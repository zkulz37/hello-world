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
    string p_Company_pk = Request["Company"];
    string p_Voucher_No = Request["Voucherno"];
    string p_Acc_pk = Request["Acc_pk"];
    
    string p_Month_fr = Request["Month_fr"];    
  string p_Month_to = Request["Month_to"];    

    string l_parameter = "'" + p_Company_pk + "', ";
    l_parameter += "'" + p_Voucher_No + "', ";
    l_parameter += "'" + p_Acc_pk + "', ";
    l_parameter += "'" + p_Month_fr + "', ";  
    l_parameter += "'" + p_Month_to + "' ";  
   //Response.Write(l_parameter);
   //Response.End();
    string p_company_name = "";
    string p_tax_code = "";
    string p_cmp_add = "";
    string SQL = " SELECT partner_lname, tax_code, ADDR1, ADDR2, ADDR3  FROM tco_company  WHERE pk = '" + p_Company_pk + "'";
    DataTable dt2 = ESysLib.TableReadOpen(SQL);
    p_company_name = dt2.Rows[0][0].ToString();
    p_tax_code = dt2.Rows[0][1].ToString();
    p_cmp_add = dt2.Rows[0][2].ToString() + " " + dt2.Rows[0][3].ToString();

    DataTable dt = ESysLib.TableReadOpenCursor("acnt.sp_sel_gfja00030_report", l_parameter);
    //Response.Write(dt.Rows.Count.ToString());
    //Response.End();
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data!!");
        Response.End();
    }

   p_Month_to = p_Month_to.Substring(4, 2) + "/" + p_Month_to.Substring(0, 4);   
          
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List
href="Copy%20of%20So%20chi%20tiet%20chi%20phi%20tra%20truoc_files/filelist.xml">
<link rel=Edit-Time-Data
href="Copy%20of%20So%20chi%20tiet%20chi%20phi%20tra%20truoc_files/editdata.mso">
<link rel=OLE-Object-Data
href="Copy%20of%20So%20chi%20tiet%20chi%20phi%20tra%20truoc_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Phan Thi Thanh Tuyen</o:Author>
  <o:LastAuthor>LONG</o:LastAuthor>
  <o:LastPrinted>2010-08-02T05:52:46Z</o:LastPrinted>
  <o:Created>2010-04-27T06:54:12Z</o:Created>
  <o:LastSaved>2010-08-02T05:56:09Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CTrang &P \/ &N";
	margin:.75in .25in .25in .5in;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl26
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:normal;}
.xl27
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style16;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl34
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl35
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl40
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl44
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl46
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl47
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl52
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl55
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Bảng phân bổ chi phí 2</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>81</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:LeftColumnVisible>2</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>14</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>18795</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>345</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1326 style='border-collapse:
 collapse;table-layout:fixed;width:994pt'>
 <col class=xl24 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl24 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl25 width=256 style='mso-width-source:userset;mso-width-alt:9362;
 width:192pt'>
 <col class=xl26 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl25 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <col class=xl25 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl25 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl27 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl26 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl26 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl27 width=103 span=2 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <col class=xl24 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl24 width=97 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 colspan=3 width=370 style='height:15.75pt;
  mso-ignore:colspan;width:278pt'><%=p_company_name%></td>
  <td class=xl26 width=103 style='width:77pt'></td>
  <td class=xl25 width=55 style='width:41pt'></td>
  <td class=xl25 width=83 style='width:62pt'></td>
  <td class=xl25 width=76 style='width:57pt'></td>
  <td class=xl27 width=103 style='width:77pt'></td>
  <td class=xl26 width=86 style='width:65pt'></td>
  <td class=xl26 width=103 style='width:77pt'></td>
  <td class=xl27 width=103 style='width:77pt'></td>
  <td class=xl27 width=103 style='width:77pt'></td>
  <td class=xl24 width=44 style='width:33pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 colspan=2 style='height:15.75pt;mso-ignore:colspan'><%=p_cmp_add%></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=13 height=25 class=xl29 style='height:18.75pt'>BẢNG PHÂN BỔ CHI
  PHÍ TRÍCH TRƯỚC THÁNG <%=p_Month_to%></td>
  <td class=xl24></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=3 class=xl29 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl31 height=84 style='height:63.0pt'>
  <td height=84 class=xl32 width=44 style='height:63.0pt;width:33pt'>STT</td>
  <td class=xl33 width=70 style='width:53pt'>Mã</td>
  <td class=xl33 width=256 style='width:192pt'>Tài sản</td>
  <td class=xl34 width=103 style='width:77pt'>Nguyên giá</td>
  <td class=xl35 width=55 style='width:41pt' x:str="Thời gian phân bổ"><span
  style='mso-spacerun:yes'> </span>Thời gian phân bổ<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl33 width=83 style='width:62pt'>Thời gian bắt đầu phân bổ</td>
  <td class=xl33 width=76 style='width:57pt'>Thời gian kết thúc phân bổ</td>
  <td class=xl34 width=103 style='width:77pt'>Tổng giá trị phân bổ</td>
  <td class=xl35 width=86 style='width:65pt' x:str="Giá trị phân bổ tháng này"><span
  style='mso-spacerun:yes'> </span>Giá trị phân bổ tháng này<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl34 width=103 style='width:77pt'>Giá trị phân bổ lũy kế tháng
  trước</td>
  <td class=xl34 width=103 style='width:77pt'>Giá trị phân bổ lũy kế tháng này</td>
  <td class=xl34 width=103 style='width:77pt'>Giá trị còn lại</td>
  <td class=xl33 width=44 style='width:33pt'>Ghi chú</td>
  <td class=xl31></td>
 </tr>
 <tr class=xl36 height=20 style='height:15.0pt'>
  <td height=20 class=xl37 style='height:15.0pt' x:num>1</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl39 width=256 style='width:192pt' x:num x:fmla="=+A6+1">2</td>
  <td class=xl40 x:num x:fmla="=+C6+1">3</td>
  <td class=xl38 x:num x:fmla="=+D6+1">4</td>
  <td class=xl38 x:num x:fmla="=+E6+1">5</td>
  <td class=xl38 x:num x:fmla="=+F6+1">6</td>
  <td class=xl40 x:num x:fmla="=+G6+1">7</td>
  <td class=xl40>8=7/4</td>
  <td class=xl40 x:num>9</td>
  <td class=xl40>10 = 8 + 9</td>
  <td class=xl40>11=7-10</td>
  <td class=xl38 x:num>12</td>
  <td class=xl36></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl41 style='height:15.0pt'>I</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl43 width=256 style='width:192pt'>Phân bổ chi phí trả trước ngắn
  hạn</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl45 width=55 style='width:41pt'>&nbsp;</td>
  <td class=xl39 width=83 style='width:62pt'>&nbsp;</td>
  <td class=xl39 width=76 style='width:57pt'>&nbsp;</td>
  <td class=xl46 width=103 style='width:77pt'>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl46 width=103 style='width:77pt'>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl24></td>
 </tr>
<%int k=0;
        decimal nguyengia = 0;
        decimal tong_gtripb = 0;
       decimal pb_thangnay = 0;
       decimal pblk_thangtruoc = 0;
       decimal pblk_thangnay = 0;
       decimal conlai = 0; 
                for(int  i = 0;i<dt.Rows.Count;i++)
                {
                    
                  if(dt.Rows[i][2].ToString().Trim() != "")
                  {
                            nguyengia += decimal.Parse(dt.Rows[k][2].ToString());
                  }  
                  else
                  {
                        nguyengia=0;
                  }
                  
                   if(dt.Rows[i][6].ToString().Trim() != "")
                  {
                            tong_gtripb += decimal.Parse(dt.Rows[k][6].ToString());
                  }  
                  else
                  {
                        tong_gtripb=0;
                  }
                  
                  if(dt.Rows[i][7].ToString().Trim() != "")
                  {
                            pb_thangnay += decimal.Parse(dt.Rows[k][7].ToString());
                  }  
                  else
                  {
                        pb_thangnay=0;
                  }
                  
                  if(dt.Rows[i][8].ToString().Trim() != "")
                  {
                            pblk_thangtruoc += decimal.Parse(dt.Rows[k][8].ToString());
                  }  
                  else
                  {
                        pblk_thangtruoc=0;
                  }
                  
                  if(dt.Rows[i][9].ToString().Trim() != "")
                  {
                            pblk_thangnay += decimal.Parse(dt.Rows[k][9].ToString());
                  }  
                  else
                  {
                        pblk_thangnay =0;
                  }
                  
                  if(dt.Rows[i][10].ToString().Trim() != "")
                  {
                            conlai += decimal.Parse(dt.Rows[k][10].ToString());
                  }  
                  else
                  {
                        conlai =0;
                  }
%> 
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl37 style='height:15.0pt' ><%=k+1%></td>
  <td class=xl48><%=dt.Rows[i][0]%></td>
  <td class=xl50 width=256 style='width:192pt'><%=dt.Rows[i][1]%></td>
  <td class=xl47 x:num><%=dt.Rows[i][2]%></td>
  <td class=xl45 width=55 style='width:41pt' x:num><%=dt.Rows[i][3]%> </td>
  <td class=xl51 width=83 style='width:62pt' x:num><%=dt.Rows[i][4]%></td>
  <td class=xl51 width=76 style='width:57pt' x:num><%=dt.Rows[i][5]%></td>
  <td class=xl45 width=103 style='width:77pt' x:num><%=dt.Rows[i][6]%></td>
  <td class=xl47 x:num><%=dt.Rows[i][7]%></td>
  <td class=xl47 x:num><%=dt.Rows[i][8]%></td>
  <td class=xl47 x:num><%=dt.Rows[i][9]%></td>
  <td class=xl47 x:num><%=dt.Rows[i][10]%></td>
  <td class=xl50 width=44 style='width:33pt'><%=dt.Rows[i][11]%></td>
 
 </tr>
<%
 k+=1;
} %> 
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl49 style='height:15.0pt'>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl43 width=256 style='width:192pt'>Tổng</td>
  <td class=xl52 x:num><%=nguyengia %></td>
  <td class=xl53 width=55 style='width:41pt'>&nbsp;</td>
  <td class=xl54 width=83 style='width:62pt'>&nbsp;</td>
  <td class=xl54 width=76 style='width:57pt'>&nbsp;</td>
  <td class=xl53 width=103 style='width:77pt' x:num><%=tong_gtripb%></td>
  <td class=xl53 width=86 style='width:65pt' x:num><%=pb_thangnay%></td>
  <td class=xl53 width=103 style='width:77pt' x:num><%=pblk_thangtruoc%></td>
  <td class=xl53 width=103 style='width:77pt' x:num  ><%=pblk_thangnay %></td>
  <td class=xl53 width=103 style='width:77pt' x:num  ><%=conlai %></td>
  <td class=xl48>&nbsp;</td>
  <td class=xl27></td>
 </tr>
 
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=44 style='width:33pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=256 style='width:192pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=97 style='width:73pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
