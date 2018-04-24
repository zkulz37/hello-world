<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% Response.ContentType = "application/vnd.ms-excel"; %>
<% ESysLib.SetUser("imex");%>

<%
    //if (Request.QueryString["random"] == null) return;
    
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
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="ephl00010_Consp_group_files/filelist.xml">
<link rel=Edit-Time-Data href="ephl00010_Consp_group_files/editdata.mso">
<link rel=OLE-Object-Data href="ephl00010_Consp_group_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>NgaLe</o:Author>
  <o:LastAuthor>NgaLe</o:LastAuthor>
  <o:LastPrinted>2008-09-11T05:59:46Z</o:LastPrinted>
  <o:Created>2008-09-10T02:47:42Z</o:Created>
  <o:LastSaved>2008-09-11T06:04:37Z</o:LastSaved>
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
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl28
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl29
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	mso-number-format:"_\(* \#\,\#\#0\.00000_\)\;_\(* \\\(\#\,\#\#0\.00000\\\)\;_\(* \0022-\0022?????_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:right;}
.xl34
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00000_\)\;_\(* \\\(\#\,\#\#0\.00000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl47
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl50
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.00000_\)\;\\\(\#\,\#\#0\.00000\\\)";}
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
      <x:Scale>72</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>4</x:ActiveRow>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=944 style='border-collapse:
 collapse;table-layout:fixed;width:711pt'>
 <col class=xl24 width=34 style='mso-width-source:userset;mso-width-alt:1243;
 width:26pt'>
 <col class=xl24 width=124 style='mso-width-source:userset;mso-width-alt:4534;
 width:93pt'>
 <col class=xl24 width=101 style='mso-width-source:userset;mso-width-alt:3693;
 width:76pt'>
 <col class=xl24 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl24 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl24 width=98 style='mso-width-source:userset;mso-width-alt:3584;
 width:74pt'>
 <col class=xl24 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 <col class=xl24 width=96 span=2 style='mso-width-source:userset;mso-width-alt:
 3510;width:72pt'>
 <col class=xl24 width=42 style='mso-width-source:userset;mso-width-alt:1536;
 width:32pt'>
 <col class=xl24 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl24 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
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
  <td colspan=12 height=17 class=xl27 width=944 style='height:12.75pt;
  width:711pt'>Mẫu: 08/ĐMNLNK/2006</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=12 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=58 style='mso-height-source:userset;height:43.5pt'>
  <td colspan=11 height=58 class=xl47 width=864 style='height:43.5pt;
  width:651pt'>BẢNG KÊ ĐỊNH MỨC TIÊU HAO NGUYÊN VẬT LIỆU<br>
    NHẬP KHẨU CỦA MỘT SỐ ĐƠN VỊ SẢN PHẨM</td>
  <td class=xl24></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 colspan=11 class=xl25 style='height:23.25pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl36 height=21 style='height:15.75pt'>
  <td height=21 class=xl36 colspan=2 style='height:15.75pt;mso-ignore:colspan'
  x:str="Tên doanh nghi&#7879;p: ">Tên doanh nghi&#7879;p:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl37><%=partnerName %></td>
  <td class=xl37></td>
  <td colspan=8 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl36 height=21 style='height:15.75pt'>
  <td height=21 class=xl36 colspan=2 style='height:15.75pt;mso-ignore:colspan'>&#272;&#7883;a
  ch&#7881;:</td>
  <td class=xl36><%=addr%></td>
  <td class=xl37></td>
  <td colspan=8 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl36 height=21 style='height:15.75pt'>
  <td height=21 class=xl36 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Mã
  s&#7889; doanh nghi&#7879;p:</td>
  <td class=xl37 colspan=2 style='mso-ignore:colspan'><%=faxNo %></td>
  <td colspan=8 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl36 height=21 style='height:15.75pt'>
  <td height=21 class=xl36 colspan=2 style='height:15.75pt;mso-ignore:colspan'>H&#7907;p
  &#273;&#7891;ng Xu&#7845;t kh&#7849;u s&#7889;:</td>
  <td colspan=2 class=xl37 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl36 height=21 style='height:15.75pt'>
  <td height=21 class=xl36 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Tên
  s&#7843;n ph&#7849;m:</td>
  <td class=xl36><%=itemNm %></td>
  <td colspan=3 class=xl36 style='mso-ignore:colspan'></td>
  <td  class=xl39></td>
  <td  class=xl39></td>
  <td  class=xl39></td>
  <td class=xl38></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl36 height=21 style='height:15.75pt'>
  <td height=21 class=xl36 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Mã
  s&#7843;n ph&#7849;m:</td>
  <td class=xl49><%=itemCD %></td>
  <td class=xl38></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl36 height=21 style='height:15.75pt'>
  <td height=21 class=xl38 colspan=2 style='height:15.75pt;mso-ignore:colspan'>&#272;&#417;n
  v&#7883; tính:</td>
  <td class=xl49><%=unit %></td>
  <td class=xl38></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=12 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr> 
 <tr class=xl42 height=55 style='mso-height-source:userset;height:41.25pt'>
  <td height=55 class=xl40 style='height:41.25pt'>STT</td>
  <td colspan=2 class=xl40 style='border-left:none'>Tên nguyên ph&#7909;
  li&#7879;u</td>
  <td colspan=2 class=xl40 style='border-left:none'>Mã NPL</td>
  <td class=xl40 style='border-left:none'>&#272;VT</td>
  <td class=xl41 width=85 style='border-left:none;width:64pt'>&#272;&#7883;nh
  m&#7913;c<br>
    s&#7917; d&#7909;ng</td>
  <td class=xl41 width=96 style='border-left:none;width:72pt'>T&#7927; l&#7879;
  <br>
    hao h&#7909;t (%)</td>
  <td class=xl41 width=96 style='border-left:none;width:72pt'>&#272;&#7883;nh
  m&#7913;c <br>
    k&#7875; c&#7843; hao h&#7909;t</td>
  <td colspan=2 class=xl40 style='border-left:none'>Ngu&#7891;n cung c&#7845;p</td>
  <td class=xl40 style='border-left:none'>Ghi chú</td>
 </tr>
 <%     
   SQL = "select  v3.item_name, v3.item_code  ,  v4.tranuom_code    " +
     "      , sum(nvl(v.req_qty,0))*nvl(tran_rate,1) as req_qty, avg(v.loss_rate) loss_rate   " +
     "      , sum(nvl(v.req_qty,0)*nvl(tran_rate,1)*(1 +nvl(v.loss_rate,0)/100)+nvl(v.adjust_qty,0)*nvl(tran_rate,1)) total    " +
     "      , s.country_nm , v.remark   " +
     "  from tie_consp_dtls v, tco_item v2, tco_stitem v3, tco_measure v4 , tco_uom v5       " +
     "            , tie_country s  " +
     "  where v.del_if=0 and v2.del_if=0     " +
     "        and v2.tco_stitem_pk =v3.pk(+)   " +
     "                and v.tco_item_im_pk=v2.pk    " +
     "                and v.pur_origin_cd = s.country_cd2(+)    " +
     "                and v.unit = v5.UOM_CODE(+)  " +
     "                and v4.TCO_UOM_PK(+) = v5.pk " +
     "                and v4.TRANUOM_CODE(+) = 'YD' " +
     "                and v.tie_consp_dtlm_pk ='" + myArr[i] + "'  " +
     "  group by  v3.item_name, v3.item_code, s.country_nm, v.remark, v4.tranuom_code , tran_rate  ";

    dt = ESysLib.TableReadOpen(SQL);
        
 %>
 <% for(int j=0; j<dt.Rows.Count ;j++)
    { %>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl29 style='height:15.95pt;border-top:none'><%=j+1%></td>
  <td colspan=2 class=xl43 style='border-right:.5pt solid black;border-left:
  none'><%=dt.Rows[j][0] %></td>
  <td colspan=2 class=xl43 style='border-right:.5pt solid black;border-left:
  none'><%=dt.Rows[j][1] %></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dt.Rows[j][2] %></td>
  <td class=xl31 x:num  style='border-top:none;border-left:none'><%=dt.Rows[j][3]%></td>
  <td class=xl32 x:num  style='border-top:none;border-left:none'><%=dt.Rows[j][4] %></td>
  <td class=xl34 x:num  style='border-top:none;border-left:none'><%=dt.Rows[j][5] %></td>
  <td colspan=2 class=xl43 style='border-right:.5pt solid black;border-left:
  none'><%=dt.Rows[j][6] %></td>
  <td class=xl48 style='border-top:none;border-left:none'><%=dt.Rows[j][7] %></td>
 </tr>
 <%} %> 
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl26 style='height:15.95pt'></td>
  <td colspan=4 class=xl45>…………Ngày……….Tháng………….N&#259;m…………….</td>
  <td class=xl28></td>
  <td class=xl27></td>
  <td colspan=4 class=xl45>…………Ngày……….Tháng………….N&#259;m…………….</td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl26 style='height:15.95pt'></td>
  <td colspan=4 class=xl46>công ch&#7913;c ti&#7871;p nh&#7853;n
  &#273;&#7883;nh m&#7913;c</td>
  <td class=xl28></td>
  <td class=xl27></td>
  <td colspan=4 class=xl46>Giám &#273;&#7889;c doanh nghi&#7879;p</td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl26 style='height:15.95pt'></td>
  <td colspan=4 class=xl26>(ký tên, &#273;óng d&#7845;u công ch&#7913;c)</td>
  <td class=xl28></td>
  <td class=xl27></td>
  <td colspan=4 class=xl26>(ký tên, &#273;óng d&#7845;u, ghi rõ h&#7885; tên)</td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl26 style='height:15.95pt'></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl33></td>
  <td class=xl35></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl26 style='height:15.95pt'></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl33></td>
  <td class=xl35></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl26 style='height:15.95pt'></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl33></td>
  <td class=xl35></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl26 style='height:15.95pt'></td>
  <td class=xl28></td>
  <td class=xl28 x:num></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl33></td>
  <td class=xl35 x:num><span style='mso-spacerun:yes'>                     
  </span> </td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <%
     for (int n = dt.Rows.Count; n<44 ; n++)
     {    
  %>
  <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl26 style='height:15.95pt'></td>
  <td class=xl28></td>
  <td class=xl28 x:num></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl33></td>
  <td class=xl35 x:num><span style='mso-spacerun:yes'>                     
  </span> </td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
  <%} %>
 <%} %>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl26 style='height:15.95pt'></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl33></td>
  <td class=xl35></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl26 style='height:15.95pt'></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl33></td>
  <td class=xl35></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl26 style='height:15.95pt'></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl33></td>
  <td class=xl35></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl26 style='height:15.95pt'></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl33></td>
  <td class=xl35></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl26 style='height:15.95pt'></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl33></td>
  <td class=xl35></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl26 style='height:15.95pt'></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl33></td>
  <td class=xl35></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl26 style='height:15.95pt'></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl33></td>
  <td class=xl35></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl26 style='height:15.95pt'></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl33></td>
  <td class=xl35></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl26 style='height:15.95pt'></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl33></td>
  <td class=xl35></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl24 style='height:15.95pt'></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td class=xl27></td>
  <td class=xl33></td>
  <td class=xl35></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=12 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=12 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=12 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=12 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=12 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=12 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=12 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=12 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=12 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=12 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=12 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=12 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=12 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=12 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=12 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=34 style='width:26pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=80 style='width:60pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
