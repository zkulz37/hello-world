<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%

    string p_to, p_from, p_org, p_status, p_nation, p_month;


    p_org = Request["p_org"].ToString();
    p_status = Request["p_status"].ToString();
    p_nation = Request["p_nation"].ToString();
    p_from = Request["p_from"].ToString();
    p_to = Request["p_to"].ToString();
    p_month = Request["p_month"].ToString();

    string SQL
    = "select decode((select c.org_nm from comm.tco_org c where c.del_if=0 and nvl(b.p_pk,b.pk) = c.pk),'OFFICE','OFFICE','FACTORY') as col0  " + 
        ",b.ORG_NM col1 " +
        ",sum(case when a.JOIN_DT < '" + p_from + "' and nvl(a.LEFT_DT, '30000101') >= '" + p_from + "' then 1 else 0 end ) col2 " +
        ",sum(case when a.JOIN_DT <= '" + p_to + "' and nvl(a.LEFT_DT,'30000101') >'" + p_to + "' then 1 else 0 end) as col3  " +
        ",sum(case when a.JOIN_DT <= '" + p_to + "' and a.JOIN_DT between '" + p_from + "' and '" + p_to + "' then 1 else 0 end) col4 " +
        ",case when sum(case when a.JOIN_DT < '" + p_from + "' and nvl(a.LEFT_DT, '30000101') >= '" + p_from + "' then 1 else 0 end )=0 then 0 else  " +
        "round(sum(case when a.JOIN_DT <= '" + p_to + "' and a.JOIN_DT between '" + p_from + "' and '" + p_to + "' then 1 else 0 end) " +
        "/sum(case when a.JOIN_DT < '" + p_from + "' and nvl(a.LEFT_DT, '30000101') >= '" + p_from + "' then 1 else 0 end )*100,1) end col5 " +
        ",sum(case when a.JOIN_DT <= '" + p_to + "' and nvl(a.LEFT_DT,'30000101') between '" + p_from + "' and '" + p_to + "' then 1 else 0 end) col6 " +
        ",case when sum(case when a.JOIN_DT < '" + p_from + "' and nvl(a.LEFT_DT, '30000101') >= '" + p_from + "' then 1 else 0 end )=0 then 0 else  " +
        "round(sum(case when a.JOIN_DT <= '" + p_to + "' and nvl(a.LEFT_DT,'30000101') between '" + p_from + "' and '" + p_to + "' then 1 else 0 end) " +
        "/sum(case when a.JOIN_DT < '" + p_from + "' and nvl(a.LEFT_DT, '30000101') >= '" + p_from + "' then 1 else 0 end )*100,1) end col7 " +
        ",case when sum(case when a.JOIN_DT < '" + p_from + "' and nvl(a.LEFT_DT, '30000101') >= '" + p_from + "' then 1 else 0 end )=0 then 0 else  " +
        "round(abs(sum(case when a.JOIN_DT <= '" + p_to + "' and a.JOIN_DT between '" + p_from + "' and '" + p_to + "' then 1 else 0 end) " +
        "- sum(case when a.JOIN_DT <= '" + p_to + "' and nvl(a.LEFT_DT,'30000101') between '" + p_from + "' and '" + p_to + "' then 1 else 0 end)) " +
        "/sum(case when a.JOIN_DT < '" + p_from + "' and nvl(a.LEFT_DT, '30000101') >= '" + p_from + "' then 1 else 0 end )*100,1) end as col8 " +
        "from thr_employee a, comm.tco_org b " +
        "where a.del_if=0 and a.TCO_ORG_PK = b.pk " +
        "and a.NATION ='01' " +
            "and Decode('" + p_status + "','ALL','ALL', a.STATUS )= '" + p_status + "' " +
            "and Decode('" + p_nation + "','ALL','ALL', a.NATION )= '" + p_nation + "' " +
            " and (a.tco_org_pk in ( " +
            "                              SELECT     g.pk " +
            "                                    FROM comm.tco_org g " +
            "                                   WHERE g.del_if = 0 " +
            "                              START WITH g.pk = " +
            "                                            DECODE ('" + p_org + "', " +
            "                                                    'ALL', 0, " +
            "                                                    '" + p_org + "' " +
            "                                                   ) " +
            "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
            "                        OR '" + p_org + "' = 'ALL') " +
        "group by b.ORG_NM, a.TCO_ORG_PK, b.pk, b.P_PK " +
        "order by a.TCO_ORG_PK " ;


    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp, icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp = dt_Emp.Columns.Count;
    if (irow_emp == 0)
    {
        Response.Write("There is no data of salary");
        Response.End();
    }
//-----------------total --------------------
    string SQL_Total
    = "select  " +
        "sum(case when a.JOIN_DT < '" + p_from + "' and nvl(a.LEFT_DT, '30000101') >= '" + p_from + "' then 1 else 0 end ) col0 " +
        ",sum(case when a.JOIN_DT <= '" + p_to + "' and nvl(a.LEFT_DT,'30000101') >'" + p_to + "' then 1 else 0 end) as col1  " +
        ",sum(case when a.JOIN_DT <= '" + p_to + "' and a.JOIN_DT between '" + p_from + "' and '" + p_to + "' then 1 else 0 end) col2 " +
        ",case when sum(case when a.JOIN_DT < '" + p_from + "' and nvl(a.LEFT_DT, '30000101') >= '" + p_from + "' then 1 else 0 end )=0 then 0 else  " +
        "round(sum(case when a.JOIN_DT <= '" + p_to + "' and a.JOIN_DT between '" + p_from + "' and '" + p_to + "' then 1 else 0 end) " +
        "/sum(case when a.JOIN_DT < '" + p_from + "' and nvl(a.LEFT_DT, '30000101') >= '" + p_from + "' then 1 else 0 end )*100,1) end col3 " +
        ",sum(case when a.JOIN_DT <= '" + p_to + "' and nvl(a.LEFT_DT,'30000101') between '" + p_from + "' and '" + p_to + "' then 1 else 0 end) col4 " +
        ",case when sum(case when a.JOIN_DT < '" + p_from + "' and nvl(a.LEFT_DT, '30000101') >= '" + p_from + "' then 1 else 0 end )=0 then 0 else  " +
        "round(sum(case when a.JOIN_DT <= '" + p_to + "' and nvl(a.LEFT_DT,'30000101') between '" + p_from + "' and '" + p_to + "' then 1 else 0 end) " +
        "/sum(case when a.JOIN_DT < '" + p_from + "' and nvl(a.LEFT_DT, '30000101') >= '" + p_from + "' then 1 else 0 end )*100,1) end col5 " +
        ",case when sum(case when a.JOIN_DT < '" + p_from + "' and nvl(a.LEFT_DT, '30000101') >= '" + p_from + "' then 1 else 0 end )=0 then 0 else  " +
        "round(abs(sum(case when a.JOIN_DT <= '" + p_to + "' and a.JOIN_DT between '" + p_from + "' and '" + p_to + "' then 1 else 0 end) " +
        "- sum(case when a.JOIN_DT <= '" + p_to + "' and nvl(a.LEFT_DT,'30000101') between '" + p_from + "' and '" + p_to + "' then 1 else 0 end)) " +
        "/sum(case when a.JOIN_DT < '" + p_from + "' and nvl(a.LEFT_DT, '30000101') >= '" + p_from + "' then 1 else 0 end )*100,1) end as col_6 " +
        "from thr_employee a, comm.tco_org b " +
        "where a.del_if=0 and a.TCO_ORG_PK = b.pk " +
        "and a.NATION ='01' " +
            "and Decode('" + p_status + "','ALL','ALL', a.STATUS )= '" + p_status + "' " +
            "and Decode('" + p_nation + "','ALL','ALL', a.NATION )= '" + p_nation + "' " +
            " and (a.tco_org_pk in ( " +
            "                              SELECT     g.pk " +
            "                                    FROM comm.tco_org g " +
            "                                   WHERE g.del_if = 0 " +
            "                              START WITH g.pk = " +
            "                                            DECODE ('" + p_org + "', " +
            "                                                    'ALL', 0, " +
            "                                                    '" + p_org + "' " +
            "                                                   ) " +
            "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
            "                        OR '" + p_org + "' = 'ALL') " +
            "group by a.employee_type ";


    DataTable dt_total = ESysLib.TableReadOpen(SQL_Total);
    //-------------------------gtotal ----------
    string SQL_gTotal
    = "select  " +
       "sum(case when a.JOIN_DT < '" + p_from + "' and nvl(a.LEFT_DT, '30000101') >= '" + p_from + "' then 1 else 0 end ) col0 " +
        ",sum(case when a.JOIN_DT <= '" + p_to + "' and nvl(a.LEFT_DT,'30000101') >'" + p_to + "' then 1 else 0 end) as col1  " +
        ",sum(case when a.JOIN_DT <= '" + p_to + "' and a.JOIN_DT between '" + p_from + "' and '" + p_to + "' then 1 else 0 end) col2 " +
        ",case when sum(case when a.JOIN_DT < '" + p_from + "' and nvl(a.LEFT_DT, '30000101') >= '" + p_from + "' then 1 else 0 end )=0 then 0 else  " +
        "round(sum(case when a.JOIN_DT <= '" + p_to + "' and a.JOIN_DT between '" + p_from + "' and '" + p_to + "' then 1 else 0 end) " +
        "/sum(case when a.JOIN_DT < '" + p_from + "' and nvl(a.LEFT_DT, '30000101') >= '" + p_from + "' then 1 else 0 end )*100,1) end col3 " +
        ",sum(case when a.JOIN_DT <= '" + p_to + "' and nvl(a.LEFT_DT,'30000101') between '" + p_from + "' and '" + p_to + "' then 1 else 0 end) col4 " +
        ",case when sum(case when a.JOIN_DT < '" + p_from + "' and nvl(a.LEFT_DT, '30000101') >= '" + p_from + "' then 1 else 0 end )=0 then 0 else  " +
        "round(sum(case when a.JOIN_DT <= '" + p_to + "' and nvl(a.LEFT_DT,'30000101') between '" + p_from + "' and '" + p_to + "' then 1 else 0 end) " +
        "/sum(case when a.JOIN_DT < '" + p_from + "' and nvl(a.LEFT_DT, '30000101') >= '" + p_from + "' then 1 else 0 end )*100,1) end col5 " +
        ",case when sum(case when a.JOIN_DT < '" + p_from + "' and nvl(a.LEFT_DT, '30000101') >= '" + p_from + "' then 1 else 0 end )=0 then 0 else  " +
        "round(abs(sum(case when a.JOIN_DT <= '" + p_to + "' and a.JOIN_DT between '" + p_from + "' and '" + p_to + "' then 1 else 0 end) " +
        "- sum(case when a.JOIN_DT <= '" + p_to + "' and nvl(a.LEFT_DT,'30000101') between '" + p_from + "' and '" + p_to + "' then 1 else 0 end)) " +
        "/sum(case when a.JOIN_DT < '" + p_from + "' and nvl(a.LEFT_DT, '30000101') >= '" + p_from + "' then 1 else 0 end )*100,1) end as col_6 " +
        "from thr_employee a, comm.tco_org b " +
        "where a.del_if=0 and a.TCO_ORG_PK = b.pk " +
        "and a.NATION ='01' " +
            "and Decode('" + p_status + "','ALL','ALL', a.STATUS )= '" + p_status + "' " +
            "and Decode('" + p_nation + "','ALL','ALL', a.NATION )= '" + p_nation + "' " +
            " and (a.tco_org_pk in ( " +
            "                              SELECT     g.pk " +
            "                                    FROM comm.tco_org g " +
            "                                   WHERE g.del_if = 0 " +
            "                              START WITH g.pk = " +
            "                                            DECODE ('" + p_org + "', " +
            "                                                    'ALL', 0, " +
            "                                                    '" + p_org + "' " +
            "                                                   ) " +
            "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
            "                        OR '" + p_org + "' = 'ALL') ";


    DataTable dt_gtotal = ESysLib.TableReadOpen(SQL_gTotal);

    //----- Day info--
    string SQL_Day
    = "select " +
        "to_char(to_date('"+ p_month +"','yyyymm'),'MON-YYYY') as d1 " +
        ",to_char(to_date('" + p_from + "','YYYYMMDD'),'DD/MM/YYYY') as d2  " +
        ",to_char(to_date('" + p_to + "','YYYYMMDD'),'DD/MM/YYYY') as d3 " +
        ",to_char(sysdate,'dd/mm/yyyy') as d4 " +
        "from dual ";

    DataTable dt_Day = ESysLib.TableReadOpen(SQL_Day);

 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_manpower_month_vhpc_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_manpower_month_vhpc_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_manpower_month_vhpc_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>HR_PHU</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-04-22T05:56:22Z</o:LastPrinted>
  <o:Created>2011-02-08T01:52:52Z</o:Created>
  <o:LastSaved>2011-04-22T06:02:46Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .7in .75in .7in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;
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
	padding:0px;
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
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl80
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	color:windowtext;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl82
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl83
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl84
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl85
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl86
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl88
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl89
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl94
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl95
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl96
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Month Manpower</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>91</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11760</x:WindowHeight>
  <x:WindowWidth>19095</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="6145"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl69>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1008 style='border-collapse:
 collapse;table-layout:fixed;width:757pt'>
 <col class=xl69 width=50 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col class=xl69 width=132 style='mso-width-source:userset;mso-width-alt:4827;
 width:99pt'>
 <col class=xl69 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl69 width=105 span=2 style='mso-width-source:userset;mso-width-alt:
 3840;width:79pt'>
 <col class=xl69 width=96 span=4 style='mso-width-source:userset;mso-width-alt:
 3510;width:72pt'>
 <col class=xl69 width=101 style='mso-width-source:userset;mso-width-alt:3693;
 width:76pt'>
 <col class=xl69 width=64 style='width:48pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 width=50 style='height:15.75pt;width:38pt' align=left
  valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75" coordsize="21600,21600"
   o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe" filled="f"
   stroked="f">
   <v:stroke joinstyle="miter"/>
   <v:formulas>
    <v:f eqn="if lineDrawn pixelLineWidth 0"/>
    <v:f eqn="sum @0 1 0"/>
    <v:f eqn="sum 0 0 @1"/>
    <v:f eqn="prod @2 1 2"/>
    <v:f eqn="prod @3 21600 pixelWidth"/>
    <v:f eqn="prod @3 21600 pixelHeight"/>
    <v:f eqn="sum @0 0 1"/>
    <v:f eqn="prod @6 1 2"/>
    <v:f eqn="prod @7 21600 pixelWidth"/>
    <v:f eqn="sum @8 21600 0"/>
    <v:f eqn="prod @7 21600 pixelHeight"/>
    <v:f eqn="sum @10 21600 0"/>
   </v:formulas>
   <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
   <o:lock v:ext="edit" aspectratio="t"/>
  </v:shapetype><v:shape id="Picture_x0020_1" o:spid="_x0000_s1025" type="#_x0000_t75"
   style='position:absolute;margin-left:0;margin-top:0;width:96pt;height:31.5pt;
   z-index:1;visibility:visible'>
   <v:imagedata src="rpt_manpower_month_vhpc_files/image001.png" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:0px;width:128px;
  height:42px'><img width=128 height=42
  src="rpt_manpower_month_vhpc_files/image002.jpg" v:shapes="Picture_x0020_1"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=21 class=xl69 width=50 style='height:15.75pt;width:38pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl69 width=132 style='width:99pt'></td>
  <td class=xl69 colspan=4 width=373 style='mso-ignore:colspan;width:280pt'>POSCO
  VIETNAM<span style='mso-spacerun:yes'>  </span>PROCESSING CENTER CO., LTD</td>
  <td class=xl69 width=96 style='width:72pt'></td>
  <td class=xl69 width=96 style='width:72pt'></td>
  <td class=xl69 width=96 style='width:72pt'></td>
  <td class=xl69 width=101 style='width:76pt'></td>
  <td class=xl69 width=64 style='width:48pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=11 class=xl69 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=11 class=xl69 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=11 height=30 class=xl81 style='height:22.5pt'>TURN OVER OF<span
  style='mso-spacerun:yes'>  </span>MANPOWER IN <%= dt_Day.Rows[0][0].ToString() %></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=11 height=26 class=xl81 style='height:19.5pt'>From <%= dt_Day.Rows[0][1].ToString() %> to
  <%= dt_Day.Rows[0][2].ToString() %></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=8 class=xl68 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl69></td>
  <td class=xl73>Date : <%= dt_Day.Rows[0][3].ToString() %></td>
  <td class=xl68></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=11 class=xl69 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=42 style='mso-height-source:userset;height:31.5pt'>
  <td height=42 class=xl82 style='height:31.5pt'>No</td>
  <td class=xl82 style='border-left:none'>Department</td>
  <td rowspan=2 class=xl95 style='border-bottom:.5pt solid black'>Budget</td>
  <td rowspan=2 class=xl93 width=105 style='border-bottom:.5pt solid black;
  width:79pt'>Total of Employee<br>
    last month</td>
  <td rowspan=2 class=xl93 width=105 style='border-bottom:.5pt solid black;
  width:79pt'>Employee<br>
    current</td>
  <td colspan=2 class=xl83 style='border-right:.5pt solid black;border-left:
  none'>New Employee</td>
  <td colspan=2 class=xl83 style='border-right:.5pt solid black;border-left:
  none'>Resigned Employee</td>
  <td rowspan=2 class=xl93 width=101 style='border-bottom:.5pt solid black;
  width:76pt'>Turn over<br>
    (%)</td>
  <td class=xl82 style='border-left:none'>Remark</td>
 </tr>
 <tr class=xl68 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl85 style='height:23.25pt'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>Total</td>
  <td class=xl85 style='border-left:none'>Turn over (%)</td>
  <td class=xl85 style='border-left:none'>Total</td>
  <td class=xl85 style='border-left:none'>Turn over (%)</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
 </tr>
 <%
 
    int i;
    int count=1;
    int g = 0;
    Boolean flag = true;
    Boolean flag_total = false;
    string emp_type_old, emp_type_new;
    for (i = 0; i < irow_emp; i++)
    {

        emp_type_old = dt_Emp.Rows[i][0].ToString();

        if (flag)
        {
  %>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=11 height=32 class=xl74 style='border-right:.5pt solid black;
  height:24.0pt'> <%= dt_Emp.Rows[i][0].ToString()%> :</td>
 </tr>
 <%	
     flag = false;
 }
 %>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl71 style='height:24.0pt;border-top:none' x:num><%= count %></td>
  <td class=xl70 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][1].ToString() %></td>
  <td class=xl70 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                    </span><%= dt_Emp.Rows[i][2].ToString() %> </td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                    </span><%= dt_Emp.Rows[i][3].ToString() %> </td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                    </span><%= dt_Emp.Rows[i][4].ToString() %> </td>
  <td class=xl90 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_Emp.Rows[i][5].ToString() %> </td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                   </span><%= dt_Emp.Rows[i][6].ToString() %> </td>
  <td class=xl90 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_Emp.Rows[i][7].ToString() %> </td>
  <td class=xl90 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt_Emp.Rows[i][8].ToString() %> </td>
  <td class=xl70 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%
     
     if (i < irow_emp - 1)
     {
         count = count + 1;
         emp_type_new = dt_Emp.Rows[i + 1][0].ToString();
         if (emp_type_new != emp_type_old)
         {
             flag = true;
             flag_total = true;
         }
     }
     else
     {
         flag = true;
         flag_total = true;
     }
     if (flag_total)
     {
  %>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td colspan=3 height=33 class=xl77 style='border-right:.5pt solid black;
  height:24.75pt'>Total <%= dt_Emp.Rows[i][0].ToString() %></td>
  <td class=xl91 style='border-top:none;border-left:none' x:num><span style='mso-spacerun:yes'>                   
  </span><%= dt_total.Rows[g][0].ToString() %> </td>
  <td class=xl91 style='border-top:none;border-left:none' x:num><span style='mso-spacerun:yes'>                   
  </span><%= dt_total.Rows[g][1].ToString() %> </td>
  <td class=xl91 style='border-top:none;border-left:none' x:num><span style='mso-spacerun:yes'>                   
  </span><%= dt_total.Rows[g][2].ToString() %> </td>
  <td class=xl92 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_total.Rows[g][3].ToString() %> </td>
  <td class=xl91 style='border-top:none;border-left:none' x:num><span style='mso-spacerun:yes'>                  
  </span><%= dt_total.Rows[g][4].ToString() %> </td>
  <td class=xl92 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_total.Rows[g][5].ToString() %> </td>
  <td class=xl92 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt_total.Rows[g][6].ToString() %> </td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%
     g++;
     flag_total = false;
     }
} 
  %>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=3 height=30 class=xl86 style='border-right:.5pt solid black;
  height:22.5pt'>Grand total</td>
  <td class=xl91 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                    </span><%= dt_gtotal.Rows[0][0].ToString() %> </td>
  <td class=xl91 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                    </span><%= dt_gtotal.Rows[0][1].ToString() %> </td>
  <td class=xl91 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                    </span><%= dt_gtotal.Rows[0][2].ToString() %> </td>
  <td class=xl92 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_gtotal.Rows[0][3].ToString() %> </td>
  <td class=xl91 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                   </span><%= dt_gtotal.Rows[0][4].ToString() %> </td>
  <td class=xl92 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= dt_gtotal.Rows[0][5].ToString() %> </td>
  <td class=xl92 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt_gtotal.Rows[0][6].ToString() %> </td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=11 class=xl69 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl72 style='height:15.75pt'></td>
  <td colspan=10 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=50 style='width:38pt'></td>
  <td width=132 style='width:99pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
