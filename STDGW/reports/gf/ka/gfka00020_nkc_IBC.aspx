<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string SQL = "";
	SQL = "";	
	string p_compk = "";
	string p_acc_pk = "";
	string p_from_dt = "", p_to_dt = "";
	
	p_compk = Request["company_pk"];
	p_acc_pk = Request["account_pk"];
	p_from_dt = Request["dtbFrom"];
	p_to_dt = Request["dtbTo"];
	string p_status = Request["status"];
	 SQL
	= " select h.voucherno, to_char(h.tr_date, 'DD/MM') tr_date " + 
        "    , h.remark2, c1.ac_cd dr_cd, c2.ac_cd cr_cd, v.pl_cd " +
        "    , d.tr_bookamt, d.tr_amt " +
        "from tac_hgtrd_ref d, tac_abacctcode c1, tac_abacctcode c2 " +
        "    , v_abplcenter v, tac_hgtrh h " +
        "    where d.del_if = 0 " +
        "    and d.tac_hgtrh_pk = h.pk " +
        "    and h.del_if = 0 and h.tr_status like '" + p_status + "'" +
        "    and d.drcr_type = 'D' " +
        "    and d.tac_abacctcode_pk_dr = c1.pk " +
        "    and d.tac_abacctcode_pk_cr = c2.pk " +
		" and d.tac_abacctcode_pk_dr like '" + p_acc_pk + "' " + 
        "    and v.tac_abplcenter_pk = d.tac_abplcenter_pk " +
        "    and h.tr_date between to_date('" + p_from_dt + "', 'YYYYMMDD') and to_date('" + p_to_dt + "', 'YYYYMMDD') " +
        "    and h.tco_company_pk = '" + p_compk + "' order by h.voucherno asc " ;
	DataTable dt =  ESysLib.TableReadOpen(SQL);
	int i;
	
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00020_nkc_IBC_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00020_nkc_IBC_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00020_nkc_IBC_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>GENU</o:Author>
  <o:LastAuthor>GENU</o:LastAuthor>
  <o:Created>2010-04-26T06:14:42Z</o:Created>
  <o:LastSaved>2010-04-26T06:21:10Z</o:LastSaved>
  <o:Company>GENUWIN</o:Company>
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
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"";}
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
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
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
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid black;
	white-space:normal;}
.xl26
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid black;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	border:.5pt solid black;
	white-space:normal;}
.xl28
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;}
.xl30
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid black;
	white-space:normal;}
.xl31
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl32
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	border:.5pt solid black;
	white-space:normal;}
.xl33
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border:.5pt solid black;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	border:.5pt solid black;
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
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>1</x:SplitHorizontal>
     <x:TopRowBottomPane>1</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
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
  <x:WindowHeight>8280</x:WindowHeight>
  <x:WindowWidth>15225</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=790 style='border-collapse:
 collapse;table-layout:fixed;width:593pt'>
 <col width=35 style='mso-width-source:userset;mso-width-alt:1280;width:26pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=43 style='mso-width-source:userset;mso-width-alt:1572;width:32pt'>
 <col width=256 style='mso-width-source:userset;mso-width-alt:9362;width:192pt'>
 <col width=62 span=2 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col class=xl28 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl31 width=124 style='mso-width-source:userset;mso-width-alt:4534;
 width:93pt'>
 <tr height=34 style='height:25.5pt'>
  <td height=34 class=xl25 width=35 style='height:25.5pt;width:26pt'>No.</td>
  <td class=xl25 width=72 style='border-left:none;width:54pt'>Voucher</td>
  <td class=xl25 width=43 style='border-left:none;width:32pt'>Date</td>
  <td class=xl25 width=256 style='border-left:none;width:192pt'>Description</td>
  <td class=xl25 width=62 style='border-left:none;width:47pt'>Debit</td>
  <td class=xl25 width=62 style='border-left:none;width:47pt'>Credit</td>
  <td class=xl25 width=40 style='border-left:none;width:30pt'>Code</td>
  <td class=xl26 width=96 style='border-left:none;width:72pt'
  x:str><span style='mso-spacerun:yes'> </span>Amount (USD)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl30 width=124 style='border-left:none;width:93pt'
  x:str><span style='mso-spacerun:yes'> </span>Amount (VND)<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <%
	for(i = 0; i < dt.Rows.Count; i++)
	{
 %>
 
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 align=right width=35 style='height:12.75pt;
  border-top:none;width:26pt' x:num><%=i+1%></td>
  <td class=xl27 align=left width=72 style='border-top:none;border-left:none;
  width:54pt'>&nbsp;<%=dt.Rows[i][0]%></td>
  <td class=xl27 align=left width=43 style='border-top:none;border-left:none;
  width:32pt'>&nbsp;<%=dt.Rows[i][1]%></td>
  <td class=xl27 align=left width=256 style='border-top:none;border-left:none;
  width:192pt'>&nbsp;<%=dt.Rows[i][2]%></td>
  <td class=xl34 width=62 style='border-top:none;border-left:none;width:47pt'>&nbsp;<%=dt.Rows[i][3]%></td>
  <td class=xl34 width=62 style='border-top:none;border-left:none;width:47pt'>&nbsp;<%=dt.Rows[i][4]%></td>
  <td class=xl27 align=left width=40 style='border-top:none;border-left:none;
  width:30pt'>&nbsp;<%=dt.Rows[i][5]%></td>
  <td class=xl33 width=96 style='border-top:none;border-left:none;width:72pt'
  x:num><span style='mso-spacerun:yes'>      
  </span><%=dt.Rows[i][6]%> </td>
  <td class=xl32 width=124 style='border-top:none;border-left:none;width:93pt'
  x:num><span style='mso-spacerun:yes'>       
  </span><%=dt.Rows[i][7]%> </td>
 </tr>
 <%
	}
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=7 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td class=xl31></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl29 colspan=3 align=left style='height:15.75pt;
  mso-ignore:colspan'>Month <%=p_from_dt.Substring(4, 2)%>/<%=p_from_dt.Substring(0, 4)%></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td class=xl31></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=35 style='width:26pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=256 style='width:192pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=124 style='width:93pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
