<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("ec111");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
                string p_Project_pk = Request["Project_pk"];
                string p_Work = Request["Work"];
                string p_Field = Request["Field"];
               // string p_Select_Column = Request["Select_Column"];
                string p_Version = Request["Version"]; 
    			string p_Intergrated_YN = Request["Intergrated_YN"];
                string l_parameter = "'" +  p_Project_pk + "', ";
                         l_parameter += "'" + p_Work + "', ";
                         l_parameter += "'" + p_Field + "', ";
                       //  l_parameter += "'" + p_Select_Column + "', ";   
						 l_parameter += "'" + p_Version + "' ";   
				//Response.Write(l_parameter);
//				Response.End();		 
                DataTable dt = ESysLib.TableReadOpenCursor("ec111.sp_sel_kpbp00050_rpt", l_parameter);
                if (dt.Rows.Count == 0)
                {
                    Response.Write("There is no data!!");
                    Response.End();
                }
				
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="kpbp00050_files/filelist.xml">
<link rel=Edit-Time-Data href="kpbp00050_files/editdata.mso">
<link rel=OLE-Object-Data href="kpbp00050_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ISA_SERVER</o:Author>
  <o:LastAuthor>LONG</o:LastAuthor>
  <o:LastPrinted>2011-03-05T06:23:34Z</o:LastPrinted>
  <o:Created>2011-03-05T04:23:22Z</o:Created>
  <o:LastSaved>2011-05-13T08:16:18Z</o:LastSaved>
  <o:Company>Vina Genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.39in .2in .39in 0in;
	mso-header-margin:.51in;
	mso-footer-margin:.51in;
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
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl27
	{mso-style-parent:style0;
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
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl30
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
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
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
      <x:Scale>60</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:SplitVertical>7</x:SplitVertical>
     <x:LeftColumnRightPane>7</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>2</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>12120</x:WindowHeight>
  <x:WindowWidth>15180</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>
<%
        string _class = ";display:none";
    %>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1720 style='border-collapse:
 collapse;table-layout:fixed;width:1295pt'>
 <%
 		if(p_Intergrated_YN == "Y")
		  _class = ";display:none";    
		  else
		  _class = "";
 %><%
 		if(p_Intergrated_YN == "Y")
		  _class = ";display:none";    
		  else
		  _class = "";
 %><%
 		if(p_Intergrated_YN == "Y")
		  _class = ";display:none";    
		  else
		  _class = "";
 %><%
 		if(p_Intergrated_YN == "Y")
		  _class = ";display:none";    
		  else
		  _class = "";
 %><%
 		if(p_Intergrated_YN == "Y")
		  _class = ";display:none";    
		  else
		  _class = "";
 %><%
 		if(p_Intergrated_YN == "Y")
		  _class = ";display:none";    
		  else
		  _class = "";
 %>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt;
 <%=_class %>'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=180 style='mso-width-source:userset;mso-width-alt:6582;width:135pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=82 style='mso-width-source:userset;mso-width-alt:2998;width:62pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2560;width:53pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=138 style='mso-width-source:userset;mso-width-alt:5046;width:104pt'>
 <col width=117 style='mso-width-source:userset;mso-width-alt:4278;width:88pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=117 style='mso-width-source:userset;mso-width-alt:4278;width:88pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=117 style='mso-width-source:userset;mso-width-alt:4278;width:88pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=124 style='mso-width-source:userset;mso-width-alt:4534;width:93pt'>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td colspan=16 height=35 class=xl29 width=1720 style='height:26.25pt;
  width:1295pt'>CONTRACT DETAILS</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=16 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td rowspan=2 height=47 class=xl30 style='border-bottom:.5pt solid black;
  height:35.25pt'>Level</td>
  <td rowspan=2 class=xl30 style='border-bottom:.5pt solid black'>Field</td>
  <td rowspan=2 class=xl30 style='border-bottom:.5pt solid black'>Code</td>
  <td rowspan=2 class=xl30 style='border-bottom:.5pt solid black'>Name</td>
  <td rowspan=2 class=xl30 style='border-bottom:.5pt solid black'>Standard</td>
  <td rowspan=2 class=xl30 style='border-bottom:.5pt solid black'>Unit</td>
  <td rowspan=2 class=xl30 style='border-bottom:.5pt solid black'>Cuurency</td>
  <td colspan=9 class=xl33 style='border-right:.5pt solid black;border-left:
  none'>Contract (Changed)</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl24 style='height:18.75pt'>Quantity</td>
  <td class=xl24>Raw Mtrl. Cost U/P</td>
  <td class=xl24>Raw Mtrl. Amt</td>
  <td class=xl24>Labor Cost U/P</td>
  <td class=xl24>Labor Amt</td>
  <td class=xl24>Expense U/P</td>
  <td class=xl24>Expense Amt</td>
  <td class=xl24>Unit Price</td>
  <td class=xl24>Amount</td>
 </tr>
 <%
     decimal t7 = 0; 
     decimal t8 = 0;
     decimal t9 = 0;
     decimal t10 = 0;
     decimal t11 = 0;
     decimal t12 = 0;
     decimal t13 = 0;
     decimal t14 = 0;
     decimal t15 = 0;
 			for(int i = 0; i<dt.Rows.Count;i++)
			{
                if (dt.Rows[i][7].ToString().Trim() != "")
                {
                    t7 += decimal.Parse(dt.Rows[i][7].ToString());
                }
                else
                {
                    t7 += 0;
                }
                
                if (dt.Rows[i][8].ToString().Trim() != "")
                {
                    t8 += decimal.Parse(dt.Rows[i][8].ToString());
                }
                else
                {
                    t8 += 0;
                }

                if (dt.Rows[i][9].ToString().Trim() != "")
                {
                    t9 += decimal.Parse(dt.Rows[i][9].ToString());
                }
                else
                {
                    t9 += 0;
                }

                if (dt.Rows[i][10].ToString().Trim() != "")
                {
                    t10 += decimal.Parse(dt.Rows[i][10].ToString());
                }
                else
                {
                    t10 += 0;
                }

                if (dt.Rows[i][11].ToString().Trim() != "")
                {
                    t11 += decimal.Parse(dt.Rows[i][11].ToString());
                }
                else
                {
                    t11 += 0;
                }

                if (dt.Rows[i][12].ToString().Trim() != "")
                {
                    t12 += decimal.Parse(dt.Rows[i][12].ToString());
                }
                else
                {
                    t12 += 0;
                }

                if (dt.Rows[i][13].ToString().Trim() != "")
                {
                    t13 += decimal.Parse(dt.Rows[i][13].ToString());
                }
                else
                {
                    t13 += 0;
                }

                if (dt.Rows[i][14].ToString().Trim() != "")
                {
                    t14 += decimal.Parse(dt.Rows[i][14].ToString());
                }
                else
                {
                    t14 += 0;
                }

                if (dt.Rows[i][15].ToString().Trim() != "")
                {
                    t15 += decimal.Parse(dt.Rows[i][15].ToString());
                }
                else
                {
                    t15 += 0;
                }/**/
 %>
 <tr height=25 style='mso-height-source:auto;height:18.75pt'>
  <td height=25 class=xl25 style='height:18.75pt'><%=dt.Rows[i][0]%></td>
  <td class=xl26><%=dt.Rows[i][1]%></td>
  <td class=xl35 width=110 style='width:83pt'><%=dt.Rows[i][2]%></td>
  <td class=xl35 width=180 style='width:135pt'><%=dt.Rows[i][3]%></td>
  <td class=xl26><%=dt.Rows[i][4]%></td>
  <td class=xl26><%=dt.Rows[i][5]%></td>
  <td class=xl27><%=dt.Rows[i][6]%></td>
  <td class=xl28 x:num><%=dt.Rows[i][7]%></td>
  <td class=xl28 x:num><%=dt.Rows[i][8]%></td>
  <td class=xl28 x:num><%=dt.Rows[i][9]%></td>
  <td class=xl28 x:num><%=dt.Rows[i][10]%></td>
  <td class=xl28 x:num><%=dt.Rows[i][11]%></td>
  <td class=xl28 x:num><%=dt.Rows[i][12]%></td>
  <td class=xl28 x:num><%=dt.Rows[i][13]%></td>
  <td class=xl28 x:num><%=dt.Rows[i][14]%></td>
  <td class=xl28 x:num><%=dt.Rows[i][15]%></td>
 </tr>
 <%
  		}
  %>
   <tr height=25 style='mso-height-source:auto;height:18.75pt'>
  <td colspan="7" height=25 class=xl25 style='height:18.75pt;text-align:center;font-weight:700'>Total</td>
  
  <td class=xl28 style="font-weight:700" x:num><%=t7%></td>
  <td class=xl28 style="font-weight:700" x:num><%=t8%></td>
  <td class=xl28 style="font-weight:700" x:num><%=t9%></td>
  <td class=xl28 style="font-weight:700" x:num><%=t10%></td>
  <td class=xl28 style="font-weight:700" x:num><%=t11%></td>
  <td class=xl28 style="font-weight:700" x:num><%=t12%></td>
  <td class=xl28 style="font-weight:700" x:num><%=t13%></td>
  <td class=xl28 style="font-weight:700" x:num><%=t14%></td>
  <td class=xl28 style="font-weight:700" x:num><%=t15%></td>
 </tr>

 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=68 style='width:51pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=124 style='width:93pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
