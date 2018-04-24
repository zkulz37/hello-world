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
<%
    string p_user,p_tco_org_pk,p_wg,p_work_shift,p_search_by,p_search_temp;
    string p_from_date, p_to_date, p_from_date_text, p_to_date_text, p_date_type, p_nation, p_reg, p_have_ot, p_approve, p_section_type, p_join_from, p_join_to;
     
  
    p_tco_org_pk       = Request["p_tco_org_pk"].ToString();
    p_wg      = Request["p_wg"].ToString();
    p_date_type         = Request["p_date_type"].ToString();
    p_search_by         = Request["p_search_by"].ToString();
    p_search_temp       = Request["p_search_temp"].ToString();
    p_work_shift        = Request["p_work_shift"].ToString();
    p_from_date         = Request["p_from_date"].ToString();
    p_to_date           = Request["p_to_date"].ToString();
    p_user              = Request["p_user"].ToString();
	p_nation            = Request["p_nation"].ToString();
    p_have_ot = Request["p_have_ot"].ToString();
    p_approve = Request["p_approve"].ToString();
    p_section_type = Request["p_section_type"].ToString();
    p_join_from = Request["p_join_from"].ToString();
    p_join_to = Request["p_join_to"].ToString();
   
    int p_tmp;

    string SQL_Com
    = "SELECT A.NUM_4 FROM VHR_HR_CODE A " +
        " WHERE A.ID='HR0006' AND A.CODE='11'";

    DataTable dt_Com = ESysLib.TableReadOpen(SQL_Com);
    int irow_com;
    irow_com = dt_Com.Rows.Count;
    if (irow_com == 0)
        p_tmp = 0;
    else
        p_tmp = int.Parse(dt_Com.Rows[0][0].ToString());  
   
   string SQL
   = " SELECT  to_char(sysdate,'dd/mm/yyyy') " + 
        "        ,C.ORG_NM " +
        "        ,GP.WORKGROUP_NM  " +
        "        ,A.EMP_ID " +
        "        ,A.FULL_NAME  " +
        "        ,TO_CHAR(TO_DATE(GW.WORK_DT,'YYYYMMDD'),'DD/MM/YYYY')  " +
        "        ,WS.REMARK  " +
        "        ,WKD.TIME_IN  " +
        "        ,WKD.TIME_OUT " +
        "        ,WKD.WORK_TIME  " +
        "        ,WKD.OVT " +
        "        ,WKD.HT " +
        "        ,WKD.NT " +
        "        ,WKD.NT2 " +
        "        ,WKD.OT_A " +
        "        ,WKD.HT_A " +
        "        ,WKD.NT_A " +
        "        ,WKD.NT2_A " +
        "        ,NVL(WKD.APPROVE_YN,'N') " +
        "        ,WKD.NOTE " +
        "  FROM THR_EMPLOYEE A, COMM.TCO_ORG C,THR_WORK_GROUP GP,THR_WG_SCH_DETAIL GW,THR_WORK_SHIFT WS " +
        "         ,(SELECT D.THR_EMP_PK AS THR_EMP_PK,D.WORK_DT AS W_DATE,MAX( D.TIME_IN) AS TIME_IN, MAX(D.TIME_OUT) AS TIME_OUT, MAX(D.WORK_TIME) AS WORK_TIME " +
        "       ,MAX(D.PK) AS PK " +
        "       ,SUM(DECODE(H.OT_TYPE,'OT',NVL(H.OT_TIME,0),0)) AS OVT " +
        "       ,SUM(DECODE(H.OT_TYPE,'NT',NVL(H.OT_TIME,0),0)) AS NT " +
        "       ,SUM(DECODE(H.OT_TYPE,'NT2',NVL(H.OT_TIME,0),0)) AS NT2 " +
        "        ,SUM(DECODE(H.OT_TYPE,'HT',NVL(H.OT_TIME,0),0)) AS HT " +
        "         ,SUM(DECODE(H.OT_TYPE,'OT',H.PK,0)) AS OVT_PK " +
        "         ,SUM(DECODE(H.OT_TYPE,'NT',H.PK,0)) AS NT_PK " +
        "         ,SUM(DECODE(H.OT_TYPE,'NT2',H.PK,0)) AS NT2_PK " +
        "         ,SUM(DECODE(H.OT_TYPE,'HT',H.PK,0)) AS HT_PK " +
        "          ,SUM(DECODE(H.OT_TYPE,'OT',NVL(H.OT_APPROVE,0),0)) AS OT_A " +
        "       ,SUM(DECODE(H.OT_TYPE,'NT',NVL(H.OT_APPROVE,0),0)) AS NT_A " +
        "       ,SUM(DECODE(H.OT_TYPE,'NT2',NVL(H.OT_APPROVE,0),0)) AS NT2_A " +
        "        ,SUM(DECODE(H.OT_TYPE,'HT',NVL(H.OT_APPROVE,0),0)) AS HT_A " +
        "       ,MAX(D.NOTE) AS NOTE " +
        "          ,max(nvl(D.APPROVE_YN,'N')) AS APPROVE_YN " +
        "            FROM THR_TIME_MACHINE D,THR_EXTRA_TIME H,THR_EMPLOYEE V " +
        "          WHERE D.DEL_IF = 0 AND H.DEL_IF(+)=0 AND V.DEL_IF=0 AND V.PK=D.THR_EMP_PK " +
        "          AND D.THR_EMP_PK=H.THR_EMP_PK(+) AND D.WORK_DT=H.WORK_DT(+) " +
        "          AND D.WORK_DT BETWEEN '" + p_from_date + "' AND '" + p_to_date + "' " +
        "           AND (DECODE('" + p_search_by + "','1',UPPER(V.EMP_ID),'2',V.ID_NUM,'3',UPPER(V.FULL_NAME)) LIKE '%'||UPPER('" + p_search_temp + "') " +
        "                OR '" + p_search_temp + "' IS NULL) " +
        "           AND (    V.TCO_ORG_PK IN ( " +
        "                              SELECT     G.PK " +
        "                                    FROM COMM.TCO_ORG G " +
        "                                   WHERE G.DEL_IF = 0 " +
        "                              START WITH G.PK = " +
        "                                            DECODE ('" + p_tco_org_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_tco_org_pk + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR G.PK = G.P_PK) " +
        "                        OR '" + p_tco_org_pk + "' = 'ALL') " +
        "          GROUP BY  D.THR_EMP_PK, D.WORK_DT) WKD " +
        " WHERE A.DEL_IF = 0 AND GP.DEL_IF=0 AND GW.DEL_IF=0 AND WS.DEL_IF=0  " +
        "   AND A.PK=GW.THR_EMP_PK AND GW.THR_WS_PK=WS.PK    " +
        " AND (A.JOIN_DT BETWEEN '" + p_join_from + "' AND '" + p_join_to + "' OR '" + p_join_from + "' IS NULL OR '" + p_join_to + "' IS NULL) "+
        "   AND (A.LEFT_DT > TO_CHAR(TO_DATE(GW.WORK_DT,'YYYYMMDD')- '" + p_tmp + "','YYYYMMDD') OR A.LEFT_DT IS NULL) " +
        "   AND A.TCO_ORG_PK = C.PK AND A.THR_WG_PK=GP.PK " +
        "    AND GW.WORK_DT BETWEEN '" + p_from_date + "' AND '" + p_to_date + "' " +
        "   AND A.PK = WKD.THR_EMP_PK " +
        "   AND GW.WORK_DT=WKD.W_DATE " +
        "   AND DECODE('" + p_wg  + "','ALL','" + p_wg  + "',GP.PK) = '" + p_wg  + "' " +
        "   AND DECODE('" + p_work_shift + "','ALL','ALL',WS.PK)='" + p_work_shift + "' " +
        "   and (decode('" + p_nation + "','ALL','ALL',nvl(a.NATION,'01')) = '" + p_nation + "'  " +
                "                or ( '" + p_nation + "'='02' and nvl(a.NATION,'01') <> '01' )) " +
        " AND ( (NVL(WKD.OVT,0)+NVL(WKD.HT,0)>0 AND '" + p_have_ot + "'='Y') "+
        "    OR (NVL(WKD.OVT,0)+NVL(WKD.HT,0)=0 AND '" + p_have_ot + "'='N')  " +
        "    OR '" + p_have_ot + "'='ALL'   " +
        "   )  "+
        " AND DECODE('" + p_approve + "','ALL','ALL',NVL(WKD.APPROVE_YN,'N'))='" + p_approve + "' " +     
        "   AND (c.pk     IN ( " +
        "                              SELECT     G.PK " +
        "                                    FROM COMM.TCO_ORG G " +
        "                                   WHERE G.DEL_IF = 0 " +
        "                              START WITH G.PK = " +
        "                                            DECODE ('" + p_tco_org_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_tco_org_pk + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR G.PK = G.P_PK) " +
        "                        OR '" + p_tco_org_pk + "' = 'ALL') " +
        "   AND (DECODE('" + p_search_by + "','1',UPPER(A.EMP_ID),'2',A.ID_NUM,'3',UPPER(A.FULL_NAME)) LIKE '%'||UPPER('" + p_search_temp + "') " +
        "                OR '" + p_search_temp + "' IS NULL) " +
        " AND DECODE('" + p_section_type + "','ALL','ALL',a.SECTION_TYPE)='" + p_section_type + "' "+
        "ORDER BY GW.WORK_DT,C.ORG_NM,A.EMP_ID " ;

        
        
        
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
<link rel=File-List href="rpt_attendence_absence_approve_files/filelist.xml">
<link rel=Edit-Time-Data
href="rpt_attendence_absence_approve_files/editdata.mso">
<link rel=OLE-Object-Data
href="rpt_attendence_absence_approve_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-05-14T04:30:36Z</o:LastPrinted>
  <o:Created>2008-05-23T07:19:16Z</o:Created>
  <o:LastSaved>2011-05-14T05:47:28Z</o:LastSaved>
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
	margin:.32in 0in .26in 0in;
	mso-header-margin:.32in;
	mso-footer-margin:.14in;
	mso-page-orientation:landscape;}
.font11
	{color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
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
.xl65
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl74
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl79
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl80
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl82
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl83
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl84
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl86
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl87
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
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl88
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
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl89
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl90
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
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
      <x:Scale>61</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>6</x:SplitHorizontal>
     <x:TopRowBottomPane>6</x:TopRowBottomPane>
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
       <x:ActiveCol>4</x:ActiveCol>
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
  <x:WindowHeight>7935</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$5:$6</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl65>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1691 style='border-collapse:
 collapse;table-layout:fixed;width:1272pt'>
 <col class=xl65 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl65 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl65 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col class=xl65 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl65 width=215 style='mso-width-source:userset;mso-width-alt:7862;
 width:161pt'>
 <col class=xl65 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl65 width=173 style='mso-width-source:userset;mso-width-alt:6326;
 width:130pt'>
 <col class=xl65 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl65 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl65 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl65 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl65 width=59 style='mso-width-source:userset;mso-width-alt:2157;
 width:44pt'>
 <col class=xl65 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl65 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl65 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl65 width=59 style='mso-width-source:userset;mso-width-alt:2157;
 width:44pt'>
 <col class=xl65 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl65 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl65 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl65 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl65 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <tr height=66 style='mso-height-source:userset;height:49.5pt'>
  <td colspan=20 height=66 class=xl89 width=1691 style='height:49.5pt;
  width:1272pt'>WORKING TIMES AND OVERTIME APPROVE<br>
    <font class="font11">B&#7842;NG CÔNG VÀ PHÊ DUY&#7878;T T&#258;NG CA</font></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl65 style='height:15.75pt'></td>
  <td class=xl67 x:str><%if (p_date_type=="3") 
                        Response.Write("Month");
                    else
                        Response.Write("From Date");%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl68 x:str><%if (p_date_type=="3") 
                        Response.Write(p_from_date.Substring(4,2) + "/" + p_from_date.Substring(0,4));
                    else
                        Response.Write(p_from_date.Substring(6,2) + "/" + p_from_date.Substring(4,2) + "/" + p_from_date.Substring(0,4));
                        %></td>
  <td class=xl66><%if (p_date_type!="3") 
                        Response.Write("To Date");%></td>
  <td class=xl68 x:str><%if (p_date_type!="3") 
                            Response.Write(p_to_date.Substring(6,2) + "/" + p_to_date.Substring(4,2) + "/" + p_to_date.Substring(0,4));
                            %></td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl69 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl84></td>
  <td class=xl66>Reporter</td>
  <td class=xl65></td>
  <td colspan=2 class=xl84><%=p_user %></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl65 style='height:15.75pt'></td>
  <td class=xl67></td>
  <td class=xl69></td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl68></td>
  <td class=xl66 colspan=2 style='mso-ignore:colspan'>Report Date</td>
  <td colspan=2 class=xl68><%= dt_total.Rows[0][0].ToString() %></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl65 style='height:15.75pt'></td>
  <td class=xl66></td>
  <td class=xl68></td>
  <td colspan=17 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl70 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl85 style='height:19.5pt'>No</td>
  <td class=xl86>Organization</td>
  <td class=xl86>Work Group</td>
  <td class=xl86>Emp ID</td>
  <td class=xl86>Full Name</td>
  <td class=xl86>Date</td>
  <td class=xl86>Work Shift</td>
  <td class=xl86>IN Time</td>
  <td class=xl86>OUT Time</td>
  <td class=xl86>WT</td>
  <td class=xl86>OT</td>
  <td class=xl86>HT</td>
  <td class=xl86>NT1</td>
  <td class=xl86>NT2</td>
  <td class=xl86>OT(A)</td>
  <td class=xl86>HT(A)</td>
  <td class=xl86>NT1(A)</td>
  <td class=xl86>NT2(A)</td>
  <td class=xl86>Approved</td>
  <td class=xl86>Note</td>
 </tr>
 <tr class=xl70 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl87 style='height:27.0pt'>STT</td>
  <td class=xl88>B&#7897; ph&#7853;n</td>
  <td class=xl88>Nhóm</td>
  <td class=xl88>Mã NV</td>
  <td class=xl88>H&#7885; và tên</td>
  <td class=xl88>Ngày</td>
  <td class=xl88>Ca làm vi&#7879;c</td>
  <td class=xl88>Gi&#7901; vào</td>
  <td class=xl88>Gi&#7901; ra</td>
  <td class=xl88>Công</td>
  <td class=xl88>T&#259;ng ca</td>
  <td class=xl88>Ngày l&#7877;</td>
  <td class=xl88>Gi&#7901; &#273;êm 1</td>
  <td class=xl88>Gi&#7901; &#273;êm 2</td>
  <td class=xl88>T&#259;ng ca</td>
  <td class=xl88>Ngày l&#7877;</td>
  <td class=xl88>Gi&#7901; &#273;êm 1</td>
  <td class=xl88>Gi&#7901; &#273;êm 2</td>
  <td class=xl88>Phê duy&#7879;t</td>
  <td class=xl88>Ghi chú</td>
 </tr>
  <% 
    
    int count=0;
     for (int i = 0; i < irow; i++) 
     {
        count++;
    %> 
 <tr class=xl71 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl72 style='height:19.5pt' x:num><%= count %></td>
  <td class=xl73><% = dt_total.Rows[i][1].ToString()%></td>
  <td class=xl73><% = dt_total.Rows[i][2].ToString()%></td>
  <td class=xl74 x:str><% = dt_total.Rows[i][3].ToString()%></td>
  <td class=xl73><% = dt_total.Rows[i][4].ToString()%></td>
  <td class=xl75 x:num><% = dt_total.Rows[i][5].ToString()%></td>
  <td class=xl74><% = dt_total.Rows[i][6].ToString()%></td>
  <td class=xl76><% = dt_total.Rows[i][7].ToString()%></td>
  <td class=xl76><% = dt_total.Rows[i][8].ToString()%></td>
  <td class=xl74 x:num><% = dt_total.Rows[i][9].ToString()%></td>
  <td class=xl74 x:num><% = dt_total.Rows[i][10].ToString()%></td>
  <td class=xl74 x:num><% = dt_total.Rows[i][11].ToString()%></td>
  <td class=xl74 x:num><% = dt_total.Rows[i][12].ToString()%></td>
  <td class=xl74 x:num><% = dt_total.Rows[i][13].ToString()%></td>
  <td class=xl74 x:num><% = dt_total.Rows[i][14].ToString()%></td>
  <td class=xl74 x:num><% = dt_total.Rows[i][15].ToString()%></td>
  <td class=xl74 x:num><% = dt_total.Rows[i][16].ToString()%></td>
  <td class=xl74 x:num><% = dt_total.Rows[i][17].ToString()%></td>
  <td class=xl77><% = dt_total.Rows[i][18].ToString()%></td>
  <td class=xl77><% = dt_total.Rows[i][19].ToString()%></td>
 </tr>
   <%
    }
  %>
 <tr class=xl71 height=1 style='mso-height-source:userset;height:.75pt'>
  <td height=1 class=xl78 style='height:.75pt'>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl82>&nbsp;</td>
  <td class=xl82>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
 </tr>

 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=47 style='width:35pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=173 style='width:130pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=86 style='width:65pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
