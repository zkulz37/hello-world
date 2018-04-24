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
        ",t.child_no a4 " +
        ",12 - round(months_between(to_date(t.end_dt,'yyyymmdd'),to_date('" + p_from_regdate +"','yyyymmdd')),1) a5 " +
        ",to_char(to_date(t.START_DT,'yyyymmdd'),'dd/mm/yyyy') a6  " +
        ",to_char(to_date(t.end_dt,'yyyymmdd')+1,'dd/mm/yyyy') a7 " +
        ",t.remark a8 " +
        " from thr_regulation t,thr_employee a,tco_org b " +
        "where t.del_if=0  and a.del_if=0 and b.del_if=0 and a.maternity_leave_dt is null " +
        "and t.thr_emp_pk=a.pk and a.tco_org_pk=b.pk " +
        "and t.end_DT >='" + p_from_regdate + "'  and t.START_DT<='" + p_to_regdate + "'  " +
        " and t.kind='02' " +
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
<link rel=File-List href="rpt_female_have_child_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_female_have_child_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_female_have_child_files/oledata.mso">
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
  <o:LastPrinted>2008-11-25T08:05:18Z</o:LastPrinted>
  <o:Created>2006-05-18T23:20:08Z</o:Created>
  <o:LastSaved>2012-07-17T03:26:04Z</o:LastSaved>
  <o:Company>Microsoft Corporation</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.19in 0in .34in .24in;
	mso-header-margin:.17in;
	mso-footer-margin:.17in;
	mso-horizontal-page-align:center;}
.font18
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
	text-align:center;
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl28
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
.xl29
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
.xl30
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
	mso-pattern:auto none;
	white-space:normal;}
.xl31
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
.xl32
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl37
	{mso-style-parent:style0;
	font-size:7.0pt;}
.xl38
	{mso-style-parent:style0;
	font-size:6.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl40
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:6.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	mso-number-format:"\#\,\#\#0\.0\;\[Red\]\#\,\#\#0\.0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:6.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
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
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl50
	{mso-style-parent:style0;
	color:black;
	font-size:7.0pt;
	font-family:VNI-Helve-Condense;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl51
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl52
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl53
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl55
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl56
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
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
       <x:ActiveRow>17</x:ActiveRow>
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
  <x:Formula>=Sheet1!$9:$10</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1115 style='border-collapse:
 collapse;table-layout:fixed;width:838pt'>
 <col width=36 style='mso-width-source:userset;mso-width-alt:1316;width:27pt'>
 <col width=58 style='mso-width-source:userset;mso-width-alt:2121;width:44pt'>
 <col width=127 style='mso-width-source:userset;mso-width-alt:4644;width:95pt'>
 <col width=119 style='mso-width-source:userset;mso-width-alt:4352;width:89pt'>
 <col width=90 style='mso-width-source:userset;mso-width-alt:3291;width:68pt'>
 <col width=49 style='mso-width-source:userset;mso-width-alt:1792;width:37pt'>
 <col width=62 style='mso-width-source:userset;mso-width-alt:2267;width:47pt'>
 <col width=85 style='mso-width-source:userset;mso-width-alt:3108;width:64pt'>
 <col width=69 style='mso-width-source:userset;mso-width-alt:2523;width:52pt'>
 <col width=164 style='mso-width-source:userset;mso-width-alt:5997;width:123pt'>
 <col width=64 span=4 style='width:48pt'>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td colspan=8 height=36 class=xl55 width=626 style='height:27.0pt;width:471pt'
  x:str=" LIST OF FEMALE WORKER HAVE CHILD      "><span
  style='mso-spacerun:yes'> </span>LIST OF FEMALE WORKER HAVE CHILD<span
  style='mso-spacerun:yes'>      </span></td>
  <td colspan=2 rowspan=3 class=xl24 width=233 style='width:175pt'><%=p_to_dt.ToString("MMM,yy") %></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=8 height=22 class=xl56 style='height:16.5pt'
  x:str="WHO PERMITED PUNCH OUT BEFORE 01 HOUR         ">WHO PERMITED PUNCH OUT
  BEFORE 01 HOUR<span style='mso-spacerun:yes'>         </span></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=8 height=22 class=xl57 style='height:16.5pt'
  x:str="(ACCORDING TO LABOUR LAW OF VN)                          ">(ACCORDING
  TO LABOUR LAW OF VN)<span
  style='mso-spacerun:yes'>                          </span></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 colspan=8 class=xl25 style='height:9.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=10 height=20 class=xl52 style='height:15.0pt'>(DANH SÁCH NỮ CÔNG
  NHÂN VIÊN CÓ CON NHỎ DƯỚI 12 THÁNG TUỔI ĐƯỢC VỀ SỚM 01 GiỜ THEO QUY ĐỊNH)</td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=3 height=17 class=xl53 style='height:12.75pt'></td>
  <td colspan=11 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl26 style='height:21.0pt'></td>
  <td colspan=2 class=xl53>Up date:&nbsp;<%=DateTime.Now.ToString("dd-MMM-yyyy")%></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl54>THÁNG&nbsp;<%=p_to_dt.ToString("MM-yyyy") %></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=3 style='mso-height-source:userset;height:2.45pt'>
  <td height=3 colspan=14 style='height:2.45pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl28 style='height:23.25pt'>NO</td>
  <td class=xl29>CODE</td>
  <td class=xl29>FULL NAME</td>
  <td class=xl29>SECTION</td>
  <td class=xl29>POSITION</td>
  <td class=xl30 width=49 style='width:37pt'>TOTAL BABY</td>
  <td class=xl29>MONTHS</td>
  <td class=xl29>BIRTHDAY</td>
  <td class=xl29>RETURN</td>
  <td class=xl31>NOTE</td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl32 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl33 style='height:21.0pt'>Stt</td>
  <td class=xl34>Msnv</td>
  <td class=xl34>Họ vænbsp; tên</td>
  <td class=xl34>Bộ phận</td>
  <td class=xl34>Chức vụ</td>
  <td class=xl34>Số con</td>
  <td class=xl35 width=62 style='width:47pt'>ThÁng tuổi</td>
  <td class=xl35 width=85 style='width:64pt'>Ngænbsp;y sinh của bé</td>
  <td class=xl35 width=69 style='width:52pt'>Ngænbsp;y lænbsp;m lại</td>
  <td class=xl36>Ghi chú</td>
  <td colspan=4 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <% 
     for (int i = 0; i < irow; i++) 
    {
       
    %> 
 <tr class=xl37 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl38 width=36 style='height:20.1pt;width:27pt' x:num><%=i+1 %></td>
  <td class=xl40 width=58 style='width:44pt'><% = dt_total.Rows[i]["a0"].ToString()%></td>
  <td class=xl41 width=127 style='width:95pt'><% = dt_total.Rows[i]["a1"].ToString()%></td>
  <td class=xl42 width=119 style='width:89pt'><% = dt_total.Rows[i]["a2"].ToString()%></td>
  <td class=xl42 width=90 style='width:68pt'><% = dt_total.Rows[i]["a3"].ToString()%></td>
  <td class=xl43 width=49 style='width:37pt' x:num><% = dt_total.Rows[i]["a4"].ToString()%></td>
  <td class=xl44 width=62 style='width:47pt' x:num><% = dt_total.Rows[i]["a5"].ToString()%></td>
  <td class=xl44 width=85 style='width:64pt'><% = dt_total.Rows[i]["a6"].ToString()%></td>
  <td class=xl43 width=69 style='width:52pt'><% = dt_total.Rows[i]["a7"].ToString()%></td>
  <td class=xl45 width=164 style='width:123pt'><% = dt_total.Rows[i]["a8"].ToString()%></td>
  <td colspan=4 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl46 align=left style='height:20.1pt'>TOTA<span
  style='display:none'>L</span></td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47 align=right x:num><%=irow %></td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=14 style='height:13.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 style='height:17.25pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
   id="_x0000_t202" coordsize="21600,21600" o:spt="202" path="m,l,21600r21600,l21600,xe">
   <v:stroke joinstyle="miter"/>
   <v:path gradientshapeok="t" o:connecttype="rect"/>
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t202" style='position:absolute;
   direction:LTR;text-align:left;margin-left:14.25pt;margin-top:4.5pt;width:126.75pt;
   height:27pt;z-index:1;mso-wrap-style:tight' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1025;mso-direction-alt:auto'/>
   <x:ClientData ObjectType="Shape">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1026" type="#_x0000_t202" style='position:absolute;
   direction:LTR;text-align:left;margin-left:162.75pt;margin-top:3.75pt;
   width:90pt;height:29.25pt;z-index:2;mso-wrap-style:tight' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1026;mso-direction-alt:auto'/>
   <x:ClientData ObjectType="Shape">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:19px;margin-top:5px;width:318px;
  height:39px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=169></td>
    <td width=29></td>
    <td width=120></td>
   </tr>
   <tr>
    <td height=1></td>
    <td colspan=2></td>
    <td rowspan=3 width=120 height=39 align=center valign=top bgcolor=white
    style='vertical-align:top;background:white'><![endif]>
    <div v:shape="_x0000_s1026" style='padding:3.6pt 7.2pt 3.6pt 7.2pt;
    text-align:center;direction:ltr' class=shape><font class="font18">CHECKED
    BY<br>
        <br>
        </font></div>
    <![if !vml]></td>
   </tr>
   <tr>
    <td height=36></td>
    <td width=169 height=36 align=center valign=top bgcolor=white
    style='vertical-align:top;background:white'><![endif]>
    <div v:shape="_x0000_s1025" style='padding:3.6pt 7.2pt 3.6pt 7.2pt;
    text-align:center;direction:ltr' class=shape><font class="font18">REPORTTED
    BY<br>
        <br>
        </font></div>
    <![if !vml]></td>
   </tr>
   <tr>
    <td height=2></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=23 class=xl27 width=36 style='height:17.25pt;width:27pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl49></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 rowspan=2 height=46 class=xl50 width=139 style='mso-ignore:
  colspan-rowspan;height:34.5pt;width:105pt'><!--[if gte vml 1]><v:shape id="_x0000_s1027"
   type="#_x0000_t202" style='position:absolute;direction:LTR;text-align:left;
   margin-left:18pt;margin-top:3.75pt;width:73.5pt;height:28.5pt;z-index:3;
   mso-wrap-style:tight' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1027;mso-direction-alt:auto'/>
   <x:ClientData ObjectType="Shape">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=24 height=5></td>
   </tr>
   <tr>
    <td></td>
    <td width=98 height=38 align=center valign=top bgcolor=white
    style='vertical-align:top;background:white'><![endif]>
    <div v:shape="_x0000_s1027" style='padding:3.6pt 7.2pt 3.6pt 7.2pt;
    text-align:center;direction:ltr' class=shape><font class="font18">CONFIRMED
    BY<br>
        <br>
        <br>
        </font></div>
    <![if !vml]></td>
    <td width=17></td>
   </tr>
   <tr>
    <td height=3></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:104.25pt;height:34.5pt'></span><![endif]--></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1030"
   type="#_x0000_t202" style='position:absolute;direction:LTR;text-align:left;
   margin-left:3.75pt;margin-top:3.75pt;width:72.75pt;height:29.25pt;z-index:6;
   mso-wrap-style:tight' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1030;mso-direction-alt:auto'/>
   <x:ClientData ObjectType="Shape">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1028" type="#_x0000_t202" style='position:absolute;
   direction:LTR;text-align:left;margin-left:88.5pt;margin-top:3.75pt;width:85.5pt;
   height:27pt;z-index:4;mso-wrap-style:tight' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1028;mso-direction-alt:auto'/>
   <x:ClientData ObjectType="Shape">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1029" type="#_x0000_t202" style='position:absolute;
   direction:LTR;text-align:left;margin-left:189pt;margin-top:5.25pt;width:84pt;
   height:29.25pt;z-index:5;mso-wrap-style:tight' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1029;mso-direction-alt:auto'/>
   <x:ClientData ObjectType="Shape">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:6;margin-left:5px;margin-top:5px;width:359px;
  height:41px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=97></td>
    <td width=16></td>
    <td width=114></td>
    <td width=20></td>
    <td width=112></td>
   </tr>
   <tr>
    <td height=2></td>
    <td rowspan=3 width=97 height=39 align=center valign=top bgcolor=white
    style='vertical-align:top;background:white'><![endif]>
    <div v:shape="_x0000_s1030" style='padding:3.6pt 7.2pt 3.6pt 7.2pt;
    text-align:center;direction:ltr' class=shape><font class="font18">CONFIRMED
    BY<br>
        <br>
        <br>
        </font></div>
    <![if !vml]></td>
    <td></td>
    <td rowspan=2 width=114 height=36 align=center valign=top bgcolor=white
    style='vertical-align:top;background:white'><![endif]>
    <div v:shape="_x0000_s1028" style='padding:3.6pt 7.2pt 3.6pt 7.2pt;
    text-align:center;direction:ltr' class=shape><font class="font18">CONFIRMED
    BY<br>
        <br>
        <br>
        </font></div>
    <![if !vml]></td>
   </tr>
   <tr>
    <td height=34></td>
    <td></td>
    <td></td>
    <td rowspan=3 width=112 height=39 align=center valign=top bgcolor=white
    style='vertical-align:top;background:white'><![endif]>
    <div v:shape="_x0000_s1029" style='padding:3.6pt 7.2pt 3.6pt 7.2pt;
    text-align:center;direction:ltr' class=shape><font class="font18">APPROVED
    BY<br>
        </font></div>
    <![if !vml]></td>
   </tr>
   <tr>
    <td height=3></td>
   </tr>
   <tr>
    <td height=2></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=23 class=xl27 width=62 style='height:17.25pt;width:47pt'></td>
   </tr>
  </table>
  </span></td>
  <td></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl27 style='height:17.25pt'></td>
  <td class=xl49></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl27 style='height:17.25pt'></td>
  <td class=xl49></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl27 style='height:17.25pt'></td>
  <td class=xl49></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl27 style='height:17.25pt'></td>
  <td class=xl49></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 style='height:17.25pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="_x0000_s1031" type="#_x0000_t202" style='position:absolute;direction:LTR;
   text-align:left;margin-left:9pt;margin-top:4.5pt;width:2in;height:30.75pt;
   z-index:7;mso-wrap-style:tight' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1031;mso-direction-alt:auto'/>
   <x:ClientData ObjectType="Shape">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1032" type="#_x0000_t202" style='position:absolute;
   direction:LTR;text-align:left;margin-left:156pt;margin-top:4.5pt;width:102.75pt;
   height:31.5pt;z-index:8;mso-wrap-style:tight' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1032;mso-direction-alt:auto'/>
   <x:ClientData ObjectType="Shape">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1033" type="#_x0000_t202" style='position:absolute;
   direction:LTR;text-align:left;margin-left:268.5pt;margin-top:3.75pt;width:87pt;
   height:27pt;z-index:9;mso-wrap-style:tight' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1033;mso-direction-alt:auto'/>
   <x:ClientData ObjectType="Shape">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:7;margin-left:12px;margin-top:5px;width:462px;
  height:43px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=192></td>
    <td width=4></td>
    <td width=137></td>
    <td width=13></td>
    <td width=116></td>
   </tr>
   <tr>
    <td height=1></td>
    <td colspan=4></td>
    <td rowspan=2 width=116 height=36 align=center valign=top bgcolor=white
    style='vertical-align:top;background:white'><![endif]>
    <div v:shape="_x0000_s1033" style='padding:3.6pt 7.2pt 3.6pt 7.2pt;
    text-align:center;direction:ltr' class=shape><font class="font18">KIM KWANG
    JO<br>
        FACTORY MANAGER<br>
        <br>
        </font></div>
    <![if !vml]></td>
   </tr>
   <tr>
    <td height=35></td>
    <td rowspan=2 width=192 height=41 align=center valign=top bgcolor=white
    style='vertical-align:top;background:white'><![endif]>
    <div v:shape="_x0000_s1031" style='padding:3.6pt 7.2pt 3.6pt 7.2pt;
    text-align:center;direction:ltr' class=shape><font class="font18">NGUYỄN
    THỊ QUỲNH NY<br>
        ADMIN-HR-STAFF<br>
        </font></div>
    <![if !vml]></td>
    <td></td>
    <td rowspan=3 width=137 height=42 align=center valign=top bgcolor=white
    style='vertical-align:top;background:white'><![endif]>
    <div v:shape="_x0000_s1032" style='padding:3.6pt 7.2pt 3.6pt 7.2pt;
    text-align:center;direction:ltr' class=shape><font class="font18">PHẠM
    NGỌC DŨNG<br>
        ADMIN-HR-MANAGER<br>
        </font></div>
    <![if !vml]></td>
   </tr>
   <tr>
    <td height=6></td>
   </tr>
   <tr>
    <td height=1></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=23 width=36 style='height:17.25pt;width:27pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1036"
   type="#_x0000_t202" style='position:absolute;direction:LTR;text-align:left;
   margin-left:8.25pt;margin-top:3pt;width:79.5pt;height:27.75pt;z-index:12;
   mso-wrap-style:tight' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1036;mso-direction-alt:auto'/>
   <x:ClientData ObjectType="Shape">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1034" type="#_x0000_t202" style='position:absolute;
   direction:LTR;text-align:left;margin-left:90.75pt;margin-top:4.5pt;width:88.5pt;
   height:28.5pt;z-index:10;mso-wrap-style:tight' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1034;mso-direction-alt:auto'/>
   <x:ClientData ObjectType="Shape">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1035" type="#_x0000_t202" style='position:absolute;
   direction:LTR;text-align:left;margin-left:189pt;margin-top:3.75pt;width:90pt;
   height:28.5pt;z-index:11;mso-wrap-style:tight' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1035;mso-direction-alt:auto'/>
   <x:ClientData ObjectType="Shape">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:12;margin-left:11px;margin-top:4px;width:361px;
  height:40px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=106></td>
    <td width=4></td>
    <td width=118></td>
    <td width=13></td>
    <td width=120></td>
   </tr>
   <tr>
    <td height=1></td>
    <td rowspan=3 width=106 height=37 align=center valign=top bgcolor=white
    style='vertical-align:top;background:white'><![endif]>
    <div v:shape="_x0000_s1036" style='padding:3.6pt 7.2pt 3.6pt 7.2pt;
    text-align:center;direction:ltr' class=shape><font class="font18">MR
    LIM<br>
        OFFICE MANAGER<br>
        <br>
        </font></div>
    <![if !vml]></td>
   </tr>
   <tr>
    <td height=1></td>
    <td colspan=3></td>
    <td rowspan=3 width=120 height=38 align=center valign=top bgcolor=white
    style='vertical-align:top;background:white'><![endif]>
    <div v:shape="_x0000_s1035" style='padding:3.6pt 7.2pt 3.6pt 7.2pt;
    text-align:center;direction:ltr' class=shape><font class="font18">PARK SANG
    MAN<br>
        GENERAL DIRECTOR<br>
        <br>
        </font></div>
    <![if !vml]></td>
   </tr>
   <tr>
    <td height=35></td>
    <td></td>
    <td rowspan=3 width=118 height=38 align=center valign=top bgcolor=white
    style='vertical-align:top;background:white'><![endif]>
    <div v:shape="_x0000_s1034" style='padding:3.6pt 7.2pt 3.6pt 7.2pt;
    text-align:center;direction:ltr' class=shape><font class="font18">MR
    MOON<br>
        GENERAL MANAGER<br>
        <br>
        </font></div>
    <![if !vml]></td>
   </tr>
   <tr>
    <td height=2></td>
   </tr>
   <tr>
    <td height=1></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=23 width=62 style='height:17.25pt;width:47pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl51 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl51></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl39 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl39></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=36 style='width:27pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=127 style='width:95pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=164 style='width:123pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
