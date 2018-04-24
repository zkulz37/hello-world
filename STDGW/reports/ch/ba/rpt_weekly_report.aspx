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
    string p_user,p_tco_org_pk,p_wg,p_opt,p_wt_ot,p_search,p_input;
    string p_from,p_to,p_month,p_week,p_nation,p_emp_kind,p_tco_company;
     
  
    p_tco_org_pk   = Request["p_tco_org_pk"].ToString();
    p_wg      = Request["p_wg"].ToString();
    p_from          = Request["p_from"].ToString();
    p_to            = Request["p_to"].ToString();
    p_opt           = Request["p_opt"].ToString();
    p_wt_ot         = Request["p_wt_ot"].ToString();
    p_search        = Request["p_search"].ToString();
    p_input         = Request["p_input"].ToString();
    p_user          = Request["p_user"].ToString();
    p_month         = Request["p_month"].ToString();
    p_week         = Request["p_week"].ToString();
    
   
   //header of table
     string SQL
	= "SELECT CAR_DATE,TO_CHAR(TO_DATE(CAR_DATE,'YYYYMMDD'),'dd-MON') AS DT  " + 
        "            FROM tco_abcalendar " +
        "            WHERE CAR_DATE BETWEEN '" + p_from + "' and '" + p_to + "' " +
        "            ORDER BY CAR_DATE " ;
    DataTable dt_name = ESysLib.TableReadOpen(SQL);
    int irow_name;
    irow_name = dt_name.Rows.Count;
    if (irow_name == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
   // Response.Write(irow_name);
   // Response.End();
   SQL
	= "select max(g.partner_fname)  " + 
        ",a.emp_id a0 " +
        ",a.full_name a1 " +
        ",e.org_nm a2 " +
        ",d.org_nm a3 " +
        ",(select v.code_nm from vhr_hr_code v where v.id='HR0008' and v.code=a.pos_type) a4 " ;
        for ( int i=0;i<irow_name;i++)
        {
            SQL+=",max(decode(b.work_dt,'" + dt_name.Rows[i][0].ToString() + "',round(decode(nvl(decode(b.wt_allowance,8,7,wt_allowance),0),0,b.work_time,decode(b.wt_allowance,8,7,wt_allowance)) + nvl(ht.ot_time,0)-nvl(b.minus_wt,0),2),0)) a5 " +
                 ",max(decode(b.work_dt,'" + dt_name.Rows[i][0].ToString() + "',round(nvl(ot.ot_time,0) + nvl(b.ot_plus,0) - nvl(b.minus_ot,0),2),0)) a5 " ;
        }
        SQL+=",sum(round(decode(nvl(decode(b.wt_allowance,8,7,wt_allowance),0),0,b.work_time,decode(b.wt_allowance,8,7,wt_allowance)) + nvl(ht.ot_time,0)-nvl(b.minus_wt,0),2)) a5 " +
        ",sum(round(nvl(ot.ot_time,0) + nvl(b.ot_plus,0) - nvl(b.minus_ot,0),2)) a5 " +
        ",sum(round(decode(nvl(decode(b.wt_allowance,8,7,wt_allowance),0),0,b.work_time,decode(b.wt_allowance,8,7,wt_allowance)) + nvl(ht.ot_time,0)-nvl(b.minus_wt,0),2)) " +
        " + sum(round(nvl(ot.ot_time,0) + nvl(b.ot_plus,0) - nvl(b.minus_ot,0),2)) a5 " +
        ",(select  f.code_fnm as status from thr_regulation v,vhr_hr_code f where f.id='HR0029' and v.del_if=0 and f.code=v.kind and (v.start_dt <= '" + p_to + "' and nvl(v.MISCARRIAGE_DT,v.end_dt) >= '" + p_from + "')  and kind in ('01','02')  and v.thr_emp_pk=a.pk  and rownum=1) " +
        ",(select 'ALL:Start: ' || to_char(to_date(start_dt,'yyyymmdd'),'dd/mm/yyyy') || ' End: ' || to_char(to_date(nvl(MISCARRIAGE_DT,end_dt),'yyyymmdd'),'dd/mm/yyyy') as note from thr_regulation v where v.del_if=0  and kind in ('01','02') and (v.start_dt <= '" + p_to + "' and nvl(v.MISCARRIAGE_DT,v.end_dt) >= '" + p_from + "') and v.thr_emp_pk=a.pk  and rownum=1) " +
        "from thr_employee a,thr_time_machine b,tco_org d,tco_org e,tco_company g " +
        ",thr_extra_time ht,thr_extra_time ot " +
        "where a.del_if=0 and b.del_if=0 and ht.del_if(+)=0 and ot.del_if(+)=0 and d.del_if=0 and e.del_if=0 and g.del_if=0 and a.tco_company_pk=g.pk " +
        "and b.thr_emp_pk=a.pk and a.tco_org_pk=d.pk and d.p_pk=e.pk " +
        "and ot.thr_emp_pk(+)=b.thr_emp_pk " +
        "and ht.thr_emp_pk(+)=b.thr_emp_pk " +
        "and b.work_dt=ht.work_dt(+) " +
        "and b.work_dt=ot.work_dt(+) " +
        "and b.work_dt between '" + p_from + "' and '" + p_to + "' " +
        "and ht.work_dt(+) between '" + p_from + "' and '" + p_to + "' " +
        "and ot.work_dt(+) between '" + p_from + "' and '" + p_to + "' " +
        "and ht.ot_type(+)='HT' " +
        "and ot.ot_type(+)='OT' " +
        "     AND DECODE ('" + p_wg + "', 'ALL', '" + p_wg + "', a.thr_wg_pk) = '" + p_wg + "' " +
        "            AND (A.TCO_ORG_PK IN (SELECT  g.pk " +
        "                                            FROM tco_org g " +
        "                                           WHERE g.del_if = 0 " +
        "                                      START WITH g.pk = " +
        "                                                    DECODE ('" + p_tco_org_pk + "' , " +
        "                                                            'ALL', 0, " +
        "                                                            '" + p_tco_org_pk + "' " +
        "                                                           ) " +
        "                                      CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                                OR '" + p_tco_org_pk + "'  = 'ALL') " +
          "     AND (   DECODE ('" + p_search + "', " +
          "                     '1', UPPER (a.emp_id), " +
          "                     '2', a.id_num, " +
          "                     '3', UPPER (a.full_name) " +
          "                    ) LIKE '%' || UPPER ('" + p_input + "') " +
          "          OR '" + p_input + "' IS NULL " +
          "         ) " +
        "group by a.pk,a.emp_id,a.full_name,d.org_nm,e.org_nm,a.pos_type order by a.emp_id" ;

        
        
//Response.Write(SQL);
//Response.End();
    DataTable dt = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt.Rows.Count;
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
<link rel=File-List href="rpt_weekly_report_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_weekly_report_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_weekly_report_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2012-07-23T04:17:07Z</o:LastPrinted>
  <o:Created>2006-04-20T03:25:12Z</o:Created>
  <o:LastSaved>2012-07-23T06:36:09Z</o:LastSaved>
  <o:Company>Computer</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.4in .16in .33in .28in;
	mso-header-margin:.26in;
	mso-footer-margin:.16in;
	mso-page-orientation:landscape;}
.font0
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font5
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
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
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:.5pt solid black;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:none}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"0\.0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"00\.00";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	mso-number-format:"00\.00";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	mso-number-format:"00\.00";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:14.0pt;
	text-align:center;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
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
      <x:Scale>54</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:DoNotDisplayZeros/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>4</x:TopRowBottomPane>
     <x:SplitVertical>2</x:SplitVertical>
     <x:LeftColumnRightPane>2</x:LeftColumnRightPane>
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
  <x:WindowHeight>9225</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$3:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1889 style='border-collapse:
 collapse;table-layout:fixed;width:1420pt'>
<col width=57 style='mso-width-source:userset;mso-width-alt:2084;width:43pt'>
 <col width=88 style='mso-width-source:userset;mso-width-alt:3218;width:66pt'>
 <col width=148 style='mso-width-source:userset;mso-width-alt:5412;width:111pt'>
 <col width=163 span=2 style='mso-width-source:userset;mso-width-alt:5961;
 width:122pt'>
 <col width=102 style='mso-width-source:userset;mso-width-alt:3730;width:77pt'>
 <col width=61 style='mso-width-source:userset;mso-width-alt:2230;width:46pt'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=61 style='mso-width-source:userset;mso-width-alt:2230;width:46pt'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=61 style='mso-width-source:userset;mso-width-alt:2230;width:46pt'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=61 style='mso-width-source:userset;mso-width-alt:2230;width:46pt'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=61 style='mso-width-source:userset;mso-width-alt:2230;width:46pt'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=61 style='mso-width-source:userset;mso-width-alt:2230;width:46pt'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=61 style='mso-width-source:userset;mso-width-alt:2230;width:46pt'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=64 style='width:48pt'>
 <col width=49 style='mso-width-source:userset;mso-width-alt:1792;width:37pt'>
 <col width=64 style='width:48pt'>
 <col width=145 style='mso-width-source:userset;mso-width-alt:5302;width:109pt'>
 <col width=170 style='mso-width-source:userset;mso-width-alt:6217;width:128pt'>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=4 height=31 width=425 style='height:23.25pt;width:319pt'><% = dt.Rows[0][0].ToString()%></td>
  <td width=163 style='width:122pt'></td>
  <td colspan=7 class=xl40 width=405 style='width:305pt'>GENERAL WORKING TIME
  <%=p_month %> WEEK <%=p_week %></td>
  <td width=61 style='width:46pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=170 style='width:128pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=6 height=24 class=xl41 style='border-right:.5pt solid black;
  height:18.0pt'>&nbsp;</td>
  <td colspan=2 class=xl37 style='border-right:.5pt solid black;border-left:
  none'>MON</td>
  <td colspan=2 class=xl37 style='border-right:.5pt solid black;border-left:
  none'>TUE</td>
  <td colspan=2 class=xl37 style='border-right:.5pt solid black;border-left:
  none'>WED</td>
  <td colspan=2 class=xl37 style='border-right:.5pt solid black;border-left:
  none'>THU</td>
  <td colspan=2 class=xl37 style='border-right:.5pt solid black;border-left:
  none'>FRI</td>
  <td colspan=2 class=xl37 style='border-right:.5pt solid black;border-left:
  none'>SAT</td>
  <td colspan=2 class=xl37 style='border-right:.5pt solid black;border-left:
  none'>SUN</td>
  <td colspan=3 class=xl37 style='border-right:.5pt solid black;border-left:
  none'>WEEK <%=p_week %></td>
  <td class=xl25 style='border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl26 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl27 style='height:20.25pt'>No.</td>
  <td class=xl28>CODE</td>
  <td class=xl28>FULL NAME</td>
  <td class=xl28>DEPT</td>
  <td class=xl28>SECTION</td>
  <td class=xl28>POSTION</td>
  <% for(int i=0;i<irow_name;i++)
  { %>
  <td class=xl28><%= dt_name.Rows[i][1].ToString() %></td>
  <td class=xl28>OT</td>
  <%} %>
  <td class=xl28>TTRWH</td>
  <td class=xl28>TT</td>
  <td class=xl28>TTNWH</td>
  <td class=xl28>STATUS</td>
  <td class=xl28>REMARK</td>
 </tr>
 <%  for (int j = 0; j < irow; j++) 
 {%>
 <tr class=xl33 height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl36 style='height:27.75pt' x:num><%=j+1 %></td>
  <td class=xl35><% = dt.Rows[j][1].ToString()%></td>
  <td class=xl34><% = dt.Rows[j][2].ToString()%></td>
  <td class=xl34><% = dt.Rows[j][3].ToString()%></td>
  <td class=xl34><% = dt.Rows[j][4].ToString()%></td>
  <td class=xl34><% = dt.Rows[j][5].ToString()%></td>
   <% for(int i=0;i<irow_name*2;i++)
  { %>
  <td class=xl29 align=right x:num><% = dt.Rows[j][i+6].ToString()%></td>
  
  <%} %>
  
  <td class=xl30 align=right x:num><% = dt.Rows[j][6+irow_name*2].ToString()%></td>
  <td class=xl30 align=right x:num><% = dt.Rows[j][7+irow_name*2].ToString()%></td>
  <td class=xl30 align=right x:num><% = dt.Rows[j][8+irow_name*2].ToString()%></td>
  <td class=xl30 width=145 style='width:109pt'><% = dt.Rows[j][9+irow_name*2].ToString()%></td>
  <td class=xl32 width=170 style='width:128pt'><% = dt.Rows[j][10+irow_name*2].ToString()%></td>
 
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=26 style='width:20pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=148 style='width:111pt'></td>
  <td width=163 style='width:122pt'></td>
  <td width=163 style='width:122pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=170 style='width:128pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
