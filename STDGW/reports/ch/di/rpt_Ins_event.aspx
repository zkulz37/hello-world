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
    
    string p_to = Request["p_to"].ToString();
    string p_from = Request["p_from"].ToString();
    string p_nation = Request["p_nation"].ToString();
    string p_org = Request["p_org"].ToString();
    string p_wg = Request["p_wg"].ToString();
    string p_search = Request["p_search"].ToString();
    string p_kind = Request["p_kind"].ToString();
    string p_tmp = Request["p_tmp"].ToString();
 
    
   string SQL
	= " select (select count(*) from thr_insurance_manage m where m.del_if=0 and m.THR_EMP_PK=e.pk  " + 
        "  and decode ('"+p_kind+"','ALL','"+p_kind+"',m.Loai_BH)='"+p_kind+"'  and m.thang_bc between '"+p_from+"' and '"+p_to+"'  group by m.THR_EMP_PK  )  " +
        " , e.EMP_ID,e.full_name,e.join_dt,to_char(to_date(g.thang_bc,'yyyymm'),'mm/yyyy') " +
        ",(select hr.code_nm from vhr_hr_code hr where id='HR0041' and hr.code=g.loai_bh),nvl(g.LUONG_MOI ,g.luong_cu ), case when nvl(g.LUONG_MOI ,g.luong_cu )>nvl(muc_tran,0) then nvl(muc_tran,0) else nvl(g.LUONG_MOI ,g.luong_cu ) end  " +
        "from thr_employee e,thr_insurance_manage g,tco_org m where g.THR_EMP_PK=e.pk and g.del_if=0 and e.del_if=0  " +
        "and m.del_if=0 and m.pk=e.tco_org_pk  " +
        "and g.thang_bc between '"+p_from+"' and '"+p_to+"' " +
        "and decode ('"+p_kind+"','ALL','"+p_kind+"',g.Loai_BH)='"+p_kind+"' " +
        "and decode ('"+p_nation+"','ALL','"+p_nation+"',e.nation)='"+p_nation+"' " +
        "and decode ('"+p_wg+"','ALL','"+p_wg+"',e.thr_wg_pk)='"+p_wg+"' " +
        "AND (e.TCO_ORG_pk IN ( " +
        "                              SELECT     n.pk " +
        "                                    FROM COMM.TCO_ORG n " +
        "                                   WHERE n.del_if = 0 " +
        "                              START WITH n.pk = " +
        "                                            DECODE ('"+p_org+"', " +
        "                                                    'ALL', 0, " +
        "                                                    '"+p_org+"' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR n.pk = n.p_pk) " +
        "                        OR '"+p_org+"' = 'ALL') " +
        "     AND (('"+p_search+"'='1' AND UPPER(e.EMP_ID) LIKE  '%' || UPPER('"+p_tmp+"')) " +
        "         OR ('"+p_search+"'='2' AND UPPER(e.ID_NUM) LIKE  '%' || UPPER('"+p_tmp+"')) " +
        "         OR ('"+p_search+"'='3' AND UPPER(e.FULL_NAME ) LIKE  '%' || UPPER('"+p_tmp+"')) " +
        "         OR ('"+p_search+"'='4' AND UPPER(g.SO_BHXH ) LIKE  '%' || UPPER('"+p_tmp+"')) " +
        "         OR ('"+p_search+"'='5' AND UPPER(g.SO_BHYT ) LIKE  '%' || UPPER('"+p_tmp+"')) " +
        "         ) " +
        "   order by e.tco_org_pk,e.emp_id,g.thang_bc " ;


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
<link rel=File-List href="Book1_files/filelist.xml">
<link rel=Edit-Time-Data href="Book1_files/editdata.mso">
<link rel=OLE-Object-Data href="Book1_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>nhut_k</o:Author>
  <o:LastAuthor>nhut_k</o:LastAuthor>
  <o:LastPrinted>2010-07-01T09:51:21Z</o:LastPrinted>
  <o:Created>2010-07-01T09:36:46Z</o:Created>
  <o:LastSaved>2010-07-01T09:52:20Z</o:LastSaved>
  <o:Company>AS</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .1in .5in .1in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
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
	mso-font-charset:0;
	text-align:left;}
.xl26
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-size:26.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl37
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
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
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:Scale>64</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>3</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
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
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$4:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1152 style='border-collapse:
 collapse;table-layout:fixed;width:865pt'>
 <col class=xl24 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl24 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 <col class=xl24 width=264 style='mso-width-source:userset;mso-width-alt:9654;
 width:198pt'>
 <col class=xl24 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col class=xl24 width=154 style='mso-width-source:userset;mso-width-alt:5632;
 width:116pt'>
 <col class=xl24 width=212 style='mso-width-source:userset;mso-width-alt:7753;
 width:159pt'>
 <col class=xl36 width=136 style='mso-width-source:userset;mso-width-alt:4973;
 width:102pt'>
 <col class=xl36 width=152 style='mso-width-source:userset;mso-width-alt:5558;
 width:114pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 width=51 style='height:15.75pt;width:38pt'></td>
  <td class=xl24 width=69 style='width:52pt'></td>
  <td class=xl24 width=264 style='width:198pt'></td>
  <td colspan=5 rowspan=2 class=xl29 width=768 style='width:577pt'>INSURANCE
  EVENTS</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl25 style='height:15.75pt'>Report Date:</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl27 style='height:15.75pt'>Report By:</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl26 style='height:18.75pt;border-top:none'>No</td>
  <td class=xl26 style='border-top:none;border-left:none'>ID</td>
  <td class=xl26 style='border-top:none;border-left:none'>Employee Name</td>
  <td class=xl26 style='border-top:none;border-left:none' x:str="Join Date ">Join
  Date<span style='mso-spacerun:yes'>&nbsp;</span></td>
  <td class=xl26 style='border-left:none'>Insurance Month</td>
  <td class=xl26 style='border-left:none'>Insurance Type</td>
  <td class=xl26 style='border-left:none'>Basic Salary</td>
  <td class=xl26 style='border-left:none'>Insurances Salary</td>
 </tr>
 
 <%  string value="";
     int count = 0;
     for (int i = 0; i < dt_Emp.Rows.Count; i++)
     {
         %>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <% if (i == 0 || (dt_Emp.Rows[i][1].ToString() != dt_Emp.Rows[i - 1][1].ToString()))
     {
          %>
  <td height=25 class=xl46 style='height:18.75pt;border-top:none' rowspan=<%=dt_Emp.Rows[i][0].ToString()%>><%=(++count) %></td>
  <td class=xl47 style='border-top:none;border-left:none'  rowspan=<%=dt_Emp.Rows[i][0].ToString()%>><%=dt_Emp.Rows[i][1].ToString()%></td>
  <td class=xl34 style='border-top:none;border-left:none'  rowspan=<%=dt_Emp.Rows[i][0].ToString()%>><%=dt_Emp.Rows[i][2].ToString()%></td>
  <td class=xl31 style='border-top:none;border-left:none'  rowspan=<%=dt_Emp.Rows[i][0].ToString()%>><%=dt_Emp.Rows[i][3].ToString()%></td>
  <%} %>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][4].ToString()%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][5].ToString()%></td>
  <td class=xl40 style='border-top:none;border-left:none' x:num ><%=dt_Emp.Rows[i][6].ToString()%></td>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][7].ToString()%></td>
 </tr>
 <%} %>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl48 style='height:18.75pt;border-top:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=51 style='width:38pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=264 style='width:198pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=154 style='width:116pt'></td>
  <td width=212 style='width:159pt'></td>
  <td width=136 style='width:102pt'></td>
  <td width=152 style='width:114pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
