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
   string p_train_type         = Request["p_train_type"].ToString();
   string p_from_start_dt         = Request["p_from_start_dt"].ToString();
   string p_to_start_dt           = Request["p_to_start_dt"].ToString();
   string p_have_train         = Request["p_have_train"].ToString();
   string p_from_end_dt           = Request["p_from_end_dt"].ToString();
   string p_to_end_dt             = Request["p_to_end_dt"].ToString();

   string SQL
= "SELECT 0 " +
   "            , B.ORG_NM " +
   "            , A.EMP_ID, A.FULL_NAME " +
   "            , C.WORKGROUP_NM " +
   "            , (SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0008' AND V.CODE= A.POS_TYPE ) " +
   "            , TO_CHAR(TO_DATE(A.JOIN_DT, 'YYYYMMDD'),'DD/MM/YYYY') " +
   "            , (SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0170' AND V.CODE= D.TRAIN_TYPE )  " +
   "            , D.TRAIN_NAME " +
   "            , TO_CHAR(TO_DATE(D.START_DT, 'YYYYMMDD'),'DD/MM/YYYY') " +
   "            , TO_CHAR(TO_DATE(D.END_DT, 'YYYYMMDD'),'DD/MM/YYYY') " +
   "            , D.LOCATION " +
   "            , D.INSTITUDE " +
   "            , DECODE(D.PASS_YN, 'Y', 'Yes', 'N', 'No', '') " +
   "            , D.DESCRIPTION " +
   "            , NVL(D.TIMES,0) " +
   "           FROM THR_EMPLOYEE A, COMM.TCO_ORG B, THR_WORK_GROUP C, " +
   "                (SELECT *   " +
   "                FROM THR_TRAIN_INTERNAL E  " +
   "                ,(SELECT MAX(C.PK) C_PK, MAX(NVL(C.TIMES,0)) C_TIMES FROM THR_TRAIN_INTERNAL C WHERE C.DEL_IF=0 GROUP BY C.THR_EMP_PK) T  " +
   "                WHERE E.DEL_IF=0 " +
   "                AND E.PK = T.C_PK) D " +
   "          WHERE A.DEL_IF = 0 " +
   "            AND B.DEL_IF = 0 " +
   "            AND C.DEL_IF = 0 " +
   "            AND A.TCO_ORG_PK = B.PK " +
   "            AND A.THR_WG_PK = C.PK " +
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
   "            AND DECODE ('" + p_train_type + "', 'ALL', '" + p_train_type + "', D.TRAIN_TYPE ) = '" + p_train_type + "' " +
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
   "            AND D.DEL_IF(+) = 0 " +
   "            AND  D.THR_EMP_PK = A.PK " +
   "            AND ((A.JOIN_DT BETWEEN '" + p_from_join_dt + "' AND '" + p_to_join_dt + "') OR ('" + p_from_join_dt + "' IS NULL) OR ('" + p_to_join_dt + "' IS NULL)) " +
   "            AND ((D.START_DT BETWEEN '" + p_from_start_dt + "' AND '" + p_to_start_dt + "') OR ('" + p_from_start_dt + "' IS NULL) OR ('" + p_to_start_dt + "' IS NULL)) " +
   "            AND ((D.END_DT BETWEEN '" + p_from_end_dt + "' AND '" + p_to_end_dt + "') OR ('" + p_from_end_dt + "' IS NULL) OR ('" + p_to_end_dt + "' IS NULL)) " +
   "            ORDER BY ORG_NM,WORKGROUP_NM,A.EMP_ID ";


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
<link rel=File-List href="rpt_internal_training_summary_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_internal_training_summary_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_internal_training_summary_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-09-13T07:21:42Z</o:LastPrinted>
  <o:Created>2008-05-23T07:19:16Z</o:Created>
  <o:LastSaved>2011-09-13T07:24:36Z</o:LastSaved>
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
.font11
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
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl67
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
	border-left:none;
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
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
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
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
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
	mso-number-format:"\@";
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
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl76
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
.xl77
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
.xl78
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
.xl79
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
.xl80
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
.xl81
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;}
.xl82
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	border:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl84
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
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl86
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl87
	{mso-style-parent:style0;
	color:#3366FF;
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
      <x:PaperSizeIndex>5</x:PaperSizeIndex>
      <x:Scale>64</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:LeftColumnVisible>5</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1931 style='border-collapse:
 collapse;table-layout:fixed;width:1448pt'>
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
 <col class=xl65 width=135 span=2 style='mso-width-source:userset;mso-width-alt:
 4937;width:101pt'>
 <col class=xl65 width=100 span=2 style='mso-width-source:userset;mso-width-alt:
 3657;width:75pt'>
 <col class=xl65 width=143 style='mso-width-source:userset;mso-width-alt:5229;
 width:107pt'>
 <col class=xl65 width=106 style='mso-width-source:userset;mso-width-alt:3876;
 width:80pt'>
 <col class=xl65 width=108 style='mso-width-source:userset;mso-width-alt:3949;
 width:81pt'>
 <col class=xl65 width=131 style='mso-width-source:userset;mso-width-alt:4790;
 width:98pt'>
 <col class=xl65 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <tr height=68 style='mso-height-source:userset;height:51.0pt'>
  <td colspan=16 height=68 class=xl86 width=1931 style='height:51.0pt;
  width:1448pt'>INTERNAL TRAINING<span style='mso-spacerun:yes'> 
  </span>LIST<br>
    <font class="font11">Danh sách nhân viên &#273;&#432;&#7907;c &#273;ào
  t&#7841;o n&#7897;i b&#7897;</font></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=14 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl82>Date : <%= dt_Com.Rows[0][5].ToString() %></td>
  <td class=xl65></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl65 style='height:15.75pt'></td>
  <td class=xl81></td>
  <td colspan=14 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl66 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl67 style='height:19.5pt'>No</td>
  <td class=xl68>Department</td>
  <td class=xl68>Emp ID</td>
  <td class=xl68>Full Name</td>
  <td class=xl68>Work Group</td>
  <td class=xl68>Position</td>
  <td class=xl68>Join Date</td>
  <td class=xl68>Train Type</td>
  <td class=xl68>Train Name</td>
  <td class=xl68>Start Date</td>
  <td class=xl68>End Date</td>
  <td class=xl68>Location</td>
  <td class=xl68>Institude</td>
  <td class=xl68>Pass YN</td>
  <td class=xl68>Description</td>
  <td class=xl68>Times</td>
 </tr>
 <tr class=xl66 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl69 style='height:19.5pt'>STT</td>
  <td class=xl70>B&#7897; ph&#7853;n</td>
  <td class=xl70>Mã NV</td>
  <td class=xl70>H&#7885; và tên</td>
  <td class=xl70>Nhóm</td>
  <td class=xl70>Ch&#7913;c v&#7909;</td>
  <td class=xl70>Ngày vào làm</td>
  <td class=xl70>Lo&#7841;i &#273;ào t&#7841;o</td>
  <td class=xl70>Tên khóa h&#7885;c</td>
  <td class=xl70>Ngày b&#7855;t &#273;&#7847;u</td>
  <td class=xl70>Ngày k&#7871;t thúc</td>
  <td class=xl70>&#272;&#7883;a &#273;i&#7875;m</td>
  <td class=xl70>Vi&#7879;n &#273;ào t&#7841;o</td>
  <td class=xl70>&#272;&#7841;t YN</td>
  <td class=xl70>Ghi chú</td>
  <td class=xl70>S&#7889; l&#7847;n</td>
 </tr>
 <% 
      int count = 0;
      for (int i = 0; i < irow; i++)
      {
          count++;
    %> 
 <tr class=xl71 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl72 style='height:21.75pt' x:num><%= count %></td>
  <td class=xl73><% = dt_total.Rows[i][1].ToString()%></td>
  <td class=xl74><% = dt_total.Rows[i][2].ToString()%></td>
  <td class=xl73><% = dt_total.Rows[i][3].ToString()%></td>
  <td class=xl80 style='border-top:none;border-left:none'><% = dt_total.Rows[i][4].ToString()%></td>
  <td class=xl80 style='border-top:none;border-left:none'><% = dt_total.Rows[i][5].ToString()%></td>
  <td class=xl74><% = dt_total.Rows[i][6].ToString()%></td>
  <td class=xl74><% = dt_total.Rows[i][7].ToString()%></td>
  <td class=xl74><% = dt_total.Rows[i][8].ToString()%></td>
  <td class=xl74><% = dt_total.Rows[i][9].ToString()%></td>
  <td class=xl74><% = dt_total.Rows[i][10].ToString()%></td>
  <td class=xl84><% = dt_total.Rows[i][11].ToString()%></td>
  <td class=xl84><% = dt_total.Rows[i][12].ToString()%></td>
  <td class=xl84><% = dt_total.Rows[i][13].ToString()%></td>
  <td class=xl84><% = dt_total.Rows[i][14].ToString()%></td>
  <td class=xl83 x:num><% = dt_total.Rows[i][15].ToString()%></td>
 </tr>
 <%} %>
 <tr class=xl71 height=3 style='mso-height-source:userset;height:2.25pt'>
  <td height=3 class=xl75 style='height:2.25pt'>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
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
  <td width=135 style='width:101pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=143 style='width:107pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=89 style='width:67pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
