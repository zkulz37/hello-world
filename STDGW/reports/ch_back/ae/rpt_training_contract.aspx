<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
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
	= "select a.CONTRACT_NO as num0 " +
        ",substr(nvl(a.BEGIN_CONTRACT,a.begin_probation),7,2)  as printdate1 " +
        ",substr(nvl(a.BEGIN_CONTRACT,a.begin_probation),5,2) as printmonth2 " +
        ",substr(nvl(a.BEGIN_CONTRACT,a.begin_probation),1,4) as printyear3 " +
        ",b.FULL_NAME as full_name4 " +
        ",(select CODE_FNM from vhr_hr_code where id='HR0009' and code=b.NATION) as nation5 " +
        ",(case when length(b.BIRTH_DT)=8 then  substr(b.BIRTH_DT,7,2)  end ) as birthdate6 " +
        ",(case when length(b.BIRTH_DT)=8 then substr(b.BIRTH_DT,5,2)  end ) as birthmonth7 " +
        ",substr(b.BIRTH_DT,1,4) as birthyear8 " +
        ",(select CODE_FNM from vhr_hr_code where id='HR0021' and code=b.PLACE_BIRTH ) as place_birth9 " +
        ",b.PERMANENT_ADDR as permanent_add10 " +
        ",b.PERSON_ID as person_id11 " +
        ",to_char(to_date(b.ISSUE_DT,'yyyymmdd'),'dd/mm/yyyy')   as issuedate12 " +
        ",(select CODE_FNM from vhr_hr_code where id='HR0014' and code=b.PLACE_PER_ID ) as place_persion13 " +
        ",'' labour_no14  " +
        ",''  as labourdate15 " +
        ",'' as lb_place16 " +
        ",(select char_2 from vhr_hr_code where id='HR0001' and code=a.CONTRACT_TYPE ) as contract_type17 " +
        ",substr(a.BEGIN_CONTRACT,7,2)  as stcontractdate18 " +
        ",substr(a.BEGIN_CONTRACT,5,2) as stcontractmonth19 " +
        ",substr(a.BEGIN_CONTRACT,1,4) as stcontractyearw20 " +
        ",substr(a.end_CONTRACT,7,2)  as etcontractdate21 " +
        ",substr(a.end_CONTRACT,5,2) as etcontractmonth22 " +
        ",substr(a.end_CONTRACT,1,4) as etcontractyearw23 " +
        ",substr(a.BEGIN_PROBATION,7,2)  as probationdate24 " +
        ",substr(a.BEGIN_PROBATION,5,2) as probationmonth25 " +
        ",substr(a.BEGIN_PROBATION,1,4) as probationyear26 " +
        ",substr(a.end_PROBATION,7,2)  as probationdate27 " +
        ",substr(a.end_PROBATION,5,2) as probationmonth28 " +
        ",substr(a.end_PROBATION,1,4) as probationyear29  " +
        ",(select CODE_FNM from vhr_hr_code where id='HR0008' and code=b.POS_TYPE) as position30 " +
        ",(select remark_code from vhr_hr_code where id='HR0010' and code=b.job_TYPE) as c_job31 " +
        ",to_char(nvl(B.LEVEL1_SAL,0),'99,999,999') as salary32 " +
        ",substr(nvl(a.BEGIN_CONTRACT,a.begin_probation),7,2)  as effectdate33 " +
        ",substr(nvl(a.BEGIN_CONTRACT,a.begin_probation),5,2) as effectmonth34 " +
        ",substr(nvl(a.BEGIN_CONTRACT,a.begin_probation),1,4) as effectyear35 " +
        ",(select char_4 from vhr_hr_code where id='HR0001' and code=a.CONTRACT_TYPE ) as title36 " +
        ",(select CODE_FNM from vhr_hr_code where id='HR0010' and code=b.job_TYPE) as job37 " +
        ", b.MONEY_KIND money_kind38" +
        ",(select code_nm from vhr_hr_code where id='HR0001' and code=a.CONTRACT_TYPE ) as contract_type39 " +
        ",(select CODE_NM from vhr_hr_code where id='HR0008' and code=b.POS_TYPE) as position40 " +
        ",to_char(nvl(B.LEVEL1_SAL,0) ,'99,999,999') as salary41 " +
         ",to_char(nvl(a.ALLOW_AMT1,0),'99,999,999') as salary42 " +
         ",to_char(nvl(a.ALLOW_AMT2,0),'99,999,999') as salary43 " +
        "from thr_labour_contract a,thr_employee b,comm.tco_org c,thr_work_group d  " +
        "where a.del_if=0 and b.del_if=0 and c.del_if=0 and d.del_if=0  " +
        "and b.pk=a.thr_employee_pk " +
        "and c.pk=b.tco_org_PK " +
        "and d.pk=b.thr_wg_pk " +
        "and b.pk in (" + emp_pk + ") " + 
        "and b.CONTRACT_TIMES=a.CONTRACT_TIMES " ;
        
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
    = "select code,code_nm  " +
        "from vhr_hr_code " +
        "where id='HR0036'  ";
    DataTable dt_name = ESysLib.TableReadOpen(SQL);
    int irow_name;
    irow_name = dt_name.Rows.Count;
    /*if (irow_name != 23)
    {
        Response.Write("There is enough information of HR code Labour Contract Report!");
        Response.End();
    }*/
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 11">
<meta name=Originator content="Microsoft Word 11">
<link rel=File-List href="rpt_training_contract_files/filelist.xml">
<title>C«ng ty TNHH Nichias H¶I Phßng</title>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="country-region"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="City"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="place"/>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>hien-pt</o:Author>
  <o:LastAuthor>huynhtruong</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>8</o:TotalTime>
  <o:LastPrinted>2010-02-03T03:01:00Z</o:LastPrinted>
  <o:Created>2010-03-17T08:58:00Z</o:Created>
  <o:LastSaved>2010-03-17T08:58:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>808</o:Words>
  <o:Characters>4609</o:Characters>
  <o:Lines>38</o:Lines>
  <o:Paragraphs>10</o:Paragraphs>
  <o:CharactersWithSpaces>5407</o:CharactersWithSpaces>
  <o:Version>11.6360</o:Version>
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
	panose-1:2 11 114 0 0 0 0 0 0 0;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:3 0 0 0 1 0;}
@font-face
	{font-family:"\.VnTimeH";
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
	{mso-footnote-separator:url("rpt_training_contract_files/header.htm") fs;
	mso-footnote-continuation-separator:url("rpt_training_contract_files/header.htm") fcs;
	mso-endnote-separator:url("rpt_training_contract_files/header.htm") es;
	mso-endnote-continuation-separator:url("rpt_training_contract_files/header.htm") ecs;}
@page Section1
	{size:595.35pt 842.0pt;
	margin:45.0pt 42.55pt 27.0pt 70.9pt;
	mso-header-margin:14.2pt;
	mso-footer-margin:14.2pt;
	mso-even-footer:url("rpt_training_contract_files/header.htm") ef1;
	mso-footer:url("rpt_training_contract_files/header.htm") f1;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:862667460;
	mso-list-type:hybrid;
	mso-list-template-ids:227196318 114822266 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-number-format:roman-upper;
	mso-level-tab-stop:.75in;
	mso-level-number-position:left;
	margin-left:.75in;
	text-indent:-.5in;}
@list l1
	{mso-list-id:1162814843;
	mso-list-type:hybrid;
	mso-list-template-ids:204474564 67698701 67698691 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0FC;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l2
	{mso-list-id:1444418523;
	mso-list-type:hybrid;
	mso-list-template-ids:42886344 -833054512 67698691 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l2:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
@list l3
	{mso-list-id:1936207142;
	mso-list-type:hybrid;
	mso-list-template-ids:1659671046 1080190310 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l3:level1
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
<![endif]-->
</head>

<body lang=EN-US style='tab-interval:.5in'>

<div class=Section1>
<% 
     
     for (int i = 0; i < irow; i++) 
    {
       
    %> 

<p class=MsoNormal align=center style='text-align:center'><o:p>&nbsp;</o:p></p>

<div align=center>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;mso-padding-alt:0in 5.4pt 0in 5.4pt'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes'>
  <td width=306 valign=top style='width:229.8pt;padding:0in 5.4pt 0in 5.4pt'>
  <h1 align=center style='text-align:center'><span style='font-family:"Times New Roman"'>Công
  ty TNHH <%= dt_name.Rows[0][1].ToString() %> <o:p></o:p></span></h1>
  <p class=MsoNormal align=center style='text-align:center'><b><o:p>&nbsp;</o:p></b></p>
  <p class=MsoNormal align=center style='text-align:center'><b>- - - - - ***- -
  - - -<o:p></o:p></b></p>
  <p class=MsoNormal align=center style='text-align:center'><b>S&#7889;: <%= dt_total.Rows[i][0].ToString() %><o:p></o:p></b></p>
  </td>
  <td width=351 valign=top style='width:262.9pt;padding:0in 5.4pt 0in 5.4pt'>
  <h3><span style='font-family:"Times New Roman"'>C&#7896;NG HOÀ XÃ H&#7896;I
  CH&#7910; NGH&#296;A VI&#7878;T <st1:country-region w:st="on"><st1:place
   w:st="on">NAM</st1:place></st1:country-region><o:p></o:p></span></h3>
  <p class=MsoNormal align=center style='text-align:center'><b>&#272;&#7897;c
  l&#7853;p - T&#7921; do - H&#7841;nh phúc<o:p></o:p></b></p>
  <p class=MsoNormal align=center style='text-align:center'><b>- - - - -
  ***<span style='mso-spacerun:yes'>  </span>- - - - -<o:p></o:p></b></p>
  <h2 align=right style='text-align:right'><span style='font-family:"Times New Roman";
  font-weight:normal'>H&#7843;i Phòng, ngày <%= dt_total.Rows[i][24].ToString() %><span style='mso-spacerun:yes'> 
  </span>tháng <%= dt_total.Rows[i][25].ToString() %> n&#259;m <%= dt_total.Rows[i][26].ToString() %><o:p></o:p></span></h2>
  </td>
 </tr>
</table>

</div>

<p class=MsoCaption align=center style='text-align:center;line-height:150%'><span
style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoCaption align=center style='text-align:center'><span
style='font-size:16.0pt;font-family:"Times New Roman"'>H&#7906;P
&#272;&#7890;NG &#272;ÀO T&#7840;O<o:p></o:p></span></p>

<h1 align=center style='text-align:center;line-height:150%'><span
style='font-size:14.0pt;line-height:150%;font-family:"Times New Roman"'>Training
Contract<o:p></o:p></span></h1>

<p class=MsoNormal style='margin-bottom:6.0pt'>Chúng tôi,</p>

<p class=MsoNormal style='margin-bottom:6.0pt'><i>We,<o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt'><b>1. CÔNG TY TNHH <%= dt_name.Rows[0][1].ToString() %><o:p></o:p></b></p>

<p class=MsoNormal style='margin-top:6.0pt'>Do ông:<span
style='mso-spacerun:yes'>  </span><span style='mso-tab-count:1'>         </span><span
style='mso-spacerun:yes'>  </span><b><%= dt_name.Rows[1][1].ToString() %></b><span
style='mso-spacerun:yes'>       </span>TG&#272; làm &#273;&#7841;i di&#7879;n
(sau &#273;ây g&#7885;i “Ng&#432;&#7901;i s&#7917; d&#7909;ng lao
&#273;&#7897;ng”)</p>

<p class=MsoNormal><i>Represented by:<span style='mso-tab-count:3'>                                   </span><span
style='mso-spacerun:yes'>       </span>General Director</i> <i>(hereinafter
called </i>“<i>Employer</i>”<i>)</i></p>

<p class=MsoNormal style='margin-top:6.0pt'><b>2. Và Anh/ Ch&#7883;: <span
style='mso-tab-count:1'>        </span><%= dt_total.Rows[i][4].ToString() %></b><span
style='mso-spacerun:yes'>      </span>(sau &#273;ây &#273;&#432;&#7907;c
g&#7885;i là “H&#7885;c viên”)</p>

<p class=MsoNormal><i>And the other half <span style='mso-tab-count:3'>                               </span><span
style='mso-spacerun:yes'>        </span>(hereinafter called </i>“<i>Trainee</i>”<i>)<o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt'>- &#272;&#7883;a ch&#7881;:<span
style='mso-spacerun:yes'>  </span><span style='mso-tab-count:2'>                   </span><%= dt_total.Rows[i][10].ToString() %></p>

<p class=MsoNormal><i><span style='mso-spacerun:yes'>  </span>Address: <o:p></o:p></i></p>

<p class=MsoNormal>- Ngày sinh: <span style='mso-tab-count:2'>                </span><%= dt_total.Rows[i][6].ToString() + "/" +dt_total.Rows[i][7].ToString() +"/" + dt_total.Rows[i][8].ToString() %></p>

<p class=MsoNormal><i><span style='mso-spacerun:yes'>  </span>Date of birth<o:p></o:p></i></p>

<p class=MsoNormal style='tab-stops:2.0in 271.15pt'>- CMND s&#7889;:<span
style='mso-spacerun:yes'>  </span><%= dt_total.Rows[i][11].ToString()%><span style='mso-spacerun:yes'>      
</span><span style='mso-tab-count:1'>               </span>c&#7845;p ngày<span
style='mso-spacerun:yes'>  </span><%= dt_total.Rows[i][12].ToString()%><span style='mso-tab-count:1'>               </span>n&#417;i
c&#7845;p<span style='mso-spacerun:yes'>  </span><%= dt_total.Rows[i][13].ToString()%></p>

<p class=MsoNormal><i><span style='mso-spacerun:yes'>   </span>ID card No: <span
style='mso-tab-count:3'>                         </span><span
style='mso-spacerun:yes'> </span>issue d date<span style='mso-tab-count:2'>                 </span><span
style='mso-spacerun:yes'>       </span>issued place <o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in'>Hai bên tho&#7843; thu&#7853;n ký k&#7871;t và &#273;&#7891;ng
cam k&#7871;t th&#7921;c hi&#7879;n &#273;úng các &#273;i&#7873;u kho&#7843;n
sau:</p>

<p class=MsoNormal style='margin-bottom:6.0pt'><i>Agreed to sign this labor
contract and engage to satisfy the following provisions:<o:p></o:p></i></p>

<p class=MsoNormal><b>&#272;i&#7873;u I: <span style='mso-tab-count:1'>           </span>Th&#7901;i
h&#7841;n và &#273;&#7883;a &#273;i&#7875;m &#273;ào t&#7841;o:<o:p></o:p></b></p>

<p class=MsoNormal style='margin-bottom:6.0pt'><b><i>Article I: <span
style='mso-tab-count:1'>         </span>Term and Place:<o:p></o:p></i></b></p>

<p class=MsoNormal style='margin-bottom:6.0pt'>Th&#7901;i gian &#273;ào
t&#7841;o 6 tháng: <span style='mso-tab-count:1'>     </span>t&#7915; ngày <%= dt_total.Rows[i][24].ToString() + "/" + dt_total.Rows[i][25].ToString() +"/" + dt_total.Rows[i][26].ToString()%>
&#273;&#7871;n ngày <%= dt_total.Rows[i][27].ToString() + "/" + dt_total.Rows[i][28].ToString() +"/" + dt_total.Rows[i][29].ToString()%></p>

<p class=MsoNormal style='margin-bottom:6.0pt'><i>Term of contract 6 months: <span
style='mso-tab-count:1'>    </span>from date<span style='mso-tab-count:1'>         </span><span
style='mso-spacerun:yes'>        </span>to date<o:p></o:p></i></p>

<p class=MsoNormal style='margin-bottom:6.0pt'>&#272;&#7883;a &#273;i&#7875;m
&#273;ào t&#7841;o: <span style='mso-tab-count:1'>       </span>T&#7893;
h&#7907;p khu Resort Sông Giá, L&#432;u Ki&#7871;m, Thu&#7927; Nguyên,
H&#7843;i Phòng. </p>

<p class=MsoNormal style='margin-bottom:6.0pt'><i>Training place: <span
style='mso-tab-count:1'>           </span>Song Gia Resort, Luu Kiem, Thuy
Nguyen, <st1:City w:st="on"><st1:place w:st="on">Haiphong</st1:place></st1:City><o:p></o:p></i></p>

<p class=MsoNormal style='margin-bottom:6.0pt'>N&#7897;i dung &#273;ào
t&#7841;o:<span style='mso-tab-count:1'>       </span>&#272;ào t&#7841;o
k&#7929; n&#259;ng ph&#7909;c v&#7909; ng&#432;&#7901;i ch&#417;i Gôn.</p>

<p class=MsoNormal style='margin-bottom:6.0pt;tab-stops:.5in 1.0in 1.5in 2.0in 2.5in 3.0in center 240.95pt'><i>Content
of training:<span style='mso-tab-count:1'>     </span>Caddie training<o:p></o:p></i></p>

<p class=MsoNormal style='margin-bottom:6.0pt'>Th&#7901;i gian &#273;ào
t&#7841;o: <span style='mso-tab-count:1'>      </span>8 ti&#7871;ng/ngày<span
style='mso-tab-count:1'>    </span>48 ti&#7871;ng/tu&#7847;n</p>

<p class=MsoNormal style='margin-bottom:6.0pt'><i>Training time:<span
style='mso-tab-count:2'>             </span>8 hours/day<span style='mso-tab-count:
1'>     </span>48 hours/week<o:p></o:p></i></p>

<p class=MsoNormal style='margin-bottom:6.0pt'><b>&#272;i&#7873;u II: <span
style='mso-tab-count:1'>          </span>N&#7897;i dung &#273;ào t&#7841;o:<o:p></o:p></b></p>

<p class=MsoNormal style='margin-bottom:6.0pt'><b><i>Article II: <span
style='mso-tab-count:1'>       </span>Training content:<o:p></o:p></i></b></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'>-
H&#7885;c viên s&#7869; &#273;&#432;&#7907;c h&#7885;c k&#7929; n&#259;ng
ph&#7909;c v&#7909; ng&#432;&#7901;i ch&#417;i Gôn.</p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify'><i><span
style='mso-spacerun:yes'>  </span>The trainee shall get training on Caddie
performance.<o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'>-
D&#7909;ng c&#7909; làm vi&#7879;c: trong th&#7901;i gian h&#7885;c vi&#7879;c
h&#7885;c viên &#273;&#432;&#7907;c phát các v&#7853;t d&#7909;ng c&#7847;n
thi&#7871;t theo yêu c&#7847;u công vi&#7879;c.</p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify'><i>Equipment
to be provided: stationary and other necessary equipment required by the
assigned work.<o:p></o:p></i></p>

<p class=MsoNormal style='margin-bottom:6.0pt'><b><o:p>&nbsp;</o:p></b></p>

<p class=MsoNormal style='margin-bottom:6.0pt'><b>&#272;i&#7873;u III: <span
style='mso-tab-count:1'>        </span>Ngh&#297;a v&#7909; và quy&#7873;n
l&#7907;i:<o:p></o:p></b></p>

<p class=MsoNormal style='margin-bottom:6.0pt'><b><i>Article III: <span
style='mso-tab-count:1'>      </span>Obligations and benefits of the Employee<o:p></o:p></i></b></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;line-height:150%'><b>I. Quy&#7873;n l&#7907;i/ <i>Benefits</i>:<o:p></o:p></b></p>

<p class=MsoNormal style='margin-bottom:6.0pt'>- Ph&#432;&#417;ng ti&#7879;n
&#273;i l&#7841;i: theo chính sách công ty</p>

<p class=MsoNormal style='margin-bottom:6.0pt'><i><span
style='mso-spacerun:yes'> </span>Means of transport for working: as company
policy<o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt'>- L&#432;&#417;ng c&#417;
b&#7843;n: <span style='mso-tab-count:1'>         </span><b><%= dt_total.Rows[i][41].ToString() %> VN&#272;/tháng </b></p>

<p class=MsoNormal style='margin-bottom:6.0pt'><i><span
style='mso-spacerun:yes'>   </span>Basic salary<o:p></o:p></i></p>

<p class=MsoNormal style='margin-bottom:6.0pt'>- Thanh toán: h&#7885;c viên
s&#7869; &#273;&#432;&#7907;c thanh toán l&#432;&#417;ng vào ngày 25 hàng
tháng.</p>

<p class=MsoNormal style='margin-bottom:6.0pt'><i><span
style='mso-spacerun:yes'>   </span>Payment: </i><i><span style='font-size:13.0pt'><span
style='mso-spacerun:yes'> </span>trainee’s salary shall be paid once on every
25<sup>th</sup> of month<o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-bottom:6.0pt'>- Thi&#7871;t b&#7883; b&#7843;o
h&#7897; lao &#273;&#7897;ng s&#7869; &#273;&#432;&#7907;c công ty cung
c&#7845;p n&#7871;u công vi&#7879;c yêu c&#7847;u.</p>

<p class=MsoNormal style='margin-bottom:6.0pt'><i><span style='font-size:13.0pt'><span
style='mso-spacerun:yes'>   </span>Labor protection equipment will be provided if
the work required.<o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;line-height:150%'>-
B&#7843;o hi&#7875;m xã h&#7897;i và b&#7843;o hi&#7875;m y t&#7871; theo
lu&#7853;t Vi&#7879;t <st1:country-region w:st="on"><st1:place w:st="on">Nam</st1:place></st1:country-region>
s&#7869; &#273;&#432;&#7907;c xem xét sau khi k&#7871;t thúc th&#7901;i gian
h&#7885;c vi&#7879;c.</p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify'><i>Social
insurance &amp; heath insurance pursuant to the Labor Code of <st1:country-region
w:st="on"><st1:place w:st="on">Vietnam</st1:place></st1:country-region> is
considered after Trainee’s probation period.<o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;line-height:150%'><b>II. Ngh&#297;a v&#7909;/ <i>Obligations</i>:<o:p></o:p></b></p>

<p class=MsoNormal style='margin-top:6.0pt'>Tuân th&#7911; n&#7897;i quy lao
&#273;&#7897;ng, an toàn lao &#273;&#7897;ng, tr&#7853;t t&#7921; công
vi&#7879;c, &#273;i&#7873;u ch&#7881;nh công vi&#7879;c. . . . .</p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;line-height:150%'><i>To comply with work order, business
management, labor regulation and labor safety. . . . . <o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt'>Hoàn thành công vi&#7879;c
&#273;&#432;&#7907;c giao nh&#432; &#273;ã cam k&#7871;t trong H&#7907;p
&#273;&#7891;ng.</p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in'><i>To fulfill the job undertaken in the contract.<o:p></o:p></i></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify;line-height:
150%'>B&#7891;i th&#432;&#7901;ng các vi ph&#7841;m (n&#7871;u có) theo
nh&#432; các &#273;i&#7873;u kho&#7843;n quy &#273;&#7883;nh trong N&#7897;i
quy lao &#273;&#7897;ng c&#7911;a Công ty và theo Lu&#7853;t lao
&#273;&#7897;ng Vi&#7879;t <st1:country-region w:st="on"><st1:place w:st="on">Nam</st1:place></st1:country-region>.</p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify'><i>To
compensate for violations (if any) as provisions in the Labor Regulation of the
Company and in the accordance with Labor Code of <st1:country-region w:st="on"><st1:place
 w:st="on">Vietnam</st1:place></st1:country-region>.<o:p></o:p></i></p>

<p class=MsoNormal style='margin-bottom:6.0pt'><b>&#272;i&#7873;u IV: <span
style='mso-tab-count:1'>        </span>Ngh&#297;a v&#7909; và quy&#7873;n
l&#7907;i c&#7911;a ng&#432;&#7901;i s&#7917; d&#7909;ng lao &#273;&#7897;ng<o:p></o:p></b></p>

<p class=MsoNormal style='margin-bottom:6.0pt'><b><i>Article IV: <span
style='mso-tab-count:1'>      </span>Obligations and benefits of the Employerny
<o:p></o:p></i></b></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;line-height:150%'><b>I. Ngh&#297;a v&#7909; /<i>Obligations</i>:<o:p></o:p></b></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;line-height:150%'>- &#272;&#7843;m b&#7843;o công vi&#7879;c
&#273;ào t&#7841;o cho h&#7885;c viên và tuân th&#7911; &#273;úng các
&#273;i&#7873;u ki&#7879;n trong h&#7907;p &#273;&#7891;ng.</p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify'><i>To assure
training job for the trainee and fully comply with necessary terms and
conditions committed in the contract.<o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;text-align:justify;line-height:150%'>- Thanh toán
&#273;&#7847;y &#273;&#7911; và &#273;úng h&#7841;n cho h&#7885;c viên
ti&#7873;n l&#432;&#417;ng và các kho&#7843;n thu nh&#7853;p khác nh&#432;
&#273;&#432;&#7907;c cam k&#7871;t trong h&#7907;p &#273;&#7891;ng và trong
N&#7897;i quy lao &#273;&#7897;ng c&#7911;a Công ty.</p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify'><i><span
style='mso-spacerun:yes'> </span>To fully and duly pay trainee</i>’<i>s
remuneration and other benefits as committed in the contract and provisions in
the Labor Regulation of the Company.<o:p></o:p></i></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify'>Công ty có
quy&#7873;n t&#7915; ch&#7889;i ký k&#7871;t H&#272;L&#272; chính th&#7913;c
n&#7871;u h&#7885;c hiên không &#273;&#7841;t yêu c&#7847;u &#273;ào t&#7841;o.
Yêu c&#7847;u &#273;ào t&#7841;o c&#7911;a công ty s&#7869; phát cho h&#7885;c
viên khi b&#7855;t &#273;&#7847;u khoá &#273;ào t&#7841;o.</p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify'><i>If the
Trainee’s training result is not meet requirement, company will refuse to sign
Official Labor Contract with Trainee. The company’s requirements will be giving
to trainee when the trainee commences training.<o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;line-height:150%'><b>II. Quy&#7873;n l&#7907;i/ <i>Benefits</i>:<o:p></o:p></b></p>

<p class=MsoNormal style='margin-top:6.0pt;line-height:150%'>- Qu&#7843;n lý và
&#273;i&#7873;u hành h&#7885;c viên &#273;&#7875; hoàn thành t&#7889;t công
vi&#7879;c &#273;&#432;&#7907;c giao trong h&#7907;p &#273;&#7891;ng</p>

<p class=MsoNormal style='margin-bottom:6.0pt'><i><span
style='mso-spacerun:yes'>  </span>To manage the employee in the order to fully
complete the work assigned in the contract.<o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;text-align:justify;line-height:150%'>- &#272;ình ch&#7881;
ho&#7863;c ch&#7845;m d&#7913;t h&#7907;p &#273;&#7891;ng và áp d&#7909;ng các
bi&#7879;n pháp k&#7927; lu&#7853;t theo Lu&#7853;t lao &#273;&#7897;ng và
N&#7897;i quy lao &#273;&#7897;ng c&#7911;a Công ty.</p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify'><i>To suspend
or terminate this contract and apply discipline measures according to Labor
Laws and Labor Regulations of the Company.<o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in'><b>&#272;i&#7873;u V: <span style='mso-tab-count:1'>          </span>&#272;i&#7873;u
kho&#7843;n chung:<o:p></o:p></b></p>

<p class=MsoNormal style='margin-bottom:6.0pt'><b><i>Article V: <span
style='mso-tab-count:1'>       </span>General provisions:<o:p></o:p></i></b></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;text-align:justify;line-height:150%'>- Các v&#7845;n
&#273;&#7873; lao &#273;&#7897;ng khác mà không &#273;&#432;&#7907;c
&#273;&#7873; c&#7853;p trong h&#7907;p &#273;&#7891;ng s&#7869;
&#273;&#432;&#7907;c áp d&#7909;ng theo lu&#7853;t Lao &#273;&#7897;ng
Vi&#7879;t <st1:country-region w:st="on"><st1:place w:st="on">Nam</st1:place></st1:country-region>
và N&#7897;i quy lao &#273;&#7897;ng c&#7911;a Công ty.</p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify'><i>Other
labor matters, which are not mentioned in this contract, shall be subject to
the Labor Regulation of the Company and Labor Code if Vietnam.<o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;text-align:justify;line-height:150%'>- B&#7843;n h&#7907;p
&#273;&#7891;ng này &#273;&#432;&#7907;c l&#7853;p thành 02 b&#7843;n
ti&#7871;ng Vi&#7879;t và ti&#7871;ng Anh. Ng&#432;&#7901;i s&#7917; d&#7909;ng
lao &#273;&#7897;ng gi&#7919; 01 b&#7843;n, ng&#432;&#7901;i lao
&#273;&#7897;ng gi&#7919; 01 b&#7843;n.</p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify'><i>This
contract is made into two sets in Vietnamese and English. The Employer keeps
one copy and the Employee keeps one copy.<o:p></o:p></i></p>

<p class=MsoNormal style='mso-line-height-alt:1.2pt'>H&#7907;p &#273;&#7891;ng
này làm t&#7841;i Công ty TNHH <%= dt_name.Rows[0][1].ToString() %>, ngày  <%= dt_total.Rows[i][24].ToString() + "/" + dt_total.Rows[i][25].ToString() +"/" + dt_total.Rows[i][26].ToString()%></p>

<p class=MsoNormal style='mso-line-height-alt:1.2pt'><i>This contract make on
date  <%= dt_total.Rows[i][24].ToString() + "/" + dt_total.Rows[i][25].ToString() +"/" + dt_total.Rows[i][26].ToString()%> signed at <%= dt_name.Rows[0][1].ToString() %>.<o:p></o:p></i></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-indent:.5in'><b><o:p>&nbsp;</o:p></b></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-indent:.5in'><b>NG&#431;&#7900;I
&#272;&#431;&#7906;C &#272;ÀO T&#7840;O<span style='mso-tab-count:5'>                                                 </span>T&#7892;NG
GIÁM &#272;&#7888;C<o:p></o:p></b></p>

<p class=MsoNormal style='margin-bottom:6.0pt'><span style='mso-spacerun:yes'> 
</span><span style='mso-tab-count:2'>                      </span><b>Trainee<span
style='mso-tab-count:6'>                                                                       </span><span
style='mso-spacerun:yes'>   </span>General Director </b></p>
<p class=MsoNormal style='margin-bottom:6.0pt'><span style='mso-spacerun:yes'> 
</span><span style='mso-tab-count:2'>                      </span><b><span
style='mso-tab-count:6'>                                                                       </span><span
style='mso-spacerun:yes'>   </span> </b></p>
<p class=MsoNormal style='margin-bottom:6.0pt'><span style='mso-spacerun:yes'> 
</span><span style='mso-tab-count:2'>                      </span><b><span
style='mso-tab-count:6'>                                                                       </span><span
style='mso-spacerun:yes'>   </span> </b></p>
<p class=MsoNormal style='margin-bottom:6.0pt'><span style='mso-spacerun:yes'> 
</span><span style='mso-tab-count:2'>                      </span><b><span
style='mso-tab-count:6'>                                                                       </span><span
style='mso-spacerun:yes'>   </span> </b></p>
<p class=MsoNormal style='margin-bottom:6.0pt'><span style='mso-spacerun:yes'> 
</span><span style='mso-tab-count:2'>                      </span><b><span
style='mso-tab-count:7'>                                                                       </span><span
style='mso-spacerun:yes'>   </span><%= dt_name.Rows[1][1].ToString() %> </b></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;line-height:150%'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal><span style='font-family:"Times New Roman"'><u1:p>&nbsp;</u1:p></span></p>
<%
     if (i == irow - 1)//nhan vien cuoi cung 
     { 
         %>
         
<b><span style='font-size:12.0pt;font-family:"Times New Roman";mso-fareast-font-family:
"Times New Roman";mso-ansi-language:EN-US;mso-fareast-language:EN-US;
mso-bidi-language:AR-SA'><br clear=all >
</span></b>
         <%
     }
     else
     {   
  %>
    
<p class=MsoNormal><span style='font-family:"Times New Roman"'><u1:p>&nbsp;</u1:p><o:p></o:p></span></p>

<b style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;
font-family:"Times New Roman";mso-fareast-font-family:Batang;mso-ansi-language:
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA'><br clear=all
style='mso-special-character:line-break;page-break-before:always'>
</span></b>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>
<% 
     }
    }
%>

</div>

</body>

</html>
