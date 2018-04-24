<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%

    string p_dept, p_position, p_status, p_search_by, p_search_temp, p_workmonth, p_from_join, p_to_join, p_money_kind;

    p_dept = Request["org"].ToString();
    p_position = Request["position"].ToString();
    p_status = Request["status"].ToString();
    p_search_by = Request["search_by"].ToString();
    p_search_temp = Request["search_temp"].ToString();
    p_workmonth = Request["workmonth"].ToString();
    p_from_join = Request["from_join"].ToString();
    p_to_join = Request["to_join"].ToString();
    p_money_kind = Request["money_kind"].ToString();

    //p_dept = "ALL";
    //p_position = "ALL";
    //p_status = "ALL";
    //p_search_by = "1";
    //p_search_temp = "ALL";
    //p_workmonth = "NULL";
    //p_from_join = "NULL";
    //p_to_join = "NULL";
    //p_money_kind = "ALL";

    string SQL
    = "select s.thr_emp_pk,g.org_nm, " + //0 1
        "    (select code_nm from vhr_hr_code where id='HR0008' and code=e.pos_type), " + //2
        "    e.emp_id,e.full_name,to_char(to_date(e.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy'), " +  // 3 4 5
        "    to_char(to_date(s.work_mon,'yyyymm'),'mm/yyyy'), " + //6
        "    s2.salary_level2 as old_sal,s.SALARY_LEVEL2 as new_sal,to_char(to_date(s.CONFIRM_DT,'yyyymmdd'),'dd/mm/yyyy') " + //7 8 9
        "    from thr_salary_manage s,thr_employee e,thr_salary_manage s2,tco_org g " +
        "    where s.del_if=0 and e.del_if=0 and g.del_if=0 and s.thr_emp_pk=e.pk  " +
        "    and s2.del_if=0 and s.WORK_MON>=nvl('"+ p_workmonth +"',substr(e.JOIN_DT,1,6)) " +
        "    and s2.thr_emp_pk=e.pk and e.tco_org_pk=g.pk " +
        "    and s2.work_mon=to_char(add_months(to_date(s.work_mon,'yyyymm'),-1),'yyyymm')  " +
        "    and nvl(s.SALARY_LEVEL2,0)<>nvl(s2.salary_level2,0) " +
        "    and nvl(s.SALARY_LEVEL2,0)>0 and nvl(s2.salary_level2,0)>0 " +
        "    AND (g.pk IN (SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk =DECODE ('" + p_dept + "','ALL', 0,'" + p_dept + "') " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_dept + "' = 'ALL') " +
        "   AND DECODE ('" + p_position + "', 'ALL', '" + p_position + "', e.pos_type) = '" + p_position + "' " +
        "   AND DECODE ('" + p_status + "', 'ALL', '" + p_status + "', e.status) = '" + p_status + "' " +
        "   AND UPPER (DECODE ("+ p_search_by +",1, e.full_name,2, e.emp_id,e.id_num)) LIKE '%' || UPPER ('"+ p_search_temp +"') || '%' " +
        "   AND ('"+ p_from_join +"' IS NULL " +
        "        OR '" + p_to_join + "' IS NULL " +
        "        OR e.join_dt BETWEEN '" + p_from_join + "' AND '" + p_to_join + "' " +
        "       ) " +
        "  AND DECODE('" + p_money_kind + "','ALL','" + p_money_kind + "',e.MONEY_KIND)='" + p_money_kind + "' " +
        "  order by g.org_nm,e.join_dt,s.work_mon ";

    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
    int emp_row = 0;
    if (dt_emp.Rows.Count == 0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }
    else
    {
        emp_row = dt_emp.Rows.Count;
    }
    
    //Information Company
    string SQL_Com
    = "select  a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,a.TCO_BPPHOTO_PK,to_char(to_date('" + p_workmonth + "','yyyymm'),'MM-YYYY'),to_char(to_date('" + p_workmonth + "','yyyymm'),'MM-YYYY') " +
        "from tco_company a " +
        "where a.DEL_IF=0 " +
        "and a.pk in ( select tco_company_pk from  " +
        "               tco_org  f " +
        "               where  f.pk IN ( " +
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
        "and rownum=1 ";

    //Response.Write(SQL_Com);
    //Response.End();
    DataTable dt_Com = ESysLib.TableReadOpen(SQL_Com);
    int irow_com;
    irow_com = dt_Com.Rows.Count;
    if (irow_com == 0)
    {
        Response.Write("There is no data of company");
        Response.End();
    }
    string month_VN, month_EN;
    if (p_workmonth !="")
    {
        month_VN = "TỪ " + dt_Com.Rows[0][4].ToString();
        month_EN = "FROM " + dt_Com.Rows[0][4].ToString();
    }
    else
    {
        month_EN = "";
        month_VN = "";
    }
    int pk = int.Parse(dt_Com.Rows[0][3].ToString());

 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_event_salary_change_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_event_salary_change_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_event_salary_change_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Hee</o:Author>
  <o:LastAuthor>PHONGNV</o:LastAuthor>
  <o:Created>2008-09-26T02:35:53Z</o:Created>
  <o:LastSaved>2010-06-08T02:43:06Z</o:LastSaved>
  <o:Company>Hee Nguyen</o:Company>
  <o:Version>11.6568</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
.font11
	{color:windowtext;
	font-size:12.0pt;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	mso-number-format:"\@";}
.xl26
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl28
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;}
.xl31
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;}
.xl32
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl33
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
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
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:Scale>32</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
      <x:RowBreak>
       <x:Row>6</x:Row>
      </x:RowBreak>
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
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$2:$7</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1028"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1223 style='border-collapse:
 collapse;table-layout:fixed;width:919pt'>
 <col class=xl24 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col width=189 style='mso-width-source:userset;mso-width-alt:6912;width:142pt'>
 <col width=168 style='mso-width-source:userset;mso-width-alt:6144;width:126pt'>
 <col width=77 style='mso-width-source:userset;mso-width-alt:2816;width:58pt'>
 <col width=187 style='mso-width-source:userset;mso-width-alt:6838;width:140pt'>
 <col width=108 style='mso-width-source:userset;mso-width-alt:3949;width:81pt'>
 <col class=xl25 width=105 style='mso-width-source:userset;mso-width-alt:3840;
 width:79pt'>
 <col class=xl26 width=112 style='mso-width-source:userset;mso-width-alt:4096;
 width:84pt'>
 <col class=xl26 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col width=105 style='mso-width-source:userset;mso-width-alt:3840;width:79pt'>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl24 width=62 style='height:13.5pt;width:47pt'></td>
  <td width=189 style='width:142pt'></td>
  <td width=168 style='width:126pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=187 style='width:140pt'></td>
  <td width=108 style='width:81pt'></td>
  <td class=xl25 width=105 style='width:79pt'></td>
  <td class=xl26 width=112 style='width:84pt'></td>
  <td class=xl26 width=110 style='width:83pt'></td>
  <td width=105 style='width:79pt'></td>
 </tr>
 <tr class=xl24 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 style='height:21.75pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
   id="_x0000_t75" coordsize="21600,21600" o:spt="75" o:preferrelative="t"
   path="m@4@5l@4@11@9@11@9@5xe" filled="f" stroked="f">
   <v:stroke joinstyle="miter"/>
   <v:formulas>
    <v:f eqn="if lineDrawn pixelLineWidth 0"/>
    <v:f eqn="sum @0 1 0"/>
    <v:f eqn="sum 0 0 @1"/>
    <v:f eqn="prod @2 1 2"/>
    <v:f eqn="prod @3 21600 pixelWidth"/>
    <v:f eqn="prod @3 21600 pixelHeight"/>
    <v:f eqn="sum @0 0 1"/>
    <v:f eqn="prod @6 1 2"/>
    <v:f eqn="prod @7 21600 pixelWidth"/>
    <v:f eqn="sum @8 21600 0"/>
    <v:f eqn="prod @7 21600 pixelHeight"/>
    <v:f eqn="sum @10 21600 0"/>
   </v:formulas>
   <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
   <o:lock v:ext="edit" aspectratio="t"/>
  </v:shapetype><v:shape id="Picture_x0020_1" o:spid="_x0000_s1027" type="#_x0000_t75"
   alt="http://localhost/esys/system/binary/ViewFile.aspx?img_pk=149&amp;table_name=tco_bpphoto"
   style='position:absolute;margin-left:0;margin-top:0;width:46.5pt;height:42pt;
   z-index:1;visibility:visible'>
   <v:imagedata src="http://localhost/esys/system/binary/ViewFile.aspx?img_pk=149&amp;table_name=tco_bpphoto"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:0px;width:62px;
  height:56px'><img width=62 height=56
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=pk%>&table_name=tco_bpphoto"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=29 class=xl28 width=62 style='height:21.75pt;width:47pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl29><%=dt_Com.Rows[0][0].ToString() %></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl30>SALARY CHANGE EVENT <%= month_EN %></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
 </tr>
 <tr class=xl24 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl28 style='height:18.75pt'></td>
  <td class=xl29 colspan=3 style='mso-ignore:colspan'><%=dt_Com.Rows[0][1].ToString().ToUpper() %></td>
  <td class=xl29></td>
  <td class=xl24></td>
  <td class=xl33>TIẾN TRÌNH THAY ĐỔI LƯƠNG <%= month_VN %></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl24 height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl28 style='height:12.0pt'></td>
  <td class=xl29>Phone :<%=dt_Com.Rows[0][2].ToString() %></td>
  <td class=xl29></td>
  <td class=xl24></td>
  <td class=xl34></td>
  <td class=xl24></td>
  <td class=xl27></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 style='height:12.75pt'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr class=xl35 height=39 style='mso-height-source:userset;height:29.25pt'>
  <td rowspan=2 height=78 class=xl45 width=62 style='border-bottom:.5pt solid black;
  height:58.5pt;width:47pt'>No.<br>
    <font class="font11">STT</font></td>
  <td rowspan=2 class=xl47 width=189 style='border-bottom:.5pt solid black;
  width:142pt'>Department<br>
    <font class="font11">Bộ phận</font></td>
  <td rowspan=2 class=xl47 width=168 style='border-bottom:.5pt solid black;
  width:126pt'>Position<br>
    <font class="font11">Chức vụ</font></td>
  <td rowspan=2 class=xl47 width=77 style='border-bottom:.5pt solid black;
  width:58pt'>Emp ID<br>
    <font class="font11">Mã NV</font></td>
  <td rowspan=2 class=xl47 width=187 style='border-bottom:.5pt solid black;
  width:140pt'>Full Name<br>
    <font class="font11">Họ và Tên</font></td>
  <td rowspan=2 class=xl47 width=108 style='border-bottom:.5pt solid black;
  width:81pt'>Join Date<br>
    <font class="font11">Ngày vào</font></td>
  <td rowspan=2 class=xl49 width=105 style='border-bottom:.5pt solid black;
  width:79pt'>Work month<br>
    <font class="font11">Tháng</font></td>
  <td rowspan=2 class=xl45 width=112 style='border-bottom:.5pt solid black;
  width:84pt'>Old Salary<br>
    <font class="font11">Lương cũ</font></td>
  <td rowspan=2 class=xl45 width=110 style='border-bottom:.5pt solid black;
  width:83pt'>New Salary<br>
    <font class="font11">Lương mới</font></td>
  <td rowspan=2 class=xl47 width=105 style='border-bottom:.5pt solid black;
  width:79pt'>Confirm Date<br>
    <font class="font11">Ngày hiệu lực</font></td>
 </tr>
 <tr class=xl35 height=39 style='page-break-before:always;mso-height-source:
  userset;height:29.25pt'>
 </tr>
 <%   
     int i;
      for (i = 0; i < emp_row; i++)
        {
 %>
 <tr class=xl36 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl37 style='height:22.5pt' x:str><%=i+1 %></td>
  <td class=xl38 x:str><%= dt_emp.Rows[i][1].ToString() %></td>
  <td class=xl38><%= dt_emp.Rows[i][2].ToString()%></td>
  <td class=xl38 x:num><%= dt_emp.Rows[i][3].ToString()%></td>
  <td class=xl38><%= dt_emp.Rows[i][4].ToString()%></td>
  <td class=xl39><%= dt_emp.Rows[i][5].ToString()%></td>
  <td class=xl40><%= dt_emp.Rows[i][6].ToString()%></td>
  <td class=xl41 x:num><%= dt_emp.Rows[i][7].ToString()%></td>
  <td class=xl41 x:num><%= dt_emp.Rows[i][8].ToString()%></td>
  <td class=xl42><%= dt_emp.Rows[i][9].ToString()%></td>
 </tr>
    <%
        }
   %>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=6 height=28 class=xl51 style='border-right:.5pt solid black;
  height:21.0pt'>Total <%=i %> Employee(s)</td>
  <td class=xl43>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
 </tr>

 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=62 style='width:47pt'></td>
  <td width=189 style='width:142pt'></td>
  <td width=168 style='width:126pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=187 style='width:140pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=112 style='width:84pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=105 style='width:79pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
