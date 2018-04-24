<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<%
    string SQL = "";
    string p_comp_pk = "";
    string p_year = "";
    p_year = Request["yearly"];
    p_year = p_year.Substring(0, 4);
    p_comp_pk = Request["comp_pk"];
    decimal v_profit = 0, v_profit_1 = 0, v_profit_2 = 0, v_cost_amt = 0, v_cost_amt_1 = 0, v_cost_amt_2 = 0, v_sale_amt = 0, v_sale_amt_1 = 0, v_sale_amt_2 = 0;
    decimal v_tot_qty = 0, v_tot_qty_1 = 0, v_tot_qty_2 = 0, v_tot_profit = 0, v_cost_price_avg = 0, v_cost_price_avg_1 = 0, v_cost_price_avg_2 = 0;
    decimal v_tot_profit_1 = 0, v_tot_profit_2 = 0, v_sale_price_avg = 0, v_sale_price_avg_1 = 0, v_sale_price_avg_2 = 0 ;
    int i;
     SQL
        = "select t.sizea, nvl(sum(t.qty_1), 0) qty_1, max(t.sale_price_1) sale_price_1, max(t.cost_price_1) cost_price_1, sum(t.qty_2) qty_2, max(t.sale_price_2) sale_price_2, max(t.cost_price_2) cost_price_2, " +
            "    sum(t.qty_3) qty_3, max(t.sale_price_3) sale_price_3, max(t.cost_price_3) cost_price_3 " +
            "from ( " +
            "select s.sizea, nvl(sum(d.qty), 0) / 1000 qty_1, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_1,   " +
            "round(max(s.this_upricebal), 2) cost_price_1, 0 qty_2, 0 sale_price_2, 0 cost_price_2, 0 qty_3, 0 sale_price_3, 0 cost_price_3  " +
            "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
            "where a.tr_date between '" + p_year + "0101' and to_char(last_day(to_date('" + p_year + "0101', 'YYYYMMDD')), 'YYYYMMDD')  " +
            "and a.del_if = 0  " +
            "and a.tr_status in ('2', '0')  " +
            "and a.pk = d.tac_crca_pk  " +
            "and d.del_if = 0  " +
            "and d.tco_item_pk = i.pk  " +
            "and s.std_ym = '" + p_year + "01'  " +
            "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
            "group by s.sizea " +
            "union all " +
            "select s.sizea, 0 qty_1, 0 sale_price_1, 0 cost_price_1, nvl(sum(d.qty), 0) / 1000 qty_2, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_2,   " +
            "round(max(s.this_upricebal), 2) cost_price_2, 0 qty_3, 0 sale_price_3, 0 cost_price_3 " +
            "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
            "where a.tr_date between '" + p_year + "0201' and to_char(last_day(to_date('" + p_year + "0201', 'YYYYMMDD')), 'YYYYMMDD')  " +
            "and a.del_if = 0  " +
            "and a.tr_status in ('2', '0')  " +
            "and a.pk = d.tac_crca_pk  " +
            "and d.del_if = 0  " +
            "and d.tco_item_pk = i.pk  " +
            "and s.std_ym = '" + p_year + "02'  " +
            "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
            "group by s.sizea " +
            "union all " +
            "select s.sizea, 0 qty_1, 0 sale_price_1, 0 cost_price_1, 0 qty_2, 0 sale_price_2, 0 cost_price_2, nvl(sum(d.qty), 0) / 1000 qty_3, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_3,   " +
            "round(max(s.this_upricebal), 2) cost_price_3 " +
            "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
            "where a.tr_date between '" + p_year + "0301 + ' and to_char(last_day(to_date('" + p_year + "0301', 'YYYYMMDD')), 'YYYYMMDD')  " +
            "and a.del_if = 0  " +
            "and a.tr_status in ('2', '0')  " +
            "and a.pk = d.tac_crca_pk  " +
            "and d.del_if = 0  " +
            "and d.tco_item_pk = i.pk  " +
            "and s.std_ym = '" + p_year + "03'  " +
            "and i.tac_abacctcode_p0k = s.tac_abacctcode_pk  " +
            "group by s.sizea " +
            ") t " +
            "group by t.sizea ";
    DataTable dt = ESysLib.TableReadOpen(SQL);        
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="MONTHLY%20UNIT%20PROFIT_files/filelist.xml">
<link rel=Edit-Time-Data href="MONTHLY%20UNIT%20PROFIT_files/editdata.mso">
<link rel=OLE-Object-Data href="MONTHLY%20UNIT%20PROFIT_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Le Huu Phuc</o:Author>
  <o:LastAuthor>Le Huu Phuc</o:LastAuthor>
  <o:LastPrinted>2011-11-18T07:53:18Z</o:LastPrinted>
  <o:Created>2011-11-18T07:26:32Z</o:Created>
  <o:LastSaved>2011-11-18T08:53:55Z</o:LastSaved>
  <o:Company>Vina Genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .25in .5in .25in;
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
	font-size:11.0pt;}
.xl25
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	text-align:center;}
.xl28
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl37
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FF99CC;
	mso-pattern:auto none;}
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
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>126</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>141</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>10230</x:WindowHeight>
  <x:WindowWidth>19995</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1016 style='border-collapse:
 collapse;table-layout:fixed;width:763pt'>
 <col width=60 style='mso-width-source:userset;mso-width-alt:2194;width:45pt'>
 <col width=82 style='mso-width-source:userset;mso-width-alt:2998;width:62pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=88 style='mso-width-source:userset;mso-width-alt:3218;width:66pt'>
 <col width=84 style='mso-width-source:userset;mso-width-alt:3072;width:63pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=88 style='mso-width-source:userset;mso-width-alt:3218;width:66pt'>
 <col width=84 style='mso-width-source:userset;mso-width-alt:3072;width:63pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2560;width:53pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=93 style='mso-width-source:userset;mso-width-alt:3401;width:70pt'>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl24 colspan=4 width=287 style='height:14.25pt;
  mso-ignore:colspan;width:216pt'># . <%=p_year %> MONTHLY UNIT PROFIT</td>
  <td width=88 style='width:66pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=93 style='width:70pt'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl24 style='height:14.25pt'></td>
  <td colspan=12 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl36 style='height:12.75pt'>TOTAL</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'>(Unit: 1000pcs, 1000VND)</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl38 style='border-bottom:.5pt solid black;
  height:25.5pt'>SIZE</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>JAN</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>FEB</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>MAR</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl37 style='height:12.75pt;border-top:none;border-left:
  none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
 </tr>
 <% 
     for (i = 0; i < dt.Rows.Count; i++)
     {
         v_profit = (decimal.Parse(dt.Rows[i][2].ToString()) - decimal.Parse(dt.Rows[i][3].ToString())) * decimal.Parse(dt.Rows[i][1].ToString()) ;
         v_profit = Math.Round(v_profit);
         v_profit_1 = (decimal.Parse(dt.Rows[i][5].ToString()) - decimal.Parse(dt.Rows[i][6].ToString())) * decimal.Parse(dt.Rows[i][4].ToString()) ;
         v_profit_1 = Math.Round(v_profit_1);
         v_profit_2 = ( decimal.Parse(dt.Rows[i][8].ToString()) - decimal.Parse(dt.Rows[i][9].ToString())) * decimal.Parse(dt.Rows[i][7].ToString()) ;
         v_profit_2 = Math.Round(v_profit_2); 
         v_tot_qty += decimal.Parse(dt.Rows[i][1].ToString());
         v_tot_qty_1 += decimal.Parse(dt.Rows[i][4].ToString());        
         v_tot_qty_2 += decimal.Parse(dt.Rows[i][7].ToString()) ;
         v_cost_amt += decimal.Parse(dt.Rows[i][1].ToString()) * decimal.Parse(dt.Rows[i][3].ToString()); // Cost Amount
         v_cost_amt_1 += decimal.Parse(dt.Rows[i][4].ToString()) * decimal.Parse(dt.Rows[i][6].ToString()); // Cost Amount
         v_cost_amt_2 += decimal.Parse(dt.Rows[i][7].ToString()) * decimal.Parse(dt.Rows[i][9].ToString()); // Cost Amount
         v_sale_amt += decimal.Parse(dt.Rows[i][1].ToString()) * decimal.Parse(dt.Rows[i][2].ToString()); // Sale Amount
         v_sale_amt_1 += decimal.Parse(dt.Rows[i][4].ToString()) * decimal.Parse(dt.Rows[i][5].ToString()); // Sale Amount
         v_sale_amt_2 += decimal.Parse(dt.Rows[i][7].ToString()) * decimal.Parse(dt.Rows[i][8].ToString()) ; // Sale Amount
        v_tot_profit += v_profit;
         v_tot_profit_1 += v_profit_1;
         v_tot_profit_2 += v_profit_2 ;
          %>
 <% 
     if (dt.Rows[i][0].ToString() == "#00")
     {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#00</td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
 </tr>
 <% }
    else if (dt.Rows[i][0].ToString() == "#0E")
    {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#0E</td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
 </tr>
 <% 
     }
     else if(dt.Rows[i][0].ToString() == "#0")
     {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'>#0</td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
 </tr>
 <% 
     }
     else if (dt.Rows[i][0].ToString() == "#1")
     {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>#1</td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
 </tr>
 <% 
     }
     else if (dt.Rows[i][0].ToString() == "#2")
     {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#2</td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
 </tr>
 <% 
     }
     else if (dt.Rows[i][9].ToString() == "#3")
     {         
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#3</td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
 </tr>
 <% 
     }
     else if(dt.Rows[i][0].ToString() = "#4")
     {
 %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl26 style='height:13.5pt;border-top:none'>#4</td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
 </tr>
 <% 
     }   
     }
     v_cost_price_avg = Math.Round(v_cost_amt / v_tot_qty, 2) ;     
     v_cost_price_avg_1 = Math.Round(v_cost_amt_1 / v_tot_qty_1, 2) ;     
     v_cost_price_avg_2 = Math.Round(v_cost_amt_2 / v_tot_qty_2, 2) ;    
     v_sale_price_avg = Math.Round( v_sale_amt / v_tot_qty, 2);
     v_sale_price_avg_1 = Math.Round( v_sale_amt_1 / v_tot_qty_1, 2);
     v_sale_price_avg_2 = Math.Round( v_sale_amt_2 / v_tot_qty_2, 2);
 %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl32 style='height:13.5pt'>&nbsp;</td>
  <td class=xl33 align=right style='border-left:none' x:num><%=v_tot_qty %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_avg %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_sale_price_avg %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_tot_profit %></td>
  <td class=xl33 align=right style='border-left:none' x:num><%=v_tot_qty_1 %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_avg_1 %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_sale_price_avg_1 %></td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%=v_tot_profit_1 %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl33 style='border-left:none' x:num><%=v_tot_qty_2 %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_avg_2 %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_sale_price_avg_2 %></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%=v_tot_profit_2 %><span
  style='mso-spacerun:yes'>   </span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td colspan=12 style='mso-ignore:colspan'></td>
 </tr>
 <% 
 SQL
	= "select t.sizea, nvl(sum(t.qty_1), 0) qty_1, max(t.sale_price_1) sale_price_1, max(t.cost_price_1) cost_price_1, sum(t.qty_2) qty_2, max(t.sale_price_2) sale_price_2, max(t.cost_price_2) cost_price_2, " + 
        "    sum(t.qty_3) qty_3, max(t.sale_price_3) sale_price_3, max(t.cost_price_3) cost_price_3 " +
        "from ( " +
        "select s.sizea, nvl(sum(d.qty), 0) / 1000 qty_1, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_1,   " +
        "round(max(s.this_upricebal), 2) cost_price_1, 0 qty_2, 0 sale_price_2, 0 cost_price_2, 0 qty_3, 0 sale_price_3, 0 cost_price_3  " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "0101' and to_char(last_day(to_date('" + p_year + "0101', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +
        "and a.tr_type = 'OS' " +
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "01'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        "union all " +
        "select s.sizea, 0 qty_1, 0 sale_price_1, 0 cost_price_1, nvl(sum(d.qty), 0) / 1000 qty_2, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_2,   " +
        "round(max(s.this_upricebal), 2) cost_price_2, 0 qty_3, 0 sale_price_3, 0 cost_price_3 " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "0201' and to_char(last_day(to_date('" + p_year + "0201', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +
        "and a.tr_type = 'OS' " +
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "02'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        "union all " +
        "select s.sizea, 0 qty_1, 0 sale_price_1, 0 cost_price_1, 0 qty_2, 0 sale_price_2, 0 cost_price_2, nvl(sum(d.qty), 0) / 1000 qty_3, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_3,   " +
        "round(max(s.this_upricebal), 2) cost_price_3 " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "0301 + ' and to_char(last_day(to_date('" + p_year + "0301', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +
        "and a.tr_type = 'OS' " +
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "03'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        ") t " +
        "group by t.sizea " ;
     dt = ESysLib.TableReadOpen(SQL);
     
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl36 style='height:12.75pt'>EXPORT</td>
  <td colspan=12 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl38 style='border-bottom:.5pt solid black;
  height:25.5pt'>SIZE</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>JAN</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>FEB</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>MAR</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl37 style='height:12.75pt;border-top:none;border-left:
  none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
 </tr>
 <% 
    v_tot_qty = 0; v_tot_qty_1 = 0; v_tot_qty_2 = 0;
    v_cost_amt = 0;  v_cost_amt_1 = 0; v_cost_amt_2 = 0;
    v_sale_amt = 0;  v_sale_amt_1 = 0; v_sale_amt_2 = 0;
    v_tot_profit = 0; v_tot_profit_1 = 0; v_tot_profit_2 = 0; 
     for(i = 0 ; i < dt.Rows.Count; i++)
     {
       v_profit = (decimal.Parse(dt.Rows[i][2].ToString()) - decimal.Parse(dt.Rows[i][3].ToString())) * decimal.Parse(dt.Rows[i][1].ToString()) ;
         v_profit = Math.Round(v_profit);
         v_profit_1 = (decimal.Parse(dt.Rows[i][5].ToString()) - decimal.Parse(dt.Rows[i][6].ToString())) * decimal.Parse(dt.Rows[i][4].ToString()) ;
         v_profit_1 = Math.Round(v_profit_1);
         v_profit_2 = ( decimal.Parse(dt.Rows[i][8].ToString()) - decimal.Parse(dt.Rows[i][9].ToString())) * decimal.Parse(dt.Rows[i][7].ToString()) ;
         v_profit_2 = Math.Round(v_profit_2); 
         v_tot_qty += decimal.Parse(dt.Rows[i][1].ToString());
         v_tot_qty_1 += decimal.Parse(dt.Rows[i][4].ToString());        
         v_tot_qty_2 += decimal.Parse(dt.Rows[i][7].ToString()) ;
         v_cost_amt += decimal.Parse(dt.Rows[i][1].ToString()) * decimal.Parse(dt.Rows[i][3].ToString()); // Cost Amount
         v_cost_amt_1 += decimal.Parse(dt.Rows[i][4].ToString()) * decimal.Parse(dt.Rows[i][6].ToString()); // Cost Amount
         v_cost_amt_2 += decimal.Parse(dt.Rows[i][7].ToString()) * decimal.Parse(dt.Rows[i][9].ToString()); // Cost Amount
         v_sale_amt += decimal.Parse(dt.Rows[i][1].ToString()) * decimal.Parse(dt.Rows[i][2].ToString()); // Sale Amount
         v_sale_amt_1 += decimal.Parse(dt.Rows[i][4].ToString()) * decimal.Parse(dt.Rows[i][5].ToString()); // Sale Amount
         v_sale_amt_2 += decimal.Parse(dt.Rows[i][7].ToString()) * decimal.Parse(dt.Rows[i][8].ToString()); // Sale Amount
        v_tot_profit += v_profit;
         v_tot_profit_1 += v_profit_1;
         v_tot_profit_2 += v_profit_2 ;      
 %>
 <% 
    if(dt.Rows[i][0].ToString() =="#0")
    {            
 %>
 <tr height=17 style='height:12.75pt'> 
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#0</td>
 <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
  <% 
    }
    else if(dt.Rows[i][0].ToString() =="#00")
    {
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#00</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td> 
  </tr>
 <% 
    }
    else if(dt.Rows[i][0].ToString() =="#0E")        
    {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'>#0E</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
 </tr>
 <% 
    }
    else if(dt.Rows[i][0].ToString() == "#1")
    {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>#1</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td> 
 </tr>
 <% 
    }
    else if(dt.Rows[i][0].ToString() == "#2")
    {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#2</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td> 
 </tr>
 <% 
    }
    else if(dt.Rows[i][0].ToString() == "#3")
    {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#3</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td> 
 </tr>
 <% 
    }
    else if(dt.Rows[i][0].ToString() == "#4")
    {
 %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl26 style='height:13.5pt;border-top:none'>#4</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td> 
 </tr>
 <% 
    }
     }
    v_cost_price_avg = Math.Round(v_cost_amt / v_tot_qty, 2) ;     
     v_cost_price_avg_1 = Math.Round(v_cost_amt_1 / v_tot_qty_1, 2) ;     
     v_cost_price_avg_2 = Math.Round(v_cost_amt_2 / v_tot_qty_2, 2) ;    
     v_sale_price_avg = Math.Round( v_sale_amt / v_tot_qty, 2);
     v_sale_price_avg_1 = Math.Round( v_sale_amt_1 / v_tot_qty_1, 2);
     v_sale_price_avg_2 = Math.Round( v_sale_amt_2 / v_tot_qty_2, 2);     
 %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl32 style='height:13.5pt'>&nbsp;</td>
  <td class=xl33 align=right style='border-left:none' x:num><%=v_tot_qty %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_average %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_sale_price_avg %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_tot_profit %></td>
  <td class=xl33 align=right style='border-left:none' x:num><%=v_tot_qty_1 %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_avg_1 %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_sale_price_avg_1 %></td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%=v_tot_profit_1 %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl33 style='border-left:none' x:num><%=v_tot_qty_2 %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_avg_2 %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_sale_price_avg_2 %></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%=v_tot_profit_2 %><span
  style='mso-spacerun:yes'>   </span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl36 colspan=2 style='height:12.75pt;mso-ignore:colspan'>DOMESTIC</td>
  <td colspan=11 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl38 style='border-bottom:.5pt solid black;
  height:25.5pt'>SIZE</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>JAN</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>FEB</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>MAR</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl37 style='height:12.75pt;border-top:none;border-left:
  none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
 </tr>
 <% 
      SQL
	= "select t.sizea, nvl(sum(t.qty_1), 0) qty_1, max(t.sale_price_1) sale_price_1, max(t.cost_price_1) cost_price_1, sum(t.qty_2) qty_2, max(t.sale_price_2) sale_price_2, max(t.cost_price_2) cost_price_2, " + 
        "    sum(t.qty_3) qty_3, max(t.sale_price_3) sale_price_3, max(t.cost_price_3) cost_price_3 " +
        "from ( " +
        "select s.sizea, nvl(sum(d.qty), 0) / 1000 qty_1, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_1,   " +
        "round(max(s.this_upricebal), 2) cost_price_1, 0 qty_2, 0 sale_price_2, 0 cost_price_2, 0 qty_3, 0 sale_price_3, 0 cost_price_3  " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "0101' and to_char(last_day(to_date('" + p_year + "0101', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +
        "and a.tr_type = 'DO' " +
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "01'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        "union all " +
        "select s.sizea, 0 qty_1, 0 sale_price_1, 0 cost_price_1, nvl(sum(d.qty), 0) / 1000 qty_2, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_2,   " +
        "round(max(s.this_upricebal), 2) cost_price_2, 0 qty_3, 0 sale_price_3, 0 cost_price_3 " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "0201' and to_char(last_day(to_date('" + p_year + "0228', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +
        "and a.tr_type = 'DO' " +
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "02'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        "union all " +
        "select s.sizea, 0 qty_1, 0 sale_price_1, 0 cost_price_1, 0 qty_2, 0 sale_price_2, 0 cost_price_2, nvl(sum(d.qty), 0) / 1000 qty_3, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_3,   " +
        "round(max(s.this_upricebal), 2) cost_price_3 " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "0301' and to_char(last_day(to_date('" + p_year + "0301', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +
        "and a.tr_type = 'DO' " +
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "03'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        ") t " +
        "group by t.sizea " ;
     dt = ESysLib.TableReadOpen(SQL);
 v_tot_qty = 0; v_tot_qty_1 = 0; v_tot_qty_2 = 0;
    v_cost_amt = 0;  v_cost_amt_1 = 0; v_cost_amt_2 = 0;
    v_sale_amt = 0;  v_sale_amt_1 = 0; v_sale_amt_2 = 0;
    v_tot_profit = 0; v_tot_profit_1 = 0; v_tot_profit_2 = 0; 
     for(i = 0 ; i < dt.Rows.Count; i++)
     {
       v_profit = (decimal.Parse(dt.Rows[i][2].ToString()) - decimal.Parse(dt.Rows[i][3].ToString())) * decimal.Parse(dt.Rows[i][1].ToString()) ;
         v_profit = Math.Round(v_profit);
         v_profit_1 = (decimal.Parse(dt.Rows[i][5].ToString()) - decimal.Parse(dt.Rows[i][6].ToString())) * decimal.Parse(dt.Rows[i][4].ToString()) ;
         v_profit_1 = Math.Round(v_profit_1);
         v_profit_2 = ( decimal.Parse(dt.Rows[i][8].ToString()) - decimal.Parse(dt.Rows[i][9].ToString())) * decimal.Parse(dt.Rows[i][7].ToString()) ;
         v_profit_2 = Math.Round(v_profit_2); 
         v_tot_qty += decimal.Parse(dt.Rows[i][1].ToString());
         v_tot_qty_1 += decimal.Parse(dt.Rows[i][4].ToString());        
         v_tot_qty_2 += decimal.Parse(dt.Rows[i][7].ToString()) ;
         v_cost_amt += decimal.Parse(dt.Rows[i][1].ToString()) * decimal.Parse(dt.Rows[i][3].ToString()); // Cost Amount
         v_cost_amt_1 += decimal.Parse(dt.Rows[i][4].ToString()) * decimal.Parse(dt.Rows[i][6].ToString()); // Cost Amount
         v_cost_amt_2 += decimal.Parse(dt.Rows[i][7].ToString()) * decimal.Parse(dt.Rows[i][9].ToString()); // Cost Amount
         v_sale_amt += decimal.Parse(dt.Rows[i][1].ToString()) * decimal.Parse(dt.Rows[i][2].ToString()); // Sale Amount
         v_sale_amt_1 += decimal.Parse(dt.Rows[i][4].ToString()) * decimal.Parse(dt.Rows[i][5].ToString()); // Sale Amount
         v_sale_amt_2 += decimal.Parse(dt.Rows[i][7].ToString()) * decimal.Parse(dt.Rows[i][8].ToString()); // Sale Amount
        v_tot_profit += v_profit;
         v_tot_profit_1 += v_profit_1;
         v_tot_profit_2 += v_profit_2 ;
    if(dt.Rows[i][0].ToString() == "#0")
    {              
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#0</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
 </tr>
 <%} 
    else if(dt.Rows[i][0].ToString() == "#00")
    {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#00</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
 <% 
    }
    else if(dt.Rows[0][0].ToString() == "#0E")
    {            
 %>  
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'>#0E</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
  <% 
    }
    else if(dt.Rows[i][0].ToString() == "#1")
    {
        %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>#1</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
  <% 
    }
    else if(dt.Rows[i][0].ToString() == "#2")
    {
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#2</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td> 
  </tr>
 <tr height=17 style='height:12.75pt'>
 <%
    }
    else if(dt.Rows[i][0].ToString() == "#3")
    {
 %>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#3</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %> </td>
 </tr>
 <% 
    }
    else if(dt.Rows[i][0].ToString() == "#4")
    { 
 %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl26 style='height:13.5pt;border-top:none'>#4</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %> </td> 
  </tr>
  <% 
    }
    }
     v_cost_price_avg = Math.Round(v_cost_amt / v_tot_qty, 2) ;     
     v_cost_price_avg_1 = Math.Round(v_cost_amt_1 / v_tot_qty_1, 2) ;     
     v_cost_price_avg_2 = Math.Round(v_cost_amt_2 / v_tot_qty_2, 2) ;    
     v_sale_price_avg = Math.Round( v_sale_amt / v_tot_qty, 2);
     v_sale_price_avg_1 = Math.Round( v_sale_amt_1 / v_tot_qty_1, 2);
     v_sale_price_avg_2 = Math.Round( v_sale_amt_2 / v_tot_qty_2, 2);    
  %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl32 style='height:13.5pt'>&nbsp;</td>
  <td class=xl33 align=right style='border-left:none' x:num><%=v_tot_qty %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_average %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_sale_price_avg %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_tot_profit %></td>
  <td class=xl33 align=right style='border-left:none' x:num><%=v_tot_qty_1 %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_avg_1 %> </td>
  <td class=xl34 style='border-left:none'><%=v_sale_price_avg_1 %></td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%=v_tot_profit_1 %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl33 style='border-left:none'><%=v_tot_qty_2 %></td>
  <td class=xl34 style='border-left:none'><%=v_cost_price_avg_2 %></td>
  <td class=xl34 style='border-left:none'><%=v_sale_price_avg_2 %></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%=v_tot_profit_2 %><span
  style='mso-spacerun:yes'>   </span></td>
 </tr>
 <tr height=51 style='height:38.25pt;mso-xlrowspan:3'>
  <td height=51 colspan=13 style='height:38.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl24 colspan=4 style='height:14.25pt;mso-ignore:colspan'>#
  . <%=p_year %> MONTHLY UNIT PROFIT</td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl24 style='height:14.25pt'></td>
  <td colspan=12 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl36 style='height:12.75pt'>TOTAL</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'>(Unit: 1000pcs, 1000VND)</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl38 style='border-bottom:.5pt solid black;
  height:25.5pt'>SIZE</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>APR</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>MAY</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>JUN</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl37 style='height:12.75pt;border-top:none;border-left:
  none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
 </tr>
<% 
         SQL
        = "select t.sizea, nvl(sum(t.qty_1), 0) qty_1, max(t.sale_price_1) sale_price_1, max(t.cost_price_1) cost_price_1, sum(t.qty_2) qty_2, max(t.sale_price_2) sale_price_2, max(t.cost_price_2) cost_price_2, " +
            "    sum(t.qty_3) qty_3, max(t.sale_price_3) sale_price_3, max(t.cost_price_3) cost_price_3 " +
            "from ( " +
            "select s.sizea, nvl(sum(d.qty), 0) / 1000 qty_1, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_1,   " +
            "round(max(s.this_upricebal), 2) cost_price_1, 0 qty_2, 0 sale_price_2, 0 cost_price_2, 0 qty_3, 0 sale_price_3, 0 cost_price_3  " +
            "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
            "where a.tr_date between '" + p_year + "0401' and to_char(last_day(to_date('" + p_year + "0401', 'YYYYMMDD')), 'YYYYMMDD')  " +
            "and a.del_if = 0  " +
            "and a.tr_status in ('2', '0')  " +
            "and a.pk = d.tac_crca_pk  " +
            "and d.del_if = 0  " +
            "and d.tco_item_pk = i.pk  " +
            "and s.std_ym = '" + p_year + "04'  " +
            "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
            "group by s.sizea " +
            "union all " +
            "select s.sizea, 0 qty_1, 0 sale_price_1, 0 cost_price_1, nvl(sum(d.qty), 0) / 1000 qty_2, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_2,   " +
            "round(max(s.this_upricebal), 2) cost_price_2, 0 qty_3, 0 sale_price_3, 0 cost_price_3 " +
            "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
            "where a.tr_date between '" + p_year + "0501' and to_char(last_day(to_date('" + p_year + "0501', 'YYYYMMDD')), 'YYYYMMDD')  " +
            "and a.del_if = 0  " +
            "and a.tr_status in ('2', '0')  " +
            "and a.pk = d.tac_crca_pk  " +
            "and d.del_if = 0  " +
            "and d.tco_item_pk = i.pk  " +
            "and s.std_ym = '" + p_year + "05'  " +
            "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
            "group by s.sizea " +
            "union all " +
            "select s.sizea, 0 qty_1, 0 sale_price_1, 0 cost_price_1, 0 qty_2, 0 sale_price_2, 0 cost_price_2, nvl(sum(d.qty), 0) / 1000 qty_3, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_3,   " +
            "round(max(s.this_upricebal), 2) cost_price_3 " +
            "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
            "where a.tr_date between '" + p_year + "0601 + ' and to_char(last_day(to_date('" + p_year + "0601', 'YYYYMMDD')), 'YYYYMMDD')  " +
            "and a.del_if = 0  " +
            "and a.tr_status in ('2', '0')  " +
            "and a.pk = d.tac_crca_pk  " +
            "and d.del_if = 0  " +
            "and d.tco_item_pk = i.pk  " +
            "and s.std_ym = '" + p_year + "06'  " +
            "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
            "group by s.sizea " +
            ") t " +
            "group by t.sizea ";
    dt = ESysLib.TableReadOpen(SQL);
    v_tot_qty = 0; v_tot_qty_1 = 0; v_tot_qty_2 = 0;
    v_cost_amt = 0;  v_cost_amt_1 = 0; v_cost_amt_2 = 0;
    v_sale_amt = 0;  v_sale_amt_1 = 0; v_sale_amt_2 = 0;
    v_tot_profit = 0; v_tot_profit_1 = 0; v_tot_profit_2 = 0; 
    for( i = 0; i < dt.Rows.Count; i++)
    {
         v_profit = (decimal.Parse(dt.Rows[i][2].ToString()) - decimal.Parse(dt.Rows[i][3].ToString())) * decimal.Parse(dt.Rows[i][1].ToString()) ;
         v_profit = Math.Round(v_profit);
         v_profit_1 = (decimal.Parse(dt.Rows[i][5].ToString()) - decimal.Parse(dt.Rows[i][6].ToString())) * decimal.Parse(dt.Rows[i][4].ToString()) ;
         v_profit_1 = Math.Round(v_profit_1);
         v_profit_2 = ( decimal.Parse(dt.Rows[i][8].ToString()) - decimal.Parse(dt.Rows[i][9].ToString())) * decimal.Parse(dt.Rows[i][7].ToString()) ;
         v_profit_2 = Math.Round(v_profit_2); 
         v_tot_qty += decimal.Parse(dt.Rows[i][1].ToString());
         v_tot_qty_1 += decimal.Parse(dt.Rows[i][4].ToString());        
         v_tot_qty_2 += decimal.Parse(dt.Rows[i][7].ToString()) ;
         v_cost_amt += decimal.Parse(dt.Rows[i][1].ToString()) * decimal.Parse(dt.Rows[i][3].ToString()); // Cost Amount
         v_cost_amt_1 += decimal.Parse(dt.Rows[i][4].ToString()) * decimal.Parse(dt.Rows[i][6].ToString()); // Cost Amount
         v_cost_amt_2 += decimal.Parse(dt.Rows[i][7].ToString()) * decimal.Parse(dt.Rows[i][9].ToString()); // Cost Amount
         v_sale_amt += decimal.Parse(dt.Rows[i][1].ToString()) * decimal.Parse(dt.Rows[i][2].ToString()); // Sale Amount
         v_sale_amt_1 += decimal.Parse(dt.Rows[i][4].ToString()) * decimal.Parse(dt.Rows[i][5].ToString()); // Sale Amount
         v_sale_amt_2 += decimal.Parse(dt.Rows[i][7].ToString()) * decimal.Parse(dt.Rows[i][8].ToString()); // Sale Amount
        v_tot_profit += v_profit;
         v_tot_profit_1 += v_profit_1;
         v_tot_profit_2 += v_profit_2 ;
        
    if(dt.Rows[i][0].ToString() == "#0")
    {              
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#0</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
 </tr>
 <%} 
    else if(dt.Rows[i][0].ToString() == "#00")
    {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#00</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
 <% 
    }
    else if(dt.Rows[0][0].ToString() == "#0E")
    {            
 %>  
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'>#0E</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
  <% 
    }
    else if(dt.Rows[i][0].ToString() == "#1")
    {
        %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>#1</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
  <% 
    }
    else if(dt.Rows[i][0].ToString() == "#2")
    {
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#2</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td> 
  </tr>
 <tr height=17 style='height:12.75pt'>
 <%
    }
    else if(dt.Rows[i][0].ToString() == "#3")
    {
 %>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#3</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %> </td>
 </tr>
 <% 
    }
    else if(dt.Rows[i][0].ToString() == "#4")
    { 
 %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl26 style='height:13.5pt;border-top:none'>#4</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %> </td> 
  </tr>
  <% }    
    }
     v_cost_price_avg = Math.Round(v_cost_amt / v_tot_qty, 2) ;     
     v_cost_price_avg_1 = Math.Round(v_cost_amt_1 / v_tot_qty_1, 2) ;     
     v_cost_price_avg_2 = Math.Round(v_cost_amt_2 / v_tot_qty_2, 2) ;    
     v_sale_price_avg = Math.Round( v_sale_amt / v_tot_qty, 2);
     v_sale_price_avg_1 = Math.Round( v_sale_amt_1 / v_tot_qty_1, 2);
     v_sale_price_avg_2 = Math.Round( v_sale_amt_2 / v_tot_qty_2, 2);
    
  %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl32 style='height:13.5pt'>&nbsp;</td>
  <td class=xl33 align=right style='border-left:none' x:num><%=v_tot_qty %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_average %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_sale_price_avg %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_tot_profit %></td>
  <td class=xl33 align=right style='border-left:none' x:num><%=v_tot_qty_1 %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_avg_1 %> </td>
  <td class=xl34 style='border-left:none'><%=v_sale_price_avg_1 %></td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%=v_tot_profit_1 %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl33 style='border-left:none'><%=v_tot_qty_2 %></td>
  <td class=xl34 style='border-left:none'><%=v_cost_price_avg_2 %></td>
  <td class=xl34 style='border-left:none'><%=v_sale_price_avg_2 %></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%=v_tot_profit_2 %><span
  style='mso-spacerun:yes'>   </span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td colspan=12 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl36 style='height:12.75pt'>EXPORT</td>
  <td colspan=12 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl38 style='border-bottom:.5pt solid black;
  height:25.5pt'>SIZE</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>APR</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>MAY</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>JUN</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl37 style='height:12.75pt;border-top:none;border-left:
  none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
 </tr>
<% 
 SQL
	= "select t.sizea, nvl(sum(t.qty_1), 0) qty_1, max(t.sale_price_1) sale_price_1, max(t.cost_price_1) cost_price_1, sum(t.qty_2) qty_2, max(t.sale_price_2) sale_price_2, max(t.cost_price_2) cost_price_2, " + 
        "    sum(t.qty_3) qty_3, max(t.sale_price_3) sale_price_3, max(t.cost_price_3) cost_price_3 " +
        "from ( " +
        "select s.sizea, nvl(sum(d.qty), 0) / 1000 qty_1, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_1,   " +
        "round(max(s.this_upricebal), 2) cost_price_1, 0 qty_2, 0 sale_price_2, 0 cost_price_2, 0 qty_3, 0 sale_price_3, 0 cost_price_3  " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "0401' and to_char(last_day(to_date('" + p_year + "0401', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +
        "and a.tr_type = 'OS' " +
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "04'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        "union all " +
        "select s.sizea, 0 qty_1, 0 sale_price_1, 0 cost_price_1, nvl(sum(d.qty), 0) / 1000 qty_2, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_2,   " +
        "round(max(s.this_upricebal), 2) cost_price_2, 0 qty_3, 0 sale_price_3, 0 cost_price_3 " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "0501' and to_char(last_day(to_date('" + p_year + "0501', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +
        "and a.tr_type = 'OS' " +
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "05'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        "union all " +
        "select s.sizea, 0 qty_1, 0 sale_price_1, 0 cost_price_1, 0 qty_2, 0 sale_price_2, 0 cost_price_2, nvl(sum(d.qty), 0) / 1000 qty_3, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_3,   " +
        "round(max(s.this_upricebal), 2) cost_price_3 " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "0601 + ' and to_char(last_day(to_date('" + p_year + "0601', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +
        "and a.tr_type = 'OS' " +
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "06'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        ") t " +
        "group by t.sizea " ;
     dt = ESysLib.TableReadOpen(SQL);
      
    v_tot_qty = 0; v_tot_qty_1 = 0; v_tot_qty_2 = 0;
    v_cost_amt = 0;  v_cost_amt_1 = 0; v_cost_amt_2 = 0;
    v_sale_amt = 0;  v_sale_amt_1 = 0; v_sale_amt_2 = 0;
    v_tot_profit = 0; v_tot_profit_1 = 0; v_tot_profit_2 = 0; 
     for(i = 0 ; i < dt.Rows.Count; i++)
     {
       v_profit = (decimal.Parse(dt.Rows[i][2].ToString()) - decimal.Parse(dt.Rows[i][3].ToString())) * decimal.Parse(dt.Rows[i][1].ToString()) ;
         v_profit = Math.Round(v_profit);
         v_profit_1 = (decimal.Parse(dt.Rows[i][5].ToString()) - decimal.Parse(dt.Rows[i][6].ToString())) * decimal.Parse(dt.Rows[i][4].ToString()) ;
         v_profit_1 = Math.Round(v_profit_1);
         v_profit_2 = ( decimal.Parse(dt.Rows[i][8].ToString()) - decimal.Parse(dt.Rows[i][9].ToString())) * decimal.Parse(dt.Rows[i][7].ToString()) ;
         v_profit_2 = Math.Round(v_profit_2); 
         v_tot_qty += decimal.Parse(dt.Rows[i][1].ToString());
         v_tot_qty_1 += decimal.Parse(dt.Rows[i][4].ToString());        
         v_tot_qty_2 += decimal.Parse(dt.Rows[i][7].ToString()) ;
         v_cost_amt += decimal.Parse(dt.Rows[i][1].ToString()) * decimal.Parse(dt.Rows[i][3].ToString()); // Cost Amount
         v_cost_amt_1 += decimal.Parse(dt.Rows[i][4].ToString()) * decimal.Parse(dt.Rows[i][6].ToString()); // Cost Amount
         v_cost_amt_2 += decimal.Parse(dt.Rows[i][7].ToString()) * decimal.Parse(dt.Rows[i][9].ToString()); // Cost Amount
         v_sale_amt += decimal.Parse(dt.Rows[i][1].ToString()) * decimal.Parse(dt.Rows[i][2].ToString()); // Sale Amount
         v_sale_amt_1 += decimal.Parse(dt.Rows[i][4].ToString()) * decimal.Parse(dt.Rows[i][5].ToString()); // Sale Amount
         v_sale_amt_2 += decimal.Parse(dt.Rows[i][7].ToString()) * decimal.Parse(dt.Rows[i][8].ToString()); // Sale Amount
        v_tot_profit += v_profit;
         v_tot_profit_1 += v_profit_1;
         v_tot_profit_2 += v_profit_2 ;      
 %>
 <% 
    if(dt.Rows[i][0].ToString() =="#0")
    {            
 %>
 <tr height=17 style='height:12.75pt'> 
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#0</td>
 <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
  <% 
    }
    else if(dt.Rows[i][0].ToString() =="#00")
    {
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#00</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td> 
  </tr>
 <% 
    }
    else if(dt.Rows[i][0].ToString() =="#0E")        
    {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'>#0E</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
 </tr>
 <% 
    }
    else if(dt.Rows[i][0].ToString() == "#1")
    {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>#1</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td> 
 </tr>
 <% 
    }
    else if(dt.Rows[i][0].ToString() == "#2")
    {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#2</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td> 
 </tr>
 <% 
    }
    else if(dt.Rows[i][0].ToString() == "#3")
    {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#3</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td> 
 </tr>
 <% 
    }
    else if(dt.Rows[i][0].ToString() == "#4")
    {
 %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl26 style='height:13.5pt;border-top:none'>#4</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td> 
 </tr>
 <% 
    }
     }
    v_cost_price_avg = Math.Round(v_cost_amt / v_tot_qty, 2) ;     
     v_cost_price_avg_1 = Math.Round(v_cost_amt_1 / v_tot_qty_1, 2) ;     
     v_cost_price_avg_2 = Math.Round(v_cost_amt_2 / v_tot_qty_2, 2) ;    
     v_sale_price_avg = Math.Round( v_sale_amt / v_tot_qty, 2);
     v_sale_price_avg_1 = Math.Round( v_sale_amt_1 / v_tot_qty_1, 2);
     v_sale_price_avg_2 = Math.Round( v_sale_amt_2 / v_tot_qty_2, 2);     
 %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl32 style='height:13.5pt'>&nbsp;</td>
  <td class=xl33 align=right style='border-left:none' x:num><%=v_tot_qty %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_average %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_sale_price_avg %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_tot_profit %></td>
  <td class=xl33 align=right style='border-left:none' x:num><%=v_tot_qty_1 %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_avg_1 %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_sale_price_avg_1 %></td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%=v_tot_profit_1 %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl33 style='border-left:none' x:num><%=v_tot_qty_2 %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_avg_2 %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_sale_price_avg_2 %></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%=v_tot_profit_2 %><span
  style='mso-spacerun:yes'>   </span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl36 colspan=2 style='height:12.75pt;mso-ignore:colspan'>DOMESTIC</td>
  <td colspan=11 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl38 style='border-bottom:.5pt solid black;
  height:25.5pt'>SIZE</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>APR</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>MAY</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>JUN</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl37 style='height:12.75pt;border-top:none;border-left:
  none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
 </tr>
 <%
      SQL
	= "select t.sizea, nvl(sum(t.qty_1), 0) qty_1, max(t.sale_price_1) sale_price_1, max(t.cost_price_1) cost_price_1, sum(t.qty_2) qty_2, max(t.sale_price_2) sale_price_2, max(t.cost_price_2) cost_price_2, " + 
        "    sum(t.qty_3) qty_3, max(t.sale_price_3) sale_price_3, max(t.cost_price_3) cost_price_3 " +
        "from ( " +
        "select s.sizea, nvl(sum(d.qty), 0) / 1000 qty_1, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_1,   " +
        "round(max(s.this_upricebal), 2) cost_price_1, 0 qty_2, 0 sale_price_2, 0 cost_price_2, 0 qty_3, 0 sale_price_3, 0 cost_price_3  " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "0401' and to_char(last_day(to_date('" + p_year + "0401', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +
        "and a.tr_type = 'DO' " +
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "04'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        "union all " +
        "select s.sizea, 0 qty_1, 0 sale_price_1, 0 cost_price_1, nvl(sum(d.qty), 0) / 1000 qty_2, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_2,   " +
        "round(max(s.this_upricebal), 2) cost_price_2, 0 qty_3, 0 sale_price_3, 0 cost_price_3 " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "0501' and to_char(last_day(to_date('" + p_year + "0501', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +
        "and a.tr_type = 'DO' " +
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "05'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        "union all " +
        "select s.sizea, 0 qty_1, 0 sale_price_1, 0 cost_price_1, 0 qty_2, 0 sale_price_2, 0 cost_price_2, nvl(sum(d.qty), 0) / 1000 qty_3, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_3,   " +
        "round(max(s.this_upricebal), 2) cost_price_3 " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "0601' and to_char(last_day(to_date('" + p_year + "0601', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +
        "and a.tr_type = 'DO' " +
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "06'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        ") t " +
        "group by t.sizea " ;
     dt = ESysLib.TableReadOpen(SQL);
 v_tot_qty = 0; v_tot_qty_1 = 0; v_tot_qty_2 = 0;
    v_cost_amt = 0;  v_cost_amt_1 = 0; v_cost_amt_2 = 0;
    v_sale_amt = 0;  v_sale_amt_1 = 0; v_sale_amt_2 = 0;
    v_tot_profit = 0; v_tot_profit_1 = 0; v_tot_profit_2 = 0; 
     for(i = 0 ; i < dt.Rows.Count; i++)
     {
       v_profit = (decimal.Parse(dt.Rows[i][2].ToString()) - decimal.Parse(dt.Rows[i][3].ToString())) * decimal.Parse(dt.Rows[i][1].ToString()) ;
         v_profit = Math.Round(v_profit);
         v_profit_1 = (decimal.Parse(dt.Rows[i][5].ToString()) - decimal.Parse(dt.Rows[i][6].ToString())) * decimal.Parse(dt.Rows[i][4].ToString()) ;
         v_profit_1 = Math.Round(v_profit_1);
         v_profit_2 = ( decimal.Parse(dt.Rows[i][8].ToString()) - decimal.Parse(dt.Rows[i][9].ToString())) * decimal.Parse(dt.Rows[i][7].ToString()) ;
         v_profit_2 = Math.Round(v_profit_2); 
         v_tot_qty += decimal.Parse(dt.Rows[i][1].ToString());
         v_tot_qty_1 += decimal.Parse(dt.Rows[i][4].ToString());        
         v_tot_qty_2 += decimal.Parse(dt.Rows[i][7].ToString()) ;
         v_cost_amt += decimal.Parse(dt.Rows[i][1].ToString()) * decimal.Parse(dt.Rows[i][3].ToString()); // Cost Amount
         v_cost_amt_1 += decimal.Parse(dt.Rows[i][4].ToString()) * decimal.Parse(dt.Rows[i][6].ToString()); // Cost Amount
         v_cost_amt_2 += decimal.Parse(dt.Rows[i][7].ToString()) * decimal.Parse(dt.Rows[i][9].ToString()); // Cost Amount
         v_sale_amt += decimal.Parse(dt.Rows[i][1].ToString()) * decimal.Parse(dt.Rows[i][2].ToString()); // Sale Amount
         v_sale_amt_1 += decimal.Parse(dt.Rows[i][4].ToString()) * decimal.Parse(dt.Rows[i][5].ToString()); // Sale Amount
         v_sale_amt_2 += decimal.Parse(dt.Rows[i][7].ToString()) * decimal.Parse(dt.Rows[i][8].ToString()); // Sale Amount
        v_tot_profit += v_profit;
         v_tot_profit_1 += v_profit_1;
         v_tot_profit_2 += v_profit_2 ;
    if(dt.Rows[i][0].ToString() == "#0")
    {    
%> 
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#0</td>
 <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
  <% 
    }
    else if(dt.Rows[i][0].ToString() =="#00")
    {
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#00</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td> 
  </tr>
 <% 
    }
    else if(dt.Rows[i][0].ToString() =="#0E")        
    {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'>#0E</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
 </tr>
 <% 
    }
    else if(dt.Rows[i][0].ToString() == "#1")
    {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>#1</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td> 
 </tr>
 <% 
    }
    else if(dt.Rows[i][0].ToString() == "#2")
    {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#2</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td> 
 </tr>
 <% 
    }
    else if(dt.Rows[i][0].ToString() == "#3")
    {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#3</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td> 
 </tr>
 <% 
    }
    else if(dt.Rows[i][0].ToString() == "#4")
    {
 %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl26 style='height:13.5pt;border-top:none'>#4</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td> 
 </tr>
 <% 
    }
     }
    v_cost_price_avg = Math.Round(v_cost_amt / v_tot_qty, 2) ;     
     v_cost_price_avg_1 = Math.Round(v_cost_amt_1 / v_tot_qty_1, 2) ;     
     v_cost_price_avg_2 = Math.Round(v_cost_amt_2 / v_tot_qty_2, 2) ;    
     v_sale_price_avg = Math.Round( v_sale_amt / v_tot_qty, 2);
     v_sale_price_avg_1 = Math.Round( v_sale_amt_1 / v_tot_qty_1, 2);
     v_sale_price_avg_2 = Math.Round( v_sale_amt_2 / v_tot_qty_2, 2);     
 %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl32 style='height:13.5pt'>&nbsp;</td>
  <td class=xl33 align=right style='border-left:none' x:num><%=v_tot_qty %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_average %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_sale_price_avg %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_tot_profit %></td>
  <td class=xl33 align=right style='border-left:none' x:num><%=v_tot_qty_1 %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_avg_1 %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_sale_price_avg_1 %></td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%=v_tot_profit_1 %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl33 style='border-left:none' x:num><%=v_tot_qty_2 %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_avg_2 %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_sale_price_avg_2 %></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%=v_tot_profit_2 %><span
  style='mso-spacerun:yes'>   </span></td>
 </tr>
 <tr height=51 style='height:38.25pt;mso-xlrowspan:3'>
  <td height=51 colspan=13 style='height:38.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl24 colspan=4 style='height:14.25pt;mso-ignore:colspan'>#
  . <%=p_year %> MONTHLY UNIT PROFIT</td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl24 style='height:14.25pt'></td>
  <td colspan=12 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl36 style='height:12.75pt'>TOTAL</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'>(Unit: 1000pcs, 1000VND)</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl38 style='border-bottom:.5pt solid black;
  height:25.5pt'>SIZE</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>JUL</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>AUG</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>SEP</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl37 style='height:12.75pt;border-top:none;border-left:
  none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
 </tr>
 <% 
         SQL
        = "select t.sizea, nvl(sum(t.qty_1), 0) qty_1, max(t.sale_price_1) sale_price_1, max(t.cost_price_1) cost_price_1, sum(t.qty_2) qty_2, max(t.sale_price_2) sale_price_2, max(t.cost_price_2) cost_price_2, " +
            "    sum(t.qty_3) qty_3, max(t.sale_price_3) sale_price_3, max(t.cost_price_3) cost_price_3 " +
            "from ( " +
            "select s.sizea, nvl(sum(d.qty), 0) / 1000 qty_1, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_1,   " +
            "round(max(s.this_upricebal), 2) cost_price_1, 0 qty_2, 0 sale_price_2, 0 cost_price_2, 0 qty_3, 0 sale_price_3, 0 cost_price_3  " +
            "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
            "where a.tr_date between '" + p_year + "0701' and to_char(last_day(to_date('" + p_year + "0701', 'YYYYMMDD')), 'YYYYMMDD')  " +
            "and a.del_if = 0  " +
            "and a.tr_status in ('2', '0')  " +
            "and a.pk = d.tac_crca_pk  " +
            "and d.del_if = 0  " +
            "and d.tco_item_pk = i.pk  " +
            "and s.std_ym = '" + p_year + "07'  " +
            "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
            "group by s.sizea " +
            "union all " +
            "select s.sizea, 0 qty_1, 0 sale_price_1, 0 cost_price_1, nvl(sum(d.qty), 0) / 1000 qty_2, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_2,   " +
            "round(max(s.this_upricebal), 2) cost_price_2, 0 qty_3, 0 sale_price_3, 0 cost_price_3 " +
            "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
            "where a.tr_date between '" + p_year + "0801' and to_char(last_day(to_date('" + p_year + "0801', 'YYYYMMDD')), 'YYYYMMDD')  " +
            "and a.del_if = 0  " +
            "and a.tr_status in ('2', '0')  " +
            "and a.pk = d.tac_crca_pk  " +
            "and d.del_if = 0  " +
            "and d.tco_item_pk = i.pk  " +
            "and s.std_ym = '" + p_year + "08'  " +
            "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
            "group by s.sizea " +
            "union all " +
            "select s.sizea, 0 qty_1, 0 sale_price_1, 0 cost_price_1, 0 qty_2, 0 sale_price_2, 0 cost_price_2, nvl(sum(d.qty), 0) / 1000 qty_3, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_3,   " +
            "round(max(s.this_upricebal), 2) cost_price_3 " +
            "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
            "where a.tr_date between '" + p_year + "0901 + ' and to_char(last_day(to_date('" + p_year + "0901', 'YYYYMMDD')), 'YYYYMMDD')  " +
            "and a.del_if = 0  " +
            "and a.tr_status in ('2', '0')  " +
            "and a.pk = d.tac_crca_pk  " +
            "and d.del_if = 0  " +
            "and d.tco_item_pk = i.pk  " +
            "and s.std_ym = '" + p_year + "09'  " +
            "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
            "group by s.sizea " +
            ") t " +
            "group by t.sizea ";
    dt = ESysLib.TableReadOpen(SQL);
    v_tot_qty = 0; v_tot_qty_1 = 0; v_tot_qty_2 = 0;
    v_cost_amt = 0;  v_cost_amt_1 = 0; v_cost_amt_2 = 0;
    v_sale_amt = 0;  v_sale_amt_1 = 0; v_sale_amt_2 = 0;
    v_tot_profit = 0; v_tot_profit_1 = 0; v_tot_profit_2 = 0; 
    for(i = 0; i < dt.Rows.Count; i ++)
    {        
      v_profit = (decimal.Parse(dt.Rows[i][2].ToString()) - decimal.Parse(dt.Rows[i][3].ToString())) * decimal.Parse(dt.Rows[i][1].ToString()) ;
         v_profit = Math.Round(v_profit);
         v_profit_1 = (decimal.Parse(dt.Rows[i][5].ToString()) - decimal.Parse(dt.Rows[i][6].ToString())) * decimal.Parse(dt.Rows[i][4].ToString()) ;
         v_profit_1 = Math.Round(v_profit_1);
         v_profit_2 = ( decimal.Parse(dt.Rows[i][8].ToString()) - decimal.Parse(dt.Rows[i][9].ToString())) * decimal.Parse(dt.Rows[i][7].ToString()) ;
         v_profit_2 = Math.Round(v_profit_2); 
         v_tot_qty += decimal.Parse(dt.Rows[i][1].ToString());
         v_tot_qty_1 += decimal.Parse(dt.Rows[i][4].ToString());        
         v_tot_qty_2 += decimal.Parse(dt.Rows[i][7].ToString()) ;
         v_cost_amt += decimal.Parse(dt.Rows[i][1].ToString()) * decimal.Parse(dt.Rows[i][3].ToString()); // Cost Amount
         v_cost_amt_1 += decimal.Parse(dt.Rows[i][4].ToString()) * decimal.Parse(dt.Rows[i][6].ToString()); // Cost Amount
         v_cost_amt_2 += decimal.Parse(dt.Rows[i][7].ToString()) * decimal.Parse(dt.Rows[i][9].ToString()); // Cost Amount
         v_sale_amt += decimal.Parse(dt.Rows[i][1].ToString()) * decimal.Parse(dt.Rows[i][2].ToString()); // Sale Amount
         v_sale_amt_1 += decimal.Parse(dt.Rows[i][4].ToString()) * decimal.Parse(dt.Rows[i][5].ToString()); // Sale Amount
         v_sale_amt_2 += decimal.Parse(dt.Rows[i][7].ToString()) * decimal.Parse(dt.Rows[i][8].ToString()); // Sale Amount
        v_tot_profit += v_profit;
         v_tot_profit_1 += v_profit_1;
         v_tot_profit_2 += v_profit_2 ;        
    if(dt.Rows[i][0].ToString() == "#0")
    {              
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#0</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
 </tr>
 <%} 
    else if(dt.Rows[i][0].ToString() == "#00")
    {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#00</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
 <% 
    }
    else if(dt.Rows[0][0].ToString() == "#0E")
    {            
 %>  
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'>#0E</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
  <% 
    }
    else if(dt.Rows[i][0].ToString() == "#1")
    {
        %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>#1</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
  <% 
    }
    else if(dt.Rows[i][0].ToString() == "#2")
    {
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#2</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td> 
  </tr>
 <tr height=17 style='height:12.75pt'>
 <%
    }
    else if(dt.Rows[i][0].ToString() == "#3")
    {
 %>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#3</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %> </td>
 </tr>
 <% 
    }
    else if(dt.Rows[i][0].ToString() == "#4")
    { 
 %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl26 style='height:13.5pt;border-top:none'>#4</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %> </td> 
  </tr>
  <% }    
    }
     v_cost_price_avg = Math.Round(v_cost_amt / v_tot_qty, 2) ;     
     v_cost_price_avg_1 = Math.Round(v_cost_amt_1 / v_tot_qty_1, 2) ;     
     v_cost_price_avg_2 = Math.Round(v_cost_amt_2 / v_tot_qty_2, 2) ;    
     v_sale_price_avg = Math.Round( v_sale_amt / v_tot_qty, 2);
     v_sale_price_avg_1 = Math.Round( v_sale_amt_1 / v_tot_qty_1, 2);
     v_sale_price_avg_2 = Math.Round( v_sale_amt_2 / v_tot_qty_2, 2);    
  %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl32 style='height:13.5pt'>&nbsp;</td>
  <td class=xl33 align=right style='border-left:none' x:num><%=v_tot_qty %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_average %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_sale_price_avg %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_tot_profit %></td>
  <td class=xl33 align=right style='border-left:none' x:num><%=v_tot_qty_1 %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_avg_1 %> </td>
  <td class=xl34 style='border-left:none'><%=v_sale_price_avg_1 %></td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%=v_tot_profit_1 %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl33 style='border-left:none'><%=v_tot_qty_2 %></td>
  <td class=xl34 style='border-left:none'><%=v_cost_price_avg_2 %></td>
  <td class=xl34 style='border-left:none'><%=v_sale_price_avg_2 %></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%=v_tot_profit_2 %><span
  style='mso-spacerun:yes'>   </span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td colspan=12 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl36 style='height:12.75pt'>EXPORT</td>
  <td colspan=12 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl38 style='border-bottom:.5pt solid black;
  height:25.5pt'>SIZE</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>JUL</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>AUG</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>SEP</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl37 style='height:12.75pt;border-top:none;border-left:
  none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
 </tr>
 <% 
 SQL
	= "select t.sizea, nvl(sum(t.qty_1), 0) qty_1, max(t.sale_price_1) sale_price_1, max(t.cost_price_1) cost_price_1, sum(t.qty_2) qty_2, max(t.sale_price_2) sale_price_2, max(t.cost_price_2) cost_price_2, " + 
        "    sum(t.qty_3) qty_3, max(t.sale_price_3) sale_price_3, max(t.cost_price_3) cost_price_3 " +
        "from ( " +
        "select s.sizea, nvl(sum(d.qty), 0) / 1000 qty_1, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_1,   " +
        "round(max(s.this_upricebal), 2) cost_price_1, 0 qty_2, 0 sale_price_2, 0 cost_price_2, 0 qty_3, 0 sale_price_3, 0 cost_price_3  " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "0701' and to_char(last_day(to_date('" + p_year + "0701', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +
        "and a.tr_type = 'OS' " +
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "07'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        "union all " +
        "select s.sizea, 0 qty_1, 0 sale_price_1, 0 cost_price_1, nvl(sum(d.qty), 0) / 1000 qty_2, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_2,   " +
        "round(max(s.this_upricebal), 2) cost_price_2, 0 qty_3, 0 sale_price_3, 0 cost_price_3 " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "0801' and to_char(last_day(to_date('" + p_year + "0801', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +
        "and a.tr_type = 'OS' " +
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "08'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        "union all " +
        "select s.sizea, 0 qty_1, 0 sale_price_1, 0 cost_price_1, 0 qty_2, 0 sale_price_2, 0 cost_price_2, nvl(sum(d.qty), 0) / 1000 qty_3, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_3,   " +
        "round(max(s.this_upricebal), 2) cost_price_3 " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "0901 + ' and to_char(last_day(to_date('" + p_year + "0901', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +
        "and a.tr_type = 'OS' " +
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "09'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        ") t " +
        "group by t.sizea " ;
     dt = ESysLib.TableReadOpen(SQL);
      
    v_tot_qty = 0; v_tot_qty_1 = 0; v_tot_qty_2 = 0;
    v_cost_amt = 0;  v_cost_amt_1 = 0; v_cost_amt_2 = 0;
    v_sale_amt = 0;  v_sale_amt_1 = 0; v_sale_amt_2 = 0;
    v_tot_profit = 0; v_tot_profit_1 = 0; v_tot_profit_2 = 0; 
     for(i = 0 ; i < dt.Rows.Count; i++)
     {
       v_profit = (decimal.Parse(dt.Rows[i][2].ToString()) - decimal.Parse(dt.Rows[i][3].ToString())) * decimal.Parse(dt.Rows[i][1].ToString()) ;
         v_profit = Math.Round(v_profit);
         v_profit_1 = (decimal.Parse(dt.Rows[i][5].ToString()) - decimal.Parse(dt.Rows[i][6].ToString())) * decimal.Parse(dt.Rows[i][4].ToString()) ;
         v_profit_1 = Math.Round(v_profit_1);
         v_profit_2 = ( decimal.Parse(dt.Rows[i][8].ToString()) - decimal.Parse(dt.Rows[i][9].ToString())) * decimal.Parse(dt.Rows[i][7].ToString()) ;
         v_profit_2 = Math.Round(v_profit_2); 
         v_tot_qty += decimal.Parse(dt.Rows[i][1].ToString());
         v_tot_qty_1 += decimal.Parse(dt.Rows[i][4].ToString());        
         v_tot_qty_2 += decimal.Parse(dt.Rows[i][7].ToString()) ;
         v_cost_amt += decimal.Parse(dt.Rows[i][1].ToString()) * decimal.Parse(dt.Rows[i][3].ToString()); // Cost Amount
         v_cost_amt_1 += decimal.Parse(dt.Rows[i][4].ToString()) * decimal.Parse(dt.Rows[i][6].ToString()); // Cost Amount
         v_cost_amt_2 += decimal.Parse(dt.Rows[i][7].ToString()) * decimal.Parse(dt.Rows[i][9].ToString()); // Cost Amount
         v_sale_amt += decimal.Parse(dt.Rows[i][1].ToString()) * decimal.Parse(dt.Rows[i][2].ToString()); // Sale Amount
         v_sale_amt_1 += decimal.Parse(dt.Rows[i][4].ToString()) * decimal.Parse(dt.Rows[i][5].ToString()); // Sale Amount
         v_sale_amt_2 += decimal.Parse(dt.Rows[i][7].ToString()) * decimal.Parse(dt.Rows[i][8].ToString()); // Sale Amount
        v_tot_profit += v_profit;
         v_tot_profit_1 += v_profit_1;
         v_tot_profit_2 += v_profit_2 ;      
 %>
 <% 
    if(dt.Rows[i][0].ToString() =="#0")
    {            
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#0</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
 </tr>
 <%} 
    else if(dt.Rows[i][0].ToString() == "#00")
    {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#00</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
 <% 
    }
    else if(dt.Rows[0][0].ToString() == "#0E")
    {            
 %>  
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'>#0E</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
  <% 
    }
    else if(dt.Rows[i][0].ToString() == "#1")
    {
        %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>#1</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
  <% 
    }
    else if(dt.Rows[i][0].ToString() == "#2")
    {
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#2</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td> 
  </tr>
 <tr height=17 style='height:12.75pt'>
 <%
    }
    else if(dt.Rows[i][0].ToString() == "#3")
    {
 %>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#3</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %> </td>
 </tr>
 <% 
    }
    else if(dt.Rows[i][0].ToString() == "#4")
    { 
 %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl26 style='height:13.5pt;border-top:none'>#4</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %> </td> 
  </tr>
  <% }
    
    }
  %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl32 style='height:13.5pt'>&nbsp;</td>
  <td class=xl33 align=right style='border-left:none' x:num><%=v_tot_qty %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_average %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_sale_price_avg %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_tot_profit %></td>
  <td class=xl33 align=right style='border-left:none' x:num><%=v_tot_qty_1 %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_avg_1 %> </td>
  <td class=xl34 style='border-left:none'><%=v_sale_price_avg_1 %></td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%=v_tot_profit_1 %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl33 style='border-left:none'><%=v_tot_qty_2 %></td>
  <td class=xl34 style='border-left:none'><%=v_cost_price_avg_2 %></td>
  <td class=xl34 style='border-left:none'><%=v_sale_price_avg_2 %></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%=v_tot_profit_2 %><span
  style='mso-spacerun:yes'>   </span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl36 colspan=2 style='height:12.75pt;mso-ignore:colspan'>DOMESTIC</td>
  <td colspan=11 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl38 style='border-bottom:.5pt solid black;
  height:25.5pt'>SIZE</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>JUL</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>AUG</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>SEP</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl37 style='height:12.75pt;border-top:none;border-left:
  none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
 </tr>
 <% 
 SQL
	= "select t.sizea, nvl(sum(t.qty_1), 0) qty_1, max(t.sale_price_1) sale_price_1, max(t.cost_price_1) cost_price_1, sum(t.qty_2) qty_2, max(t.sale_price_2) sale_price_2, max(t.cost_price_2) cost_price_2, " + 
        "    sum(t.qty_3) qty_3, max(t.sale_price_3) sale_price_3, max(t.cost_price_3) cost_price_3 " +
        "from ( " +
        "select s.sizea, nvl(sum(d.qty), 0) / 1000 qty_1, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_1,   " +
        "round(max(s.this_upricebal), 2) cost_price_1, 0 qty_2, 0 sale_price_2, 0 cost_price_2, 0 qty_3, 0 sale_price_3, 0 cost_price_3  " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "0701' and to_char(last_day(to_date('" + p_year + "0701', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +
        "and a.tr_type = 'DO' " +
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "07'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        "union all " +
        "select s.sizea, 0 qty_1, 0 sale_price_1, 0 cost_price_1, nvl(sum(d.qty), 0) / 1000 qty_2, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_2,   " +
        "round(max(s.this_upricebal), 2) cost_price_2, 0 qty_3, 0 sale_price_3, 0 cost_price_3 " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "0801' and to_char(last_day(to_date('" + p_year + "0801', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +
        "and a.tr_type = 'DO' " +
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "08'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        "union all " +
        "select s.sizea, 0 qty_1, 0 sale_price_1, 0 cost_price_1, 0 qty_2, 0 sale_price_2, 0 cost_price_2, nvl(sum(d.qty), 0) / 1000 qty_3, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_3,   " +
        "round(max(s.this_upricebal), 2) cost_price_3 " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "0901 + ' and to_char(last_day(to_date('" + p_year + "0901', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +
        "and a.tr_type = 'DO' " +
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "09'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        ") t " +
        "group by t.sizea " ;
     dt = ESysLib.TableReadOpen(SQL);
      
    v_tot_qty = 0; v_tot_qty_1 = 0; v_tot_qty_2 = 0;
    v_cost_amt = 0;  v_cost_amt_1 = 0; v_cost_amt_2 = 0;
    v_sale_amt = 0;  v_sale_amt_1 = 0; v_sale_amt_2 = 0;
    v_tot_profit = 0; v_tot_profit_1 = 0; v_tot_profit_2 = 0; 
     for(i = 0 ; i < dt.Rows.Count; i++)
     {
       v_profit = (decimal.Parse(dt.Rows[i][2].ToString()) - decimal.Parse(dt.Rows[i][3].ToString())) * decimal.Parse(dt.Rows[i][1].ToString()) ;
         v_profit = Math.Round(v_profit);
         v_profit_1 = (decimal.Parse(dt.Rows[i][5].ToString()) - decimal.Parse(dt.Rows[i][6].ToString())) * decimal.Parse(dt.Rows[i][4].ToString()) ;
         v_profit_1 = Math.Round(v_profit_1);
         v_profit_2 = ( decimal.Parse(dt.Rows[i][8].ToString()) - decimal.Parse(dt.Rows[i][9].ToString())) * decimal.Parse(dt.Rows[i][7].ToString()) ;
         v_profit_2 = Math.Round(v_profit_2); 
         v_tot_qty += decimal.Parse(dt.Rows[i][1].ToString());
         v_tot_qty_1 += decimal.Parse(dt.Rows[i][4].ToString());        
         v_tot_qty_2 += decimal.Parse(dt.Rows[i][7].ToString()) ;
         v_cost_amt += decimal.Parse(dt.Rows[i][1].ToString()) * decimal.Parse(dt.Rows[i][3].ToString()); // Cost Amount
         v_cost_amt_1 += decimal.Parse(dt.Rows[i][4].ToString()) * decimal.Parse(dt.Rows[i][6].ToString()); // Cost Amount
         v_cost_amt_2 += decimal.Parse(dt.Rows[i][7].ToString()) * decimal.Parse(dt.Rows[i][9].ToString()); // Cost Amount
         v_sale_amt += decimal.Parse(dt.Rows[i][1].ToString()) * decimal.Parse(dt.Rows[i][2].ToString()); // Sale Amount
         v_sale_amt_1 += decimal.Parse(dt.Rows[i][4].ToString()) * decimal.Parse(dt.Rows[i][5].ToString()); // Sale Amount
         v_sale_amt_2 += decimal.Parse(dt.Rows[i][7].ToString()) * decimal.Parse(dt.Rows[i][8].ToString()); // Sale Amount
        v_tot_profit += v_profit;
         v_tot_profit_1 += v_profit_1;
         v_tot_profit_2 += v_profit_2 ;      
 %>
 <% 
    if(dt.Rows[i][0].ToString() =="#0")
    {            
 %> 
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#0</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
 </tr>
 <%} 
    else if(dt.Rows[i][0].ToString() == "#00")
    {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#00</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
 <% 
    }
    else if(dt.Rows[0][0].ToString() == "#0E")
    {            
 %>  
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'>#0E</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
  <% 
    }
    else if(dt.Rows[i][0].ToString() == "#1")
    {
        %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>#1</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
  <% 
    }
    else if(dt.Rows[i][0].ToString() == "#2")
    {
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#2</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td> 
  </tr>
 <tr height=17 style='height:12.75pt'>
 <%
    }
    else if(dt.Rows[i][0].ToString() == "#3")
    {
 %>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#3</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %> </td>
 </tr>
 <% 
    }
    else if(dt.Rows[i][0].ToString() == "#4")
    { 
 %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl26 style='height:13.5pt;border-top:none'>#4</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %> </td> 
  </tr>
  <% }    
    }
     v_cost_price_avg = Math.Round(v_cost_amt / v_tot_qty, 2) ;     
     v_cost_price_avg_1 = Math.Round(v_cost_amt_1 / v_tot_qty_1, 2) ;     
     v_cost_price_avg_2 = Math.Round(v_cost_amt_2 / v_tot_qty_2, 2) ;    
     v_sale_price_avg = Math.Round( v_sale_amt / v_tot_qty, 2);
     v_sale_price_avg_1 = Math.Round( v_sale_amt_1 / v_tot_qty_1, 2);
     v_sale_price_avg_2 = Math.Round( v_sale_amt_2 / v_tot_qty_2, 2);
    
  %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl32 style='height:13.5pt'>&nbsp;</td>
  <td class=xl33 align=right style='border-left:none' x:num><%=v_tot_qty %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_average %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_sale_price_avg %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_tot_profit %></td>
  <td class=xl33 align=right style='border-left:none' x:num><%=v_tot_qty_1 %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_avg_1 %> </td>
  <td class=xl34 style='border-left:none'><%=v_sale_price_avg_1 %></td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%=v_tot_profit_1 %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl33 style='border-left:none'><%=v_tot_qty_2 %></td>
  <td class=xl34 style='border-left:none'><%=v_cost_price_avg_2 %></td>
  <td class=xl34 style='border-left:none'><%=v_sale_price_avg_2 %></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%=v_tot_profit_2 %><span
  style='mso-spacerun:yes'>   </span></td>
 </tr>
 <tr height=51 style='height:38.25pt;mso-xlrowspan:3'>
  <td height=51 colspan=13 style='height:38.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl24 colspan=4 style='height:14.25pt;mso-ignore:colspan'>#
  . <%=p_year %> MONTHLY UNIT PROFIT</td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl24 style='height:14.25pt'></td>
  <td colspan=12 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl36 style='height:12.75pt'>TOTAL</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'>(Unit: 1000pcs, 1000VND)</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl38 style='border-bottom:.5pt solid black;
  height:25.5pt'>SIZE</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>OCT</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>NOV</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>DEC</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl37 style='height:12.75pt;border-top:none;border-left:
  none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
 </tr>
  <% 
 SQL
	= "select t.sizea, nvl(sum(t.qty_1), 0) qty_1, max(t.sale_price_1) sale_price_1, max(t.cost_price_1) cost_price_1, sum(t.qty_2) qty_2, max(t.sale_price_2) sale_price_2, max(t.cost_price_2) cost_price_2, " + 
        "    sum(t.qty_3) qty_3, max(t.sale_price_3) sale_price_3, max(t.cost_price_3) cost_price_3 " +
        "from ( " +
        "select s.sizea, nvl(sum(d.qty), 0) / 1000 qty_1, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_1,   " +
        "round(max(s.this_upricebal), 2) cost_price_1, 0 qty_2, 0 sale_price_2, 0 cost_price_2, 0 qty_3, 0 sale_price_3, 0 cost_price_3  " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "1001' and to_char(last_day(to_date('" + p_year + "1001', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +        
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "10'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        "union all " +
        "select s.sizea, 0 qty_1, 0 sale_price_1, 0 cost_price_1, nvl(sum(d.qty), 0) / 1000 qty_2, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_2,   " +
        "round(max(s.this_upricebal), 2) cost_price_2, 0 qty_3, 0 sale_price_3, 0 cost_price_3 " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "1101' and to_char(last_day(to_date('" + p_year + "1101', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +        
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "11'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        "union all " +
        "select s.sizea, 0 qty_1, 0 sale_price_1, 0 cost_price_1, 0 qty_2, 0 sale_price_2, 0 cost_price_2, nvl(sum(d.qty), 0) / 1000 qty_3, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_3,   " +
        "round(max(s.this_upricebal), 2) cost_price_3 " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "1201 + ' and to_char(last_day(to_date('" + p_year + "1201', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +        
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "12'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        ") t " +
        "group by t.sizea " ;
     dt = ESysLib.TableReadOpen(SQL);
      
    v_tot_qty = 0; v_tot_qty_1 = 0; v_tot_qty_2 = 0;
    v_cost_amt = 0;  v_cost_amt_1 = 0; v_cost_amt_2 = 0;
    v_sale_amt = 0;  v_sale_amt_1 = 0; v_sale_amt_2 = 0;
    v_tot_profit = 0; v_tot_profit_1 = 0; v_tot_profit_2 = 0; 
     for(i = 0 ; i < dt.Rows.Count; i++)
     {
       v_profit = (decimal.Parse(dt.Rows[i][2].ToString()) - decimal.Parse(dt.Rows[i][3].ToString())) * decimal.Parse(dt.Rows[i][1].ToString()) ;
         v_profit = Math.Round(v_profit);
         v_profit_1 = (decimal.Parse(dt.Rows[i][5].ToString()) - decimal.Parse(dt.Rows[i][6].ToString())) * decimal.Parse(dt.Rows[i][4].ToString()) ;
         v_profit_1 = Math.Round(v_profit_1);
         v_profit_2 = ( decimal.Parse(dt.Rows[i][8].ToString()) - decimal.Parse(dt.Rows[i][9].ToString())) * decimal.Parse(dt.Rows[i][7].ToString()) ;
         v_profit_2 = Math.Round(v_profit_2); 
         v_tot_qty += decimal.Parse(dt.Rows[i][1].ToString());
         v_tot_qty_1 += decimal.Parse(dt.Rows[i][4].ToString());        
         v_tot_qty_2 += decimal.Parse(dt.Rows[i][7].ToString()) ;
         v_cost_amt += decimal.Parse(dt.Rows[i][1].ToString()) * decimal.Parse(dt.Rows[i][3].ToString()); // Cost Amount
         v_cost_amt_1 += decimal.Parse(dt.Rows[i][4].ToString()) * decimal.Parse(dt.Rows[i][6].ToString()); // Cost Amount
         v_cost_amt_2 += decimal.Parse(dt.Rows[i][7].ToString()) * decimal.Parse(dt.Rows[i][9].ToString()); // Cost Amount
         v_sale_amt += decimal.Parse(dt.Rows[i][1].ToString()) * decimal.Parse(dt.Rows[i][2].ToString()); // Sale Amount
         v_sale_amt_1 += decimal.Parse(dt.Rows[i][4].ToString()) * decimal.Parse(dt.Rows[i][5].ToString()); // Sale Amount
         v_sale_amt_2 += decimal.Parse(dt.Rows[i][7].ToString()) * decimal.Parse(dt.Rows[i][8].ToString()); // Sale Amount
        v_tot_profit += v_profit;
         v_tot_profit_1 += v_profit_1;
         v_tot_profit_2 += v_profit_2 ;      
 %>
 <% 
    if(dt.Rows[i][0].ToString() =="#0")
    {            
 %> 
 
 
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#0</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
 </tr>
 <%} 
    else if(dt.Rows[i][0].ToString() == "#00")
    {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#00</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
 <% 
    }
    else if(dt.Rows[0][0].ToString() == "#0E")
    {            
 %>  
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'>#0E</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
  <% 
    }
    else if(dt.Rows[i][0].ToString() == "#1")
    {
        %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>#1</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
  <% 
    }
    else if(dt.Rows[i][0].ToString() == "#2")
    {
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#2</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td> 
  </tr>
 <tr height=17 style='height:12.75pt'>
 <%
    }
    else if(dt.Rows[i][0].ToString() == "#3")
    {
 %>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#3</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %> </td>
 </tr>
 <% 
    }
    else if(dt.Rows[i][0].ToString() == "#4")
    { 
 %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl26 style='height:13.5pt;border-top:none'>#4</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %> </td> 
  </tr>
  <% }    
    }
     v_cost_price_avg = Math.Round(v_cost_amt / v_tot_qty, 2) ;     
     v_cost_price_avg_1 = Math.Round(v_cost_amt_1 / v_tot_qty_1, 2) ;     
     v_cost_price_avg_2 = Math.Round(v_cost_amt_2 / v_tot_qty_2, 2) ;    
     v_sale_price_avg = Math.Round( v_sale_amt / v_tot_qty, 2);
     v_sale_price_avg_1 = Math.Round( v_sale_amt_1 / v_tot_qty_1, 2);
     v_sale_price_avg_2 = Math.Round( v_sale_amt_2 / v_tot_qty_2, 2);
    
  %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl32 style='height:13.5pt'>&nbsp;</td>
  <td class=xl33 align=right style='border-left:none' x:num><%=v_tot_qty %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_average %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_sale_price_avg %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_tot_profit %></td>
  <td class=xl33 align=right style='border-left:none' x:num><%=v_tot_qty_1 %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_avg_1 %> </td>
  <td class=xl34 style='border-left:none'><%=v_sale_price_avg_1 %></td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%=v_tot_profit_1 %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl33 style='border-left:none'><%=v_tot_qty_2 %></td>
  <td class=xl34 style='border-left:none'><%=v_cost_price_avg_2 %></td>
  <td class=xl34 style='border-left:none'><%=v_sale_price_avg_2 %></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%=v_tot_profit_2 %><span
  style='mso-spacerun:yes'>   </span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td colspan=12 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl36 style='height:12.75pt'>EXPORT</td>
  <td colspan=12 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl38 style='border-bottom:.5pt solid black;
  height:25.5pt'>SIZE</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>OCT</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>NOV</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>DEC</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl37 style='height:12.75pt;border-top:none;border-left:
  none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
 </tr>
  <% 
 SQL
	= "select t.sizea, nvl(sum(t.qty_1), 0) qty_1, max(t.sale_price_1) sale_price_1, max(t.cost_price_1) cost_price_1, sum(t.qty_2) qty_2, max(t.sale_price_2) sale_price_2, max(t.cost_price_2) cost_price_2, " + 
        "    sum(t.qty_3) qty_3, max(t.sale_price_3) sale_price_3, max(t.cost_price_3) cost_price_3 " +
        "from ( " +
        "select s.sizea, nvl(sum(d.qty), 0) / 1000 qty_1, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_1,   " +
        "round(max(s.this_upricebal), 2) cost_price_1, 0 qty_2, 0 sale_price_2, 0 cost_price_2, 0 qty_3, 0 sale_price_3, 0 cost_price_3  " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "1001' and to_char(last_day(to_date('" + p_year + "1001', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +  
        " and a.tr_type = 'OS' " +      
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "10'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        "union all " +
        "select s.sizea, 0 qty_1, 0 sale_price_1, 0 cost_price_1, nvl(sum(d.qty), 0) / 1000 qty_2, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_2,   " +
        "round(max(s.this_upricebal), 2) cost_price_2, 0 qty_3, 0 sale_price_3, 0 cost_price_3 " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "1101' and to_char(last_day(to_date('" + p_year + "1101', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " + 
        " and a.tr_type = 'OS' " +       
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "11'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        "union all " +
        "select s.sizea, 0 qty_1, 0 sale_price_1, 0 cost_price_1, 0 qty_2, 0 sale_price_2, 0 cost_price_2, nvl(sum(d.qty), 0) / 1000 qty_3, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_3,   " +
        "round(max(s.this_upricebal), 2) cost_price_3 " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "1201 + ' and to_char(last_day(to_date('" + p_year + "1201', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +   
        " and a.tr_type = 'OS' " +     
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "12'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        ") t " +
        "group by t.sizea " ;
     dt = ESysLib.TableReadOpen(SQL);
      
    v_tot_qty = 0; v_tot_qty_1 = 0; v_tot_qty_2 = 0;
    v_cost_amt = 0;  v_cost_amt_1 = 0; v_cost_amt_2 = 0;
    v_sale_amt = 0;  v_sale_amt_1 = 0; v_sale_amt_2 = 0;
    v_tot_profit = 0; v_tot_profit_1 = 0; v_tot_profit_2 = 0; 
     for(i = 0 ; i < dt.Rows.Count; i++)
       v_profit = (decimal.Parse(dt.Rows[i][2].ToString()) - decimal.Parse(dt.Rows[i][3].ToString())) * decimal.Parse(dt.Rows[i][1].ToString()) ;
         v_profit = Math.Round(v_profit);
         v_profit_1 = (decimal.Parse(dt.Rows[i][5].ToString()) - decimal.Parse(dt.Rows[i][6].ToString())) * decimal.Parse(dt.Rows[i][4].ToString()) ;
         v_profit_1 = Math.Round(v_profit_1);
         v_profit_2 = ( decimal.Parse(dt.Rows[i][8].ToString()) - decimal.Parse(dt.Rows[i][9].ToString())) * decimal.Parse(dt.Rows[i][7].ToString()) ;
         v_profit_2 = Math.Round(v_profit_2); 
         v_tot_qty += decimal.Parse(dt.Rows[i][1].ToString());
         v_tot_qty_1 += decimal.Parse(dt.Rows[i][4].ToString());        
         v_tot_qty_2 += decimal.Parse(dt.Rows[i][7].ToString()) ;
         v_cost_amt += decimal.Parse(dt.Rows[i][1].ToString()) * decimal.Parse(dt.Rows[i][3].ToString()); // Cost Amount
         v_cost_amt_1 += decimal.Parse(dt.Rows[i][4].ToString()) * decimal.Parse(dt.Rows[i][6].ToString()); // Cost Amount
         v_cost_amt_2 += decimal.Parse(dt.Rows[i][7].ToString()) * decimal.Parse(dt.Rows[i][9].ToString()); // Cost Amount
         v_sale_amt += decimal.Parse(dt.Rows[i][1].ToString()) * decimal.Parse(dt.Rows[i][2].ToString()); // Sale Amount
         v_sale_amt_1 += decimal.Parse(dt.Rows[i][4].ToString()) * decimal.Parse(dt.Rows[i][5].ToString()); // Sale Amount
         v_sale_amt_2 += decimal.Parse(dt.Rows[i][7].ToString()) * decimal.Parse(dt.Rows[i][8].ToString()); // Sale Amount
        v_tot_profit += v_profit;
         v_tot_profit_1 += v_profit_1;
         v_tot_profit_2 += v_profit_2 ;      
 %>
 <% 
    if(dt.Rows[i][0].ToString() =="#0")
    {            
 %>  
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#0</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
 </tr>
 <%} 
    else if(dt.Rows[i][0].ToString() == "#00")
    {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#00</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
 <% 
    }
    else if(dt.Rows[0][0].ToString() == "#0E")
    {            
 %>  
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'>#0E</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
  <% 
    }
    else if(dt.Rows[i][0].ToString() == "#1")
    {
        %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>#1</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
  <% 
    }
    else if(dt.Rows[i][0].ToString() == "#2")
    {
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#2</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td> 
  </tr>
 <tr height=17 style='height:12.75pt'>
 <%
    }
    else if(dt.Rows[i][0].ToString() == "#3")
    {
 %>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#3</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %> </td>
 </tr>
 <% 
    }
    else if(dt.Rows[i][0].ToString() == "#4")
    { 
 %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl26 style='height:13.5pt;border-top:none'>#4</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %> </td> 
  </tr>
  <% }    
    }
     v_cost_price_avg = Math.Round((v_cost_amt v_tot_qty), 2) ;     
     v_cost_price_avg_1 = Math.Round(v_cost_amt_1 / v_tot_qty_1, 2) ;     
     v_cost_price_avg_2 = Math.Round(v_cost_amt_2 / v_tot_qty_2, 2) ;    
     v_sale_price_avg = Math.Round( v_sale_amt / v_tot_qty, 2);
     v_sale_price_avg_1 = Math.Round( v_sale_amt_1 / v_tot_qty_1, 2);
     v_sale_price_avg_2 = Math.Round( v_sale_amt_2 / v_tot_qty_2, 2);
    
  %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl32 style='height:13.5pt'>&nbsp;</td>
  <td class=xl33 align=right style='border-left:none' x:num><%=v_tot_qty %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_average %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_sale_price_avg %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_tot_profit %></td>
  <td class=xl33 align=right style='border-left:none' x:num><%=v_tot_qty_1 %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_avg_1 %> </td>
  <td class=xl34 style='border-left:none'><%=v_sale_price_avg_1 %></td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%=v_tot_profit_1 %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl33 style='border-left:none'><%=v_tot_qty_2 %></td>
  <td class=xl34 style='border-left:none'><%=v_cost_price_avg_2 %></td>
  <td class=xl34 style='border-left:none'><%=v_sale_price_avg_2 %></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%=v_tot_profit_2 %><span
  style='mso-spacerun:yes'>   </span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl36 colspan=2 style='height:12.75pt;mso-ignore:colspan'>DOMESTIC</td>
  <td colspan=11 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl38 style='border-bottom:.5pt solid black;
  height:25.5pt'>SIZE</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>OCT</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>NOV</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>DEC</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl37 style='height:12.75pt;border-top:none;border-left:
  none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Quant.</td>
  <td class=xl37 style='border-top:none;border-left:none'>Cost Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Sales Price</td>
  <td class=xl37 style='border-top:none;border-left:none'>Profit</td>
 </tr>
   <% 
 SQL
	= "select t.sizea, nvl(sum(t.qty_1), 0) qty_1, max(t.sale_price_1) sale_price_1, max(t.cost_price_1) cost_price_1, sum(t.qty_2) qty_2, max(t.sale_price_2) sale_price_2, max(t.cost_price_2) cost_price_2, " + 
        "    sum(t.qty_3) qty_3, max(t.sale_price_3) sale_price_3, max(t.cost_price_3) cost_price_3 " +
        "from ( " +
        "select s.sizea, nvl(sum(d.qty), 0) / 1000 qty_1, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_1,   " +
        "round(max(s.this_upricebal), 2) cost_price_1, 0 qty_2, 0 sale_price_2, 0 cost_price_2, 0 qty_3, 0 sale_price_3, 0 cost_price_3  " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "1001' and to_char(last_day(to_date('" + p_year + "1001', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +  
        " and a.tr_type = 'DO' " +      
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "10'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        "union all " +
        "select s.sizea, 0 qty_1, 0 sale_price_1, 0 cost_price_1, nvl(sum(d.qty), 0) / 1000 qty_2, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_2,   " +
        "round(max(s.this_upricebal), 2) cost_price_2, 0 qty_3, 0 sale_price_3, 0 cost_price_3 " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "1101' and to_char(last_day(to_date('" + p_year + "1101', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " + 
        " and a.tr_type = 'DO' " +       
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "11'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        "union all " +
        "select s.sizea, 0 qty_1, 0 sale_price_1, 0 cost_price_1, 0 qty_2, 0 sale_price_2, 0 cost_price_2, nvl(sum(d.qty), 0) / 1000 qty_3, round(sum(d.net_bk_amt) / nvl(sum(d.qty), 0), 2) sale_price_3,   " +
        "round(max(s.this_upricebal), 2) cost_price_3 " +
        "from tac_crcad d, tac_crca a, comm.tco_item i, tac_allocate_costfg_store s  " +
        "where a.tr_date between '" + p_year + "1201 + ' and to_char(last_day(to_date('" + p_year + "1201', 'YYYYMMDD')), 'YYYYMMDD')  " +
        "and a.del_if = 0  " +
        "and a.tr_status in ('2', '0')  " +   
        " and a.tr_type = 'DO' " +     
        "and a.pk = d.tac_crca_pk  " +
        "and d.del_if = 0  " +
        "and d.tco_item_pk = i.pk  " +
        "and s.std_ym = '" + p_year + "12'  " +
        "and i.tac_abacctcode_pk = s.tac_abacctcode_pk  " +
        "group by s.sizea " +
        ") t " +
        "group by t.sizea " ;
     dt = ESysLib.TableReadOpen(SQL);
      
    v_tot_qty = 0; v_tot_qty_1 = 0; v_tot_qty_2 = 0;
    v_cost_amt = 0;  v_cost_amt_1 = 0; v_cost_amt_2 = 0;
    v_sale_amt = 0;  v_sale_amt_1 = 0; v_sale_amt_2 = 0;
    v_tot_profit = 0; v_tot_profit_1 = 0; v_tot_profit_2 = 0; 
     for(i = 0 ; i < dt.Rows.Count; i++)
     {
       v_profit = (decimal.Parse(dt.Rows[i][2].ToString()) - decimal.Parse(dt.Rows[i][3].ToString())) * decimal.Parse(dt.Rows[i][1].ToString()) ;
         v_profit = Math.Round(v_profit, 0);
         v_profit_1 = (decimal.Parse(dt.Rows[i][5].ToString()) - decimal.Parse(dt.Rows[i][6].ToString())) * decimal.Parse(dt.Rows[i][4].ToString()) ;
         v_profit_1 = Math.Round(v_profit_1, 0);
         v_profit_2 = ( decimal.Parse(dt.Rows[i][8].ToString()) - decimal.Parse(dt.Rows[i][9].ToString())) * decimal.Parse(dt.Rows[i][7].ToString()) ;
         v_profit_2 = Math.Round(v_profit_2, 0); 
         v_tot_qty += decimal.Parse(dt.Rows[i][1].ToString());
         v_tot_qty_1 += decimal.Parse(dt.Rows[i][4].ToString());        
         v_tot_qty_2 += decimal.Parse(dt.Rows[i][7].ToString()) ;
         v_cost_amt += decimal.Parse(dt.Rows[i][1].ToString()) * decimal.Parse(dt.Rows[i][3].ToString()); // Cost Amount
         v_cost_amt_1 += decimal.Parse(dt.Rows[i][4].ToString()) * decimal.Parse(dt.Rows[i][6].ToString()); // Cost Amount
         v_cost_amt_2 += decimal.Parse(dt.Rows[i][7].ToString()) * decimal.Parse(dt.Rows[i][9].ToString()); // Cost Amount
         v_sale_amt += decimal.Parse(dt.Rows[i][1].ToString()) * decimal.Parse(dt.Rows[i][2].ToString()); // Sale Amount
         v_sale_amt_1 += decimal.Parse(dt.Rows[i][4].ToString()) * decimal.Parse(dt.Rows[i][5].ToString()); // Sale Amount
         v_sale_amt_2 += decimal.Parse(dt.Rows[i][7].ToString()) * decimal.Parse(dt.Rows[i][8].ToString()); // Sale Amount
        v_tot_profit += v_profit;
         v_tot_profit_1 += v_profit_1;
         v_tot_profit_2 += v_profit_2 ;      
 %>
 <% 
    if(dt.Rows[i][0].ToString() =="#0")
    {            
 %>  
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#0</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
 </tr>
 <%} 
    else if(dt.Rows[i][0].ToString() == "#00")
    {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#00</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
 <% 
    }
    else if(dt.Rows[0][0].ToString() == "#0E")
    {            
 %>  
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'>#0E</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
  <% 
    }
    else if(dt.Rows[i][0].ToString() == "#1")
    {
        %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>#1</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td>
  </tr>
  <% 
    }
    else if(dt.Rows[i][0].ToString() == "#2")
    {
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#2</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %></td> 
  </tr>
 <tr height=17 style='height:12.75pt'>
 <%
    }
    else if(dt.Rows[i][0].ToString() == "#3")
    {
 %>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>#3</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %> </td>
 </tr>
 <% 
    }
    else if(dt.Rows[i][0].ToString() == "#4")
    { 
 %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl26 style='height:13.5pt;border-top:none'>#4</td>
<td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit %></td> 
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5] %></td> <!-- Sales Price -->
  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7] %></td> <!-- Sales Q'ty -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9] %></td> <!-- Cost Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8] %></td> <!-- Sales Price -->
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=v_profit_2 %> </td> 
  </tr>
  <% }    
    }
     v_cost_price_avg = Math.Round(v_cost_amt / v_tot_qty, 2) ;     
     v_cost_price_avg_1 = Math.Round(v_cost_amt_1 / v_tot_qty_1, 2) ;     
     v_cost_price_avg_2 = Math.Round(v_cost_amt_2 / v_tot_qty_2, 2) ;    
     v_sale_price_avg = Math.Round( v_sale_amt / v_tot_qty, 2);
     v_sale_price_avg_1 = Math.Round( v_sale_amt_1 / v_tot_qty_1, 2);
     v_sale_price_avg_2 = Math.Round( v_sale_amt_2 / v_tot_qty_2, 2);
    
  %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl32 style='height:13.5pt'>&nbsp;</td>
  <td class=xl33 align=right style='border-left:none' x:num><%=v_tot_qty %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_average %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_sale_price_avg %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_tot_profit %></td>
  <td class=xl33 align=right style='border-left:none' x:num><%=v_tot_qty_1 %></td>
  <td class=xl34 style='border-left:none' x:num><%=v_cost_price_avg_1 %> </td>
  <td class=xl34 style='border-left:none'><%=v_sale_price_avg_1 %></td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%=v_tot_profit_1 %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl33 style='border-left:none'><%=v_tot_qty_2 %></td>
  <td class=xl34 style='border-left:none'><%=v_cost_price_avg_2 %></td>
  <td class=xl34 style='border-left:none'><%=v_sale_price_avg_2 %></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%=v_tot_profit_2 %><span
  style='mso-spacerun:yes'>   </span></td>
 </tr>

 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=60 style='width:45pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=93 style='width:70pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
