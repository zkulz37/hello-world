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
    string p_mon = Request.QueryString["p_mon"].ToString();

    string SQL_Com
    = "select v.CODE_NM " +
        "from vhr_hr_code v " +
        "where v.ID='HR0049' ";
    
    DataTable dt_com = ESysLib.TableReadOpen(SQL_Com);
    if (dt_com.Rows.Count == 0)
    {
        Response.Write("There is no data of regulation to show");
        Response.End();            
    }
    //Response.Write(p_mon.Insert(4, "-") + "-01");
    //Response.End();
    string SQL_Sum
  = "select count(*),nvl(sum(decode(b.sex,'F',1,0)),0),nvl(sum(luong_cb),0)  " +
      "from thr_insurance_month a,thr_employee b " +
      "where a.del_if=0 and b.del_if=0 and a.thr_emp_pk=b.pk " +
      "and a.work_mon='" + p_mon + "' and nvl(b.SOCIAL_YN,'N')='Y' ";
    double dtotal_lb = 0, dtotal_lb_femail = 0, dtotal_sal = 0;
    DataTable dt_sum = ESysLib.TableReadOpen(SQL_Sum);
    if (dt_sum.Rows.Count != 0)
    {
        dtotal_lb = double.Parse(dt_sum.Rows[0][0].ToString());
        dtotal_lb_femail = double.Parse(dt_sum.Rows[0][1].ToString());
        dtotal_sal = double.Parse(dt_sum.Rows[0][2].ToString());
    }
    string SQL
    = "select v.CODE_NM, ti.FULL_NAME, ti.SOCIAL_NO, ti.CONDITION, round(nvl(ti.AVERAGE_SALARY,0),0) " +
        "    ,to_char(to_date(ti.ST_SOCIAL_DT,'yyyymm'),'mm-yyyy'),ti.DAYS, ti.PROGRESSIVE  " +
        "    ,round(ti.INS_AMT,0),to_char(to_date(ti.FROM_DT,'yyyymmdd'),'dd/mm/yyyy'),"+
        "    to_char(to_date(ti.TO_DT,'yyyymmdd'),'dd/mm/yyyy'), ti.REMARK, v.NUM_1 " +
        "from THR_INS_REGULATION ti, vhr_hr_code v  " +
        "where ti.DEL_IF=0 " +
        "and ti.INS_MONTH='"+p_mon+"' " +
        "and v.ID='HR0055' " +
        "and ti.INS_REG_TYPE='01' " +
        "and v.CODE=ti.DETAIL_INS_REG_TYPE " +
        "order by v.NUM_1 , ti.FULL_NAME,ti.from_dt ";

    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
    if(dt_emp.Rows.Count==0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }    
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="C66a-HD_files/filelist.xml">
<link rel=Edit-Time-Data href="C66a-HD_files/editdata.mso">
<link rel=OLE-Object-Data href="C66a-HD_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>User</o:Author>
  <o:LastAuthor>Hee</o:LastAuthor>
  <o:LastPrinted>2008-12-03T01:43:48Z</o:LastPrinted>
  <o:Created>2007-02-07T01:57:00Z</o:Created>
  <o:LastSaved>2008-12-09T06:39:18Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.36in .2in .16in .56in;
	mso-header-margin:.17in;
	mso-footer-margin:.16in;
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
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl89
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl90
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl92
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl93
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl94
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl95
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl96
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl97
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl98
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl99
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl100
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl101
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl102
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl103
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl104
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl105
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	white-space:normal;}
.xl106
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl107
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl108
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl109
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl110
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl111
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl112
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl113
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl114
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	font-size:12.0pt;
	mso-number-format:"\#\,\#\#0";
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	mso-text-control:shrinktofit;
	border-left:none;}
.xl115
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl116
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl117
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl118
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:Tahoma, sans-serif;
	mso-number-format:"\#\,\#\#0";
	mso-text-control:shrinktofit;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl119
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl120
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl121
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl122
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl123
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl124
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	font-size:12.0pt;
	mso-font-charset:0;
	mso-number-format:"dd/mm/yyyy";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	mso-text-control:shrinktofit;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>66a</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>330</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>  
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:CodeName>Sheet1</x:CodeName>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>27</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_Fill</x:Name>
  <x:Hidden/>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_10</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_100</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_10S</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_120</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_140</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_160</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_20</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_30</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_40</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_40S</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_5S</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_60</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_80</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_80S</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_STD</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_XS</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_XXS</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl102>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1254 style='border-collapse:
 collapse;table-layout:fixed;width:943pt'>
 <col class=xl25 width=43 style='mso-width-source:userset;mso-width-alt:1572;
 width:32pt'>
 <col class=xl25 width=164 style='mso-width-source:userset;mso-width-alt:5997;
 width:123pt'>
 <col class=xl25 width=93 span=2 style='mso-width-source:userset;mso-width-alt:
 3401;width:70pt'>
 <col class=xl25 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl25 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl25 width=89 span=3 style='mso-width-source:userset;mso-width-alt:
 3254;width:67pt'>
 <col class=xl25 width=121 style='mso-width-source:userset;mso-width-alt:4425;
 width:91pt'>
 <col class=xl25 width=111 style='mso-width-source:userset;mso-width-alt:4059;
 width:83pt'>
 <col class=xl25 width=126 style='mso-width-source:userset;mso-width-alt:4608;
 width:95pt'>
 <col class=xl24 width=64 style='width:48pt'>

 <tr class=xl93 height=17 style='height:12.75pt'>
  <td height=17 class=xl91 colspan=2 width=207 style='height:12.75pt;
  mso-ignore:colspan;width:155pt' x:str>Tên cơ quan (đơn vị):<%=dt_com.Rows[0][0].ToString() %></td>
  <td class=xl91 width=93 style='width:70pt'></td>
  <td class=xl91 width=93 style='width:70pt'></td>
  <td class=xl91 width=94 style='width:71pt'></td>
  <td class=xl91 width=78 style='width:59pt'></td>
  <td class=xl92 width=89 style='width:67pt'></td>
  <td class=xl92 width=89 style='width:67pt'></td>
  <td class=xl93 width=89 style='width:67pt'></td>
  <td class=xl91 width=91 style='width:68pt'></td>
  <td colspan=2 class=xl94 width=204 style='width:154pt'>Mẫu số: C 66a- HD</td>
  <td class=xl93 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl93 height=17 style='height:12.75pt'>
  <td height=17 class=xl91 colspan=2 style='height:12.75pt;mso-ignore:colspan'
  x:str>Mã đơn vị:<%=dt_com.Rows[1][0].ToString() %><span style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl91 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl92 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl92></td>
  <td class=xl93></td>
 </tr>
 <tr class=xl93 height=17 style='height:12.75pt'>
  <td height=17 colspan=8 class=xl91 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl92></td>
  <td class=xl93></td>
 </tr>
 <tr class=xl93 height=17 style='height:12.75pt'>
  <td height=17 class=xl91 style='height:12.75pt'></td>
  <td colspan=12 class=xl93 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl96 height=20 style='height:15.0pt'>
  <td colspan=12 height=20 class=xl95 style='height:15.0pt'>DANH SÁCH NGƯỜI LAO
  ĐỘNG<span style='mso-spacerun:yes'>  </span>ĐỀ NGHỊ HƯỞNG CHẾ ĐỘ ỐM ĐAU</td>
  <td class=xl96></td>
 </tr>
 <tr class=xl98 height=19 style='height:14.25pt'>
 <%
     string w = "I";
     if (p_mon.Substring(4, 2) == "04" || p_mon.Substring(4, 2) == "05" || p_mon.Substring(4, 2) == "06")
         w = "II";
     if (p_mon.Substring(4, 2) == "07" || p_mon.Substring(4, 2) == "08" || p_mon.Substring(4, 2) == "09")
         w = "III";
     if (p_mon.Substring(4, 2) == "10" || p_mon.Substring(4, 2) == "11" || p_mon.Substring(4, 2) == "12")
         w = "IV";
         
  %>
  <td colspan=12 height=19 class=xl97 style='height:14.25pt'>Tháng <%=p_mon.Substring(4,2) %> quý <%=w %> năm <%= p_mon.Substring(0,4) %> </td>
  <td class=xl98></td>
 </tr>
 <tr class=xl98 height=19 style='height:14.25pt'>
  <td height=19 class=xl98 style='height:14.25pt'></td>
  <td colspan=3 class=xl99 style='mso-ignore:colspan'></td>
  <td class=xl99 colspan=3 style='mso-ignore:colspan'>Số hiệu tài khoản:<%=dt_com.Rows[8][0].ToString() %> mở
  tại: <%=dt_com.Rows[9][0].ToString() %></td>
  <td colspan=6 class=xl99 style='mso-ignore:colspan'></td>
 </tr>
<tr class=xl27 height=17 style='height:12.75pt'>
  <td height=17 colspan=2  style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl34 x:str="Tổng số lao động: ">Tổng số lao động:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl35 x:num><%=dtotal_lb %></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl34 colspan=2 style='mso-ignore:colspan' x:str="Trong đó nữ: ">Trong
  đó nữ:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl35 x:num><%=dtotal_lb_femail %></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'>&nbsp;</td>
  <td >&nbsp;</td>
 </tr>
 <tr class=xl27 height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl25 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl34 x:str="Tổng quỹ lương trong tháng:  ">Tổng quỹ lương trong
  tháng:<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl35 x:num><%=dtotal_sal %></td>
  <td >&nbsp;</td>
  <td >&nbsp;</td>
  <td >&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'>&nbsp;</td>
  <td >&nbsp;</td>
  <td colspan=2  style='mso-ignore:colspan'>&nbsp;</td>
  <td >&nbsp;</td>
 </tr>
 <tr class=xl98 height=19 style='height:14.25pt'>
  <td height=19 colspan=9 class=xl100 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl97 style='mso-ignore:colspan'></td>
  <td class=xl97>Số:……….</td>
  <td class=xl98></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=12 class=xl101 style='height:16.5pt;mso-ignore:colspan'></td>
  <td class=xl102></td>
 </tr>
 <tr class=xl105 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td rowspan=3 height=76 class=xl89 width=43 style='height:57.0pt;width:32pt'>STT</td>
  <td rowspan=3 class=xl89 width=164 style='width:123pt'>Họ và tên</td>
  <td rowspan=3 class=xl89 width=93 style='width:70pt'>Số sổ BHXH</td>
  <td rowspan=3 class=xl89 width=93 style='border-bottom:.5pt solid black;
  width:70pt'>Điều kiện tính hưởng</td>
  <td rowspan=3 class=xl89 width=94 style='width:71pt'>Tiền lương tính hưởng
  BHXH</td>
  <td rowspan=3 class=xl89 width=78 style='width:59pt'>Thời gian đóng BHXH</td>
  <td colspan=3 class=xl90 width=267 style='border-right:.5pt solid black;
  border-left:none;width:201pt'>Số đơn vị đề nghị</td>
  <td rowspan=3 class=xl89 width=91 style='border-bottom:.5pt solid black;
  width:68pt'>Từ ngày</td>
  <td rowspan=3 class=xl89 width=78 style='border-bottom:.5pt solid black;
  width:59pt'>Đến ngày</td>
  <td rowspan=3 class=xl89 width=126 style='border-bottom:.5pt solid black;
  width:95pt'>Ghi chú</td>
  <td class=xl105></td>
 </tr>
 <tr class=xl105 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=2 height=19 class=xl107 width=178 style='border-right:.5pt solid black;
  height:14.25pt;border-left:none;width:134pt'>Số ngày nghỉ</td>
  <td rowspan=2 class=xl89 width=89 style='border-top:none;width:67pt'
  x:str="Số tiền ">Số tiền<span style='mso-spacerun:yes'> </span></td>
  <td class=xl105></td>
 </tr>
 <tr class=xl105 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl106 width=89 style='height:27.0pt;border-left:none;
  width:67pt'>Trong kỳ</td>
  <td class=xl106 width=89 style='border-left:none;width:67pt'>Luỹ kế từ đầu
  năm</td>
  <td class=xl105></td>
 </tr>
 <tr class=xl111 height=19 style='height:14.25pt'>
  <td height=19 class=xl110 style='height:14.25pt'>A</td>
  <td class=xl110 style='border-left:none'>B</td>
  <td class=xl110 style='border-left:none'>C</td>
  <td class=xl110 style='border-top:none;border-left:none'>D</td>
  <td class=xl110 style='border-left:none' x:num>1</td>
  <td class=xl110 style='border-left:none' x:num>2</td>
  <td class=xl110 style='border-left:none' x:num>3</td>
  <td class=xl110 style='border-left:none' x:num>4</td>
  <td class=xl110 style='border-left:none' x:num>5</td>
  <td class=xl110 style='border-top:none;border-left:none'>E</td>
  <td class=xl110 style='border-top:none;border-left:none'>E</td>
  <td class=xl110 style='border-top:none;border-left:none'>E</td>
  <td class=xl111></td>
 </tr>
 <%             
        string[] seq = new string[4] { "I", "II", "III", "IV" };
        int j=0, i=0;
        double[] sum = new Double[11] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
        sum[4] += Double.Parse(dt_emp.Rows[i][4].ToString());
        sum[6] += Double.Parse(dt_emp.Rows[i][6].ToString());
        sum[7] += Double.Parse(dt_emp.Rows[i][7].ToString());
        sum[8] += Double.Parse(dt_emp.Rows[i][8].ToString());
  %>
 <tr class=xl115 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl112 style='height:15.0pt'><%=seq[j++] %></td>
  <td class=xl113 style='border-top:none;border-left:none'><%=dt_emp.Rows[0][0].ToString() %></td>
  <td class=xl114>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl115></td>
 </tr>
 <tr class=xl115 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl116 style='height:15.0pt' x:num><%=i+1 %></td>
  <td class=xl114 style='border-top:none;border-left:none' ><%=dt_emp.Rows[i][1].ToString() %></td>
  <td class=xl114 style='border-top:none;border-left:none' ><%=dt_emp.Rows[i][2].ToString() %></td>
  <td class=xl114 style='border-top:none;border-left:none' ><%=dt_emp.Rows[i][3].ToString() %></td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][4].ToString() %></td>
  <td class=xl114 align=center style='border-top:none;border-left:none; text-align:center' x:str><%=dt_emp.Rows[i][5].ToString() %></td>
  <td class=xl114 style='border-top:none;border-left:none; text-align:center' x:num><%=dt_emp.Rows[i][6].ToString() %></td>
  <td class=xl114 style='border-top:none;border-left:none; text-align:center' x:num><%=dt_emp.Rows[i][7].ToString() %></td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][8].ToString() %></td>
  <td class=xl124 align=center style='border-top:none;border-left:none; text-align:center' x:num x:fmla="=DATE(<%=int.Parse(dt_emp.Rows[i][9].ToString().Substring(6,4).ToString())%>,<%=int.Parse(dt_emp.Rows[i][9].ToString().Substring(3,2).ToString())%>,<%=int.Parse(dt_emp.Rows[i][9].ToString().Substring(0,2).ToString())%>)" ></td>
  <td class=xl124 align=center style='border-top:none;border-left:none; text-align:center' x:num  x:fmla="=DATE(<%=int.Parse(dt_emp.Rows[i][10].ToString().Substring(6,4).ToString())%>,<%=int.Parse(dt_emp.Rows[i][10].ToString().Substring(3,2).ToString())%>,<%=int.Parse(dt_emp.Rows[i][10].ToString().Substring(0,2).ToString())%>)"></td>
  <td class=xl114 style='border-top:none;border-left:none' x:str><%=dt_emp.Rows[i][11].ToString() %></td>  
 </tr>
 <%
     int z = 1;
     
     for (i = 1; i < dt_emp.Rows.Count; i++)
     {
         sum[4] += Double.Parse(dt_emp.Rows[i][4].ToString());
         sum[6] += Double.Parse(dt_emp.Rows[i][6].ToString());
         sum[7] += Double.Parse(dt_emp.Rows[i][7].ToString());
         sum[8] += Double.Parse(dt_emp.Rows[i][8].ToString());
         if (dt_emp.Rows[i][0].ToString() != dt_emp.Rows[i - 1][0].ToString())
         {
             z = 0;
  %>
  
 <tr class=xl115 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl112 style='height:15.0pt'><%=seq[j++]%></td>
  <td class=xl113 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][0].ToString()%></td>
  <td class=xl114>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl115></td>
 </tr>
 <%     }//if %>
  <tr class=xl115 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl116 style='height:15.0pt' x:num><%=++z %></td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][1].ToString() %></td>
  <td class=xl114 style='border-top:none;border-left:none' ><%=dt_emp.Rows[i][2].ToString() %></td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][3].ToString() %></td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][4].ToString() %></td>
  <td class=xl114 style='border-top:none;border-left:none; text-align:center' x:str><%=dt_emp.Rows[i][5].ToString() %></td>
  <td class=xl114 style='border-top:none;border-left:none; text-align:center' x:num><%=dt_emp.Rows[i][6].ToString() %></td>
  <td class=xl114 style='border-top:none;border-left:none; text-align:center' x:num><%=dt_emp.Rows[i][7].ToString() %></td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][8].ToString() %></td>
  <td class=xl124 style='border-top:none;border-left:none; text-align:center' x:num x:fmla="=DATE(<%=int.Parse(dt_emp.Rows[i][9].ToString().Substring(6,4).ToString())%>,<%=int.Parse(dt_emp.Rows[i][9].ToString().Substring(3,2).ToString())%>,<%=int.Parse(dt_emp.Rows[i][9].ToString().Substring(0,2).ToString())%>)"></td>
  <td class=xl124 style='border-top:none;border-left:none; text-align:center' x:num x:fmla="=DATE(<%=int.Parse(dt_emp.Rows[i][10].ToString().Substring(6,4).ToString())%>,<%=int.Parse(dt_emp.Rows[i][10].ToString().Substring(3,2).ToString())%>,<%=int.Parse(dt_emp.Rows[i][10].ToString().Substring(0,2).ToString())%>)"></td>
  <td class=xl114 style='border-top:none;border-left:none' x:str><%=dt_emp.Rows[i][11].ToString() %></td>  
 </tr>
 <% }//for %>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl118 style='height:23.25pt'>&nbsp;</td>
  <td class=xl119 style='border-left:none'>Tổng cộng</td>
  <td class=xl118 style='border-left:none'>&nbsp;</td>
  <td class=xl118 style='border-left:none'>&nbsp;</td>
  <td class=xl118 style='border-left:none' x:num><%=sum[4] %></td>
  <td class=xl118 style='border-left:none'>&nbsp;</td>
  <td class=xl118 style='border-left:none' x:num><%=sum[6] %></td>
  <td class=xl118 style='border-left:none' x:num><%=sum[7] %></td>
  <td class=xl118 style='border-left:none' x:num><%=sum[8] %></td>
  <td class=xl118 style='border-left:none'>&nbsp;</td>
  <td class=xl118 style='border-left:none'>&nbsp;</td>
  <td class=xl118 style='border-left:none'>&nbsp;</td>
  <td class=xl102></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl101 style='height:23.25pt'></td>
  <td class=xl120></td>
  <td colspan=10 class=xl101 style='mso-ignore:colspan'></td>
  <td class=xl102></td>
 </tr>
 <tr class=xl96 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 colspan=8 class=xl121 style='height:23.25pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl122>Ngày <%=DateTime.Now.Day.ToString() %> tháng <%=DateTime.Now.Month.ToString() %> năm <%=DateTime.Now.Year.ToString() %></td>
  <td class=xl96></td>
 </tr>
 <tr class=xl115 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl95 style='height:23.25pt'></td>
  <td class=xl95>Người lập</td>
  <td colspan=2 class=xl95 style='mso-ignore:colspan'></td>
  <td class=xl95>Kế toán trưởng</td>
  <td class=xl95></td>
  <td class=xl115></td>
  <td class=xl95></td>
  <td colspan=4 class=xl95>Thủ trưởng đơn vị</td>
  <td class=xl115></td>
 </tr>
 <tr class=xl123 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl122 style='height:14.25pt'></td>
  <td class=xl122 x:str="  (Ký, họ tên) "><span style='mso-spacerun:yes'> 
  </span>(Ký, họ tên)<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl122 style='mso-ignore:colspan'></td>
  <td class=xl122 x:str="  (Ký, họ tên) "><span style='mso-spacerun:yes'> 
  </span>(Ký, họ tên)<span style='mso-spacerun:yes'> </span></td>
  <td class=xl122></td>
  <td class=xl123></td>
  <td class=xl122></td>
  <td colspan=4 class=xl122><span style='mso-spacerun:yes'> </span>(Ký, đóng
  dấu)</td>
  <td class=xl123></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 colspan=12 class=xl101 style='height:23.25pt;mso-ignore:colspan'></td>
  <td class=xl102></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 colspan=12 class=xl101 style='height:23.25pt;mso-ignore:colspan'></td>
  <td class=xl102></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 colspan=12 class=xl101 style='height:23.25pt;mso-ignore:colspan'></td>
  <td class=xl102></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 colspan=12 class=xl101 style='height:23.25pt;mso-ignore:colspan'></td>
  <td class=xl102></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl101 style='height:23.25pt'></td>
  <td class=xl101><%=dt_com.Rows[5][0].ToString() %></td>
  <td class=xl101></td>
  <td colspan=3 class=xl101><%=dt_com.Rows[7][0].ToString() %></td>
  <td colspan=2 class=xl101 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl101><%=dt_com.Rows[6][0].ToString() %></td>
  <td class=xl102></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 colspan=12 class=xl101 style='height:23.25pt;mso-ignore:colspan'></td>
  <td class=xl102></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 colspan=12 class=xl101 style='height:23.25pt;mso-ignore:colspan'></td>
  <td class=xl102></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  
 </tr>
 <![endif]>
</table>

</body>

</html>
