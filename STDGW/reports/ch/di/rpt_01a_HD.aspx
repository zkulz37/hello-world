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
    
    string p_times,p_rpt_month;
     
    p_times       = Request["l_times"].ToString();
    p_rpt_month  = Request["l_rpt_month"].ToString();
   string SQL
	= "SELECT A.EMP_ID as c0  " + 
        ",A.FULL_NAME  c1  " +
        ",A.SO_BHXH c2  " +
        ",A.SO_BHYT  c3  " +
        ",DECODE(LENGTH(A.BIRTH_DT),4,A.BIRTH_DT,TO_CHAR(TO_DATE(A.BIRTH_DT,'YYYYMMDD'),'DD/MM/YYYY')) AS NGAYSINH4   " +
        ",DECODE(A.SEX,'F','X','') AS SEXc5  " +
        ",A.SO_CMT c6  " +
        ",TO_CHAR(TO_DATE(A.NGAY_CAP,'YYYYMMDD'),'DD/MM/YYYY') c7  " +
        ",(SELECT CHAR_1 FROM VHR_HR_CODE V WHERE V.ID='HR0014' AND V.CODE=A.TINH_CAP) AS BENHVIEN8  " +
        ",A.NGUYEN_QUAN c9  " +
        ",(SELECT code_fnm FROM VHR_HR_CODE V WHERE V.ID='HR0008' AND V.CODE=A.CHUC_DANH ) c10  " +
        ",A.ADDRESS c11  " +
        ",(SELECT CHAR_1 FROM VHR_HR_CODE V WHERE V.ID='HR0012' AND V.CODE=A.HEALTH_PLACE) AS BENHVIEN12  " +
        ",(SELECT CODE_FNM FROM VHR_HR_CODE V WHERE V.ID='HR0012' AND V.CODE=A.HEALTH_PLACE) AS BENHVIEN13  " +
        ",A.MA_HOP_DONG || '-' ||  TO_CHAR(TO_DATE(A.NGAY_KY_HD,'YYYYMMDD'),'DD/MM/YYYY') AS GHICHU14 " +
        "FROM THR_INSURANCE_MANAGE A " +
        "WHERE A.DEL_IF=0 AND A.THANG_BC='" + p_rpt_month + "' " +
        "AND A.LOAI_BH='01' " +
        "AND A.LAN_BAO='" + p_times + "' " +
        "ORDER BY A.EMP_ID " ;

//Response.Write(SQL);
//Response.End();
    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp=dt_Emp.Columns.Count;
    
     if (irow_emp == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
     
    //getting information of labels 
    SQL
    = "select code_fnm,to_char(sysdate,'dd/mm/yyyy')  " +
        "from vhr_hr_code " +
        "where id='HR0049'  order by code ";
    DataTable dt_name = ESysLib.TableReadOpen(SQL);
    int irow_name;
    irow_name = dt_name.Rows.Count;
    if (irow_name <12)
    {
        Response.Write("You have to input enough information of HR0049 code");
        Response.End();
    }
    %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_01a_HD_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_01a_HD_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_01a_HD_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>User</o:Author>
  <o:LastAuthor>tyml</o:LastAuthor>
  <o:LastPrinted>2009-06-29T04:27:05Z</o:LastPrinted>
  <o:Created>2009-05-18T01:58:31Z</o:Created>
  <o:LastSaved>2009-06-29T04:28:25Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .25in 0in .25in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style16
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:Comma;
	mso-style-id:3;}
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
	{mso-style-parent:style16;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl26
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl37
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;}
.xl38
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl41
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl44
	{mso-style-parent:style16;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl47
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;}
.xl49
	{mso-style-parent:style16;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;}
.xl50
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:top;}
.xl51
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl52
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Scientific;}
.xl53
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl55
	{mso-style-parent:style16;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl56
	{mso-style-parent:style16;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl57
	{mso-style-parent:style16;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;}
.xl58
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl61
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl64
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl65
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl66
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl67
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl68
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl69
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl70
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl71
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>1a</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>90</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>13</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8835</x:WindowHeight>
  <x:WindowWidth>15180</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="7169"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="4"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl27>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1323 style='border-collapse:
 collapse;table-layout:fixed;width:993pt'>
 <col class=xl38 width=36 style='mso-width-source:userset;mso-width-alt:1316;
 width:27pt'>
 <col class=xl38 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl27 width=132 style='mso-width-source:userset;mso-width-alt:4827;
 width:99pt'>
 <col class=xl27 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl27 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl27 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl27 width=32 style='mso-width-source:userset;mso-width-alt:1170;
 width:24pt'>
 <col class=xl27 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl27 width=64 style='width:48pt'>
 <col class=xl27 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl27 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl27 width=64 style='width:48pt'>
 <col class=xl27 width=115 style='mso-width-source:userset;mso-width-alt:4205;
 width:86pt'>
 <col class=xl27 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl27 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl27 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl27 width=64 span=3 style='width:48pt'>
 <tr class=xl45 height=33 style='mso-height-source:userset;height:24.75pt'>
  <td colspan=3 height=33 width=230 style='height:24.75pt;width:173pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s4097" style='position:absolute;
   z-index:1' from="109.5pt,0" to="318.75pt,0" strokecolor="windowText [64]"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s4098" style='position:absolute;z-index:2'
   from="109.5pt,0" to="317.25pt,0" strokecolor="windowText [64]"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s4099" style='position:absolute;flip:y;z-index:3'
   from="111pt,0" to="316.5pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s4104" style='position:absolute;z-index:8'
   from="108.75pt,0" to="151.5pt,0" strokecolor="windowText [64]"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s4105" style='position:absolute;z-index:9'
   from="203.25pt,0" to="318.75pt,0" strokecolor="windowText [64]"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s4106" style='position:absolute;z-index:10'
   from="109.5pt,0" to="231pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s4107" style='position:absolute;z-index:11'
   from="109.5pt,0" to="231pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s4108" style='position:absolute;flip:y;z-index:12'
   from="111pt,0" to="231pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s4113" style='position:absolute;z-index:17'
   from="108.75pt,0" to="151.5pt,0" strokecolor="windowText [64]"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s4114" style='position:absolute;z-index:18'
   from="203.25pt,0" to="231pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s4115" style='position:absolute;z-index:19'
   from="109.5pt,0" to="371.25pt,0" strokecolor="windowText [64]"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
   <x:ClientData ObjectType="Line">
    
   </x:ClientData>
  </v:line><v:line id="_x0000_s4116" style='position:absolute;z-index:20'
   from="109.5pt,0" to="371.25pt,0" strokecolor="windowText [64]"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
   <x:ClientData ObjectType="Line">
    
   </x:ClientData>
  </v:line><v:line id="_x0000_s4117" style='position:absolute;flip:y;z-index:21'
   from="111pt,0" to="371.25pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
   <x:ClientData ObjectType="Line">
    
   </x:ClientData>
  </v:line><v:line id="_x0000_s4122" style='position:absolute;z-index:26'
   from="108.75pt,0" to="152.25pt,0" strokecolor="windowText [64]"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s4123" style='position:absolute;z-index:27'
   from="321pt,0" to="371.25pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
   <x:ClientData ObjectType="Line">
    
   </x:ClientData>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  relative;z-index:1'><span style='position:absolute;left:144px;top:-1px;
  width:352px;height:2px'><img width=352 height=2
  src="rpt_01a_HD_files/image001.gif" v:shapes="_x0000_s4097 _x0000_s4098 _x0000_s4099 _x0000_s4104 _x0000_s4105 _x0000_s4106 _x0000_s4107 _x0000_s4108 _x0000_s4113 _x0000_s4114 _x0000_s4115 _x0000_s4116 _x0000_s4117 _x0000_s4122 _x0000_s4123"></span></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=3 height=33 class=xl69 width=230 style='height:24.75pt;
    width:173pt'>Mã<span
    style='mso-spacerun:yes'>  </span>&#273;&#417;n v&#7883;: <%=dt_name.Rows[1][0].ToString() %><span
    style='mso-spacerun:yes'>               </span></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl69 width=157 style='width:118pt'>Mã
  KCB: <%=dt_name.Rows[11][0].ToString() %><span style='mso-spacerun:yes'> </span></td>
  <td class=xl41 width=76 style='width:57pt'></td>
  <td class=xl44 width=32 style='width:24pt'></td>
  <td class=xl41 width=67 style='width:50pt'></td>
  <td class=xl45 width=64 style='width:48pt'></td>
  <td class=xl24 width=68 style='width:51pt'>DANH SÁCH LAO &#272;&#7896;NG
  &#272;&#7872; NGH&#7882; C&#7844;P S&#7892; BHXH, TH&#7866; BHYT</td>
  <td class=xl45 width=78 style='width:59pt'></td>
  <td class=xl41 width=64 style='width:48pt'></td>
  <td class=xl44 width=115 style='width:86pt'></td>
  <td width=51 style='width:38pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s4100" style='position:absolute;flip:x y;z-index:4' from="38.25pt,0"
   to="80.25pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s4101" style='position:absolute;flip:x;z-index:5'
   from="38.25pt,0" to="80.25pt,0" strokecolor="windowText [64]"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s4102" style='position:absolute;flip:x;z-index:6'
   from="38.25pt,0" to="80.25pt,0" strokecolor="windowText [64]"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s4103" style='position:absolute;flip:x;z-index:7'
   from="38.25pt,0" to="80.25pt,0" strokecolor="windowText [64]"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s4118" style='position:absolute;flip:x y;
   z-index:22' from="38.25pt,0" to="80.25pt,0" strokecolor="windowText [64]"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s4119" style='position:absolute;flip:x;z-index:23'
   from="38.25pt,0" to="80.25pt,0" strokecolor="windowText [64]"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s4120" style='position:absolute;flip:x;z-index:24'
   from="38.25pt,0" to="80.25pt,0" strokecolor="windowText [64]"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s4121" style='position:absolute;flip:x;z-index:25'
   from="38.25pt,0" to="80.25pt,0" strokecolor="windowText [64]"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  relative;z-index:4'><span style='position:absolute;left:50px;top:-1px;
  width:58px;height:2px'><img width=58 height=2
  src="rpt_01a_HD_files/image002.gif" v:shapes="_x0000_s4100 _x0000_s4101 _x0000_s4102 _x0000_s4103 _x0000_s4118 _x0000_s4119 _x0000_s4120 _x0000_s4121"></span></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=33 class=xl44 width=51 style='height:24.75pt;width:38pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl44 width=56 style='width:42pt'></td>
  <td class=xl46 width=73 style='width:55pt'>M&#7851;u s&#7889;: 01a-TBH</td>
  <td width=64 style='width:48pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s4109" style='position:absolute;flip:x y;z-index:13' from="48pt,0"
   to="96pt,0" strokecolor="windowText [64]" strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s4110" style='position:absolute;flip:x;z-index:14'
   from="48pt,0" to="96pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s4111" style='position:absolute;flip:x;z-index:15'
   from="48pt,0" to="96pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s4112" style='position:absolute;flip:x;z-index:16'
   from="48pt,0" to="96pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  relative;z-index:13'><span style='position:absolute;left:63px;top:-1px;
  width:66px;height:2px'><img width=66 height=2
  src="rpt_01a_HD_files/image003.gif" v:shapes="_x0000_s4109 _x0000_s4110 _x0000_s4111 _x0000_s4112"></span></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=33 class=xl45 width=64 style='height:24.75pt;width:48pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl45 width=64 style='width:48pt'></td>
  <td class=xl45 width=64 style='width:48pt'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=3 height=21 class=xl69 style='height:15.75pt' >Tên
  &#273;&#417;n v&#7883;: <%=dt_name.Rows[0][0].ToString() %><span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl48></td>
  <td class=xl49></td>
  <td class=xl27></td>
  <td class=xl26>S&#7889;: 1 Tháng <%=p_rpt_month.Substring(4,2) %> N&#259;m <%=p_rpt_month.Substring(0,4) %></td>
  <td class=xl27></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl49></td>
  <td class=xl50></td>
  <td class=xl25></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl54 height=21 style='height:15.75pt'>
  <td colspan=6 height=21 class=xl70 style='height:15.75pt'>&#272;&#7883;a
  ch&#7881;: <%=dt_name.Rows[2][0].ToString() %></td>
  <td  class=xl52 style='mso-ignore:colspan'></td>
  <td  class=xl51 style='mso-ignore:colspan'></td>
  <td  class=xl53 style='mso-ignore:colspan'></td>
  <td class=xl52></td>
  <td colspan=5 class=xl54 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl42 height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl55 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl56></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl57 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl42 style='mso-ignore:colspan'></td>
  <td class=xl56></td>
  <td colspan=4 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl43 height=34 style='mso-height-source:userset;height:25.5pt'>
  <td rowspan=2 height=72 class=xl28 width=36 style='height:54.0pt;width:27pt'>S&#7889;
  <br>
    TT</td>
  <td rowspan=2 class=xl74 width=62 style='border-bottom:.5pt solid black;
  width:47pt'>Mã S&#7889;</td>
  <td rowspan=2 class=xl28 width=132 style='width:99pt'>H&#7885; và tên</td>
  <td rowspan=2 class=xl28 width=78 style='width:59pt'>S&#7889; s&#7893; BHXH</td>
  <td rowspan=2 class=xl28 width=79 style='width:59pt' x:str="S&#7889; th&#7867; BHYT ">S&#7889;
  th&#7867; BHYT<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl28 width=76 style='width:57pt'>Ngày, tháng, n&#259;m
  sinh</td>
  <td rowspan=2 class=xl28 width=32 style='width:24pt'>N&#7919; <br>
    (X)</td>
  <td colspan=3 class=xl71 width=199 style='border-right:.5pt solid black;
  border-left:none;width:149pt'>S&#7889; ch&#7913;ng minh th&#432;</td>
  <td rowspan=2 class=xl28 width=78 style='width:59pt'>Nguyên quán</td>
  <td rowspan=2 class=xl28 width=64 style='width:48pt'
  x:str="Ch&#7913;c danh công vi&#7879;c ">Ch&#7913;c danh công vi&#7879;c<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl28 width=115 style='width:86pt'>&#272;&#7883;a
  ch&#7881;</td>
  <td colspan=2 class=xl28 width=107 style='border-left:none;width:80pt'>N&#417;i
  &#273;&#259;ng ký KCB ban &#273;&#7847;u (mã s&#7889;)</td>
  <td rowspan=2 class=xl28 width=73 style='width:55pt'>Ghi chú</td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl43 height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl28 width=67 style='height:28.5pt;border-top:none;
  border-left:none;width:50pt'>S&#7889;</td>
  <td class=xl28 width=64 style='border-top:none;border-left:none;width:48pt'>Ngày
  c&#7845;p</td>
  <td class=xl28 width=68 style='border-top:none;border-left:none;width:51pt'>Mã
  T&#7881;nh c&#7845;p</td>
  <td class=xl28 width=51 style='border-top:none;border-left:none;width:38pt'>T&#7881;nh</td>
  <td class=xl58 style='border-top:none;border-left:none'>B&#7879;nh vi&#7879;n</td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
 </tr>
 
 <tr class=xl36 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl59 style='height:18.0pt;border-top:none'>1</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none;border-left:none'>2</td>
  <td class=xl59 style='border-top:none;border-left:none'>3</td>
  <td class=xl59 style='border-top:none;border-left:none'>4</td>
  <td class=xl59 style='border-top:none;border-left:none'>5</td>
  <td class=xl59 style='border-top:none;border-left:none'>6</td>
  <td class=xl59 style='border-top:none;border-left:none'>7</td>
  <td class=xl59 style='border-top:none;border-left:none'>8</td>
  <td class=xl59 style='border-top:none;border-left:none'>9</td>
  <td class=xl59 style='border-top:none;border-left:none'>10</td>
  <td class=xl59 style='border-top:none;border-left:none'>11</td>
  <td class=xl59 style='border-top:none;border-left:none'>12</td>
  <td class=xl59 style='border-top:none;border-left:none'>13</td>
  <td class=xl59 style='border-top:none;border-left:none'>14</td>
  <td class=xl59 style='border-top:none;border-left:none'>15</td>
  <td colspan=3 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <%
    string s_format;
     for(int i=0;i<irow_emp;i++)
    {
        if (i == irow_emp - 1)
            s_format = ";border-bottom:.5pt solid windowtext";
        else
            s_format = ";";
  %>
  <tr class=xl32 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl65 style='height:18.0pt;border-top:none<%=s_format%>' x:num><%=i+1 %></td>
  <td class=xl64 style='border-top:none;border-left:none<%=s_format%>'><%=dt_Emp.Rows[i][0].ToString()%> </td>
  <td class=xl65 style='border-top:none;border-left:none<%=s_format%>'><%=dt_Emp.Rows[i][1].ToString()%> </td>
  <td class=xl65 style='border-top:none;border-left:none<%=s_format%>'><%=dt_Emp.Rows[i][2].ToString()%> </td>
  <td class=xl66 style='border-top:none;border-left:none<%=s_format%>'><%=dt_Emp.Rows[i][3].ToString()%> </td>
  <td class=xl65 style='border-top:none;border-left:none<%=s_format%>'><%=dt_Emp.Rows[i][4].ToString()%> </td>
  <td class=xl65 style='border-top:none;border-left:none<%=s_format%>'><%=dt_Emp.Rows[i][5].ToString()%> </td>
  <td class=xl65 style='border-top:none;border-left:none<%=s_format%>'><%=dt_Emp.Rows[i][6].ToString()%> </td>
  <td class=xl65 style='border-top:none;border-left:none<%=s_format%>'><%=dt_Emp.Rows[i][7].ToString()%> </td>
  <td class=xl67 style='border-top:none;border-left:none<%=s_format%>'><%=dt_Emp.Rows[i][8].ToString()%> </td>
  <td class=xl67 style='border-top:none;border-left:none<%=s_format%>'><%=dt_Emp.Rows[i][9].ToString()%> </td>
  <td class=xl67 style='border-top:none;border-left:none<%=s_format%>'><%=dt_Emp.Rows[i][10].ToString()%> </td>
  <td class=xl67 style='border-top:none;border-left:none<%=s_format%>'><%=dt_Emp.Rows[i][11].ToString()%> </td>
  <td class=xl67 style='border-top:none;border-left:none<%=s_format%>'><%=dt_Emp.Rows[i][12].ToString()%> </td>
  <td class=xl68 style='border-top:none;border-left:none<%=s_format%>' ><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][13].ToString()%> <span style='mso-spacerun:yes'> </span></td>
  <td class=xl68 style='border-top:none;border-left:none<%=s_format%>' ><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][14].ToString()%> <span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl38 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl39 colspan=3 style='mso-ignore:colspan'>* Ph&#7847;n dành cho
  c&#417; quan BHXH ghi:</td>
  <td colspan=14 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl38 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl63 colspan=7 style='mso-ignore:colspan'
  x:str="'- S&#7889; s&#7893; BHXH &#273;&#432;&#7907;c c&#7845;p:................................ s&#7889;, T&#7915; s&#7889;:................................ &#272;&#7871;n s&#7889;:................................">-
  S&#7889; s&#7893; BHXH &#273;&#432;&#7907;c
  c&#7845;p:................................ s&#7889;, T&#7915;
  s&#7889;:................................ &#272;&#7871;n
  s&#7889;:................................</td>
  <td colspan=10 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl38 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl63 colspan=7 style='mso-ignore:colspan'
  x:str="'- S&#7889; th&#7867; BHYT &#273;&#432;&#7907;c c&#7845;p:.............................. th&#7867;, trong &#273;ó c&#7845;p ngo&#7841;i t&#7881;nh:........................................ th&#7867;.">-
  S&#7889; th&#7867; BHYT &#273;&#432;&#7907;c
  c&#7845;p:.............................. th&#7867;, trong &#273;ó c&#7845;p
  ngo&#7841;i t&#7881;nh:........................................ th&#7867;.</td>
  <td colspan=10 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl38 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl27 colspan=7 style='mso-ignore:colspan'
  x:str="'- Th&#7901;i h&#7841;n s&#7917; d&#7909;ng c&#7911;a th&#7867; BHYT: T&#7915; ngày ____/____/_______ &#272;&#7871;n ngày ____/____/_______">-
  Th&#7901;i h&#7841;n s&#7917; d&#7909;ng c&#7911;a th&#7867; BHYT: T&#7915;
  ngày ____/____/_______ &#272;&#7871;n ngày ____/____/_______</td>
  <td colspan=10 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl38 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=17 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl38 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl38>Ngày..... tháng...... n&#259;m..........</td>
  <td colspan=5 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl38>Ngày <%=dt_name.Rows[0][1].ToString().Substring(0,2) %> tháng <%=dt_name.Rows[0][1].ToString().Substring(3,2) %> n&#259;m <%=dt_name.Rows[0][1].ToString().Substring(6,4) %></td>
  <td colspan=5 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl36 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl36>Cán b&#7897; BHXH</td>
  <td colspan=4 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl37 x:str="Giám &#273;&#7889;c BHXH"><span
  style='mso-spacerun:yes'> </span>Giám &#273;&#7889;c BHXH<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl40 colspan=2 style='mso-ignore:colspan'>Ng&#432;&#7901;i
  l&#7853;p bi&#7875;u</td>
  <td class=xl36>Ng&#432;&#7901;i s&#7917; d&#7909;ng lao &#273;&#7897;ng</td>
  <td colspan=5 class=xl40 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl36 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl37></td>
  <td colspan=5 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl36></td>
  <td colspan=5 class=xl40 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl36 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl37></td>
  <td colspan=5 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl36></td>
  <td colspan=5 class=xl40 style='mso-ignore:colspan'></td>
 </tr>
  <tr class=xl40 height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl36 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl37></td>
  <td colspan=5 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl36></td>
  <td colspan=5 class=xl40 style='mso-ignore:colspan'></td>
 </tr>
  <tr class=xl40 height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl36 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl37></td>
  <td colspan=5 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl36></td>
  <td colspan=5 class=xl40 style='mso-ignore:colspan'></td>
 </tr>
  <tr class=xl40 height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl36 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl37></td>
  <td colspan=5 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl36></td>
  <td colspan=5 class=xl40 style='mso-ignore:colspan'></td>
 </tr>
   <tr class=xl40 height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl36 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl36><%=dt_name.Rows[3][0].ToString() %></td>
  <td colspan=4 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl37 x:str><span
  style='mso-spacerun:yes'> </span><%=dt_name.Rows[4][0].ToString() %><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl40 colspan=2 style='mso-ignore:colspan'><%=dt_name.Rows[5][0].ToString() %></td>
  <td class=xl36><%=dt_name.Rows[6][0].ToString() %></td>
  <td colspan=5 class=xl40 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=36 style='width:27pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=132 style='width:99pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
