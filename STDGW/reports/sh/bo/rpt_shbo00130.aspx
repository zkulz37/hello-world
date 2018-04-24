<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("sale");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string dtForm=Request["dtform"];
    string dtTo= Request["dtto"];
    string dtToday = Request["dttoday"];
    string a="", b="", c="";
    string sql = "select to_char(to_date(" + dtForm + ",'yyyymmdd'),'yyyy.mm.dd'),to_char(to_date(" + dtTo + ",'yyyymmdd'),'yyyy.mm.dd'),to_char(to_date(" + dtToday + ",'yyyymmdd'),'yyyy.mm.dd') from dual";
    DataTable dt = ESysLib.TableReadOpen(sql);
    if (dt.Rows.Count > 0)
    {
        a = dt.Rows[0][0].ToString();
        b = dt.Rows[0][1].ToString();
        c = dt.Rows[0][2].ToString();
    }
    DataTable dt1 = ESysLib.TableReadOpenCursor("prod.sp_sel_shbo00130", dtForm + "," + dtTo);
    int pages = (dt1.Rows.Count / 49 +1);
 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_shbo00130_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_shbo00130_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_shbo00130_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Trung</o:Author>
  <o:LastAuthor>Ngale</o:LastAuthor>
  <o:LastPrinted>2010-03-31T02:25:20Z</o:LastPrinted>
  <o:Created>2010-03-30T02:19:16Z</o:Created>
  <o:LastSaved>2010-03-31T02:35:08Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.67in .31in .48in .68in;
	mso-header-margin:.5in;
	mso-footer-margin:.39in;}
.font8
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
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
	font-size:12.0pt;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022???_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022???_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022???_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022???_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	padding-left:12px;
	mso-char-indent-count:1;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	padding-left:12px;
	mso-char-indent-count:1;}
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
      <x:Scale>77</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>20</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
       <x:RangeSelection>$G$21:$H$21</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
      <x:RowBreak>
       <x:Row>54</x:Row>
       <x:ColEnd>10</x:ColEnd>
      </x:RowBreak>
     </x:RowBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9345</x:WindowHeight>
  <x:WindowWidth>11340</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Area</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$A$1:$K$117</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=853 style='border-collapse:
 collapse;table-layout:fixed;width:641pt'>
 <col width=64 style='width:48pt'>
 <col width=52 style='mso-width-source:userset;mso-width-alt:1901;width:39pt'>
 <col width=64 style='width:48pt'>
 <col width=53 style='mso-width-source:userset;mso-width-alt:1938;width:40pt'>
 <col width=64 style='width:48pt'>
 <col width=59 style='mso-width-source:userset;mso-width-alt:2157;width:44pt'>
 <col width=64 style='width:48pt'>
 <col width=46 style='mso-width-source:userset;mso-width-alt:1682;width:35pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2560;width:53pt'>
 <col width=90 style='mso-width-source:userset;mso-width-alt:3291;width:68pt'>
 <col width=227 style='mso-width-source:userset;mso-width-alt:8301;width:170pt'>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=11 height=30 class=xl26 width=853 style='height:22.5pt;
  width:641pt'>Titanium Solution Preparation Record(Gelatin) Civil Official boo</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=9 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
  <td></td>
  <td class=xl25>Date<font class="font8"><%=c%></font></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=4 class=xl24 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl25>Period:</td>
  <td class=xl24 colspan=4 style='mso-ignore:colspan'><%=a%><span
  style='mso-spacerun:yes'>   </span>-<span style='mso-spacerun:yes'>  
  </span><%=b%></td>
  <td></td>
  <td class=xl25>Page<font class="font8"> :<span style='mso-spacerun:yes'> 
  </span>1<span style='mso-spacerun:yes'>  </span>/<span
  style='mso-spacerun:yes'>  </span><%=pages %></font></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=11 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl27 style='height:18.0pt'>Issued Date</td>
  <td colspan=2 class=xl27>Entered Date</td>
  <td colspan=2 class=xl27>Batch No.</td>
  <td colspan=2 class=xl37 x:str="Batch Q'ty  ">Batch Q'ty<span
  style='mso-spacerun:yes'>  </span></td>
  <td colspan=2 class=xl27>Total Instructed Q'ty</td>
  <td class=xl27>Remarks</td>
 </tr>
 <%
     Double total1 = 0;
     for (int i = 0; i < dt1.Rows.Count; i++)
     {
         total1 = total1 + CommondLib.ConvertToDbl(dt1.Rows[i]["batch_qty"].ToString());
 %>
 <tr class=xl28 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl29 style='height:18.75pt'><%=dt1.Rows[i]["iss_date"]%></td>
  <td colspan=2 class=xl29><%=dt1.Rows[i]["reg_dt"]%></td>
  <td colspan=2 class=xl29><%=dt1.Rows[i]["batch_no"]%></td>
  <td colspan=2 class=xl32 x:num><%=dt1.Rows[i]["batch_qty"]%></td>
  <td colspan=2 class=xl32 x:num><%=total1%></td>
  <td class=xl38 x:num><%=dt1.Rows[i]["batch_desc"]%></td>
 </tr>
 <% 
     if ((i % 49 == 0) && (i > 0))
     {        
 %>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=11 height=30 class=xl26 width=853 style='height:22.5pt;
  width:641pt'>Titanium Solution Preparation Record(Gelatin) Civil Official boo</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=9 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
  <td></td>
  <td class=xl25>Date<font class="font8"><%=c%></font></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=4 class=xl24 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl25>Period:</td>
  <td class=xl24 colspan=4 style='mso-ignore:colspan'><%=a%><span
  style='mso-spacerun:yes'>   </span>-<span style='mso-spacerun:yes'>  
  </span><%=b%></td>
  <td></td>
  <td class=xl25>Page<font class="font8"> :<span style='mso-spacerun:yes'> 
  </span><%=(i/49 +1) %><span style='mso-spacerun:yes'>  </span>/<span
  style='mso-spacerun:yes'>  </span><%=pages%></font></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=11 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl27 style='height:18.0pt'>Issued Date</td>
  <td colspan=2 class=xl27>Entered Date</td>
  <td colspan=2 class=xl27>Batch No.</td>
  <td colspan=2 class=xl37 x:str="Batch Q'ty  ">Batch Q'ty<span
  style='mso-spacerun:yes'>  </span></td>
  <td colspan=2 class=xl27>Total Instructed Q'ty</td>
  <td class=xl27>Remarks</td>
 </tr>   
 <%
     }
 }
  %>
 <tr class=xl28 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl31 style='height:18.0pt'>&nbsp;</td>
  <td colspan=2 class=xl31>&nbsp;</td>
  <td colspan=2 class=xl27>Total</td>
  <td colspan=2 class=xl34 x:num><%=total1%></td>
  <td colspan=2 class=xl34 x:num><%=total1%></td>
  <td class=xl34>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=227 style='width:170pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
