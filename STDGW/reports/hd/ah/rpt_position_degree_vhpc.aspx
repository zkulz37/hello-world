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

string p_to,p_org,p_status,p_nation;    

        p_to = Request["p_to"].ToString();
		p_org = Request["p_org"].ToString();
		p_status = Request["p_status"].ToString();
		p_nation = Request["p_nation"].ToString();

        string SQL
            = "select decode((select c.org_nm from comm.tco_org c where c.del_if=0 and nvl(b.p_pk,b.pk) = c.pk),'OFFICE','OFFICE','FACTORY') as col0 " + 
                ",b.org_nm " +
                ",(select code_nm from vhr_hr_code where id='HR0008' and code = a.POS_TYPE) as position " +
                ",sum(decode(a.SEX,'M',1,0)) as male " +
                ",sum(decode(a.SEX,'F',1,0)) as female " +
                ",sum(decode(a.SEX,'M',1,0) + decode(a.SEX,'F',1,0)) total_sex " +
                ",sum(decode(a.EDU_TYPE,'03',1,0)) as secondary " +
                ",sum(decode(a.EDU_TYPE,'09',1,0)) as highschool " +
                ",sum(decode(a.EDU_TYPE,'04',1,0)) as vocation " +
                ",sum(decode(a.EDU_TYPE,'01',1,0)) as intemediate " +
                ",sum(decode(a.EDU_TYPE,'05',1,0)) as college " +
                ",sum(decode(a.EDU_TYPE,'06',1,0)) as university " +
                ",sum(decode(a.EDU_TYPE,'07',1,0)) as masters " +
                ",sum(decode(a.EDU_TYPE,'02',1,0)) as doctor " +
                ",sum(case when a.EDU_TYPE in ('03','09','04','01','05','06','07','02') then 1 else 0 end) as summar " +
                "from thr_employee a, comm.tco_org b " +
                "where a.del_if=0 and b.del_if=0 " +
                "and a.TCO_ORG_PK = b.PK " +
                "and a.JOIN_DT <= '"+ p_to +"' " +
                "and Decode('"+ p_status +"','ALL','ALL', a.STATUS )= '"+ p_status +"' " +
	            "and Decode('"+ p_nation +"','ALL','ALL', a.NATION )= '"+ p_nation +"' " +
	            " and (a.tco_org_pk in ( " +
                "                              SELECT     g.pk " +
                "                                    FROM comm.tco_org g " +
                "                                   WHERE g.del_if = 0 " +
                "                              START WITH g.pk = " +
                "                                            DECODE ('" + p_org + "', " +
                "                                                    'ALL', 0, " +
                "                                                    '" + p_org + "' " +
                "                                                   ) " +
                "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
                "                        OR '" + p_org + "' = 'ALL') " +
                "group by b.ORG_NM, a.POS_TYPE, b.pk, b.p_pk, a.TCO_ORG_PK, a.EMPLOYEE_TYPE " +
                "order by a.EMPLOYEE_TYPE, b.ORG_NM, (select nvl(num_1,0) from vhr_hr_code where id='HR0008' and code = a.POS_TYPE) " ;


    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp=dt_Emp.Columns.Count;
    if (irow_emp == 0)
    {
        Response.Write("There is no data of salary");
        Response.End();
    }

    string SQL_Dept
            = "select te.org_nm, sum(num) from " + 
                "(select a.EMPLOYEE_TYPE as emp_type, b.ORG_NM as org_nm, 1 as num  " +
                "from thr_employee a, comm.tco_org b " +
                "where a.del_if=0 and b.del_if=0 " +
                "and a.TCO_ORG_PK = b.PK " +
                "and a.JOIN_DT <= '"+ p_to +"' " +
                "and Decode('"+ p_status +"','ALL','ALL', a.STATUS )= '"+ p_status +"' " +
	            "and Decode('"+ p_nation +"','ALL','ALL', a.NATION )= '"+ p_nation +"' " +
	            " and (a.tco_org_pk in ( " +
                "                              SELECT     g.pk " +
                "                                    FROM comm.tco_org g " +
                "                                   WHERE g.del_if = 0 " +
                "                              START WITH g.pk = " +
                "                                            DECODE ('" + p_org + "', " +
                "                                                    'ALL', 0, " +
                "                                                    '" + p_org + "' " +
                "                                                   ) " +
                "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
                "                        OR '" + p_org + "' = 'ALL') " +
                "group by b.ORG_NM, a.POS_TYPE, a.EMPLOYEE_TYPE  " +
                "order by a.EMPLOYEE_TYPE, b.ORG_NM  " +
                ") te " +
                "group by te.org_nm, te.emp_type " +
                "order by te.emp_type, te.org_nm " ;
        
        DataTable dt_dept = ESysLib.TableReadOpen(SQL_Dept);

    //----- Day info--
    string SQL_Day
    = "select " +
        "to_char(to_date('" + p_to + "','YYYYMMDD'),'DD/MM/YYYY') as d1 " +
        ",to_char(sysdate,'dd/mm/yyyy') as d2 " +
        "from dual ";

    DataTable dt_Day = ESysLib.TableReadOpen(SQL_Day);
 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_position_degree_vhpc_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_position_degree_vhpc_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_position_degree_vhpc_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>HR_PHU</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-05-07T01:40:23Z</o:LastPrinted>
  <o:Created>2011-02-08T01:52:52Z</o:Created>
  <o:LastSaved>2011-05-07T01:40:45Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in 0in .25in 0in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;
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
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
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
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl81
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
	border-left:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl84
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
	border-left:.5pt solid windowtext;}
.xl85
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
	border-left:none;}
.xl86
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
	border-left:none;}
.xl87
	{mso-style-parent:style0;
	font-size:12.0pt;
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
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl89
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl90
	{mso-style-parent:style0;
	font-size:12.0pt;
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
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl92
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl93
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl94
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
	border-left:.5pt solid windowtext;}
.xl95
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
	border-left:none;}
.xl96
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
	border-left:none;}
.xl97
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl98
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl99
	{mso-style-parent:style0;
	font-size:12.0pt;
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
	white-space:normal;}
.xl100
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Position - Degree </x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>78</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>14</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11760</x:WindowHeight>
  <x:WindowWidth>19095</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="6145"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="4"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl68>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1358 style='border-collapse:
 collapse;table-layout:fixed;width:1025pt'>
 <col class=xl68 width=25 style='mso-width-source:userset;mso-width-alt:914;
 width:19pt'>
 <col class=xl68 width=148 style='mso-width-source:userset;mso-width-alt:5412;
 width:111pt'>
 <col class=xl68 width=159 style='mso-width-source:userset;mso-width-alt:5814;
 width:119pt'>
 <col class=xl68 width=74 span=13 style='mso-width-source:userset;mso-width-alt:
 2706;width:56pt'>
 <col class=xl68 width=64 style='width:48pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 width=25 style='height:15.75pt;width:19pt' align=left
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
  </v:shapetype><v:shape id="Picture_x0020_1" o:spid="_x0000_s4098" type="#_x0000_t75"
   style='position:absolute;margin-left:1.5pt;margin-top:.75pt;width:94.5pt;
   height:30.75pt;z-index:1;visibility:visible'>
   <v:imagedata src="rpt_position_degree_vhpc_files/image001.png" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:2px;margin-top:1px;width:126px;
  height:41px'><img width=126 height=41
  src="rpt_position_degree_vhpc_files/image002.jpg" v:shapes="Picture_x0020_1"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=21 class=xl68 width=25 style='height:15.75pt;width:19pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl68 width=148 style='width:111pt'></td>
  <td class=xl69 colspan=4 width=381 style='mso-ignore:colspan;width:287pt'>POSCO
  VIETNAM<span style='mso-spacerun:yes'>  </span>PROCESSING CENTER CO., LTD</td>
  <td class=xl68 width=74 style='width:56pt'></td>
  <td class=xl68 width=74 style='width:56pt'></td>
  <td class=xl68 width=74 style='width:56pt'></td>
  <td class=xl68 width=74 style='width:56pt'></td>
  <td class=xl68 width=74 style='width:56pt'></td>
  <td class=xl68 width=74 style='width:56pt'></td>
  <td class=xl68 width=74 style='width:56pt'></td>
  <td class=xl68 width=74 style='width:56pt'></td>
  <td class=xl68 width=74 style='width:56pt'></td>
  <td class=xl68 width=74 style='width:56pt'></td>
  <td class=xl68 width=64 style='width:48pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=17 class=xl68 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl70 height=33 style='mso-height-source:userset;height:24.75pt'>
  <td colspan=16 height=33 class=xl89 style='height:24.75pt'>TH&#7888;NG KÊ
  CH&#7912;C V&#7908; - TRÌNH &#272;&#7896; &#272;&#7870;N NGÀY <%= dt_Day.Rows[0][0].ToString() %></td>
  <td class=xl100></td>
 </tr>
 <tr class=xl70 height=33 style='mso-height-source:userset;height:24.75pt'>
  <td colspan=16 height=33 class=xl70 style='height:24.75pt'>STATISTIC POSITION
  - DEGREE TO DATE <%= dt_Day.Rows[0][0].ToString() %></td>
  <td class=xl70></td>
 </tr>
 <tr class=xl70 height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 colspan=17 class=xl70 style='height:24.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl71 height=54 style='mso-height-source:userset;height:40.5pt'>
  <td rowspan=2 height=134 class=xl87 width=25 style='border-bottom:.5pt solid black;
  height:100.5pt;width:19pt'>SttNo</td>
  <td rowspan=2 class=xl87 width=148 style='border-bottom:.5pt solid black;
  width:111pt'>B&#7896; PH&#7852;N DEPARTMENT</td>
  <td rowspan=2 class=xl87 width=159 style='border-bottom:.5pt solid black;
  width:119pt'>CH&#7912;C V&#7908; POSITION</td>
  <td colspan=3 class=xl97 width=222 style='border-right:.5pt solid black;
  border-left:none;width:168pt'>GI&#7898;I TÍNH - GENDER</td>
  <td colspan=9 class=xl97 width=666 style='border-right:.5pt solid black;
  border-left:none;width:504pt'>TRÌNH &#272;&#7896; - DEGREE</td>
  <td rowspan=2 class=xl90 width=74 style='border-bottom:.5pt solid black;
  width:56pt'>GHI CHÚ REMARK</td>
  <td class=xl71></td>
 </tr>
 <tr class=xl71 height=80 style='mso-height-source:userset;height:60.0pt'>
  <td height=80 class=xl79 width=74 style='height:60.0pt;border-left:none;
  width:56pt'>Nam/<br>
    Male</td>
  <td class=xl79 width=74 style='border-left:none;width:56pt'>N&#7919;/<br>
    Female</td>
  <td class=xl79 width=74 style='border-left:none;width:56pt'>T&#7893;ng/<br>
    Total</td>
  <td class=xl79 width=74 style='border-left:none;width:56pt'>PT C&#417;
  S&#7903;/<span style='mso-spacerun:yes'>                 </span>Secondary
  school</td>
  <td class=xl79 width=74 style='border-left:none;width:56pt'>PTTH/<span
  style='mso-spacerun:yes'>      </span>High school</td>
  <td class=xl80 width=74 style='border-left:none;width:56pt'>Ngh&#7873;/
  Vocational</td>
  <td class=xl80 width=74 style='width:56pt'>Trung C&#7845;p/ Intermediate</td>
  <td class=xl80 width=74 style='width:56pt'>Cao &#272;&#7859;ng/ Collecge</td>
  <td class=xl80 width=74 style='width:56pt'>&#272;&#7841;i H&#7885;c/
  University</td>
  <td class=xl80 width=74 style='width:56pt'>Th&#7841;c S&#297;/ Master</td>
  <td class=xl80 width=74 style='width:56pt'>Ti&#7871;n S&#297;/ Doctor</td>
  <td class=xl79 width=74 style='width:56pt'>T&#7892;NG/<br>
    TOTAL</td>
  <td class=xl71></td>
 </tr>
  <%
 
    int i;
    int count=1;
    int i_dept=0;
    Boolean flag = true;
    Boolean flag_total = false;
    Boolean flag_dep = false;
    string emp_type_old, emp_type_new;
    string dep_old, dep_new;
    string cur_dept, old_dept;
    double[] tot = new double[20];
    double[] total = new double[20];
    double[] gtotal = new double[20];  
    for(int k=0; k<20 ; k++)
    {
        tot[k] = 0;
        total[k] = 0;
        gtotal[k] = 0;
    }
    for (i = 0; i < irow_emp; i++)
    {
        emp_type_old = dt_Emp.Rows[i][0].ToString();
        dep_old = dt_Emp.Rows[i][1].ToString();
    
        cur_dept = dt_Emp.Rows[i][1].ToString();    
        
        for (int j = 3; j < icol_emp; j++)
        {
            tot[j - 3] += Double.Parse(dt_Emp.Rows[i][j].ToString());
            total[j - 3] += Double.Parse(dt_Emp.Rows[i][j].ToString());
            gtotal[j - 3] += Double.Parse(dt_Emp.Rows[i][j].ToString());
        }
        if (flag)
        {
  %>
 <tr class=xl71 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=16 height=32 class=xl91 width=1294 style='border-right:.5pt solid black;
  height:24.0pt;width:977pt'><span style='mso-spacerun:yes'> </span><%= dt_Emp.Rows[i][0].ToString() %></td>
  <td class=xl71></td>
 </tr>
 <%	
     flag = false;
 }
 %>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
 
 <%
    if(i==0)
    {
  %>
  <td height=31 class=xl78 style='height:23.25pt;border-top:none' rowspan="<%=int.Parse(dt_dept.Rows[i_dept][1].ToString()) %>" x:num><%= count %></td>
  
  <td class=xl78 style='border-top:none;border-left:none' rowspan="<%=int.Parse(dt_dept.Rows[i_dept][1].ToString()) %>"><%=dt_dept.Rows[i_dept][0].ToString() %></td>
  <%
    }
    else
    {
        old_dept = dt_Emp.Rows[i-1][1].ToString();
        if (old_dept != cur_dept)
        {
            i_dept++;
 
   %>
  <td height=31 class=xl78 style='height:23.25pt;border-top:none' rowspan="<%=int.Parse(dt_dept.Rows[i_dept][1].ToString()) %>" x:num ><%= count %></td>
  
  <td class=xl78 style='border-top:none;border-left:none' rowspan="<%=int.Parse(dt_dept.Rows[i_dept][1].ToString()) %>" ><%=dt_dept.Rows[i_dept][0].ToString() %></td>
  <%
        }
    }    
   %>
   
  <td class=xl76 style='border-top:none'><%= dt_Emp.Rows[i][2].ToString() %></td>
  <%
    for(int k=3; k<15; k++)
    {
   %>
  <td class=xl82 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%= dt_Emp.Rows[i][k].ToString() %> </td>
  <%
    }
   %>
 
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68></td>
 </tr>
 <%
     
     if (i < irow_emp - 1)
     {
         
         emp_type_new = dt_Emp.Rows[i + 1][0].ToString();
         if (emp_type_new != emp_type_old)
         {
             flag = true;
             flag_total = true;
         }
         dep_new = dt_Emp.Rows[i+1][1].ToString();
         if(dep_new != dep_old)
         {
			count = count + 1;
            flag_dep = true;
         }
     }
     else
     {
         flag = true;
         flag_total = true;
     }
     if (flag_dep)
     {
  %>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=3 height=31 class=xl84 style='border-right:.5pt solid black;
  height:23.25pt'>TOTAL <%= dt_Emp.Rows[i][1].ToString() %></td>
  <%
    for(int k=0; k<12; k++)
    {
   %>
  <td class=xl83 x:num><span style='mso-spacerun:yes'>             
  </span><%= tot[k] %> </td>
  <%
    }
   %>
  
  <td class=xl81 style='border-left:none'>&nbsp;</td>
  <td class=xl68></td>
 </tr>
 <%
        flag_dep = false;
        for(int k=0; k<20; k++)
            tot[k]=0;
    }
    if(flag_total)
    {
  %>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=3 height=31 class=xl84 style='border-right:.5pt solid black;
  height:23.25pt'>TOTAL <%= dt_Emp.Rows[i][0].ToString() %></td>
    <%
    for(int k=0; k<12; k++)
    {
   %>
  <td class=xl83 x:num><span style='mso-spacerun:yes'>             
  </span><%= total[k] %> </td>
    <%
    }
   %>
 
  <td class=xl81 style='border-left:none'>&nbsp;</td>
  <td class=xl68></td>
 </tr>
 <%
        flag_total = false;
        for(int k=0; k<20; k++)
            total[k]=0;
    }
  }  
  %>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=3 height=31 class=xl84 style='border-right:.5pt solid black;
  height:23.25pt' x:str="GRAND TOTAL ">GRAND TOTAL<span
  style='mso-spacerun:yes'> </span></td>
   <%
    for(int k=0; k<12; k++)
    {
   %>
  <td class=xl83 x:num><span style='mso-spacerun:yes'>             
  </span><%= gtotal[k] %> </td>
  <%
    }
   %>
 
  <td class=xl81 style='border-left:none'>&nbsp;</td>
  <td class=xl68></td>
 </tr>
 <tr class=xl74 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=3 height=30 class=xl94 style='height:22.5pt'>PERCENT (%)</td>

  <td class=xl83 x:num><span style='mso-spacerun:yes'>             
  </span><%= gtotal[0]/gtotal[2]*100 %> </td>
  <td class=xl83 x:num><span style='mso-spacerun:yes'>             
  </span><%= gtotal[1]/gtotal[2]*100 %> </td>
  <td class=xl83 x:num><span style='mso-spacerun:yes'>             
  </span> </td>
  <td class=xl83 x:num><span style='mso-spacerun:yes'>             
  </span><%= gtotal[3]/gtotal[11]*100 %> </td>
  <td class=xl83 x:num><span style='mso-spacerun:yes'>             
  </span><%= gtotal[4]/gtotal[11]*100 %> </td>
  <td class=xl83 x:num><span style='mso-spacerun:yes'>             
  </span><%= gtotal[5]/gtotal[11]*100 %> </td>
  <td class=xl83 x:num><span style='mso-spacerun:yes'>             
  </span><%= gtotal[6]/gtotal[11]*100 %> </td>
  <td class=xl83 x:num><span style='mso-spacerun:yes'>             
  </span><%= gtotal[7]/gtotal[11]*100 %> </td>
  <td class=xl83 x:num><span style='mso-spacerun:yes'>           
  </span><%= gtotal[8]/gtotal[11]*100 %> </td>
  <td class=xl83 x:num><span style='mso-spacerun:yes'>           
  </span><%= gtotal[9]/gtotal[11]*100 %> </td>
  <td class=xl83 x:num><span style='mso-spacerun:yes'>           
  </span><%= gtotal[10]/gtotal[11]*100 %> </td>
  <td class=xl83 x:num><span style='mso-spacerun:yes'>           
  </span> </td>
  <td class=xl77 style='border-top:none'>&nbsp;</td>
  <td class=xl74></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=17 class=xl68 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl75 style='height:15.75pt'></td>
  <td colspan=16 class=xl68 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=25 style='width:19pt'></td>
  <td width=148 style='width:111pt'></td>
  <td width=159 style='width:119pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
