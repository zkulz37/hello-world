<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    long emp_pk;
    emp_pk = long.Parse(Request["emp_pk"].ToString());
    string SQL;
   
   SQL= " select b.emp_id,b.full_name,d.ORG_NM,c.WORKGROUP_NM,to_char(to_date(join_dt,'yyyymmdd'),'dd/mm/yyyy'),photo_pk,  " +
        "a.FULL_NAME , e.code_nm, to_char(to_date( a.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy'),a.job,a.salary, a.REMARK   " +
        " from THR_FAMILY a ,thr_employee b,thr_work_group c,tco_org d, vhr_hr_code e   " +
        " where a.del_if=0 and b.del_if=0 and c.del_if=0 and d.del_if=0 and e.id='HR0024'  " +
        " and a.thr_employee_pk=b.pk and b.THR_WG_PK=c.pk and b.TCO_ORG_PK=d.pk  and a.relation = e.code " +
        " and a.THR_EMPLOYEE_PK= " + emp_pk.ToString() +
        " order by start_dt   ";


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
<link rel=File-List href="rpt_employee_family_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_employee_family_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_employee_family_files/oledata.mso">
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
  <o:LastAuthor>ty-ml</o:LastAuthor>
  <o:LastPrinted>2008-07-08T03:25:42Z</o:LastPrinted>
  <o:Created>2008-05-26T07:46:39Z</o:Created>
  <o:LastSaved>2008-07-08T03:26:09Z</o:LastSaved>
  <o:Company>genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.4in .41in 1.0in .42in;
	mso-header-margin:.23in;
	mso-footer-margin:.5in;}
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
	font-size:11.0pt;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:left;
	vertical-align:middle;
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
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
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
  <x:WindowHeight>7935</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
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

<body link=blue vlink=purple>
<table x:str border=0 cellpadding=0 cellspacing=0 width=762 style='border-collapse:
 collapse;table-layout:fixed;width:572pt'>
 <col width=56 style='mso-width-source:userset;mso-width-alt:2048;width:42pt'>
 <col width=168 style='mso-width-source:userset;mso-width-alt:6144;width:126pt'>
 <col width=9 style='mso-width-source:userset;mso-width-alt:329;width:7pt'>
 <col width=141 style='mso-width-source:userset;mso-width-alt:5156;width:106pt'>
 <col width=103 style='mso-width-source:userset;mso-width-alt:3766;width:77pt'>
 <col width=92 style='mso-width-source:userset;mso-width-alt:3364;width:69pt'>
 <col width=85 style='mso-width-source:userset;mso-width-alt:3108;width:64pt'>
 <col width=108 style='mso-width-source:userset;mso-width-alt:3949;width:81pt'>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td colspan=7 height=45 class=xl39 width=661 style='height:33.75pt;
  width:496pt'>EMPLOYEE'S FAMILY</td>
 </tr>
 <tr class=xl25 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl26 width=224 style='height:22.5pt;width:168pt'>Emp
  ID</td>
  <td class=xl24>:</td>
  <td class=xl25><%= dt_total.Rows[0][0].ToString() %></td>
  <td class=xl24></td>
  <td width=103 style='width:77pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
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
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:65.25pt;margin-top:1.5pt;width:117pt;height:112.5pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_total.Rows[0][5].ToString()%>&table_name=<%=Session["APP_DBUSER"].ToString()%>.TC_FSBINARY" o:title="Www_PhiSon_Info_SieuBaby_29"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:87px;margin-top:2px;width:156px;
  height:150px'><img width=156 height=150
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_total.Rows[0][5].ToString()%>&table_name=<%=Session["APP_DBUSER"].ToString()%>.TC_FSBINARY" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl26 width=103 style='height:22.5pt;width:77pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27></td>
 </tr>
 <tr class=xl25 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl26 width=224 style='height:22.5pt;width:168pt'>Full
  Name</td>
  <td class=xl24>:</td>
  <td colspan=4 class=xl40 ><%= dt_total.Rows[0][1].ToString() %><span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl25 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl26 width=224 style='height:22.5pt;width:168pt'>Deparment</td>
  <td class=xl24>:</td>
  <td class=xl25><%= dt_total.Rows[0][2].ToString() %></td>
  <td class=xl26></td>
  <td class=xl24></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl26 width=224 style='height:22.5pt;width:168pt'>Group</td>
  <td class=xl24>:</td>
  <td class=xl25><%= dt_total.Rows[0][3].ToString() %></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=42 style='mso-height-source:userset;height:31.5pt'>
  <td colspan=2 height=42 class=xl35 width=224 style='height:31.5pt;width:168pt'>Join
  Date</td>
  <td class=xl24>:</td>
  <td class=xl28 x:num><%= dt_total.Rows[0][4].ToString() %></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl29 width=56 style='height:21.0pt;border-top:none;
  width:42pt'>No</td>
  <td colspan=2 class=xl30 style='border-left:none'>Name</td>
  <td class=xl31 style='border-left:none'>Relation</td>
  <td class=xl30 style='border-left:none'>Birth Date</td>
  <td class=xl30 style='border-left:none'>Job</td>
  <td class=xl30 style='border-left:none'>Salary</td>
  <td class=xl30 style='border-left:none'>Remark</td>
 </tr>
 <% for (int i = 0; i < irow; i++) 
    {
    %> 
 
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl32 style='height:21.0pt;border-top:none' x:num><%=i+1 %></td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none'><%= dt_total.Rows[i][6].ToString() %></td>
  <td class=xl34 style='border-top:none;border-left:none'><%= dt_total.Rows[i][7].ToString() %></td>
  <td class=xl33 style='border-top:none;border-left:none' x:num><%= dt_total.Rows[i][8].ToString() %></td>
  <td class=xl33 style='border-top:none;border-left:none' x:num><%= dt_total.Rows[i][9].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0"' x:num><%= dt_total.Rows[i][10].ToString() %></td>
  <td class=xl38 style='border-left:none'><%= dt_total.Rows[i][11].ToString() %></td>
 </tr>
 <%
    }
  %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=56 style='width:42pt'></td>
  <td width=168 style='width:126pt'></td>
  <td width=9 style='width:7pt'></td>
  <td width=141 style='width:106pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=9 style='width:7pt'></td>
  <td width=175 style='width:131pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
