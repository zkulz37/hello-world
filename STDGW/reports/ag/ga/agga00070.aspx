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
	string SQL
	= "select c.partner_id, c.partner_lname, b.bedefi_nm, b.bedefi_bank_nm, b.branch, b.account_no, b.ccy,b.REMARK, c.TAX_CODE " + 
        "from tac_bfbeneficiary b, tco_buspartner c " +
        "where b.tco_dccust_pk = c.pk(+) " +
        "and b.del_if = 0 " +
        "order by c.partner_id " ;
	DataTable dt = ESysLib.TableReadOpen(SQL);
	int i;
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Benificiary%20Bank%20List_files/filelist.xml">
<link rel=Edit-Time-Data href="Benificiary%20Bank%20List_files/editdata.mso">
<link rel=OLE-Object-Data href="Benificiary%20Bank%20List_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>kiet</o:Author>
  <o:LastAuthor>GENU</o:LastAuthor>
  <o:Created>2007-10-08T06:03:10Z</o:Created>
  <o:LastSaved>2010-05-15T06:14:06Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
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
	font-family:"Times New Roman";
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
	font-family:"Times New Roman";
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
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl25
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	mso-number-format:"\@";
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	mso-number-format:"\@";
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	mso-number-format:"\@";
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
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
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>3</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>4</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8550</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1065 style='border-collapse:
 collapse;table-layout:fixed;width:800pt'>
 <col width=56 style='width:42pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:3029;width:53pt'>
 <col width=196 style='mso-width-source:userset;mso-width-alt:8362;width:147pt'>
 <col width=129 style='mso-width-source:userset;mso-width-alt:5504;width:97pt'>
 <col width=154 style='mso-width-source:userset;mso-width-alt:6570;width:116pt'>
 <col width=77 style='mso-width-source:userset;mso-width-alt:3285;width:58pt'>
 <col width=121 style='mso-width-source:userset;mso-width-alt:5162;width:91pt'>
 <col width=56 style='width:42pt'>
 <col width=205 style='mso-width-source:userset;mso-width-alt:8746;width:154pt'>
 <tr height=25 style='height:18.75pt'>
  <td colspan=3 height=25 class=xl32 width=323 style='height:18.75pt;
  width:242pt'>Beneficiary Bank List</td>
  <td width=129 style='width:97pt'></td>
  <td width=154 style='width:116pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=205 style='width:154pt'></td>
 </tr>
 <tr height=34 style='height:25.5pt;mso-xlrowspan:2'>
  <td height=34 colspan=9 style='height:25.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td rowspan=2 height=38 class=xl33 style='border-bottom:.5pt solid black;
  height:28.5pt'>No</td>
  <td colspan=2 class=xl35 style='border-right:.5pt solid black;border-left:
  none'>Customer</td>
  <td rowspan=2 class=xl33 style='border-bottom:.5pt solid black'>Beneficiary
  Name</td>
  <td rowspan=2 class=xl33 style='border-bottom:.5pt solid black'>Beneficiary's
  bank</td>
  <td rowspan=2 class=xl33 style='border-bottom:.5pt solid black'>Branch</td>
  <td rowspan=2 class=xl33 style='border-bottom:.5pt solid black'>Account No.</td>
  <td rowspan=2 class=xl33 style='border-bottom:.5pt solid black'>Unit</td>
  <td rowspan=2 class=xl33 style='border-bottom:.5pt solid black'>Remark</td>
  <td rowspan=2 class=xl33 style='border-bottom:.5pt solid black'>Tax code</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl24 style='height:14.25pt'>Code</td>
  <td class=xl24>Name</td>
 </tr>
 <%
	for( i = 0; i < dt.Rows.Count; i++)
	{
		if(i < dt.Rows.Count - 1)
		{
 %>
 <tr height=34 style='height:25.5pt'>
  <td height=34 class=xl25 align=right style='height:25.5pt' x:num><%=i+1%></td>
  <td class=xl26><%=dt.Rows[i][0]%></td>
  <td class=xl31 width=196 style='width:147pt'><%=dt.Rows[i][1]%></td>
  <td class=xl26><%=dt.Rows[i][2]%></td>
  <td class=xl26><%=dt.Rows[i][3]%></td>
  <td class=xl26><%=dt.Rows[i][4]%></td>
  <td class=xl26><%=dt.Rows[i][5]%></td>
  <td class=xl26><%=dt.Rows[i][6]%></td>
  <td class=xl27><%=dt.Rows[i][7]%></td>
  <td class=xl27><%=dt.Rows[i][8]%></td>
 </tr>
<%
		}
		else
		{
%>	
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 align=right style='height:12.75pt' x:num><%=i+1%></td>
  <td class=xl29><%=dt.Rows[i][0]%></td>
  <td class=xl29><%=dt.Rows[i][1]%></td>
  <td class=xl29><%=dt.Rows[i][2]%></td>
  <td class=xl29><%=dt.Rows[i][3]%></td>
  <td class=xl29><%=dt.Rows[i][4]%></td>
  <td class=xl29><%=dt.Rows[i][5]%></td>
  <td class=xl29><%=dt.Rows[i][6]%></td>
  <td class=xl30><%=dt.Rows[i][7]%></td>
  <td class=xl30><%=dt.Rows[i][8]%></td>
 
 </tr>
 <%
		}
	}
 %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=56 style='width:42pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=196 style='width:147pt'></td>
  <td width=129 style='width:97pt'></td>
  <td width=154 style='width:116pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=205 style='width:154pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
