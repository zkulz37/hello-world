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
xmlns:ns0="http://schemas.microsoft.com/office/2004/12/omml"
xmlns:ns1="urn:schemas-microsoft-com:office:smarttags">
<%
    string emp_pk,rpt_type;
    
    emp_pk       = Request["emp_pk"].ToString();
    rpt_type = Request["rpt_type"].ToString();
    string SQL
    = "SELECT a.FULL_NAME AS full_nm_0, " + 
        "       a.emp_id AS emp_id_1, " +
        "       DECODE (NVL (a.sex, 0), 'M', 'X', 0) AS Male_2, " +
        "       DECODE (NVL (a.sex, 0), 'F', 'X', 0) AS Female_3, " +
        "       (CASE " +
        "           WHEN LENGTH (a.BIRTH_DT) = 4 THEN a.birth_dt " +
        "           ELSE TO_CHAR (TO_DATE (a.birth_dt, 'yyyymmdd'), 'dd/mm/yyyy') " +
        "        END) AS birth_dt_4, " +
        "       (SELECT v.code_fnm " +
        "          FROM vhr_hr_code v " +
        "         WHERE v.id = 'HR0015' AND v.code = a.ETHNIC_TYPE) " +
        "          AS ETHNIC_5, " +
        "       (SELECT v.code_fnm " +
        "          FROM vhr_hr_code v " +
        "         WHERE v.id = 'HR0009' AND v.code = a.NATION) " +
        "          AS nation_6, " +
        "       (SELECT v.code_fnm " +
        "          FROM vhr_hr_code v " +
        "         WHERE v.id = 'HR0021' AND v.code = a.native_country) " +
        "          AS nguyenquan_7, " +
        "       a.PERMANENT_ADDR AS noicutru_8, " +
        "       a.PERSON_ID AS personid_9, " +
        "       (SELECT v.code_fnm " +
        "          FROM vhr_hr_code v " +
        "         WHERE v.id = 'HR0014' AND v.code = a.PLACE_PER_ID) " +
        "          AS noicap_10, " +
        "       TO_CHAR (TO_DATE (a.ISSUE_DT, 'yyyymmdd'), 'dd/mm/yyyy') " +
        "          AS issued_dt_11, " +
        "       a.contract_no AS sohopdong_12, " +
        "       TO_CHAR (TO_DATE (a.BEGIN_CONTRACT, 'yyyymmdd'), 'dd/mm/yyyy') " +
        "          AS kyngay_13, " +
        "       (SELECT UPPER (v.code_fnm) " +
        "          FROM vhr_hr_code v " +
        "         WHERE v.id = 'HR0001' AND v.code = a.contract_type) " +
        "          AS loaihopdong_14, " +
        "       (SELECT v.code_fnm " +
        "          FROM vhr_hr_code v " +
        "         WHERE v.id = 'HR0008' AND v.code = a.POS_TYPE) " +
        "          AS pos_type_15, " +
        "       (SELECT PARTNER_LNAME " +
        "          FROM tco_company p " +
        "         WHERE p.del_if = 0 AND p.pk = c.tco_company_pk) " +
        "          AS tencongty_16, " +
        "       (SELECT p.ADDR2 " +
        "          FROM tco_company p " +
        "         WHERE p.del_if = 0 AND p.pk = c.tco_company_pk) " +
        "          AS diachi_17, " +
        "       (SELECT v.code_nm " +
        "          FROM vhr_hr_code v " +
        "         WHERE v.id = 'HR0012' AND v.code = a.HEALTH_PLACE) " +
        "          AS c_18, " +
        "       a.HEALTH_NO AS c_19, " +
        "       (CASE WHEN SUBSTR (BEGIN_CONTRACT, -2) > '15' " +
        "           THEN TO_CHAR (ADD_MONTHS (TO_DATE (a.BEGIN_CONTRACT, 'yyyymmdd'), 1),'mm/yyyy') " +
        "           ELSE TO_CHAR (TO_DATE (a.BEGIN_CONTRACT, 'yyyymmdd'), 'mm/yyyy') " +
        "        END) AS tuthang_20, " +
        "       (CASE WHEN SUBSTR (BEGIN_CONTRACT, -2) > '15' " +
        "           THEN TO_CHAR ( ADD_MONTHS (TO_DATE (a.BEGIN_CONTRACT, 'yyyymmdd'), 1),'mm/yyyy') " +
        "           ELSE TO_CHAR (TO_DATE (a.BEGIN_CONTRACT, 'yyyymmdd'), 'mm/yyyy') " +
        "        END) AS denthang_21, " +
        "       (SELECT TO_CHAR (s.salary_level2, '999,999,999') " +
        "          FROM THR_SALARY_MANAGE s " +
        "         WHERE s.del_if = 0 AND s.thr_emp_pk = a.pk " +
        "               AND s.work_mon = " +
        "                      (CASE WHEN SUBSTR (BEGIN_CONTRACT, -2) > '15' " +
        "                          THEN TO_CHAR (ADD_MONTHS (TO_DATE (a.BEGIN_CONTRACT, 'yyyymmdd'),1),'yyyymm') " +
        "                          ELSE TO_CHAR (TO_DATE (a.BEGIN_CONTRACT, 'yyyymmdd'), 'yyyymm') " +
        "                       END)) " +
        "          AS salary_22, " +
        "       (SELECT v.code_fnm " +
        "          FROM vhr_hr_code v " +
        "         WHERE v.id = 'HR0049' AND v.code = '11') " +
        "          AS noicongtac_23, " +
        "       a.full_name AS hoten_24, " +
        "       RPAD (NVL (a.social_no, '          '), 10, ' ') socialno_25, " +
        "       a.pk emp_pk_26 " +
        "  FROM thr_employee a, comm.tco_org c " +
        " WHERE     a.del_if = 0 " +
        "       AND c.del_if = 0 " +
        "       AND a.tco_org_pk = c.pk " +
        "       AND a.pk IN ("+ emp_pk +") " +
		"  ORDER BY a.emp_id      " ;

        
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
<link rel=File-List href="rpt_01_TBH_dorco_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_01_TBH_dorco_files/editdata.mso">
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
  <o:Template>Normal</o:Template>
  <o:LastAuthor>hac</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>32</o:TotalTime>
  <o:LastPrinted>2008-10-14T08:11:00Z</o:LastPrinted>
  <o:Created>2011-11-08T06:40:00Z</o:Created>
  <o:LastSaved>2011-11-08T06:40:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>346</o:Words>
  <o:Characters>1975</o:Characters>
  <o:Company> BHXH Viet Nam</o:Company>
  <o:Lines>16</o:Lines>
  <o:Paragraphs>4</o:Paragraphs>
  <o:CharactersWithSpaces>2317</o:CharactersWithSpaces>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Print</w:View>
  <w:Zoom>105</w:Zoom>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DrawingGridHorizontalSpacing>5.45 pt</w:DrawingGridHorizontalSpacing>
  <w:DisplayHorizontalDrawingGridEvery>2</w:DisplayHorizontalDrawingGridEvery>
  <w:DisplayVerticalDrawingGridEvery>2</w:DisplayVerticalDrawingGridEvery>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SelectEntireFieldWithStartOrEnd/>
   <w:ApplyBreakingRules/>
   <w:UseWord2002TableStyleRules/>
   <w:SplitPgBreakAndParaMark/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
  <w:TrackMoves>false</w:TrackMoves>
  <w:TrackFormatting/>
  <w:DoNotPromoteQF/>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"/>
   <m:brkBin m:val="before"/>
   <m:brkBinSub m:val="--"/>
   <m:smallFrac m:val="off"/>
   <m:dispDef/>
   <m:lMargin m:val="0"/>
   <m:rMargin m:val="0"/>
   <m:defJc m:val="centerGroup"/>
   <m:wrapIndent m:val="1440"/>
   <m:intLim m:val="subSup"/>
   <m:naryLim m:val="undOvr"/>
  </m:mathPr>
 </w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" LatentStyleCount="156">
 </w:LatentStyles>
</xml><![endif]-->
<style>
<!--p.MSONORMAL
	{mso-style-unhide:no;
	mso-style-qformat:yes;}
li.MSONORMAL
	{mso-style-unhide:no;
	mso-style-qformat:yes;}
div.MSONORMAL
	{mso-style-unhide:no;
	mso-style-qformat:yes;}
p.MSOHEADER
	{mso-style-unhide:no;}
li.MSOHEADER
	{mso-style-unhide:no;}
div.MSOHEADER
	{mso-style-unhide:no;}
p.MSOFOOTER
	{mso-style-unhide:no;}
li.MSOFOOTER
	{mso-style-unhide:no;}
div.MSOFOOTER
	{mso-style-unhide:no;}
span.HEADERCHAR
	{mso-style-unhide:no;}
span.FOOTERCHAR
	{mso-style-unhide:no;}
.MSOCHPDEFAULT
	{mso-default-props:yes;}
table.MSONORMALTABLE
	{mso-style-priority:99;}
table.MSOTABLEGRID
	{mso-style-unhide:no;}

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
	{font-family:"Times New Roman";
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
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	mso-ansi-language:VI;
	mso-fareast-language:VI;}
p.MsoHeader, li.MsoHeader, div.MsoHeader
	{mso-style-link:"Header Char";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	tab-stops:center 3.0in right 6.0in;
	font-size:14.0pt;
	mso-bidi-font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	mso-ansi-language:VI;
	mso-fareast-language:VI;}
p.MsoFooter, li.MsoFooter, div.MsoFooter
	{mso-style-link:"Footer Char";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	tab-stops:center 207.65pt right 415.3pt;
	font-size:14.0pt;
	mso-bidi-font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	mso-ansi-language:VI;
	mso-fareast-language:VI;}
span.HeaderChar
	{mso-style-name:"Header Char";
	mso-style-locked:yes;
	mso-style-link:Header;
	mso-ansi-font-size:14.0pt;
	mso-bidi-font-size:12.0pt;
	font-family:"Times New Roman";
	mso-ascii-font-family:"Times New Roman";
	mso-hansi-font-family:"Times New Roman";
	mso-ansi-language:VI;
	mso-fareast-language:VI;}
span.FooterChar
	{mso-style-name:"Footer Char";
	mso-style-locked:yes;
	mso-style-link:Footer;
	mso-ansi-font-size:14.0pt;
	mso-bidi-font-size:12.0pt;
	font-family:"Times New Roman";
	mso-ascii-font-family:"Times New Roman";
	mso-hansi-font-family:"Times New Roman";
	mso-ansi-language:VI;
	mso-fareast-language:VI;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
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
<![endif]-->
<link rel=themeData href="rpt_01_TBH_dorco_files/themedata.thmx">
<link rel=colorSchemeMapping
href="rpt_01_TBH_dorco_files/colorschememapping.xml">
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2050" fillcolor="white">
  <v:fill color="white"/>
 </o:shapedefaults></xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=EN-US style='tab-interval:.5in'>

<div class=Section1>
<%
	for(int i = 0; i < irow; i++)
	{
		if (rpt_type != "1")	//in mat truoc va 2 mat
		{
%>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:right'><span
lang=PT-BR style='font-size:11.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><b><%= dt_total.Rows[i][1].ToString()%></b><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:right'><span
lang=PT-BR style='font-size:3.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;tab-stops:27.25pt 250.7pt'><b><span
lang=PT-BR style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><span style='mso-tab-count:1'>     </span><u>BẢO HIỂM XÃ HỘI VIỆT NAM</u><span
style='mso-tab-count:1'>                  </span>CỘNG HOÀ XÃ HỘI CHỦ NGHĨA VIỆT
NAM<o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;tab-stops:250.7pt 288.85pt'><b><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'><span style='mso-tab-count:2'>                                                                          </span><u>Độc
lập - Tự do - Hạnh phúc<o:p></o:p></u></span></b></p>

<div>

<p class=MsoNormal align=center style='margin-left:334.5pt;text-align:center'><b><span
lang=PT-BR style='font-size:10.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal align=center style='margin-left:334.5pt;text-align:center'><b><span
lang=VI style='font-size:10.0pt;font-family:"Times New Roman"'>Mẫu số: 01-TBH</span></b><b><span
style='font-size:10.0pt;font-family:"Times New Roman";mso-ansi-language:EN-US'><o:p></o:p></span></b></p>

<p class=MsoNormal align=center style='margin-left:334.5pt;text-align:center'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-family:
"Times New Roman";mso-ansi-language:EN-US;mso-bidi-font-weight:bold'>(Ban <span
class=SpellE><span class=spelle>hành</span></span> <span class=SpellE>kèm</span>
<span class=SpellE><span class=GramE>theo</span></span> CV <span class=SpellE>số</span>
1615/BHXH</span></i><span style='font-family:"Times New Roman"'> </span><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-family:
"Times New Roman";mso-ansi-language:EN-US;mso-bidi-font-weight:bold'>-<o:p></o:p></span></i></p>

<p class=MsoNormal align=center style='margin-left:334.5pt;text-align:center'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-family:
"Times New Roman";mso-ansi-language:EN-US;mso-bidi-font-weight:bold'>CSXH <span
class=SpellE><span class=spelle>ngày</span></span> 02/06/2009 <span
class=SpellE><span class=spelle>của</span></span> BHXH VN)<o:p></o:p></span></i></p>

</div>

<p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><b><span
lang=VI style='font-size:16.0pt;font-family:"Times New Roman"'>TỜ KHAI</span></b><b><span
lang=PT-BR style='font-size:13.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><o:p></o:p></span></b></p>

<p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><b><span
lang=VI style='font-size:13.0pt;font-family:"Times New Roman"'>THAM GIA BẢO
HIỂM XÃ HỘI, BẢO HIỂM Y TẾ, BẢO HIỂM THẤT NGHIỆP<o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt'><!--[if gte vml 1]><v:group id="Group_x0020_11"
 o:spid="_x0000_s1026" style='position:absolute;left:0;text-align:left;
 margin-left:188pt;margin-top:.25pt;width:171.2pt;height:17.25pt;z-index:-1'
 coordsize="21739,2190" o:gfxdata="UEsDBBQABgAIAAAAIQC2gziS/gAAAOEBAAATAAAAW0NvbnRlbnRfVHlwZXNdLnhtbJSRQU7DMBBF&#13;&#10;90jcwfIWJU67QAgl6YK0S0CoHGBkTxKLZGx5TGhvj5O2G0SRWNoz/78nu9wcxkFMGNg6quQqL6RA&#13;&#10;0s5Y6ir5vt9lD1JwBDIwOMJKHpHlpr69KfdHjyxSmriSfYz+USnWPY7AufNIadK6MEJMx9ApD/oD&#13;&#10;OlTrorhX2lFEilmcO2RdNtjC5xDF9pCuTyYBB5bi6bQ4syoJ3g9WQ0ymaiLzg5KdCXlKLjvcW893&#13;&#10;SUOqXwnz5DrgnHtJTxOsQfEKIT7DmDSUCaxw7Rqn8787ZsmRM9e2VmPeBN4uqYvTtW7jvijg9N/y&#13;&#10;JsXecLq0q+WD6m8AAAD//wMAUEsDBBQABgAIAAAAIQA4/SH/1gAAAJQBAAALAAAAX3JlbHMvLnJl&#13;&#10;bHOkkMFqwzAMhu+DvYPRfXGawxijTi+j0GvpHsDYimMaW0Yy2fr2M4PBMnrbUb/Q94l/f/hMi1qR&#13;&#10;JVI2sOt6UJgd+ZiDgffL8ekFlFSbvV0oo4EbChzGx4f9GRdb25HMsYhqlCwG5lrLq9biZkxWOiqY&#13;&#10;22YiTra2kYMu1l1tQD30/bPm3wwYN0x18gb45AdQl1tp5j/sFB2T0FQ7R0nTNEV3j6o9feQzro1i&#13;&#10;OWA14Fm+Q8a1a8+Bvu/d/dMb2JY5uiPbhG/ktn4cqGU/er3pcvwCAAD//wMAUEsDBBQABgAIAAAA&#13;&#10;IQD7U+mwnAMAAPUdAAAOAAAAZHJzL2Uyb0RvYy54bWzsmdlu2zgUhu8LzDsQvJ9osXZEKYq0CQbo&#13;&#10;EqDtA9AStWAkUkPSkdOn7yEZ047joEUHNTAY+cIQzf0/n34di5evt+OA7qmQPWclDi58jCireN2z&#13;&#10;tsRfv9z8mWEkFWE1GTijJX6gEr+++uPV5TwVNOQdH2oqEAzCZDFPJe6UmgrPk1VHRyIv+EQZVDZc&#13;&#10;jERBUbReLcgMo4+DF/p+4s1c1JPgFZUSfn1rK/GVGb9paKU+NY2kCg0lhrUp8y3M91p/e1eXpGgF&#13;&#10;mbq+elwG+YVVjKRnMKkb6i1RBG1E/2yosa8El7xRFxUfPd40fUXNHmA3gX+0m1vBN5PZS1vM7eRk&#13;&#10;AmmPdPrlYauP93cC9TXELsCIkRFiZKZFUAZx5qktoM2tmD5Pd8LuEC7f8+pvCdXecb0ut/vG20aM&#13;&#10;uhNsFG2N6g9OdbpVqIIfwyCNwgiCU0FdGOR+GtuwVB3E7lm3qnu377jKMwDsaUePFHZaszi3mHkC&#13;&#10;wuReRPnvRPzckYma2Egt0E7EnYaGLD0l1O2Uk1Y2xPh1R1hL3wjB546SGpZixIYFH3TQBQmio/X8&#13;&#10;gdcQF7JR3ED2c6pm0XNRnTakmIRUt5SPSF+UWMCtYgYn9++l0qHdN9ERlHzo65t+GExBtOvrQaB7&#13;&#10;ArfVjfnokEGXJ80GhuYS53EYm5Gf1MnDIXzzOTXE2Cvwh6EfS5y5RqTQqr1jNcxJCkX6wV7D/AMz&#13;&#10;UFrlNL6yUNv1FhrqyzWvH0BQwa0PgG/BRcfFN4xm8IASy382RFCMhr8YBCWK01CbhinkQRRhJA4r&#13;&#10;1gcVhFUwUIkVRvbyWlmb2UyibzuYJzAiMP4Gwtj0RuL9mh5XDYDalf52UsMdqY+3+QF4EMXfRCrc&#13;&#10;6mG2wuiUCSy47nG1hmz9d6H2wF+BHfuMCnfinMFfo2iVBPlpatPMj198AO0d9H9hsoZaF5jFa11W&#13;&#10;AM8NS+3qjNQmcZBFL1C7eO2R17rALNQ6asHXLLXRGanNEt9PF2p/mNAar3WBWah11CY7as2fSJ1g&#13;&#10;nyFDCPw0XSWQUp9KbJcU4chsXWQWbB226Q7b5IxmG4R5lETg8wu2+lXCy68PjNu6yCzYOmzh5ZvN&#13;&#10;EdJzYhuHfp694LZLanvkti4yC7YOW0gwLbbZObFNV1mYLG77c7mti8yCrcM2gJfRltv8nNzmcRxH&#13;&#10;4PSnsoTFbo/s1kXmv8GtOSODs0WT/Tyeg+rDy8OyOZvYn9ZefQcAAP//AwBQSwMEFAAGAAgAAAAh&#13;&#10;AN/ETCjeAAAABwEAAA8AAABkcnMvZG93bnJldi54bWxMj0FLw0AQhe+C/2EZwZvdxJq2xGxKKeqp&#13;&#10;CLaCeJsm0yQ0Oxuy2yT9944nPc57j/e+ydaTbdVAvW8cG4hnESjiwpUNVwY+D68PK1A+IJfYOiYD&#13;&#10;V/Kwzm9vMkxLN/IHDftQKSlhn6KBOoQu1doXNVn0M9cRi3dyvcUgZ1/pssdRym2rH6NooS02LAs1&#13;&#10;drStqTjvL9bA24jjZh6/DLvzaXv9PiTvX7uYjLm/mzbPoAJN4S8Mv/iCDrkwHd2FS69aA/PlQn4J&#13;&#10;BhJQYi/j1ROoo+hJBDrP9H/+/AcAAP//AwBQSwECLQAUAAYACAAAACEAtoM4kv4AAADhAQAAEwAA&#13;&#10;AAAAAAAAAAAAAAAAAAAAW0NvbnRlbnRfVHlwZXNdLnhtbFBLAQItABQABgAIAAAAIQA4/SH/1gAA&#13;&#10;AJQBAAALAAAAAAAAAAAAAAAAAC8BAABfcmVscy8ucmVsc1BLAQItABQABgAIAAAAIQD7U+mwnAMA&#13;&#10;APUdAAAOAAAAAAAAAAAAAAAAAC4CAABkcnMvZTJvRG9jLnhtbFBLAQItABQABgAIAAAAIQDfxEwo&#13;&#10;3gAAAAcBAAAPAAAAAAAAAAAAAAAAAPYFAABkcnMvZG93bnJldi54bWxQSwUGAAAAAAQABADzAAAA&#13;&#10;AQcAAAAA&#13;&#10;">
 <v:rect id="<%=i*10 +9%>" o:spid="_x0000_s1027" style='position:absolute;width:2184;
  height:2190;visibility:visible' o:gfxdata="UEsDBBQABgAIAAAAIQDw94q7/QAAAOIBAAATAAAAW0NvbnRlbnRfVHlwZXNdLnhtbJSRzUrEMBDH&#13;&#10;74LvEOYqbaoHEWm6B6tHFV0fYEimbdg2CZlYd9/edD8u4goeZ+b/8SOpV9tpFDNFtt4puC4rEOS0&#13;&#10;N9b1Cj7WT8UdCE7oDI7ekYIdMayay4t6vQvEIrsdKxhSCvdSsh5oQi59IJcvnY8TpjzGXgbUG+xJ&#13;&#10;3lTVrdTeJXKpSEsGNHVLHX6OSTxu8/pAEmlkEA8H4dKlAEMYrcaUSeXszI+W4thQZudew4MNfJUx&#13;&#10;QP7asFzOFxx9L/lpojUkXjGmZ5wyhjSRJQ8YKGvKv1MWzIkL33VWU9lGfl98J6hz4cZ/uUjzf7Pb&#13;&#10;bHuj+ZQu9z/UfAMAAP//AwBQSwMEFAAGAAgAAAAhADHdX2HSAAAAjwEAAAsAAABfcmVscy8ucmVs&#13;&#10;c6SQwWrDMAyG74O9g9G9cdpDGaNOb4VeSwe7CltJTGPLWCZt376mMFhGbzvqF/o+8e/2tzCpmbJ4&#13;&#10;jgbWTQuKomXn42Dg63xYfYCSgtHhxJEM3Elg372/7U40YalHMvokqlKiGBhLSZ9aix0poDScKNZN&#13;&#10;zzlgqWMedEJ7wYH0pm23Ov9mQLdgqqMzkI9uA+p8T9X8hx28zSzcl8Zy0Nz33r6iasfXeKK5UjAP&#13;&#10;VAy4LM8w09zU50C/9q7/6ZURE31X/kL8TKv1x6wXNXYPAAAA//8DAFBLAwQUAAYACAAAACEAMy8F&#13;&#10;nkEAAAA5AAAAEAAAAGRycy9zaGFwZXhtbC54bWyysa/IzVEoSy0qzszPs1Uy1DNQUkjNS85PycxL&#13;&#10;t1UKDXHTtVBSKC5JzEtJzMnPS7VVqkwtVrK34+UCAAAA//8DAFBLAwQUAAYACAAAACEArA/tNr8A&#13;&#10;AADaAAAADwAAAGRycy9kb3ducmV2LnhtbERPTYvCMBC9L/gfwgje1lRxF6lGEUH0sJftevE2NGNb&#13;&#10;25mUJmr99xtB8DQ83ucs1z036kadr5wYmIwTUCS5s5UUBo5/u885KB9QLDZOyMCDPKxXg48lptbd&#13;&#10;5ZduWShUDBGfooEyhDbV2uclMfqxa0kid3YdY4iwK7Tt8B7DudHTJPnWjJXEhhJb2paU19mVDWQz&#13;&#10;vky5Pl356wezfn+a1Be3M2Y07DcLUIH68Ba/3Acb58PzlefVq38AAAD//wMAUEsBAi0AFAAGAAgA&#13;&#10;AAAhAPD3irv9AAAA4gEAABMAAAAAAAAAAAAAAAAAAAAAAFtDb250ZW50X1R5cGVzXS54bWxQSwEC&#13;&#10;LQAUAAYACAAAACEAMd1fYdIAAACPAQAACwAAAAAAAAAAAAAAAAAuAQAAX3JlbHMvLnJlbHNQSwEC&#13;&#10;LQAUAAYACAAAACEAMy8FnkEAAAA5AAAAEAAAAAAAAAAAAAAAAAApAgAAZHJzL3NoYXBleG1sLnht&#13;&#10;bFBLAQItABQABgAIAAAAIQCsD+02vwAAANoAAAAPAAAAAAAAAAAAAAAAAJgCAABkcnMvZG93bnJl&#13;&#10;di54bWxQSwUGAAAAAAQABAD1AAAAhAMAAAAA&#13;&#10;">
  <v:textbox style='mso-next-textbox:#<%=i*10 +9%>' inset="3.6pt,.72pt,3.6pt,.72pt">
   <![if !mso]>
   <table cellpadding=0 cellspacing=0 width="100%">
    <tr>
     <td><![endif]>
     <div>
     <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][25].ToString().Substring(0,1)%><o:p></o:p></span></p>
     </div>
     <![if !mso]></td>
    </tr>
   </table>
   <![endif]></v:textbox>
 </v:rect><v:rect id="<%=i*10 +8%>" o:spid="_x0000_s1028" style='position:absolute;
  left:2172;width:2185;height:2190;visibility:visible' o:gfxdata="UEsDBBQABgAIAAAAIQDw94q7/QAAAOIBAAATAAAAW0NvbnRlbnRfVHlwZXNdLnhtbJSRzUrEMBDH&#13;&#10;74LvEOYqbaoHEWm6B6tHFV0fYEimbdg2CZlYd9/edD8u4goeZ+b/8SOpV9tpFDNFtt4puC4rEOS0&#13;&#10;N9b1Cj7WT8UdCE7oDI7ekYIdMayay4t6vQvEIrsdKxhSCvdSsh5oQi59IJcvnY8TpjzGXgbUG+xJ&#13;&#10;3lTVrdTeJXKpSEsGNHVLHX6OSTxu8/pAEmlkEA8H4dKlAEMYrcaUSeXszI+W4thQZudew4MNfJUx&#13;&#10;QP7asFzOFxx9L/lpojUkXjGmZ5wyhjSRJQ8YKGvKv1MWzIkL33VWU9lGfl98J6hz4cZ/uUjzf7Pb&#13;&#10;bHuj+ZQu9z/UfAMAAP//AwBQSwMEFAAGAAgAAAAhADHdX2HSAAAAjwEAAAsAAABfcmVscy8ucmVs&#13;&#10;c6SQwWrDMAyG74O9g9G9cdpDGaNOb4VeSwe7CltJTGPLWCZt376mMFhGbzvqF/o+8e/2tzCpmbJ4&#13;&#10;jgbWTQuKomXn42Dg63xYfYCSgtHhxJEM3Elg372/7U40YalHMvokqlKiGBhLSZ9aix0poDScKNZN&#13;&#10;zzlgqWMedEJ7wYH0pm23Ov9mQLdgqqMzkI9uA+p8T9X8hx28zSzcl8Zy0Nz33r6iasfXeKK5UjAP&#13;&#10;VAy4LM8w09zU50C/9q7/6ZURE31X/kL8TKv1x6wXNXYPAAAA//8DAFBLAwQUAAYACAAAACEAMy8F&#13;&#10;nkEAAAA5AAAAEAAAAGRycy9zaGFwZXhtbC54bWyysa/IzVEoSy0qzszPs1Uy1DNQUkjNS85PycxL&#13;&#10;t1UKDXHTtVBSKC5JzEtJzMnPS7VVqkwtVrK34+UCAAAA//8DAFBLAwQUAAYACAAAACEAXN1zQcIA&#13;&#10;AADaAAAADwAAAGRycy9kb3ducmV2LnhtbESPT2vCQBTE74V+h+UJ3urGYIukbkQKoodemnrx9si+&#13;&#10;5u97G7Krxm/vFgo9DjPzG2aznbhXVxp948TAcpGAIimdbaQycPrev6xB+YBisXdCBu7kYZs/P20w&#13;&#10;s+4mX3QtQqUiRHyGBuoQhkxrX9bE6BduIInejxsZQ5Rjpe2ItwjnXqdJ8qYZG4kLNQ70UVPZFRc2&#13;&#10;UKy4Tbk7X/j1E4vpcF52rdsbM59Nu3dQgabwH/5rH62BFH6vxBug8wcAAAD//wMAUEsBAi0AFAAG&#13;&#10;AAgAAAAhAPD3irv9AAAA4gEAABMAAAAAAAAAAAAAAAAAAAAAAFtDb250ZW50X1R5cGVzXS54bWxQ&#13;&#10;SwECLQAUAAYACAAAACEAMd1fYdIAAACPAQAACwAAAAAAAAAAAAAAAAAuAQAAX3JlbHMvLnJlbHNQ&#13;&#10;SwECLQAUAAYACAAAACEAMy8FnkEAAAA5AAAAEAAAAAAAAAAAAAAAAAApAgAAZHJzL3NoYXBleG1s&#13;&#10;LnhtbFBLAQItABQABgAIAAAAIQBc3XNBwgAAANoAAAAPAAAAAAAAAAAAAAAAAJgCAABkcnMvZG93&#13;&#10;bnJldi54bWxQSwUGAAAAAAQABAD1AAAAhwMAAAAA&#13;&#10;">
  <v:textbox style='mso-next-textbox:#<%=i*10 +8%>' inset="3.6pt,.72pt,3.6pt,.72pt">
   <![if !mso]>
   <table cellpadding=0 cellspacing=0 width="100%">
    <tr>
     <td><![endif]>
     <div>
     <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][25].ToString().Substring(1,1)%><o:p></o:p></span></p>
     </div>
     <![if !mso]></td>
    </tr>
   </table>
   <![endif]></v:textbox>
 </v:rect><v:rect id="<%=i*10 +7%>" o:spid="_x0000_s1029" style='position:absolute;
  left:4436;width:2178;height:2190;visibility:visible' o:gfxdata="UEsDBBQABgAIAAAAIQDw94q7/QAAAOIBAAATAAAAW0NvbnRlbnRfVHlwZXNdLnhtbJSRzUrEMBDH&#13;&#10;74LvEOYqbaoHEWm6B6tHFV0fYEimbdg2CZlYd9/edD8u4goeZ+b/8SOpV9tpFDNFtt4puC4rEOS0&#13;&#10;N9b1Cj7WT8UdCE7oDI7ekYIdMayay4t6vQvEIrsdKxhSCvdSsh5oQi59IJcvnY8TpjzGXgbUG+xJ&#13;&#10;3lTVrdTeJXKpSEsGNHVLHX6OSTxu8/pAEmlkEA8H4dKlAEMYrcaUSeXszI+W4thQZudew4MNfJUx&#13;&#10;QP7asFzOFxx9L/lpojUkXjGmZ5wyhjSRJQ8YKGvKv1MWzIkL33VWU9lGfl98J6hz4cZ/uUjzf7Pb&#13;&#10;bHuj+ZQu9z/UfAMAAP//AwBQSwMEFAAGAAgAAAAhADHdX2HSAAAAjwEAAAsAAABfcmVscy8ucmVs&#13;&#10;c6SQwWrDMAyG74O9g9G9cdpDGaNOb4VeSwe7CltJTGPLWCZt376mMFhGbzvqF/o+8e/2tzCpmbJ4&#13;&#10;jgbWTQuKomXn42Dg63xYfYCSgtHhxJEM3Elg372/7U40YalHMvokqlKiGBhLSZ9aix0poDScKNZN&#13;&#10;zzlgqWMedEJ7wYH0pm23Ov9mQLdgqqMzkI9uA+p8T9X8hx28zSzcl8Zy0Nz33r6iasfXeKK5UjAP&#13;&#10;VAy4LM8w09zU50C/9q7/6ZURE31X/kL8TKv1x6wXNXYPAAAA//8DAFBLAwQUAAYACAAAACEAMy8F&#13;&#10;nkEAAAA5AAAAEAAAAGRycy9zaGFwZXhtbC54bWyysa/IzVEoSy0qzszPs1Uy1DNQUkjNS85PycxL&#13;&#10;t1UKDXHTtVBSKC5JzEtJzMnPS7VVqkwtVrK34+UCAAAA//8DAFBLAwQUAAYACAAAACEAM5HW2sMA&#13;&#10;AADaAAAADwAAAGRycy9kb3ducmV2LnhtbESPT2vCQBTE74V+h+UJ3urGPy0lukopSD14MfaS2yP7&#13;&#10;msTkvQ3ZVeO3dwWhx2FmfsOsNgO36kK9r50YmE4SUCSFs7WUBn6P27dPUD6gWGydkIEbedisX19W&#13;&#10;mFp3lQNdslCqCBGfooEqhC7V2hcVMfqJ60ii9+d6xhBlX2rb4zXCudWzJPnQjLXEhQo7+q6oaLIz&#13;&#10;G8gWfJpxk5/5fY/Z8JNPm5PbGjMeDV9LUIGG8B9+tnfWwBweV+IN0Os7AAAA//8DAFBLAQItABQA&#13;&#10;BgAIAAAAIQDw94q7/QAAAOIBAAATAAAAAAAAAAAAAAAAAAAAAABbQ29udGVudF9UeXBlc10ueG1s&#13;&#10;UEsBAi0AFAAGAAgAAAAhADHdX2HSAAAAjwEAAAsAAAAAAAAAAAAAAAAALgEAAF9yZWxzLy5yZWxz&#13;&#10;UEsBAi0AFAAGAAgAAAAhADMvBZ5BAAAAOQAAABAAAAAAAAAAAAAAAAAAKQIAAGRycy9zaGFwZXht&#13;&#10;bC54bWxQSwECLQAUAAYACAAAACEAM5HW2sMAAADaAAAADwAAAAAAAAAAAAAAAACYAgAAZHJzL2Rv&#13;&#10;d25yZXYueG1sUEsFBgAAAAAEAAQA9QAAAIgDAAAAAA==&#13;&#10;">
  <v:textbox style='mso-next-textbox:#<%=i*10 +7%>' inset="3.6pt,.72pt,3.6pt,.72pt">
   <![if !mso]>
   <table cellpadding=0 cellspacing=0 width="100%">
    <tr>
     <td><![endif]>
     <div>
     <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][25].ToString().Substring(2,1)%><o:p></o:p></span></p>
     </div>
     <![if !mso]></td>
    </tr>
   </table>
   <![endif]></v:textbox>
 </v:rect><v:rect id="<%=i*10 +6%>" o:spid="_x0000_s1030" style='position:absolute;
  left:6518;width:2184;height:2190;visibility:visible' o:gfxdata="UEsDBBQABgAIAAAAIQDw94q7/QAAAOIBAAATAAAAW0NvbnRlbnRfVHlwZXNdLnhtbJSRzUrEMBDH&#13;&#10;74LvEOYqbaoHEWm6B6tHFV0fYEimbdg2CZlYd9/edD8u4goeZ+b/8SOpV9tpFDNFtt4puC4rEOS0&#13;&#10;N9b1Cj7WT8UdCE7oDI7ekYIdMayay4t6vQvEIrsdKxhSCvdSsh5oQi59IJcvnY8TpjzGXgbUG+xJ&#13;&#10;3lTVrdTeJXKpSEsGNHVLHX6OSTxu8/pAEmlkEA8H4dKlAEMYrcaUSeXszI+W4thQZudew4MNfJUx&#13;&#10;QP7asFzOFxx9L/lpojUkXjGmZ5wyhjSRJQ8YKGvKv1MWzIkL33VWU9lGfl98J6hz4cZ/uUjzf7Pb&#13;&#10;bHuj+ZQu9z/UfAMAAP//AwBQSwMEFAAGAAgAAAAhADHdX2HSAAAAjwEAAAsAAABfcmVscy8ucmVs&#13;&#10;c6SQwWrDMAyG74O9g9G9cdpDGaNOb4VeSwe7CltJTGPLWCZt376mMFhGbzvqF/o+8e/2tzCpmbJ4&#13;&#10;jgbWTQuKomXn42Dg63xYfYCSgtHhxJEM3Elg372/7U40YalHMvokqlKiGBhLSZ9aix0poDScKNZN&#13;&#10;zzlgqWMedEJ7wYH0pm23Ov9mQLdgqqMzkI9uA+p8T9X8hx28zSzcl8Zy0Nz33r6iasfXeKK5UjAP&#13;&#10;VAy4LM8w09zU50C/9q7/6ZURE31X/kL8TKv1x6wXNXYPAAAA//8DAFBLAwQUAAYACAAAACEAMy8F&#13;&#10;nkEAAAA5AAAAEAAAAGRycy9zaGFwZXhtbC54bWyysa/IzVEoSy0qzszPs1Uy1DNQUkjNS85PycxL&#13;&#10;t1UKDXHTtVBSKC5JzEtJzMnPS7VVqkwtVrK34+UCAAAA//8DAFBLAwQUAAYACAAAACEAvHhOrsEA&#13;&#10;AADaAAAADwAAAGRycy9kb3ducmV2LnhtbESPwYrCQBBE7wv+w9CCt3Wi6CLRUUQQPezFrBdvTaZN&#13;&#10;YtI9ITNq/HtnYWGPRVW9olabnhv1oM5XTgxMxgkoktzZSgoD55/95wKUDygWGydk4EUeNuvBxwpT&#13;&#10;655yokcWChUh4lM0UIbQplr7vCRGP3YtSfSurmMMUXaFth0+I5wbPU2SL81YSVwosaVdSXmd3dlA&#13;&#10;NuPblOvLneffmPWHy6S+ub0xo2G/XYIK1If/8F/7aA3M4PdKvAF6/QYAAP//AwBQSwECLQAUAAYA&#13;&#10;CAAAACEA8PeKu/0AAADiAQAAEwAAAAAAAAAAAAAAAAAAAAAAW0NvbnRlbnRfVHlwZXNdLnhtbFBL&#13;&#10;AQItABQABgAIAAAAIQAx3V9h0gAAAI8BAAALAAAAAAAAAAAAAAAAAC4BAABfcmVscy8ucmVsc1BL&#13;&#10;AQItABQABgAIAAAAIQAzLwWeQQAAADkAAAAQAAAAAAAAAAAAAAAAACkCAABkcnMvc2hhcGV4bWwu&#13;&#10;eG1sUEsBAi0AFAAGAAgAAAAhALx4Tq7BAAAA2gAAAA8AAAAAAAAAAAAAAAAAmAIAAGRycy9kb3du&#13;&#10;cmV2LnhtbFBLBQYAAAAABAAEAPUAAACGAwAAAAA=&#13;&#10;">
  <v:textbox inset="3.6pt,.72pt,3.6pt,.72pt">
   <![if !mso]>
   <table cellpadding=0 cellspacing=0 width="100%">
    <tr>
     <td><![endif]>
     <div>
     <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][25].ToString().Substring(3,1)%><o:p></o:p></span></p>
     </div>
     <![if !mso]></td>
    </tr>
   </table>
   <![endif]></v:textbox>
 </v:rect><v:rect id="<%=i*10 +5%>" o:spid="_x0000_s1031" style='position:absolute;
  left:8600;width:2185;height:2190;visibility:visible' o:gfxdata="UEsDBBQABgAIAAAAIQDw94q7/QAAAOIBAAATAAAAW0NvbnRlbnRfVHlwZXNdLnhtbJSRzUrEMBDH&#13;&#10;74LvEOYqbaoHEWm6B6tHFV0fYEimbdg2CZlYd9/edD8u4goeZ+b/8SOpV9tpFDNFtt4puC4rEOS0&#13;&#10;N9b1Cj7WT8UdCE7oDI7ekYIdMayay4t6vQvEIrsdKxhSCvdSsh5oQi59IJcvnY8TpjzGXgbUG+xJ&#13;&#10;3lTVrdTeJXKpSEsGNHVLHX6OSTxu8/pAEmlkEA8H4dKlAEMYrcaUSeXszI+W4thQZudew4MNfJUx&#13;&#10;QP7asFzOFxx9L/lpojUkXjGmZ5wyhjSRJQ8YKGvKv1MWzIkL33VWU9lGfl98J6hz4cZ/uUjzf7Pb&#13;&#10;bHuj+ZQu9z/UfAMAAP//AwBQSwMEFAAGAAgAAAAhADHdX2HSAAAAjwEAAAsAAABfcmVscy8ucmVs&#13;&#10;c6SQwWrDMAyG74O9g9G9cdpDGaNOb4VeSwe7CltJTGPLWCZt376mMFhGbzvqF/o+8e/2tzCpmbJ4&#13;&#10;jgbWTQuKomXn42Dg63xYfYCSgtHhxJEM3Elg372/7U40YalHMvokqlKiGBhLSZ9aix0poDScKNZN&#13;&#10;zzlgqWMedEJ7wYH0pm23Ov9mQLdgqqMzkI9uA+p8T9X8hx28zSzcl8Zy0Nz33r6iasfXeKK5UjAP&#13;&#10;VAy4LM8w09zU50C/9q7/6ZURE31X/kL8TKv1x6wXNXYPAAAA//8DAFBLAwQUAAYACAAAACEAMy8F&#13;&#10;nkEAAAA5AAAAEAAAAGRycy9zaGFwZXhtbC54bWyysa/IzVEoSy0qzszPs1Uy1DNQUkjNS85PycxL&#13;&#10;t1UKDXHTtVBSKC5JzEtJzMnPS7VVqkwtVrK34+UCAAAA//8DAFBLAwQUAAYACAAAACEA0zTrNcEA&#13;&#10;AADaAAAADwAAAGRycy9kb3ducmV2LnhtbESPwYrCQBBE7wv+w9CCt3Wi6CLRUUQQPexls168NZk2&#13;&#10;iUn3hMyo8e93FgSPRVW9olabnht1p85XTgxMxgkoktzZSgoDp9/95wKUDygWGydk4EkeNuvBxwpT&#13;&#10;6x7yQ/csFCpCxKdooAyhTbX2eUmMfuxakuhdXMcYouwKbTt8RDg3epokX5qxkrhQYku7kvI6u7GB&#13;&#10;bMbXKdfnG8+/MesP50l9dXtjRsN+uwQVqA/v8Kt9tAbm8H8l3gC9/gMAAP//AwBQSwECLQAUAAYA&#13;&#10;CAAAACEA8PeKu/0AAADiAQAAEwAAAAAAAAAAAAAAAAAAAAAAW0NvbnRlbnRfVHlwZXNdLnhtbFBL&#13;&#10;AQItABQABgAIAAAAIQAx3V9h0gAAAI8BAAALAAAAAAAAAAAAAAAAAC4BAABfcmVscy8ucmVsc1BL&#13;&#10;AQItABQABgAIAAAAIQAzLwWeQQAAADkAAAAQAAAAAAAAAAAAAAAAACkCAABkcnMvc2hhcGV4bWwu&#13;&#10;eG1sUEsBAi0AFAAGAAgAAAAhANM06zXBAAAA2gAAAA8AAAAAAAAAAAAAAAAAmAIAAGRycy9kb3du&#13;&#10;cmV2LnhtbFBLBQYAAAAABAAEAPUAAACGAwAAAAA=&#13;&#10;">
  <v:textbox inset="3.6pt,.72pt,3.6pt,.72pt">
   <![if !mso]>
   <table cellpadding=0 cellspacing=0 width="100%">
    <tr>
     <td><![endif]>
     <div>
     <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][25].ToString().Substring(4,1)%><o:p></o:p></span></p>
     </div>
     <![if !mso]></td>
    </tr>
   </table>
   <![endif]></v:textbox>
 </v:rect><v:rect id="<%=i*10 +4%>" o:spid="_x0000_s1032" style='position:absolute;
  left:10773;width:2178;height:2190;visibility:visible' o:gfxdata="UEsDBBQABgAIAAAAIQDw94q7/QAAAOIBAAATAAAAW0NvbnRlbnRfVHlwZXNdLnhtbJSRzUrEMBDH&#13;&#10;74LvEOYqbaoHEWm6B6tHFV0fYEimbdg2CZlYd9/edD8u4goeZ+b/8SOpV9tpFDNFtt4puC4rEOS0&#13;&#10;N9b1Cj7WT8UdCE7oDI7ekYIdMayay4t6vQvEIrsdKxhSCvdSsh5oQi59IJcvnY8TpjzGXgbUG+xJ&#13;&#10;3lTVrdTeJXKpSEsGNHVLHX6OSTxu8/pAEmlkEA8H4dKlAEMYrcaUSeXszI+W4thQZudew4MNfJUx&#13;&#10;QP7asFzOFxx9L/lpojUkXjGmZ5wyhjSRJQ8YKGvKv1MWzIkL33VWU9lGfl98J6hz4cZ/uUjzf7Pb&#13;&#10;bHuj+ZQu9z/UfAMAAP//AwBQSwMEFAAGAAgAAAAhADHdX2HSAAAAjwEAAAsAAABfcmVscy8ucmVs&#13;&#10;c6SQwWrDMAyG74O9g9G9cdpDGaNOb4VeSwe7CltJTGPLWCZt376mMFhGbzvqF/o+8e/2tzCpmbJ4&#13;&#10;jgbWTQuKomXn42Dg63xYfYCSgtHhxJEM3Elg372/7U40YalHMvokqlKiGBhLSZ9aix0poDScKNZN&#13;&#10;zzlgqWMedEJ7wYH0pm23Ov9mQLdgqqMzkI9uA+p8T9X8hx28zSzcl8Zy0Nz33r6iasfXeKK5UjAP&#13;&#10;VAy4LM8w09zU50C/9q7/6ZURE31X/kL8TKv1x6wXNXYPAAAA//8DAFBLAwQUAAYACAAAACEAMy8F&#13;&#10;nkEAAAA5AAAAEAAAAGRycy9zaGFwZXhtbC54bWyysa/IzVEoSy0qzszPs1Uy1DNQUkjNS85PycxL&#13;&#10;t1UKDXHTtVBSKC5JzEtJzMnPS7VVqkwtVrK34+UCAAAA//8DAFBLAwQUAAYACAAAACEAI+Z1QsEA&#13;&#10;AADaAAAADwAAAGRycy9kb3ducmV2LnhtbESPwYrCQBBE7wv+w9CCt3WiqEh0FBFED3vZrBdvTaZN&#13;&#10;YtI9ITNq/PudBWGPRVW9otbbnhv1oM5XTgxMxgkoktzZSgoD55/D5xKUDygWGydk4EUetpvBxxpT&#13;&#10;657yTY8sFCpCxKdooAyhTbX2eUmMfuxakuhdXccYouwKbTt8Rjg3epokC81YSVwosaV9SXmd3dlA&#13;&#10;NuPblOvLnedfmPXHy6S+uYMxo2G/W4EK1If/8Lt9sgYW8Hcl3gC9+QUAAP//AwBQSwECLQAUAAYA&#13;&#10;CAAAACEA8PeKu/0AAADiAQAAEwAAAAAAAAAAAAAAAAAAAAAAW0NvbnRlbnRfVHlwZXNdLnhtbFBL&#13;&#10;AQItABQABgAIAAAAIQAx3V9h0gAAAI8BAAALAAAAAAAAAAAAAAAAAC4BAABfcmVscy8ucmVsc1BL&#13;&#10;AQItABQABgAIAAAAIQAzLwWeQQAAADkAAAAQAAAAAAAAAAAAAAAAACkCAABkcnMvc2hhcGV4bWwu&#13;&#10;eG1sUEsBAi0AFAAGAAgAAAAhACPmdULBAAAA2gAAAA8AAAAAAAAAAAAAAAAAmAIAAGRycy9kb3du&#13;&#10;cmV2LnhtbFBLBQYAAAAABAAEAPUAAACGAwAAAAA=&#13;&#10;">
  <v:textbox inset="3.6pt,.72pt,3.6pt,.72pt">
   <![if !mso]>
   <table cellpadding=0 cellspacing=0 width="100%">
    <tr>
     <td><![endif]>
     <div>
     <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][25].ToString().Substring(5,1)%><o:p></o:p></span></p>
     </div>
     <![if !mso]></td>
    </tr>
   </table>
   <![endif]></v:textbox>
 </v:rect><v:rect id="<%=i*10 +3%>" o:spid="_x0000_s1033" style='position:absolute;
  left:12946;width:2178;height:2190;visibility:visible' o:gfxdata="UEsDBBQABgAIAAAAIQDw94q7/QAAAOIBAAATAAAAW0NvbnRlbnRfVHlwZXNdLnhtbJSRzUrEMBDH&#13;&#10;74LvEOYqbaoHEWm6B6tHFV0fYEimbdg2CZlYd9/edD8u4goeZ+b/8SOpV9tpFDNFtt4puC4rEOS0&#13;&#10;N9b1Cj7WT8UdCE7oDI7ekYIdMayay4t6vQvEIrsdKxhSCvdSsh5oQi59IJcvnY8TpjzGXgbUG+xJ&#13;&#10;3lTVrdTeJXKpSEsGNHVLHX6OSTxu8/pAEmlkEA8H4dKlAEMYrcaUSeXszI+W4thQZudew4MNfJUx&#13;&#10;QP7asFzOFxx9L/lpojUkXjGmZ5wyhjSRJQ8YKGvKv1MWzIkL33VWU9lGfl98J6hz4cZ/uUjzf7Pb&#13;&#10;bHuj+ZQu9z/UfAMAAP//AwBQSwMEFAAGAAgAAAAhADHdX2HSAAAAjwEAAAsAAABfcmVscy8ucmVs&#13;&#10;c6SQwWrDMAyG74O9g9G9cdpDGaNOb4VeSwe7CltJTGPLWCZt376mMFhGbzvqF/o+8e/2tzCpmbJ4&#13;&#10;jgbWTQuKomXn42Dg63xYfYCSgtHhxJEM3Elg372/7U40YalHMvokqlKiGBhLSZ9aix0poDScKNZN&#13;&#10;zzlgqWMedEJ7wYH0pm23Ov9mQLdgqqMzkI9uA+p8T9X8hx28zSzcl8Zy0Nz33r6iasfXeKK5UjAP&#13;&#10;VAy4LM8w09zU50C/9q7/6ZURE31X/kL8TKv1x6wXNXYPAAAA//8DAFBLAwQUAAYACAAAACEAMy8F&#13;&#10;nkEAAAA5AAAAEAAAAGRycy9zaGFwZXhtbC54bWyysa/IzVEoSy0qzszPs1Uy1DNQUkjNS85PycxL&#13;&#10;t1UKDXHTtVBSKC5JzEtJzMnPS7VVqkwtVrK34+UCAAAA//8DAFBLAwQUAAYACAAAACEATKrQ2cIA&#13;&#10;AADaAAAADwAAAGRycy9kb3ducmV2LnhtbESPQWvCQBSE74X+h+UJ3upG0bZEVykFqQcvxl5ye2Rf&#13;&#10;k5i8tyG7avz3riD0OMzMN8xqM3CrLtT72omB6SQBRVI4W0tp4Pe4ffsE5QOKxdYJGbiRh8369WWF&#13;&#10;qXVXOdAlC6WKEPEpGqhC6FKtfVERo5+4jiR6f65nDFH2pbY9XiOcWz1LknfNWEtcqLCj74qKJjuz&#13;&#10;gWzOpxk3+ZkXe8yGn3zanNzWmPFo+FqCCjSE//CzvbMGPuBxJd4Avb4DAAD//wMAUEsBAi0AFAAG&#13;&#10;AAgAAAAhAPD3irv9AAAA4gEAABMAAAAAAAAAAAAAAAAAAAAAAFtDb250ZW50X1R5cGVzXS54bWxQ&#13;&#10;SwECLQAUAAYACAAAACEAMd1fYdIAAACPAQAACwAAAAAAAAAAAAAAAAAuAQAAX3JlbHMvLnJlbHNQ&#13;&#10;SwECLQAUAAYACAAAACEAMy8FnkEAAAA5AAAAEAAAAAAAAAAAAAAAAAApAgAAZHJzL3NoYXBleG1s&#13;&#10;LnhtbFBLAQItABQABgAIAAAAIQBMqtDZwgAAANoAAAAPAAAAAAAAAAAAAAAAAJgCAABkcnMvZG93&#13;&#10;bnJldi54bWxQSwUGAAAAAAQABAD1AAAAhwMAAAAA&#13;&#10;">
  <v:textbox inset="3.6pt,.72pt,3.6pt,.72pt">
   <![if !mso]>
   <table cellpadding=0 cellspacing=0 width="100%">
    <tr>
     <td><![endif]>
     <div>
     <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][25].ToString().Substring(6,1)%><o:p></o:p></span></p>
     </div>
     <![if !mso]></td>
    </tr>
   </table>
   <![endif]></v:textbox>
 </v:rect><v:rect id="<%=i*10 +2%>" o:spid="_x0000_s1034" style='position:absolute;
  left:15209;width:2185;height:2190;visibility:visible' o:gfxdata="UEsDBBQABgAIAAAAIQDw94q7/QAAAOIBAAATAAAAW0NvbnRlbnRfVHlwZXNdLnhtbJSRzUrEMBDH&#13;&#10;74LvEOYqbaoHEWm6B6tHFV0fYEimbdg2CZlYd9/edD8u4goeZ+b/8SOpV9tpFDNFtt4puC4rEOS0&#13;&#10;N9b1Cj7WT8UdCE7oDI7ekYIdMayay4t6vQvEIrsdKxhSCvdSsh5oQi59IJcvnY8TpjzGXgbUG+xJ&#13;&#10;3lTVrdTeJXKpSEsGNHVLHX6OSTxu8/pAEmlkEA8H4dKlAEMYrcaUSeXszI+W4thQZudew4MNfJUx&#13;&#10;QP7asFzOFxx9L/lpojUkXjGmZ5wyhjSRJQ8YKGvKv1MWzIkL33VWU9lGfl98J6hz4cZ/uUjzf7Pb&#13;&#10;bHuj+ZQu9z/UfAMAAP//AwBQSwMEFAAGAAgAAAAhADHdX2HSAAAAjwEAAAsAAABfcmVscy8ucmVs&#13;&#10;c6SQwWrDMAyG74O9g9G9cdpDGaNOb4VeSwe7CltJTGPLWCZt376mMFhGbzvqF/o+8e/2tzCpmbJ4&#13;&#10;jgbWTQuKomXn42Dg63xYfYCSgtHhxJEM3Elg372/7U40YalHMvokqlKiGBhLSZ9aix0poDScKNZN&#13;&#10;zzlgqWMedEJ7wYH0pm23Ov9mQLdgqqMzkI9uA+p8T9X8hx28zSzcl8Zy0Nz33r6iasfXeKK5UjAP&#13;&#10;VAy4LM8w09zU50C/9q7/6ZURE31X/kL8TKv1x6wXNXYPAAAA//8DAFBLAwQUAAYACAAAACEAMy8F&#13;&#10;nkEAAAA5AAAAEAAAAGRycy9zaGFwZXhtbC54bWyysa/IzVEoSy0qzszPs1Uy1DNQUkjNS85PycxL&#13;&#10;t1UKDXHTtVBSKC5JzEtJzMnPS7VVqkwtVrK34+UCAAAA//8DAFBLAwQUAAYACAAAACEAPTVEq74A&#13;&#10;AADaAAAADwAAAGRycy9kb3ducmV2LnhtbERPTYvCMBC9C/6HMII3myqrLF2jyILsHvZi9eJtaMa2&#13;&#10;tjMpTdT67zcHwePjfa+3A7fqTr2vnRiYJykoksLZWkoDp+N+9gnKBxSLrRMy8CQP2814tMbMuocc&#13;&#10;6J6HUsUQ8RkaqELoMq19URGjT1xHErmL6xlDhH2pbY+PGM6tXqTpSjPWEhsq7Oi7oqLJb2wg/+Dr&#13;&#10;gpvzjZd/mA8/53lzdXtjppNh9wUq0BDe4pf71xqIW+OVeAP05h8AAP//AwBQSwECLQAUAAYACAAA&#13;&#10;ACEA8PeKu/0AAADiAQAAEwAAAAAAAAAAAAAAAAAAAAAAW0NvbnRlbnRfVHlwZXNdLnhtbFBLAQIt&#13;&#10;ABQABgAIAAAAIQAx3V9h0gAAAI8BAAALAAAAAAAAAAAAAAAAAC4BAABfcmVscy8ucmVsc1BLAQIt&#13;&#10;ABQABgAIAAAAIQAzLwWeQQAAADkAAAAQAAAAAAAAAAAAAAAAACkCAABkcnMvc2hhcGV4bWwueG1s&#13;&#10;UEsBAi0AFAAGAAgAAAAhAD01RKu+AAAA2gAAAA8AAAAAAAAAAAAAAAAAmAIAAGRycy9kb3ducmV2&#13;&#10;LnhtbFBLBQYAAAAABAAEAPUAAACDAwAAAAA=&#13;&#10;">
  <v:textbox inset="3.6pt,.72pt,3.6pt,.72pt">
   <![if !mso]>
   <table cellpadding=0 cellspacing=0 width="100%">
    <tr>
     <td><![endif]>
     <div>
     <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][25].ToString().Substring(7,1)%><o:p></o:p></span></p>
     </div>
     <![if !mso]></td>
    </tr>
   </table>
   <![endif]></v:textbox>
 </v:rect><v:rect id="<%=i*10 +1%>" o:spid="_x0000_s1035" style='position:absolute;
  left:17382;width:2178;height:2190;visibility:visible' o:gfxdata="UEsDBBQABgAIAAAAIQDw94q7/QAAAOIBAAATAAAAW0NvbnRlbnRfVHlwZXNdLnhtbJSRzUrEMBDH&#13;&#10;74LvEOYqbaoHEWm6B6tHFV0fYEimbdg2CZlYd9/edD8u4goeZ+b/8SOpV9tpFDNFtt4puC4rEOS0&#13;&#10;N9b1Cj7WT8UdCE7oDI7ekYIdMayay4t6vQvEIrsdKxhSCvdSsh5oQi59IJcvnY8TpjzGXgbUG+xJ&#13;&#10;3lTVrdTeJXKpSEsGNHVLHX6OSTxu8/pAEmlkEA8H4dKlAEMYrcaUSeXszI+W4thQZudew4MNfJUx&#13;&#10;QP7asFzOFxx9L/lpojUkXjGmZ5wyhjSRJQ8YKGvKv1MWzIkL33VWU9lGfl98J6hz4cZ/uUjzf7Pb&#13;&#10;bHuj+ZQu9z/UfAMAAP//AwBQSwMEFAAGAAgAAAAhADHdX2HSAAAAjwEAAAsAAABfcmVscy8ucmVs&#13;&#10;c6SQwWrDMAyG74O9g9G9cdpDGaNOb4VeSwe7CltJTGPLWCZt376mMFhGbzvqF/o+8e/2tzCpmbJ4&#13;&#10;jgbWTQuKomXn42Dg63xYfYCSgtHhxJEM3Elg372/7U40YalHMvokqlKiGBhLSZ9aix0poDScKNZN&#13;&#10;zzlgqWMedEJ7wYH0pm23Ov9mQLdgqqMzkI9uA+p8T9X8hx28zSzcl8Zy0Nz33r6iasfXeKK5UjAP&#13;&#10;VAy4LM8w09zU50C/9q7/6ZURE31X/kL8TKv1x6wXNXYPAAAA//8DAFBLAwQUAAYACAAAACEAMy8F&#13;&#10;nkEAAAA5AAAAEAAAAGRycy9zaGFwZXhtbC54bWyysa/IzVEoSy0qzszPs1Uy1DNQUkjNS85PycxL&#13;&#10;t1UKDXHTtVBSKC5JzEtJzMnPS7VVqkwtVrK34+UCAAAA//8DAFBLAwQUAAYACAAAACEAUnnhMMIA&#13;&#10;AADaAAAADwAAAGRycy9kb3ducmV2LnhtbESPQWvCQBSE74X+h+UJ3upG0dJGVykFqQcvxl5ye2Rf&#13;&#10;k5i8tyG7avz3riD0OMzMN8xqM3CrLtT72omB6SQBRVI4W0tp4Pe4ffsA5QOKxdYJGbiRh8369WWF&#13;&#10;qXVXOdAlC6WKEPEpGqhC6FKtfVERo5+4jiR6f65nDFH2pbY9XiOcWz1LknfNWEtcqLCj74qKJjuz&#13;&#10;gWzOpxk3+ZkXe8yGn3zanNzWmPFo+FqCCjSE//CzvbMGPuFxJd4Avb4DAAD//wMAUEsBAi0AFAAG&#13;&#10;AAgAAAAhAPD3irv9AAAA4gEAABMAAAAAAAAAAAAAAAAAAAAAAFtDb250ZW50X1R5cGVzXS54bWxQ&#13;&#10;SwECLQAUAAYACAAAACEAMd1fYdIAAACPAQAACwAAAAAAAAAAAAAAAAAuAQAAX3JlbHMvLnJlbHNQ&#13;&#10;SwECLQAUAAYACAAAACEAMy8FnkEAAAA5AAAAEAAAAAAAAAAAAAAAAAApAgAAZHJzL3NoYXBleG1s&#13;&#10;LnhtbFBLAQItABQABgAIAAAAIQBSeeEwwgAAANoAAAAPAAAAAAAAAAAAAAAAAJgCAABkcnMvZG93&#13;&#10;bnJldi54bWxQSwUGAAAAAAQABAD1AAAAhwMAAAAA&#13;&#10;">
  <v:textbox inset="3.6pt,.72pt,3.6pt,.72pt">
   <![if !mso]>
   <table cellpadding=0 cellspacing=0 width="100%">
    <tr>
     <td><![endif]>
     <div>
     <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][25].ToString().Substring(8,1)%><o:p></o:p></span></p>
     </div>
     <![if !mso]></td>
    </tr>
   </table>
   <![endif]></v:textbox>
 </v:rect><v:rect id="<%=i*10 %>" o:spid="_x0000_s1036" style='position:absolute;
  left:19555;width:2184;height:2190;visibility:visible' o:gfxdata="UEsDBBQABgAIAAAAIQDw94q7/QAAAOIBAAATAAAAW0NvbnRlbnRfVHlwZXNdLnhtbJSRzUrEMBDH&#13;&#10;74LvEOYqbaoHEWm6B6tHFV0fYEimbdg2CZlYd9/edD8u4goeZ+b/8SOpV9tpFDNFtt4puC4rEOS0&#13;&#10;N9b1Cj7WT8UdCE7oDI7ekYIdMayay4t6vQvEIrsdKxhSCvdSsh5oQi59IJcvnY8TpjzGXgbUG+xJ&#13;&#10;3lTVrdTeJXKpSEsGNHVLHX6OSTxu8/pAEmlkEA8H4dKlAEMYrcaUSeXszI+W4thQZudew4MNfJUx&#13;&#10;QP7asFzOFxx9L/lpojUkXjGmZ5wyhjSRJQ8YKGvKv1MWzIkL33VWU9lGfl98J6hz4cZ/uUjzf7Pb&#13;&#10;bHuj+ZQu9z/UfAMAAP//AwBQSwMEFAAGAAgAAAAhADHdX2HSAAAAjwEAAAsAAABfcmVscy8ucmVs&#13;&#10;c6SQwWrDMAyG74O9g9G9cdpDGaNOb4VeSwe7CltJTGPLWCZt376mMFhGbzvqF/o+8e/2tzCpmbJ4&#13;&#10;jgbWTQuKomXn42Dg63xYfYCSgtHhxJEM3Elg372/7U40YalHMvokqlKiGBhLSZ9aix0poDScKNZN&#13;&#10;zzlgqWMedEJ7wYH0pm23Ov9mQLdgqqMzkI9uA+p8T9X8hx28zSzcl8Zy0Nz33r6iasfXeKK5UjAP&#13;&#10;VAy4LM8w09zU50C/9q7/6ZURE31X/kL8TKv1x6wXNXYPAAAA//8DAFBLAwQUAAYACAAAACEAMy8F&#13;&#10;nkEAAAA5AAAAEAAAAGRycy9zaGFwZXhtbC54bWyysa/IzVEoSy0qzszPs1Uy1DNQUkjNS85PycxL&#13;&#10;t1UKDXHTtVBSKC5JzEtJzMnPS7VVqkwtVrK34+UCAAAA//8DAFBLAwQUAAYACAAAACEAf5ptXcMA&#13;&#10;AADbAAAADwAAAGRycy9kb3ducmV2LnhtbESPMW/CQAyF90r8h5OR2MoF1FZVyoFQJdQOXRpY2Kyc&#13;&#10;SUJiX5Q7IPz7eqjEZus9v/d5tRm5M1caYhPEwWKegSEpg2+kcnDY757fwcSE4rELQg7uFGGznjyt&#13;&#10;MPfhJr90LVJlNERijg7qlPrc2ljWxBjnoSdR7RQGxqTrUFk/4E3DubPLLHuzjI1oQ409fdZUtsWF&#13;&#10;HRQvfF5ye7zw6w8W49dx0Z7DzrnZdNx+gEk0pof5//rbK77S6y86gF3/AQAA//8DAFBLAQItABQA&#13;&#10;BgAIAAAAIQDw94q7/QAAAOIBAAATAAAAAAAAAAAAAAAAAAAAAABbQ29udGVudF9UeXBlc10ueG1s&#13;&#10;UEsBAi0AFAAGAAgAAAAhADHdX2HSAAAAjwEAAAsAAAAAAAAAAAAAAAAALgEAAF9yZWxzLy5yZWxz&#13;&#10;UEsBAi0AFAAGAAgAAAAhADMvBZ5BAAAAOQAAABAAAAAAAAAAAAAAAAAAKQIAAGRycy9zaGFwZXht&#13;&#10;bC54bWxQSwECLQAUAAYACAAAACEAf5ptXcMAAADbAAAADwAAAAAAAAAAAAAAAACYAgAAZHJzL2Rv&#13;&#10;d25yZXYueG1sUEsFBgAAAAAEAAQA9QAAAIgDAAAAAA==&#13;&#10;">
  <v:textbox inset="3.6pt,.72pt,3.6pt,.72pt">
   <![if !mso]>
   <table cellpadding=0 cellspacing=0 width="100%">
    <tr>
     <td><![endif]>
     <div>
     <p class=MsoNormal><span style='mso-ansi-language:EN-US'><%=dt_total.Rows[i][25].ToString().Substring(9,1)%><o:p></o:p></span></p>
     </div>
     <![if !mso]></td>
    </tr>
   </table>
   <![endif]></v:textbox>
 </v:rect></v:group><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
position:relative;z-index:-1'><span style='left:0px;position:absolute;
left:250px;top:-1px;width:234px;height:29px'><img width=234 height=29
src="rpt_01_TBH_dorco_files/image001.gif" v:shapes="Group_x0020_11 _x0030_ _x0031_ _x0032_ _x0033_ _x0034_ _x0035_ _x0036_ _x0037_ _x0038_ _x0039_"></span></span><![endif]><b><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'><span style='mso-tab-count:4'>                                   </span><span
style='mso-spacerun:yes'> </span></span></b><span class=SpellE><b><u><span
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
EN-US'>Số</span></u></b></span><b><u><span style='mso-bidi-font-size:14.0pt;
font-family:"Times New Roman";mso-ansi-language:EN-US'> <span class=SpellE>sổ</span></span></u></b><b><span
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
EN-US'>:<o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt'><span lang=VI style='mso-bidi-font-size:
14.0pt;font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><u><span
lang=VI style='font-size:12.0pt;font-family:"Times New Roman"'>A. NGƯỜI LAO
ĐỘNG:<o:p></o:p></span></u></b></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify;tab-stops:386.95pt'><span
lang=PT-BR style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'>1. Họ và tên: <b style='mso-bidi-font-weight:normal'><%= dt_total.Rows[i][0].ToString()%> </b>(<%= dt_total.Rows[i][1].ToString()%>)<span
style='mso-tab-count:1'>                                                </span>Nam<span
style='mso-spacerun:yes'>   </span></span><span lang=PT-BR style='font-size:
12.0pt;font-family:"Wingdings 2";mso-ascii-font-family:"Times New Roman";
mso-hansi-font-family:"Times New Roman";mso-ansi-language:PT-BR;mso-char-type:
symbol;mso-symbol-font-family:"Wingdings 2"'><span style='mso-char-type:symbol;
mso-symbol-font-family:"Wingdings 2"'><% if (dt_total.Rows[i][2].ToString()=="X") 
                                                Response.Write("T");
                                         else
                                                Response.Write("£");
                                         %></span></span><span lang=PT-BR
style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:PT-BR'><span
style='mso-spacerun:yes'>   </span>Nữ<span style='mso-spacerun:yes'>  </span></span><span
lang=PT-BR style='font-size:12.0pt;font-family:"Wingdings 2";mso-ascii-font-family:
"Times New Roman";mso-hansi-font-family:"Times New Roman";mso-ansi-language:
PT-BR;mso-char-type:symbol;mso-symbol-font-family:"Wingdings 2"'><span
style='mso-char-type:symbol;mso-symbol-font-family:"Wingdings 2"'><% if (dt_total.Rows[i][3].ToString()=="X") 
                                                Response.Write("T");
                                         else
                                                Response.Write("£");
                                         %></span></span><span
lang=PT-BR style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify;tab-stops:250.7pt 386.95pt'><span
lang=PT-BR style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'>2. Ngày tháng năm sinh: <%= dt_total.Rows[i][4].ToString()%><span style='mso-tab-count:1'>                                   </span>Dân
tộc: <%= dt_total.Rows[i][5].ToString()%> <span style='mso-tab-count:1'>                        </span>Quốc
tịch: <%= dt_total.Rows[i][6].ToString()%><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span
lang=PT-BR style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'>3. Nguyên quán: <%= dt_total.Rows[i][7].ToString()%>.<o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=SV
style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:SV'>4.
Nơi cư trú (Thường trú hay tạm trú): </span><span lang=SV style='font-size:
12.0pt;mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
SV'><%= dt_total.Rows[i][8].ToString()%></span><span lang=SV style='font-size:12.0pt;
font-family:"Times New Roman";mso-ansi-language:SV'><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify;tab-stops:250.7pt 386.95pt'><span
lang=SV style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:
SV'>5. Giấy CMND số: <%= dt_total.Rows[i][9].ToString()%><span style='mso-tab-count:1'>                                  </span>Nơi
cấp: <%= dt_total.Rows[i][10].ToString()%><span style='mso-tab-count:1'>               </span>Ngày cấp:
<%= dt_total.Rows[i][11].ToString()%><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=FR
style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:FR'>6.
Hợp đồng lao động (hoặc hợp đồng làm việc): Số <%= dt_total.Rows[i][12].ToString()%> <span style='mso-tab-count:1'>               </span>Ngày <%= dt_total.Rows[i][13].ToString()%><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=FR
style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:FR'>có
hiệu lực từ ngày <% if (dt_total.Rows[i][13].ToString() != "") Response.Write(dt_total.Rows[i][13].ToString().Substring(0,2).ToString());%> tháng <% if (dt_total.Rows[i][13].ToString() != "") Response.Write(dt_total.Rows[i][13].ToString().Substring(3,2).ToString());%> năm <% if (dt_total.Rows[i][13].ToString() != "") Response.Write(dt_total.Rows[i][13].ToString().Substring(6,4).ToString());%>.<span style='mso-tab-count:2'>               </span></span><span
lang=FR style='font-size:12.0pt;mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:FR'>Loại hợp đồng: <%= dt_total.Rows[i][14].ToString()%></span><span lang=FR
style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:FR'><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=FR
style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:FR'>7.
Chức vụ, chức danh nghề: <%= dt_total.Rows[i][15].ToString()%><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=FR
style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:FR'>8.
Cơ quan, đơn vị: <%= dt_total.Rows[i][16].ToString()%><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=FR
style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:FR'>9.
Địa chỉ: <%= dt_total.Rows[i][17].ToString()%><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=SV
style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:SV'>10.
Nơi đăng ký khám chữa bệnh ban đầu: <%= dt_total.Rows[i][18].ToString()%>.<o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=SV
style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:SV'>11.
Đối tượng hưởng BHYT mức </span><span lang=SV style='font-size:12.0pt;
font-family:Wingdings;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
"Times New Roman";mso-ansi-language:SV;mso-char-type:symbol;mso-symbol-font-family:
Wingdings'><span style='mso-char-type:symbol;mso-symbol-font-family:Wingdings'>o</span></span><span
lang=SV style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:
SV'><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:3.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=IT
style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:IT'>12.
Quá trình đóng, chưa hưởng BHXH một lần và BH thất nghiệp<o:p></o:p></span></p>

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
  bold'><%= dt_total.Rows[i][20].ToString()%><o:p></o:p></span></p>
  </td>
  <td width="10%" valign=top style='width:10.9%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><span lang=IT style='font-size:
  10.0pt;font-family:"Times New Roman";mso-ansi-language:IT;mso-bidi-font-weight:
  bold'><%= dt_total.Rows[i][21].ToString()%></span><b><span lang=IT style='mso-bidi-font-size:14.0pt;
  font-family:"Times New Roman";mso-ansi-language:IT'><o:p></o:p></span></b></p>
  </td>
  <td width="27%" valign=top style='width:27.68%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><span lang=IT style='font-size:
  10.0pt;font-family:"Times New Roman";mso-ansi-language:IT;mso-bidi-font-weight:
  bold'><%= dt_total.Rows[i][15].ToString()%> – <%= dt_total.Rows[i][16].ToString()%><o:p></o:p></span></p>
  </td>
  <td width="10%" valign=top style='width:10.92%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.75pt 0in 5.75pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
  0in;margin-left:0in;margin-bottom:.0001pt'><span lang=IT style='font-size:
  10.0pt;font-family:"Times New Roman";mso-ansi-language:IT;mso-bidi-font-weight:
  bold'><%= dt_total.Rows[i][22].ToString()%><o:p></o:p></span></p>
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
  bold'><%= dt_total.Rows[i][17].ToString()%><o:p></o:p></span></p>
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
 <tr style='mso-yfti-irow:9'>
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
 <tr style='mso-yfti-irow:10'>
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
 <tr style='mso-yfti-irow:11;mso-yfti-lastrow:yes'>
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
<%
		}	//ket thuc in mat truoc hoac 2 mat
		if (rpt_type == "2")	//in 2 mat
		{
%>
<b><span lang=PT-BR style='font-size:12.0pt;font-family:"Times New Roman";
mso-fareast-font-family:"Times New Roman";mso-ansi-language:PT-BR;mso-fareast-language:
VI;mso-bidi-language:AR-SA'><br clear=all style='page-break-before:always'>
</span></b>
<%
		}
		if (rpt_type != "0")	//in mat sau hoac 2 mat
		{
%>
<p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify'><i><u><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'>Cam kết</span></u></i><span lang=PT-BR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'>: Những nội dung kê khai trên là hoàn toàn đúng sự thực, nếu sai tôi xin
hoàn toàn chịu trách nhiệm trước pháp luật.<o:p></o:p></span></p>

<p class=MsoNormal align=right style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:right'><i><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'><%=dt_total.Rows[i][23].ToString() %>, ngày 01 tháng <%if (dt_total.Rows[i][21].ToString()!= "") 
                                        Response.Write(dt_total.Rows[i][21].ToString().Substring(0,2));
                                    %> năm <%if (dt_total.Rows[i][21].ToString()!= "") 
                                        Response.Write(dt_total.Rows[i][21].ToString().Substring(3,4));
                                    %><o:p></o:p></span></i></p>

<p class=MsoNormal align=right style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:right'><b><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'>Người khai<span style='mso-tab-count:1'>       </span><o:p></o:p></span></b></p>

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

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal align=right style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:right'><b><span
lang=PT-BR style='font-size:15.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><%=dt_total.Rows[i][24].ToString() %><o:p></o:p></span></b></p>

<p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><b><span
lang=PT-BR style='font-size:15.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt'><b><u><span lang=PT-BR
style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:PT-BR'>B.
XÁC NHẬN CỦA NGƯỜI SỬ DỤNG LAO ĐỘNG:<o:p></o:p></span></u></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=PT-BR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'>Cơ quan, đơn vị, tổ chức <%=dt_total.Rows[i][16].ToString() %> sau khi kiểm tra, đối
chiếu hồ sơ gốc của Ông (Bà) <%=dt_total.Rows[i][24].ToString() %>. Xác nhận các nội dung kê khai
trên là đúng.<o:p></o:p></span></p>

<p class=MsoNormal align=right style='margin-top:6.0pt;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:right'><span
class=spelle><i><span lang=PT-BR style='mso-bidi-font-size:14.0pt;mso-ansi-language:
PT-BR'><%=dt_total.Rows[i][23].ToString() %></span></i></span><i><span lang=PT-BR style='mso-bidi-font-size:
14.0pt;font-family:"Times New Roman";mso-ansi-language:PT-BR'>, <span
class=spelle>ngày</span> 01 <span class=spelle>tháng</span> <%if (dt_total.Rows[i][21].ToString()!= "") 
                                        Response.Write(dt_total.Rows[i][21].ToString().Substring(0,2));
                                    %> <span
class=spelle>năm</span><%if (dt_total.Rows[i][21].ToString()!= "") 
                                        Response.Write(dt_total.Rows[i][21].ToString().Substring(3,4));
                                    %><o:p></o:p></span></i></p>

<p class=MsoNormal align=right style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:right'><span
class=SpellE><span class=spelle><b><span style='mso-bidi-font-size:14.0pt;
mso-ansi-language:EN-US'>Người</span></b></span></span><b><span
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
EN-US'> <span class=SpellE><span class=spelle>sử</span></span> <span
class=SpellE><span class=spelle>dụng</span></span> <span class=SpellE><span
class=GramE><span class=spelle>lao</span></span></span> <span class=SpellE><span
class=spelle>động</span></span><o:p></o:p></span></b></p>

<p class=MsoNormal align=right style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:right'><span
class=spelle><b><span style='mso-bidi-font-size:14.0pt;mso-ansi-language:EN-US'>(<span
class=SpellE>Ký</span> <span class=SpellE>và</span> <span class=SpellE>đóng</span>
<span class=SpellE>dấu</span>)</span></b></span><span lang=VI style='font-family:
"Times New Roman"'><o:p></o:p></span></p>

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
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
EN-US'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><u><span
lang=PT-BR style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'>C. XÁC NHẬN CỦA CƠ QUAN BẢO HIỂM XÃ HỘI:<o:p></o:p></span></u></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify;text-indent:27.25pt'><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'>Bảo hiểm xã hội tỉnh <%=dt_total.Rows[i][23].ToString() %> sau khi kiểm tra,
đối chiếu với hồ sơ gốc của cá nhân Ông (Bà) <%=dt_total.Rows[i][24].ToString() %> xác nhận các nội
dung kê khai trên là đúng.<o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;tab-stops:70.85pt 261.6pt'><b><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'><span style='mso-tab-count:1'>                </span>Cán
bộ thẩm định<span style='mso-tab-count:1'>                      </span></span></b><i><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'>............, ngày ....... tháng ....... năm 20.....<o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;tab-stops:70.85pt 332.45pt'><b><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'><span style='mso-tab-count:2'>                                                                                      </span>Giám
đốc BHXH</span></b><i><span lang=PT-BR style='mso-bidi-font-size:14.0pt;
font-family:"Times New Roman";mso-ansi-language:PT-BR'><o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;tab-stops:70.85pt 332.45pt'><b><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'><span style='mso-tab-count:2'>                                                                                      </span>(Ký
và đóng dấu)</span></b><i><span lang=PT-BR style='mso-bidi-font-size:14.0pt;
font-family:"Times New Roman";mso-ansi-language:PT-BR'><o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=PT-BR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=PT-BR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=PT-BR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><i><u><span
lang=PT-BR style='font-size:9.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><o:p><span style='text-decoration:none'>&nbsp;</span></o:p></span></u></i></p>

<p class=MsoNormal style='margin-right:5.6pt;text-align:justify'><span
lang=PT-BR style='font-family:"Times New Roman";mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:46.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=PT-BR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><span style='mso-spacerun:yes'>     </span><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:46.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=PT-BR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><span style='mso-spacerun:yes'>     </span><o:p></o:p></span></p>

<p class=MsoNormal style='margin-right:5.6pt;text-align:justify'><span
lang=PT-BR style='font-family:"Times New Roman";mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></p>
<%
		}	//ket thuc in mat sau hoac 2 mat
		if (i == irow-1) 
		{
%>
<p class=MsoNormal style='margin-right:5.6pt;text-align:justify'><span
lang=PT-BR style='mso-ansi-language:PT-BR;mso-special-character:line-break;
page-break-before:always'><o:p>&nbsp;</o:p></span></p>
<%  	} 
		else
		{   
%>
<b><span lang=PT-BR style='font-size:12.0pt;font-family:"Times New Roman";
mso-fareast-font-family:"Times New Roman";mso-ansi-language:PT-BR;mso-fareast-language:
VI;mso-bidi-language:AR-SA'><br clear=all style='page-break-before:always'>
</span></b>
<%  	} 
	}
%>
</div>

</body>

</html>
