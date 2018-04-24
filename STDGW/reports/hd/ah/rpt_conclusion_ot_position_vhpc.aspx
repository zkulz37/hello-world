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

    string p_to, p_org, p_status, p_nation, p_mon_from, p_mon_to;


    p_org = Request["p_org"].ToString();
    p_status = Request["p_status"].ToString();
    p_nation = Request["p_nation"].ToString();
    p_mon_from = Request["p_month_from"].ToString();
    p_mon_to = Request["p_month_to"].ToString();


    string SQL
    = "select decode(tb1.employee_type,'01', 'OFFICE', 'FACTORY') " +
        "   ,(select code_nm from vhr_hr_code where id='HR0008' and code= tb1.POS_TYPE) pos_name  " +
        "   , tb2.employees " +
        "   ,tb1.rate30, tb1.rate45, tb1.rate60, tb1.rate90, tb1.rate150, tb1.rate200, tb1.rate300, tb1.total  from " +
        "    (select e.employee_type,e.POS_TYPE, sum(case when a.PAY_RATE= 30 then a.OT_TIME else 0 end) rate30 " +
        "    , sum(case when a.PAY_RATE= 45 then a.OT_TIME else 0 end) rate45 " +
        "    , sum(case when a.PAY_RATE= 60 then a.OT_TIME else 0 end) rate60 " +
        "    , sum(case when a.PAY_RATE= 90 then a.OT_TIME else 0 end) rate90 " +
        "    , sum(case when a.PAY_RATE= 150 then a.OT_TIME else 0 end) rate150 " +
        "    , sum(case when a.PAY_RATE= 200 then a.OT_TIME else 0 end) rate200 " +
        "    , sum(case when a.PAY_RATE= 300 then a.OT_TIME else 0 end) rate300 " +
        "    , sum(a.OT_TIME) total " +
        "    from thr_extra_time a, thr_employee e " +
        "    where a.del_if=0 and e.del_if=0  " +
        "    and a.thr_emp_pk = e.pk " +
        "    and a.WORK_DT between '" + p_mon_from + "'||'16' and '" + p_mon_to + "'||'15' " +
        "    and Decode('" + p_status + "','ALL','ALL', e.STATUS )= '" + p_status + "' " +
            "and Decode('" + p_nation + "','ALL','ALL', e.NATION )= '" + p_nation + "' " +
            " and (e.tco_org_pk in ( " +
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
        "    group by e.employee_type, e.POS_TYPE " +
        "    having e.pos_type is not null " +
        "    order by e.EMPLOYEE_TYPE, e.POS_TYPE) tb1, " +
		"   ( select pos.employee_type,pos.pos_type, count(*) employees from " +
        "        (select e.employee_type,e.POS_TYPE, a.THR_EMP_PK  " +
        "        from thr_extra_time a, thr_employee e  " +
        "        where a.del_if=0 and e.del_if=0   " +
        "        and a.THR_EMP_PK = e.pk   " +
        "    	 and a.WORK_DT between '" + p_mon_from + "'||'16' and '" + p_mon_to + "'||'15' " +
        "        and e.pos_type is not null  " +
		    "    and Decode('" + p_status + "','ALL','ALL', e.STATUS )= '" + p_status + "' " +
            "and Decode('" + p_nation + "','ALL','ALL', e.NATION )= '" + p_nation + "' " +
            " and (e.tco_org_pk in ( " +
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
        "        group by e.employee_type,e.POS_TYPE, a.THR_EMP_PK) pos  " +
        "    group by pos.employee_type, pos.pos_type  " +
        "    having pos.pos_type is not null  " +
        "    order by pos.employee_type, pos.pos_type) tb2 " +
        "where tb1.employee_type = tb2.employee_type " +
        "and tb1.pos_type = tb2.pos_type " +
        "order by tb1.employee_type, tb1.pos_type ";



    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp, icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp = dt_Emp.Columns.Count;
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
<link rel=File-List href="rpt_conclusion_ot_position_vhpc_files/filelist.xml">
<link rel=Edit-Time-Data
href="rpt_conclusion_ot_position_vhpc_files/editdata.mso">
<link rel=OLE-Object-Data
href="rpt_conclusion_ot_position_vhpc_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>user</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-09-23T02:46:06Z</o:LastPrinted>
  <o:Created>2011-04-29T05:58:59Z</o:Created>
  <o:LastSaved>2011-09-23T02:49:19Z</o:LastSaved>
  <o:Company>Hewlett-Packard Company</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .25in .25in .25in;
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
.style57
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
	mso-style-name:"Normal 2";}
.style58
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
	mso-style-name:"Normal 3";}
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
	{mso-style-parent:style57;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style57;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl72
	{mso-style-parent:style57;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style57;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style57;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmm\\-yy";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style57;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl76
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl77
	{mso-style-parent:style57;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style57;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style57;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl80
	{mso-style-parent:style58;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style58;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style57;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl83
	{mso-style-parent:style58;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl84
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl85
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl86
	{mso-style-parent:style57;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl87
	{mso-style-parent:style57;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl88
	{mso-style-parent:style58;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl89
	{mso-style-parent:style58;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl90
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl92
	{mso-style-parent:style57;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmm\\-yy";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl93
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>hour of position</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Zoom>112</x:Zoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
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
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl71>

<table x:str border=0 cellpadding=0 cellspacing=0 width=973 style='border-collapse:
 collapse;table-layout:fixed;width:727pt'>
 <col class=xl71 width=183 style='mso-width-source:userset;mso-width-alt:6692;
 width:137pt'>
 <col class=xl71 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl70 width=79 span=7 style='mso-width-source:userset;mso-width-alt:
 2889;width:59pt'>
 <col class=xl71 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl71 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl71 width=96 span=2 style='mso-width-source:userset;mso-width-alt:
 3510;width:72pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 width=183 style='height:15.0pt;width:137pt' align=left
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
  </v:shapetype><v:shape id="Picture_x0020_1" o:spid="_x0000_s1025" type="#_x0000_t75"
   style='position:absolute;margin-left:0;margin-top:0;width:96.75pt;height:37.5pt;
   z-index:1;visibility:visible'>
   <v:imagedata src="rpt_conclusion_ot_position_vhpc_files/image001.png"
    o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:0px;width:129px;
  height:50px'><img width=129 height=50
  src="rpt_conclusion_ot_position_vhpc_files/image002.jpg" v:shapes="Picture_x0020_1"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl68 width=183 style='height:15.0pt;width:137pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl68 width=79 style='width:59pt'></td>
  <td class=xl69 width=79 style='width:59pt'></td>
  <td class=xl69 width=79 style='width:59pt'></td>
  <td class=xl69 width=79 style='width:59pt'></td>
  <td class=xl69 width=79 style='width:59pt'></td>
  <td class=xl69 width=79 style='width:59pt'></td>
  <td class=xl69 width=79 style='width:59pt'></td>
  <td class=xl69 width=79 style='width:59pt'></td>
  <td class=xl71 width=79 style='width:59pt'></td>
  <td class=xl71 width=79 style='width:59pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl68 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl72 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl69 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 class=xl68 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl69 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=11 height=32 class=xl86 style='height:24.0pt'
  x:str="TH&#7888;NG K&#7870; S&#7888; GI&#7900; T&#258;NG CA THEO CH&#7912;C V&#7908; T&#7914; THÁNG 01 &#272;&#7870;N THÁNG 09 N&#258;M 2011 ">TH&#7888;NG
  K&#7870; S&#7888; GI&#7900; T&#258;NG CA THEO CH&#7912;C V&#7908; T&#7914;
  THÁNG 01 &#272;&#7870;N THÁNG 09 N&#258;M 2011<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td colspan=11 height=35 class=xl87 style='height:26.25pt'>REPORT OVERTIME
  &amp; NIGHT SHIFT ALLOWANCE POSITION CONCLUSION FROM JANUARY TO SEPTEMBERIN
  2011</td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl75 style='height:18.75pt'>unit : hour</td>
  <td class=xl75></td>
  <td colspan=7 class=xl73 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 class=xl68 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl69 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=53 style='mso-height-source:userset;height:39.75pt'>
  <td height=53 class=xl82 width=183 style='height:39.75pt;width:137pt'>Position</td>
  <td class=xl84 width=79 style='width:59pt'>Total Employee's OT</td>
  <td class=xl83 style='border-left:none' x:num="1.5">150%</td>
  <td class=xl83 style='border-left:none' x:num="2">200%</td>
  <td class=xl83 style='border-left:none' x:num="3">300%</td>
  <td class=xl83 style='border-left:none' x:num="0.3">30%</td>
  <td class=xl83 style='border-left:none' x:num="0.45">45%</td>
  <td class=xl83 style='border-left:none' x:num="0.6">60%</td>
  <td class=xl83 style='border-left:none' x:num="0.9">90%</td>
  <td class=xl85 style='border-left:none'>Total of OT</td>
  <td class=xl84 width=79 style='border-left:none;width:59pt'>Average
  hour/person</td>
 </tr>
 <%
    int i = 0;
    int count = 1;
    Boolean flag = true;
    Boolean flag_total = false;
    string emp_type_old, emp_type_new; 
    double[] total = new double[10];
    double[] gtotal = new double[10];
    for (int k = 0; k < 10; k++)
    {
        total[k] = 0;
        gtotal[k] = 0;
    }  
    for (i = 0; i < irow_emp; i++)
    {
        emp_type_old = dt_Emp.Rows[i][0].ToString();

        for (int j = 2; j < icol_emp; j++)
        { 
            total[j-2] += Double.Parse(dt_Emp.Rows[i][j].ToString());
            gtotal[j-2] += Double.Parse(dt_Emp.Rows[i][j].ToString());
        }
        if (flag)
        {
  %>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl78 style='height:25.5pt;border-top:none'
  x:str><%= dt_Emp.Rows[i][0].ToString()%><span style='mso-spacerun:yes'> </span></td>
  <td class=xl77 style='border-top:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none'>&nbsp;</td>
  <td class=xl79 style='border-top:none'>&nbsp;</td>
 </tr>
      <%	
        flag = false;
        }
 %>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td height=39 class=xl74 style='height:29.25pt;border-top:none'><%= dt_Emp.Rows[i][1].ToString()%></td>
  <td class=xl90 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><%= dt_Emp.Rows[i][2].ToString()%> </td>
  <td class=xl80 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= dt_Emp.Rows[i][3].ToString()%> </td>
  <td class=xl80 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= dt_Emp.Rows[i][4].ToString()%> </td>
  <td class=xl80 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= dt_Emp.Rows[i][5].ToString()%> </td>
  <td class=xl80 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= dt_Emp.Rows[i][6].ToString()%> </td>
  <td class=xl80 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= dt_Emp.Rows[i][7].ToString()%> </td>
  <td class=xl80 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= dt_Emp.Rows[i][8].ToString()%> </td>
  <td class=xl81 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= dt_Emp.Rows[i][9].ToString()%> </td>
  <td class=xl80 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= dt_Emp.Rows[i][10].ToString()%> </td>
  <%
      if (dt_Emp.Rows[i][2].ToString() == "0")
      {
         %>
  <td class=xl80 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span> 0 </td>
  <%   
           
      }
      else
      {      %>
    <td class=xl80 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= Double.Parse(dt_Emp.Rows[i][10].ToString()) / Double.Parse(dt_Emp.Rows[i][2].ToString())%> </td>
  <%  } %>
 </tr>

 <%
     
    if (i < irow_emp - 1)
    {
        count = count + 1;
        emp_type_new = dt_Emp.Rows[i + 1][0].ToString();
        if (emp_type_new != emp_type_old)
        {
            flag = true;
            flag_total = true;
        }
    }
    else
    {
        flag = true;
        flag_total = true;
    }
    if (flag_total)
    {
  %>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td height=39 class=xl92 style='height:29.25pt'>Total <%= dt_Emp.Rows[i][0].ToString()%></td>
  <td class=xl91 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>             </span><%= total[0] %> </td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= total[1] %> </td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= total[2] %> </td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= total[3] %> </td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= total[4] %> </td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= total[5] %> </td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= total[6] %> </td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= total[7] %> </td>
  <td class=xl88 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= total[8] %> </td>

  
  <%
      if (total[0].ToString() == "0")
      {
         %>
  <td class=xl88 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span>0 </td>
  <%   
           
      }
      else
      {      %>
    <td class=xl88 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= (Double)total[8]/total[0] %> </td>
  <%  } %>
 </tr>
  <%
     
     for (int k = 0; k < 10; k++)
         total[k] = 0;     
    flag_total = false;
   }
}
      
	%>
 <tr class=xl76 height=39 style='mso-height-source:userset;height:29.25pt'>
  <td height=39 class=xl93 style='height:29.25pt'>GRAND TOTAL</td>
  <td class=xl91 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><%= gtotal[0] %> </td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= gtotal[1] %> </td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= gtotal[2] %> </td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= gtotal[3] %> </td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= gtotal[4] %> </td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= gtotal[5] %> </td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= gtotal[6] %> </td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= gtotal[7] %> </td>
  <td class=xl88 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= gtotal[8] %> </td>

 
   <%
      if (gtotal[0].ToString() == "0")
      {
         %>
   <td class=xl88 style='border-top:none;border-left:none' x:num="26"><span
  style='mso-spacerun:yes'>         </span>0 </td>
  <%   
           
      }
      else
      {      %>
     <td class=xl88 style='border-top:none;border-left:none' x:num="26"><span
  style='mso-spacerun:yes'>         </span><%= (Double)gtotal[8]/gtotal[0] %> </td>
  <%  } %>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=183 style='width:137pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
