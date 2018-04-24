<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%

	string p_org;
  
    p_org    = Request["p21"].ToString();
	
	string SQL
	= "select e.emp_id, " + 
        "       e.full_name, " +
        "       e.level1_sal, " +
        "       to_char( e.basic_sal, '999,999,999' ) basic_sal, " +
        "       to_char( to_date( e.join_dt, 'yyyymmdd' ), 'DD/MM/YYYY' ) join_dt " +
        "from   thr_employee e " +
        "where  e.del_if = 0 and e.tco_org_pk =  " + p_org ;

	DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp=dt_Emp.Columns.Count;
    if (irow_emp == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 15">
<link id=Main-File rel=Main-File href="../test_report.htm">
<link rel=File-List href=filelist.xml>
<link rel=Stylesheet href=stylesheet.css>
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .7in .75in .7in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;}
-->
</style>
<![if !supportTabStrip]><script language="JavaScript">
<!--
function fnUpdateTabs()
 {
  if (parent.window.g_iIEVer>=4) {
   if (parent.document.readyState=="complete"
    && parent.frames['frTabs'].document.readyState=="complete")
   parent.fnSetActiveSheet(0);
  else
   window.setTimeout("fnUpdateTabs();",150);
 }
}

if (window.name!="frSheet")
 window.location.replace("../test_report.htm");
else
 fnUpdateTabs();
//-->
</script>
<![endif]>
</head>

<body link="#0563C1" vlink="#954F72">

<table border=0 cellpadding=0 cellspacing=0 width=581 style='border-collapse:
 collapse;table-layout:fixed;width:436pt'>
 <col width=64 span=2 style='width:48pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:3657;width:75pt'>
 <col width=97 style='mso-width-source:userset;mso-width-alt:3547;width:73pt'>
 <col width=64 span=4 style='width:48pt'>
 <tr height=20 style='height:15.0pt'>
  <td colspan=5 height=20 class=xl65 width=389 style='height:15.0pt;width:292pt'>Thông
  tin nhân viên</td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 style='height:15.0pt'>Emp ID</td>
  <td>Tên</td>
  <td>Lương thử việc</td>
  <td>Lương căn bản</td>
  <td>Ngày vào</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <%
	for(int i=0;i<irow_emp;i++)
	{
 %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 style='height:15.0pt'><%=dt_Emp.Rows[i]["emp_id"].ToString() %></td>
  <td><%=dt_Emp.Rows[i]["full_name"].ToString() %></td>
  <td x:num><%=dt_Emp.Rows[i]["level1_sal"].ToString() %></td>
  <td x:num><%=dt_Emp.Rows[i]["basic_sal"].ToString() %></td>
  <td x:str><%=dt_Emp.Rows[i]["join_dt"].ToString() %></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <%
	}
 %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
