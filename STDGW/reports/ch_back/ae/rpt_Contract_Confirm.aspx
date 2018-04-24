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
	string contract_type       = Request["contract_type"].ToString();
    string SQL
	= "select h.PARTNER_FNAME as a0 " +
	    ",h.ADDR2 as a1 " +
	    ",h.PHONE_NO as a2 " +
	    ",h.FAX_NO as a3 " +
        ",TO_CHAR(to_date(a.ACTIVE_Dt,'YYYYMMDD'),'DD/MM/YYYY')  as a4 " +
        ",b.full_name as a5 " +
        ",b.emp_id as a6 " +
        ",c.org_nm as a7 " +
        ",(select code_nm || '(' || CODE_FNM || ')' from vhr_hr_code where id='HR0008' and code=b.POS_TYPE) as a8 " +
        ",TO_CHAR(to_date(b.join_dt,'YYYYMMDD'),'DD-mon-yy') as a9 " +
        ",TO_CHAR(to_date(a.begin_contract,'YYYYMMDD'),'DD-mon-yy') as a10 " +
        ",to_char(a.BASIC_SAL,'99,999,999') as a11 " +
        ",to_char(a.allow_amt1,'99,999,999') as a12 " +
        ",(select code_nm from vhr_hr_code v where v.id='HR0048' and tco_company_pk=h.pk and char_4='rpt_contract_confirm.aspx') as a13 " +
        "from thr_labour_contract a,thr_employee b,tco_org c,thr_work_group d ,tco_company h " +
        "where a.del_if=0 and b.del_if=0 and c.del_if=0 and d.del_if=0 and h.del_if=0 " +
        "and b.pk=a.thr_employee_pk and b.tco_company_pk=h.pk " +
        "and c.pk=b.tco_org_PK " +
        "and d.pk=b.thr_wg_pk " +
        "and b.pk in (" + emp_pk + ") " + 
        "and a.contract_type='"+contract_type+"' " ;
        
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
<link rel=File-List href="rpt_Contract_Confirm_files/filelist.xml">
<title>NOBLAND VIETNAM CO</title>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="place" downloadurl="http://www.5iantlavalamp.com/"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="country-region" downloadurl="http://www.5iantlavalamp.com/"/>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Vina_huy</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>15</o:TotalTime>
  <o:LastPrinted>2012-07-07T04:02:00Z</o:LastPrinted>
  <o:Created>2012-07-07T06:38:00Z</o:Created>
  <o:LastSaved>2012-07-07T06:38:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>316</o:Words>
  <o:Characters>1806</o:Characters>
  <o:Company>Genuwin</o:Company>
  <o:Lines>15</o:Lines>
  <o:Paragraphs>4</o:Paragraphs>
  <o:CharactersWithSpaces>2118</o:CharactersWithSpaces>
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
	{font-family:"Palatino Linotype";
	panose-1:2 4 5 2 5 5 5 3 3 4;
	mso-font-charset:0;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-536870009 1073741843 0 0 415 0;}
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
	text-align:right;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:1;
	font-size:12.0pt;
	font-family:Arial;
	mso-font-kerning:0pt;}
h2
	{mso-style-next:Normal;
	margin:0in;
	margin-bottom:.0001pt;
	text-align:center;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:2;
	font-size:26.0pt;
	font-family:Arial;
	font-weight:normal;}
h3
	{mso-style-next:Normal;
	margin:0in;
	margin-bottom:.0001pt;
	text-align:justify;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:3;
	font-size:12.0pt;
	font-family:Arial;}
p.MsoBodyText, li.MsoBodyText, div.MsoBodyText
	{margin:0in;
	margin-bottom:.0001pt;
	text-align:justify;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:Arial;
	mso-fareast-font-family:"Times New Roman";
	font-style:italic;}
p.MsoBodyText2, li.MsoBodyText2, div.MsoBodyText2
	{margin:0in;
	margin-bottom:.0001pt;
	text-align:justify;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:Arial;
	mso-fareast-font-family:"Times New Roman";
	font-style:italic;}
p.MsoBodyText3, li.MsoBodyText3, div.MsoBodyText3
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:0in;
	margin-bottom:.0001pt;
	text-align:justify;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:Arial;
	mso-fareast-font-family:"Times New Roman";}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:595.45pt 841.7pt;
	margin:.2in 1.0in 1.5in 1.0in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
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

<% 
     
     for (int i = 0; i < irow; i++) 
    {
       
    %> 

<div class=Section1>

<p class=MsoNormal><b><span style='font-size:11.0pt;font-family:Arial'><%= dt_total.Rows[i]["a0"].ToString() %><o:p></o:p></span></b></p>

<p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'><%= dt_total.Rows[i]["a1"].ToString() %><o:p></o:p></span></p>

<div style='mso-element:para-border-div;border:none;border-bottom:solid windowtext 1.0pt;
mso-border-bottom-alt:solid windowtext .75pt;padding:0in 0in 1.0pt 0in'>

<p class=MsoNormal style='border:none;mso-border-bottom-alt:solid windowtext .75pt;
padding:0in;mso-padding-alt:0in 0in 1.0pt 0in'><span style='font-size:10.0pt;
font-family:Arial'>Tel.: <%= dt_total.Rows[i]["a2"].ToString() %><span style='mso-tab-count:1'> </span> Fax: <%= dt_total.Rows[i]["a3"].ToString() %><o:p></o:p></span></p>

</div>

<h1 align=left style='text-align:left'><span style='font-size:8.0pt;color:black;
font-weight:normal'>NO:</span><span style='font-size:8.0pt;color:purple'> </span><span
style='font-size:8.0pt;color:black'><%=i+1 %></span><span style='font-size:11.0pt;
color:black'><span style='mso-tab-count:1'>     </span></span><span
style='font-size:11.0pt;color:purple'><span style='mso-tab-count:6'>                                                                        </span><span
style='mso-spacerun:yes'>              </span>PRIVATE AND CONFIDENTAL<o:p></o:p></span></h1>

<h2><b><span style='font-size:20.0pt'>CONFIRMATION LETTER<o:p></o:p></span></b></h2>

<p class=MsoNormal align=center style='text-align:center;line-height:150%'><span
style='font-size:15.0pt;line-height:150%;font-family:"Palatino Linotype";
mso-bidi-font-family:"Palatino Linotype"'><span
style='mso-spacerun:yes'>                                         </span>(<b>THƯ
XÁC NHẬN)<span style='mso-spacerun:yes'>                    </span></b></span><b><span
style='font-family:"Palatino Linotype";mso-bidi-font-family:"Palatino Linotype"'>Date:
<%= dt_total.Rows[i]["a4"].ToString() %></span></b><span style='font-size:8.0pt;line-height:150%;font-family:"Palatino Linotype";
mso-bidi-font-family:"Palatino Linotype"'><o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify;tab-stops:.5in 1.0in 1.5in 2.0in 2.5in 3.0in 327.75pt'><span
style='font-size:11.0pt;font-family:Arial'>Full name <i>(Họ và tên)<span
style='mso-tab-count:1'> </span></i></span><span style='font-family:Arial'><span
style='mso-tab-count:1'>            </span>: <b><%= dt_total.Rows[i]["a5"].ToString() %><span style='mso-tab-count:
1'>      </span></b><o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-size:11.0pt;
font-family:Arial'>Emp. Code <i>(MSNV)<span style='mso-tab-count:1'>   </span></i></span><i><span
style='font-family:Arial'><span style='mso-tab-count:1'>            </span></span></i><span
style='font-family:Arial'>: <b><%= dt_total.Rows[i]["a6"].ToString() %></b><o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-size:11.0pt;
font-family:Arial'>Department <i>(Bộ phận)<span style='mso-tab-count:2'>                        </span></i></span><span
style='font-family:Arial'>: <%= dt_total.Rows[i]["a7"].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-size:11.0pt;
font-family:Arial'>Position <i>(Vị trí)</i></span><span style='font-family:
Arial'><span style='mso-tab-count:3'>                                    </span>:
<%= dt_total.Rows[i]["a8"].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-family:Arial'>Starting
date <i>(Ngày vào)<span style='mso-tab-count:2'>                 </span></i>: <%= dt_total.Rows[i]["a9"].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-size:11.0pt;
font-family:Arial'>Effective date <i>(Ngày hiệu lực)</i></span><i><span
style='font-family:Arial'><span style='mso-tab-count:1'>           </span></span></i><span
style='font-family:Arial'>: <%= dt_total.Rows[i]["a10"].ToString() %><o:p></o:p></span></p>

<p class=MsoBodyText3><span style='font-size:11.0pt'>Please be informed that
management has found your performance as well as positive working attitude was
highly appreciated during last period working.<o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span class=GramE><span
style='font-size:10.0pt;font-family:Arial'>(<i>Chúng tôi rất hân hạnh được
thông báo rằng Ban Giám Đốc đã đánh giá cao khả năng và thái độ làm việc của
bạn trong suốt thời gian qua).</i></span></span><i><span style='font-size:10.0pt;
font-family:Arial'><o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify'><span
style='font-size:11.0pt;font-family:Arial'>After discussion and preserve the
unity and oneness of mind within our company about the salary system, your
salary will be adjusted as follows:<o:p></o:p></span></p>

<p class=MsoBodyText><span style='font-size:10.0pt'>(Sau khi thảo luận và căn
cứ trên hệ thống lương của công ty, lương của bạn sẽ được điều chỉnh như <span
class=GramE>sau:</span>)<o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;tab-stops:177.65pt'><span
style='font-size:11.0pt;font-family:Arial'>Monthly gross basic salary<span
style='mso-tab-count:1'>                </span>:<span
style='mso-spacerun:yes'>  </span><b><span style='mso-spacerun:yes'> </span><span
class=GramE><%= dt_total.Rows[i]["a11"].ToString() %><span style='mso-spacerun:yes'>  </span><span style='font-weight:
normal'>VNĐ</span></span></b>/26 ngày công<o:p></o:p></span></p>

<p class=MsoBodyText2 style='tab-stops:177.65pt'><span style='font-size:10.0pt'>(Lương
căn bản (lương thuần)<o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify;tab-stops:177.65pt'><span
style='font-size:11.0pt;font-family:Arial'>Add to allowance<span
style='mso-tab-count:1'>                                </span>:<span
style='mso-spacerun:yes'>  </span><b><span style='mso-spacerun:yes'> </span><%= dt_total.Rows[i]["a12"].ToString() %><span
style='mso-spacerun:yes'>  </span></b>VNĐ/26 ngày công<b> </b><o:p></o:p></span></p>

<p class=MsoBodyText style='tab-stops:177.65pt'><span style='font-size:10.0pt'>(Cộng
với phụ cấp)<o:p></o:p></span></p>

<p class=MsoBodyText3><span style='font-size:11.0pt'>Nhân đây chúng tôi cũng
thông báo cho bạn rằng để đảm bảo tiến độ và nhu cầu công việc, có khả năng
Công ty sẽ điều động bạn làm việc <span class=GramE>theo</span> ca ngày và đêm
(ca ngày làm việc từ 07:30 sáng – 16:30 chiều, ca đêm từ 21:30 tối – 5:30
sáng).<o:p></o:p></span></p>

<p class=MsoBodyText><span style='font-size:10.0pt'>(By the way, we also inform
to you that<span style='mso-spacerun:yes'>  </span>in order to catch up with
progress and production requirements, we maybe appoint your work according to
dayshift and nightshift (dayshift begin from 7:30AM to 16:30PM, nightshift
begin from 21:30 PM<span style='mso-spacerun:yes'>  </span>to 5:30 AM) <o:p></o:p></span></p>

<p class=MsoBodyText3 style='margin-top:6.0pt'><span style='font-size:11.0pt'>We
hope that you will continue to give your best to the company and we look
forward to a mutually beneficial employment relationship with you.<o:p></o:p></span></p>

<p class=MsoBodyText2><span style='font-size:10.0pt'>(Chúng tôi hy vọng rằng
bạn sẽ tiếp tục góp sức vào sự thành công của công ty, và chúng tôi mong đợi sự
gắn bó lâu dài của bạn với công ty.)<o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-size:7.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-size:11.0pt;
font-family:Arial'>Yours sincerely,<o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-size:11.0pt;
font-family:Arial'>(<i>Thân ái,)<o:p></o:p></i></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-size:11.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-family:Arial'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-family:Arial'><o:p>&nbsp;</o:p></span></p>

<h3><span style='font-size:11.0pt'><%= dt_total.Rows[i]["a13"].ToString() %></span></h3>

<div style='mso-element:para-border-div;border:none;border-bottom:solid windowtext 1.0pt;
mso-border-bottom-alt:solid windowtext .75pt;padding:0in 0in 1.0pt 0in'>

<p class=MsoNormal style='text-align:justify;border:none;mso-border-bottom-alt:
solid windowtext .75pt;padding:0in;mso-padding-alt:0in 0in 1.0pt 0in'><b><span
style='font-family:Arial'>General Director<o:p></o:p></span></b></p>

</div>

<p class=MsoNormal style='text-align:justify'><span style='font-size:11.0pt;
font-family:Arial'>I<span class=GramE>,<span style='mso-spacerun:yes'> 
</span>,</span> acknowledged and accepted with above mention letter.<o:p></o:p></span></p>

<p class=MsoBodyText><span style='font-size:10.0pt'>(Tôi<span class=GramE>, <b><span
style='mso-spacerun:yes'> </span></b>,</span> xác nhận và hoàn toàn đồng ý với
nội dung trên.)</span><span style='font-size:11.0pt'><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify'><span
style='font-family:Arial'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify'><span
style='font-family:Arial'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-family:Arial'>-----------------------------------<o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify;tab-stops:280.5pt'><span
class=GramE><b><span style='font-family:Arial'>Employee’s signature.</span></b></span><b><span
style='font-family:Arial'> <span style='mso-tab-count:1'>                                                  </span>Employee’s
code: <o:p></o:p></span></b></p>

<p class=MsoNormal style='text-align:justify;tab-stops:280.5pt'><span
style='font-size:10.0pt;font-family:Arial'>(<i>Họ và tên nhân viên)<span
style='mso-tab-count:1'>                                                               </span>(MSNV)
</i></span><!--[if supportFields]><i><span style='font-size:8.0pt;font-family:
Arial'><span style='mso-element:field-begin'></span><span
style='mso-spacerun:yes'> </span>MERGEFIELD &quot;check&quot; </span></i><![endif]--><!--[if supportFields]><i><span
style='font-size:8.0pt;font-family:Arial'><span style='mso-element:field-end'></span></span></i><![endif]--><i><span
style='font-size:8.0pt;font-family:Arial'><o:p></o:p></span></i></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

</div>

<%
     if (i != irow - 1)//nhan vien cuoi cung 
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
</body>

</html>
