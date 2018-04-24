<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% Response.ContentType = "application/msword"; %>
<% ESysLib.SetUser("imex");%>

<% 
    if (Request.QueryString["random"] == null) return;    
    
    string SQL, l_decl_pk, l_company_pk;
    string l_exp_name = "", l_exp_add = "", l_imp_name = "", l_imp_add = "", l_not_name = "", l_not_add = "", l_not_tel="";
    string l_loading = "", l_dest = "", l_carrier = "", l_vessel_name = "", l_vessel_no = "", l_ship_date = "", l_marks = "";
    string l_inv_no = "", l_inv_date = "", l_lc_no = "", l_lc_dt = "", l_pay_meth = "", l_desc = "", l_qty = "", l_net_weight = "";
    string l_g_weight = "", l_unit_weight = "", l_meas = "", l_unit_meas = "", l_com_name = "", l_com_add="";

    l_decl_pk = Request.QueryString["decl_pk"];
    l_company_pk = Request.QueryString["company_pk"];

    SQL = " select  a.partner_name, a.addr1  " +
        " from    tco_company a   " +
        " where pk='" + l_company_pk + "' ";
    System.Data.DataTable dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count > 0)
    {
        l_com_name = (string)dt.Rows[0][0].ToString();
        l_com_add = (string)dt.Rows[0][1].ToString();
    }
        
    SQL = " select v2.partner_name exp_name, v2.addr1 exp_add, v3.partner_name imp_name, v3.addr1 imp_add " +
        "        , v4.partner_name not_name, v4.addr1 not_add, v4.phone_no not_tel " +
        "        , v5.port_nm loading, v6.port_nm dest, v7.partner_name carrier, v1.vessel_flt_name " +
        "        , v1.vessel_flt_no, to_char(to_date(v1.arrival_date,'yyyymmdd'),'MON. dd,yyyy')   ship_date " +
        "        , v1.marks, v8.co_invoice_no, to_char(to_date(v8.co_invoice_date,'yyyymmdd'),'MON. dd,yyyy') inv_date " +
        "        , v8.lc_no, to_char(to_date(v8.lc_dt,'yyyymmdd'),'MON. dd,yyyy') lc_dt, s1.code_nm pay_meth " +
        "        , v.description, s2.qty, to_char(s2.net_weight,'9,999,999.99'), to_char(s2.g_weight,'9,999,999.99') " +
        "        , s2.unit_weight, to_char(s2.meas,'9,999,999.99'), s2.unit_met " +
        " from  tim_decl_mst v, tie_bl_mst v1, comm.tco_buspartner v2   " +
        "      , comm.tco_buspartner v3, comm.tco_buspartner v4 " +
        "      , tie_port v5, tie_port v6, comm.tco_buspartner v7 " +
        "      , tim_cinv_mst_a v8  " +
        "      ,(select a.code,  a.code_nm from tco_abcode a, tco_abcodegrp b  " +
        "        where tco_abcodegrp_pk=b.pk and b.id='ACCR0140'  " +
        "            and a.del_if=0 and b.del_if=0 order by a.code) s1 " +
        "      ,(select sum(nvl(a1.qty,0)) qty, sum(nvl(a1.net_weight,0)) net_weight " +
        "            , sum(nvl(a1.gross_weight,0)) g_weight, sum(nvl(a1.measurement,0)) meas " +
        "            , a1.unit_weight, a1.unit_met, a1.tie_bl_mst_pk " +
        "        from tie_bl_dtl a1   " +
        "        group by a1.unit_weight, a1.unit_met, a1.tie_bl_mst_pk " +
        "      ) s2 " +
        "    where v.del_if=0 and v2.del_if(+)=0 and v3.del_if(+)=0 " +
        "        and v.tco_buspartner_pk1 = v2.pk(+) " +
        "        and v.tco_buspartner_pk1 = v3.pk(+)  " +
        "        and v1.tco_buspartner_pk3 = v4.pk(+)    " +
        "        and v1.tco_buspartner_pk1 = v7.pk(+)  " +
        "        and v.tim_cinv_mst_a_pk = v8.pk(+) " +
        "        and v.plc_discharge = v6.port_cd(+) " +
        "        and v.plc_loading = v5.port_cd(+) " +
        "        and upper(v.pay_meth) = upper(s1.code) " +
        "        and v1.pk = s2.tie_bl_mst_pk " +
        "        and  v.pk ='" + l_decl_pk + "' ";
    dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count > 0)
    { 
        l_exp_name =(string) dt.Rows[0][0].ToString();
        l_exp_add = (string)dt.Rows[0][1].ToString();
        l_imp_name = (string)dt.Rows[0][2].ToString();
        l_imp_add = (string)dt.Rows[0][3].ToString();
        l_not_name = (string)dt.Rows[0][4].ToString();
        l_not_add = (string)dt.Rows[0][5].ToString();
        l_not_tel = (string)dt.Rows[0][6].ToString();
        l_loading = (string)dt.Rows[0][7].ToString();
        l_dest = (string)dt.Rows[0][8].ToString();
        l_carrier = (string)dt.Rows[0][9].ToString();
        l_vessel_name = (string)dt.Rows[0][10].ToString();
        l_vessel_no = (string)dt.Rows[0][11].ToString();
        l_ship_date = (string)dt.Rows[0][12].ToString();
        l_marks = (string)dt.Rows[0][13].ToString();
        l_inv_no = (string)dt.Rows[0][14].ToString();
        l_inv_date = (string)dt.Rows[0][15].ToString();
        l_lc_no = (string)dt.Rows[0][16].ToString();
        l_lc_dt = (string)dt.Rows[0][17].ToString();
        l_pay_meth = (string)dt.Rows[0][18].ToString();
        l_desc = (string)dt.Rows[0][19].ToString();
        l_qty = (string)dt.Rows[0][20].ToString();
        l_net_weight = (string)dt.Rows[0][21].ToString();
        l_g_weight = (string)dt.Rows[0][22].ToString();
        l_unit_weight = (string)dt.Rows[0][23].ToString();
        l_meas = (string)dt.Rows[0][24].ToString();
        l_unit_meas = (string)dt.Rows[0][25].ToString();
    }
    SQL = " select  c.item_name, c.item_code " +
        "     , to_char(a.qty,'999,999,999') qty, a.unit_cd , a.pk  " +
        " from tim_decl_dtl a, comm.tco_item  c  " +
        " where a.del_if = 0   " +
        "    and a.TCO_ITEM_PK = c.pk " +
        "    and c.TRANS_FEE_YN ='N' " +
        "    and a.tim_decl_mst_pk='" + l_decl_pk + "' " +
        " order by a.pk ";
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
<link rel=File-List href="rpt_epgd00010_PACKING_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_epgd00010_PACKING_files/editdata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<title>  <%=l_com_name%>   </title>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="PlaceType"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="PlaceName"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="place"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="stockticker"/>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>NgaLe</o:Author>
  <o:LastAuthor>NgaLe</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>67</o:TotalTime>
  <o:Created>2008-10-03T08:58:00Z</o:Created>
  <o:LastSaved>2008-10-03T08:58:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>171</o:Words>
  <o:Characters>977</o:Characters>
  <o:Company>Vinagenuwin</o:Company>
  <o:Lines>8</o:Lines>
  <o:Paragraphs>2</o:Paragraphs>
  <o:CharactersWithSpaces>1146</o:CharactersWithSpaces>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Print</w:View>
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
<![endif]--><style>
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
	{size:595.45pt 841.7pt;
	margin:.75in 1.25in 27.0pt 1.25in;
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
<![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2050"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=EN-US style='tab-interval:.5in'>

<div class=Section1>

<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 width=672
 style='width:7.0in;margin-left:-.3in;border-collapse:collapse;border:none;
 mso-border-alt:solid windowtext .5pt;mso-yfti-tbllook:480;mso-padding-alt:
 0in 5.4pt 0in 5.4pt;mso-border-insideh:.5pt solid windowtext;mso-border-insidev:
 .5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes'>
  <td width=672 colspan=13 style='width:7.0in;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><!--[if gte vml 1]><v:shapetype
   id="_x0000_t75" coordsize="21600,21600" o:spt="75" o:preferrelative="t"
   path="m@4@5l@4@11@9@11@9@5xe" filled="f" stroked="f">
   <v:stroke joinstyle="miter"/>
   <v:formulas>
    <v:f eqn="if lineDrawn pixelLineWidth 0"/>
    <v:f eqn="sum @0 1 0"/>
    <v:f eqn="sum 0 0 @1"/>
    <v:f eqn="prod @2 1 2"/>
    <v:f eqn="prod @3 21600 pixelWidth"/>
    <v:f eqn="prod @3 21600 pixelHeight"/>
    <v:f eqn="sum @0 0 1"/>
    <v:f eqn="prod @6 1 2"/>
    <v:f eqn="prod @7 21600 pixelWidth"/>
    <v:f eqn="sum @8 21600 0"/>
    <v:f eqn="prod @7 21600 pixelHeight"/>
    <v:f eqn="sum @10 21600 0"/>
   </v:formulas>
   <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
   <o:lock v:ext="edit" aspectratio="t"/>
  </v:shapetype><v:shape id="_x0000_i1025" type="#_x0000_t75" style='width:63pt;
   height:26.25pt' o:allowoverlap="f">
   <v:imagedata src="rpt_epgd00010_PACKING_files/image001.png" o:title="genuwin_logo"/>
  </v:shape><![endif]--><![if !vml]><img width=84 height=35
  src="rpt_epgd00010_PACKING_files/image002.jpg" v:shapes="_x0000_i1025"><![endif]><span
  style='mso-spacerun:yes'> </span><b style='mso-bidi-font-weight:normal'><span
  style='font-size:20.0pt'><%=l_com_name%><span style='mso-spacerun:yes'>  
  </span><o:p></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1'>
  <td width=672 colspan=13 valign=top style='width:7.0in;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><%=l_com_add %></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2;height:25.15pt'>
  <td width=672 colspan=13 style='width:7.0in;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:25.15pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:20.0pt'>PACKING LIST<o:p></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3;height:13.9pt'>
  <td width=336 colspan=4 rowspan=5 valign=top style='width:3.5in;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:13.9pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'>Manufacture/Exporter<o:p></o:p></span></p>
  <p class=MsoNormal><%=l_exp_name %></p>
  <p class=MsoNormal><%=l_exp_add %></p>
  </td>
  <td width=336 colspan=9 valign=top style='width:3.5in;border:none;border-right:
  solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:
  solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:
  solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:
  0in 5.4pt 0in 5.4pt;height:13.9pt'>
  <p class=MsoNormal style='tab-stops:right 199.35pt'><span style='font-size:
  11.0pt'>No. &amp; date of invoice<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:4;height:11.65pt'>
  <td width=187 colspan=5 valign=top style='width:140.2pt;border:none;
  border-bottom:solid windowtext 1.0pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-left-alt:solid windowtext .5pt;mso-border-bottom-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:11.65pt'>
  <p class=MsoNormal><b style='mso-bidi-font-weight:normal'><%=l_inv_no %><o:p></o:p></b></p>
  </td>
  <td width=149 colspan=4 valign=top style='width:111.8pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:11.65pt'>
  <p class=MsoNormal align=right style='text-align:right'><b style='mso-bidi-font-weight:
  normal'><%=l_inv_date %><o:p></o:p></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:5;height:11.65pt'>
  <td width=336 colspan=9 valign=top style='width:3.5in;border:none;border-right:
  solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:
  solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:
  solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:
  0in 5.4pt 0in 5.4pt;height:11.65pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'>No. &amp; date of L/C<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:6;height:13.45pt'>
  <td width=187 colspan=5 style='width:140.2pt;border:none;border-bottom:solid windowtext 1.0pt;
  mso-border-left-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-bottom-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:13.45pt'>
  <p class=MsoNormal><%=l_lc_no %></p>
  </td>
  <td width=149 colspan=4 style='width:111.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:13.45pt'>
  <p class=MsoNormal align=right style='text-align:right'><%=l_lc_dt %></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:7;height:30.1pt'>
  <td width=336 colspan=9 valign=top style='width:3.5in;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:30.1pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'>L/C Issuing Bank<o:p></o:p></span></p>
  <p class=MsoNormal><%=l_pay_meth %></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:8'>
  <td width=336 colspan=4 valign=top style='width:3.5in;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'>For Account &amp; Risk of
  Messrs.<o:p></o:p></span></p>
  <p class=MsoNormal><%=l_imp_name  %></p>
  <p class=MsoNormal><%=l_imp_add %></p>
  </td>
  <td width=336 colspan=9 rowspan=4 valign=top style='width:3.5in;border-top:
  none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'>Remark:<o:p></o:p></span></p>
  <p class=MsoNormal><%=l_desc %></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:9'>
  <td width=336 colspan=4 valign=top style='width:3.5in;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'>Notify Party</span></p>
  <p class=MsoNormal><%=l_not_name %></p>
  <p class=MsoNormal><%=l_not_add%></p>
  <p class=MsoNormal><%=l_not_tel%></p>
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
  <p class=MsoNormal><%=l_loading %></p>
  </td>
  <td width=193 colspan=3 valign=top style='width:145.05pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'>Final Destination<o:p></o:p></span></p>
  <p class=MsoNormal><%=l_dest %></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:11'>
  <td width=143 valign=top style='width:106.95pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'>Carrier<o:p></o:p></span></p>
  <p class=MsoNormal><%=l_carrier %></p>
  <p class=MsoNormal><%=l_vessel_name%></p>
  <p class=MsoNormal><%=l_vessel_no%></p>
  </td>
  <td width=193 colspan=3 valign=top style='width:145.05pt;border-top:none;
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
  <td width=179 colspan=3 style='width:134.2pt;border:none;mso-border-top-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:18.85pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'>Description of Goods<o:p></o:p></span></p>
  </td>
  <td width=152 colspan=3 style='width:100.0pt;border:none;mso-border-top-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:18.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'>Quantity<o:p></o:p></span></p>
  </td>
  <td width=149 colspan=4 style='width:120.8pt;border:none;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;
  mso-border-right-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:18.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'>Weight &amp; Measurement<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:13;height:17.5pt'>
  <td width=192 colspan=6 style='width:2.0in;border:none;border-left:solid windowtext 1.0pt;
  mso-border-left-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.5pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'><o:p><%=l_marks %>, <%=l_qty %>PCS</o:p></span></p>
  </td>
  <p class=MsoNormal><span style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=152 colspan=3 style='width:114.0pt;border:none;padding:0in 5.4pt 0in 5.4pt;
  height:17.5pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=89 colspan=3 style='width:66.8pt;border:none;padding:0in 5.4pt 0in 5.4pt;
  height:17.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=60 style='width:45.0pt;border:none;border-right:solid windowtext 1.0pt;
  mso-border-right-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <%
     for(int i=0; i< dtDetail.Rows.Count;i++)
     {
      %>
 <tr style='mso-yfti-irow:14;height:17.5pt'>
  <td width=371 colspan=6 style='width:278.2pt;border:none;border-left:solid windowtext 1.0pt;
  mso-border-left-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.5pt'>
  <p class=MsoNormal><span style='font-size:11.0pt'><%=dtDetail.Rows[i][0] %><o:p></o:p></span></p>
  </td>
  <td width=95 colspan=2 style='width:71.4pt;border:none;padding:0in 5.4pt 0in 5.4pt;
  height:17.5pt'>
  <p class=MsoNormal align=right style='text-align:right'><span
  style='font-size:11.0pt'><%=dtDetail.Rows[i][2] %><o:p></o:p></span></p>
  </td>
  <td width=57 style='width:42.6pt;border:none;padding:0in 5.4pt 0in 5.4pt;
  height:17.5pt'>
  <p class=MsoNormal><st1:stockticker w:st="on"><span style='font-size:11.0pt'><%=dtDetail.Rows[i][3] %></span></st1:stockticker><span
  style='font-size:11.0pt'><o:p></o:p></span></p>
  </td>
  <td width=89 colspan=3 style='width:66.8pt;border:none;padding:0in 5.4pt 0in 5.4pt;
  height:17.5pt'>
  <p class=MsoNormal align=right style='text-align:right'><span
  style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=60 style='width:45.0pt;border:none;border-right:solid windowtext 1.0pt;
  mso-border-right-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.5pt'>
  <p class=MsoNormal align=right style='text-align:right'><span
  style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <%} %>
 <tr style='mso-yfti-irow:17;height:17.5pt'>
  <td width=672 colspan=13 style='width:7.0in;border-top:none;border-left:solid windowtext 1.0pt;
  border-bottom:none;border-right:solid windowtext 1.0pt;mso-border-left-alt:
  solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:
  0in 5.4pt 0in 5.4pt;height:17.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'>/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:18;height:.3in'>
  <td width=179 colspan=2 style='width:134.05pt;border:none;border-left:solid windowtext 1.0pt;
  mso-border-left-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:.3in'>
  <p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
  style='font-size:11.0pt'>Total:<o:p></o:p></span></b></p>
  </td>
  <td width=168 colspan=3 style='width:126.1pt;border:none;padding:0in 5.4pt 0in 5.4pt;
  height:.3in'>
  <p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
  style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width=119 colspan=3 style='width:89.45pt;border:none;padding:0in 5.4pt 0in 5.4pt;
  height:.3in'>
  <p class=MsoNormal align=right style='text-align:right'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:11.0pt'><%=l_qty %><o:p></o:p></span></b></p>
  </td>
  <td width=57 style='width:42.6pt;border:none;padding:0in 5.4pt 0in 5.4pt;
  height:.3in'>
  <p class=MsoNormal align=right style='text-align:right'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width=53 colspan=2 style='width:39.8pt;border:none;padding:0in 5.4pt 0in 5.4pt;
  height:.3in'>
  <p class=MsoNormal align=right style='text-align:right'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width=96 colspan=2 style='width:1.0in;border:none;border-right:solid windowtext 1.0pt;
  mso-border-right-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:.3in'>
  <p class=MsoNormal align=right style='text-align:right'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:11.0pt'><o:p></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:19;height:17.5pt'>
  <td width=672 colspan=13 style='width:7.0in;border-top:none;border-left:solid windowtext 1.0pt;
  border-bottom:none;border-right:solid windowtext 1.0pt;mso-border-left-alt:
  solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:
  0in 5.4pt 0in 5.4pt;height:17.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'>/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:20;height:17.5pt'>
  <td width=564 colspan=10 style='width:423.0pt;border:none;border-left:solid windowtext 1.0pt;
  mso-border-left-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.5pt'>
  <p class=MsoNormal align=right style='text-align:right'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:11.0pt'>N/W :<o:p></o:p></span></b></p>
  </td>
  <td width=108 colspan=3 style='width:81.0pt;border:none;border-right:solid windowtext 1.0pt;
  mso-border-right-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.5pt'>
  <p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
  style='font-size:11.0pt'><%=l_net_weight %><%=l_unit_weight %><o:p></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:21;height:17.5pt'>
  <td width=564 colspan=10 style='width:423.0pt;border:none;border-left:solid windowtext 1.0pt;
  mso-border-left-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.5pt'>
  <p class=MsoNormal align=right style='text-align:right'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:11.0pt'>G/W :<o:p></o:p></span></b></p>
  </td>
  <td width=108 colspan=3 style='width:81.0pt;border:none;border-right:solid windowtext 1.0pt;
  mso-border-right-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.5pt'>
  <p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
  style='font-size:11.0pt'><%=l_g_weight %><%=l_unit_weight %><o:p></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:22;height:17.5pt'>
  <td width=564 colspan=10 style='width:423.0pt;border:none;border-left:solid windowtext 1.0pt;
  mso-border-left-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.5pt'>
  <p class=MsoNormal align=right style='text-align:right'><st1:stockticker
  w:st="on"><b style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt'>MET</span></b></st1:stockticker><b
  style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt'>:<o:p></o:p></span></b></p>
  </td>
  <td width=108 colspan=3 style='width:81.0pt;border:none;border-right:solid windowtext 1.0pt;
  mso-border-right-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.5pt'>
  <p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
  style='font-size:11.0pt'><%=l_meas %><%=l_unit_meas %><o:p></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:23;height:4.0pt'>
  <td width=672 colspan=13 style='width:7.0in;border-top:none;border-left:solid windowtext 1.0pt;
  border-bottom:none;border-right:solid windowtext 1.0pt;mso-border-left-alt:
  solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:
  0in 5.4pt 0in 5.4pt;height:4.0pt'>
  <p class=MsoNormal align=right style='text-align:right'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:24;height:17.5pt'>
  <td width=672 colspan=13 style='width:7.0in;border-top:none;border-left:solid windowtext 1.0pt;
  border-bottom:none;border-right:solid windowtext 1.0pt;mso-border-left-alt:
  solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:
  0in 5.4pt 0in 5.4pt;height:17.5pt'>
  <p class=MsoNormal align=right style='text-align:right'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:11.0pt'>-YOURS VERY TRULY-<o:p></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:25;height:48.15pt'>
  <td width=179 colspan=2 valign=bottom style='width:134.05pt;border:none;
  border-left:solid windowtext 1.0pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:48.15pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=168 colspan=3 valign=bottom style='width:126.1pt;border:none;
  padding:0in 5.4pt 0in 5.4pt;height:48.15pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=97 colspan=2 valign=bottom style='width:72.85pt;border:none;
  padding:0in 5.4pt 0in 5.4pt;height:48.15pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=228 colspan=6 valign=bottom style='width:171.0pt;border:none;
  border-right:solid windowtext 1.0pt;mso-border-right-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:48.15pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'><%=l_com_name %><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:26;height:.75in'>
  <td width=179 colspan=2 valign=bottom style='width:134.05pt;border:none;
  border-left:solid windowtext 1.0pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:.75in'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=168 colspan=3 valign=bottom style='width:126.1pt;border:none;
  padding:0in 5.4pt 0in 5.4pt;height:.75in'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=97 colspan=2 valign=bottom style='width:72.85pt;border:none;
  padding:0in 5.4pt 0in 5.4pt;height:.75in'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=228 colspan=6 valign=bottom style='width:171.0pt;border:none;
  border-right:solid windowtext 1.0pt;mso-border-right-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:.75in'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:27;mso-yfti-lastrow:yes;height:.25in'>
  <td width=179 colspan=2 style='width:134.05pt;border-top:none;border-left:
  solid windowtext 1.0pt;border-bottom:solid windowtext 1.0pt;border-right:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-bottom-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:.25in'>
  <p class=MsoNormal><span style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=168 colspan=3 style='width:126.1pt;border:none;border-bottom:solid windowtext 1.0pt;
  mso-border-bottom-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:.25in'>
  <p class=MsoNormal><span style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=97 colspan=2 style='width:72.85pt;border:none;border-bottom:solid windowtext 1.0pt;
  mso-border-bottom-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:.25in'>
  <p class=MsoNormal><span style='font-size:11.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=228 colspan=6 style='width:171.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:.25in'>
  <p class=MsoNormal><span style='font-size:11.0pt'>SIGNED BY:
  _________________<o:p></o:p></span></p>
  </td>
 </tr>
 <![if !supportMisalignedColumns]>
 <tr height=0>
  <td width=143 style='border:none'></td>
  <td width=36 style='border:none'></td>
  <td width=13 style='border:none'></td>
  <td width=144 style='border:none'></td>
  <td width=11 style='border:none'></td>
  <td width=24 style='border:none'></td>
  <td width=73 style='border:none'></td>
  <td width=22 style='border:none'></td>
  <td width=57 style='border:none'></td>
  <td width=41 style='border:none'></td>
  <td width=12 style='border:none'></td>
  <td width=36 style='border:none'></td>
  <td width=60 style='border:none'></td>
 </tr>
 <![endif]>
</table>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>
