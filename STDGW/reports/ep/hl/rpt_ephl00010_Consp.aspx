<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% Response.ContentType = "application/vnd.ms-excel"; %>
<% ESysLib.SetUser("imex");%>


<%
    if (Request.QueryString["random"] == null) return;
    
    string pkList, ConspPK;
    string partnerName = "", addr = "", faxNo = "";
   // string[]  myArr = new string[100];
    
    pkList = Request.QueryString["pkList"];
    ConspPK = Request.QueryString["ConspPK"];

    string SQL;
    SQL = "select v1.partner_name, v1.addr1 , v1.fax_no " +
        "    from tie_consp_mst v, tco_buspartner v1     " +
        "    where v.del_if=0 and v1.del_if=0 " +
        "        and v.tco_buspartner_pk=v1.pk  " +
        "        and v.pk='" + ConspPK + "' ";

    DataTable dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count > 0)
    { 
        partnerName=(string)dt.Rows[0][0].ToString() ; 
        addr= (string)dt.Rows[0][1].ToString();
        faxNo =(string)dt.Rows[0][2].ToString(); 
    }
    char[] charSeparators = new char[] {','};

    string[] myArr = pkList.Split(charSeparators);
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="ephl00010_Consp_files/filelist.xml">
<link rel=Edit-Time-Data href="ephl00010_Consp_files/editdata.mso">
<link rel=OLE-Object-Data href="ephl00010_Consp_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>NgaLe</o:Author>
  <o:LastAuthor>NgaLe</o:LastAuthor>
  <o:LastPrinted>2008-09-10T03:55:21Z</o:LastPrinted>
  <o:Created>2008-09-10T02:47:42Z</o:Created>
  <o:LastSaved>2008-09-10T03:55:33Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.56in .4in .59in .36in;
	mso-header-margin:.36in;
	mso-footer-margin:.28in;}
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl26
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl32
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
	border-left:none;}
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
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl36
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl41
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:right;}
.xl42
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;}
.xl43
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl48
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl51
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
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
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>78</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:TopRowVisible>12</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>25</x:ActiveRow>
       <x:RangeSelection>$26:$35</x:RangeSelection>
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
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=874 style='border-collapse:
 collapse;table-layout:fixed;width:659pt'>
 <col class=xl24 width=34 style='mso-width-source:userset;mso-width-alt:1243;
 width:26pt'>
 <col class=xl24 width=124 style='mso-width-source:userset;mso-width-alt:4534;
 width:93pt'>
 <col class=xl24 width=106 style='mso-width-source:userset;mso-width-alt:3876;
 width:80pt'>
 <col class=xl24 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl24 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl24 width=98 style='mso-width-source:userset;mso-width-alt:3584;
 width:74pt'>
 <col class=xl24 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 <col class=xl24 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl24 width=97 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <col class=xl24 width=42 style='mso-width-source:userset;mso-width-alt:1536;
 width:32pt'>
 <col class=xl24 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <%
    for(int i=0; i< myArr.Length; i++)
    {        
        string itemNm="", itemCD="", unit="";
        
	    SQL = "select v2.item_code, v2.item_name, unit  " + 
            "        from tie_consp_dtlm v, tco_item v2  " +
            "        where v.del_if=0 and v2.del_if=0  " +
            "                and v.tco_item_ex_pk=v2.pk " +
            "                and v.pk ='" + myArr[i] + "'" ;
        dt = ESysLib.TableReadOpen(SQL);
        
        if(dt.Rows.Count>0)
        {  
            itemNm=(string)dt.Rows[0][1].ToString() ; 
            itemCD=(string)dt.Rows[0][0].ToString() ;
            unit= (string)dt.Rows[0][2].ToString() ;
        }
  %>
 <tr height=17 style='height:12.75pt'>
  <td colspan=11 height=17 class=xl25 width=874 style='height:12.75pt;
  width:659pt'>Mẫu: 08/ĐMNLNK/2006</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=58 style='mso-height-source:userset;height:43.5pt'>
  <td colspan=11 height=58 class=xl43 width=874 style='height:43.5pt;
  width:659pt'>BẢNG KÊ ĐỊNH MỨC TIÊU HAO NGUYÊN VẬT LIỆU<br>
    NHẬP KHẨU CỦA MỘT SỐ ĐƠN VỊ SẢN PHẨM</td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 colspan=11 class=xl26 style='height:23.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>        
  <td height=21 class=xl27 colspan=2 style='height:15.75pt;mso-ignore:colspan'
  x:str="Tên doanh nghiệp: ">Tên doanh nghiệp:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl28><%=partnerName%></td>
  <td class=xl28></td>
  <td colspan=7 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 class=xl27 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Địa
  chỉ:</td>
  <td class=xl28><%=addr%></td>  
  <td class=xl28></td>
  <td colspan=7 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 class=xl27 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Mã
  số doanh nghiệp:</td>
  <td class=xl28 colspan=2 style='mso-ignore:colspan'><%=faxNo %></td>
  <td colspan=7 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 class=xl27 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Hợp
  đồng Xuất khẩu số:</td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 class=xl27 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Mã
  sản phẩm:</td>
  <td colspan=2 class=xl29><%=itemCD %></td>
  <td class=xl27></td>
  <td class=xl27>Tên sản phẩm:</td>
  <td colspan=3 class=xl44><%=itemNm %></td>
  <td class=xl29>ĐVT:</td>
  <td class=xl27><%=unit %></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=42 style='height:31.5pt'>
  <td height=42 class=xl31 style='height:31.5pt'>STT</td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none'>Tên nguyên phụ liệu</td>
  <td colspan=2 class=xl47 style='border-right:.5pt solid black;border-left:
  none'>Mã NPL</td>       
  <td class=xl32>ĐVT</td>
  <td class=xl32>Định mức</td>
  <td class=xl33 width=100 style='width:75pt'>Tỷ lệ <br>
    hao hụt (%)</td>
  <td class=xl33 width=97 style='width:73pt'>Định mức <br>
    kể cả hao hụt</td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none'>Nguồn cung cấp</td>
 </tr>
 <%     
	SQL= "select  v2.item_name, v2.item_code, v.unit " + 
        "            , v.req_qty, v.loss_rate, nvl(v.req_qty,0)*(1 +nvl(v.loss_rate,0)/100)+nvl(v.adjust_qty,0) total " +
        "            , s.CODE_nm " +
        "        from tie_consp_dtls v, tco_item v2   " +
        "            , (select a.CODE,  a.CODE_nm from TCO_ABCODE a, TCO_ABCODEGRP b  " +
        "                where TCO_ABCODEGRP_PK=b.pk and b.id='COAB0080'  " +
        "                    and a.del_if=0 and b.del_if=0  " +
        "                order by a.CODE)  s            " +
        "        where v.del_if=0 and v2.del_if=0  " +
        "                and v.tco_item_im_pk=v2.pk " +
        "                and v.PUR_ORIGIN_CD = s.CODE(+) " +
        "                and v.tie_consp_dtlm_pk ='"  + myArr[i] + "'  " ;
    dt = ESysLib.TableReadOpen(SQL);
        
 %>
 <% for(int j=0; j<dt.Rows.Count ;j++)
    { %>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl34 style='height:15.95pt'><%=j+1 %></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none'><%=dt.Rows[j][0] %></td>
  <td colspan=2 class=xl50 style='border-right:.5pt solid black;border-left:
  none'><%=dt.Rows[j][1] %></td>
  <td class=xl36><%=dt.Rows[j][2] %></td>
  <td class=xl37><%=dt.Rows[j][3] %></td>
  <td class=xl38><%=dt.Rows[j][4] %></td>
  <td class=xl39><%=dt.Rows[j][5] %></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none'><%=dt.Rows[j][6] %></td>
 </tr>
 <%} %>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl40 style='height:15.95pt'></td>
  <td colspan=4 class=xl51>…………Ngày……….Tháng………….Năm…………….</td>
  <td class=xl35></td>
  <td class=xl25></td>
  <td colspan=4 class=xl51>…………Ngày……….Tháng………….Năm…………….</td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl40 style='height:15.95pt'></td>
  <td colspan=4 class=xl52>công chức tiếp nhận định mức</td>
  <td class=xl35></td>
  <td class=xl25></td>
  <td colspan=4 class=xl52>Giám đốc doanh nghiệp</td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl40 style='height:15.95pt'></td>
  <td colspan=4 class=xl40>(ký tên, đóng dấu công chức)</td>
  <td class=xl35></td>
  <td class=xl25></td>
  <td colspan=4 class=xl40>(ký tên, đóng dấu, ghi rõ họ tên)</td>
 </tr>
 <%
     for (int n = dt.Rows.Count; n < 45; n++)
     {
 %>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl40 style='height:15.95pt'></td>
  <td class=xl35></td>
  <td class=xl35 x:num></td>
  <td colspan=3 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl41></td>
  <td class=xl42 ><span style='mso-spacerun:yes'>                     
  </span></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <%
    }
 %>
 <tr height=21 style='page-break-before:always;mso-height-source:userset;
  height:15.95pt'>
  <td height=21 class=xl40 style='height:15.95pt'></td>
  <td colspan=5 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl41></td>
  <td class=xl42></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=11 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=11 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=11 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=11 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=11 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=11 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=11 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=11 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=11 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=11 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=11 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=11 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=11 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=11 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=34 style='width:26pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=82 style='width:62pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
