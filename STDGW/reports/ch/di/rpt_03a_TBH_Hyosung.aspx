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
    
    string p_times,p_rpt_month,p_old_year,p_cur_year, p_select;
     
    p_times       = Request["l_times"].ToString();
    p_rpt_month  = Request["l_rpt_month"].ToString();
    p_select     = Request["l_select"].ToString();
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
        ",a.FULL_NAME as c2 " +
        ",a.SO_BHXH as c3 " +
        ",a.LUONG_CU as c4 " +
        ",'' as c5 " +
        ",'' as c6 " +
        ",'' as c7 " +
        ",'' as c8 " +
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
        ",a.TY_LE||'%' as c20 " +
        ",decode(e.employee_type, '01', 'nhân viên', 'công nhân') as c21 " +
        ",a.SO_THANG as c22 " +
        ",a.DC_TANG_XH as c23 " +
        ",a.DC_GIAM_XH as c24 " +
        ",a.DC_TANG_YT as c25 " +
        ",a.DC_GIAM_YT as c26 " +
        ",a.ghi_chu as c27 " +
        ",a.EMP_ID as c28 " +
        ",decode(nvl(a.TRA_THE_YN,'N'),'Y','X','') as c29 " +
        ",nvl(a.CL_TANG_TN,0) as c30 " +
        ",nvl(a.CL_GIAM_TN,0) as c31 " +
        ",a.DC_TANG_TN as c32 " +
        ",a.DC_GIAM_TN as c33 " +
        ",(SELECT D.NUM_1 FROM THR_CODE_MASTER M,THR_CODE_DETAIL D WHERE M.DEL_IF=0 AND D.DEL_IF=0 AND D.THR_CODE_MASTER_PK=M.PK and id='HR0043' and char_1='" + p_old_year + "') c34 " +
        ",(select num_1 from vhr_hr_code where id='HR0043' and char_1='" + p_cur_year + "' ) c35 " +
        ",(select char_4 from vhr_hr_code where id='HR0043' and char_1='" + p_cur_year + "' ) c36 " +
        "from THR_INSURANCE_MANAGE a, thr_employee e, " +
        "(select code,num_1,CHAr_3 from vhr_hr_code where id='HR0041') ins_type " +
        "where a.del_if=0 and a.LOAI_BH=ins_type.code and a.loai_bh  not in(" + ins_type + ")" +
        "and e.del_if=0 and a.thr_emp_pk = e.pk " +
        "and ((a.status_rpt = -1 and '" + p_select + "' = 'Y') or '" + p_select + "' = 'N' ) " +  //lay report dc select
        "and a.THANG_BC='" + p_rpt_month + "' " +
        "and a.LAN_BAO='" + p_times + "' " +
        "order by ins_type.num_1,a.emp_id,a.LUONG_MOI  ";


//Response.Write(SQL);
//Response.End();
    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp=dt_Emp.Columns.Count;
    
    if (irow_emp == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    
    //getting information of labels 
    SQL
    = "select code_fnm,to_char(sysdate,'dd/mm/yyyy')  " +
        "from vhr_hr_code " +
        "where id='HR0049'  order by code ";
    DataTable dt_name = ESysLib.TableReadOpen(SQL);
    int irow_name;
    irow_name = dt_name.Rows.Count;
    if (irow_name <7)
    {
        Response.Write("You have to input enough information of HR0049 code");
        Response.End();
    }
    //summary  of insurance
    SQL
	= "select  " + 
        "sum(decode(a.loai_bh,'02',1,'03',1,0)) as c1t1  " +
        ",sum(decode(a.loai_bh,'04',1,'05',1,'06',1,'07',1,0)) as c1g2 " +
        ",sum(nvl(a.CL_TANG_XH,0)) as c2txh3 " +
        ",sum(nvl(a.CL_GIAM_XH,0)) as c2gxh4 " +
        ",sum(nvl(a.CL_TANG_YT,0)) as c2tyt5 " +
        ",sum(nvl(a.CL_GIAM_YT,0)) as c2gyt6 " +
        ",sum(nvl(a.CL_TANG_XH,0))*max(nvl(social_rate,0) + nvl(social_com_rate,0))/100  as c3txh7 " +
        ",sum(nvl(a.CL_GIAM_XH,0))*max(nvl(social_rate,0) + nvl(social_com_rate,0))/100 as c3gxh8 " +
        ",sum(nvl(a.CL_TANG_YT,0))*max(nvl(health_rate,0) + nvl(health_com_rate,0))/100  as c3tyt9 " +
        ",sum(nvl(a.CL_GIAM_YT,0))*max(nvl(health_rate,0) + nvl(health_com_rate,0))/100 as c3gyt10 " +
        ",sum(nvl(a.dc_tang_xh,0)) as c4txh11 " +
        ",sum(nvl(a.dc_giam_xh,0)) as c4gxh12 " +
        ",sum(nvl(a.dc_tang_yt,0)) as c4tyt13 " +
        ",sum(nvl(a.dc_giam_yt,0)) as c4gyt14 " +
        ",sum(nvl(a.CL_TANG_TN,0)) as c2ttn15 " +
        ",sum(nvl(a.CL_GIAM_TN,0)) as c2gtn16" +
        ",sum(nvl(a.CL_TANG_TN,0))*max(nvl(unemp_rate,0) + nvl(unemp_com_rate,0))/100  as c3ttn17 " +
        ",sum(nvl(a.CL_GIAM_TN,0))*max(nvl(unemp_rate,0) + nvl(unemp_com_rate,0))/100 as c3gtn18 " +
        ",sum(nvl(a.dc_tang_tn,0)) as c4ttn19 " +
        ",sum(nvl(a.dc_giam_tn,0)) as c4gtn20 " +
        ",sum(case when a.TRA_THE_YN = 'Y' then 1 else 0 end) trathe21 " +
        ",sum(case when a.LOAI_BH = '14'  then 1 else 0 end) kotrathe22 " +
        "from thr_insurance_manage a " +
        "where a.del_if=0  " +
        "and a.THANG_BC='" + p_rpt_month + "' " +
		"and ((a.status_rpt = -1 and '" + p_select + "' = 'Y') or '" + p_select + "' = 'N' ) " +  //lay report dc select
        "and a.LAN_BAO='" + p_times + "' and a.loai_bh not in(" + ins_type + ") ";
        
    DataTable dt_sum = ESysLib.TableReadOpen(SQL);
    int irow_sum;
    irow_sum = dt_sum.Rows.Count;
    if (irow_sum ==0)
    {
        Response.Write("There is no data");
        Response.End();
    }

    %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_03a_TBH_Hyosung_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_03a_TBH_Hyosung_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_03a_TBH_Hyosung_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>welcome</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-10-01T03:47:16Z</o:LastPrinted>
  <o:Created>2011-10-01T03:40:25Z</o:Created>
  <o:LastSaved>2011-10-01T03:55:02Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:0in .2in 0in .2in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;
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
	font-family:"MS Sans Serif", sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl66
	{mso-style-parent:style0;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl67
	{mso-style-parent:style0;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"MS Sans Serif", sans-serif;
	mso-font-charset:0;}
.xl69
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl70
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"MS Sans Serif", sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl71
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style43;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl73
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl74
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
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
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl76
	{mso-style-parent:style43;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl77
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl78
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl79
	{mso-style-parent:style43;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl80
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl82
	{mso-style-parent:style0;
	color:windowtext;
	font-size:7.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl83
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl84
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl85
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl86
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl87
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl88
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl89
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl90
	{mso-style-parent:style43;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl91
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl92
	{mso-style-parent:style0;
	background:white;
	mso-pattern:auto none;}
.xl93
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl94
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl95
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl96
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl97
	{mso-style-parent:style0;
	text-align:center;}
.xl98
	{mso-style-parent:style0;
	color:windowtext;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl99
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl100
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl101
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl102
	{mso-style-parent:style0;
	color:windowtext;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl103
	{mso-style-parent:style43;
	color:red;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl104
	{mso-style-parent:style43;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	background:white;
	mso-pattern:auto none;}
.xl105
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl106
	{mso-style-parent:style43;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	background:white;
	mso-pattern:auto none;}
.xl107
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl108
	{mso-style-parent:style43;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl109
	{mso-style-parent:style0;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl110
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl111
	{mso-style-parent:style43;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl112
	{mso-style-parent:style43;
	color:red;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl113
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl114
	{mso-style-parent:style43;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	background:white;
	mso-pattern:auto none;}
.xl115
	{mso-style-parent:style0;
	font-weight:700;
	background:white;
	mso-pattern:auto none;}
.xl116
	{mso-style-parent:style43;
	color:red;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl117
	{mso-style-parent:style43;
	color:red;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl118
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl119
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl120
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl121
	{mso-style-parent:style43;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl122
	{mso-style-parent:style43;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl123
	{mso-style-parent:style43;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl124
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl125
	{mso-style-parent:style43;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl126
	{mso-style-parent:style43;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl127
	{mso-style-parent:style43;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl128
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl129
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl130
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl131
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl132
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl133
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl134
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl135
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl136
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl137
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl138
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl139
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl140
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl141
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl142
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl143
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl144
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl145
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl146
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl147
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl148
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl149
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl150
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl151
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl152
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl153
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl154
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl155
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl156
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl157
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl158
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl159
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl160
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl161
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl162
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl163
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl164
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
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
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl165
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl166
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl167
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl168
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl169
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl170
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl171
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl172
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl173
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl174
	{mso-style-parent:style43;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl175
	{mso-style-parent:style43;
	color:windowtext;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl176
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"MS Sans Serif", sans-serif;
	mso-font-charset:0;
	text-align:right;
	background:white;
	mso-pattern:auto none;}
.xl177
	{mso-style-parent:style43;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl178
	{mso-style-parent:style43;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl179
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl180
	{mso-style-parent:style43;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl181
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
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
    <x:Name>Sheet1 (5)</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>9</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>26</x:ActiveRow>
       <x:ActiveCol>14</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7935</x:WindowHeight>
  <x:WindowWidth>20115</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>135</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Sheet1 (5)'!$11:$16</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="8193"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1,2,3,4,5,6,7"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl65>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1280 style='border-collapse:
 collapse;table-layout:fixed;width:963pt'>
 <col class=xl65 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl65 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:2596'>
 <col class=xl65 width=153 style='mso-width-source:userset;mso-width-alt:5595;
 width:115pt'>
 <col class=xl65 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl65 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl65 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl65 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl65 width=21 style='mso-width-source:userset;mso-width-alt:768;
 width:16pt'>
 <col class=xl65 width=17 style='mso-width-source:userset;mso-width-alt:621;
 width:13pt'>
 <col class=xl65 width=27 style='mso-width-source:userset;mso-width-alt:987;
 width:20pt'>
 <col class=xl65 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl65 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl65 width=46 style='mso-width-source:userset;mso-width-alt:1682;
 width:35pt'>
 <col class=xl65 width=20 style='mso-width-source:userset;mso-width-alt:731;
 width:15pt'>
 <col class=xl65 width=25 style='mso-width-source:userset;mso-width-alt:914;
 width:19pt'>
 <col class=xl65 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <col class=xl65 width=60 style='mso-width-source:userset;mso-width-alt:2194;
 width:45pt'>
 <col class=xl65 width=52 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col class=xl65 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl65 width=35 style='mso-width-source:userset;mso-width-alt:1280;
 width:26pt'>
 <col class=xl65 width=48 style='mso-width-source:userset;mso-width-alt:1755;
 width:36pt'>
 <col class=xl65 width=64 style='width:48pt'>
 <col class=xl65 width=80 span=2 style='mso-width-source:userset;mso-width-alt:
 2925;width:60pt'>
 <tr height=27 style='height:20.25pt'>
  <td height=27 class=xl65 width=40 style='height:20.25pt;width:30pt'>&nbsp;</td>
  <td class=xl65 width=0>&nbsp;</td>
  <td class=xl65 width=153 style='width:115pt'>&nbsp;</td>
  <td class=xl66 width=90 style='width:68pt'>&nbsp;</td>
  <td class=xl66 width=94 style='width:71pt'>&nbsp;</td>
  <td class=xl66 colspan=6 width=306 style='mso-ignore:colspan;width:231pt'
  x:str="DANH SÁCH &#272;I&#7872;U CH&#7880;NH ">DANH SÁCH &#272;I&#7872;U
  CH&#7880;NH<span style='mso-spacerun:yes'> </span></td>
  <td class=xl66 width=65 style='width:49pt'>&nbsp;</td>
  <td class=xl66 width=46 style='width:35pt'>&nbsp;</td>
  <td class=xl66 width=20 style='width:15pt'>&nbsp;</td>
  <td class=xl66 width=25 style='width:19pt'>&nbsp;</td>
  <td class=xl66 width=55 style='width:41pt'>&nbsp;</td>
  <td class=xl66 width=60 style='width:45pt'>&nbsp;</td>
  <td class=xl65 width=52 style='width:39pt'>&nbsp;</td>
  <td class=xl65 width=47 style='width:35pt'>&nbsp;</td>
  <td class=xl65 width=35 style='width:26pt'>&nbsp;</td>
  <td class=xl65 width=48 style='width:36pt'>&nbsp;</td>
  <td class=xl65 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl65 width=80 style='width:60pt'>&nbsp;</td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td height=27 colspan=3 class=xl65 style='height:20.25pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67 colspan=11 style='mso-ignore:colspan'>LAO &#272;&#7896;NG<span
  style='mso-spacerun:yes'>  </span>VÀ M&#7912;C &#272;ÓNG BHXH , BHYT
  B&#7854;T BU&#7896;C.</td>
  <td colspan=2 class=xl67 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl176>Mã &#272;V&#7882;:</td>
  <td class=xl68>YN0<span style='display:none'>098K</span></td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 class=xl65 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=5 class=xl69 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl69 colspan=3 style='mso-ignore:colspan'>Tháng <%= p_rpt_month.Substring(4,2).ToString() %>/<%= p_rpt_month.Substring(0,4).ToString() %> </td>
  <td colspan=6 class=xl69 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl70 colspan=3 style='mso-ignore:colspan'>M&#7851;u s&#7889;: 03a -
  TBH</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl65 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl75>(Áp d&#7909;ng &#273;&#7889;i v&#7901;i ng&#432;&#7901;i lao
  &#273;&#7897;ng h&#432;&#7903;ng l&#432;&#417;ng do ch&#7911; s&#7917;
  d&#7909;ng lao &#273;&#7897;ng quy &#273;&#7883;nh)</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl65 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl75>&#272;&#417;n v&#7883; ch&#7911; qu&#7843;n: BHXH HUY&#7878;N
  NH&#416;N TR&#7840;CH - &#272;&#7890;NG NAI</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl65 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl75>Tên &#273;&#417;n v&#7883;: CÔNG TY TNHH HYOSUNG</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl65 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl75>&#272;&#7883;a ch&#7881;: &#272;&#431;&#7900;NG N2,KHU CN
  NH&#416;N TR&#7840;CH 5 - NH&#416;N TR&#7840;CH - &#272;&#7890;NG NAI</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl65 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl75>&#272;i&#7879;n tho&#7841;i: 0613.569 467<span
  style='mso-spacerun:yes'>      </span>Fax: 0163.569 230</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl65 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl75>S&#7889; tài kho&#7843;n: DD912030077 (VND) T&#7840;I Ngân
  Hàng WOORI BANK,Chi Nhánh H&#7891; Chí Minh</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=23 class=xl65 style='height:13.5pt;mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td rowspan=5 height=150 class=xl159 width=40 style='border-bottom:1.0pt solid black;
  height:112.5pt;width:30pt'>STT</td>
  <td rowspan=5 class=xl163 width=0 style='border-bottom:1.0pt solid black'
  x:str="Mã NV ">Mã NV<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=5 class=xl166 style='border-bottom:1.0pt solid black'>H&#7885; và
  tên</td>
  <td rowspan=3 class=xl143 width=90 style='width:68pt' x:str="S&#7889; S&#7893; BHXH ">S&#7889;
  S&#7893; BHXH<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=5 class=xl170 width=94 style='border-bottom:1.0pt solid black;
  width:71pt'>Ch&#7913;c v&#7909; ho&#7863;c<br>
    ch&#7913;c danh ngh&#7873;</td>
  <td colspan=10 class=xl171 style='border-right:.5pt solid black;border-left:
  none'>Ti&#7873;n L&#432;&#417;ng và ph&#7909; c&#7845;p</td>
  <td colspan=2 class=xl139 style='border-left:none' x:str="Th&#7901;i gian ">Th&#7901;i
  gian<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=5 class=xl140 width=52 style='border-bottom:1.0pt solid black;
  width:39pt'>T&#7927; l&#7879; n&#7897;p<br>
    <span style='mso-spacerun:yes'> </span>b&#7893; sung</td>
  <td rowspan=5 class=xl140 width=47 style='border-bottom:1.0pt solid black;
  width:35pt'>H&#272;L&#272;<br>
    (S&#7889;, ngày<br>
    tháng<br>
    n&#259;m)</td>
  <td colspan=2 rowspan=2 class=xl143 width=83 style='border-right:1.0pt solid black;
  width:62pt'>Ghi chú</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=5 rowspan=2 height=34 class=xl147 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:25.5pt' x:str="M&#7913;c L&#432;&#417;ng c&#361; ">M&#7913;c
  L&#432;&#417;ng c&#361;<span style='mso-spacerun:yes'> </span></td>
  <td colspan=5 rowspan=2 class=xl147 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>M&#7913;c L&#432;&#417;ng m&#7899;i</td>
  <td class=xl78 style='border-left:none' x:str="From ">From<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl78 style='border-left:.5pt solid black' x:str="to ">to<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=3 height=115 class=xl153 width=55 style='border-bottom:1.0pt solid black;
  height:86.25pt;border-top:none;width:41pt' x:str="T&#7915; tháng&#10;n&#259;m ">T&#7915;
  tháng<br>
    n&#259;m<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl153 width=60 style='border-bottom:1.0pt solid black;
  border-top:none;width:45pt' x:str="&#272;&#7871;n tháng&#10;n&#259;m ">&#272;&#7871;n
  tháng<br>
    n&#259;m<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl145 width=35 style='border-bottom:1.0pt solid black;
  border-top:none;width:26pt'>Tr&#7843; th&#7867; <br>
    &#273;ánh d&#7845;u<br>
    X</td>
  <td rowspan=3 class=xl157 width=48 style='border-bottom:1.0pt solid black;
  border-top:none;width:36pt'>Khác</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=98 class=xl145 width=90 style='border-bottom:1.0pt solid black;
  height:73.5pt;border-top:none;width:68pt'>(Social book No.)</td>
  <td rowspan=2 class=xl174 width=90 style='border-bottom:1.0pt solid black;width:68pt' x:str><span
  style='mso-spacerun:yes'> </span>Ti&#7873;n l&#432;&#417;ng,<br>
    ti&#7873;n công<br>
    <span style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl125 width=126 style='border-right:.5pt solid black;
  border-left:none;width:95pt' x:str="Ph&#7909; c&#7845;p"><span
  style='mso-spacerun:yes'> </span>Ph&#7909; c&#7845;p<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl174 width=90 style='border-bottom:1.0pt solid black;width:68pt' x:str><span
  style='mso-spacerun:yes'> </span>Ti&#7873;n l&#432;&#417;ng,<br>
    ti&#7873;n công<br>
    <span style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl125 width=156 style='border-right:.5pt solid black;
  border-left:none;width:118pt' x:str="Ph&#7909; c&#7845;p"><span
  style='mso-spacerun:yes'> </span>Ph&#7909; c&#7845;p<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=81 style='height:60.75pt'>
  <td height=81 class=xl79 width=61 style='height:60.75pt;border-top:none;
  border-left:none;width:46pt' x:str="CV&#7909;"><span
  style='mso-spacerun:yes'> </span>CV&#7909;<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl79 width=21 style='border-top:none;border-left:none;width:16pt'
  x:str="TN&#10;VK"><span style='mso-spacerun:yes'> </span>TN<br>
    VK<span style='mso-spacerun:yes'> </span></td>
  <td class=xl79 width=17 style='border-top:none;border-left:none;width:13pt'
  x:str="TNNG"><span style='mso-spacerun:yes'> </span>TNNG<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl80 width=27 style='border-top:none;border-left:none;width:20pt'>KV</td>
  <td class=xl79 width=65 style='border-top:none;border-left:none;width:49pt'
  x:str="CV&#7909;"><span style='mso-spacerun:yes'> </span>CV&#7909;<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl79 width=46 style='border-top:none;border-left:none;width:35pt'
  x:str="TN&#10;VK"><span style='mso-spacerun:yes'> </span>TN<br>
    VK<span style='mso-spacerun:yes'> </span></td>
  <td class=xl79 width=20 style='border-top:none;border-left:none;width:15pt'
  x:str="TNNG"><span style='mso-spacerun:yes'> </span>TNNG<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl80 width=25 style='border-top:none;border-left:none;width:19pt'>KV</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl81 style='height:13.5pt;border-top:none' x:num>1</td>
  <td class=xl82 style='border-top:none;border-left:none' x:str="'1">1</td>
  <td class=xl83 style='border-top:none;border-left:none'>2</td>
  <td class=xl84 style='border-top:none;border-left:none'>3</td>
  <td class=xl83 style='border-top:none;border-left:none'>4</td>
  <td class=xl84 style='border-top:none;border-left:none'>5</td>
  <td class=xl83 style='border-top:none;border-left:none'>6</td>
  <td class=xl84 style='border-top:none;border-left:none'>7</td>
  <td class=xl83 style='border-top:none;border-left:none'>8</td>
  <td class=xl84 style='border-top:none;border-left:none'>9</td>
  <td class=xl83 style='border-top:none;border-left:none'>10</td>
  <td class=xl84 style='border-top:none;border-left:none'>11</td>
  <td class=xl83 style='border-top:none;border-left:none'>12</td>
  <td class=xl84 style='border-top:none;border-left:none'>13</td>
  <td class=xl83 style='border-top:none;border-left:none'>14</td>
  <td class=xl85 style='border-top:none;border-left:none'>15</td>
  <td class=xl85 style='border-top:none;border-left:none'>16</td>
  <td class=xl84 style='border-top:none;border-left:none'>17</td>
  <td class=xl86 style='border-top:none;border-left:none'>18</td>
  <td class=xl87 style='border-top:none'>19</td>
  <td class=xl88 style='border-top:none'>20</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <% 
    string next_type,cur_type,old_type;
    Boolean bchange=false;
    Boolean btotal=false;
    double dLuongCu = 0, dLuongMoi = 0, dBSTangXH = 0, dBSGiamXH = 0, dBSTangYT = 0, dBSGiamYT = 0, dBSTangTN = 0, dBSGiamTN = 0;
    double dLuongCuT = 0, dLuongMoiT = 0, dBSTangXHT = 0, dBSGiamXHT = 0, dBSTangYTT = 0, dBSGiamYTT = 0, dBSTangTNT = 0, dBSGiamTNT = 0;
    double dCLTangXH = 0, dCLGiamXH = 0, dCLTangYT = 0, dCLGiamYT = 0, dCLTangTN = 0, dCLGiamTN = 0;
    double dCLTangXHT = 0, dCLGiamXHT = 0, dCLTangYTT = 0, dCLGiamYTT = 0, dCLTangTNT = 0, dCLGiamTNT = 0;
    string[] atype=new string[] {"I","II","III","IV","V","VI","VII","VIII","IX","X","XI"};
    int irow_type=0;
    int j=0;
    for (int i=0;i<irow_emp;i++)
    {
        irow_type+=1;
        cur_type=dt_Emp.Rows[i][0].ToString();
        //sum
        if (dt_Emp.Rows[i][3].ToString()!="")
        {
             dLuongCu+=double.Parse(dt_Emp.Rows[i][3].ToString());
             dLuongCuT+=double.Parse(dt_Emp.Rows[i][3].ToString());
        }
        if (dt_Emp.Rows[i][8].ToString()!="")
        {
            dLuongMoi+=double.Parse(dt_Emp.Rows[i][8].ToString());
            dLuongMoiT+=double.Parse(dt_Emp.Rows[i][8].ToString());
        }
        if (dt_Emp.Rows[i][22].ToString()!="")
        {
            dBSTangXH += double.Parse(dt_Emp.Rows[i][22].ToString());
            dBSTangXHT += double.Parse(dt_Emp.Rows[i][22].ToString());
        }
        if (dt_Emp.Rows[i][23].ToString()!="")
        {
            dBSGiamXH += double.Parse(dt_Emp.Rows[i][23].ToString());
            dBSGiamXHT += double.Parse(dt_Emp.Rows[i][23].ToString());
        }
        if (dt_Emp.Rows[i][24].ToString()!="")
        {
            dBSTangYT += double.Parse(dt_Emp.Rows[i][24].ToString());
            dBSTangYTT += double.Parse(dt_Emp.Rows[i][24].ToString());
        }
        if (dt_Emp.Rows[i][25].ToString()!="")
        {
            dBSGiamYT += double.Parse(dt_Emp.Rows[i][25].ToString());
            dBSGiamYTT += double.Parse(dt_Emp.Rows[i][25].ToString());
        }
        if (dt_Emp.Rows[i][31].ToString() != "")
        {
            dBSTangTN += double.Parse(dt_Emp.Rows[i][31].ToString());
            dBSTangTNT += double.Parse(dt_Emp.Rows[i][31].ToString());
        }
        if (dt_Emp.Rows[i][32].ToString() != "")
        {
            dBSGiamTN += double.Parse(dt_Emp.Rows[i][32].ToString());
            dBSGiamTNT += double.Parse(dt_Emp.Rows[i][32].ToString());
        }
        //chenh lech bao hiem 
        if (dt_Emp.Rows[i][13].ToString() != "")
        {
            dCLTangXH += double.Parse(dt_Emp.Rows[i][13].ToString());
            dCLTangXHT += double.Parse(dt_Emp.Rows[i][13].ToString());
        }
        if (dt_Emp.Rows[i][14].ToString() != "")
        {
            dCLGiamXH += double.Parse(dt_Emp.Rows[i][14].ToString());
            dCLGiamXHT += double.Parse(dt_Emp.Rows[i][14].ToString());
        }
        if (dt_Emp.Rows[i][15].ToString() != "")
        {
            dCLTangYT += double.Parse(dt_Emp.Rows[i][15].ToString());
            dCLTangYTT += double.Parse(dt_Emp.Rows[i][15].ToString());
        }
        if (dt_Emp.Rows[i][16].ToString() != "")
        {
            dCLGiamYT += double.Parse(dt_Emp.Rows[i][16].ToString());
            dCLGiamYTT += double.Parse(dt_Emp.Rows[i][16].ToString());
        }
        if (dt_Emp.Rows[i][29].ToString() != "")
        {
            dCLTangTN += double.Parse(dt_Emp.Rows[i][29].ToString());
            dCLTangTNT += double.Parse(dt_Emp.Rows[i][29].ToString());
        }
        if (dt_Emp.Rows[i][30].ToString() != "")
        {
            dCLGiamTN += double.Parse(dt_Emp.Rows[i][30].ToString());
            dCLGiamTNT += double.Parse(dt_Emp.Rows[i][30].ToString());
        }
            
        //end sum 
        if (i==0) 
            bchange=true;
        else
        {
            old_type=dt_Emp.Rows[i-1][0].ToString();
            if (cur_type!=old_type)
                bchange=true;
        }    
        if (bchange==true)
        { 
            irow_type=1;
            //doi loai bao cao 
  %>
 <tr class=xl92 height=21 style='height:15.75pt'>
  <td colspan=5 height=21 class=xl128 style='border-right:.5pt solid black;
  height:15.75pt'><%=atype[j]%>.<%=cur_type %></td>

  <%--<td class=xl89 style='border-left:none'>&nbsp;</td>--%>
  <td class=xl90 style='border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl91 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
  <%     bchange=false;
            j+=1;
        }//ket thuc doi group%>
 <tr class=xl97 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl93 style='height:18.0pt;border-top:none' x:num><%=irow_type %></td>
  <td class=xl94 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][27].ToString() %></td>
  <td class=xl94 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][1].ToString() %></td>
  <td class=xl179 style='border-top:none;border-left:none' x:str><%=dt_Emp.Rows[i][2].ToString() %></td>
  <td class=xl180 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][20].ToString() %></td>
  <td class=xl177 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>        </span><%=dt_Emp.Rows[i][3].ToString() %> </td>
  <td class=xl94 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl94 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl94 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl94 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl177 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][8].ToString() %></td>
  <td class=xl94 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl94 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl94 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl94 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl181 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][17].ToString() %></td>
  <td class=xl181 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][18].ToString() %></td>
  <td class=xl179 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][19].ToString() %></td>
  <td class=xl95 style='border-top:none;border-left:none'></td>
  <td class=xl94 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][28].ToString() %></td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl97 style='mso-ignore:colspan'></td>
 </tr>
  <%
        if(i==irow_emp-1)
            btotal=true;
        else
        {    
            next_type=dt_Emp.Rows[i+1][0].ToString();
            if (cur_type !=next_type)
                btotal=true;
        } 
        if (btotal==true)
        {   
  %>
 <tr class=xl92 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=3 height=28 class=xl131 style='height:21.0pt'>T&#7893;ng
  c&#7897;ng</td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl178 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>      </span><%=dLuongCu %> </td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl178 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>      </span><%= dLuongMoi %> </td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl100 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
  <%         btotal=false;
            dLuongCu=0;
            dLuongMoi=0;
            dBSTangXH=0;
            dBSGiamXH=0;
            dBSTangYT=0;
            dBSGiamYT=0;
            dCLTangXH = 0;
            dCLGiamXH = 0;
            dCLTangYT = 0;
            dCLGiamYT = 0;
            
        }//ket thuc tong cong tung type 
    } //ket thuc vong for
  %>
 <tr class=xl92 height=20 style='height:15.0pt'>
  <td height=20 colspan=3 class=xl101 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td height=20 class=xl102 width=90 style='height:15.0pt;width:68pt'>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td height=20 class=xl104 width=90 style='height:15.0pt;width:68pt'>&nbsp;</td>
  <td colspan=4 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl104>&nbsp;</td>
  <td colspan=12 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl92 height=20 style='height:15.0pt'>
  <td height=20 colspan=2 class=xl92 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl105>T&#7892;NG H&#7906;P CHUNG</td>
  <td class=xl105>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl106>&nbsp;</td>
  <td colspan=17 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl92 height=20 style='height:15.0pt'>
  <td height=20 colspan=2 class=xl92 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td rowspan=3 class=xl133 style='border-bottom:.5pt solid black'>Phát sinh</td>
  <td colspan=10 class=xl136 style='border-right:.5pt solid black;border-left:
  none'>Phát sinh trong k&#7923;</td>
  <td colspan=10 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl92 height=20 style='height:15.0pt'>
  <td height=20 colspan=2 class=xl92 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl136 style='border-right:.5pt solid black;border-left:
  none'>B&#7843;o hi&#7875;m xã h&#7897;i</td>
  <td colspan=5 class=xl136 style='border-right:.5pt solid black;border-left:
  none'>B&#7843;o hi&#7875;m y t&#7871;</td>
  <td colspan=3 class=xl136 style='border-right:.5pt solid black;border-left:
  none'>B&#7843;o hi&#7875;m th&#7845;t gnhi&#7879;p</td>
  <td colspan=10 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl92 height=20 style='height:15.0pt'>
  <td height=20 colspan=2 class=xl92 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none' x:str="T&#259;ng ">T&#259;ng<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl107 style='border-top:none;border-left:none'>Gi&#7843;m</td>
  <td class=xl108 style='border-top:none;border-left:none' x:str="T&#259;ng "><span
  style='mso-spacerun:yes'> </span>T&#259;ng<span
  style='mso-spacerun:yes'>  </span></td>
  <td colspan=4 class=xl136 style='border-right:.5pt solid black;border-left:
  none'>Gi&#7843;m</td>
  <td class=xl107 style='border-top:none;border-left:none' x:str="T&#259;ng ">T&#259;ng<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl136 style='border-right:.5pt solid black;border-left:
  none'>Gi&#7843;m</td>
  <td colspan=10 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl92 height=20 style='height:15.0pt'>
  <td height=20 colspan=2 class=xl92 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl109 style='border-top:none'>1.Lao &#273;&#7897;ng</td>
  <td class=xl110 style='border-top:none;border-left:none' x:num><%=dt_sum.Rows[0][0].ToString()%></td>
  <td class=xl110 style='border-top:none;border-left:none' x:num><%=dt_sum.Rows[0][1].ToString()%></td>
  <td class=xl110 style='border-top:none;border-left:none' x:num><%=dt_sum.Rows[0][0].ToString()%></td>
  <td colspan=4 class=xl118 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dt_sum.Rows[0][1].ToString()%></td>
  <td class=xl110 style='border-top:none;border-left:none' x:num><%=dt_sum.Rows[0][0].ToString()%></td>
  <td colspan=2 class=xl118 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dt_sum.Rows[0][1].ToString()%></td>
  <td colspan=10 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl92 height=20 style='height:15.0pt'>
  <td height=20 colspan=2 class=xl92 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl109 style='border-top:none'>2.Qu&#7929; l&#432;&#417;ng</td>
  <td class=xl111 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                       </span><%=dt_sum.Rows[0][2].ToString()%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl111 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%=dt_sum.Rows[0][3].ToString()%> </td>
  <td class=xl111 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                       </span><%=dt_sum.Rows[0][4].ToString()%><span
  style='mso-spacerun:yes'>   </span></td>
  <td colspan=4 class=xl121 style='border-right:.5pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'>                   
  </span><%=dt_sum.Rows[0][5].ToString()%> </td>
  <td class=xl111 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                       </span><%=dt_sum.Rows[0][14].ToString()%><span
  style='mso-spacerun:yes'>   </span></td>
  <td colspan=2 class=xl121 style='border-right:.5pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'>              
  </span><%=dt_sum.Rows[0][15].ToString()%> </td>
  <td colspan=5 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=5 class=xl124>&nbsp;</td>
 </tr>
 <tr class=xl92 height=20 style='height:15.0pt'>
  <td height=20 colspan=2 class=xl92 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl109 style='border-top:none'>3.BHXH ph&#7843;i &#273;óng</td>
  <td class=xl111 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                       </span><%=dt_sum.Rows[0][6].ToString()%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl111 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><%=dt_sum.Rows[0][7].ToString()%> </td>
  <td class=xl111 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                       </span><%=dt_sum.Rows[0][8].ToString()%><span
  style='mso-spacerun:yes'>   </span></td>
  <td colspan=4 class=xl121 style='border-right:.5pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'>                       
  </span><%=dt_sum.Rows[0][9].ToString()%> </td>
  <td class=xl111 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                       </span><%=dt_sum.Rows[0][16].ToString()%><span
  style='mso-spacerun:yes'>   </span></td>
  <td colspan=2 class=xl121 style='border-right:.5pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'>                    
  </span><%=dt_sum.Rows[0][17].ToString()%> </td>
  <td colspan=5 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl124>&nbsp;</td>
  <td colspan=2 class=xl124>&nbsp;</td>
 </tr>
 <tr class=xl92 height=20 style='height:15.0pt'>
  <td height=20 colspan=2 class=xl92 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl109 style='border-top:none'>4.&#272;i&#7873;u ch&#7881;nh
  s&#7889; ph&#7843;i &#273;ón<span style='display:none'>g</span></td>
  <td class=xl112 style='border-top:none;border-left:none' x:num><%=dt_sum.Rows[0][10].ToString()%></td>
  <td class=xl112 style='border-top:none;border-left:none' x:num><%=dt_sum.Rows[0][11].ToString()%></td>
  <td class=xl112 style='border-top:none;border-left:none' x:num><%=dt_sum.Rows[0][12].ToString()%></td>
  <td colspan=4 class=xl116 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dt_sum.Rows[0][13].ToString()%></td>
  <td class=xl112 style='border-top:none;border-left:none' x:num><%=dt_sum.Rows[0][18].ToString()%></td>
  <td colspan=2 class=xl116 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dt_sum.Rows[0][19].ToString()%></td>
  <td colspan=10 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl92 height=20 style='height:15.0pt'>
  <td height=20 class=xl92 style='height:15.0pt'>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl92 colspan=2 style='mso-ignore:colspan'>T&#7893;ng s&#7889;
  th&#7867; &#273;ã thu h&#7891;i : <%= dt_sum.Rows[0][20].ToString() %></td>
  <td colspan=9 class=xl106 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=10 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl92 height=20 style='height:15.0pt'>
  <td height=20 class=xl92 style='height:15.0pt'>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl92 colspan=2 style='mso-ignore:colspan'>T&#7893;ng s&#7889;
  th&#7867; ch&#432;a thu h&#7891;i : <%= dt_sum.Rows[0][21].ToString() %></td>
  <td colspan=2 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl106>&nbsp;</td>
  <td colspan=16 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl92 height=20 style='height:15.0pt'>
  <td height=20 class=xl92 style='height:15.0pt'>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl92 colspan=10 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>                   </span>Ngày<span
  style='mso-spacerun:yes'>              </span>tháng<span
  style='mso-spacerun:yes'>                 </span>n&#259;m<span
  style='mso-spacerun:yes'>                                                                             
  </span>Ngày<span style='mso-spacerun:yes'>            </span>tháng<span
  style='mso-spacerun:yes'>              </span>n&#259;m 2011</td>
  <td colspan=2 class=xl113 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=9 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl92 height=20 style='height:15.0pt'>
  <td height=20 class=xl92 style='height:15.0pt'>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl92 colspan=11 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>                </span>Cán b&#7897; thu<span
  style='mso-spacerun:yes'>                              </span>Giám
  &#272;&#7889;c BHXH<span style='mso-spacerun:yes'>                           
  </span>Ng&#432;&#7901;i l&#7853;p bi&#7875;u<span
  style='mso-spacerun:yes'>                             
  </span>Ng&#432;&#7901;i s&#7917; d&#7909;ng lao &#273;&#7897;ng</td>
  <td class=xl113>&nbsp;</td>
  <td class=xl105>&nbsp;</td>
  <td colspan=8 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl92 height=20 style='height:15.0pt'>
  <td height=20 class=xl92 style='height:15.0pt'>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td colspan=4 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl106>&nbsp;</td>
  <td colspan=16 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl92 height=20 style='height:15.0pt'>
  <td height=20 class=xl92 style='height:15.0pt'>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td colspan=4 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl106>&nbsp;</td>
  <td colspan=16 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl92 height=20 style='height:15.0pt'>
  <td height=20 class=xl92 style='height:15.0pt'>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td colspan=4 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl106>&nbsp;</td>
  <td colspan=16 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl92 height=20 style='height:15.0pt'>
  <td height=20 class=xl92 style='height:15.0pt'>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td colspan=4 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl106>&nbsp;</td>
  <td colspan=16 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl92 height=9 style='mso-height-source:userset;height:6.75pt'>
  <td height=9 class=xl92 style='height:6.75pt'>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td colspan=4 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl106>&nbsp;</td>
  <td colspan=16 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl92 height=20 style='height:15.0pt'>
  <td height=20 class=xl92 style='height:15.0pt'>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td colspan=4 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl106>&nbsp;</td>
  <td colspan=3 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl92><span style='mso-spacerun:yes'>                            
  </span><span style='display:none'><span
  style='mso-spacerun:yes'>                                                                                         </span>KWON
  GI SOO</span></td>
  <td class=xl115 colspan=2 style='mso-ignore:colspan'>KIM CHI HYUNG</td>
  <td colspan=10 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl92 height=20 style='height:15.0pt'>
  <td height=20 class=xl92 style='height:15.0pt'>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td colspan=4 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl106>&nbsp;</td>
  <td colspan=16 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl92 height=20 style='height:15.0pt'>
  <td height=20 colspan=5 class=xl92 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl106>&nbsp;</td>
  <td colspan=17 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl92 height=20 style='height:15.0pt'>
  <td height=20 colspan=5 class=xl92 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl106>&nbsp;</td>
  <td colspan=17 class=xl92 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=40 style='width:30pt'></td>
  <td width=0></td>
  <td width=153 style='width:115pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=17 style='width:13pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=35 style='width:26pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=80 style='width:60pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
