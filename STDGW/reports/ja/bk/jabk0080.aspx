<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<% ESysLib.SetUser("crm");%>
<% Response.ContentType = "application/vnd.ms-excel";
   Response.Charset = "utf-8"; 
   Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string l_month = Request["p_dtMonth"];
    string l_parameter = "'" + l_month + "'";
    string print_date_system="";
    string SQL2 = " select TO_CHAR(sysdate,'dd/mm/yyyy') dt_print  from dual ";
    DataTable dt2 = ESysLib.TableReadOpen(SQL2);
    if (dt2.Rows.Count > 0)
    {
        print_date_system = dt2.Rows[0][0].ToString();
    }
    //Response.Write(l_parameter);
    //Response.End();
    DataTable dt = ESysLib.TableReadOpenCursor("CRM.sp_sel_jabk0080", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    string strdt_month = l_month.Substring(4, 2) + "/" + l_month.Substring(0, 4);//2009.08
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="jabk80_report2_files/filelist.xml">
<link rel=Edit-Time-Data href="jabk80_report2_files/editdata.mso">
<link rel=OLE-Object-Data href="jabk80_report2_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>PCVINA002</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2010-10-18T05:45:56Z</o:LastPrinted>
  <o:Created>2010-10-18T03:47:39Z</o:Created>
  <o:LastSaved>2010-10-18T06:43:31Z</o:LastSaved>
  <o:Company>VINA</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .5in .5in .5in;
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
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:6.0pt;
	text-align:left;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	text-align:left;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl29
	{mso-style-parent:style0;
	text-align:right;}
.xl30
	{mso-style-parent:style0;
	color:#33CCCC;
	text-align:center;
	border:.5pt solid windowtext;
	background:#33CCCC;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#33CCCC;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:#CC99FF;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-size:6.0pt;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
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
       <x:ActiveRow>18</x:ActiveRow>
       <x:ActiveCol>27</x:ActiveCol>
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
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1839 style='border-collapse:
 collapse;table-layout:fixed;width:1357pt'>
 <col width=73 style='mso-width-source:userset;mso-width-alt:2669;width:55pt'>
 <col width=19 style='mso-width-source:userset;mso-width-alt:694;width:14pt'>
 <col width=18 style='mso-width-source:userset;mso-width-alt:658;width:14pt'>
 <col width=19 span=91 style='mso-width-source:userset;mso-width-alt:694;
 width:14pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=19 span=5 style='mso-width-source:userset;mso-width-alt:694;
 width:14pt'>
 <col width=63 style='mso-width-source:userset;mso-width-alt:2304;width:47pt'>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=94 height=31 class=xl26 width=1839 style='height:23.25pt;
  width:1357pt'>Reservation Report by Players</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>Date :</td>
  <td colspan=83 class=xl27><%=strdt_month %></td>
  <td colspan=5 class=xl28>Print Date :</td>
  <td colspan=5 class=xl29><%=print_date_system %></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl30 style='height:25.5pt'>&nbsp;</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>1</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>2</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>3</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>4</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>5</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>6</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>7</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>8</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>9</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>10</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>11</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>12</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>13</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>14</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>15</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>16</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>17</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>18</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>19</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>20</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>21</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>22</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>23</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>24</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>25</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>26</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>27</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>28</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>29</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>30</td>
  <td colspan=3 class=xl31 style='border-left:none' x:num>31</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none;border-left:
  none'>M</td>
  <td class=xl33 style='border-top:none;border-left:none'>A</td>
  <td class=xl33 style='border-top:none;border-left:none'>T</td>
  <td class=xl32 style='border-top:none;border-left:none'>M</td>
  <td class=xl32 style='border-top:none;border-left:none'>A</td>
  <td class=xl32 style='border-top:none;border-left:none'>T</td>
  <td class=xl33 style='border-top:none;border-left:none'>M</td>
  <td class=xl33 style='border-top:none;border-left:none'>A</td>
  <td class=xl33 style='border-top:none;border-left:none'>T</td>
  <td class=xl32 style='border-top:none;border-left:none'>M</td>
  <td class=xl32 style='border-top:none;border-left:none'>A</td>
  <td class=xl32 style='border-top:none;border-left:none'>T</td>
  <td class=xl33 style='border-top:none;border-left:none'>M</td>
  <td class=xl33 style='border-top:none;border-left:none'>A</td>
  <td class=xl33 style='border-top:none;border-left:none'>T</td>
  <td class=xl32 style='border-top:none;border-left:none'>M</td>
  <td class=xl32 style='border-top:none;border-left:none'>A</td>
  <td class=xl32 style='border-top:none;border-left:none'>T</td>
  <td class=xl33 style='border-top:none;border-left:none'>M</td>
  <td class=xl33 style='border-top:none;border-left:none'>A</td>
  <td class=xl33 style='border-top:none;border-left:none'>T</td>
  <td class=xl32 style='border-top:none;border-left:none'>M</td>
  <td class=xl32 style='border-top:none;border-left:none'>A</td>
  <td class=xl32 style='border-top:none;border-left:none'>T</td>
  <td class=xl33 style='border-top:none;border-left:none'>M</td>
  <td class=xl33 style='border-top:none;border-left:none'>A</td>
  <td class=xl33 style='border-top:none;border-left:none'>T</td>
  <td class=xl32 style='border-top:none;border-left:none'>M</td>
  <td class=xl32 style='border-top:none;border-left:none'>A</td>
  <td class=xl32 style='border-top:none;border-left:none'>T</td>
  <td class=xl33 style='border-top:none;border-left:none'>M</td>
  <td class=xl33 style='border-top:none;border-left:none'>A</td>
  <td class=xl33 style='border-top:none;border-left:none'>T</td>
  <td class=xl32 style='border-top:none;border-left:none'>M</td>
  <td class=xl32 style='border-top:none;border-left:none'>A</td>
  <td class=xl32 style='border-top:none;border-left:none'>T</td>
  <td class=xl33 style='border-top:none;border-left:none'>M</td>
  <td class=xl33 style='border-top:none;border-left:none'>A</td>
  <td class=xl33 style='border-top:none;border-left:none'>T</td>
  <td class=xl32 style='border-top:none;border-left:none'>M</td>
  <td class=xl32 style='border-top:none;border-left:none'>A</td>
  <td class=xl32 style='border-top:none;border-left:none'>T</td>
  <td class=xl33 style='border-top:none;border-left:none'>M</td>
  <td class=xl33 style='border-top:none;border-left:none'>A</td>
  <td class=xl33 style='border-top:none;border-left:none'>T</td>
  <td class=xl32 style='border-top:none;border-left:none'>M</td>
  <td class=xl32 style='border-top:none;border-left:none'>A</td>
  <td class=xl32 style='border-top:none;border-left:none'>T</td>
  <td class=xl33 style='border-top:none;border-left:none'>M</td>
  <td class=xl33 style='border-top:none;border-left:none'>A</td>
  <td class=xl33 style='border-top:none;border-left:none'>T</td>
  <td class=xl32 style='border-top:none;border-left:none'>M</td>
  <td class=xl32 style='border-top:none;border-left:none'>A</td>
  <td class=xl32 style='border-top:none;border-left:none'>T</td>
  <td class=xl33 style='border-top:none;border-left:none'>M</td>
  <td class=xl33 style='border-top:none;border-left:none'>A</td>
  <td class=xl33 style='border-top:none;border-left:none'>T</td>
  <td class=xl32 style='border-top:none;border-left:none'>M</td>
  <td class=xl32 style='border-top:none;border-left:none'>A</td>
  <td class=xl32 style='border-top:none;border-left:none'>T</td>
  <td class=xl33 style='border-top:none;border-left:none'>M</td>
  <td class=xl33 style='border-top:none;border-left:none'>A</td>
  <td class=xl33 style='border-top:none;border-left:none'>T</td>
  <td class=xl32 style='border-top:none;border-left:none'>M</td>
  <td class=xl32 style='border-top:none;border-left:none'>A</td>
  <td class=xl32 style='border-top:none;border-left:none'>T</td>
  <td class=xl33 style='border-top:none;border-left:none'>M</td>
  <td class=xl33 style='border-top:none;border-left:none'>A</td>
  <td class=xl33 style='border-top:none;border-left:none'>T</td>
  <td class=xl32 style='border-top:none;border-left:none'>M</td>
  <td class=xl32 style='border-top:none;border-left:none'>A</td>
  <td class=xl32 style='border-top:none;border-left:none'>T</td>
  <td class=xl33 style='border-top:none;border-left:none'>M</td>
  <td class=xl33 style='border-top:none;border-left:none'>A</td>
  <td class=xl33 style='border-top:none;border-left:none'>T</td>
  <td class=xl32 style='border-top:none;border-left:none'>M</td>
  <td class=xl32 style='border-top:none;border-left:none'>A</td>
  <td class=xl32 style='border-top:none;border-left:none'>T</td>
  <td class=xl33 style='border-top:none;border-left:none'>M</td>
  <td class=xl33 style='border-top:none;border-left:none'>A</td>
  <td class=xl33 style='border-top:none;border-left:none'>T</td>
  <td class=xl32 style='border-top:none;border-left:none'>M</td>
  <td class=xl32 style='border-top:none;border-left:none'>A</td>
  <td class=xl32 style='border-top:none;border-left:none'>T</td>
  <td class=xl33 style='border-top:none;border-left:none'>M</td>
  <td class=xl33 style='border-top:none;border-left:none'>A</td>
  <td class=xl33 style='border-top:none;border-left:none'>T</td>
  <td class=xl32 style='border-top:none;border-left:none'>M</td>
  <td class=xl32 style='border-top:none;border-left:none'>A</td>
  <td class=xl32 style='border-top:none;border-left:none'>T</td>
  <td class=xl33 style='border-top:none;border-left:none'>M</td>
  <td class=xl33 style='border-top:none;border-left:none'>A</td>
  <td class=xl33 style='border-top:none;border-left:none'>T</td>
 </tr>
 <%
     for (int i = 1; i < dt.Rows.Count; i++)
     {
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'><%=dt.Rows[i][0]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][10]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][11]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][12]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][13]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][14]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][15]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][16]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][17]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][18]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][19]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][20]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][21]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][22]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][23]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][24]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][25]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][26]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][27]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][28]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][29]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][30]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][31]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][32]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][33]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][34]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][35]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][36]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][37]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][38]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][39]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][40]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][41]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][42]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][43]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][44]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][45]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][46]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][47]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][48]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][49]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][50]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][51]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][52]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][53]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][54]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][55]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][56]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][57]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][58]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][59]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][60]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][61]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][62]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][63]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][64]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][65]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][66]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][67]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][68]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][69]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][70]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][71]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][72]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][73]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][74]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][75]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][76]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][77]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][78]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][79]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][80]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][81]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][82]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][83]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][84]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][85]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][86]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][87]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][88]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][89]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][90]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][91]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][92]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][93]%></td>
 </tr>
 <%
     } %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=73 style='width:55pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=18 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
