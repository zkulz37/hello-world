<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string P_TEAM_PK, P_SEARCH_BY, P_SEARCH_TEMP, P_INCLUDE, P_EXPIRY_FROM, P_EXPIRY_TO, P_TCO_ORG_PK, P_STATUS;

    P_TEAM_PK = Request["P_TEAM_PK"].ToString();
    P_SEARCH_BY = Request["P_SEARCH_BY"].ToString();
    P_SEARCH_TEMP = Request["P_SEARCH_TEMP"].ToString();
    P_INCLUDE = Request["P_INCLUDE"].ToString();
    P_EXPIRY_FROM = Request["P_EXPIRY_FROM"].ToString();
    P_EXPIRY_TO = Request["P_EXPIRY_TO"].ToString();
    P_TCO_ORG_PK = Request["P_TCO_ORG_PK"].ToString();
    P_STATUS = Request["P_STATUS"].ToString();

    string SQL
    = "SELECT " +
        "        B.ORG_NM AS ORG_NM,  " +
        "        C.WORKGROUP_NM AS TEAM,  " +
        "        A.EMP_ID,   " +
        "        A.FULL_NAME,   " +
        "        to_char(to_date(A.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy'),   " +
        "        POS_TYPE.code_nm, " +
        "        D.rental_amt,     " +
        "        D.Deposit_amt,     " +
        "        to_char(to_date(D.FROM_DT,'yyyymmdd'),'dd/mm/yyyy'),   " +
        "        to_char(to_date(D.TO_DT,'yyyymmdd'),'dd/mm/yyyy')   " +
        "     FROM THR_EMPLOYEE A,TCO_ORG B,THR_WORK_GROUP C " +
        "     ,(SELECT A.CODE,A.CODE_NM FROM THR_CODE_DETAIL A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND A.THR_CODE_MASTER_PK=B.PK AND B.ID ='HR0008') POS_TYPE " +
        "     ,THR_F_RENTAL_HOUSE D " +
        "     WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0 AND A.TCO_ORG_PK=B.PK AND A.THR_WG_PK=C.PK " +
        "     AND A.POS_TYPE=POS_TYPE.CODE(+) AND D.DEL_IF=0 " +
        "     AND A.THR_F_RENTAL_HOUSE_PK=D.PK  " +
        "     AND DECODE('" + P_TEAM_PK + "','ALL','ALL',c.PK)='" + P_TEAM_PK + "' " +
        "     AND (('" + P_SEARCH_BY + "'='1' AND UPPER(A.FULL_NAME) LIKE  '%' || UPPER('" + P_SEARCH_TEMP + "')|| '%') " +
        "         OR ('" + P_SEARCH_BY + "'='2' AND UPPER(A.EMP_ID) LIKE  '%' || UPPER('" + P_SEARCH_TEMP + "')|| '%') " +
        "     ) " +
        "     AND ('" + P_INCLUDE + "'='01' OR '" + P_INCLUDE + "'='ALL') " +
        "     AND A.NATION <>'01' " +
        "     AND TO_CHAR(TO_DATE(D.TO_DT,'YYYYMMDD')+1,'YYYYMMDD') BETWEEN '" + P_EXPIRY_FROM + "' AND '" + P_EXPIRY_TO + "'  " +
        "     AND DECODE('" + P_STATUS + "','ALL','ALL',A.STATUS)='" + P_STATUS + "' " +
        "      AND (   A.TCO_ORG_PK IN ( " +
        "                              SELECT     G.PK " +
        "                                    FROM TCO_ORG G " +
        "                                   WHERE G.DEL_IF = 0 " +
        "                              START WITH G.PK = " +
        "                                            DECODE ('" + P_TCO_ORG_PK + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + P_TCO_ORG_PK + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR G.PK = G.P_PK) " +
        "                        OR '" + P_TCO_ORG_PK + "' = 'ALL') " +
        "      ORDER BY emp_id ";

	
	//Response.Write(SQL);
	//Response.End();
	
    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp=dt_Emp.Columns.Count;
    if (irow_emp == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }    
    
   
 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_foreigner_2_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_foreigner_2_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_foreigner_2_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2011-09-07T03:58:45Z</o:LastPrinted>
  <o:Created>2008-05-23T07:19:16Z</o:Created>
  <o:LastSaved>2011-09-08T03:40:40Z</o:LastSaved>
  <o:Company>genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.41in .11in .26in .15in;
	mso-header-margin:.24in;
	mso-footer-margin:.14in;
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:15.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
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
      <x:PaperSizeIndex>5</x:PaperSizeIndex>
      <x:Scale>46</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>3</x:SplitHorizontal>
     <x:TopRowBottomPane>3</x:TopRowBottomPane>
     <x:SplitVertical>4</x:SplitVertical>
     <x:LeftColumnRightPane>4</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
       <x:RangeSelection>$H$2:$J$2</x:RangeSelection>
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
  <x:WindowHeight>8835</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$5:$6</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1025"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1124 style='border-collapse:
 collapse;table-layout:fixed;width:846pt'>
 <col class=xl24 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl24 width=118 style='mso-width-source:userset;mso-width-alt:4315;
 width:89pt'>
 <col class=xl24 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col class=xl24 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl24 width=172 style='mso-width-source:userset;mso-width-alt:6290;
 width:129pt'>
 <col class=xl24 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl24 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl24 width=122 style='mso-width-source:userset;mso-width-alt:4461;
 width:92pt'>
 <col class=xl24 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl24 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=10 height=38 class=xl39 width=932 style='height:28.5pt;
  width:702pt;border:none'>RENTAL HOUSE LIST </td>
 </tr>
 <tr class=xl25 height=43 style='mso-height-source:userset;height:27.75pt'>
    <td  colspan=2 height=43  style='height:27.75pt;border:none;text-align:right'><b>Expiry Date  From</b>
    </td>
    <td  style='height:27.75pt;border:none'><%=P_EXPIRY_FROM.Substring(5, 2).ToString() + "/" + P_EXPIRY_FROM.Substring(4, 2).ToString() + "/" + P_EXPIRY_FROM.Substring(0, 4).ToString() %>
    </td>
    <td   style='height:27.75pt;border:none;text-align:right'><b>To</b>
    </td>
    
    <td  style='height:27.75pt;border:none'><%=P_EXPIRY_TO.Substring(5, 2).ToString() + "/" + P_EXPIRY_TO.Substring(4, 2).ToString() + "/" + P_EXPIRY_TO.Substring(0, 4).ToString() %>
    </td>
 </tr>
 <tr class=xl25 height=43 style='mso-height-source:userset;height:27.75pt'>
  <td height=43 class=xl26 style='height:27.75pt'>No</td>
  <td class=xl27 >Department</td>
  <td class=xl27 >Group</td>
  <td class=xl27 >Emp ID</td>
  <td class=xl27 >Full Name</td>
  <td class=xl27 >Join Date</td>
  <td class=xl27 >Position</td>
  <td colspan=4 class=xl37 style='border-right:.5pt solid black;border-left:
  none'>Rental House</td>
 </tr>
 <tr class=xl25 height=43 style='mso-height-source:userset;height:27.75pt'>
  <td height=43 class=xl28 style='height:27.75pt'>STT</td>
  <td class=xl29>Bộ phận</td>
  <td class=xl29>Nhóm</td>
  <td class=xl29>Mã NV</td>
  <td class=xl29>Họ và tên</td>
  <td class=xl29>Ngày vào</td>
  <td class=xl29>Chức vụ</td>
  <td class=xl29>Rental Amt</td>
  <td class=xl29>Deposit Amt</td>
  <td class=xl29>Issue Date</td>
  <td class=xl29>Expiry Date</td>
 </tr>
 <%
    int i;
	for (i=0;i<irow_emp;i++)
    {	
		
  %>
 <tr class=xl30 height=53 style='mso-height-source:userset;height:27.75pt'>
  <td height=53 class=xl31 style='height:27.95pt'><%=i+1 %>&nbsp;</td>
  <% 
    for (int k=0;k<icol_emp;k++)
    {
        
   %>
  <td class=xl32><%=dt_Emp.Rows[i][k].ToString()%>&nbsp;</td>
  <%    
  } %>
  <td colspan=8 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <tr class=xl40 height=68 style='mso-height-source:userset;height:12.75pt'>
  <td height=68 class=xl34 style='height:12.75pt' x:num></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=47 style='width:35pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=172 style='width:129pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
