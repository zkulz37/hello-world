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
    
    string P_WORK_MON,P_EMP_ID,P_POS_EMP;
  
    P_WORK_MON    = Request["P_WORK_MON"].ToString();
    P_EMP_ID      = Request["P_EMP_ID"].ToString();
    P_POS_EMP     = Request["P_POS_EMP"].ToString();

  string SQL;
	SQL = "select " ;
        SQL = SQL + "      full_NAME c0, " ;
        SQL = SQL + "      EMP_ID    c1      , " ;
        SQL = SQL + "      round(nvl(GROSS_AMT,0),0)  c2        , " ;
        SQL = SQL + "      round(nvl(BASIC_SAL,0),0)    c3      , " ;
        SQL = SQL + "      round(nvl(OT_DAY_OFF_AMT,0),0) c4       , " ;
        SQL = SQL + "      round(nvl(HRENTAL_INCOME,0),0)  c5, " ;
        SQL = SQL + "      round(nvl(ALLOW_AMT,0),0) c6, " ;
        SQL = SQL + "      round(nvl(GROSS_AMT_VND,0),0) c7     , " ;
        SQL = SQL + "      round(nvl(INCOME_TAX,0),0)     c8    , " ;
        SQL = SQL + "      round(nvl(INCOME_TAX_VND,0),0)   c9  , " ;
        SQL = SQL + "      round(nvl(NET_AMT,0),0)         c10   , " ;
        SQL = SQL + "      round(nvl(NET_AMT_VND,0),0)      c11  , " ;
        SQL = SQL + "      round(nvl(ADV_TOTAL_AMT,0),0)    c12  , " ;
        SQL = SQL + "      round(nvl(ADV_SALARY_AMT,0),0)    c13 , " ;
        SQL = SQL + "      round(nvl(ADV_TICKET_AMT,0),0) c14, " ;
        SQL = SQL + "      round(nvl(HEALTH_INSURANCE,0),0) c15, " ;
        SQL = SQL + "      round(nvl(ADV_HOUSE_AMT,0),0)   c16   , " ;
        SQL = SQL + "      round(nvl(HEALTH_INSURANCE_VND,0),0) c17, " ;
        SQL = SQL + "      round(nvl(ADV_TOTAL_AMT_VND,0),0) c18, " ;
        SQL = SQL + "      round(nvl(REMAIN_AMT,0),0)       c19  , " ;
        SQL = SQL + "      round(nvl(REMAIN_AMT_VND,0),0)   c20 , " ;
        SQL = SQL + "      round(nvl(HEALTH_INSURANCE_COM_USD,0),0)   c21 , ";
        SQL = SQL + "      round(nvl(HEALTH_INSURANCE_COM_VND,0),0)   c22 , ";
        SQL = SQL + "      THR_PROJECT_code   c23, " ;
        SQL = SQL + "      THR_PROJECT_Nm  c24 , " ;
        SQL = SQL + "      REMARK c25 " ;
        SQL = SQL + "      FROM  THR_SALARY_FOREIGNER A " ;
        SQL = SQL + "      WHERE A.DEL_IF=0 " ;
        SQL = SQL + "      AND A.WORK_MON='" + P_WORK_MON + "'" ;
        SQL = SQL + "      AND A.EMP_ID LIKE '%" + P_EMP_ID + "%' " ;
        SQL = SQL + "      AND DECODE('" + P_POS_EMP + "','ALL','ALL',A.POS_EMP )='" + P_POS_EMP +"'" ;




//Response.Write(SQL);
//Response.End();
    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp=dt_Emp.Columns.Count;
    if (irow_emp == 0)
    {
        Response.Write("There is no data of unfixed allowance");
        Response.End();
    }
   
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_foreigner_salary_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_foreigner_salary_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_foreigner_salary_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Ho Thu Hien</o:LastAuthor>
  <o:Created>2010-01-26T08:50:04Z</o:Created>
  <o:LastSaved>2010-01-27T01:45:42Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl25
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl27
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:black none;}
.xl28
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	background:white;
	mso-pattern:black none;}
.xl29
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	background:white;
	mso-pattern:black none;}
.xl30
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	background:white;
	mso-pattern:black none;}
.xl31
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	background:white;
	mso-pattern:black none;}
.xl32
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:black none;}
.xl33
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	background:white;
	mso-pattern:black none;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;}
.xl36
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:left;
	background:white;
	mso-pattern:black none;}
.xl37
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:right;
	background:white;
	mso-pattern:black none;}
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:black none;}
.xl39
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:black none;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:black none;}
.xl41
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center-across;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center-across;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;}
.xl43
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:black none;}
.xl44
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;}
.xl45
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double black;
	background:white;
	mso-pattern:black none;}
.xl46
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;}
.xl47
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;}
.xl48
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:black none;}
.xl50
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:black none;}
.xl51
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:black none;}
.xl52
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:black none;}
.xl53
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:black none;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:black none;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:black none;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:black none;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:black none;}
.xl63
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:black none;}
.xl64
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:black none;}
.xl65
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:black none;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:black none;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:black none;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:black none;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:black none;}
.xl71
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;}
.xl72
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;}
.xl73
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;}
.xl74
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	background:white;
	mso-pattern:black none;}
.xl75
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:black none;}
.xl76
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl77
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl78
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl79
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl80
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl82
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl83
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl84
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;}
.xl85
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl86
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;}
.xl87
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	background:white;
	mso-pattern:black none;}
.xl88
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	background:white;
	mso-pattern:black none;}
.xl89
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	background:white;
	mso-pattern:black none;}
.xl90
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:black none;}
.xl91
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;}
.xl92
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl93
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl94
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl95
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl96
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl97
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:black none;}
.xl98
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:black none;}
.xl99
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:black none;}
.xl100
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:black none;}
.xl101
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	vertical-align:middle;
	background:white;
	mso-pattern:black none;}
.xl102
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:left;
	background:white;
	mso-pattern:black none;}
.xl103
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	background:white;
	mso-pattern:black none;}
.xl104
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	background:white;
	mso-pattern:black none;}
.xl105
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	background:white;
	mso-pattern:black none;}
.xl106
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:black none;}
.xl107
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center-across;
	background:white;
	mso-pattern:black none;}
.xl108
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	background:white;
	mso-pattern:black none;}
.xl109
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	background:white;
	mso-pattern:black none;}
.xl110
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center-across;
	background:white;
	mso-pattern:black none;}
.xl111
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>sheet 1</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:DoNotDisplayGridlines/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8310</x:WindowHeight>
  <x:WindowWidth>15240</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl111>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2218 style='border-collapse:
 collapse;table-layout:fixed;width:1669pt'>
 <col class=xl32 width=37 style='mso-width-source:userset;mso-width-alt:1353;
 width:28pt'>
 <col class=xl32 width=126 style='mso-width-source:userset;mso-width-alt:4608;
 width:95pt'>
 <col class=xl32 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <col class=xl30 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl30 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl30 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 <col class=xl30 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl29 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl30 width=87 style='mso-width-source:userset;mso-width-alt:3181;
 width:65pt'>
 <col class=xl29 width=102 style='mso-width-source:userset;mso-width-alt:3730;
 width:77pt'>
 <col class=xl30 width=78 span=2 style='mso-width-source:userset;mso-width-alt:
 2852;width:59pt'>
 <col class=xl29 width=101 style='mso-width-source:userset;mso-width-alt:3693;
 width:76pt'>
 <col class=xl30 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl30 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl30 width=57 style='mso-width-source:userset;mso-width-alt:2084;
 width:43pt'>
 <col class=xl30 width=92 colspan=2 style='mso-width-source:userset;mso-width-alt:3364;
 width:69pt'>
 <col class=xl30 width=92 style='mso-width-source:userset;mso-width-alt:3364;
 width:69pt'>
 <col class=xl29 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl30 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl29 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl29 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl29 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl29 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl32 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl32 width=279 style='mso-width-source:userset;mso-width-alt:10203;
 width:209pt'>
 <col class=xl32 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl32 width=64 style='width:48pt'>
 <col class=xl32 width=0 span=2 style='mso-width-source:userset;
 mso-width-alt:0'>
 <col class=xl32 width=0 style='mso-width-source:userset;
 mso-width-alt:2889'>
 <col class=xl32 width=0 span=3 style='mso-width-source:userset;
 mso-width-alt:0'>
 <tr class=xl33 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=3 height=24 class=xl27 width=218 style='height:18.0pt;width:164pt'>POSLILAMA
  E &amp; C</td>
  <td class=xl28 width=73 style='width:55pt'>&nbsp;</td>
  <td class=xl28 width=75 style='width:56pt'>&nbsp;</td>
  <td class=xl28 width=69 style='width:52pt'>&nbsp;</td>
  <td class=xl28 width=75 style='width:56pt'>&nbsp;</td>
  <td class=xl29 width=94 style='width:71pt'>&nbsp;</td>
  <td class=xl30 width=87 style='width:65pt'>&nbsp;</td>
  <td class=xl29 width=102 style='width:77pt'>&nbsp;</td>
  <td class=xl30 width=78 style='width:59pt'>&nbsp;</td>
  <td class=xl29 width=78 style='width:59pt'>&nbsp;</td>
  <td class=xl30 width=101 style='width:76pt'>&nbsp;</td>
  <td class=xl30 width=62 style='width:47pt'>&nbsp;</td>
  <td class=xl30 width=56 style='width:42pt'>&nbsp;</td>
  <td class=xl30 width=57 style='width:43pt'>&nbsp;</td>
  <td class=xl29 width=74 style='width:56pt'>&nbsp;</td>
  <td class=xl29 width=74 style='width:56pt'>&nbsp;</td>
  <td class=xl29 width=92 style='width:69pt'>&nbsp;</td>
  <td class=xl30 width=86 style='width:65pt'>&nbsp;</td>
  <td class=xl29 width=86 style='width:65pt'>&nbsp;</td>
  <td class=xl29 width=86 style='width:65pt'>&nbsp;</td>
  <td class=xl29 width=86 style='width:65pt'>&nbsp;</td>
  <td class=xl31 width=93 style='width:70pt'>&nbsp;</td>
  <td class=xl32 width=68 style='width:51pt'>&nbsp;</td>
  <td class=xl31 width=279 style='width:209pt'>&nbsp;</td>
  <td class=xl32 width=77 style='width:58pt'>&nbsp;</td>
  <td class=xl32 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl32 width=0>&nbsp;</td>
  <td class=xl32 width=0>&nbsp;</td>
  <td class=xl32 width=0>&nbsp;</td>
  <td class=xl32 width=0>&nbsp;</td>
  <td class=xl32 width=0>&nbsp;</td>
  <td class=xl32 width=0>&nbsp;</td>
 </tr>
 <tr class=xl33 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=24 height=24 class=xl34 style='height:18.0pt'>SALARY TABLE -
  <%=P_WORK_MON.Substring(4,2).ToString() + "/" + P_WORK_MON.Substring(0,4).ToString() %></td>
  <td colspan=8 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl33 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl35 style='height:18.0pt' x:str="Exchange"><span
  style='mso-spacerun:yes'> </span>Exchange<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36>&nbsp;</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl29>VND</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td colspan=8 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl49 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td rowspan=3 height=84 class=xl38 style='border-bottom:.5pt solid black;
  height:63.0pt;border-top:none'>No</td>
  <td rowspan=3 class=xl39 style='border-bottom:.5pt solid black;border-top:
  none'>Name</td>
  <td rowspan=3 class=xl40 style='border-bottom:.5pt solid black'>Emp ID</td>
  <td class=xl41 align=center>INCOME</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td colspan=2 class=xl43 style='border-right:2.0pt double black;border-left:
  none' x:str="PER. INCOME TAX (B)"><span style='mso-spacerun:yes'> </span>PER.
  INCOME TAX (B)<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl45 style='border-right:2.0pt double black;border-left:
  none' x:str="NET INCOME (C) = (A)-(B)"><span
  style='mso-spacerun:yes'> </span>NET INCOME (C) = (A)-(B)<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=9 class=xl45 style='border-right:2.0pt double black;border-left:
  none' x:str="DEDUCTION"><span style='mso-spacerun:yes'> </span>DEDUCTION<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl45 style='border-right:2.0pt double black;border-left:
  none' x:str="REMAIN ( VND)"><span style='mso-spacerun:yes'> </span>REMAIN (
  VND)<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none' x:str="PROJECT"><span style='mso-spacerun:yes'> </span>PROJECT<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl48 width=77 style='border-bottom:.5pt solid black;
  width:58pt' x:str="REMARKS"><span
  style='mso-spacerun:yes'> </span>REMARKS<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=7 class=xl49 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl49 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td rowspan=2 height=60 class=xl53 width=73 style='border-bottom:.5pt solid black;
  height:45.0pt;border-top:none;width:55pt'>SUM</td>
  <td class=xl54 width=75 style='width:56pt'>&nbsp;</td>
  <td class=xl55 width=69 style='border-top:none;width:52pt'>&nbsp;</td>
  <td class=xl55 width=75 style='border-top:none;width:56pt'>&nbsp;</td>
  <td class=xl56 width=94 style='width:71pt'>&nbsp;</td>
  <td rowspan=2 class=xl57 width=87 style='border-bottom:.5pt solid black;
  border-top:none;width:65pt'>(VND)</td>
  <td rowspan=2 class=xl58 width=102 style='border-bottom:.5pt solid black;
  border-top:none;width:77pt'>(USD)</td>
  <td rowspan=2 class=xl57 width=78 style='border-bottom:.5pt solid black;
  border-top:none;width:59pt'>(VND)</td>
  <td rowspan=2 class=xl58 width=78 style='border-bottom:.5pt solid black;
  border-top:none;width:59pt'>(USD)</td>
  <td rowspan=2 class=xl57 width=101 style='border-bottom:.5pt solid black;
  border-top:none;width:76pt'>(VND)</td>
  <td rowspan=2 class=xl53 width=62 style='border-bottom:.5pt solid black;
  border-top:none;width:47pt'>SUM (USD)</td>
  <td class=xl54 width=56 style='width:42pt'>&nbsp;</td>
  <td class=xl54 width=57 style='width:43pt'>&nbsp;</td>
  <td class=xl55 width=74 style='border-top:none;width:56pt'>&nbsp;</td>
  <td class=xl54 width=74 style='width:56pt'>&nbsp;</td>
  <td class=xl54 width=74 style='width:56pt'>&nbsp;</td>
  <td class=xl54 width=74 style='width:56pt'>&nbsp;</td>
  <td class=xl59 width=92 style='border-top:none;width:69pt'>&nbsp;</td>
  <td rowspan=2 class=xl57 width=86 style='border-bottom:.5pt solid black;
  border-top:none;width:65pt'>(VND)</td>
  <td rowspan=2 class=xl58 width=86 style='border-bottom:.5pt solid black;
  border-top:none;width:65pt'>(USD)</td>
  <td rowspan=2 class=xl57 width=93 style='border-bottom:.5pt solid black;
  border-top:none;width:70pt'>(VND)</td>
  <td rowspan=2 class=xl60 width=68 style='border-bottom:.5pt solid black;
  border-top:none;width:51pt' x:str="CODE"><span
  style='mso-spacerun:yes'> </span>CODE<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl60 width=279 style='border-bottom:.5pt solid black;
  border-top:none;width:209pt' x:str="NAME"><span
  style='mso-spacerun:yes'> </span>NAME<span style='mso-spacerun:yes'> </span></td>
  <td colspan=7 class=xl49 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl49 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl56 width=75 style='height:27.0pt;width:56pt'>SALARY</td>
  <td class=xl56 width=69 style='width:52pt'>OVERTIME</td>
  <td class=xl56 width=75 style='width:56pt'>H.RENTAL</td>
  <td class=xl56 width=94 style='width:71pt'>ALLOW</td>
  <td class=xl56 width=56 style='width:42pt'>Advaced salary</td>
  <td class=xl56 width=57 style='width:43pt'>Air - Ticket fee</td>
  <td class=xl56 width=74 style='width:56pt'>Health Insurance (1.5%)</td>
  <td class=xl56 width=74 style='width:56pt'>Health Insurance (3%)</td>
  <td class=xl56 width=74 style='width:56pt'>Advance for House Rental</td>
  <td class=xl56 width=92 style='width:69pt'>Health Insurance (VND) (1.5%)</td>
  <td class=xl56 width=92 style='width:69pt'>Health Insurance (VND) (3%)</td>
  <td colspan=7 class=xl49 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl74 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl70 style='height:18.0pt'>(1)</td>
  <td class=xl71>(2)</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl70>(3)</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl73>(4)=3xEx.Rate</td>
  <td class=xl71>(5)=(6)/Ex. Rate</td>
  <td class=xl73>(6)=(4) x Rate</td>
  <td class=xl71>(7)=(3)-(5)</td>
  <td class=xl73>(8) = (4)-(6)</td>
  <td class=xl71>(9)</td>
  <td class=xl71>(9.1)</td>
  <td class=xl71>(9.2)</td>
  <td class=xl71>(9.3)</td>
  <td class=xl71></td>
  <td class=xl71>(9.4)</td>
  <td class=xl71></td>
  <td class=xl71>&nbsp;</td>
  <td class=xl73>(10) = (7)-(9)</td>
  <td class=xl71>(11)</td>
  <td class=xl73>(12) = (8)-(11)</td>
  <td class=xl71>(13)</td>
  <td class=xl71>(14)</td>
  <td class=xl73>(15)</td>
  <td colspan=7 class=xl74 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
  <%
    int i;
    string sformat;
    double[] Group_Total=new double[icol_emp];
    for (int j=2;j<icol_emp;j++)
    {
        Group_Total[j-2]=0;
    }
    
    for (i=0;i<irow_emp;i++)
    {
        for (int j=2;j < icol_emp-3;j++)
        {
            Group_Total[j-2]+=Double.Parse(dt_Emp.Rows[i][j].ToString());
        }
  %>
 <tr class=xl33 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl75 style='height:18.0pt' x:num><%=i+1 %></td>
  <td class=xl24><%=dt_Emp.Rows[i][0].ToString()%></td>
  <td class=xl26 x:num><%=dt_Emp.Rows[i][1].ToString()%></td>
  <td class=xl76 align=right x:num><%=dt_Emp.Rows[i][2].ToString()%></td>
  <td class=xl77 align=right x:num><%=dt_Emp.Rows[i][3].ToString()%></td>
  <td class=xl77 align=right x:num><%=dt_Emp.Rows[i][4].ToString()%></td>
  <td class=xl77 align=right x:num><%=dt_Emp.Rows[i][5].ToString()%></td>
  <td class=xl77 align=right x:num><%=dt_Emp.Rows[i][6].ToString()%></td>
  <td class=xl78 x:num><%=dt_Emp.Rows[i][7].ToString()%></td>
  <td class=xl79 x:num><%=dt_Emp.Rows[i][8].ToString()%></td>
  <td class=xl78 x:num><%=dt_Emp.Rows[i][9].ToString()%></td>
  <td class=xl79 x:num><%=dt_Emp.Rows[i][10].ToString()%></td>
  <td class=xl78 x:num><%=dt_Emp.Rows[i][11].ToString()%></td>
  <td class=xl77 align=right x:num><%=dt_Emp.Rows[i][12].ToString()%></td>
  <td class=xl80 x:num><%=dt_Emp.Rows[i][13].ToString()%></td>
  <td class=xl80 x:num><%=dt_Emp.Rows[i][14].ToString()%></td>
  <td class=xl80 x:num><%=dt_Emp.Rows[i][15].ToString()%></td>
  <td class=xl80 x:num><%=dt_Emp.Rows[i][21].ToString()%></td>
  <td class=xl80 x:num><%=dt_Emp.Rows[i][16].ToString()%></td>
  <td class=xl81 x:num><%=dt_Emp.Rows[i][17].ToString()%></td>
  <td class=xl81 x:num><%=dt_Emp.Rows[i][22].ToString()%></td>
  <td class=xl81 x:num><%=dt_Emp.Rows[i][18].ToString()%></td>
  <td class=xl82 x:num><%=dt_Emp.Rows[i][19].ToString()%></td>
  <td class=xl83 x:num><%=dt_Emp.Rows[i][20].ToString()%></td>
  <td class=xl84><%=dt_Emp.Rows[i][23].ToString()%></td>
  <td class=xl85><%=dt_Emp.Rows[i][24].ToString()%></td>
  <td class=xl86><%=dt_Emp.Rows[i][25].ToString()%></td>
  <td class=xl87></td>
  <td class=xl32 align=right x:num></td>
  <td class=xl88 x:str><span
  style='mso-spacerun:yes'> </span><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl89></td>
  <td class=xl32 align=right x:num></td>
  <td class=xl32></td>
  <td class=xl32 align=center ></td>
 </tr>
<%
     }
 %>
 <tr class=xl33 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=3 class=xl32 style='height:18.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=5 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=6 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=5 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl89>&nbsp;</td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl33 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl90 style='height:18.0pt' x:num>22</td>
  <td class=xl91>Total</td>
  <td class=xl91>&nbsp;</td>
  <td class=xl92 x:num><%=Group_Total[0] %></td>
  <td class=xl93 x:num><%=Group_Total[1] %></td>
  <td class=xl93 x:num><%=Group_Total[2] %></td>
  <td class="xl93" x:num><%=Group_Total[3] %></td>
  <td class=xl93 x:num><%=Group_Total[4] %></td>
  <td class=xl94 x:num><%=Group_Total[5] %></td>
  <td class=xl93 x:num><%=Group_Total[6] %></td>
  <td class=xl94 x:num><%=Group_Total[7] %></td>
  <td class=xl93 x:num><%=Group_Total[8] %></td>
  <td class=xl94 x:num><%=Group_Total[9] %></td>
  <td class=xl93 x:num><%=Group_Total[10] %></td>
  <td class=xl93 x:num><%=Group_Total[11] %></td>
  <td class=xl93 x:num><%=Group_Total[12] %></td>
  <td class=xl93 x:num><%=Group_Total[13] %></td>
  <td class=xl93 x:num><%=Group_Total[19] %></td>
  <td class=xl93 x:num><%=Group_Total[14] %></td>
  <td class=xl94 x:num><%=Group_Total[15] %></td>
  <td class=xl94 x:num><%=Group_Total[20] %></td>
  <td class=xl94 x:num><%=Group_Total[16] %></td>
  <td class=xl93 x:num><%=Group_Total[17] %></td>
  <td class=xl94 x:num><%=Group_Total[18] %></td>
  <td class=xl95 x:str></td>
  <td class=xl95 x:str></td>
  <td class=xl96>&nbsp;</td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl89>&nbsp;</td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl33 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=3 class=xl97 style='height:18.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 class=xl98 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl99>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl99>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl99>&nbsp;</td>
  <td colspan=4 class=xl98 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl99 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl99>&nbsp;</td>
  <td class=xl100>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl101>&nbsp;</td>
  <td colspan=7 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
 </tr>
 <tr class=xl33 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt'>&nbsp;</td>
  <td class=xl36 x:str="Prepared by"><span
  style='mso-spacerun:yes'> </span>Prepared by<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36>&nbsp;</td>
  <td colspan=4 class=xl102 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl103>HR &amp; G. Affairs Team Leader</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl104>V. G. Director</td>
  <td class=xl103>&nbsp;</td>
  <td colspan=4 class=xl104 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl103>&nbsp;</td>
  <td class=xl103>General Director</td>
  <td class=xl103>&nbsp;</td>
  <td class=xl104>&nbsp;</td>
  <td class=xl103>&nbsp;</td>
  <td class=xl105>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl105>&nbsp;</td>
  <td colspan=7 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
 </tr>
 <tr class=xl33 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt'>&nbsp;</td>
  <td colspan=2 class=xl106 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl104>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl107>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl105>&nbsp;</td>
  <td colspan=7 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
 </tr>
 <tr class=xl33 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt'>&nbsp;</td>
  <td colspan=2 class=xl106 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl104>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl107>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl105>&nbsp;</td>
  <td colspan=7 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
 </tr>
 <tr class=xl33 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt'>&nbsp;</td>
  <td colspan=2 class=xl106 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl104>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl107>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl105>&nbsp;</td>
  <td colspan=7 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
 </tr>
 <tr class=xl33 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt'>&nbsp;</td>
  <td colspan=2 class=xl106 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl104>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl108>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl105>&nbsp;</td>
  <td colspan=7 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
 </tr>
 <tr class=xl33 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl109 style='height:18.0pt'>&nbsp;</td>
  <td colspan=2 class=xl109 x:str="NGUY&#7876;N T&#7844;T TH&#7854;NG"><span
  style='mso-spacerun:yes'> </span>NGUY&#7876;N T&#7844;T TH&#7854;NG<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl110 align=center>KIM HYEON</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl104>LE VAN PHNG</td>
  <td class=xl103>&nbsp;</td>
  <td colspan=4 class=xl104 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl103>&nbsp;</td>
  <td class=xl103>PARK, SI SUNG</td>
  <td class=xl103>&nbsp;</td>
  <td class=xl104>&nbsp;</td>
  <td class=xl103>&nbsp;</td>
  <td class=xl105>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl105>&nbsp;</td>
  <td colspan=7 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
 </tr>
 <tr class=xl33 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=3 class=xl32 style='height:18.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl105>&nbsp;</td>
  <td colspan=7 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
 </tr>
 <tr class=xl33 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=3 class=xl32 style='height:18.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl105>&nbsp;</td>
  <td colspan=7 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
 </tr>
 <tr class=xl33 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=3 class=xl32 style='height:18.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl105>&nbsp;</td>
  <td colspan=7 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
 </tr>
 <tr class=xl33 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=3 class=xl32 style='height:18.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl105>&nbsp;</td>
  <td colspan=7 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
 </tr>
 <tr class=xl33 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=3 class=xl32 style='height:18.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl105>&nbsp;</td>
  <td colspan=7 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
 </tr>
 <tr class=xl33 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=3 class=xl32 style='height:18.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl105>&nbsp;</td>
  <td colspan=7 class=xl32 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=37 style='width:28pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=279 style='width:209pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
