<%@ Page Language="C#"%>
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
        + "a.FULL_NAME || '(' || a.emp_id || ')' "
        + ",decode(nvl(a.sex,0),'M','X',0) as Male "
        + ",decode(nvl(a.sex,0),'F','X',0) as FeMale "
        + ",(case when length(a.BIRTH_DT)=4 then a.birth_dt else to_char(to_date(a.birth_dt,'yyyymmdd'),'dd/mm/yyyy') end ) as birth_dt "
        + ",(select v.code_fnm from vhr_hr_code v where v.id='HR0015' and v.code=a.ETHNIC_TYPE) as ETHNIC "
        + ",(select v.code_fnm from vhr_hr_code v where v.id='HR0009' and v.code=a.NATION) as nation "
        + ",(select v.code_fnm from vhr_hr_code v where v.id='HR0021' and v.code=a.PLACE_BIRTH) as nguyenquan "
        + ",a.PERMANENT_ADDR as noicutru "
        + ",a.PERSON_ID  as personid "
        + ",(select v.code_fnm from vhr_hr_code v where v.id='HR0014' and v.code=a.PLACE_PER_ID) as noicap "
        + ",to_char(to_date(a.ISSUE_DT,'yyyymmdd'),'dd/mm/yyyy') as issued_dt "
        + ",a.HEALTH_NO "
        + ",(select v.code_fnm from vhr_hr_code v where v.id='HR0012' and v.code=a.HEALTH_PLACE) "
        + ",to_char(to_date(a.BEGIN_CONTRACT,'yyyymmdd'),'mm/yyyy') as tuthang "
        + ",to_char(to_date(a.BEGIN_CONTRACT,'yyyymmdd'),'mm/yyyy') as denthang "
        + ",(select v.code_fnm from vhr_hr_code v where v.id='HR0008' and v.code=a.POS_TYPE) as pos_type "
        + ",(select PARTNER_LNAME from comm.tco_company p where p.del_if=0 and p.pk=c.tco_company_pk) as tencongty "
        + ",(select p.ADDR1 from comm.tco_company p where p.del_if=0 and p.pk=c.tco_company_pk) as diachi "
        + ",(Select TO_CHAR(s.salary_level2,'999,999,999') from THR_SALARY_MANAGE s where s.del_if=0 and s.thr_emp_pk=a.pk and s.work_mon=substr(a.BEGIN_CONTRACT,1,6)) as salary,a.pk,a.FULL_NAME  "
        + ",(select v.code_fnm from vhr_hr_code v where v.id='HR0049' and v.code='11') as noicongtac21 , nvl(a.social_no,'          ') socialno22 "
        + "from thr_employee a,comm.tco_org c "
        + "where a.del_if=0 and c.del_if=0 and a.tco_org_pk=c.pk "
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
    //getting employeer
    SQL
    = "select max(decode(code,'01',code_fnm,'')) ,max(decode(code,'04',code_fnm,'')) " +
        "from vhr_hr_code " +
        "where id='HR0048' group by id  ";
    DataTable dt_name = ESysLib.TableReadOpen(SQL);
    int irow_name;
    irow_name = dt_name.Rows.Count;
   
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
	font-size:11.0pt;
	mso-bidi-font-size:9.0pt;
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
	font-size:11.0pt;
	mso-bidi-font-size:9.0pt;
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
	font-size:11.0pt;
	mso-bidi-font-size:9.0pt;
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

<div class=Section1>
<% 
     
     for (int i = 0; i < irow; i++) 
    {
       
    %> 
<p class=MsoNormal style='tab-stops:.1in'><span style='font-size:11.0pt;
font-family:"Times New Roman";mso-fareast-font-family:"Times New Roman";
mso-bidi-font-weight:bold'><b>&#272;&#417;n <span class=GramE>V&#7883; </b>:</span> </span><span
style='font-size:11.0pt;font-family:"Times New Roman";mso-fareast-font-family:
"Times New Roman";font-weight:normal'>CTy TNHH HanSoll – Daekwang Apparel</span><span
style='font-size:11.0pt;font-family:"Times New Roman";mso-fareast-font-family:
"Times New Roman";mso-bidi-font-weight:bold'><span
style='mso-spacerun:yes'>       </span></span><span style='font-size:11.0pt;
font-family:"Times New Roman";mso-fareast-font-family:"Times New Roman";
font-weight:normal'><span
style='mso-spacerun:yes'>               </span>C&#7896;NG HÒA XÃ H&#7896;I
CH&#7910; NGH&#296;A VI&#7878;T <st1:country-region w:st="on"><st1:place w:st="on">NAM</st1:place></st1:country-region>
<o:p></o:p></span></p>

<p class=MsoNormal style='tab-stops:.1in'><span style='font-size:11.0pt;
font-family:"Times New Roman";mso-fareast-font-family:"Times New Roman";
mso-bidi-font-weight:bold'><b>&#272;/ <span class=GramE>C</b> :</span><span
style='mso-spacerun:yes'>  </span></span><span style='font-size:11.0pt;
font-family:"Times New Roman";mso-fareast-font-family:"Times New Roman";
font-weight:normal'>S&#7889; 01 – KCN Bình &#272;&#432;&#7901;ng – D&#297; An –
Bình D&#432;&#417;ng</span><span style='font-size:11.0pt;font-family:"Times New Roman";
mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:bold'><span
style='mso-spacerun:yes'>                        </span></span><span
style='font-size:11.0pt;font-family:"Times New Roman";mso-fareast-font-family:
"Times New Roman";font-weight:normal'>&#272;&#7896;C L&#7852;P – T&#7920; DO –
H&#7840;NH PHÚC</span><span style='font-size:11.0pt;font-family:"Times New Roman";
mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:bold'> <o:p></o:p></span></p>

<div>

<p class=MsoNormal align=center style='margin-left:334.5pt;text-align:center'><b><span
style='font-size:10.0pt;mso-ansi-language:EN-US'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal align=center style='margin-left:334.5pt;text-align:center'><b><span
lang=VI style='font-size:7.0pt'>M</span></b><b><span lang=VI style='font-size:
7.0pt;font-family:Arial'>ẫ</span></b><b><span lang=VI style='font-size:7.0pt'>u
s</span></b><b><span lang=VI style='font-size:7.0pt;font-family:Arial'>ố</span></b><b><span
lang=VI style='font-size:7.0pt'>: 01-TBH</span></b><b><span style='font-size:
7.0pt;mso-ansi-language:EN-US'><o:p></o:p></span></b></p>

</div>


<p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><b><span
lang=VI style='font-size:14.0pt;font-family:"Times New Roman"'>TỜ KHAI</span></b><b><span
style='font-size:13.0pt;font-family:"Times New Roman";mso-ansi-language:EN-US'><o:p></o:p></span></b></p>

<p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><b><span
lang=VI style='font-size:14.0pt;font-family:"Times New Roman"'>THAM GIA BẢO
HIỂM XÃ HỘI, BẢO HIỂM Y TẾ BẮT BUỘC<o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt'>

<!--[if gte vml 1]><v:rect id="<%=i*10 +9%>"
 style='position:absolute;left:0;text-align:left;margin-left:341.85pt;
 margin-top:7.9pt;width:17.2pt;height:17.25pt;z-index:-1'>
 <v:textbox style='mso-next-textbox:#<%=i*10 +9%>' inset="3.6pt,.72pt,3.6pt,.72pt"/>
</v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
absolute;z-index:-1;left:0px;margin-left:455px;margin-top:10px;width:29px;
height:29px'>

<table cellpadding=0 cellspacing=0>
 <tr>
  <td width=29 height=29 bgcolor=white style='border:.75pt solid black;
  vertical-align:top;background:white'><![endif]><![if !mso]><span
  style='position:absolute;mso-ignore:vglayout;left:0pt;z-index:-1'>
  <table cellpadding=0 cellspacing=0 width="100%">
   <tr>
    <td><![endif]>
    <div v:shape="<%=i*10 +9%>" style='padding:1.47pt 4.35pt 1.47pt 4.35pt'
    class=shape>
    <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][22].ToString().Substring(9,1)%><o:p></o:p></span></p>
    </div>
    <![if !mso]></td>
   </tr>
  </table>
  </span><![endif]><![if !mso & !vml]>&nbsp;<![endif]><![if !vml]></td>
 </tr>
</table>
</span><![endif]>


<!--[if gte vml 1]><v:rect id="<%=i*10 +8%>" style='position:absolute;
 left:0;text-align:left;margin-left:324.7pt;margin-top:7.9pt;width:17.15pt;
 height:17.25pt;z-index:-2'>
 <v:textbox style='mso-next-textbox:#<%=i*10 +8%>' inset="3.6pt,.72pt,3.6pt,.72pt"/>
</v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
absolute;z-index:-2;left:0px;margin-left:432px;margin-top:10px;width:29px;
height:29px'>

<table cellpadding=0 cellspacing=0>
 <tr>
  <td width=29 height=29 bgcolor=white style='border:.75pt solid black;
  vertical-align:top;background:white'><![endif]><![if !mso]><span
  style='position:absolute;mso-ignore:vglayout;left:0pt;z-index:-2'>
  <table cellpadding=0 cellspacing=0 width="100%">
   <tr>
    <td><![endif]>
    <div v:shape="<%=i*10 +8%>" style='padding:1.47pt 4.35pt 1.47pt 4.35pt'
    class=shape>
    <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][22].ToString().Substring(8,1)%><o:p></o:p></span></p>
    </div>
    <![if !mso]></td>
   </tr>
  </table>
  </span><![endif]><![if !mso & !vml]>&nbsp;<![endif]><![if !vml]></td>
 </tr>
</table>

</span><![endif]><!--[if gte vml 1]><v:rect id="<%=i*10 +7%>" style='position:absolute;
 left:0;text-align:left;margin-left:307.5pt;margin-top:7.9pt;width:17.2pt;
 height:17.25pt;z-index:-3'>
 <v:textbox style='mso-next-textbox:#<%=i*10 +7%>' inset="3.6pt,.72pt,3.6pt,.72pt"/>
</v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
absolute;z-index:-3;left:0px;margin-left:409px;margin-top:10px;width:29px;
height:29px'>

<table cellpadding=0 cellspacing=0>
 <tr>
  <td width=29 height=29 bgcolor=white style='border:.75pt solid black;
  vertical-align:top;background:white'><![endif]><![if !mso]><span
  style='position:absolute;mso-ignore:vglayout;left:0pt;z-index:-3'>
  <table cellpadding=0 cellspacing=0 width="100%">
   <tr>
    <td><![endif]>
    <div v:shape="<%=i*10 +7%>" style='padding:1.47pt 4.35pt 1.47pt 4.35pt'
    class=shape>
    <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][22].ToString().Substring(7,1)%><o:p></o:p></span></p>
    </div>
    <![if !mso]></td>
   </tr>
  </table>
  </span><![endif]><![if !mso & !vml]>&nbsp;<![endif]><![if !vml]></td>
 </tr>
</table>

</span><![endif]><!--[if gte vml 1]><v:rect id="<%=i*10 +6%>" style='position:absolute;
 left:0;text-align:left;margin-left:290.35pt;margin-top:7.9pt;width:17.15pt;
 height:17.25pt;z-index:-4'>
 <v:textbox style='mso-next-textbox:#<%=i*10 +6%>' inset="3.6pt,.72pt,3.6pt,.72pt"/>
</v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
absolute;z-index:-4;left:0px;margin-left:386px;margin-top:10px;width:29px;
height:29px'>

<table cellpadding=0 cellspacing=0>
 <tr>
  <td width=29 height=29 bgcolor=white style='border:.75pt solid black;
  vertical-align:top;background:white'><![endif]><![if !mso]><span
  style='position:absolute;mso-ignore:vglayout;left:0pt;z-index:-4'>
  <table cellpadding=0 cellspacing=0 width="100%">
   <tr>
    <td><![endif]>
    <div v:shape="<%=i*10 +6%>" style='padding:1.47pt 4.35pt 1.47pt 4.35pt'
    class=shape>
    <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][22].ToString().Substring(6,1)%><o:p></o:p></span></p>
    </div>
    <![if !mso]></td>
   </tr>
  </table>
  </span><![endif]><![if !mso & !vml]>&nbsp;<![endif]><![if !vml]></td>
 </tr>
</table>

</span><![endif]><!--[if gte vml 1]><v:rect id="<%=i*10 +5%>" style='position:absolute;
 left:0;text-align:left;margin-left:273.2pt;margin-top:7.9pt;width:17.15pt;
 height:17.25pt;z-index:-5'>
 <v:textbox style='mso-next-textbox:#<%=i*10 +5%>' inset="3.6pt,.72pt,3.6pt,.72pt"/>
</v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
absolute;z-index:-5;left:0px;margin-left:363px;margin-top:10px;width:29px;
height:29px'>

<table cellpadding=0 cellspacing=0>
 <tr>
  <td width=29 height=29 bgcolor=white style='border:.75pt solid black;
  vertical-align:top;background:white'><![endif]><![if !mso]><span
  style='position:absolute;mso-ignore:vglayout;left:0pt;z-index:-5'>
  <table cellpadding=0 cellspacing=0 width="100%">
   <tr>
    <td><![endif]>
    <div v:shape="<%=i*10 +5%>" style='padding:1.47pt 4.35pt 1.47pt 4.35pt'
    class=shape>
    <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][22].ToString().Substring(5,1)%><o:p></o:p></span></p>
    </div>
    <![if !mso]></td>
   </tr>
  </table>
  </span><![endif]><![if !mso & !vml]>&nbsp;<![endif]><![if !vml]></td>
 </tr>
</table>

</span><![endif]><!--[if gte vml 1]><v:rect id="<%=i*10 +4%>" style='position:absolute;
 left:0;text-align:left;margin-left:256pt;margin-top:7.9pt;width:17.2pt;
 height:17.25pt;z-index:-6'>
 <v:textbox style='mso-next-textbox:#<%=i*10 +4%>' inset="3.6pt,.72pt,3.6pt,.72pt"/>
</v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
absolute;z-index:-6;left:0px;margin-left:340px;margin-top:10px;width:29px;
height:29px'>

<table cellpadding=0 cellspacing=0>
 <tr>
  <td width=29 height=29 bgcolor=white style='border:.75pt solid black;
  vertical-align:top;background:white'><![endif]><![if !mso]><span
  style='position:absolute;mso-ignore:vglayout;left:0pt;z-index:-6'>
  <table cellpadding=0 cellspacing=0 width="100%">
   <tr>
    <td><![endif]>
    <div v:shape="<%=i*10 +4%>" style='padding:1.47pt 4.35pt 1.47pt 4.35pt'
    class=shape>
    <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][22].ToString().Substring(4,1)%><o:p></o:p></span></p>
    </div>
    <![if !mso]></td>
   </tr>
  </table>
  </span><![endif]><![if !mso & !vml]>&nbsp;<![endif]><![if !vml]></td>
 </tr>
</table>

</span><![endif]><!--[if gte vml 1]><v:rect id="<%=i*10 +3%>" style='position:absolute;
 left:0;text-align:left;margin-left:239.55pt;margin-top:7.9pt;width:17.2pt;
 height:17.25pt;z-index:-7'>
 <v:textbox style='mso-next-textbox:#<%=i*10 +3%>' inset="3.6pt,.72pt,3.6pt,.72pt"/>
</v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
absolute;z-index:-7;left:0px;margin-left:318px;margin-top:10px;width:29px;
height:29px'>

<table cellpadding=0 cellspacing=0>
 <tr>
  <td width=29 height=29 bgcolor=white style='border:.75pt solid black;
  vertical-align:top;background:white'><![endif]><![if !mso]><span
  style='position:absolute;mso-ignore:vglayout;left:0pt;z-index:-7'>
  <table cellpadding=0 cellspacing=0 width="100%">
   <tr>
    <td><![endif]>
    <div v:shape="<%=i*10 +3%>" style='padding:1.47pt 4.35pt 1.47pt 4.35pt'
    class=shape>
    <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][22].ToString().Substring(3,1)%><o:p></o:p></span></p>
    </div>
    <![if !mso]></td>
   </tr>
  </table>
  </span><![endif]><![if !mso & !vml]>&nbsp;<![endif]><![if !vml]></td>
 </tr>
</table>

</span><![endif]><!--[if gte vml 1]><v:rect id="<%=i*10 +2%>" style='position:absolute;
 left:0;text-align:left;margin-left:222.4pt;margin-top:7.9pt;width:17.15pt;
 height:17.25pt;z-index:-8'>
 <v:textbox style='mso-next-textbox:#<%=i*10 +2%>' inset="3.6pt,.72pt,3.6pt,.72pt"/>
</v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
absolute;z-index:-8;left:0px;margin-left:296px;margin-top:10px;width:28px;
height:29px'>

<table cellpadding=0 cellspacing=0>
 <tr>
  <td width=28 height=29 bgcolor=white style='border:.75pt solid black;
  vertical-align:top;background:white'><![endif]><![if !mso]><span
  style='position:absolute;mso-ignore:vglayout;left:0pt;z-index:-8'>
  <table cellpadding=0 cellspacing=0 width="100%">
   <tr>
    <td><![endif]>
    <div v:shape="<%=i*10 +2%>" style='padding:1.47pt 4.35pt 1.47pt 4.35pt'
    class=shape>
    <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][22].ToString().Substring(2,1)%><o:p></o:p></span></p>
    </div>
    <![if !mso]></td>
   </tr>
  </table>
  </span><![endif]><![if !mso & !vml]>&nbsp;<![endif]><![if !vml]></td>
 </tr>
</table>

</span><![endif]><!--[if gte vml 1]><v:rect id="<%=i*10 +1%>" style='position:absolute;
 left:0;text-align:left;margin-left:205.2pt;margin-top:7.9pt;width:17.2pt;
 height:17.25pt;z-index:-9'>
 <v:textbox style='mso-next-textbox:#<%=i*10 +1%>' inset="3.6pt,.72pt,3.6pt,.72pt"/>
</v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
absolute;z-index:-9;left:0px;margin-left:273px;margin-top:10px;width:29px;
height:29px'>

<table cellpadding=0 cellspacing=0>
 <tr>
  <td width=29 height=29 bgcolor=white style='border:.75pt solid black;
  vertical-align:top;background:white'><![endif]><![if !mso]><span
  style='position:absolute;mso-ignore:vglayout;left:0pt;z-index:-9'>
  <table cellpadding=0 cellspacing=0 width="100%">
   <tr>
    <td><![endif]>
    <div v:shape="<%=i*10 +1%>" style='padding:1.47pt 4.35pt 1.47pt 4.35pt'
    class=shape>
    <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][22].ToString().Substring(1,1)%><o:p></o:p></span></p>
    </div>
    <![if !mso]></td>
   </tr>
  </table>
  </span><![endif]><![if !mso & !vml]>&nbsp;<![endif]><![if !vml]></td>
 </tr>
</table>

</span><![endif]><!--[if gte vml 1]><v:rect id="<%=i*10%>" style='position:absolute;
 left:0;text-align:left;margin-left:188pt;margin-top:7.9pt;width:17.2pt;
 height:17.25pt;z-index:-10'>
 <v:textbox style='mso-next-textbox:#<%=i*10%>' inset="3.6pt,.72pt,3.6pt,.72pt"/>
</v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
absolute;z-index:-10;left:0px;margin-left:250px;margin-top:10px;width:29px;
height:29px'>

<table cellpadding=0 cellspacing=0>
 <tr>
  <td width=29 height=29 bgcolor=white style='border:.75pt solid black;
  vertical-align:top;background:white'><![endif]><![if !mso]><span
  style='position:absolute;mso-ignore:vglayout;left:0pt;z-index:-10'>
  <table cellpadding=0 cellspacing=0 width="100%">
   <tr>
    <td><![endif]>
    <div v:shape="<%=i*10%>" style='padding:1.47pt 4.35pt 1.47pt 4.35pt'
    class=shape>
    <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][22].ToString().Substring(0,1)%><o:p></o:p></span></p>
    </div>
    <![if !mso]></td>
   </tr>
  </table>
  </span><![endif]><![if !mso & !vml]>&nbsp;<![endif]><![if !vml]></td>
 </tr>
</table>

</span><![endif]>
<b>
<span lang=PT-BR style='mso-bidi-font-size:14.0pt;
font-family:"Times New Roman";mso-ansi-language:PT-BR'><span style='mso-tab-count:
4'> </span>
</span></b><b><span style='mso-bidi-font-size:14.0pt;
font-family:"Times New Roman";mso-ansi-language:EN-US'><o:p></o:p></span></b></p>


<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span style='mso-tab-count:
4'> </span><b><u>
<span style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
EN-US'>Số sổ:</span></u></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><u><span
style='font-size:11.0pt;font-family:"Times New Roman";mso-ansi-language:EN-US'>A.
NGƯỜI LAO ĐỘNG:<o:p></o:p></span></u></b></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify;tab-stops:386.95pt'><span
lang=PT-BR style='mso-bidi-font-size:11.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'>- Họ và tên: <%= dt_total.Rows[i][0].ToString() %><span style='mso-tab-count:
1'>                                                    </span>Nam<span
style='mso-spacerun:yes'>   </span></span><span lang=PT-BR style='mso-bidi-font-size:
11.0pt;font-family:"Wingdings 2";mso-ascii-font-family:"Times New Roman";
mso-hansi-font-family:"Times New Roman";mso-ansi-language:PT-BR;mso-char-type:
symbol;mso-symbol-font-family:"Wingdings 2"'><span style='mso-char-type:symbol;
mso-symbol-font-family:"Wingdings 2"'><% if (dt_total.Rows[i][1].ToString()=="X") 
                                                Response.Write("T");
                                         else
                                                Response.Write("£");
                                         %></span></span><span lang=PT-BR
style='mso-bidi-font-size:11.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><span style='mso-spacerun:yes'>   </span>Nữ<span
style='mso-spacerun:yes'>  </span></span><span lang=PT-BR style='mso-bidi-font-size:
11.0pt;font-family:"Wingdings 2";mso-ascii-font-family:"Times New Roman";
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
lang=PT-BR style='mso-bidi-font-size:11.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'>- Ngày tháng năm sinh: <%=dt_total.Rows[i][3].ToString() %><span
style='mso-tab-count:1'>        </span>Dân tộc: <%=dt_total.Rows[i][4].ToString() %><span style='mso-tab-count:
1'>               </span>Quốc tịch: <%=dt_total.Rows[i][5].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span
lang=PT-BR style='mso-bidi-font-size:11.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'>- Nguyên Quán: <%=dt_total.Rows[i][6].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=SV
style='mso-bidi-font-size:11.0pt;font-family:"Times New Roman";mso-ansi-language:
SV'>- Nơi cư trú (Thường trú hay tạm trú): <%=dt_total.Rows[i][7].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify;tab-stops:250.7pt 386.95pt'><span
style='mso-bidi-font-size:11.0pt;font-family:"Times New Roman";mso-ansi-language:
EN-US'>- Giấy CMND số: <%=dt_total.Rows[i][8].ToString() %><span style='mso-tab-count:1'>                 </span>Nơi
cấp: <%=dt_total.Rows[i][9].ToString() %><span style='mso-tab-count:1'>    </span>Ngày cấp: <%=dt_total.Rows[i][10].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=FR
style='mso-bidi-font-size:11.0pt;font-family:"Times New Roman";mso-ansi-language:
FR'>- Số thẻ BHYT (nếu có): <%=dt_total.Rows[i][11].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=SV
style='mso-bidi-font-size:11.0pt;font-family:"Times New Roman";mso-ansi-language:
SV'>- Nơi đăng ký khám chữa bệnh ban đầu: <%=dt_total.Rows[i][12].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=FR
style='mso-bidi-font-size:11.0pt;font-family:"Times New Roman";mso-ansi-language:
FR'>- Quyền lợi khám chữa bệnh:<o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><!--[if gte vml 1]><v:group
 id="_x0000_s1086" style='position:absolute;left:0;text-align:left;
 margin-left:270.85pt;margin-top:2.7pt;width:14.7pt;height:52.25pt;z-index:12'
 coordorigin="6203,6601" coordsize="294,1045">
 <v:rect id="_x0000_s1087" style='position:absolute;left:6203;top:6601;width:294;
  height:295'/>
 <v:rect id="_x0000_s1088" style='position:absolute;left:6203;top:6969;width:294;
  height:295'/>
 
</v:group><![endif]--><span
lang=FR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:FR'><span style='mso-tab-count:1'>       </span></span><span
lang=IT style='mso-bidi-font-size:11.0pt;font-family:"Times New Roman";
mso-ansi-language:IT'>+ Người có công:<span style='mso-tab-count:3'>                     </span>.
Loại A:<o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=IT
style='mso-bidi-font-size:11.0pt;font-family:"Times New Roman";mso-ansi-language:
IT'><span style='mso-tab-count:6'>                                                       </span>.
Loại B:<o:p></o:p></span></p>


<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=IT
style='mso-bidi-font-size:11.0pt;font-family:"Times New Roman";mso-ansi-language:
IT'><span style='mso-tab-count:1'>       </span>+ Sống hoặc làm việc ở khu vực
I, II, III:<o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:28.9pt;margin-bottom:.0001pt;text-align:justify;text-indent:
-.25in;mso-list:l0 level1 lfo2;tab-stops:list 28.9pt'><![if !supportLists]><span
lang=IT style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:IT;mso-bidi-font-weight:bold'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><b><span lang=IT style='mso-bidi-font-size:11.0pt;
font-family:"Times New Roman";mso-ansi-language:IT'>Thời gian công tác có đóng
bảo hiểm xã hội:<o:p></o:p></span></b></p>

<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 width="99%"
 style='width:99.98%;border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-yfti-tbllook:480;mso-padding-alt:0in 5.75pt 0in 5.75pt;mso-border-insideh:
 .5pt solid windowtext;mso-border-insidev:.5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes'>
  <td width="21%" colspan=2 style='width:21.82%;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=IT style='font-size:7.0pt;font-family:"Times New Roman";mso-ansi-language:
  IT'>Thời gian</span><b><span lang=IT style='mso-bidi-font-size:14.0pt;
  font-family:"Times New Roman";mso-ansi-language:IT'><o:p></o:p></span></b></p>
  </td>
  <td width="27%" rowspan=2 style='width:27.68%;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:7.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR'>Cấp bậc, chức vụ, chức danh nghề, công việc, nơi làm việc (tên cơ
  quan, đơn vị, địa chỉ)</span><b><span lang=IT style='mso-bidi-font-size:14.0pt;
  font-family:"Times New Roman";mso-ansi-language:IT'><o:p></o:p></span></b></p>
  </td>
  <td width="10%" rowspan=2 style='width:10.92%;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:7.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR'>Tiền lương, tiền công</span><b><span lang=IT style='mso-bidi-font-size:
  14.0pt;font-family:"Times New Roman";mso-ansi-language:IT'><o:p></o:p></span></b></p>
  </td>
  <td width="31%" colspan=4 style='width:31.0%;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:7.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR'>Phụ cấp</span><b><span lang=IT style='mso-bidi-font-size:14.0pt;
  font-family:"Times New Roman";mso-ansi-language:IT'><o:p></o:p></span></b></p>
  </td>
  <td width="8%" rowspan=2 style='width:8.58%;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:7.0pt;font-family:"Times New Roman";mso-ansi-language:
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
  lang=IT style='font-size:7.0pt;font-family:"Times New Roman";mso-ansi-language:
  IT'>Từ<o:p></o:p></span></p>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=IT style='font-size:7.0pt;font-family:"Times New Roman";mso-ansi-language:
  IT'>tháng/năm</span><b><span lang=IT style='mso-bidi-font-size:14.0pt;
  font-family:"Times New Roman";mso-ansi-language:IT'><o:p></o:p></span></b></p>
  </td>
  <td width="10%" style='width:10.9%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
  margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><span
  lang=IT style='font-size:7.0pt;font-family:"Times New Roman";mso-ansi-language:
  IT'>Đến<o:p></o:p></span></p>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=IT style='font-size:7.0pt;font-family:"Times New Roman";mso-ansi-language:
  IT'>tháng/năm</span><b><span lang=IT style='mso-bidi-font-size:14.0pt;
  font-family:"Times New Roman";mso-ansi-language:IT'><o:p></o:p></span></b></p>
  </td>
  <td width="7%" style='width:7.34%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:7.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR'>Chức vụ</span><b><span lang=IT style='mso-bidi-font-size:14.0pt;
  font-family:"Times New Roman";mso-ansi-language:IT'><o:p></o:p></span></b></p>
  </td>
  <td width="8%" style='width:8.24%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:7.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR'>Thâm niên VK</span><b><span lang=IT style='mso-bidi-font-size:14.0pt;
  font-family:"Times New Roman";mso-ansi-language:IT'><o:p></o:p></span></b></p>
  </td>
  <td width="7%" style='width:7.94%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:7.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR'>Thâm niên nghề</span><b><span lang=IT style='mso-bidi-font-size:14.0pt;
  font-family:"Times New Roman";mso-ansi-language:IT'><o:p></o:p></span></b></p>
  </td>
  <td width="7%" style='width:7.48%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:7.0pt;font-family:"Times New Roman";mso-ansi-language:
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
  7.0pt;font-family:"Times New Roman";mso-ansi-language:IT;mso-bidi-font-weight:
  bold'><%=dt_total.Rows[i][13].ToString() %><o:p></o:p></span></p>
  </td>
  <td width="10%" valign=top style='width:10.9%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><span lang=IT style='font-size:
  7.0pt;font-family:"Times New Roman";mso-ansi-language:IT;mso-bidi-font-weight:
  bold'><%=dt_total.Rows[i][14].ToString() %></span><b><span lang=IT style='mso-bidi-font-size:14.0pt;
  font-family:"Times New Roman";mso-ansi-language:IT'><o:p></o:p></span></b></p>
  </td>
  <td width="27%" valign=top style='width:27.68%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><span lang=IT style='font-size:
  7.0pt;font-family:"Times New Roman";mso-ansi-language:IT;mso-bidi-font-weight:
  bold'><%=dt_total.Rows[i][15].ToString() %> – <%=dt_total.Rows[i][16].ToString() %><o:p></o:p></span></p>
  </td>
  <td width="10%" valign=top style='width:10.92%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><span lang=IT style='font-size:
  7.0pt;font-family:"Times New Roman";mso-ansi-language:IT;mso-bidi-font-weight:
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
 
</table>



<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><u><span
lang=PT-BR style='font-size:11.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'>B. THÂN NHÂN:<o:p></o:p></span></u></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><u><span
lang=PT-BR style='font-size:6.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><o:p><span style='text-decoration:none'>&nbsp;</span></o:p></span></u></b></p>

<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-yfti-tbllook:480;mso-padding-alt:0in 5.4pt 0in 5.4pt;mso-border-insideh:
 .5pt solid windowtext;mso-border-insidev:.5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes'>
  <td width=56 style='width:41.85pt;border:solid windowtext 1.0pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
  margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:7.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR'>Số TT<o:p></o:p></span></p>
  </td>
  <td width=160 style='width:119.85pt;border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
  margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:7.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR'>Họ và tên<o:p></o:p></span></p>
  </td>
  <td width=99 style='width:74.45pt;border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
  margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><span
  class=SpellE><span style='font-size:7.0pt;font-family:"Times New Roman";
  mso-ansi-language:EN-US'>Ngày</span></span><span style='font-size:7.0pt;
  font-family:"Times New Roman";mso-ansi-language:EN-US'>, <span class=SpellE>tháng</span>,
  <span class=SpellE>năm</span> <span class=SpellE>sinh</span><o:p></o:p></span></p>
  </td>
  <td width=69 style='width:51.95pt;border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
  margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:7.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR'>Quan hệ<o:p></o:p></span></p>
  </td>
  <td width=92 style='width:68.65pt;border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
  margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:7.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR'>Nghề nghiệp<o:p></o:p></span></p>
  </td>
  <td width=76 style='width:56.9pt;border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
  margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:7.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR'>Thu nhập<o:p></o:p></span></p>
  </td>
  <td width=169 style='width:127.05pt;border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
  margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:7.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR'>Nơi cư trú<o:p></o:p></span></p>
  </td>
 
 <tr style='mso-yfti-irow:2'>
  <td width=56 valign=top style='width:41.85pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  6.0pt;margin-left:10.9pt;text-align:justify'><span lang=PT-BR
  style='font-size:10.0pt;font-family:"Times New Roman";mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=160 valign=top style='width:119.85pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  6.0pt;margin-left:10.9pt;text-align:justify'><span lang=PT-BR
  style='font-size:10.0pt;font-family:"Times New Roman";mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=99 valign=top style='width:74.45pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  6.0pt;margin-left:10.9pt;text-align:justify'><span lang=PT-BR
  style='font-size:10.0pt;font-family:"Times New Roman";mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=69 valign=top style='width:51.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  6.0pt;margin-left:10.9pt;text-align:justify'><span lang=PT-BR
  style='font-size:10.0pt;font-family:"Times New Roman";mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=92 valign=top style='width:68.65pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  6.0pt;margin-left:10.9pt;text-align:justify'><span lang=PT-BR
  style='font-size:10.0pt;font-family:"Times New Roman";mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=76 valign=top style='width:56.9pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  6.0pt;margin-left:10.9pt;text-align:justify'><span lang=PT-BR
  style='font-size:10.0pt;font-family:"Times New Roman";mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=169 valign=top style='width:127.05pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  6.0pt;margin-left:10.9pt;text-align:justify'><span lang=PT-BR
  style='font-size:10.0pt;font-family:"Times New Roman";mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
  
 
 </table>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><i><u><span
lang=PT-BR style='mso-bidi-font-size:11.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'>Cam kết</span></u></i><span lang=PT-BR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'>: Những nội dung kê khai trên là hoàn toàn đúng sự thực, nếu sai tôi xin
hoàn toàn chịu trách nhiệm trước pháp luật.<o:p></o:p></span></p>

<p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><i><span
lang=PT-BR style='mso-bidi-font-size:11.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'><%=dt_total.Rows[i][21].ToString() %>, ngày 01 <span style='mso-spacerun:yes'> 
</span>tháng <%if (dt_total.Rows[i][14].ToString()!="") 
                                        Response.Write(dt_total.Rows[i][14].ToString().Substring(0,2));
                                    %>  năm <%if (dt_total.Rows[i][14].ToString()!="") 
                                        Response.Write(dt_total.Rows[i][14].ToString().Substring(3,4));
                                    %><o:p></o:p></span></i></p>

<p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><b><span
lang=PT-BR style='mso-bidi-font-size:11.0pt;font-family:"Times New Roman";
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
lang=PT-BR style='font-size:11.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><%=dt_total.Rows[i][20].ToString() %><o:p></o:p></span></b></p>



<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><u><span
lang=PT-BR style='font-size:11.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'>C. XÁC NHẬN CỦA NGƯỜI SỬ DỤNG LAO ĐỘNG:<o:p></o:p></span></u></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=PT-BR
style='mso-bidi-font-size:11.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'>Cơ quan, đơn vị, tổ chức <%=dt_total.Rows[i][16].ToString() %> sau khi kiểm tra, đối chiếu hồ sơ gốc của
Ông (Bà) <%=dt_total.Rows[i][20].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=PT-BR
style='mso-bidi-font-size:11.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'>Xác nhận các nội dung kê khai trên là hoàn toàn đúng sự thực.<o:p></o:p></span></p>

<p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><span
class=SpellE><span class=GramE><i><span style='mso-bidi-font-size:110pt;
font-family:"Times New Roman";mso-ansi-language:EN-US'><%=dt_total.Rows[i][21].ToString() %></span></i></span></span><i><span
style='mso-bidi-font-size:11.0pt;font-family:"Times New Roman";mso-ansi-language:
EN-US'>, <span class=SpellE>ngày</span> 01 <span style='mso-spacerun:yes'> 
</span><span class=SpellE>tháng</span> <%if (dt_total.Rows[i][14].ToString()!="") 
                                        Response.Write(dt_total.Rows[i][14].ToString().Substring(0,2));
                                    %><span style='mso-spacerun:yes'> 
</span><span class=SpellE>năm</span> <%if (dt_total.Rows[i][14].ToString()!="") 
                                        Response.Write(dt_total.Rows[i][14].ToString().Substring(3,4));
                                    %><o:p></o:p></span></i></p>

<p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><span
class=SpellE><b><span style='mso-bidi-font-size:11.0pt;font-family:"Times New Roman";
mso-ansi-language:EN-US'>Người</span></b></span><b><span style='mso-bidi-font-size:
11.0pt;font-family:"Times New Roman";mso-ansi-language:EN-US'> <span
class=SpellE>sử</span> <span class=SpellE>dụng</span> <span class=SpellE><span
class=GramE>lao</span></span> <span class=SpellE>động</span><o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><span
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
EN-US'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><span
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
EN-US'><o:p>&nbsp;</o:p></span></b></p>





<p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><b><span
style='font-size:11.0pt;font-family:"Times New Roman";mso-ansi-language:EN-US'>
<%if (irow_name>0)
     Response.Write(dt_name.Rows[0][0].ToString()); %><o:p></o:p></span></b></p>



<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><u><span
lang=PT-BR style='font-size:11.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'>D. XÁC NHẬN CỦA CƠ QUAN BẢO HIỂM XÃ HỘI:<o:p></o:p></span></u></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify;text-indent:27.25pt'><span
lang=PT-BR style='mso-bidi-font-size:11.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'>Bảo hiểm xã hội tỉnh <%=dt_total.Rows[i][21].ToString() %> sau khi kiểm tra, đối
chiếu với hồ sơ gốc của cá nhân Ông (Bà) <%=dt_total.Rows[i][20].ToString() %> xác nhận các nội dung kê
khai trên là đúng.<o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;tab-stops:70.85pt 261.6pt'><b><span
lang=PT-BR style='mso-bidi-font-size:11.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'><span style='mso-tab-count:1'>                </span>Cán
bộ thẩm định<span style='mso-tab-count:1'>                      </span></span></b><i><span
lang=PT-BR style='mso-bidi-font-size:11.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'>............, ngày ....... tháng ....... năm 20.....<o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;tab-stops:70.85pt 332.45pt'><b><span
lang=PT-BR style='mso-bidi-font-size:11.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'><span style='mso-tab-count:2'>                                                                                      </span>Giám
đốc BHXH</span></b><i><span lang=PT-BR style='mso-bidi-font-size:14.0pt;
font-family:"Times New Roman";mso-ansi-language:PT-BR'><o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=PT-BR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><i><u><span
lang=PT-BR style='font-size:9.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><o:p><span style='text-decoration:none'>&nbsp;</span></o:p></span></u></i></p>

<p class=MsoNormal style='margin-right:5.6pt;text-align:justify'><span
lang=PT-BR style='mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></p>



<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:46.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=PT-BR
style='mso-bidi-font-size:11.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><span style='mso-spacerun:yes'>     </span><%if (irow_name>0)
     Response.Write(dt_name.Rows[0][1].ToString()); %><o:p></o:p></span></p>
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
<%} %>
</div>

</body>

</html>
