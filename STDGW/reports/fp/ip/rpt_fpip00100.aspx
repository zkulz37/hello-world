<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("prod");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<%
string datefrom = Request.QueryString["dtFrom"];
string dateto=Request.QueryString["dtTo"];
DataTable dt, dt1, dt2, dt3, dt4, dt5;
dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpip00100_4", "'" + datefrom + "','" + dateto + "'");
dt1 = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpip00100_5", "'" + datefrom + "','" + dateto + "'");
dt2 = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpip00100_6", "'" + datefrom + "','" + dateto + "'");
dt3 = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpip00100_7", "'" + datefrom + "','" + dateto + "'");
dt4 = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpip00100_8", "'" + datefrom + "','" + dateto + "'");
dt5 = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpip00100_9", "'" + datefrom + "','" + dateto + "'");  
 %>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="OrdPlan_files/filelist.xml">
<link rel=Edit-Time-Data href="OrdPlan_files/editdata.mso">
<link rel=OLE-Object-Data href="OrdPlan_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>QuangNguyen</o:Author>
  <o:LastAuthor>HRSV1</o:LastAuthor>
  <o:LastPrinted>2010-02-19T07:14:37Z</o:LastPrinted>
  <o:Created>2010-02-19T02:32:10Z</o:Created>
  <o:LastSaved>2010-02-19T07:22:41Z</o:LastSaved>
  <o:Company>VinaGenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.38in .15in .39in .12in;
	mso-header-margin:.37in;
	mso-footer-margin:.41in;
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
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.5pt solid windowtext;
	border-bottom:1.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.5pt solid windowtext;
	border-left:1.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.5pt solid windowtext;
	border-bottom:1.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	color:navy;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	color:navy;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.5pt solid windowtext;
	border-right:1.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	color:navy;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.5pt solid windowtext;
	border-left:1.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.5pt solid windowtext;
	border-left:.5pt solid windowtext;
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
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>98</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:TopRowVisible>3</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>43</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Area</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$A$1:$J$15</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1040 style='border-collapse:
 collapse;table-layout:fixed;width:785pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=98 style='mso-width-source:userset;mso-width-alt:3584;
 width:74pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=98 style='mso-width-source:userset;mso-width-alt:3584;
 width:74pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=98 style='mso-width-source:userset;mso-width-alt:3584;
 width:74pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=98 style='mso-width-source:userset;mso-width-alt:3584;
 width:74pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=98 style='mso-width-source:userset;mso-width-alt:3584;
 width:74pt'>
 
 
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=4 height=25 class=xl40 width=416 style='height:18.75pt;
  width:314pt'><a name="Print_Area">P/O No</a></td>
  <td colspan=6 class=xl38 width=624 style='border-right:1.5pt solid black;
  border-left:none;width:471pt'>Style</td>
 </tr>
 
 <%
     for (int i = 0; i < dt.Rows.Count; i++)
     {
        %>
        

 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td colspan=2 rowspan=2 height=65 class=xl41 style='height:48.75pt'
  x:num><%=dt.Rows[i]["ref_po_no"]%></td>
  <td colspan=2 class=xl37 style='border-left:none'>*ODP<%=dt.Rows[i]["pp_ordplan_pk"]%>*</td>
  <td colspan=4 rowspan=2 class=xl42><%=dt.Rows[i]["item_code"]%> <%=dt.Rows[i]["item_name"]%></td>
  <td colspan=2 class=xl25 style='border-right:1.5pt solid black;border-left:
  none'>*<%=dt.Rows[i]["item_code"]%>*</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl31 style='height:15.0pt;border-left:none'
  x:num><%=dt.Rows[i]["pp_ordplan_pk"]%></td>
  <td colspan=2 class=xl31 style='border-right:1.5pt solid black;border-left:
  none'><%=dt.Rows[i]["item_code"]%></td>
 </tr>
        <% 
     }
  %> 
 

 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=10 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 
 
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl40 style='height:18.75pt'>Spec 01</td>
  <td colspan=2 class=xl38 style='border-left:none'>Spec 02</td>
  <td colspan=2 class=xl38 style='border-left:none'>Spec 03</td>
  <td colspan=2 class=xl38 style='border-left:none'>Spec 04</td>
  <td colspan=2 class=xl38 style='border-right:1.5pt solid black;border-left:
  none'>Spec 05</td>
 </tr>

<%
    int rownum1 = dt1.Rows.Count;
    int rownum2 = dt2.Rows.Count;
    int rownum3 = dt3.Rows.Count;
    int rownum4 = dt4.Rows.Count;
    int rownum5 = dt5.Rows.Count;
    
    
    //====================================================================================
    
    
    if (rownum1 > rownum2 && rownum1 > rownum3 && rownum1 > rownum4 && rownum1 > rownum5)
    {
        for (int i = 0; i < dt1.Rows.Count; i++)
        {
             %>
             <tr height=40 style='mso-height-source:userset;height:30.0pt'>
              <td rowspan=2 height=60 class=xl32 style='height:45.0pt;border-top:none'><%=dt1.Rows[i]["spec_nm_01"]%></td>
              <td class=xl25 style='border-top:none;border-left:none'>*S1<%=dt1.Rows[i]["spec_id_01"]%>*</td>
              <%
                  if (i >= rownum2)
                  {
                       %>
                       <td rowspan=2 class=xl31 style='border-top:none'></td>
                       <td class=xl25 style='border-top:none;border-left:none'></td>
                       <%
                  }
                  else
                  {
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'><%=dt2.Rows[i]["spec_nm_02"]%></td>
                      <td class=xl25 style='border-top:none;border-left:none'>*S1<%=dt2.Rows[i]["spec_id_02"]%>*</td>
                      <% 
                  }
                  if (i >= rownum3)
                  {
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'></td>
                      <td class=xl25 style='border-top:none;border-left:none'></td>
                      <% 
                  }
                  else
                  {
                       %>
                       <td rowspan=2 class=xl31 style='border-top:none'><%=dt3.Rows[i]["spec_nm_03"]%></td>
                       <td class=xl25 style='border-top:none;border-left:none'>*S1<%=dt3.Rows[i]["spec_id_03"]%>*</td>
                       <%
                  }
                  if (i >= rownum4)
                  {
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'></td>
                      <td class=xl25 style='border-top:none;border-left:none'></td>
                      <%
                      
                  }
                  else
                  { 
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'><%=dt4.Rows[i]["spec_nm_04"]%></td>
                      <td class=xl25 style='border-top:none;border-left:none'>*S1<%=dt4.Rows[i]["spec_id_04"]%>*</td>
                      <%
                  }
                  if (i >= rownum5)
                  {
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'></td>
                      <td class=xl26 style='border-top:none;border-left:none'></td>
                      <% 
                  }
                  else
                  { 
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'><%=dt5.Rows[i]["spec_nm_05"]%></td>
                      <td class=xl26 style='border-top:none;border-left:none'>*S1<%=dt5.Rows[i]["spec_id_05"]%>*</td>
                      <%
                          
                  }
               %>

             </tr>             
             <tr height=20 style='mso-height-source:userset;height:15.0pt'>
              <td height=20 class=xl27 style='height:15.0pt;border-top:none;border-left:none'><%=dt1.Rows[i]["spec_id_01"]%></td>
              <%
                  if (i >= rownum2)
                  {
                       %>
                       <td class=xl27 style='border-top:none;border-left:none'></td>
                       <%
                  }
                  else
                  {
                        %>
                       <td class=xl27 style='border-top:none;border-left:none'><%=dt2.Rows[i]["spec_id_02"]%></td>
                        <%
                  }
                  if (i >= rownum3)
                  {
                      %>
                       <td class=xl27 style='border-top:none;border-left:none'></td>
                      
                      <% 
                  }
                  else
                  { 
                      %>
                        <td class=xl27 style='border-top:none;border-left:none'><%=dt3.Rows[i]["spec_id_03"]%></td>                      
                      <%
                  }
                  if (i >= rownum4)
                  {
                      %>
                        <td class=xl27 style='border-top:none;border-left:none'></td>                      
                      <% 
                  }
                  else
                  { 
                      %>
                        <td class=xl27 style='border-top:none;border-left:none'><%=dt4.Rows[i]["spec_id_04"]%></td>                      
                      <%
                  }
                  if (i >= rownum5)
                  {
                       %>
                        <td class=xl28 style='border-top:none;border-left:none'></td>                       
                       <%
                  }
                  else
                  {
                       %>    
                        <td class=xl28 style='border-top:none;border-left:none'><%=dt5.Rows[i]["spec_id_05"]%></td>                                       
                       <%
                  }
             %>
              
             </tr>
             <%
        } 
    }
                 
                 
    //====================================================================================
                 
                              
    if (rownum2 > rownum1 && rownum2 > rownum3 && rownum2 > rownum4 && rownum2 > rownum5)
    {
        for (int i = 0; i < dt2.Rows.Count; i++)
        {
             %>
             <tr height=40 style='mso-height-source:userset;height:30.0pt'>
              <%
                  if (i >= rownum1)
                  {
                      %>
                      <td rowspan=2 height=60 class=xl32 style='height:45.0pt;border-top:none'></td>
                      <td class=xl25 style='border-top:none;border-left:none'></td>
                      <% 
                  }
                  else
                  {
                      %>
                      <td rowspan=2 height=60 class=xl32 style='height:45.0pt;border-top:none'><%=dt1.Rows[i]["spec_nm_01"]%></td>
                      <td class=xl25 style='border-top:none;border-left:none'>*S1<%=dt1.Rows[i]["spec_id_01"]%>*</td>
                      <% 
                  }
               %>

             <td rowspan=2 class=xl31 style='border-top:none'><%=dt2.Rows[i]["spec_nm_02"]%></td>
             <td class=xl25 style='border-top:none;border-left:none'>*S1<%=dt2.Rows[i]["spec_id_02"]%>*</td>
                 
                <%
                  if (i >= rownum3)
                  {
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'></td>
                      <td class=xl25 style='border-top:none;border-left:none'></td>
                      <% 
                  }
                  else
                  {
                       %>
                       <td rowspan=2 class=xl31 style='border-top:none'><%=dt3.Rows[i]["spec_nm_03"]%></td>
                       <td class=xl25 style='border-top:none;border-left:none'>*S1<%=dt3.Rows[i]["spec_id_03"]%>*</td>
                       <%
                  }
                  if (i >= rownum4)
                  {
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'></td>
                      <td class=xl25 style='border-top:none;border-left:none'></td>
                      <%
                      
                  }
                  else
                  { 
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'><%=dt4.Rows[i]["spec_nm_04"]%></td>
                      <td class=xl25 style='border-top:none;border-left:none'>*S1<%=dt4.Rows[i]["spec_id_04"]%>*</td>
                      <%
                  }
                  if (i >= rownum5)
                  {
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'></td>
                      <td class=xl26 style='border-top:none;border-left:none'></td>
                      <% 
                  }
                  else
                  { 
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'><%=dt5.Rows[i]["spec_nm_05"]%></td>
                      <td class=xl26 style='border-top:none;border-left:none'>*S1<%=dt5.Rows[i]["spec_id_05"]%>*</td>
                      <%
                          
                  }
               %>

             </tr>
             <tr height=20 style='mso-height-source:userset;height:15.0pt'>
             <%
                 if (i >= rownum1)
                 {
                     %>                    
                     <td height=20 class=xl27 style='height:15.0pt;border-top:none;border-left:none'></td>
                     <% 
                 }
                 else
                 {
                     %>              
                     <td height=20 class=xl27 style='height:15.0pt;border-top:none;border-left:none'><%=dt1.Rows[i]["spec_id_01"]%></td>
                     <% 
                 }
              %>             
             
                     <td class=xl27 style='border-top:none;border-left:none'><%=dt2.Rows[i]["spec_id_02"]%></td>
               
                  <%
                  if (i >= rownum3)
                  {
                      %>
                       <td class=xl27 style='border-top:none;border-left:none'></td>
                      
                      <% 
                  }
                  else
                  { 
                      %>
                        <td class=xl27 style='border-top:none;border-left:none'><%=dt3.Rows[i]["spec_id_03"]%></td>                      
                      <%
                  }
                  if (i >= rownum4)
                  {
                      %>
                        <td class=xl27 style='border-top:none;border-left:none'></td>                      
                      <% 
                  }
                  else
                  { 
                      %>
                        <td class=xl27 style='border-top:none;border-left:none'><%=dt4.Rows[i]["spec_id_04"]%></td>                      
                      <%
                  }
                  if (i >= rownum5)
                  {
                       %>
                        <td class=xl28 style='border-top:none;border-left:none'></td>                       
                       <%
                  }
                  else
                  {
                       %>    
                        <td class=xl28 style='border-top:none;border-left:none'><%=dt5.Rows[i]["spec_id_05"]%></td>                                       
                       <%
                  }
             %>
              
             </tr>
             <%
        } 
    }
                 
   //====================================================================================            
   if (rownum3 > rownum1 && rownum3 > rownum2 && rownum3 > rownum4 && rownum3 > rownum5)
    {
        for (int i = 0; i < dt3.Rows.Count; i++)
        {
             %>
             <tr height=40 style='mso-height-source:userset;height:30.0pt'>
              <%
                  if (i >= rownum1)
                  {
                      %>
                      <td rowspan=2 height=60 class=xl32 style='height:45.0pt;border-top:none'></td>
                      <td class=xl25 style='border-top:none;border-left:none'></td>
                      <% 
                  }
                  else
                  {
                      %>
                      <td rowspan=2 height=60 class=xl32 style='height:45.0pt;border-top:none'><%=dt1.Rows[i]["spec_nm_01"]%></td>
                      <td class=xl25 style='border-top:none;border-left:none'>*S1<%=dt1.Rows[i]["spec_id_01"]%>*</td>
                      <% 
                  }
                  if (i >= rownum2)
                  {
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'></td>
                      <td class=xl25 style='border-top:none;border-left:none'></td>
                      <% 
                  }
                  else
                  {
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'><%=dt2.Rows[i]["spec_nm_02"]%></td>
                      <td class=xl25 style='border-top:none;border-left:none'>*S1<%=dt2.Rows[i]["spec_id_02"]%>*</td>
                      <%
                  }
               %>

                       <td rowspan=2 class=xl31 style='border-top:none'><%=dt3.Rows[i]["spec_nm_03"]%></td>
                       <td class=xl25 style='border-top:none;border-left:none'>*S1<%=dt3.Rows[i]["spec_id_03"]%>*</td>
                 
                  <%
                  if (i >= rownum4)
                  {
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'></td>
                      <td class=xl25 style='border-top:none;border-left:none'></td>
                      <%
                      
                  }
                  else
                  { 
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'><%=dt4.Rows[i]["spec_nm_04"]%></td>
                      <td class=xl25 style='border-top:none;border-left:none'>*S1<%=dt4.Rows[i]["spec_id_04"]%>*</td>
                      <%
                  }
                  if (i >= rownum5)
                  {
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'></td>
                      <td class=xl26 style='border-top:none;border-left:none'></td>
                      <% 
                  }
                  else
                  { 
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'><%=dt5.Rows[i]["spec_nm_05"]%></td>
                      <td class=xl26 style='border-top:none;border-left:none'>*S1<%=dt5.Rows[i]["spec_id_05"]%>*</td>
                      <%
                          
                  }
               %>

             </tr>
             <tr height=20 style='mso-height-source:userset;height:15.0pt'>
             <%
                 if (i >= rownum1)
                 {
                     %>                    
                     <td height=20 class=xl27 style='height:15.0pt;border-top:none;border-left:none'></td>
                     <% 
                 }
                 else
                 {
                     %>              
                     <td height=20 class=xl27 style='height:15.0pt;border-top:none;border-left:none'><%=dt1.Rows[i]["spec_id_01"]%></td>
                     <% 
                 }
                 if (i >= rownum2)
                 {
                     %>
                     <td class=xl27 style='border-top:none;border-left:none'></td>                     
                     <% 
                 }
                 else
                 {
                     %>
                     <td class=xl27 style='border-top:none;border-left:none'><%=dt2.Rows[i]["spec_id_02"]%></td>                     
                     <%
                 }
              %>             
             

                    <td class=xl27 style='border-top:none;border-left:none'><%=dt3.Rows[i]["spec_id_03"]%></td>                      
                 
                  <%
                  if (i >= rownum4)
                  {
                      %>
                        <td class=xl27 style='border-top:none;border-left:none'></td>                      
                      <% 
                  }
                  else
                  { 
                      %>
                        <td class=xl27 style='border-top:none;border-left:none'><%=dt4.Rows[i]["spec_id_04"]%></td>                      
                      <%
                  }
                  if (i >= rownum5)
                  {
                       %>
                        <td class=xl28 style='border-top:none;border-left:none'></td>                       
                       <%
                  }
                  else
                  {
                       %>    
                        <td class=xl28 style='border-top:none;border-left:none'><%=dt5.Rows[i]["spec_id_05"]%></td>                                       
                       <%
                  }
             %>
              
             </tr>
             <%
        } 
    }
                 
 //====================================================================================  
                 
                           
   if (rownum4 > rownum1 && rownum4 > rownum2 && rownum4 > rownum3 && rownum4 > rownum5)
    {
        for (int i = 0; i < dt4.Rows.Count; i++)
        {
             %>
             <tr height=40 style='mso-height-source:userset;height:30.0pt'>
              <%
                  if (i >= rownum1)
                  {
                      %>
                      <td rowspan=2 height=60 class=xl32 style='height:45.0pt;border-top:none'></td>
                      <td class=xl25 style='border-top:none;border-left:none'></td>
                      <% 
                  }
                  else
                  {
                      %>
                      <td rowspan=2 height=60 class=xl32 style='height:45.0pt;border-top:none'><%=dt1.Rows[i]["spec_nm_01"]%></td>
                      <td class=xl25 style='border-top:none;border-left:none'>*S1<%=dt1.Rows[i]["spec_id_01"]%>*</td>
                      <% 
                  }
                  if (i >= rownum2)
                  {
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'></td>
                      <td class=xl25 style='border-top:none;border-left:none'></td>
                      <% 
                  }
                  else
                  {
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'><%=dt2.Rows[i]["spec_nm_02"]%></td>
                      <td class=xl25 style='border-top:none;border-left:none'>*S1<%=dt2.Rows[i]["spec_id_02"]%>*</td>
                      <%
                  }
                  if (i >= rownum3)
                  {
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'></td>
                      <td class=xl25 style='border-top:none;border-left:none'></td>
                      <% 
                  }
                  else
                  {
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'><%=dt3.Rows[i]["spec_nm_03"]%></td>
                      <td class=xl25 style='border-top:none;border-left:none'>*S1<%=dt3.Rows[i]["spec_id_03"]%>*</td>
                      <%
                  }
               %>

                       
                      <td rowspan=2 class=xl31 style='border-top:none'><%=dt4.Rows[i]["spec_nm_04"]%></td>
                      <td class=xl25 style='border-top:none;border-left:none'>*S1<%=dt4.Rows[i]["spec_id_04"]%>*</td>
                
               <%
                  if (i >= rownum5)
                  {
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'></td>
                      <td class=xl26 style='border-top:none;border-left:none'></td>
                      <% 
                  }
                  else
                  { 
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'><%=dt5.Rows[i]["spec_nm_05"]%></td>
                      <td class=xl26 style='border-top:none;border-left:none'>*S1<%=dt5.Rows[i]["spec_id_05"]%>*</td>
                      <%
                          
                  }
               %>

             </tr>
             <tr height=20 style='mso-height-source:userset;height:15.0pt'>
             <%
                 if (i >= rownum1)
                 {
                     %>                    
                     <td height=20 class=xl27 style='height:15.0pt;border-top:none;border-left:none'></td>
                     <% 
                 }
                 else
                 {
                     %>              
                     <td height=20 class=xl27 style='height:15.0pt;border-top:none;border-left:none'><%=dt1.Rows[i]["spec_id_01"]%></td>
                     <% 
                 }
                 if (i >= rownum2)
                 {
                     %>
                     <td class=xl27 style='border-top:none;border-left:none'></td>                     
                     <% 
                 }
                 else
                 {
                     %>
                     <td class=xl27 style='border-top:none;border-left:none'><%=dt2.Rows[i]["spec_id_02"]%></td>                     
                     <%
                 }
                 if (i >= rownum3)
                 {
                      %>
                    <td class=xl27 style='border-top:none;border-left:none'></td>                                            
                      <%
                 }
                 else
                 {
                     %>
                    <td class=xl27 style='border-top:none;border-left:none'><%=dt3.Rows[i]["spec_id_03"]%></td>                                           
                     <% 
                 }
              %>             
             

                    <td class=xl27 style='border-top:none;border-left:none'><%=dt4.Rows[i]["spec_id_04"]%></td>                      
                 
              <%
                  if (i >= rownum5)
                  {
                       %>
                        <td class=xl28 style='border-top:none;border-left:none'></td>                       
                       <%
                  }
                  else
                  {
                       %>    
                        <td class=xl28 style='border-top:none;border-left:none'><%=dt5.Rows[i]["spec_id_05"]%></td>                                       
                       <%
                  }
             %>
              
             </tr>
             <%
        } 
    }
                 
//====================================================================================  
                 
                           
   if (rownum5 > rownum1 && rownum5 > rownum2 && rownum5 > rownum3 && rownum5 > rownum4)
    {
        for (int i = 0; i < dt5.Rows.Count; i++)
        {
             %>
             <tr height=40 style='mso-height-source:userset;height:30.0pt'>
              <%
                  if (i >= rownum1)
                  {
                      %>
                      <td rowspan=2 height=60 class=xl32 style='height:45.0pt;border-top:none'></td>
                      <td class=xl25 style='border-top:none;border-left:none'></td>
                      <% 
                  }
                  else
                  {
                      %>
                      <td rowspan=2 height=60 class=xl32 style='height:45.0pt;border-top:none'><%=dt1.Rows[i]["spec_nm_01"]%></td>
                      <td class=xl25 style='border-top:none;border-left:none'>*S1<%=dt1.Rows[i]["spec_id_01"]%>*</td>
                      <% 
                  }
                  if (i >= rownum2)
                  {
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'></td>
                      <td class=xl25 style='border-top:none;border-left:none'></td>
                      <% 
                  }
                  else
                  {
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'><%=dt2.Rows[i]["spec_nm_02"]%></td>
                      <td class=xl25 style='border-top:none;border-left:none'>*S1<%=dt2.Rows[i]["spec_id_02"]%>*</td>
                      <%
                  }
                  if (i >= rownum3)
                  {
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'></td>
                      <td class=xl25 style='border-top:none;border-left:none'></td>
                      <% 
                  }
                  else
                  {
                      %>
                      <td rowspan=2 class=xl31 style='border-top:none'><%=dt3.Rows[i]["spec_nm_03"]%></td>
                      <td class=xl25 style='border-top:none;border-left:none'>*S1<%=dt3.Rows[i]["spec_id_03"]%>*</td>
                      <%
                  }
                  if (i >= rownum4)
                  {
                       %>
                      <td rowspan=2 class=xl31 style='border-top:none'></td>
                      <td class=xl25 style='border-top:none;border-left:none'></td>
                       <%
                  }
                  else
                  {
                       %>
                      <td rowspan=2 class=xl31 style='border-top:none'><%=dt4.Rows[i]["spec_nm_04"]%></td>
                      <td class=xl25 style='border-top:none;border-left:none'>*S1<%=dt4.Rows[i]["spec_id_04"]%>*</td>
                       <%
                  }
               %>

                      <td rowspan=2 class=xl31 style='border-top:none'><%=dt5.Rows[i]["spec_nm_05"]%></td>
                      <td class=xl26 style='border-top:none;border-left:none'>*S1<%=dt5.Rows[i]["spec_id_05"]%>*</td

             </tr>
             <tr height=20 style='mso-height-source:userset;height:15.0pt'>
             <%
                 if (i >= rownum1)
                 {
                     %>                    
                     <td height=20 class=xl27 style='height:15.0pt;border-top:none;border-left:none'></td>
                     <% 
                 }
                 else
                 {
                     %>              
                     <td height=20 class=xl27 style='height:15.0pt;border-top:none;border-left:none'><%=dt1.Rows[i]["spec_id_01"]%></td>
                     <% 
                 }
                 if (i >= rownum2)
                 {
                     %>
                     <td class=xl27 style='border-top:none;border-left:none'></td>                     
                     <% 
                 }
                 else
                 {
                     %>
                     <td class=xl27 style='border-top:none;border-left:none'><%=dt2.Rows[i]["spec_id_02"]%></td>                     
                     <%
                 }
                 if (i >= rownum3)
                 {
                      %>
                    <td class=xl27 style='border-top:none;border-left:none'></td>                                            
                      <%
                 }
                 else
                 {
                     %>
                    <td class=xl27 style='border-top:none;border-left:none'><%=dt3.Rows[i]["spec_id_03"]%></td>                                           
                     <% 
                 }
                 if (i >= rownum4)
                 {
                     %>
                    <td class=xl27 style='border-top:none;border-left:none'></td>                      
                     
                     <%
                 }
                 else
                 {
                     %>
                    <td class=xl27 style='border-top:none;border-left:none'><%=dt4.Rows[i]["spec_id_04"]%></td>                      
                     
                     <%
                 }
              %>             
             
    
                      <td class=xl28 style='border-top:none;border-left:none'><%=dt5.Rows[i]["spec_id_05"]%></td>                                       

             </tr>
             <%
        } 
    }
 %>

 <%--<tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td rowspan=2 height=60 class=xl32 style='height:45.0pt;border-top:none'>FLORIDA</td>
  <td class=xl25 style='border-top:none;border-left:none'>*S1001*</td>
  <td rowspan=2 class=xl31 style='border-top:none'>FLORIDA</td>
  <td class=xl25 style='border-top:none;border-left:none'>*S1001*</td>
  <td rowspan=2 class=xl31 style='border-top:none'>FLORIDA</td>
  <td class=xl25 style='border-top:none;border-left:none'>*S1001*</td>
  <td rowspan=2 class=xl31 style='border-top:none'>FLORIDA</td>
  <td class=xl25 style='border-top:none;border-left:none'>*S1001*</td>
  <td rowspan=2 class=xl31 style='border-top:none'>FLORIDA</td>
  <td class=xl26 style='border-top:none;border-left:none'>*S1001*</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt;border-top:none;border-left:
  none'>001</td>
  <td class=xl27 style='border-top:none;border-left:none'>001</td>
  <td class=xl27 style='border-top:none;border-left:none'>001</td>
  <td class=xl27 style='border-top:none;border-left:none'>001</td>
  <td class=xl28 style='border-top:none;border-left:none'>001</td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td rowspan=2 height=60 class=xl32 style='height:45.0pt;border-top:none'>FLORIDA</td>
  <td class=xl25 style='border-top:none;border-left:none'>*S1001*</td>
  <td rowspan=2 class=xl31 style='border-top:none'>FLORIDA</td>
  <td class=xl25 style='border-top:none;border-left:none'>*S1001*</td>
  <td rowspan=2 class=xl31 style='border-top:none'>FLORIDA</td>
  <td class=xl25 style='border-top:none;border-left:none'>*S1001*</td>
  <td rowspan=2 class=xl31 style='border-top:none'>FLORIDA</td>
  <td class=xl25 style='border-top:none;border-left:none'>*S1001*</td>
  <td rowspan=2 class=xl31 style='border-top:none'>FLORIDA</td>
  <td class=xl26 style='border-top:none;border-left:none'>*S1001*</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt;border-top:none;border-left:
  none'>002</td>
  <td class=xl27 style='border-top:none;border-left:none'>001</td>
  <td class=xl27 style='border-top:none;border-left:none'>001</td>
  <td class=xl27 style='border-top:none;border-left:none'>001</td>
  <td class=xl28 style='border-top:none;border-left:none'>001</td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td rowspan=2 height=60 class=xl32 style='border-bottom:1.5pt solid black;
  height:45.0pt;border-top:none'>FLORIDA</td>
  <td class=xl25 style='border-top:none;border-left:none'>*S1001*</td>
  <td rowspan=2 class=xl31 style='border-bottom:1.5pt solid black;border-top:
  none'>FLORIDA</td>
  <td class=xl25 style='border-top:none;border-left:none'>*S1001*</td>
  <td rowspan=2 class=xl31 style='border-bottom:1.5pt solid black;border-top:
  none'>FLORIDA</td>
  <td class=xl25 style='border-top:none;border-left:none'>*S1001*</td>
  <td rowspan=2 class=xl31 style='border-bottom:1.5pt solid black;border-top:
  none'>FLORIDA</td>
  <td class=xl25 style='border-top:none;border-left:none'>*S1001*</td>
  <td rowspan=2 class=xl31 style='border-bottom:1.5pt solid black;border-top:
  none'>FLORIDA</td>
  <td class=xl26 style='border-top:none;border-left:none'>*S1001*</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt;border-top:none;border-left:
  none'>003</td>
  <td class=xl29 style='border-top:none;border-left:none'>001</td>
  <td class=xl29 style='border-top:none;border-left:none'>001</td>
  <td class=xl29 style='border-top:none;border-left:none'>001</td>
  <td class=xl30 style='border-top:none;border-left:none'>001</td>
 </tr>--%>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=10 class=xl24 style='height:13.5pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=110 style='width:83pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=98 style='width:74pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
