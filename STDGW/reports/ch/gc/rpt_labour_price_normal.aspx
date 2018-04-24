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
   
    string p_dept = Request.QueryString["p_dept"].ToString();
    string p_group = Request.QueryString["p_group"].ToString();
    string p_emp_id = Request.QueryString["p_emp_id"].ToString();
    string p_from_dt = Request.QueryString["p_from_dt"].ToString();
    string p_to_dt = Request.QueryString["p_to_dt"].ToString();
    string p_item_code = Request.QueryString["p_item_code"].ToString();
    string p_item_nm = Request.QueryString["p_item_nm"].ToString();
    string p_sale_no = Request.QueryString["p_sale_no"].ToString();
    string p_task = Request.QueryString["p_task"].ToString();
    string p_item_pk = Request.QueryString["p_item_pk"].ToString();

    string SQL
    = "SELECT   b.group_nm, a.item_code, a.item_nm, a.sale_order_no, " +
        "               a.task_nm,to_char(to_date(a.prod_date,'yyyymmdd'),'dd/mm/yyyy') " +
        "               , d.emp_id, d.full_name, nvl(a.QUANTITY,0) , " +
        "               nvl(a.LABOUR_PRICE,0),nvl(a.EMP_AMOUNT,0) " +
        "          FROM VHR_DAILY_RESULT_NORMAL a, " +
        "               thr_group b, " +
        "               thr_employee d               " +
        "         WHERE  d.del_if = 0           " +
        "           AND a.thr_emp_pk = d.pk " +
        "           AND b.del_if = 0 " +
        "           AND a.thr_group_pk = b.pk " +
        "           and a.prod_date between '" + p_from_dt + "' and '" + p_to_dt + "'    " +
        "           AND DECODE ('" + p_group + "', 'ALL', '" + p_group + "', b.pk)='" + p_group + "' " +
        "           AND( '" + p_item_pk + "' = a.TCO_ITEM_PK or  '" + p_item_pk + "' is null) " +
        "           and a.ITEM_CODE like '%' || upper(trim('" + p_item_code + "')) || '%' " +
        "           and a.ITEM_NM like '%' || upper(trim('" + p_item_nm + "')) || '%' " +
        "           and d.EMP_ID like '%' || '" + p_emp_id + "' || '%' " +
        "           AND DECODE ('" + p_task + "', 'ALL', '" + p_task + "', a.tpr_task_pk )='" + p_task + "' " +
        "           and a.sale_order_no like '%' || '" + p_sale_no + "' || '%' " +
        "          AND (   b.TCO_DEPT_PK IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM comm.tco_dept g " +
        "                                   WHERE g.del_if = 0 " +
        "                                     AND NVL (g.child_yn, 'Y') = 'N' " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_dept + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_dept + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_dept + "' = 'ALL') " +
        "           ORDER BY b.group_nm,a.item_code, a.tpr_task_pk,a.prod_date, d.emp_id ";
    //Response.Write(SQL);
    //Response.End();
    
    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
    if (dt_emp.Rows.Count == 0)
    {
        Response.Write("There is no data to show");
        Response.End();            
    }

    string SQL_cnt
    = "SELECT    a.item_code , count(d.emp_id) " +
        "          FROM VHR_DAILY_RESULT_NORMAL a, " +
        "               thr_group b, " +
        "               thr_employee d               " +
        "         WHERE  d.del_if = 0           " +
        "           AND a.thr_emp_pk = d.pk " +
        "           AND b.del_if = 0 " +
        "           AND a.thr_group_pk = b.pk " +
        "           and a.prod_date between '" + p_from_dt + "' and '" + p_to_dt + "'    " +
        "           AND DECODE ('" + p_group + "', 'ALL', '" + p_group + "', b.pk)='" + p_group + "' " +
        "           AND( '" + p_item_pk + "' = a.TCO_ITEM_PK or  '" + p_item_pk + "' is null) " +
        "           and a.ITEM_CODE like '%' || upper(trim('" + p_item_code + "')) || '%' " +
        "           and a.ITEM_NM like '%' || upper(trim('" + p_item_nm + "')) || '%' " +
        "           and d.EMP_ID like '%' || '" + p_emp_id + "' || '%' " +
        "           AND DECODE ('" + p_task + "', 'ALL', '" + p_task + "', a.tpr_task_pk )='" + p_task + "' " +
        "           and a.sale_order_no like '%' || '" + p_sale_no + "' || '%' " +
        "          AND (   b.TCO_DEPT_PK IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM comm.tco_dept g " +
        "                                   WHERE g.del_if = 0 " +
        "                                     AND NVL (g.child_yn, 'Y') = 'N' " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_dept + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_dept + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_dept + "' = 'ALL') " +
        "    group by a.ITEM_CODE       ORDER BY a.item_code ";       
    //Response.Write(SQL_cnt);
    //Response.End();
    DataTable dt_cnt = ESysLib.TableReadOpen(SQL_cnt);
    if (dt_cnt.Rows.Count == 0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_labour_price_normal_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_labour_price_normal_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_labour_price_normal_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Hee Nguyen</o:Author>
  <o:LastAuthor>Hee Nguyen</o:LastAuthor>
  <o:LastPrinted>2008-12-22T06:29:20Z</o:LastPrinted>
  <o:Created>2008-12-22T02:43:55Z</o:Created>
  <o:LastSaved>2008-12-22T06:32:36Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.51in .24in 1.0in .24in;
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
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double #00CCFF;
	border-left:2.0pt double #00CCFF;}
.xl27
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double #00CCFF;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:2.0pt double #00CCFF;
	border-bottom:2.0pt double #00CCFF;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt dashed #00CCFF;
	border-right:.5pt dashed #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed #00CCFF;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt dashed #00CCFF;
	white-space:nowrap;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed #00CCFF;
	border-right:2.0pt double #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:.5pt dashed #00CCFF;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double #00CCFF;
	border-right:.5pt dashed #00CCFF;
	border-bottom:none;
	border-left:2.0pt double #00CCFF;
	background:#00CCFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double #00CCFF;
	border-right:.5pt dashed #00CCFF;
	border-bottom:none;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double #00CCFF;
	border-right:.5pt dashed #00CCFF;
	border-bottom:none;
	border-left:.5pt dashed #00CCFF;
	background:#00CCFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double #00CCFF;
	border-right:2.0pt double #00CCFF;
	border-bottom:none;
	border-left:.5pt dashed #00CCFF;
	background:#00CCFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double #00CCFF;
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
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>77</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>3</x:SplitHorizontal>
     <x:TopRowBottomPane>3</x:TopRowBottomPane>
     <x:SplitVertical>6</x:SplitVertical>
     <x:LeftColumnRightPane>6</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
       <x:ActiveCol>8</x:ActiveCol>
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

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1422 style='border-collapse:
 collapse;table-layout:fixed;width:1069pt'>
 <col class=xl24 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl24 width=174 style='mso-width-source:userset;mso-width-alt:6363;
 width:131pt'>
 <col class=xl24 width=92 style='mso-width-source:userset;mso-width-alt:3364;
 width:69pt'>
 <col class=xl24 width=186 style='mso-width-source:userset;mso-width-alt:6802;
 width:140pt'>
 <col class=xl24 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl24 width=107 style='mso-width-source:userset;mso-width-alt:3913;
 width:80pt'>
 <col class=xl24 width=91 style='mso-width-source:userset;mso-width-alt:3328;
 width:68pt'>
 <col class=xl24 width=84 style='mso-width-source:userset;mso-width-alt:3072;
 width:63pt'>
 <col class=xl24 width=210 style='mso-width-source:userset;mso-width-alt:7680;
 width:158pt'>
 <col class=xl24 width=102 style='mso-width-source:userset;mso-width-alt:3730;
 width:77pt'>
 <col class=xl24 width=122 style='mso-width-source:userset;mso-width-alt:4461;
 width:92pt'>
 <col class=xl24 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td colspan=12 height=37 class=xl39 width=1314 style='height:27.75pt;
  width:989pt'>Normal Labour Price Report</td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 colspan=6 class=xl24 style='height:20.25pt;mso-ignore:colspan'></td>
  <td colspan=1 class=xl40>From: <%=DateTime.Parse(p_from_dt.Insert(6,"-").Insert(4,"-")).ToString("dd-MM-yyyy") %></td>
  <td colspan=1 class=xl40> </td>
  <td colspan=1 class=xl40>To: <%=DateTime.Parse(p_to_dt.Insert(6,"-").Insert(4,"-")).ToString("dd-MM-yyyy") %></td>
  
  <td colspan=2 class=xl40>Printed Date: <%=DateTime.Now.ToString("dd-MM-yyyy") %> </td>
 </tr>
 <tr class=xl25 height=44 style='mso-height-source:userset;height:33.0pt'>
  <td height=44 class=xl35 width=44 style='height:33.0pt;width:33pt'>Seq</td>
  <td class=xl36 width=174 style='width:131pt'>Group</td>
  <td class=xl37 width=122 style='border-left:none;width:92pt'>Item Code</td>
  <td class=xl37 width=186 style='border-left:none;width:140pt'>Item Name</td>
  <td class=xl37 width=132 style='border-left:none;width:99pt'>Sale Order No</td>
  <td class=xl37 width=137 style='border-left:none;width:103pt'>Task Name</td>
  <td class=xl37 width=109 style='border-top:none;border-left:none;width:82pt'>Prod Date</td>
  <td class=xl37 style="border-top:none;border-left:none;width:113pt">Emp
  ID</td>
  <td class=xl37 width=210 style='border-top:none;border-left:none;width:158pt'>Full
  Name</td>
  <td class=xl38 style="border-top:none;border-left:none;width:88pt">Quantity</td>
  <td class=xl38 style="border-top:none;border-left:none;width:29px">Labour
  Price</td>
  <td class=xl38 style="border-top:none;border-left:none;width:1px">Emp Amount</td>
 </tr>
 <%
     int j = 0;
     double sub = 0, sub1 = 0, sub2 = 0;
     for (int i = 0; i < dt_emp.Rows.Count; i++)
     {
         sub += Double.Parse(dt_emp.Rows[i][8].ToString());
         sub1 += Double.Parse(dt_emp.Rows[i][9].ToString());
         sub2 += Double.Parse(dt_emp.Rows[i][10].ToString());
  %>
 <tr class=xl34 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl29 style='height:21.0pt' x:num><%=i + 1%></td>
  <%    if(i==0)
        { %>
  <td class=xl30  rowspan="<%=int.Parse(dt_cnt.Rows[j][1].ToString())+1 %>" ><%=dt_emp.Rows[i][0].ToString()%></td>  
  <td class=xl31 rowspan="<%=int.Parse(dt_cnt.Rows[j++][1].ToString())+1 %>" style='border-left:none'><%=dt_emp.Rows[i][1].ToString()%></td>  
  <%    }
        else if (dt_emp.Rows[i][1].ToString() != dt_emp.Rows[i - 1][1].ToString())
        {
   %>
    <td class=xl30  rowspan="<%=int.Parse(dt_cnt.Rows[j][1].ToString())+1 %>" ><%=dt_emp.Rows[i][0].ToString()%></td>  
  <td class=xl31 rowspan="<%=int.Parse(dt_cnt.Rows[j++][1].ToString())+1 %>" style='border-left:none'><%=dt_emp.Rows[i][1].ToString()%></td>
  
   <%
        } %>
  <td class=xl32  rowspan="1"  style="border-left:none; width: 113pt;"><%=dt_emp.Rows[i][2].ToString()%></td>
  <td class=xl32  rowspan="1"  style='border-left:none'><%=dt_emp.Rows[i][3].ToString()%></td>
  <td class=xl32 style="border-left:none; width: 88pt;"><%=dt_emp.Rows[i][4].ToString()%></td>
  <td class=xl33 style="border-right:.5pt dashed #00CCFF; width: 29px;" x:num><%=dt_emp.Rows[i][5].ToString()%></td>
  <td class=xl32 style="border-left:none; width: 1px;"><%=dt_emp.Rows[i][6].ToString()%></td>
  <td class=xl32 style='border-left:none'><%=dt_emp.Rows[i][7].ToString()%></td>
  <td class=xl32 style='border-left:none; text-align:right;'x:num><%=dt_emp.Rows[i][8].ToString()%></td>
  <td class=xl32 style='border-left:none; text-align:right;'x:num><%=dt_emp.Rows[i][9].ToString()%></td>
  <td class=xl33 style='border-left:none' x:num><%=dt_emp.Rows[i][10].ToString()%></td>
 </tr>
 
 <!------------------------------------------------------------------------------>
 
 
  
  <%    if (i < dt_emp.Rows.Count - 1)
        {
            if (dt_emp.Rows[i][1].ToString() != dt_emp.Rows[i + 1][1].ToString())
            {          %>
  <tr class=xl34 height=28 style='mso-height-source:userset;height:21.0pt'>          
  <td height=28 class=xl29 style='height:21.0pt' x:num></td>              
  <td class=xl32 colspan=6 style='border-left:none'><b>SUM OF: <%=dt_emp.Rows[i][1].ToString() %></b> </td>
  <td class=xl32  style='border-left:none; text-align:right' x:num><b><%=sub%></b></td>
  <td class=xl32  style='border-left:none; text-align:right' x:num><b><%=sub1%></b></td>  
  <td class=xl33 style='border-left:none' x:num><b><%=sub2%></b></td> 
  </tr>
  <%        sub = 0;
            sub1 = 0;
            sub2 = 0;    
            }
        }
        else
        { %>
<tr class=xl34 height=28 style='mso-height-source:userset;height:21.0pt'>                      
  <td height=28 class=xl29 style='height:21.0pt' x:num></td>              
  <td class=xl32 colspan=6 style='border-left:none'><b>SUM OF: <%=dt_emp.Rows[i][1].ToString() %></b></td>
  <td class=xl32  style='border-left:none; text-align:right' x:num><b><%=sub%></b></td>
  <td class=xl32  style='border-left:none; text-align:right' x:num><b><%=sub1%></b></td>  
  <td class=xl33 style='border-left:none' x:num><b><%=sub2%></b></td>  
   </tr>  
  <%      }
          
  %>
 

 <!----------------------------------------------------------------------------------->
 
 <%    
    }//for %>
 <tr height=4 style='mso-height-source:userset;height:3.0pt'>
  <td height=4 class=xl26 style='height:3.0pt'>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27 style="width: 113pt">&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl28 style="width: 88pt">&nbsp;</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=10 class=xl24 style='height:13.5pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>q1
  <td width=44 style='width:33pt'></td>
  <td width=174 style='width:131pt'></td>
  <td width=122 style='width:92pt'></td>
  <td width=186 style='width:140pt'></td>
  <td width=132 style='width:99pt'></td>
  <td width=137 style='width:103pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=210 style='width:158pt'></td>
  <td width=102 style='width:77pt'></td>
 </tr>
 <![endif]></table>

</body>

</html>

