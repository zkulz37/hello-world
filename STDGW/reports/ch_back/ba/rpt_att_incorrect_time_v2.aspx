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
    string p_user,p_tco_org_pk,p_wg,p_work_shift,p_search_by,p_search_temp;
    string p_from_date,p_to_date,p_from_date_text,p_to_date_text,p_date_type,p_nation;
     
  
    p_tco_org_pk       = Request["p_tco_org_pk"].ToString();
    p_wg      = Request["p_wg"].ToString();
    p_date_type         = Request["p_date_type"].ToString();
    p_search_by         = Request["p_search_by"].ToString();
    p_search_temp       = Request["p_search_temp"].ToString();
    p_work_shift        = Request["p_work_shift"].ToString();
    p_from_date         = Request["p_from_date"].ToString();
    p_to_date           = Request["p_to_date"].ToString();
    p_user              = Request["p_user"].ToString();
	p_nation              = Request["p_nation"].ToString();
   
    
    
   string SQL
	= "SELECT  to_char(sysdate,'dd/mm/yyyy'),t.org_nm org_nm, a.workgroup_nm workgroup_nm, v.emp_id emp_id, v.full_name, " + 
        "         TO_CHAR (TO_DATE (d.work_dt, 'yyyymmdd'), 'dd/mm/yyyy') AS w_date, " +
        "         ('S' || W.START_TIME || '-E' || W.END_TIME || (CASE WHEN W.START_MEAL1 IS NOT NULL THEN 'SM1:' || W.START_MEAL1 || '-EM1:' || W.END_MEAL1 END ) " +
        "|| (CASE WHEN W.START_MEAL2 IS NOT NULL THEN 'SM2:' || W.START_MEAL2 || '-EM2:' || W.END_MEAL2 END )) as w_shift, " +
        "        d.time_in AS time_in, d.time_out AS time_out " +
        "   FROM thr_time_machine d, " +
        "        thr_employee v, " +
        "         thr_work_group a, " +
        "         tco_org t,thr_work_shift w " +
        "   WHERE d.del_if = 0 " +
        "     AND v.del_if = 0 " +
        "     and w.del_if=0  " +
        "     and w.pk=d.THR_WS_PK " +
       "     AND t.del_if = 0 and v.join_dt<=d.work_dt" +
        "     AND (v.left_dt is null or v.left_dt>d.work_dt) " +
        "     AND a.pk = v.thr_wg_pk " +
        "     AND t.pk = v.tco_org_pk " +
        "     AND v.pk = d.thr_emp_pk " +        
		"     AND DECODE('" + p_nation + "' ,'ALL', '" + p_nation + "',v.nation) =  '" + p_nation  + "'" +
        "     AND DECODE ('" + p_work_shift + "', 'ALL', '" + p_work_shift + "', d.thr_ws_pk) = '" + p_work_shift  + "'" +
        "     AND DECODE ('" + p_wg + "', 'ALL', '" + p_wg + "', v.thr_wg_pk) = '" + p_wg  + "'" +
        "     AND (   DECODE ('" + p_search_by + "', " +
        "                     '1', UPPER (v.emp_id), " +
        "                     '2', v.id_num, " +
        "                     '3', UPPER (v.full_name) " +
        "                    ) LIKE '%' || UPPER ('" + p_search_temp + "') " +
        "          OR '" + p_search_temp + "' IS NULL " +
        "         ) " ;
        SQL = SQL + "                   AND (    v.TCO_ORG_PK IN ( ";
        SQL = SQL + "                       SELECT     G.PK ";
        SQL = SQL + "                             FROM TCO_ORG G ";
        SQL = SQL + "                            WHERE G.DEL_IF = 0           ";                           
        SQL = SQL + "                       START WITH G.PK = ";
        SQL = SQL + "                                     DECODE ('"+p_tco_org_pk+"', ";
        SQL = SQL + "                                             'ALL', 0, ";
        SQL = SQL + "                                             '"+p_tco_org_pk+"' ";
        SQL = SQL + "                                            ) ";
        SQL = SQL + "                       CONNECT BY PRIOR G.PK = G.P_PK) ";
        SQL = SQL + "                 OR '"+p_tco_org_pk+"' = 'ALL') "+
        "     and (d.TIME_IN is null or d.TIME_OUT is null)  " +
		"     AND d.work_dt BETWEEN '" + p_from_date + "' AND '" + p_to_date  + "'" + 
        "     order by d.work_dt,v.emp_id " ;

        
        
        
//Response.Write(SQL);
//Response.End();
    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt_total.Rows.Count;
    if (irow == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_att_incorrect_time_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_att_incorrect_time_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_att_incorrect_time_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>ty-ml</o:LastAuthor>
  <o:LastPrinted>2008-07-21T08:22:10Z</o:LastPrinted>
  <o:Created>2008-05-23T07:19:16Z</o:Created>
  <o:LastSaved>2008-07-21T08:26:04Z</o:LastSaved>
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
	margin:.41in .41in .26in .33in;
	mso-header-margin:.24in;
	mso-footer-margin:.14in;}
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
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
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
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
      <x:Scale>69</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>6</x:SplitHorizontal>
     <x:TopRowBottomPane>6</x:TopRowBottomPane>
     <x:SplitVertical>5</x:SplitVertical>
     <x:LeftColumnRightPane>5</x:LeftColumnRightPane>
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
       <x:ActiveRow>4</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
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
  <x:WindowTopY>75</x:WindowTopY>
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

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=985 style='border-collapse:
 collapse;table-layout:fixed;width:740pt'>
 <col class=xl24 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl24 width=104 style='mso-width-source:userset;mso-width-alt:3803;
 width:78pt'>
 <col class=xl24 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col class=xl24 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl24 width=229 style='mso-width-source:userset;mso-width-alt:8374;
 width:172pt'>
 <col class=xl24 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl24 width=178 style='mso-width-source:userset;mso-width-alt:6509;
 width:134pt'>
 <col class=xl24 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl24 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=9 height=38 class=xl42 width=985 style='height:28.5pt;width:740pt'>INCORRECT
  TIMES</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl38 x:str><%if (p_date_type=="3") 
                        Response.Write("Month");
                    else
                        Response.Write("From Date");%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl33><%if (p_date_type=="3") 
                        Response.Write(p_from_date.Substring(4,2) + "/" + p_from_date.Substring(0,4));
                    else
                        Response.Write(p_from_date.Substring(6,2) + "/" + p_from_date.Substring(4,2) + "/" + p_from_date.Substring(0,4));
                        %></td>
  <td class=xl32><%if (p_date_type!="3") 
                        Response.Write("To Date");%></td>
  <td class=xl33 x:num><%if (p_date_type!="3") 
                            Response.Write(p_to_date.Substring(6,2) + "/" + p_to_date.Substring(4,2) + "/" + p_to_date.Substring(0,4));
                            %></td>
  <td class=xl24></td>
  <td class=xl32>Reporter</td>
  <td colspan=2 class=xl43><%=p_user %></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl38></td>
  <td class=xl37></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl32>Report Date</td>
  <td colspan=2 class=xl33 x:num><%= dt_total.Rows[0][0].ToString() %></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl32></td>
  <td class=xl33></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl30 style='height:19.5pt'>No</td>
  <td class=xl30 style='border-left:none'>Organization</td>
  <td class=xl30 style='border-left:none'>Work Group</td>
  <td class=xl30 style='border-left:none'>Emp ID</td>
  <td class=xl30 style='border-left:none'>Full Name</td>
  <td class=xl30 style='border-left:none'>Date</td>
  <td class=xl30 style='border-left:none'>Work Shift</td>
  <td class=xl30 style='border-left:none'>IN Time</td>
  <td class=xl30 style='border-left:none'>OUT Time</td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl31 style='height:19.5pt;border-top:none'>STT</td>
  <td class=xl31 style='border-top:none;border-left:none'>B&#7897; ph&#7853;n</td>
  <td class=xl31 style='border-top:none;border-left:none'>Nhóm</td>
  <td class=xl31 style='border-top:none;border-left:none'>Mã NV</td>
  <td class=xl31 style='border-top:none;border-left:none'>H&#7885; và tên</td>
  <td class=xl31 style='border-top:none;border-left:none'>Ngày</td>
  <td class=xl31 style='border-top:none;border-left:none'>Ca làm vi&#7879;c</td>
  <td class=xl31 style='border-top:none;border-left:none'>Gi&#7901; vào</td>
  <td class=xl31 style='border-top:none;border-left:none'>Gi&#7901; ra</td>
 </tr>
 <% 
     string s_format;
     for (int i = 0; i < irow; i++) 
    {
        if (i == irow - 1)
            s_format = ";border-bottom:.5pt solid windowtext";
        else
            s_format = ";";
    %> 
 <tr class=xl26 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl27 style='height:19.5pt;border-top:none<%=s_format%>' x:num><%=i+1 %></td>
  <td class=xl28 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][1].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][2].ToString()%></td>
  <td class=xl27 style='border-top:none;border-left:none<%=s_format%>' x:num><% = dt_total.Rows[i][3].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][4].ToString()%></td>
  <td class=xl29 style='border-top:none;border-left:none<%=s_format%>' x:num><% = dt_total.Rows[i][5].ToString()%></td>
  <td class=xl27 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][6].ToString()%></td>
  <td class=xl39 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][7].ToString()%></td>
  <td class=xl39 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][8].ToString()%></td>
 </tr>
 <%
    }
  %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=47 style='width:35pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=229 style='width:172pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=178 style='width:134pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=80 style='width:60pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
