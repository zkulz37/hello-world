<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% Response.ContentType = "application/msword"; %>
<% ESysLib.SetUser("imex");%>

<% 

    if (Request.QueryString["random"] == null) return;
            
    string l_invoice_pk, SQL, l_company_pk;
    string l_com_name = "", l_com_add = "";
    string l_vendor_name = "", l_vendor_add = "", l_ship_name = "", l_ship_add = "", l_notify_name = "";
    string l_notify_add = "", l_notify_tel = "", l_destination = "", l_loading_port = "", l_carrier_cd = "";
    string l_carrier_nm = "", l_ship_date="", l_invoice_no="", l_invoice_dt="", l_lc_no="", l_lc_dt="" ;
    string l_pay_meth = "", l_remark="", l_tot_amt="", l_curr="";    
    
    l_invoice_pk = Request.QueryString["pk"];
    
    l_company_pk = Request.QueryString["com_pk"];

    SQL = " select  a.partner_name, a.addr1  " +
        " from    tco_company a   " +
        " where pk='" + l_company_pk + "' ";
    System.Data.DataTable dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count > 0)
    { 
        l_com_name = (string)dt.Rows[0][0].ToString();
        l_com_add = (string)dt.Rows[0][1].ToString();        
    }
    
    SQL= " select co_invoice_no , to_char(to_date(co_invoice_date ,'yyyymmdd'),'MON. dd,yyyy') as inv_date     " +
        "        , vendor.partner_name, vendor.addr1, vendor.fax_no, vendor.phone_no, vendor.email_address     " +
        "        , nvl(ship.partner_name,comp.partner_name), nvl(ship.addr1,comp.addr1)   " +
        "        , nvl(ship.fax_no,comp.fax_no), nvl(ship.phone_no  ,comp.phone_no), v.pay_ccy " +
        "        , v.lc_no, to_char(to_date(v.lc_dt,'yyyymmdd'),'MON. dd,yyyy') lc_dt " +
        "        , v.carrier_code, v.carrier_name, to_char(to_date(v.ship_date,'yyyymmdd'),'MON. dd,yyyy') ship_date " +
        "        , v1.partner_name notify_name, v1.addr1 notify_add, v1.phone_no  " +
        "        , v2.port_nm plc_discharge, v3.port_nm plc_loading  " +
        "        , decode(v.pay_ccy, 'VND',to_char(v.tot_amt,'9,999,999'),to_char(v.tot_amt,'9,999,999.99')) tot_amt " +
        "        , s.code_nm pay_meth, v.description  " +
        " from imex.tim_cinv_mst_a v, comm.tco_buspartner ship " +
        "    , comm.tco_buspartner vendor ,tco_company comp   " +
        "    , comm.tco_buspartner v1 " +
        "    , tie_port v2, tie_port v3 " +
        "    ,( " +
        "        select   a.code, a.code_nm " +
        "               from tco_abcode a, tco_abcodegrp b " +
        "               where tco_abcodegrp_pk = b.pk " +
        "                     and b.id = 'ACCR0140' " +
        "                     and a.del_if = 0 " +
        "                     and b.del_if = 0 " +
        "    )s " +
        " where v.del_if=0      " +
        "    and tco_buspartner_pk1 = ship.pk (+)    " +
        "    and tco_buspartner_pk = vendor.pk(+)    " +
        "    and v.tco_buspartner_pk1=comp.pk(+)   " +
        "    and v.notify_pk = v1.pk (+)  " +
        "    and v.plc_discharge = v2.port_cd(+) " +
        "    and v.plc_loading = v3.port_cd(+) " +
        "    and upper(v.PAY_METH) = upper(s.code(+)) " +
        "    and comp.del_if(+)=0   " +
        "    and v.pk= '" +  l_invoice_pk + "'  ";
    
    dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count > 0)
    { 
        l_vendor_name = (string ) dt.Rows[0][2].ToString() ;
        l_vendor_add = (string)dt.Rows[0][3].ToString();
        l_ship_name = (string)dt.Rows[0][7].ToString();
        l_ship_add = (string)dt.Rows[0][8].ToString();
        l_notify_name = (string)dt.Rows[0][17].ToString();
        l_notify_add = (string)dt.Rows[0][18].ToString();
        l_notify_tel = (string)dt.Rows[0][19].ToString();
        l_destination = (string)dt.Rows[0][20].ToString();
        l_loading_port = (string)dt.Rows[0][21].ToString();
        l_carrier_cd = (string)dt.Rows[0][14].ToString();
        l_carrier_nm = (string)dt.Rows[0][15].ToString();
        l_ship_date = (string)dt.Rows[0][16].ToString();
        l_invoice_no = (string)dt.Rows[0][0].ToString();
        l_invoice_dt = (string)dt.Rows[0][1].ToString();
        l_lc_no = (string)dt.Rows[0][12].ToString();
        l_lc_dt = (string)dt.Rows[0][13].ToString();
        l_pay_meth = (string)dt.Rows[0][23].ToString();
        l_remark = (string)dt.Rows[0][24].ToString();
        l_tot_amt = (string)dt.Rows[0][22].ToString();
        l_curr = (string)dt.Rows[0][11].ToString();        
    }
    SQL = " select item_code, item_name,  v.unit_cd" +
               "        , decode('" + l_curr + "','VND',to_char(v.u_price,'9,999,999'),to_char(v.u_price,'9,999,999.99')) u_price" +
               "        , to_char(v.qty,'9,999,999.99')  " +
               "        , decode('" + l_curr + "','VND',to_char(nvl(v.u_price,0)* nvl(v.qty,0),'9,999,999'),to_char(nvl(v.u_price,0)* nvl(v.qty,0),'9,999,999.99')) amount , v.pk " +
               "        from imex.tim_cinv_dtl v, comm.tco_item v2  " +
               "        where v.del_if=0   " +
               "            and v.tco_item_pk=v2.pk  " +
               "            and v.tim_cinv_mst_a_pk = '" + l_invoice_pk + "' " +
               "        order by v.pk ";

    System.Data.DataTable dtDetail = ESysLib.TableReadOpen(SQL);

%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:w="urn:schemas-microsoft-com:office:word"
xmlns:st1="urn:schemas-microsoft-com:office:smarttags"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 11">
<meta name=Originator content="Microsoft Word 11">
<link rel=File-List href="SUHEUNG_INVOICE_files/filelist.xml">
<link rel=Edit-Time-Data href="SUHEUNG_INVOICE_files/editdata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<title><%=l_com_name %></title>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="PlaceName"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="PlaceType"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="stockticker"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="place"/>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>NgaLe</o:Author>
  <o:LastAuthor>NgaLe</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>134</o:TotalTime>
  <o:Created>2008-10-01T09:40:00Z</o:Created>
  <o:LastSaved>2008-10-01T09:40:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>158</o:Words>
  <o:Characters>906</o:Characters>
  <o:Company>Vinagenuwin</o:Company>
  <o:Lines>7</o:Lines>
  <o:Paragraphs>2</o:Paragraphs>
  <o:CharactersWithSpaces>1062</o:CharactersWithSpaces>
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
@page Section1
	{size:8.5in 11.0in;
	margin:.75in 1.25in 45.0pt 1.25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
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

<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 width=671
 style='width:502.9pt;margin-left:-.3in;border-collapse:collapse;border:none;
 mso-border-alt:solid windowtext .5pt;mso-yfti-tbllook:480;mso-padding-alt:
 0in 5.4pt 0in 5.4pt;mso-border-insideh:.5pt solid windowtext;mso-border-insidev:
 .5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes'>
  <td width=671 colspan=10 style='width:502.9pt;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-spacerun:yes'> </span><b style='mso-bidi-font-weight:normal'><span
  style='font-size:20.0pt'><%=l_com_name %><span style='mso-spacerun:yes'>  
  </span><o:p></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1'>
  <td width=671 colspan=10 valign=top style='width:502.9pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><%=l_com_add %></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2;height:25.15pt'>
  <td width=671 colspan=10 style='width:502.9pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:25.15pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:20.0pt'>COMMERCIAL
  INVOICE<o:p></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3;height:13.9pt'>
  <td width=301 colspan=4 rowspan=5 valign=top style='width:225.8pt;border:
  solid windowtext 1.0pt;border-top:none;mso-border-top-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:13.9pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'>Manufacture/Exporter<o:p></o:p></span></p>
  <p class=MsoNormal><span style='font-size:11.0pt'><%=l_vendor_name %></span> </p>
  <p class=MsoNormal><%=l_vendor_add %></p>
  </td>
  <td width=369 colspan=6 valign=top style='width:277.1pt;border:none;
  border-right:solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .5pt;
  mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;
  mso-border-left-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:13.9pt'>
  <p class=MsoNormal style='tab-stops:right 199.35pt'><span style='font-size:
  11.0pt'>No. &amp; date of invoice<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:4;height:15.25pt'>
  <td width=187 colspan=4 valign=top style='width:140.2pt;border:none;
  border-bottom:solid windowtext 1.0pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-left-alt:solid windowtext .5pt;mso-border-bottom-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:15.25pt'>
  <p class=MsoNormal><b style='mso-bidi-font-weight:normal'><%=l_invoice_no %><o:p></o:p></b></p>
  </td>
  <td width=183 colspan=2 valign=top style='width:136.9pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:15.25pt'>
  <p class=MsoNormal align=right style='text-align:right'><b style='mso-bidi-font-weight:
  normal'><%=l_invoice_dt %><o:p></o:p></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:5;height:15.25pt'>
  <td width=369 colspan=6 valign=top style='width:277.1pt;border:none;
  border-right:solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .5pt;
  mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;
  mso-border-left-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:15.25pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'>No. &amp; date of L/C<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:6;height:17.05pt'>
  <td width=187 colspan=4 valign=top style='width:140.2pt;border:none;
  border-bottom:solid windowtext 1.0pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-left-alt:solid windowtext .5pt;mso-border-bottom-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:17.05pt'>
  <p class=MsoNormal><%=l_lc_no %></p>
  </td>
  <td width=183 colspan=2 valign=top style='width:136.9pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:17.05pt'>
  <p class=MsoNormal align=right style='text-align:right'><%=l_lc_dt %></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:7;height:30.1pt'>
  <td width=369 colspan=6 valign=top style='width:277.1pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:30.1pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'>L/C Issuing Bank<o:p></o:p></span></p>
  <p class=MsoNormal><%=l_pay_meth %></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:8'>
  <td width=301 colspan=4 valign=top style='width:225.8pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'>For Account &amp; Risk of
  Messrs.<o:p></o:p></span></p>
  <p class=MsoNormal><%=l_ship_name %></p>
  <p class=MsoNormal><%=l_ship_add %></p>
  </td>
  <td width=369 colspan=6 rowspan=4 valign=top style='width:277.1pt;border-top:
  none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'>Remark:<o:p></o:p></span></p>
  <p class=MsoNormal><%=l_remark %></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:9'>
  <td width=301 colspan=4 valign=top style='width:225.8pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'>Notify Party<o:p></o:p></span></p>
  <p class=MsoNormal><%=l_notify_name %></p>
  <p class=MsoNormal><%=l_notify_add %></p>
  <p class=MsoNormal>Tel: <%=l_notify_tel %></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:10'>
  <td width=143 valign=top style='width:106.95pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><st1:place w:st="on"><st1:PlaceType w:st="on"><span
    style='font-size:11.0pt'>Port</span></st1:PlaceType><span style='font-size:
   11.0pt'> of <st1:PlaceName w:st="on">Loading</st1:PlaceName></span></st1:place><span
  style='font-size:11.0pt'><o:p></o:p></span></p>
  <p class=MsoNormal><%=l_loading_port %></p>
  </td>
  <td width=158 colspan=3 valign=top style='width:118.85pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'>Final Destination<o:p></o:p></span></p>
  <p class=MsoNormal><%=l_destination %></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:11'>
  <td width=143 valign=top style='width:106.95pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'>Carrier<o:p></o:p></span></p>
  <p class=MsoNormal><%=l_carrier_nm  %></p>
  <p class=MsoNormal><%=l_carrier_cd  %></p>
  </td>
  <td width=158 colspan=3 valign=top style='width:118.85pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'>Sailing on or about<o:p></o:p></span></p>
  <p class=MsoNormal><%=l_ship_date %></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:12;height:18.85pt'>
  <td width=192 colspan=3 style='width:2.0in;border:none;border-left:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;
  mso-border-left-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:18.85pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'>Marks and Number of PKGS<o:p></o:p></span></p>
  </td>
  <td width=144 colspan=3 style='width:1.5in;border:none;mso-border-top-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:18.85pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'>Description of Goods<o:p></o:p></span></p>
  </td>
  <td width=152 colspan=2 style='width:114.0pt;border:none;mso-border-top-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:18.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'>Unit Quantity<o:p></o:p></span></p>
  </td>
  <td width=91 style='width:68.15pt;border:none;mso-border-top-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:18.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'>Unit-Price<o:p></o:p></span></p>
  </td>
  <td width=92 style='width:68.75pt;border:none;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;
  mso-border-right-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:18.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'>Amount<o:p></o:p></span></p>
  </td>
 </tr>
 <%--<tr style='mso-yfti-irow:13;height:5pt'>
  <td width=192 colspan=3 style='width:2.0in;border:none;border-left:solid windowtext 1.0pt;
  mso-border-left-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:5pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=144 colspan=3 style='width:1.5in;border:none;padding:0in 5.4pt 0in 5.4pt;
  height:5pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=152 colspan=2 style='width:114.0pt;border:none;padding:0in 5.4pt 0in 5.4pt;
  height:5pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=91 style='width:68.15pt;border:none;padding:0in 5.4pt 0in 5.4pt;
  height:5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=92 style='width:68.75pt;border:none;border-right:solid windowtext 1.0pt;
  mso-border-right-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>--%>
 <% 
     for (int i = 0; i < dtDetail.Rows.Count; i++)
     {
 %>
 <tr style='mso-yfti-irow:14;height:17.5pt'>
  <td width=336 colspan=6 style='width:3.5in;border:none;border-left:solid windowtext 1.0pt;
  mso-border-left-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.5pt'>
  <%=dtDetail.Rows[i][1] %>
  </td>
  <td width=95 align=right style='width:71.4pt;border:none;padding:0in 5.4pt 0in 5.4pt;
  height:17.5pt'>
  <%=dtDetail.Rows[i][4] %>
  </td>
  <td width=57 style='width:42.6pt;border:none;padding:0in 5.4pt 0in 5.4pt;
  height:17.5pt'>
  <%=dtDetail.Rows[i][2] %>
  </td>
  <td width=91 align=right  style='width:68.15pt;border:none;padding:0in 5.4pt 0in 5.4pt;
  height:17.5pt'>
  <%=dtDetail.Rows[i][3] %>
  </td>
  <td width=92 align=right  style='width:68.75pt;border:none;border-right:solid windowtext 1.0pt;
  mso-border-right-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.5pt'><%=dtDetail.Rows[i][5] %>
  </td>
 </tr>
 <% 
     }
 %> 
 <tr style='mso-yfti-irow:20;height:17.5pt'>
  <td width=671 colspan=10 style='width:502.9pt;border-top:none;border-left:
  solid windowtext 1.0pt;border-bottom:none;border-right:solid windowtext 1.0pt;
  mso-border-left-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:17.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'>/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:21;height:.3in'>
  <td width=179 colspan=2 style='width:134.05pt;border:none;border-left:solid windowtext 1.0pt;
  mso-border-left-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:.3in'>
  <p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
  style='font-size:11.0pt'>Total:<o:p></o:p></span></b></p>
  </td>
  <td width=133 colspan=3 style='width:99.9pt;border:none;padding:0in 5.4pt 0in 5.4pt;
  height:.3in'>
  <p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
  style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width=119 colspan=2 style='width:89.45pt;border:none;padding:0in 5.4pt 0in 5.4pt;
  height:.3in'>
  <p class=MsoNormal align=right style='text-align:right'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:11.0pt'>&nbsp;<o:p></o:p></span></b></p>
  </td>
  <td width=57 style='width:42.6pt;border:none;padding:0in 5.4pt 0in 5.4pt;
  height:.3in'>
  <p class=MsoNormal align=right style='text-align:right'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width=91 style='width:68.15pt;border:none;padding:0in 5.4pt 0in 5.4pt;
  height:.3in'>
  <p class=MsoNormal align=right style='text-align:right'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width=92 style='width:68.75pt;border:none;border-right:solid windowtext 1.0pt;
  mso-border-right-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:.3in'>
  <p class=MsoNormal align=right style='text-align:right'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:11.0pt'><%=l_curr%> <%=l_tot_amt %><o:p></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:22;height:17.5pt'>
  <td width=671 colspan=10 style='width:502.9pt;border-top:none;border-left:
  solid windowtext 1.0pt;border-bottom:none;border-right:solid windowtext 1.0pt;
  mso-border-left-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:17.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'>/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:23;height:17.5pt'>
  <td width=671 colspan=10 style='width:502.9pt;border-top:none;border-left:
  solid windowtext 1.0pt;border-bottom:none;border-right:solid windowtext 1.0pt;
  mso-border-left-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:17.5pt'>
  <p class=MsoNormal align=right style='text-align:right'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:11.0pt'>-YOURS VERY TRULY-<o:p></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:24;height:45.0pt'>
  <td width=179 colspan=2 valign=bottom style='width:134.05pt;border:none;
  border-left:solid windowtext 1.0pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:45.0pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=133 colspan=3 valign=bottom style='width:99.9pt;border:none;
  padding:0in 5.4pt 0in 5.4pt;height:45.0pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=119 colspan=2 valign=bottom style='width:89.45pt;border:none;
  padding:0in 5.4pt 0in 5.4pt;height:45.0pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=239 colspan=3 valign=bottom style='width:179.5pt;border:none;
  border-right:solid windowtext 1.0pt;mso-border-right-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:45.0pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'><%=l_com_name %><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:25;height:.75in'>
  <td width=179 colspan=2 valign=bottom style='width:134.05pt;border:none;
  border-left:solid windowtext 1.0pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:.75in'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=133 colspan=3 valign=bottom style='width:99.9pt;border:none;
  padding:0in 5.4pt 0in 5.4pt;height:.75in'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=119 colspan=2 valign=bottom style='width:89.45pt;border:none;
  padding:0in 5.4pt 0in 5.4pt;height:.75in'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=239 colspan=3 valign=bottom style='width:179.5pt;border:none;
  border-right:solid windowtext 1.0pt;mso-border-right-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:.75in'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:26;mso-yfti-lastrow:yes;height:.25in'>
  <td width=179 colspan=2 style='width:134.05pt;border-top:none;border-left:
  solid windowtext 1.0pt;border-bottom:solid windowtext 1.0pt;border-right:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-bottom-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:.25in'>
  <p class=MsoNormal><span style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=133 colspan=3 style='width:99.9pt;border:none;border-bottom:solid windowtext 1.0pt;
  mso-border-bottom-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:.25in'>
  <p class=MsoNormal><span style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=119 colspan=2 style='width:89.45pt;border:none;border-bottom:solid windowtext 1.0pt;
  mso-border-bottom-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:.25in'>
  <p class=MsoNormal><span style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=239 colspan=3 style='width:179.5pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:.25in'>
  <p class=MsoNormal><span style='font-size:11.0pt'>SIGNED BY:
  _________________<o:p></o:p></span></p>
  </td>
 </tr>
 <![if !supportMisalignedColumns]>
 <tr height=0>
  <td width=142 style='border:none'></td>
  <td width=36 style='border:none'></td>
  <td width=13 style='border:none'></td>
  <td width=109 style='border:none'></td>
  <td width=11 style='border:none'></td>
  <td width=24 style='border:none'></td>
  <td width=95 style='border:none'></td>
  <td width=57 style='border:none'></td>
  <td width=91 style='border:none'></td>
  <td width=92 style='border:none'></td>
 </tr>
 <![endif]>
</table>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>
