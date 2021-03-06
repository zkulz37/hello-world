﻿<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("inv");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string p_pk = Request.QueryString["p_pk"];
    string p_user = Request.QueryString["p_user"];
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="bisa00060_files/filelist.xml">
<link rel=Edit-Time-Data href="bisa00060_files/editdata.mso">
<link rel=OLE-Object-Data href="bisa00060_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr. Khanh</o:LastAuthor>
  <o:LastPrinted>2010-10-04T05:43:57Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2010-10-04T05:43:58Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style0
	{mso-number-format:General;
	text-align:general;	vertical-align:bottom;
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
.xl24
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid blue;}
.xl25
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl26
	{mso-style-parent:style0;
	color:blue;
	text-align:center;
	border-top:none;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:.5pt solid blue;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	color:blue;
	text-align:center;
	border-top:none;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:.5pt solid blue;}
.xl29
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.000";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	border-top:none;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	color:red;
	font-size:18.0pt;
	text-align:center;
	border-top:.5pt solid blue;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid blue;}
.xl36
	{mso-style-parent:style0;
	color:red;
	font-size:18.0pt;
	text-align:center;
	border-top:.5pt solid blue;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	color:red;
	font-size:18.0pt;
	text-align:center;
	border-top:.5pt solid blue;
	border-right:.5pt solid blue;
	border-bottom:none;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid blue;
	border-bottom:none;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid blue;
	border-left:.5pt solid blue;}
.xl41
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid blue;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid blue;
	border-right:none;
	border-bottom:.5pt solid blue;
	border-left:.5pt solid blue;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid blue;
	border-right:none;
	border-bottom:.5pt solid blue;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid blue;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;
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
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>14</x:ActiveRow>
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
  <x:WindowHeight>12585</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=917 style='border-collapse:
 collapse;table-layout:fixed;width:690pt'>
 <col width=76 style='mso-width-source:userset;mso-width-alt:2779;width:57pt'>
 <col width=165 style='mso-width-source:userset;mso-width-alt:6034;width:124pt'>
 <col width=37 style='mso-width-source:userset;mso-width-alt:1353;width:28pt'>
 <col width=62 style='mso-width-source:userset;mso-width-alt:2267;width:47pt'>
 <col width=77 style='mso-width-source:userset;mso-width-alt:2816;width:58pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=60 style='mso-width-source:userset;mso-width-alt:2194;width:45pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=59 style='mso-width-source:userset;mso-width-alt:2157;width:44pt'>
 <col width=77 style='mso-width-source:userset;mso-width-alt:2816;width:58pt'>
 <col width=62 style='mso-width-source:userset;mso-width-alt:2267;width:47pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <tr height=31 style='height:23.25pt'>
  <td colspan=12 height=31 class=xl35 width=917 style='border-right:.5pt solid blue;
  height:23.25pt;width:690pt'>W/H Stock Closing</td>
              <% string para = " '" + p_pk + "'";
                  DataTable dt, dt1; 
                  dt = ESysLib.TableReadOpenCursor("INV.SP_RPT_BImc00060_1",para); 
                  for (int i = 0; i < dt.Rows.Count; i++)
               { %>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>W/H:</td>
  <td colspan=3 class=xl38><%= dt.Rows[i]["wh_name"]%></td>
  <td class=xl25>Stock Date:</td>
  <td colspan=2 class=xl38><%= System.DateTime.ParseExact(dt.Rows[i]["stock_date"].ToString(),"yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%></td>
  <td class=xl25>Charger:</td>
  <td colspan=4 class=xl38 style='border-right:.5pt solid blue'><%= dt.Rows[i]["full_name"]%></td>
 </tr>
 <% } %>
 <tr height=17 style='height:12.75pt'>
  <td colspan=12 height=17 class=xl40 style='border-right:.5pt solid blue;
  height:12.75pt'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 style='height:12.75pt'>Item Code</td>
  <td class=xl27>Item Name</td>
  <td class=xl27>UOM</td>
  <td class=xl27>Lot No</td>
  <td class=xl27>Begin Qty</td>
  <td class=xl27>Begin Amount</td>
  <td class=xl27>In Qty</td>
  <td class=xl27>In Amount</td>
  <td class=xl27>Out Qty</td>
  <td class=xl27>Out Amount</td>
  <td class=xl27>End Qty</td>
  <td class=xl27>End Amount</td>
 </tr>
 <% 
     para = " '" + p_pk + "','" + p_user + "'";
     dt1 = ESysLib.TableReadOpenCursor("INV.SP_RPT_BImc00061", para);
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
      <td colspan=4 height=17 class=xl43 style='border-right:.5pt solid blue;
      height:12.75pt; font-weight:bold'>Sub Total</td>
      <td class=xl33>&nbsp;</td>
      <td class=xl34 align=right x:num><%= SubBeginAmount %></td>
      <td class=xl33>&nbsp;</td>
      <td class=xl34 align=right x:num><%= SubInAmount %></td>
      <td class=xl33>&nbsp;</td>
      <td class=xl34 align=right x:num><%= SubOutAmount %></td>
      <td class=xl33>&nbsp;</td>
      <td class=xl34 align=right x:num><%= SubEndAmount%></td>
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
     <tr  style='height:20.0pt'>
        <td colspan ="12"  class=xl33 style="background-color:#FFCC99 ; border:1">
            <b>Group: <%= dt1.Rows[y]["grp_nm"]%></b>
        </td>
    </tr>
    <%                    
    } %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'><%= dt1.Rows[y]["item_code"]%></td>
  <td class=xl29 width=165 style='width:124pt'><%= dt1.Rows[y]["item_name"]%></td>
  <td class=xl30><%= dt1.Rows[y]["uom"]%></td>
  <td class=xl31 align=right x:num><%= dt1.Rows[y]["lot_no"]%></td>
  <td class=xl32 align=right x:num><%= dt1.Rows[y]["begin_qty"]%></td>
  <td class=xl31 align=right x:num><%= dt1.Rows[y]["begin_amount"]%></td>
  <td class=xl32 align=right x:num><%= dt1.Rows[y]["in_qty"]%></td>
  <td class=xl31 align=right x:num><%= dt1.Rows[y]["in_amount"]%></td>
  <td class=xl32 align=right x:num><%= dt1.Rows[y]["out_qty"]%></td>
  <td class=xl31 align=right x:num><%= dt1.Rows[y]["out_amount"]%></td>
  <td class=xl32 align=right x:num><%= dt1.Rows[y]["end_qty"]%></td>
  <td class=xl31 align=right x:num><%= dt1.Rows[y]["end_amount"]%></td>
 </tr>
 <% 
    TotalBeginAmount+= Convert.ToDecimal(dt1.Rows[y]["begin_amount"]); 
    TotalEndAmount += Convert.ToDecimal(dt1.Rows[y]["end_amount"]);
    TotalInAmount += Convert.ToDecimal(dt1.Rows[y]["in_amount"]); 
    TotalOutAmount += Convert.ToDecimal(dt1.Rows[y]["out_amount"]);

} %>
 <tr height=17 style='height:12.75pt'>
      <td colspan=4 height=17 class=xl43 style='border-right:.5pt solid blue;
      height:12.75pt ; font-weight:bold'>Sub Total</td>
      <td class=xl33>&nbsp;</td>
      <td class=xl34 align=right x:num><%= SubBeginAmount %></td>
      <td class=xl33>&nbsp;</td>
      <td class=xl34 align=right x:num><%= SubInAmount %></td>
      <td class=xl33>&nbsp;</td>
      <td class=xl34 align=right x:num><%= SubOutAmount %></td>
      <td class=xl33>&nbsp;</td>
      <td class=xl34 align=right x:num><%= SubEndAmount%></td>
 </tr> 
 <tr height=17 style='height:12.75pt'>
  <td colspan=4 height=17 class=xl43 style='border-right:.5pt solid blue;
  height:12.75pt ; font-weight:bold'>Total</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34 align=right x:num><%= TotalBeginAmount %></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34 align=right x:num><%= TotalInAmount %></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34 align=right x:num><%= TotalOutAmount %></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34 align=right x:num><%= TotalEndAmount%></td>
 </tr> 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=76 style='width:57pt'></td>
  <td width=165 style='width:124pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=79 style='width:59pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
