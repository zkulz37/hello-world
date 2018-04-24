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

string p_work_mon,p_from,p_to,p_option, SQL;    

        p_work_mon = Request["p_1"].ToString();
        p_from = Request["p_from"].ToString();
        p_to = Request["p_to"].ToString();
        p_option = Request["p_option"].ToString();
        
 string SQL1
    = "SELECT DECODE(S.EMPLOYEE_TYPE,'01','OFFICE','FACTORY')  " + 
        ",S.EMP_ID " +
        ",S.FULL_NAME " +
        ",S.POS_NM " +
        ",S.DEPT_NM " +
        ",NVL(S.SALARY_LEVEL2,0) " +
        ",TO_CHAR(TO_DATE(S.JOIN_DT,'YYYYMMDD'),'DD/MM/YYYY') JOIN_DT " +
        ",TO_CHAR(TO_DATE(S.LEFT_DT,'YYYYMMDD'),'DD/MM/YYYY') LEFT_DT " +
        ",NVL(W.WT_TMP_L1,0) " +
        ",ROUND(NVL(S.ALLOW_K1_AMT,0),0) TRANS " +
        ",ROUND(NVL(S.ALLOW_K2_AMT,0),0) PHONE " +
        ",ROUND(NVL(S.ALLOW_K3_AMT,0),0) LUNCH " +
        ",ROUND(NVL(S.ALLOW_K4_AMT,0),0) RES " +
        ",ROUND(NVL(S.ALLOW_K5_AMT,0),0) KOREAN " +
        ",ROUND(NVL(S.ALLOW_K6_AMT,0),0) DELIGENT " +
        ",ROUND(NVL(S.NET_AMT,0),0) TOTAL " +
        "FROM THR_MONTH_SALARY S, THR_WORK_MON W " +
        "WHERE S.DEL_IF=0 AND W.DEL_IF=0 " +
        "AND S.THR_EMP_PK = W.THR_EMP_PK " +
        "AND S.WORK_MON = W.WORK_MON " +
        "AND S.WORK_MON='"+ p_work_mon +"' " +
        "AND S.JOIN_DT BETWEEN '" + p_from + "' AND '" + p_to + "' " +
        "ORDER BY S.EMPLOYEE_TYPE " ;

 string SQL2
 = "SELECT DECODE(S.EMPLOYEE_TYPE,'01','OFFICE','FACTORY')  " +
     ",S.EMP_ID " +
     ",S.FULL_NAME " +
     ",S.POS_NM " +
     ",S.DEPT_NM " +
     ",NVL(S.SALARY_LEVEL2,0) " +
     ",TO_CHAR(TO_DATE(S.JOIN_DT,'YYYYMMDD'),'DD/MM/YYYY') JOIN_DT " +
     ",TO_CHAR(TO_DATE(S.LEFT_DT,'YYYYMMDD'),'DD/MM/YYYY') LEFT_DT " +
     ",NVL(W.WT_TMP_L1,0) " +
     ",ROUND(NVL(S.ALLOW_K1_AMT,0),0) TRANS " +
     ",ROUND(NVL(S.ALLOW_K2_AMT,0),0) PHONE " +
     ",ROUND(NVL(S.ALLOW_K3_AMT,0),0) LUNCH " +
     ",ROUND(NVL(S.ALLOW_K4_AMT,0),0) RES " +
     ",ROUND(NVL(S.ALLOW_K5_AMT,0),0) KOREAN " +
     ",ROUND(NVL(S.ALLOW_K6_AMT,0),0) DELIGENT " +
     ",ROUND(NVL(S.NET_AMT,0),0) TOTAL " +
     "FROM THR_MONTH_SALARY S, THR_WORK_MON W " +
     "WHERE S.DEL_IF=0 AND W.DEL_IF=0 " +
     "AND S.THR_EMP_PK = W.THR_EMP_PK " +
     "AND S.WORK_MON = W.WORK_MON " +
     "AND S.WORK_MON='" + p_work_mon + "' " +
     "AND NVL(S.LEFT_DT,'30000101') BETWEEN '" + p_from + "' AND '" + p_to + "' " +
     "ORDER BY S.EMPLOYEE_TYPE ";

 if (p_option == "1")
     SQL = SQL1;
 else SQL = SQL2;
        
    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp=dt_Emp.Columns.Count;
    if (irow_emp == 0)
    {
        Response.Write("There is no data of salary");
        Response.End();
    }

    //----- Day info--
    string SQL_Day
    = "select to_char(to_date(a.FROM_DT,'YYYYMMDD'),'DD/MM/YYYY'), to_char(to_date(a.TO_DT,'YYYYMMDD'),'DD/MM/YYYY'), to_char(to_date('" + p_work_mon + "','YYYYMM'),'MONTH,YYYY') " +
        "from thr_close a where a.del_if=0 " +
        "and a.MONTH_CLOSE='" + p_work_mon + "' and a.ID='01' ";

    DataTable dt_Day = ESysLib.TableReadOpen(SQL_Day);
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_new_staff_vhpc_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_new_staff_vhpc_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_new_staff_vhpc_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>HR_PHU</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-02-16T02:19:30Z</o:LastPrinted>
  <o:Created>2011-02-08T01:52:52Z</o:Created>
  <o:LastSaved>2011-02-16T02:20:51Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .25in .5in .25in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;
	mso-page-orientation:landscape;}
.font12
	{color:black;
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font24
	{color:black;
	font-size:14.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
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
.style45
	{mso-number-format:"\0022$\0022\#\,\#\#0\.00";
	mso-style-name:"Comma_New staff11-06";}
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
.style57
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"Normal_New staff11-06";}
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
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl68
	{mso-style-parent:style0;
	font-size:10.5pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"\.VnTimeH", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl72
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl73
	{mso-style-parent:style57;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;}
.xl74
	{mso-style-parent:style45;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;
	padding-left:9px;
	mso-char-indent-count:1;}
.xl75
	{mso-style-parent:style57;
	color:windowtext;
	font-family:"\.VnTimeH", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl76
	{mso-style-parent:style57;
	color:windowtext;
	font-family:"\.VnTimeH", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl77
	{mso-style-parent:style57;
	color:windowtext;
	font-family:"\.VnTimeH", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl78
	{mso-style-parent:style57;
	font-family:"\.VnTimeH", sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"\.VnTimeH", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl80
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"\.VnTimeH", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl81
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"\.VnTimeH", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl82
	{mso-style-parent:style0;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"\.VnTimeH", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto gray-0625;}
.xl83
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"\.VnTimeH", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto gray-0625;}
.xl84
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;}
.xl85
	{mso-style-parent:style0;
	font-size:10.5pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;}
.xl86
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;}
.xl87
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
.xl88
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl89
	{mso-style-parent:style57;
	font-family:"\.VnTimeH", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	padding-left:9px;
	mso-char-indent-count:1;}
.xl90
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"\.VnTimeH", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl91
	{mso-style-parent:style43;
	font-size:13.0pt;
	font-weight:700;
	font-family:"\.VnTimeH", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto gray-0625;}
.xl92
	{mso-style-parent:style0;
	mso-number-format:"\@";}
.xl93
	{mso-style-parent:style45;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;
	padding-left:9px;
	mso-char-indent-count:1;}
.xl94
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl95
	{mso-style-parent:style0;
	font-size:10.5pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl96
	{mso-style-parent:style43;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;}
.xl97
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl98
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl99
	{mso-style-parent:style45;
	font-family:"\.VnTimeH", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	padding-left:9px;
	mso-char-indent-count:1;}
.xl100
	{mso-style-parent:style43;
	font-size:13.0pt;
	font-weight:700;
	font-family:"\.VnTimeH", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl101
	{mso-style-parent:style43;
	font-size:13.0pt;
	font-weight:700;
	font-family:"\.VnTimeH", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl102
	{mso-style-parent:style43;
	font-size:13.0pt;
	font-weight:700;
	font-family:"\.VnTimeH", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto gray-0625;}
.xl103
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl104
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl105
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl106
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl107
	{mso-style-parent:style43;
	color:windowtext;
	font-family:"\.VnTimeH", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl108
	{mso-style-parent:style43;
	color:windowtext;
	font-family:"\.VnTimeH", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl109
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
.xl110
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl111
	{mso-style-parent:style45;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;}
.xl112
	{mso-style-parent:style57;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl113
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl114
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl115
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl116
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl117
	{mso-style-parent:style0;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"\.VnTimeH", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto gray-0625;}
.xl118
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl119
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl120
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl121
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl122
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl123
	{mso-style-parent:style0;
	mso-number-format:"\@";
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl124
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl125
	{mso-style-parent:style0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl126
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl127
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl128
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl129
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl130
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl131
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl132
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl133
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl134
	{mso-style-parent:style0;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"\.VnTimeH", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl135
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl136
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;}
.xl137
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>STAFF</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>64</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>17</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
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
 <o:shapedefaults v:ext="edit" spidmax="5121"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1703 style='border-collapse:
 collapse;table-layout:fixed;width:1276pt'>
 <col class=xl92 width=64 span=2 style='width:48pt'>
 <col width=171 style='mso-width-source:userset;mso-width-alt:6253;width:128pt'>
 <col width=124 style='mso-width-source:userset;mso-width-alt:4534;width:93pt'>
 <col width=115 style='mso-width-source:userset;mso-width-alt:4205;width:86pt'>
 <% 
    if(p_option=="1")
    {
  %>
 <col class=xl103 width=104 style='mso-width-source:userset;mso-width-alt:3803;
 width:78pt'>
 <%
    }
    else
    {
  %>
 <col class=xl92 width=76  style='mso-width-source:userset;mso-width-alt:
 2779;width:57pt'>
 <%
    }
  %>
  <col class=xl92 width=76  style='mso-width-source:userset;mso-width-alt:
 2779;width:57pt'>
 <col class=xl103 width=76 span=7 style='mso-width-source:userset;mso-width-alt:
 2779;width:57pt'>
 <col class=xl103 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col width=123 style='mso-width-source:userset;mso-width-alt:4498;width:92pt'>
 <col width=64 style='width:48pt'>
 <col width=87 style='mso-width-source:userset;mso-width-alt:3181;width:65pt'>
 <tr height=31 style='height:23.25pt'>
  <td height=31 class=xl84 colspan=4 width=423 style='height:23.25pt;
  mso-ignore:colspan;width:317pt'>POSCO VIETNAM PROCESSING CENTER CO.,LTD.</td>
  <td class=xl67 width=115 style='width:86pt'></td>
  <td class=xl94 width=104 style='width:78pt'></td>
  <td class=xl84 width=76 style='width:57pt'></td>
  <td class=xl84 width=76 style='width:57pt'></td>
  <td class=xl104 width=76 style='width:57pt'></td>
  <td class=xl104 width=76 style='width:57pt'></td>
  <td class=xl104 width=76 style='width:57pt'></td>
  <td class=xl104 width=76 style='width:57pt'></td>
  <td class=xl104 width=76 style='width:57pt'></td>
  <td class=xl104 width=76 style='width:57pt'></td>
  <td class=xl104 width=76 style='width:57pt'></td>
  <td class=xl104 width=103 style='width:77pt'></td>
  <td class=xl104 width=123 style='width:92pt'></td>
  <td class=xl104 width=64 style='width:48pt'></td>
  <td class=xl104 width=87 style='width:65pt'></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 class=xl85 colspan=2 style='height:23.25pt;mso-ignore:colspan'
  x:str="DEPARTMENT: ">DEPARTMENT:<span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl95></td>
  <td colspan=2 class=xl85 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl104 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 class=xl136 colspan=3 style='height:23.25pt;mso-ignore:colspan'>MONTH:
  <%=dt_Day.Rows[0][2].ToString() %></td>
  <td colspan=2 class=xl69 style='mso-ignore:colspan'></td>
  <td class=xl96></td>
  <td colspan=2 class=xl86 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl104 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=62 style='mso-height-source:userset;height:46.5pt'>
  <td colspan=17 height=62 class=xl120 width=1552 style='height:46.5pt;
  width:1163pt'>
  <%if (p_option == "1")
    { 
   %>NEW STAFF 
   <%}
     else
     { %>
   RESIGN STAFF
   <%} %>
   <font class="font12"><br>
    </font><font class="font24">(<%=dt_Day.Rows[0][0].ToString() %>-<%=dt_Day.Rows[0][1].ToString() %>)</font></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 colspan=2 class=xl109 style='height:23.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl71 style='mso-ignore:colspan'></td>
  <td class=xl97></td>
  <td colspan=2 class=xl87 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl104 style='mso-ignore:colspan'></td>
  <td class=xl71></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 class=xl110 style='height:23.25pt'>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <%
      if (p_option == "1")
      {
       %>
  <td class=xl88>&nbsp;</td>
  <%
      }
      else
      { %>
  <td class=xl88>&nbsp;</td>
  <%  } %>
  <td class=xl98>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td rowspan=2 height=70 class=xl122 style='border-bottom:1.0pt solid black;
  height:52.5pt;border-top:none'>NO.</td>
  <td rowspan=2 class=xl124 style='border-bottom:1.0pt solid black;border-top:
  none'>Code</td>
  <td rowspan=2 class=xl113 style='border-bottom:1.0pt solid black;border-top:
  none'>NAME</td>
  <td rowspan=2 class=xl113 style='border-bottom:1.0pt solid black;border-top:
  none'>POSITION</td>
  <td rowspan=2 class=xl113 style='border-bottom:1.0pt solid black;border-top:
  none'>DEPARTMENT</td>
  <td rowspan=2 class=xl126 style='border-bottom:1.0pt solid black;border-top:
  none' x:str="SALARY"><span style='mso-spacerun:yes'> </span>SALARY<span
  style='mso-spacerun:yes'> </span></td>
  <%
      if (p_option == "1")
      {
       %>
  <td rowspan=2 class=xl115 width=76 style='border-bottom:1.0pt solid black;
  border-top:none;width:57pt'>STARTING<br>
    DATE</td>
  <%
      }
      else
      {
   %>
  <td rowspan=2 class=xl115 width=76 style='border-bottom:1.0pt solid black;
  border-top:none;width:57pt'>RESIGN<br>
    DATE</td>
   <%} %>
  <td colspan=8 class=xl128 style='border-right:1.0pt solid black;border-left:
  none' x:str="SALARY MONTH"><span style='mso-spacerun:yes'> </span>SALARY
  MONTH<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl113 style='border-bottom:1.0pt solid black;border-top:
  none'>Remark</td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td height=45 class=xl105 width=76 style='height:33.75pt;border-left:none;
  width:57pt' x:str="WORKING DAYS"><span
  style='mso-spacerun:yes'> </span>WORKING DAYS<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl105 width=76 style='border-left:none;width:57pt' x:str="Trans"><span
  style='mso-spacerun:yes'> </span>Trans<span style='mso-spacerun:yes'> </span></td>
  <td class=xl105 width=76 style='border-left:none;width:57pt'
  x:str="Cell Phone"><span style='mso-spacerun:yes'> </span>Cell Phone<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl105 width=76 style='border-left:none;width:57pt' x:str="Lunch"><span
  style='mso-spacerun:yes'> </span>Lunch<span style='mso-spacerun:yes'> </span></td>
  <td class=xl105 width=76 style='border-left:none;width:57pt' x:str="Resp"><span
  style='mso-spacerun:yes'> </span>Resp<span style='mso-spacerun:yes'> </span></td>
  <td class=xl105 width=76 style='border-left:none;width:57pt' x:str="Korean"><span
  style='mso-spacerun:yes'> </span>Korean<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl105 width=76 style='border-left:none;width:57pt' x:str="Deligent"><span
  style='mso-spacerun:yes'> </span>Deligent<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl106 style='border-left:none' x:str="AMOUNT"><span
  style='mso-spacerun:yes'> </span>AMOUNT<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <%
    
     int count = 1;
     Boolean flag = true;
     Boolean flag_1 = false;
     double s1=0, s2=0, total1=0, total2=0;
     string emp_type_old="";string emp_type_new="";
     for (int i = 0; i < irow_emp; i++)
     {
         emp_type_old = dt_Emp.Rows[i][0].ToString();
         
         s1 = s1 + Double.Parse(dt_Emp.Rows[i][5].ToString());
         s2 = s2 + Double.Parse(dt_Emp.Rows[i][15].ToString());
         total1 += Double.Parse(dt_Emp.Rows[i][5].ToString());
         total2 += Double.Parse(dt_Emp.Rows[i][15].ToString());
         if (flag)
         {
  %>
 <tr height=25 style='height:18.75pt'>
 
  <td colspan=16 height=25 class=xl132 style='border-right:1.0pt solid black;
  height:18.75pt'>I. <%=dt_Emp.Rows[i][0].ToString()%></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
  <%     }
        flag = false;
             
              %>
 <tr height=24 style='height:18.0pt'>
  <td height=24 class=xl73 style='height:18.0pt;border-top:none'>1</td>
  <td class=xl135><%=dt_Emp.Rows[i][1].ToString()%></td>
  <td class=xl111 x:str><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][2].ToString()%><span style='mso-spacerun:yes'> </span></td>
  <td class=xl74 style='border-left:none' x:str><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][3].ToString()%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl74 style='border-left:none' x:str><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][4].ToString()%><span style='mso-spacerun:yes'> </span></td>
  <td class=xl93 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%=dt_Emp.Rows[i][5].ToString()%> </td>
  <%
     if(p_option=="1")
     {
   %>
  <td class=xl112><%=dt_Emp.Rows[i][6].ToString()%></td>
  <%
     }
     else 
     {
   %>
  <td class=xl112 style='border-left:none'><%=dt_Emp.Rows[i][7].ToString()%></td>
  <%  
     }
  %>
  <td class=xl93 x:num><span style='mso-spacerun:yes'>           </span><%=dt_Emp.Rows[i][8].ToString()%></td>
  </td>
  <td class=xl93 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>     </span><%=dt_Emp.Rows[i][9].ToString()%></td> </td>
  <td class=xl93 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>     </span><%=dt_Emp.Rows[i][10].ToString()%></td> </td>
  <td class=xl93 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>     </span><%=dt_Emp.Rows[i][11].ToString()%></td> </td>
  <td class=xl93 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>   </span><%=dt_Emp.Rows[i][12].ToString()%></td> </td>
  <td class=xl93 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><%=dt_Emp.Rows[i][13].ToString()%></td> </td>
  <td class=xl93 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><%=dt_Emp.Rows[i][14].ToString()%></td> </td>
  <td class=xl93 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%=dt_Emp.Rows[i][15].ToString()%></td> </td>
  <td class=xl74 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <%
     if (i < irow_emp - 1)
     {
         count = count + 1;
         emp_type_new = dt_Emp.Rows[i + 1][0].ToString();
         if (emp_type_new != emp_type_old)
         {
             flag = true;
             flag_1 = true;
         }
     }
     else
     {
         flag = true;
         flag_1 = true;
     }

     if (flag_1)
     {
  %>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl75 style='height:18.75pt;border-top:none'>&nbsp;</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <%
      if (p_option == "1")
      {
   %>
  <td class=xl89 style='border-top:none'>&nbsp;</td>
  <%
      }
      else
      {
   %>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <%  } %>
  <td class=xl107 style='border-top:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl108 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl78 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 
 <tr height=25 style='height:18.75pt'>
  <td colspan=3 height=25 class=xl134 style='border-right:1.0pt solid black;
  height:18.75pt'>TOTAL</td>
  <td class=xl79 style='border-top:none'>&nbsp;</td>
  <td class=xl79 style='border-top:none'>&nbsp;</td>
  <td class=xl100 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>   </span><%= s1 %> </td>
  <%
      if (p_option == "1")
      {
          %>
  <td class=xl90 style='border-top:none;border-left:none'>&nbsp;</td>
  <%
      }
      else
      { %>
  <td class=xl90 style='border-top:none;border-left:none'>&nbsp;</td>
  <%  } %>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>   </span><%= s2 %> </td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
  <%
            s1 = 0;
            s2 = 0;
         }
         flag_1 = false;
         
    }
  %>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=3 height=38 class=xl117 style='height:28.5pt'>Grand TOTAL</td>
  <td class=xl82 style='border-top:none'>&nbsp;</td>
  <td class=xl82 style='border-top:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>  </span><%= total1 %> </td>
  <%
      if (p_option == "1")
      {
       %>
  <td class=xl91 style='border-top:none;border-left:none'>&nbsp;</td>
  <%
      }
      else
      {
   %>
  <td class=xl91 style='border-top:none;border-left:none'>&nbsp;</td>
  <%  } %>
  <td class=xl102 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= total2 %> </td>
  <td class=xl83 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=171 style='width:128pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=87 style='width:65pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
