<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
    ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	Response.Buffer = false;
    ESysLib.SetUser("acnt");
        
%>

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
    
    
    
    
    string l_parameter1 = Request["p_tco_company_pk"];
    string l_parameter2 = Request["p_tr_date"];
    string l_parameter3 = Request["p_status"];
    string l_parameter4 = Request["p_ac_pk"];
    string l_parameter5 = Request["p_tac_abcenter_pk"];
    string l_parameter6 = Request["p_tac_abpl_pk"];
    string l_parameter7 = Request["p_lang"];

    string l_parameter = "'" + l_parameter1 + "', ";
    l_parameter += "'" + l_parameter2 + "', ";
    l_parameter += "'" + l_parameter3 + "', ";
    l_parameter += "'" + l_parameter4 + "', ";
    l_parameter += "'" + l_parameter5 + "', ";
    l_parameter += "'" + l_parameter6 + "', ";
    l_parameter += "'" + l_parameter7 + "' ";
   
    
    //Response.Write(l_parameter);
	//Response.End();
    
    string SQL1 = " SELECT PARTNER_NAME, ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + l_parameter1 + "'";
    string l_cmp_name = "", l_cmp_add = "", l_cmp_taxcode = "";

    DataTable dt1 = ESysLib.TableReadOpen(SQL1);
    if (dt1.Rows.Count > 0)
    {
        l_cmp_name = dt1.Rows[0][0].ToString();
        l_cmp_add = dt1.Rows[0][1].ToString();
        l_cmp_taxcode = dt1.Rows[0][3].ToString();
    }
    string sp3 = "ac_sel_expense_plunit_sum";
    DataTable dt2 = ESysLib.TableReadOpenCursor(sp3, l_parameter);
    if (dt2.Rows.Count == 0)
    {
        Response.Write("there is no data.");
        Response.End();            
    }
    
    
      
    string l_date_from = "",l_date_to="";
    string SQL = "";
    string SQL3   = "SELECT TO_CHAR (TO_DATE ('" + l_parameter2 + "' || '01', 'yyyymmdd'), 'dd/mm/yyyy') from_dt, " +
            "       TO_CHAR (LAST_DAY (TO_DATE ('" + l_parameter2 + "' || '01', 'yyyymmdd')), " +
            "                'dd/mm/yyyy' " +
            "               ) to_dt " +
            "  FROM DUAL ";
    DataTable dt4 = ESysLib.TableReadOpen(SQL3);
    if (dt4.Rows.Count > 0)
    {
        l_date_from = dt4.Rows[0][0].ToString();
        l_date_to = dt4.Rows[0][1].ToString();
        
    }
    //Response.Write(SQL1);
    int i, j;
   
%>


<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00220_Expense%20PL_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00220_Expense%20PL_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00220_Expense%20PL_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>AA</o:Author>
  <o:LastAuthor>Mr Long</o:LastAuthor>
  <o:LastPrinted>2009-10-07T01:56:20Z</o:LastPrinted>
  <o:Created>2008-12-29T02:31:10Z</o:Created>
  <o:LastSaved>2009-10-07T06:38:24Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .5in .25in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
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
.style20
	{color:blue;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-style-name:Hyperlink;
	mso-style-id:8;}
a:link
	{color:blue;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
a:visited
	{color:purple;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
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
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext; 
	background:#99CCFF;
	mso-pattern:auto none;
	}
	
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;
	
	}
	
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	text-align:right;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style20;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	color:black;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}

.xl46
    {mso-style-parent:style0;
	font-size:11.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;
	background:#FFCC99;
	mso-pattern:auto none;
	font-weight:700;
	}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Expense PL</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>45</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
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
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>16</x:ActiveCol>
       <x:RangeSelection>$Q$16:$R$17</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7875</x:WindowHeight>
  <x:WindowWidth>19035</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>135</x:WindowTopY>
  <x:TabRatio>216</x:TabRatio>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Expense PL'!$A$7:$L$7</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2082 style='border-collapse:
 collapse;table-layout:fixed;width:1559pt'>
 <col class=xl24 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=115 style='mso-width-source:userset;mso-width-alt:4205;
 width:86pt'>
 <col class=xl24 width=113 style='mso-width-source:userset;mso-width-alt:4132;
 width:85pt'>
 <col class=xl24 width=131 style='mso-width-source:userset;mso-width-alt:4790;
 width:98pt'>
 <col class=xl24 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col class=xl24 width=107 style='mso-width-source:userset;mso-width-alt:3913;
 width:80pt'>
 <col class=xl24 width=109 style='mso-width-source:userset;mso-width-alt:3986;
 width:82pt'>
 <col class=xl24 width=103 span=13 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <col class=xl24 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl24 width=98 style='mso-width-source:userset;mso-width-alt:3584;
 width:74pt'>
 <col class=xl24 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <tr class=xl35 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=4 height=26 class=xl44 width=413 style='height:20.1pt;width:310pt'><%=l_cmp_name %></td>
  <td class=xl36 width=114 style='width:86pt'></td>
  <td colspan=2 class=xl45 width=216 style='width:162pt'></td>
  <td class=xl37 width=103 style='width:77pt'></td>
  <td class=xl29 width=103 style='width:77pt'></td>
  <td class=xl29 width=103 style='width:77pt'></td>
  <td class=xl35 width=103 style='width:77pt'></td>
  <td class=xl35 width=103 style='width:77pt'></td>
  <td class=xl29 width=103 style='width:77pt'></td>
  <td class=xl29 width=103 style='width:77pt'></td>
  <td class=xl35 width=103 style='width:77pt'></td>
  <td class=xl35 width=103 style='width:77pt'></td>
  <td class=xl29 width=103 style='width:77pt'></td>
  <td class=xl29 width=103 style='width:77pt'></td>
  <td class=xl35 width=103 style='width:77pt'></td>
  <td class=xl35 width=103 style='width:77pt'></td>
 </tr>
 <tr class=xl35 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=5 height=26 class=xl44 style='height:20.1pt'><%=l_cmp_add %></td>
  <td colspan=2 class=xl45></td>
  <td class=xl38></td>
  <td class=xl39></td>
  <td colspan=3 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl39></td>
  <td colspan=3 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl39></td>
  <td colspan=3 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=20 height=27 class=xl42 style='height:20.25pt'>BÁO CÁO CHI PHÍ,
  DOANH THU THEO KHOẢN MỤC</td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=20 height=27 class=xl43 style='height:20.25pt'>Từ ngày <%=l_date_from%>
  đến <%=l_date_to%></td>
 </tr>
 <tr class=xl35 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 style='height:20.1pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
   id="_x0000_t128" coordsize="21600,21600" o:spt="128" path="m,l21600,,10800,21600xe">
   <v:stroke joinstyle="miter"/>
   <v:path gradientshapeok="t" o:connecttype="custom" o:connectlocs="10800,0;5400,10800;10800,21600;16200,10800"
    textboxrect="5400,0,16200,10800"/>
  </v:shapetype><v:shape id="_x0000_s1030" type="#_x0000_t128" style='position:absolute;
   margin-left:0;margin-top:2.25pt;width:0;height:9pt;z-index:1' fillcolor="#0cf [40]"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:1;margin-left:-1px;
  margin-top:2px;width:2px;height:14px'><img width=2 height=14
  src="gfka00220_Expense%20PL_files/image001.gif" v:shapes="_x0000_s1030"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl35 width=54 style='height:20.1pt;width:41pt'></td>
   </tr>
  </table>
  </span></td>
  
  <td colspan=16 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl26 style='height:20.1pt'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=17 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
  
 <tr class=xl29 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl27 id="_x0000_s1048" x:autofilter="all"
  x:autofilterrange="$A$7:$L$7" style='height:20.1pt'>No</td>
  <td class=xl27 id="_x0000_s1049" x:autofilter="all" style='border-left:none'>P/L
  Unit Code</td>
  <td class=xl27 id="_x0000_s1050" x:autofilter="all" style='border-left:none'>P/L
  Unit Name</td>
  <td class=xl27 id="_x0000_s1051" x:autofilter="all">P/L Center Code</td>
  <td class=xl27 id="_x0000_s1052" x:autofilter="all" style='border-left:none'>P/L
  Center Name</td>
  <td class=xl27 id="_x0000_s1053" x:autofilter="all" style='border-left:none'>Acc.
  Code</td>
  <td class=xl27 id="_x0000_s1054" x:autofilter="all" style='border-left:none'>Account
  Name</td>
  <td class=xl27 id="_x0000_s1055" x:autofilter="all" style='border-left:none'>Accumulate
  Amt.</td>
  <td class=xl27 id="_x0000_s1056" x:autofilter="all" style='border-left:none'>Jan</td>
  <td class=xl27 id="_x0000_s1057" x:autofilter="all" style='border-left:none'>Feb</td>
  <td class=xl27 id="_x0000_s1058" x:autofilter="all" style='border-left:none'>Mar</td>
  <td class=xl27 id="_x0000_s1059" x:autofilter="all" style='border-left:none'>Apr</td>
  <td class=xl27 style='border-left:none'>May</td>
  <td class=xl27 style='border-left:none'>Jun</td>
  <td class=xl27 style='border-left:none'>Jul</td>
  <td class=xl27 style='border-left:none'>Aug</td>
  <td class=xl27 style='border-left:none'>Sep</td>
  <td class=xl27 style='border-left:none'>Oct</td>
  <td class=xl27 style='border-left:none'>Nov</td>
  <td class=xl27 style='border-left:none'>Dec</td>
 </tr>
  <%
      string l_pl_cd = "", l_pl_pk = "";
      decimal l_sum_accumulate = 0, l_sum_jan = 0, l_sum_feb = 0, l_sum_mar = 0, l_sum_apr = 0, l_sum_may = 0, l_sum_jun = 0, l_sum_jul = 0, l_sum_aug = 0, l_sum_sep = 0, l_sum_oct = 0, l_sum_nov = 0, l_sum_dec = 0;
        int k = 0;
      for (i = 0; i < dt2.Rows.Count; i++)
      {
          l_sum_accumulate += decimal.Parse(dt2.Rows[i][1].ToString());
          l_sum_jan += decimal.Parse(dt2.Rows[i][2].ToString());
          l_sum_feb += decimal.Parse(dt2.Rows[i][3].ToString());
          l_sum_mar += decimal.Parse(dt2.Rows[i][4].ToString());
          l_sum_apr += decimal.Parse(dt2.Rows[i][5].ToString());
          l_sum_may += decimal.Parse(dt2.Rows[i][6].ToString());
          l_sum_jun += decimal.Parse(dt2.Rows[i][7].ToString());
          l_sum_jul += decimal.Parse(dt2.Rows[i][8].ToString());
          l_sum_aug += decimal.Parse(dt2.Rows[i][9].ToString());
          l_sum_sep += decimal.Parse(dt2.Rows[i][10].ToString());
          l_sum_oct += decimal.Parse(dt2.Rows[i][11].ToString());
          l_sum_nov += decimal.Parse(dt2.Rows[i][12].ToString());
          l_sum_dec += decimal.Parse(dt2.Rows[i][13].ToString());
          l_pl_cd = dt2.Rows[i][0].ToString();
          
          SQL
          = "select pk from tac_abpl where pl_cd like '" + l_pl_cd + "' ";
          DataTable dt3 = ESysLib.TableReadOpen(SQL);
          l_pl_pk = dt3.Rows[0][0].ToString();
          l_parameter = "'" + l_parameter1 + "', ";
          l_parameter += "'" + l_parameter2 + "', ";
          l_parameter += "'" + l_parameter3 + "', ";
          l_parameter += "'" + l_parameter4 + "', ";
          l_parameter += "'" + l_parameter5 + "', ";
          l_parameter += "'" + l_pl_pk + "', ";
          l_parameter += "'" + l_parameter7 + "' ";
          DataTable dt = ESysLib.TableReadOpenCursor("ac_sel_60080190_exp_plunit_pl", l_parameter);
          for (j = 0; j < dt.Rows.Count; j++)
          {                
%> 


 <tr class=xl35 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl30 style='height:20.1pt;border-top:none'><%= k + 1 %></td>
  <td class=xl31 style='border-top:none;border-left:none'><%= dt.Rows[j][6]%></td>
  <td class=xl32 style='border-top:none;border-left:none'><%= dt.Rows[j][7]%></td>
  <td class=xl33 style='border-top:none'><%= dt.Rows[j][4]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%= dt.Rows[j][5]%></td>
  <td class=xl33 style='border-top:none;border-left:none'><%= dt.Rows[j][8]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%= dt.Rows[j][9]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%= dt.Rows[j][10]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%= dt.Rows[j][11]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%= dt.Rows[j][12]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%= dt.Rows[j][13]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%= dt.Rows[j][14]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%= dt.Rows[j][15]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%= dt.Rows[j][16]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%= dt.Rows[j][17]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%= dt.Rows[j][18]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%= dt.Rows[j][19]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%= dt.Rows[j][20]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%= dt.Rows[j][21]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%= dt.Rows[j][22]%></td>
 </tr>
 <%
         k += 1;     
      }//for j        
%>
 <tr class=xl35 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl46 style='height:20.1pt;border-top:none'></td>
  <td class=xl46 style='border-top:none;border-left:none'>Total</td>
  <td class=xl46 style='border-top:none;border-left:none'></td>
  <td class=xl46 style='border-top:none'></td>
  <td class=xl46 style='border-top:none;border-left:none'></td>
  <td class=xl46 style='border-top:none;border-left:none'></td>
  <td class=xl46 style='border-top:none;border-left:none'></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%= dt2.Rows[i][1]%></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%= dt2.Rows[i][2]%></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%= dt2.Rows[i][3]%></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%= dt2.Rows[i][4]%></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%= dt2.Rows[i][5]%></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%= dt2.Rows[i][6]%></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%= dt2.Rows[i][7]%></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%= dt2.Rows[i][8]%></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%= dt2.Rows[i][9]%></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%= dt2.Rows[i][10]%></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%= dt2.Rows[i][11]%></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%= dt2.Rows[i][12]%></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%= dt2.Rows[i][13]%></td>
 </tr>      
<%          
  } // for i
 %>
 <tr class=xl35 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl46 style='height:20.1pt;border-top:none'></td>
  <td class=xl46 style='border-top:none;border-left:none'></td>
  <td class=xl46 style='border-top:none;border-left:none'></td>
  <td class=xl46 style='border-top:none'></td>
  <td class=xl46 style='border-top:none;border-left:none'></td>
  <td class=xl46 style='border-top:none;border-left:none'></td>
  <td class=xl46 style='border-top:none;border-left:none'></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%= l_sum_accumulate%></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%=l_sum_jan %></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%=l_sum_feb %></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%=l_sum_mar %></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%=l_sum_apr %></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%=l_sum_may %></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%=l_sum_jun %></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%=l_sum_jul %></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%=l_sum_aug %></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%=l_sum_sep %></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%=l_sum_oct %></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%=l_sum_nov %></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%=l_sum_dec %></td>
 </tr>       
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=20 class=xl24 style='height:20.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=20 class=xl24 style='height:20.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=20 class=xl24 style='height:20.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=20 class=xl24 style='height:20.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=20 class=xl24 style='height:20.1pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=54 style='width:41pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
