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

   string p_tco_org_pk        = Request["p_tco_org_pk"].ToString();
   string p_wg_pk              = Request["p_wg_pk"].ToString();
   string p_position           = Request["p_position"].ToString();
   string p_nation           = Request["p_nation"].ToString();
   string p_status             = Request["p_status"].ToString();
   string p_from_join_dt            = Request["p_from_join_dt"].ToString();
   string p_to_join_dt           = Request["p_to_join_dt"].ToString();
   string p_search_by          = Request["p_search_by"].ToString();
   string p_search_temp        = Request["p_search_temp"].ToString();
   string p_from_start_dt         = Request["p_from_start_dt"].ToString();
   string p_to_start_dt           = Request["p_to_start_dt"].ToString();
   string p_from_end_dt           = Request["p_from_end_dt"].ToString();
   string p_to_end_dt             = Request["p_to_end_dt"].ToString();

   string SQL
    = "SELECT  0 " +
        "            , B.ORG_NM " +
        "            , A.EMP_ID " +
        "            , A.FULL_NAME " +
        "            , C.WORKGROUP_NM " +
        "            , (SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0008' AND V.CODE= A.POS_TYPE ) AS POSITION " +
        "            , TO_CHAR(TO_DATE(A.JOIN_DT, 'YYYYMMDD'),'DD/MM/YYYY') AS JOIN_DT " +
        "            , D.TRAIN_NAME " +
        "            , TO_CHAR(TO_DATE(D.START_DT, 'YYYYMMDD'),'DD/MM/YYYY') AS START_DT " +
        "            , TO_CHAR(TO_DATE(D.END_DT, 'YYYYMMDD'),'DD/MM/YYYY') AS END_DT " +
        "            , D.LOCATION " +
        "            , D.INSTITUDE " +
        "            , DECODE(D.PASS_YN,'Y', 'Yes', 'N', 'No', '') AS PASS_YN " +
        "            , 'Internal' " +
        "           FROM THR_EMPLOYEE A, COMM.TCO_ORG B, THR_WORK_GROUP C, THR_TRAIN_INTERNAL D " +
        "          WHERE A.DEL_IF = 0 " +
        "            AND B.DEL_IF = 0 " +
        "            AND C.DEL_IF = 0 " +
        "            AND D.DEL_IF = 0 " +
        "            AND A.TCO_ORG_PK = B.PK " +
        "            AND A.THR_WG_PK = C.PK " +
        "            AND  D.THR_EMP_PK = A.PK " +
        "            AND A.THR_WG_PK = DECODE('" + p_wg_pk + "','ALL', A.THR_WG_PK, '" + p_wg_pk + "') " +
   "            AND A.NATION = DECODE('" + p_nation + "','ALL', A.NATION, '" + p_nation + "') " +
   "            AND UPPER (DECODE ('" + p_search_by + "', " +
   "                              1, A.FULL_NAME, " +
   "                              2, A.EMP_ID, " +
   "                              3,A.ID_NUM, " +
   "                              4,PERSON_ID, " +
   "                              OLD_ID) " +
   "                     ) LIKE '%' || UPPER ('" + p_search_temp + "') || '%' " +
   "            AND DECODE ('" + p_status + "', 'ALL', '" + p_status + "', A.STATUS) = '" + p_status + "' " +
   "            AND (   A.TCO_ORG_PK IN ( " +
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
   "            AND ((A.JOIN_DT BETWEEN '" + p_from_join_dt + "' AND '" + p_to_join_dt + "') OR ('" + p_from_join_dt + "' IS NULL) OR ('" + p_to_join_dt + "' IS NULL)) " +
   "            AND ((D.START_DT BETWEEN '" + p_from_start_dt + "' AND '" + p_to_start_dt + "') OR ('" + p_from_start_dt + "' IS NULL) OR ('" + p_to_start_dt + "' IS NULL)) " +
   "            AND ((D.END_DT BETWEEN '" + p_from_end_dt + "' AND '" + p_to_end_dt + "') OR ('" + p_from_end_dt + "' IS NULL) OR ('" + p_to_end_dt + "' IS NULL)) " +
        " UNION ALL " +
        " SELECT  0  " +
        "            , B.ORG_NM " +
        "            , A.EMP_ID, A.FULL_NAME " +
        "            , C.WORKGROUP_NM " +
        "            , (SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0008' AND V.CODE= A.POS_TYPE ) AS POSITION " +
        "            , TO_CHAR(TO_DATE(A.JOIN_DT, 'YYYYMMDD'),'DD/MM/YYYY') JOIN_DT " +
        "            , Q.COURSE_ID||'-'||Q.COURSE_NAME AS TRAIN_NAME " +
        "            , TO_CHAR(TO_DATE(Q.START_DT, 'YYYYMMDD'),'DD/MM/YYYY') AS START_DT " +
        "            , TO_CHAR(TO_DATE(Q.END_DT, 'YYYYMMDD'),'DD/MM/YYYY') AS END_DT " +
        "            , Q.LOCATION " +
        "            , Q.TRAIN_INSTITUTION AS INTITUTION " +
        "            , DECODE(D.PASS_YN,'Y', 'Yes', 'N', 'No', '') PASS_YN " +
        "            , 'Company' " +
        "           FROM THR_EMPLOYEE A, COMM.TCO_ORG B, THR_WORK_GROUP C, THR_TRAIN_REQD D, THR_TRAIN_REQ R, THR_TRAIN_COURSE Q " +
        "          WHERE A.DEL_IF = 0 AND R.DEL_IF=0 AND Q.DEL_IF=0 " +
        "            AND B.DEL_IF = 0 " +
        "            AND C.DEL_IF = 0 " +
        "            AND D.DEL_IF = 0 " +
        "            AND D.THR_TRAIN_REQ_PK = R.PK " +
        "            AND R.THR_TRAIN_COURSE_PK = Q.PK " +
        "            AND A.TCO_ORG_PK = B.PK " +
        "            AND A.THR_WG_PK = C.PK " +
        "            AND  D.TRAINEE_PK = A.PK " +
        "            AND D.PASS_YN IS NOT NULL " +
        "            AND A.THR_WG_PK = DECODE('" + p_wg_pk + "','ALL', A.THR_WG_PK, '" + p_wg_pk + "') " +
   "            AND A.NATION = DECODE('" + p_nation + "','ALL', A.NATION, '" + p_nation + "') " +
   "            AND UPPER (DECODE ('" + p_search_by + "', " +
   "                              1, A.FULL_NAME, " +
   "                              2, A.EMP_ID, " +
   "                              3,A.ID_NUM, " +
   "                              4,PERSON_ID, " +
   "                              OLD_ID) " +
   "                     ) LIKE '%' || UPPER ('" + p_search_temp + "') || '%' " +
   "            AND DECODE ('" + p_status + "', 'ALL', '" + p_status + "', A.STATUS) = '" + p_status + "' " +
   "            AND (   A.TCO_ORG_PK IN ( " +
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
   "            AND ((A.JOIN_DT BETWEEN '" + p_from_join_dt + "' AND '" + p_to_join_dt + "') OR ('" + p_from_join_dt + "' IS NULL) OR ('" + p_to_join_dt + "' IS NULL)) " +
   "            AND ((Q.START_DT BETWEEN '" + p_from_start_dt + "' AND '" + p_to_start_dt + "') OR ('" + p_from_start_dt + "' IS NULL) OR ('" + p_to_start_dt + "' IS NULL)) " +
   "            AND ((Q.END_DT BETWEEN '" + p_from_end_dt + "' AND '" + p_to_end_dt + "') OR ('" + p_from_end_dt + "' IS NULL) OR ('" + p_to_end_dt + "' IS NULL)) " +
        "        order by  3,14 desc ";



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


    //-----------------information of company-----------------
    string SQL_Com
    = "select  a.TCO_BPPHOTO_PK,a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,A.FAX_no, to_char(sysdate, 'dd/mm/yyyy') " +
        "from comm.tco_company a " +
        "where a.DEL_IF=0 and rownum=1 ";
       


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

 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_training_history_summary_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_training_history_summary_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_training_history_summary_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-09-13T07:21:42Z</o:LastPrinted>
  <o:Created>2008-05-23T07:19:16Z</o:Created>
  <o:LastSaved>2011-09-14T02:49:16Z</o:LastSaved>
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
	margin:.41in .11in .26in .15in;
	mso-header-margin:.24in;
	mso-footer-margin:.14in;
	mso-page-orientation:landscape;}
.font8
	{color:#3366FF;
	font-size:18.0pt;
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
.xl65
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl68
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
.xl69
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
	background:#99CCFF;
	mso-pattern:auto none;}
.xl70
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
	background:#99CCFF;
	mso-pattern:auto none;}
.xl71
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
	background:#99CCFF;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl73
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
.xl74
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
.xl75
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
.xl76
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
.xl77
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
	color:#3366FF;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl84
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
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
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>5</x:PaperSizeIndex>
      <x:Scale>64</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
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
  <x:Formula>=Sheet1!$4:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl65>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1719 style='border-collapse:
 collapse;table-layout:fixed;width:1289pt'>
 <col class=xl65 width=42 style='mso-width-source:userset;mso-width-alt:1536;
 width:32pt'>
 <col class=xl65 width=180 style='mso-width-source:userset;mso-width-alt:6582;
 width:135pt'>
 <col class=xl65 width=91 style='mso-width-source:userset;mso-width-alt:3328;
 width:68pt'>
 <col class=xl65 width=194 style='mso-width-source:userset;mso-width-alt:7094;
 width:146pt'>
 <col class=xl65 width=131 span=2 style='mso-width-source:userset;mso-width-alt:
 4790;width:98pt'>
 <col class=xl65 width=115 style='mso-width-source:userset;mso-width-alt:4205;
 width:86pt'>
 <col class=xl65 width=135 style='mso-width-source:userset;mso-width-alt:4937;
 width:101pt'>
 <col class=xl65 width=100 span=2 style='mso-width-source:userset;mso-width-alt:
 3657;width:75pt'>
 <col class=xl65 width=143 style='mso-width-source:userset;mso-width-alt:5229;
 width:107pt'>
 <col class=xl65 width=106 style='mso-width-source:userset;mso-width-alt:3876;
 width:80pt'>
 <col class=xl65 width=108 style='mso-width-source:userset;mso-width-alt:3949;
 width:81pt'>
 <col class=xl65 width=143 style='mso-width-source:userset;mso-width-alt:5229;
 width:107pt'>
 <tr height=68 style='mso-height-source:userset;height:51.0pt'>
  <td colspan=14 height=68 class=xl83 width=1719 style='height:51.0pt;
  width:1289pt'>TRAINING HISTORY LIST<br>
    <font class="font8">Danh sách lý l&#7883;ch &#273;ào t&#7841;o</font></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=12 class=xl65 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl84 style='border-right:.5pt solid black'>Date :
  <%= dt_Com.Rows[0][5].ToString() %></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl65 style='height:15.75pt'></td>
  <td class=xl66></td>
  <td colspan=12 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl67 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl68 style='height:19.5pt'>No</td>
  <td class=xl69>Department</td>
  <td class=xl69>Emp ID</td>
  <td class=xl69>Full Name</td>
  <td class=xl69>Work Group</td>
  <td class=xl69>Position</td>
  <td class=xl69>Join Date</td>
  <td class=xl69>Train Name</td>
  <td class=xl69>Start Date</td>
  <td class=xl69>End Date</td>
  <td class=xl69>Location</td>
  <td class=xl69>Institude</td>
  <td class=xl69>Pass YN</td>
  <td class=xl69>Scope</td>
 </tr>
 <tr class=xl67 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl70 style='height:19.5pt'>STT</td>
  <td class=xl71>B&#7897; ph&#7853;n</td>
  <td class=xl71>Mã NV</td>
  <td class=xl71>H&#7885; và tên</td>
  <td class=xl71>Nhóm</td>
  <td class=xl71>Ch&#7913;c v&#7909;</td>
  <td class=xl71>Ngày vào làm</td>
  <td class=xl71>Tên khóa h&#7885;c</td>
  <td class=xl71>Ngày b&#7855;t &#273;&#7847;u</td>
  <td class=xl71>Ngày k&#7871;t thúc</td>
  <td class=xl71>&#272;&#7883;a &#273;i&#7875;m</td>
  <td class=xl71>Vi&#7879;n &#273;ào t&#7841;o</td>
  <td class=xl71>&#272;&#7841;t YN</td>
  <td class=xl71>Ph&#7841;m vi</td>
 </tr>
  <% 
      int count = 0;
      for (int i = 0; i < irow; i++)
      {
          count++;
    %> 
 <tr class=xl72 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl73 style='height:21.75pt' x:num><%= count %></td>
  <td class=xl74><% = dt_total.Rows[i][1].ToString()%></td>
  <td class=xl75><% = dt_total.Rows[i][2].ToString()%></td>
  <td class=xl74><% = dt_total.Rows[i][3].ToString()%></td>
  <td class=xl76><% = dt_total.Rows[i][4].ToString()%></td>
  <td class=xl76><% = dt_total.Rows[i][5].ToString()%></td>
  <td class=xl75><% = dt_total.Rows[i][6].ToString()%></td>
  <td class=xl75><% = dt_total.Rows[i][7].ToString()%></td>
  <td class=xl75><% = dt_total.Rows[i][8].ToString()%></td>
  <td class=xl75><% = dt_total.Rows[i][9].ToString()%></td>
  <td class=xl77><% = dt_total.Rows[i][10].ToString()%></td>
  <td class=xl77><% = dt_total.Rows[i][11].ToString()%></td>
  <td class=xl77><% = dt_total.Rows[i][12].ToString()%></td>
  <td class=xl77><% = dt_total.Rows[i][13].ToString()%></td>
 </tr>
  <%} %>
 <tr class=xl72 height=3 style='mso-height-source:userset;height:2.25pt'>
  <td height=3 class=xl78 style='height:2.25pt'>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl82>&nbsp;</td>
  <td class=xl82>&nbsp;</td>
  <td class=xl82>&nbsp;</td>
  <td class=xl82>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=42 style='width:32pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=194 style='width:146pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=135 style='width:101pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=143 style='width:107pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=143 style='width:107pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
