<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%Response.ContentType = "application/vnd.ms-excel"; %>
<% ESysLib.SetUser("crm");%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
    string p_tht_shift_close_pk = Request.QueryString["tht_shift_close_pk"];
        
    DataTable dt01 = ESysLib.TableReadOpenCursor("crm.sp_rpt_htfo00120",  p_tht_shift_close_pk );    
    
    DataTable dt = ESysLib.TableReadOpenCursor("crm.sp_rpt_htfo00120_1", p_tht_shift_close_pk );        
    
    string l_open_usd = "", l_open_vnd = "", l_receive_usd = "", l_receive_vnd = "", l_paid_usd = "", l_paid_vnd = "";
    string l_adjust_usd = "", l_adjust_vnd = "", l_bal_usd = "", l_bal_vnd = "", l_drop_usd = "", l_drop_vnd = "";
    string l_credit_usd = "", l_credit_vnd = "", l_ledger_usd = "", l_ledger_vnd = "";
    
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    } 
    else
    {
        l_open_usd = dt.Rows[0]["cash_open_usd"].ToString();
        l_open_vnd = dt.Rows[0]["cash_open_vnd"].ToString();
        
        l_receive_usd = dt.Rows[0]["cash_receive_usd"].ToString();
        l_receive_vnd = dt.Rows[0]["cash_receive_vnd"].ToString();
        
        l_paid_usd = dt.Rows[0]["cash_paid_usd"].ToString();
        l_paid_vnd = dt.Rows[0]["cash_paid_vnd"].ToString();
        
        l_adjust_usd = dt.Rows[0]["cash_adjust_usd"].ToString();
        l_adjust_vnd = dt.Rows[0]["cash_adjust_vnd"].ToString();  
        
        l_bal_usd = dt.Rows[0]["cash_bal_usd"].ToString();
        l_bal_vnd = dt.Rows[0]["cash_bal_vnd"].ToString(); 
        
        l_drop_usd = dt.Rows[0]["cash_drop_usd"].ToString();
        l_drop_vnd = dt.Rows[0]["cash_drop_vnd"].ToString(); 

        l_credit_usd = dt.Rows[0]["cash_drop_usd"].ToString();
        l_credit_vnd = dt.Rows[0]["cash_drop_vnd"].ToString(); 

        l_ledger_usd = dt.Rows[0]["cash_drop_usd"].ToString();
        l_ledger_vnd = dt.Rows[0]["cash_drop_vnd"].ToString();                       
    }   
 %>
 
<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_htfo00120_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_htfo00120_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_htfo00120_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>VINAGENUWIN</o:Author>
  <o:LastAuthor>VINAGENUWIN</o:LastAuthor>
  <o:LastPrinted>2010-12-18T03:25:35Z</o:LastPrinted>
  <o:Created>2010-12-18T02:36:11Z</o:Created>
  <o:LastSaved>2010-12-18T03:26:09Z</o:LastSaved>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .38in 1.0in .41in;
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
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:20.0pt;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
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
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>7</x:ActiveRow>
       <x:ActiveCol>12</x:ActiveCol>
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

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=694 style='border-collapse:
 collapse;table-layout:fixed;width:524pt'>
 <col width=90 span=7 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col width=64 style='width:48pt'>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=7 height=40 class=xl25 width=630 style='height:30.0pt;width:476pt'>SONG
  GIA Golf Resort</td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=80 style='mso-height-source:userset;height:60.0pt'>
  <td colspan=7 height=80 class=xl26 style='height:60.0pt'>Cashier Cloure</td>
  <td class=xl24></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl27 style='height:18.75pt' >Date
  : <%=dt01.Rows[0]["close_date"].ToString()%></td>
  <td colspan=2 class=xl27 >Shift : <%=dt01.Rows[0]["shift"].ToString()%><span
  style='mso-spacerun:yes'></span></td>
  <td colspan=3 class=xl27 >Crt Dt / By : <%=dt01.Rows[0]["crt_dt_by"].ToString()%><span
  style='mso-spacerun:yes'></span></td>
  <td></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=3 height=30 class=xl28 style='border-right:.5pt solid black;
  height:22.5pt'>&nbsp;</td>
  <td colspan=2 class=xl31 style='border-right:.5pt solid black;border-left:
  none'>USD</td>
  <td colspan=2 class=xl31 style='border-right:.5pt solid black;border-left:
  none'>VND</td>
  <td></td>
 </tr>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td colspan=3 height=45 class=xl33 style='border-right:.5pt solid black;
  height:33.75pt'>Open</td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none' x:num=""><%=l_open_usd%></td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none' x:num=""><%=l_open_vnd%></td>
  <td></td>
 </tr>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td colspan=3 height=45 class=xl33 style='border-right:.5pt solid black;
  height:33.75pt'>Receive</td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none' x:num=""><%=l_receive_usd%></td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none' x:num=""><%=l_receive_vnd%></td>
  <td></td>
 </tr>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td colspan=3 height=45 class=xl33 style='border-right:.5pt solid black;
  height:33.75pt'>Paid Out</td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none' x:num=""><%=l_paid_usd%></td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none' x:num=""><%=l_paid_vnd%></td>
  <td></td>
 </tr>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td colspan=3 height=45 class=xl33 style='border-right:.5pt solid black;
  height:33.75pt'>Adjust</td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none' x:num=""><%=l_adjust_usd%></td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none' x:num=""><%=l_adjust_vnd%></td>
  <td></td>
 </tr>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td colspan=3 height=45 class=xl38 style='border-right:.5pt solid black;
  height:33.75pt'>Balance</td>
  <td colspan=2 class=xl41 style='border-right:.5pt solid black;border-left:
  none' x:num=""><%=l_bal_usd %></td>
  <td colspan=2 class=xl41 style='border-right:.5pt solid black;border-left:
  none' x:num=""><%=l_bal_vnd %></td>
  <td></td>
 </tr>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td colspan=3 height=45 class=xl33 style='border-right:.5pt solid black;
  height:33.75pt'>Drop</td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none' x:num=""><%=l_drop_usd %></td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none' x:num=""><%=l_drop_vnd %></td>
  <td></td>
 </tr>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td colspan=3 height=45 class=xl33 style='border-right:.5pt solid black;
  height:33.75pt'>Credit</td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none' x:num=""><%=l_credit_usd%></td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none' x:num=""><%=l_credit_vnd%></td>
  <td></td>
 </tr>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td colspan=3 height=45 class=xl33 style='border-right:.5pt solid black;
  height:33.75pt'>City Ledger</td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none' x:num=""><%=l_ledger_usd%></td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none' x:num=""><%=l_ledger_vnd%></td>
  <td></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
