<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser("inv");%>
<% 	
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
%>
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office"
    xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
<%
    int curPg, totPg, curRow, minRow, maxRow, totRow, nullRow_Qty, rowSeq;
    string pk;
    string l_dtFrom, l_dtTo;

    pk = Request.QueryString["p_pk"];
    l_dtFrom = Request.QueryString["DT_FROM"];
    l_dtTo = Request.QueryString["DT_TO"];
    DateTime dt_From = DateTime.ParseExact(l_dtFrom, "yyyyMMdd", System.Globalization.CultureInfo.CurrentCulture);
    DateTime dt_To = DateTime.ParseExact(l_dtTo, "yyyyMMdd", System.Globalization.CultureInfo.CurrentCulture);

    DataTable dt = ESysLib.TableReadOpenCursor("INV.sp_rpt_epfm00060_posli", "'" + pk + "'");

    if (dt.Rows.Count == 0)
    {
        Response.Write("No thing to print.");
        Response.End();
    }


%>
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office"
    xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="ProgId" content="Excel.Sheet">
    <meta name="Generator" content="Microsoft Excel 11">
    <link rel="File-List" href="rpt_epfm00060_posli_filelist.xml">
    <link rel="Edit-Time-Data" href="editdata.mso">
    <link rel="OLE-Object-Data" href="oledata.mso">
    <!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
    <!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Poslilama</o:Author>
  <o:LastAuthor>Nguyen Thanh Xuan</o:LastAuthor>
  <o:LastPrinted>2010-10-07T03:13:13Z</o:LastPrinted>
  <o:Created>2010-09-30T09:06:31Z</o:Created>
  <o:LastSaved>2010-10-07T03:15:23Z</o:LastSaved>
  <o:Company>Poslilama</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
 <o:OfficeDocumentSettings>
  <o:DoNotOrganizeInFolder/>
 </o:OfficeDocumentSettings>
</xml><![endif]-->
    <style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in 0in .5in 0in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
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
.xl25
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl41
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
.xl42
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
.xl43
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
.xl44
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	mso-number-format:"yyyy\/mm\/dd";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	mso-number-format:"yyyy\/mm\/dd";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	mso-number-format:"yyyy\/mm\/dd";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
-->
</style>
    <!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Report</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>360</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>95</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>3</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>34</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8190</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Report!$7:$7</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
    <!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="5121"/>
</xml><![endif]-->
    <!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="4"/>
 </o:shapelayout></xml><![endif]-->
</head>
<body link="blue" vlink="purple" class="xl25">
    <table x:str border="0" cellpadding="0" cellspacing="0" width="1150" style='border-collapse: collapse;
        table-layout: fixed; width: 863pt'>
        <col class="xl25" width="83" style='mso-width-source: userset; mso-width-alt: 3035;
            width: 62pt'>
        <col class="xl25" width="75" span="2" style='mso-width-source: userset; mso-width-alt: 2742;
            width: 56pt'>
        <col class="xl25" width="177" style='mso-width-source: userset; mso-width-alt: 6473;
            width: 133pt'>
        <col class="xl25" width="56" style='mso-width-source: userset; mso-width-alt: 2048;
            width: 42pt'>
        <col class="xl29" width="64" span="2" style='width: 48pt'>
        <col class="xl29" width="72" style='mso-width-source: userset; mso-width-alt: 2633;
            width: 54pt'>
        <col class="xl29" width="106" style='mso-width-source: userset; mso-width-alt: 3876;
            width: 80pt'>
        <col class="xl25" width="102" style='mso-width-source: userset; mso-width-alt: 3730;
            width: 77pt'>
        <col class="xl25" width="78" style='mso-width-source: userset; mso-width-alt: 2852;
            width: 59pt'>
        <col class="xl25" width="119" style='mso-width-source: userset; mso-width-alt: 4352;
            width: 89pt'>
        <col class="xl25" width="79" style='mso-width-source: userset; mso-width-alt: 2889;
            width: 59pt'>
        <tr height="24" style='height: 18.0pt'>
            <td height="24" width="83" style='height: 18.0pt; width: 62pt' align="left" valign="top">
                <!--[if gte vml 1]><v:shapetype id="_x0000_t75" coordsize="21600,21600"
   o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe" filled="f"
   stroked="f">
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
  </v:shapetype><v:shape id="_x0000_s4097" type="#_x0000_t75" style='position:absolute;
   margin-left:.75pt;margin-top:2.25pt;width:129pt;height:21.75pt;z-index:1'>
   <v:imagedata src="rpt_epfm00060_posli_image001.jpg" o:title=""/>
  </v:shape><![endif]-->
                <![if !vml]><span style='mso-ignore: vglayout; position: absolute; z-index: 1; margin-left: 1px;
                    margin-top: 3px; width: 172px; height: 29px'>
                    <img width="172" height="29" src="rpt_epfm00060_posli_image002.jpg" v:shapes="_x0000_s4097"></span>
                <![endif]><span style='mso-ignore: vglayout2'>
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td height="24" class="xl25" width="83" style='height: 18.0pt; width: 62pt'>
                            </td>
                        </tr>
                    </table>
                </span>
            </td>
            <td class="xl25" width="75" style='width: 56pt'>
            </td>
            <td class="xl25" width="75" style='width: 56pt'>
            </td>
            <td class="xl25" width="177" style='width: 133pt'>
            </td>
            <td class="xl25" width="56" style='width: 42pt'>
            </td>
            <td class="xl29" width="64" style='width: 48pt'>
            </td>
            <td class="xl29" width="64" style='width: 48pt'>
            </td>
            <td class="xl29" width="72" style='width: 54pt'>
            </td>
            <td class="xl29" width="106" style='width: 80pt'>
            </td>
            <td class="xl25" width="102" style='width: 77pt'>
            </td>
            <td class="xl25" width="78" style='width: 59pt'>
            </td>
            <td class="xl25" width="119" style='width: 89pt'>
            </td>
            <td class="xl25" width="79" style='width: 59pt'>
            </td>
        </tr>
        <tr height="14" style='mso-height-source: userset; height: 10.5pt'>
            <td height="14" colspan="5" class="xl25" style='height: 10.5pt; mso-ignore: colspan'>
            </td>
            <td colspan="4" class="xl29" style='mso-ignore: colspan'>
            </td>
            <td colspan="4" class="xl25" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="24" style='mso-height-source: userset; height: 18.0pt'>
            <td height="24" class="xl27" colspan="4" style='height: 18.0pt; mso-ignore: colspan'>
                POSCO<span style='mso-spacerun: yes'> </span>Engineering &amp; contruction -VIET
                NAM Co.,Ltd</td>
            <td class="xl27">
            </td>
            <td colspan="4" class="xl29" style='mso-ignore: colspan'>
            </td>
            <td colspan="4" class="xl25" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="24" style='mso-height-source: userset; height: 18.0pt'>
            <td colspan="12" height="24" class="xl36" style='height: 18.0pt'>
                LIST OF MATERIAL DELIVERY<span style='mso-spacerun: yes'> </span>TO SITE</td>
            <td class="xl25">
            </td>
        </tr>
        <tr height="24" style='mso-height-source: userset; height: 18.0pt'>
            <td height="24" colspan="12" class="xl36" style='height: 18.0pt; mso-ignore: colspan'>
            </td>
            <td class="xl25">
            </td>
        </tr>
        <tr height="24" style='mso-height-source: userset; height: 18.0pt'>
            <td height="24" class="xl25" colspan="4" style='height: 18.0pt; mso-ignore: colspan'>
                From :
                <% =dt_From.ToString("dd/MM/yyyy")%>
                . To
                <%=dt_To.ToString("dd/MM/yyyy")%>
            </td>
            <td class="xl25">
            </td>
            <td colspan="4" class="xl29" style='mso-ignore: colspan'>
            </td>
            <td colspan="4" class="xl25" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr class="xl35" height="24" style='mso-height-source: userset; height: 18.0pt'>
            <td height="24" class="xl28" style='height: 18.0pt'>
                Invoice No.</td>
            <td class="xl28" style='border-left: none' x:str="Date ">
                Date<span style='mso-spacerun: yes'> </span>
            </td>
            <td class="xl28" style='border-left: none'>
                Code</td>
            <td class="xl28" style='border-left: none'>
                Item name</td>
            <td class="xl28" style='border-left: none'>
                Unit</td>
            <td class="xl34" style='border-left: none' x:str="Q'ty">
                <span style='mso-spacerun: yes'></span>Q'ty<span style='mso-spacerun: yes'> </span>
            </td>
            <td class="xl34" style='border-left: none' x:str="Weight">
                <span style='mso-spacerun: yes'></span>Weight<span style='mso-spacerun: yes'> </span>
            </td>
            <td class="xl34" style='border-left: none' x:str="U.P  (USD)">
                <span style='mso-spacerun: yes'></span>U.P<span style='mso-spacerun: yes'> </span>
                (USD)<span style='mso-spacerun: yes'> </span>
            </td>
            <td class="xl34" style='border-left: none' x:str="Amount (USD)">
                <span style='mso-spacerun: yes'></span>Amount (USD)<span style='mso-spacerun: yes'>
                </span>
            </td>
            <td class="xl28" style='border-left: none'>
                Receiver</td>
            <td class="xl28" style='border-left: none'>
                Truck no.</td>
            <td class="xl28" style='border-left: none'>
                Project</td>
            <td class="xl35">
            </td>
        </tr>
        <%
            totRow = 1;
            int rCurr = 8;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                totRow = totRow + i;
         
        %>
        <tr height="24" style='mso-height-source: userset; height: 18.0pt'>
            <td height="24" class="xl30" style='height: 18.0pt; border-top: none'>
                <%=dt.Rows[i]["invoice_no"] %>
            </td>
            <%if (dt.Rows[i]["doc_date"].Equals(DBNull.Value))
              { %>
            <td class="xl51" style='border-top: none; border-left: none'>
                <%=string.Empty%>
            </td>
            <%}
              else
              { %>
            <td class="xl51" style='border-top: none; border-left: none'>
                <%=DateTime.ParseExact(dt.Rows[i]["doc_date"].ToString(), "yyyyMMdd", System.Globalization.CultureInfo.CurrentCulture).ToString("dd/MM/yyyy")%>
            </td>
            <%} %>
            <td class="xl30" style='border-top: none; border-left: none'>
                <%=dt.Rows[i]["item_code"]%>
            </td>
            <td class="xl48" style='border-top: none; border-left: none'>
                <%=dt.Rows[i]["item_name"]%>
            </td>
            <td class="xl30" style='border-top: none; border-left: none'>
                <%=dt.Rows[i]["unit"]%>
            </td>
            <td class="xl31" style='border-top: none; border-left: none' x:num>
                <%=dt.Rows[i]["qty"]%>
            </td>
            <td class="xl31" style='border-top: none; border-left: none' x:num>
                <%=dt.Rows[i]["weight"]%>
            </td>
            <td class="xl31" style='border-top: none; border-left: none' x:num>
                <%=dt.Rows[i]["unit_price"]%>
            </td>
            <td class="xl31" style='border-top: none; border-left: none' x:num="0" x:fmla="=F<%=rCurr %>*H<%=rCurr %>">
            </td>
            <td class="xl30" style='border-top: none; border-left: none'>
                <%=dt.Rows[i]["receiver"]%>
            </td>
            <td class="xl30" style='border-top: none; border-left: none'>
                <%=dt.Rows[i]["vehicle_no"]%>
            </td>
            <td class="xl44" width="119" style='border-top: none; border-left: none; width: 89pt'>
                <%=dt.Rows[i]["tac_abpl_name"]%>
            </td>
            <td class="xl25">
            </td>
        </tr>
        <%
            rCurr = rCurr + 1;
        }
        int rAdd = dt.Rows.Count % 23;
        if (dt.Rows.Count <= 23)
            rAdd = 23 - dt.Rows.Count;
        for (int j = 0; j < rAdd; j++)
        {
        %>
        <tr height="24" style='mso-height-source: userset; height: 18.0pt'>
            <td height="24" class="xl32" style='height: 18.0pt; border-top: none'>
                &nbsp;</td>
            <td class="xl52" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl32" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl49" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl32" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl33" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl33" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl33" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl33" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl32" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl32" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl45" width="119" style='border-top: none; border-left: none; width: 89pt'>
                &nbsp;</td>
            <td class="xl25">
            </td>
        </tr>
        <%}

          totRow = dt.Rows.Count + 8 - 1;
        %>
        <!--
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 width=119 style='border-top:none;border-left:none;width:89pt'>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 width=119 style='border-top:none;border-left:none;width:89pt'>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 width=119 style='border-top:none;border-left:none;width:89pt'>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 width=119 style='border-top:none;border-left:none;width:89pt'>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 width=119 style='border-top:none;border-left:none;width:89pt'>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 width=119 style='border-top:none;border-left:none;width:89pt'>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 width=119 style='border-top:none;border-left:none;width:89pt'>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 width=119 style='border-top:none;border-left:none;width:89pt'>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 width=119 style='border-top:none;border-left:none;width:89pt'>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 width=119 style='border-top:none;border-left:none;width:89pt'>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 width=119 style='border-top:none;border-left:none;width:89pt'>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 width=119 style='border-top:none;border-left:none;width:89pt'>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 width=119 style='border-top:none;border-left:none;width:89pt'>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 width=119 style='border-top:none;border-left:none;width:89pt'>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 width=119 style='border-top:none;border-left:none;width:89pt'>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 width=119 style='border-top:none;border-left:none;width:89pt'>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 width=119 style='border-top:none;border-left:none;width:89pt'>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 width=119 style='border-top:none;border-left:none;width:89pt'>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 width=119 style='border-top:none;border-left:none;width:89pt'>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 width=119 style='border-top:none;border-left:none;width:89pt'>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl37 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl46 width=119 style='border-top:none;border-left:none;width:89pt'>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 -->
        <tr class="xl40" height="24" style='mso-height-source: userset; height: 18.0pt'>
            <td colspan="4" height="24" class="xl41" style='border-right: .5pt solid black; height: 18.0pt'>
                Total</td>
            <td class="xl26" style='border-left: none'>
                &nbsp;</td>
            <td class="xl39" style='border-left: none' x:num="0" x:fmla="=SUM(F8:F<%=totRow %>)">
                <span style='mso-spacerun: yes'></span>-<span style='mso-spacerun: yes'> </span>
            </td>
            <td class="xl39" style='border-left: none' x:num="0" x:fmla="=SUM(G8:G<%=totRow %>)">
                <span style='mso-spacerun: yes'></span>-<span style='mso-spacerun: yes'> </span>
            </td>
            <td class="xl39" style='border-left: none'>
                &nbsp;</td>
            <td class="xl39" style='border-left: none' x:num="0" x:fmla="=SUM(I8:I<%=totRow %>)">
                <span style='mso-spacerun: yes'></span>-<span style='mso-spacerun: yes'> </span>
            </td>
            <td class="xl39" style='border-left: none'>
                &nbsp;</td>
            <td class="xl39" style='border-left: none'>
                &nbsp;</td>
            <td class="xl47" width="119" style='border-left: none; width: 89pt'>
                &nbsp;</td>
            <td class="xl40">
            </td>
        </tr>
        <![if supportMisalignedColumns]>
        <tr height="0" style='display: none'>
            <td width="83" style='width: 62pt'>
            </td>
            <td width="75" style='width: 56pt'>
            </td>
            <td width="75" style='width: 56pt'>
            </td>
            <td width="177" style='width: 133pt'>
            </td>
            <td width="56" style='width: 42pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="72" style='width: 54pt'>
            </td>
            <td width="106" style='width: 80pt'>
            </td>
            <td width="102" style='width: 77pt'>
            </td>
            <td width="78" style='width: 59pt'>
            </td>
            <td width="119" style='width: 89pt'>
            </td>
            <td width="79" style='width: 59pt'>
            </td>
        </tr>
        <![endif]>
    </table>
</body>
</html>
