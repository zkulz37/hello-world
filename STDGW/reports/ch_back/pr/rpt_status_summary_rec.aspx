<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    
    string p_dept, p_master, p_detail, p_dtFrom, p_dtTo; 
     
  
    p_dept       = Request["l_dept"].ToString();
    p_master      = Request["l_master"].ToString();
    p_detail      = Request["l_detail"].ToString();
    p_dtFrom       = Request["l_dtFrom"].ToString();
    p_dtTo         = Request["l_dtTo"].ToString();



    string SQL
    = "select 0 " +
       "        ,(select k.org_nm from comm.tco_org k where k.del_if=0 and k.pk = (select o.p_pk from comm.tco_org o where o.del_if=0 and o.PK = c.p_pk)) as factory  " +
        "        ,(select o.org_nm from comm.tco_org o where o.del_if=0 and o.PK = c.p_pk) as Dept  " +
        "        ,c.org_nm as group_nm_3 " +
        "        ,nvl(a.req_num,0) req_num_4 " +
        "        ,nvl(emp.emp_num,0) emp_num_5 " +
        "        ,abs(nvl(emp.emp_num,0) - nvl(a.req_num,0)) thieu_6 " +
        "        ,nvl(app1.app_num,0) app_num_7  " +
        "        ,nvl(app2.itv_num,0) itv_num_8  " +
        "        ,nvl(app3.pass_num,0) pass_num_9  " +
        "        ,nvl(emp.emp_num,0)*100/nvl(a.req_num,0) rate_10   " +
        "     from thr_rec_request_detail a, thr_rec_request b, comm.tco_org c " +
        "            ,(select e.THR_REC_REQUEST_DT_PK " +
        "              ,count(e.THR_REC_REQUEST_DT_PK) app_num             " +
        "                from thr_rec_emp e " +
        "                where e.del_if=0 " +
        "                    and e.cv_recieve_dt between '" + p_dtFrom + "' and '" + p_dtTo + "' " +
        "                group by e.THR_REC_REQUEST_DT_PK " +
        "            ) app1 " +
        "           ,(select e.THR_REC_REQUEST_DT_PK " +
        "              ,sum(case when e.result_t1 is not null or e.result_t2 is not null or e.result_t3 is not null " +
        "                then 1 else 0 end) itv_num             " +
        "                from thr_rec_emp e " +
        "                where e.del_if=0 " +
        "                    and ((e.interview_dt1 between '" + p_dtFrom + "' and '" + p_dtTo + "' ) " +
        "                        or(e.interview_dt2 between '" + p_dtFrom + "' and '" + p_dtTo + "' ) " +
        "                        or(e.interview_dt3 between '" + p_dtFrom + "' and '" + p_dtTo + "' )) " +
        "                group by e.THR_REC_REQUEST_DT_PK " +
        "            ) app2 " +
        "           ,(select e.THR_REC_REQUEST_DT_PK " +
        "              ,sum(decode(nvl(e.PASS_YN,'N'),'Y',1,0)) pass_num            " +
        "                from thr_rec_emp e " +
        "                where e.del_if=0 " +
        "                    and e.pass_dt between '" + p_dtFrom + "' and '" + p_dtTo + "' " +
        "                group by e.THR_REC_REQUEST_DT_PK " +
        "            ) app3 " +
        "          ,(select r.pk , count(r.pk) emp_num  " +
        "                from thr_employee e, thr_rec_emp a,thr_rec_request_detail r " +
        "                where e.del_if=0 and r.del_if=0 and a.del_if=0 " +
        "                and a.pk = e.THR_REC_EMP_PK " +
        "                and a.THR_REC_REQUEST_DT_PK = r.pk " +
        "                and r.app_status ='03' " +
        "                and e.join_dt between '" + p_dtFrom + "' and '" + p_dtTo + "' " +
        "                group by r.pk) emp " +
        "        where a.del_if=0 and c.del_if=0 and b.del_if=0 " +
        "            and a.thr_rec_request_pk = b.pk " +
        "            and b.tco_org_pk = c.pk " +
        "            and a.pk = app1.thr_rec_request_dt_pk(+) " +
        "            and a.pk = app2.thr_rec_request_dt_pk(+) " +
        "            and a.pk = app3.thr_rec_request_dt_pk(+) " +
        "            and a.pk = emp.pk(+) " +
        "            and a.app_status ='03'  " +
        "            and (('" + p_dtFrom + "' between b.from_dt  and b.to_dt) or ('" + p_dtTo + "' between b.from_dt and b.to_dt)) " +
        "           and (b.tco_org_pk in ( " +
        "                              SELECT     g.pk " +
        "                                    FROM comm.tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_dept + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_dept + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_dept + "' = 'ALL') " +
        " and decode('" + p_master + "','ALL','ALL',a.thr_rec_request_pk)='" + p_master + "'" +
        " and decode('" + p_detail + "','ALL','ALL',a.pk)='" + p_detail + "'" +
        " order by 4 ";





   //Response.Write(SQL);
   //Response.End();

    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
   
    if (irow_emp == 0)
    {
        Response.Write("There is no data of salary");
        Response.End();
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_status_summary_rec_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_status_summary_rec_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_status_summary_rec_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>nga</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-07-25T07:30:38Z</o:LastPrinted>
  <o:Created>2011-06-20T02:00:45Z</o:Created>
  <o:LastSaved>2011-07-25T07:53:01Z</o:LastSaved>
  <o:Company>vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.42in .25in .23in .25in;
	mso-header-margin:.3in;
	mso-footer-margin:.23in;
	mso-page-orientation:landscape;}
.font6
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font8
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font11
	{color:black;
	font-size:16.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
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
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style59
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"Normal 2";}
.style60
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"Normal 3";}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
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
.xl71
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl72
	{mso-style-parent:style60;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmm\\-yy";
	text-align:center;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style60;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style59;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style60;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl76
	{mso-style-parent:style60;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style60;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl78
	{mso-style-parent:style60;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl79
	{mso-style-parent:style60;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl80
	{mso-style-parent:style60;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl81
	{mso-style-parent:style60;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl82
	{mso-style-parent:style60;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00\;\[Red\]\#\,\#\#0\.00";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style59;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style60;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style60;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00\;\[Red\]\#\,\#\#0\.00";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style60;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00\;\[Red\]\#\,\#\#0\.00";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl87
	{mso-style-parent:style60;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style60;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl89
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl90
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl91
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl92
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:none;
	white-space:normal;}
.xl93
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Summary Report</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
       <x:RangeSelection>$A$2:$J$2</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7170</x:WindowHeight>
  <x:WindowWidth>10395</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="5121"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl71>

<table x:str border=0 cellpadding=0 cellspacing=0 width=993 style='border-collapse:
 collapse;table-layout:fixed;width:749pt'>
 <col class=xl71 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl71 width=170 style='mso-width-source:userset;mso-width-alt:6217;
 width:128pt'>
 <col class=xl71 width=86 span=7 style='mso-width-source:userset;mso-width-alt:
 3145;width:65pt'>
 <col class=xl71 width=176 style='mso-width-source:userset;mso-width-alt:6436;
 width:132pt'>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl71 width=45 style='height:19.5pt;width:34pt'></td>
  <td class=xl71 width=170 style='width:128pt'></td>
  <td class=xl71 width=86 style='width:65pt'></td>
  <td class=xl71 width=86 style='width:65pt'></td>
  <td class=xl71 width=86 style='width:65pt'></td>
  <td class=xl71 width=86 style='width:65pt'></td>
  <td class=xl71 width=86 style='width:65pt'></td>
  <td class=xl71 width=86 style='width:65pt'></td>
  <td class=xl71 width=86 style='width:65pt'></td>
  <td class=xl71 width=176 style='width:132pt'></td>
 </tr>
 <tr height=78 style='mso-height-source:userset;height:58.5pt'>
  <td colspan=10 height=78 class=xl92 width=993 style='height:58.5pt;
  width:749pt'>RECRUITMENT STATUS SUMMARY<br>
    <font class="font11">FROM <%= p_dtFrom.Substring(6,2).ToString() %>/<%= p_dtFrom.Substring(4,2).ToString() %>/<%= p_dtFrom.Substring(0,4).ToString() %> TO <%= p_dtTo.Substring(6,2).ToString() %>/<%= p_dtTo.Substring(4,2).ToString() %>/<%= p_dtTo.Substring(0,4).ToString() %></font></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl89 width=45 style='height:15.0pt;width:34pt'>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
  <td class=xl91>&nbsp;</td>
  <td class=xl91>&nbsp;</td>
  <td class=xl91>&nbsp;</td>
  <td class=xl91>&nbsp;</td>
  <td class=xl91>&nbsp;</td>
  <td class=xl91>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
 </tr>
 <tr height=59 style='height:44.25pt'>
  <td height=59 class=xl77 width=45 style='height:44.25pt;border-top:none;
  width:34pt'>No<br>
    <font class="font8">STT</font></td>
  <td class=xl77 width=170 style='border-top:none;border-left:none;width:128pt'>Department<br>
    <font class="font8">B&#7897; Ph&#7853;n</font></td>
  <td class=xl78 width=86 style='border-top:none;border-left:none;width:65pt'>Plan<br>
    <font class="font8">Ch&#7881; tiêu &#273;&#7873; xu&#7845;t</font></td>
  <td class=xl78 width=86 style='border-top:none;width:65pt'>Recruited<br>
    <font class="font8">Tuy&#7875;n d&#7909;ng<br>
    </font></td>
  <td class=xl78 width=86 style='border-top:none;width:65pt'>Short of<br>
    <font class="font8">Thi&#7871;u</font></td>
  <td class=xl78 width=86 style='border-top:none;width:65pt'>CV Applied<br>
    <font class="font8">H&#7891; s&#417; d&#7921; tuy&#7875;n</font></td>
  <td class=xl78 width=86 style='border-top:none;width:65pt'>Interviewee<br>
    <font class="font8">H&#7891; s&#417; ph&#7887;ng v&#7845;n</font></td>
  <td class=xl78 width=86 style='border-top:none;width:65pt'>Pass<br>
    <font class="font8">Nhân viên &#273;&#7841;t</font></td>
  <td class=xl79 width=86 style='border-top:none;width:65pt'>Rate <br>
    <font class="font8">T&#7927; l&#7879;</font><font class="font6"><br>
    (%)</font></td>
  <td class=xl77 width=176 style='border-top:none;border-left:none;width:132pt'>Remark<br>
    <font class="font8">Ghi chú</font></td>
 </tr>
 <%
     string dept_old,  dept_new;
     bool flag_total = false;
     int count = 1;
     double[] total = new double[6];
     double[] gtotal = new double[6];
     for (int i = 0; i < 6; i++)
     {
         total[i] = 0;
         gtotal[i] = 0;
     }
     for (int i = 0; i < irow_emp; i++)
     {
         dept_old = dt_Emp.Rows[i][3].ToString();

         for (int k = 4; k < 10; k++)
         {
             total[k - 4] += double.Parse(dt_Emp.Rows[i][k].ToString());
             gtotal[k - 4] += double.Parse(dt_Emp.Rows[i][k].ToString());
         }
      %>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl73 style='height:25.5pt;border-top:none' x:num><%= count %></td>
  <td class=xl74 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][3].ToString() %></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%= dt_Emp.Rows[i][4].ToString() %></td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><%= dt_Emp.Rows[i][5].ToString() %></td>
  <td class=xl84 style='border-top:none' x:num><%= dt_Emp.Rows[i][6].ToString() %></td>
  <td class=xl84 style='border-top:none' x:num><%= dt_Emp.Rows[i][7].ToString() %></td>
  <td class=xl84 style='border-top:none' x:num><%= dt_Emp.Rows[i][8].ToString() %></td>
  <td class=xl84 style='border-top:none' x:num><%= dt_Emp.Rows[i][9].ToString() %></td>
  <td class=xl82 x:num><%= dt_Emp.Rows[i][10].ToString() %></td>
  <td class=xl75 width=176 style='border-top:none;width:132pt'>&nbsp;</td>
 </tr>
  <%
     
    if (i < irow_emp - 1)
    {
        count = count + 1;
        dept_new = dt_Emp.Rows[i + 1][3].ToString();
        if (dept_new != dept_old)
        {
            flag_total = true;
        }
    }
    else
    {
        flag_total = true;
    }
    if (flag_total)
    {
  %>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td colspan=2 height=34 class=xl76 style='height:25.5pt'>Total of <%= dt_Emp.Rows[i][3].ToString() %></td>
  <td class=xl87 style='border-top:none;border-left:none' x:num><%= total[0] %></td>
  <td class=xl87 style='border-top:none;border-left:none' x:num><%= total[1] %></td>
  <td class=xl87 style='border-top:none;border-left:none' x:num><%= total[2] %></td>
  <td class=xl87 style='border-top:none;border-left:none' x:num><%= total[3] %></td>
  <td class=xl87 style='border-top:none;border-left:none' x:num><%= total[4] %></td>
  <td class=xl87 style='border-top:none;border-left:none' x:num><%= total[5] %></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%= total[1]*100/total[0] %></td>
  <td class=xl75 width=176 style='border-top:none;border-left:none;width:132pt'>&nbsp;</td>
 </tr>
  <% 
     flag_total = false;
     for (int k = 0; k < 6; k++)
         total[k] = 0;
    }
   } %>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td colspan=2 height=45 class=xl80 style='height:33.75pt'>Total :</td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><%= gtotal[0] %></td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><%= gtotal[1] %></td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><%= gtotal[2] %></td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><%= gtotal[3] %></td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><%= gtotal[4] %></td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><%= gtotal[5] %></td>
  <td class=xl86 style='border-top:none;border-left:none' x:num><%= gtotal[1]*100/gtotal[0] %></td>
  <td class=xl81 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl71 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl71 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl71 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl71 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl71 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=7 class=xl71 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl72></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=45 style='width:34pt'></td>
  <td width=170 style='width:128pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=176 style='width:132pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
