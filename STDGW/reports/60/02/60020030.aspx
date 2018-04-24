<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_contract_no = Request["p_contract_no"];
    string p_tac_abplcenter_pk = Request["tac_abplcenter_pk"];
    string p_tco_buspartner_pk = Request["tco_buspartner_pk"];
    string p_from =  Request["from"];
    string p_to = Request["to"];
    string p_company = Request["company"];
    
    string l_parameter = "'" + p_contract_no + "', ";
    l_parameter += "'" + p_tac_abplcenter_pk + "', ";
    l_parameter += "'" + p_tco_buspartner_pk + "', ";
    l_parameter += "'" + p_from + "', ";
    l_parameter += "'" + p_to + "', ";
    l_parameter += "'" + p_company + "' ";

    string l_taxcode = "";
    string l_compa = "";
    string l_address = "";

    string SQL1 = " SELECT PARTNER_NAME,ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + p_company + "' ";
    DataTable dt_f = ESysLib.TableReadOpen(SQL1);
    if (dt_f.Rows.Count > 0)
    {
        l_compa = dt_f.Rows[0][0].ToString();
        l_address = dt_f.Rows[0][1].ToString();
        l_taxcode = dt_f.Rows[0][3].ToString();
    }
    
    DataTable dt = ESysLib.TableReadOpenCursor("AC_RPT_60020030_REPORT", l_parameter);
    //Response.Write(dt.Rows.Count.ToString());
    //Response.End();f
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data!!");
        Response.End();
    }
    string l_book_ccy = "";
    String p_xls_ccy_format = "";
    String p_xls_ccy_format_usd = "";
    if (l_book_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }

%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Book1_files/filelist.xml">
<link rel=Edit-Time-Data href="Book1_files/editdata.mso">
<link rel=OLE-Object-Data href="Book1_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr Long</o:Author>
  <o:LastAuthor>Mr Long</o:LastAuthor>
  <o:LastPrinted>2010-05-19T03:24:13Z</o:LastPrinted>
  <o:Created>2010-05-19T02:33:34Z</o:Created>
  <o:LastSaved>2010-05-19T03:30:25Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .25in .5in .5in;
	mso-header-margin:.5in;
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
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
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
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
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
.xl39
	{mso-style-parent:style0;
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
.xl40
	{mso-style-parent:style0;
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
.xl41
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
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
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
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
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>18</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7275</x:WindowHeight>
  <x:WindowWidth>19035</x:WindowWidth>
  <x:WindowTopX>-45</x:WindowTopX>
  <x:WindowTopY>3165</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$A$4:$Z$5</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1050"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2965 style='border-collapse:
 collapse;table-layout:fixed;width:2230pt'>
 <col class=xl24 width=138 style='mso-width-source:userset;mso-width-alt:5046;
 width:104pt'>
 <col class=xl24 width=266 style='mso-width-source:userset;mso-width-alt:9728;
 width:200pt'>
 <col class=xl24 width=137 style='mso-width-source:userset;mso-width-alt:5010;
 width:103pt'>
 <col class=xl24 width=111 style='mso-width-source:userset;mso-width-alt:4059;
 width:83pt'>
 <col class=xl24 width=274 style='mso-width-source:userset;mso-width-alt:10020;
 width:206pt'>
 <col class=xl24 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl24 width=84 style='mso-width-source:userset;mso-width-alt:3072;
 width:63pt'>
 <col class=xl24 width=112 style='mso-width-source:userset;mso-width-alt:4096;
 width:84pt'>
 <col class=xl24 width=113 style='mso-width-source:userset;mso-width-alt:4132;
 width:85pt'>
 <col class=xl24 width=105 style='mso-width-source:userset;mso-width-alt:3840;
 width:79pt'>
 <col class=xl24 width=98 style='mso-width-source:userset;mso-width-alt:3584;
 width:74pt'>
 <col class=xl24 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl24 width=117 style='mso-width-source:userset;mso-width-alt:4278;
 width:88pt'>
 <col class=xl24 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl24 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl24 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl24 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl24 width=105 style='mso-width-source:userset;mso-width-alt:3840;
 width:79pt'>
 <col class=xl24 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl24 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl24 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl24 width=98 style='mso-width-source:userset;mso-width-alt:3584;
 width:74pt'>
 <col class=xl24 width=105 style='mso-width-source:userset;mso-width-alt:3840;
 width:79pt'>
 <col class=xl24 width=234 style='mso-width-source:userset;mso-width-alt:8557;
 width:176pt'>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=8 height=26 class=xl33 width=1194 style='height:19.5pt;
  width:897pt'><!--[if gte vml 1]><v:shapetype id="_x0000_t201" coordsize="21600,21600"
   o:spt="201" path="m,l,21600r21600,l21600,xe">
   <v:stroke joinstyle="miter"/>
   <v:path shadowok="f" o:extrusionok="f" strokeok="f" fillok="f"
    o:connecttype="rect"/>
   <o:lock v:ext="edit" shapetype="t"/>
  </v:shapetype><v:shape id="_x0000_s1044" type="#_x0000_t201" style='position:absolute;
   margin-left:0;margin-top:0;width:895.5pt;height:19.5pt;z-index:1;
   visibility:hidden' stroked="f" o:insetmode="auto">
   <o:lock v:ext="edit" rotation="t" text="t"/>
   <![if excel]><x:ClientData ObjectType="Drop">
    <x:MoveWithCells/>
    <x:SizeWithCells/>
    <x:PrintObject>False</x:PrintObject>
    <x:UIObj/>
    <x:AutoLine>False</x:AutoLine>
    <x:Val>0</x:Val>
    <x:Min>0</x:Min>
    <x:Max>0</x:Max>
    <x:Inc>1</x:Inc>
    <x:Page>10</x:Page>
    <x:Dx>16</x:Dx>
    <x:Sel>0</x:Sel>
    <x:SelType>Single</x:SelType>
    <x:LCT>Normal</x:LCT>
    <x:DropStyle>Simple</x:DropStyle>
    <x:DropLines>8</x:DropLines>
    <x:WidthMin>108</x:WidthMin>
   </x:ClientData>
   <![endif]></v:shape><v:shape id="_x0000_s1045" type="#_x0000_t201" style='position:absolute;
   margin-left:0;margin-top:0;width:895.5pt;height:19.5pt;z-index:2;
   visibility:hidden' stroked="f" o:insetmode="auto">
   <o:lock v:ext="edit" rotation="t" text="t"/>
   <![if excel]><x:ClientData ObjectType="Drop">
    <x:MoveWithCells/>
    <x:SizeWithCells/>
    <x:PrintObject>False</x:PrintObject>
    <x:UIObj/>
    <x:AutoLine>False</x:AutoLine>
    <x:Val>0</x:Val>
    <x:Min>0</x:Min>
    <x:Max>0</x:Max>
    <x:Inc>1</x:Inc>
    <x:Page>10</x:Page>
    <x:Dx>16</x:Dx>
    <x:Sel>0</x:Sel>
    <x:SelType>Single</x:SelType>
    <x:LCT>Normal</x:LCT>
    <x:DropStyle>Simple</x:DropStyle>
    <x:DropLines>8</x:DropLines>
    <x:WidthMin>108</x:WidthMin>
   </x:ClientData>
   <![endif]></v:shape><v:shape id="_x0000_s1046" type="#_x0000_t201" style='position:absolute;
   margin-left:0;margin-top:0;width:895.5pt;height:19.5pt;z-index:3;
   visibility:hidden' stroked="f" o:insetmode="auto">
   <o:lock v:ext="edit" rotation="t" text="t"/>
   <![if excel]><x:ClientData ObjectType="Drop">
    <x:MoveWithCells/>
    <x:SizeWithCells/>
    <x:PrintObject>False</x:PrintObject>
    <x:UIObj/>
    <x:AutoLine>False</x:AutoLine>
    <x:Val>0</x:Val>
    <x:Min>0</x:Min>
    <x:Max>0</x:Max>
    <x:Inc>1</x:Inc>
    <x:Page>10</x:Page>
    <x:Dx>16</x:Dx>
    <x:Sel>0</x:Sel>
    <x:SelType>Single</x:SelType>
    <x:LCT>Normal</x:LCT>
    <x:DropStyle>Simple</x:DropStyle>
    <x:DropLines>8</x:DropLines>
    <x:WidthMin>108</x:WidthMin>
   </x:ClientData>
   <![endif]></v:shape><v:shape id="_x0000_s1047" type="#_x0000_t201" style='position:absolute;
   margin-left:0;margin-top:0;width:895.5pt;height:19.5pt;z-index:4;
   visibility:hidden' stroked="f" o:insetmode="auto">
   <o:lock v:ext="edit" rotation="t" text="t"/>
   <![if excel]><x:ClientData ObjectType="Drop">
    <x:MoveWithCells/>
    <x:SizeWithCells/>
    <x:PrintObject>False</x:PrintObject>
    <x:UIObj/>
    <x:AutoLine>False</x:AutoLine>
    <x:Val>0</x:Val>
    <x:Min>0</x:Min>
    <x:Max>0</x:Max>
    <x:Inc>1</x:Inc>
    <x:Page>10</x:Page>
    <x:Dx>16</x:Dx>
    <x:Sel>0</x:Sel>
    <x:SelType>Single</x:SelType>
    <x:LCT>Normal</x:LCT>
    <x:DropStyle>Simple</x:DropStyle>
    <x:DropLines>8</x:DropLines>
    <x:WidthMin>108</x:WidthMin>
   </x:ClientData>
   <![endif]></v:shape><v:shape id="_x0000_s1048" type="#_x0000_t201" style='position:absolute;
   margin-left:0;margin-top:0;width:895.5pt;height:19.5pt;z-index:5;
   visibility:hidden' stroked="f" o:insetmode="auto">
   <o:lock v:ext="edit" rotation="t" text="t"/>
   <![if excel]><x:ClientData ObjectType="Drop">
    <x:MoveWithCells/>
    <x:SizeWithCells/>
    <x:PrintObject>False</x:PrintObject>
    <x:UIObj/>
    <x:AutoLine>False</x:AutoLine>
    <x:Val>0</x:Val>
    <x:Min>0</x:Min>
    <x:Max>0</x:Max>
    <x:Inc>1</x:Inc>
    <x:Page>10</x:Page>
    <x:Dx>16</x:Dx>
    <x:Sel>0</x:Sel>
    <x:SelType>Single</x:SelType>
    <x:LCT>Normal</x:LCT>
    <x:DropStyle>Simple</x:DropStyle>
    <x:DropLines>8</x:DropLines>
    <x:WidthMin>108</x:WidthMin>
   </x:ClientData>
   <![endif]></v:shape><v:shape id="_x0000_s1049" type="#_x0000_t201" style='position:absolute;
   margin-left:0;margin-top:0;width:895.5pt;height:19.5pt;z-index:6;
   visibility:hidden' stroked="f" o:insetmode="auto">
   <o:lock v:ext="edit" rotation="t" text="t"/>
   <![if excel]><x:ClientData ObjectType="Drop">
    <x:MoveWithCells/>
    <x:SizeWithCells/>
    <x:PrintObject>False</x:PrintObject>
    <x:UIObj/>
    <x:AutoLine>False</x:AutoLine>
    <x:Val>0</x:Val>
    <x:Min>0</x:Min>
    <x:Max>0</x:Max>
    <x:Inc>1</x:Inc>
    <x:Page>10</x:Page>
    <x:Dx>16</x:Dx>
    <x:Sel>0</x:Sel>
    <x:SelType>Single</x:SelType>
    <x:LCT>Normal</x:LCT>
    <x:DropStyle>Simple</x:DropStyle>
    <x:DropLines>8</x:DropLines>
    <x:WidthMin>108</x:WidthMin>
   </x:ClientData>
   <![endif]></v:shape><![endif]--><%=l_compa%></td>
  <td class=xl24 width=113 style='width:85pt'></td>
  <td class=xl24 width=105 style='width:79pt'></td>
  <td class=xl24 width=98 style='width:74pt'></td>
  <td class=xl24 width=100 style='width:75pt'></td>
  <td class=xl24 width=117 style='width:88pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=81 style='width:61pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=86 style='width:65pt'></td>
  <td class=xl24 width=105 style='width:79pt'></td>
  <td class=xl24 width=69 style='width:52pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=81 style='width:61pt'></td>
  <td class=xl24 width=78 style='width:59pt'></td>
  <td class=xl24 width=76 style='width:57pt'></td>
  <td class=xl24 width=98 style='width:74pt'></td>
  <td class=xl24 width=105 style='width:79pt'></td>
  <td class=xl24 width=234 style='width:176pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=8 height=20 class=xl34 style='height:15.0pt'><%=l_address%></td>
  <td colspan=18 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=26 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td rowspan=2 height=35 class=xl35 id="_x0000_s1025" x:autofilter="all"
  x:autofilterrange="$A$4:$Z$5" width=138 style='border-bottom:.5pt solid black;
  height:26.25pt;width:104pt'>SUBCONTRACTOR CODE</td>
  <td rowspan=2 class=xl35 id="_x0000_s1026" x:autofilter="all" width=266
  style='border-bottom:.5pt solid black;width:200pt'>NAME OF <br>
    SUBCONTRACTOR</td>
  <td rowspan=2 class=xl35 id="_x0000_s1027" x:autofilter="all" width=137
  style='border-bottom:.5pt solid black;width:103pt'>NO OF CONTRACT</td>
  <td rowspan=2 class=xl35 id="_x0000_s1028" x:autofilter="all" width=111
  style='border-bottom:.5pt solid black;width:83pt'>PROJECT CODE</td>
  <td rowspan=2 class=xl35 id="_x0000_s1029" x:autofilter="all" width=274
  style='border-bottom:.5pt solid black;width:206pt'>PROJECT</td>
  <td rowspan=2 class=xl35 id="_x0000_s1030" x:autofilter="all" width=72
  style='border-bottom:.5pt solid black;width:54pt'>DATE</td>
  <td rowspan=2 class=xl35 id="_x0000_s1031" x:autofilter="all" width=84
  style='border-bottom:.5pt solid black;width:63pt'>QUANTITY</td>
  <td rowspan=2 class=xl35 id="_x0000_s1032" x:autofilter="all" width=112
  style='border-bottom:.5pt solid black;width:84pt'>PRICE<br>
    (NET)</td>
  <td rowspan=2 class=xl35 id="_x0000_s1033" x:autofilter="all" width=113
  style='border-bottom:.5pt solid black;width:85pt'>VAT</td>
  <td rowspan=2 class=xl35 id="_x0000_s1034" x:autofilter="all" width=105
  style='border-bottom:.5pt solid black;width:79pt'>AMOUNT</td>
  <td rowspan=2 class=xl35 id="_x0000_s1035" x:autofilter="all" width=98
  style='border-bottom:.5pt solid black;width:74pt'>ADJUST</td>
  <td rowspan=2 class=xl35 id="_x0000_s1036" x:autofilter="all" width=100
  style='border-bottom:.5pt solid black;width:75pt'>VAT<br>
    ADJUST</td>
  <td rowspan=2 class=xl35 id="_x0000_s1037" x:autofilter="all" width=117
  style='border-bottom:.5pt solid black;width:88pt'>FINAL AMOUNT</td>
  <td colspan=4 class=xl38 id="_x0000_s1038" x:autofilter="all"
  style='border-right:.5pt solid black;border-left:none'>CODITION OF CONT (%)</td>
  <td rowspan=2 class=xl35 id="_x0000_s1039" x:autofilter="all" width=105
  style='border-bottom:.5pt solid black;width:79pt'>PERIOD OF<br>
    CONTRACT</td>
  <td rowspan=2 class=xl35 id="_x0000_s1040" x:autofilter="all" width=69
  style='border-bottom:.5pt solid black;width:52pt'>RATE</td>
  <td rowspan=2 class=xl35 id="_x0000_s1041" x:autofilter="all" width=64
  style='border-bottom:.5pt solid black;width:48pt'>UNIT</td>
  <td colspan=5 class=xl38 id="_x0000_s1042" x:autofilter="all"
  style='border-right:.5pt solid black;border-left:none'>SYSTEM</td>
  <td rowspan=2 class=xl40 id="_x0000_s1043" x:autofilter="all"
  style='border-bottom:.5pt solid black'>REMARK</td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl25 style='height:13.5pt'>ADVANCE</td>
  <td class=xl25>PROGRESS</td>
  <td class=xl25>RETENTION</td>
  <td class=xl25>GUARANTEE</td>
  <td class=xl25>Advance Amt</td>
  <td class=xl25>Payable</td>
  <td class=xl25>Payment</td>
  <td class=xl25>Payable Remain</td>
  <td class=xl25>Payment Remain</td>
 </tr>
  <%
      decimal payment_remain = 0;
      decimal final_amt = 0;
      decimal payment_II = 0;
      decimal payment_III = 0;
      decimal payable_remain = 0;
      decimal amount = 0;
     for (int i = 0; i < dt.Rows.Count; i++)
     {
         if (dt.Rows[i][12].ToString().Trim() != "")
         {
             final_amt = decimal.Parse(dt.Rows[i][12].ToString());
         }
         else
         {
             final_amt = 0;
         }

         if (dt.Rows[i][22].ToString().Trim() !="")
         {
             payment_II = decimal.Parse(dt.Rows[i][22].ToString());
         }
         else
         {
             payment_II = 0;
         }

         if (dt.Rows[i][23].ToString().Trim() != "")
         {
             payment_III = decimal.Parse(dt.Rows[i][23].ToString());
         }
         else
         {
             payment_III = 0;
         }

         if (dt.Rows[i][21].ToString().Trim() != "")
         {
             amount = decimal.Parse(dt.Rows[i][21].ToString());
         }
         else
         {
             amount = 0;
         }

         
         payment_remain = final_amt - payment_II + payment_III;
         payable_remain = final_amt - amount;
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 style='height:12.75pt'><%=dt.Rows[i][0]%></td>
  <td class=xl27><%=dt.Rows[i][1]%></td>
  <td class=xl27><%=dt.Rows[i][2]%></td>
  <td class=xl27><%=dt.Rows[i][3]%></td>
  <td class=xl27><%=dt.Rows[i][4]%></td>
  <td class=xl28 x:num><%=dt.Rows[i][5]%></td>
  <td class=xl29 x:num><%=dt.Rows[i][6]%></td>
  <td class=xl29 x:num><%=dt.Rows[i][7]%></td>
  <td class=xl29 x:num><%=dt.Rows[i][8]%></td>
  <td class=xl29 x:num><%=dt.Rows[i][9]%></td>
  <td class=xl29 x:num><%=dt.Rows[i][10]%></td>
  <td class=xl29 x:num><%=dt.Rows[i][11]%></td>
  <td class=xl29 x:num><%=dt.Rows[i][12]%></td>
  <td class=xl29 x:num><%=dt.Rows[i][13]%></td>
  <td class=xl29 x:num><%=dt.Rows[i][14]%></td>
  <td class=xl29 x:num><%=dt.Rows[i][15]%></td>
  <td class=xl29 x:num><%=dt.Rows[i][16]%></td>
  <td class=xl28 x:num><%=dt.Rows[i][17]%></td>
  <td class=xl29 x:num><%=dt.Rows[i][18]%></td>
  <td class=xl30><%=dt.Rows[i][19]%></td>
  <td class=xl29 x:num><%=dt.Rows[i][20]%></td>
  <td class=xl29 x:num><%=dt.Rows[i][21]%></td>
  <td class=xl29 x:num><%=dt.Rows[i][22]%></td>
  <td class=xl29 x:num><%=payable_remain%></td>
  <td class=xl29 x:num><%=payment_remain%></td>
  <td class=xl27><%=dt.Rows[i][24]%></td>
 </tr>
 <%} %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt'>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=138 style='width:104pt'></td>
  <td width=266 style='width:200pt'></td>
  <td width=137 style='width:103pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=274 style='width:206pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=112 style='width:84pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=234 style='width:176pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
