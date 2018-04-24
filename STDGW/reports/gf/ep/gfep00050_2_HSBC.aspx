<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<%         
    string SQL = "";
    string v_comp_nm = "", v_comp_addr = "", v_phone_no = "";
    string p_comp_pk = Request["company_pk"];    
    string p_seq = Request["pk"];
    string[] a = p_seq.Split(',');
    string v_seq = "";
    if (a.Length > 0)
    {
        v_seq = a[0];
    }
    else
    {
        v_seq = p_seq;
    }
    
    string v_debit_account = "", v_bank_ccy = "", v_trans_ccy = "";
    string p_xls_ccy_trans = "";
    decimal v_total_trans = 0;
    SQL = "select partner_name, addr1, phone_no from comm.tco_company where pk like '" + p_comp_pk + "' ";
    DataTable dtComp = new DataTable();
    dtComp = ESysLib.TableReadOpen(SQL);
    if (dtComp.Rows.Count == 0)
    {
        Response.Write("There is no data to display");
        Response.End();
    }
    v_comp_nm = dtComp.Rows[0][0].ToString(); // Company name
    v_comp_addr = dtComp.Rows[0][1].ToString(); // Address
    v_phone_no = dtComp.Rows[0][2].ToString(); // Phone Number
    SQL
        = "select substr(b.account_no, 1, 3) || '-' || substr(b.account_no, 4, length(b.account_no) - 6) || '-' || substr(b.account_no, length(b.account_no) - 2, 3) account_no, b.ccy " +
            "from tac_abdepomt b " +
            "where b.pk = ( select t.tac_bfdepomt_pk from tfn_eppaytr t where t.pk like '" + v_seq + "' " +
            "and t.del_if = 0 ) ";
    DataTable dtBank = new DataTable();
    dtBank = ESysLib.TableReadOpen(SQL);
    if (dtBank.Rows.Count == 0)
    {
        Response.Write("There is no data to display dtBank");
        Response.End();
    }
    v_debit_account = dtBank.Rows[0][0].ToString();
    v_bank_ccy = dtBank.Rows[0][1].ToString();
    
    SQL
        = "select max(t.pay_ccy), sum(t.pay_famt) pay_famt from tfn_eppaytr t where t.pk in (" + p_seq + ") " +
            "                        and t.del_if = 0 ";
    DataTable dtTransCcy = new DataTable();
    dtTransCcy = ESysLib.TableReadOpen(SQL);
    if (dtTransCcy.Rows.Count > 0)
    {
        v_trans_ccy = dtTransCcy.Rows[0][0].ToString();    
        v_total_trans = decimal.Parse(dtTransCcy.Rows[0][1].ToString());            
    }

     SQL
        = "select '' reference_no, (select b.bedefi_nm from tac_bfbeneficiary b where b.tco_dccust_pk = t.tco_buspartner_pk and b.del_if = 0) bedefi_nm, " +
            "(select b.account_no from tac_bfbeneficiary b where b.tco_dccust_pk = t.tco_buspartner_pk and b.del_if = 0 ) account_no, " +
            "(select b.bedefi_bank_nm from tac_bfbeneficiary b where b.tco_dccust_pk = t.tco_buspartner_pk and b.del_if = 0 ) bedefi_bank_nm, " +
            "(select b.swift_code from tac_bfbeneficiary b where b.tco_dccust_pk = t.tco_buspartner_pk and b.del_if = 0 ) swift_code, " +
            "t.tr_famt, t.pay_date, t.tr_remark " +
            "from tfn_eppaytr t  " +
            "where t.pk in (" + p_seq + ") " +
            " and t.del_if = 0 ";
     DataTable dt = new DataTable();
     dt = ESysLib.TableReadOpen(SQL);
     if (dt.Rows.Count == 0)
     {
         Response.Write("There is no data to display dt");
         Response.End();
     }    
    
    if (v_trans_ccy == "VND")
    {
        p_xls_ccy_trans = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";        
    }
    else
    {
        p_xls_ccy_trans = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";        
    }
    
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Copy%20of%20HSBC-Payment%20list_files/filelist.xml">
<link rel=Edit-Time-Data
href="Copy%20of%20HSBC-Payment%20list_files/editdata.mso">
<link rel=OLE-Object-Data
href="Copy%20of%20HSBC-Payment%20list_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>van</o:LastAuthor>
  <o:LastPrinted>2011-10-17T04:08:41Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-11-01T02:24:22Z</o:LastSaved>
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
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}
.font13
	{color:red;
	font-size:8.0pt;
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
.xl65
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl67
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl68
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl70
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;}
.xl71
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl72
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl73
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl74
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl76
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;}
.xl77
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl78
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl79
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl81
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;}
.xl82
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl83
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl84
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl85
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl86
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl87
	{mso-style-parent:style0;
	mso-number-format:Standard;}
.xl88
	{mso-style-parent:style0;
	mso-number-format:"\@";}
.xl89
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	white-space:normal;}
.xl90
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;}
.xl91
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	border:.5pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl94
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl95
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border:.5pt solid windowtext;}
.xl96
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl97
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl99
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl100
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl101
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl102
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl103
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl104
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\;\[Red\]0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl105
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl106
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl107
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl108
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl109
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl110
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\;\[Red\]0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl111
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl112
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl113
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl114
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl115
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl116
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl117
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\;\[Red\]0";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl118
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl119
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl120
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl121
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl122
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl123
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl124
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl125
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl126
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl127
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl128
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl129
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl130
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl131
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl132
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl133
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl134
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl135
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl136
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl137
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl138
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl139
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl140
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
.xl141
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl142
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
.xl143
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
.xl144
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl145
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
.xl146
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl147
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl148
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl149
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
.xl150
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
.xl151
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
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>22</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9120</x:WindowHeight>
  <x:WindowWidth>12120</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=906 style='border-collapse:
 collapse;table-layout:fixed;width:681pt'>
 <col width=9 style='mso-width-source:userset;mso-width-alt:329;width:7pt'>
 <col width=24 style='mso-width-source:userset;mso-width-alt:877;width:18pt'>
 <col width=64 style='width:48pt'>
 <col width=106 style='mso-width-source:userset;mso-width-alt:3876;width:80pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=182 style='mso-width-source:userset;mso-width-alt:6656;width:137pt'>
 <col width=86 style='mso-width-source:userset;mso-width-alt:3145;width:65pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:3657;width:75pt'>
 <col width=91 span=2 style='mso-width-source:userset;mso-width-alt:3328;
 width:68pt'>
 <col width=64 style='width:48pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl65 width=9 style='height:12.75pt;width:7pt'></td>
  <td class=xl66 width=24 style='width:18pt'></td>
  <td class=xl65 width=64 style='width:48pt'></td>
  <td class=xl65 width=106 style='width:80pt'></td>
  <td class=xl67 width=89 style='width:67pt'></td>
  <td class=xl68 width=182 style='width:137pt'></td>
  <td class=xl69 width=86 style='width:65pt'></td>
  <td class=xl70 width=100 style='width:75pt'></td>
  <td class=xl69 width=91 style='width:68pt'></td>
  <td class=xl65 width=91 style='width:68pt'></td>
  <td class=xl65 width=64 style='width:48pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl71 style='height:12.75pt'></td>
  <td class=xl72 colspan=8 style='mso-ignore:colspan'>Transfer using Internet
  Banking and enjoy preferential remittance fees. For more information, please
  visit www.hsbc.com.vn</td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl71 style='height:12.75pt'></td>
  <td class=xl72></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td class=xl75></td>
  <td class=xl76></td>
  <td class=xl75></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl71 style='height:12.75pt'></td>
  <td class=xl72 colspan=5 style='mso-ignore:colspan'>Subject to the enclosed
  terms and conditions, please issue following transfers:</td>
  <td class=xl75></td>
  <td class=xl76></td>
  <td class=xl75></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl77 style='height:12.75pt'></td>
  <td class=xl72></td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
  <td class=xl78></td>
  <td class=xl79></td>
  <td class=xl80></td>
  <td class=xl81></td>
  <td class=xl80></td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl82 style='height:12.75pt'></td>
  <td class=xl83 colspan=4 style='mso-ignore:colspan'
  x:str="Name of Remitter (in BLOCK LETTERS): ">Name of Remitter (in BLOCK
  LETTERS):<span style='mso-spacerun:yes'> </span></td>
  <td class=xl85></td>
  <td class=xl83>Address:</td>
  <td class=xl86></td>
  <td colspan=2 class=xl82 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl77 style='height:12.75pt'></td>
  <td class=xl83></td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
  <td class=xl78></td>
  <td class=xl87></td>
  <td class=xl81></td>
  <td class=xl80></td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl77 style='height:12.75pt'></td>
  <td colspan=4 rowspan=2 class=xl139 width=283 style='width:213pt'><%=v_comp_nm %></td>
  <td class=xl87></td>
  <td colspan=4 rowspan=2 class=xl140 width=368 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:276pt'><%=v_comp_addr %></td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl77 style='height:12.75pt'></td>
  <td class=xl87></td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=4 class=xl77 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl78></td>
  <td class=xl87></td>
  <td class=xl88></td>
  <td class=xl81></td>
  <td class=xl80></td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl77 style='height:12.75pt'></td>
  <td class=xl83 colspan=3 style='mso-ignore:colspan'>Telephone number.:</td>
  <td class=xl78></td>
  <td class=xl79></td>
  <td class=xl80></td>
  <td class=xl87></td>
  <td class=xl88></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl77 style='height:12.75pt'></td>
  <td class=xl83></td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
  <td class=xl78></td>
  <td class=xl79></td>
  <td class=xl80></td>
  <td class=xl87></td>
  <td class=xl88></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl77 style='height:12.75pt'></td>
  <td colspan=4 class=xl146 width=283 style='border-right:.5pt solid black;
  width:213pt'><%=v_phone_no%></td>
  <td class=xl78></td>
  <td class=xl89></td>
  <td class=xl87></td>
  <td class=xl88></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl77 style='height:12.75pt'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
  <td class=xl77></td>
  <td class=xl78></td>
  <td class=xl79></td>
  <td class=xl80></td>
  <td class=xl90></td>
  <td class=xl86></td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl77 style='height:12.75pt'></td>
  <td class=xl83 colspan=4 style='mso-ignore:colspan'>For payment please debit
  my/our account:</td>
  <td class=xl79></td>
  <td class=xl72 colspan=2 style='mso-ignore:colspan'>Debit Account Currency:</td>
  <td class=xl88></td>
  <td class=xl86 colspan=2 style='mso-ignore:colspan'>Transaction Currency:</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl77 style='height:12.75pt'></td>
  <td class=xl83></td>
  <td class=xl81></td>
  <td class=xl77></td>
  <td class=xl80></td>
  <td class=xl79></td>
  <td class=xl80></td>
  <td class=xl90></td>
  <td class=xl88></td>
  <td class=xl86></td>
  <td class=xl77></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl77 style='height:12.75pt'></td>
  <td colspan=3 class=xl149 width=194 style='border-right:.5pt solid black;
  width:146pt'><%=v_debit_account%></td>
  <td class=xl80></td>
  <td class=xl79></td>
  <td class=xl91><%=v_bank_ccy%></td>
  <td class=xl90></td>
  <td class=xl88></td>
  <td class=xl92><%=v_trans_ccy%></td>
  <td class=xl93></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl77 style='height:12.75pt'></td>
  <td class=xl80></td>
  <td class=xl87></td>
  <td class=xl88></td>
  <td class=xl80></td>
  <td class=xl87></td>
  <td class=xl88></td>
  <td class=xl90></td>
  <td class=xl88></td>
  <td class=xl94></td>
  <td class=xl93></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl77 style='height:12.75pt'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
  <td class=xl77></td>
  <td class=xl80></td>
  <td class=xl87></td>
  <td class=xl88></td>
  <td class=xl90></td>
  <td class=xl86></td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=4 class=xl77 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl78></td>
  <td class=xl79></td>
  <td class=xl95>TOTAL</td>
  <td class=xl96 align=right style="border-left:none; mso-number-format:'<%=p_xls_ccy_trans %>';" x:num
  ><%=v_total_trans %></td>
  <td class=xl80></td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl101 height=42 style='height:31.5pt'>
  <td height=42 class=xl71 style='height:31.5pt'></td>
  <td class=xl97>&nbsp;</td>
  <td class=xl98 width=64 style='border-left:none;width:48pt'>Reference No.</td>
  <td class=xl98 width=106 style='border-left:none;width:80pt'>Beneficiary Name</td>
  <td class=xl98 width=89 style='border-left:none;width:67pt'>Beneficiary's
  Account</td>
  <td class=xl98 width=182 style='border-left:none;width:137pt'>Beneficiary's
  Bank Name (in Vietnam only)</td>
  <td class=xl99 width=86 style='border-top:none;border-left:none;width:65pt'>Bank
  Code (SWIFT/LCC)</td>
  <td class=xl100 width=100 style='border-top:none;border-left:none;width:75pt'>Transfer
  Amount</td>
  <td class=xl99 width=91 style='border-left:none;width:68pt'>Value Date
  (YYYYMMDD)</td>
  <td class=xl98 width=91 style='border-left:none;width:68pt'>Narrative</td>
  <td class=xl98 width=64 style='border-left:none;width:48pt'>Charge
  (SHA/BEN/OUR)</td>
 </tr>
 <% 
     int i;
     for (i = 0; i < dt.Rows.Count; i++)
     {     
 %>
 <tr height=45 style='height:33.75pt'>
  <td height=45 class=xl71 style='height:33.75pt'></td>
  <td class=xl102 style='border-top:none' x:num><%=i + 1 %></td>
  <td class=xl103 width=64 style='border-top:none;border-left:none;width:48pt'><%=dt.Rows[i][0].ToString() %></td>
  <td class=xl104 width=106 style='border-top:none;border-left:none;width:80pt'><%=dt.Rows[i][1].ToString()%></td>
  <td class=xl105 width=89 style='border-top:none;border-left:none;width:67pt'><%=dt.Rows[i][2].ToString()%></td>
  <td class=xl105 width=182 style='border-top:none;border-left:none;width:137pt'><%=dt.Rows[i][3].ToString()%></td>
  <td class=xl106 width=86 style='border-top:none;border-left:none;width:65pt'
  x:str><%=dt.Rows[i][4].ToString()%></td> <!-- Swift Code -->
  <td class=xl107 width=100 style="border-top:none;border-left:none;width:75pt; mso-number-format:'<%=p_xls_ccy_trans %>';"
  x:num><%=dt.Rows[i][5].ToString()%></td>
  <td class=xl106 width=91 style='border-top:none;border-left:none;width:68pt'
  x:str><%=dt.Rows[i][6].ToString()%></td>
  <td class=xl103 width=91 style='border-top:none;border-left:none;width:68pt'><%=dt.Rows[i][7].ToString() %></td>
  <td class=xl103 width=64 style='border-top:none;border-left:none;width:48pt'></td>
 </tr>
 <% 
     }
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl71 style='height:12.75pt'></td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl109 width=64 style='border-top:none;border-left:none;width:48pt'>&nbsp;</td>
  <td class=xl110 width=106 style='border-top:none;border-left:none;width:80pt'>&nbsp;</td>
  <td class=xl111 width=89 style='border-top:none;border-left:none;width:67pt'>&nbsp;</td>
  <td class=xl111 width=182 style='border-top:none;border-left:none;width:137pt'>&nbsp;</td>
  <td class=xl112 width=86 style='border-top:none;border-left:none;width:65pt'>&nbsp;</td>
  <td class=xl113 width=100 style='border-top:none;border-left:none;width:75pt'>&nbsp;</td>
  <td class=xl112 width=91 style='border-top:none;border-left:none;width:68pt'>&nbsp;</td>
  <td class=xl109 width=91 style='border-top:none;border-left:none;width:68pt'>&nbsp;</td>
  <td class=xl109 width=64 style='border-top:none;border-left:none;width:48pt'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl71 style='height:12.75pt'></td>
  <td class=xl108>&nbsp;</td>
  <td class=xl109 width=64 style='border-left:none;width:48pt'>&nbsp;</td>
  <td class=xl110 width=106 style='border-left:none;width:80pt'>&nbsp;</td>
  <td class=xl111 width=89 style='border-left:none;width:67pt'>&nbsp;</td>
  <td class=xl111 width=182 style='border-left:none;width:137pt'>&nbsp;</td>
  <td class=xl112 width=86 style='border-left:none;width:65pt'>&nbsp;</td>
  <td class=xl113 width=100 style='border-left:none;width:75pt'>&nbsp;</td>
  <td class=xl112 width=91 style='border-left:none;width:68pt'>&nbsp;</td>
  <td class=xl109 width=91 style='border-left:none;width:68pt'>&nbsp;</td>
  <td class=xl109 width=64 style='border-left:none;width:48pt'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl71 style='height:12.75pt'></td>
  <td class=xl108>&nbsp;</td>
  <td class=xl109 width=64 style='border-left:none;width:48pt'>&nbsp;</td>
  <td class=xl110 width=106 style='border-left:none;width:80pt'>&nbsp;</td>
  <td class=xl111 width=89 style='border-left:none;width:67pt'>&nbsp;</td>
  <td class=xl111 width=182 style='border-left:none;width:137pt'>&nbsp;</td>
  <td class=xl112 width=86 style='border-left:none;width:65pt'>&nbsp;</td>
  <td class=xl113 width=100 style='border-left:none;width:75pt'>&nbsp;</td>
  <td class=xl112 width=91 style='border-left:none;width:68pt'>&nbsp;</td>
  <td class=xl109 width=91 style='border-left:none;width:68pt'>&nbsp;</td>
  <td class=xl109 width=64 style='border-left:none;width:48pt'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl71 style='height:12.75pt'></td>
  <td class=xl102>&nbsp;</td>
  <td class=xl103 width=64 style='border-left:none;width:48pt'>&nbsp;</td>
  <td class=xl104 width=106 style='border-left:none;width:80pt'>&nbsp;</td>
  <td class=xl105 width=89 style='border-left:none;width:67pt'>&nbsp;</td>
  <td class=xl105 width=182 style='border-left:none;width:137pt'>&nbsp;</td>
  <td class=xl106 width=86 style='border-left:none;width:65pt'>&nbsp;</td>
  <td class=xl114 width=100 style='border-left:none;width:75pt'>&nbsp;</td>
  <td class=xl106 width=91 style='border-left:none;width:68pt'>&nbsp;</td>
  <td class=xl103 width=91 style='border-left:none;width:68pt'>&nbsp;</td>
  <td class=xl103 width=64 style='border-left:none;width:48pt'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl71 style='height:12.75pt'></td>
  <td class=xl115>&nbsp;</td>
  <td class=xl116>&nbsp;</td>
  <td class=xl117>&nbsp;</td>
  <td colspan=2 class=xl118 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl119>&nbsp;</td>
  <td class=xl120>&nbsp;</td>
  <td class=xl119>&nbsp;</td>
  <td colspan=2 class=xl116 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl77 style='height:12.75pt'></td>
  <td colspan=6 rowspan=10 class=xl121 width=551 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:415pt'>I/ We hereby confirm that I/ We
  have read, understood and fully agreed to be bound by the standard Terms and
  Conditions (including all amendments thereto from time to time) applicable to
  Telegraphic Transfers/Demand Drafts, which is available on HSBC website at <font
  class="font13">http://www.hsbc.com.vn/1/2/miscellaneous/con_tele_transfers</font></td>
  <td colspan=4 rowspan=10 class=xl130 width=346 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:259pt'>Remitter/Applicant's Signature(s)
  and Stamp</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl77 style='height:12.75pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl77 style='height:12.75pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl77 style='height:12.75pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl77 style='height:12.75pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl77 style='height:12.75pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl77 style='height:12.75pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl77 style='height:12.75pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl77 style='height:12.75pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl77 style='height:12.75pt'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=9 style='width:7pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=182 style='width:137pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
