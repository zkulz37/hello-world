<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string SQL
    = "SELECT MAX(code1),MAX(code2),MAX(code3),MAX(code4),MAX(code5),MAX(code6),MAX(code7),MAX(code8) ,MAX(code9),MAX(code10) " +
        "          ,MAX(UPPER(c1)),MAX(UPPER(c2)),MAX(UPPER(c3)),MAX(UPPER(c4)),MAX(UPPER(c5)),MAX(UPPER(c6)),MAX(UPPER(c7)),MAX(UPPER(c8)),MAX(UPPER(c9)),MAX(UPPER(c10)) " +
        "        FROM (SELECT DECODE (code, '01', a.code_nm, '') AS code1,   " +
        "                     DECODE (code, '02', a.code_nm, '') AS code2,   " +
        "                     DECODE (code, '03', a.code_nm, '') AS code3,   " +
        "                     DECODE (code, '04', a.code_nm, '') AS code4,   " +
        "                     DECODE (code, '05', a.code_nm, '') AS code5,   " +
        "                     DECODE (code, '06', a.code_nm, '') AS code6,   " +
        "                     DECODE (code, '07', a.code_nm, '') AS code7,   " +
        "                     DECODE (code, '08', a.code_nm, '') AS code8, " +
        "                     DECODE (code, '09', a.code_nm, '') AS code9,   " +
        "                     DECODE (code, '10', a.code_nm, '') AS code10,   " +
        "                        " +
        "                     DECODE (code, '01', a.CHAR_1, '') AS c1,   " +
        "                     DECODE (code, '02', a.CHAR_1, '') AS c2,   " +
        "                     DECODE (code, '03', a.CHAR_1, '') AS c3,   " +
        "                     DECODE (code, '04', a.CHAR_1, '') AS c4,   " +
        "                     DECODE (code, '05', a.CHAR_1, '') AS c5,   " +
        "                     DECODE (code, '06', a.CHAR_1, '') AS c6,   " +
        "                     DECODE (code, '07', a.CHAR_1, '') AS c7,   " +
        "                     DECODE (code, '08', a.CHAR_1, '') AS c8,  " +
        "                     DECODE (code, '09', a.CHAR_1, '') AS c9, " +
        "                     DECODE (code, '10', a.CHAR_1, '') AS c10 " +
        "                FROM vhr_hr_code a   " +
        "               WHERE a.ID = 'HR0151'  ) allow_amt ";

    DataTable data = ESysLib.TableReadOpen(SQL);
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="aaaaaaa_files/filelist.xml">
<link rel=Edit-Time-Data href="aaaaaaa_files/editdata.mso">
<link rel=OLE-Object-Data href="aaaaaaa_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Ho Thu Hien</o:Author>
  <o:LastAuthor>nhut_k</o:LastAuthor>
  <o:Created>2010-06-16T03:35:23Z</o:Created>
  <o:LastSaved>2011-05-30T01:27:56Z</o:LastSaved>
  <o:Company>Vina Genuwin</o:Company>
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
	text-decoration:n;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:n;
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
	text-decoration:n;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border:n;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl24
	{mso-style-parent:style0;
	font-family:"Comic Sans MS", cursive;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-family:"Comic Sans MS", cursive;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Comic Sans MS", cursive;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt  #339966;
	border-right:.5pt dashed #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:2.0pt  #339966;
	background:#CCFFFF;
	mso-pattern:auto n;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Comic Sans MS", cursive;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt  #339966;
	border-right:.5pt dashed #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:n;
	background:#CCFFFF;
	mso-pattern:auto n;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Comic Sans MS", cursive;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt  #339966;
	border-right:2.0pt  #339966;
	border-bottom:.5pt dashed #00CCFF;
	border-left:n;
	background:#CCFFFF;
	mso-pattern:auto n;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-family:"Comic Sans MS", cursive;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:n;
	border-right:.5pt dashed #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:2.0pt  #339966;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-family:"Comic Sans MS", cursive;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:n;
	border-right:.5pt dashed #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:n;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-family:"Comic Sans MS", cursive;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:n;
	border-right:.5pt dashed #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:n;}
.xl32
	{mso-style-parent:style0;
	font-family:"Comic Sans MS", cursive;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:n;
	border-right:.5pt dashed #00CCFF;
	border-bottom:2.0pt  #339966;
	border-left:2.0pt  #339966;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-family:"Comic Sans MS", cursive;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:n;
	border-right:.5pt dashed #00CCFF;
	border-bottom:2.0pt  #339966;
	border-left:n;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-family:"Comic Sans MS", cursive;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:n;
	border-right:.5pt dashed #00CCFF;
	border-bottom:2.0pt  #339966;
	border-left:n;}
.xl35
	{mso-style-parent:style0;
	font-family:"Comic Sans MS", cursive;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:n;
	
	border-bottom:.5pt dashed #00CCFF;
	border-left:n;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-family:"Comic Sans MS", cursive;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:n;
	
	border-bottom:2.0pt  #339966;
	border-left:n;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	
	font-family:"Comic Sans MS", cursive;
	mso-font-charset:0;
	mso-number-format:"Short Date";}
.xl38
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Comic Sans MS", cursive;
	mso-font-charset:0;
	text-align:center;
	border-top:n;
	border-right:n;
	border-bottom:2.0pt  #339966;
	border-left:n;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
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
       <x:ActiveRow>9</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
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
  <x:WindowHeight>12630</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1545</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=550 style='border-collapse:
 collapse;table-layout:fixed;width:413pt'>
 <col class=xl24 width=35 style='mso-width-source:userset;mso-width-alt:1280;
 width:26pt'>
 <col class=xl24 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl24 width=163 style='mso-width-source:userset;mso-width-alt:5961;
 width:122pt'>
 <%int d = 0;
   for (int i = 0; i < 10; i++)
       if (data.Rows[0][i + 10].ToString() == "1")
           d++;
 
 %>
 
 <col class=xl25 width=74  span=<%=d %> style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 
 <col class=xl25 width=130 style='mso-width-source:userset;mso-width-alt:4754;
 width:98pt'>
 <col class=xl24 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 
 <tr height=48 style='mso-height-source:userset;height:36.0pt'>
  <td height=48 class=xl26 width=35 style='height:36.0pt;border-top:n;
  width:26pt'>No.</td>
  <td class=xl27 width=67 style='border-top:n;width:50pt'>Emp ID</td>
  <td class=xl27 width=163 style='border-top:n;width:122pt'>Full Name</td>
  <%for (int i = 0; i < 10; i++)
    {
        if (data.Rows[0][i + 10].ToString() == "1")
        {
        %>
  
  <td class=xl27 width=74 style='width:56pt' x:str><%=data.Rows[0][i].ToString()%><span  style='mso-spacerun:yes'> </span></td>
  <%}
} %>
  <td class=xl28 width=130 style='width:98pt'>Total Increase
  AMT</td>
  <td class=xl28 width=81 style='width:61pt'>Confirm Date</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 width=35 style='height:15.0pt;width:26pt' x:num>1</td>
  <td class=xl30 width=67 style='width:50pt'>C00003</td>
  <td class=xl31>NGUYEN VAN QUY</td>
  <%for (int i = 0; i < 10; i++)
    {
        if (data.Rows[0][i + 10].ToString() == "1")
        {
        %>
  <td class=xl35 width=74 style='width:56pt' x:num>100000</td>
  <%}
}%> 
  <td class=xl35 width=130 style='width:98pt' x:num><%=100000*d %></td>
  <td class=xl35 align=right x:str style="border-right:2.0pt  #339966;">12/05/1986</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl32 width=35 style='height:15.75pt;width:26pt' x:num>2</td>
  <td class=xl33 width=67 style='width:50pt'>C00005</td>
  <td class=xl34>CAO THI THU PHUONG</td>
   <%for (int i = 0; i < 10; i++)
    {
        if (data.Rows[0][i + 10].ToString() == "1")
        {
        %>
 
  <td class=xl36 width=74 style='width:56pt' x:num>5840</td>
   <%}
}%> 
  <td class=xl36 width=130 style='width:98pt' x:num><%=5840*d %></td>
  <td class=xl36 align=right x:str style="border-right:2.0pt  #339966;">12/05/1986</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:n'>
  <td width=35 style='width:26pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=163 style='width:122pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=130 style='width:98pt'></td>
  <td width=81 style='width:61pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
