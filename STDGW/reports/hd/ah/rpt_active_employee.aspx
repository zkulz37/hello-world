<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data" %>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%  string p_nation, p_org_pk, p_status; 
    string p_from=Request.QueryString["p_1"].ToString() ;
    string p_to=Request.QueryString["p_2"].ToString();
    p_nation = Request["p_nation"].ToString();
    p_org_pk = Request["p_org"].ToString();
    p_status = Request["p_status"].ToString();
    
    string SQL
	= "select (SELECT   max(T.org_nm) " + 
        "                                    FROM tco_org t " +
        "                                    WHERE t.del_if = 0 " +
        "                                    AND T.ORG_TYPE IN('03') " +
        "                                    START WITH t.pk=e.tco_org_pk " +
        "                                    CONNECT BY PRIOR t.p_pk=t.pk) AS fact , " +
        "      (SELECT   max(T.org_nm) " +
        "                                    FROM tco_org t " +
        "                                    WHERE t.del_if = 0 " +
        "                                    AND T.ORG_TYPE IN('06') " +
        "                                    START WITH t.pk=e.tco_org_pk " +
        "                                    CONNECT BY PRIOR t.p_pk=t.pk) AS dept, "+
        "      (SELECT   max(T.org_nm) " +
        "                                    FROM tco_org t " +
        "                                    WHERE t.del_if = 0 " +
        "                                    AND T.ORG_TYPE IN('07','12') " +
        "                                    START WITH t.pk=e.tco_org_pk " +
        "                                    CONNECT BY PRIOR t.p_pk=t.pk) AS org_nm "+
        " , (select code_nm from vhr_hr_code v where V.CODE=E.POS_TYPE and V.ID='HR0008') pos     "+
        "    , (select code_nm from vhr_hr_code v where V.CODE=E.EMPLOYEE_TYPE and V.ID='HR0017') emp_type " +
        "    , E.EMP_ID,E.FULL_NAME, decode(length(E.BIRTH_DT),4,E.BIRTH_DT,to_char(to_date(E.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy')) birth " +
        "    , decode(E.SEX,'M','Nam','Nữ'),E.PERMANENT_ADDR,(select code_nm from vhr_hr_code v where V.CODE=e.permanent_province and V.ID='HR0021')  province " +
        "    ,  (select code_nm from vhr_hr_code v where V.CODE=E.EDU_TYPE and V.ID='HR0011') edu " +
        "    , e.major " +
        "    , to_char(to_date(E.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') join_dt " +
        "    , to_char(to_date('"+p_from+"' ,'yyyymmdd'),'dd/mm/yyyy'), to_char(to_date('"+p_to+"' ,'yyyymmdd'),'dd/mm/yyyy')   "+
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk " +
        "and E.JOIN_DT<='"+p_to+"' " +
        " and decode('" + p_status + "','ALL','ALL',e.status)='" + p_status + "' " +
        " and decode('" + p_nation + "','ALL','ALL',e.nation)='" + p_nation + "' " +
             " AND (   e.tco_org_pk IN ( " +
             "                         SELECT     g.pk " +
             "                               FROM tco_org g " +
             "                              WHERE g.del_if = 0 " +
             "                         START WITH g.pk = " +
             "                                       DECODE ('" + p_org_pk + "', " +
             "                                               'ALL', 0, " +
             "                                               '" + p_org_pk + "'" +
             "                                              ) " +
             "                         CONNECT BY PRIOR g.pk = g.p_pk) " +
             "                   OR '" + p_org_pk + "' = 'ALL') " +
        "and ( E.LEFT_DT IS NULL OR E.LEFT_DT>'"+p_to+"' ) order by fact,dept,org_nm " ;

        DataTable dt_emp = ESysLib.TableReadOpen(SQL);
        
        if (dt_emp.Rows.Count == 0)
        {
            Response.Write("There is no data to show");
            Response.End();
        } 

 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_active_employee_hyosung_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_active_employee_hyosung_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_active_employee_hyosung_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2011-07-09T02:17:19Z</o:LastPrinted>
  <o:Created>2011-07-09T02:15:02Z</o:Created>
  <o:LastSaved>2011-07-09T02:29:47Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .28in 1.0in .34in;
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
.style58
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet1;}
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
.xl66
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl67
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl68
	{mso-style-parent:style58;
	color:black;
	font-size:18.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl69
	{mso-style-parent:style58;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt solid blue;
	background:#00CCFF;
	mso-pattern:black none;}
.xl70
	{mso-style-parent:style58;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt dashed blue;
	background:#00CCFF;
	mso-pattern:black none;}
.xl71
	{mso-style-parent:style58;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt dashed blue;
	background:#00CCFF;
	mso-pattern:black none;
	white-space:normal;}
.xl72
	{mso-style-parent:style58;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt solid blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt dashed blue;
	background:#00CCFF;
	mso-pattern:black none;}
.xl73
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt solid blue;}
.xl74
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt dashed blue;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl75
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt dashed blue;}
.xl76
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed blue;}
.xl77
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt dashed blue;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl78
	{mso-style-parent:style58;
	color:black;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed blue;
	border-right:.5pt solid blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt dashed blue;}
.xl79
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:.5pt dashed blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt solid blue;
	border-left:.5pt solid blue;}
.xl80
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:.5pt dashed blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt solid blue;
	border-left:.5pt dashed blue;}
.xl81
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:.5pt dashed blue;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:.5pt dashed blue;}
.xl82
	{mso-style-parent:style58;
	color:black;
	font-size:18.0pt;
	font-family:Tahoma, sans-serif;
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
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>66</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Zoom>85</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>4</x:TopRowBottomPane>
     <x:SplitVertical>7</x:SplitVertical>
     <x:LeftColumnRightPane>7</x:LeftColumnRightPane>
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
       <x:ActiveRow>3</x:ActiveRow>
       <x:ActiveCol>0</x:ActiveCol>
       <x:RangeSelection>$A$4:$C$4</x:RangeSelection>
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
  <x:WindowHeight>5445</x:WindowHeight>
  <x:WindowWidth>11475</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
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

<body link=blue vlink=purple class=xl66>

<table border=0 cellpadding=0 cellspacing=0 width=1390 style='border-collapse:
 collapse;table-layout:fixed;width:1045pt'>
 <col class=xl66 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl66 width=99 style='mso-width-source:userset;mso-width-alt:3620;
 width:74pt'>
 <col class=xl66 width=97 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <col class=xl66 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl66 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl66 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl66 width=57 style='mso-width-source:userset;mso-width-alt:2084;
 width:43pt'>
 <col class=xl66 width=155 style='mso-width-source:userset;mso-width-alt:5668;
 width:116pt'>
 <col class=xl66 width=98 style='mso-width-source:userset;mso-width-alt:3584;
 width:74pt'>
 <col class=xl66 width=50 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col class=xl66 width=186 style='mso-width-source:userset;mso-width-alt:6802;
 width:140pt'>
 <col class=xl66 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl66 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl66 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl66 width=97 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <tr class=xl67 height=30 style='height:22.5pt'>
  <td colspan=15 height=30 class=xl82 width=1520 style='height:22.5pt;
  width:1142pt'>REPORT ACTIVE EMPLOYEE</td>
 </tr>
 <tr class=xl67 height=30 style='height:22.5pt'>
  <td colspan=15 height=30 class=xl82 style='height:22.5pt'>From date:
  <%=dt_emp.Rows[0][14].ToString() %><span style='mso-spacerun:yes'>  </span>To date: <%=dt_emp.Rows[0][15].ToString() %></td>
 </tr>
 <tr class=xl67 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=15 class=xl68 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=46 style='mso-height-source:userset;height:34.5pt'>
  <td height=46 class=xl69 style='height:34.5pt'>No</td>
  <td class=xl70 style='border-left:none'>Division</td>
  <td class=xl70 style='border-left:none'>Department</td>
  <td class=xl70 style='border-left:none'>Team/Section</td>
  <td class=xl70 style='border-left:none'>Position</td>
  <td class=xl71 width=72 style='border-left:none;width:54pt'>Employee Type</td>
  <td class=xl70 style='border-left:none'>Emp ID</td>
  <td class=xl70 style='border-left:none'>Full Name</td>
  <td class=xl70 style='border-left:none'>Birth Date</td>
  <td class=xl70 style='border-left:none'>Sex</td>
  <td class=xl70 style='border-left:none'>Permanent Address</td>
  <td class=xl70 style='border-left:none'>Province</td>
  <td class=xl70 style='border-left:none'>Education</td>
  <td class=xl70 style='border-left:none'>Major</td>
  <td class=xl72 style='border-left:none'>Join Date</td>
 </tr>
 <% for(int i=0;i<dt_emp.Rows.Count;i++)
        { %>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl73 style='height:20.25pt;border-top:none' x:num><%=i+1 %></td>
  <td class=xl74 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][0].ToString() %></td>
  <td class=xl74 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][1].ToString() %></td>
  <td class=xl74 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][2].ToString() %></td>
  <td class=xl74 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][3].ToString() %></td>
  <td class=xl75 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][4].ToString() %></td>
  <td class=xl76 style='border-top:none;border-left:none' x:str><%=dt_emp.Rows[i][5].ToString() %></td>
  <td class=xl75 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][6].ToString() %></td>
  <td class=xl76 style='border-top:none;border-left:none' x:str><%=dt_emp.Rows[i][7].ToString() %></td>
  <td class=xl76 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][8].ToString() %></td>
  <td class=xl74 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][9].ToString() %></td>
  <td class=xl77 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][10].ToString() %></td>
  <td class=xl74 style='border-top:none;border-left:none' x:str><%=dt_emp.Rows[i][11].ToString() %></td>
  <td class=xl74 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][12].ToString() %></td>
  <td class=xl78 style='border-top:none;border-left:none' x:str><%=dt_emp.Rows[i][13].ToString() %></td>
 </tr>
 <% } %>
 <tr height=4 style='mso-height-source:userset;height:3.0pt'>
  <td height=4 class=xl79 style='height:3.0pt;border-top:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl81 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
 
 </tr>
 <![endif]>
</table>

</body>

</html>
