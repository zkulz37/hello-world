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
    
        
    string l_company = ""+ Request["Company"];
    string l_date_from = ""+ Request["DateFrom"];
    string l_date_to = ""+ Request["DateTo"];
    string l_Status = "" + Request["Status"];
    string l_voucher = ""+ Request["Voucher"];
    string l_Seq = ""+ Request["Seq"];
    string l_lang = ""+ Request["lang"];

    string l_parameter = "'" + l_company + "', ";
    l_parameter += "'" + l_date_from + "', ";
    l_parameter += "'" + l_date_to + "', ";
    l_parameter += "'" + l_Status + "', ";
    l_parameter += "'" + l_voucher + "', ";
    l_parameter += "'" + l_Seq + "', ";
    l_parameter += "'" + l_lang + "' ";


    string l_compa = "", l_address = "";

    string l_crt_by = "";
    string l_total_debit = ""; 
    string l_total_credit = "";
    
    string l_date_fr2 = "";
    string l_date_to2 = "";
    string l_report_dd = "";
    string l_report_mm = "";
    string l_report_yy = "";
    string l_total_book_amt = Request["p_dramt"];
    string l_taxcode = "";
    
   
    
    
    
//---------------------------------------------------------------------------------    
    string l_ccy = Request["p_ccy"];
    
    string p_xls_ccy_format = "";
    string sql2 = "SELECT ACNT.SF_A_GET_DEFAULT('ACBG0040') FROM DUAL ";

    DataTable dt_bccy = ESysLib.TableReadOpen(sql2);
    if (dt_bccy.Rows.Count > 0)
    {
        l_ccy = dt_bccy.Rows[0][0].ToString();
    }
    if (l_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
//-----------------------------------------------------------------------------------------------
    string SQL1 = " SELECT PARTNER_NAME,ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + l_company + "' ";
	
    
    DataTable dt_f = ESysLib.TableReadOpen(SQL1);
    if (dt_f.Rows.Count > 0)
    {
        l_compa = dt_f.Rows[0][0].ToString();
        l_address = dt_f.Rows[0][1].ToString();
        l_taxcode = dt_f.Rows[0][3].ToString();
    }
//-----------------------------------------------------------------------------------------------------
   string SQL = " SELECT TO_CHAR(TO_DATE('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') DT_FR,  TO_CHAR(TO_DATE('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') DT_TO, ";
    SQL = SQL + "acnt.sf_get_format('ACBG0040'), TO_CHAR(LAST_DAY(TO_DATE('" + l_date_to + "','YYYYMMDD')),'DD')  RP_DD,";
    SQL = SQL + " TO_CHAR(LAST_DAY(TO_DATE('" + l_date_to + "','YYYYMMDD')),'MM')  RP_MM, ";
    SQL = SQL + " TO_CHAR(LAST_DAY(TO_DATE('" + l_date_to + "','YYYYMMDD')),'YYYY')  RP_YY, ";
    SQL = SQL + " SF_GET_FORMAT ('ACRP0010') ";
    SQL = SQL + " FROM DUAL ";

   DataTable dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count > 0)
    {
        l_date_fr2 = dt.Rows[0][0].ToString();
        l_date_to2 = dt.Rows[0][1].ToString();
        
        l_report_dd = dt.Rows[0][3].ToString();
        l_report_mm = dt.Rows[0][4].ToString();
        l_report_yy = dt.Rows[0][5].ToString();
        
    }
//-------------------------------------------------------------------------------------------------


    DataTable dt_detail = ESysLib.TableReadOpenCursor("ACNT.sp_sel_daily_nkcnb", l_parameter);

    //Response.Write(dt_detail.Rows.Count.ToString());
    //Response.End();
    if (dt_detail.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
//-------------------------------------------------------------------------------------------------
    
//-----------------------------------------------------------------------------------------------------    
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="fwef_files/filelist.xml">
<link rel=Edit-Time-Data href="fwef_files/editdata.mso">
<link rel=OLE-Object-Data href="fwef_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>tam</o:Author>
  <o:LastAuthor>Mr Long</o:LastAuthor>
  <o:LastPrinted>2009-11-04T09:20:38Z</o:LastPrinted>
  <o:Created>2006-06-27T06:13:13Z</o:Created>
  <o:LastSaved>2009-11-05T07:51:12Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Trang &P \/ &N";
	margin:.5in .25in .5in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style16
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
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
.xl24
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:left;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid #00CCFF;
	border-right:.5pt solid #00CCFF;
	border-bottom:none;
	border-left:.5pt solid #00CCFF;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid #00CCFF;
	border-right:.5pt solid #00CCFF;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:.5pt solid #00CCFF;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:.5pt solid #00CCFF;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;}
.xl44
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl47
	{mso-style-parent:style16;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl48
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid #00CCFF;
	border-right:none;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid #00CCFF;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid #00CCFF;
	border-right:none;
	border-bottom:.5pt solid #00CCFF;
	border-left:.5pt solid #00CCFF;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl56
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid #00CCFF;
	border-right:none;
	border-bottom:.5pt solid #00CCFF;
	border-left:.5pt solid #00CCFF;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid #00CCFF;
	border-right:none;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid #00CCFF;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sổ NKC (Mau so S03a-DN) (2)</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>77</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>90</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>8</x:SplitHorizontal>
     <x:TopRowBottomPane>9</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveCol>13</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>5790</x:WindowHeight>
  <x:WindowWidth>11880</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1905</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Sổ NKC (Mau so S03a-DN) (2)'!$7:$8</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1736 style='border-collapse:
 collapse;table-layout:fixed;width:1305pt'>
 <col class=xl24 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl24 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl24 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl24 width=285 style='mso-width-source:userset;mso-width-alt:10422;
 width:214pt'>
 <col class=xl24 width=298 style='mso-width-source:userset;mso-width-alt:10898;
 width:224pt'>
 <col class=xl24 width=68 span=2 style='mso-width-source:userset;mso-width-alt:
 2486;width:51pt'>
 <col class=xl24 width=117 style='mso-width-source:userset;mso-width-alt:4278;
 width:88pt'>
 <col class=xl24 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=110 span=4 style='mso-width-source:userset;mso-width-alt:
 4022;width:83pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl26 colspan=2 width=184 style='height:15.75pt;
  mso-ignore:colspan;width:138pt'><!--[if gte vml 1]><v:shapetype id="_x0000_t201"
   coordsize="21600,21600" o:spt="201" path="m,l,21600r21600,l21600,xe">
   <v:stroke joinstyle="miter"/>
   <v:path shadowok="f" o:extrusionok="f" strokeok="f" fillok="f"
    o:connecttype="rect"/>
   <o:lock v:ext="edit" shapetype="t"/>
  </v:shapetype><v:shape id="_x0000_s1030" type="#_x0000_t201" style='position:absolute;
   margin-left:0;margin-top:0;width:60.75pt;height:15.75pt;z-index:1;
   visibility:hidden' o:insetmode="auto">
   <o:lock v:ext="edit" rotation="t" text="t"/>
   <![if excel]><x:ClientData ObjectType="Drop">
    <x:MoveWithCells/>
    <x:SizeWithCells/>
    <x:PrintObject>False</x:PrintObject>
    <x:UIObj/>
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
  <td class=xl24 width=83 style='width:62pt'></td>
  <td class=xl24 width=285 style='width:214pt'></td>
  <td class=xl24 width=298 style='width:224pt'></td>
  <td class=xl27 colspan=2 width=136 style='mso-ignore:colspan;width:102pt'>Mẫu
  số S03a-DN</td>
  <td class=xl28 width=117 style='width:88pt'></td>
  <td class=xl24 width=54 style='width:41pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=75 style='width:56pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl29 colspan=3 style='height:15.75pt;mso-ignore:colspan'><%=l_address %></td>
  <td class=xl29></td>
  <td class=xl24></td>
  <td class=xl31
  x:str="                 (Ban hành theo Quyết định số 15/2006/QĐ-BTC ngày "><span
  style='mso-spacerun:yes'>                 </span>(Ban hành theo Quyết định số
  15/2006/QĐ-BTC ngày<span style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl30 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Mã
  số thuế: <%= l_taxcode %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl31>&nbsp;&nbsp;&nbsp;<span style='mso-spacerun:yes'>           
  </span>20 tháng 03 năm 2006 của Bộ trường Bộ Tài chính)</td>
  <td colspan=4 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=10 height=30 class=xl51 style='height:22.5pt'>NHẬT KÝ CHUNG</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=10 height=26 class=xl31 style='height:19.5pt'>Từ ngày <%= l_date_fr2 %>
  -&gt; <%= l_date_to2 %></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=21 style='height:15.75pt'>
  <td height=21 colspan=13 class=xl30 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl33>Đơn vị tính:</td>
  <td class=xl34><%=l_ccy%></td>
 </tr>
 <tr class=xl35 height=21 style='height:15.75pt'>
  <td height=21 class=xl36 style='height:15.75pt' x:str="Ngày tháng ">Ngày
  tháng<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid #00CCFF'>Chứng từ</td>
  <td class=xl37>Diễn giải</td>
  <td class=xl37>Description</td>
  <td colspan=2 class=xl54 style='border-right:.5pt solid #00CCFF;border-left:
  none'>Số hiệu TK</td>
  <td class=xl37>Số phát sinh</td>
  <td class=xl37>Loại</td>
  <td class=xl37>Ghi chú</td>
  <td class=xl37 x:str="Đối tượng ">Đối tượng<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl37 x:str="Đối tượng ">Đối tượng<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl37 x:str="Đối tượng ">Đối tượng<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl37 x:str="Đối tượng ">Đối tượng<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl37>Tỷ giá</td>
 </tr>
 <tr class=xl35 height=21 style='height:15.75pt'>
  <td height=21 class=xl38 style='height:15.75pt'>ghi sổ</td>
  <td class=xl39>Số hiệu</td>
  <td class=xl39>Ngày</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39 x:str="Nợ ">Nợ<span style='mso-spacerun:yes'> </span></td>
  <td class=xl39>Có</td>
  <td class=xl39><span style='mso-spacerun:yes'> </span></td>
  <td class=xl39>chi phí</td>
  <td class=xl39>Seq</td>
  <td class=xl39>Cộng nợ</td>
  <td class=xl39>Nhân viên</td>
  <td class=xl39>Ngân hàng</td>
  <td class=xl39>Chi phí</td>
  <td class=xl39>&nbsp;</td>
 </tr>
 <%
   
   
        for (int i = 0; i < dt_detail.Rows.Count; i++)
        {

%>  
 <tr class=xl30 height=21 style='height:15.75pt'>
  <td height=21 class=xl40 style='height:15.75pt'><%=dt_detail.Rows[i][1]%></td>
  <td class=xl41><%=dt_detail.Rows[i][2]%></td>
  <td class=xl42><%=dt_detail.Rows[i][1]%></td>
  <td class=xl43><%=dt_detail.Rows[i][7]%></td>
  <td class=xl43><%=dt_detail.Rows[i][6]%></td>
  <td class=xl41 x:num><%=dt_detail.Rows[i][3]%></td>
  <td class=xl41 x:num><%=dt_detail.Rows[i][4]%></td>
  <td class=xl44 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'></span><%=dt_detail.Rows[i][5]%></td>
  <td class=xl43><%=dt_detail.Rows[i][8]%></td>
  <td class=xl45 x:num><%=dt_detail.Rows[i][0]%></td>
  <td class=xl43><%=dt_detail.Rows[i][13]%></td>
  <td class=xl43><%=dt_detail.Rows[i][11]%></td>
  <td class=xl43><%=dt_detail.Rows[i][12]%></td>
  <td class=xl43><%=dt_detail.Rows[i][10]%></td>
  <td class=xl44 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'></span><%=dt_detail.Rows[i][14]%></td>
 </tr>
 <%
     
 }

 %>

 <tr class=xl30 height=21 style='height:15.75pt'>
  <td colspan=6 height=21 class=xl56 width=918 style='border-right:.5pt solid #00CCFF;
  height:15.75pt;width:689pt'>Tổng cộng số phát sinh</td>
  <td class=xl46 width=68 style='width:51pt'>&nbsp;</td>
  <td class=xl47 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'></span><%= l_total_book_amt %></td>
  <td class=xl48>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl50 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl31 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl31>Ngày <%= l_report_dd %> tháng <%= l_report_mm %> năm <%= l_report_yy %></td>
  <td colspan=6 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl35 style='height:15.75pt'>Người ghi sổ</td>
  <td colspan=2 class=xl35>Kế toán trưởng</td>
  <td colspan=4 class=xl35>Giám đốc</td>
  <td class=xl25></td>
  <td colspan=5 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl55 style='height:15.75pt'>( Ký, họ tên )</td>
  <td colspan=2 class=xl55>( Ký, họ tên )</td>
  <td colspan=4 class=xl55>( Ký, họ tên, đóng dấu )</td>
  <td colspan=6 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl50 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl50 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl50 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl50 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl50 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl50 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl50 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl50 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 class=xl50 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=6 class=xl50 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 class=xl50 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=6 class=xl50 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=81 style='width:61pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=285 style='width:214pt'></td>
  <td width=298 style='width:224pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=75 style='width:56pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
