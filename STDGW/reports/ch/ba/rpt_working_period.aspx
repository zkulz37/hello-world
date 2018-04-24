<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_date = "20100701";
    string SQL
    = "SELECT G.ORG_NM,v.code " +
        ",sum(case when  MONTHS_BETWEEN (TO_DATE('"+p_date+"','YYYYMMDD'),TO_DATE(E.JOIN_DT,'YYYYMMDD') ) " +
        " > NVL(V.NUM_1,0) AND MONTHS_BETWEEN (TO_DATE('" + p_date + "','YYYYMMDD'),TO_DATE(E.JOIN_DT,'YYYYMMDD') ) <=  NVL(V.NUM_2,MONTHS_BETWEEN (TO_DATE('" + p_date + "','YYYYMMDD'),TO_DATE(E.JOIN_DT,'YYYYMMDD')) )  " +
        "  then 1 else 0 end )as num  " +
        "  FROM THR_EMPLOYEE E, VHR_HR_CODE V,COMM.TCO_ORG G    " +
        "  WHERE  V.ID='HR0134' AND E.DEL_IF =0 AND G.DEL_IF=0 AND G.PK=E.TCO_ORG_PK " +
        "  and e.JOIN_DT <='"+p_date+"' " +
        "  and nvl(left_dt,'30000101')>'"+p_date+"' " +
        "  GROUP BY G.PK,G.ORG_NM,V.CODE " +
        "  order by G.ORG_NM,G.PK,V.CODE  ";
   
  //  Response.Write(SQL);
   // Response.End();
    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    if (dt_Emp.Rows.Count == 0)
    {
        Response.Write("There is no data ");
        Response.End();
    }
    string SQL2
        = "select v.CHAR_1  from vhr_hr_code v where v.id='HR0134' order by code ";
    DataTable dt_Label = ESysLib.TableReadOpen(SQL2);
    if (dt_Label.Rows.Count == 0)
    {
        Response.Write("There is no data ");
        Response.End();
    }
    Double total=0;
    Double[] dept = new Double[50];
    for (int i = 0; i < dt_Emp.Rows.Count; i++)
    { total =(Double) total + Double.Parse(dt_Emp.Rows[i][2].ToString()); }
    
    
    
    
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
  <o:Author>nhut_k</o:Author>
  <o:LastAuthor>nhut_k</o:LastAuthor>
  <o:Created>2010-07-16T04:17:27Z</o:Created>
  <o:LastSaved>2010-07-16T06:20:53Z</o:LastSaved>
  <o:Company>AS</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.3in .3in .3in .3in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>4</x:TopRowBottomPane>
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
       <x:ActiveCol>0</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet2</x:Name>
    <x:WorksheetOptions>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11505</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$4:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=581 style='border-collapse:
 collapse;table-layout:fixed;width:436pt'>
 <col class=xl24 width=304 style='mso-width-source:userset;mso-width-alt:11117;
 width:228pt'>
 <col class=xl24 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl24 width=105 span=<%=dt_Label.Rows.Count%> style='mso-width-source:userset;mso-width-alt:3840;
 width:79pt'>
 <col class=xl24 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 width=304 style='height:15.75pt;width:228pt'>Report
  by: <%=Session["USER_NAME"] %></td>
  <td colspan=3 rowspan=2 class=xl32 width=277 style='width:208pt'>WORKING
  PERIOD</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'>Report date:<%=DateTime.Today.Day.ToString()+"/"+DateTime.Today.Month.ToString()+"/"+DateTime.Today.Year.ToString() %></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=4 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl29 style='height:18.75pt' x:str="Organization ">Organization<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl29 style='border-left:none'>Total Employee</td>
  <%for (int i = 0; i<dt_Label.Rows.Count; i++)
    {%>
  <td class=xl29 style='border-left:none'><%=dt_Label.Rows[i][0].ToString() %> </td>
  <%} %>
  <td class=xl29 style='border-left:none'>Total(%)</td>
 </tr>
 <% for (int i = 0; i < dt_Emp.Rows.Count; i=i+0)
    {
        Double sum = 0;
        for (int m = 0; m < dt_Label.Rows.Count; m++)
        {
            sum = sum + double.Parse(dt_Emp.Rows[i + m][2].ToString());
            dept[m] += Double.Parse(dt_Emp.Rows[i + m][2].ToString());
        }
        
         %>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl26 style='height:15.75pt;border-top:none;text-align:left' x:str><b><%=dt_Emp.Rows[i][0].ToString()%></b></td>
  <td class=xl27 style='border-top:none;border-left:none'><b><%=sum %></b></td>
  <% for(int j=0 ;j< dt_Label.Rows.Count; j++) {
         %>
    <td class=xl27 style='border-top:none;border-left:none' x:num><b><%=dt_Emp.Rows[i][2].ToString()%></b></td>
    <%  
        i = i + 1;
    } 
        %>
  
  <td class=xl28 style='border-top:none;border-left:none' x:num><b><%=sum/total*100 %></b></td>
 </tr>
 <%} %>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl30 style='height:15.75pt;border-top:none'>Total</td>
  <td class=xl31 style='border-top:none;border-left:none'><%=total %></td>
  <% for(int j=0 ;j< dt_Label.Rows.Count; j++) {
   %>
    <td class=xl31 style='border-top:none;border-left:none' x:num><%=dept[j]/total*100 %></td>
  <%} %>
  <td class=xl31 style='border-top:none;border-left:none'>100%</td>
 
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=304 style='width:228pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=72 style='width:54pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
