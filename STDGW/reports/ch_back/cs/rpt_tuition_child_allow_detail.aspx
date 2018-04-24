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
  
  string  p_tco_org_pk       = Request["org"].ToString();
  string  p_wg               = Request["wg"].ToString();
  string  p_job               = Request["job"].ToString();
  string  p_nation               = Request["nation"].ToString();
  string  p_searchby               = Request["searchby"].ToString();
  string  p_txtsearch               = Request["txtsearch"].ToString();
  string  p_work_mon               = Request["work_mon"].ToString();

  string SQL
    = "SELECT 1 " + 
        "   , D.ORG_NM AS TEAM " +
        "   ,A.EMP_ID " +
        "   ,A.FULL_NAME " +
        "   ,E.CHILD_NM " +
        "   ,E.BIRTH_DT " +
        "   ,E.SCHOOL_NM " +
        "   ,(select v.code_nm from vhr_hr_code v where v.id='HR0164' and v.code= E.SCHOOL_LEVEL_TYPE) school_level " +
        "   ,E.PERIOD " +
        "   ,E.YEAR " +
        "   ,E.VOUCHER_NUM " +
        "   ,nvl(E.AMOUNT,0) " +
        "   ,nvl(E.AMOUNT_ALLOW,0) " +
        "   FROM THR_EMPLOYEE A, THR_WORK_GROUP C,THR_CHILD_ALLOW_DETAIL_VHPC E, THR_CHILD_ALLOW_MASTER_VHPC V, TCO_ORG D " +
        "   WHERE A.DEL_IF=0 AND C.DEL_IF=0 AND E.DEL_IF=0 AND D.DEL_IF = 0 AND V.DEL_IF=0 " +
        "   AND E.THR_MASTER_PK = V.PK AND V.THR_EMP_PK = A.PK " +
        "   AND A.TCO_ORG_PK = D.PK " +
        "   AND A.THR_WG_PK=C.PK  " +
        "   AND V.WORK_MON = '"+ p_work_mon +"' " +
        "   AND (   A.TCO_ORG_PK IN ( " +
        "                              SELECT     G.PK " +
        "                                    FROM TCO_ORG G " +
        "                                   WHERE G.DEL_IF = 0 " +
        "                              START WITH G.PK = " +
        "                                            DECODE ('"+ p_tco_org_pk +"', " +
        "                                                    'ALL', 0, " +
        "                                                    '"+ p_tco_org_pk +"' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR G.PK = G.P_PK) " +
        "                        OR '"+ p_tco_org_pk +"' = 'ALL') " +
        "   AND  '"+ p_job +"' = DECODE('"+ p_job +"', 'ALL', '"+ p_job +"',A.JOB_TYPE) " +
        "   AND '"+ p_nation +"' = DECODE('"+ p_nation +"','ALL', '"+ p_nation +"', A.NATION) " +
        "   AND DECODE('"+ p_wg +"','ALL','ALL',A.THR_WG_PK )='"+ p_wg +"' " +
        "   AND (   ('"+ p_searchby +"' = 1 AND UPPER(A.FULL_NAME) LIKE '%' || UPPER('"+ p_txtsearch +"') || '%') " +
        "              OR ('"+ p_searchby +"' = 2 AND A.EMP_ID LIKE '%' || '"+ p_txtsearch +"' || '%') " +
        "              OR ('"+ p_searchby +"' = 3 AND A.ID_NUM LIKE '%' || '"+ p_txtsearch +"' || '%') " +
        "              OR ('"+ p_searchby +"' = 4 AND UPPER(A.PERSON_ID) LIKE '%' || UPPER('"+ p_txtsearch +"') || '%') " +
        "              OR '"+ p_txtsearch +"' IS NULL " +
        "             ) " +
        "   ORDER BY 2,3  " ;



//Response.Write(SQL);
//Response.End();
    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp=dt_Emp.Columns.Count;
    if (irow_emp == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
   
    
    
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_tuition_child_allow_detail_files/filelist.xml">
<link rel=Edit-Time-Data
href="rpt_tuition_child_allow_detail_files/editdata.mso">
<link rel=OLE-Object-Data
href="rpt_tuition_child_allow_detail_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-08-06T06:00:40Z</o:LastPrinted>
  <o:Created>2008-05-23T07:19:16Z</o:Created>
  <o:LastSaved>2011-08-08T01:54:26Z</o:LastSaved>
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
	color:#3366FF;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl71
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
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl73
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
.xl74
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
.xl75
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
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
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
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl78
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
.xl79
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
.xl80
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
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
	mso-number-format:"\@";
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
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
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
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl84
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl85
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl86
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl87
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
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
      <x:Scale>62</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:SplitVertical>4</x:SplitVertical>
     <x:LeftColumnRightPane>4</x:LeftColumnRightPane>
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
       <x:ActiveRow>6</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>9</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
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
  <x:WindowHeight>8760</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1755</x:WindowTopY>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=2091 style='border-collapse:
 collapse;table-layout:fixed;width:1569pt'>
 <col class=xl65 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl65 width=181 style='mso-width-source:userset;mso-width-alt:6619;
 width:136pt'>
 <col class=xl65 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl65 width=203 span=2 style='mso-width-source:userset;mso-width-alt:
 7424;width:152pt'>
 <col class=xl65 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl65 width=171 style='mso-width-source:userset;mso-width-alt:6253;
 width:128pt'>
 <col class=xl65 width=124 style='mso-width-source:userset;mso-width-alt:4534;
 width:93pt'>
 <col class=xl65 width=91 style='mso-width-source:userset;mso-width-alt:3328;
 width:68pt'>
 <col class=xl65 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl65 width=122 style='mso-width-source:userset;mso-width-alt:4461;
 width:92pt'>
 <col class=xl65 width=118 span=2 style='mso-width-source:userset;mso-width-alt:
 4315;width:89pt'>
 <col class=xl65 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl65 width=115 span=3 style='mso-width-source:userset;mso-width-alt:
 4205;width:86pt'>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=13 height=38 class=xl84 width=1650 style='height:28.5pt;
  width:1239pt'>TUITION CHILDREN ALLOWANCE DETAIL</td>
  <td class=xl66 width=96 style='width:72pt'></td>
  <td class=xl66 width=115 style='width:86pt'></td>
  <td class=xl66 width=115 style='width:86pt'></td>
  <td class=xl65 width=115 style='width:86pt'></td>
 </tr>
 <tr class=xl67 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td colspan=13 height=35 class=xl85 style='height:26.25pt'>MONTH: <%= p_work_mon.Substring(4,2).ToString() %>/<%= p_work_mon.Substring(0,4).ToString() %></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl65 style='height:15.75pt'></td>
  <td class=xl70>&nbsp;</td>
  <td colspan=15 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl71 style='height:19.5pt'>No</td>
  <td class=xl72>Department</td>
  <td class=xl73>Emp ID</td>
  <td class=xl73>Full Name</td>
  <td class=xl73>Child's Name</td>
  <td class=xl73>Birth Date</td>
  <td class=xl73>School Name</td>
  <td class=xl73>School Level</td>
  <td class=xl73>Period</td>
  <td class=xl73>Year</td>
  <td class=xl73>Voucher No</td>
  <td class=xl73>Amount</td>
  <td class=xl73>Amount All</td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'></td>
 </tr>

 <tr class=xl68 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl74 style='height:19.5pt'>STT</td>
  <td class=xl75>B&#7897; ph&#7853;n</td>
  <td class=xl75>Mã NV</td>
  <td class=xl75>H&#7885; và tên</td>
  <td class=xl75>Tên con</td>
  <td class=xl75>Ngày sinh</td>
  <td class=xl75>Tên tr&#432;&#7901;ng</td>
  <td class=xl75>C&#7845;p h&#7885;c</td>
  <td class=xl75>H&#7885;c kì</td>
  <td class=xl75>N&#259;m h&#7885;c</td>
  <td class=xl75>S&#7889; phi&#7871;u</td>
  <td class=xl75>H&#7885;c phí</td>
  <td class=xl75>S&#7889; ti&#7873;n tr&#7907; c&#7845;p</td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'></td>
 </tr>
  <%
    int i;
    int count=0;
    double t1 = 0; double t2=0;
    for (i = 0; i < irow_emp; i++)
    {
        count++;
        t1 += Double.Parse(dt_Emp.Rows[i][11].ToString());
        t2 += Double.Parse(dt_Emp.Rows[i][12].ToString());
            
  %>
 <tr class=xl76 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl77 style='height:19.5pt' x:num><%= count%></td>
  <td class=xl78><%= dt_Emp.Rows[i][1].ToString()%></td>
  <td class=xl81><%= dt_Emp.Rows[i][2].ToString()%></td>
  <td class=xl78><%= dt_Emp.Rows[i][3].ToString()%></td>
  <td class=xl80><%= dt_Emp.Rows[i][4].ToString()%></td>
  <td class=xl81><%= dt_Emp.Rows[i][5].ToString()%></td>
  <td class=xl79><%= dt_Emp.Rows[i][6].ToString()%></td>
  <td class=xl79><%= dt_Emp.Rows[i][7].ToString()%></td>
  <td class=xl79 x:num><%= dt_Emp.Rows[i][8].ToString()%></td>
  <td class=xl79 x:num><%= dt_Emp.Rows[i][9].ToString()%></td>
  <td class=xl79 x:num><%= dt_Emp.Rows[i][10].ToString()%></td>
  <td class=xl82 x:num><span
  style='mso-spacerun:yes'> </span><%= dt_Emp.Rows[i][11].ToString()%> </td>
  <td class=xl82 x:num><span
  style='mso-spacerun:yes'> </span><%= dt_Emp.Rows[i][12].ToString()%> </td>
  <td colspan=4 class=xl76 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <tr class=xl76 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=2 height=26 class=xl86 style='border-right:.5pt solid black;
  height:19.5pt'>Total</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl83 x:num><span
  style='mso-spacerun:yes'> </span><%= t1 %></td>
  <td class=xl83 x:num><span
  style='mso-spacerun:yes'> </span><%= t2 %> </td>
  <td colspan=4 class=xl76 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=47 style='width:35pt'></td>
  <td width=181 style='width:136pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=203 style='width:152pt'></td>
  <td width=203 style='width:152pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=171 style='width:128pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=122 style='width:92pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=115 style='width:86pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
