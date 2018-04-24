<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_Seq = Request["Seq"];
    DataTable dt = ESysLib.TableReadOpenCursor("ac_sel_60050040_rpt", p_Seq);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is not data !!");
        Response.End();
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List
href="Giay%20nop%20tien%20vao%20ngan%20sach%20nha%20nuoc_files/filelist.xml">
<link rel=Edit-Time-Data
href="Giay%20nop%20tien%20vao%20ngan%20sach%20nha%20nuoc_files/editdata.mso">
<link rel=OLE-Object-Data
href="Giay%20nop%20tien%20vao%20ngan%20sach%20nha%20nuoc_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Phan Thi Thanh Tuyen</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2011-09-30T09:07:36Z</o:LastPrinted>
  <o:Created>2011-09-29T08:25:33Z</o:Created>
  <o:LastSaved>2011-09-30T09:07:58Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .5in .5in .5in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;}
.font0
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font7
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font8
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font10
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font12
	{color:navy;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
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
	padding:0px;
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
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:justify;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	color:navy;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	color:navy;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl41
	{mso-style-parent:style16;
	color:navy;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	color:navy;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	color:navy;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl45
	{mso-style-parent:style16;
	color:navy;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl47
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl48
	{mso-style-parent:style16;
	color:navy;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	color:navy;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	color:navy;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
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
     <x:DefaultRowHeight>360</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9150</x:WindowHeight>
  <x:WindowWidth>18780</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>270</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=776 style='border-collapse:
 collapse;table-layout:fixed;width:584pt'>
 <col class=xl24 width=17 style='mso-width-source:userset;mso-width-alt:621;
 width:13pt'>
 <col class=xl24 width=35 style='mso-width-source:userset;mso-width-alt:1280;
 width:26pt'>
 <col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl24 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl24 width=117 style='mso-width-source:userset;mso-width-alt:4278;
 width:88pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl24 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=117 style='mso-width-source:userset;mso-width-alt:4278;
 width:88pt'>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 width=17 style='height:18.0pt;width:13pt'></td>
  <td class=xl24 width=35 style='width:26pt'></td>
  <td class=xl24 width=89 style='width:67pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=117 style='width:88pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=66 style='width:50pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl37 width=117 style='width:88pt'>Mẫu số: C1- 02/NS</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td colspan=2 rowspan=3 class=xl67 width=124 style='border-right:.5pt hairline black;
  border-bottom:.5pt hairline black;width:93pt'>Không ghi vào khu vực này</td>
  <td colspan=6 class=xl74>GIẤY NỘP TIỀN VÀO NGÂN SÁCH NHÀ NƯỚC</td>
  <td class=xl36>Mã hiệu:…………</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl24></td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1025"
   style='position:absolute;direction:LTR;text-align:left;margin-left:65.25pt;
   margin-top:3.75pt;width:10.5pt;height:9.75pt;z-index:1' filled="f"
   fillcolor="#0cf [40]" strokecolor="windowText [64]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'/>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:1;margin-left:86px;margin-top:4px;width:16px;height:15px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=13 height=15 align=left valign=top style='border:.75pt solid black;
    vertical-align:top'><![endif]>
    <div v:shape="_x0000_s1025" style='padding:.75pt 0pt 0pt .75pt;text-align:
    left;direction:ltr' class=shape><font class="font0"><br>
        </font></div>
    <![if !vml]></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl31 align=left width=117 style='height:18.0pt;
    width:88pt' x:str="Tiền mặt  ">Tiền mặt<span
    style='mso-spacerun:yes'>  </span></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24></td>
  <td class=xl31 align=left>chuyển khoả<span style='display:none'>n</span></td>
  <td height=24 class=xl31 width=66 style='height:18.0pt;width:50pt'><!--[if gte vml 1]><v:rect
   id="_x0000_s1026" style='position:absolute;direction:LTR;text-align:left;
   margin-left:19.5pt;margin-top:3.75pt;width:10.5pt;height:9.75pt;z-index:2'
   filled="f" fillcolor="#0cf [40]" strokecolor="windowText [64]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'/>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=25 height=4></td>
   </tr>
   <tr>
    <td></td>
    <td width=13 height=15 align=left valign=top style='border:.75pt solid black;
    vertical-align:top'><![endif]>
    <div v:shape="_x0000_s1026" style='padding:.75pt 0pt 0pt .75pt;text-align:
    left;direction:ltr' class=shape><font class="font0"><br>
        </font></div>
    <![if !vml]></td>
    <td width=25></td>
   </tr>
   <tr>
    <td height=5></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:49.5pt;height:18.0pt'></span><![endif]--></td>
  <td class=xl24></td>
  <td class=xl36>Số:……………</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td colspan=6 class=xl75>(Đánh dấu X vào ô tương ứng)</td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=10 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl31 colspan=4 align=left style='mso-ignore:colspan'>Người nộp
  thuế: <font class="font12">Công ty TNHH DORCO VINA</font></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl31 colspan=3 align=left style='mso-ignore:colspan'>Mã số thuế:<font
  class="font8"> 0900283167</font></td>
  <td class=xl31 colspan=5 align=left style='mso-ignore:colspan'>Địa chỉ: <font
  class="font12">Đường B3, Khu B, KCN Phố Nối A, Minh Hải</font></td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl31></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl31 colspan=2 align=left style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>Huyện: <font class="font8">Văn Lâm</font></td>
  <td class=xl31 colspan=2 align=left style='mso-ignore:colspan'>Tỉnh, TP: <font
  class="font12">Hưng Yên</font></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl31 colspan=2 align=left style='mso-ignore:colspan'
  x:str="Người nộp thay: ">Người nộp thay:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td class=xl24></td>
  <td class=xl31 align=left>Mã số thuế:</td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl31 colspan=2 align=left style='mso-ignore:colspan'>Địa chỉ: .</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl31></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl31 colspan=2 align=left style='mso-ignore:colspan' x:str="Huyện: ">Huyện:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl31 align=left x:str="Tỉnh, TP: ">Tỉnh, TP:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl31 colspan=4 align=left style='mso-ignore:colspan'>Đề nghị NH
  (KBNN): <font class="font12">Vietcom Bank Hưng Yên</font></td>
  <td class=xl24></td>
  <td class=xl31 colspan=3 align=left style='mso-ignore:colspan'>trích TK số: <font
  class="font12">0591001804796</font></td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl31 colspan=4 align=left style='mso-ignore:colspan'>(hoặc) nộp
  tiền mặt để chuyển cho KBNN: <font class="font12">Mỹ Hào</font></td>
  <td class=xl31></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl31 colspan=2 align=left style='mso-ignore:colspan'>Tỉnh, TP: <font
  class="font12">Hưng Yên</font></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl31 colspan=4 align=left style='mso-ignore:colspan'>Để<span
  style='mso-spacerun:yes'>  </span>nộp vào TK tạm thu số <font class="font12">741.01.00.00002</font></td>
  <td class=xl31></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl31 colspan=4 align=left style='mso-ignore:colspan'>Cơ quan quản
  lý thu: <font class="font12">Chi cục hải quan Hưng Yên</font></td>
  <td class=xl31 align=left><span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl31 align=left x:str="Mã số: ">Mã số:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl31 colspan=5 align=left style='mso-ignore:colspan'>Tờ khai HQ, QĐ
  số<font class="font8">: </font><font class="font12">1373/ NDT08</font><font
  class="font8"><span style='mso-spacerun:yes'>    </span></font><font
  class="font7"><span style='mso-spacerun:yes'> </span>ngày: </font><font
  class="font12">05/05/2011</font></td>
  <td class=xl24></td>
  <td class=xl31 colspan=2 align=left style='mso-ignore:colspan'>Loại hình XNK:
  <font class="font12">NDT08</font></td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl31 colspan=3 align=left style='mso-ignore:colspan'
  x:str="(hoặc) Bảng kê Biên lai số: ">(hoặc) Bảng kê Biên lai số:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl24></td>
  <td class=xl31></td>
  <td class=xl31 align=left x:str=" ngày "><span
  style='mso-spacerun:yes'> </span>ngày<span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 colspan=10 class=xl24 style='height:12.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td rowspan=2 class=xl65 width=35 style='width:26pt'>STT</td>
  <td colspan=3 class=xl59 width=288 style='border-right:.5pt solid black;
  width:217pt'>Nội dung</td>
  <td rowspan=2 class=xl66 width=64 style='width:48pt'>Mã chương</td>
  <td rowspan=2 class=xl50 width=79 style='border-bottom:.5pt solid black;
  width:59pt'>Mã ngành KT (K)</td>
  <td rowspan=2 class=xl50 width=66 style='border-bottom:.5pt solid black;
  width:50pt'>Mã NDKT (TM)</td>
  <td rowspan=2 class=xl49 width=110 style='width:83pt' x:str="Kỳ thuế ">Kỳ
  thuế<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl49 width=117 style='width:88pt'>Số tiền</td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl24 style='height:25.5pt'></td>
  <td colspan=3 class=xl62 width=288 style='border-right:.5pt solid black;
  width:217pt'>các khoản nộp NS</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl38 width=35 style='border-top:none;width:26pt' x:num>1</td>
  <td colspan=3 class=xl54 width=288 style='border-left:none;width:217pt'>Thuế
  xuất nhập khẩu</td>
  <td class=xl39 width=64 style='border-top:none;border-left:none;width:48pt'
  x:num>151</td>
  <td class=xl39 width=79 style='border-top:none;border-left:none;width:59pt'
  x:num>191</td>
  <td class=xl39 width=66 style='border-top:none;border-left:none;width:50pt'
  x:num>1901</td>
  <td class=xl40 align=left width=110 style='border-top:none;border-left:none;
  width:83pt'>Tháng 05/2011</td>
  <td class=xl41 align=left width=117 style='border-top:none;border-left:none;
  width:88pt' x:num="54034830"><span style='mso-spacerun:yes'>        
  </span>54,034,830 </td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl42 width=35 style='border-top:none;width:26pt' x:num>2</td>
  <td colspan=3 class=xl55 width=288 style='border-left:none;width:217pt'>Thuế
  GTGT</td>
  <td class=xl43 width=64 style='border-top:none;border-left:none;width:48pt'
  x:num>151</td>
  <td class=xl43 width=79 style='border-top:none;border-left:none;width:59pt'
  x:num>191</td>
  <td class=xl43 width=66 style='border-top:none;border-left:none;width:50pt'
  x:num>1702</td>
  <td class=xl44 align=left width=110 style='border-top:none;border-left:none;
  width:83pt'>Tháng 05/2011</td>
  <td class=xl45 align=left width=117 style='border-top:none;border-left:none;
  width:88pt' x:num="54034830"><span style='mso-spacerun:yes'>        
  </span>54,034,830 </td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl42 width=35 style='border-top:none;width:26pt'>&nbsp;</td>
  <td colspan=3 class=xl56 width=288 style='border-left:none;width:217pt'>&nbsp;</td>
  <td class=xl42 width=64 style='border-top:none;border-left:none;width:48pt'>&nbsp;</td>
  <td class=xl42 width=79 style='border-top:none;border-left:none;width:59pt'>&nbsp;</td>
  <td class=xl42 width=66 style='border-top:none;border-left:none;width:50pt'>&nbsp;</td>
  <td class=xl46 width=110 style='border-top:none;border-left:none;width:83pt'>&nbsp;</td>
  <td class=xl47 width=117 style='border-top:none;border-left:none;width:88pt'>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td colspan=8 class=xl53 width=642 style='width:483pt'>Tổng cộng</td>
  <td class=xl48 align=left width=117 style='border-top:none;border-left:none;
  width:88pt' x:num="54034830"><span style='mso-spacerun:yes'>        
  </span>54,034,830 </td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 colspan=10 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl32 colspan=9 align=left style='mso-ignore:colspan'>Tổng số tiền
  ghi bằng chữ: <font class="font10">Một trăm mười ba triệu bốn trăm bảy
  mươi ba nghìn một trăm bốn mươi ba đồng./…</font></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl24 colspan=9 style='mso-ignore:colspan'>…………………………………………………………………………………………………………………………</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td colspan=3 class=xl73 width=206 style='width:155pt'>PHẦN KBNN GHI</td>
  <td class=xl33 width=117 style='width:88pt'><u style='visibility:hidden;
  mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan'>Mã quỹ: …………………………<span
  style='display:none'>…..</span></td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan'
  x:str="Mã ĐBHC: ………………………. ">Mã ĐBHC: ……………………….<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan;border-right:.5pt solid black'
  x:str="Nợ TK: ……………...……………………. ">Nợ TK: ……………...…………………….<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan'>Mã KBNN: ……………………<span
  style='display:none'>……</span></td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan'>Mã nguồn NS:……………………..</td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan;border-right:.5pt solid black'>Có
  TK:……………...……………………..</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl34 width=35 style='width:26pt'>&nbsp;</td>
  <td class=xl35 width=89 style='width:67pt'>&nbsp;</td>
  <td class=xl35 width=82 style='width:62pt'>&nbsp;</td>
  <td class=xl35 width=117 style='width:88pt'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=10 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td colspan=5 class=xl57 width=387 style='width:291pt'>ĐỐI TƯỢNG NỘP TIỀN</td>
  <td colspan=4 class=xl57 width=372 style='width:280pt'>NGÂN HÀNG A</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td colspan=5 class=xl58 width=387 style='width:291pt'>Ngày <font
  class="font12">06</font><font class="font7"> tháng </font><font class="font12">05</font><font
  class="font7"> năm </font><font class="font12">2011</font></td>
  <td colspan=4 class=xl58 width=372 style='width:280pt'>Ngày……tháng……năm……</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td colspan=5 class=xl57 width=387 style='width:291pt'>Người nộp tiền<span
  style='mso-spacerun:yes'>    </span>Kế toán trưởng<span
  style='mso-spacerun:yes'>     </span>Thủ trưởng</td>
  <td colspan=4 class=xl57 width=372 style='width:280pt'
  x:str="Kế toán                             Kế toán trưởng  ">Kế toán<span
  style='mso-spacerun:yes'>                             </span>Kế toán
  trưởng<span style='mso-spacerun:yes'>  </span></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=10 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=10 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=10 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=10 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td colspan=5 class=xl57 width=387 style='width:291pt'>NGÂN HÀNG B</td>
  <td colspan=4 class=xl57 width=372 style='width:280pt'>KHO BẠC NHÀ NƯỚC</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td colspan=5 class=xl58 width=387 style='width:291pt'>Ngày……tháng……năm……</td>
  <td colspan=4 class=xl58 width=372 style='width:280pt'>Ngày……tháng…..năm…….</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td colspan=5 class=xl57 width=387 style='width:291pt'>Kế toán<span
  style='mso-spacerun:yes'>                        </span>Kế toán trưởng</td>
  <td colspan=4 class=xl52
  x:str="Thủ quỹ          Kế toán        Kế toán trưởng    ">Thủ quỹ<span
  style='mso-spacerun:yes'>          </span>Kế toán<span
  style='mso-spacerun:yes'>        </span>Kế toán trưởng<span
  style='mso-spacerun:yes'>    </span></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=17 style='width:13pt'></td>
  <td width=35 style='width:26pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=117 style='width:88pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
