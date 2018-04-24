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
    string l_group = Request.QueryString["l_group"].ToString();
    string l_pay_type = Request.QueryString["l_pay_type"].ToString();
    string l_m_type = Request.QueryString["l_m_type"].ToString();
    string l_bn_times = Request.QueryString["l_bn_times"].ToString();
    string l_emp_id = Request.QueryString["l_emp_id"].ToString();
    string l_dept = Request.QueryString["l_dept"].ToString();
    string l_year = Request.QueryString["l_year"].ToString();
    
    string SQL
	= "select dep.org_nm C0, te.EMP_ID C1, te.FULL_NAME C2, to_char(to_date(te.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') C3, " + 
        "    TO_CHAR(TO_DATE(BN_FROM,'YYYYMMDD'),'DD/MM/YYYY') || '-' || TO_CHAR(TO_DATE(BN_TO,'YYYYMMDD'),'DD/MM/YYYY') C4 , tb.SALARY C5, tb.SENIORITY C6, tb.RATIO C7, " +
        "        (case when tb.MONEY_KIND='02' then round(nvl(tb.BN_AMT,0)*nvl(tb.BN_EXT_RATE,0),3) " +
        "            else round(nvl(tb.BN_AMT,0),0) end) as C8,com.PARTNER_LNAME c9,com.TCO_BPPHOTO_PK c10 " +
        "from thr_bonus tb, thr_employee te,tco_org dep,tco_company com  " +
        "where tb.DEL_IF=0 and dep.del_if=0 and dep.pk =te.tco_org_PK and nvl(tb.BN_AMT,0)>0  " +
        "    and te.DEL_IF = 0 and com.del_if=0 and dep.tco_company_pk=com.pk " +
        "    and tb.THR_EMP_PK = te.pk " +
        "    and tb.BN_YEAR='" + l_year + "' " +
        "    and decode('" + l_pay_type + "','ALL','" + l_pay_type + "',tb.PAY_TYPE)='" + l_pay_type + "'  " +
        "    and decode('" + l_m_type + "','ALL','" + l_m_type + "',tb.MONEY_KIND)='" + l_m_type + "'  " +
        "    and decode('" + l_bn_times + "','ALL','" + l_bn_times + "',tb.BN_TIMES)='" + l_bn_times + "'  " +
        "    and (te.EMP_ID like  '%'||'" + l_emp_id + "'||'%' or '" + l_emp_id + "' is null) " +
        "    and (te.tco_org_PK in   (  " +
        "                              SELECT     g.pk  " +
        "                                    FROM tco_org g  " +
        "                                   WHERE g.del_if = 0  " +
                "                              START WITH g.pk =  " +
        "                                            DECODE ('" + l_dept + "',  " +
        "                                                    'ALL', 0,  " +
        "                                                    '" + l_dept + "'  " +
        "                                                   )  " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "            OR '" + l_dept + "' = 'ALL')  " +
        "   order by dep.org_nm, te.EMP_ID     ";
    //Response.Write(SQL);
    //Response.End();
    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
    int emp_row=dt_emp.Rows.Count;
    if (dt_emp.Rows.Count == 0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }


        
 %>
 
 

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_bonus_slip_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_bonus_slip_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_bonus_slip_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Ho Thu Hien</o:Author>
  <o:LastAuthor>Ho Thu Hien</o:LastAuthor>
  <o:LastPrinted>2010-02-04T02:35:08Z</o:LastPrinted>
  <o:Created>2010-02-03T01:34:34Z</o:Created>
  <o:LastSaved>2010-02-04T02:36:09Z</o:LastSaved>
  <o:Company>Vina Genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.24in .22in .14in .71in;
	mso-header-margin:.08in;
	mso-footer-margin:14316557.65in;
	mso-page-orientation:landscape;}
.font5
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font7
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font8
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
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
	padding:0px;
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
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	white-space:normal;}
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
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>18</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>24</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
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
        for (int m=0;m<emp_row;m=m+6)
        {
                irow+=35 ;
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
  <x:WindowWidth>15180</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=928 style='border-collapse:
 collapse;table-layout:fixed;width:698pt'>
 <col width=54 style='mso-width-source:userset;mso-width-alt:1974;width:41pt'>
 <col width=158 style='mso-width-source:userset;mso-width-alt:5778;width:119pt'>
 <col width=207 style='mso-width-source:userset;mso-width-alt:7570;width:155pt'>
 <col width=90 style='mso-width-source:userset;mso-width-alt:3291;width:68pt'>
 <col width=54 style='mso-width-source:userset;mso-width-alt:1974;width:41pt'>
 <col width=158 style='mso-width-source:userset;mso-width-alt:5778;width:119pt'>
 <col width=207 style='mso-width-source:userset;mso-width-alt:7570;width:155pt'>
 <%
    int i,k;
    k=0;
    i=0;
    int iblankrow=0;
    while(i<emp_row)
    {
        iblankrow=iblankrow+1;
        k=i+1;
 %>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td colspan=3 class=xl41 width=365 style='height:27.75pt;border-right:2.0pt double windowtext;
  width:274pt'><%=dt_emp.Rows[i][9].ToString()%><font class="font7"><br>
    BONUS SLIP <%=l_year %> - </font><font class="font8">PHI&#7870;U TH&#431;&#7902;NG
  <%=l_year %></font></td>
  <td width=90 style='width:68pt'></td>
  <%
     if (k<=emp_row-1) 
     {
   %>

  <td colspan=3 class=xl41 width=365 style='border-right:2.0pt double windowtext;
  width:274pt'><%=dt_emp.Rows[k][9].ToString()%><font class="font7"><br>
    BONUS SLIP <%=l_year %> - </font><font class="font8">PHI&#7870;U TH&#431;&#7902;NG
  <%=l_year %></font></td>
  <%} %>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:13.5pt'>
  <td class=xl30 colspan=2 style="height:14pt;mso-ignore:colspan;
  border-right:.5pt solid black">B&#7897; ph&#7853;n (<font class="font9">Group</font><font
  class="font5">):</font></td>
  <td class=xl24 style="border-top:none;border-left:none; height: 14pt;white-space:nowrap;
	mso-text-control:shrinktofit;"><%=dt_emp.Rows[i][0].ToString()%></td>
  <td class=xl25 style="height: 14pt"></td>
   <%
     if (k<=emp_row-1) 
     {
   %>
  <td class=xl30 colspan=2 style="mso-ignore:colspan;border-right:.5pt solid black; height: 14pt;">B&#7897; ph&#7853;n  (<font class="font9">Group</font><font class="font5">):</font></td>
  <td class=xl24 style="border-top:none;border-left:nonewhite-space:nowrap;
	mso-text-control:shrinktofit; height: 14pt;"><%=dt_emp.Rows[k][0].ToString()%></td>
  <%} %>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:13.5pt'>
  <td height=22 class=xl32 colspan=2 style='height:13.5pt;mso-ignore:colspan;
  border-right:.5pt solid black'>Mã s&#7889; (<font class="font9">Emp ID</font><font
  class="font5">):<span style='mso-spacerun:yes'>&nbsp;</span></font></td>
  <td class=xl38 style='border-top:none;border-left:none' x:str><%=dt_emp.Rows[i][1].ToString()%></td>
  <td class=xl25></td>
   <%
     if (k<=emp_row-1) 
     {
   %>
  <td class=xl32 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black'>Mã
  s&#7889; (<font class="font9">Emp ID</font><font class="font5">):<span
  style='mso-spacerun:yes'>&nbsp;</span></font></td>
  <td class=xl38 style='border-top:none;border-left:none' x:str><%=dt_emp.Rows[k][1].ToString()%></td>
  <%} %>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:13.5pt'>
  <td height=22 class=xl32 colspan=2 style='height:13.5pt;mso-ignore:colspan;
  border-right:.5pt solid black'>H&#7885; tên (<font class="font9">Name</font><font
  class="font5">):</font></td>
  <td class=xl37 style='border-top:none;border-left:none;white-space:nowrap;
	mso-text-control:shrinktofit;'><%=dt_emp.Rows[i][2].ToString()%></td>
  <td class=xl25></td>
   <%
     if (k<=emp_row-1) 
     {
   %>
  <td class=xl32 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black'>H&#7885;
  tên (<font class="font9">Name</font><font class="font5">):</font></td>
  <td class=xl37 style='border-top:none;border-left:none;white-space:nowrap;
	mso-text-control:shrinktofit;'><%=dt_emp.Rows[k][2].ToString()%></td>
  <%} %>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:13.5pt'>
  <td height=22 class=xl32 colspan=2 style='height:13.5pt;mso-ignore:colspan;
  border-right:.5pt solid black'>Ngày vào (<font class="font9">Join Date</font><font
  class="font5">):</font></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][3].ToString()%></td>
  <td class=xl25></td>
   <%
     if (k<=emp_row-1) 
     {
   %>
  <td class=xl32 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black'>Ngày
  vào (<font class="font9">Join Date</font><font class="font5">):</font></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt_emp.Rows[k][3].ToString()%></td>
  <%} %>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:13.5pt'>
  <td height=22 class=xl32 colspan=2 style='height:13.5pt;mso-ignore:colspan;
  border-right:.5pt solid black'>M&#7889;c tính th&#432;&#7903;ng (<font
  class="font9">Bonus Period</font><font class="font5">):</font></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][4].ToString()%></td>
  <td class=xl25></td>
   <%
     if (k<=emp_row-1) 
     {
   %>
  <td class=xl32 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black'>M&#7889;c
  tính th&#432;&#7903;ng (<font class="font9">Bonus Period</font><font
  class="font5">):</font></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt_emp.Rows[k][4].ToString()%></td>
  <%} %>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:13.5pt'>
  <td height=22 class=xl32 colspan=2 style='height:13.5pt;mso-ignore:colspan;
  border-right:.5pt solid black'>Ti&#7873;n l&#432;&#417;ng (<font class="font9">Salary</font><font
  class="font5">):</font></td>
  <td class=xl27 align=right style='border-top:none;border-left:none'
  x:num><%=dt_emp.Rows[i][5].ToString()%></td>
  <td class=xl25></td>
   <%
     if (k<=emp_row-1) 
     {
   %>
  <td class=xl32 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black'>Ti&#7873;n
  l&#432;&#417;ng (<font class="font9">Salary</font><font class="font5">):</font></td>
  <td class=xl27 align=right style='border-top:none;border-left:none'
  x:num><%=dt_emp.Rows[k][5].ToString()%></td>
  <%} %>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:13.5pt'>
  <td height=22 class=xl32 colspan=2 style='height:13.5pt;mso-ignore:colspan;
  border-right:.5pt solid black'>Thâm niên (<font class="font9">Duration
  Service</font><font class="font5">):</font></td>
  <td class=xl28 align=right style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][6].ToString()%></td>
  <td class=xl25></td>
   <%
     if (k<=emp_row-1) 
     {
   %>
  <td class=xl32 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black'>Thâm
  niên (<font class="font9">Duration Service</font><font class="font5">):</font></td>
  <td class=xl28 align=right style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[k][6].ToString()%></td>
  <%} %>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:13.5pt'>
  <td height=22 class=xl32 colspan=2 style='height:13.5pt;mso-ignore:colspan;
  border-right:.5pt solid black'>T&#7927; l&#7879; (<font class="font9">Ratio</font><font
  class="font5">):</font></td>
  <td class=xl29 align=right style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][7].ToString()%></td>
  <td class=xl25></td>
   <%
     if (k<=emp_row-1) 
     {
   %>
  <td class=xl32 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black'>T&#7927;
  l&#7879; (<font class="font9">Ratio</font><font class="font5">):</font></td>
  <td class=xl29 align=right style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[k][7].ToString()%></td>
  <%} %>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:13.5pt'>
  <td height=22 class=xl34 colspan=2 style='height:13.5pt;mso-ignore:colspan;
  border-right:.5pt solid black'>T&#7893;ng th&#432;&#7903;ng (<font
  class="font9">Bonus Amount</font><font class="font5">):</font></td>
  <td class=xl39 align=right style='border-top:none;border-left:none'
  x:num><%=dt_emp.Rows[i][8].ToString()%></td>
  <td class=xl25></td>
   <%
     if (k<=emp_row-1) 
     {
   %>
  <td class=xl34 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black'>T&#7893;ng
  th&#432;&#7903;ng (<font class="font9">Bonus Amount</font><font class="font5">):</font></td>
  <td class=xl39 align=right style='border-top:none;border-left:none'
  x:num><%=dt_emp.Rows[k][8].ToString()%></td>
  <%} %>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:22.5pt'>
  <td height=22 class=xl34 colspan=2 style='height:22.5pt;mso-ignore:colspan;
  border-right:.5pt solid black'>Chữ ký (<font
  class="font9">Signature</font><font class="font5">):</font></td>
  <td class=xl39 align=right style='border-top:none;border-left:none'
  x:num></td>
  <td class=xl25></td>
   <%
     if (k<=emp_row-1) 
     {
   %>
  <td class=xl34 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black'>Chữ ký (<font class="font9">Signature</font><font class="font5">):</font></td>
  <td class=xl39 align=right style='border-top:none;border-left:none'
  x:num></td>
  <%} %>
 </tr>
 <%if (iblankrow%3!=0)
    { %>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 colspan=7 style='height:21.0pt;mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <%
    i=i+2;
 } %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=54 style='width:41pt'></td>
  <td width=158 style='width:119pt'></td>
  <td width=207 style='width:155pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=158 style='width:119pt'></td>
  <td width=207 style='width:155pt'></td>
 </tr>
 <![endif]></table>

</body>

</html>
