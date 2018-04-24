<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<% 
    string SQL = "";
    string v_comp_pk = "", v_comp_nm = "", v_comp_addr = ""; // company
    string v_month = "";
    string v_month_to = "";
    string v_ac_cd = "";
    string v_item_pk = "";
    string v_tac_abplcenter_pk = "";
    string v_wh_pk = "";
    string v_param = "";
    string v_from_date = "", v_to_date = ""; // từ ngày đến ngày
    int v_yeari = 0, v_monthi = 0;
    
    v_comp_pk = Request["comp_pk"];
    v_month = Request["month"];
    v_from_date = "01" + "/" + v_month.Substring(4, 2) + "/" + v_month.Substring(0, 4);
    v_yeari = int.Parse(v_month.Substring(0, 4));
    v_monthi = int.Parse(v_month.Substring(4, 2));
    v_to_date = DateTime.DaysInMonth(v_yeari, v_monthi).ToString() + "/" + v_month.Substring(4, 2) + "/" + v_month.Substring(0, 4);
    
    v_month_to = Request["month_to"];
    v_ac_cd = Request["ac_cd"];
    v_item_pk = Request["item_pk"];
    v_tac_abplcenter_pk = Request["abplcenter_pk"];
    v_wh_pk = Request["wh_pk"];
    v_param = "'" + v_comp_pk + "', '" + v_month + "', '" + v_month_to + "', '" + v_ac_cd + "', '" + v_item_pk + "', '" + v_tac_abplcenter_pk + "', '" + v_wh_pk + "'";
    DataTable dt = ESysLib.TableReadOpenCursor("SP_SEL_FMGF00440_1", v_param);
    SQL = "select partner_name, addr1  from comm.tco_buspartner where pk like '" + v_comp_pk + "' and del_if = 0 ";
    DataTable dtComp = new DataTable();
    dtComp = ESysLib.TableReadOpen(SQL);
    if (dtComp.Rows.Count > 0)
    {
        v_comp_nm = dtComp.Rows[0][0].ToString(); //company name
        v_comp_addr = dtComp.Rows[0][1].ToString(); //company address
    }
    
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Yearly%20Inventory%20Inquiry_files/filelist.xml">
<link rel=Edit-Time-Data href="Yearly%20Inventory%20Inquiry_files/editdata.mso">
<link rel=OLE-Object-Data href="Yearly%20Inventory%20Inquiry_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>van</o:Author>
  <o:LastAuthor>van</o:LastAuthor>
  <o:LastPrinted>2011-11-11T07:56:36Z</o:LastPrinted>
  <o:Created>2011-11-11T07:16:45Z</o:Created>
  <o:LastSaved>2011-11-11T07:56:39Z</o:LastSaved>
  <o:Company>Vina Genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in 0in .75in .25in;
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
	font-size:12.0pt;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	mso-number-format:Standard;
	text-align:right;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	text-align:right;
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	mso-number-format:Standard;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	border:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	border:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	border:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:16.0pt;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Yearly Inquiry</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>60</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9345</x:WindowHeight>
  <x:WindowWidth>11340</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1677 style='border-collapse:
 collapse;table-layout:fixed;width:1260pt'>
 <col width=159 style='mso-width-source:userset;mso-width-alt:5814;width:119pt'>
 <col width=101 style='mso-width-source:userset;mso-width-alt:3693;width:76pt'>
 <col width=165 style='mso-width-source:userset;mso-width-alt:6034;width:124pt'>
 <col width=59 style='mso-width-source:userset;mso-width-alt:2157;width:44pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=99 style='mso-width-source:userset;mso-width-alt:3620;width:74pt'>
 <col width=133 style='mso-width-source:userset;mso-width-alt:4864;width:100pt'>
 <col width=102 style='mso-width-source:userset;mso-width-alt:3730;width:77pt'>
 <col width=128 style='mso-width-source:userset;mso-width-alt:4681;width:96pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=128 style='mso-width-source:userset;mso-width-alt:4681;width:96pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=114 span=3 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col width=113 span=2 style='mso-width-source:userset;mso-width-alt:4132;
 width:85pt'>
 
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 width=260 style='height:12.75pt;mso-ignore:colspan;
  width:195pt'><%=v_comp_nm %></td>
  <td width=165 style='width:124pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=133 style='width:100pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=128 style='width:96pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=113 style='width:85pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 style='height:12.75pt;mso-ignore:colspan'><%=v_comp_addr %></td>
  <td colspan=12 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td height=27 colspan=5 style='height:20.25pt;mso-ignore:colspan'></td>
  <td class=xl42 colspan=5 style='mso-ignore:colspan'>BẢNG TỔNG HỢP XUẤT NHẬP
  TỒN VẬT TƯ, HÀNG HÓA</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=6 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan'>Từ ngày <%=v_from_date %> đến
  ngày <%=v_to_date %></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'><span style='mso-spacerun:yes'> </span></td>
  <td colspan=14 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>Kho</td>
  <td colspan=2 class=xl25 style='border-left:none'>Vật tư hàng hóa</td>
  <td class=xl26 style='border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-left:none'>Đơn giá</td>
  <td class=xl26 style='border-left:none'>Tồn đầu kỳ</td>
  <td class=xl26 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl25 style='border-left:none'>Nhập trong kỳ</td>
  <td colspan=2 class=xl25 style='border-left:none'>Xuất trong kỳ</td>
  <td colspan=4 class=xl25 style='border-left:none'>Lũy kế</td>
  <td colspan=2 class=xl25 style='border-left:none'>Tồn cuối kỳ</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>Mã</td>
  <td class=xl26 style='border-top:none;border-left:none'>Tên VT, háng hóa</td>
  <td class=xl25 style='border-top:none;border-left:none'>Đơn vị</td>
  <td class=xl26 style='border-top:none;border-left:none'>Đơn giá</td>
  <td class=xl25 style='border-top:none;border-left:none'>Số lượng</td>
  <td class=xl25 style='border-top:none;border-left:none'>Giá trị</td>
  <td class=xl25 style='border-top:none;border-left:none'>Số lượng</td>
  <td class=xl25 style='border-top:none;border-left:none'>Giá trị</td>
  <td class=xl25 style='border-top:none;border-left:none'>Số lượng</td>
  <td class=xl27 style='border-top:none;border-left:none' x:str><span
  style='mso-spacerun:yes'> </span>Giá trị<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl25 style='border-top:none;border-left:none'>Số lượng nhập</td>
  <td class=xl25 style='border-top:none;border-left:none'>Giá trị nhập</td>
  <td class=xl25 style='border-top:none;border-left:none'>Số lượng xuất</td>
  <td class=xl25 style='border-top:none;border-left:none'>Giá trị xuất</td>
  <td class=xl25 style='border-top:none;border-left:none'>Số lượng</td>
  <td class=xl25 style='border-top:none;border-left:none'>Giá trị</td>
 </tr>
 <% 
    int i;     
    decimal v_last_qty_sum = 0, v_last_amt_sum = 0, v_input_qty_sum = 0, v_input_amt_sum = 0;
    decimal v_output_qty_sum = 0, v_output_amt_sum = 0, v_inqty_accumu = 0, v_inamt_accumu = 0;
    decimal v_end_qty_sum = 0, v_end_amt_sum = 0, v_outqty_accumu = 0, v_outamt_accumu = 0;
    for (i = 0; i < dt.Rows.Count; i++)
    {        
        // last qty    
        if(dt.Rows[i][10].ToString() != "")
        {
            v_last_qty_sum += decimal.Parse(dt.Rows[i][10].ToString());
        }
        // last amt
        if(dt.Rows[i][11].ToString() != "")
        {
            v_last_amt_sum += decimal.Parse(dt.Rows[i][11].ToString());
        }
        // input qty
        if(dt.Rows[i][12].ToString() != "")
        {
            v_input_qty_sum += decimal.Parse(dt.Rows[i][12].ToString());
        }
        // input amt
        if(dt.Rows[i][13].ToString() != "")
        {
            v_input_amt_sum += decimal.Parse(dt.Rows[i][13].ToString());
        }
        // output qty
        if(dt.Rows[i][14].ToString() != "")
        {
            v_output_qty_sum += decimal.Parse(dt.Rows[i][14].ToString());
        }
        // output amt
        if(dt.Rows[i][15].ToString() != "")
        {
            v_output_amt_sum += decimal.Parse(dt.Rows[i][15].ToString());
        }
        // input qty accumulated
        if(dt.Rows[i][17].ToString() != "")
        {
            v_inqty_accumu += decimal.Parse(dt.Rows[i][17].ToString());
        }
        // input amt accumulated
        if(dt.Rows[i][18].ToString() != "")
        {
            v_inamt_accumu += decimal.Parse(dt.Rows[i][18].ToString());
        }

        // output qty accumulated
        if (dt.Rows[i][21].ToString() != "")
        {
            v_outqty_accumu += decimal.Parse(dt.Rows[i][21].ToString());
        }
        // output amt accumulated
        if (dt.Rows[i][22].ToString() != "")
        {
            v_outamt_accumu += decimal.Parse(dt.Rows[i][22].ToString());
        }
                
        // end qty
        if(dt.Rows[i][19].ToString() != "")
        {
            v_end_qty_sum += decimal.Parse(dt.Rows[i][19].ToString());
        }
        // end amt
        if(dt.Rows[i][20].ToString() != "")
        {
            v_end_qty_sum += decimal.Parse(dt.Rows[i][20].ToString());
        }
        
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt;border-top:none'><%=dt.Rows[i][7] %>
  </td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt.Rows[i][3] %></td>
  <td class=xl41 width=165 style='border-top:none;border-left:none;width:124pt'><%=dt.Rows[i][4] %></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt.Rows[i][6] %></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>  </span><%=dt.Rows[i][16] %><span style='mso-spacerun:yes'>    </span></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][10] %></td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>  </span><%=dt.Rows[i][11] %><span style='mso-spacerun:yes'>    </span></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][12] %><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl33 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][13] %><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][14] %><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>  </span><%=dt.Rows[i][15] %><span style='mso-spacerun:yes'>    </span></td>
  <td class=xl34 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i][17] %></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>  </span><%=dt.Rows[i][18] %><span style='mso-spacerun:yes'>    </span></td>

  <td class=xl34 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i][21] %></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>  </span><%=dt.Rows[i][22] %><span style='mso-spacerun:yes'>    </span></td>

  <td class=xl34 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i][19] %></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num ><span
  style='mso-spacerun:yes'>  </span><%=dt.Rows[i][20] %><span style='mso-spacerun:yes'>    </span></td>
 </tr>
 <% 
    }
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none;border-left:none'>Tổng cộng</td>
  <td class=xl26 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none' x:num><%=v_last_qty_sum %></td>
  <td class=xl37 style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'>       
  </span><%=v_last_amt_sum %> </td>
  <td class=xl38 align=right style='border-top:none;border-left:none'
  x:num><%=v_input_qty_sum%></td>
  <td class=xl39 align=right style='border-top:none;border-left:none'
  x:num><%=v_input_amt_sum %></td>
  <td class=xl36 style='border-top:none;border-left:none' x:num><%=v_output_qty_sum %></td>
  <td class=xl40 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%=v_output_amt_sum %> </td>
  <td class=xl38 align=right style='border-top:none;border-left:none'
  x:num><%=v_inqty_accumu %></td>
  <td class=xl37 style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'>   
  </span><%=v_inamt_accumu %> </td>

  <td class=xl38 align=right style='border-top:none;border-left:none'
  x:num><%=v_outqty_accumu%></td>
  <td class=xl37 style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'>   
  </span><%=v_outamt_accumu%> </td>
  
  <td class=xl38 align=right style='border-top:none;border-left:none'
  x:num><%=v_end_qty_sum %></td>
  <td class=xl37 style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'>  
  </span><%=v_end_amt_sum %> </td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=159 style='width:119pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=165 style='width:124pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=133 style='width:100pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=128 style='width:96pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=113 style='width:85pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
