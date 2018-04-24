<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<%  ESysLib.SetUser("duol");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
    
    string p_Master_Pk = Request.QueryString["Master_Pk"];
    string p_Ccy = Request.QueryString["Ccy"];

    string SQL = "select B.PROJECTCODE, A.REQUEST_DT , A.TCO_BUSPARTNER_PK, A.TECPS_PROJECTSUMM_PK, C.PARTNER_NAME, to_char(to_date(A.REQUEST_DT, 'YYYYMMDD'), 'DD MON YYYY') REQUEST_DT, " +
        "nvl(A.REQUEST_TIMES,0), F.PARTNER_NAME, f.ADDR1, D.SWIST_CODE, D.ACCOUNT_NO, E.ACCOUNT_NO, d.ccy, e.ccy " +
        "FROM TECPS_MCTREQUEST a, TECPS_PROJECTSUMM b, TCO_BUSPARTNER c, TAC_ABDEPOMT d, TAC_ABDEPOMT e, TCO_BUSPARTNER f " +
        " WHERE     a.del_if = 0    " +
        "       AND b.del_if = 0    " +
        "       and c.del_if(+) = 0   " +
        "       and d.del_if(+) = 0 " +
        "       and e.del_if(+) = 0 " +
        "       and f.del_if(+) = 0 " +
        "       AND A.tecps_projectsumm_pk = b.pk    " +
        "       and A.TCO_BUSPARTNER_PK = c.pk(+) " +
        "       and A.TAC_ABDEPOMT1_PK = d.pk(+) " +
        "       and A.TAC_ABDEPOMT2_PK = e.pk(+) " +
        "       and D.TCO_BUSPARTNER_PK = f.pk(+) " +
        "       and a.pk = '"+p_Master_Pk+"' ";

    
    string p_Project_Cd = "";
    string p_REQUESTDATE = "";
    string p_TCO_BUSPARTNER_PK = "";
    string p_Project_Pk = "";
    string p_Partner_Nm = "";
    string p_Date = "";
    string p_Date1="";
    string p_MonthYear="";
    string p_Num = "";
    decimal p_Req_Times = 0;
    string p_Bank_Nm = "";
    string p_Bank_Add = "";
    string p_Swift = "";
    string p_Acc_No1 = "";
    string p_Acc_No2 = "";
    string p_Ccy1 = "";
    string p_Ccy2 = "";

    DataTable dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count > 0)
    {
        p_Project_Cd = dt.Rows[0][0].ToString();
        p_REQUESTDATE = dt.Rows[0][1].ToString();
        p_TCO_BUSPARTNER_PK = dt.Rows[0][2].ToString();
        p_Project_Pk = dt.Rows[0][3].ToString();
        p_Partner_Nm = dt.Rows[0][4].ToString();
        p_Date = dt.Rows[0][5].ToString();
        p_Req_Times = decimal.Parse(dt.Rows[0][6].ToString());
        p_Bank_Nm = dt.Rows[0][7].ToString();
        p_Bank_Add = dt.Rows[0][8].ToString();
        p_Swift = dt.Rows[0][9].ToString();
        p_Acc_No1 = dt.Rows[0][10].ToString();
        p_Acc_No2 = dt.Rows[0][11].ToString();
        p_Ccy1 = dt.Rows[0][12].ToString();
        p_Ccy2 = dt.Rows[0][13].ToString();

        p_Date1 = p_Date.Substring(0, 2);
        p_MonthYear = p_Date.Substring(3, 8);

        if (p_Date1=="01")
        {
            p_Num = "st";
        }
        else if (p_Date1=="02")
        {
            p_Num = "nd";
        }
        else if (p_Date1 == "03")
        {
            p_Num = "rd";
        }
        else if (decimal.Parse(p_Date1) > 03 && decimal.Parse(p_Date1) < 21)
        {
            p_Num = "th";
        }
        else if (p_Date1 == "21")
        {
            p_Num = "st";
        }
        else if (p_Date1 == "22")
        {
            p_Num = "nd";
        }
        else if (p_Date1 == "23")
        {
            p_Num = "rd";
        }
        else if (decimal.Parse(p_Date1) > 23 && decimal.Parse(p_Date1) < 31)
        {
            p_Num = "th";
        }
        else
        {
            p_Num = "st";
        }
    }
    else
    {
        Response.Write("There is not data !!");
        Response.End();
    }
    
    string l_parameter = "";
    l_parameter = "'" + p_Project_Pk + "',";
    l_parameter += "'" + p_Master_Pk + "',";
    l_parameter += "'" + p_TCO_BUSPARTNER_PK + "'";

    decimal Net_Amt = 0;
    decimal VAT_Amt = 0;
    decimal TotalWorkdone_Amt = 0;
    decimal AdvPay_Amt = 0;
    decimal Retention_Amt = 0;
    //decimal Deducting_Amt = 0;
    decimal Deduct_AdvPay_Amt = 0;
    decimal Deduct_Retention = 0;
    decimal TotalDeducting_Amt = 0;
    decimal ThisPay_Amt = 0;

    decimal Pre_Net_Amt = 0;
    decimal Pre_VAT_Amt = 0;
    decimal Pre_TotalWorkdone_Amt = 0;
    decimal Pre_AdvPay_Amt = 0;
    decimal Pre_Retention_Amt = 0;
    decimal Pre_Deduct_AdvPay_Amt = 0;
    decimal Pre_Deduct_Retention = 0;
    decimal Pre_TotalDeducting_Amt = 0;
    decimal Pre_ThisPay_Amt = 0;

    decimal This_Net_Amt = 0;
    decimal This_VAT_Amt = 0;
    decimal This_TotalWorkdone_Amt = 0;
    decimal This_AdvPay_Amt = 0;
    decimal This_Retention_Amt = 0;
    decimal This_Deduct_AdvPay_Amt = 0;
    decimal This_Deduct_Retention = 0;
    decimal This_TotalDeducting_Amt = 0;
    decimal This_ThisPay_Amt = 0;

    decimal Accum_Net_Amt = 0;
    decimal Accum_VAT_Amt = 0;
    decimal Accum_TotalWorkdone_Amt = 0;
    decimal Accum_AdvPay_Amt = 0;
    decimal Accum_Retention_Amt = 0;
    decimal Accum_Deduct_AdvPay_Amt = 0;
    decimal Accum_Deduct_Retention = 0;
    decimal Accum_TotalDeducting_Amt = 0;
    decimal Accum_ThisPay_Amt = 0;

    decimal Bal_Net_Amt = 0;
    decimal Bal_VAT_Amt = 0;
    decimal Bal_TotalWorkdone_Amt = 0;
    decimal Bal_AdvPay_Amt = 0;
    decimal Bal_Retention_Amt = 0;
    decimal Bal_Deduct_AdvPay_Amt = 0;
    decimal Bal_Deduct_Retention = 0;
    decimal Bal_TotalDeducting_Amt = 0;
    decimal Bal_ThisPay_Amt = 0;
    
    string Remark = "";
    string VAT_Rate = "";
    string ReadNum = "";
    DataTable dt_Detail = ESysLib.TableReadOpenCursor("rpt_sel_kpbp128_1", l_parameter);
    if (dt_Detail.Rows.Count > 0)
    {
        // Net_Amt = dt_Detail.Rows[0]["l_net_amt"].ToString();
		 //-------Doc so thanh chu------------------
          ReadNum = CommondLib.Num2EngText(dt_Detail.Rows[0]["PAYMENT_IAMT"].ToString(), p_Ccy);
          string SQL3 = " SELECT upper(substr(trim('" + ReadNum + "'),1,1)) || substr(lower(trim('" + ReadNum + "')),2, length(trim('" + ReadNum + "')))  from dual ";
          DataTable dt_t = ESysLib.TableReadOpen(SQL3);

          if (dt_t.Rows.Count > 0)
          {
              ReadNum = dt_t.Rows[0][0].ToString();

          }
   %>
 
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="AR_request_files/filelist.xml">
<link rel=Edit-Time-Data href="AR_request_files/editdata.mso">
<link rel=OLE-Object-Data href="AR_request_files/oledata.mso">
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
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2011-08-06T06:39:29Z</o:LastPrinted>
  <o:Created>2011-08-05T01:53:19Z</o:Created>
  <o:LastSaved>2011-08-06T06:39:40Z</o:LastSaved>
  <o:Company>VNG</o:Company>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.56in .17in .75in .17in;
	mso-header-margin:.56in;
	mso-footer-margin:.3in;
	mso-horizontal-page-align:center;}
.font7
	{color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
.font8
	{color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style45
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:"Comma 2";}
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
.style57
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
	mso-style-name:"Normal 2";}
.style61
	{mso-number-format:0%;
	mso-style-name:"Percent 2";}
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
.xl68
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:1.5pt solid windowtext;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
.xl70
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:돋움;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;}
.xl72
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style57;
	color:green;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl74
	{mso-style-parent:style45;
	color:green;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl75
	{mso-style-parent:style57;
	color:blue;
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
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl76
	{mso-style-parent:style45;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl77
	{mso-style-parent:style45;
	color:#333333;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl78
	{mso-style-parent:style57;
	color:purple;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl79
	{mso-style-parent:style57;
	color:purple;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl80
	{mso-style-parent:style45;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl81
	{mso-style-parent:style57;
	color:blue;
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
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl82
	{mso-style-parent:style57;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl83
	{mso-style-parent:style57;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl84
	{mso-style-parent:style45;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl85
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
.xl86
	{mso-style-parent:style45;
	color:purple;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl87
	{mso-style-parent:style57;
	color:#333399;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl88
	{mso-style-parent:style57;
	color:#333399;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl89
	{mso-style-parent:style45;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl90
	{mso-style-parent:style57;
	color:#333399;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl91
	{mso-style-parent:style57;
	color:#333399;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl92
	{mso-style-parent:style45;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl93
	{mso-style-parent:style45;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl94
	{mso-style-parent:style57;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl95
	{mso-style-parent:style57;
	color:#993300;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	padding-left:24px;
	mso-char-indent-count:2;}
.xl96
	{mso-style-parent:style57;
	color:#993300;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	padding-left:24px;
	mso-char-indent-count:2;}
.xl97
	{mso-style-parent:style61;
	color:#993300;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl98
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl99
	{mso-style-parent:style45;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl100
	{mso-style-parent:style45;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl101
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl102
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl103
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl104
	{mso-style-parent:style57;
	color:green;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl105
	{mso-style-parent:style57;
	color:green;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl106
	{mso-style-parent:style57;
	color:green;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl107
	{mso-style-parent:style57;
	color:green;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl108
	{mso-style-parent:style45;
	color:green;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl109
	{mso-style-parent:style45;
	color:green;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl110
	{mso-style-parent:style45;
	color:green;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl111
	{mso-style-parent:style45;
	color:green;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl112
	{mso-style-parent:style45;
	color:green;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl113
	{mso-style-parent:style57;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl114
	{mso-style-parent:style57;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl115
	{mso-style-parent:style45;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl116
	{mso-style-parent:style57;
	color:teal;
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
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl117
	{mso-style-parent:style57;
	color:teal;
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
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl118
	{mso-style-parent:style57;
	color:#333333;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl119
	{mso-style-parent:style57;
	color:#333333;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl120
	{mso-style-parent:style45;
	color:#333333;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl121
	{mso-style-parent:style45;
	color:#333333;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl122
	{mso-style-parent:style45;
	color:#333333;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl123
	{mso-style-parent:style45;
	color:purple;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl124
	{mso-style-parent:style45;
	color:purple;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl125
	{mso-style-parent:style45;
	color:purple;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl126
	{mso-style-parent:style45;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl127
	{mso-style-parent:style45;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl128
	{mso-style-parent:style45;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl129
	{mso-style-parent:style45;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl130
	{mso-style-parent:style45;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl131
	{mso-style-parent:style45;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl132
	{mso-style-parent:style57;
	color:#003366;
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
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl133
	{mso-style-parent:style57;
	color:#003366;
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
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl134
	{mso-style-parent:style45;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl135
	{mso-style-parent:style45;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl136
	{mso-style-parent:style45;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl137
	{mso-style-parent:style57;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-\[$VND\]\\ * \#\,\#\#0\.00_-\;\\-\[$VND\]\\ * \#\,\#\#0\.00_-\;_-\[$VND\]\\ * \0022-\0022??_-\;_-\@_-";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl138
	{mso-style-parent:style57;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-\[$VND\]\\ * \#\,\#\#0\.00_-\;\\-\[$VND\]\\ * \#\,\#\#0\.00_-\;_-\[$VND\]\\ * \0022-\0022??_-\;_-\@_-";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl139
	{mso-style-parent:style45;
	color:purple;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl140
	{mso-style-parent:style45;
	color:purple;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl141
	{mso-style-parent:style45;
	color:purple;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl142
	{mso-style-parent:style45;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl143
	{mso-style-parent:style45;
	color:#339966;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-\[$VND\]\\ * \#\,\#\#0\.00_-\;\\-\[$VND\]\\ * \#\,\#\#0\.00_-\;_-\[$VND\]\\ * \0022-\0022??_-\;_-\@_-";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl144
	{mso-style-parent:style45;
	color:#339966;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-\[$VND\]\\ * \#\,\#\#0\.00_-\;\\-\[$VND\]\\ * \#\,\#\#0\.00_-\;_-\[$VND\]\\ * \0022-\0022??_-\;_-\@_-";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl145
	{mso-style-parent:style45;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl146
	{mso-style-parent:style45;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl147
	{mso-style-parent:style45;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl148
	{mso-style-parent:style45;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl149
	{mso-style-parent:style45;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl150
	{mso-style-parent:style45;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl151
	{mso-style-parent:style45;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl152
	{mso-style-parent:style45;
	color:#339966;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl153
	{mso-style-parent:style45;
	color:#339966;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl154
	{mso-style-parent:style57;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl155
	{mso-style-parent:style57;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl156
	{mso-style-parent:style45;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl157
	{mso-style-parent:style57;
	color:black;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl158
	{mso-style-parent:style57;
	color:black;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl159
	{mso-style-parent:style57;
	color:black;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl160
	{mso-style-parent:style45;
	color:#993300;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl161
	{mso-style-parent:style45;
	color:#993300;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl162
	{mso-style-parent:style45;
	color:#993300;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl163
	{mso-style-parent:style45;
	color:#993300;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CC00;
	mso-pattern:auto none;
	white-space:normal;}
.xl164
	{mso-style-parent:style45;
	color:#993300;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CC00;
	mso-pattern:auto none;
	white-space:normal;}
.xl165
	{mso-style-parent:style45;
	color:#993300;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl166
	{mso-style-parent:style45;
	color:#993300;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>AR REQUEST FORM</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>25</x:ActiveRow>
       <x:ActiveCol>15</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8130</x:WindowHeight>
  <x:WindowWidth>18975</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=846 style='border-collapse:
 collapse;table-layout:fixed;width:637pt'>
 <col width=37 style='mso-width-source:userset;mso-width-alt:1353;width:28pt'>
 <col width=64 style='width:48pt'>
 <col width=77 style='mso-width-source:userset;mso-width-alt:2816;width:58pt'>
 <col width=51 style='mso-width-source:userset;mso-width-alt:1865;width:38pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=37 style='mso-width-source:userset;mso-width-alt:1353;width:28pt'>
 <col width=33 style='mso-width-source:userset;mso-width-alt:1206;width:25pt'>
 <col width=42 style='mso-width-source:userset;mso-width-alt:1536;width:32pt'>
 <col width=51 style='mso-width-source:userset;mso-width-alt:1865;width:38pt'>
 <col width=57 style='mso-width-source:userset;mso-width-alt:2084;width:43pt'>
 <col width=56 style='mso-width-source:userset;mso-width-alt:2048;width:42pt'>
 <col width=49 style='mso-width-source:userset;mso-width-alt:1792;width:37pt'>
 <col width=53 span=2 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col width=114 style='mso-width-source:userset;mso-width-alt:4169;width:86pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 width=37 style='height:12.75pt;width:28pt' align=left
  valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75" coordsize="21600,21600"
   o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe" filled="f"
   stroked="f">
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
  </v:shapetype><v:shape id="Picture_x0020_7" o:spid="_x0000_s1025" type="#_x0000_t75"
   alt="letterhead 3" style='position:absolute;margin-left:14.25pt;
   margin-top:6pt;width:534pt;height:88.5pt;z-index:1;visibility:visible'>
   <v:imagedata src="AR_request_files/image001.png" o:title="letterhead 3"/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:19px;margin-top:8px;width:712px;
  height:118px'><img width=712 height=118 src="AR_request_files/image002.gif"
  alt="letterhead 3" v:shapes="Picture_x0020_7"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 width=37 style='height:12.75pt;width:28pt'></td>
   </tr>
  </table>
  </span></td>
  <td width=64 style='width:48pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=114 style='width:86pt'></td>
 </tr>
 <tr height=102 style='height:76.5pt;mso-xlrowspan:6'>
  <td height=102 colspan=15 style='height:76.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl68 style='height:13.5pt'>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 style='height:21.75pt'></td>
  <td class=xl69 colspan=2 style='mso-ignore:colspan'><%=p_Date1 %><font class="font7"><sup><%=p_Num %></sup></font><font class="font8"> <%=p_MonthYear %></font></td>
  <td colspan=8 class=xl69 style='mso-ignore:colspan'></td>
  <td class=xl69>Ref:</td>
  <td class=xl69 colspan=2 style='mso-ignore:colspan'><%=p_Project_Cd%></td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl70 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl70 style='height:20.1pt'></td>
  <td class=xl70>To</td>
  <td class=xl71>: <%=p_Partner_Nm%></td>
  <td colspan=12 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl70 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl70 style='height:20.1pt'></td>
  <td class=xl70>Attn</td>
  <td class=xl70 x:str=": ">:</td>
  <td colspan=12 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl70 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl70 style='height:20.1pt'></td>
  <td class=xl70>Subject</td>
  <td class=xl70 x:str=": ">:</td>
  <td colspan=12 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl70 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=15 class=xl70 style='height:20.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl70 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl70 style='height:20.1pt'></td>
  <td class=xl70>Dear Mr.</td>
  <td colspan=13 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl70 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl70 style='height:20.1pt'></td>
  <td class=xl70 colspan=14 style='mso-ignore:colspan' >We would like to request payment <%=Remark%></td>
 </tr>
 <tr class=xl70 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl70 style='height:20.1pt'></td>
  <td class=xl70 colspan=7 style='mso-ignore:colspan'>according to attached work done reports and as below:</td>
  <td colspan=7 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl72 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=15 class=xl72 style='height:20.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=15 height=26 class=xl101 style='border-right:.5pt solid black; height:20.1pt' x:str="INTERIM PAYMENT ">INTERIM PAYMENT</td>
 </tr>
 <tr height=46 style='mso-height-source:userset;height:34.5pt'>
  <td height=46 class=xl73 width=37 style='height:34.5pt;border-top:none;  width:28pt' x:str="No. ">No.</td>
  <td colspan=2 class=xl104 width=141 style='border-right:.5pt solid black;  border-left:none;width:106pt'>Description</td>
  <td colspan=2 class=xl106 width=123 style='border-right:.5pt solid black;  border-left:none;width:92pt'>Value Workdone Status</td>
  <td colspan=3 class=xl108 width=112 style='border-right:.5pt solid black;  border-left:none;width:85pt' x:str="Previous Payment">Previous Payment</td>
  <td colspan=2 class=xl111 width=108 style='border-right:.5pt solid black;  border-left:none;width:81pt'>This Month</td>
  <td colspan=2 class=xl74 width=105 style='border-left:none;width:79pt'>Accumulative Amount</td>
  <td colspan=2 class=xl74 width=106 style='border-left:none;width:80pt'>Balance Amount</td>
  <td class=xl74 width=114 style='border-top:none;border-left:none;width:86pt'>Remarks</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl75 width=37 style='height:20.1pt;width:28pt' x:num>1</td>
  <td colspan=2 class=xl113 width=141 style='border-right:.5pt solid black; border-left:none;width:106pt'>Net Amount</td>
  <td colspan=2 class=xl99 width=123 style='border-right:.5pt solid black; border-left:none;width:92pt' x:num><%=dt_Detail.Rows[0]["mc_amt"].ToString()%></td>
  <td colspan=3 class=xl115 width=112 style='border-left:none;width:85pt'  x:num><%=dt_Detail.Rows[0]["pre_net_famt"].ToString()%></td>
  <td colspan=2 class=xl99 width=108 style='border-right:.5pt solid black;  border-left:none;width:81pt' x:num><%=dt_Detail.Rows[0]["this_net_amt"].ToString()%></td>
  <td colspan=2 class=xl99 width=105 style='border-right:.5pt solid black;  border-left:none;width:79pt' x:num  x:fmla="=F21+I21" ></td>
  <td colspan=2 class=xl99 width=106 style='border-right:.5pt solid black;  border-left:none;width:80pt' x:num  x:fmla="=D21-K21" ><%=Bal_Net_Amt%></td>
  <td class=xl76 width=114 style='border-top:none;border-left:none;width:86pt'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td rowspan=2 height=52 class=xl116 width=37 style='border-bottom:.5pt solid black;  height:40.2pt;width:28pt'>&nbsp;</td>
  <td colspan=2 class=xl118 width=141 style='border-right:.5pt solid black;  border-left:none;width:106pt'>VAT (<%=dt_Detail.Rows[0]["vat_rate"].ToString()%>%)</td>
  <td colspan=2 class=xl120 width=123 style='border-right:.5pt solid black;  border-left:none;width:92pt' x:num><%=dt_Detail.Rows[0]["mc_vat_amt"].ToString()%></td>
  <td colspan=3 class=xl122 width=112 style='border-left:none;width:85pt' x:num><%=dt_Detail.Rows[0]["pre_vat_amt"].ToString()%></td>
  <td colspan=2 class=xl120 width=108 style='border-right:.5pt solid black;  border-left:none;width:81pt' x:num><%=dt_Detail.Rows[0]["this_vat_amt"].ToString()%></td>
  <td colspan=2 class=xl120 width=105 style='border-right:.5pt solid black;  border-left:none;width:79pt' x:num x:fmla="=F22+I22"></td>
  <td colspan=2 class=xl120 width=106 style='border-right:.5pt solid black;  border-left:none;width:80pt' x:num x:fmla="=D22-K22"></td>
  <td class=xl77 width=114 style='border-left:none;width:86pt'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl78 style='height:20.1pt;border-top:none;border-left:  none'>Total Workdone</td>
  <td class=xl79 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl123 width=123 style='border-right:.5pt solid black;  width:92pt' x:num x:fmla="=SUM(D21:E22)"></td>
  <td colspan=3 class=xl125 width=112 style='border-left:none;width:85pt'  x:num x:fmla="=F21+F22"> 1</td>
  <td colspan=2 class=xl123 width=108 style='border-right:.5pt solid black;  border-left:none;width:81pt' x:num x:fmla="=I21+I22"></td>
  <td colspan=2 class=xl123 width=105 style='border-right:.5pt solid black;  border-left:none;width:79pt' x:num x:fmla="=K21+K22"></td>
  <td colspan=2 class=xl123 width=106 style='border-right:.5pt solid black;  border-left:none;width:80pt' x:num x:fmla="=D23-K23" ></td>
  <td class=xl80 width=114 style='border-top:none;border-left:none;width:86pt'></td>
 </tr>
 <tr class=xl85 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl81 width=37 style='height:20.1pt;width:28pt' x:num>2</td>
  <td class=xl82 style='border-top:none' >Advance (<%=dt_Detail.Rows[0]["adv_rate"].ToString()%>%)</td>
  <td class=xl83 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl129 width=123 style='border-right:.5pt solid black;  width:92pt' x:num ><%=dt_Detail.Rows[0]["advance_amt"].ToString()%></td>
  <td colspan=3 class=xl129 width=112 style='border-right:.5pt solid black;  border-left:none;width:85pt' x:num><%=dt_Detail.Rows[0]["pre_adv_amt"].ToString()%></td>
  <td colspan=2 class=xl129 width=108 style='border-right:.5pt solid black;  border-left:none;width:81pt' x:num>0</td>
  <td colspan=2 class=xl129 width=105 style='border-right:.5pt solid black;  border-left:none;width:79pt' x:num x:fmla="=F24+I24"></td>
  <td colspan=2 class=xl126 width=106 style='border-right:.5pt solid black;  border-left:none;width:80pt' x:num x:fmla="=D24-K24"></td>
  <td class=xl84 width=114 style='border-top:none;border-left:none;width:86pt'></td>
 </tr>
 <tr class=xl85 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl81 width=37 style='height:20.1pt;width:28pt' x:num>3</td>
  <td class=xl82 colspan=2 style='border-top:none' >Retention(<%=dt_Detail.Rows[0]["retention_rate"].ToString()%>%)</td>
  
  <td colspan=2 class=xl126 width=123 style='border-right:.5pt solid black;  width:92pt' x:num><%=dt_Detail.Rows[0]["retention_amt"].ToString()%></td>
  <td colspan=3 class=xl126 width=112 style='border-right:.5pt solid black;  border-left:none;width:85pt' x:num><%=dt_Detail.Rows[0]["pre_retention_amt"].ToString()%></td>
  <td colspan=2 class=xl126 width=108 style='border-right:.5pt solid black;  border-left:none;width:81pt' x:num><%=dt_Detail.Rows[0]["this_retention_amt"].ToString()%></td>
  <td colspan=2 class=xl126 width=105 style='border-right:.5pt solid black;  border-left:none;width:79pt' x:num x:fmla="=F24+I24"></td>
  <td colspan=2 class=xl126 width=106 style='border-right:.5pt solid black;  border-left:none;width:80pt' x:num></td>
  <td class=xl84 width=114 style='border-top:none;border-left:none;width:86pt'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl75 width=37 style='height:20.1pt;width:28pt' x:num>4</td>
  <td class=xl82 style='border-top:none'>Deducting</td>
  <td class=xl82 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl137 style='border-right:.5pt solid black;border-left:  none'><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td colspan=3 class=xl139 width=112 style='border-right:.5pt solid black;  border-left:none;width:85pt'>&nbsp;</td>
  <td colspan=2 class=xl139 width=108 style='border-right:.5pt solid black;  border-left:none;width:81pt'>&nbsp;</td>
  <td colspan=2 class=xl142 width=105 style='border-left:none;width:79pt'>&nbsp;</td>
  <td colspan=2 class=xl143 width=106 style='border-right:.5pt solid black;  border-left:none;width:80pt'>&nbsp;</td>
  <td class=xl86 width=114 style='border-top:none;border-left:none;width:86pt'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td rowspan=3 height=92 class=xl132 width=37 style='border-bottom:.5pt solid black;  height:70.2pt;width:28pt'>&nbsp;</td>
  <td class=xl87 style='border-top:none;border-left:none'  x:str="Advance Payment ">Advance Payment</td>
  <td class=xl88 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl134 width=123 style='border-right:.5pt solid black;  width:92pt' x:num x:fmla="=D24"></td>
  <td colspan=3 class=xl136 width=112 style='border-left:none;width:85pt' x:num><%=dt_Detail.Rows[0]["pre_deduct_adv"].ToString()%></td>
  <td colspan=2 class=xl134 width=108 style='border-right:.5pt solid black;  border-left:none;width:81pt' x:num><%=dt_Detail.Rows[0]["this_adv_deduct"].ToString()%></td>
  <td colspan=2 class=xl134 width=105 style='border-right:.5pt solid black;  border-left:none;width:79pt' x:num x:fmla="=F27+I27"></td>
  <td colspan=2 class=xl134 width=106 style='border-right:.5pt solid black;  border-left:none;width:80pt' x:num x:fmla="=D27-K27"></td>
  <td class=xl89 width=114 style='border-top:none;border-left:none;width:86pt'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl90 style='height:20.1pt;border-left:none'>Retention</td>
  <td class=xl91 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl147 width=123 style='border-right:.5pt solid black;  border-left:none;width:92pt' x:num><%=dt_Detail.Rows[0]["retention_amt"].ToString()%></td>
  <td colspan=3 class=xl147 width=112 style='border-right:.5pt solid black;  border-left:none;width:85pt' x:num><%=dt_Detail.Rows[0]["pre_retention_amt"].ToString()%></td>
  <td colspan=2 class=xl147 width=108 style='border-right:.5pt solid black;  border-left:none;width:81pt' x:num><%=dt_Detail.Rows[0]["this_retention_amt"].ToString()%></td>
  <td colspan=2 class=xl150 width=105 style='border-right:.5pt solid black;  border-left:none;width:79pt' x:num x:fmla="=F28+I28"></td>
  <td colspan=2 class=xl152 width=106 style='border-right:.5pt solid black;  border-left:none;width:80pt' x:num x:fmla="=D28-K28"></td>
  <td class=xl92 width=114 style='border-top:none;border-left:none;width:86pt'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=2 height=40 class=xl154 width=141 style='border-right:.5pt solid black;  height:30.0pt;border-left:none;width:106pt'>Total Deducting Amount</td>
  <td colspan=2 class=xl145 width=123 style='border-right:.5pt solid black;  border-left:none;width:92pt' x:num x:fmla="=D27+D28"></td>
  <td colspan=3 class=xl156 width=112 style='border-left:none;width:85pt'  x:num x:fmla="=F27+F28"></td>
  <td colspan=2 class=xl145 width=108 style='border-right:.5pt solid black;  border-left:none;width:81pt' x:num x:fmla="=I27+I28"></td>
  <td colspan=2 class=xl156 width=105 style='border-left:none;width:79pt'  x:num x:fmla="=F29+I29"></td>
  <td colspan=2 class=xl145 width=106 style='border-right:.5pt solid black;  border-left:none;width:80pt' x:num x:fmla="=D29-K29"></td>
  <td class=xl93 width=114 style='border-top:none;border-left:none;width:86pt'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=15 height=26 class=xl157 width=846 style='border-right:.5pt solid black;  height:20.1pt;width:637pt'>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl94 width=37 style='height:20.1pt;border-top:none;  width:28pt'>5</td>
  <td class=xl95 style='border-top:none;border-left:none'>This Payment</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl160 width=123 style='border-right:.5pt solid black;  width:92pt' x:num x:fmla="=D23"></td>
  <td colspan=3 class=xl160 width=112 style='border-right:.5pt solid black;  border-left:none;width:85pt' x:num x:fmla="=F23+F24-F29"></td>
  <td colspan=2 class=xl163 width=108 style='border-right:.5pt solid black;  border-left:none;width:81pt' x:num x:fmla="=I23-I29"></td>
  <td colspan=2 class=xl165 style='border-right:.5pt solid black;border-left:  none' x:num x:fmla="=K23+K24+K25-K29"></td>
  <td colspan=2 class=xl165 style='border-right:.5pt solid black;border-left:  none' x:num x:fmla="=M23+M24+M25-M29"></td>
  <td class=xl97 width=114 style='border-top:none;border-left:none;width:86pt'  x:num x:fmla="=K31/D31"></td>
 </tr>

 <%
	   }

 %>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=15 style='height:20.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 style='height:20.1pt'></td>
  <td colspan=9 style='mso-ignore:colspan'>In words: <%=ReadNum %> only</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 style='height:20.1pt'></td>
  <td colspan=8 style='mso-ignore:colspan'>Please transfer the above mentioned amount to following account:</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 style='height:20.1pt'></td>
  <td colspan=2 style='mso-ignore:colspan'>Bank name</td>
  <td>:</td>
  <td colspan=6 style='mso-ignore:colspan'><%=p_Bank_Nm %></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 style='height:20.1pt'></td>
  <td colspan=2 style='mso-ignore:colspan'>Bank address</td>
  <td>:</td>
  <td colspan=11 style='mso-ignore:colspan'><%=p_Bank_Add %></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 style='height:20.1pt'></td>
  <td>Swift BIC</td>
  <td></td>
  <td>:</td>
  <td colspan=2 style='mso-ignore:colspan'><%=p_Swift %></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 style='height:20.1pt'></td>
  <td colspan=2 style='mso-ignore:colspan'>Account No.</td>
  <td>:</td>
  <td class=xl85><%=p_Acc_No1 %> <%=p_Ccy1 %></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=4 style='height:20.1pt;mso-ignore:colspan'></td>
  <td class=xl85><%=p_Acc_No2 %> <%=p_Ccy2 %></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 style='height:20.1pt'></td>
  <td colspan=2 style='mso-ignore:colspan'>Beneficiary Name</td>
  <td>:</td>
  <td colspan=8 style='mso-ignore:colspan' x:str>CTY TNHH THIẾT KẾ DUOL VINA<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=15 style='height:20.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 style='height:20.1pt'></td>
  <td colspan=4 style='mso-ignore:colspan'>We highly appreciate your kind cooperation.</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 style='height:20.1pt'></td>
  <td colspan=2 style='mso-ignore:colspan'>Sincerely yours,</td>
  <td colspan=7 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'>Confirmed by:</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='height:25.5pt;mso-xlrowspan:2'>
  <td height=34 colspan=15 style='height:25.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td class=xl98>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td colspan=7 style='mso-ignore:colspan'></td>
  <td class=xl98>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=2 style='mso-ignore:colspan'>Project manager</td>
  <td colspan=12 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=37 style='width:28pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=114 style='width:86pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
