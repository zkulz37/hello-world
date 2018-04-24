<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("crm");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%   
                    
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_htfo00250_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_htfo00250_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_htfo00250_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>VINAGENUWIN</o:LastAuthor>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2010-12-11T07:19:50Z</o:LastSaved>
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
	color:blue;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl25
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;}
.xl29
	{mso-style-parent:style0;
	color:red;
	font-size:18.0pt;
	text-align:center;}
.xl40
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#\#0.\#0";
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}	
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
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>17</x:ActiveRow>
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
  <x:WindowHeight>8445</x:WindowHeight>
  <x:WindowWidth>19035</x:WindowWidth>
  <x:WindowTopX>-75</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<%
       DataTable dt = ESysLib.TableReadOpenCursor("CRM.sp_rpt_htfo00250_basic" );                  
%> 
        
<table x:str border=0 cellpadding=0 cellspacing=0 width=2600 style='border-collapse:
 collapse;table-layout:fixed;width:1950pt'>
 <col width=100 span=26 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <tr height=31 style='height:23.25pt'>
  <td colspan=18 height=31 class=xl29 width=2600 style='height:23.25pt;
  width:1950pt'>ROOM INCOME SUMMARY</td>
 </tr>
 <tr class=xl28 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl27 style='height:18.0pt'> </td>
  <td class=xl27> </td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>

  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  
  <td class=xl27>Print Date</td>
  <td class=xl27><%=dt.Rows[0]["print_dt"]%></td>
  
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt;border-top:none'>Room No</td>
  <td class=xl24 style='border-top:none;border-left:none'>Last Name</td>
  <td class=xl24 style='border-top:none;border-left:none'>First Name</td>
  <td class=xl24 style='border-top:none;border-left:none'>Check In</td>
  <td class=xl24 style='border-top:none;border-left:none'>Departure</td>
  <td class=xl24 style='border-top:none;border-left:none'>Days</td>
  <td class=xl24 style='border-top:none;border-left:none'>Room Type</td>
  <td class=xl24 style='border-top:none;border-left:none'>Avg Rate Amount</td>
  <td class=xl24 style='border-top:none;border-left:none'>Nation</td>
  <td class=xl24 style='border-top:none;border-left:none'>F&B Hotel</td>
  <td class=xl24 style='border-top:none;border-left:none'>MiniBar</td>
  <td class=xl24 style='border-top:none;border-left:none'>Laundry</td>
  <td class=xl24 style='border-top:none;border-left:none'>Biz Center</td>
  <td class=xl24 style='border-top:none;border-left:none'>Others</td>
  
  <td class=xl24 style='border-top:none;border-left:none'>Checkin By</td>
  <td class=xl24 style='border-top:none;border-left:none'>Checkin Date</td>
  <td class=xl24 style='border-top:none;border-left:none'>Checkout By</td>

  <td class=xl24 style='border-left:none'>Checkout Date</td>

  <td class=xl24 style='border-top:none;border-left:none'>Rate Plan</td>
  <td class=xl24 style='border-left:none'>Payment Method</td>

 </tr>
<%  
    string l_checkout_yn = Request.QueryString["checkout_yn"];  
    string l_from_dt = Request.QueryString["from_dt"];  
    
    DataTable dt1 = ESysLib.TableReadOpenCursor("CRM.sp_rpt_htfo00250", " '" + l_from_dt + "','" + l_checkout_yn + "'" );                  

    for (int i = 0; i < dt1.Rows.Count; i++)
    {        
%>
 <tr class=xl25 height=51 style='height:38.25pt'>
  <td height=51 class=xl26 width=100 style='height:38.25pt;border-top:none;
  width:75pt'><%=dt1.Rows[i]["room_no"]%></td>
  <td class=xl26 width=100 style='border-top:none;border-left:none;width:75pt'><%=dt1.Rows[i]["last_name"]%></td>
  <td class=xl26 width=100 style='border-top:none;border-left:none;width:75pt'><%=dt1.Rows[i]["first_name"]%></td>
  <td class=xl26 width=100 style='border-top:none;border-left:none;width:75pt'><%=dt1.Rows[i]["checkin_date"]%></td>
  <td class=xl26 width=100 style='border-top:none;border-left:none;width:75pt'><%=dt1.Rows[i]["departure_date"]%></td>
  <td class=xl26 width=100 style='border-top:none;border-left:none;width:75pt'><%=dt1.Rows[i]["days"]%></td>
  <td class=xl26 width=100 style='border-top:none;border-left:none;width:75pt'><%=dt1.Rows[i]["room_type"]%></td>
  <td class=xl40 width=100 style='border-top:none;border-left:none;width:75pt' x:num><%=dt1.Rows[i]["avg_rate_amt"]%></td>
  <td class=xl40 width=100 style='border-top:none;border-left:none;width:75pt'><%=dt1.Rows[i]["nat"]%></td>
  <td class=xl40 width=100 style='border-top:none;border-left:none;width:75pt' x:num><%=dt1.Rows[i]["fnb_hotel_amt"]%></td>
  <td class=xl40 width=100 style='border-top:none;border-left:none;width:75pt' x:num><%=dt1.Rows[i]["minibar_amt"]%></td>
  <td class=xl40 width=100 style='border-top:none;border-left:none;width:75pt' x:num><%=dt1.Rows[i]["laundry_amt"]%></td>
  <td class=xl40 width=100 style='border-top:none;border-left:none;width:75pt' x:num><%=dt1.Rows[i]["biz_center_amt"]%></td>
  <td class=xl40 width=100 style='border-top:none;border-left:none;width:75pt' x:num><%=dt1.Rows[i]["others_amt"]%></td>
  
  <td class=xl26 width=100 style='border-top:none;border-left:none;width:75pt'><%=dt1.Rows[i]["checkin_by"]%></td>
  <td class=xl26 width=100 style='border-top:none;border-left:none;width:75pt'><%=dt1.Rows[i]["checkin_date_time"]%></td>
  <td class=xl26 width=100 style='border-top:none;border-left:none;width:75pt'><%=dt1.Rows[i]["checkout_by"]%></td>
  <td class=xl26 width=100 style='border-top:none;border-left:none;width:75pt'><%=dt1.Rows[i]["checkout_date_time"]%></td>

  <td class=xl26 width=100 style='border-top:none;border-left:none;width:75pt'><%=dt1.Rows[i]["rate_name"]%></td>
  <td class=xl26 width=100 style='border-left:none;width:75pt'><%=dt1.Rows[i]["pay_method"]%></td>

 </tr>
<%  
   }       
%>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>

  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>

  <td width=100 style='width:75pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
