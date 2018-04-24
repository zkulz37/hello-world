<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
   
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    
    
    string l_com_pk = "" + Request["p_com_pk"];
    string l_date_fr = "" + Request["p_date_fr"];
    string l_date_to = "" + Request["p_date_to"];
    string l_tco_buspartner_pk = "" + Request["p_tco_buspartner_pk"];
    string l_tac_abacctcode_pk = "" + Request["p_tac_abacctcode_pk"];
    string l_tac_abplcenter_pk = "" + Request["p_tac_abplcenter_pk"];
    string l_seq = "" + Request["p_seq"];
    string l_voucher = "" + Request["p_voucher"];
    string l_invoice_no = "" + Request["p_invoice_no"];
    string l_type = "" + Request["p_type"];
    string l_lang = "" + Request["p_lang"];
    
    string l_company = "", l_address = "";
    
    

    string l_parameter = "'" + l_com_pk + "', ";
    l_parameter += "'" + l_date_fr + "', ";
    l_parameter += "'" + l_date_to + "', ";
    l_parameter += "'" + l_tco_buspartner_pk + "', ";
    l_parameter += "'" + l_tac_abacctcode_pk + "', ";
    l_parameter += "'" + l_tac_abplcenter_pk + "', ";
    l_parameter += "'" + l_seq + "', ";
    l_parameter += "'" + l_voucher + "', ";
    l_parameter += "'" + l_invoice_no + "', ";
    
    l_parameter += "'" + l_type + "', ";
    l_parameter += "'" + l_lang + "' ";

//--------------------------------------------------------------------------------------
    string l_ccy = Request["p_ccy"];

    string p_xls_ccy_format = "";
    string sql2 = "SELECT SF_A_GET_DEFAULT('ACBG0040') FROM DUAL ";

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
//--------------------------------------------------------------------------------------

    string SQL1 = " SELECT  PARTNER_NAME,addr1 FROM TCO_COMPANY WHERE DEL_IF=0 and pk ='" + l_com_pk + "'";

    DataTable dt_f = ESysLib.TableReadOpen(SQL1);
    if (dt_f.Rows.Count > 0)
    {
        l_company = dt_f.Rows[0][0].ToString();
        l_address = dt_f.Rows[0][1].ToString();
    }
    //string l_parameter = "'" + l_com_pk + "','" + l_date_fr + "','" + l_date_to + "','" + l_tco_buspartner_pk + "','" + l_tac_abacctcode_pk + "','" + l_tac_abplcenter_pk + "','" + l_seq + "','" + l_voucher + "','" + l_invoice_no + "','" + l_type + "','" + l_lang + "','" + l_style_no + "'";
    DataTable dt = ESysLib.TableReadOpenCursor("SP_SEL_GRD_AP_BALANCE1", l_parameter);
    //Response.Write(dt.Rows[0][1].ToString());
    //Response.End();

    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    DataTable dtSum = ESysLib.TableReadOpenCursor("sp_sel_grd_ap_balance_sum", l_parameter);
    //Response.Write(l_parameter);
    //Response.End();
    if (dtSum.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    l_date_fr = l_date_fr.Substring(6, 2) + "/" + l_date_fr.Substring(4, 2) + "/" + l_date_fr.Substring(0, 4); 
    l_date_to = l_date_to.Substring(6, 2) + "/" + l_date_to.Substring(4, 2) + "/" + l_date_to.Substring(0, 4);  
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfda00090%2034%20_files/filelist.xml">
<link rel=Edit-Time-Data href="gfda00090%2034%20_files/editdata.mso">
<link rel=OLE-Object-Data href="gfda00090%2034%20_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>PCVINA002</o:Author>
  <o:LastAuthor>Mr Long</o:LastAuthor>
  <o:LastPrinted>2009-10-19T03:39:21Z</o:LastPrinted>
  <o:Created>2009-10-16T03:08:39Z</o:Created>
  <o:LastSaved>2009-11-03T01:13:14Z</o:LastSaved>
  <o:Company>VINA</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .2in .5in .2in;
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
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	text-align:left;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid white;
	border-bottom:.5pt solid #00CCFF;
	border-left:.5pt solid #00CCFF;
	background:#00CCFF;
	mso-pattern:auto none;
	mso-protection:unlocked hidden;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid white;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;
	mso-protection:unlocked hidden;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid #00CCFF;
	border-right:.5pt solid white;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;
	mso-protection:unlocked hidden;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;
	mso-protection:unlocked hidden;}
.xl30
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	background:#339966;
	mso-pattern:auto none;
	mso-protection:unlocked hidden;}
.xl31
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\\ _\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	background:#339966;
	mso-pattern:auto none;
	mso-protection:unlocked hidden;}
.xl32
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	background:#339966;
	mso-pattern:auto none;
	mso-protection:unlocked hidden;}
.xl33
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	border-top:none;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	background:#339966;
	mso-pattern:auto none;
	mso-protection:unlocked hidden;}
.xl34
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	mso-protection:unlocked hidden;}
.xl35
	{mso-style-parent:style0;
	text-align:right;
	border-top:none;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	mso-protection:unlocked hidden;}
.xl36
	{mso-style-parent:style0;
	border-top:.5pt solid #00CCFF;
	border-right:none;
	border-bottom:.5pt solid #00CCFF;
	border-left:.5pt solid #00CCFF;
	mso-protection:unlocked hidden;}
.xl37
	{mso-style-parent:style0;
	border-top:.5pt solid #00CCFF;
	border-right:none;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	mso-protection:unlocked hidden;}
.xl38
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	mso-protection:unlocked hidden;}
.xl39
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	mso-protection:unlocked hidden;}
.xl40
	{mso-style-parent:style0;
	text-align:right;
	border-top:none;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	mso-protection:unlocked hidden;}
.xl41
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid #00CCFF;
	border-right:none;
	border-bottom:.5pt solid #00CCFF;
	border-left:.5pt solid #00CCFF;
	background:#339966;
	mso-pattern:auto none;
	mso-protection:unlocked hidden;}
.xl42
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid #00CCFF;
	border-right:none;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	background:#339966;
	mso-pattern:auto none;
	mso-protection:unlocked hidden;}
.xl43
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid #00CCFF;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	background:#339966;
	mso-pattern:auto none;
	mso-protection:unlocked hidden;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	border-top:.5pt solid #00CCFF;
	border-right:none;
	border-bottom:.5pt solid #00CCFF;
	border-left:.5pt solid #00CCFF;
	background:#99CCFF;
	mso-pattern:auto none;
	mso-protection:unlocked hidden;}
.xl47
	{mso-style-parent:style0;
	border-top:.5pt solid #00CCFF;
	border-right:none;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	background:#339966;
	mso-pattern:auto none;
	mso-protection:unlocked hidden;}
.xl48
	{mso-style-parent:style0;
	border-top:.5pt solid #00CCFF;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;
	background:#339966;
	mso-pattern:auto none;
	mso-protection:unlocked hidden;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid #00CCFF;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl52
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl54
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl55
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>sheet1</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:Scale>45</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>12270</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>-195</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2679 style='border-collapse:
 collapse;table-layout:fixed;width:2011pt'>
 <col width=35 style='mso-width-source:userset;mso-width-alt:1280;width:26pt'>
 <col width=59 style='mso-width-source:userset;mso-width-alt:2157;width:44pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=235 style='mso-width-source:userset;mso-width-alt:8594;width:176pt'>
 <col width=155 style='mso-width-source:userset;mso-width-alt:5668;width:116pt'>
 <col width=266 style='mso-width-source:userset;mso-width-alt:9728;width:200pt'>
 <col width=75 style='mso-width-source:userset;mso-width-alt:2742;width:56pt'>
 <col width=134 style='mso-width-source:userset;mso-width-alt:4900;width:101pt'>
 <col width=66 style='mso-width-source:userset;mso-width-alt:2413;width:50pt'>
 <col width=86 style='mso-width-source:userset;mso-width-alt:3145;width:65pt'>
 <col width=78 style='mso-width-source:userset;mso-width-alt:2852;width:59pt'>
 <col width=101 style='mso-width-source:userset;mso-width-alt:3693;width:76pt'>
 <col width=64 style='width:48pt'>
 <col width=109 style='mso-width-source:userset;mso-width-alt:3986;width:82pt'>
 <col width=132 style='mso-width-source:userset;mso-width-alt:4827;width:99pt'>
 <col width=92 style='mso-width-source:userset;mso-width-alt:3364;width:69pt'>
 <col width=125 style='mso-width-source:userset;mso-width-alt:4571;width:94pt'>
 <col width=135 style='mso-width-source:userset;mso-width-alt:4937;width:101pt'>
 <col width=136 style='mso-width-source:userset;mso-width-alt:4973;width:102pt'>
 <col width=225 style='mso-width-source:userset;mso-width-alt:8228;width:169pt'>
 <col width=280 style='mso-width-source:userset;mso-width-alt:10240;width:210pt'>
 <tr height=26 style='height:19.5pt'>
  <td colspan=5 height=26 class=xl51 width=575 style='height:19.5pt;width:430pt'><%=l_company %></td>
  <td colspan=16 class=xl52 width=2104 style='width:1581pt'>AP BALANCE</td>
 </tr>
 <tr height=26 style='height:19.5pt'>
  <td colspan=5 height=26 class=xl53 style='height:19.5pt'><%=l_address %></td>
  <td colspan=2 class=xl54>Tran / Balance :</td>
  <td colspan=2 class=xl25><%=l_date_fr %> ~ <%=l_date_to %></td>
  <td colspan=12 class=xl55></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl49 style='height:12.75pt'>Type :</td>
  <td colspan=3 class=xl50><%=l_type %></td>
  <td colspan=2 class=xl49>Voucher No :</td>
  <td class=xl25><%=l_voucher %></td>
  <td class=xl24>Seq :</td>
  <td class=xl24><%=l_seq %></td>
  <td class=xl24>Invoice No:</td>
  <td colspan=3 class=xl50><%=l_invoice_no %></td>
  <td class=xl24>Po No :</td>
  <td colspan=2 class=xl44>&nbsp;</td>
  <td colspan=4 class=xl45>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 style='height:12.75pt'>Row</td>
  <td class=xl27>Seq</td>
  <td class=xl27>Acc.Code</td>
  <td class=xl27>Acc.Name</td>
  <td class=xl27>Partner ID</td>
  <td class=xl27>Partner Name</td>
  <td class=xl27>Trans.Date</td>
  <td class=xl28>Voucher No</td>
  <td class=xl28>Serial No</td>
  <td class=xl28>Invoice Date</td>
  <td class=xl28>Invoice No</td>
  <td class=xl27>Due Date</td>
  <td class=xl27>CCY</td>
  <td class=xl27>A/P Trans</td>
  <td class=xl28>A/P Books</td>
  <td class=xl27>Pay Trans</td>
  <td class=xl27>Pay Books</td>
  <td class=xl27>Balance Trans</td>
  <td class=xl27>Balance Books</td>
  <td class=xl27>Description</td>
  <td class=xl29>L.Description</td>
 </tr>
 <%
     string pk ="";
     decimal ArBook=0, RcBook=0, BlaBook = 0;
     
     int i, j, k =1;
     for (i = 0; i < dtSum.Rows.Count; i++)
     {
          pk = dtSum.Rows[i][0].ToString();
          ArBook += decimal.Parse(dtSum.Rows[i][3].ToString());
          RcBook += decimal.Parse(dtSum.Rows[i][4].ToString());
          BlaBook += decimal.Parse(dtSum.Rows[i][5].ToString());
          
         
  %>
 <tr height=17 style='height:12.75pt'>
  <td colspan=4 height=17 class=xl46 style='border-right:.5pt solid #00CCFF; height:12.75pt'><%=dtSum.Rows[i][1].ToString()%> - <%=dtSum.Rows[i][2].ToString()%></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35 x:num><%=dtSum.Rows[i][3].ToString()%></td>
  <td class=xl35>&nbsp;</td>
  <td class=xl34 align=right x:num><%=dtSum.Rows[i][4].ToString()%></td>
  <td class=xl35>&nbsp;</td>
  <td class=xl34 align=right x:num><%=dtSum.Rows[i][5].ToString()%></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
 </tr>
 <%
      
      
     for (j = 0; j < dt.Rows.Count; j++)
     {
         
         if (pk == dt.Rows[j][21].ToString())
         {
             
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl36 style='height:12.75pt;border-top:none' x:num><%=k%></td>
  <td class=xl37 style='border-top:none' x:num><%=dt.Rows[j][1].ToString()%></td>
  <td class=xl37 style='border-top:none' x:num><%=dt.Rows[j][2].ToString()%></td>
  <td class=xl37 style='border-top:none'><%=dt.Rows[j][3].ToString()%></td>
  <td class=xl38><%=dt.Rows[j][4].ToString()%></td>
  <td class=xl38><%=dt.Rows[j][5].ToString()%></td>
  <td class=xl38><%=dt.Rows[j][6].ToString()%></td>
  <td class=xl39><%=dt.Rows[j][7].ToString()%></td>
  <td class=xl39><%=dt.Rows[j][8].ToString()%></td>
  <td class=xl39><%=dt.Rows[j][9].ToString()%></td>
  <td class=xl39><%=dt.Rows[j][10].ToString()%></td>
  <td class=xl39><%=dt.Rows[j][11].ToString()%></td>
  <td class=xl39><%=dt.Rows[j][12].ToString()%></td>
  <td class=xl40><%=dt.Rows[j][13].ToString()%></td>
  <td class=xl40 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt.Rows[j][14].ToString()%></td>
  <td class=xl40 x:num><%=dt.Rows[j][15].ToString()%></td>
  <td class=xl39 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt.Rows[j][16].ToString()%></td>
  <td class=xl40 x:num><%=dt.Rows[j][17].ToString()%></td>
  <td class=xl39 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt.Rows[j][18].ToString()%></td>
  <td class=xl39><%=dt.Rows[j][19].ToString()%></td>
  <td class=xl39><%=dt.Rows[j][20].ToString()%></td>
 </tr>
 <%
    k++;   
      }
     
   }
   }%>
 <tr height=17 style='height:12.75pt'>
  <td colspan=8 height=17 class=xl41 style='border-right:.5pt solid #00CCFF;
  height:12.75pt'>Grand total</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl31 style="mso-number-format:' <%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes' </span><%=ArBook %> </td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'></span><%=RcBook %></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl32 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'></span><%= BlaBook%></td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=35 style='width:26pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=235 style='width:176pt'></td>
  <td width=155 style='width:116pt'></td>
  <td width=266 style='width:200pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=134 style='width:101pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=132 style='width:99pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=135 style='width:101pt'></td>
  <td width=136 style='width:102pt'></td>
  <td width=225 style='width:169pt'></td>
  <td width=280 style='width:210pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
