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
    string emp_pk;
    
    emp_pk       = Request["emp_pk"].ToString();
    string SQL = " select  " 
        + "a.FULL_NAME  "//0
        + ",decode(nvl(a.sex,0),'M',case when length(a.BIRTH_DT)>4 then to_char(to_date(a.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy') else substr(a.BIRTH_DT,1,4)end,' ') as Male " //2
        + ",decode(nvl(a.sex,0),'F',case when length(a.BIRTH_DT)>4 then to_char(to_date(a.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy') else substr(a.BIRTH_DT,1,4)end ,' ') as FeMale " //2
        + ",a.health_no as health_no " //3
        + ",to_char(to_date(e.old_from_dt,'YYYYMMdd'),'dd/mm/yyyy') " //5
        + ",to_char(to_date(e.old_to_dt,'YYYYMMdd'),'dd/mm/yyyy') " //6
        +",e.old " // 7
        + ",e.new " // 8
        + ",e.reason " //9
        + "from thr_employee a,thr_ins_modify e "
        + "where a.del_if=0 and e.del_if=0 and e.thr_emp_pk =a.pk "
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
string s="Đồng";
    string s1="Thẻ";
    string Total_vn = CommondLib.Num2VNText(dt_total.Rows.Count+"","VND").Replace(s,s1);
    
        
   
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Copy%20of%20mauso03_THE_files/filelist.xml">
<style id="Copy of mauso03_THE_29913_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.xl63029913
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl63129913
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl63229913
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl63329913
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl63429913
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl63529913
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl63629913
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl63729913
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl63829913
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63929913
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl64029913
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl64129913
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl64229913
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl64329913
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl64429913
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl64529913
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl64629913
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
</head>

<body>
<!--[if !excel]>&nbsp;&nbsp;<![endif]-->
<!--The following information was generated by Microsoft Office Excel's Publish
as Web Page wizard.-->
<!--If the same item is republished from Excel, all information between the DIV
tags will be replaced.-->
<!----------------------------->
<!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD -->
<!----------------------------->

<div id="Copy of mauso03_THE_29913" align=center x:publishsource="Excel">

<table x:str border=0 cellpadding=0 cellspacing=0 width=1254 class=xl63029913
 style='border-collapse:collapse;table-layout:fixed;width:941pt'>
 <col class=xl63029913 width=33 style='mso-width-source:userset;mso-width-alt:
 1056;width:25pt'>
 <col class=xl63029913 width=206 style='mso-width-source:userset;mso-width-alt:
 6592;width:155pt'>
 <col class=xl63029913 width=71 style='mso-width-source:userset;mso-width-alt:
 2272;width:53pt'>
 <col class=xl63029913 width=63 style='mso-width-source:userset;mso-width-alt:
 2016;width:47pt'>
 <col class=xl63029913 width=98 style='mso-width-source:userset;mso-width-alt:
 4136;width:74pt'>
 <col class=xl63029913 width=76 style='mso-width-source:userset;mso-width-alt:
 3432;width:57pt'>
 <col class=xl63029913 width=88 style='mso-width-source:userset;mso-width-alt:
 3816;width:66pt'>
 <col class=xl63029913 width=99 style='mso-width-source:userset;mso-width-alt:
 4168;width:74pt'>
 <col class=xl63029913 width=105 style='mso-width-source:userset;mso-width-alt:
 4360;width:79pt'>
 <col class=xl63029913 width=232 style='mso-width-source:userset;mso-width-alt:
 7424;width:174pt'>
 <col class=xl63029913 width=111 style='mso-width-source:userset;mso-width-alt:
 3552;width:83pt'>
 <col class=xl63029913 width=72 style='width:54pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl63029913 width=33 style='height:15.75pt;width:25pt'></td>
  <td class=xl63029913 width=206 style='width:155pt'></td>
  <td class=xl63029913 width=71 style='width:53pt'></td>
  <td class=xl63029913 width=63 style='width:47pt'></td>
  <td class=xl63029913 width=98 style='width:74pt'></td>
  <td class=xl63029913 width=76 style='width:57pt'></td>
  <td class=xl63029913 width=88 style='width:66pt'></td>
  <td class=xl63029913 width=99 style='width:74pt'></td>
  <td class=xl63029913 width=105 style='width:79pt'></td>
  <td class=xl63029913 width=232 style='width:174pt'></td>
  <td class=xl63129913 colspan=2 width=183 style='width:137pt'>M&#7851;u
  s&#7889;<span style='mso-spacerun:yes'>&nbsp; </span>03/THE</td>
 </tr>
 <tr class=xl63229913 height=27 style='height:20.25pt'>
  <td height=27 class=xl63229913 style='height:20.25pt'></td>
  <td class=xl63229913></td>
  <td class=xl64529913 colspan=7><span style='mso-spacerun:yes'> &nbsp; </span>DANH
  SÁCH &#272;&#7872; NGH&#7882; C&#7844;P L&#7840;I TH&#7866; B&#7842;O
  HI&#7874;M Y T&#7870;</td>
  <td class=xl63229913></td>
  <td class=xl63229913></td>
  <td class=xl63229913></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl63029913 style='height:15.75pt'></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63329913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl63029913 style='height:15.75pt'></td>
  <td class=xl63029913></td>
  <td class=xl63329913 colspan=8>&#272;&#417;n
  v&#7883;:<%= dt_name.Rows[0][0].ToString()%>.  Mã s&#7889;  <%= dt_name.Rows[1][0].ToString()%></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl63029913 style='height:15.75pt'></td>
  <td class=xl63029913></td>
  <td class=xl63329913 colspan=8>&#272;&#7883;a
  ch&#7881;:<%= dt_name.Rows[2][0].ToString()%>.</td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl63029913 style='height:15.75pt'></td>
  <td class=xl63029913></td>
  <td class=xl63329913 colspan=8>&#272;i&#7879;n
  tho&#7841;i:<%= dt_name.Rows[11][0].ToString()%>. Fax <%= dt_name.Rows[12][0].ToString()%></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl63029913 style='height:15.75pt'></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
 </tr>
 <tr class=xl63529913 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td rowspan=2 height=45 class=xl64029913 style='border-bottom:.5pt solid black;
  height:33.75pt'>TT</td>
  <td rowspan=2 class=xl64029913 style='border-bottom:.5pt solid black'>H&#7885;
  và tên</td>
  <td colspan=2 class=xl64129913 style='border-right:.5pt solid black;
  border-left:none'>N&#259;m sinh</td>
  <td rowspan=2 class=xl64029913 style='border-bottom:.5pt solid black'>S&#7889;
  th&#7867; BHYT</td>
  <td colspan=2 class=xl64129913 style='border-right:.5pt solid black;
  border-left:none'><span style='mso-spacerun:yes'> &nbsp; </span>Th&#7901;i h&#7841;n
  s&#7917; d&#7909;ng</td>
  <td class=xl64329913 colspan=2 style='border-left:none'>N&#7897;i dung
  thay &#273;&#7893;i</td>
 
  <td rowspan=2 class=xl64029913 style='border-bottom:.5pt solid black'>Lý do</td>
  <td rowspan=2 class=xl64029913 style='border-bottom:.5pt solid black'>Ghi chú</td>
  <td class=xl63529913></td>
 </tr>
 <tr class=xl63529913 height=22 style='height:16.5pt'>
  <td height=22 class=xl64329913 style='height:16.5pt;border-top:none;
  border-left:none'>
      Nam</td>
  <td class=xl64329913 style='border-top:none;border-left:none'>
      Nữ</td>
  <td class=xl64429913 style='border-left:none'>T&#7915; ngày</td>
  <td class=xl64429913 style='border-left:none'>&#272;&#7871;n ngày</td>
  <td class=xl64329913 style='border-top:none;border-left:none'>N&#7897;i dung
  c&#361;</td>
  <td class=xl64329913 style='border-top:none;border-left:none'>N&#7897;i dung
  m&#7899;i</td>
  <td class=xl63529913></td>
 </tr>
 <tr class=xl63529913 height=22 style='height:16.5pt'>
  <td height=22 class=xl64329913 style='height:16.5pt;border-top:none' x:num>1</td>
  <td class=xl64329913 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl64329913 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl64329913 style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl64329913 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl64329913 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl64329913 style='border-top:none;border-left:none' x:num>7</td>
  <td class=xl64329913 style='border-top:none;border-left:none' x:num>8</td>
  <td class=xl64329913 style='border-top:none;border-left:none' x:num>9</td>
  <td class=xl64329913 style='border-top:none;border-left:none' x:num>10</td>
  <td class=xl64329913 style='border-top:none;border-left:none' x:num>11</td>
  <td class=xl63529913></td>
 </tr>
 <% for(int i=0;i< dt_total.Rows.Count;i++ ) {%>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl63829913 style='height:28.5pt;border-top:none'><%= i+1 %></td>
  <td class=xl64629913 style='border-top:none;border-left:none;text-align:left'><%= dt_total.Rows[i][0].ToString()%></td>
  <td class=xl63829913 style='border-top:none;border-left:none'><%= dt_total.Rows[i][1].ToString()%></td>
  <td class=xl63829913 style='border-top:none;border-left:none'><%= dt_total.Rows[i][2].ToString()%></td>
  <td class=xl63829913 style='border-top:none;border-left:none'><%= dt_total.Rows[i][3].ToString()%></td>
  <td class=xl63829913 style='border-top:none;border-left:none'><%= dt_total.Rows[i][4].ToString()%></td>
  <td class=xl63829913 style='border-top:none;border-left:none'><%= dt_total.Rows[i][5].ToString()%></td>
  <td class=xl63829913 style='border-top:none;border-left:none'><%= dt_total.Rows[i][6].ToString()%></td>
  <td class=xl63829913 style='border-top:none;border-left:none'><%= dt_total.Rows[i][7].ToString()%></td>
  <td class=xl63829913 style='border-top:none;border-left:none'><%= dt_total.Rows[i][8].ToString()%></td>
  <td class=xl63829913 style='border-top:none;border-left:none'></td>
  <td class=xl63029913></td>
 </tr>
 <%} %>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl63929913 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td class=xl63929913 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl63929913 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl63929913 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl63929913 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl63929913 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl63929913 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl63929913 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl63929913 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl63929913 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl63929913 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl63029913></td>
 </tr>
 
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl63029913 style='height:15.75pt'></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl63029913 colspan=3 style='height:15.75pt'>T&#7893;ng
  s&#7889; th&#7867; &#273;&#7873; ngh&#7883; c&#7845;p l&#7841;i :<span
  style='mso-spacerun:yes'> </span><%=dt_total.Rows.Count %>  th&#7867;</td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl63029913 colspan=5 style='height:15.75pt'>( B&#7857;ng
  ch&#7919;:<%=Total_vn%>)</td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63129913 colspan=2><%=dt_name.Rows[10][0].ToString()%>,ngày <%= DateTime.Today.Day%> tháng <%= DateTime.Today.Month%>
  n&#259;m <%= DateTime.Today.Year%>.</td>
  <td class=xl63129913></td>
  <td class=xl63029913></td>
 </tr>
 <tr class=xl63329913 height=21 style='height:15.75pt'>
  <td height=21 class=xl63329913 style='height:15.75pt'></td>
  <td class=xl63329913>NG&#431;&#7900;I L&#7852;P BI&#7874;U</td>
  <td class=xl63329913></td>
  <td class=xl63329913></td>
  <td class=xl63329913></td>
  <td class=xl63329913></td>
  <td class=xl63329913></td>
  <td class=xl63329913></td>
  <td class=xl63329913 colspan=2><span style='mso-spacerun:yes'>          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp;
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
  </span>TH&#7910; TR&#431;&#7902;NG &#272;&#416;N V&#7882;</td>
  <td class=xl63329913></td>
  <td class=xl63329913></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl63029913 style='height:15.75pt'></td>
  <td class=xl63029913>( Ký, ghi rõ h&#7885; tên)</td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913 colspan=2><span style='mso-spacerun:yes'>         &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
      &nbsp; &nbsp; &nbsp; &nbsp;
  </span>(Ký,&#273;óng d&#7845;u,ghi rõ h&#7885; tên)</td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
 </tr>
 <tr></tr>
 <tr></tr>
 <tr></tr>
 <tr></tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl63029913 style='height:15.75pt'></td>
  <td class=xl63029913><%=dt_name.Rows[5][0].ToString() %></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913 colspan=2><span style='mso-spacerun:yes'>         &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
      &nbsp; &nbsp; &nbsp; &nbsp;
  </span><%=dt_name.Rows[6][0].ToString() %></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
 </tr>
 
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl63029913 style='height:15.75pt'></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl63029913 style='height:15.75pt'></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
  <td class=xl63029913></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl63629913 colspan=2 style='height:15.75pt'>Ghi chú :</td>
  <td class=xl63129913></td>
  <td class=xl63129913></td>
  <td class=xl63129913></td>
  <td class=xl63129913></td>
  <td class=xl63129913></td>
  <td class=xl63129913></td>
  <td class=xl63129913></td>
  <td class=xl63129913></td>
  <td class=xl63129913></td>
  <td class=xl63129913></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl63729913 style='height:15.75pt' x:num>1</td>
  <td class=xl63129913 colspan=3>Danh sách do &#273;&#417;n v&#7883; qu&#7843;n
  lý ng&#432;&#7901;i BHYT l&#7853;p</td>
  <td class=xl63129913></td>
  <td class=xl63129913></td>
  <td class=xl63129913></td>
  <td class=xl63129913></td>
  <td class=xl63129913></td>
  <td class=xl63129913></td>
  <td class=xl63129913></td>
  <td class=xl63129913></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl63729913 style='height:15.75pt' x:num>2</td>
  <td class=xl63129913 colspan=10
  x:str>Khi
  th&#7867;BHYT h&#7887;ng do in sai n&#7897;i dung, do b&#7843;o qu&#7843;n,
  s&#7917; d&#7909;ng ho&#7863;c thay &#273;&#7893;i n&#417;i KCB ban
  &#273;&#7847;u, &#273;&#417;n v&#7883; l&#7853;p<span
  style='mso-spacerun:yes'>&nbsp;</span></td>
  <td class=xl63129913></td>
  <td class=xl63129913></td>
  <td class=xl63129913></td>
  <td class=xl63129913></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl63129913 style='height:15.75pt'></td>
  <td class=xl63129913 colspan=12> danh sách kèm theo th&#7867; BHYT c&#361;
  (tr&#7915; tr&#432;&#7901;ng h&#7907;p ch&#7871;t) cùng công v&#259;n
  &#273;&#7873; ngh&#7883;, &#273;&#417;n c&#7911;a ng&#432;&#7901;i tham gia
  BHYT</td>
  
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=33 style='width:25pt'></td>
  <td width=206 style='width:155pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=232 style='width:174pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=72 style='width:54pt'></td>
 </tr>
 <![endif]></table>

</div>


<!----------------------------->
<!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD-->
<!----------------------------->
</body>

</html>
