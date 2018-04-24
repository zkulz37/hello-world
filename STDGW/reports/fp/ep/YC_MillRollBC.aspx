<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("sale");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
  	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%

    string SQL, p_tpr_prodresult_pk;
    string roll_id1 = "", item_code = "", item_name = "", roll_id2 = "", bobin="", seq="";
    string line = "", shift1 = "", shift2 = "", worktime = "", q_grade = "", qty = "", uom = "", roll_id_barcode ="";

    p_tpr_prodresult_pk = Request.QueryString["tpr_prodresult_pk"];
    SQL = "SELECT a.pk,  b.LOT_NO roll_id1, a.att02 bobin, a.att04 shift1, a.bc_seq," +
          " '*' || a.item_bc || '*' roll_id_barcode, " +
          " a.item_bc roll_id2, a.item_code, a.item_name, a.line_name, " +
          " a.att04 shift2, a.att05 work_time, a.quality_grade, to_char(a.bc_qty,'999,999,999.99') bc_qty, " +
          " a.lot_uom, a.description " +
          " FROM prod.tpr_itembcm a,prod.tpr_lotno b " +
          " WHERE a.del_if = 0 AND ROWNUM < 2  and b.DEL_IF=0" +
          " AND tpr_prodresult_pk = '" + p_tpr_prodresult_pk + "' and a.TPR_LOTNO_PK = b.PK ";

    DataTable dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count > 0)
    {
        roll_id1 = (string)dt.Rows[0]["roll_id1"].ToString();
        roll_id2 = (string)dt.Rows[0]["roll_id2"].ToString();
        bobin = (string)dt.Rows[0]["bobin"].ToString();
        shift1 = (string)dt.Rows[0]["shift1"].ToString();
        shift2 = (string)dt.Rows[0]["shift2"].ToString();
        worktime = (string)dt.Rows[0]["work_time"].ToString();
        q_grade = (string)dt.Rows[0]["quality_grade"].ToString();
        qty = (string)dt.Rows[0]["bc_qty"].ToString();
        uom = (string)dt.Rows[0]["lot_uom"].ToString();
        item_code = (string)dt.Rows[0]["item_code"].ToString();
        item_name = (string)dt.Rows[0]["item_name"].ToString();
        roll_id_barcode = (string)dt.Rows[0]["roll_id_barcode"].ToString();
        seq = (string)dt.Rows[0]["bc_seq"].ToString();
    }

    SQL = " SELECT b.pk, b.tpr_defect_pk, c.defect_name, to_char(b.defect_qty,'999,999,999.99') defect_qty" +
          "  FROM prod.tpr_oqcresult a, prod.tpr_oqcdefect b, prod.tpr_defect c " +
          "  WHERE a.del_if = 0 " +
          "  AND b.del_if = 0 " +
          "  AND c.del_if = 0 " + 
          "  AND a.pk = b.tpr_oqcresult_pk " +
          "  AND b.tpr_defect_pk = c.pk " +
          "  AND a.tpr_prodresult_pk ='" + p_tpr_prodresult_pk + "'" ;
    dt = ESysLib.TableReadOpen(SQL);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="YC_MillRollBC_files/filelist.xml">
<link rel=Edit-Time-Data href="YC_MillRollBC_files/editdata.mso">
<link rel=OLE-Object-Data href="YC_MillRollBC_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr Quang</o:Author>
  <o:LastAuthor>tuyen</o:LastAuthor>
  <o:LastPrinted>2009-03-11T06:30:45Z</o:LastPrinted>
  <o:Created>2009-02-25T02:14:55Z</o:Created>
  <o:LastSaved>2009-03-11T06:53:09Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.59in .71in .59in .75in;
	mso-header-margin:.51in;
	mso-footer-margin:.51in;}
.font8
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
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
	font-size:20.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl25
	{mso-style-parent:style0;
	font-size:20.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl26
	{mso-style-parent:style0;
	font-size:16.0pt;}
.xl27
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:16.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-size:16.0pt;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:16.0pt;
	text-align:left;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:18.0pt;}
.xl32
	{mso-style-parent:style0;
	font-size:16.0pt;
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:16.0pt;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:24.0pt;}
.xl35
	{mso-style-parent:style0;
	font-size:36.0pt;}
.xl36
	{mso-style-parent:style0;
	font-size:40.0pt;
	font-weight:700;}
.xl37
	{mso-style-parent:style0;
	font-size:40.0pt;}
.xl38
	{mso-style-parent:style0;
	font-size:30.0pt;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:left;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;}
.xl42
	{mso-style-parent:style0;
	font-size:14.0pt;}
.xl43
	{mso-style-parent:style0;
	font-size:14.0pt;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:14.0pt;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:14.0pt;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:14.0pt;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:14.0pt;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-size:14.0pt;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-size:14.0pt;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	font-size:14.0pt;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-size:14.0pt;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-family:Batang, serif;
	mso-font-charset:129;
	text-align:right;}
.xl53
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl57
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl61
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:top;}
.xl62
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl65
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl66
	{mso-style-parent:style0;
	font-size:40.0pt;
	font-weight:700;
	mso-number-format:"0_ ";
	text-align:left;}
.xl67
	{mso-style-parent:style0;
	font-size:40.0pt;
	font-weight:700;
	text-align:center;}
.xl68
	{mso-style-parent:style0;
	font-size:16.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	font-size:16.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	text-align:left;}
.xl71
	{mso-style-parent:style0;
	font-size:24.0pt;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl72
	{mso-style-parent:style0;
	font-size:36.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	font-size:40.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	font-size:40.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	font-size:40.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl77
	{mso-style-parent:style0;
	font-size:40.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	font-size:30.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	font-size:30.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl80
	{mso-style-parent:style0;
	font-size:30.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl81
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl83
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
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
      <x:Scale>83</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
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
  <x:WindowHeight>8925</x:WindowHeight>
  <x:WindowWidth>15390</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>270</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="3073"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=772 style='border-collapse:
 collapse;table-layout:fixed;width:581pt'>
 <col width=123 style='mso-width-source:userset;mso-width-alt:4498;width:92pt'>
 <col width=78 span=3 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col width=128 style='mso-width-source:userset;mso-width-alt:4681;width:96pt'>
 <col width=116 style='mso-width-source:userset;mso-width-alt:4242;width:87pt'>
 <col width=109 style='mso-width-source:userset;mso-width-alt:3986;width:82pt'>
 <col width=62 style='mso-width-source:userset;mso-width-alt:2267;width:47pt'>
 <tr class=xl34 height=40 style='height:30.0pt'>
  <td height=40 class=xl34 width=123 style='height:30.0pt;width:92pt'></td>
  <td class=xl34 width=78 style='width:59pt'></td>
  <td class=xl34 width=78 style='width:59pt'></td>
  <td class=xl34 width=78 style='width:59pt'></td>
  <td class=xl34 width=128 style='width:96pt'></td>
  <td class=xl34 width=116 style='width:87pt'></td>
  <td class=xl34 width=109 style='width:82pt'></td>
  <td class=xl34 width=62 style='width:47pt'></td>
 </tr>
 <tr class=xl35 height=67 style='height:50.25pt'>
  <td colspan=8 height=67 class=xl66 style='height:50.25pt'
  ><%=roll_id1 %></td>
 </tr>
 <tr class=xl40 height=15 style='height:11.25pt'>
  <td height=15 colspan=4 class=xl39 style='height:11.25pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl40 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=35 style='height:26.25pt'>
  <td colspan=4 height=35 class=xl70 style='height:26.25pt'><%=bobin %></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 colspan=4 class=xl41 style='height:12.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl40 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=70 style='mso-height-source:userset;height:52.5pt'>
  <td colspan=8 height=70 class=xl67 style='height:52.5pt'>QC CARD</td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 colspan=8 class=xl36 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td rowspan=2 height=60 class=xl71 style='height:45.0pt'><%=shift1 %></td>
  <td rowspan=2 class=xl71><%=seq %></td>
  <td colspan=6 rowspan=2 class=xl72><%=roll_id_barcode%></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 class=xl24 style='height:9.75pt'>&nbsp;</td>
  <td class=xl24>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
 </tr>
 <tr class=xl31 height=43 style='mso-height-source:userset;height:32.25pt'>
  <td colspan=2 height=43 class=xl68 style='border-right:.5pt solid black;
  height:32.25pt'>ITEM CODE</td>
  <td colspan=6 class=xl81 style='border-right:.5pt solid black;border-left:
  none'><%=item_code %></td>
 </tr>
 <tr class=xl31 height=43 style='mso-height-source:userset;height:32.25pt'>
  <td colspan=2 height=43 class=xl68 style='border-right:.5pt solid black;
  height:32.25pt'>ITEM NAME</td>
  <td colspan=6 class=xl81 style='border-right:.5pt solid black;border-left:
  none'><%=item_name %></td>
 </tr>
 <tr class=xl26 height=43 style='mso-height-source:userset;height:32.25pt'>
  <td height=43 class=xl27 style='height:32.25pt'>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td colspan=5 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=27 style='height:20.25pt'>
  <td colspan=2 height=27 class=xl53 style='border-right:.5pt solid black;
  height:20.25pt'>LINE</td>
  <td colspan=3 class=xl53 style='border-right:.5pt solid black;border-left:
  none'>SHIFT</td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black'>Work Time</td>
 </tr>
 <tr class=xl38 height=43 style='mso-height-source:userset;height:32.25pt'>
  <td colspan=2 height=43 class=xl78 style='border-right:.5pt solid black;
  height:32.25pt'><%=line %></td>
  <td colspan=3 class=xl78 style='border-right:.5pt solid black;border-left:
  none'><%=shift2 %></td>
  <td colspan=3 class=xl80 style='border-right:.5pt solid black'><%=worktime %></td>
 </tr>
 <tr class=xl26 height=43 style='mso-height-source:userset;height:32.25pt'>
  <td height=43 class=xl33 style='height:32.25pt'></td>
  <td colspan=4 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=43 style='mso-height-source:userset;height:32.25pt'>
  <td colspan=3 height=43 class=xl53 style='border-right:.5pt solid black;
  height:32.25pt'>Q GRADE</td>
  <td colspan=3 class=xl53 style='border-left:none'>QTY</td>
  <td colspan=2 class=xl53 style='border-right:.5pt solid black'>UOM</td>
 </tr>
 <tr class=xl37 height=67 style='height:50.25pt'>
  <td colspan=3 height=67 class=xl74 style='border-right:.5pt solid black;
  height:50.25pt'><%=q_grade %></td>
  <td colspan=3 class=xl77 style='border-left:none' x:num><%=qty %></td>
  <td colspan=2 class=xl74 style='border-right:.5pt solid black'><%=uom %></td>
 </tr>
 <tr class=xl26 height=27 style='height:20.25pt'>
  <td height=27 colspan=8 class=xl26 style='height:20.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=27 style='height:20.25pt'>
  <td colspan=4 height=27 class=xl53 style='border-right:.5pt solid black;
  height:20.25pt'>DEFECT NAME</td>
  <td colspan=2 class=xl56 style='border-right:.5pt solid black;border-left:
  none'>QTY</td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
  <%
     for (int i = 0; i < dt.Rows.Count; i++)
     {    
 %>
 <tr class=xl42 height=24 style='height:18.0pt'>
  <td height=24 colspan=4 class=xl49 style='height:18.0pt;border-top:none'><%=dt.Rows[i]["defect_name"]%></td>
  <td class=xl43 colspan=2  style="border-right:.5pt solid black" x:num><%=dt.Rows[i]["defect_qty"]%></td>
 </tr>
  <%} %> 
  <tr class=xl42 height=24 style='height:18.0pt'>
  <td colspan=4 height=24 class=xl49 style='height:18.0pt'></td>
  <td colspan=2  class='xl49' style="border-right:.5pt solid black"></td>
  </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=27 style='height:20.25pt'>
  <td height=27 class=xl29 style='height:20.25pt'>REMARK</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=8 rowspan=12 height=204 class=xl57 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:153.0pt'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=4 style='height:12.75pt;mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
   coordsize="21600,21600" o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe"
   filled="f" stroked="f">
   <v:stroke joinstyle="miter"/>
   <v:formulas>
    <v:f eqn="if lineDrawn pixelLineWidth 0"/>
    <v:f eqn="sum @0 1 0"/>
    <v:f eqn="sum 0 0 @1"/>
    <v:f eqn="prod @2 1 2"/>
    <v:f eqn="prod @3 21600 pixelWidth"/>
    <v:f eqn="prod @3 21600 pixelHeight"/>
    <v:f eqn="sum @0 0 1"/>
    <v:f eqn="prod @6 1 2"/>
    <v:f eqn="prod @7 21600 pixelWidth"/>
    <v:f eqn="sum @8 21600 0"/>
    <v:f eqn="prod @7 21600 pixelHeight"/>
    <v:f eqn="sum @10 21600 0"/>
   </v:formulas>
   <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
   <o:lock v:ext="edit" aspectratio="t"/>
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:30.75pt;margin-top:10.5pt;width:20.25pt;height:16.5pt;z-index:1'>
   <v:imagedata src="YC_MillRollBC_files/image001.jpg" o:title="logo_youlchon"/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:41px;margin-top:14px;width:27px;
  height:22px'><img width=27 height=22 src="YC_MillRollBC_files/image002.jpg"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 width=128 style='height:12.75pt;width:96pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td colspan=8 height=22 class='xl52' style='height:16.5pt; font-size:12.0pt; font-weight:700'>YOUL CHON VINA PLASTIC
  JSC</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=123 style='width:92pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=128 style='width:96pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=62 style='width:47pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
