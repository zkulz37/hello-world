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
    string p_user,p_from_join_dt,p_to_join_dt,p_thr_group_pk,p_search_by,p_search_temp,p_status,p_tco_dept_pk,p_level,p_from_disdate,p_to_disdate,p_from_disdate_text,p_to_disdate_text;
    p_user = Request["p_user"].ToString();
    p_from_join_dt = Request["p_from_join_dt"].ToString();
    p_to_join_dt = Request["p_to_join_dt"].ToString();
    p_thr_group_pk = Request["p_thr_group_pk"].ToString();
    p_search_by = Request["p_search_by"].ToString();
    p_search_temp = Request["p_search_temp"].ToString();
    p_status = Request["p_status"].ToString();
    p_tco_dept_pk = Request["p_tco_dept_pk"].ToString();
    p_level = Request["p_level"].ToString();
    p_from_disdate = Request["p_from_disdate"].ToString();
    p_to_disdate = Request["p_to_disdate"].ToString();
    p_from_disdate_text = Request["p_from_disdate_text"].ToString();
    p_to_disdate_text = Request["p_to_disdate_text"].ToString();
    string SQL;
    
    SQL = " SELECT to_char(sysdate,'dd/mm/yyyy') ";
    SQL = SQL + ",b.org_nm, c.workgroup_nm, a.emp_id, a.full_name,to_char(to_date(a.join_dt,'yyyymmdd'),'dd/mm/yyyy'), ";
    SQL = SQL + "                to_char(to_date(d.dis_dt,'yyyymmdd'),'dd/mm/yyyy') AS dis_date ";
    SQL = SQL + "                , (select code_nm from vhr_hr_code where id='HR0025' and code=d.dis_level) AS dis_level, ";
    SQL = SQL + "                d.reason AS reason, d.remark AS remark ";
    SQL = SQL + "                , d.treat_disc_v AS treat_dis, ";
    SQL = SQL + "                nvl(d.Times,'') ";  
    SQL = SQL + " ,(SELECT   MAX(t.org_id) "; 
    SQL = SQL + "                                FROM tco_org t "; 
    SQL = SQL + "                                WHERE t.del_if = 0 "; 
    SQL = SQL + "                                AND T.ORG_TYPE IN('03') "; 
    SQL = SQL + "                                START WITH t.pk=a.tco_org_pk "; 
    SQL = SQL + "                                CONNECT BY PRIOR t.p_pk=t.pk) "; 
    SQL = SQL + " ,(SELECT   MAX(t.org_id) "; 
    SQL = SQL + "                                FROM tco_org t "; 
    SQL = SQL + "                                WHERE t.del_if = 0 "; 
    SQL = SQL + "                                AND T.ORG_TYPE IN('06') "; 
    SQL = SQL + "                                START WITH t.pk=a.tco_org_pk "; 
    SQL = SQL + "                                CONNECT BY PRIOR t.p_pk=t.pk) ";     
    SQL = SQL + "           FROM thr_employee a, tco_org b, thr_work_group c, thr_discipline d  ";
    SQL = SQL + "          WHERE a.del_if = 0 ";
    SQL = SQL + "            AND b.del_if = 0 ";
    SQL = SQL + "            AND c.del_if = 0 ";
    SQL = SQL + "            AND a.tco_org_pk = b.pk ";
    SQL = SQL + "            AND a.thr_wg_pk = c.pk ";
    SQL = SQL + "            and (a.JOIN_DT between '" + p_from_join_dt  + "' and '" + p_to_join_dt  + "' or '" + p_from_join_dt + "' is null or '" + p_to_join_dt + "' is null)  ";
    SQL = SQL + "            AND DECODE ('" + p_thr_group_pk + "', ";
    SQL = SQL + "                        'ALL', '" + p_thr_group_pk + "', ";
    SQL = SQL + "                        a.thr_wg_pk ";
    SQL = SQL + "                       ) = '" + p_thr_group_pk  + "'";
    SQL = SQL + "            AND UPPER (DECODE ('" + p_search_by + "', ";
    SQL = SQL + "                              1, a.full_name, ";
    SQL = SQL + "                              2, a.emp_id, ";
    SQL = SQL + "                              3,a.id_num, ";
    SQL = SQL + "                              4,person_id, ";
    SQL = SQL + "                              old_id) ";
    SQL = SQL + "                     ) LIKE '%' || UPPER ('" + p_search_temp + "') || '%' ";
    SQL = SQL + "            AND DECODE ('" + p_status + "', 'ALL', '" + p_status + "', a.status) = '" + p_status  + "'";
    SQL = SQL + "            AND (   a.tco_org_pk IN ( ";
    SQL = SQL + "                              SELECT     g.pk ";
    SQL = SQL + "                                    FROM tco_org g ";
    SQL = SQL + "                                   WHERE g.del_if = 0 ";
    SQL = SQL + "                              START WITH g.pk = ";
    SQL = SQL + "                                            DECODE ('" + p_tco_dept_pk + "', ";
    SQL = SQL + "                                                    'ALL', 0, ";
    SQL = SQL + "                                                    '" + p_tco_dept_pk  + "'";
    SQL = SQL + "                                                   ) ";
    SQL = SQL + "                              CONNECT BY PRIOR g.pk = g.p_pk) ";
    SQL = SQL + "                        OR '" + p_tco_dept_pk + "' = 'ALL') ";
    SQL = SQL + "            AND d.del_if = 0 ";
    SQL = SQL + "            AND d.thr_emp_pk = a.pk ";
    SQL = SQL + "            AND DECODE ('" + p_level + "', 'ALL', '" + p_level + "', d.dis_level) = '" + p_level  + "'";
    SQL = SQL + "            AND (d.dis_dt BETWEEN '" + p_from_disdate + "' AND '" + p_to_disdate + "') ";
    SQL = SQL + "            order by a.emp_id, b.org_nm, c.workgroup_nm, d.Times ";

	//Response.Write(SQL);
      //  Response.End();

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
<link rel=File-List href="rpt_employee_discipline_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_employee_discipline_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_employee_discipline_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>ty-ml</o:LastAuthor>
  <o:LastPrinted>2008-07-10T04:27:58Z</o:LastPrinted>
  <o:Created>2008-05-26T08:09:14Z</o:Created>
  <o:LastSaved>2008-07-10T05:51:59Z</o:LastSaved>
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
	margin:.17in .4in .53in .32in;
	mso-header-margin:.16in;
	mso-footer-margin:.28in;}
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
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
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
      <x:Scale>66</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:LeftColumnVisible>2</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
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
  <x:WindowHeight>7935</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$7:$7</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1090 style='border-collapse:
 collapse;table-layout:fixed;width:818pt'>
 <col class=xl24 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl24 width=132 style='mso-width-source:userset;mso-width-alt:4827;
 width:99pt'>
 <col class=xl24 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl24 width=173 style='mso-width-source:userset;mso-width-alt:6326;
 width:130pt'>
 <col class=xl24 width=75 span=2 style='mso-width-source:userset;mso-width-alt:
 2742;width:56pt'>
 <col class=xl24 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl24 width=174 style='mso-width-source:userset;mso-width-alt:6363;
 width:131pt'>
 
  <col class=xl24 width=174 style='mso-width-source:userset;mso-width-alt:6363;
 width:131pt'>
 <col class=xl24 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 
 <col class=xl24 width=148 style='mso-width-source:userset;mso-width-alt:5412;
 width:111pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <tr height=34 style='height:25.5pt'>
  <td colspan=11 height=34 class=xl48 width=1026 style='height:25.5pt;
  width:770pt'>DISCIPLINE LIST</td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'>Reporter</td>
  <td class=xl29><%=p_user %></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'>Report Date</td>
  <td class=xl30 x:num><%= dt_total.Rows[0][0].ToString() %></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=12 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl31>From Date :</td>
  <td class=xl25><%=p_from_disdate_text %></td>
  <td class=xl31>To Date :</td>
  <td class=xl25><%=p_to_disdate_text %></td>
  <td class=xl25></td>
  <td colspan=5 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl32 style='height:24.0pt'>Department</td>
  <td class=xl33>Group</td>
  <td class=xl33>Emp ID</td>
  <td class=xl33>Full Name</td>
  <td class=xl33>Join Date</td>
  <td class=xl33>Date</td>
  <td class=xl33>Level</td>
  <td class=xl33>Reason</td>
  
  <td class=xl33>Treat Discipline</td>
  <td class=xl33>Times</td>
  
  <td class=xl33>Remark</td>
  <td class=xl25></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl34 style='height:24.0pt;border-top:none'>B&#7897;
  ph&#7853;n</td>
  <td class=xl35 style='border-top:none'>Nhóm</td>
  <td class=xl35 style='border-top:none'>Mã NV</td>
  <td class=xl35 style='border-top:none'>H&#7885; và tên NV</td>
  <td class=xl35 style='border-top:none'>Ngày vào</td>
  <td class=xl35 style='border-top:none'>Ngày</td>
  <td class=xl35 style='border-top:none'>M&#7913;c &#273;&#7897;</td>
  <td class=xl35 style='border-top:none'>Lý do</td>
  
  <td class=xl35 style='border-top:none'>Hình thức xử lý</td>
  <td class=xl35 style='border-top:none'>Số lần</td>
  
  <td class=xl35 style='border-top:none'>B&#7893; sung</td>
  <td class=xl25></td>
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
 <tr height=36 style='mso-height-source:userset;height:27.0pt'> 
  <td height=36 class=xl36 style='height:27.0pt;border-top:none<%=s_format%>'><%=dt_total.Rows[i][11].ToString() + "-" + dt_total.Rows[i][12].ToString() + "-" + dt_total.Rows[i][1].ToString() %></td>
  <td class=xl37 style='border-top:none<%=s_format%>'><% = dt_total.Rows[i][2].ToString()%></td>
  <td class=xl38 style='border-top:none<%=s_format%>'><% = dt_total.Rows[i][3].ToString()%></td>
  <td class=xl37 style='border-top:none<%=s_format%>'><% = dt_total.Rows[i][4].ToString()%></td>
  <td class=xl39 style='border-top:none<%=s_format%>' x:str><% = dt_total.Rows[i][5].ToString()%></td>
  <td class=xl39 style='border-top:none<%=s_format%>' x:str><% = dt_total.Rows[i][6].ToString()%></td>
  <td class=xl38 style='border-top:none<%=s_format%>'><% = dt_total.Rows[i][7].ToString()%></td>
  <td class=xl40 width=174 style='border-top:none;width:131pt<%=s_format%>'><% = dt_total.Rows[i][8].ToString()%></td>
  
  <td class=xl40 width=174 style='border-top:none;width:131pt<%=s_format%>'><% = dt_total.Rows[i][10].ToString()%></td>
  <td class=xl38 style='border-top:none<%=s_format%>'><% = dt_total.Rows[i][11].ToString()%></td>
  
  <td class=xl41 width=148 style='border-top:none;width:111pt<%=s_format%>'><% = dt_total.Rows[i][9].ToString()%></td>
  <td class=xl25></td>
 </tr>
 <%
    }
  %>
 
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=11 height=31 class=xl49 style='border-right:.5pt solid black;
  height:23.25pt'>TOTAL <%=irow %> CASE(S)</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=96 style='width:72pt'></td>
  <td width=132 style='width:99pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=173 style='width:130pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=174 style='width:131pt'></td>
  <td width=148 style='width:111pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
