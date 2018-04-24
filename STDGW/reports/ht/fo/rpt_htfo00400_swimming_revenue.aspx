<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("crm");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%

 
	string l_dtfrm =Request["p_dtfrom"];  
	string l_dtto =Request["p_dtto"];
	string l_invoice =Request["p_invoice"];
	string l_room_no =Request["p_roomno"];
	string l_delete =Request["p_delete"];
	
	string l_parameter="";
     l_parameter = "'" + l_dtfrm + "','" + l_dtto + "','" + l_invoice + "','" + l_room_no + "','" + l_delete + "'";
    DataTable dt = ESysLib.TableReadOpenCursor("crm.sp_sel_htfo00400", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
	string l_print_date="",l_dtfrm_dtto="";
	string SQL3 = "select to_char(sysdate,'dd-Mon-yyyy hh24:mi') print_date from dual";
    DataTable dt_sysdate = ESysLib.TableReadOpen(SQL3);
    if (dt_sysdate.Rows.Count > 0)
    {
        l_print_date = dt_sysdate.Rows[0][0].ToString(); 
    }
	l_dtfrm_dtto = "   " + l_dtfrm.Substring(6, 2) + "/" + l_dtfrm.Substring(4, 2) + "/" + l_dtfrm.Substring(0, 4) + "  ~  " + l_dtto.Substring(6, 2) + "/" + l_dtto.Substring(4, 2) + "/" + l_dtto.Substring(0, 4);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_htfo00400_swimming_revenue_files/filelist.xml">
<link rel=Edit-Time-Data
href="rpt_htfo00400_swimming_revenue_files/editdata.mso">
<link rel=OLE-Object-Data
href="rpt_htfo00400_swimming_revenue_files/oledata.mso">
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
  <o:LastPrinted>2011-08-03T01:30:06Z</o:LastPrinted>
  <o:Created>2011-07-23T08:04:51Z</o:Created>
  <o:LastSaved>2011-08-03T01:32:59Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P";
	margin:.42in .26in .28in .31in;
	mso-header-margin:.41in;
	mso-footer-margin:.28in;}
.font6
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
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:right;
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	color:red;
	font-size:16.0pt;
	text-align:center;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	text-align:center;}
.xl40
	{mso-style-parent:style0;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
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
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
       <x:ActiveCol>13</x:ActiveCol>
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
  <x:WindowHeight>8745</x:WindowHeight>
  <x:WindowWidth>20490</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="3073"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=966 style='border-collapse:
 collapse;table-layout:fixed;width:724pt'>
 <col width=80 style='mso-width-source:userset;mso-width-alt:2925;width:60pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:3657;width:75pt'>
 <col width=37 style='mso-width-source:userset;mso-width-alt:1353;width:28pt'>
 <col width=127 style='mso-width-source:userset;mso-width-alt:4644;width:95pt'>
 <col width=154 style='mso-width-source:userset;mso-width-alt:5632;width:116pt'>
 <col width=75 style='mso-width-source:userset;mso-width-alt:2742;width:56pt'>
 <col width=63 span=2 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col width=67 style='mso-width-source:userset;mso-width-alt:2450;width:50pt'>
 <col width=64 style='width:48pt'>
 <col width=45 style='mso-width-source:userset;mso-width-alt:1645;width:34pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <tr height=110 style='mso-height-source:userset;height:82.5pt'>
  <td colspan=2 height=110 width=180 style='height:82.5pt;width:135pt'
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
   margin-left:3pt;margin-top:3.75pt;width:129.75pt;height:72.75pt;z-index:1'>
   <v:imagedata src="rpt_htfo00400_swimming_revenue_files/image001.jpg"
    o:title="AMCO"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:4px;margin-top:5px;width:173px;
  height:97px'><img width=173 height=97
  src="rpt_htfo00400_swimming_revenue_files/image002.jpg" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=2 height=110 class=xl39 width=180 style='height:82.5pt;
    width:135pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=8 class=xl38 width=650 style='width:487pt'>Swimming Revenue
  Report</td>
  <td colspan=2 height=110 width=136 style='height:82.5pt;width:102pt'
  align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1027" type="#_x0000_t75"
   style='position:absolute;margin-left:1.5pt;margin-top:4.5pt;width:97.5pt;
   height:74.25pt;z-index:2'>
   <v:imagedata src="rpt_htfo00400_swimming_revenue_files/image003.jpg"
    o:title="image002"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:2px;margin-top:6px;width:130px;
  height:99px'><img width=130 height=99
  src="rpt_htfo00400_swimming_revenue_files/image004.jpg" v:shapes="_x0000_s1027"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=2 height=110 class=xl38 width=136 style='height:82.5pt;
    width:102pt'></td>
   </tr>
  </table>
  </span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl41 style='height:12.75pt'>Date:<font
  class="font6"><%=l_dtfrm_dtto%></font></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29></td>
  <td class=xl29></td>
  <td class=xl24></td>
  <td class=xl30>Print Time:</td>
  <td colspan=2 class=xl40><%=l_print_date%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 style='height:12.75pt;border-top:none'>Date</td>
  <td class=xl26 style='border-top:none;border-left:none'>Invoice#</td>
  <td class=xl26 style='border-top:none;border-left:none'>RM#</td>
  <td class=xl26 style='border-left:none'>Last Name</td>
  <td class=xl26 style='border-left:none'>First Name</td>
  <td class=xl26 style='border-left:none'>Amount</td>
  <td class=xl26 style='border-left:none'>Discount</td>
  <td class=xl26 style='border-left:none'>SVC Amt</td>
  <td class=xl26 style='border-left:none'>VAT Amt</td>
  <td class=xl26 style='border-top:none;border-left:none'>Total due</td>
  <td class=xl26 style='border-top:none;border-left:none'>Rate</td>
  <td class=xl26 style='border-top:none;border-left:none'>Total due(VND)</td>
 </tr>
 <%
	 decimal l_sum_total=0,l_sum_discount=0,l_svc_amt=0,l_vat_amt=0,l_sum_fee_amt_usd=0,l_sum_total_due_vnd=0;
     for (int i = 0; i < dt.Rows.Count; i++)
     {
			if(dt.Rows[i]["total_amt"].ToString() !="")
			{
				l_sum_total =l_sum_total +decimal.Parse(dt.Rows[i]["total_amt"].ToString());
				l_sum_discount=l_sum_discount +decimal.Parse(dt.Rows[i]["discount_amt"].ToString());
				l_svc_amt=l_svc_amt +decimal.Parse(dt.Rows[i]["svc_amt"].ToString());
				l_vat_amt=l_vat_amt +decimal.Parse(dt.Rows[i]["vat_amt"].ToString());
				l_sum_fee_amt_usd=l_sum_fee_amt_usd +decimal.Parse(dt.Rows[i]["total_due"].ToString());
				l_sum_total_due_vnd=l_sum_total_due_vnd +decimal.Parse(dt.Rows[i]["total_due_vnd"].ToString());
			}
          %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl27 style='height:13.5pt;border-top:none'><%=dt.Rows[i]["invoice_date_rpt"].ToString()%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i]["invoice_id"].ToString()%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dt.Rows[i]["room_no"].ToString()%></td>
  <td class=xl36 style='border-top:none;border-left:none'><%=dt.Rows[i]["last_name"].ToString()%></td>
  <td class=xl36 style='border-top:none;border-left:none'><%=dt.Rows[i]["first_name"].ToString()%></td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["total_amt"].ToString()%></td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["discount_amt"].ToString()%></td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["svc_amt"].ToString()%></td>
  <td class=xl33 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i]["vat_amt"].ToString()%></td>
  <td class=xl33 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i]["total_due"].ToString()%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i]["rate"].ToString()%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i]["total_due_vnd"].ToString()%></td>
 </tr>
 <%}%>
 <tr height=17 style='height:12.75pt'>
  <td colspan=5 height=17 class=xl37 style='height:12.75pt'>Total:</td>
  <td class=xl31 align=right style='border-top:none;border-left:none'
  x:num><%=l_sum_total%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'
  x:num><%=l_sum_discount%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'
  x:num><%=l_svc_amt%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'
  x:num><%=l_vat_amt%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'
  x:num><%=l_sum_fee_amt_usd%></td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 align=right style='border-top:none;border-left:none'
  x:num><%=l_sum_total_due_vnd%></td>
 </tr>
 <tr height=272 style='height:204.0pt;mso-xlrowspan:16'>
  <td height=272 colspan=12 style='height:204.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=12 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=80 style='width:60pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=127 style='width:95pt'></td>
  <td width=154 style='width:116pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=91 style='width:68pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
