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
    string p_work_mon;
           p_work_mon = Request.QueryString["l_work_mon"].ToString();  
    
    

           string SQL
           = "select code_knm,sum(Male1),sum(Female1),sum(Sum1),sum(MaleHCM1),sum(FemaleHCM1),sum(MaleNOTHCM1),sum(FemaleNOTHCM1)  " +
               "                            ,sum(Male2),sum(Female2),sum(Sum2),sum(MaleHCM2),sum(FemaleHCM2),sum(MaleNOTHCM2),sum(FemaleNOTHCM2)  " +
               "                            ,sum(Male3),sum(Female3),sum(Sum3),sum(MaleHCM3),sum(FemaleHCM3),sum(MaleNOTHCM3),sum(FemaleNOTHCM3) " +
               " from (  " +
               "select a.CODE_KNM, sum( case when e.JOB_TYPE= a.CODE and nvl(E.SEX,'F')='M' then 1 else 0 end) as Male1,  " +
               "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.SEX,'F')='F' then 1 else 0 end) as Female1,  " +
               "        sum( case when e.JOB_TYPE= a.CODE then 1 else 0 end) as Sum1,  " +
               "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.PLACE_PER_ID,0)=33 and nvl(E.SEX,'F')='M' then 1 else 0 end) MaleHCM1,  " +
               "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.PLACE_PER_ID,0)=33 and nvl(E.SEX,'F')='F' then 1 else 0 end) FemaleHCM1,  " +
               "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.PLACE_PER_ID,0)!=33 and nvl(E.SEX,'F')='M' then 1 else 0 end) MaleNOTHCM1,  " +
               "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.PLACE_PER_ID,0)!=33 and nvl(E.SEX,'F')='F' then 1 else 0 end) FemaleNOTHCM1,  " +
               "        0 as Male2,0 as Female2,0 as Sum2,0 as MaleHCM2,0 as FemaleHCM2,0 as MaleNOTHCM2,0 as FemaleNOTHCM2, " +
               "        0 as Male3,0 as Female3,0 as Sum3,0 as MaleHCM3,0 as FemaleHCM3,0 as MaleNOTHCM3,0 as FemaleNOTHCM3  " +
               "from thr_employee e, vhr_hr_code a   " +
               "where e.del_if=0 and a.ID='HR0010' and substr(E.JOIN_DT,1,6) between '190001' and '" + p_work_mon + "'  and nvl(A.NUM_1,0)=1   " +
               "and substr(nvl(E.LEFT_DT,'30000101'),1,6) > '" + p_work_mon + "'  " +
               "group by  a.code_knm   " +
               "union all  " +
               "select a.CODE_KNM,   " +
               "        0 as Male1,0 as Female1,0 as Sum1,0 as MaleHCM1,0 as FemaleHCM1,0 as MaleNOTHCM1,0 as FemaleNOTHCM1,  " +
               "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.SEX,'F')='M' then 1 else 0 end) as Male2,  " +
               "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.SEX,'F')='F' then 1 else 0 end) as Female2,  " +
               "        sum( case when e.JOB_TYPE= a.CODE then 1 else 0 end) as Sum2,  " +
               "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.PLACE_PER_ID,0)=33 and nvl(E.SEX,'F')='M' then 1 else 0 end) MaleHCM2,  " +
               "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.PLACE_PER_ID,0)=33 and nvl(E.SEX,'F')='F' then 1 else 0 end) FemaleHCM2,  " +
               "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.PLACE_PER_ID,0)!=33 and nvl(E.SEX,'F')='M' then 1 else 0 end) MaleNOTHCM2,  " +
               "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.PLACE_PER_ID,0)!=33 and nvl(E.SEX,'F')='F' then 1 else 0 end) FemaleNOTHCM2 , " +
               "         0 as Male3,0 as Female3,0 as Sum3,0 as MaleHCM3,0 as FemaleHCM3,0 as MaleNOTHCM3,0 as FemaleNOTHCM3 " +
               "from thr_employee e, vhr_hr_code a   " +
               "where e.del_if=0 and a.ID='HR0010' and substr(E.JOIN_DT,1,6) = '" + p_work_mon + "'  and nvl(A.NUM_1,0)=1   " +
               "group by  a.code_knm  " +
               "union all  " +
               "select a.CODE_KNM,   " +
               "        0 as Male1,0 as Female1,0 as Sum1,0 as MaleHCM1,0 as FemaleHCM1,0 as MaleNOTHCM1,0 as FemaleNOTHCM1, " +
               "        0 as Male2,0 as Female2,0 as Sum2,0 as MaleHCM2,0 as FemaleHCM2,0 as MaleNOTHCM2,0 as FemaleNOTHCM2,  " +
               "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.SEX,'F')='M' then 1 else 0 end) as Male3,  " +
               "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.SEX,'F')='F' then 1 else 0 end) as Female3,  " +
               "        sum( case when e.JOB_TYPE= a.CODE then 1 else 0 end) as Sum3,  " +
               "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.PLACE_PER_ID,0)=33 and nvl(E.SEX,'F')='M' then 1 else 0 end) MaleHCM3,  " +
               "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.PLACE_PER_ID,0)=33 and nvl(E.SEX,'F')='F' then 1 else 0 end) FemaleHCM3,  " +
               "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.PLACE_PER_ID,0)!=33 and nvl(E.SEX,'F')='M' then 1 else 0 end) MaleNOTHCM3,  " +
               "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.PLACE_PER_ID,0)!=33 and nvl(E.SEX,'F')='F' then 1 else 0 end) FemaleNOTHCM3  " +
               "from thr_employee e, vhr_hr_code a   " +
               "where e.del_if=0 and a.ID='HR0010' and substr(E.LEFT_DT ,1,6) = '" + p_work_mon + "'  and nvl(A.NUM_1,0)=1   " +
               "group by  a.code_knm " +
               ")  " +
               "group by code_knm  ";


    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp, icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp = dt_Emp.Columns.Count;
    if (irow_emp == 0)
    {
        Response.Write("There is no data of salary");
        Response.End();
    }


    

    string SQL2
    = "select sum(Male1),sum(Female1),sum(Sum1),sum(MaleHCM1),sum(FemaleHCM1),sum(MaleNOTHCM1),sum(FemaleNOTHCM1)  " +
        "                            ,sum(Male2),sum(Female2),sum(Sum2),sum(MaleHCM2),sum(FemaleHCM2),sum(MaleNOTHCM2),sum(FemaleNOTHCM2) " +
        "                            ,sum(Male3),sum(Female3),sum(Sum3),sum(MaleHCM3),sum(FemaleHCM3),sum(MaleNOTHCM3),sum(FemaleNOTHCM3)  " +
        "                            ,to_char(sysdate,'dd'),to_char(sysdate,'mm'), to_char(sysdate,'yyyy')  " +
        " from (  " +
        "select sum( case when e.JOB_TYPE= a.CODE and nvl(E.SEX,'F')='M' then 1 else 0 end) as Male1,  " +
        "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.SEX,'F')='F' then 1 else 0 end) as Female1,  " +
        "        sum( case when e.JOB_TYPE= a.CODE then 1 else 0 end) as Sum1,  " +
        "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.PLACE_PER_ID,0)=33 and nvl(E.SEX,'F')='M' then 1 else 0 end) MaleHCM1,  " +
        "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.PLACE_PER_ID,0)=33 and nvl(E.SEX,'F')='F' then 1 else 0 end) FemaleHCM1,  " +
        "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.PLACE_PER_ID,0)!=33 and nvl(E.SEX,'F')='M' then 1 else 0 end) MaleNOTHCM1,  " +
        "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.PLACE_PER_ID,0)!=33 and nvl(E.SEX,'F')='F' then 1 else 0 end) FemaleNOTHCM1,  " +
        "        0 as Male2,0 as Female2,0 as Sum2,0 as MaleHCM2,0 as FemaleHCM2,0 as MaleNOTHCM2,0 as FemaleNOTHCM2 , " +
        "        0 as Male3,0 as Female3,0 as Sum3,0 as MaleHCM3,0 as FemaleHCM3,0 as MaleNOTHCM3,0 as FemaleNOTHCM3  " +
        "from thr_employee e, vhr_hr_code a   " +
        "where e.del_if=0 and a.ID='HR0010' and substr(E.JOIN_DT,1,6) between '190001' and '" + p_work_mon + "'  and nvl(A.NUM_1,0)=0   " +
        "and substr(nvl(E.LEFT_DT,'30000101'),1,6) > '" + p_work_mon + "'  " +
        "union all  " +
        "select  0 as Male1,0 as Female1,0 as Sum1,0 as MaleHCM1,0 as FemaleHCM1,0 as MaleNOTHCM1,0 as FemaleNOTHCM1,  " +
        "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.SEX,'F')='M' then 1 else 0 end) as Male2,  " +
        "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.SEX,'F')='F' then 1 else 0 end) as Female2,  " +
        "        sum( case when e.JOB_TYPE= a.CODE then 1 else 0 end) as Sum2,  " +
        "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.PLACE_PER_ID,0)=33 and nvl(E.SEX,'F')='M' then 1 else 0 end) MaleHCM2,  " +
        "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.PLACE_PER_ID,0)=33 and nvl(E.SEX,'F')='F' then 1 else 0 end) FemaleHCM2,  " +
        "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.PLACE_PER_ID,0)!=33 and nvl(E.SEX,'F')='M' then 1 else 0 end) MaleNOTHCM2,  " +
        "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.PLACE_PER_ID,0)!=33 and nvl(E.SEX,'F')='F' then 1 else 0 end) FemaleNOTHCM2 , " +
        "        0 as Male3,0 as Female3,0 as Sum3,0 as MaleHCM3,0 as FemaleHCM3,0 as MaleNOTHCM3,0 as FemaleNOTHCM3 " +
        "from thr_employee e, vhr_hr_code a   " +
        "where e.del_if=0 and a.ID='HR0010' and substr(E.JOIN_DT,1,6) = '" + p_work_mon + "'  and nvl(A.NUM_1,0)=0   " +
        "and substr(nvl(E.LEFT_DT,'30000101'),1,6) > '" + p_work_mon + "' " +
        "union all  " +
        "select  0 as Male1,0 as Female1,0 as Sum1,0 as MaleHCM1,0 as FemaleHCM1,0 as MaleNOTHCM1,0 as FemaleNOTHCM1,   " +
        "        0 as Male2,0 as Female2,0 as Sum2,0 as MaleHCM2,0 as FemaleHCM2,0 as MaleNOTHCM2,0 as FemaleNOTHCM2 , " +
        "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.SEX,'F')='M' then 1 else 0 end) as Male3,  " +
        "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.SEX,'F')='F' then 1 else 0 end) as Female3,  " +
        "        sum( case when e.JOB_TYPE= a.CODE then 1 else 0 end) as Sum3,  " +
        "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.PLACE_PER_ID,0)=33 and nvl(E.SEX,'F')='M' then 1 else 0 end) MaleHCM3,  " +
        "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.PLACE_PER_ID,0)=33 and nvl(E.SEX,'F')='F' then 1 else 0 end) FemaleHCM3,  " +
        "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.PLACE_PER_ID,0)!=33 and nvl(E.SEX,'F')='M' then 1 else 0 end) MaleNOTHCM3,  " +
        "        sum( case when e.JOB_TYPE= a.CODE and nvl(E.PLACE_PER_ID,0)!=33 and nvl(E.SEX,'F')='F' then 1 else 0 end) FemaleNOTHCM3  " +
        "from thr_employee e, vhr_hr_code a   " +
        "where e.del_if=0 and a.ID='HR0010' and substr(E.LEFT_DT ,1,6) = '" + p_work_mon + "'  and nvl(A.NUM_1,0)=0   " +
        ") ";


    DataTable dt_Emp2 = ESysLib.TableReadOpen(SQL2);
    

 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="nhanlucSBGear_files/filelist.xml">
<link rel=Edit-Time-Data href="nhanlucSBGear_files/editdata.mso">
<link rel=OLE-Object-Data href="nhanlucSBGear_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>nhut_k</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2010-10-21T06:58:08Z</o:LastPrinted>
  <o:Created>2010-07-16T04:17:27Z</o:Created>
  <o:LastSaved>2010-10-22T01:29:23Z</o:LastSaved>
  <o:Company>AS</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
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
	font-family:Arial, sans-serif;
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
	font-size:11.0pt;}
.xl66
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:center;
	border:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	font-size:11.0pt;
	border:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	border:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	font-size:11.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:center;}
.xl72
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	text-align:center;}
.xl73
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	border:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>20</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11505</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=596 style='border-collapse:
 collapse;table-layout:fixed;width:449pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=81 span=6 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl65 colspan=2 width=191 style='height:14.25pt;
  mso-ignore:colspan;width:144pt'>CTY TNHH SBGEAR VINA</td>
  <td colspan=4 class=xl65 width=81 style='width:61pt'></td>
  <td colspan=4 class=xl71 width=324 style='width:244pt'>C&#7896;NG HÒA XÃ
  H&#7896;I CH&#360; NGH&#296;A VI&#7878;T NAM</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl65 colspan=3 style='height:14.25pt;mso-ignore:colspan'>88D
  DƯƠNG CÔNG KHI, ẤP 6</td>
  <td colspan=3 class=xl65 width=81 style='width:61pt'></td>
  <td colspan=4 class=xl71>&#272;&#7897;c L&#7853;p - T&#7921; Do - H&#7841;nh
  Phúc</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl65 colspan=3 style='height:14.25pt;mso-ignore:colspan'>XÃ
  XUÂN THỚI SƠN, HÓC MÔN, TP. HCM</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='height:25.5pt;mso-xlrowspan:2'>
  <td height=34 colspan=7 style='height:25.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=10 height=27 class=xl72 style='height:20.25pt'>BÁO CÁO TÌNH HÌNH
  NHÂN L&#7920;C</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=10 height=24 class=xl71 style='height:18.0pt'>Tháng: <%=p_work_mon.Substring(4,2) %>/<%=p_work_mon.Substring(0,4) %></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=7 style='height:18.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=7 style='height:18.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td rowspan=2 height=48 class=xl77 style='border-bottom:.5pt solid black;
  height:36.0pt'>&nbsp;</td>
  <td colspan=3 class=xl73 style='border-right:.5pt solid black;border-left:
  none'>T&#7893;ng s&#7889; nhân l&#7921;c</td>
  <td colspan=3 class=xl76 style='border-left:none'>Nhân l&#7921;c t&#259;ng
  trong tháng</td>
  <td colspan=3 class=xl76 style='border-left:none'>Nhân l&#7921;c giảm
  trong tháng</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl66 style='height:18.0pt;border-top:none;border-left:
  none' x:str="Nam ">Nam<span style='mso-spacerun:yes'> </span></td>
  <td class=xl66 style='border-top:none;border-left:none'>N&#7919;</td>
  <td class=xl66 style='border-top:none;border-left:none'>T&#7893;ng</td>
  <td class=xl66 style='border-top:none;border-left:none' x:str="Nam ">Nam<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl66 style='border-top:none;border-left:none'>N&#7919;</td>
  <td class=xl66 style='border-top:none;border-left:none'>T&#7893;ng</td>
  <td class=xl66 style='border-top:none;border-left:none' x:str="Nam ">Nam<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl66 style='border-top:none;border-left:none'>N&#7919;</td>
  <td class=xl66 style='border-top:none;border-left:none'>T&#7893;ng</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl67 style='height:18.0pt;border-top:none'>V&#259;n phòng</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_Emp2.Rows[0][0].ToString() %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_Emp2.Rows[0][1].ToString() %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%= dt_Emp2.Rows[0][2].ToString() %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_Emp2.Rows[0][7].ToString() %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_Emp2.Rows[0][8].ToString() %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_Emp2.Rows[0][9].ToString() %> </td>
  
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_Emp2.Rows[0][14].ToString() %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_Emp2.Rows[0][15].ToString() %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_Emp2.Rows[0][16].ToString() %> </td>
 </tr>
 <%
     double[] total = new double[21];
     for (int i = 0; i < 21; i++)
         total[i] = 0;
     
     for (int i = 0; i < irow_emp; i++)
     {
         for(int j=1;j<icol_emp;j++)
             
            total[j-1] += Double.Parse(dt_Emp.Rows[i][j].ToString());
  %>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl67 style='height:18.0pt;border-top:none'><%= dt_Emp.Rows[i][0].ToString() %></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_Emp.Rows[i][1].ToString() %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_Emp.Rows[i][2].ToString() %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_Emp.Rows[i][3].ToString() %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_Emp.Rows[i][8].ToString() %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_Emp.Rows[i][9].ToString() %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_Emp.Rows[i][10].ToString() %> </td>
  
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_Emp.Rows[i][15].ToString() %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_Emp.Rows[i][16].ToString() %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_Emp.Rows[i][17].ToString() %> </td>
 </tr>
 <%} %>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl67 style='height:18.0pt;border-top:none'
  x:str="Trong t&#7881;nh ">Trong t&#7881;nh<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[3]+ Double.Parse(dt_Emp2.Rows[0][3].ToString()) %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[4]+ Double.Parse(dt_Emp2.Rows[0][4].ToString()) %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%= total[3] + Double.Parse(dt_Emp2.Rows[0][3].ToString()) + total[4] + Double.Parse(dt_Emp2.Rows[0][4].ToString())%> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[10]+ Double.Parse(dt_Emp2.Rows[0][10].ToString()) %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[11]+ Double.Parse(dt_Emp2.Rows[0][11].ToString()) %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[10] + Double.Parse(dt_Emp2.Rows[0][10].ToString()) + total[11] + Double.Parse(dt_Emp2.Rows[0][11].ToString())%> </td>
  
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[17]+ Double.Parse(dt_Emp2.Rows[0][17].ToString()) %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[18]+ Double.Parse(dt_Emp2.Rows[0][18].ToString()) %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[17] + Double.Parse(dt_Emp2.Rows[0][17].ToString()) + total[18] + Double.Parse(dt_Emp2.Rows[0][18].ToString())%> </td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl67 style='height:18.0pt;border-top:none'>Ngo&#7841;i
  t&#7881;nh</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[5]+ Double.Parse(dt_Emp2.Rows[0][5].ToString()) %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[6]+ Double.Parse(dt_Emp2.Rows[0][6].ToString()) %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[5] + Double.Parse(dt_Emp2.Rows[0][5].ToString()) + total[6] + Double.Parse(dt_Emp2.Rows[0][6].ToString())%> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[12] + Double.Parse(dt_Emp2.Rows[0][12].ToString()) %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[13] + Double.Parse(dt_Emp2.Rows[0][13].ToString()) %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[12] + Double.Parse(dt_Emp2.Rows[0][12].ToString()) + total[13] + Double.Parse(dt_Emp2.Rows[0][13].ToString())%> </td>
  
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[19] + Double.Parse(dt_Emp2.Rows[0][19].ToString()) %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[20] + Double.Parse(dt_Emp2.Rows[0][20].ToString()) %> </td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[19] + Double.Parse(dt_Emp2.Rows[0][19].ToString()) + total[20] + Double.Parse(dt_Emp2.Rows[0][20].ToString())%> </td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl68 style='height:18.0pt;border-top:none'>T&#7893;ng
  c&#7897;ng:</td>
  <td class=xl70 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[3] + Double.Parse(dt_Emp2.Rows[0][3].ToString()) + total[5] + Double.Parse(dt_Emp2.Rows[0][5].ToString())%> </td>
  <td class=xl70 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[4] + Double.Parse(dt_Emp2.Rows[0][4].ToString()) + total[6] + Double.Parse(dt_Emp2.Rows[0][6].ToString())%> </td>
  <td class=xl70 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%= total[3] + Double.Parse(dt_Emp2.Rows[0][3].ToString()) + total[5] + Double.Parse(dt_Emp2.Rows[0][5].ToString()) + total[4] + Double.Parse(dt_Emp2.Rows[0][4].ToString()) + total[6] + Double.Parse(dt_Emp2.Rows[0][6].ToString())%> </td>
  <td class=xl70 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[10] + Double.Parse(dt_Emp2.Rows[0][10].ToString()) + total[12] + Double.Parse(dt_Emp2.Rows[0][12].ToString())%> </td>
  <td class=xl70 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[11] + Double.Parse(dt_Emp2.Rows[0][11].ToString()) + total[13] + Double.Parse(dt_Emp2.Rows[0][13].ToString())%> </td>
  <td class=xl70 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%= total[10] + Double.Parse(dt_Emp2.Rows[0][10].ToString()) + total[11] + Double.Parse(dt_Emp2.Rows[0][11].ToString())+ total[12] + Double.Parse(dt_Emp2.Rows[0][12].ToString()) + total[13] + Double.Parse(dt_Emp2.Rows[0][13].ToString())%> </td>
  
  <td class=xl70 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[17] + Double.Parse(dt_Emp2.Rows[0][17].ToString()) + total[19] + Double.Parse(dt_Emp2.Rows[0][19].ToString())%> </td>
  <td class=xl70 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[18] + Double.Parse(dt_Emp2.Rows[0][18].ToString()) + total[20] + Double.Parse(dt_Emp2.Rows[0][20].ToString())%> </td>
  <td class=xl70 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%= total[17] + Double.Parse(dt_Emp2.Rows[0][17].ToString()) + total[18] + Double.Parse(dt_Emp2.Rows[0][18].ToString())+ total[19] + Double.Parse(dt_Emp2.Rows[0][19].ToString()) + total[20] + Double.Parse(dt_Emp2.Rows[0][20].ToString())%> </td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=7 class=xl65 style='height:18.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=4 class=xl65 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl71>Tp. HCM, ngày <%= dt_Emp2.Rows[0][21].ToString() %> tháng <%= dt_Emp2.Rows[0][22].ToString() %> n&#259;m <%= dt_Emp2.Rows[0][23].ToString() %></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=4 class=xl65 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl71>Ng&#432;&#7901;i báo cáo</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=7 class=xl65 style='height:18.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=7 class=xl65 style='height:18.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=7 class=xl65 style='height:18.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=4 class=xl65 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl71></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=7 class=xl65 style='height:18.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl65 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl65 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl65 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl65 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl65 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl65 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl65 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl65 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl65 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl65 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl65 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl65 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl65 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl65 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl65 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl65 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl65 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl65 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=110 style='width:83pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=81 style='width:61pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
