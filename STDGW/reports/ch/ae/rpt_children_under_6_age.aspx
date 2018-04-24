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
        ",c.org_nm a2 " +
        ",b.org_nm a3 " +
        ",(select v.code_nm from vhr_hr_code v where  v.id='HR0008' and v.code=a.pos_type) a4 " +
        ",nvl(t.child_no,1) a5 " +
        ",(select v.code_nm from vhr_hr_code v where  v.id='HR0007' and v.code=a.sex) a6 " +
        ",nvl(t.birth_no,0) a7 " +
        ",to_char(to_date(t.START_DT,'yyyymmdd'),'dd/mm/yyyy') a8 " +
        ",round( months_between(to_date('" + p_from_regdate + "','yyyymmdd'),to_date(t.start_dt,'yyyymmdd'))/12,2) a9 " +
        " from thr_regulation t,thr_employee a,tco_org b,tco_org c " +
        "where t.del_if=0  and a.del_if=0 and b.del_if=0 and c.del_if=0  " +
        "and t.thr_emp_pk=a.pk and a.tco_org_pk=b.pk and b.p_pk=c.pk " +
        "and (('" + p_from_regdate + "' between t.start_dt and  t.end_dt_6a )) " +
        " and t.kind in ('02','03') " +
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
        " order by b.org_nm,a.emp_id,t.start_dt " ;

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
<link rel=File-List href="rpt_children_under_6_age_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_children_under_6_age_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_children_under_6_age_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>nobland</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2007-03-21T03:12:27Z</o:LastPrinted>
  <o:Created>2007-03-09T02:05:06Z</o:Created>
  <o:LastSaved>2012-07-17T06:39:09Z</o:LastSaved>
  <o:Company>nobland</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-header-data:"&LNOBLAND VIETNAM  CO\,\.LTD";
	mso-footer-data:"Page &P of &N";
	margin:.38in .17in .39in .33in;
	mso-header-margin:.17in;
	mso-footer-margin:.17in;
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
	font-family:"MS Sans Serif";
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
	font-family:"MS Sans Serif";
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl29
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
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:justify;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:justify;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:justify;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:VNI-Helve-Condense;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:VNI-Helve-Condense;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:VNI-Helve-Condense;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	color:red;
	font-size:8.0pt;
	font-family:VNI-Helve-Condense;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	color:red;
	font-size:8.0pt;
	font-family:VNI-Helve-Condense;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"0\.0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:VNI-Helve-Condense;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:0000;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:VNI-Helve-Condense;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:0000;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:VNI-Helve-Condense;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:0000;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style0;
	font-size:8.5pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl47
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:justify;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>DUOI6</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
      </x:Pane>
     </x:Panes>
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
  <x:Formula>=DUOI6!$4:$5</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>tblEmployeeInfo</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="6145"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="3"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=fuchsia>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1017 style='border-collapse:
 collapse;table-layout:fixed;width:763pt'>
 <col width=34 style='mso-width-source:userset;mso-width-alt:1243;width:26pt'>
  <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=184 style='mso-width-source:userset;mso-width-alt:6729;width:138pt'>
 <col width=136 style='mso-width-source:userset;mso-width-alt:4973;width:102pt'>
 <col width=128 style='mso-width-source:userset;mso-width-alt:4681;width:96pt'>
 <col width=119 style='mso-width-source:userset;mso-width-alt:4352;width:89pt'>
 <col width=71 span=2 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col width=66 style='mso-width-source:userset;mso-width-alt:2413;width:50pt'>
 <col width=77 style='mso-width-source:userset;mso-width-alt:2816;width:58pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <tr height=77 style='mso-height-source:userset;height:57.75pt'>
  <td colspan=11 height=77 width=1017 style='height:57.75pt;width:763pt'
  align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t136"
   coordsize="21600,21600" o:spt="136" adj="10800" path="m@7,l@8,m@5,21600l@6,21600e">
   <v:formulas>
    <v:f eqn="sum #0 0 10800"/>
    <v:f eqn="prod #0 2 1"/>
    <v:f eqn="sum 21600 0 @1"/>
    <v:f eqn="sum 0 0 @2"/>
    <v:f eqn="sum 21600 0 @3"/>
    <v:f eqn="if @0 @3 0"/>
    <v:f eqn="if @0 21600 @1"/>
    <v:f eqn="if @0 0 @2"/>
    <v:f eqn="if @0 @4 21600"/>
    <v:f eqn="mid @5 @6"/>
    <v:f eqn="mid @8 @5"/>
    <v:f eqn="mid @7 @8"/>
    <v:f eqn="mid @6 @7"/>
    <v:f eqn="sum @6 0 @5"/>
   </v:formulas>
   <v:path textpathok="t" o:connecttype="custom" o:connectlocs="@9,0;@10,10800;@11,21600;@12,10800"
    o:connectangles="270,180,90,0"/>
   <v:textpath on="t" fitshape="t"/>
   <v:handles>
    <v:h position="#0,bottomRight" xrange="6629,14971"/>
   </v:handles>
   <o:lock v:ext="edit" text="t" shapetype="t"/>
  </v:shapetype><v:shape id="_x0000_s3073" type="#_x0000_t136" style='position:absolute;
   direction:LTR;text-align:left;margin-left:578.25pt;margin-top:25.5pt;
   width:180.75pt;height:29.25pt;z-index:1' fillcolor="#b2b2b2" strokecolor="#33c"
   strokeweight="1pt" o:insetmode="auto">
   <v:fill opacity=".5"/>
   <v:shadow on="t" color="#99f" offset="3pt"/>
   <v:textpath style='font-family:"Arial";font-size:24pt;v-text-kern:t' trim="t"
    fitpath="t" string="THÁNG 03-2012"/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:770px;margin-top:33px;width:246px;
  height:43px'><img width=246 height=43
  src="rpt_children_under_6_age_files/image001.gif" alt="THÁNG 03-2012" v:shapes="_x0000_s3073"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=11 height=77 class=xl47 width=1017 style='height:57.75pt;
    width:763pt'>LIST OF FEMALE WORKER HAVE CHILD UNDER 6 YEARS</td>
   </tr>
  </table>
  </span></td>
 </tr>
 <tr height=34 style='height:25.5pt'>
  <td colspan=11 height=34 class=xl48 width=1017 style='height:25.5pt;
  width:763pt'>(DANH SÁCH NỮ CÔNG NHÂN VIÊN CÓ CON NHỎ DƯỚI 6 TUỔI )</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl24 colspan=2 align=left style='mso-ignore:colspan'>Up date:
  <%=DateTime.Now.ToString("dd-MMM-yyyy")%></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl25 width=34 style='height:27.75pt;width:26pt'>NO.</td>
  <td class=xl26 width=63 style='width:47pt'>CODE</td>
  <td class=xl26 width=184 style='width:138pt'>FULL NAME</td>
  <td class=xl26 width=136 style='width:102pt'>DEPT.</td>
  <td class=xl26 width=128 style='width:96pt'>SECTION</td>
  <td class=xl26 width=119 style='width:89pt'>POSITION</td>
  <td class=xl26 width=71 style='width:53pt'>NO. CHILDREN</td>
  <td class=xl26 width=71 style='width:53pt'>SEX</td>
  <td class=xl26 width=66 style='width:50pt' x:str="NO. BIRTHDAY ">NO.
  BIRTHDAY<span style='mso-spacerun:yes'> </span></td>
  <td class=xl26 width=77 style='width:58pt' x:str="BIRTHDAY ">BIRTHDAY<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl26 width=68 style='width:51pt' x:str="NO. AGE ">NO. AGE<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl27 style='height:22.5pt'>Stt</td>
  <td class=xl28 width=63 style='width:47pt'>Msnv</td>
  <td class=xl28 width=184 style='width:138pt'>Họ và tên</td>
  <td class=xl28 width=136 style='width:102pt'>Phòng ban</td>
  <td class=xl28 width=128 style='width:96pt'>Bộ phận</td>
  <td class=xl28 width=119 style='width:89pt'>Chức vụ</td>
  <td class=xl29>Số con</td>
  <td class=xl29>Giới tính</td>
  <td class=xl28 width=66 style='width:50pt'>Số lần sinh</td>
  <td class=xl28 width=77 style='width:58pt' x:str="Ngày sinh   ">Ngày
  sinh<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl30><%=p_from_regdate_text %></td>
 </tr>
 <% 
    string semp_cur,semp_old;
    int sdif=0,icnt=0,icnt_chil=1,icnt_chil_all=0;
     for (int i = 0; i < irow; i++) 
    {
        
        sdif=0;
        icnt_chil_all+=int.Parse(dt_total.Rows[i]["a5"].ToString());
        semp_cur=dt_total.Rows[i]["a0"].ToString();
       if (i==0)
       {
            sdif=1;
            icnt++;
        }
       else
            if (dt_total.Rows[i]["a0"].ToString() !=dt_total.Rows[i-1]["a0"].ToString())
            {
               sdif=1;
               icnt++;
               icnt_chil=1;
            }
            else
            {
                icnt_chil++;
            }
    %> 
    
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
 <% if (sdif==1) 
 {%>
  <td height=23 class=xl31 style='height:17.25pt;border-bottom:none' x:num><%=icnt %></td>
  <td class=xl33 style="white-space:nowrap;mso-text-control:shrinktofit;border-bottom:none"><%=dt_total.Rows[i]["a0"].ToString() %></td>
  <td class=xl33 style="border-bottom:none"><%=dt_total.Rows[i]["a1"].ToString() %></td>
  <td class=xl33 style="border-bottom:none"><%=dt_total.Rows[i]["a2"].ToString() %></td>
  <td class=xl33 style="border-bottom:none"><%=dt_total.Rows[i]["a3"].ToString() %></td>
  <td class=xl33 style="border-bottom:none"><%=dt_total.Rows[i]["a4"].ToString() %></td>
  <%}
  else
  {
   %>
  <td height=23 class=xl31 style='height:17.25pt' x:num></td>
  <td class=xl32 >&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <%} %>
  <td class=xl34 x:num><%=dt_total.Rows[i]["a5"].ToString() %></td>
  <td class=xl34><%=dt_total.Rows[i]["a6"].ToString() %></td>
  <td class=xl34 x:num><%=icnt_chil %></td>
  <td class=xl35><%=dt_total.Rows[i]["a8"].ToString() %></td>
  <td class=xl36 align=right x:num><%=dt_total.Rows[i]["a9"].ToString() %></td>
 </tr>
 <%} %>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=6 height=29 class=xl42 width=664 style='border-right:.5pt solid black;
  height:21.75pt;width:498pt'>TOTAL:<%=icnt %> PEOPLE</td>
  <td class=xl37 x:num><%=icnt_chil_all %></td>
  <td class=xl38>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=11 height=17 class=xl45 style='height:12.75pt'>Report by<span
  style='mso-spacerun:yes'>                                        
  </span>Checked by<span
  style='mso-spacerun:yes'>                                  </span>Confirmed
  by<span style='mso-spacerun:yes'>                               </span>Confirmed
  by<span style='mso-spacerun:yes'>                                      
  </span>Confirmed by<span style='mso-spacerun:yes'>                        
  </span>Approved by</td>
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
 <tr height=17 style='height:12.75pt'>
  <td colspan=11 height=17 class=xl45 style='height:12.75pt'>NGUYỄN THỊ QUỲNH
  NY<span style='mso-spacerun:yes'>            </span>PHẠM NGỌC DŨNG<span
  style='mso-spacerun:yes'>                        </span>KIM KWANG JO<span
  style='mso-spacerun:yes'>                                </span>MR LIM<span
  style='mso-spacerun:yes'>                                                 
  </span>MR MOON<span style='mso-spacerun:yes'>                         
  </span>PARK SANG MAN</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=11 height=17 class=xl46 align=left style='height:12.75pt'>ADMIN -
  HR STAFF<span style='mso-spacerun:yes'>                    </span>ADMIN - HR
  SUPERVISOR<span style='mso-spacerun:yes'>                      
  </span>FACTORY MANAGER<span style='mso-spacerun:yes'>                    
  </span>OFFICE MANAGER<span
  style='mso-spacerun:yes'>                               </span>GENERAL
  DIRECTOR<span style='mso-spacerun:yes'>                  </span>GENERAL
  DIRECTOR</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=34 style='width:26pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=184 style='width:138pt'></td>
  <td width=136 style='width:102pt'></td>
  <td width=128 style='width:96pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=68 style='width:51pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
