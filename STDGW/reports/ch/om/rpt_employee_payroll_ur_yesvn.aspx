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
    
    string p_dept, p_group, p_status, p_type, p_pay_type, p_emp_id, p_work_mon, p_m_type, p_times, p_emp_type, p_from_leftdate, p_to_leftdate; 
     
  
    p_dept       = Request["l_dept"].ToString();
    p_group      = Request["l_group"].ToString();
    p_status      = Request["l_status"].ToString();
    p_type       = Request["l_type"].ToString();
    p_pay_type   = Request["l_pay_type"].ToString();
    p_emp_id     = Request["l_emp_id"].ToString();
    p_work_mon   = Request["l_work_mon"].ToString();
    p_times = Request["l_Times_r"].ToString();
    p_emp_type = Request["l_Emp_Type"].ToString();
    p_m_type = Request.QueryString["l_m_type"].ToString();
    p_from_leftdate = Request["l_from_leftdate"].ToString();
    p_to_leftdate = Request["l_to_leftdate"].ToString();
    DateTime p_month_dt=new DateTime(int.Parse(p_work_mon.Substring(0,4).ToString()),int.Parse(p_work_mon.Substring(4,2).ToString()),1) ;
    if (p_type=="ALL")
        p_type="=nvl(a.net_amt,0)";
    
   string SQL
	= "select a.DEPT_NM,  " +                                  //1
        "A.EMP_ID,  " +                                             //2
        "A.FULL_NAME,  " +                                          //3
        "to_char(to_date(A.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy'),  " +  //4
        "A.POS_NM,  " +                
        "ROUND(NVL(A.ins_salary,0),10),  " +                               //8
        "ROUND(NVL(A.SALARY_LEVEL2,0),10),  " +                               //8
        "ROUND(NVL(A.ALLOW_AMT1,0),10),  " +                                  //9
        "ROUND(NVL(A.WT_L2,0)/8 + NVL(a.HOL_DAY_L2,0),10), " +                                        //18
        "ROUND(NVL(A.ABS_TMP_L2,0)/8,10), " +        //22
        "ROUND(NVL(A.ABS_OTHER_PAY_L2,0)/8,10), " +        //22
        "ROUND(nvl(A.WT_L2_AMT,0) + nvl(A.TOTAL_ABS_PAY_L2_AMT,0)+ NVL(a.HOL_DAY_L2_AMT,0),10),  " +  //23
        "ROUND(NVL(A.OT_L2,0),10), " +                                        //25
        "ROUND(NVL(A.ST_L2,0) + nvl(A.HT_L2,0)+ nvl(A.OHT_L2,0)+ nvl(A.OST_L2,0),10), " +                       //27
        "ROUND(NVL(A.NT_30_L2,0),10), " +                                     //29
        "ROUND(NVL(A.NT_45_L2,0),10), " +                                     //31
        "ROUND(NVL(A.NT_60_L2,0),10), " +                                     //33
        "ROUND(NVL(A.NT_90_L2,0),10), " +                                     //35
        "ROUND(NVL(A.TOTAL_OT_L1_AMT,0) + nvl(A.TOTAL_OT_L2_AMT,0),10), " +        //36
        "ROUND(NVL(A.OT_TAX_L1_AMT,0)+NVL(A.OT_TAX_L2_AMT,0),10)," + //63
        "ROUND(NVL(A.ALLOW_K1_AMT,0),10),  " +                                //37
        "ROUND(NVL(A.ALLOW_K2_AMT,0),10),  " +                                //38
        "ROUND(NVL(A.ALLOW_K3_AMT,0),10),  " +                                //39
        "ROUND(NVL(A.ALLOW_K4_AMT,0),10),  " +                                //40
        "ROUND(NVL(A.RETURN_AMT,0),10), " +                //45
        "ROUND(nvl(A.INC_AMT,0)+nvl(A.BONUS_YEARLY_AMT,0),10), " +                //65
        "ROUND(NVL(A.ALE_STOP,0),10),  " +                                    //46
        "ROUND(NVL(A.ALE_STOP_AMT,0),10),  " +                                //47
        "ROUND(NVL(A.SEVERANCE_MONTH,0),10),  " +                             //49
        "ROUND(NVL(A.SEVERANCE_AMT,0),10),  " +                               //50
        "ROUND(NVL(A.GROSS_AMT,0),10),  " +                            //51
        "ROUND(NVL(A.BREAK_CONTRACT_AMT,0),10), " +                           //52
        "ROUND(NVL(A.DEDUCT_NON_ABS,0),10), " +                           //52
        "ROUND(NVL(A.ADVANCE_AMT,0),10),  " +                                 //53
        "ROUND(NVL(A.DEDUCT_PIT,0),10)," + //61
        "ROUND(NVL(A.INCOME_BEFORE_TAX,NVL(A.INCOME_AMT,0)),10),  " +                           //54
        "ROUND(NVL(A.INCOME_TAX,0),10),  " +                           //55
        "ROUND(NVL(A.SOCIAL_AMT,0) + NVL(A.UNEMP_INS,0)+nvl(A.HEALTH_AMT,0)  ,10),  " +           //57
        "DECODE('" + p_m_type + "','ALL',round(NVL(A.NET_AMT,0),0),'01',round(NVL(A.NET_AMT,0),0),round(NVL(A.NET_AMT,0),10))  " + //60                             
        "from thr_month_salary a, comm.tco_org b, thr_work_group c " +         
        "where a.del_if=0 and a.work_mon='" + p_work_mon + "' " +
        " and b.del_if=0 and c.del_if=0 and a.tco_dept_pk=b.pk and a.thr_group_pk=c.pk " +
        " and (a.tco_dept_pk in ( " +
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
        " and decode('" + p_group + "','ALL','ALL',a.thr_group_pk)='" + p_group + "'" +
        " and a.emp_id like '%" + p_emp_id + "%' " +
        " and ('" + p_from_leftdate + "' is null or '" + p_to_leftdate + "' is null or a.left_dt between '" + p_from_leftdate + "' and '" + p_to_leftdate + "')" + 
        " and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "'" +
        " and decode('" + p_pay_type + "','ALL','ALL',a.pay_type)='" + p_pay_type + "'" +
        " and decode('" + p_emp_type + "','ALL','ALL',a.Employee_Type)='" + p_emp_type + "'" +
        " and decode('" + p_m_type + "','ALL','ALL',a.MONEY_KIND)='" + p_m_type + "'" +
        " and decode('" + p_times + "','ALL','ALL',a.times)='" + p_times + "'" +
        " and nvl(a.net_amt,0) " + p_type  +
        " order by A.DEPT_NM,a.emp_id";



   //Response.Write(SQL);
   //Response.End();

    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp=dt_Emp.Columns.Count;
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
<link rel=File-List href="rpt_employee_payroll_yesvn_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_employee_payroll_yesvn_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_employee_payroll_yesvn_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2011-09-22T07:09:51Z</o:LastPrinted>
  <o:Created>2008-09-06T07:03:32Z</o:Created>
  <o:LastSaved>2011-09-22T07:37:04Z</o:LastSaved>
  <o:Company>genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.28in .19in .41in .07in;
	mso-header-margin:.3in;
	mso-footer-margin:.19in;
	mso-page-orientation:landscape;}
.font11
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
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
	padding:0px;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:30.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl33
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl35
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
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl51
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl52
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl55
	{mso-style-parent:style0;
	font-size:30.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;}
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
      <x:Scale>32</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>568</x:TopRowBottomPane>
     <x:SplitVertical>5</x:SplitVertical>
     <x:LeftColumnRightPane>5</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>5</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>562</x:ActiveRow>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
     <%
        int irow=4;
        int tmp=1;
        string cur_grp,next_grp;
        for (int k=0;k<irow_emp;k++)
        {
            irow+=1;
            cur_grp=dt_Emp.Rows[k][0].ToString() ;
            if (k<irow_emp-1)
            {
                
                next_grp=dt_Emp.Rows[k+1][0].ToString() ;
                if (cur_grp!=next_grp)
                {   
                    
                
                %>
                    <x:RowBreak>
                        <x:Row><%=irow %></x:Row>
                    </x:RowBreak>
                <%
                }
                
            }    
                
        }  
      %>
     </x:RowBreaks>
    </x:PageBreaks>
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
  <x:WindowHeight>8835</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>-30</x:WindowTopX>
  <x:WindowTopY>-225</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026" u1:ext="edit"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl26>

<table x:str border=0 cellpadding=0 cellspacing=0 width=3591 style='border-collapse:
 collapse;table-layout:fixed;width:2697pt'>
<!--37--><!--47--><!--51 -->
 <col class=xl26 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl26 width=92 style='mso-width-source:userset;mso-width-alt:3364;
 width:69pt'>
 <col class=xl26 width=58 style='mso-width-source:userset;mso-width-alt:2121;
 width:44pt'>
 <col class=xl26 width=137 style='mso-width-source:userset;mso-width-alt:5010;
 width:103pt'>
 <col class=xl26 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl26 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl26 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl26 width=84 style='mso-width-source:userset;mso-width-alt:3072;
 width:63pt'>
 <col class=xl26 width=84 style='mso-width-source:userset;mso-width-alt:3072;
 width:63pt'>
 <col class=xl26 width=92 style='mso-width-source:userset;mso-width-alt:3364;
 width:69pt'>
 <col class=xl26 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl26 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl26 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl26 width=64 style='mso-width-source:userset;mso-width-alt:2340;
 width:48pt'>
 <col class=xl26 width=56 span=5 style='mso-width-source:userset;mso-width-alt:
 2048;width:42pt'>
 <col class=xl26 width=74 span=2 style='mso-width-source:userset;mso-width-alt:
 2706;width:56pt'>
 <col class=xl26 width=84 style='mso-width-source:userset;mso-width-alt:3072;
 width:63pt'>
 <col class=xl26 width=83 span=3 style='mso-width-source:userset;mso-width-alt:
 3035;width:62pt'>
 <col class=xl26 width=99 span=2 style='mso-width-source:userset;mso-width-alt:
 3620;width:74pt'>
 <col class=xl26 width=57 style='mso-width-source:userset;mso-width-alt:2084;
 width:43pt'>
 <col class=xl26 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl26 width=49 style='mso-width-source:userset;mso-width-alt:1792;
 width:37pt'>
 <col class=xl26 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl26 width=97 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <col class=xl26 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl26 width=109 style='mso-width-source:userset;mso-width-alt:3986;
 width:82pt'>
 <col class=xl26 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl26 width=85 span=3 style='mso-width-source:userset;mso-width-alt:
 3108;width:64pt'>
 <col class=xl26 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl26 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl26 width=64 span=8 style='width:48pt'>
 <tr height=37 style='height:27.75pt'>
  <td height=37 width=44 style='height:27.75pt;width:33pt' align=left
  valign=top></td>
  <td class=xl26 width=92 style='width:69pt'></td>
  <td class=xl52 colspan=2 align=left width=195 style='mso-ignore:colspan;
  width:147pt'>CÔNG TY TNHH VÂNG VIỆT NAM
</td>
  <td class=xl26 width=73 style='width:55pt'></td>
  <td class=xl26 width=77 style='width:58pt'></td>
  <td class=xl26 width=75 style='width:56pt'></td>
  <td class=xl26 width=84 style='width:63pt'></td>
  <td class=xl26 width=92 style='width:69pt'></td>
  <td class=xl26 width=79 style='width:59pt'></td>
  <td class=xl26 width=94 style='width:71pt'></td>
  <td class=xl26 width=93 style='width:70pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=56 style='width:42pt'></td>
  <td class=xl50 width=56 style='width:42pt'>EMPLOYEE'S PAYROLL IN <%=p_month_dt.ToString("MMMM").ToUpper().ToString() %><span style='mso-spacerun:yes'>  </span><%=p_month_dt.ToString("yyyy") %></td>
  <td class=xl26 width=56 style='width:42pt'></td>
  <td class=xl26 width=56 style='width:42pt'></td>
  <td class=xl26 width=56 style='width:42pt'></td>
  <td class=xl26 width=74 style='width:56pt'></td>
  <td class=xl26 width=74 style='width:56pt'></td>
  <td class=xl26 width=84 style='width:63pt'></td>
  <td class=xl26 width=83 style='width:62pt'></td>
  <td class=xl26 width=83 style='width:62pt'></td>
  <td class=xl26 width=83 style='width:62pt'></td>
  <td class=xl26 width=99 style='width:74pt'></td>
  <td class=xl26 width=99 style='width:74pt'></td>
  <td class=xl26 width=57 style='width:43pt'></td>
  <td class=xl26 width=79 style='width:59pt'></td>
  <td class=xl26 width=49 style='width:37pt'></td>
  <td class=xl26 width=78 style='width:59pt'></td>
  <td class=xl26 width=97 style='width:73pt'></td>
  <td class=xl26 width=73 style='width:55pt'></td>
  <td class=xl26 width=109 style='width:82pt'></td>
  <td class=xl26 width=72 style='width:54pt'></td>
  <td class=xl26 width=85 style='width:64pt'></td>
  <td class=xl26 width=85 style='width:64pt'></td>
  <td class=xl26 width=85 style='width:64pt'></td>
  <td class=xl26 width=100 style='width:75pt'></td>
  <td class=xl26 width=89 style='width:67pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
 </tr>
 <tr height=37 style='height:27.75pt'>
  <td height=37 colspan=2 class=xl26 style='height:27.75pt;mso-ignore:colspan'></td>
  <td class=xl52 colspan=4 align=left style='mso-ignore:colspan'>688/1 Huơng lộ 2, P. Bình Trị Đông A, Quận Bình Tân, TP HCM
</td>
  <td colspan=4 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl51>BẢNG LƯƠNG NHÂN VIÊN THÁNG <%=p_work_mon.Substring(4,2).ToString() + "/" + p_work_mon.Substring(0,4).ToString()%></td>
  <td colspan=19 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl32></td>
  <td colspan=11 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=2 class=xl26 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl52 colspan=3 align=left style='mso-ignore:colspan'>
  Phone :  083 877 5661
</td>
  <td colspan=5 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=25 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl36 height=76 style='mso-height-source:userset;height:57.0pt'>
  <td height=76 class=xl49 width=44 style='height:57.0pt;width:33pt'>No.<br>
    <font class="font11">STT</font></td>
  <td class=xl49 width=92 style='border-left:none;width:69pt'>GROUP<br>
    <font class="font11">Nhóm</font></td>
  <td class=xl49 width=58 style='border-left:none;width:44pt'>Emp ID<br>
    <font class="font11">Mã NV</font></td>
  <td class=xl49 width=137 style='border-left:none;width:103pt'>Full Name<br>
    <font class="font11">Họ và Tên</font></td>
  <td class=xl49 width=73 style='border-left:none;width:55pt'>Join Date<br>
    <font class="font11">Ngày vào</font></td>
  <td class=xl49 width=77 style='border-left:none;width:58pt'>Position<br>
    <font class="font11">Chức vụ</font></td>
  <td class=xl34 width=75 style='border-left:none;width:56pt'>Insurance
  Salary<br>
    <font class="font11">Lương Bảo hiểm</font></td>
  <td class=xl34 width=84 style='width:63pt'>Salary<br>
    <font class="font11">Lương</font></td>
  <td class=xl49 width=92 style='width:69pt'>ALLOWANCE<br>
    <font class="font11">Phụ Cấp Tay nghề</font></td>
  <td class=xl34 width=79 style='border-left:none;width:59pt'>Working
  Days<br>
    <font class="font11">Ngày công</font></td>
  <td class=xl34 width=94 style='width:71pt'>Temp Absence <br>
    <font class="font11">Nghỉ hết hàng </font></td>
   <td class=xl34 width=94 style='width:71pt'>Other Absence <br>
    <font class="font11">Nghỉ khác trả lương</font></td>
  <td class=xl49 width=93 style='width:70pt'>Working Salary<br>
    <font class="font11">Lương ngày công</font></td>
  <td class=xl34 width=64 style='border-left:none;width:48pt'>OT Hours<br>
    <font class="font11">Giờ T.C</font></td>
  <td class=xl34 width=56 style='width:42pt'>HT Hours<br>
    <font class="font11">T.C lễ</font></td>
  <td class=xl34 width=56 style='width:42pt'>NT 30%<br>
    <font class="font11">Trợ cấp đêm</font></td>
  <td class=xl34 width=56 style='width:42pt'>NT 45%<br>
    <font class="font11">Trợ cấp đêm</font></td>
  <td class=xl34 width=56 style='width:42pt'>NT 60%<br>
    <font class="font11">Trợ cấp đêm</font></td>
  <td class=xl34 width=56 style='width:42pt'>NT 90%<br>
    <font class="font11">Trợ cấp đêm</font></td>
  <td class=xl49 width=74 style='width:56pt'>OT Salary<br>
    </td>
  <td class=xl49 width=74 style='border-left:none;width:56pt'>OT (100%)<br>
    <font class="font11">Lương tăng ca</font></td>
  <td class=xl49 width=84 style='border-left:none;width:63pt'>Allowance<br>
    <font class="font11">Phụ cấp tay nghề</font></td>
  <td class=xl49 width=83 style='border-left:none;width:62pt'>Diligent
  Allowance <font class="font11">Phụ cấp chuyên cần</font></td>
  <td class=xl49 width=83 style='border-left:none;width:62pt'>House
  Allowance<br>
    <font class="font11">Phụ cấp nhà</font></td>
  <td class=xl49 width=83 style='border-left:none;width:62pt'>Noxious
  Allowance<br>
    <font class="font11">Phụ cấp độc hại</font></td>
  <td class=xl49 width=99 style='border-left:none;width:74pt'>Other
  Compensation<br>
    <font class="font11">Hoàn trả khác</font></td>
  <td class=xl49 width=99 style='border-left:none;width:74pt'>Incentive<br>
    <font class="font11">Thưởng</font></td>
  <td colspan=2 class=xl34 width=136 style='border-right:.5pt solid black;
  border-left:none;width:102pt'>Remain ALE<br>
    <font class="font11">Phép năm còn lại<span
  style='mso-spacerun:yes'> </span></font></td>
  <td colspan=2 class=xl34 width=127 style='border-right:.5pt solid black;
  border-left:none;width:96pt'>Severance<br>
    <font class="font11">Trợ cấp thôi việc</font></td>
  <td class=xl49 width=97 style='border-left:none;width:73pt'>Total
  Income<br>
    <font class="font11">Tổng thu nhập</font></td>
  <td class=xl49 width=73 style='border-left:none;width:55pt'>Break
  Contract<br>
    <font class="font11">Vi phạm hợp đồng</font></td>
  <td class=xl49 width=109 style='border-left:none;width:82pt'>Non Permission
  Leave<br>
    <font class="font11">Vắng không phép</font></td>
  <td class=xl49 width=72 style='border-left:none;width:54pt'>Other
  Deduction<br>
    <font class="font11">Trừ khác</font></td>
  <td class=xl49 width=85 style='border-left:none;width:64pt'>Deduct PIT<br>
    <font class="font11">Giảm trừ thuế</font></td>
  <td class=xl49 width=85 style='border-left:none;width:64pt'>Income Pay
  Tax<br>
    <font class="font11">Thu nhập chịu thuế</font></td>
  <td class=xl49 width=85 style='border-left:none;width:64pt'>Income Tax<br>
    <font class="font11">Thuế thu nhập</font></td>
  <td class=xl49 width=100 style='border-left:none;width:75pt'>Insurance
  8.5%)<br>
    <font class="font11">Tiền bảo hiểm</font></td>
  <td class=xl49 width=89 style='border-left:none;width:67pt'>Salary
  Total<br>
    <font class="font11">Thực lãnh</font></td>
  <td class=xl49 width=64 style='border-left:none;width:48pt'>Sign<br>
    <font class="font11">Ký nhận</font></td>
  <td colspan=7 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <%
    int i;
	String new_org,cur_org,sclass;
    double[] Group_Total=new double[icol_emp];
    double[] Sub_Total=new double[icol_emp];
    int ino=0;
    Boolean bTotal=false; 
	for (int j=5;j<icol_emp;j++)
    {
        Group_Total[j-5]=0;
		Sub_Total[j-5]=0;
    }
    
    for (i=0;i<irow_emp;i++)
    {	
		bTotal=false; 
		cur_org=dt_Emp.Rows[i][0].ToString();
        ino++;
        if (i==irow_emp-1)
			bTotal=true;
		else
		{
			new_org=dt_Emp.Rows[i+1][0].ToString() ;
			if (new_org != cur_org)
				bTotal=true;
		}

       
  %>
 <tr class=xl43 height=46 style='mso-height-source:userset;height:34.5pt'>
 
  <td height=46 class=xl37 style='height:34.5pt' x:num><%=ino %></td>
  <td class=xl38 align=left style='border-left:none'><%=dt_Emp.Rows[i][0].ToString() %></td>
  <td class=xl37 style='border-left:none'><%=dt_Emp.Rows[i][1].ToString() %></td>
  <td class=xl38 align=left style='border-left:none'><%=dt_Emp.Rows[i][2].ToString() %></td>
  <td class=xl39 style='border-left:none' x:num><%=dt_Emp.Rows[i][3].ToString() %></td>
  <td class=xl39 style='border-left:none'><%=dt_Emp.Rows[i][4].ToString() %></td>
  <%    for (int j=5;j<icol_emp;j++)   
        {
            if (j==8 || j==9 || j==10 || (j>=12 && j<=17))
                   sclass="xl42";
            else
                   sclass="xl41";
            Group_Total[j-5]+=Double.Parse(dt_Emp.Rows[i][j].ToString());
			Sub_Total[j-5]+=Double.Parse(dt_Emp.Rows[i][j].ToString());
    %>
  <td class="<%=sclass %>" align=left style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][j].ToString() %></td>
  <%    } %>
  <td class=xl40 style='border-left:none'>&nbsp;</td>
 </tr>
 <%if (bTotal==true)
 { %>
  <tr class=xl28 height=46 style='mso-height-source:userset;height:34.5pt'>
  <td colspan=6 height=46 class=xl44 style='border-right:.5pt solid black;
  height:34.5pt'>Total: <%=ino %> Employee(s)</td>
  <%    for (int j=5;j<icol_emp;j++)   
        {
            if (j==8 || j==9 || (j>=11 && j<=16))
                   sclass="xl48";
            else
                   sclass="xl47";
            
    %>
  <td class="<%=sclass %>" style='border-left:none' x:num><%=Sub_Total[j-5] %></td>
  <%
            Sub_Total[j-5]=0;
            
        } %>
  <td class=xl47 style='border-left:none'>&nbsp;</td>
 </tr>
 <%
    
    bTotal=false;
    ino=0;
 } %>
 <%} //end for  %>
  <tr class=xl28 height=46 style='mso-height-source:userset;height:34.5pt'>
  <td colspan=6 height=46 class=xl44 style='border-right:.5pt solid black;
  height:34.5pt'>Grant Total: <%=irow_emp %> Employee(s)</td>
  <%    for (int j=5;j<icol_emp;j++)   
        {
            if (j==8 || j==9 || (j>=11 && j<=16))
                   sclass="xl48";
            else
                   sclass="xl47";
            
    %>
  <td class="<%=sclass %>" style='border-left:none' x:num><%=Group_Total[j-5] %></td>
  <%
        } %>
  <td class=xl47 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=38 class=xl30 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=9 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=38 class=xl30 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=9 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 colspan=3 class=xl53 style='height:23.25pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl54>PREPARE BY</td>
  <td colspan=6 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl53></td>
  <td colspan=5 class=xl54>CHECKED BY</td>
  <td colspan=4 class=xl53 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=7 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl54>APPROVED BY</td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=11 class=xl53 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl55 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=13 class=xl55 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=47 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=47 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=47 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=47 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=47 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 colspan=47 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 colspan=3 class=xl53 style='height:23.25pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl54></td>
  <td colspan=6 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl53></td>
  <td colspan=5 class=xl56 x:str="KIM JEONG MEE"><span
  style='mso-spacerun:yes'> </span>KIM JEONG MEE<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl53 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=7 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl56 x:str="JUNG CHUL WON"><span
  style='mso-spacerun:yes'> </span>JUNG CHUL WON<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl57></td>
  <td colspan=10 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=44 style='width:33pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=137 style='width:103pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
