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
    string p_tco_org_pk, p_wg, p_from, p_to, p_lsttmp, p_txttmp;
    p_tco_org_pk = Request.QueryString["p_tco_org_pk"].ToString();
    p_wg = Request.QueryString["p_wg"].ToString();
    p_from = Request.QueryString["p_from"].ToString();
    p_to = Request.QueryString["p_to"].ToString();
    p_lsttmp = Request.QueryString["p_lsttmp"].ToString();
    p_txttmp = Request.QueryString["p_txttmp"].ToString();

    string SQL
    = "SELECT   NULL, b.grp_nm grp_nm_1, a.emp_id emp_id_2, a.full_nm full_nm_3,  " + 
        "         a.emp_pk emp_pk_4  " +
        "    FROM (SELECT   e.emp_id AS emp_id, e.full_name AS full_nm,  " +
        "                   c.thr_emp_pk AS emp_pk  " +
        "              FROM thr_wg_his_change c, thr_employee e  " +
        "             WHERE c.del_if = 0  " +
        "               AND e.del_if = 0  " +
        "               AND c.thr_emp_pk = e.pk  " +
        "               AND c.thr_old_wg_pk <> 0  " +
        "               AND c.work_dt BETWEEN '" + p_from + "' AND '" + p_to + "'  " +
        "               AND (   DECODE (" + p_lsttmp + ",  " +
        "                               '1', UPPER (e.emp_id),  " +
        "                               '2', UPPER (e.full_name),  " +
        "                               '3', e.id_num  " +
        "                              ) LIKE '%' || UPPER ('" + p_txttmp + "')  " +
        "                    OR '" + p_txttmp + "' IS NULL  " +
        "                   )  " +
        "               AND DECODE ('" + p_wg + "', 'ALL', 'ALL', e.thr_wg_pk) = '" + p_wg + "'  " +
        "               AND (   e.tco_org_pk IN (  " +
        "                             SELECT     g.pk  " +
        "                                   FROM tco_org g  " +
        "                                  WHERE g.del_if = 0  " +        
        "                             START WITH g.pk = DECODE ('" + p_tco_org_pk + "',  " +
        "                                                       'ALL', 0,  " +
        "                                                       '" + p_tco_org_pk + "'  " +
        "                                                      )  " +
        "                             CONNECT BY PRIOR g.pk = g.p_pk)  " +
        "                    OR '" + p_tco_org_pk + "' = 'ALL'  " +
        "                   )  " +
        "          GROUP BY c.thr_emp_pk, e.emp_id, e.full_name) a,  " +
        "         (SELECT   g.workgroup_nm AS grp_nm, d.pk AS emp_pk  " +
        "              FROM thr_work_group g, thr_employee d  " +
        "             WHERE g.del_if = 0 AND d.del_if = 0 AND g.pk = d.thr_wg_pk  " +
        "          GROUP BY g.workgroup_nm, d.pk) b  " +
        "   WHERE a.emp_pk = b.emp_pk  " +
        "ORDER BY b.grp_nm, a.emp_id " ;


    
    //Response.Write(SQL);
    //Response.End();        
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
<link rel=File-List href="rpt_change_group_list_detail_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_change_group_list_detail_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_change_group_list_detail_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Hee</o:Author>
  <o:LastAuthor>baoky</o:LastAuthor>
  <o:LastPrinted>2008-12-15T06:47:09Z</o:LastPrinted>
  <o:Created>2008-11-05T03:41:52Z</o:Created>
  <o:LastSaved>2008-12-15T06:48:25Z</o:LastSaved>
  <o:Company>Hee Nguyen</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .24in .25in .25in;
	mso-header-margin:.23in;
	mso-footer-margin:.22in;}
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl29
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl32
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
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
      <x:Scale>77</x:Scale>
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
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>14</x:ActiveRow>
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
  <x:WindowHeight>8445</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=919 style='border-collapse:
 collapse;table-layout:fixed;width:689pt'>
 <col class=xl24 width=41 style='mso-width-source:userset;mso-width-alt:1499;
 width:31pt'>
 <col class=xl24 width=159 style='mso-width-source:userset;mso-width-alt:5814;
 width:119pt'>
 <col class=xl24 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl24 width=194 style='mso-width-source:userset;mso-width-alt:7094;
 width:146pt'>
 <col class=xl24 width=104 style='mso-width-source:userset;mso-width-alt:3803;
 width:78pt'>
 <col class=xl24 width=159 span=2 style='mso-width-source:userset;mso-width-alt:
 5814;width:119pt'>
 <tr class=xl25 height=31 style='height:23.25pt'>
  <td colspan=7 height=31 class=xl31 width=919 style='height:23.25pt;
  width:689pt'>EMPLOYEE CHANGE LIST DETAIL REPORT</td>
 </tr>
 <tr class=xl25 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 colspan=3 class=xl25 style='height:24.0pt;mso-ignore:colspan'></td>
  <td class=xl26>From: <%=p_from.Substring(6,2).ToString() + "/" + p_from.Substring(4,2).ToString() + "/" + p_from.Substring(0,4).ToString() %></td>
  <td class=xl27>To: <%=p_to.Substring(6, 2).ToString() + "/" + p_to.Substring(4, 2).ToString() + "/" + p_to.Substring(0, 4).ToString()%></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl28 width=41 style='height:28.5pt;width:31pt'>No</td>
  <td class=xl29 width=159 style='width:119pt'>Group</td>
  <td class=xl29 width=103 style='width:77pt'>Emp ID</td>
  <td class=xl29 width=194 style='width:146pt'>Full Name</td>
  <td class=xl29 width=104 style='width:78pt'>Change Date</td>
  <td class=xl29 width=159 style='width:119pt'>Old Group</td>
  <td class=xl29 width=159 style='width:119pt'>New Group</td>
 </tr>
 <%
     for (int i = 0; i < dt_emp.Rows.Count; i++)
     {
         string SQL_DETAIL
            = "SELECT   TO_CHAR (TO_DATE (c.work_dt, 'yyyymmdd'), 'dd/mm/yyyy'), " +
                "         (SELECT g1.workgroup_nm " +
                "            FROM thr_work_group g1 " +
                "           WHERE g1.del_if = 0 AND g1.pk = c.thr_old_wg_pk), g.workgroup_nm " +
                "    FROM thr_wg_his_change c, thr_work_group g " +
                "   WHERE c.del_if = 0 " +
                "     AND g.del_if = 0 " +
                "     AND c.thr_wg_pk = g.pk " +
                "     AND c.thr_old_wg_pk <> 0 " +
                "     AND c.work_dt BETWEEN '" + p_from + "' AND '" + p_to + "'  " +
                "     AND c.thr_emp_pk = " + Double.Parse(dt_emp.Rows[i][4].ToString()) +
                "ORDER BY c.work_dt ";
         
         DataTable dt_detail = ESysLib.TableReadOpen(SQL_DETAIL);

  %>
 <tr class=xl25 height=28 style='mso-height-source:userset;height:21.0pt;
  userset'>
  <td rowspan=<%=dt_detail.Rows.Count %> height=56 class=xl34 width=41 style='border-bottom:.5pt solid black;
  border-top:none;width:31pt' x:num><%=i+1 %></td>
  <td rowspan=<%=dt_detail.Rows.Count %> class=xl35 width=159 style='border-bottom:.5pt solid black;
  border-top:none;width:119pt'><%=dt_emp.Rows[i][1].ToString() %></td>
  <td rowspan=<%=dt_detail.Rows.Count %> class=xl35 width=103 style='border-bottom:.5pt solid black;
  border-top:none;width:77pt'><%=dt_emp.Rows[i][2].ToString() %></td>
  <td rowspan=<%=dt_detail.Rows.Count %> class=xl35 width=194 style='border-bottom:.5pt solid black;
  border-top:none;width:146pt'><%=dt_emp.Rows[i][3].ToString() %></td>
  <td class=xl38 width=104 style='border-top:.5pt solid black;border-left:.5pt solid black;width:78pt'><%=dt_detail.Rows[0][0].ToString() %></td>
  <td class=xl39 width=159 style='border-top:.5pt solid black;border-left:none;width:119pt'><%=dt_detail.Rows[0][1].ToString() %></td>
  <td class=xl40 width=159 style='border-top:.5pt solid black;border-left:none;width:119pt'><%=dt_detail.Rows[0][2].ToString() %></td>
 </tr>
    <%
        for (int j = 1; j < dt_detail.Rows.Count; j++)
        { 
    %>
 <tr class=xl25 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl32 width=104 style='border-top:none;border-left:.5pt solid black;height:21.0pt;width:78pt'><%=dt_detail.Rows[j][0].ToString() %></td>
  <td class=xl30 width=159 style='border-top:none;width:119pt'><%=dt_detail.Rows[j][1].ToString() %></td>
  <td class=xl37 width=159 style='border-top:none;border-left:none;width:119pt'><%=dt_detail.Rows[j][2].ToString() %></td>
 </tr>
    <%
        }
          %>
 <%
     }
 %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='border-top:.5pt solid black;display:none'>
  <td width=41 style='width:31pt'></td>
  <td width=159 style='width:119pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=194 style='width:146pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=159 style='width:119pt'></td>
  <td width=159 style='width:119pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
