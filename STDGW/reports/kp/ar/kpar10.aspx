<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<%  ESysLib.SetUser("ec111");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
			string p_Master_Pk = Request.QueryString["Master_pk"];
            string p_Project_Pk = Request.QueryString["Project_pk"];
            string p_Base_dt = Request.QueryString["Base_dt"];
//===========================================================================================================		
	string SQL_Master =  "SELECT a.pk, " + 
        "       b.pk project_pk, " +
        "       b.projectcode, " +
        "       b.projectname, " +
        "       to_char(to_date(a.basedate, 'YYYYMMDD'), 'DD/MM/YYYY') " +
        "  FROM ec111.tecps_subcontresult_m a, ec111.tecps_projectsumm b " +
        " WHERE     a.del_if = 0 " +
        "       AND b.del_if = 0 " +
        "       AND a.tecps_projectsumm_pk = b.pk " +
        "       AND a.pk = '"+p_Master_Pk+"' ";

		DataTable dt = ESysLib.TableReadOpen(SQL_Master);
		if (dt.Rows.Count == 0)
		{
			Response.Write("There is no data to show");
			Response.End();
		}
		string p_Project_Name = dt.Rows[0][3].ToString();
		string p_Date = dt.Rows[0][4].ToString();
//===========================================================================================================		
string SQL_DailyReport  	= "SELECT a.tecps_subcontresult_m_pk, " + 
        "       a.pk, " +
        "       DECODE (a.weather, " +
        "               1, 'Sunny', " +
        "               2, 'Cloudy', " +
        "               3, 'Rainy', " +
        "               4, 'Snowy', " +
        "               5, 'Foggy') " +
        "          weather, " +
        "            replace ( a.todayworkrmrk,chr(13),'$') todayworkrmrk , " +
        "       replace ( a.tommorrowworkrmrk ,chr(13),'$') , " +
        "       a.description " +
        "  FROM ec111.tecps_subcontworkrmrk a " +
        " WHERE a.del_if = 0 AND a.TECPS_SUBCONTRESULT_M_PK =  '"+p_Master_Pk+"' " ;		
		DataTable dt_1 = ESysLib.TableReadOpen(SQL_DailyReport);
        string tmp = dt_1.Rows[0][3].ToString().Replace("$", "<br>");
        string tmp1 = dt_1.Rows[0][4].ToString().Replace("$", "<br>");
        string[] a = dt_1.Rows[0][3].ToString().Split('$');
        string[] b = dt_1.Rows[0][4].ToString().Split('$');
        int _j = a.Length;
        int _jj = b.Length;
        int _zz = (_j > _jj) ? _j : _jj;
		if (dt_1.Rows.Count == 0)
		{
				
		}
		string p_Weather = dt_1.Rows[0][2].ToString();
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 12">
<link rel=File-List href="Book1_files/filelist.xml">
<link rel=Edit-Time-Data href="Book1_files/editdata.mso">
<link rel=OLE-Object-Data href="Book1_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>LONG</o:Author>
  <o:LastAuthor>ISA_SERVER</o:LastAuthor>
  <o:Created>2011-04-06T10:02:21Z</o:Created>
  <o:LastSaved>2011-04-06T10:16:19Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.39in .16in .2in .5in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;}
.font6
	{color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font7
	{color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:돋움, monospace;
	mso-font-charset:129;}
.font11
	{color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font13
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font19
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style45
	{mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	mso-style-name:"Comma \[0\] 2";}
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style57
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
	mso-style-name:"Normal 2";}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
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
.xl67
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	font-size:26.0pt;
	font-weight:700;}
.xl69
	{mso-style-parent:style0;
	font-size:26.0pt;}
.xl70
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl71
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl73
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl74
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl75
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style57;
	color:windowtext;
	font-size:16.0pt;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl77
	{mso-style-parent:style57;
	color:windowtext;
	font-size:16.0pt;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style57;
	color:windowtext;
	font-size:16.0pt;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style57;
	color:windowtext;
	font-size:16.0pt;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl80
	{mso-style-parent:style57;
	color:windowtext;
	font-size:16.0pt;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl81
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl82
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:top;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl84
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl85
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl87
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl92
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl95
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl96
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl97
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl98
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl99
	{mso-style-parent:style45;
	color:windowtext;
	font-size:9.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl100
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl101
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl102
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl103
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl104
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;}
.xl105
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl106
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl107
	{mso-style-parent:style57;
	color:windowtext;
	font-size:7.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl108
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl109
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl110
	{mso-style-parent:style57;
	color:windowtext;
	font-size:7.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl111
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl112
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl113
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl114
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl115
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl116
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl117
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl118
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl119
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl120
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"0\.0%";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl121
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;}
.xl122
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl123
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl124
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;}
.xl125
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl126
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl127
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl128
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"0\.0%";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl129
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl130
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl131
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl132
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl133
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;}
.xl134
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl135
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl136
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl137
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl138
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl139
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl140
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl141
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl142
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl143
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl144
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl145
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl146
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl147
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl148
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl149
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl150
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"0\.0%";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl151
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:top;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl152
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:top;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl153
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl154
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl155
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl156
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl157
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl158
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"0\.0%";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl159
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl160
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl161
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl162
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl163
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl164
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl165
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl166
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl167
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl168
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl169
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	mso-rotate:90;}
.xl170
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl171
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl172
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl173
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl174
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl175
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl176
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-rotate:90;}
.xl177
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-rotate:90;}
.xl178
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl179
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl180
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl181
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl182
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl183
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl184
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl185
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl186
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl187
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl188
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl189
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl190
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl191
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl192
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl193
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl194
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl195
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl196
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl197
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl198
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl199
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl200
	{mso-style-parent:style57;
	color:windowtext;
	font-size:7.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl201
	{mso-style-parent:style57;
	color:windowtext;
	font-size:7.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl202
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl203
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl204
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl205
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl206
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl207
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl208
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	text-align:center;}
.xl209
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl210
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl211
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl212
	{mso-style-parent:style45;
	color:windowtext;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;}
.xl213
	{mso-style-parent:style57;
	color:windowtext;
	font-size:7.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl214
	{mso-style-parent:style57;
	color:windowtext;
	font-size:7.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl215
	{mso-style-parent:style57;
	color:windowtext;
	font-size:7.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl216
	{mso-style-parent:style57;
	color:windowtext;
	font-size:7.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl217
	{mso-style-parent:style57;
	color:windowtext;
	font-size:16.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;}
.xl218
	{mso-style-parent:style57;
	color:windowtext;
	font-size:16.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl219
	{mso-style-parent:style57;
	color:windowtext;
	font-size:16.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl220
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl221
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl222
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl223
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl224
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl225
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl226
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl227
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl228
	{mso-style-parent:style57;
	color:windowtext;
	font-size:7.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl229
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl230
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl231
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl232
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl233
	{mso-style-parent:style57;
	color:windowtext;
	font-size:16.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;}
.xl234
	{mso-style-parent:style57;
	color:windowtext;
	font-size:16.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl235
	{mso-style-parent:style57;
	color:windowtext;
	font-size:16.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl236
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl237
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl238
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl239
	{mso-style-parent:style57;
	color:windowtext;
	font-size:16.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl240
	{mso-style-parent:style57;
	color:windowtext;
	font-size:16.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl241
	{mso-style-parent:style57;
	color:windowtext;
	font-size:22.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl242
	{mso-style-parent:style57;
	color:windowtext;
	font-size:22.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl243
	{mso-style-parent:style57;
	color:windowtext;
	font-size:22.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl244
	{mso-style-parent:style57;
	color:windowtext;
	font-size:22.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;}
.xl245
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;}
.xl246
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl247
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl248
	{mso-style-parent:style57;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl249
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;}
.xl250
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl251
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl252
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl253
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl254
	{mso-style-parent:style57;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>72</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>31</x:ActiveRow>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>12720</x:WindowHeight>
  <x:WindowWidth>18735</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>300</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2040 style='border-collapse:
 collapse;table-layout:fixed;width:1532pt'>
 <col width=146 style='mso-width-source:userset;mso-width-alt:4672;width:110pt'>
 <col width=61 span=2 style='mso-width-source:userset;mso-width-alt:1952;
 width:46pt'>
 <col width=63 style='mso-width-source:userset;mso-width-alt:2016;width:47pt'>
 <col width=135 style='mso-width-source:userset;mso-width-alt:4320;width:101pt'>
 <col width=119 style='mso-width-source:userset;mso-width-alt:3808;width:89pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2272;width:53pt'>
 <col width=94 span=4 style='mso-width-source:userset;mso-width-alt:3008;
 width:71pt'>
 <col width=72 span=14 style='width:54pt'>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=7 rowspan=4 height=92 class=xl241 width=656 style='height:69.0pt;width:492pt'>DAILY WORK REPORT</td>
  <td colspan=2 class=xl245 width=188 style='border-right:.5pt solid black; width:142pt'>PROJECT</td>
  <td colspan=2 class=xl247 width=188 style='border-right:1.0pt solid black; border-left:none;width:142pt'><%=p_Project_Name%></td>
  <td class=xl67 width=72 style='border-left:none;width:54pt'>&nbsp;</td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=2 height=23 class=xl249 style='border-right:.5pt solid black;
  height:17.25pt'>DATE</td>
  <td colspan=2 class=xl251 style='border-right:1.0pt solid black;border-left:
  none'><%=p_Date%></td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td class=xl68></td>
  <td colspan=11 class=xl69 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=2 height=23 class=xl249 style='border-right:.5pt solid black; height:17.25pt'>WEATHER</td>
  <td colspan=2 class=xl251 style='border-right:1.0pt solid black;border-left:none'><%=p_Weather%></td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=12 class=xl69 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=2 height=23 class=xl253 style='border-right:.5pt solid black;
  height:17.25pt'>TEMP.(MAX/MIN)</td>
  <td colspan=2 class=xl251 style='border-right:1.0pt solid black;border-left:
  none'>31<font class="font11"><sup>o</sup></font><font class="font6">C/22</font><font
  class="font11"><sup>o</sup></font><font class="font6">C</font></td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl70 style='height:14.1pt'>1. WORK LIST ( TODAY )</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl73 colspan=2 style='mso-ignore:colspan'>2. WORK LIST ( TOMORROW )</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>

 <tr height=18 style='mso-height-source:auto;height:14.1pt'>
  <td  height=18 colspan="<%=7%>" rowspan="<%=_zz%>" class=xl75 style='border-right:none;  height:14.1pt;text-align:left;white-space:normal;mso-height-source:auto;vertical-align:top'><%=tmp%><span style='mso-spacerun:yes'></span></td>
  <td class=xl75 colspan=4 rowspan="<%=_zz%>"  style='mso-ignore: ; white-space:normal;border-right:1.0pt solid windowtext;vertical-align:top'><%=tmp1 %></td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
 </tr>

 <%
     for (int z = 0; z < _zz - 1; z++)
     {
  %>
  <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td ></td>
 </tr>
  <%
     }
   %>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td colspan=11 height=18 class=xl220 style='border-right:1.0pt solid black;  height:14.1pt'>3. MANPOWER STATUS</td>
  <td class=xl81 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td colspan=5 height=18 class=xl223 style='height:14.1pt'>OUTSOURCING</td>
  <td colspan=6 class=xl224 style='border-right:1.0pt solid black;border-left:  none'>DIRECT MANAGEMENT</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td rowspan=2 height=36 class=xl226 style='height:28.2pt;border-top:none'>WORK ITEM</td>
  <td rowspan=2 class=xl213 width=61 style='border-top:none;width:46pt'>UNTIL<br>YESTER-DAY</td>
  <td rowspan=2 class=xl213 width=61 style='border-top:none;width:46pt'>TODAY</td>
  <td rowspan=2 class=xl213 width=63 style='border-top:none;width:47pt'>ACCUM.</td>
  <td rowspan=2 class=xl213 width=135 style='border-top:none;width:101pt'>MAJOR WORK</td>
  <td colspan=2 rowspan=2 class=xl229 style='border-right:.5pt solid black;border-bottom:.5pt hairline black'>WORK ITEM</td>
  <td rowspan=2 class=xl213 width=94 style='border-bottom:.5pt hairline black;border-top:none;width:71pt'>UNTIL<br>YESTERDAY</td>
  <td rowspan=2 class=xl213 width=94 style='border-bottom:.5pt hairline black;border-top:none;width:71pt'>TODAY</td>
  <td rowspan=2 class=xl213 width=94 style='border-bottom:.5pt hairline black;border-top:none;width:71pt'>ACCUM.</td>
  <td rowspan=2 class=xl215 width=94 style='border-bottom:.5pt hairline black;border-top:none;width:71pt'>MAJOR WORK</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl67 style='height:14.1pt;border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
<%
    decimal Total_MD1 = 0;
    decimal Total_MD2 = 0;
    decimal Total_MD3 = 0;
    decimal Total_MO1 = 0;
    decimal Total_MO2 = 0;
    decimal Total_MO3 = 0;      
    int seq = 0;
    string l_seq   = "select max(changeseq)  from tecps_conprogplan where del_if = 0 and TECPS_PROJECTSUMM_PK = '"+p_Project_Pk+"' ";
    DataTable dt_2 = ESysLib.TableReadOpen(l_seq);
    seq = int.Parse (dt_2.Rows[0][0].ToString());
//===========================================================================================================		
    string SQL_Manpower = "   SELECT ec111.sf_get_test (tecps_proplan_item_pk), " +
"       b.representqtyname, " +
"       A.TYPE, " +
"       A.NATIONALITY, " +
"       b.unit, " +
"       A.UNTILYESTERDAY, " +
"       A.TODAY, " +
"       A.CUMMULATION, " +
"       A.TOMORROW, " +
"       A.RATE, " +
"       A.DESCRIPTION, " +
"       a.pk, " +
"       A.TECPS_SUBCONTRESULT_M_PK " +
"  FROM tecps_subcontqty a, tecps_conprogplan b " +
" WHERE     a.del_if = 0 " +
"       AND b.del_if(+) = 0 " +
"       AND A.TECPS_CONPROGPLAN_PK = b.pk(+) " +
"       and A.TECPS_SUBCONTRESULT_M_PK = '" + p_Master_Pk + "'  " +
"       and A.TYPE = 'O' " +
"       AND b.changeseq = '" + seq + "' order by 1 ";
    DataTable dt_3 = ESysLib.TableReadOpen(SQL_Manpower);

    string SQL_Manpower_D = "   SELECT ec111.sf_get_test (tecps_proplan_item_pk), " +
"       b.representqtyname, " +
"       A.TYPE, " +
"       A.NATIONALITY, " +
"       b.unit, " +
"       A.UNTILYESTERDAY, " +
"       A.TODAY, " +
"       A.CUMMULATION, " +
"       A.TOMORROW, " +
"       A.RATE, " +
"       A.DESCRIPTION, " +
"       a.pk, " +
"       A.TECPS_SUBCONTRESULT_M_PK " +
"  FROM tecps_subcontqty a, tecps_conprogplan b " +
" WHERE     a.del_if = 0 " +
"       AND b.del_if(+) = 0 " +
"       AND A.TECPS_CONPROGPLAN_PK = b.pk(+) " +
"       and A.TECPS_SUBCONTRESULT_M_PK = '" + p_Master_Pk + "'  " +
"       and A.TYPE = 'D' " +
"       AND b.changeseq = '" + seq + "'  order by 1";
    DataTable dt_4 = ESysLib.TableReadOpen(SQL_Manpower_D);
    int item1 = dt_4.Rows.Count;
    int item = dt_3.Rows.Count;
    int r = (item > item1) ? item : item1;
    //Response.Write(r);
    //Response.End();  


    string SQL_Out
    = "select  a1, count(*) " +
        "from ( " +
        "       SELECT ec111.sf_get_test (tecps_proplan_item_pk) a1 " +
        "      FROM tecps_subcontqty a, tecps_conprogplan b  " +
        "     WHERE     a.del_if = 0  " +
        "           AND b.del_if(+) = 0  " +
        "           AND A.TECPS_CONPROGPLAN_PK = b.pk(+)  " +
        "           and A.TECPS_SUBCONTRESULT_M_PK  = '" + p_Master_Pk + "'  " +
        "           and A.TYPE = 'O'  " +
        "           AND b.changeseq = '" + seq + "' " +
        ") " +
        "group by a1 " +
        "order by a1   ";
        DataTable _dt_cnt_out = ESysLib.TableReadOpen(SQL_Out);

        string SQL_Direct
        = "select  a1, count(*) " +
            "from ( " +
            "       SELECT ec111.sf_get_test (tecps_proplan_item_pk) a1 " +
            "      FROM tecps_subcontqty a, tecps_conprogplan b  " +
            "     WHERE     a.del_if = 0  " +
            "           AND b.del_if(+) = 0  " +
            "           AND A.TECPS_CONPROGPLAN_PK = b.pk(+)  " +
            "           and A.TECPS_SUBCONTRESULT_M_PK  = '" + p_Master_Pk + "'  " +
            "           and A.TYPE = 'D'  " +
            "           AND b.changeseq = '" + seq + "' "+
        ") " +
        "group by a1 " +
        "order by a1   ";

        DataTable _dt_cnt_direct = ESysLib.TableReadOpen(SQL_Direct);

        int _j_out = 0;
        int _j_direct = 0;  
    for (int t = 0; t < r ; t++)
    {
//==============Total Manpower Direct=============================          
     /* 
    //==============Total Manpower Outsour=============================          
         /**/
%> 
 <tr height=15 style='mso-height-source:auto;height:14.1pt'>

 <%
     if (t < dt_3.Rows.Count)
     {
         if (dt_3.Rows[t][5].ToString().Trim() != "")
         {
             Total_MO1 += decimal.Parse(dt_3.Rows[t][5].ToString());
         }
         else
         {
             Total_MO1 = 0;
         }

         if (dt_3.Rows[t][6].ToString().Trim() != "")
         {
             Total_MO2 += decimal.Parse(dt_3.Rows[t][6].ToString());
         }
         else
         {
             Total_MO2 = 0;
         }

         if (dt_3.Rows[t][7].ToString().Trim() != "")
         {
             Total_MO3 += decimal.Parse(dt_3.Rows[t][7].ToString());
         }
         else
         {
             Total_MO3 = 0;
         }  
          %>
<%
    if (_j_out == 0)
    {  
 %>
  <td  height=36 rowspan="<%= _dt_cnt_out.Rows[_j_out++][1].ToString() %>" class=xl211 style='border-bottom:.5pt hairline black;height:28.2pt' ><%=dt_3.Rows[t][0]%></td>
<%
    }
    else if (dt_3.Rows[t][0].ToString() != dt_3.Rows[t - 1][0].ToString())
    {  
            %>  
    <td  height=36 rowspan="<%= _dt_cnt_out.Rows[_j_out++][1].ToString() %>" class=xl211 style='border-bottom:.5pt hairline black;height:28.2pt' ><%=dt_3.Rows[t][0]%></td>
  <%
    }  
            %>              
  
  <td  class=xl85  style='border-bottom:.5pt hairline black'x:num><%=dt_3.Rows[t][5]%></td>
  <td  class=xl85 style='border-bottom:.5pt hairline black'x:num><%=dt_3.Rows[t][6]%></td>
  <td class=xl85 style='border-bottom:.5pt hairline black' x:num><%=dt_3.Rows[t][7]%></td>
  <td class=xl82 style='border-left:none;vertical-align:middle' ><%=dt_3.Rows[t][1]%></td>
<%
     }
     else
     {
         %>
     <td  height=36 rowspan="" class=xl211 style='border-bottom:.5pt hairline black;height:28.2pt' ></td>
  <td  class=xl190  style='border-bottom:.5pt hairline black'x:num></td>
  <td  class=xl190 style='border-bottom:.5pt hairline black'x:num></td>
  <td class=xl190 style='border-bottom:.5pt hairline black' x:num></td>
  <td class=xl82 style='border-left:none;vertical-align:middle' ></td>   
         
       <%  
     }  
          
     %>  
<%
    if (t < dt_4.Rows.Count)
    {
        if (dt_4.Rows[t][5].ToString().Trim() != "")
        {
            Total_MD1 += decimal.Parse(dt_4.Rows[t][5].ToString());
        }
        else
        {
            Total_MD1 = 0;
        }

        if (dt_4.Rows[t][6].ToString().Trim() != "")
        {
            Total_MD2 += decimal.Parse(dt_4.Rows[t][6].ToString());
        }
        else
        {
            Total_MD2 = 0;
        }

        if (dt_4.Rows[t][7].ToString().Trim() != "")
        {
            Total_MD3 += decimal.Parse(dt_4.Rows[t][7].ToString());
        }
        else
        {
            Total_MD3 = 0;
        }  
 %>
<%
    if (_j_direct == 0)
    {  
 %>
  <td colspan=2  rowspan="<%= _dt_cnt_direct.Rows[_j_direct++][1].ToString() %>" class=xl83 width=119 style='border-top:none;border-left:none;width:89pt;border-right:.5pt solid windowtext'><%=dt_4.Rows[t][0]%></td>    
<%
    }
    else if (dt_4.Rows[t][0].ToString() != dt_4.Rows[t - 1][0].ToString())
    {  
            %>  
<td colspan=2  rowspan="<%= _dt_cnt_direct.Rows[_j_direct++][1].ToString() %>" class=xl83 width=119 style='border-top:none;border-left:none;width:89pt;border-right:.5pt solid windowtext'><%=dt_4.Rows[t][0]%></td>    
  <%
    }  
            %>
  <td class=xl84 style='border-top:none'><%=dt_4.Rows[t][5]%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_4.Rows[t][6]%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_4.Rows[t][7]%></td>
  <td class=xl86 style='border-top:none;border-left:none' ><%=dt_4.Rows[t][1]%></td>
<%
    }
    else
    {
                %>
  <td colspan=2 class=xl83 width=119 style='border-top:none;border-left:none;width:89pt;border-right:.5pt solid windowtext'></td>
  <td class=xl84 style='border-top:none'></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num></td>
  <td class=xl86 style='border-top:none;border-left:none' ></td>                  
              <%  
    }   
         %>  
 </tr>
<%
    }
%>  
 <tr height=18 style='mso-height-source:auto;height:14.1pt'>
  <td  height=36 class=xl211 style='border-bottom:.5pt hairline black;height:28.2pt'></td>
  <td  class=xl190 style='border-bottom:.5pt hairline black'></td>
  <td  class=xl190 style='border-bottom:.5pt hairline black'></td>
  <td class=xl190 style='border-bottom:.5pt hairline black' ></td>
  <td class=xl82 style='border-left:none;border-bottom:.5pt hairline black' ></td>
  <td colspan=2 height=18 class=xl194 style='border-right:.5pt solid black;  height:14.1pt;border-left:none' x:str="TOTAL">TOTAL</td>
  <td class=xl113 style='border-left:none' x:num><%=Total_MD1%></td>
  <td class=xl113 style='border-left:none' x:num><%=Total_MD2%> </td>
  <td class=xl113 style='border-left:none' x:num><%=Total_MD3%></td>
  <td class=xl101 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl102 style='height:14.1pt'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td colspan=6 class=xl209 style='border-right:1.0pt solid black;border-left:  none' x:str="4. ENTRY OF MATERIAL (DIRECT MANAGEMENT)">4. ENTRY OF MATERIAL (DIRECT  MANAGEMENT)</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl104 style='height:14.1pt'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td rowspan=2 class=xl196 style='border-bottom:.5pt hairline black;  border-top:none' x:str="ITEM">ITEM</td>
  <td class=xl106 style='border-top:none' x:str="BOQ ">BOQ</td>
  <td rowspan=2 class=xl200 width=94 style='border-bottom:.5pt hairline black; border-top:none;width:71pt'>UNTIL<br>YESTERDAY</td>
  <td rowspan=2 class=xl200 width=94 style='border-bottom:.5pt hairline black; border-top:none;width:71pt'>TODAY</td>
  <td rowspan=2 class=xl200 width=94 style='border-bottom:.5pt hairline black;  border-top:none;width:71pt'>ACCUM.</td>
  <td class=xl107 width=94 style='border-top:none;border-left:none;width:71pt'>REMARKS</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl108 style='height:14.1pt;border-top:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl87 x:str="(Tons)">(Tons)</td>
  <td class=xl110 width=94 style='border-left:none;width:71pt'>(%)</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
<%
    decimal Total_Mt_D1 = 0;
    decimal Total_Mt_D2 = 0;
    decimal Total_Mt_D3 = 0;
    decimal Total_Mt_D4 = 0;    
    string SQL_Material_D= " SELECT b.MATERIALNAME, null, a.YESTERDAY, a.TODAY,  a.ACCUM, a.description " +
"        FROM ec111.tecps_subcontmaterial a, TECPS_ST_MATERIAL b " +
"       WHERE a.del_if = 0 " +
"         AND b.del_if = 0 " +
"         AND a.TECPS_ST_MATERIAL_pk = b.pk " +
"         and a.type = 'D' " +
"         AND a.tecps_subcontresult_m_pk = '"+p_Master_Pk+"' ";
    DataTable dt_5 = ESysLib.TableReadOpen(SQL_Material_D);
    for (int p = 0; p < dt_5.Rows.Count; p++)
    {
        if (dt_5.Rows[p][1].ToString().Trim() != "")
        {
            Total_Mt_D1 += decimal.Parse(dt_5.Rows[p][1].ToString());
        }
        else
        {
            Total_Mt_D1 = 0;
        }

        if (dt_5.Rows[p][2].ToString().Trim() != "")
        {
            Total_Mt_D2 += decimal.Parse(dt_5.Rows[p][2].ToString());
        }
        else
        {
            Total_Mt_D2 = 0;
        }

        if (dt_5.Rows[p][3].ToString().Trim() != "")
        {
            Total_Mt_D3 += decimal.Parse(dt_5.Rows[p][3].ToString());
        }
        else
        {
            Total_Mt_D3 = 0;
        }

        if (dt_5.Rows[p][4].ToString().Trim() != "")
        {
            Total_Mt_D4 += decimal.Parse(dt_5.Rows[p][4].ToString());
        }
        else
        {
            Total_Mt_D4 = 0;
        }  
 %>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl108 style='height:14.1pt'>&nbsp;</td>
  <td class=xl96 style='border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-left:none;text-align:left' ><%=dt_5.Rows[p][0]%></td>
  <td class=xl118 x:num><%=dt_5.Rows[p][1]%></td>
  <td class=xl119 style='border-left:none' x:num><%=dt_5.Rows[p][2]%></td>
  <td class=xl87 style='border-left:none' x:num><%=dt_5.Rows[p][3]%> </td>
  <td class=xl119 style='border-left:none' x:num><%=dt_5.Rows[p][4]%></td>
  <td class=xl120 ><%=dt_5.Rows[p][5]%></td>
  <td class=xl67 style='border-left:none'></td>
  <td colspan=12 class=xl124 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
<%} %> 
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl121 style='height:14.1pt'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-left:none;text-align:center' x:str="TOTAL">TOTAL</td>
  <td class=xl125 x:num><%=Total_Mt_D1%></td>
  <td class=xl126 style='border-left:none' x:num><%=Total_Mt_D2%></td>
  <td class=xl126 style='border-left:none' x:num><%=Total_Mt_D3%></td>
  <td class=xl126 style='border-left:none' x:num><%=Total_Mt_D4%></td>
  <td class=xl128 x:num></td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=12 class=xl124 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl141 style='height:14.1pt'><sup>&nbsp;</sup></td>
  <td class=xl142 style='border-left:none'><sup>&nbsp;</sup></td>
  <td class=xl142 style='border-left:none'><sup>&nbsp;</sup></td>
  <td class=xl142 style='border-left:none'><sup>&nbsp;</sup></td>
  <td class=xl142 style='border-left:none'><sup>&nbsp;</sup></td>
  <td colspan=6 class=xl203 style='border-right:1.0pt solid black;border-left:  none' x:str="5. ENTRY OF MATERIAL (OUTSOURCING)">5. ENTRY OF MATERIAL (OUTSOURCING)</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl121 style='height:14.1pt'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl196 style='border-right:.5pt solid black;  border-bottom:.5pt hairline black' x:str="ITEM">ITEM</td>
  <td rowspan=2 class=xl200 width=94 style='border-bottom:.5pt hairline black;  border-top:none;width:71pt'>UNTIL<br>YESTERDAY</td>
  <td rowspan=2 class=xl200 width=94 style='border-bottom:.5pt hairline black; border-top:none;width:71pt'>TODAY</td>
  <td rowspan=2 class=xl200 width=94 style='border-bottom:.5pt hairline black; border-top:none;width:71pt'>ACCUM.</td>
  <td rowspan=2 class=xl107 width=94 style='border-bottom:.5pt hairline black; border-top:none;width:71pt'>REMARKS</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl108 style='height:14.1pt;border-top:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
<%
    decimal Total_Mt_O1 = 0;
    decimal Total_Mt_O2 = 0;
    decimal Total_Mt_O3 = 0;
    string SQL_Material_O= " SELECT b.MATERIALNAME, null, a.YESTERDAY, a.TODAY,  a.ACCUM, a.description " +
"        FROM ec111.tecps_subcontmaterial a, TECPS_ST_MATERIAL b " +
"       WHERE a.del_if = 0 " +
"         AND b.del_if = 0 " +
"         AND a.TECPS_ST_MATERIAL_pk = b.pk " +
"         and a.type = 'O' " +
"         AND a.tecps_subcontresult_m_pk = '"+p_Master_Pk+"' ";
    DataTable dt_6 = ESysLib.TableReadOpen(SQL_Material_O);
    for (int v = 0; v < dt_6.Rows.Count; v++)
    {
        if (dt_6.Rows[v][2].ToString().Trim() != "")
        {
            Total_Mt_O1 += decimal.Parse(dt_6.Rows[v][2].ToString());
        }
        else
        {
            Total_Mt_O1 = 0;
        }

        if (dt_6.Rows[v][3].ToString().Trim() != "")
        {
            Total_Mt_O2 += decimal.Parse(dt_6.Rows[v][3].ToString());
        }
        else
        {
            Total_Mt_O2 = 0;
        }

        if (dt_6.Rows[v][4].ToString().Trim() != "")
        {
            Total_Mt_O3 += decimal.Parse(dt_6.Rows[v][4].ToString());
        }
        else
        {
            Total_Mt_O3 = 0;
        }
 %>
 
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl111 style='height:14.1pt'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl89 style='border-right:.5pt solid black;border-left:  none'><%=dt_6.Rows[v][0]%></td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><%=dt_6.Rows[v][2]%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_6.Rows[v][3]%></td>
  <td class=xl115 style='border-left:none' x:num><%=dt_6.Rows[v][4]%></td>
  <td class=xl116 style='border-top:none;border-left:none'><%=dt_6.Rows[v][5]%></td>
  <td class=xl67 style='border-left:none'></td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
<%} %> 
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl108 style='height:14.1pt'>&nbsp;</td>
  <td class=xl96 style='border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl206 style='border-right:.5pt solid black;border-left: none' x:str="TOTAL">TOTAL</td>
  <td class=xl113 style='border-top:none;border-left:none' x:num><%=Total_Mt_O1%></td>
  <td class=xl113 style='border-top:none;border-left:none' x:num><%=Total_Mt_O2%></td>
  <td class=xl113 style='border-top:none;border-left:none' x:num><%=Total_Mt_O3%></td>
  <td class=xl143 style='border-top:none;border-left:none' ></td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl121 style='height:14.1pt'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td colspan=6 class=xl203 style='border-right:1.0pt solid black;border-left: none' x:str="6. EQUIPMENT (DIRECT MANAGEMENT)">6. EQUIPMENT (DIRECT MANAGEMENT)</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl111 style='height:14.1pt'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl196 style='border-right:.5pt solid black; border-bottom:.5pt hairline black' x:str="ITEM">ITEM</td>
  <td rowspan=2 class=xl200 width=94 style='border-bottom:.5pt hairline black; border-top:none;width:71pt'>UNTIL<br>YESTERDAY</td>
  <td rowspan=2 class=xl200 width=94 style='border-bottom:.5pt hairline black;border-top:none;width:71pt'>TODAY</td>
  <td rowspan=2 class=xl200 width=94 style='border-bottom:.5pt hairline black;  border-top:none;width:71pt'>ACCUM.</td>
  <td rowspan=2 class=xl107 width=94 style='border-bottom:.5pt hairline black;  border-top:none;width:71pt'>REMARKS</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl121 style='height:14.1pt'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 <%
     decimal Total_Eq_D1 = 0; 
     decimal Total_Eq_D2 = 0; 
     decimal Total_Eq_D3 = 0; 
        string SQL_Eq= "SELECT b.EQUIPNAME, " + 
        "       a.lastday, " +
        "       a.todayqty, " +
        "       a.cummulation, " +
        "       a.description " +
        "  FROM ec111.tecps_subcontequip a, TECPS_ST_EQUIPMENT b " +
        " WHERE     a.del_if = 0 " +
        "       AND b.del_if = 0 " +
        "       AND a.TECPS_ST_EQUIPMENT_pk = b.pk " +
        "       AND a.TYPE = 'D' " +
        "       AND a.tecps_subcontresult_m_pk = '" + p_Master_Pk + "' ";
        DataTable dt_7 = ESysLib.TableReadOpen(SQL_Eq);
        for (int g = 0; g < dt_7.Rows.Count; g++)
        {
            if (dt_7.Rows[g][1].ToString().Trim() != "")
            {
                Total_Eq_D1 += decimal.Parse(dt_7.Rows[g][1].ToString());
            }
            else
            {
                Total_Eq_D1 = 0;
            }

            if (dt_7.Rows[g][2].ToString().Trim() != "")
            {
                Total_Eq_D2 += decimal.Parse(dt_7.Rows[g][2].ToString());
            }
            else
            {
                Total_Eq_D2 = 0;
            }

            if (dt_7.Rows[g][3].ToString().Trim() != "")
            {
                Total_Eq_D3 += decimal.Parse(dt_7.Rows[g][3].ToString());
            }
            else
            {
                Total_Eq_D3 = 0;
            }
  %>
 
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl108 style='height:14.1pt;border-top:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl144 style='border-right:.5pt solid black;border-left:  none' ><%=dt_7.Rows[g][0]%></td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><%=dt_7.Rows[g][1]%> </td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><%=dt_7.Rows[g][2]%></td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><%=dt_7.Rows[g][3]%> </td>
  <td class=xl116 style='border-top:none;border-left:none'><%=dt_7.Rows[g][4]%></td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
<%} %>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl108 style='height:14.1pt'>&nbsp;</td>
  <td class=xl96 style='border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl194 style='border-right:.5pt solid black;border-left:  none' x:str="TOTAL">TOTAL</td>
  <td class=xl113 style='border-left:none' x:num><%=Total_Eq_D1%></td>
  <td class=xl113 style='border-left:none' x:num><%=Total_Eq_D2%> </td>
  <td class=xl113 style='border-left:none' x:num><%=Total_Eq_D3%></td>
  <td class=xl147 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl148></td>
  <td colspan=4 class=xl148 style='mso-ignore:colspan'></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl121 style='height:14.1pt'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td colspan=6 class=xl203 style='border-right:1.0pt solid black;border-left:  none' x:str="7. EQUIPMENT (OUTSOURCING)">7. EQUIPMENT (OUTSOURCING)</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl148></td>
  <td colspan=4 class=xl148 style='mso-ignore:colspan'></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl111 style='height:14.1pt'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl196 style='border-right:.5pt solid black;  border-bottom:.5pt hairline black' x:str="ITEM">ITEM</td>
  <td rowspan=2 class=xl200 width=94 style='border-bottom:.5pt hairline black;  border-top:none;width:71pt'>UNTIL<br>YESTERDAY</td>
  <td rowspan=2 class=xl200 width=94 style='border-bottom:.5pt hairline black;  border-top:none;width:71pt'>TODAY</td>
  <td rowspan=2 class=xl200 width=94 style='border-bottom:.5pt hairline black; border-top:none;width:71pt'>ACCUM.</td>
  <td rowspan=2 class=xl107 width=94 style='border-bottom:.5pt hairline black;  border-top:none;width:71pt'>REMARKS</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=6 class=xl148 style='mso-ignore:colspan'></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl121 style='height:14.1pt'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=6 class=xl148 style='mso-ignore:colspan'></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <%
     decimal Total_Eq_O1 = 0; 
     decimal Total_Eq_O2 = 0; 
     decimal Total_Eq_O3 = 0; 
        string SQL_Eq_O= "SELECT b.EQUIPNAME, " + 
        "       a.lastday, " +
        "       a.todayqty, " +
        "       a.cummulation, " +
        "       a.description " +
        "  FROM ec111.tecps_subcontequip a, TECPS_ST_EQUIPMENT b " +
        " WHERE     a.del_if = 0 " +
        "       AND b.del_if = 0 " +
        "       AND a.TECPS_ST_EQUIPMENT_pk = b.pk " +
        "       AND a.TYPE = 'O' " +
        "       AND a.tecps_subcontresult_m_pk = '" + p_Master_Pk + "' ";
        DataTable dt_8 = ESysLib.TableReadOpen(SQL_Eq_O);
        for (int u = 0; u < dt_8.Rows.Count; u++)
        {
            if (dt_8.Rows[u][1].ToString().Trim() != "")
            {
                Total_Eq_O1 += decimal.Parse(dt_8.Rows[u][1].ToString());
            }
            else
            {
                Total_Eq_O1 = 0;
            }

            if (dt_8.Rows[u][2].ToString().Trim() != "")
            {
                Total_Eq_O2 += decimal.Parse(dt_8.Rows[u][2].ToString());
            }
            else
            {
                Total_Eq_O2 = 0;
            }

            if (dt_8.Rows[u][3].ToString().Trim() != "")
            {
                Total_Eq_O3 += decimal.Parse(dt_8.Rows[u][3].ToString());
            }
            else
            {
                Total_Eq_O3 = 0;
            }
  %>

 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl121 style='height:14.1pt'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl144 style='border-right:.5pt solid black;border-left:  none'><%=dt_8.Rows[u][0]%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_8.Rows[u][1]%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_8.Rows[u][2]%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_8.Rows[u][3]%></td>
  <td class=xl116 style='border-top:none;border-left:none'><%=dt_8.Rows[u][4]%></td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
<%} %> 
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl108 style='height:14.1pt;border-top:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl194 style='border-right:.5pt solid black;border-left: none' x:str="TOTAL">TOTAL</td>
  <td class=xl113 style='border-top:none;border-left:none' x:num><%=Total_Eq_O1%></td>
  <td class=xl113 style='border-top:none;border-left:none' x:num><%=Total_Eq_O2%></td>
   <td class=xl113 style='border-top:none;border-left:none' x:num><%=Total_Eq_O3%> </td>
  <td class=xl116 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl111 style='height:14.1pt'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td colspan=6 class=xl139 style='border-right:1.0pt solid black;border-left:  none' x:str="8. OTHERS (FOUNDATION WORK )">8. OTHERS (FOUNDATION WORK )</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl108 style='height:14.1pt'>&nbsp;</td>
  <td class=xl96 style='border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-left:none'>&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl196 style='border-right:.5pt solid black;  border-bottom:.5pt hairline black' x:str="ITEM">ITEM</td>
  <td rowspan=2 class=xl200 width=94 style='border-bottom:.5pt hairline black;  border-top:none;width:71pt'>UNTIL<br>YESTERDAY</td>
  <td rowspan=2 class=xl200 width=94 style='border-bottom:.5pt hairline black;border-top:none;width:71pt'>TODAY</td>
  <td rowspan=2 class=xl200 width=94 style='border-bottom:.5pt hairline black;border-top:none;width:71pt'>ACCUM.</td>
  <td rowspan=2 class=xl107 width=94 style='border-bottom:.5pt hairline black;border-top:none;width:71pt'>REMARKS</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl121 style='height:14.1pt'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
<%
    decimal Total_Other1 = 0;
    decimal Total_Other2 = 0;
    decimal Total_Other3 = 0;    
    string l_parameter = "'" + p_Master_Pk + "', '" + p_Base_dt + "', '" + p_Project_Pk + "'";
    DataTable dt_9 = ESysLib.TableReadOpenCursor("ec111.sp_sel_kpar10_Manpower", l_parameter);
    for (int f = 1; f < dt_9.Rows.Count;f++)
    {
        if (dt_9.Rows[f][7].ToString().Trim() != "")
        {
            Total_Other1 += decimal.Parse(dt_9.Rows[f][7].ToString());
        }
        else
        {
            Total_Other1 = 0;
        }
        if (dt_9.Rows[f][8].ToString().Trim() != "")
        {
            Total_Other2 += decimal.Parse(dt_9.Rows[f][8].ToString());
        }
        else
        {
            Total_Other2 = 0;
        }
        if (dt_9.Rows[f][9].ToString().Trim() != "")
        {
            Total_Other3 += decimal.Parse(dt_9.Rows[f][9].ToString());
        }
        else
        {
            Total_Other3 = 0;
        }    
 %> 
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl111 style='height:14.1pt'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl151 style='border-right:.5pt solid black;border-left: none' ><%=dt_9.Rows[f][0]%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_9.Rows[f][7]%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_9.Rows[f][8]%> </td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_9.Rows[f][9]%></td>
  <td class=xl150 style='border-top:none' ><%=dt_9.Rows[f][20]%></td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl111 style='height:14.1pt'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl153 style='border-right:.5pt solid black;border-left:  none;text-align:center' x:str="TOTAL">TOTAL</td>
  <td class=xl113 style='border-top:none;border-left:none;border-bottom:.5pt solid windowtext;' x:num><%=Total_Other1%></td>
  <td class=xl113 style='border-top:none;border-left:none;border-bottom:.5pt solid windowtext;' x:num><%=Total_Other2%></td>
  <td class=xl113 style='border-top:none;border-left:none;border-bottom:.5pt solid windowtext;' x:num><%=Total_Other3%></td>
  <td class=xl158 style='border-top:none' ></td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl108 style='height:14.1pt'>&nbsp;</td>
  <td class=xl96 style='border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl155 style='border-right:.5pt solid black;border-left:  none' x:str="B. Pile Cutting">B. Pile  Cutting</td>
  <td class=xl87 style='border-left:none'>&nbsp;</td>
  <td class=xl87 style='border-left:none'>&nbsp;</td>
  <td class=xl87 style='border-left:none'>&nbsp;</td>
  <td class=xl120>&nbsp;</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td rowspan=2 height=36 class=xl186 style='border-bottom:.5pt solid black;  height:28.2pt' x:str="TOTAL">TOTAL</td>
  <td rowspan=2 class=xl113 style='border-bottom:.5pt solid black' x:num><%=Total_MO1%></td>
  <td rowspan=2 class=xl113 style='border-bottom:.5pt solid black' x:num><%=Total_MO2%></td>
  <td rowspan=2 class=xl113 style='border-bottom:.5pt solid black' x:num><%=Total_MO3%></td>
  <td rowspan=2 class=xl190 style='border-bottom:.5pt solid black'>&nbsp;</td>
  <td colspan=2 class=xl192 style='border-right:.5pt solid black;border-left:  none' x:str="D 600(617#)">D600(617#)</td>
  <td class=xl87 style='border-left:none' x:num>562 </td>
  <td class=xl87 style='border-left:none' x:num>- </td>
  <td class=xl87 style='border-left:none' x:num>562 </td>
  <td class=xl120 x:num>86.9%</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=12 class=xl124 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td colspan=2 height=18 class=xl194 style='border-right:.5pt solid black;  height:14.1pt;border-left:none' x:str="TOTAL(647#)">TOTAL(647#)</td>
  <td class=xl85 style='border-top:none;border-left:none' x:num>562 </td>
  <td class=xl85 style='border-top:none;border-left:none' x:num>- </td>
  <td class=xl85 style='border-top:none;border-left:none' x:num>562 </td>
  <td class=xl158 style='border-top:none' x:num>86.9%</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=12 class=xl124 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl159 style='height:14.1pt;border-top:none'  x:str="8. REMARKS">8. REMARKS</td>
  <td class=xl160 style='border-top:none'>&nbsp;</td>
  <td class=xl160 style='border-top:none'>&nbsp;</td>
  <td class=xl160 style='border-top:none'>&nbsp;</td>
  <td class=xl160 style='border-top:none'>&nbsp;</td>
  <td class=xl160 style='border-top:none'>&nbsp;</td>
  <td class=xl160 style='border-top:none'>&nbsp;</td>
  <td class=xl160>&nbsp;</td>
  <td class=xl160>&nbsp;</td>
  <td class=xl160>&nbsp;</td>
  <td class=xl161 style='border-top:none'>&nbsp;</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td colspan=5 height=18 class=xl170 style='border-right:.5pt solid black;  height:14.1pt'>&nbsp;</td>
  <td colspan=6 class=xl94 style='border-right:1.0pt solid black;border-bottom:  .5pt hairline black;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=12 class=xl124 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl162 colspan=5 style='height:20.25pt;mso-ignore:colspan'  x:str="THIS DOCUMENT MUST BE SUBMITTED UNTIL ON 9:00AM OF NEXT DAY.">THIS DOCUMENT MUST BE SUBMITTED UNTIL ON  9:00AM OF NEXT DAY.</td>
  <td class=xl164>&nbsp;</td>
  <td rowspan=2 class=xl176 style='border-bottom:1.0pt solid black'  x:str="CONFIRM">CONFIRM</td>
  <td colspan=2 class=xl178 style='border-right:.5pt solid black;border-left:  none' x:str="Prepared by :  ">Prepared by :</td>
  <td colspan=2 class=xl180 style='border-right:1.0pt solid black'  x:str="Checked by :">Checked by :</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=12 class=xl124 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=67 style='mso-height-source:userset;height:50.25pt'>
  <td height=67 class=xl165 style='height:50.25pt' ></td>
  <td class=xl166 ></td>
  <td class=xl166>&nbsp;</td>
  <td class=xl166 ></td>
  <td class=xl166>&nbsp;</td>
  <td class=xl167 width=119 style='width:89pt'>&nbsp;</td>
  <td colspan=2 class=xl182 width=188 style='border-right:.5pt solid black;  border-left:none;width:142pt'  x:str="OJERA, S. Office Engineer">OJERA, S.Office  Engineer</td>
  <td colspan=2 class=xl184 width=188 style='border-right:1.0pt solid black;width:142pt' x:str="KIM, HJ Site Manager">KIM, HJ Site Manager</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>

 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=146 style='width:110pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=135 style='width:101pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
