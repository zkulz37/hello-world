<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
%>
<%  ESysLib.SetUser("acnt");%>
<% 
    string l_kind = Request["p_kind"];  
  string l_status=Request["p_status"];
  string l_tco_company_pk=Request["p_company_pk"];
  string l_date_fr=Request["p_date_f"];
  string l_date_to=Request["p_date_t"];
  string l_date_type=Request["p_date_type"];
string l_scale=Request["p_scale"];
string fr_dt, to_dt, l_cmp_name, l_cmp_add, l_cmp_taxcode, l_last_year, l_cur_month, l_prev_month, l_cur_month1,l_yymm1,l_yymm2,l_yy,l_mm;
  fr_dt = "";
  to_dt = "";
  l_cmp_name = "";
  l_cmp_add = "";
  l_cmp_taxcode = "";
  l_last_year=""; 
 l_cur_month="";
 l_prev_month = "";
 l_cur_month1 = "";
 l_yymm1 = "";
 l_yymm2 = "";
 l_yy = "";
 l_mm = "";   

string y = l_date_fr.Substring(0,4),y1,y2;
string m = l_date_fr.Substring(4,2),m1,m2;

if(m == "01")
{
	m1 = "12";
	y1 = (int.Parse(y) -1).ToString("0000");
}
else 
{
	m1 = (int.Parse(m) -1).ToString("00");
	y1 = y;//(int.Parse(y) -1).ToString("0000");
}

if(m1 == "01")
{
	m2 = "12";
	y2 = (int.Parse(y1) -1).ToString("0000");
}
else 
{
	m2 = (int.Parse(m1) -1).ToString("00");
	y2 = y1;
	//(int.Parse(y1) -1).ToString("0000");
}


string SQL = " SELECT partner_name, addr1, addr2, tax_code, TO_CHAR (TO_DATE ('" + l_date_fr + "', 'yyyymmdd'), 'mm/yyyy') to_day, ";
SQL += "       TO_CHAR (ADD_MONTHS (TO_DATE ('" + l_date_to + "', 'yyyymmdd'), -1), 'mm.yy') prev_month, ";
SQL += "       TO_CHAR (TO_DATE ('" + l_date_to + "', 'yyyymmdd'), 'mm.yy') cur_month, ";
SQL += "       TO_CHAR (ADD_MONTHS (TO_DATE ('" + l_date_to + "', 'yyyymmdd'), -12), 'mm.yy') last_year, ";
SQL += "       TO_CHAR (TO_DATE ('" + l_date_to + "', 'yyyymmdd'), 'yy.mm') cur_month_yymm1, ";
SQL += "       TO_CHAR (ADD_MONTHS (TO_DATE ('" + l_date_to + "', 'yyyymmdd'), -1), 'yy.mm') prev_month_yymm2, ";
SQL += "       TO_CHAR (TO_DATE ('" + l_date_to + "', 'yyyymmdd'), 'yy') cur_month_yy, ";
SQL += "       TO_CHAR (TO_DATE ('" + l_date_to + "', 'yyyymmdd'), 'mm') cur_month_mm ";                
SQL += "  FROM tco_company ";
SQL += " WHERE pk = '" + l_tco_company_pk + "' ";


  DataTable dt_f = ESysLib.TableReadOpen(SQL);
  if (dt_f.Rows.Count > 0)
  {
      l_cmp_name = dt_f.Rows[0][0].ToString();

      l_cmp_add = dt_f.Rows[0][1].ToString();
      l_cmp_taxcode = dt_f.Rows[0][3].ToString();
      l_cur_month1 = dt_f.Rows[0][4].ToString();
      l_prev_month = dt_f.Rows[0][5].ToString();//T truoc
      l_cur_month = dt_f.Rows[0][6].ToString();//T hientai
      l_last_year = dt_f.Rows[0][7].ToString();//nam truoc
      l_yymm1 = dt_f.Rows[0][8].ToString();
      l_yymm2 = dt_f.Rows[0][9].ToString();
      l_yy = dt_f.Rows[0][10].ToString();
      l_mm = dt_f.Rows[0][11].ToString();

  }
      
  string l_parameter="'" + l_kind + "','" + l_status + "','" + l_tco_company_pk + "','" + l_date_fr + "','" + l_date_to + "','" + l_date_type + "','" + l_scale +"'";
  string sp="ACNT.SP_SEL_GRD_FINANCE_STATEMENT3";
	//Response.Write(sp + l_parameter);
    //Response.End();
  DataTable dt = ESysLib.TableReadOpenCursor(sp,l_parameter);  
  if (dt.Rows.Count==0)
  {
    Response.Write("There is no data");
    Response.End();
  
}
%> 
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00120_vie_kor_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00120_vie_kor_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00120_vie_kor_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>genuwin</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2009-04-17T03:37:02Z</o:LastPrinted>
  <o:Created>2009-03-12T08:16:42Z</o:Created>
  <o:LastSaved>2009-04-17T03:38:07Z</o:LastSaved>
  <o:Company>company</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .25in .5in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style17
	{mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	mso-style-name:"Comma \[0\]";
	mso-style-id:6;}
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
.style20
	{mso-number-format:0%;
	mso-style-name:Percent;
	mso-style-id:5;}
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
	font-size:11.0pt;
	font-family:\AC00\C744\CCB4, serif;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0_ ";
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:\AC00\C744\CCB4, serif;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0\.000_ ";
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Gaeul, serif;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0_ ";
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_ ";
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Gaeul, serif;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0_ ";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Gaeul, serif;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0_ ";
	vertical-align:middle;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	color:white;
	font-size:9.0pt;
	font-family:Gaeul, serif;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0_ ";
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	color:white;
	font-size:12.0pt;
	font-family:Gaeul, serif;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0_ ";
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-family:Gaeul, serif;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0_ ";
	text-align:right;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_ ";
	vertical-align:middle;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_ ";
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:\AC00\C744\CCB4, serif;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0\.00_ ";
	vertical-align:middle;}
.xl37
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-family:\AC00\C744\CCB4, serif;
	mso-font-charset:129;
	mso-number-format:"0\.000000%";
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:\AC00\C744\CCB4, serif;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0\.000000000_ ";
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:\AC00\C744\CCB4, serif;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0_ ";
	vertical-align:middle;}
.xl40
	{mso-style-parent:style17;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_ ";
	vertical-align:middle;
	mso-text-control:shrinktofit;
	border:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Gaeul;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_ ";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_ ";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_ ";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_ ";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_ ";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_ ";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Gaeul, serif;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0_ ";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>3.BS(Bang can doi KT)</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>66</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>8</x:SplitHorizontal>
     <x:TopRowBottomPane>8</x:TopRowBottomPane>
     <x:SplitVertical>1</x:SplitVertical>
     <x:LeftColumnRightPane>1</x:LeftColumnRightPane>
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
       <x:ActiveRow>5</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>17</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
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
  <x:WindowTopX>-180</x:WindowTopX>
  <x:WindowTopY>345</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1462 style='border-collapse:
 collapse;table-layout:fixed;width:1097pt'>
 <col class=xl25 width=26 style='mso-width-source:userset;mso-width-alt:950;
 width:20pt'>
 <col class=xl25 width=186 style='mso-width-source:userset;mso-width-alt:6802;
 width:140pt'>
 <col class=xl28 width=225 style='mso-width-source:userset;mso-width-alt:8228;
 width:169pt'>
 <col class=xl25 width=95 span=5 style='mso-width-source:userset;mso-width-alt:
 3474;width:71pt'>
 <col class=xl25 width=171 style='mso-width-source:userset;mso-width-alt:6253;
 width:128pt'>
 <col class=xl25 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl25 width=122 style='mso-width-source:userset;mso-width-alt:4461;
 width:92pt'>
 <col class=xl25 width=167 style='mso-width-source:userset;mso-width-alt:6107;
 width:125pt'>
 <tr class=xl41 height=20 style='height:15.0pt'>
  <td height=20 class=xl41 width=26 style='height:15.0pt;width:20pt'></td>
  <td class=xl28 width=186 style='width:140pt'><% =l_cmp_name %></td>
  <td class=xl42 width=225 style='width:169pt'></td>
  <td class=xl41 width=95 style='width:71pt'></td>
  <td class=xl41 width=95 style='width:71pt'></td>
  <td class=xl43 width=95 style='width:71pt'></td>
  <td class=xl41 width=95 style='width:71pt'></td>
  <td class=xl41 width=95 style='width:71pt'></td>
  <td class=xl41 width=171 style='width:128pt'></td>
  <td class=xl41 width=90 style='width:68pt'></td>
  <td class=xl41 width=122 style='width:92pt'></td>
  <td class=xl41 width=167 style='width:125pt'></td>
 </tr>
 <tr class=xl41 height=20 style='height:15.0pt'>
  <td height=20 class=xl41 style='height:15.0pt'></td>
  <td class=xl28 colspan=2 style='mso-ignore:colspan'><% =l_cmp_add %></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl43></td>
  <td colspan=6 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl41 height=20 style='height:15.0pt'>
  <td height=20 class=xl41 style='height:15.0pt'></td>
  <td class=xl28>Mã s&#7889; thu&#7871; : <% =l_cmp_taxcode%></td>
  <td class=xl42></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl43></td>
  <td colspan=6 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl25 style='height:21.75pt'></td>
  <td class=xl39 colspan=3 style='mso-ignore:colspan'>3.
  &#45824;&#52264;&#45824;&#51312;&#54364;<span style='mso-spacerun:yes'> 
  </span>BẢNG CÂN ĐỐI  <%=l_cur_month1%></td>
  <td colspan=4 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=20 style='height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt'></td>
  <td class=xl25>&#54840;&#52824;&#48124; &#44552;&#54840;&#49340;&#53076;</td>
  <td class=xl28>1:10000 Scale is: <%= l_scale%></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl33>[&#45800;&#50948;:&#48177;&#47564;VND]</td>
 </tr>
 <tr class=xl35 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl34 style='height:13.5pt'>&nbsp;</td>
  <td rowspan=3 class=xl44>&#44396;<span style='mso-spacerun:yes'>         
  </span>&#48516;</td>
  <td rowspan=3 class=xl45>H&#7841;ng m&#7909;c</td>
  <td class=xl45 style='border-top:none;border-left:none' x:str="''08&#45380; 12&#50900;&#47568;"><% = l_yy %>&#45380;
  <%=l_mm %>&#50900;&#47568;</td>
  <td class=xl45 style='border-left:none' ><%=l_yymm2 %>&#50900;&#47568;</td>
  <td class=xl45 style='border-left:none' ><%=l_yymm1%>&#50900;&#47568;</td>
  <td class=xl45 style='border-left:none' >&#51204;&#50900;&#47568;&#45824;&#48708;</td>
  <td class=xl45 style='border-left:none'>&#51204;&#45380;&#47568;&#45824;&#48708;</td>
  <td colspan=2 rowspan=2 class=xl45>&#51613;&#44032;&#45236;&#50669;(&#51204;&#45380;&#47568;&#45824;&#48708;)</td>
  <td colspan=2 rowspan=2 class=xl45>&#44048;&#49548;&#45236;&#50669;(&#51204;&#45380;&#47568;&#45824;&#48708;)</td>
 </tr>
 <tr class=xl35 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl34 style='height:13.5pt'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>(A)</td>
  <td class=xl45 style='border-top:none;border-left:none'>(B)</td>
  <td class=xl45 style='border-top:none;border-left:none'>(C)</td>
  <td class=xl45 style='border-top:none;border-left:none'>(C-B)</td>
  <td class=xl45 style='border-top:none;border-left:none'>(C-A)</td>
 </tr>
 <tr class=xl35 height=38 style='height:28.5pt'>
  <td height=38 class=xl34 style='height:28.5pt'>&nbsp;</td>
  <td class=xl46 width=95 style='border-top:none;border-left:none;width:71pt'>Năm trước<br/>T.<%= l_last_year%> </td>
  <td class=xl46 width=95 style='border-top:none;border-left:none;width:71pt'>Tháng
  trước T.<%= l_prev_month%> </td>
  <td class=xl46 width=95 style='border-top:none;border-left:none;width:71pt'>Tháng
  này<br/> T. <%= l_cur_month %> </td>
  <td class=xl46 width=95 style='border-top:none;border-left:none;width:71pt'>So
  v&#7899;i cu&#7889;i tháng tr&#432;&#7899;c</td>
  <td class=xl46 width=95 style='border-top:none;border-left:none;width:71pt'>So
  v&#7899;i cu&#7889;i <br>
    n&#259;m tr&#432;&#7899;c</td>
  <td colspan=2 class=xl45 style='border-left:none'>N&#7897;i dung t&#259;ng
  (so v&#7899;i cu&#7889;i n&#259;m tr&#432;&#7899;c)</td>
  <td colspan=2 class=xl45 style='border-left:none'>N&#7897;i dung gi&#7843;m
  (so v&#7899;i cu&#7889;i n&#259;m tr&#432;&#7899;c)</td>
 </tr>
  <% 
	 
	 
	 for(int i = 0; i<dt.Rows.Count ; i++)
	 {
		string tag_begin=" ";
        string tag_end=" ";
        string color;
         color = "background-color:";
         color += dt.Rows[i][6].ToString();
        if (dt.Rows[i][5].ToString()=="I")
        {
            tag_begin="<i>";
            tag_end="</i>";
        }
        if (dt.Rows[i][5].ToString()=="B")
        {
            tag_begin="<b>";
            tag_end="</b>";
        }
 %> 
   
 <tr  style="<%=color %>" class=xl27 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18  class=xl27 style='height:13.5pt'></td>
  <td class=xl47 style='border-top:none'><%=tag_begin%><%= dt.Rows[i][2].ToString()%><%=tag_end%></td>
  <td class=xl48 style='border-top:none;border-left:none'><%=tag_begin%><%= dt.Rows[i][1].ToString()%><%=tag_end%></td>
  <td class=xl40 align=right   x:num><%=tag_begin%><%= dt.Rows[i][6].ToString()%><%=tag_end%></td>
  <td class=xl40 align=right   x:num><%=tag_begin%><%= dt.Rows[i][7].ToString()%><%=tag_end%></td>
  <td class=xl40 align=right   x:num><%=tag_begin%><%= dt.Rows[i][8].ToString()%><%=tag_end%></td>
  <td class=xl40 align=right   x:num><%=tag_begin%><%= dt.Rows[i][9].ToString()%><%=tag_end%></td>
  <td class=xl40 align=right   x:num> <%=tag_begin%><%= dt.Rows[i][10].ToString()%><%=tag_end%> </td>
  <td colspan=2 class=xl49 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl50 style='border-left:none'>&nbsp;</td>
 </tr>
 <%
     } 
 %>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl25 style='height:13.5pt'></td>
  <td class=xl28 colspan=4 style='mso-ignore:colspan'>&#51452;)
  &#50976;&#51060;&#51088;&#52292;&#47924;&#51032;
  &#44592;&#53440;&#51312;&#51221;&#44552;&#50529;&#51008;
  &#54788;&#51116;&#44032;&#52824;&#54624;&#51064;&#52264;&#44552;,
  &#49324;&#52292;&#54624;&#51064;&#48156;&#54665;&#52264;&#44552; &#46321;&#51012;
  '-'&#47196; &#54364;&#44592;</td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td colspan=9 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td colspan=3 class=xl36 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td class=xl25></td>
  <td colspan=2 class=xl37 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td class=xl25></td>
  <td colspan=2 class=xl38 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=26 style='width:20pt'></td>
  <td width=186 style='width:140pt'></td>
  <td width=225 style='width:169pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=171 style='width:128pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=122 style='width:92pt'></td>
  <td width=167 style='width:125pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
