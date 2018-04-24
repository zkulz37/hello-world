<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("prod");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string saleorderpk = "";
	
    saleorderpk = Request.QueryString["saleorderpk"];
    
    DataTable dt;
    string sql = "select * from prod.WI_PROD_CARD a where a.del_if=0 and ref_table_name = 'PP_ORDPLAND' and a.REF_TABLE_PK ='" + saleorderpk + "' order by a.card_Seq ";
    dt = ESysLib.TableReadOpen(sql);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_fpip00102_snj_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_fpip00102_snj_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_fpip00102_snj_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Window XP Service Pack 2</o:Author>
  <o:LastAuthor>QuangNguyen</o:LastAuthor>
  <o:LastPrinted>2010-05-05T02:30:09Z</o:LastPrinted>
  <o:Created>2008-01-28T02:29:49Z</o:Created>
  <o:LastSaved>2010-05-05T02:35:50Z</o:LastSaved>
  <o:Company>Microsoft</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.52in .16in .1in .28in;
	mso-header-margin:0in;
	mso-footer-margin:0in;}
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
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;}
.xl32
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl34
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"d\\-mmm";
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	color:black;}
.xl42
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl48
	{mso-style-parent:style0;
	color:black;
	font-size:34.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	color:black;
	font-size:34.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	color:black;
	font-size:34.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	color:black;
	font-size:34.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	color:black;
	font-size:34.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	color:black;
	font-size:34.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl62
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl63
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl65
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]mmmm\\ d\\\,\\ yyyy\;\@";
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	color:black;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl69
	{mso-style-parent:style0;
	color:black;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl70
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl71
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl72
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl73
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl74
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl75
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	color:black;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl77
	{mso-style-parent:style0;
	color:black;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
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
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>3</x:ActiveRow>
       <x:ActiveCol>11</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
      <x:RowBreak>
       <x:Row>42</x:Row>
      </x:RowBreak>
     </x:RowBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8100</x:WindowHeight>
  <x:WindowWidth>14805</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>2115</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1096 style='border-collapse:
 collapse;table-layout:fixed;width:824pt'>
 <col width=95 style='mso-width-source:userset;mso-width-alt:3474;width:71pt'>
 <col width=45 style='mso-width-source:userset;mso-width-alt:1645;width:34pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=62 style='mso-width-source:userset;mso-width-alt:2267;width:47pt'>
 <col width=172 style='mso-width-source:userset;mso-width-alt:6290;width:129pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=67 style='mso-width-source:userset;mso-width-alt:2450;width:50pt'>
 <col width=52 style='mso-width-source:userset;mso-width-alt:1901;width:39pt'>
 <col width=114 style='mso-width-source:userset;mso-width-alt:4169;width:86pt'>
 <col width=210 style='mso-width-source:userset;mso-width-alt:7680;width:158pt'>
 <col width=105 style='mso-width-source:userset;mso-width-alt:3840;width:79pt'>
 <col width=19 style='mso-width-source:userset;mso-width-alt:694;width:14pt'>
 <col width=69 style='mso-width-source:userset;mso-width-alt:2523;width:52pt'>
 <col width=62 style='mso-width-source:userset;mso-width-alt:2267;width:47pt'>
 <col width=137 style='mso-width-source:userset;mso-width-alt:5010;width:103pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=67 style='mso-width-source:userset;mso-width-alt:2450;width:50pt'>
 <col width=52 style='mso-width-source:userset;mso-width-alt:1901;width:39pt'>
 <col width=66 style='mso-width-source:userset;mso-width-alt:2413;width:50pt'>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
 
   <%
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            %>
            
  <td colspan=6 height=40 class=xl65 width=507 style='height:30.0pt;width:381pt'
  x:str="S &amp; J HOSIERY (VIETNAM) CO.,LTD. ">S &amp; J HOSIERY (VIETNAM)
  CO.,LTD.<span style='mso-spacerun:yes'> </span></td>
  <td class=xl24 width=72 style='width:54pt'>EX. FAC.:</td>
  <td colspan=2 class=xl67 width=141 style='width:106pt'><%=dt.Rows[i]["ATT05"]%></td>
  <td class=xl24 width=52 style='width:39pt'>&nbsp;</td>
  <td class=xl25 width=114 style='width:86pt'>&nbsp;</td>
  <td class=xl26 width=210 style='width:158pt'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl27 style='height:30.0pt'>S&amp;J Order #:</td>
  <td colspan=2 class=xl64><%=dt.Rows[i]["REF_PO_NO"]%></td>
  <td class=xl28>Article #:</td>
  <td class=xl30><%=dt.Rows[i]["STYLE_ID"]%></td>
  <td class=xl29></td>
  <td class=xl47>Desc.:</td>
  <td colspan=4 class=xl47 style='border-right:1.0pt solid black'><%=dt.Rows[i]["STYLE_NAME"]%></td>
  <td class=xl26></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl27 style='height:30.0pt'>Buyer Order #:</td>
  <td colspan=2 class=xl64><%=dt.Rows[i]["ATT01"]%></td>
  <td class=xl28>Order Qty:</td>
  <td class=xl31 x:num ><%=dt.Rows[i]["ORDER_QTY"]%></td>
  <td class=xl29></td>
  <td class=xl47>Colorway:</td>
  <td colspan=2 class=xl30><%=dt.Rows[i]["SPEC02"]%></td>
  <td class=xl47>SIZE:</td>
  <td class=xl46><%=dt.Rows[i]["SPEC03"]%></td>
  <td class=xl26></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl27 style='height:30.0pt'>Foot/Shaft/Rim:</td>
  <td colspan=2 class=xl64><%=dt.Rows[i]["ATT03"]%></td>
  <td class=xl28>Link Type:</td>
  <td class=xl30><%=dt.Rows[i]["ATT02"]%></td>
  <td class=xl29></td>
  <td class=xl47>Card Qty:</td>
  <td colspan=2 class=xl30><%=dt.Rows[i]["CARD_QTY"]%></td>
  <td class=xl47>NDL.:</td>
  <td class=xl46><%=dt.Rows[i]["ATT04"]%></td>
  <td class=xl26></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td colspan=2 height=33 class=xl62 style='height:24.95pt'>Labelling Shift:</td>
  <td colspan=3 class=xl76 width=302 style='border-right:1.0pt solid black;
  width:227pt'><%=dt.Rows[i]["ref_po_no"]%> / <%=dt.Rows[i]["STYLE_ID"]%> / <%=dt.Rows[i]["SPEC02"]%> / <%=dt.Rows[i]["SPEC03"]%></td>
  <td colspan=2 class=xl59 style='border-left:none'>Packing Shift:</td>
  <td colspan=4 class=xl68 style='border-right:1.0pt solid black'><%=dt.Rows[i]["ref_po_no"]%> / <%=dt.Rows[i]["STYLE_ID"]%> / <%=dt.Rows[i]["SPEC02"]%> / <%=dt.Rows[i]["SPEC03"]%></td>
  <td class=xl33></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl34 style='height:24.95pt'>Card Qty:</td>
  <td class=xl38><%=dt.Rows[i]["CARD_QTY"]%></td>
  <td class=xl36>Labeler ID#:</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl34>Card Qty:</td>
  <td class=xl38 x:num><%=dt.Rows[i]["CARD_QTY"]%></td>
  <td class=xl36>&nbsp;</td>
  <td colspan=2 class=xl45>Packer_ID#:</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl33></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl34 style='height:24.95pt'>Date Start:</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl35>Date Finish:</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>M/C# :</td>
  <td class=xl34>Date Start:</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td colspan=2 class=xl45>Date Finish:</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl33></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl34 style='height:24.95pt'>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl33></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td colspan=3 height=33 class=xl55 style='height:24.95pt'><%=dt.Rows[i]["CARD_ID"]%></td>
  <td colspan=2 class=xl56>Card <%=dt.Rows[i]["card_seq"]%> of <%=dt.Rows[i]["ATT06"]%></td>
  <td colspan=3 class=xl55><%=dt.Rows[i]["CARD_ID"]%></td>
  <td colspan=3 class=xl57 style='border-right:1.0pt solid black'>Card <%=dt.Rows[i]["card_seq"]%> of <%=dt.Rows[i]["ATT06"]%></td>
  <td class=xl32></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=5 rowspan=2 height=55 class=xl48 style='border-bottom:1.0pt solid black;
  height:41.85pt'>*<%=dt.Rows[i]["CARD_ID"]%>*</td>
  <td colspan=6 rowspan=2 class=xl48 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black'>*<%=dt.Rows[i]["CARD_ID"]%>*</td>
  <td></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl41 style='height:21.75pt'></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td colspan=2 height=33 class=xl59 style='border-right:.5pt solid black;
  height:24.95pt'>Pairing Shift:</td>
  <td colspan=3 class=xl72 style='border-left:none'><%=dt.Rows[i]["ref_po_no"]%> / <%=dt.Rows[i]["STYLE_ID"]%> / <%=dt.Rows[i]["SPEC02"]%> / <%=dt.Rows[i]["SPEC03"]%></td>
  <td colspan=2 class=xl59>Sewing Shift:</td>
  <td colspan=4 class=xl70 style='border-right:1.0pt solid black'><%=dt.Rows[i]["ref_po_no"]%> / <%=dt.Rows[i]["STYLE_ID"]%> / <%=dt.Rows[i]["SPEC02"]%> / <%=dt.Rows[i]["SPEC03"]%></td>
  <td></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl34 style='height:24.95pt'>Card Qty:</td>
  <td class=xl38><%=dt.Rows[i]["CARD_QTY"]%></td>
  <td class=xl36>Pairer_ID#:</td>
  <td class=xl33></td>
  <td class=xl33>Washing :</td>
  <td class=xl34>Card Qty:</td>
  <td class=xl38><%=dt.Rows[i]["CARD_QTY"]%></td>
  <td class=xl36>Optr_ID#:</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl36>M/C # :</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl33></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl34 style='height:24.95pt'>Date Start:</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl36>Date Finish:</td>
  <td class=xl43>&nbsp;</td>
  <td class=xl45>Bck Set.:</td>
  <td class=xl34>Date Start:</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl35>Date Finish:</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl33></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl34 style='height:24.95pt'>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl36>Mending:</td>
  <td class=xl43 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>Damage:</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl33></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td colspan=3 height=33 class=xl55 style='height:24.95pt'><%=dt.Rows[i]["CARD_ID"]%></td>
  <td colspan=2 class=xl57>Card <%=dt.Rows[i]["card_seq"]%> of <%=dt.Rows[i]["ATT06"]%></td>
  <td colspan=3 class=xl55><%=dt.Rows[i]["CARD_ID"]%></td>
  <td colspan=3 class=xl57 style='border-right:1.0pt solid black'>Card <%=dt.Rows[i]["card_seq"]%> of <%=dt.Rows[i]["ATT06"]%></td>
  <td></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=5 rowspan=2 height=55 class=xl48 style='border-bottom:1.0pt solid black;
  height:41.85pt'>*<%=dt.Rows[i]["CARD_ID"]%>*</td>
  <td colspan=6 rowspan=2 class=xl48 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black'>*<%=dt.Rows[i]["CARD_ID"]%>*</td>
  <td></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl41 style='height:21.75pt'></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td colspan=2 height=33 class=xl59 style='height:24.95pt'>Washing Shift:</td>
  <td colspan=3 class=xl73 style='border-right:1.0pt solid black'><%=dt.Rows[i]["ref_po_no"]%> / <%=dt.Rows[i]["STYLE_ID"]%> / <%=dt.Rows[i]["SPEC02"]%> / <%=dt.Rows[i]["SPEC03"]%></td>
  <td colspan=2 class=xl59 style='border-right:.5pt solid black;border-left:
  none'>Setting Shift:</td>
  <td colspan=4 class=xl72 style='border-right:1.0pt solid black;border-left:
  none'><%=dt.Rows[i]["ref_po_no"]%> / <%=dt.Rows[i]["STYLE_ID"]%> / <%=dt.Rows[i]["SPEC02"]%> / <%=dt.Rows[i]["SPEC03"]%></td>
  <td></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl34 style='height:24.95pt'>Card Qty:</td>
  <td class=xl38><%=dt.Rows[i]["CARD_QTY"]%></td>
  <td class=xl36>Washer :</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl37>Damage:</td>
  <td class=xl34 style='border-left:none'>Card Qty:</td>
  <td class=xl38><%=dt.Rows[i]["CARD_QTY"]%></td>
  <td class=xl44>Oprt_ID#:</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>M/C # :</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl33></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl34 style='height:24.95pt'>Date Start:</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl36>Date Finish:</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl34 style='border-left:none'>Date Start:</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>Date Finish:</td>
  <td class=xl43 style='border-top:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none'>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl34 style='height:24.95pt'>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl34 style='border-left:none'>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl33></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td colspan=3 height=33 class=xl55 style='height:24.95pt'><%=dt.Rows[i]["CARD_ID"]%></td>
  <td colspan=2 class=xl57 style='border-right:1.0pt solid black'>Card <%=dt.Rows[i]["card_seq"]%> of <%=dt.Rows[i]["ATT06"]%></td>
  <td colspan=3 class=xl55 style='border-left:none'><%=dt.Rows[i]["CARD_ID"]%></td>
  <td colspan=3 class=xl57 style='border-right:1.0pt solid black'>Card <%=dt.Rows[i]["card_seq"]%> of <%=dt.Rows[i]["ATT06"]%></td>
  <td class=xl32></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=5 rowspan=2 height=51 class=xl48 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black;height:38.85pt'>*<%=dt.Rows[i]["CARD_ID"]%>*</td>
  <td colspan=6 rowspan=2 class=xl48 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black'>*<%=dt.Rows[i]["CARD_ID"]%>*</td>
  <td class=xl41></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl41 style='height:18.75pt'></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td colspan=2 height=33 class=xl59 style='height:24.95pt'>Inspection Shift:</td>
  <td colspan=3 class=xl70 style='border-right:1.0pt solid black'><%=dt.Rows[i]["ref_po_no"]%> / <%=dt.Rows[i]["STYLE_ID"]%> / <%=dt.Rows[i]["SPEC02"]%> / <%=dt.Rows[i]["SPEC03"]%></td>
  <td colspan=2 class=xl59 style='border-left:none'>Pre-Setting Shift:</td>
  <td colspan=4 class=xl70 style='border-right:1.0pt solid black'><%=dt.Rows[i]["ref_po_no"]%> / <%=dt.Rows[i]["STYLE_ID"]%> / <%=dt.Rows[i]["SPEC02"]%> / <%=dt.Rows[i]["SPEC03"]%></td>
  <td class=xl33></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl34 style='height:24.95pt'>Card Qty:</td>
  <td class=xl38><%=dt.Rows[i]["CARD_QTY"]%></td>
  <td colspan=2 class=xl43>Inspection_ID#:</td>
  <td class=xl37>Mending:</td>
  <td class=xl34 style='border-left:none'>Card Qty:</td>
  <td class=xl38><%=dt.Rows[i]["CARD_QTY"]%></td>
  <td class=xl36>Oprt_ID#:</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>M/C # :</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl33></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl34 style='height:24.95pt'>Date Start:</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl36>Date Finish:</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl39>B-Grade:</td>
  <td class=xl34 style='border-left:none'>Date Start:</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>Date Finish:</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl33></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl34 style='height:24.95pt'>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl39>C-Grade:</td>
  <td class=xl34 style='border-left:none'>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl33></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td colspan=3 height=33 class=xl55 style='height:24.95pt'><%=dt.Rows[i]["CARD_ID"]%></td>
  <td colspan=2 class=xl57 style='border-right:1.0pt solid black'>Card <%=dt.Rows[i]["card_seq"]%> of <%=dt.Rows[i]["ATT06"]%></td>
  <td colspan=3 class=xl55 style='border-left:none'><%=dt.Rows[i]["CARD_ID"]%></td>
  <td colspan=3 class=xl57 style='border-right:1.0pt solid black'>Card <%=dt.Rows[i]["card_seq"]%> of <%=dt.Rows[i]["ATT06"]%></td>
  <td class=xl32></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=5 rowspan=2 height=56 class=xl48 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black;height:42.6pt'>*<%=dt.Rows[i]["CARD_ID"]%>*</td>
  <td colspan=6 rowspan=2 class=xl48 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black'>*<%=dt.Rows[i]["CARD_ID"]%>*</td>
  <td class=xl41></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl41 style='height:22.5pt'></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td colspan=2 height=33 class=xl59 style='height:24.95pt'>Knitting Shift:</td>
  <td colspan=3 class=xl70 style='border-right:1.0pt solid black'><%=dt.Rows[i]["ref_po_no"]%> / <%=dt.Rows[i]["STYLE_ID"]%> / <%=dt.Rows[i]["SPEC02"]%> / <%=dt.Rows[i]["SPEC03"]%></td>
  <td colspan=2 class=xl59 style='border-left:none'>Linking Shift:</td>
  <td colspan=4 class=xl70 style='border-right:1.0pt solid black'><%=dt.Rows[i]["ref_po_no"]%> / <%=dt.Rows[i]["STYLE_ID"]%> / <%=dt.Rows[i]["SPEC02"]%> / <%=dt.Rows[i]["SPEC03"]%></td>
  <td class=xl33></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl34 style='height:24.95pt'>Card Qty:</td>
  <td class=xl38><%=dt.Rows[i]["CARD_QTY"]%></td>
  <td class=xl36>M/C#</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl39>Hand Linking</td>
  <td class=xl34 style='border-left:none'>Card Qty:</td>
  <td class=xl38><%=dt.Rows[i]["CARD_QTY"]%></td>
  <td class=xl36>M/C#</td>
  <td class=xl35>&nbsp;</td>
  <td colspan=2 class=xl45 style='border-right:1.0pt solid black'>Hand Linking</td>
  <td class=xl33></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl34 style='height:24.95pt'>Date Start:</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl36>Date Fin:</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl39>B-Grade:</td>
  <td class=xl34 style='border-left:none'>Date Start:</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>Date Fin:</td>
  <td class=xl36>&nbsp;</td>
  <td colspan=2 class=xl45 style='border-right:1.0pt solid black'>Mending:</td>
  <td class=xl33></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl34 style='height:24.95pt'>Oprt ID#:</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl36>Q/C:</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl39>C-Grade:</td>
  <td class=xl34 style='border-left:none'>Oprt ID#:</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>Reverser:</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>Cutter:</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl33></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl34 style='height:24.95pt'>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl39>Totally Damage:</td>
  <td class=xl34 style='border-left:none'>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>Damage:</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl33></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td colspan=3 height=33 class=xl55 style='height:24.95pt'><%=dt.Rows[i]["CARD_ID"]%></td>
  <td colspan=2 class=xl57 style='border-right:1.0pt solid black'>Card <%=dt.Rows[i]["card_seq"]%> of <%=dt.Rows[i]["ATT06"]%></td>
  <td colspan=3 class=xl55 style='border-left:none'><%=dt.Rows[i]["CARD_ID"]%></td>
  <td colspan=3 class=xl57 style='border-right:1.0pt solid black'>Card <%=dt.Rows[i]["card_seq"]%> of <%=dt.Rows[i]["ATT06"]%></td>
  <td class=xl32></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=5 rowspan=2 height=58 class=xl48 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black;height:44.1pt'>*<%=dt.Rows[i]["CARD_ID"]%>*</td>
  <td colspan=6 rowspan=2 class=xl48 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black'>*<%=dt.Rows[i]["CARD_ID"]%>*</td>
  <td class=xl41></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl41 style='height:24.0pt'></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl41 style='height:24.0pt'></td>
  <td colspan=11 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl41 style='height:24.0pt'></td>
  <td colspan=11 style='mso-ignore:colspan'></td>
 </tr>
   <% 
        } 
     %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=95 style='width:71pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=172 style='width:129pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=210 style='width:158pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
