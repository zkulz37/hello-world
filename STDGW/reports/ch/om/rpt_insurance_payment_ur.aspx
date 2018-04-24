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
    string p_dept, p_group, p_status, p_type, p_pay_type, p_emp_id, p_work_mon, p_sal_period;


    p_dept = Request["l_dept"].ToString();
    p_group = Request["l_group"].ToString();
    p_status = Request["l_status"].ToString();
    p_type = Request["l_type"].ToString();
    p_pay_type = Request["l_pay_type"].ToString();
    p_emp_id = Request["l_emp_id"].ToString();
    p_work_mon = Request["l_work_mon"].ToString();
    p_sal_period = Request["l_sal_period"].ToString();
    string p_m_type = Request.QueryString["l_m_type"].ToString();
    
    if(p_type=="ALL")
        p_type="=nvl(s.net_amt,0)";

    string SQL
	= "SELECT S.FULL_NAME,S.EMP_ID,S.salary_si " +
    ",NVL(S.SOCIAL_AMT,0) AS SOCIAL_3 " +
        ",NVL(S.HEALTH_AMT,0) AS HEALTH_4  " +
         ",NVL(S.UNEMP_INS,0) AS unemp_wor_5  " +
         ",NVL(S.SOCIAL_AMT,0)+NVL(S.HEALTH_AMT,0)+NVL(S.UNEMP_INS,0) AS tt6  " +
        ",NVL(S.SOCIAL_COMPANY,0)+NVL(S.SOCIAL_COM_NET,0) AS SOCIAL_COM_7 " +
        ",NVL(S.UNEMP_COM_INS,0) AS unemp_COM_8 " +
        ",NVL(S.HEALTH_COMPANY,0)+NVL(S.HEALTH_COM_NET,0) AS HEALTH_COM_9  " +
        ",NVL(S.HEALTH_COMPANY,0)+NVL(S.HEALTH_COM_NET,0)+NVL(S.SOCIAL_COMPANY,0)+NVL(S.SOCIAL_COM_NET,0)+NVL(S.UNEMP_COM_INS,0) AS tt10  " +
        ",NVL(S.HEALTH_COMPANY,0)+NVL(S.HEALTH_COM_NET,0)+NVL(S.SOCIAL_COMPANY,0)+NVL(S.SOCIAL_COM_NET,0)+NVL(S.UNEMP_COM_INS,0) +  " +
        " NVL(S.SOCIAL_AMT,0)+NVL(S.HEALTH_AMT,0)+NVL(S.UNEMP_INS,0) AS gran_tt11  " +
        " ,to_char(to_date('" + p_work_mon + "','yyyymm'),'MM-YYYY') as wm_12 " +
        " from thr_month_salary_ur S, thr_employee a " +
        " where S.del_if=0 and a.del_if=0 and s.thr_emp_pk=a.pk and S.work_mon='" + p_work_mon + "' " +
        " and (a.tco_org_pk in ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_dept + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_dept + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_dept + "' = 'ALL') " +
        " and decode('" + p_group + "','ALL','ALL',a.thr_wg_pk)='" + p_group + "'" +
        " and S.emp_id like '%" + p_emp_id + "%' " +
        " and decode('" + p_status + "','ALL','ALL',S.status)='" + p_status + "'" +
        " and decode('" + p_pay_type + "','ALL','ALL',S.pay_type)='" + p_pay_type + "'" +
        " and decode('" + p_m_type + "','ALL','ALL',S.MONEY_KIND)='" + p_m_type + "'" +
        " and decode('" + p_sal_period + "','ALL','ALL',a.sal_period)='" + p_sal_period + "'" +
        " and nvl(S.HEALTH_AMT,0)+nvl(S.HEALTH_COM_NET,0)+NVL(S.SOCIAL_AMT,0)+NVL(S.SOCIAL_COM_NET,0) > 0 " + 
        " and nvl(s.net_amt,0) " + p_type  +
        " order by S.emp_id"; 
  
    DataTable data = ESysLib.TableReadOpen(SQL);
    if (data.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    
    string sql_rate1="SELECT NVL(A.NUM_4,0),NVL(A.NUM_5,0),TO_NUMBER(NVL(A.CHAR_2,0)),TO_NUMBER(NVL(A.CHAR_3,0)) " +
            " FROM VHR_HR_CODE A " +
            " WHERE A.ID='HR0043' AND A.CHAR_1=SUBSTR('" + p_work_mon + "',1,4)" ;
    DataTable data_1 = ESysLib.TableReadOpen(sql_rate1);
    string r_social="",r_health="",r_unemp="";
    string r_social_c="",r_health_c="",r_unemp_c="";
    if (data_1.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    else
    {
         r_social=data_1.Rows[0][1].ToString();
         r_health=data_1.Rows[0][0].ToString();
         r_social_c=data_1.Rows[0][3].ToString();
         r_health_c=data_1.Rows[0][2].ToString();
    }
    
    string sql_rate2="SELECT NVL(A.NUM_2,0),NVL(A.NUM_3,0) " +
            " FROM VHR_HR_CODE A " +
            " WHERE A.ID='HR0067' AND A.CHAR_1=SUBSTR('" + p_work_mon + "',1,4)" ;
    DataTable data_2 = ESysLib.TableReadOpen(sql_rate2);
    if (data_2.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    else
    {
         r_unemp=data_2.Rows[0][0].ToString();
         r_unemp_c=data_2.Rows[0][1].ToString();
        
    }
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_insurance_payment_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_insurance_payment_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_insurance_payment_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>htruong</o:Author>
  <o:LastAuthor>htruong</o:LastAuthor>
  <o:Created>2008-11-04T07:46:02Z</o:Created>
  <o:LastSaved>2008-11-04T08:09:38Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .25in .5in .25in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;}
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
	font-size:11.0pt;
	font-weight:400;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:400;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-size:16.0pt;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	border:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	border:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:16.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:16.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:16.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:22.0pt;
	text-align:center;}
.xl35
	{mso-style-parent:style0;
	font-size:16.0pt;
	text-align:center;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"\@";
	border:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:14.0pt;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;
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
      <x:Scale>57</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
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
  <x:WindowHeight>11220</x:WindowHeight>
  <x:WindowWidth>18075</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>
<table x:str border=0 cellpadding=0 cellspacing=0 width=1592 style='border-collapse:
 collapse;table-layout:fixed;width:1195pt'>
 <col width=64 style='width:48pt'>
 <col width=209 style='mso-width-source:userset;mso-width-alt:7643;width:157pt'>
 <col width=77 style='mso-width-source:userset;mso-width-alt:2816;width:58pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=98 style='mso-width-source:userset;mso-width-alt:3584;width:74pt'>
 <col width=95 style='mso-width-source:userset;mso-width-alt:3474;width:71pt'>
 <col width=108 style='mso-width-source:userset;mso-width-alt:3949;width:81pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:3657;width:75pt'>
 <col width=127 style='mso-width-source:userset;mso-width-alt:4644;width:95pt'>
 <col width=119 style='mso-width-source:userset;mso-width-alt:4352;width:89pt'>
 <col width=116 style='mso-width-source:userset;mso-width-alt:4242;width:87pt'>
 <col width=118 style='mso-width-source:userset;mso-width-alt:4315;width:89pt'>
 <col width=108 style='mso-width-source:userset;mso-width-alt:3949;width:81pt'>
 <col width=143 style='mso-width-source:userset;mso-width-alt:5229;width:107pt'>

 <tr height=17 style='height:12.75pt'>
  <td height=17 width=64 style='height:12.75pt;width:48pt'></td>
  <td width=182 style='width:137pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=98 style='width:74pt'></td>
 </tr>
 <tr height=36 style='height:27.0pt'>
  <td colspan=14 height=36 class=xl34 style='height:27.0pt'>INSURANCE PAYMENT</td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=14 height=27 class=xl35 style='height:20.25pt'>MONTH : <%=data.Rows[0][12].ToString() %></td>
 </tr>
 <tr height=34 style='height:25.5pt;mso-xlrowspan:2'>
  <td height=34 colspan=12 style='height:25.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=54 style='height:40.5pt'>
  <td height=54 class=xl24 style='height:40.5pt'>No</td>
  <td class=xl24 style='border-left:none'>Full Name</td>
  <td class=xl24 style='border-left:none'>Emp ID</td>
  <td class=xl24 style='border-left:none'>Salary</td>
  <td class=xl25 width=98 style='border-left:none;width:74pt'>Social <%=r_social %>%<br>
    (Worker)</td>
  <td class=xl25 width=95 style='border-left:none;width:71pt'>Health <%=r_health %>%<br>
    <span style='mso-spacerun:yes'> </span>(worker)</td>
  <td class=xl25 width=108 style='border-left:none;width:81pt'>UI <%=r_unemp %>%<br>
    (Worker)</td>
  <td class=xl25 width=100 style='border-left:none;width:75pt'>Total Ins <% =float.Parse(r_social) + float.Parse(r_health) +float.Parse(r_unemp) %>%<br>
    (Worker)</td>
  <td class="xl25" style='border-left: none; width: 89pt' width="119">
         Social <%=r_social_c %>%
         <br>
         (Company)</td>  
   <td class="xl25" style='border-left: none; width: 89pt' width="119">
         UI <%=r_unemp_c %>%
         <br>
         (Company)</td>  
  <td class=xl25 width=101 style='border-left:none;width:76pt'>Health <%=r_health_c %>%<br>
    (Company)</td>
  <td class=xl25 width=119 style='border-left:none;width:89pt'>Total Insurance <%=float.Parse(r_social_c) + float.Parse(r_health_c) +float.Parse(r_unemp_c) %>%<br>
    (Company)</td>
  
  <td class=xl25 width=116 style='border-left:none;width:87pt'>Total </td>
 </tr>
 <%
     double[] total = new double[14]{0,0,0,0,0,0,0,0,0,0,0,0,0,0}; 
     for (int i = 0; i < data.Rows.Count; i++)
     {
        total[2] += Double.Parse(data.Rows[i][2].ToString());    
        total[3] += Double.Parse(data.Rows[i][3].ToString());
        total[4] += Double.Parse(data.Rows[i][4].ToString());
        total[5] += Double.Parse(data.Rows[i][5].ToString());
        total[6] += Double.Parse(data.Rows[i][6].ToString());
        total[7] += Double.Parse(data.Rows[i][7].ToString());
        total[8] += Double.Parse(data.Rows[i][8].ToString());
        total[9] += Double.Parse(data.Rows[i][9].ToString());
        total[10] += Double.Parse(data.Rows[i][10].ToString());
        total[11] += Double.Parse(data.Rows[i][11].ToString());
        
        
        
  %>
 <tr class=xl27 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl28 align=right style='height:24.0pt;border-top:none' x:num><%=i+1 %></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=data.Rows[i][0].ToString() %></td>
  <td class=xl36 style='border-top:none;border-left:none' ><%=data.Rows[i][1].ToString() %></td>
  <td class=xl29 align=right style='border-top:none;border-left:none' x:num><%=data.Rows[i][2].ToString() %></td>
  <td class=xl29 align=right style='border-top:none;border-left:none' x:num><%=data.Rows[i][3].ToString() %></td>
  <td class=xl29 align=right style='border-top:none;border-left:none' x:num><%=data.Rows[i][4].ToString() %></td>
  <td class=xl29 align=right style='border-top:none;border-left:none' x:num><%=data.Rows[i][5].ToString() %></td>
  <td class=xl29 align=right style='border-top:none;border-left:none' x:num><%=data.Rows[i][6].ToString() %></td>
  <td class=xl29 align=right style='border-top:none;border-left:none' x:num><%=data.Rows[i][7].ToString() %></td>
  <td class=xl29 align=right style='border-top:none;border-left:none' x:num><%=data.Rows[i][8].ToString() %></td>
  <td class=xl29 align=right style='border-top:none;border-left:none' x:num><%=data.Rows[i][9].ToString() %></td>
  <td class=xl29 align=right style='border-top:none;border-left:none' x:num><%=data.Rows[i][10].ToString() %></td>
  <td class=xl29 align=right style='border-top:none;border-left:none' x:num><%=data.Rows[i][11].ToString() %></td>
  
 </tr>
 <%
    }
  %>
 <tr class=xl27 height=42 style='mso-height-source:userset;height:31.5pt'>
  <td colspan=3 height=42 class=xl31 style='border-right:.5pt solid black;
  height:31.5pt'>TOTAL</td>
  <td class=xl37 style='border-top:none;border-left:none' x:num ><%=total[2] %></td>
  <td class=xl37 style='border-top:none;border-left:none' x:num ><%=total[3] %></td>
  <td class=xl37 style='border-top:none;border-left:none' x:num><%=total[4] %></td>
  <td class=xl37 style='border-top:none;border-left:none' x:num><%=total[5] %></td>
  <td class=xl37 style='border-top:none;border-left:none' x:num><%=total[6] %></td>
  <td class=xl37 style='border-top:none;border-left:none' x:num><%=total[7] %></td>
  <td class=xl37 style='border-top:none;border-left:none' x:num><%=total[8] %></td>
  <td class=xl37 style='border-top:none;border-left:none' x:num><%=total[9] %></td>
  <td class=xl37 style='border-top:none;border-left:none' x:num><%=total[10] %></td>
  <td class=xl37 style='border-top:none;border-left:none' x:num><%=total[11] %></td>
  
  
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=182 style='width:137pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=98 style='width:74pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
