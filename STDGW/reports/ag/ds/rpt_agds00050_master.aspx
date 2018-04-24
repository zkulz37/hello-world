<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<%  ESysLib.SetUser("comm");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    
    string strName,strGroup;    
    //strName=Request.QueryString["code_nm"];
    strGroup=Request.QueryString["code_grp"];
 
   string SQL
	= "select PK,  " + 
        "        ROWNUM,  " +
        "        group_ID,  " +
        "        group_NaMe,  " +
        "        (CASE WHEN USE_IF='Y' THEN 'Y' ELSE 'N' END),  " +
        "        REMARK,  " +
        "        Rem_num1,  " +
        "        Rem_num2,  " +
        "        Rem_num3,         " +
        "        Rem_cha1,  " +
        "        Rem_cha2,  " +
        "        Rem_cha3,        " +
        "        (CASE WHEN NVL(SYS_YN,'N')='Y' THEN 'Y' ELSE 'N' END)  " +
        "    FROM sale.LG_CODE_GROUP a " +
        "    WHERE DEL_IF=0 AND A.PARENT_PK <>1 " +
        "    and  a.pk in  " +
        "    ( " +
        "        select pk from sale.lg_code_group B " +
        "        WHERE B.DEL_IF =0  " +
        "        CONNECT BY PRIOR  B.PK = B.PARENT_PK " +
        "        START WITH B.PK = '" + strGroup + "'       " +
        "    )  " ;

    //Response.Write(SQL);
    //Response.End();
    DataTable dt_master = ESysLib.TableReadOpen(SQL);
    if (dt_master.Rows.Count == 0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }
    int cnt = dt_master.Rows.Count;        
    /**/
    //int cnt=0;
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
  <o:Author>Hee</o:Author>
  <o:LastAuthor>Hee</o:LastAuthor>
  <o:Created>2008-10-17T02:44:09Z</o:Created>
  <o:LastSaved>2008-10-17T03:01:55Z</o:LastSaved>
  <o:Company>Hee Nguyen</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
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
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
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
      <x:Scale>68</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>3</x:SplitHorizontal>
     <x:TopRowBottomPane>3</x:TopRowBottomPane>
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
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$3</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1272 style='border-collapse:
 collapse;table-layout:fixed;width:955pt'>
 <col class=xl24 width=32 style='mso-width-source:userset;mso-width-alt:1170;
 width:24pt'>
 <col class=xl24 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl24 width=125 style='mso-width-source:userset;mso-width-alt:4571;
 width:94pt'>
 <col class=xl24 width=64 span=2 style='width:48pt'>
 <col class=xl24 width=95 style='mso-width-source:userset;mso-width-alt:3474;
 width:71pt'>
 <col class=xl24 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl24 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 <col class=xl24 width=82 span=2 style='mso-width-source:userset;mso-width-alt:
 2998;width:62pt'>
 <col class=xl24 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl24 width=64 style='mso-width-source:userset;mso-width-alt:2340;
 width:48pt'>
 <tr height=36 style='height:27.0pt'>
  <td height=36 class=xl24 width=32 style='height:27.0pt;width:24pt'></td>
  <td class=xl24 width=70 style='width:53pt'></td>
  <td class=xl24 width=125 style='width:94pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=95 style='width:71pt'></td>
  <td class=xl25 colspan=5 width=417 style='mso-ignore:colspan;width:313pt'>LOGISTIC
  MASTER CODE REPORT</td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=88 style='width:66pt'></td>
  <td class=xl24 width=83 style='width:62pt'></td>
  <td class=xl24 width=88 style='width:66pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=3 class=xl24 style='height:11.25pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl29 style='height:18.0pt'>No.</td>
  <td class=xl29 style='border-left:none'>ID</td>
  <td class=xl29 style='border-left:none'>Name</td>
  <td class=xl29 style='border-left:none'>Use</td>
  <td class=xl29 style='border-left:none'>Remark</td>
  <td class=xl29 style='border-left:none'>Num1 Value</td>
  <td class=xl29 style='border-left:none'>Num2 Value</td>
  <td class=xl29 style='border-left:none'>Num3 Value</td> 
  <td class=xl29 style='border-left:none'>Cha1 Name</td>
  <td class=xl29 style='border-left:none'>Cha2 Name</td>
  <td class=xl29 style='border-left:none'>Cha3 Name</td>
 
  <td class=xl29 style='border-left:none'>SYS Y/N</td>
 </tr>
 <%
     for (int j = 0; j < cnt; j++)
     {       
  %>
 <tr height=23 style='userset;height:17.25pt'> 
  <td height=23 class=xl28 width=32 style='height:17.25pt;border-top:none;
  width:24pt' x:num><%=j+1 %></td>
  <td class=xl27 width=70 style='border-top:none;border-left:none;width:53pt'><%=dt_master.Rows[j][2].ToString() %></td>
  <td class=xl27 width=125 style='border-top:none;border-left:none;width:94pt'><%=dt_master.Rows[j][3].ToString() %></td>
  <td class=xl27 width=64 style='text-align:center;border-top:none;border-left:none;width:48pt'><%=dt_master.Rows[j][4].ToString() %></td>
  <td class=xl27 width=64 style='border-top:none;border-left:none;width:48pt'><%=dt_master.Rows[j][5].ToString() %></td>
  <td class=xl27 width=95 style='border-top:none;border-left:none;width:71pt'><%=dt_master.Rows[j][6].ToString() %></td>
  <td class=xl27 width=88 style='border-top:none;border-left:none;width:66pt'><%=dt_master.Rows[j][7].ToString() %></td>
  <td class=xl27 width=79 style='border-top:none;border-left:none;width:59pt'><%=dt_master.Rows[j][8].ToString() %></td>
  <td class=xl27 width=83 style='border-top:none;border-left:none;width:62pt'><%=dt_master.Rows[j][9].ToString() %></td>
  <td class=xl27 width=85 style='border-top:none;border-left:none;width:64pt'><%=dt_master.Rows[j][10].ToString() %></td>
  <td class=xl27 width=82 style='border-top:none;border-left:none;width:62pt'><%=dt_master.Rows[j][11].ToString() %></td>
  <td class=xl27 style='text-align:center;vertical-align:middle;'><%=dt_master.Rows[j][12].ToString() %></td>
  
 </tr>
 <%
     } %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=32 style='width:24pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
