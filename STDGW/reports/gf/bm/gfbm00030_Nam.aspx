<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%
    ESysLib.SetUser("acnt");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel"
    xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_Company_pk = Request["Company_pk"];
    string p_From = Request["From"];
    string p_To = Request["To"];
    string p_Taikhoan_pk = Request["Taikhoan_pk"];
    string p_Loai = Request["Loai"];
    string p_NuaNam = Request["6thang"];
    string p_Quy = Request["Quy"];

    string l_parameter = "'" + p_Company_pk + "', ";
    l_parameter += "'" + p_From + "', ";
    l_parameter += "'" + p_To + "', ";
    l_parameter += "'" + p_Taikhoan_pk + "' ";
    // l_parameter += "'" + p_Loai + "' ";   

    string p_company_name = "";
    string p_tax_code = "";
    string p_cmp_add = "";
    string SQL = " SELECT partner_lname, tax_code, ADDR1, ADDR2, ADDR3  FROM tco_company  WHERE pk = '" + p_Company_pk + "'";
    DataTable dt2 = ESysLib.TableReadOpen(SQL);
    p_company_name = dt2.Rows[0][0].ToString();
    p_tax_code = dt2.Rows[0][1].ToString();
    p_cmp_add = dt2.Rows[0][2].ToString() + " " + dt2.Rows[0][3].ToString();

    DataTable dt = ESysLib.TableReadOpenCursor("ACNT.sel_sp_gfbm00030_nam", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data!!");
        Response.End();
    }


    p_From = (p_From.Substring(6, 2) + "/" + p_From.Substring(4, 2) + "/" + p_From.Substring(0, 4));
    p_To = (p_To.Substring(6, 2) + "/" + p_To.Substring(4, 2) + "/" + p_To.Substring(0, 4));
                
                
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="ProgId" content="Excel.Sheet">
    <meta name="Generator" content="Microsoft Excel 11">
    <link rel="File-List" href="aa_files/filelist.xml">
    <link rel="Edit-Time-Data" href="aa_files/editdata.mso">
    <link rel="OLE-Object-Data" href="aa_files/oledata.mso">
    <!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>LONG</o:Author>
  <o:LastAuthor>LONG</o:LastAuthor>
  <o:LastPrinted>2010-07-26T09:19:23Z</o:LastPrinted>
  <o:Created>2010-07-26T08:20:08Z</o:Created>
  <o:LastSaved>2010-07-30T04:12:08Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
    <style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .5in .5in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
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
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	white-space:normal;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl38
		{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:silver;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
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
      <x:Scale>21</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>11</x:SplitHorizontal>
     <x:TopRowBottomPane>11</x:TopRowBottomPane>
     <x:SplitVertical>4</x:SplitVertical>
     <x:LeftColumnRightPane>17</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>7</x:ActiveRow>
       <x:ActiveCol>0</x:ActiveCol>
       <x:RangeSelection>$A$8:$AQ$8</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>12000</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>
<body link="blue" vlink="purple">
    <%
        string _class = ";display:none";
    %>
    <table x:str border="0" cellpadding="0" cellspacing="0" width="6156" style='border-collapse: collapse;
        table-layout: fixed; width: 4637pt'>
        <col width="110" style='mso-width-source: userset; mso-width-alt: 4022; width: 83pt'>
        <col width="215" style='mso-width-source: userset; mso-width-alt: 7862; width: 161pt'>
        <col width="110" style='mso-width-source: userset; mso-width-alt: 4022; width: 83pt'>
        <col width="215" style='mso-width-source: userset; mso-width-alt: 7862; width: 161pt'>
        <col width="110" span="1" style='mso-width-source: userset; mso-width-alt: 4022;
            width: 83pt'>
        <%      
            if (p_Loai == "98" || (p_Loai == "97" && p_NuaNam == "1") || (p_Loai == "95" && p_Quy == "1"))//nua nam lan I
                _class = "";
            else if ((p_Loai == "97" && p_NuaNam == "2") || (p_Loai == "95" && p_Quy != "1"))
                _class = ";display:none";     
        %>
        <col width="110" span="3" style='mso-width-source: userset; mso-width-alt: 4022;
            width: 83pt<%=_class %>'>
        <%      
            if (p_Loai == "98" || (p_Loai == "97" && p_NuaNam == "1") || (p_Loai == "95" && p_Quy == "2"))//nua nam lan I
                _class = "";
            else if ((p_Loai == "97" && p_NuaNam == "2") || (p_Loai == "95" && p_Quy != "2"))
                _class = ";display:none";     
        %>
        <col width="110" span="3" style='mso-width-source: userset; mso-width-alt: 4022;
            width: 83pt<%=_class %>'>
        <%      
            if (p_Loai == "97" && p_NuaNam == "1" || (p_Loai == "95" && p_Quy != "3")) //nua nam lan I
                _class = ";display:none";
            else if (p_Loai == "98" || (p_Loai == "97" && p_NuaNam == "2") || (p_Loai == "95" && p_Quy == "3"))
                _class = "";   
        %>
        <col width="110" span="3" style='mso-width-source: userset; mso-width-alt: 4022;
            width: 83pt<%=_class %>'>
        <%      
            if (p_Loai == "97" && p_NuaNam == "1" || (p_Loai == "95" && p_Quy != "4"))//nua nam lan I
                _class = ";display:none";
            else if (p_Loai == "98" || (p_Loai == "97" && p_NuaNam == "2") || (p_Loai == "95" && p_Quy == "4"))
                _class = "";  
        %>
        <col width="110" span="3" style='mso-width-source: userset; mso-width-alt: 4022;
            width: 83pt<%=_class %>'>
        <!--------------------------------------------------------------------------------------------------->
        <col width="110" span="1" style='mso-width-source: userset; mso-width-alt: 4022;
            width: 83pt'>
        <%      
            if (p_Loai == "98" || (p_Loai == "97" && p_NuaNam == "1") || (p_Loai == "95" && p_Quy == "1"))//nua nam lan I
                _class = "";
            else if ((p_Loai == "97" && p_NuaNam == "2") || (p_Loai == "95" && p_Quy != "1"))
                _class = ";display:none";     
        %>
        <col width="110" span="3" style='mso-width-source: userset; mso-width-alt: 4022;
            width: 83pt<%=_class %>'>
        <%      
            if (p_Loai == "98" || (p_Loai == "97" && p_NuaNam == "1") || (p_Loai == "95" && p_Quy == "2"))//nua nam lan I
                _class = "";
            else if ((p_Loai == "97" && p_NuaNam == "2") || (p_Loai == "95" && p_Quy != "2"))
                _class = ";display:none";     
        %>
        <col width="110" span="3" style='mso-width-source: userset; mso-width-alt: 4022;
            width: 83pt<%=_class %>'>
        <%      
            if (p_Loai == "97" && p_NuaNam == "1" || (p_Loai == "95" && p_Quy != "3")) //nua nam lan I
                _class = ";display:none";
            else if (p_Loai == "98" || (p_Loai == "97" && p_NuaNam == "2") || (p_Loai == "95" && p_Quy == "3"))
                _class = "";   
        %>
        <col width="110" span="3" style='mso-width-source: userset; mso-width-alt: 4022;
            width: 83pt<%=_class %>'>
        <%      
            if (p_Loai == "97" && p_NuaNam == "1" || (p_Loai == "95" && p_Quy != "4"))//nua nam lan I
                _class = ";display:none";
            else if (p_Loai == "98" || (p_Loai == "97" && p_NuaNam == "2") || (p_Loai == "95" && p_Quy == "4"))
                _class = "";  
        %>
        <col width="110" span="3" style='mso-width-source: userset; mso-width-alt: 4022;
            width: 83pt<%=_class %>'>
        <!--------------------------------------------------------------------------------------------------->
        <col width="110" span="1" style='mso-width-source: userset; mso-width-alt: 4022;
            width: 83pt'>
        <%      
            if (p_Loai == "98" || (p_Loai == "97" && p_NuaNam == "1") || (p_Loai == "95" && p_Quy == "1"))//nua nam lan I
                _class = "";
            else if ((p_Loai == "97" && p_NuaNam == "2") || (p_Loai == "95" && p_Quy != "1"))
                _class = ";display:none";     
        %>
        <col width="110" span="3" style='mso-width-source: userset; mso-width-alt: 4022;
            width: 83pt<%=_class %>'>
        <%      
            if (p_Loai == "98" || (p_Loai == "97" && p_NuaNam == "1") || (p_Loai == "95" && p_Quy == "2"))//nua nam lan I
                _class = "";
            else if ((p_Loai == "97" && p_NuaNam == "2") || (p_Loai == "95" && p_Quy != "2"))
                _class = ";display:none";     
        %>
        <col width="110" span="3" style='mso-width-source: userset; mso-width-alt: 4022;
            width: 83pt<%=_class %>'>
        <%      
            if (p_Loai == "97" && p_NuaNam == "1" || (p_Loai == "95" && p_Quy != "3")) //nua nam lan I
                _class = ";display:none";
            else if (p_Loai == "98" || (p_Loai == "97" && p_NuaNam == "2") || (p_Loai == "95" && p_Quy == "3"))
                _class = "";   
        %>
        <col width="110" span="3" style='mso-width-source: userset; mso-width-alt: 4022;
            width: 83pt<%=_class %>'>
        <%      
            if (p_Loai == "97" && p_NuaNam == "1" || (p_Loai == "95" && p_Quy != "4"))//nua nam lan I
                _class = ";display:none";
            else if (p_Loai == "98" || (p_Loai == "97" && p_NuaNam == "2") || (p_Loai == "95" && p_Quy == "4"))
                _class = "";  
        %>
        <col width="110" span="3" style='mso-width-source: userset; mso-width-alt: 4022;
            width: 83pt<%=_class %>'>
        <!--------------------------------------------------------------------------------------------------->
        <col width="110" span="39" style='mso-width-source: userset; mso-width-alt: 4022;
            width: 83pt'>
        <col width="64" span="19" style='width: 48pt'>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" class="xl24" colspan="2" width="325" style='height: 12.75pt; mso-ignore: colspan;
                width: 244pt'>
                <%=p_company_name%>
            </td>
            <td class="xl24" width="110" style='width: 83pt'>
            </td>
            <td class="xl24" width="215" style='width: 161pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="62" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" class="xl24" colspan="2" style='height: 12.75pt; mso-ignore: colspan'>
                <%=p_cmp_add%>
            </td>
            <td colspan="2" class="xl24" style='mso-ignore: colspan'>
            </td>
            <td colspan="58" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="34" style='height: 25.5pt; mso-xlrowspan: 2'>
            <td height="34" colspan="62" style='height: 25.5pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="33" style='mso-height-source: userset; height: 24.95pt'>
            <td colspan="43" height="33" class="xl41" style='height: 24.95pt'>
                Budget Draft Inquiry</td>
            <td colspan="19" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="62" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="20" style='height: 15.0pt'>
            <td colspan="43" height="20" class="xl25" style='height: 15.0pt'>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Từ
                ngày
                <%=p_From%>
                đến ngày
                <%=p_To%>
            </td>
            <td colspan="19" class="xl40" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="18" style='height: 13.5pt'>
            <td height="18" colspan="62" style='height: 13.5pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="20" style='mso-height-source: userset; height: 15.0pt'>
            <td height="20" class="xl26" style='height: 15.0pt'>
                &nbsp;</td>
            <td class="xl27">
                &nbsp;</td>
            <td class="xl27">
                &nbsp;</td>
            <td class="xl27">
                &nbsp;</td>
            <td colspan="13" class="xl42" style='border-right: .5pt solid black'>
                Budget</td>
            <td colspan="13" class="xl45" style='border-right: .5pt solid black; border-left: none'>
                Phát Sinh</td>
            <td colspan="13" class="xl45" style='border-right: 1.0pt solid black; border-left: none'>
                Chênh Lệch</td>
            <td colspan="19" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr class="xl28" height="22" style='height: 16.5pt'>
            <td height="22" class="xl29" style='height: 16.5pt'>
                Mã</td>
            <td class="xl30">
                Tên</td>
            <td class="xl30">
                Mã TK</td>
            <td class="xl30">
                Tên TK</td>
            <td class="xl30">
                Tổng</td>
            <td class="xl30">
                Tháng 1</td>
            <td class="xl30">
                Tháng 2</td>
            <td class="xl30">
                Tháng 3</td>
            <td class="xl30">
                Tháng 4</td>
            <td class="xl30">
                Tháng 5</td>
            <td class="xl30">
                Tháng 6</td>
            <td class="xl30">
                Tháng 7</td>
            <td class="xl30">
                Tháng 8</td>
            <td class="xl30">
                Tháng 9</td>
            <td class="xl30">
                Tháng 10</td>
            <td class="xl30">
                Tháng 11</td>
            <td class="xl30">
                Tháng 12</td>
            <td class="xl30">
                Tổng</td>
            <td class="xl30">
                Tháng 1</td>
            <td class="xl30">
                Tháng 2</td>
            <td class="xl30">
                Tháng 3</td>
            <td class="xl30">
                Tháng 4</td>
            <td class="xl30">
                Tháng 5</td>
            <td class="xl30">
                Tháng 6</td>
            <td class="xl30">
                Tháng 7</td>
            <td class="xl30">
                Tháng 8</td>
            <td class="xl30">
                Tháng 9</td>
            <td class="xl30">
                Tháng 10</td>
            <td class="xl30">
                Tháng 11</td>
            <td class="xl30">
                Tháng 12</td>
            <td class="xl30">
                Tổng</td>
            <td class="xl30">
                Tháng 1</td>
            <td class="xl30">
                Tháng 2</td>
            <td class="xl30">
                Tháng 3</td>
            <td class="xl30">
                Tháng 4</td>
            <td class="xl30">
                Tháng 5</td>
            <td class="xl30">
                Tháng 6</td>
            <td class="xl30">
                Tháng 7</td>
            <td class="xl30">
                Tháng 8</td>
            <td class="xl30">
                Tháng 9</td>
            <td class="xl30">
                Tháng 10</td>
            <td class="xl30">
                Tháng 11</td>
            <td class="xl31">
                Tháng 12</td>
            <td colspan="19" class="xl28" style='mso-ignore: colspan'>
            </td>
        </tr>
        <%
            string tag_begin = "";
            string tag_bold = "";
            string tag_endbold = ""; 
            int i;
           
            for (i = 1; i < dt.Rows.Count; i++)
            {
               tag_begin = "";
               tag_bold = "";
               tag_endbold = "";
               
               if (dt.Rows[i][1].ToString() == "B")
                {
                    tag_begin = "background:#99CCFF;mso-pattern:auto none;";
                    //Response.Write(dt.Rows[i][1].ToString());
                    //Response.End();    
                   tag_bold = "<b>";
                   tag_endbold = "</b>";
                         
                   
                }
        %>
        <tr class="xl25" height="20" style='mso-height-source:userset;height: 15.0pt'>
            <td height="20" class="xl32" style="<%=tag_begin %>">
           
                <%=tag_bold%><%=dt.Rows[i][3]%><%=tag_endbold%>
            </td>
            <td class="xl33" style="<%=tag_begin %>">
                <%=tag_bold%><%=dt.Rows[i][4]%><%=tag_endbold%>
            </td>
            <td class="xl34" style="<%=tag_begin%>">
                <%=tag_bold%><%=dt.Rows[i][5]%><%=tag_endbold%>
            </td>
            <td class="xl33" style="<%=tag_begin%>;white-space:normal">
                <%=tag_bold%><%=dt.Rows[i][6]%><%=tag_endbold%>
            </td>
            <td class="xl35" style="<%=tag_begin%>"  x:num>
                <%=tag_bold%><%=dt.Rows[i][7]%><%=tag_endbold%>
            </td>
            <td class="xl35" style="<%=tag_begin%>"  x:num>
                <%=tag_bold%><%=dt.Rows[i][8]%><%=tag_endbold%>
            </td>
            <td class="xl35" style="<%=tag_begin%>"  x:num>
                <%=tag_bold%><%=dt.Rows[i][9]%><%=tag_endbold%>
            </td>
            <td class="xl35" style="<%=tag_begin%>"  x:num>
                <%=tag_bold%><%=dt.Rows[i][10]%><%=tag_endbold%>
            </td>
            <td class="xl35" style="<%=tag_begin%>"  x:num>
                <%=tag_bold%><%=dt.Rows[i][11]%><%=tag_endbold%>
            </td>
            <td class="xl35" style="<%=tag_begin%>"  x:num>
                <%=tag_bold%><%=dt.Rows[i][12]%><%=tag_endbold%>
            </td>
            <td class="xl35" style="<%=tag_begin%>"  x:num>
                <%=tag_bold%><%=dt.Rows[i][13]%><%=tag_endbold%>
            </td>
            <td class="xl35" style="<%=tag_begin%>" x:num>
               <%=tag_bold%> <%=dt.Rows[i][14]%><%=tag_endbold%>
            </td>
            <td class="xl35" style="<%=tag_begin%>"  x:num>
                <%=tag_bold%><%=dt.Rows[i][15]%><%=tag_endbold%>
            </td>
            <td class="xl35" style="<%=tag_begin%>"  x:num>
                <%=tag_bold%><%=dt.Rows[i][16]%><%=tag_endbold%>
            </td>
            <td class="xl35" style="<%=tag_begin%>"  x:num>
               <%=tag_bold%> <%=dt.Rows[i][17]%><%=tag_endbold%>
            </td>
            <td class="xl35" style="<%=tag_begin%>"  x:num>
               <%=tag_bold%> <%=dt.Rows[i][18]%><%=tag_endbold%>
            </td>
            <td class="xl35" style="<%=tag_begin%>"  x:num>
                <%=tag_bold%><%=dt.Rows[i][19]%><%=tag_endbold%>
            </td>
            <td class="xl35" style="<%=tag_begin%>" x:num>
                <%=tag_bold%><%=dt.Rows[i][20]%><%=tag_endbold%>
            </td>
            <td class="xl35" style="<%=tag_begin%>" x:num>
                <%=tag_bold%><%=dt.Rows[i][21]%><%=tag_endbold%>
            </td>
            <td class="xl35" style="<%=tag_begin%>"  x:num>
                <%=tag_bold%><%=dt.Rows[i][22]%><%=tag_endbold%>
            </td>
            <td class="xl35" style="<%=tag_begin%>"  x:num>
                <%=tag_bold%><%=dt.Rows[i][23]%><%=tag_endbold%>
            </td>
            <td class="xl35"  style="<%=tag_begin%>" x:num>
                <%=tag_bold%><%=dt.Rows[i][24]%><%=tag_endbold%>
            </td>
            <td class="xl35"  style="<%=tag_begin%>" x:num>
                <%=tag_bold%><%=dt.Rows[i][25]%><%=tag_endbold%>
            </td>
            <td class="xl35" style="<%=tag_begin%>"  x:num>
                <%=tag_bold%><%=dt.Rows[i][26]%><%=tag_endbold%>
            </td>
            <td class="xl35"  style="<%=tag_begin%>" x:num>
                <%=tag_bold%><%=dt.Rows[i][27]%><%=tag_endbold%>
            </td>
            <td class="xl35"  style="<%=tag_begin%>" x:num>
                <%=tag_bold%><%=dt.Rows[i][28]%><%=tag_endbold%>
            </td>
            <td class="xl35" style="<%=tag_begin%>"  x:num>
                <%=tag_bold%><%=dt.Rows[i][29]%><%=tag_endbold%>
            </td>
            <td class="xl35" style="<%=tag_begin%>"  x:num>
                <%=tag_bold%><%=dt.Rows[i][30]%><%=tag_endbold%>
            </td>
            <td class="xl35"  style="<%=tag_begin%>" x:num>
                <%=tag_bold%><%=dt.Rows[i][31]%><%=tag_endbold%>
            </td>
            <td class="xl35"  style="<%=tag_begin%>" x:num>
                <%=tag_bold%><%=dt.Rows[i][32]%><%=tag_endbold%>
            </td>
            <td class="xl35"  style="<%=tag_begin%>" x:num>
                <%=tag_bold%><%=dt.Rows[i][33]%><%=tag_endbold%>
            </td>
            <td class="xl35" style="<%=tag_begin%>"  x:num>
                <%=tag_bold%><%=dt.Rows[i][34]%><%=tag_endbold%>
            </td>
            <td class="xl35"  style="<%=tag_begin%>" x:num>
                <%=tag_bold%><%=dt.Rows[i][35]%><%=tag_endbold%>
            </td>
            <td class="xl35"  style="<%=tag_begin%>" x:num>
                <%=tag_bold%><%=dt.Rows[i][36]%><%=tag_endbold%>
            </td>
            <td class="xl35" style="<%=tag_begin%>"  x:num>
                <%=tag_bold%><%=dt.Rows[i][37]%><%=tag_endbold%>
            </td>
            <td class="xl35"  style="<%=tag_begin%>" x:num>
                <%=tag_bold%><%=dt.Rows[i][38]%><%=tag_endbold%>
            </td>
            <td class="xl35" style="<%=tag_begin%>"  x:num>
               <%=tag_bold%> <%=dt.Rows[i][39]%><%=tag_endbold%>
            </td>
            <td class="xl35"  style="<%=tag_begin%>" x:num>
               <%=tag_bold%> <%=dt.Rows[i][40]%><%=tag_endbold%>
            </td>
            <td class="xl35"  style="<%=tag_begin%>" x:num>
                <%=tag_bold%><%=dt.Rows[i][41]%><%=tag_endbold%>
            </td>
            <td class="xl35"  style="<%=tag_begin%>" x:num>
                <%=tag_bold%><%=dt.Rows[i][42]%><%=tag_endbold%>
            </td>
            <td class="xl35"  style="<%=tag_begin%>" x:num>
                <%=tag_bold%><%=dt.Rows[i][43]%><%=tag_endbold%>
            </td>
            <td class="xl35" style="<%=tag_begin%>"  x:num>
                <%=tag_bold%><%=dt.Rows[i][44]%><%=tag_endbold%>
            </td>
            <td class="xl36" style="<%=tag_begin%>"  x:num>
                <%=tag_bold%><%=dt.Rows[i][45]%><%=tag_endbold%>
            </td>
        </tr>
        <%}

        
                %>
        
        <tr height="20" style='height: 15.0pt;' >
            <td height="18" class="xl37" style='height: 13.5pt;'>
                &nbsp;</td>
            <td class="xl38" >
                &nbsp;</td>
            <td class="xl38" >
                &nbsp;</td>
            <td class="xl38" >
               </td>
            <td class="xl38" >
             </td>
            <td class="xl38" >
              </td>
            <td class="xl38" >
               </td>
            <td class="xl38" >
              </td>
            <td class="xl38" >
             </td>
            <td class="xl38" >
              </td>
            <td class="xl38" >
                </td>
            <td class="xl38" >
               </td>
            <td class="xl38" >
               </td>
            <td class="xl38" >
               </td>
            <td class="xl38" >
                </td>
            <td class="xl38" >
                </td>
            <td class="xl38">
                </td>
            <td class="xl38" >
                </td>
            <td class="xl38">
                </td>
            <td class="xl38" >
                </td>
            <td class="xl38">
                </td>
            <td class="xl38" >
                </td>
            <td class="xl38" >
                </td>
            <td class="xl38" >
               </td>
            <td class="xl38">
                </td>
            <td class="xl38" >
               </td>
            <td class="xl38" >
                </td>
            <td class="xl38" >
               </td>
            <td class="xl38"  >
                </td>
            <td class="xl38" >
               </td>
            <td class="xl38">
                </td>
            <td class="xl38" >
                </td>
            <td class="xl38" >
                </td>
            <td class="xl38" >
                </td>
            <td class="xl38" >
                </td>
            <td class="xl38" >
                </td>
            <td class="xl38" >
                </td>
            <td class="xl38" >
               </td>
            <td class="xl38" >
                </td>
            <td class="xl38" >
                </td>
            <td class="xl38" >
                </td>
            <td class="xl38" >
               </td>
            <td class="xl39" >
                </td>
            <td colspan="19" style='mso-ignore: colspan'>
            </td>
        </tr>
      
        <![if supportMisalignedColumns]>
        <tr height="0" style='display: none'>
            
        </tr>
        <![endif]>
    </table>
</body>
</html>
