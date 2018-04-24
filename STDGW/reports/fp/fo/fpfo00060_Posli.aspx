<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("PROD");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
   
    string l_tpr_reqiqc_pk = Request["p_tpr_reqiqc_pk"];
    //Response.Write(l_tac_crcontract_pk);
    //Response.End();
    
    DataTable dt = ESysLib.TableReadOpenCursor("PROD.sp_sel_fpfo00060_2_report", l_tpr_reqiqc_pk);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    string l_book_ccy = "";
    String p_xls_ccy_format = "";
    String p_xls_ccy_format_usd = "";
    if (l_book_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="POSCOdgg_files/filelist.xml">
<link rel=Edit-Time-Data href="POSCOdgg_files/editdata.mso">
<link rel=OLE-Object-Data href="POSCOdgg_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Long</o:LastAuthor>
  <o:LastPrinted>2010-01-06T04:29:16Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2010-01-06T04:30:29Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-header-data:"&RPrint Date \: &D";
	mso-footer-data:"&LPage &P of &N&RPrint By ";
	margin:.25in .25in .46in .25in;
	mso-header-margin:.25in;
	mso-footer-margin:.19in;
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
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl65
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl66
	{mso-style-parent:style0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl67
	{mso-style-parent:style0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl70
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl72
	{mso-style-parent:style0;
	font-size:30.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Delivery Note</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9510</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>90</x:WindowTopX>
  <x:WindowTopY>-90</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Delivery Note'!$1:$12</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=968 style='border-collapse:
 collapse;table-layout:fixed;width:731pt'>
 <col class=xl24 width=33 span=2 style='mso-width-source:userset;mso-width-alt:
 1206;width:25pt'>
 <col class=xl24 width=53 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col class=xl24 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col class=xl24 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl24 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl24 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col class=xl24 width=32 style='mso-width-source:userset;mso-width-alt:1170;
 width:24pt'>
 <col class=xl24 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl24 width=34 style='mso-width-source:userset;mso-width-alt:1243;
 width:26pt'>
 <col class=xl24 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl24 width=133 style='mso-width-source:userset;mso-width-alt:4864;
 width:100pt'>
 <col class=xl24 width=22 span=2 style='mso-width-source:userset;mso-width-alt:
 804;width:17pt'>
 <col class=xl24 width=36 style='mso-width-source:userset;mso-width-alt:1316;
 width:27pt'>
 <col class=xl24 width=22 span=2 style='mso-width-source:userset;mso-width-alt:
 804;width:17pt'>
 <col class=xl24 width=41 style='mso-width-source:userset;mso-width-alt:1499;
 width:31pt'>
 <col class=xl24 width=33 span=2 style='mso-width-source:userset;mso-width-alt:
 1206;width:25pt'>
 <col class=xl24 width=91 style='mso-width-source:userset;mso-width-alt:3328;
 width:68pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 colspan=4 width=152 style='height:12.75pt;
  mso-ignore:colspan;width:115pt'>POSCO E&amp;C &amp; LILAMA</td>
  <td class=xl24 width=83 style='width:62pt'></td>
  <td class=xl24 width=51 style='width:38pt'></td>
  <td class=xl24 width=33 style='width:25pt'></td>
  <td class=xl24 width=32 style='width:24pt'></td>
  <td class=xl24 width=90 style='width:68pt'></td>
  <td class=xl24 width=34 style='width:26pt'></td>
  <td class=xl24 width=38 style='width:29pt'></td>
  <td class=xl24 width=133 style='width:100pt'></td>
  <td class=xl24 width=22 style='width:17pt'></td>
  <td class=xl24 width=22 style='width:17pt'></td>
  <td class=xl24 width=36 style='width:27pt'></td>
  <td class=xl24 width=22 style='width:17pt'></td>
  <td class=xl24 width=22 style='width:17pt'></td>
  <td class=xl24 width=41 style='width:31pt'></td>
  <td class=xl24 width=33 style='width:25pt'></td>
  <td class=xl24 width=33 style='width:25pt'></td>
  <td class=xl24 width=91 style='width:68pt'></td>
 </tr>
<%
    DataTable dt1 = ESysLib.TableReadOpenCursor("PROD.sp_sel_fpfo00060_1_report", l_tpr_reqiqc_pk);
    if (dt1.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    string ls_date = "";
    
    for (int j = 0; j < dt1.Rows.Count; j++)
    {
        ls_date = dt1.Rows[j][4].ToString().Trim();
        ls_date = ls_date.Substring(0,4) + "." + ls_date.Substring(4,2) + "." + ls_date.Substring(6,2);
       
     %>
 <tr height=31 style='height:23.25pt'>
  <td colspan=21 height=31 class=xl70 style='height:23.25pt'>DELIVERY NOTE</td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl25 colspan=3 style='height:12.95pt;mso-ignore:colspan'>Delivery
  Seq</td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'>:&nbsp;<%=dt1.Rows[j][3]%></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl30>Delivery Date :&nbsp;<%=ls_date%></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.95pt'>
  <td height=13 colspan=2 class=xl24 style='height:9.95pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=9 rowspan=3 class=xl72>*R<%=dt1.Rows[j][0]%>*</td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl25 colspan=3 style='height:12.95pt;mso-ignore:colspan'>Delivery
  Person</td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'>: Purchasing Team</td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 colspan=2 class=xl24 style='height:12.95pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl25 colspan=2 style='height:12.95pt;mso-ignore:colspan'>Receiver</td>
  <td class=xl24></td>
  <td class=xl24 colspan=4 style='mso-ignore:colspan'>: Material Management
  Section</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl30>R<%=dt1.Rows[j][0]%></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 colspan=2 class=xl24 style='height:12.95pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl25 colspan=2 style='height:12.95pt;mso-ignore:colspan'>Supplier</td>
  <td class=xl24></td>
  <td class=xl24 colspan=4 style='mso-ignore:colspan'>:&nbsp;<%=dt1.Rows[j][9]%></td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 colspan=2 class=xl25 style='height:12.95pt;mso-ignore:colspan'></td>
  <td colspan=19 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl25 colspan=2 style='height:12.95pt;mso-ignore:colspan'>Project</td>
  <td class=xl24></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'>: <%=dt1.Rows[j][13]%>&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;<%=dt1.Rows[j][11]%></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 colspan=21 class=xl24 style='height:12.95pt;mso-ignore:colspan'></td>
 </tr>
 <%
     
    } 
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'>NO</td>
  <td colspan=11 class=xl33 style='border-right:.5pt solid black;border-left:
  none'>Item</td>
  <td colspan=3 class=xl69 style='border-right:.5pt solid black;border-left:
  none'>Unit</td>
  <td colspan=3 class=xl69 style='border-right:.5pt solid black;border-left:
  none'>Qty</td>
  <td colspan=3 class=xl69 style='border-right:.5pt solid black;border-left:
  none'>TOT. Weight</td>
 </tr>
  <%
      decimal t_qty = 0;
      decimal t_weight = 0;
      int k = 0;
    for (int i = 0; i < dt.Rows.Count; i++)
    {
        if (dt.Rows[i][20].ToString().Trim() != "")
        {
            t_qty += decimal.Parse(dt.Rows[i][20].ToString());
            
        }
        else
        {
            t_qty = 0;   
        }
        if (dt.Rows[i][22].ToString().Trim() != "")
        {
            t_weight += decimal.Parse(dt.Rows[i][22].ToString());
        }
        else
        {
            t_weight = 0;
                 
        }
        
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt' x:num><%=k+1%></td>
  <td colspan=11 class=xl71 style='border-right:.5pt solid black;border-left:
  none'><%=dt.Rows[i][5]%> - <%=dt.Rows[i][6]%></td>
  <td colspan=3 class=xl65 style='border-right:.5pt solid black;border-left:
  none'><%=dt.Rows[i][12]%></td>
  <td colspan=3 class=xl66 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt.Rows[i][20]%></td>
  <td colspan=3 class=xl66 style="border-right:.5pt solid black;border-left:
  none";"mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt.Rows[i][22]%></td>
 </tr>
 <%
     k += 1;
    } %>
 <tr height=2 style='mso-height-source:userset;height:2.1pt'>
  <td colspan=21 height=2 class=xl31 style='height:2.1pt'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=12 height=17 class=xl33 style='border-right:.5pt solid black;
  height:12.75pt'>TOTAL</td>
  <td colspan=3 class=xl36 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=3 class=xl39 style="border-right:.5pt solid black;border-left:
  none";"mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=t_qty%></td>
  <td colspan=3 class=xl66 style="border-right:.5pt solid black;border-left:
  none";"mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=t_weight%></td>
 </tr>
 
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=18 class=xl28 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=9 height=17 class=xl33 style='border-right:.5pt solid black;
  height:12.75pt'>Prepared By</td>
  <td colspan=12 class=xl33 style='border-right:.5pt solid black;border-left:
  none'>Receiver</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=9 rowspan=4 height=92 class=xl47 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:69.0pt'>&nbsp;</td>
  <td colspan=12 rowspan=4 class=xl56 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>&nbsp;</td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=9 height=16 class=xl31 style='border-right:.5pt solid black;
  height:12.0pt'>VÕ THỊ PHƯƠNG TUYỀN</td>
  <td colspan=12 class=xl31 style='border-right:.5pt solid black;border-left:
  none'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=33 style='width:25pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=34 style='width:26pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=133 style='width:100pt'></td>
  <td width=22 style='width:17pt'></td>
  <td width=22 style='width:17pt'></td>
  <td width=36 style='width:27pt'></td>
  <td width=22 style='width:17pt'></td>
  <td width=22 style='width:17pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=91 style='width:68pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
