<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/msword";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:w="urn:schemas-microsoft-com:office:word"
xmlns="http://www.w3.org/TR/REC-html40">

<%
    string emp_pk;
    
    emp_pk       = Request["emp_pk"].ToString();
    string SQL = " select a.pk  " 
        + ",a.FULL_NAME  "
        + ",(select PARTNER_LNAME from tco_company p where p.del_if=0 and p.pk=c.tco_company_pk) as tencongty "
        + ",to_char(to_date(a.BEGIN_CONTRACT,'yyyymmdd'),'mm/yyyy') as tuthang "
        + ",(select v.code_fnm from vhr_hr_code v where v.id='HR0049' and v.code='11') as noicongtac "
        + "from thr_employee a,thr_group b,tco_dept c "
        + "where a.del_if=0 and b.del_if=0 and c.del_if=0 and a.thr_group_pk=b.pk and a.tco_dept_pk=c.pk "
       + "and a.pk in (" + emp_pk + ") " ;
        
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
    //getting information of Employeer
    SQL
    = "select max(decode(code,'01',code_fnm,'')) ,max(decode(code,'04',code_fnm,'')) " +
        "from vhr_hr_code " +
        "where id='HR0048' group by id  ";
    DataTable dt_name = ESysLib.TableReadOpen(SQL);
    int irow_name;
    irow_name = dt_name.Rows.Count;
   
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 11">
<meta name=Originator content="Microsoft Word 11">
<link rel=File-List href="rpt_01_TBH_Sau_files/filelist.xml">
<title>B</title>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>huynhtruong</o:Author>
  <o:LastAuthor>User</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>16</o:TotalTime>
  <o:Created>2008-07-27T01:38:00Z</o:Created>
  <o:LastSaved>2008-07-27T01:38:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>146</o:Words>
  <o:Characters>835</o:Characters>
  <o:Lines>6</o:Lines>
  <o:Paragraphs>1</o:Paragraphs>
  <o:CharactersWithSpaces>980</o:CharactersWithSpaces>
  <o:Version>11.5606</o:Version>
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
</xml><![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"\.VnTime";
	mso-font-alt:"Courier New";
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:3 0 0 0 1 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:14.0pt;
	mso-bidi-font-size:12.0pt;
	font-family:"\.VnTime";
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	mso-ansi-language:VI;
	mso-fareast-language:VI;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:28.35pt 28.35pt 27.0pt 27.25pt;
	mso-header-margin:35.45pt;
	mso-footer-margin:35.45pt;
	mso-page-numbers:17;
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
<% 
     
     for (int i = 0; i < irow; i++) 
     {
        
        
    
    %> 

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><u><span
lang=PT-BR style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'>C. XÁC NHẬN CỦA NGƯỜI SỬ DỤNG LAO ĐỘNG:<o:p></o:p></span></u></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=PT-BR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'>Cơ quan, đơn vị, tổ chức <%=dt_total.Rows[i][2].ToString() %> sau khi kiểm tra, đối chiếu hồ sơ gốc của
Ông (Bà) <%=dt_total.Rows[i][1].ToString() %><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=PT-BR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'>Xác nhận các nội dung kê khai trên là hoàn toàn đúng sự thực.<o:p></o:p></span></p>

<p class=MsoNormal align=center style='margin-top:6.0pt;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><span
class=SpellE><span class=GramE><i><span style='mso-bidi-font-size:14.0pt;
font-family:"Times New Roman";mso-ansi-language:EN-US'><%=dt_total.Rows[i][4].ToString() %></span></i></span></span><i><span
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
EN-US'>, <span class=SpellE>ngày</span> 01 <span style='mso-spacerun:yes'> 
</span><span class=SpellE>tháng</span> <%if (dt_total.Rows[i][3].ToString()!="") 
                                        Response.Write(dt_total.Rows[i][3].ToString().Substring(0,2));
                                    %><span style='mso-spacerun:yes'> 
</span><span class=SpellE>năm</span> <%if (dt_total.Rows[i][3].ToString()!="") 
                                        Response.Write(dt_total.Rows[i][3].ToString().Substring(3,4));
                                    %><o:p></o:p></span></i></p>

<p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><span
class=SpellE><b><span style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:EN-US'>Người</span></b></span><b><span style='mso-bidi-font-size:
14.0pt;font-family:"Times New Roman";mso-ansi-language:EN-US'> <span
class=SpellE>sử</span> <span class=SpellE>dụng</span> <span class=SpellE><span
class=GramE>lao</span></span> <span class=SpellE>động</span><o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><span
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
EN-US'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><span
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
EN-US'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><span
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
EN-US'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><span
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
EN-US'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><span
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
EN-US'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><b><span
style='font-size:15.0pt;font-family:"Times New Roman";mso-ansi-language:EN-US'>
<%if (irow_name>0)
     Response.Write(dt_name.Rows[0][0].ToString()); %><o:p></o:p></span></b></p>

<p class=MsoNormal align=center style='margin-top:0in;margin-right:5.6pt;
margin-bottom:0in;margin-left:10.9pt;margin-bottom:.0001pt;text-align:center'><b><span
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
EN-US'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><b><u><span
lang=PT-BR style='font-size:12.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'>D. XÁC NHẬN CỦA CƠ QUAN BẢO HIỂM XÃ HỘI:<o:p></o:p></span></u></b></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify;text-indent:27.25pt'><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'>Bảo hiểm xã hội tỉnh <%=dt_total.Rows[i][4].ToString() %> sau khi kiểm tra, đối
chiếu với hồ sơ gốc của cá nhân Ông (Bà) <%=dt_total.Rows[i][1].ToString() %> xác nhận các nội dung kê
khai trên là đúng.<o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;tab-stops:70.85pt 261.6pt'><b><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'><span style='mso-tab-count:1'>                </span>Cán
bộ thẩm định<span style='mso-tab-count:1'>                      </span></span></b><i><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'>............, ngày ....... tháng ....... năm 20.....<o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:5.6pt;margin-bottom:
0in;margin-left:10.9pt;margin-bottom:.0001pt;tab-stops:70.85pt 332.45pt'><b><span
lang=PT-BR style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";
mso-ansi-language:PT-BR'><span style='mso-tab-count:2'>                                                                                      </span>Giám
đốc BHXH</span></b><i><span lang=PT-BR style='mso-bidi-font-size:14.0pt;
font-family:"Times New Roman";mso-ansi-language:PT-BR'><o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=PT-BR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:10.9pt;margin-bottom:.0001pt;text-align:justify'><i><u><span
lang=PT-BR style='font-size:9.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><o:p><span style='text-decoration:none'>&nbsp;</span></o:p></span></u></i></p>

<p class=MsoNormal style='margin-right:5.6pt;text-align:justify'><span
lang=PT-BR style='mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-right:5.6pt;text-align:justify'><span
lang=PT-BR style='mso-ansi-language:PT-BR'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-top:0in;margin-right:5.6pt;margin-bottom:0in;
margin-left:46.9pt;margin-bottom:.0001pt;text-align:justify'><span lang=PT-BR
style='mso-bidi-font-size:14.0pt;font-family:"Times New Roman";mso-ansi-language:
PT-BR'><span style='mso-spacerun:yes'>     </span><%if (irow_name>0)
     Response.Write(dt_name.Rows[0][1].ToString()); %><o:p></o:p></span></p>

<%  if (i==irow-1) 
    {%>
<p class=MsoNormal style='margin-right:5.6pt;text-align:justify'><span
lang=PT-BR style='mso-ansi-language:PT-BR;mso-special-character:line-break;
page-break-before:always'><o:p>&nbsp;</o:p></span></p>
<%  } 
    else
    {    %>
<b><span lang=PT-BR style='font-size:12.0pt;font-family:"Times New Roman";
mso-fareast-font-family:"Times New Roman";mso-ansi-language:PT-BR;mso-fareast-language:
VI;mso-bidi-language:AR-SA'><br clear=all style='page-break-before:always'>
</span></b>
<%  } %>
<%} %>
</div>

</body>

</html>
