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
                string p_Pk = Request["Pk"];
                string p_Project_Pk = Request["Project_Pk"];
                string p_Title = "";
                string p_Project_Name = "";
                
                string SQL = "SELECT a.orderingconttypename, B.PROJECTNAME " +
                "  FROM tecps_orderingconttype a, TECPS_PROJECTSUMM b " +
                " WHERE     a.del_if = 0 " +
                "       AND b.del_if = 0 " +
                "       AND A.TECPS_PROJECTSUMM_PK = b.pk " +
                "       AND a.pk = '" + p_Pk + "' ";

                DataTable dt = ESysLib.TableReadOpen(SQL);
                if (dt.Rows.Count == 0)
                {
                    Response.Write("There is no data!!");
                    Response.End();
                }
                p_Title = dt.Rows[0][0].ToString();
                p_Project_Name = dt.Rows[0][1].ToString();
                
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="kpcs311_BOQ_files/filelist.xml">
<link rel=Edit-Time-Data href="kpcs311_BOQ_files/editdata.mso">
<link rel=OLE-Object-Data href="kpcs311_BOQ_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>kenzie</o:Author>
  <o:LastAuthor>kenzie</o:LastAuthor>
  <o:LastPrinted>2011-06-22T01:40:34Z</o:LastPrinted>
  <o:Created>2011-06-20T07:57:05Z</o:Created>
  <o:LastSaved>2011-06-23T07:08:24Z</o:LastSaved>
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
	font-size:11.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	vertical-align:middle;}
.xl35
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
.xl36
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
.xl37
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
.xl38
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
.xl39
	{mso-style-parent:style0;
	font-size:30.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;}
.xl40
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
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:1.0pt solid windowtext;}
.xl42
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
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
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
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
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
	border-left:.5pt solid black;}
.xl47
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
.xl48
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
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
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
     <x:SplitHorizontal>7</x:SplitHorizontal>
     <x:TopRowBottomPane>7</x:TopRowBottomPane>
     <x:SplitVertical>4</x:SplitVertical>
     <x:LeftColumnRightPane>4</x:LeftColumnRightPane>
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
       <x:ActiveRow>8</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
       <x:ActiveCol>0</x:ActiveCol>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1780 style='border-collapse:
 collapse;table-layout:fixed;width:1338pt'>
 <col width=250 style='mso-width-source:userset;mso-width-alt:9142;width:188pt'>
 <col width=124 style='mso-width-source:userset;mso-width-alt:4534;width:93pt'>
 <col width=68 span=2 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl24 width=145 span=8 style='mso-width-source:userset;mso-width-alt:
 5302;width:109pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 width=250 style='height:12.75pt;width:188pt'></td>
  <td width=124 style='width:93pt'></td>
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
  <td height=17 colspan=4 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=50 style='height:37.5pt'>
  <td colspan=13 height=50 class=xl39 style='height:37.5pt'>Bill of Quantity(<%=p_Title%>)</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'>PROJECT NAME: <%=p_Project_Name%></td>
  <td class=xl25></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr class=xl26 height=22 style='mso-height-source:userset;height:17.1pt'>
  <td rowspan=2 height=42 class=xl40 style='border-bottom:.5pt solid black;
  height:32.1pt'>WORK SCOPE / ITEM</td>
  <td rowspan=2 class=xl42 style='border-bottom:.5pt solid black'>SPECIFICATION</td>
  <td rowspan=2 class=xl50 style='border-bottom:.5pt solid black'>UNIT</td>
  <td rowspan=2 class=xl50 style='border-bottom:.5pt solid black'>QTY</td>
  <td colspan=2 class=xl44 style='border-right:.5pt solid black'>MATERIAL</td>
  <td colspan=2 class=xl44 style='border-right:.5pt solid black;border-left:
  none'>LABOR</td>
  <td colspan=2 class=xl44 style='border-right:.5pt solid black;border-left:
  none'>EQUIPMENT</td>
  <td colspan=2 class=xl46 style='border-right:.5pt solid black;border-left:
  none'>TOTAL</td>
  <td rowspan=2 class=xl48 style='border-bottom:.5pt solid black'>REMARK</td>
 </tr>
 <tr class=xl26 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt'>U-PRICE</td>
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
     string SQL_Detail = "SELECT (SELECT itemcode || ' ' || itemname " +
        "                  FROM tecps_item " +
        "                 WHERE pk = e.tecps_item_pk) " +
        "          Item, " +
        "       e.STANDARD Spec, " +
        "       e.changeunit Unit, " +
        "       NVL (e.changeqty, 0) Qty, " +
        "       NVL (e.changematerialunitcost, 0) Material_unit, " +
        "       NVL (E.CHANGEMATERIALAMT, 0) Material_Amt, " +
        "       NVL (e.changelaborunitcost, 0) Labor_Unit, " +
        "       NVL (e.changelaboramt, 0) Labor_Amt, " +
        "       NVL (e.changecostunitcost, 0) Exp_Unit, " +
        "       NVL (e.changecostamt, 0) Exp_Amt, " +
        "       NVL (e.changeunitcost, 0) Tot_Unit, " +
        "       NVL (e.changeamt, 0) Tot_Amt, " +
        "       NULL remark " +
        "  FROM tecps_performrmrk e, " +
        "       tecps_orderingconttype c, " +
        "       tecps_st_budget d, " +
        "       tecps_undertakelevelcode b " +
        " WHERE     e.del_if = 0 " +
        "       AND e.tecps_orderingconttype_pk = c.pk(+) " +
        "       AND e.tecps_stbudget_pk = d.pk(+)  AND e.level_num = 2 " +
        "       AND e.tecps_undertakelevelcode_pk = b.pk(+) " +
        "       AND e.tecps_projectsumm_pk = '"+p_Project_Pk+"' " +
        "       AND e.tecps_orderingconttype_pk = '" + p_Pk + "' ";

     DataTable dt_detail = ESysLib.TableReadOpen(SQL_Detail);
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
 %>
 <tr class=xl28 height=19 style='height:14.25pt'>
  <td height=19 class=xl29 width=250 style='height:14.25pt;width:188pt;width:188pt'><%=dt_detail.Rows[i][0]%></td>
  <td class=xl30><%=dt_detail.Rows[i][1]%></td>
  <td class=xl31><%=dt_detail.Rows[i][2]%></td>
  <td class=xl32 x:num><%=dt_detail.Rows[i][3]%></td>
  <td class=xl32 x:num><%=dt_detail.Rows[i][4]%></td>
  <td class=xl32 x:num><%=dt_detail.Rows[i][5]%></td>
  <td class=xl32 x:num><%=dt_detail.Rows[i][6]%></td>
  <td class=xl32 x:num><%=dt_detail.Rows[i][7]%></td>
  <td class=xl32 x:num><%=dt_detail.Rows[i][8]%></td>
  <td class=xl32 x:num><%=dt_detail.Rows[i][9]%></td>
  <td class=xl32 x:num><%=dt_detail.Rows[i][10]%></td>
  <td class=xl32 x:num><%=dt_detail.Rows[i][11]%></td>
  <td class=xl33 x:num><%=dt_detail.Rows[i][12]%></td>
 </tr>
 <%} %>
 <tr class=xl34 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl35 style='height:18.0pt'>GRAND TOTAL</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37 x:num><%=_M_Amt%></td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37 x:num><%=_L_Amt %></td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37 x:num><%=_E_Amt%></td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37 x:num><%=_Tot_Amt%></td>
  <td class=xl38>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=250 style='width:188pt'></td>
  <td width=124 style='width:93pt'></td>
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
