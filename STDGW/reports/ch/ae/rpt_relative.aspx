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
    string p_tco_org_pk,p_thr_wgroup_pk,p_chktemp,p_temp,p_status,p_relation,p_start_dt,p_end_dt,p_thr_emp_pk,p_start_dt_text,p_end_dt_text,p_job,p_nation,p_depend;
      p_tco_org_pk = Request["l_tco_org_pk"].ToString();
    p_thr_wgroup_pk = Request["l_wgroup_pk"].ToString();
    p_chktemp = Request["l_chktemp"].ToString();
    p_temp = Request["l_temp"].ToString();
    p_status = Request["l_status"].ToString();
    p_relation = Request["l_relation"].ToString();
    p_start_dt = Request["l_start_dt"].ToString();
    p_end_dt = Request["l_end_dt"].ToString();
    p_start_dt_text = Request["l_start_dt_text"].ToString();
    p_end_dt_text = Request["l_end_dt_text"].ToString();
    p_thr_emp_pk = Request["l_thr_emp_pk"].ToString();
    p_job = Request["p_job"].ToString();
    p_nation = Request["p_nation"].ToString();
    p_depend = Request["l_depend"].ToString();
    
    string SQL
	= "select d.org_nm,c.workgroup_nm " + 
        "   ,a.emp_id " +
        "   ,a.full_name " +
        "   ,e.full_name " +
        "   ,(select code_nm from vhr_hr_code where id='HR0024' and code=e.relation) " +
        "   ,case when length(E.BIRTH_DT)=8 then to_char(to_date(E.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy') else E.BIRTH_DT   end " +
        "   ,nvl(e.depend_yn,'N') " +
        "   ,to_char(to_date(e.start_dt,'yyyymmdd'),'dd/mm/yyyy') " +
        "   ,to_char(to_date(e.end_dt,'yyyymmdd'),'dd/mm/yyyy') " +
        "   ,e.remark " +
        "   ,E.BIRTH_PLACE " +
        "   ,E.ADDRESS " +
        "   ,E.TELEPHONE " +
        "   ,E.JOB " +
        "   from thr_employee a, thr_work_group c,thr_family e,tco_org d " +
        "   where a.del_if=0 and c.del_if=0 and e.del_if=0 and d.del_if=0 " +
        "   and a.thr_wg_pk=c.pk and a.pk=e.THR_EMPLOYEE_PK and a.tco_org_pk=d.pk " +
        "   and (a.pk='" + p_thr_emp_pk + "' or '" + p_thr_emp_pk + "' is null) " +
        "   AND (   a.tco_org_pk IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_tco_org_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_tco_org_pk + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_tco_org_pk + "' = 'ALL') " +
        "   and decode('" + p_thr_wgroup_pk + "','ALL','ALL',a.thr_wg_pk )='" + p_thr_wgroup_pk + "' " +
        "   AND (   ('" + p_chktemp+ "' = 1 AND upper(a.full_name) like '%' || upper('" + p_temp + "') || '%') " +
        "              OR ('" + p_chktemp + "' = 2 AND a.emp_id like '%' || '" + p_temp + "' || '%') " +
        "              OR ('" + p_chktemp + "' = 3 AND a.id_num like '%' || '" + p_temp + "' || '%') " +
        "              OR ('" + p_chktemp + "' = 4 AND upper(a.person_id) like '%' || upper('" + p_temp + "') || '%') " +
        "              OR '" + p_temp + "' IS NULL " +
        "             ) " +
        "   and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "' " +
        "   and decode('" + p_nation + "','ALL','ALL',a.nation)='" + p_nation + "' " +
        "   and decode('" + p_job + "','ALL','ALL',a.job_type)='" + p_job + "' " +
        "   and decode('" + p_relation + "','ALL','ALL',e.relation)='" + p_relation + "' " +
        "   and ('" + p_start_dt + "'  is null or '" + p_end_dt + "' is null " +
        "   or  ((e.start_dt is null or e.start_dt < '" + p_end_dt + "') and nvl(e.end_dt,'" + p_start_dt + "')>='" + p_start_dt + "') )  " +
        " and (('" + p_start_dt + "' is not null and '" + p_end_dt + "' is not null and nvl(e.depend_yn,'N')='Y') or '" + p_start_dt + "' is null or '" + p_end_dt + "'is null) " +
        "   and ( ('" + p_depend + "' = '1' and nvl(e.depend_yn,'N') = 'Y') or " +
        "         ('" + p_depend + "' = '2' and nvl(e.depend_yn,'N') = 'N') or " +
        "         ('" + p_depend + "' = 'ALL') " +
        "       ) " +
        "   order by c.workgroup_nm,a.emp_id " ;

    //Response.Write(SQL);
   // Response.End();
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
<link rel=File-List href="rpt_relative_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_relative_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_relative_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>banana</o:LastAuthor>
  <o:LastPrinted>2008-05-23T08:14:08Z</o:LastPrinted>
  <o:Created>2008-05-23T07:19:16Z</o:Created>
  <o:LastSaved>2009-03-26T05:31:38Z</o:LastSaved>
  <o:Company>genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.41in .11in .26in .15in;
	mso-header-margin:.24in;
	mso-footer-margin:.14in;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
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
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>5</x:PaperSizeIndex>
      <x:Scale>24</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:SplitVertical>5</x:SplitVertical>
     <x:LeftColumnRightPane>5</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
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
  <x:WindowHeight>8760</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1755</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$4:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1673 style='border-collapse:
 collapse;table-layout:fixed;width:1257pt'>
 <col class=xl24 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl24 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl24 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl24 width=191 style='mso-width-source:userset;mso-width-alt:6985;
 width:143pt'>
 <col class=xl24 width=166 style='mso-width-source:userset;mso-width-alt:6070;
 width:125pt'>
 <col class=xl24 width=90 span=2 style='mso-width-source:userset;mso-width-alt:
 3291;width:68pt'>
 
  <col class=xl24 width=124 span=4 style='mso-width-source:userset;mso-width-alt:4534;
 width:93pt'>
 
 <col class=xl24 width=124 style='mso-width-source:userset;mso-width-alt:4534;
 width:93pt'>
 <col class=xl24 width=119 style='mso-width-source:userset;mso-width-alt:4352;
 width:89pt'>
 <col class=xl24 width=106 style='mso-width-source:userset;mso-width-alt:3876;
 width:80pt'>
 <col class=xl24 width=149 style='mso-width-source:userset;mso-width-alt:5449;
 width:112pt'>
 <col class=xl24 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl24 width=115 span=3 style='mso-width-source:userset;mso-width-alt:
 4205;width:86pt'>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=15 height=38 class=xl25 width=1198 style='height:28.5pt;
  width:901pt'>EMPLOYEE'S RELATIVE</td>
  <td class=xl25 width=149 style='width:112pt'></td>
  <td class=xl32 width=96 style='width:72pt'></td>
  <td class=xl32 width=115 style='width:86pt'></td>
  <td class=xl32 width=115 style='width:86pt'></td>
 </tr>
 <tr class=xl43 height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl40 style='height:28.5pt'></td>
  <td class=xl26>From Date</td>
  <td class=xl46 ><%=p_start_dt_text %></td>
  <td class=xl26>To Date</td>
  <td class=xl46 ><%=p_end_dt_text %></td>
  <td class=xl41></td>
  <td colspan=10 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl44>&nbsp;</td>
  <td class=xl45>&nbsp;</td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl27 style='height:19.5pt'>No</td>
  <td class=xl28 style='border-top:none'>Department</td>
  <td class=xl28 style='border-top:none'>Group</td>
  <td class=xl28>Emp ID</td>
  <td class=xl28>Full Name</td>
  <td class=xl28>Name of Relative</td>
  <td class=xl28>Relative</td>
  <td class=xl28>Birth Date</td>
  
  <td class=xl28>Birth Place</td>
  <td class=xl28>Address</td>
  <td class=xl28>Telephone</td>
  <td class=xl28>Job</td>
  
  <td class=xl28>Depend Flag</td>
  <td class=xl28>Start Date</td>
  <td class=xl28>End Date</td>
  <td class=xl28>Remark</td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 
 <tr class=xl26 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl29 style='height:19.5pt'>STT</td>
  <td class=xl30>B&#7897; ph&#7853;n</td>
  <td class=xl30>Nhóm</td>
  <td class=xl30>Mã NV</td>
  <td class=xl30>H&#7885; và tên</td>
  <td class=xl30>Tên ng&#432;&#7901;i ph&#7909; thu&#7897;c</td>
  <td class=xl30>Quan h&#7879;</td>
  <td class=xl30>Ngày sinh</td>
  
  <td class=xl30>Nơi sinh</td>
  <td class=xl30>Địa chỉ</td>
  <td class=xl30>Điện thoại</td>
  <td class=xl30>Công việc</td>
  
  <td class=xl30>Y/N</td>
  <td class=xl30>B&#7855;t &#273;&#7847;u</td>
  <td class=xl30>K&#7871;t thúc</td>
  <td class=xl30>Ghi chú</td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <% 
     for (int i = 0; i < irow; i++) 
    {
        
    %> 
 <tr class=xl31 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl33 style='height:19.5pt;border-top:none' x:num><%=i+1 %></td>
  <td class=xl34 style='border-top:none'><%= dt_total.Rows[i][0].ToString() %></td>
  <td class=xl34 style='border-top:none'><%= dt_total.Rows[i][1].ToString() %></td>
  <td class=xl35 style='border-top:none'><%= dt_total.Rows[i][2].ToString() %></td>
  <td class=xl34 style='border-top:none'><%= dt_total.Rows[i][3].ToString() %></td>
  <td class=xl39 style='border-top:none'><%= dt_total.Rows[i][4].ToString() %></td>
  <td class=xl39 style='border-top:none'><%= dt_total.Rows[i][5].ToString() %></td>
  <td class=xl36 style='border-top:none'><%= dt_total.Rows[i][6].ToString() %></td>
  
  <td class=xl35 style='border-top:none'><%= dt_total.Rows[i][11].ToString() %></td>
  <td class=xl35 style='border-top:none'><%= dt_total.Rows[i][12].ToString() %></td>
  <td class=xl35 style='border-top:none'><%= dt_total.Rows[i][13].ToString() %></td>
  <td class=xl35 style='border-top:none'><%= dt_total.Rows[i][14].ToString() %></td>
  
  <td class=xl35 style='border-top:none'><%= dt_total.Rows[i][7].ToString() %></td>
  <td class=xl38 style='border-top:none' x:num><%= dt_total.Rows[i][8].ToString() %></td>
  <td class=xl38 style='border-top:none' x:num><%= dt_total.Rows[i][9].ToString() %></td>
  <td class=xl37 style='border-top:none'><%= dt_total.Rows[i][10].ToString() %></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=47 style='width:35pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=191 style='width:143pt'></td>
  <td width=166 style='width:125pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=149 style='width:112pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=115 style='width:86pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
