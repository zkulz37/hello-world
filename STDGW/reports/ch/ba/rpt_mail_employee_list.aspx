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
    string p_date,p_manager_pk,p_send_flag,p_search_by,p_search_temp,p_thr_wg_pk,P_TCO_ORG_PK;    
    p_date          = Request["p_date"].ToString();
    p_manager_pk    = Request["p_manager_pk"].ToString();
    p_send_flag     = Request["p_send_flag"].ToString();
    p_search_by     = Request["p_search_by"].ToString();
    p_search_temp     = Request["p_search_temp"].ToString();
    p_thr_wg_pk     = Request["p_thr_wg_pk"].ToString();
    P_TCO_ORG_PK     = Request["P_TCO_ORG_PK"].ToString();
    
    string SQL
	= " select b.org_nm,c.workgroup_nm,a.emp_id,a.full_name,a.NOTE,a.lately,a.remark,a.MANAGER_ID,a.MANAGER_NAME,a.MANAGER_MAIL " + 
        "       from thr_non_lately_mail a,tco_org b,thr_work_group c " +
        "       where a.del_if=0 and b.del_if=0 and c.del_if=0 and a.tco_org_pk=b.pk  " +
        "       and a.thr_wg_pk=c.pk and a.WORK_DT='" + p_date  + "'" +
        "       and decode('" + p_manager_pk + "','ALL','ALL',a.manager_pk)='" + p_manager_pk + "' " +
        "        AND (   A.TCO_ORG_PK IN ( " +
        "                              SELECT     G.PK " +
        "                                    FROM COMM.TCO_ORG G " +
        "                                   WHERE G.DEL_IF = 0 " +
        "                              START WITH G.PK = " +
        "                                            DECODE ('" + P_TCO_ORG_PK + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + P_TCO_ORG_PK + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR G.PK = G.P_PK) " +
        "                        OR '" + P_TCO_ORG_PK + "'= 'ALL') " +
        "       and decode('" + p_thr_wg_pk + "','ALL','ALL',a.thr_wg_pk)='" + p_thr_wg_pk + "' " +
        "       AND (('" + p_manager_pk + "'<>'ALL') OR (NVL(A.L1_YN,'N')='Y' AND '" + p_manager_pk + "'='ALL')) --CHI LAY LAN 1  " +
        "       AND UPPER (DECODE ('" + p_search_by + "',1, a.full_name,2, a.emp_id)) LIKE '%' || UPPER ('" + p_search_temp + "') || '%' " +
        "       order by manager_id; " +
        "       " ;


   
  //  Response.Write(SQL);
   // Response.End();
    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp=dt_Emp.Columns.Count-2;
    if (irow_emp == 0)
    {
        Response.Write("There is no data of salary");
        Response.End();
    }
   
    
    
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_mail_employee_list_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_mail_employee_list_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_mail_employee_list_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>truong</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2011-08-17T02:47:57Z</o:LastPrinted>
  <o:Created>2011-08-17T02:30:55Z</o:Created>
  <o:LastSaved>2011-08-17T02:48:16Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.37in .22in .31in .27in;
	mso-header-margin:.28in;
	mso-footer-margin:.16in;
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
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:right;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:left;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
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
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>75</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
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
  <x:WindowHeight>8445</x:WindowHeight>
  <x:WindowWidth>19035</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1359 style='border-collapse:
 collapse;table-layout:fixed;width:1021pt'>
 <col width=64 style='width:48pt'>
 <col width=154 style='mso-width-source:userset;mso-width-alt:5632;width:116pt'>
 <col width=153 style='mso-width-source:userset;mso-width-alt:5595;width:115pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=194 style='mso-width-source:userset;mso-width-alt:7094;width:146pt'>
 <col width=151 style='mso-width-source:userset;mso-width-alt:5522;width:113pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=114 style='mso-width-source:userset;mso-width-alt:4169;width:86pt'>
 <col width=76 style='mso-width-source:userset;mso-width-alt:2779;width:57pt'>
 <col width=178 style='mso-width-source:userset;mso-width-alt:6509;width:134pt'>
 <col width=107 style='mso-width-source:userset;mso-width-alt:3913;width:80pt'>
 <tr height=48 style='mso-height-source:userset;height:36.0pt'>
  <td colspan=11 height=48 class=xl31 width=1359 style='height:36.0pt;
  width:1021pt'>LIST OF EMPLOYEES GOING LATE OR NO SCAN CARD</td>
 </tr>
 <tr class=xl27 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl28 style='height:22.5pt'>Date:</td>
  <td class=xl30 x:str><%=p_date.Substring(6,2).ToString() + "/" + p_date.Substring(4,2).ToString()+ "/" + p_date.Substring(0,4).ToString()  %></td>
  <td colspan=7 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl28>Total:</td>
  <td class=xl29 x:num><%=irow_emp %></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl26 style='height:19.5pt'>No.</td>
  <td class=xl26 style='border-left:none'>Organization</td>
  <td class=xl26 style='border-left:none'>Work Group</td>
  <td class=xl26 style='border-left:none'>Emp ID</td>
  <td class=xl26 style='border-left:none'>Full Name</td>
  <td class=xl26 style='border-left:none'>Note</td>
  <td class=xl26 style='border-left:none'>Lately</td>
  <td class=xl26 style='border-left:none'>Remark</td>
  <td class=xl26 style='border-left:none'>Manager ID</td>
  <td class=xl26 style='border-left:none'>Manager Name</td>
  <td class=xl26 style='border-left:none'>Manager Mail</td>
 </tr>
 <%
	for (int i=0;i<irow_emp;i++)
    {
		
 %>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl24 style='height:19.5pt;border-top:none' x:num><%=i+1 %></td>
  <td class=xl24 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][0].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][1].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][2].ToString()%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][3].ToString()%></td>
  <td class=xl24 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][4].ToString()%></td>
  <td class=xl24 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][5].ToString()%></td>
  <td class=xl24 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][6].ToString()%></td>
  <td class=xl24 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][7].ToString()%></td>
  <td class=xl24 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][8].ToString()%></td>
  <td class=xl24 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][9].ToString()%></td>
 </tr>
 <%} %>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=11 style='height:19.5pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=154 style='width:116pt'></td>
  <td width=153 style='width:115pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=194 style='width:146pt'></td>
  <td width=151 style='width:113pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=178 style='width:134pt'></td>
  <td width=107 style='width:80pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
