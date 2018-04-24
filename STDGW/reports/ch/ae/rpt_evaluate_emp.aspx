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
    string emp_pk, p_contract_type;
       
  emp_pk = Request["emp_pk"].ToString(); 
    
    
    string SQL = "select  a.full_name a0" + 
        "   ,a.emp_id a1" +
        ",(select CODE_NM from vhr_hr_code where id='HR0008' and code=a.POS_TYPE) as a2 " +
        "   ,d.org_nm a3" +
        "   ,decode(b.contract_type,'01',TO_CHAR (TO_DATE (b.BEGIN_PROBATION, 'yyyymmdd'), 'dd/mm/yyyy'),TO_CHAR (TO_DATE (b.begin_contract, 'yyyymmdd'), 'dd/mm/yyyy')) a4 " +
        "   ,decode(b.contract_type,'01', TO_CHAR (TO_DATE (b.end_probation, 'yyyymmdd'), 'dd/mm/yyyy'),TO_CHAR (TO_DATE (b.end_contract, 'yyyymmdd'), 'dd/mm/yyyy')) a5 " +
        "   ,ct_next.code_fnm a6" +
        "   ,decode(b.contract_type,'01',to_char(to_date(HR_F_GET_CONTRACT_DT(b.end_probation),'yyyymmdd'),'dd/mm/yyyy'), to_char(to_date(b.end_contract,'yyyymmdd') - nvl(g.num_3,-1),'dd/mm/yyyy'))  a7" +
        "   ,ct_next.code_nm a8" +
        "   ,decode(b.contract_type,'01',to_char(to_date(HR_F_GET_CONTRACT_DT(b.end_probation),'yyyymmdd'),'dd-MON-YY'), to_char(to_date(b.end_contract,'yyyymmdd') - nvl(g.num_3,-1),'dd-MON-YY'))  a9" +
        "   ,to_char(decode(nvl(b.begin_contract,0),0,b.PRO_SAL,b.BASIC_SAL),'99,999,999')    a10 " +
        "   ,decode(b.contract_type,'01',TO_CHAR (TO_DATE (b.end_probation, 'yyyymmdd'), 'dd/mm/yyyy'),TO_CHAR (TO_DATE (b.end_contract, 'yyyymmdd'), 'dd/mm/yyyy')) a11 " +
        "   ,decode(b.contract_type,'01',TO_CHAR (TO_DATE (b.end_probation, 'yyyymmdd'), 'dd-MON-yy'),TO_CHAR (TO_DATE (b.end_contract, 'yyyymmdd'), 'dd-MON-yy')) a12 " +
        "   ,h.TCO_BPPHOTO_PK a13" + 
        "   ,h.PARTNER_FNAME a14" + 
        "   ,h.ADDR2 a15" + 
        "   from thr_employee a, thr_labour_contract b, thr_work_group c, tco_org d,vhr_hr_code g,vhr_hr_code ct_next,tco_company h,tco_org e " +
        "   where a.del_if=0 and b.del_if=0 and c.del_if=0 and d.del_if=0  and e.del_if=0 and e.pk=d.p_pk and g.id='HR0001' and ct_next.id(+)='HR0001' and h.del_if=0 and a.tco_company_pk=h.pk " +
        "   and a.contracT_times=b.contract_times and g.code=b.contract_type and (nvl(g.num_2,0)+1)=ct_next.num_2(+)" +
        "   and a.pk=b.THR_EMPLOYEE_PK " +
        "   and a.thr_wg_pk=c.pk " +
        "   and a.tco_org_pk=d.pk " +
        "   and a.pk in (" + emp_pk + ")" +
        "   order by e.org_nm,d.org_nm,a.emp_id  " ;
    
        //Response.Write(SQL);
        //Response.End();
     
        DataTable dt_total = ESysLib.TableReadOpen(SQL);
        int irow;
        irow = dt_total.Rows.Count;

        
        if (irow == 0)
        Response.Write("There is no data");
        
       
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 11">
<meta name=Originator content="Microsoft Word 11">
<link rel=File-List href="rpt_evaluate_emp_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_evaluate_emp_files/editdata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<title>NOBLAND VIETNAM CO</title>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>truong</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>4</o:TotalTime>
  <o:Created>2012-07-04T06:49:00Z</o:Created>
  <o:LastSaved>2012-07-04T06:49:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>470</o:Words>
  <o:Characters>2679</o:Characters>
  <o:Lines>22</o:Lines>
  <o:Paragraphs>6</o:Paragraphs>
  <o:CharactersWithSpaces>3143</o:CharactersWithSpaces>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
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
	{font-family:VNI-Times;
	panose-1:0 0 0 0 0 0 0 0 0 0;
	mso-font-charset:0;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:3 0 0 0 1 0;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:1627421319 -2147483648 8 0 66047 0;}
@font-face
	{font-family:"Wingdings 2";
	panose-1:5 2 1 2 1 5 7 7 7 7;
	mso-font-charset:2;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:0 268435456 0 0 -2147483648 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:VNI-Times;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";}
h1
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.25in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:1;
	font-size:9.0pt;
	font-family:VNI-Times;
	font-weight:normal;
	font-style:italic;}
h2
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:2;
	font-size:9.0pt;
	font-family:VNI-Times;
	font-weight:normal;
	font-style:italic;}
h3
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:3;
	font-size:10.0pt;
	font-family:VNI-Times;
	font-weight:normal;
	font-style:italic;}
h4
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:4;
	font-size:10.0pt;
	font-family:VNI-Times;}
h5
	{margin:0in;
	margin-bottom:.0001pt;
	text-align:center;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:5;
	font-size:10.0pt;
	font-family:VNI-Times;}
p.MsoBodyText, li.MsoBodyText, div.MsoBodyText
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:VNI-Times;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:8.0pt;
	font-family:Tahoma;
	mso-fareast-font-family:"Times New Roman";}
span.spelle
	{mso-style-name:spelle;}
@page Section1
	{size:595.35pt 842.0pt;
	margin:.2in .5in .2in .5in;
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

<% 
     
     for (int i = 0; i < irow; i++) 
    {
       
    %> 
<div class=Section1>


<h4><span style='font-family:Arial'><%= dt_total.Rows[i]["a14"].ToString() %></span></h4>

<div style='border:none;border-bottom:solid gray 1.5pt;padding:0in 0in 1.0pt 0in'>

<p class=MsoNormal style='line-height:150%'><span style='font-size:9.0pt;
line-height:150%;font-family:Arial'><%= dt_total.Rows[i]["a15"].ToString() %></span></p>

</div>

<p class=MsoNormal><span style='font-family:Arial'>&nbsp;</span></p>

<p class=MsoNormal><span style='font-family:Arial'>&nbsp;</span></p>

<p class=MsoNormal align=center style='text-align:center'><b><i><span
style='font-size:20.0pt;font-family:"Times New Roman"'>&nbsp;</span></i></b><b><span
style='font-size:20.0pt;font-family:"Times New Roman"'>BẢNG ĐÁNH GIÁ NHÂN VIÊN</span></b></p>

<p class=MsoNormal align=center style='text-align:center'><i><span
style='font-family:Arial'>(EMPLOYEE ASSESSMENT FORM)</span></i></p>

<p class=MsoNormal align=center style='text-align:center'><span
style='font-family:Wingdings'></span><span style='font-family:Arial'> </span><span
style='font-family:Wingdings'>°</span><span style='font-family:Arial'> </span><span
style='font-family:Wingdings'></span></p>

<p class=MsoNormal align=center style='text-align:center'><span
style='font-family:Arial'>&nbsp;</span></p>

<p class=MsoNormal align=center style='text-align:center'><span
style='font-family:Arial'>&nbsp;</span></p>

<p class=MsoNormal style='line-height:200%'><span style='font-size:10.0pt;
line-height:200%;font-family:Arial'>Tên <i>(Employee’s name):</i> <b><%= dt_total.Rows[i]["a0"].ToString() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>MSNV<i>
(Emp.Code):&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><%= dt_total.Rows[i]["a1"].ToString() %></b></i></span></p>

<p class=MsoNormal style='line-height:200%'><span lang=FR style='font-size:
10.0pt;line-height:200%;font-family:Arial;mso-ansi-language:FR'>Chức vụ<i>(Position)&nbsp;:
<b><%= dt_total.Rows[i]["a2"].ToString() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</b>Bộ</i> phận<i> (Dept./Section)&nbsp;: <b><%= dt_total.Rows[i]["a3"].ToString() %></b></i></span></p>

<p class=MsoNormal style='line-height:200%'><span class=spelle><span
style='font-size:10.0pt;line-height:200%;font-family:Arial'>Thời</span></span><span
style='font-size:10.0pt;line-height:200%;font-family:Arial'> <span
class=spelle>gian</span> <span class=spelle>ký</span> <span class=spelle>hợp</span>
<span class=spelle>đồng</span> <i>(Contract period</i>)<i>:</i> <span
class=spelle>Từ</span><i> (From):</i> <b><%= dt_total.Rows[i]["a4"].ToString() %></b></span><span
style='font-size:8.0pt;line-height:200%;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><span class=spelle><i><span style='font-size:10.0pt;line-height:200%;
font-family:Arial'>Đến</span></i></span><i><span style='font-size:10.0pt;
line-height:200%;font-family:Arial'> (To)</span></i><span style='font-size:
10.0pt;line-height:200%;font-family:Arial'>: <b><%= dt_total.Rows[i]["a5"].ToString() %></b></span></p>

<p class=MsoNormal style='margin-left:.5in'><span style='font-size:13.0pt;
font-family:"Wingdings 2"'>£</span><span style='font-size:13.0pt;font-family:
Arial'> </span><span style='font-size:10.0pt;font-family:Arial'>Đánh giá để
ký hợp đồng lao động sau thời gian thử việc.</span></p>

<p class=MsoNormal style='margin-left:.5in;text-indent:.25in;line-height:200%'><i><span
style='font-size:10.0pt;line-height:200%;font-family:"Times New Roman"'>Checking
performance appraisal for first labor contract.</span></i></p>

<p class=MsoNormal style='margin-left:.5in'><span style='font-size:13.0pt;
font-family:"Wingdings 2"'>£</span><span style='font-size:13.0pt;font-family:
Arial'> </span><span style='font-size:10.0pt;font-family:Arial'>Đánh giá để
ký hợp đồng lao động kế tiếp.</span></p>

<p class=MsoNormal style='margin-left:.5in;text-indent:.25in'><i><span
style='font-size:10.0pt;font-family:"Times New Roman"'>Checking performance
appraisal for nex labor contract.</span></i></p>

<p class=MsoNormal><span style='font-size:8.0pt;font-family:Arial'>&nbsp;</span></p>

<p class=MsoNormal style='margin-left:.25in;text-indent:-.25in'><b><i><span
style='font-size:11.0pt;font-family:Arial'>A.</span></i></b><b><i><span
style='font-size:7.0pt;font-family:"Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp; </span></i></b><b><u><span
style='font-size:11.0pt;font-family:Arial'>ĐÁNH GIÁ KHẢ NĂNG - </span></u></b><i><u><span
style='font-size:11.0pt;font-family:Arial'>PERFORMANCE APPRAISAL</span></u></i><b><i><span
style='font-size:11.0pt;font-family:Arial'>:</span></i></b><b><i><span
style='font-size:10.0pt;font-family:Arial'> </span></i></b><i><span
style='font-size:10.0pt;font-family:Arial'>(Please tick </span></i><i><span
style='font-size:10.0pt;font-family:Wingdings'>ü</span></i><i><span
style='font-size:10.0pt;font-family:Arial'> if it is appropriated).</span></i></p>

<p class=MsoNormal><b><span style='font-size:8.0pt;font-family:Arial'>&nbsp;</span></b></p>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0 width=710
 style='width:532.15pt;margin-left:9.9pt;border-collapse:collapse;mso-padding-alt:
 0in 0in 0in 0in'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes'>
  <td width=277 style='width:207.55pt;border:solid windowtext 1.0pt;padding:
  0in 5.4pt 0in 5.4pt'>
  <h5><span style='font-family:Arial'>Tiêu chuẩn</span></h5>
  <h5><i><span style='font-family:Arial;font-weight:normal'>(Criteria</span></i><span
  style='font-family:Arial;font-weight:normal'>)</span></h5>
  </td>
  <td width=93 style='width:69.45pt;border:solid windowtext 1.0pt;border-left:
  none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>Yếu</span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><i><span
  style='font-size:10.0pt;font-family:Arial'>(Poor)</span></i></p>
  </td>
  <td width=123 style='width:92.15pt;border:solid windowtext 1.0pt;border-left:
  none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>Khá tốt</span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><i><span
  style='font-size:10.0pt;font-family:Arial'>(</span></i><span
  style='font-size:10.0pt;font-family:Arial'>Fair)</span></p>
  </td>
  <td width=113 style='width:85.05pt;border:solid windowtext 1.0pt;border-left:
  none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>Tốt </span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><i><span
  style='font-size:10.0pt;font-family:Arial'>(Good)</span></i></p>
  </td>
  <td width=104 style='width:77.95pt;border:solid windowtext 1.0pt;border-left:
  none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>Xuất sắc</span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><i><span
  style='font-size:10.0pt;font-family:Arial'>(Excellent)</span></i></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1;height:.4in'>
  <td width=277 style='width:207.55pt;border:solid windowtext 1.0pt;border-top:
  none;padding:0in 5.4pt 0in 5.4pt;height:.4in'>
  <p class=MsoNormal style='margin-left:.25in;text-indent:-.25in'><b><span
  style='font-size:10.0pt;font-family:Arial'>1.</span></b><b><span
  style='font-size:7.0pt;font-family:"Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></b><b><span style='font-size:10.0pt;font-family:Arial'>Năng lực tổng
  quát </span></b></p>
  <h1><span style='font-size:10.0pt;font-family:Arial'>(General ability)</span></h1>
  </td>
  <td width=93 valign=top style='width:69.45pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:.4in'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:"Wingdings 2"'>£</span></p>
  </td>
  <td width=123 valign=top style='width:92.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:.4in'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:"Wingdings 2"'>£</span></p>
  </td>
  <td width=113 valign=top style='width:85.05pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:.4in'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:"Wingdings 2"'>£</span></p>
  </td>
  <td width=104 valign=top style='width:77.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:.4in'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:"Wingdings 2"'>£</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2;height:.4in'>
  <td width=277 style='width:207.55pt;border:solid windowtext 1.0pt;border-top:
  none;padding:0in 5.4pt 0in 5.4pt;height:.4in'>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Arial'>2.&nbsp;&nbsp;
  Kỷ năng &amp; kiến thức công việc </span></b></p>
  <h1><span style='font-size:10.0pt;font-family:Arial'>(Job skill &amp;
  knowledge)</span></h1>
  </td>
  <td width=93 valign=top style='width:69.45pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:.4in'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:"Wingdings 2"'>£</span></p>
  </td>
  <td width=123 valign=top style='width:92.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:.4in'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:"Wingdings 2"'>£</span></p>
  </td>
  <td width=113 valign=top style='width:85.05pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:.4in'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:"Wingdings 2"'>£</span></p>
  </td>
  <td width=104 valign=top style='width:77.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:.4in'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:"Wingdings 2"'>£</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3;height:.4in'>
  <td width=277 style='width:207.55pt;border:solid windowtext 1.0pt;border-top:
  none;padding:0in 5.4pt 0in 5.4pt;height:.4in'>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Arial'>3.&nbsp;&nbsp;
  Thái độ - hành vi kỷ luật, chuyên cần</span></b></p>
  <h2><span style='font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  (Work attitude, discipline, attendance)</span></h2>
  </td>
  <td width=93 valign=top style='width:69.45pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:.4in'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:"Wingdings 2"'>£</span></p>
  </td>
  <td width=123 valign=top style='width:92.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:.4in'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:"Wingdings 2"'>£</span></p>
  </td>
  <td width=113 valign=top style='width:85.05pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:.4in'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:"Wingdings 2"'>£</span></p>
  </td>
  <td width=104 valign=top style='width:77.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:.4in'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:"Wingdings 2"'>£</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:4;mso-yfti-lastrow:yes;height:.4in'>
  <td width=277 style='width:207.55pt;border:solid windowtext 1.0pt;border-top:
  none;padding:0in 5.4pt 0in 5.4pt;height:.4in'>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Arial'>4.&nbsp;&nbsp;
  Quan hệ đồng nghiệp </span></b></p>
  <p class=MsoNormal><i><span style='font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  (Get along with the others)</span></i></p>
  </td>
  <td width=93 valign=top style='width:69.45pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:.4in'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:"Wingdings 2"'>£</span></p>
  </td>
  <td width=123 valign=top style='width:92.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:.4in'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:"Wingdings 2"'>£</span></p>
  </td>
  <td width=113 valign=top style='width:85.05pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:.4in'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:"Wingdings 2"'>£</span></p>
  </td>
  <td width=104 valign=top style='width:77.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:.4in'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:"Wingdings 2"'>£</span></p>
  </td>
 </tr>
</table>

<p class=MsoNormal><b><span style='font-size:8.0pt;font-family:Arial'>&nbsp;</span></b></p>

<p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>* Nếu một
trong 4 tiêu chuẩn trên bị đánh giá loại yếu, thì sẽ không tiếp tục
ký kết hợp đồng lao động.</span></p>

<p class=MsoNormal><i><span style='font-size:10.0pt;font-family:"Times New Roman"'>(If
you have one poor criteria, you could not be continue working in company with
new labor contract)</span></i></p>

<p class=MsoNormal style='line-height:150%'><b><span style='font-size:10.0pt;
line-height:150%;font-family:Arial'>B. <u>ĐỀ NGHỊ BỞI GIÁM SÁT/ T. BỘ PHẬN - </u></span></b><i><u><span
style='font-size:10.0pt;line-height:150%;font-family:Arial'>RECOMMENDATION BY
SUPERVISOR/HEAD DEPARTMENT</span></u></i><b><u><span style='font-size:10.0pt;
line-height:150%;font-family:Arial'>.</span></u></b><b><span style='font-size:
10.0pt;line-height:150%;font-family:Arial'> </span></b><span style='font-size:
10.0pt;line-height:150%;font-family:Arial'>( </span><span style='font-size:
13.0pt;line-height:150%;font-family:"Wingdings 2"'>T</span><span
style='font-size:13.0pt;line-height:150%;font-family:Arial'>)</span></p>

<p class=MsoNormal style='margin-left:.5in;line-height:150%'><span
style='font-size:13.0pt;line-height:150%;font-family:"Wingdings 2"'>£</span><span
style='font-size:10.0pt;line-height:150%;font-family:Arial'> <b>Tiếp tục
được tuyển dụng</b> (be recruited):</span></p>

<p class=MsoNormal style='margin-left:1.0in'><span style='font-family:Symbol'>·</span><span
style='font-size:7.0pt;font-family:"Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><span style='font-size:10.0pt;font-family:Arial'>Ký hợp đồng lao
động <b><%= dt_total.Rows[i]["a6"].ToString() %></b> bắt đầu từ ngày <b><%= dt_total.Rows[i]["a7"].ToString() %></b></span></p>

<p class=MsoNormal style='margin-left:1.25in'><i><span style='font-size:10.0pt;
font-family:"Times New Roman"'>Labor contract is <%= dt_total.Rows[i]["a8"].ToString() %> effective
from <%= dt_total.Rows[i]["a9"].ToString() %></span></i></p>


<p class=MsoNormal style='margin-left:.5in;text-align:justify;line-height:150%'><span
style='font-size:14.0pt;line-height:150%;font-family:"Wingdings 2"'>£</span><span
style='font-size:10.0pt;line-height:150%;font-family:Arial'> Ban giám đốc và
trưởng bộ phận xác nhận qua bảng đánh giá như trên khả năng của anh
(chị) không thích hợp với công việc hiện tại vì thế công ty sẽ <b>không
tiếp tục ký hợp đồng lao động</b>. Ngày làm việc cuối cùng của anh
(chị) tại công ty là ngày&nbsp; <b><%= dt_total.Rows[i]["a11"].ToString() %></b>, vui lòng liên hệ bộ
phận Hành Chính Nhân Sự để nhận quyết định và làm thủ tục thôi
việc. </span><i><span style='font-size:10.0pt;line-height:150%;font-family:
"Times New Roman"'>(BOD and head department confirmed your performance not
suitable for this job, so that company won’t sign labor contract with you, last
day working in company is <%= dt_total.Rows[i]["a12"].ToString() %>, pls contact with Admin – Hr dept. for
receiving decision and complete resignation procedure).</span></i></p>

<p class=MsoNormal><b><span style='font-size:8.0pt;font-family:Arial'>&nbsp;</span></b></p>


<p class=MsoBodyText><b><span style='font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span class=spelle>Xác</span> <span class=spelle>nhận</span> <span
class=spelle>của</span> <span class=spelle>nhân</span> <span class=spelle>viên</span><span
style='mso-tab-count:1'> </span><span style='mso-spacerun:yes'>        </span><span
class=spelle>Người</span> <span class=spelle>đánh</span> <span class=spelle>giá</span>&nbsp;&nbsp;&nbsp;&nbsp;<span
style='mso-spacerun:yes'>       </span><span class=spelle>Giám</span> <span
class=spelle>đốc</span> <span class=spelle>xưởng</span>&nbsp;<span
style='mso-spacerun:yes'>                 </span><span class=spelle>Chấp</span>
<span class=spelle>thuận</span> <span class=spelle>của</span> TGĐ</span></b></p>

<h3><span style='font-family:Arial'>&nbsp;&nbsp;&nbsp; (Employee’s acknowledgement)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='mso-spacerun:yes'> 
</span>(Appraiser)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
style='mso-spacerun:yes'>  </span>(Factory Manager)<span
style='mso-spacerun:yes'>          </span>(Approved by General Director)</span></h3>

<p class=MsoNormal><i><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></i></p>

<p class=MsoNormal><i><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></i></p>

<p class=MsoNormal><i><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></i></p>

<p class=MsoNormal><i><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></i></p>

<p class=MsoNormal><i><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></i></p>

<p class=MsoNormal><i><span style='font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
--------------------------&nbsp;<span style='mso-spacerun:yes'> 
</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='mso-spacerun:yes'> 
</span>------------------------------&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;------------------------------<span
style='mso-spacerun:yes'>              </span>----------------------------</span></i></p>

<p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span class=spelle>Ngày</span> <i>(Date):</i> __ / __/ ___<span
style='mso-spacerun:yes'>    </span>&nbsp;<span class=spelle>Ngày</span> <i>(Date):</i>
__ / __/ ___<i>&nbsp; &nbsp;</i><span class=spelle>Ngày</span> <i>(Date):</i>
__ / __/ ___<i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </i><span
class=spelle>Ngày</span> <span class=grame><i>( Date</i></span><i>):</i> __ /
__/ ___</span></p>

</div>
<%
     if (i == irow - 1)//nhan vien cuoi cung 
     { 
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
</body>

</html>
