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
    string app_pk, status_trainee;
    app_pk = Request["app_pk"].ToString();
    app_pk = app_pk.Substring(0, app_pk.Length - 1);
    status_trainee = Request["status_trainee"].ToString();
    
    string SQL
    = "select a.THR_TRAIN_REQ_PK " + 
        "       ,req.FULL_NAME fullname_1 " +
        "       ,(select v.code_nm from vhr_hr_code v where  v.id='HR0008' and v.code = req.POS_TYPE ) pos_2 " +
        "       ,(select i.org_nm from comm.tco_org i where i.del_if=0 and i.pk = req.TCO_ORG_PK ) org_3 " +
        "       ,c.COURSE_ID||'-'||c.COURSE_NAME coursename_4 " +
        "       ,''  participate_5 " +
        "       ,c.LOCATION location_6 " +
        "       ,(select v.code_nm from vhr_hr_code v where  v.id='HR0168' and v.code = c.TRAIN_TYPE ) train_type_7 " +
        "       ,decode(nvl(c.BUDGET_YN,'N'),'N','Không', 'Có') budget_8 " +
        "       ,c.DESCRIPTION  purpose_9 " +
        "       ,e.FULL_NAME fullname_10 " +
        "       ,e.EMP_ID emp_id_11 " +
        "       ,(select v.code_nm from vhr_hr_code v where  v.id='HR0008' and v.code = e.POS_TYPE ) pos_12 " +
        "       ,o.ORG_NM org_13 " +
        "       ,to_char(to_date(e.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') join_dt_14 " +
        "       ,to_char(to_date(b.REQUIRE_DATE ,'yyyymmdd'),'ddmmyyyy') require_dt_15 " +
        "    from thr_train_reqd a, thr_train_req b, thr_train_course c, thr_employee e, comm.tco_org o, thr_employee req " +
        "    where a.del_if=0 and b.del_if=0 and c.del_if=0 and e.del_if=0 and o.del_if=0 and req.del_if=0 " +
        "        and a.THR_TRAIN_REQ_PK = b.pk  " +
        "        and b.THR_TRAIN_COURSE_PK = c.pk " +
        "        and a.TRAINEE_PK = e.pk and e.TCO_ORG_PK = o.pk " +
        "        and b.REQ_EMP_PK = req.pk  " +
        "        and a.THR_TRAIN_REQ_PK in ("+ app_pk +") " +
        "        and decode('" + status_trainee + "','ALL', 'ALL', a.status ) = '" + status_trainee + "' " +
        "    order by a.THR_TRAIN_REQ_PK " ;


   // Response.Write(SQL);
   // Response.End();
    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    int irow,icol;
    irow = dt_total.Rows.Count;
    icol = dt_total.Columns.Count;
    if (irow == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }

    string SQL2
    = "select count(*),to_char(sysdate,'ddmmyyyy') " +
        "    from thr_train_reqd a " +
        "    where a.del_if=0 " +
        "        and a.THR_TRAIN_REQ_PK in (" + app_pk + ") " +
        "        and decode('" + status_trainee + "','ALL', 'ALL', a.status ) = '" + status_trainee + "' " +
        "    group by a.THR_TRAIN_REQ_PK " +
        "    order by a.THR_TRAIN_REQ_PK ";
    DataTable dt_sum = ESysLib.TableReadOpen(SQL2);


    int j = 0;
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 11">
<meta name=Originator content="Microsoft Word 11">
<link rel=File-List href="rpt_request_training_files/filelist.xml">
<title>ATTENDING TRAINING REQUEST</title>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Ms Thu</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>4</o:TotalTime>
  <o:LastPrinted>2010-07-28T05:10:00Z</o:LastPrinted>
  <o:Created>2011-09-06T06:49:00Z</o:Created>
  <o:LastSaved>2011-09-06T06:49:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>115</o:Words>
  <o:Characters>658</o:Characters>
  <o:Company>FLDC</o:Company>
  <o:Lines>5</o:Lines>
  <o:Paragraphs>1</o:Paragraphs>
  <o:CharactersWithSpaces>772</o:CharactersWithSpaces>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
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
 /* Page Definitions */
 @page
	{mso-footnote-separator:url("rpt_request_training_files/header.htm") fs;
	mso-footnote-continuation-separator:url("rpt_request_training_files/header.htm") fcs;
	mso-endnote-separator:url("rpt_request_training_files/header.htm") es;
	mso-endnote-continuation-separator:url("rpt_request_training_files/header.htm") ecs;}
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
	mso-level-text:\F076;
	mso-level-tab-stop:63.0pt;
	mso-level-number-position:left;
	margin-left:63.0pt;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1
	{mso-list-id:988747669;
	mso-list-type:simple;
	mso-list-template-ids:67698703;}
@list l1:level1
	{mso-level-tab-stop:.25in;
	mso-level-number-position:left;
	margin-left:.25in;
	text-indent:-.25in;}
@list l2
	{mso-list-id:1195381546;
	mso-list-type:simple;
	mso-list-template-ids:67698703;}
@list l2:level1
	{mso-level-tab-stop:.25in;
	mso-level-number-position:left;
	margin-left:.25in;
	text-indent:-.25in;}
@list l3
	{mso-list-id:1455556712;
	mso-list-type:simple;
	mso-list-template-ids:67698703;}
@list l3:level1
	{mso-level-tab-stop:.25in;
	mso-level-number-position:left;
	margin-left:.25in;
	text-indent:-.25in;}
@list l4
	{mso-list-id:1460611155;
	mso-list-type:hybrid;
	mso-list-template-ids:246313348 67698705 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l4:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l5
	{mso-list-id:1577283679;
	mso-list-type:simple;
	mso-list-template-ids:67698703;}
@list l5:level1
	{mso-level-tab-stop:.25in;
	mso-level-number-position:left;
	margin-left:.25in;
	text-indent:-.25in;}
@list l6
	{mso-list-id:2003116523;
	mso-list-type:simple;
	mso-list-template-ids:67698703;}
@list l6:level1
	{mso-level-tab-stop:.25in;
	mso-level-number-position:left;
	margin-left:.25in;
	text-indent:-.25in;}
@list l7
	{mso-list-id:2085299346;
	mso-list-type:hybrid;
	mso-list-template-ids:1885220962 -794114180 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l7:level1
	{mso-level-text:"\(%1\)";
	mso-level-tab-stop:.5in;
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
 <o:shapedefaults v:ext="edit" spidmax="2050"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=EN-US style='tab-interval:.5in'>

<div class=Section1>
<% 
    int total = 0;
     Boolean flag = true;
     Boolean flag_1 = false;
     string emp_type_old="";string emp_type_new="";
     for (int i = 0; i < irow; i++) 
     {
         total++;
        emp_type_old = dt_total.Rows[i][0].ToString();

        if (flag)
         {

 %>
<p class=MsoTitle style='mso-line-height-alt:1.0pt'><b style='mso-bidi-font-weight:
normal'><span style='mso-bidi-font-size:18.0pt;font-family:"Times New Roman"'>&#272;&#416;N
YÊU C&#7846;</span></b><b style='mso-bidi-font-weight:normal'><span
style='mso-bidi-font-size:18.0pt'>U </span></b><b style='mso-bidi-font-weight:
normal'><span style='mso-bidi-font-size:18.0pt;font-family:"Times New Roman"'>&#272;ÀO
T&#7840;O<o:p></o:p></span></b></p>

<p class=MsoTitle style='mso-line-height-alt:1.0pt'><span style='font-size:
12.0pt;font-family:"Times New Roman"'>ATTENDING TRAINING REQUEST<o:p></o:p></span></p>

<p class=MsoTitle align=right style='text-align:right;mso-line-height-alt:1.0pt'><span
style='font-size:12.0pt;font-family:"Times New Roman"'>Ngày <%= dt_total.Rows[i][15].ToString().Substring(0,2) %> tháng <%= dt_total.Rows[i][15].ToString().Substring(2,2) %> n&#259;m
<%= dt_total.Rows[i][15].ToString().Substring(4,4) %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;tab-stops:283.5pt'><span style='font-size:11.0pt;mso-bidi-font-size:
10.0pt;font-family:"Times New Roman"'>H&#7885; và Tên / <i style='mso-bidi-font-style:
normal'>Full-name</i> <b style='mso-bidi-font-weight:normal'>: <span
style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][1].ToString() %></b> <span
style='mso-tab-count:1'>                        </span><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;tab-stops:283.5pt'><span style='font-size:11.0pt;mso-bidi-font-size:
10.0pt;font-family:"Times New Roman"'>Ch</span><span style='font-family:"Times New Roman"'>&#7913;c
v&#7909; /</span><i style='mso-bidi-font-style:normal'><span style='font-size:
11.0pt;mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>Position</span></i><span
style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>:
<span style='mso-spacerun:yes'>        </span><b style='mso-bidi-font-weight:
normal'><%= dt_total.Rows[i][2].ToString() %></b> <o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;tab-stops:283.5pt'><span style='font-size:11.0pt;mso-bidi-font-size:
10.0pt;font-family:"Times New Roman"'>B&#7897; ph&#7853;n / <i
style='mso-bidi-font-style:normal'>Department :<span
style='mso-spacerun:yes'>   </span></i><b style='mso-bidi-font-weight:normal'><%= dt_total.Rows[i][3].ToString() %></b><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:.25in;text-indent:-.25in;mso-list:l2 level1 lfo5;tab-stops:list .25in left 283.5pt'><![if !supportLists]><b
style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
10.0pt;font-family:"Times New Roman"'><span style='mso-list:Ignore'>1.<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span></b><![endif]><b
style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
10.0pt;font-family:"Times New Roman"'>Thông tin khóa h&#7885;c/ </span></b><i
style='mso-bidi-font-style:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
10.0pt;font-family:"Times New Roman"'>Course information :</span></i><b
style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
10.0pt;font-family:"Times New Roman"'><o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:49.65pt;text-indent:-.25in;mso-list:l0 level1 lfo1;tab-stops:dashed 42.55pt list blank 63.0pt right 396.9pt'><![if !supportLists]><span
style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:Wingdings;
mso-fareast-font-family:Wingdings;mso-bidi-font-family:Wingdings'><span
style='mso-list:Ignore'>v<span style='font:7.0pt "Times New Roman"'> </span></span></span><![endif]><span
style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>Tên
khóa h&#7885;c / <i style='mso-bidi-font-style:normal'>Course</i> : <b
style='mso-bidi-font-weight:normal'><%= dt_total.Rows[i][4].ToString() %></b><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:49.65pt;text-indent:-.25in;mso-list:l0 level1 lfo1;tab-stops:dashed 42.55pt list blank 63.0pt right 396.9pt'><![if !supportLists]><span
style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:Wingdings;
mso-fareast-font-family:Wingdings;mso-bidi-font-family:Wingdings'><span
style='mso-list:Ignore'>v<span style='font:7.0pt "Times New Roman"'> </span></span></span><![endif]><span
style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>T&#7893;ng
S</span><span style='font-family:"Times New Roman"'>&#7889;</span> ng<span
style='font-family:"Times New Roman"'>&#432;&#7901;</span>i tham d<span
style='font-family:"Times New Roman"'>&#7921;</span>/ <i style='mso-bidi-font-style:
normal'>participators: <span style='mso-spacerun:yes'> </span><b
style='mso-bidi-font-weight:normal'><%= dt_sum.Rows[j][0].ToString() %></b> </i><span style='font-size:11.0pt;
mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:49.65pt;text-indent:-.25in;mso-list:l0 level1 lfo1;tab-stops:list 42.55pt 63.0pt'><![if !supportLists]><span
style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:Wingdings;
mso-fareast-font-family:Wingdings;mso-bidi-font-family:Wingdings'><span
style='mso-list:Ignore'>v<span style='font:7.0pt "Times New Roman"'> </span></span></span><![endif]><span
style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>&#272;&#7883;a
&#273;i&#7875;m / <i style='mso-bidi-font-style:normal'>Place:</i> <span
style='mso-tab-count:1'>      </span><span style='mso-spacerun:yes'>    </span><b
style='mso-bidi-font-weight:normal'><%= dt_total.Rows[i][6].ToString() %></b><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:17.85pt;margin-bottom:.0001pt;text-indent:-17.85pt;mso-list:l2 level1 lfo5;
tab-stops:list .25in left 127.6pt 141.75pt 233.9pt 283.5pt 340.2pt'><![if !supportLists]><b
style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
10.0pt;font-family:"Times New Roman"'><span style='mso-list:Ignore'>2.<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span></b><![endif]><b
style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
10.0pt;font-family:"Times New Roman"'>Lo&#7841;i hình &#273;ào t&#7841;o/ </span></b><span
style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>Training
type<b style='mso-bidi-font-weight:normal'> : <span
style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][7].ToString() %></b><span
style='mso-spacerun:yes'>  </span><b style='mso-bidi-font-weight:normal'><o:p></o:p></b></span></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:127.6pt 141.75pt 233.9pt 283.5pt 340.2pt'><b
style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
10.0pt;font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-left:.25in;text-indent:-.25in;mso-list:l2 level1 lfo5;
tab-stops:list .25in left 141.75pt 233.9pt'><![if !supportLists]><b
style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
10.0pt;font-family:"Times New Roman"'><span style='mso-list:Ignore'>3.<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span></b><![endif]><b
style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
10.0pt;font-family:"Times New Roman"'>Ngân sách/ </span></b><span
style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:"Times New Roman";
mso-no-proof:yes'>Budget </span><b style='mso-bidi-font-weight:normal'><span
style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>:<span
style='mso-spacerun:yes'>   </span><%= dt_total.Rows[i][8].ToString() %> <o:p></o:p></span></b></p>

<p class=MsoNormal style='tab-stops:141.75pt 233.9pt'><b style='mso-bidi-font-weight:
normal'><span style='font-size:11.0pt;mso-bidi-font-size:10.0pt;font-family:
"Times New Roman"'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:.25in;text-indent:-.25in;mso-list:l2 level1 lfo5;tab-stops:list .25in left 113.4pt 290.6pt'><![if !supportLists]><b
style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
10.0pt;font-family:"Times New Roman"'><span style='mso-list:Ignore'>4.<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span></b><![endif]><b
style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
10.0pt;font-family:"Times New Roman"'>M&#7909;c &#273;ích / </span></b><i
style='mso-bidi-font-style:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
10.0pt;font-family:"Times New Roman"'>Purpose</span></i><span style='font-size:
11.0pt;mso-bidi-font-size:10.0pt;font-family:"Times New Roman";mso-bidi-font-weight:
bold'>:<span style='mso-spacerun:yes'>   </span><b><%= dt_total.Rows[i][9].ToString() %></b></span><b
style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
10.0pt;font-family:"Times New Roman"'><o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:.25in;text-indent:-.25in;mso-list:l2 level1 lfo5;tab-stops:list .25in left 113.4pt 290.6pt'><![if !supportLists]><b
style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
10.0pt;font-family:"Times New Roman"'><span style='mso-list:Ignore'>5.<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span></b><![endif]><b
style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
10.0pt;font-family:"Times New Roman"'>Danh Sách nhân viên tham d&#7921; :<o:p></o:p></span></b></p>

<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-yfti-tbllook:480;mso-padding-alt:0in 5.4pt 0in 5.4pt;mso-border-insideh:
 .5pt solid windowtext;mso-border-insidev:.5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:30.4pt'>
  <td width=43 valign=top style='width:.45in;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:30.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt;font-family:"Times New Roman"'>TT<br>
  <i>No</i><o:p></o:p></span></p>
  </td>
  <td width=164 valign=top style='width:122.7pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:30.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:11.0pt;font-family:"Times New Roman"'>H&#7885; và tên<br>
  <i>Full-name</i><o:p></o:p></span></p>
  </td>
  <td width=88 valign=top style='width:66.3pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:30.4pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:center 4.5in right dashed 6.25in'><span
  style='mso-bidi-font-size:12.0pt;font-family:"Times New Roman"'>Mã s&#7889;<o:p></o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:center 4.5in right dashed 6.25in'><i
  style='mso-bidi-font-style:normal'><span style='mso-bidi-font-size:12.0pt;
  font-family:"Times New Roman"'>Code<o:p></o:p></span></i></p>
  </td>
  <td width=114 valign=top style='width:85.5pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:30.4pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:center 4.5in right dashed 6.25in'><span
  style='mso-bidi-font-size:12.0pt;font-family:"Times New Roman"'>Ch&#7913;c
  v&#7909;<o:p></o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:center 4.5in right dashed 6.25in'><i
  style='mso-bidi-font-style:normal'><span style='mso-bidi-font-size:12.0pt;
  font-family:"Times New Roman"'>Position<o:p></o:p></span></i></p>
  </td>
  <td width=120 valign=top style='width:1.25in;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:30.4pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:center 4.5in right dashed 6.25in'><span
  style='mso-bidi-font-size:12.0pt;font-family:"Times New Roman"'>B&#7897;
  ph&#7853;n<o:p></o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:center 4.5in right dashed 6.25in'><i
  style='mso-bidi-font-style:normal'><span style='mso-bidi-font-size:12.0pt;
  font-family:"Times New Roman"'>Department<o:p></o:p></span></i></p>
  </td>
  <td width=91 valign=top style='width:.95in;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:30.4pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:center 4.5in right dashed 6.25in'><span
  style='mso-bidi-font-size:12.0pt;font-family:"Times New Roman"'>Ngày vào<o:p></o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:center 4.5in right dashed 6.25in'><i
  style='mso-bidi-font-style:normal'><span style='mso-bidi-font-size:12.0pt;
  font-family:"Times New Roman"'>Join Date<o:p></o:p></span></i></p>
  </td>
 </tr>
 <%     }  
        flag = false;     
 %>  <%--End flag--%>
 <tr style='mso-yfti-irow:1;mso-yfti-lastrow:yes;height:17.8pt'>
  <td width=43 valign=top style='width:.45in;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:17.8pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:center 4.5in right dashed 6.25in'><span
  style='mso-bidi-font-size:12.0pt;font-family:"Times New Roman"'><%= total %><o:p></o:p></span></p>
  </td>
  <td width=164 valign=top style='width:122.7pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:17.8pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:center 4.5in right dashed 6.25in'><span
  style='mso-bidi-font-size:12.0pt;font-family:"Times New Roman"'><%= dt_total.Rows[i][10].ToString() %><o:p></o:p></span></p>
  </td>
  <td width=88 valign=top style='width:66.3pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:17.8pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:center 4.5in right dashed 6.25in'><span
  style='mso-bidi-font-size:12.0pt;font-family:"Times New Roman"'><%= dt_total.Rows[i][11].ToString() %><o:p></o:p></span></p>
  </td>
  <td width=114 valign=top style='width:85.5pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:17.8pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:center 4.5in right dashed 6.25in'><span
  style='mso-bidi-font-size:12.0pt;font-family:"Times New Roman"'><%= dt_total.Rows[i][12].ToString() %><o:p></o:p></span></p>
  </td>
  <td width=120 valign=top style='width:1.25in;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:17.8pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:center 4.5in right dashed 6.25in'><span
  style='mso-bidi-font-size:12.0pt;font-family:"Times New Roman"'><%= dt_total.Rows[i][13].ToString() %><o:p></o:p></span></p>
  </td>
  <td width=91 valign=top style='width:.95in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:17.8pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:center 4.5in right dashed 6.25in'><span
  style='mso-bidi-font-size:12.0pt;font-family:"Times New Roman"'><%= dt_total.Rows[i][14].ToString() %><o:p></o:p></span></p>
  </td>
 </tr>

 <%
     if (i < irow - 1)
     {
         emp_type_new = dt_total.Rows[i + 1][0].ToString();
         if (emp_type_new != emp_type_old)
         {
             j++;
             total = 0;
             flag = true;
             flag_1 = true;
         }
     }
     else
     {
         total = 0;
         flag = true;
         flag_1 = true;
     }

     if (flag_1)
     {
  %>
</table>

<p class=MsoNormal style='tab-stops:center 4.5in right dashed 6.25in'><span
style='mso-bidi-font-size:12.0pt;font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='tab-stops:center 4.5in right dashed 6.25in'><span
style='mso-bidi-font-size:12.0pt;font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

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
  mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>Prepared<o:p></o:p></span></p>
  </td>
  <td width=158 style='width:118.75pt;border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:13.25pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:right dashed 396.9pt;
  mso-element:frame;mso-element-frame-hspace:9.0pt;mso-element-wrap:around;
  mso-element-anchor-vertical:paragraph;mso-element-anchor-horizontal:margin;
  mso-element-top:32.55pt;mso-height-rule:exactly'><span style='font-size:11.0pt;
  mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>Manager<o:p></o:p></span></p>
  </td>
  <td width=162 style='width:121.15pt;border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:13.25pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:right dashed 396.9pt;
  mso-element:frame;mso-element-frame-hspace:9.0pt;mso-element-wrap:around;
  mso-element-anchor-vertical:paragraph;mso-element-anchor-horizontal:margin;
  mso-element-top:32.55pt;mso-height-rule:exactly'><span style='font-size:11.0pt;
  mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>G. Manager<o:p></o:p></span></p>
  </td>
  <td width=148 style='width:110.85pt;border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:13.25pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:right dashed 396.9pt;
  mso-element:frame;mso-element-frame-hspace:9.0pt;mso-element-wrap:around;
  mso-element-anchor-vertical:paragraph;mso-element-anchor-horizontal:margin;
  mso-element-top:32.55pt;mso-height-rule:exactly'><span style='font-size:11.0pt;
  mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>Director<o:p></o:p></span></p>
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
  10.0pt;font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=158 valign=top style='width:118.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:40.0pt'>
  <p class=MsoNormal style='tab-stops:right dashed 396.9pt;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:margin;mso-element-top:32.55pt;
  mso-height-rule:exactly'><span style='font-size:11.0pt;mso-bidi-font-size:
  10.0pt;font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal style='tab-stops:right dashed 396.9pt;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:margin;mso-element-top:32.55pt;
  mso-height-rule:exactly'><span style='font-size:11.0pt;mso-bidi-font-size:
  10.0pt;font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal style='tab-stops:right dashed 396.9pt;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:margin;mso-element-top:32.55pt;
  mso-height-rule:exactly'><span style='font-size:11.0pt;mso-bidi-font-size:
  10.0pt;font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal style='tab-stops:right dashed 396.9pt;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:margin;mso-element-top:32.55pt;
  mso-height-rule:exactly'><span style='font-size:11.0pt;mso-bidi-font-size:
  10.0pt;font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=162 valign=top style='width:121.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:40.0pt'>
  <p class=MsoNormal style='tab-stops:right dashed 396.9pt;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:margin;mso-element-top:32.55pt;
  mso-height-rule:exactly'><span style='font-size:11.0pt;mso-bidi-font-size:
  10.0pt;font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=148 valign=top style='width:110.85pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:40.0pt'>
  <p class=MsoNormal style='tab-stops:right dashed 396.9pt;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:margin;mso-element-top:32.55pt;
  mso-height-rule:exactly'><span style='font-size:11.0pt;mso-bidi-font-size:
  10.0pt;font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
</table>

<p class=MsoNormal style='margin-left:.25in;tab-stops:right dashed 396.9pt'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-family:
"Times New Roman"'><o:p>&nbsp;</o:p></span></i></p>

<p class=MsoNormal style='margin-left:.25in;tab-stops:right dashed 396.9pt'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-family:
"Times New Roman"'><o:p>&nbsp;</o:p></span></i></p>

<p class=MsoNormal style='margin-left:.25in;tab-stops:right dashed 396.9pt'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-family:
"Times New Roman"'><o:p>&nbsp;</o:p></span></i></p>

<%
     }  // End flag_1
     flag_1 = false;
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
