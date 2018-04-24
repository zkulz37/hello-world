<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
    string l_company_pk = Request["company_pk"];
	string l_date_from	= Request["dtbFrom"];
	string l_date_to = Request["dtbTo"];
    string SQL = "";
    ////// company
    string l_comp_nm = "";
    
    SQL
        = "select c.partner_name from comm.tco_company c where c.pk like '" + l_company_pk + "' " +
            "and c.del_if = 0 ";
    DataTable dtComp = ESysLib.TableReadOpen(SQL);
    if (dtComp.Rows.Count > 0)
    {
        l_comp_nm = dtComp.Rows[0][0].ToString().Trim();            
    }
     SQL = 
         " select tb.* from ( " +
         "select v.style_no, v.order_no, v.qty, v.unit_price, v.tr_amt, to_char(to_date(v.on_board, 'YYYYMMDD'), 'DD/MM/YYYY') on_board, t.recv_amt, to_char(to_date(h.tr_date, 'YYYYMMDD'), 'DD/MM/YYYY') recv_date, nvl(v.tr_amt, 0) - nvl(t.recv_amt, 0) balance,  " +
            "v.decl_no, to_char(to_date(v.decl_date, 'YYYYMMDD'), 'DD/MM/YYYY') decl_date, to_char(to_date(v.date_export, 'YYYYMMDD'), 'DD/MM/YYYY') date_export, v.transport_by, v.ship_to, c.partner_name, v.co_invoice_no, v.invoice_no, v.serial_no,  " +
            " to_char(to_date(v.invoice_date, 'YYYYMMDD'), 'DD/MM/YYYY') invoice_date, style_name, v.tr_remark_ny, v.bk_rate, v.tr_famt, to_char(to_date(v.annex_date, 'YYYYMMDD'), 'DD/MM/YYYY') annex_date, v.annex_no, v.contract_no_ar, v.invoice_date invoice_date_1, v.fob_price, v.fob_amt, v.pay_method " +
            "from tac_carecv v,    " +
            "  tac_carecvtr t  " +
            " , tco_buspartner c  " +
            " , tac_carecvh h " +
            "where h.tr_date between '" + l_date_from + "' and '" + l_date_to + "'  " +
            "and v.del_if  =0  " +
            "and v.tco_company_pk like '" + l_company_pk + "'  " +
            "and v.pk = t.tac_carecv_pk  " +
            " and t.del_if = 0 " +
            "and t.tac_carecvh_pk = h.pk " +
            "and h.del_if = 0 " +
            "and h.tr_status in ('2', '0') " +
            "and v.tco_buspartner_pk = c.pk(+)  " +
            " union all " +
       " select v.style_no, v.order_no, v.qty, v.unit_price, v.tr_amt, to_char(to_date(v.on_board, 'YYYYMMDD'), 'DD/MM/YYYY') on_board, null recv_amt, null recv_date, nvl(v.tr_amt, 0) balance,   " +
       "v.decl_no, to_char(to_date(v.decl_date, 'YYYYMMDD'), 'DD/MM/YYYY') decl_date, to_char(to_date(v.date_export, 'YYYYMMDD'), 'DD/MM/YYYY') date_export, v.transport_by, v.ship_to, c.partner_name, v.co_invoice_no, v.invoice_no, v.serial_no,   " +
       " to_char(to_date(v.invoice_date, 'YYYYMMDD'), 'DD/MM/YYYY') invoice_date, style_name, v.tr_remark_ny, v.bk_rate, v.tr_famt, to_char(to_date(v.annex_date, 'YYYYMMDD'), 'DD/MM/YYYY') annex_date, v.annex_no, v.contract_no_ar, v.invoice_date invoice_date_1, v.fob_price, v.fob_amt, v.pay_method " +
       "from tac_carecv v,     " +
       "  tco_buspartner c   " +
       "where v.tr_date between '20090101' and '" + l_date_to + "'   " +
       "and 	v.del_if  = 0   " +
       "and 	v.tco_company_pk like '" + l_company_pk + "' " +
       "and not exists (select 'X' from tac_carecvtr t, tac_carecvh a where t.tac_carecv_pk =v.pk and t.del_if = 0 and t.tac_carecvh_pk = a.pk and a.del_if = 0 and a.tr_status in ('2', '0') and a.tr_date <= '" + l_date_to + "' )   " +
       "and 	v.tco_buspartner_pk = c.pk and v.tr_date between '20090101' and '" + l_date_to + "' " +
       " ) tb " +
       " order by tb.invoice_date_1, tb.invoice_no ";
    DataTable dt = ESysLib.TableReadOpen(SQL);
    int i;
    decimal l_tot_qty = 0, l_tot_amt_usd = 0, l_tot_balance = 0, l_tot_amt_vnd = 0, l_tot_amt_recv = 0;
    decimal l_tot_fob_amt = 0;
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Payment%20Status_files/filelist.xml">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style id="Trade receivable at 31st Dec 2009-ac code 1331_14362_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.xl2714362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2814362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl2914362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3014362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3114362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3214362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3314362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3414362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yyyy\;\@";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3514362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3614362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid silver;
	border-right:none;
	border-bottom:.5pt solid silver;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3714362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid silver;
	border-right:none;
	border-bottom:.5pt solid silver;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl3814362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid silver;
	border-right:none;
	border-bottom:.5pt solid silver;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3914362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid silver;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4014362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid silver;
	border-right:.5pt solid silver;
	border-bottom:.5pt solid silver;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl4114362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4214362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:??;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4314362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl4414362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl4514362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:00000;
	text-align:center-across;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl4614362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:center-across;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl4714362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:center-across;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl4814362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl4914362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl5014362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl5114362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl5214362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center-across;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl5314362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center-across;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl5414362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center-across;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl5514362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl5614362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl5714362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl5814362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl5914362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl6014362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl6114362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:center-across;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl6214362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl6314362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl6414362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl6514362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl6614362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl6714362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl6814362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl6914362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl7014362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl7114362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl7214362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl7314362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl7414362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl7514362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl7614362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center-across;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl7714362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl7814362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl7914362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl8014362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl8114362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl8214362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center-across;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl8314362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl8414362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl8514362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl8614362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl8714362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8814362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:0000000;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl8914362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl9014362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl9114362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl9214362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl9314362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yy\;\@";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl9414362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl9514362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yyyy\;\@";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl9614362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl9714362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl9814362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0000;
	text-align:center;
	vertical-align:bottom;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl9914362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl10014362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl10114362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl10214362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl10314362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl10414362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl10514362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl10614362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0000;
	text-align:center;
	vertical-align:bottom;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl10714362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0000;
	text-align:left;
	vertical-align:bottom;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl10814362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yyyy\;\@";
	text-align:general;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl10914362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11014362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11114362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl11214362
	{padding:0px;
	mso-ignore:padding;
	color:red;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:right;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl11314362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11414362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl11514362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl11614362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl11714362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11814362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl11914362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:general;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl12014362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl12114362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl12214362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl12314362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl12414362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:general;
	vertical-align:bottom;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl12514362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:general;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl12614362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl12714362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center-across;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl12814362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl12914362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl13014362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl13114362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:general;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl13214362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl13314362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center-across;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl13414362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center-across;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl13514362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center-across;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl13614362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl13714362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:general;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl13814362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl13914362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl14014362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl14114362
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl14214362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl14314362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl14414362
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:??, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
</head>

<body>
<!--[if !excel]>&nbsp;&nbsp;<![endif]-->
<!--The following information was generated by Microsoft Office Excel's Publish
as Web Page wizard.-->
<!--If the same item is republished from Excel, all information between the DIV
tags will be replaced.-->
<!----------------------------->
<!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD -->
<!----------------------------->

<div id="Trade receivable at 31st Dec 2009-ac code 1331_14362" align=center
x:publishsource="Excel">

<table x:str border=0 cellpadding=0 cellspacing=0 width=2618 class=xl3214362
 style='border-collapse:collapse;table-layout:fixed;width:1968pt'>
 <col class=xl10914362 width=97 style='mso-width-source:userset;mso-width-alt:
 3104;width:73pt'>
 <col class=xl4314362 width=64 style='mso-width-source:userset;mso-width-alt:
 2048;width:48pt'>
 <col class=xl3214362 width=62 style='mso-width-source:userset;mso-width-alt:
 1984;width:47pt'>
 <col class=xl4314362 width=80 style='mso-width-source:userset;mso-width-alt:
 2560;width:60pt'>
 <col class=xl3214362 width=150 style='mso-width-source:userset;mso-width-alt:
 4800;width:113pt'>
 <col class=xl3014362 width=84 style='mso-width-source:userset;mso-width-alt:
 2688;width:63pt'>
 <col class=xl3114362 width=62 style='mso-width-source:userset;mso-width-alt:
 1984;width:47pt'>
 <col class=xl11314362 width=88 style='mso-width-source:userset;mso-width-alt:
 2816;width:66pt'>
 <col class=xl11314362 width=85 style='mso-width-source:userset;mso-width-alt:
 2720;width:64pt'>
 <col class=xl11314362 width=89 style='mso-width-source:userset;mso-width-alt:
 2848;width:67pt'>
 <col class=xl11314362 width=69 style='mso-width-source:userset;mso-width-alt:
 2208;width:52pt'>
 <col class=xl11314362 width=90 style='mso-width-source:userset;mso-width-alt:
 2880;width:68pt'>
 <col class=xl3214362 width=85 style='mso-width-source:userset;mso-width-alt:
 2720;width:64pt'>
 <col class=xl3214362 width=83 style='mso-width-source:userset;mso-width-alt:
 2656;width:62pt'>
 <col class=xl3214362 width=80 style='mso-width-source:userset;mso-width-alt:
 2560;width:60pt'>
 <col class=xl11314362 width=83 style='mso-width-source:userset;mso-width-alt:
 2656;width:62pt'>
 <col class=xl4114362 width=100 style='mso-width-source:userset;mso-width-alt:
 3200;width:75pt'>
 <col class=xl3214362 width=60 style='mso-width-source:userset;mso-width-alt:
 1920;width:45pt'>
 <col class=xl3514362 width=72 span=2 style='width:54pt'>
 <col class=xl3514362 width=78 style='mso-width-source:userset;mso-width-alt:
 2496;width:59pt'>
 <col class=xl11314362 width=58 style='mso-width-source:userset;mso-width-alt:
 1856;width:44pt'>
 <col class=xl11314362 width=124 style='mso-width-source:userset;mso-width-alt:
 3968;width:93pt'>
 <col class=xl3514362 width=85 style='mso-width-source:userset;mso-width-alt:
 2720;width:64pt'>
 <col class=xl3514362 width=71 style='mso-width-source:userset;mso-width-alt:
 2272;width:53pt'>
 <col class=xl3014362 width=249 style='mso-width-source:userset;mso-width-alt:
 7968;width:187pt'>
 <col class=xl3214362 width=64 style='mso-width-source:userset;mso-width-alt:
 2048;width:48pt'>
 <col class=xl3214362 width=61 style='mso-width-source:userset;mso-width-alt:
 1952;width:46pt'>
 <col class=xl3214362 width=82 style='mso-width-source:userset;mso-width-alt:
 2624;width:62pt'>
 <col class=xl3214362 width=91 style='mso-width-source:userset;mso-width-alt:
 2912;width:68pt'>
 <tr class=xl3214362 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl2714362 width=97 style='height:18.0pt;width:73pt'><%=l_comp_nm %></td>
  <td class=xl2814362 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl2914362 width=62 style='width:47pt'></td>
  <td class=xl2814362 width=80 style='width:60pt'>&nbsp;</td>
  <td class=xl2914362 width=150 style='width:113pt'></td>
  <td class=xl3014362 width=84 style='width:63pt'></td>
  <td class=xl3114362 width=62 style='width:47pt'></td>
  <td class=xl11314362 width=88 style='width:66pt'></td>
  <td class=xl11314362 width=85 style='width:64pt'></td>
  <td class=xl11314362 width=89 style='width:67pt'></td>
  <td class=xl11314362 width=69 style='width:52pt'></td>
  <td class=xl11314362 width=90 style='width:68pt'></td>
  <td class=xl3214362 width=85 style='width:64pt'></td>
  <td class=xl3314362 width=83 style='width:62pt'></td>
  <td class=xl3414362 width=80 style='width:60pt'></td>
  <td class=xl12614362 width=83 style='width:62pt'></td>
  <td class=xl11114362 width=100 style='width:75pt'></td>
  <td class=xl3214362 width=60 style='width:45pt'></td>
  <td class=xl3514362 width=72 style='width:54pt'></td>
  <td class=xl3514362 width=72 style='width:54pt'></td>
  <td class=xl3514362 width=78 style='width:59pt'></td>
  <td class=xl11314362 width=58 style='width:44pt'></td>
  <td class=xl13214362 width=124 style='width:93pt'>&nbsp;</td>
  <td class=xl3514362 width=85 style='width:64pt'></td>
  <td class=xl3514362 width=71 style='width:53pt'></td>
  <td class=xl3014362 width=249 style='width:187pt'></td>
  <td class=xl3214362 width=64 style='width:48pt'></td>
  <td class=xl3214362 width=61 style='width:46pt'></td>
  <td class=xl3214362 width=82 style='width:62pt'></td>
  <td class=xl3214362 width=91 style='width:68pt'></td>
 </tr>
 <tr class=xl3214362 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl3614362 style='height:18.0pt'>EXPORT AND P<span
  style='display:none'>AYMENT STATUS FROM <%=l_date_from.Substring(6, 2) + "/" + l_date_from.Substring(4, 2) + "/" + l_date_from.Substring(0, 4) %> TO <%=l_date_to.Substring(6, 2) + "/" + l_date_to.Substring(4, 2) + "/" + l_date_to.Substring(0, 4) %> </span></td>
  <td class=xl3714362>&nbsp;</td>
  <td class=xl3814362>&nbsp;</td>
  <td class=xl3714362>&nbsp;</td>
  <td class=xl2914362></td>
  <td class=xl2914362></td>
  <td class=xl3114362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl3214362></td>
  <td class=xl3414362></td>
  <td class=xl3314362></td>
  <td class=xl11314362></td>
  <td class=xl11214362></td>
  <td class=xl3214362></td>
  <td class=xl3514362></td>
  <td class=xl3514362></td>
  <td class=xl3514362></td>
  <td class=xl11314362></td>
  <td class=xl13214362>&nbsp;</td>
  <td class=xl3514362></td>
  <td class=xl3514362></td>
  <td class=xl3014362></td>
  <td class=xl3214362></td>
  <td class=xl3214362></td>
  <td class=xl3214362></td>
  <td class=xl3214362></td>
 </tr>
 <tr class=xl3214362 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl3914362 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl3714362 style='border-top:none'>&nbsp;</td>
  <td class=xl3814362 style='border-top:none'>&nbsp;</td>
  <td class=xl4014362 style='border-top:none'>&nbsp;</td>
  <td class=xl3214362></td>
  <td class=xl3014362></td>
  <td class=xl3114362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl3214362></td>
  <td class=xl3414362></td>
  <td class=xl3314362></td>
  <td class=xl11314362></td>
  <td class=xl4114362></td>
  <td class=xl3214362></td>
  <td class=xl3514362></td>
  <td class=xl3514362></td>
  <td class=xl3514362></td>
  <td class=xl11314362></td>
  <td class=xl13214362>&nbsp;</td>
  <td class=xl3514362></td>
  <td class=xl3514362></td>
  <td class=xl3014362></td>
  <td class=xl3214362></td>
  <td class=xl3214362></td>
  <td class=xl3214362></td>
  <td class=xl3214362></td>
 </tr>
 <tr class=xl3214362 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl4214362 style='height:18.0pt'>&nbsp;</td>
  <td class=xl4314362>&nbsp;</td>
  <td class=xl3214362></td>
  <td class=xl4314362>&nbsp;</td>
  <td class=xl3214362></td>
  <td class=xl3014362></td>
  <td class=xl3114362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl3214362></td>
  <td class=xl3214362></td>
  <td class=xl3214362></td>
  <td class=xl11314362></td>
  <td class=xl4114362></td>
  <td class=xl3214362></td>
  <td class=xl3514362></td>
  <td class=xl3514362></td>
  <td class=xl3514362></td>
  <td class=xl11314362></td>
  <td class=xl13214362>&nbsp;</td>
  <td class=xl3514362></td>
  <td class=xl3514362></td>
  <td class=xl3014362></td>
  <td class=xl3214362></td>
  <td class=xl3214362></td>
  <td class=xl3214362></td>
  <td class=xl3214362></td>
 </tr>
 <tr class=xl3214362 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl4414362 width=97 style='height:23.25pt;width:73pt'
  x:str="INVOICE No."><span style='mso-spacerun:yes'> </span>INVOICE No.<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl4514362 align=center width=64 style='border-left:none;width:48pt'>Financial
  invoice</td>
  <td class=xl4614362>&nbsp;</td>
  <td class=xl4714362>&nbsp;</td>
  <td class=xl4814362>ITEM</td>
  <td class=xl4914362>STYLE#</td>
  <td class=xl5014362>P/O #</td>
  <td class=xl11414362 x:str="QTY ">QTY<span style='mso-spacerun:yes'> </span></td>
  <td class=xl11414362>U /P</td>
  <td class=xl11414362 x:str="AMOUNT ">AMOUNT<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl12014362>U /P</td>
  <td class=xl12014362 x:str="AMOUNT ">AMOUNT<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl13814362 width=85 style='border-bottom:.5pt solid black;
  width:64pt'>SALING ON BOARD</td>
  <td colspan=2 class=xl5214362 align=center x:str="PAYMENT STATUS"><span
  style='mso-spacerun:yes'> </span>PAYMENT STATUS<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl12714362>&nbsp;</td>
  <td class=xl5414362 align=center>Pay in advance</td>
  <td class=xl5114362 x:str="REMARK"><span
  style='mso-spacerun:yes'> </span>REMARK<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl14214362 style='border-right:.5pt solid black;
  border-left:none' x:str="Declaration"><span
  style='mso-spacerun:yes'> </span>Declaration<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl5514362>Date</td>
  <td class=xl13314362 align=center width=58 style='width:44pt'>Exchange rate</td>
  <td class=xl12014362 x:str="AMOUNT ">AMOUNT<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl5614362 x:str=" Transport by  "><span style='mso-spacerun:yes'> 
  </span>Transport by<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl5614362 x:str=" Ship To  "><span style='mso-spacerun:yes'> 
  </span>Ship To<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl5714362 x:str=" Customer Name  "><span style='mso-spacerun:yes'> 
  </span>Customer Name<span style='mso-spacerun:yes'>   </span></td>
  <td rowspan=2 class=xl14014362 width=64 style='border-bottom:.5pt solid black;
  width:48pt' x:str=" Payment method  "><span style='mso-spacerun:yes'> 
  </span>Payment method<span style='mso-spacerun:yes'>   </span></td>
  <td rowspan=2 class=xl14014362 width=61 style='border-bottom:.5pt solid black;
  width:46pt' x:str="ANNEX No"><span style='mso-spacerun:yes'> </span>ANNEX
  No<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl14014362 width=82 style='border-bottom:.5pt solid black;
  width:62pt' x:str="ANNEX DATE"><span style='mso-spacerun:yes'> </span>ANNEX
  DATE<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl14014362 width=91 style='border-bottom:.5pt solid black;
  width:68pt' x:str="CONTRACT NO"><span
  style='mso-spacerun:yes'> </span>CONTRACT NO<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl3214362 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl5814362 width=97 style='height:18.0pt;width:73pt'>&nbsp;</td>
  <td class=xl4514362 align=center width=64 style='border-top:none;border-left:
  none;width:48pt'>KI HIEU</td>
  <td class=xl5914362 style='border-top:none'>Invoice No</td>
  <td class=xl6014362 style='border-top:none'>date</td>
  <td class=xl6114362>&nbsp;</td>
  <td class=xl6214362>&nbsp;</td>
  <td class=xl6314362>&nbsp;</td>
  <td class=xl11514362>( PCS )</td>
  <td class=xl11514362>FOB</td>
  <td class=xl11514362>FOB</td>
  <td class=xl12114362><span style='mso-spacerun:yes'> </span>( USD )</td>
  <td class=xl12114362><span style='mso-spacerun:yes'> </span>( USD )</td>
  <td class=xl6414362 x:str="Received"><span
  style='mso-spacerun:yes'> </span>Received<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl6514362 width=80 style='width:60pt' x:str="Date of Receiving"><span
  style='mso-spacerun:yes'> </span>Date of Receiving<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl12814362>Balance</td>
  <td class=xl6614362>&nbsp;</td>
  <td class=xl6714362>&nbsp;</td>
  <td class=xl6814362>No.</td>
  <td class=xl6814362>Date</td>
  <td class=xl6814362>Export</td>
  <td class=xl13414362 width=58 style='width:44pt'>&nbsp;</td>
  <td class=xl12114362>( VND )</td>
  <td class=xl6914362 width=85 style='width:64pt'>&nbsp;</td>
  <td class=xl6914362 width=71 style='width:53pt'>&nbsp;</td>
  <td class=xl7014362 width=249 style='width:187pt'>&nbsp;</td>
 </tr>
 <tr class=xl3214362 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl7114362 id="_x0000_s1027" x:autofilter="all"
  x:autofilterrange="$A$7:$AD$10" width=97 style='height:18.0pt;border-top:
  none;width:73pt'>Year <%=DateTime.Today.Year %></td>
  <td class=xl7214362 id="_x0000_s1028" x:autofilter="all" width=64
  style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl7214362 id="_x0000_s1029" x:autofilter="all" width=62
  style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl7214362 id="_x0000_s1030" x:autofilter="all" width=80
  style='border-top:none;width:60pt'>&nbsp;</td>
  <td class=xl7314362 id="_x0000_s1031" x:autofilter="all" width=150
  style='border-top:none;width:113pt'>&nbsp;</td>
  <td class=xl7414362 id="_x0000_s1032" x:autofilter="all">&nbsp;</td>
  <td class=xl7514362 id="_x0000_s1033" x:autofilter="all">&nbsp;</td>
  <td class=xl11614362 id="_x0000_s1034" x:autofilter="all">&nbsp;</td>
  <td class=xl11614362 id="_x0000_s1035" x:autofilter="all">&nbsp;</td>
  <td class=xl11614362 id="_x0000_s1036" x:autofilter="all">&nbsp;</td>
  <td class=xl12214362 id="_x0000_s1037" x:autofilter="all">&nbsp;</td>
  <td class=xl12214362 id="_x0000_s1038" x:autofilter="all">&nbsp;</td>
  <td class=xl7614362 id="_x0000_s1039" x:autofilter="all" width=85
  style='width:64pt'>&nbsp;</td>
  <td class=xl7714362 id="_x0000_s1040" x:autofilter="all">&nbsp;</td>
  <td class=xl7814362 id="_x0000_s1041" x:autofilter="all" width=80
  style='width:60pt'>&nbsp;</td>
  <td class=xl12914362 id="_x0000_s1042" x:autofilter="all">&nbsp;</td>
  <td class=xl7914362 id="_x0000_s1043" x:autofilter="all">&nbsp;</td>
  <td class=xl8014362 id="_x0000_s1044" x:autofilter="all">&nbsp;</td>
  <td class=xl8114362 id="_x0000_s1045" x:autofilter="all">&nbsp;</td>
  <td class=xl8114362 id="_x0000_s1046" x:autofilter="all">&nbsp;</td>
  <td class=xl8114362 id="_x0000_s1047" x:autofilter="all">&nbsp;</td>
  <td class=xl13514362 id="_x0000_s1048" x:autofilter="all" width=58
  style='width:44pt'>&nbsp;</td>
  <td class=xl12214362 id="_x0000_s1049" x:autofilter="all">&nbsp;</td>
  <td class=xl8314362 id="_x0000_s1050" x:autofilter="all" width=85
  style='width:64pt'>&nbsp;</td>
  <td class=xl8314362 id="_x0000_s1051" x:autofilter="all" width=71
  style='width:53pt'>&nbsp;</td>
  <td class=xl8414362 id="_x0000_s1052" x:autofilter="all" width=249
  style='width:187pt'>&nbsp;</td>
  <td class=xl8214362 id="_x0000_s1053" x:autofilter="all" width=64
  style='width:48pt'>&nbsp;</td>
  <td class=xl8514362 id="_x0000_s1054" x:autofilter="all" width=61
  style='width:46pt'>&nbsp;</td>
  <td class=xl8514362 id="_x0000_s1055" x:autofilter="all" width=82
  style='width:62pt'>&nbsp;</td>
  <td class=xl8514362 id="_x0000_s1056" x:autofilter="all" width=91
  style='width:68pt'>&nbsp;</td>
 </tr>
 <% 
    for(i = 0; i < dt.Rows.Count; i++)
    {
        if (dt.Rows[i][2].ToString().Trim() != "")
            l_tot_qty += decimal.Parse(dt.Rows[i][2].ToString());
        if (dt.Rows[i][4].ToString().Trim() != "")
            l_tot_amt_usd += decimal.Parse(dt.Rows[i][4].ToString());
        if (dt.Rows[i][6].ToString().Trim() != "")
            l_tot_amt_recv += decimal.Parse(dt.Rows[i][6].ToString());
        if (dt.Rows[i][8].ToString().Trim() != "")
            l_tot_balance += decimal.Parse(dt.Rows[i][8].ToString());
        if (dt.Rows[i][22].ToString().Trim() != "")
            l_tot_amt_vnd += decimal.Parse(dt.Rows[i][22].ToString());
        if (dt.Rows[i][28].ToString().Trim() != "")
            l_tot_fob_amt += decimal.Parse(dt.Rows[i][28].ToString().Trim());
 %>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl8614362 style='height:18.0pt'><%=dt.Rows[i][15].ToString() %></td>
  <td class=xl8714362 style='border-left:none'><%=dt.Rows[i][17].ToString() %></td>
  <td class=xl8814362 align=right style='border-left:none' x:str><%=dt.Rows[i][16].ToString() %></td>
  <td class=xl8614362 style='border-left:none'><%=dt.Rows[i][18].ToString() %></td>
  <td class=xl8914362 style='border-left:none'><%=dt.Rows[i][19].ToString() %></td>
  <td class=xl9014362 style='border-left:none'><%=dt.Rows[i][0].ToString() %></td>
  <td class=xl9114362 style='border-left:none'><%=dt.Rows[i][1].ToString() %></td>
  <td class=xl11714362 align=right style='border-left:none' x:num><%=dt.Rows[i][2].ToString() %></td>
  <td class=xl12314362 align=right style='border-left:none' x:num><%=dt.Rows[i][27].ToString() %></td>
  <td class=xl9414362 align=right style='border-left:none' x:num><%=dt.Rows[i][28].ToString() %></td>
  <td class=xl12414362 align=right style='border-left:none' x:num><%=dt.Rows[i][3].ToString() %></td>
  <td class=xl9414362 align=right style='border-left:none' x:num><%=dt.Rows[i][4].ToString() %></td>
  <td class=xl9314362 style='border-left:none' x:str><%=dt.Rows[i][5].ToString() %></td>
  <td class=xl9414362 style='border-left:none' x:num><%=dt.Rows[i][6] %></td>
  <td class=xl9514362 style='border-left:none' x:str><%=dt.Rows[i][7] %></td>
  <td class=xl9414362 align=right style='border-left:none' x:num><%=dt.Rows[i][8].ToString() %></td>
  <td class=xl9414362 style='border-left:none'>&nbsp;</td>
  <td class=xl8614362 style='border-left:none'><%=dt.Rows[i][20].ToString() %></td>
  <td class=xl9614362 style='border-left:none' x:str><%=dt.Rows[i][9].ToString() %></td>
  <td class=xl9714362 style='border-left:none' x:str><%=dt.Rows[i][10].ToString() %></td>
  <td class=xl9314362 style='border-left:none' x:str><%=dt.Rows[i][11] %></td>
  <td class=xl13614362 align=right style='border-left:none' x:num><%=dt.Rows[i][21] %></td>
  <td class=xl14414362 align=right style='border-left:none' x:num><%=dt.Rows[i][22] %></td>
  <td class=xl9614362 style='border-left:none'><%=dt.Rows[i][12] %></td>
  <td class=xl9814362 style='border-left:none'><%=dt.Rows[i][13] %></td>
  <td class=xl8714362 style='border-left:none'><%=dt.Rows[i][14] %></td>
  <td class=xl8714362 style='border-left:none'><%=dt.Rows[i][29] %></td>
  <td class=xl9214362 align=right style='border-left:none' x:str><%=dt.Rows[i][24] %></td>
  <td class=xl9514362 align=right style='border-left:none' x:str><%=dt.Rows[i][23] %></td>
  <td class=xl9214362 style='border-left:none'><%=dt.Rows[i][25] %></td>
 </tr>
 <% 
    }
%>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=3 height=29 class=xl9914362 style='height:21.75pt'>Total</td>
  <td class=xl9914362 style='border-left:none'>&nbsp;</td>
  <td class=xl10014362 style='border-left:none'>&nbsp;</td>
  <td class=xl10114362 style='border-left:none'>&nbsp;</td>
  <td class=xl10214362 style='border-left:none'>&nbsp;</td>
  <td class=xl11914362 align=center style='border-left:none'
  x:num><%=l_tot_qty %></td>
  <td class=xl12514362 style='border-left:none'>&nbsp;</td>
  <td class=xl11914362 style='border-left:none' x:num><%=l_tot_fob_amt %></td>
  <td class=xl12514362 style='border-left:none'>&nbsp;</td>
  <td class=xl11914362 align=right style='border-left:none' x:num><%=l_tot_amt_usd%></td>
  <td class=xl10014362 style='border-left:none'>&nbsp;</td>
  <td class=xl10314362 style='border-left:none' x:num><%=l_tot_amt_recv%></td>
  <td class=xl10014362 style='border-left:none'>&nbsp;</td>
  <td class=xl13114362 align=right style='border-left:none' x:num><%=l_tot_balance %></td>
  <td class=xl10314362 align=center style='border-left:none' x:num></td>
  <td class=xl10414362 style='border-left:none'>&nbsp;</td>
  <td class=xl10514362 style='border-left:none'>&nbsp;</td>
  <td class=xl10514362 style='border-left:none'>&nbsp;</td>
  <td class=xl10514362 style='border-left:none'>&nbsp;</td>
  <td class=xl13714362 style='border-left:none'>&nbsp;</td>
  <td class=xl10314362 style='border-left:none' x:num><%=l_tot_amt_vnd%></td>
  <td class=xl10514362 style='border-left:none'>&nbsp;</td>
  <td class=xl10614362 style='border-left:none'>&nbsp;</td>
  <td class=xl10714362 style='border-left:none'>&nbsp;</td>
  <td class=xl10414362 style='border-left:none'>&nbsp;</td>
  <td class=xl10014362 style='border-left:none'>&nbsp;</td>
  <td class=xl10814362 style='border-left:none'>&nbsp;</td>
  <td class=xl10814362 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 class=xl10914362 style='height:18.0pt'></td>
  <td class=xl4314362>&nbsp;</td>
  <td class=xl3214362></td>
  <td class=xl4314362>&nbsp;</td>
  <td class=xl3214362></td>
  <td class=xl3014362></td>
  <td class=xl3114362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl3214362></td>
  <td class=xl3214362></td>
  <td class=xl3214362></td>
  <td class=xl11314362></td>
  <td class=xl4114362></td>
  <td class=xl3214362></td>
  <td class=xl3514362></td>
  <td class=xl3514362></td>
  <td class=xl3514362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl3514362></td>
  <td class=xl3514362></td>
  <td class=xl3014362></td>
  <td class=xl3214362></td>
  <td class=xl3214362></td>
  <td class=xl3214362></td>
  <td class=xl3214362></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl10914362 style='height:18.0pt'></td>
  <td class=xl4314362>&nbsp;</td>
  <td class=xl3214362></td>
  <td class=xl4314362>&nbsp;</td>
  <td class=xl3214362></td>
  <td class=xl3014362></td>
  <td class=xl3114362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl3214362></td>
  <td class=xl3314362></td>
  <td class=xl3214362></td>
  <td class=xl12614362></td>
  <td class=xl4114362></td>
  <td class=xl11014362></td>
  <td class=xl3514362></td>
  <td class=xl3514362></td>
  <td class=xl3514362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl3514362></td>
  <td class=xl3514362></td>
  <td class=xl3014362></td>
  <td class=xl3214362></td>
  <td class=xl3214362></td>
  <td class=xl3214362></td>
  <td class=xl3214362></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl10914362 style='height:18.0pt'></td>
  <td class=xl4314362>&nbsp;</td>
  <td class=xl3214362></td>
  <td class=xl4314362>&nbsp;</td>
  <td class=xl3214362></td>
  <td class=xl3014362></td>
  <td class=xl3114362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl3214362></td>
  <td class=xl11014362></td>
  <td class=xl3214362></td>
  <td class=xl11314362></td>
  <td class=xl4114362></td>
  <td class=xl11014362></td>
  <td class=xl3514362></td>
  <td class=xl3514362></td>
  <td class=xl3514362></td>
  <td class=xl11314362></td>
  <td class=xl11314362></td>
  <td class=xl3514362></td>
  <td class=xl3514362></td>
  <td class=xl3014362></td>
  <td class=xl3214362></td>
  <td class=xl3214362></td>
  <td class=xl3214362></td>
  <td class=xl3214362></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=97 style='width:73pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=150 style='width:113pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=249 style='width:187pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=91 style='width:68pt'></td>
 </tr>
 <![endif]>
</table>

</div>


<!----------------------------->
<!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD-->
<!----------------------------->
</body>

</html>
