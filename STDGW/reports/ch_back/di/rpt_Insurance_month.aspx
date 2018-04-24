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
string l_tco_org,p_month,l_work_group,l_serach;
     
    l_tco_org       = Request["l_tco_org"].ToString();
    l_work_group  = Request["l_work_group"].ToString();
    l_serach = Request["l_serach"].ToString();
            
    p_month  = Request["l_rpt_month"].ToString();
  string  l_temp= Request["l_temp"].ToString();
string SQL
	= "select  rownum,g1.org_nm,a.EMP_ID ,a.FULL_NAME,to_char(to_date(a.join_dt,'yyyymmdd'),'dd/mm/yyyy') " + 
        ",SO_BHXH,DC_BHXH,SO_BHYT,DC_KCB " +
        "   ,ins.Luong_cb,LUONG_BHXH  " +
        "   ,ins.LUONG_BHXH*nvl(ins.social_rate,0)/100,ins.LUONG_BHYT*nvl(health_rate,0)/100,ins.LUONG_BHTN * nvl(unemp_rate,0)/100 " +
        "   ,ins.LUONG_BHXH*nvl(social_com_rate,0)/100,ins.LUONG_BHYT*nvl(ins.health_com_rate,0)/100,ins.LUONG_BHTN * nvl(unemp_com_rate,0)/100 " +
        "   ,nvl(ins.LUONG_BHXH,0)*(nvl(ins.social_rate,0)+nvl(ins.social_com_rate,0))/100 + nvl(ins.LUONG_BHYT,0)*(nvl(ins.health_com_rate,0) +nvl(ins.health_rate,0) )/100 " +
        "    + nvl(ins.LUONG_BHTN,0) * (nvl(unemp_rate,0)+nvl(unemp_com_rate,0))/100 total_pay,ins.pk pk " +
        "   from  THR_EMPLOYEE A,thr_insurance_month ins,tco_org g1 " +
        "   where ins.DEL_IF =0 and  a.DEL_IF =0 and g1.del_if=0     " +
        "   and ins.WORK_MON = '"+p_month+"'  " +
        "   and ins.THR_EMP_PK = a.pk " +
        "   and a.tco_org_pk =g1.pk       " +
        "   and (nvl(xh_yn,'N')='Y' or nvl(yt_yn,'N')='Y' or nvl(tn_yn,'N')='Y') " +
        "   and decode('"+l_work_group+"','ALL','ALL',A.THR_WG_PK)='"+l_work_group+"' " +
        "   and  (  a.tco_org_pk IN (SELECT  g.pk " +
        "                             FROM tco_org g " +
        "                              START WITH g.pk =DECODE ('"+l_tco_org+"','ALL', 0,'"+l_tco_org+"') " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '"+l_tco_org+"' = 'ALL') " +
        "                     " +
        "   and (('"+l_serach+"'='1' and upper(a.emp_id) like  '%' || upper('"+l_temp+"')) " +
        "         or ('"+l_serach+"'='2' and upper(a.id_num) like  '%' || upper('"+l_temp+"')) " +
        "         or ('"+l_serach+"'='3' and upper(a.FULL_NAME ) like  '%' || upper('"+l_temp+"'))) " +
        "          " +
        "    " ;
//Response.Write(SQL);
//Response.End();  
    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
    if(dt_emp.Rows.Count==0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }
    DateTime dt = new DateTime(int.Parse(p_month.Substring(0,4)),int.Parse(p_month.Substring(4,2)),1);
%>
<head>
<meta http-equiv=Content);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Book_files/filelist.xml">
<link rel=Edit-Time-Data href="Book_files/editdata.mso">
<link rel=OLE-Object-Data href="Book_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>nhut_k</o:Author>
  <o:LastAuthor>nhut_k</o:LastAuthor>
  <o:LastPrinted>2010-04-22T03:36:09Z</o:LastPrinted>
  <o:Created>2010-04-22T02:59:40Z</o:Created>
  <o:LastSaved>2010-04-22T04:03:05Z</o:LastSaved>
  <o:Company>AS</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.1in .1in .1in .1in;
	mso-header-margin:.1in;
	mso-footer-margin:.1in;
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:justify;}
.xl26
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#339966;
	mso-pattern:#339966 none;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#339966;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#339966;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-size:26.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl33
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#339966;
	mso-pattern:#339966 none;}
.xl34
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#339966;
	mso-pattern:#339966 none;}
.xl35
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#339966;
	mso-pattern:#339966 none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#339966;
	mso-pattern:#339966 none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#339966;
	mso-pattern:#339966 none;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#339966;
	mso-pattern:#339966 none;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#339966;
	mso-pattern:#339966 none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#339966;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#339966;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:Scale>34</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>3</x:TopRowVisible>
     <x:LeftColumnVisible>3</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
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
  <x:WindowWidth>10395</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>135</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2134 style='border-collapse:
 collapse;table-layout:fixed;width:1602pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=197 style='mso-width-source:userset;mso-width-alt:7204;
 width:148pt'>
 <col class=xl24 width=102 style='mso-width-source:userset;mso-width-alt:3730;
 width:77pt'>
 <col class=xl24 width=198 style='mso-width-source:userset;mso-width-alt:7241;
 width:149pt'>
 <col class=xl24 width=99 style='mso-width-source:userset;mso-width-alt:3620;
 width:74pt'>
 <col class=xl24 width=119 style='mso-width-source:userset;mso-width-alt:4352;
 width:89pt'>
 <col class=xl24 width=152 style='mso-width-source:userset;mso-width-alt:5558;
 width:114pt'>
 <col class=xl24 width=143 style='mso-width-source:userset;mso-width-alt:5229;
 width:107pt'>
 <col class=xl24 width=141 span=3 style='mso-width-source:userset;mso-width-alt:
 6156;width:206pt'>
 <col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:4254;
 width:100pt'>
 <col class=xl24 width=100 style='mso-width-source:userset;mso-width-alt:3474;
 width:100pt'>
 <col class=xl24 width=100 style='mso-width-source:userset;mso-width-alt:3401;
 width:100pt'>
 <col class=xl24 width=100 span=2 style='mso-width-source:userset;mso-width-alt:3401;
 width:100pt'>
 <col class=xl24 width=116 span=2 style='mso-width-source:userset;mso-width-alt:
 4242;width:87pt'>

 <tr height=21 style='height:15.75pt'>
  <td colspan=18 rowspan=2 height=42 class=xl32 width=2134 style='height:31.5pt;
  width:1602pt' x:str>INSURANCE MONTH <%=dt.ToString("MMMM").ToUpper() +"-"+ dt.Year.ToString()%><span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=18 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=22 style='height:16.5pt'>
  <td rowspan=2 height=44 class=xl33 style='border-bottom:.5pt solid black;
  height:33.0pt'>No</td>
  <td rowspan=2 class=xl35 width=197 style='border-bottom:.5pt solid black;
  width:148pt' x:str="Oraganization ">Oraganization<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl35 width=102 style='border-bottom:.5pt solid black;
  width:77pt' x:str="Employee ID ">Employee ID<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl35 width=198 style='border-bottom:.5pt solid black;
  width:149pt'>Full Name</td>
  <td rowspan=2 class=xl35 width=99 style='border-bottom:.5pt solid black;
  width:74pt'>Join Date</td>
  <td rowspan=2 class=xl35 width=119 style='border-bottom:.5pt solid black;
  width:89pt' x:str="Basic Salary ">Basic Salary<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl35 width=152 style='border-bottom:.5pt solid black;
  width:114pt'>Salary For Insurance</td>
  <td rowspan=2 class=xl35 width=143 style='border-bottom:.5pt solid black;
  width:107pt'>Social No.</td>
  <td rowspan=2 class=xl35 width=141 style='border-bottom:.5pt solid black;
  width:106pt'>Social Place</td>
  <td rowspan=2 class=xl35 width=141 style='border-bottom:.5pt solid black;
  width:106pt'>Health No</td>
  <td rowspan=2 class=xl35 width=141 style='border-bottom:.5pt solid black;
  width:106pt'>Health Place</td>
  <td colspan=3 class=xl38 width=277 style='border-right:.5pt solid black;
  border-left:none;width:208pt'>Employee Payment</td>
  <td colspan=3 class=xl38 width=244 style='border-right:.5pt solid black;
  border-left:none;width:183pt'>Employer Payment</td>
  <td rowspan=2 class=xl35 width=116 style='border-bottom:.5pt solid black;
  width:87pt'>Total payment</td>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl26 width=89 style='height:16.5pt;width:67pt'>Health</td>
  <td class=xl26 width=95 style='width:71pt'>Social</td>
  <td class=xl26 width=93 style='width:70pt'>Unemployee</td>
  <td class=xl26 width=64 style='width:48pt'>Health</td>
  <td class=xl26 width=64 style='width:48pt'>Social</td>
  <td class=xl26 width=116 style='width:87pt'>Unemployee</td>
 </tr>
 <%double[] total = new double[9] { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
     foreach (DataRow r in dt_emp.Rows)
   { %>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl27 style='height:15.75pt'><%=r[0].ToString() %></td>
  <td class=xl42><%=r[1].ToString() %></td>
  <td class=xl42><%=r[2].ToString() %></td>
  <td class=xl42><%=r[3].ToString() %></td>
  <td class=xl42><%=r[4].ToString() %></td>
  <td class=xl28 x:num><%=r[9].ToString() %></td>
  <td class=xl28 x:num><%=r[10].ToString() %></td>
  <td class=xl43><%=r[5].ToString() %></td>
  <td class=xl43><%=r[6].ToString() %></td>
  <td class=xl43><%=r[7].ToString() %></td>
  <td class=xl28 ><%=r[8].ToString() %></td>
  <td class=xl28 x:num><%=r[11].ToString() %></td>
  <td class=xl28 x:num><%=r[12].ToString() %></td>
  <td class=xl28 x:num><%=r[13].ToString() %></td>
  <td class=xl28 x:num><%=r[14].ToString() %></td>
  <td class=xl28 x:num><%=r[15].ToString() %></td>
  <td class=xl28 x:num><%=r[16].ToString() %></td>
  <td class=xl28 x:num><%=r[17].ToString() %></td>
 </tr>
 <%
     total[0] += double.Parse(r[9].ToString());
     total[1] += double.Parse(r[10].ToString());
     total[2] += double.Parse(r[11].ToString());
     total[3] += double.Parse(r[12].ToString());
     total[4] += double.Parse(r[13].ToString());
     total[5] += double.Parse(r[14].ToString());
     total[6] += double.Parse(r[15].ToString());
     total[7] += double.Parse(r[16].ToString());
     total[8] += double.Parse(r[17].ToString());
        
   } %>
 <tr class=xl29 height=22 style='height:16.5pt'>
  <td colspan=2 height=22 class=xl40 style='border-right:.5pt solid black;
  height:16.5pt'>Total</td>
  <td class=xl30 colspan=3  x:num><%=dt_emp.Rows.Count%></td>
  <td class=xl31 x:num><%=total[0] %></td>
  <td class=xl31 x:num><%=total[1] %></td>
  <td class=xl31 x:num>&nbsp;</td>
  <td class=xl31 x:num>&nbsp;</td>
  <td class=xl31 x:num>&nbsp;</td>
  <td class=xl31 x:num>&nbsp;</td>
  <td class=xl31 x:num><%=total[2] %></td>
  <td class=xl31 x:num><%=total[3] %></td>
  <td class=xl31 x:num><%=total[4] %></td>
  <td class=xl31 x:num><%=total[5] %></td>
  <td class=xl31 x:num><%=total[6] %></td>
  <td class=xl31 x:num><%=total[7] %></td>
  <td class=xl31 x:num><%=total[8] %></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=197 style='width:148pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=198 style='width:149pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=152 style='width:114pt'></td>
  <td width=143 style='width:107pt'></td>
  <td width=141 style='width:106pt'></td>
  <td width=141 style='width:106pt'></td>
  <td width=141 style='width:106pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=116 style='width:87pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
