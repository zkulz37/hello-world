<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<%  string TCO_ORG_PK;
    string THR_WG_PK;
    string NATION;

    TCO_ORG_PK = Request["TCO_ORG_PK"].ToString();
    THR_WG_PK = Request["THR_WG_PK"].ToString();
    NATION = Request["NATION"].ToString();

    string SQL
         = "SELECT A.EMP_ID,            " +
         "             A.FULL_NAME,             " +
         "             A.SEX, " +
         "             B.CODE_NM," +
         "             A.TEL, " +
         "             A.PK, " +
         "             to_char(to_date(A.JOIN_DT,'YYYYMMDD'),'DD-MM-YYYY') as JOIN_DT, " +
         " case when length(A.BIRTH_DT) = 4 then A.BIRTH_DT " +
         " when  length(A.BIRTH_DT) = 6 then to_char(to_date(A.BIRTH_DT,'YYYYMMDD'),'MM-YYYY') " +
         " else to_char(to_date(A.BIRTH_DT,'YYYYMMDD'),'DD-MM-YYYY') " +
         " end as BIRTH_DT " +
         "        FROM THR_EMPLOYEE A " +
         " left join vhr_hr_code B on A.NATION = B.CODE " +
         "       WHERE A.DEL_IF = 0  " +
         " and B.ID = 'HR0009' " +
     " and ( A.TCO_ORG_PK in (select g.pk from tco_org g where g.del_if = 0 " +
     " start with g.pk = decode ('"+TCO_ORG_PK+"','ALL',0,'" +TCO_ORG_PK+"')" +
     " connect by prior g.pk = g.p_pk) or + '"+ TCO_ORG_PK+"' = 'ALL' )"+
         "       and decode( '" + THR_WG_PK + "', 'ALL', 'ALL', A.THR_WG_PK ) = '" + THR_WG_PK + "' " +
         "       and decode( '" + NATION + "', 'ALL', 'ALL', A.NATION ) = '" + NATION + "'";


    //Response.Write(SQL);
    //Response.End();

    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
    if (dt_emp.Rows.Count == 0)
    {
        Response.Write("There is no data to print");
        Response.End();
    } /**/
    int emp_row = dt_emp.Rows.Count;
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 15">
<link rel=File-List href="test_summary_files/filelist.xml">
<style id="test_summary_11921_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.xl6311921
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6411921
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:green;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:black none;
	white-space:nowrap;}
.xl6511921
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:green;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:bottom;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:black none;
	white-space:nowrap;}
.xl6611921
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:green;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:bottom;
	background:#CCFFCC;
	mso-pattern:black none;
	white-space:nowrap;}
.xl6711921
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:green;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	background:#CCFFCC;
	mso-pattern:black none;
	white-space:nowrap;}
.xl6811921
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:purple;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#FF99CC;
	mso-pattern:black none;
	white-space:nowrap;}
.xl6911921
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:purple;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#FF99CC;
	mso-pattern:black none;
	white-space:nowrap;}
.xl7011921
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:purple;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#FF99CC;
	mso-pattern:black none;
	white-space:nowrap;}
.xl7111921
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:purple;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:bottom;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#FF99CC;
	mso-pattern:black none;
	white-space:nowrap;}
.xl7211921
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:purple;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:bottom;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#FF99CC;
	mso-pattern:black none;
	white-space:nowrap;}
.xl7311921
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:purple;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:bottom;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#FF99CC;
	mso-pattern:black none;
	white-space:nowrap;}
.xl7411921
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:bottom;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7511921
	{color:green;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:black none;
	white-space:nowrap;
	padding-left:423px;
	mso-char-indent-count:47;}
-->
</style>
</head>

<body>
<!--[if !excel]>&nbsp;&nbsp;<![endif]-->
<!--The following information was generated by Microsoft Excel's Publish as=
 Web
Page wizard.-->
<!--If the same item is republished from Excel, all information between the=
 DIV
tags will be replaced.-->
<!----------------------------->
<!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD -->
<!----------------------------->

<div id="test_summary_11921" align=center x:publishsource="Excel">

<table border=0 cellpadding=0 cellspacing=0 width=966 class=xl631=
1921
 style='border-collapse:collapse;table-layout:fixed;width:726pt'>
 <col class=xl6311921 width=64 style='width:48pt'>
 <col class=xl6311921 width=140 style='mso-width-source:userset;mso-w=
idth-alt:
 5120;width:105pt'>
 <col class=xl6311921 width=188 style='mso-width-source:userset;mso-w=
idth-alt:
 6875;width:141pt'>
 <col class=xl6311921 width=64 style='width:48pt'>
 <col class=xl6311921 width=105 style='mso-width-source:userset;mso-w=
idth-alt:
 3840;width:79pt'>
 <col class=xl6311921 width=130 style='mso-width-source:userset;mso-w=
idth-alt:
 4754;width:98pt'>
 <col class=xl6311921 width=64 style='width:48pt'>
 <col class=xl6311921 width=110 style='mso-width-source:userset;mso-w=
idth-alt:
 4022;width:83pt'>
 <col class=xl6311921 width=101 style='mso-width-source:userset;mso-w=
idth-alt:
 3693;width:76pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl7511921 colspan=5 width=561 style='height=
:15.0pt;
  width:421pt'>List Employee</td>
  <td class=xl6411921 width=130 style='width:98pt'>&nbsp;</td>
  <td class=xl6411921 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl6411921 width=110 style='width:83pt'>&nbsp;</td>
  <td class=xl6411921 width=101 style='width:76pt'>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl6511921 style='height:15.0pt'>&nbsp;</td>
  <td class=xl6611921>&nbsp;</td>
  <td class=xl6611921>&nbsp;</td>
  <td class=xl6611921>&nbsp;</td>
  <td class=xl6611921>&nbsp;</td>
  <td class=xl6711921>&nbsp;</td>
  <td class=xl6611921>&nbsp;</td>
  <td class=xl6611921>&nbsp;</td>
  <td class=xl6611921>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl6511921 style='height:15.75pt'>&nbsp;</td>
  <td class=xl6611921>&nbsp;</td>
  <td class=xl6611921>&nbsp;</td>
  <td class=xl6611921>&nbsp;</td>
  <td class=xl6611921>&nbsp;</td>
  <td class=xl6611921>&nbsp;</td>
  <td class=xl6611921>&nbsp;</td>
  <td class=xl6611921>&nbsp;</td>
  <td class=xl6611921>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl6811921 style='height:15.0pt'>No</td>
  <td class=xl6911921>EMP_ID</td>
  <td class=xl6911921>FULLNAME</td>
  <td class=xl6911921>SEX</td>
  <td class=xl6911921>NATION</td>
  <td class=xl6911921>TEL</td>
  <td class=xl6911921>PK</td>
  <td class=xl6911921>JOINT_DT</td>
  <td class=xl7011921>BIRTHDAY</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl7111921 style='height:15.75pt'>STT</td>
  <td class=xl7211921>Mã NV</td>
  <td class=xl7211921>Họ Tên</td>
  <td class=xl7211921>Giới tính</td>
  <td class=xl7211921>Quốc tịch</td>
  <td class=xl7211921>SĐT</td>
  <td class=xl7211921>&nbsp;</td>
  <td class=xl7211921>Ngày bắt đầu</td>
  <td class=xl7311921>Ngày sinh</td>
 </tr>
<%
     int i = 0;	 
     double sum = 0;
     for (i = 0; i < emp_row; i++)
     {
         sum += i;
 %>

 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl7411921 style='height:15.0pt' x:num><% =i+1 %></td>
  <td class=xl7411921 style='border-left:none'><% =dt_emp.Rows[i]["EMP_ID"].ToString() %></td>
  <td class=xl7411921 style='border-left:none'><% =dt_emp.Rows[i]["FULL_NAME"].ToString() %></td>
  <td class=xl7411921 style='border-left:none'><% =dt_emp.Rows[i]["SEX"].ToString() %></td>
  <td class=xl7411921 style='border-left:none'><% =dt_emp.Rows[i]["CODE_NM"].ToString() %></td>
  <td class=xl7411921 style='border-left:none'><% =dt_emp.Rows[i]["TEL"].ToString() %></td>
  <td class=xl7411921 style='border-left:none'><% =dt_emp.Rows[i]["PK"].ToString() %></td>
  <td class=xl7411921 style='border-left:none'><% =dt_emp.Rows[i]["JOIN_DT"].ToString() %></td>
  <td class=xl7411921 style='border-left:none'><% =dt_emp.Rows[i]["BIRTH_DT"].ToString() %></td>
 </tr>
    <%
    }
    %>
    <tr height=22 style='height:16.5pt'>
  <td colspan=7 height=22 class=xl7411921 style='border-right:.5pt solid black;
  height:16.5pt'>Total <%=i%> employee(s)</td>
  <td class=xl7411921 width=222 style='width:167pt'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=140 style='width:105pt'></td>
  <td width=188 style='width:141pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=130 style='width:98pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=101 style='width:76pt'></td>
 </tr>

    
 <![endif]>
</table>

</div>


<!----------------------------->
<!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD-->
<!----------------------------->
</body>

</html>
