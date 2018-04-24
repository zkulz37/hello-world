<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
            string p_Project_Pk = Request.QueryString["Project_pk"];
            string p_Subcont_Pk = Request.QueryString["Subcont_Pk"];
            string p_Month = Request.QueryString["Month"];
//===========================================================================================================		
            string SQL = "SELECT B.PROJECTNAME, a.contract_nm " +
                "  FROM tecps_substrp12000 a, TECPS_PROJECTSUMM b " +
                " WHERE     a.del_if = 0 " +
                "       AND b.del_if = 0 " +
                "       AND A.TECPS_PROJECTSUMM_PK = b.pk " +
                "       AND a.tecps_projectsumm_pk =  '" + p_Project_Pk + "' and a.pk = '" + p_Subcont_Pk + "' ";
		DataTable dt = ESysLib.TableReadOpen(SQL);
        if (dt.Rows.Count == 0)
        {
            Response.Write("There is no data to show");
            Response.End();
        }
		string p_Project_Name = dt.Rows[0][0].ToString();
		string p_Scope = dt.Rows[0][1].ToString();
//===========================================================================================================	
        string l_parameter = "";
        l_parameter = "'" + p_Project_Pk + "',";
        l_parameter += "'" + p_Subcont_Pk + "',";
        l_parameter += "'" + p_Month + "'";	
        DataTable dt_Detail = ESysLib.TableReadOpenCursor("PM_RPT_61080020_2", l_parameter);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Book1_files/filelist.xml">
<link rel=Edit-Time-Data href="Book1_files/editdata.mso">
<link rel=OLE-Object-Data href="Book1_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>LONG</o:Author>
  <o:LastAuthor>LONG</o:LastAuthor>
  <o:LastPrinted>2011-05-05T01:44:41Z</o:LastPrinted>
  <o:Created>2011-05-04T10:00:05Z</o:Created>
  <o:LastSaved>2011-05-05T02:02:54Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .25in .75in 0in;
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
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
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
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
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
      <x:Scale>68</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>6</x:SplitHorizontal>
     <x:TopRowBottomPane>6</x:TopRowBottomPane>
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
       <x:ActiveRow>4</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>135</x:WindowTopY>
  <x:Calculation>ManualCalculation</x:Calculation>
  <x:MaxIterations>1000</x:MaxIterations>
  <x:Iteration/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
<x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$5:$6</x:Formula>
 </x:ExcelName> 
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1500 style='border-collapse: collapse;table-layout:fixed;width:1129pt'>
 <col width=42 style='mso-width-source:userset;mso-width-alt:1536;width:32pt'>
 <col width=180 span=2 style='mso-width-source:userset;mso-width-alt:6582; width:135pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=89 span=2 style='mso-width-source:userset;mso-width-alt:3254; width:67pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=145 style='mso-width-source:userset;mso-width-alt:5302;width:109pt'>
 <tr class=xl31 height=33 style='mso-height-source:userset;height:24.75pt'>
  <td colspan=15 height=33 class=xl32 width=1500 style='height:24.75pt;  width:1129pt'>BILL OF QUANTITY</td>
 </tr>
 <tr class=xl30 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl30 colspan=3 style='height:18.0pt;mso-ignore:colspan'>PROJECT NAME: <%=p_Project_Name%></td>
  <td colspan=12 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl30 colspan=3 style='height:18.0pt;mso-ignore:colspan'>SCOPE OF WORK : <%=p_Scope%></td>
  <td colspan=12 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td rowspan=2 height=52 class=xl25 style='height:40.2pt'>No</td>
  <td rowspan=2 class=xl25>WORK SCOPE/ITEM</td>
  <td rowspan=2 class=xl25>SPECIFICATION</td>
  <td rowspan=2 class=xl25>UNIT</td>
  <td colspan=3 class=xl25 style='border-left:none'>Contract Price</td>
  <td colspan=2 class=xl25 style='border-left:none'>Previous</td>
  <td colspan=2 class=xl25 style='border-left:none'>This Month</td>
  <td colspan=3 class=xl25 style='border-left:none'>Accumulated</td>
  <td rowspan=2 class=xl25>Remark</td>
 </tr>
 <tr class=xl24 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl25 style='height:20.1pt;border-top:none;border-left:  none'>QUANTITY</td>
  <td class=xl25 style='border-top:none;border-left:none'>Unit Price</td>
  <td class=xl25 style='border-top:none;border-left:none'>Amount</td>
  <td class=xl25 style='border-top:none;border-left:none'>QUANTITY</td>
  <td class=xl25 style='border-top:none;border-left:none'>Amount</td>
  <td class=xl25 style='border-top:none;border-left:none'>QUANTITY</td>
  <td class=xl25 style='border-top:none;border-left:none'>Amount</td>
  <td class=xl25 style='border-top:none;border-left:none'>QUANTITY</td>
  <td class=xl25 style='border-top:none;border-left:none'>Amount</td>
  <td class=xl25 style='border-top:none;border-left:none'>Ratio (%)</td>
 </tr>
<%
    decimal Amount_Cont = 0;
    decimal Amount_Pre = 0;
    decimal Amount_this = 0;
    decimal Amount_Acc = 0;
    decimal Ratio = 0;
    decimal Qty1 = 0;
    decimal Qty2 = 0;
    int i;
    int k = 0;  
    for(i=0;i<dt_Detail.Rows.Count;i++)
    {
        if (dt_Detail.Rows[i][5].ToString().Trim() != "")
        {
            Amount_Cont += decimal.Parse(dt_Detail.Rows[i][5].ToString());
        }
        else
        {
            Amount_Cont += 0;
        }

        if (dt_Detail.Rows[i][7].ToString().Trim() != "")
        {
            Amount_Pre += decimal.Parse(dt_Detail.Rows[i][7].ToString());
        }
        else
        {
            Amount_Pre += 0;
        }

        if (dt_Detail.Rows[i][9].ToString().Trim() != "")
        {
            Amount_this += decimal.Parse(dt_Detail.Rows[i][9].ToString());
        }
        else
        {
            Amount_this += 0;
        }

        if (dt_Detail.Rows[i][11].ToString().Trim() != "")
        {
            Amount_Acc += decimal.Parse(dt_Detail.Rows[i][11].ToString());
        }
        else
        {
            Amount_Acc += 0;
        }

        if (dt_Detail.Rows[i][10].ToString().Trim() != "")
        {
            Qty1 = decimal.Parse(dt_Detail.Rows[i][10].ToString());
        }
        else
        {
            Qty1 = 0;
        }

        if (dt_Detail.Rows[i][3].ToString().Trim() != "")
        {
            Qty2 = decimal.Parse(dt_Detail.Rows[i][3].ToString());
        }
        else
        {
            Qty2 = 0;
        }
       if(Qty1 != 0 && Qty2 != 0)
       { 
            Ratio = Qty1 / Qty2 * 100;
            }
            else
            {
                Ratio = 0;
            }
 %> 
 <tr class=xl29 height=20 style='mso-height-source:auto;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt;border-top:none' x:num><%=k+1%></td>
  <td class=xl27 width=180 style='border-top:none;border-left:none;width:135pt'><%=dt_Detail.Rows[i][0]%></td>
  <td class=xl27 width=180 style='border-top:none;border-left:none;width:135pt'><%=dt_Detail.Rows[i][1]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt_Detail.Rows[i][2]%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none;mso-number-format:\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)'  x:num><%=dt_Detail.Rows[i][3]%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none'  x:num><%=dt_Detail.Rows[i][4]%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none'  x:num><%=dt_Detail.Rows[i][5]%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none;mso-number-format:\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)'  x:num><%=dt_Detail.Rows[i][6]%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none'  x:num><%=dt_Detail.Rows[i][7]%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none;mso-number-format:\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)'  x:num><%=dt_Detail.Rows[i][8]%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none'  x:num><%=dt_Detail.Rows[i][9]%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none;mso-number-format:\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)'  x:num><%=dt_Detail.Rows[i][10]%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none'  x:num><%=dt_Detail.Rows[i][11]%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none'  x:num><%=Ratio%></td>
  <td class=xl27 width=145 style='border-top:none;border-left:none;width:109pt'><%=dt_Detail.Rows[i][12]%></td>
 </tr>
<%k+=1;} %> 
 <tr class=xl38 height=22 style='mso-height-source:userset;height:17.1pt;display:none'>
  <td colspan=4 height=22 class=xl33 style='border-right:.5pt solid black;  height:17.1pt'>UNIT TOTAL</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 align=right style='border-top:none;border-left:none'  x:num> </td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 align=right style='border-top:none;border-left:none'  x:num></td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 align=right style='border-top:none;border-left:none'  x:num></td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 align=right style='border-top:none;border-left:none'  x:num></td>
  <td class=xl37 align=right style='border-top:none;border-left:none'  x:num></td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl38 height=22 style='mso-height-source:userset;height:17.1pt'>
  <td colspan=4 height=22 class=xl33 style='border-right:.5pt solid black;  height:17.1pt'>GRAND TOTAL</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 align=right style='border-top:none;border-left:none'  x:num><%=Amount_Cont%></td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 align=right style='border-top:none;border-left:none'  x:num><%=Amount_Pre%></td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 align=right style='border-top:none;border-left:none'  x:num><%=Amount_this%></td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 align=right style='border-top:none;border-left:none'  x:num><%=Amount_Acc%></td>
  <td class=xl37 align=right style='border-top:none;border-left:none'  x:num></td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=42 style='width:32pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=145 style='width:109pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>