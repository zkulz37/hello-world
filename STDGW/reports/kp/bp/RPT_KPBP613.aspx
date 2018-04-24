<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("ec111");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<%
	string p_Project_Pk = Request["Project_pk"];
	string p_year = Request["Year"];
	
    string l_parameter = "'" + p_Project_Pk + "','"  + p_year +"'";

    DataTable dt_detail = ESysLib.TableReadOpenCursor("ec111.sp_rpt_kpbp613",l_parameter);
	DataTable dt_sum = ESysLib.TableReadOpenCursor("ec111.sp_rpt_kpbp613_sum",l_parameter);
	DataTable dt_group = ESysLib.TableReadOpenCursor("ec111.sp_rpt_kpbp613_group",l_parameter);
	DataTable dt_info= ESysLib.TableReadOpenCursor("ec111.sp_sel_kpbp613_m_info",l_parameter);
	
    if (dt_detail.Rows.Count == 0)
    {
        Response.Write("There is not data !!");
        Response.End();
    }
    
   
    string sql2 = "SELECT ACNT.SF_A_GET_DEFAULT('ACBG0040') FROM DUAL ";
    string p_ccy = "";
    DataTable dt_bccy = ESysLib.TableReadOpen(sql2);
    if (dt_bccy.Rows.Count > 0)
    {
        p_ccy = dt_bccy.Rows[0][0].ToString();
    }
    string p_format = "";
    if (p_ccy == "0")
    {
        p_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="RPT_KPBP613_files/filelist.xml">
<link rel=Edit-Time-Data href="RPT_KPBP613_files/editdata.mso">
<link rel=OLE-Object-Data href="RPT_KPBP613_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>linhtta</o:Author>
  <o:LastAuthor>SVPOSLILAMA</o:LastAuthor>
  <o:LastPrinted>2011-12-13T02:20:39Z</o:LastPrinted>
  <o:Created>2011-11-25T01:29:56Z</o:Created>
  <o:LastSaved>2011-12-13T02:24:31Z</o:LastSaved>
  <o:Company>VNG</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.31in 0in .16in 0in;
	mso-header-margin:.3in;
	mso-footer-margin:.16in;
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
	color:windowtext;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	color:#003366;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	color:#003366;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	color:#003366;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	color:#003366;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	color:#003366;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	color:#003366;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
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
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
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
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-size:26.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Order work status </x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>47</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>8</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9630</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1365</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2346 style='border-collapse:
 collapse;table-layout:fixed;width:1768pt'>
 <col class=xl24 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl24 width=105 style='mso-width-source:userset;mso-width-alt:3840;
 width:79pt'>
 <col class=xl24 width=98 style='mso-width-source:userset;mso-width-alt:3584;
 width:74pt'>
 <col class=xl24 width=175 style='mso-width-source:userset;mso-width-alt:6400;
 width:131pt'>
 <col class=xl24 width=138 style='mso-width-source:userset;mso-width-alt:5046;
 width:104pt'>
 <col class=xl24 width=110 span=15 style='mso-width-source:userset;mso-width-alt:
 4022;width:83pt'>
 <col class=xl24 width=124 style='mso-width-source:userset;mso-width-alt:4534;
 width:93pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 width=56 style='height:12.75pt;width:42pt'></td>
  <td class=xl24 width=105 style='width:79pt'></td>
  <td class=xl24 width=98 style='width:74pt'></td>
  <td class=xl24 width=175 style='width:131pt'></td>
  <td class=xl24 width=138 style='width:104pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=124 style='width:93pt'></td>
 </tr>
 <tr height=44 style='height:33.0pt'>
  <td colspan=20 height=44 class=xl46 style='height:33.0pt'
  x:str="ORDER WORK STATUS ">ORDER WORK STATUS<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=2 height=23 class=xl33 style='height:17.25pt'>Project</td>
  <td colspan=4 class=xl33><%=dt_info.Rows[0]["projectcode"]%></td>
  <td class=xl26>Unit : USD</td>
  <td colspan=13 class=xl34 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl27 width=56 style='height:30.0pt;border-top:none;
  width:42pt'>No.</td>
  <td class=xl27 width=105 style='border-top:none;border-left:none;width:79pt'>Content</td>
  <td class=xl27 width=98 style='border-top:none;border-left:none;width:74pt'>Work
  code</td>
  <td class=xl35 style='border-top:none;border-left:none'>Work name</td>
  <td class=xl27 width=138 style='border-top:none;border-left:none;width:104pt'>Budget(A)</td>
  <td class=xl27 width=110 style='border-top:none;border-left:none;width:83pt'>Accu.
  Cost(B)</td>
  <td class=xl27 width=110 style='border-top:none;border-left:none;width:83pt'>Balance(A-B)</td>
  <td class=xl27 width=110 style='border-left:none;width:83pt'>This year(<%=p_year%>)</td>
  <td class=xl27 width=110 style='border-left:none;width:83pt'>Jan/<%=p_year%></td>
  <td class=xl27 width=110 style='border-left:none;width:83pt'>Feb/<%=p_year%></td>
  <td class=xl27 width=110 style='border-left:none;width:83pt'>Mar/<%=p_year%></td>
  <td class=xl27 width=110 style='border-left:none;width:83pt'>Apr/<%=p_year%></td>
  <td class=xl27 width=110 style='border-left:none;width:83pt'>May/<%=p_year%></td>
  <td class=xl27 width=110 style='border-left:none;width:83pt'>Jun/<%=p_year%></td>
  <td class=xl27 width=110 style='border-left:none;width:83pt'>Jul/<%=p_year%></td>
  <td class=xl27 width=110 style='border-left:none;width:83pt'>Aug/<%=p_year%></td>
  <td class=xl27 width=110 style='border-left:none;width:83pt'>Sep/<%=p_year%></td>
  <td class=xl27 width=110 style='border-left:none;width:83pt'>Oct/<%=p_year%></td>
  <td class=xl27 width=110 style='border-left:none;width:83pt'>Nov/<%=p_year%></td>
  <td class=xl27 width=110 style='border-left:none;width:83pt'>Dec/<%=p_year%></td>
  <td class=xl25></td>
 </tr>
  <%
   int j=0;
   
    for (j = 0; j < dt_group.Rows.Count;j++ )
    {
     
	%>
		 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
		  <td colspan=4 height=26 class=xl49 style='border-right:.5pt solid black;
		  height:20.1pt' x:str >Total <%=dt_group.Rows[j]["code_nm"]%></td>
		  <td class=xl47 style='border-left:none' x:num ><%=dt_group.Rows[j]["budget_amt"]%></td>
		  <td class=xl47 style='border-left:none'  x:num ><%=dt_group.Rows[j]["acc_amt"]%></td>
		  <td class=xl47 style='border-left:none'  x:num ><%=dt_group.Rows[j]["balance"]%></td>
		  <td class=xl48 style='border-left:none'  x:num ><%=dt_group.Rows[j]["this_year"]%></td>
		  <td class=xl48 style='border-left:none'  x:num ><%=dt_group.Rows[j]["jan_amt"]%></td>
		  <td class=xl48 style='border-left:none'  x:num ><%=dt_group.Rows[j]["feb_amt"]%></td>
		  <td class=xl48 style='border-left:none'  x:num ><%=dt_group.Rows[j]["mar_amt"]%></td>
		  <td class=xl48 style='border-left:none'  x:num ><%=dt_group.Rows[j]["apr_amt"]%></td>
		  <td class=xl48 style='border-left:none'  x:num ><%=dt_group.Rows[j]["may_amt"]%></td>
		  <td class=xl48 style='border-left:none'  x:num ><%=dt_group.Rows[j]["jun_amt"]%></td>
		  <td class=xl48 style='border-left:none'  x:num ><%=dt_group.Rows[j]["jul_amt"]%></td>
		  <td class=xl48 style='border-left:none'  x:num ><%=dt_group.Rows[j]["aug_amt"]%></td>
		  <td class=xl48 style='border-left:none'  x:num ><%=dt_group.Rows[j]["sep_amt"]%></td>
		  <td class=xl48 style='border-left:none'  x:num ><%=dt_group.Rows[j]["oct_amt"]%></td>
		  <td class=xl48 style='border-left:none'  x:num ><%=dt_group.Rows[j]["nov_amt"]%></td>
		  <td class=xl48 style='border-left:none'  x:num ><%=dt_group.Rows[j]["dec_amt"]%></td>
		  <td class=xl28></td>
		 </tr>
		 <%
			int i=0;
		   
			for (i = 0; i < dt_detail.Rows.Count;i++ )
			{
			    if (dt_detail.Rows[i]["code"].ToString() == dt_group.Rows[j]["code"].ToString())
               {
		  %>
			 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
			  <td height=26 class=xl36 style='height:20.1pt'><%= i + 1%></td>
			  <td class=xl38 style='border-left:none'><%=dt_detail.Rows[i]["code_nm"]%></td>
			  <td class=xl36 style='border-left:none'><%=dt_detail.Rows[i]["orderingconttypecode"]%> </td>
			  <td class=xl42 style='border-left:none' ><%=dt_detail.Rows[i]["orderingconttypename"]%></td>
			  <td class=xl40 style='border-left:none' x:num ><%=dt_detail.Rows[i]["budget_amt"]%></td>
			  <td class=xl40 style='border-left:none' x:num><%=dt_detail.Rows[i]["acc_amt"]%></td>
			  <td class=xl40 style='border-left:none' x:num><%=dt_detail.Rows[i]["balance"]%></td>
			  <td class=xl44 style='border-left:none' x:num><%=dt_detail.Rows[i]["balance"]%></td>
			  <td class=xl44 style='border-left:none' x:num><%=dt_detail.Rows[i]["jan_amt"]%></td>
			  <td class=xl44 style='border-left:none' x:num><%=dt_detail.Rows[i]["feb_amt"]%></td>
			  <td class=xl44 style='border-left:none' x:num><%=dt_detail.Rows[i]["mar_amt"]%></td>
			  <td class=xl44 style='border-left:none' x:num><%=dt_detail.Rows[i]["apr_amt"]%></td>
			  <td class=xl44 style='border-left:none' x:num><%=dt_detail.Rows[i]["may_amt"]%></td>
			  <td class=xl44 style='border-left:none' x:num><%=dt_detail.Rows[i]["jun_amt"]%></td>
			  <td class=xl44 style='border-left:none' x:num><%=dt_detail.Rows[i]["jul_amt"]%></td>
			  <td class=xl44 style='border-left:none' x:num><%=dt_detail.Rows[i]["aug_amt"]%></td>
			  <td class=xl44 style='border-left:none' x:num><%=dt_detail.Rows[i]["sep_amt"]%></td>
			  <td class=xl44 style='border-left:none' x:num><%=dt_detail.Rows[i]["oct_amt"]%></td>
			  <td class=xl44 style='border-left:none' x:num><%=dt_detail.Rows[i]["nov_amt"]%></td>
			  <td class=xl44 style='border-left:none' x:num><%=dt_detail.Rows[i]["dec_amt"]%></td>
			  <td class=xl28></td>
			 </tr>

		   <%
		     } // End if
          }  // End For i
       } // End For j
   %>
 
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=3 height=26 class=xl30 style='border-right:.5pt solid black;
  height:19.5pt'>GRAND TOTAL</td>
  <td class=xl29 >&nbsp;</td>
  <td class=xl29 align=right  x:num><%=dt_sum.Rows[0]["budget_amt"]%></td>
  <td class=xl29 align=right  x:num><%=dt_sum.Rows[0]["acc_amt"]%></td>
  <td class=xl29 align=right  x:num><%=dt_sum.Rows[0]["balance"]%></td>
  <td class=xl29 align=right  x:num><%=dt_sum.Rows[0]["this_year"]%></td>
  <td class=xl29 align=right  x:num><%=dt_sum.Rows[0]["jan_amt"]%></td>
  <td class=xl29 align=right  x:num><%=dt_sum.Rows[0]["feb_amt"]%></td>
  <td class=xl29 align=right  x:num><%=dt_sum.Rows[0]["mar_amt"]%></td>
  <td class=xl29 align=right  x:num><%=dt_sum.Rows[0]["apr_amt"]%></td>
  <td class=xl29 align=right  x:num><%=dt_sum.Rows[0]["may_amt"]%></td>
  <td class=xl29 align=right  x:num><%=dt_sum.Rows[0]["jun_amt"]%></td>
  <td class=xl29 align=right  x:num><%=dt_sum.Rows[0]["jul_amt"]%></td>
  <td class=xl29 align=right  x:num><%=dt_sum.Rows[0]["aug_amt"]%></td>
  <td class=xl29 align=right  x:num><%=dt_sum.Rows[0]["sep_amt"]%></td>
  <td class=xl29 align=right  x:num><%=dt_sum.Rows[0]["oct_amt"]%></td>
  <td class=xl29 align=right  x:num><%=dt_sum.Rows[0]["nov_amt"]%></td>
  <td class=xl29 align=right  x:num><%=dt_sum.Rows[0]["dec_amt"]%></td>
  <td class=xl28></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=56 style='width:42pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=175 style='width:131pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=124 style='width:93pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
