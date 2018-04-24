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
    string SQL2="";
    string SQL
	= "SELECT     max(level)  " + 
        "                                    FROM TCO_ORG G " +
        "                                   WHERE G.DEL_IF = 0 " +
        "                              CONNECT BY PRIOR G.PK = G.P_PK " ;
        
    DataTable dt_total1 = ESysLib.TableReadOpen(SQL);
    int p_level=0;
    p_level=int.Parse(dt_total1.Rows[0][0].ToString());
    
    if(p_level==2)
    {
        SQL2	= "select a.org_id,a.org_nm,b.org_id,b.org_nm " + 
        "from tco_org a,tco_org b " +
        "where a.del_if=0 and b.del_if=0 " +
        "and B.P_PK=a.pk " +
        "and nvl(a.p_pk,0)=0 " +
        "order by nvl(a.seq,999999),a.pk,b.pk " ;

    }
    else if(p_level==3)
    {
        SQL2	= "select a.org_id,a.org_nm,b.org_id,b.org_nm,c.org_id,c.org_nm " + 
        "from tco_org a,tco_org b,tco_org c " +
        "where a.del_if=0 and b.del_if=0 and c.del_if=0 " +
        "and B.P_PK=a.pk and c.p_pk=b.pk " +
        "and nvl(a.p_pk,0)=0 " +
        "order by nvl(a.seq,999999),a.pk,b.pk " ;

    }
    else if(p_level==4)
    {
        SQL2	= "select a.org_id,a.org_nm,b.org_id,b.org_nm,c.org_id,c.org_nm,d.org_id,d.org_nm " + 
        "from tco_org a,tco_org b,tco_org c,tco_org d " +
        "where a.del_if=0 and b.del_if=0 and c.del_if=0 and d.del_if=0 " +
        "and B.P_PK=a.pk and c.p_pk=b.pk and d.p_pk=c.pk " +
        "and nvl(a.p_pk,0)=0 " +
        "order by nvl(a.seq,999999),a.pk,b.pk " ;

    }
    else if(p_level==5)
    {
        SQL2 = "select a.org_id,a.org_nm,b.org_id,b.org_nm,c.org_id,c.org_nm,d.org_id,d.org_nm,e.org_id,e.org_nm " + 
        "from tco_org a,tco_org b,tco_org c,tco_org d, tco_org e " +
        "where a.del_if=0 and b.del_if=0 and c.del_if=0 and d.del_if=0 and e.del_if=0 " +
        "and B.P_PK=a.pk and c.p_pk=b.pk and d.p_pk=c.pk and e.p_pk=d.pk " +
        "and nvl(a.p_pk,0)=0 " +
        "order by nvl(a.seq,999999),a.pk,b.pk " ;

    }

    DataTable dt_total = ESysLib.TableReadOpen(SQL2);
    int irow;
    irow = dt_total.Rows.Count;
    if (irow == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }    
   
   
 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_org_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_org_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_org_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>ACC-SER</o:LastAuthor>
  <o:LastPrinted>2008-05-23T08:14:08Z</o:LastPrinted>
  <o:Created>2008-05-23T07:19:16Z</o:Created>
  <o:LastSaved>2011-07-27T03:08:22Z</o:LastSaved>
  <o:Company>genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.41in .11in .26in .15in;
	mso-header-margin:.24in;
	mso-footer-margin:.14in;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
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
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>5</x:PaperSizeIndex>
      <x:Scale>24</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
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
  <x:WindowHeight>7935</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$5:$6</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1823 style='border-collapse:
 collapse;table-layout:fixed;width:1368pt'>
 <col class=xl24 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl24 width=91 style='mso-width-source:userset;mso-width-alt:3328;
 width:68pt'>
 <col class=xl24 width=251 style='mso-width-source:userset;mso-width-alt:9179;
 width:188pt'>
 <col class=xl24 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col class=xl24 width=265 style='mso-width-source:userset;mso-width-alt:9691;
 width:199pt'>
 <col class=xl24 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col class=xl24 width=263 style='mso-width-source:userset;mso-width-alt:9618;
 width:197pt'>
 <col class=xl24 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col class=xl24 width=232 style='mso-width-source:userset;mso-width-alt:8484;
 width:174pt'>
 <col class=xl24 width=109 style='mso-width-source:userset;mso-width-alt:3986;
 width:82pt'>
 <col class=xl24 width=223 style='mso-width-source:userset;mso-width-alt:8155;
 width:167pt'>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=11 height=38 class=xl29 width=1823 style='height:28.5pt;
  width:1368pt'>ORGANIZATION STRUCTURE</td>
 </tr>
 <tr class=xl24 height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl30></td>
  <td class=xl31></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl30></td>
  <td class=xl32></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl30></td>
  <td class=xl32></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl35 style='height:19.5pt'>No</td>
  <td colspan=2 class=xl33 style='border-right:.5pt solid black;border-left:
  none'>LEVEL 1</td>
  <td colspan=2 class=xl33 style='border-right:.5pt solid black;border-left:
  none'>LEVEL 2</td>
  <td colspan=2 class=xl33 style='border-right:.5pt solid black;border-left:
  none'>LEVEL 3</td>
  <td colspan=2 class=xl33 style='border-right:.5pt solid black;border-left:
  none'>LEVEL 4</td>
  <td colspan=2 class=xl33 style='border-right:.5pt solid black;border-left:
  none'>LEVEL 5</td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl26 style='height:19.5pt'>STT</td>
  <td class=xl27>ID</td>
  <td class=xl27>ORG NAME</td>
  <td class=xl27>ID</td>
  <td class=xl27>ORG NAME</td>
  <td class=xl27>ID</td>
  <td class=xl27>ORG NAME</td>
  <td class=xl27>ID</td>
  <td class=xl27>ORG NAME</td>
  <td class=xl27>ID</td>
  <td class=xl27>ORG NAME</td>
 </tr>
 <% 
    string s_format;
    for (int i = 0; i < irow; i++) 
    {
       
    %>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl36 style='height:19.5pt;border-top:none none;'><%=i+1 %></td>
  <td class=xl37 style='border-top:none;border-left:none none;'><%= dt_total.Rows[i][0].ToString() %></td>
  <td class=xl37 style='border-top:none;border-left:none none;'><%= dt_total.Rows[i][1].ToString() %></td>
  <td class=xl37 style='border-top:none;border-left:none none;'><%= dt_total.Rows[i][2].ToString() %></td>
  <td class=xl37 style='border-top:none;border-left:none none;'><%= dt_total.Rows[i][3].ToString() %></td>
  <td class=xl36 style='border-top:none;border-left:none none;'><%if(p_level>2)%><%= dt_total.Rows[i][4].ToString() %></td>
  <td class=xl36 style='border-top:none;border-left:none none;'><%if(p_level>2)%><%= dt_total.Rows[i][5].ToString() %></td>
  <td class=xl37 style='border-top:none;border-left:none none;'><%if(p_level>3)%><%= dt_total.Rows[i][6].ToString() %></td>
  <td class=xl36 style='border-top:none;border-left:none none;'><%if(p_level>3)%><%= dt_total.Rows[i][7].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none none;'><%if(p_level>4)%><%= dt_total.Rows[i][8].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none none;'><%if(p_level>4)%><%= dt_total.Rows[i][9].ToString() %></td>
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=47 style='width:35pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=251 style='width:188pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=265 style='width:199pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=263 style='width:197pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=232 style='width:174pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=223 style='width:167pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
