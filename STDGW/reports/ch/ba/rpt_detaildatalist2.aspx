<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_tco_dept_pk, p_thr_group_pk, p_status, p_emp_id, p_work_mon, p_from_dt, p_to_dt, p_work_shift, p_salary_period, p_nation,p_search_by,p_search_temp,p_reg;
    
    p_tco_dept_pk = Request["p_tco_org_pk"].ToString(); 
    p_thr_group_pk = Request["p_wg"].ToString();
    p_search_by         = Request["p_search_by"].ToString();
    p_search_temp       = Request["p_search_temp"].ToString();
   
    p_to_dt = Request["p_to_date"].ToString();
    p_from_dt = Request["p_from_date"].ToString();
    
    p_work_shift = Request["p_work_shift"].ToString();
    
    
    p_nation = Request["p_nation"].ToString();
    p_reg= Request["p_reg"].ToString();
    
    DateTime p_from_dt_1=new DateTime(int.Parse(p_from_dt.Substring(0,4).ToString()),int.Parse(p_from_dt.Substring(4,2).ToString()),int.Parse(p_from_dt.Substring(6,2).ToString())) ;
    DateTime p_to_dt_1=new DateTime(int.Parse(p_to_dt.Substring(0,4).ToString()),int.Parse(p_to_dt.Substring(4,2).ToString()),int.Parse(p_to_dt.Substring(6,2).ToString())) ;
    TimeSpan ts=p_to_dt_1-p_from_dt_1;
    int iDays=ts.Days+1;
    
    string SQL
	= "select c.emp_id||'-'||C.FULL_NAME C0,E.ORG_NM C1,D.ORG_NM C2 " + 
	"   ,(SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0008' AND V.CODE=C.POS_TYPE) C3 "+
        ",to_char(to_date(a.work_dt,'yyyymmdd'),'dd/mm/yyyy') C4 " +
        ",decode(a.day_type,1,'CN',a.day_type) C5,b.time_in C6,b.time_out C7,s.shift C8,round(nvl(b.work_time,0)-nvl(B.MINUS_WT,0),2) C9,0 C10,round(nvl(ot.ot,0),2) C11 " +
        ",round(nvl(ot.st,0),2) C12,round(nvl(ot.oht,0),2) C13,round(nvl(ot.nt_30,0),2) C14,round(nvl(ot.nt_45,0),2) C15,round(nvl(ot.nt_60,0),2) C16 " +
        ",(case when (HR_F_LATELY_EARLY(a.WORK_DT,s.START_TIME,b.DATE_IN,b.TIME_IN,'IN',b.thr_emp_pk)) >=0 then 0  " +
        "                       else  " +
        "                           ABS((HR_F_LATELY_EARLY(a.WORK_DT,s.START_TIME,b.DATE_IN,b.TIME_IN,'IN',b.thr_emp_pk)))  " +
        "                     END ) C17  " +
        "           ,(case when (HR_F_LATELY_EARLY(b.DATE_OUT,b.TIME_OUT,DECODE(s.DURING_DAY,1,b.WORK_DT,TO_CHAR(TO_DATE(b.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),s.END_TIME,'OUT',b.thr_emp_pk)) >=0 then 0  " +
        "                       else  " +
        "                           abs((HR_F_LATELY_EARLY(b.DATE_OUT,b.TIME_OUT,DECODE(s.DURING_DAY,1,b.WORK_DT,TO_CHAR(TO_DATE(b.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),s.END_TIME,'OUT',b.thr_emp_pk)))  " +
        "                     end) C18 ,nvl(B.MINUS_WT,0)+nvl(B.MINUS_OT,0) C19 " +
        " ,(CASE WHEN h.absence_type IS NOT NULL THEN  (select V.CHAR_1 from vhr_hr_code v where v.id='HR0003' and v.code= h.absence_type)"+
        "             ELSE  A.NOTE_ATT END) C20,h.absence_type C21 "+
        "                     ,DECODE(NVL(H.COMPANY_PAY_YN,'N'),'N',0,1) C22,(CASE WHEN NVL(A.HOL_TYPE,' ')='HOL' THEN 1 ELSE 0 END) C23 " +
        "                     ,(CASE WHEN H.THR_ABSENCE_REG_PK IS NULL THEN 0 ELSE  1 END) C24 " +
        "from thr_employee c,thr_wg_sch_detail a,thr_time_machine b,tco_org d,tco_org e,thr_work_shift s,thr_absence h " +
        ",(select M.THR_EMP_PK thr_emp_pk,m.work_dt,sum((case when t.hol_type is null and t.ot_type='OT' then nvl(t.ot_time,0)   else 0 end) -nvl(M.MINUS_OT,0) + nvl(m.ot_plus,0)) ot  " +
        "        ,sum(case when ((nvl(t.hol_type,' ')='SUN' and t.ot_type in('OT','HT')) or(nvl(t.hol_type,' ')='HOL' and t.ot_type ='HT')) then nvl(t.ot_time,0) + nvl(m.ot_plus,0) -nvl(M.MINUS_OT,0) else 0 end) st " +
        "        ,sum((case when nvl(t.hol_type,' ')='HOL' and t.ot_type in('OT') then nvl(t.ot_time,0) + nvl(m.ot_plus,0)-nvl(M.MINUS_OT,0) else 0 end) )  oht " +
        "        ,sum(case when t.hol_type is null and t.ot_type in('NT') then nvl(t.ot_time,0) else 0 end) nt_30 " +
        "         ,sum(case when t.hol_type is null and t.ot_type in('NT2') then nvl(t.ot_time,0) else 0 end) nt_45 " +
        "         ,sum(case when t.hol_type is not null and t.ot_type in('NT') then nvl(t.ot_time,0) else 0 end) nt_60 " +
        "from thr_extra_time t,thr_employee e,thr_time_machine m " +
        " where t.del_if(+)=0 and e.del_if=0 and m.del_if=0 and m.thr_emp_pk=e.pk and m.thr_emp_pk=t.thr_emp_pk(+) and t.work_dt(+)=m.work_dt " +
        "  and m.work_dt between '" + p_from_dt + "' and '" + p_to_dt + "' " +
		" and (e.tco_org_pk in ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_tco_dept_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_tco_dept_pk + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                       ) " +
        "     AND    UPPER (e.emp_id) LIKE '%' || UPPER (NVL('" + p_search_temp + "',e.emp_id)) " +
        "  group by M.THR_EMP_PK,m.work_dt " +
        ") ot " +
        "where c.del_if=0 and a.del_if=0 and b.del_if(+)=0 and d.del_if=0 and e.del_if=0 and s.del_if=0 and h.del_if(+)=0 and a.thr_ws_pk=s.pk " +
        "and c.pk=a.thr_emp_pk and a.thr_emp_pk=b.thr_emp_pk(+) and a.work_dt=b.work_dt(+) " +
        "and c.tco_org_pk=d.pk and d.p_pk=e.pk and a.thr_emp_pk=h.thr_emp_pk(+) and a.work_dt=h.absence_dt(+) " +
        "and a.work_dt between '" + p_from_dt + "' and '" + p_to_dt + "' " +
        "and a.thr_emp_pk=ot.thr_emp_pk(+) " +
        "and a.work_dt=ot.work_dt(+) and c.join_dt<=a.work_dt and nvl(c.left_dt,'99999999')>=a.work_dt" +
        " and (c.tco_org_pk in ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_tco_dept_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_tco_dept_pk + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        ) " +
        "     AND    UPPER (C.emp_id) LIKE '%' || UPPER (NVL('" + p_search_temp + "',C.emp_id)) " +
        "order by  c.emp_id,a.work_dt " ;
    
  
   
   //Response.Write(SQL);
   // Response.End();   
    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp;
    irow_emp = dt_Emp.Rows.Count;
    if (irow_emp == 0)
    {
        Response.Write("There is no data of working time");
        Response.End();
    }
    
    
    
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_detaildatalist_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_detaildatalist_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_detaildatalist_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Nguyen Cong Thanh</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2012-07-19T07:44:20Z</o:LastPrinted>
  <o:Created>2005-04-22T06:24:06Z</o:Created>
  <o:LastSaved>2012-07-19T07:44:58Z</o:LastSaved>
  <o:Company>Vina Genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.17in 0in 0in .3in;
	mso-header-margin:.17in;
	mso-footer-margin:0in;}
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
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	border-top:none;
	border-right:.5pt solid silver;
	border-bottom:.5pt solid silver;
	border-left:.5pt solid silver;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid silver;
	border-bottom:.5pt solid silver;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid silver;
	border-bottom:.5pt solid silver;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid silver;
	border-bottom:.5pt solid silver;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid silver;
	border-bottom:.5pt solid silver;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid silver;
	border-bottom:.5pt solid silver;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.00\;\[Red\]\#\,\#\#0\.00";
	text-align:center;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid silver;
	border-right:none;
	border-bottom:.5pt solid silver;
	border-left:.5pt solid silver;}
.xl41
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid silver;
	border-right:none;
	border-bottom:.5pt solid silver;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid silver;
	border-right:.5pt solid silver;
	border-bottom:.5pt solid silver;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:16.0pt;
	text-align:center;}
.xl47
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl48
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-size:18.0pt;
	text-align:center;}
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
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
     <%
        int ipage=18+iDays + 3;
        int irow=0;
        for (int k=0;k<irow_emp/iDays;k++)
        {
            irow+=ipage;
                %>
                    <x:RowBreak>
                        <x:Row><%=irow %></x:Row>
                    </x:RowBreak>
                <%
                
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
  <x:WindowHeight>9225</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=833 style='border-collapse:
 collapse;table-layout:fixed;width:626pt'>
 <col width=27 style='mso-width-source:userset;mso-width-alt:987;width:20pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=31 style='mso-width-source:userset;mso-width-alt:1133;width:23pt'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=43 style='mso-width-source:userset;mso-width-alt:1572;width:32pt'>
 <col width=27 style='mso-width-source:userset;mso-width-alt:987;width:20pt'>
 <col width=52 span=2 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col width=46 style='mso-width-source:userset;mso-width-alt:1682;width:35pt'>
 <col width=47 style='mso-width-source:userset;mso-width-alt:1718;width:35pt'>
 <col width=45 span=3 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col width=46 style='mso-width-source:userset;mso-width-alt:1682;width:35pt'>
 <col width=51 style='mso-width-source:userset;mso-width-alt:1865;width:38pt'>
 <col width=49 style='mso-width-source:userset;mso-width-alt:1792;width:37pt'>
 <col width=50 style='mso-width-source:userset;mso-width-alt:1828;width:38pt'>
 <col width=69 style='mso-width-source:userset;mso-width-alt:2523;width:52pt'>
 <% 
    int i=0;
    while (i<irow_emp)
    {
        
    %> 
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 width=27 style='height:9.0pt;width:20pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=31 style='width:23pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=69 style='width:52pt'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 colspan=2 style='height:22.5pt;mso-ignore:colspan'></td>
  <td colspan=12 class=xl46>DANH SÁCH CHI TIẾT NHÂN VIÊN ĐI LÀM</td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=2 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=12 class=xl25>TỪ <%=p_from_dt.Substring(6,2).ToString() + "/" + p_from_dt.Substring(4,2).ToString() + "/" + p_from_dt.Substring(0,4).ToString() %> TỚI <%=p_to_dt.Substring(6,2).ToString() + "/" + p_to_dt.Substring(4,2).ToString() + "/" + p_to_dt.Substring(0,4).ToString() %></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=2 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=15 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 colspan=7 style='height:12.75pt;mso-ignore:colspan'>MSNV
  VÀ TÊN<span style='mso-spacerun:yes'>  </span>: <%= dt_Emp.Rows[i]["C0"].ToString() %></td>
  <td class=xl24></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl24 colspan=5 style='height:14.25pt;mso-ignore:colspan'>PHÒNG
  BAN<span style='mso-spacerun:yes'>     </span>: <%= dt_Emp.Rows[i]["C1"].ToString() %></td>
  <td class=xl24></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl24 colspan=5 style='height:14.25pt;mso-ignore:colspan'>BỘ
  PHẬN<span style='mso-spacerun:yes'>          </span>: <%= dt_Emp.Rows[i]["C2"].ToString() %></td>
  <td class=xl24></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl24 colspan=5 style='height:13.5pt;mso-ignore:colspan'>VỊ
  TRÍ<span style='mso-spacerun:yes'>               </span>: <%= dt_Emp.Rows[i]["C3"].ToString() %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=11 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=18 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td rowspan=2 height=39 class=xl47 style='border-bottom:.5pt solid black;
  height:29.25pt'>STT</td>
  <td rowspan=2 class=xl47 style='border-bottom:.5pt solid black'>NGÀY</td>
  <td rowspan=2 class=xl49 width=31 style='border-bottom:.5pt solid black;
  width:23pt'>THỨ</td>
  <td colspan=2 class=xl51 style='border-right:.5pt solid black;border-left:
  none'>GiỜ</td>
  <td rowspan=2 class=xl53 width=27 style='border-bottom:.5pt solid black;
  width:20pt'>CA LV</td>
  <td rowspan=2 class=xl53 width=52 style='border-bottom:.5pt solid black;
  width:39pt'>GiỜ CÔNG</td>
  <td rowspan=2 class=xl53 width=52 style='border-bottom:.5pt solid black;
  width:39pt'>NC 300%</td>
  <td colspan=3 class=xl55 width=138 style='border-right:.5pt solid black;
  border-left:none;width:104pt'>TĂNG CA (GiỜ)</td>
  <td colspan=3 class=xl43 width=136 style='border-right:.5pt solid black;
  border-left:none;width:103pt'>PHỤ CẤP (GIỜ)</td>
  <td rowspan=2 class=xl38 width=51 style='border-bottom:.5pt solid black;
  width:38pt'>ĐI TRỄ ( PHÚT )</td>
  <td rowspan=2 class=xl38 width=49 style='border-bottom:.5pt solid black;
  width:37pt'>VỀ SỚM ( PHÚT )</td>
  <td rowspan=2 class=xl38 width=50 style='border-bottom:.5pt solid black;
  width:38pt'><span style='mso-spacerun:yes'> </span>GiỜ RA NGOÀI</td>
  <td rowspan=2 class=xl38 width=69 style='border-bottom:.5pt solid black;
  width:52pt' x:str="LÝ DO NGHỈ ">LÝ DO NGHỈ<span
  style='mso-spacerun:yes'> </span></td>
 </tr>

 <tr class=xl26 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt'>VÀO</td>
  <td class=xl27>RA</td>
  <td class=xl28 width=46 style='width:35pt'>TC.150</td>
  <td class=xl29 width=47 style='width:35pt'>CN/NL.200</td>
  <td class=xl29 width=45 style='width:34pt'>NL.300</td>
  <td class=xl29 width=45 style='width:34pt'>PC.30</td>
  <td class=xl29 width=45 style='width:34pt'>PC.45</td>
  <td class=xl29 width=46 style='width:35pt'>PC.60</td>
 </tr>
  <%    int j=0; 
        int hl1=0;
        int hl2=0;
        int nl=0;
        int abs_pay=0;
        int abs_no_pay=0;
        double[] Group_GTotal=new double[11] {0,0,0,0,0,0,0,0,0,0,0};
        int icur=i;
        int flag=0;
       while ( i<icur+iDays) //while 2  while ( (   i!=0  && i<irow_emp && dt_Emp.Rows[i]["a0"].ToString() == dt_Emp.Rows[i-1]["a0"].ToString()) || i==0 )
        { 
            j++; 
            if(i>=irow_emp)
            {
                i+=1;
                flag=1;
            }
            else if(i>0)
            {
                if(dt_Emp.Rows[i]["C0"].ToString()!=dt_Emp.Rows[i-1]["C0"].ToString()) //sang nguoi moi
                {
                    i+=1;
                    flag=1;
                }
            
            }
             
    %>
    <%if(flag==1) 
    {
    %>
    <tr class=xl30 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt' x:num>&nbsp;</td>
  <td class=xl32 x:str>&nbsp;</td>
  <td class=xl32 x:str>&nbsp;</td>
  <td class=xl32 x:str>&nbsp;</td>
  <td class=xl32 x:str>&nbsp;</td>
  <td class=xl31 style='border-left:none' x:num>&nbsp;</td>
                <% 
                    
                    for (int k=9;k<20;k++)
                    {
                        
                     %>
                    <td class=xl33 x:num style="white-space:nowrap;mso-text-control:shrinktofit;">0</td>
                 <%} %>
  <td class=xl31 style='border-left:none'>&nbsp;</td>
 </tr>
 <%
 }
 else 
 {
 %>
 <tr class=xl30 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt' x:num><%=j %></td>
  <td class=xl32 x:str><%=dt_Emp.Rows[i]["C4"].ToString() %></td>
  <td class=xl32 x:str><%=dt_Emp.Rows[i]["C5"].ToString() %></td>
  <td class=xl32 x:str><%=dt_Emp.Rows[i]["C6"].ToString() %></td>
  <td class=xl32 x:str><%=dt_Emp.Rows[i]["C7"].ToString() %></td>
  <td class=xl31 style='border-left:none' x:num><%=dt_Emp.Rows[i]["C8"].ToString() %></td>
                <% 
                    
                    for (int k=9;k<20;k++)
                    {
                        Group_GTotal[k-9]+=Double.Parse(dt_Emp.Rows[i][k].ToString());
                     %>
                    <td class=xl33 x:num style="white-space:nowrap;mso-text-control:shrinktofit;"><%=dt_Emp.Rows[i][k].ToString() %></td>
                 <%} %>
  <td class=xl31 style='border-left:none'><%=dt_Emp.Rows[i]["C20"].ToString() %></td>
 </tr>
 <%       
        if(dt_Emp.Rows[i]["C21"].ToString()!="")
        {
            if(Double.Parse(dt_Emp.Rows[i]["C22"].ToString())==1)
                abs_pay+=1;
            else
                abs_no_pay+=1;                
        }
        
   
        if(Double.Parse(dt_Emp.Rows[i]["C23"].ToString())==1) //NGAY LE
        {
            for(int h=icur;h<icur+iDays;h++)
            {
                if((h<=i)&&(Double.Parse(dt_Emp.Rows[i]["C24"].ToString())==1))
                    hl1=1;
                if((h>=i)&&(Double.Parse(dt_Emp.Rows[i]["C24"].ToString())==1))
                    hl2=1;    
            }
            if(hl1==1 && hl2==1)
                nl=0;
            else 
                nl+=1;    
        }
    
        i++;
    }//end of else

  }//while 2
             i--;
     %>
    
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=3 height=24 class=xl40 style='border-right:.5pt solid silver;
  height:18.0pt'>Tổng số giờ làm việc :</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
                 <% 
                    for (int k=0;k<11;k++)
                    {
                        
                     %>
  <td class=xl36 x:num style="white-space:nowrap;mso-text-control:shrinktofit;"><span style='mso-spacerun:yes'> </span><%=Group_GTotal[k] %> </td>
                    <%} %>
  <td class=xl36>&nbsp;</td>
  
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=3 style='height:18.0pt;mso-ignore:colspan'>Tổng số ngày
  công :</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td class=xl37 x:num><%=Group_GTotal[0]/8 %></td>
  <td colspan=5 class=xl37 style='mso-ignore:colspan'></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=18 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 colspan=5 style='height:13.5pt;mso-ignore:colspan'
  x:str="Số ngày nghỉ lễ:                           ">Số ngày nghỉ lễ:<span
  style='mso-spacerun:yes'>                           </span></td>
  <td></td>
  <td align=right x:num><%=nl %></td>
  <td colspan=11 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=6 style='height:14.25pt;mso-ignore:colspan'
  x:str="Số ngày nghỉ được hưởng luơng:         ">Số ngày nghỉ được hưởng
  luơng:<span style='mso-spacerun:yes'>         </span></td>
  <td align=right x:num><%=abs_pay %></td>
  <td colspan=11 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=6 style='height:14.25pt;mso-ignore:colspan'
  x:str="Số nghỉ không được hưởng luơng:         ">Số nghỉ không được hưởng
  luơng:<span style='mso-spacerun:yes'>        </span><span style='display:
  none'><span style='mso-spacerun:yes'> </span></span></td>
  <td align=right x:num><%=abs_no_pay %></td>
  <td colspan=11 style='mso-ignore:colspan'></td>
  
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 colspan=4 style='height:23.25pt;mso-ignore:colspan'></td>
  <td class=xl58>Checked By</td>
  <td colspan=7 style='mso-ignore:colspan'></td>
  <td class=xl58>Confirm By</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <%
    i++;
    
    }//end while %>
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=27 style='width:20pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=31 style='width:23pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=69 style='width:52pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
