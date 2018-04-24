<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string p_sa_stock_adjust_m_pk   = Request.QueryString["p_sa_stock_adjust_m_pk"];
    string p_item                   = Request.QueryString["p_item"];
    string para = " '" + p_sa_stock_adjust_m_pk + "','" + p_item + "'";
    DataTable dt, dt1;
    string str_sql = @"SELECT partner_name, addr1, phone_no, fax_no, tax_code, tco_bpphoto_pk
                       FROM tco_company
                       WHERE del_if = 0 AND pk = (SELECT MAX (pk)
                                                  FROM tco_company
                                                  WHERE del_if = 0 AND active_yn = 'Y')";
    dt1 = ESysLib.TableReadOpen(str_sql);	
    dt = ESysLib.TableReadOpenCursor("LG_RPT_BISA00010", para);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_bisa00020_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_bisa00020_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_bisa00020_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2012-09-04T07:34:48Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2012-09-04T07:34:55Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P of &N";
	margin:.1in .1in .4in .1in;
	mso-header-margin:0in;
	mso-footer-margin:.1in;
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
	font-family:돋움, monospace;
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
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
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
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:right;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl37
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>210</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
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
       <x:ActiveCol>6</x:ActiveCol>
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
  <x:WindowHeight>12120</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$5:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1025"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1030 style='border-collapse:
 collapse;table-layout:fixed;width:773pt'>
 <col class=xl25 width=28 style='mso-width-source:userset;mso-width-alt:1024;
 width:21pt'>
 <col class=xl25 width=95 style='mso-width-source:userset;mso-width-alt:3474;
 width:71pt'>
 <col class=xl25 width=152 style='mso-width-source:userset;mso-width-alt:5558;
 width:114pt'>
 <col class=xl25 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl25 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl25 width=80 span=2 style='mso-width-source:userset;mso-width-alt:
 2925;width:60pt'>
 <col class=xl25 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 <col class=xl25 width=95 style='mso-width-source:userset;mso-width-alt:3474;
 width:71pt'>
 <col class=xl25 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl25 width=95 style='mso-width-source:userset;mso-width-alt:3474;
 width:71pt'>
 <col class=xl25 width=125 style='mso-width-source:userset;mso-width-alt:4571;
 width:94pt'>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 width=28 style='height:15.0pt;width:21pt'></td>
  <td class=xl25 width=95 style='width:71pt'><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:1.5pt;margin-top:1.5pt;width:75pt;height:42pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt1.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape></td>
  <td class=xl27 width=152 style='width:114pt'><%= dt1.Rows[0]["partner_name"]%></td>
  <td class=xl26 width=45 style='width:34pt'></td>
  <td class=xl26 width=70 style='width:53pt'></td>
  <td class=xl25 width=80 style='width:60pt'></td>
  <td colspan=2 class=xl32 width=165 style='width:124pt'></td>
  <td colspan=3 class=xl32 width=270 style='width:202pt'>Tel: <%= dt1.Rows[0]["phone_no"]%></td>
  <td class=xl25 width=125 style='width:94pt'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl26><%= dt1.Rows[0]["addr1"]%></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=2 class=xl32 width=165 style='width:124pt'></td>
  <td colspan=3 class=xl32 width=270 style='width:202pt'>Fax: <%= dt1.Rows[0]["fax_no"]%></td>
  <td class=xl25></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl26>Tax code: <%= dt1.Rows[0]["tax_code"]%></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=2 class=xl37 width=165 style='width:124pt'></td>
  <td colspan=3 class=xl37 width=270 style='width:202pt'>Print date : <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
  <td class=xl25></td>
 </tr>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td colspan=12 height=45 class=xl36 width=1030 style='height:33.75pt;
  width:773pt'>STOCK EVALUATION</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl28 width=28 style='height:15.0pt;border-top:none;
  width:21pt'>Seq</td>
  <td class=xl28 width=95 style='border-top:none;width:71pt'>Item Code</td>
  <td class=xl28 width=152 style='border-top:none;width:114pt'>Item Name</td>
  <td class=xl28 width=45 style='border-top:none;width:34pt'>UOM</td>
  <td class=xl28 width=70 style='border-top:none;width:53pt'>Lot No</td>
  <td class=xl28 width=80 style='border-top:none;width:60pt'>Stock Qty</td>
  <td class=xl28 width=80 style='border-top:none;width:60pt'>Check Qty</td>
  <td class=xl28 width=85 style='border-top:none;width:64pt'>Unit Price</td>
  <td class=xl28 width=95 style='border-top:none;width:71pt'>Check Amount</td>
  <td class=xl28 width=80 style='border-top:none;width:60pt'>Gap Qty</td>
  <td class=xl28 width=95 style='border-top:none;width:71pt'>Gap Amount</td>
  <td class=xl28 width=125 style='border-top:none;width:94pt'>Remark</td>
 </tr>
 <%
     for (int i = 0; i < dt.Rows.Count; i++)
     {
      %>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl29 style='height:18.75pt' x:num><%= dt.Rows[i]["seq"] %></td>
  <td class=xl30><%= dt.Rows[i]["item_code"]%></td>
  <td class=xl33><%= dt.Rows[i]["item_name"]%></td>
  <td class=xl29><%= dt.Rows[i]["uom"]%></td>
  <td class=xl29><%= dt.Rows[i]["lot_no"]%></td>
  <td class=xl31 x:num><span style='mso-spacerun:yes'>    
  </span><%= dt.Rows[i]["stock_qty"]%></td>
  <td class=xl31 x:num><span style='mso-spacerun:yes'>    
  </span><%= dt.Rows[i]["check_qty"]%></td>
  <td class=xl34 x:num><span style='mso-spacerun:yes'>  
  </span><%= dt.Rows[i]["check_price"]%></td>
  <td class=xl34 x:num><span style='mso-spacerun:yes'>                  
  </span><%= dt.Rows[i]["check_amount"]%></td>
  <td class=xl31 x:num><span style='mso-spacerun:yes'>            
  </span><%= dt.Rows[i]["adjust_qty"]%></td>
  <td class=xl34 x:num><span style='mso-spacerun:yes'>                  
  </span><%= dt.Rows[i]["adjust_amount"]%></td>
  <td class=xl33><%= dt.Rows[i]["description"]%></td>
 </tr>
 <%} %>
 <tr height=14 style='height:10.5pt'>
  <td height=14 colspan=12 class=xl25 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='height:10.5pt'>
  <td height=14 colspan=12 class=xl25 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='height:10.5pt'>
  <td height=14 colspan=9 class=xl25 style='height:10.5pt;mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=28 style='width:21pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=152 style='width:114pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=125 style='width:94pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
