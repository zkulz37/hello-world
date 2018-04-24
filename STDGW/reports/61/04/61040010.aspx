<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string p_TPS_PROJECT_PK  =Request["p_TPS_PROJECT_PK"]; 
	string l_parameter = "'" +p_TPS_PROJECT_PK +"'";
    DataTable dt = ESysLib.TableReadOpenCursor("pm_rpt_61040010", l_parameter);
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
<link rel=File-List
href="New%20Microsoft%20Excel%20Worksheet_files/filelist.xml">
<link rel=Edit-Time-Data
href="New%20Microsoft%20Excel%20Worksheet_files/editdata.mso">
<link rel=OLE-Object-Data
href="New%20Microsoft%20Excel%20Worksheet_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Nghia</o:LastAuthor>
  <o:LastPrinted>2011-04-26T00:42:40Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-04-26T00:44:30Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.07in .04in .14in .06in;
	mso-header-margin:.05in;
	mso-footer-margin:.02in;
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
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	color:red;
	font-size:18.0pt;
	text-align:center;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl29
	{mso-style-parent:style0;
	font-size:6.0pt;
	text-align:left;
	border:.5pt solid windowtext;}
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
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>90</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>4</x:TopRowBottomPane>
     <x:SplitVertical>6</x:SplitVertical>
     <x:LeftColumnRightPane>6</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
      </x:Pane>
     </x:Panes>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1301 style='border-collapse:
 collapse;table-layout:fixed;width:976pt'>
 <col width=57 style='mso-width-source:userset;mso-width-alt:2084;width:43pt'>
 <col width=85 style='mso-width-source:userset;mso-width-alt:3108;width:64pt'>
 <col width=47 style='mso-width-source:userset;mso-width-alt:1718;width:35pt'>
 <col width=121 style='mso-width-source:userset;mso-width-alt:4425;width:91pt'>
 <col width=60 style='mso-width-source:userset;mso-width-alt:2194;width:45pt'>
 <col width=76 style='mso-width-source:userset;mso-width-alt:2779;width:57pt'>
 <col width=134 style='mso-width-source:userset;mso-width-alt:4900;width:101pt'>
 <col width=115 style='mso-width-source:userset;mso-width-alt:4205;width:86pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=95 style='mso-width-source:userset;mso-width-alt:3474;width:71pt'>
 <col width=97 style='mso-width-source:userset;mso-width-alt:3547;width:73pt'>
 <col width=108 style='mso-width-source:userset;mso-width-alt:3949;width:81pt'>
 <col width=107 style='mso-width-source:userset;mso-width-alt:3913;width:80pt'>
 <col width=64 span=2 style='width:48pt'>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=13 rowspan=2 height=34 class=xl27 width=1173 style='height:25.5pt;
  width:880pt'>List of outside order work</td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 colspan=2 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=13 height=31 class=xl28 style='height:23.25pt'>Project:</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:25.5pt'>
  <td height=30 class=xl25 style='height:22.5pt'>Code</td>
  <td class=xl26 width=85 style='border-left:none;width:64pt'
  x:str="Order Work &#10;Division Name ">Order Work <br>
    Division Name<span style='mso-spacerun:yes'></span></td>
  <td class=xl25 style='border-left:none'>Currency</td>
  <td class=xl26 width=121 style='border-left:none;width:91pt'>Domestic /
  Foreign<br>
    <span style='mso-spacerun:yes'></span>Equipment Description</td>
  <td class=xl25 style='border-left:none'>Service Type</td>
  <td class=xl26 width=76 style='border-left:none;width:57pt'>Registered <br>
    Work Division</td>
  <td class=xl26 width=134 style='border-left:none;width:101pt'>Refer to
  Headoffice's <br>
    Safety Control Cost Rate</td>
  <td class=xl26 width=115 style='border-left:none;width:86pt'>Placement Order
  <br>
    Expected Month/Year</td>
  <td class=xl25 style='border-left:none'>Contract Type</td>
  <td class=xl25 style='border-left:none'>Tax Exemption Rate</td>
  <td class=xl26 width=97 style='border-left:none;width:73pt'>Quotation without
  <br>
    Quantity<span style='mso-spacerun:yes'> </span>(Yes/No)</td>
  <td class=xl26 width=108 style='border-left:none;width:81pt'>Outsource
  Change<br>
    <span style='mso-spacerun:yes'></span>Times (Serial No.)</td>
  <td class=xl26 width=107 style='border-left:none;width:80pt'>Progress
  Status|<br>
    Responsible Person</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <%
     for (int i = 0; i < dt.Rows.Count; i++)
     {
          %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt;border-top:none'><%=dt.Rows[i][0]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt.Rows[i][1]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt.Rows[i][2]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt.Rows[i][3]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt.Rows[i][4]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt.Rows[i][5]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt.Rows[i][6]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt.Rows[i][7]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt.Rows[i][8]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt.Rows[i][9]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt.Rows[i][10]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt.Rows[i][11]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][13]%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=57 style='width:43pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=134 style='width:101pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
