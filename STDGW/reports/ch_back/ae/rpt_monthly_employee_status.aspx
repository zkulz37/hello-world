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
    string p_user,p_month,p_month_text;
    p_user = Request["p_user"].ToString();
    p_month = Request["p_month"].ToString();
    p_month_text = Request["p_month_text"].ToString();
    string SQL
	= "select "+
	  "  (SELECT   MAX(T.org_nm) "+
      "        FROM tco_org t    "+
      "         WHERE t.del_if = 0 "+
      "         AND T.ORG_TYPE IN('06') "+
      "         START WITH t.pk=A.tco_dept_pk "+
      "          CONNECT BY PRIOR t.p_pk=t.pk) AS T1 "+
	    "   ,b.org_nm " + 
        ",a.BEGIN_MALE,a.BEGIN_FEMALE " +
        ",a.BEGIN_TOTAL " +
        ",a.NEW_MALE,a.NEW_FEMALE " +
        ",a.OUT_MALE,a.OUT_FEMALE " +
        ",a.END_MALE,a.END_FEMALE " +
        ",a.END_TOTAL ,to_char(sysdate,'dd/mm/yyyy') " +
        "from thr_employee_monthly a,tco_org b " +
        "where a.del_if=0 and b.del_if=0 " +
        "and a.tco_dept_PK=b.pk  " +
        "and a.monthLY='" + p_month + "'  " +
        "order by nvl(T1,'0'),B.org_nm" ;


    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt_total.Rows.Count;
    if (irow == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    //sum department 
	string SQL_Total
	= "SELECT sum(TR.K1),sum(TR.K2),sum(TR.K3),sum(TR.K4) " + 
        ",sum(TR.K5),sum(TR.K6),sum(TR.K7),sum(TR.K8),sum(TR.K9),sum(TR.K10),sum(TR.K11) " +
        ",TR.K0 " +
        "FROM " +
        "( " +
        "    SELECT (SELECT   MAX(T.org_nm)  " +
        "            FROM tco_org t     " +
        "             WHERE t.del_if = 0  " +
        "             AND T.ORG_TYPE IN('06')  " +
        "             START WITH t.pk=T12  " +
        "              CONNECT BY PRIOR t.p_pk=t.pk) K0 " +
        "           ,T1 K1,T2 K2,T3 K3,T4 K4,T5 K5,T6 K6,T7 K7 " +
        "           ,T8 K8,T9 K9,T10 K10,T11 K11    " +
        "    FROM " +
        "    ( " +
        "         select count(*) T1 " +
        "        ,sum(a.BEGIN_MALE) T2 " +
        "        ,sum(a.BEGIN_FEMALE) T3  " +
        "        ,sum(a.BEGIN_TOTAL) T4 " +
        "        ,sum(a.NEW_MALE) T5 " +
        "        ,sum(a.NEW_FEMALE) T6 " +
        "        ,sum(a.OUT_MALE) T7 " +
        "        ,sum(a.OUT_FEMALE) T8 " +
        "        ,sum(a.END_MALE) T9 " +
        "        ,sum(a.END_FEMALE) T10 " +
        "        ,sum(a.END_TOTAL)  T11 " +
        "        ,B.PK T12 " +
        "        from thr_employee_monthly a,tco_org b  " +
        "        where a.del_if=0 and b.del_if=0  " +
        "        and a.tco_dept_PK=b.pk   " +
        "        and a.monthLY='" + p_month + "'   " +
        "        group by b.PK  " +
        "    ) HR   " +
        "    )TR " +
        "GROUP BY TR.K0  " +
        "ORDER BY NVL(TR.K0,'0') " ;


    DataTable dt_dept = ESysLib.TableReadOpen(SQL_Total);
    int irow_dept;
    irow_dept = dt_dept.Rows.Count;
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_monthly_employee_status_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_monthly_employee_status_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_monthly_employee_status_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>ty-ml</o:LastAuthor>
  <o:LastPrinted>2008-08-09T02:50:00Z</o:LastPrinted>
  <o:Created>2008-08-08T02:47:23Z</o:Created>
  <o:LastSaved>2008-08-09T02:59:01Z</o:LastSaved>
  <o:Company>genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.51in .24in .37in .25in;
	mso-header-margin:.23in;
	mso-footer-margin:.19in;}
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
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	text-align:left;}
.xl37
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
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl38
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
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl39
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
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl40
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
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
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
      <x:Scale>87</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>3</x:SplitHorizontal>
     <x:TopRowBottomPane>3</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
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
  <x:WindowHeight>7935</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$2:$3</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=814 style='border-collapse:
 collapse;table-layout:fixed;width:611pt'>
 <col width=107 style='mso-width-source:userset;mso-width-alt:3913;width:80pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:3657;width:75pt'>
 <col width=53 span=2 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col width=77 style='mso-width-source:userset;mso-width-alt:2816;width:58pt'>
 <col width=55 span=2 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <col width=61 span=2 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col width=56 span=2 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col width=80 style='mso-width-source:userset;mso-width-alt:2925;width:60pt'>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td colspan=12 height=45 class=xl33 width=814 style='height:33.75pt;
  width:611pt'>MONTHLY EMPLOYEE STATUS - <%=p_month_text %></td>
 </tr>
 <tr class=xl24 height=34 style='mso-height-source:userset;height:25.5pt'>
  <td rowspan=2 height=68 class=xl37 style='border-bottom:.5pt solid black;
  height:51.0pt;border-top:none'>Department</td>
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black;border-top:
  none'>Group</td>
  <td colspan=2 class=xl25 style='border-left:none'>The Beginning</td>
  <td rowspan=2 class=xl39 width=77 style='border-bottom:.5pt solid black;
  border-top:none;width:58pt'>Beginning Total</td>
  <td colspan=2 class=xl25 style='border-left:none'>Newcomer</td>
  <td colspan=2 class=xl25 style='border-left:none'>Resigned</td>
  <td colspan=2 class=xl25 style='border-left:none'>The Ending</td>
  <td rowspan=2 class=xl39 width=80 style='border-bottom:.5pt solid black;
  border-top:none;width:60pt'>Ending Total</td>
 </tr>
 <tr class=xl24 height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl25 style='height:25.5pt;border-top:none;border-left:
  none'>Male</td>
  <td class=xl25 style='border-top:none;border-left:none'>Female</td>
  <td class=xl25 style='border-top:none;border-left:none'>Male</td>
  <td class=xl25 style='border-top:none;border-left:none'>Female</td>
  <td class=xl25 style='border-top:none;border-left:none'>Male</td>
  <td class=xl25 style='border-top:none;border-left:none'>Female</td>
  <td class=xl25 style='border-top:none;border-left:none'>Male</td>
  <td class=xl25 style='border-top:none;border-left:none'>Female</td>
 </tr>
 <% 
     string s_format;
     int start_row=3;
     int from_row;
     int to_row;
     int i_dept;
     int t;
     string cur_dept,new_dept,old_dept;
     Boolean b_TotalDept=false;
     i_dept=0;
     from_row=start_row;
     float [] intTotal = {0,0,0,0,0,0,0,0,0,0,0}; //total of columns
     for (int i = 0; i < irow; i++) 
    {
       start_row++;
       to_row=from_row;
       cur_dept=dt_total.Rows[i][0].ToString();
    %> 
 <tr class=xl26 height=34 style='mso-height-source:userset;height:25.5pt'>
 <%
    if (i==0) 
    {
        
  %>
  <td height=34 class=xl41 style='height:25.5pt;border-top:none' rowspan="<%=int.Parse(dt_dept.Rows[i_dept][0].ToString()) + 1 %>"><% = dt_total.Rows[i][0].ToString()%></td>
  <%
    }
    else
    {
        old_dept=dt_total.Rows[i-1][0].ToString();
        if (old_dept != cur_dept)
        {
            i_dept++;
   %>
   <td height=34 class=xl41 style='height:25.5pt;border-top:none' rowspan="<%=int.Parse(dt_dept.Rows[i_dept][0].ToString()) + 1 %>"><% = dt_total.Rows[i][0].ToString()%></td>
  <%
            
        }
    }
    %> 
  <td class=xl29 style='border-top:none;border-left:none'><% = dt_total.Rows[i][1].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><% = dt_total.Rows[i][2].ToString()%> </td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><% = dt_total.Rows[i][3].ToString()%> </td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><% = dt_total.Rows[i][4].ToString()%> </td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><% = dt_total.Rows[i][5].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><% = dt_total.Rows[i][6].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><% = dt_total.Rows[i][7].ToString()%> </td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><% = dt_total.Rows[i][8].ToString()%> </td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><% = dt_total.Rows[i][9].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><% = dt_total.Rows[i][10].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><% = dt_total.Rows[i][11].ToString()%></td>
 </tr>
 <%
    if (i==irow-1)  //start of total dept
        b_TotalDept=true;
    else
    {
       
       new_dept=dt_total.Rows[i+1][0].ToString();
       if (cur_dept != new_dept)
            b_TotalDept=true;
    }
    if (b_TotalDept==true)
    {
        to_row=start_row;
        start_row++;
        from_row=start_row;
        
        for (t=0;t<=9;t++) //sum of department 
            intTotal[t] = intTotal[t] + float.Parse(dt_dept.Rows[i_dept][t+1].ToString());
  %>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td class=xl42 style='border-top:none;border-left:none'>Total <%=cur_dept %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><% = dt_dept.Rows[i_dept][1].ToString()%> </td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><% = dt_dept.Rows[i_dept][2].ToString()%> </td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><% = dt_dept.Rows[i_dept][3].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><% = dt_dept.Rows[i_dept][4].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><% = dt_dept.Rows[i_dept][5].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><% = dt_dept.Rows[i_dept][6].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><% = dt_dept.Rows[i_dept][7].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><% = dt_dept.Rows[i_dept][8].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><% = dt_dept.Rows[i_dept][9].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><% = dt_dept.Rows[i_dept][10].ToString()%></td>
 </tr>
 <%
    b_TotalDept=false;
    } //end of total dept
  %>
 <%
    }
  %>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td colspan=2 height=34 class=xl34 style='border-right:.5pt solid black;
  height:25.5pt'>Grant Total</td>
  <td class=xl27 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%=intTotal[0] %></td>
  <td class=xl27 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%=intTotal[1] %></td>
  <td class=xl27 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><%=intTotal[2] %></td>
  <td class=xl27 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%=intTotal[3] %></td>
  <td class=xl27 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%=intTotal[4] %></td>
  <td class=xl27 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%=intTotal[5] %></td>
  <td class=xl27 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%=intTotal[6] %></td>
  <td class=xl27 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%=intTotal[7] %></td>
  <td class=xl27 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%=intTotal[8] %></td>
  <td class=xl27 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%=intTotal[9] %></td>
 </tr>
 <tr height=51 style='height:38.25pt;mso-xlrowspan:3'>
  <td height=51 colspan=12 style='height:38.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=6 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'>Reporter:</td>
  <td></td>
  <td><%=p_user %></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=6 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'>Reported Date:</td>
  <td></td>
  <td colspan=2 class=xl36 x:num><% = dt_total.Rows[0][12].ToString()%></td>
  <td></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=107 style='width:80pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=80 style='width:60pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
