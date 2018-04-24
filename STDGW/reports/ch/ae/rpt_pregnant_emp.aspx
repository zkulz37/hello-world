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
    string p_user,p_wg,p_search_by,p_search_temp,p_tco_org_pk,p_kind,p_to_regdate,p_from_regdate,p_to_regdate_text,p_from_regdate_text;
    string p_status, p_typeobj;
    p_user = Request["p_user"].ToString();
    p_wg = Request["p_wg"].ToString();
    p_search_by = Request["p_search_by"].ToString();
    p_search_temp = Request["p_search_temp"].ToString();
    p_tco_org_pk = Request["p_tco_org_pk"].ToString();
    p_kind = Request["p_kind"].ToString();
    p_from_regdate = Request["p_from_regdate"].ToString();
    p_to_regdate = Request["p_to_regdate"].ToString();
    p_from_regdate_text = Request["p_from_regdate_text"].ToString();
    p_to_regdate_text = Request["p_to_regdate_text"].ToString();
    p_status = Request["p_status"].ToString();
    p_typeobj = Request["p_typeobj"].ToString();
    
   string SQL
	= "select a.emp_id a0 " + 
        ",a.full_name a1 " +
        ",b.org_nm a2 " +
        ",to_char(to_date(t.pregnancy_dt,'yyyymmdd'),'dd/mm/yyyy') a3 " +
        ",to_char(to_date(t.START_DT,'yyyymmdd'),'dd/mm/yyyy') a4 " +
        " from thr_regulation t,thr_employee a,tco_org b,tco_org c " +
        "where t.del_if=0  and a.del_if=0 and b.del_if=0 and c.del_if=0  " +
        "and t.thr_emp_pk=a.pk and a.tco_org_pk=b.pk and b.p_pk=c.pk and a.MATERNITY_LEAVE_DT is null " +
        "and ((t.end_DT >='" + p_from_regdate + "'  and t.START_DT<='" + p_to_regdate + "') or ('" + p_from_regdate + "' is null or '" + p_from_regdate + "' is null ))  " +
        " and t.kind in ('01') " +
        " AND decode('" + p_status + "','ALL','" + p_status + "',a.status)='" + p_status + "'" +
        "            AND DECODE ('" + p_wg + "', " +
        "                        'ALL', '" + p_wg + "', " +
        "                        a.thr_wg_pk " +
        "                       ) = '" + p_wg + "'" +
        "             AND UPPER (DECODE ('" + p_search_by + "', " +
        "                              1, a.full_name, " +
        "                              2, a.emp_id, " +
        "                              3,a.id_num, " +
        "                              4,person_id, " +
        "                              old_id) " +
        "                     ) LIKE '%' || UPPER ('" + p_search_temp + "') || '%' " +
        "            AND (  a.tco_org_pk IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_tco_org_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_tco_org_pk + "'" +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_tco_org_pk + "'= 'ALL') " + 
        " order by b.org_nm,a.emp_id,t.start_dt " ;

     //Response.Write(SQL);
	//Response.End();
    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt_total.Rows.Count;
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
<link rel=File-List href="rpt_pregnant_emp_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_pregnant_emp_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_pregnant_emp_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>HANSOLL</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2008-11-25T02:15:17Z</o:LastPrinted>
  <o:Created>2006-12-01T02:04:08Z</o:Created>
  <o:LastSaved>2012-07-18T03:33:26Z</o:LastSaved>
  <o:Company>HANSOLL VINA</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.2in .2in .39in .2in;
	mso-header-margin:.51in;
	mso-footer-margin:.51in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
.font7
	{color:blue;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font10
	{color:blue;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
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
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:돋움, monospace;
	mso-font-charset:129;
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
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:돋움, monospace;
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
.xl24
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl28
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl29
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl38
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl39
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>MANG THAI. pregnant (2)</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>95</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9225</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1169 style='border-collapse:
 collapse;table-layout:fixed;width:878pt'>
 <col class=xl24 width=39 style='mso-width-source:userset;mso-width-alt:1109;
 width:29pt'>
<col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col class=xl24 width=186 style='mso-width-source:userset;mso-width-alt:5290;
 width:140pt'>
 <col class=xl24 width=98 style='mso-width-source:userset;mso-width-alt:2787;
 width:74pt'>
 <col class=xl24 width=105 style='mso-width-source:userset;mso-width-alt:2986;
 width:79pt'>
 <col class=xl24 width=114 style='mso-width-source:userset;mso-width-alt:3242;
 width:86pt'>
 <col class=xl24 width=67 span=2 style='mso-width-source:userset;mso-width-alt:
 1905;width:50pt'>
 <col class=xl24 width=74 style='mso-width-source:userset;mso-width-alt:2104;
 width:56pt'>
 <col class=xl24 width=67 span=2 style='mso-width-source:userset;mso-width-alt:
 1905;width:50pt'>
 <col class=xl24 width=84 style='mso-width-source:userset;mso-width-alt:2389;
 width:63pt'>
 <col class=xl24 width=80 style='width:60pt'>
 <col class=xl24 width=66 style='mso-width-source:userset;mso-width-alt:1877;
 width:50pt'>
 <tr height=57 style='mso-height-source:userset;height:42.75pt'>
  <td colspan=14 height=57 class=xl25 width=1169 style='height:42.75pt;
  width:878pt'>DANH SÁCH CÔNG NHÂN VIÊN ĐANG MANG THAI<br>
    <font class="font7">List of pregnant employees</font></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl26 colspan=2 style='height:15.0pt;mso-ignore:colspan'>Update:</td>
  <td class=xl27 x:num><%=DateTime.Now.ToString("dd-MM-yyyy")%></td>
  <td colspan=8 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl29></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=11 class=xl28 style='height:7.5pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl41>&nbsp;</td>
 </tr>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td rowspan=2 height=88 class=xl39 width=39 style='border-bottom:.5pt solid black;
  height:66.0pt;width:29pt'>STT<br>
    <font class="font10">No</font></td>
  <td rowspan=2 class=xl39 width=55 style='border-bottom:.5pt solid black;
  width:41pt'>MSNV<br>
    <font class="font10">ID code</font></td>
  <td rowspan=2 class=xl39 width=186 style='border-bottom:.5pt solid black;
  width:140pt'>Họ và Tên <br>
    <font class="font10">Full Name</font></td>
  <td rowspan=2 class=xl39 width=98 style='border-bottom:.5pt solid black;
  width:74pt'>Bộ phận<br>
    <font class="font10">Section</font></td>
  <td rowspan=2 class=xl39 width=105 style='border-bottom:.5pt solid black;
  width:79pt'>Thời gian bắt đầu mang thai<br>
    <font class="font10">Time start Prenancy</font></td>
  <td rowspan=2 class=xl39 width=114 style='border-bottom:.5pt solid black;
  width:86pt'>Thời gian bắt đầu làm 7 giờ/ngày<br>
    <font class="font10">Time start to work <br>
    7 hours/day</font></td>
  <td colspan=5 class=xl42 width=342 style='border-right:.5pt solid black;
  border-left:none;width:256pt'>Ngày Đi Khám Thai<br>
    <font class="font10"><span style='mso-spacerun:yes'> </span>Number of
  prenatal check for all pregnant<span style='mso-spacerun:yes'> </span></font></td>
  <td rowspan=2 class=xl39 width=84 style='border-bottom:.5pt solid black;
  border-top:none;width:63pt'>Ngày Dự Sinh<br>
    <font class="font10">Maternity<span style='mso-spacerun:yes'> </span></font></td>
  <td rowspan=2 class=xl39 width=80 style='border-bottom:.5pt solid black;
  border-top:none;width:60pt'>Ngày Nghỉ Sinh<br>
    <font class="font10">Day off<span style='mso-spacerun:yes'> </span></font></td>
  <td rowspan=2 class=xl39 width=66 style='border-bottom:.5pt solid black;
  border-top:none;width:50pt'>Ghi Chú<br>
    <font class="font10">Remark</font></td>
 </tr>
 <tr height=49 style='mso-height-source:userset;height:36.75pt'>
  <td height=49 class=xl30 width=67 style='height:36.75pt;width:50pt'>Lần
  1<br>
    <font class="font10">1st time</font></td>
  <td class=xl30 width=67 style='width:50pt'>Lần 2<br>
    <font class="font10">2nd time</font></td>
  <td class=xl30 width=74 style='width:56pt'>Lần 3<br>
    <font class="font10">3rd Time</font></td>
  <td class=xl30 width=67 style='width:50pt'>Lần 4<br>
    <font class="font10">4th Time</font></td>
  <td class=xl30 width=67 style='width:50pt'>Lần 5<br>
    <font class="font10">5th time</font></td>
 </tr>
 <% 
     string s_format;
     for (int i = 0; i < irow; i++) 
    {
        if (i == irow - 1)
            s_format = ";border-bottom:.5pt solid windowtext";
        else
            s_format = ";";
    %> 
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt' x:num><%=i+1 %></td>
  <td class=xl32><% = dt_total.Rows[i]["a0"].ToString()%></td>
  <td class=xl33><% = dt_total.Rows[i]["a1"].ToString()%></td>
  <td class=xl32><% = dt_total.Rows[i]["a2"].ToString()%></td>
  <td class=xl32><% = dt_total.Rows[i]["a3"].ToString()%></td>
  <td class=xl32><% = dt_total.Rows[i]["a4"].ToString()%></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
 </tr>
 <%} %>
 
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl35 style='height:15.0pt'>Total:</td>
  <td class=xl36 align=right x:num><%=irow %></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=14 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=25 style='height:18.75pt'>
  <td colspan=14 height=25 class=xl37 style='height:18.75pt'>Report by<span
  style='mso-spacerun:yes'>                                             
  </span>Checked by<span style='mso-spacerun:yes'>                            
  </span>Confirmed by<span style='mso-spacerun:yes'>                        
  </span>Confirmed by<span style='mso-spacerun:yes'>                        
  </span>Confirmed by<span
  style='mso-spacerun:yes'>                               </span>Approved by</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=11 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=11 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=11 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=11 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=11 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=25 style='height:18.75pt'>
  <td colspan=14 height=25 class=xl37 style='height:18.75pt'>NGUYỄN THỊ QUỲNH
  NY<span style='mso-spacerun:yes'>        </span>PHẠM NGỌC DŨNG<span
  style='mso-spacerun:yes'>                  </span>KIM KWANG JO<span
  style='mso-spacerun:yes'>                        </span>MR LIM<span
  style='mso-spacerun:yes'>                               </span>MR MOON<span
  style='mso-spacerun:yes'>                           </span>PARK SANG MAN</td>
 </tr>
 <tr class=xl25 height=25 style='height:18.75pt'>
  <td colspan=14 height=25 class=xl38 style='height:18.75pt'>ADMIN - HR
  STAFF<span style='mso-spacerun:yes'>               </span>ADMIN - HR
  SUPERVISOR<span style='mso-spacerun:yes'>     </span>FACTORY MANAGER<span
  style='mso-spacerun:yes'>      </span>OFFICE MANAGER<span
  style='mso-spacerun:yes'>           </span>GENERAL DIRECTOR<span
  style='mso-spacerun:yes'>                 </span>GENERAL DIRECTOR</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt'></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=14 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=39 style='width:29pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=186 style='width:140pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=66 style='width:50pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
