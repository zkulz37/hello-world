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
    string p_tco_org_pk = Request.QueryString["p_tco_org_pk"];
    
    string SQL_Com
    = "select  a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,a.TCO_BPPHOTO_PK " +
        "from tco_company a " +
        "where a.DEL_IF=0 " +
        "and a.pk in ( select tco_company_pk from  " +
        "               tco_org  f " +
        "               where  f.pk IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +        
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_tco_org_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_tco_org_pk + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_tco_org_pk + "' = 'ALL') " +
        "and rownum=1 ";

    //Response.Write(SQL_Com);
    //Response.End();
    DataTable dt_Com = ESysLib.TableReadOpen(SQL_Com);
    int irow_com;
    irow_com = dt_Com.Rows.Count;
    if (irow_com == 0)
    {
        Response.Write("There is no data of company");
        Response.End();
    }
    int pk = int.Parse(dt_Com.Rows[0][3].ToString());/**/

    //p_dept=ALL&p_group=ALL&lstWS=ALL&fromdt=20080701&todt=20081001&idsearch=1&idtmp=
    string p_group, p_ws, p_fromdt, p_todt, p_id_search, p_tmp;
    p_group = Request.QueryString["p_group"];
    p_ws = Request.QueryString["p_ws"];
    p_fromdt = Request.QueryString["p_fromdt"];
    p_todt = Request.QueryString["p_todt"];
    p_id_search = Request.QueryString["p_id_search"];
    p_tmp = Request.QueryString["p_tmp"];

    string SQL
    = "SELECT D.THR_EMP_PK AS THR_EMP_PK,T.org_NM, E.workGROUP_NM,V.EMP_ID,V.FULL_NAME,S.REMARK  " +
        "        ,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD'),'DD/MM/YYYY') AS W_DATE  " +
        "        ,MAX(D.WORK_TIME) AS WT,MAX(D.PAY_RATE) AS WT_RATE  " +
       "        ,MAX(DECODE(H.OT_TYPE,'OT',NVL(DECODE(H.OT_TIME,0,'',H.OT_TIME),''),'')) AS OT " +
        "        ,MAX(DECODE(H.OT_TYPE,'OT',NVL(DECODE(H.OT_TIME,0,'',H.PAY_RATE),''),'')) AS OT_RATE " +
        "        ,MAX(DECODE(H.OT_TYPE,'NT',NVL(DECODE(H.OT_TIME,0,'',H.OT_TIME),''),'')) AS NT " +
        "        ,MAX(DECODE(H.OT_TYPE,'NT',NVL(DECODE(H.OT_TIME,0,'',H.PAY_RATE),''),'')) AS NT_RATE " +
        "        ,MAX(DECODE(H.OT_TYPE,'NT2',NVL(DECODE(H.OT_TIME,0,'',H.OT_TIME),''),'')) AS NT2 " +
        "        ,MAX(DECODE(H.OT_TYPE,'NT2',NVL(DECODE(H.OT_TIME,0,'',H.PAY_RATE),''),'')) AS NT2_RATE " +
		"        ,MAX(DECODE(H.OT_TYPE,'NT3',NVL(DECODE(H.OT_TIME,0,'',H.OT_TIME),''),'')) AS NT3 " +
        "        ,MAX(DECODE(H.OT_TYPE,'NT3',NVL(DECODE(H.OT_TIME,0,'',H.PAY_RATE),''),'')) AS NT3_RATE " +
        "        ,MAX(DECODE(H.OT_TYPE,'HT',NVL(DECODE(H.OT_TIME,0,'',H.OT_TIME),''),'')) AS HT " +
        "        ,MAX(DECODE(H.OT_TYPE,'HT',NVL(DECODE(H.OT_TIME,0,'',H.PAY_RATE),''),'')) AS HT_RATE " +
        "        ,MAX(D.PK) AS WT_PK  " +
        "        ,MAX(DECODE(H.OT_TYPE,'OT',H.PK,0)) AS OT_PK  " +
        "        ,MAX(DECODE(H.OT_TYPE,'NT',H.PK,0)) AS NT_PK  " +
        "        ,MAX(DECODE(H.OT_TYPE,'HT',H.PK,0)) AS HT_PK  " +
        "        ,MAX(D.WORK_DT) AS WD_TEMP  " +
        "        FROM THR_TIME_MACHINE D,THR_EXTRA_TIME H,THR_EMPLOYEE V,THR_work_GROUP E,THR_WORK_SHIFT S  " +
        "            , TCO_org T  " +
        "          WHERE D.DEL_IF = 0 AND H.DEL_IF(+)=0 AND V.DEL_IF=0 AND E.DEL_IF=0 AND S.DEL_IF=0  " +
        "            AND T.DEL_IF=0  " +
        "            AND V.TCO_org_PK=T.PK   " +
        "          AND V.PK=D.THR_EMP_PK AND D.THR_EMP_PK=H.THR_EMP_PK(+)  " +
        "          AND D.WORK_DT=H.WORK_DT(+) AND V.THR_wg_PK=E.PK AND D.THR_WS_PK=S.PK  " +
        "          AND D.WORK_DT BETWEEN '"+p_fromdt+"' AND '"+p_todt+"'  " +
        "          AND D.WORK_TIME IS NOT NULL " +
        "           AND DECODE('" + p_ws + "','ALL','" + p_ws + "',D.THR_WS_PK)='" + p_ws + "' " +
        "           AND DECODE('" + p_group + "','ALL','" + p_group + "',E.PK)='" + p_group + "' " +
        "           AND (DECODE('" + p_id_search + "','1',UPPER(V.EMP_ID),'2',V.ID_NUM,'3',UPPER(V.FULL_NAME)) LIKE '%'||UPPER('"+p_tmp+"') " +
        "                OR '"+p_tmp+"' IS NULL)  " ;
        SQL = SQL + "      AND (    v.TCO_ORG_PK IN ( ";
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
        "     GROUP BY  D.THR_EMP_PK,D.WORK_DT,T.org_NM ,E.workGROUP_NM,V.EMP_ID,V.FULL_NAME,S.REMARK  " +
        "     ORDER BY E.workGROUP_NM,D.WORK_DT,D.THR_EMP_PK   ";
    //Response.Write(SQL);
    //Response.End();        
    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
    if (dt_emp.Rows.Count == 0)
    {
        Response.Write("There is no data to print");
        Response.End();
    }
    int emp_row = dt_emp.Rows.Count;

    //p_fromdt = p_fromdt.Insert(4, "-");
    //p_fromdt = p_fromdt.Insert(7, "-");
    //p_todt = p_todt.Insert(4, "-");
    //p_todt = p_todt.Insert(7, "-");
    
    p_fromdt = p_fromdt.Insert(6, "-").Insert(4, "-");
    p_todt = p_todt.Insert(6, "-").Insert(4, "-");
    //Response.Write(p_fromdt);
    //Response.End();
    
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_working_rate_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_working_rate_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_working_rate_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>EINSVINA</o:Author>
  <o:LastAuthor>Hee</o:LastAuthor>
  <o:LastPrinted>2008-10-01T06:29:40Z</o:LastPrinted>
  <o:Created>2006-12-21T09:46:33Z</o:Created>
  <o:LastSaved>2008-10-01T08:22:25Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.26in .24in .4in .33in;
	mso-header-margin:.18in;
	mso-footer-margin:.18in;}
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
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
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
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:13.0pt;
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
.xl34
	{mso-style-parent:style0;
	color:black;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	color:black;
	font-size:13.0pt;
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
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	color:black;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	color:black;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:13.0pt;
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
	mso-pattern:#CCCCFF none;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl50
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl52
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:#CCCCFF none;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:#CCCCFF none;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:#CCCCFF none;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-size:13.0pt;
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
	mso-pattern:#CCCCFF none;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>61</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>16</x:TopRowBottomPane>
     <x:SplitVertical>6</x:SplitVertical>
     <x:LeftColumnRightPane>6</x:LeftColumnRightPane>
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
       <x:ActiveRow>4</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
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
  <x:WindowHeight>5475</x:WindowHeight>
  <x:WindowWidth>10770</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1137 style='border-collapse:
 collapse;table-layout:fixed;width:857pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=97 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <col class=xl24 width=130 style='mso-width-source:userset;mso-width-alt:4754;
 width:98pt'>
 <col class=xl24 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl24 width=201 style='mso-width-source:userset;mso-width-alt:7350;
 width:151pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 width=75 style='height:24.75pt;width:56pt' align=left
  valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75" coordsize="21600,21600"
   o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe" filled="f"
   stroked="f">
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
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:1.5pt;margin-top:5.25pt;width:53.25pt;height:43.5pt;z-index:1'>
   <v:imagedata src="rpt_working_rate_files/image001.png" o:title="vinagenuwin"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF></x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:2px;margin-top:7px;width:71px;
  height:58px'><img width=71 height=58 src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=pk%>&table_name=<%=Session["APP_DBUSER"].ToString()%>.tco_bpphoto"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=33 class=xl24 width=75 style='height:24.75pt;width:56pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl51 colspan=2 width=227 style='mso-ignore:colspan;width:171pt'><%=dt_Com.Rows[0][0].ToString() %></td>
  <td class=xl49 width=80 style='width:60pt'></td>
  <td class=xl49 width=201 style='width:151pt'></td>
  <td class=xl24 width=93 style='width:70pt'></td>
  <td class=xl50 width=58 style='width:44pt'>WORKING RATE SUMMARY</td>
  <td class=xl49 width=58 style='width:44pt'></td>
  <td class=xl49 width=58 style='width:44pt'></td>
  <td class=xl49 width=58 style='width:44pt'></td>
  <td class=xl49 width=58 style='width:44pt'></td>
  <td class=xl49 width=58 style='width:44pt'></td>
  <td class=xl49 width=58 style='width:44pt'></td>
  <td class=xl49 width=55 style='width:41pt'></td>
 </tr>
 <tr class=xl28 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl27 style='height:26.25pt'></td>
  <td class=xl51 colspan=3 style='mso-ignore:colspan'><%=dt_Com.Rows[0][1].ToString() %>
  -<span style='mso-spacerun:yes'>  </span><%=dt_Com.Rows[0][2].ToString() %></td>
  <td class=xl29 x:str>From<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl56 ><%=DateTime.Parse(p_fromdt).ToString("dd-MM-yyyy")%></td>
  <td class=xl31>To</td>
  <td colspan=2 class=xl56 ><%=DateTime.Parse(p_todt).ToString("dd-MM-yyyy")%></td>
  <td class=xl30></td>
  <td class=xl28></td>
  <td class=xl30></td>
  <td class=xl28></td>
 </tr>
 <tr class=xl25 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td rowspan=2 height=66 class=xl52 width=75 style='border-bottom:.5pt solid black;
  height:49.5pt;width:56pt'>No.</td>
  <td rowspan=2 class=xl52 width=97 style='border-bottom:.5pt solid black;
  width:73pt'>Organization</td>
  <td rowspan=2 class=xl52 width=130 style='border-bottom:.5pt solid black;
  width:98pt'>Work Group</td>
  <td rowspan=2 class=xl52 width=80 style='border-bottom:.5pt solid black;
  width:60pt'>Emp ID</td>
  <td rowspan=2 class=xl52 width=201 style='border-bottom:.5pt solid black;
  width:151pt'>Full Name</td>
  <td rowspan=2 class=xl52 width=93 style='border-bottom:.5pt solid black;
  border-top:none;width:70pt'>Work Date</td>
  <td colspan=2 class=xl54 width=116 style='border-right:.5pt solid black;
  border-left:none;width:88pt'>WT</td>
  <td colspan=2 class=xl54 width=116 style='border-right:.5pt solid black;
  border-left:none;width:88pt'>OT</td>
  <td colspan=2 class=xl54 width=116 style='border-right:.5pt solid black;
  border-left:none;width:88pt'>NT</td>
  <td colspan=2 class=xl54 width=116 style='border-right:.5pt solid black;
  border-left:none;width:88pt'>NT2</td>
  <td colspan=2 class=xl54 width=116 style='border-right:.5pt solid black;
  border-left:none;width:88pt'>NT3</td>
  <td colspan=2 class=xl54 width=113 style='border-right:.5pt solid black;
  border-left:none;width:85pt'>HT</td>
 </tr>
 <tr class=xl25 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl42 width=58 style='height:27.0pt;border-top:none;
  width:44pt'>Hours</td>
  <td class=xl42 width=58 style='border-top:none;width:44pt'>Rate</td>
  <td class=xl42 width=58 style='border-top:none;width:44pt'>Hours</td>
  <td class=xl42 width=58 style='border-top:none;width:44pt'>Rate</td>
  <td class=xl42 width=58 style='border-top:none;width:44pt'>Hours</td>
  <td class=xl42 width=58 style='border-top:none;width:44pt'>Rate</td>
  <td class=xl42 width=58 style='border-top:none;width:44pt'>Hours</td>
  <td class=xl42 width=58 style='border-top:none;width:44pt'>Rate</td>
  <td class=xl42 width=58 style='border-top:none;width:44pt'>Hours</td>
  <td class=xl42 width=55 style='border-top:none;width:41pt'>Rate</td>
  <td class=xl42 width=58 style='border-top:none;width:44pt'>Hours</td>
  <td class=xl42 width=55 style='border-top:none;width:41pt'>Rate</td>
 </tr>
 <%
     int i = 0;
     for (i = 0; i < emp_row; i++)
     {
 %>
 <tr class=xl26 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl32 style='height:30.0pt;border-top:none' x:num><%=i+1 %></td>
  <td class=xl33 style='border-top:none'><%=dt_emp.Rows[i][1].ToString() %></td>
  <td class=xl33 style='border-top:none'><%=dt_emp.Rows[i][2].ToString() %></td>
  <td class=xl34 style='border-top:none'><%=dt_emp.Rows[i][3].ToString() %></td>
  <td class=xl35 style='border-top:none'><%=dt_emp.Rows[i][4].ToString() %></td>
  <td class=xl36 style='border-top:none' x:num><%=dt_emp.Rows[i][6].ToString() %></td>
  <td class=xl45 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][7].ToString() %></td>
  <td class=xl44 style='border-top:none' x:num><%=dt_emp.Rows[i][8].ToString() %></td>
  <td class=xl43 style='border-top:none' x:num><%=dt_emp.Rows[i][9].ToString() %></td>
  <td class=xl44 style='border-top:none' x:num><%=dt_emp.Rows[i][10].ToString() %></td>
  <td class=xl43 style='border-top:none' x:num><%=dt_emp.Rows[i][11].ToString() %></td>
  <td class=xl44 style='border-top:none' x:num><%=dt_emp.Rows[i][12].ToString() %></td>
  <td class=xl43 style='border-top:none' x:num><%=dt_emp.Rows[i][13].ToString() %></td>
  <td class=xl44 style='border-top:none' x:num><%=dt_emp.Rows[i][14].ToString() %></td>
  
  <td class=xl43 style='border-top:none' x:num><%=dt_emp.Rows[i][15].ToString() %></td>
  <td class=xl44 style='border-top:none' x:num><%=dt_emp.Rows[i][16].ToString() %></td>
  <td class=xl43 style='border-top:none' x:num><%=dt_emp.Rows[i][17].ToString() %></td>
  <td class=xl44 style='border-top:none' x:num><%=dt_emp.Rows[i][18].ToString() %></td>
 </tr>
 <%
     }
 %>
 <tr >

 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=75 style='width:56pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=130 style='width:98pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=201 style='width:151pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=55 style='width:41pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
