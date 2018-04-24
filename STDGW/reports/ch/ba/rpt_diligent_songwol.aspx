<%@ Page Language="C#" %>
<%@ Import Namespace = "System.Data" %>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;

    %>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_month = "200811", p_from = "20081101", p_to="20081130";
    p_month = Request["l_work_mon"].ToString();
    p_to = Request["l_to_dt"].ToString();
    p_from = Request["l_from_dt"].ToString();
    string SQL
	= "select  " + 
        " g.pk,g.org_nm,sum( case when tb.att=0  then 1 else 0 end )absence " +
        " ,sum(tb.att) att,count(*) total " +
        "from " +
        "(  " +
        " select  " +
        "    (case  " +
        "   when nvl(a.ABSENCE_TYPE,' ') not in ('05','13')  " +
        "  and  " +
        "   ( " +
        "   t.pk is not null " +
        "   and( F_LATELY_EARLY(t.DATE_OUT,t.TIME_OUT,DECODE(ws.DURING_DAY,1,t.WORK_DT,TO_CHAR(TO_DATE(t.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),ws.END_TIME) " +
        "        + F_LATELY_EARLY(t.WORK_DT,ws.START_TIME,t.DATE_IN,t.TIME_IN)             " +
        "       ) < 120            " +
        "   )   " +
        "    then  " +
        "        1 " +
        "     else  " +
        "        0 " +
        "     end )att , " +
        "    emp.pk,emp.hol_type,emp.CAR_DATE,emp.org_pk     " +
        "from  " +
        "thr_time_machine t,thr_absence a,THR_WORK_SHIFT ws, " +
        "(select e.pk ,c.CAR_DATE,c.HOL_TYPE,c.DAY_TYPE,  " +
        "(SELECT   MAX(T.pk) " +
        "                                    FROM comm.tco_org t " +
        "                                    WHERE t.del_if = 0 " +
        "                                    AND T.ORG_TYPE IN('06') " +
        "                                    START WITH t.pk=e.tco_org_pk " +
        "                                    CONNECT BY PRIOR t.p_pk=t.pk) org_pk " +
        "from thr_employee e,comm.tco_abcalendar c " +
        "where c.del_if=0 " +
        "and c.CAR_DATE between  '"+p_from+"' and '"+p_to+"' " +
        "and nvl(e.LEFT_DT,'30000101')>c.CAR_DATE  " +
        "and e.join_dt <= c.CAR_DATE " +
        "and c.CAR_DATE not in " +
        "    ( select c.CAR_DATE  from thr_absence_reg g where g.del_if=0 and g.thr_emp_pk= e.pk and c.CAR_DATE between g.START_DT and g.END_DT " +
        "    ) " +
        ") emp " +
        "where t.del_if(+)=0 and a.del_if(+)=0 " +
        "and emp.CAR_DATE=t.WORK_DT(+) " +
        "and emp.CAR_DATE=a.ABSENCE_DT(+) " +
        "and emp.pk=t.THR_EMP_PK(+) " +
        " and emp.pk=a.thr_emp_pk(+) " +
        " and ws.PK(+)=t.THR_WS_PK " +
        " and ws.del_if(+)=0 " +
        ")tb,thr_employee e,comm.tco_org g " +
        "where e.pk=tb.pk and e.del_if=0 and g.del_if=0 and tb.org_pk=g.pk " +
        "group by  g.pk,g.org_nm,tb.CAR_DATE,tb.HOL_TYPE " +
        "order by g.pk,g.org_nm,tb.CAR_DATE,tb.HOL_TYPE " ;
  // Response.Write(SQL);
//Response.End();
    DataTable dt_org = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt_org.Rows.Count;
    if (irow == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
        
string SQL_date
	= "select substr(c.CAR_DATE,-2),c.HOL_TYPE from  comm.tco_abcalendar c " + 
        "where c.del_if=0 " +
        "and c.CAR_DATE between  '"+p_from+"' and '"+p_to+"' order by c.CAR_DATE " ;
 DataTable dt_date = ESysLib.TableReadOpen(SQL_date);

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
  <o:Created>2010-10-20T02:44:57Z</o:Created>
  <o:LastSaved>2010-10-22T07:01:23Z</o:LastSaved>
  <o:Company>AS</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.1in .3in .1in .3in;
	mso-header-margin:.1in;
	mso-footer-margin:.3in;
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
.xl25
	{mso-style-parent:style0;
	color:blue;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFFFCC;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:#FFCC99 none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:#FFCC99 none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
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
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:#FFCC99 none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FFFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FFFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
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
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>2</x:ActiveRow>
       <x:RangeSelection>$3:$3</x:RangeSelection>
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
  <x:WindowHeight>12270</x:WindowHeight>
  <x:WindowWidth>19035</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$3:$3</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=936 style='border-collapse:
 collapse;table-layout:fixed;width:703pt'>
 <col width=221 style='mso-width-source:userset;mso-width-alt:8082;width:166pt'>
 <col width=91 span=6 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=91 span=<%=dt_date.Rows.Count %> style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 
 <col width=48 style='mso-width-source:userset;mso-width-alt:1755;width:36pt'>
 
 <col width=51 style='mso-width-source:userset;mso-width-alt:1865;width:38pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=102 style='mso-width-source:userset;mso-width-alt:3730;width:77pt'>
 <col width=109 style='mso-width-source:userset;mso-width-alt:3986;width:82pt'>
 <col width=125 style='mso-width-source:userset;mso-width-alt:4571;width:94pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <tr height=25 style='height:12.75pt'>
  <td height=25  colspan=30   style='height:12.75pt;width:166pt;
  font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;'>DELIGENT REPORT MONTH <%=p_month.Substring(4,2) + "/" + p_month.Substring(0, 4)%> </td>
  
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=9 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl25 style='height:16.5pt'>Organization</td>
  <td class=xl25 style='border-left:none'>&nbsp;</td>
  <%
    for(int i=0 ;i< dt_date.Rows.Count;i++) {%>
  
  <td class=xl25 style='border-left:none;<%=(dt_date.Rows[i][1].ToString()=="")?";background:#FFFFCC;":";background:#FFCC99" %>' x:str><%=dt_date.Rows[i][0].ToString() %> </td>
  
  <%} %>
  
  
  <td class=xl25 style='border-left:none'>Total</td>
  <td class=xl25 style='border-left:none'>Attendence</td>
  <td class=xl25 style='border-left:none'>Absence</td>
  <td class=xl25 style='border-left:none'>Diligent Rate</td>
  <td class=xl25 style='border-left:none'>Category</td>
 </tr>
 <% int org_num=0; string org_pk="";
 int  abs=0;
 int  att=0;
 int  Total=0;
 
 for (int i=0;i<dt_org.Rows.Count;i++){ 
 org_pk=dt_org.Rows[i][0].ToString();
 %>
 <tr height=21 style='height:15.75pt'>
  <td rowspan=3 height=63 class=xl32 style='border-bottom:.5pt solid black;
  height:47.25pt'><%=dt_org.Rows[i][1].ToString() %></td>
  <td class=xl44 style='border-left:none'>Absence</td>
  <% for(int j=0;j< dt_org.Rows.Count;j++) { 
    
    if((i+j) >= dt_org.Rows.Count || dt_org.Rows[i+j][0].ToString()!=org_pk)
        break;
    if(dt_date.Rows[j][1].ToString()=="")
    {
        abs = abs + int.Parse(dt_org.Rows[i + j][2].ToString());
        att = att + int.Parse(dt_org.Rows[i + j][3].ToString());
        Total = Total + int.Parse(dt_org.Rows[i + j][4].ToString());
	}
    
          
   %>
  <td class=<%=(dt_date.Rows[j][1].ToString()=="")?"xl26":"xl27" %> style='border-left:none' x:num><%=(dt_date.Rows[j][1].ToString() == "") ? dt_org.Rows[i + j][2].ToString() : "0"%></td>
  <%} %>
  
  
  <td rowspan=3 class=xl35 style='border-bottom:.5pt solid black;border-top:
  none' x:num><%=Total %></td>
  <td rowspan=3 class=xl35 style='border-bottom:.5pt solid black;border-top:
  none' x:num><%=att %></td>
  <td rowspan=3 class=xl35 style='border-bottom:.5pt solid black;border-top:
  none' x:num><%=abs %></td>
  <td rowspan=3 class=xl38 style='border-bottom:.5pt solid black;border-top:
  none' x:num><%=100-(1.0*abs/Total) %></td>
  <td rowspan=3 class=xl41 style='border-bottom:.5pt solid black;border-top:
  none' x:num>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl45 style='height:15.75pt;border-top:none;border-left:
  none'>Attendence</td>
  <% for(int j=0;j< dt_org.Rows.Count;j++) {

         if ((i + j) >= dt_org.Rows.Count || dt_org.Rows[i + j][0].ToString() != org_pk)
        break;
    
          
   %>
  <td class=<%=(dt_date.Rows[j][1].ToString()=="")?"xl28":"xl29" %> style='border-top:none;border-left:none' x:num><%=(dt_date.Rows[j][1].ToString() == "") ? dt_org.Rows[i + j][3].ToString() : "0"%></td>
 <%} %>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl46 style='height:15.75pt;border-top:none;border-left:
  none'>Total</td>
   <% for(int j=0;j< dt_org.Rows.Count;j++) {
          
          if (i >= dt_org.Rows.Count || dt_org.Rows[i][0].ToString() != org_pk)
          { break;
          }
          
              
          
    abs=0;
    att=0;
    Total=0;
    
          
   %>
  <td class=<%=(dt_date.Rows[j][1].ToString()=="")?"xl30":"xl31" %> style='border-top:none;border-left:none' x:num><%=(dt_date.Rows[j][1].ToString()=="")?dt_org.Rows[i][4].ToString():"0" %></td>
  
  <%  i++;


  } i--;
  
   %>
 </tr>
<%} %>

 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=221 style='width:166pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=110 style='width:83pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
