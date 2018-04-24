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
    string p_search_by,p_search_temp;
    string p_from_date,p_to_date,p_from_date_text,p_to_date_text,p_date_type;
     
  
   
    p_search_by         = Request["p_search_by"].ToString();
    p_search_temp       = Request["p_search_temp"].ToString();
    p_from_date         = Request["p_from"].ToString();
    p_to_date           = Request["p_to"].ToString();
    p_date_type         = Request["p_date_type"].ToString();


    string SQL
     = "SELECT  E.EMP_ID,E.FULL_NAME,TO_CHAR(TO_DATE(A.WORK_DT,'YYYYMMDD'),'DD/MM/YYYY'),A.TIME " +
         "        ,TO_CHAR(TO_DATE(B.WORK_DT,'YYYYMMDD'),'DD/MM/YYYY') " +
         "        ,(SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0100' AND V.CODE=B.TIME_TYPE) " +
         "        ,DECODE(B.TIME_TYPE,'01',C.TIME_IN,'02',C.TIME_OUT,'03',C.TEMP_IN,'04',C.TEMP_OUT,NULL) AS T " +
         "        ,(SELECT S.REMARK FROM THR_WORK_SHIFT S WHERE S.DEL_IF=0 AND S.PK=C.THR_WS_PK) AS S " +
         "        FROM THR_TIME_TEMP A,THR_TIME_MAPPING B,THR_TIME_MACHINE C,THR_EMPLOYEE E " +
         "        WHERE A.WORK_DT BETWEEN TO_CHAR(TO_DATE('" + p_from_date + "','YYYYMMDD')-1,'YYYYMMDD') AND TO_CHAR(TO_DATE('" + p_to_date + "','YYYYMMDD')+1,'YYYYMMDD') " +
         "         AND C.DEL_IF(+)=0 AND E.DEL_IF=0  " +
         "        AND E.ID_NUM=A.ID  " +
         "        AND C.WORK_DT(+) BETWEEN '" + p_from_date + "' AND '" + p_to_date + "' AND C.PK(+)=B.THR_TIME_MACHINE_PK " +
         "        AND B.DEL_IF(+)=0 AND A.PK=B.THR_TIME_TEMP_PK(+) " +
         "        AND B.WORK_DT(+) BETWEEN '" + p_from_date + "' AND '" + p_to_date + "' " +
         "        AND (DECODE('" + p_search_by + "','1',UPPER(E.EMP_ID),'2',E.ID_NUM,'3',UPPER(E.FULL_NAME)) LIKE '%'||UPPER('" + p_search_temp + "') " +
         "                OR '" + p_search_temp + "' IS NULL)    " +
         "        ORDER BY E.EMP_ID,A.WORK_DT,A.TIME ";
        
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
 <col class=xl24 width=114 style='mso-width-source:userset;mso-width-alt:6000;
 width:86pt'>
 <col class=xl24 width=77 style='mso-width-source:userset;mso-width-alt:4169;
 width:58pt'>
 <col class=xl24 width=215 style='mso-width-source:userset;mso-width-alt:4169;
 width:161pt'>
 <col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:4169;
 width:67pt'>
 <col class=xl24 width=173 style='mso-width-source:userset;mso-width-alt:4169;
 width:130pt'>
 <col class=xl24 width=73 style='mso-width-source:userset;mso-width-alt:4169;
 width:55pt'>
 <col class=xl24 width=78 style='mso-width-source:userset;mso-width-alt:10000;
 width:59pt'>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=13 height=38 class=xl44 width=1207 style='height:28.5pt;
  width:907pt'>MAPPING TIME LIST</td>
  <td class=xl24 width=137 style='width:103pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl25 x:str><%if (p_date_type=="3") 
                        Response.Write("Month");
                    else
                        Response.Write("From Date");%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl26 ><%if (p_date_type=="3") 
                        Response.Write(p_from_date.Substring(4,2) + "/" + p_from_date.Substring(0,4));
                    else
                        Response.Write(p_from_date.Substring(6,2) + "/" + p_from_date.Substring(4,2) + "/" + p_from_date.Substring(0,4));
                        %></td>
  <td class=xl30><%if (p_date_type!="3") 
                        Response.Write("To Date");%></td>
  <td class=xl26 ><%if (p_date_type!="3") 
                            Response.Write(p_to_date.Substring(6,2) + "/" + p_to_date.Substring(4,2) + "/" + p_to_date.Substring(0,4));
                            %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
  <td class=xl24></td>
  <td colspan=2 class=xl45>&nbsp;</td>
  <td class=xl31></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl25></td>
  <td class=xl31></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30 colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 x:num></td>
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
  <td class=xl28 style='border-left:none'>EMP ID</td>
  <td class=xl28 style='border-left:none'>FULL NAME</td>
  <td class=xl28 style='border-left:none'>SCAN DATE</td>
  <td class=xl28 style='border-left:none'>SCAN TIME</td>
  <td class=xl28 style='border-left:none'>WORK DATE</td>
  <td class=xl28 style='border-left:none'>MAPPING TYPE</td>
  <td class=xl28 style='border-left:none'>TIME</td>
  <td class=xl28 style='border-left:none'>WORK SHIFT</td>
 </tr>
 <tr class=xl27 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl32 style='height:19.5pt;border-top:none'>STT</td>
  <td class=xl32 style='border-top:none;border-left:none'>MÃ NV</td>
  <td class=xl32 style='border-top:none;border-left:none'>HỌ TÊN</td>
  <td class=xl32 style='border-top:none;border-left:none'>NGÀY QUÉT</td>
  <td class=xl32 style='border-top:none;border-left:none'>GIỜ QUÉT</td>
  <td class=xl32 style='border-top:none;border-left:none'>NGÀY L.V</td>
  <td class=xl32 style='border-top:none;border-left:none'>LOẠI GIỜ</td>
  <td class=xl32 style='border-top:none;border-left:none'>GIỜ</td>
  <td class=xl32 style='border-top:none;border-left:none'>CA LÀM VIỆC</td>
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
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][0].ToString()%></td>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][1].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][2].ToString()%></td>
  <td class=xl36 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][3].ToString()%></td>
  <td class=xl35 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][4].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][5].ToString()%></td>
  <td class=xl36 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][6].ToString()%></td>
  <td class=xl36 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][7].ToString()%></td>
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
