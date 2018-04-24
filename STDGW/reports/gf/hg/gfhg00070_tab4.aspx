<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    ESysLib.SetUser("acnt");
    string l_company = Request["Company"];
	string l_date_from = Request["DateFrom"];
	string l_date_to = Request["DateTo"];
	string l_voucher = Request["Voucher"];
	string l_Seq = Request["Seq"];
	string l_status = Request["Status"];
	string l_bookCcy = Request["BookCcy"];
	string l_acc_dr  = Request["AccDr"];
	string l_acc_cr = Request["AccCr"];
	string l_direct_code  = Request["DirectCode"];
	string l_indirect_code  = Request["IndirectCode"];

    String p_xls_ccy_format ="";
    String p_xls_ccy_format_usd = "";
   
    string l_cmp_name="";
	string l_cmp_add ="";
	string l_cmp_taxcode="";
	string p_status = "";
	string p_dt_from ="";
	string p_dt_to ="";
	string p_dt_today = "";
	int i=0;
	 
    if (l_bookCcy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
   
   string SQL = " SELECT PARTNER_NAME,ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + l_company + "' ";
	
	DataTable dt = ESysLib.TableReadOpen(SQL);
	if (dt.Rows.Count >0)
	{
		l_cmp_name = dt.Rows[0][0].ToString();
		l_cmp_add = dt.Rows[0][1].ToString();
		l_cmp_taxcode = dt.Rows[0][3].ToString();
	}
    
    SQL = " SELECT TO_CHAR(TO_DATE('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') DT_FR,  TO_CHAR(TO_DATE('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') DT_TO, ";
    SQL = SQL + " INITCAP(To_char (sysdate, 'day, month dd  yyyy')) ";
    SQL = SQL + " FROM DUAL ";

    dt = ESysLib.TableReadOpen(SQL);
	if (dt.Rows.Count >0)
	{
	    p_dt_from = dt.Rows[0][0].ToString();
		p_dt_to = dt.Rows[0][1].ToString();
		p_dt_today = dt.Rows[0][2].ToString();
		
	}
	
	if (l_status == "2")
    {
		p_status = "Confirmed";
    }
	else if (l_status == "0") 
    {
		p_status = "Approved";
    }
	else if (l_status == "4" )
    {
		p_status = "Not Approved";
    }
	
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfhg00070_tab5_files/filelist.xml">
<link rel=Edit-Time-Data href="gfhg00070_tab5_files/editdata.mso">
<link rel=OLE-Object-Data href="gfhg00070_tab5_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>Phan Thi Thanh Tuyen</o:LastAuthor>
  <o:LastPrinted>2011-07-14T03:09:41Z</o:LastPrinted>
  <o:Created>2009-04-15T01:30:16Z</o:Created>
  <o:LastSaved>2011-07-14T04:01:07Z</o:LastSaved>
  <o:Company>vinagenuwin</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-header-data:&R&D&T;
	mso-footer-data:"Page &P of &N";
	margin:.75in .25in .25in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
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
	font-family:Tahoma;
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
	font-family:Tahoma;
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
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
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
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>94</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>4</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9255</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1560</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$A$5:$G$5</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$5:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=846 style='border-collapse:
 collapse;table-layout:fixed;width:635pt'>
 <col class=xl24 width=52 style='mso-width-source:userset;mso-width-alt:1901; width:39pt'> <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=73 span=1 style='mso-width-source:userset;mso-width-alt: 2669;width:55pt'>
 <col class=xl24 width=332 style='mso-width-source:userset;mso-width-alt:12141; width:249pt'>
 <col class=xl24 width=128 style='mso-width-source:userset;mso-width-alt:4681; width:96pt'>
 <col class=xl24 width=332 style='mso-width-source:userset;mso-width-alt:12141; width:249pt'>
 <col class=xl24 width=124 style='mso-width-source:userset;mso-width-alt:4534; width:93pt'>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl29 colspan=5 width=390 style='height:18.75pt;
  mso-ignore:colspan;width:293pt'>DAILY ENTRY INQUIRY CASH FLOW</td>
  <td class=xl26 width=332 style='width:249pt'></td>
  <td class=xl24 width=124 style='width:93pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 colspan=3 style='height:15.0pt;mso-ignore:colspan'>as
  at <%=  p_dt_today %></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl26 colspan=2 style='height:15.0pt;mso-ignore:colspan'>Company:</td>
  <td class=xl25></td>
  <td class=xl27 width=73 style='width:55pt'><%= l_cmp_name %></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'>Period:<%= p_dt_from %> ~ <%=p_dt_to %></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=7 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl32 height=38 style='height:28.5pt'>
  <td height=38 class=xl31 id="_x0000_s1025" x:autofilter="all"
  x:autofilterrange="$A$5:$G$5" width=52 style='height:28.5pt;width:39pt'>Direct
  Code</td>
  <td class=xl31 id="_x0000_s1026" x:autofilter="all" width=64
  style='border-left:none;width:48pt'>InDirect Code</td>
  <td class=xl31 id="_x0000_s1027" x:autofilter="all" width=73
  style='border-left:none;width:55pt'>Debit Code</td>
  <td class=xl31 id="_x0000_s1029" x:autofilter="all" width=73
  style='border-left:none;width:55pt'>Debit Name</td>
  <td class=xl31 id="_x0000_s1033" x:autofilter="all" width=128
  style='border-left:none;width:96pt'>Credit Code</td>
  <td class=xl31 id="_x0000_s1032" x:autofilter="all" width=332
  style='border-left:none;width:249pt'>Credit Name</td>
  <td class=xl31 id="_x0000_s1031" x:autofilter="all" width=124
  style='border-left:none;width:93pt'>Amount</td>
 </tr>
  <%  

        string l_DNDT ="DN";
        string l_parameter = "'" + l_company + "','" + l_Seq + "','" + l_voucher + "','" + l_date_from + "','" + l_date_to + "','" + l_acc_dr + "','" + l_acc_cr + "','" + l_status + "','" + l_indirect_code + "','" + l_indirect_code + "','" + l_DNDT + "'" ;
%>
 <%
       
     string sp = "SP_SEL_DAILY_CF_ACCD";
	 dt = ESysLib.TableReadOpenCursor(sp,l_parameter); 
        
	if (dt.Rows.Count >0)
	{
	    for(i=0;i<dt.Rows.Count;i++)
	    {
              %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl30 style='height:15.0pt' ><%= dt.Rows[i][0].ToString() %></td>
  <td class=xl30 style='border-left:none' ><%= dt.Rows[i][1].ToString() %></td>
  <td class=xl33 style='border-left:none' x:num><%= dt.Rows[i][2].ToString() %></td>
  <td class=xl33 style='border-left:none' x:num><%= dt.Rows[i][3].ToString() %></td>
  <td class=xl33 style='border-left:none' x:num><%= dt.Rows[i][4].ToString() %></td>
  <td class=xl30 style='border-left:none'><%= dt.Rows[i][5].ToString() %></td>
  <td class=xl34 style='border-left:none' x:num=""><%= dt.Rows[i][6].ToString() %></td>
 </tr>
   <%
        } 
    }
  %>
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=52 style='width:39pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=128 style='width:96pt'></td>
  <td width=332 style='width:249pt'></td>
  <td width=124 style='width:93pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
