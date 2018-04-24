<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("acnt");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%

    string l_com_pk = Request["p_com_pk"];
    string l_accd = Request["p_accd"];

    string l_parameter = "'" + l_com_pk + "','" + l_accd + "'";
    //Response.Write(l_parameter);
    //Response.End();
    DataTable dt = ESysLib.TableReadOpenCursor("ACNT.sp_sel_gfnt00060", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    string l_company = "", l_address = "";
    string SQL1 = " SELECT  PARTNER_NAME,addr1 FROM TCO_COMPANY WHERE DEL_IF=0 and pk ='" + l_com_pk + "'";
    DataTable dt_f = ESysLib.TableReadOpen(SQL1);
    if (dt_f.Rows.Count > 0)
    {
        l_company = dt_f.Rows[0][0].ToString();
        l_address = dt_f.Rows[0][1].ToString();
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="bgbg_files/filelist.xml">
<link rel=Edit-Time-Data href="bgbg_files/editdata.mso">
<link rel=OLE-Object-Data href="bgbg_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>PCVINA002</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2009-12-10T07:52:26Z</o:LastPrinted>
  <o:Created>2009-12-09T08:55:38Z</o:Created>
  <o:LastSaved>2009-12-10T08:36:18Z</o:LastSaved>
  <o:Company>VINA</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.49in 0in .25in 0in;
	mso-header-margin:.25in;
	mso-footer-margin:.5in;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	text-align:left;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl26
	{mso-style-parent:style0;
	text-align:left;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl27
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	text-align:left;}
.xl29
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl30
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
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
      <x:Scale>78</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>6</x:SplitHorizontal>
     <x:TopRowBottomPane>6</x:TopRowBottomPane>
     <x:SplitVertical>6</x:SplitVertical>
     <x:LeftColumnRightPane>6</x:LeftColumnRightPane>
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
       <x:ActiveRow>6</x:ActiveRow>
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
  <x:WindowHeight>8355</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1980</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$A$6:$Q$6</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1045"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1223 style='border-collapse:
 collapse;table-layout:fixed;width:918pt'>
 <col width=120 style='mso-width-source:userset;mso-width-alt:4388;width:90pt'>
 <col width=95 style='mso-width-source:userset;mso-width-alt:3474;width:71pt'>
 <col width=118 style='mso-width-source:userset;mso-width-alt:4315;width:89pt'>
 <col width=92 style='mso-width-source:userset;mso-width-alt:3364;width:69pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:1938'>
 <col width=104 style='mso-width-source:userset;mso-width-alt:3803;width:78pt'>
 <col width=64 span=5 style='width:48pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=135 style='mso-width-source:userset;mso-width-alt:4937;width:101pt'>
 <col width=38 style='mso-width-source:userset;mso-width-alt:1389;width:29pt'>
 <col width=48 style='mso-width-source:userset;mso-width-alt:1755;width:36pt'>
 <col width=28 style='mso-width-source:userset;mso-width-alt:1024;width:21pt'>
 <col width=34 style='mso-width-source:userset;mso-width-alt:1243;width:26pt'>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl28 width=333 style='height:12.75pt;
  width:250pt'><%=l_company %></td>
  <td width=92 style='width:69pt'></td>
  <td width=0></td>
  <td width=104 style='width:78pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=135 style='width:101pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=34 style='width:26pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl28 style='height:12.75pt'><%=l_address %></td>
  <td colspan=14 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=17 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=17 rowspan=2 height=34 class=xl29 style='height:25.5pt'>Account<span
  style='mso-spacerun:yes'>  </span>Code<span style='mso-spacerun:yes'> 
  </span>Inquiry</td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr class=xl24 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl32 id="_x0000_s1025" x:autofilter="all"
  x:autofilterrange="$A$6:$Q$6" width=120 style='height:21.75pt;width:90pt'>Upper
  Acc</td>
  <td class=xl33 id="_x0000_s1026" x:autofilter="all" style='border-left:none'>Ac.Code</td>
  <td class=xl33 id="_x0000_s1028" x:autofilter="all" style='border-left:none'>Account
  Name</td>
  <td colspan=2 class=xl33 id="_x0000_s1031" x:autofilter="all"
  style='border-left:none'>Standard Code</td>
  <td class=xl33 id="_x0000_s1033" x:autofilter="all" style='border-left:none'>Standard<span
  style='mso-spacerun:yes'>  </span>Name</td>
  <td class=xl33 id="_x0000_s1034" x:autofilter="all" style='border-left:none'>Sub
  Code</td>
  <td class=xl33 id="_x0000_s1035" x:autofilter="all" style='border-left:none'>Sub<span
  style='mso-spacerun:yes'>  </span>Name</td>
  <td class=xl33 id="_x0000_s1036" x:autofilter="all" style='border-left:none'>Local
  Code</td>
  <td class=xl33 id="_x0000_s1037" x:autofilter="all" style='border-left:none'>Local<span
  style='mso-spacerun:yes'>  </span>Name</td>
  <td class=xl33 id="_x0000_s1038" x:autofilter="all" style='border-left:none'>Short<span
  style='mso-spacerun:yes'>  </span>Ac.Name</td>
  <td class=xl33 id="_x0000_s1039" x:autofilter="all" style='border-left:none'>Local
  Ac.Name</td>
  <td class=xl33 id="_x0000_s1040" x:autofilter="all" style='border-left:none'>Korean<span
  style='mso-spacerun:yes'>  </span>Ac.Name</td>
  <td class=xl33 id="_x0000_s1041" x:autofilter="all" style='border-left:none'>Level</td>
  <td class=xl33 id="_x0000_s1042" x:autofilter="all" style='border-left:none'>Balance</td>
  <td class=xl33 id="_x0000_s1043" x:autofilter="all" style='border-left:none'
  x:str="Left ">Left<span style='mso-spacerun:yes'> </span></td>
  <td class=xl33 id="_x0000_s1044" x:autofilter="all" style='border-left:none'>Ccy</td>
 </tr>
 <% 
     string balance = "", left = "";
     for (int i = 0; i < dt.Rows.Count; i++)
     {
         if (dt.Rows[i][15].ToString() == "D")
         {
             balance = "Debit";
         }
         if (dt.Rows[i][15].ToString() == "C")
         {
             balance = "Credit";
         }
         if (dt.Rows[i][16].ToString() == "N")
         {
             left = "Summary";
         }
         if (dt.Rows[i][16].ToString() == "Y")
         {
             left = "Posting";
         }
         
      %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25  style='height:12.75pt'><%= dt.Rows[i][1].ToString() %></td>
  <td class=xl26 ><%= dt.Rows[i][2].ToString() %></td>
  <td class=xl26 x:str><%= dt.Rows[i][3].ToString() %></td>
  <td colspan=2 class=xl30 style='border-right:.5pt hairline black;border-left:
  none' x:str><%= dt.Rows[i][4].ToString() %></td>
  <td class=xl26 x:str><%= dt.Rows[i][5].ToString() %></td>
  <td class=xl26 x:str><%= dt.Rows[i][6].ToString() %></td>
  <td class=xl26 x:str><%= dt.Rows[i][7].ToString() %></td>
  <td class=xl26 x:str><%= dt.Rows[i][8].ToString() %></td>
  <td class=xl26 x:str><%= dt.Rows[i][9].ToString() %></td>
  <td class=xl26 x:str><%= dt.Rows[i][10].ToString() %><span style='display:none'><span
  style='mso-spacerun:yes'> </span></span></td>
  <td class=xl26 x:str><%= dt.Rows[i][11].ToString() %><span style='display:none'></span></td>
  <td class=xl26 x:str><%= dt.Rows[i][12].ToString() %></td>
  <td class=xl27 x:str><%= dt.Rows[i][14].ToString() %></td>
  <td class=xl27 x:str><%= dt.Rows[i][15].ToString() %></td>
  <td class=xl27 x:str><%= dt.Rows[i][16].ToString() %></td>
  <td class=xl27 x:str><%= dt.Rows[i][20].ToString() %></td>
 </tr>
 <%
 
     } %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=120 style='width:90pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=0></td>
  <td width=104 style='width:78pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=135 style='width:101pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=34 style='width:26pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
