<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%Response.ContentType = "application/vnd.ms-excel"; %>
<% ESysLib.SetUser("imex");%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string SQL, company = "", company_pk = "", pk = "", curr_book = "";
    string com_name = "", com_addr = "", com_tax = "", com_phone = "";
    string partnerID2 = "", partnerNm2 = "", addr2 = "", tel2 = "", fax2 = "", partnerID3 = "", partnerNm3 = "";
    string partnerID4 = "", partnerNm4 = "", addr4 = "", addr3 = "";
    string discharge = "", loading = "", transport = "", ship_dt = "", inv_no = "", inv_dt = "", lc_no = "", lc_dt = "";

    pk = Request.QueryString["pk"];
    company_pk = Request.QueryString["company_pk"];

    SQL = " select  a.partner_name, a.addr1, a.tax_code, a.phone_no ";
    SQL = SQL + " from    tco_company a  ";
    SQL = SQL + " where pk='" + company_pk + "'";
    DataTable dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count > 0)
    {
        com_name = (string)dt.Rows[0][0].ToString();
        com_addr = (string)dt.Rows[0][1].ToString();
        com_tax = (string)dt.Rows[0][2].ToString();
        com_phone = (string)dt.Rows[0][3].ToString();
    }

    SQL = " select  nvl(com.partner_name,exp.partner_name) partner1 " +
        "        , nvl(com.addr1,exp.addr1) partner_add1,  nvl(exp.tax_code,exp.tax_code) tax1 " +
        "        , imp.partner_name partner2, imp.tax_code tax2, imp.phone_no phone_no2, imp.fax_no fax_no2  " +
        "        , imp.addr1 partner_add2  " +
        "        , cons.partner_name partner3  " +
        "        , cons.addr1 partner_add3  " +
        "        , forw.partner_name partner4  " +
        "        , forw.addr1 partner_add4 " +
        "        , nvl(a.invoice_no,cinv.co_invoice_no) invoice_no  " +
        "        , to_char(to_date(nvl(a.invoice_date,cinv.co_invoice_date),'yyyymmdd'),'dd/mm/yy') cnv_date   " +
        "        , lc_dt, lc_no, trans.code transport, to_char(to_date(cinv.SHIP_DATE,'yyyymmdd'),'Mon.dd,yyyy') ship_date " +
        "        , load.port_nm, discharge.port_nm   " +
        "    from  tex_decl_mst a, tco_buspartner cus   " +
        "            , tco_buspartner exp, tco_buspartner imp   " +
        "            , tco_buspartner cons, tco_buspartner forw   " +
        "            , tex_cinv_mst_a  cinv, tco_company com   " +
        "            , tie_port load, tie_port discharge " +
        "            , (select a.code,  a.code_nm from tco_abcode a, tco_abcodegrp b      " +
        "              where tco_abcodegrp_pk=b.pk and b.id='IEAB0020'      " +
        "                  and a.del_if=0 and b.del_if=0 order by a.CODE) trans   " +
        "    where a.del_if = 0 and cus.del_if(+)=0    " +
        "         and  cons.del_if(+)=0 and forw.del_if(+)=0   " +
        "         and a.tco_buspartner_pk = cus.pk(+)   " +
        "         and a.tco_buspartner_pk1 = exp.pk(+)   " +
        "         and a.tco_buspartner_pk2 = imp.pk(+)   " +
        "         and a.tco_buspartner_pk3 = cons.pk(+)   " +
        "         and a.tco_buspartner_pk4 = forw.pk(+)   " +
        "         and a.tex_cinv_mst_a_pk = cinv.pk(+) " +
        "         and a.tco_buspartner_pk1 = com.pk(+)  " +
        "         and cinv.plc_loading =load.port_cd " +
        "         and cinv.plc_discharge = discharge.port_cd " +
        "         and upper(cinv.transport_by ) = upper(trans.code(+))   " +
        "         and a.pk='" + pk + "'";
    dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count > 0)
    {
        partnerNm2 = (string)dt.Rows[0][3].ToString();
        addr2 = (string)dt.Rows[0][7].ToString();
        tel2 = (string)dt.Rows[0][5].ToString();
        fax2 = (string)dt.Rows[0][6].ToString();
        partnerNm3 = (string)dt.Rows[0][8].ToString();
        addr3 = (string)dt.Rows[0][9].ToString();
        partnerNm4 = (string)dt.Rows[0][10].ToString();
        addr4 = (string)dt.Rows[0][11].ToString();
        discharge = (string)dt.Rows[0][18].ToString();
        loading = (string)dt.Rows[0][19].ToString();
        transport = (string)dt.Rows[0][16].ToString();
        ship_dt = (string)dt.Rows[0][17].ToString();
        inv_no = (string)dt.Rows[0][12].ToString();
        inv_dt = (string)dt.Rows[0][13].ToString();
        lc_no = (string)dt.Rows[0][14].ToString();
        lc_dt = (string)dt.Rows[0][15].ToString();
    }

    SQL = "select    v5.grp_nm, v5.grp_cd, v.item_code, v4.hs_code " +
        "        ,  comm.sf_get_item_attribute(a.tco_item_pk )  " +
        "        , to_char(nvl(a.qty,0),'999,999.99') qty, v3.uom_nm  " +
        "        , to_char(nvl(a.qty_packing,0),'999,999.99') qty_packing, a.unit_packing  " +
        "        , a.unit_weight, to_char(nvl(a.net_weight,0),'999,999.99') net_wt   " +
        "        , to_char(nvl(a.gross_weight,0),'999,999.99') gross_wt          " +
        " from tex_decl_dtl a, tco_item v, tex_decl_mst v1    " +
        "       , tie_country v2, comm.tco_uom v3  " +
        "       , tco_hscode v4, tco_itemgrp v5  " +
        " where a.del_if = 0    " +
        "        and  a.tco_item_pk = v.pk   " +
        "        and  a.tex_decl_mst_pk=v1.pk      " +
        "        and  upper(a.item_origin) = upper(v2.country_cd2(+))   " +
        "        and  upper(a.unit_cd) = upper(v3.uom_code(+))   " +
        "        and  v.tco_hscode_pk = v4.pk(+)    " +
        "        and  v.tco_itemgrp_pk = v5.pk  " +
        "        and  nvl(v.trans_fee_yn,'N') = 'N'  " +
        "        and  a.tex_decl_mst_pk='" + pk + "'" +
    " order by a.pk ";
    dt = ESysLib.TableReadOpen(SQL);

    SQL = "select   to_char(sum(nvl(a.qty,0)),'999,999.99') qty, v3.uom_nm " +
        "        , to_char(sum(nvl(a.qty_packing,0)),'999,999.99') qty_packing, a.unit_packing " +
        "        , a.unit_weight, to_char(sum(nvl(a.net_weight,0)),'999,999.99') net_wt  " +
        "        , to_char(sum(nvl(a.gross_weight,0)),'999,999.99') gross_wt         " +
        " from tex_decl_dtl a, tco_item v, tex_decl_mst v1   " +
        "       , tie_country v2, comm.tco_uom v3 " +
        "       , tco_hscode v4, tco_itemgrp v5 " +
        " where a.del_if = 0   " +
        "        and  a.tco_item_pk = v.pk  " +
        "        and  a.tex_decl_mst_pk=v1.pk     " +
        "        and  upper(a.item_origin) = upper(v2.country_cd2(+))  " +
        "        and  upper(a.unit_cd) = upper(v3.uom_code(+))  " +
        "        and  v.tco_hscode_pk = v4.pk(+)   " +
        "        and  v.tco_itemgrp_pk = v5.pk " +
        "        and  nvl(v.trans_fee_yn,'N') = 'N' " +
        "        and  a.tex_decl_mst_pk='" + pk + "'" +
        " group by  v3.uom_nm,  a.unit_packing, a.unit_weight, v.trans_fee_yn  ";
    DataTable dtSum = ESysLib.TableReadOpen(SQL);   
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_epgd00030_packinglist_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_epgd00030_packinglist_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_epgd00030_packinglist_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>&#50724;&#49849;&#54872;</o:Author>
  <o:LastAuthor>NgaLe</o:LastAuthor>
  <o:LastPrinted>2008-12-16T08:27:06Z</o:LastPrinted>
  <o:Created>2003-09-02T12:49:59Z</o:Created>
  <o:LastSaved>2008-12-16T08:27:10Z</o:LastSaved>
  <o:Company>&#44305;&#47548;&#44368;&#54924;</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.28in .18in 0in .17in;
	mso-header-margin:.2in;
	mso-footer-margin:.17in;
	mso-horizontal-page-align:center;}
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
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
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
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
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
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl28
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl42
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl44
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl47
	{mso-style-parent:style16;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;}
.xl49
	{mso-style-parent:style16;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl52
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl53
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl55
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:1.0pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:1.0pt solid windowtext;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl72
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:1.0pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	color:red;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmm\\\.\\ dd\\\,\\ yyyy";
	text-align:right;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	color:white;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl81
	{mso-style-parent:style0;
	color:white;
	font-size:10.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl82
	{mso-style-parent:style0;
	color:white;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	color:white;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	color:white;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;}
.xl85
	{mso-style-parent:style16;
	color:white;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	color:white;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	color:white;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl88
	{mso-style-parent:style0;
	color:white;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:center;}
.xl89
	{mso-style-parent:style16;
	color:white;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl90
	{mso-style-parent:style0;
	color:white;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	color:white;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:justify;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	color:white;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl93
	{mso-style-parent:style16;
	color:white;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl95
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl96
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl97
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl98
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl99
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl100
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl101
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:normal;}
.xl102
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl103
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl104
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl105
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl106
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl107
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl108
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl109
	{mso-style-parent:style0;
	color:white;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl110
	{mso-style-parent:style0;
	color:white;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl111
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl112
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl113
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl114
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl115
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl116
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl117
	{mso-style-parent:style0;
	color:white;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl118
	{mso-style-parent:style0;
	color:white;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl119
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl120
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:normal;}
.xl121
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl122
	{mso-style-parent:style0;
	color:red;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl123
	{mso-style-parent:style0;
	color:red;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl124
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl125
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl126
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl127
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl128
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl129
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl130
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl131
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl132
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl133
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl134
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl135
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl136
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl137
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl138
	{mso-style-parent:style16;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl139
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl140
	{mso-style-parent:style16;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl141
	{mso-style-parent:style16;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	border:1.0pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl142
	{mso-style-parent:style0;
	color:red;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmm\\\.\\ dd\\\,\\ yyyy";
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl143
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:right;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl144
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl145
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl146
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl147
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl148
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl149
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl150
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl151
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl152
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl153
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl154
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl155
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>PACKING LIST</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>98</x:Scale>
      <x:HorizontalResolution>-2</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:CodeName>Sheet2</x:CodeName>
     <x:TabColorIndex>11</x:TabColorIndex>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
       <x:RangeSelection>$D$9:$F$9</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:Sorting>
     <x:Sort>&#50676; A</x:Sort>
    </x:Sorting>
    <x:Watches>
     <x:Watch>
      <x:Source>$D$10</x:Source>
     </x:Watch>
    </x:Watches>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>6675</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>-15</x:WindowTopX>
  <x:WindowTopY>6165</x:WindowTopY>
  <x:TabRatio>848</x:TabRatio>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=876 style='border-collapse:
 collapse;table-layout:fixed;width:658pt'>
 <col class=xl24 width=105 style='mso-width-source:userset;mso-width-alt:2986;
 width:79pt'>
 <col class=xl24 width=98 style='mso-width-source:userset;mso-width-alt:2787;
 width:74pt'>
 <col class=xl24 width=250 style='mso-width-source:userset;mso-width-alt:7111;
 width:188pt'>
 <col class=xl24 width=112 style='mso-width-source:userset;mso-width-alt:3185;
 width:84pt'>
 <col class=xl41 width=112 style='mso-width-source:userset;mso-width-alt:3185;
 width:84pt'>
 <col class=xl24 width=112 style='mso-width-source:userset;mso-width-alt:3185;
 width:84pt'>
 <col class=xl24 width=87 style='mso-width-source:userset;mso-width-alt:2474;
 width:65pt'>
 <tr height=49 style='mso-height-source:userset;height:36.75pt'>
  <td colspan=6 height=49 class=xl103 width=789 style='height:36.75pt;
  width:593pt'>PACKING LIST</td>
  <td class=xl24 width=87 style='width:65pt'></td>
 </tr>
 <tr class=xl43 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl61 style='height:16.5pt'>Shipper/Export</td>
  <td class=xl62 width=98 style='width:74pt'>&nbsp;</td>
  <td class=xl63 width=250 style='width:188pt'>&nbsp;</td>
  <td colspan=3 class=xl104 width=336 style='border-left:none;width:252pt'>No.&amp;
  date of Invoice</td>
  <td class=xl43></td>
 </tr>
 <tr class=xl43 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=3 height=22 class=xl150 style='border-right:1.0pt solid black;
  height:16.5pt'><%=com_name%></td>
  <td colspan=2 class=xl122 width=224 style='border-left:none;width:168pt'><%=inv_no%></td>
  <td class=xl79 width=112 style='width:84pt'><%=inv_dt%></td>
  <td class=xl43></td>
 </tr>
 <tr class=xl43 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=3 rowspan=3 height=65 class=xl37 width=453 style='border-right:
  1.0pt solid black;border-bottom:1.0pt solid black;height:48.75pt;width:341pt'><%=com_addr%></td>
  <td colspan=3 class=xl104 width=336 style='border-left:none;width:252pt'>No.&amp;
  date of L/C</td>
  <td class=xl43></td>
 </tr>
 <tr class=xl43 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl44 style='height:16.5pt;border-left:none'><%=lc_no%></td>
  <td class=xl45>&nbsp;</td>
  <td class=xl143><%=lc_dt%></td>
  <td class=xl43></td>
 </tr>
 <tr class=xl43 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=3 height=21 class=xl105 width=336 style='border-right:1.0pt solid black;
  height:15.75pt;border-left:none;width:252pt'>Remark:</td>
  <td class=xl43></td>
 </tr>
 <tr class=xl43 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl64 width=105 style='height:16.5pt;border-top:none;
  width:79pt'>Consignee</td>
  <td class=xl65 width=98 style='border-top:none;width:74pt'>&nbsp;</td>
  <td class=xl66 width=250 style='border-top:none;width:188pt'>&nbsp;</td>
  <td colspan=3 class=xl127 width=336 style='border-right:1.0pt solid black;
  border-left:none;width:252pt'>&nbsp;</td>
  <td class=xl43></td>
 </tr>
 <tr class=xl43 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=3 height=22 class=xl147 style='border-right:1.0pt solid black;
  height:16.5pt'><%=partnerNm2%></td>
  <td colspan=3 class=xl132 width=336 style='border-right:1.0pt solid black;
  border-left:none;width:252pt' x:str="DELIVERY BY : ">DELIVERY BY :<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl43></td>
 </tr>
 <tr class=xl43 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=3 height=22 class=xl37 width=453 style='border-right:1.0pt solid black;
  height:16.5pt;width:341pt'><%=addr2%></td>
  <td colspan=3 class=xl144 style='border-right:1.0pt solid black;border-left:
  none'><%=com_name%></td>
  <td class=xl43></td>
 </tr>
 <tr class=xl43 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=3 height=22 class=xl37 width=453 style='border-right:1.0pt solid black;
  height:16.5pt;width:341pt'>TEL: <%=tel2%><span
  style='mso-spacerun:yes'>                   </span>FAX : <%=fax2%></td>
  <td colspan=3 rowspan=3 class=xl124 width=336 style='border-right:1.0pt solid black;
  width:252pt'><%=com_addr%></td>
  <td class=xl43></td>
 </tr>
 <tr class=xl43 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl111 width=453 style='border-right:1.0pt solid black;
  height:17.25pt;width:341pt'>&nbsp;</td>
  <td class=xl43></td>
 </tr>
 <tr class=xl43 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl64 width=453 style='border-right:1.0pt solid black;
  height:17.25pt;width:341pt'>For account and Risks of Messrs:</td>
  <td class=xl43></td>
 </tr>
 <tr class=xl43 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl100 width=453 style='border-right:1.0pt solid black;
  height:17.25pt;width:341pt'><%=partnerNm3%>ff</td>
  <td class=xl37 width=112 style='border-left:none;width:84pt'>&nbsp;</td>
  <td class=xl38></td>
  <td class=xl39 width=112 style='width:84pt'>&nbsp;</td>
  <td class=xl43></td>
 </tr>
 <tr class=xl43 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl119 width=453 style='border-right:1.0pt solid black;
  height:17.25pt;width:341pt'><%=addr3%></td>
  <td class=xl37 width=112 style='border-left:none;width:84pt'>&nbsp;</td>
  <td class=xl38></td>
  <td class=xl39 width=112 style='width:84pt'>&nbsp;</td>
  <td class=xl43></td>
 </tr>
 <tr class=xl43 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl119 width=453 style='border-right:1.0pt solid black;
  height:17.25pt;width:341pt'>&nbsp;</td>
  <td class=xl37 width=112 style='border-left:none;width:84pt'>&nbsp;</td>
  <td class=xl38></td>
  <td class=xl39 width=112 style='width:84pt'>&nbsp;</td>
  <td class=xl43></td>
 </tr>
 <tr class=xl43 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl42 style='height:16.5pt'>Port of loading</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl46 style='border-left:none'>Port of discharge</td>
  <td colspan=3 class=xl104 width=336 style='border-left:none;width:252pt'
  x:str="Terms of delivery ">Terms of delivery<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl43></td>
 </tr>
 <tr class=xl43 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=2 height=22 class=xl153 style='border-right:1.0pt solid black;
  height:16.5pt'><%=loading%></td>
  <td class=xl155 style='border-left:none'><%=discharge%></td>
  <td colspan=3 class=xl37 width=336 style='border-right:1.0pt solid black;
  border-left:none;width:252pt'>&nbsp;</td>
  <td class=xl43></td>
 </tr>
 <tr class=xl43 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=2 height=22 class=xl111 width=203 style='border-right:1.0pt solid black;
  height:16.5pt;width:153pt' x:str="Means of transportation ">Means of
  transportation<span style='mso-spacerun:yes'> </span></td>
  <td class=xl68 style='border-top:none;border-left:none'>Shipment on or about</td>
  <td colspan=3 class=xl130 style='border-right:1.0pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl43></td>
 </tr>
 <tr class=xl43 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=2 height=22 class=xl111 width=203 style='border-right:1.0pt solid black;
  height:16.5pt;width:153pt'><%=transport%></td>
  <td class=xl142 width=250 style='border-left:none;width:188pt'><%=ship_dt%></td>
  <td colspan=3 class=xl106 width=336 style='border-right:1.0pt solid black;
  border-left:none;width:252pt'>&nbsp;</td>
  <td class=xl43></td>
 </tr>
 <tr class=xl71 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl69 width=105 style='height:16.5pt;border-top:none;
  width:79pt'>Mark &amp; No.</td>
  <td colspan=2 class=xl113 width=348 style='border-right:1.0pt solid black;
  width:262pt'>Goods description</td>
  <td class=xl69 width=112 style='border-top:none;border-left:none;width:84pt'>Quantity
  ($unit)</td>
  <td class=xl70 width=112 style='border-top:none;width:84pt'>N.W($unit_wt)</td>
  <td class=xl70 width=112 style='border-top:none;border-left:none;width:84pt'>G.W
  ($unit_wt)</td>
  <td class=xl71></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl25 width=105 style='height:15.95pt;border-top:none;
  width:79pt'>N/M</td>
  <td class=xl25 width=98 style='width:74pt'>&nbsp;</td>
  <td class=xl35 width=250 style='width:188pt'><u style='visibility:hidden;
  mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl26></td>
  <td class=xl47 width=112 style='width:84pt'>&nbsp;</td>
  <td class=xl30 width=112 style='border-left:none;width:84pt'>&nbsp;</td>
  <td class=xl27></td>
 </tr>
 <% 
    for(int i=0;i< dt.Rows.Count ;i++)        
    {    
 %>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl28 width=105 style='height:15.95pt;width:79pt'><%=dt.Rows[i][8] %></td>
  <td class=xl31>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl26></td>
  <td class=xl47 width=112 style='width:84pt'>&nbsp;</td>
  <td class=xl30 width=112 style='border-left:none;width:84pt'>&nbsp;</td>
  <td class=xl27></td>
 </tr>
 <tr class=xl43 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl76 style='height:17.25pt'>&nbsp;</td>
  <td class=xl28 width=98 style='border-left:none;width:74pt'><%=dt.Rows[i][0] %></td>
  <td class=xl77 width=250 style='width:188pt'><%=dt.Rows[i][2] %></td>
  <td class=xl48></td>
  <td class=xl49>&nbsp;</td>
  <td class=xl36 style='border-left:none'>&nbsp;</td>
  <td class=xl43></td>
 </tr>
 <tr class=xl43 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl75 width=105 style='height:17.25pt;width:79pt'><%=dt.Rows[i][7] %></td>
  <td colspan=2 class=xl135 style='border-right:1.0pt solid black;border-left:
  none'><%=dt.Rows[i][4] %></td>
  <td class=xl137><%=dt.Rows[i][5] %></td>
  <td class=xl138><%=dt.Rows[i][10] %></td>
  <td class=xl139 style='border-left:none'><%=dt.Rows[i][11] %></td>
  <td class=xl43></td>
 </tr>
 <tr class=xl43 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl76 style='height:17.25pt'>&nbsp;</td>
  <td colspan=2 class=xl94 style='border-right:1.0pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl48></td>
  <td class=xl49>&nbsp;</td>
  <td class=xl36 style='border-left:none'>&nbsp;</td>
  <td class=xl43></td>
 </tr>
 <% 
    }       
 %>

 <tr class=xl87 height=0 style='display:none;mso-height-source:userset;
  mso-height-alt:315'>
  <td class=xl91>&nbsp;</td>
  <td colspan=2 class=xl117 style='border-right:1.0pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl92 style='border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl87></td>
 </tr>
 <%
    if(dtSum.Rows.Count>0)
    {
  %>
 <tr class=xl51 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl78 style='height:15.95pt'><%=dtSum.Rows[0][2] %></td>
  <td class=xl72 style='border-left:none'>&nbsp;</td>
  <td class=xl50 >TOTAL:</td>
  <td class=xl140 style='border-left:none'><%=dtSum.Rows[0][0] %></td>
  <td class=xl140><%=dtSum.Rows[0][5] %></td>
  <td class=xl141><%=dtSum.Rows[0][6] %></td>
  <td class=xl51></td>
 </tr>
 <%
    }
    else
    {
  %>
  <tr class=xl51 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl78 style='height:15.95pt'></td>
  <td class=xl72 style='border-left:none'>&nbsp;</td>
  <td class=xl50 >TOTAL:</td>
  <td class=xl140 style='border-left:none'></td>
  <td class=xl140></td>
  <td class=xl141></td>
  <td class=xl51></td>
 </tr>
 <%
    }
 %>
  <%
    for(int i = dt.Rows.Count*4; i<25;i++)
    {
  %>
 <tr class=xl43 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl73 width=105 style='height:15.95pt;width:79pt'>&nbsp;</td>
  <td colspan=3 class=xl74 style='mso-ignore:colspan'></td>
  <td class=xl52></td>
  <td class=xl53>&nbsp;</td>
  <td class=xl43></td>
 </tr>
 <%} %> 
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl57 width=105 style='height:15.95pt;width:79pt'>&nbsp;</td>
  <td class=xl58 width=98 style='width:74pt'>&nbsp;</td>
  <td class=xl58 width=250 style='width:188pt'>&nbsp;</td>
  <td class=xl58 width=112 style='width:84pt'>&nbsp;</td>
  <td class=xl59>&nbsp;</td>
  <td class=xl60>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=105 style='width:79pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=250 style='width:188pt'></td>
  <td width=112 style='width:84pt'></td>
  <td width=112 style='width:84pt'></td>
  <td width=112 style='width:84pt'></td>
  <td width=87 style='width:65pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
