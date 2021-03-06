﻿<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string l_company_pk = ""+Request["p_company_pk"];
	string l_account_pk = ""+Request["p_acc_pk"];
	string l_date_from	= "" + Request["p_date_from"];
	string l_date_to = "" +Request["p_date_to"];
	string l_ccy = ""+ Request["p_ccy"];
	string l_status = ""+Request["p_status"];
    string l_openbal = "" + Request["p_openbal"];
    string l_status1 = "";
    //Response.Write(l_openbal);
    //Response.End();
	if (l_status=="")//Default status is confirm
	{
		l_status="2";
	}
    if (l_status == "2")
    {
        l_status1 = "Confirmed";
    }
    if (l_status == "0")
    {
        l_status1 = "Approved";
    }
	string p_cmp_name = "";
	string p_cmp_add = "";
	string p_cmp_taxcode = "";
	string p_acc_code ="";
	string p_acc_name ="";
	string p_acc_type = "";
	string p_dt_from ="";
	string p_dt_to ="";

	string p_open_bal_dr_xls = "0";
	string p_open_bal_cr_xls = "0";
	string p_close_bal_dr_xls = "0";
	string p_close_bal_cr_xls = "0";
	string p_debit_xls ="0";
	string p_credit_xls ="0";
	string p_open_bal = "0";
	string p_acc_pk_arr ="";
    string p_acc_num = "";
	int i =0;

    string SQL2 = " SELECT AC_CD,AC_LNM,UPPER(a.DRCR_TYPE),  to_char(to_date('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') frm_date, ";
    SQL2 += " to_char(to_date('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') t_date ,DECODE(UPPER(a.DRCR_TYPE),'D','1','-1') ";
    SQL2 += " FROM TAC_LOCALCODE a WHERE a.pk = '" + l_account_pk + "' ";

    DataTable dt2 = ESysLib.TableReadOpen(SQL2);
    if (dt2.Rows.Count > 0)
    {
        p_acc_code = dt2.Rows[0][0].ToString();
        p_acc_name = dt2.Rows[0][1].ToString();
        p_acc_type = dt2.Rows[0][2].ToString();
        p_dt_from =  dt2.Rows[0][3].ToString();
        p_dt_to =    dt2.Rows[0][4].ToString();
        p_acc_num =  dt2.Rows[0][5].ToString();
    }
    
	String p_xls_ccy_format ="";
    String p_xls_ccy_format_usd = "";
    if (l_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }

    string SQL = " SELECT PARTNER_NAME,ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + l_company_pk + "' ";

    DataTable dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count >0)
    {
        p_cmp_name = dt.Rows[0][0].ToString();
        p_cmp_add = dt.Rows[0][1].ToString();
        p_cmp_taxcode = dt.Rows[0][3].ToString();
    }
    string l_parameter = "'" + l_company_pk + "','" + l_account_pk + "','" + l_date_from + "','" + l_date_to + "','" + l_status + "','" + l_ccy + "','" + l_openbal + "'";
    string l_parameterSum = "'" + l_company_pk + "','" + l_account_pk + "','" + l_date_from + "','" + l_date_to + "','" + l_status + "','" + l_ccy  + "'";
    
    DataTable dtDetail = ESysLib.TableReadOpenCursor("ACNT.Sp_Sel_gfrv00020_3", l_parameter);//Data of Date,not voucher
    if (dtDetail.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    //Response.Write(dtDetail.Rows[2][5].ToString());
    //Response.End();
    DataTable dtSum = ESysLib.TableReadOpenCursor("ACNT.Sp_Sel_gfrv00020_1", l_parameterSum);
    //Response.Write(dtSum.Rows[1][4].ToString());
    //    Response.End();
    if (dtSum.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
 
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt20VC2_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt20VC2_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt20VC2_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>comp</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2009-01-06T06:41:53Z</o:LastPrinted>
  <o:Created>2005-01-28T07:20:51Z</o:Created>
  <o:LastSaved>2010-03-01T06:09:05Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.5in 0in .25in .5in;
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
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
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
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
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
	mso-number-format:"Short Date";
	text-align:right;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl50
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl61
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>SL Daily</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>50</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>95</x:Zoom>
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
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8355</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1980</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='SL Daily'!$6:$7</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1807 style='border-collapse:
 collapse;table-layout:fixed;width:1356pt'>
 <col class=xl24 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl24 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl24 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=30 style='mso-width-source:userset;mso-width-alt:1097;
 width:23pt'>
 <col class=xl24 width=89 span=4 style='mso-width-source:userset;mso-width-alt:
 3254;width:67pt'>
 <col class=xl24 width=180 style='mso-width-source:userset;mso-width-alt:6582;
 width:135pt'>
 <col class=xl24 width=240 style='mso-width-source:userset;mso-width-alt:8777;
 width:180pt'>
 <col class=xl24 width=187 style='mso-width-source:userset;mso-width-alt:6838;
 width:140pt'>
 <col class=xl24 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl24 width=131 style='mso-width-source:userset;mso-width-alt:4790;
 width:98pt'>
 <col class=xl24 width=127 style='mso-width-source:userset;mso-width-alt:4644;
 width:95pt'>
 <col class=xl24 width=64 span=3 style='width:48pt'>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl27 width=211 style='height:15.0pt;width:158pt'><%= p_cmp_name %></td>
  <td class=xl25 width=75 style='width:56pt'></td>
  <td class=xl25 width=30 style='width:23pt'></td>
  <td class=xl25 width=89 style='width:67pt'></td>
  <td class=xl24 width=89 style='width:67pt'></td>
  <td class=xl24 width=89 style='width:67pt'></td>
  <td class=xl24 width=89 style='width:67pt'></td>
  <td class=xl24 width=180 style='width:135pt'></td>
  <td class=xl24 width=240 style='width:180pt'></td>
  <td class=xl24 width=187 style='width:140pt'></td>
  <td class=xl24 width=78 style='width:59pt'></td>
  <td class=xl24 width=131 style='width:98pt'></td>
  <td class=xl24 width=127 style='width:95pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=8 class=xl26 style='height:15.0pt;mso-ignore:colspan'><%= p_cmp_add %></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'>Acc Code<span
  style='display:none'>:</span></td>
  <td colspan=2 class=xl47>&nbsp;<%= p_acc_code %></td>
  <td colspan=12 class=xl47><%= p_acc_name %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'>Date :</td>
  <td colspan=2 class=xl47 x:num><%= p_dt_from %> To </td>
  <td colspan=2 class=xl47 x:num><%= p_dt_to %></td>
  <td class=xl37>Status :</td>
  <td class=xl38><%=l_status1%></td>
  <td class=xl27></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=18 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=2 height=40 class=xl59 style='border-bottom:.5pt solid black;
  height:30.0pt'>Seq</td>
  <td rowspan=2 class=xl51 width=76 style='border-bottom:.5pt solid black;
  width:57pt'>Voucher<br>
    No</td>
  <td rowspan=2 class=xl51 width=68 style='border-bottom:.5pt solid black;
  width:51pt'>Trans Date</td>
  <td rowspan=2 class=xl51 width=75 style='border-bottom:.5pt solid black;
  width:56pt'>Proposed<br>
    By</td>
  <td rowspan=2 class=xl59 style='border-bottom:.5pt solid black'>Ccy</td>
  <td rowspan=2 class=xl51 width=89 style='border-bottom:.5pt solid black;
  width:67pt'>Openning Book Balance</td>
  <td colspan=2 class=xl49 style='border-right:.5pt solid black'>Books</td>
  <td rowspan=2 class=xl51 width=89 style='border-bottom:.5pt solid black;
  width:67pt'>CFM Balance</td>
  <td rowspan=2 class=xl59 style='border-bottom:.5pt solid black'>Customer</td>
  <td colspan=2 class=xl61 style='border-right:.5pt solid black;border-left:
  none'>Description</td>
  <td rowspan=2 class=xl59 style='border-bottom:.5pt solid black'>PL</td>
  <td rowspan=2 class=xl59 style='border-bottom:.5pt solid black'>Item Control</td>
  <td rowspan=2 class=xl59 style='border-bottom:.5pt solid black'>Enclose</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt'>Debit</td>
  <td class=xl29>Credit</td>
  <td class=xl29>Foreign</td>
  <td class=xl29>Local</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <%
     for (i = 1; i < dtDetail.Rows.Count; i++)
     {
         if (i == 1)
         {
         %>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl41 style='height:20.1pt'><%= dtDetail.Rows[i][0].ToString()%></td>
  <td class=xl42><%= dtDetail.Rows[i][1].ToString()%></td>
  <td class=xl42><%= dtDetail.Rows[i][2].ToString()%></td>
  <td class=xl43><%= dtDetail.Rows[i][3].ToString()%></td>
  <td class=xl42><%= dtDetail.Rows[i][4].ToString()%></td>
  <td class=xl44 x:num><span style='mso-spacerun:yes'> </span><%= dtDetail.Rows[i][5].ToString()%></td>
  <td class=xl44 x:num><span style='mso-spacerun:yes'> </span><%= dtDetail.Rows[i][6].ToString()%></td>
  <td class=xl44 x:num><span
  style='mso-spacerun:yes'> </span><%= dtDetail.Rows[i][8].ToString()%></td>
  <td class=xl44 x:num><font color="#FF0000" style='mso-ignore:color'><span
  style='mso-spacerun:yes'>  </span><%= dtDetail.Rows[i][10].ToString()%></font></td>
  <td class=xl45><%= dtDetail.Rows[i][11].ToString()%></td>
  <td class=xl43><%= dtDetail.Rows[i][12].ToString()%></td>
  <td class=xl43><%= dtDetail.Rows[i][13].ToString()%></td>
  <td class=xl43><%= dtDetail.Rows[i][19].ToString()%></td>
  <td class=xl43><%= dtDetail.Rows[i][20].ToString()%></td>
  <td class=xl46><%= dtDetail.Rows[i][21].ToString()%></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <%
     }
     else
     {
              %>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl41 style='height:20.1pt'><%= dtDetail.Rows[i][0].ToString()%></td>
  <td class=xl42><%= dtDetail.Rows[i][1].ToString()%></td>
  <td class=xl42><%= dtDetail.Rows[i][2].ToString()%></td>
  <td class=xl43><%= dtDetail.Rows[i][3].ToString()%></td>
  <td class=xl42><%= dtDetail.Rows[i][4].ToString()%></td>
  <td class=xl44 x:num><span style='mso-spacerun:yes'> </span><%= dtDetail.Rows[i-1][10].ToString()%></td>
  <td class=xl44 x:num><span style='mso-spacerun:yes'> </span><%= dtDetail.Rows[i][6].ToString()%></td>
  <td class=xl44 x:num><span
  style='mso-spacerun:yes'> </span><%= dtDetail.Rows[i][8].ToString()%></td>
  <td class=xl44 x:num><font color="#FF0000" style='mso-ignore:color'><span
  style='mso-spacerun:yes'>  </span><%= dtDetail.Rows[i][10].ToString()%></font></td>
  <td class=xl45><%= dtDetail.Rows[i][11].ToString()%></td>
  <td class=xl43><%= dtDetail.Rows[i][12].ToString()%></td>
  <td class=xl43><%= dtDetail.Rows[i][13].ToString()%></td>
  <td class=xl43><%= dtDetail.Rows[i][19].ToString()%></td>
  <td class=xl43><%= dtDetail.Rows[i][20].ToString()%></td>
  <td class=xl46><%= dtDetail.Rows[i][21].ToString()%></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>      
  <%    
     }

        } %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=11 class=xl30 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=4 rowspan=2 height=40 class=xl53 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:30.0pt'>Total</td>
  <td rowspan=2 class=xl59 style='border-bottom:.5pt solid black'>Ccy</td>
  <td rowspan=2 class=xl51 width=89 style='border-bottom:.5pt solid black;
  width:67pt'>Openning Book Balance</td>
  <td colspan=2 class=xl49 style='border-right:.5pt solid black'>Credit</td>
  <td rowspan=2 class=xl51 width=89 style='border-bottom:.5pt solid black;
  width:67pt'>CFM Balance</td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt'>Transaction</td>
  <td class=xl29>Book</td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl40></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl31 style='height:20.1pt'>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34><%= dtSum.Rows[1][0].ToString()%></td>
  <td class=xl35 x:num><%= dtSum.Rows[1][1].ToString()%></td>
  <td class=xl35 x:num><%= dtSum.Rows[1][4].ToString()%></td>
  <td class=xl35 x:num><%= dtSum.Rows[1][5].ToString()%></td>
  <td class=xl35 x:num><font color="#FF0000" style='mso-ignore:
  color'><%= dtSum.Rows[1][6].ToString()%></font></td>
  <td class=xl39></td>
  <td class=xl36></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=67 style='width:50pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=240 style='width:180pt'></td>
  <td width=187 style='width:140pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=127 style='width:95pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
