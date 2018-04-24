﻿<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%

	string SQL1
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION='01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=975 " +
        ") " +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_1 = ESysLib.TableReadOpen(SQL1);
    /*if (dt_1.Rows.Count == 0)
    {
        Response.Write("There is no data of working time");
        Response.End();
    }/**/

	string SQL2
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION='01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=974 " +
        ") " +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_2 = ESysLib.TableReadOpen(SQL2);
	
	string SQL3
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION='01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=976 " +
        ") " +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_3 = ESysLib.TableReadOpen(SQL3);
	
	string SQL4
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION='01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=977 " +
        ") " +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_4 = ESysLib.TableReadOpen(SQL4);
	
	string SQL5
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION='01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=979 " +
        ") " +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_5 = ESysLib.TableReadOpen(SQL5);
	
	string SQL6
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION='01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=980 " +
        ") " +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_6 = ESysLib.TableReadOpen(SQL6);
	
	string SQL7
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION='01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=978 " +
        ") " +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_7 = ESysLib.TableReadOpen(SQL7);
	
	string SQL8
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION='01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=982 " +
        ") " +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_8 = ESysLib.TableReadOpen(SQL8);
	
	string SQL9
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION='01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=981 " +
        ") " +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_9 = ESysLib.TableReadOpen(SQL9);
	
	string SQLmax
	= "select max(cnt) max_cnt " + 
        "from " +
        "(select c10, count(*) cnt " +
        "from " +
        "(select c00, c01, c02, c03, c04 " +
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION='01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk " +
        ") " +
        ") " +
        "group by c10 " +
        ") " ;
		
	DataTable dt_max = ESysLib.TableReadOpen(SQLmax);


%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_org_chart_pcss_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_org_chart_pcss_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_org_chart_pcss_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>User</o:Author>
  <o:LastAuthor>SV108</o:LastAuthor>
  <o:LastPrinted>2013-03-25T04:12:07Z</o:LastPrinted>
  <o:Created>2012-12-10T08:25:12Z</o:Created>
  <o:LastSaved>2013-03-26T07:02:49Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.36in .2in .22in .2in;
	mso-header-margin:.2in;
	mso-footer-margin:.19in;
	mso-page-orientation:landscape;}
.font24
	{color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
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
	font-family:Arial, sans-serif;
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
	font-family:Arial, sans-serif;
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
.xl66
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;}
.xl67
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl68
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;}
.xl69
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl70
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;}
.xl72
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	color:olive;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	font-size:11.0pt;}
.xl75
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	color:white;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	font-size:8.0pt;}
.xl79
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl80
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:normal;}
.xl81
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	vertical-align:middle;
	white-space:normal;}
.xl82
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	color:white;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl84
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl85
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;}
.xl87
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	color:red;}
.xl90
	{mso-style-parent:style0;
	color:white;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl91
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:left;}
.xl92
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl95
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl96
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl97
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl99
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	border:.5pt solid windowtext;}
.xl100
	{mso-style-parent:style0;
	font-size:11.0pt;
	border:.5pt solid windowtext;}
.xl101
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	border:.5pt solid windowtext;}
.xl102
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl103
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"dd\\-mmm\\-yyyy";
	text-align:center;}
.xl104
	{mso-style-parent:style0;
	color:black;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl105
	{mso-style-parent:style0;
	color:black;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl106
	{mso-style-parent:style0;
	color:black;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl107
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl108
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl109
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl110
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl111
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl112
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl113
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl114
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl115
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl116
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl117
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl118
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl119
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl120
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl121
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl122
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl123
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>PCSS</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>52</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>9</x:SplitHorizontal>
     <x:TopRowBottomPane>9</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>3</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveCol>1</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveCol>1</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>3</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
       <x:RangeSelection>$B$4:$AV$4</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7365</x:WindowHeight>
  <x:WindowWidth>18975</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Area</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=PCSS!$B$1:$AV$13</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2132 style='border-collapse:
 collapse;table-layout:fixed;width:1604pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:2340'>
 <col width=54 style='mso-width-source:userset;mso-width-alt:1974;width:41pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:2194'>
 <col width=42 style='mso-width-source:userset;mso-width-alt:1536;width:32pt'>
 <col width=83 style='mso-width-source:userset;mso-width-alt:3035;width:62pt'>
 <col width=37 style='mso-width-source:userset;mso-width-alt:1353;width:28pt'>
 <col width=39 style='mso-width-source:userset;mso-width-alt:1426;width:29pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:2340'>
 <col width=41 style='mso-width-source:userset;mso-width-alt:1499;width:31pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:3657;width:75pt'>
 <col width=11 style='mso-width-source:userset;mso-width-alt:402;width:8pt'>
 <col width=53 style='mso-width-source:userset;mso-width-alt:1938;width:40pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:1645'>
 <col width=38 style='mso-width-source:userset;mso-width-alt:1389;width:29pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=24 style='mso-width-source:userset;mso-width-alt:877;width:18pt'>
 <col width=59 style='mso-width-source:userset;mso-width-alt:2157;width:44pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:1682'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:3657;width:75pt'>
 <col width=12 style='mso-width-source:userset;mso-width-alt:438;width:9pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:2669'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=11 style='mso-width-source:userset;mso-width-alt:402;width:8pt'>
 <col width=78 style='mso-width-source:userset;mso-width-alt:2852;width:59pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:1792'>
 <col width=36 style='mso-width-source:userset;mso-width-alt:1316;width:27pt'>
 <col width=86 style='mso-width-source:userset;mso-width-alt:3145;width:65pt'>
 <col width=15 style='mso-width-source:userset;mso-width-alt:548;width:11pt'>
 <col width=76 style='mso-width-source:userset;mso-width-alt:2779;width:57pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:1389'>
 <col width=36 style='mso-width-source:userset;mso-width-alt:1316;width:27pt'>
 <col width=83 style='mso-width-source:userset;mso-width-alt:3035;width:62pt'>
 <col width=63 style='mso-width-source:userset;mso-width-alt:2304;width:47pt'>
 <col width=35 style='mso-width-source:userset;mso-width-alt:1280;width:26pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:2084'>
 <col width=38 style='mso-width-source:userset;mso-width-alt:1389;width:29pt'>
 <col width=86 style='mso-width-source:userset;mso-width-alt:3145;width:65pt'>
 <col width=38 style='mso-width-source:userset;mso-width-alt:1389;width:29pt'>
 <col width=42 style='mso-width-source:userset;mso-width-alt:1536;width:32pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:2230'>
 <col width=37 style='mso-width-source:userset;mso-width-alt:1353;width:28pt'>
 <col width=109 style='mso-width-source:userset;mso-width-alt:3986;width:82pt'>
 <col width=16 style='mso-width-source:userset;mso-width-alt:585;width:12pt'>
 <col width=54 style='mso-width-source:userset;mso-width-alt:1974;width:41pt'>
 <col width=32 style='mso-width-source:userset;mso-width-alt:1170;width:24pt'>
 <col width=86 style='mso-width-source:userset;mso-width-alt:3145;width:65pt'>
 <col width=11 style='mso-width-source:userset;mso-width-alt:402;width:8pt'>
 <col width=64 style='width:48pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 width=0 style='height:12.75pt'></td>
  <td class=xl66 width=54 style='width:41pt'><a name="Print_Area"></a></td>
  <td class=xl66 width=0></td>
  <td width=42 style='width:32pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
   id="_x0000_t75" coordsize="21600,21600" o:spt="75" o:preferrelative="t"
   path="m@4@5l@4@11@9@11@9@5xe" filled="f" stroked="f">
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
  </v:shapetype><v:shape id="Picture_x0020_3" o:spid="_x0000_s1035" type="#_x0000_t75"
   alt="posco ss-vina logo" style='position:absolute;margin-left:14.25pt;
   margin-top:0;width:79.5pt;height:32.25pt;z-index:1;visibility:visible'>
   <v:imagedata src="rpt_org_chart_pcss_files/image001.jpg" o:title="posco ss-vina logo"/>
   <x:ClientData ObjectType="Pict">
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:19px;margin-top:0px;width:106px;
  height:43px'><img width=106 height=43
  src="rpt_org_chart_pcss_files/image002.jpg" alt="posco ss-vina logo" v:shapes="Picture_x0020_3"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 class=xl66 width=42 style='height:12.75pt;width:32pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl66 width=83 style='width:62pt'></td>
  <td width=37 style='width:28pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
   id="_x0000_t202" coordsize="21600,21600" o:spt="202" path="m,l,21600r21600,l21600,xe">
   <v:stroke joinstyle="miter"/>
   <v:path gradientshapeok="t" o:connecttype="rect"/>
  </v:shapetype><v:shape id="Text_x0020_Box_x0020_2" o:spid="_x0000_s1036"
   type="#_x0000_t202" style='position:absolute;margin-left:9.75pt;
   margin-top:0;width:712.5pt;height:30pt;z-index:2;visibility:visible'
   stroked="f">
   <v:textbox style='mso-direction-alt:auto' inset="2.16pt,1.8pt,0,0">
    <div style='text-align:left'><font class="font24">POSCO SS - VINA Co.,
    LTD<br>
        </font><font class="font24">N1 Street, Phu My II Industrial Zone, Tan
    Thanh District, Ba Ria - Vung Tau Province, Vietnam<span
    style='mso-spacerun:yes'>          </span></font></div>
   </v:textbox>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:13px;margin-top:0px;width:950px;
  height:40px'><img width=950 height=40
  src="rpt_org_chart_pcss_files/image003.gif"
  alt="Text Box: POSCO SS - VINA Co., LTD&#10;N1 Street, Phu My II Industrial Zone, Tan Thanh District, Ba Ria - Vung Tau Province, Vietnam          "
  v:shapes="Text_x0020_Box_x0020_2"></span><![endif]><span style='mso-ignore:
  vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 class=xl66 width=37 style='height:12.75pt;width:28pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl67 width=39 style='width:29pt'></td>
  <td class=xl67 width=0></td>
  <td class=xl66 width=41 style='width:31pt'></td>
  <td class=xl66 width=100 style='width:75pt'></td>
  <td class=xl66 width=11 style='width:8pt'></td>
  <td class=xl67 width=53 style='width:40pt'></td>
  <td class=xl67 width=0></td>
  <td class=xl67 width=38 style='width:29pt'></td>
  <td class=xl67 width=79 style='width:59pt'></td>
  <td class=xl67 width=24 style='width:18pt'></td>
  <td class=xl67 width=59 style='width:44pt'></td>
  <td class=xl67 width=0></td>
  <td class=xl67 width=40 style='width:30pt'></td>
  <td class=xl67 width=100 style='width:75pt'></td>
  <td class=xl67 width=12 style='width:9pt'></td>
  <td width=74 style='width:56pt'></td>
  <td class=xl67 width=0></td>
  <td class=xl67 width=40 style='width:30pt'></td>
  <td class=xl67 width=74 style='width:56pt'></td>
  <td class=xl67 width=11 style='width:8pt'></td>
  <td class=xl67 width=78 style='width:59pt'></td>
  <td width=0></td>
  <td width=36 style='width:27pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=15 style='width:11pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=0></td>
  <td width=36 style='width:27pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=35 style='width:26pt'></td>
  <td width=0></td>
  <td width=38 style='width:29pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=42 style='width:32pt'></td>
  <td class=xl67 width=0></td>
  <td class=xl67 width=37 style='width:28pt'></td>
  <td class=xl67 width=109 style='width:82pt'></td>
  <td class=xl67 width=16 style='width:12pt'></td>
  <td class=xl67 width=54 style='width:41pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=11 style='width:8pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=35 style='height:26.25pt'>
  <td height=35 style='height:26.25pt'></td>
  <td class=xl68 x:str="    "><span style='mso-spacerun:yes'>    </span></td>
  <td class=xl68></td>
  <td colspan=38 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl69 x:str="Update:"><span
  style='mso-spacerun:yes'> </span>Update:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl69 x:str="Update:"><span
  style='mso-spacerun:yes'> </span>Update:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl69></td>
  <td colspan=4 class=xl103 x:num="41302">28-Jan-2013</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 style='height:22.5pt'></td>
  <td colspan=5 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl69 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl69></td>
  <td class=xl70></td>
  <td colspan=9 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl69></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
  <td colspan=16 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl69></td>
  <td colspan=4 class=xl69 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=58 style='mso-height-source:userset;height:43.5pt'>
  <td height=58 style='height:43.5pt'></td>
  <td colspan=47 class=xl104 style='border-right:.5pt solid black'><span
  style='mso-spacerun:yes'>    </span>POSCO SS - VINA ORGANIZATION CHART</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl71 height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl71 style='height:28.5pt'></td>
  <td class=xl72 style='border-top:none' x:str="Dept."><span
  style='mso-spacerun:yes'> </span>Dept.<span style='mso-spacerun:yes'> </span></td>
  <td colspan=5 class=xl107 width=201 style='border-right:.5pt solid black;
  border-left:none;width:151pt' x:str="P &amp; F Dept."><span
  style='mso-spacerun:yes'> </span>P &amp; F Dept.<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=5 class=xl107 width=205 style='border-right:.5pt solid black;
  border-left:none;width:154pt' x:str="A &amp; S Dept."><span
  style='mso-spacerun:yes'> </span>A &amp; S Dept.<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=5 class=xl107 width=200 style='border-right:.5pt solid black;
  border-left:none;width:150pt' x:str="M Dept."><span
  style='mso-spacerun:yes'> </span>M Dept.<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=5 class=xl110 width=226 style='border-left:none;width:170pt'>PS
  Dept.</td>
  <td colspan=5 class=xl111 width=203 style='border-right:.5pt solid black;
  border-left:none;width:153pt'>R Dept.</td>
  <td colspan=5 class=xl110 width=213 style='border-left:none;width:160pt'>Q
  &amp; P Dept.</td>
  <td colspan=5 class=xl107 width=217 style='border-right:.5pt solid black;
  border-left:none;width:162pt' x:str="MS Dept."><span
  style='mso-spacerun:yes'> </span>MS Dept.<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=5 class=xl107 width=204 style='border-right:.5pt solid black;
  border-left:none;width:155pt' x:str="M &amp; E Dept."><span
  style='mso-spacerun:yes'> </span>M &amp; E Dept.<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=5 class=xl107 width=216 style='border-right:.5pt solid black;
  border-left:none;width:163pt' x:str="C &amp; A Dept."><span
  style='mso-spacerun:yes'> </span>C &amp; A Dept.<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl73 style='border-top:none;border-left:none' x:num>9</td>
  <td colspan=3 class=xl71 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl74 style='height:22.5pt'></td>
  <td class=xl75 style='border-top:none' x:str="I"><span
  style='mso-spacerun:yes'> </span>I<span style='mso-spacerun:yes'> </span></td>
  <td colspan=45 class=xl121 width=1885 style='border-right:.5pt solid black;
  width:1418pt'><span style='mso-spacerun:yes'> </span>KOREAN</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(AV7:AV10)">9</td>
  <td colspan=3 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl78 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td rowspan=3 height=57 class=xl114 style='height:42.75pt' x:num="1">&nbsp;</td>
  <td rowspan=3 class=xl94 width=54 style='border-top:none;width:41pt'
  x:str="General Director"><span style='mso-spacerun:yes'> </span>General
  Director<span style='mso-spacerun:yes'> </span></td>
  <td class=xl77 style='border-top:none' x:str="'000001">000001</td>
  <td class=xl77 style='border-top:none'>&nbsp;</td>
  <td colspan=43 class=xl116 width=1843 style='width:1386pt' x:str="RYU JU YEOL"><span
  style='mso-spacerun:yes'> </span>RYU JU YEOL<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl93 style='border-top:none' x:num>1</td>
  <td colspan=3 class=xl78 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl78 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl79 style='height:14.25pt'></td>
  <td colspan=3 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td class=xl81></td>
  <td colspan=4 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl82></td>
  <td colspan=8 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl79>Email:</td>
  <td class=xl79>Email:</td>
  <td colspan=4 class=xl82 width=203 style='width:153pt'
  x:str="'ryu3650@poscoss.com"><span
  style='mso-spacerun:yes'> </span>ryu3650@poscoss.com<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl81></td>
  <td colspan=17 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td class=xl79></td>
  <td colspan=3 class=xl78 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl78 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl79 style='height:14.25pt'></td>
  <td colspan=3 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td class=xl81></td>
  <td colspan=4 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl82></td>
  <td colspan=8 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl79>Phone:</td>
  <td class=xl79>Mobil:</td>
  <td colspan=2 class=xl82 width=114 style='width:86pt' x:str="'090 8880 745"><span
  style='mso-spacerun:yes'> </span>090 8880 745<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl84 width=11 style='width:8pt' x:str="'/"><span
  style='mso-spacerun:yes'> </span>/<span style='mso-spacerun:yes'> </span></td>
  <td class=xl80 width=78 style='width:59pt' x:str="'000"><span
  style='mso-spacerun:yes'> </span>000<span style='mso-spacerun:yes'> </span></td>
  <td class=xl81></td>
  <td colspan=17 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td class=xl79></td>
  <td colspan=3 class=xl78 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl78 height=57 style='mso-height-source:userset;height:42.75pt'>
  <td height=57 class=xl99 style='height:42.75pt' x:num>2</td>
  <td class=xl94 width=54 style='border-left:none;width:41pt'
  x:str="General Manager"><span style='mso-spacerun:yes'> </span>General
  Manager<span style='mso-spacerun:yes'> </span></td>
  <td class=xl95 style='border-left:none' x:str="'000002">000002</td>
  <td colspan=4 class=xl117 width=201 style='border-right:.5pt solid black;
  border-left:none;width:151pt'
  x:str="LEE YOUNG OK&#10;Email:&#10;Phone:00906.808.404             /      042"><span
  style='mso-spacerun:yes'> </span>LEE YOUNG OK<br>
    Email:<br>
    Phone:00906.808.404<span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span>042<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl97 style='border-left:none' x:str="'000003">000003</td>
  <td colspan=4 class=xl117 width=205 style='border-right:.5pt solid black;
  border-left:none;width:154pt'
  x:str="LEE YOUNG OK&#10;Email:&#10;Phone:00906.808.404             /      042"><span
  style='mso-spacerun:yes'> </span>LEE YOUNG OK<br>
    Email:<br>
    Phone:00906.808.404<span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span>042<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl98 style='border-left:none' x:str="'000006">000006</td>
  <td colspan=4 class=xl117 width=200 style='border-right:.5pt solid black;
  border-left:none;width:150pt'
  x:str="LEE YOUNG OK&#10;Email:&#10;Phone:00906.808.404             /      042"><span
  style='mso-spacerun:yes'> </span>LEE YOUNG OK<br>
    Email:<br>
    Phone:00906.808.404<span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span>042<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl98 style='border-left:none' x:str="'000007">000007</td>
  <td colspan=4 class=xl117 width=226 style='border-right:.5pt solid black;
  border-left:none;width:170pt'
  x:str="LEE YOUNG OK&#10;Email:&#10;Phone:00906.808.404             /      042"><span
  style='mso-spacerun:yes'> </span>LEE YOUNG OK<br>
    Email:<br>
    Phone:00906.808.404<span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span>042<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl98 style='border-left:none' x:str="'000004">000004</td>
  <td colspan=4 class=xl117 width=203 style='border-right:.5pt solid black;
  border-left:none;width:153pt'
  x:str="LEE YOUNG OK&#10;Email:&#10;Phone:00906.808.404             /      042"><span
  style='mso-spacerun:yes'> </span>LEE YOUNG OK<br>
    Email:<br>
    Phone:00906.808.404<span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span>042<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl98 style='border-left:none' x:str="'200490">200490</td>
  <td colspan=4 class=xl117 width=213 style='border-right:.5pt solid black;
  border-left:none;width:160pt'
  x:str="LEE YOUNG OK&#10;Email:&#10;Phone:00906.808.404             /      042"><span
  style='mso-spacerun:yes'> </span>LEE YOUNG OK<br>
    Email:<br>
    Phone:00906.808.404<span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span>042<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl98 style='border-left:none' x:str="'200535">200535</td>
  <td colspan=4 class=xl117 width=217 style='border-right:.5pt solid black;
  border-left:none;width:162pt'
  x:str="LEE YOUNG OK&#10;Email:&#10;Phone:00906.808.404             /      042"><span
  style='mso-spacerun:yes'> </span>LEE YOUNG OK<br>
    Email:<br>
    Phone:00906.808.404<span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span>042<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl95 style='border-left:none' x:str="'200546">200546</td>
  <td colspan=4 class=xl117 width=204 style='border-right:.5pt solid black;
  border-left:none;width:155pt'
  x:str="LEE YOUNG OK&#10;Email:&#10;Phone:00906.808.404             /      042"><span
  style='mso-spacerun:yes'> </span>LEE YOUNG OK<br>
    Email:<br>
    Phone:00906.808.404<span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span>042<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl96 width=0 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl117 width=216 style='border-right:.5pt solid black;
  border-left:none;width:163pt'
  x:str="LEE YOUNG OK&#10;Email:&#10;Phone:00906.808.404             /      042"><span
  style='mso-spacerun:yes'> </span>LEE YOUNG OK<br>
    Email:<br>
    Phone:00906.808.404<span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span>042<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl93 style='border-left:none' x:num>8</td>
  <td colspan=3 class=xl78 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl100 style='height:22.5pt;border-top:none'>&nbsp;</td>
  <td class=xl85 style='border-top:none;border-left:none' x:str="II"><span
  style='mso-spacerun:yes'> </span>II<span style='mso-spacerun:yes'> </span></td>
  <td colspan=45 class=xl102 width=1885 style='border-left:none;width:1418pt'><span
  style='mso-spacerun:yes'> </span>VIETNAMESE EMPLOYEES</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>0</td>
  <td colspan=3 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 
 <%
	int i=0;
	for(i=0;i<int.Parse(dt_max.Rows[0]["max_cnt"].ToString());i++)
	{
 %>
 <tr class=xl78 height=57 style='mso-height-source:userset;height:42.75pt'>
  <td height=57 class=xl99 style='height:42.75pt;border-top:none' x:num>2</td>
  <td class=xl94 width=54 style='border-top:none;border-left:none;width:41pt'
  x:str="General Manager"><span style='mso-spacerun:yes'> </span>General
  Manager<span style='mso-spacerun:yes'> </span></td>  
  <td class=xl95 style='border-top:none;border-left:none' x:str>000002</td>
  
  <td colspan=4 class=xl117 width=201 style='border-right:.5pt solid black;
  border-left:none;width:151pt'
  x:str>
  <%
	if(i<dt_1.Rows.Count)
	{
  %><%=dt_1.Rows[i]["c01"].ToString()%><br>
    Email:<%=dt_1.Rows[i]["c02"].ToString()%><br>
    Phone:<%=dt_1.Rows[i]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_1.Rows[i]["c04"].ToString()%>
  <%
	}
  %>
  </td>
  
  
  <td class=xl97 style='border-top:none;border-left:none' x:str>000003</td>
  <td colspan=4 class=xl117 width=205 style='border-right:.5pt solid black;
  border-left:none;width:154pt'
  x:str>
  <%
	if(i<dt_2.Rows.Count)
	{
  %><%=dt_2.Rows[i]["c01"].ToString()%><br>
    Email:<%=dt_2.Rows[i]["c02"].ToString()%><br>
    Phone:<%=dt_2.Rows[i]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_2.Rows[i]["c04"].ToString()%>
  <%
	}
  %>
  </td>
  <td class=xl98 style='border-top:none;border-left:none' x:str>000006</td>
  <td colspan=4 class=xl117 width=200 style='border-right:.5pt solid black;
  border-left:none;width:150pt' x:str>
  <%
	if(i<dt_3.Rows.Count)
	{
  %><%=dt_3.Rows[i]["c01"].ToString()%><br>
    Email:<%=dt_3.Rows[i]["c02"].ToString()%><br>
    Phone:<%=dt_3.Rows[i]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_3.Rows[i]["c04"].ToString()%>
  <%
	}
  %>
  </td>
  <td class=xl98 style='border-top:none;border-left:none' x:str>000007</td>
  <td colspan=4 class=xl117 width=226 style='border-right:.5pt solid black;
  border-left:none;width:170pt'
  x:str>
  <%
	if(i<dt_4.Rows.Count)
	{
  %><%=dt_4.Rows[i]["c01"].ToString()%><br>
    Email:<%=dt_4.Rows[i]["c02"].ToString()%><br>
    Phone:<%=dt_4.Rows[i]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_4.Rows[i]["c04"].ToString()%>
  <%
	}
  %>
  </td>
  <td class=xl98 style='border-top:none;border-left:none' x:str>000004</td>
  <%
	if(i<dt_5.Rows.Count)
	{
  %><%=dt_5.Rows[i]["c01"].ToString()%><br>
    Email:<%=dt_5.Rows[i]["c02"].ToString()%><br>
    Phone:<%=dt_5.Rows[i]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_5.Rows[i]["c04"].ToString()%>
  <%
	}
  %>
  </td>
  <td class=xl98 style='border-top:none;border-left:none' x:str>200490</td>
  <td colspan=4 class=xl117 width=213 style='border-right:.5pt solid black;
  border-left:none;width:160pt'
  x:str>
  <%
	if(i<dt_6.Rows.Count)
	{
  %><%=dt_6.Rows[i]["c01"].ToString()%><br>
    Email:<%=dt_6.Rows[i]["c02"].ToString()%><br>
    Phone:<%=dt_6.Rows[i]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_6.Rows[i]["c04"].ToString()%>
  <%
	}
  %>
  </td>
  <td class=xl98 style='border-top:none;border-left:none' x:str>200535</td>
  <td colspan=4 class=xl117 width=217 style='border-right:.5pt solid black;
  border-left:none;width:162pt'
  x:str>
  <%
	if(i<dt_7.Rows.Count)
	{
  %><%=dt_7.Rows[i]["c01"].ToString()%><br>
    Email:<%=dt_7.Rows[i]["c02"].ToString()%><br>
    Phone:<%=dt_7.Rows[i]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_7.Rows[i]["c04"].ToString()%>
  <%
	}
  %>
  </td>
  <td class=xl95 style='border-top:none;border-left:none' x:str>200546</td>
  <td colspan=4 class=xl117 width=204 style='border-right:.5pt solid black;
  border-left:none;width:155pt'
  x:str>
  <%
	if(i<dt_8.Rows.Count)
	{
  %><%=dt_8.Rows[i]["c01"].ToString()%><br>
    Email:<%=dt_8.Rows[i]["c02"].ToString()%><br>
    Phone:<%=dt_8.Rows[i]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_8.Rows[i]["c04"].ToString()%>
  <%
	}
  %>
  </td>
  <td class=xl96 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl117 width=216 style='border-right:.5pt solid black;
  border-left:none;width:163pt'
  x:str>
  <%
	if(i<dt_9.Rows.Count)
	{
  %><%=dt_9.Rows[i]["c01"].ToString()%><br>
    Email:<%=dt_9.Rows[i]["c02"].ToString()%><br>
    Phone:<%=dt_9.Rows[i]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_9.Rows[i]["c04"].ToString()%>
  <%
	}
  %>
  </td>
  <td class=xl93 style='border-top:none;border-left:none' x:num>0</td>
  <td colspan=3 class=xl78 style='mso-ignore:colspan'></td>
 </tr>
 
 
 
 <%
 }
 %>
 <tr class=xl86 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl101 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl87 width=54 style='border-top:none;border-left:none;width:41pt'
  x:str="Total:"><span style='mso-spacerun:yes'> </span>Total:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=5 class=xl92 style='border-left:none' x:num>7</td>
  <td colspan=5 class=xl92 style='border-left:none' x:num>11</td>
  <td colspan=5 class=xl92 style='border-left:none' x:num>5</td>
  <td colspan=5 class=xl92 style='border-left:none' x:num>5</td>
  <td colspan=5 class=xl92 style='border-left:none' x:num>5</td>
  <td colspan=5 class=xl92 style='border-left:none' x:num>2</td>
  <td class=xl92 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl92 style='border-left:none' x:num>3</td>
  <td class=xl92 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl92 style='border-left:none' x:num>5</td>
  <td colspan=5 class=xl92 style='border-left:none' x:num>10</td>
  <td class=xl88 style='border-top:none;border-left:none' x:num x:fmla="=AW13">9</td>
  <td class=xl86 x:num x:fmla="=AV6+AV11">9</td>
  <td colspan=2 class=xl86 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 style='height:18.75pt'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl67 colspan=7 style='mso-ignore:colspan'
  x:str="(*) General Director is counted in P &amp; F Dept."><span
  style='mso-spacerun:yes'> </span>(*) General Director is counted in P &amp; F
  Dept.<span style='mso-spacerun:yes'> </span></td>
  <td colspan=36 style='mso-ignore:colspan'></td>
  <td class=xl89 align=right x:num x:fmla="=SUM(C13:AU13)">53</td>
  <td colspan=2 class=xl90 style='mso-ignore:colspan'></td>
  <td class=xl71></td>
  <td class=xl91></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 style='height:27.0pt'></td>
  <td colspan=47 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
  <td class=xl91></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  
 </tr>
 <![endif]>
</table>

</body>

</html>
