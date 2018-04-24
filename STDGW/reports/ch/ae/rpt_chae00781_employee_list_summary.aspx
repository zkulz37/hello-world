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
        "             A.NATION, " +
        "             A.TEL, " +
        "             A.PK, " +
        "             to_char(to_date(A.JOIN_DT,'YYYYMMDD'),'DD-MM-YYYY') as JOIN_DT, " +
        " case when length(A.BIRTH_DT) = 4 then A.BIRTH_DT " +
        " when  length(A.BIRTH_DT) = 6 then to_char(to_date(A.BIRTH_DT,'YYYYMMDD'),'MM-YYYY') " +
        " else to_char(to_date(A.BIRTH_DT,'YYYYMMDD'),'DD-MM-YYYY') " +
        " end as BIRTH_DT " +
        "        FROM THR_EMPLOYEE A " +
        "       WHERE A.DEL_IF = 0  " +
        "       and decode( '" + TCO_ORG_PK + "', 'ALL', 'ALL', A.TCO_ORG_PK ) = '" + TCO_ORG_PK + "' " +
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
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 15">
<link rel=File-List
href="rpt_chae00781_employee_list015432admin_files/filelist.xml">
<style id="rpt_chae00781_employee_list_summary_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.xl1531759
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
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6331759
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
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6431759
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
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:black none;
	white-space:nowrap;}
.xl6531759
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
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:black none;
	white-space:nowrap;}
.xl6631759
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
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:black none;
	white-space:nowrap;}
.xl6731759
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
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	background:#CCFFCC;
	mso-pattern:black none;
	white-space:nowrap;}
.xl6831759
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
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:black none;
	white-space:nowrap;}
.xl6931759
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
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:black none;
	white-space:nowrap;}
.xl7031759
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
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	background:#FF99CC;
	mso-pattern:black none;
	white-space:nowrap;}
-->
</style>
</head>

<body>
<!--[if !excel]>&nbsp;&nbsp;<![endif]-->
<!--The following information was generated by Microsoft Excel's Publish as Web
Page wizard.-->
<!--If the same item is republished from Excel, all information between the DIV
tags will be replaced.-->
<!----------------------------->
<!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD -->
<!----------------------------->

<div id="rpt_chae00781_employee_list_summary" align=center
x:publishsource="Excel">

<table border=0 cellpadding=0 cellspacing=0 width=966 style='border-collapse:
 collapse;table-layout:fixed;width:726pt'>
 <col width=64 style='width:48pt'>
 <col width=140 style='mso-width-source:userset;mso-width-alt:5120;width:105pt'>
 <col width=188 style='mso-width-source:userset;mso-width-alt:6875;width:141pt'>
 <col width=64 style='width:48pt'>
 <col width=105 style='mso-width-source:userset;mso-width-alt:3840;width:79pt'>
 <col width=130 style='mso-width-source:userset;mso-width-alt:4754;width:98pt'>
 <col width=64 style='width:48pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=101 style='mso-width-source:userset;mso-width-alt:3693;width:76pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl6431759 width=64 style='height:15.0pt;width:48pt'>&nbsp;</td>
  <td class=xl6531759 width=140 style='width:105pt'>&nbsp;</td>
  <td class=xl6531759 width=188 style='width:141pt'>&nbsp;</td>
  <td class=xl6531759 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl6531759 width=105 style='width:79pt'>&nbsp;</td>
  <td class=xl6531759 width=130 style='width:98pt'>&nbsp;</td>
  <td class=xl6531759 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl6531759 width=110 style='width:83pt'>&nbsp;</td>
  <td class=xl6531759 width=101 style='width:76pt'>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl6631759 style='height:15.0pt'>&nbsp;</td>
  <td class=xl6731759>&nbsp;</td>
  <td class=xl6731759>&nbsp;</td>
  <td class=xl6731759>&nbsp;</td>
  <td class=xl6731759>&nbsp;</td>
  <td class=xl6731759>List Employee</td>
  <td class=xl6731759>&nbsp;</td>
  <td class=xl6731759>&nbsp;</td>
  <td class=xl6731759>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl6831759 style='height:15.0pt'>&nbsp;</td>
  <td class=xl6931759>&nbsp;</td>
  <td class=xl6931759>&nbsp;</td>
  <td class=xl6931759>&nbsp;</td>
  <td class=xl6931759>&nbsp;</td>
  <td class=xl6931759>&nbsp;</td>
  <td class=xl6931759>&nbsp;</td>
  <td class=xl6931759>&nbsp;</td>
  <td class=xl6931759>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl7031759 style='height:15.0pt'>No</td>
  <td class=xl7031759>EMP_ID</td>
  <td class=xl7031759>FULLNAME</td>
  <td class=xl7031759>SEX</td>
  <td class=xl7031759>NATION</td>
  <td class=xl7031759>TEL</td>
  <td class=xl7031759>PK</td>
  <td class=xl7031759>JOINT_DT</td>
  <td class=xl7031759>BIRTHDAY</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl7031759 style='height:15.0pt'>STT</td>
  <td class=xl7031759>Mã NV</td>
  <td class=xl7031759>H&#7885; Tên</td>
  <td class=xl7031759>Gi&#7899;i tính</td>
  <td class=xl7031759>Qu&#7889;c t&#7883;ch</td>
  <td class=xl7031759>S&#272;T</td>
  <td class=xl7031759>&nbsp;</td>
  <td class=xl7031759>Ngày b&#7855;t &#273;&#7847;u</td>
  <td class=xl7031759>Ngày sinh</td>
 </tr>

 
 <%
     int i = 0;	 
     double sum = 0;
     for (i = 0; i < emp_row; i++)
     {
         //sum += Double.Parse(dt_emp.Rows[i][6].ToString());
 %>
 <tr class=xl26 height=22 style='height:16.5pt'>
  <td height=22 class=xl31 style='height:16.5pt;border-top:none' x:num><%=i+1 %></td>
  <td class=xl32 style='border-top:none'><%=dt_emp.Rows[i]["EMP_ID"].ToString() %></td>
  <td class=xl32 style='border-top:none'><%=dt_emp.Rows[i]["FULL_NAME"].ToString() %></td>
  <td class=xl33 style='border-top:none'><%=dt_emp.Rows[i]["SEX"].ToString() %></td>
  <td class=xl34 style='border-top:none'><%=dt_emp.Rows[i]["NATION"].ToString() %></td>
  <td class=xl35 style='border-top:none'><%=dt_emp.Rows[i]["TEL"].ToString() %></td>
  <td class=xl35 style='border-top:none'><%=dt_emp.Rows[i]["PK"].ToString() %></td>
  <td class=xl36 style='border-top:none' x:num><%=dt_emp.Rows[i]["JOIN_DT"].ToString() %></td>
  <td class=xl37 width=222 style='border-top:none;width:167pt'><%=dt_emp.Rows[i]["BIRTH_DT"].ToString() %></td>
 </tr>
 <%
     }
 %>
 <tr height=22 style='height:16.5pt'>
  <td colspan=7 height=22 class=xl55 style='border-right:.5pt solid black;
  height:16.5pt'>Total <%=i%> employee(s)</td>
  <td class=xl45 x:num><%=sum %> </td>
  <td class=xl44 width=222 style='width:167pt'>&nbsp;</td>
 </tr>  
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl1531759 style='height:15.0pt'></td>
  <td class=xl1531759></td>
  <td class=xl1531759></td>
  <td class=xl1531759></td>
  <td class=xl1531759></td>
  <td class=xl1531759></td>
  <td class=xl6331759></td>
  <td class=xl1531759></td>
  <td class=xl1531759></td>
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
