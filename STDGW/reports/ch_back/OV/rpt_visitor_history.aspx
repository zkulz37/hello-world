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
    
    string P_CHECKIN_DT_FR,P_CHECKIN_DT_TO,P_VIS_COMPANY,P_SEARCH_INFO;
     
  
    P_CHECKIN_DT_FR       = Request["L_CHECKIN_DT_FR"].ToString();
    P_CHECKIN_DT_TO      = Request["L_CHECKIN_DT_TO"].ToString();
    P_VIS_COMPANY      = Request["L_VIS_COMPANY"].ToString();
    P_SEARCH_INFO       = Request["L_SEARCH_INFO"].ToString();
        
   string SQL
	= "SELECT R.VISITOR_NM " + 
        "            ,(SELECT A.CODE_NM FROM VHR_HR_CODE A WHERE A.ID='HR0007' AND A.CODE=R.SEX) " +
        "            ,C.COMPANY_NM,R.VEHICLE_NO,R.TOTAL_VISITOR " +
        "            ,(SELECT A.CODE_NM FROM VHR_HR_CODE A WHERE A.ID='HR0121' AND A.CODE=V.CARD_TYPE) " +
        "            ,V.CARD_ID " +
        "            ,DECODE(R.VIS_STATUS,NULL,'WAITING','I','IN','OUT') " +
        "            ,(SELECT A.CODE_NM FROM VHR_HR_CODE A WHERE A.ID='HR0124' AND A.CODE=R.APPROVE_STATUS) " +
        "            ,TO_CHAR(TO_DATE(R.CHECKIN_DATE, 'YYYYMMDD'), 'DD/MM/YYYY') || ' - ' " +
        "            || R.CHECKIN_TIME AS GATE_IN " +
        "            ,R.CHECKIN_BY " +
        "            , TO_CHAR(TO_DATE(R.CHECKOUT_DT, 'YYYYMMDD'), 'DD/MM/YYYY') || ' - ' " +
        "            || R.CHECKOUT_TIME AS GATE_OUT,R.CHECKOUT_BY " +
        "            , R.CONTACT_to, R.CONTACT_dept, R.CONTACT_REASON, R.DESCRIPT AS CHECK_IN_DESC " +
        "            , R.OUT_DESCRIPTION  AS CHECK_OUT_DESC,R.GA_RESPONSE " +
        "        FROM THR_VISITOR_REGISTER R, THR_VISITOR_CARD V, THR_VIS_COMPANY C " +
        "        WHERE R.DEL_IF = 0 AND V.DEL_IF = 0 AND C.DEL_IF(+) = 0 " +
        "            AND R.THR_VIS_COMPANY_PK = C.PK(+) " +
        "            AND R.THR_VISITOR_CARD_PK = V.PK " +
        "            AND ( R.THR_VIS_COMPANY_PK = DECODE('" + P_VIS_COMPANY + "', 'ALL', R.THR_VIS_COMPANY_PK,'" + P_VIS_COMPANY + "') OR R.THR_VIS_COMPANY_PK IS NULL) " +
        "            AND ((R.CHECKIN_DATE BETWEEN '" +P_CHECKIN_DT_FR + "' AND '" + P_CHECKIN_DT_TO + "'  OR R.CHECKOUT_DT IS NULL) " +
        "                OR (R.CHECKOUT_DT BETWEEN '" +P_CHECKIN_DT_FR + "' AND '" + P_CHECKIN_DT_TO + "' OR R.CHECKOUT_DT IS NULL)) " +
        "            AND (    " +
        "                    UPPER(R.VISITOR_NM)    LIKE '%' || UPPER('" + P_SEARCH_INFO + "') || '%' " +
        "                    OR UPPER(R.VISITOR_TEL)    LIKE '%' || UPPER('" + P_SEARCH_INFO + "') || '%' " +
        "                    OR UPPER(R.PERSONAL_ID)    LIKE '%' || UPPER('" + P_SEARCH_INFO + "') || '%' " +
        "                    OR UPPER(R.CONTACT_REASON)    LIKE '%' || UPPER('" + P_SEARCH_INFO + "') || '%' " +
        "                    OR UPPER(R.DESCRIPT)    LIKE '%' || UPPER('" + P_SEARCH_INFO + "') || '%' " +
        "                    OR UPPER(R.OUT_DESCRIPTION)    LIKE '%' || UPPER('" + P_SEARCH_INFO + "') || '%' " +
        "                ) " +
        "        ORDER BY R.CHECKIN_DATE DESC, R.CHECKIN_TIME DESC " ;




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
<link rel=File-List href="rpt_visitor_history_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_visitor_history_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_visitor_history_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>tyml</o:LastAuthor>
  <o:LastPrinted>2009-11-27T04:09:49Z</o:LastPrinted>
  <o:Created>2008-05-23T07:19:16Z</o:Created>
  <o:LastSaved>2009-11-27T04:20:46Z</o:LastSaved>
  <o:Company>genuwin</o:Company>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.41in .2in .26in .15in;
	mso-header-margin:.24in;
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
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
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
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl29
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
.xl30
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
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl32
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
.xl33
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
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
.xl37
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
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
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
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	border:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
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
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>55</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>6</x:TopRowBottomPane>
     <x:SplitVertical>4</x:SplitVertical>
     <x:LeftColumnRightPane>13</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
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
  <x:WindowHeight>8685</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$5:$6</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2224 style='border-collapse:
 collapse;table-layout:fixed;width:1672pt'>
 <col class=xl24 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl24 width=183 style='mso-width-source:userset;mso-width-alt:6692;
 width:137pt'>
 <col class=xl24 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl24 width=140 style='mso-width-source:userset;mso-width-alt:5120;
 width:105pt'>
 <col class=xl24 width=172 style='mso-width-source:userset;mso-width-alt:6290;
 width:129pt'>
 <col class=xl24 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl24 width=90 span=2 style='mso-width-source:userset;mso-width-alt:
 3291;width:68pt'>
 <col class=xl24 width=124 style='mso-width-source:userset;mso-width-alt:4534;
 width:93pt'>
 <col class=xl24 width=119 style='mso-width-source:userset;mso-width-alt:4352;
 width:89pt'>
 <col class=xl24 width=106 span=4 style='mso-width-source:userset;mso-width-alt:
 3876;width:80pt'>
 <col class=xl24 width=122 style='mso-width-source:userset;mso-width-alt:4461;
 width:92pt'>
 <col class=xl24 width=106 span=2 style='mso-width-source:userset;mso-width-alt:
 3876;width:80pt'>
 <col class=xl24 width=106 span=2 style='mso-width-source:userset;mso-width-alt:
 3876;width:80pt'>
 <col class=xl24 width=106 span=2 style='mso-width-source:userset;mso-width-alt:
 3876;width:80pt'>
 <col class=xl24 width=106 span=2 style='mso-width-source:userset;mso-width-alt:
 6000;width:80pt'>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=17 height=38 class=xl34 width=1852 style='height:28.5pt;
  width:1393pt'>VISITOR'S HISTORY</td>
 </tr>

 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl48>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl27 style='height:27.75pt'>No</td>
  <td class=xl28 style='border-top:none'>Visitor Name</td>
  <td class=xl28 style='border-top:none'>Sex</td>
  <td class=xl28 style='border-top:none'>Company</td>
  <td class=xl28>Vehicle No</td>
  <td class=xl28>Visitors</td>
  <td class=xl28>Card Type</td>
  <td class=xl28>Card No</td>
  <td class=xl28>Visit Status</td>
  <td class=xl28>Approval Satus</td>
  <td class=xl28>Gate In</td>
  <td class=xl28>Check In by</td>
  <td class=xl28>Gate Out</td>
  <td class=xl28>Check Out by</td>
  <td class=xl28>Contact To</td>
  <td class=xl28>Contact Point</td>
  <td class=xl28>Reason</td>
  <td class=xl28>In Description</td>
  <td class=xl28>Out Desription</td>
  <td class=xl28>GA Response</td>
 </tr>
 <tr class=xl26 height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl29 style='height:27.75pt'>STT</td>
  <td class=xl30>Tên khách</td>
  <td class=xl30>Gi&#7899;i tính</td>
  <td class=xl30>Tên công ty</td>
  <td class=xl30>S&#7889; xe</td>
  <td class=xl30>S&#7889; khách</td>
  <td class=xl30>Lo&#7841;i th&#7867;</td>
  <td class=xl30>S&#7889; th&#7867;</td>
  <td class=xl30>Tình tr&#7841;ng</td>
  <td class=xl30>Tr&#7841;ng thái xác nh&#7853;n</td>
  <td class=xl30>Ngày giờ vào</td>
  <td class=xl30>Người cho vào</td>
  <td class=xl30>Ngày giờ ra</td>
  <td class=xl30>Người cho ra</td>
  <td class=xl30>Ng&#432;&#7901;i liên h&#7879;</td>
  <td class=xl30>N&#417;i &#273;&#7871;n</td>
  <td class=xl30>Lý do</td>
  <td class=xl30>Ghi chú khi vào</td>
  <td class=xl30>Ghi chú khi ra</td>
  <td class=xl30>Lý do từ phòng G.A</td>
 </tr>
 <% 
     string s_format;
     for (int i = 0; i < irow; i++) 
    {
        if (i == irow - 1)
            s_format = "border-bottom:.5pt solid windowtext;";
        else
            s_format = ";";
    %> 
 <tr class=xl31 height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl32 style='<%=s_format%>height:27.75pt' x:num><%=i+1%></td>
  <td class=xl35 style='<%=s_format%>' x:num><%= dt_total.Rows[i][0].ToString() %></td>
  <td class=xl33 style='<%=s_format%>' x:num><%= dt_total.Rows[i][1].ToString() %></td>
  <td class=xl35 style='<%=s_format%>' x:num><%= dt_total.Rows[i][2].ToString() %></td>
  <td class=xl35 style='<%=s_format%>' x:num><%= dt_total.Rows[i][3].ToString() %></td>
  <td class=xl36 style='<%=s_format%>' x:num><%= dt_total.Rows[i][4].ToString() %></td>
  <td class=xl38 style='<%=s_format%>' ><%= dt_total.Rows[i][5].ToString() %></td>
  <td class=xl37 style='<%=s_format%>' ><%= dt_total.Rows[i][6].ToString() %></td>
  <td class=xl37 style='<%=s_format%>' ><%= dt_total.Rows[i][7].ToString() %></td>
  <td class=xl37 style='<%=s_format%>' ><%= dt_total.Rows[i][8].ToString() %></td>
  <td class=xl37 style='<%=s_format%>' ><%= dt_total.Rows[i][9].ToString() %></td>
  <td class=xl37 style='<%=s_format%>' ><%= dt_total.Rows[i][10].ToString() %></td>
  <td class=xl38 style='<%=s_format%>' ><%= dt_total.Rows[i][11].ToString() %></td>
  <td class=xl38 style='<%=s_format%>' ><%= dt_total.Rows[i][12].ToString() %></td>
  <td class=xl38 style='<%=s_format%>' ><%= dt_total.Rows[i][13].ToString() %></td>
  <td class=xl38 style='<%=s_format%>' ><%= dt_total.Rows[i][14].ToString() %></td>
  <td class=xl38 style='<%=s_format%>' ><%= dt_total.Rows[i][15].ToString() %></td>
  <td class=xl38 style='<%=s_format%>' ><%= dt_total.Rows[i][16].ToString() %></td>
  <td class=xl38 style='<%=s_format%>' ><%= dt_total.Rows[i][17].ToString() %></td>
  <td class=xl38 style='<%=s_format%>' ><%= dt_total.Rows[i][18].ToString() %></td>
 </tr>
 
  <%
    }
  %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=47 style='width:35pt'></td>
  <td width=183 style='width:137pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=140 style='width:105pt'></td>
  <td width=172 style='width:129pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=122 style='width:92pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=106 style='width:80pt'></td>
  
 </tr>
 <![endif]>
</table>

</body>

</html>
