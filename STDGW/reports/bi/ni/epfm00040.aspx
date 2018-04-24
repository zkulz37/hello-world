<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser("prod");%>
<% 	
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";	
%>


<%
    string l_request_pk = "";
    string l_company_pk = "";
    string year = "", month = "", day = "";
    string l_company = "", l_voucher_no = "", l_request_date = "", l_charger = "", l_line = "", l_remark = "";
    DataTable dt;

    l_request_pk = Request.QueryString["request_pk"];
    l_company_pk = Request.QueryString["company_pk"];

    dt = ESysLib.TableReadOpenCursor("INV.sp_rpt_epfm00040", "'" + l_company_pk + "'");
    if(dt.Rows.Count>0)
        l_company=dt.Rows[0][0].ToString();
    //Response.Write(dt.Rows[0][0].ToString());
    //Response.End();
    dt = ESysLib.TableReadOpenCursor("INV.sp_rpt_epfm00040_1", l_request_pk);
    if (dt.Rows.Count > 0)
    {
        l_voucher_no = dt.Rows[0][0].ToString();
        l_request_date = dt.Rows[0][1].ToString();
        year = l_request_date.Substring(0, 4);
        month = l_request_date.Substring(4, 2);
        day = l_request_date.Substring(6, 2);
        l_charger = dt.Rows[0][2].ToString();
        l_remark = dt.Rows[0][3].ToString();
        l_line = dt.Rows[0][4].ToString();
        
    }
    DataTable dttb = ESysLib.TableReadOpenCursor("INV.sp_rpt_epfm00040_2", l_request_pk);
         
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Mat_Issue_files/filelist.xml">
<link rel=Edit-Time-Data href="Mat_Issue_files/editdata.mso">
<link rel=OLE-Object-Data href="Mat_Issue_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Daewon</o:Author>
  <o:LastAuthor>QuangNguyen</o:LastAuthor>
  <o:LastPrinted>2009-10-02T03:59:40Z</o:LastPrinted>
  <o:Created>2009-01-17T08:50:03Z</o:Created>
  <o:LastSaved>2009-10-02T04:00:13Z</o:LastSaved>
  <o:Company>Microsoft Corporation</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.17in .26in .18in .25in;
	mso-header-margin:.17in;
	mso-footer-margin:.16in;
	mso-horizontal-page-align:center;}
.font5
	{color:windowtext;
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;}
.font6
	{color:windowtext;
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font7
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font11
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font12
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font13
	{color:#333333;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font14
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;}
.font15
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font16
	{color:gray;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font17
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;}
.font18
	{color:#333333;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font22
	{color:#969696;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0;
	mso-generic-font-family:auto;
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	text-align:right;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	color:#333333;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	color:#333333;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	color:#333333;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	text-align:left;}
.xl50
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl51
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl52
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl77
	{mso-style-parent:style0;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	text-align:center;}
.xl78
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl80
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
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
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
       <x:ActiveCol>17</x:ActiveCol>
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
  <x:WindowHeight>11250</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>15</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=675 style='border-collapse:
 collapse;table-layout:fixed;width:508pt'>
 <col width=34 style='mso-width-source:userset;mso-width-alt:1243;width:26pt'>
 <col width=137 style='mso-width-source:userset;mso-width-alt:5010;width:103pt'>
 <col width=67 style='mso-width-source:userset;mso-width-alt:2450;width:50pt'>
 <col width=80 style='mso-width-source:userset;mso-width-alt:2925;width:60pt'>
 <col width=26 style='mso-width-source:userset;mso-width-alt:950;width:20pt'>
 <col width=50 style='mso-width-source:userset;mso-width-alt:1828;width:38pt'>
 <col width=36 style='mso-width-source:userset;mso-width-alt:1316;width:27pt'>
 <col width=0 span=3 style='display:none;mso-width-source:userset;mso-width-alt:
 2340'>
 <col width=28 style='mso-width-source:userset;mso-width-alt:1024;width:21pt'>
 <col width=24 style='mso-width-source:userset;mso-width-alt:877;width:18pt'>
 <col width=64 style='width:48pt'>
 <col width=16 style='mso-width-source:userset;mso-width-alt:585;width:12pt'>
 <col width=18 style='mso-width-source:userset;mso-width-alt:658;width:14pt'>
 <col width=95 style='mso-width-source:userset;mso-width-alt:3474;width:71pt'>
 <tr height=70 style='mso-height-source:userset;height:52.5pt'>
  <td colspan=16 height=70 class=xl52 width=675 style='height:52.5pt;
  width:508pt'>&#50896;&#51088;&#51116;<font class="font6"> </font><font
  class="font5">&#48520;&#52636;&#51613;</font><font class="font6">
  (PHI&#7870;U &#272;&#7872; NGH&#7882; XU&#7844;T NGUYÊN V&#7852;T LI&#7878;U
  )<span style='mso-spacerun:yes'>  </span></font></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=5 height=26 class=xl70 width=344 style='height:19.5pt;width:259pt'>&#51068;&#51088;<font
  class="font11"> </font><font class="font16">( Date )</font><font
  class="font11">:<span style='mso-spacerun:yes'>    </span><%= year%></font><font
  class="font14">&#45380;</font><font class="font11"><span
  style='mso-spacerun:yes'>     </span><%= month %><span style='mso-spacerun:yes'>   
  </span></font><font class="font14">&#50900;</font><font class="font11"><span
  style='mso-spacerun:yes'>     </span><%= day %><span style='mso-spacerun:yes'>     
  </span></font><font class="font14">&#51068;</font><font class="font12"><span
  style='mso-spacerun:yes'>                              </span></font><font
  class="font7"><span style='mso-spacerun:yes'>          </span></font></td>
  <td class=xl40>&nbsp;</td>
  <td colspan=6 class=xl59 width=88 style='border-right:.5pt solid black;
  border-left:none;width:66pt'>&#45812; &#45817;</td>
  <td colspan=3 class=xl59 width=98 style='border-right:.5pt solid black;
  border-left:none;width:74pt'>&#44160; &#53664;</td>
  <td class=xl38 width=95 style='border-left:none;width:71pt'>&#49849;<font
  class="font11"> </font><font class="font14">&#51064;</font></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td colspan=5 height=35 class=xl57 width=344 style='height:26.25pt;
  width:259pt'>&#46972;&#51064; <font class="font22">(Line)</font><font
  class="font14"> : <%= l_line %></font></td>
  <td class=xl40>&nbsp;</td>
  <td colspan=6 class=xl71 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl24 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=5 height=19 class=xl57 width=344 style='height:14.25pt;
  width:259pt'>&#51204;&#54364; &#48264;&#54840; <font class="font22">(No)</font><font
  class="font14"> : <%= l_voucher_no %></font></td>
  <td class=xl40>&nbsp;</td>
  <td colspan=6 class=xl74 style='border-right:.5pt solid black;border-left:
  none'>/</td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>/</td>
  <td class=xl25 style='border-top:none;border-left:none'>/</td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td colspan=5 height=36 class=xl58 style='height:27.0pt'><%= "*" + l_voucher_no + "*" %></td>
  <td class=xl40>&nbsp;</td>
  <td colspan=6 class=xl71 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl24 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl41 style='height:15.0pt'>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td colspan=6 class=xl74 style='border-right:.5pt solid black;border-left:
  none'>/</td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>/</td>
  <td class=xl26 style='border-top:none;border-left:none'>/</td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td rowspan=3 height=56 class=xl46 style='border-bottom:.5pt solid black;
  height:42.0pt;border-top:none'>No.</td>
  <td rowspan=2 class=xl62 style='border-top:none'>&#54408;&#47749;<br>
    <font class="font13"><span style='mso-spacerun:yes'> </span></font></td>
  <td rowspan=2 class=xl62 style='border-top:none'>&#45800;&#50948; <br>
    </td>
  <td colspan=2 rowspan=2 class=xl64 width=106 style='border-right:.5pt solid black;
  width:80pt'>&#50836;&#52397;</td>
  <td colspan=7 rowspan=2 class=xl64 width=138 style='border-right:.5pt solid black;
  width:104pt'>&#48152;&#52636;</td>
  <td colspan=4 rowspan=2 class=xl64 width=193 style='border-right:.5pt solid black;
  width:145pt'>&#48708;&#44256;</td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl39 style='height:18.0pt;border-left:none'>TÊN HÀNG</td>
  <td class=xl39 style='border-left:none'>&#272;&#416;N V&#7882;</td>
  <td colspan=2 class=xl43 width=106 style='border-right:.5pt solid black;
  border-left:none;width:80pt'>YÊU V&#7846;U</td>
  <td colspan=7 class=xl78 style='border-right:.5pt solid black;border-left:
  none'>L&#431;&#7906;NG XU&#7844;T</td>
  <td colspan=4 class=xl43 width=193 style='border-right:.5pt solid black;
  border-left:none;width:145pt'>GHI CHÚ</td>
 </tr>
 
 <%    
            for (int i = 0; i <= dttb.Rows.Count - 1; i++)
            {
                DataTable dtLoc = ESysLib.TableReadOpenCursor("INV.sp_rpt_epfm00040_3",dttb.Rows[i][6].ToString());
                string availableLoc = "";
                for (int idx = 0; idx < dtLoc.Rows.Count; idx++)
                {
                    availableLoc = dtLoc.Rows[idx][0] + ", ";
                }

  %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl30 style='height:17.25pt;border-top:none' x:num><%= i+1 %></td>
  <td class=xl24 style='border-top:none;border-left:none'><%= dttb.Rows[i][0].ToString() %></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dttb.Rows[i][3].ToString() %></td>
  <td colspan=2 class=xl54 style='border-right:.5pt solid black;border-left:
  none'><%= dttb.Rows[i][4].ToString() %></td>
  <td colspan=7 class=xl54 style='border-right:.5pt solid black;border-left:
  none'></td>
  <td colspan=4 class=xl54 style='border-right:.5pt solid black;border-left:
  none'><%= availableLoc %></td>
 </tr>
 <%
            }
        %>
        <%
            for (int i = 0; i < 26 - dttb.Rows.Count; i++)
            {     
        %>
  <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl30 style='height:17.25pt;border-top:none' x:num></td>
  <td class=xl24 style='border-top:none;border-left:none'></td>
  <td class=xl26 style='border-top:none;border-left:none'></td>
  <td colspan=2 class=xl54 style='border-right:.5pt solid black;border-left:
  none'></td>
  <td colspan=7 class=xl54 style='border-right:.5pt solid black;border-left:
  none'></td>
  <td colspan=4 class=xl54 style='border-right:.5pt solid black;border-left:
  none'></td>
 </tr>
 <%} %>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl49 style='height:15.75pt'>&#50689;&#49688;&#51088;<font
  class="font15"> </font><font class="font18">(Receiver)</font><font
  class="font15"> :</font></td>
  <td class=xl31 style='border-top:none'>&nbsp;</td>
  <td class=xl32>&#52636;<font class="font15"> </font><font class="font17">&#44256;</font><font
  class="font15"> </font><font class="font17">&#45812;</font><font
  class="font15"> </font><font class="font17">&#45817;</font><font
  class="font18"> (Issue)</font></td>
  <td class=xl32></td>
  <td class=xl31 style='border-top:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none'>&nbsp;</td>
  <td colspan=7 class=xl51><%= l_company %></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td colspan=2 height=25 class=xl49 style='height:18.75pt'><%= l_charger %></td>
  <td class=xl35></td>
  <td class=xl32>&#51088;&#51116;&#48372;&#44288;<font class="font15"> (For C/S
  team)</font></td>
  <td class=xl32></td>
  <td colspan=3 class=xl36 style='mso-ignore:colspan'></td>
  <td class=xl37></td>
  <td colspan=7 class=xl51></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl27 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl77></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=6 class=xl28 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=34 style='width:26pt'></td>
  <td width=137 style='width:103pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=36 style='width:27pt'></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=28 style='width:21pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=16 style='width:12pt'></td>
  <td width=18 style='width:14pt'></td>
  <td width=95 style='width:71pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
