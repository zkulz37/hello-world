<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%@ Import Namespace = "System"%>
<%@ Import Namespace = "System.Text.RegularExpressions"%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
    ESysLib.SetUser(Session["APP_DBUSER"].ToString());
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
		string l_status = Request["p_status"];
		string l_tco_company_pk = Request["p_tco_company_pk"];
		string l_date_fr = Request["p_date_fr"];
		string l_date_to = Request["p_date_to"];
		string l_kind = Request["p_kind"];
		string l_date_type = Request["p_date_type"];
		string l_scale = Request["p_scale"];
		string l_lang = Request["lang"];
		string l_Exrate = Request["p_Exrate"];
    
   // + rbstatus.GetData() +'&p_company_pk=' + lstCompany.GetData() + '&p_date_f=' + dtfrdate.GetData() + '&p_date_t=' + dttodate.GetData() + 
   //     '&p_kind=' + txtFinancialType.GetData() + '&p_date_type=' + txtDateType.GetData() + '&p_scale=' + txtScale.GetData()+ '&p_crt_by=' + emp_id;
    
            string l_parameter = "'" + l_tco_company_pk + "','" + l_date_fr + "','" + l_date_to + "','" + l_status + "','" + l_scale + "','" + l_Exrate + "'";
            
			DataTable dt = ESysLib.TableReadOpenCursor("ac_sel_60080260_bs_internal", l_parameter);  
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
            //l_dtfrom = l_dtfrom.Substring(0, 4) + "." + l_dtfrom.Substring(4, 2) + "." + l_dtfrom.Substring(6, 2);//2009.08.25
            //l_dtto = l_dtto.Substring(0, 4) + "." + l_dtto.Substring(4, 2) + "." + l_dtto.Substring(6, 2);//2009.08.25   
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="BS_files/filelist.xml">
<link rel=Edit-Time-Data href="BS_files/editdata.mso">
<link rel=OLE-Object-Data href="BS_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Kenzie</o:LastAuthor>
  <o:LastPrinted>2013-04-12T08:25:03Z</o:LastPrinted>
  <o:Created>2001-09-01T01:02:36Z</o:Created>
  <o:LastSaved>2013-04-12T08:25:21Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .25in .25in .25in;
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
	color:windowtext;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
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
	color:red;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl36
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl39
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
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl40
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
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"d\\-mmm";
	text-align:center;
	border:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>BS</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>56</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>7</x:SplitHorizontal>
     <x:TopRowBottomPane>7</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>3</x:LeftColumnRightPane>
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
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=2487 style='border-collapse: collapse;table-layout:fixed;width:1868pt'>
<%
	if(l_lang=="ENG")
	{
%>
 <col class=xl24 width=215 style='mso-width-source:userset;mso-width-alt: 7862;width:161pt;'>
 <col class=xl24 width=127 style='mso-width-source:userset;mso-width-alt:7862; width:161pt;display:none'>
 <col class=xl24 width=117 style='mso-width-source:userset;mso-width-alt:7862; width:161pt;display:none'>
<%
	}
	else if(l_lang=="VIE")
	{
%>
<col class=xl24 width=215 style='mso-width-source:userset;mso-width-alt: 7862;width:161pt;display:none'>
 <col class=xl24 width=127 style='mso-width-source:userset;mso-width-alt:7862; width:95pt;'>
 <col class=xl24 width=117 style='mso-width-source:userset;mso-width-alt:7862; width:88pt;display:none'>
<%
	}
	else if(l_lang=="KOR")
	{
%> 
 <col class=xl24 width=215 style='mso-width-source:userset;mso-width-alt: 7862;width:161pt;display:none'>
 <col class=xl24 width=127 style='mso-width-source:userset;mso-width-alt:7862; width:95pt;display:none'>
 <col class=xl24 width=117 style='mso-width-source:userset;mso-width-alt:7862; width:88pt;'>
<%
	}
	else if(l_lang=="ENG-KOR")
	{
%>
<col class=xl24 width=215 style='mso-width-source:userset;mso-width-alt: 7862;width:161pt'>
<col class=xl24 width=127 style='mso-width-source:userset;mso-width-alt:7862; width:95pt;display:none'>
<col class=xl24 width=117 style='mso-width-source:userset;mso-width-alt:7862; width:88pt'>
<%
	}
	else if(l_lang=="ENG-VIE")
	{
%>
<col class=xl24 width=215 style='mso-width-source:userset;mso-width-alt: 7862;width:161pt'>
<col class=xl24 width=127 style='mso-width-source:userset;mso-width-alt:7862; width:95pt'>
<col class=xl24 width=117 style='mso-width-source:userset;mso-width-alt:7862; width:88pt;display:none'>
<%
	}
	else if(l_lang=="KOR-VIE")
	{
%>
<col class=xl24 width=215 style='mso-width-source:userset;mso-width-alt: 7862;width:161pt;display:none'>
<col class=xl24 width=127 style='mso-width-source:userset;mso-width-alt:7862; width:95pt'>
<col class=xl24 width=117 style='mso-width-source:userset;mso-width-alt:7862; width:88pt'>
<%
	}
	else if(l_lang=="ENG-VIE-KOR")
	{
%>
<col class=xl24 width=215 style='mso-width-source:userset;mso-width-alt: 7862;width:161pt'>
<col class=xl24 width=127 style='mso-width-source:userset;mso-width-alt:7862; width:95pt'>
<col class=xl24 width=117 style='mso-width-source:userset;mso-width-alt:7862; width:88pt'>
<%
	}
%>

 <col class=xl24 width=121 style='mso-width-source:userset;mso-width-alt:4425; width:91pt'>
 <col class=xl25 width=121 span=3 style='mso-width-source:userset;mso-width-alt: 4425;width:91pt'>
 <col class=xl24 width=121 style='mso-width-source:userset;mso-width-alt:4425; width:91pt'>
 <col class=xl24 width=117 span=2 style='mso-width-source:userset;mso-width-alt: 4278;width:88pt'>
 <col class=xl25 width=121 span=4 style='mso-width-source:userset;mso-width-alt: 4425;width:91pt'>
 <col class=xl24 width=121 style='mso-width-source:userset;mso-width-alt:4425; width:91pt'>
 <col class=xl24 width=26 style='mso-width-source:userset;mso-width-alt:950; width:20pt'>
 <col class=xl24 width=64 span=2 style='width:48pt'>
 
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
<%if(l_lang=="ENG"){%>
  <td height=21 class=xl29 style='height:15.75pt'>1. Balance Sheet Comparison</td>
  <td height=21 class=xl29 style='height:15.75pt'></td>
  <td height=21 class=xl29 style='height:15.75pt'></td>
<%}else if(l_lang=="VIE"){%>  
  <td height=21 class=xl29 style='height:15.75pt'></td>
  <td height=21 class=xl29 style='height:15.75pt'>1. Balance Sheet Comparison</td>
  <td height=21 class=xl29 style='height:15.75pt'></td>
<%}else if(l_lang=="KOR"){%>  
  <td height=21 class=xl29 style='height:15.75pt'></td>
  <td height=21 class=xl29 style='height:15.75pt'></td>
  <td height=21 class=xl29 style='height:15.75pt'>1. Balance Sheet Comparison</td>
  <%}else if(l_lang=="ENG-KOR"){%>  
  <td height=21 class=xl29 style='height:15.75pt'>1. Balance Sheet Comparison</td>
  <td height=21 class=xl29 style='height:15.75pt'></td>
  <td height=21 class=xl29 style='height:15.75pt'></td>
  <%}else if(l_lang=="ENG-VIE"){%>  
  <td height=21 class=xl29 style='height:15.75pt'>1. Balance Sheet Comparison</td>
  <td height=21 class=xl29 style='height:15.75pt'></td>
  <td height=21 class=xl29 style='height:15.75pt'></td>
  <%}else if(l_lang=="KOR-VIE"){%>  
  <td height=21 class=xl29 style='height:15.75pt'></td>
  <td height=21 class=xl29 style='height:15.75pt'>1. Balance Sheet Comparison</td>
  <td height=21 class=xl29 style='height:15.75pt'></td>
  <%}else if(l_lang=="ENG-VIE-KOR"){%>  
  <td height=21 class=xl29 style='height:15.75pt'>1. Balance Sheet Comparison</td>
  <td height=21 class=xl29 style='height:15.75pt'></td>
  <td height=21 class=xl29 style='height:15.75pt'></td>
<%}%>  
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
<%if(l_lang=="ENG"){%> 
  <td height=21 class=xl30 style='height:15.75pt'><%=l_date_to %></td>
  <td height=21 class=xl30 style='height:15.75pt'></td>
  <td height=21 class=xl30 style='height:15.75pt'></td>
<%}else if(l_lang=="VIE"){%>   
  <td height=21 class=xl30 style='height:15.75pt'></td>
  <td height=21 class=xl30 style='height:15.75pt'><%=l_date_to %></td>
  <td height=21 class=xl30 style='height:15.75pt'></td>
<%}else if(l_lang=="KOR"){%>    
  <td height=21 class=xl30 style='height:15.75pt'></td>
  <td height=21 class=xl30 style='height:15.75pt'></td>
  <td height=21 class=xl30 style='height:15.75pt'><%=l_date_to %></td>
  <%}else if(l_lang=="ENG-KOR"){%>    
  <td height=21 class=xl30 style='height:15.75pt'><%=l_date_to %></td>
  <td height=21 class=xl30 style='height:15.75pt'></td>
  <td height=21 class=xl30 style='height:15.75pt'></td>
  <%}else if(l_lang=="ENG-VIE"){%>    
  <td height=21 class=xl30 style='height:15.75pt'><%=l_date_to %></td>
  <td height=21 class=xl30 style='height:15.75pt'></td>
  <td height=21 class=xl30 style='height:15.75pt'></td>
  <%}else if(l_lang=="KOR-VIE"){%>    
  <td height=21 class=xl30 style='height:15.75pt'></td>
  <td height=21 class=xl30 style='height:15.75pt'><%=l_date_to %></td>
  <td height=21 class=xl30 style='height:15.75pt'></td>
  <%}else if(l_lang=="ENG-VIE-KOR"){%>    
  <td height=21 class=xl30 style='height:15.75pt'><%=l_date_to %></td>
  <td height=21 class=xl30 style='height:15.75pt'></td>
  <td height=21 class=xl30 style='height:15.75pt'></td>
<%}%>    
  <td class=xl24></td>
  <td colspan=2 class=xl50 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl28><span style='mso-spacerun:yes'>    
  </span>(Unit:&nbsp;<%=l_scale%> &nbsp;VND)</td>
  <td class=xl28></td>
  <td class=xl32></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl24 style='height:16.5pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl52 style='height:15.75pt'>Item</td>
  <td class=xl53 style='border-left:none'>Mục</td>
  <td class=xl53 style='border-left:none'>Item Korean</td>
  <td class=xl39 style='border-left:none'><%=l_lastYear %></td>
  <td class=xl40 style='border-left:none'><%=l_lastMonth %></td>
  <td class=xl40 style='border-left:none'><%=l_date_to %></td>
  <td class=xl40 style='border-left:none'>variance</td>
  <td class=xl41 style='border-left:none'>variance</td>
  <td class=xl33></td>
  <td></td>
  <td colspan=4 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl38 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>A</td>
  <td class=xl44 style='border-top:none;border-left:none'>B</td>
  <td class=xl44 style='border-top:none;border-left:none'>C</td>
  <td class=xl44 style='border-top:none;border-left:none'>C-B</td>
  <td class=xl45 style='border-top:none;border-left:none'>C-A</td>
  <td class=xl34></td>
  <td></td>
  <td colspan=4 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <%
		string _Font_style = "";
		string _Color = "";
		for (int i = 0; i < dt.Rows.Count; i++)
		{
			if(dt.Rows[i][5].ToString() == "B")
			{
				_Font_style = "font-weight:700";
			}
			else if(dt.Rows[i][5].ToString() == "I")
			{
				_Font_style = "font-style:italic";
			}
			else
			{
				_Font_style = "";
			}
			
			_Color = "mso-pattern:auto none;background-color:#" + dt.Rows[i][4].ToString().Substring(6,2) + dt.Rows[i][4].ToString().Substring(4,2) + dt.Rows[i][4].ToString().Substring(2,2);
			//_Color = "color:blue";
 %>
 <tr height=22 style='height:16.5pt;mso-height-source:auto' >
  <td height=22 class=xl46 style='height:16.5pt;border-top:none;<%=_Font_style%>;<%=_Color%>'><%= dt.Rows[i][0].ToString()%></td>
  <td class=xl47 style='border-top:none;border-left:none;<%=_Font_style%>;<%=_Color%>'><%= dt.Rows[i][1].ToString()%></td>
  <td class=xl47 style='border-top:none;border-left:none;<%=_Font_style%>;<%=_Color%>'><%= dt.Rows[i][2].ToString()%></td>
  <td class=xl49 style='border-top:none;border-left:none;<%=_Font_style%>;<%=_Color%>' x:num><%= dt.Rows[i][6].ToString()%></td>
  <td class=xl49 style='border-top:none;border-left:none;<%=_Font_style%>;<%=_Color%>' x:num><%= dt.Rows[i][7].ToString()%></td>
  <td class=xl49 style='border-top:none;border-left:none;<%=_Font_style%>;<%=_Color%>' x:num><%= dt.Rows[i][8].ToString()%></td>
  <td class=xl49 style='border-top:none;border-left:none;<%=_Font_style%>;<%=_Color%>' x:num><%= dt.Rows[i][9].ToString()%></td>
  <td class=xl51 align=right style='border-top:none;border-left:none;<%=_Font_style%>;<%=_Color%>'  x:num><%= dt.Rows[i][10].ToString()%></td>
 </tr>
 <%
 }
 %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=215 style='width:161pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=127 style='width:95pt'></td>
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
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
