<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser("prod");%>
<% 	
    Response.ContentType = "application/vnd.ms-excel";
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
    string p_from_date = Request.QueryString["p_from_date"];
    string p_to_date = Request.QueryString["p_to_date"];
    string p_po_vendor = Request.QueryString["p_po_vendor"];
    string p_item = Request.QueryString["p_item"];
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_epbp00040_4_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_epbp00040_4_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_epbp00040_4_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>VINAGENUWIN</o:Author>
  <o:LastAuthor>VINAGENUWIN</o:LastAuthor>
  <o:LastPrinted>2010-10-01T15:55:39Z</o:LastPrinted>
  <o:Created>2010-10-01T15:32:41Z</o:Created>
  <o:LastSaved>2010-10-01T16:05:47Z</o:LastSaved>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.53in .39in .46in .4in;
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>240</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>7</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
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
  <x:WindowHeight>9720</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=700 style='border-collapse:
 collapse;table-layout:fixed;width:525pt'>
 <col class=xl24 width=180 style='mso-width-source:userset;mso-width-alt:6582;
 width:135pt'>
 <col class=xl24 width=140 style='mso-width-source:userset;mso-width-alt:5120;
 width:105pt'>
 <col class=xl24 width=80 span=4 style='mso-width-source:userset;mso-width-alt:
 2925;width:60pt'>
 <col class=xl24 width=60 style='mso-width-source:userset;mso-width-alt:2194;
 width:45pt'>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td colspan=7 height=35 class=xl32 width=700 style='height:26.25pt;
  width:525pt'>PURCHASING REPORT BY SUPPLIER</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl25 style='height:18.75pt'>Supplier</td>
  <td class=xl26>Group</td>
  <td class=xl26>P/O Amount</td>
  <td class=xl26>VAT(%)</td>
  <td class=xl26>VAT Amount</td>
  <td class=xl26>Total Amount</td>
  <td class=xl26>CCY</td>
 </tr>
 
  <%
        string para = "'" + p_from_date + "','" + p_to_date + "','" + p_po_vendor + "','" + p_item + "' ";     
        DataTable dt;
        dt = ESysLib.TableReadOpenCursor("prod.sp_rpt_epbp00040_3", para);

        decimal po_amount = 0;
        decimal vat_amount = 0;
        decimal total_amount = 0;
        
        string partner_name = "";
                    
        for (int i = 0; i < dt.Rows.Count; i++)
        {  
        
            po_amount = po_amount + Convert.ToDecimal(dt.Rows[i]["po_amount"]);
            vat_amount = vat_amount + Convert.ToDecimal(dt.Rows[i]["vat_amount"]);
            total_amount = total_amount + Convert.ToDecimal(dt.Rows[i]["total_amount"]);
            
            if ( i == 0 )
            {
                partner_name = dt.Rows[i]["partner_name"].ToString();
            }
  %>
  
  
  <%        if ( partner_name != dt.Rows[i]["partner_name"].ToString() && i != 0 ) 
            {
                partner_name = dt.Rows[i]["partner_name"].ToString();
 %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl33 style='height:15.0pt'>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl35 x:num><%= po_amount %></td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35 x:num><%= vat_amount %></td>
  <td class=xl35 x:num><%= total_amount %></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 
 <%
                po_amount = 0;
                vat_amount = 0;
                total_amount = 0;
            }
 %>
 
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt'><%= dt.Rows[i]["partner_name"]%></td>
  <td class=xl28><%= dt.Rows[i]["grp_nm"]%></td>
  <td class=xl29 x:num><%= dt.Rows[i]["po_amount"]%></td>
  <td class=xl29 x:num><%= dt.Rows[i]["vat_rate"]%></td>
  <td class=xl29 x:num><%= dt.Rows[i]["vat_amount"]%></td>
  <td class=xl30 x:num><%= dt.Rows[i]["total_amount"]%></td>
  <td class=xl31><%= dt.Rows[i]["po_ccy"]%></td>
 </tr>
 
 <% } %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=180 style='width:135pt'></td>
  <td width=140 style='width:105pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=60 style='width:45pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
