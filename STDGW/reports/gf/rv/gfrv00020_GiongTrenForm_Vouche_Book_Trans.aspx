<%@ Page Language="C#"%>
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
<link rel=File-List href="rptTrsBs3_files/filelist.xml">
<link rel=Edit-Time-Data href="rptTrsBs3_files/editdata.mso">
<link rel=OLE-Object-Data href="rptTrsBs3_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>comp</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2009-01-06T06:41:53Z</o:LastPrinted>
  <o:Created>2005-01-28T07:20:51Z</o:Created>
  <o:LastSaved>2010-03-01T09:06:15Z</o:LastSaved>
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
	mso-number-format:Standard;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
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
.xl39
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
.xl40
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
.xl41
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
.xl42
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
.xl43
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
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;}
.xl46
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
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl48
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
.xl49
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
.xl50
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
.xl51
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
.xl52
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
	border-left:none;}
.xl54
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
.xl55
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
	border-left:none;}
.xl57
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
.xl58
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
.xl59
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
.xl60
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;}
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
     <x:SplitHorizontal>8</x:SplitHorizontal>
     <x:TopRowBottomPane>8</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
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
  <x:Formula>='SL Daily'!$7:$8</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1785 style='border-collapse:
 collapse;table-layout:fixed;width:1340pt'>
 <col class=xl24 width=57 style='mso-width-source:userset;mso-width-alt:2084;
 width:43pt'>
 <col class=xl24 width=68 span=2 style='mso-width-source:userset;mso-width-alt:
 2486;width:51pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl24 width=89 span=6 style='mso-width-source:userset;mso-width-alt:
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
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=17 height=20 class=xl27 width=1785 style='height:15.0pt;
  width:1340pt'><%= p_cmp_name %></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=10 class=xl26 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=17 height=20 class=xl44 style='height:15.0pt'><%= p_cmp_add %></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'>Ngày :</td>
  <td colspan=3 class=xl60><%= p_dt_from %>  <span style='mso-spacerun:yes'> 
  </span>~<span style='mso-spacerun:yes'>  </span><%= p_dt_to %></td>
  <td colspan=2 class=xl45>Tr&#7841;ng thái :</td>
  <td class=xl26><%=l_status1%></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl27 style='height:15.0pt'>Account Code :</td>
  <td colspan=2 class=xl60><%= p_acc_code %></td>
  <td colspan=13 class=xl60><%= p_acc_name %></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=17 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=2 height=40 class=xl58 style='border-bottom:.5pt solid black;
  height:30.0pt'>S&#7889; Seq</td>
  <td rowspan=2 class=xl50 width=68 style='border-bottom:.5pt solid black;
  width:51pt'>S&#7889; Ch&#7913;ng<br>
    T&#7915;</td>
  <td rowspan=2 class=xl50 width=68 style='border-bottom:.5pt solid black;
  width:51pt'>Ngày &#272;&#7873; Xu&#7845;t</td>
  <td rowspan=2 class=xl50 width=75 style='border-bottom:.5pt solid black;
  width:56pt'>Ng&#432;&#7901;i &#272;&#7873;<br>
    Xu&#7845;t</td>
  <td rowspan=2 class=xl58 style='border-bottom:.5pt solid black'>T&#7927; Giá</td>
  <td rowspan=2 class=xl50 width=89 style='border-bottom:.5pt solid black;
  width:67pt'>S&#7889; d&#432; &#272;&#7847;u K&#7923;(Ghi S&#7893;)</td>
  <td colspan=2 class=xl46 style='border-right:.5pt solid black;border-left:
  none'>N&#7907;</td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none'>Có</td>
  <td rowspan=2 class=xl50 width=89 style='border-bottom:.5pt solid black;
  width:67pt'>S&#7889; d&#432; Cu&#7889;i K&#7923;(Ghi S&#7893;)</td>
  <td rowspan=2 class=xl58 style='border-bottom:.5pt solid black'>Khách Hàng</td>
  <td colspan=2 class=xl46 style='border-right:.5pt solid black;border-left:
  none'>Ghi Chú</td>
  <td rowspan=2 class=xl58 style='border-bottom:.5pt solid black'>PL</td>
  <td rowspan=2 class=xl58 style='border-bottom:.5pt solid black'>Mã Ki&#7875;m
  Soát</td>
  <td rowspan=2 class=xl58 style='border-bottom:.5pt solid black'>Kèm Theo</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt'>Giao D&#7883;ch</td>
  <td class=xl29>Ghi S&#7893;</td>
  <td class=xl29>Giao D&#7883;ch</td>
  <td class=xl29>Ghi S&#7893;</td>
  <td class=xl29>N&#432;&#7899;c Ngoài</td>
  <td class=xl29>Trong N&#432;&#7899;c</td>
 </tr>
 <%
     for (i = 1; i < dtDetail.Rows.Count; i++)
     {
         if (i == 1)
         {
         %>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl38 style='height:20.1pt'><%= dtDetail.Rows[i][0].ToString()%></td>
  <td class=xl39><%= dtDetail.Rows[i][1].ToString()%></td>
  <td class=xl39><%= dtDetail.Rows[i][2].ToString()%></td>
  <td class=xl40><%= dtDetail.Rows[i][3].ToString()%></td>
  <td class=xl39><%= dtDetail.Rows[i][4].ToString()%></td>
  <td class=xl41 x:num><span style='mso-spacerun:yes'> </span><%= dtDetail.Rows[i][5].ToString()%></td>
  <td class=xl41 x:num><span style='mso-spacerun:yes'> </span><%= dtDetail.Rows[i][6].ToString()%></td>
  <td class=xl41 x:num><span
  style='mso-spacerun:yes'> </span><%= dtDetail.Rows[i][7].ToString()%></td>
  <td class=xl41 x:num><span style='mso-spacerun:yes'> </span><%= dtDetail.Rows[i][8].ToString()%></td>
  <td class=xl41 x:num><span
  style='mso-spacerun:yes'> </span><%= dtDetail.Rows[i][9].ToString()%></td>
  <td class=xl41 x:num><font color="#FF0000" style='mso-ignore:color'><span
  style='mso-spacerun:yes'>  </span><%= dtDetail.Rows[i][10].ToString()%></font></td>
  <td class=xl42><%= dtDetail.Rows[i][11].ToString()%></td>
  <td class=xl40><%= dtDetail.Rows[i][12].ToString()%></td>
  <td class=xl40><%= dtDetail.Rows[i][13].ToString()%></td>
  <td class=xl40><%= dtDetail.Rows[i][19].ToString()%></td>
  <td class=xl40><%= dtDetail.Rows[i][20].ToString()%></td>
  <td class=xl43><%= dtDetail.Rows[i][21].ToString()%></td>
 </tr>
 <%
     }
     else
     {
              %>
<tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl38 style='height:20.1pt'><%= dtDetail.Rows[i][0].ToString()%></td>
  <td class=xl39><%= dtDetail.Rows[i][1].ToString()%></td>
  <td class=xl39><%= dtDetail.Rows[i][2].ToString()%></td>
  <td class=xl40><%= dtDetail.Rows[i][3].ToString()%></td>
  <td class=xl39><%= dtDetail.Rows[i][4].ToString()%></td>
  <td class=xl41 x:num><span style='mso-spacerun:yes'> </span><%= dtDetail.Rows[i-1][10].ToString()%></td>
  <td class=xl41 x:num><span style='mso-spacerun:yes'> </span><%= dtDetail.Rows[i][6].ToString()%></td>
  <td class=xl41 x:num><span
  style='mso-spacerun:yes'> </span><%= dtDetail.Rows[i][7].ToString()%></td>
  <td class=xl41 x:num><span style='mso-spacerun:yes'> </span><%= dtDetail.Rows[i][8].ToString()%></td>
  <td class=xl41 x:num><span
  style='mso-spacerun:yes'> </span><%= dtDetail.Rows[i][9].ToString()%></td>
  <td class=xl41 x:num><font color="#FF0000" style='mso-ignore:color'><span
  style='mso-spacerun:yes'>  </span><%= dtDetail.Rows[i][10].ToString()%></font></td>
  <td class=xl42><%= dtDetail.Rows[i][11].ToString()%></td>
  <td class=xl40><%= dtDetail.Rows[i][12].ToString()%></td>
  <td class=xl40><%= dtDetail.Rows[i][13].ToString()%></td>
  <td class=xl40><%= dtDetail.Rows[i][19].ToString()%></td>
  <td class=xl40><%= dtDetail.Rows[i][20].ToString()%></td>
  <td class=xl43><%= dtDetail.Rows[i][21].ToString()%></td>
 </tr>       
              
  <%    
     }

        } %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=13 class=xl30 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=4 rowspan=2 height=40 class=xl52 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:30.0pt'>Total</td>
  <td rowspan=2 class=xl58 style='border-bottom:.5pt solid black'>Ccy</td>
  <td rowspan=2 class=xl50 width=89 style='border-bottom:.5pt solid black;
  width:67pt'>Openning Book Balance</td>
  <td colspan=2 class=xl46 style='border-right:.5pt solid black;border-left:
  none'>Debit</td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none'>Credit</td>
  <td rowspan=2 class=xl50 width=89 style='border-bottom:.5pt solid black;
  width:67pt'>CFM Balance</td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt'>Transaction</td>
  <td class=xl29>Book</td>
  <td class=xl29>Transaction</td>
  <td class=xl29>Book</td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl31 style='height:20.1pt'>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34><%= dtSum.Rows[1][1].ToString()%></td>
  <td class=xl35 x:num><%= dtSum.Rows[1][0].ToString()%></td>
  <td class=xl35 x:num><%= dtSum.Rows[1][2].ToString()%></td>
  <td class=xl35 x:num><%= dtSum.Rows[1][3].ToString()%></td>
  <td class=xl35 x:num><%= dtSum.Rows[1][4].ToString()%></td>
  <td class=xl35 x:num><%= dtSum.Rows[1][5].ToString()%></td>
  <td class=xl35 x:num><font color="#FF0000" style='mso-ignore:
  color'><%= dtSum.Rows[1][6].ToString()%></font></td>
  <td class=xl36></td>
  <td class=xl37></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=57 style='width:43pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
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
 </tr>
 <![endif]>
</table>

</body>

</html>
