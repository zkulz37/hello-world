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
    string dep_pk = Request.QueryString["dept_pk"].ToString();
    string SQL
    = "select b.DEPT_NM,NVL(a.GROUP_NM,'NO NAME'),a.GROUP_KNM,a.GROUP_FNM,to_char(to_date(a.START_DT,'yyyymmdd'),'dd-mm-yyyy') " + 
        "    ,to_char(to_date(a.END_DT,'yyyymmdd'),'dd-mm-yyyy'),decode(a.USE_YN,'Y','Y','N'),a.REMARK,a.SEQ " +
        "       from   THR_GROUP A,comm.tco_dept b " +
        "       where a.del_if(+)=0 and b.del_if=0 and b.pk=a.TCO_DEPT_PK(+) " +
        "        AND (   b.pk IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM comm.tco_dept g " +
        "                                   WHERE g.del_if = 0 " +
        "                                     AND NVL (g.child_yn, 'Y') = 'N' " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + dep_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + dep_pk + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + dep_pk + "' = 'ALL') " +
        "       AND NVL(B.CHILD_YN,'Y')='N' " +
        "       order by a.tco_dept_pk,nvl(a.SEQ,0) " ;
    //Response.Write(SQL);
    //Response.End();
    DataTable dt_grp = ESysLib.TableReadOpen(SQL);
    int grp_cnt = 0;
    if (dt_grp.Rows.Count == 0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }
    else
    {
        grp_cnt = dt_grp.Rows.Count;
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Book2_files/filelist.xml">
<link rel=Edit-Time-Data href="Book2_files/editdata.mso">
<link rel=OLE-Object-Data href="Book2_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Hee</o:Author>
  <o:LastAuthor>Hee</o:LastAuthor>
  <o:LastPrinted>2008-10-17T01:53:31Z</o:LastPrinted>
  <o:Created>2008-10-17T01:47:48Z</o:Created>
  <o:LastSaved>2008-10-17T01:58:35Z</o:LastSaved>
  <o:Company>Hee Nguyen</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .19in 1.0in .23in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
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
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>3</x:SplitHorizontal>
     <x:TopRowBottomPane>3</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>3</x:LeftColumnRightPane>
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
       <x:ActiveCol>6</x:ActiveCol>
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
  <x:WindowHeight>8445</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$3</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=952 style='border-collapse:
 collapse;table-layout:fixed;width:715pt'>
 <col class=xl24 width=36 style='mso-width-source:userset;mso-width-alt:1316;
 width:27pt'>
 <col class=xl24 width=109 style='mso-width-source:userset;mso-width-alt:3986;
 width:82pt'>
 <col class=xl24 width=111 style='mso-width-source:userset;mso-width-alt:4059;
 width:83pt'>
 <col class=xl24 width=115 style='mso-width-source:userset;mso-width-alt:4205;
 width:86pt'>
 <col class=xl24 width=126 style='mso-width-source:userset;mso-width-alt:4608;
 width:95pt'>
 <col class=xl24 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl24 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl24 width=60 style='mso-width-source:userset;mso-width-alt:2194;
 width:45pt'>
 <col class=xl24 width=128 style='mso-width-source:userset;mso-width-alt:4681;
 width:96pt'>
 <col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <tr height=36 style='height:27.0pt'>
  <td height=36 class=xl24 width=36 style='height:27.0pt;width:27pt'></td>
  <td class=xl24 width=109 style='width:82pt'></td>
  <td class=xl24 width=111 style='width:83pt'></td>
  
  <td class=xl25 colspan=4 width=364 style='mso-ignore:colspan;width:274pt'>GROUP
  ENTRY REPORT</td>
  <td class=xl24 width=128 style='width:96pt'></td>
  <td class=xl24 width=89 style='width:67pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl26 style='height:21.0pt'>No.</td>
  <td class=xl26 style='border-left:none'>Department</td>
  <td class=xl26 style='border-left:none'>Group Name</td>
  <td class=xl26 style='border-left:none'>Group Fname</td>
  <td class=xl26 style='border-left:none'>Group Kname</td>
  <td class=xl26 style='border-left:none'>Start Date</td>
  <td class=xl26 style='border-left:none'>End Date</td>
  <td class=xl26 style='border-left:none'>Use</td>
  <td class=xl26 style='border-left:none'>Remark</td>
  <td class=xl26 style='border-left:none'>Sequence</td>
 </tr>
 <%
     for(int i=0;i<grp_cnt;i++)
     {
%>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl27 style='height:18.0pt;border-top:none' x:num><%=i+1 %></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt_grp.Rows[i][0].ToString() %></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt_grp.Rows[i][1].ToString() %></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt_grp.Rows[i][2].ToString() %></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt_grp.Rows[i][3].ToString() %></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dt_grp.Rows[i][4].ToString() %></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dt_grp.Rows[i][5].ToString() %></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt_grp.Rows[i][6].ToString() %></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt_grp.Rows[i][7].ToString() %></td>
  <td class=xl27 style='border-top:none;border-left:none' x:num><%=dt_grp.Rows[i][8].ToString() %></td>
 </tr>
 <%
    }
  %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=36 style='width:27pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=128 style='width:96pt'></td>
  <td width=89 style='width:67pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
