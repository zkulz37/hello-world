<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("crm");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string  l_tcm_invoice_pk = Request.QueryString["tcm_invoice_pk"];

    DataTable dt;
       
    dt = ESysLib.TableReadOpenCursor("CRM.sp_rpt_htfo00260", l_tcm_invoice_pk);
    
    string t_point_name = "" , t_room_no = "" , t_invoice_id = "" , t_guest_name = "" , t_invoice_date = "" , t_invoice_amt = "" , t_service_rate = "", t_vat_rate = "", t_discount_amt = "", t_invoice_amtvat = "", t_amt_in_words = "";
        
    if (dt.Rows.Count > 0)
    {
         t_point_name = dt.Rows[0]["point_name"].ToString();
         t_room_no = dt.Rows[0]["room_no"].ToString();
         t_invoice_id = dt.Rows[0]["invoice_id"].ToString();
         t_guest_name = dt.Rows[0]["guest_name"].ToString();
         t_invoice_date = dt.Rows[0]["invoice_date"].ToString();
         t_invoice_amt = dt.Rows[0]["invoice_amt"].ToString();
         t_service_rate = dt.Rows[0]["service_rate"].ToString();
         t_vat_rate = dt.Rows[0]["vat_rate"].ToString();
         t_discount_amt = dt.Rows[0]["discount_amt"].ToString();
         t_invoice_amtvat = dt.Rows[0]["invoice_amtvat"].ToString();
         t_amt_in_words = dt.Rows[0]["amt_in_words"].ToString();
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_htfo00260_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_htfo00260_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_htfo00260_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>VINAGENUWIN</o:Author>
  <o:LastAuthor>VINAGENUWIN</o:LastAuthor>
  <o:Created>2010-12-15T03:50:21Z</o:Created>
  <o:LastSaved>2010-12-15T03:51:47Z</o:LastSaved>
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
.style54
	{color:gray;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-style-name:Hyperlink;
	mso-style-id:8;}
a:link
	{color:gray;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
a:visited
	{color:purple;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
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
.style58
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
	mso-style-name:Normal_Sheet1;}
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
.xl66
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl67
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl68
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl69
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl70
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl71
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl72
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl73
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl75
	{mso-style-parent:style58;
	color:black;
	text-align:right;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl77
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl78
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl79
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl80
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl81
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl82
	{mso-style-parent:style58;
	color:black;
	mso-number-format:"\#\,\#\#\#0.\#0";
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl83
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl84
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl86
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl87
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl88
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl89
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl90
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl91
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl92
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl93
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl94
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl95
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl96
	{mso-style-parent:style58;
	color:black;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl97
	{mso-style-parent:style58;
	color:black;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl98
	{mso-style-parent:style58;
	color:black;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl99
	{mso-style-parent:style54;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl100
	{mso-style-parent:style54;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl101
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:left;}
.xl102
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
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
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
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
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>16155</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=gray vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=640 style='border-collapse:
 collapse;table-layout:fixed;width:480pt'>
 <col width=64 span=10 style='width:48pt'>
 <tr height=19 style='height:14.25pt'>
  <td colspan=10 height=19 class=xl93 width=640 style='border-right:1.0pt solid black;
  height:14.25pt;width:480pt'>SONG GIA SUITE HOTEL BY HUYNDAI<br>
    Luu Kiem, Thuy Nguyen, Hai Phong. Tel: +84 313963215 Fax: +84
  313963332<br>
    www.songgia@songgia.com</td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=10 height=30 class=xl96 style='border-right:1.0pt solid black;
  height:22.5pt'><%=t_point_name%> BILL</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl86 style='height:15.0pt'>ROOM#:</td>
  <td colspan=3 class=xl66 x:num><%=t_room_no %></td>
  <td class=xl66>NO</td>
  <td colspan=2 class=xl66 x:num=""><%=t_invoice_id %></td>
  <td class=xl67></td>
  <td class=xl68>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl99 style='height:15.0pt'>GUEST NAME:</td>
  <td colspan=3 class=xl100><%=t_guest_name %></td>
  <td class=xl66>DATE</td>
  <td colspan=2 class=xl101 x:num=""><%=t_invoice_date %></td>
  <td class=xl67></td>
  <td class=xl68>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl71>&nbsp;</td>
 </tr>
 
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl72 style='height:14.25pt'>NO</td>
  <td colspan=4 class=xl72 style='border-left:none'>DESCRIPTION</td>
  <td class=xl72 style='border-left:none'>UNIT</td>
  <td class=xl73 style='border-left:none'>QTY</td>
  <td class=xl73 style='border-left:none'>PRICE</td>
  <td colspan=2 class=xl73 style='border-right:1.0pt solid black;border-left:
  none'>AMOUNT(USD)</td>
 </tr>
 <%
    DataTable dt2;
       
    dt2 = ESysLib.TableReadOpenCursor("CRM.sp_rpt_htfo00260_1", l_tcm_invoice_pk);
            
    for (int i=0;i<dt2.Rows.Count;i++)
    {
%>

 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl74 style='height:15.0pt;border-top:none' x:num><%=i+1%></td>
  <td colspan=4 class=xl84 style='border-right:.5pt solid black;border-left:
  none'><%=dt2.Rows[i]["item"].ToString()%></td>
  <td class=xl75 style='border-top:none;border-left:none'><%=dt2.Rows[i]["unit"].ToString()%></td>
  <td class=xl75 style='border-top:none;border-left:none'><%=dt2.Rows[i]["item_qty"].ToString()%></td>
  <td class=xl75 style='border-top:none;border-left:none'><%=dt2.Rows[i]["price"].ToString()%></td>
  <td colspan=2 class=xl84 style='border-right:1.0pt solid black;border-left:
  none'><%=dt2.Rows[i]["amount"].ToString()%></td>
 </tr>
<%
    }
%>     
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl71>&nbsp;</td>
 </tr>
 
 
 
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl76 style='height:14.25pt'>&nbsp;</td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl82>TOTAL AMT</td>
  <td colspan=4 class=xl82 style='border-right:1.0pt solid black' x:num><%=t_invoice_amt %></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl76 style='height:14.25pt'>&nbsp;</td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl82>SVC(5%)</td>
  <td colspan=4 class=xl82 style='border-right:1.0pt solid black' x:num><%=t_service_rate %></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl76 style='height:14.25pt'>&nbsp;</td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl82>VAT(10%)</td>
  <td colspan=4 class=xl82 style='border-right:1.0pt solid black' x:num><%=t_vat_rate %></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl76 style='height:14.25pt'>&nbsp;</td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl82>DISCOUNT</td>
  <td colspan=4 class=xl82 style='border-right:1.0pt solid black' x:num><%=t_discount_amt %></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl76 style='height:14.25pt'>&nbsp;</td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl82>TOTAL DUE</td>
  <td colspan=4 class=xl82 style='border-right:1.0pt solid black' x:num><%=t_invoice_amtvat %></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl76 colspan=3 style='height:14.25pt;mso-ignore:colspan'>AMOUNT
  IN WORDS:</td>
  <td colspan=7 class=xl90 style='border-right:1.0pt solid black'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=10 height=19 class=xl92 style='border-right:1.0pt solid black;
  height:14.25pt'><%=CommondLib.Num2EngText(t_invoice_amtvat,"USD") %></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=10 height=19 class=xl86 style='border-right:1.0pt solid black;
  height:14.25pt'><span style='mso-spacerun:yes'> </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Guest's
  Signature<span
  style='mso-spacerun:yes'> 
  </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cashier's Signature</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl76 style='height:14.25pt'>&nbsp;</td>
  <td colspan=8 class=xl77 style='mso-ignore:colspan'></td>
  <td class=xl78>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl71>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl71>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl71>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl71>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl71>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl71>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl71>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl71>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl71>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl71>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl71>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl71>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl71>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl71>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl71>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl71>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl71>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl71>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl71>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl79 style='height:15.75pt'>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
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
