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
<link rel=File-List href="rpt_cv_graft_book_hyosung_files/filelist.xml">
<title>Công ty TNHH Hyosung Vi&#7879;t Nam                C&#7896;NG HOÀ XÃ
H&#7896;I CH&#7910; NGH&#296;A VI&#7878;T NAM</title>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="country-region"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="place"/>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Compaq-500B</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>1</o:TotalTime>
  <o:Created>2011-09-29T08:46:00Z</o:Created>
  <o:LastSaved>2011-09-29T08:46:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>228</o:Words>
  <o:Characters>1304</o:Characters>
  <o:Company>HP Compaq</o:Company>
  <o:Lines>10</o:Lines>
  <o:Paragraphs>3</o:Paragraphs>
  <o:CharactersWithSpaces>1529</o:CharactersWithSpaces>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
 <o:OfficeDocumentSettings>
  <o:AllowPNG/>
  <o:TargetScreenSize>1024x768</o:TargetScreenSize>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-520092929 1073786111 9 0 415 0;}
@font-face
	{font-family:"Malgun Gothic";
	panose-1:2 11 5 3 2 0 0 2 0 4;
	mso-font-charset:129;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-1879047505 165117179 18 0 524289 0;}
@font-face
	{font-family:"\@Batang";
	panose-1:2 3 6 0 0 1 1 1 1 1;
	mso-font-charset:129;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-1342176593 1775729915 48 0 524447 0;}
@font-face
	{font-family:"\@Malgun Gothic";
	panose-1:2 11 5 3 2 0 0 2 0 4;
	mso-font-charset:129;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-1879047505 165117179 18 0 524289 0;}
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
@page Section1
	{size:595.45pt 841.7pt;
	margin:1.0in .6in 1.0in .5in;
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

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'>Công ty TNHH Hyosung
Vi&#7879;t <st1:country-region w:st="on">Nam</st1:country-region></b><span
style='mso-spacerun:yes'>                </span><b style='mso-bidi-font-weight:
normal'>C&#7896;NG HOÀ XÃ H&#7896;I CH&#7910; NGH&#296;A VI&#7878;T <st1:country-region
w:st="on"><st1:place w:st="on">NAM</st1:place></st1:country-region><o:p></o:p></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'>&#272;&#432;&#7901;ng
N2-KCN Nh&#417;n Tr&#7841;ch V-&#272;N</b><span
style='mso-spacerun:yes'>                            </span><b
style='mso-bidi-font-weight:normal'>&#272;&#7897;c l&#7853;p - T&#7921; do - H&#7841;nh
phúc</b></p>



<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal><span
style='mso-spacerun:yes'>                                                                                        
</span>&#272;&#7891;ng Nai, ngày<span style='mso-spacerun:yes'>  </span><%= dt_total.Rows[0][5].ToString() %><span
style='mso-spacerun:yes'>  </span>tháng<span style='mso-spacerun:yes'>  
</span><%= dt_total.Rows[0][6].ToString() %><span style='mso-spacerun:yes'>  </span>n&#259;m <%= dt_total.Rows[0][7].ToString() %></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal align=center style='text-align:center'><b style='mso-bidi-font-weight:
normal'><span style='font-size:20.0pt'>CÔNG V&#258;N &#272;&#7872; NGH&#7882; G&#7896;P
S&#7892;<o:p></o:p></span></b></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal align=center style='text-align:center'><i style='mso-bidi-font-style:
normal'><u>Kính g&#7917;i</u></i>: <b style='mso-bidi-font-weight:normal'><span
style='font-size:14.0pt'>B&#7842;O HI&#7874;M XÃ H&#7896;I HUY&#7878;N
NH&#416;N TR&#7840;CH</span></b></p>

<p class=MsoNormal align=center style='text-align:center'><i style='mso-bidi-font-style:
normal'>(V/v: Xin g&#7897;p s&#7893; BHXH)<o:p></o:p></i></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='text-indent:.5in'>Cty TNHH HYOSUNG là công ty 100% v&#7889;n
n&#432;&#7899;c ngoài có nhà máy &#273;&#7863;t t&#7841;i KCN Nh&#417;n Tr&#7841;ch
5, huy&#7879;n Nh&#417;n Tr&#7841;ch, T&#7881;nh &#272;&#7891;ng Nai theo gi&#7845;y
phép &#273;&#7847;u t&#432; s&#7889;:472043000143/GP- KCN - &#272;N do do BQL
các KCN &#272;&#7891;ng Nai c&#7845;p ngày : 22/05/2007.</p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
text-indent:.5in'>Trong quá trình khai báo tham gia b&#7843;o hi&#7875;m xã h&#7897;i
cho ng&#432;&#7901;i lao &#273;&#7897;ng t&#7841;i công ty, do ng&#432;&#7901;i
lao &#273;&#7897;ng &#273;ã không n&#7897;p s&#7893; BHXH c&#361; cho công ty nên h&#7885;
&#273;ã &#273;&#432;&#7907;c c&#7845;p thêm 1 s&#7893; BHXH n&#7919;a. Cho nên
khi h&#7885; n&#7897;p s&#7893; BHXH c&#361;,<span style='mso-spacerun:yes'> 
</span>công ty chúng tôi phải gộp th&#7901;i gian tham gia bhxh vào s&#7893; BHXH
c&#361; c&#7911;a h&#7885; và hu&#7927; s&#7893; BHXH &#273;&#432;&#7907;c c&#7845;p
m&#7899;i t&#7841;i công ty chúng tôi.<span style='mso-spacerun:yes'>  </span>Nên
công ty chúng tôi làm công v&#259;n này kính mong c&#417; quan BHXH g&#7897;p s&#7893;
cho nh&#7919;ng công nhân viên có tên trong b&#7843;ng sau:</p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
text-indent:.5in'><o:p>&nbsp;</o:p></p>

<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-yfti-tbllook:480;mso-padding-alt:0in 5.4pt 0in 5.4pt;mso-border-insideh:
 .5pt solid windowtext;mso-border-insidev:.5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:18.85pt'>
  <td width=154 valign=top style='width:115.65pt;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:18.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'>H&#7885; và tên<o:p></o:p></b></p>
  </td>
  <td width=161 valign=top style='width:120.9pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:18.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'>Ngày tháng n&#259;m sinh<o:p></o:p></b></p>
  </td>
  <td width=178 valign=top style='width:133.35pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:18.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'>S&#7893; gi&#7919; l&#7841;i <o:p></o:p></b></p>
  </td>
  <td width=186 valign=top style='width:139.5pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:18.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'>S&#7893; h&#7911;y<o:p></o:p></b></p>
  </td>
 </tr>
  <% 
     
     for (int i = 0; i < irow; i++)
     {    
    %>
 <tr style='mso-yfti-irow:1;mso-yfti-lastrow:yes;height:17.5pt'>
 
  <td width=154 style='width:115.65pt;border:solid windowtext 1.0pt;border-top:
  none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:17.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt'><%= dt_total.Rows[i][1].ToString() %><o:p></o:p></span></p>
  </td>
  <td width=161 style='width:120.9pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:17.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt'><%= dt_total.Rows[i][2].ToString() %><o:p></o:p></span></p>
  </td>
  <td width=178 style='width:133.35pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:17.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt'><%= dt_total.Rows[i][3].ToString() %><o:p></o:p></span></p>
  </td>
  <td width=186 style='width:139.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:17.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt'><%= dt_total.Rows[i][4].ToString() %><o:p></o:p></span></p>
  </td>

 </tr>
   <%} %>
</table>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
text-indent:.5in'><span style='font-family:Arial'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
text-indent:.5in'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'>Công
ty chúng tôi xin ch&#7883;u hoàn toàn trách nhi&#7879;m v&#7873; vi&#7879;c g&#7897;p
s&#7893; này.</p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'>Xin
chân thành c&#7843;m &#417;n!</p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal align=right style='text-align:right'>CÔNG TY TNHH HYOSUNG VI&#7878;T
<st1:place w:st="on"><st1:country-region w:st="on">NAM</st1:country-region></st1:place></p>

<p class=MsoNormal align=right style='text-align:right'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='margin-right:24.0pt'><span
style='mso-spacerun:yes'>                                                                                                            
</span><span style='mso-spacerun:yes'>        </span><b style='mso-bidi-font-weight:
normal'><span style='mso-spacerun:yes'> </span>GIÁM &#272;&#7888;C<o:p></o:p></b></p>

<p class=MsoNormal style='margin-right:24.0pt'><b style='mso-bidi-font-weight:
normal'><o:p>&nbsp;</o:p></b></p>

<p class=MsoNormal style='margin-right:24.0pt'><b style='mso-bidi-font-weight:
normal'><o:p>&nbsp;</o:p></b></p>

<p class=MsoNormal style='margin-right:24.0pt'><b style='mso-bidi-font-weight:
normal'><o:p>&nbsp;</o:p></b></p>

<p class=MsoNormal style='margin-right:24.0pt'><b style='mso-bidi-font-weight:
normal'><o:p>&nbsp;</o:p></b></p>

<p class=MsoNormal style='margin-right:24.0pt'><b style='mso-bidi-font-weight:
normal'><o:p>&nbsp;</o:p></b></p>

<p class=MsoNormal style='margin-right:24.0pt'><b style='mso-bidi-font-weight:
normal'><span style='mso-tab-count:10'>                                                                                                                        </span><span
style='mso-spacerun:yes'>   </span><o:p></o:p></b></p>

<p class=MsoNormal style='margin-right:24.0pt'><b style='mso-bidi-font-weight:
normal'><span style='mso-spacerun:yes'> </span><o:p></o:p></b></p>



</div>

</body>

</html>
