<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("acnt");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string l_company_pk = Request["l_company"];
    string l_book_ccy =   Request["bookccy"];
    string l_taxcode = "";
    string l_compa = ""; 
    string l_address = "";
    //-----------------------------------------------------------------------------------------------
    string SQL1 = " SELECT PARTNER_NAME,ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + l_company_pk + "' ";

    
    DataTable dt_f = ESysLib.TableReadOpen(SQL1);
    
    if (dt_f.Rows.Count > 0)
    {
        l_compa = dt_f.Rows[0][0].ToString();
        l_address = dt_f.Rows[0][1].ToString();
        l_taxcode = dt_f.Rows[0][3].ToString();
    }
//----------------------------------------------------------------------------------------------------------------
     string l_tac_allexpd_pk = Request["p_tac_allexpd_pk"];

     DataTable dt = ESysLib.TableReadOpenCursor("sp_sel_agga00120_report", l_tac_allexpd_pk);
    //Response.Write(dt.Rows.Count.ToString());
    //Response.End();
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }

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
<link rel=File-List href="aaa_files/filelist.xml">
<link rel=Edit-Time-Data href="aaa_files/editdata.mso">
<link rel=OLE-Object-Data href="aaa_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>tam</o:Author>
  <o:LastAuthor>Mr Long</o:LastAuthor>
  <o:LastPrinted>2010-01-05T07:43:30Z</o:LastPrinted>
  <o:Created>2006-06-28T09:24:54Z</o:Created>
  <o:LastSaved>2010-01-05T07:59:24Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.5in 0in .5in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
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
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>So cai NKC (Mau so S03b-DN)</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>75</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>85</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>7</x:SplitHorizontal>
     <x:TopRowBottomPane>7</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>18</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8490</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>2325</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1297 style='border-collapse:
 collapse;table-layout:fixed;width:974pt'>
 <col class=xl25 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <col class=xl25 width=186 style='mso-width-source:userset;mso-width-alt:6802;
 width:140pt'>
 <col class=xl25 width=250 style='mso-width-source:userset;mso-width-alt:9142;
 width:188pt'>
 <col class=xl25 width=207 style='mso-width-source:userset;mso-width-alt:7570;
 width:155pt'>
 <col class=xl25 width=156 style='mso-width-source:userset;mso-width-alt:5705;
 width:117pt'>
 <col class=xl25 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl25 width=151 style='mso-width-source:userset;mso-width-alt:5522;
 width:113pt'>
 <col class=xl25 width=95 style='mso-width-source:userset;mso-width-alt:3474;
 width:71pt'>
 <col class=xl25 width=97 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=3 height=19 class=xl38 width=510 style='height:14.25pt;
  width:384pt'><%=l_compa %></td>
  <td class=xl24 width=207 style='width:155pt'></td>
  <td class=xl25 width=156 style='width:117pt'></td>
  <td class=xl32 width=81 style='width:61pt'></td>
  <td colspan=3 class=xl29 width=343 style='width:257pt'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=3 height=19 class=xl39 width=510 style='height:14.25pt;
  width:384pt'><%=l_address %></td>
  <td class=xl26></td>
  <td class=xl25></td>
  <td class=xl28></td>
  <td colspan=3 class=xl36></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl38 style='height:15.75pt'>Mã số thuế: <%=l_taxcode %></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl28></td>
  <td colspan=3 class=xl36></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=9 height=30 class=xl37 style='height:22.5pt'>DANH MỤC CHI PHÍ</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=9 height=26 class=xl36 style='height:19.5pt'></td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl28 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl30></td>
 </tr>
 <tr class=xl29 height=21 style='height:15.75pt'>
  <td height=21 class=xl44 width=74 style='height:15.75pt;width:56pt'>Tháng</td>
  <td class=xl45 style='border-left:none'>Mã TK</td>
  <td class=xl45 style='border-left:none'>Tên TK</td>
  <td class=xl45 style='border-left:none'>Dự Án</td>
  <td class=xl44 width=156 style='border-left:none;width:117pt'>Số Tiền</td>
  <td class=xl44 width=81 style='border-left:none;width:61pt'>Tỷ Lệ(%)</td>
  <td class=xl45 style='border-left:none' >Số Tiền<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl45 style='border-left:none'>Số Lượng</td>
  <td class=xl45 style='border-left:none'>Thời Gian</td>
 </tr>
 <%
        for(int i = 0;i<dt.Rows.Count;i++)
        {    
 %>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 class=xl40 style='height:15.75pt' ><%=dt.Rows[i][3] %></td>
  <td class=xl41 style='border-left:none'><%=dt.Rows[i][4] %></td>
  <td class=xl42 width=250 style='border-left:none;width:188pt'><%=dt.Rows[i][5] %></td>
  <td class=xl42 width=207 style='border-left:none;width:155pt'><%=dt.Rows[i][6] %></td>
  <td class=xl34  style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'></span><%=dt.Rows[i][7] %></td>
  <td class=xl33 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt.Rows[i][8] %></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'></span><%=dt.Rows[i][9] %> </td>
  <td class=xl43 style='border-left:none' ><span  style='mso-spacerun:yes'></span><%=dt.Rows[i][10] %></td>
  <td class=xl35 x:num><%=dt.Rows[i][11] %></td>
 </tr>
 <%} %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=9 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 colspan=9 class=xl27 style='height:24.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=9 class=xl27 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 colspan=6 class=xl28 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl36></td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'></td>
  <td class=xl29></td>
  <td class=xl28></td>
  <td class=xl29></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl29></td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'></td>
  <td class=xl31></td>
  <td class=xl28></td>
  <td class=xl31></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl31></td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl28 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl28 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=74 style='width:56pt'></td>
  <td width=186 style='width:140pt'></td>
  <td width=250 style='width:188pt'></td>
  <td width=207 style='width:155pt'></td>
  <td width=156 style='width:117pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=151 style='width:113pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=97 style='width:73pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
