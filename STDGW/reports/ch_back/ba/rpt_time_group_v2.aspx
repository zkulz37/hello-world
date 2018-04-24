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
     string p_user,p_tco_org_pk,p_wg,p_from,p_to;
    string p_thr_ws_pk,p_search,p_input,p_opt,p_opt_text,p_m1,p_m2,p_nation;
     
  
    p_tco_org_pk       = Request["p_tco_org_pk"].ToString();
    p_wg                = Request["p_wg"].ToString();
    p_from              = Request["p_from"].ToString();
    p_to                = Request["p_to"].ToString();
	p_nation          = Request["p_nation"].ToString();
    

    string SQL
    = "SELECT TO_CHAR(SYSDATE,'DD/MM/YYYY'),HR.WG,SUM(HR.WD),SUM(HR.T15),SUM(HR.T2),SUM(HR.T3) " +
        "FROM( " +
        "SELECT B.workgroup_NM WG,MAX(NVL(D.WORK_TIME,0)) WD  " +
        "            ,SUM(CASE WHEN E.OT_TYPE='OT' AND E.HOL_TYPE IS NULL THEN NVL(E.OT_TIME,0) " +
        "                    ELSE 0 END) T15 " +
        "            ,SUM(CASE WHEN E.OT_TYPE IN('OT','HT')  AND NVL(E.HOL_TYPE,' ')='SUN' THEN NVL(E.OT_TIME,0) " +
        "                    ELSE 0 END) T2 " +
        "            ,SUM(CASE WHEN E.OT_TYPE IN('OT','HT')  AND NVL(E.HOL_TYPE,' ')='HOL' THEN NVL(E.OT_TIME,0) " +
        "                    ELSE 0 END) T3         " +
        "            FROM THR_EMPLOYEE A,THR_work_group B, THR_WORK_SHIFT C,THR_TIME_MACHINE D,THR_EXTRA_TIME E,tco_org F  " +
        "            WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0 AND D.DEL_IF=0 AND E.DEL_IF(+)=0 AND F.DEL_IF=0  " +
        "            AND A.THR_wg_PK=B.PK AND A.PK=D.THR_EMP_PK AND C.PK=D.THR_WS_PK AND A.TCO_org_PK=F.PK  " +
        "            AND D.THR_EMP_PK=E.THR_EMP_PK(+) AND D.WORK_DT=E.WORK_DT(+)  " +
        "            AND D.WORK_DT BETWEEN '" + p_from + "' AND  '" + p_to + "' " +
        "            AND DECODE('" + p_wg + "' ,'ALL', '" + p_wg + "',B.PK) =  '" + p_wg + "'" +
        "            AND DECODE('" + p_nation + "' ,'ALL', '" + p_nation + "',a.nation) =  '" + p_nation + "'" +
        "                   AND (    A.TCO_ORG_PK IN (  " +
        "                       SELECT     G.PK  " +
        "                             FROM TCO_ORG G  " +
        "                            WHERE G.DEL_IF = 0            " +
        "                       START WITH G.PK =  " +
        "                                     DECODE ('" + p_tco_org_pk + "',  " +
        "                                             'ALL', 0,  " +
        "                                             '" + p_tco_org_pk + "'  " +
        "                                            )  " +
        "                       CONNECT BY PRIOR G.PK = G.P_PK)  " +
        "                 OR '" + p_tco_org_pk + "' = 'ALL')  " +
        "            GROUP BY B.workgroup_NM,D.WORK_DT,d.thr_emp_pk) HR " +
        " GROUP BY HR.WG " +
        " ORDER BY HR.WG ";

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
<link rel=File-List href="rpt_time_summary_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_time_summary_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_time_summary_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>ty-ml</o:LastAuthor>
  <o:LastPrinted>2008-07-21T09:05:51Z</o:LastPrinted>
  <o:Created>2008-05-23T07:19:16Z</o:Created>
  <o:LastSaved>2008-07-24T03:06:05Z</o:LastSaved>
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
	margin:.32in .16in .26in .33in;
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
	color:#3366FF;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl44
	{mso-style-parent:style0;
	font-size:19.0pt;
	font-weight:700;
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
      <x:Scale>76</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>6</x:SplitHorizontal>
     <x:TopRowBottomPane>6</x:TopRowBottomPane>
     <x:SplitVertical>2</x:SplitVertical>
     <x:LeftColumnRightPane>12</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveCol>16</x:ActiveCol>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1539 style='border-collapse:
 collapse;table-layout:fixed;width:1155pt'>
 <col class=xl24 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl24 width=100 style='mso-width-source:userset;mso-width-alt:5657;
 width:75pt'>
 <col class=xl24 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col class=xl24 width=77 style='mso-width-source:userset;mso-width-alt:4816;
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
  <col class=xl24 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl24 width=59 style='mso-width-source:userset;mso-width-alt:2157;
 width:44pt'>
 <col class=xl24 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl24 width=103 span=2 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=6 height=38 class=xl42 width=1207 style='height:28.5pt;
  width:907pt'>TIME SUMMARY</td>
  <td class=xl42 width=59 style='width:44pt'></td>
  <td class=xl42 width=67 style='width:50pt'></td>
  <td class=xl42 width=103 style='width:77pt'></td>
  <td class=xl42 width=103 style='width:77pt'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl25 x:str="Work date:   ">Work date:<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl26 x:num><%=p_from.Substring(6,2) + "/" + p_from.Substring(4,2) + "/" + p_from.Substring(0,4) %></td>
  <td class=xl44>~</td>
  <td class=xl26 x:num><%=p_to.Substring(6,2) + "/" + p_to.Substring(4,2) + "/" + p_to.Substring(0,4) %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
  <td class=xl24></td>
  <td colspan=2 class=xl43>&nbsp;</td>
  <td colspan=5 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl25 x:str><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl31></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30 colspan=2 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl26 x:num>&nbsp;</td>
  <td colspan=5 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl30></td>
  <td class=xl26></td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl28 style='height:19.5pt'>No</td>
  <td class=xl28 style='border-left:none'>Work Group</td>
  <td class=xl28 style='border-left:none'>WT(H)</td>
  <td class=xl28 style='border-left:none'>Normal OT(H)</td>
  <td class=xl28 style='border-left:none'>Sunday OT(H)</td>
  <td class=xl28 style='border-left:none'>Holiday OT(H)</td>
 </tr>
 <tr class=xl27 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl32 style='height:19.5pt;border-top:none'>STT</td>
  <td class=xl32 style='border-top:none;border-left:none'>Nhóm</td>
  <td class=xl32 style='border-top:none;border-left:none'>Công</td>
  <td class=xl32 style='border-top:none;border-left:none'>Tăng ca thường</td>
  <td class=xl32 style='border-top:none;border-left:none'>Tăng ca CN</td>
  <td class=xl32 style='border-top:none;border-left:none'>Tăng ca lễ</td>
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
  <td class=xl35 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][1].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>' x:num><% = dt_total.Rows[i][2].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>' x:num><% = dt_total.Rows[i][3].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>' x:num><% = dt_total.Rows[i][4].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>' x:num><% = dt_total.Rows[i][5].ToString()%></td>
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
  <td width=59 style='width:44pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
