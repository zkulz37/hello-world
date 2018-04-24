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
    string p_org, p_wg, p_from, p_to, p_txtID, p_txtOpt;
    p_org = Request.QueryString["p_org"];
    p_wg = Request.QueryString["p_wg"];
    p_txtOpt = Request.QueryString["p_txtOpt"];
    p_from = Request.QueryString["p_from"];
    p_to = Request.QueryString["p_to"];
    p_txtID = Request.QueryString["p_txtID"];
    DateTime dt_from_mon= new DateTime(int.Parse(p_from.Substring(0,4).ToString()),int.Parse(p_from.Substring(4,2).ToString()),int.Parse(p_from.Substring(6,2).ToString()));
    DateTime dt_to_mon= new DateTime(int.Parse(p_to.Substring(0,4).ToString()),int.Parse(p_to.Substring(4,2).ToString()),int.Parse(p_to.Substring(6,2).ToString()));
    DateTime dt_cur_date=dt_from_mon;
    String[] array_date= new String[31];
    int i=0;
    int i_days=0;
    while (dt_cur_date<=dt_to_mon)
    {
        i_days++;
        array_date[i]=dt_cur_date.ToString("yyyyMMdd");
        dt_cur_date=dt_cur_date.AddDays(1);
        i++;
    }
   
  string SQL
	= "SELECT HR.EMP_ID a0,HR.FULL_NAME a1,HR.T2 a2,HR.T3 a3,HR.T4 a4,HR.T5 a5 " ;
   for (i=1;i<=i_days;i++)     
   {
          SQL= SQL + " ,HR.D" + i ;
   }
   SQL= SQL + " FROM " +
        "( " +
        "SELECT C.EMP_ID EMP_ID,C.FULL_NAME FULL_NAME,D.ORG_NM T2,E.WORKGROUP_NM T3,MAX(TO_CHAR(TO_DATE(C.JOIN_DT,'YYYYMMDD'),'DD/MM/YYYY')) T4,MAX(TO_CHAR(TO_DATE(C.LEFT_DT,'YYYYMMDD'),'DD/MM/YYYY')) T5 ";
   for (i=1;i<=i_days;i++)     
   {
          SQL= SQL +  "  ,max(NVL(DECODE(A.WORK_DT,'" + array_date[i-1] + "',NVL2(A.HOL_TYPE,'R','') || B.SHIFT, ''), '')) D" + i ;
   }    
   SQL = SQL + 
        "    FROM THR_WG_SCH_DETAIL a,THR_WORK_SHIFT b,THR_EMPLOYEE C,COMM.TCO_ORG D,THR_WORK_GROUP E " +
        "    WHERE a.DEL_IF=0 AND b.del_if=0 AND C.DEL_IF=0 AND D.DEL_IF=0 AND E.DEL_IF=0 " +
        "        AND A.THR_EMP_PK=C.PK AND C.THR_WG_PK=E.PK AND C.TCO_ORG_PK=D.PK " +
        "        AND A.THR_WS_PK=b.pk " +
        "        AND a.WORK_DT BETWEEN '" + p_from + "' and '" + p_to +  "'" +
        "        AND C.JOIN_DT<=A.WORK_DT " +
        "        AND (C.LEFT_DT IS NULL OR C.LEFT_DT>A.WORK_DT) " +
        "         AND DECODE('" + p_wg + "','ALL','ALL',E.PK)='" + p_wg +"' " +
        "        AND (   C.TCO_ORG_PK IN ( " +
        "                              SELECT     G.PK " +
        "                                    FROM COMM.TCO_ORG G " +
        "                                   WHERE G.DEL_IF = 0 " +
        "                              START WITH G.PK =DECODE ('" + p_org + "','ALL', 0,'" + p_org +"') " +
        "                              CONNECT BY PRIOR G.PK = G.P_PK) " +
        "                        OR '" + p_org + "' = 'ALL') " +
        "        AND (('" + p_txtOpt + "'='1' AND UPPER(C.FULL_NAME) LIKE  '%' || UPPER('" + p_txtID + "')|| '%') " +
        "         OR ('" + p_txtOpt + "'='2' AND UPPER(C.EMP_ID) LIKE  '%' || UPPER('" + p_txtID + "')|| '%') " +
        "         OR ('" + p_txtOpt + "'='3' AND UPPER(C.ID_NUM) LIKE  '%' || UPPER('" + p_txtID + "')|| '%' ))    " +
        "        GROUP BY  A.THR_EMP_PK,C.EMP_ID,C.FULL_NAME,D.ORG_NM,E.WORKGROUP_NM)HR " +
		"        ORDER BY HR.EMP_ID " ;
//Response.Write(SQL);
//Response.End();  
    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
    int count_emp=dt_emp.Rows.Count;
    if(count_emp==0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_schedule_detail_month_vst_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_schedule_detail_month_vst_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_schedule_detail_month_vst_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Hee</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2008-10-02T03:18:11Z</o:LastPrinted>
  <o:Created>2008-10-02T03:07:02Z</o:Created>
  <o:LastSaved>2011-02-28T07:00:42Z</o:LastSaved>
  <o:Company>Hee Nguyen</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.79in .48in 1.0in .5in;
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
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl34
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
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
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>4</x:TopRowBottomPane>
     <x:SplitVertical>6</x:SplitVertical>
     <x:LeftColumnRightPane>6</x:LeftColumnRightPane>
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
       <x:ActiveRow>6</x:ActiveRow>
       <x:ActiveCol>11</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:ConditionalFormatting>
     <x:Range>$H$3:$AT$65536</x:Range>
     <x:Condition>
      <x:Value1>IF(LEFT(H3,1)=&quot;R&quot;,TRUE,FALSE)</x:Value1>
      <x:Format Style='background:#FF99CC'/>
     </x:Condition>
    </x:ConditionalFormatting>
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
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=935 style='border-collapse:
 collapse;table-layout:fixed;width:703pt'>
 <col class=xl24 width=41 style='mso-width-source:userset;mso-width-alt:1499;
 width:31pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=192 style='mso-width-source:userset;mso-width-alt:7021;
 width:144pt'>
 <col class=xl24 width=111 span=2 style='mso-width-source:userset;mso-width-alt:
 4059;width:83pt'>

 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl24 width=42 span="<%=i_days %>" style='mso-width-source:userset;mso-width-alt:
 1536;width:32pt'>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=12 height=40 class=xl39 width=935 style='height:30.0pt;
  width:703pt' x:str="MONTHLY SCHEDULE DETAIL ">MONTHLY SCHEDULE DETAIL<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl24 style='height:19.5pt'></td>
  <td class=xl34>Work Month</td>
  <td class=xl35><%=dt_from_mon.ToString("dd/MM/yyyy") %> ~ <%=dt_to_mon.ToString("dd/MM/yyyy") %></td>
  <td class=xl33></td>
  <td class=xl25></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl26 style='height:22.5pt'>No.</td>
  <td class=xl27>Emp ID</td>
  <td class=xl27>Full Name</td>
  <td class=xl27>Organization</td>
  <td class=xl27>Work Group</td>
  <td class=xl27>Join DT</td>
  <td class=xl27>Left DT</td>
 
  <% 
    dt_cur_date=dt_from_mon;
    String s_format;
    for (int j=0;j<i_days;j++)
    {
        if (dt_cur_date.DayOfWeek.ToString()=="Sunday")
            s_format=";background:#FF99CC;mso-pattern:auto none;";
        else
            s_format="";
        dt_cur_date=dt_cur_date.AddDays(1);
        
        %>
  <td rowspan=2 class=xl26 style='border-bottom:.5pt solid black;<%=s_format %>' x:num><%=array_date[j].Substring(6,2) %></td>
  <%} %>
 
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl28 style='height:21.0pt'>Stt</td>
  <td class=xl29>Mã số</td>
  <td class=xl29>Họ và tên</td>
  <td class=xl29>Bộ phận</td>
  <td class=xl29>Nhóm</td>
  <td class=xl29>Ngày vào</td>
 <td class=xl29>Ngày NV</td>
 </tr>
  <% 
    
    for (int j=0;j<count_emp;j++)
   { 
        %>
 <tr height=34 style='mso-height-source:userset;height:26.1pt'>
  <td height=34 class=xl30 width=41 style='height:26.1pt;width:31pt' x:num><%=j+1 %></td>
  <td class=xl31 width=75 style='width:56pt'><%=dt_emp.Rows[j][0].ToString()%></td>
  <td class=xl38><%=dt_emp.Rows[j][1].ToString()%></td>
  <td class=xl38><%=dt_emp.Rows[j][2].ToString()%></td>
  <td class=xl38><%=dt_emp.Rows[j][3].ToString()%></td>
  <td class=xl36 width=84 style='width:63pt'><%=dt_emp.Rows[j][4].ToString()%></td>
  <td class=xl32 width=75 style='width:56pt'><%=dt_emp.Rows[j][5].ToString()%></td>
   <% 
    dt_cur_date=dt_from_mon;
    for (int k=0;k<i_days;k++)
    {
        if (dt_cur_date.DayOfWeek.ToString()=="Sunday")
            s_format=";background:#FF99CC;mso-pattern:auto none;";
        else
            s_format="";
        dt_cur_date=dt_cur_date.AddDays(1);
        %>
 <td class=xl36 width=42 style='width:32pt<%=s_format %>' x:num><%=dt_emp.Rows[j][6+k].ToString()%></td>
  <%} %>
 
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=41 style='width:31pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=192 style='width:144pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=42 style='width:32pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
