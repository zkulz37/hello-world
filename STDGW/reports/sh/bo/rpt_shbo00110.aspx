<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("prod");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    String  l_from_dt="",l_to_dt="",l_tank ="";
    
    l_from_dt = Request["from_dt"].ToString();
    l_to_dt = Request["to_dt"].ToString();
    l_tank = Request["tank"].ToString();
    Double l_pages = 1;
    Double d_sum =0;
    String l_from_s, l_to_s ;
    l_from_s = l_from_dt.Substring(0,4)+"."+l_from_dt.Substring(4,2) + "." + l_from_dt.Substring(6,2);
    l_to_s = l_to_dt.Substring(0,4)+"."+l_to_dt.Substring(4,2) + "." + l_to_dt.Substring(6,2);
    DataTable dt_mei = ESysLib.TableReadOpenCursor("PROD.sp_rpt_shbo00110_d", "'" + l_from_dt + "','" + l_to_dt + "','" + l_tank + "'");
    DataTable dt_sum = ESysLib.TableReadOpenCursor("PROD.sp_rpt_shbo00110_s", "'" + l_from_dt + "','" + l_to_dt + "','" + l_tank + "'");
   
       int irow;
       irow = dt_mei.Rows.Count;
       if (irow == 0)
        {
            Response.Write("There is no data of salary");
            Response.End();
        }
       
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_shbo00110_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_shbo00110_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_shbo00110_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>tuyen</o:LastAuthor>
  <o:LastPrinted>2010-03-30T04:05:14Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2010-03-30T04:08:06Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .5in 1.0in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-horizontal-page-align:center;}
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
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.000";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.000";
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.000";
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	text-align:center;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
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
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>81</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>18</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
     <%
        int no_row=5;
       
        for (int k=0;k<irow + 3 ;k++)
        {
            no_row+=1;
            if(no_row % 44 ==0)
              {
              
            %>
                <x:RowBreak>
                    <x:Row><%=no_row%></x:Row>
                </x:RowBreak>
            <%
             no_row += 5;    
            }            
                
        }  
        l_pages = (irow + 3)/44;
        if (no_row%44>0)
        {
            l_pages += 1;
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
  <x:WindowHeight>9300</x:WindowHeight>
  <x:WindowWidth>15135</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=816 style='border-collapse:
 collapse;table-layout:fixed;width:613pt'>
 <col width=112 style='mso-width-source:userset;mso-width-alt:4096;width:84pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=80 style='mso-width-source:userset;mso-width-alt:2925;width:60pt'>
 <col width=78 style='mso-width-source:userset;mso-width-alt:2852;width:59pt'>
 <col width=180 style='mso-width-source:userset;mso-width-alt:6582;width:135pt'>
 <col width=186 style='mso-width-source:userset;mso-width-alt:6802;width:140pt'>
 <%
     int i = 0;
     for (i = 0; i < irow; i++)
     {  
        if(i==0 || (i + (5* i/39)) % 44 ==0)  
        {       
  %>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=7 height=26 style='mso-height-source:userset;height:20.1pt;width:613pt' class=xl24 width=816 >Melting
  Batch No. Register</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=7 style='mso-height-source:userset;height:20.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=6 style='mso-height-source:userset;height:20.1pt;mso-ignore:colspan'></td>
  <td>Date:<%=dt_mei.Rows[0][7].ToString()%> </td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 style='mso-height-source:userset;height:20.1pt'>M/T No.:<%=l_tank%></td>
  <td></td>
  <td>Period: <%=l_from_s + "  -  " + l_to_s %></td>
  
  <td colspan="3"  style='mso-ignore:colspan'></td>
  <td >Page:<%=(i + (5* i/39))/44 + 1%>/<%=l_pages %></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl25 style='mso-height-source:userset;height:20.1pt'>First Issued Date</td>
  <td class=xl26>Entered Date</td>
  <td class=xl26>Batch No.</td>
  <td class=xl26>Tr./Op.</td>
  <td class=xl26>Batch Q'ty</td>
  <td class=xl26>Additive Solution Batch No.</td>
  <td class=xl27>Remak</td>
 </tr>
 <%
    }
      if(i<irow-1)
    {    
  %>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='mso-height-source:userset;height:20.1pt;border-top:none'><%=dt_mei.Rows[i][0].ToString() %></td>
  <td class=xl29 style='border-top:none'><%=dt_mei.Rows[i][1].ToString() %></td>
  <td class=xl29 style='border-top:none'><%=dt_mei.Rows[i][2].ToString() %></td>
  <td class=xl29 style='border-top:none'><%=dt_mei.Rows[i][3].ToString() %></td>
  <td class=xl30 align=right style='border-top:none' x:num><%=dt_mei.Rows[i][4].ToString() %></td>
  <td class=xl45 style='border-top:none'><%=dt_mei.Rows[i][5].ToString() %></td>
  <td class=xl31 style='border-top:none'><%=dt_mei.Rows[i][6].ToString() %></td>
 </tr>

 <% }
    else
    {
  %>
  <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='mso-height-source:userset;height:20.1pt; border-bottom:.5pt solid windowtext; border-top:none'><%=dt_mei.Rows[i][0].ToString() %></td>
  <td class=xl29 style= 'border-bottom:.5pt solid windowtext; border-top:none'><%=dt_mei.Rows[i][1].ToString() %></td>
  <td class=xl29 style=' border-bottom:.5pt solid windowtext; border-top:none'><%=dt_mei.Rows[i][2].ToString() %></td>
  <td class=xl29 style=' border-bottom:.5pt solid windowtext; border-top:none'><%=dt_mei.Rows[i][3].ToString() %></td>
  <td class=xl30 align=right style=' border-bottom:.5pt solid windowtext; border-top:none' x:num><%=dt_mei.Rows[i][4].ToString() %></td>
  <td class=xl45 style=' border-bottom:.5pt solid windowtext; border-top:none'><%=dt_mei.Rows[i][5].ToString() %></td>
  <td class=xl31 style=' border-bottom:.5pt solid windowtext; border-top:none'><%=dt_mei.Rows[i][6].ToString() %></td>
 </tr>
 <%
    }
    
    }
     i = 0;
     for (i = 0; i < dt_sum.Rows.Count ; i++)
     {        
     if(dt_sum.Rows.Count==0)      
     {     
  %>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl40 style='mso-height-source:userset;height:20.1pt;border-top:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none'>&nbsp;</td>
  <td class=xl44 style='border-top:none'><%=dt_sum.Rows[i][1].ToString() %></td>
  <td class=xl43 style='border-top:none' x:num><%=dt_sum.Rows[i][0].ToString() %></td>
  <td class=xl41 style='border-top:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none'>&nbsp;</td>
 </tr>
 <% }
    else
    {
    %>
    <tr height=26 style='mso-height-source:userset;height:20.1pt'>
      <td height=26 class=xl40 style='mso-height-source:userset;height:20.1pt;border-top:none; border-bottom:none'>&nbsp;</td>
      <td class=xl41 style='border-top:none; border-bottom:none'>&nbsp;</td>
      <td class=xl41 style='border-top:none; border-bottom:none'>&nbsp;</td>
      <td class=xl44 style='border-top:none; border-bottom:none'><%=dt_sum.Rows[i][1].ToString() %></td>
      <td class=xl43 style='border-top:none; border-bottom:none' x:num><%=dt_sum.Rows[i][0].ToString() %></td>
      <td class=xl41 style='border-top:none; border-bottom:none'>&nbsp;</td>
      <td class=xl42 style='border-top:none; border-bottom:none'>&nbsp;</td>
     </tr>
    <%
 }
 d_sum = d_sum + double.Parse(dt_sum.Rows[i][0].ToString());
 } %>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl40 style='mso-height-source:userset;height:20.1pt'>&nbsp;</td>
  <td class=xl41 >&nbsp;</td>
  <td class=xl41 >&nbsp;</td>
  <td class=xl44 >Total:</td>
  <td class=xl43 align=right  x:num><%=d_sum %></td>
  <td class=xl41 >&nbsp;</td>
  <td class=xl42 >&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=112 style='width:84pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=186 style='width:140pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
