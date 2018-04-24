<%@ Page Language="C#" %>
<%@ Import Namespace = "System.Data" %>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_group_pk=Request.QueryString[1].ToString();
    string p_search=Request.QueryString[2].ToString();
    string p_input=Request.QueryString[3].ToString();
    string p_tco_org_pk=Request.QueryString[4].ToString();
    string p_from=Request.QueryString[5].ToString();
    string p_to=Request.QueryString[6].ToString();
    string p_nation=Request.QueryString[7].ToString();
    string p_emp_type = Request.QueryString[8].ToString();
 
    string SQL
	= "select " +
		" b.WORKGROUP_NM, to_char(to_date(d.WORK_DT,'yyyymmdd'),'dd/mm/yyyy') as work_dt,a.EMP_ID as emp_id " + 
        "            , a.FULL_NAME, null, d.TIME as time, null, null, null    " +
        "  ,E.ORG_NM,(select CODE_NM from vhr_hr_code where id='HR0017' and code=a.employee_type) " +
        "            FROM THR_EMPLOYEE A,THR_WORK_GROUP B,THR_TIME_TEMP2 D ,COMM.TCO_ORG E" +
        "            WHERE A.DEL_IF=0 AND B.DEL_IF=0  AND E.DEL_IF=0 " +
        "            AND A.THR_WG_PK=B.PK AND A.ID_NUM =D.ID AND A.TCO_ORG_PK=E.PK " +
        "            AND DECODE('" + p_group_pk + "','ALL','" + p_group_pk + "',B.PK) = '" + p_group_pk + "' " +
        "            AND (A.TCO_ORG_PK IN (SELECT  g.pk " +
        "                                            FROM comm.tco_org g " +
        "                                           WHERE g.del_if = 0 " +
        "                                      START WITH g.pk = " +
        "                                                    DECODE ('" + p_tco_org_pk + "', " +
        "                                                            'ALL', 0, " +
        "                                                            '" + p_tco_org_pk + "' " +
        "                                                           ) " +
        "                                      CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                                OR '" + p_tco_org_pk + "' = 'ALL') " +
        "            AND (DECODE('" + p_search + "','1',UPPER(A.EMP_ID),'2',A.ID_NUM,'3',UPPER(A.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "')||'%' " +
        "                        OR '" + p_input + "' IS NULL) " +
        "            AND D.WORK_DT BETWEEN '" + p_from + "' AND '" + p_to + "'             " +
        "      AND DECODE('" + p_emp_type + "','ALL','" + p_emp_type + "',a.employee_type) = '" + p_emp_type + "' " +
        " AND ((D.EVENT IN('4','5') AND '" + p_nation + "'='01') " +
        "          OR (D.EVENT=6 AND '" + p_nation + "'='02') " +
        "          OR  '" + p_nation + "'='ALL') " +
        "   GROUP BY E.ORG_NM, B.workGROUP_NM,D.WORK_DT,A.EMP_ID,A.FULL_NAME,D.TIME,a.employee_type " +
        "   union all " +
        "   select 'NOT IN GROUP' as group_nm, to_char(to_date(d.WORK_DT,'yyyymmdd'),'dd/mm/yyyy') as work_dt,d.ID as emp_id, e.name as full_name,null, d.TIME as time " + 
        "   ,null,null,null "+ 
		"  ,null,null " +
        "    FROM THR_TIME_TEMP2 D,fdmsusr.tuser e "+
        "    WHERE d.id=e.id                         "+
        "            AND D.WORK_DT BETWEEN '" + p_from + "' AND '" + p_to + "'             " +
        "    and d.id not in(select a.id_num from thr_employee a where a.del_if=0 and a.id_num=d.id) "+
        " AND ((D.EVENT IN('4','5') AND '" + p_nation + "'='01') " +
        "          OR (D.EVENT=6 AND '" + p_nation + "'='02') " +
        "          OR  '" + p_nation + "'='ALL') " +
        " AND (DECODE('" + p_search + "','1',UPPER(D.ID),'2',D.ID,'3',UPPER(E.NAME)) LIKE '%'||UPPER('" + p_input + "')||'%' "+
        "                OR '" + p_input + "' IS NULL)   "+
        "    GROUP BY D.WORK_DT,D.ID,E.NAME,D.TIME  "+
        "    ORDER BY WORK_DT,EMP_ID,time" ;
		
		//Response.Write(SQL);
        //Response.End();
	
    DataTable dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Book1_files/filelist.xml">
<link rel=Edit-Time-Data href="Book1_files/editdata.mso">
<link rel=OLE-Object-Data href="Book1_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Hee</o:Author>
  <o:LastAuthor>Hee</o:LastAuthor>
  <o:LastPrinted>2009-05-27T07:50:17Z</o:LastPrinted>
  <o:Created>2009-05-27T07:45:07Z</o:Created>
  <o:LastSaved>2009-05-27T07:53:26Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.49in .33in .47in .37in;
	mso-header-margin:.5in;
	mso-footer-margin:.32in;}
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
	font-size:18.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double navy;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:2.0pt double navy;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double navy;
	border-left:2.0pt double navy;}
.xl30
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double navy;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:2.0pt double navy;
	border-bottom:2.0pt double navy;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double navy;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid navy;
	border-left:2.0pt double navy;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid navy;
	border-left:.5pt dashed windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid navy;
	border-left:.5pt dashed windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double navy;
	border-bottom:.5pt solid navy;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
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
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>18</x:ActiveRow>
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
  <x:WindowHeight>12525</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=709 style='border-collapse:
 collapse;table-layout:fixed;width:533pt'>
 <col class=xl25 width=174 style='mso-width-source:userset;mso-width-alt:2000;
 width:131pt'>
 <col class=xl25 width=174 style='mso-width-source:userset;mso-width-alt:6363;
 width:131pt'>
 <col class=xl25 width=174 style='mso-width-source:userset;mso-width-alt:6363;
 width:131pt'>
 <col class=xl25 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl25 width=97 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <col class=xl25 width=191 style='mso-width-source:userset;mso-width-alt:6985;
 width:143pt'>
 <col class=xl25 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl25 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl25 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 width=174 style='height:12.75pt;width:131pt'></td>
  <td class=xl25 width=89 style='width:67pt'></td>
  <td class=xl25 width=89 style='width:67pt'></td>
  <td class=xl25 width=89 style='width:67pt'></td>
  <td class=xl25 width=97 style='width:73pt'></td>
  <td class=xl25 width=191 style='width:143pt'></td>
  <td class=xl25 width=81 style='width:61pt'></td>
  <td class=xl25 width=77 style='width:58pt'></td>
 </tr>
 <tr height=44 style='mso-height-source:userset;height:33.0pt'>
  <td colspan=7 height=44 class=xl24 style='height:33.0pt'>Checking time Detail</td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:33.0pt'>
  <td height=33 colspan=2 class=xl25 style='height:33.0pt;mso-ignore:colspan'>From Date:<%=p_from.Substring(6,2)+"/"+p_from.Substring(4,2)+"/"+p_from.Substring(0,4) %></td>
  <td height=33 colspan=5 class=xl25 style='height:33.0pt;mso-ignore:colspan'>To Date:<%=p_to.Substring(6,2)+"/"+p_to.Substring(4,2)+"/"+p_to.Substring(0,4) %></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:33.0pt'>
 <td height=33 colspan=4 class=xl25 style='height:33.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td height=33 colspan=5 class=xl25 style='height:33.0pt;mso-ignore:colspan'>Print Date:<%=DateTime.Now.ToString("dd-MM-yyyy") %></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 class=xl26 width=174 style='height:24.75pt;width:131pt'>No</td>  
  <td height=33 class=xl26 width=174 style='height:24.75pt;width:131pt'>Organization</td>
  <td height=33 class=xl26 width=174 style='height:24.75pt;width:131pt'>Work Group</td>
  <td class=xl27 width=89 style='border-left:none;width:67pt'>Date</td>
  <td class=xl27 width=97 style='border-left:none;width:73pt'>Emp ID</td>
  <td class=xl27 width=191 style='border-left:none;width:143pt'>Name</td>
  <td class=xl27 width=77 style='border-left:none;width:58pt;border-right:2.0pt double navy;'>Time</td>
  <td class=xl27 width=77 style='border-left:none;width:58pt;border-right:2.0pt double navy;'>Employee Type</td>
 </tr>
 <%
     for (int i = 0; i < dt.Rows.Count; i++)
     {
  %>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
   <td height=29 class=xl33 style='height:21.75pt;border-top:none' x:num><%=i+1%></td> 
   <td height=29 class=xl33 style='height:21.75pt;border-top:none'><%=dt.Rows[i][9].ToString() %></td>
  <td height=29 class=xl33 style='height:21.75pt;border-top:none'><%=dt.Rows[i][0].ToString() %></td>
  <td class=xl34 style='border-top:none'><%=dt.Rows[i][1].ToString() %></td>
  <td class=xl34 style='border-top:none;border-left:none' x:str><%=dt.Rows[i][2].ToString() %></td>
  <td class=xl35 style='border-top:none;border-left:none'><%=dt.Rows[i][3].ToString() %></td>
  <td class=xl36 style='border-top:none' x:str><%=dt.Rows[i][5].ToString() %></td>
  <td class=xl36 style='border-top:none' x:str><%=dt.Rows[i][10].ToString() %></td>
 </tr>
 <% } %>
 <tr height=2 style='mso-height-source:userset;height:1.5pt'>
  <td height=2 class=xl29 style='height:1.5pt'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=7 class=xl25 style='height:13.5pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=174 style='width:131pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=191 style='width:143pt'></td>
  <td width=77 style='width:58pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
