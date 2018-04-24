<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("CRM");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string p_Month = Request["p_Month"];
    string l_date_to;
    DataTable dt = ESysLib.TableReadOpenCursor("ACNT.sp_sel_jama00040", p_Month);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    l_date_to = p_Month.Substring(4, 2) + "/" + p_Month.Substring(0, 4);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="dfsef_files/filelist.xml">
<link rel=Edit-Time-Data href="dfsef_files/editdata.mso">
<link rel=OLE-Object-Data href="dfsef_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>user</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2010-04-04T10:51:42Z</o:LastPrinted>
  <o:Created>2010-03-24T05:06:42Z</o:Created>
  <o:LastSaved>2010-05-12T10:28:27Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&LApril 3\, 2010&CPage &P of &N&RWatertree";
	margin:.5in 0in .5in .7in;
	mso-header-margin:0in;
	mso-footer-margin:.25in;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style16
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:Comma;
	mso-style-id:3;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style20
	{mso-number-format:0%;
	mso-style-name:Percent;
	mso-style-id:5;}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
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
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style16;
	color:windowtext;
	font-size:12.0pt;
	font-family:Calibri;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-family:Calibri;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style20;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	mso-number-format:0%;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style16;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style16;
	color:windowtext;
	font-size:10.0pt;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:10.0pt;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:1.0pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl42
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	mso-number-format:"\@";
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	mso-number-format:"\@";
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl45
	{mso-style-parent:style0;
	font-family:Calibri;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl48
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-family:Calibri;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border:.5pt solid windowtext;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Golf Pro-shop PNL</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>3</x:SplitHorizontal>
     <x:TopRowBottomPane>3</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
       <x:ActiveCol>8</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8355</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1980</x:WindowTopY>
  <x:TabRatio>835</x:TabRatio>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1025"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=529 style='border-collapse:
 collapse;table-layout:fixed;width:398pt'>
 <col width=298 style='mso-width-source:userset;mso-width-alt:9536;width:224pt'>
 <col class=xl24 width=53 span=3 style='mso-width-source:userset;mso-width-alt:
 1696;width:40pt'>
 <col width=72 style='width:54pt'>
 <tr height=44 style='mso-height-source:userset;height:33.0pt'>
  <td colspan=4 height=44 class=xl36 width=457 style='border-right:.5pt solid black;
  height:33.0pt;width:344pt'>Golf Pro shop Statement of Income & Expenses<br>
    Month : <%=l_date_to%></td>
  <td width=72 style='width:54pt'></td>
 </tr>
 <tr height=93 style='height:69.75pt'>
  <td height=93 class=xl25 width=298 style='height:69.75pt;width:224pt'>Golf
  Pro shop Statement of Income &amp; Expenses</td>
  <td rowspan=2 class=xl38 width=53 style='border-bottom:.5pt solid black;
  width:40pt'>Account Code</td>
  <td rowspan=2 class=xl40 width=53 style='border-bottom:.5pt solid black;
  width:40pt'>Dept Code</td>
  <td colspan=2 rowspan=2 class=xl43 width=125 style='border-right:1.0pt solid black;
  width:94pt'>Amount</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl26 style='height:14.25pt' x:str="'in Vietnam Dong">in
  Vietnam Dong</td>
 </tr>
 <%
     string strBegin = "";
     string strEnd = "";
     for (int i = 1; i < dt.Rows.Count; i++)
     {
         strBegin = "";
         strEnd = "";
         if (dt.Rows[i][5].ToString() == "B")
         {

             strBegin = "<b>";
             strEnd = "</b>";
         }
  %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt'><%=strBegin %><%= dt.Rows[i][0].ToString()%><%=strEnd%></td>
  <td class=xl28 width=53 style='width:40pt'><%= dt.Rows[i][1].ToString()%></td>
  <td class=xl45 width=53 style='width:40pt'><%= dt.Rows[i][2].ToString()%></td>
  <td colspan=2 class=xl49 width=125 style='width:94pt' x:num><%= dt.Rows[i][3].ToString()%></td>
 </tr>
 <%
     } %>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl29 style='height:14.25pt'>Total Other Expenses</td>
  <td colspan=4 class=xl48 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl29 style='height:14.25pt'>In US$</td>
  <td colspan=4 class=xl48 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt'>&nbsp;</td>
  <td colspan=4 class=xl48 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl31 style='height:14.25pt'>Total Cost &amp; Expenses</td>
  <td colspan=4 class=xl48 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl31 style='height:14.25pt'>In US$</td>
  <td colspan=4 class=xl48 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl32 style='height:14.25pt'>&nbsp;</td>
  <td colspan=4 class=xl48 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl31 style='height:14.25pt'>Departmental Profit</td>
  <td colspan=4 class=xl48 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl31 style='height:14.25pt'>In US$</td>
  <td colspan=4 class=xl48 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl31 style='height:14.25pt'>&nbsp;</td>
  <td colspan=4 class=xl48 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl33 style='height:14.25pt'>&nbsp;</td>
  <td colspan=4 class=xl48 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl34 style='height:14.25pt'>Number of Guest (Golf)</td>
  <td colspan=4 class=xl48 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl34 style='height:14.25pt'>- Golf</td>
  <td colspan=4 class=xl48 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl34 style='height:14.25pt'> - Pro-shop</td>
  <td colspan=4 class=xl48 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl34 style='height:14.25pt'>Ratio Pro-shop Guest to Golf
  Guests</td>
  <td colspan=4 class=xl48 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl34 style='height:14.25pt'>Average Spend per Guest
  (Pro-shop)</td>
  <td colspan=4 class=xl48 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl35 style='height:14.25pt'>No. of employee</td>
  <td colspan=4 class=xl48 style='border-left:none'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=298 style='width:224pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=72 style='width:54pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
