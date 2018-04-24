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
    string l_group = Request.QueryString["l_group"].ToString();
    string l_m_type = Request.QueryString["l_m_type"].ToString();
    string l_bn_times = Request.QueryString["l_bn_times"].ToString();
    string l_emp_id = Request.QueryString["l_emp_id"].ToString();
    string l_dept = Request.QueryString["l_dept"].ToString();
    string l_year = Request.QueryString["l_year"].ToString();
    
    string SQL
	= "SELECT e.partner_name a0,d.org_nm a2, " +
        "         count(b.thr_emp_pk), " +
        "         sum(nvl(b.BONUS_ALE_ADV_AMT,0)) a29 " +
        "    FROM thr_employee a, " +
        "         thr_bonus b, " +
        "         thr_annual_leave c, " +
        "         tco_org d, " +
        "         tco_company e " +
        "   WHERE     a.del_if = 0 " +
        "         AND b.del_if = 0 " +
        "         AND c.del_if(+) = 0 " +
        "         AND d.del_if = 0 " +
        "         AND e.del_if = 0 " +
        "         AND a.tco_org_pk = d.pk " +
        "         AND a.tco_company_pk = e.pk " +
        "         AND b.thr_emp_pk = a.pk " +
        "         AND b.thr_emp_pk = c.thr_emp_pk(+) " +
        "  and b.BN_YEAR='" + l_year + "' " +
        "  and c.an_year(+)='" + l_year + "'  " +
        "     and nvl(b.PAY_TYPE,'01')='02' " +
        "    and decode('" + l_m_type + "','ALL','" + l_m_type + "',b.MONEY_KIND)='" + l_m_type + "'  " +
        "    and decode('" + l_bn_times + "','ALL','" + l_bn_times + "',b.BN_TIMES)='" + l_bn_times + "'  " +
        "    and (a.EMP_ID like  '%'||'" + l_emp_id + "'||'%' or '" + l_emp_id + "' is null) " +
        "    and (a.tco_org_PK in   (  " +
        "                              SELECT     g.pk  " +
        "                                    FROM tco_org g  " +
        "                                   WHERE g.del_if = 0  " +
                "                              START WITH g.pk =  " +
        "                                            DECODE ('" + l_dept + "',  " +
        "                                                    'ALL', 0,  " +
        "                                                    '" + l_dept + "'  " +
        "                                                   )  " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "            OR '" + l_dept + "' = 'ALL')  " +
        "         AND B.STATUS='A' " +
        "group by d.pk,e.pk,d.org_nm,e.partner_name " +
        "   UNION ALL       " +
        " SELECT max(e.partner_name) a0,'INTERRUPT' a2, " +
        "         count(b.thr_emp_pk), " +
        "         sum(nvl(b.BONUS_ALE_ADV_AMT,0)) a29 " +
        "    FROM thr_employee a, " +
        "         thr_bonus b, " +
        "         thr_annual_leave c, " +
        "         tco_org d, " +
        "         tco_company e " +
        "   WHERE     a.del_if = 0 " +
        "         AND b.del_if = 0 " +
        "         AND c.del_if(+) = 0 " +
        "         AND d.del_if = 0 " +
        "         AND e.del_if = 0 " +
        "         AND a.tco_org_pk = d.pk " +
        "         AND a.tco_company_pk = e.pk " +
        "         AND b.thr_emp_pk = a.pk " +
        "         AND b.thr_emp_pk = c.thr_emp_pk(+) " +
        "  and b.BN_YEAR='" + l_year + "' " +
        "  and c.an_year(+)='" + l_year + "'  " +
        "    and nvl(b.PAY_TYPE,'01')='02' " +
        "    and decode('" + l_m_type + "','ALL','" + l_m_type + "',b.MONEY_KIND)='" + l_m_type + "'  " +
        "    and decode('" + l_bn_times + "','ALL','" + l_bn_times + "',b.BN_TIMES)='" + l_bn_times + "'  " +
        "    and (a.EMP_ID like  '%'||'" + l_emp_id + "'||'%' or '" + l_emp_id + "' is null) " +
        "    and (a.tco_org_PK in   (  " +
        "                              SELECT     g.pk  " +
        "                                    FROM tco_org g  " +
        "                                   WHERE g.del_if = 0  " +
                "                              START WITH g.pk =  " +
        "                                            DECODE ('" + l_dept + "',  " +
        "                                                    'ALL', 0,  " +
        "                                                    '" + l_dept + "'  " +
        "                                                   )  " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "            OR '" + l_dept + "' = 'ALL')  " +
        "         AND B.STATUS='R'         " +
        "order by a0,a2 " ;

  //  Response.Write(SQL);
  //  Response.End();
    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
    int emp_row=dt_emp.Rows.Count;
    int emp_col = dt_emp.Columns.Count;
    if (dt_emp.Rows.Count == 0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }


        
 %>

        
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_bonus_sign_bank_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_bonus_sign_bank_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_bonus_sign_bank_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Nguyen Cong Thanh</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2007-01-26T09:03:27Z</o:LastPrinted>
  <o:Created>2006-07-26T11:13:50Z</o:Created>
  <o:LastSaved>2012-08-16T02:27:47Z</o:LastSaved>
  <o:Company>Microsoft Corporation</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.31in .17in .25in .17in;
	mso-header-margin:.17in;
	mso-footer-margin:.21in;}
.font10
	{color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
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
.style22
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
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"Normal_Salary MAY 2006";}
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
.xl25
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style22;
	font-size:16.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style22;
	font-size:18.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style22;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style22;
	color:white;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl34
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;}
.xl35
	{mso-style-parent:style22;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style22;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl41
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single-accounting;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style22;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style22;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl47
	{mso-style-parent:style16;
	font-size:16.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\0022$\0022\#\,\#\#0\.00";
	vertical-align:middle;}
.xl48
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl49
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl50
	{mso-style-parent:style22;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style16;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl52
	{mso-style-parent:style22;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl53
	{mso-style-parent:style16;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;}
.xl54
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl55
	{mso-style-parent:style22;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl56
	{mso-style-parent:style22;
	font-size:16.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl57
	{mso-style-parent:style22;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl58
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl59
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl60
	{mso-style-parent:style22;
	font-size:18.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl61
	{mso-style-parent:style22;
	font-size:18.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl62
	{mso-style-parent:style16;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl63
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl64
	{mso-style-parent:style22;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl65
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl66
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl67
	{mso-style-parent:style22;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl68
	{mso-style-parent:style22;
	font-size:17.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:justify;}
.xl69
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style22;
	font-size:16.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl71
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline black;
	border-left:2.0pt double windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl73
	{mso-style-parent:style22;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl74
	{mso-style-parent:style22;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline black;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl75
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl76
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline black;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl77
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl78
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline black;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>465</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:ConditionalFormatting>
     <x:Range>$B$7</x:Range>
     <x:Condition>
      <x:Value1>$H$6&lt;0</x:Value1>
      <x:Format Style='background:#FF99CC'/>
     </x:Condition>
    </x:ConditionalFormatting>
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
  <x:WindowHeight>9570</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1980</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$5:$6</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=709 style='border-collapse:
 collapse;table-layout:fixed;width:533pt'>
 <col class=xl26 width=36 style='mso-width-source:userset;mso-width-alt:1316;
 width:27pt'>
 <col class=xl27 width=142 style='mso-width-source:userset;mso-width-alt:5193;
 width:107pt'>
 <col class=xl26 width=58 style='mso-width-source:userset;mso-width-alt:2121;
 width:44pt'>
 <col class=xl26 width=152 style='mso-width-source:userset;mso-width-alt:5558;
 width:114pt'>
 <col class=xl25 width=163 style='mso-width-source:userset;mso-width-alt:5961;
 width:122pt'>
 <col class=xl25 width=158 style='mso-width-source:userset;mso-width-alt:5778;
 width:119pt'>
 <tr height=29 style='height:21.75pt'>
  <td colspan=6 height=29 class=xl68 width=709 style='height:21.75pt;
  width:533pt'>GENERAL BONUS IN DECEMBER <%=l_year %> ( <%=dt_emp.Rows[0][0].ToString()%> )</td>
 </tr>
 
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'></td>
  <td class=xl29></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl30 style='height:18.0pt'></td>
  <td colspan=3 class=xl70>Payment date<font class="font10">: 02-FEB-<%=int.Parse(l_year)+1 %></font></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl32 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td rowspan=2 height=37 class=xl71 style='border-bottom:.5pt hairline black;
  height:27.75pt'>NO.</td>
  <td rowspan=2 class=xl73 style='border-bottom:.5pt hairline black;border-top:
  none'>SECTION</td>
  <td rowspan=2 class=xl75 width=58 style='border-bottom:.5pt hairline black;
  border-top:none;width:44pt' x:str="Q'TY"><span
  style='mso-spacerun:yes'> </span>Q'TY<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl75 width=152 style='border-bottom:.5pt hairline black;
  border-top:none;width:114pt' x:str="ACTUALLY PAY"><span
  style='mso-spacerun:yes'> </span>ACTUALLY PAY<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl75 width=163 style='border-bottom:.5pt hairline black;
  width:122pt' x:str="SIGNATURE"><span
  style='mso-spacerun:yes'> </span>SIGNATURE<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl77 width=158 style='border-bottom:.5pt hairline black;
  width:119pt' x:str="RECEIVER"><span
  style='mso-spacerun:yes'> </span>RECEIVER<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl32 height=20 style='height:15.0pt'>
 </tr>
 <% 
    double Group_Total_E=0,Group_Total_A=0;
    for(int i=0;i<emp_row;i++)
    { 
          Group_Total_E+=Double.Parse(dt_emp.Rows[i][2].ToString());
          Group_Total_A+=Double.Parse(dt_emp.Rows[i][3].ToString());
        
    %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl34 style='height:17.25pt' x:num><%=i+1 %></td>
  <td class=xl35><%=dt_emp.Rows[i][1].ToString() %></td>
  <td class=xl36 x:num><%=dt_emp.Rows[i][2].ToString() %></td>
  <td class=xl37 x:num><%=dt_emp.Rows[i][3].ToString() %></td>
  <td class=xl38>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
 </tr>
<%} %>

 <tr class=xl40 height=28 style='height:21.0pt'>
  <td colspan=2 height=28 class=xl65 style='border-right:.5pt solid black;
  height:21.0pt'>TOTAL</td>
  <td class=xl41 x:num><%=Group_Total_E %></td>
  <td class=xl42 x:num><%=Group_Total_A %></td>
  <td class=xl43>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
 </tr>
 <tr height=32 style='height:24.0pt'>
  <td height=32 class=xl30 style='height:24.0pt'></td>
  <td class=xl45></td>
  <td class=xl46></td>
  <td class=xl47 align=right x:num><%=Group_Total_A/20000 %></td>
  <td class=xl48></td>
  <td class=xl49></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=2 height=31 class=xl50 style='height:23.25pt'><span
  style='mso-spacerun:yes'>         </span>PREPARED BY</td>
  <td colspan=2 class=xl67 x:str="    CHECKED BY "><span
  style='mso-spacerun:yes'>     </span>CHECKED BY<span
  style='mso-spacerun:yes'>  </span></td>
  <td class=xl50 x:str="        CONFIRMED BY            "><span
  style='mso-spacerun:yes'>        </span>CONFIRMED BY<span
  style='mso-spacerun:yes'>            </span></td>
  <td class=xl50 x:str="                   APPROVED BY         "><span
  style='mso-spacerun:yes'>                   </span>APPROVED BY<span
  style='mso-spacerun:yes'>         </span></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl30 style='height:12.75pt'></td>
  <td class=xl45></td>
  <td class=xl46></td>
  <td class=xl51></td>
  <td colspan=2 class=xl50 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl30 style='height:12.75pt'></td>
  <td class=xl52></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl54 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl30 style='height:12.75pt'></td>
  <td class=xl52></td>
  <td colspan=2 class=xl55 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl54 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl56 style='height:15.0pt'></td>
  <td class=xl52></td>
  <td colspan=2 class=xl55 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl54 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl56 style='height:15.75pt'></td>
  <td class=xl52></td>
  <td colspan=2 class=xl55 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl54 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl56 style='height:13.5pt'></td>
  <td class=xl52></td>
  <td class=xl55></td>
  <td class=xl46></td>
  <td colspan=2 class=xl54 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=2 height=31 class=xl57 style='height:23.25pt'>MAI THÚY LINH</td>
  <td colspan=2 class=xl57>DƯƠNG THỊ BÌNH</td>
  <td class=xl57><span style='mso-spacerun:yes'> </span>DO IL HO</td>
  <td class=xl57 x:str="        KIM CHUNG KUK "><span
  style='mso-spacerun:yes'>        </span>KIM CHUNG KUK<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl58 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl59 style='height:15.0pt'><span
  style='mso-spacerun:yes'>       </span>PAYROLL STAFF</td>
  <td colspan=2 class=xl59><span style='mso-spacerun:yes'> </span>ADMIN-HR
  MANAGER</td>
  <td class=xl59><span style='mso-spacerun:yes'> </span>OFFICE MANAGER</td>
  <td class=xl59><span style='mso-spacerun:yes'>       </span>GENERAL DIRECTOR</td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 class=xl56 style='height:23.25pt'></td>
  <td class=xl61></td>
  <td colspan=2 class=xl56 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl54 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 class=xl56 style='height:23.25pt'></td>
  <td class=xl61></td>
  <td colspan=2 class=xl56 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl54 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 class=xl56 style='height:23.25pt'></td>
  <td class=xl61></td>
  <td colspan=2 class=xl56 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl54 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 class=xl56 style='height:23.25pt'></td>
  <td class=xl61></td>
  <td colspan=2 class=xl56 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl54 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 class=xl56 style='height:23.25pt'></td>
  <td class=xl60></td>
  <td class=xl56></td>
  <td class=xl62></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 class=xl56 style='height:23.25pt'></td>
  <td class=xl60></td>
  <td class=xl56></td>
  <td class=xl62></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 class=xl56 style='height:23.25pt'></td>
  <td class=xl60></td>
  <td class=xl56></td>
  <td class=xl62></td>
  <td class=xl33></td>
  <td class=xl63></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 class=xl56 style='height:23.25pt'></td>
  <td class=xl60></td>
  <td class=xl56></td>
  <td class=xl62></td>
  <td class=xl33></td>
  <td class=xl50></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 class=xl56 style='height:23.25pt'></td>
  <td class=xl60></td>
  <td class=xl56></td>
  <td class=xl62></td>
  <td class=xl33></td>
  <td class=xl57></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 class=xl56 style='height:23.25pt'></td>
  <td class=xl60></td>
  <td class=xl56></td>
  <td class=xl62></td>
  <td class=xl33></td>
  <td class=xl57></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 class=xl56 style='height:23.25pt'></td>
  <td class=xl60></td>
  <td class=xl56></td>
  <td class=xl62></td>
  <td class=xl33></td>
  <td class=xl57></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 class=xl56 style='height:23.25pt'></td>
  <td class=xl60></td>
  <td class=xl56></td>
  <td class=xl62></td>
  <td class=xl33></td>
  <td class=xl57></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 class=xl56 style='height:23.25pt'></td>
  <td class=xl60></td>
  <td class=xl56></td>
  <td class=xl62></td>
  <td class=xl33></td>
  <td class=xl57></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 class=xl56 style='height:23.25pt'></td>
  <td class=xl60></td>
  <td class=xl56></td>
  <td class=xl62></td>
  <td class=xl33></td>
  <td class=xl64></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 class=xl56 style='height:23.25pt'></td>
  <td class=xl60></td>
  <td class=xl56></td>
  <td class=xl62></td>
  <td class=xl33></td>
  <td class=xl54></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=36 style='width:27pt'></td>
  <td width=142 style='width:107pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=152 style='width:114pt'></td>
  <td width=163 style='width:122pt'></td>
  <td width=158 style='width:119pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
