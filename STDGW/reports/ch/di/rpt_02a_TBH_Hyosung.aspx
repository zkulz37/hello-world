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
    = "SELECT 1,2 " +
        ",A.FULL_NAME  c2    " +
        ",A.SO_BHXH as c3    " +
        ",DECODE(LENGTH(A.BIRTH_DT),4,A.BIRTH_DT,TO_CHAR(TO_DATE(A.BIRTH_DT,'YYYYMMDD'),'DD/MM/YYYY')) AS C4   " +
        ",DECODE(e.SEX,'F','X','') AS SEX5   " +
        ",A.ADDRESS c6  " +
        ",(SELECT CHAR_3 FROM VHR_HR_CODE V WHERE V.ID='HR0012' AND V.CODE=A.HEALTH_PLACE)  AS TINH7    " +
        ",(SELECT CODE_FNM FROM VHR_HR_CODE V WHERE V.ID='HR0012' AND V.CODE=A.HEALTH_PLACE) AS BENHVIEN8    " +
        //",(SELECT CODE_KNM FROM VHR_HR_CODE V WHERE V.ID='HR0008' AND V.CODE= A.CHUC_DANH) AS CHUCDANH9  " +
        ",(select decode(job.id_job,'01',g.job_01,'02',g.job_02,'03',g.job_03,'04',g.job_04,'05',g.job_05,'')  from thr_job_desc g where g.del_if=0 and G.TCO_ORG_PK=e.tco_org_pk) as c_jobdescription9 " +
        ",nvl(A.LUONG_MOI,0) c10    " +
        ",'' AS C11  " +
        ",'' AS C12  " +
        ",'' AS C13  " +
        ",'' AS C14  " +
        ",to_char(to_date(A.TU_THANG,'YYYYMM'),'MM/YYYY') AS C15  " +
        ",A.EMP_ID AS C16  " +
        ",TO_CHAR(TO_DATE(A.NGAY_KY_HD,'YYYYMMDD'),'DD/MM/YYYY') AS C17  " +
        ",(SELECT CODE_FNM FROM VHR_HR_CODE V WHERE V.ID='HR0001' AND V.CODE= A.LOAI_HD) AS C18   " +
        ",SO_CMT AS C19 " +
        ",F_GET_ORG_LEVEL(e.tco_org_pk,'01','NAME') plant20 " +
        ",F_GET_ORG_LEVEL(e.tco_org_pk,'02','NAME') dept21 " +
        ",F_GET_ORG_LEVEL(e.tco_org_pk,'03','NAME') team22      " +
        "FROM THR_INSURANCE_MANAGE A, thr_employee e,(select code,num_1,CHAr_3 from vhr_hr_code where id='HR0041') ins_type  " +
        ",(select v.code,v.char_5 as id_job from vhr_hr_code v where v.id='HR0008' ) job " +
        "WHERE A.DEL_IF=0 " +
        "and e.DEL_IF=0 and a.EMP_ID = e.emp_id " +
        "and e.pos_type=job.code(+) " +
        "and a.LOAI_BH=ins_type.code AND A.THANG_BC='" + p_rpt_month + "' " +
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
<link rel=File-List href="rpt_02a_TBH_Hyosung_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_02a_TBH_Hyosung_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_02a_TBH_Hyosung_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ms lan</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-09-30T09:41:18Z</o:LastPrinted>
  <o:Created>2011-01-02T09:16:43Z</o:Created>
  <o:LastSaved>2011-09-30T09:50:58Z</o:LastSaved>
  <o:Company>vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .2in .25in .2in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;
	mso-page-orientation:landscape;}
.font21
	{color:black;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
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
.style45
	{mso-number-format:"_\(\0022$\0022* \#\,\#\#0\.00_\)\;_\(\0022$\0022* \\\(\#\,\#\#0\.00\\\)\;_\(\0022$\0022* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:Currency;
	mso-style-id:4;}
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
.xl65
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl66
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl67
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl69
	{mso-style-parent:style0;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl70
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl71
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	background:white;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style0;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	background:white;
	mso-pattern:auto none;}
.xl73
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl74
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl75
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl76
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl78
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl81
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl82
	{mso-style-parent:style0;
	color:windowtext;
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
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl83
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
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;}
.xl84
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
	background:white;
	mso-pattern:auto none;}
.xl85
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl86
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl87
	{mso-style-parent:style43;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl88
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl89
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl90
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;}
.xl91
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl92
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl93
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;}
.xl94
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl95
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl96
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl97
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl98
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl99
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl100
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl101
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl102
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	background:white;
	mso-pattern:auto none;}
.xl103
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl104
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;}
.xl105
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl106
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl107
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl108
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl109
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;}
.xl110
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl111
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl112
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl113
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl114
	{mso-style-parent:style45;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(\0022$\0022* \#\,\#\#0\.00_\)\;_\(\0022$\0022* \\\(\#\,\#\#0\.00\\\)\;_\(\0022$\0022* \0022-\0022??_\)\;_\(\@_\)";
	background:white;
	mso-pattern:auto none;}
.xl115
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl116
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl117
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl118
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
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl119
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl120
	{mso-style-parent:style43;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl121
	{mso-style-parent:style43;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl122
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl123
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl124
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;}
.xl125
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl126
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl127
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl128
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl129
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl130
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl131
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl132
	{mso-style-parent:style0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl133
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl134
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl135
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
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
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl137
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl138
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl139
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl140
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl141
	{mso-style-parent:style0;
	color:windowtext;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl142
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl143
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl144
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl145
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl146
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl147
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl148
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl149
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl150
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl151
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl152
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl153
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl154
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl155
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl156
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;}
.xl157
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl158
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl159
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl160
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl161
	{mso-style-parent:style0;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	background:white;
	mso-pattern:auto none;}
.xl162
	{mso-style-parent:style0;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	background:white;
	mso-pattern:auto none;}
.xl163
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:right;
	background:white;
	mso-pattern:auto none;}
.xl164
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	background:white;
	mso-pattern:auto none;}
.xl165
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	background:white;
	mso-pattern:auto none;}
.xl166
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl167
	{mso-style-parent:style0;
	color:windowtext;
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
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl168
	{mso-style-parent:style0;
	color:windowtext;
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
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl169
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl170
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl171
	{mso-style-parent:style43;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl172
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	background:white;
	mso-pattern:auto none;}
.xl173
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl174
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl175
	{mso-style-parent:style0;
	mso-number-format:"\@";}
.xl176
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl177
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-protection:unlocked visible;}
.xl178
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl179
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl180
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl181
	{mso-style-parent:style0;
	color:windowtext;
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
	background:white;
	mso-pattern:auto none;}
.xl182
	{mso-style-parent:style0;
	color:windowtext;
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
	background:white;
	mso-pattern:auto none;}
.xl183
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl184
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl185
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl186
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl187
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl188
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;}
.xl189
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl190
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl191
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl192
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl193
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	background:white;
	mso-pattern:auto none;}
.xl194
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
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
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>62</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>23</x:ActiveRow>
       <x:ActiveCol>11</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:DataValidation>
     <x:Range>$B$14</x:Range>
     <x:Type>List</x:Type>
     <x:Value>$A$2:$A$3</x:Value>
    </x:DataValidation>
    <x:DataValidation>
     <x:Range>$C$14</x:Range>
     <x:Type>List</x:Type>
     <x:Value>$C$2:$C$14</x:Value>
    </x:DataValidation>
    <x:Sorting>
     <x:Sort>Column F</x:Sort>
    </x:Sorting>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet2</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7425</x:WindowHeight>
  <x:WindowWidth>14955</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>375</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:SupBook>
  <x:Path> </x:Path>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>0</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>1</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>2</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>3</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>4</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>5</x:SheetIndex>
  </x:Xct>
 </x:SupBook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$A$10:$X$23</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$10:$12</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="4097"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1,2,3"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1543 style='border-collapse:
 collapse;table-layout:fixed;width:1158pt'>
 <col width=29 style='mso-width-source:userset;mso-width-alt:1060;width:22pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:3108'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:6217'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:6217'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:2633'>
 <col width=146 style='mso-width-source:userset;mso-width-alt:5339;width:110pt'>
 <col width=87 style='mso-width-source:userset;mso-width-alt:3181;width:65pt'>
 <col class=xl175 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl188 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col width=212 style='mso-width-source:userset;mso-width-alt:7753;width:159pt'>
 <col width=37 style='mso-width-source:userset;mso-width-alt:1353;width:28pt'>
 <col width=143 style='mso-width-source:userset;mso-width-alt:5229;width:107pt'>
 <col width=123 style='mso-width-source:userset;mso-width-alt:4498;width:92pt'>
 <col width=87 style='mso-width-source:userset;mso-width-alt:3181;width:65pt'>
 <col width=12 style='mso-width-source:userset;mso-width-alt:438;width:9pt'>
 <col width=13 style='mso-width-source:userset;mso-width-alt:475;width:10pt'>
 <col width=10 style='mso-width-source:userset;mso-width-alt:365;width:8pt'>
 <col width=8 style='mso-width-source:userset;mso-width-alt:292;width:6pt'>
 <col class=xl175 width=59 style='mso-width-source:userset;mso-width-alt:2157;
 width:44pt'>
 <col width=137 style='mso-width-source:userset;mso-width-alt:5010;width:103pt'>
 <col class=xl175 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col width=47 style='mso-width-source:userset;mso-width-alt:1718;width:35pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=64 span=2 style='width:48pt'>
 <tr height=30 style='height:22.5pt'>
  <td colspan=23 height=30 class=xl141 width=1415 style='height:22.5pt;
  width:1062pt' x:str="DANH SÁCH LAO &#272;&#7896;NG &#272;ÓNG BHXH, BHYT , BHTN ">DANH
  SÁCH LAO &#272;&#7896;NG &#272;ÓNG BHXH, BHYT , BHTN<span
  style='mso-spacerun:yes'> </span></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=5 class=xl65 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td class=xl179>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl68 colspan=2 style='mso-ignore:colspan'>S&#7889;:<span
  style='mso-spacerun:yes'>   </span>tháng <%= dt_Emp.Rows[0][15].ToString().Substring(4,2) %> N&#259;m <%= dt_Emp.Rows[0][15].ToString().Substring(0,4) %></td>
  <td class=xl65>&nbsp;</td>
  <td colspan=5 class=xl69 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl161>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl161>&nbsp;</td>
  <td class=xl70>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 colspan=8 style='height:15.0pt;mso-ignore:colspan'>&#272;&#417;n
  v&#7883; ch&#7911; qu&#7843;n: B&#7843;o hi&#7875;m xã h&#7897;i Huy&#7879;n
  Nh&#417;n Tr&#7841;ch</td>
  <td class=xl179>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=5 class=xl72 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl162>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl162>&nbsp;</td>
  <td class=xl71 x:str="Mã s&#7889;:   02a - TBH ">Mã s&#7889;:<span
  style='mso-spacerun:yes'>   </span>02a - TBH<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl65>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 colspan=7 style='height:15.0pt;mso-ignore:colspan'>Tên
  &#273;&#417;n v&#7883;: CÔNG TY TNHH HYOSUNG VIET NAM</td>
  <td class=xl179>&nbsp;</td>
  <td colspan=5 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl71 x:str="Mã &#273;&#417;n v&#7883;:   ">Mã &#273;&#417;n
  v&#7883;:<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl71>&nbsp;</td>
  <td class=xl163>&nbsp;</td>
  <td align=left valign=top><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:1;margin-left:34px;margin-top:3px;width:224px;height:30px'><img
  width=224 height=30 src="rpt_02a_TBH_Hyosung_files/image001.gif"
  alt="Text Box: YN0098K" v:shapes="Rectangle_x0020_1"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl71 width=137 style='height:15.0pt;width:103pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td class=xl163>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 colspan=7 style='height:15.0pt;mso-ignore:colspan'>&#272;&#7883;a
  ch&#7881; : &#272;&#432;&#7901;ng N2 - KCN Nh&#417;n Tr&#7841;ch</td>
  <td class=xl165>&nbsp;</td>
  <td class=xl179>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=5 class=xl74 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl164>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl164>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 colspan=5 style='height:15.0pt;mso-ignore:colspan'>&#272;i&#7879;n
  tho&#7841;i: (0613)569291~298</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl165 colspan=3 style='mso-ignore:colspan'>Fax: (0613)569299</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=6 class=xl65 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td class=xl179>&nbsp;</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt' x:str="A. ">A.<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl68>PH&#7846;N CHI TI&#7870;T:</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td class=xl179>&nbsp;</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 colspan=7 class=xl65 style='height:9.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td class=xl179>&nbsp;</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td rowspan=3 height=125 class=xl142 width=29 style='border-bottom:.5pt solid black;
  height:93.75pt;width:22pt' x:str="S&#7889;&#10;TT&#10; ">S&#7889;<br>
    TT<br>
    <span style='mso-spacerun:yes'> </span></td>
  <td class=xl76 width=0>&nbsp;</td>
  <td class=xl76 width=0>&nbsp;</td>
  <td class=xl76 width=0>&nbsp;</td>
  <td rowspan=3 class=xl145 style='border-bottom:.5pt solid black'>Mã s&#7889;</td>
  <td rowspan=3 class=xl145 style='border-bottom:.5pt solid black'>H&#7885; và
  tên</td>
  <td rowspan=3 class=xl145 style='border-bottom:.5pt solid black'>S&#7889;
  s&#7893;</td>
  <td rowspan=3 class=xl166 width=77 style='border-bottom:.5pt solid black;
  width:58pt'>Ngày tháng<br>
    n&#259;m sinh</td>
  <td rowspan=3 class=xl180 style='border-bottom:.5pt solid black'>X(X)</td>
  <td rowspan=3 class=xl145 style='border-bottom:.5pt solid black'>&#272;&#7883;a
  ch&#7881;</td>
  <td colspan=2 rowspan=2 class=xl150 width=180 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:135pt'>N&#417;i &#273;&#259;ng ký <br>
    KCB ban &#273;&#7847;u</td>
  <td class=xl76 width=123 style='width:92pt'>&nbsp;</td>
  <td rowspan=3 class=xl148 width=87 style='border-bottom:.5pt solid black;
  width:65pt'>Ti&#7873;n l&#432;&#417;ng<br>
    Ti&#7873;n công</td>
  <td colspan=4 rowspan=2 class=xl150 width=43 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:33pt'>Ph&#7909; C&#7845;p</td>
  <td rowspan=3 class=xl166 width=59 style='border-bottom:.5pt solid black;
  width:44pt'>&#272;óng T&#7915; <br>
    Tháng N&#259;m</td>
  <td colspan=3 rowspan=2 class=xl150 width=260 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:195pt'>Quy&#7871;t &#273;&#7883;nh
  ho&#7863;c <br>
    H&#272;L&#272;, H&#272;LV</td>
  <td class=xl77 style='border-left:none'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl78 width=0 style='height:15.0pt'>&nbsp;</td>
  <td class=xl78 width=0>&nbsp;</td>
  <td class=xl78 width=0>&nbsp;</td>
  <td class=xl78 width=123 style='width:92pt'>Ch&#7913;c v&#7909; ho&#7863;c</td>
  <td rowspan=2 class=xl152 width=72 style='border-bottom:.5pt solid black;
  width:54pt'>Ghi <br>
    chú(Ghi s&#7889; CMT)</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=84 style='height:63.0pt'>
  <td height=84 class=xl79 width=0 style='height:63.0pt'>&nbsp;</td>
  <td class=xl79 width=0>&nbsp;</td>
  <td class=xl79 width=0>&nbsp;</td>
  <td class=xl80 width=37 style='border-top:none;border-left:none;width:28pt'>T&#7881;nh</td>
  <td class=xl80 width=143 style='border-top:none;border-left:none;width:107pt'>B&#7879;nh
  Vi&#7879;n</td>
  <td class=xl81 width=123 style='border-left:none;width:92pt'>ch&#7913;c danh
  ngh&#7873;</td>
  <td class=xl82 width=12 style='border-left:none;width:9pt'>Ch&#7913;c <br>
    v&#7909;</td>
  <td class=xl82 width=13 style='border-left:none;width:10pt'>TNVK</td>
  <td class=xl82 width=10 style='border-left:none;width:8pt'>TN ngh&#7873;</td>
  <td class=xl82 width=8 style='border-left:none;width:6pt'>KV</td>
  <td class=xl81 width=137 style='border-left:none;width:103pt'>S&#7889;</td>
  <td class=xl168 width=76 style='border-left:none;width:57pt'>Ngày, tháng,
  n&#259;m</td>
  <td class=xl81 width=47 style='border-left:none;width:35pt'>Lo&#7841;i</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl83 style='height:15.0pt;border-top:none' x:num>1</td>
  <td class=xl118 style='border-top:none'>&nbsp;</td>
  <td class=xl118 style='border-top:none'>&nbsp;</td>
  <td class=xl118 style='border-top:none'>&nbsp;</td>
  <td class=xl118 style='border-top:none'>&nbsp;</td>
  <td class=xl118 style='border-top:none' x:num>2</td>
  <td class=xl85 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl169 style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl169 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl84 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl84 style='border-top:none;border-left:none' x:num>7</td>
  <td class=xl84 style='border-top:none;border-left:none' x:num>8</td>
  <td class=xl84 style='border-top:none;border-left:none' x:num>9</td>
  <td class=xl84 style='border-top:none;border-left:none' x:num>10</td>
  <td class=xl84 style='border-top:none;border-left:none' x:num="11">#</td>
  <td class=xl84 style='border-top:none;border-left:none' x:num="12">#</td>
  <td class=xl84 style='border-top:none;border-left:none' x:num="13">&nbsp;</td>
  <td class=xl84 style='border-top:none;border-left:none' x:num="14">&nbsp;</td>
  <td class=xl169 style='border-top:none;border-left:none' x:num>15</td>
  <td class=xl84 style='border-top:none;border-left:none' x:num>16</td>
  <td class=xl169 style='border-top:none;border-left:none' x:num>17</td>
  <td class=xl84 style='border-top:none;border-left:none' x:num>18</td>
  <td class=xl86 style='border-top:none;border-left:none' x:num>19</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
  <%
     int count = 0;
     int nt = 0;
     Double sumtiencong = 0;
     for (int i = 0; i < irow_emp; i++)
     {
         sumtiencong += Double.Parse(dt_Emp.Rows[i][10].ToString()); 
         count++;
         if (dt_Emp.Rows[i][7].ToString() == "ĐN")
             nt += 1;
  %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl124 style='height:15.0pt' x:num><%= count %></td>
  <td class=xl128 style='border-left:none'><%=dt_Emp.Rows[i][20].ToString()%></td>
  <td class=xl128 style='border-left:none'><%=dt_Emp.Rows[i][21].ToString()%></td>
  <td class=xl128 style='border-left:none'><%=dt_Emp.Rows[i][22].ToString()%></td>
  <td class=xl128 style='border-left:none'><%=dt_Emp.Rows[i][16].ToString()%></td>
  <td class=xl133 style='border-left:none'><%=dt_Emp.Rows[i][2].ToString()%></td>
  <td class=xl194 style='border-left:none' x:num><%=dt_Emp.Rows[i][3].ToString()%></td>
  <td class=xl189 style='border-left:none'><%=dt_Emp.Rows[i][4].ToString()%></td>
  <td class=xl170 style='border-left:none'><%=dt_Emp.Rows[i][5].ToString()%></td>
  <td class=xl134 style='border-left:none'><%=dt_Emp.Rows[i][6].ToString()%></td>
  <td class=xl122 style='border-left:none'><%=dt_Emp.Rows[i][7].ToString()%></td>
  <td class=xl135 style='border-left:none'><%=dt_Emp.Rows[i][8].ToString()%></td>
  <td class=xl125 style='border-left:none'><%=dt_Emp.Rows[i][9].ToString()%></td>
  <td class=xl87 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>     </span><%=dt_Emp.Rows[i][10].ToString()%> </td>
  <td class=xl122 style='border-left:none'><%=dt_Emp.Rows[i][11].ToString()%></td>
  <td class=xl122 style='border-left:none'><%=dt_Emp.Rows[i][12].ToString()%></td>
  <td class=xl122 style='border-left:none'><%=dt_Emp.Rows[i][13].ToString()%></td>
  <td class=xl122 style='border-left:none'><%=dt_Emp.Rows[i][14].ToString()%></td>
  <td class=xl170 style='border-left:none'><%=dt_Emp.Rows[i][15].ToString()%></td>
  <td class=xl129 style='border-left:none'><%=dt_Emp.Rows[i][16].ToString()%>/ HOSVN - H&#272;L&#272;</td>
  <td class=xl176 style='border-left:none'><%=dt_Emp.Rows[i][17].ToString()%></td>
  <td class=xl126 style='border-left:none' x:str><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][18].ToString()%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl123 style='border-left:none'><%=dt_Emp.Rows[i][19].ToString()%></td>
  <td ></td>
  <td ></td>
 </tr>
  <%
     }
  %>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl130 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td class=xl130 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl130 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl130 style='border-top:none;border-left:none'>&nbsp;</td>
  <td height=21 class=xl130 width=0 style='height:15.75pt;border-top:none;
  border-left:none'>&nbsp;</td>
  <td class=xl130 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl131 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl183 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl183 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl119 style='border-left:none'>&nbsp;</td>
  <td class=xl120 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>        </span><%= sumtiencong %> </td>
  <td class=xl121 style='border-left:none'>&nbsp;</td>
  <td class=xl121 style='border-left:none'>&nbsp;</td>
  <td class=xl121 style='border-left:none'>&nbsp;</td>
  <td class=xl121 style='border-left:none' >&nbsp;</td>
  <td class=xl171 style='border-left:none'>&nbsp;</td>
  <td class=xl129 style='border-top:none;border-left:none' x:str=""
  x:fmla="=W15&amp;X15">&nbsp;</td>
  <td class=xl171 style='border-left:none'>&nbsp;</td>
  <td class=xl121 style='border-left:none'>&nbsp;</td>
  <td class=xl121 style='border-left:none'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl88 style='height:15.75pt'>B.</td>
  <td colspan=3 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl116>T&#7892;NG H&#7906;P CHUNG</td>
  <td height=21 class=xl178 width=77 style='height:15.75pt;width:58pt'></td>
  <td height=21 class=xl184 width=40 style='height:15.75pt;width:30pt'>&nbsp;</td>
  <td height=21 class=xl136 width=212 style='height:15.75pt;border-top:none;
  width:159pt'>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td height=21 class=xl88 width=143 style='height:15.75pt;width:107pt'>&nbsp;</td>
  <td colspan=6 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl139 x:str>&nbsp;</td>
  <td class=xl177 style='border-top:none'>&nbsp;</td>
  <td class=xl137 style='border-top:none'>&nbsp;</td>
  <td class=xl138 style='border-top:none'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl88 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td height=21 class=xl88 width=146 style='height:15.75pt;width:110pt'>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td colspan=2 class=xl172 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td height=21 class=xl88 width=143 style='height:15.75pt;width:107pt'>&nbsp;</td>
  <td height=21 class=xl88 width=123 style='height:15.75pt;width:92pt'>&nbsp;</td>
  <td height=21 class=xl88 width=87 style='height:15.75pt;width:65pt'>&nbsp;</td>
  <td height=21 class=xl88 width=12 style='height:15.75pt;width:9pt'>&nbsp;</td>
  <td colspan=3 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl140>&nbsp;</td>
  <td class=xl178></td>
  <td class=xl88>&nbsp;</td>
  <td class=xl127>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl88 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl90>Phát Sinh T&#259;ng</td>
  <td class=xl91>&nbsp;</td>
  <td class=xl190 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black'>B&#7843;o
  Hi&#7875;m Xã H&#7897;i</td>
  <td class=xl92 style='border-left:none'>B&#7843;o Hi&#7875;m Yt&#7871;</td>
  <td colspan=2 class=xl157 style='border-right:2.0pt double black;border-left:
  none'>B&#7843;o Hi&#7875;m Th&#7845;t Nghi&#7879;p</td>
  <td colspan=6 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl140 x:str="" x:fmla="=W18&amp;X18">&nbsp;</td>
  <td class=xl178></td>
  <td class=xl88>&nbsp;</td>
  <td class=xl127>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=5 class=xl88 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl93 style='border-top:none'>1. Lao &#273;&#7897;ng:</td>
  <td class=xl94 style='border-top:none'>&nbsp;</td>
  <td class=xl96 align=right style='border-top:none;border-left:none' x:num><%= count %></td>
  <td class=xl186 style='border-top:none'>&nbsp;</td>
  <td class=xl95 style='border-top:none;border-left:none' x:num><%= count %></td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl97 style='border-top:none' x:num><%= count %></td>
  <td colspan=6 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl140 x:str>&nbsp;</td>
  <td class=xl178></td>
  <td class=xl88>&nbsp;</td>
  <td class=xl127>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=5 class=xl88 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl93 style='border-top:none'>2. Q&#361;y l&#432;&#417;ng BHXH:</td>
  <td class=xl98 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl159 style='border-right:.5pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'>            
  </span><%= sumtiencong %> </td>
  <td class=xl99 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                                    
  </span><%= sumtiencong %> </td>
  <td class=xl100 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>                   </span><%= sumtiencong %> </td>
  <td colspan=5 class=xl102 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl140 x:str>&nbsp;</td>
  <td class=xl178></td>
  <td class=xl88>&nbsp;</td>
  <td class=xl127>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=5 class=xl88 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl93 style='border-top:none' x:str="3. S&#7889; ti&#7873;n ph&#7843;i &#273;óng ">3.
  S&#7889; ti&#7873;n ph&#7843;i &#273;óng<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl98 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl159 style='border-right:.5pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'>              
  </span><%= sumtiencong*0.22 %> </td>
  <td class=xl103 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                                      
  </span><%= sumtiencong*0.045 %> </td>
  <td class=xl100 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>                      </span><%= sumtiencong*0.02 %> </td>
  <td colspan=5 class=xl102 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl140 x:str="" x:fmla="=W21&amp;X21">&nbsp;</td>
  <td class=xl178></td>
  <td class=xl88>&nbsp;</td>
  <td class=xl127>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=5 class=xl88 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl104 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black'>Trong
  &#273;ó: s&#7889; ti&#7873;n &#273;&#7875; l&#7841;i &#272;V</td>
  <td class=xl191 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl186 style='border-top:none'>&nbsp;</td>
  <td class=xl106 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td colspan=5 class=xl102 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl140 x:str="" x:fmla="=W22&amp;X22">&nbsp;</td>
  <td class=xl178></td>
  <td class=xl88>&nbsp;</td>
  <td class=xl127>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl88 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl109>4.S&#7889; ti&#7873;n &#273;i&#7873;u ch&#7881;nh:</td>
  <td class=xl110>&nbsp;</td>
  <td class=xl192 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl187 style='border-top:none'>&nbsp;</td>
  <td class=xl111 style='border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-left:none'>&nbsp;</td>
  <td class=xl113>&nbsp;</td>
  <td colspan=5 class=xl102 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl140 x:str="" x:fmla="=W23&amp;X23">&nbsp;</td>
  <td class=xl178></td>
  <td class=xl88>&nbsp;</td>
  <td class=xl127>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=6 class=xl88 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl173>&nbsp;</td>
  <td colspan=9 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td colspan=2 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=6 class=xl88 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl173>&nbsp;</td>
  <td colspan=9 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td colspan=2 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=6 class=xl88 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl173>&nbsp;</td>
  <td colspan=9 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td colspan=2 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=4 class=xl88 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl88 x:str="'- Mã s&#7889; &#273;&#432;&#7907;c c&#7845;p:">- Mã
  s&#7889; &#273;&#432;&#7907;c c&#7845;p:</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl172 x:str="s&#7889;. T&#7915;  s&#7889;: ">s&#7889;.
  T&#7915;<span style='mso-spacerun:yes'>  </span>s&#7889;:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl173>&nbsp;</td>
  <td height=20 class=xl89 width=212 style='height:15.0pt;width:159pt'>&#273;&#7871;n s&#7889;</td>
  <td height=20 class=xl88 width=37 style='height:15.0pt;width:28pt'>&nbsp;</td>
  <td colspan=7 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td colspan=2 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=4 class=xl88 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl88 x:str="'- T&#7893;ng s&#7889; t&#7901; khai:">- T&#7893;ng
  s&#7889; t&#7901; khai:</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl172>t&#7901;</td>
  <td class=xl173>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl89>&nbsp;</td>
  <td colspan=7 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td colspan=2 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=4 class=xl88 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl88 colspan=2 style='mso-ignore:colspan'
  x:str>-
  S&#7889; ng&#432;&#7901;i &#273;&#432;&#7907;c c&#7845;p th&#7867; BHYT
  :<span style='mso-spacerun:yes'>  </span><%= count %></td>
  <td class=xl172>&nbsp;</td>
  <td class=xl173>ng&#432;&#7901;i</td>
  <td class=xl88>, trong &#273;ó c&#7845;p ngo&#7841;i t&#7881;nh:<span
  style='mso-spacerun:yes'>       <%= count - nt %>    </span>th&#7867;</td>
  <td class=xl89>&nbsp;</td>
  <td colspan=7 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td colspan=2 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=4 class=xl88 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl88 colspan=3 style='mso-ignore:colspan'
  x:str="'- Th&#7901;i h&#7841;n s&#7917; d&#7909;ng th&#7867; BHYT: T&#7915; ngày 01/08/2011">-
  Th&#7901;i h&#7841;n s&#7917; d&#7909;ng th&#7867; BHYT: T&#7915; ngày
  </td>
  <td class=xl173>&nbsp;</td>
  <td class=xl114 x:str="&#272;&#7871;n ngày: 31/12/2011"><span
  style='mso-spacerun:yes'> </span>&#272;&#7871;n ngày: <span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl89>&nbsp;</td>
  <td colspan=7 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td colspan=2 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=4 class=xl88 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl173>&nbsp;</td>
  <td class=xl89>&nbsp;</td>
  <td colspan=8 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td colspan=2 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=4 class=xl88 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl173>&nbsp;</td>
  <td class=xl89>&nbsp;</td>
  <td colspan=8 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td colspan=2 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=4 class=xl88 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl173>&nbsp;</td>
  <td class=xl89>&nbsp;</td>
  <td colspan=8 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td colspan=2 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=4 class=xl88 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl172>&nbsp;</td>
  <td class=xl173>Ngày<span style='mso-spacerun:yes'>                  
  </span>Tháng<span style='mso-spacerun:yes'>                   </span>N&#259;m</td>
  <td class=xl89>&nbsp;</td>
  <td colspan=4 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl89>&nbsp;</td>
  <td class=xl89>Ngày<span style='mso-spacerun:yes'>        </span>tháng<span
  style='mso-spacerun:yes'>             </span>n&#259;m 200</td>
  <td colspan=2 class=xl89 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl173>&nbsp;</td>
  <td class=xl89>&nbsp;</td>
  <td class=xl173>&nbsp;</td>
  <td class=xl89>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=4 class=xl88 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl115>Cán b&#7897; thu</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl193>&nbsp;</td>
  <td class=xl174>Giám &#273;&#7889;c B&#7843;o Hi&#7875;m Xã H&#7897;i</td>
  <td class=xl89>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl116><span style='mso-spacerun:yes'>                
  </span>Ng&#432;&#7901;i l&#7853;p bi&#7875;u</td>
  <td class=xl89>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl116>Ng&#432;&#7901;i s&#7917; d&#7909;ng lao &#273;&#7897;ng</td>
  <td colspan=3 class=xl116 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl174>&nbsp;</td>
  <td class=xl116>&nbsp;</td>
  <td class=xl174>&nbsp;</td>
  <td colspan=2 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=6 class=xl65 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td class=xl179>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td colspan=8 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=6 class=xl65 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td class=xl179>&nbsp;</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=6 class=xl65 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td class=xl179>&nbsp;</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=6 class=xl65 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td class=xl179>&nbsp;</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=6 class=xl65 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td class=xl179>&nbsp;</td>
  <td class=xl117>&nbsp;</td>
  <td colspan=8 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=6 class=xl65 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td class=xl179>&nbsp;</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=7 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl175></td>
  <td class=xl188></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl156>KIM CHI HUYNG</td>
  <td></td>
  <td class=xl175></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=7 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl175 style='mso-ignore:colspan'></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
  <td class=xl175></td>
  <td></td>
  <td class=xl175></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=29 style='width:22pt'></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=146 style='width:110pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=212 style='width:159pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=143 style='width:107pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=12 style='width:9pt'></td>
  <td width=13 style='width:10pt'></td>
  <td width=10 style='width:8pt'></td>
  <td width=8 style='width:6pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=137 style='width:103pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
