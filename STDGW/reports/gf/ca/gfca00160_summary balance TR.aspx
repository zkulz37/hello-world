<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<% ESysLib.SetUser("acnt");%>
<% Response.ContentType = "application/vnd.ms-excel";
   Response.Charset = "utf-8"; 
   Response.Buffer = false;
%>

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_tr_date_from = "", p_tr_date_to = "";
    string p_cust_pk = "";
    string p_com_pk = "", p_comp_nm = "", p_month = "", p_dt_fr = "", p_dt_to = "";
    decimal p_total = 0, p_tot_seq = 0, p_tot_trfamt = 0, p_tot_tramt = 0, p_tot_balfamt = 0 , p_tot_balamt = 0;
    p_tr_date_from = Request["from_date"];
    p_tr_date_to = Request["to_date"];
    p_cust_pk = Request["cust_pk"];
    p_com_pk = Request["company_pk"];
    p_dt_fr = p_tr_date_from.Substring(6, 2) + "/" + p_tr_date_from.Substring(4, 2) + "/" + p_tr_date_from.Substring(0, 4);
    p_dt_to = p_tr_date_to.Substring(6, 2) + "/" + p_tr_date_to.Substring(4, 2) + "/" + p_tr_date_to.Substring(0, 4);
    p_month = DateTime.Today.ToLongDateString();
    
    string SQL = "";
     SQL
        = "select rownum, tb.* from ( " +
            "select a.tco_buspartner_pk, p.partner_id, p.partner_lname, sum(a.tr_famt) tr_famt, sum(a.tr_amt) tr_amt,  " +
            "sum(a.recv_famt) recv_famt, sum(a.recv_amt) recv_amt, sum(a.sum_seq) sum_seq, " +
            "nvl( sum(a.tr_famt), 0) - nvl(sum(a.recv_famt), 0) bal_famt, nvl( sum(a.tr_amt), 0) - nvl(sum(a.recv_amt), 0) bal_amt " +
            "from ( " +
            "        select v.tco_buspartner_pk, sum(tr_famt) tr_famt, sum(v.tr_amt) tr_amt, " +
            "        0 recv_famt, 0 recv_amt, count(d.tac_hgtrh_pk) sum_seq " +
            "        from tac_carecv v, tac_hgtrd d " +
            "        where v.del_if = 0 " +
            "        and v.tr_date between '" + p_tr_date_from + "' and '" + p_tr_date_to + "' " +
            "        and (v.tco_buspartner_pk like '" + p_cust_pk + "' or '" + p_cust_pk + "' is null ) " +
            "        and v.received_yn = 'Y' " +   
            "        and v.tac_hgtrd_pk = d.pk  " +
            "        group by v.tco_buspartner_pk " +
            "        union all " +
            "        select v.tco_buspartner_pk, 0 tr_famt, 0 tr_amt, " +
            "        sum(t.recv_famt) recv_famt, sum(t.recv_amt) recv_amt, 0 sum_seq " +
            "        from tac_carecvtr t, tac_carecvh h, tac_carecv v " +
            "        where v.tr_date between '" + p_tr_date_from + "' and '" + p_tr_date_to + "' " +
            "        and v.del_if = 0 " +
            "        and (v.tco_buspartner_pk like '" + p_cust_pk + "' or '" + p_cust_pk + "' is null ) " +
            "        and v.received_yn = 'Y' " +
            "        and v.pk = t.tac_carecv_pk " +
            "        and t.del_if = 0 " +
            "        and t.tac_carecvh_pk = h.pk  " +
            "        and h.del_if = 0 " +
            "        and h.tr_status in ('2', '0') " +
            "        group by v.tco_buspartner_pk " +
            ") a, comm.tco_buspartner p " +
            "where a.tco_buspartner_pk = p.pk " +
            "group by a.tco_buspartner_pk, p.partner_id, p.partner_lname " +
            "order by p.partner_id " +
            "    ) tb " +
            "     ";
    DataTable dtItem = new DataTable();
    dtItem = ESysLib.TableReadOpen(SQL);
    if (dtItem.Rows.Count == 0)
    {
        Response.Write("There is no data to display !!!");
        Response.End();
    }
    SQL = "select partner_id, partner_name from comm.tco_company where pk like '" + p_com_pk + "' and del_if = 0";
    DataTable dtComp = new DataTable();
    dtComp = ESysLib.TableReadOpen(SQL);
    if (dtComp.Rows.Count > 0)
    {
        p_comp_nm = dtComp.Rows[0][1].ToString();        
    }
    SQL
        = "select sum(tr_famt) tr_famt         " +
            "        from tac_carecv v, tac_hgtrd d " +
            "        where v.del_if = 0 " +
            "        and v.tr_date between '" + p_tr_date_from + "' and '" + p_tr_date_to + "' " +
            "        and (v.tco_buspartner_pk like '" + p_cust_pk + "' or '" + p_cust_pk + "' is null ) " +
            "        and v.tac_hgtrd_pk = d.pk  " +
            "        and v.received_yn = 'Y' ";
    DataTable dtSum = new DataTable();
    dtSum = ESysLib.TableReadOpen(SQL);
    if (dtSum.Rows.Count > 0)
    {
        p_total = decimal.Parse(dtSum.Rows[0][0].ToString());            
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="AR%20summary%20balance%20TR_files/filelist.xml">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style id="AR summary balance TR_11305_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.font511305
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl2711305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2811305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2911305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3011305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3111305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3211305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3311305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3411305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3511305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3611305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3711305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3811305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
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
	mso-pattern:auto;
	white-space:nowrap;}
.xl3911305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.0000%";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4011305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4111305
	{padding:0px;
	mso-ignore:padding;
	color:navy;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4211305
	{padding:0px;
	mso-ignore:padding;
	color:navy;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
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
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4311305
	{padding:0px;
	mso-ignore:padding;
	color:navy;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.0000%";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4411305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4511305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4611305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
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
.xl4711305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
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
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl4811305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:right;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4911305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
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
	white-space:nowrap;}
.xl5011305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
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
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl5111305
	{padding:0px;
	mso-ignore:padding;
	color:navy;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5211305
	{padding:0px;
	mso-ignore:padding;
	color:navy;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5311305
	{padding:0px;
	mso-ignore:padding;
	color:navy;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5411305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
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
.xl5511305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
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
.xl5611305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
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
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl5711305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
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
	white-space:nowrap;}
.xl5811305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
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
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl5911305
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6011305
	{padding:0px;
	mso-ignore:padding;
	color:navy;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
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

<div id="AR summary balance TR_11305" align=center x:publishsource="Excel">

<table x:str border=0 cellpadding=0 cellspacing=0 width=979 class=xl2711305
 style='border-collapse:collapse;table-layout:fixed;width:737pt'>
 <col class=xl2711305 width=26 style='mso-width-source:userset;mso-width-alt:
 950;width:20pt'>
 <col class=xl2711305 width=124 style='mso-width-source:userset;mso-width-alt:
 4534;width:93pt'>
 <col class=xl2711305 width=295 style='mso-width-source:userset;mso-width-alt:
 10788;width:221pt'>
 <col class=xl2711305 width=40 style='mso-width-source:userset;mso-width-alt:
 1462;width:30pt'>
 <col class=xl2711305 width=110 span=4 style='mso-width-source:userset;
 mso-width-alt:4022;width:83pt'>
 <col class=xl2711305 width=54 style='mso-width-source:userset;mso-width-alt:
 1974;width:41pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl2711305 width=26 style='height:15.0pt;width:20pt'></td>
  <td class=xl2811305 colspan=2 width=419 style='width:314pt'><%=p_comp_nm %></td>
  <td class=xl2711305 width=40 style='width:30pt'></td>
  <td class=xl2911305 width=110 style='width:83pt'></td>
  <td class=xl2911305 width=110 style='width:83pt'></td>
  <td class=xl2711305 width=110 style='width:83pt'></td>
  <td class=xl2711305 width=110 style='width:83pt'></td>
  <td class=xl2711305 width=54 style='width:41pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl2711305 style='height:15.0pt'></td>
  <td class=xl3011305>AR Balance Report</td>
  <td class=xl3011305></td>
  <td colspan=2 class=xl4811305></td>
  <td colspan=3 class=xl3111305></td>
  <td class=xl2711305></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl2711305 style='height:15.0pt'></td>
  <td class=xl3011305 colspan=2>on<%=p_month%></td>
  <td colspan=2 class=xl4811305>Purchase Origin<font class="font511305">:</font></td>
  <td colspan=3 class=xl3111305>(Confirmed)</td>
  <td class=xl2711305></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl4811305 style='height:15.0pt'>Date<font
  class="font511305">:</font></td>
  <td class=xl3111305><%=p_dt_fr %> ~ <%=p_dt_to%></td>
  <td class=xl2711305></td>
  <td class=xl3211305>Customer<font class="font511305">:</font></td>
  <td colspan=4 class=xl3111305></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl3311305 style='height:15.0pt'></td>
  <td class=xl3411305></td>
  <td class=xl3411305></td>
  <td class=xl3411305></td>
  <td class=xl3511305></td>
  <td class=xl3511305></td>
  <td class=xl3311305></td>
  <td class=xl3311305></td>
  <td class=xl3311305></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td rowspan=2 height=63 class=xl5411305 width=26 style='border-bottom:.5pt solid black;
  height:47.25pt;width:20pt'>No</td>
  <td rowspan=2 class=xl5411305 width=124 style='border-bottom:.5pt solid black;
  width:93pt'>Customer ID</td>
  <td rowspan=2 class=xl5711305 style='border-bottom:.5pt solid black'>Customer</td>
  <td rowspan=2 class=xl5411305 width=40 style='border-bottom:.5pt solid black;
  width:30pt'>sum</td>
  <td rowspan=2 class=xl5411305 width=110 style='border-bottom:.5pt solid black;
  width:83pt'>Transaction Amount</td>
  <td rowspan=2 class=xl5411305 width=110 style='border-bottom:.5pt solid black;
  width:83pt'>Book Amount</td>
  <td rowspan=2 class=xl4611305 width=110 style='border-bottom:.5pt solid black;
  width:83pt'>Transaction <br>
    Balance Amount</td>
  <td rowspan=2 class=xl4611305 width=110 style='border-bottom:.5pt solid black;
  width:83pt'>Book<br>
    Balance Amount</td>
  <td rowspan=2 class=xl4911305 style='border-bottom:.5pt solid black'>%</td>
 </tr>
 <tr height=43 style='mso-height-source:userset;height:32.25pt'>
 </tr>
<% 
    int i;
    decimal p_trf_amt = 0;
    decimal p_percentage = 0;
    for (i = 0; i < dtItem.Rows.Count; i++)
    {
        p_trf_amt = decimal.Parse(dtItem.Rows[i][4].ToString());
        p_percentage = decimal.Round(p_trf_amt / p_total, 4);
        p_tot_seq += decimal.Parse(dtItem.Rows[i][8].ToString());
        p_tot_trfamt += decimal.Parse(dtItem.Rows[i][4].ToString());
        p_tot_tramt += decimal.Parse(dtItem.Rows[i][5].ToString());
        p_tot_balfamt += decimal.Parse(dtItem.Rows[i][9].ToString());
        p_tot_balamt += decimal.Parse(dtItem.Rows[i][10].ToString());
%> 
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl3611305 align=right style='height:15.0pt' x:num><%=dtItem.Rows[i][0].ToString()%></td>
  <td class=xl4411305 style='border-top:none'><%=dtItem.Rows[i][2].ToString() %></td>
  <td class=xl4511305 style='border-top:none'><%=dtItem.Rows[i][3].ToString() %><span style='display:none'>D</span></td>
  <td class=xl3711305 style='border-top:none' x:num><%=dtItem.Rows[i][8].ToString() %></td>
  <td class=xl5911305 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>     </span><%=dtItem.Rows[i][4] %> </td>
  <td class=xl3811305 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>         </span><%=dtItem.Rows[i][5] %> </td>
  <td class=xl5911305 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>       </span><%=dtItem.Rows[i][9] %> </td>
  <td class=xl3811305 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>           </span><%=dtItem.Rows[i][10] %> </td>
  <td class=xl3911305 style='border-top:none' x:num><%=p_percentage%></td>
 </tr>
 <% 
    }
        %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl2711305 style='height:15.0pt'></td>
  <td class=xl2711305></td>
  <td class=xl2711305></td>
  <td class=xl4011305></td>
  <td class=xl4011305></td>
  <td class=xl4011305></td>
  <td class=xl4011305></td>
  <td class=xl4011305></td>
  <td class=xl4011305></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=3 height=20 class=xl5111305 style='border-right:.5pt solid black;
  height:15.0pt'>TOTAL</td>
  <td class=xl4111305 x:num><%=p_tot_seq%></td>
  <td class=xl6011305 x:num><span
  style='mso-spacerun:yes'> </span><%=p_tot_trfamt%> </td>
  <td class=xl4211305 x:num><span
  style='mso-spacerun:yes'> </span><%=p_tot_tramt %> </td>
  <td class=xl6011305 x:num><span
  style='mso-spacerun:yes'> </span><%=p_tot_balfamt%> </td>
  <td class=xl4211305 x:num><span
  style='mso-spacerun:yes'> </span><%=p_tot_balamt%> </td>
  <td class=xl4311305 x:num="1">100.0000%</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=26 style='width:20pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=295 style='width:221pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=54 style='width:41pt'></td>
 </tr>
 <![endif]>
</table>

</div>


<!----------------------------->
<!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD-->
<!----------------------------->
</body>

</html>
