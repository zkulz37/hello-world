<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string p_pb_line_group_pk = Request.QueryString["p_pb_line_group_pk"];   
    DataTable dt;
    dt = ESysLib.TableReadOpenCursor("LG_RPT_FPPW00060", "'" + p_pb_line_group_pk + "'");
    
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Line_Employee_list_files/filelist.xml">
<link rel=Edit-Time-Data href="Line_Employee_list_files/editdata.mso">
<link rel=OLE-Object-Data href="Line_Employee_list_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr Lee</o:Author>
  <o:LastAuthor>VINAGENUWIN</o:LastAuthor>
  <o:LastPrinted>2012-10-11T02:47:13Z</o:LastPrinted>
  <o:Created>2012-10-11T02:17:17Z</o:Created>
  <o:LastSaved>2012-10-11T06:25:41Z</o:LastSaved>
  <o:Company>Prive</o:Company>
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
.xl65
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-family:"Code39\(1\:2\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
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
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>95</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
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
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>16155</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=644 style='border-collapse:
 collapse;table-layout:fixed;width:485pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=116 style='mso-width-source:userset;mso-width-alt:4242;width:87pt'>
 <col width=49 style='mso-width-source:userset;mso-width-alt:1792;width:37pt'>
 <col width=158 style='mso-width-source:userset;mso-width-alt:5778;width:119pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=158 style='mso-width-source:userset;mso-width-alt:5778;width:119pt'>
 <tr height=35 style='height:26.25pt'>
  <td colspan=6 height=35 class=xl71 width=644 style='height:26.25pt;
  width:485pt'>LINE AND EMPLOYEE LIST</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl67 style='height:12.75pt'>Line ID</td>
  <td class=xl67 style='border-left:none'>Line Name</td>
  <td class=xl67 style='border-left:none'>Seq</td>
  <td class=xl67 style='border-left:none'>Employee Name</td>
  <td class=xl67 style='border-left:none'>Employee ID</td>
  <td class=xl67 style='border-left:none'>Employee BC</td>
 </tr>
 <%
     string strLineID = string.Empty;
     int[] arrLineID_count = new int[dt.Rows.Count];
     int a = 0;
     int strLineID_count = 1;
     
      for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (strLineID == string.Empty)
                {
                    strLineID = dt.Rows[i]["line_id"].ToString();
                    strLineID_count = 1;
                }
                else
                {
                    if (!dt.Rows[i]["line_id"].ToString().Trim().Equals(strLineID.Trim()))
                    {
                        arrLineID_count[a] = strLineID_count;
                        strLineID_count = 1;
                        a++;
                        strLineID = dt.Rows[i]["line_id"].ToString();
                    }
                    else
                    {
                        strLineID_count++;
                    }
                }
            }
     
            arrLineID_count[a] = strLineID_count;
            a = 0;
            strLineID = string.Empty;
            //---
            for (int y = 0; y < dt.Rows.Count; y++)
            {
                if (!strLineID.Equals(dt.Rows[y]["line_id"].ToString()))
                {       
      %>
                     <tr height=38 style='mso-height-source:userset;height:28.5pt'>
                      <td rowspan="<%=arrLineID_count[a]%>" height=38 class=xl68 style='height:28.5pt;border-top:none'><%= dt.Rows[y]["line_id"]%></td>
                      <td rowspan="<%=arrLineID_count[a]%>" class=xl70 width=116 style='border-top:none;border-left:none;width:87pt'><%= dt.Rows[y]["line_name"]%></td>
            <% 
               strLineID = dt.Rows[y]["line_id"].ToString();
                a++;
            }
            %>
                      <td class=xl66 style='border-top:none;border-left:none' x:num><%= Convert.ToInt32(dt.Rows[y]["seq"])+ y %></td>
                      <td class=xl65 style='border-top:none;border-left:none'><%= dt.Rows[y]["full_name"]%></td>
                      <td class=xl65 align=right style='border-top:none;border-left:none' x:num><%= dt.Rows[y]["emp_id"]%></td>
                      <td class=xl69 style='border-top:none;border-left:none'><%= dt.Rows[y]["emp_bc"]%></td>
                     </tr>
        <%
                
            } 
        %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=74 style='width:56pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=158 style='width:119pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=158 style='width:119pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
