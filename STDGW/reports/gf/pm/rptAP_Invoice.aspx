<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string inv_pk = "";
	inv_pk = Request["inv_pk"].ToString();
	
	string sqlMaster = " SELECT TO_CHAR(A.INVOICE_DATE,'DD/MM/YYYY'), A.INVOICE_NUM "
						+ "    ,TO_CHAR(A.INVOICE_AMOUNT,'999,999,999,999,999,999') "
						+ " , (SELECT NVL(SUM(B.AMOUNT ),0) "
						+ " FROM PEAI.AP_INVOICE_LINES_INTERFACE B "
						+ " WHERE B.AP_INVOICES_INTERFACE_PK= " + inv_pk + " AND UPPER(B.UPLOAD_STATUS)<>'D') "
						+ " FROM PEAI.AP_INVOICES_INTERFACE A  "
						+ " WHERE A.PK = " + inv_pk + " AND UPPER(A.UPLOAD_STATUS)<>'D' "
						+" ";

	string sqlDetail = " SELECT ROWNUM, A.DESCRIPTION "
						+ "    , SUBSTR(A.DIST_CODE_CONCATENATED,1,20) DR_ACCT "
						+ "    , '97-00000-210301-0000' AS CR_ACCT "
						+ "    , A.AMOUNT "
						+ "FROM PEAI.AP_INVOICE_LINES_INTERFACE A  "
						+ "WHERE A.AP_INVOICES_INTERFACE_PK = " + inv_pk + " AND UPPER(A.UPLOAD_STATUS)<>'D'  "
						+ " ";

	//Response.Write(SQL);
    //Response.End();
    DataTable dt_Master = ESysLib.TableReadOpen(sqlMaster);
    if (dt_Master.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
	
	DataTable dt_Detail = ESysLib.TableReadOpen(sqlDetail);
    int detail_row, detail_col;
    detail_row = dt_Detail.Rows.Count;
    detail_col = dt_Detail.Columns.Count;
    if (detail_row == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
	
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rptAP_Invoice_files/filelist.xml">
<link rel=Edit-Time-Data href="rptAP_Invoice_files/editdata.mso">
<link rel=OLE-Object-Data href="rptAP_Invoice_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Phan Huy Quoc My</o:Author>
  <o:LastAuthor>Phan Huy Quoc My</o:LastAuthor>
  <o:LastPrinted>2009-10-27T02:09:52Z</o:LastPrinted>
  <o:Created>2009-10-27T01:44:31Z</o:Created>
  <o:LastSaved>2009-10-27T02:45:43Z</o:LastSaved>
  <o:Company>QMC Group</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.44in .22in .44in .21in;
	mso-header-margin:.43in;
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
	vertical-align:middle;
	white-space:normal;}
.xl25
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}	
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>91</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
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
  <x:WindowHeight>9855</x:WindowHeight>
  <x:WindowWidth>15180</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=779 style='border-collapse:
 collapse;table-layout:fixed;width:585pt'>
 <col class=xl25 width=52 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col class=xl24 width=292 style='mso-width-source:userset;mso-width-alt:10678;
 width:219pt'>
 <col class=xl25 width=145 span=2 style='mso-width-source:userset;mso-width-alt:
 5302;width:109pt'>
 <col class=xl26 width=145 style='mso-width-source:userset;mso-width-alt:5302;
 width:109pt'>
 <col class=xl24 width=145 span=251 style='mso-width-source:userset;mso-width-alt:
 5302;width:109pt'>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl34 width=344 style='height:18.75pt;
  width:258pt'>CÔNG TY TNHH POSCO - VIỆT NAM</td>
  <td class=xl25 width=145 style='width:109pt'></td>
  <td colspan=2 class=xl36 width=290 style='width:218pt'>Số/Invoice No :</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl34 width=344 style='height:18.75pt;
  width:258pt'>Lô 1, KCN Phú Mỹ II, Tân Thành BR-VT</td>
  <td class=xl25></td>
  <td colspan=2 class=xl37 width=290 style='width:218pt'><%=dt_Master.Rows[0][1].ToString()%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl27 width=145 style='width:109pt'>Ngày/Date :</td>
  <td class=xl28 width=145 style='width:109pt' ><span
  style='mso-spacerun:yes'> </span><%=dt_Master.Rows[0][0].ToString()%><span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl27></td>
  <td class=xl28></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td class=xl24></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=5 height=38 class=xl35 width=779 style='height:28.5pt;width:585pt'>CHỨNG
  TỪ GHI SỔ / VOUCHER</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td class=xl24></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl32 width=52 style='height:21.75pt;width:39pt'>No</td>
  <td class=xl32 width=292 style='border-left:none;width:219pt'>Nội
  Dung/Description</td>
  <td class=xl32 width=145 style='border-left:none;width:109pt'>Nợ/Dr Acct</td>
  <td class=xl32 width=145 style='border-left:none;width:109pt'>Có/Cr Acct</td>
  <td class=xl33 width=145 style='border-left:none;width:109pt'
  x:str="T.Tiền/Amt in VND"><span style='mso-spacerun:yes'> </span>T.Tiền/Amt in VND<span style='mso-spacerun:yes'> </span></td>
 </tr>
<% 
    
	for (int i = 0; i < detail_row; i++) 
    {
%>
 <tr height=59 style='mso-height-source:userset;height:44.25pt'>
  <td height=59 class=xl29 width=52 style='height:44.25pt;border-top:none;
  width:39pt' x:num><%=dt_Detail.Rows[i][0].ToString()%></td>
  <td class=xl30 width=292 style='border-top:none;border-left:none;width:219pt'><%=dt_Detail.Rows[i][1].ToString()%></td>
  <td class=xl29 width=145 style='border-top:none;border-left:none;width:109pt'><%=dt_Detail.Rows[i][2].ToString()%></td>
  <td class=xl29 width=145 style='border-top:none;border-left:none;width:109pt'><%=dt_Detail.Rows[i][3].ToString()%></td>
  <td class=xl31 width=145 style='border-top:none;border-left:none;width:109pt'
  x:num><span style='mso-spacerun:yes'></span><%=dt_Detail.Rows[i][4].ToString()%></td>
 </tr>
<%
	}
%>
<tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=4 height=29 class=xl38 width=634 style='border-right:.5pt solid black;
  height:21.75pt;width:476pt'>TỔNG/TOTAL</td>
  <td class=xl33 width=145 style='border-top:none;border-left:none;width:109pt'
  x:num><span style='mso-spacerun:yes'>                       
  </span><%=dt_Master.Rows[0][3].ToString()%></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=52 style='width:39pt'></td>
  <td width=292 style='width:219pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
