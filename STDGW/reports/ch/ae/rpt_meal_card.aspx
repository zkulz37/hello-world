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
    String emp_pk,p_month;
    emp_pk = Request["emp_pk"].ToString();
    p_month= Request["l_month"].ToString();
    string SQL
    = "SELECT  e.photo_pk a0 " +
        "      ,to_char(to_date('" + p_month + "','yyyymm'),'mm/yyyy') a1   " + 
        "      ,e.full_name a2   " + 
        "      ,c.org_nm a3   " + 
        "      , e.emp_id AS a4 " +
        "      ,(select PARTNER_LNAME from tco_company p where p.del_if=0 and p.pk=c.tco_company_pk) a5" +
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
<link rel=File-List href="rpt_meal_card_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_meal_card_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_meal_card_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mrs Huong</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2011-06-20T02:39:30Z</o:LastPrinted>
  <o:Created>2011-06-18T03:16:26Z</o:Created>
  <o:LastSaved>2011-06-20T02:43:36Z</o:LastSaved>
  <o:Company>AMB</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .17in .17in .26in;
	mso-header-margin:.16in;
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
	font-size:18.0pt;
	text-align:center;
	border:.5pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl28
	{mso-style-parent:style0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl31
	{mso-style-parent:style0;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl33
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	text-align:left;
	padding-left:12px;
	mso-char-indent-count:1;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	padding-left:24px;
	mso-char-indent-count:2;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-rotate:-90;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-rotate:-90;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-rotate:-90;}
.xl40
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl41
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;
	}
.xl49
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
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
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
     <x:PageBreaks>
     <x:RowBreaks>
      <% 
        int ibreak=0;
        for (int j=0;j<irow/2;j++)
        {
            ibreak+=32 ;
            %>
            
            <x:RowBreak>
                <x:Row><%=ibreak %></x:Row>
            </x:RowBreak>
            <%    
               
                
        }  
      %>
      
     </x:RowBreaks>
    </x:PageBreaks>
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
  <x:WindowHeight>8445</x:WindowHeight>
  <x:WindowWidth>19320</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1027"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1016 style='border-collapse:
 collapse;table-layout:fixed;width:767pt'>
  <% int i = 0;
    int k=0;
    while (i < irow)
    {     
        k=i+1;
 %>
 <col width=8 style='mso-width-source:userset;mso-width-alt:292;width:6pt'>
 <col width=49 span=10 style='mso-width-source:userset;mso-width-alt:1792;
 width:37pt'>
 <col width=8 style='mso-width-source:userset;mso-width-alt:292;width:6pt'>
 <col width=4 style='mso-width-source:userset;mso-width-alt:146;width:3pt'>
 <col width=8 style='mso-width-source:userset;mso-width-alt:292;width:6pt'>
 <col width=49 span=10 style='mso-width-source:userset;mso-width-alt:1792;
 width:37pt'>
 <col width=8 style='mso-width-source:userset;mso-width-alt:292;width:6pt'>
 <tr height=7 style='mso-height-source:userset;height:5.25pt'>
  <td height=7 class=xl27 width=8 style='height:5.25pt;width:6pt'>&nbsp;</td>
  <td class=xl28 width=49 style='width:37pt'>&nbsp;</td>
  <td class=xl28 width=49 style='width:37pt'>&nbsp;</td>
  <td class=xl28 width=49 style='width:37pt'>&nbsp;</td>
  <td class=xl28 width=49 style='width:37pt'>&nbsp;</td>
  <td class=xl28 width=49 style='width:37pt'>&nbsp;</td>
  <td class=xl28 width=49 style='width:37pt'>&nbsp;</td>
  <td class=xl28 width=49 style='width:37pt'>&nbsp;</td>
  <td class=xl28 width=49 style='width:37pt'>&nbsp;</td>
  <td class=xl28 width=49 style='width:37pt'>&nbsp;</td>
  <td class=xl28 width=49 style='width:37pt'>&nbsp;</td>
  <td class=xl29 width=8 style='width:6pt'>&nbsp;</td>
  <td width=4 style='width:3pt'></td>
  <td class=xl27 width=8 style='width:6pt'>&nbsp;</td>
  <td class=xl28 width=49 style='width:37pt'>&nbsp;</td>
  <td class=xl28 width=49 style='width:37pt'>&nbsp;</td>
  <td class=xl28 width=49 style='width:37pt'>&nbsp;</td>
  <td class=xl28 width=49 style='width:37pt'>&nbsp;</td>
  <td class=xl28 width=49 style='width:37pt'>&nbsp;</td>
  <td class=xl28 width=49 style='width:37pt'>&nbsp;</td>
  <td class=xl28 width=49 style='width:37pt'>&nbsp;</td>
  <td class=xl28 width=49 style='width:37pt'>&nbsp;</td>
  <td class=xl28 width=49 style='width:37pt'>&nbsp;</td>
  <td class=xl28 width=49 style='width:37pt'>&nbsp;</td>
  <td class=xl29 width=8 style='width:6pt'>&nbsp;</td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td height=27 class=xl30 style='height:20.25pt'>&nbsp;</td>
  <td colspan=2 rowspan=5 height=136 width=98 style='border-right:2.0pt double black;
  border-bottom:.5pt solid black;height:102.0pt;width:74pt' align=left
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
   margin-left:2.25pt;margin-top:2.25pt;width:69pt;height:97.5pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_total.Rows[i][0].ToString()%>&table_name=TC_FSBINARY" o:title="Water lilies"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:3px;margin-top:3px;width:92px;
  height:130px'><img width=92 height=130 src="rpt_meal_card_files/image002.jpg"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=2 rowspan=5 height=136 class=xl42 width=98 style='border-right:
    2.0pt double black;border-bottom:.5pt solid black;height:102.0pt;
    width:74pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td rowspan=5 class=xl37 style='border-bottom:.5pt solid black'>MONTH:
  <%=dt_total.Rows[i][1].ToString()%></td>
  <td colspan=7 class=xl40><%=dt_total.Rows[i][5].ToString()%></td>
  <td class=xl31>&nbsp;</td>
  <td></td>
  <%
        //Hình 2
        k=i+1;
        if (k < irow)
        {
   %>
  <td class=xl30>&nbsp;</td>
  <td colspan=2 rowspan=5 height=136 width=98 style='border-right:2.0pt double black;
  border-bottom:.5pt solid black;height:102.0pt;width:74pt' align=left
  valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1026" type="#_x0000_t75"
   style='position:absolute;margin-left:2.25pt;margin-top:2.25pt;width:69pt;
   height:97.5pt;z-index:2'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_total.Rows[k][0].ToString()%>&table_name=TC_FSBINARY"  o:title="Water lilies"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:3px;margin-top:3px;width:92px;
  height:130px'><img width=92 height=130 src="rpt_meal_card_files/image002.jpg"
  v:shapes="_x0000_s1026"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=2 rowspan=5 height=136 class=xl42 width=98 style='border-right:
    2.0pt double black;border-bottom:.5pt solid black;height:102.0pt;
    width:74pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td rowspan=5 class=xl37 style='border-bottom:.5pt solid black'>MONTH: <%=dt_total.Rows[k][1].ToString()%></td>
  <td colspan=7 class=xl40><%=dt_total.Rows[i][5].ToString()%></td>
  <td class=xl31>&nbsp;</td>
  <%
        }   //end if %>
 </tr>
 
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl30 style='height:18.75pt'>&nbsp;</td>
  <td colspan=7 class=xl41>Meal Card</td>
  <td class=xl31>&nbsp;</td>
  <td></td>
  <%
        //Hình 2
        if (k < irow)
        {
   %>
  <td class=xl30>&nbsp;</td>
  <td colspan=7 class=xl41>Meal Card</td>
  <td class=xl31>&nbsp;</td>
   <%
        }   //end if %>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl30 style='height:21.0pt'>&nbsp;</td>
  <td class=xl36 colspan=2 style='mso-ignore:colspan'>Name:</td>
  <td colspan=5 class=xl49><%=dt_total.Rows[i][2].ToString()%></td>
  <td class=xl31>&nbsp;</td>
  <td></td>
   <%
        //Hình 2
        if (k < irow)
        {
   %>
  <td class=xl30>&nbsp;</td>
  <td class=xl36 colspan=2 style='mso-ignore:colspan'>Name:</td>
  <td colspan=5 class=xl49><%=dt_total.Rows[k][2].ToString()%></td>
  <td class=xl31>&nbsp;</td>
   <%
        }   //end if %>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl30 style='height:21.0pt'>&nbsp;</td>
  <td class=xl36 colspan=4 style='mso-ignore:colspan'>Department/Team:</td>
  <td colspan=3 class=xl48><%=dt_total.Rows[i][3].ToString()%></td>
  <td class=xl31>&nbsp;</td>
  <td></td>
  <%
        //Hình 2
        if (k < irow)
        {
   %>
  <td class=xl30>&nbsp;</td>
  <td class=xl36 colspan=4 style='mso-ignore:colspan'>Department/Team:</td>
  <td colspan=3 class=xl48><%=dt_total.Rows[k][3].ToString()%></td>
  <td class=xl31>&nbsp;</td>
  <%
        }   //end if %>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl30 style='height:21.0pt'>&nbsp;</td>
  <td class=xl36 colspan=3 style='mso-ignore:colspan'>Employee ID:</td>
  <td colspan=4 class=xl48><%=dt_total.Rows[i][4].ToString()%></td>
  <td class=xl31>&nbsp;</td>
  <td></td>
  <%
        //Hình 2
        if (k < irow)
        {
   %>
  <td class=xl30>&nbsp;</td>
  <td class=xl36 colspan=3 style='mso-ignore:colspan'>Employee ID:</td>
  <td colspan=4  class=xl48><%=dt_total.Rows[k][4].ToString()%></td>
  <td class=xl31>&nbsp;</td>
  <%
        }   //end if %>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl30 style='height:12.75pt'>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
  <td class=xl31>&nbsp;</td>
  <td></td>
  <%
        //Hình 2
        if (k < irow)
        {
   %>
  <td class=xl30>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
  <td class=xl31>&nbsp;</td> 
  <%
        }   //end if %>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl30 style='height:24.95pt'>&nbsp;</td>
  <td class=xl24 x:num>21</td>
  <td class=xl24 style='border-left:none' x:num>22</td>
  <td class=xl24 style='border-left:none' x:num>23</td>
  <td class=xl24 style='border-left:none' x:num>24</td>
  <td class=xl24 style='border-left:none' x:num>25</td>
  <td class=xl24 style='border-left:none' x:num>26</td>
  <td class=xl24 style='border-left:none' x:num>27</td>
  <td class=xl24 style='border-left:none' x:num>28</td>
  <td class=xl24 style='border-left:none' x:num>29</td>
  <td class=xl24 style='border-left:none' x:num>30</td>
  <td class=xl31>&nbsp;</td>
  <td></td>
  <%
        //Hình 2
        if (k < irow)
        {
   %>
  <td class=xl30>&nbsp;</td>
  <td class=xl24 x:num>21</td>
  <td class=xl24 style='border-left:none' x:num>22</td>
  <td class=xl24 style='border-left:none' x:num>23</td>
  <td class=xl24 style='border-left:none' x:num>24</td>
  <td class=xl24 style='border-left:none' x:num>25</td>
  <td class=xl24 style='border-left:none' x:num>26</td>
  <td class=xl24 style='border-left:none' x:num>27</td>
  <td class=xl24 style='border-left:none' x:num>28</td>
  <td class=xl24 style='border-left:none' x:num>29</td>
  <td class=xl24 style='border-left:none' x:num>30</td>
  <td class=xl31>&nbsp;</td>
  <%
        }   //end if %>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl30 style='height:24.95pt'>&nbsp;</td>
  <td class=xl24 style='border-top:none' x:num>31</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>7</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>8</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>9</td>
  <td class=xl31>&nbsp;</td>
  <td></td>
  <%
        //Hình 2
        if (k < irow)
        {
   %>
  <td class=xl30>&nbsp;</td>
  <td class=xl24 style='border-top:none' x:num>31</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>7</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>8</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>9</td>
  <td class=xl31>&nbsp;</td>
  <%
        }   //end if %>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl30 style='height:24.95pt'>&nbsp;</td>
  <td class=xl24 style='border-top:none' x:num>10</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>11</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>12</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>13</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>14</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>15</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>16</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>17</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>18</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>19</td>
  <td class=xl31>&nbsp;</td>
  <td></td>
  <%
        //Hình 2
        if (k < irow)
        {
   %>
  <td class=xl30>&nbsp;</td>
  <td class=xl24 style='border-top:none' x:num>10</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>11</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>12</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>13</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>14</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>15</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>16</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>17</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>18</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>19</td>
  <td class=xl31>&nbsp;</td>
  <%
        }   //end if %>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl30 style='height:24.95pt'>&nbsp;</td>
  <td class=xl24 style='border-top:none' x:num>20</td>
  <td class=xl24 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td></td>
  <%
        //Hình 2
        if (k < irow)
        {
   %>
  <td class=xl30>&nbsp;</td>
  <td class=xl24 style='border-top:none' x:num>20</td>
  <td class=xl24 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
   <%
        }   //end if %>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl30 style='height:15.75pt'>&nbsp;</td>
  <td class=xl26 colspan=2 style='mso-ignore:colspan'>Overtime:</td>
  <td colspan=8 style='mso-ignore:colspan'></td>
  <td class=xl31>&nbsp;</td>
  <td></td>
  <%
        //Hình 2
        if (k < irow)
        {
   %>
  <td class=xl30>&nbsp;</td>
  <td class=xl26 colspan=2 style='mso-ignore:colspan'>Overtime:</td>
  <td colspan=8 style='mso-ignore:colspan'></td>
  <td class=xl31>&nbsp;</td>
  <%
        }   //end if %>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl30 style='height:24.95pt'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25 style='border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-left:none'>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td></td>
  <%
        //Hình 2
        if (k < irow)
        {
   %>
  <td class=xl30>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25 style='border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-left:none'>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <%
        }   //end if %>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl30 style='height:15.75pt'>&nbsp;</td>
  <td class=xl26 colspan=6 style='mso-ignore:colspan'>Vui lòng mang theo Meal
  Card khi đi ăn.</td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td class=xl31>&nbsp;</td>
  <td></td>
  <%
        //Hình 2
        if (k < irow)
        {
   %>
  <td class=xl30>&nbsp;</td>
  <td class=xl26 colspan=6 style='mso-ignore:colspan'>Vui lòng mang theo Meal
  Card khi đi ăn.</td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td class=xl31>&nbsp;</td>
  <%
        }   //end if %>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 class=xl32 style='height:6.0pt'>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td></td>
  <%
        //Hình 2
        if (k < irow)
        {
   %>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
   <%
        }   //end if %>
 </tr>
 
 <tr height=4 style='mso-height-source:userset;height:3.0pt'>
  <td height=4 colspan=25 style='height:3.0pt;mso-ignore:colspan'></td>
 </tr>
<%
       
    i=i+2;
    }       //end while
  %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=8 style='width:6pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=8 style='width:6pt'></td>
  <td width=4 style='width:3pt'></td>
  <td width=8 style='width:6pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=8 style='width:6pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
