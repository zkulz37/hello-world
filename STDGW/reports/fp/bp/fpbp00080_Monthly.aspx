<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("inv");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
  	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string SQL, l_from_date, l_to_date, l_item, l_tin_warehouse_pk, l_tco_itemgrp_pk;
    
    l_from_date         = Request["p_from_date"];
    l_to_date           = Request["p_to_date"];
    l_item              = Request["p_item"];
    l_tin_warehouse_pk  = Request["p_tin_warehouse_pk"];
    l_tco_itemgrp_pk    = Request["p_tco_itemgrp_pk"];
    
    
    SQL = "SELECT to_char(to_date('"+l_from_date+"','YYYYMMDD'),'YY-Mon-DD'),to_char(to_date('"+l_to_date+"','YYYYMMDD'),'YY-Mon-DD') from dual ";
    
    DataTable dt1 = ESysLib.TableReadOpen(SQL);

    string l_parameter = "'" + l_from_date + "','" + l_to_date + "','" + l_tin_warehouse_pk + "','" + l_tco_itemgrp_pk + "','" + l_item + "'";
    //Response.Write(l_parameter);
    //Response.End();
    DataTable dt = ESysLib.TableReadOpenCursor("INV.sp_sel_fpbp00080_2", l_parameter);//Data of Date,not voucher
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
<link rel=File-List href="AAReport_files/filelist.xml">
<link rel=Edit-Time-Data href="AAReport_files/editdata.mso">
<link rel=OLE-Object-Data href="AAReport_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr Quang</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2009-03-28T06:26:58Z</o:LastPrinted>
  <o:Created>2009-03-26T11:21:14Z</o:Created>
  <o:LastSaved>2010-01-15T08:18:47Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .5in .25in .5in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
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
.xl24
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	color:navy;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:top;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FF9900;
	mso-pattern:auto none;
	white-space:normal;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FF9900;
	mso-pattern:auto none;
	white-space:normal;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FF9900;
	mso-pattern:auto none;
	white-space:normal;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#FF9900;
	mso-pattern:auto none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>225</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>99</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
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
  <x:WindowHeight>6165</x:WindowHeight>
  <x:WindowWidth>11880</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1980</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$A$4:$H$4</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=980 style='border-collapse:
 collapse;table-layout:fixed;width:737pt'>
 <col class=xl24 width=142 style='mso-width-source:userset;mso-width-alt:5193;
 width:107pt'>
 <col class=xl24 width=143 style='mso-width-source:userset;mso-width-alt:5229;
 width:107pt'>
 <col class=xl24 width=289 style='mso-width-source:userset;mso-width-alt:10569;
 width:217pt'>
 <col class=xl24 width=50 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col class=xl24 width=89 span=4 style='mso-width-source:userset;mso-width-alt:
 3254;width:67pt'>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 class=xl25 width=142 style='height:7.5pt;width:107pt'></td>
  <td class=xl25 width=143 style='width:107pt'></td>
  <td class=xl25 width=289 style='width:217pt'></td>
  <td class=xl25 width=50 style='width:38pt'></td>
  <td class=xl25 width=89 style='width:67pt'></td>
  <td class=xl25 width=89 style='width:67pt'></td>
  <td class=xl25 width=89 style='width:67pt'></td>
  <td class=xl25 width=89 style='width:67pt'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td colspan=8 height=24 class=xl32 width=980 style='height:18.0pt;width:737pt'>Stock
  In/Out Report</td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td colspan=2 height=18 class=xl33 width=285 style='height:13.5pt;width:214pt'>Date:
  <%=dt1.Rows[0][0].ToString()%> ~ <%=dt1.Rows[0][1].ToString()%></td>
  <td colspan=6 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl35 width=142 style='height:15.0pt;border-top:none;
  width:107pt'>Warehouse</td>
  <td class=xl27 width=143 style='width:107pt'>Item Code</td>
  <td class=xl28 width=289 style='width:217pt'>Item Name</td>
  <td class=xl28 width=50 style='width:38pt'>UOM</td>
  <td class=xl28 width=89 style='width:67pt'>Begin</td>
  <td class=xl28 width=89 style='width:67pt'>Input</td>
  <td class=xl28 width=89 style='width:67pt'>Output</td>
  <td class=xl28 width=89 style='width:67pt'>End</td>
 </tr>
 <% 
     decimal Begin1=0, input1=0, output1=0, ending1=0;
       for( int k = 0 ; k< dt.Rows.Count ; k ++ )
       {
           Begin1 +=decimal.Parse(dt.Rows[k][4].ToString());
           input1 +=decimal.Parse(dt.Rows[k][5].ToString());
           output1 +=decimal.Parse(dt.Rows[k][6].ToString());
           ending1 +=decimal.Parse(dt.Rows[k][7].ToString());
       }
 %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl40 width=142 style='height:15.0pt;border-top:none;
  width:107pt'>&nbsp;</td>
  <td class=xl37 width=143 style='width:107pt'>&nbsp;</td>
  <td class=xl37 width=289 style='width:217pt'>&nbsp;</td>
  <td class=xl37 width=50 style='width:38pt'>&nbsp;</td>
  <td class=xl38 width=89 style='width:67pt' x:num><%=Begin1 %></td>
  <td class=xl38 width=89 style='width:67pt' x:num><%=input1 %></td>
  <td class=xl38 width=89 style='width:67pt' x:num><%=output1 %></td>
  <td class=xl39 width=89 style='border-top:none;width:67pt' x:num><%=ending1 %></td>
 </tr>
 <% 
     
     int row = 1;
     string wh = "";
       for( int i = 0 ; i< dt.Rows.Count ; i ++ )
       {
           
 %>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
 <% 
     if (wh != dt.Rows[i][0].ToString())
     {
         row = 1;
         wh = dt.Rows[i][0].ToString();
         for (int j = i + 1; j < dt.Rows.Count; j++)
         {
             if (wh == dt.Rows[j][0].ToString())
             {
                 row++;
             }
             else
             {
                 break;
             }
         }
    %>
  <td rowspan="<%=row %>" height=15 class=xl36 align=left width=142 style='height:11.25pt;
  border-top:none;width:107pt'><%=dt.Rows[i][0].ToString()%></td>
  <%
   }     
  %>
  <td class=xl29 align=left width=143 style='width:107pt'><%=dt.Rows[i][1].ToString()%></td>
  <td class=xl30 width=289 style='width:217pt'><%=dt.Rows[i][2].ToString()%></td>
  <td class=xl31 width=50 style='width:38pt'><%=dt.Rows[i][3].ToString()%></td>
  <td class=xl31 width=89 style='width:67pt'><%=dt.Rows[i][4].ToString()%></td>
  <td class=xl31 width=89 style='width:67pt'><%=dt.Rows[i][5].ToString()%></td>
  <td class=xl31 width=89 style='width:67pt'><%=dt.Rows[i][6].ToString()%></td>
  <td class=xl34 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7].ToString()%></td>
 </tr>
 <%         
    }
 %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=142 style='width:107pt'></td>
  <td width=143 style='width:107pt'></td>
  <td width=289 style='width:217pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
