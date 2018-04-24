<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/msword";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:w="urn:schemas-microsoft-com:office:word"
xmlns:st1="urn:schemas-microsoft-com:office:smarttags"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    
    string emp_pk;
    
    emp_pk       = Request["emp_pk"].ToString();
    string SQL
    = " select 1  " +
        ",a.FULL_NAME col1 " +
        ",to_char(to_date(a.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy') col2 " +
        ",b.new  col3 " +
        ",b.old  col4 " +
        ",to_char(sysdate,'dd') col5 " +
        ",to_char(sysdate,'mm') col6 " +
        ",to_char(sysdate,'yyyy') col7  " +
        "from thr_employee a,thr_ins_modify b  " +
        "where a.del_if=0 and b.del_if=0 and b.thr_emp_pk =a.pk  " +
        "and b.pk in (" + emp_pk + ") " ;
        
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
<link rel=File-List href="rpt_cv_dieuchinhsoso_hyosung_files/filelist.xml">
<title>Công ty TNHH Hyosung Vi&#7879;t Nam                           C&#7896;NG
HOÀ XÃ H&#7896;I CH&#7910; NGH&#296;A VI&#7878;T NAM</title>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="place"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="country-region"/>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Thuy Lan</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:Revision>1</o:Revision>
  <o:TotalTime>0</o:TotalTime>
  <o:LastPrinted>2011-11-04T03:13:00Z</o:LastPrinted>
  <o:Created>2011-11-11T06:08:00Z</o:Created>
  <o:LastSaved>2011-11-11T06:08:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>272</o:Words>
  <o:Characters>1554</o:Characters>
  <o:Company>HP Compaq</o:Company>
  <o:Lines>12</o:Lines>
  <o:Paragraphs>3</o:Paragraphs>
  <o:CharactersWithSpaces>1823</o:CharactersWithSpaces>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
 <o:OfficeDocumentSettings>
  <o:AllowPNG/>
  <o:TargetScreenSize>1024x768</o:TargetScreenSize>
 </o:OfficeDocumentSettings>
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
	{font-family:Batang;
	panose-1:2 3 6 0 0 1 1 1 1 1;
	mso-font-alt:\BC14\D0D5;
	mso-font-charset:129;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-1342176593 1775729915 48 0 524447 0;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-520077569 -1073717157 41 0 66047 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-520092929 1073786111 9 0 415 0;}
@font-face
	{font-family:VNI-Times;
	panose-1:0 0 0 0 0 0 0 0 0 0;
	mso-font-charset:0;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:3 0 0 0 1 0;}
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
	font-family:VNI-Times;
	mso-fareast-font-family:Batang;
	mso-bidi-font-family:"Times New Roman";
	mso-fareast-language:KO;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-noshow:yes;
	mso-style-link:" Char Char";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:8.0pt;
	font-family:Tahoma;
	mso-fareast-font-family:Batang;
	mso-fareast-language:KO;}
span.CharChar
	{mso-style-name:" Char Char";
	mso-style-noshow:yes;
	mso-style-locked:yes;
	mso-style-parent:"";
	mso-style-link:"Balloon Text";
	mso-ansi-font-size:8.0pt;
	mso-bidi-font-size:8.0pt;
	font-family:Tahoma;
	mso-ascii-font-family:Tahoma;
	mso-fareast-font-family:Batang;
	mso-hansi-font-family:Tahoma;
	mso-bidi-font-family:Tahoma;
	mso-fareast-language:KO;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:.3in .5in .6in .5in;
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
	font-family:Calibri;
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
	mso-fareast-font-family:Batang;
	mso-ansi-language:#0400;
	mso-fareast-language:KO;
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

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:"Times New Roman"'>Công ty TNHH Hyosung Vi&#7879;t <st1:country-region
w:st="on">Nam</st1:country-region></span></b><span style='font-family:"Times New Roman"'><span
style='mso-spacerun:yes'>                </span><span
style='mso-spacerun:yes'>           </span><b style='mso-bidi-font-weight:normal'>C&#7896;NG
HOÀ XÃ H&#7896;I CH&#7910; NGH&#296;A VI&#7878;T <st1:country-region w:st="on"><st1:place
 w:st="on">NAM</st1:place></st1:country-region><o:p></o:p></b></span></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:"Times New Roman"'>&#272;&#432;&#7901;ng N2-KCN Nh&#417;n Tr&#7841;ch
V-&#272;N</span></b><span style='font-family:"Times New Roman"'><span
style='mso-spacerun:yes'>                            </span><span
style='mso-spacerun:yes'>             </span><b style='mso-bidi-font-weight:
normal'>&#272;&#7897;c l&#7853;p - T&#7921; do - H&#7841;nh phúc</b><o:p></o:p></span></p>



<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
style='font-family:"Times New Roman"'>S&#7889;: 17CV - HSOVN<o:p></o:p></span></b></p>

<p class=MsoNormal><span style='font-family:"Times New Roman"'><span
style='mso-spacerun:yes'> </span>(V/v:<span style='mso-spacerun:yes'>  </span>H&#7911;y
s&#7889; s&#7893; <span class=GramE>BHXH<span style='mso-spacerun:yes'> 
</span>&#273;ã</span> c&#7845;p)<span style='mso-spacerun:yes'>               
</span><span style='mso-spacerun:yes'>                           </span>&#272;&#7891;ng
Nai, <span class=GramE>ngày<span style='mso-spacerun:yes'>  </span><%= dt_total.Rows[0][5].ToString() %></span><span
style='mso-spacerun:yes'>  </span>tháng<span style='mso-spacerun:yes'>   
</span><%= dt_total.Rows[0][6].ToString() %> n&#259;m <%= dt_total.Rows[0][7].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal><span style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center style='text-align:center'><b style='mso-bidi-font-weight:
normal'><span style='font-size:20.0pt;font-family:"Times New Roman"'>CÔNG
V&#258;N &#272;&#7872; NGH&#7882; &#272;I&#7872;U CH&#7880;NH S&#7888; S&#7892;<o:p></o:p></span></b></p>

<p class=MsoNormal><span style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center style='text-align:center'><i style='mso-bidi-font-style:
normal'><u><span style='font-family:"Times New Roman"'>Kính g&#7917;i</span></u></i><span
style='font-family:"Times New Roman"'>: </span><b style='mso-bidi-font-weight:
normal'><span style='font-size:14.0pt;font-family:"Times New Roman"'>B&#7842;O
HI&#7874;M XÃ H&#7896;I HUY&#7878;N NH&#416;N TR&#7840;CH</span></b><span
style='font-family:"Times New Roman"'><o:p></o:p></span></p>

<p class=MsoNormal><span style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span style='font-family:"Times New Roman"'><span
style='mso-tab-count:1'>            </span>Cty TNHH HYOSUNG là công ty 100% v&#7889;n
n&#432;&#7899;c ngoài có nhà máy &#273;&#7863;t t&#7841;i KCN Nh&#417;n Tr&#7841;ch
5, huy&#7879;n Nh&#417;n Tr&#7841;ch, T&#7881;nh &#272;&#7891;ng Nai theo gi&#7845;y
phép &#273;&#7847;u t&#432; s&#7889;:472043000143/GP- KCN - &#272;N do do BQL
các KCN &#272;&#7891;ng Nai c&#7845;p ngày : 22/05/2007.<o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-indent:.5in'><span
style='font-family:"Times New Roman"'>Trong quá trình khai báo tham gia b&#7843;o
hi&#7875;m xã h&#7897;i, Khi cty chúng tôi làm m&#7851;u 02A – TBH &#273;&#7875;
tham gia BHXH cho ng&#432;&#7901;i L&#272; và &#273;ã &#273;&#432;&#7907;c
c&#417; quan BHXH huy&#7879;n nh&#417;n tr&#7841;ch c&#7845;p s&#7889; s&#7893;
m&#7899;i.<span style='mso-spacerun:yes'>  </span>Do ng&#432;&#7901;i lao
&#273;&#7897;ng tr&#432;&#7899;c &#273;ây &#273;ã <span class=GramE>&#273;&#432;&#7907;c<span
style='mso-spacerun:yes'>  </span>c&#7845;p</span> s&#7893; b&#7843;o hi&#7875;m
&#7903; cty c&#361; nh&#432;ng khi vào làm &#273;ã không n&#7897;p, c&#361;ng
không kê khai s&#7889; s&#7893; BHXH. <span class=GramE>Cho &#273;&#7871;n khi
công ty tham gia BHXH cho h&#7885; và &#273;&#432;&#7907;c c&#7845;p s&#7889; s&#7893;
BHXH m&#7899;i, thì h&#7885; m&#7899;i &#273;em s&#7893; &#273;&#7871;n n&#7897;p.</span>
&#272;&#7875; c&#7853;p nh&#7853;t &#273;&#7847;y &#273;&#7911; quá trình tham
gia BHXH c&#7911;a h&#7885; .Nay chúng tôi làm công v&#259;n này kính mong c&#417;
quan BHXH &#273;i&#7873;u ch&#7881;nh s&#7889; s&#7893; cho h&#7885; <span
class=GramE>theo</span> danh sách &#273;ính kèm nh&#432; sau:<o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-indent:.5in'><span
style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
 style='margin-left:5.4pt;border-collapse:collapse;border:none;mso-border-alt:
 solid windowtext .5pt;mso-yfti-tbllook:480;mso-padding-alt:0in 5.4pt 0in 5.4pt;
 mso-border-insideh:.5pt solid windowtext;mso-border-insidev:.5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:18.85pt'>
  <td width=45 valign=top style='width:33.5pt;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:18.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-family:"Times New Roman"'>STT<o:p></o:p></span></b></p>
  </td>
  <td width=191 valign=top style='width:143.2pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:18.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-family:"Times New Roman"'>H&#7885;
  và tên<o:p></o:p></span></b></p>
  </td>
  <td width=169 valign=top style='width:127.0pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:18.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-family:"Times New Roman"'>Ngày
  tháng n&#259;m sinh<o:p></o:p></span></b></p>
  </td>
  <td width=150 valign=top style='width:112.3pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:18.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-family:"Times New Roman"'>S&#7889;
  s&#7893; gi&#7919; l&#7841;i <o:p></o:p></span></b></p>
  </td>
  <td width=150 valign=top style='width:112.3pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:18.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-family:"Times New Roman"'>S&#7889;
  s&#7893; h&#7911;y<o:p></o:p></span></b></p>
  </td>
 </tr>
 <% 
     int count=0;
     for (int i = 0; i < irow; i++)
     {    
        count++;
    %>
 <tr style='mso-yfti-irow:1;mso-yfti-lastrow:yes;height:25.15pt'>
  <td width=45 style='width:33.5pt;border:solid windowtext 1.0pt;border-top:
  none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:25.15pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:"Times New Roman"'><%= count %><o:p></o:p></span></p>
  </td>
  <td width=191 style='width:143.2pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:25.15pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:"Times New Roman"'><%= dt_total.Rows[i][1].ToString() %><o:p></o:p></span></p>
  </td>
  <td width=169 style='width:127.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:25.15pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:"Times New Roman";color:black'><%= dt_total.Rows[i][2].ToString() %><o:p></o:p></span></p>
  </td>
  <td width=150 style='width:112.3pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:25.15pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:"Times New Roman"'><%= dt_total.Rows[i][3].ToString() %><o:p></o:p></span></p>
  </td>
  <td width=150 style='width:112.3pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:25.15pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:"Times New Roman";color:black'><%= dt_total.Rows[i][4].ToString() %><o:p></o:p></span></p>
  </td>
 </tr>
 <%} %>
</table>

<p class=MsoNormal style='text-align:justify;text-indent:.5in'><span
style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-indent:.5in'><span
style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-family:"Times New Roman"'>Công
ty chúng tôi xin cam &#273;oan là ch&#432;a làm t&#7901; khai c&#7845;p s&#7893;
cho nh&#7919;ng s&#7889; s&#7893; <span class=GramE>hu&#7927;<span
style='mso-spacerun:yes'>  </span>nói</span> trên, nh&#7919;ng s&#7889; s&#7893;
trên ch&#432;a &#273;&#432;&#7907;c c&#417; quang BHXH c&#7845;p s&#7893;.<o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span class=GramE><span
style='font-family:"Times New Roman"'>Công ty chúng tôi xin ch&#7883;u trách
nhi&#7879;m v&#7873; nh&#7919;ng thông tin trên.</span></span><span
style='font-family:"Times New Roman"'><o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-family:"Times New Roman"'>Xin
chân thành c&#7843;m &#417;n!<o:p></o:p></span></p>

<p class=MsoNormal align=center style='text-align:center'><span
style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=right style='text-align:right'><span style='font-family:
"Times New Roman"'>CÔNG TY TNHH HYOSUNG VI&#7878;T <st1:place w:st="on"><st1:country-region
 w:st="on">NAM</st1:country-region></st1:place><o:p></o:p></span></p>

<p class=MsoNormal align=right style='text-align:right'><span style='font-family:
"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-right:24.0pt'><span style='font-family:"Times New Roman"'><span
style='mso-spacerun:yes'>                                                                  
</span><span
style='mso-spacerun:yes'>                                                  </span><span
style='mso-tab-count:2'>               </span><b style='mso-bidi-font-weight:
normal'><span style='mso-spacerun:yes'> </span>GIÁM &#272;&#7888;C<o:p></o:p></b></span></p>

<p class=MsoNormal style='margin-right:24.0pt'><b style='mso-bidi-font-weight:
normal'><span style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-right:24.0pt'><b style='mso-bidi-font-weight:
normal'><span style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-right:24.0pt'><b style='mso-bidi-font-weight:
normal'><span style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-right:24.0pt'><b style='mso-bidi-font-weight:
normal'><span style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-right:24.0pt'><b style='mso-bidi-font-weight:
normal'><span style='font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-right:24.0pt'><b style='mso-bidi-font-weight:
normal'><span style='font-family:"Times New Roman"'><span style='mso-tab-count:
10'>                                                                                                                        </span><span
style='mso-spacerun:yes'>   </span><o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-right:24.0pt'><b style='mso-bidi-font-weight:
normal'><span style='font-family:"Times New Roman"'><span
style='mso-spacerun:yes'> </span><o:p></o:p></span></b></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>
