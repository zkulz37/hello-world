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
        "   ,to_char(to_date(B.WORK_MON,'yyyymm'),'mm/yyyy') " +
        "   ,nvl(B.TOTAL_AMT,0) " +
        "   FROM THR_CHILD_ALLOW_MASTER_VHPC B ,THR_EMPLOYEE A, THR_WORK_GROUP C, TCO_ORG D " +
        "   WHERE A.DEL_IF=0 AND C.DEL_IF=0 AND D.DEL_IF=0 AND B.DEL_IF=0 " +
        "   AND B.THR_EMP_PK = A.PK " +
        "   AND A.THR_WG_PK=C.PK " +
        "   AND A.TCO_ORG_PK=D.PK " +
        "   AND B.WORK_MON = '"+ p_work_mon +"' " +
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
<link rel=File-List href="rpt_tuition_child_allow_summary_files/filelist.xml">
<link rel=Edit-Time-Data
href="rpt_tuition_child_allow_summary_files/editdata.mso">
<link rel=OLE-Object-Data
href="rpt_tuition_child_allow_summary_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-08-08T03:42:35Z</o:LastPrinted>
  <o:Created>2008-05-23T07:19:16Z</o:Created>
  <o:LastSaved>2011-08-08T03:42:54Z</o:LastSaved>
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
	margin:.51in .28in .46in .56in;
	mso-header-margin:.24in;
	mso-footer-margin:.22in;}
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
	border-top:.5pt solid windowtext;
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
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
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
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl76
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
.xl77
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
.xl78
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
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl80
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
.xl81
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl82
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
.xl83
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl84
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl85
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
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl86
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
      <x:PaperSizeIndex>5</x:PaperSizeIndex>
      <x:Scale>71</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>14</x:ActiveRow>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1423 style='border-collapse:
 collapse;table-layout:fixed;width:1067pt'>
 <col class=xl65 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl65 width=238 style='mso-width-source:userset;mso-width-alt:8704;
 width:179pt'>
 <col class=xl65 width=115 style='mso-width-source:userset;mso-width-alt:4205;
 width:86pt'>
 <col class=xl65 width=280 style='mso-width-source:userset;mso-width-alt:10240;
 width:210pt'>
 <col class=xl65 width=128 style='mso-width-source:userset;mso-width-alt:4681;
 width:96pt'>
 <col class=xl65 width=174 style='mso-width-source:userset;mso-width-alt:6363;
 width:131pt'>
 <col class=xl65 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl65 width=115 span=3 style='mso-width-source:userset;mso-width-alt:
 4205;width:86pt'>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=6 height=38 class=xl83 width=982 style='height:28.5pt;width:737pt'>TUTOR
  CHILDREN ALLOWANCE</td>
  <td class=xl66 width=96 style='width:72pt'></td>
  <td class=xl66 width=115 style='width:86pt'></td>
  <td class=xl66 width=115 style='width:86pt'></td>
  <td class=xl65 width=115 style='width:86pt'></td>
 </tr>
 <tr class=xl67 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td colspan=6 height=35 class=xl84 style='height:26.25pt'>MONTH: <%= p_work_mon.Substring(4,2).ToString() %>/<%= p_work_mon.Substring(0,4).ToString() %></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl65 style='height:15.75pt'></td>
  <td class=xl70>&nbsp;</td>
  <td colspan=8 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl71 style='height:19.5pt'>No</td>
  <td class=xl72 style='border-top:none'>Department</td>
  <td class=xl72>Emp ID</td>
  <td class=xl72>Full Name</td>
  <td class=xl72>Work Month</td>
  <td class=xl72>Total Amount</td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl73 style='height:19.5pt'>STT</td>
  <td class=xl74>B&#7897; ph&#7853;n</td>
  <td class=xl74>Mã NV</td>
  <td class=xl74>H&#7885; và tên</td>
  <td class=xl74>Tháng</td>
  <td class=xl74>T&#7893;ng s&#7889; ti&#7873;n</td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'></td>
 </tr>
 <%
    int i;
    int count=0;
    double t1 = 0; double t2=0;
    for (i = 0; i < irow_emp; i++)
    {
        count++;
        t1 += Double.Parse(dt_Emp.Rows[i][5].ToString());
        
            
  %>
 <tr class=xl75 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl79 style='height:19.5pt' x:num><%= count %></td>
  <td class=xl77><%= dt_Emp.Rows[i][1].ToString()%></td>
  <td class=xl78><%= dt_Emp.Rows[i][2].ToString()%></td>
  <td class=xl77 x:str><%= dt_Emp.Rows[i][3].ToString()%><span style='mso-spacerun:yes'> </span></td>
  <td class=xl78><%= dt_Emp.Rows[i][4].ToString()%></td>
  <td class=xl76 x:num><span
  style='mso-spacerun:yes'> </span><%= dt_Emp.Rows[i][5].ToString()%> </td>
  <td colspan=4 class=xl75 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <tr class=xl75 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=2 height=26 class=xl85 style='border-right:.5pt solid black;
  height:19.5pt'>Total</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl81 style='border-left:none'>&nbsp;</td>
  <td class=xl82 x:num><span
  style='mso-spacerun:yes'> </span><%= t1 %> </td>
  <td colspan=4 class=xl75 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=47 style='width:35pt'></td>
  <td width=238 style='width:179pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=280 style='width:210pt'></td>
  <td width=128 style='width:96pt'></td>
  <td width=174 style='width:131pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=115 style='width:86pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
