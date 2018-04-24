<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
	string  p_tps_project_pk  =Request["p_project_pk"]; 
	string  p_budget  =Request["p_budget_pk"]; 

	string SQL = " SELECT PROJECTCODE ||'-'|| PROJECTNAME  FROM TECPS_PROJECTSUMM  WHERE del_if=0 and pk = '" + p_tps_project_pk + "'";
    DataTable dt2 = ESysLib.TableReadOpen(SQL);
    string projectnane = dt2.Rows[0][0].ToString();
   

	string l_parameter = "'" +p_tps_project_pk +"','" +p_budget +"'";
    DataTable dt = ESysLib.TableReadOpenCursor("sp_sel_kpbm215",l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }       
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_kpbm215_summary_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_kpbm215_summary_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_kpbm215_summary_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>PCVINA002</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2011-05-17T06:17:39Z</o:LastPrinted>
  <o:Created>2011-05-17T06:10:14Z</o:Created>
  <o:LastSaved>2011-05-17T06:18:01Z</o:LastSaved>
  <o:Company>VINA</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P";
	margin:.34in .17in .2in .17in;
	mso-header-margin:.17in;
	mso-footer-margin:.16in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style17
	{mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	mso-style-name:"Comma \[0\]";
	mso-style-id:6;}
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
.xl522
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl523
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl524
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;}
.xl525
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl526
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl527
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl528
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl529
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl530
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl531
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl532
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl533
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl534
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl535
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl536
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl537
	{mso-style-parent:style17;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl538
	{mso-style-parent:style17;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
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
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>4</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>5</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>0</x:ActiveRow>
       <x:ActiveCol>0</x:ActiveCol>
       <x:RangeSelection>$A$1:$I$1</x:RangeSelection>
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
  <x:WindowHeight>8190</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1285 style='border-collapse:
 collapse;table-layout:fixed;width:968pt'>
 <col width=259 style='mso-width-source:userset;mso-width-alt:9472;width:194pt'>
 <col width=114 style='mso-width-source:userset;mso-width-alt:4169;width:86pt'>
 <col width=106 span=8 style='mso-width-source:userset;mso-width-alt:3876;
 width:80pt'>
 <col width=64 style='width:48pt'>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=9 height=21 class=xl537 width=1115 style='height:15.75pt;
  width:840pt' x:str>PROJECT NAME : <%=projectnane%></td>
  <td colspan=2 class=xl538 width=170 style='width:128pt' x:str="UNIT : USD"><span
  style='mso-spacerun:yes'>�</span>UNIT : USD<span
  style='mso-spacerun:yes'>�</span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=3 height=51 class=xl522 style='height:38.25pt;border-top:none'
  x:str="WORK SCOPE / ITEM"><span style='mso-spacerun:yes'>�</span>WORK SCOPE /
  ITEM<span style='mso-spacerun:yes'>�</span></td>
  <td colspan=4 class=xl522 style='border-left:none' x:str="CONTRACT (A)"><span
  style='mso-spacerun:yes'>�</span>CONTRACT (A)<span
  style='mso-spacerun:yes'>�</span></td>
  <td colspan=4 class=xl522 style='border-left:none' x:str="BUDGET (B)"><span
  style='mso-spacerun:yes'>�</span>BUDGET (B)<span
  style='mso-spacerun:yes'>�</span></td>
  <td rowspan=3 class=xl523 width=106 style='border-top:none;width:80pt'
  x:str="BALANCE                   (A)-(B)"><span
  style='mso-spacerun:yes'>�</span>BALANCE<span
  style='mso-spacerun:yes'>������������������ </span>(A)-(B)<span
  style='mso-spacerun:yes'>�</span></td>
  <td rowspan=3 class=xl522 style='border-top:none' x:str="REMARKS"><span
  style='mso-spacerun:yes'>�</span>REMARKS<span
  style='mso-spacerun:yes'>�</span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl522 style='height:12.75pt;border-left:none'
  x:str="UNIT PRICE"><span style='mso-spacerun:yes'>�</span>UNIT PRICE<span
  style='mso-spacerun:yes'>�</span></td>
  <td rowspan=2 class=xl522 style='border-top:none' x:str="AMOUNT"><span
  style='mso-spacerun:yes'>�</span>AMOUNT<span
  style='mso-spacerun:yes'>�</span></td>
  <td colspan=3 class=xl522 style='border-left:none' x:str="UNIT PRICE"><span
  style='mso-spacerun:yes'>�</span>UNIT PRICE<span
  style='mso-spacerun:yes'>�</span></td>
  <td rowspan=2 class=xl522 style='border-top:none' x:str="AMOUNT"><span
  style='mso-spacerun:yes'>�</span>AMOUNT<span
  style='mso-spacerun:yes'>�</span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl522 style='height:12.75pt;border-top:none;border-left:
  none' x:str="MATERIAL"><span style='mso-spacerun:yes'>�</span>MATERIAL<span
  style='mso-spacerun:yes'>�</span></td>
  <td class=xl522 style='border-top:none;border-left:none' x:str="LABOR"><span
  style='mso-spacerun:yes'>�</span>LABOR<span style='mso-spacerun:yes'>�</span></td>
  <td class=xl522 style='border-top:none;border-left:none' x:str="EQUIPMENT"><span
  style='mso-spacerun:yes'>�</span>EQUIPMENT<span
  style='mso-spacerun:yes'>�</span></td>
  <td class=xl522 style='border-top:none;border-left:none' x:str="MATERIAL"><span
  style='mso-spacerun:yes'>�</span>MATERIAL<span
  style='mso-spacerun:yes'>�</span></td>
  <td class=xl522 style='border-top:none;border-left:none' x:str="LABOR"><span
  style='mso-spacerun:yes'>�</span>LABOR<span style='mso-spacerun:yes'>�</span></td>
  <td class=xl522 style='border-top:none;border-left:none' x:str="EQUIPMENT"><span
  style='mso-spacerun:yes'>�</span>EQUIPMENT<span
  style='mso-spacerun:yes'>�</span></td>
 </tr>
 <%
     decimal l_undertakematerialamt = 0, l_undertakelaboramt = 0, l_undertakecostamt = 0,l_undertakeamt = 0, 
	 l_performmaterialamt = 0, l_performlaboramt = 0,l_performcostamt = 0, l_performamt = 0, l_balance = 0;
     for (int i = 0; i < dt.Rows.Count; i++)
     {
		if(dt.Rows[i]["undertakematerialamt"].ToString().Trim() != "" && dt.Rows[i]["leaf_yn"].ToString()=="T")
			{
				l_undertakematerialamt += Decimal.Parse(dt.Rows[i]["undertakematerialamt"].ToString());            
			}
		if(dt.Rows[i]["undertakelaboramt"].ToString().Trim() != "" && dt.Rows[i]["leaf_yn"].ToString()=="T")
			{
				l_undertakelaboramt += Decimal.Parse(dt.Rows[i]["undertakelaboramt"].ToString());            
			}
		if(dt.Rows[i]["undertakecostamt"].ToString().Trim() != "" && dt.Rows[i]["leaf_yn"].ToString()=="T")
			{
				l_undertakecostamt += Decimal.Parse(dt.Rows[i]["undertakecostamt"].ToString());            
			}
			if(dt.Rows[i]["undertakeamt"].ToString().Trim() != "" && dt.Rows[i]["leaf_yn"].ToString()=="T")
			{
				l_undertakeamt += Decimal.Parse(dt.Rows[i]["undertakeamt"].ToString());            
			}
		if(dt.Rows[i]["performmaterialamt"].ToString().Trim() != ""  && dt.Rows[i]["leaf_yn"].ToString()=="T")
			{
				l_performmaterialamt += Decimal.Parse(dt.Rows[i]["performmaterialamt"].ToString());            
			}
		if(dt.Rows[i]["performlaboramt"].ToString().Trim() != ""  && dt.Rows[i]["leaf_yn"].ToString()=="T")
			{
				l_performlaboramt += Decimal.Parse(dt.Rows[i]["performlaboramt"].ToString());            
			}
			if(dt.Rows[i]["performcostamt"].ToString().Trim() != ""  && dt.Rows[i]["leaf_yn"].ToString()=="T")
			{
				l_performcostamt += Decimal.Parse(dt.Rows[i]["performcostamt"].ToString());            
			}
		if(dt.Rows[i]["performamt"].ToString().Trim() != ""  && dt.Rows[i]["leaf_yn"].ToString()=="T")
			{
				l_performamt += Decimal.Parse(dt.Rows[i]["performamt"].ToString());            
			}
		if(dt.Rows[i]["balance"].ToString().Trim() != ""  && dt.Rows[i]["leaf_yn"].ToString()=="T")
			{
				l_balance += Decimal.Parse(dt.Rows[i]["balance"].ToString());            
			}	
          string _space="";
		  string strBegin="";
	      string strEnd="";
           
         if(dt.Rows[i]["leaf_yn"].ToString()=="F")
		 {
			strBegin="<b>";
			strEnd="</b>";
		 }

         switch(dt.Rows[i]["undertakelevel"].ToString())
		   {
			 case "2":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "3":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "4":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "5":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "6":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "7":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "8":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "9":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "10":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;&nbsp;&nbsp;&nbsp;&nbsp;;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
           }

          %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl524 style='height:12.75pt'
  x:str><%=strBegin%><%=_space%><%=dt.Rows[i]["undertakelevelcode"].ToString()%>-<%=dt.Rows[i]["undertakelevelname"].ToString()%><%=strEnd%></td>
  <td class=xl525 style='border-left:none' x:num><%=strBegin%><%=dt.Rows[i]["undertakematerialamt"]%><%=strEnd%></td>
  <td class=xl525 style='border-left:none' x:num><%=strBegin%><%=dt.Rows[i]["undertakelaboramt"]%><%=strEnd%></td>
  <td class=xl525 style='border-left:none' x:num><%=strBegin%><%=dt.Rows[i]["undertakecostamt"]%><%=strEnd%></td>
  <td class=xl526 style='border-left:none' x:num><%=strBegin%><%=dt.Rows[i]["undertakeamt"]%><%=strEnd%></td>
  <td class=xl527 x:num><%=strBegin%><%=dt.Rows[i]["performmaterialamt"]%><%=strEnd%></td>
  <td class=xl525 style='border-left:none' x:num><%=strBegin%><%=dt.Rows[i]["performlaboramt"]%><%=strEnd%></td>
  <td class=xl525 style='border-left:none' x:num><%=strBegin%><%=dt.Rows[i]["performcostamt"]%><%=strEnd%></td>
  <td class=xl528 style='border-top:none;border-left:none' x:num><%=strBegin%><%=dt.Rows[i]["performamt"]%><%=strEnd%></td>
  <td class=xl529 x:num><%=strBegin%><%=dt.Rows[i]["balance"]%><%=strEnd%></td>
  <td class=xl530 x:str><%=strBegin%><%=dt.Rows[i]["description"]%><%=strEnd%></td>
 </tr>
 <%}%>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl531 style='height:13.5pt;border-top:none'
  x:str="GRAND TOTAL"><span style='mso-spacerun:yes'>�</span>GRAND TOTAL<span
  style='mso-spacerun:yes'>�</span></td>
  <td class=xl532 align=right style='border-top:none;border-left:none'
  x:num><%=l_undertakematerialamt%></td>
  <td class=xl532 align=right style='border-top:none;border-left:none'
  x:num><%=l_undertakelaboramt%></td>
  <td class=xl532 align=right style='border-top:none;border-left:none'
  x:num><%=l_undertakecostamt%></td>
  <td class=xl533 align=right style='border-top:none;border-left:none'
  x:num><%=l_undertakeamt%></td>
  <td class=xl534 align=right style='border-top:none' x:num><%=l_performmaterialamt%></td>
  <td class=xl532 align=right style='border-top:none;border-left:none'
  x:num><%=l_performlaboramt%></td>
  <td class=xl532 align=right style='border-top:none;border-left:none'
  x:num><%=l_performcostamt%></td>
  <td class=xl532 align=right style='border-top:none;border-left:none'
  x:num><%=l_performamt%></td>
  <td class=xl535 align=right style='border-top:none;border-left:none'
  x:num><%=l_balance%></td>
  <td class=xl536 style='border-top:none'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=259 style='width:194pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
