<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("sale");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
    
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string p_type        = Request.QueryString["p_type"];
    string p_array_so_pk = Request.QueryString["p_order_list_pk"];
    string p_ref_no      = Request.QueryString["p_ref_no_list"];
	
    DataTable dt, dt1, dt2;
    string str_sql = @"SELECT partner_name, addr1, phone_no, fax_no, tax_code, tco_bpphoto_pk
                       FROM tco_company
                       WHERE del_if = 0 AND pk = (SELECT MAX (pk)
                                                  FROM tco_company
                                                  WHERE del_if = 0 AND active_yn = 'Y')";
    dt = ESysLib.TableReadOpen(str_sql);
    dt1 = ESysLib.TableReadOpenCursor("lg_rpt_dsos00030_1", "   '" + p_type + "' , '" + p_array_so_pk + "'");

    dt2 = ESysLib.TableReadOpenCursor("lg_rpt_dsos00030", "  '" + p_array_so_pk + "'"); 
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_dsos00030_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_dsos00030_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_dsos00030_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr Lee</o:Author>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2012-04-16T03:28:35Z</o:LastPrinted>
  <o:Created>2011-06-10T03:14:58Z</o:Created>
  <o:LastSaved>2012-04-16T03:29:09Z</o:LastSaved>
  <o:Company>Prive</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:0in .05in .37in .05in;
	mso-header-margin:0in;
	mso-footer-margin:.16in;}
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
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet1;}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
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
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style21;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style21;
	color:black;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style21;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style21;
	color:black;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
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
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>71</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>8</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9450</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$6:$6</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2029 style='border-collapse:
 collapse;table-layout:fixed;width:1524pt'>
 <col class=xl25 width=100 span=2 style='mso-width-source:userset;mso-width-alt:
 3657;width:75pt'>
 <col class=xl25 width=282 style='mso-width-source:userset;mso-width-alt:10313;
 width:212pt'>
 <col class=xl25 width=60 span=3 style='mso-width-source:userset;mso-width-alt:
 2194;width:45pt'>
 <col class=xl25 width=81 span=3 style='mso-width-source:userset;mso-width-alt:
 2962;width:61pt'>
 <col class=xl25 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl25 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl25 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <col class=xl25 width=297 style='mso-width-source:userset;mso-width-alt:10861;
 width:223pt'>
 <col class=xl25 width=417 style='mso-width-source:userset;mso-width-alt:15250;
 width:313pt'>
 <col class=xl25 width=64 span=3 style='width:48pt'>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl26 width=100 style='height:18.0pt;width:75pt'><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:4.5pt;margin-top:4.5pt;width:68.25pt;height:42pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape></td>
  <td class=xl27 width=100 style='width:75pt'><%=dt.Rows[0]["partner_name"]%></td>
  <td class=xl27 width=282 style='width:212pt'></td>
  <td class=xl27 width=60 style='width:45pt'></td>
  <td class=xl27 width=60 style='width:45pt'></td>
  <td class=xl27 width=60 style='width:45pt'></td>
  <td class=xl27 width=81 style='width:61pt'></td>
  <td class=xl27 colspan=2 width=162 style='mso-ignore:colspan;width:122pt'>Tel:
  <%=dt.Rows[0]["phone_no"]%></td>
  <td class=xl28 width=100 style='width:75pt'></td>
  <td class=xl28 width=44 style='width:33pt'></td>
  <td class=xl25 width=74 style='width:56pt'></td>
  <td class=xl27 width=297 style='width:223pt'></td>
  <td class=xl27 width=417 style='width:313pt'></td>
  <td class=xl29 width=64 style='width:48pt'></td>
  <td class=xl29 width=64 style='width:48pt'></td>
  <td class=xl29 width=64 style='width:48pt'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl26 style='height:18.0pt'></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'><%=dt.Rows[0]["addr1"]%></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'>Fax: <%=dt.Rows[0]["fax_no"]%></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl26 style='height:18.0pt'></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'>MST: <%=dt.Rows[0]["tax_code"]%></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl30 colspan=2 style='mso-ignore:colspan'>Print Date: <%=DateTime.Now.ToString("dd/MM/yyyy HH:mm")%></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=10 height=40 class=xl38 style='height:30.0pt'>S/O CONSUMPTION</td>
  <td colspan=4 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl32></td>
  <td class=xl29></td>
 </tr>
 
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl33 style='height:21.0pt'>P/O No:</td>
  <td class=xl39 colspan=2 style='mso-ignore:colspan'><%=p_ref_no %></td>
  <td  class=xl33 style='mso-ignore:colspan'>Style:</td>
  <td class=xl39 colspan=3 style='mso-ignore:colspan'><%=dt2.Rows[0]["style"]%></td>
  
  <td  class=xl33 style='mso-ignore:colspan'>Ord Qty:</td>
  <td class=xl39  style='mso-ignore:colspan'><%=dt2.Rows[0]["ord_Qty"]%></td>
  
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl34 style='height:21.0pt'>Group</td>
  <td class=xl34 style='border-left:none'>Mat Code</td>
  <td class=xl34 style='border-left:none'>Mat Name</td>
  <td class=xl34 style='border-left:none'>UOM</td>
  <td class=xl34 style='border-left:none'>Size</td>
  <td class=xl34 style='border-left:none'>Color</td>
  <td class=xl34 style='border-left:none'>Ord Qty</td>
  <td class=xl34 style='border-left:none'>ST Cons</td>
  <td class=xl34 style='border-left:none'>Gross Qty</td>
  <td class=xl34 style='border-left:none'>Remark</td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <%
     string supplier = string.Empty;
     string wh = string.Empty;
     int[] arrSupplier_count = new int[dt1.Rows.Count];
     int b = 0;
     int strSupplier_count = 1;

     for (int z = 0; z < dt1.Rows.Count; z++)
     {
         if (string.IsNullOrEmpty(supplier))
         {
             supplier = dt1.Rows[z]["grp_cd"].ToString();
             strSupplier_count = 1;
         }
         else
         {
             if (dt1.Rows[z]["grp_cd"].ToString().Trim() != supplier.Trim())
             {
                 arrSupplier_count[b] = strSupplier_count;
                 strSupplier_count = 1;
                 b++;
                 supplier = dt1.Rows[z]["grp_cd"].ToString();
             }
             else
             {
                 strSupplier_count++;
             }
         }
     }
     arrSupplier_count[b] = strSupplier_count;
     b = 0;
     supplier = string.Empty;
     wh = string.Empty;

     //========================
     for (int i = 0; i < dt1.Rows.Count; i++)
     {
      %>
 <tr class=xl28 height=36 style='mso-height-source:userset;height:27.0pt'>
  <%
     if (supplier != dt1.Rows[i]["grp_cd"].ToString())
     {
 %>
  <td rowspan=<%=arrSupplier_count[b]%> height=36 class=xl40 width=100 style='height:27.0pt;border-top:none;
  width:75pt'><%=dt1.Rows[i]["grp_cd"]%></td>
    <% 
     supplier = dt1.Rows[i]["grp_cd"].ToString();
     b++;
     }
  %>  
  <td class=xl40 width=100 style='border-top:none;border-left:none;width:75pt'><%=dt1.Rows[i]["item_code"]%></td>
  <td class=xl40 width=282 style='border-top:none;border-left:none;width:212pt'><%=dt1.Rows[i]["item_name"]%></td>
  <td class=xl40 width=60 style='border-top:none;border-left:none;width:45pt'><%=dt1.Rows[i]["mat_uom"]%></td>
  <td class=xl40 width=60 style='border-top:none;border-left:none;width:45pt'><%=dt1.Rows[i]["t_size"]%></td>
  <td class=xl40 width=60 style='border-top:none;border-left:none;width:45pt'><%=dt1.Rows[i]["t_color"]%></td>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["ord_qty"]%>aaaaaa</td>
  <td class=xl41 style='border-top:none;border-left:none'
  x:num><%=dt1.Rows[i]["st_cons_qty"]%></td>
  <td class=xl41 style='border-top:none;border-left:none'
  x:num><%=dt1.Rows[i]["total_cons_qty"]%></td>
  <td class=xl42 style='border-top:none;border-left:none'><%=dt1.Rows[i]["pattern_group_name"]%></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl37 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
  <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=282 style='width:212pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=297 style='width:223pt'></td>
  <td width=417 style='width:313pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
