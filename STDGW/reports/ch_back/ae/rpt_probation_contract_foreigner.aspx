<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/msword";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:w="urn:schemas-microsoft-com:office:word"
xmlns:st1="urn:schemas-microsoft-com:office:smarttags"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string emp_pk;
    emp_pk       = Request["emp_pk"].ToString();
    string SQL
    = "select E.FULL_NAME c00  " +
        "        ,(select code_fnm from vhr_hr_code v where V.ID='HR0009' and E.NATION=V.CODE) c01 " +
        "        , decode(length( E.BIRTH_DT) ,8,substr(E.BIRTH_DT,-2),'') c02 " +
        "        , decode(length( E.BIRTH_DT) ,8,substr(E.BIRTH_DT,5,2),'') c03 " +
        "        , decode(length( E.BIRTH_DT) ,8,substr(E.BIRTH_DT,1,4),'') c04 " +
        "        , E.PERMANENT_ADDR c05 " +
        "        , E.PERSON_ID c06 " +
        "        , to_char(to_date( E.ISSUE_DT,'yyyymmdd'),'dd/mm/yyyy') c07 " +
        "        ,(select code_fnm from vhr_hr_code v where V.ID='HR0014' and E.PLACE_PER_ID =V.CODE) c08 " +
        "        , E.SOCIAL_NO c09 " +
        "        , to_char(to_date(E.SOCIAL_DT,'yyyymm'),'mm/yyyy') c10 " +
        "        ,(select code_fnm from vhr_hr_code v where V.ID='HR0013' and E.SOCIAL_PLACE =V.CODE) c11 " +
        "        ,(select V.CHAR_2 from vhr_hr_code v where V.ID='HR0001' and E.CONTRACT_TYPE =V.CODE) c12 " +
        "        , substr(A.BEGIN_PROBATION,-2) c13 " +
        "        , substr(A.BEGIN_PROBATION,5,2) c14 " +
        "        , substr(A.BEGIN_PROBATION,1,4) c15 " +
        "        , substr(A.END_PROBATION,-2) c16 " +
        "        , substr(A.END_PROBATION,5,2) c17 " +
        "        , substr(A.END_PROBATION,1,4) c18 " +
        "        ,(select code_fnm from vhr_hr_code v where V.ID='HR0008' and E.POS_TYPE =V.CODE) c19 " +
        "        ,(select code_fnm from vhr_hr_code v where V.ID='HR0010' and E.JOB_TYPE =V.CODE) c20 " +
        "        , to_char(nvl(e.PRO_SAL,0),'999,999,999') c21 " +
        "        , to_char(nvl(e.ALLOW_AMT1_l1,0)+nvl( e.ALLOW_AMT2_l1,0)+nvl( e.ALLOW_AMT3_l1,0) " +
        "        +nvl( e.ALLOW_AMT4_l1,0)+nvl( e.ALLOW_AMT5_l1,0)+nvl( e.ALLOW_AMT6_l1,0) " +
        "        +nvl( e.ALLOW_AMT7_l1,0)+nvl( e.ALLOW_AMT8_l1,0),'999,999,999') c22 " +
        "        , substr( to_char(to_date( A.BEGIN_PROBATION,'yyyymmdd')-1,'yyyymmdd') ,-2) c23 " +
        "        , substr(to_char(to_date( A.BEGIN_PROBATION,'yyyymmdd')-1,'yyyymmdd'),5,2) c24 " +
        "        , substr(to_char(to_date( A.BEGIN_PROBATION,'yyyymmdd')-1,'yyyymmdd'),1,4) c25 " +
        "        , case when nvl(E.MONEY_KIND,'01')='01' then 'ĐỒNG' " +
        "                else 'USD' " +
        "         end   c26    " +
        "        ,to_char(decode( nvl(MEAL_YN,'N'),'Y',0,0),'999,999,999') c27    "+ 
        "        , to_char(nvl(e.PRO_SAL,0)+nvl(e.ALLOW_AMT1_l1,0)+nvl( e.ALLOW_AMT2_l1,0)+nvl( e.ALLOW_AMT3_l1,0) " +
        "        +nvl( e.ALLOW_AMT4_l1,0)+nvl( e.ALLOW_AMT5_l1,0)+nvl( e.ALLOW_AMT6_l1,0) " +
        "        +nvl( e.ALLOW_AMT7_l1,0)+nvl( e.ALLOW_AMT8_l1,0)+decode( nvl(MEAL_YN,'N'),'Y',0,0) ,'999,999,999') c28  " +
        "        , a.contract_no c29   " +
        "        , e.present_addr c30   " +
        "from thr_labour_contract a, thr_employee e " +
        "where A.DEL_IF=0 " +
        "and E.DEL_IF=0 " +
        "and A.THR_EMPLOYEE_PK=e.pk " +
        "and A.CONTRACT_TYPE=E.CONTRACT_TYPE " +
        "and e.pk in (" + emp_pk + ") ";
        
        
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
<link rel=File-List href="labour_contract_files/filelist.xml">
<title>CỘNG HOÀ XÃ HỘI CHỦ NGHĨA VIỆT NAM</title>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="PlaceType"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="PlaceName"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="country-region"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="place"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="City"/>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>convert</o:Author>
  <o:LastAuthor>convert</o:LastAuthor>
  <o:Revision>1</o:Revision>
  <o:TotalTime>2</o:TotalTime>
  <o:Created>2012-01-04T04:00:00Z</o:Created>
  <o:LastSaved>2012-01-04T04:02:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>1156</o:Words>
  <o:Characters>6591</o:Characters>
  <o:Lines>54</o:Lines>
  <o:Paragraphs>15</o:Paragraphs>
  <o:CharactersWithSpaces>7732</o:CharactersWithSpaces>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
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
	{font-family:"\.VnTime";
	panose-1:2 11 114 0 0 0 0 0 0 0;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:3 0 0 0 1 0;}
@font-face
	{font-family:VNI-Times;
	panose-1:0 0 0 0 0 0 0 0 0 0;
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
	font-size:12.0pt;
	font-family:"\.VnTime";
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";}
h1
	{mso-style-next:Normal;
	margin:0in;
	margin-bottom:.0001pt;
	text-align:center;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:1;
	font-size:18.0pt;
	font-family:VNI-Times;
	mso-font-kerning:0pt;}
h2
	{mso-style-next:Normal;
	margin:0in;
	margin-bottom:.0001pt;
	text-align:center;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:2;
	font-size:12.0pt;
	font-family:VNI-Times;}
h3
	{mso-style-next:Normal;
	margin:0in;
	margin-bottom:.0001pt;
	text-align:center;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:3;
	font-size:12.0pt;
	font-family:"Times New Roman";
	font-weight:normal;
	font-style:italic;}
h4
	{mso-style-next:Normal;
	margin:0in;
	margin-bottom:.0001pt;
	text-align:center;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:4;
	font-size:12.0pt;
	font-family:"Times New Roman";
	font-style:italic;}
p.MsoHeading7, li.MsoHeading7, div.MsoHeading7
	{mso-style-next:Normal;
	margin:0in;
	margin-bottom:.0001pt;
	text-align:justify;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:7;
	font-size:12.0pt;
	font-family:"\.VnTime";
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	font-weight:bold;}
p.MsoTitle, li.MsoTitle, div.MsoTitle
	{margin:0in;
	margin-bottom:.0001pt;
	text-align:center;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"\.VnTime";
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	font-weight:bold;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:595.45pt 841.7pt;
	margin:.5in .6in .5in .8in;
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
<![endif]-->
</head>

<body lang=EN-US style='tab-interval:.5in'>
<% 
     
     for (int i = 0; i < irow; i++) 
    {
       
    %> 
<div class=Section1>

<p class=MsoTitle><span style='font-family:"Times New Roman"'>CỘNG HOÀ XÃ HỘI
CHỦ NGHĨA VIỆT <st1:country-region w:st="on"><st1:place w:st="on">NAM</st1:place></st1:country-region><o:p></o:p></span></p>

<p class=MsoNormal align=center style='text-align:center'><span class=SpellE><b
style='mso-bidi-font-weight:normal'><span style='font-family:"Times New Roman"'>Độc</span></b></span><b
style='mso-bidi-font-weight:normal'><span style='font-family:"Times New Roman"'>
<span class=SpellE>lập</span> - <span class=SpellE>Tự</span> do - <span
class=SpellE>Hạnh</span> <span class=SpellE>phúc</span><o:p></o:p></span></b></p>

<p class=MsoNormal align=center style='text-align:center'><span
style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<h3><st1:PlaceName w:st="on">SOCIALIST</st1:PlaceName> <st1:PlaceType w:st="on">REPUBLIC</st1:PlaceType>
OF <st1:country-region w:st="on"><st1:place w:st="on">VIETNAM</st1:place></st1:country-region></h3>

<h3><st1:City w:st="on"><st1:place w:st="on">Independence</st1:place></st1:City>
– Freedom - Happiness</h3>

<p class=MsoNormal align=center style='text-align:center'><span
style='font-family:"Times New Roman"'>-----------------------------------<o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoHeading7><span class=SpellE><span style='font-family:"Times New Roman"'>Công ty POSCO E & C., LTD </span></span><span
style='font-family:"Times New Roman"'> <span class=SpellE></span> 
<o:p></o:p></span></p>

<p class=MsoNormal><span class=SpellE><span style='font-family:"Times New Roman"'>Thầu XD gói thầu A3 đường cao tốc Nội Bài-Lào Cai</span></span><span
style='font-family:"Times New Roman"'> <span class=SpellE></span> <span
class=SpellE><span class=GramE></span></span><span
class=SpellE></span> <span class=SpellE></span> <span class=SpellE></span>.<o:p></o:p></span></p>

<p class=MsoHeading7><span class=SpellE><span style='font-family:"Times New Roman";
font-weight:normal'>Số</span></span><span style='font-family:"Times New Roman";
font-weight:normal'>/<i style='mso-bidi-font-style:normal'>No.</i>:<%=dt_total.Rows[i]["c29"].ToString() %> <o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-family:"Times New Roman"'>.<o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<h1><span style='font-size:16.0pt;mso-bidi-font-size:18.0pt;font-family:"Times New Roman"'>HỢP
ĐỒNG LAO ĐỘNG<o:p></o:p></span></h1>

<h3><span style='font-size:14.0pt;mso-bidi-font-size:12.0pt'>LABOUR CONTRACT<o:p></o:p></span></h3>

<p class=MsoNormal align=center style='text-align:center'><b style='mso-bidi-font-weight:
normal'><span style='font-family:"Times New Roman"'>(Ban <span class=SpellE>hành</span>
<span class=SpellE>kèm</span> <span class=SpellE><span class=GramE>theo</span></span>
<span class=SpellE>Thông</span> <span class=SpellE>tư</span> <span
class=SpellE>số</span> 21/2003/TT/BLĐTBXH<o:p></o:p></span></b></p>

<p class=MsoNormal align=center style='text-align:center'><span class=SpellE><b
style='mso-bidi-font-weight:normal'><span style='font-family:"Times New Roman"'>Ngày</span></b></span><b
style='mso-bidi-font-weight:normal'><span style='font-family:"Times New Roman"'>
22/9/2003 <span class=SpellE>của</span> <span class=SpellE>Bộ</span> Lao <span
class=SpellE>động</span> <span class=SpellE>Thương</span> <span class=SpellE>Binh</span>
<span class=SpellE>và</span> <span class=SpellE>Xã</span> <span class=SpellE>hội</span>)<o:p></o:p></span></b></p>

<p class=MsoNormal align=center style='text-align:center'><i style='mso-bidi-font-style:
normal'><span style='font-size:11.0pt;mso-bidi-font-size:12.0pt;font-family:
"Times New Roman"'>Issued under the circular of the Ministry of <span
class=SpellE>Labour</span>, Invalids and Social Affairs<o:p></o:p></span></i></p>

<p class=MsoNormal align=center style='text-align:center'><i style='mso-bidi-font-style:
normal'><span style='font-size:11.0pt;mso-bidi-font-size:12.0pt;font-family:
"Times New Roman"'>No 21/2003/TT/BLDDTBXH on 22 September 2003<o:p></o:p></span></i></p>

<p class=MsoNormal style='text-align:justify'><b style='mso-bidi-font-weight:
normal'><span style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='text-align:justify'><b style='mso-bidi-font-weight:
normal'><span style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-top:6.0pt;line-height:150%;tab-stops:4.0in'><span
class=SpellE><span style='font-family:"Times New Roman"'>Chúng</span></span><span
style='font-family:"Times New Roman"'> <span class=SpellE>tôi</span>, <span
class=SpellE>một</span> <span class=SpellE>bên</span> <span class=SpellE>là</span>
<span class=SpellE>Ông</span>: <b style='mso-bidi-font-weight:normal'><span
style='color:blue'>KWEON OH SHIN <span class=SpellE></span> </span><span
style='mso-tab-count:1'>                                 </span></b><span
class=SpellE>Quốc</span> <span class=SpellE>tịch</span><b style='mso-bidi-font-weight:
normal'>: <span style='color:blue;mso-bidi-font-weight:bold'>Hàn Quốc</span><span
style='mso-bidi-font-weight:bold'><o:p></o:p></span></b></span></p>

<p class=MsoNormal style='margin-top:6.0pt;line-height:150%;tab-stops:4.0in'><i
style='mso-bidi-font-style:normal'><span style='font-family:"Times New Roman"'>We
are from one side, <span class=SpellE>Mr/Mrs</span></span></i><span
style='font-family:"Times New Roman"'> <span style='mso-tab-count:1'>                                               </span><i
style='mso-bidi-font-style:normal'>Nationality </i></span><b style='mso-bidi-font-weight:
normal'><span style='font-size:13.0pt;line-height:150%;font-family:"Times New Roman"'><o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
class=SpellE><span style='font-family:"Times New Roman"'>Chức</span></span><span
style='font-family:"Times New Roman"'> vụ<i style='mso-bidi-font-style:normal'>/Position:</i>
<span class=SpellE><b style='mso-bidi-font-weight:normal'><span
style='color:blue'>Giám đốc dự án/Project Manager</span></b></span><b style='mso-bidi-font-weight:normal'><span
style='color:blue'> <span class=SpellE></span> <span class=SpellE></span>
<span class=SpellE></span> <i style='mso-bidi-font-style:normal'>
</i></span><i style='mso-bidi-font-style:normal'> </i></b><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;line-height:150%'><span
class=SpellE><span style='font-family:"Times New Roman"'>Đại</span></span><span
style='font-family:"Times New Roman"'> <span class=SpellE>diện</span> <span
class=SpellE>cho</span> (1<span style='color:blue'>): <b style='mso-bidi-font-weight:
normal'>Công ty POSCO E & C., LTD Thầu XD gói thầu A3 đường cao tốc Nội Bài-Lào Cai
<span class=SpellE></span> <span class=SpellE></span>
<span class=SpellE><span class=GramE></span></span> </b></span><b
style='mso-bidi-font-weight:normal'><span style='mso-spacerun:yes'>         
</span></b><span class=SpellE><br>Điện</span> <span class=SpellE>thoại</span>/<i
style='mso-bidi-font-style:normal'>Tel:</i> <b><span style='color:blue'> 0210.3992.451 </span></b><span class=SpellE>  Fax</span> <span class=SpellE></span>/<i
style='mso-bidi-font-style:normal'>Tel:</i> <b><span style='color:blue'> 0210.3992.455	</span></b><b
style='mso-bidi-font-weight:normal'><o:p></o:p></b></span></p>

<!--
<p class=MsoNormal style='margin-top:6.0pt;line-height:150%'><b
style='mso-bidi-font-weight:normal'><span style='font-family:"Times New Roman";
color:blue'>Splendora GĐ1 <span class=SpellE>tại</span> <span class=SpellE>Hà</span>
<span class=SpellE>Nội</span><span style='mso-spacerun:yes'>  </span><span
style='mso-tab-count:2'>              </span><o:p></o:p></span></b></p> -->

<p class=MsoNormal style='margin-top:6.0pt;line-height:150%'><i
style='mso-bidi-font-style:normal'><span style='font-family:"Times New Roman"'>Representative
of: <o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
class=SpellE><span style='font-family:"Times New Roman";mso-bidi-font-style:
italic'>Địa</span></span><span style='font-family:"Times New Roman";mso-bidi-font-style:
italic'> <span class=SpellE>chỉ</span></span><i style='mso-bidi-font-style:
normal'><span style='font-family:"Times New Roman"'>/Address:</span></i><span
style='font-family:"Times New Roman"'> <span class=SpellE><b style='mso-bidi-font-weight:
normal'>Số 507 phố Châu Phong, phường Gia Cẩm, thành phố Việt Trì , Phú Thọ</b></span><b style='mso-bidi-font-weight:normal'> <span
class=SpellE></span> <span class=SpellE></span> <span class=SpellE></span>
<span class=GramE></span> <span class=SpellE></span> <span
class=SpellE></span> <span class=SpellE></span> <span class=SpellE></span>
<span class=SpellE></span> <span class=SpellE></span><o:p></o:p></b></span></p>

<!--
<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
class=SpellE><span style='font-family:"Times New Roman"'>Sinh</span></span><span
style='font-family:"Times New Roman"'> <span class=SpellE>ngày</span>/<i
style='mso-bidi-font-style:normal'>Date of birth</i>: 30 <span class=SpellE>tháng</span>/<i
style='mso-bidi-font-style:normal'>month </i>11<b style='mso-bidi-font-weight:
normal'> </b><span class=SpellE>Năm</span>/<i style='mso-bidi-font-style:normal'>year</i>
1964<o:p></o:p></span></p> -->

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
class=SpellE><span style='font-family:"Times New Roman"'>Và</span></span><span
style='font-family:"Times New Roman"'> <span class=SpellE>một</span> <span
class=SpellE>bên</span> <span class=SpellE>là</span> <span class=SpellE>Ông/Bà</span><span
style='color:blue'>: <span class=SpellE><b style='mso-bidi-font-weight:normal'><%=dt_total.Rows[i]["c00"].ToString() %></b></span><b
style='mso-bidi-font-weight:normal'> <span class=SpellE></span> <span
class=SpellE></span> <span style='mso-spacerun:yes'>     </span><span
style='mso-spacerun:yes'>        </span></b></span><span style='mso-tab-count:
1'>   </span><span style='mso-spacerun:yes'>            </span><span
class=SpellE>Quốc</span> <span class=SpellE>tịch</span>: <span class=SpellE><b><%=dt_total.Rows[i]["c01"].ToString() %></b></span><b>
<st1:country-region w:st="on"><st1:place w:st="on"></st1:place></st1:country-region><o:p></o:p></b></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
class=GramE><i style='mso-bidi-font-style:normal'><span style='font-family:
"Times New Roman"'>And<span style='mso-spacerun:yes'>  </span>from</span></i></span><i
style='mso-bidi-font-style:normal'><span style='font-family:"Times New Roman"'>
other side <span class=SpellE>Mr/Mrs</span><span style='mso-tab-count:5'>                                                  </span>Nationality<o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
class=SpellE><span style='font-family:"Times New Roman"'>Sinh</span></span><span
style='font-family:"Times New Roman"'> <span class=SpellE>ngày</span>/<i
style='mso-bidi-font-style:normal'>Date of birth</i><span style='color:blue'>:<span
style='mso-spacerun:yes'>  </span><%=dt_total.Rows[i]["c02"].ToString() %><span style='mso-tab-count:1'>     </span><span
class=SpellE>tháng</span>/<i style='mso-bidi-font-style:normal'>month <%=dt_total.Rows[i]["c03"].ToString() %><span
style='mso-spacerun:yes'>   </span></i><span class=SpellE>Năm</span>/<i
style='mso-bidi-font-style:normal'>year</i> <%=dt_total.Rows[i]["c04"].ToString() %><o:p></o:p></span></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
class=SpellE><span style='font-family:"Times New Roman"'>Nghê</span></span><span
style='font-family:"Times New Roman"'>̀ <span class=SpellE>nghiệp</span>/<i
style='mso-bidi-font-style:normal'>Profession</i> (2):<span
style='mso-spacerun:yes'>  </span><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
class=SpellE><span style='font-family:"Times New Roman"'>Địa</span></span><span
style='font-family:"Times New Roman"'> chỉ <span class=SpellE>thường</span> <span
class=SpellE>trú<i style='mso-bidi-font-style:normal'>/Residence</i></span><i
style='mso-bidi-font-style:normal'> address<b style='mso-bidi-font-weight:normal'><span
style='color:blue'>:</span></b></i><b style='mso-bidi-font-weight:normal'><span
style='color:blue'> <span class=SpellE><%=dt_total.Rows[i]["c05"].ToString() %></span>  <span class=SpellE></span>
 <span class=SpellE></span>  <span class=SpellE></span> <span
class=SpellE></span> <span class=SpellE></span> <span class=SpellE></span>
<span class=SpellE></span> <span class=SpellE></span> <span
class=SpellE></span><o:p></o:p></span></b></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
class=SpellE><span style='font-family:"Times New Roman"'>Địa chỉ tại Việt Nam/Address in Vietnam:</span></span><span
style='font-family:"Times New Roman"'>  <span class=SpellE></span> <span
class=SpellE><i style='mso-bidi-font-style:normal'></i></span><i
style='mso-bidi-font-style:normal'> <b style='mso-bidi-font-weight:normal'><span
style='color:blue'></span></b></i><b style='mso-bidi-font-weight:normal'><span
style='color:blue'> <span class=SpellE><%=dt_total.Rows[i]["c30"].ToString() %></span>  <span class=SpellE></span>
 <span class=SpellE></span>  <span class=SpellE></span> <span
class=SpellE></span> <span class=SpellE></span> <span class=SpellE></span>
<span class=SpellE></span> <span class=SpellE></span> <span
class=SpellE></span><o:p></o:p></span></b></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
class=SpellE><span style='font-family:"Times New Roman"'>Số Passport</span></span><span
style='font-family:"Times New Roman"'>́ <span class=GramE><span
style='color:blue'> :</span></span><span style='color:blue'> <%=dt_total.Rows[i]["c06"].ToString() %><span
style='mso-tab-count:2'>                        </span><span class=SpellE>Cấp</span>
<span class=SpellE>ngày</span>: <%=dt_total.Rows[i]["c07"].ToString() %><span style='mso-tab-count:1'>    </span><span
style='mso-spacerun:yes'>                        </span><span class=SpellE>Tại</span>:
<span class=SpellE></span> <span class=SpellE><%=dt_total.Rows[i]["c08"].ToString() %></span><o:p></o:p></span></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><i><span
style='font-family:"Times New Roman";mso-bidi-font-weight:bold'>Passport No.:</span></i><i
style='mso-bidi-font-style:normal'><span style='font-family:"Times New Roman"'>
</span></i><span style='font-family:"Times New Roman"'><b><span
style='mso-tab-count:4'>                                                </span></b><i
style='mso-bidi-font-style:normal'>Issued on<span style='mso-tab-count:4'>                                             </span>At:</i><b><span
style='mso-bidi-font-style:italic'><o:p></o:p></span></b></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
class=SpellE><span style='font-family:"Times New Roman"'>Sô</span></span><span
style='font-family:"Times New Roman"'> <span class=SpellE>sô</span>̉ Lao <span
class=SpellE>động</span> (<span class=SpellE>nếu</span> <span class=SpellE>có</span>́):
<span style='mso-tab-count:2'>                     </span><span class=SpellE>Cấp</span>
<span class=SpellE>ngày</span>: <span style='mso-spacerun:yes'> </span><span
style='mso-spacerun:yes'>   </span><span style='mso-tab-count:2'>                </span><span
style='mso-spacerun:yes'>                        </span><span class=SpellE>Tại</span>:<o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;line-height:150%'><span
class=SpellE><i style='mso-bidi-font-style:normal'><span style='font-family:
"Times New Roman"'>Labour</span></i></span><i style='mso-bidi-font-style:normal'><span
style='font-family:"Times New Roman"'> Book No (if any)</span></i><span
style='font-family:"Times New Roman"'><span style='mso-tab-count:2'>                     </span><i
style='mso-bidi-font-style:normal'>Issued on</i><span style='mso-tab-count:
2'>                     </span><span style='mso-spacerun:yes'>             
</span><span style='mso-spacerun:yes'>          </span><i style='mso-bidi-font-style:
normal'>At</i><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
class=SpellE><span style='font-family:"Times New Roman"'>Sô</span></span><span
style='font-family:"Times New Roman"'>́ <span class=SpellE>sô</span>̉ BHXH: <b><span
style='mso-tab-count:1'>  </span><%=dt_total.Rows[i]["c09"].ToString() %><span style='mso-tab-count:2'>                </span></b><span
class=SpellE>Cấp</span> <span class=SpellE>ngày</span>: <%=dt_total.Rows[i]["c10"].ToString() %> <span
style='mso-tab-count:2'>             </span><span
style='mso-spacerun:yes'> </span><span class=SpellE>Tạ<span class=GramE>i</span></span><span
class=GramE>&nbsp;:</span> <%=dt_total.Rows[i]["c11"].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'>Social
Insurance Book No (if any)<span style='mso-spacerun:yes'>     </span>Issued on<span
style='mso-tab-count:3'>                                   </span><span
style='mso-spacerun:yes'>    </span><span style='mso-tab-count:1'>        </span>At<span
style='font-family:"Times New Roman"'><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
class=SpellE><span style='font-family:"Times New Roman"'>Thoả</span></span><span
style='font-family:"Times New Roman"'> <span class=SpellE>thuận</span> <span
class=SpellE>ký</span> <span class=SpellE>kết</span> <span class=SpellE>hợp</span>
<span class=SpellE>đồng</span> Lao <span class=SpellE>động</span> <span
class=SpellE>và</span> cam <span class=SpellE>kết</span> <span class=SpellE>làm</span>
<span class=SpellE>đúng</span> <span class=SpellE>những</span> <span
class=SpellE>điều</span> <span class=SpellE>khoản</span> <span class=SpellE>sau</span>
<span class=SpellE>đây</span>/<i style='mso-bidi-font-style:normal'>Agree to
sign this <span class=SpellE>labour</span> contract and engage to satisfy the
following provisions</i>:<o:p></o:p></span></p>

<h2 style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
class=SpellE><span style='font-family:"Times New Roman"'>Điều</span></span><span
style='font-family:"Times New Roman"'> 1: <span class=SpellE>Thời</span> <span
class=SpellE>hạn</span> <span class=SpellE>và</span> <span class=SpellE>công</span>
<span class=SpellE>việc</span> <span class=SpellE>hợp</span> <span
class=SpellE>đồng</span>/</span><i style='mso-bidi-font-style:normal'><span
style='font-family:"Times New Roman";font-weight:normal;mso-bidi-font-weight:
bold'>T</span></i><span class=SpellE><i style='mso-bidi-font-style:normal'><span
lang=EN-GB style='font-family:"Times New Roman";mso-ansi-language:EN-GB;
font-weight:normal;mso-bidi-font-weight:bold'>erms</span></i></span><i
style='mso-bidi-font-style:normal'><span lang=EN-GB style='font-family:"Times New Roman";
mso-ansi-language:EN-GB;font-weight:normal;mso-bidi-font-weight:bold'> and job
requirements</span></i><i style='mso-bidi-font-style:normal'><span lang=EN-GB
style='font-family:"\.VnTime";mso-ansi-language:EN-GB'><o:p></o:p></span></i></h2>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:-8.1pt;margin-bottom:
0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;line-height:150%'>-
<span class=SpellE><span style='font-family:"Times New Roman"'>Loại</span></span><span
style='font-family:"Times New Roman"'> <span class=SpellE>hợp</span> <span
class=SpellE>đồng</span> <span class=SpellE><span class=GramE>lao</span></span>
<span class=SpellE>động</span>/<i style='mso-bidi-font-style:normal'>Term of
the <span class=SpellE>Labour</span> Contract</i> (3): <span class=SpellE></span>
<span class=SpellE><%=dt_total.Rows[i]["c12"].ToString() %></span> <span class=SpellE></span> <span
class=SpellE></span> <span class=SpellE></span><i></i><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman";color:blue'>- <span class=SpellE>Thử việc từ</span>
<span class=SpellE>ngày</span>/<i style='mso-bidi-font-style:normal'>from <span
class=GramE>date<span style='font-style:normal'><span
style='mso-spacerun:yes'>  </span><%=dt_total.Rows[i]["c13"].ToString() %></span></span></i> <span class=SpellE>tháng</span>/<i
style='mso-bidi-font-style:normal'>month <%=dt_total.Rows[i]["c14"].ToString() %><span style='mso-spacerun:yes'> 
</span></i><b style='mso-bidi-font-weight:normal'><span
style='mso-spacerun:yes'> </span></b><span class=SpellE>năm</span>/<i
style='mso-bidi-font-style:normal'>year <%=dt_total.Rows[i]["c15"].ToString() %></i><b style='mso-bidi-font-weight:
normal'> <span style='mso-tab-count:1'>        </span></b><span class=SpellE><span
style='mso-bidi-font-weight:bold'>Đ</span><b style='mso-bidi-font-weight:normal'>ế</b>n</span>
<span class=SpellE>ngày</span>/<i style='mso-bidi-font-style:normal'>until <%=dt_total.Rows[i]["c16"].ToString() %> </i><span
class=SpellE><span style='mso-bidi-font-weight:bold'>tháng</span></span>/<i
style='mso-bidi-font-style:normal'>month <%=dt_total.Rows[i]["c17"].ToString() %></i> <span class=SpellE>năm</span>/<i
style='mso-bidi-font-style:normal'>year <%=dt_total.Rows[i]["c18"].ToString() %><o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Địa</span> <span
class=SpellE>điểm</span> <span class=SpellE>làm</span> <span class=SpellE>việc</span>/<i
style='mso-bidi-font-style:normal'>working <span class=GramE>site<span
style='font-style:normal'>(</span></span></i>4): <span class=SpellE><b
style='mso-bidi-font-weight:normal'>Phú Thọ</b></span><b style='mso-bidi-font-weight:
normal'> <span class=SpellE></span><o:p></o:p></b></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:-16.55pt;margin-bottom:
0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;line-height:150%'><b
style='mso-bidi-font-weight:normal'><span style='font-family:"Times New Roman"'>-
</span></b><span class=SpellE><span style='font-family:"Times New Roman"'>Chức</span></span><span
style='font-family:"Times New Roman"'> <span class=SpellE>danh</span> <span
class=SpellE>chuyên</span> <span class=SpellE>môn</span>/<i style='mso-bidi-font-style:
normal'>job title</i><span style='color:blue'>: <span class=SpellE><b
style='mso-bidi-font-weight:normal'><%=dt_total.Rows[i]["c19"].ToString() %></b></span><b style='mso-bidi-font-weight:
normal'> <span class=SpellE></span> <span class=SpellE></span> <span
class=SpellE></span></b><o:p></o:p></span></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:-16.55pt;margin-bottom:
0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Công</span> <span
class=SpellE>việc</span> <span class=SpellE>phải</span> <span class=SpellE>làm</span>/<i
style='mso-bidi-font-style:normal'>job descriptions</i>:<%=dt_total.Rows[i]["c20"].ToString() %> <o:p></o:p></span></p>

<h2 align=left style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:left;text-indent:-.5in;
line-height:150%'><span class=SpellE><span style='font-family:"Times New Roman"'>Điều</span></span><span
style='font-family:"Times New Roman"'> 2: <span class=SpellE>Chế</span> <span
class=SpellE>độ</span> <span class=SpellE>làm</span> <span class=SpellE>việc</span>/</span><i
style='mso-bidi-font-style:normal'><span lang=EN-GB style='font-family:"Times New Roman";
mso-ansi-language:EN-GB;font-weight:normal;mso-bidi-font-weight:bold'>Working
conditions</span></i><i style='mso-bidi-font-style:normal'><span lang=EN-GB
style='font-family:"Times New Roman";mso-ansi-language:EN-GB'><o:p></o:p></span></i></h2>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Thời</span> <span
class=SpellE>gian</span> <span class=SpellE>làm</span> <span class=SpellE>việc</span>/<i
style='mso-bidi-font-style:normal'>working time</i> (6): Full month working but 2 days off.
<o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Được</span> <span
class=SpellE>cấp</span> <span class=SpellE>phát</span> <span class=SpellE>những</span>
<span class=SpellE>dụng</span> <span class=SpellE>cụ</span> <span class=SpellE>làm</span>
<span class=SpellE>việc</span> <span class=SpellE>gồm</span>/<i
style='mso-bidi-font-style:normal'>Equipment to be provided:</i> <span
class=SpellE>Tuỳ</span> <span class=SpellE><span class=GramE>theo</span></span>
<span class=SpellE>yêu</span> <span class=SpellE>cầu</span> <span class=SpellE>của</span>
<span class=SpellE>công</span> <span class=SpellE>việc</span>/ <i>according to
requirement of works</i><o:p></o:p></span></p>

<h4 style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
class=SpellE><span style='mso-bidi-font-weight:normal;font-style:normal'>Điều</span></span><span
style='mso-bidi-font-weight:normal;font-style:normal'> 3: <span class=SpellE>Nghĩa</span>
<span class=SpellE>vụ</span> <span class=SpellE>và</span> <span class=SpellE>quyền</span>
<span class=SpellE>lợi</span> <span class=SpellE>của</span> <span class=SpellE>người</span>
<span class=SpellE><span class=GramE>lao</span></span> <span class=SpellE>động</span>/
</span><span style='font-weight:normal;font-style:normal'>Obligations, rights
and benefits of the employee<o:p></o:p></span></h4>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><b
style='mso-bidi-font-weight:normal'><span style='font-family:"Times New Roman"'>1.
<span class=SpellE>Quyền</span> <span class=SpellE>lợi</span> </span></b><i
style='mso-bidi-font-style:normal'><span style='font-family:"Times New Roman"'>Benefits<b
style='mso-bidi-font-weight:normal'><o:p></o:p></b></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Công ty sẽ cung cấp miễn phí việc vận chuyển, nơi ở, bữa ăn cho người lao động. Chi phí điện thoại dưới 03 triệu VNĐ sẽ do công ty thanh toán. Trong trường hợp chi phí này vượt quá 03 triệu VNĐ, cần phải được Giám đốc Dự án chấp thuận trước khi thanh toán</span> <span
class=SpellE></span> <span class=SpellE></span> <span class=SpellE></span>
<span class=SpellE></span> <span class=SpellE></span>/<i
style='mso-bidi-font-style:normal'>Company will provide free transportation, accommodation, meals to employee. Telephone fee bill less than 3 million VND per month will be paid by Company. In case, monthly bill is over 3 million VND, it must be approved by Project Director before payment</i>
<o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Kỳ tính lượng được tính từ ngày 16 của tháng hiện tại làm việc đến ngày 15 của tháng liền kề. Người lao động sẽ nhận một phần lương của mình tại Việt Nam và số còn lại sẽ được chuyển về tài khoản của Công ty POSCO Engineering & Construction Co., Ltd tại Hàn Quốc. Người đại diện hợp pháp của người lao động là Công ty POSCO Engineering & Construction Co., Ltd tại Hàn Quốc sẽ chuyển số tiền lương của người lao động đến cho gia đình của họ tại Hàn Quốc. Khoản tiền lương nhận tại Việt Nam có thể được thay đổi hàng tháng theo yêu cầu của người lao động</span> <span
class=SpellE></span> <span class=SpellE></span> <span class=SpellE></span>
<span class=SpellE></span> <span class=SpellE></span>/<i
style='mso-bidi-font-style:normal'>Salary period from the 16th day of this month to the 15th day of the following month, the employee will receive a part of his monthly salary in advance in Vietnam and the balance will be sent back to bank account of POSCO Engineering & Construction Co., Ltd, in Korea. Accordingly, on behalf of employee, POSCO Engineering & Construction Co., Ltd, in Korea shall transfer the amount to his family in Korea. The amount of advance salary can be monthly changed on employee’s demand.</i>
<o:p></o:p></span></p>



<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Mức</span> <span
class=SpellE>lương</span> <span class=SpellE>chính</span>/basic salary:<span
style='mso-spacerun:yes'>                  </span><span class=GramE><b
style='mso-bidi-font-weight:normal'><i style='mso-bidi-font-style:normal'><span
style='color:blue'><%=dt_total.Rows[i]["c21"].ToString() %> <%=dt_total.Rows[i]["c26"].ToString() %><span style='mso-spacerun:yes'>  </span>/</span></i></b></span><b
style='mso-bidi-font-weight:normal'><i style='mso-bidi-font-style:normal'><span
style='color:blue'>tháng(month)</span></i></b><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Phụ</span> <span
class=SpellE>cấp</span>/Allowance:<span style='mso-tab-count:3'>                            </span><span
style='mso-spacerun:yes'>  </span><b style='mso-bidi-font-weight:normal'><i
style='mso-bidi-font-style:normal'><span style='color:blue'><span
style='mso-spacerun:yes'>      </span><span class=GramE><%=dt_total.Rows[i]["c22"].ToString() %> <%=dt_total.Rows[i]["c26"].ToString() %><span
style='mso-spacerun:yes'>  </span>/</span>tháng(month)</span></i></b><o:p></o:p></span></p>



<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Tổng cộng:</span> <span
class=SpellE></span><span style='mso-tab-count:3'>                            </span><span
style='mso-spacerun:yes'>  </span><b style='mso-bidi-font-weight:normal'><i
style='mso-bidi-font-style:normal'><span style='color:blue'><span
style='mso-spacerun:yes'>      </span><span class=GramE><%=dt_total.Rows[i]["c28"].ToString() %> <%=dt_total.Rows[i]["c26"].ToString() %><span
style='mso-spacerun:yes'>  </span>/</span>tháng(month)</span></i></b><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Hình</span> <span
class=SpellE>thức</span> <span class=SpellE>trả</span> <span class=SpellE>lương</span>/<i
style='mso-bidi-font-style:normal'>method of payment</i>: Qua Ngân hàng qui đổi theo tỉ giá liên ngân hàng tại thời điểm cuối tháng <span
class=SpellE></span> <span class=SpellE></span>  <span class=SpellE></span>
<span class=SpellE></span> <span class=SpellE></span> <span class=SpellE></span>
<span class=SpellE></span> <span class=SpellE></span> <span
class=SpellE></span> <span class=SpellE></span> <span class=SpellE></span>
<span class=SpellE></span> <span class=SpellE></span>/ <i
style='mso-bidi-font-style:normal'>Thru Bank exchange rate applied the Interbank exchange rate at end day of month  <span
class=SpellE></span><span class=GramE></span><o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Phụ cấp làm đêm/ night duty allowance (9): Có áp dụng/ available</span> <span
class=SpellE></span> <span class=SpellE></span> <span class=SpellE></span>
<i style='mso-bidi-font-style:normal'></i> <i style='mso-bidi-font-style:
normal'> </i> <span class=SpellE></span> <span class=SpellE></span>
<span class=SpellE></span><i style='mso-bidi-font-style:
normal'><o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Được</span> <span
class=SpellE>trả</span> <span class=SpellE>lương</span> <span class=SpellE>và</span>
<span class=SpellE>phụ</span> <span class=SpellE>cấp</span> <span class=SpellE>vào</span>
<span class=SpellE>ngày</span>/<i style='mso-bidi-font-style:normal'>salary and
allowance to be paid on: </i><span style='mso-spacerun:yes'> </span>trước ngày 05 hàng tháng/ before 05th everymonth <span
class=SpellE></span> <span class=SpellE></span> <i style='mso-bidi-font-style:
normal'><o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Chế</span> <span
class=SpellE>độ</span> <span class=SpellE>nâng</span> <span class=SpellE>lương</span>/<i
style='mso-bidi-font-style:normal'>salary increment</i>: <span class=SpellE>Tuỳ</span>
<span class=SpellE><span class=GramE>theo</span></span> <span class=SpellE>kết</span>
<span class=SpellE>quả</span> <span class=SpellE>kinh</span> <span
class=SpellE>doanh</span> <span class=SpellE>của</span> <span class=SpellE>Công</span>
<span class=SpellE>ty</span> <span class=SpellE>và</span> <span class=SpellE>năng</span>
<span class=SpellE>lực</span> <span class=SpellE>làm</span> <span class=SpellE>việc</span>
<span class=SpellE>của</span> <span class=SpellE>cá</span> <span class=SpellE>nhân</span>/
<i style='mso-bidi-font-style:normal'>According to the performance of the
Company as well as the performance of the employee</i><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Được</span> <span
class=SpellE>trang</span> <span class=SpellE>bị</span> <span class=SpellE>bảo</span>
<span class=SpellE>hộ</span> <span class=SpellE><span class=GramE>lao</span></span>
<span class=SpellE>động</span> <span class=SpellE>gồm/<i style='mso-bidi-font-style:
normal'>labour</i></span><i style='mso-bidi-font-style:normal'> safety tools
and equipment to be provided</i>: Depending on requirement of their works.<o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Chế</span> <span
class=SpellE>độ</span> <span class=SpellE>nghỉ</span> <span class=SpellE>ngơi</span>
(<span class=SpellE>nghỉ</span> <span class=SpellE>hàng</span> <span
class=SpellE>tuần</span>, <span class=SpellE>phép</span> <span class=SpellE>năm</span>,
<span class=SpellE>lễ</span> <span class=SpellE>tết</span>….)/<i
style='mso-bidi-font-style:normal'>full paid holidays</i> <i style='mso-bidi-font-style:
normal'>(weekly day off, annual leave, public holidays,...): </i><span
style='mso-spacerun:yes'> </span>12 <span class=SpellE>ngày</span> <span
class=SpellE>nghỉ</span> <span class=SpellE>phép</span> <span class=SpellE>một</span>
năm,10 <span class=SpellE>ngày</span> <span class=SpellE>nghỉ</span> <span
class=SpellE>lễ</span> <span class=SpellE>hưởng</span> <span class=SpellE>nguyên</span>
<span class=SpellE>lương</span>/<i style='mso-bidi-font-style:normal'> annual
leave days per year, 10 days<span style='mso-spacerun:yes'>  </span>paid public
holidays.<o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Bảo</span> <span
class=SpellE>hiểm</span> <span class=SpellE>xã</span> <span class=SpellE>hội</span>,
y <span class=SpellE>tế</span> <span class=SpellE>và</span> <span class=SpellE>thất</span>
<span class=SpellE>nghiệp</span>/<i style='mso-bidi-font-style:normal'>social,
health and unemployment insurances</i> (10): Không áp dụng trong thời gian thử việc <span class=SpellE></span>
<span class=SpellE>của</span> <span class=SpellE>Nhà</span> <span class=SpellE></span>/
<i>Not available during probation period<o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><i><span
style='font-family:"Times New Roman"'>- </span></i><span class=SpellE><span
style='font-family:"Times New Roman";mso-bidi-font-style:italic'>Bảo</span></span><span
style='font-family:"Times New Roman";mso-bidi-font-style:italic'> <span
class=SpellE>hiểm</span> <span class=GramE>tai</span> <span class=SpellE>nạn</span>/
<span class=SpellE><i>Acident</i></span><i> insurance</i>: Theo <span
class=SpellE>quy</span> <span class=SpellE>định</span> <span class=SpellE>của</span>
<span class=SpellE>Công</span> <span class=SpellE>ty</span>/ <i>As per
Company’s policy<o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Chế</span> <span
class=SpellE>độ</span> <span class=SpellE>đào</span> <span class=SpellE>tạo</span>/<i
style='mso-bidi-font-style:normal'>training</i> (11): Theo qui <span
class=SpellE>định</span> <span class=SpellE>của</span> <span class=SpellE>Công</span>
<span class=SpellE>ty</span>. <span class=SpellE>Trong</span> <span
class=SpellE>thời</span> <span class=SpellE>gian</span> <span class=SpellE>được</span>
<span class=SpellE>cử</span> <span class=SpellE>đi</span> <span class=SpellE>học</span>,
<span class=SpellE>cá</span> <span class=SpellE>nhân</span> <span class=SpellE>phải</span>
<span class=SpellE>hoàn</span> <span class=SpellE>thành</span> <span
class=SpellE>khoá</span> <span class=SpellE>học</span> <span class=SpellE>đúng</span>
<span class=SpellE>thời</span> <span class=SpellE>hạn</span>, <span
class=SpellE>được</span> <span class=SpellE>hưởng</span> <span class=SpellE>nguyên</span>
<span class=SpellE>lương</span> <span class=SpellE>và</span> <span
class=SpellE>các</span> <span class=SpellE>quyền</span> <span class=SpellE>lợi</span>
<span class=SpellE>khác</span>/<i style='mso-bidi-font-style:normal'> <span
class=GramE>As</span> per company’s policy. When the employee is sent by the
employer to a training course, he/she has to complete the course successfully
and on time. The employee is entitled full salary when attending the training
course.</i><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><a
name="OLE_LINK1"><b style='mso-bidi-font-weight:normal'><span style='font-family:
"Times New Roman"'>2. </span></b></a><span class=SpellE><span class=GramE><span
style='mso-bookmark:OLE_LINK1'><b style='mso-bidi-font-weight:normal'><span
style='font-family:"Times New Roman"'>Những</span></b></span></span></span><span
style='mso-bookmark:OLE_LINK1'><span class=GramE><b style='mso-bidi-font-weight:
normal'><span style='font-family:"Times New Roman"'> <span
style='mso-spacerun:yes'> </span><span class=SpellE>thoả</span></span></b></span></span><span
style='mso-bookmark:OLE_LINK1'><b style='mso-bidi-font-weight:normal'><span
style='font-family:"Times New Roman"'> <span class=SpellE>thuận</span> <span
class=SpellE>khác</span></span></b></span><span style='mso-bookmark:OLE_LINK1'><span
style='font-family:"Times New Roman"'>/<i style='mso-bidi-font-style:normal'>other
agreements</i> (12):<span style='mso-spacerun:yes'>  </span><span class=SpellE>Không</span>
<span class=SpellE>đóng</span> <span class=SpellE>Bảo</span> <span
class=SpellE>hiểm</span> <span class=SpellE>các</span> <span class=SpellE>loại</span>
<span class=SpellE>bảo</span> <span class=SpellE>hiểm</span> <span
class=SpellE>nêu</span> <span class=SpellE>trên</span> <span class=SpellE>trong</span>
<span class=SpellE>thời</span> <span class=SpellE>gian</span> <span
class=SpellE>thử</span> <span class=SpellE>việc</span>/. <i style='mso-bidi-font-style:
normal'>Insurances</i> <i style='mso-bidi-font-style:normal'>mentioned above <span
style='mso-bidi-font-style:italic'>are not contributed during probation.<span
style='mso-spacerun:yes'>  </span></span></i></span></span><i><span
style='font-family:"Times New Roman"'><o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><b
style='mso-bidi-font-weight:normal'><span style='font-family:"Times New Roman"'>3.
<span class=SpellE>Nghĩa</span> <span class=SpellE>vụ</span>/</span></b><i
style='mso-bidi-font-style:normal'><span style='font-family:"Times New Roman"'>Obligations</span></i><span
style='font-family:"Times New Roman"'>:<b style='mso-bidi-font-weight:normal'><o:p></o:p></b></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Hoàn</span> <span
class=SpellE>thành</span> <span class=SpellE>những</span> <span class=SpellE>công</span>
<span class=SpellE>việc</span> <span class=SpellE>được</span> <span
class=SpellE>giao</span> / <span class=GramE><i style='mso-bidi-font-style:
normal'>To</i></span><i style='mso-bidi-font-style:normal'> fulfill works as
indicated in this <span class=SpellE>Labour</span> Contract.<span
style='mso-spacerun:yes'>  </span><o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Chấp</span> <span
class=SpellE>hành</span> <span class=SpellE>điều</span> <span class=SpellE>lệnh</span>
<span class=SpellE>sản</span> <span class=SpellE>xuất</span> – <span
class=SpellE>kinh</span> <span class=SpellE>doanh</span>, <span class=SpellE>nội</span>
<span class=SpellE>quy</span> <span class=SpellE>kỷ</span> <span class=SpellE>luật</span>
<span class=SpellE><span class=GramE>lao</span></span> <span class=SpellE>động</span>,
an <span class=SpellE>toàn</span> <span class=SpellE>lao</span> <span
class=SpellE>động</span> <span class=SpellE>và</span> <span class=SpellE>những</span>
<span class=SpellE>quy</span> <span class=SpellE>định</span> <span
class=SpellE>nội</span> <span class=SpellE>bộ</span> <span class=SpellE>trong</span>
<span class=SpellE>Công</span> <span class=SpellE>ty</span>/<i
style='mso-bidi-font-style:normal'>To comply with job assignments, <span
class=SpellE>labour</span> discipline, rules of <span class=SpellE>labour</span>
safety and other internal regulations of the company.<o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Bồi</span> <span
class=SpellE>thường</span> <span class=GramE>vi</span> <span class=SpellE>phạm</span>
<span class=SpellE>và</span> <span class=SpellE>vật</span> <span class=SpellE>chất</span>/<i
style='mso-bidi-font-style:normal'>Compensation</i> (13): Theo <span
class=SpellE>nội</span> <span class=SpellE>quy</span> <span class=SpellE>của</span>
<span class=SpellE>Công</span> <span class=SpellE>ty</span> <span class=SpellE>và</span>
<span class=SpellE>Luật</span> Lao <span class=SpellE>động</span> <span
class=SpellE>Việt</span> <st1:place w:st="on"><st1:country-region w:st="on">Nam</st1:country-region></st1:place>/
<i style='mso-bidi-font-style:normal'>According to the Company’s regulations
and the <span class=SpellE>Labour</span> Law.</i><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
class=SpellE><b style='mso-bidi-font-weight:normal'><span style='font-family:
"Times New Roman"'>Điều</span></b></span><b style='mso-bidi-font-weight:normal'><span
style='font-family:"Times New Roman"'> 4: <span class=SpellE>Nghĩa</span> <span
class=SpellE>vụ</span> <span class=SpellE>và</span> <span class=SpellE>quyền</span>
<span class=SpellE>hạn</span> <span class=SpellE>của</span> <span class=SpellE>người</span>
<span class=SpellE>sử</span> <span class=SpellE>dụng</span> <span class=SpellE><span
class=GramE>lao</span></span> <span class=SpellE>động</span> / </span></b><span
class=SpellE><i style='mso-bidi-font-style:normal'><span style='font-family:
"Times New Roman"'>Oligations</span></i></span><i style='mso-bidi-font-style:
normal'><span style='font-family:"Times New Roman"'> and rights of the Employer<o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><b
style='mso-bidi-font-weight:normal'><span style='font-family:"Times New Roman"'>1.
<span class=SpellE>Nghĩa</span> <span class=SpellE>vụ</span>/</span></b><i
style='mso-bidi-font-style:normal'><span style='font-family:"Times New Roman"'>Obligations:<b
style='mso-bidi-font-weight:normal'><o:p></o:p></b></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Bảo</span> <span
class=SpellE>đảm</span> <span class=SpellE>việc</span> <span class=SpellE>làm</span>
<span class=SpellE>và</span> <span class=SpellE>thực</span> <span class=SpellE>hiện</span>
<span class=SpellE>đầy</span> <span class=SpellE>đủ</span> <span class=SpellE>những</span>
cam <span class=SpellE>kết</span> <span class=SpellE>trong</span> <span
class=SpellE>hợp</span> <span class=SpellE>đồng</span> <span class=SpellE><span
class=GramE>lao</span></span> <span class=SpellE>động</span>/<i
style='mso-bidi-font-style:normal'>To arrange works for the employee in
conformity with the signed contract and to fully ensure terms and conditions
committed in the <span class=SpellE>Labour</span> contract.<o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Thanh</span> <span
class=SpellE>toán</span> <span class=SpellE>đầy</span> <span class=SpellE>đủ</span>
<span class=SpellE>đúng</span> <span class=SpellE>thời</span> <span
class=SpellE>hạn</span>, <span class=SpellE>các</span> <span class=SpellE>chế</span>
<span class=SpellE>độ</span> <span class=SpellE>và</span> <span class=SpellE>quyền</span>
<span class=SpellE>lợi</span> <span class=SpellE>cho</span> <span class=SpellE>người</span>
<span class=SpellE><span class=GramE>lao</span></span> <span class=SpellE>động</span>
<span class=SpellE>theo</span> <span class=SpellE>hợp</span> <span
class=SpellE>đồng</span> <span class=SpellE>lao</span> <span class=SpellE>động</span>,
<span class=SpellE>thoả</span> <span class=SpellE>ước</span> <span
class=SpellE>lao</span> <span class=SpellE>động</span> <span class=SpellE>tập</span>
<span class=SpellE>thể</span> </span>(<span class=SpellE>nếu</span> <span
class=SpellE>có</span>)/<i style='mso-bidi-font-style:normal'><span
style='font-family:"Times New Roman"'>To fully pay the employee all
remuneration and other benefits on time as committed in the <span class=SpellE>Labour</span>
contract and Collective <span class=SpellE>Labour</span> Agreement (if any).</span></i><span
style='font-family:"Times New Roman"'><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><b
style='mso-bidi-font-weight:normal'><span style='font-family:"Times New Roman"'>2.
<span class=SpellE>Quyền</span> <span class=SpellE>hạn</span>/</span></b><i
style='mso-bidi-font-style:normal'><span style='font-family:"Times New Roman"'>Rights</span></i><span
style='font-family:"Times New Roman"'>:<b style='mso-bidi-font-weight:normal'><o:p></o:p></b></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Điều</span> <span
class=SpellE>hành</span> <span class=SpellE>người</span> <span class=SpellE><span
class=GramE>lao</span></span> <span class=SpellE>động</span> <span
class=SpellE>hoàn</span> <span class=SpellE>thành</span> <span class=SpellE>công</span>
<span class=SpellE>việc</span> <span class=SpellE>theo</span> <span
class=SpellE>hợp</span> <span class=SpellE>đồng</span> (<span class=SpellE>bố</span>
<span class=SpellE>trí</span>, <span class=SpellE>điều</span> <span
class=SpellE>chuyển</span>, <span class=SpellE>tạm</span> <span class=SpellE>ngừng</span>
<span class=SpellE>việc</span>….) <i style='mso-bidi-font-style:normal'>To
manage the employee to fulfill their assignments according to the <span
class=SpellE>Labour</span> contract (assign, transfer, suspend job....).<o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Tạm</span> <span
class=SpellE>hoãn</span>, <span class=SpellE>chấm</span> <span class=SpellE>dứt</span>
<span class=SpellE>hợp</span> <span class=SpellE>đồng</span> <span
class=SpellE><span class=GramE>lao</span></span> <span class=SpellE>động</span></span>,
<span class=SpellE><span style='font-family:"Times New Roman"'>kỷ</span></span><span
style='font-family:"Times New Roman"'> <span class=SpellE>luật</span> <span
class=SpellE>người</span> <span class=SpellE>lao</span> <span class=SpellE>động</span>
<span class=SpellE>theo</span> qui <span class=SpellE>định</span> <span
class=SpellE>của</span> <span class=SpellE>pháp</span> <span class=SpellE>luật</span>,
<span class=SpellE>thoả</span> <span class=SpellE>ước</span> <span
class=SpellE>lao</span> <span class=SpellE>động</span> <span class=SpellE>tập</span>
<span class=SpellE>thể</span> (<span class=SpellE>nếu</span> <span
class=SpellE>có</span>) <span class=SpellE>và</span> <span class=SpellE>nội</span>
<span class=SpellE>quy</span> <span class=SpellE>lao</span> <span class=SpellE>động</span>
<span class=SpellE>của</span> <span class=SpellE>doanh</span> <span
class=SpellE>nghiệp</span>/<i style='mso-bidi-font-style:normal'>To suspend,
terminate the <span class=SpellE>Labour</span> contract, penalty the employee
in accordance with the Laws, Company regulations and Collective <span
class=SpellE>Labour</span> Agreement (if any).<o:p></o:p></i></span></p>

<h2 style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
class=SpellE><span style='font-family:"Times New Roman"'>Điều</span></span><span
style='font-family:"Times New Roman"'> 5: <span class=SpellE>Điều</span> <span
class=SpellE>khoản</span> <span class=SpellE>thi</span> <span class=SpellE>hành</span>/</span><i
style='mso-bidi-font-style:normal'><span lang=EN-GB style='font-family:"Times New Roman";
mso-ansi-language:EN-GB;font-weight:normal;mso-bidi-font-weight:bold'>General
provisions</span></i><i style='mso-bidi-font-style:normal'><span lang=EN-GB
style='font-family:"Times New Roman";mso-ansi-language:EN-GB'><o:p></o:p></span></i></h2>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Những</span> <span
class=SpellE>vấn</span> <span class=SpellE>đề</span> <span class=SpellE>về</span>
<span class=SpellE><span class=GramE>lao</span></span> <span class=SpellE>động</span>
<span class=SpellE>không</span> <span class=SpellE>ghi</span> <span
class=SpellE>trong</span> <span class=SpellE>hợp</span> <span class=SpellE>đồng</span>
<span class=SpellE>này</span> <span class=SpellE>thì</span> <span class=SpellE>áp</span>
<span class=SpellE>dụng</span> qui <span class=SpellE>định</span> <span
class=SpellE>của</span> <span class=SpellE>thoả</span> <span class=SpellE>ước</span>
<span class=SpellE>lao</span> <span class=SpellE>động</span> <span
class=SpellE>tập</span> <span class=SpellE>thể</span>, <span class=SpellE>trường</span>
<span class=SpellE>hợp</span> <span class=SpellE>chưa</span> <span
class=SpellE>có</span> <span class=SpellE>thoả</span> <span class=SpellE>ước</span>
<span class=SpellE>lao</span> <span class=SpellE>động</span> <span
class=SpellE>tập</span> <span class=SpellE>thể</span> <span class=SpellE>thì</span>
<span class=SpellE>áp</span> <span class=SpellE>dụng</span> <span class=SpellE>quy</span>
<span class=SpellE>định</span> <span class=SpellE>của</span> <span
class=SpellE>pháp</span> <span class=SpellE>luật</span> <span class=SpellE>lao</span>
<span class=SpellE>động</span>.<o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><i
style='mso-bidi-font-style:normal'><span style='font-family:"Times New Roman"'>Other
<span class=SpellE>labour</span> issues which are not mentioned in this <span
class=SpellE>Labour</span></span></i><span style='font-family:"Times New Roman"'>
<i style='mso-bidi-font-style:normal'>contract shall be resolved according to
the terms and conditions of the Collective <span class=SpellE>Labour</span>
Agreement, otherwise <span class=SpellE>Labour</span> Laws. <o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Hợp</span> <span
class=SpellE>đồng</span> <span class=SpellE>lao</span> <span class=SpellE>động</span>
<span class=SpellE>được</span> <span class=SpellE>làm</span> <span
class=SpellE>thành</span> <span class=SpellE>hai</span> (02) <span
class=SpellE>bản</span> <span class=SpellE>có</span> <span class=SpellE>giá</span>
<span class=SpellE>trị</span> <span class=SpellE>ngang</span> <span
class=SpellE>nhau</span>, <span class=SpellE>mỗi</span> <span class=SpellE>bên</span>
<span class=SpellE>giữ</span> <span class=SpellE>một</span> <span class=SpellE>bản</span>
<span class=SpellE>và</span> <span class=SpellE>có</span> <span class=SpellE>hiệu</span>
<span class=SpellE>lực</span> <span class=SpellE>từ</span> <span class=SpellE><span
class=GramE>ngày</span></span><span class=GramE><span
style='mso-spacerun:yes'>  </span><%=dt_total.Rows[i]["c13"].ToString() %></span> <span class=SpellE>tháng</span><span
style='mso-spacerun:yes'>  </span><%=dt_total.Rows[i]["c14"].ToString() %> <span class=SpellE>năm</span> <%=dt_total.Rows[i]["c15"].ToString() %><b>.</b><span
style='mso-bidi-font-weight:bold'> <span class=SpellE>Mọi</span></span> <span
class=SpellE>phụ</span> <span class=SpellE>lục</span> <span class=SpellE>hợp</span>
<span class=SpellE>đồng</span> <span class=SpellE><span class=GramE>lao</span></span>
<span class=SpellE>động</span> (<span class=SpellE>nếu</span> <span
class=SpellE>có</span>) <span class=SpellE>đều</span> <span class=SpellE>có</span>
<span class=SpellE>giá</span> <span class=SpellE>trị</span> <span class=SpellE>như</span>
<span class=SpellE>các</span> <span class=SpellE>nội</span> dung <span
class=SpellE>của</span> <span class=SpellE>bản</span> <span class=SpellE>hợp</span>
<span class=SpellE>đồng</span> <span class=SpellE>lao</span> <span
class=SpellE>động</span> <span class=SpellE>này</span>. <o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><i
style='mso-bidi-font-style:normal'><span style='font-family:"Times New Roman"'>This
<span class=SpellE>Labour</span> contract is made into two (02) copies of equal
validity<span class=GramE>,<span style='mso-spacerun:yes'>  </span>kept</span>
by each party<span style='mso-spacerun:yes'>  </span>and comes into force from
<%=dt_total.Rows[i]["c13"].ToString() %><span style='mso-spacerun:yes'>  </span>month <%=dt_total.Rows[i]["c14"].ToString() %><span
style='mso-spacerun:yes'>  </span>year <%=dt_total.Rows[i]["c15"].ToString() %> . The Appendix to this <span
class=SpellE>Labour</span> contract (if any) is an integrated part of this <span
class=SpellE>Labour</span> Contract.</span></i><span style='font-family:"Times New Roman"'><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'>- <span class=SpellE>Hợp</span> <span
class=SpellE>đồng</span> <span class=SpellE>này</span> <span class=SpellE>làm</span>
<span class=SpellE>tại</span>:<span style='mso-spacerun:yes'>  </span><span
class=SpellE>Số 507 phố Châu Phong, phường Gia Cẩm, thành phố Việt Trì , Phú Thọ</span> <span class=SpellE></span> <span class=SpellE></span>
<span class=SpellE></span>  <span class=SpellE></span> <span
class=SpellE></span> <span class=SpellE></span> <span class=SpellE></span>
<span class=SpellE></span> <span class=SpellE></span> <span
style='mso-spacerun:yes'> </span><span class=SpellE>ngày</span> <%=dt_total.Rows[i]["c23"].ToString() %> <span
class=SpellE>tháng</span><span style='mso-spacerun:yes'>  </span><%=dt_total.Rows[i]["c24"].ToString() %><b> </b><span
class=SpellE>năm</span> <%=dt_total.Rows[i]["c25"].ToString() %><b style='mso-bidi-font-weight:normal'>.</b><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><i
style='mso-bidi-font-style:normal'><span style='font-family:"Times New Roman"'>This
<span class=SpellE>Labour</span> Contract is made at 507 Châu Phong st, Gia Cẩm ward, Việt Trì, Phú Thọ.  <span class=SpellE></span>
<span class=SpellE></span>  <span class=GramE></span> <span
class=SpellE></span> <span class=SpellE></span> <span
class=SpellE></span><span style='mso-spacerun:yes'>        
</span><span style='mso-spacerun:yes'>                           </span><o:p></o:p></span></i></p>

<p class=MsoNormal style='text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify;line-height:150%'><span
class=SpellE><span style='font-family:"Times New Roman"'>Người</span></span><span
style='font-family:"Times New Roman"'> <span class=SpellE><span class=GramE>lao</span></span>
<span class=SpellE>động</span>/<i style='mso-bidi-font-style:normal'>Employee<span
style='mso-tab-count:2'>                    </span></i><span style='mso-tab-count:
3'>                                    </span><span style='mso-spacerun:yes'> 
</span><span class=SpellE>Người</span> <span class=SpellE>sử</span> <span
class=SpellE>dụng</span> <span class=SpellE>lao</span> <span class=SpellE>động</span>/<i
style='mso-bidi-font-style:normal'>Employer<o:p></o:p></i></span></p>

<p class=MsoNormal style='text-align:justify;line-height:150%'><span
style='font-family:"Times New Roman"'><span style='mso-spacerun:yes'>     
</span>(<span class=SpellE>Ký</span> <span class=SpellE>tên</span>/<i
style='mso-bidi-font-style:normal'>Sign</i>)<span style='mso-tab-count:6'>                                                                     </span><span
style='mso-spacerun:yes'>  </span>(<span class=SpellE>Ký</span> <span
class=SpellE>tên</span>, <span class=SpellE>đóng</span> <span class=SpellE>dấu</span>/<i
style='mso-bidi-font-style:normal'>Sign and stamp</i>)<o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-indent:.5in;line-height:150%'><span
style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-indent:.5in;line-height:150%'><span
style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-indent:.5in;line-height:150%'><span
style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-indent:.5in;line-height:150%'><span
style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify;line-height:150%'><span
class=SpellE><span style='font-family:"Times New Roman"'>Ghi</span></span><span
style='font-family:"Times New Roman"'> <span class=SpellE>rõ</span> <span
class=SpellE>họ</span> <span class=SpellE>và</span> <span class=SpellE>tên</span>/full
name<span style='mso-spacerun:yes'>  </span><span style='mso-tab-count:5'>                                                        </span><span
style='mso-spacerun:yes'>        </span><span class=SpellE>Ghi</span> <span
class=SpellE>rõ</span> <span class=SpellE>họ</span> <span class=SpellE>và</span>
<span class=SpellE>tên</span>/full name<span style='mso-spacerun:yes'>  </span><o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify;line-height:150%;tab-stops:center 1.0in left 4.5in'><b><span
style='font-family:"Times New Roman"'><span style='mso-tab-count:1'> </span><span
class=SpellE><%=dt_total.Rows[i]["c00"].ToString() %></span> <span class=SpellE></span>
<span class=SpellE></span><span style='mso-tab-count:1'>                                  </span>KWEON OH SHIN
<span class=SpellE></span> <o:p></o:p></span></b></p>

<p class=MsoNormal style='text-align:justify;line-height:150%'><b><span
style='font-family:"Times New Roman"'><span style='mso-tab-count:9'>                                                                                                            </span>Project
Director<o:p></o:p></span></b></p>

<p class=MsoNormal style='text-align:justify;line-height:150%'><b><span
style='font-family:"Times New Roman"'><span style='mso-spacerun:yes'>         
</span><span style='mso-tab-count:7'>                                                                          </span><span
style='mso-spacerun:yes'>      </span><span style='mso-tab-count:1'>      </span></span></b><span
style='font-family:"Times New Roman"'><o:p></o:p></span></p>

<b><span style='font-size:12.0pt;font-family:"Times New Roman";mso-fareast-font-family:
"Times New Roman";mso-ansi-language:EN-US;mso-fareast-language:EN-US;
mso-bidi-language:AR-SA'><br clear=all style='page-break-before:always'>
</span></b>

</div>
<%
} %>
</body>

</html>
