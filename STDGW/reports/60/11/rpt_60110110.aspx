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
    string l_com_pk = Request["p_com_pk"];
    string l_date_fr = Request["p_date_fr"];
    string l_date_to = Request["p_date_to"];
    string l_tco_buspartner_pk = Request["p_tco_buspartner_pk"];
    string l_tac_abacctcode_pk = Request["p_tac_abacctcode_pk"];
    string l_tac_abplcenter_pk = Request["p_tac_abplcenter_pk"];
    string l_seq = Request["p_seq"];
    string l_voucher = Request["p_voucher"];
    string l_invoice_no = Request["p_invoice_no"];
    string l_type = Request["p_type"];
    string l_lang = Request["p_lang"];
    string l_po_no = Request["p_po_no"];
    string l_style_no = Request["p_style_no"];
    string l_company = "",l_address="";
    string l_ccy = "", p_xls_ccy_formatVND = "", p_xls_ccy_formatUSD = "";
    string sql2 = "SELECT ac_A_GET_DEFAULT('ACBG0040') FROM DUAL ";

    DataTable dt_bccy = ESysLib.TableReadOpen(sql2);
    if (dt_bccy.Rows.Count > 0)
    {
        l_ccy = dt_bccy.Rows[0][0].ToString();
    }
    if (l_ccy == "VND")
    {
        p_xls_ccy_formatVND = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_formatUSD = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    string SQL1 = " SELECT  PARTNER_NAME,addr1 FROM TCO_COMPANY WHERE DEL_IF=0 and pk ='" + l_com_pk + "'";
      
  DataTable dt_f = ESysLib.TableReadOpen(SQL1);
  if (dt_f.Rows.Count > 0)
  {
      l_company = dt_f.Rows[0][0].ToString();
      l_address = dt_f.Rows[0][1].ToString();
  }
    string l_parameter = "'" + l_com_pk + "','" + l_date_fr + "','" + l_date_to + "','" + l_tco_buspartner_pk + "','" + l_tac_abacctcode_pk + "','" + l_tac_abplcenter_pk + "','" + l_seq + "','" + l_voucher + "','" + l_invoice_no + "','" + l_po_no + "','" + l_type + "','" + l_style_no + "','" + l_lang + "'";

   // DataTable dt = ESysLib.TableReadOpenCursor("ACNT.sp_sel_grd_ar_balance_1", l_parameter);
    DataTable dt = ESysLib.TableReadOpenCursor("AC_rpt_60110110_ar_balance", l_parameter);
            if (dt.Rows.Count == 0)
            {
                Response.Write("There is no data 1");
                Response.End();
            }
        //    DataTable dtSum = ESysLib.TableReadOpenCursor("ACNT.sp_sel_grd_ar_balance_sum", l_parameter);
       DataTable dtSum = ESysLib.TableReadOpenCursor("ac_rpt_60110110_ar_balance_sum", l_parameter);       
            if (dtSum.Rows.Count == 0)
            {
                Response.Write("There is no data 2");
                Response.End();
            }
            l_date_fr = l_date_fr.Substring(6, 2) + "/" + l_date_fr.Substring(4, 2) + "/" + l_date_fr.Substring(0, 4);//2009.08.25   
            l_date_to = l_date_to.Substring(6, 2) + "/" + l_date_to.Substring(4, 2) + "/" + l_date_to.Substring(0, 4);//2009.08.25   
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfca00060%2016_1%20_files/filelist.xml">
<link rel=Edit-Time-Data href="gfca00060%2016_1%20_files/editdata.mso">
<link rel=OLE-Object-Data href="gfca00060%2016_1%20_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>PCVINA002</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2009-10-19T03:39:21Z</o:LastPrinted>
  <o:Created>2009-10-16T03:08:39Z</o:Created>
  <o:LastSaved>2009-10-19T03:50:49Z</o:LastSaved>
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
	color:red;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	border:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	mso-number-format:0;
	text-align:center;
	border:.5pt hairline windowtext;}
.xl31
	{mso-style-parent:style0;
	text-align:left;
	border:.5pt hairline windowtext;
	}
.xl32
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt hairline windowtext;
	}
.xl33
	{mso-style-parent:style0;
	border:.5pt hairline windowtext;
	text-align:right;
	}
.xl34
	{mso-style-parent:style0;
	text-align:left;
	border:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;
	}
.xl35
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	mso-number-format:0;
	text-align:center;
	
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl41
	{mso-style-parent:style0;
	text-align:right;
	border:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	mso-number-format:Standard;}
.xl42
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl48
	{mso-style-parent:style0;
	text-align:left;}
.xl49
	{mso-style-parent:style0;
	mso-number-format:Standard;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style0;
	text-align:left;
	border:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style0;
	border:.5pt hairline windowtext;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	}	
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
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
       <x:ActiveCol>6</x:ActiveCol>
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
  <x:WindowHeight>6600</x:WindowHeight>
  <x:WindowWidth>11880</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1545</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2117 style='border-collapse:
 collapse;table-layout:fixed;width:1591pt'>
 <col width=38 style='mso-width-source:userset;mso-width-alt:1389;width:29pt'>
 <col width=64 style='width:48pt'>
 <col width=85 style='mso-width-source:userset;mso-width-alt:3108;width:64pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=155 style='mso-width-source:userset;mso-width-alt:5668;width:116pt'>
 <col width=75 style='mso-width-source:userset;mso-width-alt:2742;width:56pt'>
 <col width=90 style='mso-width-source:userset;mso-width-alt:3291;width:68pt'>
 <col width=200 style='mso-width-source:userset;mso-width-alt:7314;width:150pt'>
 <col width=101 style='mso-width-source:userset;mso-width-alt:3693;width:76pt'>
 <col width=86 style='mso-width-source:userset;mso-width-alt:3145;width:65pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2560;width:53pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=47 style='mso-width-source:userset;mso-width-alt:1718;width:35pt'>
 <col width=94 style='mso-width-source:userset;mso-width-alt:3437;width:71pt'>
 <col width=98 style='mso-width-source:userset;mso-width-alt:3584;width:74pt'>
 <col width=104 style='mso-width-source:userset;mso-width-alt:3803;width:78pt'>
 <col width=95 style='mso-width-source:userset;mso-width-alt:3474;width:71pt'>
 <col width=99 style='mso-width-source:userset;mso-width-alt:3620;width:74pt'>
 <col width=96 style='mso-width-source:userset;mso-width-alt:3510;width:72pt'>
 <col width=138 style='mso-width-source:userset;mso-width-alt:5046;width:104pt'>
 <col width=150 style='mso-width-source:userset;mso-width-alt:5485;width:113pt'>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=5 height=21 class=xl43 width=340 style='height:15.75pt;
  width:256pt'><%=l_company %></td>
  <td colspan=17 class=xl45 width=1777 style='width:1335pt'>AR BALANCE</td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=5 height=17 class=xl44 style='height:12.75pt'><%=l_address %></td>
  <td colspan=2 class=xl47>Tran / Balance :</td>
  <td colspan=3 class=xl48><%=l_date_fr %> ~ <%=l_date_to %></td>
  <td colspan=12 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl47 style='height:12.75pt'>Type :</td>
  <td colspan=3 class=xl48><%=l_type %></td>
  <td colspan=2 class=xl47>Voucher No :</td>
  <td colspan=2 class=xl46><%=l_voucher %></td>
  <td class=xl39>Seq :</td>
  <td class=xl39><%=l_seq %></td>
  <td class=xl40>Invoice No<span style='display:none'>:</span></td>
  <td colspan=3 class=xl46><%=l_invoice_no %></td>
  <td class=xl40>Po No :</td>
  <td colspan=2 class=xl46></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'>Row</td>
  <td class=xl28>Seq</td>
  <td class=xl28>Acc.Code</td>
  <td class=xl28>Acc.Name</td>
  <td class=xl28>Partner ID</td>
  <td class=xl28>Partner Name</td>
  <td class=xl28>Trans.Date</td>
  <td class=xl28 style='border-top:none'>Voucher No</td>
  <td class=xl28 style='border-top:none'>Style No</td>
  <td class=xl28 style='border-top:none'>Serial No</td>
  <td class=xl28 style='border-top:none'>Invoice Date</td>
  <td class=xl28>Invoice No</td>
  <td class=xl28 style='border-top:none'>Due Date</td>
  <td class=xl28 style='border-top:none'>CCY</td>
  <td class=xl28 style='border-top:none'>A/R Trans</td>
  <td class=xl28>A/R Books</td>
  <td class=xl28 style='border-top:none'>Recv Trans</td>
  <td class=xl28 style='border-top:none'>Recv Book</td>
  <td class=xl28>Balance Trans</td>
  <td class=xl28>Balance Books</td>
  <td class=xl28>Description</td>
  <td class=xl28>L.Description</td>
 </tr>
 <%
     string pk ="";
     string trs_ccy = "";
     string p_xls_trsccy_formatVND = "";
     string p_xls_trsccy_formatUSD = "";   
     decimal ArBook=0, RcBook=0, BlaBook = 0;
     p_xls_ccy_formatVND = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
     p_xls_ccy_formatUSD = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
     for (int i = 0; i < dtSum.Rows.Count; i++)
     {
          pk = dtSum.Rows[i][0].ToString();
          ArBook += decimal.Parse(dtSum.Rows[i][3].ToString());
          RcBook += decimal.Parse(dtSum.Rows[i][4].ToString());
          BlaBook += decimal.Parse(dtSum.Rows[i][5].ToString());
  %>
 <tr height=17 style='height:12.75pt'>
  <td colspan=4 height=17 class=xl49 style='height:12.75pt'><%=dtSum.Rows[i][1].ToString()%> - <%=dtSum.Rows[i][2].ToString()%></td>
  <td class=xl29 style='border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-left:none'>&nbsp;</td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_formatVND %>';border-top:none;border-left:none" x:num><%=dtSum.Rows[i][3].ToString()%></td>
  <td class=xl29 style='border-left:none'>&nbsp;</td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_formatVND %>';border-top:none;border-left:none" x:num><%=dtSum.Rows[i][4].ToString()%></td>
  <td class=xl29 style="border-left:none;mso-number-format:'<%= p_xls_ccy_formatUSD%>'" x:num><%=dtSum.Rows[i][6].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_formatVND%>';border-top:none;border-left:none" x:num><%=dtSum.Rows[i][5].ToString()%></td>
  <td class=xl29 style='border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-left:none'>&nbsp;</td>
 </tr>
 <%
              
     for (int j = 0; j < dt.Rows.Count; j++)
     {
         if (pk == dt.Rows[j][23].ToString())
         {
             trs_ccy = dt.Rows[j]["tr_ccy"].ToString();
             if (trs_ccy == "VND")
             {
                 p_xls_ccy_formatVND = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
             }
             else
             {
                 p_xls_ccy_formatUSD = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
             }
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl36 style='height:12.75pt;border-top:none' x:num><%=dt.Rows[j][0].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt.Rows[j][1].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt.Rows[j][2].ToString()%></td>
  <td class=xl31 style='border-top:none;border-left:none' x:str><%=dt.Rows[j][3].ToString()%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[j][4].ToString()%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[j][5].ToString()%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[j][6].ToString()%></td>
  <td class=xl32 style='border-top:none;border-left:none'><%=dt.Rows[j][7].ToString()%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[j][8].ToString()%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[j][9].ToString()%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[j][10].ToString()%></td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%=dt.Rows[j][11].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none'><%=dt.Rows[j][12].ToString()%></td>
  <td class=xl32 style='border-top:none;border-left:none'><%=dt.Rows[j][13].ToString()%></td>
  <td class=xl33 align=right style='border-top:none;border-left:none'><%=dt.Rows[j][14].ToString()%></td>
  <td class=xl33 align=right style="mso-number-format:'<%= p_xls_ccy_formatVND %>';border-top:none;border-left:none" x:num><%=dt.Rows[j][15].ToString()%></td>
  <td class=xl51 align=right style="border-top:none;border-left:none;" x:num><%=dt.Rows[j][16].ToString()%></td>
  <td class=xl33 align=right style="mso-number-format:'<%= p_xls_ccy_formatVND %>';border-top:none;border-left:none" x:num><%=dt.Rows[j][17].ToString()%></td>
  <td class=xl33 align=right style="mso-number-format:'<%= p_xls_ccy_formatUSD %>';border-top:none;border-left:none" x:num><%=dt.Rows[j][18].ToString()%></td>
  <td class=xl33 align=right style="mso-number-format:'<%= p_xls_ccy_formatVND %>';border-top:none;border-left:none" x:num><%=dt.Rows[j][19].ToString()%></td>
  <td class=xl34 width=138 style='border-top:none;border-left:none;width:104pt'x:num><%=dt.Rows[j][20].ToString()%></td>
  <td class=xl37 width=150 style='border-top:none;border-left:none;width:113pt'x:num><%=dt.Rows[j][21].ToString()%></td>
 </tr>
 <%
    
     }
     
   }
   }%>
 <tr height=17 style='height:12.75pt'>
  <td colspan=8 height=17 class=xl42 style='height:12.75pt'>Grand total</td>
  <td class=xl25 style='border-left:none'>&nbsp;</td>
  <td class=xl24 style='border-left:none'>&nbsp;</td>
  <td class=xl24 style='border-left:none'>&nbsp;</td>
  <td class=xl24 style='border-left:none'>&nbsp;</td>
  <td class=xl24 style='border-left:none'>&nbsp;</td>
  <td class=xl24 style='border-left:none'>&nbsp;</td>
  <td class=xl24 style='border-left:none'>&nbsp;</td>
  <td class=xl26 align=center style="mso-number-format:'<%= p_xls_ccy_formatVND %>';border-top:none;border-left:none" x:num><%=ArBook %></td>
  <td class=xl26 style='border-left:none'>&nbsp;</td>
  <td class=xl26 style="mso-number-format:'<%= p_xls_ccy_formatVND %>';border-top:none;border-left:none" x:num><%=RcBook %></td>
  <td class=xl26 style='border-left:none'>&nbsp;</td>
  <td class=xl26 style="mso-number-format:'<%= p_xls_ccy_formatVND %>';border-top:none;border-left:none" x:num><%= BlaBook%></td>
  <td class=xl24 style='border-left:none'>&nbsp;</td>
  <td class=xl24 style='border-left:none'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=38 style='width:29pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=155 style='width:116pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=200 style='width:150pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=150 style='width:113pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
