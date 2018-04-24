<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("acnt");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
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

	string p_fa_acc_pk = ""+ Request["txtAssetCode_PK"];
	string p_depr_acc_pk = ""+ Request["txtDeprCode_PK"]	;
	string p_expe_acc_pk = ""+ Request["txtExpeCode_PK"];

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
	
	string p_xls_ccy_format = "";
    string l_ccy = "";
    if (p_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
	
    string l_fa_cd_pk = "", l_depr_acc_pk = "", l_expe_acc_pk = "";
    string SQL = " SELECT pk, partner_name, partner_lname, addr1 ||addr2||addr3 address, tax_code ";
    SQL += "  FROM tco_company ";
    SQL += " WHERE del_if = 0 AND pk = '" + p_comp + "'";
    DataTable dtCom = new DataTable();
    dtCom = ESysLib.TableReadOpen(SQL);	
    if (dtCom.Rows.Count 
	> 0)
    {
        comp_name = dtCom.Rows[0][1].ToString();
        comp_lname = dtCom.Rows[0][2].ToString();
        address = dtCom.Rows[0][3].ToString();
        tax_code = dtCom.Rows[0][4].ToString();
    }
	SQL
	= "    select pk from tac_abacctcode where del_if = 0 and ac_cd = '" + p_fa_acc + "' and tco_company_pk = '" + p_comp + "' " ;
    DataTable dtFA_CD = new DataTable();
    dtFA_CD = ESysLib.TableReadOpen(SQL);	
	if(dtFA_CD.Rows.Count > 0)
	{
		l_fa_cd_pk = dtFA_CD.Rows[0][0].ToString();
	}
	else
	{
		l_fa_cd_pk = "ALL";
	}

	SQL
	= "    select pk from tac_abacctcode where del_if = 0 and ac_cd = '" + p_depr_acc + "' and tco_company_pk = '" + p_comp + "' " ;
    DataTable dtDepr_CD = new DataTable();
    dtDepr_CD = ESysLib.TableReadOpen(SQL);	
	if(dtDepr_CD.Rows.Count > 0)
	{
		l_depr_acc_pk = dtDepr_CD.Rows[0][0].ToString();
	}
	else
	{
		l_depr_acc_pk = "ALL";
	}

	SQL
	= "    select pk from tac_abacctcode where del_if = 0 and ac_cd = '" + p_expe_acc + "' and tco_company_pk = '" + p_comp + "' " ;
    DataTable dtExpe_CD = new DataTable();
    dtExpe_CD = ESysLib.TableReadOpen(SQL);	
	if(dtExpe_CD.Rows.Count > 0)
	{
		l_expe_acc_pk = dtExpe_CD.Rows[0][0].ToString();
	}
	else
	{
		l_expe_acc_pk = "ALL";
	}
	
  	

    string l_parameter = "'" + p_from + "','" + p_to + "','" + p_comp + "','" +  p_kind  + "','" + p_dept + "','" + p_status + "', '"+p_ccy+"','" + p_expe_acc_pk +"','" + p_fa_acc_pk + "','" + p_depr_acc_pk + "'" ;

    
	DataTable data =ESysLib.TableReadOpenCursor("acnt.sp_sel_gfgf00040_01_1",l_parameter); // detail
	DataTable dt_kind =ESysLib.TableReadOpenCursor("acnt.sp_sel_gfgf00040_01_2",l_parameter); // kind
	DataTable dt_kind_d =ESysLib.TableReadOpenCursor("acnt.sp_sel_gfgf00040_01_3",l_parameter); // department
	DataTable total =ESysLib.TableReadOpenCursor("acnt.sp_sel_gfgf00040_01_4",l_parameter); // detail
	

 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfgf00040_01_VIE_POSCOEC_files/filelist.xml">
<link rel=Edit-Time-Data href="gfgf00040_01_VIE_POSCOEC_files/editdata.mso">
<link rel=OLE-Object-Data href="gfgf00040_01_VIE_POSCOEC_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Acc</o:Author>
  <o:LastAuthor>SVPOSLILAMA</o:LastAuthor>
  <o:LastPrinted>2008-11-06T07:31:57Z</o:LastPrinted>
  <o:Created>2008-11-06T07:21:07Z</o:Created>
  <o:LastSaved>2011-01-30T02:38:38Z</o:LastSaved>
  <o:Company>genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--
border-top:none;
border-right:.5pt solid windowtext;
border-bottom:.5pt hairline windowtext;
border-left:none;
table
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	border-top:none;
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
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl31
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
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";}
.xl35
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl37
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl39
	{mso-style-parent:style0;
	text-align:left;}
.xl40
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl41
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl43
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
.xl44
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl49
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";}
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
    mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";}
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
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
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>9</x:SplitHorizontal>
     <x:TopRowBottomPane>15</x:TopRowBottomPane>
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
       <x:ActiveRow>9</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>9</x:ActiveRow>
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
  <x:WindowHeight>9345</x:WindowHeight>
  <x:WindowWidth>15180</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2701 style='border-collapse:
 collapse;table-layout:fixed;width:2030pt'>
 <col width=32 style='mso-width-source:userset;mso-width-alt:1170;width:24pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=238 style='mso-width-source:userset;mso-width-alt:8704;width:179pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=45 style='mso-width-source:userset;mso-width-alt:1645;width:34pt'>
 <col width=83 style='mso-width-source:userset;mso-width-alt:3035;width:62pt'>
 <col width=74 span=2 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <col width=102 style='mso-width-source:userset;mso-width-alt:3730;width:77pt'>
 <col width=75 style='mso-width-source:userset;mso-width-alt:2742;width:56pt'>
 <col width=88 style='mso-width-source:userset;mso-width-alt:3218;width:66pt'>
 <col width=73 span=4 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col width=77 style='mso-width-source:userset;mso-width-alt:2816;width:58pt'>
 <col width=93 span=4 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col width=90 span=3 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col width=95 style='mso-width-source:userset;mso-width-alt:3474;width:71pt'>
 <col width=93 style='mso-width-source:userset;mso-width-alt:3401;width:70pt'>
 <col width=76 style='mso-width-source:userset;mso-width-alt:2779;width:57pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=103 span=2 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col width=52 style='mso-width-source:userset;mso-width-alt:1901;width:39pt'>
 <col width=55 span=2 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 width=32 style='height:10.5pt;width:24pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=238 style='width:179pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=3 height=19 class=xl38 style='height:14.25pt'><%=comp_name%></td>
  <td colspan=29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=3 height=17 class=xl39 style='height:12.75pt'><%=address%></td>
  <td colspan=29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 style='height:20.25pt'></td>
  <td colspan=24 class=xl40>DANH SÁCH KHẤU HAO TÀI SẢN CỐ ĐỊNH</td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=24 class=xl24>Từ ngày :<span style='mso-spacerun:yes'>           
  </span>Đên :<%=from_month%><%=to_month%></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=32 style='height:7.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=60 style='mso-height-source:userset;height:45.0pt'>
  <td height=60 class=xl26 width=32 style='height:45.0pt;width:24pt'>STT</td>
  <td class=xl27 width=79 style='width:59pt'>Mã TSCĐ</td>
  <td class=xl27 width=238 style='width:179pt'>Tên TSCĐ</td>
  <td class=xl27 width=89 style='width:67pt'>Ngày PS<br>
    tài sản</td>
  <td class=xl27 width=45 style='width:34pt'>Số lượng</td>
  <td class=xl27 width=83 style='width:62pt'>Ngày khấu hao</td>
  <td class=xl27 width=74 style='width:56pt'>Tuổi thọ(tháng)</td>
  <td class=xl27 width=74 style='width:56pt'>Nguyên giá<br>
    đầu kỳ</td>
  <td class=xl27 width=102 style='width:77pt'>Nguyên giá<br>
    đầu kỳ(VND)</td>
  <td class=xl27 width=75 style='width:56pt'>Tài sản<br>
    (tăng)</td>
  <td class=xl27 width=88 style='width:66pt'>Tài sản<br>
    (tăng(VND))</td>
  <td class=xl27 width=73 style='width:55pt'>Tài sản<br>
    (giảm)</td>
  <td class=xl27 width=73 style='width:55pt'>Tài sản<br>
    (giảm(VND))</td>
  <td class=xl27 width=73 style='width:55pt'>Nguyên giá<br>
    cuối kỳ</td>
  <td class=xl27 width=73 style='width:55pt'>Nguyên giá<br>
    cuối kỳ(VND)</td>
  <td class=xl27 width=77 style='width:58pt'>Số khấu hao(mỗi tháng)</td>
  <td class=xl27 width=93 style='width:70pt'>Số khấu hao(mỗi tháng)<br>
    VND</td>
  <td class=xl27 width=93 style='width:70pt'>Số khấu hao<br>
    lũy kế đầu kỳ</td>
  <td class=xl27 width=93 style='width:70pt'>Số khấu hao<br>
    lũy kế đầu kỳ<br>
    (VND)</td>
  <td class=xl27 width=93 style='width:70pt'>Số khấu hao(của tháng này)</td>
  <td class=xl27 width=90 style='width:68pt'>Số khấu hao(của tháng này VND)</td>
  <td class=xl27 width=90 style='width:68pt'>Số khấu hao lũy kế cuối kỳ</td>
  <td class=xl27 width=90 style='width:68pt'>Số khấu hao lũy kế cuối kỳ<br>
    (VND)</td>
  <td class=xl27 width=95 style='width:71pt'>Giá trị còn lại</td>
  <td class=xl27 width=93 style='width:70pt'>Giá trị còn lại<br>
    (VND)</td>
  <td class=xl27 width=76 style='width:57pt'>Tài khoản tài sản</td>
  <td class=xl27 width=79 style='width:59pt'>Tài khoản khấu hao</td>
  <td class=xl27 width=103 style='width:77pt'>Tài khoản chi phí</td>
  <td class=xl27 width=103 style='width:77pt'>PL unit</td>
  <td class=xl27 width=52 style='width:39pt'>Đơn giá</td>
  <td class=xl27 width=55 style='width:41pt'>Diễn giải</td>
  <td class=xl27 width=55 style='width:41pt'>Diễn giải</td>
 </tr>
 <%
    if(dt_kind.Rows.Count > 0)
    {
        for (int i = 0; i < dt_kind.Rows.Count; i++)
        {
            kind_code = dt_kind.Rows[i]["fa_kind_cd"].ToString();
 %>
 <tr class=xl28 height=17 style='mso-height-source:userset;height:12.75pt'>
<!--td height=17 class=xl29 style='height:12.75pt'>&nbsp;</td-->
  <td colspan=3 height=17 class=xl41 style='border-right:.5pt solid black;
  height:12.75pt'><%=dt_kind.Rows[i]["fa_kind_NM"].ToString()%>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29 x:num><%=dt_kind.Rows[i]["fa_cost"].ToString()%></td>
  <td class=xl49 x:num><%=dt_kind.Rows[i]["fa_fcost"].ToString()%></td>
  <td class=xl29 x:num><%=dt_kind.Rows[i]["inc_amt"].ToString()%></td>
  <td class=xl49 x:num><%=dt_kind.Rows[i]["inc_famt"].ToString()%></td>
  <td class=xl29 x:num><%=dt_kind.Rows[i]["dec_amt"].ToString()%></td>
  <td class=xl49 x:num><%=dt_kind.Rows[i]["dec_famt"].ToString()%></td>
  <td class=xl29 x:num><%=dt_kind.Rows[i]["fa_cost_last"].ToString()%></td>
  <td class=xl49 x:num><%=dt_kind.Rows[i]["fa_fcost_last"].ToString()%></td>
  <td class=xl29 x:num><%=dt_kind.Rows[i]["fa_deprmonth_amt"].ToString()%></td>
  <td class=xl49 x:num><%=dt_kind.Rows[i]["fa_deprmonth_famt"].ToString()%></td>
  <td class=xl29 x:num><%=dt_kind.Rows[i]["fa_begin_depr_amt"].ToString()%></td>
  <td class=xl49 x:num><%=dt_kind.Rows[i]["fa_begin_depr_famt"].ToString()%></td>
  <td class=xl29 x:num><%=dt_kind.Rows[i]["fa_depr_amt"].ToString()%></td>
  <td class=xl49 x:num><%=dt_kind.Rows[i]["fa_depr_famt"].ToString()%></td>

  <td class=xl29 x:num><%=dt_kind.Rows[i]["fa_depr_accum"].ToString()%></td>
  <td class=xl49 x:num><%=dt_kind.Rows[i]["fa_depr_faccum"].ToString()%></td>

  <td class=xl29 x:num><%=dt_kind.Rows[i]["fa_remain_amt"].ToString()%></td>
  <td class=xl49 x:num><%=dt_kind.Rows[i]["fa_remain_famt"].ToString()%></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <% 
     if (dt_kind_d.Rows.Count > 0)
     {
         for (k = 0; k < dt_kind_d.Rows.Count; k++)
         {
             kind_code_dept = dt_kind_d.Rows[k]["dept_pk"].ToString();
             if (dt_kind_d.Rows[k]["fa_kind_cd"].ToString() == kind_code)
             {
                
%>
 <tr class=xl28 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl30 style='height:12.75pt'>&nbsp;</td>
  <td colspan=2 class=xl43 style='border-right:.5pt solid black;border-left:
  none'><%=dt_kind_d.Rows[k]["dept_nm"].ToString()%>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>

<td class=xl29 x:num><%=dt_kind_d.Rows[k]["fa_cost"].ToString()%></td>
  <td class=xl49 x:num><%=dt_kind_d.Rows[k]["fa_fcost"].ToString()%></td>
  <td class=xl29 x:num><%=dt_kind_d.Rows[k]["inc_amt"].ToString()%></td>
  <td class=xl49 x:num><%=dt_kind_d.Rows[k]["inc_famt"].ToString()%></td>
  <td class=xl29 x:num><%=dt_kind_d.Rows[k]["dec_amt"].ToString()%></td>
  <td class=xl49 x:num><%=dt_kind_d.Rows[k]["dec_famt"].ToString()%></td>
  <td class=xl29 x:num><%=dt_kind_d.Rows[k]["fa_cost_last"].ToString()%></td>
  <td class=xl49 x:num><%=dt_kind_d.Rows[k]["fa_fcost_last"].ToString()%></td>
  <td class=xl29 x:num><%=dt_kind_d.Rows[k]["fa_deprmonth_amt"].ToString()%></td>
  <td class=xl49 x:num><%=dt_kind_d.Rows[k]["fa_deprmonth_famt"].ToString()%></td>
  <td class=xl29 x:num><%=dt_kind_d.Rows[k]["fa_begin_depr_amt"].ToString()%></td>
  <td class=xl49 x:num><%=dt_kind_d.Rows[k]["fa_begin_depr_famt"].ToString()%></td>
  <td class=xl29 x:num><%=dt_kind_d.Rows[k]["fa_depr_amt"].ToString()%></td>
  <td class=xl49 x:num><%=dt_kind_d.Rows[k]["fa_depr_famt"].ToString()%></td>

  <td class=xl29 x:num><%=dt_kind_d.Rows[k]["fa_depr_accum"].ToString()%></td>
  <td class=xl49 x:num><%=dt_kind_d.Rows[k]["fa_depr_faccum"].ToString()%></td>

  <td class=xl29 x:num><%=dt_kind_d.Rows[k]["fa_remain_amt"].ToString()%></td>
  <td class=xl49 x:num><%=dt_kind_d.Rows[k]["fa_remain_famt"].ToString()%></td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
 </tr>
 <%
     if (data.Rows.Count > 0)
     {
         stt = 0;
         for (j = 0; j < data.Rows.Count; j++)
         {
             if (data.Rows[j]["fa_kind_cd"].ToString() == kind_code && data.Rows[j]["dept_pk"].ToString() ==  kind_code_dept)
             {
                 stt++;
                 tmp_date = data.Rows[j]["fa_depr_date"].ToString();
                 depr_date = tmp_date.Substring(6, 2) + "/" + tmp_date.Substring(4, 2) + "/" + tmp_date.Substring(0, 4);
                 if (data.Rows[j]["fa_depr_yy"].ToString() != "")
                 {
                     tmp_yy = int.Parse(data.Rows[j]["fa_depr_yy"].ToString());
                 }
                 else
                 {
                     tmp_yy = 0;
                 }

                 if (data.Rows[j]["fa_depr_mm"].ToString() != "")
                 {
                     tmp_mm = int.Parse(data.Rows[j]["fa_depr_mm"].ToString());
                 }
                 else
                 {
                     tmp_mm = 0;
                 }
                 month_depr = tmp_yy * 12 + tmp_mm;
 %>
 <tr class=xl32 height=16 style='height:12.0pt'>
  <td height=16 class=xl33 style='height:12.0pt'><%= stt%>&nbsp;</td>
  <td class=xl34><%=data.Rows[j]["fa_cd"].ToString()%></td>
  <td class=xl34><%=data.Rows[j]["fa_nm"].ToString()%></td>
  <td class=xl34><%=data.Rows[j]["FA_USE_DATE"].ToString()%></td>
  <td class=xl34 x:num><%=data.Rows[j]["fa_qty"].ToString()%></td>
  <td class=xl34><%=depr_date%></td>
  <td class=xl34 x:num><%=data.Rows[j]["fa_depr_mm"].ToString()%></td>
  <td class=xl35 x:num><%=data.Rows[j]["fa_cost"].ToString()%></td>
  <td class=xl34 x:num><%=data.Rows[j]["fa_fcost"].ToString()%></td>
  <td class=xl35 x:num><%=data.Rows[j]["Inc_amt"].ToString()%></td>
  <td class=xl34 x:num><%=data.Rows[j]["Inc_famt"].ToString()%></td>
  <td class=xl35 x:num><%=data.Rows[j]["Dec_amt"].ToString()%></td>
  <td class=xl34 x:num><%=data.Rows[j]["Dec_famt"].ToString()%></td>
  <td class=xl35 x:num><%=data.Rows[j]["fa_cost_last"].ToString()%></td>
  <td class=xl34 x:num><%=data.Rows[j]["fa_fcost_last"].ToString()%></td>

  <td class=xl35 x:num><%=data.Rows[j]["fa_deprmonth_amt"].ToString()%></td>
  <td class=xl34 x:num><%=data.Rows[j]["fa_deprmonth_famt"].ToString()%></td>

  <td class=xl35 x:num><%=data.Rows[j]["fa_begin_depr_amt"].ToString()%></td>
  <td class=xl34 x:num><%=data.Rows[j]["fa_begin_depr_famt"].ToString()%></td>

  <td class=xl35 x:num><%=data.Rows[j]["fa_depr_amt"].ToString()%></td>
  <td class=xl34 x:num><%=data.Rows[j]["fa_depr_famt"].ToString()%></td>
  
  <td class=xl35 x:num><%=data.Rows[j]["fa_depr_accum"].ToString()%></td>
  <td class=xl34 x:num><%=data.Rows[j]["fa_depr_faccum"].ToString()%></td>
  
  <td class=xl35 x:num><%=data.Rows[j]["fa_remain_amt"].ToString()%></td>
  <td class=xl34 x:num><%=data.Rows[j]["fa_remain_famt"].ToString()%></td>
  
  <td class=xl34><%=data.Rows[j]["asset_acc"].ToString()%></td>
  <td class=xl34><%=data.Rows[j]["depr_acc"].ToString()%></td>
  <td class=xl34><%=data.Rows[j]["expe_acc"].ToString()%></td>
  <td class=xl34><%=data.Rows[j]["pl_nm"].ToString()%></td>
  <td class=xl34 x:num><%=data.Rows[j]["u_price"].ToString()%></td>
  <td class=xl34><%=data.Rows[j]["remark"].ToString()%></td>
  <td class=xl34><%=data.Rows[j]["remark2"].ToString()%></td>
  <td class=xl32></td>
 </tr>
 <%
     }
 }
}



            }// if dept 1
        } // for dept  
    } // if dept    
             

  %><%
        }
    }
  %><%
      if (total.Rows.Count > 0)
      {
 %>
 <tr class=xl36 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=3 height=17 class=xl45 style='border-right:.5pt solid black;
  height:12.75pt'>Tổng cộng</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37 x:num><%=total.Rows[0]["fa_cost"].ToString()%></td>
  <td class=xl50 x:num><%=total.Rows[0]["fa_fcost"].ToString()%></td>
  <td class=xl37 x:num><%=total.Rows[0]["inc_amt"].ToString()%></td>
  <td class=xl50 x:num><%=total.Rows[0]["inc_famt"].ToString()%></td>
  <td class=xl37 x:num><%=total.Rows[0]["dec_amt"].ToString()%></td>
  <td class=xl50 x:num><%=total.Rows[0]["dec_famt"].ToString()%></td>
  <td class=xl37 x:num><%=total.Rows[0]["fa_cost_last"].ToString()%></td>
  <td class=xl50 x:num><%=total.Rows[0]["fa_fcost_last"].ToString()%></td>
  <td class=xl37 x:num><%=total.Rows[0]["fa_deprmonth_amt"].ToString()%></td>
  <td class=xl50 x:num><%=total.Rows[0]["fa_deprmonth_famt"].ToString()%></td>
  <td class=xl37 x:num><%=total.Rows[0]["fa_begin_depr_amt"].ToString()%></td>
  <td class=xl50 x:num><%=total.Rows[0]["fa_begin_depr_famt"].ToString()%></td>
  <td class=xl37 x:num><%=total.Rows[0]["fa_depr_amt"].ToString()%></td>
  <td class=xl50 x:num><%=total.Rows[0]["fa_depr_famt"].ToString()%></td>

  <td class=xl37 x:num><%=total.Rows[0]["fa_depr_accum"].ToString()%></td>
  <td class=xl50 x:num><%=total.Rows[0]["fa_depr_faccum"].ToString()%></td>

  <td class=xl37 x:num><%=total.Rows[0]["fa_remain_amt"].ToString()%></td>
  <td class=xl50 x:num><%=total.Rows[0]["fa_remain_famt"].ToString()%></td>

  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>
 <%} %>
 <tr class=xl32 height=16 style='height:12.0pt'>
  <td height=16 colspan=32 class=xl32 style='height:12.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=32 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=23 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl48>Ngày ...…..Tháng...…….Năm.....</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl24>Người lập biểu</td>
  <td colspan=20 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24>Thủ trưởng đơn vị</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=32 style='width:24pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=238 style='width:179pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
