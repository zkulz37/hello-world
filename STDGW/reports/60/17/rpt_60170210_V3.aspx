<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string ls_compk = ""; //cong ty
	string ls_from_dt = "", ls_to_dt = ""; // tu ngay den ngay
	string ls_param = "", ls_date= "",ls_date_frm= "", ls_date_to= "";
	string ls_item = "", ls_abplcenter_pk = "";
    string ls_wh_pk = "", ls_acc_pk = "";
	ls_compk = Request["company_pk"];
	ls_from_dt = Request["from_dt"];
	ls_to_dt = Request["to_dt"];	
	ls_item =  Request["item"];	
	ls_abplcenter_pk = Request["tac_abplcenter_pk"];
    ls_wh_pk = Request["tin_warehouse_pk"];
	ls_acc_pk = Request["acc_pk"];
    ls_param = "'" + ls_compk + "', '" + ls_from_dt + "', '" + ls_to_dt + "', '" + ls_item + "', '" + ls_abplcenter_pk + "', '" + ls_wh_pk + "','" + ls_acc_pk + "'";
	//Response.Write(ls_param);
	//Response.End();
	DataTable dt = new DataTable();
	dt = ESysLib.TableReadOpenCursor("ac_rpt_60170210_inout", ls_param);	
	string l_date_date_month_2="";
	if(ls_to_dt.Substring(4, 2)=="02" && ls_to_dt.Substring(0, 4)=="2010")
	{
		l_date_date_month_2="28";
	}
	else if(ls_to_dt.Substring(4, 2)=="02" && ls_to_dt.Substring(0, 4)=="2011")
	{
		l_date_date_month_2="29";
	}
	else if(ls_to_dt.Substring(4, 2)=="02" && ls_to_dt.Substring(0, 4)=="2012")
	{
		l_date_date_month_2="29";
	}
	else if(ls_to_dt.Substring(4, 2)=="02" && ls_to_dt.Substring(0, 4)=="2013")
	{
		l_date_date_month_2="28";
	}
	else if(ls_to_dt.Substring(4, 2)=="02" && ls_to_dt.Substring(0, 4)=="2014")
	{
		l_date_date_month_2="28";
	}
	else
	{
		l_date_date_month_2=ls_to_dt.Substring(6, 2);
	}
	 ls_date_to = l_date_date_month_2 + "/" + ls_to_dt.Substring(4, 2) + "/" + ls_to_dt.Substring(0, 4);
	int i;
    ls_date = "";
      ls_date_frm = ls_from_dt.Substring(6, 2) + "/" + ls_from_dt.Substring(4, 2) + "/" + ls_from_dt.Substring(0, 4);
    ls_date_to = l_date_date_month_2 + "/" + ls_to_dt.Substring(4, 2) + "/" + ls_to_dt.Substring(0, 4);
    string SQL
        = "select partner_name, addr1 || nvl(addr2, '' ) || nvl(addr3, '') addr, tax_code " +
            "from tco_company where pk = '" + ls_compk + "'";
    DataTable dtComp = ESysLib.TableReadOpen(SQL);
    
    string l_comp_nm = "", l_addr = "", l_tax_code = "";
    if (dtComp.Rows.Count > 0)
    {
        l_comp_nm = dtComp.Rows[0][0].ToString();
        l_addr = dtComp.Rows[0][1].ToString();
        l_tax_code = dtComp.Rows[0][2].ToString();
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="FMGF00220_V3_files/filelist.xml">
<link rel=Edit-Time-Data href="FMGF00220_V3_files/editdata.mso">
<link rel=OLE-Object-Data href="FMGF00220_V3_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>VanLe</o:LastAuthor>
  <o:LastPrinted>2012-06-09T07:30:20Z</o:LastPrinted>
  <o:Created>2010-05-05T03:50:09Z</o:Created>
  <o:LastSaved>2012-06-09T08:38:45Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.55in 0in .5in .18in;
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
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:129;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl32
	{mso-style-parent:style0;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:129;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style0;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;}
.xl49
	{mso-style-parent:style0;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:129;
	vertical-align:middle;}
.xl50
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl55
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl56
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:white;
	mso-pattern:auto none;}
.xl63
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl64
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl65
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>InOutBalance</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>60</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:DoNotDisplayGridlines/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>12360</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1893 style='border-collapse:
 collapse;table-layout:fixed;width:1422pt'>
 <col class=xl24 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl24 width=190 style='mso-width-source:userset;mso-width-alt:6948;
 width:143pt'>
 <col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl24 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl24 width=84 span=3 style='mso-width-source:userset;mso-width-alt:
 3072;width:63pt'>
 <col class=xl24 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl24 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl24 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl24 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl24 width=84 style='mso-width-source:userset;mso-width-alt:3072;
 width:63pt'>
 <col class=xl24 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl24 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl24 width=187 style='mso-width-source:userset;mso-width-alt:6838;
 width:140pt'>
 <col class=xl24 width=64 span=4 style='width:48pt'>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl25 colspan=2 width=267 style='height:18.0pt;mso-ignore:
  colspan;width:201pt'><%=l_comp_nm%></td>
  <td class=xl25 width=89 style='width:67pt'></td>
  <td class=xl26 width=75 style='width:56pt'></td>
  <td class=xl26 width=79 style='width:59pt'></td>
  <td class=xl26 width=82 style='width:62pt'></td>
  <td class=xl26 width=84 style='width:63pt'></td>
  <td class=xl26 width=84 style='width:63pt'></td>
  <td class=xl26 width=84 style='width:63pt'></td>
  <td class=xl26 width=77 style='width:58pt'></td>
  <td class=xl26 width=81 style='width:61pt'></td>
  <td class=xl26 width=82 style='width:62pt'></td>
  <td class=xl26 width=96 style='width:72pt'></td>
  <td class=xl27 width=84 style='width:63pt'></td>
  <td class=xl27 width=100 style='width:75pt'></td>
  <td class=xl27 width=86 style='width:65pt'></td>
  <td class=xl27 width=187 style='width:140pt'></td>
  <td class=xl27 width=64 style='width:48pt'></td>
  <td class=xl27 width=64 style='width:48pt'></td>
  <td class=xl27 width=64 style='width:48pt'></td>
  <td class=xl27 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl25 colspan=13 style='height:18.0pt;mso-ignore:colspan'><%=l_addr%></td>
  <td colspan=8 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl25 style='height:18.0pt'>MST: <%=l_tax_code%></td>
  <td class=xl25></td>
  <td colspan=10 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=13 height=27 class=xl72 style='height:20.25pt'>INVENTORY OF
  MATERIAL REPORT</td>
  <td colspan=8 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=13 height=24 class=xl29 style='height:18.0pt'>Period from 
  <%=ls_date_frm%> To <%=ls_date_to%></td>
  <td colspan=8 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=13 class=xl29 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=9 class=xl30 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl31>Unit:</td>
  <td class=xl28>VND</td>
  <td class=xl28></td>
  <td class=xl32 x:str="                  "><span
  style='mso-spacerun:yes'>                    </span></td>
  <td colspan=8 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl67 width=267 style='border-right:.5pt solid black;
  height:18.0pt;width:201pt'>Item</td>
  <td rowspan=3 class=xl69 width=89 style='border-bottom:.5pt solid black;
  width:67pt'>Warehouse</td>
  <td colspan=2 class=xl62 style='border-right:.5pt solid black'>Openning
  Balance</td>
  <td colspan=2 class=xl62 style='border-right:.5pt solid black;border-left:
  none'>Take In</td>
  <td colspan=2 class=xl62 style='border-right:.5pt solid black;border-left:
  none'>Transfer In</td>
  <td colspan=2 class=xl62 style='border-right:.5pt solid black;border-left:
  none'>Transfer Out</td>
  <td colspan=2 class=xl62 style='border-right:.5pt solid black;border-left:
  none'>Take Out</td>
  <td colspan=2 class=xl62 style='border-right:.5pt solid black;border-left:
  none'>Closing Balance</td>
  <td colspan=2 class=xl65 style='border-right:.5pt solid black;border-left:
  none'>Remark</td>
  <td colspan=2 class=xl65 style='border-right:.5pt solid black;border-left:
  none'>PL</td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td rowspan=2 height=48 class=xl56 width=77 style='border-bottom:.5pt solid black;
  height:36.0pt;border-top:none;width:58pt'>Code</td>
  <td rowspan=2 class=xl56 width=190 style='border-bottom:.5pt solid black;
  border-top:none;width:143pt'>Name</td>
  <td rowspan=2 class=xl54 style='border-bottom:.5pt solid black;border-top:
  none'>Qty</td>
  <td rowspan=2 class=xl56 width=79 style='border-bottom:.5pt solid black;
  border-top:none;width:59pt' x:str="Books&#10;Amount ">Books<br>
    Amount<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl54 style='border-bottom:.5pt solid black;border-top:
  none'>Qty</td>
  <td rowspan=2 class=xl56 width=84 style='border-bottom:.5pt solid black;
  border-top:none;width:63pt'>Books<br>
    Amount</td>
  <td rowspan=2 class=xl56 width=84 style='border-bottom:.5pt solid black;
  border-top:none;width:63pt'>Qty</td>
  <td rowspan=2 class=xl56 width=84 style='border-bottom:.5pt solid black;
  border-top:none;width:63pt' x:str="Books&#10;Amount ">Books<br>
    Amount<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl54 style='border-bottom:.5pt solid black;border-top:
  none'>Qty</td>
  <td rowspan=2 class=xl60 width=81 style='border-bottom:.5pt solid black;
  border-top:none;width:61pt' x:str="Books Amount ">Books Amount<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl54 style='border-bottom:.5pt solid black;border-top:
  none'>Qty</td>
  <td rowspan=2 class=xl56 width=96 style='border-bottom:.5pt solid black;
  border-top:none;width:72pt'>Books <br>
    Amount</td>
  <td rowspan=2 class=xl54 style='border-bottom:.5pt solid black;border-top:
  none'>Qty</td>
  <td rowspan=2 class=xl56 width=100 style='border-bottom:.5pt solid black;
  border-top:none;width:75pt'>Amount <br>
    Books</td>
  <td rowspan=2 class=xl58 width=86 style='border-bottom:.5pt solid black;
  border-top:none;width:65pt'>Acct Code</td>
  <td rowspan=2 class=xl58 width=187 style='border-bottom:.5pt solid black;
  border-top:none;width:140pt'>Acct Name</td>
  
  
  <td rowspan=2 class=xl58 width=86 style='border-bottom:.5pt solid black;
  border-top:none;width:65pt'>PL Code</td>
  <td rowspan=2 class=xl58 width=187 style='border-bottom:.5pt solid black;
  border-top:none;width:140pt'>PL Name</td>
  
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=4 class=xl27 style='height:18.0pt;mso-ignore:colspan'></td>
 </tr>
  <%  
	decimal l_begin_qty = 0, l_begin_famt = 0, l_begin_amt = 0;
	decimal l_input_qty = 0, l_input_famt = 0, l_input_amt = 0;
	decimal l_output_qty = 0, l_output_famt = 0, l_output_amt = 0;
	decimal l_end_qty = 0, l_end_famt = 0, l_end_amt = 0;
	decimal l_moveout_qty = 0, l_moveout_famt = 0, l_moveout_amt = 0;
	decimal l_movein_qty = 0, l_movein_amt = 0;
	for ( i = 0 ; i < dt.Rows.Count ; i++)
	{
		if(dt.Rows[i]["last_qty"].ToString().Trim() != "")		
		{
			l_begin_qty += decimal.Parse(dt.Rows[i]["last_qty"].ToString());
		}
		if(dt.Rows[i]["last_amt"].ToString().Trim() != "")		
		{
			l_begin_famt += decimal.Parse(dt.Rows[i]["last_amt"].ToString());			
		}
		if(dt.Rows[i]["last_amt"].ToString().Trim() != "")		
		{
			l_begin_amt += decimal.Parse(dt.Rows[i]["last_amt"].ToString());			
		}
		if(dt.Rows[i]["input_qty"].ToString().Trim() != "")		
		{
			l_input_qty += decimal.Parse(dt.Rows[i]["input_qty"].ToString());
		}
		if(dt.Rows[i]["input_amt"].ToString().Trim() != "")		
		{
			l_input_famt += decimal.Parse(dt.Rows[i]["input_amt"].ToString());			
		}
		if(dt.Rows[i]["input_amt"].ToString().Trim() != "")		
		{
			l_input_amt += decimal.Parse(dt.Rows[i]["input_amt"].ToString());			
		}
		if(dt.Rows[i]["output_qty"].ToString().Trim() != "")		
		{
			l_output_qty += decimal.Parse(dt.Rows[i]["output_qty"].ToString());
		}
		if(dt.Rows[i]["output_amt"].ToString().Trim() != "")		
		{
			l_output_famt += decimal.Parse(dt.Rows[i]["output_amt"].ToString());			
		}
		if(dt.Rows[i]["output_amt"].ToString().Trim() != "")		
		{
			l_output_amt += decimal.Parse(dt.Rows[i]["output_amt"].ToString());			
		}
		if(dt.Rows[i]["end_qty"].ToString().Trim() != "")		
		{
			l_end_qty += decimal.Parse(dt.Rows[i]["end_qty"].ToString());
		}
		if(dt.Rows[i]["end_amt"].ToString().Trim() != "")		
		{
			l_end_famt += decimal.Parse(dt.Rows[i]["end_amt"].ToString());			
		}
		if(dt.Rows[i]["end_amt"].ToString().Trim() != "")		
		{
			l_end_amt += decimal.Parse(dt.Rows[i]["end_amt"].ToString());			
		}
		if(dt.Rows[i]["moveout_qty"].ToString().Trim() != "")		
		{
			l_moveout_qty += decimal.Parse(dt.Rows[i]["moveout_qty"].ToString());			
		}
		if(dt.Rows[i]["moveout_famt"].ToString().Trim() != "")		
		{
			l_moveout_famt += decimal.Parse(dt.Rows[i]["moveout_amt"].ToString());			
		}
		if(dt.Rows[i]["moveout_amt"].ToString().Trim() != "")		
		{
			l_moveout_amt += decimal.Parse(dt.Rows[i]["moveout_amt"].ToString());			
		}				
		if(dt.Rows[i]["movein_qty"].ToString().Trim() != "")		
		{
			l_movein_qty += decimal.Parse(dt.Rows[i]["movein_qty"].ToString());			
		}				
		if(dt.Rows[i]["movein_amt"].ToString().Trim() != "")		
		{
			l_movein_amt += decimal.Parse(dt.Rows[i]["movein_amt"].ToString());			
		}				


		
 %> 

 <tr class=xl33 height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl34 width=77 style='height:27.75pt;width:58pt'><%=dt.Rows[i]["item_code"]%></td>
  <td class=xl35 width=190 style='width:143pt'><%=dt.Rows[i]["item_name"]%></td>
  <td class=xl36 width=89 style='width:67pt'><%=dt.Rows[i]["wh_name"]%></td>
  <td class=xl37 x:num ><span style='mso-spacerun:yes'> </span><%=dt.Rows[i]["last_qty"].ToString()%> </td>
  <td class=xl38 x:num ><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i]["last_amt"].ToString()%> </td>
  <td class=xl37 x:num ><span style='mso-spacerun:yes'> </span><%=dt.Rows[i]["input_qty"].ToString()%> </td>
  <td class=xl38 x:num ><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i]["input_amt"].ToString()%> </td>
  <td class=xl37 x:num ><%=dt.Rows[i]["movein_qty"].ToString()%></td>
  <td class=xl38 x:num ><%=dt.Rows[i]["movein_amt"].ToString()%></td>
  <td class=xl37 x:num><span style='mso-spacerun:yes'> </span><%=dt.Rows[i]["moveout_qty"].ToString()%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl38 x:num><span style='mso-spacerun:yes'> </span><%=dt.Rows[i]["moveout_amt"].ToString()%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl37 x:num><span style='mso-spacerun:yes'> </span><%=dt.Rows[i]["output_qty"].ToString()%> </td>
  <td class=xl38 x:num><span style='mso-spacerun:yes'> </span><%=dt.Rows[i]["output_amt"].ToString()%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl37 x:num><span style='mso-spacerun:yes'> </span><%=dt.Rows[i]["end_qty"].ToString()%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i]["end_amt"].ToString()%> </td>
  <td class=xl39 x:num><%=dt.Rows[i]["ac_cd"].ToString()%></td>
  <td class=xl39><%=dt.Rows[i]["ac_nm"].ToString()%></td>
  
  <td class=xl39><%=dt.Rows[i]["pl_cd"].ToString()%></td>
  <td class=xl39><%=dt.Rows[i]["pl_nm"].ToString()%></td>
  <td colspan=4 class=xl40 style='mso-ignore:colspan'></td>
 </tr>
 <%
 }
 %>
 <tr class=xl33 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl52 width=267 style='border-right:.5pt solid black;
  height:18.75pt;width:201pt'>TOTAL</td>
  <td class=xl41 width=89 style='width:67pt'>&nbsp;</td>
  <td class=xl42 x:num><span style='mso-spacerun:yes'> </span><%=l_begin_qty %> </td>
  <td class=xl43 x:num><span
  style='mso-spacerun:yes'> </span><%=l_begin_amt %> </td>
  <td class=xl42 x:num><span style='mso-spacerun:yes'> </span><%=l_input_qty %> </td>
  <td class=xl43 x:num><span
  style='mso-spacerun:yes'> </span><%=l_input_amt %> </td>
  <td class=xl42 x:num><%=l_movein_qty%></td>
  <td class=xl43 x:num><%=l_movein_amt%></td>
  <td class=xl42 x:num><span style='mso-spacerun:yes'> </span><%=l_moveout_qty %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl43 x:num><span style='mso-spacerun:yes'> </span><%=l_moveout_amt %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl42 x:num><span style='mso-spacerun:yes'> </span><%=l_output_qty %> </td>
  <td class=xl43 x:num><span
  style='mso-spacerun:yes'> </span><%=l_output_amt %></td>
  <td class=xl42 x:num><span style='mso-spacerun:yes'> </span><%=l_end_qty %> </td>
  <td class=xl43 x:num><span
  style='mso-spacerun:yes'> </span><%=l_end_amt %> </td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td colspan=4 class=xl40 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=13 class=xl45 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=13 class=xl45 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=3 class=xl46 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=6 class=xl46 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl29>Prepared, as at <%=ls_date_frm%> To <%=ls_date_to%></td>
  <td colspan=8 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl47 style='height:18.75pt'></td>
  <td colspan=3 class=xl50>PREPARED BY</td>
  <td colspan=3 class=xl50>CHIEF ACCOUNTANT</td>
  <td colspan=2 class=xl50 style='mso-ignore:colspan'></td>
  <td class=xl47></td>
  <td colspan=3 class=xl50>DIRECTOR</td>
  <td colspan=8 class=xl40 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl48 style='height:18.0pt'></td>
  <td colspan=3 class=xl51>(Sign, name)</td>
  <td colspan=3 class=xl51>(Sign, name)</td>
  <td colspan=2 class=xl51 style='mso-ignore:colspan'></td>
  <td class=xl47></td>
  <td colspan=3 class=xl51>(Sign, name, Stamp)</td>
  <td colspan=8 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=13 class=xl49 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=13 class=xl49 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=13 class=xl49 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl49 style='height:18.0pt'></td>
  <td colspan=3 class=xl51></td>
  <td colspan=3 class=xl51></td>
  <td colspan=2 class=xl51 style='mso-ignore:colspan'></td>
  <td class=xl47></td>
  <td colspan=3 class=xl51></td>
  <td colspan=8 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=77 style='width:58pt'></td>
  <td width=190 style='width:143pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=187 style='width:140pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>