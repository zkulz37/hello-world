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

    string p_user, p_tco_org_pk, p_org_type;
    string p_nation, p_search_temp, p_search_by,p_status;

    p_tco_org_pk = Request["l_tco_org_pk"].ToString();
    p_org_type = Request["l_org_type"].ToString();
    p_user = Request["l_user"].ToString();
    p_nation = Request["l_nation"].ToString();
    p_search_by = Request["l_search_by"].ToString();
    p_search_temp = Request["l_search_temp"].ToString();
    p_status = Request["l_staus"].ToString();
    
    string SQL
    = "select j.t1,j.t2,j.t3,j.t4,j.t5,j.t7,j.t8,to_char(to_date(max(j.part_leader_d),'YYYYMMDD'),'dd/MM/YYYY'),to_char(to_date(max(j.part_leader),'YYYYMMDD'),'dd/MM/YYYY') " +
        ",to_char(to_date(max(j.sup_d),'YYYYMMDD'),'dd/MM/YYYY'),to_char(to_date(max(j.sup),'YYYYMMDD'),'dd/MM/YYYY'),to_char(to_date(max(j.team_d),'YYYYMMDD'),'dd/MM/YYYY'),to_char(to_date(max(j.team),'YYYYMMDD'),'dd/MM/YYYY') " +
        "from( " +
        "select  (SELECT   MAX(T.ORG_NM)  " +
        "                    FROM COMM.TCO_ORG T  " +
        "                    WHERE T.DEL_IF = 0  " +
        "                    AND T.ORG_TYPE IN('06')  " +
        "                    START WITH T.PK=A.TCO_ORG_PK  " +
        "                    CONNECT BY PRIOR T.P_PK=T.PK) AS t1  " +
        " ,(SELECT   MAX(T.ORG_NM)  " +
        "                    FROM COMM.TCO_ORG T  " +
        "                    WHERE T.DEL_IF = 0  " +
        "                    AND T.ORG_TYPE IN('07','12')  " +
        "                    START WITH T.PK=A.TCO_ORG_PK  " +
        "                    CONNECT BY PRIOR T.P_PK=T.PK) AS t2 " +
        ",a.emp_id t3,a.FULL_NAME t4 " +
        ",to_char(to_date(a.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') t5  " +
        ",c1.seq t6                    " +
        ",c1.code_nm t7,c2.code_nm t8 " +
        ",decode(b.JOB_TITLE,'40',b.JOB_DT,null) part_leader_d " +
        ",decode(b.JOB_TITLE,'55',b.JOB_DT,null) part_leader " +
        ",decode(b.JOB_TITLE,'36',b.JOB_DT,null) sup_d " +
        ",decode(b.JOB_TITLE,'54',b.JOB_DT,null) sup " +
        ",decode(b.JOB_TITLE,'28',b.JOB_DT,'32',b.JOB_DT,null) team_d " +
        ",decode(b.JOB_TITLE,'20',b.JOB_DT,'53',b.JOB_DT,null) team " +
        "from thr_employee a,thr_band_job_posco b,comm.tco_org g " +
        ",(select v.seq,v.code,v.code_nm from vhr_hr_code v where v.id='HR0008') c1 " +
        ",(select v.seq,v.code,v.code_nm from vhr_hr_code v where v.id='HR0010') c2 " +
        "where a.del_if=0 and b.del_if=0 and g.del_if=0 and g.pk=a.tco_org_pk  " +
        "and a.POS_TYPE=c1.code and a.JOB_TYPE=c2.code " +
         "    AND UPPER(DECODE('" + p_search_by + "','1',a.EMP_ID,'2', a.ID_NUM,a.FULL_NAME)) LIKE '%' || UPPER ('" + p_search_temp + "') " +
        "    AND DECODE ('" + p_org_type + "', 'ALL', '" + p_org_type + "', g.org_type )='" + p_org_type + "' " +
        "    AND DECODE ('" + p_nation + "', 'ALL', '" + p_nation + "', a.nation )='" + p_nation + "' " +
        "    AND DECODE ('" + p_status + "', 'ALL', '" + p_status + "', a.status )='" + p_status + "' " +
        "    AND (    a.TCO_ORG_PK IN ( " +
        "                                  SELECT     m.PK " +
        "                                        FROM COMM.TCO_ORG m " +
        "                                       WHERE m.DEL_IF = 0 " +
        "                                  START WITH m.PK = " +
        "                                                DECODE ('" + p_tco_org_pk + "', " +
        "                                                        'ALL', 0, " +
        "                                                        '" + p_tco_org_pk + "' " +
        "                                                       ) " +
        "                                  CONNECT BY PRIOR m.PK = m.P_PK) " +
        "                            OR '" + p_tco_org_pk + "' = 'ALL') " +
        "and a.pk=b.thr_emp_pk) j " +
        
        "group by j.t1,j.t2,j.t3,j.t4,j.t5,j.t6,j.t7,j.t8 " +
        "order by j.t6 " ;
   // Response.Write(SQL);
   // Response.End();
DataTable dt_emp = ESysLib.TableReadOpen(SQL);
if (dt_emp.Rows.Count == 0)
{
    Response.Write("There is no data to show");
    Response.End();
}/**/
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="job_class_files/filelist.xml">
<link rel=Edit-Time-Data href="job_class_files/editdata.mso">
<link rel=OLE-Object-Data href="job_class_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>nhut_k</o:Author>
  <o:LastAuthor>nhut_k</o:LastAuthor>
  <o:LastPrinted>2010-10-21T02:04:01Z</o:LastPrinted>
  <o:Created>2010-10-21T01:53:27Z</o:Created>
  <o:LastSaved>2010-10-21T02:07:10Z</o:LastSaved>
  <o:Company>AS</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.1in .3in .1in .3in;
	mso-header-margin:.1in;
	mso-footer-margin:.1in;
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
	mso-font-charset:0;
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
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl31
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
	background:#FFFF99;
	mso-pattern:auto none;}
.xl32
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
	mso-pattern:auto none;}
.xl33
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
	background:#FF99CC;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl44
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl45
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl62
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl65
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:Scale>60</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:SplitVertical>5</x:SplitVertical>
     <x:LeftColumnRightPane>5</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
       <x:ActiveCol>0</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet2</x:Name>
    <x:WorksheetOptions>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>12525</x:WindowHeight>
  <x:WindowWidth>19035</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$4:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1039"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl35>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1563 style='border-collapse:
 collapse;table-layout:fixed;width:1173pt'>
 <col class=xl35 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl43 width=215 style='mso-width-source:userset;mso-width-alt:7862;
 width:161pt'>
 <col class=xl35 width=163 style='mso-width-source:userset;mso-width-alt:5961;
 width:122pt'>
 <col class=xl44 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl35 width=196 style='mso-width-source:userset;mso-width-alt:7168;
 width:147pt'>
 <col class=xl45 width=84 style='mso-width-source:userset;mso-width-alt:3072;
 width:63pt'>
 <col class=xl45 width=140 style='mso-width-source:userset;mso-width-alt:5120;
 width:105pt'>
 <col class=xl43 width=132 style='mso-width-source:userset;mso-width-alt:4827;
 width:99pt'>
 <col class=xl44 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl44 width=82 span=2 style='mso-width-source:userset;mso-width-alt:
 2998;width:62pt'>
 <col class=xl44 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl44 width=92 span=2 style='mso-width-source:userset;mso-width-alt:
 3364;width:69pt'>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=14 height=38 class=xl34 width=1563 style='height:28.5pt;
  width:1173pt'>LIST OF EMPLOYEES' JOB-TITLE</td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  270'>
  <td height=0 class=xl34></td>
  <td class=xl36></td>
  <td class=xl37></td>
  <td class=xl34></td>
  <td class=xl38></td>
  <td colspan=2 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl40></td>
  <td colspan=6 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl34 style='height:12.0pt'></td>
  <td class=xl40></td>
  <td class=xl38></td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl40></td>
  <td colspan=6 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl41 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td rowspan=2 height=61 class=xl46 style='height:45.75pt'>No.</td>
  <td rowspan=2 class=xl27>Department</td>
  <td rowspan=2 class=xl27>Team/Section</td>
  <td rowspan=2 class=xl27>Emp.Code</td>
  <td rowspan=2 class=xl27>Name</td>
  <td rowspan=2 class=xl26>Join Date</td>
  <td rowspan=2 class=xl27>Job Title</td>
  <td rowspan=2 class=xl27>Job Class</td>
  <td colspan=2 class=xl28 style='border-right:.5pt solid black'>Part Leader</td>
  <td colspan=2 class=xl47 style='border-right:.5pt solid black;border-left:
  none'>Supervisor</td>
  <td colspan=2 class=xl49 style='border-right:1.0pt solid black;border-left:
  none'>Team/Section Manager</td>
 </tr>
 <tr class=xl41 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl31 style='height:19.5pt;border-left:none'>Deputy</td>
  <td class=xl31 style='border-left:none'>Official</td>
  <td class=xl32 style='border-top:none;border-left:none'>Deputy</td>
  <td class=xl32 style='border-top:none;border-left:none'>Official</td>
  <td class=xl33 style='border-top:none;border-left:none'>Deputy</td>
  <td class=xl57 style='border-top:none;border-left:none'>Official</td>
 </tr>
 <% for(int i=0;i<dt_emp.Rows.Count;i++){%>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl65 style='height:16.5pt'><%=(i+1)%></td>
  <td class=xl58 style='border-left:none'><%=dt_emp.Rows[i][0].ToString()%></td>
  <td class=xl59 style='border-left:none'><%=dt_emp.Rows[i][1].ToString()%></td>
  <td class=xl60 style='border-left:none'><%=dt_emp.Rows[i][2].ToString()%></td>
  <td class=xl61 style='border-left:none'><%=dt_emp.Rows[i][3].ToString()%></td>
  <td class=xl62 style='border-left:none'><%=dt_emp.Rows[i][4].ToString()%></td>
  <td class=xl63 style='border-left:none'><%=dt_emp.Rows[i][5].ToString()%></td>
  <td class=xl58 style='border-left:none'><%=dt_emp.Rows[i][6].ToString()%></td>
  <td class=xl60 style='border-left:none'><%=dt_emp.Rows[i][7].ToString()%></td>
  <td class=xl60 style='border-left:none'><%=dt_emp.Rows[i][8].ToString()%></td>
  <td class=xl60 style='border-left:none'><%=dt_emp.Rows[i][9].ToString()%></td>
  <td class=xl60 style='border-left:none'><%=dt_emp.Rows[i][10].ToString()%></td>
  <td class=xl60 style='border-left:none'><%=dt_emp.Rows[i][11].ToString()%></td>
  <td class=xl64 style='border-left:none'><%=dt_emp.Rows[i][12].ToString()%></td>
 </tr>
 <%}%>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl51 style='height:15.0pt'>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl35 style='height:13.5pt'></td>
  <td class=xl43></td>
  <td class=xl35></td>
  <td class=xl44></td>
  <td class=xl35></td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
  <td class=xl43></td>
  <td colspan=6 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=47 style='width:35pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=163 style='width:122pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=196 style='width:147pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=140 style='width:105pt'></td>
  <td width=132 style='width:99pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=92 style='width:69pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
