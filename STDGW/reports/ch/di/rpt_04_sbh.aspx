<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
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
        + "a.FULL_NAME  "//0
        + ",decode(nvl(a.sex,'0'),'M',(case when length(a.BIRTH_DT)>4 then to_char(to_date(a.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy') else substr(a.BIRTH_DT,1,4) end),'') as Male " //1
        + ",decode(nvl(a.sex,'0'),'F',(case when length(a.BIRTH_DT)>4 then to_char(to_date(a.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy') else substr(a.BIRTH_DT,1,4) end),'') as FeMale " //1
        + ",a.PERMANENT_ADDR " //3
        + ",e.reason " //4
        + " from thr_employee a,thr_ins_modify e"
        + " where a.del_if=0 and e.del_if=0 and e.thr_emp_pk =a.pk "
       + " and e.pk in (" + emp_pk + ") " ;
        
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
    = "select code_nm " +
        "from vhr_hr_code " +
        "where id='HR0049' order by code  ";
    DataTable dt_name = ESysLib.TableReadOpen(SQL);
    int irow_name;
    irow_name = dt_name.Rows.Count;
   
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 11">
<meta name=Originator content="Microsoft Word 11">
<link rel=File-List href="rpt_04_sbh_files/filelist.xml">
<title>MẪU SỐ: 04/SBH</title>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="place" downloadurl="http://www.5iantlavalamp.com/"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="country-region" downloadurl="http://www.5iantlavalamp.com/"/>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>MrTHONG</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>4</o:TotalTime>
  <o:Created>2011-06-08T03:41:00Z</o:Created>
  <o:LastSaved>2011-06-08T03:41:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>76</o:Words>
  <o:Characters>435</o:Characters>
  <o:Company>HOME</o:Company>
  <o:Lines>3</o:Lines>
  <o:Paragraphs>1</o:Paragraphs>
  <o:CharactersWithSpaces>510</o:CharactersWithSpaces>
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
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:27.0pt .5in 27.0pt .5in;
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
	font-family:"Times New Roman";
	mso-ansi-language:#0400;
	mso-fareast-language:#0400;
	mso-bidi-language:#0400;}
</style>
<![endif]-->
</head>

<body lang=EN-US style='tab-interval:.5in'>

<div class=Section1>

<p class=MsoNormal align=right style='text-align:right'><b style='mso-bidi-font-weight:
normal'>MẪU SỐ: 04/SBH<o:p></o:p></b></p>

<p class=MsoNormal>ĐƠN VỊ: <span class=GramE><b><%=dt_name.Rows[0][0].ToString()%></b></span></p>

<p class=MsoNormal align=center style='text-align:center'><b style='mso-bidi-font-weight:
normal'>CỘNG <a name=VNS0012>HOÀ</a> XÃ HỘI CHỦ NGHĨA VIỆT <st1:place w:st="on"><st1:country-region
 w:st="on">NAM</st1:country-region></st1:place><br>
Độc lập - Tự do - Hạnh phúc <br>
________________________<o:p></o:p></b></p>

<p class=MsoNormal align=center style='text-align:center'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal align=center style='text-align:center'>Kính gửi: BHXH tỉnh
<b><%=dt_name.Rows[10][0].ToString()%></b></p>

<p class=MsoNormal align=center style='text-align:center'><b style='mso-bidi-font-weight:
normal'><o:p>&nbsp;</o:p></b></p>

<p class=MsoNormal align=center style='text-align:center'><b style='mso-bidi-font-weight:
normal'>DANH SÁCH ĐỀ NGHỊ CẤP SỔ BHXH CHO NGƯỜI LAO ĐỘNG KỲ TRƯỚC<o:p></o:p></b></p>

<p class=MsoNormal align=center style='text-align:center;text-indent:.5in'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal align=center style='text-align:center;text-indent:.5in'>Tên
đơn vị: <span class=GramE><b><%=dt_name.Rows[0][0].ToString()%></b> <span style='mso-spacerun:yes'> </span>Mã</span>
đơn vị: <b><%=dt_name.Rows[1][0].ToString()%></b></p>

<p class=MsoNormal align=center style='text-align:center;text-indent:.5in'>Địa
chỉ: </p>

<p class=MsoNormal align=center style='text-align:center;text-indent:.5in'><span
class=GramE><b><%=dt_name.Rows[2][0].ToString()%></b></span></p>

<p class=MsoNormal align=center style='text-align:center;text-indent:.5in'>Điện
<span class=GramE>thoại <span style='mso-spacerun:yes'> </span><b><%=dt_name.Rows[12][0].ToString()%></b></span> Fax: <b><%=dt_name.Rows[13][0].ToString()%></b>
Email:</p>

<p class=MsoNormal align=center style='text-align:center;text-indent:.5in'><o:p>&nbsp;</o:p></p>

<div align=center>

<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 width=688
 style='width:516.1pt;border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-yfti-tbllook:480;mso-padding-alt:0in 5.4pt 0in 5.4pt;mso-border-insideh:
 .5pt solid windowtext;mso-border-insidev:.5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes'>
  <td width=43 rowspan=2 style='width:32.35pt;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'>STT</p>
  </td>
  <td width=162 rowspan=2 style='width:121.6pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span class=SpellE>Họ</span>
  <span class=SpellE>và</span> <span class=SpellE>tên</span></p>
  </td>
  <td width=175 colspan=2 style='width:131.0pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span class=SpellE>Ngày</span>
  <span class=SpellE>tháng</span> <span class=SpellE>năm</span> <span
  class=SpellE>sinh</span></p>
  </td>
  <td width=230 rowspan=2 style='width:172.4pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span class=SpellE>Nơi</span>
  <span class=SpellE>cư</span> <span class=SpellE>trú</span> (<span
  class=SpellE>thường</span> <span class=SpellE>trú</span> <span class=SpellE>hoặc</span>
  <span class=SpellE>tạm</span> <span class=SpellE>trú</span>)</p>
  </td>
  <td width=78 rowspan=2 style='width:58.75pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span class=SpellE>Ghi</span>
  <span class=SpellE>chú</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1'>
  <td width=81 style='width:60.7pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><st1:place w:st="on"><st1:country-region
   w:st="on">Nam</st1:country-region></st1:place></p>
  </td>
  <td width=81 style='width:60.7pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'>Nữ</p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2;height:19.75pt'>
  <td width=43 style='width:.45in;border:solid windowtext 1.0pt;border-top:
  none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:19.75pt'>
  <p class=MsoNormal align=center style='text-align:center'>1</p>
  </td>
  <td width=168 style='width:1.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:19.75pt'>
  <p class=MsoNormal align=center style='text-align:center'>2</p>
  </td>
  <td width=81 style='width:60.7pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:19.75pt'>
  <p class=MsoNormal align=center style='text-align:center'>3</p>
  </td>
  <td width=81 style='width:60.7pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:19.75pt'>
  <p class=MsoNormal align=center style='text-align:center'>4</p>
  </td>
  <td width=138 style='width:103.6pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:19.75pt'>
  <p class=MsoNormal align=center style='text-align:center'>5</p>
  </td>
  <td width=81 style='width:60.7pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:19.75pt'>
  <p class=MsoNormal align=center style='text-align:center'>6</p>
  </td>
 </tr>
 <% 
     
    for (int i = 0; i < irow; i++)
    {
       
    %>
<tr style='mso-yfti-irow:2;height:19.75pt'>
  <td width=43 style='width:.45in;border:solid windowtext 1.0pt;border-top:
  none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:19.75pt'>
  <p class=MsoNormal align=center style='text-align:center'><%=i+1 %></p>
  </td>
  <td width=168 style='width:1.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:19.75pt'>
  <p class=MsoNormal align=center style='text-align:center'><%=dt_total.Rows[i][0].ToString()%></p>
  </td>
  <td width=81 style='width:60.7pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:19.75pt'>
  <p class=MsoNormal align=center style='text-align:center'><%=dt_total.Rows[i][1].ToString()%></p>
  </td>
  <td width=81 style='width:60.7pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:19.75pt'>
  <p class=MsoNormal align=center style='text-align:center'><%=dt_total.Rows[i][2].ToString()%></p>
  </td>
  <td width=138 style='width:103.6pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:19.75pt'>
  <p class=MsoNormal align=center style='text-align:center'><%=dt_total.Rows[i][3].ToString()%></p>
  </td>
  <td width=81 style='width:60.7pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:19.75pt'>
  <p class=MsoNormal align=center style='text-align:center'><%=dt_total.Rows[i][4].ToString()%></p>
  </td>
 </tr>
<%} %>
 
</table>

</div>

<p class=MsoNormal align=center style='text-align:center;text-indent:.5in'><o:p>&nbsp;</o:p></p>

<div align=center>

<table border=0 cellspacing=0 cellpadding=0 style='border-collapse:collapse;
 mso-yfti-tbllook:480;mso-padding-alt:0in 5.4pt 0in 5.4pt'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes;
  height:36.35pt'>
  <td width=292 valign=top style='width:218.75pt;padding:0in 5.4pt 0in 5.4pt;
  height:36.35pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'>NGƯỜI LẬP BIỂU<br>
  </b>(Ký, ghi rõ họ tên)<b style='mso-bidi-font-weight:normal'><o:p></o:p></b></p>
  </td>
  <td width=292 valign=top style='width:219.05pt;padding:0in 5.4pt 0in 5.4pt;
  height:36.35pt'>
  <p class=MsoNormal align=center style='text-align:center'><span class=GramE><%=dt_name.Rows[10][0].ToString()%>,</span>
  ngày <%= DateTime.Today.Day%> tháng <%= DateTime.Today.Month%> năm <%= DateTime.Today.Year%><br>
  <b style='mso-bidi-font-weight:normal'>GIÁM ĐỐC <br>
  </b>(Ký tên, đóng dấu)</p>
  </td>
 </tr>
</table>

</div>


<p class=MsoNormal align=center style='text-align:center'><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>
