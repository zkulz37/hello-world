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
xmlns="http://www.w3.org/TR/REC-html40"
xmlns:ns0="urn:schemas-microsoft-com:office:smarttags">
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
        + ",(select v.code_fnm from vhr_hr_code v where v.id='HR0021' and v.code=a.native_country) as nguyenquan6 "
        + ",a.PERMANENT_ADDR as noicutru7 "
        + ",a.PERSON_ID  as personid8 "
        + ",(select v.code_fnm from vhr_hr_code v where v.id='HR0014' and v.code=a.PLACE_PER_ID) as noicap9 "
        + ",to_char(to_date(a.ISSUE_DT,'yyyymmdd'),'dd/mm/yyyy') as issued_dt10 "
        + ",a.HEALTH_NO as c11 "
        + ",(select v.code_fnm from vhr_hr_code v where v.id='HR0012' and v.code=a.HEALTH_PLACE) as c12  "
        + ",to_char(to_date(a.BEGIN_CONTRACT,'yyyymmdd'),'mm/yyyy') as tuthang13  "
        + ",to_char(to_date(a.BEGIN_CONTRACT,'yyyymmdd'),'mm/yyyy') as denthang14 "
        + ",(select v.code_fnm from vhr_hr_code v where v.id='HR0008' and v.code=a.POS_TYPE) as pos_type15 "
        + ",(select PARTNER_LNAME from tco_company p where p.del_if=0 and p.pk=c.tco_company_pk) as tencongty16 "
        + ",(select p.ADDR1 from tco_company p where p.del_if=0 and p.pk=c.tco_company_pk) as diachi17 "
        + ",(Select TO_CHAR(s.salary_level2,'999,999,999') from THR_SALARY_MANAGE s where s.del_if=0 and s.thr_emp_pk=a.pk and s.work_mon=substr(a.BEGIN_CONTRACT,1,6)) as salary18  "
        + ",a.contract_no as sohopdong19 "
        + ",to_char(to_date(a.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') as kyngay20 "
        + ",(select lower(v.code_fnm) from vhr_hr_code v where v.id='HR0001' and v.code=a.contract_type)  as loaihopdong21 "
        + ",(select v.code_fnm from vhr_hr_code v where v.id='HR0049' and v.code='11') as noicongtac22 "
         + ",a.full_name as hoten23, nvl(a.social_no,'          ') socialno24, a.pk emp_pk25  "
        + "from thr_employee a,thr_group b,tco_dept c "
        + "where a.del_if=0 and b.del_if=0 and c.del_if=0 and a.thr_group_pk=b.pk and a.tco_dept_pk=c.pk "
       + "and a.pk in (" + emp_pk + ") " ;
        
//Response.Write(SQL);
//Response.End();
    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    int num_row;
    num_row = dt_total.Rows.Count;
    if (num_row == 0)
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
<link rel=File-List href="rpt_01_TBH_BK%5b2%5d.doc123_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_01_TBH_BK%5b2%5d.doc123_files/editdata.mso">
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
  <o:LastAuthor>tuyen</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>22</o:TotalTime>
  <o:LastPrinted>2008-10-14T08:11:00Z</o:LastPrinted>
  <o:Created>2009-07-17T10:27:00Z</o:Created>
  <o:LastSaved>2009-07-17T10:27:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>328</o:Words>
  <o:Characters>1870</o:Characters>
  <o:Company> BHXH Viet Nam</o:Company>
  <o:Lines>15</o:Lines>
  <o:Paragraphs>4</o:Paragraphs>
  <o:CharactersWithSpaces>2194</o:CharactersWithSpaces>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Print</w:View>
  <w:Zoom>105</w:Zoom>
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
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;
	mso-font-charset:2;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:0 268435456 0 0 -2147483648 0;}
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
 <o:shapedefaults v:ext="edit" spidmax="7170" fillcolor="white">
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
     
     for (int i = 0; i < num_row; i++) 
    {
       
    %> 
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
lang=PT-BR style='font-size:10.0pt;mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal align=center style='margin-left:334.5pt;text-align:center'><b><span
lang=VI style='font-size:10.0pt'>M</span></b><b><span lang=VI style='font-size:
10.0pt;font-family:Arial'>ẫ</span></b><b><span lang=VI style='font-size:10.0pt'>u
s</span></b><b><span lang=VI style='font-size:10.0pt;font-family:Arial'>ố</span></b><b><span
lang=VI style='font-size:10.0pt'>: 01-TBH</span></b><b><span lang=PT-BR
style='font-size:10.0pt;mso-ansi-language:PT-BR'><o:p></o:p></span></b></p>

<p class=MsoNormal align=center style='margin-left:334.5pt;text-align:center'><i
style='mso-bidi-font-style:normal'><span lang=PT-BR style='font-size:10.0pt;
mso-ansi-language:PT-BR;mso-bidi-font-weight:bold'>(Ban <span class=spelle><span
style='font-family:"\.VnTime"'>h</span></span></span></i><span class=spelle><i
style='mso-bidi-font-style:normal'><span lang=PT-BR style='font-size:10.0pt;
font-family:Arial;mso-ansi-language:PT-BR;mso-bidi-font-weight:bold'>à</span></i></span><span
class=spelle><i style='mso-bidi-font-style:normal'><span lang=PT-BR
style='font-size:10.0pt;font-family:"\.VnTime";mso-bidi-font-family:"\.VnTime";
mso-ansi-language:PT-BR;mso-bidi-font-weight:bold'>nh</span></i></span><i
style='mso-bidi-font-style:normal'><span lang=PT-BR style='font-size:10.0pt;
mso-bidi-font-family:"\.VnTime";mso-ansi-language:PT-BR;mso-bidi-font-weight:
bold'> kèm theoQ</span></i><i style='mso-bidi-font-style:normal'><span
lang=PT-BR style='font-size:10.0pt;font-family:Arial;mso-ansi-language:PT-BR;
mso-bidi-font-weight:bold'>Đ</span></i><i style='mso-bidi-font-style:normal'><span
lang=PT-BR style='font-size:10.0pt;mso-ansi-language:PT-BR;mso-bidi-font-weight:
bold'>s</span></i><i style='mso-bidi-font-style:normal'><span lang=PT-BR
style='font-size:10.0pt;font-family:Arial;mso-ansi-language:PT-BR;mso-bidi-font-weight:
bold'>ố</span></i><i style='mso-bidi-font-style:normal'><span lang=PT-BR
style='font-size:10.0pt;mso-bidi-font-family:"\.VnTime";mso-ansi-language:PT-BR;
mso-bidi-font-weight:bold'>1333/Q</span></i><i style='mso-bidi-font-style:normal'><span
lang=PT-BR style='font-size:10.0pt;font-family:Arial;mso-ansi-language:PT-BR;
mso-bidi-font-weight:bold'>Đ</span></i><i style='mso-bidi-font-style:normal'><span
lang=PT-BR style='font-size:10.0pt;mso-ansi-language:PT-BR;mso-bidi-font-weight:
bold'>-<o:p></o:p></span></i></p>

<p class=MsoNormal align=center style='margin-left:334.5pt;text-align:center'><i
style='mso-bidi-font-style:normal'><span lang=PT-BR style='font-size:10.0pt;
mso-ansi-language:PT-BR;mso-bidi-font-weight:bold'>BHXH <span class=spelle><span
style='font-family:"\.VnTime"'>ng</span></span></span></i><span class=spelle><i
style='mso-bidi-font-style:normal'><span lang=PT-BR style='font-size:10.0pt;
font-family:Arial;mso-ansi-language:PT-BR;mso-bidi-font-weight:bold'>à</span></i></span><span
class=spelle><i style='mso-bidi-font-style:normal'><span lang=PT-BR
style='font-size:10.0pt;font-family:"\.VnTime";mso-bidi-font-family:"\.VnTime";
mso-ansi-language:PT-BR;mso-bidi-font-weight:bold'>y</span></i></span><i
style='mso-bidi-font-style:normal'><span lang=PT-BR style='font-size:10.0pt;
mso-bidi-font-family:"\.VnTime";mso-ansi-language:PT-BR;mso-bidi-font-weight:
bold'> 21/01/2008 <span class=spelle><span style='font-family:"\.VnTime";
mso-bidi-font-family:"\.VnTime"'>c</span></span></span></i><span class=spelle><i
style='mso-bidi-font-style:normal'><span lang=PT-BR style='font-size:10.0pt;
font-family:Arial;mso-ansi-language:PT-BR;mso-bidi-font-weight:bold'>ủ</span></i></span><span
class=spelle><i style='mso-bidi-font-style:normal'><span lang=PT-BR
style='font-size:10.0pt;font-family:"\.VnTime";mso-bidi-font-family:"\.VnTime";
mso-ansi-language:PT-BR;mso-bidi-font-weight:bold'>a</span></i></span><i
style='mso-bidi-font-style:normal'><span lang=PT-BR style='font-size:10.0pt;
mso-bidi-font-family:"\.VnTime";mso-ansi-language:PT-BR;mso-bidi-font-weight:
bold'> BHXH VN)</span></i><i style='mso-bidi-font-style:normal'><span
lang=PT-BR style='font-size:10.0pt;mso-ansi-language:PT-BR;mso-bidi-font-weight:
bold'><o:p></o:p></span></i></p>

</div>

<p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><b><span
lang=VI style='font-size:16.0pt;font-family:"Times New Roman"'>TỜ KHAI</span></b><b><span
lang=PT-BR style='font-size:13.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><o:p></o:p></span></b></p>

<p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><b><span
lang=VI style='font-size:13.0pt;font-family:"Times New Roman"'>THAM GIA BẢO HIỂM
XÃ HỘI, BẢO HIỂM Y TẾ BẮT BUỘC<o:p></o:p></span></b></p>

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
    <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][24].ToString().Substring(9,1)%><o:p></o:p></span></p>
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
    <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][24].ToString().Substring(8,1)%><o:p></o:p></span></p>
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
    <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][24].ToString().Substring(7,1)%><o:p></o:p></span></p>
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
    <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][24].ToString().Substring(6,1)%><o:p></o:p></span></p>
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
    <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][24].ToString().Substring(5,1)%><o:p></o:p></span></p>
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
    <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][24].ToString().Substring(4,1)%><o:p></o:p></span></p>
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
    <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][24].ToString().Substring(3,1)%><o:p></o:p></span></p>
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
    <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][24].ToString().Substring(2,1)%><o:p></o:p></span></p>
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
    <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][24].ToString().Substring(1,1)%><o:p></o:p></span></p>
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
    <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][24].ToString().Substring(0,1)%><o:p></o:p></span></p>
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
</span></b><b><u>
<span style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
EN-US'>Số sổ</span></u></b><b><span style='mso-bidi-font-size:14.0pt;
font-family:"Times New Roman";mso-ansi-language:EN-US'>:<o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt'><span lang=VI style='mso-bidi-font-size:
14.0pt;font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><u><span
lang=VI style='font-size:12.0pt;font-family:"Times New Roman"'>A. NGƯỜI LAO
ĐỘNG:<o:p></o:p></span></u></b></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify;tab-stops:386.95pt'><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'>1. Họ và tên:<%= dt_total.Rows[i][0].ToString() %><span
style='mso-tab-count:1'>                        </span>Nam<span
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
mso-ansi-language:PT-BR'>2. Ngày tháng năm sinh: <%=dt_total.Rows[i][3].ToString() %><span style='mso-tab-count:
1'>                </span>Dân tộc: <%=dt_total.Rows[i][4].ToString() %> <span style='mso-tab-count:1'>             </span>Quốc
tịch: <%=dt_total.Rows[i][5].ToString() %><o:p></o:p></span></p>

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
lang=SV style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:SV'>5. Giấy CMND số: <%=dt_total.Rows[i][8].ToString() %><span style='mso-tab-count:
1'>               </span>Nơi cấp: <%=dt_total.Rows[i][9].ToString() %><span style='mso-tab-count:1'>    </span>Ngày
cấp: <%=dt_total.Rows[i][10].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=FR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
FR'>6. Hợp đồng lao động (hoặc hợp đồng làm việc): Số <%=dt_total.Rows[i][19].ToString() %> có hiệu lực từ
ngày <%=dt_total.Rows[i][20].ToString().Substring(0,2).ToString() %> tháng <%=dt_total.Rows[i][20].ToString().Substring(3,2).ToString() %> năm <%=dt_total.Rows[i][20].ToString().Substring(6,4).ToString() %>.<o:p></o:p></span></p>

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
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><span
lang=IT style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:IT'>12. Quá trình đóng, chưa hưởng BHXH một lần và BH thất
nghiệp<o:p></o:p></span></b></p>

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
  PT-BR'>Cấp bậc, chức vụ, chức danh nghề, công việc, nơi làm việc (tên cơ quan,
  đơn vị, địa chỉ)</span><b><span lang=IT style='mso-bidi-font-size:14.0pt;
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
  bold'>07/2009<o:p></o:p></span></p>
  </td>
  <td width="10%" valign=top style='width:10.9%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><span lang=IT style='font-size:
  10.0pt;font-family:"Times New Roman";mso-ansi-language:IT;mso-bidi-font-weight:
  bold'>07/2009</span><b><span lang=IT style='mso-bidi-font-size:14.0pt;
  font-family:"Times New Roman";mso-ansi-language:IT'><o:p></o:p></span></b></p>
  </td>
  <td width="27%" valign=top style='width:27.68%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><span lang=IT style='font-size:
  10.0pt;font-family:"Times New Roman";mso-ansi-language:IT;mso-bidi-font-weight:
  bold'>Công nhân – CÔNG TY TNHH BK VINA<o:p></o:p></span></p>
  </td>
  <td width="10%" valign=top style='width:10.92%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><span lang=IT style='font-size:
  10.0pt;font-family:"Times New Roman";mso-ansi-language:IT;mso-bidi-font-weight:
  bold'>1,156,000<o:p></o:p></span></p>
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
  bold'><o:p>&nbsp;</o:p></span></p>
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
  bold'><o:p>&nbsp;</o:p></span></p>
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
 <tr style='mso-yfti-irow:8'>
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
 <tr style='mso-yfti-irow:9;mso-yfti-lastrow:yes'>
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
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b
style='mso-bidi-font-weight:normal'><span lang=PT-BR style='mso-bidi-font-size:
14.0pt;font-family:"Times New Roman";mso-ansi-language:PT-BR;mso-bidi-font-style:
italic'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b
style='mso-bidi-font-weight:normal'><span lang=PT-BR style='mso-bidi-font-size:
14.0pt;font-family:"Times New Roman";mso-ansi-language:PT-BR;mso-bidi-font-style:
italic'><o:p>&nbsp;</o:p></span></b></p>

<b><span lang=PT-BR style='font-size:12.0pt;font-family:"Times New Roman";
mso-fareast-font-family:"Times New Roman";mso-ansi-language:PT-BR;mso-fareast-language:
VI;mso-bidi-language:AR-SA'><br clear=all style='page-break-before:always'>
</span></b>

    <% 
        string strEmp_PK=dt_total.Rows[i][25].ToString();
        //family for detail employee
        SQL = " select a.FULL_NAME , a.BIRTH_DT, e.code_nm,a.job,TO_CHAR(a.salary,'999,999,999'), a.REMARK  ";
        SQL = SQL + " from THR_FAMILY a, vhr_hr_code e  ";
        SQL = SQL + " where a.del_if=0 and e.id='HR0024' ";
        SQL = SQL + " and a.relation = e.code";
        SQL = SQL + " and a.THR_EMPLOYEE_PK=" + strEmp_PK;
        SQL = SQL + " order by a.pk  ";

        DataTable dt_family = ESysLib.TableReadOpen(SQL);
        int irow_f;
        irow_f = dt_family.Rows.Count;
        
    
    %> 
    
<p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b
style='mso-bidi-font-weight:normal'><span lang=PT-BR style='mso-bidi-font-size:
14.0pt;font-family:"Times New Roman";mso-ansi-language:PT-BR;mso-bidi-font-style:
italic'>B. <u>Thân nhân:<o:p></o:p></u></span></b></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b
style='mso-bidi-font-weight:normal'><u><span lang=PT-BR style='mso-bidi-font-size:
14.0pt;font-family:"Times New Roman";mso-ansi-language:PT-BR;mso-bidi-font-style:
italic'><o:p><span style='text-decoration:none'>&nbsp;</span></o:p></span></u></b></p>

<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-yfti-tbllook:480;mso-padding-alt:0in 5.4pt 0in 5.4pt;mso-border-insideh:
 .5pt solid windowtext;mso-border-insidev:.5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:31.0pt'>
  <td width=57 valign=top style='width:42.85pt;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:31.0pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR;mso-bidi-font-style:italic'>Số TT<o:p></o:p></span></p>
  </td>
  <td width=174 valign=top style='width:130.8pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:31.0pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR;mso-bidi-font-style:italic'>Họ và tên<o:p></o:p></span></p>
  </td>
  <td width=116 valign=top style='width:87.2pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:31.0pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR;mso-bidi-font-style:italic'>Ngày tháng năm sinh<o:p></o:p></span></p>
  </td>
  <td width=94 valign=top style='width:70.85pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:31.0pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR;mso-bidi-font-style:italic'>Quan hệ<o:p></o:p></span></p>
  </td>
  <td width=102 valign=top style='width:76.3pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:31.0pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR;mso-bidi-font-style:italic'>Nghề nghiệp<o:p></o:p></span></p>
  </td>
  <td width=109 valign=top style='width:81.75pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:31.0pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR;mso-bidi-font-style:italic'>Thu nhập<o:p></o:p></span></p>
  </td>
  <td width=182 valign=top style='width:136.25pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:31.0pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
  margin-bottom:0in;margin-left:0in;margin-bottom:.0001pt;text-align:center'><span
  lang=PT-BR style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:
  PT-BR;mso-bidi-font-style:italic'>Nơi cư trú<o:p></o:p></span></p>
  </td>
 </tr>
 <%
    for (int j = 0; j < irow_f; j++) 
    {
      %>
 <tr style='mso-yfti-irow:1'>
  <td width=57 valign=top style='width:42.85pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify'><span
  lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
  mso-ansi-language:PT-BR;mso-bidi-font-style:italic'><o:p><%=j+1 %></o:p></span></p>
  </td>
  <td width=174 valign=top style='width:130.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify'><span
  lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
  mso-ansi-language:PT-BR;mso-bidi-font-style:italic'><o:p><%=dt_family.Rows[j][0].ToString() %></o:p></span></p>
  </td>
  <td width=116 valign=top style='width:87.2pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify'><span
  lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
  mso-ansi-language:PT-BR;mso-bidi-font-style:italic'><o:p><%=dt_family.Rows[j][1].ToString() %></o:p></span></p>
  </td>
  <td width=94 valign=top style='width:70.85pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify'><span
  lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
  mso-ansi-language:PT-BR;mso-bidi-font-style:italic'><o:p><%=dt_family.Rows[j][2].ToString() %></o:p></span></p>
  </td>
  <td width=102 valign=top style='width:76.3pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify'><span
  lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
  mso-ansi-language:PT-BR;mso-bidi-font-style:italic'><o:p><%=dt_family.Rows[j][3].ToString() %></o:p></span></p>
  </td>
  <td width=109 valign=top style='width:81.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify'><span
  lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
  mso-ansi-language:PT-BR;mso-bidi-font-style:italic'><o:p><%=dt_family.Rows[j][4].ToString() %></o:p></span></p>
  </td>
  <td width=182 valign=top style='width:136.25pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify'><span
  lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
  mso-ansi-language:PT-BR;mso-bidi-font-style:italic'><o:p><%=dt_family.Rows[j][5].ToString() %></o:p></span></p>
  </td>
 </tr>
 <%
    } %>
  <% 
    for (int j = 1; j <= 6-irow_f; j++) 
    {
     %>
 <tr style='mso-yfti-irow:2'>
  <td width=57 valign=top style='width:42.85pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify'><span
  lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
  mso-ansi-language:PT-BR;mso-bidi-font-style:italic'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=174 valign=top style='width:130.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify'><span
  lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
  mso-ansi-language:PT-BR;mso-bidi-font-style:italic'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=116 valign=top style='width:87.2pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify'><span
  lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
  mso-ansi-language:PT-BR;mso-bidi-font-style:italic'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=94 valign=top style='width:70.85pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify'><span
  lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
  mso-ansi-language:PT-BR;mso-bidi-font-style:italic'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=102 valign=top style='width:76.3pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify'><span
  lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
  mso-ansi-language:PT-BR;mso-bidi-font-style:italic'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=109 valign=top style='width:81.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify'><span
  lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
  mso-ansi-language:PT-BR;mso-bidi-font-style:italic'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=182 valign=top style='width:136.25pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify'><span
  lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
  mso-ansi-language:PT-BR;mso-bidi-font-style:italic'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <% }
  %>
</table>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify'><i><u><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'>Cam kết</span></u></i><span lang=PT-BR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'>: Những nội dung kê khai trên là hoàn toàn đúng sự thực, nếu sai tôi xin
hoàn toàn chịu trách nhiệm trước pháp luật.<o:p></o:p></span></p>

<p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><i><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'><%=dt_total.Rows[i][22].ToString() %>, ngày 01<span style='mso-spacerun:yes'>  
</span>tháng <%if (dt_total.Rows[i][14].ToString()!="") 
                                        Response.Write(dt_total.Rows[i][14].ToString().Substring(0,2));
                                    %>  năm <%if (dt_total.Rows[i][14].ToString()!="") 
                                        Response.Write(dt_total.Rows[i][14].ToString().Substring(3,4));
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

<p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><b><span
lang=PT-BR style='font-size:15.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt'><b><u><span lang=PT-BR
style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:PT-BR'>C.
XÁC NHẬN CỦA NGƯỜI SỬ DỤNG LAO ĐỘNG:<o:p></o:p></span></u></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=PT-BR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'>Cơ quan, đơn vị, tổ chức <%=dt_total.Rows[i][16].ToString() %> sau khi kiểm tra, đối
chiếu hồ sơ gốc của Ông (Bà) <%=dt_total.Rows[i][23].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=PT-BR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'>Xác nhận các nội dung kê khai trên là hoàn toàn đúng sự thực.<o:p></o:p></span></p>

<p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><span
class=spelle><i><span lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:
"\.VnTime";mso-ansi-language:PT-BR'><%=dt_total.Rows[i][22].ToString() %></span></i></span><i><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'>, <span class=spelle>ngày</span> 01<span
style='mso-spacerun:yes'>   </span><span class=spelle>tháng</span> <%if (dt_total.Rows[i][14].ToString()!="") 
                                        Response.Write(dt_total.Rows[i][14].ToString().Substring(0,2));
                                    %><span
style='mso-spacerun:yes'>  </span><span class=spelle>năm</span><%if (dt_total.Rows[i][14].ToString()!="") 
                                        Response.Write(dt_total.Rows[i][14].ToString().Substring(3,4));
                                    %><o:p></o:p></span></i></p>

<p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><span
class=spelle><b><span style='mso-bidi-font-size:14.0pt;font-family:"\.VnTime";
mso-ansi-language:EN-US'>Ng</span></b></span><span class=spelle><b><span
style='mso-bidi-font-size:14.0pt;font-family:Arial;mso-ansi-language:EN-US'>ườ</span></b></span><span
class=spelle><b><span style='mso-bidi-font-size:14.0pt;font-family:"\.VnTime";
mso-bidi-font-family:"\.VnTime";mso-ansi-language:EN-US'>i</span></b></span><b><span
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
EN-US'> <span class=spelle>sử</span> <span class=spelle>dụng</span> <span
class=GramE><span class=spelle>lao</span></span> <span class=spelle>động</span><o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><span
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
EN-US'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><span
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
EN-US'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><span
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
EN-US'><o:p>&nbsp;</o:p></span></b></p>

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
style='font-size:15.0pt;font-family:"Times New Roman";mso-ansi-language:EN-US'><%if (irow_name>0)
     Response.Write(dt_name.Rows[0][0].ToString()); %><o:p></o:p></span></b></p>

<p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><b><span
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
EN-US'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><u><span
lang=PT-BR style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'>D. XÁC NHẬN CỦA CƠ QUAN BẢO HIỂM XÃ HỘI:<o:p></o:p></span></u></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify;text-indent:27.25pt'><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'>Bảo hiểm xã hội tỉnh <%=dt_total.Rows[i][22].ToString() %> sau khi kiểm tra, đối chiếu
với hồ sơ gốc của cá nhân Ông (Bà) <%=dt_total.Rows[i][23].ToString() %> xác nhận các nội dung kê
khai trên là đúng.<o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;tab-stops:70.85pt 261.6pt'><b><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'><span style='mso-tab-count:1'>                </span>Cán
bộ thẩm định<span style='mso-tab-count:1'>                     </span></span></b><i><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'>............, ngày ....... tháng ....... năm 20.....<o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;tab-stops:70.85pt 332.45pt'><b><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
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
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><span style='mso-spacerun:yes'>     </span><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:46.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=PT-BR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><span style='mso-spacerun:yes'>     </span><%if (irow_name>0)
     Response.Write(dt_name.Rows[0][1].ToString()); %><o:p></o:p></span></p>
<%  if (i==num_row-1) 
    {%>
<p class=MsoNormal style='margin-right:5.6pt;text-align:justify'><span
lang=PT-BR style='mso-ansi-language:PT-BR;mso-special-character:line-break;
page-break-before:always'><o:p>&nbsp;</o:p></span></p>
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
