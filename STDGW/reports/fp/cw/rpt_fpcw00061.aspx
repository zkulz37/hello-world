<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% Response.ContentType = "application/vnd.ms-excel"; %>
<% Response.Charset = "utf-8"; %>
<% ESysLib.SetUser("prod");%>
<% Response.Buffer = false;%>

<%        
    DataTable dt , dt_master ;
    
    string l_wi_pk = Request["wi_pk"];

    dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpcw00061", l_wi_pk);

    /*****************************************************************/
    string p_po_no = "", p_cust_name = "" ,  p_group = "" , p_size = "" , p_style_no = "", p_style_name = "" , p_t_a = "" , p_leather = "" ;
    
    
    dt_master = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpcw00061_1", l_wi_pk);
    
    if (dt_master.Rows.Count > 0)
    {
        p_po_no = dt_master.Rows[0]["po_no"].ToString();
        p_cust_name = dt_master.Rows[0]["cust_name"].ToString();
        p_group = dt_master.Rows[0]["t_group"].ToString();
        p_size = dt_master.Rows[0]["t_size"].ToString();
        p_style_no = dt_master.Rows[0]["style_no"].ToString();
        p_style_name = dt_master.Rows[0]["style_name"].ToString();
        p_t_a = dt_master.Rows[0]["t_a"].ToString();
        p_leather = dt_master.Rows[0]["leather"].ToString();                
    }
    /*****************************************************************/
    
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_fpcw00020_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_fpcw00020_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_fpcw00020_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>User</o:Author>
  <o:LastAuthor>QuangNguyen</o:LastAuthor>
  <o:Created>2010-03-22T06:34:03Z</o:Created>
  <o:LastSaved>2010-03-23T05:58:26Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.6360</o:Version>
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
	{mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
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
	mso-font-charset:204;
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
	mso-font-charset:204;
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
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style16;
	font-size:8.0pt;
	mso-number-format:"_-* \#\,\#\#0\.000_-\;\\-* \#\,\#\#0\.000_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	mso-number-format:"0\;\[Red\]0";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:8.0pt;
	mso-number-format:"0\;\[Red\]0";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	font-size:8.0pt;
	mso-number-format:"0\;\[Red\]0";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
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
     <x:DefaultRowHeight>225</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7425</x:WindowHeight>
  <x:WindowWidth>12315</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl27>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1253 style='border-collapse:
 collapse;table-layout:fixed;width:946pt'>
 <col class=xl27 width=64 style='width:48pt'>
 <col class=xl27 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl27 width=140 style='mso-width-source:userset;mso-width-alt:5120;
 width:105pt'>
 <col class=xl27 width=70 span=4 style='mso-width-source:userset;mso-width-alt:
 2560;width:53pt'>
 <col class=xl27 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl27 width=149 style='mso-width-source:userset;mso-width-alt:5449;
 width:112pt'>
 <col class=xl27 width=70 span=3 style='mso-width-source:userset;mso-width-alt:
 2560;width:53pt'>
 <col class=xl27 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl27 width=70 span=3 style='mso-width-source:userset;mso-width-alt:
 2560;width:53pt'>
 <col class=xl27 width=64 style='width:48pt'>
 <col class=xl27 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=11 height=38 class=xl33 width=928 style='height:28.5pt;
  width:700pt'>CUTTING WORK INSTRUCTION</td>
  <td class=xl27 width=70 style='width:53pt'></td>
  <td class=xl27 width=45 style='width:34pt'></td>
  <td class=xl27 width=70 style='width:53pt'></td>
  <td class=xl27 width=70 style='width:53pt'></td>
  <td class=xl27 width=70 style='width:53pt'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt'>Order No.</td>
  <td colspan=2 class=xl34><%=p_po_no%></td>
  <td class=xl35></td>
  <td colspan=12 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'>Buyer</td>
  <td colspan=3 class=xl51 style='border-right:.5pt solid black;border-left:
  none'><%=p_cust_name%></td>
  <td class=xl26 style='border-left:none'>Group</td>
  <td colspan=4 class=xl32 style='border-left:none'><%=p_group%></td>
  <td class=xl26 style='border-left:none'>SIZE</td>
  <td class=xl32 style='border-left:none'><%=p_size%></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt;border-top:none'>Style No.</td>
  <td colspan=3 class=xl51 style='border-right:.5pt solid black;border-left:
  none'><%=p_style_no%></td>
  <td class=xl26 style='border-top:none;border-left:none'>Style Name</td>
  <td colspan=4 class=xl32 style='border-left:none'><%=p_style_name%></td>
  <td class=xl26 style='border-top:none;border-left:none'>T&amp;A</td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%=p_t_a%></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt;border-top:none'>Leather</td>
  <td colspan=10 class=xl32 style='border-left:none'><%=p_leather%></td>
  <td colspan=5 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 colspan=16 class=xl27 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl25 style='height:18.75pt'>Group</td>
  <td class=xl25 style='border-left:none'>Mat Code</td>
  <td class=xl25 style='border-left:none'>Mat Name</td>
  <td class=xl25 style='border-left:none'>Color</td>
  <td class=xl25 style='border-left:none'>Net</td>
  <td class=xl25 style='border-left:none'>Loss (%)</td>
  <td class=xl25 style='border-left:none'>Gross</td>
  <td class=xl25 style='border-left:none'>UOM</td>
  <td class=xl25 style='border-left:none'>Component</td>
  <td class=xl25 style='border-left:none'>Qty</td>
  <td class=xl25 style='border-left:none'>Length</td>
  <td class=xl25 style='border-left:none'>Width</td>
  <td class=xl25 style='border-left:none'>UOM</td>
  <td class=xl25 style='border-left:none'>Net Cons</td>
  <td class=xl25 style='border-left:none'>Loss (%)</td>
  <td class=xl25 style='border-left:none'>Gross Cons</td>
 </tr>
 <% 
     string group_name = "" ;
     for (int i = 0; i < dt.Rows.Count; i++ )
     {
 %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
    <%   
         if ( group_name != dt.Rows[i]["group_name"].ToString() && dt.Rows.Count > 1 )
         {
             group_name = dt.Rows[i]["group_name"].ToString();
    %>
          <td height=20 class=xl40 style='height:15.0pt;border-top:none'><%=dt.Rows[i]["group_name"].ToString()%></td>
          <td class=xl39 style='border-left:none' ><%=dt.Rows[i]["mat_code"].ToString()%></td>
          <td class=xl46 style='border-left:none'><%=dt.Rows[i]["mat_name"].ToString()%></td>
          <td class=xl36 style='border-left:none'><%=dt.Rows[i]["color"].ToString()%></td>
          <td class=xl43 style='border-left:none' x:num><%=dt.Rows[i]["net_qty"].ToString()%></td>
          <td class=xl43 style='border-left:none' x:num><%=dt.Rows[i]["loss_rate"].ToString()%></td>
          <td class=xl43 style='border-left:none' x:num ><%=dt.Rows[i]["gross_qty"].ToString()%></td>
          <td class=xl40 style='border-top:none;border-left:none'><%=dt.Rows[i]["uom1"].ToString()%></td>
 <% 
     }
     else if (dt.Rows.Count == 1 )
         {%>
          
          <td height=20 class=xl42 style='height:15.0pt;border-top:none'><%=dt.Rows[i]["group_name"].ToString()%></td>
          <td class=xl50 style='border-left:none' ><%=dt.Rows[i]["mat_code"].ToString()%></td>
          <td class=xl48 style='border-left:none'><%=dt.Rows[i]["mat_name"].ToString()%></td>
          <td class=xl38 style='border-left:none'><%=dt.Rows[i]["color"].ToString()%></td>
          <td class=xl45 style='border-left:none' x:num><%=dt.Rows[i]["net_qty"].ToString()%></td>
          <td class=xl45 style='border-left:none' x:num><%=dt.Rows[i]["loss_rate"].ToString()%></td>
          <td class=xl45 style='border-left:none' x:num ><%=dt.Rows[i]["gross_qty"].ToString()%></td>
          <td class=xl42 style='border-top:none;border-left:none'><%=dt.Rows[i]["uom1"].ToString()%></td>
                   
   <% 
         }else
         {%>
         <td height=20 class=xl42 style='height:15.0pt'>&nbsp;</td>
  <td class=xl50 style='border-left:none'>&nbsp;</td>
  <td class=xl48 style='border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-left:none'>&nbsp;</td>
  <%} %>
  <td class=xl24 style='border-top:none;border-left:none'><%=dt.Rows[i]["component"].ToString()%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp_qty"].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num=""><%=dt.Rows[i]["t_length"].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num=""><%=dt.Rows[i]["t_width"].ToString()%></td>
  <td class=xl24 style='border-top:none;border-left:none'><%=dt.Rows[i]["uom2"].ToString()%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num x:fmla="=L8*K8">1278.75</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["loss_rate"].ToString()%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num="1406.625"
  x:fmla="=N8+N8*O8%">1406.625</td>
 </tr>
 <!-- 
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl41 style='height:15.0pt'>&nbsp;</td>
  <td class=xl49 style='border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl24 style='border-top:none;border-left:none'>BACK PANEL</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num="46.5"><span
  style='mso-spacerun:yes'>         </span>46.500 </td>
  <td class=xl30 style='border-top:none;border-left:none' x:num="48.8"><span
  style='mso-spacerun:yes'>         </span>48.800 </td>
  <td class=xl24 style='border-top:none;border-left:none'>CM2</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num x:fmla="=L9*K9">2269.2</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>10</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num
  x:fmla="=N9+N9*O9%">2496.12</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl42 style='height:15.0pt'>&nbsp;</td>
  <td class=xl50 style='border-left:none'>&nbsp;</td>
  <td class=xl48 style='border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-left:none'>&nbsp;</td>
  <td class=xl24 style='border-top:none;border-left:none'>FRONT PANEL UPPER</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num="44.8"><span
  style='mso-spacerun:yes'>         </span>44.800 </td>
  <td class=xl30 style='border-top:none;border-left:none' x:num="27.8"><span
  style='mso-spacerun:yes'>         </span>27.800 </td>
  <td class=xl24 style='border-top:none;border-left:none'>CM2</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num
  x:fmla="=L10*K10">1245.44</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>10</td>
  <td class=xl24 style='border-top:none;border-left:none'
  x:num="1369.9840000000002" x:fmla="=N10+N10*O10%">1369.984</td>
 </tr> -->
 <% 
     }
 %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=140 style='width:105pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=149 style='width:112pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
