<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/msword";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:w="urn:schemas-microsoft-com:office:word"
xmlns="http://www.w3.org/TR/REC-html40"
xmlns:ns0="urn:schemas-microsoft-com:office:smarttags">
<%
    string pk = Request["pk"].ToString();
    string SQL
    =	"	SELECT DECODE (e.full_name, NULL, u.user_name, e.full_name) u_name " + 
        "       ,b.org_id || '-' || b.org_nm group_nm " +
        "       ,'Ngày ' || TO_CHAR (SYSDATE, 'dd') || ' tháng ' || TO_CHAR (SYSDATE, 'MM') || ' năm ' || TO_CHAR (SYSDATE, 'yyyy') dt_time " +
        "       ,(SELECT v.code_nm FROM vhr_hr_code v WHERE v.id = 'HR0008' AND v.code = e.POS_TYPE) pos " +
        "       ,a.course_id || ' - ' || a.course_name course_nm " +
        "       ,a.max_trainee " +
        "       ,a.location " +
        "       ,(SELECT CODE_NM FROM hr.VHR_HR_CODE WHERE ID = 'HR0168' AND CODE = a.train_type) tranning_type " +
        "       ,DECODE (a.budget_yn,  'Y', 'Yes',  'N', 'No',  'No') budget " +
		"		,a.description " +
        "    FROM comm.tco_bsuser u, hr.thr_employee e, comm.tco_org b, hr.thr_train_course a " +
        "    WHERE u.del_if = 0 " +
        "        AND u.user_id = a.crt_by  " +
        "        AND u.thr_abemp_pk = e.pk(+) " +
        "        AND e.tco_org_pk = b.pk " +
        "        AND a.pk = " + pk;
       

   // Response.Write(SQL);
   // Response.End();
    DataTable dt_sum = ESysLib.TableReadOpen(SQL);
    int irow,icol;
    irow = dt_sum.Rows.Count;
    icol = dt_sum.Columns.Count;
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
<link rel=File-List href="chkr00010_files/filelist.xml">
<title>ATTENDING TRAINING REQUEST</title>
<!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Print</w:View>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DisplayHorizontalDrawingGridEvery>0</w:DisplayHorizontalDrawingGridEvery>
  <w:DisplayVerticalDrawingGridEvery>0</w:DisplayVerticalDrawingGridEvery>
  <w:UseMarginsForDrawingGridOrigin/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:Compatibility>
   <w:FootnoteLayoutLikeWW8/>
   <w:ShapeLayoutLikeWW8/>
   <w:AlignTablesRowByRow/>
   <w:ForgetLastTabAlignment/>
   <w:LayoutRawTableWidth/>
   <w:LayoutTableRowsApart/>
   <w:UseWord97LineBreakingRules/>
   <w:SelectEntireFieldWithStartOrEnd/>
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
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;
	mso-font-charset:2;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:0 268435456 0 0 -2147483648 0;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:1627421319 -2147483648 8 0 66047 0;}
@font-face
	{font-family:VNI-Times;
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
	mso-bidi-font-size:10.0pt;
	font-family:VNI-Times;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";}
h1
	{mso-style-next:Normal;
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:1;
	tab-stops:127.6pt 141.75pt 233.9pt 283.5pt 340.2pt;
	font-size:12.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:VNI-Times;
	mso-font-kerning:0pt;
	font-weight:normal;
	mso-bidi-font-weight:bold;
	font-style:italic;}
h3
	{mso-style-next:Normal;
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:3;
	font-size:48.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:"Times New Roman";
	color:red;
	mso-ansi-language:EN-GB;}
p.MsoHeader, li.MsoHeader, div.MsoHeader
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	tab-stops:center 3.0in right 6.0in;
	font-size:12.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:VNI-Times;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";}
p.MsoFooter, li.MsoFooter, div.MsoFooter
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	tab-stops:center 3.0in right 6.0in;
	font-size:12.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:VNI-Times;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";}
p.MsoTitle, li.MsoTitle, div.MsoTitle
	{margin-top:6.0pt;
	margin-right:0in;
	margin-bottom:6.0pt;
	margin-left:0in;
	text-align:center;
	mso-pagination:widow-orphan;
	font-size:18.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:VNI-Times;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:595.45pt 841.7pt;
	margin:49.7pt 67.7pt .2in 1.25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:98062316;
	mso-list-type:simple;
	mso-list-template-ids:67698697;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:63.0pt;
	mso-level-number-position:left;
	margin-left:63.0pt;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1
	{mso-list-id:1195381546;
	mso-list-type:simple;
	mso-list-template-ids:67698703;}
@list l1:level1
	{mso-level-tab-stop:.25in;
	mso-level-number-position:left;
	margin-left:.25in;
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
 <u1:DocumentProperties>
  <u1:Author>Ms Thu</u1:Author>
  <u1:LastAuthor>welcome</u1:LastAuthor>
  <u1:Revision>2</u1:Revision>
  <u1:TotalTime>4</u1:TotalTime>
  <u1:LastPrinted>2010-07-28T05:10:00Z</u1:LastPrinted>
  <u1:Created>2011-09-06T06:49:00Z</u1:Created>
  <u1:LastSaved>2011-09-06T06:49:00Z</u1:LastSaved>
  <u1:Pages>1</u1:Pages>
  <u1:Words>115</u1:Words>
  <u1:Characters>658</u1:Characters>
  <u1:Company>FLDC</u1:Company>
  <u1:Lines>5</u1:Lines>
  <u1:Paragraphs>1</u1:Paragraphs>
  <u1:CharactersWithSpaces>772</u1:CharactersWithSpaces>
  <u1:Version>11.5606</u1:Version>
 </u1:DocumentProperties>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <u2:shapedefaults u3:ext="edit" spidmax="2050"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <u4:shapelayout u5:ext="edit">
  <u4:idmap u5:ext="edit" data="1"/>
 </u4:shapelayout>
</xml><![endif]-->
</head>

<body lang=EN-US style='tab-interval:.5in'>

<div class=Section1>

<p class=MsoTitle style='mso-line-height-alt:1.0pt'><b style='mso-bidi-font-weight:
normal'><span style='mso-bidi-font-size:18.0pt;font-family:Tahoma'>ĐƠN YÊU CẦU ĐÀO
TẠO<u6:p></u6:p></span></b><span style='font-family:Tahoma'><o:p></o:p></span></p>

<p class=MsoTitle style='mso-line-height-alt:1.0pt'><span style='font-size:
12.0pt;font-family:"Times New Roman"'>ATTENDING TRAINING REQUEST<u6:p></u6:p></span></p>

<p class=MsoTitle align=right style='text-align:right;mso-line-height-alt:1.0pt'><span
class=SpellE><span style='font-size:12.0pt;font-family:"Times New Roman"'><%= dt_sum.Rows[0][2].ToString() %></span></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;tab-stops:283.5pt'><span class=SpellE><span style='font-size:
11.0pt;mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>Họ</span></span><span
style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>
<span class=SpellE>và</span> <span class=SpellE>Tên</span> / <i
style='mso-bidi-font-style:normal'>Full-<span class=GramE>name<span
style='font-style:normal'> <b style='mso-bidi-font-weight:normal'>:</b></span></span></i><b
style='mso-bidi-font-weight:normal'><span style='mso-spacerun:yes'>  </span><span
class=SpellE><%= dt_sum.Rows[0][0].ToString() %></span></b>
<span style='mso-tab-count:1'>                        </span><u6:p></u6:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;tab-stops:283.5pt'><span class=SpellE><span style='font-size:
11.0pt;mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>Ch</span><span
style='font-family:"Times New Roman"'>ức</span></span><span style='font-family:
"Times New Roman"'> <span class=SpellE>vụ</span> /</span><i style='mso-bidi-font-style:
normal'><span style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:
"Times New Roman"'>Position</span></i><span style='font-size:11.0pt;mso-bidi-font-size:
10.0pt;font-family:"Times New Roman"'>:<span style='mso-spacerun:yes'>        
</span><span class=SpellE><b style='mso-bidi-font-weight:normal'><%= dt_sum.Rows[0][3].ToString() %></b></span>
<u6:p></u6:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;tab-stops:283.5pt'><span class=SpellE><span style='font-size:
11.0pt;mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>Bộ</span></span><span
style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>
<span class=SpellE>phận</span> / <span class=GramE><i style='mso-bidi-font-style:
normal'>Department :</i></span><i style='mso-bidi-font-style:normal'><span
style='mso-spacerun:yes'>   </span></i><b style='mso-bidi-font-weight:normal'><%= dt_sum.Rows[0][1].ToString() %></b><u6:p></u6:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:.25in;text-indent:-.25in;mso-list:l1 level1 lfo2;tab-stops:list .25in left 283.5pt'><![if !supportLists]><span
style='mso-fareast-font-family:VNI-Times;mso-bidi-font-family:VNI-Times'><span
style='mso-list:Ignore'>1.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span class=SpellE><b style='mso-bidi-font-weight:
normal'><span style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:
"Times New Roman"'>Thông</span></b></span><b style='mso-bidi-font-weight:normal'><span
style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>
tin <span class=SpellE>khóa</span> <span class=SpellE>học</span>/ </span></b><i
style='mso-bidi-font-style:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
10.0pt;font-family:"Times New Roman"'>Course information :<u6:p></u6:p> </span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:49.65pt;text-indent:-.25in;mso-list:l0 level1 lfo4;tab-stops:dashed 42.55pt list blank 63.0pt right 396.9pt'><![if !supportLists]><span
style='font-family:Wingdings;mso-fareast-font-family:Wingdings;mso-bidi-font-family:
Wingdings'><span style='mso-list:Ignore'>v<span style='font:7.0pt "Times New Roman"'>
</span></span></span><![endif]><span class=SpellE><span style='font-size:11.0pt;
mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>Tên</span></span><span
style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>
<span class=SpellE>khóa</span> <span class=SpellE>học</span> / <i
style='mso-bidi-font-style:normal'>Course</i> : <b style='mso-bidi-font-weight:
normal'><%= dt_sum.Rows[0][4].ToString() %></b><u6:p></u6:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:49.65pt;text-indent:-.25in;mso-list:l0 level1 lfo4;tab-stops:dashed 42.55pt list blank 63.0pt right 396.9pt'><![if !supportLists]><span
style='font-family:Wingdings;mso-fareast-font-family:Wingdings;mso-bidi-font-family:
Wingdings'><span style='mso-list:Ignore'>v<span style='font:7.0pt "Times New Roman"'>
</span></span></span><![endif]><span class=SpellE><span style='font-size:11.0pt;
mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>Tổng</span></span><span
style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>
<span class=SpellE>S<span style='font-size:12.0pt;mso-bidi-font-size:10.0pt'>ố</span></span></span><span
style='font-family:"Times New Roman"'> <span class=SpellE>người</span> <span
class=SpellE>tham</span> <span class=SpellE>dự</span>/ P<i style='mso-bidi-font-style:
normal'>articipators:</i></span><i style='mso-bidi-font-style:normal'><span
style='mso-spacerun:yes'>  </span></i><b style='mso-bidi-font-weight:normal'><span
style='font-size:11.0pt;font-family:"Times New Roman"'><%= dt_sum.Rows[0][5].ToString() %></span></b><i
style='mso-bidi-font-style:normal'> </i></p>

<u6:p></u6:p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:49.65pt;text-indent:-.25in;mso-list:l0 level1 lfo4;tab-stops:list 42.55pt 63.0pt'><![if !supportLists]><span
style='font-family:Wingdings;mso-fareast-font-family:Wingdings;mso-bidi-font-family:
Wingdings'><span style='mso-list:Ignore'>v<span style='font:7.0pt "Times New Roman"'>
</span></span></span><![endif]><span class=SpellE><span style='font-size:11.0pt;
mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>Địa</span></span><span
style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>
<span class=SpellE>điểm</span> / <i style='mso-bidi-font-style:normal'>Place:</i>
<span style='mso-spacerun:yes'> </span><b style='mso-bidi-font-weight:normal'><%= dt_sum.Rows[0][6].ToString() %></span></p>

<u6:p></u6:p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:17.85pt;margin-bottom:.0001pt;text-indent:-17.85pt;mso-list:l1 level1 lfo2;
tab-stops:list .25in left 127.6pt 141.75pt 233.9pt 283.5pt 340.2pt'><![if !supportLists]><span
style='mso-fareast-font-family:VNI-Times;mso-bidi-font-family:VNI-Times'><span
style='mso-list:Ignore'>2.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span class=SpellE><b style='mso-bidi-font-weight:
normal'><span style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:
"Times New Roman"'>Loại</span></b></span><b style='mso-bidi-font-weight:normal'><span
style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>
<span class=SpellE>hình</span> <span class=SpellE>đào</span> <span
class=SpellE>tạo</span>/ </span></b><span style='font-size:11.0pt;mso-bidi-font-size:
10.0pt;font-family:"Times New Roman"'>Training type<b style='mso-bidi-font-weight:
normal'> :<span style='mso-spacerun:yes'>  </span></b><span
style='mso-spacerun:yes'> </span><span style='mso-spacerun:yes'> </span><span
class=SpellE><b style='mso-bidi-font-weight:normal'><u6:p></u6:p><%= dt_sum.Rows[0][7].ToString() %></b></span></span><o:p></o:p></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:127.6pt 141.75pt 233.9pt 283.5pt 340.2pt'><b
style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
10.0pt;font-family:"Times New Roman"'><u6:p>&nbsp;</u6:p></span></b></p>

<p class=MsoNormal style='margin-left:.25in;text-indent:-.25in;mso-list:l1 level1 lfo2;
tab-stops:list .25in left 141.75pt 233.9pt'><![if !supportLists]><span
style='mso-fareast-font-family:VNI-Times;mso-bidi-font-family:VNI-Times'><span
style='mso-list:Ignore'>3.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span class=SpellE><b style='mso-bidi-font-weight:
normal'><span style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:
"Times New Roman"'>Ngân</span></b></span><b style='mso-bidi-font-weight:normal'><span
style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>
<span class=SpellE>sách</span>/ </span></b><span style='font-size:11.0pt;
mso-bidi-font-size:10.0pt;font-family:"Times New Roman";mso-no-proof:yes'>Budget
</span><b style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt;
mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>:<span
style='mso-spacerun:yes'>   </span><span class=SpellE><%= dt_sum.Rows[0][8].ToString() %></span> <u6:p></u6:p></span></b><o:p></o:p></p>

<p class=MsoNormal style='tab-stops:141.75pt 233.9pt'><b style='mso-bidi-font-weight:
normal'><span style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:
"Times New Roman"'><u6:p>&nbsp;</u6:p></span></b></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:.25in;text-indent:-.25in;mso-list:l1 level1 lfo2;tab-stops:list .25in left 113.4pt 290.6pt'><![if !supportLists]><span
style='mso-fareast-font-family:VNI-Times;mso-bidi-font-family:VNI-Times'><span
style='mso-list:Ignore'>4.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span class=SpellE><b style='mso-bidi-font-weight:
normal'><span style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:
"Times New Roman"'>Mục</span></b></span><b style='mso-bidi-font-weight:normal'><span
style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>
<span class=SpellE>đích</span> / </span></b><i style='mso-bidi-font-style:normal'><span
style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>Purpose</span></i><span
style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:"Times New Roman";
mso-bidi-font-weight:bold'>:<span style='mso-spacerun:yes'>  </span><span
style='mso-spacerun:yes'> </span></span></p>

<u6:p></u6:p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;tab-stops:113.4pt 290.6pt'><span style='font-size:11.0pt;
font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;line-height:125%;tab-stops:113.4pt 290.6pt'><span
style='font-size:11.0pt;line-height:125%;font-family:"Times New Roman"'><%= dt_sum.Rows[0][9].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;tab-stops:113.4pt 290.6pt'><span style='font-size:11.0pt;
font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 align=left
 style='border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-yfti-tbllook:480;mso-table-lspace:9.0pt;margin-left:6.75pt;mso-table-rspace:
 9.0pt;margin-right:6.75pt;mso-table-anchor-vertical:paragraph;mso-table-anchor-horizontal:
 margin;mso-table-left:left;mso-table-top:32.55pt;mso-padding-alt:0in 5.4pt 0in 5.4pt;
 mso-border-insideh:.5pt solid windowtext;mso-border-insidev:.5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:13.25pt'>
  <td width=148 style='width:110.85pt;border:solid windowtext 1.0pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:13.25pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:right dashed 396.9pt;
  mso-element:frame;mso-element-frame-hspace:9.0pt;mso-element-wrap:around;
  mso-element-anchor-vertical:paragraph;mso-element-anchor-horizontal:margin;
  mso-element-top:32.55pt;mso-height-rule:exactly'><span style='font-size:11.0pt;
  mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>Prepared<u6:p></u6:p></span></p>
  </td>
  <td width=158 style='width:118.75pt;border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:13.25pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:right dashed 396.9pt;
  mso-element:frame;mso-element-frame-hspace:9.0pt;mso-element-wrap:around;
  mso-element-anchor-vertical:paragraph;mso-element-anchor-horizontal:margin;
  mso-element-top:32.55pt;mso-height-rule:exactly'><span style='font-size:11.0pt;
  mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>Manager<u6:p></u6:p></span></p>
  </td>
  <td width=162 style='width:121.15pt;border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:13.25pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:right dashed 396.9pt;
  mso-element:frame;mso-element-frame-hspace:9.0pt;mso-element-wrap:around;
  mso-element-anchor-vertical:paragraph;mso-element-anchor-horizontal:margin;
  mso-element-top:32.55pt;mso-height-rule:exactly'><span style='font-size:11.0pt;
  mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>G. Manager<u6:p></u6:p></span></p>
  </td>
  <td width=148 style='width:110.85pt;border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:13.25pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:right dashed 396.9pt;
  mso-element:frame;mso-element-frame-hspace:9.0pt;mso-element-wrap:around;
  mso-element-anchor-vertical:paragraph;mso-element-anchor-horizontal:margin;
  mso-element-top:32.55pt;mso-height-rule:exactly'><span style='font-size:11.0pt;
  mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>Director<u6:p></u6:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1;mso-yfti-lastrow:yes;height:40.0pt'>
  <td width=148 valign=top style='width:110.85pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:40.0pt'>
  <p class=MsoNormal style='tab-stops:right dashed 396.9pt;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:margin;mso-element-top:32.55pt;
  mso-height-rule:exactly'><span style='font-size:11.0pt;mso-bidi-font-size:
  10.0pt;font-family:"Times New Roman"'><u6:p>&nbsp;</u6:p></span><o:p></o:p></p>
  </td>
  <td width=158 valign=top style='width:118.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:40.0pt'>
  <p class=MsoNormal style='tab-stops:right dashed 396.9pt;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:margin;mso-element-top:32.55pt;
  mso-height-rule:exactly'><span style='font-size:11.0pt;mso-bidi-font-size:
  10.0pt;font-family:"Times New Roman"'><u6:p>&nbsp;</u6:p></span><o:p></o:p></p>
  <p class=MsoNormal style='tab-stops:right dashed 396.9pt;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:margin;mso-element-top:32.55pt;
  mso-height-rule:exactly'><span style='font-size:11.0pt;mso-bidi-font-size:
  10.0pt;font-family:"Times New Roman"'><u6:p>&nbsp;</u6:p></span><o:p></o:p></p>
  <p class=MsoNormal style='tab-stops:right dashed 396.9pt;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:margin;mso-element-top:32.55pt;
  mso-height-rule:exactly'><span style='font-size:11.0pt;mso-bidi-font-size:
  10.0pt;font-family:"Times New Roman"'><u6:p>&nbsp;</u6:p></span><o:p></o:p></p>
  <p class=MsoNormal style='tab-stops:right dashed 396.9pt;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:margin;mso-element-top:32.55pt;
  mso-height-rule:exactly'><span style='font-size:11.0pt;mso-bidi-font-size:
  10.0pt;font-family:"Times New Roman"'><u6:p>&nbsp;</u6:p></span><o:p></o:p></p>
  </td>
  <td width=162 valign=top style='width:121.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:40.0pt'>
  <p class=MsoNormal style='tab-stops:right dashed 396.9pt;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:margin;mso-element-top:32.55pt;
  mso-height-rule:exactly'><span style='font-size:11.0pt;mso-bidi-font-size:
  10.0pt;font-family:"Times New Roman"'><u6:p>&nbsp;</u6:p></span><o:p></o:p></p>
  </td>
  <td width=148 valign=top style='width:110.85pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:40.0pt'>
  <p class=MsoNormal style='tab-stops:right dashed 396.9pt;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:margin;mso-element-top:32.55pt;
  mso-height-rule:exactly'><span style='font-size:11.0pt;mso-bidi-font-size:
  10.0pt;font-family:"Times New Roman"'><u6:p>&nbsp;</u6:p></span></p>
  </td>
 </tr>
</table>

<p class=MsoNormal style='margin-left:.25in;tab-stops:right dashed 396.9pt'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-family:
"Times New Roman"'><u6:p>&nbsp;</u6:p></span></i><o:p></o:p></p>

<p class=MsoNormal style='margin-left:.25in;tab-stops:right dashed 396.9pt'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-family:
"Times New Roman"'><u6:p>&nbsp;</u6:p></span></i><o:p></o:p></p>

<p class=MsoNormal style='margin-left:.25in;tab-stops:right dashed 396.9pt'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-family:
"Times New Roman"'><u6:p>&nbsp;</u6:p></span></i></p>

</div>

</body>

</html>
