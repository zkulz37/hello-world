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
    
    string p_times,p_rpt_month;
     
    p_times       = Request["l_times"].ToString();
    p_rpt_month  = Request["l_rpt_month"].ToString();
     /*nhung loai duoc the hien tren 02 a */
    string SQL_1 = " select code  from vhr_hr_code where id='HR0041' and num_2 = '2' ";
    DataTable dt_type = ESysLib.TableReadOpen(SQL_1);
    
    
    int row_type;
    row_type = dt_type.Rows.Count;
    string ins_type ="01";
    if (row_type == 0)
    {
        ins_type = "01";
    }
    else
    {
        ins_type = "";
        for (int i = 0; i < row_type; i++)
        {
            ins_type = ins_type + dt_type.Rows[i][0].ToString() +",";
            
        }
        ins_type = ins_type.ToString().Substring(0, ins_type.ToString().Length -1);
    }
    string SQL
     = "SELECT 1,2  " +
         ",A.FULL_NAME  c2   " +
		 ",A.SO_BHXH as c3   " +
         ",DECODE(LENGTH(A.BIRTH_DT),4,A.BIRTH_DT,TO_CHAR(TO_DATE(A.BIRTH_DT,'YYYYMMDD'),'DD/MM/YYYY')) AS C4    " +
         ",DECODE(A.SEX,' ','X','') AS SEXc5   " +
         ",A.ADDRESS c6 " +
         ",(SELECT CHAR_1 FROM VHR_HR_CODE V WHERE V.ID='HR0012' AND V.CODE=A.HEALTH_PLACE)  AS TINH7   " +
         ",(SELECT CODE_FNM FROM VHR_HR_CODE V WHERE V.ID='HR0012' AND V.CODE=A.HEALTH_PLACE) AS BENHVIEN8   " +
         ",(SELECT CODE_KNM FROM VHR_HR_CODE V WHERE V.ID='HR0008' AND V.CODE= A.CHUC_DANH) AS CHUCDANH9 " +
         ",nvl(A.LUONG_MOI,0) c10   " +
         ",'' AS C11 " +
         ",'' AS C12 " +
         ",'' AS C13 " +
         ",'' AS C14 " +
         ",to_char(to_date(A.TU_THANG,'YYYYMM'),'MM/YYYY') AS C15 " +
         ",A.EMP_ID AS C16 " +
         ",TO_CHAR(TO_DATE(A.NGAY_KY_HD,'YYYYMMDD'),'DD/MM/YYYY') AS C17 " +
         ",(SELECT NUM_1 FROM VHR_HR_CODE V WHERE V.ID='HR0001' AND V.CODE= A.LOAI_HD)||' tháng' AS C18  " +
         ",SO_CMT " +
        "FROM THR_INSURANCE_MANAGE A,(select code,num_1,CHAr_3 from vhr_hr_code where id='HR0041') ins_type " +
        "WHERE A.DEL_IF=0 and a.LOAI_BH=ins_type.code AND A.THANG_BC='" + p_rpt_month + "' " +
        "AND A.LOAI_BH in (" + ins_type + ") " +
        "AND A.LAN_BAO='" + p_times + "' " +
        "ORDER BY ins_type.num_1, A.EMP_ID " ;

//Response.Write(SQL);
//Response.End();
    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp=dt_Emp.Columns.Count;
    float f_social_rate,f_health_rate,f_unemp_rate;
    f_social_rate=f_health_rate=f_unemp_rate=0;
     if (irow_emp == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
   
    //getting information of labels 
    SQL
    = "select code_fnm,to_char(sysdate,'dd/mm/yyyy') " + 
        ",'01/'||to_char(to_date('" + p_rpt_month + "','YYYYMM'),'MM/YYYY') " +
        ",case when substr('" + p_rpt_month + "',5,2) <= '03' then  to_char(last_day(to_date(substr('" + p_rpt_month + "',1,4)||'03','YYYYMM')),'DD/MM/YYYY') " +
        "      when substr('" + p_rpt_month + "',5,2) > '03' and substr('" + p_rpt_month + "',5,2)<= '06' then to_char(last_day(to_date(substr('" + p_rpt_month + "',1,4)||'06','YYYYMM')),'DD/MM/YYYY') " +
        "      when substr('" + p_rpt_month + "',5,2) > '06' and substr('" + p_rpt_month + "',5,2)<= '09' then to_char(last_day(to_date(substr('" + p_rpt_month + "',1,4)||'09','YYYYMM')),'DD/MM/YYYY')  " +
        "      when substr('" + p_rpt_month + "',5,2) > '09' then to_char(last_day(to_date(substr('" + p_rpt_month + "',1,4)||'12','YYYYMM')),'DD/MM/YYYY') end " +
        "from vhr_hr_code  " +
        "where id='HR0049'  order by code " ;
    DataTable dt_name = ESysLib.TableReadOpen(SQL);
    int irow_name;
    irow_name = dt_name.Rows.Count;
    if (irow_name <7)
    {
        Response.Write("You have to input enough information of HR0049 code");
        Response.End();
    }
    %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_02a_TBH_VHPC_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_02a_TBH_VHPC_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_02a_TBH_VHPC_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ATCompany</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-03-28T13:26:17Z</o:LastPrinted>
  <o:Created>2007-10-22T08:34:20Z</o:Created>
  <o:LastSaved>2011-03-28T13:34:13Z</o:LastSaved>
  <o:Company>AnTra Computer</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.14in .16in .14in .15in;
	mso-header-margin:.14in;
	mso-footer-margin:.14in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
.font6
	{color:black;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font7
	{color:black;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font11
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font12
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;}
.font13
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font24
	{color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font25
	{color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font26
	{color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font27
	{color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
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
.style59
	{mso-number-format:0%;
	mso-style-name:Percent;
	mso-style-id:5;}
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
.xl66
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl67
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl68
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl69
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl70
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl74
	{mso-style-parent:style43;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl75
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl76
	{mso-style-parent:style43;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl77
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl78
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl79
	{mso-style-parent:style43;
	color:red;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl80
	{mso-style-parent:style43;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl81
	{mso-style-parent:style59;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;}
.xl82
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl83
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl84
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl85
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl86
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl87
	{mso-style-parent:style43;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl88
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl89
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl90
	{mso-style-parent:style43;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl93
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl94
	{mso-style-parent:style43;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl95
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;}
.xl96
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl97
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl98
	{mso-style-parent:style0;
	color:windowtext;
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
.xl99
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl100
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl101
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl102
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl103
	{mso-style-parent:style0;
	color:windowtext;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl104
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl105
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl106
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl107
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl108
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl109
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl110
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl111
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl112
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl113
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl114
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl115
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl116
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;}
.xl117
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl118
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl119
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl120
	{mso-style-parent:style43;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl121
	{mso-style-parent:style0;
	color:windowtext;
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
.xl122
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl123
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl124
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl125
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl126
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl127
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl128
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl129
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl130
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl131
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl132
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl133
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl134
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl135
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl136
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:StandardWidth>2304</x:StandardWidth>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>67</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:LeftColumnVisible>2</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11640</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="9217"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="8"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl66>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1497 style='border-collapse:
 collapse;table-layout:fixed;width:1124pt'>
 <col class=xl66 width=21 style='mso-width-source:userset;mso-width-alt:768;
 width:16pt'>
 <col class=xl66 width=158 style='mso-width-source:userset;mso-width-alt:5778;
 width:119pt'>
 <col class=xl66 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl66 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <col class=xl66 width=29 style='mso-width-source:userset;mso-width-alt:1060;
 width:22pt'>
 <col class=xl66 width=259 style='mso-width-source:userset;mso-width-alt:9472;
 width:194pt'>
 <col class=xl66 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl66 width=120 style='mso-width-source:userset;mso-width-alt:4388;
 width:90pt'>
 <col class=xl66 width=95 style='mso-width-source:userset;mso-width-alt:3474;
 width:71pt'>
 <col class=xl66 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl66 width=34 style='mso-width-source:userset;mso-width-alt:1243;
 width:26pt'>
 <col class=xl66 width=35 style='mso-width-source:userset;mso-width-alt:1280;
 width:26pt'>
 <col class=xl66 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <col class=xl66 width=35 style='mso-width-source:userset;mso-width-alt:1280;
 width:26pt'>
 <col class=xl66 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl66 width=60 style='mso-width-source:userset;mso-width-alt:2194;
 width:45pt'>
 <col class=xl66 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl66 width=57 style='mso-width-source:userset;mso-width-alt:2084;
 width:43pt'>
 <col class=xl66 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl66 width=63 style='width:47pt'>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td colspan=18 height=36 class=xl122 width=1358 style='height:27.0pt;
  width:1020pt'>DANH SÁCH LAO &#272;&#7896;NG THAM GIA BHXH,BHYT, BHTN</td>
  <td class=xl66 width=76 style='width:57pt'></td>
  <td class=xl66 width=63 style='width:47pt'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=18 height=21 class=xl123 style='height:15.75pt'>S&#7889; ... Tháng
  <%=p_rpt_month.Substring(4,2) %> Năm <%=p_rpt_month.Substring(0,4) %></td>
  <td colspan=2 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl66 colspan=6 style='height:15.0pt;mso-ignore:colspan'>Tên
  &#273;&#417;n v&#7883;: <font class="font6"><%=dt_name.Rows[0][0].ToString() %></font></td>
  <td colspan=5 class=xl66 style='mso-ignore:colspan'></td>
  <td colspan=9 rowspan=4 height=75 class=xl66 width=491 style='mso-ignore:
  colspan-rowspan;height:56.25pt;width:368pt'><!--[if gte vml 1]><v:shapetype
   id="_x0000_t202" coordsize="21600,21600" o:spt="202" path="m,l,21600r21600,l21600,xe">
   <v:stroke joinstyle="miter"/>
   <v:path gradientshapeok="t" o:connecttype="rect"/>
  </v:shapetype><v:shape id="Text_x0020_Box_x0020_19" o:spid="_x0000_s8218"
   type="#_x0000_t202" style='position:absolute;margin-left:83.25pt;
   margin-top:3pt;width:234.75pt;height:0;z-index:5;visibility:visible'
   filled="f" stroked="f">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t' inset="2.16pt,2.16pt,2.16pt,0">
    <div style='text-align:center'><font class="font26">M&#7851;u s&#7889;:
    02a-TBH<br>
        </font><font class="font27">(Ban hành kèm theo CV s&#7889;
    1615/BHXH-CSXH ngày 02/6/2009 c&#7911;a BHXH VN)</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s8220" type="#_x0000_t202" style='position:absolute;
   margin-left:22.5pt;margin-top:2.25pt;width:334.5pt;height:51.75pt;z-index:7;
   visibility:visible' filled="f" stroked="f">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t' inset="2.16pt,2.16pt,2.16pt,0">
    <div style='text-align:center'><font class="font26">M&#7851;u s&#7889;:
    02a-TBH<br>
        </font><font class="font27">(Ban hành kèm theo CV s&#7889;
    1615/BHXH-CSXH ngày 02/6/2009 c&#7911;a BHXH VN)</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=30 height=3></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=446 height=69 src="rpt_02a_TBH_VHPC_files/image001.gif"
    v:shapes="_x0000_s8220"></td>
    <td width=15></td>
   </tr>
   <tr>
    <td height=3></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:368.25pt;height:56.25pt'></span><![endif]--></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl66 colspan=2 style='height:15.0pt;mso-ignore:colspan'>Mã
  &#273;&#417;n v&#7883; :<span style='mso-spacerun:yes'>  </span><font
  class="font7"><%=dt_name.Rows[1][0].ToString() %></font></td>
  <td colspan=9 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl66 colspan=6 style='height:15.0pt;mso-ignore:colspan'>&#272;&#7883;a
  ch&#7881;<span style='mso-spacerun:yes'>     </span>: <font class="font6"><%=dt_name.Rows[2][0].ToString() %></font></td>
  <td colspan=5 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=11 class=xl66 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl75 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl74 colspan=2 style='height:15.75pt;mso-ignore:colspan'>A.
  PH&#7846;N CHI TI&#7870;T</td>
  <td colspan=11 class=xl75 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl76 style='mso-ignore:colspan'></td>
  <td class=xl75></td>
 </tr>
 <tr class=xl69 height=42 style='mso-height-source:userset;height:31.5pt'>
  <td rowspan=2 height=109 class=xl124 width=21 style='border-bottom:.5pt solid black;
  height:81.75pt;width:16pt'>S&#7889; <br>
    TT</td>
  <td rowspan=2 class=xl124 width=158 style='border-bottom:.5pt solid black;
  width:119pt'>H&#7885; và tên</td>
  <td rowspan=2 class=xl124 width=77 style='border-bottom:.5pt solid black;
  width:58pt'>Mã s&#7889;</td>
  <td rowspan=2 class=xl124 width=74 style='border-bottom:.5pt solid black;
  width:56pt'>Ngày, tháng, n&#259;m sinh</td>
  <td rowspan=2 class=xl124 width=29 style='border-bottom:.5pt solid black;
  width:22pt'>N&#7919; (X)</td>
  <td rowspan=2 class=xl124 width=259 style='border-bottom:.5pt solid black;
  width:194pt'>&#272;&#7883;a ch&#7881;</td>
  <td colspan=2 class=xl131 style='border-right:.5pt solid black;border-left:
  none'>&#272;&#259;ng ký KCB</td>
  <td rowspan=2 class=xl124 width=95 style='border-bottom:.5pt solid black;
  width:71pt'>Ch&#7913;c v&#7909;, ch&#7913;c danh ngh&#7873;</td>
  <td rowspan=2 class=xl124 width=72 style='border-bottom:.5pt solid black;
  width:54pt'>Ti&#7873;n l&#432;&#417;ng, ti&#7873;n công</td>
  <td colspan=4 class=xl126 width=143 style='border-right:.5pt solid black;
  border-left:none;width:107pt'>Ph&#7909; c&#7845;p</td>
  <td rowspan=2 class=xl124 width=56 style='border-bottom:.5pt solid black;
  width:42pt'>&#272;óng t&#7915; tháng, n&#259;m</td>
  <td colspan=3 class=xl126 width=187 style='border-right:.5pt solid black;
  border-left:none;width:141pt'>Quy&#7871;t &#273;&#7883;nh ho&#7863;c
  H&#272;L&#272;, H&#272;LV<font class="font12">.</font></td>
  <td rowspan=2 class=xl129 width=76 style='border-bottom:.5pt solid black;
  width:57pt'>Ghi chú<br>
    </td>
  <td class=xl69></td>
 </tr>
 <tr class=xl69 height=67 style='mso-height-source:userset;height:50.25pt'>
  <td height=67 class=xl70 width=67 style='height:50.25pt;border-left:none;
  width:50pt'>T&#7881;nh</td>
  <td class=xl70 width=120 style='border-left:none;width:90pt'>B&#7879;nh
  vi&#7879;n</td>
  <td class=xl71 width=34 style='border-top:none;border-left:none;width:26pt'>Ch&#7913;c
  v&#7909;</td>
  <td class=xl71 width=35 style='border-top:none;border-left:none;width:26pt'>Thâm
  niên VK</td>
  <td class=xl71 width=39 style='border-top:none;border-left:none;width:29pt'>Thâm
  niên ngh&#7873;</td>
  <td class=xl71 width=35 style='border-top:none;border-left:none;width:26pt'>Khác</td>
  <td class=xl71 width=60 style='border-top:none;border-left:none;width:45pt'>S&#7889;</td>
  <td class=xl71 width=70 style='border-top:none;border-left:none;width:53pt'>Ngày,
  tháng, n&#259;m</td>
  <td class=xl71 width=57 style='border-top:none;border-left:none;width:43pt'>Lo&#7841;i</td>
  <td class=xl69></td>
 </tr>
 <tr class=xl69 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl72 style='height:15.75pt;border-top:none' x:num>1</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num>7</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num>8</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num>9</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num>10</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num>11</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num>12</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num>13</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num>14</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num>15</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num>16</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num>17</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num>18</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num>19</td>
  <td class=xl69></td>
 </tr>
 <%
     int count = 0;
     Double sumtiencong = 0;
     for (int i = 0; i < irow_emp; i++)
     {
         sumtiencong += Double.Parse(dt_Emp.Rows[i][10].ToString()); 
         count++;
  %>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl105 align=right style='height:30.0pt' x:num><%= count %></td>
  <td class=xl117 style='border-left:none'><%=dt_Emp.Rows[i][2].ToString()%></td>
  <td class=xl134 style='border-left:none' x:str><%=dt_Emp.Rows[i][3].ToString()%></td>
  <td class=xl136 style='border-left:none'><%=dt_Emp.Rows[i][4].ToString()%></td>
  <td class=xl106 style='border-left:none'><%=dt_Emp.Rows[i][5].ToString()%></td>
  <td class=xl117 style='border-left:none'><%=dt_Emp.Rows[i][6].ToString()%></td>
  <td class=xl117 style='border-left:none'><%=dt_Emp.Rows[i][7].ToString()%></td>
  <td class=xl105 style='border-left:none'><%=dt_Emp.Rows[i][8].ToString()%></td>
  <td class=xl117 style='border-left:none'><%=dt_Emp.Rows[i][9].ToString()%></td>
  <td class=xl118 align=right style='border-left:none' x:num><%=dt_Emp.Rows[i][10].ToString()%></td>
  <td class=xl118 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none' x:str><%=dt_Emp.Rows[i][15].ToString()%></td>
  <td class=xl135 style='border-left:none' x:str><%=dt_Emp.Rows[i][16].ToString()%></td>
  <td class=xl135 style='border-left:none' x:str><%=dt_Emp.Rows[i][17].ToString()%></td>
  <td class=xl105 style='border-left:none'><%=dt_Emp.Rows[i][18].ToString()%></td>
  <td class=xl119 style='border-left:none' x:num><%=dt_Emp.Rows[i][19].ToString()%></td>
  <td class=xl66></td>
 </tr>
 <%
     }
  %>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl107 style='height:11.25pt'>&nbsp;</td>
  <td class=xl108 style='border-left:none'>&nbsp;</td>
  <td class=xl109 style='border-left:none'>&nbsp;</td>
  <td class=xl110 style='border-left:none'>&nbsp;</td>
  <td class=xl111 style='border-left:none'>&nbsp;</td>
  <td class=xl108 style='border-left:none'>&nbsp;</td>
  <td class=xl108 style='border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-left:none'>&nbsp;</td>
  <td class=xl108 style='border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-left:none'>&nbsp;</td>
  <td class=xl111 style='border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-left:none'>&nbsp;</td>
  <td class=xl115 style='border-left:none'>&nbsp;</td>
  <td class=xl66></td>
 </tr>
 <tr class=xl73 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl74 style='height:18.0pt'></td>
  <td colspan=2 class=xl78 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl77 style='mso-ignore:colspan'></td>
  <td class=xl79></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl73></td>
 </tr>
 <tr class=xl73 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl74 style='height:21.75pt'></td>
  <td class=xl77></td>
  <td class=xl78></td>
  <td colspan=6 class=xl77 style='mso-ignore:colspan'></td>
  <td class=xl95></td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
  <td class=xl79></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl73></td>
 </tr>
 <tr class=xl73 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl74 colspan=2 style='height:19.5pt;mso-ignore:colspan'>B.
  PH&#7846;N T&#7892;NG H&#7906;P</td>
  <td class=xl78></td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
  <td class=xl95></td>
  <td class=xl77></td>
  <td colspan=3 class=xl95 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
  <td class=xl79></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl73></td>
 </tr>
 <tr class=xl82 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl82 style='height:15.0pt'></td>
  <td class=xl83></td>
  <td colspan=7 class=xl82 style='mso-ignore:colspan'></td>
  <td class=xl116></td>
  <td colspan=10 class=xl82 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl84 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl84 style='height:21.75pt'></td>
  <td class=xl96>S&#7889; phát sinh t&#259;ng</td>
  <td class=xl97>&nbsp;</td>
  <td colspan=2 class=xl98 width=103 style='border-right:.5pt solid black;
  border-left:none;width:78pt'>BHYT</td>
  <td class=xl98 width=259 style='border-left:none;width:194pt'>BHTN</td>
  <td colspan=2 class=xl98 width=187 style='border-right:.5pt solid black;
  width:140pt'>BHXH</td>
  <td class=xl85 colspan=10 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>- Mã s&#7889; &#273;ã c&#7845;p : …………………..
  S&#7889;, t&#7915; s&#7889; ……………….…… &#273;&#7871;n s&#7889; ………….……………….</td>
  <td class=xl84></td>
  <td height=29 class=xl84 width=63 style='height:21.75pt;width:47pt'><!--[if gte vml 1]><v:shape
   id="Text_x0020_Box_x0020_24" o:spid="_x0000_s8216" type="#_x0000_t202"
   style='position:absolute;margin-left:0;margin-top:2.25pt;width:0;height:117.75pt;
   z-index:3;visibility:visible' filled="f" stroked="f">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t' inset="2.16pt,1.8pt,2.16pt,0">
    <div style='text-align:center'><font class="font24">Ngày..... tháng......
    n&#259;m..........</font><font class="font25"><br>
        </font><font class="font25">Ng&#432;&#7901;i s&#7917; d&#7909;ng lao
    &#273;&#7897;ng<br>
        </font><font class="font24">(ký và &#273;óng d&#7845;u)</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]--></td>
 </tr>
 <tr class=xl86 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl86 style='height:21.75pt'></td>
  <td class=xl99 style='border-top:none'>1. S&#7889; lao &#273;&#7897;ng:</td>
  <td class=xl97 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl96 style='border-right:.5pt solid black;border-left:
  none' x:num><%= count %></td>
  <td class=xl97 style='border-top:none' x:num><%= count %></td>
  <td colspan=2 class=xl96 style='border-right:.5pt solid black;border-left:
  none' x:num><%= count %></td>
  <td class=xl87 colspan=5 style='mso-ignore:colspan'
  x:str="'- T&#7893;ng s&#7889; t&#7901; khai: …………………………t&#7901;"><span
  style='mso-spacerun:yes'> </span>- T&#7893;ng s&#7889; t&#7901; khai:
  …………………………t&#7901;<span style='mso-spacerun:yes'> </span></td>
  <td colspan=7 class=xl86 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl75 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl69 style='height:21.75pt'></td>
  <td class=xl100 style='border-top:none'>2. Qu&#7929; l&#432;&#417;ng</td>
  <td class=xl101 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl125 style='border-right:.5pt solid black;border-left:
  none' x:num><%= sumtiencong %></td>
  <td class=xl102 style='border-top:none' x:num><%= sumtiencong %></td>
  <td colspan=2 class=xl125 style='border-right:.5pt solid black;border-left:
  none' x:num><%= sumtiencong %></td>
  <td class=xl88 colspan=10 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span><font class="font11">- S&#7889;
  ng&#432;&#7901;i &#273;&#432;&#7907;c c&#7845;p th&#7867; BHYT : ………….
  ng&#432;&#7901;i, trong &#273;ó c&#7845;p ngo&#7841;i t&#7881;nh …………………
  th&#7867;.</font></td>
  <td class=xl87></td>
  <td class=xl75></td>
 </tr>
 <tr class=xl75 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl89 style='height:21.75pt'></td>
  <td class=xl100 style='border-top:none'>3. S&#7889; ti&#7873;n ph&#7843;i
  &#273;óng</td>
  <td class=xl101 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl125 style='border-right:.5pt solid black;border-left:
  none' x:num><%= sumtiencong*0.045 %></td>
  <td class=xl102 style='border-top:none' x:num><%= sumtiencong*0.02 %></td>
  <td colspan=2 class=xl125 style='border-right:.5pt solid black;border-left:
  none' x:num><%= sumtiencong*0.22 %></td>
  <td class=xl85 colspan=8 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>- Th&#7901;i h&#7841;n s&#7917; d&#7909;ng
  c&#7911;a th&#7867; BHYT: T&#7915; ngày <font class="font13"><%=dt_name.Rows[0][2].ToString() %></font><font
  class="font11"> &#273;&#7871;n ngày </font><font class="font13"><%=dt_name.Rows[0][3].ToString() %></font></td>
  <td colspan=3 class=xl87 style='mso-ignore:colspan'></td>
  <td class=xl75></td>
 </tr>
 <tr class=xl75 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl89 style='height:21.75pt'></td>
  <td class=xl103 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black'>Trong
  &#273;ó<font class="font9">:<span style='mso-spacerun:yes'>  </span>S&#7889;
  ti&#7873;n &#273;&#7875; l&#7841;i &#273;&#417;n v&#7883;</font></td>
  <td colspan=2 class=xl125 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl97 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl125 style='border-right:.5pt solid black;border-left:
  none' x:num><%= sumtiencong*0.02 %></td>
  <td class=xl90 style='border-left:none'>&nbsp;</td>
  <td class=xl85></td>
  <td colspan=3 class=xl75 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl87 style='mso-ignore:colspan'></td>
  <td class=xl75></td>
 </tr>
 <tr class=xl73 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl77 style='height:21.75pt'></td>
  <td class=xl99 style='border-top:none'>4. S&#7889; ti&#7873;n &#273;i&#7873;u
  ch&#7881;nh:</td>
  <td class=xl104 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl96 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl97 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl96 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl91 style='border-left:none'>&nbsp;</td>
  <td colspan=11 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl73 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl77 style='height:20.1pt'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="Text_x0020_Box_x0020_22"
   o:spid="_x0000_s8219" type="#_x0000_t202" style='position:absolute;
   margin-left:0;margin-top:18.75pt;width:107.25pt;height:56.25pt;z-index:6;
   visibility:visible' filled="f" stroked="f">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t' inset="2.16pt,1.8pt,2.16pt,0">
    <div style='text-align:center'><font class="font25"><br>
        </font><font class="font25">Cán b&#7897; thu<br>
        </font><font class="font24">(ký ghi rõ h&#7885; tên</font><font
    class="font25">)</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:6;margin-left:0px;margin-top:25px;width:143px;
  height:75px'><img width=143 height=75
  src="rpt_02a_TBH_VHPC_files/image002.gif"
  alt="Text Box: Cán b&#7897; thu&#10;(ký ghi rõ h&#7885; tên)" v:shapes="Text_x0020_Box_x0020_22"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl77 width=158 style='height:20.1pt;width:119pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl73></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="Text_x0020_Box_x0020_21"
   o:spid="_x0000_s8214" type="#_x0000_t202" style='position:absolute;
   margin-left:44.25pt;margin-top:18pt;width:189.75pt;height:49.5pt;z-index:1;
   visibility:visible' filled="f" stroked="f">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t' inset="2.16pt,1.8pt,2.16pt,0">
    <div style='text-align:center'><font class="font24">Ngày..... tháng......
    n&#259;m..........</font><font class="font25"><br>
        </font><font class="font25">Ph&#7909; trách thu<br>
        </font><font class="font24">(ký và &#273;óng d&#7845;u)</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:59px;margin-top:24px;width:253px;
  height:66px'><img width=253 height=66
  src="rpt_02a_TBH_VHPC_files/image003.gif"
  alt="Text Box: Ngày..... tháng...... n&#259;m..........&#10;Ph&#7909; trách thu&#10;(ký và &#273;óng d&#7845;u)"
  v:shapes="Text_x0020_Box_x0020_21"></span><![endif]><span style='mso-ignore:
  vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl73 width=74 style='height:20.1pt;width:56pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=16 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl93 height=16 style='height:12.0pt'>
  <td height=16 colspan=2 class=xl92 style='height:12.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl93 style='mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="Text_x0020_Box_x0020_23"
   o:spid="_x0000_s8215" type="#_x0000_t202" style='position:absolute;
   margin-left:15.75pt;margin-top:0;width:153pt;height:49.5pt;z-index:2;
   visibility:visible' filled="f" stroked="f">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t' inset="2.16pt,1.8pt,2.16pt,0">
    <div style='text-align:center'><font class="font25"><br>
        </font><font class="font25">Ng&#432;&#7901;i l&#7853;p bi&#7875;u<br>
        </font><font class="font24">(ký ghi rõ h&#7885; tên)</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:21px;margin-top:0px;width:204px;
  height:66px'><img width=204 height=66
  src="rpt_02a_TBH_VHPC_files/image004.gif"
  alt="Text Box: Ng&#432;&#7901;i l&#7853;p bi&#7875;u&#10;(ký ghi rõ h&#7885; tên)"
  v:shapes="Text_x0020_Box_x0020_23"></span><![endif]><span style='mso-ignore:
  vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=16 class=xl93 width=95 style='height:12.0pt;width:71pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=5 class=xl93 style='mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="Text_x0020_Box_x0020_25"
   o:spid="_x0000_s8217" type="#_x0000_t202" style='position:absolute;
   margin-left:0;margin-top:0;width:226.5pt;height:49.5pt;z-index:4;
   visibility:visible' filled="f" stroked="f">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t' inset="2.16pt,1.8pt,2.16pt,0">
    <div style='text-align:center'><font class="font24">Ngày..... tháng......
    n&#259;m..........</font><font class="font25"><br>
        </font><font class="font25">Ng&#432;&#7901;i s&#7917; d&#7909;ng lao
    &#273;&#7897;ng<br>
        </font><font class="font24">(ký và &#273;óng d&#7845;u)</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:4;margin-left:0px;margin-top:0px;width:302px;
  height:66px'><img width=302 height=66
  src="rpt_02a_TBH_VHPC_files/image005.gif"
  alt="Text Box: Ngày..... tháng...... n&#259;m..........&#10;Ng&#432;&#7901;i s&#7917; d&#7909;ng lao &#273;&#7897;ng&#10;(ký và &#273;óng d&#7845;u)"
  v:shapes="Text_x0020_Box_x0020_25"></span><![endif]><span style='mso-ignore:
  vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=16 class=xl94 width=56 style='height:12.0pt;width:42pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=4 class=xl94 style='mso-ignore:colspan'></td>
  <td class=xl93></td>
 </tr>
 <tr class=xl73 height=16 style='height:12.0pt'>
  <td height=16 colspan=2 class=xl77 style='height:12.0pt;mso-ignore:colspan'></td>
  <td colspan=11 class=xl73 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl73></td>
 </tr>
 <tr class=xl75 height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl69 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=11 class=xl75 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl87 style='mso-ignore:colspan'></td>
  <td class=xl75></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=7 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl68></td>
  <td colspan=12 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=7 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl68></td>
  <td colspan=12 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl67 height=20 style='height:15.0pt'>
  <td height=20 colspan=8 class=xl67 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl67 colspan=4 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>                </span>Nguy&#7877;n Th&#7883; Kim
  Oanh</td>
  <td colspan=3 class=xl67 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl133><span style='mso-spacerun:yes'> </span>Bang Yeong
  Sig</td>
  <td colspan=2 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=20 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=7 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl120></td>
  <td colspan=12 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=21 style='width:16pt'></td>
  <td width=158 style='width:119pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=259 style='width:194pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=120 style='width:90pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=34 style='width:26pt'></td>
  <td width=35 style='width:26pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=35 style='width:26pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=63 style='width:47pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
