﻿<%@ Page Language="C#"%>
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
    
    string p_dept, p_master, p_detail, p_dtFrom, p_dtTo; 
     
  
    p_dept       = Request["l_dept"].ToString();
    p_master      = Request["l_master"].ToString();
    p_detail      = Request["l_detail"].ToString();
    p_dtFrom       = Request["l_dtFrom"].ToString();
    p_dtTo         = Request["l_dtTo"].ToString();



   string SQL
    = "select 1 " + 
        "    ,a.FULL_NAME fullname_01 " +
        "    ,to_char(to_date(a.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy') birth_02 " +
        "    ,a.SEX sex_03 " +
        "    ,(select v.code_nm from vhr_hr_code v where v.id='HR0011' and v.code = a.EDU_TYPE) as edu_04 " +
        "    ,(select v.code_nm from vhr_hr_code v where v.id='HR0008' and v.code = a.POS_TYPE ) as pos_05 " +
        "    ,c.org_nm org_06 " +
        "    ,c1.org_nm org_07 " +
        "    ,c2.org_nm  org_08 " +
        "    ,to_char(to_date(a.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') join_dt_09 " +
        "    ,a.TEL telephone_10 " +
        "    ,(select a.app_no||' - '|| (SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0008' AND V.CODE=B.POS_TYPE ) from THR_REC_REQUEST a,THR_REC_REQUEST_detail b where a.del_if=0 and b.del_if=0 and a.PK=b.THR_REC_REQUEST_PK  and b.pk=e.THR_REC_REQUEST_DT_PK) request_nm_11 " +
        "    ,(select to_char(to_date(a.FROM_DT,'yyyymmdd'),'dd/mm/yyyy') from THR_REC_REQUEST a,THR_REC_REQUEST_detail b where a.del_if=0 and b.del_if=0 and a.PK=b.THR_REC_REQUEST_PK  and b.pk=e.THR_REC_REQUEST_DT_PK) as from_dt_12 " +
        "    ,(select to_char(to_date(a.TO_DT,'yyyymmdd'),'dd/mm/yyyy') from THR_REC_REQUEST a,THR_REC_REQUEST_detail b where a.del_if=0 and b.del_if=0 and a.PK=b.THR_REC_REQUEST_PK  and b.pk=e.THR_REC_REQUEST_DT_PK) as to_dt_13 " +
        "    ,(select g.full_name from thr_employee g where g.del_if=0 and g.pk = e.interviewer2_pk) int_14 " +
        "    ,(select g.full_name from thr_employee g where g.del_if=0 and g.pk = e.interviewer3_pk) int_15  " +
        "from thr_employee a, thr_rec_emp e, thr_rec_request_detail d , comm.tco_org c, comm.tco_org c1, comm.tco_org c2  " +
        "where a.del_if=0 and c.del_if=0 and c1.del_if=0 and c2.del_if=0 and e.del_if=0 and d.del_if=0  " +
        "    and a.THR_REC_EMP_PK = e.pk " +
        "    and e.thr_rec_request_dt_pk = d.pk " +
        "    and c.pk = a.tco_org_pk " +
        "    and c.p_pk = c1.pk and c1.p_pk = c2.pk " +
        "    and a.join_dt between '" + p_dtFrom + "' and '" + p_dtTo + "' "  +
        "    and a.THR_REC_EMP_PK is not null " +
        "           and (a.tco_org_pk in ( " +
        "                              SELECT     g.pk " +
        "                                    FROM comm.tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_dept + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_dept + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_dept + "' = 'ALL') " +
        " and decode('" + p_master + "','ALL','ALL',d.thr_rec_request_pk)='" + p_master + "'" +
        " and decode('" + p_detail + "','ALL','ALL',d.pk)='" + p_detail + "'" +
        "    order by 14,2 " ;





   //Response.Write(SQL);
   //Response.End();

    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
   
    if (irow_emp == 0)
    {
        Response.Write("There is no data of salary");
        Response.End();
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_rec_employee_list_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_rec_employee_list_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_rec_employee_list_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>welcome</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:Created>2011-08-02T07:22:43Z</o:Created>
  <o:LastSaved>2011-08-02T07:23:23Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
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
.font5
	{color:windowtext;
	font-size:20.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font8
	{color:windowtext;
	font-size:18.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font10
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
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
.style21
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
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet1;}
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
.xl25
	{mso-style-parent:style21;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style21;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;}
.xl28
	{mso-style-parent:style21;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl29
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl33
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl34
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl35
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl37
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	mso-number-format:"\@";}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
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
  <x:WindowWidth>20115</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1720 style='border-collapse:
 collapse;table-layout:fixed;width:1295pt'>
 <col width=34 style='mso-width-source:userset;mso-width-alt:1243;width:26pt'>
 <col width=186 style='mso-width-source:userset;mso-width-alt:6802;width:140pt'>
 <col class=xl42 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col width=53 style='mso-width-source:userset;mso-width-alt:1938;width:40pt'>
 <col width=125 style='mso-width-source:userset;mso-width-alt:4571;width:94pt'>
 <col width=101 style='mso-width-source:userset;mso-width-alt:3693;width:76pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=102 style='mso-width-source:userset;mso-width-alt:3730;width:77pt'>
 <col width=121 style='mso-width-source:userset;mso-width-alt:4425;width:91pt'>
 <col class=xl42 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl42 width=99 style='mso-width-source:userset;mso-width-alt:3620;
 width:74pt'>
 <col class=xl42 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl42 width=117 style='mso-width-source:userset;mso-width-alt:4278;
 width:88pt'>
 <col class=xl42 width=86 span=2 style='mso-width-source:userset;mso-width-alt:
 3145;width:65pt'>
 <col width=133 span=2 style='mso-width-source:userset;mso-width-alt:4864;
 width:100pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 width=34 style='height:12.75pt;width:26pt'></td>
  <td width=186 style='width:140pt'></td>
  <td class=xl42 width=83 style='width:62pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=121 style='width:91pt'></td>
  <td class=xl42 width=86 style='width:65pt'></td>
  <td class=xl42 width=99 style='width:74pt'></td>
  <td class=xl42 width=86 style='width:65pt'></td>
  <td class=xl42 width=117 style='width:88pt'></td>
  <td class=xl42 width=86 style='width:65pt'></td>
  <td class=xl42 width=86 style='width:65pt'></td>
  <td width=133 style='width:100pt'></td>
  <td width=133 style='width:100pt'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 style='height:27.0pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
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
  </v:shapetype><v:shape id="Picture_x0020_1" o:spid="_x0000_s1025" type="#_x0000_t75"
   alt="Hyosung" style='position:absolute;margin-left:2.25pt;margin-top:1.5pt;
   width:23.25pt;height:21.75pt;z-index:1;visibility:visible'>
   <v:imagedata src="rpt_rec_employee_list_files/image001.jpg" o:title="Hyosung"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:3px;margin-top:2px;width:31px;
  height:29px'><img width=31 height=29
  src="rpt_rec_employee_list_files/image002.jpg" alt=Hyosung v:shapes="Picture_x0020_1"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=36 class=xl25 width=34 style='height:27.0pt;width:26pt'><span
    style='mso-spacerun:yes'> </span></td>
   </tr>
  </table>
  </span></td>
  <td class=xl26 colspan=3 style='mso-ignore:colspan'>CÔNG TY TNHH HYOSUNG
  VI&#7878;T NAM</td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=2 class=xl25 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=67 style='mso-height-source:userset;height:50.25pt'>
  <td colspan=16 height=67 class=xl28 width=1587 style='height:50.25pt;
  width:1195pt'>DANH SÁCH NH&#7852;N VI&#7878;C T&#7914; NGÀY <%= p_dtFrom.Substring(6,2).ToString() %>/<%= p_dtFrom.Substring(4,2).ToString() %>/<%= p_dtFrom.Substring(0,4).ToString() %>
  &#272;&#7870;N NGÀY <%= p_dtTo.Substring(6,2).ToString() %>/<%= p_dtTo.Substring(4,2).ToString() %>/<%= p_dtTo.Substring(0,4).ToString() %> <font class="font5"><br>
    </font><font class="font8">New comer list from <%= p_dtFrom.Substring(6,2).ToString() %>/<%= p_dtFrom.Substring(4,2).ToString() %>/<%= p_dtFrom.Substring(0,4).ToString() %> to <%= p_dtTo.Substring(6,2).ToString() %>/<%= p_dtTo.Substring(4,2).ToString() %>/<%= p_dtTo.Substring(0,4).ToString() %></font></td>
  <td class=xl28></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=10 height=28 class=xl29 style='height:21.0pt'>&nbsp;</td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl36 height=67 style='mso-height-source:userset;height:50.25pt'>
  <td height=67 class=xl32 width=34 style='height:50.25pt;border-top:none;
  width:26pt'>TT<br>
    <font class="font10">No</font></td>
  <td class=xl32 width=186 style='border-top:none;border-left:none;width:140pt'>H&#7885;
  và Tên <br>
    <font class="font10">Full - name</font></td>
  <td class=xl33 width=83 style='border-top:none;border-left:none;width:62pt'>Ngày
  sinh<br>
    <font class="font10">DOB</font></td>
  <td class=xl34 width=53 style='border-top:none;border-left:none;width:40pt'>Gi&#7899;i
  tính<br>
    <font class="font10">Sex</font></td>
  <td class=xl32 width=125 style='border-top:none;border-left:none;width:94pt'>Trình
  &#273;&#7897; <br>
    <font class="font10">Education</font></td>
  <td class=xl32 width=101 style='border-top:none;border-left:none;width:76pt'>Ch&#7913;c
  v&#7909;<br>
    Position</td>
  <td class=xl35 width=89 style='border-top:none;border-left:none;width:67pt'>Job
  Group</td>
  <td class=xl35 width=102 style='border-top:none;border-left:none;width:77pt'>Department</td>
  <td class=xl35 width=121 style='border-top:none;border-left:none;width:91pt'>Part</td>
  <td class=xl33 width=86 style='border-top:none;border-left:none;width:65pt'>Ngày
  vào Cty<br>
    <font class="font10">Join Date</font></td>
  <td class=xl32 width=99 style='border-left:none;width:74pt'>S&#7889;
  &#273;i&#7879;n tho&#7841;i <br>
    Tel. No</td>
  <td class=xl33 width=86 style='border-left:none;width:65pt'>Ký tên<br>
    <font class="font10">Signature</font></td>
  <td class=xl33 width=117 style='border-left:none;width:88pt'>&#272;&#7907;t
  tuy&#7875;n d&#7909;ng<br>
    Recruitment</td>
  <td class=xl33 width=86 style='border-left:none;width:65pt'>Ngày b&#7855;t
  &#273;&#7847;u<br>
    Start date</td>
  <td class=xl33 width=86 style='border-left:none;width:65pt'>Ngày k&#7871;t
  thúc<br>
    End date</td>
  <td class=xl32 width=133 style='border-left:none;width:100pt'>Ng&#432;&#7901;i
  ph&#7887;ng v&#7845;n 2<br>
    Interviewer 2</td>
  <td class=xl32 width=133 style='border-left:none;width:100pt'>Ng&#432;&#7901;i
  ph&#7887;ng v&#7845;n 3<br>
    Interviewer 3</td>
 </tr>
 <%
    int count = 0;
    for (int i = 0; i < irow_emp; i++)
     {
        count++;
  %>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl37 style='height:23.25pt;border-top:none' x:num><%= count %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][1].ToString() %></td>
  <td class=xl39 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][2].ToString() %></td>
  <td class=xl40 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][3].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][4].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][5].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][6].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][7].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][8].ToString() %></td>
  <td class=xl41 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][9].ToString() %></td>
  <td class=xl41 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][10].ToString() %></td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][11].ToString() %></td>
  <td class=xl41 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][12].ToString() %></td>
  <td class=xl41 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][13].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][14].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][15].ToString() %></td>
 </tr>
 <% } %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=34 style='width:26pt'></td>
  <td width=186 style='width:140pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=133 style='width:100pt'></td>
  <td width=133 style='width:100pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
