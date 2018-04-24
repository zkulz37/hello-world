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
<%string p_user="", p_from="", p_to="";
    p_user = Request["p_user"].ToString();
    p_to = Request["p_to"].ToString();
    p_from = Request["p_from"].ToString();
    string SQL
    = "select upper(to_char(sysdate,'dd-mon-yyyy')),e.EMP_ID,e.FULL_NAME,to_char(to_date(e.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') " +
        ",to_char(to_date(m.APPOINT_DATE ,'yyyymmdd'),'dd/mm/yyyy') " +
        ",to_char(m.execute_date,'DD-MM-YYYY HH24:MI:SS')" +
        ",(select o.ORG_NM from comm.tco_org o where o.pk=m.FROM_ORG_PK and o.del_if=0),(select o.ORG_NM from comm.tco_org o where o.pk=m.TO_ORG_PK and o.del_if=0)" +
        "from thr_appointment_detail m,thr_employee e  " +
        "where m.APP_STATUS='20' and m.del_if=0  " +
        "and to_char(m.execute_date,'YYYYmmdd') >='" + p_from + "'  " +
        "and to_char(m.execute_date,'YYYYmmdd') <='" + p_to + "' " +
        "and e.del_if=0 and m.THR_EMPLOYEE_PK=e.pk " +
        "order  by  e.EMP_ID,m.APPOINT_DATE,m.execute_date";
    string SQL2
     = "select count (tb.emp_id),tb.emp_id from (select upper(to_char(sysdate,'dd-mon-yyyy')),e.pk,e.EMP_ID,e.FULL_NAME,to_char(to_date(e.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') " +
         ",to_char(to_date(m.APPOINT_DATE ,'yyyymmdd'),'dd/mm/yyyy') " +
         ",(select o.ORG_NM from comm.tco_org o where o.pk=m.FROM_ORG_PK and o.del_if=0),(select o.ORG_NM from comm.tco_org o where o.pk=m.TO_ORG_PK and o.del_if=0)" +
         "from thr_appointment_detail m,thr_employee e  " +
         "where m.APP_STATUS='20' and m.del_if=0  " +
         "and to_char(m.execute_date,'YYYYmmdd') >='" + p_from + "'  " +
         "and to_char(m.execute_date,'YYYYmmdd') <='" + p_to + "' " +
         "and e.del_if=0 and m.THR_EMPLOYEE_PK=e.pk " +
         "order  by  e.EMP_ID,m.APPOINT_DATE) tb "
         + " group by emp_id  order  by  EMP_ID "
         ;

   // Response.Write(SQL2);
    //Response.End();
    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
    DataTable dt_count = ESysLib.TableReadOpen(SQL2);
    int irow;
    irow = dt_emp.Rows.Count;
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
<link rel=File-List href="Book1_files/filelist.xml">
<link rel=Edit-Time-Data href="Book1_files/editdata.mso">
<link rel=OLE-Object-Data href="Book1_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Genu Test</o:Author>
  <o:LastAuthor>Genu Test</o:LastAuthor>
  <o:Created>2009-11-03T02:11:20Z</o:Created>
  <o:LastSaved>2009-11-03T02:27:15Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .5in .5in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	text-align:center;
	vertical-align:middle;}

-->

</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
      <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:Scale>69</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>4</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
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
  <x:WindowHeight>8580</x:WindowHeight>
  <x:WindowWidth>11340</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=980 style='border-collapse:
 collapse;table-layout:fixed;width:736pt'>
 <col class=xl24 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl24 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <col class=xl24 width=165 style='mso-width-source:userset;mso-width-alt:6034;
 width:124pt'>
 <col class=xl24 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 
 <col class=xl24 width=165 style='mso-width-source:userset;mso-width-alt:6034;
 width:124pt'>
 
 <col class=xl24 width=253 style='mso-width-source:userset;mso-width-alt:9252;
 width:190pt'>
  <col class=xl24 width=253 style='mso-width-source:userset;mso-width-alt:9252;
 width:190pt'>
 <col class=xl24 width=260 style='mso-width-source:userset;mso-width-alt:9508;
 width:195pt'>
 <tr height=34 style='height:25.5pt'>
  <td colspan=8 height=34 class=xl25 width=980 style='height:25.5pt;width:736pt'
  x:str="EMPLOYEES LIST ">EMPLOYEES LIST 
  <span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl27 style='height:15.75pt' >From :<%=p_from.Substring(6,2)+ "/" + p_from.Substring(4, 2) + "/" + p_from.Substring(0, 4)%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl27></td>
  <td class=xl27></td>
  <td class=xl27>To : <%=p_to.Substring(6,2)+ "/" + p_to.Substring(4, 2) + "/" + p_to.Substring(0, 4)%></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl27>Report Date :<%=dt_emp.Rows[0][0].ToString() %></td>
  <td class=xl24></td>
  
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=6 class=xl27 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl26 style='height:15.75pt'>No</td>
  <td class=xl26 style='border-left:none'>Emp ID</td>
  <td class=xl26 style='border-left:none'>Full Name</td>
  <td class=xl26 style='border-left:none'>Join Date</td>
  <td class=xl26 style='border-left:none'>Appointment Date</td>
  <td class=xl26 style='border-left:none'>Execute Date</td>
  <td class=xl26 style='border-left:none'>Old Organization</td>
  <td class=xl26 style='border-left:none'>New Organization</td>
 </tr>
 <%string flag = ""; int t = 1; %>
 <%for(int i=0;i< dt_emp.Rows.Count ;i++){ %>
 <tr height=21 style='height:15.75pt'>
  <%if (flag != dt_emp.Rows[i][1].ToString())
       for (int j = 0; j < dt_count.Rows.Count;j++)
    {if(dt_count.Rows[j][1].ToString()==dt_emp.Rows[i][1].ToString()){
        flag = dt_count.Rows[j][1].ToString();
        %>
  <td  rowspan=<%=dt_count.Rows[j][0].ToString()%> height=21 class=xl29 style='height:15.75pt;border-top:none;text-align:center'><%=t%></td>
  <td rowspan=<%=dt_count.Rows[j][0].ToString()%> class=xl29 style='border-top:none;border-left:none;text-align:center'><%=dt_emp.Rows[i][1].ToString() %></td>
  <td rowspan=<%=dt_count.Rows[j][0].ToString()%> class=xl29 style='border-top:none;border-left:none;text-align:center'><%=dt_emp.Rows[i][2].ToString() %></td>
  <td rowspan=<%=dt_count.Rows[j][0].ToString()%> class=xl29 style='border-top:none;border-left:none;text-align:center'><%=dt_emp.Rows[i][3].ToString() %></td>
  <%t++; break;
    }
  } %>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][4].ToString() %></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][5].ToString() %></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][6].ToString() %></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][7].ToString() %></td>
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=44 style='width:33pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=165 style='width:124pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=253 style='width:190pt'></td>
  <td width=260 style='width:195pt'></td>
  <td width=260 style='width:195pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
