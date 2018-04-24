<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("prod");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
  	//Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
    string p_dtst = Request.QueryString["wi_from_dt"];
    string p_dtet = Request.QueryString["wi_to_dt"];  
    
    string SQL = "select SALE.sf_get_dsbs00013_2(2, c.TCO_ITEM_PK) item_class, c.wi_no,  " + 
        "        SALE.sf_get_dsbs00013_2(3, c.TCO_ITEM_PK) treatment, " +
        "        SALE.sf_get_dsbs00013_2(1, c.TCO_ITEM_PK) classfication, " +
        "        SALE.sf_get_dsbs00013_2(4, c.TCO_ITEM_PK) thickness, " +
        "        SALE.sf_get_dsbs00013_2(5, c.TCO_ITEM_PK) width, " +
        "        SALE.sf_get_dsbs00013_2(6, c.TCO_ITEM_PK) i_length, " +
        "        c.att07 roll  ,c.att12 weight " +
        "         , c.pk tpr_workins_pk " +
        " from prod.tpr_workins c" +
        " where  c.wi_type = 3 and c.del_if =0 and wi_mi_yn='Y' " +
        "    and c.WI_DATE between '" + p_dtst + "' and '" + p_dtet + "' " +
         " order by c.wi_no " ;
    
    //Response.Write(SQL);
    //Response.End();
    DataTable dt = ESysLib.TableReadOpen(SQL);

 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Mini_WI_files/filelist.xml">
<link rel=Edit-Time-Data href="Mini_WI_files/editdata.mso">
<link rel=OLE-Object-Data href="Mini_WI_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>khk</o:Author>
  <o:LastAuthor>NgaLe</o:LastAuthor>
  <o:LastPrinted>2009-03-10T06:39:15Z</o:LastPrinted>
  <o:Created>2009-03-10T02:14:24Z</o:Created>
  <o:LastSaved>2009-03-10T06:39:31Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.24in .2in .27in .39in;
	mso-header-margin:.17in;
	mso-footer-margin:.19in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style17
	{mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	mso-style-name:"Comma \[0\]";
	mso-style-id:6;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style21
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:\D45C\C900_Sheet1;}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl25
	{mso-style-parent:style0;
	font-size:14.0pt;}
.xl26
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;}
.xl28
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center;}
.xl29
	{mso-style-parent:style21;
	font-size:14.0pt;
	font-weight:700;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center-across;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center-across;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center;}
.xl43
	{mso-style-parent:style21;
	font-size:14.0pt;
	font-weight:700;
	mso-number-format:"Short Date";
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-weight:700;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style0;
	font-weight:700;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style0;
	font-weight:700;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style0;
	font-weight:700;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-weight:700;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style17;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;
	}
.xl61
	{mso-style-parent:style0;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl62
	{mso-style-parent:style0;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style17;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	text-align:right;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style0;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl65
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
    }
.xl66
	{mso-style-parent:style0;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl67
	{mso-style-parent:style17;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl68
	{mso-style-parent:style0;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl69
	{mso-style-parent:style17;
	font-weight:700;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022_-\;_-\@_-";
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl70
	{mso-style-parent:style0;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:2.0pt double windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl71
	{mso-style-parent:style17;
	font-weight:700;
	font-family:\AD74\B9BC\CCB4, monospace;
	mso-font-charset:129;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022_-\;_-\@_-";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Mini WI</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>270</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>67</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>44</x:ActiveRow>
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
     <x:DefaultRowHeight>270</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>270</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8475</x:WindowHeight>
  <x:WindowWidth>14280</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1647 style='border-collapse:
 collapse;table-layout:fixed;width:1238pt'>
 <col width=94 style='mso-width-source:userset;mso-width-alt:3008;width:71pt'>
 <col class=xl25 width=120 style='mso-width-source:userset;mso-width-alt:3840;
 width:90pt'>
 <col width=111 style='mso-width-source:userset;mso-width-alt:3552;width:83pt'>
 <col width=178 style='mso-width-source:userset;mso-width-alt:5696;width:134pt'>
 <col width=92 span=2 style='mso-width-source:userset;mso-width-alt:2944;
 width:69pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2240;width:53pt'>
 <col width=52 style='mso-width-source:userset;mso-width-alt:1664;width:39pt'>
 <col width=81 style='mso-width-source:userset;mso-width-alt:2592;width:61pt'>
 <col width=73 span=3 style='mso-width-source:userset;mso-width-alt:2336;
 width:55pt'>
 <col width=81 style='mso-width-source:userset;mso-width-alt:2592;width:61pt'>
 <col width=119 style='mso-width-source:userset;mso-width-alt:3808;width:89pt'>
 <col width=207 style='mso-width-source:userset;mso-width-alt:6624;width:155pt'>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 width=106 style='height:15.75pt;width:80pt'></td>
  <td class=xl26 width=116 style='width:87pt'></td>
  <td class=xl27 width=102 style='width:77pt'></td>
  <td class=xl27 width=161 style='width:121pt'></td>
  <td class=xl27 width=103 style='width:77pt'></td>
  <td class=xl27 width=103 style='width:77pt'></td>
  <td class=xl27 width=79 style='width:59pt'></td>
  <td class=xl27 width=82 style='width:62pt'></td>
  <td class=xl27 width=91 style='width:68pt'></td>
  <td class=xl27 width=82 style='width:62pt'></td>
  <td class=xl27 width=82 style='width:62pt'></td>
  <td class=xl27 width=82 style='width:62pt'></td>
  <td class=xl27 width=91 style='width:68pt'></td>
  <td class=xl28 width=134 style='width:101pt'></td>
  <td class=xl27 width=233 style='width:175pt'></td>
 </tr>
 <tr class=xl25 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl25 style='height:30.0pt'></td>
  <td colspan=14 class=xl42>MINI S/L CUTTING PLAN</td>
 </tr>
 <tr class=xl25 height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 class=xl25 style='height:9.75pt'></td>
  <td class=xl26></td>
  <td colspan=11 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td class=xl27></td>
 </tr>
 <%
     SQL = " SELECT to_char(to_date(" + p_dtst + ",'yyyymmdd'),'YYYY-MON-DD') || '~' || to_char(to_date(" + p_dtet + ",'yyyymmdd'),'YYYY-MON-DD') from dual";

     DataTable dt1 = ESysLib.TableReadOpen(SQL);
     string dtDate="";
     if (dt1.Rows.Count >0 )
        dtDate =(string) dt1.Rows[0][0];
  %>
 <tr class=xl25 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=10 height=40 class=xl43 style='height:30.0pt' >DATE : <%=dtDate %></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td class=xl27></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td rowspan=2 height=89 class=xl46 width=106 style='border-bottom:1.0pt solid black;
  height:66.75pt;border-top:none;width:80pt'>WI NO.</td>
  <td rowspan=2 class=xl44 width=116 style='border-bottom:1.0pt solid black;
  border-top:none;width:87pt'>ITEM CLASS</td>
  <td colspan=7 class=xl48 style='border-right:2.0pt double black;border-left:
  none'>INPUT SPEC</td>
  <td colspan=4 class=xl51 style='border-right:.5pt solid black;border-left:
  none'>OUTPUT SPEC</td>
  <td rowspan=2 class=xl46 width=134 style='border-bottom:1.0pt solid black;
  width:101pt'>CUTTING TYPE</td>
  <td rowspan=2 class=xl53 width=233 style='border-bottom:1.0pt solid black;
  width:175pt'>REMARK</td>
 </tr>
 <tr height=51 style='mso-height-source:userset;height:38.25pt'>
  <td height=51 class=xl30 style='height:38.25pt;border-top:none;border-left:
  none'>TREATMENT</td>
  <td class=xl31 width=161 style='border-top:none;border-left:none;width:121pt'>CLASSIFICATION</td>
  <td class=xl30 style='border-top:none;border-left:none'>THICKNESS</td>
  <td class=xl30 style='border-top:none;border-left:none'>WIDTH</td>
  <td class=xl30 style='border-top:none;border-left:none'>LENGTH</td>
  <td class=xl30 style='border-top:none;border-left:none'>ROLL</td>
  <td class=xl32 style='border-top:none;border-left:none'>WEIGHT</td>
  <td class=xl33 style='border-top:none;border-left:none'>WIDTH</td>
  <td class=xl30 style='border-top:none;border-left:none'>LENGTH</td>
  <td class=xl30 style='border-top:none;border-left:none'>ROLL</td>
  <td class=xl30 style='border-top:none;border-left:none'>WEIGHT</td>
 </tr>
 <%
     string l_pk ;
     int rowsum = 1;
     
     if (dt.Rows.Count > 0)
     {
         rowsum = dt.Rows.Count;
         for (int i = 0; i < dt.Rows.Count; i++)
         {
             l_pk = (string)dt.Rows[i]["tpr_workins_pk"].ToString();

        SQL
        = "SELECT sale.sf_get_dsbs00013_2 (5, a.tco_item_pk) width, " +
            "       sale.sf_get_dsbs00013_2 (6, a.tco_item_pk) i_length, a.att07 roll, " +
            "         a.att07 " +
            "       * sale.sf_get_dsbs00010_2 (4, a.tco_item_pk) " +
            "       * sale.sf_get_dsbs00010_2 (5, a.tco_item_pk) " +
            "       * sale.sf_get_dsbs00010_2 (6, a.tco_item_pk) " +
            "       * prod.sf_get_gravity (a.tco_item_pk, NULL) weight, " +
            "       '' cutting_type, '' description " +
            "  FROM prod.tpr_workinsd a " +
            " WHERE a.del_if = 0 and a.TPR_WORKINS_PK = '" + l_pk + "'";
             
             DataTable dtl = ESysLib.TableReadOpen(SQL);
             int rowsp = dtl.Rows.Count > 0 ? dtl.Rows.Count : 1;
             if (dtl.Rows.Count > 0) rowsum = rowsum + dtl.Rows.Count - 1;
  %>
 
 <tr style='mso-height-source:userset;height:30pt'>
  <td rowspan=<%=rowsp %>  class=xl55 width=106 style='border-bottom:.5pt solid black;
  border-top:none;width:80pt'><%=dt.Rows[i]["wi_no"]%></td>
  <td rowspan=<%=rowsp %> class=xl57 width=116 style='border-bottom:.5pt solid black;
  border-top:none;width:87pt'><%=dt.Rows[i]["item_class"]%></td>
  <td rowspan=<%=rowsp %> class=xl35 style='border-bottom:.5pt solid black;border-top:
  none;border-left:none'><%=dt.Rows[i]["treatment"]%></td>
  <td rowspan=<%=rowsp %> class=xl35 style='border-bottom:.5pt solid black;border-top:
  none'><%=dt.Rows[i]["classfication"]%></td>
  <td rowspan=<%=rowsp %> class=xl59 style='border-bottom:.5pt solid black;border-top:
  none' x:num><%=dt.Rows[i]["thickness"]%> </td>
  <td rowspan=<%=rowsp %> class=xl59 style='border-bottom:.5pt solid black;border-top:
  none' x:num><%=dt.Rows[i]["width"]%> </td>
  <td rowspan=<%=rowsp %> class=xl59 style='border-bottom:.5pt solid black;border-top:
  none' x:num><%=dt.Rows[i]["i_length"]%> </td>
  <td rowspan=<%=rowsp %> class=xl59 style='border-bottom:.5pt solid black;border-top:
  none' x:num><%=dt.Rows[i]["roll"]%> </td>
  <td rowspan=<%=rowsp %> class=xl60 style='border-bottom:.5pt solid black;border-top:
  none' x:num ><%=dt.Rows[i]["weight"]%> </td>
  <td class=xl61 style='border-top:none;border-left:none' x:num><%if (rowsp  > 0) %> <%=dtl.Rows[0]["width"]%>  </td>
  <td class=xl62 style='border-top:none;border-left:none' x:num><%if (rowsp  > 0) %> <%=dtl.Rows[0]["i_length"]%> </td>
  <td class=xl62 style='border-top:none;border-left:none' x:num><%if (rowsp  > 0) %> <%=dtl.Rows[0]["roll"]%></td>
  <td class=xl63 style='border-top:none;border-left:none' x:num><%if (rowsp  > 0) %> <%=dtl.Rows[0]["weight"]%></td>
  <td class=xl64 style='border-left:none'><%if (rowsp  > 0) %> <%=dtl.Rows[0]["cutting_type"]%></td>
  <td class=xl65 style='border-left:none'><%if (rowsp  > 0) %> <%=dtl.Rows[0]["description"]%></td>    
 </tr> 
   <%
       
     for (int j = 1; j < dtl.Rows.Count; j++)
     {          
   %>
  <tr style='mso-height-source:userset;height:30pt'>
  <td class=xl61 style='border-top:none;border-left:none' x:num><%=dtl.Rows[j]["width"]%> </td>
  <td class=xl62 style='border-top:none;border-left:none' x:num><%=dtl.Rows[j]["i_length"]%> </td>
  <td class=xl62 style='border-top:none;border-left:none' x:num><%=dtl.Rows[j]["roll"]%></td>
  <td class=xl63 style='border-top:none;border-left:none' x:num><%=dtl.Rows[j]["weight"]%></td>
  <td class=xl64 style='border-left:none'><%=dtl.Rows[j]["cutting_type"]%></td>
  <td class=xl65 style='border-left:none'><%=dtl.Rows[j]["description"]%></td>
  </tr>
  <%
     }
      
  %>
  
 <%
     }
 }
 else
 {    
 %>
 <tr height=38 style='mso-height-source:userset;height:30pt'>
  <td height=38 class=xl37 width=106 style='height:28.5pt;width:80pt'>&nbsp;</td>
  <td class=xl36 width=116 style='border-top:none;width:87pt'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num></td>
  <td class=xl70 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num</td>
  <td class=xl39 style='border-left:none'>&nbsp;</td>
  <td class=xl40 style='border-left:none'>&nbsp;</td>
 </tr>
 <% 
     }
  %>
 <tr height=38 style='mso-height-source:userset;height:30pt'>
  <td height=38 class=xl37 width=106 style='height:28.5pt;width:80pt'>&nbsp;</td>
  <td class=xl36 width=116 style='border-top:none;width:87pt'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(I7:I<%=7+rowsum-1 %>)"> </td>
  <td class=xl70 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(M7:M<%=7+rowsum-1 %>)"></td>
  <td class=xl39 style='border-left:none'>&nbsp;</td>
  <td class=xl40 style='border-left:none'>&nbsp;</td>
 </tr>
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=106 style='width:80pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=161 style='width:121pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=134 style='width:101pt'></td>
  <td width=233 style='width:175pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
