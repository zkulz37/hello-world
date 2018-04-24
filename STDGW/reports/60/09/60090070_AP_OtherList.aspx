<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string l_compk = "";
    string l_from_dt = "", l_to_dt = "";
    int i;
    string l_user_id = "", l_user_yn = "";
    string l_voucherno = "";
    string l_vendor_pk = "";    
    string l_item_pk = "";
    string l_pl_pk = "";
    string l_delivery = "";
    l_compk = Request["company_pk"];
    l_from_dt = Request["from_date"];
    l_to_dt = Request["to_date"];
    l_voucherno = Request["voucherno"];
    l_vendor_pk = Request["vendor_pk"];
    l_item_pk = Request["item_pk"];
    l_pl_pk = Request["pl_pk"];
    l_delivery = Request["delivery"];
    l_user_id = Request["user_id"];
    l_user_yn = Request["user_yn"];
    
     string p_cmp_name           = "";
    string p_cmp_add            = "";
    string p_cmp_taxcode        = "";
    
    string SQL = "";
    string l_parameter = "'" + l_compk + "', '" ;
    l_parameter += l_from_dt + "', '" + l_to_dt + "', '" + l_voucherno + "', '" + l_vendor_pk + "', '" + l_item_pk + "', '" + l_pl_pk + "', '" + l_delivery + "', '" + l_user_id + "', '" + l_user_yn + "' ";
//Response.Write(l_parameter);
//Response.End();	
    DataTable dt = ESysLib.TableReadOpenCursor("ac_sel_60090070", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("No data to display");
        Response.End();
    }
   
    SQL = " SELECT PARTNER_LNAME, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + l_compk + "' ";
	DataTable dt1 = ESysLib.TableReadOpen(SQL);
	if (dt1.Rows.Count >0)
	{
		p_cmp_name      = dt1.Rows[0][0].ToString();
		p_cmp_add       = dt1.Rows[0][1].ToString();
		p_cmp_taxcode   = dt1.Rows[0][2].ToString();
	}
	
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="AP%20Others%20Detail%20List_files/filelist.xml">
<link rel=Edit-Time-Data href="AP%20Others%20Detail%20List_files/editdata.mso">
<link rel=OLE-Object-Data href="AP%20Others%20Detail%20List_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>van</o:Author>
  <o:LastAuthor>van</o:LastAuthor>
  <o:LastPrinted>2011-06-06T05:56:23Z</o:LastPrinted>
  <o:Created>2011-06-06T04:13:54Z</o:Created>
  <o:LastSaved>2011-06-06T05:57:34Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
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
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl26
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl27
	{mso-style-parent:style0;
	text-align:left;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl37
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>AP Others Detail List</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:LeftColumnVisible>5</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>8</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8835</x:WindowHeight>
  <x:WindowWidth>15180</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1797 style='border-collapse:
 collapse;table-layout:fixed;width:1349pt'>
 <col class=xl24 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col width=222 style='mso-width-source:userset;mso-width-alt:8118;width:167pt'>
 <col class=xl24 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col width=104 style='mso-width-source:userset;mso-width-alt:3803;width:78pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=67 style='mso-width-source:userset;mso-width-alt:2450;width:50pt'>
 <col class=xl26 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl25 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl26 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:3657;width:75pt'>
 <col width=64 style='width:48pt'>
 <col width=77 style='mso-width-source:userset;mso-width-alt:2816;width:58pt'>
 <col width=87 style='mso-width-source:userset;mso-width-alt:3181;width:65pt'>
 <col width=64 style='width:48pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=237 style='mso-width-source:userset;mso-width-alt:8667;width:178pt'>
 <col width=195 style='mso-width-source:userset;mso-width-alt:7131;width:146pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 colspan=2 width=316 style='height:12.75pt;
  mso-ignore:colspan;width:238pt'><%=p_cmp_name%></td>
  <td class=xl24 width=77 style='width:58pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=67 style='width:50pt'></td>
  <td class=xl26 width=80 style='width:60pt'></td>
  <td class=xl25 width=96 style='width:72pt'></td>
  <td class=xl26 width=89 style='width:67pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=237 style='width:178pt'></td>
  <td width=195 style='width:146pt'></td>
 </tr>
 <tr height=35 style='height:26.25pt'>
  <td height=35 class=xl24 style='height:26.25pt'></td>
  <td></td>
  <td class=xl24></td>
  <td class=xl36 colspan=4 style='mso-ignore:colspan'>AP Others Detail List</td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>Từ ngày: <%=l_from_dt.Substring(6, 2) + "/" + l_from_dt.Substring(4, 2) + "/" + l_from_dt.Substring(0, 4)%> đến <%=l_to_dt.Substring(6, 2) + "/" + l_to_dt.Substring(4, 2) + "/" + l_to_dt.Substring(0, 4)%></td>
  <td></td>
  <td class=xl24></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td></td>
  <td class=xl24></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl37 style='height:27.75pt'>Item code</td>
  <td class=xl37 style='border-left:none'>Item name</td>
  <td class=xl38 width=77 style='border-left:none;width:58pt'>Transaction<br>
    <span style='mso-spacerun:yes'> </span>Date</td>
  <td class=xl37 style='border-left:none'>Voucher no</td>
  <td class=xl37 style='border-left:none'>Seq (others)</td>
  <td class=xl37 style='border-left:none'>Clear YN</td>
  <td class=xl39 style='border-left:none' x:str="Qty"><span
  style='mso-spacerun:yes'> </span>Qty<span style='mso-spacerun:yes'> </span></td>
  <td class=xl41 width=96 style='border-left:none;width:72pt'
  x:str="Trans &#10;Amount"><span style='mso-spacerun:yes'> </span>Trans <br>
    Amount<span style='mso-spacerun:yes'> </span></td>
  <td class=xl42 width=89 style='border-left:none;width:67pt'
  x:str="Book &#10;Amount"><span style='mso-spacerun:yes'> </span>Book <br>
    Amount<span style='mso-spacerun:yes'> </span></td>
  <td class=xl37 style='border-left:none'>Voucher No</td>
  <td class=xl37 style='border-left:none'>Seq</td>
  <td class=xl37 style='border-left:none'>Invoice No</td>
  <td class=xl37 style='border-left:none'>Invoice Date</td>
  <td class=xl37 style='border-left:none'>Serial No</td>
  <td class=xl37 style='border-left:none'>PL Code</td>
  <td class=xl37 style='border-left:none'>PL Name</td>
  <td class=xl37 style='border-left:none'>Vendor Name</td>
 </tr>
 <% 
     string l_takein_dt = "";
     double l_tot_qty = 0, l_tot_aptramt = 0, l_tot_amt = 0;
     for (i = 0; i < dt.Rows.Count; i++)
     {
         l_takein_dt = dt.Rows[i][4].ToString();
         l_takein_dt = l_takein_dt.Substring(6, 2) + "/" + l_takein_dt.Substring(4, 2) + "/" + l_takein_dt.Substring(0, 4);
         l_tot_qty += double.Parse(dt.Rows[i][8].ToString());
         l_tot_aptramt += double.Parse(dt.Rows[i][9].ToString());
         l_tot_amt += double.Parse(dt.Rows[i][10].ToString());
 %>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl29 style='height:16.5pt;border-top:none' x:str><%=dt.Rows[i][0] %></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dt.Rows[i][1] %></td>
  <td class=xl29 style='border-top:none;border-left:none' x:str><%=l_takein_dt%></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dt.Rows[i][5] %><span
  style='display:none'></span></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>   </span><%=dt.Rows[i][8] %> </td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>     </span><%=dt.Rows[i][9] %> </td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%=dt.Rows[i][10] %> </td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dt.Rows[i][17] %></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dt.Rows[i][18] %></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dt.Rows[i][19] %></td>
 </tr>
 <% 
     }
 %>
 <tr class=xl28 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=6 height=22 class=xl43 style='height:16.5pt'>Tổng cộng</td>
  <td class=xl33 style='border-top:none;border-left:none' x:num
  ><span style='mso-spacerun:yes'>   </span><%=l_tot_qty%> </td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><span style='mso-spacerun:yes'>    </span><%=l_tot_aptramt%> </td>
  <td class=xl33 style='border-top:none;border-left:none' x:num><span style='mso-spacerun:yes'>       </span><%=l_tot_amt%> </td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=94 style='width:71pt'></td>
  <td width=222 style='width:167pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=237 style='width:178pt'></td>
  <td width=195 style='width:146pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
