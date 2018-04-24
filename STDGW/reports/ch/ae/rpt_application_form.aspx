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
    string sql_lang, str_lang;
    string SQL
    = "select to_char(sysdate,'dd') c00 " +
        "        ,to_char(sysdate,'mm') c01 " +
        "        ,to_char(sysdate,'yyyy') c02 " +
        "        ,upper(E.FULL_NAME) c03 " +
        "        ,upper(E.FULL_FNAME) c04 " +
        "        ,decode(length(E.BIRTH_DT),4,E.BIRTH_DT, to_char(to_date(E.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy')) c05                 " +
        "        ,(select code_fnm from vhr_hr_code v where V.CODE=E.SEX and V.ID='HR0007') c06 " +
        "        ,(select code_nm from vhr_hr_code v where V.CODE=E.SEX and V.ID='HR0007') c07 " +
        "        ,(select code_fnm from vhr_hr_code v where V.CODE=E.NATION and V.ID='HR0009') c09 " +
        "        ,(select code_nm from vhr_hr_code v where V.CODE=E.NATION and V.ID='HR0009') c10 " +
        "         " +
        "        ,decode(E.NATION,'01',E.PASS_PORT_NO, P.PASSPORT_NO) c11 " +
        "        ,decode(E.NATION,'01',to_char(to_date(E.PASS_PORT_DT ,'yyyymmdd'),'dd/mm/yyyy'),to_char(to_date(P.FROM_DT ,'yyyymmdd'),'dd/mm/yyyy'))c12 " +
        "        ,(select code_fnm from vhr_hr_code v where V.CODE=E.NATION and V.ID='HR0009') c13 " +
        "        ,decode(E.NATION,'01',to_char(to_date(E.PASS_PORT_EXPIRE_DT ,'yyyymmdd'),'dd/mm/yyyy'),to_char(to_date(P.TO_DT ,'yyyymmdd'),'dd/mm/yyyy'))c14 " +
        "        ,(select code_fnm from vhr_hr_code v where V.CODE=E.EDU_TYPE and V.ID='HR0011') c15 " +
        "        ,(select code_nm from vhr_hr_code v where V.CODE=E.EDU_TYPE and V.ID='HR0011') c16 " +
        "        ,(select code_fnm from vhr_hr_code v where V.CODE=E.MAJOR  and V.ID='HR0148') c17 " +
        "        ,(select code_nm from vhr_hr_code v where V.CODE=E.MAJOR and V.ID='HR0148') c18  , e.pk c19       " +
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
<link rel=File-List href="rpt_application_form_files/filelist.xml">
<title>MẪU SỐ 1</title>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="country-region"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="place"/>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>User</o:Author>
  <o:LastAuthor>cun</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>336</o:TotalTime>
  <o:LastPrinted>2012-03-26T10:08:00Z</o:LastPrinted>
  <o:Created>2013-01-18T07:11:00Z</o:Created>
  <o:LastSaved>2013-01-18T07:11:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>390</o:Words>
  <o:Characters>2228</o:Characters>
  <o:Company>HOME</o:Company>
  <o:Lines>18</o:Lines>
  <o:Paragraphs>5</o:Paragraphs>
  <o:CharactersWithSpaces>2613</o:CharactersWithSpaces>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
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
	font-size:13.0pt;
	font-family:Arial;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";}
span.shorttext
	{mso-style-name:short_text;}
span.hps
	{mso-style-name:hps;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:.25in 1.25in 9.0pt 1.25in;
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
<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:27.0pt'><b style='mso-bidi-font-weight:normal'><span
style='font-size:9.0pt;color:teal'>MẪU SỐ 1.</span></b><i style='mso-bidi-font-style:
normal'><span style='font-size:9.0pt;color:teal'> Ban <span class=SpellE>hành</span>
<span class=SpellE>kèm</span> <span class=SpellE>theo</span> <span
class=SpellE>Thông</span> <span class=SpellE>tư</span> <span class=SpellE>số</span>
08/2008/TT-BLĐTBXH <span class=SpellE>ngày</span> 10/6/2008 <span class=SpellE>của</span>
<span class=SpellE>Bộ</span> Lao <span class=SpellE>động</span> – <span
class=SpellE>Thương</span> <span class=SpellE>binh</span> <span class=SpellE>và</span>
<span class=SpellE>Xã</span> <span class=SpellE>hội</span> <span class=SpellE>hướng</span>
<span class=SpellE>dẫn</span> <span class=SpellE>thi</span> <span class=SpellE>hành</span>
<span class=SpellE>một</span> <span class=SpellE>số</span> <span class=SpellE>điều</span>
<span class=SpellE>của</span> <span class=SpellE>Nghị</span> <span
class=SpellE>định</span> <span class=SpellE>số</span> 34/2008/NĐ-CP <span
class=SpellE>ngày</span> 25/3/2008 <span class=SpellE>của</span> <span
class=SpellE>Chính</span> <span class=SpellE>phủ</span> <span class=SpellE>về</span>
<span class=SpellE>tuyển</span> <span class=SpellE>dụng</span> <span
class=SpellE>và</span> <span class=SpellE>quản</span> <span class=SpellE>lý</span>
<span class=SpellE>người</span> <span class=SpellE>nước</span> <span
class=SpellE>ngoài</span> <span class=SpellE>làm</span> <span class=SpellE>việc</span>
<span class=SpellE>tại</span> <span class=SpellE>Việt</span> Nam.<o:p></o:p></span></i></p>

<p class=MsoNormal align=center style='text-align:center'><b style='mso-bidi-font-weight:
normal'><span style='font-size:11.0pt;mso-bidi-font-size:10.0pt;mso-bidi-font-family:
Arial'>CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT <st1:place w:st="on"><st1:country-region
 w:st="on">NAM</st1:country-region></st1:place><br>
<span class=SpellE>Độc</span> <span class=SpellE>lập</span> – <span
class=SpellE>Tự</span> do – <span class=SpellE>Hạnh</span> <span class=SpellE>phúc</span><br>
</span></b><b style='mso-bidi-font-weight:normal'><span style='font-size:15.0pt;
mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>——————————</span></b><span
style='font-size:11.0pt;mso-bidi-font-size:10.0pt;mso-bidi-font-family:Arial'><o:p></o:p></span></p>

<p class=MsoNormal align=right style='text-align:right'><i style='mso-bidi-font-style:
normal'><span style='font-size:11.0pt;mso-bidi-font-size:13.0pt;color:teal'><span
style='mso-spacerun:yes'>                  </span><span class=SpellE>Tân</span>
<span class=SpellE>Thành</span>, <span class=SpellE>ngày</span> (date)<span
style='mso-spacerun:yes'> <%=dt_emp.Rows[i]["c00"].ToString()%>    </span><span class=SpellE>tháng</span> (month)<span
style='mso-spacerun:yes'>   <%=dt_emp.Rows[i]["c01"].ToString()%>     </span><span class=SpellE>năm</span> (year) <span
style='mso-spacerun:yes'> </span><%=dt_emp.Rows[i]["c02"].ToString()%><o:p></o:p></span></i></p>

<p class=MsoNormal align=right style='text-align:right'><span style='font-size:
10.0pt;mso-bidi-font-size:13.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center style='text-align:center'><b style='mso-bidi-font-weight:
normal'><span style='font-size:12.0pt;mso-bidi-font-size:13.0pt'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal align=center style='text-align:center'><b style='mso-bidi-font-weight:
normal'><span style='font-size:14.0pt'>PHIẾU ĐĂNG KÝ DỰ TUYỂN LAO ĐỘNG<o:p></o:p></span></b></p>

<p class=MsoNormal align=center style='margin-bottom:6.0pt;text-align:center'><i
style='mso-bidi-font-style:normal'><span style='font-size:12.0pt;color:teal'>APPLICATION
FORM<o:p></o:p></span></i></p>

<p class=MsoNormal align=center style='margin-bottom:6.0pt;text-align:center'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;mso-bidi-font-size:
13.0pt;color:teal'><o:p>&nbsp;</o:p></span></i></p>

<p class=MsoNormal style='text-indent:.4in;tab-stops:right dotted 5.5in'><span
class=SpellE><b style='mso-bidi-font-weight:normal'><span style='font-size:
11.0pt;mso-bidi-font-size:13.0pt'>Kính</span></b></span><b style='mso-bidi-font-weight:
normal'><span style='font-size:11.0pt;mso-bidi-font-size:13.0pt'> <span
class=SpellE>gửi</span>:<span style='mso-spacerun:yes'>  </span><span
style='mso-spacerun:yes'> </span><span class=SpellE>Công</span> <span
class=SpellE>ty</span> TNHH POSCO SS-VINA<o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-indent:.4in;tab-stops:right dotted 5.5in'><i
style='mso-bidi-font-style:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
13.0pt;color:teal'>To:<span style='mso-spacerun:yes'>  </span><span
style='mso-spacerun:yes'>           </span><span
style='mso-spacerun:yes'> </span>POSCO SS-VINA Co., Ltd<o:p></o:p></span></i></p>

<p class=MsoNormal style='text-indent:.4in;tab-stops:153.0pt 171.0pt 261.0pt 4.25in 4.5in right dotted 5.5in'><span
style='font-size:11.0pt;mso-bidi-font-size:13.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-indent:.4in;tab-stops:153.0pt 171.0pt 261.0pt 4.25in 4.5in right dotted 5.5in'><span
class=SpellE><span style='font-size:11.0pt;mso-bidi-font-size:13.0pt'>Tôi</span></span><span
style='font-size:11.0pt;mso-bidi-font-size:13.0pt'> <span class=SpellE>tên</span>
<span class=SpellE>là</span> (<span class=SpellE><i style='mso-bidi-font-style:
normal'>viết</i></span><i style='mso-bidi-font-style:normal'> <span
class=SpellE>chữ</span> in <span class=SpellE>hoa</span>):<span
style='mso-tab-count:1'>    </span><span style='mso-spacerun:yes'>   </span></i><%=dt_emp.Rows[i]["c03"].ToString()%><o:p></o:p></span></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-indent:.4in;tab-stops:right dotted 5.5in'><i
style='mso-bidi-font-style:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
13.0pt;color:teal'>Full name (in capital):<span
style='mso-spacerun:yes'>             </span><span
style='mso-spacerun:yes'> </span><%=dt_emp.Rows[i]["c04"].ToString()%><o:p></o:p></span></i></p>

<p class=MsoNormal style='text-indent:.4in;tab-stops:4.25in 4.75in 351.0pt 6.0in'><span
class=SpellE><span style='font-size:11.0pt;mso-bidi-font-size:13.0pt'>Ngày</span></span><span
style='font-size:11.0pt;mso-bidi-font-size:13.0pt'> <span class=SpellE>tháng</span>
<span class=SpellE>năm</span> <span class=SpellE>sinh</span>: <span
style='mso-spacerun:yes'>          </span><span
style='mso-spacerun:yes'>   </span><%=dt_emp.Rows[i]["c05"].ToString()%><span
style='mso-spacerun:yes'>         </span><span
style='mso-spacerun:yes'>                               </span>Nam /<span
class=SpellE>Nữ</span>: <%=dt_emp.Rows[i]["c06"].ToString()%><o:p></o:p></span></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-indent:.4in;tab-stops:right dotted 5.5in'><i
style='mso-bidi-font-style:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
13.0pt;color:teal'>Date of birth (DD-MM-YYYY): <%=dt_emp.Rows[i]["c05"].ToString()%><span
style='mso-spacerun:yes'>           </span><span
style='mso-spacerun:yes'>                         </span>Sex: <%=dt_emp.Rows[i]["c07"].ToString()%><o:p></o:p></span></i></p>

<p class=MsoNormal style='text-indent:.4in;tab-stops:right dotted 5.5in'><span
class=SpellE><span style='font-size:11.0pt;mso-bidi-font-size:13.0pt'>Quốc</span></span><span
style='font-size:11.0pt;mso-bidi-font-size:13.0pt'> <span class=SpellE>tịch</span>:
<span style='mso-spacerun:yes'>                               </span><span
style='mso-spacerun:yes'> </span><span class=SpellE><%=dt_emp.Rows[i]["c09"].ToString()%></span> <span
class=SpellE></span><o:p></o:p></span></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-indent:.4in;tab-stops:right dotted 5.5in'><span
class=SpellE><i style='mso-bidi-font-style:normal'><span style='font-size:11.0pt;
mso-bidi-font-size:13.0pt;color:teal'>Nationalitity</span></i></span><i
style='mso-bidi-font-style:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
13.0pt;color:teal'>:<span style='mso-spacerun:yes'>                          
</span><span style='mso-spacerun:yes'> </span><span
style='mso-spacerun:yes'> </span><%=dt_emp.Rows[i]["c10"].ToString()%><o:p></o:p></span></i></p>

<p class=MsoNormal style='text-indent:27.0pt;tab-stops:right dotted 6.0in'><span
class=SpellE><span style='font-size:11.0pt;mso-bidi-font-size:13.0pt'>Số</span></span><span
style='font-size:11.0pt;mso-bidi-font-size:13.0pt'> <span class=SpellE>hộ</span>
<span class=SpellE>chiếu</span>:<span
style='mso-spacerun:yes'>                  </span><%=dt_emp.Rows[i]["c11"].ToString()%><span
style='mso-spacerun:yes'>     </span><span
style='mso-spacerun:yes'>                    </span><span class=SpellE>Ngày</span>
<span class=SpellE>cấp</span>:<span style='mso-spacerun:yes'>     </span><span
style='mso-spacerun:yes'>         </span><%=dt_emp.Rows[i]["c12"].ToString()%><o:p></o:p></span></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-indent:.4in;tab-stops:right dotted 5.5in'><i
style='mso-bidi-font-style:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
13.0pt;color:teal'>Passport number:<span style='mso-spacerun:yes'>        
</span><%=dt_emp.Rows[i]["c11"].ToString()%><span style='mso-spacerun:yes'>       </span><span
style='mso-spacerun:yes'>                 </span>Date of issue:<span
style='mso-spacerun:yes'>        </span><%=dt_emp.Rows[i]["c12"].ToString()%><o:p></o:p></span></i></p>

<p class=MsoNormal style='text-indent:.4in;tab-stops:right dotted 5.5in'><span
class=SpellE><span style='font-size:11.0pt;mso-bidi-font-size:13.0pt'>Nơi</span></span><span
style='font-size:11.0pt;mso-bidi-font-size:13.0pt'> <span class=SpellE>cấp</span>:<span
style='mso-spacerun:yes'>                               </span><span
style='mso-spacerun:yes'> </span><span style='mso-spacerun:yes'>  </span><span
style='mso-spacerun:yes'>  </span><span
style='mso-spacerun:yes'>                </span><span class=SpellE><%=dt_emp.Rows[i]["c09"].ToString()%></span> <span
class=SpellE></span> <span class=SpellE></span> <span class=SpellE></span>
<span class=SpellE></span> <span class=SpellE></span> <span
class=SpellE></span> <span class=SpellE></span><span
style='mso-spacerun:yes'>  </span><o:p></o:p></span></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-indent:.4in;tab-stops:right dotted 5.5in'><i
style='mso-bidi-font-style:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
13.0pt;color:teal'>Place of issue:<span
style='mso-spacerun:yes'>                      </span><span
style='mso-spacerun:yes'>  </span><span
style='mso-spacerun:yes'>         </span><%=dt_emp.Rows[i]["c10"].ToString()%><span
style='mso-spacerun:yes'>               </span><span
style='mso-spacerun:yes'> </span><span
style='mso-spacerun:yes'> </span><span
style='mso-spacerun:yes'>                                         </span><o:p></o:p></span></i></p>

<p class=MsoNormal style='text-indent:.4in;tab-stops:right dotted 5.5in'><i
style='mso-bidi-font-style:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
13.0pt'><span style='mso-spacerun:yes'> </span></span></i><span class=SpellE><span
style='font-size:11.0pt;mso-bidi-font-size:13.0pt'>Có</span></span><span
style='font-size:11.0pt;mso-bidi-font-size:13.0pt'> <span class=SpellE>giá</span>
<span class=SpellE>trị</span> <span class=SpellE>đến</span> <span class=SpellE>ngày</span>:
<span style='mso-spacerun:yes'>             </span><span
style='mso-spacerun:yes'>   </span><%=dt_emp.Rows[i]["c14"].ToString()%><o:p></o:p></span></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-indent:.4in;tab-stops:right dotted 5.5in'><i
style='mso-bidi-font-style:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
13.0pt;color:teal'>Date of expiry: <span
style='mso-spacerun:yes'>                    </span><span
style='mso-spacerun:yes'>    </span><span style='mso-spacerun:yes'> </span><%=dt_emp.Rows[i]["c14"].ToString()%><o:p></o:p></span></i></p>

<p class=MsoNormal style='text-indent:.4in;tab-stops:right dotted 5.5in'><span
class=SpellE><span style='font-size:11.0pt;mso-bidi-font-size:13.0pt'>Trình</span></span><span
style='font-size:11.0pt;mso-bidi-font-size:13.0pt'> <span class=SpellE>độ</span>
<span class=SpellE>học</span> <span class=SpellE>vấn</span>:<span
style='mso-spacerun:yes'>               </span><span
style='mso-spacerun:yes'>    </span><span style='mso-spacerun:yes'> </span><span
style='mso-spacerun:yes'> </span><span class=SpellE><%=dt_emp.Rows[i]["c15"].ToString()%></span> <span
class=SpellE></span><o:p></o:p></span></p>

<p class=MsoNormal style='text-indent:.4in;tab-stops:right dotted 5.5in'><i
style='mso-bidi-font-style:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
13.0pt;color:teal'>Education: <span style='mso-spacerun:yes'>  </span><span
style='mso-spacerun:yes'>                             </span><%=dt_emp.Rows[i]["c16"].ToString()%></span></i><span
style='font-size:11.0pt;mso-bidi-font-size:13.0pt'><o:p></o:p></span></p>

<p class=MsoNormal style='text-indent:.4in;tab-stops:right dotted 5.5in'><span
class=SpellE><span style='font-size:11.0pt;mso-bidi-font-size:13.0pt'>Trình</span></span><span
style='font-size:11.0pt;mso-bidi-font-size:13.0pt'> <span class=SpellE>độ</span>
<span class=SpellE>chuyên</span> <span class=SpellE>môn</span> <span
class=SpellE>tay</span> <span class=SpellE>nghề</span>: <span
style='mso-spacerun:yes'>            </span><span
style='mso-spacerun:yes'>    </span><span class=SpellE><%=dt_emp.Rows[i]["c17"].ToString()%></span> <span
class=SpellE></span> <span class=SpellE></span> <span class=SpellE></span>
<span class=SpellE></span> <span class=SpellE></span><o:p></o:p></span></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-indent:.4in;tab-stops:right dotted 5.5in'><i
style='mso-bidi-font-style:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
13.0pt;color:teal'>Professional qualification: <span
style='mso-spacerun:yes'>                      </span><span
style='mso-spacerun:yes'> </span><span style='mso-spacerun:yes'>  </span><%=dt_emp.Rows[i]["c18"].ToString()%><o:p></o:p></span></i></p>

<%
    sql_lang = "select note_1 from thr_expand a where a.del_if=0 and a.thr_employee_pk= " + dt_emp.Rows[i]["c19"].ToString();
    DataTable dt_lang = ESysLib.TableReadOpen(sql_lang);
    str_lang = "";
    for (int j = 0; j < dt_lang.Rows.Count; j++)
    {
        str_lang += dt_lang.Rows[j]["note_1"].ToString();
        if (j == dt_lang.Rows.Count)
            str_lang += ".";
        else
            str_lang += ",";
    }
         %>
<p class=MsoNormal style='text-indent:.4in;tab-stops:right dotted 5.5in'><span
class=SpellE><span style='font-size:11.0pt;mso-bidi-font-size:13.0pt'>Trình</span></span><span
style='font-size:11.0pt;mso-bidi-font-size:13.0pt'> <span class=SpellE>độ</span>
<span class=SpellE>ngoại</span> <span class=SpellE>ngữ</span> (<span
class=SpellE>sử</span> <span class=SpellE>dụng</span> <span class=SpellE>thành</span>
<span class=SpellE>thạo</span>):<span style='mso-spacerun:yes'>  </span><span
style='mso-spacerun:yes'>    </span><span style='mso-spacerun:yes'> </span><span
style='mso-spacerun:yes'> </span><span class=SpellE><%=str_lang%></span> <span
class=SpellE></span><o:p></o:p></span></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-indent:.4in;tab-stops:right dotted 5.5in'><i
style='mso-bidi-font-style:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
13.0pt;color:teal'>Foreign language (Proficiency): <span
style='mso-spacerun:yes'>                  </span><span
style='mso-spacerun:yes'>     </span><o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-left:27.0pt;text-indent:9.0pt;tab-stops:right dotted 5.5in'><span
class=SpellE><span style='font-size:11.0pt;mso-bidi-font-size:13.0pt'>Sau</span></span><span
style='font-size:11.0pt;mso-bidi-font-size:13.0pt'> <span class=SpellE>khi</span>
<span class=SpellE>nghiên</span> <span class=SpellE>cứu</span> <span
class=SpellE>nội</span> dung <span class=SpellE>thông</span> <span
class=SpellE>báo</span> <span class=SpellE>tuyển</span> <span class=SpellE>lao</span>
<span class=SpellE>động</span> <span class=SpellE>của</span> <span
class=SpellE>người</span> <span class=SpellE>sử</span> <span class=SpellE>dụng</span>
<span class=SpellE>lao</span> <span class=SpellE>động</span>, <span
class=SpellE>tôi</span> <span class=SpellE>thấy</span> <span class=SpellE>bản</span>
<span class=SpellE>thân</span> <span class=SpellE>có</span> <span class=SpellE>đủ</span>
<span class=SpellE>điều</span> <span class=SpellE>kiện</span> <span
class=SpellE>để</span> <span class=SpellE>đăng</span> <span class=SpellE>ký</span>
<span class=SpellE>dự</span> <span class=SpellE>tuyển</span> <span
class=SpellE>vào</span> <span class=SpellE>vị</span> <span class=SpellE>trí</span>:
<span class=SpellE>Nhân</span> <span class=SpellE>viên</span> <span
class=SpellE>Bộ</span> <span class=SpellE>phận</span> <span class=SpellE>Kế</span>
<span class=SpellE>hoạch</span> – <span class=SpellE>Tài</span> <span
class=SpellE>chính</span> <span class=SpellE>với</span> <span class=SpellE>thời</span>
<span class=SpellE>hạn</span> <span class=SpellE>làm</span> <span class=SpellE>việc</span>:
<span class=SpellE>Không</span> <span class=SpellE>xác</span> <span
class=SpellE>định</span> <span class=SpellE>thời</span> <span class=SpellE>hạn</span></span><span
class=hps><span style='mso-bidi-font-family:Arial;color:#333333;mso-ansi-language:
EN'> </span></span><span style='font-size:11.0pt;mso-bidi-font-size:13.0pt'><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:27.35pt;text-indent:2.15pt;tab-stops:right dotted 423.0pt'><i
style='mso-bidi-font-style:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
13.0pt;color:teal'>Upon careful consideration on your announcement of
recruitment, I myself consider to be qualified for the position of Planning
&amp; Financing Staff for the working period of: indefinite period.<o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:27.0pt;text-indent:1.8pt;tab-stops:right dotted 5.5in'><span
class=SpellE><span style='font-size:11.0pt;mso-bidi-font-size:13.0pt'>Tôi</span></span><span
style='font-size:11.0pt;mso-bidi-font-size:13.0pt'> <span class=SpellE>xin</span>
<span class=SpellE>chấp</span> <span class=SpellE>hành</span> <span
class=SpellE>nghiêm</span> <span class=SpellE>chỉnh</span> <span class=SpellE>Pháp</span>
<span class=SpellE>luật</span> <span class=SpellE>lao</span> <span
class=SpellE>động</span> <span class=SpellE>Việt</span> <st1:place w:st="on"><st1:country-region
 w:st="on">Nam</st1:country-region></st1:place>. <span class=SpellE>Nếu</span>
vi <span class=SpellE>phạm</span> <span class=SpellE>tôi</span> <span
class=SpellE>xin</span> <span class=SpellE>chịu</span> <span class=SpellE>trách</span>
<span class=SpellE>nhiệm</span> <span class=SpellE>trước</span> <span
class=SpellE>pháp</span> <span class=SpellE>luật</span>.<o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:27.0pt;text-indent:1.8pt;tab-stops:right dotted 5.5in'><i
style='mso-bidi-font-style:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
13.0pt;color:teal'>I commit to fully abide by the Vietnamese <span
class=SpellE>labour</span> legislation and will bear all responsibility for any
violation.<o:p></o:p></span></i></p>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;mso-yfti-tbllook:480;mso-padding-alt:0in 5.4pt 0in 5.4pt'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes'>
  <td width=295 valign=top style='width:221.4pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='tab-stops:right dotted 423.0pt'><span
  style='font-size:11.0pt;mso-bidi-font-size:13.0pt'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=295 valign=top style='width:221.4pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:right dotted 423.0pt'><span
  class=SpellE><span style='font-size:11.0pt;mso-bidi-font-size:13.0pt'>Người</span></span><span
  style='font-size:11.0pt;mso-bidi-font-size:13.0pt'> <span class=SpellE>đăng</span>
  <span class=SpellE>ký</span> <span class=SpellE>dự</span> <span class=SpellE>tuyển</span>
  <span class=SpellE>lao</span> <span class=SpellE>động</span><br>
  <i style='mso-bidi-font-style:normal'><span style='color:teal'>Applicant</span></i><br>
  (<span class=SpellE>Ký</span> <span class=SpellE>và</span> <span
  class=SpellE>ghi</span> <span class=SpellE>rõ</span> <span class=SpellE>họ</span>
  <span class=SpellE>tên</span>)<br>
  <span style='color:teal'>s<i style='mso-bidi-font-style:normal'>ignature and
  full name<o:p></o:p></i></span></span></p>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:right dotted 423.0pt'><i
  style='mso-bidi-font-style:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
  13.0pt;color:teal'><o:p>&nbsp;</o:p></span></i></p>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:right dotted 423.0pt'><i
  style='mso-bidi-font-style:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
  13.0pt;color:teal'><o:p>&nbsp;</o:p></span></i></p>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:right dotted 423.0pt'><i
  style='mso-bidi-font-style:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
  13.0pt;color:teal'><o:p>&nbsp;</o:p></span></i></p>
  <p class=MsoNormal align=center style='text-align:center;tab-stops:right dotted 423.0pt'><b
  style='mso-bidi-font-weight:normal'><i style='mso-bidi-font-style:normal'><span
  style='font-size:14.0pt;color:teal'><%=dt_emp.Rows[i]["c03"].ToString()%></span></i></b><b
  style='mso-bidi-font-weight:normal'><i style='mso-bidi-font-style:normal'><span
  style='font-size:14.0pt'><o:p></o:p></span></i></b></p>
  </td>
 </tr>
</table>

<%
     if (i == dt_emp.Rows.Count - 1)//nhan vien cuoi cung 
     {
         i = dt_emp.Rows.Count; 
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
