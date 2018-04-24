<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser("prod");%>
<% 	
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";	
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
    string l_wi_pk = "";
    
    string g1_wi_no = "" , g1_wi_date = "" , g1_remark = "" , g1_style = "" , g1_pattern_group = "", g1_mat_name = ""; 
    
    DataTable dt ;
    
    l_wi_pk = Request["wi_pk"];
    
    if ( l_wi_pk.ToString() != "" ) 
    { 
        //=============================
        dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpcw00121", l_wi_pk);
        
        if ( dt.Rows.Count == 0 )
        {
            return;
        } 
        else
        {                          
            g1_wi_no = dt.Rows[0]["wi_no"].ToString() ;
            g1_wi_date = dt.Rows[0]["wi_date"].ToString() ;
            g1_remark = dt.Rows[0]["description"].ToString() ;
            g1_style = dt.Rows[0]["style_name"].ToString() ;
            g1_pattern_group = dt.Rows[0]["group_name"].ToString() ;
            g1_mat_name = dt.Rows[0]["mat_name"].ToString() ;
        } 
        
        //=============================                         
    }
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="fpcw00121_files/filelist.xml">
<link rel=Edit-Time-Data href="fpcw00121_files/editdata.mso">
<link rel=OLE-Object-Data href="fpcw00121_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>QuangNguyen</o:Author>
  <o:LastAuthor>QuangNguyen</o:LastAuthor>
  <o:LastPrinted>2009-09-05T06:16:15Z</o:LastPrinted>
  <o:Created>2009-09-05T05:40:37Z</o:Created>
  <o:LastSaved>2009-09-05T07:10:10Z</o:LastSaved>
  <o:Company>VinaGenuwin</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.17in .2in .17in .2in;
	mso-header-margin:.17in;
	mso-footer-margin:.17in;
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
	font-size:9.0pt;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:9.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl62
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>240</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:Scale>98</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>15</x:ActiveCol>
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
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1304 style='border-collapse:
 collapse;table-layout:fixed;width:981pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=65 span=13 style='mso-width-source:userset;mso-width-alt:
 2377;width:49pt'>
 <col class=xl24 width=64 span=6 style='width:48pt'>
 <tr height=50 style='mso-height-source:userset;height:37.5pt'>
  <td colspan=15 height=50 class=xl39 width=984 style='height:37.5pt;
  width:741pt'>CUTTING PLAN<br>
    (k&#7871; ho&#7841;ch c&#7855;t)</td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl26 style='height:16.5pt'>WI No</td>
  <td colspan=2 class=xl41 style='border-right:.5pt solid black;border-left:
  none'><%=g1_wi_no%></td>
  <td colspan=2 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>Style</td>
  <td colspan=5 class=xl41 style='border-right:.5pt solid black;border-left:
  none'><%=g1_style%></td>
  <td class=xl24></td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black'>MERCHANDISE</td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none'>MANAGER</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl27 style='height:16.5pt'>WI Date</td>
  <td colspan=2 class=xl41 style='border-right:.5pt solid black;border-left:
  none'><%=g1_wi_date%></td>
  <td colspan=2 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>Pattern Grp</td>
  <td colspan=5 class=xl41 style='border-right:.5pt solid black;border-left:
  none'><%=g1_pattern_group%></td>
  <td class=xl24></td>
  <td colspan=2 rowspan=2 class=xl47 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl47 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>&nbsp;</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl27 style='height:16.5pt'>Remark</td>
  <td colspan=2 class=xl41 style='border-right:.5pt solid black;border-left:
  none'><%=g1_remark%></td>
  <td colspan=2 class=xl50 style='border-right:.5pt solid black;border-left:
  none'>Material</td>
  <td colspan=5 class=xl58 style='border-right:.5pt solid black;border-left:
  none'><%=g1_mat_name%></td>
  <td class=xl24></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 colspan=20 class=xl24 style='height:16.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl29 style='height:16.5pt'>Color</td>
  <td class=xl30>Plan Qty</td>
  <td class=xl30>WI Qty</td>
  <td class=xl30>Balance</td>
  <td class=xl30>Layer</td>
  <td class=xl30>S</td>
  <td class=xl30>M</td>
  <td class=xl30>L</td>
  <td class=xl30>XL</td>
  <td class=xl30>2XL</td>
  <td class=xl30>3XL</td>
  <td class=xl30>4XL</td>
  <td class=xl30>NET QTY</td>
  <td class=xl30>TOTAL</td>
  <td class=xl31>UNIT</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
  <% 
    int i=0;
    dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpcw00121_1", l_wi_pk);
    
    for (i = 0; i < dt.Rows.Count; i++)
    {
    
 %>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl32 style='height:16.5pt'><%= dt.Rows[i]["mat_color"].ToString() %></td>
  <td class=xl35 x:num><%= dt.Rows[i]["plan_qty"].ToString() %></td>
  <td class=xl35 x:num><%= dt.Rows[i]["wi_qty"].ToString() %></td>
  <td class=xl35 x:num><%= dt.Rows[i]["balance_qty"].ToString() %></td>
  <td class=xl33 x:num><%= dt.Rows[i]["lot_qty"].ToString() %></td>
  <td class=xl33 x:num><%= dt.Rows[i]["size01_set_qty"].ToString() %></td>
  <td class=xl33 x:num><%= dt.Rows[i]["size02_set_qty"].ToString() %></td>
  <td class=xl33 x:num><%= dt.Rows[i]["size03_set_qty"].ToString() %></td>
  <td class=xl33 x:num><%= dt.Rows[i]["size04_set_qty"].ToString() %></td>
  <td class=xl33 x:num><%= dt.Rows[i]["size05_set_qty"].ToString() %></td>
  <td class=xl33 x:num><%= dt.Rows[i]["size06_set_qty"].ToString() %></td>
  <td class=xl33 x:num><%= dt.Rows[i]["size07_set_qty"].ToString() %></td>
  <td class=xl57 x:num><%= dt.Rows[i]["mat_unit_qty"].ToString() %></td>
  <td class=xl57 x:num><%= dt.Rows[i]["mat_gross_qty"].ToString() %></td>
  <td class=xl28>YDS</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
  <% 
 }
 
 %>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 colspan=20 class=xl24 style='height:16.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl34 style='height:16.5pt'>S.C</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:
  none'>SCHOOL</td>
  <td class=xl31>COLOR</td>
  <td class=xl31>LOT ID</td>
  <td class=xl31>S</td>
  <td class=xl31>M</td>
  <td class=xl31>L</td>
  <td class=xl31>XL</td>
  <td class=xl31>2XL</td>
  <td class=xl31>3XL</td>
  <td class=xl31>4XL</td>
  <td class=xl31>TOTAL</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:
  none'>REMARK</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
<% 
    int t = 0;
    dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpcw00121_2", l_wi_pk);
    
    for (t = 0; t < dt.Rows.Count; t++)
    { 
%>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl32 style='height:16.5pt'><%= dt.Rows[t]["school_id"].ToString() %></td>
  <td colspan=2 class=xl61 style='border-right:.5pt solid black;border-left:
  none'><%= dt.Rows[t]["school_name"].ToString() %></td>
  
  <!--
  <td rowspan=2 class=xl48 style='border-bottom:.5pt solid black;border-top:
  none'>dsfdsf</td>
  <td rowspan=2 class=xl55 style='border-bottom:.5pt solid black;border-top:
  none' x:num>1</td>
  -->
  
   <td  class=xl48 style='border-bottom:.5pt solid black;border-top:
  none'><%= dt.Rows[t]["mat_color"].ToString() %></td>
  <td  class=xl55 style='border-bottom:.5pt solid black;border-top:
  none' x:num><%= dt.Rows[t]["lot_id"].ToString() %></td>
  
  <td class=xl35 x:num><%= dt.Rows[t]["size_01_qty"].ToString() %></td>
  <td class=xl35 x:num><%= dt.Rows[t]["size_02_qty"].ToString() %></td>
  <td class=xl35 x:num><%= dt.Rows[t]["size_03_qty"].ToString() %></td>
  <td class=xl35 x:num><%= dt.Rows[t]["size_04_qty"].ToString() %></td>
  <td class=xl35 x:num><%= dt.Rows[t]["size_05_qty"].ToString() %></td>
  <td class=xl35 x:num><%= dt.Rows[t]["size_06_qty"].ToString() %></td>
  <td class=xl35 x:num><%= dt.Rows[t]["size_07_qty"].ToString() %></td>
  <td class=xl35 x:num><%= dt.Rows[t]["total_qty"].ToString() %></td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
  
<% 
}
%>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl36 style='height:12.75pt'>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38></td>
  <td class=xl35>SUM</td>
  <td class=xl35 x:num x:fmla="=SUM(F10:F<%=10+i-1+t-1%>)"></td>
  <td class=xl35 x:num x:fmla="=SUM(G10:G<%=10+i-1+t-1%>)" ></td>
  <td class=xl35 x:num x:fmla="=SUM(H10:H<%=10+i-1+t-1%>)"></td>
  <td class=xl35 x:num x:fmla="=SUM(I10:I<%=10+i-1+t-1%>)"></td>
  <td class=xl35 x:num x:fmla="=SUM(J10:J<%=10+i-1+t-1%>)"></td>
  <td class=xl35 x:num x:fmla="=SUM(K10:K<%=10+i-1+t-1%>)"></td>
  <td class=xl35 x:num x:fmla="=SUM(L10:L<%=10+i-1+t-1%>)"></td>
  <td class=xl35 x:num x:fmla="=SUM(M10:M<%=10+i-1+t-1%>)"></td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=75 style='width:56pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
