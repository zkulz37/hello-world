<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<%  Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
    
    string p_Project_Pk = Request.QueryString["Project_Pk"];
    string p_Project_Nm = Request.QueryString["Project_Nm"];
    string p_Customer_Pk = Request.QueryString["Customer_Pk"];
    string p_Customer_Nm = Request.QueryString["Customer_Nm"];
    string p_Status = Request.QueryString["Status"];
    string p_From = Request.QueryString["From"];
    string p_To = Request.QueryString["To"];
    string p_user_pk =  Request.QueryString["p_user_pk"];
    string l_parameter = "'" + p_Project_Pk + "', ";
    l_parameter += "'" + p_Customer_Pk + "', ";
    l_parameter += "'" + p_Status + "', ";
    l_parameter += "'" + p_From + "', ";
    l_parameter += "'" + p_To + "' , ";
	 l_parameter += "'" + p_user_pk + "' ";
    DataTable dt = ESysLib.TableReadOpenCursor("sp_sel_kpbp1210", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data!!");
        Response.End();
    }
    
    if (p_Status == "1") 
    { 
        p_Status = "Save"; 
    }
    else if (p_Status == "2") 
    { 
        p_Status = "Confirm"; 
    } 
    else 
    { 
        p_Status = "ALL"; 
    }

    p_From = p_From.Substring(6,2)+"/"+p_From.Substring(4,2)+"/"+p_From.Substring(0,4);
    p_To = p_To.Substring(6, 2) + "/" + p_To.Substring(4, 2) + "/" + p_To.Substring(0, 4);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Copy%20of%20ARLIST%20(8)_files/filelist.xml">
<link rel=Edit-Time-Data href="Copy%20of%20ARLIST%20(8)_files/editdata.mso">
<link rel=OLE-Object-Data href="Copy%20of%20ARLIST%20(8)_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>linhtta</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2011-09-20T09:14:51Z</o:LastPrinted>
  <o:Created>2011-09-15T07:35:57Z</o:Created>
  <o:LastSaved>2011-09-20T09:32:40Z</o:LastSaved>
  <o:Company>VNG</o:Company>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.28in .17in .16in .17in;
	mso-header-margin:.3in;
	mso-footer-margin:.16in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style43
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:Comma;
	mso-style-id:3;}
.style45
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:"Comma 2";}
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
.xl72
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl75
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl77
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl78
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl80
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl81
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl83
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl84
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl85
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl87
	{mso-style-parent:style45;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl88
	{mso-style-parent:style45;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl89
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;}
.xl90
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl92
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl93
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl94
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl95
	{mso-style-parent:style0;
	color:blue;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl96
	{mso-style-parent:style0;
	color:blue;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl97
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style45;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl99
	{mso-style-parent:style0;
	color:blue;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl100
	{mso-style-parent:style0;
	color:blue;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl101
	{mso-style-parent:style0;
	color:blue;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl102
	{mso-style-parent:style0;
	color:blue;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl103
	{mso-style-parent:style0;
	color:blue;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl104
	{mso-style-parent:style43;
	color:blue;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl105
	{mso-style-parent:style0;
	color:blue;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl106
	{mso-style-parent:style0;
	color:blue;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl107
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl108
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl109
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl110
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>AR list</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>342</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>53</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>12</x:SplitHorizontal>
     <x:TopRowBottomPane>12</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8130</x:WindowHeight>
  <x:WindowWidth>18975</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:TabRatio>398</x:TabRatio>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:SupBook>
  <x:Path>\\192.168.1.6\Accounting_Backup\posco e&amp;c\CONTRACT\customer_Communication_History1.xlsx</x:Path>
  <x:SheetName>Bugs Log</x:SheetName>
  <x:SheetName>Configuration</x:SheetName>
  <x:SheetName>Analysis</x:SheetName>
  <x:SheetName>Plan</x:SheetName>
  <x:SheetName>Sheet1</x:SheetName>
  <x:SheetName>Sheet2</x:SheetName>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>0</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>62</x:Count>
   <x:SheetIndex>1</x:SheetIndex>
   <x:Crn>
    <x:Row>1</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.0.1 Entry Subcontractor</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>2</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.0.4 Inquiry subcontractor</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>3</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.0.5 Contract registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>4</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;Change Budget Period</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>5</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.0.7 Level code registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>6</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.0.8 Capacity</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>7</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;Register Standard Expenses Item</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>8</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.0.9 Size Code Entry</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>9</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;Register Budget Item</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>10</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.0.10 Facilities Entry</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>11</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.0.11 Work Division Entry</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>12</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.1.1 Project Summary Mgmt</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>13</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.1.2 Project Status Search</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>14</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.1.3 Project Search By Scale Value</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>15</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.2.1 Contract serial No. Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>16</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.2.2 Contract details EXCEL UPLOAD</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>17</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.2.3 Contract details registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>18</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.2.4 Contract O/H expenses registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>19</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.2.5 Contract deteails search/print</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>20</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.2.6 Contract progress payment registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>21</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.2.7 Register legally allowed Expenses of Main Contract</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>22</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.1 Placement Order Work Division Code</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>23</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.2 Budget Cost of Work Schedule(BCWS) Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>24</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.3 BCWS Period Change</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>25</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.4 [Contructtion]Working Details EXCEL UPLOAD</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>26</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.5 BCWS Details Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>27</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.6 Inputed Personnel Man Hour Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>28</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.7 Working Legal O/H Expenses Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>29</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.8 Working Expense Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>30</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.9 Working O/H Cost Caculation</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>31</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.11 Working Details Search by Work Division</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>32</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.12 BCWS Print-Out By Item of Expenditure</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>33</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.13 BCWS Summary Search Approval</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>34</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.14 [Contruction] Working Details Search By Conditions</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>35</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.2.1 Adjustment Serial No. Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>36</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.2.2 Adjustment Details Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>37</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.2.3 Adjustted Input Personnel Man Hour Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>38</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.2.4 Adjusted Legal O/H Expenses Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>39</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.2.5 Adjusted Expense Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>40</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.2.6 Adjusted O/H Cost Caculation</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>41</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.2.7 Adjustment Approval Details Search</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>42</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.2.8 Adjusted BCWS Print-Out By Item of Expenditure</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>43</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.2.9 Adjusted BCWS Summary Search Approval</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>44</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.2.10 [Construction] Working Details Standard Code Revision</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>45</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;3.1.1 SubContract List</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>46</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;3.1.2 SubContract Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>47</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;3.1.3 Changed SubContract Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>48</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;3.1.4 Inspection Report Input for P/P</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>49</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;3.1.5 Outsourcing Cumulative P/P Search</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>50</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;4.1.1 Expenditure Issue Input</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>51</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;4.1.2 Actual Result of Advanced Money</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>52</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;4.1.3 None - Payment Repay</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>53</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;4.1.4 Actual Result of Corporation Card</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>54</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;5.1.1 Progress Plan Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>55</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;5.2.1 Actual Result Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>56</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;Inquiry Input Cost</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>57</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;Inquiry Project Status</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>58</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;Inquiry Profit &amp; Loss of Project</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>59</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;Inquiry Budget</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>60</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;Subcontract Status</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>61</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;6.2.1 Expected completion cost</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>62</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;6.2.2 Expected completion cost approval</x:Text>
   </x:Crn>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>2</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>3</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>4</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>5</x:SheetIndex>
  </x:Xct>
 </x:SupBook>
 <x:ExcelName>
  <x:Name>SCREENS</x:Name>
  <x:Formula>='\\192.168.1.6\Accounting_Backup\posco e&amp;c\CONTRACT\[customer_Communication_History1.xlsx]Configuration'!$B$2:$B$65460</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl72>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2147 style='border-collapse:
 collapse;table-layout:fixed;width:1611pt'>
 <col class=xl25 width=13 style='mso-width-source:userset;mso-width-alt:475;
 width:10pt'>
 <col class=xl25 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl26 width=126 style='mso-width-source:userset;mso-width-alt:4608;
 width:95pt'>
 <col class=xl25 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl27 width=180 style='mso-width-source:userset;mso-width-alt:6582;
 width:135pt'>
 <col class=xl25 width=144 style='mso-width-source:userset;mso-width-alt:5266;
 width:108pt'>
 <col class=xl25 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col class=xl25 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl25 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl25 width=60 style='mso-width-source:userset;mso-width-alt:2194;
 width:45pt'>
 <col class=xl25 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col class=xl25 width=107 span=3 style='mso-width-source:userset;mso-width-alt:
 3913;width:80pt'>
 <col class=xl25 width=123 style='mso-width-source:userset;mso-width-alt:4498;
 width:92pt'>
 <col class=xl25 width=107 style='mso-width-source:userset;mso-width-alt:3913;
 width:80pt'>
 <col class=xl25 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl25 width=120 style='mso-width-source:userset;mso-width-alt:4388;
 width:90pt'>
 <col class=xl25 width=132 style='mso-width-source:userset;mso-width-alt:4827;
 width:99pt'>
 <col class=xl25 width=215 style='mso-width-source:userset;mso-width-alt:7862;
 width:161pt'>
 <tr height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 class=xl72 width=13 style='height:9.75pt;width:10pt'></td>
  <td class=xl72 width=62 style='width:47pt'></td>
  <td class=xl73 width=126 style='width:95pt'></td>
  <td class=xl72 width=74 style='width:56pt'></td>
  <td class=xl74 width=131 style='width:98pt'></td>
  <td class=xl72 width=144 style='width:108pt'></td>
  <td class=xl72 width=93 style='width:70pt'></td>
  <td class=xl72 width=61 style='width:46pt'></td>
  <td class=xl72 width=73 style='width:55pt'></td>
  <td class=xl72 width=60 style='width:45pt'></td>
  <td class=xl72 width=103 style='width:77pt'></td>
  <td class=xl72 width=103 style='width:77pt'></td>
  <td class=xl72 width=103 style='width:77pt'></td>
  <td class=xl72 width=103 style='width:77pt'></td>
  <td class=xl72 width=123 style='width:92pt'></td>
  <td class=xl72 width=103 style='width:77pt'></td>
  <td class=xl72 width=103 style='width:77pt'></td>
  <td class=xl72 width=120 style='width:90pt'></td>
  <td class=xl72 width=132 style='width:99pt'></td>
  <td class=xl72 width=98 style='width:74pt'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl72 style='height:17.1pt'></td>
  <td class=xl75>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl72 style='height:17.1pt'></td>
  <td colspan=19 class=xl99 style='border-right:.5pt solid black'>ACCOUNT RECEIVABLE LIST</td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl72 style='height:9.0pt'></td>
  <td class=xl81>&nbsp;</td>
  <td class=xl73></td>
  <td class=xl82></td>
  <td class=xl83></td>
  <td colspan=14 class=xl72 style='mso-ignore:colspan'></td>
  <td class=xl84>&nbsp;</td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl72 style='height:14.1pt'></td>
  <td class=xl85>Customer:</td>
  <td class=xl110 colspan=2 style='mso-ignore:colspan'><%=p_Customer_Nm %></td>
  <td class=xl86></td>
  <td colspan=5 class=xl73 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl72 style='mso-ignore:colspan'></td>
  <td class=xl84>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl72 style='height:17.1pt'></td>
  <td class=xl85>Project:</td>
  <td class=xl110 colspan=2 style='mso-ignore:colspan'><%=p_Project_Nm %></td>
  <td class=xl86></td>
  <td colspan=5 class=xl73 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl72 style='mso-ignore:colspan'></td>
  <td class=xl84>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl72 style='height:17.1pt'></td>
  <td class=xl85>Status ( issue red bill)</td>
  <td class=xl73></td>
  <td class=xl72 colspan=2 style='mso-ignore:colspan'  ><%=p_Status%> </td>
  <td colspan=7 class=xl72 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl87 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl72 style='mso-ignore:colspan'></td>
  <td class=xl84>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl72 style='height:17.1pt'></td>
  <td class=xl85>Transaction date:</td>
  <td class=xl73></td>
  <td class=xl73>Fr.</td>
  <td class=xl86 ><%=p_From %></td>
  <td class=xl72>To. <%=p_To %></td>
  <td colspan=6 class=xl72 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl87 style='mso-ignore:colspan'></td>
  <td class=xl88></td>
  <td colspan=4 class=xl72 style='mso-ignore:colspan'></td>
  <td class=xl84>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl72 style='height:17.1pt'></td>
  <td class=xl85>&nbsp;</td>
  <td class=xl89></td>
  <td class=xl72></td>
  <td class=xl74></td>
  <td colspan=14 class=xl72 style='mso-ignore:colspan'></td>
  <td class=xl84>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl72 style='height:17.1pt'></td>
  <td class=xl90>&nbsp;</td>
  <td class=xl91>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl93>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl94>&nbsp;</td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl72 style='height:26.25pt'></td>
  <td rowspan=2 class=xl95 width=62 style='width:47pt'>Project code</td>
  <td rowspan=2 class=xl102 width=126 style='border-bottom:.5pt solid black;  width:95pt'>Project name</td>
  <td rowspan=2 class=xl102 width=74 style='border-bottom:.5pt solid black;  width:56pt'>Project field</td>
  <td rowspan=2 class=xl104 x:str="Customer">Customer</td>
  <td rowspan=2 class=xl96>Payment method</td>
  <td rowspan=2 class=xl95 width=93 style='width:70pt'>Req. type</td>
  <td colspan=5 class=xl96 style='border-left:none' x:str="Claimed Amount ">Claimed Amount</td>
  <td rowspan=2 class=xl102 width=103 style='border-bottom:.5pt solid black;  width:77pt'>Deduct Advance</td>
  <td rowspan=2 class=xl96>Retention</td>
  <td colspan=2 class=xl96 style='border-left:none'>This time payment</td>
  <td rowspan=2 class=xl105 style='border-bottom:.5pt solid black'>Plan receive</td>
  <td rowspan=2 class=xl102 width=120 style='border-bottom:.5pt solid black;  width:90pt'>Trans AMT (VND)</td>
  <td rowspan=2 class=xl102 width=132 style='border-bottom:.5pt solid black;  width:99pt'>Book AMT (USD)</td>
  <td rowspan=2 class=xl105 style='border-bottom:.5pt solid black'>Remark</td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl72 style='height:26.25pt'></td>
  <td class=xl95 width=61 style='border-top:none;border-left:none;width:46pt'>Req. No.</td>
  <td class=xl95 width=73 style='border-top:none;border-left:none;width:55pt'>Date</td>
  <td class=xl96 style='border-top:none;border-left:none'>CCY</td>
  <td class=xl96 style='border-top:none;border-left:none'>( Net )</td>
  <td class=xl96 style='border-top:none;border-left:none'>( VAT )</td>
  <td class=xl96 style='border-top:none;border-left:none'>( Net )</td>
  <td class=xl96 style='border-top:none;border-left:none'>( VAT )</td>
 </tr>
 <%
     
     int i = 0;
     for(i=0;i<dt.Rows.Count;i++)
     {
				
  %>
 <tr height=24 style='mso-height-source:auto;height:18.0pt'>
  <td height=24 class=xl72 style='height:18.0pt'></td>
  <td class=xl97 style='border-top:none'><%=dt.Rows[i][3]%></td>
  <td class=xl107 width=126 style='border-top:none;border-left:none;width:95pt'><%=dt.Rows[i][4]%></td>
  <td class=xl97 style='border-top:none;border-left:none'><%=dt.Rows[i][5]%></td>
  <td class=xl108 width=131 style='border-top:none;border-left:none;width:98pt' ><%=dt.Rows[i][6]%></td>
  <td class=xl107 width=144 style='border-top:none;border-left:none;width:108pt' ><%=dt.Rows[i][7]%></td>
  <td class=xl97 style='border-top:none;border-left:none'><%=dt.Rows[i][8]%></td>
  <td class=xl109 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9]%></td>
  <td class=xl109 style='border-top:none;border-left:none'><%=dt.Rows[i][10]%></td>
  <td class=xl109 style='border-top:none;border-left:none'><%=dt.Rows[i][11]%></td>
  <td class=xl98 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][12]%></td>
  <td class=xl98 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][13]%></td>
  <td class=xl98 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][14]%></td>
  <td class=xl98 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][15]%></td>
  <td class=xl98 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][16]%></td>
  <td class=xl98 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][17]%></td>
  <td class=xl98 style='border-top:none;border-left:none'><%=dt.Rows[i][18]%></td>
  <td class=xl98 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][19]%></td>
  <td class=xl98 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][20]%></td>
  <td class=xl107 width=98 style='border-top:none;border-left:none;width:74pt'><%=dt.Rows[i][21]%></td>
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=13 style='width:10pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=144 style='width:108pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=120 style='width:90pt'></td>
  <td width=132 style='width:99pt'></td>
  <td width=98 style='width:74pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
