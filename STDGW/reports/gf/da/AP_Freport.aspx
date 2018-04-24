<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% ESysLib.SetUser(Session["APP_DBUSER"].ToString());%>
<% Response.ContentType = "application/vnd.ms-excel";
   Response.Charset = "utf-8"; 
   Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string pk = Request["pk"];
    string sSQL = "";    
    string sCompany = "";
    sCompany = "select c.PARTNER_NAME from tco_company c where c.pk in (select tco_company_pk from tac_crda where pk = '" + pk + "')";
    DataTable dsComp = new DataTable();
    dsComp = ESysLib.TableReadOpen(sCompany);
    if (dsComp.Rows.Count > 0)
    {
        sCompany = dsComp.Rows[0][0].ToString();
    }
 sSQL
	= "select (select w.wh_name from TLG_IN_WAREHOUSE w where rownum = 1 and w.pk in (select d.tin_warehouse_pk  " + 
        "    from tac_crdad d where d.del_if = 0 and d.tac_crda_pk = '" + pk + "') ) wh_name,  " +
        "    (select h.full_name from thr_employee h where h.pk = u.thr_abemp_pk) full_nm,  " +
        "    (select p.pl_nm from v_abplcenter p where rownum = 1 and p.tac_abplcenter_pk in (select d.tac_abplcenter_pk " +
        "    from tac_crdad d where d.del_if =0 and d.tac_crda_pk = '" + pk + "' )) pl_nm,  " +
        "    c.partner_id || ':' || c.partner_lname as cust_name, " +
        "       a.serial_no || '  ' || a.invoice_no || '   ' || a.co_invoice_date, " +
        "       (select d.item from tac_crdaditem d, tac_abitem ab " +
        "            where d.del_if = 0 " +
        "            and d.tac_abitem_pk = ab.pk " +
        "            and d.tac_crda_pk = '" + pk + "' " +
        "            and ab.item_nm = 'CONTRACT NOAP') contract_no  " +
        "       ,to_char (nvl((select sum(d.ap_trfamt) from tac_crdad d where d.tac_crda_pk = '" + pk + "' and d.del_if = 0),0), decode(a.tr_ccy, 'USD', '999,999,999,999,990.99', '999,999,999,999,990') ) " +
        "       ,to_char (nvl((select sum(d.ap_tramt) from tac_crdad d where d.tac_crda_pk = '" + pk + "' and d.del_if = 0),0), decode(a.bk_rate, 1, '999,999,999,999,990', '999,999,999,999,990.99' )) " +
        "       ,to_char (a.ap_vatfamt, decode(a.tr_ccy, 'USD', '999,999,999,999,990.99', '999,999,999,999,999,990')) " +
        "       ,to_char (a.ap_vatamt, decode(a.bk_rate, 1, '999,999,999,999,999,990', '999,999,999,999,990.99'))  " +
        "       ,to_char (nvl((select sum(nvl(d.imp_famt, 0) + nvl(d.ap_trfamt, 0) + nvl(d.impvat_famt, 0)) from tac_crdad d where d.tac_crda_pk = '" + pk + "' and d.del_if = 0),0), decode(a.tr_ccy, 'USD', '999,999,999,999,990.99', '999,999,999,999,990'))  " +
        "       ,to_char (nvl((select sum(nvl(d.imp_amt, 0) + nvl(d.ap_tramt, 0) + nvl(d.impvat_amt, 0)) from tac_crdad d where d.tac_crda_pk = '" + pk + "' and d.del_if = 0),0), decode(a.bk_rate, 1, '999,999,999,999,990', '999,999,999,999,990.99'))  " +
        "       ,a.voucherno  " +
        "       ,a.tr_date  " +
        "       ,a.exp_famt " +
        "       ,a.exp_amt  " +
        "       ,to_char ((select sum(d.imp_amt) from tac_crdad d where d.tac_crda_pk = '" + pk + "' and d.del_if = 0), decode(a.tr_ccy, 'USD', '999,999,999,999,990.99', '999,999,999,999,990'))  " +
        "       ,to_char ((select sum(d.imp_famt) from tac_crdad d where d.tac_crda_pk = '" + pk + "' and d.del_if = 0), decode(a.bk_rate, 1, '999,999,999,999,990', '999,999,999,999,990.99')) " +
        "  from gasp.tes_user u,               " +
        "       tac_crda a,        " +
        "       tco_buspartner c " +
        " where a.del_if  = 0 " +
        " and a.tco_bsuser_pk = u.pk(+) " +
        " and a.tco_buspartner_pk_ap = c.pk(+)     " +
        " and a.pk = '" + pk + "' " ;
		//Response.Write(sSQL);
//Response.End();
	DataTable rs = new DataTable();
	rs = ESysLib.TableReadOpen(sSQL);
	string sSQL1 = "";
 sSQL1
	= " SELECT b.item_code || '    :   ' ||b.item_name, a.ap_unit, to_char (a.ap_qty, '999,999,999,999,990.99'),   " + 
        " to_char (a.ap_uprice, '999,999,999,999,990.999'), " +
        "   decode( c.tr_ccy, 'USD', to_char ( a.ap_trfamt, '999,999,999,999,990.99'), to_char ( a.ap_trfamt, '999,999,999,999,990') ) ,  decode(c.bk_rate, 1, to_char(a.ap_tramt, '999,999,999,999,990'), to_char(a.ap_tramt, '999,999,999,999,990.99')), a.po_no " +
        "  from tac_crdad a, tco_item b, tac_crda c " +
        " where a.del_if = 0 and a.tco_item_pk=b.pk and a.tac_crda_pk = '" + pk + "' and a.tac_crda_pk = c.pk " +
        " order by b.item_code " ;
	DataTable rs1 = new DataTable();
	rs1 = ESysLib.TableReadOpen(sSQL1);
	string wh = "";
	string whk = "";
	string pj = "";
	string sl = "";
	string ti = "", ct = "", ta = "", ba = "", vta = "", vba = "", tta = "", tba = "", no = "";
	string syear = "", smonth = "", sdate = "";
	string oef = "", oe = "", ita1 = "", ita2 = "";	
	string dt = "";
if(rs.Rows.Count > 0)  
{
	if(rs.Rows[0][0].ToString().Trim() != "")
		wh = rs.Rows[0][0].ToString().Trim();	
	if(rs.Rows[0][1].ToString().Trim() != "")	
		whk = rs.Rows[0][1].ToString().Trim();
	if(rs.Rows[0][2].ToString().Trim() != "")	
		pj = rs.Rows[0][2].ToString().Trim();
	if(rs.Rows[0][3].ToString().Trim() != "")	
		sl = rs.Rows[0][3].ToString().Trim();
	if(rs.Rows[0][4].ToString().Trim() != "")	
		ti = rs.Rows[0][4].ToString().Trim();
	if(rs.Rows[0][5].ToString().Trim() != "")		
		ct = rs.Rows[0][5].ToString().Trim();
	if(rs.Rows[0][6].ToString().Trim() != "")			
		ta = rs.Rows[0][6].ToString().Trim();
	if(rs.Rows[0][7].ToString().Trim() != "")	
		ba = rs.Rows[0][7].ToString().Trim();
	if(rs.Rows[0][8].ToString().Trim() != "")		
		vta = rs.Rows[0][8].ToString().Trim();
	if(rs.Rows[0][9].ToString().Trim() != "")				
		vba = rs.Rows[0][9].ToString().Trim();
	if(rs.Rows[0][10].ToString().Trim() != "")	
		tta = rs.Rows[0][10].ToString().Trim();
	if(rs.Rows[0][11].ToString().Trim() != "")		
		tba = rs.Rows[0][11].ToString().Trim();
	if(rs.Rows[0][12].ToString().Trim() != "")	
		no = rs.Rows[0][12].ToString().Trim();	
	if(rs.Rows[0][13].ToString().Trim() != "")
	{
		syear = rs.Rows[0][13].ToString().Substring(0, 4);
		smonth = rs.Rows[0][13].ToString().Substring(4, 2);	
		sdate = rs.Rows[0][13].ToString().Substring(6, 2);
	}		
	oef = rs.Rows[0][14].ToString().Trim();
	oe = rs.Rows[0][15].ToString().Trim();
	ita1 = rs.Rows[0][16].ToString().Trim();
	ita2 = rs.Rows[0][17].ToString().Trim();
	dt=	sdate + "/" + smonth + "/" + syear ;
}   
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="APOther_Freport_files/filelist.xml">
<link rel=Edit-Time-Data href="APOther_Freport_files/editdata.mso">
<link rel=OLE-Object-Data href="APOther_Freport_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Nguen Ngoc Long</o:Author>
  <o:LastAuthor>GENU</o:LastAuthor>
  <o:LastPrinted>2010-03-10T01:36:31Z</o:LastPrinted>
  <o:Created>2006-05-29T07:13:23Z</o:Created>
  <o:LastSaved>2010-03-10T01:36:53Z</o:LastSaved>
  <o:Company>atc-solution</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&L&R\:";
	margin:.75in 0in .25in 0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
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
	font-size:12.0pt;
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
	font-size:12.0pt;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	border-top:.5pt solid black;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl38
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl39
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl40
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl41
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;}
.xl42
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid black;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;}
.xl45
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid black;}
.xl47
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl51
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid black;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl66
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:left;}
.xl80
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl81
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl82
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:left;}
.xl83
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:justify;
	white-space:normal;}
.xl84
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl85
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl86
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>9</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>22</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
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
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>12390</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=746 style='border-collapse:
 collapse;table-layout:fixed;width:561pt'>
 <col class=xl24 width=80 style='width:60pt'>
 <col class=xl24 width=94 style='mso-width-source:userset;mso-width-alt:2673;
 width:71pt'>
 <col class=xl24 width=69 style='mso-width-source:userset;mso-width-alt:1962;
 width:52pt'>
 <col class=xl24 width=45 style='mso-width-source:userset;mso-width-alt:1280;
 width:34pt'>
 <col class=xl24 width=52 style='mso-width-source:userset;mso-width-alt:1479;
 width:39pt'>
 <col class=xl24 width=83 style='mso-width-source:userset;mso-width-alt:2360;
 width:62pt'>
 <col class=xl24 width=102 style='mso-width-source:userset;mso-width-alt:2901;
 width:77pt'>
 <col class=xl24 width=88 style='mso-width-source:userset;mso-width-alt:2503;
 width:66pt'>
 <col class=xl24 width=133 style='mso-width-source:userset;mso-width-alt:3783;
 width:100pt'>
 
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=6 rowspan=3 height=63 class=xl83 width=423 style='height:47.25pt;
  width:318pt'><%=sCompany %></td>
  <td class=xl25 width=102 style='width:77pt'>NO:</td>
  <td class=xl26 width=88 style='width:66pt'><%=no%>&nbsp;</td>
  <td class=xl24 width=133 style='width:100pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl27 style='height:15.75pt'>DATE:</td>
  <td class=xl28><%=dt%>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=8 rowspan=2 height=42 class=xl84 style='height:31.5pt'>MATERIAL
  RECEIVE NOTE</td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=9 class=xl24 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl79 style='height:15.75pt'>WAREHOUSE<span
  style='mso-spacerun:yes'>                  </span>:</td>
  <td colspan=6 class=xl85><%=wh%></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl79 style='height:15.75pt'>PREPARE<span
  style='mso-spacerun:yes'>   </span>BY :</td>
  <td colspan=6 class=xl81><%=whk%></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl82 style='height:15.75pt'>PROJECT<span
  style='mso-spacerun:yes'>                                     </span>:</td>
  <td colspan=6 class=xl81><%=pj%></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl79 style='height:15.75pt'>SUPPLIER<span
  style='mso-spacerun:yes'>                        </span>:</td>
  <td colspan=6 class=xl80 align=left><%=sl%></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl79 style='height:15.75pt'>TAX INVOICE
  NO.<span style='mso-spacerun:yes'>         </span>:</td>
  <td colspan=6 class=xl80 align=left><%=ti %></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl67 style='height:15.75pt'>CONTRACT NO.<span
  style='mso-spacerun:yes'>             </span>:</td>
  <td colspan=6 class=xl68><%=ct%>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 rowspan=2 height=42 class=xl69 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:31.5pt'>DESCRIPTION</td>
  <td rowspan=2 class=xl75 style='border-bottom:.5pt solid black;border-top:
  none'>UNIT</td>
  <td rowspan=2 class=xl75 style='border-bottom:.5pt solid black;border-top:
  none'>QTY</td>
  <td rowspan=2 class=xl75 style='border-bottom:.5pt solid black;border-top:
  none'>PRICE</td>
  <td colspan=2 class=xl77 style='border-right:.5pt solid black;border-left:
  none'>AMOUNT</td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black'>SLIP NO</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl29 style='height:15.75pt'>VND</td>
  <td class=xl29>USD</td>
 </tr>
  <%
 int dem=23;
	int i;
 for(i = 0; i < rs1.Rows.Count; i++)
 {
	dem=dem-1 ;
 %>

 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl61 style='border-right:.5pt solid black;
  height:15.0pt'><%=rs1.Rows[i][0]%>&nbsp;</td>
  <td class=xl30><%=rs1.Rows[i][1]%>&nbsp;</td>
  <td class=xl31><%=rs1.Rows[i][2]%>&nbsp;</td>
  <td class=xl31><%=rs1.Rows[i][3]%>&nbsp;</td>
  <td class=xl31><%=rs1.Rows[i][4]%>&nbsp;</td>
  <td class=xl31><%=rs1.Rows[i][5]%></td>
  <td class=xl90 align="center" style='border-top:none;border-left:none'><%=rs1.Rows[i][6]%>&nbsp;</td>
 </tr>
  <%
 }    
	for(i=0; i < dem; i++)
	{
	%>

 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl64 style='border-right:.5pt solid black;
  height:15.0pt'>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl86 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
  <%	
	}
 %>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=3 height=21 class=xl58 style='border-right:.5pt solid black;
  height:15.75pt'><span style='mso-spacerun:yes'>                     
  </span>IMPORT TAX</td>
  <td colspan=3 rowspan=4 class=xl41 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>&nbsp;</td>
  <td class=xl34><%=ita2%>&nbsp;</td>
  <td class=xl34><%=ita1%>&nbsp;</td>
  <td class=xl87 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=3 height=21 class=xl49 style='border-right:.5pt solid black;
  height:15.75pt'>VALUE</td>
  <td class=xl35><%=ta%>&nbsp;</td>
  <td class=xl35><%=ba%>&nbsp;</td>
  <td class=xl88 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl49 style='border-right:.5pt solid black;
  height:15.75pt'><span style='mso-spacerun:yes'>                     
  </span>VAT</td>
  <td class=xl35><%=vta%>&nbsp;</td>
  <td class=xl35><%=vba%>&nbsp;</td>
  <td class=xl88 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl52 style='border-right:.5pt solid black;
  height:15.75pt'><span style='mso-spacerun:yes'>                     
  </span>GRAND TOTAL</td>
  <td class=xl36><%=tta%>&nbsp;</td>
  <td class=xl36><%=tba%>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl38 style='height:15.75pt'>Transporter:..........................................</td>
  <td colspan=2 class=xl39>Buyer:</td>
  <td colspan=2 class=xl40>...........................................</td>
  <td colspan=2 class=xl38>Approved
  by:.............................................</td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl38 style='height:15.75pt'>Receive:..........................................</td>
  <td colspan=2 class=xl39>Prepare by:</td>
  <td colspan=2 class=xl40>.......................................</td>
  <td colspan=2 class=xl38>Approved
  by:.............................................</td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=2 align=left style='height:15.75pt;
  mso-ignore:colspan'
  x:str="                                                                                                                                     "><span
  style='mso-spacerun:yes'>                                           </span><span
  style='display:none'><span
  style='mso-spacerun:yes'>                                                                                          </span></span></td>
  <td colspan=4 rowspan=2 class=xl37>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl37>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=80 style='width:60pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=133 style='width:100pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
