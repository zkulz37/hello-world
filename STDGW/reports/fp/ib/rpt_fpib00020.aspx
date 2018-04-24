﻿<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("sale");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<%    
    string array_line_group_pk = Request.QueryString["array_line_group_pk"];        
    
    string sql = "" ;
    
    if ( array_line_group_pk != "")
    {
         sql = "SELECT a.pk, GROUP_ID, group_name FROM tlg_pb_line_group a WHERE a.del_if = 0 and a.pk in ( " + array_line_group_pk + " ) ORDER BY GROUP_ID ";
    }
    else
    {
         sql = "SELECT a.pk, GROUP_ID, group_name FROM tlg_pb_line_group a WHERE a.del_if = 0 ORDER BY GROUP_ID ";
    }
    
    DataTable dt, dt1;    
    dt = ESysLib.TableReadOpen(sql);
    
    
 %>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="line_report_files/filelist.xml">
<link rel=Edit-Time-Data href="line_report_files/editdata.mso">
<link rel=OLE-Object-Data href="line_report_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>HRSV1</o:Author>
  <o:LastAuthor>Trung</o:LastAuthor>
  <o:LastPrinted>2010-05-18T02:51:54Z</o:LastPrinted>
  <o:Created>2010-02-01T03:18:02Z</o:Created>
  <o:LastSaved>2010-05-18T02:52:47Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.47in .48in 1.0in .47in;
	mso-header-margin:.35in;
	mso-footer-margin:.5in;}
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl32
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl33
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	font-size:30.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-size:36.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;}
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
      <x:Scale>82</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>4</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:ColBreaks>
      <x:ColBreak>
       <x:Column>5</x:Column>
      </x:ColBreak>
     </x:ColBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Area</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$A$1:$E$9</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1073 style='border-collapse:
 collapse;table-layout:fixed;width:805pt'>
 <col width=64 style='width:48pt'>
 <col width=172 style='mso-width-source:userset;mso-width-alt:6290;width:129pt'>
 <col width=217 style='mso-width-source:userset;mso-width-alt:7936;width:163pt'>
 <col width=332 style='mso-width-source:userset;mso-width-alt:12141;width:249pt'>
 <col width=32 style='mso-width-source:userset;mso-width-alt:1170;width:24pt'>
 <col width=64 style='width:48pt'>
 <col width=64 span=3 style='width:48pt'>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=4 height=26 class=xl41 width=785 style='border-right:.5pt solid black;
  height:19.5pt;width:589pt'><a name="Print_Area">Lines</a></td>
  <td class=xl25 width=32 style='width:24pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 style='height:12.75pt'>No</td>
  <td class=xl27>Lines</td>
  <td class=xl27>Work Lines</td>
  <td class=xl27>B/C</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
  <%
     for (int i = 0; i < dt.Rows.Count; i++)
     {
         string line_pk = "";
         line_pk = dt.Rows[i]["pk"].ToString();
         dt1 = ESysLib.TableReadOpenCursor("lg_rpt_fpib00020_1",line_pk);
         %>
 <tr height=120 style='mso-height-source:userset;height:70.0pt'>
  <td rowspan=<%=dt1.Rows.Count*2%> height=288 class=xl44 style='border-bottom:.5pt solid black;
  height:216.0pt;border-top:none' x:num><%=i+1 %></td>
  <td rowspan=<%=dt1.Rows.Count*2%> class=xl47 style='border-bottom:.5pt solid black;border-top:
  none'><%=dt.Rows[i]["group_name"] %></td>
  <%
      if (dt1.Rows.Count > 0 )
      {
            %>
  <td rowspan=2 class=xl38 style='border-bottom:.5pt solid black;border-top:
  none'><%=dt1.Rows[0]["line_name"] %></td>
  <td class=xl50>*L<%=dt1.Rows[0]["line_id"] %>*</td>
  <td class=xl29></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl33></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl30 style='height:18.0pt'><%=dt1.Rows[0]["line_id"] %></td>
  <td class=xl29></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl33></td>
 </tr>
  <% 
      }
   %>
 <%
     for (int j = 1; j < dt1.Rows.Count; j++)
     {
             %>
 <tr height=120 style='mso-height-source:userset;height:70.0pt'>
  <td rowspan=2 height=144 class=xl38 style='border-bottom:.5pt solid black;
  height:108.0pt;border-top:none'><%=dt1.Rows[j]["line_name"] %></td>
  <td class=xl50>*L<%=dt1.Rows[j]["line_id"] %>*</td>
  <td class=xl29></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl40></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl30 style='height:18.0pt'><%=dt1.Rows[j]["line_id"] %></td>
  <td class=xl29></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl33></td>
 </tr>
             <%
     }
 %>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td colspan=4 height=18 class=xl34 style='border-right:.5pt solid black;
  height:13.5pt'>&nbsp;</td>
  <td class=xl29></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl33></td>
 </tr>
        <% 
     }
  %>
 <tr height=39 style='height:29.25pt'>
  <td colspan=2 height=39 class=xl37 style='height:29.25pt'>SAVE</td>
  <td class=xl31></td>
  <td class=xl31>CANCEL</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl33></td>
 </tr>
 <tr height=71 style='mso-height-source:userset;height:53.25pt'>
  <td colspan=2 height=71 class=xl51 style='height:53.25pt'>*SAVE*</td>
  <td class=xl51></td>
  <td class=xl51>*CANCEL*</td>
  <td></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl33></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=9 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 style='height:11.25pt'></td>
  <td class=xl28></td>
  <td></td>
  <td class=xl28></td>
  <td class=xl24></td>
  <td class=xl28></td>
  <td class=xl32></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=9 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=9 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=9 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=9 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=9 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=75 style='mso-height-source:userset;height:56.25pt;mso-xlrowspan:
  5'>
  <td height=75 colspan=9 style='height:56.25pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=172 style='width:129pt'></td>
  <td width=217 style='width:163pt'></td>
  <td width=332 style='width:249pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
