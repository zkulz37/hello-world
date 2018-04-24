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
    string p_item	   = Request.QueryString["p_item"];
    string p_from_date = Request.QueryString["p_from_date"];
	string p_to_date   = Request.QueryString["p_to_date"];
	
    string para = " '" + p_item + "','" + p_from_date + "','" + p_to_date + "'";
    DataTable dt1 = ESysLib.TableReadOpenCursor("lg_rpt_bimc00043_1", para);
    string group_id = "";
    string s_group_id = "";
    
    decimal TotalBeginAmount = 0; 
    decimal TotalInAmount = 0; 
    decimal TotalOutAmount= 0; 
    decimal TotalEndAmount = 0;

    decimal SubBeginAmount = 0;
    decimal SubInAmount = 0;
    decimal SubOutAmount = 0;
    decimal SubEndAmount = 0;

    string str_sql = @"SELECT partner_name, addr1, phone_no, fax_no, tax_code, tco_bpphoto_pk
                       FROM tco_company
                       WHERE del_if = 0 AND pk = (SELECT MAX (pk)
                                                  FROM tco_company
                                                  WHERE del_if = 0 AND active_yn = 'Y')";
    DataTable dt2 = ESysLib.TableReadOpen(str_sql);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_bisc00013_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_bisc00013_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_bisc00013_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2011-10-05T10:16:26Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-10-05T10:16:55Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
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
	mso-footer-margin:0in;}
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
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl29
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:normal;}
.xl30
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl32
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl34
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>210</x:DefaultRowHeight>
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
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
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
  <x:WindowHeight>12825</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>-1605</x:WindowTopX>
  <x:WindowTopY>1065</x:WindowTopY>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=922 style='border-collapse:
 collapse;table-layout:fixed;width:692pt'>
 <col class=xl25 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl25 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl25 width=41 style='mso-width-source:userset;mso-width-alt:1499;
 width:31pt'>
 <col class=xl25 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl25 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 <col class=xl25 width=52 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col class=xl25 width=59 style='mso-width-source:userset;mso-width-alt:2157;
 width:44pt'>
 <col class=xl25 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl25 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl25 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl25 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <col class=xl25 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl25 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl25 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl25 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 width=66 style='height:15.0pt;width:50pt'><!--[if gte vml 1]><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:15.5pt;margin-top:1.5pt;width:75pt;height:42pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt2.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--></td>
  <td class=xl27 width=83 style='width:62pt'></td>
  <td class=xl27 align=left width=41 style='width:31pt'><%= dt2.Rows[0]["partner_name"]%></td>
  <td class=xl27 width=56 style='width:42pt'></td>
  <td class=xl26 width=69 style='width:52pt'></td>
  <td class=xl25 width=52 style='width:39pt'></td>
  <td class=xl28 width=59 style='width:44pt'></td>
  <td class=xl28 width=56 style='width:42pt'></td>
  <td class=xl28 width=73 style='width:55pt'></td>
  <td colspan=3 class=xl33 width=167 style='width:125pt'>Tel: <%= dt2.Rows[0]["phone_no"]%></td>
  <td class=xl28 width=71 style='width:53pt'></td>
  <td class=xl28 width=56 style='width:42pt'></td>
  <td class=xl25 width=73 style='width:55pt'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl26 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl26 colspan=2 align=left style='mso-ignore:colspan'><%= dt2.Rows[0]["addr1"]%></td>
  <td class=xl26></td>
  <td class=xl25></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl33 width=167 style='width:125pt'>Fax: <%= dt2.Rows[0]["fax_no"]%></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl26 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl26 colspan=2 align=left style='mso-ignore:colspan'>Tax code: <%= dt2.Rows[0]["tax_code"]%></td>
  <td class=xl26></td>
  <td class=xl25></td>
  <td class=xl29 width=59 style='width:44pt'>&nbsp;</td>
  <td class=xl29 width=56 style='width:42pt'>&nbsp;</td>
  <td class=xl29 width=73 style='width:55pt'>&nbsp;</td>
  <td colspan=3 class=xl34 width=167 style='width:125pt'>Print date :
  <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=48 style='mso-height-source:userset;height:36.0pt'>
  <td colspan=12 height=48 class=xl35 width=722 style='height:36.0pt;
  width:542pt'>REPORT W/H STOCK CLOSING</td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='height:21.0pt'>
  <td height=28 class=xl32 width=66 style='height:21.0pt;width:50pt'>Item Code</td>
  <td class=xl32 width=83 style='border-left:none;width:62pt'>Item Name</td>
  <td class=xl32 width=41 style='border-left:none;width:31pt'>UOM</td>
  <td class=xl32 width=56 style='border-left:none;width:42pt'>Lot No</td>
  <td class=xl32 width=69 style='border-left:none;width:52pt'>Begin Qty</td>
  <td class=xl32 width=52 style='border-left:none;width:39pt'>Begin Amount</td>
  <td class=xl32 width=59 style='border-left:none;width:44pt'>In Qty</td>
  <td class=xl32 width=56 style='border-left:none;width:42pt'>In Amount</td>
  <td class=xl32 width=73 style='border-left:none;width:55pt'>Out Qty</td>
  <td class=xl32 width=56 style='border-left:none;width:42pt'>Out Amount</td>
  <td class=xl32 width=55 style='border-left:none;width:41pt'>End Qty</td>
  <td class=xl32 width=56 style='border-left:none;width:42pt'>End Amount</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <%
 for (int y = 0; y < dt1.Rows.Count; y++)
           {
               if (s_group_id == dt1.Rows[y]["grp_cd"].ToString() || y == 0)
               {
                   SubBeginAmount += Convert.ToDecimal(dt1.Rows[y]["begin_amount"]);
                   SubEndAmount += Convert.ToDecimal(dt1.Rows[y]["end_amount"]);
                   SubInAmount += Convert.ToDecimal(dt1.Rows[y]["in_amount"]);
                   SubOutAmount += Convert.ToDecimal(dt1.Rows[y]["out_amount"]);
                   s_group_id = dt1.Rows[y]["grp_cd"].ToString();
               }
               else
               {
       %>
        <tr height=17 style='height:12.75pt'>
  <td colspan=4 height=17 class=xl46 style='height:12.75pt'>Sub Total</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 align=right style='border-top:none;border-left:none' x:num><%= SubBeginAmount %></td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 align=right style='border-top:none;border-left:none' x:num><%= SubInAmount %></td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 align=right style='border-top:none;border-left:none' x:num><%= SubOutAmount %></td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 align=right style='border-top:none;border-left:none' x:num><%= SubEndAmount%></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
<%
        
                SubBeginAmount = Convert.ToDecimal(dt1.Rows[y]["begin_amount"]);
                SubEndAmount = Convert.ToDecimal(dt1.Rows[y]["end_amount"]);
                SubInAmount = Convert.ToDecimal(dt1.Rows[y]["in_amount"]);
                SubOutAmount = Convert.ToDecimal(dt1.Rows[y]["out_amount"]);
                s_group_id = dt1.Rows[y]["grp_cd"].ToString();     
              }
                   
               if (group_id != dt1.Rows[y]["grp_cd"].ToString())
               {
                   group_id = dt1.Rows[y]["grp_cd"].ToString();
              
         %>       
       
 <tr height=17 style='height:12.75pt'>
  <td colspan=12 height=17 class=xl41 align=left style='height:12.75pt'>Group:
  <%= dt1.Rows[y]["grp_nm"]%></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
     <%                    
    } %>
 
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl36 align=left style='height:14.25pt;border-top:none'><%= dt1.Rows[y]["item_code"]%></td>
  <td class=xl37 align=left width=83 style='border-top:none;border-left:none;
  width:62pt'><%= dt1.Rows[y]["item_name"]%></td>
  <td class=xl38 align=left style='border-top:none;border-left:none'><%= dt1.Rows[y]["uom"]%></td>
  <td class=xl39 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[y]["lot_no"]%></td>
  <td class=xl40 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[y]["begin_qty"]%></td>
  <td class=xl39 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[y]["begin_amount"]%></td>
  <td class=xl40 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[y]["in_qty"]%></td>
  <td class=xl39 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[y]["in_amount"]%></td>
  <td class=xl40 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[y]["out_qty"]%></td>
  <td class=xl39 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[y]["out_amount"]%></td>
  <td class=xl40 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[y]["end_qty"]%></td>
  <td class=xl39 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[y]["end_amount"]%></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
  <% 
    TotalBeginAmount+= Convert.ToDecimal(dt1.Rows[y]["begin_amount"]); 
    TotalEndAmount += Convert.ToDecimal(dt1.Rows[y]["end_amount"]);
    TotalInAmount += Convert.ToDecimal(dt1.Rows[y]["in_amount"]); 
    TotalOutAmount += Convert.ToDecimal(dt1.Rows[y]["out_amount"]);

} %>
 <tr height=17 style='height:12.75pt'>
  <td colspan=4 height=17 class=xl46 style='height:12.75pt'>Sub Total</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 align=right style='border-top:none;border-left:none' x:num><%= SubBeginAmount %></td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 align=right style='border-top:none;border-left:none' x:num><%= SubInAmount %></td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 align=right style='border-top:none;border-left:none' x:num><%= SubOutAmount %></td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 align=right style='border-top:none;border-left:none' x:num><%= SubEndAmount%></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=4 height=17 class=xl42 style='height:12.75pt'>Total</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 align=right style='border-top:none;border-left:none' x:num><%= TotalBeginAmount %></td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 align=center style='border-top:none;border-left:none'
  x:num><%= TotalInAmount %></td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 align=center style='border-top:none;border-left:none'
  x:num><%= TotalOutAmount %></td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 align=center style='border-top:none;border-left:none'
  x:num><%= TotalEndAmount%></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=66 style='width:50pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=73 style='width:55pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
