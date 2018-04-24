<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser("inv");%>
<% 	
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel"  xmlns="http://www.w3.org/TR/REC-html40">
<%
    int  curPg, totPg, curRow, minRow, maxRow, totRow, nullRow_Qty, rowSeq;
    string pk;
    
    pk = Request.QueryString["p_pk"];
    DataTable dtM, dtD;
    
    dtM = ESysLib.TableReadOpenCursor("inv.sp_rpt_epfm00040_3_posli", pk);
    dtD = ESysLib.TableReadOpenCursor("inv.sp_rpt_epfm00040_4_posli", pk);
	
	if (dtM.Rows.Count == 0){
        Response.Write("No thing to print.");
        Response.End();
	}

    totRow = dtD.Rows.Count;

    if (totRow > 0){
	    if ((int)(totRow/12) == (totRow/12)) {
            totPg = (int)(totRow / 12);
        }
	    else{
		    totPg = (int)(totRow/12) + 1;
        }
    }
    else{
	    totPg = 1;
    }

    minRow = 0;

    if (totRow-1 >= minRow + 11){
	    maxRow = minRow + 11;
    }
    else{
	    maxRow = totRow - 1;
    }

    curRow = 0;
    rowSeq = 0;
    curPg = 1;

%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="xxxx_files/filelist.xml">
<link rel=Edit-Time-Data href="xxxx_files/editdata.mso">
<link rel=OLE-Object-Data href="xxxx_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Le Huu Tho</o:Author>
  <o:LastAuthor>Nguyen Van Thai</o:LastAuthor>
  <o:LastPrinted>2009-10-13T09:29:46Z</o:LastPrinted>
  <o:Created>2007-10-24T03:05:33Z</o:Created>
  <o:LastSaved>2009-10-13T09:31:41Z</o:LastSaved>
  <o:Company>Vina Genuwin</o:Company>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:0in 0in 0in 0in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl27
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:25.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:32.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
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
      <x:PaperSizeIndex>144</x:PaperSizeIndex>
      <x:HorizontalResolution>180</x:HorizontalResolution>
      <x:VerticalResolution>180</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
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
  <x:WindowHeight>9270</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1545</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=776 style='border-collapse:collapse;table-layout:fixed;width:583pt'>
 <col class=xl24 width=78 style='mso-width-source:userset;mso-width-alt:2852; width:59pt'>
 <col class=xl24 width=79 style='mso-width-source:userset;mso-width-alt:2889; width:59pt'>
 <col class=xl24 width=50 style='mso-width-source:userset;mso-width-alt:1828; width:38pt'>
 <col class=xl24 width=40 style='mso-width-source:userset;mso-width-alt:1462; width:30pt'>
 <col class=xl24 width=32 style='mso-width-source:userset;mso-width-alt:1170; width:24pt'>
 <col class=xl24 width=26 style='mso-width-source:userset;mso-width-alt:950; width:20pt'>
 <col class=xl24 width=31 style='mso-width-source:userset;mso-width-alt:1133; width:23pt'>
 <col class=xl24 width=35 style='mso-width-source:userset;mso-width-alt:1280; width:26pt'>
 <col class=xl24 width=37 style='mso-width-source:userset;mso-width-alt:1353; width:28pt'>
 <col class=xl24 width=43 span=2 style='mso-width-source:userset;mso-width-alt: 1572;width:32pt'>
 <col class=xl24 width=45 style='mso-width-source:userset;mso-width-alt:1645; width:34pt'>
 <col class=xl24 width=42 style='mso-width-source:userset;mso-width-alt:1536; width:32pt'>
 <col class=xl24 width=40 style='mso-width-source:userset;mso-width-alt:1462; width:30pt'>
 <col class=xl24 width=27 style='mso-width-source:userset;mso-width-alt:987; width:20pt'>
 <col class=xl24 width=64 span=2 style='width:48pt'>
 <% for(int i=0; i< dtD.Rows.Count;i++)
    {
        if (curRow == minRow){ 
        rowSeq = 0; 
 %>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl24 width=78 style='height:12.95pt;width:59pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td colspan=2 rowspan=2 class=xl33 width=90 style='width:68pt'><%=dtM.Rows[0][1].ToString()%></td>
  <td class=xl24 width=32 style='width:24pt'></td>
  <td class=xl24 width=26 style='width:20pt'></td>
  <td class=xl24 width=31 style='width:23pt'></td>
  <td class=xl24 width=35 style='width:26pt'></td>
  <td class=xl24 width=37 style='width:28pt'></td>
  <td class=xl24 width=43 style='width:32pt'></td>
  <td class=xl24 width=43 style='width:32pt'></td>
  <td class=xl24 width=45 style='width:34pt'></td>
  <td class=xl24 width=42 style='width:32pt'></td>
  <td colspan=3 rowspan=2 class=xl37 width=131 style='width:98pt'><%=dtM.Rows[0][0].ToString()%></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=2 class=xl25 style='height:10.5pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=2 class=xl25 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=7 class=xl35>*<%=dtM.Rows[0][1].ToString()%>*</td>
  <td class=xl24></td>
 </tr>
 <tr height=4 style='mso-height-source:userset;height:3.0pt'>
  <td height=4 colspan=2 class=xl25 style='height:3.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl32></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl33></td>
  <td colspan=2 class=xl34></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 colspan=2 class=xl28 style='height:22.5pt;mso-ignore:colspan'></td>
  <td colspan=14 class=xl38><%=dtM.Rows[0][2].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=2 class=xl28 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl24><%=dtM.Rows[0][3].ToString()%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24><%=dtM.Rows[0][4].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=2 class=xl28 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl24><%=dtM.Rows[0][6].ToString()%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24><%=dtM.Rows[0][5].ToString()%></td>
  <td class=xl24></td>
 </tr>
 
 <tr height=6 style='mso-height-source:userset;height:4.5pt'>
  <td height=6 colspan=17 class=xl24 style='height:4.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=47 style='mso-height-source:userset;height:35.25pt'>
  <td height=47 class=xl28 style='height:35.25pt'></td>
  <td colspan=15 class=xl28 width=634 style='width:476pt'></td>
  <td class=xl24></td>
 </tr>
 <%}%>
 
 <tr height=15 style='mso-height-source:userset;height:11.85pt'>
  <td height=15 class=xl30 style='height:11.85pt'></td>
  <td colspan=5 class=xl30><%=dtD.Rows[i][0].ToString()%></td>
  <td class=xl30><%=dtD.Rows[i][1].ToString()%></td>
  <td class=xl31><%=dtD.Rows[i][2].ToString()%></td>
  <td class=xl31></td>
  <td class=xl31 x:num><%=dtD.Rows[i][3].ToString()%></td>
  <td class=xl31 x:num><%=dtD.Rows[i][4].ToString()%></td>
  <td class=xl31><%=dtD.Rows[i][5].ToString()%></td>
  <td class=xl31><%=dtD.Rows[i][6].ToString()%></td>
  <td class=xl31><%=dtD.Rows[i][7].ToString()%></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'><%=dtD.Rows[i][8].ToString()%></td>
 </tr>
 <% if (curRow == maxRow)
    {
        nullRow_Qty = 11 - rowSeq;
        
        for(int j = 1;j< nullRow_Qty;j++)
        {
%>
 <tr height=15 style='mso-height-source:userset;height:11.85pt'>
  <td height=15 class=xl30 style='height:11.85pt'></td>
  <td colspan=5 class=xl30></td>
  <td class=xl30></td>
  <td class=xl31></td>
  <td class=xl31></td>
  <td class=xl31 x:num></td>
  <td class=xl31 x:num></td>
  <td class=xl31></td>
  <td class=xl31></td>
  <td class=xl31></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <%    } %>
 <tr height=7 style='mso-height-source:userset;height:5.25pt'>
  <td height=7 colspan=17 class=xl24 style='height:5.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=89 style='mso-height-source:userset;height:66.75pt'>
  <td height=89 colspan=17 class=xl24 style='height:66.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=66 style='mso-height-source:userset;height:49.5pt'>
  <td height=66 colspan=14 class=xl24 style='height:49.5pt;mso-ignore:colspan'></td>
  <td class=xl36><%=curPg%>/<%=totPg%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 colspan=14 class=xl24 style='height:20.25pt;mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
<% } %>

<%
	curRow = curRow + 1;
	
	if (curRow == maxRow + 1)
    {
		minRow = maxRow + 1;
        
		if (totRow-1 >= minRow + 11)
        {
			maxRow = minRow + 11;
        }
		else
        {
			maxRow = totRow - 1;
		}
		
		if (curPg < totPg)
        {
			curPg = curPg + 1;
        }
    }
	
	rowSeq = rowSeq + 1;
}
 %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=78 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=31 style='width:23pt'></td>
  <td width=35 style='width:26pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
