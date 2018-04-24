<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<% ESysLib.SetUser("imex");%>

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string decl_no="", decl_date="", pk="", annex="", decl_type="", license="", license_date="", license_expdate="";
    string CONTR_DATE="", exp_date="", exporter="", cust_add="", co_invoice_no="", co_invoice_date="", vessel_flt_name="";
    string arrival_date="", bill_no="", bill_date="", co_add="", co_nm="", tie_country_cd22="", country_nm="";
    string place_of_loading_nm="", import_gate="", f_nm="", l_add="", trade_terms="", TR_CCY="", ex_rate="", PAY_METH="";
    string SQL, company="", company_pk="";
	pk=Request.QueryString["pk"];
    company_pk = Request.QueryString["company_pk"];

    SQL = " select  a.partner_name, a.addr1 ";
    SQL = SQL + " from    tco_company a  ";
    SQL = SQL + " where pk='"  + company_pk + "'";

    DataTable dt = ESysLib.TableReadOpen(SQL);
       
	SQL = " select distinct a.PK , a.tim_cinv_mst_a_pk, a.decl_no  ";
    SQL = SQL + "       ,to_char(to_date(a.decl_date,'YYYYMMDD'),'dd-Mon-yyy') decl_date  ";
    SQL = SQL + "       ,a.tr_ccy ,a.EX_RATE ,a.TOT_NET_TR_AMT ,a.TCO_BUSPARTNER_pk3  ";
    SQL = SQL + "       ,a.TCO_BUSPARTNER_pk4 ,e.PARTNER_id F_ID ,e.PARTNER_name F_NM  ";
    SQL = SQL + "       ,f.PARTNER_id CO_ID ,f.PARTNER_name CO_NM ,c.PARTNER_id CustID  ";
    SQL = SQL + "       ,c.PARTNER_name ,d.PARTNER_id CS_ID ,d.PARTNER_name CS_NM     ";
    SQL = SQL + "       ,a.DECL_TYPE ,b.co_invoice_no  ,a.TCO_BUSPARTNER_pk1      ";
    SQL = SQL + "       ,to_char(to_date(a.import_date,'YYYYMMDD'),'dd-Mon-yyyy') import_date ";
    SQL = SQL + "       ,decode(a.STATUS,1,'Saved',2,' Confirmed ',3,'Cancelled',0,'Approved')";
    SQL = SQL + "       ,a.ctr_type  ,a.LICENSE  ";
    SQL = SQL + "       ,to_char(to_date(a.LICENSE_DATE,'YYYYMMDD'),'dd-Mon-yyyy') LICENSE_DATE ";
    SQL = SQL + "       ,to_char(to_date(a.LICENSE_EXPDATE,'YYYYMMDD'),'dd-Mon-yyyy') LICENSE_EXPDATE  ";
    SQL = SQL + "       ,h.Contr_No  ";
    SQL = SQL + "       ,to_char(to_date(h.CONTR_DATE,'YYYYMMDD'),'dd-Mon-yyyy') CONTR_DATE  ";
    SQL = SQL + "       ,to_char(to_date(h.EXP_DATE,'YYYYMMDD'),'dd-Mon-yyyy')EXP_DATE  ";
    SQL = SQL + "       ,to_char(to_date(b.CO_INVOICE_DATE,'YYYYMMDD'),'dd-Mon-yyyy') CO_INVOICE_DATE   ";
    SQL = SQL + "       ,TRANSPORT_BY  ,i.VESSEL_FLT_NAME  ";
    SQL = SQL + "       ,to_char(to_date(i.ARRIVAL_DATE,'YYYYMMDD'),'dd-Mon-yyyy') ARRIVAL_DATE  ";
    SQL = SQL + "       ,a.TIE_BL_MST_PK ,i.BILL_NO  ";
    SQL = SQL + "       ,to_char(to_date(i.BILL_DATE,'YYYYMMDD'),'dd-Mon-yyyy')  BILL_DATE  ";
    SQL = SQL + "       ,a.ACCEPT_NO ,a.ANNEX ,a.NO_OF_DECL ,a.ENCLOSED_DOC ,a.CARTON ,a.WEIGHT ";
    SQL = SQL + "       ,a.CONT20 ,a.CONT40 ,a.DECL_TYPE ,I.TIE_COUNTRY_CD22 ,j.code_nm  ";
    SQL = SQL + "       ,I.PLACE_OF_LOADING_NM ,I.IMPORT_GATE ,m.code_nm ,a.tr_ccy   ";
    SQL = SQL + "       ,c.addr1 ||' '|| c.addr2 || ' ' ||c.addr3 cust_add  ";
    SQL = SQL + "       ,f.addr1 ||' '|| f.addr2 || ' ' ||f.addr3 ex_add  ";
    SQL = SQL + "       ,e.addr1 ||' '|| e.addr2 || ' ' ||e.addr3 l_add  ";
    SQL = SQL + "       ,l.code_nm   ";
    SQL = SQL + "       ,d.addr1 ||' '|| d.addr2 || ' ' ||d.addr3 co_add  ";
    SQL = SQL + "       ,i.PLACE_OF_LOADING, i.PLACE_OF_DISCHARGE, i.PLC_OF_DISCHARGE_NM, trans_name ";
    SQL = SQL + " from  tim_decl_mst a left join tie_bl_mst i on a.tie_bl_mst_pk=i.pk   ";
    SQL = SQL + "      left join tim_cinv_mst_a  b on a.TIM_CINV_MST_A_PK=b.pk     ";
    SQL = SQL + "      left join TCO_BUSPARTNER  c on a.TCO_BUSPARTNER_PK1 =c.pk  ";
    SQL = SQL + "      left join TCO_BUSPARTNER  d on a.TCO_BUSPARTNER_PK2 =d.pk  ";
    SQL = SQL + "      left join TCO_BUSPARTNER  e on a.TCO_BUSPARTNER_PK3 =e.pk  ";
    SQL = SQL + "      left join TCO_BUSPARTNER  f on a.TCO_BUSPARTNER_PK4 =f.pk  ";
    SQL = SQL + "      left join tim_cinv_mst_b g on g.tim_cinv_mst_a_pk=b.pk  ";
    SQL = SQL + "      left join tim_contr_mst h on g.tim_contr_mst_pk=h.pk   ";
    SQL = SQL + "      left join (select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b  ";
    SQL = SQL + "            where TCO_ABCODEGRP_PK=b.pk and b.id='COAB0080'  ";
    SQL = SQL + "                and a.del_if=0 and b.del_if=0 order by a.CODE) j on i.tie_country_cd22=j.code  ";
    SQL = SQL + "      left join (select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b "; 
    SQL = SQL + "              where TCO_ABCODEGRP_PK=b.pk and b.id='ACCR0140' ";
    SQL = SQL + "                  and a.del_if=0 and b.del_if=0 order by a.CODE) l on b.PAY_METH=l.code ";
    SQL = SQL + "      left join (select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b ";
    SQL = SQL + "              where TCO_ABCODEGRP_PK=b.pk and b.id='IEAB0010' ";
    SQL = SQL + "                  and a.del_if=0 and b.del_if=0 order by a.CODE) m on upper(I.TRADE_TERMS)=upper(m.code) ";
    SQL = SQL + "    where a.del_if=0      and  a.pk ='" + pk + "'";

	
	DataTable resultdata= ESysLib.TableReadOpen(SQL);
	
	SQL = "  select  c.item_name, c.item_code, m.code_nm ";
    SQL = SQL + "     , to_char(a.qty,'999,999,999') qty, a.unit_cd ";
    SQL = SQL + "     , decode(e.tr_ccy,'VND',to_char(a.u_price,'999,999,999'),to_char(a.u_price,'999,999,990.99')) u_price ";
    SQL = SQL + "     , decode(e.tr_ccy,'VND',to_char(a.EXT_PRICE ,'999,999,999'),to_char(a.EXT_PRICE ,'999,999,990.99')) ext_amt  ";
    SQL = SQL + "     , decode(e.tr_ccy,'VND',to_char(nvl(IM_TAX_CALC_AMT,0)+ nvl(RE_IM_TAX_CALC_AMT,0),'999,999,999'),to_char(nvl(IM_TAX_CALC_AMT,0)+ nvl(RE_IM_TAX_CALC_AMT,0),'999,999,990.99')) tr_amt  ";
    SQL = SQL + "     , to_char(a.IM_TAX_RATE,'999,999,999.99') im_tax_rate ";
    SQL = SQL + "     , decode(e.tr_ccy,'VND',to_char(a.IM_TAX_AMT,'999,999,999'),to_char(a.IM_TAX_AMT,'999,999,990.99')) tax_amt  ";
    SQL = SQL + "     , decode(e.tr_ccy,'VND',to_char(a.VAT_AMT,'999,999,999'),to_char(a.VAT_AMT,'999,999,990.99')) vat_tr_amt ";
    SQL = SQL + "     , to_char(a.VAT_RATE,'999,999,999.99') vat_tax_rate ";
    SQL = SQL + "     , decode(e.tr_ccy,'VND',to_char(nvl(a.VAT_AMT,0)*nvl(a.VAT_RATE,0)/100,'999,999,999'),to_char(nvl(a.VAT_AMT,0)*nvl(a.VAT_RATE,0)/100,'999,999,990.99')) vat_amt ";    
    SQL = SQL + "     , to_char(a.OT_TAX_RATE,'999,999,999.99') ot_tax_rate ";
    SQL = SQL + "     , decode(e.tr_ccy,'VND',to_char(nvl(a.OT_TAX_CALC_AMT,0)*nvl(a.OT_TAX_RATE,0)/100,'999,999,999'),to_char(nvl(a.OT_TAX_CALC_AMT,0)*nvl(a.OT_TAX_RATE,0)/100,'999,999,990.99')) vat_amt ";
    SQL = SQL + " from tim_decl_dtl a   ";
    SQL = SQL + "    left join tco_item c on a.tco_item_pk = c.pk  ";
    SQL = SQL + "    left join tim_decl_mst e on a.tim_decl_mst_pk=e.pk  ";
    SQL = SQL + "    left join (select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b  ";
    SQL = SQL + "                where TCO_ABCODEGRP_PK=b.pk and b.id='COAB0080'  ";
    SQL = SQL + "                    and a.del_if=0 and b.del_if=0 order by a.CODE) m on item_origin=m.code ";
    SQL = SQL + " where a.del_if = 0  ";
    SQL = SQL + "    and a.tim_decl_mst_pk='" + pk + "'";

    DataTable dtItem = ESysLib.TableReadOpen(SQL);
    
    Response.ContentType = "application/vnd.ms-excel";	 	
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_ephd00010_decl_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_ephd00010_decl_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_ephd00010_decl_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Linh</o:Author>
  <o:LastAuthor>NgaLe</o:LastAuthor>
  <o:LastPrinted>2008-07-08T02:04:52Z</o:LastPrinted>
  <o:Created>2006-12-29T07:12:59Z</o:Created>
  <o:LastSaved>2008-07-08T02:06:27Z</o:LastSaved>
  <o:Company>Vina Genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:0in 0in 0in 0in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
	mso-horizontal-page-align:center;
	mso-vertical-page-align:center;}
.font7
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font13
	{color:black;
	font-size:8.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font14
	{color:black;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma;
	mso-generic-font-family:auto;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\.mm\\\.yy";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\.mm\\\.yy";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl62
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl66
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;}
.xl72
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl80
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl81
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;}
.xl82
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl83
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl84
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl85
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl86
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl87
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\.mm\\\.yy";
	text-align:left;
	vertical-align:middle;}
.xl89
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\.mm\\\.yy";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl90
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl92
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl93
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl94
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl95
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\.mm\\\.yy";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl96
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\.mm\\\.yy";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl97
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl99
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl100
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;}
.xl101
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl102
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl103
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl104
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl105
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl106
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl107
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl108
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl109
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl110
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl111
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;}
.xl112
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl113
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl114
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl115
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl116
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl117
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl118
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl119
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl120
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;
	white-space:normal;}
.xl121
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl122
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid black;
	white-space:normal;}
.xl123
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl124
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl125
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;}
.xl126
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl127
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl128
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl129
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl130
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl131
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl132
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl133
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl134
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl135
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:justify;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;
	white-space:normal;}
.xl136
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:justify;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid black;
	white-space:normal;}
.xl137
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl138
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl139
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl140
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl141
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl142
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl143
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl144
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl145
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl146
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl147
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl148
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl149
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl150
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl151
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl152
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl153
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl154
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl155
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl156
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl157
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl158
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl159
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl160
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline black;}
.xl161
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl162
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl163
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl164
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline black;}
.xl165
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl166
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl167
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl168
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl169
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline black;}
.xl170
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl171
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl172
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline black;}
.xl173
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl174
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl175
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl176
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl177
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;
	white-space:normal;}
.xl178
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl179
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl180
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl181
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl182
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline black;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl183
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl184
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl185
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl186
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl187
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl188
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline black;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl189
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl190
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl191
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl192
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl193
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline black;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl194
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl195
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl196
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline black;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl197
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl198
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl199
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl200
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl201
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl202
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl203
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl204
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl205
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl206
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl207
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl208
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl209
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl210
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl211
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;}
-->
</style>
<![if !supportAnnotations]><style id="dynCom" type="text/css"><!-- --></style>

<script language="JavaScript"><!--

function msoCommentShow(com_id,anchor_id) {
	if(msoBrowserCheck()) {
	   c = document.all(com_id);
	   a = document.all(anchor_id);
	   if (null != c) {
		var cw = c.offsetWidth;
		var ch = c.offsetHeight;
		var aw = a.offsetWidth;
		var ah = a.offsetHeight;
		var x = a.offsetLeft;
		var y = a.offsetTop;
		var el = a;
		while (el.tagName != "BODY") {
		   el = el.offsetParent;
		   x = x + el.offsetLeft;
		   y = y + el.offsetTop;
		   }		
		var bw = document.body.clientWidth;
		var bh = document.body.clientHeight;
		var bsl = document.body.scrollLeft;
		var bst = document.body.scrollTop;
		if (x + cw + ah/2 > bw + bsl && x + aw - ah/2 - cw >= bsl ) {
		   c.style.left = x + aw - ah / 2 - cw; 
		}
		else {
		   c.style.left = x + ah/2; 
		}
		if (y + ch + ah/2 > bh + bst && y + ah/2 - ch >= bst ) {
	 	   c.style.top = y + ah/2 - ch;
		} 
		else {
		   c.style.top = y + ah/2;
		}
		c.style.visibility = "visible";
	   }
	}
}

function msoCommentHide(com_id) {
	if(msoBrowserCheck()) {
	  c = document.all(com_id)
	  if (null != c) {
	    c.style.visibility = "hidden";
	    c.style.left = "-10000";
	    c.style.top = "-10000";
	  }
	}
}

function msoBrowserCheck() {
 ms=navigator.appVersion.indexOf("MSIE");
 vers = navigator.appVersion.substring(ms+5, ms+6);
 ie4 = (ms>0) && (parseInt(vers) >=4);
 return ie4
}

if (msoBrowserCheck()) {
document.styleSheets.dynCom.addRule(".msocomspan1","position:absolute");
document.styleSheets.dynCom.addRule(".msocomspan2","position:absolute");
document.styleSheets.dynCom.addRule(".msocomspan2","left:-1.5ex");
document.styleSheets.dynCom.addRule(".msocomspan2","width:2ex");
document.styleSheets.dynCom.addRule(".msocomspan2","height:0.5em");
document.styleSheets.dynCom.addRule(".msocomanch","font-size:0.5em");
document.styleSheets.dynCom.addRule(".msocomanch","color:red");
document.styleSheets.dynCom.addRule(".msocomhide","display: none");
document.styleSheets.dynCom.addRule(".msocomtxt","visibility: hidden");
document.styleSheets.dynCom.addRule(".msocomtxt","position: absolute");        
document.styleSheets.dynCom.addRule(".msocomtxt","top:-10000");         
document.styleSheets.dynCom.addRule(".msocomtxt","left:-10000");         
document.styleSheets.dynCom.addRule(".msocomtxt","width: 33%");                 
document.styleSheets.dynCom.addRule(".msocomtxt","background: infobackground");
document.styleSheets.dynCom.addRule(".msocomtxt","color: infotext");
document.styleSheets.dynCom.addRule(".msocomtxt","border-top: 1pt solid threedlightshadow");
document.styleSheets.dynCom.addRule(".msocomtxt","border-right: 2pt solid threedshadow");
document.styleSheets.dynCom.addRule(".msocomtxt","border-bottom: 2pt solid threedshadow");
document.styleSheets.dynCom.addRule(".msocomtxt","border-left: 1pt solid threedlightshadow");
document.styleSheets.dynCom.addRule(".msocomtxt","padding: 3pt 3pt 3pt 3pt");
document.styleSheets.dynCom.addRule(".msocomtxt","z-index: 100");
}

// -->
</script>
<![endif]><!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>95</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:CodeName>Sheet1</x:CodeName>
     <x:PageBreakZoom>100</x:PageBreakZoom>
     <x:Selected/>
     <x:LeftColumnVisible>1</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
       <x:RangeSelection>$B$14:$H$14</x:RangeSelection>
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
     <x:CodeName>Sheet2</x:CodeName>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>34</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:CodeName>Sheet3</x:CodeName>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8730</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1410</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Area</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$B$1:$O$47</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=722 style='border-collapse:
 collapse;table-layout:fixed;width:543pt'>
 <col class=xl24 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:0'>
 <col class=xl24 width=34 style='mso-width-source:userset;mso-width-alt:1243;
 width:26pt'>
 <col class=xl24 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 <col class=xl24 width=37 style='mso-width-source:userset;mso-width-alt:1353;
 width:28pt'>
 <col class=xl24 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl24 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl24 width=31 style='mso-width-source:userset;mso-width-alt:1133;
 width:23pt'>
 <col class=xl24 width=5 style='mso-width-source:userset;mso-width-alt:182;
 width:4pt'>
 <col class=xl24 width=58 style='mso-width-source:userset;mso-width-alt:2121;
 width:44pt'>
 <col class=xl24 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl24 width=59 style='mso-width-source:userset;mso-width-alt:2157;
 width:44pt'>
 <col class=xl24 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl24 width=8 style='mso-width-source:userset;mso-width-alt:292;
 width:6pt'>
 <col class=xl24 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl24 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <tr height=13 style='mso-height-source:userset;height:9.75pt'>
  <td colspan=15 height=13 class=xl24 width=722 style='height:9.75pt;
  width:543pt'></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl24 style='height:28.5pt'></td>
  <td colspan=3 class=xl211>HẢI QUAN VIỆT NAM</td>
  <td colspan=11 class=xl25 width=566 style='width:425pt'>TỜ KHAI HÀNG HÓA NHẬP
  KHẨU<br>
    <font class="font7">(Bản lưu người khai Hải quan)</font></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl24 style='height:9.0pt'></td>
  <td class=xl210>&nbsp;</td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl209 width=83 style='width:62pt'>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td colspan=3 class=xl64>TỔNG CỤC HẢI QUAN</td>
  <td class=xl207>&nbsp;</td>
  <td class=xl204 colspan=2 style='mso-ignore:colspan'>&nbsp;Tờ khai số:</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl205><% if(resultdata.Rows.Count>0) Response.Write (resultdata.Rows[0][2]); %></td>
  <td class=xl206>&nbsp;</td>
  <td class=xl205>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl206>&nbsp;</td>
  <td class=xl206>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl31 colspan=2 style='mso-ignore:colspan'>Cục Hải quan</td>
  <td class=xl28 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black'><% if(resultdata.Rows.Count>0) Response.Write (resultdata.Rows[0][12]); %></td>
  <td class=xl29 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>Ngày đăng ký:</td>
  <td class=xl24></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][3]); %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl31 colspan=2 style='mso-ignore:colspan'>Chi cục Hải quan</td>
  <td class=xl27>asdas</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl29 colspan=4 style='mso-ignore:colspan'>&nbsp;Số lượng phụ lục tờ
  khai:&nbsp;&nbsp;<% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][37]); %></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl208>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl24 style='height:17.25pt'></td>
  <td colspan=14 class=xl66 style='border-right:.5pt solid black'>A- PHẦN DÀNH
  CHO NGƯỜI KHAI HẢI QUAN KÊ KHAI VÀ TÍNH THUẾ</td>
 </tr>
 <tr class=xl35 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl35 style='height:18.0pt'></td>
  <td colspan=7 class=xl69 style='border-right:.5pt solid black'>1.Người nhập
  khẩu:</td>
  <td colspan=2 class=xl71 style='border-right:.5pt solid black;border-left:
  none'>5. Loại hình:</td>
  <td colspan=3 class=xl73 width=139 style='border-right:.5pt solid black;
  border-left:none;width:104pt'>6. Giấy phép (nếu có)</td>
  <td colspan=2 class=xl76 width=134 style='border-right:.5pt solid black;
  border-left:none;width:100pt'>7. Hợp đồng</td>
 </tr>
 <tr class=xl35 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl35 style='height:16.5pt'></td>
  <td colspan=7 class=xl85 style='border-right:.5pt solid black'><% if(resultdata.Rows.Count>0)  Response.Write (dt.Rows[0][0]); %>&nbsp;</td>
  <td colspan=2 class=xl81 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl38 width=59 style='width:44pt'>Số:</td>
  <td colspan=2 class=xl83 width=80 style='border-right:.5pt solid black;
  width:60pt' x:str><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][23]); %></td>
  <td class=xl38 width=51 style='width:38pt'>Số:</td>
  <td class=xl39 width=83 style='width:62pt'><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][23]); %></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td colspan=7 class=xl90 width=329 rowspan="2" style='border-right:.5pt solid black;
  width:248pt'><% if(resultdata.Rows.Count>0)  Response.Write (dt.Rows[0][1]); %></td>
  <td colspan=2 class=xl81 style='border-right:.5pt solid black;border-left:
  none'><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][44]); %></td>
  <td class=xl36>Ngày:</td>
  <td colspan=2 class=xl88 style='border-right:.5pt solid black' ><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][24]); %></td>
  <td class=xl36>Ngày:</td>
  <td class=xl40 ><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][27]); %></td>
 </tr>
 <tr height=41 style='mso-height-source:userset;height:30.75pt'>
  <td height=41 class=xl24 style='height:30.75pt'></td>
  <td colspan=2 class=xl93 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl42 width=59 style='width:44pt'>Ngày hết <br>
    hạn:</td>
  <td colspan=2 class=xl95 style='border-right:.5pt solid black' ><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][25]); %></td>
  <td class=xl42 width=51 style='width:38pt'>Ngày hết<br>
    <span style='mso-spacerun:yes'> </span>hạn:</td>
  <td class=xl43 ><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][28]); %></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl24 style='height:19.5pt'></td>
  <td colspan=7 class=xl69 style='border-right:.5pt solid black'>2.Người xuất
  khẩu</td>
  <td colspan=2 class=xl71 style='border-right:.5pt solid black;border-left:
  none'>8. Hoá đơn thương mại:</td>
  <td colspan=3 class=xl71 style='border-right:.5pt solid black;border-left:
  none'>9. Phương tiện vận tải</td>
  <td colspan=2 class=xl71 style='border-right:.5pt solid black;border-left:
  none'>10. Vận tải đơn</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td colspan=7 class=xl97 style='border-right:.5pt solid black'><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][14]); %></td>
  <td colspan=2 class=xl100 style='border-right:.5pt solid black;border-left:
  none'>Số:<% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][18]); %></td>
  <td colspan=3 class=xl100 style='border-right:.5pt solid black;border-left:
  none'>Số hiệu:<% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][31]); %></td>
  <td class=xl36>Số:</td>
  <td class=xl45><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][34]); %></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl24 style='height:16.5pt'></td>
  <td colspan=7 rowspan=2 class=xl101 width=329 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:248pt' x:str><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][51]); %><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl100 style='border-right:.5pt solid black;border-left:
  none'>Ngày:<% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][29]); %></td>
  <td colspan=3 class=xl100 style='border-right:.5pt solid black;border-left:
  none'><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][59]); %></td>
  <td colspan=2 class=xl100 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl24 style='height:17.25pt'></td>
  <td colspan=2 class=xl105 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl46>Ngày đến:</td>
  <td colspan=2 class=xl95 style='border-right:.5pt solid black' ><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][32]); %></td>
  <td class=xl46>Ngày:</td>
  <td class=xl43 ><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][35]); %></td>
 </tr>
 <tr class=xl35 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl35 style='height:19.5pt'></td>
  <td colspan=7 class=xl107 width=329 style='border-right:.5pt solid black;
  width:248pt'>3. Người ủy thác</td>
  <td colspan=2 class=xl76 width=120 style='border-right:.5pt solid black;
  border-left:none;width:91pt'>11. Nước xuất khẩu</td>
  <td colspan=3 class=xl76 width=139 style='border-right:.5pt solid black;
  border-left:none;width:104pt' x:str="12. Cảng, địa điểm xếp hàng ">12. Cảng,
  địa điểm xếp hàng<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl76 width=134 style='border-right:.5pt solid black;
  border-left:none;width:100pt'>13. Cảng, địa điểm dỡ hàng</td>
 </tr>
 <tr class=xl35 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl35 style='height:18.0pt'></td>
  <td colspan=7 class=xl97 style='border-right:.5pt solid black'><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][16]); %></td>
  <td colspan=2 class=xl111 style='border-right:.5pt solid black;border-left:
  none'><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][46]); %></td>
  <td colspan=3 class=xl111 style='border-right:.5pt solid black;border-left:
  none'><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][56]); %></td>
  <td colspan=2 class=xl111 style='border-right:.5pt solid black;border-left:
  none'><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][57]); %></td>
 </tr>
 <tr class=xl35 height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl35 style='height:27.75pt'></td>
  <td colspan=7 class=xl113 width=329 style='border-right:.5pt solid black;
  width:248pt' x:str><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][55]); %><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl117 style='border-right:.5pt solid black;border-left:
  none'><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][45]); %>&nbsp;</td>
  <td colspan=3 class=xl117 style='border-right:.5pt solid black;border-left:
  none'><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][47]); %></td>
  <td colspan=2 class=xl117 style='border-right:.5pt solid black;border-left:
  none'><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][58]); %></td>
 </tr>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td height=39 class=xl24 style='height:29.25pt'></td>
  <td colspan=7 class=xl119 width=329 style='border-right:.5pt solid black;
  width:248pt'>4. Đại lý làm thủ tục<br>
    hải quan</td>
  <td colspan=2 class=xl76 width=120 style='border-right:.5pt solid black;
  border-left:none;width:91pt'>14. Điều kiện <br>
    giao hàng</td>
  <td colspan=3 class=xl76 width=139 style='border-right:.5pt solid black;
  border-left:none;width:104pt'>15. Đồng tiền <br>
    thanh toán&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][4]); %></td>
  <td colspan=2 class=xl76 width=134 style='border-right:.5pt solid black;
  border-left:none;width:100pt'>16. Phương thức<br>
    thanh toán</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td colspan=7 class=xl97 style='border-right:.5pt solid black'><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][10]); %></td>
  <td colspan=2 rowspan=3 class=xl120 width=120 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:91pt'><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][49]); %></td>
  <td colspan=3 class=xl125 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=2 rowspan=3 class=xl120 width=134 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:100pt'><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][54]); %></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td colspan=7 rowspan=2 class=xl129 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black' x:str><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][53]); %><span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl135 width=59 style='border-bottom:.5pt solid black;
  width:44pt'>Tỷ giá<br>
    <span style='mso-spacerun:yes'> </span>tính thuế:</td>
  <td colspan=2 rowspan=2 class=xl137 width=80 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:60pt' x:num><span
  style='mso-spacerun:yes'></span><% if(resultdata.Rows.Count>0)  Response.Write (resultdata.Rows[0][5]); %></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl24 style='height:14.25pt'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl24 style='height:25.5pt'></td>
  <td class=xl47>STT</td>
  <td colspan=3 class=xl142 width=203 style='border-right:.5pt solid black;
  border-left:none;width:153pt'>17. TÊN HÀNG<br>
    QUY CÁCH PHẨM CHẤT</td>
  <td colspan=3 class=xl144 width=92 style='border-right:.5pt solid black;
  border-left:none;width:69pt'>18. MÃ SỐ <br>
    HÀNG HÓA</td>
  <td class=xl48 width=58 style='width:44pt'>19.XUẤT XỨ</td>
  <td class=xl48 width=62 style='width:47pt'>20. SỐ LƯỢNG</td>
  <td class=xl48 width=59 style='width:44pt'>21. ĐƠN VỊ TÍNH</td>
  <td colspan=2 class=xl145 width=80 style='border-right:.5pt solid black;
  border-left:none;width:60pt'>22. ĐƠN GIÁ NGUYÊN TỆ</td>
  <td colspan=2 class=xl147 width=134 style='border-right:.5pt solid black;
  border-left:none;width:100pt'>23. TRỊ GIÁ<br>
    NGUYÊN TỆ</td>
 </tr>
 <%
     int i = 0;
     i = dtItem.Rows.Count;
      %>
 <tr height=23 style='mso-height-source:userset;height:17.45pt'>
  <td height=23 class=xl24 style='height:17.45pt'></td>
  <td class=xl178 x:num>1</td>
  <td colspan=3 class=xl179 style='border-right:.5pt hairline black;border-left:
  none' x:str><% if (i > 0) Response.Write(dtItem.Rows[0][0]); %><span style='mso-spacerun:yes'> </span><![if !supportAnnotations]><span
  class=msocomspan1><span class=msocomspan2 id="_anchor_1"
  onmouseover="msoCommentShow('_com_1','_anchor_1')"
  onmouseout="msoCommentHide('_com_1')" language=JavaScript><a
  class=msocomanch href="#_msocom_1" name="_msoanchor_1">[1]</a></span></span><![endif]></td>
  <td colspan=3 class=xl182 style='border-right:.5pt hairline black;border-left:
  none'><% if (i > 0) Response.Write(dtItem.Rows[0][1]); %></td>
  <td class=xl183><% if (i > 0) Response.Write(dtItem.Rows[0][2]); %></td>
  <td class=xl184 x:num><span style='mso-spacerun:yes'> </span><% if (i > 0) Response.Write(dtItem.Rows[0][3]); %> </td>
  <td class=xl185><% if (i > 0) Response.Write(dtItem.Rows[0][4]); %></td>
  <td colspan=2 class=xl186 style='border-right:.5pt hairline black;border-left:
  none' x:num><span style='mso-spacerun:yes'> </span><% if (i > 0) Response.Write(dtItem.Rows[0][5]); %></td>
  <td colspan=2 class=xl188 style='border-right:.5pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'> </span><% if (i > 0) Response.Write(dtItem.Rows[0][6]); %></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.45pt'>
  <td height=23 class=xl24 style='height:17.45pt'></td>
  <td class=xl178 x:num>2</td>
  <td colspan=3 class=xl190 style='border-right:.5pt hairline black;border-left:
  none' x:str><% if (i > 1) Response.Write(dtItem.Rows[1][0]); %><span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl193 style='border-right:.5pt hairline black;border-left:
  none'><% if (i > 1) Response.Write(dtItem.Rows[1][1]); %></td>
  <td class=xl183><% if (i > 1) Response.Write(dtItem.Rows[1][2]); %></td>
  <td class=xl184 x:num><span style='mso-spacerun:yes'> </span><% if (i > 1) Response.Write(dtItem.Rows[1][3]); %> </td>
  <td class=xl185><% if (i > 1) Response.Write(dtItem.Rows[1][4]); %></td>
  <td colspan=2 class=xl194 style='border-right:.5pt hairline black;border-left:
  none' x:num><span style='mso-spacerun:yes'> </span><% if (i > 1) Response.Write(dtItem.Rows[1][5]); %> </td>
  <td colspan=2 class=xl196 style='border-right:.5pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'> </span><% if (i > 1) Response.Write(dtItem.Rows[1][6]); %> </td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.45pt'>
  <td height=23 class=xl24 style='height:17.45pt'></td>
  <td class=xl178 x:num>3</td>
  <td colspan=3 class=xl190 style='border-right:.5pt hairline black;border-left:
  none' x:str><% if (i > 2) Response.Write(dtItem.Rows[2][0]); %><span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl193 style='border-right:.5pt hairline black;border-left:
  none'><% if (i > 2) Response.Write(dtItem.Rows[2][1]); %></td>
  <td class=xl183><% if (i > 2) Response.Write(dtItem.Rows[2][2]); %></td>
  <td class=xl184 x:num><span style='mso-spacerun:yes'> </span><% if (i > 2) Response.Write(dtItem.Rows[2][3]); %> </td>
  <td class=xl185><% if (i > 2) Response.Write(dtItem.Rows[2][4]); %></td>
  <td colspan=2 class=xl194 style='border-right:.5pt hairline black;border-left:
  none' x:num><span style='mso-spacerun:yes'> </span><% if (i > 2) Response.Write(dtItem.Rows[2][5]); %> </td>
  <td colspan=2 class=xl196 style='border-right:.5pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'> </span><% if (i > 2) Response.Write(dtItem.Rows[2][6]); %> </td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td colspan=10 class=xl198>Tinh toan</td>
  <td class=xl200>Cộng:</td>
  <td class=xl201></td>
  <td colspan=2 class=xl202 style='border-right:.5pt solid black' x:num
  x:fmla="=SUM(N25:O27)"><span style='mso-spacerun:yes'> </span> </td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl51>&nbsp;</td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl52>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td rowspan=2 class=xl148 style='border-bottom:.5pt solid black'>STT</td>
  <td colspan=4 class=xl151 style='border-right:.5pt solid black;border-left:
  none'>24. THUẾ NHẬP KHẨU</td>
  <td colspan=6 class=xl153 style='border-right:.5pt solid black;border-left:
  none'>25. THUẾ GTGT(HOẶC TTĐB)</td>
  <td colspan=3 class=xl153 style='border-right:.5pt solid black;border-left:
  none'>26. THU KHÁC</td>
 </tr>
 <tr height=48 style='height:36.0pt'>
  <td height=48 class=xl24 style='height:36.0pt'></td>
  <td class=xl53>Trị giá tính thuế</td>
  <td class=xl54 width=37 style='width:28pt'>Thuế suất<br>
    (%)</td>
  <td colspan=2 class=xl66 style='border-right:.5pt solid black;border-left:
  none'>Tiền thuế</td>
  <td colspan=3 class=xl154 style='border-right:.5pt solid black;border-left:
  none'>Trị giá tính thuế</td>
  <td class=xl54 width=62 style='width:47pt'>Thuế suất<br>
    (%)</td>
  <td colspan=2 class=xl66 style='border-right:.5pt solid black;border-left:
  none'>Tiền thuế</td>
  <td colspan=2 class=xl155 width=59 style='border-right:.5pt solid black;
  border-left:none;width:44pt'>Tỷ lệ<br>
    (%)</td>
  <td class=xl55 width=83 style='width:62pt'>Số tiền</td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.45pt'>
  <td height=23 class=xl24 style='height:17.45pt'></td>
  <td class=xl49 x:num>1</td>
  <td class=xl56><% if (i > 1) Response.Write(dtItem.Rows[0][7]); %></td>
  <td class=xl56><% if (i > 1) Response.Write(dtItem.Rows[0][8]); %></td>
  <td colspan=2 class=xl158 style='border-right:.5pt hairline black;border-left:
  none'><% if (i > 1) Response.Write(dtItem.Rows[0][9]); %></td>
  <td colspan=3 class=xl160 style='border-right:.5pt hairline black;border-left:
  none'><% if (i > 1) Response.Write(dtItem.Rows[0][10]); %></td>
  <td class=xl56><% if (i > 1) Response.Write(dtItem.Rows[0][11]); %></td>
  <td colspan=2 class=xl158 style='border-right:.5pt hairline black;border-left:
  none'><% if (i > 1) Response.Write(dtItem.Rows[0][12]); %></td>
  <td colspan=2 class=xl160 style='border-right:.5pt hairline black;border-left:
  none'><% if (i > 1) Response.Write(dtItem.Rows[0][13]); %></td>
  <td class=xl57><% if (i > 1) Response.Write(dtItem.Rows[0][14]); %></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.45pt'>
  <td height=23 class=xl24 style='height:17.45pt'></td>
  <td class=xl49 x:num>2</td>
  <td class=xl50><% if (i > 2) Response.Write(dtItem.Rows[1][7]); %></td>
  <td class=xl50><% if (i > 2) Response.Write(dtItem.Rows[1][8]); %></td>
  <td colspan=2 class=xl162 style='border-right:.5pt hairline black;border-left:
  none'><% if (i > 2) Response.Write(dtItem.Rows[1][9]); %></td>
  <td colspan=3 class=xl164 style='border-right:.5pt hairline black;border-left:
  none'><% if (i > 2) Response.Write(dtItem.Rows[1][10]); %></td>
  <td class=xl50><% if (i > 2) Response.Write(dtItem.Rows[1][11]); %></td>
  <td colspan=2 class=xl162 style='border-right:.5pt hairline black;border-left:
  none'><% if (i > 2) Response.Write(dtItem.Rows[1][12]); %></td>
  <td colspan=2 class=xl164 style='border-right:.5pt hairline black;border-left:
  none'><% if (i > 2) Response.Write(dtItem.Rows[1][13]); %></td>
  <td class=xl58><% if (i > 2) Response.Write(dtItem.Rows[1][14]); %></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.45pt'>
  <td height=23 class=xl24 style='height:17.45pt'></td>
  <td class=xl49 x:num>3</td>
  <td class=xl50><% if (i > 3) Response.Write(dtItem.Rows[2][7]); %></td>
  <td class=xl50><% if (i > 3) Response.Write(dtItem.Rows[2][8]); %></td>
  <td colspan=2 class=xl162 style='border-right:.5pt hairline black;border-left:
  none'><% if (i > 3) Response.Write(dtItem.Rows[2][9]); %></td>
  <td colspan=3 class=xl164 style='border-right:.5pt hairline black;border-left:
  none'><% if (i > 3) Response.Write(dtItem.Rows[2][10]); %></td>
  <td class=xl50><% if (i > 3) Response.Write(dtItem.Rows[2][11]); %></td>
  <td colspan=2 class=xl162 style='border-right:.5pt hairline black;border-left:
  none'><% if (i > 3) Response.Write(dtItem.Rows[2][12]); %></td>
  <td colspan=2 class=xl164 style='border-right:.5pt hairline black;border-left:
  none'><% if (i > 3) Response.Write(dtItem.Rows[2][13]); %></td>
  <td class=xl58><% if (i > 3) Response.Write(dtItem.Rows[2][14]); %></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl24 style='height:17.25pt'></td>
  <td colspan=3 class=xl165 style='border-right:.5pt hairline black'>Cộng:</td>
  <td colspan=2 class=xl169 style='border-right:.5pt hairline black;border-left:
  none' x:num x:fmla="=SUM(E32:F34)"></td>
  <td colspan=4 class=xl169 style='border-right:.5pt hairline black;border-left:
  none'>&nbsp;</td>
  <td colspan=2 class=xl172 style='border-right:.5pt hairline black;border-left:
  none' x:num x:fmla="=SUM(K32:L34)"></td>
  <td colspan=3 class=xl172 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=SUM(O32:O34)"></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 class=xl24 style='height:7.5pt'></td>
  <td class=xl51>&nbsp;</td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl52>&nbsp;</td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl27 style='height:15.75pt'></td>
  <td colspan=14 class=xl64 style='border-right:.5pt solid black'>27. Tổng số
  tiền thuế và thu khác(ô 24+25+26): Bằng số</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl27 style='height:18.75pt'></td>
  <td colspan=14 class=xl64 style='border-right:.5pt solid black'>Bằng chữ 
  <%=CommondLib.IntegerToWords (100) %>......................................................................</td>
 </tr>
 <tr height=9 style='mso-height-source:userset;height:6.75pt'>
  <td height=9 class=xl27 style='height:6.75pt'></td>
  <td class=xl59>&nbsp;</td>
  <td colspan=12 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl60>&nbsp;</td>
 </tr>
 <tr class=xl35 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl36 style='height:18.0pt'></td>
  <td colspan=2 class=xl69>28. Chứng từ kèm:</td>
  <td class=xl37>:</td>
  <td class=xl37>Bản chính</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37 colspan=3 style='mso-ignore:colspan;border-right:.5pt solid black'>Bản
  sao</td>
  <td colspan=6 rowspan=2 class=xl76 width=335 style='border-right:.5pt solid black;
  width:251pt'>29. Tôi xin cam đoan chịu trách nhiệm trước pháp luật về những
  nội dung khai báo trong tờ khai này.</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl27 style='height:17.1pt'></td>
  <td colspan=2 class=xl64 x:str="'- Hợp đồng thương mại">- Hợp đồng thương mại</td>
  <td class=xl27>:</td>
  <td class=xl27>..............</td>
  <td class=xl27></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan;border-right:.5pt solid black'>..............</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl27 style='height:17.1pt'></td>
  <td class=xl59 colspan=2 style='mso-ignore:colspan'
  x:str="'- Hóa đơn thương mại   ">- Hóa đơn thương mại<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl27>:</td>
  <td class=xl27>..............</td>
  <td class=xl27></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan;border-right:.5pt solid black'>..............</td>
  <td class=xl41></td>
  <td class=xl27 colspan=4 style='mso-ignore:colspan'>Ngày ............
  tháng.............Năm</td>
  <td class=xl62>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl27 style='height:17.1pt'></td>
  <td class=xl59 colspan=2 style='mso-ignore:colspan'
  x:str="'- Bản kê chi tiết              ">- Bản kê chi tiết<span
  style='mso-spacerun:yes'>              </span></td>
  <td class=xl27>:</td>
  <td class=xl27>..............</td>
  <td class=xl27></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan;border-right:.5pt solid black'>..............</td>
  <td class=xl27></td>
  <td class=xl24></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl61>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl27 style='height:17.1pt'></td>
  <td class=xl59 colspan=2 style='mso-ignore:colspan'
  x:str="'- Vận tải đơn                  ">- Vận tải đơn<span
  style='mso-spacerun:yes'>                  </span></td>
  <td class=xl27>:</td>
  <td class=xl27>..............</td>
  <td class=xl27></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan;border-right:.5pt solid black'>..............</td>
  <td colspan=5 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl60>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl27 style='height:17.1pt'></td>
  <td class=xl59 colspan=2 style='mso-ignore:colspan'
  x:str="'-                                        ">-<span
  style='mso-spacerun:yes'>                                      </span><span
  style='display:none'><span style='mso-spacerun:yes'>  </span></span></td>
  <td class=xl27>:</td>
  <td class=xl27>..............</td>
  <td class=xl27></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan;border-right:.5pt solid black'>..............</td>
  <td colspan=5 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl60>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl27 style='height:17.1pt'></td>
  <td class=xl59 colspan=2 style='mso-ignore:colspan'
  x:str="'-                                        ">-<span
  style='mso-spacerun:yes'>                                      </span><span
  style='display:none'><span style='mso-spacerun:yes'>  </span></span></td>
  <td class=xl27>:</td>
  <td class=xl27>..............</td>
  <td class=xl27></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan;border-right:.5pt solid black'>..............</td>
  <td colspan=5 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl60>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl32 colspan=6 style='mso-ignore:colspan;border-right:.5pt solid black'>(Người
  khai báo ghi rõ họ tên, chức danh, ký tên và đóng dấu)</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=0></td>
  <td width=34 style='width:26pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=31 style='width:23pt'></td>
  <td width=5 style='width:4pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=8 style='width:6pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=83 style='width:62pt'></td>
 </tr>
 <![endif]>
</table>

<div style='mso-element:comment-list'><![if !supportAnnotations]>

<hr class=msocomhide align=left size=1 width="33%">

<![endif]>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_1" class=msocomtxt
onmouseover="msoCommentShow('_com_1','_anchor_1')"
onmouseout="msoCommentHide('_com_1')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_1"
name="_msocom_1">[1]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shapetype id="_x0000_t202" coordsize="21600,21600" o:spt="202" path="m,l,21600r21600,l21600,xe">
  <v:stroke joinstyle="miter"/>
  <v:path gradientshapeok="t" o:connecttype="rect"/>
 </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t202" style='position:absolute;
  margin-left:134.25pt;margin-top:-393.75pt;width:112.5pt;height:55.5pt;
  z-index:1;visibility:hidden' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>24</x:Row>
   <x:Column>2</x:Column>
   <x:Author>Linh</x:Author>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s1025" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font13">Linh:</font><font class="font14"><br>
</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

</div>

</body>


</html>
