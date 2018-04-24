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

    string p_to, p_org, p_status, p_nation, p_month;


    p_org = Request["p_org"].ToString();
    p_status = Request["p_status"].ToString();
    p_nation = Request["p_nation"].ToString();
    p_month = Request["p_month"].ToString();

    string SQL
    = "select 1, decode(b.EMPLOYEE_TYPE,'01','OFFICE','FACTORY')  " + 
        ",c.org_nm as c2  " +
        ",sum(case when a.WORK_DT between to_char(add_months(to_date('" + p_month + "','YYYYMM'),-2),'YYYYMM')||'16' and to_char(add_months(to_date('" + p_month + "','YYYYMM'),-1),'YYYYMM')||'15' and a.OT_TYPE not in ('NT','NT2') then nvl(a.OT_TIME,0) else 0 end) as c3  " +
        ",sum(case when a.WORK_DT between to_char(add_months(to_date('" + p_month + "','YYYYMM'),-2),'YYYYMM')||'16' and to_char(add_months(to_date('" + p_month + "','YYYYMM'),-1),'YYYYMM')||'15' and a.OT_TYPE in ('NT','NT2') then nvl(a.OT_TIME,0) else 0 end) as c4  " +
        ",sum(case when a.WORK_DT between to_char(add_months(to_date('" + p_month + "','YYYYMM'),-1),'YYYYMM')||'16' and '" + p_month + "'||'15' and nvl(a.PAY_RATE,0)=150 then nvl(a.OT_TIME,0) else 0 end) c5  " +
        ",sum(case when a.WORK_DT between to_char(add_months(to_date('" + p_month + "','YYYYMM'),-1),'YYYYMM')||'16' and '" + p_month + "'||'15' and nvl(a.PAY_RATE,0)=200 then nvl(a.OT_TIME,0) else 0 end) c6  " +
        ",sum(case when a.WORK_DT between to_char(add_months(to_date('" + p_month + "','YYYYMM'),-1),'YYYYMM')||'16' and '" + p_month + "'||'15' and nvl(a.PAY_RATE,0)=300 then nvl(a.OT_TIME,0) else 0 end) c7  " +
        ",sum(case when a.WORK_DT between to_char(add_months(to_date('" + p_month + "','YYYYMM'),-1),'YYYYMM')||'16' and '" + p_month + "'||'15' and nvl(a.PAY_RATE,0) in (150,200,300) then nvl(a.OT_TIME,0) else 0 end) c8  " +
        ",sum(case when a.WORK_DT between to_char(add_months(to_date('" + p_month + "','YYYYMM'),-1),'YYYYMM')||'16' and '" + p_month + "'||'15' and a.OT_TYPE in ('NT','NT2') then nvl(a.OT_TIME,0) else 0 end) c9  " +
        ",case when sum(case when a.WORK_DT between to_char(add_months(to_date('" + p_month + "','YYYYMM'),-1),'YYYYMM')||'16' and '" + p_month + "'||'15' and nvl(a.PAY_RATE,0) in (150,200,300) then nvl(a.OT_TIME,0) else 0 end)  " +
        "- sum(case when a.WORK_DT between to_char(add_months(to_date('" + p_month + "','YYYYMM'),-2),'YYYYMM')||'16' and to_char(add_months(to_date('" + p_month + "','YYYYMM'),-1),'YYYYMM')||'15' and a.OT_TYPE not in ('NT','NT2') then nvl(a.OT_TIME,0) else 0 end)  " +
        ">0 then sum(case when a.WORK_DT between to_char(add_months(to_date('" + p_month + "','YYYYMM'),-1),'YYYYMM')||'16' and '" + p_month + "'||'15' and nvl(a.PAY_RATE,0) in (150,200,300) then nvl(a.OT_TIME,0) else 0 end)  " +
        "- sum(case when a.WORK_DT between to_char(add_months(to_date('" + p_month + "','YYYYMM'),-2),'YYYYMM')||'16' and to_char(add_months(to_date('" + p_month + "','YYYYMM'),-1),'YYYYMM')||'15' and a.OT_TYPE not in ('NT','NT2') then nvl(a.OT_TIME,0) else 0 end)  " +
        "else 0 end as c10  " +
        ",case when sum(case when a.WORK_DT between to_char(add_months(to_date('" + p_month + "','YYYYMM'),-1),'YYYYMM')||'16' and '" + p_month + "'||'15' and nvl(a.PAY_RATE,0) in (150,200,300) then nvl(a.OT_TIME,0) else 0 end)  " +
        "- sum(case when a.WORK_DT between to_char(add_months(to_date('" + p_month + "','YYYYMM'),-2),'YYYYMM')||'16' and to_char(add_months(to_date('" + p_month + "','YYYYMM'),-1),'YYYYMM')||'15' and a.OT_TYPE not in ('NT','NT2') then nvl(a.OT_TIME,0) else 0 end)  " +
        "<0 then sum(case when a.WORK_DT between to_char(add_months(to_date('" + p_month + "','YYYYMM'),-1),'YYYYMM')||'16' and '" + p_month + "'||'15' and nvl(a.PAY_RATE,0) in (150,200,300) then nvl(a.OT_TIME,0) else 0 end)  " +
        "- sum(case when a.WORK_DT between to_char(add_months(to_date('" + p_month + "','YYYYMM'),-2),'YYYYMM')||'16' and to_char(add_months(to_date('" + p_month + "','YYYYMM'),-1),'YYYYMM')||'15' and a.OT_TYPE not in ('NT','NT2') then nvl(a.OT_TIME,0) else 0 end)  " +
        "else 0 end as c11  " +
        ",case when sum(case when a.WORK_DT between to_char(add_months(to_date('" + p_month + "','YYYYMM'),-1),'YYYYMM')||'16' and '" + p_month + "'||'15' and a.OT_TYPE in ('NT','NT2') then nvl(a.OT_TIME,0) else 0 end)  " +
        "- sum(case when a.WORK_DT between to_char(add_months(to_date('" + p_month + "','YYYYMM'),-2),'YYYYMM')||'16' and to_char(add_months(to_date('" + p_month + "','YYYYMM'),-1),'YYYYMM')||'15' and a.OT_TYPE in ('NT','NT2') then nvl(a.OT_TIME,0) else 0 end)  " +
        ">0 then sum(case when a.WORK_DT between to_char(add_months(to_date('" + p_month + "','YYYYMM'),-1),'YYYYMM')||'16' and '" + p_month + "'||'15' and a.OT_TYPE in ('NT','NT2') then nvl(a.OT_TIME,0) else 0 end)  " +
        "- sum(case when a.WORK_DT between to_char(add_months(to_date('" + p_month + "','YYYYMM'),-2),'YYYYMM')||'16' and to_char(add_months(to_date('" + p_month + "','YYYYMM'),-1),'YYYYMM')||'15' and a.OT_TYPE in ('NT','NT2') then nvl(a.OT_TIME,0) else 0 end)  " +
        "else 0 end as c12  " +
        ",case when sum(case when a.WORK_DT between to_char(add_months(to_date('" + p_month + "','YYYYMM'),-1),'YYYYMM')||'16' and '" + p_month + "'||'15' and a.OT_TYPE in ('NT','NT2') then nvl(a.OT_TIME,0) else 0 end)  " +
        "- sum(case when a.WORK_DT between to_char(add_months(to_date('" + p_month + "','YYYYMM'),-2),'YYYYMM')||'16' and to_char(add_months(to_date('" + p_month + "','YYYYMM'),-1),'YYYYMM')||'15' and a.OT_TYPE in ('NT','NT2') then nvl(a.OT_TIME,0) else 0 end)  " +
        "<0 then sum(case when a.WORK_DT between to_char(add_months(to_date('" + p_month + "','YYYYMM'),-1),'YYYYMM')||'16' and '" + p_month + "'||'15' and a.OT_TYPE in ('NT','NT2') then nvl(a.OT_TIME,0) else 0 end)  " +
        "- sum(case when a.WORK_DT between to_char(add_months(to_date('" + p_month + "','YYYYMM'),-2),'YYYYMM')||'16' and to_char(add_months(to_date('" + p_month + "','YYYYMM'),-1),'YYYYMM')||'15' and a.OT_TYPE in ('NT','NT2') then nvl(a.OT_TIME,0) else 0 end)  " +
        "else 0 end as c13  " +
        "from thr_extra_time a, thr_employee b, comm.tco_org c  " +
        "where a.del_if=0 and b.del_if=0 and c.del_if=0  " +
        "and a.THR_EMP_PK = b.PK  " +
        "and b.TCO_ORG_PK = c.PK  " +
        "and a.WORK_DT between to_char(add_months(to_date('" + p_month + "','YYYYMM'),-2),'YYYYMM')||'16' and '" + p_month + "'||'15'  " +
            "and Decode('" + p_status + "','ALL','ALL', b.STATUS )= '" + p_status + "' " +
            "and Decode('" + p_nation + "','ALL','ALL', b.NATION )= '" + p_nation + "' " +
            " and (b.tco_org_pk in ( " +
            "                              SELECT     g.pk " +
            "                                    FROM comm.tco_org g " +
            "                                   WHERE g.del_if = 0 " +
            "                              START WITH g.pk = " +
            "                                            DECODE ('" + p_org + "', " +
            "                                                    'ALL', 0, " +
            "                                                    '" + p_org + "' " +
            "                                                   ) " +
            "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
            "                        OR '" + p_org + "' = 'ALL') " +
            "group by c.org_nm, b.EMPLOYEE_TYPE " +
            "order by b.EMPLOYEE_TYPE, c.ORG_NM ";


    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp, icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp = dt_Emp.Columns.Count;
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
<link rel=File-List href="rpt_overtime_nightshift_vhpc_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_overtime_nightshift_vhpc_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_overtime_nightshift_vhpc_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>HR_PHU</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-03-16T02:56:11Z</o:LastPrinted>
  <o:Created>2010-11-08T01:11:33Z</o:Created>
  <o:LastSaved>2011-03-16T08:38:12Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .2in .5in .2in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
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
td
	{mso-style-parent:style0;
	padding:0px;
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
.xl65
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;}
.xl67
	{mso-style-parent:style0;
	font-size:14.0pt;
	text-align:center;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
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
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl81
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl82
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
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
.xl83
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl84
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl86
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl87
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl89
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl90
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>OT&amp;NS</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>84</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
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
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7875</x:WindowHeight>
  <x:WindowWidth>14175</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>15</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1107 style='border-collapse:
 collapse;table-layout:fixed;width:828pt'>
 <col width=33 style='mso-width-source:userset;mso-width-alt:1206;width:25pt'>
 <col width=131 style='mso-width-source:userset;mso-width-alt:4790;width:98pt'>
 <col width=79 span=2 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col width=87 span=4 style='mso-width-source:userset;mso-width-alt:3181;
 width:65pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=87 span=4 style='mso-width-source:userset;mso-width-alt:3181;
 width:65pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 width=33 style='height:15.0pt;width:25pt' align=left
  valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75" coordsize="21600,21600"
   o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe" filled="f"
   stroked="f">
   <v:stroke joinstyle="miter"/>
   <v:formulas>
    <v:f eqn="if lineDrawn pixelLineWidth 0"/>
    <v:f eqn="sum @0 1 0"/>
    <v:f eqn="sum 0 0 @1"/>
    <v:f eqn="prod @2 1 2"/>
    <v:f eqn="prod @3 21600 pixelWidth"/>
    <v:f eqn="prod @3 21600 pixelHeight"/>
    <v:f eqn="sum @0 0 1"/>
    <v:f eqn="prod @6 1 2"/>
    <v:f eqn="prod @7 21600 pixelWidth"/>
    <v:f eqn="sum @8 21600 0"/>
    <v:f eqn="prod @7 21600 pixelHeight"/>
    <v:f eqn="sum @10 21600 0"/>
   </v:formulas>
   <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
   <o:lock v:ext="edit" aspectratio="t"/>
  </v:shapetype><v:shape id="Picture_x0020_1" o:spid="_x0000_s1025" type="#_x0000_t75"
   style='position:absolute;margin-left:0;margin-top:0;width:113.25pt;height:37.5pt;
   z-index:1;visibility:visible'>
   <v:imagedata src="rpt_overtime_nightshift_vhpc_files/image001.png" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:0px;width:151px;
  height:50px'><img width=151 height=50
  src="rpt_overtime_nightshift_vhpc_files/image002.jpg" v:shapes="Picture_x0020_1"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 width=33 style='height:15.0pt;width:25pt'></td>
   </tr>
  </table>
  </span></td>
  <td width=131 style='width:98pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=87 style='width:65pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl66 colspan=4 style='mso-ignore:colspan'>POSCO-VHPC VietNam
  Processing Center Co., Ltd</td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td colspan=13 height=33 class=xl90 style='height:24.75pt'>OVERTIME &amp;
  NIGHT SHIFT ALLOWANCE MONHTLY REPORT<span style='mso-spacerun:yes'> 
  </span><%= p_month.Substring(4,2).ToString() %>/<%= p_month.Substring(0,4).ToString() %></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=13 class=xl67 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=47 style='mso-height-source:userset;height:35.25pt'>
  <td rowspan=3 height=120 class=xl83 style='border-bottom:.5pt solid black;
  height:90.0pt'>No</td>
  <td rowspan=3 class=xl83 style='border-bottom:.5pt solid black'>Department</td>
  <td colspan=2 class=xl80 width=158 style='border-right:.5pt solid black;
  border-left:none;width:118pt'><span style='mso-spacerun:yes'> </span>Last
  month</td>
  <td colspan=4 class=xl88 style='border-left:none'>Current Overtime</td>
  <td rowspan=3 class=xl86 width=89 style='border-bottom:.5pt solid black;
  width:67pt'>Current Night-shift<br>
    </td>
  <td colspan=4 class=xl88 style='border-left:none'>Comparative</td>
 </tr>
 <tr height=46 style='mso-height-source:userset;height:34.5pt'>
  <td rowspan=2 height=73 class=xl86 width=79 style='border-bottom:.5pt solid black;
  height:54.75pt;border-top:none;width:59pt'>Overtime</td>
  <td rowspan=2 class=xl86 width=79 style='border-bottom:.5pt solid black;
  border-top:none;width:59pt'>Night shift</td>
  <td rowspan=2 class=xl86 width=87 style='border-bottom:.5pt solid black;
  border-top:none;width:65pt'>Normal (1.5)</td>
  <td rowspan=2 class=xl86 width=87 style='border-bottom:.5pt solid black;
  border-top:none;width:65pt'>Holiday (2.0)</td>
  <td rowspan=2 class=xl86 width=87 style='border-bottom:.5pt solid black;
  border-top:none;width:65pt'>Traditional (3.0)</td>
  <td rowspan=2 class=xl86 width=87 style='border-bottom:.5pt solid black;
  border-top:none;width:65pt'>Total</td>
  <td colspan=2 class=xl80 width=174 style='border-left:none;width:130pt'>Overtime</td>
  <td colspan=2 class=xl78 width=174 style='border-right:.5pt solid black;
  width:130pt'>Night shift</td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl74 width=87 style='height:20.25pt;border-left:none;
  width:65pt'>Over</td>
  <td class=xl74 width=87 style='border-left:none;width:65pt'>Less</td>
  <td class=xl74 width=87 style='border-left:none;width:65pt'>Over</td>
  <td class=xl74 width=87 style='border-left:none;width:65pt'>Less</td>
 </tr>
   <%
    int i = 0;
    int count = 1;
    Boolean flag = true;
    Boolean flag_total = false;
    string emp_type_old, emp_type_new;
    double over1, less1, over2, less2; 
    double[] total = new double[11];
    double[] gtotal = new double[11];
    for (int k = 0; k < 11; k++)
    {
        total[k] = 0;
        gtotal[k] = 0;
    }  
    for (i = 0; i < irow_emp; i++)
    {
        emp_type_old = dt_Emp.Rows[i][1].ToString();

        for (int j = 3; j < icol_emp; j++)
        { 
            total[j-3] += Double.Parse(dt_Emp.Rows[i][j].ToString());
            gtotal[j-3] += Double.Parse(dt_Emp.Rows[i][j].ToString());
        }
        if (flag)
        {
  %>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl68 colspan=13 style='height:27.75pt;mso-ignore:colspan'>
  <%= dt_Emp.Rows[i][1].ToString()%> :</td>
  
 </tr>
  <%	
    flag = false;
}
 %>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl71 style='height:24.0pt;border-top:none' x:num><%= count %></td>
  <td class=xl65 style='border-top:none;border-left:none' x:str><%= dt_Emp.Rows[i][2].ToString()%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>        </span><%= dt_Emp.Rows[i][3].ToString()%> </td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>        </span><%= dt_Emp.Rows[i][4].ToString()%> </td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= dt_Emp.Rows[i][5].ToString()%> </td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= dt_Emp.Rows[i][6].ToString()%> </td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= dt_Emp.Rows[i][7].ToString()%> </td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= dt_Emp.Rows[i][8].ToString()%> </td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%= dt_Emp.Rows[i][9].ToString()%> </td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= dt_Emp.Rows[i][10].ToString()%> </td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_Emp.Rows[i][11].ToString()%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%= dt_Emp.Rows[i][12].ToString()%> </td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_Emp.Rows[i][13].ToString()%><span
  style='mso-spacerun:yes'>   </span></td>
 </tr>
 <%
     
    if (i < irow_emp - 1)
    {
        count = count + 1;
        emp_type_new = dt_Emp.Rows[i + 1][1].ToString();
        if (emp_type_new != emp_type_old)
        {
            flag = true;
            flag_total = true;
        }
    }
    else
    {
        flag = true;
        flag_total = true;
    }
    if (flag_total)
    {
  %>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl68 colspan=2 style='height:24.0pt;mso-ignore:colspan'>Total
  <%= dt_Emp.Rows[i][1].ToString()%></td>
  <td class=xl73 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>        </span><%= total[0] %> </td>
  <td class=xl73 style='border-top:none;border-left:none' x:num><span   
  style='mso-spacerun:yes'>        </span><%= total[1] %> </td>
  <td class=xl73 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= total[2] %> </td>
  <td class=xl73 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= total[3] %> </td>
  <td class=xl73 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= total[4] %> </td>
  <td class=xl73 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= total[5] %> </td>
  <td class=xl73 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%= total[6] %> </td>
 
 <%

     if (total[7] + total[8]>0)
     {
         over1 = total[7] + total[8];
         less1 = 0;
     }
     else
     {
         over1 = 0;
         less1 = total[7] + total[8];
     }   
 %>
  <td class=xl73 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span>  <span
  style='mso-spacerun:yes'>   </span><%= over1 %> </td>
  <td class=xl73 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= less1 %></td>
  
   <%

     if (total[9] + total[10]>0)
     {
         over2 = total[9] + total[10];
         less2 = 0;
     }
     else
     {
         over2 = 0;
         less2 = total[9] + total[10];
     }   
 %>
  <td class=xl73 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><span
  style='mso-spacerun:yes'>   </span> <%= over2 %></td>
  <td class=xl73 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><span
  style='mso-spacerun:yes'>   </span><%= less2 %></td>
 </tr>
 <%
     
     for (int k = 0; k < 11; k++)
         total[k] = 0;     
    flag_total = false;
   }
}
        over1 = 0;
        over2 = 0;
        less1 = 0;
        less2 = 0; 
	%>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl75 colspan=2 style='height:27.0pt;mso-ignore:colspan'>Grand
  total</td>
  <td class=xl77 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>      </span><%= gtotal[0] %> </td>
  <td class=xl77 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>        </span><%= gtotal[1] %> </td>
  <td class=xl77 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= gtotal[2] %> </td>
  <td class=xl77 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= gtotal[3] %> </td>
  <td class=xl77 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= gtotal[4] %> </td>
  <td class=xl77 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= gtotal[5] %> </td>
  <td class=xl77 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%= gtotal[6] %> </td>
  
  <%

     if (gtotal[7] + gtotal[8]>0)
     {
         over1 = gtotal[7] + gtotal[8];
         less1 = 0;
     }
     else
     {
         over1 = 0;
         less1 = gtotal[7] + gtotal[8];
     }   
 %>
  <td class=xl77 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= over1 %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl77 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= less1 %></td>
  
  <%

     if (gtotal[9] + gtotal[10]>0)
     {
         over2 = gtotal[9] + gtotal[10];
         less2 = 0;
     }
     else
     {
         over2 = 0;
         less2 = gtotal[9] + gtotal[10];
     }   
 %>
  <td class=xl77 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><% = over2 %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl77 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%= less2 %></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=33 style='width:25pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=87 style='width:65pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
