<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("sale");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    DataTable dt, dt1;
    dt = ESysLib.TableReadOpenCursor("LG_RPT_EPBP00311");
    
	string p_tlg_po_pr_d_pk	=	Request.QueryString["p_tlg_po_pr_d_pk"];
    dt1 = ESysLib.TableReadOpenCursor("LG_RPT_EPBP00311_1", "'" + p_tlg_po_pr_d_pk + "'");
    if (dt1.Rows.Count == 0) Response.End();
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_epbp00311_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_epbp00311_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_epbp00311_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>VNG</o:Author>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2012-06-25T06:52:11Z</o:LastPrinted>
  <o:Created>2012-06-25T06:09:33Z</o:Created>
  <o:LastSaved>2012-06-25T08:45:51Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.16in .24in .2in .24in;
	mso-header-margin:.51in;
	mso-footer-margin:.16in;
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
.xl28
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl30
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	color:black;
	font-size:18.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	color:black;
	font-size:18.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	color:black;
	font-size:18.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	color:black;
	font-size:18.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-number-format:"_-* \#\,\#\#0\.0#_-\;\\-* \#\,\#\#0\.0#_-\;_-* \0022-\0022??_-\;_-\@_-";
	mso-font-charset:0;
	text-align:right;
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
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:Scale>96</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>8</x:ActiveCol>
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
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>18075</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl28>

<table x:str border=0 cellpadding=0 cellspacing=0 width=996 style='border-collapse:
 collapse;table-layout:fixed;width:748pt'>
 <col class=xl29 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl29 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl28 width=147 style='mso-width-source:userset;mso-width-alt:5376;
 width:110pt'>
 <col class=xl28 width=144 style='mso-width-source:userset;mso-width-alt:5266;
 width:108pt'>
 <col class=xl28 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl28 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl28 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl28 width=91 style='mso-width-source:userset;mso-width-alt:3328;
 width:68pt'>
 <col class=xl28 width=105 style='mso-width-source:userset;mso-width-alt:3840;
 width:79pt'>
 <col class=xl28 width=64 style='width:48pt'>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl30 width=89 style='height:15.0pt;width:67pt'><!--[if gte vml 1]><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:5.5pt;margin-top:5.5pt;width:75pt;height:42pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>No Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--></td>
  <td class=xl30 width=93 style='width:70pt'></td>
  <td colspan=4 class=xl34 width=461 style='width:346pt'><%= dt.Rows[0]["partner_name"] %></td>
  <td colspan=4 class=xl35 width=353 style='width:265pt'>Tel: <%= dt.Rows[0]["phone_no"] %></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl30 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl35 width=461 style='width:346pt'><%= dt.Rows[0]["addr1"] %></td>
  <td colspan=4 class=xl35 width=353 style='width:265pt'>Fax:<span
  style='mso-spacerun:yes'></span><%= dt.Rows[0]["fax_no"] %></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl31 width=89 style='height:15.0pt;width:67pt'>&nbsp;</td>
  <td class=xl31 width=93 style='width:70pt'>&nbsp;</td>
  <td colspan=4 class=xl36 width=461 style='width:346pt'>MST: <%= dt.Rows[0]["tax_code"] %></td>
  <td colspan=4 class=xl37 width=353 style='width:265pt'>Print date: <%=DateTime.Now.ToString("dd/MM/yyyy hh:mm") %></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=2 class=xl29 style='height:7.5pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=10 rowspan=2 height=43 class=xl38 width=996 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:32.25pt;width:748pt'>&#44396;&#47588;
  &#44208;&#44284;<span style='mso-spacerun:yes'></span>&#48143;
  &#44228;&#54925;&#49436; [K&#7870; HO&#7840;CH, K&#7870;T QU&#7842; MUA HÀNG]</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
 </tr>
 <tr height=9 style='mso-height-source:userset;height:6.75pt'>
  <td height=9 colspan=5 class=xl32 style='height:6.75pt;mso-ignore:colspan'></td>
  <td class=xl33></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td rowspan=2 height=55 class=xl42 width=89 style='height:41.25pt;width:67pt'>&#51217;&#49688;&#51068;&#51088;<br>
    Ngày ti&#7871;p nh&#7853;n</td>
  <td rowspan=2 class=xl42 width=93 style='width:70pt'>&#52397;&#44396;&#48512;&#49436;<br>
    B&#7897; ph&#7853;n yêu c&#7847;u</td>
  <td colspan=2 class=xl42 width=291 style='border-left:none;width:218pt'>&#54408;
  &#47749; Tên Hàng</td>
  <td rowspan=2 class=xl42 width=100 style='width:75pt'>&#44508;&#44201;<br>
    Quy cách</td>
  <td rowspan=2 class=xl42 width=70 style='width:53pt'>&#45800;&#50948;<br>
    &#272;&#417;n V&#7883;</td>
  <td rowspan=2 class=xl42 width=93 style='width:70pt'>&#49688;&#47049;<br>
    S&#7889; L&#432;&#7907;ng</td>
  <td rowspan=2 class=xl42 width=91 style='width:68pt'>&#51077;&#44256;&#51068;&#51088;<br>
    Ngày nh&#7853;p</td>
  <td rowspan=2 class=xl42 width=105 style='width:79pt'>&#49688;&#47161;&#51088;<br>
    &#54869;&#51064;<br>
    Ng&#432;&#7901;i nh&#7853;n</td>
  <td rowspan=2 class=xl42 width=64 style='width:48pt'>&#48708;&#44256;<br>
    Ghi chú</td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 class=xl42 width=147 style='height:24.75pt;border-top:none;
  border-left:none;width:110pt'>&#48288;&#53944;&#45224;&#50612;<br>
    Tên ti&#7871;ng Vi&#7879;t</td>
  <td class=xl42 width=144 style='border-top:none;border-left:none;width:108pt'>&#54620;&#44397;&#50612;<br>
    Tên Ti&#7871;ng Hàn</td>
 </tr>
   <%
       string req_date = string.Empty;
       string dept = string.Empty;
       int[] arr_req_date_count = new int[100];
       int b = 0;
       int req_date_count = 1;

       for (int z = 0; z < dt1.Rows.Count; z++)
       {
           if (req_date == "" || req_date == null)
           {
               req_date = dt1.Rows[z]["req_date"].ToString();
               dept = dt1.Rows[z]["dept_name"].ToString();
               req_date_count = 1;
           }
           else
           {
               if (dt1.Rows[z]["req_date"].ToString().Trim() != req_date.Trim() || dt1.Rows[z]["dept_name"].ToString().Trim() != dept.Trim())
               {
                   arr_req_date_count[b] = req_date_count;
                   req_date_count = 1;
                   b++;
                   req_date = dt.Rows[z]["req_date"].ToString();
                   dept = dt.Rows[z]["dept_name"].ToString();
               }
               else
               {
                   req_date_count++;
               }
           }
       }
       arr_req_date_count[b] = req_date_count;
       b = 0;
       req_date = string.Empty;
       dept = string.Empty;
       //-------------
     for (int i = 0; i < dt1.Rows.Count; i++)
     {
      %>    
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <%
                if (req_date != dt1.Rows[i]["req_date"].ToString())
                {
 %>
  <td rowspan="<%=arr_req_date_count[b]%>" height=25 class=xl43 style='height:18.75pt;border-top:none'><%= dt1.Rows[i]["req_date"]%></td>
  <td rowspan="<%=arr_req_date_count[b]%>" class=xl44 style='border-top:none;border-left:none'><%= dt1.Rows[i]["dept_name"]%></td>
    <% 
                    req_date = dt1.Rows[i]["req_date"].ToString();
                    b++;
                }
  %>  
  <td class=xl44 style='border-top:none;border-left:none'><%= dt1.Rows[i]["item_lname"]%></td>
  <td class=xl44 style='border-top:none;border-left:none'><%= dt1.Rows[i]["item_fname"]%></td>
  <td class=xl44 style='border-top:none;border-left:none'><%= dt1.Rows[i]["spec"]%></td>
  <td class=xl44 style='border-top:none;border-left:none'><%= dt1.Rows[i]["req_uom"]%></td>
  <td class=xl45 style='border-top:none;border-left:none' x:num><%= dt1.Rows[i]["req_qty"]%></td>
  <td class=xl43 style='border-top:none;border-left:none'><%= dt1.Rows[i]["out_date"]%></td>
  <td class=xl44 style='border-top:none;border-left:none'><%= dt1.Rows[i]["full_name"]%></td>
  <td class=xl44 style='border-top:none;border-left:none'><%= dt1.Rows[i]["description"]%></td>
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=89 style='width:67pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=147 style='width:110pt'></td>
  <td width=144 style='width:108pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
