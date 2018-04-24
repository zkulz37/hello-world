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
    String emp_pk;
    emp_pk = Request["emp_pk"].ToString();
    string SQL
    = "SELECT null,(SELECT code_nm " +
        "          FROM vhr_hr_code " +
        "         WHERE ID = 'HR0008' AND code = e.pos_type) AS position1, " +
        "       e.emp_id AS emp_id2, e.full_name AS full_nm3, g.workgroup_nm AS group_nm4, e.photo_pk as photo_pk5 " +
        "  FROM thr_employee e, thr_work_group g , tco_org c" +
        " WHERE e.del_if = 0 AND c.del_if=0 and e.tco_org_pk=c.pk and g.del_if = 0 AND e.thr_wg_pk = g.pk " +
        " and e.pk in (" + emp_pk + ")  " +
        " order by nvl(c.seq,0), nvl(g.seq,0), e.emp_id  ";

    
    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt_total.Rows.Count;
    if (irow == 0)
        Response.Write("There is no data");
//Response.Write(SQL);
    //Response.End();
  
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_TimeCard_Poongin_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_TimeCard_Poongin_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_TimeCard_Poongin_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>baoky</o:Author>
  <o:LastAuthor>POONGIN</o:LastAuthor>
  <o:LastPrinted>2008-09-12T02:24:45Z</o:LastPrinted>
  <o:Created>2008-09-11T06:33:22Z</o:Created>
  <o:LastSaved>2008-09-12T22:00:23Z</o:LastSaved>
  <o:Company>home</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.17in .24in .3in .24in;
	mso-header-margin:.17in;
	mso-footer-margin:.23in;
	mso-page-orientation:landscape;}
.font0
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font6
	{color:windowtext;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Code128, sans-serif;
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
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:ShowPageBreakZoom/>
     <x:PageBreakZoom>70</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>2</x:ActiveRow>
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
  <x:WindowHeight>9690</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
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
  <o:regrouptable v:ext="edit">
   <o:entry new="1" old="0"/>
   <o:entry new="2" old="0"/>
  </o:regrouptable>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=967 style='border-collapse:
 collapse;table-layout:fixed;width:726pt'>
 <% int i = 0;
    while (i < irow)
    {     
 %>
 <col width=221 style='mso-width-source:userset;mso-width-alt:8082;width:166pt'>
 <col width=12 style='mso-width-source:userset;mso-width-alt:438;width:9pt'>
 <col width=221 style='mso-width-source:userset;mso-width-alt:8082;width:166pt'>
 <col width=59 style='mso-width-source:userset;mso-width-alt:2157;width:44pt'>
 <col width=221 style='mso-width-source:userset;mso-width-alt:8082;width:166pt'>
 <col width=12 style='mso-width-source:userset;mso-width-alt:438;width:9pt'>
 <col width=221 style='mso-width-source:userset;mso-width-alt:8082;width:166pt'>
 <tr height=367 style='mso-height-source:userset;height:275.25pt'>
  <td height=367 width=221 style='height:275.25pt;width:166pt' align=left
  valign=top><!--[if gte vml 1]><v:group id="_x0000_s1053" style='position:absolute;
   margin-left:.75pt;margin-top:0;width:339pt;height:274.5pt;z-index:1'
   coordorigin="1" coordsize="452,366">
   <o:lock v:ext="edit" text="t"/>
   <v:shapetype id="_x0000_t75" coordsize="21600,21600" o:spt="75"
    o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe" filled="f" stroked="f">
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
   </v:shapetype><v:shape id="_x0000_s1026" type="#_x0000_t75" style='position:absolute;
    left:234;width:219;height:364' o:regroupid="2">
    <v:imagedata src="rpt_TimeCard_Poongin_files/image001.jpg" o:title="HOAN CHINH THE POONG IN 2 MAT SAU "
     croptop="1676f" cropbottom="1117f" cropleft="3435f" cropright="3140f"/>
   </v:shape><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
    left:1;width:219;height:366' o:regroupid="2">
    <v:imagedata src="rpt_TimeCard_Poongin_files/image002.jpg" o:title="HOAN CHINH THE POONG IN 2"
     croptop="5029f" cropbottom="6757f" cropleft="9534f" cropright="9547f"/>
   </v:shape><v:shapetype id="_x0000_t202" coordsize="21600,21600" o:spt="202"
    path="m,l,21600r21600,l21600,xe">
    <v:stroke joinstyle="miter"/>
    <v:path gradientshapeok="t" o:connecttype="rect"/>
   </v:shapetype><v:shape id="_x0000_s1037" type="#_x0000_t202" style='position:absolute;
    left:52;top:208;width:139;height:17;mso-wrap-style:tight' o:regroupid="2"
    filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
    o:insetmode="auto">
    <v:textbox style='mso-direction-alt:auto'>
     <div style='text-align:center'><font class="font0"><%= dt_total.Rows[i][1].ToString() %></font></div>
    </v:textbox>
    <x:ClientData ObjectType="Text">
     <x:TextHAlign>Center</x:TextHAlign>
    </x:ClientData>
   </v:shape><v:shape id="_x0000_s1038" type="#_x0000_t202" style='position:absolute;
    left:51;top:233;width:139;height:17;mso-wrap-style:tight' o:regroupid="2"
    filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
    o:insetmode="auto">
    <v:textbox style='mso-direction-alt:auto'>
     <div style='text-align:center'><font class="font0"><%= dt_total.Rows[i][2].ToString() %></font></div>
    </v:textbox>
    <x:ClientData ObjectType="Text">
     <x:TextHAlign>Center</x:TextHAlign>
    </x:ClientData>
   </v:shape><v:shape id="_x0000_s1039" type="#_x0000_t202" style='position:absolute;
    left:49;top:259;width:151;height:19;mso-wrap-style:tight' o:regroupid="2"
    filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
    o:insetmode="auto">
    <v:textbox style='mso-direction-alt:auto'>
     <div style='text-align:center'><font class="font0"><%= dt_total.Rows[i][3].ToString() %></font></div>
    </v:textbox>
    <x:ClientData ObjectType="Text">
     <x:TextHAlign>Center</x:TextHAlign>
    </x:ClientData>
   </v:shape><v:shape id="_x0000_s1040" type="#_x0000_t202" style='position:absolute;
    left:50;top:286;width:139;height:17;mso-wrap-style:tight' o:regroupid="2"
    filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
    o:insetmode="auto">
    <v:textbox style='mso-direction-alt:auto'>
     <div style='text-align:center'><font class="font0"><%= dt_total.Rows[i][4].ToString() %></font></div>
    </v:textbox>
    <x:ClientData ObjectType="Text">
     <x:TextHAlign>Center</x:TextHAlign>
    </x:ClientData>
   </v:shape><v:shape id="_x0000_s1041" type="#_x0000_t75" style='position:absolute;
    left:54;top:61;width:110;height:129' o:regroupid="2">
    <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_total.Rows[i][5].ToString()%>&table_name=HR_IMAGE" o:title="01"/>
   </v:shape><v:shape id="_x0000_s1052" type="#_x0000_t202" style='position:absolute;
    left:47;top:301;width:158;height:30;mso-wrap-style:tight' filled="f"
    fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
    o:insetmode="auto">
    <v:textbox style='mso-direction-alt:auto'>
     <div style='text-align:center'><font class="font6">*H<%= dt_total.Rows[i][2].ToString() %>*</font></div>
    </v:textbox>
    <x:ClientData ObjectType="Text">
     <x:TextHAlign>Center</x:TextHAlign>
    </x:ClientData>
   </v:shape></v:group><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:1px;margin-top:0px;width:452px;
  height:366px'><img width=452 height=366
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_total.Rows[i][5].ToString()%>&table_name=HR_IMAGE" v:shapes="_x0000_s1053 _x0000_s1026 _x0000_s1025 _x0000_s1037 _x0000_s1038 _x0000_s1039 _x0000_s1040 _x0000_s1041 _x0000_s1052"></span><![endif]><span
  style='mso-ignore:vglayout2'>
   <%
        //Hình 2
        i++;
        if (i < irow)
        {
   %>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=367 width=221 style='height:275.25pt;width:166pt'></td>
   </tr>
  </table>
  </span></td>
  <td width=12 style='width:9pt'></td>
  <td width=221 style='width:166pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=221 style='width:166pt' align=left valign=top><!--[if gte vml 1]><v:group
   id="_x0000_s1054" style='position:absolute;margin-left:.75pt;margin-top:0;
   width:339pt;height:274.5pt;z-index:2' coordorigin="1" coordsize="452,366">
   <o:lock v:ext="edit" text="t"/>
   <v:shape id="_x0000_s1055" type="#_x0000_t75" style='position:absolute;
    left:234;width:219;height:364'>
    <v:imagedata src="rpt_TimeCard_Poongin_files/image001.jpg" o:title="HOAN CHINH THE POONG IN 2 MAT SAU "
     croptop="1676f" cropbottom="1117f" cropleft="3435f" cropright="3140f"/>
   </v:shape><v:shape id="_x0000_s1056" type="#_x0000_t75" style='position:absolute;
    left:1;width:219;height:366'>
    <v:imagedata src="rpt_TimeCard_Poongin_files/image002.jpg" o:title="HOAN CHINH THE POONG IN 2"
     croptop="5029f" cropbottom="6757f" cropleft="9534f" cropright="9547f"/>
   </v:shape><v:shape id="_x0000_s1057" type="#_x0000_t202" style='position:absolute;
    left:52;top:208;width:139;height:17;mso-wrap-style:tight' filled="f"
    fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
    o:insetmode="auto">
    <v:textbox style='mso-direction-alt:auto'>
     <div style='text-align:center'><font class="font0"><%= dt_total.Rows[i][1].ToString() %></font></div>
    </v:textbox>
    <x:ClientData ObjectType="Text">
     <x:TextHAlign>Center</x:TextHAlign>
    </x:ClientData>
   </v:shape><v:shape id="_x0000_s1058" type="#_x0000_t202" style='position:absolute;
    left:51;top:233;width:139;height:17;mso-wrap-style:tight' filled="f"
    fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
    o:insetmode="auto">
    <v:textbox style='mso-direction-alt:auto'>
     <div style='text-align:center'><font class="font0"><%= dt_total.Rows[i][2].ToString() %></font></div>
    </v:textbox>
    <x:ClientData ObjectType="Text">
     <x:TextHAlign>Center</x:TextHAlign>
    </x:ClientData>
   </v:shape><v:shape id="_x0000_s1059" type="#_x0000_t202" style='position:absolute;
    left:49;top:259;width:151;height:19;mso-wrap-style:tight' filled="f"
    fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
    o:insetmode="auto">
    <v:textbox style='mso-direction-alt:auto'>
     <div style='text-align:center'><font class="font0"><%= dt_total.Rows[i][3].ToString() %></font></div>
    </v:textbox>
    <x:ClientData ObjectType="Text">
     <x:TextHAlign>Center</x:TextHAlign>
    </x:ClientData>
   </v:shape><v:shape id="_x0000_s1060" type="#_x0000_t202" style='position:absolute;
    left:50;top:286;width:139;height:17;mso-wrap-style:tight' filled="f"
    fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
    o:insetmode="auto">
    <v:textbox style='mso-direction-alt:auto'>
     <div style='text-align:center'><font class="font0"><%= dt_total.Rows[i][4].ToString() %></font></div>
    </v:textbox>
    <x:ClientData ObjectType="Text">
     <x:TextHAlign>Center</x:TextHAlign>
    </x:ClientData>
   </v:shape><v:shape id="_x0000_s1061" type="#_x0000_t75" style='position:absolute;
    left:54;top:61;width:110;height:129'>
    <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_total.Rows[i][5].ToString()%>&table_name=HR_IMAGE" o:title="01"/>
   </v:shape><v:shape id="_x0000_s1062" type="#_x0000_t202" style='position:absolute;
    left:47;top:301;width:158;height:30;mso-wrap-style:tight' filled="f"
    fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
    o:insetmode="auto">
    <v:textbox style='mso-direction-alt:auto'>
     <div style='text-align:center'><font class="font6">*H<%= dt_total.Rows[i][2].ToString() %>*</font></div>
    </v:textbox>
    <x:ClientData ObjectType="Text">
     <x:TextHAlign>Center</x:TextHAlign>
    </x:ClientData>
   </v:shape></v:group><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:1px;margin-top:0px;width:452px;
  height:366px'><img width=452 height=366
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_total.Rows[i][5].ToString()%>&table_name=HR_IMAGE" v:shapes="_x0000_s1054 _x0000_s1055 _x0000_s1056 _x0000_s1057 _x0000_s1058 _x0000_s1059 _x0000_s1060 _x0000_s1061 _x0000_s1062"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=367 width=221 style='height:275.25pt;width:166pt'></td>
   </tr>
  </table>
  </span></td>
  <td width=12 style='width:9pt'></td>
  <td width=221 style='width:166pt'></td>
 </tr>
 <%
        }   //end if
    i++;
    }       //end while
  %>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 colspan=7 style='height:12.95pt;mso-ignore:colspan'></td>
 </tr>
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=221 style='width:166pt'></td>
  <td width=12 style='width:9pt'></td>
  <td width=221 style='width:166pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=221 style='width:166pt'></td>
  <td width=12 style='width:9pt'></td>
  <td width=221 style='width:166pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
