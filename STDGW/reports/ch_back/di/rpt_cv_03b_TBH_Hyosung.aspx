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
    = " select a.pk   " +
        ",(select v.code_nm from vhr_hr_code v where v.id='HR0132' and v.code=b.content)  col1  " +
        ",(select v.char_1 from vhr_hr_code v where v.id='HR0132' and v.code=b.content )  col2  " +
        ",a.FULL_NAME col3  " +
        ",b.old  col4  " +
        ",b.new  col5  " +
        ",to_char(to_date(b.modify_dt,'yyyymmdd'),'dd') col6  " +
        ",to_char(to_date(b.modify_dt,'yyyymmdd'),'mm') col7  " +
        ",to_char(to_date(b.modify_dt,'yyyymmdd'),'yyyy') col8 " +
        ",(select to_char(to_date(nvl(max(i.thang_bc),a.social_dt),'yyyymm'),'mm/yyyy') from thr_insurance_manage i where i.del_if=0 and i.thr_emp_pk = a.pk and i.loai_bh = '01')  col9 " +
        "from thr_employee a,thr_ins_modify b  " +
        "where a.del_if=0 and b.del_if=0 and b.thr_emp_pk =a.pk  " +
        "and b.pk in (" + emp_pk + ") " +
        "order by a.pk " ;
        
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
<link rel=File-List href="rpt_cv_03b_TBH_HS_files/filelist.xml">
<title>Công ty  TNHH </title>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="country-region"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="place"/>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Thuy Lan</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>14</o:TotalTime>
  <o:LastPrinted>2011-10-26T06:48:00Z</o:LastPrinted>
  <o:Created>2011-11-08T02:50:00Z</o:Created>
  <o:LastSaved>2011-11-08T02:50:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>250</o:Words>
  <o:Characters>1429</o:Characters>
  <o:Company>HP Compaq</o:Company>
  <o:Lines>11</o:Lines>
  <o:Paragraphs>3</o:Paragraphs>
  <o:CharactersWithSpaces>1676</o:CharactersWithSpaces>
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
	{font-family:PMingLiU;
	panose-1:2 2 5 0 0 0 0 0 0 0;
	mso-font-alt:\65B0\7D30\660E\9AD4;
	mso-font-charset:136;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-1610611969 684719354 22 0 1048577 0;}
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
	{font-family:"\@PMingLiU";
	panose-1:2 2 5 0 0 0 0 0 0 0;
	mso-font-charset:136;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-1610611969 684719354 22 0 1048577 0;}
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
h3
	{mso-style-link:" Char Char1";
	mso-style-next:"Normal Indent";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:3;
	font-size:12.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:VNI-Times;
	mso-fareast-font-family:PMingLiU;
	font-weight:normal;}
p.MsoNormalIndent, li.MsoNormalIndent, div.MsoNormalIndent
	{mso-style-noshow:yes;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:VNI-Times;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-noshow:yes;
	mso-style-link:" Char Char";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:8.0pt;
	font-family:Tahoma;
	mso-fareast-font-family:"Times New Roman";}
span.CharChar1
	{mso-style-name:" Char Char1";
	mso-style-locked:yes;
	mso-style-parent:"";
	mso-style-link:"Heading 3";
	mso-ansi-font-size:12.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:VNI-Times;
	mso-ascii-font-family:VNI-Times;
	mso-fareast-font-family:PMingLiU;
	mso-hansi-font-family:VNI-Times;
	mso-bidi-font-family:"Times New Roman";}
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
	mso-fareast-font-family:"Times New Roman";
	mso-hansi-font-family:Tahoma;
	mso-bidi-font-family:Tahoma;}
@page Section1
	{size:595.45pt 841.7pt;
	margin:1.0in 1.0in 26.65pt 1.0in;
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
<% 
    Boolean flag = true;
    string emp_type_old, emp_type_new;
    for (int i = 0; i < irow; i++) 
    {
       // emp_type_old = dt_total.Rows[i][0].ToString();
        
    %>
<h3><b><span style='font-size:13.0pt;mso-bidi-font-size:10.0pt;font-family:
"Times New Roman"'>Công ty<span style='mso-spacerun:yes'>  </span>TNHH</span></b><span
style='font-size:13.0pt;mso-bidi-font-size:10.0pt;font-family:"Times New Roman"'>
<span style='mso-tab-count:2'>                  </span><span
style='mso-spacerun:yes'>    </span><b>C&#7896;NG HOÀ – XÃ H&#7896;I- CH&#7910;
NGH&#296;A- VI&#7878;T NAM</b> <b>Hyosung Vi&#7879;t Nam</b><span
style='mso-tab-count:4'>                                                </span>&#272;&#7897;c
l&#7853;p - T&#7921; do- H&#7841;nh Phúc<o:p></o:p></span></h3>

<p class=MsoNormal><i style='mso-bidi-font-style:normal'><span
style='font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:"Times New Roman"'><span
style='mso-tab-count:7'>                                                                                    </span><span
style='mso-spacerun:yes'>      </span>---***---<o:p></o:p></span></i></p>

<p class=MsoNormal><i style='mso-bidi-font-style:normal'><span
style='font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:"Times New Roman"'>CV
s&#7889; : 26/HOS-2011<o:p></o:p></span></i></p>

<p class=MsoNormal style='line-height:150%'><i style='mso-bidi-font-style:normal'><span
style='font-size:13.0pt;mso-bidi-font-size:12.0pt;line-height:150%;font-family:
"Times New Roman"'><span style='mso-spacerun:yes'> </span>(V/v: &#272;i&#7873;u
ch&#7881;nh 
<%
    string st = dt_total.Rows[i][2].ToString(); ;
    for (int k = i+1; k < irow; k++)
    {
        if (dt_total.Rows[i][0].ToString() == dt_total.Rows[k][0].ToString())
        {
            st += ", " + dt_total.Rows[k][2].ToString();
            //i = k+1;
        }
        else
        {
            k = irow;
        }
    } 
%>
       <%= st %>     )<o:p></o:p></span></i></p>

<p class=MsoNormal><span style='font-size:13.0pt;mso-bidi-font-size:12.0pt;
font-family:"Times New Roman"'><span style='mso-tab-count:5'>                                                            </span><span
style='mso-spacerun:yes'>               </span><span
style='mso-spacerun:yes'> </span>Nh&#417;n Tr&#7841;ch, ngày<span
style='mso-spacerun:yes'>  </span><%= dt_total.Rows[i][6].ToString() %> tháng <%= dt_total.Rows[i][7].ToString() %> n&#259;m <%= dt_total.Rows[i][8].ToString() %><i style='mso-bidi-font-style:
normal'><o:p></o:p></i></span></p>

<p class=MsoNormal><span style='font-size:13.0pt;mso-bidi-font-size:12.0pt;
font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='line-height:150%'><i style='mso-bidi-font-style:normal'><span
style='font-size:13.0pt;mso-bidi-font-size:12.0pt;line-height:150%;font-family:
"Times New Roman"'><span style='mso-tab-count:1'>            </span><u>Kính
g&#7917;i</u></span></i><b style='mso-bidi-font-weight:normal'><span
style='font-size:13.0pt;mso-bidi-font-size:12.0pt;line-height:150%;font-family:
"Times New Roman"'> :<span style='mso-spacerun:yes'>    </span>- </span></b><b
style='mso-bidi-font-weight:normal'><span style='font-size:15.0pt;mso-bidi-font-size:
14.0pt;line-height:150%;font-family:"Times New Roman"'>B&#7842;O HI&#7874;M XÃ
H&#7896;I HUY&#7878;N NH&#416;N TR&#7840;CH<o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-left:2.0in;text-indent:.5in;line-height:150%'><i
style='mso-bidi-font-style:normal'><span style='font-size:13.0pt;mso-bidi-font-size:
12.0pt;line-height:150%;font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></i></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify;text-indent:
27.0pt'><span style='font-family:"Times New Roman"'>Công ty TNHH HYSOUNG là
&#273;&#417;n v&#7883; s&#7843;n xu&#7845;t và xu&#7845;t kh&#7849;u m&#7863;t
hàng s</span><span lang=VI style='font-family:"Times New Roman";mso-ansi-language:
VI'>&#7907;i</span><span style='font-family:"Times New Roman"'> và,
&#273;&#432;&#7907;c thành l&#7853;p theo gi&#7845;y phép &#273;&#7847;u
t&#432; s&#7889; gi&#7845;y phép &#273;&#7847;u t&#432; s&#7889;<span
style='mso-spacerun:yes'>  </span>: 472043000143/GP-KCN-&#272;N do Ban
qu&#7843;n lý Khu công nghi&#7879;p &#272;&#7891;ng Nai c&#7845;p : 22/05/2007,
tr&#7909; s&#7903; và nhà máy &#273;&#7863;t t&#7841;i Khu Công Nghi&#7879;p
Nh&#417;n Tr&#7841;ch 5, Huy&#7879;n Nh&#417;n Tr&#7841;ch, T&#7881;nh
&#272;&#7891;ng Nai.</span><span style='mso-bidi-font-weight:bold'> <o:p></o:p></span></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify;text-indent:
27.0pt'><span style='font-family:"Times New Roman";mso-bidi-font-weight:bold'>
<% if (dt_total.Rows[i][9].ToString() != "")
   {
       %>

Vào
tháng <%= dt_total.Rows[i][9].ToString()%> , công
 <%}
   else
   { 
 %>
    Công
 <%  
   }     
         %> ty chúng tôi có làm m&#7851;u 02a &#273;&#7875; t&#259;ng
m&#7899;i cho ng&#432;&#7901;i lao &#273;&#7897;ng, trong &#273;ó có Anh/chị
<%= dt_total.Rows[i][3].ToString() %> và c&#417; quan BHXH huy&#7879;n Nh&#417;n Tr&#7841;ch
&#273;ã c&#7845;p s&#7893; BHXH cho Anh/chị <%= dt_total.Rows[i][3].ToString() %><span
style='mso-spacerun:yes'>  </span>nh&#432;ng 
<%
    string st1 = dt_total.Rows[i][2].ToString(); ;
    for (int k = i+1; k < irow; k++)
    {
        if (dt_total.Rows[i][0].ToString() == dt_total.Rows[k][0].ToString())
        {
            st1 += ", " + dt_total.Rows[k][2].ToString();
            //i = k+1;
        }
        else
        {
            k = irow;
        }
    } 
%>
<%= st1 %>
trong s&#7893; BHXH b&#7883; sai<span
style='mso-spacerun:yes'>  </span>là do nhân s&#7921; bên công ty &#273;ã
nh&#7853;p sai thông tin cá nhân c&#7911;a Anh/chị <%= dt_total.Rows[i][3].ToString() %> cho nên khi<span
style='mso-spacerun:yes'>  </span>làm m&#7851;u 02 &#273;&#7875; tham gia BHXH
&#273;ã có s&#7921; sai sót<span style='mso-spacerun:yes'>  </span>cho Anh/chị <%= dt_total.Rows[i][3].ToString() %>
 c&#7909; th&#7875; nh&#432; sau:<o:p></o:p></span></p>

            <p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify;text-indent:
            27.0pt'><span style='font-family:"Times New Roman";mso-bidi-font-weight:bold'>
            <%=dt_total.Rows[i][2].ToString() %><span style='mso-spacerun:yes'>  </span>sai:<span style='mso-tab-count:2'> </span>
            <%=dt_total.Rows[i][4].ToString() %><o:p></o:p></span></p>

<%
    
    for (int k = i; k < irow-1; k++)
    {
       
        if (dt_total.Rows[k][0].ToString() == dt_total.Rows[k + 1][0].ToString())
        {
            
 %>
            <p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify;text-indent:
            27.0pt'><span style='font-family:"Times New Roman";mso-bidi-font-weight:bold'>
            <%=dt_total.Rows[k+1][2].ToString() %><span style='mso-spacerun:yes'>  </span>sai:<span style='mso-tab-count:2'> </span>
            <%=dt_total.Rows[k+1][4].ToString() %><o:p></o:p></span></p>
 <%         
            
        }
        else
        {
            k = irow;
        }
    } 
%>


<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify;text-indent:
27.0pt'><span style='font-family:"Times New Roman";mso-bidi-font-weight:bold'>
<%=dt_total.Rows[i][2].ToString() %><span style='mso-spacerun:yes'>  </span>&#273;úng :<span style='mso-tab-count:
1'>        </span>
<%=dt_total.Rows[i][5].ToString() %><span style='mso-tab-count:
1'>   </span><o:p></o:p></span></p>

<%
    
    for (int k = i; k < irow-1; k++)
    {
       
        if (dt_total.Rows[k][0].ToString() == dt_total.Rows[k + 1][0].ToString())
        {
            
 %>
            <p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify;text-indent:
            27.0pt'><span style='font-family:"Times New Roman";mso-bidi-font-weight:bold'>
            <%=dt_total.Rows[k+1][2].ToString() %><span style='mso-spacerun:yes'>  </span>&#273;úng :<span style='mso-tab-count:
            1'>        </span>
            <%=dt_total.Rows[k+1][5].ToString() %><span style='mso-tab-count:
            1'>   </span><o:p></o:p></span></p>
 <%         
           
        }
        else
        {
            k = irow;
        }
    } 
%>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify;text-indent:
27.0pt'><span style='font-family:"Times New Roman";mso-bidi-font-weight:bold'>Nay
công ty chúng tôi làm công v&#259;n này xin &#273;i&#7873;u ch&#7881;nh
l&#7841;i 
<%
    string st2 = dt_total.Rows[i][2].ToString(); ;
    for (int k = i+1; k < irow; k++)
    {
        if (dt_total.Rows[i][0].ToString() == dt_total.Rows[k][0].ToString())
        {
            st2 += ", " + dt_total.Rows[k][2].ToString();
            i = k;
        }
        else
        {
            k = irow;
        }
    } 
%>
<%= st2 %> 
cho Anh/chị <%= dt_total.Rows[i][3].ToString() %><span
style='mso-spacerun:yes'>  </span>trong s&#7893; BHXH &#273;&#7875; ti&#7879;n
gi&#7843;i quy&#7871;t các ch&#7871; &#273;&#7897; v&#7873; sau c&#7911;a
ng&#432;&#7901;i lao &#273;&#7897;ng.<o:p></o:p></span></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify;text-indent:
27.0pt'><span style='font-family:"Times New Roman";mso-bidi-font-weight:bold'>Công
ty cam &#273;oan nh&#7919;ng n&#7897;i dung nêu trên là dung s&#7921; th&#7853;t
n&#7871;u sai công ty chúng tôi s&#7869; ch&#7883;u trách nhi&#7879;m
tr&#432;&#7899;c pháp lu&#7853;t.<o:p></o:p></span></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify;text-indent:
27.0pt'><span style='font-family:"Times New Roman"'>Xin chân thành cám &#417;n
và r&#7845;t mong s&#7921; giúp &#273;&#7905; c&#7911;a quý c&#417; quan.<o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify'><b style='mso-bidi-font-weight:
normal'><i style='mso-bidi-font-style:normal'><span style='font-size:13.0pt;
mso-bidi-font-size:12.0pt;font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></i></b></p>

<p class=MsoNormal style='text-align:justify'><b style='mso-bidi-font-weight:
normal'><i style='mso-bidi-font-style:normal'><span style='font-size:13.0pt;
mso-bidi-font-size:12.0pt;font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></i></b></p>

<p class=MsoNormal style='text-align:justify'><b style='mso-bidi-font-weight:
normal'><i style='mso-bidi-font-style:normal'><span style='font-size:13.0pt;
mso-bidi-font-size:12.0pt;font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></i></b></p>

<p class=MsoNormal style='margin-left:3.0in;text-align:justify'><span
style='font-size:13.0pt;mso-bidi-font-size:12.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-left:3.0in;text-align:justify'><span
style='font-size:13.0pt;mso-bidi-font-size:12.0pt'>COÂNG TY TNHH HYOSUNG VIEÄT <st1:place
w:st="on"><st1:country-region w:st="on">NAM</st1:country-region></st1:place><o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify'><span style='font-size:13.0pt;
mso-bidi-font-size:12.0pt;font-family:"Times New Roman"'><span
style='mso-tab-count:7'>                                                                                    </span><span
style='mso-spacerun:yes'>      </span><b style='mso-bidi-font-weight:normal'>GIÁM
&#272;&#7888;C &#272;I&#7872;U HÀNH</b></span><b style='mso-bidi-font-weight:
normal'><span style='font-size:13.0pt;mso-bidi-font-size:12.0pt'> <o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-left:3.5in;text-align:justify'><span
style='font-size:13.0pt;mso-bidi-font-size:12.0pt'><span style='mso-tab-count:
2'>                        </span><span style='mso-spacerun:yes'> </span><o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:3.5in;text-align:justify'><span
style='font-size:13.0pt;mso-bidi-font-size:12.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-left:3.5in;text-align:justify'><span
style='font-size:13.0pt;mso-bidi-font-size:12.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-left:3.5in;text-align:justify'><span
style='font-size:13.0pt;mso-bidi-font-size:12.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-left:3.5in;text-align:justify'><span
style='font-size:13.0pt;mso-bidi-font-size:12.0pt'><span style='mso-tab-count:
2'>                        </span><b style='mso-bidi-font-weight:normal'><span
style='mso-tab-count:4'>                                                            </span></b></span><b>NOH
JUN JEONG</b><span style='font-size:13.0pt;mso-bidi-font-size:12.0pt'><o:p></o:p></span></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

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
</div>

</body>

</html>
