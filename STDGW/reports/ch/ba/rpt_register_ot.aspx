<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>

<html 
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_tco_dept_pk,p_thr_group_pk,p_work_shift,p_search_by,p_search_temp,p_date;
    string p_dt; 
  
    p_tco_dept_pk       = Request["p_tco_dept_pk"].ToString();
    p_thr_group_pk      = Request["p_thr_group_pk"].ToString();
    p_date              = Request["p_dt"].ToString();
    p_search_by         = Request["p_search_by"].ToString();
    p_search_temp       = Request["p_search_temp"].ToString();
    p_work_shift        = Request["p_workshift"].ToString();

    p_dt = p_date.Substring(6,2) + "/" + p_date.Substring(4,2) + "/" + p_date.Substring(0,4);
    //-----------------information of company-----------------
    string SQL_Com
    = "select  a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,a.TCO_BPPHOTO_PK  " +
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
       
    string SQL
    = "SELECT d.org_nm AS dept_0, g.workgroup_nm group_1, e.emp_id emp_id_2, " + 
        "       e.full_name name_3, (SELECT code_nm " +
        "                              FROM vhr_hr_code " +
        "                             WHERE ID = 'HR0008' AND code = e.pos_type) pos_4, " +
        "       (SELECT code_nm " +
        "          FROM vhr_hr_code " +
        "         WHERE ID = 'HR0010' AND code = e.job_type) job_5 " +
        "  FROM thr_employee e, tco_org d, thr_work_group g " +
        " WHERE e.del_if = 0 " +
        "   AND d.del_if = 0 " +
        "   AND g.del_if = 0 " +
        "   AND e.join_dt <= '" + p_date + "' " +
        "   AND (e.left_dt is null or e.left_dt > '" + p_date + "') " +
        "   AND e.tco_org_pk = d.pk " +
        "   AND e.thr_wg_pk = g.pk " +
        "   AND decode('" + p_thr_group_pk + "','ALL','ALL',e.thr_wg_pk) = '" + p_thr_group_pk + "' " +
	    " AND (    e.TCO_ORG_PK IN ( " + 
        "                              SELECT     G.PK " +
        "                                    FROM TCO_ORG G " +
        "                                   WHERE G.DEL_IF = 0 " +
        "                              START WITH G.PK = " +
        "                                            DECODE ('" + p_tco_dept_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_tco_dept_pk + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR G.PK = G.P_PK) " +
        "                        OR '" + p_tco_dept_pk + "' = 'ALL') "  +
        " order by e.emp_id   " ;
    
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
<link rel=File-List href="rpt_register_ot_poongin_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_register_ot_poongin_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_register_ot_poongin_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>User</o:Author>
  <o:LastAuthor>baoky</o:LastAuthor>
  <o:LastPrinted>2008-09-23T06:57:59Z</o:LastPrinted>
  <o:Created>2008-01-07T03:43:02Z</o:Created>
  <o:LastSaved>2008-09-23T06:59:21Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .2in .5in .28in;
	mso-header-margin:.23in;
	mso-footer-margin:.5in;}
.font9
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
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
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto gray-125;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto gray-125;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto gray-125;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	mso-number-format:"Short Time";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto gray-125;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto gray-125;}
.xl37
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto gray-125;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto gray-125;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto gray-125;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto gray-125;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto gray-125;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto gray-125;}
.xl47
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>582</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>78</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>100</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>7</x:ActiveRow>
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
  <x:WindowHeight>6510</x:WindowHeight>
  <x:WindowWidth>11880</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1365</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$7:$7</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
  <o:regrouptable v:ext="edit">
   <o:entry new="1" old="0"/>
   <o:entry new="2" old="0"/>
   <o:entry new="3" old="0"/>
  </o:regrouptable>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=900 style='border-collapse:
 collapse;table-layout:fixed;width:676pt'>
 <col class=xl25 width=36 style='mso-width-source:userset;mso-width-alt:1316;
 width:27pt'>
 <col class=xl25 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl26 width=193 style='mso-width-source:userset;mso-width-alt:7058;
 width:145pt'>
 <col class=xl25 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl25 width=63 span=2 style='mso-width-source:userset;mso-width-alt:
 2304;width:47pt'>
 <col class=xl25 width=64 style='width:48pt'>
 <col class=xl25 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl25 width=106 style='mso-width-source:userset;mso-width-alt:3876;
 width:80pt'>
 <col class=xl25 width=129 style='mso-width-source:userset;mso-width-alt:4717;
 width:97pt'>
 <tr height=53 style='mso-height-source:userset;height:39.75pt'>
  <td height=53 width=36 style='height:39.75pt;width:27pt' align=left
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
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:3pt;margin-top:3pt;width:90pt;height:33.75pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_Com.Rows[0][3].ToString()%>&table_name=tco_bpphoto" o:title="image001"
    croptop="1040f" cropbottom="4161f" cropright="2389f"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:4px;margin-top:4px;width:304px;
  height:45px'><img width=304 height=45
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_Com.Rows[0][3].ToString()%>&table_name=tco_bpphoto" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=53 class=xl25 width=36 style='height:39.75pt;width:27pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl25 width=100 style='width:75pt'></td>
  <td class=xl57  width=70 colspan=3 style='width:53pt;'><% = dt_Com.Rows[0][0].ToString()%> <br>
                    <% = dt_Com.Rows[0][1].ToString()%>    </td>
  
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=76 style='width:57pt'></td>
  <td class=xl25 width=106 style='width:80pt'></td>
  <td class=xl25 width=129 style='width:97pt'></td>
 </tr>
 <tr height=43 style='mso-height-source:userset;height:32.25pt'>
  <td colspan=8 height=43 class=xl47 width=665 style='height:32.25pt;
  width:499pt'>DANH SÁCH ĐĂNG KÝ TĂNG CA</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td colspan=8 height=33 class=xl48 width=665 style='height:24.75pt;
  width:499pt'>( OVERTIME REGISTER )</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=2 class=xl25 style='height:14.1pt;mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=2 height=29 class=xl52 style='height:21.75pt'>Ngày (Date) :</td>
  <td colspan=2 class=xl49><%=p_dt %></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl50 colspan=3 style='height:23.25pt;mso-ignore:colspan'>Bộ
  phận (Depart<span style='display:none'>ment): <%=dt_total.Rows[0][0].ToString() %></span></td>
  <td colspan=2 class=xl40>Chuyền (Group) :</td>
  <td class=xl50 x:str><%=dt_total.Rows[0][1].ToString() %></span></td>
  
 </tr>
 <tr height=51 style='mso-height-source:userset;height:38.25pt'>
  <td height=51 class=xl27 width=36 style='height:38.25pt;border-top:none;
  width:27pt'>STT<br>
    (No)</td>
  <td class=xl28 width=100 style='border-top:none;width:75pt'>Mã số CNV<br>
    (Epm ID)</td>
  <td class=xl28 width=193 style='width:145pt'>Họ Và Tên<br>
    (Full Name)</td>
  <td class=xl28 width=70 style='border-top:none;width:53pt'>Vị trí<br>
    (Position)</td>
  <td class=xl28 width=63 style='border-top:none;width:47pt'>Công việc<br>
    (Job)</td>
  <td colspan=2 class=xl41 width=127 style='border-right:.5pt solid black;
  border-left:none;width:95pt'>Thời gian làm việc<br>
    (Working time)</td>
  <td class=xl29 width=76 style='width:57pt'>Tổng giờ tăng ca<br>
    (Total OT)</td>
  <td class=xl28 width=106 style='width:80pt'>Chữ ký<br>
    (Sign)</td>
  <td class=xl28 width=129 style='width:97pt'>Điều chỉnh khác<br>
    (Adjustment)</td>
 </tr>
 <%
    int i;
    for(i=0;i<irow; i++)
    {
  %>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl30 style='height:19.5pt' x:num><%=i+1 %></td>
  <td class=xl31><%=dt_total.Rows[i][2].ToString() %></td>
  <td class=xl32><%=dt_total.Rows[i][3].ToString() %></td>
  <td class=xl32><%=dt_total.Rows[i][4].ToString() %></td>
  <td class=xl32><%=dt_total.Rows[i][5].ToString() %></td>
  <td class=xl33 x:num="0.6875">16:30</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
 </tr>
 <%
    }
  %>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=2 class=xl25 style='height:11.25pt;mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 rowspan=2 height=56 class=xl42 width=136 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:42.0pt;width:102pt'>Tổng
  Hợp <br>
    (Summary)</td>
  <td class=xl35>Từ 16:30 đến 18:30</td>
  <td colspan=5 class=xl36 style='border-right:.5pt solid black;border-left:
  none'>Từ 16:30 đến 20:30</td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none'>Không đăng ký</td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl32 style='height:24.0pt'>&nbsp;</td>
  <td colspan=5 class=xl37 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=2 class=xl37 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:29.1pt'>
  <td height=38 colspan=2 class=xl25 style='height:29.1pt;mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:group id="_x0000_s1039"
   style='position:absolute;margin-left:8.25pt;margin-top:18pt;width:463.5pt;
   height:112.5pt;z-index:2' coordorigin="122,376" coordsize="590,150">
   <o:lock v:ext="edit" text="t"/>
   <v:rect id="_x0000_s1027" style='position:absolute;left:122;top:376;width:590;
    height:149' o:regroupid="3" fillcolor="window [65]" strokecolor="windowText [64]"
    o:insetmode="auto"/>
   <v:line id="_x0000_s1028" style='position:absolute' from="122,421" to="712,421"
    o:regroupid="3" strokecolor="windowText [64]" o:insetmode="auto"/>
   <v:line id="_x0000_s1029" style='position:absolute' from="418,376" to="418,525"
    o:regroupid="3" strokecolor="windowText [64]" o:insetmode="auto"/>
   <v:line id="_x0000_s1030" style='position:absolute' from="265,376" to="265,526"
    o:regroupid="3" strokecolor="windowText [64]" o:insetmode="auto"/>
   <v:line id="_x0000_s1031" style='position:absolute' from="562,376" to="562,526"
    o:regroupid="3" strokecolor="windowText [64]" o:insetmode="auto"/>
   <v:shapetype id="_x0000_t202" coordsize="21600,21600" o:spt="202" path="m,l,21600r21600,l21600,xe">
    <v:stroke joinstyle="miter"/>
    <v:path gradientshapeok="t" o:connecttype="rect"/>
   </v:shapetype><v:shape id="_x0000_s1032" type="#_x0000_t202" style='position:absolute;
    left:128;top:382;width:118;height:34;mso-wrap-style:tight' o:regroupid="3"
    fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
    o:insetmode="auto">
    <v:textbox style='mso-direction-alt:auto'>
     <div style='text-align:center'><font class="font9">Tổ Trưởng<br>
          Leader</font></div>
    </v:textbox>
    <x:ClientData ObjectType="Text">
     <x:TextHAlign>Center</x:TextHAlign>
    </x:ClientData>
   </v:shape><v:shape id="_x0000_s1033" type="#_x0000_t202" style='position:absolute;
    left:276;top:379;width:116;height:37;mso-wrap-style:tight' o:regroupid="3"
    fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
    o:insetmode="auto">
    <v:textbox style='mso-direction-alt:auto'>
     <div style='text-align:center'><font class="font9">Trưởng Bộ Phận<br>
          Supervisor</font></div>
    </v:textbox>
    <x:ClientData ObjectType="Text">
     <x:TextHAlign>Center</x:TextHAlign>
    </x:ClientData>
   </v:shape><v:shape id="_x0000_s1034" type="#_x0000_t202" style='position:absolute;
    left:431;top:380;width:121;height:37;mso-wrap-style:tight' o:regroupid="3"
    fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
    o:insetmode="auto">
    <v:textbox style='mso-direction-alt:auto'>
     <div style='text-align:center'><font class="font9">Quản lý Bộ Phận<br>
          Section Manager</font></div>
    </v:textbox>
    <x:ClientData ObjectType="Text">
     <x:TextHAlign>Center</x:TextHAlign>
    </x:ClientData>
   </v:shape><v:shape id="_x0000_s1035" type="#_x0000_t202" style='position:absolute;
    left:574;top:381;width:124;height:37;mso-wrap-style:tight' o:regroupid="3"
    fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
    o:insetmode="auto">
    <v:textbox style='mso-direction-alt:auto'>
     <div style='text-align:center'><font class="font9">Giám đốc xưởng<br>
          Factory Manager</font></div>
    </v:textbox>
    <x:ClientData ObjectType="Text">
     <x:TextHAlign>Center</x:TextHAlign>
    </x:ClientData>
   </v:shape></v:group><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:10px;margin-top:23px;width:620px;
  height:152px'><img width=620 height=152
  src="rpt_register_ot_poongin_files/image003.gif" v:shapes="_x0000_s1039 _x0000_s1027 _x0000_s1028 _x0000_s1029 _x0000_s1030 _x0000_s1031 _x0000_s1032 _x0000_s1033 _x0000_s1034 _x0000_s1035"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=38 class=xl26 width=193 style='height:29.1pt;width:145pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:29.1pt'>
  <td height=38 colspan=2 class=xl25 style='height:29.1pt;mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:29.1pt'>
  <td height=38 colspan=2 class=xl25 style='height:29.1pt;mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:29.1pt'>
  <td height=38 colspan=2 class=xl25 style='height:29.1pt;mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:29.1pt'>
  <td height=38 colspan=2 class=xl25 style='height:29.1pt;mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=36 style='width:27pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=193 style='width:145pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=129 style='width:97pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
