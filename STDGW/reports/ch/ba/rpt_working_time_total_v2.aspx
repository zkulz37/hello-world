<%@ Page Language="C#" %>
<%@ Import Namespace = "System.Data" %>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_user, p_tco_org_pk, p_wg, p_opt, p_wt_ot, p_search, p_input, p_val;
    string p_from,p_to,p_nation;
     
  
    p_tco_org_pk       = Request["p_tco_org_pk"].ToString();
    p_wg      = Request["p_wg"].ToString();
    p_from         = Request["p_from"].ToString();
    p_to         = Request["p_to"].ToString();
    p_opt       = Request["p_opt"].ToString();
    p_wt_ot        = Request["p_wt_ot"].ToString();
    p_search         = Request["p_search"].ToString();
    p_input           = Request["p_input"].ToString();
    p_user              = Request["p_user"].ToString();
    p_nation          = Request["p_nation"].ToString();
    p_val = Request["p_val"].ToString();
    string p_status = Request["p_status"].ToString();
   
    string SQL
	= " SELECT to_char(sysdate,'dd/mm/yyyy'),FIN.ORG_NM,FIN.WGROUP_NM,FIN.EMP_ID " + 
        "                ,FIN.FULL_NAME " +
        "                ,TO_CHAR(TO_DATE(FIN.JOIN_DT,'YYYYMMDD'),'DD/MM/YYYY') " +
        "                ,FIN.WT " +
        "                ,DECODE(FIN.OT,0,'',FIN.OT) " +
        "                ,DECODE(FIN.NT,0,'',FIN.NT) " +
        "                ,DECODE(FIN.HT,0,'',FIN.HT) " +
        "                ,DECODE(FIN.WT_OT,0,'',FIN.WT_OT) " +
        "                ,DECODE(FIN.OT_HT,0,'',FIN.OT_HT)  " +
        "                ,DECODE(FIN.NT2,0,'',FIN.NT2) " +
        "        FROM( " +
        "              SELECT C.ORG_NM AS ORG_NM,B.WORKGROUP_NM AS WGROUP_NM,A.EMP_ID AS EMP_ID,A.JOIN_DT AS JOIN_DT " +
        "            ,A.FULL_NAME AS FULL_NAME,NVL(TM.WT,0) AS WT " +
        "            ,NVL(OVT.OT,0) AS OT " +
        "            ,NVL(OVT.NT,0) AS NT " +
        "            ,NVL(OVT.NT2,0) AS NT2 " +
        "            ,NVL(OVT.HT,0) AS HT " +
        "            ,NVL(TM.WT,0) + NVL(OVT.OT,0) AS WT_OT " +
        "            ,NVL(OVT.OT,0)+NVL(OVT.HT,0) AS OT_HT " +
        "            ,A.TCO_ORG_PK AS TCO_ORG_PK " +
        "            FROM THR_EMPLOYEE A,THR_WORK_GROUP B,tco_ORG C " +
        "            ,(SELECT F.PK AS EMP_PK " +
        "                    ,SUM(NVL(M.WORK_TIME,0)) AS WT " +
        "                    FROM THR_TIME_MACHINE M,THR_EMPLOYEE F " +
        "                    WHERE M.DEL_IF=0 AND F.DEL_IF=0 AND F.PK=M.THR_EMP_PK " +
        "            AND DECODE('" + p_nation + "' ,'ALL', '" + p_nation + "',f.nation) =  '" + p_nation  + "'" +
        "            AND DECODE('" + p_status + "' ,'ALL', '" + p_status + "',f.status) =  '" + p_status + "'" +
        "                    AND M.WORK_DT BETWEEN '" + p_from  + "' AND '" + p_to  + "' " ;
        SQL = SQL + "                   AND (    F.TCO_ORG_PK IN ( ";
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
        "                        AND (DECODE('" + p_search + "' ,'1',UPPER(F.EMP_ID),'2',F.ID_NUM,'3',UPPER(F.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "' ) " +
        "                            OR '" + p_input + "'  IS NULL) " +
        "                    GROUP BY F.PK           " +
        "                 ) TM    " +
        "                ,(SELECT F.PK AS EMP_PK " +
        "                    ,SUM(DECODE(E.OT_TYPE,'OT',NVL(E.OT_TIME,0),0)) AS OT " +
        "                    ,SUM(DECODE(E.OT_TYPE,'NT',NVL(E.OT_TIME,0),0)) AS NT " +
        "                    ,SUM(DECODE(E.OT_TYPE,'NT2',NVL(E.OT_TIME,0),0)) AS NT2 " +
        "                    ,SUM(DECODE(E.OT_TYPE,'HT',NVL(E.OT_TIME,0),0)) AS HT " +
        "                    FROM THR_EXTRA_TIME E,THR_EMPLOYEE F " +
        "                    WHERE E.DEL_IF=0 AND F.DEL_IF=0 AND F.PK=E.THR_EMP_PK " +
		        "            AND DECODE('" + p_nation + "' ,'ALL', '" + p_nation + "',f.nation) =  '" + p_nation  + "'" +
                "            AND DECODE('" + p_status + "' ,'ALL', '" + p_status + "',f.status) =  '" + p_status + "'" +
        "                    AND E.WORK_DT BETWEEN '" + p_from  + "' AND '" + p_to  + "' " ;
       SQL = SQL + "                   AND (    F.TCO_ORG_PK IN ( ";
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
        "                        AND (DECODE('" + p_search + "' ,'1',UPPER(F.EMP_ID),'2',F.ID_NUM,'3',UPPER(F.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "' ) " +
        "                            OR '" + p_input + "'  IS NULL) " +
        "                    GROUP BY F.PK           " +
        "                 ) OVT    " +
        "            WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0  " +
        "            AND A.THR_WG_PK=B.PK AND A.TCO_ORG_PK=C.PK " +
        "            AND A.PK=OVT.EMP_PK(+)  " +
        "            AND A.PK=TM.EMP_PK(+)   " +
        "            AND A.JOIN_DT <= '" + p_to  + "' " +
        "            AND (A.LEFT_DT>= '" + p_from + "'  OR A.LEFT_DT IS NULL)           " +
        "            AND DECODE('" + p_nation + "' ,'ALL', '" + p_nation + "',a.nation) =  '" + p_nation  + "'" +
        "            AND DECODE('" + p_status + "' ,'ALL', '" + p_status + "',a.status) =  '" + p_status + "'" +
        "            AND DECODE('" + p_wg + "' ,'ALL','" + p_wg + "' ,B.PK) = '" + p_wg  + "' " ;
       SQL = SQL + "                   AND (    A.TCO_ORG_PK IN ( ";
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
        "            AND (DECODE('" + p_search + "' ,'1',UPPER(A.EMP_ID),'2',A.ID_NUM,'3',UPPER(A.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "' ) " +
        "                        OR '" + p_input + "'  IS NULL) " +
        "            )FIN " +
        "            WHERE ( '" + p_val + "' = '=' and DECODE('" + p_opt + "','1',FIN.WT,'2',FIN.OT,'3',FIN.HT,'4',FIN.WT_OT,'5',FIN.OT_HT)=NVL('" + p_wt_ot + "',0) " +
        "                        or '" + p_val + "' = '>' and DECODE('" + p_opt + "','1',FIN.WT,'2',FIN.OT,'3',FIN.HT,'4',FIN.WT_OT,'5',FIN.OT_HT)>NVL('" + p_wt_ot + "',0) " +
        "                        or '" + p_val + "' = '<' and DECODE('" + p_opt + "','1',FIN.WT,'2',FIN.OT,'3',FIN.HT,'4',FIN.WT_OT,'5',FIN.OT_HT)<NVL('" + p_wt_ot + "',0) " +
        "                        or '" + p_val + "' = '>=' and DECODE('" + p_opt + "','1',FIN.WT,'2',FIN.OT,'3',FIN.HT,'4',FIN.WT_OT,'5',FIN.OT_HT)>=NVL('" + p_wt_ot + "',0) " +
        "                        or '" + p_val + "' = '<=' and DECODE('" + p_opt + "','1',FIN.WT,'2',FIN.OT,'3',FIN.HT,'4',FIN.WT_OT,'5',FIN.OT_HT)<=NVL('" + p_wt_ot + "',0) " +
        "                        OR NVL('" + p_wt_ot + "',0)=0) " +
        "            ORDER BY FIN.ORG_NM,FIN.WGROUP_NM,FIN.EMP_ID " ;

        
        
        
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
<link rel=File-List href="rpt_working_time_total_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_working_time_total_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_working_time_total_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>ty-ml</o:LastAuthor>
  <o:LastPrinted>2008-07-24T06:33:21Z</o:LastPrinted>
  <o:Created>2008-05-26T09:13:46Z</o:Created>
  <o:LastSaved>2008-07-25T07:09:45Z</o:LastSaved>
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;}
.xl34
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
.xl35
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
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
.xl37
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
.xl38
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
.xl39
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
.xl40
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
.xl41
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
.xl42
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
.xl43
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
.xl44
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
.xl45
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
.xl46
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
.xl47
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
.xl48
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
.xl49
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
.xl50
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
.xl51
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
.xl52
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;}
.xl54
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";}
.xl57
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
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
       <x:ActiveCol>3</x:ActiveCol>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1171 style='border-collapse:
 collapse;table-layout:fixed;width:879pt'>
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
 <col class=xl30 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl25 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl25 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl25 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <col class=xl25 width=69 span=3 style='mso-width-source:userset;mso-width-alt:
 2523;width:52pt'>
 <col class=xl25 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl25 width=64 style='width:48pt'>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=12 height=28 class=xl52 width=1107 style='height:21.0pt;
  width:831pt'>WORKING TIME SUMMARY</td>
  <td class=xl25 width=64 style='width:48pt'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl25 style='height:20.25pt'></td>
  <td class=xl24>Reporter</td>
  <td class=xl55><%=p_user %></td>
  <td class=xl55></td>
  <td class=xl53></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl25 style='height:20.25pt'></td>
  <td class=xl24>Report Date</td>
  <td class=xl33 x:num><%= dt_total.Rows[0][0].ToString() %></td>
  <td class=xl56></td>
  <td class=xl29></td>
  <td class=xl54 x:str="Work Date   ">Work Date<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl57 x:num><%=p_from.Substring(6,2) + "/" + p_from.Substring(4,2) + "/" + p_from.Substring(0,4) %></td>
  <td class=xl58>~</td>
  <td class=xl57 x:num><%=p_to.Substring(6,2) + "/" + p_to.Substring(4,2) + "/" + p_to.Substring(0,4) %></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 colspan=4 class=xl26 style='height:20.25pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl31 height=43 style='mso-height-source:userset;height:32.25pt'>
  <td height=43 class=xl44 width=36 style='height:32.25pt;width:27pt'>No</td>
  <td class=xl45 width=125 style='width:94pt'>Organization</td>
  <td class=xl45 width=132 style='width:99pt'>Work Group</td>
  <td class=xl45 width=75 style='width:56pt'>Emp ID</td>
  <td class=xl46 width=211 style='width:158pt'>Full Name</td>
  <td class=xl47 width=86 style='width:65pt'>Join_Date</td>
  <td class=xl45 width=79 style='width:59pt'>WT</td>
  <td class=xl45 width=80 style='width:60pt'>OT</td>
  <td class=xl45 width=74 style='width:56pt'>NT</td>
  <td class=xl45 width=74 style='width:56pt'>NT2</td>
  <td class=xl45 width=69 style='width:52pt'>HT</td>
  <td class=xl45 width=69 style='width:52pt'>Total <br>
    WT + OT</td>
  <td class=xl45 width=71 style='width:53pt'>Total<br>
    OT + HT</td>
  <td class=xl31></td>
 </tr>
 <tr class=xl31 height=43 style='mso-height-source:userset;height:32.25pt'>
  <td height=43 class=xl48 width=36 style='height:32.25pt;border-top:none;
  width:27pt'>STT</td>
  <td class=xl49 width=125 style='border-top:none;width:94pt'>B&#7897;
  ph&#7853;n</td>
  <td class=xl49 width=132 style='border-top:none;width:99pt'>Nhóm</td>
  <td class=xl49 width=75 style='border-top:none;width:56pt'>Mã NV</td>
  <td class=xl50 width=211 style='border-top:none;width:158pt'>H&#7885; và tên
  NV</td>
  <td class=xl51 width=86 style='border-top:none;width:65pt'>Ngày vào</td>
  <td class=xl49 width=79 style='border-top:none;width:59pt'>Công</td>
  <td class=xl49 width=80 style='border-top:none;width:60pt'>T&#259;ng ca</td>
  <td class=xl49 width=74 style='border-top:none;width:56pt'>Trợ cấp ca
  &#273;êm</td>
  <td class=xl49 width=74 style='border-top:none;width:56pt'>T&#259;ng ca
  &#273;êm</td>
  <td class=xl49 width=69 style='border-top:none;width:52pt'>T&#259;ng ca ngày
  l&#7877;</td>
  <td class=xl49 width=69 style='border-top:none;width:52pt'>T&#7893;ng WT và
  OT</td>
  <td class=xl49 width=71 style='border-top:none;width:53pt'>T&#7893;ng OT và
  HT</td>
  <td class=xl31></td>
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
  <td height=30 class=xl34 width=36 style='height:22.5pt;border-top:none;
  width:27pt<%=s_format%>' x:num><%=i+1 %></td>
  <td class=xl35 width=125 style='border-top:none;width:94pt<%=s_format%>'><% = dt_total.Rows[i][1].ToString()%></td>
  <td class=xl35 width=132 style='border-top:none;width:99pt<%=s_format%>'><% = dt_total.Rows[i][2].ToString()%></td>
  <td class=xl38 width=75 style='border-top:none;width:56pt<%=s_format%>' x:num><% = dt_total.Rows[i][3].ToString()%></td>
  <td class=xl36 style='border-top:none<%=s_format%>'><% = dt_total.Rows[i][4].ToString()%></td>
  <td class=xl37 width=86 style='border-top:none;width:65pt<%=s_format%>' ><% = dt_total.Rows[i][5].ToString()%></td>
  <td class=xl38 width=79 style='border-top:none;width:59pt<%=s_format%>' x:num><% = dt_total.Rows[i][6].ToString()%></td>
  <td class=xl38 width=80 style='border-top:none;width:60pt<%=s_format%>' x:num><% = dt_total.Rows[i][7].ToString()%></td>
  <td class=xl38 width=74 style='border-top:none;width:56pt<%=s_format%>' x:num><% = dt_total.Rows[i][8].ToString()%></td>
  <td class=xl38 width=74 style='border-top:none;width:56pt<%=s_format%>' x:num><% = dt_total.Rows[i][12].ToString()%></td>
  <td class=xl38 width=69 style='border-top:none;width:52pt<%=s_format%>' x:num><% = dt_total.Rows[i][9].ToString()%></td>
  <td class=xl38 width=69 style='border-top:none;width:52pt<%=s_format%>' x:num><% = dt_total.Rows[i][10].ToString()%></td>
  <td class=xl38 width=71 style='border-top:none;width:53pt<%=s_format%>' x:num><% = dt_total.Rows[i][11].ToString()%></td>
  <td class=xl32></td>
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
  <td width=86 style='width:65pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
