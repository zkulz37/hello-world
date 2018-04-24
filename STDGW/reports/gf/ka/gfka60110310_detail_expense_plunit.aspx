<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
    ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%

   string p_compk = Request["company"];        
   string p_from = Request["from"];             
   string p_to = Request["to"];               
   string p_acc_pk = Request["acc_cd"];           
  // string p_plcenter = Request["pl_center_pk"];        
   string p_plunit = Request["plunit_pk"];
   string p_pl_cd = Request["pl_cd"];
   string p_pl_nm = Request["pl_nm"];

   string l_parameter = "'" + p_compk + "', ";
   l_parameter += "'" + p_from + "', ";
   l_parameter += "'" + p_to + "', ";
   l_parameter += "'" + p_acc_pk + "', ";
   l_parameter += "'" + p_plunit + "' ";

   //Response.Write(l_parameter);
   //Response.End();
   string from_date = "";
   string to_date = "";

 
   string p_date = "";

   string l_taxcode = "";
   string l_compa = "";
   string l_address = "";

   string SQL1 = " SELECT PARTNER_NAME,ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + p_compk + "' ";
   DataTable dt_f = ESysLib.TableReadOpen(SQL1);
   if (dt_f.Rows.Count > 0)
   {
       l_compa = dt_f.Rows[0][0].ToString();
       l_address = dt_f.Rows[0][1].ToString();
       l_taxcode = dt_f.Rows[0][3].ToString();
   }


   DataTable dt = ESysLib.TableReadOpenCursor("acnt.sp_sel_gfka00310_report", l_parameter);
   if (dt.Rows.Count == 0)
   {
       Response.Write("There is no data!!");
       Response.End();
   }


   from_date = p_from.Substring(4, 2) + "/" + p_from.Substring(0, 4);
   to_date = p_to.Substring(4, 2) + "/" + p_to.Substring(0, 4);


   string l_book_ccy = "";
   String p_xls_ccy_format = "";
   String p_xls_ccy_format_usd = "";
   if (l_book_ccy == "VND")
   {
       p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
       p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
   }
   else
   {
       p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
       p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
   }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="60110310_detail_expense_plunit_files/filelist.xml">
<link rel=Edit-Time-Data
href="60110310_detail_expense_plunit_files/editdata.mso">
<link rel=OLE-Object-Data
href="60110310_detail_expense_plunit_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Phan Thi Thanh Tuyen</o:Author>
  <o:LastAuthor>Mr Long</o:LastAuthor>
  <o:LastPrinted>2010-05-21T03:14:43Z</o:LastPrinted>
  <o:Created>2010-05-19T03:31:22Z</o:Created>
  <o:LastSaved>2010-05-21T03:15:46Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.75in .25in .25in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
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
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>56</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>1</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
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
  <x:WindowWidth>18795</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>285</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1735 style='border-collapse:
 collapse;table-layout:fixed;width:1298pt'>
 <col width=20 style='mso-width-source:userset;mso-width-alt:731;width:15pt'>
 <col width=43 style='mso-width-source:userset;mso-width-alt:1572;width:32pt'>
 <col width=87 style='mso-width-source:userset;mso-width-alt:3181;width:65pt'>
 <col width=83 style='mso-width-source:userset;mso-width-alt:3035;width:62pt'>
 <col width=75 style='mso-width-source:userset;mso-width-alt:2742;width:56pt'>
 <col width=215 style='mso-width-source:userset;mso-width-alt:7862;width:161pt'>
 <col width=103 style='mso-width-source:userset;mso-width-alt:3766;width:77pt'>
 <col width=107 style='mso-width-source:userset;mso-width-alt:3913;width:80pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=215 style='mso-width-source:userset;mso-width-alt:7862;width:161pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=215 span=3 style='mso-width-source:userset;mso-width-alt:7862;
 width:161pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 width=20 style='height:12.75pt;width:15pt'></td>
  <td class=xl24 colspan=4 width=288 style='mso-ignore:colspan;width:215pt'>&nbsp;<%=l_compa%></td>
  <td width=215 style='width:161pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=215 style='width:161pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan'>&nbsp;<%=l_address%></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td height=27 style='height:20.25pt'></td>
  <td colspan=13 class=xl32>BẢNG CHI TIẾT CHI PHÍ/ DETAIL EXPENSE PL UNIT</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 style='height:15.75pt'></td>
  <td class=xl25 colspan=3 style='mso-ignore:colspan'>Từ <%=from_date%> đến <%=to_date%></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl25>PL Unit</td>
  <td class=xl25><%=p_pl_cd%></td>
  <td class=xl25><%=p_pl_nm%></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=14 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 style='height:15.75pt'></td>
  <td class=xl26>Seq</td>
  <td class=xl26 style='border-left:none'>Voucher No</td>
  <td class=xl26 style='border-left:none'>Trans Date</td>
  <td class=xl26 style='border-left:none'>Acc. Code</td>
  <td class=xl26 style='border-left:none'>Acc. Name</td>
  <td class=xl26 style='border-left:none'>Trans Amount</td>
  <td class=xl26 style='border-left:none'>Books Amount</td>
  <td class=xl26 style='border-left:none'>Cust ID</td>
  <td class=xl26 style='border-left:none'>Cust Name</td>
  <td class=xl26 style='border-left:none'>PL Code</td>
  <td class=xl26 style='border-left:none'>PL Name</td>
  <td class=xl26 style='border-left:none'>Remark</td>
  <td class=xl26 style='border-left:none'>Remark</td>
 </tr>
 <%
     for(int i = 0; i<dt.Rows.Count;i++)
     {

         p_date = dt.Rows[0][2].ToString();
         p_date = p_date.Substring(6, 2) + "/" + p_date.Substring(4, 2) + "/" + p_date.Substring(0, 4);
      
  
      %>
 <tr height=63 style='height:47.25pt'>
  <td height=63 style='height:47.25pt'></td>
  <td class=xl27 style='border-top:none'><%=dt.Rows[i][0]%></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt.Rows[i][1]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=p_date%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3]%></td>
  <td class=xl30 width=215 style='border-top:none;border-left:none;width:161pt'><%=dt.Rows[i][4]%></td>
  <td class=xl31 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=dt.Rows[i][5]%></td>
  <td class=xl31 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=dt.Rows[i][6]%></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt.Rows[i][7]%></td>
  <td class=xl30 width=215 style='border-top:none;border-left:none;width:161pt'><%=dt.Rows[i][8]%></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt.Rows[i][9]%></td>
  <td class=xl30 width=215 style='border-top:none;border-left:none;width:161pt'><%=dt.Rows[i][10]%></td>
  <td class=xl30 width=215 style='border-top:none;border-left:none;width:161pt'><%=dt.Rows[i][11]%></td>
  <td class=xl30 width=215 style='border-top:none;border-left:none;width:161pt'><%=dt.Rows[i][12]%></td>
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=20 style='width:15pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=215 style='width:161pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
