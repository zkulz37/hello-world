﻿<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    
    string p_year = Request.QueryString["p_1"].ToString();
    string p_nation, p_org_pk, p_status;    
    p_nation = Request["p_nation"].ToString();
    p_org_pk = Request["p_org"].ToString();
    p_status = Request["p_status"].ToString();
           
    string SQL
    = "select (SELECT   max(T.org_nm)  " +
        "                                    FROM tco_org t  " +
        "                                    WHERE t.del_if = 0  " +
        "                                    AND T.ORG_TYPE IN('03')  " +
        "                                    START WITH t.pk=sub.tco_org_pk  " +
        "                                    CONNECT BY PRIOR t.p_pk=t.pk) AS fact ,  " +
        "      (SELECT   max(T.org_nm)  " +
        "                                    FROM tco_org t  " +
        "                                    WHERE t.del_if = 0  " +
        "                                    AND T.ORG_TYPE IN('06')  " +
        "                                    START WITH t.pk=sub.tco_org_pk  " +
        "                                    CONNECT BY PRIOR t.p_pk=t.pk) AS dept,  " +
        "      (SELECT   max(T.org_nm)  " +
        "                                    FROM tco_org t  " +
        "                                    WHERE t.del_if = 0  " +
        "                                    AND T.ORG_TYPE IN('07','12')  " +
        "                                    START WITH t.pk=sub.tco_org_pk  " +
        "                                    CONNECT BY PRIOR t.p_pk=t.pk) AS org_nm "+
        "    ,nvl(sub.t01,0),nvl(sub.t02,0),nvl(sub.t03,0) " +
        "    ,nvl(sub.t04,0),nvl(sub.t05,0),nvl(sub.t06,0) " +
        "    ,nvl(sub.t07,0),nvl(sub.t08,0),nvl(sub.t09,0) " +
        "    ,nvl(sub.t10,0),nvl(sub.t11,0),nvl(sub.t12,0)   " +
         "   ,nvl(sub.t01,0)+nvl(sub.t02,0)+nvl(sub.t03,0) " +
        "    +nvl(sub.t04,0)+nvl(sub.t05,0)+nvl(sub.t06,0) " +
        "    +nvl(sub.t07,0)+nvl(sub.t08,0)+nvl(sub.t09,0) " +
        "    +nvl(sub.t10,0)+nvl(sub.t11,0)+nvl(sub.t12,0)   " +
        "from tco_org g " +
        "    ,(  select E.TCO_ORG_PK " +
        "             ,sum(case when substr(e.join_dt,1,6)='" + p_year + "'||'01' and nvl(e.left_dt,'99999999')>'" + p_year + "'||'0131'  then 1 else 0 end )   t01 " +
        "             ,sum(case when substr(e.join_dt,1,6)='" + p_year + "'||'02' and nvl(e.left_dt,'99999999')>'" + p_year + "'||'0231' then 1 else 0 end )   t02 " +
        "             ,sum(case when substr(e.join_dt,1,6)='" + p_year + "'||'03' and nvl(e.left_dt,'99999999')>'" + p_year + "'||'0331' then 1 else 0 end )   t03 " +
        "             ,sum(case when substr(e.join_dt,1,6)='" + p_year + "'||'04' and nvl(e.left_dt,'99999999')>'" + p_year + "'||'0431' then 1 else 0 end )   t04 " +
        "             ,sum(case when substr(e.join_dt,1,6)='" + p_year + "'||'05' and nvl(e.left_dt,'99999999')>'" + p_year + "'||'0531' then 1 else 0 end )   t05 " +
        "             ,sum(case when substr(e.join_dt,1,6)='" + p_year + "'||'06' and nvl(e.left_dt,'99999999')>'" + p_year + "'||'0631' then 1 else 0 end )   t06 " +
        "             ,sum(case when substr(e.join_dt,1,6)='" + p_year + "'||'07' and nvl(e.left_dt,'99999999')>'" + p_year + "'||'0731' then 1 else 0 end )   t07 " +
        "             ,sum(case when substr(e.join_dt,1,6)='" + p_year + "'||'08' and nvl(e.left_dt,'99999999')>'" + p_year + "'||'0831' then 1 else 0 end )   t08 " +
        "             ,sum(case when substr(e.join_dt,1,6)='" + p_year + "'||'09' and nvl(e.left_dt,'99999999')>'" + p_year + "'||'0931' then 1 else 0 end )   t09 " +
        "             ,sum(case when substr(e.join_dt,1,6)='" + p_year + "'||'10' and nvl(e.left_dt,'99999999')>'" + p_year + "'||'1031' then 1 else 0 end )   t10 " +
        "             ,sum(case when substr(e.join_dt,1,6)='" + p_year + "'||'11' and nvl(e.left_dt,'99999999')>'" + p_year + "'||'1131' then 1 else 0 end )   t11 " +
        "             ,sum(case when substr(e.join_dt,1,6)='" + p_year + "'||'12' and nvl(e.left_dt,'99999999')>'" + p_year + "'||'1231' then 1 else 0 end )   t12 " +
        "        from   thr_employee e " +
        "        where e.DEL_IF=0 "+
        "        and substr(e.join_dt,1,4)<='"+p_year+"' " +
         " and decode('" + p_nation + "','ALL','ALL',e.nation)='" + p_nation + "' " +
         " and decode('" + p_status + "','ALL','ALL',e.status)='" + p_status + "' " +
             " AND (   e.tco_org_pk IN ( " +
             "                         SELECT     g.pk " +
             "                               FROM tco_org g " +
             "                              WHERE g.del_if = 0 " +
             "                         START WITH g.pk = " +
             "                                       DECODE ('" + p_org_pk + "', " +
             "                                               'ALL', 0, " +
             "                                               '" + p_org_pk + "'" +
             "                                              ) " +
             "                         CONNECT BY PRIOR g.pk = g.p_pk) " +
             "                   OR '" + p_org_pk + "' = 'ALL') " +
        "        group by E.TCO_ORG_PK ) sub " +
        "where G.PK=sub.TCO_ORG_PK " +
        "and G.P_PK is not null " +
        "order by nvl(g.seq,999999999),1,2,3 ";

    DataTable dt_s = ESysLib.TableReadOpen(SQL);

    if (dt_s.Rows.Count == 0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }


     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_active_employee_year_hyosung_files/filelist.xml">
<link rel=Edit-Time-Data
href="rpt_active_employee_year_hyosung_files/editdata.mso">
<link rel=OLE-Object-Data
href="rpt_active_employee_year_hyosung_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2011-07-15T03:03:38Z</o:LastPrinted>
  <o:Created>2011-07-15T02:19:09Z</o:Created>
  <o:LastSaved>2011-07-15T03:56:22Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.56in .44in .57in .49in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}
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
.style61
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet1;}
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
.xl71
	{mso-style-parent:style61;
	font-size:18.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style61;
	color:black;
	font-size:16.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style61;
	font-size:26.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style61;
	font-size:18.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style61;
	color:black;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl76
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl77
	{mso-style-parent:style61;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl78
	{mso-style-parent:style61;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed #00CCFF;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl79
	{mso-style-parent:style61;
	font-size:14.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed #00CCFF;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl80
	{mso-style-parent:style61;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed #00CCFF;
	background:#00CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl81
	{mso-style-parent:style61;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl82
	{mso-style-parent:style61;
	color:black;
	font-size:16.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt dashed #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:.5pt solid #00CCFF;
	white-space:normal;
	mso-rotate:-90;}
.xl83
	{mso-style-parent:style61;
	color:black;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt dashed #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:.5pt dashed #00CCFF;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl84
	{mso-style-parent:style61;
	color:black;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt dashed #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:.5pt dashed #00CCFF;
	background:white;
	mso-pattern:auto none;}
.xl85
	{mso-style-parent:style61;
	color:black;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:.5pt dashed #00CCFF;
	background:white;
	mso-pattern:auto none;}
.xl86
	{mso-style-parent:style61;
	color:black;
	font-size:16.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed #00CCFF;
	border-right:.5pt dashed #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:.5pt solid #00CCFF;
	white-space:normal;
	mso-rotate:-90;}
.xl87
	{mso-style-parent:style61;
	color:black;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt dashed #00CCFF;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl88
	{mso-style-parent:style61;
	color:black;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed #00CCFF;
	background:white;
	mso-pattern:auto none;}
.xl89
	{mso-style-parent:style61;
	color:black;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	vertical-align:middle;
	border-top:.5pt dashed #00CCFF;
	border-right:.5pt solid #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:.5pt dashed #00CCFF;
	background:white;
	mso-pattern:auto none;}
.xl90
	{mso-style-parent:style61;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed #00CCFF;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl91
	{mso-style-parent:style61;
	color:black;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed #00CCFF;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl92
	{mso-style-parent:style61;
	color:black;
	font-size:16.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed #00CCFF;
	border-right:.5pt dashed #00CCFF;
	border-bottom:none;
	border-left:.5pt solid #00CCFF;
	white-space:normal;
	mso-rotate:-90;}
.xl93
	{mso-style-parent:style61;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed #00CCFF;
	border-right:.5pt dashed #00CCFF;
	border-bottom:none;
	border-left:.5pt dashed #00CCFF;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl94
	{mso-style-parent:style61;
	color:black;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed #00CCFF;
	border-right:.5pt dashed #00CCFF;
	border-bottom:none;
	border-left:.5pt dashed #00CCFF;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl95
	{mso-style-parent:style61;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed #00CCFF;
	border-right:.5pt dashed #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:.5pt solid #00CCFF;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl96
	{mso-style-parent:style61;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed #00CCFF;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl97
	{mso-style-parent:style61;
	color:black;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed #00CCFF;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl98
	{mso-style-parent:style61;
	color:black;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl99
	{mso-style-parent:style61;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl100
	{mso-style-parent:style61;
	color:black;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl101
	{mso-style-parent:style61;
	color:black;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl102
	{mso-style-parent:style61;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl103
	{mso-style-parent:style61;
	color:black;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt dashed #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:.5pt dashed #00CCFF;}
.xl104
	{mso-style-parent:style61;
	color:black;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed #00CCFF;}
.xl105
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt dashed #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:.5pt dashed #00CCFF;}
.xl106
	{mso-style-parent:style16;
	color:black;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt dashed #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:.5pt dashed #00CCFF;
	background:white;
	mso-pattern:auto none;}
.xl107
	{mso-style-parent:style16;
	color:red;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt dashed #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:.5pt dashed #00CCFF;
	background:white;
	mso-pattern:auto none;}
.xl108
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt dashed #00CCFF;}
.xl109
	{mso-style-parent:style16;
	color:black;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed #00CCFF;
	background:white;
	mso-pattern:auto none;}
.xl110
	{mso-style-parent:style16;
	color:red;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed #00CCFF;
	background:white;
	mso-pattern:auto none;}
.xl111
	{mso-style-parent:style16;
	color:black;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed #00CCFF;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl112
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed #00CCFF;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl113
	{mso-style-parent:style16;
	color:black;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed #00CCFF;
	border-right:.5pt dashed #00CCFF;
	border-bottom:none;
	border-left:.5pt dashed #00CCFF;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl114
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed #00CCFF;
	border-right:.5pt dashed #00CCFF;
	border-bottom:none;
	border-left:.5pt dashed #00CCFF;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl115
	{mso-style-parent:style16;
	color:black;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed #00CCFF;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl116
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed #00CCFF;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl117
	{mso-style-parent:style61;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed #00CCFF;
	border-right:.5pt dashed #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl118
	{mso-style-parent:style61;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed #00CCFF;
	border-right:none;
	border-bottom:none;
	border-left:.5pt dashed #00CCFF;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl119
	{mso-style-parent:style61;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed #00CCFF;
	border-right:.5pt dashed #00CCFF;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl120
	{mso-style-parent:style61;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt dashed #00CCFF;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl121
	{mso-style-parent:style61;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt dashed #00CCFF;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl122
	{mso-style-parent:style61;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt dashed #00CCFF;
	border-left:.5pt dashed #00CCFF;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl123
	{mso-style-parent:style61;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt dashed #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl124
	{mso-style-parent:style61;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt dashed #00CCFF;
	border-right:.5pt dashed #00CCFF;
	border-bottom:none;
	border-left:.5pt dashed #00CCFF;
	white-space:normal;
	mso-rotate:0;}
.xl125
	{mso-style-parent:style61;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt dashed #00CCFF;
	border-bottom:none;
	border-left:.5pt dashed #00CCFF;
	white-space:normal;
	mso-rotate:-90;}
.xl126
	{mso-style-parent:style61;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed #00CCFF;
	border-right:.5pt dashed #00CCFF;
	border-bottom:none;
	border-left:.5pt dashed #00CCFF;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl127
	{mso-style-parent:style61;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt dashed #00CCFF;
	border-bottom:.5pt dashed #00CCFF;
	border-left:.5pt dashed #00CCFF;
	background:#00CCFF;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Yearly</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>54</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Zoom>85</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>4</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>4</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8760</x:WindowHeight>
  <x:WindowWidth>17235</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Yearly!$1:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl76>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1816 style='border-collapse:
 collapse;table-layout:fixed;width:1366pt'>
 <col class=xl76 width=64 span=1 style='mso-width-source:userset;mso-width-alt:7997; width:123pt'>
 <col class=xl76 width=164  span=2 style='mso-width-source:userset;mso-width-alt:7997;
 width:123pt'>
 <col class=xl76 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>

 <col class=xl76 width=65 span=12 style='mso-width-source:userset;mso-width-alt:
 2377;width:49pt'>
 <col class=xl76 width=95 style='mso-width-source:userset;mso-width-alt:3474;
 width:71pt'>
 <col class=xl76 width=110 span=2 style='mso-width-source:userset;mso-width-alt:
 4022;width:83pt'>
 <col class=xl76 width=64 span=4 style='width:48pt'>
 <tr height=43 style='height:32.25pt'>
  <td height=43 class=xl71 colspan=2 width=128 style='height:32.25pt;
  mso-ignore:colspan;width:96pt'>Yearly Active Employees</td>
  <td class=xl72 width=164 style='width:123pt'></td>
  <td class=xl72 width=73 style='width:55pt'></td>
  <td class=xl72 width=85 style='width:64pt'></td>
  <td class=xl72 width=85 style='width:64pt'></td>
  <td class=xl72 width=85 style='width:64pt'></td>
  <td class=xl73 width=85 style='width:64pt'></td>
  <td class=xl74 width=85 style='width:64pt'></td>
  <td class=xl72 width=65 style='width:49pt'></td>
  <td class=xl72 width=65 style='width:49pt'></td>
  <td class=xl75 width=65 style='width:49pt'></td>
  <td class=xl75 width=65 style='width:49pt'></td>
  <td class=xl75 width=65 style='width:49pt'></td>
  <td class=xl75 width=65 style='width:49pt'></td>
  <td class=xl75 width=65 style='width:49pt'></td>
  <td class=xl75 width=95 style='width:71pt'></td>
  <td class=xl75 width=110 style='width:83pt'></td>
  <td class=xl75 width=110 style='width:83pt'></td>
  <td class=xl75 width=64 style='width:48pt'></td>
  <td class=xl75 width=64 style='width:48pt'></td>
  <td class=xl75 width=64 style='width:48pt'></td>
  <td class=xl75 width=64 style='width:48pt'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl75 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
  <td colspan=14 class=xl75 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=43 style='mso-height-source:userset;height:32.25pt'>
  <td rowspan=2 height=88 class=xl78 style='height:66.0pt'>Division</td>
  <td rowspan=2 class=xl126 style='border-bottom:.5pt dashed #00CCFF'>Department</td>
  <td rowspan=2 class=xl78>Team/Section</td>
  <td colspan=13 class=xl79 style='border-left:none' x:str><%=p_year%></td>
  
  <td colspan=4 class=xl81 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td height=45 class=xl78 style='height:33.75pt;border-top:none;border-left:none'>Jan</td>
  <td class=xl78 style='border-top:none;border-left:none'>Feb</td>
  <td class=xl78 style='border-top:none;border-left:none'>Mar</td>
  <td class=xl78 style='border-top:none;border-left:none'>Apr</td>
  <td class=xl78 style='border-top:none;border-left:none'>May</td>
  <td class=xl78 style='border-top:none;border-left:none'>Jun</td>
  <td class=xl78 style='border-top:none;border-left:none'>Jul</td>
  <td class=xl78 style='border-top:none;border-left:none'>Aug</td>
  <td class=xl78 style='border-top:none;border-left:none'>Sep</td>
  <td class=xl78 style='border-top:none;border-left:none'>Oct</td>
  <td class=xl78 style='border-top:none;border-left:none'>Nov</td>
  <td class=xl78 style='border-top:none;border-left:none'>Dec</td>
  <td class=xl78 style='border-top:none;border-left:none'>Total</td>
  <td colspan=4 class=xl81 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <%
     int _i_f = 0;
	 int _i_d = 0;
     int _i_s = 0;
     int _sumsub1 = 0;
     int _sumsub2 = 0;
     double[] _subttl1 = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0 };
     double[] _subttl2 = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0 };
     double[] _grandttl = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0 };    

            for (_i_s = 0; _i_s < dt_s.Rows.Count; _i_s++)
            {
               
                for (int _t = 0; _t < 13; _t++)
                {
                   
					_grandttl[_t]+=  double.Parse(dt_s.Rows[_i_s][3 + _t].ToString());
                }   
  %>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  
<td height=126 class=xl124 width=64 style='height:48pt;width:48pt'><%=dt_s.Rows[_i_s][0].ToString()%></td>
  <td  class=xl124 width=64 style='width:48pt'><%=dt_s.Rows[_i_s][1].ToString() %></td>
  <td class=xl83><%=dt_s.Rows[_i_s][2].ToString() %></td>
  <% 
      for (int _z = 0; _z < 13; _z++)
      {
            
            
            %>
  <td class=xl105 style='border-left:none' x:num><%=dt_s.Rows[_i_s][3 + _z].ToString()%></td>
  <%    }
                
    } %>

  
  <td colspan=4 class=xl75 style='mso-ignore:colspan'></td>
 </tr>
 
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=3 height=40 class=xl95 style='height:30.0pt'>Grand Total</td>
  
  <%
      double _Grand = 0; 
      for (int _l = 0; _l < 13; _l++ )
     {%>
  <td class=xl115 style='border-left:none' x:num><%=_grandttl[_l] %> </td>
 <%
      } %>
  
  
  <td colspan=4 class=xl75 style='mso-ignore:colspan'></td>
 </tr>
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  
 </tr>
 <![endif]>
</table>

</body>

</html>
