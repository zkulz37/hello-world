<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% Response.ContentType = "application/msword"; %>
<% ESysLib.SetUser("imex");%>

<%    
    string l_contract_pk, l_curr, SQL, l_curr_nm = "", com_pk="";
    string l_contr_no="", l_contr_dt="", l_exp_date="", l_ship_dt="", l_item_origin="", l_pay_method="";
    string l_seller_name="", l_seller_add="", l_account="", l_buyer_name="", l_buyer_add="", l_buyer_fax="";
    string l_buyer_tel = "", l_bank = "", l_swift_no = "", l_quality = "", l_transshipment = "", l_packing = "";
    string l_partial_shipment = "", l_percent_of_paid = "", l_shipping_doc = "", l_insurance = "", l_complaint = "";
    string l_force_majeure="", l_arbitration ="", l_other_clauses="", l_seller_ref="", l_buyer_ref="", l_amount="";
    string l_remark="", l_transport="", l_seller_fax="", l_seller_tel ="", l_port_of_ship="", l_port_of_des="", l_word="";
    string   seller_tax="";
    double l_tt_mount = 0;
        
    l_contract_pk = Request.QueryString["contract_pk"];
	l_curr = Request.QueryString["curr"];
    com_pk = Request.QueryString["com_pk"];

    SQL = "select partner_name, addr1, phone_no ,fax_no, tax_code " +
         "        from tco_company " +
         "        where pk= '" + com_pk + "'";
    DataTable dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count > 0)
    {
        l_seller_name = (string)dt.Rows[0][0].ToString();
        l_seller_add = (string)dt.Rows[0][1].ToString();
        l_seller_tel = (string)dt.Rows[0][2].ToString();
        l_seller_fax = (string)dt.Rows[0][3].ToString();
        seller_tax = (string)dt.Rows[0][4].ToString();
    }    
    
	SQL = "select CONTR_NO, to_char(to_date(CONTR_DATE,'yyyymmdd'),'dd/mm/yyyy') as contr_date    " + 
        "                    , to_char(to_date(EXP_DATE,'yyyymmdd'),'Mon ddth, YYYY') as exp_date    " +
        "                    , nvl(SHIP_REMARK,to_char(to_date(SHIPMENT_DATE,'yyyymmdd'),'Mon ddth, YYYY')) as ship_date    " +
        "                    , s3.COUNTRY_NM ITEM_ORGIN,  s1.code_nm pay_method   " +
        "                    , vendor.partner_name seller_name, v.addr_nm2 seller_add, v.bank_account     " +
        "                    , nvl(ship.partner_name,comp.partner_name) buyer_name, v.addr_nm1 buy_add  " +
        "                    , nvl(ship.fax_no,paid.fax_no) buyer_fax, nvl(ship.phone_no,paid.phone_no) buyer_tel  " +
        "                    , paid.partner_name, bank.partner_name bank, vendor.ven_swift_no swift_no  " +
        "                    , v.quality, v.packing, v.transshipment, v.partial_shipment  " +
        "                    , v.percent_of_paid,  REPLACE(v.shipping_doc, CHR (10), '<br>'), REPLACE(v.insurance, CHR (10), '<br>'), REPLACE(v.complaint, CHR (10), '<br>')  " +
        "                    , REPLACE(v.force_majeure, CHR (10), '<br>'), REPLACE(v.arbitration, CHR (10), '<br>'), REPLACE(v.other_clauses , CHR (10), '<br>') " +
        "                    , vendor.represented_by seller_ref, ship.represented_by buyer_ref, vendor.fax_no seller_fax, vendor.phone_no seller_tel " +
        "                    , v1.port_nm discharge_port, v2.port_nm loading_port, s2.code_nm transport_by,  v.description " +
        "                    , decode(TR_CCY,'VND', to_char(nvl(TOT_AMT,0),'999,999,999'),to_char(nvl(TOT_AMT,0),'999,999,999.99')), nvl(TOT_AMT,0) " +
        "             from imex.tex_contr_mst v, comm.tco_buspartner ship, tco_company comp   " +
        "                    , comm.TCO_BUSPARTNER vendor, comm.TCO_BUSPARTNER paid     " +
        "                    , comm.TCO_BUSPARTNER bank, tie_port v1, tie_port v2     " +
        "                    ,(  SELECT code, code_nm      " +
        "                        FROM comm.tco_abcode a, comm.tco_abcodegrp b      " +
        "                        WHERE a.tco_abcodegrp_pk = b.pk  AND b.ID = 'ACCR0020'     " +
        "                             AND a.use_if = 1 AND a.del_if = 0 AND b.del_if = 0     " +
        "                    ) s1  " +
        "                    ,(  SELECT code, code_nm      " +
        "                        FROM comm.tco_abcode a, comm.tco_abcodegrp b      " +
        "                        WHERE a.tco_abcodegrp_pk = b.pk  AND b.ID = 'IEAB0020'     " +
        "                             AND a.use_if = 1 AND a.del_if = 0 AND b.del_if = 0     " +
        "                    ) s2           " +
        "                    ,tie_country s3           " +
        "             where v.del_if=0     " +
        "                and TCO_BUSPARTNER_PK = ship.pk(+)    " +
        "                and TCO_BUSPARTNER_PK1 = vendor.pk     " +
        "                and TCO_BUSPARTNER_PK = paid.pk(+)   " +
        "                and TCO_BUSPARTNER_PK = comp.pk(+)   " +
        "                and TCO_BUSPARTNER_PK4 = bank.pk(+)  " +
        "                and upper(PAY_TERM) = upper(s1.code(+))  " +
        "                and upper(transport_by) = upper(s2.code(+))  " +
        "                and plc_discharge =  v1.port_cd(+) " +
        "                and plc_loading =  v2.port_cd(+) " +
        "                and upper(ITEM_ORGIN) = upper(s3.COUNTRY_CD2(+))" +
        "                and v.pk= '" + l_contract_pk + "'";

    dt= ESysLib.TableReadOpen(SQL);

    SQL = " select item_code, item_name,  v3.uom_nm   " +
        "   ,  to_char(nvl(v.qty,0),'999,999,990.99') qty " +
        "   , decode('" + l_curr + "','VND',to_char(nvl(v.u_price,0),'999,999,999'), to_char(nvl(v.u_price,0),'999,999,990.99')) price" +        
        "   , decode('" + l_curr + "','VND',to_char(nvl(v.u_price,0)* nvl(v.qty,0)/nvl(v3.cnv_ratio,1),'999,999,999'), to_char(nvl(v.u_price,0)* nvl(v.qty,0)/nvl(v3.cnv_ratio,1),'999,999,990.99')) amt" +
        "   , decode(nvl(v3.CNV_RATIO,1),1,'',to_char(nvl(v3.CNV_RATIO,1),'9,999')) || ' ' || v3.UOM_NM p_unit " + 
        "  from imex.tex_contr_dtl v, comm.tco_item v2, comm.tco_uom v3  " +
        "  where v.del_if=0   " +
        "  and v.tco_item_pk=v2.pk  " +
        "  and v.unit_cd = v3.uom_code(+) " +
        "  and v.tex_contr_mst_pk = '" + l_contract_pk + "' " +
        "  order by v.pk  ";

    DataTable dtDetail = ESysLib.TableReadOpen(SQL);
    
    if (dt.Rows.Count  >0 )
    {
        l_contr_no= (string)dt.Rows[0][0].ToString() ;
        l_contr_dt = (string)dt.Rows[0][1].ToString();
        l_exp_date = (string)dt.Rows[0][2].ToString();
        l_ship_dt = (string)dt.Rows[0][3].ToString();
        l_item_origin = (string)dt.Rows[0][4].ToString();
        l_pay_method = (string)dt.Rows[0][5].ToString();
        //l_seller_name = (string)dt.Rows[0][6].ToString();
        //l_seller_add = (string)dt.Rows[0][7].ToString();
        l_account = (string)dt.Rows[0][8].ToString();
        l_buyer_name = (string)dt.Rows[0][9].ToString();
        l_buyer_add = (string)dt.Rows[0][10].ToString();
        l_buyer_fax = (string)dt.Rows[0][11].ToString();
        l_buyer_tel = (string)dt.Rows[0][12].ToString();
        l_bank = (string)dt.Rows[0][14].ToString();
        l_swift_no = (string)dt.Rows[0][15].ToString();
        l_quality = (string)dt.Rows[0][16].ToString();
        l_transshipment = (string)dt.Rows[0][18].ToString();
        l_packing = (string)dt.Rows[0][17].ToString();
        l_complaint = (string)dt.Rows[0][23].ToString();
        l_partial_shipment = (string)dt.Rows[0][19].ToString();
        l_percent_of_paid = (string)dt.Rows[0][20].ToString();
        l_shipping_doc = (string)dt.Rows[0][21].ToString();
        l_insurance = (string)dt.Rows[0][22].ToString();
        l_force_majeure = (string)dt.Rows[0][24].ToString();
        l_arbitration = (string)dt.Rows[0][25].ToString();
        l_other_clauses = (string)dt.Rows[0][26].ToString();
        l_seller_ref = (string)dt.Rows[0][27].ToString();
        l_buyer_ref = (string)dt.Rows[0][28].ToString();
        l_remark=(string)dt.Rows[0][34].ToString(); 
        l_transport=(string)dt.Rows[0][33].ToString(); 
        l_seller_fax=(string)dt.Rows[0][29].ToString(); 
        l_seller_tel =(string)dt.Rows[0][30].ToString(); 
        l_port_of_ship=(string)dt.Rows[0][32].ToString(); 
        l_port_of_des=(string)dt.Rows[0][31].ToString();
        l_amount =(string)dt.Rows[0][35].ToString();
    }

    SQL = "SELECT a.code, INITCAP(a.code_nm) " +
        "   FROM tco_abcode a, tco_abcodegrp b  " +
        "  WHERE tco_abcodegrp_pk = b.pk  " +
        "    AND b.ID = 'ACAB0110'  " +
        "    AND a.del_if = 0  " +
        "    AND b.del_if = 0 " +
        "    and a.code ='" + l_curr  + "' ";
    dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count > 0)
        l_curr_nm = (string)dt.Rows[0][1].ToString();    

%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:w="urn:schemas-microsoft-com:office:word"
xmlns:st1="urn:schemas-microsoft-com:office:smarttags"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 11">
<meta name=Originator content="Microsoft Word 11">
<link rel=File-List href="CONTRACT_files/filelist.xml">
<title>CONTRACT</title>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="country-region"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="State"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="City"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="place"/>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>NgaLe</o:Author>
  <o:LastAuthor>NgaLe</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>68</o:TotalTime>
  <o:Created>2008-09-29T09:24:00Z</o:Created>
  <o:LastSaved>2008-09-29T09:24:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>232</o:Words>
  <o:Characters>1325</o:Characters>
  <o:Company>Vinagenuwin</o:Company>
  <o:Lines>11</o:Lines>
  <o:Paragraphs>3</o:Paragraphs>
  <o:CharactersWithSpaces>1554</o:CharactersWithSpaces>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:GrammarState>Clean</w:GrammarState>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" LatentStyleCount="156">
 </w:LatentStyles>
</xml><![endif]--><!--[if !mso]><object
 classid="clsid:38481807-CA0E-42D2-BF39-B33AF135CC4D" id=ieooui></object>
<style>
st1\:*{behavior:url(#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:595.45pt 841.7pt;
	margin:27.35pt 55.45pt 45.35pt 81.0pt;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-vertical-page-align:middle;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
@page Section2
	{size:8.5in 11.0in;
	margin:.5in 63.0pt 45.0pt 81.0pt;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-vertical-page-align:middle;
	mso-paper-source:0;}
div.Section2
	{page:Section2;}
 /* List Definitions */
 @list l0
	{mso-list-id:1172794933;
	mso-list-type:hybrid;
	mso-list-template-ids:-1189729494 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1
	{mso-list-id:1351032853;
	mso-list-type:hybrid;
	mso-list-template-ids:448049414 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2
	{mso-list-id:1578517510;
	mso-list-type:hybrid;
	mso-list-template-ids:1420213994 1146797112 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l2:level1
	{mso-level-number-format:roman-upper;
	mso-level-tab-stop:.75in;
	mso-level-number-position:left;
	margin-left:.75in;
	text-indent:-.5in;}
@list l3
	{mso-list-id:1682925368;
	mso-list-type:hybrid;
	mso-list-template-ids:-751640432 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l3:level1
	{mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";
	mso-ansi-language:#0400;
	mso-fareast-language:#0400;
	mso-bidi-language:#0400;}
table.MsoTableGrid
	{mso-style-name:"Table Grid";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	border:solid windowtext 1.0pt;
	mso-border-alt:solid windowtext .5pt;
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-border-insideh:.5pt solid windowtext;
	mso-border-insidev:.5pt solid windowtext;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";
	mso-ansi-language:#0400;
	mso-fareast-language:#0400;
	mso-bidi-language:#0400;}
</style>
<![endif]-->
</head>

<body lang=EN-US style='tab-interval:.5in'>

<div class=Section1>

<p class=MsoNormal align=center style='text-align:center'><span
style='font-size:18.0pt'>CONTRACT<o:p></o:p></span></p>

<p class=MsoNormal align=center style='text-align:center'><b style='mso-bidi-font-weight:
normal'><span style='font-size:14.0pt'>No.</span></b><span style='font-size:
14.0pt'>:<span style='mso-spacerun:yes'>  </span><%=l_contr_no %><o:p></o:p></span></p>

<p class=MsoNormal style='tab-stops:right 5.5in'><span style='font-size:11.0pt'><span
style='mso-tab-count:1'>   </span>Date:
<%=l_contr_dt %><o:p></o:p></span></p>

<p class=MsoNormal><span style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='tab-stops:1.0in'><b style='mso-bidi-font-weight:normal'>The
seller <span style='mso-tab-count:1'>      </span>: <%=l_seller_name %><o:p></o:p></b></p>

<p class=MsoNormal style='margin-left:81.0pt;text-indent:-81.0pt;tab-stops:
1.0in'><span style='font-size:11.0pt'>Address <span style='mso-tab-count:1'>           </span>:
<%=l_seller_add%> <o:p></o:p></span></p>

<p class=MsoNormal style='tab-stops:1.0in'><span style='font-size:11.0pt'>Tel <span
style='mso-tab-count:1'>                  </span>: <%=l_seller_tel %><o:p></o:p></span></p>

<p class=MsoNormal style='tab-stops:1.0in'><span style='font-size:11.0pt'>Fax <span
style='mso-tab-count:1'>                  </span>: <%=l_seller_fax %><o:p></o:p></span></p>

<p class=MsoNormal style='tab-stops:1.0in'><span style='font-size:11.0pt'>Bank <span
style='mso-tab-count:1'>               </span>: <%=l_bank %><o:p></o:p></span></p>

<p class=MsoNormal style='tab-stops:1.0in'><span style='font-size:11.0pt'>Account
No <span style='mso-tab-count:1'>     </span>: <%=l_account %><o:p></o:p></span></p>

<p class=MsoNormal style='tab-stops:1.0in'><span style='font-size:11.0pt'>Represented
by<span style='mso-tab-count:1'>            </span>: <%=l_seller_ref %><o:p></o:p></span></p>

<p class=MsoNormal style='tab-stops:1.0in'><span style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='tab-stops:1.0in'><b style='mso-bidi-font-weight:normal'>The
Buyer</b> <span style='mso-tab-count:1'>     </span>: <%=l_buyer_name %></p>

<p class=MsoNormal style='margin-left:1.0in;text-indent:-1.0in;tab-stops:1.0in'><span
style='font-size:11.0pt'>Address<span style='mso-tab-count:1'>            </span>:
<%=l_buyer_add %> <o:p></o:p></span></p>

<p class=MsoNormal style='tab-stops:1.0in'><span style='font-size:11.0pt'>Tel <span
style='mso-tab-count:1'>                  </span>: <%=l_buyer_tel %><o:p></o:p></span></p>

<p class=MsoNormal style='tab-stops:1.0in'><span style='font-size:11.0pt'>Fax <span
style='mso-tab-count:1'>                  </span>: <%=l_buyer_fax %><o:p></o:p></span></p>

<p class=MsoNormal style='tab-stops:1.0in'><span style='font-size:11.0pt'>Represented
by<span style='mso-tab-count:1'></span>: <%=l_buyer_ref %><o:p></o:p></span></p>

<p class=MsoNormal><span style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span style='font-size:11.0pt'>After discussion, both parties
have agreed to sign this contract under the following terms and conditions:<o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:27.35pt;text-indent:-27.35pt;mso-list:l2 level1 lfo1;tab-stops:
list .25in'><![if !supportLists]><b style='mso-bidi-font-weight:normal'><span
style='font-size:11.0pt'><span style='mso-list:Ignore'><u>I.</u><span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span></b><![endif]><b
style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt'><u>COMMODITY-SPECIFICATION-QUANTITY-UNIT-PRICE</u><o:p></o:p></span></b></p>

<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;border:none;mso-border-top-alt:solid windowtext .5pt;
 mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;
 mso-yfti-tbllook:480;mso-padding-alt:0in 5.4pt 0in 5.4pt;mso-border-insideh:
 .5pt solid windowtext;mso-border-insidev:.5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:13.9pt'>
  <td style='border:solid windowtext 1.0pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:13.9pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:10.0pt'>No.<o:p></o:p></span></b></p>
  </td>
  <td style='border:solid windowtext 1.0pt;border-left:none;mso-border-left-alt:
  solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:13.9pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:10.0pt'>COMMODITY<o:p></o:p></span></b></p>
  </td>
  <td style='border:solid windowtext 1.0pt;border-left:none;mso-border-left-alt:
  solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:13.9pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:10.0pt'>SPECIFICATION<o:p></o:p></span></b></p>
  </td>
  <td style='border:solid windowtext 1.0pt;border-left:none;mso-border-left-alt:
  solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:13.9pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:10.0pt'>QUANTITY<o:p></o:p></span></b></p>
  </td>
  <td style='border:solid windowtext 1.0pt;border-left:none;mso-border-left-alt:
  solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:13.9pt'>
  <p class=MsoNormal align=center style='text-align:center'><st1:stockticker
  w:st="on"><b style='mso-bidi-font-weight:normal'><span style='font-size:10.0pt'>UNIT</span></b></st1:stockticker><b
  style='mso-bidi-font-weight:normal'><span style='font-size:10.0pt'> PRICE<o:p></o:p></span></b></p>
  </td>
  <td style='border:solid windowtext 1.0pt;border-left:none;mso-border-left-alt:
  solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:13.9pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:10.0pt'>AMOUNT<o:p></o:p></span></b></p>
  </td>
 </tr>
 <%
     for (int i = 0; i < dtDetail.Rows.Count ; i++)
     {
%>
 <tr style='mso-yfti-irow:1;height:16.6pt'>
  <td valign=bottom align="center" style='border:solid windowtext 1.0pt;border-top:none;
  mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:16.6pt'>
  <span style='font-size:10.0pt'><%=i+1 %> </span>
  </td>
  <td valign=bottom style='border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;
  border-right:solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .5pt;
  mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:16.6pt'>
  <p class=MsoNormal><span style='font-size:10.0pt'><%=dtDetail.Rows[i][1] %> <o:p></o:p></span></p>
  </td>
  <td valign=bottom style='border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;
  border-right:solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .5pt;
  mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:16.6pt'>
  <p class=MsoNormal><span style='font-size:10.0pt'><%=dtDetail.Rows[i][0] %> <o:p></o:p></span></p>
  </td>
  <td valign=bottom style='border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;
  border-right:solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .5pt;
  mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:16.6pt'>
  <p class=MsoNormal align=right style='text-align:right'><span
  style='font-size:10.0pt'><%=dtDetail.Rows[i][3] %> &nbsp;<%=dtDetail.Rows[i][2] %></span></p>
  </td>
  <td valign=bottom style='border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;
  border-right:solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .5pt;
  mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:16.6pt'>
  <p class=MsoNormal align=right style='text-align:right'><span
  style='font-size:10.0pt'><%=dtDetail.Rows[i][4]%>/<%=dtDetail.Rows[i][6]%></span></p>
  </td>
  <td valign=bottom style='border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;
  border-right:solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .5pt;
  mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:16.6pt'>
  <p class=MsoNormal align=right style='text-align:right'><span
  style='font-size:10.0pt'><%=dtDetail.Rows[i][5]  %></span></p>
  </td>
 </tr>
 <%} %> 
 <tr style='mso-yfti-irow:3;mso-yfti-lastrow:yes;height:16.6pt'>
  <td colspan=4 valign=bottom style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;
  mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:16.6pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:10.0pt'>TOTAL<o:p></o:p></span></b></p>
  </td>
  <td width=187 colspan=2 valign=bottom style='width:1.95in;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;
  mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:16.6pt'>
  <p class=MsoNormal align=right style='text-align:right'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:10.0pt'><%=l_amount %>(<%=l_curr %></span></b><span
  style='font-size:10.0pt'>)<o:p></o:p></span></p>
  </td>
 </tr>
</table>
<% 
    l_word = CommondLib.changeCurrencyToWords(l_amount);
     %>
<p class=MsoNormal style='margin-top:6.0pt'><span style='font-size:11.0pt'>Total
value: <%=l_curr_nm %>  <%Response.Write(l_word.Substring(0, 1).ToUpper());%><%Response.Write(l_word.Substring(1, l_word.Length-1).ToLower() );%>

<p class=MsoNormal><span style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-left:.25in;text-indent:-.25in;mso-list:l0 level1 lfo2;
tab-stops:list .25in left 1.5in'><![if !supportLists]><span style='font-size:
11.0pt'><span style='mso-list:Ignore'>1.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='font-size:11.0pt'>Manufacturer<span
style='mso-tab-count:1'>          </span>: <b style='mso-bidi-font-weight:
normal'><%=l_seller_name %></b><o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:.25in;text-indent:-.25in;mso-list:l0 level1 lfo2;
tab-stops:list .25in left 1.5in'><![if !supportLists]><span style='font-size:
11.0pt'><span style='mso-list:Ignore'>2.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='font-size:11.0pt'>Quality <span
style='mso-tab-count:1'>                   </span>: <%=l_quality %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:.25in;text-indent:-.25in;mso-list:l0 level1 lfo2;
tab-stops:list .25in left 1.5in'><![if !supportLists]><span style='font-size:
11.0pt'><span style='mso-list:Ignore'>3.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='font-size:11.0pt'>Country of origin<span
style='mso-tab-count:1'>     </span>: <%=l_item_origin %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:.25in;text-indent:-.25in;mso-list:l0 level1 lfo2;
tab-stops:list .25in left 1.5in'><![if !supportLists]><span style='font-size:
11.0pt'><span style='mso-list:Ignore'>4.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='font-size:11.0pt'>Packing <span
style='mso-tab-count:1'>                 </span>: <%=l_packing %> <o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:27.35pt;margin-bottom:.0001pt;text-indent:-27.35pt;mso-list:l2 level1 lfo1;
tab-stops:list .25in decimal 117.0pt'><![if !supportLists]><b style='mso-bidi-font-weight:
normal'><span style='font-size:11.0pt'><span style='mso-list:Ignore'><u>II.</u><span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp; </span></span></span></b><![endif]><b
style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt'><u>SHIPMENT</u><o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-left:.25in;text-indent:-.25in;mso-list:l1 level1 lfo4;
tab-stops:list .25in left 1.5in'><![if !supportLists]><span style='font-size:
11.0pt'><span style='mso-list:Ignore'>1.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='font-size:11.0pt'>Mode of
shipment<span style='mso-spacerun:yes'>   </span>: <%=l_transport %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:.25in;text-indent:-.25in;mso-list:l1 level1 lfo4;
tab-stops:list .25in left 1.5in'><![if !supportLists]><span style='font-size:
11.0pt'><span style='mso-list:Ignore'>2.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='font-size:11.0pt'>Date of shipment<span
style='mso-tab-count:1'>     </span>: <%=l_ship_dt %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:.25in;text-indent:-.25in;mso-list:l1 level1 lfo4;
tab-stops:list .25in left 1.5in'><![if !supportLists]><span style='font-size:
11.0pt'><span style='mso-list:Ignore'>3.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='font-size:11.0pt'>Port of
destination<span style='mso-tab-count:1'>   </span>: <%=l_port_of_des%><o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:.25in;text-indent:-.25in;mso-list:l1 level1 lfo4;
tab-stops:list .25in left 1.5in'><![if !supportLists]><span style='font-size:
11.0pt'><span style='mso-list:Ignore'>4.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='font-size:11.0pt'>Port of shipment<span
style='mso-tab-count:1'>      </span>: <%=l_port_of_ship %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:.25in;text-indent:-.25in;mso-list:l1 level1 lfo4;
tab-stops:list .25in left 1.5in'><![if !supportLists]><span style='font-size:
11.0pt'><span style='mso-list:Ignore'>5.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='font-size:11.0pt'>Transshipment<span
style='mso-tab-count:1'>         </span>: <%=l_transshipment %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:.25in;text-indent:-.25in;mso-list:l1 level1 lfo4;
tab-stops:list .25in left 1.5in'><![if !supportLists]><span style='font-size:
11.0pt'><span style='mso-list:Ignore'>6.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='font-size:11.0pt'>Partial shipment<span
style='mso-tab-count:1'>       </span>: <%=l_partial_shipment%><o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:.25in;text-indent:-.25in;mso-list:l1 level1 lfo4;
tab-stops:list .25in left 1.5in'><![if !supportLists]><span style='font-size:
11.0pt'><span style='mso-list:Ignore'>7.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='font-size:11.0pt'>Receiver<span
style='mso-tab-count:1'>                 </span> <b style='mso-bidi-font-weight:
normal'><%=l_buyer_name%></b><o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:1.5in;text-indent:-1.5in;tab-stops:1.5in'><span
style='font-size:11.0pt'><span style='mso-tab-count:1'>                                    </span>:
<%=l_buyer_add %> <o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:27.35pt;margin-bottom:.0001pt;text-indent:-27.35pt;mso-list:l2 level1 lfo1;
tab-stops:list .25in'><![if !supportLists]><b style='mso-bidi-font-weight:normal'><span
style='font-size:11.0pt'><span style='mso-list:Ignore'><u>III.</u><span
style='font:7.0pt "Times New Roman"'> </span></span></span></b><![endif]><b
style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt'><u>MODE OF
PAYMENT AND SHIPPING DOCUMENT</u><o:p></o:p></span></b></p>

<p class=MsoNormal><span style='font-size:11.0pt'><%=l_percent_of_paid %>% value of the
contract will be paid by <%=l_pay_method %>.<o:p></o:p></span></p>

<p class=MsoNormal style='tab-stops:1.0in'><span style='font-size:11.0pt'>In
favor of<span style='mso-tab-count:1'>        </span>: <%=l_seller_name %><o:p></o:p></span></p>

<p class=MsoNormal style='tab-stops:1.0in'><span style='font-size:11.0pt'>Bank<span
style='mso-tab-count:1'>                </span>: <%=l_bank %><o:p></o:p></span></p>

<p class=MsoNormal style='tab-stops:1.0in'><span style='font-size:11.0pt'>Account
No<span style='mso-tab-count:1'>      </span>: <%=l_account %><o:p></o:p></span></p>

<p class=MsoNormal style='tab-stops:1.0in'><span class=GramE><span
style='font-size:11.0pt'>SWIFT No.</span></span><span style='font-size:11.0pt'><span
style='mso-tab-count:1'>       </span>: <%=l_swift_no %><o:p></o:p></span></p>

<p class=MsoNormal style='tab-stops:1.0in'><span style='font-size:11.0pt'>Beneficiary<span
style='mso-tab-count:1'>       </span>: <%=l_seller_name%><o:p></o:p></span></p>

<p class=MsoNormal><span class=GramE><span style='font-size:11.0pt'>All banking
charge inside <st1:place w:st="on"><st1:country-region w:st="on">Vietnam</st1:country-region></st1:place>
for buyer’s account.</span></span><span style='font-size:11.0pt'><o:p></o:p></span></p>

<p class=MsoNormal><span style='font-size:11.0pt'>All banking charge outside <st1:country-region
w:st="on"><st1:place w:st="on">Vietnam</st1:place></st1:country-region> for
seller’ account.<o:p></o:p></span></p>
</div>

<span style='font-size:11.0pt;font-family:"Times New Roman";mso-fareast-font-family:
"Times New Roman";mso-ansi-language:EN-US;mso-fareast-language:EN-US;
mso-bidi-language:AR-SA'><br clear=all style='page-break-before:always;
mso-break-type:section-break'>
</span>

<div class=Section2>

<p class=MsoNormal ><span style='font-size:11.0pt'><u>Shipping
document:</u></span></p>

<span
style='font-size:11.0pt'><%=l_shipping_doc %></span>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify'><span
style='font-size:11.0pt'><u>Remark: </u><%=l_remark%><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:27.35pt;margin-bottom:.0001pt;text-indent:-27.35pt;mso-list:l2 level1 lfo1;
tab-stops:list .25in'><![if !supportLists]><b style='mso-bidi-font-weight:normal'><span
style='font-size:11.0pt'><span style='mso-list:Ignore'><u>IV.</u><span
style='font:7.0pt "Times New Roman"'>&nbsp; </span></span></span></b><![endif]><b
style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt'><u>INSURANCE</u><o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify'><span
style='font-size:11.0pt'><%=l_insurance %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:27.35pt;margin-bottom:.0001pt;text-indent:-27.35pt;mso-list:l2 level1 lfo1;
tab-stops:list .25in'><![if !supportLists]><b style='mso-bidi-font-weight:normal'><span
style='font-size:11.0pt'><span style='mso-list:Ignore'><u>>V.</u<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span></b><![endif]><b
style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt'><u>COMPLAINT</u><o:p></o:p></span></b></p>

<p class=MsoNormal style='text-align:justify'><span style='font-size:11.0pt;text-align:justify'><%=l_complaint %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:27.35pt;margin-bottom:.0001pt;text-indent:-27.35pt;mso-list:l2 level1 lfo1;
tab-stops:list .25in'><![if !supportLists]><b style='mso-bidi-font-weight:normal'><span
style='font-size:11.0pt'><span style='mso-list:Ignore'><u>VI.</u><span
style='font:7.0pt "Times New Roman"'>&nbsp; </span></span></span></b><![endif]><b
style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt'><u>FORCE
MAJEURE</u><o:p></o:p></span></b></p>

<p class=MsoNormal style='text-align:justify'><span style='font-size:11.0pt;text-align:justify'><%=l_force_majeure %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:27.35pt;margin-bottom:.0001pt;text-indent:-27.35pt;mso-list:l2 level1 lfo1;
tab-stops:list 27.0pt'><![if !supportLists]><b style='mso-bidi-font-weight:normal'><span
style='font-size:11.0pt'><span style='mso-list:Ignore'><u>VII.</u><span
style='font:7.0pt "Times New Roman"'>&nbsp;</span></span></span></b><![endif]><b
style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt'><u>ARBITRATION</u><o:p></o:p></span></b></p>

<p class=MsoNormal style='text-align:justify'><span style='font-size:11.0pt'><%=l_arbitration %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:27.35pt;margin-bottom:.0001pt;text-indent:-27.35pt;mso-list:l2 level1 lfo1;
tab-stops:list 27.0pt'><![if !supportLists]><b style='mso-bidi-font-weight:
normal'><span style='font-size:11.0pt'><span style='mso-list:Ignore'><u>VIII.</u><span
style='font:7.0pt "Times New Roman"'>&nbsp; </span></span></span></b><![endif]><b
style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt'><u>OTHER
CLAUSES</u><o:p></o:p></span></b></p>

<span
style='font-size:11.0pt'><%=l_other_clauses %></span>

<p class=MsoNormal><span style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='tab-stops:center 1.5in 5.0in'><span style='font-size:
11.0pt'><span style='mso-tab-count:1'>                     </span>FOR THE
SELLER <span style='mso-tab-count:1'>                                                      </span>FOR
THE BUYER<o:p></o:p></span></p>

<p class=MsoNormal style='tab-stops:center 1.5in 5.0in'><span style='font-size:
11.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='tab-stops:center 1.5in 5.0in'><span style='font-size:
11.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='tab-stops:center 1.5in 5.0in'><span style='font-size:
11.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='tab-stops:center 1.5in 5.0in'><span style='font-size:
11.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='tab-stops:center 1.5in 5.0in'><span style='font-size:
11.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='tab-stops:center 1.5in 5.0in'><span style='font-size:
11.0pt'><span style='mso-tab-count:1'>                             </span><span style='mso-tab-count:1'>    </span>
<o:p></o:p></span></p>

</div>

</body>

</html>
