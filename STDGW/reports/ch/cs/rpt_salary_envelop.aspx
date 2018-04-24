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
    
    string p_dept,p_group,p_status,p_type,p_pay_type,p_emp_id,p_work_mon, p_m_type,p_times,p_emp_type, p_from_leftdate, p_to_leftdate;
     
  
    p_dept       = Request["l_dept"].ToString();
    p_group      = Request["l_group"].ToString();
    p_status      = Request["l_status"].ToString();
    p_type       = Request["l_type"].ToString();
    p_pay_type   = Request["l_pay_type"].ToString();
    p_emp_id     = Request["l_emp_id"].ToString();
    p_work_mon   = Request["l_work_mon"].ToString();
    p_times = Request["l_Times_r"].ToString();
	p_emp_type=Request["l_p1"].ToString();
    p_m_type = Request.QueryString["l_p2"].ToString();
	p_from_leftdate = Request["l_p3"].ToString();
    p_to_leftdate = Request["l_p4"].ToString();
    DateTime p_month_dt=new DateTime(int.Parse(p_work_mon.Substring(0,4).ToString()),int.Parse(p_work_mon.Substring(4,2).ToString()),1) ;
    
    if(p_type=="ALL")
        p_type="=nvl(a.net_amt,0)";
    
    
   string SQL
	= "select  " +
		"A.FULL_NAME A0,   " +
        "A.EMP_ID A1,   " +
        "a.org_level1_nm || '-' || a.org_level2_nm || '-' || a.dept_nm as a2, " +
        "(select p.PARTNER_FNAME from tco_company p where p.del_if=0 and p.pk=b.tco_company_pk) " +
		"from thr_month_salary a,tco_org b " +         
        "where a.del_if=0 and b.del_if=0 and a.tco_dept_pk=b.pk and a.work_mon='" + p_work_mon + "' " +
        " and (a.tco_dept_pk in ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_dept + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_dept + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_dept + "' = 'ALL') " +
        " and decode('" + p_group + "','ALL','ALL',a.thr_group_pk)='" + p_group + "'" +
        " and a.emp_id like '%" + p_emp_id + "%' " + 
        " and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "'" +
        " and decode('" + p_pay_type + "','ALL','ALL',a.pay_type)='" + p_pay_type + "'" +
		 " and decode('" + p_emp_type + "','ALL','ALL',a.employee_type)='" + p_emp_type + "'" +
        " and decode('" + p_m_type + "','ALL','ALL',a.MONEY_KIND)='" + p_m_type + "'" +
		" and ('" + p_from_leftdate + "' is null or '" + p_to_leftdate + "' is null or a.left_dt between '" + p_from_leftdate + "' and '" + p_to_leftdate + "')" + 
        " and decode('" + p_times + "','ALL','ALL',a.times)='" + p_times + "'" +
        " and nvl(a.net_amt,0) " + p_type  +
        " order by a.org_level1_id,a.org_level2_id,a.dept_nm,a.emp_id";



 // Response.Write(SQL);
 // Response.End();

    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp=dt_Emp.Columns.Count;
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
<link rel=File-List href="rpt_salary_envelop_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_salary_envelop_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_salary_envelop_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>toai</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2011-07-26T06:02:18Z</o:LastPrinted>
  <o:Created>2010-05-26T07:10:10Z</o:Created>
  <o:LastSaved>2011-07-26T06:02:37Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .67in 1.0in .51in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
.font5
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font13
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
.xl65
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl68
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl69
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\0022- Phiếu Lương  \0022mm\0022-\0022yyyy";
	text-align:left;}
.xl70
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl71
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl72
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>BI THU</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>99</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>50</x:PageBreakZoom>
     <x:Selected/>
     <x:DoNotDisplayGridlines/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>4</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
      <% 
        int irow=0;
        for (int k=0;k<irow_emp;k++)
        {
            irow+=6;
            
            %>
            
            <x:RowBreak>
                <x:Row><%=irow %></x:Row>
            </x:RowBreak>
            <%    
               
                
        }  
      %>
      
     </x:RowBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=700 style='border-collapse:
 collapse;table-layout:fixed;width:526pt'>
 
 <col width=38 style='mso-width-source:userset;mso-width-alt:1389;width:29pt'>
 <col width=206 style='mso-width-source:userset;mso-width-alt:7533;width:155pt'>
 <col width=132 span=2 style='mso-width-source:userset;mso-width-alt:4827;
 width:99pt'>
 <col width=64 span=3 style='width:48pt'>
 <%
    for (int i=0;i<irow_emp;i++)
    {
  %>
 <tr height=57 style='mso-height-source:userset;height:42.75pt'>
  <td height=57 class=xl67 colspan=2 align=left width=244 style='height:42.75pt;
  mso-ignore:colspan;width:184pt'><%=dt_Emp.Rows[i][3].ToString()%></td>
  <td width=132 style='width:99pt'></td>
  <td width=132 style='width:99pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl70 style='height:12.75pt' x:num><%=i+1 %></td>
  <td class=xl69 x:num>- Phiếu Lương<span style='mso-spacerun:yes'> 
  </span><%=p_work_mon.Substring(4, 2) + "-" + p_work_mon.Substring(0, 4)%></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=144 style='mso-height-source:userset;height:108.0pt'>
  <td height=144 colspan=2 style='height:108.0pt;mso-ignore:colspan'></td>
  <td class=xl68 align=left>Tên <font class="font13">( name) </font><font
  class="font5"><span style='mso-spacerun:yes'>     </span>:</font></td>
  <td class=xl66 align=left><%=dt_Emp.Rows[i][0].ToString()%></td>
  <td></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 colspan=2 style='height:24.0pt;mso-ignore:colspan'></td>
  <td class=xl72>Mã NV<font class="font13"> ( code )</font><font class="font5"><span
  style='mso-spacerun:yes'>  </span>:</font></td>
  <td class=xl73 align=left><%=dt_Emp.Rows[i][1].ToString()%></td>
  <td></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=215 style='mso-height-source:userset;height:161.25pt'>
  <td height=215 colspan=2 style='height:161.25pt;mso-ignore:colspan'></td>
  <td class=xl71 align=left>Bộ phận <font class="font13">( Dept ) </font><font
  class="font5">:</font></td>
  <td class=xl71 align=left><%=dt_Emp.Rows[i][2].ToString()%></td>
  <td></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=494 style='mso-height-source:userset;height:370.5pt'>
  <td height=494 colspan=7 style='height:370.5pt;mso-ignore:colspan'></td>
 </tr>
 
 <%
 }
  %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=38 style='width:29pt'></td>
  <td width=206 style='width:155pt'></td>
  <td width=132 style='width:99pt'></td>
  <td width=132 style='width:99pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
