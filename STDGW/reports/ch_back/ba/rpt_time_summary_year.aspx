<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
     string p_user,p_tco_org_pk,p_wg,p_year,p_search_by;
    string p_search_temp,p_search_ot,p_ot,p_nation;
     
 
    p_tco_org_pk       = Request["p_tco_org_pk"].ToString();
    p_wg      = Request["p_wg"].ToString();
    p_year              = Request["p_year"].ToString();
    p_search_by         = Request["p_search_by"].ToString();
    p_search_temp       = Request["p_search_temp"].ToString();
    p_search_ot         = Request["p_search_ot"].ToString();
    p_ot                = Request["p_ot"].ToString();
    p_user                = Request["p_user"].ToString();
	p_nation          = Request["p_nation"].ToString();
    string SQL
	= " SELECT to_char(sysdate,'dd/mm/yyyy'),PR_OT.ORG_NM,PR_OT.WGROUP_NM,PR_OT.EMP_ID,PR_OT.FULL_NAME " + 
        "        ,TO_CHAR(TO_DATE(PR_OT.JOIN_DT,'YYYYMMDD'),'DD/MM/YYYY') " +
        "        ,DECODE(PR_OT.T1,0,'',PR_OT.T1) " +
        "        ,DECODE(PR_OT.T2,0,'',PR_OT.T2) " +
        "        ,DECODE(PR_OT.T3,0,'',PR_OT.T3) " +
        "        ,DECODE(PR_OT.T4,0,'',PR_OT.T4) " +
        "        ,DECODE(PR_OT.T5,0,'',PR_OT.T5) " +
        "        ,DECODE(PR_OT.T6,0,'',PR_OT.T6) " +
        "        ,DECODE(PR_OT.T7,0,'',PR_OT.T7) " +
        "        ,DECODE(PR_OT.T8,0,'',PR_OT.T8) " +
        "        ,DECODE(PR_OT.T9,0,'',PR_OT.T9) " +
        "        ,DECODE(PR_OT.T10,0,'',PR_OT.T10) " +
        "        ,DECODE(PR_OT.T11,0,'',PR_OT.T11) " +
        "        ,DECODE(PR_OT.T12,0,'',PR_OT.T12) " +
        "        ,PR_OT.T1+PR_OT.T2+PR_OT.T3+PR_OT.T4+PR_OT.T5 " +
        "         +PR_OT.T6+PR_OT.T7+PR_OT.T8+PR_OT.T9+PR_OT.T10+PR_OT.T11+PR_OT.T12 AS TOTAL " +
        "        FROM( " +
        "        SELECT D.ORG_NM AS ORG_NM,B.WORKGROUP_NM AS WGROUP_NM,V.EMP_ID AS EMP_ID,V.FULL_NAME AS FULL_NAME,V.JOIN_DT AS JOIN_DT, V.PK as PK " +
        "        ,SUM(DECODE(SUBSTR(A.WORK_DT,5,2),'01',NVL(A.OT_TIME,0),0)) AS T1 " +
        "        ,SUM(DECODE(SUBSTR(A.WORK_DT,5,2),'02',NVL(A.OT_TIME,0),0)) AS T2 " +
        "        ,SUM(DECODE(SUBSTR(A.WORK_DT,5,2),'03',NVL(A.OT_TIME,0),0)) AS T3 " +
        "        ,SUM(DECODE(SUBSTR(A.WORK_DT,5,2),'04',NVL(A.OT_TIME,0),0)) AS T4 " +
        "        ,SUM(DECODE(SUBSTR(A.WORK_DT,5,2),'05',NVL(A.OT_TIME,0),0)) AS T5 " +
        "        ,SUM(DECODE(SUBSTR(A.WORK_DT,5,2),'06',NVL(A.OT_TIME,0),0)) AS T6 " +
        "        ,SUM(DECODE(SUBSTR(A.WORK_DT,5,2),'07',NVL(A.OT_TIME,0),0)) AS T7 " +
        "        ,SUM(DECODE(SUBSTR(A.WORK_DT,5,2),'08',NVL(A.OT_TIME,0),0)) AS T8 " +
        "        ,SUM(DECODE(SUBSTR(A.WORK_DT,5,2),'09',NVL(A.OT_TIME,0),0)) AS T9 " +
        "        ,SUM(DECODE(SUBSTR(A.WORK_DT,5,2),'10',NVL(A.OT_TIME,0),0)) AS T10 " +
        "        ,SUM(DECODE(SUBSTR(A.WORK_DT,5,2),'11',NVL(A.OT_TIME,0),0)) AS T11 " +
        "        ,SUM(DECODE(SUBSTR(A.WORK_DT,5,2),'12',NVL(A.OT_TIME,0),0))  AS T12 " +
        "        FROM THR_EXTRA_TIME A,THR_EMPLOYEE V,THR_WORK_GROUP B,tco_org D " +
        "        WHERE A.DEL_IF=0 AND V.DEL_IF=0 AND B.DEL_IF=0 AND A.OT_TYPE NOT IN ('NT','NT2') AND D.DEL_IF=0  " +
        "         AND A.THR_EMP_PK=V.PK AND V.THR_WG_PK=B.PK AND V.TCO_ORG_PK=D.PK " +
        "         AND SUBSTR(A.WORK_DT,1,4)='" + p_year + "' " +
		"            AND DECODE('" + p_nation + "' ,'ALL', '" + p_nation + "',v.nation) =  '" + p_nation  + "'" +
        "         AND DECODE('" + p_wg + "' ,'ALL','ALL',B.PK) = '" + p_wg + "'  " ;
        SQL = SQL + "                   AND (    V.TCO_ORG_PK IN ( ";
        SQL = SQL + "                       SELECT     G.PK ";
        SQL = SQL + "                             FROM TCO_ORG G ";
        SQL = SQL + "                            WHERE G.DEL_IF = 0           ";                           
        SQL = SQL + "                       START WITH G.PK = ";
        SQL = SQL + "                                     DECODE ('"+p_tco_org_pk+"', ";
        SQL = SQL + "                                             'ALL', 0, ";
        SQL = SQL + "                                             '"+p_tco_org_pk+"' ";
        SQL = SQL + "                                            ) ";
        SQL = SQL + "                       CONNECT BY PRIOR G.PK = G.P_PK) ";
        SQL = SQL + "                 OR '"+p_tco_org_pk+"' = 'ALL') "+
        "            AND (DECODE('" + p_search_by + "' ,'1',UPPER(V.EMP_ID),'2',V.ID_NUM,'3',UPPER(V.FULL_NAME)) LIKE '%'||UPPER('" + p_search_temp + "' ) " +
        "                        OR '" + p_search_temp + "'  IS NULL) " +
        "          " +
        "        GROUP BY D.ORG_NM,B.WORKGROUP_NM,V.EMP_ID,V.FULL_NAME,V.JOIN_DT,V.PK  " +
        "        HAVING ((SUM(NVL(A.OT_TIME,0))>=nvl('" + p_ot + "' ,0) AND '" + p_search_ot + "' =1) OR (SUM(NVL(A.OT_TIME,0)) < nvl('" + p_ot + "' ,0) AND '" + p_search_ot + "'  =2)) " +
        "        ORDER BY d.org_nm,B.WORKGROUP_NM,V.EMP_ID " +
        "        )PR_OT " ;

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
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_time_summary_year_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_time_summary_year_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_time_summary_year_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>ty-ml</o:LastAuthor>
  <o:LastPrinted>2008-07-24T06:33:21Z</o:LastPrinted>
  <o:Created>2008-05-26T09:13:46Z</o:Created>
  <o:LastSaved>2008-07-24T06:49:06Z</o:LastSaved>
  <o:Company>genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.3in .16in .6in .28in;
	mso-header-margin:.16in;
	mso-footer-margin:.41in;
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
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl30
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$-1010000\]d\/m\/yyyy\;\@";}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$-1010000\]d\/m\/yyyy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$-1010000\]d\/m\/yyyy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$-1010000\]d\/m\/yyyy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$-1010000\]d\/m\/yyyy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
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
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>74</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>7</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
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
  <x:WindowHeight>7680</x:WindowHeight>
  <x:WindowWidth>14955</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>330</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1512 style='border-collapse:
 collapse;table-layout:fixed;width:1140pt'>
 <col class=xl25 width=36 style='mso-width-source:userset;mso-width-alt:1316;
 width:27pt'>
 <col class=xl25 width=125 style='mso-width-source:userset;mso-width-alt:4571;
 width:94pt'>
 <col class=xl25 width=132 style='mso-width-source:userset;mso-width-alt:4827;
 width:99pt'>
 <col class=xl25 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl29 width=211 style='mso-width-source:userset;mso-width-alt:7716;
 width:158pt'>
 <col class=xl30 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl25 width=54 span=12 style='mso-width-source:userset;mso-width-alt:
 1974;width:41pt'>
 <col class=xl25 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl25 width=64 span=2 style='width:48pt'>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=18 height=28 class=xl54 width=1306 style='height:21.0pt;
  width:985pt'>OVERTIME SUMMARY IN YEAR <%=p_year %></td>
  <td class=xl33 width=78 style='width:59pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=13 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'>Reporter</td>
  <td class=xl25></td>
  <td colspan=2 class=xl34><%=p_user %></td>
  <td class=xl34></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=13 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'>Report Date</td>
  <td class=xl25></td>
  <td colspan=2 class=xl35 x:num><%= dt_total.Rows[0][0].ToString() %></td>
  <td class=xl35></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=4 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 class=xl46 width=36 style='height:24.75pt;width:27pt'>No</td>
  <td class=xl47 width=125 style='width:94pt'>Organization</td>
  <td class=xl47 width=132 style='width:99pt'>Work Group</td>
  <td class=xl47 width=75 style='width:56pt'>Emp ID</td>
  <td class=xl48 width=211 style='width:158pt'>Full Name</td>
  <td class=xl49 width=79 style='width:59pt'>Join_Date</td>
  <td class=xl47 width=54 style='width:41pt'>JAN</td>
  <td class=xl47 width=54 style='width:41pt'>FEB</td>
  <td class=xl47 width=54 style='width:41pt'>MAR</td>
  <td class=xl47 width=54 style='width:41pt'>APR</td>
  <td class=xl47 width=54 style='width:41pt'>MAY</td>
  <td class=xl47 width=54 style='width:41pt'>JUN</td>
  <td class=xl47 width=54 style='width:41pt'>JUL</td>
  <td class=xl47 width=54 style='width:41pt'>AUG</td>
  <td class=xl47 width=54 style='width:41pt'>SEP</td>
  <td class=xl47 width=54 style='width:41pt'>OCT</td>
  <td class=xl47 width=54 style='width:41pt'>NOV</td>
  <td class=xl47 width=54 style='width:41pt'>DEC</td>
  <td class=xl47 width=78 style='width:59pt'>Total</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 class=xl50 width=36 style='height:24.75pt;border-top:none;
  width:27pt'>STT</td>
  <td class=xl51 width=125 style='border-top:none;width:94pt'>B&#7897;
  ph&#7853;n</td>
  <td class=xl51 width=132 style='border-top:none;width:99pt'>Nhóm</td>
  <td class=xl51 width=75 style='border-top:none;width:56pt'>Mã NV</td>
  <td class=xl52 width=211 style='border-top:none;width:158pt'>H&#7885; và tên
  NV</td>
  <td class=xl53 width=79 style='border-top:none;width:59pt'>Ngày vào</td>
  <td class=xl51 width=54 style='border-top:none;width:41pt' x:num>1</td>
  <td class=xl51 width=54 style='border-top:none;width:41pt' x:num>2</td>
  <td class=xl51 width=54 style='border-top:none;width:41pt' x:num>3</td>
  <td class=xl51 width=54 style='border-top:none;width:41pt' x:num>4</td>
  <td class=xl51 width=54 style='border-top:none;width:41pt' x:num>5</td>
  <td class=xl51 width=54 style='border-top:none;width:41pt' x:num>6</td>
  <td class=xl51 width=54 style='border-top:none;width:41pt' x:num>7</td>
  <td class=xl51 width=54 style='border-top:none;width:41pt' x:num>8</td>
  <td class=xl51 width=54 style='border-top:none;width:41pt' x:num>9</td>
  <td class=xl51 width=54 style='border-top:none;width:41pt' x:num>10</td>
  <td class=xl51 width=54 style='border-top:none;width:41pt' x:num>11</td>
  <td class=xl51 width=54 style='border-top:none;width:41pt' x:num>12</td>
  <td class=xl51 width=78 style='border-top:none;width:59pt'>T&#7893;ng
  c&#7897;ng</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <% 
     string s_format;
     for (int i = 0; i < irow; i++) 
    {
        if (i == irow - 1)
            s_format = ";border-bottom:.5pt solid windowtext";
        else
            s_format = ";";
    %> 
 <tr class=xl31 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl36 width=36 style='height:22.5pt;border-top:none;
  width:27pt<%=s_format%>' x:num><%=i+1%></td>
  <td class=xl38 width=125 style='mso-text-control:shrinktofit;;border-top:none;width:94pt<%=s_format%>'><% = dt_total.Rows[i][1].ToString()%></td>
  <td class=xl38 width=132 style='mso-text-control:shrinktofit;;border-top:none;width:99pt<%=s_format%>'><% = dt_total.Rows[i][2].ToString()%></td>
  <td class=xl38 width=75 style='border-top:none;width:56pt<%=s_format%>' ><% = dt_total.Rows[i][3].ToString()%></td>
  <td class=xl38 style='border-top:none<%=s_format%>'><% = dt_total.Rows[i][4].ToString()%></td>
  <td class=xl39 width=79 style='border-top:none;width:59pt<%=s_format%>'><% = dt_total.Rows[i][5].ToString()%></td>
  <td class=xl40 width=54 style='border-top:none;width:41pt<%=s_format%>' x:num><% = dt_total.Rows[i][6].ToString()%></td>
  <td class=xl40 width=54 style='border-top:none;width:41pt<%=s_format%>' x:num><% = dt_total.Rows[i][7].ToString()%></td>
  <td class=xl40 width=54 style='border-top:none;width:41pt<%=s_format%>' x:num><% = dt_total.Rows[i][8].ToString()%></td>
  <td class=xl40 width=54 style='border-top:none;width:41pt<%=s_format%>' x:num><% = dt_total.Rows[i][9].ToString()%></td>
  <td class=xl40 width=54 style='border-top:none;width:41pt<%=s_format%>' x:num><% = dt_total.Rows[i][10].ToString()%></td>
  <td class=xl40 width=54 style='border-top:none;width:41pt<%=s_format%>' x:num><% = dt_total.Rows[i][11].ToString()%></td>
  <td class=xl40 width=54 style='border-top:none;width:41pt<%=s_format%>' x:num><% = dt_total.Rows[i][12].ToString()%></td>
  <td class=xl40 width=54 style='border-top:none;width:41pt<%=s_format%>' x:num><% = dt_total.Rows[i][13].ToString()%></td>
  <td class=xl40 width=54 style='border-top:none;width:41pt<%=s_format%>' x:num><% = dt_total.Rows[i][14].ToString()%></td>
  <td class=xl40 width=54 style='border-top:none;width:41pt<%=s_format%>' x:num><% = dt_total.Rows[i][15].ToString()%></td>
  <td class=xl40 width=54 style='border-top:none;width:41pt<%=s_format%>' x:num><% = dt_total.Rows[i][16].ToString()%></td>
  <td class=xl40 width=54 style='border-top:none;width:41pt<%=s_format%>' x:num><% = dt_total.Rows[i][17].ToString()%></td>
  <td class=xl40 width=78 style='border-top:none;width:59pt<%=s_format%>' x:num><% = dt_total.Rows[i][18].ToString()%></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
  <%
    }
  %>
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=36 style='width:27pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=132 style='width:99pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=211 style='width:158pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>

