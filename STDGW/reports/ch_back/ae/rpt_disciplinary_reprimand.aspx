<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/msword";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:w="urn:schemas-microsoft-com:office:word"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_user,p_from_join_dt,p_to_join_dt,p_thr_group_pk,p_search_by,p_search_temp,p_status,p_tco_dept_pk,p_level,p_from_disdate,p_to_disdate,p_from_disdate_text,p_to_disdate_text;
    p_user = Request["p_user"].ToString();
    p_from_join_dt = Request["p_from_join_dt"].ToString();
    p_to_join_dt = Request["p_to_join_dt"].ToString();
    p_thr_group_pk = Request["p_thr_group_pk"].ToString();
    p_search_by = Request["p_search_by"].ToString();
    p_search_temp = Request["p_search_temp"].ToString();
    p_status = Request["p_status"].ToString();
    p_tco_dept_pk = Request["p_tco_dept_pk"].ToString();
    p_level = Request["p_level"].ToString();
    p_from_disdate = Request["p_from_disdate"].ToString();
    p_to_disdate = Request["p_to_disdate"].ToString();
    p_from_disdate_text = Request["p_from_disdate_text"].ToString();
    p_to_disdate_text = Request["p_to_disdate_text"].ToString();
    
    DateTime p_from_dt=new DateTime(int.Parse(p_from_disdate.Substring(0,4).ToString()),int.Parse(p_from_disdate.Substring(4,2).ToString()),int.Parse(p_from_disdate.Substring(6,2).ToString())) ;
    DateTime p_to_dt=new DateTime(int.Parse(p_to_disdate.Substring(0,4).ToString()),int.Parse(p_to_disdate.Substring(4,2).ToString()),int.Parse(p_to_disdate.Substring(6,2).ToString())) ;
    
    string SQL;
    SQL = "SELECT " + 
        " h.PARTNER_FNAME as a0 " +
	    ",h.ADDR2 as a1 " +
	    ",h.PHONE_NO as a2 " +
	    ",h.FAX_NO as a3 " +
	    ",to_char(sysdate,'dd/mm/yyyy') as a4 " +
	    " , a.full_name a5,a.emp_id a6 " ;
    SQL =SQL + " ,(select code_nm  from vhr_hr_code where id='HR0008' and code=a.POS_TYPE) a4,to_char(to_date(a.join_dt,'yyyymmdd'),'dd-MON-yy') a7 ";
    SQL = SQL + " ,b.org_nm AS a8 ";
    SQL = SQL + " , to_char(to_date(d.dis_dt,'yyyymmdd'),'dd-mm-yyyy') AS a9 ";
    SQL = SQL + " ,reason_vn AS a10 ";
    SQL = SQL + " ,reason AS a11 ";
    SQL = SQL + " ,(select v.code_nm from vhr_hr_code v where v.id='HR0048' and v.char_4='rpt_disciplinary_reprimand.aspx' and v.tco_company_pk=h.pk) AS a12 ";
    SQL = SQL + "           FROM thr_employee a, tco_org b, thr_work_group c,tco_org g,tco_company h,  ";
    SQL = SQL + "                (SELECT *   " +
        "                FROM THR_DISCIPLINE E  " +
        "                ,(SELECT MAX(C.PK) C_PK, MAX(NVL(C.TIMES,0)) C_TIMES FROM THR_DISCIPLINE C WHERE C.DEL_IF=0 GROUP BY C.THR_EMP_PK) T  " +
        "                WHERE E.DEL_IF=0 " +
        "                AND E.PK = T.C_PK) d ";
    SQL = SQL + "          WHERE a.del_if = 0  and g.del_if=0 and h.del_if=0 and a.tco_company_pk=h.pk ";
    SQL = SQL + "            AND b.del_if = 0 and b.p_pk=g.pk ";
    SQL = SQL + "            AND c.del_if = 0 ";
    SQL = SQL + "            AND a.tco_org_pk = b.pk ";
    SQL = SQL + "            AND a.thr_wg_pk = c.pk ";
    SQL = SQL + "            and (a.JOIN_DT between '" + p_from_join_dt  + "' and '" + p_to_join_dt  + "' or '" + p_from_join_dt + "' is null or '" + p_to_join_dt + "' is null)  ";
    SQL = SQL + "            AND DECODE ('" + p_thr_group_pk + "', ";
    SQL = SQL + "                        'ALL', '" + p_thr_group_pk + "', ";
    SQL = SQL + "                        a.thr_wg_pk ";
    SQL = SQL + "                       ) = '" + p_thr_group_pk  + "'";
    SQL = SQL + "            AND UPPER (DECODE ('" + p_search_by + "', ";
    SQL = SQL + "                              1, a.full_name, ";
    SQL = SQL + "                              2, a.emp_id, ";
    SQL = SQL + "                              3,a.id_num, ";
    SQL = SQL + "                              4,person_id, ";
    SQL = SQL + "                              old_id) ";
    SQL = SQL + "                     ) LIKE '%' || UPPER ('" + p_search_temp + "') || '%' ";
    SQL = SQL + "            AND DECODE ('" + p_status + "', 'ALL', '" + p_status + "', a.status) = '" + p_status  + "'";
    SQL = SQL + "            AND (   a.tco_org_pk IN ( ";
    SQL = SQL + "                              SELECT     g.pk ";
    SQL = SQL + "                                    FROM tco_org g ";
    SQL = SQL + "                                   WHERE g.del_if = 0 ";
    SQL = SQL + "                              START WITH g.pk = ";
    SQL = SQL + "                                            DECODE ('" + p_tco_dept_pk + "', ";
    SQL = SQL + "                                                    'ALL', 0, ";
    SQL = SQL + "                                                    '" + p_tco_dept_pk  + "'";
    SQL = SQL + "                                                   ) ";
    SQL = SQL + "                              CONNECT BY PRIOR g.pk = g.p_pk) ";
    SQL = SQL + "                        OR '" + p_tco_dept_pk + "' = 'ALL') ";
    SQL = SQL + "            AND d.del_if = 0 ";
    SQL = SQL + "            AND d.thr_emp_pk = a.pk ";
    SQL = SQL + "            AND DECODE ('" + p_level + "', 'ALL', '" + p_level + "', d.dis_level) = '" + p_level  + "'";
    SQL = SQL + "            AND (d.dis_dt BETWEEN '" + p_from_disdate + "' AND '" + p_to_disdate + "') ";
    SQL = SQL + "            order by a.emp_id, b.org_nm, c.workgroup_nm ";

	//Response.Write(SQL);
      //  Response.End();

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
<link rel=File-List href="rpt_disciplinary_reprimand_files/filelist.xml">
<title>VERBAL WARNING</title>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>truong</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>10</o:TotalTime>
  <o:Created>2012-07-16T02:35:00Z</o:Created>
  <o:LastSaved>2012-07-16T02:35:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>210</o:Words>
  <o:Characters>1201</o:Characters>
  <o:Lines>10</o:Lines>
  <o:Paragraphs>2</o:Paragraphs>
  <o:CharactersWithSpaces>1409</o:CharactersWithSpaces>
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
	{font-family:VNI-Korin;
	panose-1:0 0 0 0 0 0 0 0 0 0;
	mso-font-charset:0;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:3 0 0 0 1 0;}
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
	{mso-style-next:Normal;
	margin:0in;
	margin-bottom:.0001pt;
	text-align:center;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:1;
	font-size:16.0pt;
	mso-bidi-font-size:12.0pt;
	font-family:VNI-Times;
	mso-font-kerning:0pt;}
h2
	{mso-style-next:Normal;
	margin:0in;
	margin-bottom:.0001pt;
	text-align:justify;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:2;
	tab-stops:center 65.45pt left 181.05pt center 402.05pt;
	font-size:11.0pt;
	mso-bidi-font-size:12.0pt;
	font-family:VNI-Times;}
h3
	{mso-style-next:Normal;
	margin:0in;
	margin-bottom:.0001pt;
	text-align:justify;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:3;
	tab-stops:center 56.1pt 402.05pt;
	font-size:12.0pt;
	font-family:VNI-Korin;}
p.MsoHeader, li.MsoHeader, div.MsoHeader
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	tab-stops:center 3.0in right 6.0in;
	font-size:12.0pt;
	font-family:VNI-Times;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";}
p.MsoFooter, li.MsoFooter, div.MsoFooter
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	tab-stops:center 3.0in right 6.0in;
	font-size:12.0pt;
	font-family:VNI-Times;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";}
p.MsoBodyText, li.MsoBodyText, div.MsoBodyText
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:9.0pt;
	mso-bidi-font-size:12.0pt;
	font-family:VNI-Times;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";}
p.MsoBodyText2, li.MsoBodyText2, div.MsoBodyText2
	{margin-top:6.0pt;
	margin-right:0in;
	margin-bottom:6.0pt;
	margin-left:0in;
	mso-pagination:widow-orphan;
	tab-stops:195.25pt 269.8pt;
	font-size:11.0pt;
	mso-bidi-font-size:12.0pt;
	font-family:VNI-Times;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-noshow:yes;
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:8.0pt;
	font-family:Tahoma;
	mso-fareast-font-family:"Times New Roman";}
span.spelle
	{mso-style-name:spelle;}
 /* Page Definitions */
 @page
	{mso-footnote-separator:url("rpt_disciplinary_reprimand_files/header.htm") fs;
	mso-footnote-continuation-separator:url("rpt_disciplinary_reprimand_files/header.htm") fcs;
	mso-endnote-separator:url("rpt_disciplinary_reprimand_files/header.htm") es;
	mso-endnote-continuation-separator:url("rpt_disciplinary_reprimand_files/header.htm") ecs;}
@page Section1
	{size:595.45pt 841.7pt;
	margin:.4in .7in .3in 1.0in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:1499274576;
	mso-list-type:hybrid;
	mso-list-template-ids:-1760808184 67698697 67698691 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
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
<% 
     
     for (int i = 0; i < irow; i++) 
    {
       
    %> 
<div class=Section1>

<p class=MsoNormal style='tab-stops:right 473.05pt'><i style='mso-bidi-font-style:
normal'><span style='font-size:10.0pt;mso-bidi-font-size:12.0pt;font-family:
Arial;color:#333333;mso-bidi-font-weight:bold'><%= dt_total.Rows[i]["a0"].ToString() %></span></i><b><span
style='font-size:10.0pt;mso-bidi-font-size:12.0pt;font-family:Arial;color:#333333'><span
style='mso-tab-count:1'>                                                                                                                                     </span>ADMIN-HR/07</span></b></p>

<p class=MsoNormal><i><span style='font-size:10.0pt;mso-bidi-font-size:12.0pt;
font-family:Arial'><%= dt_total.Rows[i]["a1"].ToString() %></span></i></p>

<div style='mso-element:para-border-div;border:none;border-bottom:solid windowtext 1.0pt;
mso-border-bottom-alt:solid windowtext .75pt;padding:0in 0in 1.0pt 0in'>

<p class=MsoNormal style='border:none;mso-border-bottom-alt:solid windowtext .75pt;
padding:0in;mso-padding-alt:0in 0in 1.0pt 0in'><i><span style='font-size:10.0pt;
mso-bidi-font-size:12.0pt;font-family:Arial'>Tel: (84) – <%= dt_total.Rows[i]["a2"].ToString() %> <span
style='mso-tab-count:2'>                </span>Fax: (84) – <%= dt_total.Rows[i]["a3"].ToString() %></span></i></p>

</div>

<p class=MsoHeader style='tab-stops:.5in center 3.0in right 6.0in'><i><span
style='font-size:10.0pt;mso-bidi-font-size:12.0pt;font-family:Arial'>No: </span></i><!--[if supportFields]><i><span
style='font-size:10.0pt;mso-bidi-font-size:12.0pt;font-family:Arial'><span
style='mso-element:field-begin'></span><span
style='mso-spacerun:yes'> </span>MERGEFIELD &quot;NO&quot; <span
style='mso-element:field-separator'></span></span></i><![endif]--><i><span
style='font-size:10.0pt;mso-bidi-font-size:12.0pt;font-family:Arial'><span
style='mso-no-proof:yes'>71</span></span></i><!--[if supportFields]><i><span
style='font-size:10.0pt;mso-bidi-font-size:12.0pt;font-family:Arial'><span
style='mso-element:field-end'></span></span></i><![endif]--><i><span
style='font-size:10.0pt;mso-bidi-font-size:12.0pt;font-family:Arial'> </span></i><span
style='font-size:10.0pt;mso-bidi-font-size:12.0pt;font-family:Arial'>HR –2008</span></p>

<p class=MsoHeader style='tab-stops:.5in center 3.0in right 6.0in'><span
style='font-family:Arial'>&nbsp;</span></p>

<h1><span style='font-family:Arial'>LỜI KHIỂN TRÁCH </span></h1>

<p class=MsoNormal align=center style='text-align:center'><b><i><span
style='font-family:Arial'>(REPRIMAND)</span></i></b></p>

<p class=MsoHeader style='tab-stops:354.0pt right 6.0in'><span
style='font-family:Arial'><span style='mso-tab-count:1'>                                                                                                                      </span></span></p>

<p class=MsoNormal style='tab-stops:3.5in right lined 477.0pt'><span
style='font-size:11.0pt;mso-bidi-font-size:12.0pt;font-family:Arial'><span
style='mso-tab-count:1'>                                                                                    </span>Ngày
<i>(date): <b><span style='mso-spacerun:yes'> </span><%= dt_total.Rows[i]["a4"].ToString() %></b></i></span></p>

<p class=MsoNormal style='tab-stops:339.75pt'><span style='font-size:11.0pt;
mso-bidi-font-size:12.0pt;font-family:Arial'><span style='mso-tab-count:1'>                                                                                                                 </span></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;tab-stops:93.5pt 233.75pt 289.85pt 336.6pt 402.05pt right 477.0pt'><span
style='font-size:11.0pt;mso-bidi-font-size:12.0pt;font-family:Arial'>Họ và tên </span><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;mso-bidi-font-size:
12.0pt;font-family:Arial'>(Full name)</span></i><span style='font-size:11.0pt;
mso-bidi-font-size:12.0pt;font-family:Arial'>:<b><%= dt_total.Rows[i]["a5"].ToString() %></b><span style='mso-tab-count:
1'>                                        </span>MSNV </span><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;mso-bidi-font-size:
12.0pt;font-family:Arial'>(Em. </span></i><i style='mso-bidi-font-style:normal'><span
lang=FR style='font-size:10.0pt;mso-bidi-font-size:12.0pt;font-family:Arial;
mso-ansi-language:FR'>Code)</span></i><i><span lang=FR style='font-size:9.0pt;
mso-bidi-font-size:12.0pt;font-family:Arial;mso-ansi-language:FR'>&nbsp;</span></i><span
lang=FR style='font-size:11.0pt;mso-bidi-font-size:12.0pt;font-family:Arial;
mso-ansi-language:FR'>: <b><%= dt_total.Rows[i]["a6"].ToString() %></b></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;tab-stops:93.5pt 233.75pt 374.0pt right lined 477.0pt'><span
lang=FR style='font-size:11.0pt;mso-bidi-font-size:12.0pt;font-family:Arial;
mso-ansi-language:FR'>Chức vụ </span><i style='mso-bidi-font-style:normal'><span
lang=FR style='font-size:10.0pt;mso-bidi-font-size:12.0pt;font-family:Arial;
mso-ansi-language:FR'>(Position )</span></i><span lang=FR style='font-size:
11.0pt;mso-bidi-font-size:12.0pt;font-family:Arial;mso-ansi-language:FR'>:<b>
<%= dt_total.Rows[i]["a7"].ToString() %></b><span style='mso-tab-count:1'>                                          </span>Bộ
phận </span><i style='mso-bidi-font-style:normal'><span lang=FR
style='font-size:10.0pt;mso-bidi-font-size:12.0pt;font-family:Arial;mso-ansi-language:
FR'>(Dept./ </span></i><i style='mso-bidi-font-style:normal'><span
style='font-size:10.0pt;mso-bidi-font-size:12.0pt;font-family:Arial'>Section)</span></i><span
style='font-size:11.0pt;mso-bidi-font-size:12.0pt;font-family:Arial'>: <b><%= dt_total.Rows[i]["a8"].ToString() %></b></span></p>

<p class=MsoBodyText2 style='text-align:justify;tab-stops:lined 3.0in blank 3.5in right lined 477.0pt'><span
style='font-family:Arial'>Vào ngày <%= dt_total.Rows[i]["a9"].ToString() %> nhân viên có tên trên đây đã vi phạm nội
quy công ty như sau:</span></p>

<p class=MsoBodyText2 style='text-align:justify;tab-stops:lined 3.0in blank 3.5in right lined 477.0pt'><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;mso-bidi-font-size:
12.0pt;font-family:Arial'>(It has been noted that on<b> </b><span
style='mso-bidi-font-weight:bold'><%= dt_total.Rows[i]["a9"].ToString() %><b>,</b></span> the above employee violated
the company policy as follows)</span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;tab-stops:right lined 477.0pt'><b><span style='font-size:11.0pt;
mso-bidi-font-size:12.0pt;font-family:Arial'>&nbsp;</span></b></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;tab-stops:right lined 477.0pt'><b><span style='font-size:11.0pt;
mso-bidi-font-size:12.0pt;font-family:Arial'><%= dt_total.Rows[i]["a10"].ToString() %></span></b></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:6.0pt;
margin-left:0in;tab-stops:right lined 477.0pt'><b><i style='mso-bidi-font-style:
normal'><span style='font-size:10.0pt;mso-bidi-font-size:12.0pt;font-family:
Arial'><%= dt_total.Rows[i]["a11"].ToString() %></span></i></b></p>

<p class=MsoBodyText><span style='font-size:11.0pt;mso-bidi-font-size:12.0pt;
font-family:Arial'>&nbsp;</span></p>

<p class=MsoBodyText style='text-align:justify;line-height:150%'><span
style='font-size:11.0pt;mso-bidi-font-size:12.0pt;line-height:150%;font-family:
Arial'>Do đã vi phạm nội quy công ty, nhân viên nêu trên sẽ bị nhận lời khiển
trách (</span><i style='mso-bidi-font-style:normal'><span style='font-size:
10.0pt;mso-bidi-font-size:12.0pt;line-height:150%;font-family:Arial'>Because of
the above-mentioned violation, the verbal reprimand is given</span></i><span
style='font-size:10.0pt;mso-bidi-font-size:12.0pt;line-height:150%;font-family:
Arial'>). </span></p>

<p class=MsoNormal style='text-align:justify;line-height:150%'><span
style='font-size:11.0pt;mso-bidi-font-size:12.0pt;line-height:150%;font-family:
Arial'>Sau này, nếu nhân viên trên tái phạm hoặc vi phạm bất kỳ nội quy công ty
nào khác sẽ bị xử phạt theo quy định của công ty. </span><i style='mso-bidi-font-style:
normal'><span style='font-size:10.0pt;mso-bidi-font-size:12.0pt;line-height:
150%;font-family:Arial'>(Later, if the violation is still repeated, he/she will
receive a more severe discipline according to the current company policy).</span></i></p>

<p class=MsoNormal style='margin-left:.5in;text-indent:-.25in;line-height:150%;
mso-list:l0 level1 lfo2;tab-stops:list .5in'><![if !supportLists]><span
style='font-family:Wingdings;mso-fareast-font-family:Wingdings;mso-bidi-font-family:
Wingdings'><span style='mso-list:Ignore'>v<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='font-size:11.0pt;mso-bidi-font-size:
12.0pt;line-height:150%;font-family:Arial'>Các lần vi phạm trước đó </span><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;mso-bidi-font-size:
12.0pt;line-height:150%;font-family:Arial'>(Previous reprimand was recorded as
follows)</span></i><span style='font-size:11.0pt;mso-bidi-font-size:12.0pt;
line-height:150%;font-family:Arial'>:</span></p>

<p class=MsoNormal style='line-height:150%;tab-stops:right lined 477.0pt'><i><span
style='font-size:11.0pt;mso-bidi-font-size:12.0pt;line-height:150%;font-family:
Arial'><span style='mso-tab-count:1 lined'>_______________________________________________________________________________ </span></span></i></p>

<p class=MsoNormal style='line-height:150%;tab-stops:right lined 477.0pt'><i><span
style='font-size:11.0pt;mso-bidi-font-size:12.0pt;line-height:150%;font-family:
Arial'><span style='mso-tab-count:1 lined'>_______________________________________________________________________________ </span></span></i></p>

<p class=MsoNormal style='margin-left:.5in;text-indent:-.25in;line-height:150%;
mso-list:l0 level1 lfo2;tab-stops:list .5in'><![if !supportLists]><span
style='font-family:Wingdings;mso-fareast-font-family:Wingdings;mso-bidi-font-family:
Wingdings'><span style='mso-list:Ignore'>v<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='font-size:11.0pt;mso-bidi-font-size:
12.0pt;line-height:150%;font-family:Arial'>Kế hoạch được đề nghị để sửa đổi </span><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;mso-bidi-font-size:
12.0pt;line-height:150%;font-family:Arial'>(Suggested responsibilities must
complete):</span></i><i><span style='font-size:11.0pt;mso-bidi-font-size:12.0pt;
line-height:150%;font-family:Arial'><span style='mso-tab-count:1'>           </span></span></i></p>

<p class=MsoNormal style='line-height:150%;tab-stops:right lined 477.0pt'><i><span
style='font-size:11.0pt;mso-bidi-font-size:12.0pt;line-height:150%;font-family:
Arial'><span style='mso-tab-count:1 lined'>_______________________________________________________________________________ </span></span></i></p>

<p class=MsoNormal style='line-height:150%;tab-stops:right lined 477.0pt'><i><span
style='font-size:11.0pt;mso-bidi-font-size:12.0pt;line-height:150%;font-family:
Arial'><span style='mso-tab-count:1 lined'>_______________________________________________________________________________ </span></span></i></p>

<p class=MsoBodyText style='margin-left:.5in;text-indent:-.25in;line-height:
150%;mso-list:l0 level1 lfo2;tab-stops:18.7pt list .5in right lined 477.0pt'><![if !supportLists]><span
style='font-family:Wingdings;mso-fareast-font-family:Wingdings;mso-bidi-font-family:
Wingdings'><span style='mso-list:Ignore'>v<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='font-size:11.0pt;mso-bidi-font-size:
12.0pt;line-height:150%;font-family:Arial'>Hạn chót để sửa chữa </span><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;mso-bidi-font-size:
12.0pt;line-height:150%;font-family:Arial'>(Deadline for reformation)</span></i><i><span
style='font-size:11.0pt;mso-bidi-font-size:12.0pt;line-height:150%;font-family:
Arial'>:</span></i><span style='font-size:11.0pt;mso-bidi-font-size:12.0pt;
line-height:150%;font-family:Arial'><span style='mso-tab-count:1 lined'>____________________________________ </span></span></p>

<p class=MsoBodyText style='margin-left:.25in;line-height:150%;tab-stops:18.7pt right lined 477.0pt'><span
style='font-size:11.0pt;mso-bidi-font-size:12.0pt;line-height:150%;font-family:
Arial'>&nbsp;</span></p>

<p class=MsoNormal style='text-align:justify;tab-stops:center 56.1pt 243.1pt 420.75pt'><b><span
style='font-size:11.0pt;mso-bidi-font-size:12.0pt;font-family:Arial'><span
style='mso-tab-count:1'>     </span>Khiển trách bởi<i><span style='mso-tab-count:
1'>                              </span></i>Chữ ký của nhân viên <span
style='mso-tab-count:1'>                          </span>Chấp thuận bởi </span></b></p>

<p class=MsoNormal style='text-align:justify;tab-stops:center 56.1pt 243.1pt 420.75pt'><i><span
style='font-size:10.0pt;mso-bidi-font-size:12.0pt;font-family:Arial'><span
style='mso-tab-count:1'>      </span>(Reprimanded by</span></i><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;mso-bidi-font-size:
12.0pt;font-family:Arial;mso-bidi-font-weight:bold'>)<b><span style='mso-tab-count:
1'>                                 </span></b></span></i><i><span
style='font-size:10.0pt;mso-bidi-font-size:12.0pt;font-family:Arial'>(Employee’s
signature)<span style='mso-tab-count:1'>                                 </span>(Approved
by</span></i><i style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;
mso-bidi-font-size:12.0pt;font-family:Arial'>)</span></i></p>

<p class=MsoNormal style='text-align:justify;tab-stops:center 56.1pt 243.1pt 420.75pt'><span
style='font-size:9.0pt;mso-bidi-font-size:12.0pt;font-family:Arial'>&nbsp;<o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify;tab-stops:center 56.1pt 243.1pt 420.75pt'><span
style='font-size:9.0pt;mso-bidi-font-size:12.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify;tab-stops:center 56.1pt 243.1pt 420.75pt'><span
style='font-size:9.0pt;mso-bidi-font-size:12.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify;tab-stops:center 56.1pt 243.1pt 420.75pt'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='text-align:justify;tab-stops:center 56.1pt 243.1pt 420.75pt'><span
style='font-size:9.0pt;mso-bidi-font-size:12.0pt;font-family:Arial'>&nbsp;<o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify;tab-stops:center 56.1pt 243.1pt 420.75pt'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='text-align:justify;tab-stops:center 56.1pt 243.1pt 420.75pt'><span
style='font-size:9.0pt;mso-bidi-font-size:12.0pt;font-family:Arial'>&nbsp;</span><b><span
style='font-size:11.0pt;mso-bidi-font-size:12.0pt;font-family:Arial'><span
style='mso-tab-count:1'>               </span><%= dt_total.Rows[i]["a12"].ToString() %><i><span style='mso-tab-count:
1'>                                                         </span></i><%= dt_total.Rows[i]["a5"].ToString() %> <span
style='mso-tab-count:1'>                                          </span></span></b><span
class=spelle><b style='mso-bidi-font-weight:normal'><span style='font-size:
11.0pt;mso-bidi-font-size:12.0pt;font-family:Arial'>Trưởng</span></b></span><b
style='mso-bidi-font-weight:normal'><span style='font-size:11.0pt;mso-bidi-font-size:
12.0pt;font-family:Arial'> <span class=spelle>bộ</span> <span class=spelle>phận</span></span></b></p>

<p class=MsoNormal style='margin-left:1.0in;text-align:justify;tab-stops:center 85.45pt 440.75pt'><span
style='font-size:9.0pt;mso-bidi-font-size:12.0pt;font-family:Arial'>&nbsp;</span><b><i><span
style='font-size:10.0pt;mso-bidi-font-size:12.0pt;font-family:Arial'><span
style='mso-spacerun:yes'>                                                                                                         
</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Dept. Manager)</span></i></b></p>

<p class=MsoNormal style='text-align:justify;line-height:150%;tab-stops:right dashed 477.0pt'><i><span
style='font-size:11.0pt;mso-bidi-font-size:12.0pt;line-height:150%;font-family:
Arial'><span style='mso-tab-count:1 dashed'>------------------------------------------------------------------------------------------------------------------------------ </span></span></i></p>

<p class=MsoNormal style='text-align:justify;tab-stops:center 102.85pt 374.0pt right lined 477.0pt'><b><span
style='font-size:11.0pt;mso-bidi-font-size:12.0pt;font-family:Arial'><span
style='mso-tab-count:1'>        </span>Ghi nhận của Phòng Nhân Sự <span
style='mso-tab-count:1'>                                               </span>Đại
diện công đoàn </span></b></p>

<p class=MsoNormal style='text-align:justify;tab-stops:center 102.85pt 374.0pt'><b><i
style='mso-bidi-font-style:normal'><span style='font-size:10.0pt;mso-bidi-font-size:
12.0pt;font-family:Arial'><span style='mso-tab-count:1'>                   </span>(Noted
by HR Dept.)<span style='mso-tab-count:1'>                                                           </span>Representative
Union</span></i></b><b><i><span style='font-size:11.0pt;mso-bidi-font-size:
12.0pt;font-family:Arial'><span style='mso-tab-count:1'>   </span></span></i></b></p>

<p class=MsoNormal style='text-align:justify;line-height:150%;tab-stops:right lined 477.0pt'><span
style='font-size:11.0pt;mso-bidi-font-size:12.0pt;line-height:150%;font-family:
Arial'>&nbsp;</span></p>

<p class=MsoNormal style='text-align:justify;line-height:150%;tab-stops:right lined 477.0pt'><span
style='font-size:11.0pt;mso-bidi-font-size:12.0pt;line-height:150%;font-family:
Arial'>&nbsp;</span></p>

<p class=MsoNormal style='text-align:justify;line-height:150%;tab-stops:right lined 477.0pt'><span
style='font-size:11.0pt;mso-bidi-font-size:12.0pt;line-height:150%;font-family:
Arial'>&nbsp;</span></p>

<p class=MsoNormal style='text-align:justify;line-height:150%;tab-stops:37.4pt dashed 168.3pt blank 308.55pt dashed 430.1pt right blank 477.0pt'><span
style='font-family:Arial'><span style='mso-tab-count:1'>             </span><span
style='mso-tab-count:2 dashed'>----------------------------------------------------------------------- </span><span
style='mso-tab-count:1'>                                         </span></span>&nbsp;</p>

</div>
<%} %>
</body>

</html>
