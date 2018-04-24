
<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/msword";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html 
xmlns:w="urn:schemas-microsoft-com:office:word"
xmlns:st1="urn:schemas-microsoft-com:office:smarttags"
xmlns="http://www.w3.org/TR/REC-html40">
<%
   
   string emp_pk;
    
    emp_pk       = Request["emp_pk"].ToString();
    string SQL = " select  " 
        + "a.FULL_NAME  "//0
        + ",a.social_no as health_no " //3
        + ",(select b.code_nm from vhr_hr_code b where  b.id='HR0132' and b.code=e.content) " 
        +",e.old " // 7
        + ",e.new " // 8
        + ",e.reason " //9
        + "from thr_employee a,thr_ins_modify e "
        + "where a.del_if=0 and e.del_if=0 and e.thr_emp_pk =a.pk "
       + " and e.pk in (" + emp_pk + ") order by e.content" ;
       
   //Response.Write(SQL);
//Response.End();
    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt_total.Rows.Count;
    if (irow == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
     SQL
    = "select code_fnm,to_char(sysdate,'dd/mm/yyyy')  " +
        "from vhr_hr_code " +
        "where id='HR0049'  order by code ";
    DataTable dt_name = ESysLib.TableReadOpen(SQL);
    int irow_name;
    irow_name = dt_name.Rows.Count;
    if (irow_name <7)
    {
        Response.Write("You have to input enough information of HR0049 code");
        Response.End();
    }
   
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 11">
<meta name=Originator content="Microsoft Word 11">
<link rel=File-List href="rpt_D01b_TS_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_D01b_TS_files/editdata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<title>BẢO HIỂM XÃ HỘI VIỆT NAM</title>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="country-region" downloadurl="http://www.5iantlavalamp.com/"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="place" downloadurl="http://www.5iantlavalamp.com/"/>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Yen</o:Author>
  <o:LastAuthor>ty-ml</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>295</o:TotalTime>
  <o:LastPrinted>2008-07-22T04:19:00Z</o:LastPrinted>
  <o:Created>2008-07-22T06:21:00Z</o:Created>
  <o:LastSaved>2008-07-22T06:21:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>1056</o:Words>
  <o:Characters>6022</o:Characters>
  <o:Company>VinaGenuWin</o:Company>
  <o:Lines>50</o:Lines>
  <o:Paragraphs>14</o:Paragraphs>
  <o:CharactersWithSpaces>7064</o:CharactersWithSpaces>
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
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:1627421319 -2147483648 8 0 66047 0;}
@font-face
	{font-family:"\.VnTimeH";
	panose-1:2 11 114 0 0 0 0 0 0 0;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:7 0 0 0 19 0;}
@font-face
	{font-family:"\.VnTime";
	panose-1:2 11 114 0 0 0 0 0 0 0;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:3 0 0 0 1 0;}
@font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:536871559 0 0 0 415 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";
	mso-ansi-language:EN-US;
	mso-fareast-language:EN-US;}
h1
	{mso-style-next:Normal;
	margin:0in;
	margin-bottom:.0001pt;
	text-align:center;
	line-height:18.0pt;
	mso-line-height-rule:exactly;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:1;
	font-size:16.0pt;
	font-family:"\.VnTimeH";
	mso-font-kerning:0pt;
	mso-ansi-language:EN-US;
	mso-fareast-language:EN-US;
	font-weight:bold;
	mso-bidi-font-weight:normal;}
h2
	{mso-style-next:Normal;
	margin-top:6.0pt;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:0in;
	margin-bottom:.0001pt;
	text-align:right;
	text-indent:.5in;
	line-height:21.0pt;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:2;
	font-size:11.0pt;
	font-family:"Times New Roman";
	mso-ansi-language:EN-US;
	mso-fareast-language:EN-US;
	font-weight:bold;}
h4
	{mso-style-next:Normal;
	margin:0in;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:.5in;
	line-height:150%;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:4;
	font-size:14.0pt;
	mso-bidi-font-size:12.0pt;
	font-family:"\.VnTime";
	mso-ansi-language:EN-US;
	mso-fareast-language:EN-US;
	font-weight:bold;}
h5
	{mso-style-next:Normal;
	margin:0in;
	margin-bottom:.0001pt;
	text-align:center;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:5;
	font-size:12.0pt;
	font-family:"\.VnTimeH";
	mso-ansi-language:EN-US;
	mso-fareast-language:EN-US;
	font-weight:bold;}
h6
	{mso-style-next:Normal;
	margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	mso-pagination:widow-orphan;
	mso-outline-level:6;
	font-size:11.0pt;
	font-family:"Times New Roman";
	mso-ansi-language:EN-US;
	mso-fareast-language:EN-US;
	font-weight:bold;}
p.MsoHeader, li.MsoHeader, div.MsoHeader
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	tab-stops:center 3.0in right 6.0in;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";
	mso-ansi-language:EN-US;
	mso-fareast-language:EN-US;}
p.MsoFooter, li.MsoFooter, div.MsoFooter
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	tab-stops:center 207.65pt right 415.3pt;
	font-size:14.0pt;
	mso-bidi-font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";
	mso-ansi-language:VI;
	mso-fareast-language:VI;}
span.MsoPageNumber
	{font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";}
p.MsoBodyTextIndent, li.MsoBodyTextIndent, div.MsoBodyTextIndent
	{mso-style-link:" Char Char";
	margin-top:6.0pt;
	margin-right:0in;
	margin-bottom:4.0pt;
	margin-left:0in;
	text-align:justify;
	text-indent:.5in;
	line-height:18.0pt;
	mso-pagination:widow-orphan;
	font-size:14.0pt;
	font-family:"\.VnTime";
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"\.VnTime";
	mso-ansi-language:EN-US;
	mso-fareast-language:EN-US;}
p.MsoDocumentMap, li.MsoDocumentMap, div.MsoDocumentMap
	{mso-style-noshow:yes;
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	background:navy;
	font-size:10.0pt;
	font-family:Tahoma;
	mso-fareast-font-family:"Times New Roman";
	mso-ansi-language:EN-US;
	mso-fareast-language:EN-US;}
p
	{mso-style-noshow:yes;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";
	mso-ansi-language:EN-GB;
	mso-fareast-language:EN-GB;}
span.CharChar
	{mso-style-name:" Char Char";
	mso-style-locked:yes;
	mso-style-link:"Body Text Indent";
	mso-ansi-font-size:14.0pt;
	mso-bidi-font-size:14.0pt;
	font-family:"\.VnTime";
	mso-ascii-font-family:"\.VnTime";
	mso-hansi-font-family:"\.VnTime";
	mso-bidi-font-family:"\.VnTime";
	mso-ansi-language:EN-US;
	mso-fareast-language:EN-US;
	mso-bidi-language:AR-SA;}
p.Char, li.Char, div.Char
	{mso-style-name:" Char";
	mso-style-link:"Default Paragraph Font";
	margin-top:0in;
	margin-right:0in;
	margin-bottom:8.0pt;
	margin-left:0in;
	line-height:12.0pt;
	mso-line-height-rule:exactly;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	mso-ansi-language:EN-US;
	mso-fareast-language:EN-US;}
 /* Page Definitions */
@page
	{mso-footnote-separator:url("rpt_D01b_TS_files/header.htm") fs;
	mso-footnote-continuation-separator:url("rpt_D01b_TS_files/header.htm") fcs;
	mso-endnote-separator:url("rpt_D01b_TS_files/header.htm") es;
	mso-endnote-continuation-separator:url("rpt_D01b_TS_files/header.htm") ecs;}
@page Section1
	{size:595.35pt 842.0pt;
	margin:27.0pt 49.35pt .25in 26.0pt;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-even-footer:url("rpt_D01b_TS_files/header.htm") ef1;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
@page Section2
	{size:841.9pt 595.3pt;
	mso-page-orientation:landscape;
	margin:.5in 28.35pt 28.35pt 28.35pt;
	mso-header-margin:35.45pt;
	mso-footer-margin:35.45pt;
	mso-page-numbers:1;
	mso-title-page:yes;
	mso-even-footer:url("rpt_D01b_TS_files/header.htm") ef1;
	mso-paper-source:0;}
div.Section2
	{page:Section2;}
@page Section3
	{size:595.45pt 841.7pt;
	margin:28.1pt 28.1pt 28.1pt .5in;
	mso-header-margin:35.3pt;
	mso-footer-margin:35.3pt;
	mso-page-numbers:1;
	mso-title-page:yes;
	mso-even-footer:url("rpt_D01b_TS_files/header.htm") ef1;
	mso-paper-source:0;}
div.Section3
	{page:Section3;}

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
	mso-fareast-language:#0400;}
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

<table class=MsoTableGrid border=0 cellspacing=0 cellpadding=0 align=left
 width=735 style='width:551.4pt;border-collapse:collapse;mso-yfti-tbllook:480;
 mso-table-lspace:9.0pt;margin-left:6.75pt;mso-table-rspace:9.0pt;margin-right:
 6.75pt;mso-table-anchor-vertical:margin;mso-table-anchor-horizontal:margin;
 mso-table-left:left;mso-table-top:45.1pt;mso-padding-alt:0in 5.4pt 0in 5.4pt'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:45.0pt'>
  <td width=270 valign=top style='width:202.6pt;padding:0in 5.4pt 0in 5.4pt;
  height:45.0pt'>
  <p class=MsoNormal style='mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-horizontal:margin;mso-element-top:
  45.1pt;mso-height-rule:exactly'><b style='mso-bidi-font-weight:normal'><span
  lang=PT-BR style='font-size:14.0pt;mso-bidi-font-size:12.0pt;mso-ansi-language:
  PT-BR'>Đơn vị: </span></b><%=dt_name.Rows[0][0].ToString() %><b style='mso-bidi-font-weight:normal'><span
  lang=PT-BR style='font-size:14.0pt;mso-bidi-font-size:12.0pt;mso-ansi-language:
  PT-BR'><o:p></o:p></span></b></p>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:
  3.0pt;margin-left:0in;text-align:justify;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-horizontal:margin;
  mso-element-top:45.1pt;mso-height-rule:exactly'><span lang=PT-BR
  style='font-size:14.0pt;mso-bidi-font-size:12.0pt;mso-ansi-language:PT-BR'>Số:
  </span><span lang=PT-BR style='font-size:14.0pt;mso-bidi-font-size:12.0pt'><span
  style='mso-spacerun:yes'> </span></span><span style='font-size:14.0pt;
  mso-bidi-font-size:12.0pt'><%=dt_name.Rows[1][0].ToString() %><o:p></o:p></span></p>
  </td>
  <td width=465 valign=top style='width:348.8pt;padding:0in 5.4pt 0in 5.4pt;
  height:45.0pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-horizontal:
  margin;mso-element-top:45.1pt;mso-height-rule:exactly'><b style='mso-bidi-font-weight:
  normal'><span lang=PT-BR style='mso-ansi-language:PT-BR;mso-no-proof:yes'>CỘNG
  HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM<o:p></o:p></span></b></p>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-horizontal:
  margin;mso-element-top:45.1pt;mso-height-rule:exactly'><b style='mso-bidi-font-weight:
  normal'><span lang=PT-BR style='font-size:14.0pt;mso-bidi-font-size:12.0pt;
  mso-ansi-language:PT-BR'>Độc lập - Tự do - Hạnh phúc<o:p></o:p></span></b></p>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-horizontal:
  margin;mso-element-top:45.1pt;mso-height-rule:exactly'><!--[if gte vml 1]><v:line
   id="_x0000_s1139" style='position:absolute;left:0;text-align:left;z-index:1'
   from="96.95pt,51.1pt" to="261.1pt,51.1pt"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:1;left:0px;margin-left:
  128px;margin-top:67px;width:221px;height:2px'><img width=221 height=2
  src="rpt_D01b_TS_files/image001.gif" v:shapes="_x0000_s1139"></span><![endif]><b
  style='mso-bidi-font-weight:normal'><span lang=PT-BR style='font-size:14.0pt;
  mso-bidi-font-size:12.0pt;mso-ansi-language:PT-BR'><o:p></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1;mso-yfti-lastrow:yes;height:35.1pt'>
  <td width=270 valign=top style='width:202.6pt;padding:0in 5.4pt 0in 5.4pt;
  height:35.1pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-horizontal:
  margin;mso-element-top:45.1pt;mso-height-rule:exactly'><span lang=PT-BR
  style='mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-horizontal:
  margin;mso-element-top:45.1pt;mso-height-rule:exactly'><span lang=PT-BR
  style='mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-horizontal:
  margin;mso-element-top:45.1pt;mso-height-rule:exactly'><span lang=PT-BR
  style='mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=465 valign=top style='width:348.8pt;padding:0in 5.4pt 0in 5.4pt;
  height:35.1pt'>
  <p class=MsoNormal align=right style='margin-top:12.0pt;text-align:right;
  mso-element:frame;mso-element-frame-hspace:9.0pt;mso-element-wrap:around;
  mso-element-anchor-horizontal:margin;mso-element-top:45.1pt;mso-height-rule:
  exactly'><i style='mso-bidi-font-style:normal'><span style='font-size:14.0pt;
  mso-bidi-font-size:12.0pt'><%=dt_name.Rows[10][0].ToString() %>, ngày <%=dt_name.Rows[0][1].ToString().Substring(0,2) %> tháng <%=dt_name.Rows[0][1].ToString().Substring(3,2) %> năm <%=dt_name.Rows[0][1].ToString().Substring(6,4) %></span><o:p></o:p></i></p>
  </td>
 </tr>
</table>

<p class=MsoNormal align=center style='text-align:center'><span
style='mso-tab-count:1'>            </span><span style='mso-tab-count:7'>                                                                                    </span><b><span
style='font-size:9.0pt'>Mẫu số: D01b-TS<o:p></o:p></span></b></p>

<p class=MsoNormal align=center style='margin-left:3.5in;text-align:center;
text-indent:.5in'><i><span style='font-size:9.0pt'>(Ban hành kèm theo QĐ số:1111/QĐ-BHXH<o:p></o:p></span></i></p>

<p class=MsoNormal align=center style='text-align:center'><i><span
style='font-size:9.0pt'><span style='mso-spacerun:yes'> </span><span
style='mso-tab-count:8'>                                                                                                                               </span>ngày
25/10/2011 của BHXH Việt <st1:place w:st="on"><st1:country-region w:st="on">Nam</st1:country-region></st1:place>)<o:p></o:p></span></i></p>

<p class=MsoNormal style='tab-stops:58.5pt'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal align=center style='text-align:center'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal align=center style='text-align:center;mso-outline-level:
1'><span style='font-size:14.0pt;mso-bidi-font-size:12.0pt'>Kính gửi: Bảo hiểm
xã hội tỉnh <%=dt_name.Rows[10][0].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal><span style='font-size:14.0pt;mso-bidi-font-size:12.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:32.5pt;margin-bottom:.0001pt;text-align:justify;text-indent:.5in'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt'>- Tên đơn vị: <%=dt_name.Rows[0][0].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:3.0pt;
margin-left:32.5pt;text-align:justify;text-indent:.5in'><span style='font-size:
14.0pt;mso-bidi-font-size:12.0pt'>- Mã số quản lý: <%=dt_name.Rows[1][0].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:3.0pt;
margin-left:32.5pt;text-indent:.5in'><span style='font-size:14.0pt;mso-bidi-font-size:
12.0pt'>- Địa chỉ: </span><span style='font-size:14.0pt'><%=dt_name.Rows[2][0].ToString() %></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:3.0pt;
margin-left:32.5pt;text-indent:.5in'><span style='font-size:14.0pt;mso-bidi-font-size:
12.0pt'>-</span> <span style='font-size:14.0pt;mso-bidi-font-size:12.0pt'>ĐT: <%=dt_name.Rows[12][0].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:3.0pt;
margin-left:32.5pt;text-align:justify;text-indent:.5in;mso-outline-level:1'><b
style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;mso-bidi-font-size:
12.0pt'>Nội dung:<o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:3.0pt;
margin-left:39.0pt'><span lang=PT-BR style='font-size:14.0pt;mso-bidi-font-size:
12.0pt;mso-ansi-language:PT-BR'>.............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................<o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:3.0pt;
margin-left:35.15pt;text-indent:36.85pt;mso-outline-level:1'><b
style='mso-bidi-font-weight:normal'><span lang=PT-BR style='font-size:14.0pt;
mso-bidi-font-size:12.0pt;mso-ansi-language:PT-BR'>Lý do:<o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:3.0pt;
margin-left:32.5pt'><span lang=PT-BR style='font-size:14.0pt;mso-bidi-font-size:
12.0pt;mso-ansi-language:PT-BR'>.............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................<o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:3.0pt;
margin-left:.5in;text-align:justify;text-indent:.5in;mso-outline-level:1'><b
style='mso-bidi-font-weight:normal'><span lang=PT-BR style='font-size:14.0pt;
mso-bidi-font-size:12.0pt;mso-ansi-language:PT-BR'>Hồ sơ gửi kèm:<o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:3.0pt;
margin-left:39.0pt'><span lang=PT-BR style='font-size:14.0pt;mso-bidi-font-size:
12.0pt;mso-ansi-language:PT-BR'>......................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................<o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;text-indent:.5in'><span
lang=PT-BR style='font-size:14.0pt;mso-bidi-font-size:12.0pt;mso-ansi-language:
PT-BR'>Đề nghị cơ quan bảo hiểm xã hội xem xét, giải quyết theo quy định.<o:p></o:p></span></p>

<p class=MsoNormal><span lang=PT-BR style='font-size:14.0pt;mso-bidi-font-size:
12.0pt;mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center style='margin-left:2.0in;text-align:center;
mso-outline-level:1'><b style='mso-bidi-font-weight:normal'><span lang=PT-BR
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;mso-ansi-language:PT-BR'>Thủ
trưởng đơn vị<o:p></o:p></span></b></p>

<p class=MsoNormal align=center style='margin-left:2.0in;text-align:center'><i
style='mso-bidi-font-style:normal'><span lang=PT-BR style='font-size:14.0pt;
mso-bidi-font-size:12.0pt;mso-ansi-language:PT-BR'>(ký, đóng dấu và ghi rõ họ
tên)<o:p></o:p></span></i></p>

<p class=MsoNormal align=center style='margin-left:2.0in;text-align:center'><i
style='mso-bidi-font-style:normal'><span lang=PT-BR style='font-size:14.0pt;
mso-bidi-font-size:12.0pt;mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></i></p>

<p class=MsoNormal style='margin-left:2.0in'><i style='mso-bidi-font-style:
normal'><span lang=PT-BR style='font-size:14.0pt;mso-bidi-font-size:12.0pt;
mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></i></p>

<p class=MsoNormal align=center style='margin-left:2.0in;text-align:center;
mso-outline-level:1'><b style='mso-bidi-font-weight:normal'><span lang=PT-BR
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal align=center style='margin-left:2.0in;text-align:center;
mso-outline-level:1'><b style='mso-bidi-font-weight:normal'><span lang=PT-BR
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal align=center style='margin-left:2.0in;text-align:center;
mso-outline-level:1'><b style='mso-bidi-font-weight:normal'><span lang=PT-BR
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal align=center style='margin-left:2.0in;text-align:center;
mso-outline-level:1'><b style='mso-bidi-font-weight:normal'><span lang=PT-BR
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;mso-ansi-language:PT-BR'><%=dt_name.Rows[6][0].ToString() %><o:p></o:p></span></b></p>

</div>

<i style='mso-bidi-font-style:normal'><span lang=PT-BR style='font-size:12.0pt;
font-family:"Times New Roman";mso-fareast-font-family:"Times New Roman";
mso-ansi-language:PT-BR;mso-fareast-language:EN-US;mso-bidi-language:AR-SA'><br
clear=all style='page-break-before:always;mso-break-type:section-break'>
</span></i>

<div class=Section2>

<p class=MsoNormal><span lang=PT-BR style='font-size:14.0pt;mso-bidi-font-size:
12.0pt;mso-ansi-language:PT-BR'>Tên đơn vị: <%=dt_name.Rows[0][0].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal><span lang=PT-BR style='font-size:14.0pt;mso-bidi-font-size:
12.0pt;mso-ansi-language:PT-BR'>Mã số: <%=dt_name.Rows[1][0].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal><span lang=PT-BR style='font-size:14.0pt;mso-bidi-font-size:
12.0pt;mso-ansi-language:PT-BR'>Điện thoại: <%=dt_name.Rows[12][0].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal align=center style='text-align:center'><b style='mso-bidi-font-weight:
normal'><span lang=PT-BR style='font-size:16.0pt;mso-bidi-font-size:12.0pt;
mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal align=center style='text-align:center;mso-outline-level:
1'><b style='mso-bidi-font-weight:normal'><span lang=PT-BR style='font-size:
16.0pt;mso-bidi-font-size:12.0pt;mso-ansi-language:PT-BR'>DANH SÁCH ĐỀ NGHỊ<o:p></o:p></span></b></p>

<p class=MsoNormal align=center style='text-align:center'><i style='mso-bidi-font-style:
normal'><span lang=PT-BR style='font-size:14.0pt;mso-bidi-font-size:12.0pt;
mso-ansi-language:PT-BR'>(Kèm theo công văn số:....................
ngày......................)<o:p></o:p></span></i></p>

<p class=MsoNormal align=center style='text-align:center'><span lang=PT-BR
style='mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center style='text-align:center'><span lang=PT-BR
style='mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center style='text-align:center'><span lang=PT-BR
style='mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></p>

<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 width=1052
 style='width:789.3pt;border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-yfti-tbllook:480;mso-padding-alt:0in 5.4pt 0in 5.4pt;mso-border-insideh:
 .5pt solid windowtext;mso-border-insidev:.5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes'>
  <td width=51 valign=top style='width:37.9pt;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:0in;
  margin-bottom:6.0pt;margin-left:0in;text-align:center'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:14.0pt;mso-bidi-font-size:12.0pt'>STT<o:p></o:p></span></b></p>
  </td>
  <td width=165 valign=top style='width:200.5pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:0in;
  margin-bottom:6.0pt;margin-left:0in;text-align:center'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:14.0pt;mso-bidi-font-size:12.0pt'>Họ và tên<o:p></o:p></span></b></p>
  </td>
  <td width=78 valign=top style='width:58.5pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:0in;
  margin-bottom:6.0pt;margin-left:0in;text-align:center'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:14.0pt;mso-bidi-font-size:12.0pt'>Số sổ<o:p></o:p></span></b></p>
  </td>
  <td width=173 valign=top style='width:250.0pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:0in;
  margin-bottom:6.0pt;margin-left:0in;text-align:center'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:14.0pt;mso-bidi-font-size:12.0pt'>Nội dung đề
  nghị<o:p></o:p></span></b></p>
  </td>
  <td width=121 valign=top style='width:50.4pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:0in;
  margin-bottom:6.0pt;margin-left:0in;text-align:center'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:14.0pt;mso-bidi-font-size:12.0pt'>Cũ<o:p></o:p></span></b></p>
  </td>
  <td width=191 valign=top style='width:50.6pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:0in;
  margin-bottom:6.0pt;margin-left:0in;text-align:center'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:14.0pt;mso-bidi-font-size:12.0pt'>Mới<o:p></o:p></span></b></p>
  </td>
  <td width=274 valign=top style='width:100.4pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:0in;
  margin-bottom:6.0pt;margin-left:0in;text-align:center'><b style='mso-bidi-font-weight:
  normal'><span lang=PT-BR style='font-size:14.0pt;mso-bidi-font-size:12.0pt;
  mso-ansi-language:PT-BR'>Căn cứ điều chỉnh<o:p></o:p></span></b></p>
  </td>
 </tr>
  <% for(int i=0;i< dt_total.Rows.Count;i++ ) {%>
 <tr style='mso-yfti-irow:1'>
  <td width=51 valign=top style='width:37.9pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:
  6.0pt;margin-left:0in'><span lang=PT-BR style='mso-ansi-language:PT-BR'><%= i+1 %><o:p></o:p></span></p>
  </td>
  <td width=165 valign=top style='width:123.5pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:
  6.0pt;margin-left:0in'><span lang=PT-BR style='mso-ansi-language:PT-BR'><%= dt_total.Rows[i][0].ToString()%><o:p></o:p></span></p>
  </td>
  <td width=78 valign=top style='width:58.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:
  6.0pt;margin-left:0in'><span lang=PT-BR style='mso-ansi-language:PT-BR'><%= dt_total.Rows[i][1].ToString()%><o:p></o:p></span></p>
  </td>
  <td width=173 valign=top style='width:130.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:
  6.0pt;margin-left:0in'><span lang=PT-BR style='mso-ansi-language:PT-BR'><%= dt_total.Rows[i][2].ToString()%><o:p></o:p></span></p>
  </td>
  <td width=121 valign=top style='width:90.4pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:
  6.0pt;margin-left:0in'><span lang=PT-BR style='mso-ansi-language:PT-BR'><%= dt_total.Rows[i][3].ToString()%><o:p></o:p></span></p>
  </td>
  <td width=191 valign=top style='width:143.6pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:
  6.0pt;margin-left:0in'><span lang=PT-BR style='mso-ansi-language:PT-BR'><%= dt_total.Rows[i][4].ToString()%><o:p></o:p></span></p>
  </td>
  <td width=274 valign=top style='width:205.4pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:
  6.0pt;margin-left:0in'><span lang=PT-BR style='mso-ansi-language:PT-BR'><%= dt_total.Rows[i][5].ToString()%><o:p></o:p></span></p>
  </td>
 </tr>
  <% }%>
 
</table>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><i style='mso-bidi-font-style:
normal'><u><span lang=PT-BR style='mso-ansi-language:PT-BR'><o:p><span
 style='text-decoration:none'>&nbsp;</span></o:p></span></u></i></b></p>

</div>



</body>

</html>
