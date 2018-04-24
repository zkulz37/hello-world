<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("acnt");
    Response.ContentType = "application/msword";
    
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>

<html 

xmlns:w="urn:schemas-microsoft-com:office:word"
xmlns:st1="urn:schemas-microsoft-com:office:smarttags"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
    string p_tac_bfbeneficiary_pk = "";
    string SQL = "";
    string p_bef_name = "", p_account_no = "", p_bef_bank = "", p_comp_name = "", p_address = "";
    string p_gene_director = "", p_phone_no = "", p_fax_no = "", p_tax_code = "", p_prepared_by = "";
    string p_conf_date = "", p_conf_by = "", p_ccy = "";
    ////////////////////////////////////////////////////////////
    p_tac_bfbeneficiary_pk = Request["bfbeneficiary_pk"];
    
     SQL
        = "select b.bedefi_nm,  b.account_no, b.ccy, b.bedefi_bank_nm || ' - ' || b.branch bedefi_bank_nm, c.partner_id || ' - ' || c.partner_name, c.addr1, c.representative, c.phone_no, c.fax_no, c.tax_code,  " +
            "    (select full_name from comm.vco_bsuser where user_id = b.crt_by ) crt_by, (select full_name from comm.vco_bsuser where user_id = b.mod_by ) confirmed_by, " +
            "    to_char(b.mod_dt, 'DD/MM/YYYY') confirm_date " +
            "from tac_bfbeneficiary b, comm.tco_buspartner c  " +
            "where b.tco_dccust_pk = c.pk " +
            "and b.del_if = 0 " +
            "and c.del_if = 0 " +
            "and b.pk = " + p_tac_bfbeneficiary_pk + " ";
     DataTable dt = ESysLib.TableReadOpen(SQL);
     if (dt.Rows.Count > 0)
     {
         p_bef_name = dt.Rows[0][0].ToString();
         p_account_no = dt.Rows[0][1].ToString();
         p_bef_bank = dt.Rows[0][3].ToString();
         p_comp_name = dt.Rows[0][4].ToString();
         p_address = dt.Rows[0][5].ToString();
         p_gene_director = dt.Rows[0][6].ToString();
         p_phone_no = dt.Rows[0][7].ToString();
         p_fax_no = dt.Rows[0][8].ToString();
         p_tax_code = dt.Rows[0][9].ToString();
         p_prepared_by = dt.Rows[0][10].ToString();
         p_conf_by = dt.Rows[0][11].ToString();
         p_conf_date = dt.Rows[0][12].ToString();
         p_ccy = dt.Rows[0][2].ToString();
     }     
     
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 11">
<meta name=Originator content="Microsoft Word 11">
<link rel=File-List href="rpt_test_files/filelist.xml">
<title>THOÂNG TIN TAØI KHOAÛN</title>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Lanny</o:Author>
  <o:LastAuthor>van</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>10</o:TotalTime>
  <o:LastPrinted>2010-07-19T02:38:00Z</o:LastPrinted>
  <o:Created>2011-03-04T04:06:00Z</o:Created>
  <o:LastSaved>2011-03-04T04:06:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>40</o:Words>
  <o:Characters>230</o:Characters>
  <o:Company>IBC</o:Company>
  <o:Lines>1</o:Lines>
  <o:Paragraphs>1</o:Paragraphs>
  <o:CharactersWithSpaces>269</o:CharactersWithSpaces>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
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
</xml><![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:VNI-Centur;
	mso-font-charset:0;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:3 0 0 0 1 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:14.0pt;
	font-family:"VNI-Centur;";
	mso-fareast-font-family:"VNI-Centur;";}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;
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
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2050"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=EN-US style='tab-interval:.5in'>

<div class=Section1>

<p class=MsoNormal align=center style='text-align:center'><b style='mso-bidi-font-weight:
normal'><span style='font-size:16.0pt;font-family:VNI-Centur'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal align=center style='text-align:center'><b style='mso-bidi-font-weight:
normal'><span style='font-size:16.0pt;font-family:VNI-Centur'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal align=center style='text-align:center'><b style='mso-bidi-font-weight:
normal'><span style='font-size:16.0pt;font-family:VNI-Centur'>CONTRACTORS
INFORMATION<o:p></o:p></span></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:VNI-Centur'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:VNI-Centur'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:VNI-Centur'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:VNI-Centur'>Company Name <span
style='mso-spacerun:yes'> </span>: <o:p></o:p></span><%=p_comp_name%></b></p>
<p class=MsoNormal><b style='mso-bidi-font-weight:normal; '><span
style='font-family:VNI-Centur'>Address : <o:p></o:p></span><%=p_address%></b></p>
<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:VNI-Centur'>General Director Name :<o:p></o:p></span><%=p_gene_director%></b></p>
<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:VNI-Centur'>Tel. : <o:p></o:p></span><%=p_phone_no%></b></p>
<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:VNI-Centur'>Fax : <o:p></o:p></span><%=p_fax_no%></b></p>
<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:VNI-Centur'>Tax Code : <o:p></o:p></span><%=p_tax_code%></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:VNI-Centur'> <span
style='mso-spacerun:yes'> </span><o:p></o:p></span></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:VNI-Centur'>Beneficiary Name : <o:p></o:p></span><%=p_bef_name%></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:VNI-Centur'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:VNI-Centur'>Account Number: <o:p></o:p></span><%=p_account_no%></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:VNI-Centur'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:VNI-Centur'>Currency: <o:p></o:p></span><%=p_ccy%></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:VNI-Centur'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:VNI-Centur'>Beneficiary Bank: <o:p></o:p></span><%=p_bef_bank%></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:VNI-Centur'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:VNI-Centur'><span style='mso-tab-count:7'>                                                                                    </span>Date: <%=p_conf_date %>
<o:p></o:p></span></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:VNI-Centur'>Prepared by<span style='mso-tab-count:5'>                                                 </span>Checked
and Confirmed by<o:p></o:p></span></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:VNI-Centur'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:VNI-Centur'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:VNI-Centur'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:VNI-Centur'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:VNI-Centur'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><i style='mso-bidi-font-style:
normal'><span style='font-family:VNI-Centur'><%=p_prepared_by%><span
style='mso-tab-count:3'>                             </span><%=p_conf_by%><o:p></o:p></span></i></b></p>

</div>

</body>

</html>
