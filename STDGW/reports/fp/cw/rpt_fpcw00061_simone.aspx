<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% Response.ContentType = "application/vnd.ms-excel"; %>
<% Response.Charset = "utf-8"; %>
<% ESysLib.SetUser("prod");%>
<% Response.Buffer = false;%>

<%        
    DataTable dt , dt_master ;

    string l_wi_pk = Request["wi_pk"];

    dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpcw00061_simone ", l_wi_pk); 
    
    /*****************************************************************/
    string p_po_no = "", p_cust_name = "" ,  p_group = "" , p_size = "" , p_style_no = "", p_style_name = "" , p_t_a = "" , p_leather = "" ;

    dt_master = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpcw00061_simone_1", l_wi_pk); 
    
    if (dt_master.Rows.Count > 0)
    {
        p_po_no = dt_master.Rows[0]["po_no"].ToString();
        p_cust_name = dt_master.Rows[0]["cust_name"].ToString();
        p_group = dt_master.Rows[0]["t_group"].ToString();
        p_size = dt_master.Rows[0]["t_size"].ToString();
        p_style_no = dt_master.Rows[0]["style_no"].ToString();
        p_style_name = dt_master.Rows[0]["style_name"].ToString();
        p_t_a = dt_master.Rows[0]["t_a"].ToString();
        p_leather = dt_master.Rows[0]["leather"].ToString();                
    }
    /*****************************************************************/
    
%>

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_fpcw00020_simone_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_fpcw00020_simone_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_fpcw00020_simone_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>QuangNguyen</o:Author>
  <o:LastAuthor>QuangNguyen</o:LastAuthor>
  <o:LastPrinted>2010-03-29T07:54:34Z</o:LastPrinted>
  <o:Created>2010-03-29T07:41:52Z</o:Created>
  <o:LastSaved>2010-03-29T07:58:05Z</o:LastSaved>
  <o:Company>VinaGenuwin</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.31in .13in .18in .15in;
	mso-header-margin:.25in;
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
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
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
     <x:DefaultRowHeight>225</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:CodeName>Sheet1</x:CodeName>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>9</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
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
     <x:CodeName>Sheet2</x:CodeName>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:CodeName>Sheet3</x:CodeName>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8445</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
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

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1234 style='border-collapse:
 collapse;table-layout:fixed;width:927pt'>
 <col class=xl24 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl24 width=155 style='mso-width-source:userset;mso-width-alt:5668;
 width:116pt'>
 <col class=xl24 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl24 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl24 width=64 span=2 style='width:48pt'>
 <col class=xl24 width=48 style='mso-width-source:userset;mso-width-alt:1755;
 width:36pt'>
 <col class=xl24 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl24 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl24 width=57 style='mso-width-source:userset;mso-width-alt:2084;
 width:43pt'>
 <col class=xl24 width=64 span=2 style='width:48pt'>
 <col class=xl24 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl24 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl24 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl24 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=13 height=30 class=xl34 width=974 style='height:22.5pt;
  width:731pt'>Cutting Work Instruction</td>
  <td class=xl30 width=51 style='width:38pt'></td>
  <td class=xl30 width=66 style='width:50pt'></td>
  <td class=xl30 width=62 style='width:47pt'></td>
  <td class=xl30 width=81 style='width:61pt'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'>Order No.</td>
  <td colspan=3 class=xl33><%=p_po_no%></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt'>Buyer.</td>
  <td colspan=3 class=xl28 style='border-left:none'><%=p_cust_name%></td>
  <td class=xl28 style='border-left:none'>Group.</td>
  <td colspan=5 class=xl28 style='border-left:none'><%=p_group%></td>
  <td class=xl28 style='border-left:none'>Size.</td>
  <td colspan=2 class=xl28 style='border-left:none'><%=p_size%></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt;border-top:none'>Style No.</td>
  <td colspan=3 class=xl28 style='border-left:none'><%=p_style_no%></td>
  <td class=xl28 style='border-top:none;border-left:none'>Style Name.</td>
  <td colspan=5 class=xl28 style='border-left:none'><%=p_style_name%></td>
  <td class=xl28 style='border-top:none;border-left:none'>T&amp;A.</td>
  <td colspan=2 class=xl28 style='border-left:none'><%=p_t_a%></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt;border-top:none'>Leather.</td>
  <td colspan=12 class=xl35 style='border-right:.5pt solid black;border-left:
  none'><%=p_leather%></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=17 class=xl24 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt'>Group</td>
  <td class=xl29 style='border-left:none'>Mat Code</td>
  <td class=xl29 style='border-left:none'>Mat Name</td>
  <td class=xl29 style='border-left:none'>Color</td>
  <td class=xl29 style='border-left:none'>Net</td>
  <td class=xl29 style='border-left:none'>Loss (%)</td>
  <td class=xl29 style='border-left:none'>Gross</td>
  <td class=xl29 style='border-left:none'>UOM</td>
  <td class=xl29 style='border-left:none'>Component</td>
  <td class=xl29 style='border-left:none'>Picture</td>
  <td class=xl29 style='border-left:none'>Qty</td>
  <td class=xl29 style='border-left:none'>Length</td>
  <td class=xl29 style='border-left:none'>Width</td>
  <td class=xl29 style='border-left:none'>UOM</td>
  <td class=xl29 style='border-left:none'>Net Cons</td>
  <td class=xl29 style='border-left:none'>Loss (%)</td>
  <td class=xl29 style='border-left:none'>Gross Cons</td>
 </tr>
 <% 
     string group_name = "" ;
     for (int i = 0; i < dt.Rows.Count; i++ )
     {
 %>
 <tr height=80 style='mso-height-source:userset;height:60.0pt'>
    <%   
        if (group_name != dt.Rows[i]["group_name"].ToString() )
        {
            group_name = dt.Rows[i]["group_name"].ToString();
    %> 
  <td height=80 class=xl25 style='height:60.0pt;border-top:none'><%=dt.Rows[i]["group_name"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[i]["mat_code"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[i]["mat_name"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[i]["color"].ToString()%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i]["net_qty"].ToString()%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i]["loss_rate"].ToString()%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i]["gross_qty"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[i]["uom1"].ToString()%></td>
<% 
        }
        else
        {%>  
  <td height=80 class=xl25 style='height:60.0pt;border-top:none'></td>
  <td class=xl25 style='border-top:none;border-left:none'></td>
  <td class=xl25 style='border-top:none;border-left:none'></td>
  <td class=xl25 style='border-top:none;border-left:none'></td>
  <td class=xl31 style='border-top:none;border-left:none'></td>
  <td class=xl31 style='border-top:none;border-left:none'></td>
  <td class=xl31 style='border-top:none;border-left:none'></td>
  <td class=xl25 style='border-top:none;border-left:none'></td>          
 <%} %>        
  
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[i]["component"].ToString()%></td>
  <td height=80 class=xl25 width=100 style='height:60.0pt;border-top:none;
  border-left:none;width:75pt'><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
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
   margin-left:1.5pt;margin-top:3pt;width:71.25pt;height:54pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[i]["picture_pk"].ToString()%>&table_name=TES_LGPICTURE" o:title="New Image"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=2 height=4></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=95 height=72 src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[i]["picture_pk"].ToString()%>&table_name=TES_LGPICTURE"
    v:shapes="_x0000_s1025"></td>
    <td width=3></td>
   </tr>
   <tr>
    <td height=4></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:75.0pt;height:60.0pt'></span><![endif]--></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i]["comp_qty"].ToString()%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i]["t_length"].ToString()%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i]["t_width"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[i]["uom2"].ToString()%></td>
  <td class=xl32 style='border-top:none;border-left:none' x:num x:fmla="=L<%=8+i%>*M<%=8+i%>" ></td>
  <td class=xl32 style='border-top:none;border-left:none'><%=dt.Rows[i]["loss_rate"].ToString()%></td>
  <td class=xl32 style='border-top:none;border-left:none' x:num x:fmla="=O<%=8+i%> + O<%=8+i%>*P<%=8+i%>%" ></td>
 </tr>
  <% 
     }
 %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=63 style='width:47pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=155 style='width:116pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=81 style='width:61pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
