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
    string emp_pk;
    
    emp_pk       = Request["emp_pk"].ToString();
    string SQL = " select  " 
        + "a.FULL_NAME  "//0
        + ",decode(nvl(a.sex,'0'),'M',(case when length(a.BIRTH_DT)>4 then to_char(to_date(a.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy') else substr(a.BIRTH_DT,1,4) end),'') as Male " //1
        + ",decode(nvl(a.sex,'0'),'F',(case when length(a.BIRTH_DT)>4 then to_char(to_date(a.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy') else substr(a.BIRTH_DT,1,4) end),'') as FeMale " //1
        + ",a.PERMANENT_ADDR " //3
        + ",e.reason " //4
        + ",a.emp_id " //5
        + " from thr_employee a,thr_ins_modify e"
        + " where a.del_if=0 and e.del_if=0 and e.thr_emp_pk =a.pk "
       + " and e.pk in (" + emp_pk + ") " ;
        
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
    //getting employeer
    SQL
    = "select code_nm " +
        "from vhr_hr_code " +
        "where id='HR0049' order by code  ";
    DataTable dt_name = ESysLib.TableReadOpen(SQL);
    int irow_name;
    irow_name = dt_name.Rows.Count;
 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_04_sbh_hyosung_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_04_sbh_hyosung_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_04_sbh_hyosung_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ms lan</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-11-11T08:29:10Z</o:LastPrinted>
  <o:Created>2011-01-12T06:11:19Z</o:Created>
  <o:LastSaved>2011-11-11T08:31:54Z</o:LastSaved>
  <o:Company>vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\,";
	mso-displayed-thousand-separator:"\.";}
@page
	{margin:0in .12in 0in .12in;
	mso-header-margin:.31in;
	mso-footer-margin:.31in;}
.font5
	{color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font8
	{color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font12
	{color:windowtext;
	font-size:14.0pt;
	font-weight:400;
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
.xl65
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl67
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl68
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl69
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl70
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl71
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl72
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl77
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;}
.xl80
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl82
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl84
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmm\\-yy";}
.xl85
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl86
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmm\\-yy";
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl89
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl90
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl91
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl92
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl93
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl94
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl95
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl96
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl97
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl99
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl100
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl101
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:normal;}
.xl102
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>04_SBH</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>375</x:DefaultRowHeight>
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
       <x:ActiveRow>26</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7680</x:WindowHeight>
  <x:WindowWidth>14715</x:WindowWidth>
  <x:WindowTopX>600</x:WindowTopX>
  <x:WindowTopY>525</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='04_SBH'!$A$17:$H$19</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="24577"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl68>

<table x:str border=0 cellpadding=0 cellspacing=0 width=885 style='border-collapse:
 collapse;table-layout:fixed;width:664pt'>
 <col class=xl68 width=31 style='mso-width-source:userset;mso-width-alt:1133;
 width:23pt'>
 <col class=xl68 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:2523'>
 <col class=xl68 width=144 style='mso-width-source:userset;mso-width-alt:5266;
 width:108pt'>
 <col class=xl68 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 <col class=xl68 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl68 width=257 style='mso-width-source:userset;mso-width-alt:9398;
 width:193pt'>
 <col class=xl68 width=173 style='mso-width-source:userset;mso-width-alt:6326;
 width:130pt'>
 <col class=xl68 width=107 style='mso-width-source:userset;mso-width-alt:3913;
 width:80pt'>
 <col class=xl68 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl68 width=31 style='height:18.75pt;width:23pt'></td>
  <td class=xl68 width=0></td>
  <td class=xl68 width=144 style='width:108pt'></td>
  <td class=xl68 width=85 style='width:64pt'></td>
  <td class=xl68 width=88 style='width:66pt'></td>
  <td class=xl68 width=257 style='width:193pt'></td>
  <td class=xl67 width=173 style='width:130pt'>M&#7851;u s&#7889;: 04/SBH</td>
  <td class=xl68 width=107 style='width:80pt'></td>
 </tr>
 <tr height=28 style='height:21.0pt'>
  <td height=28 class=xl65 colspan=3 style='height:21.0pt;mso-ignore:colspan'>&#272;&#416;N
  V&#7882;:</td>
  <td colspan=2 class=xl67 style='mso-ignore:colspan'></td>
  <td class=xl68></td>
  <td class=xl67></td>
  <td class=xl68></td>
 </tr>
 <tr height=26 style='height:19.5pt'>
  <td height=26 colspan=2 class=xl71 style='height:19.5pt;mso-ignore:colspan'></td>
  <td class=xl65 colspan=3 style='mso-ignore:colspan'>Công ty TNHH Hyosung
  Vi&#7879;t Nam</td>
  <td class=xl68></td>
  <td class=xl68>M&#272;V: YN0098K</td>
  <td class=xl68></td>
 </tr>
 <tr height=26 style='height:19.5pt'>
  <td height=26 colspan=2 class=xl71 style='height:19.5pt;mso-ignore:colspan'></td>
  <td class=xl65 colspan=4 style='mso-ignore:colspan'>&#272;&#432;&#7901;ng N2,
  KCN Nh&#417;n Tr&#7841;ch 5, &#272;&#7891;ng Nai</td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='height:19.5pt'>
  <td height=26 colspan=2 class=xl71 style='height:19.5pt;mso-ignore:colspan'></td>
  <td class=xl65 colspan=2 style='mso-ignore:colspan'>&#272;T: 0613 569 445 ~
  474</td>
  <td class=xl65></td>
  <td colspan=3 class=xl68 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td colspan=7 height=25 class=xl93 style='height:18.75pt'>C&#7897;ng Hòa Xã
  H&#7897;i Ch&#7911; Ngh&#297;a Vi&#7879;t Nam</td>
  <td class=xl68></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td colspan=7 height=25 class=xl93 style='height:18.75pt'>&#272;&#7897;c
  L&#7853;p - T&#7921; Do - H&#7841;nh Phúc</td>
  <td class=xl68></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=8 class=xl68 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td colspan=6 height=25 class=xl70 style='height:18.75pt'>Kính g&#7917;i:
  BHXH T&#7881;nh &#272;&#7891;ng Nai</td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=7 class=xl70 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl68></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td colspan=7 height=25 class=xl93 style='height:18.75pt'>DANH SÁCH
  &#272;&#7872; NGH&#7882; C&#7844;P S&#7892; BHXH CHO NG&#431;&#7900;I LAO
  &#272;&#7896;NG K&#7922; TR&#431;&#7898;C</td>
  <td class=xl68></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl71 style='height:18.75pt'></td>
  <td class=xl68></td>
  <td colspan=6 class=xl68 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='height:19.5pt'>
  <td colspan=7 height=26 class=xl70 style='height:19.5pt'>Tên &#273;&#417;n
  v&#7883;: <font class="font5">Hyosung Vi&#7879;t Nam</font><font
  class="font12"><span style='mso-spacerun:yes'>  </span></font><font
  class="font8"><span style='mso-spacerun:yes'> </span>Mã &#273;&#417;n
  v&#7883;:………..</font></td>
  <td class=xl68></td>
 </tr>
 <tr height=26 style='height:19.5pt'>
  <td colspan=7 height=26 class=xl70 style='height:19.5pt'>&#272;&#7883;a
  ch&#7881;: <font class="font5">&#272;&#432;&#7901;ng N2, KCN Nh&#417;n
  Tr&#7841;ch 5, &#272;&#7891;ng Nai</font></td>
  <td class=xl68></td>
 </tr>
 <tr height=26 style='height:19.5pt'>
  <td colspan=7 height=26 class=xl70 style='height:19.5pt'>&#272;i&#7879;n
  tho&#7841;i: <font class="font5">0613 569 445</font><font class="font8"><span
  style='mso-spacerun:yes'>   </span>Fax: </font><font class="font5">0613 569
  230</font><font class="font8"><span style='mso-spacerun:yes'>    
  </span>Email:……………</font></td>
  <td class=xl68></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 colspan=8 class=xl68 style='height:12.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=52 style='mso-height-source:userset;height:39.0pt'>
  <td rowspan=2 height=84 class=xl94 width=31 style='border-bottom:2.0pt double black;
  height:63.0pt;width:23pt'>STT</td>
  <td class=xl72 width=0>&nbsp;</td>
  <td rowspan=2 class=xl72 width=144 style='border-bottom:2.0pt double black;
  width:108pt'>H&#7885; và tên</td>
  <td colspan=2 class=xl96 width=173 style='width:130pt'>Ngày tháng n&#259;m
  sinh</td>
  <td rowspan=2 class=xl98 width=257 style='border-bottom:2.0pt double black;
  width:193pt'>N&#417;i c&#432; trú (Th&#432;&#7901;ng trú ho&#7863;c t&#7841;m
  trú)</td>
  <td rowspan=2 class=xl100 width=173 style='border-bottom:2.0pt double black;
  width:130pt'>Ghi chú</td>
  <td class=xl68></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl73 width=0 style='height:24.0pt;border-top:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none'>Nam</td>
  <td class=xl75 style='border-top:none;border-left:none'>N&#7919;</td>
  <td class=xl68></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl76 style='height:20.25pt;border-top:none' x:num>1</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl77 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl77 style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl77 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl78 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl68></td>
 </tr>

<% 
     int count=0;
    for (int i = 0; i < irow; i++)
    {
       count++;
    %>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl79 style='height:20.25pt' x:num><%= count %></td>
  <td class=xl80 style='border-left:none'><%=dt_total.Rows[i][5].ToString()%></td>
  <td class=xl80 style='border-left:none'><%=dt_total.Rows[i][0].ToString()%></td>
  <td class=xl81 style='border-left:none'><%=dt_total.Rows[i][1].ToString()%></td>
  <td class=xl81 style='border-left:none'><%=dt_total.Rows[i][2].ToString()%></td>
  <td class=xl82 style='border-left:none'><%=dt_total.Rows[i][3].ToString()%></td>
  <td class=xl83><%=dt_total.Rows[i][4].ToString()%></td>
  <td class=xl84></td>
 </tr>
 <%} %>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl85 style='height:21.75pt'>&nbsp;</td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl69 style='border-left:none'>&nbsp;</td>
  <td class=xl69 style='border-left:none'>&nbsp;</td>
  <td class=xl69 style='border-left:none'>&nbsp;</td>
  <td class=xl69 style='border-left:none'>&nbsp;</td>
  <td class=xl87 width=173 style='border-top:none;border-left:none;width:130pt'>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
 </tr>
 <tr height=26 style='height:19.5pt'>
  <td height=26 colspan=8 class=xl68 style='height:19.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl68 style='height:18.75pt'></td>
  <td colspan=4 class=xl70>Ngày <%= DateTime.Today.Day%> tháng <%= DateTime.Today.Month%> n&#259;m <%= DateTime.Today.Year%></td>
  <td colspan=2 class=xl102>Ngày …. tháng .... n&#259;m ……</td>
  <td class=xl68></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=2 class=xl68 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl89>NG&#431;&#7900;I L&#7852;P BI&#7874;U</td>
  <td class=xl71></td>
  <td class=xl89>GIÁM &#272;&#7888;C</td>
  <td class=xl68></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=2 class=xl68 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl91>(Ký, ghi rõ h&#7885; tên)</td>
  <td class=xl90></td>
  <td class=xl91>(Ký tên, &#273;óng d&#7845;u)</td>
  <td class=xl68></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=8 class=xl68 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=8 class=xl68 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=8 class=xl68 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=8 class=xl68 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=6 class=xl68 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl92>NOH YUN JEONG</td>
  <td class=xl68></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=6 class=xl68 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl92></td>
  <td class=xl68></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=31 style='width:23pt'></td>
  <td width=0></td>
  <td width=144 style='width:108pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=257 style='width:193pt'></td>
  <td width=173 style='width:130pt'></td>
  <td width=107 style='width:80pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
