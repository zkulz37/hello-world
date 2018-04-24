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
    string p_tco_org_pk,p_thr_group_pk,p_chktemp,p_temp,p_probation_type,p_from_begin_probation,p_status;
    string p_to_begin_probation,p_from_end_probation,p_to_end_probation,p_contract_type,p_from_begin_contract,p_from_end_contract,p_to_end_contract,p_to_begin_contract;
     
    
    p_tco_org_pk  = Request["p_tco_dept_pk"].ToString();
    p_thr_group_pk = Request["p_thr_group_pk"].ToString();
    p_chktemp      = Request["p_chktemp"].ToString();
    p_temp         = Request["p_temp"].ToString();
    p_probation_type    = Request["p_probation_type"].ToString();
    p_from_begin_probation  = Request["p_from_begin_probation"].ToString();
    p_to_begin_probation    = Request["p_to_begin_probation"].ToString();
    p_from_end_probation    = Request["p_from_end_probation"].ToString();
    p_to_end_probation      = Request["p_to_end_probation"].ToString();
    p_contract_type         = Request["p_contract_type"].ToString();
    p_from_begin_contract   = Request["p_from_begin_contract"].ToString();
    p_to_begin_contract     = Request["p_to_begin_contract"].ToString();
    p_from_end_contract     = Request["p_from_end_contract"].ToString();
    p_to_end_contract       = Request["p_to_end_contract"].ToString();
    p_status = Request["p_status"].ToString();
    
    string SQL;
    SQL = " select to_char(sysdate,'dd/mm/yyyy'),d.org_nm ";
    SQL = SQL + "   ,c.workgroup_nm ";
    SQL = SQL + "   ,a.emp_id ";
    SQL = SQL + "   ,a.full_name ";
    SQL = SQL + "   ,to_char(to_date(a.join_dt,'yyyymmdd'),'dd/mm/yyyy') ";
    SQL = SQL + "   ,(select code_nm from vhr_hr_code where id='HR0001' and code=b.contract_type) ";
    SQL = SQL + "   ,b.contract_no ";
    SQL = SQL + "   ,b.contract_times ";
    SQL = SQL + "   ,to_char(to_date(b.begin_probation,'yyyymmdd'),'dd/mm/yyyy') ";
    SQL = SQL + "   ,to_char(to_date(b.end_probation,'yyyymmdd'),'dd/mm/yyyy') ";
    SQL = SQL + "   ,to_char(to_date(b.begin_contract,'yyyymmdd'),'dd/mm/yyyy') ";
    SQL = SQL + "   ,to_char(to_date(b.end_contract,'yyyymmdd'),'dd/mm/yyyy') ";
    SQL = SQL + "   ,decode(nvl(b.begin_contract,0),0,b.PRO_SAL,b.BASIC_SAL) ";
    SQL = SQL + "   from thr_employee a, thr_labour_contract b, thr_work_group c, tco_org d ";
    SQL = SQL + "   where a.del_if=0 and b.del_if=0 and c.del_if=0 and d.del_if=0  ";
    SQL = SQL + "   and a.contracT_times=b.contract_times ";
    SQL = SQL + "   and a.pk=b.THR_EMPLOYEE_PK ";
    SQL = SQL + "   and a.thr_wg_pk=c.pk ";
    SQL = SQL + "   and a.tco_org_pk=d.pk ";
    SQL = SQL + "   AND (  a.tco_org_pk IN ( ";
    SQL = SQL + "                              SELECT     g.pk ";
    SQL = SQL + "                                    FROM tco_org g ";
    SQL = SQL + "                                   WHERE g.del_if = 0 ";
    SQL = SQL + "                              START WITH g.pk = ";
    SQL = SQL + "                                            DECODE ('" + p_tco_org_pk + "', ";
    SQL = SQL + "                                                    'ALL', 0, ";
    SQL = SQL + "                                                    '" + p_tco_org_pk  + "'";
    SQL = SQL + "                                                   ) ";
    SQL = SQL + "                              CONNECT BY PRIOR g.pk = g.p_pk) ";
    SQL = SQL + "                        OR '" + p_tco_org_pk  + "'= 'ALL') ";
    SQL = SQL + "   and decode('" + p_contract_type + "','ALL','ALL',a.CONTRACT_TYPE )='" + p_contract_type + "' ";
    SQL = SQL + "   and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "' ";
    SQL = SQL + "   and decode('" + p_thr_group_pk + "','ALL','ALL',a.thr_wg_pk )='" + p_thr_group_pk  + "'";
    SQL = SQL + "   and decode('" + p_probation_type + "','ALL','ALL',a.prob_type )='" + p_probation_type + "' ";
    SQL = SQL + "   and (('" + p_from_begin_probation + "' is null and '" + p_to_begin_probation + "' is null)  ";
    SQL = SQL + "   or (a.BEGIN_probation between '" + p_from_begin_probation + "' and '" + p_to_begin_probation + "') )  ";
    SQL = SQL + "   and (('" + p_from_begin_contract + "' is null and '" + p_to_begin_contract + "' is null)  ";
    SQL = SQL + "   or (b.BEGIN_CONTRACT between '" + p_from_begin_contract + "' and '" + p_to_begin_contract + "') )  ";
    SQL = SQL + "   and (('" + p_from_end_contract + "' is null and '" + p_to_end_contract + "' is null)  ";
    SQL = SQL + "   or (b.end_CONTRACT between '" + p_from_end_contract + "' and '" + p_to_end_contract + "') )  ";
    SQL = SQL + "    and (('" + p_from_end_probation + "' is null and '" + p_to_end_probation + "' is null)  ";
    SQL = SQL + "   or (a.end_probation between '" + p_from_end_probation + "' and '" + p_to_end_probation + "') )  ";
    SQL = SQL + "                   AND (   DECODE ('" + p_chktemp + "', ";
    SQL = SQL + "                                   '2', UPPER (a.emp_id), ";
    SQL = SQL + "                                   '3', a.id_num, ";
    SQL = SQL + "                                   '4', a.contract_no, ";
    SQL = SQL + "                                   '1', UPPER (a.full_name) ";
    SQL = SQL + "                                  ) LIKE '%' || UPPER ('" + p_temp + "') ";
    SQL = SQL + "                        OR '" + p_temp + "' IS NULL ";
    SQL = SQL + "                       ) ";
    SQL = SQL + "   order by nvl(d.seq,0),a.emp_id ";


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
<link rel=File-List href="rpt_list_lb_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_list_lb_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_list_lb_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>EINSVINA</o:Author>
  <o:LastAuthor>ty-ml</o:LastAuthor>
  <o:LastPrinted>2008-07-15T01:42:15Z</o:LastPrinted>
  <o:Created>2006-12-21T09:46:33Z</o:Created>
  <o:LastSaved>2008-07-15T01:44:59Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.28in .33in .33in .4in;
	mso-header-margin:.27in;
	mso-footer-margin:.31in;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style16
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:Comma;
	mso-style-id:3;}
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
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl36
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
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
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:13.0pt;
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
	mso-pattern:auto none;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:13.0pt;
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
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:13.0pt;
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
	mso-pattern:auto none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:13.0pt;
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
	mso-pattern:auto none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl47
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>46</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:LeftColumnVisible>5</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>2</x:ActiveRow>
       <x:ActiveCol>8</x:ActiveCol>
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
  <x:WindowHeight>5475</x:WindowHeight>
  <x:WindowWidth>10770</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$2</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1472 style='border-collapse:
 collapse;table-layout:fixed;width:1107pt'>
 <col class=xl24 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl24 width=130 span=2 style='mso-width-source:userset;mso-width-alt:
 4754;width:98pt'>
 <col class=xl24 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl24 width=194 style='mso-width-source:userset;mso-width-alt:7094;
 width:146pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=124 span=2 style='mso-width-source:userset;mso-width-alt:
 4534;width:93pt'>
 <col class=xl24 width=64 style='mso-width-source:userset;mso-width-alt:2340;
 width:48pt'>
 <col class=xl24 width=108 style='mso-width-source:userset;mso-width-alt:3949;
 width:81pt'>
 <col class=xl24 width=109 style='mso-width-source:userset;mso-width-alt:3986;
 width:82pt'>
 <col class=xl24 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl24 width=99 style='mso-width-source:userset;mso-width-alt:3620;
 width:74pt'>
 <col class=xl24 width=98 style='mso-width-source:userset;mso-width-alt:3584;
 width:74pt'>
 <tr height=61 style='mso-height-source:userset;height:45.75pt'>
  <td colspan=14 height=61 class=xl47 width=1472 style='height:45.75pt;
  width:1107pt' x:str="LIST OF LABOUR CONTRACT ">LIST OF LABOUR CONTRACT<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl25 height=44 style='mso-height-source:userset;height:33.0pt'>
  <td height=44 class=xl41 width=38 style='height:33.0pt;border-top:none;
  width:29pt'>No.</td>
  <td class=xl42 width=130 style='border-top:none;width:98pt'>Department</td>
  <td class=xl42 width=130 style='border-top:none;width:98pt'>Group</td>
  <td class=xl42 width=67 style='border-top:none;width:50pt'>Emp ID</td>
  <td class=xl42 width=194 style='border-top:none;width:146pt'>Full Name</td>
  <td class=xl42 width=93 style='border-top:none;width:70pt'>Join date</td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'>Contract kind</td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'>Contract Number</td>
  <td class=xl42 width=64 style='border-top:none;width:48pt'>Times</td>
  <td class=xl42 width=108 style='border-top:none;width:81pt'>Start probation</td>
  <td class=xl42 width=109 style='border-top:none;width:82pt'>End probation</td>
  <td class=xl42 width=94 style='border-top:none;width:71pt'>Start contract</td>
  <td class=xl42 width=99 style='border-top:none;width:74pt'>End contract</td>
  <td class=xl42 width=98 style='border-top:none;width:74pt'>Basic salary</td>
 </tr>
 <tr class=xl25 height=44 style='mso-height-source:userset;height:33.0pt'>
  <td height=44 class=xl43 width=38 style='height:33.0pt;border-top:none;
  width:29pt'>Stt</td>
  <td class=xl44 width=130 style='border-top:none;width:98pt'>B&#7897;
  ph&#7853;n</td>
  <td class=xl44 width=130 style='border-top:none;width:98pt'>Nhóm</td>
  <td class=xl44 width=67 style='border-top:none;width:50pt'>Mã s&#7889;</td>
  <td class=xl44 width=194 style='border-top:none;width:146pt'>H&#7885; tên</td>
  <td class=xl44 width=93 style='border-top:none;width:70pt'>Ngày vào</td>
  <td class=xl44 width=124 style='border-top:none;width:93pt'>Lo&#7841;i
  h&#7907;p &#273;&#7891;ng</td>
  <td class=xl44 width=124 style='border-top:none;width:93pt'>S&#7889;
  h&#7907;p &#273;&#7891;ng</td>
  <td class=xl44 width=64 style='border-top:none;width:48pt'>L&#7847;n
  th&#7913;</td>
  <td class=xl44 width=108 style='border-top:none;width:81pt'>Ngày b&#7855;t
  &#273;&#7847;u th&#7917; vi&#7879;c</td>
  <td class=xl44 width=109 style='border-top:none;width:82pt'>Ngày k&#7871;t
  thúc th&#7917; vi&#7879;c</td>
  <td class=xl44 width=94 style='border-top:none;width:71pt'>Ngày b&#7855;t
  &#273;&#7847;u h&#7907;p &#273;&#7891;ng</td>
  <td class=xl44 width=99 style='border-top:none;width:74pt'>Ngày k&#7871;t
  thúc h&#7907;p &#273;&#7891;ng</td>
  <td class=xl44 width=98 style='border-top:none;width:74pt'>L&#432;&#417;ng</td>
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
 <tr class=xl26 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl27 style='height:27.0pt;border-top:none<%=s_format%>' x:num><%=i+1 %></td>
  <td class=xl28 style='border-top:none<%=s_format%>'><% = dt_total.Rows[i][1].ToString()%></td>
  <td class=xl28 style='border-top:none<%=s_format%>'><% = dt_total.Rows[i][2].ToString()%></td>
  <td class=xl29 style='border-top:none<%=s_format%>'><% = dt_total.Rows[i][3].ToString()%></td>
  <td class=xl30 style='border-top:none<%=s_format%>'><% = dt_total.Rows[i][4].ToString()%></td>
  <td class=xl31 style='border-top:none<%=s_format%>' x:num><% = dt_total.Rows[i][5].ToString()%></td>
  <td class=xl31 style='border-top:none<%=s_format%>'><% = dt_total.Rows[i][6].ToString()%></td>
  <td class=xl45 style='border-top:none<%=s_format%>'><% = dt_total.Rows[i][7].ToString()%></td>
  <td class=xl32 style='border-top:none<%=s_format%>' x:num><% = dt_total.Rows[i][8].ToString()%></td>
  <td class=xl31 style='border-top:none<%=s_format%>' x:num><% = dt_total.Rows[i][9].ToString()%></td>
  <td class=xl31 style='border-top:none<%=s_format%>' x:num><% = dt_total.Rows[i][10].ToString()%></td>
  <td class=xl31 style='border-top:none<%=s_format%>' x:num><% = dt_total.Rows[i][11].ToString()%></td>
  <td class=xl31 style='border-top:none<%=s_format%>'  x:num><% = dt_total.Rows[i][12].ToString()%></td>
  <td class=xl33 style='border-top:none<%=s_format%>' x:num><span
  style='mso-spacerun:yes'>      </span><% = dt_total.Rows[i][13].ToString()%></td>
 </tr>
 <%
    }
  %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=38 style='width:29pt'></td>
  <td width=130 style='width:98pt'></td>
  <td width=130 style='width:98pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=194 style='width:146pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=98 style='width:74pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
