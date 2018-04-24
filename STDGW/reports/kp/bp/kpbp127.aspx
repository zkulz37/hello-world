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
                string p_Level_Pk = Request["Pk"];
                string p_Project_Pk = Request["Project_Pk"];
                string p_From = Request["From"];
                string p_To = Request["To"];
                //string p_Date = Request["Date"];
                string p_Title = "";
                string p_Project_Name = "";
                string l_parameter = "'" + p_Project_Pk + "', ";
                l_parameter += "'" + p_Level_Pk + "', ";
                l_parameter += "'" + p_From + "', ";
                l_parameter += "'" + p_To + "' ";
                string SQL = "SELECT A.UNDERTAKELEVELNAME, B.PROJECTNAME " +
                "  FROM tecps_undertakelevelcode a, TECPS_PROJECTSUMM b " +
                " WHERE     a.del_if = 0 " +
                "       AND b.del_if = 0 " +
                "       AND a.TECPS_PROJECTSUMM_PK = b.pk " +
                "       AND a.pk = '" + p_Level_Pk + "' ";

                DataTable dt = ESysLib.TableReadOpen(SQL);
                if (dt.Rows.Count == 0)
                {
                    Response.Write("There is no data!!");
                    Response.End();
                }
                p_Title = dt.Rows[0][0].ToString();
                p_Project_Name = dt.Rows[0][1].ToString();
                p_From = p_From.Substring(6, 2) + "/" + p_From.Substring(4, 2) + "/" + p_From.Substring(0, 4);
                p_To = p_To.Substring(6, 2) + "/" + p_To.Substring(4, 2) + "/" + p_To.Substring(0, 4);
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="1.2.7_files/filelist.xml">
<link rel=Edit-Time-Data href="1.2.7_files/editdata.mso">
<link rel=OLE-Object-Data href="1.2.7_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>kenzie</o:Author>
  <o:LastAuthor>kenzie</o:LastAuthor>
  <o:LastPrinted>2011-06-22T01:40:34Z</o:LastPrinted>
  <o:Created>2011-06-20T07:57:05Z</o:Created>
  <o:LastSaved>2011-06-22T01:43:19Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.52in .41in .49in 0in;
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
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:30.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
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
      <x:Scale>52</x:Scale>
      <x:HorizontalResolution>200</x:HorizontalResolution>
      <x:VerticalResolution>200</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>8</x:SplitHorizontal>
     <x:TopRowBottomPane>8</x:TopRowBottomPane>
     <x:SplitVertical>6</x:SplitVertical>
     <x:LeftColumnRightPane>6</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>19</x:ActiveRow>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9720</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1916 style='border-collapse:
 collapse;table-layout:fixed;width:1440pt'>
 <col width=250 style='mso-width-source:userset;mso-width-alt:9142;width:188pt'>
 <col width=124 style='mso-width-source:userset;mso-width-alt:4534;width:93pt'>
 <col width=68 span=4 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl24 width=145 span=8 style='mso-width-source:userset;mso-width-alt:
 5302;width:109pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 width=250 style='height:12.75pt;width:188pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td width=110 style='width:83pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=6 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=50 style='height:37.5pt'>
  <td colspan=15 height=50 class=xl38 style='height:37.5pt'><%=p_Title%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=6 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'>DATE: <%=p_From%> ~ <%=p_To%></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 colspan=2 style='height:15.75pt;mso-ignore:colspan'>PROJECT NAME: <%=p_Project_Name%></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr class=xl26 height=22 style='mso-height-source:userset;height:17.1pt'>
  <td rowspan=2 height=42 class=xl39 style='border-bottom:.5pt solid black;  height:32.1pt'>WORK SCOPE / ITEM</td>
  <td rowspan=2 class=xl41 style='border-bottom:.5pt solid black'>SPECIFICATION</td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:  none'>Actual</td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:  none'>Main Contract</td>
  <td colspan=2 class=xl43 style='border-right:.5pt solid black;border-left:  none'>MATERIAL</td>
  <td colspan=2 class=xl43 style='border-right:.5pt solid black;border-left:  none'>LABOR</td>
  <td colspan=2 class=xl43 style='border-right:.5pt solid black;border-left:  none'>EQUIPMENT</td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:  none'>TOTAL</td>
  <td rowspan=2 class=xl47 style='border-bottom:.5pt solid black'>REMARK</td>
 </tr>
 <tr class=xl26 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl42 style='height:15.0pt;border-left:none'>UNIT</td>
  <td class=xl42 style='border-left:none'>QTY</td>
  <td class=xl42 style='border-left:none'>UNIT</td>
  <td class=xl42 style='border-left:none'>QTY</td>
  <td class=xl27>U-PRICE</td>
  <td class=xl27>AMOUNT</td>
  <td class=xl27>U-PRICE</td>
  <td class=xl27>AMOUNT</td>
  <td class=xl27>U-PRICE</td>
  <td class=xl27>AMOUNT</td>
  <td class=xl27>U-PRICE</td>
  <td class=xl27>AMOUNT</td>
 </tr>
 <%
     int i = 0;
     decimal _M_Amt = 0;
     decimal _L_Amt = 0;
     decimal _E_Amt = 0;
     decimal _Tot_Amt = 0;
     string _format = "";
     DataTable dt_detail = ESysLib.TableReadOpenCursor("ec111.sp_sel_kpbp129_dt", l_parameter);
     for (i = 0;i<dt_detail.Rows.Count; i++)
     {
         if (dt_detail.Rows[i][5].ToString().Trim() != "")
         {
             _M_Amt += decimal.Parse(dt_detail.Rows[i][5].ToString());
         }
         else
         {
             _M_Amt += 0;
         }
         //===================================================
         if (dt_detail.Rows[i][7].ToString().Trim() != "")
         {
             _L_Amt += decimal.Parse(dt_detail.Rows[i][7].ToString());
         }
         else
         {
             _L_Amt += 0;
         }
         //===================================================
         if (dt_detail.Rows[i][9].ToString().Trim() != "")
         {
             _E_Amt += decimal.Parse(dt_detail.Rows[i][9].ToString());
         }
         else
         {
             _E_Amt += 0;
         }
         //===================================================
         if (dt_detail.Rows[i][11].ToString().Trim() != "")
         {
             _Tot_Amt += decimal.Parse(dt_detail.Rows[i][11].ToString());
         }
         else
         {
             _Tot_Amt += 0;
         }

         if (dt_detail.Rows[i][13].ToString() == "F")
         {
             _format = ";font-weight:700";
         }
         else
         {
             _format = "";
         }
 %>
 <tr class=xl28 height=24 style='mso-height-source:auto;height:18.0pt'>
  <td height=24 class=xl29 width=250 style='height:18.0pt;width:188pt<%=_format%>'><%=dt_detail.Rows[i][0]%></td>
  <td class=xl30><%=dt_detail.Rows[i][1]%></td>
  <td class=xl31></td>
  <td class=xl32 x:num></td>
  <td class=xl31><%=dt_detail.Rows[i][2]%></td>
  <td class=xl32 x:num><%=dt_detail.Rows[i][3]%></td>
  <td class=xl32 align=right x:num><%=dt_detail.Rows[i][4]%></td>
  <td class=xl32 align=right x:num><%=dt_detail.Rows[i][5]%></td>
  <td class=xl32 align=right x:num><%=dt_detail.Rows[i][6]%></td>
  <td class=xl32 align=right x:num><%=dt_detail.Rows[i][7]%></td>
  <td class=xl32 align=right x:num><%=dt_detail.Rows[i][8]%></td>
  <td class=xl32 align=right x:num><%=dt_detail.Rows[i][9]%></td>
  <td class=xl32 align=right x:num><%=dt_detail.Rows[i][10]%></td>
  <td class=xl32 align=right x:num><%=dt_detail.Rows[i][11]%></td>
  <td class=xl49><%=dt_detail.Rows[i][12]%></td>
 </tr>
 <%} %>
 <tr class=xl33 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl34 style='height:18.0pt'>GRAND TOTAL</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36 align=right x:num><%=_M_Amt%></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36 align=right x:num><%=_L_Amt %></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36 align=right x:num><%=_E_Amt%></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36 align=right x:num><%=_Tot_Amt%></td>
  <td class=xl37>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=250 style='width:188pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=110 style='width:83pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
