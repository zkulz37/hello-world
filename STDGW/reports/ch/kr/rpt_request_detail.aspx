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

    string P_TCO_ORG_PK        = Request["p_tco_org_pk"].ToString();
    string P_CATEGORY          = Request["p_category"].ToString();
    string P_COURSE            = Request["p_course"].ToString();
    string P_APPLICATION       = Request["p_application"].ToString();
    string P_STATUS          = Request["p_status"].ToString();
    string P_FROM_REQ        = Request["p_from_req"].ToString();
    string P_TO_REQ          = Request["p_to_req"].ToString();
    string P_STATUS_TRAINEE  = Request["p_status_trainee"].ToString();
    
   string SQL
    = "SELECT " + 
        "          B.COURSE_ID ||'-'||B.COURSE_NAME " +
        "          ,A.REQ_NO||'-'||B.COURSE_NAME " +
        "          ,E.EMP_ID " +
        "          ,E.FULL_NAME " +
        "          ,G.ORG_NM " +
        "          ,(SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0008' AND V.CODE =  E.POS_TYPE ) " +
        "          ,TO_CHAR(TO_DATE(E.JOIN_DT, 'YYYYMMDD'),'DD/MM/YYYY') " +
        "          ,(SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0090' AND V.CODE =  C.STATUS) " +
        "          ,(SELECT K.FULL_NAME FROM THR_EMPLOYEE K WHERE K.DEL_IF=0 AND K.PK = A.APPROVER_PK) " +
        "          ,C.DESCRIPTION " +
        "    FROM THR_TRAIN_REQ A, THR_TRAIN_COURSE B, THR_TRAIN_REQD C, THR_EMPLOYEE E, COMM.TCO_ORG G " +
        "        WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0 AND E.DEL_IF=0 AND G.DEL_IF=0 " +
        "            AND A.THR_TRAIN_COURSE_PK = B.PK AND C.THR_TRAIN_REQ_PK = A.PK " +
        "            AND C.TRAINEE_PK = E.PK AND E.TCO_ORG_PK = G.PK " +
        "            AND DECODE('"+ P_STATUS +"','ALL', 'ALL', A.STATUS )='"+ P_STATUS +"' " +
        "            AND DECODE('"+ P_STATUS_TRAINEE +"','ALL', 'ALL', C.STATUS )='"+ P_STATUS_TRAINEE +"' " +
        "            AND DECODE('"+ P_APPLICATION +"','ALL', 'ALL', A.PK )='"+ P_APPLICATION +"' " +
        "            AND DECODE('"+ P_COURSE +"','ALL', 'ALL', B.PK )='"+ P_COURSE +"' " +
        "            AND DECODE('"+ P_CATEGORY +"','ALL', 'ALL', B.CATEGORY )='"+ P_CATEGORY +"' " +
        "            AND (('"+ P_FROM_REQ +"' IS NULL AND '"+ P_TO_REQ +"' IS NULL) OR " +
        "                      A.REQUIRE_DATE BETWEEN '"+ P_FROM_REQ +"' AND '"+ P_TO_REQ +"') " +
        "            AND A.REQ_EMP_PK IN (SELECT E.PK FROM THR_EMPLOYEE E, COMM.TCO_ORG C  " +
        "                                    WHERE E.DEL_IF=0 AND C.DEL_IF=0 " +
        "                                        AND E.TCO_ORG_PK IN ( " +
        "                                                              SELECT     G.PK " +
        "                                                                    FROM COMM.TCO_ORG G " +
        "                                                                   WHERE G.DEL_IF = 0 " +
        "                                                              START WITH G.PK = " +
        "                                                                            DECODE ('"+ P_TCO_ORG_PK +"', " +
        "                                                                                    'ALL', 0, " +
        "                                                                                    '"+ P_TCO_ORG_PK +"' " +
        "                                                                                   ) " +
        "                                                              CONNECT BY PRIOR G.PK = G.P_PK) " +
        "                                 ) " +
        "            ORDER BY 2,3 " ;


	//Response.Write(SQL);
      //  Response.End();

    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt_emp.Rows.Count;
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
<link rel=File-List href="rpt_request_detail_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_request_detail_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_request_detail_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-09-07T02:59:24Z</o:LastPrinted>
  <o:Created>2008-05-23T07:19:16Z</o:Created>
  <o:LastSaved>2011-09-07T04:05:45Z</o:LastSaved>
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
	border-left:none;
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
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl70
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
.xl71
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
.xl72
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
.xl73
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
.xl74
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
.xl75
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
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;}
.xl77
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
.xl78
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
.xl79
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
.xl80
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl81
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl82
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl83
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
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
      <x:Scale>81</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1536 style='border-collapse:
 collapse;table-layout:fixed;width:1154pt'>
 <col class=xl65 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl65 width=203 style='mso-width-source:userset;mso-width-alt:7424;
 width:152pt'>
 <col class=xl65 width=171 style='mso-width-source:userset;mso-width-alt:6253;
 width:128pt'>
 <col class=xl65 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl65 width=194 style='mso-width-source:userset;mso-width-alt:7094;
 width:146pt'>
 <col class=xl65 width=158 style='mso-width-source:userset;mso-width-alt:5778;
 width:119pt'>
 <col class=xl65 width=143 style='mso-width-source:userset;mso-width-alt:5229;
 width:107pt'>
 <col class=xl65 width=120 style='mso-width-source:userset;mso-width-alt:4388;
 width:90pt'>
 <col class=xl65 width=122 style='mso-width-source:userset;mso-width-alt:4461;
 width:92pt'>
 <col class=xl65 width=150 style='mso-width-source:userset;mso-width-alt:5485;
 width:113pt'>
 <col class=xl65 width=131 style='mso-width-source:userset;mso-width-alt:4790;
 width:98pt'>
 <tr height=68 style='mso-height-source:userset;height:51.0pt'>
  <td height=68 class=xl65 width=62 style='height:51.0pt;width:47pt'></td>
  <td colspan=10 class=xl80 width=1474 style='width:1107pt'>TRAINEE LIST<br>
    <font class="font11">Danh sách nhân viên &#273;&#432;&#7907;c &#273;ào
  t&#7841;o</font></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=9 class=xl65 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl82 style='border-right:.5pt solid black'>Date :
  <%= dt_Com.Rows[0][5].ToString() %></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl65 style='height:15.75pt'></td>
  <td class=xl76></td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl66 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl67 style='height:19.5pt'>No</td>
  <td class=xl67>Course Name</td>
  <td class=xl67>Application</td>
  <td class=xl67>Emp ID</td>
  <td class=xl67>Full Name</td>
  <td class=xl67>Organization</td>
  <td class=xl67>Position</td>
  <td class=xl67>Join Date</td>
  <td class=xl67>Status</td>
  <td class=xl67>Approver</td>
  <td class=xl67>Description</td>
 </tr>

 <tr class=xl66 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl68 style='height:19.5pt'>STT</td>
  <td class=xl68>Tên khóa &#273;ào t&#7841;o</td>
  <td class=xl68>&#272;&#417;n yêu c&#7847;u</td>
  <td class=xl68>Mã NV</td>
  <td class=xl68>H&#7885; và tên</td>
  <td class=xl68>Phòng ban</td>
  <td class=xl68>Ch&#7913;c v&#7909;</td>
  <td class=xl68>Ngày vào làm</td>
  <td class=xl68>Tình tr&#7841;ng</td>
  <td class=xl68>Ng&#432;&#7901;i phê duy&#7879;t</td>
  <td class=xl68>Ghi chú</td>
 </tr>
  <%
    int count =0;
    for (int i = 0; i < irow; i++)
     {
         count++;
  %>
 <tr class=xl69 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl71 style='height:21.75pt'><%= count %></td>
  <td class=xl78><%= dt_emp.Rows[i][0].ToString() %></td>
  <td class=xl78 x:str><%= dt_emp.Rows[i][1].ToString() %><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl71><%= dt_emp.Rows[i][2].ToString() %></td>
  <td class=xl70><%= dt_emp.Rows[i][3].ToString() %></td>
  <td class=xl75 style='border-top:none;border-left:none'><%= dt_emp.Rows[i][4].ToString() %></td>
  <td class=xl78><%= dt_emp.Rows[i][5].ToString() %></td>
  <td class=xl71><%= dt_emp.Rows[i][6].ToString() %></td>
  <td class=xl77><%= dt_emp.Rows[i][7].ToString() %></td>
  <td class=xl77><%= dt_emp.Rows[i][8].ToString() %></td>
  <td class=xl71><%= dt_emp.Rows[i][9].ToString() %></td>
 </tr>
 <%} %>
 <tr class=xl69 height=3 style='mso-height-source:userset;height:2.25pt'>
  <td height=3 class=xl73 style='height:2.25pt'>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=62 style='width:47pt'></td>
  <td width=203 style='width:152pt'></td>
  <td width=171 style='width:128pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=194 style='width:146pt'></td>
  <td width=158 style='width:119pt'></td>
  <td width=143 style='width:107pt'></td>
  <td width=120 style='width:90pt'></td>
  <td width=122 style='width:92pt'></td>
  <td width=150 style='width:113pt'></td>
  <td width=131 style='width:98pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
