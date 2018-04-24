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
    DateTime p_to_dt=new DateTime(int.Parse(p_to_regdate.Substring(0,4).ToString()),int.Parse(p_to_regdate.Substring(4,2).ToString()),int.Parse(p_to_regdate.Substring(6,2).ToString())) ;
    
    string SQL
        = "select a.emp_id a0 " + 
        ",a.full_name a1 " +
        ",b.org_nm a2 " +
        ",(select v.code_nm from vhr_hr_code v where  v.id='HR0008' and v.code=a.pos_type) a3 " +
        ",round(months_between(to_date('" + p_from_regdate + "','yyyymmdd'),to_date(t.pregnancy_dt,'yyyymmdd')),2) a4 " +
        ",t.healthy_status a5 " +
        ",to_char(to_date(t.START_DT,'yyyymmdd'),'dd/mm/yyyy') a6 " +
        ",t.remark a7 " +
        " from thr_regulation t,thr_employee a,tco_org b " +
        "where t.del_if=0  and a.del_if=0 and b.del_if=0 " +
        "and t.thr_emp_pk=a.pk and a.tco_org_pk=b.pk and a.maternity_leave_dt is null " +
        "and t.end_DT >='" + p_from_regdate + "'  and t.START_DT<='" + p_to_regdate + "'  " +
        " and nvl(t.MISCARRIAGE_DT,t.END_DT)>='" + p_from_regdate + "' " +
        " and t.kind='01' " +
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
        " order by b.org_nm,a.emp_id " ;

    
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
<link rel=File-List href="rpt_pregnant_female_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_pregnant_female_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_pregnant_female_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Huy</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2012-07-17T02:27:05Z</o:LastPrinted>
  <o:Created>2006-05-18T23:20:08Z</o:Created>
  <o:LastSaved>2012-07-17T02:27:32Z</o:LastSaved>
  <o:Company>Microsoft Corporation</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.27in 0in .34in .24in;
	mso-header-margin:.26in;
	mso-footer-margin:.17in;
	mso-horizontal-page-align:center;}
.font19
	{color:black;
	font-size:7.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Helve-Condense;
	mso-generic-font-family:auto;
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
	color:#3366FF;
	font-size:30.0pt;
	font-weight:700;
	font-family:"\.VnBodoni", sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl30
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl31
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	font-size:7.0pt;}
.xl40
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:6.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"\#\,\#\#0\.0\;\[Red\]\#\,\#\#0\.0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"\#\,\#\#0\.0\;\[Red\]\#\,\#\#0\.0";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl47
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl49
	{mso-style-parent:style0;
	color:black;
	font-size:7.0pt;
	font-family:VNI-Helve-Condense;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl50
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl51
	{mso-style-parent:style0;
	color:black;
	font-size:7.0pt;
	font-family:VNI-Helve-Condense;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl52
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl54
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style0;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style0;
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
      <x:Scale>86</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>100</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>9</x:ActiveRow>
       <x:ActiveCol>11</x:ActiveCol>
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
  <x:WindowHeight>9225</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$8:$9</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1215 style='border-collapse:
 collapse;table-layout:fixed;width:912pt'>
 <col width=37 style='mso-width-source:userset;mso-width-alt:1353;width:28pt'>
 <col width=46 style='mso-width-source:userset;mso-width-alt:1682;width:35pt'>
 <col width=129 style='mso-width-source:userset;mso-width-alt:4717;width:97pt'>
 <col width=103 style='mso-width-source:userset;mso-width-alt:3766;width:77pt'>
 <col width=92 style='mso-width-source:userset;mso-width-alt:3364;width:69pt'>
 <col width=75 style='mso-width-source:userset;mso-width-alt:2742;width:56pt'>
 <col width=84 style='mso-width-source:userset;mso-width-alt:3072;width:63pt'>
 <col width=78 style='mso-width-source:userset;mso-width-alt:2852;width:59pt'>
 <col width=123 style='mso-width-source:userset;mso-width-alt:4498;width:92pt'>
 <col width=64 span=7 style='width:48pt'>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td colspan=9 height=34 class=xl52 width=767 style='height:25.5pt;width:576pt'>PREGNANT
  FEMALE LIST WHO PERMITED PUNCH OUT BEFORE 01 HOUR</td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=7 height=28 class=xl53 style='height:21.0pt'>(ACCORDING TO LABOUR
  LAW OF VN)</td>
  <td colspan=2 rowspan=3 class=xl24><%=p_to_dt.ToString("MMM,yy") %></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td colspan=7 height=15 class=xl25 style='height:11.25pt'></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=7 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=9 height=21 class=xl26 style='height:15.75pt'>(DANH SÁCH NỮ CÔNG
  NHÂN VIÊN CÓ THAI ĐƯỢC VỀ SỚM 01 GiỜ THEO QUY ĐỊNH)</td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl27 style='height:21.0pt'></td>
  <td colspan=2 class=xl28>Up date:<%=DateTime.Now.ToString("dd-MMM-yyyy")%></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29>THÁNG&nbsp;<%=p_to_dt.ToString("MM-yyyy") %></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=3 style='mso-height-source:userset;height:2.45pt'>
  <td height=3 colspan=16 style='height:2.45pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl31 style='height:20.1pt'>NO</td>
  <td class=xl32>CODE</td>
  <td class=xl32>FULL NAME</td>
  <td class=xl32>SECTION</td>
  <td class=xl32>POSITION</td>
  <td class=xl32>MONTHS</td>
  <td class=xl32>HEALTHY STATUS</td>
  <td class=xl32>START</td>
  <td class=xl33>NOTE</td>
  <td colspan=7 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl34 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl35 style='height:17.25pt'>Stt</td>
  <td class=xl36>Msnv</td>
  <td class=xl36>Họ và tên</td>
  <td class=xl36>Bộ phận</td>
  <td class=xl36>Chức vụ</td>
  <td class=xl37 width=75 style='width:56pt'>Thai tuổi</td>
  <td class=xl36>Tình trạng sức khỏe</td>
  <td class=xl36>Ngày bắt đầu</td>
  <td class=xl38>Ghi chú</td>
  <td colspan=7 class=xl34 style='mso-ignore:colspan'></td>
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
 <tr class=xl39 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl40 style='height:20.1pt'><%=i+1 %></td>
  <td class=xl42><% = dt_total.Rows[i]["a0"].ToString()%></td>
  <td class=xl42><% = dt_total.Rows[i]["a1"].ToString()%></td>
  <td class=xl54><% = dt_total.Rows[i]["a2"].ToString()%></td>
  <td class=xl54><% = dt_total.Rows[i]["a3"].ToString()%></td>
  <td class=xl43 x:num><% = dt_total.Rows[i]["a4"].ToString()%></td>
  <td class=xl44><% = dt_total.Rows[i]["a5"].ToString()%></td>
  <td class=xl45><% = dt_total.Rows[i]["a6"].ToString()%></td>
  <td class=xl55><% = dt_total.Rows[i]["a7"].ToString()%></td>
  <td colspan=7 class=xl39 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl46 align=left style='height:20.1pt'>TOTA<span
  style='display:none'>L</span></td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47 align=left><%=irow %></td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=8 style='height:13.5pt;mso-ignore:colspan'></td>
  <td class=xl57></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 style='height:17.25pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
   id="_x0000_t202" coordsize="21600,21600" o:spt="202" path="m,l,21600r21600,l21600,xe">
   <v:stroke joinstyle="miter"/>
   <v:path gradientshapeok="t" o:connecttype="rect"/>
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t202" style='position:absolute;
   direction:LTR;text-align:left;margin-left:14.25pt;margin-top:4.5pt;width:81.75pt;
   height:27pt;z-index:1;mso-wrap-style:tight' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1025;mso-direction-alt:auto'/>
   <x:ClientData ObjectType="Shape">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1026" type="#_x0000_t202" style='position:absolute;
   direction:LTR;text-align:left;margin-left:124.5pt;margin-top:3.75pt;width:60.75pt;
   height:29.25pt;z-index:2;mso-wrap-style:tight' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1026;mso-direction-alt:auto'/>
   <x:ClientData ObjectType="Shape">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1027" type="#_x0000_t202" style='position:absolute;
   direction:LTR;text-align:left;margin-left:205.5pt;margin-top:3.75pt;width:1in;
   height:28.5pt;z-index:3;mso-wrap-style:tight' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1027;mso-direction-alt:auto'/>
   <x:ClientData ObjectType="Shape">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1030" type="#_x0000_t202" style='position:absolute;
   direction:LTR;text-align:left;margin-left:292.5pt;margin-top:3.75pt;width:74.25pt;
   height:29.25pt;z-index:6;mso-wrap-style:tight' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1030;mso-direction-alt:auto'/>
   <x:ClientData ObjectType="Shape">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1028" type="#_x0000_t202" style='position:absolute;
   direction:LTR;text-align:left;margin-left:398.25pt;margin-top:3.75pt;
   width:74.25pt;height:27pt;z-index:4;mso-wrap-style:tight' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1028;mso-direction-alt:auto'/>
   <x:ClientData ObjectType="Shape">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:19px;margin-top:5px;width:611px;
  height:39px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=109></td>
    <td width=38></td>
    <td width=81></td>
    <td width=27></td>
    <td width=96></td>
    <td width=20></td>
    <td width=99></td>
    <td width=42></td>
    <td width=99></td>
   </tr>
   <tr>
    <td height=1></td>
    <td colspan=2></td>
    <td rowspan=5 width=81 height=39 align=center valign=top bgcolor=white
    style='vertical-align:top;background:white'><![endif]>
    <div v:shape="_x0000_s1026" style='padding:3.6pt 7.2pt 3.6pt 7.2pt;
    text-align:center;direction:ltr' class=shape><font class="font19">CHECKED
    BY<br>
        <br>
        </font></div>
    <![if !vml]></td>
    <td></td>
    <td rowspan=4 width=96 height=38 align=center valign=top bgcolor=white
    style='vertical-align:top;background:white'><![endif]>
    <div v:shape="_x0000_s1027" style='padding:3.6pt 7.2pt 3.6pt 7.2pt;
    text-align:center;direction:ltr' class=shape><font class="font19">CONFIRMED
    BY<br>
        <br>
        <br>
        </font></div>
    <![if !vml]></td>
    <td></td>
    <td rowspan=5 width=99 height=39 align=center valign=top bgcolor=white
    style='vertical-align:top;background:white'><![endif]>
    <div v:shape="_x0000_s1030" style='padding:3.6pt 7.2pt 3.6pt 7.2pt;
    text-align:center;direction:ltr' class=shape><font class="font19">CONFIRMED
    BY<br>
        <br>
        <br>
        </font></div>
    <![if !vml]></td>
    <td></td>
    <td rowspan=2 width=99 height=36 align=center valign=top bgcolor=white
    style='vertical-align:top;background:white'><![endif]>
    <div v:shape="_x0000_s1028" style='padding:3.6pt 7.2pt 3.6pt 7.2pt;
    text-align:center;direction:ltr' class=shape><font class="font19">CONFIRMED
    BY<br>
        <br>
        <br>
        </font></div>
    <![if !vml]></td>
   </tr>
   <tr>
    <td height=35></td>
    <td rowspan=2 width=109 height=36 align=center valign=top bgcolor=white
    style='vertical-align:top;background:white'><![endif]>
    <div v:shape="_x0000_s1025" style='padding:3.6pt 7.2pt 3.6pt 7.2pt;
    text-align:center;direction:ltr' class=shape><font class="font19">REPORTTED
    BY<br>
        <br>
        </font></div>
    <![if !vml]></td>
   </tr>
   <tr>
    <td height=1></td>
   </tr>
   <tr>
    <td height=1></td>
   </tr>
   <tr>
    <td height=1></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=23 class=xl24 width=37 style='height:17.25pt;width:28pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl26></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td class=xl48></td>
  <td class=xl24></td>
  <td class=xl48></td>
  <td rowspan=2 height=46 class=xl49 width=123 style='mso-ignore:colspan-rowspan;
  height:34.5pt;width:92pt'><!--[if gte vml 1]><v:shape id="_x0000_s1029"
   type="#_x0000_t202" style='position:absolute;direction:LTR;text-align:left;
   margin-left:7.5pt;margin-top:5.25pt;width:78pt;height:29.25pt;z-index:5;
   mso-wrap-style:tight' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1029;mso-direction-alt:auto'/>
   <x:ClientData ObjectType="Shape">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=10 height=7></td>
   </tr>
   <tr>
    <td></td>
    <td width=104 height=39 align=center valign=top bgcolor=white
    style='vertical-align:top;background:white'><![endif]>
    <div v:shape="_x0000_s1029" style='padding:3.6pt 7.2pt 3.6pt 7.2pt;
    text-align:center;direction:ltr' class=shape><font class="font19">APPROVED
    BY<br>
        </font></div>
    <![if !vml]></td>
    <td width=9></td>
   </tr>
   <tr>
    <td height=0></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:92.25pt;height:34.5pt'></span><![endif]--></td>
  <td class=xl24></td>
  <td class=xl50></td>
  <td></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl24 style='height:17.25pt'></td>
  <td class=xl26></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td class=xl48></td>
  <td class=xl24></td>
  <td class=xl48></td>
  <td class=xl24></td>
  <td class=xl50></td>
  <td></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl24 style='height:17.25pt'></td>
  <td class=xl26></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td class=xl48></td>
  <td class=xl24></td>
  <td class=xl48></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl50></td>
  <td></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl24 style='height:17.25pt'></td>
  <td class=xl26></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td class=xl48></td>
  <td class=xl24></td>
  <td class=xl48></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl50></td>
  <td></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl24 style='height:17.25pt'></td>
  <td class=xl26></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td class=xl48></td>
  <td class=xl24></td>
  <td class=xl48></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl50></td>
  <td></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 style='height:17.25pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="_x0000_s1031" type="#_x0000_t202" style='position:absolute;direction:LTR;
   text-align:left;margin-left:9pt;margin-top:4.5pt;width:99pt;height:30.75pt;
   z-index:7;mso-wrap-style:tight' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1031;mso-direction-alt:auto'/>
   <x:ClientData ObjectType="Shape">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1032" type="#_x0000_t202" style='position:absolute;
   direction:LTR;text-align:left;margin-left:111pt;margin-top:4.5pt;width:92.25pt;
   height:31.5pt;z-index:8;mso-wrap-style:tight' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1032;mso-direction-alt:auto'>
    <div style='text-align:center;direction:ltr'><font class="font19">PHẠM
    NGỌC DŨNG<br>
        ADMIN-HR-MANAGER<br>
        </font></div>
   </v:textbox>
   <x:ClientData ObjectType="Shape">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1033" type="#_x0000_t202" style='position:absolute;
   direction:LTR;text-align:left;margin-left:201pt;margin-top:3.75pt;width:75pt;
   height:27pt;z-index:9;mso-wrap-style:tight' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1033;mso-direction-alt:auto'>
    <div style='text-align:center;direction:ltr'><font class="font19">KIM KWANG
    JO<br>
        FACTORY MANAGER<br>
        <br>
        </font></div>
   </v:textbox>
   <x:ClientData ObjectType="Shape">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1036" type="#_x0000_t202" style='position:absolute;
   direction:LTR;text-align:left;margin-left:278.25pt;margin-top:3pt;width:100.5pt;
   height:27.75pt;z-index:12;mso-wrap-style:tight' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1036;mso-direction-alt:auto'/>
   <x:ClientData ObjectType="Shape">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1034" type="#_x0000_t202" style='position:absolute;
   direction:LTR;text-align:left;margin-left:393.75pt;margin-top:4.5pt;width:87.75pt;
   height:28.5pt;z-index:10;mso-wrap-style:tight' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1034;mso-direction-alt:auto'/>
   <x:ClientData ObjectType="Shape">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:7;margin-left:12px;margin-top:4px;width:630px;
  height:44px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=132></td>
    <td width=4></td>
    <td width=220></td>
    <td width=3></td>
    <td width=134></td>
    <td width=20></td>
    <td width=117></td>
   </tr>
   <tr>
    <td height=1></td>
    <td colspan=4></td>
    <td rowspan=3 width=134 height=37 align=center valign=top bgcolor=white
    style='vertical-align:top;background:white'><![endif]>
    <div v:shape="_x0000_s1036" style='padding:3.6pt 7.2pt 3.6pt 7.2pt;
    text-align:center;direction:ltr' class=shape><font class="font19">MR
    LIM<br>
        OFFICE MANAGER<br>
        <br>
        </font></div>
    <![if !vml]></td>
   </tr>
   <tr>
    <td height=1></td>
    <td colspan=2></td>
    <td rowspan=5 align=left valign=top><img width=220 height=43
    src="rpt_pregnant_female_files/image001.gif" v:shapes="_x0000_s1032 _x0000_s1033"></td>
   </tr>
   <tr>
    <td height=35></td>
    <td rowspan=3 width=132 height=41 align=center valign=top bgcolor=white
    style='vertical-align:top;background:white'><![endif]>
    <div v:shape="_x0000_s1031" style='padding:3.6pt 7.2pt 3.6pt 7.2pt;
    text-align:center;direction:ltr' class=shape><font class="font19">NGUYỄN
    THỊ QUỲNH NY<br>
        ADMIN-HR-STAFF<br>
        </font></div>
    <![if !vml]></td>
    <td></td>
    <td></td>
    <td></td>
    <td rowspan=2 width=117 height=38 align=center valign=top bgcolor=white
    style='vertical-align:top;background:white'><![endif]>
    <div v:shape="_x0000_s1034" style='padding:3.6pt 7.2pt 3.6pt 7.2pt;
    text-align:center;direction:ltr' class=shape><font class="font19">MR
    MOON<br>
        GENERAL MANAGER<br>
        <br>
        </font></div>
    <![if !vml]></td>
   </tr>
   <tr>
    <td height=3></td>
   </tr>
   <tr>
    <td height=3></td>
   </tr>
   <tr>
    <td height=1></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=23 width=37 style='height:17.25pt;width:28pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
  <td rowspan=2 height=56 class=xl51 width=123 style='mso-ignore:colspan-rowspan;
  height:42.2pt;width:92pt'><!--[if gte vml 1]><v:shape id="_x0000_s1035"
   type="#_x0000_t202" style='position:absolute;direction:LTR;text-align:left;
   margin-left:3pt;margin-top:3.75pt;width:89.25pt;height:28.5pt;z-index:11;
   mso-wrap-style:tight' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1035;mso-direction-alt:auto'/>
   <x:ClientData ObjectType="Shape">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=4 height=5></td>
   </tr>
   <tr>
    <td></td>
    <td width=119 height=38 align=center valign=top bgcolor=white
    style='vertical-align:top;background:white'><![endif]>
    <div v:shape="_x0000_s1035" style='padding:3.6pt 7.2pt 3.6pt 7.2pt;
    text-align:center;direction:ltr' class=shape><font class="font19">PARK SANG
    MAN<br>
        GENERAL DIRECTOR<br>
        <br>
        </font></div>
    <![if !vml]></td>
    <td width=0></td>
   </tr>
   <tr>
    <td height=13></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:92.25pt;height:42.0pt'></span><![endif]--></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 colspan=8 style='height:24.95pt;mso-ignore:colspan'></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=37 style='width:28pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=129 style='width:97pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
