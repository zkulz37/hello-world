<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
	Response.Buffer = false;

    string tecps_projectsumm_pk = Request["p_tecps_projectsumm_pk"];
    string p_month = Request["p_month"];
    string p_Subcontract_Pk = Request["Subcontract_Pk"];
    string p_Project_Cd = Request["Project_Cd"];
    string p_Project_Nm = Request["Project_Nm"];
    string l_parameter = "", l_project_name = "", strdt_month = "";
    l_parameter = "'" + tecps_projectsumm_pk + "','" + p_month + "','" + p_Subcontract_Pk + "'";
    //Response.Write(l_parameter);
    //Response.End();
    DataTable dt = ESysLib.TableReadOpenCursor("pm_rpt_61050050", l_parameter);
	DataTable dt_sum = ESysLib.TableReadOpenCursor("pm_rpt_61050050_sum", l_parameter);
	int sum_cnt = dt_sum.Rows.Count ;
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    strdt_month = p_month.Substring(4, 2) + "/" + p_month.Substring(0, 4);//2009.08
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_kpcs315m_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_kpcs315m_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_kpcs315m_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>linhtta</o:Author>
  <o:LastAuthor>SVPOSLILAMA</o:LastAuthor>
  <o:Created>2011-11-25T01:29:56Z</o:Created>
  <o:LastSaved>2011-11-25T01:32:35Z</o:LastSaved>
  <o:Company>VNG</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.31in .17in .16in .17in;
	mso-header-margin:.3in;
	mso-footer-margin:.16in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style43
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
	font-family:Arial, sans-serif;
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
	font-family:Arial, sans-serif;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl66
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl67
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl72
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl73
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl74
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl75
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl76
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl77
	{mso-style-parent:style43;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl78
	{mso-style-parent:style43;
	color:red;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl79
	{mso-style-parent:style43;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl80
	{mso-style-parent:style43;
	color:red;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style43;
	color:red;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl82
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	vertical-align:middle;}
.xl83
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl84
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl85
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl86
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl87
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl88
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl89
	{mso-style-parent:style43;
	color:red;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl90
	{mso-style-parent:style43;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl91
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt hairline windowtext;
	text-align:right;}
.xl92
	{mso-style-parent:style43;
	color:red;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl93
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl94
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl95
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl96
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl97
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl98
	{mso-style-parent:style43;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl99
	{mso-style-parent:style43;
	color:red;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl100
	{mso-style-parent:style43;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl101
	{mso-style-parent:style43;
	color:red;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl102
	{mso-style-parent:style43;
	color:red;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl103
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl104
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;}
.xl105
	{mso-style-parent:style0;
	font-size:26.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl106
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl107
	{mso-style-parent:style0;
	color:#003366;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl108
	{mso-style-parent:style0;
	color:#003366;
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
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl109
	{mso-style-parent:style0;
	color:#003366;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl110
	{mso-style-parent:style0;
	color:#003366;
	font-size:11.0pt;
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
.xl111
	{mso-style-parent:style0;
	color:#003366;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl112
	{mso-style-parent:style0;
	color:#003366;
	font-size:11.0pt;
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
.xl113
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl114
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl115
	{mso-style-parent:style0;
	color:#003366;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl116
	{mso-style-parent:style0;
	color:#003366;
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
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl117
	{mso-style-parent:style0;
	color:#003366;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl118
	{mso-style-parent:style0;
	color:#003366;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl119
	{mso-style-parent:style0;
	color:#003366;
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
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl120
	{mso-style-parent:style0;
	color:#003366;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl121
	{mso-style-parent:style0;
	color:#003366;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl122
	{mso-style-parent:style0;
	color:#003366;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl123
	{mso-style-parent:style0;
	color:#003366;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl124
	{mso-style-parent:style43;
	color:#003366;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl125
	{mso-style-parent:style43;
	color:#003366;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl126
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	text-align:right;}
.xl127
	{mso-style-parent:style0;
	color:#003366;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl128
	{mso-style-parent:style0;
	color:#003366;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl129
	{mso-style-parent:style0;
	color:#003366;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Subcontract payment inquiry</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>60</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:LeftColumnVisible>11</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>23</x:ActiveRow>
       <x:ActiveCol>20</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7365</x:WindowHeight>
  <x:WindowWidth>18975</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl65>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2455 style='border-collapse:
 collapse;table-layout:fixed;width:1845pt'>
 <col class=xl65 width=42 style='mso-width-source:userset;mso-width-alt:1536;
 width:32pt'>
 <col class=xl65 width=105 style='mso-width-source:userset;mso-width-alt:3840;
 width:79pt'>
 <col class=xl65 width=98 style='mso-width-source:userset;mso-width-alt:3584;
 width:74pt'>
 <col class=xl65 width=363 style='mso-width-source:userset;mso-width-alt:13275;
 width:272pt'>
 <col class=xl65 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl65 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl65 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl65 width=129 style='mso-width-source:userset;mso-width-alt:4717;
 width:97pt'>
 <col class=xl65 width=122 style='mso-width-source:userset;mso-width-alt:4461;
 width:92pt'>
 <col class=xl65 width=121 span=2 style='mso-width-source:userset;mso-width-alt:
 4425;width:91pt'>
 <col class=xl65 width=108 style='mso-width-source:userset;mso-width-alt:3949;
 width:81pt'>
 <col class=xl65 width=121 style='mso-width-source:userset;mso-width-alt:4425;
 width:91pt'>
 <col class=xl65 width=108 style='mso-width-source:userset;mso-width-alt:3949;
 width:81pt'>
 <col class=xl65 width=117 style='mso-width-source:userset;mso-width-alt:4278;
 width:88pt'>
 <col class=xl65 width=121 span=2 style='mso-width-source:userset;mso-width-alt:
 4425;width:91pt'>
 <col class=xl65 width=58 style='mso-width-source:userset;mso-width-alt:2121;
 width:44pt'>
 <col class=xl65 width=108 style='mso-width-source:userset;mso-width-alt:3949;
 width:81pt'>
 <col class=xl65 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl65 width=121 style='mso-width-source:userset;mso-width-alt:4425;
 width:91pt'>
 <col class=xl65 width=124 style='mso-width-source:userset;mso-width-alt:4534;
 width:93pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl65 width=42 style='height:12.75pt;width:32pt'></td>
  <td class=xl65 width=105 style='width:79pt'></td>
  <td class=xl65 width=98 style='width:74pt'></td>
  <td class=xl65 width=363 style='width:272pt'></td>
  <td class=xl65 width=73 style='width:55pt'></td>
  <td class=xl65 width=71 style='width:53pt'></td>
  <td class=xl65 width=40 style='width:30pt'></td>
  <td class=xl65 width=129 style='width:97pt'></td>
  <td class=xl65 width=122 style='width:92pt'></td>
  <td class=xl65 width=121 style='width:91pt'></td>
  <td class=xl65 width=121 style='width:91pt'></td>
  <td class=xl65 width=108 style='width:81pt'></td>
  <td class=xl65 width=121 style='width:91pt'></td>
  <td class=xl65 width=108 style='width:81pt'></td>
  <td class=xl65 width=117 style='width:88pt'></td>
  <td class=xl65 width=121 style='width:91pt'></td>
  <td class=xl65 width=121 style='width:91pt'></td>
  <td class=xl65 width=58 style='width:44pt'></td>
  <td class=xl65 width=108 style='width:81pt'></td>
  <td class=xl65 width=63 style='width:47pt'></td>
  <td class=xl65 width=121 style='width:91pt'></td>
  <td class=xl65 width=124 style='width:93pt'></td>
 </tr>
 <tr height=44 style='height:33.0pt'>
  <td colspan=21 height=44 class=xl105 style='height:33.0pt'>Subcontract
  payment inquiry</td>
  <td class=xl65></td>
 </tr>
 <tr class=xl71 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl66 style='height:17.25pt'>Project:</td>
  <td colspan=6 class=xl106><%=p_Project_Cd %> -  <%=p_Project_Nm %></td>
  <td class=xl67>&nbsp;</td>
  <td class=xl68>Progress Month:</td>
  <td class=xl67><%=strdt_month%></td>
  <td class=xl69>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td colspan=8 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl71></td>
 </tr>
 <tr class=xl71 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td rowspan=3 height=80 class=xl107 width=42 style='border-bottom:.5pt solid black;
  height:60.0pt;width:32pt'>Work Code</td>
  <td rowspan=3 class=xl107 width=105 style='border-bottom:.5pt solid black;
  border-top:none;width:79pt'>Work Name</td>
  <td rowspan=3 class=xl107 width=98 style='border-bottom:.5pt solid black;
  border-top:none;width:74pt'>Contract No</td>
  <td rowspan=3 class=xl108 style='border-bottom:.5pt solid black;border-top:
  none'>Subcontractor</td>
  <td rowspan=3 class=xl107 width=73 style='border-bottom:.5pt solid black;
  border-top:none;width:55pt'>Start Date</td>
  <td rowspan=3 class=xl107 width=71 style='border-bottom:.5pt solid black;
  border-top:none;width:53pt'>Finish Date</td>
  <td rowspan=3 class=xl107 width=40 style='border-bottom:.5pt solid black;
  border-top:none;width:30pt'>CCY</td>
  <td colspan=2 class=xl109 width=251 style='width:189pt'>Contract Amount</td>
  <td colspan=3 class=xl110 style='border-right:.5pt solid black'>Claim Amount</td>
  <td colspan=4 class=xl110 style='border-right:.5pt solid black;border-left:
  none'>Deduct Amount</td>
  <td colspan=4 class=xl110 style='border-right:.5pt solid black;border-left:
  none'>Payment</td>
  <td rowspan=3 class=xl107 width=121 style='border-bottom:.5pt solid black;
  width:91pt'>Balance claim</td>
  <td class=xl71></td>
 </tr>
 <tr class=xl70 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=2 height=40 class=xl107 width=129 style='border-bottom:.5pt solid black;
  height:30.0pt;border-top:none;width:97pt'>Net</td>
  <td rowspan=2 class=xl107 width=122 style='border-bottom:.5pt solid black;
  border-top:none;width:92pt'>VAT</td>
  <td rowspan=2 class=xl107 width=121 style='border-bottom:.5pt solid black;
  border-top:none;width:91pt'>Advance</td>
  <td rowspan=2 class=xl107 width=121 style='border-bottom:.5pt solid black;
  border-top:none;width:91pt'>Progress</td>
  <td rowspan=2 class=xl107 width=108 style='border-bottom:.5pt solid black;
  border-top:none;width:81pt'>VAT</td>
  <td rowspan=2 class=xl107 width=121 style='border-bottom:.5pt solid black;
  border-top:none;width:91pt'>Advance</td>
  <td rowspan=2 class=xl107 width=108 style='border-bottom:.5pt solid black;
  border-top:none;width:81pt'>Retention</td>
  <td rowspan=2 class=xl107 width=117 style='border-bottom:.5pt solid black;
  border-top:none;width:88pt'>Withholding Tax</td>
  <td rowspan=2 class=xl107 width=121 style='border-bottom:.5pt solid black;
  border-top:none;width:91pt'>Total Deduct</td>
  <td colspan=2 class=xl117 style='border-right:.5pt solid black;border-bottom:
  .5pt solid black;border-left:none'>Actual payment</td>
  <td colspan=2 class=xl117 style='border-right:.5pt solid black;border-bottom:
  .5pt solid black;border-left:none'>Keeping Retention</td>
  <td class=xl70></td>
 </tr>
 <tr class=xl70 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl119 style='height:15.0pt;border-left:none'>Amount</td>
  <td class=xl120>Rate</td>
  <td class=xl119 style='border-left:none'>Amount</td>
  <td class=xl119 style='border-left:none'>Rate(%)</td>
  <td class=xl70></td>
 </tr>
  <%
      for (int i = 0; i < dt.Rows.Count; i++)
      {
          %>
 <tr class=xl71 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl83 style='height:20.1pt;border-top:none'><%=dt.Rows[i]["orderingconttypecode"]%></td>
  <td class=xl84 style='border-top:none;border-left:none'><%=dt.Rows[i]["orderingconttypename"]%></td>
  <td class=xl85 style='border-top:none;border-left:none'><%=dt.Rows[i]["scontract_cd"]%></td>
  <td class=xl84 style='border-top:none;border-left:none'><%=dt.Rows[i]["scontractor"]%></td>
  <td class=xl86 style='border-top:none;border-left:none'><%=dt.Rows[i]["ct_from"]%></td>
  <td class=xl86 style='border-top:none;border-left:none'><%=dt.Rows[i]["ct_to"]%></td>
  <td class=xl87 style='border-top:none;border-left:none'><%=dt.Rows[i]["currency_code"]%></td>
  <td class=xl88 align=right style='border-top:none;border-left:none'   x:num><%=dt.Rows[i]["supplyprice"]%></td>
  <td class=xl88 align=right style='border-top:none;border-left:none'   x:num><%=dt.Rows[i]["ct_vat_famt"]%></td>
  <td class=xl88 align=right style='border-top:none;border-left:none'   x:num><%=dt.Rows[i]["adv_famt"]%></td>
  <td class=xl88 align=right style='border-top:none;border-left:none'   x:num><%=dt.Rows[i]["progress_famt"]%></td>
  <td class=xl88 align=right style='border-top:none;border-left:none'   x:num><%=dt.Rows[i]["vat_famt"]%></td>
  <td class=xl88 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["adv_deduct"]%></td>
  <td class=xl88 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["retention_famt"]%></td>
  <td class=xl88 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["holding_tax"]%></td>
  <td class=xl89 align=right style='border-top:none;border-left:none' x:num  ><%=dt.Rows[i]["total_deduct"]%></td>
  <td class=xl90 style='border-top:none;border-left:none'   x:num><%=dt.Rows[i]["actual_payment"]%></td>
  <td class=xl91 align=right style='border-top:none;border-left:none'  ><%=dt.Rows[i]["actual_rate"]%></td>
  <td class=xl88 align=right style='border-top:none;border-left:none' x:num  ><%=dt.Rows[i]["retention_famt"]%></td>
  <td class=xl91 align=right style='border-top:none;border-left:none'  ><%=dt.Rows[i]["retention_rate"]%></td>
  <td class=xl92 align=right style='border-top:none;border-left:none' x:num> <%=dt.Rows[i]["balace"]%></td>
  <td class=xl82></td>
 </tr>
 <%}
 
  
 %>
 
   
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=6 rowspan=<%=sum_cnt%> height=52 class=xl117 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:40.2pt'>TOTAL</td>
  <%
  for (int j = 0; j < dt_sum.Rows.Count; j++)
      { 
 %>
  <td class=xl123 style='border-top:none'><%=dt_sum.Rows[j]["currency_code"]%></td>
  <td class=xl124 align=right style='border-top:none;border-left:none'   x:num><%=dt_sum.Rows[j]["supplyprice"]%></td>
  <td class=xl124 align=right style='border-top:none;border-left:none'   x:num><%=dt_sum.Rows[j]["ct_vat_famt"]%></td>
  <td class=xl124 align=right style='border-top:none;border-left:none'   x:num><%=dt_sum.Rows[j]["adv_famt"]%></td>
  <td class=xl124 align=right style='border-top:none;border-left:none'   x:num><%=dt_sum.Rows[j]["progress_famt"]%></td>
  <td class=xl124 align=right style='border-top:none;border-left:none'   x:num><%=dt_sum.Rows[j]["vat_famt"]%></td>
  <td class=xl124 align=right style='border-top:none;border-left:none'   x:num><%=dt_sum.Rows[j]["adv_deduct"]%></td>
  <td class=xl124 align=right style='border-top:none;border-left:none'   x:num><%=dt_sum.Rows[j]["retention_famt"]%></td>
  <td class=xl124 align=right style='border-top:none;border-left:none'   x:num><%=dt_sum.Rows[j]["holding_tax"]%></td>
  <td class=xl124 align=right style='border-top:none;border-left:none'   x:num><%=dt_sum.Rows[j]["total_deduct"]%></td>
  <td class=xl125 style='border-top:none;border-left:none' x:num><%=dt_sum.Rows[j]["actual_payment"]%></td>
  <td class=xl126 align=right ><%=dt_sum.Rows[j]["actual_rate"]%></td>
  <td class=xl124 align=right style='border-top:none;border-left:none'  x:num><%=dt_sum.Rows[j]["retention_famt"]%></td>
  <td class=xl126 align=right ><%=dt_sum.Rows[j]["retention_rate"]%></td>
  <td class=xl124 align=right style='border-top:none;border-left:none'   x:num><%=dt_sum.Rows[j]["balace"]%></td>
  <td class=xl82></td>
 </tr>
 <%}%>
 
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=22 class=xl65 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=22 class=xl65 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=22 class=xl65 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=18 class=xl65 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl104></td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=42 style='width:32pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=363 style='width:272pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=129 style='width:97pt'></td>
  <td width=122 style='width:92pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=124 style='width:93pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
