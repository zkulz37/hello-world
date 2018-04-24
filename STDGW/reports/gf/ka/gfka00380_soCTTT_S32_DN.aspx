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
    string p_com_pk = "" + Request["com"];
    string p_ac_pk = "" + Request["acc_pk"];
    string p_cust_pk = "" + Request["cust_pk"];
    string p_date_from = "" + Request["sdate"];
    string p_from_date = p_date_from.Substring(6, 2) + "/" + p_date_from.Substring(4, 2) + "/" + p_date_from.ToString().Substring(0, 4);
    string p_date_to = "" + Request["edate"];
    string p_to_date = p_date_to.Substring(6, 2) + "/" + p_date_to.Substring(4, 2) + "/" + p_date_to.Substring(0, 4);
    string p_ccy = "" + Request["ccy"];
    string p_status = "" + Request["status"];
    string p_check_acc = Request["check_acc"];
    string p_check_cust = Request["check_cust"];

    string p_Lname = "";
    string p_Add = "";
    string p_Taxcode = "";

    string SQL = " SELECT pk, partner_name, partner_lname, addr2 address, tax_code ";
    SQL += "  FROM tco_company ";
    SQL += " WHERE del_if = 0 AND pk = '" + p_com_pk + "'";
    DataTable dtCom = ESysLib.TableReadOpen(SQL);
    if (dtCom.Rows.Count > 0)
    {
        p_Lname = dtCom.Rows[0][2].ToString();
        p_Add = dtCom.Rows[0][3].ToString();
        p_Taxcode = dtCom.Rows[0][4].ToString();
    }
    
    string l_parameter = "'" + p_com_pk + "', ";
           l_parameter += "'" + p_date_from + "', ";
           l_parameter += "'" + p_date_to + "', ";
           l_parameter += "'" + p_ac_pk + "', ";
           l_parameter += "'" + p_cust_pk + "', ";
           l_parameter += "'" + p_status + "', ";
           l_parameter += "'" + p_ccy + "', ";
           l_parameter += "'" + p_check_acc + "', ";
           l_parameter += "'" + p_check_cust + "' ";
    DataTable dt = ESysLib.TableReadOpenCursor("SP_SEL_gfka00380_voucher",l_parameter);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="aaa_files/filelist.xml">
<link rel=Edit-Time-Data href="aaa_files/editdata.mso">
<link rel=OLE-Object-Data href="aaa_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>KENZIE</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2011-11-30T08:02:52Z</o:LastPrinted>
  <o:Created>2011-11-18T07:36:03Z</o:Created>
  <o:LastSaved>2011-11-30T08:55:18Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.75in .75in .25in .5in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style16
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:Comma;
	mso-style-id:3;}
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
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl26
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-pattern:auto none;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-pattern:auto none;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-pattern:auto none;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-pattern:auto none;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-pattern:auto none;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Form1- Account Code</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:Scale>44</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>200</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>7</x:SplitHorizontal>
     <x:TopRowBottomPane>7</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:Sorting>
     <x:Sort>Column A</x:Sort>
     <x:Sort>Column E</x:Sort>
    </x:Sorting>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8070</x:WindowHeight>
  <x:WindowWidth>18195</x:WindowWidth>
  <x:WindowTopX>465</x:WindowTopX>
  <x:WindowTopY>2250</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Form1- Account Code'!$7:$7</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl31>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2014 style='border-collapse:
 collapse;table-layout:fixed;width:1512pt'>
 <col class=xl32 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl31 width=188 style='mso-width-source:userset;mso-width-alt:6875;
 width:141pt'>
 <col class=xl31 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl31 width=87 style='mso-width-source:userset;mso-width-alt:3181;
 width:65pt'>
 <col class=xl31 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl31 width=109 style='mso-width-source:userset;mso-width-alt:3986;
 width:82pt'>
 <col class=xl31 width=113 style='mso-width-source:userset;mso-width-alt:4132;
 width:85pt'>
 <col class=xl31 width=111 style='mso-width-source:userset;mso-width-alt:4059;
 width:83pt'>
 <col class=xl31 width=152 style='mso-width-source:userset;mso-width-alt:5558;
 width:114pt'>
 <col class=xl34 width=109 span=4 style='mso-width-source:userset;mso-width-alt:
 3986;width:82pt'>
 <col class=xl31 width=156 style='mso-width-source:userset;mso-width-alt:5705;
 width:117pt'>
 <col class=xl31 width=210 style='mso-width-source:userset;mso-width-alt:7680;
 width:158pt'>
 <col class=xl31 width=128 style='mso-width-source:userset;mso-width-alt:4681;
 width:96pt'>
 <col class=xl31 width=132 style='mso-width-source:userset;mso-width-alt:4827;
 width:99pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl35 colspan=4 align=left width=396 style='height:15.0pt;width:297pt'><%=p_Lname %></td>
  <td class=xl32 width=71 style='width:53pt'></td>
  <td class=xl32 width=109 style='width:82pt'></td>
  <td class=xl31 width=113 style='width:85pt'></td>
  <td class=xl31 width=111 style='width:83pt'></td>
  <td class=xl31 width=152 style='width:114pt'></td>
  <td class=xl34 width=109 style='width:82pt'></td>
  <td class=xl34 width=109 style='width:82pt'></td>
  <td class=xl34 width=109 style='width:82pt'></td>
  <td class=xl34 width=109 style='width:82pt'></td>
  <td class=xl31 width=156 style='width:117pt'></td>
  <td class=xl31 width=210 style='width:158pt'></td>
  <td class=xl31 width=128 style='width:96pt'></td>
  <td class=xl31 width=132 style='width:99pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl35 colspan=2 align=left style='height:15.0pt; '><%=p_Add %></td>
  <td colspan=7 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl35 colspan=2 align=left style='height:15.0pt; '><%=p_Taxcode %></td>
  <td colspan=7 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=30 style='height:22.5pt'>
  <td colspan=17 height=30 class=xl36 style='height:22.5pt'>SỔ CHI TIẾT THANH TOÁN VỚI NGƯỜI MUA/NGƯỜI BÁN</td>
 </tr>
 <tr class=xl33 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=17 height=24 class=xl40 style='height:18.0pt'>Từ ngày <%=p_from_date %> Đến ngày <%=p_to_date %></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl32 style='height:15.0pt'></td>
  <td colspan=8 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=50 style='mso-height-source:userset;height:37.5pt'>
  <td height=50 class=xl24 width=77 style='height:37.5pt;width:58pt'>Partner ID</td>
  <td class=xl25 width=188 style='border-left:none;width:141pt'>Partner Name</td>
  <td class=xl25 width=44 style='border-left:none;width:33pt'>Seq</td>
  <td class=xl25 width=87 style='border-left:none;width:65pt'>Voucher No</td>
  <td class=xl25 width=71 style='border-left:none;width:53pt'>Trans Date</td>
  <td class=xl25 width=109 style='border-left:none;width:82pt'>User ID</td>
  <td class=xl25 width=113 style='border-left:none;width:85pt'>CCY</td>
  <td class=xl25 width=111 style='border-left:none;width:83pt'>Account Code</td>
  <td class=xl25 width=152 style='border-left:none;width:114pt'>Account Name</td>
  <td class=xl26 width=109 style='border-left:none;width:82pt'  x:str="Trans Debit"><span style='mso-spacerun:yes'> </span>Trans Debit<span  style='mso-spacerun:yes'> </span></td>
  <td class=xl26 width=109 style='border-left:none;width:82pt'  x:str="Books Debit"><span style='mso-spacerun:yes'> </span>Books Debit<span  style='mso-spacerun:yes'> </span></td>
  <td class=xl26 width=109 style='border-left:none;width:82pt'  x:str="Trans Credit"><span style='mso-spacerun:yes'> </span>Trans Credit<span  style='mso-spacerun:yes'> </span></td>
  <td class=xl26 width=109 style='border-left:none;width:82pt'  x:str="Books Credit"><span style='mso-spacerun:yes'> </span>Books Credit<span  style='mso-spacerun:yes'> </span></td>
  <td class=xl25 width=156 style='border-left:none;width:117pt'>Description</td>
  <td class=xl25 width=210 style='border-left:none;width:158pt'>Local Description</td>
  <td class=xl25 width=128 style='border-left:none;width:96pt'>Cost Center</td>
  <td class=xl25 width=132 style='border-left:none;width:99pt'>Item</td>
 </tr>
 <%
     string p_color = "";
     string p_align = "";
     for (int i = 0; i < dt.Rows.Count; i++)
     {
         if (dt.Rows[i][18].ToString() == "1")
         {
             p_color = "background-color:#FFCC99";
             p_align = "text-align:right";
         }
         else if (dt.Rows[i][18].ToString() == "0")
         {
             p_color = "background-color:#99CCFF";
             p_align = "text-align:right";
         }
         else
         {
             p_color = "";
             p_align = "";
         }
      %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 align=left style='height:15.0pt;border-top:none;<%=p_color%> ' ><%=dt.Rows[i][0]%></td>
  <td class=xl29 align=left style='border-top:none;border-left:none;<%=p_color%>'><%=dt.Rows[i][1]%></td>
  <td class=xl38 style='border-top:none;border-left:none;<%=p_color%>' x:num><%=dt.Rows[i][2]%></td>
  <td class=xl29 align=left style='border-top:none;border-left:none;<%=p_color%>'><%=dt.Rows[i][3]%></td>
  <td class=xl39 align=right style='border-top:none;border-left:none;<%=p_color%>'  x:num><%=dt.Rows[i][4]%></td>
  <td class=xl38 style='border-top:none;border-left:none;<%=p_color%>;<%=p_align%>'><%=dt.Rows[i][5]%></td>
  <td class=xl29 align=left style='border-top:none;border-left:none;<%=p_color%>;<%=p_align%>'><%=dt.Rows[i][6]%></td>
  <td class=xl37 style='border-top:none;border-left:none;<%=p_color%>;<%=p_align%>' x:num><%=dt.Rows[i][7]%></td>
  <td class=xl29 align=left style='border-top:none;border-left:none;<%=p_color%>;<%=p_align%>'><%=dt.Rows[i][8]%></td>
  <td class=xl30 align=left style='border-top:none;border-left:none;<%=p_color%>;<%=p_align%>'  x:num><%=dt.Rows[i][9]%></td>
  <td class=xl30 align=left style='border-top:none;border-left:none;<%=p_color%>;<%=p_align%>'  x:num><%=dt.Rows[i][10]%></td>
  <td class=xl30 align=left style='border-top:none;border-left:none;<%=p_color%>;<%=p_align%>'  x:num><%=dt.Rows[i][11]%></td>
  <td class=xl30 align=left style='border-top:none;border-left:none;<%=p_color%>;<%=p_align%>'  x:num><%=dt.Rows[i][12]%></td>
  <td class=xl29 align=left style='border-top:none;border-left:none;<%=p_color%>;<%=p_align%>'><%=dt.Rows[i][13]%></td>
  <td class=xl29 align=left style='border-top:none;border-left:none;<%=p_color%>;<%=p_align%>'><%=dt.Rows[i][14]%></td>
  <td class=xl29 align=left style='border-top:none;border-left:none;<%=p_color%>;<%=p_align%>'><%=dt.Rows[i][15]%></td>
  <td class=xl29 align=left style='border-top:none;border-left:none;<%=p_color%>;<%=p_align%>'><%=dt.Rows[i][16]%></td>
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=77 style='width:58pt'></td>
  <td width=188 style='width:141pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=152 style='width:114pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=156 style='width:117pt'></td>
  <td width=210 style='width:158pt'></td>
  <td width=128 style='width:96pt'></td>
  <td width=132 style='width:99pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
