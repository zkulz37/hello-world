<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/msword";
    Response.Charset = "utf-8"; 
	
%>
<html>
<%
    string emp_pk, p_sal_security;
    emp_pk = Request["emp_pk"].ToString();
    p_sal_security = Request["p_sal_security"].ToString();
    string SQL
    = "select to_char(sysdate,'dd') c00 " +
        "        ,to_char(sysdate,'mm') c01 " +
        "        ,to_char(sysdate,'yyyy') c02 " +
        "        ,E.FULL_NAME c03 " +
        "        ,(select code_fnm from vhr_hr_code v where V.CODE=E.NATION and V.ID='HR0009') c04 " +
        "        ,decode(length(E.BIRTH_DT),4,E.BIRTH_DT, to_char(to_date(E.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy')) c05 " +
        "        ,decode(E.NATION,'01',E.PASS_PORT_NO, P.PASSPORT_NO) c06 " +
        "        ,(select code_fnm from vhr_hr_code v where V.CODE=E.MAJOR  and V.ID='HR0148') c07 " +
        "        ,(select code_fnm from vhr_hr_code v where V.CODE=E.JOB_TYPE  and V.ID='HR0010') c08 " +
        "        ,decode(E.NATION,'01',to_char(to_date(E.PASS_PORT_DT ,'yyyymmdd'),'dd/mm/yyyy'),to_char(to_date(P.FROM_DT ,'yyyymmdd'),'dd/mm/yyyy'))c09 " +
        "        ,decode(E.NATION,'01',to_char(to_date(E.PASS_PORT_EXPIRE_DT ,'yyyymmdd'),'dd/mm/yyyy'),to_char(to_date(P.TO_DT ,'yyyymmdd'),'dd/mm/yyyy'))c10 " +
        "from thr_employee e, thr_f_passport p " +
        "where E.DEL_IF=0 " +
        "and P.DEL_IF(+)=0 " +
        "and e.pk=P.THR_EMP_PK(+) " +
        "and E.PK in ( " + emp_pk + " )        ";
    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
    if (dt_emp.Rows.Count == 0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }
    
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 11">
<meta name=Originator content="Microsoft Word 11">
<link rel=File-List href="rpt_07_TT31_files/filelist.xml">
<title></title>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="country-region"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="place"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="PlaceName"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="PlaceType"/>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Group 911</o:Author>
  <o:LastAuthor>cun</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>96</o:TotalTime>
  <o:LastPrinted>2012-03-02T10:26:00Z</o:LastPrinted>
  <o:Created>2013-01-18T05:45:00Z</o:Created>
  <o:LastSaved>2013-01-18T05:45:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>425</o:Words>
  <o:Characters>2427</o:Characters>
  <o:Company>HOME</o:Company>
  <o:Lines>20</o:Lines>
  <o:Paragraphs>5</o:Paragraphs>
  <o:CharactersWithSpaces>2847</o:CharactersWithSpaces>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:PunctuationKerning/>
  <w:DrawingGridHorizontalSpacing>6 pt</w:DrawingGridHorizontalSpacing>
  <w:DisplayHorizontalDrawingGridEvery>2</w:DisplayHorizontalDrawingGridEvery>
  <w:DisplayVerticalDrawingGridEvery>2</w:DisplayVerticalDrawingGridEvery>
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
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;
	mso-font-alt:宋体;
	mso-font-charset:134;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:3 680460288 22 0 262145 0;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;
	mso-font-charset:134;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:3 680460288 22 0 262145 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:14.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:SimSun;
	color:black;
	mso-fareast-language:ZH-CN;
	font-weight:bold;}
p.MsoHeader, li.MsoHeader, div.MsoHeader
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	tab-stops:center 3.0in right 6.0in;
	font-size:14.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:SimSun;
	color:black;
	mso-fareast-language:ZH-CN;
	font-weight:bold;}
p.CharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharChar, li.CharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharChar, div.CharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharChar
	{mso-style-name:" Char Char Char Char Char Char Char Char Char Char Char Char Char Char Char Char Char Char Char Char Char Char";
	mso-style-noshow:yes;
	mso-style-next:Header;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:8.0pt;
	margin-left:0in;
	line-height:12.0pt;
	mso-line-height-rule:exactly;
	mso-pagination:widow-orphan;
	font-size:14.0pt;
	mso-bidi-font-size:11.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
@page Section1
	{size:595.35pt 842.0pt;
	margin:9.0pt 42.55pt .25in 85.05pt;
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
    for (int i = 0; i < dt_emp.Rows.Count; i++)
    { %>
<p class=MsoNormal style='margin-top:6.0pt'><span lang=FR style='font-size:
10.0pt;mso-ansi-language:FR;font-weight:normal;mso-bidi-font-weight:bold'>MẪU SỐ
7: <i style='mso-bidi-font-style:normal'>Ban <span class=SpellE>hành</span> <span
class=SpellE>kèm</span> <span class=SpellE>theo</span> <span class=SpellE>Thông</span>
<span class=SpellE>tư</span> <span class=SpellE>số</span> 31/2011/TT-BLĐTBXH <span
class=SpellE>ngày</span> 03/11/2011 <span class=SpellE>của</span> <span
class=SpellE>Bộ</span> Lao <span class=SpellE>động</span> - <span class=SpellE>Thương</span>
<span class=SpellE>binh</span> <span class=SpellE>và</span> <span class=SpellE>Xã</span>
<span class=SpellE>hội</span> <span class=SpellE>hướng</span> <span
class=SpellE>dẫn</span> <span class=SpellE>thi</span> <span class=SpellE>hành</span>
<span class=SpellE>một</span> <span class=SpellE>số</span> <span class=SpellE>điều</span>
<span class=SpellE>của</span> <span class=SpellE>Nghị</span> <span
class=SpellE>định</span> <span class=SpellE>số</span> 34/2008/NĐ-CP <span
class=SpellE>đã</span> <span class=SpellE>được</span> <span class=SpellE>sửa</span>
<span class=SpellE>đổi</span>, <span class=SpellE>bổ</span> <span class=SpellE>sung</span>:<o:p></o:p></i></span></p>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;mso-yfti-tbllook:480;mso-padding-alt:0in 5.4pt 0in 5.4pt'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:.2in'>
  <td width=224 rowspan=2 valign=top style='width:168.3pt;padding:0in 5.4pt 0in 5.4pt;
  height:.2in'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;text-align:center'><span
  style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:bold'>CÔNG TY
  TNHH POSCO SS-VINA<br>
  <i style='mso-bidi-font-style:normal'>(ENTERPRISE, ORGANIZATON)</i><o:p></o:p></span></p>
  <p class=MsoNormal style='margin-top:6.0pt'><span style='font-size:10.0pt;
  font-weight:normal;mso-bidi-font-weight:bold'>SỐ (No):<span
  style='mso-spacerun:yes'>          </span>/PSSV-NS<br>
  V/v <span class=SpellE>đề</span> <span class=SpellE>nghị</span> <span
  class=SpellE>cấp</span> <span class=SpellE>giấy</span> <span class=SpellE>phép</span>
  <span class=SpellE>lao</span> <span class=SpellE>động</span> <span
  class=SpellE>cho</span> <span class=SpellE>người</span> <span class=SpellE>nước</span>
  <span class=SpellE>ngoài</span>.<br>
  <i style='mso-bidi-font-style:normal'>Suggestion for <span class=SpellE>issuane</span>
  of work permit</i><o:p></o:p></span></p>
  </td>
  <td width=366 valign=top style='width:274.5pt;padding:0in 5.4pt 0in 5.4pt;
  height:.2in'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;text-align:center'><span
  style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:bold'>CỘNG
  HÒA XÃ HỘI CHỦ NGHĨA VIỆT <st1:country-region w:st="on">NAM</st1:country-region><br>
  <span class=SpellE>Độc</span> <span class=SpellE>lập</span> - <span
  class=SpellE>Tự</span> do - <span class=SpellE>Hạnh</span> <span
  class=SpellE>phúc</span><br>
<st1:PlaceName w:st="on"><i style='mso-bidi-font-style:normal'>Socialist</i></st1:PlaceName><i
  style='mso-bidi-font-style:normal'> <st1:PlaceType w:st="on">Republic</st1:PlaceType>
  of <st1:country-region w:st="on"><st1:place w:st="on">Vietnam</st1:place></st1:country-region><br>
  Independence- Freedom- Happiness<br>
  ----------------<o:p></o:p></i></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1;mso-yfti-lastrow:yes;height:12.8pt'>
  <td width=366 valign=top style='width:274.5pt;padding:0in 5.4pt 0in 5.4pt;
  height:12.8pt'>
  <p class=MsoNormal align=right style='margin-top:6.0pt;text-align:right'><span
  class=SpellE><i style='mso-bidi-font-style:normal'><span style='font-size:
  10.0pt;font-weight:normal;mso-bidi-font-weight:bold'>Tân</span></i></span><i
  style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'> <span class=SpellE>Thành</span>, <span
  class=SpellE>ngày</span> <%=dt_emp.Rows[i]["c00"].ToString() %><span style='mso-spacerun:yes'>  </span><span
  style='mso-spacerun:yes'> </span><span class=SpellE>tháng</span> <span
  style='mso-spacerun:yes'>  </span><%=dt_emp.Rows[i]["c01"].ToString() %> <span class=SpellE>năm</span> <%=dt_emp.Rows[i]["c02"].ToString() %><br>
  ……, date … month … year ……..<o:p></o:p></span></i></p>
  </td>
 </tr>
</table>

<p class=MsoNormal style='margin-top:6.0pt'><span style='font-size:10.0pt;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center style='margin-top:6.0pt;text-align:center'><span
class=SpellE><span style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>Kính</span></span><span style='font-size:10.0pt;font-weight:normal;
mso-bidi-font-weight:bold'> <span class=SpellE>gửi</span>: Ban <span
class=SpellE>Quản</span> <span class=SpellE>Lý</span> <span class=SpellE>các</span>
KCN <span class=SpellE>Tỉnh</span> <span class=SpellE>Bà</span> <span
class=SpellE>Rịa</span> –<span class=SpellE>Vũng</span> <span class=SpellE>Tàu</span>
(BIZA)<br>
<i style='mso-bidi-font-style:normal'>To:....................................................................<o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;mso-outline-level:1;tab-stops:right dotted 430.35pt'><span
style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:bold'>1. <span
class=SpellE>Doanh</span> <span class=SpellE>nghiệp</span>, <span class=SpellE>tổ</span>
<span class=SpellE>chức</span>: <span class=SpellE>Công</span> <span
class=SpellE>ty</span> TNHH POSCO SS-VINA<span style='mso-tab-count:1 dotted'>................................................................................... </span><br>
<i style='mso-bidi-font-style:normal'>Enterprise organization:<o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;mso-outline-level:1;tab-stops:right dotted 430.35pt'><span
style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:bold'>2. <span
class=SpellE>Địa</span> <span class=SpellE>chỉ</span>: <span class=SpellE>Đường</span>
N1, KCN <span class=SpellE>Phú</span> <span class=SpellE>Mỹ</span> II, <span
class=SpellE>Huyện</span> <span class=SpellE>Tân</span> <span class=SpellE>Thành</span>
, <span class=SpellE>Tỉnh</span> <span class=SpellE>Bà</span> <span
class=SpellE>Rịa</span> – <span class=SpellE>Vũng</span> <span class=SpellE>Tàu</span><span
style='mso-tab-count:1 dotted'>...................................... </span><br>
<i style='mso-bidi-font-style:normal'>Address:<o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;mso-outline-level:1;tab-stops:right dotted 430.35pt'><span
style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:bold'>3. <span
class=SpellE>Điện</span> <span class=SpellE>thoại</span>: 064 3892 009<span
style='mso-tab-count:1 dotted'>............................................................................................................................................ </span><br>
<i style='mso-bidi-font-style:normal'>Telephone number (Tel):<o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;mso-outline-level:1;tab-stops:right dotted 430.35pt'><span
style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:bold'>4. <span
class=SpellE>Giấy</span> <span class=SpellE>phép</span> <span class=SpellE>kinh</span>
<span class=SpellE>doanh</span> (<span class=SpellE>hoạt</span> <span
class=SpellE>động</span>) <span class=SpellE>số</span>: 492043000178<span
style='mso-tab-count:1 dotted'>........................................................................................ </span><br>
<i style='mso-bidi-font-style:normal'>Permission for business (No):<o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;mso-outline-level:1;tab-stops:right dotted 430.35pt'><span
style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:bold'>5. <span
class=SpellE>Cơ</span> <span class=SpellE>quan</span> <span class=SpellE>cấp</span>:
Ban <span class=SpellE>Quản</span> <span class=SpellE>Lý</span> <span
class=SpellE>các</span> KCN <span class=SpellE>Tỉnh</span> <span class=SpellE>Bà</span>
<span class=SpellE>Rịa</span> –<span class=SpellE>Vũng</span> <span
class=SpellE>Tàu</span> ….. <span class=SpellE>Ngày</span> cấp:14/05/2010<span
style='mso-tab-count:1 dotted'>......................... </span><br>
<i style='mso-bidi-font-style:normal'>Place of issue<span
style='mso-spacerun:yes'>                                                              
</span>Date of issue<o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;mso-outline-level:1;tab-stops:right dotted 430.35pt'><span
style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:bold'>6. <span
class=SpellE>Lĩnh</span> <span class=SpellE>vực</span> <span class=SpellE>kinh</span>
<span class=SpellE>doanh</span> (<span class=SpellE>hoạt</span> <span
class=SpellE>động</span>): <span class=SpellE>Sản</span> <span class=SpellE>xuất</span>
<span class=SpellE>thép</span> <span class=SpellE>và</span> <span class=SpellE>gia</span>
<span class=SpellE>công</span> <span class=SpellE>thép</span><span
style='mso-tab-count:1 dotted'>.................................................................... </span><br>
<i style='mso-bidi-font-style:normal'>Fields of business:<o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;mso-outline-level:1;tab-stops:right dotted 430.35pt'><span
class=SpellE><span style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>Đề</span></span><span style='font-size:10.0pt;font-weight:normal;
mso-bidi-font-weight:bold'> <span class=SpellE>nghị</span>: Ban <span
class=SpellE>Quản</span> <span class=SpellE>Lý</span> <span class=SpellE>các</span>
KCN <span class=SpellE>Tỉnh</span> <span class=SpellE>Bà</span> <span
class=SpellE>Rịa</span> –<span class=SpellE>Vũng</span> <span class=SpellE>Tàu</span>
……………<span class=SpellE>cấp</span> <span class=SpellE>giấy</span> <span
class=SpellE>phép</span> <span class=SpellE>lao</span> <span class=SpellE>động</span><span
style='mso-tab-count:1 dotted'>....................... </span><br>
<i style='mso-bidi-font-style:normal'>Suggestion:<span
style='mso-spacerun:yes'>                                                       
</span>issuance of work permit<o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:right dotted 430.35pt'><span
class=SpellE><span style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>cho</span></span><span style='font-size:10.0pt;font-weight:normal;
mso-bidi-font-weight:bold'>: <span style='mso-tab-count:1 dotted'>..................................................................................................................................................................................... </span><br>
<i style='mso-bidi-font-style:normal'>for:<o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:right dotted 430.35pt'><span
class=SpellE><span style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>Ông</span></span><span style='font-size:10.0pt;font-weight:normal;
mso-bidi-font-weight:bold'> (<span class=SpellE>bà</span>): <span class=SpellE>Ông</span>
</span><span style='font-size:10.0pt;color:blue;font-weight:normal;mso-bidi-font-weight:
bold'><%=dt_emp.Rows[i]["c03"].ToString() %></span><span style='font-size:10.0pt;font-weight:normal;
mso-bidi-font-weight:bold'><span style='mso-spacerun:yes'>  </span>…………. <span
class=SpellE>Quốc</span> <span class=SpellE>tịch</span>: </span><span
class=SpellE><span style='font-size:10.0pt;color:blue;font-weight:normal;
mso-bidi-font-weight:bold'><%=dt_emp.Rows[i]["c04"].ToString() %></span></span><span style='font-size:10.0pt;
color:blue;font-weight:normal;mso-bidi-font-weight:bold'> <span class=SpellE></span></span><span
style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:bold'><span
style='mso-tab-count:1 dotted'>.................................................................... </span><br>
<i style='mso-bidi-font-style:normal'>Mr. (Ms.)<span
style='mso-spacerun:yes'>                                                               
</span>Nationality:<o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:right dotted 430.35pt'><span
class=SpellE><span style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>Ngày</span></span><span style='font-size:10.0pt;font-weight:normal;
mso-bidi-font-weight:bold'> <span class=SpellE>tháng</span> <span class=SpellE>năm</span>
<span class=SpellE>sinh</span>: </span><span style='font-size:10.0pt;
color:blue;font-weight:normal;mso-bidi-font-weight:bold'><%=dt_emp.Rows[i]["c05"].ToString() %></span><span
style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:bold'>……………… <span
class=SpellE>Số</span> <span class=SpellE>hộ</span> <span class=SpellE>chiếu</span>:
</span><span style='font-size:10.0pt;color:blue;font-weight:normal;mso-bidi-font-weight:
bold'><%=dt_emp.Rows[i]["c06"].ToString() %></span><span style='font-size:10.0pt;font-weight:normal;
mso-bidi-font-weight:bold'><span style='mso-tab-count:1 dotted'>............................................................. </span><br>
<i style='mso-bidi-font-style:normal'>Date of birth (DD-MM-YY)<span
style='mso-spacerun:yes'>                                   </span>Passport No<o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:right dotted 430.35pt'><span
class=SpellE><span style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>Trình</span></span><span style='font-size:10.0pt;font-weight:normal;
mso-bidi-font-weight:bold'> <span class=SpellE>độ</span> <span class=SpellE>chuyên</span>
<span class=SpellE>môn</span>: </span><span class=SpellE><span
style='font-size:10.0pt;color:blue;font-weight:normal;mso-bidi-font-weight:
bold'><%=dt_emp.Rows[i]["c07"].ToString() %></span></span><span style='font-size:10.0pt;color:blue;font-weight:
normal;mso-bidi-font-weight:bold'> <span class=SpellE></span> <span
class=SpellE></span> <span class=SpellE></span> <span class=SpellE></span>
<span class=SpellE></span></span><span style='font-size:10.0pt;font-weight:
normal;mso-bidi-font-weight:bold'><span style='mso-tab-count:1 dotted'>............................................................................................... </span><br>
<i style='mso-bidi-font-style:normal'>Professional qualification (skill):<o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:right dotted 430.35pt'><span
class=SpellE><span style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>Nơi</span></span><span style='font-size:10.0pt;font-weight:normal;
mso-bidi-font-weight:bold'> <span class=SpellE>làm</span> <span class=SpellE>việc</span>:
<span class=SpellE>Công</span> <span class=SpellE>ty</span> TNHH POSCO SS-VINA<br>
<i style='mso-bidi-font-style:normal'>Working place<o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:right dotted 430.35pt'><span
class=SpellE><span style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>Vị</span></span><span style='font-size:10.0pt;font-weight:normal;
mso-bidi-font-weight:bold'> <span class=SpellE>trí</span> <span class=SpellE>công</span>
<span class=SpellE>việc</span>: </span><span class=SpellE><span
style='font-size:10.0pt;color:blue;font-weight:normal;mso-bidi-font-weight:
bold'><%=dt_emp.Rows[i]["c08"].ToString() %></span></span><span style='font-size:10.0pt;color:blue;font-weight:
normal;mso-bidi-font-weight:bold'> <span class=SpellE></span> <span
class=SpellE></span>  <span class=SpellE></span> <span class=SpellE></span>
– <span class=SpellE></span> <span class=SpellE></span></span><span
style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:bold'><span
style='mso-tab-count:1 dotted'>...................................................................................... </span><br>
<i style='mso-bidi-font-style:normal'>Job assignment:<o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:right dotted 430.35pt'><span
class=SpellE><span style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>Thời</span></span><span style='font-size:10.0pt;font-weight:normal;
mso-bidi-font-weight:bold'> <span class=SpellE>gian</span> <span class=SpellE>làm</span>
<span class=SpellE>việc</span> <span class=SpellE>từ</span> <span class=SpellE>ngày</span>:
</span><span style='font-size:10.0pt;color:blue;font-weight:normal;mso-bidi-font-weight:
bold'><%=dt_emp.Rows[i]["c09"].ToString() %></span><span style='font-size:10.0pt;font-weight:normal;
mso-bidi-font-weight:bold'> <span class=SpellE>đến</span> <span class=SpellE>ngày</span>:
</span><span style='font-size:10.0pt;color:blue;font-weight:normal;mso-bidi-font-weight:
bold'><%=dt_emp.Rows[i]["c10"].ToString() %></span><span style='font-size:10.0pt;font-weight:normal;
mso-bidi-font-weight:bold'><br>
<i style='mso-bidi-font-style:normal'>Period of work from<span
style='mso-spacerun:yes'>        </span><span
style='mso-spacerun:yes'>                      </span><span
style='mso-spacerun:yes'>  </span><span style='mso-spacerun:yes'> </span>To<o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:right dotted 430.35pt'><span
class=SpellE><span style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>Lý</span></span><span style='font-size:10.0pt;font-weight:normal;
mso-bidi-font-weight:bold'> do <span class=SpellE>ông</span> (<span
class=SpellE>bà</span>): <span class=SpellE>Ông</span> <span
style='mso-spacerun:yes'> </span></span><span style='font-size:10.0pt;
color:blue;font-weight:normal;mso-bidi-font-weight:bold'><%=dt_emp.Rows[i]["c03"].ToString() %></span><span
style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:bold'><span
style='mso-spacerun:yes'>  </span><span class=SpellE>làm</span> <span
class=SpellE>việc</span> <span class=SpellE>tại</span> <span class=SpellE>Việt</span>
Nam: Theo <span class=SpellE>hình</span> <span class=SpellE>thức</span> <span
class=SpellE>tuyển</span> <span class=SpellE>dụng</span><br>
<i style='mso-bidi-font-style:normal'>The reasons for Mr. (Ms.)<span
style='mso-spacerun:yes'>                             </span>working in Vietnam<o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:right dotted 430.35pt'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;mso-yfti-tbllook:480;mso-padding-alt:0in 5.4pt 0in 5.4pt'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes'>
  <td width=295 valign=top style='width:221.4pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt'><span style='font-size:10.0pt;
  font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal style='margin-top:6.0pt'><span class=SpellE><i
  style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'>Nơi</span></i></span><i style='mso-bidi-font-style:
  normal'><span style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
  bold'> <span class=SpellE>nhận</span>:<br>
  </span></i><span style='font-size:8.0pt;mso-bidi-font-size:10.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'>- <span class=SpellE>Như</span> <span
  class=SpellE>trên</span>;<br>
  - <span class=SpellE>Lưu</span> <span class=SpellE>đơn</span> <span
  class=SpellE>vị</span>.<o:p></o:p></span></p>
  </td>
  <td width=270 valign=top style='width:202.5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;text-align:center'><span
  style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:bold'>TUQ. <span
  class=SpellE>Tổng</span> <span class=SpellE>Giám</span> <span class=SpellE>Đốc</span><br>
  <i style='mso-bidi-font-style:normal'>Authorized <span class=SpellE>byGeneral</span>
  Director<br>
  </i>GĐ. <span class=SpellE>Nhân</span> <span class=SpellE>sự</span> - <span
  class=SpellE>Tổng</span> <span class=SpellE>vụ</span><span
  style='mso-spacerun:yes'>                           </span>General manager of
  A &amp; S Dept.<o:p></o:p></span></p>
  <p class=MsoNormal align=center style='margin-top:6.0pt;text-align:center'><i
  style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>
  <p class=MsoNormal align=center style='margin-top:6.0pt;text-align:center'><i
  style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>
  <p class=MsoNormal align=center style='margin-top:6.0pt;text-align:center'><i
  style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>
  <p class=MsoNormal align=center style='margin-top:6.0pt;text-align:center'><i
  style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>
  <p class=MsoNormal align=center style='margin-top:6.0pt;text-align:center'><i
  style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'>HONG SOON WON<o:p></o:p></span></i></p>
  </td>
 </tr>
</table>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:right dotted 430.35pt'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:right dotted 430.35pt'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:right dotted 430.35pt'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:right dotted 430.35pt'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:right dotted 430.35pt'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:right dotted 430.35pt'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:right dotted 430.35pt'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:right dotted 430.35pt'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:right dotted 430.35pt'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:right dotted 430.35pt'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:right dotted 430.35pt'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:right dotted 430.35pt'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:right dotted 430.35pt'><span
style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;mso-yfti-tbllook:480;mso-padding-alt:0in 5.4pt 0in 5.4pt'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes'>
  <td width=295 valign=top style='width:221.4pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt'><span style='font-size:10.0pt;
  font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal style='margin-top:6.0pt'><span class=SpellE><i
  style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'>Nơi</span></i></span><i style='mso-bidi-font-style:
  normal'><span style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
  bold'> <span class=SpellE>nhận</span>:<br>
  </span></i><span style='font-size:8.0pt;mso-bidi-font-size:10.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'>- <span class=SpellE>Như</span> <span
  class=SpellE>trên</span>;<br>
  - <span class=SpellE>Lưu</span> <span class=SpellE>đơn</span> <span
  class=SpellE>vị</span>.<o:p></o:p></span></p>
  </td>
  <td width=270 valign=top style='width:202.5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;text-align:center'><span
  class=SpellE><span style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
  bold'>Tổng</span></span><span style='font-size:10.0pt;font-weight:normal;
  mso-bidi-font-weight:bold'> <span class=SpellE>Giám</span> <span
  class=SpellE>Đốc</span><br>
  <i style='mso-bidi-font-style:normal'>General Director<br style='mso-special-character:
  line-break'>
  <![if !supportLineBreakNewLine]><br style='mso-special-character:line-break'>
  <![endif]></i><o:p></o:p></span></p>
  <p class=MsoNormal align=center style='margin-top:6.0pt;text-align:center'><i
  style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>
  <p class=MsoNormal align=center style='margin-top:6.0pt;text-align:center'><i
  style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>
  <p class=MsoNormal align=center style='margin-top:6.0pt;text-align:center'><i
  style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>
  <p class=MsoNormal align=center style='margin-top:6.0pt;text-align:center'><i
  style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>
  <p class=MsoNormal align=center style='margin-top:6.0pt;text-align:center'><i
  style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'>RYU JU YEOL<o:p></o:p></span></i></p>
  </td>
 </tr>
</table>

<p class=MsoNormal style='margin-top:6.0pt;tab-stops:right dotted 430.35pt'><span
class=SpellE><span style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>Ghi</span></span><span style='font-size:10.0pt;font-weight:normal;
mso-bidi-font-weight:bold'> <span class=SpellE>chú</span>: <span class=SpellE>Đối</span>
<span class=SpellE>với</span> <span class=SpellE>các</span> <span class=SpellE>tổ</span>
<span class=SpellE>chức</span> phi <span class=SpellE>chính</span> <span
class=SpellE>phủ</span> <span class=SpellE>mà</span> <span class=SpellE>chưa</span>
<span class=SpellE>có</span> con <span class=SpellE>dấu</span> <span
class=SpellE>thì</span> <span class=SpellE>phải</span> <span class=SpellE>có</span>
<span class=SpellE>xác</span> <span class=SpellE>nhận</span> <span
class=SpellE>của</span> <span class=SpellE>Ủy</span> ban <span class=SpellE>công</span>
<span class=SpellE>tác</span> <span class=SpellE>về</span> <span class=SpellE>các</span>
<span class=SpellE>tổ</span> <span class=SpellE>chức</span> phi <span
class=SpellE>chính</span> <span class=SpellE>phủ</span> <span class=SpellE>nước</span>
<span class=SpellE>ngoài</span>.<o:p></o:p></span></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;mso-yfti-tbllook:480;mso-padding-alt:0in 5.4pt 0in 5.4pt'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes'>
  <td width=295 valign=top style='width:221.4pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt'><span style='font-size:10.0pt;
  font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal style='margin-top:6.0pt'><span class=SpellE><i
  style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'>Nơi</span></i></span><i style='mso-bidi-font-style:
  normal'><span style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
  bold'> <span class=SpellE>nhận</span>:<br>
  </span></i><span style='font-size:8.0pt;mso-bidi-font-size:10.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'>- <span class=SpellE>Như</span> <span
  class=SpellE>trên</span>;<br>
  - <span class=SpellE>Lưu</span> <span class=SpellE>đơn</span> <span
  class=SpellE>vị</span>.<o:p></o:p></span></p>
  </td>
  <td width=270 valign=top style='width:202.5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='margin-top:6.0pt;text-align:center'><span
  style='font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:bold'>TUQ. <span
  class=SpellE>Tổng</span> <span class=SpellE>Giám</span> <span class=SpellE>Đốc</span><br>
  <i style='mso-bidi-font-style:normal'>Authorized <span class=SpellE>byGeneral</span>
  Director<br>
  </i>GĐ. <span class=SpellE>Nhân</span> <span class=SpellE>sự</span> - <span
  class=SpellE>Tổng</span> <span class=SpellE>vụ</span><span
  style='mso-spacerun:yes'>                           </span>General manager of
  A &amp; S Dept.<o:p></o:p></span></p>
  <p class=MsoNormal align=center style='margin-top:6.0pt;text-align:center'><i
  style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>
  <p class=MsoNormal align=center style='margin-top:6.0pt;text-align:center'><i
  style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>
  <p class=MsoNormal align=center style='margin-top:6.0pt;text-align:center'><i
  style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>
  <p class=MsoNormal align=center style='margin-top:6.0pt;text-align:center'><i
  style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>
  <p class=MsoNormal align=center style='margin-top:6.0pt;text-align:center'><i
  style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'>HONG SOON WON<o:p></o:p></span></i></p>
  </td>
 </tr>
</table>

<%
     if (i == dt_emp.Rows.Count - 1)//nhan vien cuoi cung 
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
