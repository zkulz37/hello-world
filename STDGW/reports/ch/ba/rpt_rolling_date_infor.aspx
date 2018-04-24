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
    string p_lstinfo_type,p_from,p_to,p_search,p_input,p_lstinfo_type_t;
     
    p_lstinfo_type = Request["p_lstinfo_type"].ToString();
    p_lstinfo_type_t = Request["p_lstinfo_type_t"].ToString();
    p_from         = Request["p_from"].ToString();
    p_to           = Request["p_to"].ToString();
    p_search       = Request["p_search"].ToString();
    p_input        = Request["p_input"].ToString();
   
    
   string SQL
	= "SELECT HR.T1,HR.T2,HR.T3,HR.T4,HR.T5,HR.T6 " + 
        "    FROM( " +
        "    SELECT (select e.org_nm from tco_org e where e.del_if=0 and e.pk=c.tco_org_pk) as t1 " +
        "            ,b.id AS T2,b.FULL_NAME AS T3,b.CARD_NO AS T4,to_char(to_date(b.WORK_DT,'yyyymmdd'),'dd/mm/yyyy') AS T5,b.TIME AS T6 " +
        "        FROM thr_time_temp4 b,thr_employee c " +
        "        where c.del_if=0 and b.WORK_DT between '" + p_from + "' and '" + p_to + "' " +
        "        and b.ID=c.ID_NUM " +
        "        and ('" + p_lstinfo_type + "'='0' OR '" + p_lstinfo_type + "'='ALL')  " +
        "        AND (DECODE('" + p_search + "','1',UPPER(B.ID),'2',B.ID,'3',UPPER(B.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "') " +
        "                        OR '" + p_input + "' IS NULL) " +
        "    UNION " +
        "    SELECT (select e.org_nm from tco_org e where e.del_if=0 and e.pk=c.tco_org_pk) as t1 " +
        "            ,b.id AS T2,b.FULL_NAME AS T3,b.CARD_NO AS T4,to_char(to_date(b.WORK_DT,'yyyymmdd'),'dd/mm/yyyy') AS T5,b.TIME AS T6 " +
        "        FROM thr_time_temp3 b,thr_employee c,thr_visitor_register d " +
        "        where c.del_if(+)=0 and b.WORK_DT between '" + p_from + "' and '" + p_to + "' " +
        "        and b.ID=c.ID_NUM(+) and d.del_if=0 and b.THR_VISITOR_REGISTER_PK=d.pk and b.work_dt=d.checkin_date " +
        "        and ('" + p_lstinfo_type + "'='1' OR '" + p_lstinfo_type + "'='ALL')  " +
        "        AND LENGTH(B.ID) < 6 " +
        "        AND (DECODE('" + p_search + "','1',UPPER(B.ID),'2',B.ID,'3',UPPER(D.VISITOR_NM)) LIKE '%'||UPPER('" + p_input + "') " +
        "                        OR '" + p_input + "' IS NULL) " +
        "    UNION " +
        "    SELECT 'Sub Contract' as t1 " +
        "            ,b.id AS T2,b.FULL_NAME AS T3,b.CARD_NO AS T4,to_char(to_date(b.WORK_DT,'yyyymmdd'),'dd/mm/yyyy') AS T5,b.TIME AS T6 " +
        "        FROM thr_time_temp4 b,thr_employee c " +
        "        where c.del_if(+)=0 and b.WORK_DT between '" + p_from + "' and '" + p_to + "' " +
        "        and b.ID=c.ID_NUM(+) " +
        "        and ('" + p_lstinfo_type + "'='2' OR '" + p_lstinfo_type + "'='ALL')   " +
        "        AND LENGTH(B.ID) = 6 AND SUBSTR(B.ID,1,1)=3 " +
        "        AND (DECODE('" + p_search + "','1',UPPER(B.ID),'2',B.ID,'3',UPPER(B.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "') " +
        "                        OR '" + p_input + "' IS NULL)  " +
        "    )HR     " ;




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
<meta http-equiv=Content-Type content="text/html; charset=uft-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_rolling_date_infor_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_rolling_date_infor_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_rolling_date_infor_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>EINSVINA</o:Author>
  <o:LastAuthor>Ho Thu Hien</o:LastAuthor>
  <o:LastPrinted>2010-01-08T08:32:37Z</o:LastPrinted>
  <o:Created>2006-12-21T09:46:33Z</o:Created>
  <o:LastSaved>2010-01-08T08:34:30Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.28in .33in .33in .4in;
	mso-header-margin:.27in;
	mso-footer-margin:.31in;}
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
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl42
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
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl48
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
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>79</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>7</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
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
  <x:WindowHeight>8475</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
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

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=863 style='border-collapse:
 collapse;table-layout:fixed;width:649pt'>
 <col class=xl24 width=42 style='mso-width-source:userset;mso-width-alt:1536;
 width:32pt'>
 <col class=xl24 width=130 style='mso-width-source:userset;mso-width-alt:4754;
 width:98pt'>
 <col class=xl24 width=121 style='mso-width-source:userset;mso-width-alt:4425;
 width:91pt'>
 <col class=xl24 width=199 style='mso-width-source:userset;mso-width-alt:7277;
 width:149pt'>
 <col class=xl24 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl24 width=30 style='mso-width-source:userset;mso-width-alt:1097;
 width:23pt'>
 <col class=xl24 width=123 style='mso-width-source:userset;mso-width-alt:4498;
 width:92pt'>
 <col class=xl24 width=138 style='mso-width-source:userset;mso-width-alt:5046;
 width:104pt'>
 <tr height=43 style='mso-height-source:userset;height:32.25pt'>
  <td colspan=8 height=43 class=xl31 width=863 style='height:32.25pt;
  width:649pt'>ROLLING GATE INFORMATION</td>
 </tr>
 <tr class=xl32 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl33 style='height:21.75pt'></td>
  <td class=xl45>Information Type:</td>
  <td class=xl43><%=p_lstinfo_type_t %></td>
  <td class=xl45>Work Date:</td>
  <td class=xl43><%=p_from.Substring(6,2) + "/" + p_from.Substring(4,2) + "/" + p_from.Substring(0,4) %></td>
  <td class=xl44>~</td>
  <td class=xl43><%=p_to.Substring(6,2) + "/" + p_to.Substring(4,2) + "/" + p_to.Substring(0,4) %></td>
  <td class=xl45></td>
 </tr>
 <tr class=xl32 height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 class=xl34 style='height:10.5pt'>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
 </tr>
  
 <tr class=xl25 height=44 style='mso-height-source:userset;height:33.0pt'>
  <td height=44 class=xl30 width=42 style='height:33.0pt;border-top:none;
  width:32pt'>No.</td>
  <td class=xl30 width=130 style='border-top:none;border-left:none;width:98pt'>Organization</td>
  <td class=xl30 width=121 style='border-top:none;border-left:none;width:91pt'>Emp
  ID</td>
  <td class=xl30 width=199 style='border-top:none;border-left:none;width:149pt'>Full
  Name</td>
  <td class=xl30 width=80 style='border-top:none;border-left:none;width:60pt'>Card
  ID</td>
  <td colspan=2 class=xl35 width=153 style='border-right:.5pt solid black;
  border-left:none;width:115pt'>Check Date</td>
  <td class=xl30 width=138 style='border-top:none;border-left:none;width:104pt'>Check
  Time</td>
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
 <tr class=xl26 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl27 style='height:27.0pt<%=s_format%>' x:num><%=i+1 %></td>
  <td class=xl28 style='height:27.0pt<%=s_format%>' ><% = dt_total.Rows[i][0].ToString()%></td>
  <td class=xl46 style='height:27.0pt<%=s_format%>'  x:str><% = dt_total.Rows[i][1].ToString()%></td>
  <td class=xl29 style='height:27.0pt<%=s_format%>' x:str><% = dt_total.Rows[i][2].ToString()%></td>
  <td class=xl29 style='height:27.0pt<%=s_format%>' x:str><% = dt_total.Rows[i][3].ToString()%></td>
  <td colspan=2   class=xl47 style='border-right:.5pt solid black;border-left:
  none<%=s_format%>' x:str><% = dt_total.Rows[i][4].ToString()%></td>
  <td class=xl49 style='height:27.0pt<%=s_format%>' x:str><% = dt_total.Rows[i][5].ToString()%></td>
 </tr>
  <%
    }
  %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=42 style='width:32pt'></td>
  <td width=130 style='width:98pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=199 style='width:149pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=138 style='width:104pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
