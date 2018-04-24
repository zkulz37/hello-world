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
    emp_pk       = Request["pk_list"].ToString();

    string SQL
     = "select b.FULL_NAME d1 " +
         ",c.org_lnm  d2 " +
         ",c.ORG_FNM d3  " +
         ",decode(length(b.BIRTH_DT),4,'01/01/'||b.BIRTH_DT,to_char(to_date(b.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy')) d4 " +
         ",(select t.CODE_FNM from vhr_hr_code t where t.ID='HR0008' and t.CODE= b.POS_TYPE) d5 " +
         ",(select t.CODE_NM from vhr_hr_code t where t.ID='HR0008' and t.CODE= b.POS_TYPE) d6 " +
         ",to_char(to_date(b.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') d7 " +
         ",b.EMP_ID d8 " +
         ",to_char(to_date(b.LEFT_DT,'yyyymmdd'),'dd/mm/yyyy') d9 " +
         ",to_char(sysdate,'yyyymmdd') d10 " +
         "from thr_employee_resign a, thr_employee b, comm.tco_org c " +
         "where a.del_if=0 and b.del_if=0 and c.del_if=0 " +
         "and a.THR_EMP_PK = b.PK " +
         "and b.TCO_ORG_PK = c.PK " +
         "and a.pk in ("+ emp_pk +") ";
        
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
<link rel=File-List href="rpt_dimissal_resign_vhpc_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_dimissal_resign_vhpc_files/editdata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<title> </title>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="country-region"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="place"/>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Posco</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>13</o:TotalTime>
  <o:LastPrinted>2011-01-27T02:05:00Z</o:LastPrinted>
  <o:Created>2011-03-18T03:57:00Z</o:Created>
  <o:LastSaved>2011-03-18T03:57:00Z</o:LastSaved>
  <o:Pages>2</o:Pages>
  <o:Words>388</o:Words>
  <o:Characters>2218</o:Characters>
  <o:Company>Posco</o:Company>
  <o:Lines>18</o:Lines>
  <o:Paragraphs>5</o:Paragraphs>
  <o:CharactersWithSpaces>2601</o:CharactersWithSpaces>
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-520092929 1073786111 9 0 415 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin-top:0in;
	margin-right:0in;
	margin-bottom:10.0pt;
	margin-left:0in;
	line-height:115%;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:Calibri;
	mso-fareast-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";}
p.ListParagraph, li.ListParagraph, div.ListParagraph
	{mso-style-name:"List Paragraph";
	margin-top:0in;
	margin-right:0in;
	margin-bottom:10.0pt;
	margin-left:.5in;
	mso-add-space:auto;
	line-height:115%;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:Calibri;
	mso-fareast-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";}
p.ListParagraphCxSpFirst, li.ListParagraphCxSpFirst, div.ListParagraphCxSpFirst
	{mso-style-name:"List ParagraphCxSpFirst";
	mso-style-type:export-only;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	mso-add-space:auto;
	line-height:115%;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:Calibri;
	mso-fareast-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";}
p.ListParagraphCxSpMiddle, li.ListParagraphCxSpMiddle, div.ListParagraphCxSpMiddle
	{mso-style-name:"List ParagraphCxSpMiddle";
	mso-style-type:export-only;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	mso-add-space:auto;
	line-height:115%;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:Calibri;
	mso-fareast-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";}
p.ListParagraphCxSpLast, li.ListParagraphCxSpLast, div.ListParagraphCxSpLast
	{mso-style-name:"List ParagraphCxSpLast";
	mso-style-type:export-only;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:10.0pt;
	margin-left:.5in;
	mso-add-space:auto;
	line-height:115%;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:Calibri;
	mso-fareast-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:595.45pt 841.7pt;
	margin:27.35pt .9in 1.0in 1.0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:922379543;
	mso-list-type:hybrid;
	mso-list-template-ids:1204607126 -559232710 67698691 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;
	mso-fareast-font-family:Calibri;
	mso-bidi-font-family:Arial;}
@list l1
	{mso-list-id:2002149349;
	mso-list-type:hybrid;
	mso-list-template-ids:-1047657910 1646552064 67698691 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l1:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Arial;
	mso-fareast-font-family:Calibri;}
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
	font-family:Calibri;
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
<p class=MsoNormal><span style='font-size:12.0pt;line-height:115%'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center style='text-align:center'><span
style='mso-no-proof:yes'><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
 coordsize="21600,21600" o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe"
 filled="f" stroked="f">
 <v:stroke joinstyle="miter"/>
 <v:formulas>
  <v:f eqn="if lineDrawn pixelLineWidth 0"/>
  <v:f eqn="sum @0 1 0"/>
  <v:f eqn="sum 0 0 @1"/>
  <v:f eqn="prod @2 1 2"/>
  <v:f eqn="prod @3 21600 pixelWidth"/>
  <v:f eqn="prod @3 21600 pixelHeight"/>
  <v:f eqn="sum @0 0 1"/>
  <v:f eqn="prod @6 1 2"/>
  <v:f eqn="prod @7 21600 pixelWidth"/>
  <v:f eqn="sum @8 21600 0"/>
  <v:f eqn="prod @7 21600 pixelHeight"/>
  <v:f eqn="sum @10 21600 0"/>
 </v:formulas>
 <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
 <o:lock v:ext="edit" aspectratio="t"/>
</v:shapetype><v:shape id="Picture_x0020_1" o:spid="_x0000_i1025" type="#_x0000_t75"
 style='width:156.75pt;height:40.5pt;visibility:visible'>
 <v:imagedata src="rpt_dimissal_resign_vhpc_files/image001.png" o:title=""/>
</v:shape><![endif]--><![if !vml]><img width=209 height=54
src="rpt_dimissal_resign_vhpc_files/image002.jpg" v:shapes="Picture_x0020_1"><![endif]><o:p></o:p></span></p>

<p class=MsoNormal><span style='font-size:10.0pt;line-height:115%;font-family:
Arial'>Công Ty TNHH Trung Tâm Gia Công POSCO Vi&#7879;t Nam <span
style='mso-spacerun:yes'>      </span><span style='mso-spacerun:yes'>   </span>C&#7897;ng
Hòa<span style='mso-spacerun:yes'>  </span>Xã H&#7897;i Ch&#7911; Ngh&#297;a Vi&#7879;t
Nam <span style='mso-spacerun:yes'>                           </span><i
style='mso-bidi-font-style:normal'>POSCO VIETNAM Processing Center Co.,
Ltd<span style='mso-spacerun:yes'>         </span><span
style='mso-spacerun:yes'>                     </span><span
style='mso-spacerun:yes'> </span>Socialist<span style='mso-spacerun:yes'> 
</span>Republic Of VietNam<span style='mso-spacerun:yes'>                     
</span>&#272;&#432;&#7901;ng N2,KCN Nh&#417;n Tr&#7841;ch V – &#272;&#7891;ng
Nai</i><span style='mso-tab-count:3'>                                  </span><span
style='mso-spacerun:yes'>  </span>&#272;&#7897;c L&#7853;p – T&#7921; Do – H&#7841;nh
Phúc<span style='mso-tab-count:1'> </span><span
style='mso-spacerun:yes'>                     </span>S&#7889; : VHPC/<%= dt_total.Rows[i][7].ToString() %><span
style='mso-tab-count:2'>                        </span><span
style='mso-spacerun:yes'>                                 </span><span
style='mso-spacerun:yes'>      </span><span style='mso-spacerun:yes'> </span><span
style='mso-spacerun:yes'> </span><span style='mso-spacerun:yes'>        </span><i
style='mso-bidi-font-style:normal'>Independence - Freedom – Happiness<span
style='mso-spacerun:yes'>    </span><span
style='mso-spacerun:yes'>                </span><span
style='mso-spacerun:yes'> </span><span style='mso-tab-count:3'>                               </span><span
style='mso-tab-count:3'>                                    </span><span
style='mso-spacerun:yes'>        </span><span style='mso-tab-count:3'>                            </span><span
style='mso-spacerun:yes'>    </span><span style='mso-spacerun:yes'> </span>***<span
style='mso-spacerun:yes'>  </span><span style='mso-tab-count:2'>             </span><span
style='mso-spacerun:yes'>                 </span><span
style='mso-spacerun:yes'>     </span><span
style='mso-spacerun:yes'>        </span></i><o:p></o:p></span></p>

<p class=MsoNormal align=right style='text-align:right'><span style='font-size:
12.0pt;line-height:115%'><span style='mso-tab-count:5'>                                                            </span></span><span
style='font-size:12.0pt;line-height:115%;mso-bidi-font-family:Arial'><span
style='mso-spacerun:yes'>      </span><span style='mso-tab-count:4'>                                          </span></span><span
style='font-size:12.0pt;line-height:115%;font-family:Arial'><span
style='mso-spacerun:yes'> </span><span
style='mso-spacerun:yes'>                                  </span><i
style='mso-bidi-font-style:normal'>&#272;&#7891;ng Nai, ngày <%= (dt_total.Rows[i][8].ToString()).Substring(0,2).ToString() %> tháng <%= (dt_total.Rows[i][8].ToString()).Substring(3,2).ToString() %>
n&#259;m <%= (dt_total.Rows[i][8].ToString()).Substring(6,4).ToString() %>.<o:p></o:p></i></span></p>

<p class=MsoNormal align=right style='text-align:right'><i style='mso-bidi-font-style:
normal'><span style='font-size:12.0pt;line-height:115%;font-family:Arial'><o:p>&nbsp;</o:p></span></i></p>

<p class=MsoNormal align=center style='text-align:center'><b style='mso-bidi-font-weight:
normal'><span style='font-size:12.0pt;line-height:115%;font-family:Arial'>T&#7892;NG
GIÁM &#272;&#7888;C CÔNG TY TNHH TRUNG TÂM GIA CÔNG POSCO VI&#7878;T <st1:country-region
w:st="on"><st1:place w:st="on">NAM</st1:place></st1:country-region><o:p></o:p></span></b></p>

<p class=MsoNormal align=center style='text-align:center'><i style='mso-bidi-font-style:
normal'><span style='font-family:Arial'>GENERAL DIRECTOR OF POSCO <st1:country-region
w:st="on"><st1:place w:st="on">VIETNAM</st1:place></st1:country-region>
PROCESSING CENTER O., LTD<o:p></o:p></span></i></p>

<p class=ListParagraphCxSpFirst style='text-align:justify;text-indent:-.25in;
mso-list:l0 level1 lfo2'><![if !supportLists]><span style='font-size:12.0pt;
line-height:115%;font-family:Symbol;mso-fareast-font-family:Symbol;mso-bidi-font-family:
Symbol'><span style='mso-list:Ignore'>·<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='font-size:12.0pt;line-height:115%;
font-family:Arial'>C&#259;n c&#7913; gi&#7845;y phép &#273;&#7847;u t&#432; s&#7889;
472023000152 &#273;&#432;&#7907;c Ban Qu&#7843;n Lý Khu C</span><span
style='font-size:12.0pt;line-height:115%'>ô</span><span style='font-size:12.0pt;
line-height:115%;font-family:Arial'>ng Nghi&#7879;p &#272;&#7891;ng Nai c&#7845;p
ngày 04/06/2007.<o:p></o:p></span></p>

<p class=ListParagraphCxSpMiddle style='text-align:justify'><i
style='mso-bidi-font-style:normal'><span style='font-family:Arial'>Base on the
Investment license no. 472023000152 approved on 04 June 2007 by the Dong Nai
Industrial Zones Authority</span></i><span style='font-size:12.0pt;line-height:
115%;font-family:Arial'>.<o:p></o:p></span></p>

<p class=ListParagraphCxSpMiddle style='text-align:justify;text-indent:-.25in;
mso-list:l0 level1 lfo2'><![if !supportLists]><span style='font-size:12.0pt;
line-height:115%;font-family:Symbol;mso-fareast-font-family:Symbol;mso-bidi-font-family:
Symbol'><span style='mso-list:Ignore'>·<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='font-size:12.0pt;line-height:115%;
font-family:Arial'>C&#259;n c&#7913; trách nhi&#7879;m và quy&#7873;n h&#7841;n
c&#7911;a T&#7893;ng Giám &#272;&#7889;c công ty<o:p></o:p></span></p>

<p class=ListParagraphCxSpMiddle style='text-align:justify'><i
style='mso-bidi-font-style:normal'><span style='font-family:Arial'>Base on the
responsibility and authority of the General Director<o:p></o:p></span></i></p>

<p class=ListParagraphCxSpMiddle style='text-align:justify'><span
style='font-size:12.0pt;line-height:115%;font-family:Arial'><o:p>&nbsp;</o:p></span></p>

<p class=ListParagraphCxSpMiddle align=center style='text-align:center'><b
style='mso-bidi-font-weight:normal'><span style='font-size:18.0pt;line-height:
115%;font-family:Arial'>QUY&#7870;T &#272;&#7882;NH <o:p></o:p></span></b></p>

<p class=ListParagraphCxSpLast align=center style='text-align:center'><b
style='mso-bidi-font-weight:normal'><i style='mso-bidi-font-style:normal'><span
style='font-size:14.0pt;line-height:115%;font-family:Arial'>DECISION
<o:p></o:p></span></i></b></p>

<p class=MsoNormal style='text-align:justify'><span style='font-size:12.0pt;
line-height:115%;font-family:Arial'><span style='mso-tab-count:1'>            </span>&#272;i&#7873;u
1<span style='mso-tab-count:2'>                        </span><span
class=GramE>Thôi</span> việc nhân viên/</span><i style='mso-bidi-font-style:
normal'><span style='font-family:Arial'>Decision</span></i><span
style='font-size:12.0pt;line-height:115%;font-family:Arial'><span
style='mso-tab-count:1'>           </span>:<span style='mso-tab-count:1'>           </span><%= dt_total.Rows[i][0].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-size:12.0pt;
line-height:115%;font-family:Arial'><span style='mso-tab-count:1'>            </span></span><i
style='mso-bidi-font-style:normal'><span style='font-family:Arial'>Article
1<span style='mso-spacerun:yes'>           </span></span></i><span
style='font-size:12.0pt;line-height:115%;font-family:Arial'>Mã s&#7889; nhân
viên/ </span><i style='mso-bidi-font-style:normal'><span style='font-family:
Arial'>Code</span></i><span style='font-size:12.0pt;line-height:115%;
font-family:Arial'><span style='mso-tab-count:1'>       </span>:<span
style='mso-tab-count:1'>           </span><%= dt_total.Rows[i][7].ToString() %><span style='mso-tab-count:
1'>        </span></span><i style='mso-bidi-font-style:normal'><span
style='font-family:Arial'><o:p></o:p></span></i></p>

<p class=MsoNormal style='text-align:justify'><span style='font-size:12.0pt;
line-height:115%;font-family:Arial'><span style='mso-tab-count:3'>                                    </span>Ngày
gia nh&#7853;p/</span><i style='mso-bidi-font-style:normal'><span
style='font-family:Arial'>Date of Join</span></i><span style='font-size:12.0pt;
line-height:115%;font-family:Arial'><span style='mso-tab-count:1'> </span>:<span
style='mso-tab-count:1'>           </span><%= dt_total.Rows[i][6].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-size:12.0pt;
line-height:115%;font-family:Arial'><span style='mso-tab-count:3'>                                    </span>B&#7897;
ph&#7853;n/ </span><i style='mso-bidi-font-style:normal'><span
style='font-family:Arial'>Dept’</span></i><span style='font-size:12.0pt;
line-height:115%;font-family:Arial'><span style='mso-tab-count:2'>                      </span>:
<span style='mso-tab-count:1'>          </span><%= dt_total.Rows[i][1].ToString() %> / <i
style='mso-bidi-font-style:normal'><%= dt_total.Rows[i][2].ToString() %></i><o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-size:12.0pt;
line-height:115%;font-family:Arial'><span style='mso-tab-count:3'>                                    </span>Ch&#7913;c
v&#7909;/ </span><i style='mso-bidi-font-style:normal'><span style='font-family:
Arial'>Position</span></i><span style='font-size:12.0pt;line-height:115%;
font-family:Arial'><span style='mso-tab-count:2'>                 </span>: <span
style='mso-tab-count:1'>          </span><%= dt_total.Rows[i][4].ToString() %> /<i style='mso-bidi-font-style:
normal'><%= dt_total.Rows[i][5].ToString() %></i><o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-size:12.0pt;
line-height:115%;font-family:Arial'><span style='mso-tab-count:3'>                                    </span><span
class=GramE>Thôi</span> việc ngày/ </span><i style='mso-bidi-font-style:
normal'><span style='font-family:Arial'>From<span style='mso-tab-count:1'>   </span></span></i><span
style='font-size:12.0pt;line-height:115%;font-family:Arial'>:<span style='mso-tab-count:1'>           </span><%= dt_total.Rows[i][8].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-size:12.0pt;
line-height:115%;font-family:Arial'><span style='mso-tab-count:1'>            </span>&#272;i&#7873;u
2<span style='mso-tab-count:2'>                        </span>Hình th&#7913;c <span
class=GramE>thôi</span> việc/ </span><i style='mso-bidi-font-style:normal'><span
style='font-family:Arial'>Decision form<o:p></o:p></span></i></p>

<p class=MsoNormal style='text-align:justify'><span style='font-size:12.0pt;
line-height:115%;font-family:Arial'><span style='mso-tab-count:2'>                        </span><span
style='mso-spacerun:yes'>          </span>Theo &#273;i&#7873;u 85 Kho&#7843;n 1
M&#7909;c c c&#7911;a B&#7897; lu&#7853;t <span class=GramE>lao</span> &#273;&#7897;ng<o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-size:12.0pt;
line-height:115%;font-family:Arial'><span style='mso-tab-count:1'>            </span></span><i
style='mso-bidi-font-style:normal'><span style='font-family:Arial'>Article 2</span></i><span
style='font-size:12.0pt;line-height:115%;font-family:Arial'><span
style='mso-tab-count:1'>           </span></span><i style='mso-bidi-font-style:
normal'><span style='font-family:Arial'>According to article of 85 <span
class=GramE>item</span> 1c of <st1:country-region w:st="on"><st1:place w:st="on">Vietnam</st1:place></st1:country-region>
labor code<o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-left:1.5in;text-align:justify;text-indent:
-1.0in'><span style='font-size:12.0pt;line-height:115%;font-family:Arial'>&#272;i&#7873;u
3<span style='mso-tab-count:1'>            </span>Anh/Ch&#7883; <%= dt_total.Rows[i][0].ToString() %>
có nhi&#7879;m v&#7909; bàn giao các v&#7853;</span><span style='font-size:
12.0pt;line-height:115%'>t d</span><span style='font-size:12.0pt;line-height:
115%;font-family:Arial'>&#7909;ng &#273;ã &#273;&#432;&#7907;c c&#7845;p phát (n&#7871;u
có) ho&#7863;c công vi&#7879;c d&#7905; dang cho tr&#432;&#7903;ng b&#7897; ph&#7853;n</span><span
style='font-size:12.0pt;line-height:115%'><o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:1.5in;text-align:justify;text-indent:
-1.0in'><i style='mso-bidi-font-style:normal'><span style='font-family:Arial'>Article
3</span></i><span style='font-size:12.0pt;line-height:115%;font-family:Arial'><span
style='mso-tab-count:1'>           </span></span><i style='mso-bidi-font-style:
normal'><span style='font-family:Arial'>Mr/Ms. <%= CommondLib.bodau(dt_total.Rows[i][0].ToString()) %> has the responsible
to transfer all of things received (if any) or job remaining to your supervisor<o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-left:1.5in;text-align:justify;text-indent:
-1.0in'><span style='font-size:12.0pt;line-height:115%;font-family:Arial'>&#272;i&#7873;u
4<span style='mso-tab-count:1'>            </span>Phòng Nhân s&#7921;, phòng K&#7871;
toán, các b&#7897; ph&#7853;n liên quan và <o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:1.5in;text-align:justify;text-indent:
-1.0in'><span style='font-size:12.0pt;line-height:115%;font-family:Arial'><span
style='mso-tab-count:1'>                        </span><span class=GramE>Anh/Ch&#7883;
<%= dt_total.Rows[i][0].ToString() %> có trách nhi&#7879;m thi hành quy&#7871;t &#273;&#7883;nh
này.</span><o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:1.5in;text-align:justify;text-indent:
-1.0in'><i style='mso-bidi-font-style:normal'><span style='font-size:12.0pt;
line-height:115%;font-family:Arial'>Article 4</span></i><span style='font-size:
12.0pt;line-height:115%;font-family:Arial'><span style='mso-tab-count:1'>          </span></span><i
style='mso-bidi-font-style:normal'><span style='font-family:Arial'>Human
Resources, Financial Accounting and related department and Mr/Ms. <%= CommondLib.bodau(dt_total.Rows[i][0].ToString()) %> has
responsible to execute this decision<o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-left:1.5in;text-align:justify;text-indent:
-1.0in'><span style='font-size:12.0pt;line-height:115%;font-family:Arial'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-size:12.0pt;
line-height:115%;font-family:Arial'><span
style='mso-spacerun:yes'>               </span>GIÁM &#272;&#7888;C<span
style='mso-spacerun:yes'>                                                                       
</span>T&#7892;NG GIÁM &#272;&#7888;C<span
style='mso-spacerun:yes'>                  </span><span
style='mso-spacerun:yes'>                                        </span><span
style='mso-spacerun:yes'> </span><o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify'><i style='mso-bidi-font-style:
normal'><span style='font-family:Arial'><span style='mso-spacerun:yes'> 
</span><span style='mso-spacerun:yes'>        </span>GENERAL MANAGER<span
style='mso-spacerun:yes'>      </span><span
style='mso-spacerun:yes'>           </span><span
style='mso-spacerun:yes'>                                               </span>GENERAL
DIRECTOR<span style='mso-spacerun:yes'>             </span><span
style='mso-spacerun:yes'>                                            </span><span
style='mso-spacerun:yes'>  </span><o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-left:1.5in;text-align:justify;text-indent:
-1.0in'><span style='font-size:12.0pt;line-height:115%;font-family:Arial'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-left:1.5in;text-align:justify;text-indent:
-1.0in'><span style='font-size:12.0pt;line-height:115%;font-family:Arial'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-size:12.0pt;
line-height:115%;font-family:Arial;mso-ansi-language:SV'><span
style='mso-spacerun:yes'> </span><span lang=SV><span
style='mso-spacerun:yes'>          </span>PARK HAE HWA<span
style='mso-spacerun:yes'>       </span><span
style='mso-spacerun:yes'>                                                          </span>BANG
YEONG SIG<span style='mso-spacerun:yes'>               </span><span
style='mso-spacerun:yes'>              </span><span
style='mso-spacerun:yes'>                            </span><o:p></o:p></span></span></p>

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
