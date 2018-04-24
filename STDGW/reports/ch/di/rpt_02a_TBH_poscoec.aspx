﻿<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    
    string p_times, p_rpt_month;

    p_times = Request["l_times"].ToString();
    p_rpt_month = Request["l_rpt_month"].ToString();
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
	= "SELECT A.EMP_ID as c1  " + 
        ",A.FULL_NAME  c2  " +
        ",A.SO_BHXH c3  " +
        ",A.SO_BHYT  c4  " +
        ",DECODE(LENGTH(A.BIRTH_DT),4,A.BIRTH_DT,TO_CHAR(TO_DATE(A.BIRTH_DT,'YYYYMMDD'),'DD/MM/YYYY')) AS NGAYSINH5   " +
        ",DECODE(A.SEX,'F','X','') AS SEXc6  " +
        ",A.SO_CMT c7  " +
        ",A.ADDRESS c8  " +
        ",(SELECT v.Char_1 FROM VHR_HR_CODE V WHERE V.ID='HR0012' AND V.CODE=A.HEALTH_PLACE) AS tinh9  " +
        ",(SELECT CODE_FNM FROM VHR_HR_CODE V WHERE V.ID='HR0012' AND V.CODE=A.HEALTH_PLACE) AS BENHVIEN10  " +
        ",nvl(A.LUONG_MOI,0) c11  " +
        ",'' AS CHUCVUc12  " +
        ",'' AS TNVKc13  " +
        ",'' AS TNNc14  " +
        ",'' AS KHUVUCc15  " +
        ",to_char(to_date(A.TU_THANG,'yyyymm'),'mm/yyyy') c16  " +
        ",nvl(A.DC_TANG_XH,0) c17  " +
        ",nvl(A.DC_TANG_YT,0) c18  " +
        ",nvl(A.DC_TANG_TN,0) c19  " +
        ",decode(nvl(a.tn_yn,'N'),'Y','X','') c20  " +
        ",(select v.code_fnm from vhr_hr_code v where v.id='HR0008' and v.code=nvl(e.pos_type,' ')) " +//21
        ",( select s.contract_no from thr_labour_contract s where s.del_if=0 and s.thr_employee_pk=e.pk and s.contract_times=e.contract_times )"+ //22
        ",( select to_char(to_date(s.begin_contract,'yyyymmdd'),'dd/mm/yyyy') from thr_labour_contract s where s.del_if=0 and s.thr_employee_pk=e.pk and s.contract_times=e.contract_times )" + //23
        ",( select v.code_fnm from thr_labour_contract s,vhr_hr_code v  where v.id='HR0001' and v.code=s.contract_type and  s.del_if=0 and s.thr_employee_pk=e.pk and s.contract_times=e.contract_times )" + //24
        ",A.GHI_CHU c25  " +
		",(SELECT upper(v.code_nm) FROM VHR_HR_CODE V WHERE V.ID='HR0041' AND V.CODE=A.LOAI_BH ) as c26 " +
        "FROM THR_INSURANCE_MANAGE A,thr_employee e  " +
        "WHERE A.DEL_IF=0 AND A.THANG_BC='" + p_rpt_month + "' " +
        " and e.del_if=0 and e.pk=a.thr_emp_pk " +
            "AND A.LOAI_BH in (" + ins_type + ") " +
        "AND A.LAN_BAO='" + p_times + "' " +
        "ORDER BY loai_BH,A.EMP_ID " ;

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

    SQL
    = "select  " +
        "sum(nvl(a.CL_TANG_XH,0)*(nvl(SOCIAL_RATE,0)+nvl(SOCIAL_com_RATE,0))/100)  as c3txh7 " +
        ",sum(nvl(a.CL_TANG_YT,0)*(nvl(HEALTH_RATE,0)+nvl(HEALTH_com_RATE,0))/100)  as c3tyt9 " +
        ",sum(nvl(a.CL_TANG_TN,0)*(nvl(UNEMP_RATE,0)+nvl(UNEMP_com_RATE,0))/100)  as c3ttn17 " +
         " FROM THR_INSURANCE_MANAGE A " +
        " WHERE A.DEL_IF=0 AND A.THANG_BC='" + p_rpt_month + "' " +
        " AND A.LOAI_BH in (" + ins_type + ") " +
        " AND A.LAN_BAO='" + p_times + "' ";
    DataTable dt_sum = ESysLib.TableReadOpen(SQL);
    
    %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_02a_TBH_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_02a_TBH_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_02a_TBH_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>User</o:Author>
  <o:LastAuthor>User</o:LastAuthor>
  <o:LastPrinted>2008-10-28T03:18:55Z</o:LastPrinted>
  <o:Created>2008-08-14T06:14:40Z</o:Created>
  <o:LastSaved>2008-10-28T04:21:47Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.43in 0in 0in .21in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style26
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
.style38
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
.xl41
	{mso-style-parent:style26;
	font-size:16.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style26;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;}
.xl46
	{mso-style-parent:style26;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;}
.xl47
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:top;}
.xl48
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl49
	{mso-style-parent:style26;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl50
	{mso-style-parent:style26;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Scientific;}
.xl51
	{mso-style-parent:style26;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style26;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl54
	{mso-style-parent:style26;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;}
.xl55
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl56
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl57
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl59
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl60
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl61
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl62
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl63
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;}
.xl64
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl65
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style26;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl67
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl68
	{mso-style-parent:style26;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl69
	{mso-style-parent:style0;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;}
.xl70
	{mso-style-parent:style0;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl71
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl72
	{mso-style-parent:style26;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl75
	{mso-style-parent:style26;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl76
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl78
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl79
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl80
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl81
	{mso-style-parent:style26;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl82
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl84
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl85
	{mso-style-parent:style0;
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
.xl86
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl88
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl89
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl90
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl91
	{mso-style-parent:style26;
	color:red;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl92
	{mso-style-parent:style26;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl93
	{mso-style-parent:style38;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl94
	{mso-style-parent:style26;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl95
	{mso-style-parent:style26;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl96
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl97
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl98
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center-across;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl99
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl100
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl101
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl102
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	border:.5pt solid windowtext;}
.xl103
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl104
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl105
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl106
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl107
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl108
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl109
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl110
	{mso-style-parent:style26;
	color:red;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl111
	{mso-style-parent:style26;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl112
	{mso-style-parent:style38;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl113
	{mso-style-parent:style26;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl114
	{mso-style-parent:style26;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl115
	{mso-style-parent:style26;
	color:red;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl116
	{mso-style-parent:style26;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl117
	{mso-style-parent:style26;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl118
	{mso-style-parent:style38;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl119
	{mso-style-parent:style26;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl120
	{mso-style-parent:style26;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl121
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl122
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl123
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl124
	{mso-style-parent:style26;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl125
	{mso-style-parent:style26;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl126
	{mso-style-parent:style26;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl127
	{mso-style-parent:style26;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl128
	{mso-style-parent:style26;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl129
	{mso-style-parent:style26;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl130
	{mso-style-parent:style0;
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
.xl131
	{mso-style-parent:style0;
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
.xl132
	{mso-style-parent:style0;
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
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>02a-TBH</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>75</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>7</x:SplitHorizontal>
     <x:TopRowBottomPane>7</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>3</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9345</x:WindowHeight>
  <x:WindowWidth>15180</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:SupBook>
  <x:Path>\My Documents\VietHung\Luu_DL\Luu02\SuaQ§Thu\Gui PT.xls</x:Path>
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
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl48>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1370 style='border-collapse:
 collapse;table-layout:fixed;width:1032pt'>
 <col class=xl56 width=25 style='mso-width-source:userset;mso-width-alt:914;
 width:19pt'>
 
 <col class=xl48 width=138 style='mso-width-source:userset;mso-width-alt:6946;
 width:104pt'>
 <col class=xl48 width=81 span=1 style='mso-width-source:userset;mso-width-alt:
 2962;width:61pt'>
 <col class=xl48 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 <col class=xl48 width=27 style='mso-width-source:userset;mso-width-alt:987;
 width:20pt'>
 
 <col class=xl48 width=185 style='mso-width-source:userset;mso-width-alt:6765;
 width:139pt'>
 <col class=xl48 width=58 style='mso-width-source:userset;mso-width-alt:2121;
 width:44pt'>
 <col class=xl48 width=146 style='mso-width-source:userset;mso-width-alt:5339;
 width:110pt'>
 <col class=xl48 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl48 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl48 width=38 span=4 style='mso-width-source:userset;mso-width-alt:
 1389;width:29pt'>
 
 <col class=xl48 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 
 <col class=xl48 width=55 style='mso-width-source:userset;mso-width-alt:4011;
 width:41pt'>
 <col class=xl48 width=60 style='mso-width-source:userset;mso-width-alt:3594;
 width:45pt'>
 <col class=xl48 width=60 style='mso-width-source:userset;mso-width-alt:3194;
 width:45pt'>
 <col class=xl48 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 
 <tr class=xl43 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl81 width=25 style='height:17.25pt;width:19pt'>Tên<span
  style='display:none'> đơn vị: <%=dt_name.Rows[0][0].ToString() %></span></td>
  <td width=55 style='width:41pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1040" style='position:absolute;z-index:10' from="35.25pt,0"
   to="41.25pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1025" style='position:absolute;z-index:1'
   from="77.25pt,0" to="294.75pt,0" strokecolor="windowText [64]"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1026" style='position:absolute;z-index:2'
   from="77.25pt,0" to="293.25pt,0" strokecolor="windowText [64]"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1027" style='position:absolute;flip:y;z-index:3'
   from="78.75pt,0" to="292.5pt,0" strokecolor="windowText [64]"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1032" style='position:absolute;z-index:8'
   from="76.5pt,0" to="120pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1033" style='position:absolute;z-index:9'
   from="236.25pt,0" to="294.75pt,0" strokecolor="windowText [64]"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  relative;z-index:10'><span style='position:absolute;left:46px;top:-1px;
  width:348px;height:2px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=10></td>
    <td width=45></td>
    <td width=293></td>
   </tr>
   <tr>
    <td height=2></td>
    <td align=left valign=top><img width=10 height=2
    src="rpt_02a_TBH_files/image001.gif" v:shapes="_x0000_s1040"></td>
    <td></td>
    <td align=left valign=top><img width=293 height=2
    src="rpt_02a_TBH_files/image002.gif" v:shapes="_x0000_s1025 _x0000_s1026 _x0000_s1027 _x0000_s1032 _x0000_s1033"></td>
   </tr>
  </table>
  </span></span><![endif]><span style='mso-ignore:vglayout2'><table cellpadding=0 cellspacing=0>
   <tr>
    <td height=23 class=xl42 width=55 style='height:17.25pt;width:41pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl42 width=138 style='width:104pt'></td>
  
  <td  colspan =10 class=xl75 width=185 style='width:139pt'>DANH SÁCH LAO ĐỘNG THAM GIA
  BHXH, BHYT, BHTN</td>
  <td width=72 style='width:54pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1028" style='position:absolute;flip:x y;z-index:4' from="54pt,0"
   to="82.5pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1029" style='position:absolute;flip:x;z-index:5'
   from="54pt,0" to="82.5pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1030" style='position:absolute;flip:x;z-index:6'
   from="54pt,0" to="82.5pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1031" style='position:absolute;flip:x;z-index:7'
   from="54pt,0" to="82.5pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  relative;z-index:4'><span style='position:absolute;left:71px;top:-1px;
  width:40px;height:2px'><img width=40 height=2
  src="rpt_02a_TBH_files/image003.gif" v:shapes="_x0000_s1028 _x0000_s1029 _x0000_s1030 _x0000_s1031"></span></span><![endif]><span
  style='mso-ignore:vglayout2'><table cellpadding=0 cellspacing=0>
   <tr>
    <td height=23 class=xl41 width=72 style='height:17.25pt;width:54pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl73 width=38 style='width:29pt'>Mẫu số: 02a-TBH</td>

 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl81 colspan=3 style='height:17.25pt;mso-ignore:colspan'>Mã
  đơn vị: <%=dt_name.Rows[1][0].ToString() %></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl45></td>
  <td class=xl46></td>
  
  <td class=xl78 colspan=4>Số:..........Tháng <%=p_rpt_month.Substring(4,2) %> Năm <%=p_rpt_month.Substring(0,4) %> </td>
 
  <td class=xl46></td>
  <td class=xl47></td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
  <td class=xl74>Ban hành kèm theo CV số 1615/BHXH-</td>
 
 </tr>
 <tr class=xl52 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl81 colspan=3 style='height:17.25pt;mso-ignore:colspan'>Địa
  chỉ: <%=dt_name.Rows[2][0].ToString() %></td>
  <td class=xl50></td>
  <td colspan=2 class=xl49 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl51 style='mso-ignore:colspan'></td>
  <td class=xl50></td>
  <td colspan=3 class=xl52 style='mso-ignore:colspan'></td>
  <td class=xl73>CSXH ngày 02/06/2009 của BHXH VN</td>
  
 </tr>
 <tr class=xl43 height=21 style='height:15.75pt'>
  <td height=21 class=xl72 style='height:15.75pt'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td class=xl43></td>
  <td colspan=2 class=xl54 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl53></td>
  <td colspan=6 class=xl43 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl84 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td rowspan=2 height=83 class=xl82 width=25 style='height:62.25pt;width:19pt'>Số
  <br>
    TT</td>
  <td rowspan=2 class=xl130 width=138 style='border-bottom:.5pt solid black;
  width:104pt'>Họ và tên</td>
  <td rowspan=2 class=xl82 width=81 style='width:61pt'>Mã số</td>
  

  <td rowspan=2 class=xl130 width=69 style='border-bottom:.5pt solid black;
  width:52pt'>Ngày, tháng, <br>
    năm sinh</td>
  <td rowspan=2 class=xl130 width=27 style='border-bottom:.5pt solid black;
  width:20pt'>Nữ <br>
    (X)</td>
  <td rowspan=2 class=xl82 width=185 style='width:139pt'>Địa chỉ</td>
  <td colspan=2 class=xl82 width=204 style='border-left:none;width:154pt'>Nơi
  đăng ký KCB ban đầu</td>
  <td rowspan=2 class=xl130 width=72 style='border-bottom:.5pt solid black;
  width:54pt'>Chức vụ </td>
  <td rowspan=2 class=xl130 width=72 style='border-bottom:.5pt solid black;
  width:54pt'>Tiền lương, tiền công</td>
  <td class=xl83 align=center width=38 style='border-left:none;width:29pt'>Phụ
  cấp</td>
  <td class=xl83 width=38 style='border-left:none;width:29pt'>&nbsp;</td>
  <td class=xl83 width=38 style='border-left:none;width:29pt'>&nbsp;</td>
  <td class=xl83 width=38 style='border-left:none;width:29pt'>&nbsp;</td>
  <td rowspan=2 class=xl130 width=69 style='border-bottom:.5pt solid black;
  width:52pt'>Đóng từ tháng, năm</td>
  <td colspan=3 class=xl131 width=115 style='border-right:.5pt solid black;
  border-left:none;width:86pt'>Quyết định hoặc HDLD, HDLV</td>
  <td rowspan=2 class=xl131 width=115 style='border-right:.5pt solid black;
  border-left:none;width:86pt'>Ghi Chú</td>
 </tr>
 <tr class=xl84 height=57 style='mso-height-source:userset;height:42.75pt'>
  <td height=57 class=xl82 width=58 style='height:42.75pt;border-top:none;
  border-left:none;width:44pt'>Tỉnh</td>
  <td class=xl82 width=146 style='border-top:none;border-left:none;width:110pt'>Bệnh
  viện</td>
  <td class=xl82 width=38 style='border-top:none;border-left:none;width:29pt'>Chức
  vụ</td>
  <td class=xl82 width=38 style='border-top:none;border-left:none;width:29pt'>Thâm
  niên VK</td>
  <td class=xl82 width=38 style='border-top:none;border-left:none;width:29pt'>Thâm
  niên nghề</td>
  <td class=xl82 width=38 style='border-top:none;border-left:none;width:29pt'>Khác
  </td>
  <td class=xl85 width=55 style='border-left:none;width:41pt'>Số</td>
  <td class=xl85 width=60 style='border-left:none;width:45pt'>Ngày/tháng/năm</td>
  <td class=xl85 width=60 style='border-left:none;width:45pt'>Loại</td>
 </tr>
 <tr class=xl55 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl86 style='height:18.0pt;border-top:none' x:str="'1">1</td>
  
  <td class=xl86 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl86 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl86 style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl86 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl86 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl86 style='border-top:none;border-left:none' x:num>7</td>
  <td class=xl86 style='border-top:none;border-left:none' x:num>8</td>
  <td class=xl86 style='border-top:none;border-left:none' x:num>9</td>
  <td class=xl86 style='border-top:none;border-left:none' x:num>10</td>
  <td class=xl86 style='border-top:none;border-left:none' x:num>11</td>
  <td class=xl86 style='border-top:none;border-left:none' x:num>12</td>
  <td class=xl86 style='border-top:none;border-left:none' x:num>13</td>
  <td class=xl86 style='border-top:none;border-left:none' x:num>14</td>
  <td class=xl86 style='border-top:none;border-left:none' x:num>15</td>
  <td class=xl86 style='border-top:none;border-left:none' x:num>16</td>
  <td class=xl86 style='border-top:none;border-left:none' x:num>17</td>
  <td class=xl86 style='border-top:none;border-left:none' x:num>18</td>
  <td class=xl86 style='border-top:none;border-left:none' x:num>19</td>
 </tr>
 <%
    
     Double dtongthunhap, dtongdctBHXH, dtongdctBHYT, dtongdctBHTN,dtongthunhap1;
    dtongthunhap=0;
	dtongthunhap1=0;
    dtongdctBHXH=0;
    dtongdctBHYT=0;
    dtongdctBHTN = 0;
	int idx=0;
	int idx_code=0;
	
	string code_name="";
    for(int i=0;i<irow_emp;i++)
    {
        dtongthunhap+=Double.Parse(dt_Emp.Rows[i][10].ToString());
		dtongthunhap1+=Double.Parse(dt_Emp.Rows[i][10].ToString());
        dtongdctBHXH+=Double.Parse(dt_Emp.Rows[i][16].ToString());
        dtongdctBHYT+=Double.Parse(dt_Emp.Rows[i][17].ToString());
        dtongdctBHTN += Double.Parse(dt_Emp.Rows[i][18].ToString());
	string[] atype=new string[] {"I","II","III","IV","V","VI","VII","VIII","IX","X","XI"};
  %>
  
  <% if(code_name!= dt_Emp.Rows[i][25].ToString())
    { code_name= dt_Emp.Rows[i][25].ToString();
		idx_code++;
  %>
  <tr class=xl96 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl87 style='height:23.25pt' x:str><b><%=atype[idx_code-1] %> </b></td>
  <td class=xl97 colspan=19  style='border-left:none;border-right:none;border-top:none;border-bottom:none' x:str><b><%=code_name%> </b>  </td>
                                                        
 </tr>
  
  <%}%>
 <tr class=xl96 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl87 style='height:23.25pt' x:num><%=++idx %> </td>
  
  <td class=xl97 style='border-left:none' x:str><%=dt_Emp.Rows[i][1].ToString()%> 
  <span style='mso-spacerun:yes'>  &nbsp;&nbsp;</span></td>
  <td class=xl90 style='border-left:none'><%=dt_Emp.Rows[i][2].ToString()%> </td>
  
  <td class=xl89 style='border-left:none'><%=dt_Emp.Rows[i][4].ToString()%></td>
  <td class=xl87 style='border-left:none'><%=dt_Emp.Rows[i][5].ToString()%></td>
  
  <td class=xl88 style='border-left:none'><%=dt_Emp.Rows[i][7].ToString()%></td>
  <td class=xl87 style='border-left:none'><%=dt_Emp.Rows[i][8].ToString()%></td>
  <td class=xl88 style='border-left:none'><%=dt_Emp.Rows[i][9].ToString()%></td>
  <td class=xl88 style='border-left:none' x:str><%=dt_Emp.Rows[i][20].ToString()%></td>
  <td class=xl91 style='border-left:none' x:num><%=dt_Emp.Rows[i][10].ToString()%></td>
  <td class=xl92 style='border-left:none'><%=dt_Emp.Rows[i][11].ToString()%></td>
  <td class=xl93 style='border-left:none'><%=dt_Emp.Rows[i][12].ToString()%></td>
  <td class=xl93 style='border-left:none'><%=dt_Emp.Rows[i][13].ToString()%></td>
  <td class=xl92 style='border-left:none'><%=dt_Emp.Rows[i][14].ToString()%></td>
  
  <td class=xl94 style='border-left:none'><%=dt_Emp.Rows[i][15].ToString()%></td>
  
  <td class=xl95 style='border-left:none' x:str><%=dt_Emp.Rows[i][21].ToString()%></td>
  <td class=xl95 style='border-left:none' x:str><%=dt_Emp.Rows[i][22].ToString()%></td>
  <td class=xl95 style='border-left:none' x:str><%=dt_Emp.Rows[i][23].ToString()%></td>                                                    
  <td class=xl95 style='border-left:none' x:str><%=dt_Emp.Rows[i][24].ToString()%></td>                                                    
                                                        
 </tr>
 
 
<% if(dt_Emp.Rows.Count-1==i||code_name!= dt_Emp.Rows[i+1][25].ToString()) {%>
 <tr class=xl96 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=9 height=31 class=xl121 style='border-right:.5pt solid black;
  height:23.25pt'>Tổng cộng</td>
  <td class=xl115 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> &nbsp;</span><%=dtongthunhap1 %> </td>
  <td class=xl117 style='border-left:none'>&nbsp;</td>
  <td class=xl118>&nbsp;</td>
  <td class=xl118>&nbsp;</td>
  <td class=xl119>&nbsp;</td>
  <td class=xl120>&nbsp;</td>
  <td class=xl120>&nbsp;</td>
  <td class=xl120>&nbsp;</td>
  <td class=xl116 style='border-left:none' ><span
  style='mso-spacerun:yes'> &nbsp;</span></td>
  <td class=xl116 style='border-left:none' ><span
  style='mso-spacerun:yes'> &nbsp;</span></td>
 </tr>
 <%
 dtongthunhap1=0;
 idx=0;
 }%>
 <%} %>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl56 style='height:18.0pt'></td>
  <td colspan=18 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl56 style='height:18.0pt'></td>
  <td colspan=3 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl57 style='mso-ignore:colspan'></td>
  <td class=xl76>TỔNG HỢP CHUNG</td>
  <td class=xl58></td>
  <td class=xl59></td>
  <td colspan=9 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl56 style='height:18.0pt'></td>
  <td class=xl98 align=center width=58 style='width:44pt'>Phát sinh tăng</td>
  <td class=xl100 colspan=3 align=center width=72 style='border-left:none;width:54pt'>Bảo
  hiểm xã hội</td>
  <td class=xl100  align=center width=38 style='border-left:none;width:29pt'>Bảo
  hiểm y tế</td>
  <td class=xl100 colspan=2 align=center width=38 style='border-left:none;width:29pt'>BH Thất nghiệp</td>
  
  <td colspan=2 class=xl60 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl48 style='mso-ignore:colspan'></td>
  
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  
  <td height=24 class=xl56 style='height:18.0pt'></td>
  <td class=xl103 colspan=1 style='mso-ignore:colspan;border-right:.5pt solid black'>1.
  Số lao động</td>
  <td colspan=3 class=xl127 style='border-right:.5pt solid black;border-left:
  none' x:num><%=irow_emp %></td>
  <td colspan=1 class=xl127 style='border-right:.5pt solid black;border-left:
  none' x:num><%=irow_emp %></td>
  <td colspan=2 class=xl127 style='border-right:.5pt solid black;border-left:
  none' x:num><%=irow_emp %></td>
  
  <td class=xl61 colspan=7 style='mso-ignore:colspan'
  x:str="'- Mã số đã cấp :................................ số, Từ số:................................ Đến số:................................">-
  Mã số đã cấp :................................ số, Từ
  số:................................ Đến số:................................</td>
  <td class=xl48></td>
  
  
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl56 style='height:18.0pt'></td>
  <td class=xl103 colspan=1 style='mso-ignore:colspan;border-right:.5pt solid black'>2.
  Quỹ lương tham gia</td>
  <td colspan=3 class=xl124 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dtongthunhap %></td>
  <td colspan=1 class=xl124 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dtongthunhap %></td>
   <td colspan=2 class=xl124 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dtongthunhap %></td>
  <td class=xl61 colspan=7 style='mso-ignore:colspan'
  x:str>-
  Tổng số tờ khai ........................... tờ.</td>
  <td class=xl48></td>
  
  
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl56 style='height:18.0pt'></td>
  <td class=xl103 colspan=1 style='mso-ignore:colspan;border-right:.5pt solid black'>3.
  Số phải đóng</td>
  <td colspan=3 class=xl124 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dt_sum.Rows[0][0].ToString()%></td>
  <td colspan=1 class=xl124 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dt_sum.Rows[0][1].ToString()%></td>
  <td colspan=2 class=xl124 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dt_sum.Rows[0][2].ToString()%></td>
  <td class=xl61 colspan=7 style='mso-ignore:colspan'
  x:str="'- Số thẻ BHYT được cấp:.............................. thẻ, trong đó cấp ngoại tỉnh:........................................ thẻ.">-
  Số thẻ BHYT được cấp:.............................. thẻ, trong đó cấp ngoại
  tỉnh:........................................ thẻ.</td>
  <td class=xl48></td>
  
  
 </tr>
 
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl56 style='height:18.0pt'></td>
  <td class=xl103 colspan=1 style='mso-ignore:colspan;border-right:.5pt solid black'><i>Trong đó:</i>Số tiền để lại đơn vị</td>
  <td colspan=3 class=xl124 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dtongthunhap*0.02 %></td>
  <td colspan=1 class=xl124 style='border-right:.5pt solid black;border-left:
  none' x:num></td>
  <td colspan=2 class=xl124 style='border-right:.5pt solid black;border-left:
  none' x:num></td>
  <td class=xl48 colspan=7 style='mso-ignore:colspan'
  x:str="'- Thời hạn sử dụng của thẻ BHYT: Từ ngày ____/____/_______ Đến ngày ____/____/_______">-
  Thời hạn sử dụng của thẻ BHYT: Từ ngày ____/____/_______ Đến ngày
  ____/____/_______</td>
 
 
  <td class=xl48></td>
  
  
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl56 style='height:18.0pt'></td>
  <td class=xl103 colspan=1 style='mso-ignore:colspan;border-right:.5pt solid black'>4.
  Điều chỉnh số phải đóng</td>
  <td colspan=3 class=xl124 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dtongdctBHXH %></td>
  <td colspan=1 class=xl124 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dtongdctBHYT %></td>
  <td colspan=2 class=xl124 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dtongdctBHTN %></td>
  <td colspan=8 class=xl48 style='mso-ignore:colspan'></td>
  
 </tr>
 
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl56 style='height:12.75pt'></td>
  <td colspan=8 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl61></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl62></td>
  <td class=xl63></td>
  <td colspan=3 class=xl62 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 
 <tr class=xl70 height=17 style='height:12.75pt'>
  <td height=17 class=xl69 style='height:12.75pt'></td>
  <td colspan=11 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl77 height=23 style='mso-height-source:userset;height:17.25pt'>
  
  <td colspan=5 class=xl77 style="mso-ignore:colspan; height: 17pt;"></td>
  <td class=xl74 style="height: 17pt">Ngày..... tháng...... năm..........</td>
  <td colspan=10 class=xl77 style="mso-ignore:colspan; height: 17pt;"></td>
  <td class=xl74 style="height: 17pt">Ngày <%=dt_name.Rows[0][1].ToString().Substring(0,2) %> tháng <%=dt_name.Rows[0][1].ToString().Substring(3,2) %> năm <%=dt_name.Rows[0][1].ToString().Substring(6,4) %></td>
  <td colspan=4 class=xl77 style="mso-ignore:colspan; height: 17pt;"></td>
 </tr>
 <tr class=xl80 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl78 style='height:21.75pt'></td>
  
  <td colspan=1 class=xl79>Cán bộ thu</td>
  <td colspan=3 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl79>Phụ trách thu</td>
  <td colspan=4 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl79>Người lập biểu</td>
  <td colspan=5 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl79>Người sử dụng lao động</td>
  <td colspan=4 class=xl80 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl80 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl78 style='height:21.75pt'></td>
  
  <td colspan=1 class=xl79><i>(Ký ghi rõ họ tên)</i></td>
  <td colspan=3 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl79><i>(Ký và đóng dấu)</i></td>
  <td colspan=4 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl79><i>(Ký ghi rõ họ tên)</i></td>
  <td colspan=5 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl79><i>(Ký và đóng dấu)</i></td>
  <td colspan=4 class=xl80 style='mso-ignore:colspan'></td>
 </tr>
 
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl56 style='height:12.75pt'></td>
  <td colspan=11 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl56 style='height:12.75pt'></td>
  <td colspan=18 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl56 style='height:12.75pt'></td>
  <td colspan=18 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl56 style='height:12.75pt'></td>
  <td colspan=18 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl56 style='height:12.75pt'></td>
  <td colspan=18 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl56 style='height:12.75pt'></td>
  <td colspan=18 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl80 height=29 style='mso-height-source:userset;height:21.75pt'>
  
  <td class=xl79></td>
  <td class=xl79 colspan=1> <%=dt_name.Rows[3][0].ToString() %></td>
  <td colspan=3 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl79><%=dt_name.Rows[4][0].ToString() %></td>
  <td colspan=4 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl79><%=dt_name.Rows[5][0].ToString() %></td>
  <td colspan=5 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl79><%=dt_name.Rows[6][0].ToString() %></td>
  <td colspan=4 class=xl80 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl56 style='height:12.75pt'></td>
  <td colspan=18 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl71 colspan=9 style='height:12.75pt;mso-ignore:colspan'>Ghi
  chú: Mẫu 02a-TBH đơn vị sử dụng lập khi tham gia BHXH, BHYT lần đầu hoặc khi
  có lao động tăng mới để cấp thẻ BHYT, sổ BHXH.</td>
  <td colspan=3 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl61></td>
  <td colspan=6 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl56 style='height:12.0pt'></td>
  <td colspan=18 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=25 style='width:19pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=185 style='width:139pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=146 style='width:110pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=60 style='width:45pt'></td>
 </tr>
 <![endif]></table>

</body>

</html>
