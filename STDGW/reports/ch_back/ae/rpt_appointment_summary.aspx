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
    
        string p_from_org, p_to_org,p_from_pos,p_to_pos,p_emp_status,p_search_by,p_search_temp, p_from_app, p_to_app, p_change, p_sal;
    
    p_from_org = Request.QueryString["l_from_org"].ToString();
    p_to_org = Request.QueryString["l_to_org"].ToString();
    p_from_pos = Request.QueryString["l_from_pos"].ToString();
    p_to_pos = Request.QueryString["l_to_pos"].ToString();
    p_emp_status = Request["l_emp_status"].ToString();
    p_search_by = Request["l_search_by"].ToString();
    p_search_temp = Request["l_search_temp"].ToString();
    p_from_app = Request.QueryString["l_from_app"].ToString();
    p_to_app = Request.QueryString["l_to_app"].ToString();
    p_change = Request["l_change"].ToString();
    
    p_sal   = Request["l_sal"].ToString();
    
    string SQL
    = "SELECT 0 as c0, " + 
        "             b.emp_id as c1, b.full_name as c2 " +
        "             , (select c.org_nm from tco_org c where c.del_if=0 and c.pk = a.from_org_pk) as c3 " +
        "             , (select e.FULL_NAME from thr_employee e where e.del_if=0 and e.pk = a.FROM_MANAGER_PK) as c4 " +
        "             , (select w.workgroup_nm from thr_work_group w where w.del_if=0 and w.pk = a.from_wg_pk) as c5 " +
        "             , (select code_nm from vhr_hr_code where id='HR0008' and code = a.from_pos_type) as c6 " +
        "             , round(nvl(a.OLD_SALARY,0),10) as c7 " +
        "             , (select c.org_nm from tco_org c where c.del_if=0 and c.pk = a.to_org_pk) as c8 " +
        "             , (select e.FULL_NAME from thr_employee e where e.del_if=0 and e.pk = a.TO_MANAGER_PK) as c9 " +
        "             , (select w.workgroup_nm from thr_work_group w where w.del_if=0 and w.pk = a.to_wg_pk) as c10 " +
        "             , (select code_nm from vhr_hr_code where id='HR0008' and code = a.to_pos_type) as c11 " +
        "             , round(nvl(a.NEW_SALARY,0),10) as c12 " +
        "             , to_char(to_date(a.appoint_date,'yyyymmdd'),'dd/mm/yyyy') as c13 " +
        "             , a.description as c14 " +
        "             , nvl(a.TIMES,1) as c15 " +
        "             , to_char(to_date('"+ p_from_app +"','yyyymmdd'),'dd/mm/yyyy') as c16 " +
        "             , to_char(to_date('"+ p_to_app +"','yyyymmdd'),'dd/mm/yyyy') as c17 " +
        "             , to_char(sysdate, 'dd/mm/yyyy') as c18 " +
        "             , (select code_nm from vhr_hr_code where id='HR0011' and code = a.from_edu_type) as c19 " +
        "             , (select code_nm from vhr_hr_code where id='HR0011' and code = a.to_edu_type) as c20 " +
        "        FROM thr_appointment_detail a, " +
        "             thr_employee b, " +
        "             tco_org g " +
        "       WHERE a.del_if = 0 " +
        "         AND b.del_if = 0 " +
        "         AND a.thr_employee_pk = b.pk " +
        "         AND g.del_if=0 and b.TCO_ORG_PK = g.PK " +
        "         AND DECODE ('"+ p_from_org +"', 'ALL', '"+ p_from_org +"', a.from_org_pk) = '"+ p_from_org +"' " +
        "         AND DECODE ('"+ p_to_org +"', 'ALL', '"+ p_to_org +"', a.to_org_pk) = '"+ p_to_org +"' " +
        "         AND DECODE ('" + p_from_pos + "', 'ALL', '" + p_from_pos + "', a.from_pos_type) = '" + p_from_pos + "' " +
        "         AND DECODE ('" + p_to_pos + "', 'ALL', '" + p_to_pos + "', a.to_pos_type) = '" + p_to_pos + "' " +
        "         AND DECODE ('" + p_emp_status + "', 'ALL', '" + p_emp_status + "', b.status) = '" + p_emp_status + "' " +
        "         AND UPPER (DECODE ('" + p_search_by + "',1, b.full_name,2, b.emp_id,b.id_num)) LIKE '%' || UPPER ('" + p_search_temp + "') || '%' " +
        "         AND (   '" + p_from_app + "' IS NULL " +
        "                OR '" + p_to_app + "' IS NULL " +
        "                OR a.APPOINT_DATE BETWEEN '" + p_from_app + "' AND '" + p_to_app + "' " +
        "             ) " +
        "         AND ( ('" + p_change + "' ='1' and a.from_org_pk <> a.to_org_pk) " +
        "               OR ('" + p_change + "' ='2' and a.from_pos_type <> a.to_pos_type) " +
        "               OR ('" + p_change + "' ='3' and a.from_edu_type <> a.to_edu_type) " +
        "               OR ( '" + p_change + "' = 'ALL' and 1=1 )   " +
        "             ) " +
        "         AND a.pk in (select max(e.pk) pk from thr_appointment_detail e where e.del_if=0 group by e.THR_EMPLOYEE_PK) " +
        "         ORDER BY a.appoint_date desc, a.THR_EMPLOYEE_PK  " ;

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
<link rel=File-List href="report%20appointment_summary_files/filelist.xml">
<link rel=Edit-Time-Data href="report%20appointment_summary_files/editdata.mso">
<link rel=OLE-Object-Data href="report%20appointment_summary_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-06-28T04:01:07Z</o:LastPrinted>
  <o:Created>2008-05-26T08:09:14Z</o:Created>
  <o:LastSaved>2011-06-28T04:02:18Z</o:LastSaved>
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
	margin:.28in 0in .53in 0in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
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
	font-family:Arial, sans-serif;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;}
.xl68
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl70
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl72
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl73
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
.xl74
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
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl76
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
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl77
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
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl79
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl80
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl82
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
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
      <x:Scale>58</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>90</x:Zoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>4</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
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

<body link=blue vlink=purple class=xl65>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1843 style='border-collapse:
 collapse;table-layout:fixed;width:1384pt'>
 <col class=xl65 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl65 width=144 style='mso-width-source:userset;mso-width-alt:5266;
 width:108pt'>
 <col class=xl65 width=137 style='mso-width-source:userset;mso-width-alt:5010;
 width:103pt'>
 <col class=xl65 width=131 style='mso-width-source:userset;mso-width-alt:4790;
 width:98pt'>
 <col class=xl65 width=119 style='mso-width-source:userset;mso-width-alt:4352;
 width:89pt'>
 <col class=xl65 width=126 style='mso-width-source:userset;mso-width-alt:4608;
 width:95pt'>
  <col class=xl65 width=126 style='mso-width-source:userset;mso-width-alt:4608;
 width:95pt'>
 <% if (p_sal == "Y")
    {
         %>
 <col class=xl65 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <%
     }
     else
     {
  %>
  <col class=xl65 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt;display:none'>
 <%  } %>
 <col class=xl65 width=133 span=2 style='mso-width-source:userset;mso-width-alt:
 4864;width:100pt'>
 <col class=xl65 width=119 style='mso-width-source:userset;mso-width-alt:4352;
 width:89pt'>
 <col class=xl65 width=130 style='mso-width-source:userset;mso-width-alt:4754;
 width:98pt'>
 <col class=xl65 width=130 style='mso-width-source:userset;mso-width-alt:4754;
 width:98pt'>
 <%
     if (p_sal == "Y")
     {
      %>
 <col class=xl65 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
    <%}
     else
     {  
         %>
  <col class=xl65 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt;display:none'>
 <%  } %>       
         
 <col class=xl65 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl65 width=170 style='mso-width-source:userset;mso-width-alt:6217;
 width:128pt'>
 <col class=xl65 width=52 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col class=xl65 width=64 style='width:48pt'>
 <tr height=73 style='mso-height-source:userset;height:54.75pt'>
  <td colspan=17 height=73 class=xl82 width=1779 style='height:54.75pt;
  width:1336pt'>APPOINTMENT LIST<br>
    DANH SÁCH B&#7892; NHI&#7878;M</td>
  <td class=xl65 width=64 style='width:48pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl71 style='height:15.75pt'></td>
  <td class=xl66></td>
  <td colspan=3 class=xl66 style='mso-ignore:colspan'></td>
  <td colspan=13 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl71 style='height:15.75pt'>Report Da<span
  style='display:none'>te</span></td>
  <td class=xl67><% = dt_total.Rows[0][18].ToString()%></td>
  <td colspan=3 class=xl66 style='mso-ignore:colspan'></td>
  <td colspan=13 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl66 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=13 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl66 style='height:15.75pt'></td>
  <% if((dt_total.Rows[0][16].ToString()!= "") && (dt_total.Rows[0][17].ToString()!= ""))
        {
  %>
  <td class=xl69>From Date :</td>
  <td class=xl66><% = dt_total.Rows[0][16].ToString()%></td>
  <td class=xl69>To Date :</td>
  <td class=xl66><% = dt_total.Rows[0][17].ToString()%></td>
  <%
        }
        else
        {
   %>
  <td class=xl69></td>
  <td class=xl69></td>
  <td class=xl66></td>
  <td class=xl69></td>
  <td class=xl66></td>
  <%
        }
   %>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl68></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=18 class=xl68 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=49 style='mso-height-source:userset;height:36.75pt'>
  <td height=49 class=xl76 style='height:36.75pt'>Emp ID</td>
  <td class=xl76>Full Name</td>
  <td class=xl76>From Organization</td>
  <td class=xl76>From Manager</td>
  <td class=xl76>From Work Group</td>
  <td class=xl76>From Position</td>
  <td class=xl76>From Education</td>
  <td class=xl76>Old Salary</td>
  <td class=xl76>To Organization</td>
  <td class=xl76>To Manager</td>
  <td class=xl76>To Work Group</td>
  <td class=xl76>To Position</td>
  <td class=xl76>To Education</td>
  <td class=xl76>New Salary</td>
  <td class=xl76>Apply Date</td>
  <td class=xl76>Reason</td>
  <td class=xl76>Times</td>
  <td class=xl68></td>
 </tr>
 <tr height=49 style='mso-height-source:userset;height:36.75pt'>
  <td height=49 class=xl77 style='height:36.75pt'>Mã NV</td>
  <td class=xl77>H&#7885; và tên NV</td>
  <td class=xl77>Chuy&#7875;n t&#7915; b&#7897; ph&#7853;n</td>
  <td class=xl77>Chuy&#7875;n t&#7915; qu&#7843;n lý</td>
  <td class=xl77>Chuy&#7875;n t&#7915; nhóm</td>
  <td class=xl77>Chuy&#7875;n t&#7915; ch&#7913;c v&#7909;</td>
  <td class=xl77>Chuy&#7875;n t&#7915; trình độ</td>
  <td class=xl77>M&#7913;c l&#432;&#417;ng c&#361;</td>
  <td class=xl77>Chuy&#7875;n &#273;&#7871;n b&#7897; ph&#7853;n</td>
  <td class=xl77>Chuy&#7875;n &#273;&#7871;n qu&#7843;n lý</td>
  <td class=xl77>Chuy&#7875;n &#273;&#7871;n nhóm</td>
  <td class=xl77>Chuy&#7875;n sang ch&#7913;c v&#7909;</td>
  <td class=xl77>Chuy&#7875;n sang trình độ</td>
  <td class=xl77>M&#7913;c l&#432;&#417;ng m&#7899;i</td>
  <td class=xl77>Ngày chuy&#7875;n &#273;&#7893;i</td>
  <td class=xl77>Lý do chuy&#7875;n &#273;&#7893;i</td>
  <td class=xl77>S&#7889; l&#7847;n</td>
  <td class=xl68></td>
 </tr>
  <% 
      int count=0;
     for (int i = 0; i < irow; i++) 
    {
        count++;
    %>
 <tr height=49 style='mso-height-source:userset;height:36.75pt'>
  <td height=49 class=xl78 style='height:36.75pt'><% = dt_total.Rows[i][1].ToString()%></td>
  <td class=xl81><% = dt_total.Rows[i][2].ToString()%></td>
  <td class=xl78><% = dt_total.Rows[i][3].ToString()%></td>
  <td class=xl78><% = dt_total.Rows[i][4].ToString()%></td>
  <td class=xl78><% = dt_total.Rows[i][5].ToString()%></td>
  <td class=xl78><% = dt_total.Rows[i][6].ToString()%></td>
  <td class=xl78><% = dt_total.Rows[i][19].ToString()%></td>
  <td class=xl79 x:num><span
  style='mso-spacerun:yes'> </span><% = dt_total.Rows[i][7].ToString()%> </td>
  <td class=xl78><% = dt_total.Rows[i][8].ToString()%></td>
  <td class=xl78><% = dt_total.Rows[i][9].ToString()%></td>
  <td class=xl78><% = dt_total.Rows[i][10].ToString()%></td>
  <td class=xl78><% = dt_total.Rows[i][11].ToString()%></td>
  <td class=xl78><% = dt_total.Rows[i][20].ToString()%></td>
  <td class=xl79 x:num><span
  style='mso-spacerun:yes'> </span><% = dt_total.Rows[i][12].ToString()%> </td>
  <td class=xl80><% = dt_total.Rows[i][13].ToString()%></td>
  <td class=xl81><% = dt_total.Rows[i][14].ToString()%></td>
  <td class=xl78 x:num><% = dt_total.Rows[i][15].ToString()%></td>
  <td class=xl68></td>
 </tr>
 <%} %>
 <tr height=49 style='mso-height-source:userset;height:36.75pt'>
  <td colspan=15 height=49 class=xl73 style='border-right:.5pt solid black;
  height:36.75pt'>TOTAL <%= count %> RECORD(S)</td>
  <td class=xl65></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=75 style='width:56pt'></td>
  <td width=144 style='width:108pt'></td>
  <td width=137 style='width:103pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=133 style='width:100pt'></td>
  <td width=133 style='width:100pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=130 style='width:98pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=170 style='width:128pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
