<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
string emp_pk;
    emp_pk = Request["emp_pk"].ToString();

    string SQL
    = "select e.PHOTO_PK " +
        "   ,e.rec_id " +
        "   ,to_char( to_date(CV_RECIEVE_DT,'yyyymmdd'),'dd/mm/yyyy') " +
        "   ,e.REC_NM " +
        "   ,decode (SEX,'M','Nam','F','Nu','') " +
        "   ,case when length( BIRTH_DT)>4 then to_char( to_date(BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy') else BIRTH_DT  end " +
        "   ,PER_ID " +
        "   ,to_char( to_date(PER_DT,'yyyymmdd'),'dd/mm/yyyy') " +
        "   ,(select v.code_nm from vhr_hr_code v where v.id='HR0014' and v.code=nvl( PER_PLACE,' ')) " +
        "   ,PERMANENT_ADDR " +
        "   ,PRESENT_ADDR " +
        "   ,HAND_PHONE " +
        "   ,EMAIL " +
        "   ,(select v.code_nm from vhr_hr_code v where v.id='HR0011' and v.code=nvl(EDU_TYPE,' ')) " +
        "   ,(select v.code_nm from vhr_hr_code v where v.id='HR0146' and v.code=nvl(GRA_SCHOOL,' ')) " +
        "   ,(select v.code_nm from vhr_hr_code v where v.id='HR0148' and v.code=nvl(MAJOR,' ')) " +
        "   ,(select v.code_nm from vhr_hr_code v where v.id='HR0147' and v.code=nvl(GRA_RESULT,' ')) " +
        "   ,(select v.code_nm from vhr_hr_code v where v.id='HR0143' and v.code=nvl(LANG_TYPE,' ')) " +
        "   ,(select v.code_nm from vhr_hr_code v where v.id='HR0144' and v.code=nvl(LANG_RESULT,' ')) " +
        "   ,OTHER_LANGUAGE " +
        "   ,COMPUTER_SKILL " +
        "   ,OTHER_DEGREE " +
        "   ,EXPERIENCE_YEAR " +
        "   ,REMARK " +
        "   ,(select g.ORG_NM from   comm.tco_org g where g.del_if=0 and g.pk=nvl( REC_ORG_PK,0)) " +
        "   ,(select v.code_nm from vhr_hr_code v where v.id='HR0008' and v.code=nvl(REC_POS_TYPE,' ')) " +
        "   ,(select v.code_nm from vhr_hr_code v where v.id='HR0010' and v.code=nvl(REC_JOB_TYPE,' ')) " +
        "   ,REC_SALARY " +
        "   ,OTHER_REQUEST " +
        "   ,INT_ID||'-'||INT_NM  " +
        "   ,to_char( to_date(INTERVIEW_DT1,'yyyymmdd'),'dd/mm/yyyy') " +
        "   ,to_char( to_date(INTERVIEW_DT2,'yyyymmdd'),'dd/mm/yyyy') " +
        "   ,to_char( to_date(INTERVIEW_DT3,'yyyymmdd'),'dd/mm/yyyy') " +
        "   ,RESULT_T1 " +
        "   ,RESULT_T2 " +
        "   ,RESULT_T3 " +
        "   ,REMARK_1 " +
        "   ,REMARK_2 " +
        "   ,REMARK_3 " +
        "   from thr_rec_emp e " +
        "   where e.del_if=0 and e.pk in ("+emp_pk+") ";

    //Response.Write(SQL);
    //Response.End();
    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt_Emp.Rows.Count;
    if (irow == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    
    
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List
href="New%20Microsoft%20Excel%20Worksheet_files/filelist.xml">
<link rel=Edit-Time-Data
href="New%20Microsoft%20Excel%20Worksheet_files/editdata.mso">
<link rel=OLE-Object-Data
href="New%20Microsoft%20Excel%20Worksheet_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>nhut_k</o:LastAuthor>
  <o:LastPrinted>2011-06-17T09:22:02Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-06-17T09:23:52Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.1in .3in .1in .3in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
.font6
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;}
.font11
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;}
.font12
	{color:windowtext;
	font-size:20.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;}
.font13
	{color:windowtext;
	font-size:13.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;}
.font14
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl24
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;}
.xl25
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;}
.xl26
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;}
.xl27
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	border:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:right;
	vertical-align:middle;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl62
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl65
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl74
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl77
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	background:silver;
	mso-pattern:silver none;}
.xl79
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	background:silver;
	mso-pattern:auto none;}
.xl80
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl82
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl83
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl84
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl86
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl87
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl88
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl89
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl90
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl91
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl92
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl93
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl94
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl95
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl96
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl97
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl98
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet2</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>402</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:Scale>64</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:CodeName></x:CodeName>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
     <x:PageBreaks>
     <x:RowBreaks>
      <% 
         irow=0;
        for (int k=0;k<dt_Emp.Rows.Count;k++)
        {irow=irow + 39;
           
            %>
            
            <x:RowBreak>
                <x:Row><%=irow %></x:Row>
            </x:RowBreak>
            <%    
                
        }  
      %>
      
     </x:RowBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:CodeName>Sheet1</x:CodeName>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9300</x:WindowHeight>
  <x:WindowWidth>15135</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="4097"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="3"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1176 style='border-collapse:
 collapse;table-layout:fixed;width:883pt'>
 <col class=xl24 width=286 style='mso-width-source:userset;mso-width-alt:10459;
 width:215pt'>
 <col class=xl26 width=12 style='mso-width-source:userset;mso-width-alt:438;
 width:9pt'>
 <col class=xl24 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl24 width=201 style='mso-width-source:userset;mso-width-alt:7350;
 width:151pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=199 style='mso-width-source:userset;mso-width-alt:7277;
 width:149pt'>
 <col class=xl24 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl24 width=64 style='mso-width-source:userset;mso-width-alt:2340;
 width:48pt'>
 <col class=xl24 width=64 span=2 style='width:48pt'>
  <% for (int i=0;i<dt_Emp.Rows.Count;i++)
  {
   %>
 
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=9 rowspan=3 height=78 width=1112 style='height:60.3pt;width:835pt'
  align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
   coordsize="21600,21600" o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe"
   filled="f" stroked="f">
   <v:stroke joinstyle="miter"/>
   <v:formulas>
    <v:f eqn="if lineDrawn pixelLineWidth 0"/>
    <v:f eqn="sum @0 1 0"/>
    <v:f eqn="sum 0 0 @1"/>
    <v:f eqn="prod @2 1 2"/>
    <v:f eqn="prod @3 21600 pixelWidth"/>
    <v:f eqn="prod @3 21600 pixelHeight"/>
    <v:f eqn="sum @0 0 1"/>
    <v:f eqn="prod @6 1 2"/>
    <v:f eqn="prod @7 21600 pixelWidth"/>
    <v:f eqn="sum @8 21600 0"/>
    <v:f eqn="prod @7 21600 pixelHeight"/>
    <v:f eqn="sum @10 21600 0"/>
   </v:formulas>
   <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
   <o:lock v:ext="edit" aspectratio="t"/>
  </v:shapetype><v:shape id="_x0000_s3073" type="#_x0000_t75" style='position:absolute;
   margin-left:.75pt;margin-top:0;width:96pt;height:77.25pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_Emp.Rows[i][0].ToString()%>&table_name=TC_FSBINARY"
    o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Pict</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:1px;margin-top:0px;width:128px;
  height:103px'><img width=128 height=103
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_Emp.Rows[i][0].ToString()%>&table_name=TC_FSBINARY" v:shapes="_x0000_s3073"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=9 rowspan=3 height=78 class=xl77 width=1112 style='height:60.3pt;
    width:835pt'>H&#7890; S&#416; TUY&#7874;N D&#7908;NG - <font class="font12">APLICATION
    DOCUMENT</font></td>
   </tr>
  </table>
  </span></td>
  
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=3 height=26 class=xl57 style='height:20.1pt'>M&atilde; h&#7891;
  s&#417; - <font class="font14">Document ID</font></td>
  <td class=xl42 x:str><%=dt_Emp.Rows[i][1].ToString()%></td>
  <td colspan=2 class=xl55>Ng&agrave;y nh&#7853;n -<font class="font14">Received
  Date</font></td>
  <td colspan=3 class=xl56><%=dt_Emp.Rows[i][2].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td colspan=9 height=29 class=xl78 style='height:21.95pt'>TH&Ocirc;NG TIN
  C&Aacute; NH&Acirc;N - PERSONAL INFORMATION</td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl27 style='height:21.95pt'>H&#7885; t&ecirc;n -<font
  class="font13"> Name</font></td>
  <td class=xl30>:</td>
  <td colspan=7 class=xl80 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Emp.Rows[i][3].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl28 style='height:21.95pt;border-top:none'>Gi&#7899;i
  t&iacute;nh -<font class="font13"> Sex</font></td>
  <td class=xl31 style='border-top:none'>:</td>
  <td colspan=7 class=xl44 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Emp.Rows[i][4].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl28 style='height:21.95pt;border-top:none'>Ng&agrave;y
  sinh -<font class="font13">Birth Date</font></td>
  <td class=xl31 style='border-top:none'>:</td>
  <td colspan=7 class=xl43 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Emp.Rows[i][5].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl28 style='height:21.95pt;border-top:none'>CMND - <font
  class="font13">Personal ID</font></td>
  <td class=xl31 style='border-top:none'>:</td>
  <td class=xl35 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][6].ToString()%></td>
  <td class=xl35 style='border-top:none;border-left:none'>Ng&agrave;y c&#7845;p
  - <font class="font14">Issue DT</font><font class="font6">:</font></td>
  <td class=xl43 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][7].ToString()%></td>
  <td class=xl35 style='border-top:none'>N&#417;i c&#7845;p - <font
  class="font14">Place ID</font><font class="font6"> :</font></td>
  <td colspan=3 class=xl44 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Emp.Rows[i][8].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl28 style='height:21.95pt;border-top:none'>&#272;&#7883;a
  ch&#7881; - <font class="font13">Permanent -Address</font></td>
  <td class=xl31 style='border-top:none'>:</td>
  <td colspan=7 class=xl44 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Emp.Rows[i][9].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl28 style='height:21.95pt;border-top:none'>T&#7841;m
  tr&uacute; - <font class="font13">Current Address</font></td>
  <td class=xl31 style='border-top:none'>:</td>
  <td colspan=7 class=xl44 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Emp.Rows[i][10].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl28 style='height:21.95pt;border-top:none'>&#272;i&#7879;n
  tho&#7841;i - <font class="font13">Tell No</font></td>
  <td class=xl31 style='border-top:none'>:</td>
  <td colspan=7 class=xl44 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Emp.Rows[i][11].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl29 style='height:21.95pt;border-top:none'>Email</td>
  <td class=xl32 style='border-top:none'>:</td>
  <td colspan=7 class=xl68 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Emp.Rows[i][12].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl25 style='height:21.95pt'></td>
  <td class=xl26></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl25 style='height:21.95pt'></td>
  <td class=xl26></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td colspan=9 height=29 class=xl79 style='height:21.95pt'>TR&Igrave;NH
  &#272;&#7896; CHUY&Ecirc;N M&Ocirc;N -<span style='mso-spacerun:yes'> 
  </span>EDUCATION</td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl45 style='height:21.95pt'>Tr&igrave;nh &#273;&#7897; - <font
  class="font13">Education</font></td>
  <td class=xl46>:</td>
  <td class=xl47 style='border-left:none'><%=dt_Emp.Rows[i][13].ToString()%></td>
  <td class=xl47 style='border-left:none'>Tr&#7915;&#417;ng <font class="font14">-
  School</font><font class="font6"> :</font></td>
  <td colspan=5 class=xl74 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Emp.Rows[i][14].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl48 style='height:21.95pt;border-top:none'>Chuy&ecirc;n
  ng&agrave;nh -<font class="font13"> Major</font></td>
  <td class=xl49 style='border-top:none'>:</td>
  <td class=xl50 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][15].ToString()%></td>
  <td class=xl50 style='border-top:none;border-left:none'>T&#7889;t
  nghi&#7879;p lo&#7841;i - <font class="font14">Graduation Kin</font><span
  style='display:none'><font class="font14">d</font><font class="font6">:</font></span></td>
  <td colspan=5 class=xl44 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Emp.Rows[i][16].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl48 style='height:21.95pt;border-top:none'>Ngo&#7841;i
  ng&#7919; - <font class="font13">Foreigner Language</font></td>
  <td class=xl49 style='border-top:none'>:</td>
  <td class=xl50 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][17].ToString()%></td>
  <td class=xl50 style='border-top:none;border-left:none'>Tr&igrave;nh
  &#273;&#7897; ngo&#7841;i ng&#7919; -<font class="font14"> Level</font><font
  class="font6">:</font></td>
  <td class=xl44 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][18].ToString()%></td>
  <td class=xl50 style='border-top:none'>Ngo&#7841;i ng&#7919; kh&aacute;c
  :Other Languag<span style='display:none'>es</span></td>
  <td colspan=3 class=xl44 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Emp.Rows[i][19].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl48 style='height:21.95pt;border-top:none'>Tr&igrave;nh
  &#273;&#7897; s&#7917; d&#7909;ng vi t&iacute;nh -<font class="font13">Computer
  Skill</font></td>
  <td class=xl49 style='border-top:none'>:</td>
  <td class=xl50 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][20].ToString()%></td>
  <td class=xl50 style='border-top:none;border-left:none'>V&#259;n<span
  style='mso-spacerun:yes'>  </span>b&#7857;ng kh&aacute;c <font class="font14">-Other
  Certificat</font><span style='display:none'><font class="font14">e</font><font
  class="font6">:</font></span></td>
  <td colspan=5 class=xl44 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Emp.Rows[i][21].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl48 style='height:21.95pt;border-top:none'>Kinh
  nghi&#7879;m l&agrave;m vi&#7879;c - <font class="font13">Experence</font></td>
  <td class=xl49 style='border-top:none'>:</td>
  <td colspan=7 class=xl44 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Emp.Rows[i][22].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl51 style='height:21.95pt;border-top:none'>Ghi
  ch&uacute; kh&aacute;c - <font class="font13">Other Description</font></td>
  <td class=xl52 style='border-top:none'>:</td>
  <td colspan=7 class=xl68 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Emp.Rows[i][23].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl25 style='height:21.95pt'></td>
  <td class=xl26></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl24 style='height:21.95pt'></td>
  <td class=xl26></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td colspan=9 height=29 class=xl33 style='border-right:.5pt solid black;
  height:21.95pt'>V&#7882; TR&Iacute; &#7912;NG TUY&#7874;N - <font
  class="font11">APPLY POSITION</font></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl45 style='height:21.95pt'>B&#7897; ph&#7853;n - <font
  class="font13">Organization</font></td>
  <td class=xl46>:</td>
  <td colspan=7 class=xl74 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Emp.Rows[i][24].ToString()%>;</td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl48 style='height:21.95pt;border-top:none'>Ch&#7913;c
  v&#7909; -<font class="font13"> Position</font></td>
  <td class=xl49 style='border-top:none'>:</td>
  <td colspan=7 class=xl44 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Emp.Rows[i][25].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl48 style='height:21.95pt;border-top:none'>C&ocirc;ng
  vi&#7879;c - <font class="font13">Job</font></td>
  <td class=xl49 style='border-top:none'>:</td>
  <td colspan=7 class=xl44 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Emp.Rows[i][26].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl48 style='height:21.95pt;border-top:none'>M&#7913;c
  l&#432;&#417;ng &#273;&#7873; ngh&#7883; - <font class="font13">Salary</font></td>
  <td class=xl49 style='border-top:none'>:</td>
  <td colspan=7 class=xl44 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Emp.Rows[i][27].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl48 style='height:21.95pt;border-top:none'>Y&ecirc;u
  c&#7847;u kh&aacute;c - <font class="font13">Other Request</font></td>
  <td class=xl49 style='border-top:none'>:</td>
  <td colspan=7 class=xl44 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Emp.Rows[i][28].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl53 style='height:21.95pt'>Ng&#432;&#7901;i gi&#7899;i
  thi&#7879;u - <font class="font13">Introduction Name</font></td>
  <td class=xl54>:</td>
  <td colspan=7 class=xl71 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Emp.Rows[i][29].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl24 style='height:21.95pt'></td>
  <td class=xl26></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=9 height=26 class=xl33 style='border-right:.5pt solid black;
  height:20.1pt'>TH&Ocirc;NG TIN PH&#7886;NG V&#7844;N - <font class="font11">INTERVIEW
  INFORMATION</font></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl33 style='height:20.1pt'>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td colspan=2 class=xl64>L&#7846;N 1 - <font class="font11">TIME 1</font></td>
  <td colspan=2 class=xl85 style='border-right:.5pt hairline black;border-left:
  none'>L&#7846;N 2 - <font class="font11">TIME 2</font></td>
  <td colspan=3 class=xl85 style='border-right:.5pt solid black;border-left:
  none'>L&#7846;N 3 -<font class="font11">TIME 3</font></td>
  <td class=xl24></td>
 </tr>
 <tr height=41 style='mso-height-source:userset;height:30.75pt'>
  <td height=41 class=xl36 style='height:30.75pt'>Ng&agrave;y ph&#7887;ng
  v&#7845;n - <font class="font13">Interviewe Date</font></td>
  <td class=xl37>:</td>
  <td colspan=2 class=xl65 style='border-right:.5pt hairline black'><%=dt_Emp.Rows[i][30].ToString()%></td>
  <td colspan=2 class=xl65 style='border-right:.5pt hairline black;border-left:
  none'><%=dt_Emp.Rows[i][31].ToString()%></td>
  <td colspan=3 class=xl65 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Emp.Rows[i][32].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=44 style='mso-height-source:userset;height:33.0pt'>
  <td height=44 class=xl38 style='height:33.0pt;border-top:none'>K&#7871;t
  qu&#7843; - <font class="font13">Result</font></td>
  <td class=xl39 style='border-top:none'>:</td>
  <td colspan=2 class=xl60 style='border-right:.5pt hairline black'><%=dt_Emp.Rows[i][33].ToString()%></td>
  <td colspan=2 class=xl60 style='border-right:.5pt hairline black;border-left:
  none'><%=dt_Emp.Rows[i][34].ToString()%></td>
  <td colspan=3 class=xl60 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Emp.Rows[i][35].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=60 style='mso-height-source:userset;height:45.0pt'>
  <td height=60 class=xl38 style='height:45.0pt;border-top:none'>Ghi ch&uacute;
  - <font class="font13">Remark</font></td>
  <td class=xl39 style='border-top:none'>:</td>
  <td colspan=2 class=xl60 style='border-right:.5pt hairline black'><%=dt_Emp.Rows[i][36].ToString()%></td>
  <td colspan=2 class=xl60 style='border-right:.5pt hairline black;border-left:
  none'><%=dt_Emp.Rows[i][37].ToString()%></td>
  <td colspan=3 class=xl60 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Emp.Rows[i][38].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=83 style='mso-height-source:userset;height:62.25pt'>
  <td height=83 class=xl40 style='height:62.25pt'>Ng&#432;&#7901;i tuy&#7875;n
  d&#7909;ng - <font class="font13">Interviewer</font></td>
  <td class=xl41>:</td>
  <td colspan=2 class=xl58 style='border-right:.5pt hairline black;border-left:
  none'></td>
  <td colspan=2 class=xl87 style='border-right:.5pt hairline black;border-left:
  none'></td>
  <td colspan=3 class=xl87 style='border-right:.5pt solid black;border-left:
  none'></td>
  <td class=xl24></td>
 </tr>
 <tr>
 <td></td>
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=286 style='width:215pt'></td>
  <td width=12 style='width:9pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=201 style='width:151pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=199 style='width:149pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
