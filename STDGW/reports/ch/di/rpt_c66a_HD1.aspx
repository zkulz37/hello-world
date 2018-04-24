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
  = "select count(*),sum(decode(b.sex,'F',1,0)),sum(luong_cb)  " +
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
<link rel=File-List href="rpt_c66a_HD1_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_c66a_HD1_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_c66a_HD1_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>User</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2012-01-03T07:11:36Z</o:LastPrinted>
  <o:Created>2010-06-29T09:36:17Z</o:Created>
  <o:LastSaved>2012-01-03T07:17:39Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.35in .2in .16in .55in;
	mso-header-margin:.16in;
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
.xl65
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl68
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl69
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl72
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl73
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl74
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl75
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl76
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl77
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl78
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl83
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl88
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl94
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl95
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
.xl96
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl97
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl99
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl100
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl101
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl102
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl103
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl104
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl105
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl106
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl108
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl109
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl110
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl111
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl112
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl113
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
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
    <x:Name>C66a-HD1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>330</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>99</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
       <x:ActiveCol>14</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8850</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl93>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1065 style='border-collapse:
 collapse;table-layout:fixed;width:800pt'>
 <col class=xl101 width=28 style='mso-width-source:userset;mso-width-alt:1024;
 width:21pt'>
 <col class=xl101 width=144 style='mso-width-source:userset;mso-width-alt:5266;
 width:108pt'>
 <col class=xl101 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl101 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl101 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl101 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl101 width=59 style='mso-width-source:userset;mso-width-alt:2157;
 width:44pt'>
 <col class=xl101 width=57 style='mso-width-source:userset;mso-width-alt:2084;
 width:43pt'>
 <col class=xl102 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl101 width=84 style='mso-width-source:userset;mso-width-alt:3072;
 width:63pt'>
 <col class=xl101 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl101 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl93 width=64 span=2 style='width:48pt'>
 <tr class=xl68 height=17 style='height:12.75pt'>
  <td height=17 class=xl65 colspan=3 width=266 style='height:12.75pt;
  mso-ignore:colspan;width:200pt'>Tên c&#417; quan (&#273;&#417;n v&#7883;):
  <%=dt_com.Rows[0][0].ToString() %></td>
  <td class=xl65 width=86 style='width:65pt'></td>
  <td class=xl65 width=76 style='width:57pt'></td>
  <td class=xl65 width=67 style='width:50pt'></td>
  <td class=xl66 width=59 style='width:44pt'></td>
  <td class=xl66 width=57 style='width:43pt'></td>
  <td colspan=5 class=xl67 width=390 style='width:293pt'>M&#7851;u s&#7889;: C
  66a- HD1</td>
  <td class=xl68 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl68 height=17 style='height:12.75pt'>
  <td height=17 class=xl65 colspan=2 style='height:12.75pt;mso-ignore:colspan'>Mã
  &#273;&#417;n v&#7883;: <%=dt_com.Rows[1][0].ToString() %></td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl66 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl66></td>
  <td class=xl67></td>
  <td class=xl68></td>
 </tr>
 <tr class=xl68 height=17 style='height:12.75pt'>
  <td height=17 class=xl65 colspan=3 style='height:12.75pt;mso-ignore:colspan'>S&#7889;
  &#272;i&#7879;n tho&#7841;i: <%=dt_com.Rows[13][0].ToString() %><span style='mso-spacerun:yes'> 
  </span>Fax:<%=dt_com.Rows[15][0].ToString() %></td>
  <td colspan=5 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl66></td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=17 style='height:12.75pt'>
  <td height=17 class=xl65 style='height:12.75pt'></td>
  <td colspan=7 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl69></td>
  <td colspan=5 class=xl68 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl71 height=21 style='height:15.75pt'>
  <td colspan=12 height=21 class=xl70 style='height:15.75pt'>DANH SÁCH
  NG&#431;&#7900;I LAO &#272;&#7896;NG<span style='mso-spacerun:yes'> 
  </span>&#272;&#7872; NGH&#7882; H&#431;&#7902;NG CH&#7870; &#272;&#7896;
  &#7888;M &#272;AU</td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl73 height=20 style='height:15.0pt'>
 <%
     string w = "I";
     if (p_mon.Substring(4, 2) == "04" || p_mon.Substring(4, 2) == "05" || p_mon.Substring(4, 2) == "06")
         w = "II";
     if (p_mon.Substring(4, 2) == "07" || p_mon.Substring(4, 2) == "08" || p_mon.Substring(4, 2) == "09")
         w = "III";
     if (p_mon.Substring(4, 2) == "10" || p_mon.Substring(4, 2) == "11" || p_mon.Substring(4, 2) == "12")
         w = "IV";
         
  %>
  <td colspan=12 height=20 class=xl72 style='height:15.0pt'>Tháng <%=p_mon.Substring(4,2) %> quý <%=w %>
  n&#259;m <%= p_mon.Substring(0,4) %></td>
  <td colspan=2 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl73 height=20 style='height:15.0pt'>
  <td height=20 class=xl73 style='height:15.0pt'></td>
  <td colspan=3 class=xl74 style='mso-ignore:colspan'></td>
  <td class=xl74 colspan=4 style='mso-ignore:colspan'>S&#7889; hi&#7879;u tài
  kho&#7843;n: <%=dt_com.Rows[8][0].ToString() %></td>
  <td class=xl74 colspan=3 style='mso-ignore:colspan'>M&#7903; t&#7841;i: <%=dt_com.Rows[9][0].ToString() %></td>
  <td colspan=3 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl73 height=20 style='height:15.0pt'>
  <td height=20 class=xl73 style='height:15.0pt'></td>
  <td colspan=3 class=xl74 style='mso-ignore:colspan'></td>
  <td class=xl74 colspan=4 style='mso-ignore:colspan'>T&#7893;ng s&#7889; lao
  &#273;&#7897;ng……..……<%=dtotal_lb %>.……………</td>
  <td class=xl74 colspan=3 style='mso-ignore:colspan'>Trong &#273;ó n&#7919;:………<%=dtotal_lb_femail %>..…..…………</td>
  <td colspan=3 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl73 height=20 style='height:15.0pt'>
  <td height=20 class=xl73 style='height:15.0pt'></td>
  <td colspan=3 class=xl74 style='mso-ignore:colspan'></td>
  <td class=xl74 colspan=7 style='mso-ignore:colspan'>T&#7893;ng qu&#7929;
  l&#432;&#417;ng trong (tháng) quý……………………<%=dtotal_sal %>…………........…….……</td>
  <td colspan=3 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl73 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=8 class=xl76 style='height:19.5pt;mso-ignore:colspan'></td>
  <td class=xl77></td>
  <td colspan=2 class=xl76 style='mso-ignore:colspan'></td>
  <td class=xl72>S&#7889;:……….</td>
  <td colspan=2 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl78 height=44 style='mso-height-source:userset;height:33.0pt'>
  <td rowspan=3 height=99 class=xl107 width=28 style='height:74.25pt;
  width:21pt'>STT</td>
  <td rowspan=3 class=xl107 width=144 style='width:108pt'>H&#7885; và tên</td>
  <td rowspan=3 class=xl107 width=94 style='width:71pt'>S&#7889; s&#7893; BHXH</td>
  <td rowspan=3 class=xl107 width=86 style='border-bottom:.5pt solid black;
  width:65pt'>&#272;i&#7873;u ki&#7879;n tính h&#432;&#7903;ng</td>
  <td rowspan=3 class=xl107 width=76 style='width:57pt'>Ti&#7873;n
  l&#432;&#417;ng tính h&#432;&#7903;ng BHXH</td>
  <td rowspan=3 class=xl107 width=67 style='width:50pt'>Th&#7901;i gian
  &#273;óng BHXH</td>
  <td colspan=3 class=xl109 width=192 style='border-right:.5pt solid black;
  border-left:none;width:144pt'>S&#7889; &#273;&#417;n v&#7883; &#273;&#7873;
  ngh&#7883;</td>
  <td colspan=2 class=xl109 width=177 style='border-right:.5pt solid black;
  border-left:none;width:133pt'>Ngày phát sinh ch&#7913;ng t&#7915;</td>
  <td rowspan=3 class=xl107 width=73 style='border-bottom:.5pt solid black;
  width:55pt'>Chi chú</td>
  <td colspan=2 class=xl78 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl78 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=2 height=19 class=xl103 width=116 style='border-right:.5pt solid black;
  height:14.25pt;border-left:none;width:87pt'>S&#7889; ngày ngh&#7881;</td>
  <td rowspan=2 class=xl105 width=76 style='border-top:none;width:57pt'
  x:str="S&#7889; ti&#7873;n ">S&#7889; ti&#7873;n<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl79 width=84 style='border-bottom:.5pt solid black;
  width:63pt' x:str="T&#7915; ngày/ tháng/n&#259;m ">T&#7915; ngày/
  tháng/n&#259;m<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl112 width=93 style='border-bottom:.5pt solid black;
  width:70pt'>&#272;&#7871;n ngày/tháng/ n&#259;m</td>
  <td colspan=2 class=xl78 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl78 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl79 width=59 style='height:27.0pt;border-left:none;
  width:44pt'>Trong k&#7923;</td>
  <td class=xl79 width=57 style='border-left:none;width:43pt'>Lu&#7929;
  k&#7871; t&#7915; &#273;&#7847;u n&#259;m</td>
  <td colspan=2 class=xl78 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl82 height=19 style='height:14.25pt'>
  <td height=19 class=xl80 style='height:14.25pt'>A</td>
  <td class=xl80 style='border-left:none'>B</td>
  <td class=xl80 style='border-left:none'>C</td>
  <td class=xl80 style='border-top:none;border-left:none'>D</td>
  <td class=xl80 style='border-left:none' x:num>1</td>
  <td class=xl80 style='border-left:none' x:num>2</td>
  <td class=xl80 style='border-left:none' x:num>3</td>
  <td class=xl80 style='border-left:none' x:num>4</td>
  <td class=xl81 style='border-left:none' x:num>5</td>
  <td class=xl80 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl80 style='border-top:none;border-left:none' x:num>7</td>
  <td class=xl80 style='border-top:none;border-left:none'>E</td>
  <td colspan=2 class=xl82 style='mso-ignore:colspan'></td>
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
 <tr class=xl87 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl83 style='height:15.0pt'><%=seq[j++] %></td>
  <td class=xl84 style='border-top:none;border-left:none'><%=dt_emp.Rows[0][0].ToString() %></td>
  <td class=xl85>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl87 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl87 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl88 style='height:15.0pt' x:num><%=i+1 %></td>
  <td class=xl89 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][1].ToString() %></td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][2].ToString() %></td>
  <td class=xl88 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][3].ToString() %></td>
  <td class=xl90 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][4].ToString() %></td>
  <td class=xl88 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][5].ToString() %></td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][6].ToString() %></td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][7].ToString() %></td>
  <td class=xl91 style='border-top:none;border-left:none'
  x:num><%=dt_emp.Rows[i][8].ToString() %></td>
  <td class=xl92 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][9].ToString() %></td>
  <td class=xl92 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][10].ToString() %></td>
  <td class=xl88 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][11].ToString() %></td>
  <td colspan=2 class=xl87 style='mso-ignore:colspan'></td>
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
  <tr class=xl87 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl83 style='height:15.0pt'><%=seq[j++] %></td>
  <td class=xl84 style='border-top:none;border-left:none'><%=dt_emp.Rows[0][0].ToString() %></td>
  <td class=xl85>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl87 style='mso-ignore:colspan'></td>
 </tr>
  <%     }//if %>
 <tr class=xl87 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl88 style='height:15.0pt' x:num><%=i+1 %></td>
  <td class=xl89 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][1].ToString() %></td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][2].ToString() %></td>
  <td class=xl88 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][3].ToString() %></td>
  <td class=xl90 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][4].ToString() %></td>
  <td class=xl88 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][5].ToString() %></td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][6].ToString() %></td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][7].ToString() %></td>
  <td class=xl91 style='border-top:none;border-left:none'
  x:num><%=dt_emp.Rows[i][8].ToString() %></td>
  <td class=xl92 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][9].ToString() %></td>
  <td class=xl92 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][10].ToString() %></td>
  <td class=xl88 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][11].ToString() %></td>
  <td colspan=2 class=xl87 style='mso-ignore:colspan'></td>
 </tr>
  <% }//for %>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl94 style='height:23.25pt'>&nbsp;</td>
  <td class=xl95 style='border-left:none'>T&#7893;ng c&#7897;ng</td>
  <td class=xl94 style='border-left:none'>&nbsp;</td>
  <td class=xl94 style='border-left:none'>&nbsp;</td>
  <td class=xl97 style='border-left:none' x:num><%=sum[4] %></td>
  <td class=xl94 style='border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-left:none' x:num><%=sum[6] %></td>
  <td class=xl94 style='border-left:none' x:num><%=sum[7] %></td>
  <td class=xl97 style='border-left:none' x:num><%=sum[8] %></td>
  <td class=xl94 style='border-left:none'>&nbsp;</td>
  <td class=xl94 style='border-left:none'>&nbsp;</td>
  <td class=xl94 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl93 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl71 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 colspan=8 class=xl98 style='height:23.25pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl99>Ngày <%=DateTime.Now.Day.ToString() %> tháng <%=DateTime.Now.Month.ToString() %> n&#259;m <%=DateTime.Now.Year.ToString() %></td>
  <td class=xl99></td>
  <td class=xl71></td>
 </tr>
 <tr class=xl87 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl70 style='height:23.25pt'></td>
  <td class=xl70>Ng&#432;&#7901;i l&#7853;p</td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl70 x:str="K&#7871; toán ">K&#7871; toán<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl70></td>
  <td class=xl87></td>
  <td class=xl70></td>
  <td colspan=4 class=xl70>Th&#7911; tr&#432;&#7903;ng &#273;&#417;n v&#7883;</td>
  <td colspan=2 class=xl87 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl100 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl99 style='height:14.25pt'></td>
  <td class=xl99 x:str="  (Ký, h&#7885; tên) "><span style='mso-spacerun:yes'> 
  </span>(Ký, h&#7885; tên)<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl99 style='mso-ignore:colspan'></td>
  <td class=xl99 x:str="  (Ký, h&#7885; tên) "><span style='mso-spacerun:yes'> 
  </span>(Ký, h&#7885; tên)<span style='mso-spacerun:yes'> </span></td>
  <td class=xl99></td>
  <td class=xl100></td>
  <td class=xl99></td>
  <td colspan=4 class=xl99><span style='mso-spacerun:yes'> </span>(Ký,
  &#273;óng d&#7845;u)</td>
  <td colspan=2 class=xl100 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl100 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=6 class=xl99 style='height:14.25pt;mso-ignore:colspan'></td>
  <td class=xl100></td>
  <td colspan=5 class=xl99 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl100 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl100 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=6 class=xl99 style='height:14.25pt;mso-ignore:colspan'></td>
  <td class=xl100></td>
  <td colspan=5 class=xl99 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl100 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=28 style='width:21pt'></td>
  <td width=144 style='width:108pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
