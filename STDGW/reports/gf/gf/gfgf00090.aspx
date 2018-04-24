<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%
    
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
  string  p_company_pk = Request["company_pk"];
  string  p_Asset_cd = Request["Asset"];
  string  p_Asset_Type = Request["Asset_type"];
  string l_parameter = "'" + p_company_pk + "', ";
  l_parameter += "'" + p_Asset_cd + "' ,";
   l_parameter += "'" + p_Asset_Type + "' ";

  DataTable dt = ESysLib.TableReadOpenCursor("SP_SEL_GFGF00090_1_RPT", l_parameter);
  if (dt.Rows.Count == 0)
  {
      Response.Write("There is no data!!");
      Response.End();
  }
    %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Book1_files/filelist.xml">
<link rel=Edit-Time-Data href="Book1_files/editdata.mso">
<link rel=OLE-Object-Data href="Book1_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>LONG</o:Author>
  <o:LastAuthor>LONG</o:LastAuthor>
  <o:LastPrinted>2010-11-02T09:56:17Z</o:LastPrinted>
  <o:Created>2010-11-02T08:26:14Z</o:Created>
  <o:LastSaved>2010-11-02T09:56:29Z</o:LastSaved>
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
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}
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
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
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
      <x:Scale>12</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>4</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>22</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>7</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>28</x:ActiveRow>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>12750</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>15</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=7186 style='border-collapse:
 collapse;table-layout:fixed;width:5402pt'>
 <col class=xl24 width=42 style='mso-width-source:userset;mso-width-alt:1536;
 width:32pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=180 span=3 style='mso-width-source:userset;mso-width-alt:
 6582;width:135pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=180 style='mso-width-source:userset;mso-width-alt:6582;
 width:135pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=180 style='mso-width-source:userset;mso-width-alt:6582;
 width:135pt'>
 <col class=xl28 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=180 style='mso-width-source:userset;mso-width-alt:6582;
 width:135pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=180 style='mso-width-source:userset;mso-width-alt:6582;
 width:135pt'>
 <col class=xl24 width=121 style='mso-width-source:userset;mso-width-alt:4425;
 width:91pt'>
 <col class=xl24 width=180 span=3 style='mso-width-source:userset;mso-width-alt:
 6582;width:135pt'>
 <col class=xl24 width=145 style='mso-width-source:userset;mso-width-alt:5302;
 width:109pt'>
 <col class=xl24 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl24 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl24 width=95 style='mso-width-source:userset;mso-width-alt:3474;
 width:71pt'>
 <col class=xl24 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl24 width=124 span=4 style='mso-width-source:userset;mso-width-alt:
 4534;width:93pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=145 span=12 style='mso-width-source:userset;mso-width-alt:
 5302;width:109pt'>
 <col class=xl24 width=110 span=8 style='mso-width-source:userset;mso-width-alt:
 4022;width:83pt'>
 <col class=xl24 width=145 style='mso-width-source:userset;mso-width-alt:5302;
 width:109pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=145 style='mso-width-source:userset;mso-width-alt:5302;
 width:109pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=215 span=2 style='mso-width-source:userset;mso-width-alt:
 7862;width:161pt'>
 <col class=xl24 width=145 style='mso-width-source:userset;mso-width-alt:5302;
 width:109pt'>
<col class=xl24 width=145 style='mso-width-source:userset;mso-width-alt:5302;
 width:109pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 width=42 style='height:12.75pt;width:32pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=180 style='width:135pt'></td>
  <td class=xl24 width=180 style='width:135pt'></td>
  <td class=xl24 width=180 style='width:135pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=180 style='width:135pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=180 style='width:135pt'></td>
  <td class=xl28 width=110 style='width:83pt'></td>
  <td class=xl24 width=180 style='width:135pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=180 style='width:135pt'></td>
  <td class=xl24 width=121 style='width:91pt'></td>
  <td class=xl24 width=180 style='width:135pt'></td>
  <td class=xl24 width=180 style='width:135pt'></td>
  <td class=xl24 width=180 style='width:135pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=103 style='width:77pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=95 style='width:71pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=124 style='width:93pt'></td>
  <td class=xl24 width=124 style='width:93pt'></td>
  <td class=xl24 width=124 style='width:93pt'></td>
  <td class=xl24 width=124 style='width:93pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=215 style='width:161pt'></td>
  <td class=xl24 width=215 style='width:161pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td colspan=53 height=36 class=xl39 style='height:27.0pt'>Fixed Asset
  Oppening</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=9 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td colspan=43 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=21 style='height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'>No</td>
  <td class=xl25 style='border-left:none'>Asset Code</td>
  <td class=xl25 style='border-left:none'>Asset Name</td>
  <td class=xl25 style='border-left:none'>Local Name</td>
  <td class=xl25 style='border-left:none'>Korean Name</td>
  <td class=xl25 style='border-left:none'>Acc.Code</td>
  <td class=xl25 style='border-left:none'>Acc.Name</td>
  <td class=xl25 style='border-left:none'>Acc.Depr Code</td>
  <td class=xl25 style='border-left:none'>Acc.Depr Name</td>
  <td class=xl25 style='border-left:none'>Acc.Exp Code</td>
  <td class=xl25 style='border-left:none'>Acc.Depr Name</td>
  <td class=xl25 style='border-left:none'>P/L Unit Code</td>
  <td class=xl25 style='border-left:none'>P/L Unit Name</td>
  <td class=xl25 style='border-left:none'>P/L Center Code</td>
  <td class=xl25 style='border-left:none'>P/L Center Name</td>
  <td class=xl25 style='border-left:none'>Kind</td>
  <td class=xl25 style='border-left:none'>Department</td>
  <td class=xl25 style='border-left:none'>Charger</td>
  <td class=xl25 style='border-left:none'>Depr. Method</td>
  <td class=xl25 style='border-left:none'>Depr. Rate</td>
  <td class=xl25 style='border-left:none'>Service Date</td>
  <td class=xl25 style='border-left:none'>Depr. Date</td>
  <td class=xl25 style='border-left:none'>Estime life(year)</td>
  <td class=xl25 style='border-left:none'>Month(s)</td>
  <td class=xl25 style='border-left:none'>Total month(s)</td>
  <td class=xl25 style='border-left:none'>Day(s)</td>
  <td class=xl25 style='border-left:none'>CCY</td>
  <td class=xl25 style='border-left:none'>Original Cost</td>
  <td class=xl25 style='border-left:none'>Original Amt</td>
  <td class=xl25 style='border-left:none'>Begin Depr</td>
  <td class=xl25 style='border-left:none'>Begin Depr Amt</td>
  <td class=xl25 style='border-left:none'>Monthly Depr</td>
  <td class=xl25 style='border-left:none'>Monthly Depr Amt</td>
  <td class=xl25 style='border-left:none'>Daily Depr</td>
  <td class=xl25 style='border-left:none'>Daily Depr Amt</td>
  <td class=xl25 style='border-left:none'>Accum Depr</td>
  <td class=xl25 style='border-left:none'>Accum Depr Amt</td>
  <td class=xl25 style='border-left:none'>Remain Depr</td>
  <td class=xl25 style='border-left:none'>Remain Depr Amt</td>
  <td class=xl25 style='border-left:none'>Status</td>
  <td class=xl25 style='border-left:none'>Prod Year</td>
  <td class=xl25 style='border-left:none'>Invoice Date</td>
  <td class=xl25 style='border-left:none'>Invoice No</td>
  <td class=xl25 style='border-left:none'>Serial No</td>
  <td class=xl25 style='border-left:none'>Voucher No</td>
  <td class=xl25 style='border-left:none'>Price</td>
  <td class=xl25 style='border-left:none'>Amount</td>
  <td class=xl25 style='border-left:none'>Origin</td>
  <td class=xl25 style='border-left:none'>Quantity</td>
  <td class=xl25 style='border-left:none'>Capacity</td>
  <td class=xl25 style='border-left:none'>Engine No</td>
  <td class=xl25 style='border-left:none'>Description</td>
  <td class=xl25 style='border-left:none'>Local Description</td>
  <td class=xl25 style='border-left:none'>Remain Day(s)</td>
  <td class=xl25 style='border-left:none'>Depreciated(End date)</td>
 </tr>
<%
                for(int i=0;i<dt.Rows.Count;i++)
                {
 %> 
 <tr class=xl27 height=20 style='height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt;border-top:none'><%=dt.Rows[i][0]%></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dt.Rows[i][1]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i][2]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i][3]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i][4]%></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dt.Rows[i][5]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i][6]%></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dt.Rows[i][7]%></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dt.Rows[i][8]%></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dt.Rows[i][9]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i][10]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i][11]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i][12]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i][13]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i][14]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i][15]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i][16]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i][17]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i][18]%></td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][19]%></td>
  <td class=xl33 style='border-top:none;border-left:none' ><%=dt.Rows[i][20]%></td>
  <td class=xl33 style='border-top:none;border-left:none' ><%=dt.Rows[i][21]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][22]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][23]%> </td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][24]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][25]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt.Rows[i][26]%></td>
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
  <td class=xl29 style='border-top:none;border-left:none'><%=dt.Rows[i][39]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][40]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt.Rows[i][41]%></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dt.Rows[i][42]%></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dt.Rows[i][43]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i][44]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][45]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][46]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i][47]%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i][48]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][49]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i][50]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i][51]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i][52]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i][61]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i][62]%></td>
 </tr>
<%} %> 
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=42 style='width:32pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=215 style='width:161pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
