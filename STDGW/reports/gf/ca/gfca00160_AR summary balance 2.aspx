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
    string p_tr_date_from = "", p_tr_date_to = "", p_curr_date = "";
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
            "        and v.tr_date <= '" + p_tr_date_to + "' " +
            "        and (v.tco_buspartner_pk like '" + p_cust_pk + "' or '" + p_cust_pk + "' is null ) " +
            "        and v.received_yn = 'Y' " +   
            "        and v.tac_hgtrd_pk = d.pk  " +
            "        group by v.tco_buspartner_pk " +
            "        union all " +
            "        select v.tco_buspartner_pk, 0 tr_famt, 0 tr_amt, " +
            "        sum(t.recv_famt) recv_famt, sum(t.recv_amt) recv_amt, 0 sum_seq " +
            "        from tac_carecvtr t, tac_carecvh h, tac_carecv v " +
            "        where v.tr_date <= '" + p_tr_date_to + "' " +
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
    SQL = "select partner_id, partner_name, to_char(sysdate, 'DD/MM/YYYY') curr_date from comm.tco_company where pk like '" + p_com_pk + "' and del_if = 0";
    DataTable dtComp = new DataTable();
    dtComp = ESysLib.TableReadOpen(SQL);
    if (dtComp.Rows.Count > 0)
    {
        p_comp_nm = dtComp.Rows[0][1].ToString();
        p_curr_date = dtComp.Rows[0][2].ToString();        
    }
    SQL
        = "select sum(tr_famt) tr_famt         " +
            "        from tac_carecv v, tac_hgtrd d " +
            "        where v.del_if = 0 " +
            "        and v.tr_date <= '" + p_tr_date_to + "' " +
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
<link rel=File-List
href="gfca00160_AR%20summary%20balance%202_files/filelist.xml">
<link rel=Edit-Time-Data
href="gfca00160_AR%20summary%20balance%202_files/editdata.mso">
<link rel=OLE-Object-Data
href="gfca00160_AR%20summary%20balance%202_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>visitor</o:Author>
  <o:LastAuthor>van</o:LastAuthor>
  <o:LastPrinted>2011-06-24T02:38:28Z</o:LastPrinted>
  <o:Created>2005-06-22T19:58:19Z</o:Created>
  <o:LastSaved>2011-06-24T11:07:08Z</o:LastSaved>
  <o:Company>USER</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.39in 0in .2in .2in;
	mso-header-margin:.2in;
	mso-footer-margin:.2in;
	mso-page-orientation:landscape;}
.font6
	{color:windowtext;
	font-size:11.0pt;
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
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style22
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
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_In01;}
.style23
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
	mso-style-name:Normal_In-draft;}
.style24
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
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet1;}
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
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style23;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.0000%";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}	
.xl41
	{mso-style-parent:style0;
	color:navy;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style23;
	color:navy;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.0000%";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
	
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	color:navy;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:right;
	vertical-align:middle;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl51
	{mso-style-parent:style24;
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
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl52
	{mso-style-parent:style24;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl53
	{mso-style-parent:style24;
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
	background:#99CCFF;
	mso-pattern:auto none;}
.xl54
	{mso-style-parent:style24;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl55
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
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl57
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
	background:#99CCFF;
	mso-pattern:auto none;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl59
	{mso-style-parent:style0;
	color:navy;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	color:navy;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	color:navy;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl62
	{mso-style-parent:style0;
	color:navy;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
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
    <x:Name>AP Balance</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>319</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>99</x:Scale>
      <x:HorizontalResolution>1200</x:HorizontalResolution>
      <x:VerticalResolution>1200</x:VerticalResolution>
     </x:Print>
     <x:CodeName>Sheet1</x:CodeName>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>7</x:SplitHorizontal>
     <x:TopRowBottomPane>7</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9255</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1560</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='AP Balance'!$A$7:$K$7</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='AP Balance'!$6:$7</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl27>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1033 style='border-collapse:
 collapse;table-layout:fixed;width:774pt'>
 <col class=xl27 width=26 style='mso-width-source:userset;mso-width-alt:950;
 width:20pt'>
 <col class=xl27 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl27 width=215 style='mso-width-source:userset;mso-width-alt:7862;
 width:161pt'>
 <col class=xl27 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl27 width=103 span=6 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <col class=xl27 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <tr height=25 style='mso-height-source:userset;height:18.95pt'>
  <td height=25 class=xl27 width=26 style='height:18.95pt;width:20pt'></td>
  <td class=xl28 colspan=2 width=295 style='mso-ignore:colspan;width:221pt'><%=p_comp_nm%></td>
  <td class=xl27 width=40 style='width:30pt'></td>
  <td class=xl29 width=103 style='width:77pt'></td>
  <td class=xl29 width=103 style='width:77pt'></td>
  <td class=xl29 width=103 style='width:77pt'></td>
  <td class=xl29 width=103 style='width:77pt'></td>
  <td class=xl27 width=103 style='width:77pt'></td>
  <td class=xl27 width=103 style='width:77pt'></td>
  <td class=xl27 width=54 style='width:41pt'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl27 style='height:17.1pt'></td>
  <td class=xl30 colspan=2 style='mso-ignore:colspan'>AR Balance Report</td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl49></td>
  <td colspan=3 class=xl31></td>
  <td class=xl27></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl27 style='height:17.1pt'></td>
  <td class=xl30 colspan=2 style='mso-ignore:colspan'>on <%=p_month%></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl49>Purchase Origin<font class="font6">:</font></td>
  <td colspan=3 class=xl31>(Confirmed)</td>
  <td class=xl27></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td colspan=2 height=33 class=xl49 style='height:24.95pt'>Date<font
  class="font6">:</font></td>
  <td class=xl31><%=p_curr_date %></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl32>Customer<font class="font6">:</font></td>
  <td colspan=3 class=xl50 width=309 style='width:231pt'></td>
  <td class=xl31></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl33 style='height:15.0pt'></td>
  <td colspan=3 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=2 height=65 class=xl51 width=26 style='border-bottom:.5pt solid black;
  height:48.75pt;width:20pt'>No</td>
  <td rowspan=2 class=xl51 width=80 style='border-bottom:.5pt solid black;
  width:60pt'>Customer ID</td>
  <td rowspan=2 class=xl53 style='border-bottom:.5pt solid black'>Customer</td>
  <td rowspan=2 class=xl51 width=40 style='border-bottom:.5pt solid black;
  width:30pt'>sum</td>
  <td rowspan=2 class=xl51 width=103 style='border-bottom:.5pt solid black;
  width:77pt'>Transaction Amount</td>
  <td rowspan=2 class=xl51 width=103 style='border-bottom:.5pt solid black;
  width:77pt'>Book Amount</td>
  <td rowspan=2 class=xl51 width=103 style='border-bottom:.5pt solid black;
  width:77pt'>Transaction<br>
    Recv. Amount</td>
  <td rowspan=2 class=xl51 width=103 style='border-bottom:.5pt solid black;
  width:77pt'>Book<br>
    Recv. Amount</td>
  <td rowspan=2 class=xl55 width=103 style='border-bottom:.5pt solid black;
  width:77pt'>Transaction <br>
    Balance Amount</td>
  <td rowspan=2 class=xl55 width=103 style='border-bottom:.5pt solid black;
  width:77pt'>Book<br>
    Balance Amount</td>
  <td rowspan=2 class=xl57 style='border-bottom:.5pt solid black'>%</td>
 </tr>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
 </tr>
<% 
    int i;
    decimal p_trf_amt = 0;
    decimal p_percentage = 0, p_tot_recv_famt = 0, p_tot_recv_amt = 0;
    for (i = 0; i < dtItem.Rows.Count; i++)
    {
        p_trf_amt = decimal.Parse(dtItem.Rows[i][4].ToString());
        p_percentage = decimal.Round(p_trf_amt / p_total, 4);
        p_tot_seq += decimal.Parse(dtItem.Rows[i][8].ToString());
        p_tot_trfamt += decimal.Parse(dtItem.Rows[i][4].ToString());
        p_tot_tramt += decimal.Parse(dtItem.Rows[i][5].ToString());
        p_tot_balfamt += decimal.Parse(dtItem.Rows[i][9].ToString());
        p_tot_balamt += decimal.Parse(dtItem.Rows[i][10].ToString());
        p_tot_recv_famt += decimal.Parse(dtItem.Rows[i][6].ToString());
        p_tot_recv_amt += decimal.Parse(dtItem.Rows[i][7].ToString());
        
%>  <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl36 align=right style='height:30.0pt;border-top:none'
  x:num><%=dtItem.Rows[i][0]%></td>
  <td class=xl37 style='border-top:none'><%=dtItem.Rows[i][2]%></td>
  <td class=xl38 style='border-top:none'><%=dtItem.Rows[i][3]%></td>
  <td class=xl39 style='border-top:none;border-left:none' x:num><%=dtItem.Rows[i][8]%></td>
  <td class=xl43 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dtItem.Rows[i][4]%> </td>
  <td class=xl44 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dtItem.Rows[i][5]%> </td>
  <td class=xl45 style='border-top:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dtItem.Rows[i][6]%><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl46 style='border-top:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dtItem.Rows[i][7]%> </td>
  <td class=xl43 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dtItem.Rows[i][9]%> </td>
  <td class=xl44 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dtItem.Rows[i][10]%> </td>
  <td class=xl40 style='border-top:none' x:num><%=p_percentage%></td>
 </tr>
 <% } %>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=4 class=xl27 style='height:15.95pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=3 height=40 class=xl59 style='border-right:.5pt solid black;
  height:30.0pt'>TOTAL</td>
  <td class=xl41 x:num><%=p_tot_seq%></td>
  <td class=xl62 x:num><span
  style='mso-spacerun:yes'> </span><%=p_tot_trfamt %> </td>
  <td class=xl48 x:num><span
  style='mso-spacerun:yes'> </span><%=p_tot_tramt%> </td>
  <td class=xl62 x:num><span
  style='mso-spacerun:yes'> </span><%=p_tot_recv_famt%> </td>
  <td class=xl48 x:num><span
  style='mso-spacerun:yes'> </span><%=p_tot_recv_amt%> </td>
  <td class=xl62 x:num><span
  style='mso-spacerun:yes'> </span><%=p_tot_balfamt%> </td>
  <td class=xl48 x:num><span
  style='mso-spacerun:yes'> </span><%=p_tot_balamt %> </td>
  <td class=xl42 x:num>1</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=26 style='width:20pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=54 style='width:41pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
