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
	string[] stringSeparators = new string[] { "," };
    string[] arr = l_tcm_invoice_pk.Split(stringSeparators, StringSplitOptions.None);
    int sdongcodong = 23;	//so dong co dinh trong 1 trang - phan detail cua trang 
     
	 for ( int k = 0 ; k < arr.Length ; k++ )  
	 {
		
		dt = ESysLib.TableReadOpenCursor("CRM.sp_rpt_htfo00101", arr[k]);
		
		
				
		//Response.Write(arr[10]);
        //Response.End();
		string t_point_name = "" ,t_amt_vn="", t_room_no = "" , t_invoice_id = "" , t_guest_name = "" , t_invoice_date = "" , t_invoice_amt = "" , t_service_rate = "", t_vat_rate = "", t_discount_amt = "", t_invoice_amtvat = "", t_amt_in_words = "";
			
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
			 t_amt_vn=dt.Rows[0]["amt_vnd"].ToString();
		}
         //open table dt2 o day
         DataTable dt2;
       
    dt2 = ESysLib.TableReadOpenCursor("CRM.sp_rpt_htfo00260_1", arr[k]);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="5551_files/filelist.xml">
<link rel=Edit-Time-Data href="5551_files/editdata.mso">
<link rel=OLE-Object-Data href="5551_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr.Quyen</o:Author>
  <o:LastAuthor>Mr.Quyen</o:LastAuthor>
  <o:LastPrinted>2011-06-10T07:04:35Z</o:LastPrinted>
  <o:Created>2011-06-10T06:50:05Z</o:Created>
  <o:LastSaved>2011-06-10T07:24:39Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.44in .75in .48in .75in;
	mso-header-margin:.44in;
	mso-footer-margin:.5in;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style21
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
.style22
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
.xl25
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl26
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl27
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl28
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl29
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl31
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl32
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl34
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl36
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl37
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style22;
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
.xl40
	{mso-style-parent:style22;
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
.xl41
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl42
	{mso-style-parent:style22;
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
.xl43
	{mso-style-parent:style22;
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
.xl44
	{mso-style-parent:style22;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\#\,\#\#0\.\#0";
	text-align:right;}
.xl45
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;}
.xl46
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl47
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;}
.xl48
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl49
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl50
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl51
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:left;}
.xl52
	{mso-style-parent:style22;
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
.xl53
	{mso-style-parent:style22;
	color:black;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl54
	{mso-style-parent:style22;
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
.xl55
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl56
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl57
	{mso-style-parent:style22;
	color:black;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-text-control:shrinktofit;
	text-align:right;
	border:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style22;
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
.xl62
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style22;
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
.xl64
	{mso-style-parent:style22;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
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
      <x:Scale>98</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>33</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
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
  <x:WindowWidth>17115</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=gray vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=648 style='border-collapse:
 collapse;table-layout:fixed;width:486pt'>
 <col width=64 span=9 style='width:48pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td colspan=10 height=39 class=xl55 width=648 style='border-right:1.0pt solid black;
  height:29.25pt;width:486pt'>SONG GIA SUITE HOTEL BY HUYNDAI</td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=10 height=30 class=xl52 style='border-right:1.0pt solid black;
  height:22.5pt'><%=t_point_name%> HOTEL BILL</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl40 style='height:15.0pt'>ROOM#:</td>
  <td colspan=3 class=xl41 x:num><%=t_room_no %></td>
  <td class=xl25>NO</td>
  <td colspan=2 class=xl41 x:str><%=t_invoice_id %></td>
  <td class=xl26></td>
  <td class=xl27>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl49 style='height:15.0pt'>GUEST NAME:</td>
  <td colspan=3 class=xl50><%=t_guest_name %></td>
  <td class=xl25>DATE</td>
  <td colspan=2 class=xl51 x:str><%=t_invoice_date %></td>
  <td class=xl26></td>
  <td class=xl27>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl63 style='height:14.25pt'>NO</td>
  <td colspan=4 class=xl34 style='border-left:none'>DESCRIPTION</td>
  <td class=xl34 style='border-left:none'>UNIT</td>
  <td class=xl34 style='border-left:none'>QTY</td>
  <td class=xl34 style='border-left:none'>PRICE</td>
  <td colspan=2 class=xl34 style='border-right:1.0pt solid black;border-left:
  none'>AMOUNT</td>
 </tr>
  <%
    
            
    for (int i=0;i<dt2.Rows.Count;i++)
    {
%>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl64 style='height:15.0pt;border-top:none' x:num><%=i+1%></td>
  <td colspan=4 class=xl58 style='border-left:none'><%=dt2.Rows[i]["item"].ToString()%></td>
  <td class=xl59 style='border-top:none;border-left:none'><%=dt2.Rows[i]["unit"].ToString()%></td>
  <td class=xl57 style='border-top:none;border-left:none' x:num><%=dt2.Rows[i]["item_qty"].ToString()%></td>
  <td class=xl60 style='border-top:none;border-left:none' x:num><%=dt2.Rows[i]["price"].ToString()%></td>
  <td colspan=2 class=xl60 style='border-right:1.0pt solid black;border-left:
  none' x:num><%=dt2.Rows[i]["amount"].ToString()%></td>
 </tr>
 <%}%>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl31 style='height:14.25pt'>&nbsp;</td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl44>TOTAL AMT</td>
  <td colspan=4 class=xl45 style='border-right:1.0pt solid black' x:num><%=t_invoice_amt %></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl31 style='height:14.25pt'>&nbsp;</td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl44>SVC(5%)</td>
  <td colspan=4 class=xl45 style='border-right:1.0pt solid black' x:num><%=t_service_rate %></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl31 style='height:14.25pt'>&nbsp;</td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl44>VAT(10%)</td>
  <td colspan=4 class=xl45 style='border-right:1.0pt solid black' x:num><%=t_vat_rate %></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl31 style='height:14.25pt'>&nbsp;</td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl44>DISCOUNT</td>
  <td colspan=4 class=xl45 style='border-right:1.0pt solid black' x:num><%=t_discount_amt %></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl31 style='height:14.25pt'>&nbsp;</td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl44>TOTAL DUE</td>
  <td colspan=4 class=xl45 style='border-right:1.0pt solid black' x:num><%=t_amt_vn %></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl31 style='height:14.25pt'>&nbsp;</td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl44>TOTAL DUE(USD)</td>
  <td colspan=4 class=xl47 style='border-right:1.0pt solid black'><%=t_invoice_amtvat %>$</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl31 colspan=3 style='height:14.25pt;mso-ignore:colspan'>AMOUNT
  IN WORDS:</td>
  <td colspan=7 class=xl25 style='border-right:1.0pt solid black'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=10 height=19 class=xl40 style='border-right:1.0pt solid black;
  height:14.25pt'><%=CommondLib.Num2EngText(t_invoice_amtvat,"USD") %></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=3 height=19 class=xl43 style='height:14.25pt'>&nbsp;Guest's
  Signature &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='border-right:1.0pt solid black'>Cashier's
  Signature</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl31 style='height:14.25pt'>&nbsp;</td>
  <td colspan=8 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <%
	int cnt_dtl=0,add_row=0;
	cnt_dtl=dt2.Rows.Count;
	add_row=43-cnt_dtl;
	for (int z =0;z<add_row;z++)
	{
 %>
<tr height=20 style='height:15.0pt'>
  <td height=20 class=xl64 style='height:15.0pt;border-top:none;height:15.0pt;border-left:1.0pt solid windowtext;height:15.0pt;border-right:none;height:15.0pt;border-bottom:none'></td>
  <td colspan=4 class=xl58 style='height:15.0pt;width:13.57pt;border-top:none;height:15.0pt;border-left:none;height:15.0pt;border-right:none;height:15.0pt;border-bottom:none'></td>
  <td class=xl59 style='height:15.0pt;border-top:none;height:15.0pt;border-left:none;height:15.0pt;border-right:none;height:15.0pt;border-bottom:none'></td>
  <td class=xl57 style='height:15.0pt;border-top:none;height:15.0pt;border-left:none;height:15.0pt;border-right:none;height:15.0pt;border-bottom:none'></td>
  <td class=xl60 style='height:15.0pt;border-top:none;height:15.0pt;border-left:none;height:15.0pt;border-right:none;height:15.0pt;border-bottom:none'></td>
  <td colspan=2 class=xl60 style='height:15.0pt;border-top:none;height:15.0pt;border-left:none;height:15.0pt;border-bottom:none;border-right:1.0pt solid windowtext;'></td>
 </tr>
 <%}%>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl36 style='height:15.75pt'>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
 </tr>
 <%}%>
 <![if supportMisalignedColumns]>
 
 <![endif]>
</table>

</body>

</html>
