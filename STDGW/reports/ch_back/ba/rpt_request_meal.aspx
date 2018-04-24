<%@ Page Language="C#" %>
<%@ Import Namespace = "System.Data" %>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_dt = Request["p_from"].ToString();

    string SQL
    = "select nvl(meal.dept,'Division'),sum(meal.vn_hc),sum(meal.vn_1),sum(meal.vn_2),sum(meal.vn_3),sum(meal.nn)  " +
        "from(  " +
        "select (SELECT   MAX(T.org_NM)   " +
        " FROM tco_org t        " +
        "   WHERE t.del_if = 0        " +
        "   AND T.org_TYPE IN('06')   " +
        "  START WITH t.pk=a.tco_org_pk   " +
        "  CONNECT BY PRIOR t.p_pk=t.pk) AS dept  " +
        "  ,(case when nvl(a.nation,'01')='01' and B.thr_ws_pk=63 then 1 else 0 end) vn_hc " +
        "  ,(case when nvl(a.nation,'01')='01' and B.thr_ws_pk=206 then 1 else 0 end) vn_1 " +
        "  ,(case when nvl(a.nation,'01')='01' and B.thr_ws_pk=207 then 1 else 0 end) vn_2 " +
        "  ,(case when nvl(a.nation,'01')='01' and B.thr_ws_pk=103 then 1 else 0 end) vn_3 " +
        "  ,decode(nvl(a.nation,'01'),'01',0,1) as nn  " +
        "from thr_employee a,thr_wg_sch_detail b  " +
        "where a.del_if=0 and b.del_if=0 and a.pk=b.thr_emp_pk   " +
        "and A.JOIN_DT<='" + p_dt + "' and b.work_dt='" + p_dt + "' " +
        "and (A.LEFT_DT is null or A.LEFT_DT>'" + p_dt + "')  " +
        "and a.pk not in(select b.thr_emp_pk from thr_absence b where b.del_if=0  " +
        "                        and b.absence_dt='" + p_dt + "'and b.thr_emp_pk=a.pk  " +
        "                        and b.absence_type not in('13','17'))) meal  " +
        "group by meal.dept  " +
        "order by meal.dept ";

		
		//Response.Write(SQL);
        //Response.End();
	
    DataTable dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }
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
  <o:LastPrinted>2009-05-27T07:50:17Z</o:LastPrinted>
  <o:Created>2009-05-27T07:45:07Z</o:Created>
  <o:LastSaved>2009-05-27T07:53:26Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.49in .33in .47in .37in;
	mso-header-margin:.5in;
	mso-footer-margin:.32in;}
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
	font-size:18.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double navy;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:2.0pt double navy;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double navy;
	border-left:2.0pt double navy;}
.xl30
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double navy;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:2.0pt double navy;
	border-bottom:2.0pt double navy;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double navy;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid navy;
	border-left:2.0pt double navy;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid navy;
	border-left:.5pt dashed windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid navy;
	border-left:.5pt dashed windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double navy;
	border-bottom:.5pt solid navy;
	border-left:none;
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
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>18</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
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
  <x:WindowHeight>12525</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=709 style='border-collapse:
 collapse;table-layout:fixed;width:533pt'>
 <col class=xl25 width=174 style='mso-width-source:userset;mso-width-alt:2000;
 width:131pt'>
 <col class=xl25 width=174 style='mso-width-source:userset;mso-width-alt:10363;
 width:131pt'>
 <col class=xl25 width=174 style='mso-width-source:userset;mso-width-alt:5363;
 width:131pt'>
 <col class=xl25 width=89 style='mso-width-source:userset;mso-width-alt:5254;
 width:67pt'>
 <col class=xl25 width=89 style='mso-width-source:userset;mso-width-alt:5254;
 width:67pt'>
 <col class=xl25 width=89 style='mso-width-source:userset;mso-width-alt:5254;
 width:67pt'>
 <col class=xl25 width=89 style='mso-width-source:userset;mso-width-alt:5254;
 width:67pt'>
 <col class=xl25 width=97 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 width=174 style='height:12.75pt;width:131pt'></td>
  <td class=xl25 width=89 style='width:67pt'></td>
  <td class=xl25 width=89 style='width:67pt'></td>
  <td class=xl25 width=89 style='width:67pt'></td>
 </tr>
 <tr height=44 style='mso-height-source:userset;height:33.0pt'>
  <td colspan=7 height=44 class=xl24 style='height:33.0pt'>DAILY REQUEST MEAL FORM</td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:33.0pt'>
  <td height=33 colspan=2 class=xl25 style='height:33.0pt;mso-ignore:colspan'>Work Date:<%=p_dt.Substring(6,2)+"/"+p_dt.Substring(4,2)+"/"+p_dt.Substring(0,4) %></td>
  <td height=33 colspan=5 class=xl25 style='height:33.0pt;mso-ignore:colspan'>&nbsp;</td>
 </tr>
 
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 class=xl26 width=174 style='height:24.75pt;width:131pt'>No</td>  
  <td height=33 class=xl26 width=174 style='height:24.75pt;width:131pt'>Department</td>
  <td height=33 class=xl26 width=174 style='height:24.75pt;width:131pt'>Q'ty VN (DayShift)</td>
  <td height=33 class=xl26 width=174 style='height:24.75pt;width:131pt'>Q'ty VN (Shift 1)</td>
  <td height=33 class=xl26 width=174 style='height:24.75pt;width:131pt'>Q'ty VN (Shift 2)</td>
  <td height=33 class=xl26 width=174 style='height:24.75pt;width:131pt'>Q'ty VN (OFF)</td>
  <td class=xl27 width=89 style='border-left:none;width:67pt'>Q'ty Korean meal</td>
 </tr>
 <%
     double tt1, tt2,tt3,tt4,tt5;
     tt1=tt2=tt3=tt4=tt5=0;   
     for (int i = 0; i < dt.Rows.Count; i++)
     {
         tt1+=double.Parse(dt.Rows[i][1].ToString());   
         tt2+=double.Parse(dt.Rows[i][2].ToString());
         tt3 += double.Parse(dt.Rows[i][3].ToString());
         tt4 += double.Parse(dt.Rows[i][4].ToString());
         tt5 += double.Parse(dt.Rows[i][5].ToString());
  %>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
   <td height=29 class=xl33 style='height:21.75pt;border-top:none' x:num><%=i+1%></td> 
   <td height=29 class=xl33 style='height:21.75pt;border-top:none'><%=dt.Rows[i][0].ToString() %></td>
  <td height=29 class=xl33 style='height:21.75pt;border-top:none' x:num><%=dt.Rows[i][1].ToString() %></td>
  <td height=29 class=xl33 style='height:21.75pt;border-top:none' x:num><%=dt.Rows[i][2].ToString() %></td>
  <td height=29 class=xl33 style='height:21.75pt;border-top:none' x:num><%=dt.Rows[i][3].ToString() %></td>
  <td height=29 class=xl33 style='height:21.75pt;border-top:none' x:num><%=dt.Rows[i][4].ToString() %></td>
  <td class=xl34 style='border-top:none' x:num><%=dt.Rows[i][5].ToString() %></td>
 </tr>
 <% } %>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=2 height=29 class=xl33 style='height:21.75pt;border-top:none' x:num>Total</td> 
  <td height=29 class=xl33 style='height:21.75pt;border-top:none' x:num><%=tt1 %></td>
  <td height=29 class=xl33 style='height:21.75pt;border-top:none' x:num><%=tt2 %></td>
  <td height=29 class=xl33 style='height:21.75pt;border-top:none' x:num><%=tt3 %></td>
  <td height=29 class=xl33 style='height:21.75pt;border-top:none' x:num><%=tt4 %></td>
  <td class=xl34 style='border-top:none' x:num><%=tt5 %></td>
 </tr>
 <tr height=2 style='mso-height-source:userset;height:1.5pt'>
  <td height=2 class=xl29 style='height:1.5pt'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=7 class=xl25 style='height:13.5pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=174 style='width:131pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=191 style='width:143pt'></td>
  <td width=77 style='width:58pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
