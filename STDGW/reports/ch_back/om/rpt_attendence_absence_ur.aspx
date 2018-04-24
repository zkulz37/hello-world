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
    string p_user, p_tco_org_pk, p_thr_wg_pk, p_work_shift, p_search_by, p_search_temp, p_nation;
    string p_from_date,p_to_date,p_from_date_text,p_to_date_text,p_date_type;
    int p_tmp;
     
  
    p_tco_org_pk       = Request["p_tco_org_pk"].ToString();
    p_thr_wg_pk      = Request["p_thr_wg_pk"].ToString();
    p_date_type         = Request["p_date_type"].ToString();
    p_search_by         = Request["p_search_by"].ToString();
    p_search_temp       = Request["p_search_temp"].ToString();
    p_work_shift        = Request["p_work_shift"].ToString();
    p_from_date         = Request["p_from_date"].ToString();
    p_to_date           = Request["p_to_date"].ToString();
    p_user              = Request["p_user"].ToString();
    p_nation = Request["p_nation"].ToString();

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
	= "SELECT to_char(sysdate,'dd/mm/yyyy'),C.org_NM,GP.WORKGROUP_NM ,A.EMP_ID, A.FULL_NAME " + 
        "        ,TO_CHAR(TO_DATE(GW.WORK_DT,'YYYYMMDD'),'DD/MM/YYYY') " +
        "       ,'S' || Ws.START_TIME || '-E' || Ws.END_TIME || (CASE WHEN Ws.START_MEAL1 IS NOT NULL THEN 'SM1:' || Ws.START_MEAL1 || '-EM1:' || Ws.END_MEAL1 END ) " +
        "       || (CASE WHEN Ws.START_MEAL2 IS NOT NULL THEN 'SM2:' || Ws.START_MEAL2 || '-EM2:' || Ws.END_MEAL2 END ) " +
        "       ,WKD.TIME_IN " +
        "       , WKD.TIME_OUT, WKD.WORK_TIME " +
        "       ,WKD.OVT,WKD.HT,WKD.NT " +
        "       ,hr_code.code_nm ,WKD.NT2 " +
        "  FROM THR_EMPLOYEE A, tco_org C,THR_WORK_GROUP GP,THR_WG_SCH_DETAIL GW,THR_WORK_SHIFT WS " +
        "  ,(select hr.code, hr.code_nm from vhr_hr_code hr where hr.id='HR0003' ) hr_code " +
        "         ,(SELECT G.THR_EMP_PK AS THR_EMP_PK,G.WORK_DT AS W_DATE,MAX( D.TIME_IN) AS TIME_IN, MAX(D.TIME_OUT) AS TIME_OUT, MAX(D.WORK_TIME) AS WORK_TIME " +
        "       ,MAX(D.PK) AS PK,MAX(D.THR_WS_PK) AS THR_WS_PK " +
        "       ,SUM(DECODE(H.OT_TYPE,'OT',NVL(H.OT_TIME,0),0)) AS OVT " +
        "       ,SUM(DECODE(H.OT_TYPE,'NT',NVL(H.OT_TIME,0),0)) AS NT " +
        "       ,SUM(DECODE(H.OT_TYPE,'NT2',NVL(H.OT_TIME,0),0)) AS NT2 " +
        "        ,SUM(DECODE(H.OT_TYPE,'HT',NVL(H.OT_TIME,0),0)) AS HT " +
        "         ,SUM(DECODE(H.OT_TYPE,'OT',H.PK,0)) AS OVT_PK " +
        "         ,SUM(DECODE(H.OT_TYPE,'NT',H.PK,0)) AS NT_PK " +
        "         ,SUM(DECODE(H.OT_TYPE,'HT',H.PK,0)) AS HT_PK " +
        "         ,MAX( D.DATE_IN) AS DATE_IN " +
        "         ,MAX( D.DATE_OUT) AS DATE_OUT " +
        "         ,MAX(NVL(D.MOD_BYHAND_YN,'N')) AS BYHAND_YN " +
        "            FROM THR_TIME_MACHINE_ur D,THR_EXTRA_TIME_ur H,THR_WG_SCH_DETAIL G,THR_EMPLOYEE V,THR_WORK_SHIFT U " +
        "          WHERE D.DEL_IF(+) = 0   AND G.DEL_IF=0 AND U.DEL_IF=0  " +
        "          AND V.DEL_IF=0 AND V.PK=G.THR_EMP_PK AND G.THR_WS_PK=U.PK " +
        "          AND H.DEL_IF(+)=0  AND G.WORK_DT=D.WORK_DT(+)  " +
        "          AND G.THR_EMP_PK=D.THR_EMP_PK(+) " +
        "          AND G.WORK_DT BETWEEN '" + p_from_date + "' AND '" + p_to_date + "' " +
        "          AND G.WORK_DT=H.WORK_DT(+)  " +
        "           AND G.THR_EMP_PK=H.THR_EMP_PK(+) " +
        "     AND DECODE ('" + p_work_shift + "', 'ALL', '" + p_work_shift + "', u.pk) = '" + p_work_shift  + "'" +
        "     AND DECODE ('" + p_thr_wg_pk + "', 'ALL', '" + p_thr_wg_pk + "', v.thr_wg_pk) = '" + p_thr_wg_pk  + "'" +
        "     AND (   DECODE ('" + p_search_by + "', " +
        "                     '1', UPPER (v.emp_id), " +
        "                     '2', v.id_num, " +
        "                     '3', UPPER (v.full_name) " +
        "                    ) LIKE '%' || UPPER ('" + p_search_temp + "') " +
        "          OR '" + p_search_temp + "' IS NULL " +
        "         ) " +
        "     AND (   v.tco_org_pk IN ( " +
        "                SELECT     g.pk " +
        "                      FROM tco_org g " +
        "                     WHERE g.del_if = 0  " +
        "                START WITH g.pk = " +
        "                               DECODE ('" + p_tco_org_pk + "', " +
        "                                       'ALL', 0, " +
        "                                       '" + p_tco_org_pk  + "'" +
        "                                      ) " +
        "                CONNECT BY PRIOR g.pk = g.p_pk) " +
        "          OR '" + p_tco_org_pk + "' = 'ALL' " +
        "         ) " +
        "          GROUP BY  G.THR_EMP_PK, G.WORK_DT) WKD " +
        "       ,(SELECT K.WORK_DT AS ABS_DATE,K.THR_EMP_PK, E.ABSENCE_TYPE AS CODE, E.ABSENCE_TIME,E.PK " +
        "           FROM THR_ABSENCE_ur E,THR_EMPLOYEE F,THR_wg_sch_DETAIL K " +
        "          WHERE E.DEL_IF(+) = 0  AND K.DEL_IF=0 " +
        "          AND F.DEL_IF=0  AND F.PK=K.THR_EMP_PK " +
        "          AND K.THR_EMP_PK=E.THR_EMP_PK(+) AND K.WORK_DT=E.ABSENCE_DT(+) " +
        "            AND K.WORK_DT BETWEEN '" + p_from_date + "' AND '" + p_to_date + "' "  +
        "     AND (   DECODE ('" + p_search_by + "', " +
        "                     '1', UPPER (F.emp_id), " +
        "                     '2', F.id_num, " +
        "                     '3', UPPER (F.full_name) " +
        "                    ) LIKE '%' || UPPER ('" + p_search_temp + "') " +
        "          OR '" + p_search_temp + "' IS NULL " +
        "         ) " +
        "     AND (   F.tco_org_pk IN ( " +
        "                SELECT     g.pk " +
        "                      FROM tco_org g " +
        "                     WHERE g.del_if = 0  " +
        "                START WITH g.pk = " +
        "                               DECODE ('" + p_tco_org_pk + "', " +
        "                                       'ALL', 0, " +
        "                                       '" + p_tco_org_pk  + "'" +
        "                                      ) " +
        "                CONNECT BY PRIOR g.pk = g.p_pk) " +
        "          OR '" + p_tco_org_pk + "' = 'ALL' " +
        "         ) " +
        "        ) ABS " +
        " WHERE A.DEL_IF = 0 AND GP.DEL_IF=0 AND GW.DEL_IF=0 AND WS.DEL_IF=0 " +
        "   AND A.PK=GW.THR_EMP_PK AND GW.THR_WS_PK=WS.PK " +
        "   AND A.JOIN_DT <= '" + p_to_date + "' "  +
        "   AND (A.LEFT_DT > TO_CHAR(TO_DATE(GW.WORK_DT,'YYYYMMDD')- '" + p_tmp + "','YYYYMMDD') OR A.LEFT_DT IS NULL) " +
        "   AND A.TCO_org_PK = C.PK AND A.THR_wg_PK=GP.PK " +
        "   AND GW.WORK_DT BETWEEN '" + p_from_date + "' AND '" + p_to_date + "' "  +
        "   AND A.PK = WKD.THR_EMP_PK(+) " +
        "   AND A.PK = ABS.THR_EMP_PK(+) " +
        "   AND GW.WORK_DT=WKD.W_DATE " +
        "   AND GW.WORK_DT=ABS.ABS_DATE " +
        "   and hr_code.code(+) = nvl(ABS.CODE,' ') " +
        "     AND DECODE ('" + p_thr_wg_pk + "', 'ALL', '" + p_thr_wg_pk + "', GP.PK) = '" + p_thr_wg_pk  + "'" +
        "   AND DECODE ('" + p_work_shift + "', 'ALL', '" + p_work_shift + "', ws.pk) = '" + p_work_shift  + "'" +
        "   AND (DECODE ('" + p_nation + "', 'ALL', a.NATION , '01','01') =  a.NATION or ( '" + p_nation + "' ='02' and a.NATION <> '01'))" +
        "     AND (   C.PK IN ( " +
        "                SELECT     g.pk " +
        "                      FROM tco_org g " +
        "                     WHERE g.del_if = 0  " +
        "                START WITH g.pk = " +
        "                               DECODE ('" + p_tco_org_pk + "', " +
        "                                       'ALL', 0, " +
        "                                       '" + p_tco_org_pk  + "'" +
        "                                      ) " +
        "                CONNECT BY PRIOR g.pk = g.p_pk) " +
        "          OR '" + p_tco_org_pk + "' = 'ALL' " +
        "         ) " +
        "   AND A.PK NOT IN(SELECT AB.THR_EMP_PK FROM THR_ABSENCE_ur AB WHERE AB.DEL_IF=0 AND AB.ABSENCE_TYPE='04' AND AB.ABSENCE_DT=GW.WORK_DT AND AB.THR_EMP_PK=A.PK) " +
        "     AND (   DECODE ('" + p_search_by + "', " +
        "                     '1', UPPER (A.emp_id), " +
        "                     '2', A.id_num, " +
        "                     '3', UPPER (A.full_name) " +
        "                    ) LIKE '%' || UPPER ('" + p_search_temp + "') " +
        "          OR '" + p_search_temp + "' IS NULL " +
        "         ) " +
        "ORDER BY GW.WORK_DT,nvl(c.seq,0),nvl(gp.seq,0), a.emp_id ";

        
        
        
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
<link rel=File-List href="rpt_attendence_absence_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_attendence_absence_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_attendence_absence_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>ty-ml</o:LastAuthor>
  <o:LastPrinted>2008-07-23T02:09:15Z</o:LastPrinted>
  <o:Created>2008-05-23T07:19:16Z</o:Created>
  <o:LastSaved>2008-07-23T02:09:35Z</o:LastSaved>
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
	margin:.32in .16in .26in .28in;
	mso-header-margin:.32in;
	mso-footer-margin:.14in;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl28
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
	background:#99CCFF;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
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
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
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
      <x:Scale>76</x:Scale>
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
       <x:ActiveRow>4</x:ActiveRow>
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

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1344 style='border-collapse:
 collapse;table-layout:fixed;width:1010pt'>
 <col class=xl24 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl24 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl24 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col class=xl24 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl24 width=215 style='mso-width-source:userset;mso-width-alt:7862;
 width:161pt'>
 <col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl24 width=173 style='mso-width-source:userset;mso-width-alt:6326;
 width:130pt'>
 <col class=xl24 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl24 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl24 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl24 width=59 style='mso-width-source:userset;mso-width-alt:2157;
 width:44pt'>
 <col class=xl24 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
<col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl24 width=137 style='mso-width-source:userset;mso-width-alt:5010;
 width:103pt'>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=13 height=38 class=xl44 width=1207 style='height:28.5pt;
  width:907pt'>WORKING TIMES AND ABSENCES</td>
  <td class=xl24 width=137 style='width:103pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl25 x:str><%if (p_date_type=="3") 
                        Response.Write("Month");
                    else
                        Response.Write("From Date");%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl26 x:num><%if (p_date_type=="3") 
                        Response.Write(p_from_date.Substring(4,2) + "/" + p_from_date.Substring(0,4));
                    else
                        Response.Write(p_from_date.Substring(6,2) + "/" + p_from_date.Substring(4,2) + "/" + p_from_date.Substring(0,4));
                        %></td>
  <td class=xl30><%if (p_date_type!="3") 
                        Response.Write("To Date");%></td>
  <td class=xl26 x:num><%if (p_date_type!="3") 
                            Response.Write(p_to_date.Substring(6,2) + "/" + p_to_date.Substring(4,2) + "/" + p_to_date.Substring(0,4));
                            %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>Reporter</td>
  <td class=xl24></td>
  <td colspan=2 class=xl45><%=p_user %></td>
  <td class=xl31></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl25></td>
  <td class=xl31></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30 colspan=2 style='mso-ignore:colspan'>Report Date</td>
  <td colspan=2 class=xl26 x:num><%= dt_total.Rows[0][0].ToString() %></td>
  <td class=xl26></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl30></td>
  <td class=xl26></td>
  <td colspan=11 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl28 style='height:19.5pt'>No</td>
  <td class=xl28 style='border-left:none'>Department</td>
  <td class=xl28 style='border-left:none'>Group</td>
  <td class=xl28 style='border-left:none'>Emp ID</td>
  <td class=xl28 style='border-left:none'>Full Name</td>
  <td class=xl28 style='border-left:none'>Date</td>
  <td class=xl28 style='border-left:none'>Work Shift</td>
  <td class=xl28 style='border-left:none'>IN Time</td>
  <td class=xl28 style='border-left:none'>OUT Time</td>
  <td class=xl28 style='border-left:none'>WT</td>
  <td class=xl28 style='border-left:none'>OT</td>
  <td class=xl28 style='border-left:none'>HT</td>
  <td class=xl28 style='border-left:none'>NT</td>
  <td class=xl28 style='border-left:none'>NT2</td>
  <td class=xl28 style='border-left:none'>Absence Type</td>
  
 </tr>
 <tr class=xl27 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl32 style='height:19.5pt;border-top:none'>STT</td>
  <td class=xl32 style='border-top:none;border-left:none'>B&#7897; ph&#7853;n</td>
  <td class=xl32 style='border-top:none;border-left:none'>Nhóm</td>
  <td class=xl32 style='border-top:none;border-left:none'>Mã NV</td>
  <td class=xl32 style='border-top:none;border-left:none'>H&#7885; và tên</td>
  <td class=xl32 style='border-top:none;border-left:none'>Ngày</td>
  <td class=xl32 style='border-top:none;border-left:none'>Ca làm vi&#7879;c</td>
  <td class=xl32 style='border-top:none;border-left:none'>Gi&#7901; vào</td>
  <td class=xl32 style='border-top:none;border-left:none'>Gi&#7901; ra</td>
  <td class=xl32 style='border-top:none;border-left:none'>Công</td>
  <td class=xl32 style='border-top:none;border-left:none'>T&#259;ng ca</td>
  <td class=xl32 style='border-top:none;border-left:none'>Ngày l&#7877;</td>
  <td class=xl32 style='border-top:none;border-left:none'>Gi&#7901; &#273;êm</td>
  <td class=xl32 style='border-top:none;border-left:none'>Gi&#7901; &#273;êm 45%</td>
  <td class=xl32 style='border-top:none;border-left:none'>Lo&#7841;i ngh&#7881;</td>
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
 <tr class=xl29 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl33 style='height:19.5pt;border-top:none<%=s_format%>' x:num><%=i+1 %></td>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][1].ToString()%></td>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][2].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][3].ToString()%></td>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][4].ToString()%></td>
  <td class=xl35 style='border-top:none;border-left:none<%=s_format%>' x:num><% = dt_total.Rows[i][5].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][6].ToString()%></td>
  <td class=xl36 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][7].ToString()%></td>
  <td class=xl36 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][8].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>' x:num><% = dt_total.Rows[i][9].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>' x:num><% = dt_total.Rows[i][10].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>' x:num><% = dt_total.Rows[i][11].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>' x:num><% = dt_total.Rows[i][12].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>' x:num><% = dt_total.Rows[i][14].ToString()%></td>
  <td class=xl43 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][13].ToString()%></td>
 </tr>
 <%
    }
  %>
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=47 style='width:35pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=173 style='width:130pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=137 style='width:103pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
