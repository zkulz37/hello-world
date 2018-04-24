<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/msword";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:w="urn:schemas-microsoft-com:office:word"
xmlns:st1="urn:schemas-microsoft-com:office:smarttags"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string emp_pk;
    emp_pk       = Request["emp_pk"].ToString();
	
	string SQL;
	SQL = "select  e.EMP_ID, to_char(to_date(e.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') join_dt, null,  " ;
        SQL = SQL + "            (select g.ORG_NM from comm.tco_org g  " ;
        SQL = SQL + "            where g.DEL_IF=0 and g.PK=e.TCO_ORG_PK)  org " ;
        SQL = SQL + "            , (select v.CODE_NM from vhr_hr_code v where id='HR0008' and e.POS_TYPE=v.code) pos " ;
        SQL = SQL + "            ,e.FULL_NAME,  " ;
        SQL = SQL + "            decode(length(e.BIRTH_DT),4,e.BIRTH_DT,  to_char(to_date(e.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy') ) birth_dt " ;
        SQL = SQL + "            ,e.PERSON_ID, e.TEL, decode(e.SEX,'M','Nam','Nữ'),e.PERMANENT_ADDR " ;
        SQL = SQL + "from thr_employee e " ;
        SQL = SQL + "where e.DEL_IF=0 " ;
        SQL = SQL + "and e.PK in ("+ emp_pk +") " ;
	DataTable dt_total = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt_total.Rows.Count;
    if (irow == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 11">
<meta name=Originator content="Microsoft Word 11">
<link rel=File-List href="rpt_personel_card_files/filelist.xml">
<title>THẺ NHÂN SỰ</title>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>thinguyentung</o:Author>
  <o:LastAuthor>Convert</o:LastAuthor>
  <o:Revision>3</o:Revision>
  <o:TotalTime>6</o:TotalTime>
  <o:LastPrinted>2010-03-15T01:24:00Z</o:LastPrinted>
  <o:Created>2010-12-11T02:16:00Z</o:Created>
  <o:LastSaved>2010-12-11T02:20:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>139</o:Words>
  <o:Characters>793</o:Characters>
  <o:Company>VPI</o:Company>
  <o:Lines>6</o:Lines>
  <o:Paragraphs>1</o:Paragraphs>
  <o:CharactersWithSpaces>931</o:CharactersWithSpaces>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
 <o:OfficeDocumentSettings>
  <o:RelyOnVML/>
  <o:AllowPNG/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Print</w:View>
  <w:PunctuationKerning/>
  <w:DrawingGridHorizontalSpacing>7 pt</w:DrawingGridHorizontalSpacing>
  <w:DisplayHorizontalDrawingGridEvery>2</w:DisplayHorizontalDrawingGridEvery>
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
	{font-family:Calibri;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-520092929 1073786111 9 0 415 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin-top:0in;
	margin-right:0in;
	margin-bottom:10.0pt;
	margin-left:0in;
	line-height:115%;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:Calibri;
	mso-ansi-language:VI;
	font-weight:bold;
	mso-bidi-font-weight:normal;}
p.MsoHeader, li.MsoHeader, div.MsoHeader
	{mso-style-noshow:yes;
	mso-style-link:"Char Char1";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	tab-stops:center 225.65pt right 451.3pt;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:Calibri;
	mso-ansi-language:VI;
	font-weight:bold;
	mso-bidi-font-weight:normal;}
p.MsoFooter, li.MsoFooter, div.MsoFooter
	{mso-style-noshow:yes;
	mso-style-link:"Char Char";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	tab-stops:center 225.65pt right 451.3pt;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:Calibri;
	mso-ansi-language:VI;
	font-weight:bold;
	mso-bidi-font-weight:normal;}
span.CharChar1
	{mso-style-name:"Char Char1";
	mso-style-noshow:yes;
	mso-style-locked:yes;
	mso-style-link:Header;}
span.CharChar
	{mso-style-name:"Char Char";
	mso-style-noshow:yes;
	mso-style-locked:yes;
	mso-style-link:Footer;}
 /* Page Definitions */
 @page
	{mso-footnote-separator:url("rpt_personel_card_files/header.htm") fs;
	mso-footnote-continuation-separator:url("rpt_personel_card_files/header.htm") fcs;
	mso-endnote-separator:url("rpt_personel_card_files/header.htm") es;
	mso-endnote-continuation-separator:url("rpt_personel_card_files/header.htm") ecs;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:14.2pt 14.1pt 14.2pt 21.3pt;
	mso-header-margin:35.4pt;
	mso-footer-margin:35.4pt;
	mso-footer:url("rpt_personel_card_files/header.htm") f1;
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
	border:solid black 1.0pt;
	mso-border-alt:solid black .5pt;
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-border-insideh:.5pt solid black;
	mso-border-insidev:.5pt solid black;
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
 <o:shapedefaults v:ext="edit" spidmax="6146"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=EN-US style='tab-interval:.5in'>
<%	for(int i=0;i<irow;i++)
	{ 
%>
<div class=Section1>

<p class=MsoNormal align=center style='text-align:center;line-height:150%'><span
style='font-size:24.0pt;line-height:150%;mso-fareast-font-family:"Times New Roman";
mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:bold'>THẺ NHÂN SỰ<o:p></o:p></span></p>

<p class=MsoNormal style='line-height:150%'><span style='font-size:14.0pt;
line-height:150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:
EN-US;mso-bidi-font-weight:bold'>Số thẻ:<span style='mso-spacerun:yes'> 
</span></span><!--[if supportFields]><span style='font-size:14.0pt;line-height:
150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
mso-bidi-font-weight:bold'><span style='mso-element:field-begin'></span><span
style='mso-spacerun:yes'> </span>MERGEFIELD the </span><![endif]--><!--[if supportFields]><span
style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:"Times New Roman";
mso-ansi-language:EN-US;mso-bidi-font-weight:bold'><span style='mso-element:
field-end'></span></span><![endif]--><span style='font-size:14.0pt;line-height:
150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
mso-bidi-font-weight:bold'><%=dt_total.Rows[i][0].ToString()%><o:p></o:p></span></p>

<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;border:none;mso-border-alt:solid black .5pt;
 mso-yfti-tbllook:1184;mso-padding-alt:0in 5.4pt 0in 5.4pt;mso-border-insideh:
 .5pt solid black;mso-border-insidev:.5pt solid black'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes'>
  <td width=149 colspan=3 valign=top style='width:111.75pt;border:solid black 1.0pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=right style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:right;line-height:150%'><span style='mso-bidi-font-size:14.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:
  EN-US;font-weight:normal;mso-bidi-font-weight:bold'>Ngày vào:<o:p></o:p></span></p>
  </td>
  <td width=151 colspan=6 valign=top style='width:113.4pt;border:solid black 1.0pt;
  border-left:none;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;mso-bidi-font-weight:bold'><%=dt_total.Rows[i][1].ToString()%><o:p></o:p></span></p>
  </td>
  <td width=66 colspan=2 valign=top style='width:49.6pt;border:solid black 1.0pt;
  border-left:none;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=right style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:right;line-height:150%'><span style='mso-bidi-font-size:14.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:
  EN-US;font-weight:normal;mso-bidi-font-weight:bold'>Xưởng:<o:p></o:p></span></p>
  </td>
  <td width=57 colspan=2 valign=top style='width:42.5pt;border:solid black 1.0pt;
  border-left:none;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;mso-bidi-font-weight:bold'><%=dt_total.Rows[i][2].ToString()%><o:p></o:p></span></p>
  </td>
  <td width=38 colspan=2 valign=top style='width:28.35pt;border:solid black 1.0pt;
  border-left:none;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=right style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:right;line-height:150%'><span style='mso-bidi-font-size:14.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:
  EN-US;font-weight:normal;mso-bidi-font-weight:bold'>Tổ:<o:p></o:p></span></p>
  </td>
  <td width=95 colspan=6 valign=top style='width:70.9pt;border:solid black 1.0pt;
  border-left:none;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;mso-bidi-font-weight:bold'><%=dt_total.Rows[i][3].ToString()%><o:p></o:p></span></p>
  </td>
  <td width=94 colspan=2 valign=top style='width:70.85pt;border:solid black 1.0pt;
  border-left:none;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='mso-bidi-font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'>Chức danh:<o:p></o:p></span></p>
  </td>
  <td width=111 colspan=3 valign=top style='width:83.35pt;border:solid black 1.0pt;
  border-left:none;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;mso-bidi-font-weight:bold'><%=dt_total.Rows[i][4].ToString()%><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1'>
  <td width=149 colspan=3 rowspan=2 valign=top style='width:111.75pt;
  border-top:none;border-left:solid black 1.0pt;border-bottom:none;border-right:
  solid black 1.0pt;mso-border-top-alt:solid black .5pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-right-alt:
  solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='mso-bidi-font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=123 colspan=4 valign=top style='width:70pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=right style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:right;line-height:150%'><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>Họ và tên</span><span
  style='mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
  font-weight:normal;mso-bidi-font-weight:bold'>:<o:p></o:p></span></p>
  </td>
  <td width=226 colspan=11 valign=top style='width:190pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;mso-bidi-font-weight:bold'><%=dt_total.Rows[i][5].ToString()%><o:p></o:p></span></p>
  </td>
  <td width=151 colspan=5 valign=top style='width:113.4pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=right style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span lang=VI style='font-size:11.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>Ngày tháng
  năm</span><span lang=VI style='font-size:11.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'> </span><span lang=VI style='font-size:11.0pt;line-height:150%;
  mso-fareast-font-family:"Times New Roman";font-weight:normal;mso-bidi-font-weight:
  bold'>sinh</span><span style='font-size:11.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'>: <o:p></o:p></span></p>
  </td>
  <td width=111 colspan=3 valign=top style='width:83.35pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;mso-bidi-font-weight:bold'><%=dt_total.Rows[i][6].ToString()%><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2'>
  <td width=123 colspan=4 valign=bottom style='width:70pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=right style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:right;line-height:150%'><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>Số CMNT</span><span
  style='mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
  font-weight:normal;mso-bidi-font-weight:bold'>:<o:p></o:p></span></p>
  </td>
  <td width=226 colspan=11 valign=top style='width:190pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'><%=dt_total.Rows[i][7].ToString()%><o:p></o:p></span></p>
  </td>
  <td width=151 colspan=5 valign=bottom style='width:113.4pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=right style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:right;line-height:150%'><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>Điện thoại</span><span
  style='mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
  font-weight:normal;mso-bidi-font-weight:bold'>:<o:p></o:p></span></p>
  </td>
  <td width=111 colspan=3 valign=top style='width:83.35pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'><%=dt_total.Rows[i][8].ToString()%><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3'>
  <td width=149 colspan=3 valign=top style='width:111.75pt;border-top:none;
  border-left:solid black 1.0pt;border-bottom:none;border-right:solid black 1.0pt;
  mso-border-left-alt:solid black .5pt;mso-border-right-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='mso-bidi-font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=123 colspan=4 valign=bottom style='width:70pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=right style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:right;line-height:150%'><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>Giới tính</span><span
  style='mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
  font-weight:normal;mso-bidi-font-weight:bold'>:<o:p></o:p></span></p>
  </td>
  <td width=489 colspan=19 valign=top style='width:366.5pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;mso-bidi-font-weight:bold'><%=dt_total.Rows[i][9].ToString()%><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:4'>
  <td width=149 colspan=3 valign=top style='width:111.75pt;border:solid black 1.0pt;
  border-top:none;mso-border-left-alt:solid black .5pt;mso-border-bottom-alt:
  solid black .5pt;mso-border-right-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='mso-bidi-font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=123 colspan=4 valign=top style='width:70pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=right style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:right;line-height:150%'><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>Địa chỉ</span><span
  style='mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
  font-weight:normal;mso-bidi-font-weight:bold'>:</span><span style='mso-bidi-font-size:
  14.0pt;line-height:150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:
  EN-US;font-weight:normal;mso-bidi-font-weight:bold'><o:p></o:p></span></p>
  </td>
  <td width=489 colspan=19 valign=top style='width:366.5pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span lang=FR style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:FR;font-weight:normal;mso-bidi-font-weight:
  bold'><%=dt_total.Rows[i][10].ToString()%><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:5'>
  <td width=124 colspan=2 rowspan=4 style='width:93.15pt;border:solid black 1.0pt;
  border-top:none;mso-border-top-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=FR style='mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:FR;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";mso-bidi-font-weight:bold'>Quan hệ gia đ</span><span
  style='mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
  mso-bidi-font-weight:bold'>ì</span><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";mso-bidi-font-weight:bold'>nh<o:p></o:p></span></p>
  </td>
  <td width=83 colspan=3 style='width:62.2pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>Quan hệ<o:p></o:p></span></p>
  </td>
  <td width=225 colspan=9 style='width:169.0pt;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>Họ và tên<o:p></o:p></span></p>
  </td>
  <td width=95 colspan=5 style='width:71.2pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span style='mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'>Năm Sinh<o:p></o:p></span></p>
  </td>
  <td width=132 colspan=5 style='width:98.9pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>Tr</span><span
  style='mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
  font-weight:normal;mso-bidi-font-weight:bold'>ì</span><span lang=VI
  style='mso-fareast-font-family:"Times New Roman";font-weight:normal;
  mso-bidi-font-weight:bold'>nh độ văn hóa<o:p></o:p></span></p>
  </td>
  <td width=102 colspan=2 style='width:76.25pt;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>Nghề nghiệp<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:6'>
  <td width=83 colspan=3 style='width:62.2pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>Bố<o:p></o:p></span></p>
  </td>
  <td width=225 colspan=9 style='width:169.0pt;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><!--[if supportFields]><span lang=VI style='font-size:14.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";font-weight:normal;
  mso-bidi-font-weight:bold'><span style='mso-element:field-begin'></span><span
  style='mso-spacerun:yes'> </span>MERGEFIELD ho_ten_bo </span><![endif]--><!--[if supportFields]><span
  lang=VI style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'><span
  style='mso-element:field-end'></span></span><![endif]--><span lang=VI
  style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:"Times New Roman";
  font-weight:normal;mso-bidi-font-weight:bold'><o:p></o:p></span></p>
  </td>
  <td width=95 colspan=5 style='width:71.2pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><!--[if supportFields]><span lang=VI
  style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:"Times New Roman";
  font-weight:normal;mso-bidi-font-weight:bold'><span style='mso-element:field-begin'></span><span
  style='mso-spacerun:yes'> </span>MERGEFIELD ns_bo </span><![endif]--><!--[if supportFields]><span
  lang=VI style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'><span
  style='mso-element:field-end'></span></span><![endif]--><span lang=VI
  style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:"Times New Roman";
  font-weight:normal;mso-bidi-font-weight:bold'><o:p></o:p></span></p>
  </td>
  <td width=132 colspan=5 style='width:98.9pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:14.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";font-weight:normal;
  mso-bidi-font-weight:bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=102 colspan=2 style='width:76.25pt;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:14.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";font-weight:normal;
  mso-bidi-font-weight:bold'>&nbsp;<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:7'>
  <td width=83 colspan=3 style='width:62.2pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>&nbsp;Mẹ<o:p></o:p></span></p>
  </td>
  <td width=225 colspan=9 style='width:169.0pt;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><!--[if supportFields]><span lang=VI style='font-size:14.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";font-weight:normal;
  mso-bidi-font-weight:bold'><span style='mso-element:field-begin'></span><span
  style='mso-spacerun:yes'> </span>MERGEFIELD ho_ten_me </span><![endif]--><!--[if supportFields]><span
  lang=VI style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'><span
  style='mso-element:field-end'></span></span><![endif]--><span lang=VI
  style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:"Times New Roman";
  font-weight:normal;mso-bidi-font-weight:bold'><o:p></o:p></span></p>
  </td>
  <td width=95 colspan=5 style='width:71.2pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><!--[if supportFields]><span lang=VI
  style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:"Times New Roman";
  font-weight:normal;mso-bidi-font-weight:bold'><span style='mso-element:field-begin'></span><span
  style='mso-spacerun:yes'> </span>MERGEFIELD ns_me </span><![endif]--><!--[if supportFields]><span
  lang=VI style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'><span
  style='mso-element:field-end'></span></span><![endif]--><span lang=VI
  style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:"Times New Roman";
  font-weight:normal;mso-bidi-font-weight:bold'><o:p></o:p></span></p>
  </td>
  <td width=132 colspan=5 style='width:98.9pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:14.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";font-weight:normal;
  mso-bidi-font-weight:bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=102 colspan=2 style='width:76.25pt;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:14.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";font-weight:normal;
  mso-bidi-font-weight:bold'>&nbsp;<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:8'>
  <td width=83 colspan=3 style='width:62.2pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=225 colspan=9 style='width:169.0pt;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:14.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";font-weight:normal;
  mso-bidi-font-weight:bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=95 colspan=5 style='width:71.2pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:14.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";font-weight:normal;
  mso-bidi-font-weight:bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=132 colspan=5 style='width:98.9pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:14.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";font-weight:normal;
  mso-bidi-font-weight:bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=102 colspan=2 style='width:76.25pt;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:14.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";font-weight:normal;
  mso-bidi-font-weight:bold'>&nbsp;<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:9'>
  <td width=124 colspan=2 rowspan=4 valign=top style='width:93.15pt;border:
  solid black 1.0pt;border-top:none;mso-border-top-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span lang=VI style='mso-fareast-font-family:"Times New Roman";
  mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span lang=VI style='mso-fareast-font-family:"Times New Roman";
  mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span lang=VI style='mso-fareast-font-family:"Times New Roman";
  mso-bidi-font-weight:bold'>Kinh nghiệm công tác trước khi vào công ty</span><span
  lang=VI style='mso-bidi-font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-bidi-font-weight:bold'><o:p></o:p></span></p>
  </td>
  <td width=138 colspan=4 style='width:103.65pt;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>Thời gian<o:p></o:p></span></p>
  </td>
  <td width=227 colspan=11 style='width:170.1pt;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>Tên công ty<o:p></o:p></span></p>
  </td>
  <td width=124 colspan=5 style='width:93.15pt;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>Chức vụ<o:p></o:p></span></p>
  </td>
  <td width=148 colspan=4 style='width:110.65pt;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>Nghề nghiệp<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:10'>
  <td width=138 colspan=4 valign=top style='width:103.65pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=227 colspan=11 valign=top style='width:170.1pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=124 colspan=5 valign=top style='width:93.15pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=148 colspan=4 valign=top style='width:110.65pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:11'>
  <td width=138 colspan=4 valign=top style='width:103.65pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=227 colspan=11 valign=top style='width:170.1pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=124 colspan=5 valign=top style='width:93.15pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=148 colspan=4 valign=top style='width:110.65pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:12;height:28.05pt'>
  <td width=138 colspan=4 valign=top style='width:103.65pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt;height:28.05pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=227 colspan=11 valign=top style='width:170.1pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt;height:28.05pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=124 colspan=5 valign=top style='width:93.15pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt;height:28.05pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=148 colspan=4 valign=top style='width:110.65pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt;height:28.05pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:13'>
  <td width=124 colspan=2 rowspan=6 valign=top style='width:93.15pt;border:
  solid black 1.0pt;border-top:none;mso-border-top-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span lang=VI style='mso-fareast-font-family:"Times New Roman";
  mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span lang=VI style='mso-fareast-font-family:"Times New Roman";
  mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span lang=VI style='mso-fareast-font-family:"Times New Roman";
  mso-bidi-font-weight:bold'>Thay đổi lương và chức vụ</span><span lang=VI
  style='mso-bidi-font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-bidi-font-weight:bold'><o:p></o:p></span></p>
  </td>
  <td width=81 colspan=2 style='width:61.1pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:10.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";font-weight:normal;
  mso-bidi-font-weight:bold'>Ngày<o:p></o:p></span></p>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:10.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";font-weight:normal;
  mso-bidi-font-weight:bold'>(date)<o:p></o:p></span></p>
  </td>
  <td width=57 colspan=2 style='width:42.55pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:10.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";font-weight:normal;
  mso-bidi-font-weight:bold'>Bậc<br>
  (Grade)<o:p></o:p></span></p>
  </td>
  <td width=94 colspan=4 style='width:70.85pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:10.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";font-weight:normal;
  mso-bidi-font-weight:bold'>Lương<br>
  (Salary)<o:p></o:p></span></p>
  </td>
  <td width=57 colspan=2 style='width:42.55pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:10.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";font-weight:normal;
  mso-bidi-font-weight:bold'>Ngày<br>
  (date)<o:p></o:p></span></p>
  </td>
  <td width=57 colspan=4 style='width:42.5pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:10.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";font-weight:normal;
  mso-bidi-font-weight:bold'>Bậc<br>
  (Grade)<o:p></o:p></span></p>
  </td>
  <td width=66 colspan=4 style='width:49.5pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:10.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";font-weight:normal;
  mso-bidi-font-weight:bold'>Lương<br>
  (Salary)<o:p></o:p></span></p>
  </td>
  <td width=77 colspan=2 style='width:57.85pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:10.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";font-weight:normal;
  mso-bidi-font-weight:bold'>Ngày<br>
  (date)<o:p></o:p></span></p>
  </td>
  <td width=60 colspan=3 style='width:44.8pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:10.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";font-weight:normal;
  mso-bidi-font-weight:bold'>Bậc<br>
  (Grade)<o:p></o:p></span></p>
  </td>
  <td width=88 style='width:65.85pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:10.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";font-weight:normal;
  mso-bidi-font-weight:bold'>Lương<br>
  (Salary)<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:14'>
  <td width=81 colspan=2 valign=bottom style='width:61.1pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='font-size:11.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=57 colspan=2 style='width:42.55pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><!--[if supportFields]><span lang=VI
  style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:bold'><span
  style='mso-element:field-begin'></span><span
  style='mso-spacerun:yes'> </span>MERGEFIELD bl1 </span><![endif]--><!--[if supportFields]><span
  lang=VI style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'><span style='mso-element:field-end'></span></span><![endif]--><span
  lang=VI style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'><o:p></o:p></span></p>
  </td>
  <td width=94 colspan=4 style='width:70.85pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=right style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:right;line-height:150%'><span style='mso-fareast-font-family:"Times New Roman";
  mso-ansi-language:EN-US;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=57 colspan=2 style='width:42.55pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:11.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=57 colspan=4 style='width:42.5pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=66 colspan=4 style='width:49.5pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=77 colspan=2 style='width:57.85pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span style='font-size:9.0pt;line-height:
  150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
  mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=60 colspan=3 style='width:44.8pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=88 style='width:65.85pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:15'>
  <td width=81 colspan=2 style='width:61.1pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  150%'><span style='mso-fareast-font-family:"Times New Roman";mso-ansi-language:
  EN-US;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=57 colspan=2 style='width:42.55pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><!--[if supportFields]><span lang=VI
  style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:bold'><span
  style='mso-element:field-begin'></span><span
  style='mso-spacerun:yes'> </span>MERGEFIELD bl_2 </span><![endif]--><!--[if supportFields]><span
  lang=VI style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'><span style='mso-element:field-end'></span></span><![endif]--><span
  lang=VI style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'><o:p></o:p></span></p>
  </td>
  <td width=94 colspan=4 style='width:70.85pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=right style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:right;line-height:150%'><!--[if supportFields]><span lang=VI
  style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:bold'><span
  style='mso-element:field-begin'></span><span
  style='mso-spacerun:yes'> </span>MERGEFIELD luong_2 </span><![endif]--><!--[if supportFields]><span
  lang=VI style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'><span style='mso-element:field-end'></span></span><![endif]--><span
  lang=VI style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'><o:p></o:p></span></p>
  </td>
  <td width=57 colspan=2 style='width:42.55pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:11.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=57 colspan=4 style='width:42.5pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=66 colspan=4 style='width:49.5pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=77 colspan=2 style='width:57.85pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=60 colspan=3 style='width:44.8pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=88 style='width:65.85pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:16'>
  <td width=81 colspan=2 style='width:61.1pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=57 colspan=2 style='width:42.55pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=94 colspan=4 style='width:70.85pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=57 colspan=2 style='width:42.55pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=57 colspan=4 style='width:42.5pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=66 colspan=4 style='width:49.5pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=77 colspan=2 style='width:57.85pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=60 colspan=3 style='width:44.8pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=88 style='width:65.85pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:17'>
  <td width=81 colspan=2 style='width:61.1pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=57 colspan=2 style='width:42.55pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=94 colspan=4 style='width:70.85pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=57 colspan=2 style='width:42.55pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=57 colspan=4 style='width:42.5pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=66 colspan=4 style='width:49.5pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=77 colspan=2 style='width:57.85pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=60 colspan=3 style='width:44.8pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=88 style='width:65.85pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:18'>
  <td width=81 colspan=2 style='width:61.1pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=57 colspan=2 style='width:42.55pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=94 colspan=4 style='width:70.85pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=57 colspan=2 style='width:42.55pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=57 colspan=4 style='width:42.5pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=66 colspan=4 style='width:49.5pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=77 colspan=2 style='width:57.85pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=60 colspan=3 style='width:44.8pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
  <td width=88 style='width:65.85pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='font-size:9.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>&nbsp;<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:19'>
  <td width=102 rowspan=6 style='width:76.3pt;border:solid black 1.0pt;
  border-top:none;mso-border-top-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-top:3.0pt;margin-right:0in;
  margin-bottom:3.0pt;margin-left:0in;text-align:center;line-height:150%'><span
  lang=VI style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:
  bold'>Quan hệ thưởng phạt<o:p></o:p></span></p>
  </td>
  <td width=104 colspan=3 rowspan=3 valign=top style='width:77.95pt;border-top:
  none;border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span style='mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span style='mso-bidi-font-size:14.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:
  EN-US;font-weight:normal;mso-bidi-font-weight:bold'>Thưởng <o:p></o:p></span></p>
  </td>
  <td width=85 colspan=4 valign=top style='width:63.8pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>Ngày</span><span
  style='mso-bidi-font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p></o:p></span></p>
  </td>
  <td width=246 colspan=12 valign=top style='width:184.15pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>Lý Do</span><span
  style='mso-bidi-font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p></o:p></span></p>
  </td>
  <td width=225 colspan=6 valign=top style='width:168.5pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>H</span><span
  style='mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
  font-weight:normal;mso-bidi-font-weight:bold'>ì</span><span lang=VI
  style='mso-fareast-font-family:"Times New Roman";font-weight:normal;
  mso-bidi-font-weight:bold'>nh thức thưởng</span><span style='mso-bidi-font-size:
  14.0pt;line-height:150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:
  EN-US;font-weight:normal;mso-bidi-font-weight:bold'><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:20'>
  <td width=85 colspan=4 valign=top style='width:63.8pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span style='font-size:14.0pt;line-height:
  150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
  font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=246 colspan=12 valign=top style='width:184.15pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span style='font-size:14.0pt;line-height:
  150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
  font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=225 colspan=6 valign=top style='width:168.5pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span style='font-size:14.0pt;line-height:
  150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
  font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:21'>
  <td width=85 colspan=4 valign=top style='width:63.8pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span style='font-size:14.0pt;line-height:
  150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
  font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=246 colspan=12 valign=top style='width:184.15pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span style='font-size:14.0pt;line-height:
  150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
  font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=225 colspan=6 valign=top style='width:168.5pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span style='font-size:14.0pt;line-height:
  150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
  font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:22'>
  <td width=104 colspan=3 rowspan=3 valign=top style='width:77.95pt;border-top:
  none;border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span style='mso-bidi-font-size:14.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:
  EN-US;font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span style='mso-bidi-font-size:14.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:
  EN-US;font-weight:normal;mso-bidi-font-weight:bold'>Phạt<o:p></o:p></span></p>
  </td>
  <td width=85 colspan=4 valign=top style='width:63.8pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>Ngày</span><span
  style='mso-bidi-font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p></o:p></span></p>
  </td>
  <td width=246 colspan=12 valign=top style='width:184.15pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>Lý do</span><span
  style='mso-bidi-font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p></o:p></span></p>
  </td>
  <td width=225 colspan=6 valign=top style='width:168.5pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>Kết quả xử lý</span><span
  style='mso-bidi-font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:23'>
  <td width=85 colspan=4 valign=top style='width:63.8pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span style='font-size:14.0pt;line-height:
  150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
  font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=246 colspan=12 valign=top style='width:184.15pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span style='font-size:14.0pt;line-height:
  150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
  font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=225 colspan=6 valign=top style='width:168.5pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span style='font-size:14.0pt;line-height:
  150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
  font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:24'>
  <td width=85 colspan=4 valign=top style='width:63.8pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span style='font-size:14.0pt;line-height:
  150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
  font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=246 colspan=12 valign=top style='width:184.15pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span style='font-size:14.0pt;line-height:
  150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
  font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=225 colspan=6 valign=top style='width:168.5pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span style='font-size:14.0pt;line-height:
  150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
  font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:25'>
  <td width=102 rowspan=2 valign=top style='width:76.3pt;border-top:none;
  border-left:solid black 1.0pt;border-bottom:solid black 1.0pt;border-right:
  none;mso-border-top-alt:solid black .5pt;mso-border-top-alt:solid black .5pt;
  mso-border-left-alt:solid black .5pt;mso-border-bottom-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span lang=VI style='mso-fareast-font-family:
  "Times New Roman";mso-bidi-font-weight:bold'>Trạng thái làm việc</span><span
  style='mso-bidi-font-size:14.0pt;line-height:150%;mso-fareast-font-family:
  "Times New Roman";mso-ansi-language:EN-US;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p></o:p></span></p>
  </td>
  <td width=104 colspan=3 rowspan=2 valign=top style='width:77.95pt;border-top:
  none;border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-top-alt:solid black .5pt;
  mso-border-bottom-alt:solid black .5pt;mso-border-right-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span style='mso-bidi-font-size:14.0pt;
  line-height:150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:
  EN-US;font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=555 colspan=22 valign=top style='width:416.45pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span style='font-size:14.0pt;line-height:
  150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
  font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:26;mso-yfti-lastrow:yes'>
  <td width=555 colspan=22 valign=top style='width:416.45pt;border-top:none;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .5pt;mso-border-left-alt:solid black .5pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:150%'><span style='font-size:14.0pt;line-height:
  150%;mso-fareast-font-family:"Times New Roman";mso-ansi-language:EN-US;
  font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <![if !supportMisalignedColumns]>
 <tr height=0>
  
 </tr>
 <![endif]>
</table>

<%if(i<irow)
	{%>
<b><span style='font-size:12.0pt;font-family:"Times New Roman";mso-fareast-font-family:
"Times New Roman";mso-ansi-language:EN-US;mso-fareast-language:EN-US;
mso-bidi-language:AR-SA'><br clear=all style='page-break-before:always'>
</span></b>
<%	}%>

</div>
<%	} %>
</body>

</html>
