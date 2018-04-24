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
    string p_emp_type,p_work_mon,p_mon,p_from,p_to;
    
    p_emp_type = Request["l_emp_type"].ToString();
    p_work_mon = Request["l_work_mon"].ToString();  
    p_mon = p_work_mon.Substring(4, 2).ToString();
    p_to=p_work_mon;
    if (p_mon=="06")
        p_from=p_work_mon.Substring(0, 4).ToString() + "01";
    else if (p_mon=="12")
        p_from=p_work_mon.Substring(0, 4).ToString() + "07";
    else
        p_from=p_to;
    string SQL
	= "select sum(case when substr(a.join_dt,1,6) < '" + p_from + "' and (a.LEFT_DT is null or substr(a.left_dt,1,6) >= '" + p_from + "') then 1 else 0 end) as c0 " + 
        " ,sum(case when substr(a.join_dt,1,6) < '" + p_from + "'  and (a.LEFT_DT is null or substr(a.left_dt,1,6) >= '" + p_from + "') and nvl(a.SEX,'0')='F' then 1 else 0 end) as c1 " +
        " ,sum(case when substr(a.join_dt,1,6) >= '" + p_from + "' and substr(a.join_dt,1,6) <='" + p_to + "'  then 1 else 0 end) as c2 " +
        " ,sum(case when substr(a.join_dt,1,6) >= '" + p_from + "' and substr(a.join_dt,1,6) <='" + p_to + "' and nvl(a.SEX,'0')='F' then 1 else 0 end) as c3 " +
        " ,sum(case when substr(a.left_dt,1,6) >= '" + p_from + "' and substr(a.left_dt,1,6) <='" + p_to + "' and a.join_dt <='" + p_to + "'  then 1 else 0 end) as c4 " +
        " ,sum(case when substr(a.left_dt,1,6) >= '" + p_from + "' and substr(a.left_dt,1,6) <='" + p_to + "' and a.join_dt <='" + p_to + "'  and nvl(a.SEX,'0')='F' then 1 else 0 end) as c5 " +
        " ,sum(case when substr(a.join_dt,1,6) <='" + p_to + "' and (a.LEFT_DT is null or substr(a.left_dt,1,6) > '" + p_to + "') then 1 else 0 end) as c6 " +
        " ,sum(case when substr(a.join_dt,1,6) <='" + p_to + "'  and (a.LEFT_DT is null or substr(a.left_dt,1,6) > '" + p_to + "') and nvl(a.SEX,'0')='F' then 1 else 0 end) as c7 " +
        " ,sum(case when substr(a.join_dt,1,6) <='" + p_to + "' and (a.LEFT_DT is null or substr(a.left_dt,1,6) > '" + p_to + "') and nvl(birth_p.num_1,0)=0 then 1 else 0 end) as c8   " +
        " ,sum(case when substr(a.join_dt,1,6) <='" + p_to + "' and (a.LEFT_DT is null or substr(a.left_dt,1,6) > '" + p_to + "') and contract_t.num_5 =1 then 1 else 0 end) as c9 " +
        " ,sum(case when substr(a.join_dt,1,6) <='" + p_to + "' and (a.LEFT_DT is null or substr(a.left_dt,1,6) > '" + p_to + "') and contract_t.num_5 =1 and nvl(a.SEX,'0')='F' then 1 else 0 end) as c10 " +
        " ,sum(case when substr(a.join_dt,1,6) <='" + p_to + "' and (a.LEFT_DT is null or substr(a.left_dt,1,6) > '" + p_to + "') and contract_t.num_5 =2 then 1 else 0 end) as c11 " +
        " ,sum(case when substr(a.join_dt,1,6) <='" + p_to + "' and (a.LEFT_DT is null or substr(a.left_dt,1,6) > '" + p_to + "') and contract_t.num_5 =2 and nvl(a.SEX,'0')='F' then 1 else 0 end) as c12 " +
        " ,sum(case when substr(a.join_dt,1,6) <='" + p_to + "' and (a.LEFT_DT is null or substr(a.left_dt,1,6) > '" + p_to + "') and contract_t.num_5 =3 then 1 else 0 end) as c13 " +
        " ,sum(case when substr(a.join_dt,1,6) <='" + p_to + "' and (a.LEFT_DT is null or substr(a.left_dt,1,6) > '" + p_to + "') and contract_t.num_5 =3 and nvl(a.SEX,'0')='F' then 1 else 0 end) as c14 " +
        " ,sum(case when substr(a.join_dt,1,6) <='" + p_to + "' and (a.LEFT_DT is null or substr(a.left_dt,1,6) > '" + p_to + "') and edu_t.num_1 in (5,6,7) then 1 else 0 end) as c15 " +
        " ,sum(case when substr(a.join_dt,1,6) <='" + p_to + "' and (a.LEFT_DT is null or substr(a.left_dt,1,6) > '" + p_to + "') and edu_t.num_1 in (4) then 1 else 0 end) as c16 " +
        " ,sum(case when substr(a.join_dt,1,6) <='" + p_to + "' and (a.LEFT_DT is null or substr(a.left_dt,1,6) > '" + p_to + "') and edu_t.num_1 in (1,2,3) then 1 else 0 end) as c17 " +
        " from thr_employee a " +
        " ,(select code,num_1 from vhr_hr_code b where b.id='HR0021') birth_p " +
        " ,(select code,num_5 from vhr_hr_code b where b.id='HR0001') contract_t " +
        " ,(select code,num_1 from vhr_hr_code b where b.id='HR0011') edu_t " +
        "where a.del_if=0 " +
        "and decode('" + p_emp_type + "','ALL','ALL',a.employee_type)='" + p_emp_type + "' " +
        "and a.PLACE_BIRTH=birth_p.code(+) " +
        "and a.contract_type=contract_t.code(+) " +
        "and a.edu_type=edu_t.code(+) " ;



//Response.Write(SQL);
//Response.End();
    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt_total.Rows.Count;
    if (irow == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    //-----------------information of company-----------------
    string SQL_Com
	= "select  a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,a.TCO_BPPHOTO_PK,to_char(to_date('" + p_work_mon + "','yyyymm'),'MON-YYYY') " + 
        "from tco_company a " +
        "where a.DEL_IF=0 " +
        "and a.pk in ( select tco_company_pk from  " +
        "               comm.tco_dept  f " +
        "               where  f.pk IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM comm.tco_dept g " +
        "                                   WHERE g.del_if = 0 )) " +
        "and rownum=1 " ;

    //Response.Write(SQL_Com);
    //Response.End();
    DataTable dt_Com = ESysLib.TableReadOpen(SQL_Com);
    int irow_com;
    irow_com = dt_Com.Rows.Count;
    if (irow_com == 0)
    {
        Response.Write("There is no data of company");
        Response.End();
    }
    
 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_labor_using_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_labor_using_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_labor_using_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Yen</o:Author>
  <o:LastAuthor>tyml</o:LastAuthor>
  <o:LastPrinted>2009-06-16T05:48:16Z</o:LastPrinted>
  <o:Created>2006-08-16T21:34:19Z</o:Created>
  <o:LastSaved>2009-06-16T05:49:10Z</o:LastSaved>
  <o:Company>VinaGenuWin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.92in .25in .32in .62in;
	mso-header-margin:.5in;
	mso-footer-margin:.33in;}
.font9
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font10
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font12
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font13
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl27
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl28
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl35
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl48
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl49
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl59
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl60
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
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
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveCol>10</x:ActiveCol>
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
  <x:WindowHeight>9075</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1410</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=645 style='border-collapse:
 collapse;table-layout:fixed;width:485pt'>
 <col class=xl25 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <col class=xl24 width=57 style='mso-width-source:userset;mso-width-alt:2084;
 width:43pt'>
 <col class=xl24 width=64 span=4 style='width:48pt'>
 <col class=xl24 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl24 width=134 style='mso-width-source:userset;mso-width-alt:4900;
 width:101pt'>
 <col class=xl24 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 width=39 style='height:15.75pt;width:29pt'></td>
  <td class=xl24 width=57 style='width:43pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=65 style='width:49pt'></td>
  <td class=xl24 width=134 style='width:101pt'></td>
  <td class=xl26 width=94 style='width:71pt'>M&#7851;u s&#7889; 1</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl60 colspan=4 style='height:16.5pt;mso-ignore:colspan'>Tên
  &#273;&#417;n v&#7883;:<span style='mso-spacerun:yes'>   </span><%=dt_Com.Rows[0][0].ToString()%></td>
  <td class=xl24></td>
  <td colspan=4 class=xl47>C&#7896;NG HÒA XÃ H&#7896;I CH&#7910; NGH&#296;A
  VI&#7878;T NAM</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl60 colspan=2 style='height:16.5pt;mso-ignore:colspan'>&#272;&#7883;a
  ch&#7881;: <%=dt_Com.Rows[0][1].ToString()%></td>
  <td class=xl28></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl58>&#272;&#7897;c l&#7853;p - T&#7921; do - H&#7841;nh phúc</td>
  <td class=xl29></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl60 colspan=3 style='height:18.75pt;mso-ignore:colspan'>Tel:<span
  style='mso-spacerun:yes'>      </span><%=dt_Com.Rows[0][2].ToString()%></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl59 x:str="'-------------">-------------</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25>&#272;&#7891;ng Nai, <font class="font10">ngày <%=DateTime.Today.Day.ToString() %> tháng <%=DateTime.Today.Month.ToString() %> 
  n&#259;m <%=DateTime.Today.Year.ToString() %></font></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td colspan=9 height=22 class=xl48 style='height:16.5pt'>BÁO CÁO TÌNH HÌNH
  S&#7916; D&#7908;NG LAO &#272;&#7896;NG 6 THÁNG &#272;&#7846;U N&#258;M
  (HO&#7862;C N&#258;M) …</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td colspan=9 height=22 class=xl48 style='height:16.5pt'>VÀ D&#7920;
  KI&#7870;N TUY&#7874;N D&#7908;NG LAO &#272;&#7896;NG 6 THÁNG CU&#7888;I
  N&#258;M (HO&#7862;C N&#258;M) …</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30 colspan=5 style='mso-ignore:colspan'>Kính g&#7917;i<font
  class="font12"> :</font><font class="font13"> </font><font class="font9">Ban
  Qu&#7843;n lý các KCN &#272;&#7891;ng Nai</font></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl31 width=39 style='height:18.75pt;width:29pt'>Stt</td>
  <td colspan=6 class=xl49 width=378 style='border-right:.5pt solid black;
  border-left:none;width:284pt'>N&#7897;i dung</td>
  <td class=xl32 width=134 style='width:101pt'>S&#7889; l&#432;&#7907;ng</td>
  <td class=xl32 width=94 style='width:71pt'>Ghi chú</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt'>I</td>
  <td colspan=6 class=xl44 style='border-right:.5pt solid black;border-left:
  none'>T&#7893;ng s&#7889; Lao &#273;&#7897;ng có m&#7863;t &#273;&#7847;u
  k&#7923; báo cáo:</td>
  <td class=xl55 x:num><% = dt_total.Rows[0][0].ToString()%></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt'>&nbsp;</td>
  <td colspan=6 class=xl44 style='border-right:.5pt solid black;border-left:
  none'>Trong &#273;ó n&#7919;:</td>
  <td class=xl55 x:num><% = dt_total.Rows[0][1].ToString()%></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt'>II</td>
  <td colspan=6 class=xl44 style='border-right:.5pt solid black;border-left:
  none'>S&#7889; lao &#273;&#7897;ng t&#259;ng, gi&#7843;m trong k&#7923;:</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt' x:num>1</td>
  <td colspan=6 class=xl44 style='border-right:.5pt solid black;border-left:
  none'>S&#7889; lao &#273;&#7897;ng t&#259;ng trong k&#7923;:</td>
  <td class=xl55 x:num><% = dt_total.Rows[0][2].ToString()%></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt'>&nbsp;</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Trong &#273;ó n&#7919;:</td>
  <td class=xl55 x:num><% = dt_total.Rows[0][3].ToString()%></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt' x:num>2</td>
  <td colspan=6 class=xl44 style='border-right:.5pt solid black;border-left:
  none'>S&#7889; lao &#273;&#7897;ng gi&#7843;m trong k&#7923;:</td>
  <td class=xl55 x:num><% = dt_total.Rows[0][4].ToString()%></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt'>&nbsp;</td>
  <td colspan=6 class=xl44 style='border-right:.5pt solid black;border-left:
  none' x:str="'-Trong &#273;ó n&#7919;:">-Trong &#273;ó n&#7919;:</td>
  <td class=xl55 x:num><% = dt_total.Rows[0][5].ToString()%></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt'>a</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Ngh&#7881; h&#432;&#7903;ng ch&#7871; &#273;&#7897; h&#432;u trí:</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt'>&nbsp;</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none' x:str="'-Trong &#273;ó n&#7919;:">-Trong &#273;ó n&#7919;:</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt'>b</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Thôi vi&#7879;c, m&#7845;t vi&#7879;c làm:</td>
  <td class=xl55 x:num><% = dt_total.Rows[0][4].ToString()%></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt'>&nbsp;</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none' x:str="'-Trong &#273;ó n&#7919;:">-Trong &#273;ó n&#7919;:</td>
  <td class=xl55 x:num><% = dt_total.Rows[0][5].ToString()%></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt'>c</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Sa th&#7843;i do k&#7927; lu&#7853;t lao &#273;&#7897;ng:</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt'>&nbsp;</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none' x:str="'-Trong &#273;ó n&#7919;:">-Trong &#273;ó n&#7919;:</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt'>d</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Lý do khác:</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt'>&nbsp;</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none' x:str="'-Trong &#273;ó n&#7919;:">-Trong &#273;ó n&#7919;:</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt'>III</td>
  <td colspan=6 class=xl44 style='border-right:.5pt solid black;border-left:
  none'>T&#7893;ng s&#7889; Lao &#273;&#7897;ng có m&#7863;t cu&#7889;i
  k&#7923;:</td>
  <td class=xl55 x:num><% = dt_total.Rows[0][6].ToString()%></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt'>&nbsp;</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Trong &#273;ó, Lao &#273;&#7897;ng n&#7919;:</td>
  <td class=xl55 x:num><% = dt_total.Rows[0][7].ToString()%></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt'>&nbsp;</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'><span style='mso-spacerun:yes'>                 </span>Lao
  &#273;&#7897;ng ngo&#7841;i t&#7881;nh:</td>
  <td class=xl55 x:num><% = dt_total.Rows[0][8].ToString()%></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt' x:num>1</td>
  <td colspan=6 class=xl44 style='border-right:.5pt solid black;border-left:
  none'>Phân theo H&#272;L&#272;:</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl37 style='height:16.5pt'>a</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>S&#7889; ng&#432;&#7901;i ký H&#272;L&#272; không xác &#273;&#7883;nh
  th&#7901;i h&#7841;n:</td>
  <td class=xl55 x:num><% = dt_total.Rows[0][9].ToString()%></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl37 style='height:16.5pt'>&nbsp;</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Trong &#273;ó n&#7919;:</td>
  <td class=xl55 x:num><% = dt_total.Rows[0][10].ToString()%></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl37 style='height:16.5pt'>b</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>S&#7889; ng&#432;&#7901;i ký H&#272;L&#272; xác &#273;&#7883;nh
  th&#7901;i h&#7841;n t&#7915; 1-3 n&#259;m:</td>
  <td class=xl55 x:num><% = dt_total.Rows[0][11].ToString()%></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl37 style='height:16.5pt'>&nbsp;</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Trong &#273;ó n&#7919;:</td>
  <td class=xl55 x:num><% = dt_total.Rows[0][12].ToString()%></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl37 style='height:16.5pt'>c</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>S&#7889; ng&#432;&#7901;i ký H&#272;L&#272; d&#432;&#7899;i 1 n&#259;m:</td>
  <td class=xl55 x:num><% = dt_total.Rows[0][13].ToString()%></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl37 style='height:16.5pt'>&nbsp;</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Trong &#273;ó n&#7919;:</td>
  <td class=xl55 x:num><% = dt_total.Rows[0][14].ToString()%></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt' x:num>2</td>
  <td colspan=6 class=xl44 style='border-right:.5pt solid black;border-left:
  none'>Trình &#273;&#7897; lao &#273;&#7897;ng:</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl37 style='height:16.5pt'>a</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>&#272;&#7841;i h&#7885;c, Cao &#273;&#7859;ng:</td>
  <td class=xl55 x:num><% = dt_total.Rows[0][15].ToString()%></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=43 style='mso-height-source:userset;height:32.25pt'>
  <td height=43 class=xl57 style='height:32.25pt'>b</td>
  <td colspan=6 class=xl51 width=378 style='border-right:.5pt solid black;
  border-left:none;width:284pt'>Công nhân K&#7929; thu&#7853;t, trung c&#7845;p
  ngh&#7873; (k&#7875; c&#7843; công nhân &#273;&#432;&#7907;c &#273;ào
  t&#7841;o t&#7841;i Công ty):</td>
  <td class=xl55 x:num><% = dt_total.Rows[0][16].ToString()%></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl37 style='height:16.5pt'>c</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Lao &#273;&#7897;ng ph&#7893; thông:</td>
  <td class=xl55 x:num><% = dt_total.Rows[0][17].ToString()%></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl38 style='height:16.5pt;border-top:none'>IV</td>
  <td colspan=6 class=xl44 style='border-right:.5pt solid black;border-left:
  none'>Thu nh&#7853;p c&#7911;a lao &#273;&#7897;ng</td>
  <td class=xl56 style='border-top:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt' x:num>1</td>
  <td colspan=6 class=xl44 style='border-right:.5pt solid black;border-left:
  none'>L&#432;&#417;ng</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl37 style='height:16.5pt'>a</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>M&#7913;c cao nh&#7845;t:</td>
  <td class=xl55></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl37 style='height:16.5pt'>b</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>M&#7913;c th&#7845;p nh&#7845;t:</td>
  <td class=xl55></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl37 style='height:16.5pt'>c</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Trung bình:</td>
  <td class=xl55></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt' x:num>2</td>
  <td colspan=6 class=xl44 style='border-right:.5pt solid black;border-left:
  none'>Các kho&#7843;n khác (ph&#7909; c&#7845;p &#273;i l&#7841;i, nhà
  &#7903;…)</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl38 style='height:16.5pt;border-top:none'>V</td>
  <td colspan=6 class=xl44 style='border-right:.5pt solid black;border-left:
  none'>D&#7921; ki&#7871;n tuy&#7875;n lao &#273;&#7897;ng c&#7911;a k&#7923;
  sau</td>
  <td class=xl56 style='border-top:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt'>&nbsp;</td>
  <td colspan=6 class=xl44 style='border-right:.5pt solid black;border-left:
  none'>T&#7893;ng s&#7889;:</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl37 style='height:16.5pt'>&nbsp;</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Trong &#273;ó n&#7919;:</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt' x:num>1</td>
  <td colspan=6 class=xl44 style='border-right:.5pt solid black;border-left:
  none'>Phân theo H&#272;L&#272;:</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl37 style='height:16.5pt'>a</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>S&#7889; ng&#432;&#7901;i ký H&#272;L&#272; không xác &#273;&#7883;nh
  th&#7901;i h&#7841;n:</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl37 style='height:16.5pt'>&nbsp;</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Trong &#273;ó n&#7919;:</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl37 style='height:16.5pt'>b</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>S&#7889; ng&#432;&#7901;i ký H&#272;L&#272; xác &#273;&#7883;nh
  th&#7901;i h&#7841;n t&#7915; 1-3 n&#259;m:</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl37 style='height:16.5pt'>&nbsp;</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Trong &#273;ó n&#7919;:</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl37 style='height:16.5pt'>c</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>S&#7889; ng&#432;&#7901;i ký H&#272;L&#272; d&#432;&#7899;i 1 n&#259;m:</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl37 style='height:16.5pt'>&nbsp;</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Trong &#273;ó n&#7919;:</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt' x:num>2</td>
  <td colspan=6 class=xl44 style='border-right:.5pt solid black;border-left:
  none'>Trình &#273;&#7897; yêu c&#7847;u:</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl37 style='height:16.5pt'>a</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>&#272;&#7841;i h&#7885;c, Cao &#273;&#7859;ng:</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl37 style='height:16.5pt'>b</td>
  <td colspan=6 class=xl51 width=378 style='border-right:.5pt solid black;
  border-left:none;width:284pt'>Công nhân K&#7929; thu&#7853;t:</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl37 style='height:16.5pt'>c</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Lao &#273;&#7897;ng ph&#7893; thông:</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt' x:num>3</td>
  <td colspan=6 class=xl44 style='border-right:.5pt solid black;border-left:
  none'>Hình th&#7913;c tuy&#7875;n:</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl37 style='height:16.5pt'>a</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>T&#7921; tuy&#7875;n:</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl37 style='height:16.5pt'>b</td>
  <td colspan=6 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Thông qua t&#7893; ch&#7913;c gi&#7899;i thi&#7879;u vi&#7879;c làm:</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl27 style='height:16.5pt'></td>
  <td colspan=6 class=xl43>&nbsp;</td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl27 style='height:16.5pt'></td>
  <td colspan=6 class=xl28></td>
  <td colspan=2 class=xl27>GIÁM &#272;&#7888;C CÔNG TY</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl27 style='height:16.5pt'></td>
  <td colspan=6 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27>(Ký tên, &#273;óng d&#7845;u)</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl27 style='height:16.5pt'></td>
  <td colspan=8 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=39 style='width:29pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=134 style='width:101pt'></td>
  <td width=94 style='width:71pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
