<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("crm");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string l_pk = Request.QueryString["p_pk"];
	String l_print_date="";
    string l_parameter = "'" + l_pk + "'";
    DataTable dt, dt1;
    dt = ESysLib.TableReadOpenCursor("CRM.sp_rpt_htfo00240_confer_only",l_parameter);
	string l_GTD_Type="",l_Credit_type="";
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
	string SQL3 = "select to_char(sysdate,'dd-Mon-yyyy hh24:mi') print_date from dual";
    DataTable dt_sysdate = ESysLib.TableReadOpen(SQL3);
    if (dt_sysdate.Rows.Count > 0)
    {
        l_print_date = dt_sysdate.Rows[0][0].ToString();
    }
	if(dt.Rows[0]["guarantee_type"].ToString()=="01")
	{
		l_GTD_Type=dt.Rows[0]["gtd_type"].ToString(); 
		l_Credit_type=dt.Rows[0]["credit_type"].ToString();
	}
	else
	{
		l_GTD_Type="";
		l_Credit_type="";
	}
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_htfo00240_conference_only_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_htfo00240_conference_only_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_htfo00240_conference_only_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Compaq-500B</o:Author>
  <o:LastAuthor>Mr.Quyen</o:LastAuthor>
  <o:LastPrinted>2011-08-01T01:25:18Z</o:LastPrinted>
  <o:Created>2010-12-06T07:07:55Z</o:Created>
  <o:LastSaved>2011-08-01T01:47:47Z</o:LastSaved>
  <o:Company>HP Compaq</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.9in .2in .75in .28in;
	mso-header-margin:.68in;
	mso-footer-margin:.3in;}
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
td
	{mso-style-parent:style0;
	padding:0px;
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
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Time";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style16;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl62
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl65
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl66
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl77
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}	
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Conference</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>98</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>17</x:ActiveRow>
       <x:ActiveCol>13</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8745</x:WindowHeight>
  <x:WindowWidth>20490</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="3073"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=705 style='border-collapse:
 collapse;table-layout:fixed;width:529pt'>
 <col class=xl24 width=32 style='mso-width-source:userset;mso-width-alt:1170;
 width:24pt'>
 <col class=xl24 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl24 width=116 style='mso-width-source:userset;mso-width-alt:4242;
 width:87pt'>
 <col class=xl24 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=87 style='mso-width-source:userset;mso-width-alt:3181;
 width:65pt'>
 <col class=xl24 width=107 style='mso-width-source:userset;mso-width-alt:3913;
 width:80pt'>
 <col class=xl24 width=170 style='mso-width-source:userset;mso-width-alt:6217;
 width:128pt'>
 <col class=xl24 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 width=32 style='height:13.5pt;width:24pt'></td>
  <td class=xl24 width=45 style='width:34pt'></td>
  <td class=xl24 width=116 style='width:87pt'></td>
  <td class=xl24 width=45 style='width:34pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=87 style='width:65pt'></td>
  <td class=xl24 width=107 style='width:80pt'></td>
  <td class=xl24 width=170 style='width:128pt'></td>
  <td class=xl24 width=39 style='width:29pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
   coordsize="21600,21600" o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe"
   filled="f" stroked="f">
   <v:stroke joinstyle="miter"/>
   <v:formulas>
    <v:f eqn="if lineDrawn pixelLineWidth 0"/>
    <v:f eqn="sum @0 1 0"/>
    <v:f eqn="sum 0 0 @1"/>
    <v:f eqn="prod @2 1 2"/>
    <v:f eqn="prod @3 21600 pixelWidth"/>
    <v:f eqn="prod @3 21600 pixelHeight"/>
    <v:f eqn="sum @0 0 1"/>
    <v:f eqn="prod @6 1 2"/>
    <v:f eqn="prod @7 21600 pixelWidth"/>
    <v:f eqn="sum @8 21600 0"/>
    <v:f eqn="prod @7 21600 pixelHeight"/>
    <v:f eqn="sum @10 21600 0"/>
   </v:formulas>
   <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
   <o:lock v:ext="edit" aspectratio="t"/>
  </v:shapetype><v:shape id="_x0000_s1027" type="#_x0000_t75" style='position:absolute;
   margin-left:23.25pt;margin-top:6.75pt;width:102.75pt;height:50.25pt;
   z-index:2'>
   <v:imagedata src="rpt_htfo00240_conference_only_files/image001.jpg" o:title="AMCO"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:31px;margin-top:9px;width:137px;
  height:67px'><img width=137 height=67
  src="rpt_htfo00240_conference_only_files/image001.jpg" v:shapes="_x0000_s1027"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 class=xl25 width=45 style='height:12.75pt;width:34pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1026"
   type="#_x0000_t75" style='position:absolute;margin-left:34.5pt;margin-top:4.5pt;
   width:99.75pt;height:63.75pt;z-index:1'>
   <v:imagedata src="rpt_htfo00240_conference_only_files/image002.png" o:title="image001"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:46px;margin-top:6px;width:133px;
  height:85px'><img width=133 height=85
  src="rpt_htfo00240_conference_only_files/image003.jpg" v:shapes="_x0000_s1026"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 class=xl26 width=170 style='height:12.75pt;width:128pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td class=xl27>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl24 style='height:21.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=3 class=xl56>Conference Form</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl36 style='border-top:none'>Book No</td>
  <td colspan=2 class=xl57 style='border-right:.5pt solid black;border-left:
  none'>Book Date</td>
  <td class=xl32>Time From</td>
  <td class=xl32><span style='mso-spacerun:yes'> </span>Time To</td>
  <td class=xl32>Setup</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl33><%=dt.Rows[0]["book_no"]%></td>
  <td colspan=2 class=xl59 style='border-right:.5pt solid black;border-left:
  none' x:str><%=dt.Rows[0]["book_date1"]%></td>
  <td class=xl37><%=dt.Rows[0]["time_from"]%></td>
  <td class=xl34><%=dt.Rows[0]["time_to"]%></td>
  <td class=xl34><%=dt.Rows[0]["setup"]%></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl31>Venue</td>
  <td colspan=2 class=xl57 style='border-right:.5pt solid black;border-left:
  none'>Total Person</td>
  <td colspan=2 class=xl61 style='border-right:.5pt solid black;border-left:
  none'>Advance Deposit</td>
  <td class=xl35>Total Due</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl33><%=dt.Rows[0]["venue_type_conference"]%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dt.Rows[0]["total_person"]%></td>
  <td colspan=2 class=xl62 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dt.Rows[0]["cash_deposit_amt"]%></td>
  <td class=xl38 x:num><%=dt.Rows[0]["total_due"]%></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl24 style='height:23.25pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl39>Mr/Mrs/Miss:</td>
  <td colspan=5 class=xl49 style='border-right:.5pt solid black'><%=dt.Rows[0]["contact_person"]%></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl40>Phone:</td>
  <td colspan=5 class=xl66 style='border-right:.5pt solid black'><%=dt.Rows[0]["contact_phone"]%></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=42 style='mso-height-source:userset;height:31.5pt'>
  <td height=42 class=xl24 style='height:31.5pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl41 style='border-top:none'>Email:</td>
  <td colspan=5 class=xl54 style='border-right:.5pt solid black'><%=dt.Rows[0]["contact_email"]%></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=41 style='mso-height-source:userset;height:30.75pt'>
  <td height=41 class=xl24 style='height:30.75pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl41 style='border-top:none'>Conference Name:</td>
  <td colspan=5 class=xl54 style='border-right:.5pt solid black'><%=dt.Rows[0]["conference_name"]%></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl42 style='border-top:none'>Name Of Company:</td>
  <td colspan=5 class=xl49 style='border-right:.5pt solid black'><%=dt.Rows[0]["customer"]%></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=6 class=xl51 style='border-right:.5pt solid black'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl24 style='height:30.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl42 style='border-top:none'>GTD Type:</td>
  <td colspan=5 class=xl49 style='border-right:.5pt solid black'><%=l_GTD_Type%></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl24 style='height:27.75pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl39>Credit Type:</td>
  <td colspan=5 class=xl43 style='border-right:.5pt solid black'><%=l_Credit_type%></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl24 style='height:28.5pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl39>Exp.Date:</td>
  <td colspan=2 class=xl43><%=dt.Rows[0]["expire_date1"]%></td>
  <td class=xl43></td>
  <td class=xl44>Credit CCV:</td>
  <td class=xl45><%=dt.Rows[0]["credit_ccv"]%></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl24 style='height:28.5pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl39>Card No:</td>
  <td colspan=2 class=xl43><%=dt.Rows[0]["credit_no"]%></td>
  <td class=xl43></td>
  <td class=xl44>Credit Owner:</td>
  <td class=xl45><%=dt.Rows[0]["credit_owner"]%></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl24 style='height:19.5pt'></td>
  <td class=xl28>&nbsp;</td>
  <td rowspan=2 class=xl39 style='border-bottom:.5pt solid black'>Description</td>
  <td colspan=5 rowspan=2 class=xl78 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'><%=dt.Rows[0]["description"]%></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl24 style='height:19.5pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl24 style='height:24.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=4 class=xl57 style='border-right:.5pt solid black'>Sales
  Operation &amp; Reservation</td>
  <td colspan=2 class=xl61 style='border-right:.5pt solid black;border-left:
  none'>Accepted by:</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl24 style='height:17.25pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=4 class=xl57 style='border-right:.5pt solid black'>Song Gia
  Suites by Hyundai</td>
  <td colspan=2 class=xl61 style='border-right:.5pt solid black;border-left:
  none'>Full name/Title/Signature</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=146 style='mso-height-source:userset;height:109.5pt'>
  <td height=146 class=xl24 style='height:109.5pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=3 class=xl69 style='border-right:.5pt solid black'>&nbsp;</td>
  <td colspan=3 class=xl72 width=364 style='border-right:.5pt solid black;
  border-left:none;width:273pt'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=43 style='mso-height-source:userset;height:32.25pt'>
  <td height=43 class=xl24 style='height:32.25pt'></td>
  <td colspan=8 class=xl75 width=673 style='border-right:1.0pt solid black;
  width:505pt'>Luu Kiem Thuy Nguyen, Hai Phong City, Vietnam<br>
    Tel: (8431) 396 3900. Fax: (8431) 396 3909. Website: www.songgia.com</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=32 style='width:24pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=170 style='width:128pt'></td>
  <td width=39 style='width:29pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
