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
    string p_tco_dept_pk, p_thr_group_pk, p_status, p_position, p_search_by, p_search_temp, p_from_joindate , p_to_joindate , p_money_kind , p_contract_type,p_month;
    p_tco_dept_pk = Request["dept"].ToString();
    p_thr_group_pk = Request["group"].ToString();
    p_status = Request["status"].ToString();
    p_position = Request["pos"].ToString();
    p_search_by = Request["lsttmp"].ToString();
    p_search_temp = Request["txttmp"].ToString();
    p_from_joindate  = Request["fromjoin"].ToString();
    p_to_joindate  = Request["tojoin"].ToString();
    p_money_kind  = Request["lstmoney"].ToString();
    p_contract_type = Request["contract"].ToString();
    p_month= Request["dtMonth"].ToString();


    string SQL_Com
    = "select  a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,a.TCO_BPPHOTO_PK,to_char(to_date('" + p_month + "','yyyymm'),'MM-YYYY') " +
        "from tco_company a " +
        "where a.DEL_IF=0 " +
        "and a.pk in ( select tco_company_pk from  " +
        "               tco_org  f " +
        "               where  f.pk IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_tco_dept_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_tco_dept_pk + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_tco_dept_pk + "' = 'ALL') " +
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
    int pk = int.Parse(dt_Com.Rows[0][3].ToString());


    string SQL
	= "SELECT   b.dept_nm, c.group_nm, a.emp_id, a.full_name, " + 
        "               TO_CHAR (TO_DATE (a.join_dt, 'yyyymmdd'), 'dd/mm/yyyy') " +
        "               ,p.code_nm ,d.code_nm,las.basic_sal,cur.basic_sal " +
        "          FROM thr_employee a,tco_org b,thr_group c " +
        "               ,(SELECT code, code_nm FROM vhr_hr_code WHERE ID = 'HR0001') d " +
        "               ,(SELECT code, code_nm FROM vhr_hr_code WHERE ID = 'HR0008') p " +
        "               ,(SELECT t.thr_emp_pk, " +
        "                  (case when t.confirm_dt is null or t.confirm_dt <= s.to_dt then t.salary_level2 else t.salary_level1 end) as basic_sal " +
        "                  FROM thr_salary_manage t,thr_close s  " +
        "                 WHERE t.del_if = 0 and t.del_if=0 and s.id='01' " +
        "                   and t.work_mon=s.month_close " +
        "                   AND t.work_mon = '" + p_month + "') CUR " +
        "               ,(SELECT t.thr_emp_pk, " +
        "                  (case when t.confirm_dt is null or t.confirm_dt <= s.to_dt then t.salary_level2 else t.salary_level1 end) as basic_sal " +
        "                  FROM thr_salary_manage t,thr_close s  " +
        "                 WHERE t.del_if = 0 and t.del_if=0 and s.id='01' " +
        "                   and t.work_mon=s.month_close " +
        "                   AND t.work_mon =to_char(add_months(to_date('" + p_month + "','yyyymm'),-1),'yyyymm')) LAS " +
        "         WHERE a.del_if = 0 " +
        "           AND b.del_if = 0 " +
        "           AND c.del_if = 0 " +
        "           AND a.thr_group_pk = c.pk " +
        "           AND a.tco_org_pk = b.pk " +
        "           AND a.pk=CUR.thr_emp_pk " +
        "           and a.pk=LAS.THR_EMP_PK " +
        "           and nvl(cur.basic_sal,0) <> nvl(las.basic_sal,0)  " +
        "           and a.contract_type=d.code " +
        "           and a.pos_type=p.code(+) " +
        "           AND CUR.thr_emp_pk=LAS.THR_EMP_PK " +
        "           AND DECODE ('" + p_thr_group_pk + "','ALL','" + p_thr_group_pk + "',a.thr_group_pk) ='" + p_thr_group_pk + "' " +
        "           AND (a.tco_org_pk IN (SELECT  g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                                    START WITH g.pk=DECODE ('" + p_tco_dept_pk  + "','ALL', 0,'" + p_tco_dept_pk  + "') " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_tco_dept_pk  + "' = 'ALL') " +
        "           AND DECODE ('" + p_position + "', 'ALL', '" + p_position + "', a.pos_type) = '" + p_position + "' " +
        "           AND DECODE ('" + p_status + "', 'ALL', '" + p_status + "', a.status) = '" + p_status + "' " +
        "           AND DECODE ('" + p_contract_type + "','ALL', '" + p_contract_type + "',a.contract_type) = '" + p_contract_type + "' " +
        "           AND UPPER (DECODE ('" + p_search_by + "',1, a.full_name,2, a.emp_id,a.id_num)) LIKE '%' || UPPER ('" + p_search_temp  + "') || '%' " +
        "           AND ('" + p_from_joindate  + "' IS NULL OR '" + p_to_joindate  + "' IS NULL " +
        "                OR a.join_dt BETWEEN '" + p_from_joindate  + "' AND '" + p_to_joindate  + "' " +
        "               ) " +
        "           AND DECODE('" + p_money_kind  + "','ALL','" + p_money_kind  + "',A.MONEY_KIND)='" + p_money_kind  + "' " +
        "      ORDER BY b.dept_nm, c.group_nm, a.emp_id " ;

        //Response.Write(SQL);
        //Response.End();    
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

 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_basic_salary_changing_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_basic_salary_changing_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_basic_salary_changing_files/oledata.mso">
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
  <o:LastAuthor>tyml</o:LastAuthor>
  <o:LastPrinted>2009-06-18T01:37:39Z</o:LastPrinted>
  <o:Created>2008-09-26T02:35:53Z</o:Created>
  <o:LastSaved>2009-06-18T01:37:45Z</o:LastSaved>
  <o:Company>Hee Nguyen</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.77in .26in .49in .25in;
	mso-header-margin:.5in;
	mso-footer-margin:.24in;}
.font12
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl29
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
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
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
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
.xl43
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
.xl44
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
.xl45
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
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
.xl48
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
.xl49
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
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
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
	border-left:none;}
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
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl54
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl55
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
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;
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
      <x:Scale>71</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:SplitVertical>5</x:SplitVertical>
     <x:LeftColumnRightPane>6</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
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
  <x:WindowHeight>8235</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1431 style='border-collapse:
 collapse;table-layout:fixed;width:1076pt'>
 <col class=xl24 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col width=122 style='mso-width-source:userset;mso-width-alt:4461;width:92pt'>
 <col width=128 style='mso-width-source:userset;mso-width-alt:4681;width:96pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=181 style='mso-width-source:userset;mso-width-alt:6619;width:136pt'>
 <col width=76 style='mso-width-source:userset;mso-width-alt:2779;width:57pt'>
 <col width=89 span=2 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col width=96 span=2 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col width=83 style='mso-width-source:userset;mso-width-alt:3035;width:62pt'>
 <col width=88 style='mso-width-source:userset;mso-width-alt:3218;width:66pt'>
 <col width=82 span=8 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <tr class=xl24 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 width=65 style='height:21.75pt;width:49pt' align=left
  valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75" coordsize="21600,21600"
   o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe" filled="f"
   stroked="f">
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
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" alt="" style='position:absolute;
   margin-left:0;margin-top:0;width:46.5pt;height:42pt;z-index:1'>
   <v:imagedata src="http://localhost/esys/system/binary/ViewFile.aspx?img_pk=66&amp;table_name=tco_bpphoto"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:0px;width:62px;
  height:56px'><img width=62 height=56
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=pk%>&table_name=tco_bpphoto"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=29 class=xl25 width=65 style='height:21.75pt;width:49pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl26 colspan=2 width=250 style='mso-ignore:colspan;width:188pt'><%=dt_Com.Rows[0][0].ToString() %></td>
  <td class=xl26 width=72 style='width:54pt'></td>
  <td class=xl24 width=181 style='width:136pt'></td>
  <td class=xl24 width=76 style='width:57pt'></td>
  <td class=xl28 width=89 style='width:67pt'>BASIC SALARY CHANGING <%=dt_Com.Rows[0][4].ToString() %></td>
  <td class=xl24 width=89 style='width:67pt'></td>
  <td class=xl24 width=96 style='width:72pt'></td>
  <td class=xl24 width=96 style='width:72pt'></td>
  <td class=xl24 width=83 style='width:62pt'></td>
  <td class=xl24 width=88 style='width:66pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
 </tr>
 <tr class=xl24 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl25 style='height:18.75pt'></td>
  <td class=xl26><%=dt_Com.Rows[0][1].ToString() %></td>
  <td class=xl26></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>THAY &#272;&#7892;I L&#431;&#416;NG <%=dt_Com.Rows[0][4].ToString() %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl25 style='height:12.0pt'></td>
  <td class=xl26>Phone : <%=dt_Com.Rows[0][2].ToString() %></td>
  <td class=xl26></td>
  <td class=xl24></td>
  <td class=xl30></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl32 style='height:12.75pt'></td>
  <td colspan=14 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=66 style='mso-height-source:userset;height:49.5pt'>
  <td height=66 class=xl53 width=65 style='height:49.5pt;width:49pt'>No.<br>
    <font class="font12">STT</font></td>
  <td class=xl54 width=122 style='width:92pt'>DEPARTMENT<br>
    <font class="font12">B&#7897; ph&#7853;n</font></td>
  <td class=xl54 width=128 style='width:96pt'>GROUP<br>
    <font class="font12">Nhóm</font></td>
  <td class=xl54 width=72 style='width:54pt'>Emp ID<br>
    <font class="font12">Mã NV</font></td>
  <td class=xl54 width=181 style='width:136pt'>Full Name<br>
    <font class="font12">H&#7885; và Tên</font></td>
  <td class=xl54 width=76 style='width:57pt'>Join Date<br>
    <font class="font12">Ngày vào</font></td>
  <td class=xl54 width=89 style='width:67pt'>Position<br>
    <font class="font12">Ch&#7913;c v&#7909;</font></td>
  <td class=xl54 width=89 style='width:67pt'>Contract<br>
    <font class="font12">Lo&#7841;i H&#272;</font></td>
  <td class=xl55 width=96 style='width:72pt'>Old Salary<br>
    <font class="font12">L&#432;&#417;ng c&#361;</font></td>
  <td class=xl34 width=96 style='width:72pt'>New Salary<br>
    <font class="font12">L&#432;&#417;ng m&#7899;i</font></td>
  <td colspan=5 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <%
     int i = 0;
     double[] sum = new double[2] {0,0 };
     for (i = 0; i < emp_row; i++)
     {
         sum[0]  += Double.Parse(dt_emp.Rows[i][7].ToString());
         sum[1]  += Double.Parse(dt_emp.Rows[i][8].ToString());
         
  %>
 <tr class=xl35 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl36 style='height:22.5pt' x:num><%=i+1 %></td>
  <td class=xl37><%=dt_emp.Rows[i][0].ToString() %></td>
  <td class=xl37><%=dt_emp.Rows[i][1].ToString() %></td>
  <td class=xl37><%=dt_emp.Rows[i][2].ToString() %></td>
  <td class=xl37><%=dt_emp.Rows[i][3].ToString() %></td>
  <td class=xl38><%=dt_emp.Rows[i][4].ToString() %></td>
  <td class=xl39><%=dt_emp.Rows[i][5].ToString() %></td>
  <td class=xl40><%=dt_emp.Rows[i][6].ToString() %></td>
  <td class=xl41 x:num><%=dt_emp.Rows[i][7].ToString() %></td>
  <td class=xl41 x:num><%=dt_emp.Rows[i][8].ToString() %></td>
  <td colspan=5 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=6 height=28 class=xl50 style='border-right:.5pt solid black;
  height:21.0pt'>Total <%=emp_row %> Employee(s)</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl49 x:num><%=sum[0] %></td>
  <td class=xl49 x:num><%=sum[1] %></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=65 style='width:49pt'></td>
  <td width=122 style='width:92pt'></td>
  <td width=128 style='width:96pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=181 style='width:136pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
