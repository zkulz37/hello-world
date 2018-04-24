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
	string l_company_pk = "" + Request["company_pk"];
	string l_account_pk = "" + Request["account_pk"];
	string l_date_from	= ""+ Request["dtbFrom"];
	string l_date_to = "" + Request["dtbTo"];
	string l_ccy = ""+Request["ccy"];
	string l_status = "" +Request["status"];
	string l_book_ccy = ""+Request["bookccy"];
	string l_cust_pk = ""+Request["cust_pk"];
	string p_cmp_name = "";
	string p_cmp_add = "";
	string p_cmp_taxcode = "";
	string p_acc_code ="";
	string p_acc_name ="";
	string p_dt_from ="";
	string p_dt_to ="";
	string p_cust_name ="";
	string p_cust_code ="";
	string p_cd_dr_num ="1";

	string p_open_bal_xls = "0";
	string p_close_bal_xls = "0";
	string p_debit_xls = "0";
	string p_credit_xls = "0";
	string p_open_bal = "0";
	string p_acc_pk_arr ="";
	string p_temp ="";
	string strDate = "";
	string strDate_Dsp = "";

	string l_report_dd = "";
	string l_report_mm = "";
	string l_report_yy = "";
	int i =0;
	
	String p_xls_ccy_book ="";
    String p_xls_ccy_trans = "";
    if (l_book_ccy == "VND")
    {
        p_xls_ccy_book = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_trans = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_book = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_trans = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    
	string SQL = " SELECT partner_lname, addr2, tax_code  FROM tco_company WHERE pk = '" + l_company_pk + "' ";
	
	DataTable dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count >0)
    {
        p_cmp_name = dt.Rows[0][0].ToString();
        p_cmp_add = dt.Rows[0][1].ToString();
        p_cmp_taxcode = dt.Rows[0][2].ToString();
    }
   
   SQL= "SELECT DECODE(ac_get_DRCRTYPE('"+l_company_pk+"','"+l_account_pk+"'),'D','1','C','-1','1') FROM DUAL " ; 
	dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count >0)
    {
        p_cd_dr_num = dt.Rows[0][0].ToString();
    }

    SQL = " SELECT AC_CD_formular AC_CD,AC_NM, to_char(to_date('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') frm_date, ";
	SQL += "to_char(to_date('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') t_date  ";
	SQL += "FROM TAC_ABACCTCODE a WHERE a.pk = '" + l_account_pk + "' ";

	DataTable dt1 = ESysLib.TableReadOpen(SQL);
	if(dt1.Rows.Count>0)
	{
		p_acc_code = dt1.Rows[0][0].ToString();
	    p_acc_name = dt1.Rows[0][1].ToString();
	    p_dt_from = dt1.Rows[0][2].ToString();
		p_dt_to = dt1.Rows[0][3].ToString();
	}
	if (l_cust_pk!="")
	{
	    SQL= "SELECT PARTNER_ID,PARTNER_NAME,PARTNER_LNAME FROM TCO_BUSPARTNER WHERE PK = "+l_cust_pk;
	    dt = ESysLib.TableReadOpen(SQL);
        if (dt.Rows.Count >0)
        {
            p_cust_code = dt.Rows[0][0].ToString();
            p_cust_name = dt.Rows[0][1].ToString();
        }
        
	}
	l_report_dd = l_date_to.Substring(6,2);
	l_report_mm = l_date_to.Substring(4,2);
	l_report_yy = l_date_to.Substring(0,4);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="8989_files/filelist.xml">
<link rel=Edit-Time-Data href="8989_files/editdata.mso">
<link rel=OLE-Object-Data href="8989_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>kiet</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2008-09-11T08:59:43Z</o:LastPrinted>
  <o:Created>2007-10-11T03:53:00Z</o:Created>
  <o:LastSaved>2009-01-22T08:14:37Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.5in .25in .25in .75in;
	mso-header-margin:.25in;
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
	font-family:"Times New Roman";
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
	font-family:"Times New Roman";
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
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl47
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl48
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl54
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl55
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:center;}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	text-align:center;}
.xl61
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;}
.xl62
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}	
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Monthly Partner Balance</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>58</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>94</x:Zoom>
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
       <x:ActiveRow>2</x:ActiveRow>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>5460</x:WindowHeight>
  <x:WindowWidth>14970</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1545</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Monthly Partner Balance'!$A$6:$I$7</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1526 style='border-collapse:
 collapse;table-layout:fixed;width:1142pt'>
 <col class=xl24 width=88 style='mso-width-source:userset;mso-width-alt:3754;
 width:66pt'>
 <col class=xl24 width=249 style='mso-width-source:userset;mso-width-alt:10624;
 width:187pt'>
 <col class=xl24 width=49 style='mso-width-source:userset;mso-width-alt:2090;
 width:37pt'>
 <col class=xl24 width=95 span=12 style='mso-width-source:userset;mso-width-alt:
 4053;width:71pt'>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl25 colspan=2 width=337 style='height:18.75pt;
  mso-ignore:colspan;width:253pt'><%=p_cmp_name %></td>
  <td class=xl24 width=49 style='width:37pt'></td>
  <td class=xl24 width=95 style='width:71pt'></td>
  <td class=xl24 width=95 style='width:71pt'></td>
  <td class=xl24 width=95 style='width:71pt'></td>
  <td class=xl24 width=95 style='width:71pt'></td>
  <td class=xl24 width=95 style='width:71pt'></td>
  <td class=xl24 width=95 style='width:71pt'></td>
  <td class=xl24 width=95 style='width:71pt'></td>
  <td class=xl24 width=95 style='width:71pt'></td>
  <td class=xl24 width=95 style='width:71pt'></td>
  <td class=xl24 width=95 style='width:71pt'></td>
  <td class=xl24 width=95 style='width:71pt'></td>
  <td class=xl24 width=95 style='width:71pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 colspan=2 style='height:12.75pt;mso-ignore:colspan'>Monthly
  Partner Balance</td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'>at</td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl28 x:str="Account code : ">Account code :<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl29 x:num><%=p_acc_code %></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'><%=p_acc_name %></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 colspan=2 style='height:12.75pt;mso-ignore:colspan'>From <%= p_dt_from %> to <%=p_dt_to %></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl28><% if (p_cust_code!="") { %>Partner :<%} %></td>
  <td class=xl29><%=p_cust_code %></td>
  <td class=xl27 style='mso-ignore:colspan'><%=p_cust_name %></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=2 height=40 class=xl45 style='border-bottom:.5pt solid black;
  height:30.0pt'>Partner ID</td>
  <td rowspan=2 class=xl45 style='border-bottom:.5pt solid black'>Partner Name</td>
  <td rowspan=2 class=xl45 style='border-bottom:.5pt solid black'>Ccy</td>
  <td colspan=2 class=xl54 style='border-left:none'>Opening Balance</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:
  none'>Trans</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:
  none'>Book</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:
  none'>Acc. Trans</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:
  none'>Acc. Books</td>
  <td colspan=2 class=xl54 style='border-left:none'>Closing Balance</td>
 </tr>
 <tr class=xl30 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl54 style='height:15.0pt;border-top:none;border-left:
  none'>Trans</td>
  <td class=xl54 style='border-top:none;border-left:none'>Book</td>
  <td class=xl31>Debit</td>
  <td class=xl31>Credit</td>
  <td class=xl31>Debit</td>
  <td class=xl31>Credit</td>
  <td class=xl31>Debit</td>
  <td class=xl31>Credit</td>
  <td class=xl31>Debit</td>
  <td class=xl31>Credit</td>
  <td class=xl54 style='border-top:none;border-left:none'>Trans</td>
  <td class=xl54 style='border-top:none;border-left:none'>Book</td>
 </tr>
<%
SQL = "SELECT N.TCO_BUSPARTNER_PK,N.TAC_ABACCTCODE_PK , B.PARTNER_ID, B.PARTNER_NAME,DECODE('"+l_account_pk+"','',SF_A_GET_ACCD(N.TAC_ABACCTCODE_PK,'"+l_company_pk+"'),'') ACCD, " + 
        "        N.CCY,N.OPEN_FBAL,N.OPEN_BAL,N.DR_FSUM,N.CR_FSUM,N.DR_SUM,N.CR_SUM, " +
        "        N.ACC_DR_FSUM,N.ACC_CR_FSUM,N.ACC_DR_SUM,N.ACC_CR_SUM, " +
        "        N.CLOSE_FBAL,N.CLOSE_BAL " +
        "    FROM " +
        "    ( " +
        "    SELECT  " +
        "    NVL(G.TAC_ABACCTCODE_PK,H.TAC_ABACCTCODE_PK) TAC_ABACCTCODE_PK, " +
        "    NVL(G.TCO_BUSPARTNER_PK,H.TCO_BUSPARTNER_PK) TCO_BUSPARTNER_PK, " +
        "    NVL(G.CCY,H.CCY) CCY,NVL(G.OPEN_FBAL,0) OPEN_FBAL,NVL(G.OPEN_BAL,0) OPEN_BAL,  " +
        "        NVL(H.DR_FSUM,0) DR_FSUM, NVL(H.CR_FSUM,0) CR_FSUM, " +
        "        NVL(H.DR_SUM,0) DR_SUM, NVL(H.CR_SUM,0) CR_SUM, " +
        "        (NVL(G.O_DR_FSUM,0) + NVL(H.DR_FSUM,0)) ACC_DR_FSUM, " +
        "        (NVL(G.O_CR_FSUM,0) + NVL(H.CR_FSUM,0)) ACC_CR_FSUM, " +
        "        (NVL(G.O_DR_SUM,0)  + NVL(H.DR_SUM,0)) ACC_DR_SUM, " +
        "        (NVL(G.O_CR_SUM,0)  + NVL(H.CR_SUM,0)) ACC_CR_SUM, " +
        "        (NVL(G.OPEN_FBAL,0) + (NVL(H.DR_FSUM,0)- NVL(H.CR_FSUM,0))*TO_NUMBER('"+p_cd_dr_num+"') ) CLOSE_FBAL, " +
        "        (NVL(G.OPEN_BAL,0) + (NVL(H.DR_SUM,0)- NVL(H.CR_SUM,0))*TO_NUMBER('"+p_cd_dr_num+"') ) CLOSE_BAL " +
        "    FROM  " +
        "    ( " +
        "    SELECT  " +
        "    NVL(E.TAC_ABACCTCODE_PK,F.TAC_ABACCTCODE_PK) TAC_ABACCTCODE_PK, " +
        "    NVL(E.TCO_BUSPARTNER_PK,F.TCO_BUSPARTNER_PK) TCO_BUSPARTNER_PK, " +
        "    NVL(E.CCY,F.CCY) CCY,(NVL(E.OPEN_FBAL1,0)+NVL(F.OPEN_FBAL2,0)) OPEN_FBAL, " +
        "    (NVL(E.OPEN_BAL1,0)+ NVL(F.OPEN_BAL2,0)) OPEN_BAL, " +
        "    (NVL(E.O_DR_FSUM1,0) + NVL(F.O_DR_FSUM2,0)) O_DR_FSUM, " +
        "    (NVL(E.O_CR_FSUM1,0) + NVL(F.O_CR_FSUM2,0)) O_CR_FSUM, " +
        "    (NVL(E.O_DR_SUM1,0)  + NVL(F.O_DR_SUM2,0)) O_DR_SUM, " +
        "    (NVL(E.O_CR_SUM1,0)  + NVL(F.O_CR_SUM2,0)) O_CR_SUM " +
        "    FROM " +
        "    ( " +
        "    SELECT M.TAC_ABACCTCODE_PK,M.TCO_BUSPARTNER_PK ,M.CCY,(SUM(NVL(M.THIS_DRFAMT,0)) - SUM(NVL(M.THIS_CRFAMT,0)))*TO_NUMBER('"+p_cd_dr_num+"') OPEN_FBAL1, " +
        "        (SUM(NVL(M.THIS_DRAMT,0)) - SUM(NVL(M.THIS_CRAMT,0)))*TO_NUMBER('"+p_cd_dr_num+"') OPEN_BAL1, " +
        "        SUM(NVL(M.THIS_DRFAMT,0)) O_DR_FSUM1, SUM(NVL(M.THIS_CRFAMT,0)) O_CR_FSUM1, " +
        "        SUM(NVL(M.THIS_DRAMT,0)) O_DR_SUM1,SUM(NVL(M.THIS_CRAMT,0)) O_CR_SUM1 " +
        "    FROM TAC_HGCUSTMMBAL M " +
        "        WHERE M.DEL_IF =0  " +
        "        AND M.TCO_COMPANY_PK = '"+l_company_pk+"' " +
        "        AND M.TR_STATUS = '"+l_status+"' " +
        "        AND (('"+l_ccy+"' IS NULL) OR (M.CCY = '"+l_ccy+"')) " +
        "        AND DECODE('"+l_account_pk+"','',1,M.TAC_ABACCTCODE_PK) = DECODE('"+l_account_pk+"','',1,'"+l_account_pk+"') " +
        "        AND (M.STD_YM||'01') = ac_get_LASTCLOSEMM ('"+l_date_from+"','"+l_company_pk+"') " +
        "        AND DECODE('"+l_cust_pk+"','',1,M.TCO_BUSPARTNER_PK) = DECODE('"+l_cust_pk+"','',1,'"+l_cust_pk+"') " +
        "    GROUP BY M.TAC_ABACCTCODE_PK,M.TCO_BUSPARTNER_PK,M.CCY) E FULL OUTER JOIN  " +
        "    ( " +
        "    SELECT D.TAC_ABACCTCODE_PK,D.TCO_BUSPARTNER_PK,  D.CCY,  " +
        "        (SUM(NVL(D.YMD_DRTRANS,0)) -SUM(NVL(D.YMD_CRTRANS,0)))*TO_NUMBER('"+p_cd_dr_num+"') OPEN_FBAL2, " +
        "        (SUM(NVL(D.YMD_DRBOOKS,0))-SUM(NVL(D.YMD_CRBOOKS,0)))*TO_NUMBER('"+p_cd_dr_num+"') OPEN_BAL2, " +
        "        SUM(NVL(D.YMD_DRTRANS,0)) O_DR_FSUM2, SUM(NVL(D.YMD_CRTRANS,0)) O_CR_FSUM2, " +
        "        SUM(NVL(D.YMD_DRBOOKS,0)) O_DR_SUM2, SUM(NVL(D.YMD_CRBOOKS,0)) O_CR_SUM2 " +
        "        FROM TAC_HGCUSTDDBAL D " +
        "        WHERE D.DEL_IF =0 " +
        "         AND D.TCO_COMPANY_PK = '"+l_company_pk+"' " +
        "         AND D.TR_STATUS = '"+l_status+"' " +
        "         AND (('"+l_ccy+"' IS NULL) OR (D.CCY = '"+l_ccy+"')) " +
        "         AND DECODE('"+l_account_pk+"','',1,D.TAC_ABACCTCODE_PK) = DECODE('"+l_account_pk+"','',1,'"+l_account_pk+"') " +
        "         AND DECODE('"+l_cust_pk+"','',1,D.TCO_BUSPARTNER_PK) = DECODE('"+l_cust_pk+"','',1,'"+l_cust_pk+"') " +
        "         AND D.STD_YMD >= TO_CHAR(ADD_MONTHS(TO_DATE(ac_get_LASTCLOSEMM ('"+l_date_from+"','"+l_company_pk+"'),'YYYYMMDD'),+1),'YYYYMMDD') " +
        "         AND D.STD_YMD < '"+l_date_from+"' " +
        "         GROUP BY D.TAC_ABACCTCODE_PK,D.TCO_BUSPARTNER_PK, D.CCY " +
        "       ) F " +
        "       ON E.TAC_ABACCTCODE_PK = F.TAC_ABACCTCODE_PK AND E.TCO_BUSPARTNER_PK=F.TCO_BUSPARTNER_PK AND F.CCY = E.CCY " +
        "       ) G FULL OUTER JOIN  " +
        "       ( " +
        "       SELECT D.TAC_ABACCTCODE_PK,D.TCO_BUSPARTNER_PK,D.CCY,  " +
        "            SUM(NVL(D.YMD_DRTRANS,0)) DR_FSUM,SUM(NVL(D.YMD_CRTRANS,0)) CR_FSUM, " +
        "            SUM(NVL(D.YMD_DRBOOKS,0)) DR_SUM,SUM(NVL(D.YMD_CRBOOKS,0)) CR_SUM " +
        "        FROM TAC_HGCUSTDDBAL D " +
        "        WHERE D.DEL_IF =0 " +
        "         AND D.TCO_COMPANY_PK = '"+l_company_pk+"' " +
        "         AND D.TR_STATUS = '"+l_status+"' " +
        "         AND (('"+l_ccy+"' IS NULL) OR (D.CCY = '"+l_ccy+"')) " +
        "         AND DECODE('"+l_account_pk+"','',1,D.TAC_ABACCTCODE_PK) = DECODE('"+l_account_pk+"','',1,'"+l_account_pk+"') " +
        "         AND DECODE('"+l_cust_pk+"','',1,D.TCO_BUSPARTNER_PK) = DECODE('"+l_cust_pk+"','',1,'"+l_cust_pk+"') " +
        "         AND D.STD_YMD BETWEEN '"+l_date_from+"' AND '"+l_date_to+"' " +
        "         GROUP BY D.TAC_ABACCTCODE_PK,D.TCO_BUSPARTNER_PK,D.CCY " +
        "         ) H " +
        "         ON G.TAC_ABACCTCODE_PK = H.TAC_ABACCTCODE_PK AND G.TCO_BUSPARTNER_PK=H.TCO_BUSPARTNER_PK AND G.CCY = H.CCY " +
        "       ) N, TCO_BUSPARTNER B " +
        "       WHERE N.TCO_BUSPARTNER_PK = B.PK " +
        "       ORDER BY PARTNER_ID,ACCD,CCY,TAC_ABACCTCODE_PK " ;

    DataTable dt_detail = ESysLib.TableReadOpen(SQL);
    if (dt_detail.Rows.Count >0)
	{ 
	    for(i=0;i<dt_detail.Rows.Count;i++)
		{
 %>
 <tr class=xl32 height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'><%=dt_detail.Rows[i][2].ToString()%></td>
  <td class=xl34 width=249 style='width:187pt'><%=dt_detail.Rows[i][3].ToString()%></td>
  <td class=xl35><%=dt_detail.Rows[i][5].ToString()%></td>
  <td class=xl55 style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy_trans %>';" x:num><%=dt_detail.Rows[i][6].ToString()%></td>
  <td class=xl55 style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy_book %>';" x:num><%=dt_detail.Rows[i][7].ToString()%></td>
  <td class=xl37 x:num style="mso-number-format:'<%= p_xls_ccy_trans %>'"><%=dt_detail.Rows[i][8].ToString()%></td>
  <td class=xl37 x:num  style="mso-number-format:'<%= p_xls_ccy_trans %>'"><%=dt_detail.Rows[i][9].ToString()%></td>
  <td class=xl36 x:num  style="mso-number-format:'<%= p_xls_ccy_book %>'"><%=dt_detail.Rows[i][10].ToString()%></td>
  <td class=xl36 x:num style="mso-number-format:'<%= p_xls_ccy_book %>'"><%=dt_detail.Rows[i][11].ToString()%></td>
  <td class=xl37 x:num style="mso-number-format:'<%= p_xls_ccy_trans %>'"><%=dt_detail.Rows[i][12].ToString()%></td>
  <td class=xl37 x:num style="mso-number-format:'<%= p_xls_ccy_trans %>'"><%=dt_detail.Rows[i][13].ToString()%></td>
  <td class=xl36 x:num style="mso-number-format:'<%= p_xls_ccy_book %>'"><%=dt_detail.Rows[i][14].ToString()%></td>
  <td class=xl36 x:num style="mso-number-format:'<%= p_xls_ccy_book %>'"><%=dt_detail.Rows[i][15].ToString()%></td>
  <td class=xl36 align=right x:num style="mso-number-format:'<%= p_xls_ccy_trans %>'"><%=dt_detail.Rows[i][16].ToString()%></td>
  <td class=xl36 align=right x:num style="mso-number-format:'<%= p_xls_ccy_book %>'"><%=dt_detail.Rows[i][17].ToString()%></td>
 </tr>
  <%
    }
}
%>

 <tr class=xl38 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 rowspan=2 height=40 class=xl47 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:30.0pt'>Ccy</td>
  <td colspan=2 class=xl54 style='border-left:none'>Opening Balance</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:
  none'>Trans</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:
  none'>Book</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:
  none'>Acc. Trans</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:
  none'>Acc. Books</td>
  <td colspan=2 class=xl54 style='border-left:none'>Closing Balance</td>
 </tr>
 <tr class=xl38 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl54 style='height:15.0pt;border-top:none;border-left:
  none'>Trans</td>
  <td class=xl54 style='border-top:none;border-left:none'>Book</td>
  <td class=xl31>Debit</td>
  <td class=xl31>Credit</td>
  <td class=xl31>Debit</td>
  <td class=xl31>Credit</td>
  <td class=xl31>Debit</td>
  <td class=xl31>Credit</td>
  <td class=xl31>Debit</td>
  <td class=xl31>Credit</td>
  <td class=xl54 style='border-top:none;border-left:none'>Trans</td>
  <td class=xl54 style='border-top:none;border-left:none'>Book</td>
 </tr>

 <%
SQL = "SELECT CCY,OPEN_FBAL,OPEN_BAL,DR_FSUM,CR_FSUM,DR_SUM,CR_SUM, " + 
        "            ACC_DR_FSUM,ACC_CR_FSUM,ACC_DR_SUM,ACC_CR_SUM, " +
        "            CLOSE_FBAL,CLOSE_BAL " +
        "        FROM " +
        "        ( " +
        "        SELECT NVL(G.CCY,H.CCY) CCY,NVL(G.OPEN_FBAL,0) OPEN_FBAL,NVL(G.OPEN_BAL,0) OPEN_BAL,  " +
        "            NVL(H.DR_FSUM,0) DR_FSUM, NVL(H.CR_FSUM,0) CR_FSUM, " +
        "            NVL(H.DR_SUM,0) DR_SUM, NVL(H.CR_SUM,0) CR_SUM, " +
        "            (NVL(G.O_DR_FSUM,0) + NVL(H.DR_FSUM,0)) ACC_DR_FSUM, " +
        "            (NVL(G.O_CR_FSUM,0) + NVL(H.CR_FSUM,0)) ACC_CR_FSUM, " +
        "            (NVL(G.O_DR_SUM,0)  + NVL(H.DR_SUM,0)) ACC_DR_SUM, " +
        "            (NVL(G.O_CR_SUM,0)  + NVL(H.CR_SUM,0)) ACC_CR_SUM, " +
        "            (NVL(G.OPEN_FBAL,0) + (NVL(H.DR_FSUM,0)- NVL(H.CR_FSUM,0))*TO_NUMBER('"+p_cd_dr_num+"') ) CLOSE_FBAL, " +
        "            (NVL(G.OPEN_BAL,0) + (NVL(H.DR_SUM,0)- NVL(H.CR_SUM,0))*TO_NUMBER('"+p_cd_dr_num+"') ) CLOSE_BAL " +
        "        FROM  " +
        "        ( " +
        "        SELECT NVL(E.CCY,F.CCY) CCY,(NVL(E.OPEN_FBAL1,0)+NVL(F.OPEN_FBAL2,0)) OPEN_FBAL, " +
        "        (NVL(E.OPEN_BAL1,0)+ NVL(F.OPEN_BAL2,0)) OPEN_BAL, " +
        "        (NVL(E.O_DR_FSUM1,0) + NVL(F.O_DR_FSUM2,0)) O_DR_FSUM, " +
        "        (NVL(E.O_CR_FSUM1,0) + NVL(F.O_CR_FSUM2,0)) O_CR_FSUM, " +
        "        (NVL(E.O_DR_SUM1,0)  + NVL(F.O_DR_SUM2,0)) O_DR_SUM, " +
        "        (NVL(E.O_CR_SUM1,0)  + NVL(F.O_CR_SUM2,0)) O_CR_SUM " +
        "        FROM " +
        "        ( " +
        "        SELECT M.CCY,(SUM(NVL(M.THIS_DRFAMT,0)) - SUM(NVL(M.THIS_CRFAMT,0)))*TO_NUMBER('"+p_cd_dr_num+"') OPEN_FBAL1, " +
        "        (SUM(NVL(M.THIS_DRAMT,0)) - SUM(NVL(M.THIS_CRAMT,0)))*TO_NUMBER('"+p_cd_dr_num+"') OPEN_BAL1, " +
        "        SUM(NVL(M.THIS_DRFAMT,0)) O_DR_FSUM1, SUM(NVL(M.THIS_CRFAMT,0)) O_CR_FSUM1, " +
        "        SUM(NVL(M.THIS_DRAMT,0)) O_DR_SUM1,SUM(NVL(M.THIS_CRAMT,0)) O_CR_SUM1 " +
        "        FROM TAC_HGCUSTMMBAL M " +
        "        WHERE M.DEL_IF =0  " +
        "        AND M.TCO_COMPANY_PK = '"+l_company_pk+"' " +
        "        AND M.TR_STATUS = '"+l_status+"' " +
        "        AND (('"+l_ccy+"' IS NULL) OR (M.CCY = '"+l_ccy+"')) " +
        "        AND DECODE('"+l_account_pk+"','',1,M.TAC_ABACCTCODE_PK) = DECODE('"+l_account_pk+"','',1,'"+l_account_pk+"') " +
        "        AND (M.STD_YM||'01') = ac_get_LASTCLOSEMM ('"+l_date_from+"','"+l_company_pk+"') " +
        "        AND DECODE('"+l_cust_pk+"','',1,M.TCO_BUSPARTNER_PK) = DECODE('"+l_cust_pk+"','',1,'"+l_cust_pk+"') " +
        "        GROUP BY M.CCY) E FULL OUTER JOIN  " +
        "        (SELECT D.CCY, (SUM(NVL(D.YMD_DRTRANS,0)) -SUM(NVL(D.YMD_CRTRANS,0)))*TO_NUMBER('"+p_cd_dr_num+"') OPEN_FBAL2, " +
        "        (SUM(NVL(D.YMD_DRBOOKS,0))-SUM(NVL(D.YMD_CRBOOKS,0)))*TO_NUMBER('"+p_cd_dr_num+"') OPEN_BAL2, " +
        "            SUM(NVL(D.YMD_DRTRANS,0)) O_DR_FSUM2, SUM(NVL(D.YMD_CRTRANS,0)) O_CR_FSUM2, " +
        "            SUM(NVL(D.YMD_DRBOOKS,0)) O_DR_SUM2, SUM(NVL(D.YMD_CRBOOKS,0)) O_CR_SUM2 " +
        "            FROM TAC_HGCUSTDDBAL D " +
        "            WHERE D.DEL_IF =0 " +
        "             AND D.TCO_COMPANY_PK = '"+l_company_pk+"' " +
        "             AND D.TR_STATUS = '"+l_status+"' " +
        "             AND (('"+l_ccy+"' IS NULL) OR (D.CCY = '"+l_ccy+"')) " +
        "             AND DECODE('"+l_account_pk+"','',1,D.TAC_ABACCTCODE_PK) = DECODE('"+l_account_pk+"','',1,'"+l_account_pk+"') " +
        "             AND DECODE('"+l_cust_pk+"','',1,D.TCO_BUSPARTNER_PK) = DECODE('"+l_cust_pk+"','',1,'"+l_cust_pk+"') " +
        "             AND D.STD_YMD >= TO_CHAR(ADD_MONTHS(TO_DATE(ac_get_LASTCLOSEMM ('"+l_date_from+"','"+l_company_pk+"'),'YYYYMMDD'),+1),'YYYYMMDD') " +
        "             AND D.STD_YMD < '"+l_date_from+"' " +
        "             GROUP BY D.CCY " +
        "           ) F " +
        "           ON F.CCY = E.CCY " +
        "           ) G FULL OUTER JOIN  " +
        "           ( " +
        "           SELECT D.CCY, SUM(NVL(D.YMD_DRTRANS,0)) DR_FSUM,SUM(NVL(D.YMD_CRTRANS,0)) CR_FSUM, " +
        "                SUM(NVL(D.YMD_DRBOOKS,0)) DR_SUM,SUM(NVL(D.YMD_CRBOOKS,0)) CR_SUM " +
        "            FROM TAC_HGCUSTDDBAL D " +
        "            WHERE D.DEL_IF =0 " +
        "             AND D.TCO_COMPANY_PK = '"+l_company_pk+"' " +
        "             AND D.TR_STATUS = '"+l_status+"' " +
        "             AND (('"+l_ccy+"' IS NULL) OR (D.CCY = '"+l_ccy+"')) " +
        "             AND DECODE('"+l_account_pk+"','',1,D.TAC_ABACCTCODE_PK) = DECODE('"+l_account_pk+"','',1,'"+l_account_pk+"') " +
        "             AND DECODE('"+l_cust_pk+"','',1,D.TCO_BUSPARTNER_PK) = DECODE('"+l_cust_pk+"','',1,'"+l_cust_pk+"') " +
        "             AND D.STD_YMD BETWEEN '"+l_date_from+"' AND '"+l_date_to+"' " +
        "             GROUP BY D.CCY " +
        "             ) H " +
        "             ON G.CCY = H.CCY " +
        "            ) " +
        "            ORDER BY CCY " ;

    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    if (dt_total.Rows.Count >0)
	{ 
	    for(i=0;i<dt_total.Rows.Count;i++)
		{

  %>
 <tr class=xl32 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl42 style='border-right:.5pt solid black;
  height:15.0pt'><%=dt_total.Rows[i][0].ToString()%></td>
  <td class=xl56 align=right style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy_trans %>';" x:num><%=dt_total.Rows[i][1].ToString()%></td>
  <td class=xl56  align=right style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy_book %>';" x:num><%=dt_total.Rows[i][2].ToString()%></td>
  <td class=xl40  align=right style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy_trans %>';" x:num><%=dt_total.Rows[i][3].ToString()%></td>
  <td class=xl40 align=right style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy_trans %>';" x:num><%=dt_total.Rows[i][4].ToString()%></td>
  <td class=xl39 align=right style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy_book %>';" x:num><%=dt_total.Rows[i][5].ToString()%></td>
  <td class=xl39 align=right style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy_book %>';" x:num><%=dt_total.Rows[i][6].ToString()%></td>
  <td class=xl40 align=right style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy_trans %>';" x:num><%=dt_total.Rows[i][7].ToString()%></td>
  <td class=xl40 align=right style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy_trans %>';" x:num><%=dt_total.Rows[i][8].ToString()%></td>
  <td class=xl39 align=right style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy_book %>';" x:num><%=dt_total.Rows[i][9].ToString()%></td>
  <td class=xl39 align=right style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy_book %>';" x:num><%=dt_total.Rows[i][10].ToString()%></td>
  <td class=xl41 align=right style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy_trans %>';" x:num><%=dt_total.Rows[i][11].ToString()%></td>
  <td class=xl41 align=right style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy_book %>';" x:num><%=dt_total.Rows[i][12].ToString()%></td>
 </tr>
<%
        }
   }

 %>
 
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
  <td class=xl58></td>
  <td class=xl58 colspan=2 align=left style='mso-ignore:colspan'>Ngày <%= l_report_dd %> tháng
  <%= l_report_mm %> năm <%= l_report_yy %></td>
  <td class=xl24></td>
 </tr>
 <%
SQL = "SELECT   " +
            "    D.CODE, " +
            "    D.CHAR_1,  " +
            "    D.CHAR_2,  " +
            "    D.CHAR_3,  " +
            "    D.CHAR_4,  " +
            "    D.CHAR_5,  " +
            "    D.REMARK " +
            " FROM TAC_COMMCODE_DETAIL D, TAC_COMMCODE_MASTER M " +
            " WHERE D.DEL_IF=0 AND D.TAC_COMMCODE_MASTER_PK = M.PK " +
            " AND M.ID='EACAB012' " +
            " order by D.ORD ";
    DataTable dt10 = ESysLib.TableReadOpen(SQL);
    String e1 = "";
    String e2 = "";
    String e3 = "";
    String e4 = "";
    String e5 = "";
    String e6 = "";
    String v1 = "";
    String v2 = "";
    String v3 = "";
    String v4 = "";
    String v5 = "";
    String v6 = "";
    String g1 = "";
    String g2 = "";
    String g3 = "";
    String g4 = "";
    String g5 = "";
    String g6 = "";
    String n1 = "";
    String n2 = "";
    String n3 = "";
    String n4 = "";
    String n5 = "";
    String n6 = "";

    for (int k = 0; k < dt10.Rows.Count; k++)
    {

        string strTmp = dt10.Rows[k][0].ToString();
        if (strTmp == "ENG")
        {
            e1 = "" + dt10.Rows[k][1].ToString();
            e2 = "" + dt10.Rows[k][2].ToString();
            e3 = "" + dt10.Rows[k][3].ToString();
            e4 = "" + dt10.Rows[k][4].ToString();
            e5 = "" + dt10.Rows[k][5].ToString();
            e6 = "" + dt10.Rows[k][6].ToString();
        }

        if (strTmp == "VIE")
        {
            v1 = dt10.Rows[k][1].ToString();
            v2 = dt10.Rows[k][2].ToString();
            v3 = dt10.Rows[k][3].ToString();
            v4 = dt10.Rows[k][4].ToString();
            v5 = dt10.Rows[k][5].ToString();
            v6 = dt10.Rows[k][6].ToString();
        }
        if (strTmp == "SIG")
        {
            g1 = dt10.Rows[k][1].ToString();
            g2 = dt10.Rows[k][2].ToString();
            g3 = dt10.Rows[k][3].ToString();
            g4 = dt10.Rows[k][4].ToString();
            g5 = dt10.Rows[k][5].ToString();
            g6 = dt10.Rows[k][6].ToString();
        }

        if (strTmp == "NAM")
        {
            n1 = dt10.Rows[k][1].ToString();
            n2 = dt10.Rows[k][2].ToString();
            n3 = dt10.Rows[k][3].ToString();
            n4 = dt10.Rows[k][4].ToString();
            n5 = dt10.Rows[k][5].ToString();
            n6 = dt10.Rows[k][6].ToString();
        }
    }
	

 %> 
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl59 style='height:15.75pt'><%= v1 %></td>
  <td class=xl61></td>
  <td></td>
  <td colspan=4 class=xl59><%= v2 %></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl59><%= v3 %></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl60 style='height:15.75pt'><%=g1 %></td>
  <td class=xl62></td>
  <td></td>
  <td colspan=4 class=xl60><%=g2 %></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl60><%=g3 %></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl63 style='height:15.75pt'><%= n1 %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl63><%= n2 %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl63><%= n3 %></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=88 style='width:66pt'></td>
  <td width=249 style='width:187pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
