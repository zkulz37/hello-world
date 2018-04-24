<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string l_company_pk = ""+Request["company_pk"];
    string l_emp_pk = ""+Request["emp_pk"];//ALL =''
    string l_from_date =""+Request["from_date"];
    string l_to_date = ""+Request["to_date"];
    string l_status =""+Request["status"];
    string l_acc_pk =""+Request["acc_pk"];
    string l_trans_book =""+Request["Trans"];
    string l_book_ccy = "" + Request["BookCCy"]; 
    string SQL = "";

    //l_trans_book = "BOOK";
    string l_cmp_name = "";
    string l_cmp_add = "";
    string l_cmp_taxcode = ""; 
    string l_rpt_date1 = "";
    string l_rpt_date2 = "";
    string l_rpt_date3 = "";
    string l_rpt_date4 = "";
    string l_rpt_date5 = "";
    string l_rpt_drcr = "";
    string l_rpt_drcr_num = ""; 
    int i =0;
    SQL = " SELECT partner_lname, addr2, tax_code,TO_CHAR(TO_DATE('" + l_from_date + "','YYYYMMDD'),'DD/MM/YYYY') DT1,TO_CHAR(TO_DATE('" + l_to_date + "','YYYYMMDD'),'DD/MM/YYYY') DT2, TO_CHAR(SYSDATE,'DD') DT3,TO_CHAR(SYSDATE,'MM') DT4,TO_CHAR(SYSDATE,'YYYY') DT5  FROM tco_company WHERE pk = " + l_company_pk;
    DataTable dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count > 0)
    {
        l_cmp_name = dt.Rows[0][0].ToString();
        l_cmp_add = dt.Rows[0][1].ToString();
        l_cmp_taxcode = dt.Rows[0][2].ToString();
        l_rpt_date1 = dt.Rows[0][3].ToString();
        l_rpt_date2 = dt.Rows[0][4].ToString();
        l_rpt_date3 = dt.Rows[0][5].ToString();
        l_rpt_date4 = dt.Rows[0][6].ToString();
        l_rpt_date5 = dt.Rows[0][7].ToString();
    }
    SQL = "select DRCR_TYPE,TO_NUMBER(DECODE(DRCR_TYPE,'D','1','C','-1','1')) from  tac_abacctcode where pk =" + l_acc_pk;
    dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count > 0)
    {
        l_rpt_drcr = dt.Rows[0][0].ToString();
        l_rpt_drcr_num = dt.Rows[0][1].ToString();
    }
    
   String p_xls_ccy_format_vnd ="";
   String p_xls_ccy_format_usd = ""; 
   p_xls_ccy_format_vnd = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
   p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
   String p_xls_ccy_format = "";


 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00150_tonghop_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00150_tonghop_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00150_tonghop_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>MS HOA</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2008-10-31T06:51:15Z</o:LastPrinted>
  <o:Created>2006-07-04T07:25:31Z</o:Created>
  <o:LastSaved>2008-10-31T06:52:08Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.25in .25in .5in .25in;
	mso-header-margin:.25in;
	mso-footer-margin:0in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style21
	{mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	mso-style-name:"Comma_Mau cac so ke toan \!";}
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
.style22
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
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"Normal_Mau cac so ke toan \!";}
td
	{mso-style-parent:style0;
	padding:0px;
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
.xl26
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style22;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style22;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style22;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl32
	{mso-style-parent:style22;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl34
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style21;
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
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl46
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl47
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl49
	{mso-style-parent:style22;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl50
	{mso-style-parent:style22;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style22;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl52
	{mso-style-parent:style22;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl53
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl54
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl55
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl56
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl57
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:silver;
	mso-pattern:auto none;}
.xl58
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl59
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl60
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl61
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl62
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl63
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl65
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl66
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl67
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl68
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl69
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl71
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>T&#7841;m &#7912;ng</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>375</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>96</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>8</x:SplitHorizontal>
     <x:TopRowBottomPane>8</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>21</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11505</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>285</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='T&#7841;m &#7912;ng'!$A$8:$K$8</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='T&#7841;m &#7912;ng'!$7:$8</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1036"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl26>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1056 style='border-collapse:
 collapse;table-layout:fixed;width:791pt'>
 <col class=xl26 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl26 width=59 style='mso-width-source:userset;mso-width-alt:2157;
 width:44pt'>
 <col class=xl26 width=219 style='mso-width-source:userset;mso-width-alt:8009;
 width:164pt'>
 <col class=xl26 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl26 width=103 span=6 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <col class=xl26 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl27 colspan=3 width=316 style='height:18.75pt;
  mso-ignore:colspan;width:237pt'><%= l_cmp_name%></td>
  <td class=xl27 width=40 style='width:30pt'></td>
  <td class=xl28 width=103 style='width:77pt'></td>
  <td class=xl28 width=103 style='width:77pt'></td>
  <td class=xl28 width=103 style='width:77pt'></td>
  <td class=xl28 width=103 style='width:77pt'></td>
  <td class=xl28 width=103 style='width:77pt'></td>
  <td class=xl28 width=103 style='width:77pt'></td>
  <td class=xl28 width=82 style='width:62pt'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl27 colspan=3 style='height:18.75pt;mso-ignore:colspan'><%= l_cmp_add %></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl27 colspan=3 style='height:18.75pt;mso-ignore:colspan'>MST : <%= l_cmp_taxcode %></td>
  <td class=xl27></td>
  <td colspan=7 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=11 height=27 class=xl52 style='height:20.25pt'>BÁO CÁO TỔNG HỢP TÌNH HÌNH TẠM ỨNG CÔNG NHÂN VIÊN</td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td colspan=11 height=25 class=xl29 style='height:18.75pt'>Từ ngày <%= l_rpt_date1 %> - <%= l_rpt_date2 %></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 colspan=8 class=xl29 style='height:9.0pt;mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td class=xl30></td>
  <td class=xl32></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td rowspan=2 height=50 class=xl53 width=38 style='border-bottom:.5pt solid black;
  height:37.5pt;width:29pt'>SỐ TT</td>
  <td colspan=2 class=xl56 width=278 style='border-left:none;width:208pt'>ĐỐI TƯỢNG</td>
  <td rowspan=2 class=xl53 width=40 style='border-bottom:.5pt solid black;
  width:30pt'>LOẠI TIỀN</td>
  <td colspan=2 class=xl59 style='border-right:.5pt solid black'>SỐ DƯ ĐẦU KỲ</td>
  <td colspan=2 class=xl57 style='border-right:.5pt solid black;border-left:
  none'>SỐ PHÁT SINH</td>
  <td colspan=2 class=xl57 style='border-right:.5pt solid black;border-left:
  none'>SỐ DƯ CUỐI KỲ</td>
  <td rowspan=2 class=xl61 style='border-bottom:.5pt solid black'>GHI CHÚ</td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl33 id="_x0000_s1026" x:autofilter="all" width=59
  style='height:18.75pt;width:44pt'>MÃ</td>
  <td class=xl70 id="_x0000_s1027" x:autofilter="all" width=219
  style='width:164pt'>TÊN</td>
  <td class=xl34 id="_x0000_s1029" x:autofilter="all">NỢ</td>
  <td class=xl34 id="_x0000_s1030" x:autofilter="all">CÓ</td>
  <td class=xl34 id="_x0000_s1031" x:autofilter="all">NỢ</td>
  <td class=xl34 id="_x0000_s1032" x:autofilter="all">CÓ</td>
  <td class=xl34 id="_x0000_s1033" x:autofilter="all">NỢ</td>
  <td class=xl34 id="_x0000_s1034" x:autofilter="all">CÓ</td>
 </tr>
 <%
      /*
     SQL = "SELECT V.EMP_ID, V.FULL_NAME,E.CCY,  OPEN_D, OPEN_C, E.PS_DEBIT,E.PS_CREDIT,(OPEN_D +PS_DEBIT)  CLOSE_D, (OPEN_C +PS_CREDIT ) CLOSE_C,E.VHR_EMP_PK   " +
             " FROM VHR_EMP V, (  " +
             " SELECT VHR_EMP_PK,CCY, " +
             "SF_GET_EMP_OPENBAL('" + l_company_pk + "'," + l_acc_pk + ",D.VHR_EMP_PK,D.CCY,'" + l_from_date + "','" + l_status + "','D','" + l_trans_book + "') OPEN_D, SF_GET_EMP_OPENBAL('" + l_company_pk + "'," + l_acc_pk + ",D.VHR_EMP_PK,D.CCY,'" + l_from_date + "','" + l_status + "','C','" + l_trans_book + "') OPEN_C," + 
             " SUM(NVL(YMD_DRTRANS,0)) PS_DEBIT, SUM(NVL(YMD_CRTRANS,0)) PS_CREDIT   " +
             " FROM TAC_HGEMPDDBAL D   " +
             " WHERE  D.DEL_IF =0  " +
             " AND D.TR_STATUS =  " + l_status +
             " AND D.TCO_COMPANY_PK = " + l_company_pk +
             " AND D.STD_YMD BETWEEN '" + l_from_date + "' AND '" + l_to_date + "'  " +
             "        AND (('" + l_acc_pk + "' IS NULL) OR (D.TAC_ABACCTCODE_PK = '" + l_acc_pk + "')) " + 
             " GROUP BY VHR_EMP_PK,CCY  " +
             " ) E  " +
             " WHERE V.PK = E.VHR_EMP_PK  " +
             " AND DECODE('" + l_emp_pk + "','',1,'ALL',1,V.PK) = DECODE('" + l_emp_pk + "','',1,'ALL',1,'" + l_emp_pk + "') " +
             " ORDER BY EMP_ID,CCY  ";
  */
/*
     SQL = "SELECT V.EMP_ID, V.FULL_NAME,E.CCY,  decode('" + l_rpt_drcr + "','D',(OPEN_D-OPEN_C),0), decode('" + l_rpt_drcr + "','C',(OPEN_C-OPEN_D),0), E.PS_DEBIT,E.PS_CREDIT,decode('" + l_rpt_drcr + "','D',((OPEN_D +PS_DEBIT)-(OPEN_C +PS_CREDIT )),0)  CLOSE_D, decode('" + l_rpt_drcr + "','C',((OPEN_C +PS_CREDIT )-(OPEN_D +PS_DEBIT)),0) CLOSE_C,E.VHR_EMP_PK   " +
                " FROM VHR_EMP V, (  " +
                " SELECT VHR_EMP_PK,CCY, " +
                "SF_GET_EMP_OPENBAL('" + l_company_pk + "'," + l_acc_pk + ",D.VHR_EMP_PK,D.CCY,'" + l_from_date + "','" + l_status + "','D','" + l_trans_book + "') OPEN_D, SF_GET_EMP_OPENBAL('" + l_company_pk + "'," + l_acc_pk + ",D.VHR_EMP_PK,D.CCY,'" + l_from_date + "','" + l_status + "','C','" + l_trans_book + "') OPEN_C," +
                " SUM(NVL(YMD_DRTRANS,0)) PS_DEBIT, SUM(NVL(YMD_CRTRANS,0)) PS_CREDIT   " +
                " FROM TAC_HGEMPDDBAL D   " +
                " WHERE  D.DEL_IF =0  " +
                " AND D.TR_STATUS =  " + l_status +
                " AND D.TCO_COMPANY_PK = " + l_company_pk +
                " AND D.STD_YMD BETWEEN '" + l_from_date + "' AND '" + l_to_date + "'  " +
                "        AND (('" + l_acc_pk + "' IS NULL) OR (D.TAC_ABACCTCODE_PK = '" + l_acc_pk + "')) " +
                " GROUP BY VHR_EMP_PK,CCY  " +
                " ) E  " +
                " WHERE V.PK = E.VHR_EMP_PK  " +
                " AND DECODE('" + l_emp_pk + "','',1,'ALL',1,V.PK) = DECODE('" + l_emp_pk + "','',1,'ALL',1,'" + l_emp_pk + "') " +
                " ORDER BY EMP_ID,CCY  ";
     */
     SQL = "SELECT EMP_ID,FULL_NAME,CCY,OPEN_FBAL_DR,OPEN_FBAL_CR,DR_FSUM,CR_FSUM,CLOSE_FBAL_DR,CLOSE_FBAL_CR FROM (SELECT B.EMP_ID, B.FULL_NAME, " +
        "        N.CCY, DECODE('" + l_rpt_drcr + "','D',N.OPEN_FBAL,0) OPEN_FBAL_DR,DECODE('" + l_rpt_drcr + "','C',N.OPEN_FBAL,0) OPEN_FBAL_CR,  N.DR_FSUM DR_FSUM,N.CR_FSUM CR_FSUM, " +
        "        DECODE('" + l_rpt_drcr + "','D',N.CLOSE_FBAL,0) CLOSE_FBAL_DR,DECODE('" + l_rpt_drcr + "','C',N.CLOSE_FBAL,0) CLOSE_FBAL_CR,DECODE('" + l_acc_pk + "','',SF_A_GET_ACCD(N.TAC_ABACCTCODE_PK,'" + l_company_pk + "'),'') ACCD " +
        "    FROM " +
        "    ( " +
        "    SELECT  " +
        "    NVL(G.TAC_ABACCTCODE_PK,H.TAC_ABACCTCODE_PK) TAC_ABACCTCODE_PK, " +
        "    NVL(G.VHR_EMP_PK,H.VHR_EMP_PK) VHR_EMP_PK, " +
        "    NVL(G.CCY,H.CCY) CCY,NVL(G.OPEN_FBAL,0) OPEN_FBAL,NVL(G.OPEN_BAL,0) OPEN_BAL,  " +
        "        NVL(H.DR_FSUM,0) DR_FSUM, NVL(H.CR_FSUM,0) CR_FSUM, " +
        "        NVL(H.DR_SUM,0) DR_SUM, NVL(H.CR_SUM,0) CR_SUM, " +
        "        (NVL(G.OPEN_FBAL,0) + (NVL(H.DR_FSUM,0)- NVL(H.CR_FSUM,0))*TO_NUMBER('" + l_rpt_drcr_num + "') ) CLOSE_FBAL, " +
        "        (NVL(G.OPEN_BAL,0) + (NVL(H.DR_SUM,0)- NVL(H.CR_SUM,0))*TO_NUMBER('" + l_rpt_drcr_num + "') ) CLOSE_BAL " +
        "    FROM  " +
        "    ( " +
        "    SELECT  " +
        "    NVL(E.TAC_ABACCTCODE_PK,F.TAC_ABACCTCODE_PK) TAC_ABACCTCODE_PK, " +
        "    NVL(E.VHR_EMP_PK,F.VHR_EMP_PK) VHR_EMP_PK, " +
        "    NVL(E.CCY,F.CCY) CCY,(NVL(E.OPEN_FBAL1,0)+NVL(F.OPEN_FBAL2,0)) OPEN_FBAL, " +
        "    (NVL(E.OPEN_BAL1,0)+ NVL(F.OPEN_BAL2,0)) OPEN_BAL " +
        "    FROM " +
        "    ( " +
        "    SELECT M.TAC_ABACCTCODE_PK,M.VHR_EMP_PK ,M.CCY,(SUM(NVL(M.THIS_DRFAMT,0)) - SUM(NVL(M.THIS_CRFAMT,0)))*TO_NUMBER('" + l_rpt_drcr_num + "') OPEN_FBAL1, " +
        "        (SUM(NVL(M.THIS_DRAMT,0)) - SUM(NVL(M.THIS_CRAMT,0)))*TO_NUMBER('" + l_rpt_drcr_num + "') OPEN_BAL1 " +
        "        " +
        "    FROM TAC_HGEMPMMBAL M " +
        "        WHERE M.DEL_IF =0  " +
        "        AND M.TCO_COMPANY_PK = '" + l_company_pk + "' " +
        "        AND M.TR_STATUS = '" + l_status + "' ";
       // "        AND ((p_ccy IS NULL) OR (M.CCY = p_ccy)) " 
     SQL += "        AND DECODE('" + l_acc_pk + "','',1,M.TAC_ABACCTCODE_PK) = DECODE('" + l_acc_pk + "','',1,'" + l_acc_pk + "') " +
        "        AND (M.STD_YM||'01') = SF_GET_LASTCLOSEMM ('" + l_from_date + "','" + l_company_pk + "') " +
        "        AND DECODE('" + l_emp_pk + "','',1,M.VHR_EMP_PK) = DECODE('" + l_emp_pk + "','',1,'" + l_emp_pk + "') " +
        "    GROUP BY M.TAC_ABACCTCODE_PK,M.VHR_EMP_PK,M.CCY) E FULL OUTER JOIN  " +
        "    ( " +
        "    SELECT D.TAC_ABACCTCODE_PK,D.VHR_EMP_PK,  D.CCY,  " +
        "        (SUM(NVL(D.YMD_DRTRANS,0)) -SUM(NVL(D.YMD_CRTRANS,0)))*TO_NUMBER('"+l_rpt_drcr_num+"') OPEN_FBAL2, " +
        "        (SUM(NVL(D.YMD_DRBOOKS,0))-SUM(NVL(D.YMD_CRBOOKS,0)))*TO_NUMBER('"+l_rpt_drcr_num+"') OPEN_BAL2 " +
        "       " +
        "        FROM TAC_HGEMPDDBAL D " +
        "        WHERE D.DEL_IF =0 " +
        "         AND D.TCO_COMPANY_PK = '" + l_company_pk + "' " +
        "         AND D.TR_STATUS = '" + l_status + "' " +
        "         AND DECODE('" + l_acc_pk + "','',1,D.TAC_ABACCTCODE_PK) = DECODE('" + l_acc_pk + "','',1,'" + l_acc_pk + "') " +
        "         AND DECODE('" + l_emp_pk + "','',1,D.VHR_EMP_PK) = DECODE('" + l_emp_pk + "','',1,'" + l_emp_pk + "') " +
        "         AND D.STD_YMD >= TO_CHAR(ADD_MONTHS(TO_DATE(SF_GET_LASTCLOSEMM ('" + l_from_date + "','" + l_company_pk + "'),'YYYYMMDD'),+1),'YYYYMMDD') " +
        "         AND D.STD_YMD < '" + l_from_date + "' " +
        "         GROUP BY D.TAC_ABACCTCODE_PK,D.VHR_EMP_PK, D.CCY " +
        "       ) F " +
        "       ON E.TAC_ABACCTCODE_PK = F.TAC_ABACCTCODE_PK AND E.VHR_EMP_PK=F.VHR_EMP_PK AND F.CCY = E.CCY " +
        "       ) G FULL OUTER JOIN  " +
        "       ( " +
        "       SELECT D.TAC_ABACCTCODE_PK,D.VHR_EMP_PK,D.CCY,  " +
        "            SUM(NVL(D.YMD_DRTRANS,0)) DR_FSUM,SUM(NVL(D.YMD_CRTRANS,0)) CR_FSUM, " +
        "            SUM(NVL(D.YMD_DRBOOKS,0)) DR_SUM,SUM(NVL(D.YMD_CRBOOKS,0)) CR_SUM " +
        "        FROM TAC_HGEMPDDBAL D " +
        "        WHERE D.DEL_IF =0 " +
        "         AND D.TCO_COMPANY_PK = '" + l_company_pk + "' " +
        "         AND D.TR_STATUS = '" + l_status + "' " +
        "         AND DECODE('" + l_acc_pk + "','',1,D.TAC_ABACCTCODE_PK) = DECODE('" + l_acc_pk + "','',1,'" + l_acc_pk + "') " +
        "         AND DECODE('" + l_emp_pk + "','',1,D.VHR_EMP_PK) = DECODE('" + l_emp_pk + "','',1,'" + l_emp_pk + "') " +
        "         AND D.STD_YMD BETWEEN '" + l_from_date + "' AND '" + l_to_date + "' " +
        "         GROUP BY D.TAC_ABACCTCODE_PK,D.VHR_EMP_PK,D.CCY " +
        "         ) H " +
        "         ON G.TAC_ABACCTCODE_PK = H.TAC_ABACCTCODE_PK AND G.VHR_EMP_PK=H.VHR_EMP_PK AND G.CCY = H.CCY " +
        "       ) N, tac_employee_adv B " +
        "       WHERE N.VHR_EMP_PK = B.PK) " +
        "   WHERE ((OPEN_FBAL_DR <>0) OR (OPEN_FBAL_CR <>0 ) OR(DR_FSUM <>0) OR(CR_FSUM<>0)) " +
        "       ORDER BY EMP_ID,CCY ";

     //Response.Write(SQL);
    // Response.End();
     
    DataTable dt_detail = ESysLib.TableReadOpen(SQL);
for (i = 0; i < dt_detail.Rows.Count; i++)
{
   // if (dt_detail.Rows[i][2].ToString() == "VND")
    if (l_book_ccy == "VND")
    {
        p_xls_ccy_format = p_xls_ccy_format_vnd;
    }
    else
    {
        p_xls_ccy_format = p_xls_ccy_format_usd;
    }  
  %>
 
 <tr class=xl35 height=20 style='height:15.0pt'>
  <td height=20 class=xl36 style='height:15.0pt' x:num><%=(i+1) %></td>
  <td class=xl37><%= dt_detail.Rows[i][0].ToString() %></td>
  <td class=xl38><%= dt_detail.Rows[i][1].ToString() %></td>
  <td class=xl38><%= dt_detail.Rows[i][2].ToString() %></td>
  <td class=xl39  style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_detail.Rows[i][3].ToString() %></td>
  <td class=xl39 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_detail.Rows[i][4].ToString() %></td>
  <td class=xl39 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_detail.Rows[i][5].ToString() %></td>
  <td class=xl39 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_detail.Rows[i][6].ToString() %></td>
  <td class=xl39 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_detail.Rows[i][7].ToString() %></td>
  <td class=xl39 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_detail.Rows[i][8].ToString() %></td>
  <td class=xl40>&nbsp;</td>
 </tr>
<%
    } 
/*
SQL = " SELECT CCY, " +
        " SUM(SF_GET_EMP_BAL('" + l_company_pk +"' ,'" + l_emp_pk + "',D.CCY,'" + l_from_date + "','" + l_status + "','D','" + l_trans_book + "')) OPEN_D,  " +
        " SUM(SF_GET_EMP_BAL('" + l_company_pk + "' ,'" + l_emp_pk + "',D.CCY,'" + l_from_date + "','" + l_status + "','C','" + l_trans_book + "')) OPEN_C, " +
        " SUM(PS_DEBIT) PS_DEBIT, SUM(PS_CREDIT) PS_CREDIT, " +
        " (SUM(PS_DEBIT) + SUM(SF_GET_EMP_BAL('" + l_company_pk + "' ,'" + l_emp_pk + "',D.CCY,'" + l_from_date + "','" + l_status + "','D','" + l_trans_book + "'))) CLOSE_D, " +
        " (SUM(PS_CREDIT) + SUM(SF_GET_EMP_BAL('" + l_company_pk + "' ,'" + l_emp_pk + "',D.CCY,'" + l_from_date + "','" + l_status + "','C','" + l_trans_book + "'))) CLOSE_C " +
        " FROM( " +
        "  SELECT CCY, " +
        " SUM(NVL(YMD_DRTRANS,0)) PS_DEBIT, SUM(NVL(YMD_CRTRANS,0)) PS_CREDIT    " +
        " FROM TAC_HGEMPDDBAL D    " +
        " WHERE  D.DEL_IF =0   " +
        " AND D.TR_STATUS =  " + l_status +
        " AND D.TCO_COMPANY_PK = " + l_company_pk +
        " AND D.STD_YMD BETWEEN '" + l_from_date + "' AND '" + l_to_date + "'  " +
        " AND DECODE('','',1,'ALL',1,D.VHR_EMP_PK) = DECODE('','',1,'ALL',1,'" + l_emp_pk + "')  " +
         "        AND (('" + l_acc_pk + "' IS NULL) OR (D.TAC_ABACCTCODE_PK = '" + l_acc_pk + "')) " + 
        " GROUP BY CCY   " +
        " )  D" +
        " GROUP BY CCY " +
        " ORDER BY CCY ";
 * */

    SQL = "SELECT CCY, DECODE('" + l_rpt_drcr + "','D',OPEN_FBAL,0) OPEN_FBALD, DECODE('" + l_rpt_drcr + "','C',OPEN_FBAL,0) OPEN_FBALC, " +
        "        DR_FSUM,CR_FSUM,  DECODE('" + l_rpt_drcr + "','D',CLOSE_FBAL,0) CLOSE_FBALD, DECODE('" + l_rpt_drcr + "','C',CLOSE_FBAL,0) CLOSE_FBALC " +
        "         " +
        "        FROM " +
        "        ( " +
        "        SELECT NVL(G.CCY,H.CCY) CCY,NVL(G.OPEN_FBAL,0) OPEN_FBAL,NVL(G.OPEN_BAL,0) OPEN_BAL,  " +
        "            NVL(H.DR_FSUM,0) DR_FSUM, NVL(H.CR_FSUM,0) CR_FSUM, " +
        "            NVL(H.DR_SUM,0) DR_SUM, NVL(H.CR_SUM,0) CR_SUM, " +
        "            (NVL(G.OPEN_FBAL,0) + (NVL(H.DR_FSUM,0)- NVL(H.CR_FSUM,0))*TO_NUMBER('" + l_rpt_drcr_num + "') ) CLOSE_FBAL, " +
        "            (NVL(G.OPEN_BAL,0) + (NVL(H.DR_SUM,0)- NVL(H.CR_SUM,0))*TO_NUMBER('" + l_rpt_drcr_num + "') ) CLOSE_BAL " +
        "        FROM  " +
        "        ( " +
        "        SELECT NVL(E.CCY,F.CCY) CCY,(NVL(E.OPEN_FBAL1,0)+NVL(F.OPEN_FBAL2,0)) OPEN_FBAL, " +
        "        (NVL(E.OPEN_BAL1,0)+ NVL(F.OPEN_BAL2,0)) OPEN_BAL, " +
        "        (NVL(E.O_DR_FSUM1,0) + NVL(F.O_DR_FSUM2,0)) O_DR_FSUM, " +
        "        (NVL(E.O_CR_FSUM1,0) + NVL(F.O_CR_FSUM2,0)) O_CR_FSUM, " +
        "        (NVL(E.O_DR_SUM1,0)  + NVL(F.O_DR_SUM2,0)) O_DR_SUM, " +
        "        (NVL(E.O_CR_SUM1,0)  + NVL(F.O_CR_SUM2,0)) O_CR_SUM " +
        "        FROM " +
        "        ( " +
        "        SELECT M.CCY,(SUM(NVL(M.THIS_DRFAMT,0)) - SUM(NVL(M.THIS_CRFAMT,0)))*TO_NUMBER('" + l_rpt_drcr_num + "') OPEN_FBAL1, " +
        "        (SUM(NVL(M.THIS_DRAMT,0)) - SUM(NVL(M.THIS_CRAMT,0)))*TO_NUMBER('" + l_rpt_drcr_num + "') OPEN_BAL1, " +
        "        SUM(NVL(M.THIS_DRFAMT,0)) O_DR_FSUM1, SUM(NVL(M.THIS_CRFAMT,0)) O_CR_FSUM1, " +
        "        SUM(NVL(M.THIS_DRAMT,0)) O_DR_SUM1,SUM(NVL(M.THIS_CRAMT,0)) O_CR_SUM1 " +
        "        FROM TAC_HGEMPMMBAL M " +
        "        WHERE M.DEL_IF =0  " +
        "        AND M.TCO_COMPANY_PK = '" + l_company_pk + "' " +
        "        AND M.TR_STATUS = '" + l_status + "' " +
        "        AND DECODE('" + l_acc_pk + "','',1,M.TAC_ABACCTCODE_PK) = DECODE('" + l_acc_pk + "','',1,'" + l_acc_pk + "') " +
        "        AND (M.STD_YM||'01') = SF_GET_LASTCLOSEMM ('" + l_from_date + "','" + l_company_pk + "') " +
        "        AND DECODE('" + l_emp_pk + "','',1,M.VHR_EMP_PK) = DECODE('" + l_emp_pk + "','',1,'" + l_emp_pk + "') " +
        "        GROUP BY M.CCY) E FULL OUTER JOIN  " +
        "        (SELECT D.CCY, (SUM(NVL(D.YMD_DRTRANS,0)) -SUM(NVL(D.YMD_CRTRANS,0)))*TO_NUMBER('" + l_rpt_drcr_num + "') OPEN_FBAL2, " +
        "        (SUM(NVL(D.YMD_DRBOOKS,0))-SUM(NVL(D.YMD_CRBOOKS,0)))*TO_NUMBER('" + l_rpt_drcr_num + "') OPEN_BAL2, " +
        "            SUM(NVL(D.YMD_DRTRANS,0)) O_DR_FSUM2, SUM(NVL(D.YMD_CRTRANS,0)) O_CR_FSUM2, " +
        "            SUM(NVL(D.YMD_DRBOOKS,0)) O_DR_SUM2, SUM(NVL(D.YMD_CRBOOKS,0)) O_CR_SUM2 " +
        "            FROM TAC_HGEMPDDBAL D " +
        "            WHERE D.DEL_IF =0 " +
        "             AND D.TCO_COMPANY_PK = '" + l_company_pk + "' " +
        "             AND D.TR_STATUS = '" + l_status + "' " +
        "             AND DECODE('" + l_acc_pk + "','',1,D.TAC_ABACCTCODE_PK) = DECODE('" + l_acc_pk + "','',1,'" + l_acc_pk + "') " +
        "             AND DECODE('" + l_emp_pk + "','',1,D.VHR_EMP_PK) = DECODE('" + l_emp_pk + "','',1,'" + l_emp_pk + "') " +
        "             AND D.STD_YMD >= TO_CHAR(ADD_MONTHS(TO_DATE(SF_GET_LASTCLOSEMM ('" + l_from_date + "','" + l_company_pk + "'),'YYYYMMDD'),+1),'YYYYMMDD') " +
        "             AND D.STD_YMD < '" + l_from_date + "' " +
        "             GROUP BY D.CCY " +
        "           ) F " +
        "           ON F.CCY = E.CCY " +
        "           ) G FULL OUTER JOIN  " +
        "           ( " +
        "           SELECT D.CCY, SUM(NVL(D.YMD_DRTRANS,0)) DR_FSUM,SUM(NVL(D.YMD_CRTRANS,0)) CR_FSUM, " +
        "                SUM(NVL(D.YMD_DRBOOKS,0)) DR_SUM,SUM(NVL(D.YMD_CRBOOKS,0)) CR_SUM " +
        "            FROM TAC_HGEMPDDBAL D " +
        "            WHERE D.DEL_IF =0 " +
        "             AND D.TCO_COMPANY_PK = '" + l_company_pk + "' " +
        "             AND D.TR_STATUS = '" + l_status + "' " +
        "             AND DECODE('" + l_acc_pk + "','',1,D.TAC_ABACCTCODE_PK) = DECODE('" + l_acc_pk + "','',1,'" + l_acc_pk + "') " +
        "             AND DECODE('" + l_emp_pk + "','',1,D.VHR_EMP_PK) = DECODE('" + l_emp_pk + "','',1,'" + l_emp_pk + "') " +
        "             AND D.STD_YMD BETWEEN '" + l_from_date + "' AND '" + l_to_date + "' " +
        "             GROUP BY D.CCY " +
        "             ) H " +
        "             ON G.CCY = H.CCY " +
        "            ) " +
        "            ORDER BY CCY ";

    DataTable dt_total = ESysLib.TableReadOpen(SQL);
 %> 
 <tr class=xl35 height=20 style='height:15.0pt'>
  <td colspan=2 rowspan="<%=dt_total.Rows.Count.ToString() %>" height=40 class=xl63 style='border-right:.5pt solid black;border-bottom:.5pt solid black;height:30.0pt'>TỔNG CỘNG</td>
  <%
      for (i = 0; i < dt_total.Rows.Count; i++)
      {
          if (dt_total.Rows[i][0].ToString() == "VND")
          {
              p_xls_ccy_format = p_xls_ccy_format_vnd;
          }
          else
          {
              p_xls_ccy_format = p_xls_ccy_format_usd;
          }

          if (i == 0)
          {
   %>
  <td class=xl41>&nbsp;</td>
  <td class=xl41><%= dt_total.Rows[i][0].ToString()%></td>
  <td class=xl42 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_total.Rows[i][1].ToString()%></td>
  <td class=xl42 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_total.Rows[i][2].ToString()%></td>
  <td class=xl42 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_total.Rows[i][3].ToString()%></td>
  <td class=xl42 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_total.Rows[i][4].ToString()%></td>
  <td class=xl42 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_total.Rows[i][5].ToString()%></td>
  <td class=xl42 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_total.Rows[i][6].ToString()%></td>
  <td rowspan="<%=dt_total.Rows.Count.ToString() %>" class=xl67 style='border-bottom:.5pt solid black'>&nbsp;</td>
 </tr>
<%
      }
      else
      {
 %> 
 <tr class=xl35 height=20 style='height:15.0pt'>
  <td height=20 class=xl43 style='height:15.0pt'>&nbsp;</td>
  <td class=xl43><%= dt_total.Rows[i][0].ToString()%></td>
  <td class=xl44  style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_total.Rows[i][1].ToString()%></td>
  <td class=xl44  style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_total.Rows[i][2].ToString()%></td>
  <td class=xl44  style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_total.Rows[i][3].ToString()%></td>
  <td class=xl44  style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_total.Rows[i][4].ToString()%></td>
  <td class=xl44  style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_total.Rows[i][5].ToString()%></td>
  <td class=xl44  style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_total.Rows[i][6].ToString()%></td>
 </tr>
<%
      }
  }

 %> 
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=10 class=xl46 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl26></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=7 class=xl45 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl69>Lập ngày <%= l_rpt_date3%> tháng <%= l_rpt_date4%> năm <%= l_rpt_date5%></td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=2 class=xl47 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl48>NGƯỜI LẬP BIỂU</td>
  <td class=xl48></td>
  <td colspan=3 class=xl47 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl48>KẾ TOÁN TRƯỞNG</td>
  <td class=xl47></td>
  <td class=xl49></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=2 class=xl50 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl51>(Ký, họ tên)</td>
  <td class=xl51></td>
  <td colspan=3 class=xl50 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl51>(Ký, họ tên)</td>
  <td class=xl50></td>
  <td class=xl32></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=10 class=xl50 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl32></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=10 class=xl50 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl32></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=2 class=xl50 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl50 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29></td>
  <td class=xl50></td>
  <td class=xl32></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=11 class=xl32 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=38 style='width:29pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=219 style='width:164pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=82 style='width:62pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
