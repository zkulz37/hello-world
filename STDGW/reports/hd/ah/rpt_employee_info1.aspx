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
    string p_dept=Request.QueryString[0] ;
    string p_dept_nm=Request.QueryString[1] ;
    string p_from=Request.QueryString[2] ;
    string p_to=Request.QueryString[3];
    string p_typeDT=Request.QueryString[4];
    
    string sql_gen_info
    = "SELECT MAX(HR.TOTAL),MAX(HR.new_staff),MAX(HR.resign),MAX(HR.maternity) " + 
        "        FROM " +
        "        ( " +
        "        SELECT count(*) as TOTAL,0 as new_staff,0 as resign, 0 as maternity " +
        "        FROM THR_EMPLOYEE A " +
        "        WHERE A.DEL_IF=0 AND A.JOIN_DT <= '" + p_to + "' " +
        "        AND (A.LEFT_DT IS NULL OR A.LEFT_DT>'" + p_to + "') " +
        "        AND (a.tco_dept_pk IN (SELECT g.pk " +
        "                                FROM comm.tco_dept g " +
        "                                WHERE g.del_if = 0 AND NVL (g.child_yn, 'Y') = 'N' " +
        "                                START WITH g.pk =DECODE ('" +p_dept +"','ALL', 0,'" + p_dept + "') " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '"+ p_dept + "' = 'ALL') " +
        "        union all " +
        "        SELECT 0 as TOTAL,count(*) as new_staff,0 as resign, 0 as maternity " +
        "        FROM THR_EMPLOYEE A " +
        "        WHERE A.DEL_IF=0 AND A.JOIN_DT BETWEEN '" + p_from + "' AND '" + p_to + "' " +
        "        AND (A.LEFT_DT IS NULL OR A.LEFT_DT>'" + p_to + "') " +
        "         AND (a.tco_dept_pk IN (SELECT g.pk " +
        "                                FROM comm.tco_dept g " +
        "                                WHERE g.del_if = 0 AND NVL (g.child_yn, 'Y') = 'N' " +
        "                                START WITH g.pk =DECODE ('" + p_dept + "','ALL', 0,'" + p_dept + "') " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_dept + "' = 'ALL') " +
        "        union all " +
        "        SELECT 0 as TOTAL,0 as new_staff,COUNT(*) as resign, 0 as maternity " +
        "        FROM THR_EMPLOYEE A " +
        "        WHERE A.DEL_IF=0 AND A.JOIN_DT<='" + p_to + "' " +
        "        AND A.LEFT_DT IS NOT NULL " +
        "        AND A.LEFT_DT BETWEEN '" + p_from + "' AND '" + p_to + "' " +
        "        AND A.STATUS='R' " +
        "         AND (a.tco_dept_pk IN (SELECT g.pk " +
        "                                FROM comm.tco_dept g " +
        "                                WHERE g.del_if = 0 AND NVL (g.child_yn, 'Y') = 'N' " +
        "                                START WITH g.pk =DECODE ('" + p_dept + "','ALL', 0,'" + p_dept + "') " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_dept + "' = 'ALL') " +
        "        union all " +
        "        SELECT 0 as TOTAL,0 as new_staff,0 as resign, COUNT(*) as maternity " +
        "        FROM THR_EMPLOYEE A,THR_ABSENCE_REG B " +
        "        WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND A.PK=B.THR_EMP_PK " +
        "        AND A.JOIN_DT<='" + p_to + "' " +
        "        AND (A.LEFT_DT IS NULL OR A.LEFT_DT>'" + p_to + "') " +
        "        AND B.ABSENCE_TYPE='04' " +
        "        AND (B.START_DT BETWEEN '" + p_from + "' AND '" + p_to + "' " +
        "            OR B.END_DT BETWEEN '" + p_from + "' AND '" + p_to + "') " +
        "         AND (A.tco_dept_pk IN (SELECT g.pk " +
        "                                FROM comm.tco_dept g " +
        "                                WHERE g.del_if = 0 AND NVL (g.child_yn, 'Y') = 'N' " +
        "                                START WITH g.pk =DECODE('" + p_dept + "','ALL', 0,'" +p_dept + "') " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_dept + "' = 'ALL')    )HR " ;
        
        
        //Response.Write(sql_gen_info);
        //Response.End();
        
        DataTable dt_gen_info = ESysLib.TableReadOpen(sql_gen_info);
        
        if (dt_gen_info.Rows.Count == 0)
        {
            Response.Write("There is no data to show");
            Response.End();
        }     
        
           
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_employee_info_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_employee_info_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_employee_info_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Thu Hien</o:Author>
  <o:LastAuthor>Thu Hien</o:LastAuthor>
  <o:LastPrinted>2008-11-20T06:27:14Z</o:LastPrinted>
  <o:Created>2008-11-19T09:31:00Z</o:Created>
  <o:LastSaved>2008-11-20T07:10:11Z</o:LastSaved>
  <o:Company>Vina Genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .5in 1.0in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-horizontal-page-align:center;}
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
	mso-number-format:"Medium Date";}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	color:red;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	text-align:right;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl40
	{mso-style-parent:style0;
	font-size:14.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:14.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
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
       <x:ActiveRow>16</x:ActiveRow>
       <x:RangeSelection>$A$17:$B$17</x:RangeSelection>
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
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1110 style='border-collapse:
 collapse;table-layout:fixed;width:833pt'>
 <col width=101 style='mso-width-source:userset;mso-width-alt:3693;width:76pt'>
 <col width=111 style='mso-width-source:userset;mso-width-alt:4059;width:83pt'>
 <col width=113 style='mso-width-source:userset;mso-width-alt:4132;width:85pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=109 style='mso-width-source:userset;mso-width-alt:3986;width:82pt'>
 <col width=103 style='mso-width-source:userset;mso-width-alt:3766;width:77pt'>
 <col width=108 style='mso-width-source:userset;mso-width-alt:3949;width:81pt'>
 <col width=99 style='mso-width-source:userset;mso-width-alt:3620;width:74pt'>
 <col width=112 style='mso-width-source:userset;mso-width-alt:4096;width:84pt'>
 <col width=80 style='mso-width-source:userset;mso-width-alt:2925;width:60pt'>
 <col width=64 style='width:48pt'>
 <col width=63 style='mso-width-source:userset;mso-width-alt:2304;width:47pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 width=101 style='height:12.75pt;width:76pt'>Year:</td>
  <td align=right width=111 style='width:83pt' x:num>2008</td>
  <td width=113 style='width:85pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=109 style='width:82pt'>Reporter:</td>
  <td class=xl38 width=103 style='width:77pt'>Hien</td>
  <td width=108 style='width:81pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=112 style='width:84pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'>Month:</td>
  <td class=xl39>December</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td>Reporter:</td>
  <td class=xl38>Hien</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'>From: 20-Nov-08</td>
  <td class=xl38></td>
  <td class=xl24>To: 12/20/2008</td>
  <td></td>
  <td>Reporter:</td>
  <td class=xl38>Hien</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt' x:str="Date: ">Date:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl24 align=right x:num="39772">20-Nov-08</td>
  <td class=xl24></td>
  <td></td>
  <td>Reporter:</td>
  <td class=xl38>Hien</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'>Department:</td>
  <td class=xl25>ACCOUNTING</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td>Report date:</td>
  <td class=xl24 align=right x:num="39772">20-Nov-08</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl32 style='height:15.75pt'>CURRENT EMP</td>
  <td colspan=2 class=xl32 style='border-left:none' x:str="NEW EMP ">NEW
  EMP<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl32 style='border-left:none'>RESIGN EMP</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl40 style='border-right:.5pt solid black;
  height:18.75pt' x:num><%=dt_gen_info.Rows[0][0].ToString() %></td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dt_gen_info.Rows[0][1].ToString() %></td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dt_gen_info.Rows[0][0].ToString() %></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl29 colspan=2 style='height:12.75pt;mso-ignore:colspan'>Sumary
  Information</td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl33 style='height:15.75pt'>Probation</td>
  <td class=xl33 style='border-left:none'>Regular</td>
  <td class=xl33 style='border-left:none'>Discipline</td>
  <td class=xl33 style='border-left:none'>Under 18</td>
  <td class=xl33 style='border-left:none'>Male</td>
  <td class=xl33 style='border-left:none'>Female</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl27 align=right style='height:18.75pt;border-top:none'
  x:num>1</td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl28 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'>                         </span>- </td>
  <td class=xl28 style='border-top:none;border-left:none' x:num="10"><span
  style='mso-spacerun:yes'>                     </span>10 </td>
  <td class=xl28 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'>                        </span>- </td>
  <td class=xl28 style='border-top:none;border-left:none' x:num="25"><span
  style='mso-spacerun:yes'>                    </span>25 </td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl29 colspan=2 style='height:15.0pt;mso-ignore:colspan'>Sumary
  by department</td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=2 height=26 class=xl34 style='border-right:.5pt solid black;
  height:19.5pt'>Department</td>
  <td class=xl36 style='border-left:none'>Male</td>
  <td class=xl36>Female</td>
  <td colspan=2 class=xl34>Total</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=2 height=27 class=xl51 style='border-right:.5pt solid black;
  height:20.25pt'>SEWING F1</td>
  <td class=xl42 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'>                         </span>- </td>
  <td class=xl42 style='border-top:none;border-left:none' x:num="2"><span
  style='mso-spacerun:yes'>                       </span>2 </td>
  <td colspan=2 class=xl43 style='border-right:.5pt solid black;border-left:
  none' x:num="0"><span
  style='mso-spacerun:yes'>                                                
  </span>- </td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl53 style='border-right:.5pt solid black;
  height:18.75pt'>HR</td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num>3</td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none' x:num="4"><span
  style='mso-spacerun:yes'>                                                
  </span>4 </td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=2 height=28 class=xl53 style='border-right:.5pt solid black;
  height:21.0pt'>PACKING F1</td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num>5</td>
  <td colspan=2 class=xl47 style='border-right:.5pt solid black;border-left:
  none' x:num="6"><span
  style='mso-spacerun:yes'>                                                
  </span>6 </td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl53 style='border-right:.5pt solid black;
  height:18.0pt'>CUTTING</td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num>6</td>
  <td colspan=2 class=xl47 style='border-right:.5pt solid black;border-left:
  none' x:num="7"><span
  style='mso-spacerun:yes'>                                                
  </span>7 </td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=2 height=26 class=xl53 style='border-right:.5pt solid black;
  height:19.5pt'>FINISHING</td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num>7</td>
  <td colspan=2 class=xl47 style='border-right:.5pt solid black;border-left:
  none' x:num="8"><span
  style='mso-spacerun:yes'>                                                
  </span>8 </td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=2 height=27 class=xl53 style='border-right:.5pt solid black;
  height:20.25pt'>HR</td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num>8</td>
  <td colspan=2 class=xl47 style='border-right:.5pt solid black;border-left:
  none' x:num="9"><span
  style='mso-spacerun:yes'>                                                
  </span>9 </td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=2 height=26 class=xl55 style='border-right:.5pt solid black;
  height:19.5pt'>ACCOUNTING</td>
  <td class=xl31 align=right style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl31 align=right style='border-top:none;border-left:none' x:num>9</td>
  <td colspan=2 class=xl49 style='border-right:.5pt solid black;border-left:
  none' x:num="10"><span
  style='mso-spacerun:yes'>                                              
  </span>10 </td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl29 colspan=2 style='height:13.5pt;mso-ignore:colspan'>Sumary
  by position</td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=2 height=26 class=xl34 style='border-right:.5pt solid black;
  height:19.5pt'>Position</td>
  <td class=xl33 style='border-left:none'>Male</td>
  <td class=xl33 style='border-left:none'>Female</td>
  <td colspan=2 class=xl34 style='border-right:.5pt solid black;border-left:
  none'>Total</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl51 style='border-right:.5pt solid black;
  height:18.75pt'>Manager</td>
  <td class=xl42 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'>                         </span>- </td>
  <td class=xl42 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'>                        </span>- </td>
  <td colspan=2 class=xl43 style='border-right:.5pt solid black;border-left:
  none' x:num="8"><span
  style='mso-spacerun:yes'>                                                
  </span>8 </td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl57 style='height:18.75pt'>Worker</td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num>3</td>
  <td colspan=2 class=xl47 style='border-right:.5pt solid black;border-left:
  none' x:num="5"><span
  style='mso-spacerun:yes'>                                                
  </span>5 </td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl58 style='height:18.75pt'>Perchangsing</td>
  <td class=xl31 align=right style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl31 align=right style='border-top:none;border-left:none' x:num>5</td>
  <td colspan=2 class=xl49 style='border-right:.5pt solid black;border-left:
  none' x:num="9"><span
  style='mso-spacerun:yes'>                                                
  </span>9 </td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl29 colspan=2 style='height:12.75pt;mso-ignore:colspan'>Sumary
  by Seniority</td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl33 style='height:15.75pt'>&lt;1 (Year)</td>
  <td class=xl33 style='border-left:none'>1 to &lt; 2 (Year)</td>
  <td class=xl33 style='border-left:none'>2 to &lt;3 (Year)</td>
  <td class=xl33 style='border-left:none'>3 to 4 (Year)</td>
  <td class=xl33 style='border-left:none'>4 to &lt; 5 (Year)</td>
  <td class=xl33 style='border-left:none'>&lt; 5 (Year)</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl27 align=right style='height:19.5pt;border-top:none'
  x:num>1</td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl28 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'>                      </span>- </td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=101 style='width:76pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=112 style='width:84pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
