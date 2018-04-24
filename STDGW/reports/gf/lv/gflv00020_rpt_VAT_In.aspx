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
    
        
    string l_company = "" + Request["compk"];
    string l_month = "" + Request["month"];
    string l_vat_type = "" + Request["vat_type"];
    string l_vat_rate = "" + Request["vat_rate"];
    
    //string l_vat_rate = Request["vat_rate"];
    string l_trade = "";//+ Request["trade"];
    string l_ccy = "" + Request["ccy"];
    string l_status = "" + Request["status"];
    string l_custpk = "" + Request["custpk"];
    string l_invoiceno = "" + Request["invoiceno"];
    string l_ac_cd = "" + Request["ac_cd"];
    string l_voucherno = "" + Request["voucherno"];







    string l_parameter = "";
   


    string l_compa = "", l_address = "";
    
    //string l_date_fr2 = "";
    //string l_date_to2 = "";
    
    
    int l_report_dd = 0 ;
    int l_report_mm = 0 ;
    int l_report_yy = 0 ;

    l_report_dd = DateTime.Today.Day;
    l_report_mm = DateTime.Today.Month;
    l_report_yy = DateTime.Today.Year;
    
   
    string l_taxcode = "";


    string net_amt = "";
    string vat_sum = "";
    decimal l_sumNET_AMT = 0;
    decimal l_sumVAT = 0;
    decimal l_grand_sum = 0;
    decimal l_grand_sumvat = 0;
    
    
//---------------------------------------------------------------------------------    
    string lccy = Request["p_ccy"];
    
    string p_xls_ccy_format = "";
    string sql2 = "SELECT ACNT.SF_A_GET_DEFAULT('ACBG0040') FROM DUAL ";

    DataTable dt_bccy = ESysLib.TableReadOpen(sql2);
    if (dt_bccy.Rows.Count > 0)
    {
        lccy = dt_bccy.Rows[0][0].ToString();
    }
    if (lccy == "VND")
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
   // string l_date_from = "";
   // string l_date_to = "";
   // string SQL = " SELECT TO_CHAR(TO_DATE('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') DT_FR,  TO_CHAR(TO_DATE('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') DT_TO, ";
   // SQL = SQL + "acnt.sf_get_format('ACBG0040'), TO_CHAR(LAST_DAY(TO_DATE('" + l_date_to + "','YYYYMMDD')),'DD')  RP_DD,";
   // SQL = SQL + " TO_CHAR(LAST_DAY(TO_DATE('" + l_date_to + "','YYYYMMDD')),'MM')  RP_MM, ";
   // SQL = SQL + " TO_CHAR(LAST_DAY(TO_DATE('" + l_date_to + "','YYYYMMDD')),'YYYY')  RP_YY, ";
   // SQL = SQL + " SF_GET_FORMAT ('ACRP0010') ";
   // SQL = SQL + " FROM DUAL ";

   //DataTable dt = ESysLib.TableReadOpen(SQL);
   // if (dt.Rows.Count > 0)
   // {
   //     //l_date_fr2 = dt.Rows[0][0].ToString();
   //     //l_date_to2 = dt.Rows[0][1].ToString();
        
   //     l_report_dd = dt.Rows[0][3].ToString();
   //     l_report_mm = dt.Rows[0][4].ToString();
   //     l_report_yy = dt.Rows[0][5].ToString();
        
   // }
//-------------------------------------------------------------------------------------------------


    

    //Response.Write(l_parameter);
    //Response.End();
    //if (dt_detail.Rows.Count == 0)
    //{
    //    Response.Write("There is no data");
    //    Response.End();
    //}
//-------------------------------------------------------------------------------------------------
    string l_date_from = "", l_date_to = "";
    string SQL = "";
    string SQL3 = "SELECT TO_CHAR (TO_DATE ('" + l_month + "' || '01', 'yyyymmdd'), 'dd/mm/yyyy') from_dt, " +
            "       TO_CHAR (LAST_DAY (TO_DATE ('" + l_month + "' || '01', 'yyyymmdd')), " +
            "                'dd/mm/yyyy' " +
            "               ) to_dt "+ 
            "  FROM DUAL ";
    DataTable dt_date = ESysLib.TableReadOpen(SQL3);
    if (dt_date.Rows.Count > 0)
    {
        l_date_from = dt_date.Rows[0][0].ToString();
        l_date_to = dt_date.Rows[0][1].ToString();

    }
//-----------------------------------------------------------------------------------------------------
    string SQL9 = "select b.code_nm, concat('Hàng hóa, dịch vụ dùng riêng cho sản xuất, kinh doanh chịu thuế GTGT',code_nm) " +
        "from comm.tco_abcodegrp a, comm.tco_abcode b " +
        "where a.del_if = 0 " +
        "and b.del_if = 0 " +
        "and a.pk = b.tco_abcodegrp_pk " +
        "and a.id = 'ACCR0110' " +
        "and b.code_nm = decode('" + l_vat_rate + "', 'All Types', b.code_nm, '" + l_vat_rate + "')  ";
   

    DataTable dt_rate = ESysLib.TableReadOpen(SQL9);

    //Response.Write(l_vat_rate);
    //Response.End();
//------------------------------------------------------------------------------------------------------        
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="wed_files/filelist.xml">
<link rel=Edit-Time-Data href="wed_files/editdata.mso">
<link rel=OLE-Object-Data href="wed_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>Mr Long</o:LastAuthor>
  <o:LastPrinted>2009-11-06T07:14:18Z</o:LastPrinted>
  <o:Created>2008-08-04T09:01:52Z</o:Created>
  <o:LastSaved>2009-11-06T07:43:15Z</o:LastSaved>
  <o:Company>GENUWIN</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in 0in .5in .25in;
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
	font-size:18.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl30
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid #00CCFF;}
.xl31
	{mso-style-parent:style0;
	border:.5pt solid #00CCFF;}
.xl32
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid #00CCFF;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid #00CCFF;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	border:.5pt solid #00CCFF;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid #00CCFF;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	color:red;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	border:.5pt solid #00CCFF;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid #00CCFF;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	border:.5pt solid #00CCFF;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl40
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid #00CCFF;}
.xl41
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl42
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl44
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid #00CCFF;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid #00CCFF;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid #00CCFF;
	border-right:none;
	border-bottom:.5pt solid #00CCFF;
	border-left:.5pt solid #00CCFF;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid #00CCFF;
	border-right:none;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid #00CCFF;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	text-align:left;}
.xl50
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl60
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
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
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>10</x:SplitHorizontal>
     <x:TopRowBottomPane>10</x:TopRowBottomPane>
     <x:SplitVertical>4</x:SplitVertical>
     <x:LeftColumnRightPane>4</x:LeftColumnRightPane>
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
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>0</x:ActiveCol>
       <x:RangeSelection>$A$14:$E$14</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7065</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>540</x:WindowTopX>
  <x:WindowTopY>-75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1109 style='border-collapse:
 collapse;table-layout:fixed;width:832pt'>
 <col width=27 style='mso-width-source:userset;mso-width-alt:1152;width:20pt'>
 <col width=67 style='mso-width-source:userset;mso-width-alt:2858;width:50pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2986;width:53pt'>
 <col width=93 style='mso-width-source:userset;mso-width-alt:3968;width:70pt'>
 <col width=174 style='mso-width-source:userset;mso-width-alt:7424;width:131pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:4266;width:75pt'>
 <col width=143 style='mso-width-source:userset;mso-width-alt:6101;width:107pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:4266;width:75pt'>
 <col width=52 style='mso-width-source:userset;mso-width-alt:2218;width:39pt'>
 <col width=84 style='mso-width-source:userset;mso-width-alt:3584;width:63pt'>
 <col width=143 style='mso-width-source:userset;mso-width-alt:6101;width:107pt'>
 <col width=56 style='width:42pt'>
 <tr height=31 style='height:23.25pt'>
  <td colspan=11 height=31 class=xl24 width=1053 style='height:23.25pt;
  width:790pt'>BẢNG KÊ HÓA ĐƠN, CHỨNG TỪ HÀNG HÓA DICH VỤ MUA VÀO</td>
  <td width=56 style='width:42pt'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=3 class=xl24 style='height:19.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl51 style='border-right:.5pt solid black'>Từ <%=l_date_from%><span
  style='mso-spacerun:yes'>     </span>~ <%=l_date_to%></td>
  <td colspan=4 rowspan=4 class=xl53 width=379 style='border-right:.5pt solid black;
  width:284pt'>Mẫu số:01-2/GTGT<br>
    (Ban hành theo thông tư số60/2007/TT-BTC ngày 14/6/2007 của Bộ Tài Chính )</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=7 style='height:12.75pt;mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'>Tên cơ sở kinh doanh :</td>
  <td colspan=3 class=xl59><%=l_compa%></td>
  <td></td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td class=xl25>Địa chỉ<span style='mso-spacerun:yes'>    </span>:</td>
  <td></td>
  <td colspan=3 class=xl60><%=l_address %></td>
  <td></td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'>Mã số thuế:</td>
  <td colspan=3 class=xl49><%= l_taxcode %></td>
  <td></td>
  <td colspan=3 class=xl50>Đơn vị tiền<span style='mso-spacerun:yes'> 
  </span>:<span style='mso-spacerun:yes'>  </span><%=lccy%></td>
  <td class=xl26>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=12 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td rowspan=2 height=57 class=xl33 width=27 style='height:42.75pt;width:20pt'>STT</td>
  <td colspan=3 class=xl33 width=230 style='border-left:none;width:173pt'>Hóa
  đơn, chứng từ, biên lai nộp thuế</td>
  <td rowspan=2 class=xl33 width=174 style='width:131pt'>Tên người bán</td>
  <td rowspan=2 class=xl33 width=100 style='width:75pt'>Mã số thuế của người
  bán</td>
  <td rowspan=2 class=xl33 width=143 style='width:107pt'>Mặt hàng</td>
  <td rowspan=2 class=xl33 width=100 style='width:75pt'>Doanh số mua chưa có
  thuế</td>
  <td rowspan=2 class=xl33 width=52 style='width:39pt'>Thuế suất</td>
  <td rowspan=2 class=xl33 width=84 style='width:63pt'>Thuế GTGT đầu vào</td>
  <td rowspan=2 class=xl33 width=143 style='width:107pt'>Ghi chú</td>
  <td></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl33 width=67 style='height:26.25pt;border-top:none;
  border-left:none;width:50pt'>Ký hiệu hóa đơn</td>
  <td class=xl33 width=70 style='border-top:none;border-left:none;width:53pt'>Số
  hóa đơn</td>
  <td class=xl33 width=93 style='border-top:none;border-left:none;width:70pt'>Ngày,
  tháng, năm phát hành</td>
  <td></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl30 style='height:15.0pt;border-top:none' x:num>1</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>7</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>8</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>9</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>10</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>11</td>
  <td></td>
 </tr>
 <%
     

     for (int j = 0; j < dt_rate.Rows.Count; j++)
     {
         l_vat_rate = dt_rate.Rows[j][0].ToString();
         l_parameter = "'" + l_company + "', ";
         l_parameter += "'" + l_month + "', ";
         l_parameter += "'" + l_vat_type + "', ";
         l_parameter += "'" + l_vat_rate + "', ";
         l_parameter += "'" + l_trade + "', ";
         l_parameter += "'" + l_ccy + "', ";
         l_parameter += "'" + l_status + "', ";
         l_parameter += "'" + l_custpk + "', ";
         l_parameter += "'" + l_invoiceno + "', ";
         l_parameter += "'" + l_ac_cd + "', ";
         l_parameter += "'" + l_voucherno + "' ";         
         DataTable dt_detail = ESysLib.TableReadOpenCursor("ACNT.gflv00020_rpt_VAT_In", l_parameter);
         l_sumNET_AMT = 0; l_sumVAT = 0;
         if (dt_detail.Rows.Count > 0)
         {
 %>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=11 height=24 class=xl46 style='border-right:.5pt solid #00CCFF;height:18.0pt'><%=dt_rate.Rows[j][1]%></td>
  <td></td>
 </tr>
 <% 
           }
    
     for (int i = 0; i < dt_detail.Rows.Count; i++)
     {
         net_amt = dt_detail.Rows[i][15].ToString();
         vat_sum = dt_detail.Rows[i][16].ToString();
         if (net_amt!="")
         {
             l_sumNET_AMT += decimal.Parse(net_amt);
             l_sumVAT += decimal.Parse(vat_sum);
             l_grand_sum += decimal.Parse(net_amt);
             l_grand_sumvat += decimal.Parse(vat_sum);
         }
 %>      
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl40 style='height:17.25pt;border-top:none'><%=dt_detail.Rows[i][0]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt_detail.Rows[i][5]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt_detail.Rows[i][7]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt_detail.Rows[i][6]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt_detail.Rows[i][9]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt_detail.Rows[i][10]%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt_detail.Rows[i][12]%></td>
  <td class=xl32 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'></span><%=dt_detail.Rows[i][15]%></td>
  <td class=xl32 style='border-top:none;border-left:none' x:str><span style='mso-spacerun:yes'></span><%=dt_detail.Rows[i][14]%><span style='mso-spacerun:yes'> </span></td>
  <td class=xl32 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'></span><%=dt_detail.Rows[i][16]%></td>
  <td class=xl32 style='border-top:none;border-left:none' x:str><span style='mso-spacerun:yes'></span><%=dt_detail.Rows[i][17]%><span style='mso-spacerun:yes'> </span></td>
 </tr>
 <%     
     }
     if (l_sumVAT > 0 && l_sumNET_AMT > 0)
     {
 %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl44 style='height:17.25pt'>Tổng</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'></span><%=l_sumNET_AMT%></td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'></span><%=l_sumVAT%></td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td></td>
 </tr>
 <%
     }   
     }
     
  %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl45 style='height:17.25pt'>Tổng cộng</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'></span><%=l_grand_sum%></td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'></span><%= l_grand_sumvat%></td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=12 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 style='height:13.5pt'></td>
  <td colspan=4 class=xl41>Tổng giá trị hàng hóa, dịch vụ mua vào:</td>
  <td class=xl39 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'></span><%=l_grand_sum%></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=5 style='height:13.5pt;mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 style='height:13.5pt'></td>
  <td colspan=4 class=xl41>Số tiền thuế GTGT của hàng hóa, dich vụ mua vào:</td>
  <td class=xl39 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'></span><%= l_grand_sumvat%></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=12 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl42>Ngày <%= l_report_dd %><span style='mso-spacerun:yes'></span>tháng <%= l_report_mm %><span style='mso-spacerun:yes'></span>năm <%= l_report_yy %></td>
  <td></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=2 style='height:13.5pt;mso-ignore:colspan'></td>
  <td class=xl28 colspan=2 style='mso-ignore:colspan'>Người lập phiếu</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl28>Kế toán Trưởng</td>
  <td></td>
  <td colspan=3 class=xl43>Giám Đốc</td>
  <td></td>
 </tr>
 <tr height=136 style='height:102.0pt;mso-xlrowspan:8'>
  <td height=136 colspan=12 style='height:102.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=12 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=27 style='width:20pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=174 style='width:131pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=143 style='width:107pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=143 style='width:107pt'></td>
  <td width=56 style='width:42pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>