<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_comp = "" + Request["company_pk"];    
    string p_kind = ""+Request["KindCode"];
	string p_dept = ""+Request["DeptPK"];
	string p_status = ""+Request["Status"];
	string p_fa_acc = ""+ Request["AssetAccCode"];
	string p_depr_acc = ""+ Request["AssetDepr"]	;
	string p_expe_acc = ""+ Request["ExpAcc"];
    string p_from = "" + Request["dtFrom"];
    string p_to = "" + Request["dtTo"];
	string p_ccy = "" + Request["ccy"];
    string from_month = p_from.Substring(4, 2) + "/" + p_from.Substring(0, 4);
    string to_month = p_to.Substring(4, 2) + "/" + p_to.Substring(0, 4);
    string comp_name = "";
    string comp_lname = "";
    string address = "";
    string tax_code = "";
    string kind_code ="";
    string kind_code_dept = "";
    int j = 0, k=0;
    int stt = 0;
    string depr_date = "";
    string tmp_date = "";
    int month_depr = 0;
    int tmp_yy = 0;
    int tmp_mm = 0;
    
    string l_cmp_name = "";
    string l_cmp_add = "";
    string l_cmp_taxcode = "";
    int    i;
    string l_Scale1 = "";
    if (Request["p_Scale"] != "1")
    {
        l_Scale1 = Request["p_Scale"];
    }     
    string l_ccy = Request["p_ccy"];

    string p_xls_ccy_format = "";

   
   ///---Get company information-------------------------------------------------------------------------------
        
    string SQL1 = " SELECT PARTNER_NAME, ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + p_comp + "' ";

    DataTable dt = ESysLib.TableReadOpen(SQL1);
    if (dt.Rows.Count > 0)
    {
        l_cmp_name = dt.Rows[0][0].ToString();
        l_cmp_add = dt.Rows[0][1].ToString();
        l_cmp_taxcode = dt.Rows[0][3].ToString();
    }
    //---Get booking ccy for format----------------------------------------------------------------------------
    string sql2= "SELECT SF_A_GET_DEFAULT('ACBG0040') FROM DUAL ";

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
    //----End booking ccy format-------------------------------------------------------------------------------
    //---------------------------------------------------------------------------------------------------------
    string l_parameter = "'" + p_from + "','" + p_to + "','" + p_comp + "','" +  p_kind  + "','" + p_dept + "','" + p_status + "', '"+p_ccy+"'";
    DataTable dt_grp_kind = ESysLib.TableReadOpenCursor("ac_sel_60130140_02_2", l_parameter);
	
    DataTable dt_sum_location = ESysLib.TableReadOpenCursor("ac_sel_60130140_02_3", l_parameter);
	//Response.Write(dt_sum_location.Rows.Count.ToString());
	//Response.End();
    DataTable dt_grd_total = ESysLib.TableReadOpenCursor("ac_sel_60130140_02_4", l_parameter);
    DataTable dt_detail = ESysLib.TableReadOpenCursor("ac_sel_60130140_02_1",l_parameter);
    DataTable dt_depr_yn = ESysLib.TableReadOpenCursor("ac_sel_60130140_02_5", l_parameter);
  
    if (dt_detail.Rows.Count==0)
    {
        Response.Write("There is no data");
        Response.End();
    }

    int ti = 0; 
    int ti_s = 0; 

    //Response.Write(ti);
    //Response.End();
    
   //----------------------------------------------------------------------------------------------------------- 
    
    
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List
href="090616_LIST%20OF%20FIXED%20ASSETS%20DEPRECIATION%20AMEND_files/filelist.xml">
<link rel=Edit-Time-Data
href="090616_LIST%20OF%20FIXED%20ASSETS%20DEPRECIATION%20AMEND_files/editdata.mso">
<link rel=OLE-Object-Data
href="090616_LIST%20OF%20FIXED%20ASSETS%20DEPRECIATION%20AMEND_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Acc</o:Author>
  <o:LastAuthor>AiLinh</o:LastAuthor>
  <o:LastPrinted>2009-06-25T07:22:05Z</o:LastPrinted>
  <o:Created>2008-11-06T07:21:07Z</o:Created>
  <o:LastSaved>2009-06-25T07:23:17Z</o:LastSaved>
  <o:Company>genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in 0in .75in .5in;
	mso-header-margin:.5in;
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
	font-family:Arial, sans-serif;
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
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	color:red;
	border:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl47
	{mso-style-parent:style0;
	text-align:left;}
.xl48
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl49
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	color:red;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	color:red;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	color:red;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}	
.xl64
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}	
.xl65
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}	
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Amended Depreciation List</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:TabColorIndex>13</x:TabColorIndex>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>9</x:SplitHorizontal>
     <x:TopRowBottomPane>9</x:TopRowBottomPane>
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
       <x:ActiveRow>26</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8595</x:WindowHeight>
  <x:WindowWidth>15240</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1575</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="3073"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:regrouptable v:ext="edit">
   <o:entry new="1" old="0"/>
   <o:entry new="2" old="0"/>
  </o:regrouptable>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2437 style='border-collapse:
 collapse;table-layout:fixed;width:1829pt'>
 <col width=32 style='mso-width-source:userset;mso-width-alt:1170;width:24pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=238 style='mso-width-source:userset;mso-width-alt:8704;width:179pt'>
 <col width=42 style='mso-width-source:userset;mso-width-alt:1536;width:32pt'>
 <col width=100 span=3 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col width=83 style='mso-width-source:userset;mso-width-alt:3035;width:62pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=105 style='mso-width-source:userset;mso-width-alt:3840;width:79pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=105 style='mso-width-source:userset;mso-width-alt:3840;width:79pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=160 span=4 style='mso-width-source:userset;mso-width-alt:5851;
 width:120pt'>
 <col width=102 style='mso-width-source:userset;mso-width-alt:3730;width:77pt'>
 <col width=90 style='mso-width-source:userset;mso-width-alt:3291;width:68pt'>
 <col width=95 style='mso-width-source:userset;mso-width-alt:3474;width:71pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:3657;width:75pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 width=32 style='height:10.5pt;width:24pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=238 style='width:179pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=160 style='width:120pt'></td>
  <td width=160 style='width:120pt'></td>
  <td width=160 style='width:120pt'></td>
  <td width=160 style='width:120pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=79 style='width:59pt'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=3 height=19 class=xl46 style='height:14.25pt'><%=l_cmp_name %></td>
  <td colspan=18 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=3 height=17 class=xl47 style='height:12.75pt'><%=l_cmp_add %></td>
  <td colspan=18 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=21 height=27 class=xl48 style='height:20.25pt'>LIST OF FIXED
  ASSETS DEPRECIATION</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=21 height=17 class=xl24 style='height:12.75pt'>From :<%=from_month %>  To :<%=to_month %></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=21 style='height:7.5pt;mso-ignore:colspan'></td>
 </tr>
 <!--tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td rowspan=2 height=68 class=xl57 width=32 style='height:51.0pt;width:24pt'>No</td>
  <td rowspan=2 class=xl57 width=79 style='width:59pt'>Asset code</td>
  <td rowspan=2 class=xl57 width=238 style='width:179pt'>Asset Name</td>
  <td rowspan=2 class=xl57 width=42 style='width:32pt'>Qty</td>
  <td rowspan=2 class=xl55 width=100 style='border-bottom:.5pt solid black;
  width:75pt'>Location</td>
  <td rowspan=2 class=xl57 width=83 style='width:62pt'>Date of depreciation</td>
  <td rowspan=2 class=xl57 width=74 style='width:56pt'>Estimate life(month)</td>
  <td colspan=3 class=xl61 width=301 style='border-right:.5pt solid black;
  border-left:none;width:226pt'>At the beginning(<%=from_month%>)</td>
  <td colspan=2 class=xl61 width=251 style='border-right:.5pt solid black;
  border-left:none;width:188pt'>Acquisition</td>
  <td colspan=2 class=xl61 width=320 style='border-right:.5pt solid black;
  border-left:none;width:240pt'>Disposal</td>
  <td rowspan=2 class=xl57 width=160 style='width:120pt'>Depr. In period</td>
  <td colspan=3 class=xl57 width=287 style='border-left:none;width:216pt'>At
  the Ending</td>
  <td rowspan=2 class=xl57 width=100 style='width:75pt'>Depr. Acc</td>
  <td rowspan=2 class=xl57 width=91 style='width:68pt'>Depr. Per Month</td>
  <td rowspan=2 class=xl57 width=79 style='width:59pt'>Expe. Acc</td>
 </tr>
 <tr class=xl25 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl26 width=105 style='height:30.0pt;border-top:none;
  width:79pt'>Original Cost</td>
  <td class=xl26 width=91 style='border-top:none;width:68pt'>Accumulation</td>
  <td class=xl26 width=105 style='border-top:none;width:79pt'>Remain</td>
  <td class=xl26 width=91 style='border-top:none;width:68pt'>New purchase</td>
  <td class=xl26 width=160 style='border-top:none;width:120pt'>Substitution
  From <br>
    Other Accounts</td>
  <td class=xl26 width=160 style='border-top:none;width:120pt'>Decrease of
  <br>
    Original Cost</td>
  <td class=xl26 width=160 style='border-top:none;width:120pt'>Decrease
  of<br>
    Accumulation</td>
  <td class=xl26 width=102 style='border-top:none;width:77pt'>Original Cost</td>
  <td class=xl26 width=90 style='border-top:none;width:68pt'>Accumulation</td>
  <td class=xl26 width=95 style='border-top:none;width:71pt'>Remain</td>
 </tr-->
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td rowspan=2 height=68 class=xl43 width=32 style='border-bottom:.5pt solid black;
  height:51.0pt;width:24pt'>No</td>
  <td rowspan=2 class=xl43 width=79 style='border-bottom:.5pt solid black;
  width:59pt'>Asset code</td>
  <td rowspan=2 class=xl43 width=238 style='border-bottom:.5pt solid black;
  width:179pt'>Asset Name</td>
  <td rowspan=2 class=xl43 width=42 style='border-bottom:.5pt solid black;
  width:32pt'>Qty</td>
  <td rowspan=2 class=xl43 width=100 style='border-bottom:.5pt solid black;
  width:75pt'>Place</td>
  <td rowspan=2 class=xl43 width=100 style='border-bottom:.5pt solid black;
  width:75pt'>Location</td>
  <td rowspan=2 class=xl43 width=100 style='border-bottom:.5pt solid black;
  width:75pt'>Service date</td>
  <td rowspan=2 class=xl43 width=83 style='border-bottom:.5pt solid black;
  width:62pt'>Date of depreciation</td>
  <td rowspan=2 class=xl43 width=74 style='border-bottom:.5pt solid black;
  width:56pt'>Estimate life(month)</td>
  <td colspan=3 class=xl45 width=301 style='border-right:.5pt solid black;
  border-left:none;width:226pt'>At the beginning(<%=from_month%>)</td>
  <td colspan=2 class=xl50 width=251 style='border-right:.5pt solid black;
  border-left:none;width:188pt'>Acquisition</td>
  <td colspan=2 class=xl50 width=320 style='border-right:.5pt solid black;
  border-left:none;width:240pt'>Disposal</td>
  <td rowspan=2 class=xl43 width=160 style='border-bottom:.5pt solid black;
  width:120pt'>Depr. In period</td>
  <td colspan=3 class=xl45 width=287 style='border-right:.5pt solid black;
  border-left:none;width:216pt'>At the Ending</td>
  <td rowspan=2 class=xl43 width=100 style='border-bottom:.5pt solid black;
  width:75pt'>Depr. Acc</td>
  <td rowspan=2 class=xl43 width=91 style='border-bottom:.5pt solid black;
  width:68pt'>Depr. Per Month</td>
  <td rowspan=2 class=xl43 width=79 style='border-bottom:.5pt solid black;
  width:59pt'>Expe. Acc</td>
 </tr>
 <tr class=xl25 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl26 width=105 style='height:30.0pt;width:79pt'>Original
  Cost</td>
  <td class=xl26 width=91 style='width:68pt'>Accumulation</td>
  <td class=xl26 width=105 style='width:79pt'>Remain</td>
  <td class=xl26 width=91 style='width:68pt'>New purchase</td>
  <td class=xl26 width=160 style='width:120pt'>Substitution From <br>
    Other Accounts</td>
  <td class=xl26 width=160 style='width:120pt'>Decrease of <br>
    Original Cost</td>
  <td class=xl26 width=160 style='width:120pt'>Decrease of<br>
    Accumulation</td>
  <td class=xl26 width=102 style='width:77pt'>Original Cost</td>
  <td class=xl26 width=90 style='width:68pt'>Accumulation</td>
  <td class=xl26 width=95 style='width:71pt'>Remain</td>
 </tr>
 
 <%
     string depr_yn="";
     if (dt_depr_yn.Rows.Count > 0)
     {
         for (int di = 0; di < dt_depr_yn.Rows.Count; di++)
         {
             depr_yn = dt_depr_yn.Rows[di]["depr_yn"].ToString();
 %>
 
 <tr class=xl27 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=3 class=xl63 style='border-right:.5pt solid black;border-left:
  none'><%=dt_depr_yn.Rows[di]["depr_yn"].ToString()%></td>
  <td class=xl64 style='border-top:none'>&nbsp;</td>
  <td class=xl64 style='border-top:none'>&nbsp;</td>
  <td class=xl64 style='border-top:none'>&nbsp;</td>
  <td class=xl64 style='border-top:none'>&nbsp;</td>
  <td class=xl64 style='border-top:none'>&nbsp;</td>
  <td class=xl64 style='border-top:none'>&nbsp;</td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_depr_yn.Rows[di]["origin_amt"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_depr_yn.Rows[di]["acc_amt"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_depr_yn.Rows[di]["remain_amt"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_depr_yn.Rows[di]["new_pur_amt"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_depr_yn.Rows[di]["sub_acc_amt"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_depr_yn.Rows[di]["dis_dec_amt"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_depr_yn.Rows[di]["dis_dec_acc_amt"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_depr_yn.Rows[di]["depr_peirod"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_depr_yn.Rows[di]["end_org_amt"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_depr_yn.Rows[di]["end_acc_amt"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_depr_yn.Rows[di]["end_remain"].ToString()%></td>
  <td class=xl64></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_depr_yn.Rows[di]["depr_month_amt"].ToString()%></td>
  
  <td class=xl64 style='border-top:none'>&nbsp;</td>
 </tr>
             
<%           if (dt_grp_kind.Rows.Count > 0)
             {
                 for (int ki = 0; ki < dt_grp_kind.Rows.Count; ki++)
                 {
                     kind_code = dt_grp_kind.Rows[ki]["fa_kind_cd"].ToString();
                     if (dt_grp_kind.Rows[ki]["depr_yn"].ToString() == depr_yn)
                      {
 %>
  <tr class=xl27 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl44 style='border-right:.5pt solid black;border-left:
  none'><%=dt_grp_kind.Rows[ki]["fa_kind_NM"].ToString()%></td>
  <!--td class=xl29 style='border-top:none'>&nbsp;</td-->
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grp_kind.Rows[ki]["origin_amt"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grp_kind.Rows[ki]["acc_amt"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grp_kind.Rows[ki]["remain_amt"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grp_kind.Rows[ki]["new_pur_amt"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grp_kind.Rows[ki]["sub_acc_amt"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grp_kind.Rows[ki]["dis_dec_amt"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grp_kind.Rows[ki]["dis_dec_acc_amt"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grp_kind.Rows[ki]["depr_peirod"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grp_kind.Rows[ki]["end_org_amt"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grp_kind.Rows[ki]["end_acc_amt"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grp_kind.Rows[ki]["end_remain"].ToString()%></td>
  <td class=xl29></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grp_kind.Rows[ki]["depr_month_amt"].ToString()%></td>
  
  <td class=xl29 style='border-top:none'>&nbsp;</td>
 </tr>
 <%
    
     if (dt_detail.Rows.Count > 0)
     {
         stt = 0;
         for (i = 0; i < dt_detail.Rows.Count; i++)
         {

             if (dt_detail.Rows[i]["fa_kind_cd"].ToString() == kind_code && dt_detail.Rows[i]["depr_yn"].ToString() == depr_yn)
             {
                 stt++;
 %>            
 <tr class=xl31 height=16 style='height:12.0pt'>
  <td height=16 class=xl32 align=right style='height:12.0pt' x:num><%=stt%></td>
  <td class=xl33><%=dt_detail.Rows[i]["fa_cd"].ToString()%></td>
  <td class=xl33><%=dt_detail.Rows[i]["fa_nm"].ToString()%></td>
  <td class=xl33 align=right x:num><%=dt_detail.Rows[i]["fa_qty"].ToString()%></td>
  <td class=xl33><%=dt_detail.Rows[i]["place"].ToString()%></td>
  <td class=xl33><%=dt_detail.Rows[i]["LOCATION"].ToString()%></td>
  <td class=xl33><%=dt_detail.Rows[i]["fa_use_date"].ToString()%></td>
  <td class=xl33><%=dt_detail.Rows[i]["fa_depr_date"].ToString()%></td>
  <td class=xl33 align=right x:num><%=dt_detail.Rows[i]["months"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["origin_amt"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["acc_amt"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["remain_amt"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["new_pur_amt"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["sub_acc_amt"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["dis_dec_amt"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["dis_dec_acc_amt"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["depr_peirod"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["end_org_amt"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["end_acc_amt"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["end_remain"].ToString()%></td>
  <td class=xl33><%=dt_detail.Rows[i]["depr_acc"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["depr_month_amt"].ToString()%></td>
  <td class=xl33><%=dt_detail.Rows[i]["exp_acc"].ToString()%></td>
 </tr>
 <%
     }
 }
 }
}
}
} // end if dt_grp_kind
} // end for dt_depr_yn
} // end if dt_depr_yn
        if (dt_grd_total.Rows.Count > 0)
        {
%>

 
 <tr class=xl35 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=7 height=17 class=xl58 style='border-right:.5pt solid black;
  height:12.75pt'>TOTAL</td>
  <td class=xl37 style='border-top:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none'>&nbsp;</td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["origin_amt"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["acc_amt"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["remain_amt"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["new_pur_amt"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["sub_acc_amt"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["dis_dec_amt"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["dis_dec_acc_amt"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["depr_peirod"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["end_org_amt"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["end_acc_amt"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["end_remain"].ToString()%></td>
  <td class=xl37></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["depr_month_amt"].ToString()%></td>
  <td class=xl37 style='border-top:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none'>&nbsp;</td>  
  
  <!--td class=xl37 style='border-left:none' x:num ></td>
  <td class=xl37 style='border-left:none' x:num></td>
  <td class=xl37 style='border-left:none' x:num></td>
  <td class=xl37 style='border-left:none' x:num></td>
  <td class=xl37 style='border-left:none' x:num></td>
  <td class=xl37 style='border-left:none' x:num></td>
  <td class=xl37 style='border-left:none' x:num></td>
  <td class=xl37 style='border-left:none' x:num></td>
  <td class=xl37 style='border-left:none' x:num></td>
  <td class=xl37 style='border-left:none' x:num></td>
  <td class=xl37 style='border-left:none' x:num></td>
  <td class=xl37 style='border-left:none' x:num></td>
  <td class=xl37 style='border-left:none' x:num></td>
  <td class=xl37 style='border-left:none' x:num></td-->
 </tr>
 <%
     }
     if (dt_sum_location.Rows.Count > 0)
     {
         for (int si = 0; si < dt_sum_location.Rows.Count; si++)
         {

           
 %>
 <tr class=xl31 height=16 style='height:12.0pt'>
  <td colspan=7 height=16 class=xl49 style='border-right:.5pt solid black;
  height:12.0pt'>Sub Total <%=dt_sum_location.Rows[si]["LOCATION"].ToString()%></td>
  <td class=xl41 style='border-top:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none'>&nbsp;</td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["origin_amt"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["acc_amt"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["remain_amt"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["new_pur_amt"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["sub_acc_amt"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["dis_dec_amt"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["dis_dec_acc_amt"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["depr_peirod"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["end_org_amt"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["end_acc_amt"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["end_remain"].ToString()%></td>
  <td class=xl41></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["depr_month_amt"].ToString()%></td>
  <td class=xl41 style='border-top:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none'>&nbsp;</td>
  <!--td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td-->
 </tr>
 <%
     }
 } 
  %>
 
 <!--tr height=17 style='height:12.75pt'>
  <td colspan=7 height=17 class=xl52 style='border-right:.5pt solid black;
  height:12.75pt'>Factory Sub Total</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr-->
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=17 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl43>Day... Month.... Year.....</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl24>Prepared by</td>
  <td colspan=14 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24>Director</td>
  <td></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=32 style='width:24pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=238 style='width:179pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=160 style='width:120pt'></td>
  <td width=160 style='width:120pt'></td>
  <td width=160 style='width:120pt'></td>
  <td width=160 style='width:120pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=79 style='width:59pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
