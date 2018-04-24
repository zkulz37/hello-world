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
    string p_date,p_manager_pk,p_send_flag;    
    p_date          = Request["p_date"].ToString();
    p_manager_pk    = Request["p_manager_pk"].ToString();
    p_send_flag     = Request["p_send_flag"].ToString();
    
    
  string SQL
	= "select manager_id,manager_name,manager_mail,count(*) as emp_total,max(decode(nvl(a.send_flag,0),0,'NOT SEND',1,'SEND OK','SEND FAIL')),max(send_note) " + 
        "       from thr_non_lately_mail a " +
        "       where a.del_if=0 and a.WORK_DT='" + p_date +"'" +
        "       and decode('" + p_manager_pk + "','ALL','ALL',a.manager_pk)='" + p_manager_pk + "'" +
        "       and decode('" + p_send_flag + "','ALL','ALL',nvl(a.send_flag,0))='" + p_send_flag + "' " +
        "        group by manager_pk,manager_id,manager_name,manager_mail " +
        "       order by manager_id " ;

   
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
<link rel=File-List href="rpt_mail_manager_list_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_mail_manager_list_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_mail_manager_list_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>truong</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:Created>2011-08-17T02:30:55Z</o:Created>
  <o:LastSaved>2011-08-17T02:35:08Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
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
	text-align:right;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;}
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
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>19</x:ActiveRow>
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
  <x:WindowWidth>19035</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=864 style='border-collapse:
 collapse;table-layout:fixed;width:648pt'>
 <col width=64 style='width:48pt'>
 <col width=101 style='mso-width-source:userset;mso-width-alt:3693;width:76pt'>
 <col width=211 style='mso-width-source:userset;mso-width-alt:7716;width:158pt'>
 <col width=132 style='mso-width-source:userset;mso-width-alt:4827;width:99pt'>
 <col width=97 style='mso-width-source:userset;mso-width-alt:3547;width:73pt'>
 <col width=99 style='mso-width-source:userset;mso-width-alt:3620;width:74pt'>
 <col width=160 style='mso-width-source:userset;mso-width-alt:5851;width:120pt'>
 <tr class=xl27 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl28 width=64 style='height:22.5pt;width:48pt'>Date:</td>
  <td class=xl27 width=101 style='width:76pt' x:str><%=p_date.Substring(6,2).ToString() + "/" + p_date.Substring(4,2).ToString()+ "/" + p_date.Substring(0,4).ToString()  %></td>
  <td class=xl27 width=211 style='width:158pt'></td>
  <td class=xl27 width=132 style='width:99pt'></td>
  <td class=xl27 width=97 style='width:73pt'></td>
  <td class=xl28 width=99 style='width:74pt'>Total:</td>
  <td class=xl29 width=160 style='width:120pt' x:num><%=irow_emp %></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl26 style='height:19.5pt'>No.</td>
  <td class=xl26 style='border-left:none'>Manager ID</td>
  <td class=xl26 style='border-left:none'>Manager Name</td>
  <td class=xl26 style='border-left:none'>Manager Mail</td>
  <td class=xl26 style='border-left:none'>Total Emp</td>
  <td class=xl26 style='border-left:none'>Send Flag</td>
  <td class=xl26 style='border-left:none'>Time</td>
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
 </tr>
 <%} %>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=7 style='height:19.5pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=211 style='width:158pt'></td>
  <td width=132 style='width:99pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=160 style='width:120pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
