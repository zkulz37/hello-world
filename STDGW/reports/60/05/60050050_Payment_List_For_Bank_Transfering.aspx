<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string l_company_pk= ""+ Request["company_pk"];
	string l_seq= ""+ Request["seq"];
	string l_voucher_type= ""+ Request["voucher_type"];
	string l_cust_cd = ""+ Request["cust_cd"];
	string l_status= ""+ Request["status"];
	string l_voucher_no= ""+ Request["voucher_no"];
	string l_Trs_fr= ""+ Request["Trs_fr"];
	string l_Trs_to= ""+ Request["Trs_to"];
	string l_RPPerson=""+ Request["RPPerson"];
	string l_Desc1=""+ Request["Desc1"];
	string l_Desc2=""+ Request["Desc2"];
	string l_DepositNo=""+ Request["DepositNo"];
	
	string l_parameter = "'" + l_company_pk + "', ";
	l_parameter += "'" + l_Trs_fr + "', ";
	l_parameter += "'" + l_Trs_to + "', ";
	l_parameter += "'" + l_cust_cd + "', ";
	l_parameter += "'" + l_status + "', ";
	l_parameter += "'" + l_voucher_no + "', ";
	l_parameter += "'" + l_voucher_type + "', ";
	l_parameter += "'" + l_seq + "', ";
	l_parameter += "'" + l_RPPerson + "', ";
	l_parameter += "'" + l_Desc1 + "', ";
	l_parameter += "'" + l_Desc2 + "', ";
	l_parameter += "'"+l_DepositNo+"' ";
	
	string p_Company_Nm = "";
	string p_Tax_Code = "";
	string p_Add = "";
	string SQL = " SELECT partner_lname, tax_code, ADDR1, ADDR2, ADDR3  FROM tco_company  WHERE pk = '" + l_company_pk + "'";
	DataTable dt_Com = ESysLib.TableReadOpen(SQL);
	if(dt_Com.Rows.Count > 0)
	{
		p_Company_Nm = dt_Com.Rows[0][0].ToString();
		p_Tax_Code = dt_Com.Rows[0][1].ToString();
		p_Add = dt_Com.Rows[0][2].ToString() ;
	}
	
	DataTable dt = ESysLib.TableReadOpenCursor("ac_SEL_60050050_PayList_rpt", l_parameter);
	if (dt.Rows.Count == 0)
	{
		Response.Write("There is no data!!");
		Response.End();
	}
	l_Trs_fr = l_Trs_fr.Substring(6,2) + "." +l_Trs_fr.Substring(4,2) + "." + l_Trs_fr.Substring(0,4);
	l_Trs_to = l_Trs_to.Substring(6,2) + "." +l_Trs_to.Substring(4,2) + "." + l_Trs_to.Substring(0,4);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Payment_List_For_Bank_Transfering_files/filelist.xml">
<link rel=Edit-Time-Data
href="Payment_List_For_Bank_Transfering_files/editdata.mso">
<link rel=OLE-Object-Data
href="Payment_List_For_Bank_Transfering_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>TRUONG</o:Author>
  <o:LastAuthor>Kenzie</o:LastAuthor>
  <o:LastPrinted>2013-09-14T06:34:42Z</o:LastPrinted>
  <o:Created>2012-02-09T06:57:32Z</o:Created>
  <o:LastSaved>2013-09-14T06:36:49Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.5in .25in .25in .25in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style43
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
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
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style56
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:굴림, sans-serif;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Hiep__Expense_;}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
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
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	vertical-align:middle;}
.xl67
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;}
.xl68
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style43;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl70
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl72
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;}
.xl74
	{mso-style-parent:style56;
	color:white;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style56;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style43;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl79
	{mso-style-parent:style43;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl80
	{mso-style-parent:style0;
	font-weight:700;}
.xl81
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl83
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl84
	{mso-style-parent:style43;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl85
	{mso-style-parent:style56;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl86
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	vertical-align:middle;}
.xl87
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;}
.xl88
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl89
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:dd;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl93
	{mso-style-parent:style56;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl94
	{mso-style-parent:style43;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl95
	{mso-style-parent:style43;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl96
	{mso-style-parent:style56;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl97
	{mso-style-parent:style56;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl98
	{mso-style-parent:style56;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl99
	{mso-style-parent:style56;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl100
	{mso-style-parent:style56;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl101
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl102
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl103
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl104
	{mso-style-parent:style43;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl105
	{mso-style-parent:style43;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl106
	{mso-style-parent:style43;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl107
	{mso-style-parent:style0;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl108
	{mso-style-parent:style56;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl109
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl110
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl111
	{mso-style-parent:style56;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl112
	{mso-style-parent:style56;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl113
	{mso-style-parent:style56;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl114
	{mso-style-parent:style56;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl115
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl116
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet2</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>94</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
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
       <x:ActiveRow>17</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    
    <x:ConditionalFormatting>
     <x:Range>$C$7,$D$1:$D$5,$B$3</x:Range>
     <x:Condition>
      <x:Qualifier>Equal</x:Qualifier>
      <x:Value1>&quot;usd&quot;</x:Value1>
      <x:Format Style='color:#3366FF'/>
     </x:Condition>
    </x:ConditionalFormatting>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>10935</x:WindowHeight>
  <x:WindowWidth>18735</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>375</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet2!$7:$7</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1058 style='border-collapse:
 collapse;table-layout:fixed;width:794pt'>
 <col width=54 style='mso-width-source:userset;mso-width-alt:1974;width:41pt'>
 <col width=195 style='mso-width-source:userset;mso-width-alt:7131;width:146pt'>
 <col width=52 style='mso-width-source:userset;mso-width-alt:1901;width:39pt'>
 <col class=xl79 width=116 style='mso-width-source:userset;mso-width-alt:4242; width:87pt'>
 <col width=200 style='mso-width-source:userset;mso-width-alt:7314;width:150pt'>
 <col width=200 style='mso-width-source:userset;mso-width-alt:7314;width:150pt'>
 <col width=151 style='mso-width-source:userset;mso-width-alt:5522;width:113pt'>
 <col width=145 span=2 style='mso-width-source:userset;mso-width-alt:5302; width:109pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl66 colspan=2 width=249 style='height:15.75pt;
  mso-ignore:colspan;width:187pt'><%=p_Company_Nm%></td>
  <td class=xl68 width=52 style='width:39pt'></td>
  <td class=xl78 width=116 style='width:87pt'></td>
  <td class=xl69 width=200 style='width:150pt'></td>
  <td class=xl75 width=151 style='width:113pt'></td>
  <td class=xl75 width=145 style='width:109pt'></td>
  <td class=xl70 width=145 style='width:109pt'></td>
 </tr>
 <tr height=40 style='height:30.0pt'>
  <td height=40 class=xl86 colspan=3 style='height:30.0pt;mso-ignore:colspan'>PAYMENT
  LIST FOR BANK TRANSFE<span style='display:none'>RING</span></td>
  <td class=xl78></td>
  <td class=xl69></td>
  <td class=xl75></td>
  <td class=xl98 width=145 style='width:109pt'>Prepared by:</td>
  <td class=xl101 width=145 style='border-left:none;width:109pt'>Authorized
  signature:</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl72 style='height:16.5pt'>DATE:</td>
  <td class=xl108><%=l_Trs_fr%></td>
  <td class=xl71></td>
  <td class=xl78></td>
  <td class=xl69></td>
  <td class=xl75></td>
  <td class=xl99 width=145 style='width:109pt'>&nbsp;</td>
  <td class=xl102 width=145 style='border-left:none;width:109pt'>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl72 colspan=2 style='height:16.5pt;mso-ignore:colspan'>TRANSFER
  ACCOUNT:</td>
  <td class=xl107 ><%=l_DepositNo%></td>
  <td class=xl78></td>
  <td class=xl69></td>
  <td class=xl75></td>
  <td class=xl99 width=145 style='width:109pt'>&nbsp;</td>
  <td class=xl102 width=145 style='border-left:none;width:109pt'>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl72 style='height:16.5pt'></td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td class=xl78></td>
  <td class=xl69></td>
  <td class=xl75></td>
  <td class=xl100 width=145 style='width:109pt'>&nbsp;</td>
  <td class=xl103 width=145 style='border-left:none;width:109pt'>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 colspan=3 style='height:16.5pt;mso-ignore:colspan'></td>
  <td class=xl79></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl92 style='height:18.75pt'>No</td>
  <td class=xl93 width=195 style='border-left:none;width:146pt'>Beneficiary</td>
  <td class=xl94 width=52 style='border-left:none;width:39pt' x:str="Unit"><span
  style='mso-spacerun:yes'> </span>Unit<span style='mso-spacerun:yes'> </span></td>
  <td class=xl95 width=116 style='border-left:none;width:87pt' x:str="Amount"><span
  style='mso-spacerun:yes'> </span>Amount<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl93 width=200 style='border-left:none;width:150pt'>In words</td>
  <td class=xl93 width=200 style='border-left:none;width:150pt'>Bank name</td>
  <td class=xl93 width=151 style='border-left:none;width:113pt'>Bank Account</td>
  <td colspan=2 class=xl113 width=290 style='border-right:.5pt solid black;
  border-left:none;width:218pt'>Purpose</td>
 </tr>
 <%
	decimal _total = 0;
	string Inword = "";
    for (int i=0; i< dt.Rows.Count; i++)
    {
	Inword = CommondLib.Num2VNText(dt.Rows[i][3].ToString(), "VND");
        string SQL3 = " SELECT upper(substr(trim('" + Inword + "'),1,1)) || substr(lower(trim(HR_F_BO_DAU('" + Inword + "'))),2, length(trim('" + Inword + "')))  from dual ";
        DataTable dt_t = ESysLib.TableReadOpen(SQL3);

        if (dt_t.Rows.Count > 0)
        {
            Inword = dt_t.Rows[i][0].ToString();
        }
	_total += decimal.Parse(dt.Rows[i][3].ToString());
 %>
 <tr height=40 style='height:30.0pt'>
  <td height=40 class=xl89 style='height:30.0pt' x:num><% =dt.Rows[i][0].ToString()%></td>
  <td class=xl90 width=195 style='border-left:none;width:146pt;border-bottom:.5pt hairline windowtext;'><% =dt.Rows[i][1].ToString()%></td>
  <td class=xl91 style='border-left:none;border-bottom:.5pt hairline windowtext;'><% =dt.Rows[i][2].ToString()%></td>
  <td class=xl104 style='border-left:none;border-bottom:.5pt hairline windowtext;' x:num><% =dt.Rows[i][3].ToString()%></td>
  <td class=xl90 width=200 style='border-left:none;width:150pt;border-bottom:.5pt hairline windowtext;'  ><%=Inword%></td>
  <td class=xl90 width=200 style='border-left:none;width:150pt;border-bottom:.5pt hairline windowtext;'  ><% =dt.Rows[i][4].ToString()%></td>
  <td class=xl96 style='border-left:none;border-bottom:.5pt hairline windowtext;'><% =dt.Rows[i][5].ToString()%></td>
  <td colspan=2 class=xl115 width=290 style='border-right:.5pt solid black;  border-left:none;width:218pt;border-bottom:.5pt hairline windowtext;'><% =dt.Rows[i][6].ToString()%></td>
 </tr>
 <%
    }
 %> 
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl81 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl76 width=195 style='border-left:none;width:146pt'>&nbsp;</td>
  <td class=xl77 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl76 width=200 style='border-left:none;width:150pt'>&nbsp;</td>
  <td class=xl76 width=200 style='border-left:none;width:150pt'>&nbsp;</td>
  <td class=xl97 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl109 width=290 style='border-right:.5pt solid black;
  border-left:none;width:218pt'>&nbsp;</td>
 </tr>
 <tr class=xl80 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl93 width=54 style='height:18.75pt;width:41pt'>&nbsp;</td>
  <td class=xl93 width=195 style='border-left:none;width:146pt'>TOTAL</td>
  <td class=xl93 width=52 style='border-left:none;width:39pt'>&nbsp;</td>
  <td class=xl106 style='border-left:none' x:num><span  style='mso-spacerun:yes'> </span><%=_total%></td>
  <td class=xl93 width=200 style='border-left:none;width:150pt'>&nbsp;</td>
  <td class=xl93 width=200 style='border-left:none;width:150pt'>&nbsp;</td>
  <td class=xl93 width=151 style='border-left:none;width:113pt'>&nbsp;</td>
  <td colspan=2 class=xl111 width=290 style='border-right:.5pt solid black;
  border-left:none;width:218pt'>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl82 style='height:15.0pt'></td>
  <td class=xl83></td>
  <td class=xl82></td>
  <td class=xl84></td>
  <td class=xl83></td>
  <td colspan=2 class=xl85 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl79></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl79></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl79></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=54 style='width:41pt'></td>
  <td width=195 style='width:146pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=200 style='width:150pt'></td>
  <td width=151 style='width:113pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
