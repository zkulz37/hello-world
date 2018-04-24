﻿<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/msword";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:w="urn:schemas-microsoft-com:office:word"
xmlns:st1="urn:schemas-microsoft-com:office:smarttags"
xmlns="http://www.w3.org/TR/REC-html40">

<%
    string emp_pk;
    
    emp_pk       = Request["emp_pk"].ToString();
    string SQL = " select  " 
        + "a.FULL_NAME || '(' || a.emp_id || ')' as c0 "
        + ",decode(nvl(a.sex,0),'M','X',0) as Male1 "
        + ",decode(nvl(a.sex,0),'F','X',0) as FeMale2 "
        + ",(case when length(a.BIRTH_DT)=4 then a.birth_dt else to_char(to_date(a.birth_dt,'yyyymmdd'),'dd/mm/yyyy') end ) as birth_dt3 "
        + ",(select v.code_fnm from vhr_hr_code v where v.id='HR0015' and v.code=a.ETHNIC_TYPE) as ETHNIC4 "
        + ",(select v.code_fnm from vhr_hr_code v where v.id='HR0009' and v.code=a.NATION) as nation5 "
        + ",a.PERMANENT_ADDR as nguyenquan "
        + ",a.PRESENT_ADDR as noicutru "
        + ",a.PERSON_ID  as personid8 "
        + ",(select v.code_fnm from vhr_hr_code v where v.id='HR0014' and v.code=a.PLACE_PER_ID) as noicap9 "
        + ",to_char(to_date(a.ISSUE_DT,'yyyymmdd'),'dd/mm/yyyy') as issued_dt10 "
        + ",a.HEALTH_NO as c11 "
        + ",(select v.code_fnm from vhr_hr_code v where v.id='HR0012' and v.code=a.HEALTH_PLACE) as c12  "
        + ",to_char(to_date(nvl(a.BEGIN_CONTRACT,a.BEGIN_PROBATION),'yyyymmdd'),'mm/yyyy') as tuthang13  "
        + ",to_char(to_date(NVL(a.BEGIN_CONTRACT,a.BEGIN_PROBATION),'yyyymmdd'),'mm/yyyy') as denthang14 "
        + ",(select v.code_fnm from vhr_hr_code v where v.id='HR0008' and v.code=a.POS_TYPE) as pos_type15 "
        + ",'Công ty TNHH Amco - Mibaek Vina' as tencongty "
        + ",'Tầng 8 tòa nhà DG, số 15 Trần Phú, Ngô Quyền, Hải Phòng' as diachi "
        + ",(Select TO_CHAR(s.salary_level2,'999,999,999') from THR_SALARY_MANAGE s where s.del_if=0 and s.thr_emp_pk=a.pk and s.work_mon=substr(a.BEGIN_CONTRACT,1,6)) as salary18  "
        + ",a.contract_no as sohopdong19 "
        + ",to_char(to_date(NVL(a.BEGIN_CONTRACT,a.BEGIN_PROBATION),'yyyymmdd'),'dd/mm/yyyy') as kyngay20 "
        + ",(select lower(v.code_fnm) from vhr_hr_code v where v.id='HR0001' and v.code=a.contract_type)  as loaihopdong21 "
        + ",(select v.code_fnm from vhr_hr_code v where v.id='HR0049' and v.code='11') as noicongtac22 "
         + ",a.full_name as hoten23 "
        + "from thr_employee a "
        + "where a.del_if=0  "
       + "and a.pk in (" + emp_pk + ") " ;
        
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
    
   
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 11">
<meta name=Originator content="Microsoft Word 11">
<link rel=File-List href="rpt_01_TBH_Truoc_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_01_TBH_Truoc_files/editdata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<title>Bo hiÓm x• héi ViÖt Nam</title>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Tran Viet Hung</o:Author>
  <o:LastAuthor>huynhtruong</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>0</o:TotalTime>
  <o:LastPrinted>2008-10-14T08:11:00Z</o:LastPrinted>
  <o:Created>2008-10-23T09:47:00Z</o:Created>
  <o:LastSaved>2008-10-23T09:47:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>162</o:Words>
  <o:Characters>928</o:Characters>
  <o:Company> BHXH Viet Nam</o:Company>
  <o:Lines>7</o:Lines>
  <o:Paragraphs>2</o:Paragraphs>
  <o:CharactersWithSpaces>1088</o:CharactersWithSpaces>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DrawingGridHorizontalSpacing>5.45 pt</w:DrawingGridHorizontalSpacing>
  <w:DisplayHorizontalDrawingGridEvery>2</w:DisplayHorizontalDrawingGridEvery>
  <w:DisplayVerticalDrawingGridEvery>2</w:DisplayVerticalDrawingGridEvery>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:Compatibility>
   <w:SelectEntireFieldWithStartOrEnd/>
   <w:ApplyBreakingRules/>
   <w:UseWord2002TableStyleRules/>
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
	{font-family:"Wingdings 2";
	panose-1:5 2 1 2 1 5 7 7 7 7;
	mso-font-charset:2;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:0 268435456 0 0 -2147483648 0;}
@font-face
	{font-family:"\.VnTime";
	panose-1:2 11 114 0 0 0 0 0 0 0;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:3 0 0 0 1 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:14.0pt;
	mso-bidi-font-size:12.0pt;
	font-family:"\.VnTime";
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	mso-ansi-language:VI;
	mso-fareast-language:VI;}
p.MsoHeader, li.MsoHeader, div.MsoHeader
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	tab-stops:center 3.0in right 6.0in;
	font-size:14.0pt;
	mso-bidi-font-size:12.0pt;
	font-family:"\.VnTime";
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	mso-ansi-language:VI;
	mso-fareast-language:VI;}
p.MsoFooter, li.MsoFooter, div.MsoFooter
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	tab-stops:center 207.65pt right 415.3pt;
	font-size:14.0pt;
	mso-bidi-font-size:12.0pt;
	font-family:"\.VnTime";
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	mso-ansi-language:VI;
	mso-fareast-language:VI;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:28.35pt 28.35pt 27.0pt 27.25pt;
	mso-header-margin:35.45pt;
	mso-footer-margin:35.45pt;
	mso-page-numbers:17;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:1309163645;
	mso-list-type:hybrid;
	mso-list-template-ids:-1056926388 -1752559078 67698691 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:28.9pt;
	mso-level-number-position:left;
	margin-left:28.9pt;
	text-indent:-.25in;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
@list l0:level2
	{mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level4
	{mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level7
	{mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-tab-stop:4.5in;
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
<![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="4098" fillcolor="white">
  <v:fill color="white"/>
 </o:shapedefaults></xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
  <o:regrouptable v:ext="edit">
   <o:entry new="1" old="0"/>
  </o:regrouptable>
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=EN-US style='tab-interval:.5in'>
<% 
     
     for (int i = 0; i < irow; i++) 
    {
       
    %> 
<div class=Section1>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;tab-stops:27.25pt 250.7pt'><b><span
lang=PT-BR style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><span style='mso-tab-count:1'>     </span><u>BẢO HIỂM XÃ HỘI VIỆT NAM</u><span
style='mso-tab-count:1'>                 </span>CỘNG HOÀ XÃ HỘI CHỦ NGHĨA VIỆT
NAM<o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;tab-stops:250.7pt 288.85pt'><b><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'><span style='mso-tab-count:2'>                                                                          </span><u>Độc
lập - Tự do - Hạnh phúc<o:p></o:p></u></span></b></p>

<div>

<p class=MsoNormal align=center style='margin-left:334.5pt;text-align:center'><b><span
style='font-size:10.0pt;mso-ansi-language:EN-US'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal align=center style='margin-left:334.5pt;text-align:center'><b><span
lang=VI style='font-size:10.0pt'>M</span></b><b><span lang=VI style='font-size:
10.0pt;font-family:Arial'>ẫ</span></b><b><span lang=VI style='font-size:10.0pt'>u
s</span></b><b><span lang=VI style='font-size:10.0pt;font-family:Arial'>ố</span></b><b><span
lang=VI style='font-size:10.0pt'>: 01-TBH</span></b><b><span style='font-size:
10.0pt;mso-ansi-language:EN-US'><o:p></o:p></span></b></p>

<p class=MsoNormal align=center style='margin-left:334.5pt;text-align:center'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;mso-ansi-language:
EN-US;mso-bidi-font-weight:bold'>(Ban <span class=SpellE>h<span
style='font-family:Arial'>à</span><span style='mso-bidi-font-family:"\.VnTime"'>nh</span></span></span></i><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;mso-bidi-font-family:
"\.VnTime";mso-ansi-language:EN-US;mso-bidi-font-weight:bold'> kèmtheoQ</span></i><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-family:
Arial;mso-ansi-language:EN-US;mso-bidi-font-weight:bold'>Đ</span></i><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;mso-ansi-language:
EN-US;mso-bidi-font-weight:bold'>s</span></i><i style='mso-bidi-font-style:
normal'><span style='font-size:10.0pt;font-family:Arial;mso-ansi-language:EN-US;
mso-bidi-font-weight:bold'>ố</span></i><i style='mso-bidi-font-style:normal'><span
style='font-size:10.0pt;mso-bidi-font-family:"\.VnTime";mso-ansi-language:EN-US;
mso-bidi-font-weight:bold'>1333/Q</span></i><i style='mso-bidi-font-style:normal'><span
style='font-size:10.0pt;font-family:Arial;mso-ansi-language:EN-US;mso-bidi-font-weight:
bold'>Đ</span></i><i style='mso-bidi-font-style:normal'><span style='font-size:
10.0pt;mso-ansi-language:EN-US;mso-bidi-font-weight:bold'>-<o:p></o:p></span></i></p>

<p class=MsoNormal align=center style='margin-left:334.5pt;text-align:center'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;mso-ansi-language:
EN-US;mso-bidi-font-weight:bold'>BHXH <span class=SpellE>ng<span
style='font-family:Arial'>à</span><span style='mso-bidi-font-family:"\.VnTime"'>y</span></span></span></i><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;mso-bidi-font-family:
"\.VnTime";mso-ansi-language:EN-US;mso-bidi-font-weight:bold'> 21/01/2008 <span
class=SpellE>c<span style='font-family:Arial'>ủ</span>a</span> BHXH VN)</span></i><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;mso-ansi-language:
EN-US;mso-bidi-font-weight:bold'><o:p></o:p></span></i></p>

</div>


<p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><b><span
lang=VI style='font-size:16.0pt;font-family:"Times New Roman"'>TỜ KHAI</span></b><b><span
style='font-size:13.0pt;font-family:"Times New Roman";mso-ansi-language:EN-US'><o:p></o:p></span></b></p>

<p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><b><span
lang=VI style='font-size:13.0pt;font-family:"Times New Roman"'>THAM GIA BẢO
HIỂM XÃ HỘI, BẢO HIỂM Y TẾ BẮT BUỘC<o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt'><!--[if gte vml 1]><v:rect id="_x0000_s1078"
 style='position:absolute;left:0;text-align:left;margin-left:341.85pt;
 margin-top:7.9pt;width:17.2pt;height:17.25pt;z-index:-2'/><![endif]--><!--[if gte vml 1]><v:rect
 id="_x0000_s1077" style='position:absolute;left:0;text-align:left;
 margin-left:324.7pt;margin-top:7.9pt;width:17.15pt;height:17.25pt;z-index:-3'/><![endif]--><!--[if gte vml 1]><v:rect
 id="_x0000_s1076" style='position:absolute;left:0;text-align:left;
 margin-left:307.5pt;margin-top:7.9pt;width:17.2pt;height:17.25pt;z-index:-4'/><![endif]--><!--[if gte vml 1]><v:rect
 id="_x0000_s1075" style='position:absolute;left:0;text-align:left;
 margin-left:290.35pt;margin-top:7.9pt;width:17.15pt;height:17.25pt;z-index:-5'/><![endif]--><!--[if gte vml 1]><v:rect
 id="_x0000_s1074" style='position:absolute;left:0;text-align:left;
 margin-left:273.2pt;margin-top:7.9pt;width:17.15pt;height:17.25pt;z-index:-6'/><![endif]--><!--[if gte vml 1]><v:rect
 id="_x0000_s1073" style='position:absolute;left:0;text-align:left;
 margin-left:256pt;margin-top:7.9pt;width:17.2pt;height:17.25pt;z-index:-7'/><![endif]--><!--[if gte vml 1]><v:rect
 id="_x0000_s1072" style='position:absolute;left:0;text-align:left;
 margin-left:239.55pt;margin-top:7.9pt;width:17.2pt;height:17.25pt;z-index:-8'/><![endif]--><!--[if gte vml 1]><v:rect
 id="_x0000_s1071" style='position:absolute;left:0;text-align:left;
 margin-left:222.4pt;margin-top:7.9pt;width:17.15pt;height:17.25pt;z-index:-9'/><![endif]--><!--[if gte vml 1]><v:rect
 id="_x0000_s1070" style='position:absolute;left:0;text-align:left;
 margin-left:205.2pt;margin-top:7.9pt;width:17.2pt;height:17.25pt;z-index:-10'/><![endif]--><!--[if gte vml 1]><v:rect
 id="_x0000_s1069" style='position:absolute;left:0;text-align:left;
 margin-left:188pt;margin-top:7.9pt;width:17.2pt;height:17.25pt;z-index:-11'/><![endif]--><b><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'><span style='mso-tab-count:4'>                                   </span></span></b><b><span
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
EN-US'><u>Số sổ</u>:<o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt'><span style='mso-bidi-font-size:14.0pt;
font-family:"Times New Roman";mso-ansi-language:EN-US'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><u><span
style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:EN-US'>A.
NGƯỜI LAO ĐỘNG:<o:p></o:p></span></u></b></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify;tab-stops:386.95pt'><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'>1. Họ và tên: <%= dt_total.Rows[i][0].ToString() %><span style='mso-tab-count:
1'>                                                    </span>Nam<span
style='mso-spacerun:yes'>   </span></span><span lang=PT-BR style='mso-bidi-font-size:
14.0pt;font-family:"Wingdings 2";mso-ascii-font-family:"Times New Roman";
mso-hansi-font-family:"Times New Roman";mso-ansi-language:PT-BR;mso-char-type:
symbol;mso-symbol-font-family:"Wingdings 2"'><span style='mso-char-type:symbol;
mso-symbol-font-family:"Wingdings 2"'><% if (dt_total.Rows[i][1].ToString()=="X") 
                                                Response.Write("T");
                                         else
                                                Response.Write("£");
                                         %></span></span><span lang=PT-BR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><span style='mso-spacerun:yes'>   </span>Nữ<span
style='mso-spacerun:yes'>  </span></span><span lang=PT-BR style='mso-bidi-font-size:
14.0pt;font-family:"Wingdings 2";mso-ascii-font-family:"Times New Roman";
mso-hansi-font-family:"Times New Roman";mso-ansi-language:PT-BR;mso-char-type:
symbol;mso-symbol-font-family:"Wingdings 2"'><span style='mso-char-type:symbol;
mso-symbol-font-family:"Wingdings 2"'><% if (dt_total.Rows[i][2].ToString()=="X") 
                                                Response.Write("T");
                                         else
                                                Response.Write("£");
                                         %></span></span><span lang=PT-BR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify;tab-stops:250.7pt 386.95pt'><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'>2. Ngày tháng năm sinh: <%=dt_total.Rows[i][3].ToString() %><span
style='mso-tab-count:1'>        </span>Dân tộc: <%=dt_total.Rows[i][4].ToString() %><span style='mso-tab-count:
1'>               </span>Quốc tịch: <%=dt_total.Rows[i][5].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'>3. Nguyên Quán: <%=dt_total.Rows[i][6].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=SV
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
SV'>4. Nơi cư trú (Thường trú hay tạm trú): <%=dt_total.Rows[i][7].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify;tab-stops:250.7pt 386.95pt'><span
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
EN-US'>5. Giấy CMND số: <%=dt_total.Rows[i][8].ToString() %><span style='mso-tab-count:1'>                 </span>Nơi
cấp: <%=dt_total.Rows[i][9].ToString() %><span style='mso-tab-count:1'>    </span>Ngày cấp: <%=dt_total.Rows[i][10].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=FR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
FR'>6. Hợp đồng lao động (hoặc hợp đồng làm việc): Số <%=dt_total.Rows[i][19].ToString() %> có hiệu lực từ ngày <%=dt_total.Rows[i][20].ToString().Substring(0,2).ToString() %> tháng <%=dt_total.Rows[i][20].ToString().Substring(3,2).ToString() %> năm <%=dt_total.Rows[i][20].ToString().Substring(6,4).ToString() %>. Loại hợp đồng <%=dt_total.Rows[i][21].ToString()%><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=FR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
FR'>7. Chức vụ, chức danh nghề: <%=dt_total.Rows[i][15].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=FR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
FR'>8. Cơ quan, đơn vị: <%=dt_total.Rows[i][16].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=FR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
FR'>9. Địa chỉ: <%=dt_total.Rows[i][17].ToString() %><o:p></o:p></span></p>


<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=SV
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
SV'>10. Nơi đăng ký khám chữa bệnh ban đầu: <%=dt_total.Rows[i][12].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=SV
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
SV'>11. Đối tượng hưởng BHYT mức </span><span lang=SV style='mso-bidi-font-size:
14.0pt;font-family:Wingdings;mso-ascii-font-family:"Times New Roman";
mso-hansi-font-family:"Times New Roman";mso-ansi-language:SV;mso-char-type:
symbol;mso-symbol-font-family:Wingdings'><span style='mso-char-type:symbol;
mso-symbol-font-family:Wingdings'>o</span></span><span lang=SV
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
SV'><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><![if !supportLists]><b><span
lang=IT style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:IT'></span></span></b><![endif]><span lang=IT style='mso-bidi-font-size:
14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'>12. Quá trình đóng, chưa
hưởng BHXH một lần và BH thất nghiệp<o:p></o:p></span></p>


<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 width="99%"
 style='width:99.98%;border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-yfti-tbllook:480;mso-padding-alt:0in 5.75pt 0in 5.75pt;mso-border-insideh:
 .5pt solid windowtext;mso-border-insidev:.5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes'>
  <td width="21%" colspan=2 style='width:21.82%;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=IT style='font-size:10.0pt;font-family:"Times New Roman";mso-ansi-language:
  IT'>Thời gian</span><b><span lang=IT style='mso-bidi-font-size:14.0pt;
  font-family:"Times New Roman";mso-ansi-language:IT'><o:p></o:p></span></b></p>
  </td>
  <td width="27%" rowspan=2 style='width:27.68%;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:10.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR'>Cấp bậc, chức vụ, chức danh nghề, công việc, nơi làm việc (tên cơ
  quan, đơn vị, địa chỉ)</span><b><span lang=IT style='mso-bidi-font-size:14.0pt;
  font-family:"Times New Roman";mso-ansi-language:IT'><o:p></o:p></span></b></p>
  </td>
  <td width="10%" rowspan=2 style='width:10.92%;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:10.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR'>Tiền lương, tiền công</span><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p></o:p></span></b></p>
  </td>
  <td width="31%" colspan=4 style='width:31.0%;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:10.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR'>Phụ cấp</span><b><span lang=IT style='mso-bidi-font-size:14.0pt;
  font-family:"Times New Roman";mso-ansi-language:IT'><o:p></o:p></span></b></p>
  </td>
  <td width="8%" rowspan=2 style='width:8.58%;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:10.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR'>Ghi chú</span><b><span lang=IT style='mso-bidi-font-size:14.0pt;
  font-family:"Times New Roman";mso-ansi-language:IT'><o:p></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1'>
  <td width="10%" style='width:10.92%;border:solid windowtext 1.0pt;border-top:
  none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
  margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><span
  lang=IT style='font-size:10.0pt;font-family:"Times New Roman";mso-ansi-language:
  IT'>Từ<o:p></o:p></span></p>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=IT style='font-size:10.0pt;font-family:"Times New Roman";mso-ansi-language:
  IT'>tháng/năm</span><b><span lang=IT style='mso-bidi-font-size:14.0pt;
  font-family:"Times New Roman";mso-ansi-language:IT'><o:p></o:p></span></b></p>
  </td>
  <td width="10%" style='width:10.9%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
  margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><span
  lang=IT style='font-size:10.0pt;font-family:"Times New Roman";mso-ansi-language:
  IT'>Đến<o:p></o:p></span></p>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=IT style='font-size:10.0pt;font-family:"Times New Roman";mso-ansi-language:
  IT'>tháng/năm</span><b><span lang=IT style='mso-bidi-font-size:14.0pt;
  font-family:"Times New Roman";mso-ansi-language:IT'><o:p></o:p></span></b></p>
  </td>
  <td width="7%" style='width:7.34%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:10.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR'>Chức vụ</span><b><span lang=IT style='mso-bidi-font-size:14.0pt;
  font-family:"Times New Roman";mso-ansi-language:IT'><o:p></o:p></span></b></p>
  </td>
  <td width="8%" style='width:8.24%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:10.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR'>Thâm niên VK</span><b><span lang=IT style='mso-bidi-font-size:14.0pt;
  font-family:"Times New Roman";mso-ansi-language:IT'><o:p></o:p></span></b></p>
  </td>
  <td width="7%" style='width:7.94%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:10.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR'>Thâm niên nghề</span><b><span lang=IT style='mso-bidi-font-size:14.0pt;
  font-family:"Times New Roman";mso-ansi-language:IT'><o:p></o:p></span></b></p>
  </td>
  <td width="7%" style='width:7.48%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:10.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR'>Khác</span><b><span lang=IT style='mso-bidi-font-size:14.0pt;
  font-family:"Times New Roman";mso-ansi-language:IT'><o:p></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2'>
  <td width="10%" valign=top style='width:10.92%;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><span lang=IT style='font-size:
  10.0pt;font-family:"Times New Roman";mso-ansi-language:IT;mso-bidi-font-weight:
  bold'><%=dt_total.Rows[i][13].ToString() %><o:p></o:p></span></p>
  </td>
  <td width="10%" valign=top style='width:10.9%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><span lang=IT style='font-size:
  10.0pt;font-family:"Times New Roman";mso-ansi-language:IT;mso-bidi-font-weight:
  bold'><%=dt_total.Rows[i][14].ToString() %></span><b><span lang=IT style='mso-bidi-font-size:14.0pt;
  font-family:"Times New Roman";mso-ansi-language:IT'><o:p></o:p></span></b></p>
  </td>
  <td width="27%" valign=top style='width:27.68%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><span lang=IT style='font-size:
  10.0pt;font-family:"Times New Roman";mso-ansi-language:IT;mso-bidi-font-weight:
  bold'><%=dt_total.Rows[i][15].ToString() %> <o:p></o:p></span></p>
  </td>
  <td width="10%" valign=top style='width:10.92%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><span lang=IT style='font-size:
  10.0pt;font-family:"Times New Roman";mso-ansi-language:IT;mso-bidi-font-weight:
  bold'><%=dt_total.Rows[i][18].ToString() %><o:p></o:p></span></p>
  </td>
  <td width="7%" valign=top style='width:7.34%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="8%" valign=top style='width:8.24%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="7%" valign=top style='width:7.94%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="7%" valign=top style='width:7.48%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="8%" valign=top style='width:8.58%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3'>
  <td width="10%" valign=top style='width:10.92%;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="10%" valign=top style='width:10.9%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="27%" valign=top style='width:27.68%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><span lang=IT style='font-size:
  10.0pt;font-family:"Times New Roman";mso-ansi-language:IT;mso-bidi-font-weight:
  bold'><%=dt_total.Rows[i][16].ToString() %><o:p></o:p></span></p>
  </td>
  <td width="10%" valign=top style='width:10.92%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="7%" valign=top style='width:7.34%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="8%" valign=top style='width:8.24%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="7%" valign=top style='width:7.94%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="7%" valign=top style='width:7.48%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="8%" valign=top style='width:8.58%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:4'>
  <td width="10%" valign=top style='width:10.92%;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="10%" valign=top style='width:10.9%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="27%" valign=top style='width:27.68%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><span lang=IT style='font-size:
  10.0pt;font-family:"Times New Roman";mso-ansi-language:IT;mso-bidi-font-weight:
  bold'><%=dt_total.Rows[i][17].ToString() %><o:p></o:p></span></p>
  </td>
  <td width="10%" valign=top style='width:10.92%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="7%" valign=top style='width:7.34%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="8%" valign=top style='width:8.24%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="7%" valign=top style='width:7.94%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="7%" valign=top style='width:7.48%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="8%" valign=top style='width:8.58%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:5'>
  <td width="10%" valign=top style='width:10.92%;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="10%" valign=top style='width:10.9%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="27%" valign=top style='width:27.68%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="10%" valign=top style='width:10.92%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="7%" valign=top style='width:7.34%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="8%" valign=top style='width:8.24%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="7%" valign=top style='width:7.94%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="7%" valign=top style='width:7.48%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="8%" valign=top style='width:8.58%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:6'>
  <td width="10%" valign=top style='width:10.92%;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="10%" valign=top style='width:10.9%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="27%" valign=top style='width:27.68%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="10%" valign=top style='width:10.92%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="7%" valign=top style='width:7.34%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="8%" valign=top style='width:8.24%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="7%" valign=top style='width:7.94%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="7%" valign=top style='width:7.48%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="8%" valign=top style='width:8.58%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:7'>
  <td width="10%" valign=top style='width:10.92%;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="10%" valign=top style='width:10.9%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="27%" valign=top style='width:27.68%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="10%" valign=top style='width:10.92%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="7%" valign=top style='width:7.34%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="8%" valign=top style='width:8.24%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="7%" valign=top style='width:7.94%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="7%" valign=top style='width:7.48%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
  <td width="8%" valign=top style='width:8.58%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p>&nbsp;</o:p></span></b></p>
  </td>
 </tr>
 
 
 
 
</table>
<p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><i><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'>Cam kết</span></i><span lang=PT-BR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'>: Những nội dung kê khai trên là hoàn toàn đúng sự thực, nếu sai tôi xin
hoàn toàn chịu trách nhiệm trước pháp luật.<o:p></o:p></span></p>

<p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><i><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'><%=dt_total.Rows[i][22].ToString() %>, ngày 01 <span style='mso-spacerun:yes'> 
</span>tháng <%if (dt_total.Rows[i][20].ToString()!="") 
                                        Response.Write(dt_total.Rows[i][20].ToString().Substring(3,2));
                                    %>  năm <%if (dt_total.Rows[i][20].ToString()!="") 
                                        Response.Write(dt_total.Rows[i][20].ToString().Substring(6,4));
                                    %><o:p></o:p></span></i></p>

<p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><b><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'>Người khai<o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><b><span
lang=PT-BR style='font-size:15.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><%=dt_total.Rows[i][23].ToString() %><o:p></o:p></span></b></p>


<%  if (i==irow-1) 
    {%>
<%  } 
    else
    {    %>
<b><span lang=PT-BR style='font-size:12.0pt;font-family:"Times New Roman";
mso-fareast-font-family:"Times New Roman";mso-ansi-language:PT-BR;mso-fareast-language:
VI;mso-bidi-language:AR-SA'><br clear=all style='page-break-before:always'>
</span></b>
<%  } %>

</div>
<%} //end for %>
</body>

</html>
