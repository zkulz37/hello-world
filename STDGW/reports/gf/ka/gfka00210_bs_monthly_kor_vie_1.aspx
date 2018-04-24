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
            string l_kind = Request["p_kind"];
            string l_status = Request["p_status"];
            string l_tco_company_pk = Request["p_tco_company_pk"];
            string l_date_fr = Request["p_date_fr"];
            string l_date_to = Request["p_date_to"];
            string l_date_type = Request["p_date_type"];
            string l_scale = Request["p_scale"];
            string l_lastMonth = "", l_lastYear = "", l_firtMonthlastYear = "", l_curMonthlastYear = "";
            string l_parameter = "'" + l_kind + "','" + l_status + "','" + l_tco_company_pk + "','" + l_date_fr + "','" + l_date_to + "','" + l_date_type + "','" + l_scale + "'";
            DataTable dt = ESysLib.TableReadOpenCursor("ACNT.sp_sel_gfka00210_3_1", l_parameter);  
            if (dt.Rows.Count == 0)
            {
                Response.Write("There is no data");
                Response.End();
            }
            //l_date_fr = l_date_fr.Substring(4, 2)+ "/" + l_date_fr.Substring(0, 4);//2009.08.25
            l_date_to = l_date_to.Substring(4, 2) + "/" + l_date_to.Substring(0, 4);// +"." + l_dtto.Substring(6, 2);//2009.08.25  
            string SQL1 = " select (TO_CHAR(ADD_MONTHS(TO_DATE('" + l_date_fr + "', 'yyyymmdd'), -1) , 'yyyymmdd')) dtfrom,(TO_CHAR(ADD_MONTHS(TO_DATE('" + l_date_fr + "', 'yyyymmdd'), -12) , 'yyyymmdd')) dtTo,(TO_CHAR(TO_DATE('" + l_date_fr + "', 'yyyymmdd') , 'yyyymmdd')) dtTo1 from dual ";

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
<link rel=File-List href="sh111_files/filelist.xml">
<link rel=Edit-Time-Data href="sh111_files/editdata.mso">
<link rel=OLE-Object-Data href="sh111_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2009-03-18T01:27:41Z</o:LastPrinted>
  <o:Created>2001-09-01T01:02:36Z</o:Created>
  <o:LastSaved>2009-10-12T09:30:06Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .25in .25in .25in;
	mso-header-margin:.25in;
	mso-footer-margin:0in;
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
	color:windowtext;
	text-align:right;	
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl26
	{mso-style-parent:style0;
	color:aqua;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:black;
	mso-pattern:auto none;}
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
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl30
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
.xl31
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl32
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
	border-left:none;}
.xl34
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
	border-left:none;}
.xl35
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
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
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
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"d\\-mmm";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl42
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
	border-left:none;}
.xl43
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
	border-left:none;}
.xl44
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
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"d\\-mmm";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
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
.xl52
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
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
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-number-format:Standard;}
.xl58
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
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
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>cashflow analysis</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>60</x:Scale>
      <x:HorizontalResolution>-3</x:HorizontalResolution>
      <x:VerticalResolution>-3</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8400</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1935</x:WindowTopY>
  <x:TabRatio>394</x:TabRatio>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1678 style='border-collapse:
 collapse;table-layout:fixed;width:1262pt'>
 <col class=xl24 width=117 span=2 style='mso-width-source:userset;mso-width-alt:
 4278;width:88pt'>
 <col class=xl24 width=117 span=2 style='mso-width-source:userset;mso-width-alt:
 4278;width:88pt'>
 <col class=xl24 width=117 span=2 style='mso-width-source:userset;mso-width-alt:
 4278;width:88pt'>
 <col class=xl24 width=121 style='mso-width-source:userset;mso-width-alt:4425;
 width:91pt'>
 <col class=xl25 width=121 span=3 style='mso-width-source:userset;mso-width-alt:
 4425;width:91pt'>
 <col class=xl24 width=121 style='mso-width-source:userset;mso-width-alt:4425;
 width:91pt'>
 <col class=xl24 width=117 span=2 style='mso-width-source:userset;mso-width-alt:
 4278;width:88pt'>
 <col class=xl25 width=121 span=4 style='mso-width-source:userset;mso-width-alt:
 4425;width:91pt'>
 <col class=xl24 width=121 style='mso-width-source:userset;mso-width-alt:4425;
 width:91pt'>
 <col class=xl24 width=26 style='mso-width-source:userset;mso-width-alt:950;
 width:20pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl26 colspan=2 width=234 style='height:15.75pt;
  mso-ignore:colspan;width:176pt' x:str="Cash Flow Analysis ">Cash Flow
  Analysis<span style='mso-spacerun:yes'> </span></td>
  <td class=xl24 width=121 style='width:91pt'></td>
  <td class=xl27 width=121 style='width:91pt'></td>
  <td class=xl27 width=121 style='width:91pt'></td>
  <td class=xl27 width=121 style='width:91pt'></td>
  <td class=xl24 width=121 style='width:91pt'></td>
  <td class=xl24 width=117 style='width:88pt'></td>
  <td class=xl24 width=117 style='width:88pt'></td>
  <td class=xl25 width=121 style='width:91pt'></td>
  <td class=xl25 width=121 style='width:91pt'></td>
  <td class=xl25 width=121 style='width:91pt'></td>
  <td class=xl25 width=121 style='width:91pt'></td>
  <td class=xl24 width=121 style='width:91pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 colspan=2 style='height:15.75pt;mso-ignore:colspan'>1.
  Balance Sheet Comparison</td>
  <td class=xl24></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl29 style='height:15.75pt'><%=l_date_to%></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=3 class=xl24 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24 colspan="5"><span style='mso-spacerun:yes'>     </span>(Unit:&nbsp;<%=l_scale%> &nbsp;VND)</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl32 style='height:16.5pt'>&nbsp;</td>
  <td class=xl33>Item</td>
  <td class=xl60></td>
  <td class=xl60>Chỉ Tiêu</td>
  <td class=xl34><%=l_lastYear %></td>
  <td class=xl35><%=l_lastMonth%></td>
  <td class=xl35><%=l_date_to%></td>
  <td class=xl35>variance</td>
  <td class=xl36>variance</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl33>Item</td>
  <td class=xl60></td>
  <td class=xl60>Chỉ Tiêu</td>
  <td class=xl38><%=l_lastYear %></td>
  <td class=xl35><%=l_lastMonth%></td>
  <td class=xl35><%=l_date_to%></td>
  <td class=xl39>variance</td>
  <td class=xl40>variance</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl41 style='height:15.75pt'>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td height=21 class=xl41 style='height:15.75pt'>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl43>A</td>
  <td class=xl44>B</td>
  <td class=xl44>C</td>
  <td class=xl44>C-A</td>
  <td class=xl45>C-B</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl48>A</td>
  <td class=xl49>B</td>
  <td class=xl49>C</td>
  <td class=xl50>C-A</td>
  <td class=xl51>C-B</td>
 </tr>
 <%
     string  color_p = "", l_prn_no_p = "";
     int color_1 ;
     string strBegin = "";
     string strEnd = "";
     int p = (dt.Rows.Count) / 2, color = 0; 
     int l_Creditor_row = 0;
     for (int i = 0; i < p; i++)
     {
         color = int.Parse(dt.Rows[i][11].ToString());
         strBegin = "";
         strEnd = "";
         if (dt.Rows[i][5].ToString() == "B")
         {
             strBegin = "<b>";
             strEnd = "</b>";
         }
      %>
 <tr height=21 style='height:15.75pt'>
 <%
     if (color == 1 || color == 2 || color == 4 || color == 5)
     {         
%>        
  <td height=21 class=xl52 style='height:15.75pt'><%=strBegin %><%= dt.Rows[i][2].ToString()%><%=strEnd%></td>
  <td class=xl53></td>
  <td height=21 class=xl52 style='height:15.75pt'><%=strBegin %><%= dt.Rows[i][1].ToString()%><%=strEnd%></td>
  <td class=xl53></td>
  <td class=xl55 x:num><%=strBegin %><%= dt.Rows[i][6].ToString()%><%=strEnd%> </td>
  <td class=xl56 x:num><%=strBegin %><%= dt.Rows[i][7].ToString()%><%=strEnd%> </td>
  <td class=xl56 x:num><%=strBegin %><%= dt.Rows[i][8].ToString()%><%=strEnd%></td>
  <td class=xl56 x:num><%=strBegin %><%= dt.Rows[i][9].ToString()%><%=strEnd%> </td>
  <td class=xl57 align=right x:num><%=strBegin %><%= dt.Rows[i][10].ToString()%><%=strEnd%> </td>
  <% 
      color_1 = int.Parse(dt.Rows[i + p][11].ToString());
      if (color_1 != 3)
         {
  %>
  <td class=xl58><%=strBegin %><%= dt.Rows[i + p][2].ToString()%><%=strEnd%></td>
  <td class=xl54>&nbsp;</td>
  <td class=xl58><%=strBegin %><%= dt.Rows[i + p][1].ToString()%><%=strEnd%></td>
  <td class=xl54>&nbsp;</td>
  <% 
        }
         else
         {
  %>
  <td class=xl58></td>
  <td class=xl54><%=strBegin %><%= dt.Rows[i + p][2].ToString()%><%=strEnd%></td>
  <td class=xl58></td>
  <td class=xl54><%=strBegin %><%= dt.Rows[i + p][1].ToString()%><%=strEnd%></td>
   <% 
         }
  %>
  <td class=xl59 x:num><%=strBegin %><%= dt.Rows[i + p][6].ToString()%><%=strEnd%> </td>
  <td class=xl59 x:num><%=strBegin %><%= dt.Rows[i + p][7].ToString()%><%=strEnd%> </td>
  <td class=xl59 x:num><%=strBegin %><%= dt.Rows[i + p][8].ToString()%><%=strEnd%> </td>
  <td class=xl56 x:num><%=strBegin %><%= dt.Rows[i + p][9].ToString()%><%=strEnd%> </td>
  <td class=xl57 align=right x:num><%=strBegin %><%= dt.Rows[i + p][10].ToString()%><%=strEnd%></td>
   <%  
     }
     else // truong hop 3
     {         
  %>
  <td height=21 class=xl52 style='height:15.75pt'></td>
  <td class=xl53><%=strBegin %><%= dt.Rows[i][2].ToString()%><%=strEnd%></td>
  <td class=xl53><%=strBegin %><%= dt.Rows[i][1].ToString()%><%=strEnd%></td>
  <td class=xl54>&nbsp;</td>
  <td class=xl55 x:num><%=strBegin %><%= dt.Rows[i][6].ToString()%> <%=strEnd%></td>
  <td class=xl56 x:num><%=strBegin %><%= dt.Rows[i][7].ToString()%><%=strEnd%> </td>
  <td class=xl56 x:num><%=strBegin %><%=strBegin %><%= dt.Rows[i][8].ToString()%><%=strEnd%></td>
  <td class=xl56 x:num><%=strBegin %><%= dt.Rows[i][9].ToString()%> <%=strEnd%></td>
  <td class=xl57 align=right x:num><%=strBegin %><%= dt.Rows[i][10].ToString()%> <%=strEnd%></td>
  <% 
      color_1 = int.Parse(dt.Rows[i + p][11].ToString());
      if (color_1 != 3)
         {
  %>
  <td class=xl58><%=strBegin %><%= dt.Rows[i + p][2].ToString()%><%=strEnd%></td>
  <td class=xl54>&nbsp;</td>
  <td class=xl58><%=strBegin %><%= dt.Rows[i + p][1].ToString()%><%=strEnd%></td>
  <td class=xl54>&nbsp;</td>
  <% 
        }
         else
         {
  %>
  <td class=xl58></td>
  <td class=xl54><%=strBegin %><%= dt.Rows[i + p][2].ToString()%><%=strEnd%></td>
  <td class=xl58></td>
  <td class=xl54><%=strBegin %><%= dt.Rows[i + p][1].ToString()%><%=strEnd%></td>
   <% 
         }
  %>
  <td class=xl59 x:num><%=strBegin %><%= dt.Rows[i + p][6].ToString()%> <%=strEnd%></td>
  <td class=xl59 x:num=><%=strBegin %><%= dt.Rows[i + p][7].ToString()%> <%=strEnd%></td>
  <td class=xl59 x:num><%=strBegin %><%= dt.Rows[i + p][8].ToString()%> <%=strEnd%></td>
  <td class=xl56 x:num><%=strBegin %><%= dt.Rows[i + p][9].ToString()%> <%=strEnd%></td>
  <td class=xl57 align=right x:num><%=strBegin %><%= dt.Rows[i + p][10].ToString()%><%=strEnd%></td>
 <%
     }
     %>   
 </tr>
 <%
     } //for   
        %>
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
 </tr>
 <![endif]>
</table>

</body>

</html>
