<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("prod");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel"
    xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string p_month = Request.QueryString["month"];
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="ProgId" content="Excel.Sheet">
    <meta name="Generator" content="Microsoft Excel 11">
    <link rel="File-List" href="rpt_htfo00110_2_files/filelist.xml">
    <link rel="Edit-Time-Data" href="rpt_htfo00110_2_files/editdata.mso">
    <link rel="OLE-Object-Data" href="rpt_htfo00110_2_files/oledata.mso">
    <!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>VINAGENUWIN</o:Author>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:Created>2010-12-13T04:50:47Z</o:Created>
  <o:LastSaved>2010-12-13T06:33:08Z</o:LastSaved>
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
.font5
	{color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font6
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
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
.xl65
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	background:lime;
	mso-pattern:auto none;}
.xl67
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	background:#FF6600;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	background:red;
	mso-pattern:auto none;}
.xl69
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl70
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl74
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl81
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl82
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl84
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl85
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl86
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;}
.xl87
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl88
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yy\;\@";
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
    <!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>29</x:ActiveRow>
       <x:ActiveCol>12</x:ActiveCol>
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
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>
<body link="blue" vlink="purple">
    <table x:str border="0" cellpadding="0" cellspacing="0" width="2261" style='border-collapse: collapse;
        table-layout: fixed; width: 1696pt'>
        <col width="85" style='mso-width-source: userset; mso-width-alt: 3108; width: 64pt'>
        <col width="64" span="34" style='width: 48pt'>
        <tr height="31" style='height: 23.25pt'>
            <%
    DateTime date = DateTime.Now;  
    
     DateTime mydate = new DateTime(Convert.ToInt32(p_month.Substring(0,4)),Convert.ToInt32(p_month.Substring(4,2)), 01);
     
    string _date = date.ToString("dd-MMMM-yyyy");
    string _time = date.ToString("HH:mm:ss");
            %>
            <td colspan="35" height="31" class="xl87" width="2261" style='height: 23.25pt; width: 1696pt'>
                <font class="font5">RESERVATION CHART MONTHLY : </font><font class="font6">
                    <%= mydate.ToString("MMMM yyyy").ToUpper() %>
                </font>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" class="xl65" style='height: 12.75pt'>
            </td>
            <td class="xl66">
                C:CONFIRM<span style='display: none'>ED</span></td>
            <td colspan="2" class="xl65" style='mso-ignore: colspan'>
            </td>
            <td class="xl67">
                B:BLOCKED</td>
            <td colspan="2" class="xl65" style='mso-ignore: colspan'>
            </td>
            <td class="xl68">
                O:OUT OF O<span style='display: none'>RDER</span></td>
            <td colspan="3" class="xl65" style='mso-ignore: colspan'>
            </td>
            <td class="xl69">
                &nbsp;</td>
            <td class="xl69">
                T:TENTATI<span style='display: none'>VE</span></td>
            <td colspan="12" class="xl65" style='mso-ignore: colspan'>
            </td>
            <td class="xl65" colspan="2" style='mso-ignore: colspan'>
                PRINT DATE</td>
            <td class="xl65">
            </td>
            <td colspan="4" class="xl88">
                <%= _date %>
            </td>
            <td colspan="2" class="xl86">
                <%= _time %>
            </td>
            <td class="xl65">
            </td>
        </tr>
        <%
            string para = "'" + p_month + "'";
            DataTable dt = ESysLib.TableReadOpenCursor("CRM.sp_rpt_htfo00110", para);
			
        %>
        <tr height="17" style='height: 12.75pt'>
            <td colspan="3" rowspan="2" height="35" class="xl80" width="213" style='border-right: .5pt solid black;
                border-bottom: .5pt solid black; height: 26.25pt; width: 160pt'>
                ROOM TYPE</td>
            <td rowspan="2" class="xl78" width="64" style='border-bottom: 1.0pt solid black;
                width: 48pt'>
                ROOM No.</td>

            <td class="xl70" style='border-left: none'>
                <%= dt.Rows[0]["d1"]%>
            </td>
            <td class="xl70" style='border-left: none'>
                <%= dt.Rows[0]["d2"]%>
            </td>
            <td class="xl70" style='border-left: none'>
                <%= dt.Rows[0]["d3"]%>
            </td>
            <td class="xl71" style='border-left: none'>
                <%= dt.Rows[0]["d4"]%>
            </td>
            <td class="xl71" style='border-left: none'>
                <%= dt.Rows[0]["d5"]%>
            </td>
            <td class="xl70" style='border-left: none'>
                <%= dt.Rows[0]["d6"]%>
            </td>
            <td class="xl70" style='border-left: none'>
                <%= dt.Rows[0]["d7"]%>
            </td>
            <td class="xl70" style='border-left: none;'>
                <%= dt.Rows[0]["d8"]%>
            </td>
            <td class="xl70" style='border-left: none'>
                <%= dt.Rows[0]["d9"]%>
            </td>
            <td class="xl70" style='border-left: none'>
                <%= dt.Rows[0]["d10"]%>
            </td>
            <td class="xl71" style='border-left: none'>
                <%= dt.Rows[0]["d11"]%>
            </td>
            <td class="xl71" style='border-left: none'>
                <%= dt.Rows[0]["d12"]%>
            </td>
            <td class="xl70" style='border-left: none'>
                <%= dt.Rows[0]["d13"]%>
            </td>
            <td class="xl70" style='border-left: none'>
                <%= dt.Rows[0]["d14"]%>
            </td>
            <td class="xl70" style='border-left: none'>
                <%= dt.Rows[0]["d15"]%>
            </td>
            <td class="xl70" style='border-left: none'>
                <%= dt.Rows[0]["d16"]%>
            </td>
            <td class="xl70" style='border-left: none'>
                <%= dt.Rows[0]["d17"]%>
            </td>
            <td class="xl71" style='border-left: none'>
                <%= dt.Rows[0]["d18"]%>
            </td>
            <td class="xl71" style='border-left: none'>
                <%= dt.Rows[0]["d19"]%>
            </td>
            <td class="xl70" style='border-left: none'>
                <%= dt.Rows[0]["d20"]%>
            </td>
            <td class="xl70" style='border-left: none'>
                <%= dt.Rows[0]["d21"]%>
            </td>
            <td class="xl70" style='border-left: none'>
                <%= dt.Rows[0]["d22"]%>
            </td>
            <td class="xl70" style='border-left: none'>
                <%= dt.Rows[0]["d23"]%>
            </td>
            <td class="xl70" style='border-left: none'>
                <%= dt.Rows[0]["d24"]%>
            </td>
            <td class="xl71" style='border-top: none; border-left: none'>
                <%= dt.Rows[0]["d25"]%>
            </td>
            <td class="xl71" style='border-top: none; border-left: none'>
                <%= dt.Rows[0]["d26"]%>
            </td>
            <td class="xl70" style='border-top: none; border-left: none'>
                <%= dt.Rows[0]["d27"]%>
            </td>
            <td class="xl70" style='border-top: none; border-left: none'>
                <%= dt.Rows[0]["d28"]%>
            </td>
            <td class="xl70" style='border-left: none'>
                <%= dt.Rows[0]["d29"]%>
            </td>
            <td class="xl70" style='border-left: none'>
                <%= dt.Rows[0]["d30"]%>
            </td>
            <td class="xl70" style='border-left: none'>
                <%= dt.Rows[0]["d31"]%>
            </td>
        </tr>
        <tr height="18" style='height: 13.5pt'>
            <td height="18" class="xl72" style='height: 13.5pt; border-top: none; border-left: none'
                x:num>
                <%= dt.Rows[1]["d1"]%>
            </td>
            <td class="xl72" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d2"]%>
            </td>
            <td class="xl72" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d3"]%>
            </td>
            <td class="xl73" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d4"]%>
            </td>
            <td class="xl73" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d5"]%>
            </td>
            <td class="xl72" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d6"]%>
            </td>
            <td class="xl72" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d7"]%>
            </td>
            <td class="xl72" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d8"]%>
            </td>
            <td class="xl72" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d9"]%>
            </td>
            <td class="xl72" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d10"]%>
            </td>
            <td class="xl73" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d11"]%>
            </td>
            <td class="xl73" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d12"]%>
            </td>
            <td class="xl72" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d13"]%>
            </td>
            <td class="xl72" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d14"]%>
            </td>
            <td class="xl72" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d15"]%>
            </td>
            <td class="xl72" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d16"]%>
            </td>
            <td class="xl72" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d17"]%>
            </td>
            <td class="xl73" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d18"]%>
            </td>
            <td class="xl73" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d19"]%>
            </td>
            <td class="xl72" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d20"]%>
            </td>
            <td class="xl72" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d21"]%>
            </td>
            <td class="xl72" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d22"]%>
            </td>
            <td class="xl72" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d23"]%>
            </td>
            <td class="xl72" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d24"]%>
            </td>
            <td class="xl73" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d25"]%>
            </td>
            <td class="xl73" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d26"]%>
            </td>
            <td class="xl72" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d27"]%>
            </td>
            <td class="xl72" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d28"]%>
            </td>
            <td class="xl72" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d29"]%>
            </td>
            <td class="xl72" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d30"]%>
            </td>
            <td class="xl72" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[1]["d31"]%>
            </td>
        </tr>
        <%         
   //------------------- Room Type -------------------  
            string room_type = String.Empty;
            int[] arrRoom_Type_count = new int[dt.Rows.Count];    
            int strRoom_Type_count = 1;
            int a = 0;
            
            for (int y = 0; y < dt.Rows.Count; y++)
            {
                if (room_type == "" || room_type == null)
                {
                    room_type = dt.Rows[y]["room_type"].ToString();
                    strRoom_Type_count = 1;
                }
                else
                {
                    if (dt.Rows[y]["room_type"].ToString().Trim() != room_type.Trim())
                    {
                        arrRoom_Type_count[a] = strRoom_Type_count;
                        strRoom_Type_count = 1;
                        a++;
                        room_type = dt.Rows[y]["room_type"].ToString();
                    }
                    else
                    {
                        strRoom_Type_count++;
                    }
                }
            }
            arrRoom_Type_count[a] = strRoom_Type_count;
            a = 0;
            room_type = string.Empty;
            //--------------------------
            int count = 0;
            for (int i = 2; i < dt.Rows.Count; i++)
            {
        %>
        <tr height="17" style='mso-height-source: userset; height: 12.75pt'>
            <%
            
                if (room_type != dt.Rows[i]["room_type"].ToString())
                {
            %>
            <td rowspan="<%=arrRoom_Type_count[a]%>" colspan="2" height="17" class="xl76" width="149"
                style='border-right: .5pt solid black; height: 12.75pt; width: 112pt'>
                <%= dt.Rows[i]["room_type"]%>
            </td>
            <% 
                room_type = dt.Rows[i]["room_type"].ToString();
                a++;
                count=0;
                }
            count++;
            %>
            <td class="xl74" width="64" style='border-left: none; width: 48pt' x:num>
                <%= count %>
            </td>
            <td class="xl75" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[i]["room_no"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d1"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d2"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d3"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d4"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d5"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d6"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d7"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d8"]%>
            </td>			 
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d9"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d10"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d11"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d12"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d13"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d14"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d15"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d16"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d17"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d18"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d19"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d20"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d21"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d22"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d23"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d24"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d25"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d26"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d27"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d28"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d29"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d30"]%>
            </td>
            <td class="xl75" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["d31"]%>
            </td>
        </tr>
        <% }
        %>
        <![if supportMisalignedColumns]>
        <tr height="0" style='display: none'>
            <td width="85" style='width: 64pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
        </tr>
        <![endif]>
    </table>
</body>
</html>
