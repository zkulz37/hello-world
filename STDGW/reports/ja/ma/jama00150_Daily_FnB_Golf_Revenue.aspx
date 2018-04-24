<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("CRM");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
 string  p_date = Request["p_date"],l_date_to="";
    string l_parameter_snack_bar="",l_parameter_tee_house6="",l_parameter_tee_house14="",l_parameter_club_house_fnb="";
	l_parameter_snack_bar="'"+p_date+"','POINT-06'";
	l_parameter_tee_house6="'"+p_date+"','POINT-04'";
	l_parameter_tee_house14="'"+p_date+"','POINT-05'";
	l_parameter_club_house_fnb="'"+p_date+"','POINT-01'";

    DataTable dt_snack_bar = ESysLib.TableReadOpenCursor("crm.sp_rpt_jama00150_fnb_revenue", l_parameter_snack_bar);
	DataTable dt_tee_house6 = ESysLib.TableReadOpenCursor("crm.sp_rpt_jama00150_fnb_revenue", l_parameter_tee_house6);
	DataTable dt_tee_house14 = ESysLib.TableReadOpenCursor("crm.sp_rpt_jama00150_fnb_revenue", l_parameter_tee_house14);
	DataTable dt_club_house_fnb = ESysLib.TableReadOpenCursor("crm.sp_rpt_jama00150_fnb_revenue", l_parameter_club_house_fnb);
     if (dt_snack_bar.Rows.Count == 0 && dt_tee_house6.Rows.Count == 0 && dt_tee_house14.Rows.Count == 0 && dt_club_house_fnb.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    l_date_to =  p_date.Substring(6, 2) + "/" +p_date.Substring(4, 2) + "/" + p_date.Substring(0, 4);
	
	string l_sysdate="";
	string l_ex_rate="";
	string SQL1 = "select to_char(sysdate,'dd/mm/yyyy hh24:mi') from dual";
    DataTable dt_sysdate = ESysLib.TableReadOpen(SQL1);
    if (dt_sysdate.Rows.Count > 0)
    {
        l_sysdate = dt_sysdate.Rows[0][0].ToString();
    }
   string  SQL_ex_rate = "SELECT crm.sf_get_current_sell_ex_rate(2,'USD') from dual";
    DataTable dt_ex_rate = ESysLib.TableReadOpen(SQL_ex_rate);
    if (dt_ex_rate.Rows.Count > 0)
    {
        l_ex_rate = dt_ex_rate.Rows[0][0].ToString();
    }
	
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="jama00150_Daily_FnB_Golf_Revenue_files/filelist.xml">
<link rel=Edit-Time-Data
href="jama00150_Daily_FnB_Golf_Revenue_files/editdata.mso">
<link rel=OLE-Object-Data
href="jama00150_Daily_FnB_Golf_Revenue_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>dieu</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2010-11-29T06:53:04Z</o:LastPrinted>
  <o:Created>2010-11-29T04:42:02Z</o:Created>
  <o:LastSaved>2011-01-22T01:19:19Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&RPage &P";
	margin:.2in .2in .2in .2in;
	mso-header-margin:.51in;
	mso-footer-margin:.51in;
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
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid black;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl38
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl54
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl56
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
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
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
       <x:ActiveCol>15</x:ActiveCol>
       <x:RangeSelection>$P$2:$Q$2</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9000</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>0</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=944 style='border-collapse:
 collapse;table-layout:fixed;width:709pt'>
 <col width=20 style='mso-width-source:userset;mso-width-alt:731;width:15pt'>
 <col width=36 style='mso-width-source:userset;mso-width-alt:1316;width:27pt'>
 <col width=51 style='mso-width-source:userset;mso-width-alt:1865;width:38pt'>
 <col width=43 style='mso-width-source:userset;mso-width-alt:1572;width:32pt'>
 <col width=36 style='mso-width-source:userset;mso-width-alt:1316;width:27pt'>
 <col width=50 style='mso-width-source:userset;mso-width-alt:1828;width:38pt'>
 <col width=56 style='mso-width-source:userset;mso-width-alt:2048;width:42pt'>
 <col width=49 style='mso-width-source:userset;mso-width-alt:1792;width:37pt'>
 <col width=52 style='mso-width-source:userset;mso-width-alt:1901;width:39pt'>
 <col width=64 style='width:48pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=59 style='mso-width-source:userset;mso-width-alt:2157;width:44pt'>
 <col width=64 style='width:48pt'>
 <col width=67 style='mso-width-source:userset;mso-width-alt:2450;width:50pt'>
 <col width=62 style='mso-width-source:userset;mso-width-alt:2267;width:47pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=102 style='mso-width-source:userset;mso-width-alt:3730;width:77pt'>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=17 height=27 class=xl37 width=944 style='height:20.25pt;
  width:709pt'>Song<span style='mso-spacerun:yes'>  </span>Gia<span
  style='mso-spacerun:yes'>  </span>Resort<span style='mso-spacerun:yes'> 
  </span>Complex</td>
 </tr>
 <tr height=51 style='mso-height-source:userset;height:38.25pt'>
  <td colspan=6 height=51 class=xl38 width=236 style='height:38.25pt;
  width:177pt'>Daily<span style='mso-spacerun:yes'>  </span>Revenue<span
  style='mso-spacerun:yes'>  </span>Report<span style='mso-spacerun:yes'>   
  </span>Snack Bar,Golf Academy</td>
  <td class=xl24>Date:</td>
  <td colspan=3 class=xl39><%=l_date_to%></td>
  <td class=xl24>Currency:</td>
  <td class=xl25 x:num><%=l_ex_rate%></td>
  <td colspan=2 class=xl40>&nbsp;</td>
  <td class=xl26>Print Date:</td>
  <td colspan=2 class=xl41><%=l_sysdate%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=3 height=51 class=xl32 style='height:38.25pt;border-top:none'>No</td>
  <td rowspan=3 class=xl32 style='border-top:none'>Inv.No</td>
  <td rowspan=3 class=xl32 style='border-top:none'>Locker#</td>
  <td rowspan=3 class=xl32 style='border-top:none'>Rm No</td>
  <td rowspan=3 class=xl32 style='border-top:none'>Cover</td>
  <td colspan=4 class=xl32 style='border-left:none'>Revenue Type</td>
  <td class=xl32 style='border-top:none;border-left:none'>Payable To:</td>
  <td rowspan=3 class=xl42 width=65 style='width:49pt'>Total
  Revenue&amp;Payable</td>
  <td colspan=2 class=xl32 style='border-left:none'>Payment by:</td>
  <td colspan=3 class=xl32 style='border-left:none'>Transfer to:</td>
  <td rowspan=3 class=xl42 width=102 style='border-top:none;width:77pt'>Total
  Pymnt,AR&amp;Guest Account</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl32 style='height:25.5pt;border-top:none'>Food</td>
  <td rowspan=2 class=xl32 style='border-top:none'>Beverage</td>
  <td rowspan=2 class=xl32 style='border-top:none'>Other</td>
  <td rowspan=2 class=xl32 style='border-top:none'>Total</td>
  <td rowspan=2 class=xl32 style='border-top:none'>VAT(10%)</td>
  <td rowspan=2 class=xl32 style='border-top:none'>Cash</td>
  <td rowspan=2 class=xl32 style='border-top:none'>Credit Card</td>
  <td rowspan=2 class=xl42 width=67 style='border-top:none;width:50pt'>Accounts
  Receivable</td>
  <td colspan=2 class=xl32 style='border-left:none'>Guest Account at:</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl32 style='height:12.75pt;border-top:none;border-left:
  none'>Hotel</td>
  <td class=xl32 style='border-top:none;border-left:none'>Club House</td>
 </tr>
 <%
     int rownum=0;
	 for (int i = 0; i < dt_snack_bar.Rows.Count; i++)
     {
          if(dt_snack_bar.Rows.Count != 0)
		  {
			 rownum=i+1;
		  }
		  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl34 style='height:12.75pt;border-top:none' x:num><%=rownum%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt_snack_bar.Rows[i][0]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt_snack_bar.Rows[i][1]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt_snack_bar.Rows[i][2]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt_snack_bar.Rows[i][3]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt_snack_bar.Rows[i][4]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt_snack_bar.Rows[i][5]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt_snack_bar.Rows[i][6]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt_snack_bar.Rows[i][7]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt_snack_bar.Rows[i][8]%></td>
  <td class=xl36 width=65 style='border-top:none;border-left:none;width:49pt'
  x:num><%=dt_snack_bar.Rows[i][9]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt_snack_bar.Rows[i][10]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt_snack_bar.Rows[i][11]%></td>
  <td class=xl36 width=67 style='border-top:none;border-left:none;width:50pt'
  x:num><%=dt_snack_bar.Rows[i][12]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt_snack_bar.Rows[i][13]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt_snack_bar.Rows[i][14]%></td>
  <td class=xl36 width=102 style='border-top:none;border-left:none;width:77pt'
  x:num><%=dt_snack_bar.Rows[i][15]%></td>
 </tr>
 <%} %>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=17 height=17 class=xl43 style='height:12.75pt'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=17 height=25 class=xl37 style='height:18.75pt'>Song<span
  style='mso-spacerun:yes'>  </span>Gia<span style='mso-spacerun:yes'> 
  </span>Resort<span style='mso-spacerun:yes'>  </span>Complex</td>
 </tr>
 <tr height=53 style='mso-height-source:userset;height:39.75pt'>
  <td colspan=6 height=53 class=xl38 width=236 style='height:39.75pt;
  width:177pt'>Daily<span style='mso-spacerun:yes'>  </span>Revenue<span
  style='mso-spacerun:yes'>  </span>Report<span style='mso-spacerun:yes'>   
  </span>Tee - House No.6</td>
  <td colspan=3 class=xl44>Date:</td>
  <td colspan=8 class=xl45><%=l_date_to%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=3 height=51 class=xl32 style='height:38.25pt;border-top:none'>No</td>
  <td rowspan=3 class=xl32 style='border-top:none'>Inv.No</td>
  <td rowspan=3 class=xl32 style='border-top:none'>Locker#</td>
  <td rowspan=3 class=xl32 style='border-top:none'>Rm No</td>
  <td rowspan=3 class=xl32 style='border-top:none'>Cover</td>
  <td colspan=4 class=xl32 style='border-left:none'>Revenue Type</td>
  <td class=xl32 style='border-top:none;border-left:none'>Payable To:</td>
  <td rowspan=3 class=xl42 width=65 style='border-top:none;width:49pt'>Total
  Revenue&amp;Payable</td>
  <td colspan=2 class=xl32 style='border-left:none'>Payment by:</td>
  <td colspan=3 class=xl32 style='border-left:none'>Transfer to:</td>
  <td rowspan=3 class=xl42 width=102 style='border-top:none;width:77pt'>Total
  Pymnt,AR&amp;Guest Account</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl32 style='height:25.5pt;border-top:none'>Food</td>
  <td rowspan=2 class=xl32 style='border-top:none'>Beverage</td>
  <td rowspan=2 class=xl32 style='border-top:none'>Other</td>
  <td rowspan=2 class=xl32 style='border-top:none'>Total</td>
  <td rowspan=2 class=xl32 style='border-top:none'>VAT(10%)</td>
  <td rowspan=2 class=xl32 style='border-top:none'>Cash</td>
  <td rowspan=2 class=xl32 style='border-top:none'>Credit Card</td>
  <td rowspan=2 class=xl42 width=67 style='border-top:none;width:50pt'>Accounts
  Receivable</td>
  <td colspan=2 class=xl32 style='border-left:none'>Guest Account at:</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl32 style='height:12.75pt;border-top:none;border-left:
  none'>Hotel</td>
  <td class=xl32 style='border-top:none;border-left:none'>Club House</td>
 </tr>
 <%
     int rownum1=0;
	 for (int i1 = 0; i1 < dt_tee_house6.Rows.Count; i1++)
     {
          if(dt_tee_house6.Rows.Count != 0)
		  {
			 rownum1=i1+1;
		  }
		  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl34 style='height:12.75pt;border-top:none' x:num><%=rownum1%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt_tee_house6.Rows[i1][0]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt_tee_house6.Rows[i1][1]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt_tee_house6.Rows[i1][2]%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dt_tee_house6.Rows[i1][3]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt_tee_house6.Rows[i1][4]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt_tee_house6.Rows[i1][5]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt_tee_house6.Rows[i1][6]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt_tee_house6.Rows[i1][7]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt_tee_house6.Rows[i1][8]%></td>
  <td class=xl36 width=65 style='border-top:none;border-left:none;width:49pt'
  x:num><%=dt_tee_house6.Rows[i1][9]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt_tee_house6.Rows[i1][10]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt_tee_house6.Rows[i1][11]%></td>
  <td class=xl36 width=67 style='border-top:none;border-left:none;width:50pt'
  x:num><%=dt_tee_house6.Rows[i1][12]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt_tee_house6.Rows[i1][13]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt_tee_house6.Rows[i1][14]%></td>
  <td class=xl36 width=102 style='border-top:none;border-left:none;width:77pt'
  x:num><%=dt_tee_house6.Rows[i1][15]%></td>
 </tr>
 <%} %>
 <tr height=17 style='height:12.75pt'>
  <td colspan=17 height=17 class=xl46 style='height:12.75pt'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=17 height=25 class=xl37 style='height:18.75pt'>Song<span
  style='mso-spacerun:yes'>  </span>Gia<span style='mso-spacerun:yes'> 
  </span>Resort<span style='mso-spacerun:yes'>  </span>Complex</td>
 </tr>
 <tr height=48 style='mso-height-source:userset;height:36.0pt'>
  <td colspan=6 height=48 class=xl38 width=236 style='height:36.0pt;width:177pt'>Daily<span
  style='mso-spacerun:yes'>  </span>Revenue<span style='mso-spacerun:yes'> 
  </span>Report<span style='mso-spacerun:yes'>    </span>Tee - House No.14</td>
  <td colspan=3 class=xl44>Date:</td>
  <td colspan=8 class=xl45><%=l_date_to%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=3 height=51 class=xl47 style='border-bottom:.5pt solid black;
  height:38.25pt;border-top:none'>No</td>
  <td rowspan=3 class=xl47 style='border-bottom:.5pt solid black;border-top:
  none'>Inv.No</td>
  <td rowspan=3 class=xl47 style='border-bottom:.5pt solid black;border-top:
  none'>Locker#</td>
  <td rowspan=3 class=xl47 style='border-bottom:.5pt solid black;border-top:
  none'>Rm No</td>
  <td rowspan=3 class=xl47 style='border-bottom:.5pt solid black;border-top:
  none'>Cover</td>
  <td colspan=4 class=xl50 style='border-right:.5pt solid black;border-left:
  none'>Revenue Type</td>
  <td class=xl27>Payable To:</td>
  <td rowspan=3 class=xl53 width=65 style='border-bottom:.5pt solid black;
  border-top:none;width:49pt'>Total Revenue&amp;Payable</td>
  <td colspan=2 class=xl50 style='border-right:.5pt solid black;border-left:
  none'>Payment by:</td>
  <td colspan=3 class=xl50 style='border-right:.5pt solid black;border-left:
  none'>Transfer to:</td>
  <td rowspan=3 class=xl53 width=102 style='border-bottom:.5pt solid black;
  border-top:none;width:77pt'>Total Pymnt,AR&amp;Guest Account</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl47 style='border-bottom:.5pt solid black;
  height:25.5pt;border-top:none'>Food</td>
  <td rowspan=2 class=xl47 style='border-bottom:.5pt solid black;border-top:
  none'>Beverage</td>
  <td rowspan=2 class=xl47 style='border-bottom:.5pt solid black;border-top:
  none'>Other</td>
  <td rowspan=2 class=xl47 style='border-bottom:.5pt solid black;border-top:
  none'>Total</td>
  <td rowspan=2 class=xl47 style='border-bottom:.5pt solid black;border-top:
  none'>VAT(10%)</td>
  <td rowspan=2 class=xl47 style='border-bottom:.5pt solid black;border-top:
  none'>Cash</td>
  <td rowspan=2 class=xl47 style='border-bottom:.5pt solid black;border-top:
  none'>Credit Card</td>
  <td rowspan=2 class=xl53 width=67 style='border-bottom:.5pt solid black;
  border-top:none;width:50pt'>Accounts Receivable</td>
  <td colspan=2 class=xl50 style='border-right:.5pt solid black;border-left:
  none'>Guest Account at:</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'>Hotel</td>
  <td class=xl27>Club House</td>
 </tr>
 <%
     int rownum2=0;
	 for (int i2 = 0; i2 < dt_tee_house14.Rows.Count; i2++)
     {
          if(dt_tee_house14.Rows.Count != 0)
		  {
			 rownum2=i2+1;
		  }
		  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt' x:num><%=rownum2%></td>
  <td class=xl29><%=dt_tee_house14.Rows[i2][0]%></td>
  <td class=xl30><%=dt_tee_house14.Rows[i2][1]%></td>
  <td class=xl33 x:num><%=dt_tee_house14.Rows[i2][2]%></td>
  <td class=xl30 align=right x:num><%=dt_tee_house14.Rows[i2][3]%></td>
  <td class=xl30 align=right x:num><%=dt_tee_house14.Rows[i2][4]%></td>
  <td class=xl30 align=right x:num><%=dt_tee_house14.Rows[i2][5]%></td>
  <td class=xl30 align=right x:num><%=dt_tee_house14.Rows[i2][6]%></td>
  <td class=xl30 align=right x:num><%=dt_tee_house14.Rows[i2][7]%></td>
  <td class=xl30 align=right x:num><%=dt_tee_house14.Rows[i2][8]%></td>
  <td class=xl30 align=right x:num><%=dt_tee_house14.Rows[i2][9]%></td>
  <td class=xl30 align=right x:num><%=dt_tee_house14.Rows[i2][10]%></td>
  <td class=xl30 align=right x:num><%=dt_tee_house14.Rows[i2][11]%></td>
  <td class=xl30 align=right x:num><%=dt_tee_house14.Rows[i2][12]%></td>
  <td class=xl30 align=right x:num><%=dt_tee_house14.Rows[i2][13]%></td>
  <td class=xl30 align=right x:num><%=dt_tee_house14.Rows[i2][14]%></td>
  <td class=xl30 align=right x:num><%=dt_tee_house14.Rows[i2][15]%></td>
 </tr>
 <%} %>
 <tr height=17 style='height:12.75pt'>
  <td colspan=17 height=17 class=xl46 style='height:12.75pt'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=17 height=25 class=xl37 style='height:18.75pt'>Song<span
  style='mso-spacerun:yes'>  </span>Gia<span style='mso-spacerun:yes'> 
  </span>Resort<span style='mso-spacerun:yes'>  </span>Complex</td>
 </tr>
 <tr height=48 style='mso-height-source:userset;height:36.0pt'>
  <td colspan=6 height=48 class=xl38 width=236 style='height:36.0pt;width:177pt'>Daily<span
  style='mso-spacerun:yes'>  </span>Revenue<span style='mso-spacerun:yes'> 
  </span>Report<span style='mso-spacerun:yes'>    </span>Restaurant,golf Club
  House</td>
  <td colspan=3 class=xl44>Date:</td>
  <td colspan=8 class=xl45><%=l_date_to%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=3 height=51 class=xl47 style='border-bottom:.5pt solid black;
  height:38.25pt;border-top:none'>No</td>
  <td rowspan=3 class=xl47 style='border-bottom:.5pt solid black;border-top:
  none'>Inv.No</td>
  <td rowspan=3 class=xl47 style='border-bottom:.5pt solid black;border-top:
  none'>Locker#</td>
  <td rowspan=3 class=xl47 style='border-bottom:.5pt solid black;border-top:
  none'>Rm No</td>
  <td rowspan=3 class=xl47 style='border-bottom:.5pt solid black;border-top:
  none'>Cover</td>
  <td colspan=4 class=xl50 style='border-right:.5pt solid black;border-left:
  none'>Revenue Type</td>
  <td class=xl27>Payable To:</td>
  <td rowspan=3 class=xl53 width=65 style='border-bottom:.5pt solid black;
  border-top:none;width:49pt'>Total Revenue&amp;Payable</td>
  <td colspan=2 class=xl50 style='border-right:.5pt solid black;border-left:
  none'>Payment by:</td>
  <td colspan=3 class=xl50 style='border-right:.5pt solid black;border-left:
  none'>Transfer to:</td>
  <td rowspan=3 class=xl53 width=102 style='border-bottom:.5pt solid black;
  border-top:none;width:77pt'>Total Pymnt,AR&amp;Guest Account</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl47 style='border-bottom:.5pt solid black;
  height:25.5pt;border-top:none'>Food</td>
  <td rowspan=2 class=xl47 style='border-bottom:.5pt solid black;border-top:
  none'>Beverage</td>
  <td rowspan=2 class=xl47 style='border-bottom:.5pt solid black;border-top:
  none'>Other</td>
  <td rowspan=2 class=xl47 style='border-bottom:.5pt solid black;border-top:
  none'>Total</td>
  <td rowspan=2 class=xl47 style='border-bottom:.5pt solid black;border-top:
  none'>VAT(10%)</td>
  <td rowspan=2 class=xl47 style='border-bottom:.5pt solid black;border-top:
  none'>Cash</td>
  <td rowspan=2 class=xl47 style='border-bottom:.5pt solid black;border-top:
  none'>Credit Card</td>
  <td rowspan=2 class=xl53 width=67 style='border-bottom:.5pt solid black;
  border-top:none;width:50pt'>Accounts Receivable</td>
  <td colspan=2 class=xl50 style='border-right:.5pt solid black;border-left:
  none'>Guest Account at:</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'>Hotel</td>
  <td class=xl27>Club House</td>
 </tr>
 <%
     int rownum3=0;
	 for (int i3 = 0; i3 < dt_club_house_fnb.Rows.Count; i3++)
     {
          if(dt_club_house_fnb.Rows.Count != 0)
		  {
			 rownum3=i3+1;
		  }
		  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt' x:num><%=rownum3%></td>
  <td class=xl29><%=dt_club_house_fnb.Rows[i3][0]%></td>
  <td class=xl30><%=dt_club_house_fnb.Rows[i3][1]%></td>
  <td class=xl30 align=right x:num><%=dt_club_house_fnb.Rows[i3][2]%></td>
  <td class=xl30 align=right x:num><%=dt_club_house_fnb.Rows[i3][3]%></td>
  <td class=xl30 align=right x:num><%=dt_club_house_fnb.Rows[i3][4]%></td>
  <td class=xl30 align=right x:num><%=dt_club_house_fnb.Rows[i3][5]%></td>
  <td class=xl30 align=right x:num><%=dt_club_house_fnb.Rows[i3][6]%></td>
  <td class=xl30 align=right x:num><%=dt_club_house_fnb.Rows[i3][7]%></td>
  <td class=xl30 align=right x:num><%=dt_club_house_fnb.Rows[i3][8]%></td>
  <td class=xl30 align=right x:num><%=dt_club_house_fnb.Rows[i3][9]%></td>
  <td class=xl30 align=right x:num><%=dt_club_house_fnb.Rows[i3][10]%></td>
  <td class=xl30 align=right x:num><%=dt_club_house_fnb.Rows[i3][11]%></td>
  <td class=xl30 align=right x:num><%=dt_club_house_fnb.Rows[i3][12]%></td>
  <td class=xl30 align=right x:num><%=dt_club_house_fnb.Rows[i3][13]%></td>
  <td class=xl31 align=right x:num><%=dt_club_house_fnb.Rows[i3][14]%></td>
  <td class=xl31 align=right style='border-top:none' x:num><%=dt_club_house_fnb.Rows[i3][15]%></td>
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=20 style='width:15pt'></td>
  <td width=36 style='width:27pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=36 style='width:27pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=102 style='width:77pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
