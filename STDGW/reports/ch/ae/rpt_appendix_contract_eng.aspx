<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
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
    emp_pk = Request["emp_pk"].ToString();
    string SQL
    = "select a.FULL_FNAME as full_name1 " +
        ",(select CODE_FNM from vhr_hr_code where id='HR0009' and code=a.NATION) as nation2 " +
        ",(case when length(a.BIRTH_DT)=8 then  substr(a.BIRTH_DT,7,2) end ) as birthdate3 " +
        ",(case when length(a.BIRTH_DT)=8 then  substr(a.BIRTH_DT,5,2) end ) as birthmonth4 " +
        ",substr(a.BIRTH_DT,1,4) as birthyear5 " +
        ",(select CODE_NM from vhr_hr_code where id='HR0021' and code=a.PLACE_BIRTH ) as place_birth6 " +
        ",(select CODE_NM from vhr_hr_code where id='HR0010' and code=a.JOB_TYPE) as JOB_TYPE7 " +
        ",a.PERMANENT_ADDR as permanent_add8 " +
        ",a.PERSON_ID as person_id9 " +
        ",to_char(to_date(a.ISSUE_DT,'yyyymmdd'),'dd/mm/yyyy')   as issuedate10 " +
        ",(select CODE_NM from vhr_hr_code where id='HR0014' and code=a.PLACE_PER_ID ) as place_persion11 " +
        ",a.SOCIAL_NO as social_no12 " +
        ",(case when length(a.social_dt)=8 then to_char(to_date(a.SOCIAL_DT,'yyyymmdd'),'dd/mm/yyyy') end) as social_dt13 " +
        ",(select CODE_NM from vhr_hr_code where id='HR0013' and code=a.SOCIAL_PLACE ) as SOCIAL_PLACE14 " +
        ",b.CONTRACT_NO as contract_no15 " +
        ",to_char(to_date(c.BEGIN_CONTRACT,'yyyymmdd'),'fmdd-Mon-yyyy') as begin_contract16 " +
        ",to_char(nvl(c.BASIC_SAL,0) + nvl(c.allow_amt1,0) + nvl(c.allow_amt2,0)+ nvl(c.allow_amt3,0)+ nvl(c.allow_amt4,0)+ nvl(c.allow_amt5,0)+ nvl(c.allow_amt6,0)+ nvl(c.allow_amt7,0)+ nvl(c.allow_amt8,0) ,'99,999,999') as basic_sal17 " +
        ",to_char(nvl(b.BASIC_SAL,0) + nvl(b.allow_amt1,0) + nvl(b.allow_amt2,0)+ nvl(b.allow_amt3,0)+ nvl(b.allow_amt4,0)+ nvl(b.allow_amt5,0)+ nvl(b.allow_amt6,0)+ nvl(b.allow_amt7,0)+ nvl(b.allow_amt8,0),'99,999,999') as basic_sal18 " +
        ",b.APPENDIX_NO as appendix_no19 " +
        ",(case when length(b.signature_date)=8 then  to_char(to_date(b.signature_date,'yyyymmdd'),'fmddth')  end ) as signaturedate20 " +
        ",(case when length(b.signature_date)=8 then  to_char(to_date(b.signature_date,'yyyymmdd'),'MON')  end ) as signaturemonth21 " +
        ",substr(b.signature_date,1,4) as signatureyear22 " +
        ",to_char(nvl(c.BASIC_SAL,0) ,'99,999,999') as basic_sal23 " +
        ",to_char(nvl(b.BASIC_SAL,0),'99,999,999') as basic_sal24 " +
        ",to_char(nvl(c.allow_amt1,0)+  nvl(c.allow_amt2,0)+ nvl(c.allow_amt3,0)+ nvl(c.allow_amt4,0)+ nvl(c.allow_amt5,0)+ nvl(c.allow_amt6,0)+ nvl(c.allow_amt7,0)+ nvl(c.allow_amt8,0) ,'99,999,999') as trans25 " +
        ",to_char(nvl(b.allow_amt1,0)+ nvl(b.allow_amt2,0)+ nvl(b.allow_amt3,0)+ nvl(b.allow_amt4,0)+ nvl(b.allow_amt5,0)+ nvl(b.allow_amt6,0)+ nvl(b.allow_amt7,0)+ nvl(b.allow_amt8,0),'99,999,999') as trans26 " +
        ",to_char(nvl(c.allow_amt2,0) ,'99,999,999') as tel27 " +
        ",to_char(nvl(b.allow_amt2,0),'99,999,999') as tel28 " +
        
        "from thr_employee a, thr_appendix_contract b, thr_labour_contract c " +
        "where a.del_if=0 and b.del_if=0 and c.del_if=0 " +
        "and a.pk = c.THR_EMPLOYEE_PK " +
        "and b.THR_EMPLOYEE_PK = c.THR_EMPLOYEE_PK " +
        " and b.contract_no=c.contract_no and b.pk in (" + emp_pk + ")";

   // Response.Write(SQL);
   // Response.End();
    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt_total.Rows.Count;
    if (irow == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    SQL
    = "select code,code_fnm  " +
        "from vhr_hr_code " +
        "where id='HR0036'  ";
    DataTable dt_name = ESysLib.TableReadOpen(SQL);
    int irow_name;
    irow_name = dt_name.Rows.Count;
    if (irow_name < 20)
    {
        Response.Write("There is enough information of HR code Labour Contract Report!");
        Response.End();
    }
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 11">
<meta name=Originator content="Microsoft Word 11">
<link rel=File-List href="rpt_appendix_contract_eng_files/filelist.xml">
<title>C«ng ty TNHH Nichias H¶I Phßng</title>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="place" downloadurl="http://www.5iantlavalamp.com/"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="country-region" downloadurl="http://www.5iantlavalamp.com/"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="PlaceName"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="PlaceType"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="City"/>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>hien-pt</o:Author>
  <o:LastAuthor>Ho Thu Hien</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>71</o:TotalTime>
  <o:LastPrinted>2010-05-12T10:06:00Z</o:LastPrinted>
  <o:Created>2010-05-14T02:15:00Z</o:Created>
  <o:LastSaved>2010-05-14T02:15:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>260</o:Words>
  <o:Characters>1483</o:Characters>
  <o:Lines>12</o:Lines>
  <o:Paragraphs>3</o:Paragraphs>
  <o:CharactersWithSpaces>1740</o:CharactersWithSpaces>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:DrawingGridHorizontalSpacing>9.35 pt</w:DrawingGridHorizontalSpacing>
  <w:DisplayVerticalDrawingGridEvery>2</w:DisplayVerticalDrawingGridEvery>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:Compatibility>
   <w:SelectEntireFieldWithStartOrEnd/>
   <w:UseWord2002TableStyleRules/>
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
	{font-family:"\.VnTime";
	mso-font-alt:"Courier New";
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:3 0 0 0 1 0;}
@font-face
	{font-family:"\.VnTimeH";
	mso-font-alt:"Courier New";
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
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
h1
	{mso-style-next:Normal;
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:1;
	font-size:12.0pt;
	font-family:"\.VnTime";
	mso-font-kerning:0pt;}
h2
	{mso-style-next:Normal;
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:2;
	font-size:12.0pt;
	font-family:"\.VnTime";
	font-style:italic;}
h3
	{mso-style-next:Normal;
	margin:0in;
	margin-bottom:.0001pt;
	text-align:center;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:3;
	font-size:12.0pt;
	font-family:"\.VnTimeH";}
p.MsoHeader, li.MsoHeader, div.MsoHeader
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	tab-stops:center 3.0in right 6.0in;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
p.MsoFooter, li.MsoFooter, div.MsoFooter
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	tab-stops:center 3.0in right 6.0in;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
p.MsoCaption, li.MsoCaption, div.MsoCaption
	{mso-style-noshow:yes;
	mso-style-next:Normal;
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"\.VnTime";
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	font-weight:bold;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-noshow:yes;
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:8.0pt;
	font-family:Tahoma;
	mso-fareast-font-family:"Times New Roman";}
 /* Page Definitions */
 @page
	{mso-footnote-separator:url("rpt_appendix_contract_eng_files/header.htm") fs;
	mso-footnote-continuation-separator:url("rpt_appendix_contract_eng_files/header.htm") fcs;
	mso-endnote-separator:url("rpt_appendix_contract_eng_files/header.htm") es;
	mso-endnote-continuation-separator:url("rpt_appendix_contract_eng_files/header.htm") ecs;}
@page Section1
	{size:595.35pt 842.0pt;
	margin:45.0pt 42.55pt 27.0pt 70.9pt;
	mso-header-margin:14.2pt;
	mso-footer-margin:14.2pt;
	mso-even-footer:url("rpt_appendix_contract_eng_files/header.htm") ef1;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:159086509;
	mso-list-type:hybrid;
	mso-list-template-ids:-228684012 1605394474 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-weight:bold;}
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
@list l1
	{mso-list-id:862667460;
	mso-list-type:hybrid;
	mso-list-template-ids:227196318 114822266 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-number-format:roman-upper;
	mso-level-tab-stop:.75in;
	mso-level-number-position:left;
	margin-left:.75in;
	text-indent:-.5in;}
@list l2
	{mso-list-id:1162814843;
	mso-list-type:hybrid;
	mso-list-template-ids:204474564 67698701 67698691 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l2:level1
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l3
	{mso-list-id:1444418523;
	mso-list-type:hybrid;
	mso-list-template-ids:42886344 -833054512 67698691 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l3:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
@list l4
	{mso-list-id:1936207142;
	mso-list-type:hybrid;
	mso-list-template-ids:1659671046 1080190310 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l4:level1
	{mso-level-number-format:roman-upper;
	mso-level-tab-stop:.75in;
	mso-level-number-position:left;
	margin-left:.75in;
	text-indent:-.5in;}
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
<% 
     
     for (int i = 0; i < irow; i++) 
    {
       
    %> 
<div align=center>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;mso-padding-alt:0in 5.4pt 0in 5.4pt'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes'>
  <td width=269 valign=top style='width:201.75pt;padding:0in 5.4pt 0in 5.4pt'>
  <h1 align=center style='text-align:center'><span style='font-family:"Times New Roman"'><%= dt_name.Rows[4][1].ToString() %><o:p></o:p></span></h1>
  <p class=MsoNormal align=center style='text-align:center'><b>- - - - - ***- -
  - - -<o:p></o:p></b></p>
  <p class=MsoNormal align=center style='text-align:center'><b><o:p>&nbsp;</o:p></b></p>
  <p class=MsoNormal align=center style='text-align:center'><b>No: <%= dt_total.Rows[i][18].ToString() %><o:p></o:p></b></p>
  </td>
  <td width=388 valign=top style='width:290.95pt;padding:0in 5.4pt 0in 5.4pt'>
  <h3><st1:PlaceName w:st="on"><span style='font-family:"Times New Roman"'>SOCIALIST</span></st1:PlaceName><span
  style='font-family:"Times New Roman"'> <st1:PlaceType w:st="on">REPUBLIC</st1:PlaceType>
  OF <st1:country-region w:st="on"><st1:place w:st="on">VIETNAM</st1:place></st1:country-region><o:p></o:p></span></h3>
  <p class=MsoNormal align=center style='text-align:center'><st1:City w:st="on"><st1:place
   w:st="on"><b>Independence</b></st1:place></st1:City><b> - Freedom -
  Happiness<o:p></o:p></b></p>
  <p class=MsoNormal align=center style='text-align:center'><b>- - - - -
  ***<span style='mso-spacerun:yes'>  </span>- - - - -<o:p></o:p></b></p>
  <h2 align=right style='text-align:right'><st1:place w:st="on"><st1:City
   w:st="on"><span style='font-family:"Times New Roman";font-weight:normal;
    mso-bidi-font-weight:bold'>Haiphong</span></st1:City></st1:place><span
  style='font-family:"Times New Roman";font-weight:normal;mso-bidi-font-weight:
  bold'>, <%= dt_total.Rows[i][19].ToString().Substring(0,dt_total.Rows[i][19].ToString().Length-2) %><sup><%= dt_total.Rows[i][19].ToString().Substring(dt_total.Rows[i][19].ToString().Length-2,2) %></sup> <%= dt_total.Rows[i][20].ToString() %>, <%= dt_total.Rows[i][21].ToString() %><o:p></o:p></span></h2>
  </td>
 </tr>
</table>

</div>

<p class=MsoCaption align=center style='text-align:center;line-height:150%'><span
style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoCaption align=center style='text-align:center'><span
style='font-size:16.0pt;mso-bidi-font-size:12.0pt;font-family:"Times New Roman"'>ADDENDUM
TO LABOUR CONTRACT<o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:2.0in'>We, for one part,
Mr.: <b style='mso-bidi-font-weight:normal'><span style='mso-tab-count:1'>             </span><%= dt_name.Rows[1][1].ToString() %> </b><span style='mso-tab-count:2'>               </span><span
style='mso-tab-count:1'>            </span><span style='mso-tab-count:1'>            </span>Nationality:
<st1:country-region w:st="on"><st1:place w:st="on"><%= dt_name.Rows[2][1].ToString() %></st1:place></st1:country-region></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:140.25pt'>Position: <span
style='mso-tab-count:2'>                                  </span><%= dt_name.Rows[3][1].ToString() %></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:140.25pt'>Representing: <span
style='mso-tab-count:2'>                           </span><%= dt_name.Rows[4][1].ToString() %><span style='mso-tab-count:1'>   </span><span style='mso-tab-count:2'>                        </span>Tel:
<%= dt_name.Rows[5][1].ToString() %></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:2.0in'>Address: <span
style='mso-tab-count:1'>                                  </span><%= dt_name.Rows[6][1].ToString() %></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:2.0in 5.0in'>And for the
other part, Ms.: <span style='mso-tab-count:1'>     </span><b style='mso-bidi-font-weight:
normal'><%= dt_total.Rows[i][0].ToString() %> <span style='mso-tab-count:1'>                                              </span></b>Nationality:
<st1:country-region w:st="on"><st1:place w:st="on"><%= dt_total.Rows[i][1].ToString() %></st1:place></st1:country-region><span
style='mso-tab-count:1'>      </span></p>

<p class=MsoNormal style='margin-top:6.0pt'>Date of birth: <span
style='mso-tab-count:2'>               </span><span style='mso-tab-count:1'>            </span><%= dt_total.Rows[i][2].ToString() %>/<%= dt_total.Rows[i][3].ToString() %>/<%= dt_total.Rows[i][4].ToString() %><span
style='mso-tab-count:1'>      </span>at: <st1:City w:st="on"><st1:place w:st="on"><%= dt_total.Rows[i][5].ToString() %></st1:place></st1:City><span
style='mso-tab-count:1'>     </span></p>

<p class=MsoNormal style='margin-top:6.0pt'>Occupation: <span style='mso-tab-count:
3'>                             </span><%= dt_total.Rows[i][6].ToString() %></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:1.0in 1.75in 2.75in 243.0pt 297.0pt'>Address
of permanent resident: <%= dt_total.Rows[i][7].ToString() %></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:1.0in 1.75in 2.75in 243.0pt 297.0pt'>ID
No.: <%= dt_total.Rows[i][8].ToString() %><span style='mso-tab-count:1'>               </span>issued on date:
<%= dt_total.Rows[i][9].ToString() %> <span style='mso-tab-count:1'>               </span>in: <st1:City
w:st="on"><st1:place w:st="on"><%= dt_total.Rows[i][10].ToString() %></st1:place></st1:City></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;text-indent:18.7pt;
line-height:150%'>Pursuant to Labour Contract No.: <%= dt_total.Rows[i][14].ToString() %> signed date <%= dt_total.Rows[i][15].ToString() %>
and the requirement for employment, the tow parties mutually agree to amend a
number of items of the contract signed by both parties as follows:</p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'><b
style='mso-bidi-font-weight:normal'>1. Content of Amendments:</b></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:18.7pt;margin-bottom:.0001pt;text-align:justify;tab-stops:1.0in 1.75in 2.75in 225.0pt 243.0pt 297.0pt 4.75in'>-
The total salary in labour contract is: <%= dt_total.Rows[i][16].ToString() %> VND/ month.</p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:18.7pt;margin-bottom:.0001pt;text-align:justify;tab-stops:1.0in 1.75in 2.75in 225.0pt 243.0pt 297.0pt 4.75in'><span
style='mso-spacerun:yes'>  </span>Amendment is: <%= dt_total.Rows[i][17].ToString() %>&nbsp;VND/ month.</p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:18.7pt;margin-bottom:.0001pt;text-align:justify;tab-stops:1.0in 1.75in 2.75in 225.0pt 243.0pt 297.0pt 4.75in'>-
Basic salary in labour contract: <%= dt_total.Rows[i][22].ToString() %> VND/ month.</p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:18.7pt;margin-bottom:.0001pt;text-align:justify;tab-stops:1.0in 1.75in 2.75in 225.0pt 243.0pt 297.0pt 4.75in'><span
style='mso-spacerun:yes'>  </span>Amendment is: <%= dt_total.Rows[i][23].ToString() %> VND/ month.</p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:18.7pt;margin-bottom:.0001pt;text-align:justify;tab-stops:1.0in 1.75in 2.75in 225.0pt 243.0pt 297.0pt 4.75in'>-
Total allowance in labour contract <%= dt_total.Rows[i][24].ToString() %> VND/ month.</p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:18.7pt;margin-bottom:.0001pt;text-align:justify;tab-stops:1.0in 1.75in 2.75in 225.0pt 243.0pt 297.0pt 4.75in'><span
style='mso-spacerun:yes'>  </span>Amendment is: <%= dt_total.Rows[i][25].ToString() %> VND/ month</p>


<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;tab-stops:1.0in 1.75in 2.75in 225.0pt 243.0pt 297.0pt 4.75in'><b
style='mso-bidi-font-weight:normal'>2. Period of implementation:</b></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;text-indent:18.7pt;
line-height:150%;tab-stops:1.0in 1.75in 2.75in 225.0pt 243.0pt 297.0pt 4.75in'>The
salary above will be changing from date: <%= dt_total.Rows[i][19].ToString().Substring(0,dt_total.Rows[i][19].ToString().Length-2) %><sup><%= dt_total.Rows[i][19].ToString().Substring(dt_total.Rows[i][19].ToString().Length-2,2) %></sup> <%= dt_total.Rows[i][20].ToString() %>, <%= dt_total.Rows[i][21].ToString() %>.</p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;text-indent:18.7pt;
line-height:150%'>This Addendum is part of Labour Contract No. <%= dt_total.Rows[i][14].ToString() %> is
made into two popies of equal validity, one of which shall be kept by each
party and used as the basis for resolution of labour disputes.</p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;text-indent:.5in'><b style='mso-bidi-font-weight:normal'>EMPLOYEE<span
style='mso-spacerun:yes'>   </span><span style='mso-tab-count:4'>                                               </span><span
style='mso-tab-count:2'>                        </span>EMPLOYER<span
style='mso-tab-count:3'>                          </span><o:p></o:p></b></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;line-height:150%'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;line-height:150%'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;line-height:150%;tab-stops:center 74.8pt 364.65pt'><span
style='mso-tab-count:1'>           </span><%= dt_total.Rows[i][0].ToString() %><span
style='mso-tab-count:1'>                                                                    </span><%= dt_name.Rows[1][1].ToString() %><span
style='mso-tab-count:1'>         </span><span
style='mso-spacerun:yes'>                                   </span></p>
<%
     if (i == irow - 1)//nhan vien cuoi cung 
     { 
         %>
 
         <%
     }
     else
     {   
  %>
    
<b><span style='font-size:12.0pt;font-family:"Times New Roman";mso-fareast-font-family:
"Times New Roman";mso-ansi-language:EN-US;mso-fareast-language:EN-US;
mso-bidi-language:AR-SA'><br clear=all style='page-break-before:always'>
</span></b>
<% 
     }
    }
%>
</div>

</body>

</html>
