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
    
    string p_times,p_rpt_month,p_old_year,p_cur_year, p_pk;
     
    p_times       = Request["l_times"].ToString();
    p_rpt_month  = Request["l_rpt_month"].ToString();
	p_pk	= Request["emp_pk"].ToString();
	
    p_cur_year=p_rpt_month.Substring(0,4);
    p_old_year=p_rpt_month.Substring(0,4);
	
    /*nhung loai duoc the hien tren 02 a */
    string SQL_1 = " select code  from vhr_hr_code where id='HR0041' and num_2 = '2' ";
    DataTable dt_type = ESysLib.TableReadOpen(SQL_1);
    int row_type;
    row_type = dt_type.Rows.Count;
    string ins_type = "01";
    if (row_type == 0)
    {
        ins_type = "01";
    }
    else
    {
        ins_type = "";
        for (int i = 0; i < row_type; i++)
        {
            ins_type = ins_type + dt_type.Rows[i][0].ToString() + ",";

        }
        ins_type = ins_type.ToString().Substring(0, ins_type.ToString().Length - 1);
    }
    string SQL
	= "select ins_type.char_3 " + 
        ",a.FULL_NAME as c1 " +
        ",a.SO_BHXH as c2 " +
		",(SELECT CODE_KNM FROM VHR_HR_CODE V WHERE V.ID='HR0008' AND V.CODE= A.CHUC_DANH) AS CHUCDANH3 " +
        ",a.LUONG_BHXH_CU as c4 " +
        ",to_char(to_date(a.THANG_BC,'YYYYMM'),'MM/YYYY') as c5 " +
        ",'' as c6 " +
        ",'' as c7 " +
        ",a.LUONG_CU as c8 " +
        ",a.LUONG_MOI as c9 " +
        ",'' as c10 " +
        ",'' as c11 " +
        ",'' as c12 " +
        ",'' as c13 " +
        ",nvl(a.CL_TANG_XH,0) as c14 " +
        ",nvl(a.CL_GIAM_XH,0) as c15 " +
        ",nvl(a.CL_TANG_YT,0) as c16 " +
        ",nvl(a.CL_GIAM_YT,0) as c17 " +
        ",to_char(to_date(a.TU_THANG,'yyyymm'),'mm/yyyy') as c18 " +
        ",to_char(to_date(a.DEN_THANG,'yyyymm'),'mm/yyyy') as c19 " +
        ",round(a.TY_LE,1) as c20 " +
        ",'HĐ số ' || A.MA_HOP_DONG || '(' ||  TO_CHAR(TO_DATE(A.NGAY_KY_HD,'YYYYMMDD'),'DD/MM/YYYY') || ')' as c21 " +
        ",a.SO_THANG as c22 " +
        ",a.DC_TANG_XH as c23 " +
        ",a.DC_GIAM_XH as c24 " +
        ",a.DC_TANG_YT as c25 " +
        ",a.DC_GIAM_YT as c26 " +
        ",a.ghi_chu as c27 " +
        ",a.EMP_ID as c28 " +
        ",decode(nvl(a.TN_YN,'N'),'Y','X','') as c29 " +
        ",nvl(a.CL_TANG_TN,0) as c30 " +
        ",nvl(a.CL_GIAM_TN,0) as c31 " +
        ",a.DC_TANG_TN as c32 " +
        ",a.DC_GIAM_TN as c33 " +
        ",(SELECT D.NUM_1 FROM THR_CODE_MASTER M,THR_CODE_DETAIL D WHERE M.DEL_IF=0 AND D.DEL_IF=0 AND D.THR_CODE_MASTER_PK=M.PK and id='HR0043' and char_1='" + p_old_year + "') c34 " +
        ",(select num_1 from vhr_hr_code where id='HR0043' and char_1='" + p_cur_year + "' ) c35 " +
        ",(select char_4 from vhr_hr_code where id='HR0043' and char_1='" + p_cur_year + "' ) c36 " +
		",a.LOAI_BH c37 " +
		",case when a.loai_bh='04' or (a.loai_bh='12' and nvl(so_thang,0)>1) then 'X' else ' ' end as c38 " +
		",to_char(to_date(a.TU_THANG,'YYYYMM'),'MM/YYYY') as c39 " +
		",to_char(to_date(a.DEN_THANG,'YYYYMM'),'MM/YYYY') as c40 " +
        "from THR_INSURANCE_MANAGE a, " +
        "(select code,num_1,CHAr_3 from vhr_hr_code where id='HR0041') ins_type " +
        "where a.del_if=0 and a.LOAI_BH=ins_type.code and a.loai_bh  not in(" + ins_type + ")" +
        "and a.THANG_BC='" + p_rpt_month + "' " +
        "and a.LAN_BAO='" + p_times + "' " +
		"and a.thr_emp_pk in (" + p_pk + ")" +
        "order by ins_type.num_1,a.LOAI_BH, a.emp_id  ";

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
	
	// Lay du lieu tong hop cho giam
	string SQL_SUM
    = "select count(a.pk),sum(nvl(a.LUONG_CU,0)) as quyluong " + 
        ", round(sum(nvl(a.LUONG_CU,0))*0.22,0) as bhxh " +
        ", round(sum(nvl(a.LUONG_CU,0))*0.045,0) as bhyt " +
        ", round(sum(nvl(a.LUONG_CU,0))*0.02,0) as bhtn " +
		",nvl(sum(case when nvl(a.SO_THANG,0)=0 then 1 else 0 end),0) as songuoitrathe   " +
		",sum(case when a.LOAI_BH in ('05','12') then nvl(a.LUONG_CU,0)*0.045 else 0 end ) as tangbhyt   " +
        "from THR_INSURANCE_MANAGE a  " +
        "where a.del_if=0 and a.loai_bh in('04','05','12') " +
        "and a.THANG_BC='" + p_rpt_month + "' " +
        "and a.LAN_BAO='" + p_times + "' " +
		"and a.thr_emp_pk in (" + p_pk + ")" ;
		
	DataTable dt_sum = ESysLib.TableReadOpen(SQL_SUM);
	
	// Lay du lieu tong hop cho phan tang
	string SQL_SUM1
    = "select 1 " + 
        ", round(sum(decode(e.nation, '01', nvl(a.LUONG_MOI,0)- nvl(a.LUONG_CU,0),0))*0.22,0) as bhxh   " +
        ", round(sum(nvl(a.LUONG_MOI,0)- nvl(a.LUONG_CU,0))*0.045,0) as bhyt   " +
        ", round(sum(decode(e.nation, '01', nvl(a.LUONG_MOI,0)- nvl(a.LUONG_CU,0),0))*0.02,0) as bhtn  " +
        ", sum(decode(e.nation, '01', nvl(a.LUONG_MOI,0)- nvl(a.LUONG_CU,0),0)) as quyluong_bhxh " +
        ", sum(nvl(a.luong_moi,0) - nvl(a.luong_cu,0)) as quyluong_bhyt " +
        ", sum(decode(e.nation, '01', nvl(a.LUONG_MOI,0)- nvl(a.LUONG_CU,0),0)) as quyluong_bhtn    " +
        "from THR_INSURANCE_MANAGE a, thr_employee e   " +
        "where a.del_if=0 and e.del_if=0 " +
        "and a.thr_emp_pk = e.pk and a.loai_bh in ('08')    " +
        "and a.THANG_BC='" + p_rpt_month + "' " +
        "and a.LAN_BAO='" + p_times + "' " +
		"and a.thr_emp_pk in (" + p_pk + ")" ;
		
	DataTable dt_tang = ESysLib.TableReadOpen(SQL_SUM1);

	// Lay du lieu tong hop so tien dieu chinh cho giam thai san
	string SQL_TS
    =   "select sum(nvl(a.LUONG_BHXH,0)*0.22) as giamthaisan_22 " +
        ",sum(nvl(a.LUONG_BHYT,0)*0.045) as giamthaisan4_5 " +
        ",sum(nvl(a.LUONG_BHTN,0)*0.02) as giamthaisan0_2 " +
        "from thr_insurance_manage m, thr_insurance_month a " +
        "where a.del_if=0 and m.del_if=0 " +
        "and m.THR_EMP_PK = a.THR_EMP_PK " +
        "and a.WORK_MON between m.TU_THANG and m.DEN_THANG " +
        "and m.LOAI_BH ='06' " +
        "and m.THANG_BC='" + p_rpt_month + "' " +
        "and m.LAN_BAO='" + p_times + "' " +
		"and m.thr_emp_pk in (" + p_pk + ")" ;
		
	DataTable dt_Ts = ESysLib.TableReadOpen(SQL_TS);
	
	
    %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_03a_TBH_VHPC_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_03a_TBH_VHPC_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_03a_TBH_VHPC_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>TLT</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-03-29T07:55:13Z</o:LastPrinted>
  <o:Created>2010-02-09T07:56:57Z</o:Created>
  <o:LastSaved>2011-03-29T07:58:20Z</o:LastSaved>
  <o:Company>BHXH</o:Company>
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
.font5
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font6
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font14
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font15
	{color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font16
	{color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font17
	{color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font18
	{color:black;
	font-size:10.0pt;
	font-weight:700;
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
.style53
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
.style74
	{mso-number-format:0%;
	mso-style-name:Percent;
	mso-style-id:5;}
td
	{mso-style-parent:style0;
	padding:0px;
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
.xl79
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl80
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl81
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl82
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl83
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl84
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl85
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl86
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style74;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style74;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl95
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl96
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl97
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style74;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl99
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl100
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl101
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl102
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;}
.xl103
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl104
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl105
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl106
	{mso-style-parent:style74;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;}
.xl107
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;}
.xl108
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl109
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	background:#CC99FF;
	mso-pattern:auto none;}
.xl110
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CC99FF;
	mso-pattern:auto none;}
.xl111
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	background:#CC99FF;
	mso-pattern:auto none;}
.xl112
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl113
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl114
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;}
.xl115
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;
	white-space:normal;}
.xl116
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:top;
	white-space:normal;}
.xl117
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl118
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl119
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	background:#CC99FF;
	mso-pattern:auto none;}
.xl120
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl121
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl122
	{mso-style-parent:style0;
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
	white-space:normal;}
.xl123
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CC99FF;
	mso-pattern:auto none;
	white-space:normal;}
.xl124
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CC99FF;
	mso-pattern:auto none;
	white-space:normal;}
.xl125
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl126
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CC99FF;
	mso-pattern:auto none;}
.xl127
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl128
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl129
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;}
.xl130
	{mso-style-parent:style53;
	color:red;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl131
	{mso-style-parent:style74;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;}
.xl132
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl133
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl134
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	background:#CC99FF;
	mso-pattern:auto none;}
.xl135
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl136
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl137
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl138
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl139
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;}
.xl140
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl141
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl142
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl143
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl144
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CC99FF;
	mso-pattern:auto none;
	white-space:normal;}
.xl145
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl146
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl147
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl148
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl149
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl150
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl151
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl152
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl153
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	background:#CC99FF;
	mso-pattern:auto none;}
.xl154
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl155
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl156
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl157
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl158
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl159
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;}
.xl160
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	background:#CC99FF;
	mso-pattern:auto none;}
.xl161
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl162
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;}
.xl163
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	background:#CC99FF;
	mso-pattern:auto none;}
.xl164
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;}
.xl165
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl166
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl167
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	background:#CC99FF;
	mso-pattern:auto none;}
.xl168
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl169
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";}
.xl170
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl171
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;}
.xl172
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl173
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl174
	{mso-style-parent:style0;
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
	white-space:normal;}
.xl175
	{mso-style-parent:style0;
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
	white-space:normal;}
.xl176
	{mso-style-parent:style0;
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
	white-space:normal;}
.xl177
	{mso-style-parent:style0;
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
	white-space:normal;}
.xl178
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
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
.xl179
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl180
	{mso-style-parent:style0;
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
	white-space:normal;}
.xl181
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl182
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl183
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl184
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl185
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl186
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl187
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl188
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl189
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl190
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl191
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl192
	{mso-style-parent:style0;
	color:black;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl193
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl194
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl195
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl196
	{mso-style-parent:style53;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl197
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl198
	{mso-style-parent:style74;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl199
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl200
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl201
	{mso-style-parent:style74;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl202
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:normal;}
.xl203
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl204
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl205
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl206
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl207
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl208
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl209
	{mso-style-parent:style74;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl210
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl211
	{mso-style-parent:style53;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:right;
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
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>6</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9855</x:WindowHeight>
  <x:WindowWidth>19020</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:SupBook>
  <x:Path>\My Documets\Dung chung\HUONG DAN BH THAT NGHIEP-BHXHVN\HUONG DAN BH THAT NGHIEP\BIEU MAU THU\My Documents\VietHung\Luu_DL\Luu02\SuaQ§Thu\Gui PT.xls</x:Path>
  <x:SheetName>C45_BH</x:SheetName>
  <x:SheetName>C47_BH</x:SheetName>
  <x:SheetName>C48_BH</x:SheetName>
  <x:SheetName>S53_BH</x:SheetName>
  <x:SheetName>C46_BH</x:SheetName>
  <x:SheetName>7_BCT</x:SheetName>
  <x:SheetName>8_BCT</x:SheetName>
  <x:SheetName>2_TBH</x:SheetName>
  <x:SheetName>4_KHT</x:SheetName>
  <x:SheetName>5_KHT</x:SheetName>
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
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>6</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>7</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>8</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>9</x:SheetIndex>
  </x:Xct>
 </x:SupBook>
 <x:SupBook>
  <x:Path>C:\Documents and Settings\user\My Documents\Downloads\03b_TBH.xls</x:Path>
  <x:SheetName>03b-TBH</x:SheetName>
 </x:SupBook>
 <x:ExcelName>
  <x:Name>_Fill</x:Name>
  <x:Hidden/>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>EmployeeName</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>LRCode_No</x:Name>
  <x:Macro>Command</x:Macro>
  <x:FunctionGroup>14</x:FunctionGroup>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>LRDaysTaken</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>LREmployeeName</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>LRFromDate</x:Name>
  <x:Macro>Command</x:Macro>
  <x:FunctionGroup>14</x:FunctionGroup>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>LRMinus_YN</x:Name>
  <x:Macro>Command</x:Macro>
  <x:FunctionGroup>14</x:FunctionGroup>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>LRNoOfDays</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>LRToDate</x:Name>
  <x:Macro>Command</x:Macro>
  <x:FunctionGroup>14</x:FunctionGroup>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="10241"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="9"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl104>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1272 style='border-collapse:
 collapse;table-layout:fixed;width:956pt'>
 <col class=xl103 width=27 style='mso-width-source:userset;mso-width-alt:987;
 width:20pt'>
 <col class=xl104 width=214 style='mso-width-source:userset;mso-width-alt:7826;
 width:161pt'>
 <col class=xl104 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl104 width=97 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <col class=xl104 width=92 style='mso-width-source:userset;mso-width-alt:3364;
 width:69pt'>
 <col class=xl105 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl105 width=43 style='mso-width-source:userset;mso-width-alt:1572;
 width:32pt'>
 <col class=xl105 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl105 width=53 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col class=xl105 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 <col class=xl111 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:3108'>
 <col class=xl105 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl105 width=49 style='mso-width-source:userset;mso-width-alt:1792;
 width:37pt'>
 <col class=xl104 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl104 width=42 style='mso-width-source:userset;mso-width-alt:1536;
 width:32pt'>
 <col class=xl104 width=52 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col class=xl169 width=52 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col class=xl169 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl169 width=59 style='mso-width-source:userset;mso-width-alt:2157;
 width:44pt'>
 <col class=xl168 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <col class=xl104 width=64 style='width:48pt'>
 <tr height=55 style='mso-height-source:userset;height:41.25pt'>
  <td colspan=20 height=55 class=xl192 width=1208 style='height:41.25pt;
  width:908pt'>DANH SÁCH LAO &#272;&#7896;NG &#272;I&#7872;U CH&#7880;NH
  &#272;ÓNG BHXH, BHYT,BHTN</td>
  <td class=xl113 width=64 style='width:48pt'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl104 style='height:21.75pt'></td>
  <td colspan=4 class=xl114 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl173>S&#7889;:<span style='mso-spacerun:yes'> 
  </span><%= p_times%><span style='mso-spacerun:yes'>  </span>Tháng<span
  style='mso-spacerun:yes'>  </span><%=p_rpt_month.Substring(4,2) %><span style='mso-spacerun:yes'> 
  </span>N&#259;m <%=p_rpt_month.Substring(0,4) %></td>
  <td class=xl115></td>
  <td class=xl114></td>
  <td colspan=3 class=xl115 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl116 style='mso-ignore:colspan'></td>
  <td class=xl104></td>
 </tr>
 <tr class=xl81 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl81 style='height:18.75pt'></td>
  <td class=xl82 colspan=4 style='mso-ignore:colspan'>Tên &#273;&#417;n
  v&#7883;: <%=dt_name.Rows[0][0].ToString() %></td>
  <td class=xl83></td>
  <td colspan=4 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl109>&nbsp;</td>
  <td class=xl81></td>
  <td class=xl81 x:str="        "><span
  style='mso-spacerun:yes'>        </span></td>
  <td colspan=8 class=xl81 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl81 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl81 style='height:18.75pt'></td>
  <td class=xl84>Mã &#273;&#417;n v&#7883; : <%=dt_name.Rows[1][0].ToString() %></td>
  <td class=xl84></td>
  <td colspan=3 class=xl83 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl109>&nbsp;</td>
  <td colspan=3 class=xl81 style='mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t202"
   coordsize="21600,21600" o:spt="202" path="m,l,21600r21600,l21600,xe">
   <v:stroke joinstyle="miter"/>
   <v:path gradientshapeok="t" o:connecttype="rect"/>
  </v:shapetype><v:shape id="Text_x0020_Box_x0020_19" o:spid="_x0000_s9237"
   type="#_x0000_t202" style='position:absolute;margin-left:24pt;margin-top:1.5pt;
   width:183.75pt;height:64.5pt;z-index:1;visibility:visible' filled="f"
   stroked="f">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t' inset="2.16pt,2.16pt,2.16pt,0">
    <div style='text-align:center'><font class="font15">M&#7851;u s&#7889;:
    03a-TBH<br>
        </font><font class="font16">(Ban hành kèm theo CV s&#7889;
    1615/BHXH-CSXH ngày 02/6/2009 c&#7911;a BHXH VN)</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:32px;margin-top:2px;width:245px;
  height:86px'><img width=245 height=86
  src="rpt_03a_TBH_VHPC_files/image001.gif"
  alt="Text Box: M&#7851;u s&#7889;: 03a-TBH&#10;(Ban hành kèm theo CV s&#7889; 1615/BHXH-CSXH ngày 02/6/2009 c&#7911;a BHXH VN)"
  v:shapes="Text_x0020_Box_x0020_19"></span><![endif]><span style='mso-ignore:
  vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=25 class=xl81 width=42 style='height:18.75pt;width:32pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl202></td>
  <td colspan=5 class=xl81 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl81 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl81 style='height:18.75pt'></td>
  <td class=xl82 colspan=5 style='mso-ignore:colspan'>&#272;&#7883;a
  ch&#7881;<span style='mso-spacerun:yes'>      </span>: &#272;&#432;&#7901;ng
  N2, KCN Nh&#417;n Tr&#7841;ch V, Huy&#7879;n Nh&#417;n Tr&#7841;ch,
  T&#7881;nh &#272;&#7891;ng Nai.</td>
  <td colspan=4 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl109>&nbsp;</td>
  <td colspan=10 class=xl81 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl81 height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 class=xl81 style='height:8.25pt'></td>
  <td colspan=2 class=xl82 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl83 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl109>&nbsp;</td>
  <td colspan=10 class=xl81 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl79 colspan=2 style='height:22.5pt;mso-ignore:colspan'>A.
  PH&#7846;N CHI TI&#7870;T</td>
  <td colspan=3 class=xl104 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl117 style='mso-ignore:colspan'></td>
  <td class=xl118></td>
  <td class=xl119>&nbsp;</td>
  <td class=xl105></td>
  <td class=xl117></td>
  <td class=xl104></td>
  <td colspan=3 class=xl117 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl120 style='mso-ignore:colspan'></td>
  <td class=xl117></td>
  <td class=xl104></td>
 </tr>
 <tr class=xl103 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td rowspan=4 height=160 class=xl121 width=27 style='height:120.0pt;
  width:20pt'>S&#7889; <br>
    TT</td>
  <td rowspan=4 class=xl174 width=214 style='border-bottom:.5pt solid black;
  width:161pt'>H&#7885; và tên</td>
  <td rowspan=4 class=xl174 width=82 style='border-bottom:.5pt solid black;
  width:62pt'>Mã s&#7889;</td>
  <td rowspan=4 class=xl174 width=97 style='border-bottom:.5pt solid black;
  width:73pt'>Ch&#7913;c v&#7909;,<span style='mso-spacerun:yes'> 
  </span>ch&#7913;c danh ngh&#7873;</td>
  <td colspan=11 class=xl122 width=530 style='border-left:none;width:399pt'>Ti&#7873;n
  l&#432;&#417;ng và ph&#7909; c&#7845;p</td>
  <td colspan=2 rowspan=2 class=xl172 width=104 style='width:78pt'
  x:str="Th&#7901;i gian ">Th&#7901;i gian<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=4 class=xl172 width=56 style='width:42pt'>T&#7927; l&#7879;
  n&#7897;p b&#7893; sung</td>
  <td rowspan=4 class=xl172 width=59 style='width:44pt'>H&#272;L&#272;
  (s&#7889;, ngày tháng n&#259;m)</td>
  <td rowspan=4 class=xl178 width=39 style='border-bottom:.5pt solid black;
  width:29pt'>Ghi chú <br>
    </td>
  <td class=xl103></td>
 </tr>
 <tr class=xl103 height=20 style='height:15.0pt'>
  <td colspan=5 height=20 class=xl122 width=276 style='height:15.0pt;
  border-left:none;width:207pt'>M&#7913;c c&#361;</td>
  <td colspan=6 class=xl122 width=254 style='width:192pt'>M&#7913;c m&#7899;i</td>
  <td class=xl103></td>
 </tr>
 <tr class=xl103 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td rowspan=2 height=121 class=xl121 width=92 style='height:90.75pt;
  border-top:none;width:69pt'>Ti&#7873;n l&#432;&#417;ng, ti&#7873;n công</td>
  <td colspan=4 class=xl122 width=184 style='border-right:.5pt solid black;
  border-left:none;width:138pt'>Ph&#7909; c&#7845;p</td>
  <td rowspan=2 class=xl121 width=85 style='border-top:none;width:64pt'>Ti&#7873;n
  l&#432;&#417;ng, ti&#7873;n công</td>
  <td class=xl123 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl122 width=169 style='border-right:.5pt solid black;
  width:128pt'>Ph&#7909; c&#7845;p</td>
  <td rowspan=2 class=xl121 width=52 style='border-top:none;width:39pt'>T&#7915;
  tháng<br>
    n&#259;m</td>
  <td rowspan=2 class=xl121 width=52 style='border-top:none;width:39pt'>&#272;&#7871;n
  tháng<br>
    n&#259;m</td>
  <td class=xl103></td>
 </tr>
 <tr class=xl103 height=104 style='mso-height-source:userset;height:78.0pt'>
  <td height=104 class=xl121 width=44 style='height:78.0pt;border-top:none;
  border-left:none;width:33pt'>Ch&#7913;c v&#7909;</td>
  <td class=xl121 width=43 style='border-top:none;border-left:none;width:32pt'>Thâm
  niên VK</td>
  <td class=xl121 width=44 style='border-top:none;border-left:none;width:33pt'>Thâm
  niên ngh&#7873;</td>
  <td class=xl121 width=53 style='border-top:none;border-left:none;width:40pt'>Khác</td>
  <td class=xl124 width=0 style='border-top:none;border-left:none' x:str="T&#259;ng"><span
  style='mso-spacerun:yes'> </span>T&#259;ng<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl121 width=40 style='border-top:none;border-left:none;width:30pt'>Ch&#7913;c
  v&#7909;</td>
  <td class=xl121 width=49 style='border-top:none;border-left:none;width:37pt'>Thâm
  niên VK</td>
  <td class=xl121 width=38 style='border-top:none;border-left:none;width:29pt'>Thâm
  niên ngh&#7873;</td>
  <td class=xl121 width=42 style='border-top:none;border-left:none;width:32pt'>Khác</td>
  <td class=xl103></td>
 </tr>
 <tr class=xl103 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl125 style='height:19.5pt;border-top:none' x:str="'1">1</td>
  <td class=xl125 style='border-top:none;border-left:none' x:str="'2">2</td>
  <td class=xl125 style='border-top:none;border-left:none' x:str="'3">3</td>
  <td class=xl125 style='border-top:none;border-left:none' x:str="'4">4</td>
  <td class=xl125 style='border-top:none;border-left:none' x:str="'5">5</td>
  <td class=xl125 style='border-top:none;border-left:none' x:str="'6">6</td>
  <td class=xl125 style='border-top:none;border-left:none' x:str="'7">7</td>
  <td class=xl125 style='border-top:none;border-left:none' x:str="'8">8</td>
  <td class=xl125 style='border-top:none;border-left:none' x:str="'9">9</td>
  <td class=xl125 style='border-top:none;border-left:none' x:str="'10">10</td>
  <td class=xl126 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl125 style='border-top:none;border-left:none' x:str="'11">11</td>
  <td class=xl125 style='border-top:none;border-left:none' x:str="'12">12</td>
  <td class=xl125 style='border-top:none;border-left:none' x:str="'13">13</td>
  <td class=xl125 style='border-top:none;border-left:none' x:str="'14">14</td>
  <td class=xl125 style='border-top:none;border-left:none' x:str="'15">15</td>
  <td class=xl125 style='border-top:none;border-left:none' x:str="'16">16</td>
  <td class=xl125 style='border-top:none;border-left:none' x:str="'17">17</td>
  <td class=xl125 style='border-top:none;border-left:none' x:num>18</td>
  <td class=xl125 style='border-top:none;border-left:none' x:str="'19">19</td>
  <td class=xl103></td>
 </tr>
  <%
     int count = 1;
	 int k=0;
	 Boolean f_kind= true;
     Double sumtiencong = 0;
	
	 string kind_new, kind_old;
	 string[] lama = new string[10]{"I.","II.","III.","IV.","V.","VI.","VII.","VIII.","IX.","X"} ;
     for (int i = 0; i < irow_emp; i++)
     {
         //sumtiencong += Double.Parse(dt_Emp.Rows[i][10].ToString()); 
		 kind_old = dt_Emp.Rows[i][0].ToString();
		 if(f_kind)
		 {
  %>
 <tr class=xl127 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td conspan="2" height=26 class=xl193 style='height:19.5pt'><span
  style='mso-spacerun:yes'>                                    </span><%= lama[k] %>
  <%= dt_Emp.Rows[i][0].ToString() %></td>
  <td class=xl195 style='border-left:none'>&nbsp;</td>
  <td class=xl195 style='border-left:none'>&nbsp;</td>
  <td class=xl195 style='border-left:none'>&nbsp;</td>
  <td class=xl196 style='border-left:none'>&nbsp;</td>
  <td class=xl197 style='border-left:none'>&nbsp;</td>
  <td class=xl198 style='border-left:none'>&nbsp;</td>
  <td class=xl198 style='border-left:none'>&nbsp;</td>
  <td class=xl197 style='border-left:none'>&nbsp;</td>
  <td class=xl197 style='border-left:none'>&nbsp;</td>
  <td class=xl199 style='border-left:none'>&nbsp;</td>
  <td class=xl197 style='border-left:none'>&nbsp;</td>
  <td class=xl198 style='border-left:none'>&nbsp;</td>
  <td class=xl198 style='border-left:none'>&nbsp;</td>
  <td class=xl197 style='border-left:none'>&nbsp;</td>
  <td class=xl200 style='border-left:none'>&nbsp;</td>
  <td class=xl200 style='border-left:none'>&nbsp;</td>
  <td class=xl201 style='border-left:none'>&nbsp;</td>
  <td class=xl201 style='border-left:none'>&nbsp;</td>
  <td class=xl195 style='border-left:none'>&nbsp;</td>
  <td class=xl127></td>
 </tr>
  <%
		f_kind = false;
		k= k+1;
     }
	 
  %>
 <tr class=xl128 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl99 style='height:27.0pt' x:num><%= count %></td>
  <td class=xl203 style='border-left:none'><%=dt_Emp.Rows[i][1].ToString()%></td>
  <td class=xl204 style='border-left:none' x:num><%=dt_Emp.Rows[i][2].ToString()%></td>
  <td class=xl205 style='border-left:none'><%=dt_Emp.Rows[i][3].ToString()%></td>
  
  <td class=xl206 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][8].ToString()%> </td>
  
  <td class=xl207 style='border-left:none'>&nbsp;</td>
  <td class=xl207 style='border-left:none'>&nbsp;</td>
  <td class=xl207 style='border-left:none'>&nbsp;</td>
  <td class=xl207 style='border-left:none'>&nbsp;</td>
  <%
	if(dt_Emp.Rows[i][37].ToString()== "08" || dt_Emp.Rows[i][37].ToString()== "09") // tang, giam luong
	{
  %>
  <td class=xl207 style='border-left:none' x:num><%=dt_Emp.Rows[i][9].ToString()%></td>
  <%
	}
	else
	{
  %>
  <td class=xl207 style='border-left:none'>&nbsp;</td>
  <%
	}
  %>
  <td class=xl207 style='border-left:none'>&nbsp;</td>
  <td class=xl207 style='border-left:none'>&nbsp;</td>
  <td class=xl207 style='border-left:none'>&nbsp;</td>
  <td class=xl207 style='border-left:none'>&nbsp;</td>
  <td class=xl207 style='border-left:none'>&nbsp;</td>
  <td class=xl208 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][39].ToString()%></td>
  <td class=xl208 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][40].ToString()%></td>
  <%
	// giam lao dong ko tra the, giam thai san, giam lao dong tra the ko kip thoi
	if(dt_Emp.Rows[i][37].ToString() == "05" || dt_Emp.Rows[i][37].ToString()=="06" || dt_Emp.Rows[i][37].ToString()=="12")
	{
  %>
  <td class=xl209 style='border-top:none;border-left:none' x:str>28.5%</td>
  <%
	}
	else
	{
  %>
  <td class=xl209 style='border-top:none;border-left:none' x:str>&nbsp;</td>
  <%
	}
  %>
  <td class=xl210 style='border-left:none' x:str><%=dt_Emp.Rows[i][28].ToString()%></td>
  <td class=xl170 style='border-left:none'><%=dt_Emp.Rows[i][38].ToString()%></td>
  <td class=xl128></td>
 </tr>
 <%
	if(dt_Emp.Rows[i][37].ToString()=="05" || dt_Emp.Rows[i][37].ToString()=="12" ) // giam lao dong ko tra the và ko kip thoi
	{
 %>
 <tr class=xl128 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl86 style='height:27.0pt;border-top:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl87 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-left:none'>&nbsp;</td>
  <td class=xl208 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][18].ToString()%></td>
  <td class=xl208 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][19].ToString()%></td>
  <td class=xl209 style='border-top:none;border-left:none' >4.5%</td>
  <td class=xl211 style='border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-left:none'>&nbsp;</td>
  <td class=xl128></td>
 </tr>
 <%
		}
		if (i < irow_emp - 1)
		{
			count = count + 1;
			kind_new = dt_Emp.Rows[i + 1][0].ToString();
			if (kind_new != kind_old)
			{
				f_kind = true;
				count = 1;
			}
		}
		else
		{
			f_kind = true;
			count =1;
		}
			
	}
 %>
 <tr class=xl128 height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 class=xl88 style='height:10.5pt;border-top:none'>&nbsp;</td>
  <td class=xl92 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl95 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl92 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl91 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl91 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl110 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl91 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl91 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl97 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl100 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl94 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl128></td>
 </tr>
 <tr class=xl104 height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 class=xl103 style='height:10.5pt'></td>
  <td colspan=3 class=xl108 style='mso-ignore:colspan'></td>
  <td class=xl129></td>
  <td class=xl130></td>
  <td class=xl105></td>
  <td colspan=2 class=xl106 style='mso-ignore:colspan'></td>
  <td class=xl105></td>
  <td class=xl111>&nbsp;</td>
  <td colspan=2 class=xl105 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl106 style='mso-ignore:colspan'></td>
  <td class=xl105></td>
  <td colspan=3 class=xl107 style='mso-ignore:colspan'></td>
  <td class=xl131></td>
  <td class=xl104></td>
 </tr>
 <tr class=xl136 height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl80 colspan=2 style='height:25.5pt;mso-ignore:colspan'>B.
  PH&#7846;N T&#7892;NG H&#7906;P</td>
  <td colspan=2 class=xl112 style='mso-ignore:colspan'></td>
  <td class=xl132></td>
  <td colspan=4 class=xl101 style='mso-ignore:colspan'></td>
  <td class=xl133></td>
  <td class=xl134>&nbsp;</td>
  <td class=xl135></td>
  <td class=xl104></td>
  <td colspan=8 class=xl136 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl127 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl127 style='height:19.5pt'></td>
  <td colspan=2 rowspan=2 class=xl181 width=296 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:223pt'>Phát sinh</td>
  <td colspan=2 class=xl122 width=189 style='border-right:.5pt solid black;
  border-left:none;width:142pt'>BHXH</td>
  <td colspan=4 class=xl122 width=184 style='border-left:none;width:138pt'>BHYT</td>
  <td colspan=4 class=xl121 width=174 style='width:131pt'>BHTN</td>
  <td class=xl137></td>
  <td class=xl127></td>
  <td class=xl85 colspan=3 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>- T&#7893;ng s&#7889; th&#7867; &#273;ã thu
  h&#7891;i:</td>
  <td class=xl138></td>
  <td class=xl138 x:num><%= dt_sum.Rows[0][5].ToString()%></td>
  <td class=xl127></td>
 </tr>
 <tr class=xl127 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl127 style='height:19.5pt'></td>
  <td class=xl122 width=97 style='border-top:none;border-left:none;width:73pt'>T&#259;ng</td>
  <td class=xl121 width=92 style='border-top:none;width:69pt'>Gi&#7843;m</td>
  <td colspan=2 class=xl122 width=87 style='border-right:.5pt solid black;
  border-left:none;width:65pt'>T&#259;ng</td>
  <td colspan=2 class=xl122 width=97 style='border-right:.5pt solid black;
  border-left:none;width:73pt'>Gi&#7843;m</td>
  <td class=xl121 width=85 style='border-top:none;border-left:none;width:64pt'>T&#259;ng</td>
  <td class=xl124 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl121 width=89 style='border-left:none;width:67pt'>Gi&#7843;m</td>
  <td class=xl137></td>
  <td class=xl139></td>
  <td class=xl85 colspan=4 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>- T&#7893;ng s&#7889; th&#7867; ch&#432;a
  thu h&#7891;i:</td>
  <td class=xl138 x:num><%= int.Parse(dt_sum.Rows[0][0].ToString()) - int.Parse(dt_sum.Rows[0][5].ToString()) %></td>
  <td class=xl127></td>
 </tr>
 <tr class=xl127 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl127 style='height:19.5pt'></td>
  <td class=xl140 style='border-top:none'>1. S&#7889; lao &#273;&#7897;ng</td>
  <td class=xl141 style='border-top:none'>&nbsp;</td>
  <td class=xl142 style='border-top:none'>&nbsp;</td>
  <td class=xl125 style='border-top:none' x:num><%= dt_sum.Rows[0][0].ToString()%></td>
  <td colspan=2 class=xl122 width=87 style='border-right:.5pt solid black;
  border-left:none;width:65pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=97 style='border-right:.5pt solid black;
  border-left:none;width:73pt' x:num ><%= dt_sum.Rows[0][0].ToString()%></td>
  <td class=xl121 width=85 style='border-top:none;border-left:none;width:64pt'>&nbsp;</td>
  <td class=xl124 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl121 width=89 style='border-left:none;width:67pt' x:num><%= dt_sum.Rows[0][0].ToString()%></td>
  <td class=xl137></td>
  <td colspan=7 class=xl127 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl127 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl127 style='height:19.5pt'></td>
  <td class=xl140 style='border-top:none'>2. Qu&#7929; l&#432;&#417;ng</td>
  <td class=xl141 style='border-top:none'>&nbsp;</td>
  <td class=xl145 style='border-top:none' x:num><%= dt_tang.Rows[0][4].ToString()%></td>
  <td class=xl146 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>  </span><%= dt_sum.Rows[0][1].ToString()%> </td>
  <td colspan=2 class=xl186 width=87 style='border-right:.5pt solid black;
  border-left:none;width:65pt' x:num><%= dt_tang.Rows[0][5].ToString()%></td>
  <td colspan=2 class=xl186 width=97 style='border-right:.5pt solid black;
  border-left:none;width:73pt' x:num><span
  style='mso-spacerun:yes'>    </span><%= dt_sum.Rows[0][1].ToString()%> </td>
  <td class=xl147 width=85 style='border-top:none;border-left:none;width:64pt' x:num><%= dt_tang.Rows[0][6].ToString()%></td>
  <td class=xl144 width=0 style='border-top:none;border-left:none' >&nbsp;</td>
  <td colspan=2 class=xl147 width=89 style='border-left:none;width:67pt'
  x:num><span style='mso-spacerun:yes'>  </span><%= dt_sum.Rows[0][1].ToString()%> </td>
  <td class=xl137></td>
  <td colspan=7 class=xl127 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl127 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl127 style='height:19.5pt'></td>
  <td class=xl148 style='border-top:none'>3. S&#7889; ti&#7873;n ph&#7843;i
  &#273;óng</td>
  <td class=xl141 style='border-top:none'>&nbsp;</td>
  <td class=xl145 style='border-top:none' x:num><%= dt_tang.Rows[0][1].ToString()%></td>
  <td class=xl146 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>    </span><%= dt_sum.Rows[0][2].ToString()%> </td>
  <td colspan=2 class=xl186 width=87 style='border-right:.5pt solid black;
  border-left:none;width:65pt' x:num><%= dt_tang.Rows[0][2].ToString()%></td>
  <td colspan=2 class=xl190 style='border-right:.5pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'>      </span><%= dt_sum.Rows[0][3].ToString()%> </td>
  <td class=xl147 width=85 style='border-top:none;border-left:none;width:64pt' x:num><%= dt_tang.Rows[0][3].ToString()%></td>
  <td class=xl144 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl147 width=89 style='border-left:none;width:67pt'
  x:num><span style='mso-spacerun:yes'>       </span><%= dt_sum.Rows[0][4].ToString()%> </td>
  <td class=xl137></td>
  <td colspan=7 class=xl127 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl127 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl127 style='height:19.5pt'></td>
  <td class=xl149 style='border-top:none'>Trong &#273;ó:<font class="font5">
  S&#7889; ti&#7873;n &#273;&#7875; l&#7841;i &#273;&#417;n v&#7883;</font></td>
  <td class=xl141 style='border-top:none'>&nbsp;</td>
  <td class=xl145 style='border-top:none' x:num><%= dt_tang.Rows[0][3].ToString()%></td>
  <td class=xl150 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>       </span><%= dt_sum.Rows[0][4].ToString()%> </td>
  <td colspan=2 class=xl188 width=87 style='border-right:.5pt solid black;
  border-left:none;width:65pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=97 style='border-right:.5pt solid black;
  border-left:none;width:73pt'>&nbsp;</td>
  <td class=xl143 width=85 style='border-top:none;border-left:none;width:64pt'>&nbsp;</td>
  <td class=xl144 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl121 width=89 style='border-left:none;width:67pt'>&nbsp;</td>
  <td class=xl137></td>
  <td colspan=7 class=xl127 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl127 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl127 style='height:19.5pt'></td>
  <td class=xl151 style='border-top:none'>4. S&#7889; ti&#7873;n
  &#273;i&#7873;u ch&#7881;nh</td>
  <td class=xl141 style='border-top:none'>&nbsp;</td>
  <td class=xl142 style='border-top:none' x:num>&nbsp;</td>
  <td class=xl150 style='border-top:none' x:num><%= dt_Ts.Rows[0][0].ToString()%></td>
  <td colspan=2 class=xl188 width=87 style='border-right:.5pt solid black;
  border-left:none;width:65pt' x:num><span
  style='mso-spacerun:yes'>   </span><%= dt_sum.Rows[0][6].ToString()%> </td>
  <td colspan=2 class=xl150 style='border-top:none' x:num><%= dt_Ts.Rows[0][1].ToString()%></td>
  <td class=xl147 width=85 style='border-top:none;border-left:none;width:64pt'>&nbsp;</td>
  <td class=xl144 width=0 style='border-top:none;border-left:none' x:num>&nbsp;</td>
  <td colspan=2 class=xl150 style='border-top:none' x:num><%= dt_Ts.Rows[0][2].ToString()%></td>
  <td class=xl137></td>
  <td colspan=7 class=xl127 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl127 height=20 style='height:15.0pt'>
  <td height=20 colspan=9 class=xl127 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl152></td>
  <td class=xl153>&nbsp;</td>
  <td class=xl154></td>
  <td class=xl155></td>
  <td colspan=3 class=xl156 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl155 style='mso-ignore:colspan'></td>
  <td class=xl157></td>
  <td class=xl127></td>
 </tr>
 <tr class=xl158 height=20 style='height:15.0pt'>
  <td height=20 class=xl158 style='height:15.0pt'></td>
  
  <td colspan=3 class=xl158 style='mso-ignore:colspan'></td>
  <td class=xl158 x:str="Ngày..... tháng...... n&#259;m..........   ">Ngày.....
  tháng...... n&#259;m..........<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl158></td>
  <td colspan=2 class=xl159 style='mso-ignore:colspan'></td>
  <td class=xl158></td>
  <td class=xl159></td>
  <td class=xl160>&nbsp;</td>
  <td colspan=2 class=xl159 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl158 style='mso-ignore:colspan'></td>
  <td class=xl159 x:str="Ngày ...... tháng.......n&#259;m ..........."><span
  style='mso-spacerun:yes'> </span>Ngày ...... tháng.......n&#259;m
  ...........<span style='mso-spacerun:yes'> </span></td>
  <td class=xl159></td>
  <td colspan=2 class=xl158 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl161 height=19 style='height:14.25pt'>
  <td height=19 class=xl161 style='height:14.25pt'></td>
  <td class=xl161>Cán b&#7897; thu</td>
  <td height=19 colspan=2 class=xl161 style='height:14.25pt;mso-ignore:colspan'></td>
  <td class=xl161>Ph&#7909; trách thu</td>
  <td class=xl161></td>
  <td colspan=2 class=xl162 style='mso-ignore:colspan'></td>
  <td class=xl161></td>
  <td class=xl162></td>
  <td class=xl163>&nbsp;</td>
  <td class=xl162 x:str="Ng&#432;&#7901;i l&#7853;p bi&#7875;u"><span
  style='mso-spacerun:yes'> </span>Ng&#432;&#7901;i l&#7853;p bi&#7875;u<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl164></td>
  <td colspan=4 class=xl161 style='mso-ignore:colspan'></td>
  <td class=xl162 x:str="Ng&#432;&#7901;i s&#7917; d&#7909;ng lao &#273;&#7897;ng"><span
  style='mso-spacerun:yes'> </span>Ng&#432;&#7901;i s&#7917; d&#7909;ng lao
  &#273;&#7897;ng<span style='mso-spacerun:yes'> </span></td>
  <td class=xl162></td>
  <td colspan=2 class=xl161 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl161 height=20 style='height:15.0pt'>
  <td height=20 class=xl161 style='height:15.0pt'></td>
  <td class=xl158>(ký ghi rõ h&#7885; tên)</td>
  <td height=20 colspan=2 class=xl161 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl158>(ký ghi rõ h&#7885; tên)</td>
  <td class=xl161></td>
  <td colspan=2 class=xl162 style='mso-ignore:colspan'></td>
  <td class=xl161></td>
  <td class=xl162></td>
  <td class=xl163>&nbsp;</td>
  <td class=xl159 x:str="(ký ghi rõ h&#7885; tên)"><span
  style='mso-spacerun:yes'> </span>(ký ghi rõ h&#7885; tên)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl164></td>
  <td colspan=4 class=xl161 style='mso-ignore:colspan'></td>
  <td class=xl159 x:str="(ký và &#273;óng d&#7845;u)"><span
  style='mso-spacerun:yes'> </span>(ký và &#273;óng d&#7845;u)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl162></td>
  <td colspan=2 class=xl161 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl161 height=19 style='height:14.25pt'>
  <td height=19 colspan=6 class=xl161 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl162 style='mso-ignore:colspan'></td>
  <td class=xl161></td>
  <td class=xl162></td>
  <td class=xl163>&nbsp;</td>
  <td class=xl162></td>
  <td class=xl164></td>
  <td colspan=4 class=xl161 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl162 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl161 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl161 height=19 style='height:14.25pt'>
  <td height=19 colspan=6 class=xl161 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl162 style='mso-ignore:colspan'></td>
  <td class=xl161></td>
  <td class=xl162></td>
  <td class=xl163>&nbsp;</td>
  <td class=xl162></td>
  <td class=xl164></td>
  <td colspan=4 class=xl161 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl162 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl161 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl161 height=19 style='height:14.25pt'>
  <td height=19 colspan=6 class=xl161 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl162 style='mso-ignore:colspan'></td>
  <td class=xl161></td>
  <td class=xl162></td>
  <td class=xl163>&nbsp;</td>
  <td class=xl162></td>
  <td class=xl164></td>
  <td colspan=4 class=xl161 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl162 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl161 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl161 height=19 style='height:14.25pt'>
  <td height=19 colspan=3 class=xl161 style='height:14.25pt;mso-ignore:colspan'></td>
  <td class=xl171></td>
  <td colspan=2 class=xl161 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl162 style='mso-ignore:colspan'></td>
  <td class=xl161></td>
  <td class=xl162></td>
  <td class=xl163>&nbsp;</td>
  <td class=xl162></td>
  <td class=xl164></td>
  <td colspan=4 class=xl161 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl162 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl161 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl101 height=20 style='height:15.0pt'>
  <td height=20 colspan=6 class=xl101 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl102 style='mso-ignore:colspan'></td>
  <td class=xl101></td>
  <td colspan=5 class=xl102 x:str="Nguy&#7877;n Th&#7883; Kim Oanh"><span
  style='mso-spacerun:yes'> </span>Nguy&#7877;n Th&#7883; Kim Oanh<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl101 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl102 x:str="Bang Yeong Sig"><span
  style='mso-spacerun:yes'> </span>Bang Yeong Sig<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl101 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl165 style='height:15.0pt'></td>
  <td class=xl104 colspan=9 style='mso-ignore:colspan'><font class="font14">Ghi
  chú </font><font class="font6">:<span style='mso-spacerun:yes'>   </span>+
  M&#7851;u 03a-TBH l&#7853;p khi &#273;&#417;n v&#7883; có &#273;i&#7873;u
  ch&#7881;nh v&#7873; lao &#273;&#7897;ng, ti&#7873;n l&#432;&#417;ng và
  m&#7913;c &#273;óng BHXH,BHYT b&#7855;t bu&#7897;c.</font></td>
  <td class=xl111>&nbsp;</td>
  <td colspan=2 class=xl105 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl104 style='mso-ignore:colspan'></td>
  <td class=xl105></td>
  <td colspan=4 class=xl104 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl103 style='height:15.0pt'></td>
  <td class=xl108 colspan=6 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>                 </span>+ &#272;&#417;n v&#7883;
  g&#7917;i c&#417; s&#7903; d&#7919; li&#7879;u bi&#7875;u này b&#7857;ng
  Email ho&#7863;c &#273;&#297;a m&#7873;m cho c&#417; quan BHXH.</td>
  <td colspan=2 class=xl104 style='mso-ignore:colspan'></td>
  <td class=xl105></td>
  <td class=xl111>&nbsp;</td>
  <td colspan=2 class=xl105 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl104 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl105 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl104 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl103 style='height:15.0pt'></td>
  <td colspan=8 class=xl104 style='mso-ignore:colspan'></td>
  <td class=xl105></td>
  <td class=xl111>&nbsp;</td>
  <td colspan=2 class=xl105 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl104 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl105 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl104 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl103 style='height:15.0pt'></td>
  <td colspan=8 class=xl104 style='mso-ignore:colspan'></td>
  <td class=xl105></td>
  <td class=xl111>&nbsp;</td>
  <td colspan=2 class=xl105 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl104 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl105 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl104 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl103 style='height:15.0pt'></td>
  <td colspan=7 class=xl104 style='mso-ignore:colspan'></td>
  <td class=xl136></td>
  <td class=xl105></td>
  <td class=xl111>&nbsp;</td>
  <td colspan=2 class=xl105 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl104 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl105 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl104 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl103 style='height:15.0pt'></td>
  <td colspan=8 class=xl104 style='mso-ignore:colspan'></td>
  <td class=xl105></td>
  <td class=xl111>&nbsp;</td>
  <td colspan=2 class=xl105 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl104 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl105 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl104 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=9 class=xl104 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl105></td>
  <td class=xl111>&nbsp;</td>
  <td colspan=2 class=xl105 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl104 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl105 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl104 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=9 class=xl104 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl105></td>
  <td class=xl111>&nbsp;</td>
  <td colspan=2 class=xl105 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl104 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl103 style='height:15.0pt'></td>
  <td colspan=8 class=xl104 style='mso-ignore:colspan'></td>
  <td class=xl105></td>
  <td class=xl111>&nbsp;</td>
  <td colspan=2 class=xl105 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl104 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl105 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl104 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl103 style='height:15.0pt'></td>
  <td colspan=6 class=xl104 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl105 style='mso-ignore:colspan'></td>
  <td class=xl111>&nbsp;</td>
  <td colspan=2 class=xl105 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl104 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl105 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl104 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl103 style='height:15.0pt'></td>
  <td colspan=5 class=xl104 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl105 style='mso-ignore:colspan'></td>
  <td class=xl111>&nbsp;</td>
  <td colspan=2 class=xl105 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl104 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl105 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl104 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl136 height=20 style='height:15.0pt'>
  <td height=20 class=xl101 style='height:15.0pt'></td>
  <td colspan=5 class=xl136 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl166 style='mso-ignore:colspan'></td>
  <td class=xl167>&nbsp;</td>
  <td colspan=2 class=xl166 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl136 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl166 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl136 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl103 style='height:15.0pt'></td>
  <td colspan=4 class=xl104 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl105 style='mso-ignore:colspan'></td>
  <td class=xl111>&nbsp;</td>
  <td colspan=2 class=xl105 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl104 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl105 style='mso-ignore:colspan'></td>
  <td class=xl168></td>
  <td class=xl104></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=27 style='width:20pt'></td>
  <td width=214 style='width:161pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=0></td>
  <td width=40 style='width:30pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
