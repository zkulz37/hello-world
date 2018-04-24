<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%@ Import Namespace = "System"%>
<%@ Import Namespace = "System.Text.RegularExpressions"%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
    
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
            ESysLib.SetUser("acnt");
            
            string l_status = Request["p_status"];
            string l_tco_company_pk = Request["p_tco_company_pk"];
            string l_date_fr = Request["p_date_fr"];
            string l_date_to = Request["p_date_to"];
            string l_kind = Request["p_kind"];
            string l_date_type = Request["p_date_type"];
            string l_scale = Request["p_scale"];
    
   // + rbstatus.GetData() +'&p_company_pk=' + lstCompany.GetData() + '&p_date_f=' + dtfrdate.GetData() + '&p_date_t=' + dttodate.GetData() + 
   //     '&p_kind=' + txtFinancialType.GetData() + '&p_date_type=' + txtDateType.GetData() + '&p_scale=' + txtScale.GetData()+ '&p_crt_by=' + emp_id;
    
            string l_parameter = "'" + l_kind + "','" + l_status + "','" + l_tco_company_pk + "','" + l_date_fr + "','" + l_date_to + "','" + l_date_type + "','" + l_scale + "'";
            DataTable dt = ESysLib.TableReadOpenCursor("ACNT.sp_sel_gfka00210_3", l_parameter);  
            if (dt.Rows.Count == 0)
            {
                Response.Write("There is no data");
                Response.End();
            }
            l_date_to = l_date_to.Substring(4, 2) + "/" + l_date_to.Substring(0, 4);// +"." + l_dtto.Substring(6, 2);//2009.08.25  
            string SQL1 = " select (TO_CHAR(ADD_MONTHS(TO_DATE('" + l_date_fr + "', 'yyyymmdd'), -1) , 'yyyymmdd')) dtfrom,(TO_CHAR(ADD_MONTHS(TO_DATE('" + l_date_fr + "', 'yyyymmdd'), -12) , 'yyyymmdd')) dtTo,(TO_CHAR(TO_DATE('" + l_date_fr + "', 'yyyymmdd') , 'yyyymmdd')) dtTo1 from dual ";
            string l_lastMonth = "", l_lastYear = "", l_firtMonthlastYear = "", l_curMonthlastYear = "";
            DataTable dt1 = ESysLib.TableReadOpen(SQL1);
            if (dt1.Rows.Count > 0)
            {
                l_lastMonth = dt1.Rows[0][0].ToString();
                l_lastYear = dt1.Rows[0][1].ToString();
                l_firtMonthlastYear = dt1.Rows[0][1].ToString();
                l_curMonthlastYear = dt1.Rows[0][2].ToString();
            }

            l_lastMonth = l_lastMonth.Substring(4, 2) + "/" + l_lastMonth.Substring(0, 4);
            l_lastYear = l_lastYear.Substring(4, 2) + "/" + l_lastYear.Substring(0, 4);
            l_firtMonthlastYear = "01" + "/" + l_firtMonthlastYear.Substring(0, 4);
            l_curMonthlastYear = "01" + "/" + l_curMonthlastYear.Substring(0, 4);
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00120_bs_month_3_type3_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00120_bs_month_3_type3_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00120_bs_month_3_type3_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2009-03-18T01:27:41Z</o:LastPrinted>
  <o:Created>2001-09-01T01:02:36Z</o:Created>
  <o:LastSaved>2009-09-30T07:55:56Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .25in .25in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;}
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
	color:black;
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
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
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
	color:aqua;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:black;
	mso-pattern:auto none;}
.xl25
	{mso-style-parent:style0;
	color:aqua;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:black;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	color:aqua;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"d\\-mmm";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom::.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl41
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"d\\-mmm";
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom::.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>cashflow analysis2</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>75</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>7</x:SplitHorizontal>
     <x:TopRowBottomPane>7</x:TopRowBottomPane>
     <x:SplitVertical>1</x:SplitVertical>
     <x:LeftColumnRightPane>1</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9120</x:WindowHeight>
  <x:WindowWidth>7650</x:WindowWidth>
  <x:WindowTopX>7665</x:WindowTopX>
  <x:WindowTopY>-15</x:WindowTopY>
  <x:TabRatio>394</x:TabRatio>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl26>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1704 style='border-collapse:
 collapse;table-layout:fixed;width:1282pt'>
 <col class=xl26 width=117 span=2 style='mso-width-source:userset;mso-width-alt:
 4278;width:88pt'>
 <col class=xl26 width=121 style='mso-width-source:userset;mso-width-alt:4425;
 width:91pt'>
 <col class=xl28 width=121 span=3 style='mso-width-source:userset;mso-width-alt:
 4425;width:91pt'>
 <col class=xl26 width=121 style='mso-width-source:userset;mso-width-alt:4425;
 width:91pt'>
 <col class=xl26 width=117 span=2 style='mso-width-source:userset;mso-width-alt:
 4278;width:88pt'>
 <col class=xl28 width=121 span=4 style='mso-width-source:userset;mso-width-alt:
 4425;width:91pt'>
 <col class=xl26 width=121 style='mso-width-source:userset;mso-width-alt:4425;
 width:91pt'>
 <col class=xl26 width=26 style='mso-width-source:userset;mso-width-alt:950;
 width:20pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=2 width=234 style='height:15.75pt;
  mso-ignore:colspan;width:176pt' x:str="Cash Flow Analysis ">Cash Flow
  Analysis<span style='mso-spacerun:yes'> </span></td>
  <td class=xl26 width=121 style='width:91pt'></td>
  <td class=xl27 width=121 style='width:91pt'></td>
  <td class=xl27 width=121 style='width:91pt'></td>
  <td class=xl27 width=121 style='width:91pt'></td>
  <td class=xl26 width=121 style='width:91pt'></td>
  <td class=xl26 width=117 style='width:88pt'></td>
  <td class=xl26 width=117 style='width:88pt'></td>
  <td class=xl28 width=121 style='width:91pt'></td>
  <td class=xl28 width=121 style='width:91pt'></td>
  <td class=xl28 width=121 style='width:91pt'></td>
  <td class=xl28 width=121 style='width:91pt'></td>
  <td class=xl26 width=121 style='width:91pt'></td>
  <td class=xl26 width=26 style='width:20pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl29 colspan=2 style='height:15.75pt;mso-ignore:colspan'>1.
  Balance Sheet Comparison</td>
  <td class=xl26></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl30 align=right style='height:15.75pt' x:str><%=l_date_to %></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl26><span style='mso-spacerun:yes'>     </span>(Unit:&nbsp;<%=l_scale%> &nbsp;VND)</td>
  <td class=xl26></td>
  <td class=xl32></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=3 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl42 style='height:16.5pt'>&nbsp;</td>
  <td class=xl33 style='border-left:none'>Item</td>
  <td class=xl43 style='border-left:none'><%=l_lastYear %></td>
  <td class=xl44 style='border-left:none'><%=l_lastMonth%></td>
  <td class=xl44 style='border-left:none'><%=l_date_to%></td>
  <td class=xl44 style='border-left:none'>variance</td>
  <td class=xl45 style='border-left:none'>variance</td>
  <td class=xl48 style='border-left:none'>&nbsp;</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl34 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td class=xl35 style='border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-left:none'>A</td>
  <td class=xl37 style='border-left:none'>B</td>
  <td class=xl37 style='border-left:none'>C</td>
  <td class=xl37 style='border-left:none'>C-B</td>
  <td class=xl46 style='border-top:none;border-left:none'>C-A</td>
  <td class=xl49 style='border-left:none'>&nbsp;</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <%
     string  l_prn_no = "", xx="";
     int color = 0;
     string strBegin = "";
     string strEnd = "";
     for (int i = 0; i < dt.Rows.Count; i++)
     {
         color = int.Parse(dt.Rows[i][11].ToString());
         strBegin = "";
         strEnd = "";
         if (dt.Rows[i][5].ToString() == "B")
         {
             strBegin = "<b>";
             strEnd = "</b>";
         }
         //l_prn_no = color.Substring(0, 1);
      %>

 <tr height=21 style='height:15.75pt'>
 <%
     if (color == 1 || color == 2 || color == 4 || color == 5)
     { 
         %>
      <td height=21 class=xl53 style='height:15.75pt'><%=strBegin %><%= dt.Rows[i][2].ToString()%><%=strEnd%></td>
      <td class=xl38 style='border-left:none'></td>
      <td class=xl50 style='border-left:none' x:num><%=strBegin %><%= dt.Rows[i][6].ToString()%><%=strEnd%></td>
      <td class=xl51 style='border-left:none' x:num><%=strBegin %><%= dt.Rows[i][7].ToString()%><%=strEnd%></td>
      <td class=xl51 style='border-left:none' x:num><%=strBegin %><%= dt.Rows[i][8].ToString()%><%=strEnd%></td>
      <td class=xl52 style='border-bottom:.5pt solid windowtext' x:num><%=strBegin %><%= dt.Rows[i][9].ToString()%><%=strEnd%></td>
      <td class=xl39 style='border-bottom:.5pt solid windowtext' align=right x:num><%=strBegin %><%= dt.Rows[i][10].ToString()%><%=strEnd%></td>
      <td colspan=8 class=xl26 style='mso-ignore:colspan'></td>     
  <%  
     }
     else
     {         
  %>
  <td height=21 class=xl53 style='height:15.75pt'></td> 
  <td class=xl38 style='border-left:none'><%=strBegin %><%= dt.Rows[i][2].ToString()%><%=strEnd%></td>
  <td class=xl50 style='border-left:none' x:num><%=strBegin %><%= dt.Rows[i][6].ToString()%><%=strEnd%></td>
  <td class=xl51 style='border-left:none' x:num><%=strBegin %><%= dt.Rows[i][7].ToString()%><%=strEnd%></td>
  <td class=xl51 style='border-left:none' x:num><%=strBegin %><%= dt.Rows[i][8].ToString()%><%=strEnd%></td>
  <td class=xl52 style='border-bottom:.5pt solid windowtext' x:num><%=strBegin %><%= dt.Rows[i][9].ToString()%><%=strEnd%></td>
  <td class=xl39 style='border-bottom:.5pt solid windowtext' align=right x:num><%=strBegin %><%= dt.Rows[i][10].ToString()%><%=strEnd%></td>
  <td colspan=8 class=xl26 style='mso-ignore:colspan'></td>     
 
    <%
     }
     %>   
 </tr>
 <%
     }    
        %>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl47 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none'>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td colspan=8 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=7 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=26 style='width:20pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
