<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
string p_company_pk = ""+Request["company_pk"];
string SQL = " SELECT partner_lname, addr2, tax_code FROM tco_company WHERE pk = " + p_company_pk;

string p_cmp_name = "";
string p_cmp_add = "";
string p_cmp_taxcode = "";

DataTable dt = ESysLib.TableReadOpen(SQL);
	if (dt.Rows.Count >0)
    {
        p_cmp_name = dt.Rows[0][0].ToString();
        p_cmp_add = dt.Rows[0][1].ToString();
        p_cmp_taxcode = dt.Rows[0][2].ToString();
    }
   

    SQL = "SELECT   sf_a_get_accd_ifrs(t.pac_pk, " + p_company_pk + ") uac_cd " +
        "       , LPAD(t.ac_cd, 6 + (ac_level - 1) * 6, CHR(32) || CHR(32) ), t.ac_nm " +
        "       , t.ac_lnm, t.ac_knm, t.ac_level " +
        "       , DECODE(t.ac_type, 'G', 'General Ledger', 'M', 'Manage') ac_type " +
        "       , DECODE(t.drcr_type, 'D', 'Debit', 'Credit') drcr_type " +
        "       , DECODE(t.leaf_yn, 'Y', 'Posting', 'N', 'Summary') " +
        "    FROM tac_abacctcode_ifrs t " +
        "   WHERE t.del_if = 0  AND ac_level > 0 AND tco_company_pk =  " + p_company_pk +
        "ORDER BY t.ac_cd ";


dt = ESysLib.TableReadOpen(SQL);

%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Account%20Code%20List_files/filelist.xml">
<link rel=Edit-Time-Data href="Account%20Code%20List_files/editdata.mso">
<link rel=OLE-Object-Data href="Account%20Code%20List_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:Created>2008-09-17T04:07:31Z</o:Created>
  <o:LastSaved>2008-09-18T04:08:20Z</o:LastSaved>
  <o:Company>vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
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
	font-family:Tahoma;
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
	font-family:Tahoma;
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
	text-align:left;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Account Code List</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>6</x:SplitHorizontal>
     <x:TopRowBottomPane>6</x:TopRowBottomPane>
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
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>11400</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1086 style='border-collapse:
 collapse;table-layout:fixed;width:815pt'>
 <col class=xl25 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl25 width=101 style='mso-width-source:userset;mso-width-alt:3693;
 width:76pt'>
 <col class=xl25 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl25 width=188 span=3 style='mso-width-source:userset;mso-width-alt:
 6875;width:141pt'>
 <col class=xl25 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl25 width=120 style='mso-width-source:userset;mso-width-alt:4388;
 width:90pt'>
 <col class=xl25 width=64 style='width:48pt'>
 <col class=xl25 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=2 width=152 style='height:15.75pt;
  mso-ignore:colspan;width:114pt'><%= p_cmp_name %></td>
  <td class=xl25 width=61 style='width:46pt'></td>
  <td class=xl25 width=188 style='width:141pt'></td>
  <td class=xl25 width=188 style='width:141pt'></td>
  <td class=xl25 width=188 style='width:141pt'></td>
  <td class=xl26 width=51 style='width:38pt'></td>
  <td class=xl26 width=120 style='width:90pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=74 style='width:56pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 colspan=2 style='height:15.75pt;mso-ignore:colspan'><%= p_cmp_add %></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 colspan=2 style='height:15.75pt;mso-ignore:colspan'>M&atilde; s&#7889; thu&#7871;:<%= p_cmp_taxcode %></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=10 height=31 class=xl31 style='height:23.25pt'>ACCOUNT CODE LIST</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=10 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=64 style='mso-height-source:userset;height:48.0pt'>
  <td height=64 class=xl30 width=51 style='height:48.0pt;width:38pt'>No.</td>
  <td class=xl30 width=101 style='border-left:none;width:76pt'>Upper Account
  Code</td>
  <td class=xl30 width=61 style='border-left:none;width:46pt'>Account Code</td>
  <td class=xl30 width=188 style='border-left:none;width:141pt'>Account Name</td>
  <td class=xl30 width=188 style='border-left:none;width:141pt'>Local Account
  Name</td>
  <td class=xl30 width=188 style='border-left:none;width:141pt'>Korean Account
  Name</td>
  <td class=xl30 width=51 style='border-left:none;width:38pt'>Level</td>
  <td class=xl30 width=120 style='border-left:none;width:90pt'>Account Type</td>
  <td class=xl30 width=64 style='border-left:none;width:48pt'>Balance Type</td>
  <td class=xl30 width=74 style='border-left:none;width:56pt'>Posting/ Summary</td>
 </tr>
 <%
	string strColor = "";
	string strBegin="";
	string strEnd="";
	if (dt.Rows.Count >0)
	{
		for(int i=0;i<dt.Rows.Count;i++)
		{ 
			strBegin="";
			strEnd="";
			strColor = "";
			if (dt.Rows[i][5].ToString()=="1") 
			{
				strBegin="<b>";
				strEnd="</b>";
				strColor = "style='background-color:#FFCC99'";
			}
			if (dt.Rows[i][5].ToString()=="2")
			{
				strBegin="<b>";
				strEnd="</b>";
				strColor = "style='background-color:#99CCFF'";
			}
			
			if (i<dt.Rows.Count-1)
			{
		 
%>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl32 <%= strColor %> style='height:15.75pt;border-top:none' x:num> <%= strBegin %> <%= i+1 %> <%= strEnd %></td>
  <td class=xl33  <%= strColor %> style='border-top:none;border-left:none;' ><span><%= strBegin %> <%=dt.Rows[i][0].ToString() %><%= strEnd %></span></td>
  <td class=xl33  <%= strColor %> style='border-top:none;border-left:none;' x:str><%= strBegin %> <%= dt.Rows[i][1].ToString() %><%= strEnd %></td>
  <td class=xl34  <%= strColor %> style='border-top:none;border-left:none;' x:str> 
  <%= strBegin %> <%=dt.Rows[i][2].ToString() %><%= strEnd %></td>
  <td class=xl34  <%= strColor %> style='border-top:none;border-left:none'><%= strBegin %> <%=dt.Rows[i][3].ToString() %><%= strEnd %></td>
  <td class=xl34  <%= strColor %> style='border-top:none;border-left:none'><%= strBegin %>  <%=dt.Rows[i][4].ToString() %><%= strEnd %></td>
  <td class=xl35  <%= strColor %> style='border-top:none;border-left:none' x:num> <%= strBegin %> <%=dt.Rows[i][5].ToString() %><%= strEnd %></td>
  <td class=xl36  <%= strColor %> style='border-top:none;border-left:none'> <%= strBegin %> <%=dt.Rows[i][6].ToString() %><%= strEnd %></td>
  <td class=xl35  <%= strColor %> style='border-top:none;border-left:none'><%= strBegin %> <%=dt.Rows[i][7].ToString() %><%= strEnd %></td>
  <td class=xl35  <%= strColor %> style='border-top:none;border-left:none'><%= strBegin %> <%=dt.Rows[i][8].ToString() %><%= strEnd %></td>
 </tr>
  <%
	}
	else
	{
 %>
  <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl32 <%= strColor %> style='height:15.75pt;border-bottom:.5pt solid windowtext;border-top:.5pt hairline windowtext;' x:num> <%= strBegin %> <%= i+1 %> <%= strEnd %></td>
  <td class=xl33  <%= strColor %> style='border-bottom:.5pt solid windowtext;;border-left:none;border-top:.5pt hairline windowtext;' ><span> <%= strBegin %> <%=dt.Rows[i][0].ToString() %><%= strEnd %></span></td>
  <td class=xl33  <%= strColor %> style='border-bottom:.5pt solid windowtext;;border-left:none;border-top:.5pt hairline windowtext;' x:str><%= strBegin %> <%= dt.Rows[i][1].ToString() %><%= strEnd %></td>
  <td class=xl34  <%= strColor %> style='border-bottom:.5pt solid windowtext;;border-left:none;border-top:.5pt hairline windowtext;' x:str> 
  <%= strBegin %> <%=dt.Rows[i][2].ToString() %><%= strEnd %></td>
  <td class=xl34  <%= strColor %> style='border-bottom:.5pt solid windowtext;;border-left:none;border-top:.5pt hairline windowtext;'><%= strBegin %> <%=dt.Rows[i][3].ToString() %><%= strEnd %></td>
  <td class=xl34  <%= strColor %> style='border-bottom:.5pt solid windowtext;;border-left:none;border-top:.5pt hairline windowtext;'><%= strBegin %>  <%=dt.Rows[i][4].ToString() %><%= strEnd %></td>
  <td class=xl35  <%= strColor %> style='border-bottom:.5pt solid windowtext;;border-left:none;border-top:.5pt hairline windowtext;' x:num> <%= strBegin %> <%=dt.Rows[i][5].ToString() %><%= strEnd %></td>
  <td class=xl36  <%= strColor %> style='border-bottom:.5pt solid windowtext;;border-left:none;border-top:.5pt hairline windowtext;'> <%= strBegin %> <%=dt.Rows[i][6].ToString() %><%= strEnd %></td>
  <td class=xl35  <%= strColor %> style='border-bottom:.5pt solid windowtext;;border-left:none;border-top:.5pt hairline windowtext;'><%= strBegin %> <%=dt.Rows[i][7].ToString() %><%= strEnd %></td>
  <td class=xl35  <%= strColor %> style='border-bottom:.5pt solid windowtext;;border-left:none;border-top:.5pt hairline windowtext;'><%= strBegin %> <%=dt.Rows[i][8].ToString() %><%= strEnd %></td>
 </tr>
 
  <%
		}
		}
	}
 %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=51 style='width:38pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=188 style='width:141pt'></td>
  <td width=188 style='width:141pt'></td>
  <td width=188 style='width:141pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=120 style='width:90pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=74 style='width:56pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
