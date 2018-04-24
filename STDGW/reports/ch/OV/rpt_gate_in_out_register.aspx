<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html 
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    
    string p_visitor_pk;
    string p_company_pk;
    
    p_visitor_pk       = Request["l_visitor_pk"].ToString();
    p_company_pk       = Session["COMPANY_PK"].ToString();
        
   string SQL
	= "select a.VISITOR_NM " + 
        ",to_char(to_date(a.CHECKIN_DATE,'yyyymmdd'),'dd/mm/yyyy') " +
        ",a.TOTAL_VISITOR " +
        ",a.CHECKIN_TIME " +
        ",a.CHECKOUT_TIME " +
        ",a.PERSONAL_ID " +
        ",a.CONTACT_TO " +
        ",b.COMPANY_NM " +
        ",a.CONTACT_POSITION " +
        ",a.VEHICLE_NO " +
        ",a.CONTACT_DEPT " +
        ",a.CONTACT_REASON " +
        "from thr_visitor_register a,thr_vis_company b " +
        "where a.del_if=0 and a.pk='" + p_visitor_pk + "' and a.del_if=0 and b.del_if(+)=0  " +
        "and a.THR_VIS_COMPANY_PK=b.pk(+) " ;


    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt_total.Rows.Count;
    if (irow == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    
    string SQL_D
	= "select b.PROPERTY_DESC  " + 
        ",b.PROPERTY_QTY " +
        ",b.SERIAL_NO " +
        ",b.PURPOSE_OF_PROPERTY " +
        "from THR_VIS_REGISTER_DETAIL b " +
        "where b.del_if=0 and b.THR_VISITOR_REGISTER_PK='" + p_visitor_pk + "'" ;
    DataTable dt_detail = ESysLib.TableReadOpen(SQL_D);
    int irow_d;
    irow_d = dt_detail.Rows.Count;
    //--------------------company information-----------------------
    string SQL_Com
	= "select  a.TCO_BPPHOTO_PK " + 
        "from tco_company a " +
        "where a.DEL_IF=0 " +
        "and a.pk='" + p_company_pk + "'" ;
    DataTable dt_Com = ESysLib.TableReadOpen(SQL_Com);
    int irow_com;
    irow_com = dt_Com.Rows.Count;
    if (irow_com == 0)
    {
        Response.Write("There is no data of company");
        Response.End();
    }
    %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_gate_in_out_register_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_gate_in_out_register_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_gate_in_out_register_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>tyml</o:Author>
  <o:LastAuthor>tyml</o:LastAuthor>
  <o:LastPrinted>2009-11-27T08:49:16Z</o:LastPrinted>
  <o:Created>2009-11-27T07:26:06Z</o:Created>
  <o:LastSaved>2009-11-27T08:49:47Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.28in .2in .19in .2in;
	mso-header-margin:.17in;
	mso-footer-margin:.16in;
	mso-page-orientation:landscape;}
.font10
	{color:windowtext;
	font-size:13.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font11
	{color:windowtext;
	font-size:13.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font12
	{color:windowtext;
	font-size:17.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font13
	{color:windowtext;
	font-size:17.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style0;
	font-size:17.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl62
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl65
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl66
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
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
      <x:PaperSizeIndex>11</x:PaperSizeIndex>
      <x:Scale>83</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>2</x:ActiveRow>
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
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1054 style='border-collapse:
 collapse;table-layout:fixed;width:792pt'>
 <col class=xl24 width=145 style='mso-width-source:userset;mso-width-alt:5302;
 width:109pt'>
 <col class=xl24 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl24 width=157 style='mso-width-source:userset;mso-width-alt:5741;
 width:118pt'>
 <col class=xl24 width=50 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col class=xl24 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl24 width=155 style='mso-width-source:userset;mso-width-alt:5668;
 width:116pt'>
 <col class=xl24 width=42 style='mso-width-source:userset;mso-width-alt:1536;
 width:32pt'>
 <col class=xl24 width=137 style='mso-width-source:userset;mso-width-alt:5010;
 width:103pt'>
 <col class=xl24 width=49 style='mso-width-source:userset;mso-width-alt:1792;
 width:37pt'>
 <col class=xl24 width=64 span=3 style='width:48pt'>
 <tr height=82 style='mso-height-source:userset;height:61.5pt'>
  <td colspan=9 height=82 width=862 style='height:61.5pt;width:648pt'
  align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
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
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:0;margin-top:3.75pt;width:132.75pt;height:21.75pt;z-index:1'>
   <v:imagedata  o:title="4773c141_11"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:5px;width:177px;
  height:29px'><img width=177 height=59
 src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_Com.Rows[0][0].ToString()%>&table_name=tco_bpphoto" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=9 height=82 class=xl56 width=862 style='height:61.5pt;
    width:648pt'>GI&#7844;Y &#272;&#258;NG KÝ RA VÀO C&#7892;NG<br>
        (<font class="font13">GATE IN-OUT REGISTER</font><font class="font12">)</font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27 width=64 style='width:48pt'></td>
  <td class=xl27 width=64 style='width:48pt'></td>
  <td class=xl27 width=64 style='width:48pt'></td>
 </tr>
 
 <tr class=xl26 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl57 colspan=2 style='height:22.5pt;mso-ignore:colspan'>H&#7885;
  tên khách (<font class="font11">Visitor's name</font><font class="font10">):</font></td>
  <td colspan=2 class=xl50 style='border-right:.5pt solid black' ><%= dt_total.Rows[0][0].ToString() %></td>
  <td class=xl60 colspan=2 style='mso-ignore:colspan'>Ngày vào (<font
  class="font11">Date</font><font class="font10">):</font></td>
  <td colspan=3 class=xl50 style='border-right:.5pt solid black' ><%= dt_total.Rows[0][1].ToString() %></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl58 colspan=2 style='height:22.5pt;mso-ignore:colspan'>T&#7893;ng
  s&#7889; khách (<font class="font11">Total visitors</font><font class="font10">):</font></td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black' x:num><%= dt_total.Rows[0][2].ToString() %></td>
  <td class=xl61 colspan=2 style='mso-ignore:colspan'>Gi&#7901; vào (<font
  class="font11">Time in</font><font class="font10">):</font></td>
  <td class=xl54 ><%= dt_total.Rows[0][3].ToString() %></td>
  <td class=xl61>Gi&#7901; ra (<font class="font11">Time out</font><font
  class="font10">):</font></td>
  <td class=xl55 ><%= dt_total.Rows[0][4].ToString() %></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl58 colspan=2 style='height:22.5pt;mso-ignore:colspan'>S&#7889;
  CMND (<font class="font11">ID/Passport No.</font><font class="font10">):</font></td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black' ><%= dt_total.Rows[0][5].ToString() %></td>
  <td class=xl61 colspan=2 style='mso-ignore:colspan'>Ng&#432;&#7901;i liên
  h&#7879; (<font class="font11">Contact To</font><font class="font10">):</font></td>
  <td colspan=3 class=xl52 style='border-right:.5pt solid black' ><%= dt_total.Rows[0][6].ToString() %></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl58 colspan=2 style='height:22.5pt;mso-ignore:colspan'>Tên
  Cty (<font class="font11">Company name</font><font class="font10">):</font></td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black' ><%= dt_total.Rows[0][7].ToString() %></td>
  <td class=xl61 colspan=2 style='mso-ignore:colspan'>Ch&#7913;c v&#7909; (<font
  class="font11">Position</font><font class="font10">)</font></td>
  <td colspan=3 class=xl52 style='border-right:.5pt solid black' ><%= dt_total.Rows[0][8].ToString() %></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl59 colspan=2 style='height:22.5pt;mso-ignore:colspan'>Bi&#7875;n
  s&#7889; xe (<font class="font11">Vehicle number</font><font class="font10">):</font></td>
  <td colspan=2 class=xl64 style='border-right:.5pt solid black' ><%= dt_total.Rows[0][9].ToString() %></td>
  <td class=xl61 colspan=2 style='mso-ignore:colspan'>B&#7897; ph&#7853;n (<font
  class="font11">Dept</font><font class="font10">.)</font></td>
  <td colspan=3 class=xl52 style='border-right:.5pt solid black' ><%= dt_total.Rows[0][10].ToString() %></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=58 style='mso-height-source:userset;height:43.5pt'>
  <td height=58 class=xl42 width=145 style='height:43.5pt;border-top:none;
  width:109pt'>M&#7909;c &#273;ích vào c&#7893;ng<br>
    (<font class="font11">Purpose to visit</font><font class="font10">)</font></td>
  <td colspan=8 class=xl38 width=717 style='border-right:.5pt solid black;
  border-left:none;width:539pt' ><%= dt_total.Rows[0][11].ToString() %></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=45 style='mso-height-source:userset;height:33.75pt'>
  <td colspan=3 height=45 class=xl43 width=378 style='border-right:.5pt solid black;
  height:33.75pt;width:284pt'>Mô t&#7843; hàng hóa, tài s&#7843;n mang
  theo<br>
    (<font class="font11">Description of Property</font><font class="font10">)</font></td>
  <td colspan=2 class=xl42 width=101 style='border-left:none;width:76pt'>S&#7889;
  l&#432;&#7907;ng<br>
    (<font class="font11">Q.ty /Unit</font><font class="font10">)</font></td>
  <td class=xl47 width=155 style='border-top:none;border-left:none;width:116pt'>Serial
  No.<br>
    /Part No.</td>
  <td colspan=3 class=xl42 width=228 style='border-left:none;width:172pt'>M&#7909;c
  &#273;ích<br>
    (<font class="font11">Purpose</font><font class="font10">)</font></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <%
    if (irow_d==0)
    {
    
  %>
    <tr class=xl26 height=61 style='mso-height-source:userset;height:45.75pt'>
  <td colspan=3 height=61 class=xl43 width=378 style='border-right:.5pt solid black;
  height:45.75pt;width:284pt'></td>
  <td colspan=2 class=xl43 width=101 style='border-right:.5pt solid black;
  border-left:none;width:76pt' x:num></td>
  <td class=xl66 width=155 style='border-top:none;border-left:none;width:116pt'
  x:num></td>
  <td colspan=3 class=xl67 width=228 style='border-right:.5pt solid black;
  border-left:none;width:172pt' x:num></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <%}
    else
    { %>
 <%
        for (int i=0;i<irow_d;i++)
        {
  %>

 <tr class=xl26 height=61 style='mso-height-source:userset;height:45.75pt'>
  <td colspan=3 height=61 class=xl43 width=378 style='border-right:.5pt solid black;
  height:45.75pt;width:284pt'><%= dt_detail.Rows[i][0].ToString() %></td>
  <td colspan=2 class=xl43 width=101 style='border-right:.5pt solid black;
  border-left:none;width:76pt' x:num><%= dt_detail.Rows[i][1].ToString() %></td>
  <td class=xl66 width=155 style='border-top:none;border-left:none;width:116pt'
  x:num><%= dt_detail.Rows[i][2].ToString() %></td>
  <td colspan=3 class=xl67 width=228 style='border-right:.5pt solid black;
  border-left:none;width:172pt' x:num><%= dt_detail.Rows[i][3].ToString() %></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <%
        } // end for
    }// end if    %>
 <tr class=xl26 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=3 height=25 class=xl41 style='border-right:.5pt solid black;
  height:18.75pt'>Especially checking: Camera /Camera mobile /Video</td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl71 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl36 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 
 <tr class=xl26 height=22 style='height:16.5pt'>
  <td height=22 class=xl28 style='height:16.5pt;border-top:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none'>Xác nh&#7853;n c&#7911;a
  ng&#432;&#7901;i liên h&#7879; công tác /<font class="font11">Confirmed by</font></td>
  <td class=xl30 style='border-top:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none'>Xác nh&#7853;n ki&#7875;m tra
  c&#7911;a B&#7843;o v&#7879;/ <font class="font11">Checking by Security</font></td>
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=21 style='height:15.75pt'>
  <td height=21 class=xl31 style='height:15.75pt'>&nbsp;</td>
  <td class=xl26></td>
  <td class=xl32>&nbsp;</td>
  <td class=xl31 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=21 style='height:15.75pt'>
  <td height=21 class=xl31 style='height:15.75pt'>&nbsp;</td>
  <td class=xl26></td>
  <td class=xl32>&nbsp;</td>
  <td class=xl31 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=21 style='height:15.75pt'>
  <td height=21 class=xl31 style='height:15.75pt'>&nbsp;</td>
  <td class=xl26></td>
  <td class=xl32>&nbsp;</td>
  <td class=xl31 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=21 style='height:15.75pt'>
  <td height=21 class=xl31 style='height:15.75pt'>&nbsp;</td>
  <td class=xl26></td>
  <td class=xl32>&nbsp;</td>
  <td class=xl31 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl35 style='height:16.5pt'>&nbsp;</td>
  <td class=xl49>Ký ghi rõ h&#7885; tên (<font class="font11">Sign &amp; Name</font><font
  class="font10">)</font></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl35 style='border-left:none'>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl49>Ký ghi rõ h&#7885; tên (<font class="font11">Sign &amp; Name</font><font
  class="font10">)</font></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=21 style='height:15.75pt'>
  <td height=21 colspan=12 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=21 style='height:15.75pt'>
  <td height=21 colspan=12 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=21 style='height:15.75pt'>
  <td height=21 colspan=12 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=21 style='height:15.75pt'>
  <td height=21 colspan=12 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=21 style='height:15.75pt'>
  <td height=21 colspan=12 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=21 style='height:15.75pt'>
  <td height=21 colspan=12 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=21 style='height:15.75pt'>
  <td height=21 colspan=12 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=21 style='height:15.75pt'>
  <td height=21 colspan=12 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=21 style='height:15.75pt'>
  <td height=21 colspan=12 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=21 style='height:15.75pt'>
  <td height=21 colspan=12 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=21 style='height:15.75pt'>
  <td height=21 colspan=12 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=21 style='height:15.75pt'>
  <td height=21 colspan=12 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=21 style='height:15.75pt'>
  <td height=21 colspan=12 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=145 style='width:109pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=157 style='width:118pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=155 style='width:116pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=137 style='width:103pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
