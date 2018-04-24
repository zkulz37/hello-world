<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string SQL_VN
	= "select c12 , count(c12) cnt_c12 " + 
        "from " +
        "( " +
        "select c00, c01, c02, c03, c04  " +
        "        , c05, c06, c07, c08, c09  " +
        "        , c10, c11, c12  " +
        "from  " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04  " +
        "        , nvl(G.SEQ,0) c05  " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06  " +
        "        , E.JOIN_DT c07  " +
        "        , E.EMP_ID c08  " +
        "        , g.pk c09  " +
        "        , G.ORG_NM c10  " +
        "        , G.ORG_ID c11      " +
        "        , (select char_4 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12      " +
        "from thr_employee e, tco_org g  " +
        "where E.DEL_IF=0  " +
        "and E.NATION='01'  " +
        "and E.STATUS='A'  " +
        "and E.POS_TYPE is not null  " +
        "and G.DEL_IF=0  " +
        "and E.TCO_ORG_PK=g.pk  " +
        ")  " +
		//"where c12='100.MANAGER'  " +
        ") " +
        "group by c12 " +
        "order by c12 " ;
    //Response.Write(SQL_VN );
    //Response.End();    
	DataTable dt_vn = ESysLib.TableReadOpen(SQL_VN);
    if (dt_vn.Rows.Count == 0)
    {
        Response.Write("There is no data of working time");
        Response.End();
    }/**/
	
	string SQL_KOR
	= "select c12 , count(c12) cnt_c12 " + 
        "from " +
        "( " +
        "select c00, c01, c02, c03, c04  " +
        "        , c05, c06, c07, c08, c09  " +
        "        , c10, c11, c12  " +
        "from  " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04  " +
        "        , nvl(G.SEQ,0) c05  " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06  " +
        "        , E.JOIN_DT c07  " +
        "        , E.EMP_ID c08  " +
        "        , g.pk c09  " +
        "        , G.ORG_NM c10  " +
        "        , G.ORG_ID c11      " +
        "        , (select char_4 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12      " +
        "from thr_employee e, tco_org g  " +
        "where E.DEL_IF=0  " +
        "and E.NATION<>'01'  " +
        "and E.STATUS='A'  " +
        "and E.POS_TYPE is not null  " +
        "and G.DEL_IF=0  " +
        "and E.TCO_ORG_PK=g.pk  " +
        ")  " +
		//"where c12='100.MANAGER'  " +
        ") " +
        "group by c12 " +
        "order by c12 " ;
	DataTable dt_kor = ESysLib.TableReadOpen(SQL_KOR);
    if (dt_kor.Rows.Count == 0)
    {
        Response.Write("There is no data of working time");
        Response.End();
    }/**/
	
	//Response.Write(SQL_KOR);
        //Response.End();
		
	string SQL_TOTAL
	= "select to_char(sysdate,'dd-MON-yyyy') sys_date, c13,  cnt_c13 " + 
        "from " +
        "( " +
        "select c13, count(*) cnt_c13  " +
        "from  " +
        "(  " +
        "select c00, c01, c02, c03, c04   " +
        "        , c05, c06, c07, c08, c09   " +
        "        , c10, c11, c12  , c13 " +
        "from   " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04   " +
        "        , nvl(G.SEQ,0) c05   " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06   " +
        "        , E.JOIN_DT c07   " +
        "        , E.EMP_ID c08   " +
        "        , g.pk c09   " +
        "        , G.ORG_NM c10   " +
        "        , G.ORG_ID c11       " +
        "        , (select char_4 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12 " +
        "        , case when nvl(E.NATION,'01')='01' then 1 else 0 end c13       " +
        "from thr_employee e, tco_org g   " +
        "where E.DEL_IF=0   " +
        "and E.STATUS='A'   " +
        "and E.POS_TYPE is not null   " +
        "and G.DEL_IF=0   " +
        "and E.TCO_ORG_PK=g.pk   " +
        ")     " +
        ")  " +
        "group by c13 " +
        ") " +
        "order by c13 " ;
	
	DataTable dt_total = ESysLib.TableReadOpen(SQL_TOTAL);	
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_org_chart_pcss2_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_org_chart_pcss2_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_org_chart_pcss2_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>User</o:Author>
  <o:LastAuthor>SV108</o:LastAuthor>
  <o:LastPrinted>2013-03-27T06:48:19Z</o:LastPrinted>
  <o:Created>2012-12-10T08:25:12Z</o:Created>
  <o:LastSaved>2013-03-27T06:51:00Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.36in .2in .22in .2in;
	mso-header-margin:.2in;
	mso-footer-margin:.19in;
	mso-page-orientation:landscape;}
.font22
	{color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
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
	font-family:Arial, sans-serif;
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
	font-family:Arial, sans-serif;
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
.xl66
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;}
.xl67
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl68
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;}
.xl69
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;}
.xl71
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	color:olive;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	font-size:11.0pt;}
.xl74
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	font-size:8.0pt;}
.xl76
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;}
.xl78
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	color:white;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl81
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:left;}
.xl82
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl85
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl87
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	border:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	font-size:11.0pt;
	border:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	border:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	font-size:14.0pt;
	text-align:center;}
.xl92
	{mso-style-parent:style0;
	color:black;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	font-size:12.0pt;
	border:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl95
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl96
	{mso-style-parent:style0;
	font-size:11.0pt;
	border:.5pt solid windowtext;}
.xl97
	{mso-style-parent:style0;
	color:white;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl99
	{mso-style-parent:style0;
	color:white;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl100
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>PCSS</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>54</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>7</x:SplitHorizontal>
     <x:TopRowBottomPane>7</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>3</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveCol>1</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>9</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>4</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
       <x:RangeSelection>$C$5:$D$5</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7365</x:WindowHeight>
  <x:WindowWidth>18975</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Area</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=PCSS!$B$1:$U$11</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=4080 style='border-collapse:
 collapse;table-layout:fixed;width:3065pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:2340'>
 <col width=54 style='mso-width-source:userset;mso-width-alt:1974;width:41pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:1718'>
 <col width=202 style='mso-width-source:userset;mso-width-alt:7387;width:152pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:1718'>
 <col width=202 style='mso-width-source:userset;mso-width-alt:7387;width:152pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:1718'>
 <col width=202 style='mso-width-source:userset;mso-width-alt:7387;width:152pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:1718'>
 <col width=202 style='mso-width-source:userset;mso-width-alt:7387;width:152pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:1718'>
 <col width=202 style='mso-width-source:userset;mso-width-alt:7387;width:152pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:1718'>
 <col width=202 style='mso-width-source:userset;mso-width-alt:7387;width:152pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:1718'>
 <col width=202 style='mso-width-source:userset;mso-width-alt:7387;width:152pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:1718'>
 <col width=202 style='mso-width-source:userset;mso-width-alt:7387;width:152pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:1718'>
 <col width=202 style='mso-width-source:userset;mso-width-alt:7387;width:152pt'>
 <col width=32 style='mso-width-source:userset;mso-width-alt:1170;width:24pt'>
 <col width=64 span=6 style='width:48pt'>
 <col width=64 style='width:48pt'>
 <col width=64 span=4 style='width:48pt'>
 <col width=64 style='width:48pt'>
 <col width=64 span=4 style='width:48pt'>
 <col width=64 style='width:48pt'>
 <col width=64 span=4 style='width:48pt'>
 <col width=64 style='width:48pt'>
 <col width=64 span=4 style='width:48pt'>
 <col width=64 style='width:48pt'>
 <col width=64 span=4 style='width:48pt'>
 <col width=64 style='width:48pt'>
 <col width=64 style='width:48pt'>
 <col width=64 style='width:48pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 width=0 style='height:12.75pt'></td>
  <td class=xl66 width=54 style='width:41pt'><a name="Print_Area"></a></td>
  <td class=xl66 width=0></td>
  <td width=202 style='width:152pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
   id="_x0000_t75" coordsize="21600,21600" o:spt="75" o:preferrelative="t"
   path="m@4@5l@4@11@9@11@9@5xe" filled="f" stroked="f">
   <v:stroke joinstyle="miter"/>
   <v:formulas>
    <v:f eqn="if lineDrawn pixelLineWidth 0"/>
    <v:f eqn="sum @0 1 0"/>
    <v:f eqn="sum 0 0 @1"/>
    <v:f eqn="prod @2 1 2"/>
    <v:f eqn="prod @3 21600 pixelWidth"/>
    <v:f eqn="prod @3 21600 pixelHeight"/>
    <v:f eqn="sum @0 0 1"/>
    <v:f eqn="prod @6 1 2"/>
    <v:f eqn="prod @7 21600 pixelWidth"/>
    <v:f eqn="sum @8 21600 0"/>
    <v:f eqn="prod @7 21600 pixelHeight"/>
    <v:f eqn="sum @10 21600 0"/>
   </v:formulas>
   <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
   <o:lock v:ext="edit" aspectratio="t"/>
  </v:shapetype><v:shape id="Picture_x0020_3" o:spid="_x0000_s1035" type="#_x0000_t75"
   alt="posco ss-vina logo" style='position:absolute;margin-left:12.75pt;
   margin-top:1.5pt;width:93.75pt;height:32.25pt;z-index:1;visibility:visible'>
   <v:imagedata src="rpt_org_chart_pcss2_files/image001.jpg" o:title="posco ss-vina logo"/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:17px;margin-top:2px;width:125px;
  height:43px'><img width=125 height=43
  src="rpt_org_chart_pcss2_files/image002.jpg" alt="posco ss-vina logo" v:shapes="Picture_x0020_3"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 class=xl66 width=202 style='height:12.75pt;width:152pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl66 width=0></td>
  <td width=202 style='width:152pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
   id="_x0000_t202" coordsize="21600,21600" o:spt="202" path="m,l,21600r21600,l21600,xe">
   <v:stroke joinstyle="miter"/>
   <v:path gradientshapeok="t" o:connecttype="rect"/>
  </v:shapetype><v:shape id="Text_x0020_Box_x0020_2" o:spid="_x0000_s1036"
   type="#_x0000_t202" style='position:absolute;margin-left:.75pt;margin-top:2.25pt;
   width:578.25pt;height:30pt;z-index:2;visibility:visible;mso-wrap-style:tight'
   stroked="f">
   <v:textbox style='mso-direction-alt:auto' inset="2.16pt,1.8pt,0,0">
    <div style='text-align:left'><font class="font22">POSCO SS - VINA Co.,
    LTD<br>
        </font><font class="font22">N1 Street, Phu My II Industrial Zone, Tan
    Thanh District, Ba Ria - Vung Tau Province, Vietnam<span
    style='mso-spacerun:yes'>          </span></font></div>
   </v:textbox>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:1px;margin-top:3px;width:771px;
  height:40px'><img width=771 height=40
  src="rpt_org_chart_pcss2_files/image003.gif"
  alt="Text Box: POSCO SS - VINA Co., LTD&#10;N1 Street, Phu My II Industrial Zone, Tan Thanh District, Ba Ria - Vung Tau Province, Vietnam          "
  v:shapes="Text_x0020_Box_x0020_2"></span><![endif]><span style='mso-ignore:
  vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 class=xl66 width=202 style='height:12.75pt;width:152pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl66 width=0></td>
  <td class=xl66 width=202 style='width:152pt'></td>
  <td class=xl66 width=0></td>
  <td class=xl66 width=202 style='width:152pt'></td>
  <td class=xl66 width=0></td>
  <td class=xl66 width=202 style='width:152pt'></td>
  <td class=xl66 width=0></td>
  <td class=xl66 width=202 style='width:152pt'></td>
  <td class=xl66 width=0></td>
  <td class=xl66 width=202 style='width:152pt'></td>
  <td class=xl66 width=0></td>
  <td class=xl66 width=202 style='width:152pt'></td>
  <td class=xl66 width=0></td>
  <td class=xl66 width=202 style='width:152pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=35 style='height:26.25pt'>
  <td height=35 style='height:26.25pt'></td>
  <td class=xl68 x:str="    "><span style='mso-spacerun:yes'>    </span></td>
  <td class=xl68></td>
  <td colspan=16 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl91><span style='mso-spacerun:yes'> </span>Update:
  <%=dt_total.Rows[0]["sys_date"].ToString()%></td>
  <td colspan=34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 style='height:22.5pt'></td>
  <td colspan=19 class=xl69 style='mso-ignore:colspan'></td>
  <td colspan=35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=58 style='mso-height-source:userset;height:43.5pt'>
  <td colspan=21 height=58 class=xl92 style='height:43.5pt'><span
  style='mso-spacerun:yes'>    </span>POSCO SS - VINA ORGANIZATION CHART</td>
  <td colspan=34 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl70 height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl93 style='height:28.5pt;border-top:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none' x:str="Dept."><span
  style='mso-spacerun:yes'> </span>Dept.<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl94 width=202 style='border-left:none;width:152pt'
  x:str="P &amp; F Dept."><span style='mso-spacerun:yes'> </span>P &amp; F
  Dept.<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl94 width=202 style='border-left:none;width:152pt'
  x:str="A &amp; S Dept."><span style='mso-spacerun:yes'> </span>A &amp; S
  Dept.<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl94 width=202 style='border-left:none;width:152pt'
  x:str="M Dept."><span style='mso-spacerun:yes'> </span>M Dept.<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl94 width=202 style='border-left:none;width:152pt'
  x:str="PS Dept."><span style='mso-spacerun:yes'> </span>PS Dept.<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl94 width=202 style='border-left:none;width:152pt'
  x:str="R Dept."><span style='mso-spacerun:yes'> </span>R Dept.<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl94 width=202 style='border-left:none;width:152pt'
  x:str="Q &amp; P Dept."><span style='mso-spacerun:yes'> </span>Q &amp; P
  Dept.<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl94 width=202 style='border-left:none;width:152pt'
  x:str="MS Dept."><span style='mso-spacerun:yes'> </span>MS Dept.<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl94 width=202 style='border-left:none;width:152pt'
  x:str="M &amp; E Dept."><span style='mso-spacerun:yes'> </span>M &amp; E
  Dept.<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl94 width=202 style='border-left:none;width:152pt'
  x:str="C &amp; A Dept."><span style='mso-spacerun:yes'> </span>C &amp; A
  Dept.<span style='mso-spacerun:yes'> </span></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num>9</td>
  <td colspan=34 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl73 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl96 style='height:22.5pt;border-top:none'>&nbsp;</td>
  <td class=xl76 style='border-top:none;border-left:none' x:str="I"><span
  style='mso-spacerun:yes'> </span>I<span style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl90 width=404 style='border-left:none;width:304pt'><span
  style='mso-spacerun:yes'> </span>KOREAN</td>
  <td class=xl90 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 width=202 style='border-top:none;border-left:none;width:152pt'>&nbsp;</td>
  <td class=xl90 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 width=202 style='border-top:none;border-left:none;width:152pt'>&nbsp;</td>
  <td class=xl90 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 width=202 style='border-top:none;border-left:none;width:152pt'>&nbsp;</td>
  <td class=xl90 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 width=202 style='border-top:none;border-left:none;width:152pt'>&nbsp;</td>
  <td class=xl90 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 width=202 style='border-top:none;border-left:none;width:152pt'>&nbsp;</td>
  <td class=xl90 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 width=202 style='border-top:none;border-left:none;width:152pt'>&nbsp;</td>
  <td class=xl90 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 width=202 style='border-top:none;border-left:none;width:152pt'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none' x:num>
  <%=int.Parse(dt_total.Rows[0]["cnt_c13"].ToString())+1%>
  </td>
  <td colspan=34 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl75 height=57 style='mso-height-source:userset;height:42.75pt'>
  <td height=57 class=xl87 style='height:42.75pt;border-top:none' x:num>1</td>
  <td class=xl84 width=54 style='border-top:none;border-left:none;width:41pt'
  x:str="General Director"><span style='mso-spacerun:yes'> </span>General
  Director<span style='mso-spacerun:yes'> </span></td>
  <td class=xl97 style='border-top:none;border-left:none' x:str="'000001">000001</td>
  <td colspan=17 class=xl98 width=1818 style='border-left:none;width:1368pt'>RYU
  JU YEOL<br>
    Email: ryu3650@poscoss.com<br>
    Phone: 090 8880 745<span style='mso-spacerun:yes'>      </span>/<span
  style='mso-spacerun:yes'>     </span>000</td>
  <td class=xl83 style='border-top:none;border-left:none' x:num>1</td>
  <td colspan=34 class=xl75 style='mso-ignore:colspan'></td>
 </tr>
 
 <%
	int ii=0;
	int []sum_kor=new int []{0,0,0,0,0,0,0,0,0,0};
	for(ii=0;ii<dt_kor.Rows.Count;ii++)	
	{
		string SQL1_kor
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_4 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION<>'01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=975 " +
        ") " +
		"where  c12= '"+dt_kor.Rows[ii]["c12"].ToString()+"'	" +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_1_kor = ESysLib.TableReadOpen(SQL1_kor);
    /*if (dt_1.Rows.Count == 0)
    {
        Response.Write("There is no data of working time");
        Response.End();
    }/**/
	//Response.Write(SQL1);
    //Response.End();
	string SQL2_kor
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_4 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION<>'01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=974 " +
        ") " +
		"where  c12= '"+dt_kor.Rows[ii]["c12"].ToString()+"'	" +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_2_kor = ESysLib.TableReadOpen(SQL2_kor);
	
	string SQL3_kor
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_4 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION<>'01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=976 " +
        ") " +
		"where  c12= '"+dt_kor.Rows[ii]["c12"].ToString()+"'	" +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_3_kor = ESysLib.TableReadOpen(SQL3_kor);
	
	string SQL4_kor
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_4 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION<>'01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=977 " +
        ") " +
		"where  c12= '"+dt_kor.Rows[ii]["c12"].ToString()+"'	" +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_4_kor = ESysLib.TableReadOpen(SQL4_kor);
	
	string SQL5_kor
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_4 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION<>'01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=979 " +
        ") " +
		"where  c12= '"+dt_kor.Rows[ii]["c12"].ToString()+"'	" +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_5_kor = ESysLib.TableReadOpen(SQL5_kor);
	
	string SQL6_kor
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_4 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION<>'01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=980 " +
        ") " +
		"where  c12= '"+dt_kor.Rows[ii]["c12"].ToString()+"'	" +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_6_kor = ESysLib.TableReadOpen(SQL6_kor);
	
	string SQL7_kor
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_4 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION<>'01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=978 " +
        ") " +
		"where  c12= '"+dt_kor.Rows[ii]["c12"].ToString()+"'	" +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_7_kor = ESysLib.TableReadOpen(SQL7_kor);
	
	string SQL8_kor
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_4 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION<>'01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=982 " +
        ") " +
		"where  c12= '"+dt_kor.Rows[ii]["c12"].ToString()+"'	" +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_8_kor = ESysLib.TableReadOpen(SQL8_kor);
	
	string SQL9_kor
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_4 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION<>'01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=981 " +
        ") " +
		"where  c12= '"+dt_kor.Rows[ii]["c12"].ToString()+"'	" +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_9_kor = ESysLib.TableReadOpen(SQL9_kor);
	
	string SQLmax_kor
	= "select max(cnt) max_cnt " + 
        "from " +
        "(select c10, count(*) cnt " +
        "from " +
        "(select c00, c01, c02, c03, c04 " +
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_4 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION<>'01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk " +
        ") " +
        ") " +
		"where  c12= '"+dt_kor.Rows[ii]["c12"].ToString()+"'	" +
        "group by c10 " +
        ") " ;
		//Response.Write(SQLmax);
        //Response.End();
		DataTable dt_max_kor = ESysLib.TableReadOpen(SQLmax_kor);
		
		int sum1_kor=0;
		for(int j=0;j<int.Parse(dt_max_kor.Rows[0]["max_cnt"].ToString());j++)
		{
 %>
 
 <tr class=xl75 height=57 style='mso-height-source:userset;height:42.75pt'>
  <% if(j==0)
		{%>
  <td height=57 rowspan="<%=int.Parse(dt_max_kor.Rows[0]["max_cnt"].ToString())%>" class=xl87 style='height:42.75pt;border-top:none' x:num></td>
  <td class=xl84 rowspan="<%=int.Parse(dt_max_kor.Rows[0]["max_cnt"].ToString())%>" width=54 style='border-top:none;border-left:none;width:41pt'
  x:str><%=dt_kor.Rows[ii]["c12"].ToString().Substring(4,dt_kor.Rows[ii]["c12"].ToString().Length-4)%><span style='mso-spacerun:yes'> </span></td>
  <%
		}%>
  <td class=xl85 style='border-top:none;border-left:none' x:str><%
	if(j<dt_1_kor.Rows.Count)
	{
		sum1_kor++;
		sum_kor[1]++;
  %><%=dt_1_kor.Rows[j]["c08"].ToString()%>
  <%}%></td>
  <td class=xl86 width=202 style='border-top:none;border-left:none;width:152pt'
  x:str>
  <%
	if(j<dt_1_kor.Rows.Count)
	{
  %>
  <%=dt_1_kor.Rows[j]["c01"].ToString()%><br>
    Email: <%=dt_1_kor.Rows[j]["c02"].ToString()%><br>
    Phone: <%=dt_1_kor.Rows[j]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_1_kor.Rows[j]["c04"].ToString()%><span
  style='mso-spacerun:yes'> </span>
  <%
	}
  %>
  </td>
  <td class=xl85 style='border-top:none;border-left:none' x:str><%
	if(j<dt_2_kor.Rows.Count)
	{
		sum1_kor++;	
		sum_kor[2]++;
  %><%=dt_2_kor.Rows[j]["c08"].ToString()%>
  <%}%></td>
  <td class=xl86 width=202 style='border-top:none;border-left:none;width:152pt'
  x:str><%
	if(j<dt_2_kor.Rows.Count)
	{
  %>
  <%=dt_2_kor.Rows[j]["c01"].ToString()%><br>
    Email: <%=dt_2_kor.Rows[j]["c02"].ToString()%><br>
    Phone: <%=dt_2_kor.Rows[j]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_2_kor.Rows[j]["c04"].ToString()%><span
  style='mso-spacerun:yes'> </span>
  <%
	}
  %>
  </td>
  <td class=xl85 style='border-top:none;border-left:none' x:str><%
	if(j<dt_3_kor.Rows.Count)
	{
		sum1_kor++;	
		sum_kor[3]++;
  %><%=dt_3_kor.Rows[j]["c08"].ToString()%>
  <%}%></td>
  <td class=xl86 width=202 style='border-top:none;border-left:none;width:152pt'
  x:str>
  <%
	if(j<dt_3_kor.Rows.Count)
	{
  %>
  <%=dt_3_kor.Rows[j]["c01"].ToString()%><br>
    Email: <%=dt_3_kor.Rows[j]["c02"].ToString()%><br>
    Phone: <%=dt_3_kor.Rows[j]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_3_kor.Rows[j]["c04"].ToString()%><span
  style='mso-spacerun:yes'> </span>
  <%
	}
  %>
  </td>
  <td class=xl85 style='border-top:none;border-left:none' x:str><%
	if(j<dt_4_kor.Rows.Count)
	{
		sum1_kor++;	
		sum_kor[4]++;
  %><%=dt_4_kor.Rows[j]["c08"].ToString()%>
  <%}%></td>
  <td class=xl86 width=202 style='border-top:none;border-left:none;width:152pt'
  x:str>
  <%
	if(j<dt_4_kor.Rows.Count)
	{
  %>
  <%=dt_4_kor.Rows[j]["c01"].ToString()%><br>
    Email: <%=dt_4_kor.Rows[j]["c02"].ToString()%><br>
    Phone: <%=dt_4_kor.Rows[j]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_4_kor.Rows[j]["c04"].ToString()%><span
  style='mso-spacerun:yes'> </span>
  <%
	}
  %>
  </td>
  <td class=xl85 style='border-top:none;border-left:none' x:str><%
	if(j<dt_5_kor.Rows.Count)
	{
		sum1_kor++;	
		sum_kor[5]++;
  %><%=dt_5_kor.Rows[j]["c08"].ToString()%>
  <%}%></td>
  <td class=xl86 width=202 style='border-top:none;border-left:none;width:152pt'
  x:str><%
	if(j<dt_5_kor.Rows.Count)
	{
  %>
  <%=dt_5_kor.Rows[j]["c01"].ToString()%><br>
    Email: <%=dt_5_kor.Rows[j]["c02"].ToString()%><br>
    Phone: <%=dt_5_kor.Rows[j]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_5_kor.Rows[j]["c04"].ToString()%><span
  style='mso-spacerun:yes'> </span>
  <%
	}
  %></td>
  <td class=xl85 style='border-top:none;border-left:none' x:str><%
	if(j<dt_6_kor.Rows.Count)
	{
		sum1_kor++;	
		sum_kor[6]++;
  %><%=dt_6_kor.Rows[j]["c08"].ToString()%>
  <%}%></td>
  <td class=xl86 width=202 style='border-top:none;border-left:none;width:152pt'
  x:str><%
	if(j<dt_6_kor.Rows.Count)
	{
  %>
  <%=dt_6_kor.Rows[j]["c01"].ToString()%><br>
    Email: <%=dt_6_kor.Rows[j]["c02"].ToString()%><br>
    Phone: <%=dt_6_kor.Rows[j]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_6_kor.Rows[j]["c04"].ToString()%><span
  style='mso-spacerun:yes'> </span>
  <%
	}
  %></td>
  <td class=xl85 style='border-top:none;border-left:none' x:str><%
	if(j<dt_7_kor.Rows.Count)
	{
		sum1_kor++;	
		sum_kor[7]++;
  %><%=dt_7_kor.Rows[j]["c08"].ToString()%>
  <%}%></td>
  <td class=xl86 width=202 style='border-top:none;border-left:none;width:152pt'
  x:str><%
	if(j<dt_7_kor.Rows.Count)
	{
  %>
  <%=dt_7_kor.Rows[j]["c01"].ToString()%><br>
    Email: <%=dt_7_kor.Rows[j]["c02"].ToString()%><br>
    Phone: <%=dt_7_kor.Rows[j]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_7_kor.Rows[j]["c04"].ToString()%><span
  style='mso-spacerun:yes'> </span>
  <%
	}
  %></td>
  <td class=xl85 style='border-top:none;border-left:none' x:str><%
	if(j<dt_8_kor.Rows.Count)
	{
		sum1_kor++;	
		sum_kor[8]++;
  %><%=dt_8_kor.Rows[j]["c08"].ToString()%>
  <%}%></td>
  <td class=xl86 width=202 style='border-top:none;border-left:none;width:152pt'
  x:str><%
	if(j<dt_8_kor.Rows.Count)
	{
  %>
  <%=dt_8_kor.Rows[j]["c01"].ToString()%><br>
    Email: <%=dt_8_kor.Rows[j]["c02"].ToString()%><br>
    Phone: <%=dt_8_kor.Rows[j]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_8_kor.Rows[j]["c04"].ToString()%><span
  style='mso-spacerun:yes'> </span>
  <%
	}
  %></td>
  <td class=xl85 style='border-top:none;border-left:none' x:str><%
	if(j<dt_9_kor.Rows.Count)
	{
		sum1_kor++;	
		sum_kor[9]++;
  %><%=dt_9_kor.Rows[j]["c08"].ToString()%>
  <%}%></td>
  <td class=xl86 width=202 style='border-top:none;border-left:none;width:152pt'
  x:str><%
	if(j<dt_9_kor.Rows.Count)
	{
  %>
  <%=dt_9_kor.Rows[j]["c01"].ToString()%><br>
    Email: <%=dt_9_kor.Rows[j]["c02"].ToString()%><br>
    Phone: <%=dt_9_kor.Rows[j]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_9_kor.Rows[j]["c04"].ToString()%><span
  style='mso-spacerun:yes'> </span>
  <%
	}
  %></td>
  
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=sum1_kor%></td>
  <td colspan=34 class=xl75 style='mso-ignore:colspan'></td>
 </tr>
 
 <%
		sum1_kor=0;
		}
	}
 %>
 <tr class=xl73 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl88 style='height:22.5pt;border-top:none'>&nbsp;</td>
  <td class=xl76 style='border-top:none;border-left:none' x:str="II"><span
  style='mso-spacerun:yes'> </span>II<span style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl90 width=404 style='border-left:none;width:304pt'><span
  style='mso-spacerun:yes'> </span>VIETNAMESE EMPLOYEES</td>
  <td class=xl90 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 width=202 style='border-top:none;border-left:none;width:152pt'>&nbsp;</td>
  <td class=xl90 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 width=202 style='border-top:none;border-left:none;width:152pt'>&nbsp;</td>
  <td class=xl90 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 width=202 style='border-top:none;border-left:none;width:152pt'>&nbsp;</td>
  <td class=xl90 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 width=202 style='border-top:none;border-left:none;width:152pt'>&nbsp;</td>
  <td class=xl90 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 width=202 style='border-top:none;border-left:none;width:152pt'>&nbsp;</td>
  <td class=xl90 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 width=202 style='border-top:none;border-left:none;width:152pt'>&nbsp;</td>
  <td class=xl90 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 width=202 style='border-top:none;border-left:none;width:152pt'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[1]["cnt_c13"].ToString()%></td>
  <td colspan=34 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <%
	int i=0;
	int []sum_vn=new int []{0,0,0,0,0,0,0,0,0,0};
	for(i=0;i<dt_vn.Rows.Count;i++)	
	{
		string SQL1
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_4 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION='01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=975 " +
        ") " +
		"where  c12= '"+dt_vn.Rows[i]["c12"].ToString()+"'	" +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_1 = ESysLib.TableReadOpen(SQL1);
    /*if (dt_1.Rows.Count == 0)
    {
        Response.Write("There is no data of working time");
        Response.End();
    }/**/
	//Response.Write(SQL1);
    //Response.End();
	string SQL2
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_4 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION='01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=974 " +
        ") " +
		"where  c12= '"+dt_vn.Rows[i]["c12"].ToString()+"'	" +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_2 = ESysLib.TableReadOpen(SQL2);
	
	string SQL3
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_4 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION='01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=976 " +
        ") " +
		"where  c12= '"+dt_vn.Rows[i]["c12"].ToString()+"'	" +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_3 = ESysLib.TableReadOpen(SQL3);
	
	string SQL4
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_4 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION='01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=977 " +
        ") " +
		"where  c12= '"+dt_vn.Rows[i]["c12"].ToString()+"'	" +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_4 = ESysLib.TableReadOpen(SQL4);
	
	string SQL5
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_4 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION='01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=979 " +
        ") " +
		"where  c12= '"+dt_vn.Rows[i]["c12"].ToString()+"'	" +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_5 = ESysLib.TableReadOpen(SQL5);
	
	string SQL6
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_4 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION='01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=980 " +
        ") " +
		"where  c12= '"+dt_vn.Rows[i]["c12"].ToString()+"'	" +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_6 = ESysLib.TableReadOpen(SQL6);
	
	string SQL7
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_4 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION='01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=978 " +
        ") " +
		"where  c12= '"+dt_vn.Rows[i]["c12"].ToString()+"'	" +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_7 = ESysLib.TableReadOpen(SQL7);
	
	string SQL8
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_4 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION='01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=982 " +
        ") " +
		"where  c12= '"+dt_vn.Rows[i]["c12"].ToString()+"'	" +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_8 = ESysLib.TableReadOpen(SQL8);
	
	string SQL9
	= "select c00, c01, c02, c03, c04 " + 
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_4 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION='01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk and g.pk=981 " +
        ") " +
		"where  c12= '"+dt_vn.Rows[i]["c12"].ToString()+"'	" +
        "order by c05,c06,c07,c08 " ;
		
	DataTable dt_9 = ESysLib.TableReadOpen(SQL9);
	
	string SQLmax
	= "select max(cnt) max_cnt " + 
        "from " +
        "(select c10, count(*) cnt " +
        "from " +
        "(select c00, c01, c02, c03, c04 " +
        "        , c05, c06, c07, c08, c09 " +
        "        , c10, c11, c12 " +
        "from " +
        "(select E.EMP_ID c00, E.FULL_NAME c01, E.EMAIL c02, E.TEL c03, substr(E.OFFICE_NUMBER,-3) c04 " +
        "        , nvl(G.SEQ,0) c05 " +
        "        , (select num_2 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c06 " +
        "        , E.JOIN_DT c07 " +
        "        , E.EMP_ID c08 " +
        "        , g.pk c09 " +
        "        , G.ORG_NM c10 " +
        "        , G.ORG_ID c11     " +
        "        , (select char_4 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c12     " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and E.NATION='01' " +
        "and E.STATUS='A' " +
        "and E.POS_TYPE is not null " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk " +
        ") " +
        ") " +
		"where  c12= '"+dt_vn.Rows[i]["c12"].ToString()+"'	" +
        "group by c10 " +
        ") " ;
		//Response.Write(SQLmax);
        //Response.End();
		DataTable dt_max = ESysLib.TableReadOpen(SQLmax);
		int sum1_vn=0;
		for(int j=0;j<int.Parse(dt_max.Rows[0]["max_cnt"].ToString());j++)
		{
 %>
 <tr class=xl75 height=57 style='mso-height-source:userset;height:42.75pt'>
	<% if(j==0)
		{%>
  <td height=57 rowspan="<%=int.Parse(dt_max.Rows[0]["max_cnt"].ToString())%>" class=xl87 style='height:42.75pt;border-top:none' x:num></td>
  <td class=xl84 rowspan="<%=int.Parse(dt_max.Rows[0]["max_cnt"].ToString())%>" width=54 style='border-top:none;border-left:none;width:41pt'
  x:str><%=dt_vn.Rows[i]["c12"].ToString().Substring(4,dt_vn.Rows[i]["c12"].ToString().Length-4)%><span style='mso-spacerun:yes'> </span></td>
  <%
		}%>
  <td class=xl85 style='border-top:none;border-left:none' x:str><%
	if(j<dt_1.Rows.Count)
	{
		sum1_vn++;
		sum_vn[1]++;
  %><%=dt_1.Rows[j]["c08"].ToString()%>
  <%}%></td>
  <td class=xl86 width=202 style='border-top:none;border-left:none;width:152pt'
  x:str>
  <%
	if(j<dt_1.Rows.Count)
	{
  %>
  <%=dt_1.Rows[j]["c01"].ToString()%><br>
    Email: <%=dt_1.Rows[j]["c02"].ToString()%><br>
    Phone: <%=dt_1.Rows[j]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_1.Rows[j]["c04"].ToString()%><span
  style='mso-spacerun:yes'> </span>
  <%
	}
  %>
  </td>
  <td class=xl85 style='border-top:none;border-left:none' x:str><%
	if(j<dt_2.Rows.Count)
	{
		sum1_vn++;
		sum_vn[2]++;
  %><%=dt_2.Rows[j]["c08"].ToString()%>
  <%}%></td>
  <td class=xl86 width=202 style='border-top:none;border-left:none;width:152pt'
  x:str><%
	if(j<dt_2.Rows.Count)
	{
  %>
  <%=dt_2.Rows[j]["c01"].ToString()%><br>
    Email: <%=dt_2.Rows[j]["c02"].ToString()%><br>
    Phone: <%=dt_2.Rows[j]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_2.Rows[j]["c04"].ToString()%><span
  style='mso-spacerun:yes'> </span>
  <%
	}
  %>
  </td>
  <td class=xl85 style='border-top:none;border-left:none' x:str><%
	if(j<dt_3.Rows.Count)
	{
		sum1_vn++;
		sum_vn[3]++;
  %><%=dt_3.Rows[j]["c08"].ToString()%>
  <%}%></td>
  <td class=xl86 width=202 style='border-top:none;border-left:none;width:152pt'
  x:str>
  <%
	if(j<dt_3.Rows.Count)
	{
  %>
  <%=dt_3.Rows[j]["c01"].ToString()%><br>
    Email: <%=dt_3.Rows[j]["c02"].ToString()%><br>
    Phone: <%=dt_3.Rows[j]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_3.Rows[j]["c04"].ToString()%><span
  style='mso-spacerun:yes'> </span>
  <%
	}
  %>
  </td>
  <td class=xl85 style='border-top:none;border-left:none' x:str><%
	if(j<dt_4.Rows.Count)
	{
		sum1_vn++;
		sum_vn[4]++;
  %><%=dt_4.Rows[j]["c08"].ToString()%>
  <%}%></td>
  <td class=xl86 width=202 style='border-top:none;border-left:none;width:152pt'
  x:str>
  <%
	if(j<dt_4.Rows.Count)
	{
  %>
  <%=dt_4.Rows[j]["c01"].ToString()%><br>
    Email: <%=dt_4.Rows[j]["c02"].ToString()%><br>
    Phone: <%=dt_4.Rows[j]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_4.Rows[j]["c04"].ToString()%><span
  style='mso-spacerun:yes'> </span>
  <%
	}
  %>
  </td>
  <td class=xl85 style='border-top:none;border-left:none' x:str><%
	if(j<dt_5.Rows.Count)
	{
		sum1_vn++;
		sum_vn[5]++;
  %><%=dt_5.Rows[j]["c08"].ToString()%>
  <%}%></td>
  <td class=xl86 width=202 style='border-top:none;border-left:none;width:152pt'
  x:str><%
	if(j<dt_5.Rows.Count)
	{
  %>
  <%=dt_5.Rows[j]["c01"].ToString()%><br>
    Email: <%=dt_5.Rows[j]["c02"].ToString()%><br>
    Phone: <%=dt_5.Rows[j]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_5.Rows[j]["c04"].ToString()%><span
  style='mso-spacerun:yes'> </span>
  <%
	}
  %></td>
  <td class=xl85 style='border-top:none;border-left:none' x:str><%
	if(j<dt_6.Rows.Count)
	{
		sum1_vn++;
		sum_vn[6]++;
  %><%=dt_6.Rows[j]["c08"].ToString()%>
  <%}%></td>
  <td class=xl86 width=202 style='border-top:none;border-left:none;width:152pt'
  x:str><%
	if(j<dt_6.Rows.Count)
	{
  %>
  <%=dt_6.Rows[j]["c01"].ToString()%><br>
    Email: <%=dt_6.Rows[j]["c02"].ToString()%><br>
    Phone: <%=dt_6.Rows[j]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_6.Rows[j]["c04"].ToString()%><span
  style='mso-spacerun:yes'> </span>
  <%
	}
  %></td>
  <td class=xl85 style='border-top:none;border-left:none' x:str><%
	if(j<dt_7.Rows.Count)
	{
		sum1_vn++;
		sum_vn[7]++;
  %><%=dt_7.Rows[j]["c08"].ToString()%>
  <%}%></td>
  <td class=xl86 width=202 style='border-top:none;border-left:none;width:152pt'
  x:str><%
	if(j<dt_7.Rows.Count)
	{
  %>
  <%=dt_7.Rows[j]["c01"].ToString()%><br>
    Email: <%=dt_7.Rows[j]["c02"].ToString()%><br>
    Phone: <%=dt_7.Rows[j]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_7.Rows[j]["c04"].ToString()%><span
  style='mso-spacerun:yes'> </span>
  <%
	}
  %></td>
  <td class=xl85 style='border-top:none;border-left:none' x:str><%
	if(j<dt_8.Rows.Count)
	{
		sum1_vn++;
		sum_vn[8]++;
  %><%=dt_8.Rows[j]["c08"].ToString()%>
  <%}%></td>
  <td class=xl86 width=202 style='border-top:none;border-left:none;width:152pt'
  x:str><%
	if(j<dt_8.Rows.Count)
	{
  %>
  <%=dt_8.Rows[j]["c01"].ToString()%><br>
    Email: <%=dt_8.Rows[j]["c02"].ToString()%><br>
    Phone: <%=dt_8.Rows[j]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_8.Rows[j]["c04"].ToString()%><span
  style='mso-spacerun:yes'> </span>
  <%
	}
  %></td>
  <td class=xl85 style='border-top:none;border-left:none' x:str><%
	if(j<dt_9.Rows.Count)
	{
		sum1_vn++;
		sum_vn[9]++;
  %><%=dt_9.Rows[j]["c08"].ToString()%>
  <%}%></td>
  <td class=xl86 width=202 style='border-top:none;border-left:none;width:152pt'
  x:str><%
	if(j<dt_9.Rows.Count)
	{
  %>
  <%=dt_9.Rows[j]["c01"].ToString()%><br>
    Email: <%=dt_9.Rows[j]["c02"].ToString()%><br>
    Phone: <%=dt_9.Rows[j]["c03"].ToString()%><span style='mso-spacerun:yes'>            
  </span>/<span style='mso-spacerun:yes'>      </span><%=dt_9.Rows[j]["c04"].ToString()%><span
  style='mso-spacerun:yes'> </span>
  <%
	}
  %></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=sum1_vn%></td>
  <td colspan=34 class=xl75 style='mso-ignore:colspan'></td>
 </tr>
 
 <%
		sum1_vn=0;
		}
	}
 %>

 <tr class=xl77 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl89 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl78 width=54 style='border-top:none;border-left:none;width:41pt'
  x:str="Total:"><span style='mso-spacerun:yes'> </span>Total:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl100 align=right style='border-top:none;border-left:none' x:num><%=sum_kor[1]+sum_vn[1]%></td>
  <td class=xl82 style='border-top:none;border-left:none' x:num><%=sum_kor[1]+sum_vn[1]%></td>
  <td class=xl82 style='border-top:none;border-left:none' x:num><%=sum_kor[2]+sum_vn[2]%></td>
  <td class=xl82 style='border-top:none;border-left:none' x:num><%=sum_kor[2]+sum_vn[2]%></td>
  <td class=xl82 style='border-top:none;border-left:none' x:num><%=sum_kor[3]+sum_vn[3]%></td>
  <td class=xl82 style='border-top:none;border-left:none' x:num><%=sum_kor[3]+sum_vn[3]%></td>
  <td class=xl82 style='border-top:none;border-left:none' x:num><%=sum_kor[4]+sum_vn[4]%></td>
  <td class=xl82 style='border-top:none;border-left:none' x:num><%=sum_kor[4]+sum_vn[4]%></td>
  <td class=xl82 style='border-top:none;border-left:none' x:num><%=sum_kor[5]+sum_vn[5]%></td>
  <td class=xl82 style='border-top:none;border-left:none' x:num><%=sum_kor[5]+sum_vn[5]%></td>
  <td class=xl82 style='border-top:none;border-left:none' x:num><%=sum_kor[6]+sum_vn[6]%></td>
  <td class=xl82 style='border-top:none;border-left:none' x:num><%=sum_kor[6]+sum_vn[6]%></td>
  <td class=xl82 style='border-top:none;border-left:none' x:num><%=sum_kor[7]+sum_vn[7]%></td>
  <td class=xl82 style='border-top:none;border-left:none' x:num><%=sum_kor[7]+sum_vn[7]%></td>
  <td class=xl82 style='border-top:none;border-left:none' x:num><%=sum_kor[8]+sum_vn[8]%></td>
  <td class=xl82 style='border-top:none;border-left:none' x:num><%=sum_kor[8]+sum_vn[8]%></td>
  <td class=xl82 style='border-top:none;border-left:none' x:num><%=sum_kor[9]+sum_vn[9]%></td>
  <td class=xl82 style='border-top:none;border-left:none' x:num><%=sum_kor[9]+sum_vn[9]%></td>
  <td class=xl79 style='border-top:none;border-left:none' x:num>
  <%=sum_kor[1]+sum_vn[1]+sum_kor[2]+sum_vn[2]+sum_kor[3]+sum_vn[3]+sum_kor[4]+sum_vn[4]+sum_kor[5]+sum_vn[5]+sum_kor[6]+sum_vn[6]+sum_kor[7]+sum_vn[7]+sum_kor[8]+sum_vn[8]+sum_kor[9]+sum_vn[9]%>
  </td>
  <td colspan=34 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 style='height:18.75pt'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl67 colspan=3 style='mso-ignore:colspan'
  x:str="(*) General Director is counted in P &amp; F Dept."><span
  style='mso-spacerun:yes'> </span>(*) General Director is counted in P &amp; F
  Dept.<span style='mso-spacerun:yes'> </span></td>
  <td></td>
  <td class=xl67></td>
  <td></td>
  <td class=xl67></td>
  <td></td>
  <td class=xl67></td>
  <td></td>
  <td class=xl67></td>
  <td></td>
  <td class=xl67></td>
  <td></td>
  <td class=xl67></td>
  <td></td>
  <td class=xl67></td>
  <td class=xl80></td>
  <td class=xl81></td>
  <td colspan=33 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  
 </tr>
 <![endif]>
</table>

</body>

</html>
