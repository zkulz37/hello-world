<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("crm");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string l_month="",l_parameter="",month="";
	l_month =Request["p_month"];
	l_parameter = "'" + l_month + "'";
    DataTable dt = ESysLib.TableReadOpenCursor("crm.sp_sel_htfo00460", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
	string l_print_date="";
    string SQL3 = "select to_char(sysdate,'dd-Mon-yyyy hh24:mi') print_date from dual";
    DataTable dt_sysdate = ESysLib.TableReadOpen(SQL3);
    if (dt_sysdate.Rows.Count > 0)
    {
        l_print_date = dt_sysdate.Rows[0][0].ToString();
    }
    month=l_month.Substring(4,2)+"/"+l_month.Substring(0,4);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_htfo00460_sct_item_list_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_htfo00460_sct_item_list_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_htfo00460_sct_item_list_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr.Quyen</o:Author>
  <o:LastAuthor>Mr.Quyen</o:LastAuthor>
  <o:LastPrinted>2011-08-15T08:48:37Z</o:LastPrinted>
  <o:Created>2011-08-15T08:25:14Z</o:Created>
  <o:LastSaved>2011-08-15T08:52:18Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P";
	margin:.49in .34in .35in .44in;
	mso-header-margin:.5in;
	mso-footer-margin:.34in;
	mso-page-orientation:landscape;}
.font5
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Arial Narrow", sans-serif;
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
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:right;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:right;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	color:red;
	font-size:20.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#33CCCC;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:right;
	border:.5pt solid windowtext;}	
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
      <x:Scale>74</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>3</x:SplitHorizontal>
     <x:TopRowBottomPane>3</x:TopRowBottomPane>
     <x:SplitVertical>2</x:SplitVertical>
     <x:LeftColumnRightPane>1</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
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
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>17115</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$3</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1027"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1244 style='border-collapse:
 collapse;table-layout:fixed;width:934pt'>
 <col width=76 style='mso-width-source:userset;mso-width-alt:2779;width:57pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=411 style='mso-width-source:userset;mso-width-alt:15030;width:308pt'>
 <col width=85 style='mso-width-source:userset;mso-width-alt:3108;width:64pt'>
 <col width=77 style='mso-width-source:userset;mso-width-alt:2816;width:58pt'>
 <col width=86 style='mso-width-source:userset;mso-width-alt:3145;width:65pt'>
 <col width=88 style='mso-width-source:userset;mso-width-alt:3218;width:66pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=90 style='mso-width-source:userset;mso-width-alt:3291;width:68pt'>
 <col width=85 style='mso-width-source:userset;mso-width-alt:3108;width:64pt'>
 <col width=83 style='mso-width-source:userset;mso-width-alt:3035;width:62pt'>
 <tr height=89 style='mso-height-source:userset;height:66.75pt'>
  <td colspan=2 height=89 width=148 style='height:66.75pt;width:111pt'
  align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
   coordsize="21600,21600" o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe"
   filled="f" stroked="f">
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
   margin-left:2.25pt;margin-top:4.5pt;width:105.75pt;height:59.25pt;z-index:1'>
   <v:imagedata src="rpt_htfo00460_sct_item_list_files/image001.jpg" o:title="AMCO"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:3px;margin-top:6px;width:141px;
  height:79px'><img width=141 height=79
  src="rpt_htfo00460_sct_item_list_files/image002.jpg" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=2 height=89 class=xl24 width=148 style='height:66.75pt;
    width:111pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=7 class=xl33 width=928 style='width:697pt'>SCT Item List</td>
  <td colspan=2 height=89 width=168 style='height:66.75pt;width:126pt'
  align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1026" type="#_x0000_t75"
   style='position:absolute;margin-left:1.5pt;margin-top:6pt;width:122.25pt;
   height:56.25pt;z-index:2'>
   <v:imagedata src="rpt_htfo00460_sct_item_list_files/image003.jpg" o:title="image002"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:2px;margin-top:8px;width:163px;
  height:75px'><img width=163 height=75
  src="rpt_htfo00460_sct_item_list_files/image004.jpg" v:shapes="_x0000_s1026"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=2 height=89 class=xl24 width=168 style='height:66.75pt;
    width:126pt'></td>
   </tr>
  </table>
  </span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl25 style='height:12.75pt'>Month:<font
  class="font5"> <%=month%></font></td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'><b>Total:<b></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows.Count%>Row(s).</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl28 style='border-left:none'>Print Time:<font
  class="font5"><span style='mso-spacerun:yes'>  </span><%=l_print_date%></font></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl34 style='height:12.75pt;border-top:none'>Invoice#</td>
  <td class=xl34 style='border-top:none;border-left:none'>Invoice Date</td>
  <td class=xl34 style='border-top:none;border-left:none'>Partner Name</td>
  <td class=xl34 style='border-top:none;border-left:none'>Green Fee</td>
  <td class=xl34 style='border-top:none;border-left:none'>Caddies Fee</td>
  <td class=xl34 style='border-top:none;border-left:none'>Cart Fee</td>
  <td class=xl34 style='border-top:none;border-left:none'>Drv Range Fee</td>
  <td class=xl34 style='border-top:none;border-left:none'>Teaching Fee</td>
  <td class=xl34 style='border-top:none;border-left:none'>Member Fee</td>
  <td class=xl34 style='border-top:none;border-left:none' x:str="SCT ">SCT<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl34 style='border-top:none;border-left:none'>Total</td>
 </tr>
 <%
	decimal green_fee=0,caddie_fee=0,cart_fee=0,drv_range_fee=0,teaching_fee=0,member_fee=0,sct=0,total=0 ;
     for (int i = 0; i < dt.Rows.Count; i++)
     {
         if(dt.Rows[i][3].ToString() != "")
		 {
            green_fee += decimal.Parse(dt.Rows[i][3].ToString()) ;
         } 
		 if(dt.Rows[i][4].ToString() != "")
         {
            caddie_fee += decimal.Parse(dt.Rows[i][4].ToString()) ;
         } 
		 if(dt.Rows[i][5].ToString() != "")
         {
            cart_fee += decimal.Parse(dt.Rows[i][5].ToString()) ;
         } 
		 if(dt.Rows[i][6].ToString() != "")
         {
            drv_range_fee += decimal.Parse(dt.Rows[i][6].ToString()) ;
         } 
		 if(dt.Rows[i][7].ToString() != "")
         {
            teaching_fee += decimal.Parse(dt.Rows[i][7].ToString()) ;
         } 
		 if(dt.Rows[i][8].ToString() != "")
         {
            member_fee += decimal.Parse(dt.Rows[i][8].ToString()) ;
         } 
		 if(dt.Rows[i][9].ToString() != "")
         {
            sct += decimal.Parse(dt.Rows[i][9].ToString()) ;
         } 
		 if(dt.Rows[i][10].ToString() != "")
         {
            total += decimal.Parse(dt.Rows[i][10].ToString()) ;
         } 
		 
          %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl30 style='height:12.75pt;border-top:none'><%=dt.Rows[i][0]%></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dt.Rows[i][11]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][2]%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][3]%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][4]%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][5]%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][6]%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][7]%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][8]%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][9]%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][10]%></td>
 </tr>
 <%}%>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl28 style='height:12.75pt'>Total:</td>
  <td class=xl32 align=right style='border-top:none;border-left:none'
  x:num><%=green_fee%></td>
  <td class=xl32 align=right style='border-top:none;border-left:none'
  x:num><%=caddie_fee%></td>
  <td class=xl32 align=right style='border-top:none;border-left:none'
  x:num><%=cart_fee%></td>
  <td class=xl32 align=right style='border-top:none;border-left:none'
  x:num><%=drv_range_fee%></td>
  <td class=xl32 align=right style='border-top:none;border-left:none'
  x:num><%=teaching_fee%></td>
  <td class=xl32 align=right style='border-top:none;border-left:none'
  x:num><%=member_fee%></td>
  <td class=xl32 align=right style='border-top:none;border-left:none'
  x:num><%=sct%></td>
  <td class=xl32 align=right style='border-top:none;border-left:none'
  x:num><%=total%></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=76 style='width:57pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=411 style='width:308pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=83 style='width:62pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
