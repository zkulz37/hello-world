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
    string p_mon = Request.QueryString["p_mon"].ToString();

    string SQL_Com
    = "select v.CODE_NM " +
        "from vhr_hr_code v " +
        "where v.ID='HR0049' ";
    
    DataTable dt_com = ESysLib.TableReadOpen(SQL_Com);

    if (dt_com.Rows.Count == 0)
    {
        Response.Write("There is no data of regulation to show");
        Response.End();            
    }
    
    string SQL_DAY
	= "SELECT TO_CHAR(SYSDATE, 'DD'),TO_CHAR(SYSDATE, 'MM'),TO_CHAR(SYSDATE, 'YYYY')  FROM DUAL " ;

    DataTable dt_day = ESysLib.TableReadOpen(SQL_DAY);

    string SQL
    = "SELECT " + 
        "(SELECT V.CODE_FNM  FROM VHR_HR_CODE V WHERE V.ID='HR0054' AND V.CODE= A.INS_REG_TYPE) AS C0 " +
        ",(SELECT V.CODE_FNM  FROM VHR_HR_CODE V WHERE V.ID='HR0055' AND V.CODE= A.DETAIL_INS_REG_TYPE) AS C1 " +
        ",B.FULL_NAME AS C2 " +
        ",B.EMP_ID AS C3 " +
        ",DECODE(B.SEX, 'M', DECODE(LENGTH(B.BIRTH_DT), 8, TO_CHAR(TO_DATE(B.BIRTH_DT,'YYYYMMDD'),'DD/MM/YYYY'), B.BIRTH_DT), ' ') AS C4 " +
        ",DECODE(B.SEX, 'F', DECODE(LENGTH(B.BIRTH_DT), 8, TO_CHAR(TO_DATE(B.BIRTH_DT,'YYYYMMDD'),'DD/MM/YYYY'), B.BIRTH_DT), ' ') AS C5 " +
        ",A.SOCIAL_NO AS C6 " +
        ",DECODE(A.INS_REG_TYPE, '03', '', HR_GET_PERIOD_YEAR(" + p_mon + ", B.SOCIAL_DT, A.DETAIL_INS_REG_TYPE)) AS C7 " +
        ",DECODE(A.INS_REG_TYPE, '03', '25%',ROUND(NVL(A.AVERAGE_SALARY,0),0))  AS C8 " +
        ",A.CONDITION AS C9 " +
        ",A.THOI_DIEM AS C10 " +
        ",TO_CHAR(TO_DATE(A.FROM_DT,'YYYYMMDD'),'DD/MM/YYYY') AS C11 " +
        ",TO_CHAR(TO_DATE(A.TO_DT,'YYYYMMDD'),'DD/MM/YYYY') AS C12  " +
        ",NVL(A.DAYS,0) AS C13 " +
        ",NVL(A.PROGRESSIVE,0) AS C14 " +
        ",ROUND(NVL(A.INS_AMT,0),0) AS C15 " +
        ",' ' AS C16 " +
		" ,(SELECT V.NUM_1  FROM VHR_HR_CODE V WHERE V.ID='HR0055' AND V.CODE= A.DETAIL_INS_REG_TYPE) AS C17 " +
        ", A.DETAIL_INS_REG_TYPE AS C18 " +
        ", A.INS_REG_TYPE AS C19 " +
        "FROM THR_INS_REGULATION A, THR_EMPLOYEE B " +
        "WHERE A.DEL_IF=0 AND B.DEL_IF=0 " +
        "AND A.THR_EMP_PK = B.PK " +
        "AND A.INS_MONTH ='" + p_mon + "'   " +
        "ORDER BY A.INS_REG_TYPE, C17" ;


    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp=dt_Emp.Columns.Count;
    if(dt_Emp.Rows.Count==0)
    {
        Response.Write("There is no data to show");
        Response.End();
    } 

    // total type
    SQL
	= "SELECT " + 
        "(SELECT V.CODE_FNM  FROM VHR_HR_CODE V WHERE V.ID='HR0055' AND V.CODE= A.DETAIL_INS_REG_TYPE) AS C0 " +
        ",COUNT(A.PK) AS EMP_COUNT " +
        ",SUM(ROUND(NVL(A.INS_AMT,0),0)) AS AMT " +
		" ,MAX((SELECT V.NUM_1  FROM VHR_HR_CODE V WHERE V.ID='HR0055' AND V.CODE= A.DETAIL_INS_REG_TYPE)) AS C3 " +
        "FROM THR_INS_REGULATION A, THR_EMPLOYEE B " +
        "WHERE A.DEL_IF=0 AND B.DEL_IF=0 " +
        "AND A.THR_EMP_PK = B.PK " +
        "AND A.INS_MONTH ='" + p_mon + "'   " +
        "GROUP BY A.DETAIL_INS_REG_TYPE, A.INS_REG_TYPE " +
        "ORDER BY A.INS_REG_TYPE, C3 " ;

    DataTable dt_Kind = ESysLib.TableReadOpen(SQL);

    // total kind
    SQL
	= "SELECT " + 
        "(SELECT V.CODE_FNM  FROM VHR_HR_CODE V WHERE V.ID='HR0054' AND V.CODE= A.INS_REG_TYPE) AS C0 " +
        ",COUNT(A.PK) AS EMP_COUNT " +
        ",SUM(ROUND(NVL(A.INS_AMT,0),0)) AS AMT " +
        "FROM THR_INS_REGULATION A, THR_EMPLOYEE B " +
        "WHERE A.DEL_IF=0 AND B.DEL_IF=0 " +
        "AND A.THR_EMP_PK = B.PK " +
        "AND A.INS_MONTH ='" + p_mon + "'   " +
        "GROUP BY A.INS_REG_TYPE " +
        "ORDER BY A.INS_REG_TYPE " ;
    
    DataTable dt_Type = ESysLib.TableReadOpen(SQL);

    //DANH SACH DIEU CHINH

    
    string SQL_R
	= "SELECT " + 
        "(SELECT V.CODE_FNM  FROM VHR_HR_CODE V WHERE V.ID='HR0054' AND V.CODE= A.INS_REG_TYPE) AS C0 " +
        ",(SELECT V.CODE_FNM  FROM VHR_HR_CODE V WHERE V.ID='HR0055' AND V.CODE= A.DETAIL_INS_REG_TYPE) AS C1 " +
        ",B.FULL_NAME AS C2 " +
        ",B.EMP_ID AS C3 " +
        ",DECODE(B.SEX, 'M', DECODE(LENGTH(B.JOIN_DT), 8, TO_CHAR(TO_DATE(B.JOIN_DT,'YYYYMMDD'),'DD/MM/YYYY'), B.JOIN_DT), ' ') AS C4 " +
        ",DECODE(B.SEX, 'F', DECODE(LENGTH(B.JOIN_DT), 8, TO_CHAR(TO_DATE(B.JOIN_DT,'YYYYMMDD'),'DD/MM/YYYY'), B.JOIN_DT), ' ') AS C5 " +
        ",A.SOCIAL_NO AS C6 " +
        ",TO_CHAR(TO_DATE(A.INS_MONTH,'YYYYMM'),'MM/YYYY') AS C7  " +
        ",ROUND(NVL(A.INS_AMT,0),0) AS C8 " +
        ",ROUND(NVL(A.INS_AMT,0) - NVL(A.PAY_AMOUNT,0) ,0) AS C9 " +
        ",NVL(A.DAYS,0) AS C10 " +
        ",NVL(A.PROGRESSIVE,0) AS C11 " +
        ",' ' AS C12 " +
        "FROM THR_INS_REGULATION A, THR_EMPLOYEE B " +
        "WHERE A.DEL_IF=0 AND B.DEL_IF=0 " +
        "AND A.THR_EMP_PK = B.PK " +
        "AND NVL(A.MONTH_REPORT,'300001') = '"+ p_mon +"' " +
        "AND NVL(A.PAY_AMOUNT,0) >0 " +
        "AND NVL(A.PAY_AMOUNT,0) <> NVL(A.INS_AMT,0) " +
        "ORDER BY A.INS_REG_TYPE, A.DETAIL_INS_REG_TYPE " ;

       
       DataTable dt_Emp_r = ESysLib.TableReadOpen(SQL_R);
       int irow_emp_r,icol_emp_r;
       irow_emp_r = dt_Emp_r.Rows.Count;
       icol_emp_r=dt_Emp_r.Columns.Count;
 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_c70a_hd_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_c70a_hd_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_c70a_hd_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>User</o:Author>
  <o:LastAuthor>HoChang</o:LastAuthor>
  <o:LastPrinted>2013-07-11T01:50:02Z</o:LastPrinted>
  <o:Created>2007-02-07T02:04:19Z</o:Created>
  <o:LastSaved>2013-07-11T01:51:02Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.24in .16in .31in .24in;
	mso-header-margin:.2in;
	mso-footer-margin:.28in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style44
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
.xl89
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl90
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl91
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl92
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl93
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl94
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl95
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:left;
	vertical-align:middle;}
.xl96
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl97
	{mso-style-parent:style44;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl98
	{mso-style-parent:style44;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;
	vertical-align:middle;}
.xl99
	{mso-style-parent:style44;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl100
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl101
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl102
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl103
	{mso-style-parent:style44;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl104
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;}
.xl105
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl106
	{mso-style-parent:style44;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl107
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;}
.xl108
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl109
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl110
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl111
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl112
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl113
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl114
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:normal;}
.xl115
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl116
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl117
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl118
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl119
	{mso-style-parent:style44;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl120
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl121
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl122
	{mso-style-parent:style44;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl123
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl124
	{mso-style-parent:style0;
	color:red;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl125
	{mso-style-parent:style0;
	color:red;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl126
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl127
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl128
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl129
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl130
	{mso-style-parent:style44;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl131
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;}
.xl132
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl133
	{mso-style-parent:style44;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl134
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;}
.xl135
	{mso-style-parent:style44;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:left;
	vertical-align:middle;}
.xl136
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl137
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl138
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl139
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl140
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl141
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl142
	{mso-style-parent:style44;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl143
	{mso-style-parent:style44;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;}
.xl144
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl145
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;}
.xl146
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;}
.xl147
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl148
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;}
.xl149
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl150
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl151
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl152
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl153
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl154
	{mso-style-parent:style0;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl155
	{mso-style-parent:style0;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl156
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl157
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl158
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl159
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl160
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl161
	{mso-style-parent:style44;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
.xl162
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;}
.xl163
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border:.5pt solid windowtext;}
.xl164
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl165
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl166
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl167
	{mso-style-parent:style44;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl168
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl169
	{mso-style-parent:style44;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl170
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border:.5pt solid windowtext;}
.xl171
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl172
	{mso-style-parent:style44;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl173
	{mso-style-parent:style44;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl174
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;}
.xl175
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl176
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;}
.xl177
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl178
	{mso-style-parent:style0;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl179
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl180
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;}
.xl181
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;}
.xl182
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;}
.xl183
	{mso-style-parent:style44;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;}
.xl184
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl185
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl186
	{mso-style-parent:style0;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;}
.xl187
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border:.5pt solid windowtext;}
.xl188
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border:.5pt solid windowtext;}
.xl189
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;}
.xl190
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;}
.xl191
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl192
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl193
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;}
.xl194
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;}
.xl195
	{mso-style-parent:style0;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;
	vertical-align:middle;}
.xl196
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl197
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl198
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl199
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl200
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl201
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl202
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl203
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl204
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl205
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl206
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl207
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl208
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl209
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl210
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>c70a_hd</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>270</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>97</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>9</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>3</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:Sorting>
     <x:Sort>Column C</x:Sort>
    </x:Sorting>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_Fill</x:Name>
  <x:Hidden/>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='c70a_hd'!$D$12:$E$19</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_10</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_100</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_10S</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_120</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_140</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_160</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_20</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_30</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_40</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_40S</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_5S</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_60</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_80</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_80S</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_STD</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_XS</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CS_XXS</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='c70a_hd'!$12:$15</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl91>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1052 style='border-collapse:
 collapse;table-layout:fixed;width:791pt'>
 <col class=xl90 width=32 style='mso-width-source:userset;mso-width-alt:1170;
 width:24pt'>
 <col class=xl90 width=140 style='mso-width-source:userset;mso-width-alt:5120;
 width:105pt'>
 <col class=xl174 width=32 style='mso-width-source:userset;mso-width-alt:1170;
 width:24pt'>
 <col class=xl144 width=84 style='mso-width-source:userset;mso-width-alt:3072;
 width:63pt'>
 <col class=xl90 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl174 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl174 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <col class=xl90 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl90 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl90 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl90 width=61 span=2 style='mso-width-source:userset;mso-width-alt:
 2230;width:46pt'>
 <col class=xl90 width=49 span=2 style='mso-width-source:userset;mso-width-alt:
 1792;width:37pt'>
 <col class=xl90 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl91 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl112 colspan=5 width=353 style='height:14.25pt;
  mso-ignore:colspan;width:265pt'>Tên c&#417; quan (&#273;&#417;n v&#7883;):
  <%= dt_com.Rows[0][0].ToString() %></td>
  <td class=xl159 width=76 style='width:57pt'></td>
  <td class=xl159 width=39 style='width:29pt'></td>
  <td class=xl89 width=68 style='width:51pt'></td>
  <td class=xl92 width=90 style='width:68pt'></td>
  <td class=xl89 width=68 style='width:51pt'></td>
  <td class=xl90 width=61 style='width:46pt'></td>
  <td class=xl90 width=61 style='width:46pt'></td>
  <td class=xl90 width=49 style='width:37pt'></td>
  <td colspan=3 class=xl202 width=187 style='width:141pt'>M&#7851;u s&#7889;: C
  70 a- HD</td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=2 height=19 class=xl112 style='height:14.25pt'>Mã &#273;&#417;n
  v&#7883;: <%= dt_com.Rows[1][0].ToString() %></td>
  <td class=xl182></td>
  <td class=xl146></td>
  <td class=xl94></td>
  <td colspan=2 class=xl159 style='mso-ignore:colspan'></td>
  <td class=xl89></td>
  <td class=xl92></td>
  <td class=xl89></td>
  <td colspan=2 class=xl90 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl203><span
  style='mso-spacerun:yes'>                            </span>(Ban hành theo
  thông t&#432; s&#7889; 178/TT-BTC</td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl92 style='height:14.25pt'></td>
  <td class=xl89></td>
  <td class=xl159></td>
  <td class=xl147></td>
  <td class=xl89></td>
  <td colspan=2 class=xl159 style='mso-ignore:colspan'></td>
  <td class=xl89></td>
  <td class=xl92></td>
  <td colspan=3 class=xl89 style='mso-ignore:colspan'></td>
  <td class=xl91></td>
  <td colspan=3 class=xl111>ngày 23/10/2012 c&#7911;a B&#7897; Tài Chính)</td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl92 style='height:14.25pt'></td>
  <td class=xl91></td>
  <td class=xl160></td>
  <td class=xl144></td>
  <td class=xl91></td>
  <td colspan=2 class=xl160 style='mso-ignore:colspan'></td>
  <td class=xl91></td>
  <td class=xl90></td>
  <td colspan=7 class=xl91 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=15 height=23 class=xl209 style='height:17.25pt'>DANH SÁCH THANH
  TOÁN CH&#7870; &#272;&#7896; &#7888;M &#272;AU, THAI S&#7842;N,
  D&#431;&#7904;NG S&#7912;C PH&#7908;C H&#7890;I S&#7912;C KH&#7886;E</td>
  <td class=xl91></td>
 </tr>
 <%
     string w = "I";
     if (p_mon.Substring(4, 2) == "04" || p_mon.Substring(4, 2) == "05" || p_mon.Substring(4, 2) == "06")
         w = "II";
     if (p_mon.Substring(4, 2) == "07" || p_mon.Substring(4, 2) == "08" || p_mon.Substring(4, 2) == "09")
         w = "III";
     if (p_mon.Substring(4, 2) == "10" || p_mon.Substring(4, 2) == "11" || p_mon.Substring(4, 2) == "12")
         w = "IV";
         
  %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=15 height=23 class=xl210 style='height:17.25pt'>&#272;&#7907;t 1
  tháng <%=p_mon.Substring(4,2) %>. Quý <%=w %> năm <%= p_mon.Substring(0,4) %></td>
  <td class=xl91></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl90 style='height:17.25pt'></td>
  <td class=xl97></td>
  <td class=xl161></td>
  <td class=xl143></td>
  <td class=xl97></td>
  <td colspan=2 class=xl161 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl97 style='mso-ignore:colspan'></td>
  <td class=xl91></td>
 </tr>
 <tr class=xl93 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl98 style='height:17.25pt'></td>
  <td class=xl93></td>
  <td class=xl162></td>
  <td class=xl148 x:str="S&#7889; hi&#7879;u tài kho&#7843;n:             ">S&#7889;
  hi&#7879;u tài kho&#7843;n:<span
  style='mso-spacerun:yes'>             </span></td>
  <td class=xl93></td>
  <td class=xl176 colspan=2 style='mso-ignore:colspan'><%=dt_com.Rows[8][0].ToString() %></td>
  <td class=xl96 colspan=5 style='mso-ignore:colspan'>M&#7903; t&#7841;i: <%=dt_com.Rows[9][0].ToString() %></td>
  <td colspan=4 class=xl98 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl93 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl98 style='height:14.25pt'></td>
  <td class=xl93></td>
  <td class=xl162></td>
  <td class=xl145></td>
  <td class=xl93></td>
  <td class=xl176></td>
  <td class=xl162></td>
  <td class=xl93></td>
  <td class=xl141></td>
  <td class=xl93></td>
  <td colspan=2 class=xl99 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl98 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl93 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl93 style='height:18.75pt'></td>
  <td class=xl135 colspan=5 style='mso-ignore:colspan'>PH&#7846;N 1: DANH SÁCH
  H&#431;&#7902;NG CH&#7870; &#272;&#7896; M&#7898;I PHÁT SINH</td>
  <td class=xl162></td>
  <td class=xl93></td>
  <td class=xl141></td>
  <td class=xl93></td>
  <td colspan=2 class=xl99 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl98 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl93 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl98 style='height:14.25pt'></td>
  <td class=xl93></td>
  <td class=xl162></td>
  <td class=xl145></td>
  <td class=xl93></td>
  <td class=xl176></td>
  <td class=xl162></td>
  <td class=xl93></td>
  <td class=xl141></td>
  <td class=xl93></td>
  <td colspan=2 class=xl99 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl98 style='mso-ignore:colspan'></td>
  <td class=xl95></td>
  <td class=xl93></td>
 </tr>
 <tr class=xl114 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td rowspan=3 height=57 class=xl198 width=32 style='height:42.75pt;
  width:24pt'>STT</td>
  <td rowspan=3 class=xl198 width=140 style='width:105pt'>H&#7885; và tên</td>
  <td rowspan=3 class=xl164 width=32 style='border-bottom:.5pt solid black;
  width:24pt'>Mã s&#7889;</td>
  <td colspan=2 class=xl153 style='border-left:none'>N&#259;m sinh</td>
  <td rowspan=3 class=xl164 width=76 style='width:57pt'>S&#7889; s&#7893; BHXH</td>
  <td rowspan=3 class=xl164 width=39 style='width:29pt'>Th&#7901;i gian
  &#273;óng BHXH</td>
  <td rowspan=3 class=xl198 width=68 style='border-bottom:.5pt solid black;
  width:51pt'>Ti&#7873;n l&#432;&#417;ng tính h&#432;&#7903;ng BHXH</td>
  <td colspan=2 class=xl199 width=158 style='border-left:none;width:119pt'
  x:str="&#272;i&#7873;u ki&#7879;n tính h&#432;&#7903;ng ">&#272;i&#7873;u
  ki&#7879;n tính h&#432;&#7903;ng<span style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl206 width=220 style='border-right:.5pt solid black;
  border-left:none;width:166pt'>S&#7889; ngày th&#7921;c ngh&#7881;</td>
  <td rowspan=3 class=xl198 width=65 style='border-bottom:.5pt solid black;
  width:49pt'>S&#7889; ti&#7873;n tr&#7907; c&#7845;p trong k&#7923;
  (&#273;&#7891;ng)</td>
  <td rowspan=3 class=xl198 width=73 style='border-bottom:.5pt solid black;
  width:55pt'>Ký nh&#7853;n</td>
 </tr>
 <tr class=xl114 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td rowspan=2 height=38 class=xl204 width=84 style='border-bottom:.5pt solid black;
  height:28.5pt;border-top:none;width:63pt'>Nam</td>
  <td rowspan=2 class=xl198 width=65 style='border-bottom:.5pt solid black;
  border-top:none;width:49pt'>N&#7919;</td>
  <td rowspan=2 class=xl115 width=90 style='border-bottom:.5pt solid black;
  width:68pt'>Tình tr&#7841;ng</td>
  <td rowspan=2 class=xl115 width=68 style='border-bottom:.5pt solid black;
  width:51pt'>Th&#7901;i &#273;i&#7875;m</td>
  <td colspan=3 class=xl206 width=171 style='border-right:.5pt solid black;
  border-left:none;width:129pt'>Trong k&#7923;</td>
  <td rowspan=2 class=xl198 width=49 style='border-bottom:.5pt solid black;
  border-top:none;width:37pt'>L&#361;y k&#7871; t&#7915; &#273;&#7847;u
  n&#259;m</td>
 </tr>
 <tr class=xl114 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl115 width=61 style='height:14.25pt;border-left:none;
  width:46pt' x:str="T&#7915; ngày ">T&#7915; ngày<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl115 width=61 style='border-left:none;width:46pt'>&#273;&#7871;n
  ngày</td>
  <td class=xl115 width=49 style='border-left:none;width:37pt'>T&#7893;ng
  s&#7889;</td>
 </tr>
 <tr class=xl111 height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl110 style='height:11.25pt'>A</td>
  <td class=xl110 style='border-left:none'>B</td>
  <td class=xl163 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl110 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl110 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl163 style='border-left:none' x:num>3</td>
  <td class=xl163 style='border-left:none' x:num>4</td>
  <td class=xl110 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl110 style='border-top:none;border-left:none'>C</td>
  <td class=xl110 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl110 style='border-left:none' x:num>7</td>
  <td class=xl110 style='border-left:none' x:num>8</td>
  <td class=xl110 style='border-left:none' x:num>9</td>
  <td class=xl110 style='border-top:none;border-left:none' x:num>10</td>
  <td class=xl110 style='border-top:none;border-left:none' x:num>11</td>
  <td class=xl110 style='border-top:none;border-left:none'>D</td>
 </tr>
 <%
    string[] atype=new string[] {"A","B","C","D","E","F","G","H"};
    string[] btype=new string[] {"I","II","III","IV","V","VI","VII","VIII","IX","X","XI"};
    string cur_type,cur_kind,old_kind, old_type,next_type;
    Boolean bchange=false;
    Boolean gchange=false;
    Boolean btotal=false;
    
    int j=0;
    int k=0;
    int g = 0;
    int count = 1;
    double total=0, gtotal=0;
    for (int i = 0; i < irow_emp; i++)
    {
        cur_type = dt_Emp.Rows[i][0].ToString();
        cur_kind = dt_Emp.Rows[i][1].ToString();

        total += double.Parse(dt_Emp.Rows[i][15].ToString());
        if (i == 0)
        {
            bchange = true;
            gchange = true;
        }
        else
        {
            old_type = dt_Emp.Rows[i - 1][0].ToString();
            old_kind = dt_Emp.Rows[i - 1][1].ToString();
            if (cur_type != old_type)
            {
                bchange = true;
                j++;
            }
            if (cur_kind != old_kind)
            {
                gchange = true;
                count = 1;
            }
        }

        if (bchange == true)
        {
            
  %>
 <tr class=xl125 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl116 style='height:15.0pt;border-top:none'><%=atype[j]%></td>
  <td class=xl117 style='border-top:none;border-left:none'><%=cur_type%></td>
  <td class=xl184 style='border-top:none;border-left:none'><u style='visibility:
  hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl149 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl118 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl168 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl167 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl119 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl119 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl119 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl120 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl120 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl121 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl122 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl123 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl124 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%
        bchange = false;

        }//ket thuc doi group

        if (gchange)
        {
  %>
 <tr class=xl125 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl116 style='height:15.0pt;border-top:none'><%= btype[k]%></td>
  <td class=xl117 style='border-top:none;border-left:none'><%= cur_kind %></td>
  <td class=xl184 style='border-top:none;border-left:none'><u style='visibility:
  hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl149 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl118 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl168 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl167 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl142 style='border-top:none;border-left:none'><u style='visibility:
  hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl119 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl119 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl120 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl120 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl121 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl122 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl142 style='border-top:none;border-left:none' x:num><%= dt_Kind.Rows[k][2].ToString() %></td>
  <td class=xl124 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%
        gchange = false;
        k++;
        }
  %>
 <tr class=xl125 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl126 style='height:15.0pt;border-top:none' x:num><%=count %></td>
  <td class=xl118 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][2].ToString() %></td>
  <td class=xl168 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][3].ToString() %></td>
  <td class=xl140 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][4].ToString() %></td>
  <td class=xl140 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][5].ToString() %></td>
  <td class=xl167 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][6].ToString() %></td>
  <td class=xl168 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][7].ToString() %></td>

  <%
     if(dt_Emp.Rows[i][19].ToString() == "03")
     {
   %>
  <td class=xl119 style='border-top:none;border-left:none' x:str><%=dt_Emp.Rows[i][8].ToString() %></td>
  <% }
     else
     { %>
  <td class=xl119 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][8].ToString() %></td>
  <% } %>

  
  <td class=xl127 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][9].ToString() %></td>
  <td class=xl138 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][10].ToString() %></td>
  <td class=xl140 style='border-top:none;border-left:none' x:str><%=dt_Emp.Rows[i][11].ToString() %></td>
  <td class=xl140 style='border-top:none;border-left:none' x:str><%=dt_Emp.Rows[i][12].ToString() %></td>
  <td class=xl139 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][13].ToString() %></td>
  <td class=xl139 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][14].ToString() %></td>
  <td class=xl119 style='border-top:none;border-left:none'
  x:num><%=dt_Emp.Rows[i][15].ToString() %></td>
  <td class=xl138 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%
     if (i == irow_emp - 1)
         btotal = true;
     else
     {
         next_type = dt_Emp.Rows[i + 1][0].ToString();
         if (cur_type != next_type)
             btotal = true;
     }
     if (btotal == true)
     {   
         %>
 <tr class=xl125 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl126 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl116 style='border-top:none;border-left:none'>C&#7897;ng</td>
  <td class=xl185 style='border-top:none;border-left:none'><u style='visibility:
  hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl140 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl138 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl168 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl167 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl142 style='border-top:none;border-left:none'><u style='visibility:
  hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl119 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl119 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl140 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl140 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl121 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl122 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl142 style='border-top:none;border-left:none' x:num><%= dt_Type.Rows[j][2].ToString() %></td>
  <td class=xl124 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%
      btotal = false;
      //dLuongCu = 0;
      //dLuongMoi = 0;
        }
      
      count++;
    }// ket thuc for
     
  %>

<%
    //danh sach dieu chinh
    double total_r =0;
    if(irow_emp_r >0)
    {
        
 %>
 <tr class=xl125 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl128 style='height:19.5pt'></td>
  <td class=xl154 colspan=8 style='mso-ignore:colspan'>PH&#7846;N 2: DANH SÁCH
  &#272;I&#7872;U CH&#7880;NH S&#7888; &#272;Ã &#272;&#431;&#7906;C THANH TOÁN
  TRONG &#272;&#7906;T XÉT DUY&#7878;T TR&#431;&#7898;C</td>
  <td class=xl130></td>
  <td colspan=2 class=xl131 style='mso-ignore:colspan'></td>
  <td class=xl132></td>
  <td class=xl133></td>
  <td class=xl134></td>
  <td class=xl125></td>
 </tr>
 <tr class=xl125 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td rowspan=3 height=72 class=xl198 width=32 style='height:54.0pt;width:24pt'>STT</td>
  <td rowspan=3 class=xl198 width=140 style='width:105pt'>H&#7885; và tên</td>
  <td rowspan=3 class=xl164 width=32 style='border-bottom:.5pt solid black;
  width:24pt'>Mã s&#7889;</td>
  <td colspan=2 class=xl199 width=149 style='border-left:none;width:112pt'>N&#259;m
  sinh</td>
  <td rowspan=3 class=xl164 width=76 style='width:57pt'>S&#7889; s&#7893; BHXH</td>
  <td rowspan=3 class=xl164 width=39 style='width:29pt'>&#272;&#7907;t xét
  duy&#7879;t</td>
  <td colspan=2 class=xl199 width=158 style='border-left:none;width:119pt'>M&#7913;c
  h&#432;&#7903;ng (&#273;&#7891;ng)</td>
  <td colspan=2 class=xl200 style='border-left:none'>S&#7889; ngày th&#7921;c
  ngh&#7881;</td>
  <td colspan=5 rowspan=3 class=xl199 width=297 style='width:224pt'>N&#7897;i
  dung, lý do &#273;i&#7873;u ch&#7881;nh</td>
 </tr>
 <tr class=xl125 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl115 width=84 style='height:14.25pt;border-left:none;
  width:63pt'>Nam</td>
  <td class=xl115 width=65 style='border-left:none;width:49pt'>N&#7919;</td>
  <td rowspan=2 class=xl115 width=68 style='border-bottom:.5pt solid black;
  width:51pt' x:str="S&#7889; m&#7899;i ">S&#7889; m&#7899;i<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl115 width=90 style='border-bottom:.5pt solid black;
  width:68pt'>S&#7889; chênh l&#7879;ch</td>
  <td rowspan=2 class=xl115 width=68 style='border-bottom:.5pt solid black;
  width:51pt'>S&#7889; chênh l&#7879;ch</td>
  <td rowspan=2 class=xl115 width=61 style='border-bottom:.5pt solid black;
  width:46pt'>L&#361;y k&#7871; t&#7915; &#273;&#7847;u n&#259;m</td>
 </tr>
 <tr class=xl125 height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl115 width=84 style='height:25.5pt;border-left:none;
  width:63pt'>&nbsp;</td>
  <td class=xl115 width=65 style='border-left:none;width:49pt'>&nbsp;</td>
 </tr>
 <tr class=xl125 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl110 style='height:14.25pt'>A</td>
  <td class=xl110 style='border-left:none'>B</td>
  <td class=xl163 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl110 style='border-left:none' x:num>1</td>
  <td class=xl110 style='border-left:none' x:num>2</td>
  <td class=xl163 style='border-left:none' x:num>3</td>
  <td class=xl163 style='border-left:none' x:num>4</td>
  <td class=xl110 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl110 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl110 style='border-top:none;border-left:none' x:num>7</td>
  <td class=xl110 style='border-top:none;border-left:none' x:num>8</td>
  <td colspan=5 class=xl110 style='border-left:none'>C</td>
 </tr>
    <%
        string[] atype_r=new string[] {"A","B","C","D","E","F","G","H"};
        string[] btype_r=new string[] {"I","II","III","IV","V","VI","VII","VIII","IX","X","XI"};
        string cur_type_r,cur_kind_r,old_kind_r, old_type_r,next_type_r;
        Boolean bchange_r=false;
        Boolean gchange_r=false;
        Boolean btotal_r=false;
    
        int j_r=0;
        int k_r=0;
        int count_r = 1;
        double total_type =0;
        
        for (int i_r = 0; i_r < irow_emp_r; i_r++)
        {
            cur_type_r = dt_Emp_r.Rows[i_r][0].ToString();
            cur_kind_r = dt_Emp_r.Rows[i_r][1].ToString();

            total_type += double.Parse(dt_Emp_r.Rows[i_r][9].ToString());
            total_r += double.Parse(dt_Emp_r.Rows[i_r][9].ToString());
            if (i_r == 0)
            {
                bchange_r = true;
                gchange_r = true;
            }
            else
            {
                old_type_r = dt_Emp_r.Rows[i_r - 1][0].ToString();
                old_kind_r = dt_Emp_r.Rows[i_r - 1][1].ToString();
                if (cur_type_r != old_type_r)
                {
                    bchange_r = true;
                    j_r++;
                    
                }
                if (cur_kind_r != old_kind_r)
                {
                    gchange_r = true;
                    count_r = 1;
                }
            }

            if (bchange_r == true)
            {
     %>
 <tr class=xl125 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl156 style='height:14.25pt;border-top:none'><%=atype_r[j]%></td>
  <td class=xl157 style='border-top:none;border-left:none'><%=cur_type_r%></td>
  <td class=xl187 style='border-top:none;border-left:none'><u style='visibility:
  hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl158 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl158 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl170 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl170 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl158 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl158 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl158 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl158 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=5 class=xl110 style='border-left:none'>&nbsp;</td>
 </tr>
 <%
        bchange_r = false;

        }//ket thuc doi group

        if (gchange_r)
        {
  %>
 <tr class=xl125 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl156 style='height:14.25pt;border-top:none'><%= btype_r[k]%></td>
  <td class=xl157 style='border-top:none;border-left:none'><%= cur_kind_r %></td>
  <td class=xl187 style='border-top:none;border-left:none'><u style='visibility:
  hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl158 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl158 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl170 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl170 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl158 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl158 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl158 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl158 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=5 class=xl110 style='border-left:none'>&nbsp;</td>
 </tr>
 <%
        gchange_r = false;
        k_r++;
        }
  %>
 <tr class=xl125 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl110 style='height:14.25pt;border-top:none' x:num><%=count_r %></td>
  <td class=xl118 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i_r][2].ToString() %></td>
  <td class=xl170 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i_r][3].ToString() %></td>
  <td class=xl140 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i_r][4].ToString() %></td>
  <td class=xl140 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i_r][5].ToString() %></td>
  <td class=xl167 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i_r][6].ToString() %></td>
  <td class=xl168 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i_r][7].ToString() %></td>
  <td class=xl119 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i_r][8].ToString() %></td>
  <td class=xl119 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i_r][9].ToString() %></td>
  <td class=xl110 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i_r][10].ToString() %></td>
  <td class=xl110 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i_r][11].ToString() %></td>
  <td colspan=5 class=xl110 style='border-left:none'>&nbsp;</td>
 </tr>
 <%
     if (i_r == irow_emp_r - 1)
         btotal_r = true;
     else
     {
         next_type_r = dt_Emp_r.Rows[i_r + 1][0].ToString();
         if (cur_type_r != next_type_r)
             btotal_r = true;
     }
     if (btotal_r == true)
     {   
         %>
 <tr class=xl125 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl110 style='height:14.25pt;border-top:none'>&nbsp;</td>
  <td class=xl156 style='border-top:none;border-left:none'>C&#7897;ng</td>
  <td class=xl188 style='border-top:none;border-left:none'><u style='visibility:
  hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl158 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl158 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl170 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl170 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl158 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl142 style='border-top:none;border-left:none' x:num><%= total_type %></td>
  <td class=xl158 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl158 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=5 class=xl110 style='border-left:none'>&nbsp;</td>
 </tr>
 <%
      btotal_r = false;
      total_type =0;
        }
      
      count_r++;
    }// ket thuc for
     
  %>

 <% }//end if %>
 <tr class=xl125 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl111 style='height:19.5pt'></td>
  <td class=xl136></td>
  <td class=xl189></td>
  <td class=xl150></td>
  <td class=xl137></td>
  <td colspan=2 class=xl171 style='mso-ignore:colspan'></td>
  <td class=xl137></td>
  <td class=xl111></td>
  <td colspan=3 class=xl137 style='mso-ignore:colspan'></td>
  <td class=xl132></td>
  <td class=xl133></td>
  <td class=xl134></td>
  <td class=xl125></td>
 </tr>
 <tr class=xl125 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl128 style='height:14.25pt'></td>
  <td class=xl94 colspan=4 style='mso-ignore:colspan'>PH&#7846;N 3: T&#7892;NG
  H&#7906;P CHI PHÍ THANH TOÁN</td>
  <td class=xl177></td>
  <td class=xl169></td>
  <td colspan=3 class=xl130 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl131 style='mso-ignore:colspan'></td>
  <td class=xl132></td>
  <td class=xl133></td>
  <td class=xl134></td>
  <td class=xl125></td>
 </tr>
 <tr class=xl100 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl101 style='height:14.25pt'></td>
  <td class=xl109>1/</td>
  <td class=xl191></td>
  <td class=xl145>S&#7889; ti&#7873;n duy&#7879;t m&#7899;i:</td>
  <td class=xl102></td>
  <td class=xl178 x:num><%= total %></td>
  <td class=xl172>&#273;&#7891;ng</td>
  <td class=xl100></td>
  <td colspan=2 class=xl103 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl104 style='mso-ignore:colspan'></td>
  <td class=xl105></td>
  <td class=xl106></td>
  <td class=xl107></td>
  <td class=xl100></td>
 </tr>
 <tr class=xl100 height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl101 style='height:25.5pt'></td>
  <td class=xl109>2/</td>
  <td class=xl191></td>
  <td class=xl145>S&#7889; ti&#7873;n &#273;i&#7873;u ch&#7881;nh:</td>
  <td class=xl102></td>
  <td class=xl178 x:num><%= total_r %></td>
  <td class=xl172>&#273;&#7891;ng</td>
  <td class=xl100></td>
  <td colspan=2 class=xl103 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl104 style='mso-ignore:colspan'></td>
  <td class=xl105></td>
  <td class=xl106></td>
  <td class=xl107></td>
  <td class=xl100></td>
 </tr>
 <% gtotal = total + total_r; %>
 <tr class=xl100 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl101 style='height:14.25pt'></td>
  <td class=xl102></td>
  <td class=xl192></td>
  <td class=xl145>T&#7892;NG C&#7896;NG (1+2):</td>
  <td class=xl102></td>
  <td class=xl178 x:num><%= total + total_r %></td>
  <td class=xl172>&#273;&#7891;ng</td>
  <td class=xl100></td>
  <td colspan=2 class=xl103 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl104 style='mso-ignore:colspan'></td>
  <td class=xl105></td>
  <td class=xl106></td>
  <td class=xl107></td>
  <td class=xl100></td>
 </tr>
 <tr class=xl100 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl101 style='height:14.25pt'></td>
  <td class=xl102></td>
  <td class=xl192></td>
  <td class=xl145 x:str="(Vi&#7871;t b&#7857;ng ch&#7919;: ">(Vi&#7871;t
  b&#7857;ng ch&#7919;:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl102></td>
  <td class=xl180><%= CommondLib.Num2VNText(gtotal.ToString(), "VNĐ")%></td>
  <td class=xl173></td>
  <td colspan=3 class=xl103 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl104 style='mso-ignore:colspan'></td>
  <td class=xl105></td>
  <td class=xl106></td>
  <td class=xl107></td>
  <td class=xl100></td>
 </tr>
 <tr class=xl100 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl101 style='height:14.25pt'></td>
  <td class=xl102></td>
  <td class=xl192></td>
  <td class=xl152></td>
  <td class=xl102></td>
  <td class=xl179></td>
  <td class=xl173></td>
  <td colspan=3 class=xl103 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl104 style='mso-ignore:colspan'></td>
  <td class=xl105></td>
  <td class=xl106></td>
  <td class=xl107></td>
  <td class=xl100></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=2 class=xl90 style='height:14.25pt;mso-ignore:colspan'></td>
  <td class=xl174></td>
  <td class=xl144></td>
  <td class=xl90></td>
  <td colspan=2 class=xl174 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl90 style='mso-ignore:colspan'></td>
  <td class=xl91></td>
  <td class=xl90></td>
  <td colspan=4 class=xl197>Ngày <%= dt_day.Rows[0][0].ToString() %> tháng <%= dt_day.Rows[0][1].ToString() %> n&#259;m <%= dt_day.Rows[0][2].ToString() %></td>
  <td class=xl91></td>
 </tr>
 <tr class=xl89 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=2 height=19 class=xl92 style='height:14.25pt'>Ng&#432;&#7901;i
  l&#7853;p</td>
  <td class=xl193></td>
  <td colspan=2 class=xl92>Công &#273;oàn c&#417; s&#7903;</td>
  <td colspan=2 class=xl159 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl92>K&#7871; toán tr&#432;&#7903;ng</td>
  <td class=xl89></td>
  <td colspan=4 class=xl92>Th&#7911; tr&#432;&#7903;ng &#273;&#417;n v&#7883;</td>
  <td class=xl89></td>
 </tr>
 <tr class=xl108 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=2 height=19 class=xl197 style='height:14.25pt'
  x:str="  (Ký, h&#7885; tên) "><span style='mso-spacerun:yes'>  </span>(Ký,
  h&#7885; tên)<span style='mso-spacerun:yes'> </span></td>
  <td class=xl194></td>
  <td colspan=2 class=xl197 x:str="  (Ký, h&#7885; tên, &#273;óng d&#7845;u) "><span
  style='mso-spacerun:yes'>  </span>(Ký, h&#7885; tên, &#273;óng
  d&#7845;u)<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl175 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl197 x:str="  (Ký, h&#7885; tên) "><span
  style='mso-spacerun:yes'>  </span>(Ký, h&#7885; tên)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl108></td>
  <td colspan=4 class=xl197 x:str="  (Ký, h&#7885; tên, &#273;óng d&#7845;u) "><span
  style='mso-spacerun:yes'>  </span>(Ký, h&#7885; tên, &#273;óng
  d&#7845;u)<span style='mso-spacerun:yes'> </span></td>
  <td class=xl108></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=32 style='width:24pt'></td>
  <td width=140 style='width:105pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=73 style='width:55pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
