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
    string p_tco_org_pk,p_position,p_search_by,p_txt,p_app_status,p_emp_status,p_from_app,p_to_app,p_sal_rule;
    p_tco_org_pk = Request["p_tco_org"].ToString();
    p_position = Request["p_position"].ToString();
    p_search_by = Request["p_search_by"].ToString();
    p_txt = Request["p_txt"].ToString();
    p_app_status = Request["p_app_status"].ToString();
    p_emp_status = Request["p_emp_status"].ToString();
    p_from_app = Request["p_from"].ToString();
    p_to_app = Request["p_to"].ToString();
    
    p_sal_rule = Request["p_sal_rule"].ToString();
   
   string SQL
    = "SELECT 0, " + 
        "             b.emp_id, b.full_name, " +
        "             from_org.org_nm, (select e.FULL_NAME from thr_employee e where e.del_if=0 and e.pk = a.FROM_MANAGER_PK) " +
        "             , (select code_nm from vhr_hr_code where id='HR0008' and code = a.from_pos_type) " +
        "             , nvl(a.OLD_SALARY,0) " +
        "             , to_org.org_nm, (select e.FULL_NAME from thr_employee e where e.del_if=0 and e.pk = a.TO_MANAGER_PK) " +
        "             , (select code_nm from vhr_hr_code where id='HR0008' and code = a.to_pos_type) " +
        "             , nvl(a.NEW_SALARY,0), to_char(to_date(a.appoint_date,'yyyymmdd'),'dd/mm/yyyy'), decode(a.app_status,'10','Saved','Execute') " +
        "        FROM hr.thr_appointment_detail a, " +
        "             hr.thr_employee b, " +
        "             comm.tco_org g, " +
        "             comm.tco_org from_org, " +
        "             comm.tco_org to_org " +
        "       WHERE a.del_if = 0 " +
        "         AND b.del_if = 0 " +
        "         AND a.thr_employee_pk = b.pk " +
        "         AND from_org.del_if(+) = 0 " +
        "         AND a.from_org_pk = from_org.pk(+) " +
        "         AND to_org.del_if(+) = 0 " +
        "         AND a.to_org_pk = to_org.pk(+) " +
        "         AND g.del_if=0 and b.TCO_ORG_PK = g.PK " +
        "         AND (g.pk IN (SELECT     g.pk " +
        "                                    FROM comm.tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk =DECODE ('" + p_tco_org_pk + "','ALL', 0,'" + p_tco_org_pk + "') " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_tco_org_pk + "' = 'ALL') " +
        "         AND DECODE ('" + p_position + "', 'ALL', '" + p_position + "', b.pos_type) = '" + p_position + "' " +
        "         AND DECODE ('" + p_app_status + "', 'ALL', '" + p_app_status + "', a.APP_STATUS ) = '" + p_app_status + "' " +
        "         AND DECODE ('" + p_emp_status + "', 'ALL', '" + p_emp_status + "', b.status) = '" + p_emp_status + "' " +
        "         AND UPPER (DECODE ('" + p_search_by + "',1, b.full_name,2, b.emp_id,b.id_num)) LIKE '%' || UPPER ('" + p_txt + "') || '%' " +
        "         AND (   '" + p_from_app + "' IS NULL " +
        "                OR '" + p_to_app + "' IS NULL " +
        "                OR a.APPOINT_DATE BETWEEN '" + p_from_app + "' AND '" + p_to_app + "' " +
        "             ) " +
        "         ORDER BY a.THR_EMPLOYEE_PK " ;


    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt_total.Rows.Count;
    if (irow == 0)
        Response.Write("There is no data");
    

 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_change_dept_position_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_change_dept_position_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_change_dept_position_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>welcome</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-05-12T14:05:49Z</o:LastPrinted>
  <o:Created>2011-05-12T09:29:53Z</o:Created>
  <o:LastSaved>2011-05-12T14:06:49Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .25in .5in .25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}
.font9
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border:.5pt solid windowtext;
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
      <x:Scale>65</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
       <x:RangeSelection>$A$2:$M$2</x:RangeSelection>
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
  <x:WindowHeight>9015</x:WindowHeight>
  <x:WindowWidth>17235</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1569 style='border-collapse:
 collapse;table-layout:fixed;width:1179pt'>
 <col width=49 style='mso-width-source:userset;mso-width-alt:1792;width:37pt'>
 <col width=81 style='mso-width-source:userset;mso-width-alt:2962;width:61pt'>
 <col width=174 style='mso-width-source:userset;mso-width-alt:6363;width:131pt'>
 <col width=145 span=3 style='mso-width-source:userset;mso-width-alt:5302;
 width:109pt'>
 <% if(p_sal_rule=="Y") 
    {
 %>
 <col width=100 style='mso-width-source:userset;mso-width-alt:3657;width:75pt'>
 <%
    }
  %>
 <col width=145 span=3 style='mso-width-source:userset;mso-width-alt:5302;
 width:109pt'>
  <% if(p_sal_rule=="Y") 
    {
 %>
 <col width=99 style='mso-width-source:userset;mso-width-alt:3620;width:74pt'>
 <% } %>
 <col width=103 style='mso-width-source:userset;mso-width-alt:3766;width:77pt'>
 <col width=93 style='mso-width-source:userset;mso-width-alt:3401;width:70pt'>

 <tr height=17 style='height:12.75pt'>
  <td height=17 width=49 style='height:12.75pt;width:37pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=174 style='width:131pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=93 style='width:70pt'></td>
 </tr>
 <tr height=51 style='mso-height-source:userset;height:38.25pt'>
  <td colspan=13 height=51 class=xl25 style='height:38.25pt'>DANH SÁCH NHÂN
  VIÊN THAY &#272;&#7892;I PHÒNG BAN - CH&#7912;C V&#7908;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl25 style='height:18.0pt'></td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=94 style='mso-height-source:userset;height:70.5pt'>
  <td height=94 class=xl26 width=49 style='height:70.5pt;width:37pt'>STT<br>
    <br>
    <font class="font9">NO</font></td>
  <td class=xl26 width=81 style='border-left:none;width:61pt'>MÃ NV<br>
    <br>
    <font class="font9">EMP ID</font></td>
  <td class=xl26 width=174 style='border-left:none;width:131pt'>H&#7884;
  TÊN<br>
    <br>
    <font class="font9">FULL NAME</font></td>
  <td class=xl26 width=145 style='border-left:none;width:109pt'>B&#7896;
  PH&#7852;N C&#360;<br>
    <br>
    <font class="font9">OLD ORGANIZATION</font></td>
  <td class=xl26 width=145 style='border-left:none;width:109pt'>QU&#7842;N LÝ
  C&#360;<br>
    <br>
    <font class="font9">OLD MANAGER</font></td>
  <td class=xl26 width=145 style='border-left:none;width:109pt'>CH&#7912;C
  V&#7908; C&#360;<br>
    <br>
    <font class="font9">OLD POSITION</font></td>
     <% if(p_sal_rule=="Y") 
    {
 %>
  <td class=xl26 width=100 style='border-left:none;width:75pt'>L&#431;&#416;NG
  C&#360;<br>
    <br>
    <font class="font9">OLD SALARY</font></td>
  <%} %>
  <td class=xl26 width=145 style='border-left:none;width:109pt'>B&#7896;
  PH&#7852;N M&#7898;I<br>
    <br>
    <font class="font9">NEW ORGANIZATION</font></td>
  <td class=xl26 width=145 style='border-left:none;width:109pt'>QU&#7842;N LÝ
  M&#7898;I<br>
    <br>
    <font class="font9">NEW MANAGER</font></td>
  <td class=xl26 width=145 style='border-left:none;width:109pt'>CH&#7912;C
  V&#7908; M&#7898;I<br>
    <br>
    <font class="font9">NEW POSITION</font></td>
     <% if(p_sal_rule=="Y") 
    {
 %>
  <td class=xl26 width=99 style='border-left:none;width:74pt'>L&#431;&#416;NG
  M&#7898;I<br>
    <br>
    <font class="font9">NEW SALARY</font></td>
 <% } %>
  <td class=xl26 width=103 style='border-left:none;width:77pt'>NGÀY HI&#7878;U
  L&#7920;C<br>
    <br>
    <font class="font9">APPOINTMENT DATE</font></td>
  <td class=xl26 width=93 style='border-left:none;width:70pt'>TÌNH
  TR&#7840;NG<br>
    <br>
    <font class="font9">STATUS</font></td>
 </tr>
  <%
      int count=0;
      for (int i = 0; i < irow; i++)
      { 
        count++;
  %>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 class=xl31 style='height:24.75pt;border-top:none' x:num><%= count %></td>
  <td class=xl32 style='border-top:none;border-left:none' x:str><%= dt_total.Rows[i][1].ToString() %></td>
  <td class=xl27 style='border-top:none;border-left:none'><%= dt_total.Rows[i][2].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none'><%= dt_total.Rows[i][3].ToString() %></td>
  <td class=xl27 style='border-top:none;border-left:none'><%= dt_total.Rows[i][4].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none'><%= dt_total.Rows[i][5].ToString() %></td>
     <% if(p_sal_rule=="Y") 
    {
 %>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][6].ToString() %> </td>
   <%} %>
  <td class=xl31 style='border-top:none;border-left:none'><%= dt_total.Rows[i][7].ToString() %></td>

  <td class=xl27 style='border-top:none;border-left:none'><%= dt_total.Rows[i][8].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none'><%= dt_total.Rows[i][9].ToString() %></td>
   <% if(p_sal_rule=="Y") 
    {
 %>
  <td class=xl30 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][10].ToString() %> </td>
  <%} %>
  <td class=xl29 style='border-top:none;border-left:none' x:str><%= dt_total.Rows[i][11].ToString() %></td>
  <td class=xl27 style='border-top:none;border-left:none'><%= dt_total.Rows[i][12].ToString() %></td>
 </tr>
 <%
    }
  %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=49 style='width:37pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=174 style='width:131pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=93 style='width:70pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
