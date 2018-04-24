<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/msword";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>

<html >
<%
    
    string pk_list = Request["pk_list"].ToString();
    pk_list = pk_list.Substring(0, pk_list.Length - 1);
    
    string SQL
    = "select 1  " + 
        ",b.FULL_NAME as fullname   " +
        ",b.EMP_ID as emp_id   " +
        ",(select g.org_nm from tco_org g where g.del_if=0 and g.pk = a.FROM_ORG_PK) as from_org   " +
        ",(select v.code_nm from vhr_hr_code v where v.id='HR0008'and v.code= a.FROM_POS_TYPE ) as from_pos " +
        ",(select g.workgroup_nm from thr_work_group g where g.del_if=0 and g.pk = a.from_wg_pk) as from_wg " +
        ",(select g.org_nm from tco_org g where g.del_if=0 and g.pk = a.TO_ORG_PK) as to_org " +
        ",(select v.code_nm from vhr_hr_code v where v.id='HR0008'and v.code= a.TO_POS_TYPE ) as to_pos " +
        ",(select g.workgroup_nm from thr_work_group g where g.del_if=0 and g.pk = a.to_wg_pk) as to_wg    " +
        ",to_char(to_date(a.APPOINT_DATE,'yyyymmdd'),'dd/mm/yyyy') as app_date   " +
        ",to_char(sysdate,'dd') day  " +
        ",to_char(sysdate,'mm') mon  " +
        ",to_char(sysdate,'yyyy') day  " +
        "from thr_appointment_detail a, thr_employee b, thr_work_group c   " +
        "where a.del_if=0 and b.del_if=0 and c.del_if=0   " +
        "and a.THR_EMPLOYEE_PK = b.pk    " +
        "and b.THR_WG_PK = c.pk   " +
        "and a.pk in (" + pk_list + ")  " +
        "order by a.THR_EMPLOYEE_PK " ;

    //Response.Write(SQL);
    //Response.End();
    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
    if (dt_emp.Rows.Count == 0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }
    
    //--------------------company information-----------------------
    string SQL_Com
	= "select  a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,a.FAX_NO,a.TCO_BPPHOTO_PK " + 
        "from tco_company a " +
        "where a.DEL_IF=0 " +
        "and rownum=1 " ;

    
    DataTable dt_Com = ESysLib.TableReadOpen(SQL_Com);
    int irow_com;
    irow_com = dt_Com.Rows.Count;
    if (irow_com == 0)
    {
        Response.Write("There is no data of company");
        Response.End();
    }
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 11">
<meta name=Originator content="Microsoft Word 11">
<link rel=File-List href="rpt_decision_appointment_files/filelist.xml">
<title>CÔNG TY TNHH POSCO VST</title>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>cun</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>0</o:TotalTime>
  <o:Created>2011-06-28T02:05:00Z</o:Created>
  <o:LastSaved>2011-06-28T02:05:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>201</o:Words>
  <o:Characters>1149</o:Characters>
  <o:Company>VinaGenuwin</o:Company>
  <o:Lines>9</o:Lines>
  <o:Paragraphs>2</o:Paragraphs>
  <o:CharactersWithSpaces>1348</o:CharactersWithSpaces>
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
   <w:UseFELayout/>
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
	{font-family:Batang;
	panose-1:2 3 6 0 0 1 1 1 1 1;
	mso-font-alt:\BC14\D0D5;
	mso-font-charset:129;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-1342176593 1775729915 48 0 524447 0;}
@font-face
	{font-family:"\@Batang";
	panose-1:2 3 6 0 0 1 1 1 1 1;
	mso-font-charset:129;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-1342176593 1775729915 48 0 524447 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:Batang;
	mso-fareast-language:KO;}
h1
	{mso-style-next:Normal;
	margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:1;
	font-size:16.0pt;
	font-family:Arial;
	mso-font-kerning:16.0pt;
	mso-fareast-language:KO;}
h2
	{mso-style-next:Normal;
	margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:2;
	font-size:14.0pt;
	font-family:Arial;
	mso-fareast-language:KO;
	font-style:italic;}
h3
	{mso-style-next:Normal;
	margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:3;
	font-size:13.0pt;
	font-family:Arial;
	mso-fareast-language:KO;}
h4
	{mso-style-next:Normal;
	margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:4;
	font-size:14.0pt;
	font-family:"Times New Roman";
	mso-fareast-language:KO;}
h5
	{mso-style-next:Normal;
	margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	mso-pagination:widow-orphan;
	mso-outline-level:5;
	font-size:13.0pt;
	font-family:"Times New Roman";
	mso-fareast-language:KO;
	font-style:italic;}
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
	mso-fareast-language:KO;}
p.MsoHeading7, li.MsoHeading7, div.MsoHeading7
	{mso-style-next:Normal;
	margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	mso-pagination:widow-orphan;
	mso-outline-level:7;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:Batang;
	mso-fareast-language:KO;}
p.MsoListBullet2, li.MsoListBullet2, div.MsoListBullet2
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	text-indent:-.25in;
	mso-pagination:widow-orphan;
	mso-list:l0 level1 lfo2;
	tab-stops:list .5in;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:Batang;
	mso-fareast-language:KO;}
p.MsoBodyText, li.MsoBodyText, div.MsoBodyText
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:6.0pt;
	margin-left:0in;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:Batang;
	mso-fareast-language:KO;}
p.MsoBodyTextIndent, li.MsoBodyTextIndent, div.MsoBodyTextIndent
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:6.0pt;
	margin-left:.25in;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:Batang;
	mso-fareast-language:KO;}
p.MsoBodyTextFirstIndent, li.MsoBodyTextFirstIndent, div.MsoBodyTextFirstIndent
	{mso-style-parent:"Body Text";
	margin-top:0in;
	margin-right:0in;
	margin-bottom:6.0pt;
	margin-left:0in;
	text-indent:10.5pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:Batang;
	mso-fareast-language:KO;}
p.MsoBodyTextFirstIndent2, li.MsoBodyTextFirstIndent2, div.MsoBodyTextFirstIndent2
	{mso-style-parent:"Body Text Indent";
	margin-top:0in;
	margin-right:0in;
	margin-bottom:6.0pt;
	margin-left:.25in;
	text-indent:10.5pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:Batang;
	mso-fareast-language:KO;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:595.45pt 841.7pt;
	margin:.5in 32.95pt 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:-125;
	mso-list-type:simple;
	mso-list-template-ids:-1167687448;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-style-link:"List Bullet 2";
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1
	{mso-list-id:1275554699;
	mso-list-type:hybrid;
	mso-list-template-ids:-885088526 -1172785824 67698691 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l1:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Times New Roman";
	mso-fareast-font-family:Batang;}
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
	border:solid black 1.0pt;
	mso-border-alt:solid black .5pt;
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-border-insideh:.5pt solid black;
	mso-border-insidev:.5pt solid black;
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

<p class=MsoNormal style='margin-right:4.5pt;text-indent:9.0pt;tab-stops:center 5.0in'><b><span
style='font-size:14.0pt'><%= dt_Com.Rows[0][0].ToString() %></span></b><b style='mso-bidi-font-weight:
normal'><span style='font-size:14.0pt'><span style='mso-tab-count:1'>                                        </span><o:p></o:p></span></b></p>

<p class=MsoNormal style='text-indent:9.0pt;tab-stops:center 5.0in'><b
style='mso-bidi-font-weight:normal'><%= dt_Com.Rows[0][1].ToString() %><span
style='mso-tab-count:1'>          </span><o:p></o:p></b></p>

<p class=MsoNormal style='text-indent:9.0pt;tab-stops:center 6.5in'><b
style='mso-bidi-font-weight:normal'>Tel: <%= dt_Com.Rows[0][2].ToString() %><span
style='mso-spacerun:yes'>     </span>Fax: <%= dt_Com.Rows[0][3].ToString() %></b></p>

<div style='mso-element:para-border-div;border:none;border-bottom:solid windowtext 1.0pt;
mso-border-bottom-alt:solid windowtext .5pt;padding:0in 0in 1.0pt 0in'>

<p class=MsoNormal style='tab-stops:center 6.5in;border:none;mso-border-bottom-alt:
solid windowtext .5pt;padding:0in;mso-padding-alt:0in 0in 1.0pt 0in'><span
style='mso-tab-count:1'>                                                                                                                                                            </span></p>

</div>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:center 5.0in'>S&#7889;: </p>

<p class=MsoNormal style='tab-stops:center 5.0in'>V/<span class=GramE>v :</span>
&#272;i&#7873;u chuy&#7875;n công vi&#7879;c cho nhân viên</p>

<p class=MsoNormal style='tab-stops:center 5.0in'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='tab-stops:center 5.0in'><span style='mso-tab-count:
1'>                                                                                         </span>Ngày 
<%=dt_emp.Rows[0][10].ToString() %> tháng <%=dt_emp.Rows[0][11].ToString() %> n&#259;m <%=dt_emp.Rows[0][12].ToString() %></p>

<p class=MsoNormal style='tab-stops:center 5.0in'><span style='mso-tab-count:
1'>                                                                                                                        </span></p>

<p class=MsoNormal style='margin-left:27.0pt;text-indent:-.25in;mso-list:l1 level1 lfo1;
tab-stops:list 27.0pt center 4.75in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-style:italic'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='mso-bidi-font-style:italic'>C&#259;n
c&#7913; vào trách nhi&#7879;m và quy&#7873;n<span style='mso-spacerun:yes'> 
</span>h&#7841;n c&#7911;a T&#7893;ng Giám &#272;&#7889;c<o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:27.0pt;text-indent:-.25in;mso-list:l1 level1 lfo1;
tab-stops:list 27.0pt center 4.75in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-style:italic'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='mso-bidi-font-style:italic'>C&#259;n
c&#7913; vào tình hình ho&#7841;t &#273;&#7897;ng s&#7843;n xu&#7845;t t&#7841;i
công ty<o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:27.0pt;text-indent:-.25in;mso-list:l1 level1 lfo1;
tab-stops:list 27.0pt center 4.75in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-style:italic'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='mso-bidi-font-style:italic'>Xét
&#273;&#7873; ngh&#7883; c&#7911;a Tr&#432;&#7903;ng b&#7897; ph&#7853;n<o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:.25in;tab-stops:center 4.75in'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='margin-left:.25in;tab-stops:center 4.75in'>T&#7893;ng
Giám &#272;&#7889;c <%= dt_Com.Rows[0][0].ToString() %> </p>

<p class=MsoNormal style='margin-left:.25in;tab-stops:center 4.75in'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal align=center style='margin-left:.25in;text-align:center;
tab-stops:center 4.75in'><b><span style='font-size:16.0pt'>QUY&#7870;T &#272;&#7882;NH<o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-left:63.0pt;text-indent:-45.0pt;tab-stops:
center 4.75in'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='margin-left:.25in;text-indent:-.25in;tab-stops:63.0pt center 4.75in'><b
style='mso-bidi-font-weight:normal'><u>&#272;i&#7873;u 1:</u></b> <span
style='mso-tab-count:1'>        </span>&#272;i&#7873;u chuy&#7875;n công vi&#7879;c
cho nhân viên sau:</p>

<p class=MsoNormal style='margin-left:49.5pt;text-align:justify;text-justify:
inter-ideograph;text-indent:-45.0pt;tab-stops:49.5pt center 4.75in'><o:p>&nbsp;</o:p></p>

<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 width=684
 style='width:513.0pt;margin-left:5.4pt;border-collapse:collapse;border:none;
 mso-border-alt:solid black .5pt;mso-yfti-tbllook:1184;mso-padding-alt:0in 5.4pt 0in 5.4pt;
 mso-border-insideh:.5pt solid black;mso-border-insidev:.5pt solid black'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:15.25pt'>
  <td width=42 rowspan=2 style='width:31.5pt;border:solid black 1.0pt;
  mso-border-alt:solid black .5pt;padding:0in 5.4pt 0in 5.4pt;height:15.25pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:49.5pt center 4.75in'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:10.0pt'>STT<o:p></o:p></span></b></p>
  </td>
  <td width=138 rowspan=2 style='width:103.5pt;border:solid black 1.0pt;
  border-left:none;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:15.25pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:49.5pt center 4.75in'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:10.0pt'>H&#7884;
  TÊN<o:p></o:p></span></b></p>
  </td>
  <td width=264 colspan=3 style='width:2.75in;border:solid black 1.0pt;
  border-left:none;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:15.25pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:49.5pt center 4.75in'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:10.0pt'>T&#7914;<o:p></o:p></span></b></p>
  </td>
  <td width=240 colspan=3 style='width:2.5in;border:solid black 1.0pt;
  border-left:none;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:15.25pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:49.5pt center 4.75in'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:10.0pt'>SANG<o:p></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1'>
  <td width=96 style='width:1.0in;border-top:none;border-left:none;border-bottom:
  solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:solid black .5pt;
  mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:49.5pt center 4.75in'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:10.0pt'>B&#7896;
  PH&#7852;N<o:p></o:p></span></b></p>
  </td>
  <td width=90 style='width:67.5pt;border-top:none;border-left:none;border-bottom:
  solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:solid black .5pt;
  mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:49.5pt center 4.75in'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:10.0pt'>NHÓM<o:p></o:p></span></b></p>
  </td>
  <td width=78 style='width:58.5pt;border-top:none;border-left:none;border-bottom:
  solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:solid black .5pt;
  mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:49.5pt center 4.75in'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:10.0pt'>CH&#7912;C
  V&#7908;<o:p></o:p></span></b></p>
  </td>
  <td width=90 style='width:67.5pt;border-top:none;border-left:none;border-bottom:
  solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:solid black .5pt;
  mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:49.5pt center 4.75in'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:10.0pt'>B&#7896;
  PH&#7852;N<o:p></o:p></span></b></p>
  </td>
  <td width=84 style='width:63.0pt;border-top:none;border-left:none;border-bottom:
  solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:solid black .5pt;
  mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:49.5pt center 4.75in'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:10.0pt'>NHÓM<o:p></o:p></span></b></p>
  </td>
  <td width=66 style='width:49.5pt;border-top:none;border-left:none;border-bottom:
  solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:solid black .5pt;
  mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:49.5pt center 4.75in'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:10.0pt'>CH&#7912;C
  V&#7908;<o:p></o:p></span></b></p>
  </td>
 </tr>
   <%
   int count =0;
    for (int i = 0; i < dt_emp.Rows.Count; i++)
    {        
        count++;
 %>
 <tr style='mso-yfti-irow:2'>
  <td width=42 style='width:31.5pt;border:solid black 1.0pt;border-top:none;
  mso-border-top-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:49.5pt center 4.75in'><span
  style='font-size:10.0pt'><%= count %><o:p></o:p></span></p>
  </td>
  <td width=138 style='width:103.5pt;border-top:none;border-left:none;
  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:
  solid black .5pt;mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:49.5pt center 4.75in'><span
  style='font-size:10.0pt'><%=dt_emp.Rows[i][1].ToString() %><o:p></o:p></span></p>
  </td>
  <td width=96 style='width:1.0in;border-top:none;border-left:none;border-bottom:
  solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:solid black .5pt;
  mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:49.5pt center 4.75in'><span
  style='font-size:10.0pt'><%=dt_emp.Rows[i][3].ToString() %><o:p></o:p></span></p>
  </td>
  <td width=90 style='width:67.5pt;border-top:none;border-left:none;border-bottom:
  solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:solid black .5pt;
  mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:49.5pt center 4.75in'><span
  style='font-size:10.0pt'><%=dt_emp.Rows[i][5].ToString() %><o:p></o:p></span></p>
  </td>
  <td width=78 style='width:58.5pt;border-top:none;border-left:none;border-bottom:
  solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:solid black .5pt;
  mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:49.5pt center 4.75in'><span
  style='font-size:10.0pt'><%=dt_emp.Rows[i][4].ToString() %><o:p></o:p></span></p>
  </td>
  <td width=90 style='width:67.5pt;border-top:none;border-left:none;border-bottom:
  solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:solid black .5pt;
  mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:49.5pt center 4.75in'><span
  style='font-size:10.0pt'><%=dt_emp.Rows[i][6].ToString() %><o:p></o:p></span></p>
  </td>
  <td width=84 style='width:63.0pt;border-top:none;border-left:none;border-bottom:
  solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:solid black .5pt;
  mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:49.5pt center 4.75in'><span
  style='font-size:10.0pt'><%=dt_emp.Rows[i][8].ToString() %><o:p></o:p></span></p>
  </td>
  <td width=66 style='width:49.5pt;border-top:none;border-left:none;border-bottom:
  solid black 1.0pt;border-right:solid black 1.0pt;mso-border-top-alt:solid black .5pt;
  mso-border-left-alt:solid black .5pt;mso-border-alt:solid black .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:49.5pt center 4.75in'><span
  style='font-size:10.0pt'><%=dt_emp.Rows[i][7].ToString() %><o:p></o:p></span></p>
  </td>
 </tr>
 <%} %>
</table>

<p class=MsoNormal align=center style='margin-left:49.5pt;text-align:center;
text-indent:-45.0pt;tab-stops:49.5pt center 4.75in'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='margin-left:49.5pt;text-align:justify;text-justify:
inter-ideograph;text-indent:-45.0pt;line-height:150%;tab-stops:49.5pt center 4.75in'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='margin-left:.25in;text-indent:-.25in;line-height:
150%;tab-stops:63.0pt center 4.75in'><b style='mso-bidi-font-weight:normal'><u>&#272;i&#7873;u
2:</u></b><span style='mso-tab-count:1'>         </span>Yêu c&#7847;u nhân viên
trên <span class=GramE>ti&#7871;p<span style='mso-spacerun:yes'>  </span>nh&#7853;n</span>
công vi&#7879;c m&#7899;i và hoàn thành t&#7889;t nhi&#7879;m v&#7909;
&#273;&#432;&#7907;c giao.</p>

<p class=MsoNormal style='margin-left:.25in;text-indent:-.25in;line-height:
150%;tab-stops:63.0pt center 4.75in'><b style='mso-bidi-font-weight:normal'><u>&#272;i&#7873;u
3:</u></b><span style='mso-tab-count:1'>         </span>L&#432;&#417;ng và các
kho&#7843;n ph&#7909; c&#7845;p không thay &#273;&#7893;i so v&#7899;i tr&#432;&#7899;c
&#273;ây</p>

<p class=MsoNormal style='margin-left:.25in;text-indent:-.25in;line-height:
150%;tab-stops:63.0pt center 4.75in'><b style='mso-bidi-font-weight:normal'><u>&#272;i&#7873;u
4:</u></b> <span style='mso-tab-count:1'>        </span>Các nhân viên trên, tr&#432;&#7903;ng
các b&#7897; ph&#7853;n liên quan, tr&#432;&#7903;ng phòng nhân s&#7921; và k&#7871;
toán tr&#432;&#7903;ng có <span class=GramE>trách<span
style='mso-spacerun:yes'>  </span>nhi&#7879;m</span> thi hành quy&#7871;t
&#273;&#7883;nh này.</p>

<p class=MsoNormal style='margin-left:.25in;text-indent:-.25in;tab-stops:63.0pt center 4.75in'>Quy&#7871;t
&#273;&#7883;nh có hi&#7879;u l&#7921;c t&#7915; ngày <%=dt_emp.Rows[0][9].ToString() %></p>

<p class=MsoNormal style='margin-left:.25in;text-align:justify;text-justify:
inter-ideograph;tab-stops:63.0pt center 4.75in'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='margin-left:.25in;tab-stops:63.0pt center 4.75in'><span
style='mso-tab-count:2'>                                                                                </span><b><%= dt_Com.Rows[0][0].ToString() %>
<o:p></o:p></b></p>

<p class=MsoNormal style='margin-left:.25in;tab-stops:63.0pt center 4.75in'><b><span
style='mso-tab-count:2'>                                                                                   </span>GIÁM
&#272;&#7888;C HÀNH CHÁNH</b></p>

<p class=MsoNormal style='margin-left:.25in;text-indent:-.25in;tab-stops:63.0pt center 4.75in'>N&#417;i
nh&#7853;n:</p>

<p class=MsoNormal style='margin-left:.5in;text-indent:-.25in;mso-list:l1 level1 lfo1;
tab-stops:list .5in left 63.0pt center 4.75in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-style:italic'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='mso-bidi-font-style:italic'>Nh&#432;
trên;<o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:.5in;text-indent:-.25in;mso-list:l1 level1 lfo1;
tab-stops:list .5in left 63.0pt center 4.75in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Các phòng ban;</p>

<p class=MsoNormal style='margin-left:.5in;text-indent:-.25in;mso-list:l1 level1 lfo1;
tab-stops:list .5in left 63.0pt center 4.75in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>L&#432;u h&#7891; s&#417;,</p>

<p class=MsoNormal style='margin-left:.25in;tab-stops:63.0pt center 4.75in'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='margin-left:.25in;tab-stops:63.0pt center 4.75in'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='margin-left:.25in;tab-stops:63.0pt center 4.75in'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='margin-left:.25in;tab-stops:63.0pt center 4.75in'><span
style='mso-tab-count:2'>                                                                                            </span><b> <o:p></o:p></b></p>

</div>

</body>

</html>
