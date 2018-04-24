<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string l_company_pk = "" +Request["company_pk"];
	
	string p_cmp_name = "";
	string p_cmp_add = "";	
	string p_cmp_taxcode = "";
	int i =0;
    string SQL = " SELECT partner_name, addr1, tax_code  FROM tco_company WHERE pk = '" + l_company_pk + "' ";
    DataTable dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count >0)
    {
        p_cmp_name = dt.Rows[0][0].ToString();
        p_cmp_add = dt.Rows[0][1].ToString();
        p_cmp_taxcode = dt.Rows[0][2].ToString();
    }
    
   SQL = "SELECT " +
            " (select b.pl_cd from tac_abpl b where b.pk = m.p_pk) uplcd, " +
            " (select b.pl_nm from tac_abpl b where b.pk = m.p_pk) uplnm, " +
            "  M.PL_CD, M.PL_NM, M.PL_LNM, M.PL_FNM, DECODE(M.USE_YN,'Y','Yes','No') Active " +
            " FROM TAC_ABPL M " +
            " WHERE M.DEL_IF =0 " +
            "  AND DECODE ('" + l_company_pk + "' , 'ALL', '" + l_company_pk + "' , M.TCO_COMPANY_PK) = '" + l_company_pk + "'  " +
            " connect by prior M.pk = M.p_pk " +
            " start with M.p_pk = 0 ";
	DataTable dt_detail = ESysLib.TableReadOpen(SQL);
	%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="agga00030_CostCenter_List_files/filelist.xml">
<link rel=Edit-Time-Data href="agga00030_CostCenter_List_files/editdata.mso">
<link rel=OLE-Object-Data href="agga00030_CostCenter_List_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>genuwin</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2009-04-01T03:18:00Z</o:LastPrinted>
  <o:Created>2009-04-01T03:04:43Z</o:Created>
  <o:LastSaved>2009-04-01T03:27:22Z</o:LastSaved>
  <o:Company>company</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.5in .25in .25in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
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
	padding:0px;
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
	mso-number-format:0%;
	text-align:left;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
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
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:16.0pt;
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
    <x:Name>Cost Center List</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>6</x:SplitHorizontal>
     <x:TopRowBottomPane>6</x:TopRowBottomPane>
     <x:SplitVertical>4</x:SplitVertical>
     <x:LeftColumnRightPane>4</x:LeftColumnRightPane>
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
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>17</x:ActiveRow>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Cost Center List'!$A$6:$H$6</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1127 style='border-collapse:
 collapse;table-layout:fixed;width:845pt'>
 <col class=xl25 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl25 width=155 style='mso-width-source:userset;mso-width-alt:5668;
 width:116pt'>
 <col class=xl25 width=189 style='mso-width-source:userset;mso-width-alt:6912;
 width:142pt'>
 <col class=xl25 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col class=xl25 width=187 span=3 style='mso-width-source:userset;mso-width-alt:
 6838;width:140pt'>
 <col class=xl25 width=64 style='width:48pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=2 width=199 style='height:15.75pt;
  mso-ignore:colspan;width:149pt'><%=p_cmp_name %></td>
  <td class=xl25 width=189 style='width:142pt'></td>
  <td class=xl25 width=114 style='width:86pt'></td>
  <td class=xl25 width=187 style='width:140pt'></td>
  <td class=xl25 width=187 style='width:140pt'></td>
  <td class=xl25 width=187 style='width:140pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 colspan=3 style='height:15.75pt;mso-ignore:colspan'><%= p_cmp_add %></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Mã
  s&#7889; thu&#7871; : <%= p_cmp_taxcode %></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=8 height=27 class=xl33 style='height:20.25pt'>COST CENTER LIST</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 class=xl29 id="_x0000_s1025" x:autofilter="all"
  x:autofilterrange="$A$6:$H$6" style='height:15.75pt'>No</td>
  <td class=xl29 id="_x0000_s1026" x:autofilter="all" style='border-left:none'>Upper
  Cost Center Code</td>
  <td class=xl29 id="_x0000_s1027" x:autofilter="all" style='border-left:none'>Upper
  Cost Center Name</td>
  <td class=xl29 id="_x0000_s1028" x:autofilter="all" style='border-left:none'>Cost
  Center Code</td>
  <td class=xl29 id="_x0000_s1029" x:autofilter="all" style='border-left:none'>Cost
  Center Name</td>
  <td class=xl29 id="_x0000_s1030" x:autofilter="all" style='border-left:none'>Cost
  Center L.Name</td>
  <td class=xl29 id="_x0000_s1031" x:autofilter="all" style='border-left:none'>Cost
  Center K.Name</td>
  <td class=xl26 id="_x0000_s1032" x:autofilter="all" style='border-left:none'>Active</td>
 </tr>
<%
if (dt_detail.Rows.Count >0)
	{
		for(i=0;i<dt_detail.Rows.Count;i++)
		{
 %> 
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl30 style='height:15.75pt;border-top:none' x:num><%=  (i+1) %></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt_detail.Rows[i][0].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt_detail.Rows[i][1].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt_detail.Rows[i][2].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt_detail.Rows[i][3].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt_detail.Rows[i][4].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt_detail.Rows[i][5].ToString() %></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt_detail.Rows[i][6].ToString() %></td>
 </tr>
 <%
        }
    }
  %>

 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=7 class=xl32 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=44 style='width:33pt'></td>
  <td width=155 style='width:116pt'></td>
  <td width=189 style='width:142pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=187 style='width:140pt'></td>
  <td width=187 style='width:140pt'></td>
  <td width=187 style='width:140pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
