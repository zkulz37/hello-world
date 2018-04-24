<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
	ESysLib.SetUser(Session["APP_DBUSER"].ToString());
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
		string p_Company_Pk = Request["Company_Pk"];
		string p_FROM_DATE = Request["FROM_DATE"];
		string p_TO_DATE = Request["TO_DATE"];
		string p_Status = Request["Status"];
		string p_Acc_Cd = Request["Acc_Cd"];
		string p_PS = Request["PS"];
                   string p_FS = Request["FS"];
		 string p_Report_Type = Request["Report_Type"];
		
		string p_Company_Nm = "";
		string p_Tax_Code = "";
		string p_Add = "";
		string p_From = p_FROM_DATE.Substring(4,2) + "/" + p_FROM_DATE.Substring(0,4);
		string p_To = p_TO_DATE.Substring(4,2) + "/" + p_TO_DATE.Substring(0,4);
		
		string SQL = " SELECT partner_lname, tax_code, ADDR1, ADDR2, ADDR3  FROM tco_company  WHERE pk = '" + p_Company_Pk + "'";
		DataTable dt_Com = ESysLib.TableReadOpen(SQL);
		if(dt_Com.Rows.Count > 0)
		{
			p_Company_Nm = dt_Com.Rows[0][0].ToString();
			p_Tax_Code = dt_Com.Rows[0][1].ToString();
			p_Add = dt_Com.Rows[0][2].ToString() ;
		}
		
		string l_parameter = "'" + p_Company_Pk + "', ";
		l_parameter += "'" + p_FROM_DATE + "', ";
		l_parameter += "'" + p_TO_DATE + "', ";
		l_parameter += "'" + p_Status + "', ";
		l_parameter += "'" + p_Acc_Cd + "', ";
		l_parameter += "'" + p_PS + "', ";
		l_parameter += "'" + p_FS + "', ";
		l_parameter += "'"+p_Report_Type+"' ";
		
		DataTable dt = ESysLib.TableReadOpenCursor("ac_sel_600800150_op_cost", l_parameter);
		if (dt.Rows.Count == 0)
		{
			Response.Write("There is no data!!");
			Response.End();
		}
		
		int j = 0;
		int _Cols = 0;
		//for (j = 111; j < 211; j++) 
		for (j=0; j < dt.Columns.Count; j++) 
		{
			if(dt.Rows[1][j]!="" &&  dt.Rows[1][j]!="0")
			{
				_Cols =  dt.Columns.Count;
			}
		}
		//Response.Write(_Cols);
		//Response.End();
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="OperatingCost_files/filelist.xml">
<link rel=Edit-Time-Data href="OperatingCost_files/editdata.mso">
<link rel=OLE-Object-Data href="OperatingCost_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>AiLinh</o:Author>
  <o:LastAuthor>Kenzie</o:LastAuthor>
  <o:LastPrinted>2013-06-06T07:44:05Z</o:LastPrinted>
  <o:Created>2010-10-19T09:50:51Z</o:Created>
  <o:LastSaved>2013-06-06T09:07:57Z</o:LastSaved>
  <o:Company>VNG</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-header-data:&L&T;
	mso-footer-data:"Page &P of &N";
	margin:.25in .25in .25in .25in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
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
.xl24
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
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
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Operating cost 1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>13</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>6</x:SplitHorizontal>
     <x:TopRowBottomPane>6</x:TopRowBottomPane>
     <x:SplitVertical>2</x:SplitVertical>
     <x:LeftColumnRightPane>2</x:LeftColumnRightPane>
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
       <x:ActiveRow>17</x:ActiveRow>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>18795</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>345</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Operating cost 1'!$A$6:$N$6</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1040"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=7415 style='border-collapse: collapse;table-layout:fixed;width:5562pt'>

 <col class=xl24 width=60 style='mso-width-source:userset;mso-width-alt:2194; width:45pt'>
 <col class=xl24 width=267 span=3 style='mso-width-source:userset;mso-width-alt: 9764;width:200pt'>
 <col class=xl24 width=42 style='mso-width-source:userset;mso-width-alt:1536; width:32pt'>
 <col class=xl24 width=49 style='mso-width-source:userset;mso-width-alt:1792; width:37pt'>
 <col class=xl25 width=121 style='mso-width-source:userset;mso-width-alt:4425; width:91pt'>
 <col class=xl25 width=142 style='mso-width-source:userset;mso-width-alt:5193; width:107pt'>
 
 <%if(dt.Rows[0]["name1"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name2"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name3"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name4"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name5"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name6"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name7"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name8"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name9"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name10"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 
 <%if(dt.Rows[0]["name11"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name12"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name13"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name14"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name15"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 
 <%if(dt.Rows[0]["name16"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name17"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name18"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name19"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name20"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 
 <%if(dt.Rows[0]["name21"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name22"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name23"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name24"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name25"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name26"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name27"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name28"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name29"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name30"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
<%if(dt.Rows[0]["name31"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name32"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name33"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name34"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name35"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name36"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name37"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name38"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name39"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name40"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name41"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name42"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name43"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name44"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name45"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name46"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name47"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name48"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name49"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <%if(dt.Rows[0]["name50"].ToString()!=""){%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt'>
 <%}else{%>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt: 4534;width:93pt;display:none'>
 <%}%>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl24 colspan=2 width=391 style='height:15.75pt;
  mso-ignore:colspan;width:293pt'><%=p_Company_Nm%></td>
  <td class=xl24 width=267 style='width:200pt'></td>
  <td class=xl24 width=267 style='width:200pt'></td>
  <td class=xl24 width=74 style='width:56pt'></td>
  <td class=xl24 width=81 style='width:61pt'></td>
  <td class=xl27 width=153 style='width:115pt'></td>
  <td class=xl27 width=142 style='width:107pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
  <td class=xl27 width=124 style='width:93pt'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl24 colspan=6 style='height:15.75pt;mso-ignore:colspan'><%=p_Add%></td>
  <td colspan=52 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Mã  số thuế: <%=p_Tax_Code%></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=52 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='height:25.5pt'>
  <td colspan=58 height=34 class=xl37 style='height:25.5pt'>OPERATING COST  REPORT</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td colspan=58 height=22 class=xl51 style='height:16.5pt'>From : <%=p_From%> ~ <%=p_To%></td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 class=xl29 style='height:15.75pt;border-top:none;white-space:normal'>Account Code</td>
  <td class=xl30 style='border-top:none'>Account Name</td>
  <td class=xl30 style='border-top:none'>Account Name (Local)</td>
  <td class=xl30 style='border-top:none'>Account Name (Foreign)</td>
  <td class=xl30 style='border-top:none'>Code</td>
  <td class=xl30 style='border-top:none'>Group</td>
  <td class=xl31 style='border-top:none'>Count Total PL</td>
  <td class=xl31 style='border-top:none'>Total</td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name1"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name2"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name3"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name4"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name5"]%></td>
  <td class=xl44 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name6"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name7"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name8"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name9"]%></td>
  <td class=xl48 width=124 style='border-top:none;border-left:none;width:93pt'><%=dt.Rows[0]["name10"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name11"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name12"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name13"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name14"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name15"]%></td>
  <td class=xl48 width=124 style='border-top:none;border-left:none;width:93pt'><%=dt.Rows[0]["name16"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name17"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name18"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name19"]%></td>
  <td class=xl48 width=124 style='border-top:none;border-left:none;width:93pt'><%=dt.Rows[0]["name20"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name21"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name22"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name23"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name24"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name25"]%></td>
  <td class=xl48 width=124 style='border-top:none;border-left:none;width:93pt'><%=dt.Rows[0]["name26"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name27"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name28"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name29"]%></td>
  <td class=xl48 width=124 style='border-top:none;border-left:none;width:93pt'><%=dt.Rows[0]["name30"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name31"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name32"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name33"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name34"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name35"]%></td>
  <td class=xl48 width=124 style='border-top:none;border-left:none;width:93pt'><%=dt.Rows[0]["name36"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name37"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name38"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name39"]%></td>
  <td class=xl50 width=124 style='border-top:none;border-left:none;width:93pt'><%=dt.Rows[0]["name40"]%></td>
  <td class=xl47 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name41"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name42"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name43"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name44"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name45"]%></td>
  <td class=xl48 width=124 style='border-top:none;border-left:none;width:93pt'><%=dt.Rows[0]["name46"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name47"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name48"]%></td>
  <td class=xl42 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name49"]%></td>
  <td class=xl43 width=124 style='border-top:none;width:93pt'><%=dt.Rows[0]["name50"]%></td>
 </tr>
<%
		int i = 0;
		string l_color = "";
		string l_Font = "";
		for (i = 0; i < dt.Rows.Count; i++) 
		{ 
			l_color = "background:#" + dt.Rows[i]["prn_color"].ToString().Substring(6, 2) + dt.Rows[i]["prn_color"].ToString().Substring(4, 2) + dt.Rows[i]["prn_color"].ToString().Substring(2, 2)+ ";mso-pattern:auto none;";
			if (dt.Rows[i]["font_stype"].ToString() == "B")
			{
				l_Font = "font-weight:700";
			}
			else if (dt.Rows[i]["font_stype"].ToString() == "I")
			{
				l_Font = "font-style:Italic";
			} 	
			else
			{
				l_Font = "font-style:Normal";
			}
 %>
 <tr class=xl26 height=21 style='height:15.75pt'>
  <td height=21 class=xl32 style='height:15.75pt;<%=l_color%>;<%=l_Font%>'><%=dt.Rows[i]["acc_cd"]%></td>
  <td class=xl38 width=267 style='mso-text-control:shrinktofit;width:200pt;<%=l_color%>;<%=l_Font%>'><%=dt.Rows[i]["prn_acnm"]%></td>
  <td class=xl38 width=267 style='mso-text-control:shrinktofit;width:200pt;<%=l_color%>;<%=l_Font%>'><%=dt.Rows[i]["prn_lacnm"]%></td>
  <td class=xl38 width=267 style='mso-text-control:shrinktofit;width:200pt;<%=l_color%>;<%=l_Font%>'><%=dt.Rows[i]["prn_kacnm"]%></td>
  <td class=xl38 width=74 style='width:56pt;<%=l_color%>;<%=l_Font%>'><%=dt.Rows[i]["code"]%></td>
  <td class=xl38 width=81 style='width:61pt;<%=l_color%>;<%=l_Font%>'><%=dt.Rows[i]["grp_accd"]%></td>
  <td class=xl39 style='<%=l_color%>;<%=l_Font%>'><%=dt.Rows[i]["total_pl"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["total"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num1"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num2"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num3"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num4"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num5"]%></td>
  <td class=xl45 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num6"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num7"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num8"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num9"]%></td>
  <td class=xl45 style='border-top:none;<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num10"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num11"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num12"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num13"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num14"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num15"]%></td>
  <td class=xl45 style='border-top:none;<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num16"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num17"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num18"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num19"]%></td>
  <td class=xl45 style='border-top:none;<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num20"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num21"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num22"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num23"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num24"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num25"]%></td>
  <td class=xl45 style='border-top:none;<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num26"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num27"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num28"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num29"]%></td>
  <td class=xl45 style='border-top:none;<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num30"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num31"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num32"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num33"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num34"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num35"]%></td>
  <td class=xl45 style='border-top:none;<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num36"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num37"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num38"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num39"]%></td>
  <td class=xl49 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num40"]%></td>
  <td class=xl46 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num41"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num42"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num43"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num44"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num45"]%></td>
  <td class=xl45 style='border-top:none;<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num46"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num47"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num48"]%></td>
  <td class=xl40 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num49"]%></td>
  <td class=xl41 style='<%=l_color%>;<%=l_Font%>' x:num><%=dt.Rows[i]["num50"]%></td>
 </tr>
 <%}%>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt'>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=124 style='width:93pt'></td>
  <td width=267 style='width:200pt'></td>
  <td width=267 style='width:200pt'></td>
  <td width=267 style='width:200pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=153 style='width:115pt'></td>
  <td width=142 style='width:107pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
