<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
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
    = "select a.FULL_NAME   " +  //0
        ",decode(length(a.BIRTH_DT),4,a.BIRTH_DT,8,to_char(to_date(a.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy')) " + //1
        ",a.EMP_ID " +          //2
        ",(select v.CODE_KNM from vhr_hr_code v where v.ID='HR0008' and v.CODE= a.POS_TYPE) " +  //3
        ",to_char(to_date(a.BEGIN_PROBATION,'yyyymmdd'),'dd/mm/yyyy') as begin_probation " +   //4
        ",to_char(to_date(a.END_PROBATION,'yyyymmdd'),'dd/mm/yyyy') as end_probation " +     //5
        ",substr(a.BEGIN_PROBATION,7,2) DayBeginPro " +  //6
        ",substr(a.BEGIN_PROBATION,5,2) MonBeginPro " +  //7
        ",substr(a.BEGIN_PROBATION,1,4) YearBeginPro " + //8
        ",decode(a.SEX,'M','Ông','F','Bà','Ông/Bà') " + //9
        "from thr_employee a " +
        "where a.del_if=0 " +
        "and a.pk in ("+ emp_pk +") " ;
        

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
    
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 11">
<meta name=Originator content="Microsoft Word 11">
<link rel=File-List href="rpt_Labour_Decide_files/filelist.xml">
<title>TỈNH ĐỒNG NAI</title>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="country-region"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="place"/>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Daewon02</o:Author>
  <o:LastAuthor>PHONGNV</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>5</o:TotalTime>
  <o:Created>2010-10-08T01:58:00Z</o:Created>
  <o:LastSaved>2010-10-08T01:58:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>219</o:Words>
  <o:Characters>1254</o:Characters>
  <o:Lines>10</o:Lines>
  <o:Paragraphs>2</o:Paragraphs>
  <o:CharactersWithSpaces>1471</o:CharactersWithSpaces>
  <o:Version>11.6568</o:Version>
 </o:DocumentProperties>
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
	{font-family:Batang;
	panose-1:2 3 6 0 0 1 1 1 1 1;
	mso-font-alt:"Arial Unicode MS";
	mso-font-charset:129;
	mso-generic-font-family:auto;
	mso-font-format:other;
	mso-font-pitch:fixed;
	mso-font-signature:1 151388160 16 0 524288 0;}
@font-face
	{font-family:"\@Batang";
	panose-1:0 0 0 0 0 0 0 0 0 0;
	mso-font-charset:129;
	mso-generic-font-family:auto;
	mso-font-format:other;
	mso-font-pitch:fixed;
	mso-font-signature:1 151388160 16 0 524288 0;}
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
	{size:8.5in 11.0in;
	margin:.5in .5in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:111704426;
	mso-list-type:hybrid;
	mso-list-template-ids:719250026 922632068 67698691 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:.75in;
	mso-level-number-position:left;
	margin-left:.75in;
	text-indent:-.5in;
	font-family:"Times New Roman";
	mso-fareast-font-family:Batang;}
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
<p class=MsoNormal style='text-indent:.5in'>TỈNH ĐỒNG NAI<span
style='mso-tab-count:2'>                 </span><span
style='mso-spacerun:yes'>                        </span><b style='mso-bidi-font-weight:
normal'>CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT <st1:country-region w:st="on"><st1:place
 w:st="on">NAM</st1:place></st1:country-region><o:p></o:p></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><u><%= dt_name.Rows[0][1].ToString() %></u></b>.<span style='mso-tab-count:1'>       </span><span
style='mso-spacerun:yes'>        </span><span style='mso-tab-count:1'>    </span><b
style='mso-bidi-font-weight:normal'><u>Độc lập – Tự do – Hạnh phúc<o:p></o:p></u></b></p>

<p class=MsoNormal>Số: 070027/QĐNS-Cty</p>

<p class=MsoNormal align=right style='margin-left:2.5in;text-align:right;
text-indent:.5in'><i style='mso-bidi-font-style:normal'><span style='font-size:
14.0pt'>Đồng nai, ngày <%= dt_total.Rows[i][6].ToString() %> tháng <%= dt_total.Rows[i][7].ToString() %> năm <%= dt_total.Rows[i][8].ToString() %><o:p></o:p></span></i></p>

<p class=MsoNormal align=right style='text-align:right;background:#BFBFBF;
mso-shading:windowtext;mso-pattern:gray-25 auto'><span style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center style='margin-bottom:6.0pt;text-align:center'><b
style='mso-bidi-font-weight:normal'><span style='font-size:28.0pt;mso-bidi-font-size:
12.0pt'>QUYẾT ĐỊNH<o:p></o:p></span></b></p>

<p class=MsoNormal align=center style='margin-bottom:6.0pt;text-align:center'><b
style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt'>Về việc <u>tiếp
nhận và bố trí công tác</u> CB-CNV<o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:.25in'>- Căn cứ vào bản điều lệ <%= dt_name.Rows[4][1].ToString() %> ngày 29 tháng 08 năm
2007.</p>

<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:.25in'>- Căn cứ quyền hạn của Tổng giám đốc Công ty.</p>

<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:.25in'>- Căn cứ vào nhu cầu cần tuyển dụng của Công ty.</p>

<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:.25in'>- Căn cứ vào hồ sơ ứng tuyển của <%= dt_total.Rows[i][9].ToString() %> <%= dt_total.Rows[i][0].ToString() %>.</p>

<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:.25in'>- Xét năng lực và khả năng đáp ứng yêu cầu công việc của <%= dt_total.Rows[i][9].ToString() %> <%= dt_total.Rows[i][0].ToString() %></p>

<p class=MsoNormal align=center style='margin-top:0in;margin-right:0in;
margin-bottom:6.0pt;margin-left:.25in;text-align:center'><b style='mso-bidi-font-weight:
normal'><span style='font-size:14.0pt'>TỔNG GIÁM ĐỐC <%= dt_name.Rows[4][1].ToString() %><o:p></o:p></span></b></p>

<p class=MsoNormal align=center style='margin-top:0in;margin-right:0in;
margin-bottom:6.0pt;margin-left:.25in;text-align:center'><b style='mso-bidi-font-weight:
normal'><span style='font-size:22.0pt'>QUYẾT ĐỊNH<o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:.25in'><b style='mso-bidi-font-weight:normal'><u>Điều 1.</u><span
style='mso-tab-count:1'>      </span>Nay tiếp nhận và bố trí công tác đối với:<o:p></o:p></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:.25in'><%= dt_total.Rows[i][9].ToString() %><span style='mso-tab-count:3'>                                   </span>:<span
style='mso-tab-count:1'>           </span><%= dt_total.Rows[i][0].ToString() %></p>

<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:.25in'>Sinh năm<span style='mso-tab-count:3'>                           </span>:<span
style='mso-tab-count:1'>           </span><%= dt_total.Rows[i][1].ToString() %></p>

<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:.25in'>Mã số nhân viên<span style='mso-tab-count:2'>                </span>:<span
style='mso-tab-count:1'>           </span><%= dt_total.Rows[i][2].ToString() %></p>

<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:.25in'>Đảm nhận chức vụ<span style='mso-tab-count:1'>            </span>:<span
style='mso-tab-count:1'>           </span><%= dt_total.Rows[i][3].ToString() %>.</p>

<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:.25in'>Thời gian thử việc<span style='mso-tab-count:2'>             </span>:<span
style='mso-tab-count:1'>           </span>Từ ngày <%= dt_total.Rows[i][4].ToString() %> đến <%= dt_total.Rows[i][5].ToString() %></p>

<%--<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:.25in'><span style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>--%>

<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:.25in'><b style='mso-bidi-font-weight:normal'><u>Điều 2.</u><span
style='mso-tab-count:1'>      </span>Lương và các quyền lợi khác của <%= dt_total.Rows[i][9].ToString() %> <%= dt_total.Rows[i][0].ToString() %> được hưởng theo quy định Công ty:<o:p></o:p></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:.25in;text-align:justify'>Chủ quản đơn vị có trách nhiệm theo dõi
và đánh giá <%= dt_total.Rows[i][9].ToString() %> <%= dt_total.Rows[i][0].ToString() %> trong thời gian thử việc, nhận xét và đề xuất trình
Tổng giám đốc Công ty quyết định về việc có thực hiện ký kết Hợp đồng đới với
<%= dt_total.Rows[i][9].ToString() %> <%= dt_total.Rows[i][0].ToString() %> sau khi kết thúc thời gian thử việc.</p>

<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:.25in;text-align:justify'><b style='mso-bidi-font-weight:normal'><u>Điều
3</u></b>.<span style='mso-tab-count:1'>      </span>Khối hành chánh – tài
chánh, khối sản xuất, các đơn vị có liên quan và <%= dt_total.Rows[i][9].ToString() %> <%= dt_total.Rows[i][0].ToString() %> chiụ trách nhiệm
thi hành quyết định này.</p>

<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:.25in;text-align:justify'>Quyết định có hiệu lực kể từ ngày ký và
ban hành.</p>

<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:.25in'><b style='mso-bidi-font-weight:normal'><span
style='font-size:14.0pt'><span style='mso-tab-count:10'>                                                                                           </span>TỔNG
GIÁM ĐỐC<o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:.25in'><b style='mso-bidi-font-weight:normal'><u><span
style='font-size:14.0pt'>Nơi nhận:<o:p></o:p></span></u></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:.75in;text-indent:-.5in;mso-list:l0 level1 lfo2;tab-stops:list .75in'><![if !supportLists]><span
style='font-size:11.0pt;mso-fareast-font-family:"Times New Roman"'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='font-size:11.0pt'>Ban TGĐ (để kính
tường).<o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:.75in;text-indent:-.5in;mso-list:l0 level1 lfo2;tab-stops:list .75in'><![if !supportLists]><span
style='font-size:11.0pt;mso-fareast-font-family:"Times New Roman"'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='font-size:11.0pt'>Như điều 3 (để
thi hành).<o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:.75in;text-indent:-.5in;mso-list:l0 level1 lfo2;tab-stops:list .75in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='font-size:11.0pt'>Lưu HC-Cty.</span></p>

<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:.25in'><b style='mso-bidi-font-weight:normal'><span
style='font-size:14.0pt'><span style='mso-tab-count:10'>                                                                                       </span><%= dt_name.Rows[1][1].ToString() %><o:p></o:p></span></b></p>

</div>
<%} %>
</body>

</html>
