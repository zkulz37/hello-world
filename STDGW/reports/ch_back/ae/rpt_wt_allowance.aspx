<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%   ESysLib.SetUser(Session["APP_DBUSER"].ToString());
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
     string SQL;
     if (p_typeobj == "1")
     {

         SQL = " SELECT  to_char(sysdate,'dd/mm/yyyy') ,b.org_nm, c.workgroup_nm, a.emp_id, a.full_name,to_char(to_date(a.join_dt,'yyyymmdd'),'dd/mm/yyyy'), ";
         SQL = SQL + "                (select code_nm from vhr_hr_code where id='HR0029' and code=d.kind) , ";
         SQL = SQL + "                  to_char(to_date(d.START_DT,'yyyymmdd'),'dd/mm/yyyy'),to_char(to_date(d.end_dt,'yyyymmdd'),'dd/mm/yyyy') , d.reg_hours,d.remark  ";
         SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0119' and code=d.reg_type),d.test_weeks,to_char(to_date(d.test_date,'yyyymmdd'),'dd/mm/yyyy')";
         SQL = SQL + ",d.register_times as register_times ";
         SQL = SQL + "           FROM thr_employee a, tco_org b, thr_work_group c, ";
         SQL = SQL + "           (select r.thr_emp_pk,r.kind,r.start_dt,r.end_dt,r.remark,r.reg_hours,r.pk,r.test_date,r.test_weeks,r.reg_type,r.register_times  ";
         SQL = SQL + "            from (select thr_emp_pk ,max(start_dt) as start_dt ";
         SQL = SQL + "            from thr_regulation  ";
         SQL = SQL + "            where del_if=0  ";
         SQL = SQL + "            group by thr_emp_pk ";
         SQL = SQL + "            ) reg ,thr_regulation r ";
         SQL = SQL + "            where r.del_if=0 and r.thr_emp_pk=reg.thr_emp_pk and reg.start_dt=r.start_dt) d ";
         SQL = SQL + "           WHERE a.del_if = 0 ";
         SQL = SQL + "            AND b.del_if = 0 ";
         SQL = SQL + "            AND c.del_if = 0 ";
         SQL = SQL + "            AND a.tco_org_pk = b.pk ";
         SQL = SQL + "            AND a.thr_wg_pk = c.pk ";
         SQL = SQL + "            AND decode('" + p_status + "','ALL','" + p_status + "',a.status)='" + p_status + "'";
         SQL = SQL + "            AND DECODE ('" + p_wg + "', ";
         SQL = SQL + "                        'ALL', '" + p_wg + "', ";
         SQL = SQL + "                        a.thr_wg_pk ";
         SQL = SQL + "                       ) = '" + p_wg + "'";
         SQL = SQL + "             AND UPPER (DECODE ('" + p_search_by + "', ";
         SQL = SQL + "                              1, a.full_name, ";
         SQL = SQL + "                              2, a.emp_id, ";
         SQL = SQL + "                              3,a.id_num, ";
         SQL = SQL + "                              4,person_id, ";
         SQL = SQL + "                              old_id) ";
         SQL = SQL + "                     ) LIKE '%' || UPPER ('" + p_search_temp + "') || '%' ";
         SQL = SQL + "            AND (  a.tco_org_pk IN ( ";
         SQL = SQL + "                              SELECT     g.pk ";
         SQL = SQL + "                                    FROM tco_org g ";
         SQL = SQL + "                                   WHERE g.del_if = 0 ";
         //SQL = SQL + "                                     AND NVL (g.child_yn, 'Y') = 'N' ";
         SQL = SQL + "                              START WITH g.pk = ";
         SQL = SQL + "                                            DECODE ('" + p_tco_org_pk + "', ";
         SQL = SQL + "                                                    'ALL', 0, ";
         SQL = SQL + "                                                    '" + p_tco_org_pk + "'";
         SQL = SQL + "                                                   ) ";
         SQL = SQL + "                              CONNECT BY PRIOR g.pk = g.p_pk) ";
         SQL = SQL + "                        OR '" + p_tco_org_pk + "'= 'ALL') ";
         SQL = SQL + "            and d.thr_emp_pk=a.pk ";
         SQL = SQL + "            AND (( d.start_dt <= '" + p_to_regdate + "' and d.end_dt >= '" + p_from_regdate + "') or  '" + p_from_regdate + "' is null or '" + p_to_regdate + "' is null) ";
         SQL = SQL + "                 and  decode('" + p_kind + "','ALL','" + p_kind + "',d.kind)='" + p_kind + "' ";
         SQL = SQL + "            order by org_nm,workgroup_nm,emp_id       ";
     }
     else //history
     {
         SQL = " SELECT  to_char(sysdate,'dd/mm/yyyy') ,b.org_nm, c.workgroup_nm, a.emp_id, a.full_name,to_char(to_date(a.join_dt,'yyyymmdd'),'dd/mm/yyyy'), ";
         SQL = SQL + "                (select code_nm from vhr_hr_code where id='HR0029' and code=d.kind) , ";
         SQL = SQL + "                  to_char(to_date(d.START_DT,'yyyymmdd'),'dd/mm/yyyy'),to_char(to_date(d.end_dt,'yyyymmdd'),'dd/mm/yyyy') , d.reg_hours,d.remark  ";
         SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0119' and code=d.reg_type),d.test_weeks,to_char(to_date(d.test_date,'yyyymmdd'),'dd/mm/yyyy')";
         SQL = SQL + ",d.register_times as register_times ";
         SQL = SQL + "           FROM thr_employee a, tco_org b, thr_work_group c, ";
         SQL = SQL + "           thr_regulation d ";
         SQL = SQL + "           WHERE a.del_if = 0 ";
         SQL = SQL + "            AND b.del_if = 0 ";
         SQL = SQL + "            AND c.del_if = 0 and d.del_if=0 and d.thr_emp_pk=a.pk";
         SQL = SQL + "            AND a.tco_org_pk = b.pk ";
         SQL = SQL + "            AND a.thr_wg_pk = c.pk ";
         SQL = SQL + "            AND decode('" + p_status + "','ALL','" + p_status + "',a.status)='" + p_status + "'";
         SQL = SQL + "            AND DECODE ('" + p_wg + "', ";
         SQL = SQL + "                        'ALL', '" + p_wg + "', ";
         SQL = SQL + "                        a.thr_wg_pk ";
         SQL = SQL + "                       ) = '" + p_wg + "'";
         SQL = SQL + "             AND UPPER (DECODE ('" + p_search_by + "', ";
         SQL = SQL + "                              1, a.full_name, ";
         SQL = SQL + "                              2, a.emp_id, ";
         SQL = SQL + "                              3,a.id_num, ";
         SQL = SQL + "                              4,person_id, ";
         SQL = SQL + "                              old_id) ";
         SQL = SQL + "                     ) LIKE '%' || UPPER ('" + p_search_temp + "') || '%' ";
         SQL = SQL + "            AND (  a.tco_org_pk IN ( ";
         SQL = SQL + "                              SELECT     g.pk ";
         SQL = SQL + "                                    FROM tco_org g ";
         SQL = SQL + "                                   WHERE g.del_if = 0 ";
         //SQL = SQL + "                                     AND NVL (g.child_yn, 'Y') = 'N' ";
         SQL = SQL + "                              START WITH g.pk = ";
         SQL = SQL + "                                            DECODE ('" + p_tco_org_pk + "', ";
         SQL = SQL + "                                                    'ALL', 0, ";
         SQL = SQL + "                                                    '" + p_tco_org_pk + "'";
         SQL = SQL + "                                                   ) ";
         SQL = SQL + "                              CONNECT BY PRIOR g.pk = g.p_pk) ";
         SQL = SQL + "                        OR '" + p_tco_org_pk + "'= 'ALL') ";
         SQL = SQL + "            AND ((d.start_dt <= '" + p_to_regdate + "' and d.end_dt >= '" + p_from_regdate + "') or '" + p_from_regdate + "' is null or '" + p_to_regdate + "' is null) ";
         SQL = SQL + "            order by org_nm,workgroup_nm,emp_id       ";
     }

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
<link rel=File-List href="rpt_wt_allowance_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_wt_allowance_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_wt_allowance_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>ty-ml</o:LastAuthor>
  <o:LastPrinted>2008-07-10T08:28:40Z</o:LastPrinted>
  <o:Created>2008-05-26T08:09:14Z</o:Created>
  <o:LastSaved>2008-07-10T08:28:55Z</o:LastSaved>
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
	margin:.17in .41in .53in .32in;
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
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
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
.xl41
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
.xl42
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
	white-space:normal;}
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
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
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
	border-left:.5pt solid windowtext;
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
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
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
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
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
<table x:str border=0 cellpadding=0 cellspacing=0 width=1107 style='border-collapse:
 collapse;table-layout:fixed;width:832pt'>
 <col class=xl24 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl24 width=132 style='mso-width-source:userset;mso-width-alt:4827;
 width:99pt'>
 <col class=xl24 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl24 width=173 style='mso-width-source:userset;mso-width-alt:6326;
 width:130pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=98 style='mso-width-source:userset;mso-width-alt:3584;  <%--Regulation type--%>
 width:74pt'> 
 <col class=xl24 width=101 style='mso-width-source:userset;mso-width-alt:3693;
 width:76pt'>
 <col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl24 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl24 width=98 style='mso-width-source:userset;mso-width-alt:4004;  <%--Pregnancy times--%>
 width:74pt'>
 <col class=xl24 width=113 style='mso-width-source:userset;mso-width-alt:4132;
 width:85pt'>

 <col class=xl24 width=64 style='width:48pt'>
 <tr height=34 style='height:25.5pt'>
  <td colspan=11 height=34 class=xl49 width=1031 style='height:25.5pt;
  width:775pt'><%if (p_kind == "01")
                     Response.Write("Danh sách công nhân có thai trên 6 tháng được về sớm 1 tiếng");
                 else if (p_kind == "02")
                     Response.Write("Danh sách công nhân nuôi con dưới 1 tuổi được về sớm 1 tiếng");
                 else
                     Response.Write("Danh sách công nhân thai trên 6 tháng và nuôi con dưới 1 tuổi được về sớm 1 tiếng");  %></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'>Reporter</td>
  <td class=xl29><%=p_user %></td>
  <td colspan=9 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'>Report Date</td>
  <td class=xl30 x:num><%= dt_total.Rows[0][0].ToString() %></td>
  <td colspan=9 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl31>From Date :</td>
  <td class=xl25><%=p_from_regdate_text %></td>
  <td class=xl31>To Date :</td>
  <td class=xl25><%=p_to_regdate_text %></td>
  <td class=xl25></td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=11 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl32 style='height:24.0pt'>Organization</td>
  <td class=xl33>Group</td>
  <td class=xl33>Emp ID</td>
  <td class=xl33>Full Name</td>  
  <td class=xl33>Join Date</td>
  <td class=xl33>Type</td>  
  <td class=xl33>Reg Type</td>
  <td class=xl33>Test Weeks</td>
  <td class=xl33>Test Date/Child Birth</td> 
  <td class=xl33>From Date</td>
  <td class=xl33>To Date</td>
  <td class=xl33>Time</td>
  <td class=xl33>Register Times</td>
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
  <td class=xl35 style='border-top:none'>Lo&#7841;i</td>  
  <td class=xl35 style='border-top:none'>Kiểu về sớm</td>
  <td class=xl35 style='border-top:none'>Tuần khám thai</td>
  <td class=xl35 style='border-top:none'>Ngày khám/Ngày sinh</td>  
  <td class=xl35 style='border-top:none'>T&#7915; ngày</td>
  <td class=xl35 style='border-top:none'>&#272;&#7871;n ngày</td>
  <td class=xl35 style='border-top:none'>Th&#7901;i gian</td>
  <td class=xl35 style='border-top:none'>Lần đăng ký</td>
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
  <td height=36 class=xl36 style='height:27.0pt;border-top:none<%=s_format%>'><% = dt_total.Rows[i][1].ToString()%></td>
  <td class=xl37 style='border-top:none<%=s_format%>'><% = dt_total.Rows[i][2].ToString()%></td>
  <td class=xl38 style='border-top:none<%=s_format%>'><% = dt_total.Rows[i][3].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][4].ToString()%></td>
  <td class=xl46 style='border-top:none<%=s_format%>' x:num><% = dt_total.Rows[i][5].ToString()%></td>
  <td class=xl46 style='border-top:none<%=s_format%>' x:str><% = dt_total.Rows[i][6].ToString()%><span
  style='mso-spacerun:yes'> </span></td>  
  <td class=xl48 width=113 style='border-top:none;width:85pt<%=s_format%>'><% = dt_total.Rows[i][11].ToString()%></td>
  <td class=xl48 width=113 style='border-top:none;width:85pt<%=s_format%>'><% = dt_total.Rows[i][12].ToString()%></td>
  <td class=xl48 width=113 style='border-top:none;width:85pt<%=s_format%>'><% = dt_total.Rows[i][13].ToString()%></td>
  <td class=xl46 style='border-top:none<%=s_format%>' x:num><% = dt_total.Rows[i][7].ToString()%></td>
  <td class=xl46 style='border-top:none<%=s_format%>' x:num><% = dt_total.Rows[i][8].ToString()%></td>
  <td class=xl47 width=68 style='border-top:none;width:51pt<%=s_format%>'><% = dt_total.Rows[i][9].ToString()%></td>
  <td class=xl46 style='border-top:none<%=s_format%>' x:str><% = dt_total.Rows[i]["register_times"].ToString()%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl48 width=113 style='border-top:none;width:85pt<%=s_format%>'><% = dt_total.Rows[i][10].ToString()%></td>
  <td class=xl25 ></td>
 </tr>
 <%
    }
  %>
 
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=14 height=31 class=xl50 style='border-right:.5pt solid black;
  height:23.25pt'>TOTAL <%=irow %> EMPLOYEE(S)</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  
 </tr>
 <![endif]>
</table>

</body>

</html>
