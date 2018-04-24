<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% Response.ContentType = "application/vnd.ms-excel"; %>
<% ESysLib.SetUser("imex");%>

<%     
    string dtstValue, dtetValue, dtstText, dtetText;
    string cusPk, consp_No, status, validYN, closeYN;

    dtetText = Request.QueryString["dtetText"];
    dtstText = Request.QueryString["dtstText"];
    dtstValue = Request.QueryString["dtstValue"];
    dtetValue = Request.QueryString["dtetValue"];
    cusPk = Request.QueryString["cusPk"];
    consp_No = Request.QueryString["consp_No"];
    status = Request.QueryString["status"];
    validYN = Request.QueryString["validYN"];
    closeYN = Request.QueryString["closeYN"];

    string SQL;
    SQL = "select v.consp_slip_no, v.accept_no, to_char(to_date(v.consp_reg_date,'yyyymmdd'),'dd/mm/yyyy')" + 
        "        , to_char(to_date(v.consp_prps_date,'yyyymmdd'),'dd/mm/yyyy') " +
        "        , v2.full_name, v1.partner_name, to_char(to_date(v.valid_from,'yyyymmdd'),'dd/mm/yyyy') " +
        "        , to_char(to_date(v.valid_to,'yyyymmdd'),'dd/mm/yyyy'), to_char(to_date(v.close_date,'yyyymmdd'),'dd/mm/yyyy'), v.remark " +
        "  from tie_consp_mst v, tco_buspartner v1, hr.thr_employee v2 " +
        "  where  v.del_if=0 and v1.del_if(+)=0 " +
        "       and v.TCO_BUSPARTNER_PK = v1.pk(+) " +
        "       and v.THR_EMP_PK = v2.pk(+) " +
        "       and (v.TCO_BUSPARTNER_PK = '" + cusPk + "' or ' " + cusPk + "' =' ') " +
        "       and v.CONSP_SLIP_NO like '%' || '" + consp_No + "' || '%' " +
        "       and v.CONSP_REG_DATE between '" + dtstValue + "' and '" + dtetValue + "'" +
        "       and (v.status= '" + status + "' or '" + status + "'='0') " +
        "       and CLOSE_YN ='" + closeYN + "'" +
        "       and ((to_char(sysdate,'yyyymmdd') between v.VALID_FROM and nvl(v.VALID_TO,'30000101') and '" + validYN + "'='Y') " +
        "            or (to_char(sysdate,'yyyymmdd') > v.VALID_TO and '" + validYN + "'='N')) " +
        "  order by v.consp_reg_date ";
    DataTable dt = ESysLib.TableReadOpen(SQL);
 %>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_consp_inquiry_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_consp_inquiry_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_consp_inquiry_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>NgaLe</o:Author>
  <o:LastAuthor>NgaLe</o:LastAuthor>
  <o:LastPrinted>2008-09-11T07:42:23Z</o:LastPrinted>
  <o:Created>2008-09-11T03:56:44Z</o:Created>
  <o:LastSaved>2008-09-11T07:43:49Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.51in .38in .51in .37in;
	mso-header-margin:.36in;
	mso-footer-margin:.4in;
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl25
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	text-align:center;}
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
      <x:Scale>84</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
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
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1178 style='border-collapse:
 collapse;table-layout:fixed;width:884pt'>
 <col width=36 style='mso-width-source:userset;mso-width-alt:1316;width:27pt'>
 <col width=112 style='mso-width-source:userset;mso-width-alt:4096;width:84pt'>
 <col width=102 style='mso-width-source:userset;mso-width-alt:3730;width:77pt'>
 <col width=93 style='mso-width-source:userset;mso-width-alt:3401;width:70pt'>
 <col width=127 style='mso-width-source:userset;mso-width-alt:4644;width:95pt'>
 <col width=95 style='mso-width-source:userset;mso-width-alt:3474;width:71pt'>
 <col width=180 style='mso-width-source:userset;mso-width-alt:6582;width:135pt'>
 <col width=82 style='mso-width-source:userset;mso-width-alt:2998;width:62pt'>
 <col width=79 span=2 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col width=98 style='mso-width-source:userset;mso-width-alt:3584;width:74pt'>
 <col width=95 style='mso-width-source:userset;mso-width-alt:3474;width:71pt'>
 <tr height=24 style='height:18.0pt'>
  <td colspan=12 height=24 class=xl32 width=1178 style='height:18.0pt;
  width:884pt'>CONSUMPTION SLIP INQUIRY</td> 
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=12 height=22 class=xl36 style='height:16.5pt'>From:  <%=dtstText%>   To:  <%=dtetText %></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=12 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'>No.</td>
  <td class=xl24 style='border-left:none'>Consumption No.</td>
  <td class=xl24 style='border-left:none'>Accept No.</td>
  <td class=xl24 style='border-left:none'>Register Date</td>
  <td class=xl24 style='border-left:none'>Proposed By</td>
  <td class=xl24 style='border-left:none'>Accept Date</td>
  <td class=xl24 style='border-left:none'>Customs Office</td>
  <td class=xl24 style='border-left:none'>Valid From</td>
  <td class=xl24 style='border-left:none'>Valid To</td>
  <td class=xl24 style='border-left:none'>Close Date</td>
  <td colspan=2 class=xl29>Description</td>
 </tr>
 <%
    for(int i=0 ; i<dt.Rows.Count;i++)
    {
  %>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl25 style='height:15.95pt;border-top:none' x:num><%=i+1 %></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][0] %></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][1] %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none'><%=dt.Rows[i][2] %></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][3] %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none'><%=dt.Rows[i][4] %></td>
  <td class=xl35 width=180 style='border-top:none;border-left:none;width:135pt'><%=dt.Rows[i][5] %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none'><%=dt.Rows[i][6] %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none'><%=dt.Rows[i][7] %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none'><%=dt.Rows[i][8] %></td>
  <td colspan=2 class=xl30 style='border-right:.5pt solid black;border-left:none'><%=dt.Rows[i][9] %></td>
 </tr>
 <%} %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=6 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=6 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=6 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=6 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=36 style='width:27pt'></td>
  <td width=112 style='width:84pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=127 style='width:95pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=95 style='width:71pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
