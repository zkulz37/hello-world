<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% string p_date = Request["p_date"].ToString();
string p_month = Request["p_month"].ToString();
string p_report = Request["report"].ToString();
   string SQL1,SQL2,SQL3;
if(p_report=="true")
{
	SQL1= "select b.org_nm,c.PL_NM,c.PL_CD, " + 
   " SUM(nvl(CNC,0))+SUM(nvl(FILTER,0)) + SUM(nvl(HELPER,0)) + SUM(nvl(HELPER_PACK,0)) " + 
        " +SUM(nvl(PACKER_PACK,0)) + SUM(nvl(FOREMAN_PACK,0)) + SUM(nvl(ENGINEER_PACK,0))+ SUM(nvl(ENGINEER,0))+SUM(nvl(FOREMAN,0))  " +
        "      +SUM(nvl(ELECTRICIAN,0))+ SUM(nvl(CLEANER,0)) + SUM(nvl(STAFF,0)) +SUM(nvl(CLEANER_PACK,0))+SUM(nvl(DRIVER,0))+SUM(nvl(CHIEF,0))+SUM(nvl(MAINTAIN,0)) " +
        "      +SUM(nvl(OPERATOR,0))+SUM(nvl(TRUCK_DRIVER,0))+SUM(nvl(Blaster,0))+SUM(nvl(Painter,0))+SUM(nvl(WELDER,0)) " +
        "      +SUM(nvl(TEAM_LEADER,0))+ SUM(nvl(SECTION_CHEIF,0))+SUM(nvl(CRANE_HELPER,0)) as total     " +
        "                                 , SUM(nvl(CNC,0)) as cnc " +
        "                                ,SUM(nvl(FILTER,0))  AS FILTER  " +
        "                                ,SUM(nvl(HELPER,0))  AS HELPER  " +
        "                                ,SUM(nvl(HELPER_PACK,0))  AS HELPER_PACK " +
        "                                ,SUM(nvl(PACKER_PACK,0))  AS PACKER_PACK  " +
        "                               ,SUM(nvl(FOREMAN_PACK,0))  AS FOREMAN_PACK " +
        "                               ,SUM(nvl(ENGINEER_PACK,0)) AS ENGINEES_PACK " +
        "                               ,SUM(nvl(ENGINEER,0)) AS ENGINEES  " +
        "                               ,SUM(nvl(FOREMAN,0)) AS FOREMAN  " +
        "                               ,SUM(nvl(ELECTRICIAN,0)) AS ELECTRICIAN  " +
        "                               ,SUM(nvl(CLEANER,0)) AS CLEANER  " +
        "                               ,SUM(nvl(STAFF,0))  AS STAFF  " +
        "                               ,SUM(nvl(CLEANER_PACK,0)) AS CLEANER_PACK " +
        "                               ,SUM(nvl(DRIVER,0)) AS DRIVER  " +
        "                               ,SUM(nvl(CHIEF,0)) AS CHIEF  " +
        "                               ,SUM(nvl(MAINTAIN,0)) AS MAINTAIN  " +
        "                               ,SUM(nvl(OPERATOR,0)) AS OPERATOR  " +
        "                               ,SUM(nvl(TRUCK_DRIVER,0)) AS TRUCK_DRIVER  " +
        "                               ,SUM(nvl(Blaster,0)) AS Blaster  " +
        "                               ,SUM(nvl(Painter,0)) AS Painter  " +
        "                               ,SUM(nvl(WELDER,0))  AS WELDER  " +
        "                               ,SUM(nvl(TEAM_LEADER,0))  AS TEAM_LEADER   " +
        "                               ,SUM(nvl(SECTION_CHEIF,0))  AS SECTION_CHEIF   " +
        "                               ,SUM(nvl(CRANE_HELPER,0))  AS CRANE_HELPER " +
        "from thr_project_daily a,comm.tco_org b,ACNT.tac_abpl c  " +
        "where a.tco_org_pk=b.pk  " +
        "and a.del_if=0  " +
        "and b.del_if=0 " +
        "and a.PROJECT_PK=c.pk  " +
        "and c.del_if=0 " +
        "and a.DAILY_DATE='"+p_date+"' " +
        "group by b.org_nm,c.PL_NM,c.PL_CD " +
        "order by b.org_nm,c.PL_NM,c.PL_CD " ;
        
        

    SQL2
	= "select tb.org_nm,count (*) from  " + 
        " (select  " +
        " b.org_nm ,a.PROJECT_NAME,a.PROJECT_CODE " +
        "    FROM thr_project_daily a, comm.tco_org b ,acnt.tac_abpl c " +
        "   WHERE a.tco_org_pk = b.pk " +
        "     AND a.del_if = 0 " +
        "     AND b.del_if = 0 " +
        "     AND a.project_pk = c.pk " +
        "     AND c.del_if = 0 " +
        "     AND a.daily_date = '"+p_date+"' " +
        " GROUP BY b.org_nm, a.PROJECT_NAME,a.PROJECT_CODE " +
        " ) tb  " +
        " group by tb.org_nm " +
        " order by tb.org_nm " ;

   SQL3
	= "select  " + 
        "upper(to_char(sysdate,'dd-mon-yyyy')),upper(to_char((to_date('"+p_date+"','yyyymmdd')),'dd-mon-yyyy')), " +
        "c.PL_NM,c.PL_CD, " +
       " SUM(nvl(CNC,0)) as cnc " + 
        "                                ,SUM(nvl(FILTER,0))  AS FILTER  " +
        "                                ,SUM(nvl(HELPER,0))  AS HELPER  " +
        "                                ,SUM(nvl(HELPER_PACK,0))  AS HELPER_PACK " +
        "                                ,SUM(nvl(PACKER_PACK,0))  AS PACKER_PACK  " +
        "                               ,SUM(nvl(FOREMAN_PACK,0))  AS FOREMAN_PACK " +
        "                               ,SUM(nvl(ENGINEER_PACK,0)) AS ENGINEES_PACK " +
        "                               ,SUM(nvl(ENGINEER,0)) AS ENGINEES  " +
        "                               ,SUM(nvl(FOREMAN,0)) AS FOREMAN  " +
        "                               ,SUM(nvl(ELECTRICIAN,0)) AS ELECTRICIAN  " +
        "                               ,SUM(nvl(CLEANER,0)) AS CLEANER  " +
        "                               ,SUM(nvl(STAFF,0))  AS STAFF  " +
        "                               ,SUM(nvl(CLEANER_PACK,0)) AS CLEANER_PACK " +
        "                               ,SUM(nvl(DRIVER,0)) AS DRIVER  " +
        "                               ,SUM(nvl(CHIEF,0)) AS CHIEF  " +
        "                               ,SUM(nvl(MAINTAIN,0)) AS MAINTAIN  " +
        "                               ,SUM(nvl(OPERATOR,0)) AS OPERATOR  " +
        "                               ,SUM(nvl(TRUCK_DRIVER,0)) AS TRUCK_DRIVER  " +
        "                               ,SUM(nvl(Blaster,0)) AS Blaster  " +
        "                               ,SUM(nvl(Painter,0)) AS Painter  " +
        "                               ,SUM(nvl(WELDER,0))  AS WELDER  " +
        "                               ,SUM(nvl(TEAM_LEADER,0))  AS TEAM_LEADER   " +
        "                               ,SUM(nvl(SECTION_CHEIF,0))  AS SECTION_CHEIF   " +
        "                               ,SUM(nvl(CRANE_HELPER,0))  AS CRANE_HELPER " +
        " from thr_project_daily a,comm.tco_org b,ACNT.tac_abpl c  " +
        "where a.tco_org_pk=b.pk  " +
        "and a.del_if=0  " +
        "and b.del_if=0 " +
        "and a.PROJECT_PK=c.pk  " +
        "and c.del_if=0 " +
        "and a.DAILY_DATE='"+p_date+"' " +
        "group by c.PL_NM,c.PL_CD " +
        "order by c.PL_NM,c.PL_CD " ;
}
else
{	SQL1= "select b.org_nm,c.PL_NM,c.PL_CD, " + 
   " SUM(nvl(CNC,0))+SUM(nvl(FILTER,0)) + SUM(nvl(HELPER,0)) + SUM(nvl(HELPER_PACK,0)) " + 
        " +SUM(nvl(PACKER_PACK,0)) + SUM(nvl(FOREMAN_PACK,0)) + SUM(nvl(ENGINEER_PACK,0))+ SUM(nvl(ENGINEER,0))+SUM(nvl(FOREMAN,0))  " +
        "      +SUM(nvl(ELECTRICIAN,0))+ SUM(nvl(CLEANER,0)) + SUM(nvl(STAFF,0)) +SUM(nvl(CLEANER_PACK,0))+SUM(nvl(DRIVER,0))+SUM(nvl(CHIEF,0))+SUM(nvl(MAINTAIN,0)) " +
        "      +SUM(nvl(OPERATOR,0))+SUM(nvl(TRUCK_DRIVER,0))+SUM(nvl(Blaster,0))+SUM(nvl(Painter,0))+SUM(nvl(WELDER,0)) " +
        "      +SUM(nvl(TEAM_LEADER,0))+ SUM(nvl(SECTION_CHEIF,0))+SUM(nvl(CRANE_HELPER,0)) as total     " +
        "                                 , SUM(nvl(CNC,0)) as cnc " +
        "                                ,SUM(nvl(FILTER,0))  AS FILTER  " +
        "                                ,SUM(nvl(HELPER,0))  AS HELPER  " +
        "                                ,SUM(nvl(HELPER_PACK,0))  AS HELPER_PACK " +
        "                                ,SUM(nvl(PACKER_PACK,0))  AS PACKER_PACK  " +
        "                               ,SUM(nvl(FOREMAN_PACK,0))  AS FOREMAN_PACK " +
        "                               ,SUM(nvl(ENGINEER_PACK,0)) AS ENGINEES_PACK " +
        "                               ,SUM(nvl(ENGINEER,0)) AS ENGINEES  " +
        "                               ,SUM(nvl(FOREMAN,0)) AS FOREMAN  " +
        "                               ,SUM(nvl(ELECTRICIAN,0)) AS ELECTRICIAN  " +
        "                               ,SUM(nvl(CLEANER,0)) AS CLEANER  " +
        "                               ,SUM(nvl(STAFF,0))  AS STAFF  " +
        "                               ,SUM(nvl(CLEANER_PACK,0)) AS CLEANER_PACK " +
        "                               ,SUM(nvl(DRIVER,0)) AS DRIVER  " +
        "                               ,SUM(nvl(CHIEF,0)) AS CHIEF  " +
        "                               ,SUM(nvl(MAINTAIN,0)) AS MAINTAIN  " +
        "                               ,SUM(nvl(OPERATOR,0)) AS OPERATOR  " +
        "                               ,SUM(nvl(TRUCK_DRIVER,0)) AS TRUCK_DRIVER  " +
        "                               ,SUM(nvl(Blaster,0)) AS Blaster  " +
        "                               ,SUM(nvl(Painter,0)) AS Painter  " +
        "                               ,SUM(nvl(WELDER,0))  AS WELDER  " +
        "                               ,SUM(nvl(TEAM_LEADER,0))  AS TEAM_LEADER   " +
        "                               ,SUM(nvl(SECTION_CHEIF,0))  AS SECTION_CHEIF   " +
        "                               ,SUM(nvl(CRANE_HELPER,0))  AS CRANE_HELPER " +
        "from thr_project_daily a,comm.tco_org b,ACNT.tac_abpl c  " +
        "where a.tco_org_pk=b.pk  " +
        "and a.del_if=0  " +
        "and b.del_if=0 " +
        "and a.PROJECT_PK=c.pk  " +
        "and c.del_if=0 " +
        "and a.DAILY_DATE between ('"+p_month+"'||'16') and (to_char(add_months(to_date('"+p_month+"','YYYYMM'),1),'YYYYMM')||'15') " +
        "group by b.org_nm,c.PL_NM,c.PL_CD " +
        "order by b.org_nm,c.PL_NM,c.PL_CD " ;
        
        

    SQL2
	= "select tb.org_nm,count (*) from  " + 
        " (select  " +
        " b.org_nm ,a.PROJECT_NAME,a.PROJECT_CODE " +
        "    FROM thr_project_daily a, comm.tco_org b ,acnt.tac_abpl c " +
        "   WHERE a.tco_org_pk = b.pk " +
        "     AND a.del_if = 0 " +
        "     AND b.del_if = 0 " +
        "     AND a.project_pk = c.pk " +
        "     AND c.del_if = 0 " +
        "     AND a.daily_date between ('"+p_month+"'||'16') and (to_char(add_months(to_date('"+p_month+"','YYYYMM'),1),'YYYYMM')||'15') " +
        " GROUP BY b.org_nm, a.PROJECT_NAME,a.PROJECT_CODE " +
        " ) tb  " +
        " group by tb.org_nm " +
        " order by tb.org_nm " ;

   SQL3
	= "select  " + 
        "upper(to_char(sysdate,'dd-mon-yyyy')),upper(to_char((to_date('"+p_date+"','yyyymmdd')),'dd-mon-yyyy')), " +
        "c.PL_NM,c.PL_CD, " +
       " SUM(nvl(CNC,0)) as cnc " + 
        "                                ,SUM(nvl(FILTER,0))  AS FILTER  " +
        "                                ,SUM(nvl(HELPER,0))  AS HELPER  " +
        "                                ,SUM(nvl(HELPER_PACK,0))  AS HELPER_PACK " +
        "                                ,SUM(nvl(PACKER_PACK,0))  AS PACKER_PACK  " +
        "                               ,SUM(nvl(FOREMAN_PACK,0))  AS FOREMAN_PACK " +
        "                               ,SUM(nvl(ENGINEER_PACK,0)) AS ENGINEES_PACK " +
        "                               ,SUM(nvl(ENGINEER,0)) AS ENGINEES  " +
        "                               ,SUM(nvl(FOREMAN,0)) AS FOREMAN  " +
        "                               ,SUM(nvl(ELECTRICIAN,0)) AS ELECTRICIAN  " +
        "                               ,SUM(nvl(CLEANER,0)) AS CLEANER  " +
        "                               ,SUM(nvl(STAFF,0))  AS STAFF  " +
        "                               ,SUM(nvl(CLEANER_PACK,0)) AS CLEANER_PACK " +
        "                               ,SUM(nvl(DRIVER,0)) AS DRIVER  " +
        "                               ,SUM(nvl(CHIEF,0)) AS CHIEF  " +
        "                               ,SUM(nvl(MAINTAIN,0)) AS MAINTAIN  " +
        "                               ,SUM(nvl(OPERATOR,0)) AS OPERATOR  " +
        "                               ,SUM(nvl(TRUCK_DRIVER,0)) AS TRUCK_DRIVER  " +
        "                               ,SUM(nvl(Blaster,0)) AS Blaster  " +
        "                               ,SUM(nvl(Painter,0)) AS Painter  " +
        "                               ,SUM(nvl(WELDER,0))  AS WELDER  " +
        "                               ,SUM(nvl(TEAM_LEADER,0))  AS TEAM_LEADER   " +
        "                               ,SUM(nvl(SECTION_CHEIF,0))  AS SECTION_CHEIF   " +
        "                               ,SUM(nvl(CRANE_HELPER,0))  AS CRANE_HELPER " +
        " from thr_project_daily a,comm.tco_org b,ACNT.tac_abpl c  " +
        "where a.tco_org_pk=b.pk  " +
        "and a.del_if=0  " +
        "and b.del_if=0 " +
        "and a.PROJECT_PK=c.pk  " +
        "and c.del_if=0 " +
        "and a.DAILY_DATE between ('"+p_month+"'||'16') and (to_char(add_months(to_date('"+p_month+"','YYYYMM'),1),'YYYYMM')||'15') " +
        "group by c.PL_NM,c.PL_CD " +
        "order by c.PL_NM,c.PL_CD " ;
}

// Response.Write(SQL2);
  //      Response.End();
DataTable detail = ESysLib.TableReadOpen(SQL1);
    int irow;
    irow = detail.Rows.Count;
    if (irow == 0)
    {   Response.Write("There is no data");
        Response.End();
    }
    DataTable CountRow = ESysLib.TableReadOpen(SQL2);
    DataTable total = ESysLib.TableReadOpen(SQL3);

 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_Emp_Daily_Project_status_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_Emp_Daily_Project_status_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_Emp_Daily_Project_status_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Genu Test</o:LastAuthor>
  <o:LastPrinted>2009-10-01T09:10:25Z</o:LastPrinted>
  <o:Created>2008-12-08T05:43:30Z</o:Created>
  <o:LastSaved>2009-10-01T09:34:31Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.20in .25in .20in .25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}
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
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:129;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:black none;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:black none;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:black none;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:black none;}
.xl35
	{mso-style-parent:style0;
	color:blue;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:black none;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:black none;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:black none;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:black none;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:black none;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:black none;}
.xl43
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:black none;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:black none;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:black none;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:black none;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:black none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>27 11</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>49</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:DoNotDisplayGridlines/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
       <x:RangeSelection>$A$7:$A$8</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>-3165</x:WindowTopX>
  <x:WindowTopY>0</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='27 11'!$1:$6</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1891 style='border-collapse:
 collapse;table-layout:fixed;width:1419pt'>
 <col class=xl24 width=216 style='mso-width-source:userset;mso-width-alt:7899;
 width:162pt'>
 <col class=xl24 width=428 style='mso-width-source:userset;mso-width-alt:15652;
 width:321pt'>
 <col class=xl24 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl25 width=57 style='mso-width-source:userset;mso-width-alt:2084;
 width:43pt'>
 <col class=xl24 width=107 span=26 style='mso-width-source:userset;mso-width-alt:
 3913;width:80pt'>
 
 <tr height=17 style='height:12.75pt'>
  <td colspan=20 rowspan=2 height=34 class=xl35 width=1891 style='height:25.5pt;
  width:1419pt' x:str ><%=(p_month=="true")?"REPORT DAILY PROJECT":"REPORT MONTHLY PROJECT" %><span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl25>Report date:</td>
  <td class=xl26 ></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'><%=total.Rows[0][0].ToString()%></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl36 style='height:12.75pt'><%=(p_report=="true")? ("Date :" + total.Rows[0][1].ToString()):("Month :"+p_month.Substring(4,2)+"/"+p_month.Substring(0,4)) %></td>
  <td class=xl24></td>
  <td colspan=12 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td rowspan=2 height=64 class=xl37 style='border-bottom:.5pt solid black;
  height:48.0pt;border-top:none'>TEAM</td>
  <td colspan=2 class=xl41 style='border-right:.5pt solid black;border-left:
  none' x:str="PROJECT ">PROJECT<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black'>TOTAL</td>
  <td colspan=24 class=xl41 style='border-right:.5pt solid black;border-left:
  none'>FABRICATION</td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl49 style='height:24.0pt;border-top:none;border-left:
  none'>PROJECT NAME</td>
  <td class=xl27>CODE</td>
  <%String [] col_name= new String[24]{"CNC","Filter","Helpper","Helpper Pack","Packer Pack","Foreman Pack","Engineer Pack","Engineers ","Foreman","Electrician","Clearner","Staff","Clearner Pack","Driver","Chief","Maintain","Operator","Truck Driver","Blaster","Painter","welder","Team Leader","Sectoin Cheif","Crane Helper"}; 
  for(int i=0;i<24;i++)
  { %>
     <td class=xl28><%=col_name[i]%></td>
     <%} %>
 </tr>
 <% Int32 []sum=new Int32[32];
 for(int i=0;i<detail.Rows.Count;i++) {%>
 <tr height=25 style='mso-height-source:userset;height:19.15pt'>
  
  <% if(i>0&&detail.Rows[i][0].ToString()!=detail.Rows[i-1][0].ToString())
    {for (int j=0;j<CountRow.Rows.Count;j++)
    if(CountRow.Rows[j][0].ToString()==detail.Rows[i][0].ToString()){
     for(int m=0;m<32;m++) sum[m]=0;
     %>
  <td 
  rowspan=<%=int.Parse(CountRow.Rows[j][1].ToString())+1%> height=50 class=xl43 style='border-bottom:.5pt solid black;
  height:38.3pt;border-top:none'><%=detail.Rows[i][0].ToString()%></td><%break;}%>
  <%}else if(i==0)
    {for (int j=0;j<CountRow.Rows.Count;j++)
    if(CountRow.Rows[j][0].ToString()==detail.Rows[i][0].ToString()){
     for(int m=0;m<32;m++) sum[m]=0;
     %>
  <td 
  rowspan=<%=int.Parse(CountRow.Rows[j][1].ToString())+1%> height=50 class=xl43 style='border-bottom:.5pt solid black;
  height:38.3pt;border-top:none'><%=detail.Rows[i][0].ToString()%></td><%break;}}%>
  
 <%for(int m=4;m<28;m++) sum[m]=sum[m]+int.Parse(detail.Rows[i][m].ToString()); 
 %>
 
  <td class=xl30 ><%=detail.Rows[i][1].ToString()%></td>
  <td class=xl30 ><%=detail.Rows[i][2].ToString()%> </td>
 <%for(int m=3;m<28;m++) {%>
  <td class=xl30 x:num=""><%=detail.Rows[i][m].ToString()%> </td>
  <%} %>
  </tr>
<%
 if(i<detail.Rows.Count-1)
 if(detail.Rows[i][0].ToString()!=detail.Rows[i+1][0].ToString())
 {%>

  <tr height=25 style='mso-height-source:userset;height:19.15pt'>
  <td colspan=2 height=25 class=xl45 style='border-right:.5pt solid black;
  height:19.15pt;border-left:none'>TOTAL</td>
  <td class=xl31 x:num=""></td>
 <%for(int m=4;m<28;m++) {%>
   <td class=xl31 x:num=""><%=sum[m] %></td>
  <%} %>
 
 </tr>
 
 <%}%>
 <%
 if(i==detail.Rows.Count-1)
  {%>

 
  <tr height=25 style='mso-height-source:userset;height:19.15pt'>
  <td colspan=2 height=25 class=xl45 style='border-right:.5pt solid black;
  height:19.15pt;border-left:none'>TOTAL</td>
  <td class=xl31 x:num=""></td>
 <%for(int m=4;m<28;m++) {%>
   <td class=xl31 x:num=""><%=sum[m] %></td>
  <%} %>
 </tr>
 
 <% }%>

 
 
 <%
 
 }%>
 <%sum[1]=0;
 for(int j=0;j<total.Rows.Count;j++) {%>
 <tr height=25 style='mso-height-source:userset;height:19.15pt'>
  <%if(j==0)
  { for(int m=4;m<28;m++)sum[m]=0;
  
  %>
    <td height=25  rowspan=<%=total.Rows.Count %> class=xl32 style='height:19.15pt'>TOTAL</td>
  <%} %>

  <% sum[0]=0;
  for(int m=4;m<28;m++){ sum[m]=sum[m]+int.Parse(total.Rows[j][m].ToString());
        sum[0]+=int.Parse(total.Rows[j][m].ToString());
        }sum[1]+=sum[0]; 
 %>
  <td class=xl30 ><%=total.Rows[j][2].ToString() %> </td>
  <td class=xl30 ><%=total.Rows[j][3].ToString() %></td>
   <td class=xl30 x:num=""><%=sum[0] %></td>
  <%for(int m=4;m<28;m++) {%>
   <td class=xl30 x:num=""><%=total.Rows[j][m].ToString() %></td>
  <%} %>
 
 </tr>
 <%} %>
   
 
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=2 height=27 class=xl45 style='border-right:.5pt solid black;
  height:20.25pt'>GRAND TOTAL</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33 x:num="" ><%=sum[1] %></td>
  <%for(int m=4;m<28;m++) {%>
  <td class=xl34 x:num=""><%=sum[m] %> </td>
  <%} %>
  </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=216 style='width:162pt'></td>
  <td width=428 style='width:321pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=36 style='width:27pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=107 style='width:80pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
