<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string p_user, p_tco_org_pk, p_org_type;
    string p_nation, p_search_temp, p_search_by;
    
    p_tco_org_pk = Request["l_tco_org_pk"].ToString();
    p_org_type = Request["l_org_type"].ToString();
    p_user = Request["l_user"].ToString();
    p_nation = Request["l_nation"].ToString();
    p_search_by = Request["l_search_by"].ToString();
    p_search_temp = Request["l_search_temp"].ToString();
    
    /**/
    string SQL
    = "select g.ORG_NM, e.EMP_ID, e.FULL_NAME " +
        "    ,(select v.CODE_NM from vhr_hr_code v where v.ID='HR0109' and v.CODE=e.BAND_CD) " +
        "    ,(select v.CODE_NM from vhr_hr_code v where v.ID='HR0110' and v.CODE=e.GRADE_CD) " +
        "    ,to_char(to_date(e.BAND_DT,'yyyymmdd'),'dd-mm-yyyy') " +
        //"    ,e.BAND_CD,e.GRADE_CD, e.pk " +
		"    ,to_char(to_date(e.POSITION_DT,'yyyymmdd'),'dd-mm-yyyy') "+
		"	 ,(select v.code_nm from vhr_hr_code v where v.code=e.JOB_TYPE and v.id='HR0010') "+
		"    ,(select v.code_nm from vhr_hr_code v where v.code=e.POS_TYPE and v.id='HR0008')  " +
        "    from thr_employee e, comm.tco_org g " +
        "    where e.DEL_IF=0 " +
        "    and g.DEL_IF=0 " +
        "    and e.TCO_ORG_PK=g.pk " +
        "    AND UPPER(DECODE('"+p_search_by+"','1',e.EMP_ID,'2', e.ID_NUM,e.FULL_NAME)) LIKE '%' || UPPER ('"+p_search_temp+"') " +
        "    AND DECODE ('" + p_org_type + "', 'ALL', '" + p_org_type + "', g.org_type )='" + p_org_type + "' " +
        "    AND DECODE ('" + p_nation + "', 'ALL', '" + p_nation + "', e.nation )='" + p_nation + "' " +
        "    AND (    e.TCO_ORG_PK IN ( " +
        "                                  SELECT     G.PK " +
        "                                        FROM COMM.TCO_ORG G " +
        "                                       WHERE G.DEL_IF = 0 " +
        "                                  START WITH G.PK = " +
        "                                                DECODE ('"+p_tco_org_pk+"', " +
        "                                                        'ALL', 0, " +
        "                                                        '"+p_tco_org_pk+"' " +
        "                                                       ) " +
        "                                  CONNECT BY PRIOR G.PK = G.P_PK) " +
        "                            OR '"+p_tco_org_pk+"' = 'ALL') " +
        "    order by 1, 3  ";

    //Response.Write(SQL);
    //Response.End();

    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
    int dt_row = dt_emp.Rows.Count;
    if (dt_row == 0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }/**/
  %>   
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_band_grade_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_band_grade_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_band_grade_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Hee</o:Author>
  <o:LastAuthor>Hee</o:LastAuthor>
  <o:LastPrinted>2009-10-23T07:36:59Z</o:LastPrinted>
  <o:Created>2009-10-23T06:52:47Z</o:Created>
  <o:LastSaved>2009-10-23T07:37:44Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.56in .24in .35in .36in;
	mso-header-margin:.5in;
	mso-footer-margin:.24in;
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
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double #00CCFF;
	border-left:2.0pt double #00CCFF;}
.xl26
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double #00CCFF;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:2.0pt double #00CCFF;
	border-bottom:2.0pt double #00CCFF;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double #00CCFF;
	border-right:.5pt dashed #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:2.0pt double #00CCFF;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double #00CCFF;
	border-right:.5pt dashed #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:.5pt dashed #00CCFF;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double #00CCFF;
	border-right:2.0pt double #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:.5pt dashed #00CCFF;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed #00CCFF;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt dashed #00CCFF;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed #00CCFF;
	border-right:2.0pt double #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:.5pt dashed #00CCFF;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed #00CCFF;
	border-right:.5pt dashed #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:2.0pt double #00CCFF;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double #00CCFF;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
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
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>4</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>0</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
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
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=988 style='border-collapse:
 collapse;table-layout:fixed;width:742pt'>
 <col class=xl24 width=46 style='mso-width-source:userset;mso-width-alt:1682;
 width:35pt'>
 <col class=xl24 width=185 style='mso-width-source:userset;mso-width-alt:6765;
 width:139pt'>
 <col class=xl24 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl24 width=167 style='mso-width-source:userset;mso-width-alt:6107;
 width:125pt'>
 <col class=xl24 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl24 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl24 width=95 style='mso-width-source:userset;mso-width-alt:3474;
 width:71pt'>
 <col class=xl24 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl24 width=104 style='mso-width-source:userset;mso-width-alt:3803;
 width:78pt'>
 <col class=xl24 width=108 style='mso-width-source:userset;mso-width-alt:3949;
 width:81pt'>
 <col class=xl24 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl24 width=92 style='mso-width-source:userset;mso-width-alt:3364;
 width:69pt'>
 <tr height=49 style='mso-height-source:userset;height:36.75pt'>
  <td colspan=7 height=49 class=xl36 width=688 style='height:36.75pt;
  width:517pt'>Employee Band-Grade report</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl37>Reporter:</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl35>Report<span style='mso-spacerun:yes'>  </span>Date:</td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:35pt'>
  <td height=38 class=xl28 style='height:35pt'>Seq.</td>
  <td class=xl29 style='border-left:none'>Organization</td>
  <td class=xl29 style='border-left:none'>Emp ID</td>
  <td class=xl29 style='border-left:none'>Full Name</td>
  <td class=xl29 style='border-left:none; '>Band</td>
  <td class=xl29 style='border-left:none'>Grade</td>
  <td class=xl29 style='border-left:none;white-space:normal;'>Band Date</td>
  <td class=xl29 style='border-left:none;white-space:normal;'>Job Class</td>
  <td class=xl29 style='border-left:none;white-space:normal;'>Job Title</td>
  <td class=xl30 style='border-left:none;white-space:normal;'>Job Date</td>
 </tr>
 <% for (int i = 0; i < dt_emp.Rows.Count; i++)
    { %>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl34 style='height:21.75pt;border-top:none' x:num><%=i+1 %></td>
  <td class=xl32 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][0].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:str><%=dt_emp.Rows[i][1].ToString() %></td>
  <td class=xl32 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][2].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][3].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][4].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][5].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][7].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][8].ToString() %></td>
  <td class=xl33 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][6].ToString() %></td>
 </tr>
 <%} %>
 <tr height=3 style='mso-height-source:userset;height:2.25pt'>
  <td height=3 class=xl25 style='height:2.25pt'>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=7 class=xl24 style='height:13.5pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  
 </tr>
 <![endif]>
</table>

</body>

</html>