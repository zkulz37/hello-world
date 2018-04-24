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
    string p_dept, p_group, p_status, pos, lsttmp, txttmp, dtyear, fromjoin, tojoin, lstmoney, contract ;
//dept=ALL&code=ALL&pos=ALL&lsttmp=2
    //&txttmp=undefined&dtyear=2008&contract=ALL&status=A&fromjoin=&tojoin=&lstmoney=ALL
    p_dept = Request["org"].ToString();
    p_group = Request["wg"].ToString();
    p_status = Request["status"].ToString();
    pos = Request["pos"].ToString();
    lsttmp = Request["lsttmp"].ToString();
    txttmp = Request["txttmp"].ToString();
    dtyear = Request["dtyear"].ToString();
    fromjoin = Request["fromjoin"].ToString();
    tojoin = Request["tojoin"].ToString();
    lstmoney = Request["lstmoney"].ToString();
    contract = Request["contract"].ToString();


    string SQL_Com
    = "select  a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,a.TCO_BPPHOTO_PK,to_char(to_date('" + dtyear + "','yyyy'),'YYYY'),to_char(to_date('" + dtyear + "','yyyy'),'YYYY') " +
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
    int pk = int.Parse(dt_Com.Rows[0][3].ToString());

  
    string SQL
    = "SELECT null as null_0,  b.org_nm, c.workgroup_nm, a.emp_id, a.full_name, " +
        "               TO_CHAR (TO_DATE (a.join_dt, 'yyyymmdd'), 'dd-mm-yyyy'), " +
        "               pos.code_FNM, d.code_nm " +
        "               ,decode(nvl(e.m01,0),0,0,e.m01) " +
        "               ,decode(nvl(e.m02,0),0,0,e.m02) " +
        "               ,decode(nvl(e.m03,0),0,0,e.m03) " +
        "               ,decode(nvl(e.m04,0),0,0,e.m04) " +
        "               ,decode(nvl(e.m05,0),0,0,e.m05) " +
        "               ,decode(nvl(e.m06,0),0,0,e.m06) " +
        "               ,decode(nvl(e.m07,0),0,0,e.m07) " +
        "               ,decode(nvl(e.m08,0),0,0,e.m08) " +
        "               ,decode(nvl(e.m09,0),0,0,e.m09) " +
        "               ,decode(nvl(e.m10,0),0,0,e.m10) " +
        "               ,decode(nvl(e.m11,0),0,0,e.m11) " +
        "               ,decode(nvl(e.m12,0),0,0,e.m12) " +
        "          FROM thr_employee a, " +
        "               tco_org b, " +
        "               thr_work_group c, " +
        "               (select thr_emp_pk ,  " +
        "                sum(decode(substr(work_mon,5,2),'01',salary_level2,0)) as m01, " +
        "                sum(decode(substr(work_mon,5,2),'02',salary_level2,0)) as m02, " +
        "                sum(decode(substr(work_mon,5,2),'03',salary_level2,0)) as m03, " +
        "                sum(decode(substr(work_mon,5,2),'04',salary_level2,0)) as m04, " +
        "                sum(decode(substr(work_mon,5,2),'05',salary_level2,0)) as m05, " +
        "                sum(decode(substr(work_mon,5,2),'06',salary_level2,0)) as m06, " +
        "                sum(decode(substr(work_mon,5,2),'07',salary_level2,0)) as m07, " +
        "                sum(decode(substr(work_mon,5,2),'08',salary_level2,0)) as m08, " +
        "                sum(decode(substr(work_mon,5,2),'09',salary_level2,0)) as m09, " +
        "                sum(decode(substr(work_mon,5,2),'10',salary_level2,0)) as m10, " +
        "                sum(decode(substr(work_mon,5,2),'11',salary_level2,0)) as m11, " +
        "                sum(decode(substr(work_mon,5,2),'12',salary_level2,0)) as m12 " +
        "               from thr_salary_manage " +
        "               where del_if=0 and substr(work_mon,1,4)='" + dtyear + "' " +
        "               group by thr_emp_pk " +
        "               ) e, " +
        "               (SELECT code, code_nm " +
        "                  FROM vhr_hr_code " +
        "                 WHERE ID = 'HR0001') d " +
        "               , " +
        "               (SELECT vh.code, vh.code_fnm " +
        "                  FROM vhr_hr_code vh " +
        "                 WHERE vh.ID = 'HR0008') pos " +
        "         WHERE a.del_if = 0 " +
        "           AND b.del_if = 0 " +
        "           AND c.del_if = 0 " +
        "           AND a.thr_wg_pk = c.pk " +
        "           AND a.tco_org_pk = b.pk " +
        "           AND e.thr_emp_pk = a.pk " +
        "           AND a.contract_type = d.code(+) " +
        "           and pos.code(+)=a.POS_TYPE "+
        " AND DECODE ('" + p_group + "', 'ALL', '" + p_group + "', a.thr_wg_pk) ='" + p_group + "'" +
            "           AND (   a.tco_org_pk IN ( " +
            "                              SELECT     g.pk " +
            "                                    FROM tco_org g " +
            "                                   WHERE g.del_if = 0 " +
            "                              START WITH g.pk = " +
            "                                            DECODE ('"+p_dept+"', " +
            "                                                    'ALL', 0, " +
            "                                                    '" + p_dept + "' " +
            "                                                   ) " +
            "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
            "                        OR '" + p_dept + "' = 'ALL') " +
            "           AND DECODE ('" + pos + "', 'ALL', '" + pos + "', a.pos_type) = '" + pos + "' " +
            "      AND DECODE ('" + p_status + "', 'ALL', '" + p_status + "', a.status) = '" + p_status + "' " +
            "           AND DECODE ('"+contract+"', " +
            "                       'ALL', '" + contract + "', " +
            "                       a.contract_type " +
            "                      ) = '" + contract + "' " +
            "           AND UPPER (DECODE ('"+lsttmp+"', " +
            "                              1, a.full_name, " +
            "                              2, a.emp_id, " +
            "                              a.id_num " +
            "                             ) " +
            "                     ) LIKE '%' || UPPER ('"+txttmp+"') || '%' " +
            "           AND (   '"+fromjoin+"' IS NULL " +
            "                OR '"+tojoin+"' IS NULL " +
            "                OR a.join_dt BETWEEN '" + fromjoin + "' AND '" + tojoin + "' " +
            "               ) " +
            "   AND DECODE('" + lstmoney + "','ALL','" + lstmoney + "',A.MONEY_KIND)='" + lstmoney + "'" +
             "      ORDER BY NVL(B.SEQ,0),B.org_nm, C.workgroup_nm, A.emp_id ";
    

    //Response.Write(SQL);
    //Response.End();
    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int emp_cnt = 0;
    if (dt_Emp.Rows.Count == 0)
    {
        Response.Write("There is no data to print");
        Response.End();
    }
    else
    {
        emp_cnt = dt_Emp.Rows.Count;
    }

    
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_salary_year_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_salary_year_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_salary_year_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>Hee</o:LastAuthor>
  <o:LastPrinted>2008-09-24T03:02:01Z</o:LastPrinted>
  <o:Created>2008-09-06T07:03:32Z</o:Created>
  <o:LastSaved>2008-09-24T03:08:43Z</o:LastSaved>
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
	margin:.18in .19in .41in .2in;
	mso-header-margin:.17in;
	mso-footer-margin:.19in;
	mso-page-orientation:landscape;}
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
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
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
	font-size:20.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
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
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
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
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
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
.xl44
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
.xl45
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
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
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>55</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:SplitVertical>5</x:SplitVertical>
     <x:LeftColumnRightPane>5</x:LeftColumnRightPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
       <x:ActiveCol>15</x:ActiveCol>
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
  <x:WindowHeight>9630</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1365</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$4:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="4097"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1865 style='border-collapse:
 collapse;table-layout:fixed;width:1405pt'>
 <col class=xl24 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl24 width=128 span=2 style='mso-width-source:userset;mso-width-alt:
 4681;width:96pt'>
 <col class=xl24 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl24 width=204 style='mso-width-source:userset;mso-width-alt:7460;
 width:153pt'>
 <col class=xl24 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl24 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl24 width=106 style='mso-width-source:userset;mso-width-alt:3876;
 width:80pt'>
 <col class=xl24 width=82 span=11 style='mso-width-source:userset;mso-width-alt:
 2998;width:62pt'>
 <col class=xl24 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 width=72 style='height:21.75pt;width:54pt' align=left
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
   margin-left:0;margin-top:0;width:51.75pt;height:42pt;z-index:1'>
   <v:imagedata src="http://localhost:1051/ESYS/system/binary/ViewFile.aspx?img_pk=66&amp;table_name=tco_bpphoto"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF></x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:0px;width:69px;
  height:56px'><img width=69 height=56
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=pk%>&table_name=tco_bpphoto"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=29 class=xl24 width=72 style='height:21.75pt;width:54pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl25 width=128 style='width:96pt'> <%=dt_Com.Rows[0][0].ToString() %> </td>
  
  <td class=xl26 width=204 style='width:153pt'></td>
  <td class=xl24 width=73 style='width:55pt'></td>
  <td class=xl24 width=77 style='width:58pt'></td>
  <td class=xl24 width=106 style='width:80pt'></td>
  <td class=xl28 width=82 style='width:62pt'>SALARY SUMMARY IN THE YEAR <%=dt_Com.Rows[0][5].ToString().ToUpper() %></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=96 style='width:72pt'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl24 style='height:18.75pt'></td>
  <td class=xl25><%=dt_Com.Rows[0][1].ToString().ToUpper() %></td>

  <td class=xl24></td>
  <td class=xl26></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>TỔNG HỢP LƯƠNG NĂM <%=dt_Com.Rows[0][5].ToString().ToUpper() %></td>
  <td colspan=11 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl24 style='height:12.0pt'></td>
  <td class=xl25>Phone :<%=dt_Com.Rows[0][2].ToString() %></td>

  <td class=xl24></td>
  <td class=xl26></td>
  <td class=xl24></td>
  <td colspan=14 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td rowspan=2 height=50 class=xl43 width=72 style='border-bottom:.5pt solid black;
  height:37.5pt;width:54pt'>No.<br>
    <font class="font12">STT</font></td>
  <td rowspan=2 class=xl43 width=128 style='border-bottom:.5pt solid black;
  width:96pt'>DEPARTMENT<br>
    <font class="font12">Bộ phận</font></td>
  <td rowspan=2 class=xl43 width=128 style='border-bottom:.5pt solid black;
  width:96pt'>GROUP<br>
    <font class="font12">Nhóm</font></td>
  <td rowspan=2 class=xl43 width=79 style='border-bottom:.5pt solid black;
  width:59pt'>Emp ID<br>
    <font class="font12">Mã NV</font></td>
  <td rowspan=2 class=xl43 width=204 style='border-bottom:.5pt solid black;
  width:153pt'>Full Name<br>
    <font class="font12">Họ và Tên</font></td>
  <td rowspan=2 class=xl43 width=73 style='border-bottom:.5pt solid black;
  width:55pt'>Join Date<br>
    <font class="font12">Ngày vào</font></td>
  <td rowspan=2 class=xl43 width=77 style='border-bottom:.5pt solid black;
  width:58pt'>Position<br>
    <font class="font12">Chức vụ</font></td>
  <td rowspan=2 class=xl43 width=106 style='border-bottom:.5pt solid black;
  width:80pt'>Contract Type<br>
    <font class="font12">Loại hợp đồng</font></td>
  <td rowspan=2 class=xl43 width=82 style='border-bottom:.5pt solid black;
  width:62pt'>January<br>
    <font class="font12">01</font></td>
  <td rowspan=2 class=xl43 width=82 style='border-bottom:.5pt solid black;
  width:62pt'>January<br>
    <font class="font12">02</font></td>
  <td rowspan=2 class=xl43 width=82 style='border-bottom:.5pt solid black;
  width:62pt'>January<br>
    <font class="font12">03</font></td>
  <td rowspan=2 class=xl43 width=82 style='border-bottom:.5pt solid black;
  width:62pt'>January<br>
    <font class="font12">04</font></td>
  <td rowspan=2 class=xl43 width=82 style='border-bottom:.5pt solid black;
  width:62pt'>January<br>
    <font class="font12">05</font></td>
  <td rowspan=2 class=xl43 width=82 style='border-bottom:.5pt solid black;
  width:62pt'>January<br>
    <font class="font12">06</font></td>
  <td rowspan=2 class=xl43 width=82 style='border-bottom:.5pt solid black;
  width:62pt'>January<br>
    <font class="font12">07</font></td>
  <td rowspan=2 class=xl43 width=82 style='border-bottom:.5pt solid black;
  width:62pt'>January<br>
    <font class="font12">08</font></td>
  <td rowspan=2 class=xl43 width=82 style='border-bottom:.5pt solid black;
  width:62pt'>January<br>
    <font class="font12">09</font></td>
  <td rowspan=2 class=xl43 width=82 style='border-bottom:.5pt solid black;
  width:62pt'>January<br>
    <font class="font12">10</font></td>
  <td rowspan=2 class=xl43 width=82 style='border-bottom:.5pt solid black;
  width:62pt'>January<br>
    <font class="font12">11</font></td>
  <td rowspan=2 class=xl43 width=96 style='border-bottom:.5pt solid black;
  width:72pt'>January<br>
    <font class="font12">12</font></td>
 </tr>
 <tr class=xl31 height=25 style='mso-height-source:userset;height:18.75pt'>
 </tr>
 <%
     double[] sum = new double[12]{ 0,0,0,0,0,0,0,0,0,0,0,0};
     for (int i = 0; i < emp_cnt; i++)
     {
 %>
 <tr class=xl32 height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl33 style='height:25.5pt' x:num><%=i+1 %></td>
  <td class=xl34><%=dt_Emp.Rows[i][1].ToString() %></td>
  <td class=xl34><%=dt_Emp.Rows[i][2].ToString() %></td>
  <td class=xl35><%=dt_Emp.Rows[i][3].ToString() %></td>
  <td class=xl34 x:str><%=dt_Emp.Rows[i][4].ToString() %><span  style='mso-spacerun:yes'> </span></td>
  <td class=xl36><%=dt_Emp.Rows[i][5].ToString() %></td>
  <td class=xl34><%=dt_Emp.Rows[i][6].ToString() %></td>
  <td class=xl34><%=dt_Emp.Rows[i][7].ToString() %></td>
  <td class=xl37 x:num><span style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][8].ToString()%> </td>  
  <%   
      sum[0] += Double.Parse(dt_Emp.Rows[i][8].ToString());     
      for (int j = 9; j < 20; j++)
      {    sum[j - 8] += Double.Parse(dt_Emp.Rows[i][j].ToString());      
          if (!dt_Emp.Rows[i][j].ToString().Equals(dt_Emp.Rows[i][j - 1].ToString()) && dt_Emp.Rows[i][j].ToString()!="0" )
          { //neu co su thay doi luong thi chuyen mau background             
  %>
      <td class=xl42 x:num><span style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][j].ToString()%> </td>     
 <%     
          }
          else
          {          
              %>      
      <td class=xl37 x:num><span style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][j].ToString()%> </td>         
              <%
          }
      }         
  } 
 %>
  </tr>
 <tr class=xl38 height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=5 height=38 class=xl45 style='border-right:.5pt solid black;
  height:28.5pt'>Total <%=emp_cnt %> Employee(s)</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <%
        for(int t=0; t<12;t++)
        {
   %>
  <td class=xl40 x:num><b><%=sum[t] %></b></td>
  <%    
        }
   %>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=72 style='width:54pt'></td>
  <td width=128 style='width:96pt'></td>
  <td width=128 style='width:96pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=204 style='width:153pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=96 style='width:72pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
