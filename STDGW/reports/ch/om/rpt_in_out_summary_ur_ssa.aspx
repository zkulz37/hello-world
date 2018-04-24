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
    string p_tco_org_pk, p_thr_wg_pk, p_status, p_emp_id, p_work_mon, p_from_dt, p_to_dt, p_dept_nm, p_times,p_nation;
    
    p_tco_org_pk = Request["l_tco_dept_pk"].ToString();
    p_thr_wg_pk = Request["l_thr_group_pk"].ToString();
    p_status = Request["l_status"].ToString();
    p_emp_id = Request["l_emp_id"].ToString();
    p_work_mon = Request["l_work_mon"].ToString();
    p_to_dt = Request["l_to_dt"].ToString();
    p_from_dt = Request["l_from_dt"].ToString();
    p_dept_nm = Request["l_dept_nm"].ToString();
    p_times = Request["l_resign_times"].ToString();
    p_nation = Request["l_nation"].ToString();
    //-----------------information of company-----------------
    
       string SQL
        = " select c0, c1, c2,c3,c4,c5,c6,c7, decode(c8,0,1,c8),c9,c10,decode(c11,0,1,c11), c12, c13 " +
            "    from (select null c0, G.ORG_NM c1, b.EMP_ID c2, substr(A.WORK_DT,1,4) c3 " +
            "    ,to_number( substr(A.WORK_DT, 5,2)) c4,to_number( substr(A.WORK_DT,-2)) c5 " +
            "    ,to_number(substr(A.TIME_IN,1,2)) c6 " +
            "    ,to_number(substr(A.TIME_IN,-2)) c7 " +
            "    , abs(MOD(DBMS_RANDOM.Random,60)) c8 " +
            "    ,to_number(substr(A.TIME_OUT,1,2)) c9 " +
            "    ,to_number(substr(A.TIME_OUT,-2)) c10 " +
            "    , abs(MOD(DBMS_RANDOM.Random,60)) c11 " +
            "    ,'FINGER PRINTING' c12 " +
            "    , decode(s.shift,5,'B',6,'C',7,'A',1,'HC',s.shift||' ') c13 " +
            "from thr_time_machine_ur a, thr_employee b, tco_org g, thr_work_shift s,thr_work_group c " +
            "where A.DEL_IF=0 " +
            "and b.DEL_IF=0 " +
            "and G.DEL_IF=0 " +
            "and s.DEL_IF=0 and c.del_if=0 and c.pk=b.thr_wg_pk " +
            "and s.pk=A.THR_WS_PK " +
            "and b.TCO_ORG_PK=g.pk " +
            "and A.THR_EMP_PK=b.pk " +            
           "and a.WORK_DT between '" + p_from_dt + "' and '" + p_to_dt + "' " +
           "and a.WORK_DT between b.join_dt and nvl(b.left_dt,'" + p_to_dt + "') " +
           "and b.join_dt<=a.WORK_DT " +
           "and (b.left_dt>a.WORK_DT or b.left_dt is null) " +           
           "and (b.tco_org_pk in ( " +
           "                              SELECT     g.pk " +
           "                                    FROM comm.tco_org g " +
           "                                   WHERE g.del_if = 0 " +
           "                              START WITH g.pk = " +
           "                                            DECODE ('" + p_tco_org_pk + "', " +
           "                                                    'ALL', 0, " +
           "                                                    '" + p_tco_org_pk + "' " +
           "                                                   ) " +
           "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
           "                        OR '" + p_tco_org_pk + "' = 'ALL') " +
           "and decode('" + p_thr_wg_pk + "','ALL','ALL',b.thr_wg_pk)='" + p_thr_wg_pk + "'" +
           "and b.emp_id like '%" + p_emp_id + "%' " +
           "and decode('" + p_status + "','ALL','ALL',b.status)='" + p_status + "' ) " +          
           " ORDER BY c2,c3,c4,c5,c1 ";


    
    //Response.Write(SQL);
    //Response.End();  

    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp;
    irow_emp = dt_Emp.Rows.Count;
    if (irow_emp == 0)
    {
        Response.Write("There is no data of working time");
        Response.End();
    }        
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="report%20inout_files/filelist.xml">
<link rel=Edit-Time-Data href="report%20inout_files/editdata.mso">
<link rel=OLE-Object-Data href="report%20inout_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Brian</o:Author>
  <o:LastAuthor>VINAESYS</o:LastAuthor>
  <o:LastPrinted>2011-11-22T08:45:03Z</o:LastPrinted>
  <o:Created>2011-08-12T09:00:26Z</o:Created>
  <o:LastSaved>2011-11-22T08:45:19Z</o:LastSaved>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .25in .25in .25in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;
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
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style75
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
	mso-style-name:"Normal_thang 9 payroll gui chuyen";}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl108
	{mso-style-parent:style75;
	color:windowtext;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid #00CCFF;
	border-right:.5pt hairline #00CCFF;
	border-bottom:.5pt hairline #00CCFF;
	border-left:.5pt hairline #00CCFF;
	mso-protection:locked hidden;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl109
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid #00CCFF;
	border-right:.5pt hairline #00CCFF;
	border-bottom:.5pt hairline #00CCFF;
	border-left:.5pt hairline #00CCFF;}
.xl110
	{mso-style-parent:style0;
	color:windowtext;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid #00CCFF;
	border-right:.5pt hairline #00CCFF;
	border-bottom:.5pt hairline #00CCFF;
	border-left:.5pt hairline #00CCFF;}
.xl111
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid #00CCFF;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt hairline #00CCFF;
	border-left:.5pt hairline #00CCFF;}
.xl112
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid #00CCFF;
	border-right:.5pt hairline #00CCFF;
	border-bottom:.5pt hairline #00CCFF;
	border-left:.5pt solid #00CCFF;}
.xl113
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid #00CCFF;
	border-right:.5pt hairline #00CCFF;
	border-bottom:.5pt hairline #00CCFF;
	border-left:.5pt hairline #00CCFF;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl114
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl115
	{mso-style-parent:style0;
	color:windowtext;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt hairline #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:.5pt solid #00CCFF;}
.xl116
	{mso-style-parent:style0;
	color:windowtext;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt hairline #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;}
.xl117
	{mso-style-parent:style0;
	color:windowtext;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt hairline #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:.5pt hairline #00CCFF;}
.xl118
	{mso-style-parent:style0;
	color:windowtext;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt hairline #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:.5pt hairline #00CCFF;}
.xl119
	{mso-style-parent:style0;
	color:windowtext;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:.5pt hairline #00CCFF;}
.xl120
	{mso-style-parent:style0;
	color:windowtext;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl121
	{mso-style-parent:style0;
	color:windowtext;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl122
	{mso-style-parent:style0;
	color:maroon;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid #00CCFF;
	border-right:.5pt solid #00CCFF;
	border-bottom:none;
	border-left:.5pt solid #00CCFF;
	background:#FFCC00;
	mso-pattern:auto none;}
.xl123
	{mso-style-parent:style0;
	color:maroon;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid #00CCFF;
	background:#FFCC00;
	mso-pattern:auto none;}
.xl124
	{mso-style-parent:style0;
	color:#00CCFF;
	font-size:20.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>File All</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>4</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>3</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11535</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>-150</x:WindowTopX>
  <x:WindowTopY>-30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='File All'!$A$4:$N$4</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='File All'!$1:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl114>

<table x:str border=0 cellpadding=0 cellspacing=0 width=967 style='border-collapse:
 collapse;table-layout:fixed;width:728pt'>
 <col class=xl120 width=50 style='mso-width-source:userset;mso-width-alt:1600;
 width:38pt'>
 <col class=xl120 width=147 style='mso-width-source:userset;mso-width-alt:4704;
 width:110pt'>
 <col class=xl120 width=56 style='mso-width-source:userset;mso-width-alt:1792;
 width:42pt'>
 <col class=xl120 width=53 span=4 style='mso-width-source:userset;mso-width-alt:
 1696;width:40pt'>
 <col class=xl121 width=53 style='mso-width-source:userset;mso-width-alt:1696;
 width:40pt'>
 <col class=xl120 width=53 span=4 style='mso-width-source:userset;mso-width-alt:
 1696;width:40pt'>
 <col class=xl120 width=139 style='mso-width-source:userset;mso-width-alt:4448;
 width:104pt'>
 <col class=xl120 width=98 style='mso-width-source:userset;mso-width-alt:3136;
 width:74pt'>
 <tr height=41 style='mso-height-source:userset;height:30.75pt'>
  <td colspan=14 height=41 class=xl124 width=967 style='height:30.75pt;
  width:728pt'>IN-OUT DETAIL REPORT</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl120 style='height:14.25pt;mso-ignore:colspan'></td>
  <td class=xl121></td>
  <td colspan=6 class=xl120 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td rowspan=2 height=38 class=xl123 style='height:28.5pt'>Seq.</td>
  <td rowspan=2 class=xl123>DEPT</td>
  <td rowspan=2 class=xl123>NO.</td>
  <td colspan=3 class=xl123 style='border-left:none'>DATE</td>
  <td colspan=3 class=xl123 style='border-left:none'>IN</td>
  <td colspan=3 class=xl123 style='border-left:none'>OUT</td>
  <td rowspan=2 class=xl123>REMARKS</td>
  <td rowspan=2 class=xl123>SHIFT</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl122 id="_x0000_s1028" x:autofilter="all"
  style='height:14.25pt;border-top:none;border-left:none'>YEAR</td>
  <td class=xl122 id="_x0000_s1029" x:autofilter="all" style='border-top:none;
  border-left:none'>MONTH</td>
  <td class=xl122 id="_x0000_s1030" x:autofilter="all" style='border-top:none;
  border-left:none'>DAY</td>
  <td class=xl122 id="_x0000_s1031" x:autofilter="all" style='border-top:none;
  border-left:none'>HOUR</td>
  <td class=xl122 id="_x0000_s1032" x:autofilter="all" style='border-top:none;
  border-left:none'>MIN</td>
  <td class=xl122 id="_x0000_s1033" x:autofilter="all" style='border-top:none;
  border-left:none'>SEC</td>
  <td class=xl122 id="_x0000_s1034" x:autofilter="all" style='border-top:none;
  border-left:none'>HOUR</td>
  <td class=xl122 id="_x0000_s1035" x:autofilter="all" style='border-top:none;
  border-left:none'>MIN</td>
  <td class=xl122 id="_x0000_s1036" x:autofilter="all" style='border-top:none;
  border-left:none'>SEC</td>
 </tr>
 <% for (int _i = 0; _i < irow_emp; _i++)
    { %>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl112 style='height:14.25pt;border-bottom:.5pt hairline #00CCFF;border-top:.5pt hairline #00CCFF;' x:num><%=_i+1 %></td>
  <td class=xl113 style='border-left:none;border-bottom:.5pt hairline #00CCFF;border-top:.5pt hairline #00CCFF;'><%=dt_Emp.Rows[_i][1].ToString() %></td>
  <td class=xl108 style='border-left:none;border-bottom:.5pt hairline #00CCFF;border-top:.5pt hairline #00CCFF;' x:num><%=dt_Emp.Rows[_i][2].ToString() %></td>
  <td class=xl109 style='border-left:none;border-bottom:.5pt hairline #00CCFF;border-top:.5pt hairline #00CCFF;' x:num><%=dt_Emp.Rows[_i][3].ToString() %></td>
  <td class=xl109 style='border-left:none;border-bottom:.5pt hairline #00CCFF;border-top:.5pt hairline #00CCFF;' x:num><%=dt_Emp.Rows[_i][4].ToString() %></td>
  <td class=xl109 style='border-left:none;border-bottom:.5pt hairline #00CCFF;border-top:.5pt hairline #00CCFF;' x:num><%=dt_Emp.Rows[_i][5].ToString() %></td>
  <td class=xl109 style='border-left:none;border-bottom:.5pt hairline #00CCFF;border-top:.5pt hairline #00CCFF;' x:num><%=dt_Emp.Rows[_i][6].ToString() %></td>
  <td class=xl110 style='border-left:none;border-bottom:.5pt hairline #00CCFF;border-top:.5pt hairline #00CCFF;' x:num><%=dt_Emp.Rows[_i][7].ToString() %></td>
  <td class=xl110 style='border-left:none;border-bottom:.5pt hairline #00CCFF;border-top:.5pt hairline #00CCFF;' x:num><%=dt_Emp.Rows[_i][8].ToString() %></td>
  <td class=xl109 style='border-left:none;border-bottom:.5pt hairline #00CCFF;border-top:.5pt hairline #00CCFF;' x:num><%=dt_Emp.Rows[_i][9].ToString() %></td>
  <td class=xl109 style='border-left:none;border-bottom:.5pt hairline #00CCFF;border-top:.5pt hairline #00CCFF;' x:num><%=dt_Emp.Rows[_i][10].ToString() %></td>
  <td class=xl109 style='border-left:none;border-bottom:.5pt hairline #00CCFF;border-top:.5pt hairline #00CCFF;' x:num><%=dt_Emp.Rows[_i][11].ToString() %></td>
  <td class=xl109 style='border-left:none;border-bottom:.5pt hairline #00CCFF;border-top:.5pt hairline #00CCFF;'><%=dt_Emp.Rows[_i][12].ToString() %></td>
  <td class=xl111 style='border-left:none;border-bottom:.5pt hairline #00CCFF;border-top:.5pt hairline #00CCFF;'><%=dt_Emp.Rows[_i][13].ToString() %></td>
 </tr>
 <%} %>
 <tr height=3 style='mso-height-source:userset;height:2.25pt'>
  <td height=3 class=xl115 style='height:2.25pt'>&nbsp;</td>
  <td class=xl116>&nbsp;</td>
  <td class=xl117 style='border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-left:none'>&nbsp;</td>
  <td class=xl118 style='border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-left:none'>&nbsp;</td>
  <td class=xl119 style='border-left:none'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>

 </tr>
 <![endif]>
</table>

</body>

</html>
