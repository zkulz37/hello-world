<%@ Page Language="C#"%>
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
    
    string p_times,p_rpt_month;
     
    p_times       = Request["l_times"].ToString();
    p_rpt_month  = Request["l_rpt_month"].ToString();
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
        ",to_char(to_date(a.TU_THANG,'yyyymm'),'mm/yy') as c18 " +
        ",to_char(to_date(a.DEN_THANG,'yyyymm'),'mm/yy') as c19 " +
        ",a.TY_LE/100 as c20 " +
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
        ",(SELECT D.NUM_1 FROM THR_CODE_MASTER M,THR_CODE_DETAIL D WHERE M.DEL_IF=0 AND D.DEL_IF=0 AND D.THR_CODE_MASTER_PK=M.PK and id='HR0043' and char_1='2008') c34 " +
        ",(select num_1 from vhr_hr_code where id='HR0043' and char_1=substr('" + p_rpt_month + "',1,4)) c35 " +
        ",(select char_4 from vhr_hr_code where id='HR0043' and char_1=substr('" + p_rpt_month + "',1,4)) c36 " +
        "from THR_INSURANCE_MANAGE a, " +
        "(select code,num_1,CHAr_3 from vhr_hr_code where id='HR0041') ins_type " +
        "where a.del_if=0 and a.LOAI_BH=ins_type.code and a.loai_bh  not in(" + ins_type + ")" +
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
        ",sum(nvl(a.CL_TANG_XH,0))*20/100  as c3txh7 " +
        ",sum(nvl(a.CL_GIAM_XH,0))*20/100 as c3gxh8 " +
        ",sum(nvl(a.CL_TANG_YT,0))*3/100  as c3tyt9 " +
        ",sum(nvl(a.CL_GIAM_YT,0))*3/100 as c3gyt10 " +
        ",sum(nvl(a.dc_tang_xh,0)) as c4txh11 " +
        ",sum(nvl(a.dc_giam_xh,0)) as c4gxh12 " +
        ",sum(nvl(a.dc_tang_yt,0)) as c4tyt13 " +
        ",sum(nvl(a.dc_giam_yt,0)) as c4gyt14 " +
        ",sum(nvl(a.CL_TANG_TN,0)) as c2ttn15 " +
        ",sum(nvl(a.CL_GIAM_TN,0)) as c2gtn16" +
        ",sum(nvl(a.CL_TANG_TN,0))*2/100  as c3ttn17 " +
        ",sum(nvl(a.CL_GIAM_TN,0))*2/100 as c3gtn18 " +
        ",sum(nvl(a.dc_tang_tn,0)) as c4ttn19 " +
        ",sum(nvl(a.dc_giam_tn,0)) as c4gtn20 " +
        "from thr_insurance_manage a " +
        "where a.del_if=0  " +
        "and a.THANG_BC='" + p_rpt_month + "' " +
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
<link rel=File-List href="rpt_03a_TBH_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_03a_TBH_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_03a_TBH_files/oledata.mso">
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
  <o:LastPrinted>2008-10-30T02:35:23Z</o:LastPrinted>
  <o:Created>2008-08-14T06:16:12Z</o:Created>
  <o:LastSaved>2008-10-30T02:55:46Z</o:LastSaved>
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
	margin:.47in .16in 0in .28in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
.font21
	{color:windowtext;
	font-size:12.0pt;
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
	font-size:12.0pt;
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
	font-size:12.0pt;
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
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl42
	{mso-style-parent:style26;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl43
	{mso-style-parent:style26;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;}
.xl46
	{mso-style-parent:style26;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;
	white-space:normal;}
.xl47
	{mso-style-parent:style26;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center-across;}
.xl48
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:top;
	white-space:normal;}
.xl49
	{mso-style-parent:style26;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl50
	{mso-style-parent:style26;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl53
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl54
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl56
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl59
	{mso-style-parent:style26;
	color:red;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl60
	{mso-style-parent:style26;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl61
	{mso-style-parent:style38;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;}
.xl62
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;}
.xl63
	{mso-style-parent:style38;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;}
.xl64
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl65
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl77
	{mso-style-parent:style0;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl78
	{mso-style-parent:style26;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl79
	{mso-style-parent:style26;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl80
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";}
.xl81
	{mso-style-parent:style26;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl82
	{mso-style-parent:style26;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl83
	{mso-style-parent:style26;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl84
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl86
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl87
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl88
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl89
	{mso-style-parent:style26;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl90
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl91
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl92
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl93
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl94
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl95
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl96
	{mso-style-parent:style26;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl97
	{mso-style-parent:style26;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl98
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl99
	{mso-style-parent:style38;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl100
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl101
	{mso-style-parent:style26;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl102
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl103
	{mso-style-parent:style38;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl104
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl105
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl106
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl107
	{mso-style-parent:style26;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl108
	{mso-style-parent:style26;
	color:red;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl109
	{mso-style-parent:style26;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl110
	{mso-style-parent:style38;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl111
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl112
	{mso-style-parent:style38;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl113
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl114
	{mso-style-parent:style26;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl115
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl116
	{mso-style-parent:style38;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl117
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl118
	{mso-style-parent:style26;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl119
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl120
	{mso-style-parent:style38;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl121
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl122
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl123
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl124
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl125
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl126
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl127
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl128
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl129
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl130
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl131
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl132
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl133
	{mso-style-parent:style26;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl134
	{mso-style-parent:style26;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl135
	{mso-style-parent:style26;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl136
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl137
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl138
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl139
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl140
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
.xl141
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
.xl142
	{mso-style-parent:style0;
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
.xl143
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl144
	{mso-style-parent:style0;
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
.xl145
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
.xl146
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
.xl147
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl148
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl149
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl150
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl151
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl152
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl153
	{mso-style-parent:style26;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl154
	{mso-style-parent:style26;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl155
	{mso-style-parent:style26;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>03a-TBH</x:Name>
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
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>8</x:SplitHorizontal>
     <x:TopRowBottomPane>8</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>3</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
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
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='03a-TBH'!$4:$8</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl41>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1951 style='border-collapse:
 collapse;table-layout:fixed;width:1467pt'>
 <col class=xl25 width=27 style='mso-width-source:userset;mso-width-alt:987;
 width:20pt'>
  <col class=xl24 width=60 style='mso-width-source:userset;mso-width-alt:2194;
 width:45.13pt'>
 <col class=xl24 width=156 style='mso-width-source:userset;mso-width-alt:5705;
 width:117pt'>
 <col class=xl24 width=117 style='mso-width-source:userset;mso-width-alt:4278;
 width:88pt'>
  <col class=xl24 width=60 style='mso-width-source:userset;mso-width-alt:2194;
 width:45.13pt'>
 <col class=xl26 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl26 width=44 span=4 style='mso-width-source:userset;mso-width-alt:
 1609;width:33pt'>
 <col class=xl26 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl26 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl24 width=44 span=3 style='mso-width-source:userset;mso-width-alt:
 1609;width:33pt'>
 <col class=xl24 width=60 span=2 style='mso-width-source:userset;mso-width-alt:
 2194;width:45pt'>
 <col class=xl24 width=43 style='mso-width-source:userset;mso-width-alt:1572;
 width:32pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl27 width=65 span=2 style='mso-width-source:userset;mso-width-alt:
 2377;width:49pt'>
 <col class=xl28 width=65 span=3 style='mso-width-source:userset;mso-width-alt:
 2377;width:49pt'>
 <col class=xl24 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl24 width=43 style='mso-width-source:userset;mso-width-alt:1572;
 width:32pt'>
 <col class=xl27 width=65 span=2 style='mso-width-source:userset;mso-width-alt:
 2377;width:49pt'>
 <col class=xl28 width=65 span=3 style='mso-width-source:userset;mso-width-alt:
 2377;width:49pt'>
 <col class=xl24 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl83 width=27 style='height:18.0pt;width:20pt'>Tên<span
  style='display:none'> đơn vị:<%=dt_name.Rows[0][0].ToString() %></span></td>
  <td width=156 style='width:117pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1025" style='position:absolute;z-index:1' from="36pt,0" to="233.25pt,0"
   strokecolor="windowText [64]" strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1026" style='position:absolute;z-index:2'
   from="36pt,0" to="231.75pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1027" style='position:absolute;flip:y;z-index:3'
   from="37.5pt,0" to="231pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1032" style='position:absolute;z-index:8'
   from="35.25pt,0" to="78.75pt,0" strokecolor="windowText [64]"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1033" style='position:absolute;z-index:9'
   from="147.75pt,0" to="233.25pt,0" strokecolor="windowText [64]"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1034" style='position:absolute;z-index:10'
   from="36pt,0" to="204.75pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1035" style='position:absolute;z-index:11'
   from="36pt,0" to="204.75pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1036" style='position:absolute;flip:y;z-index:12'
   from="37.5pt,0" to="204.75pt,0" strokecolor="windowText [64]"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1041" style='position:absolute;z-index:17'
   from="35.25pt,0" to="78.75pt,0" strokecolor="windowText [64]"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1042" style='position:absolute;z-index:18'
   from="147.75pt,0" to="204.75pt,0" strokecolor="windowText [64]"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  relative;z-index:1'><span style='position:absolute;left:46px;top:-1px;
  width:266px;height:2px'><img width=266 height=2
  src="rpt_03a_TBH_files/image001.gif" v:shapes="_x0000_s1025 _x0000_s1026 _x0000_s1027 _x0000_s1032 _x0000_s1033 _x0000_s1034 _x0000_s1035 _x0000_s1036 _x0000_s1041 _x0000_s1042"></span></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl41 width=156 style='height:18.0pt;width:117pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl41 width=117 style='width:88pt'></td>
  <td class=xl42 width=78 style='width:59pt'></td>
  <td class=xl42 width=44 style='width:33pt'></td>
  <td class=xl42 width=44 style='width:33pt'></td>
  <td class=xl42 width=44 style='width:33pt'></td>
  <td class=xl43></td>
  <td class=xl89 width=44 style='width:33pt'>DANH SÁCH<span
  style='mso-spacerun:yes'>  </span>ĐIỀU CHỈNH LAO ĐỘNG VÀ MỨC ĐÓNG BHXH, BHYT, BHTN</td>
  <td class=xl43 width=78 style='width:59pt'></td>
  <td class=xl42 width=44 style='width:33pt'></td>
  <td width=44 style='width:33pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1028" style='position:absolute;flip:x y;z-index:4' from="33pt,0"
   to="66pt,0" strokecolor="windowText [64]" strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1029" style='position:absolute;flip:x;z-index:5'
   from="33pt,0" to="66pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1030" style='position:absolute;flip:x;z-index:6'
   from="33pt,0" to="66pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1031" style='position:absolute;flip:x;z-index:7'
   from="33pt,0" to="66pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  relative;z-index:4'><span style='position:absolute;left:43px;top:-1px;
  width:46px;height:2px'><img width=46 height=2
  src="rpt_03a_TBH_files/image002.gif" v:shapes="_x0000_s1028 _x0000_s1029 _x0000_s1030 _x0000_s1031"></span></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl41 width=44 style='height:18.0pt;width:33pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl42 width=44 style='width:33pt'></td>
  <td class=xl42 width=44 style='width:33pt'></td>
  <td class=xl42 width=53 style='width:40pt'></td>
  <td class=xl44 width=53 style='width:40pt'></td>
  <td class=xl44 width=40 style='width:30pt'></td>
  <td class=xl84 width=40 style='width:30pt'>Mẫu số: 03a-TBH</td>
  <td class=xl44 width=40 style='width:30pt'></td>
  <td class=xl44 width=60 style='width:45pt'></td>
  <td class=xl44 width=60 style='width:45pt'></td>
  <td class=xl44 width=60 style='width:45pt'></td>
  <td class=xl44 width=60 style='width:45pt'></td>
  <td  class=xl45 style='border-left:.5pt solid black;border-bottom:.5pt solid black;border-right:.5pt solid black;border-top:.5pt solid black;'>Mức lương trần</td>
  <td  class=xl45 style='border-left:.5pt solid black;border-bottom:.5pt solid black;border-right:.5pt solid black;border-top:.5pt solid black;'>01/10/2006</td>
  <td  class=xl45 style='border-left:.5pt solid black;border-bottom:.5pt solid black;border-right:.5pt solid black;border-top:.5pt solid black;'>01/01/2008</td>
  <td  class=xl45 style='border-left:.5pt solid black;border-bottom:.5pt solid black;border-right:.5pt solid black;border-top:.5pt solid black;'>01/05/2009</td>
  <td  class=xl45 style='border-left:.5pt solid black;border-bottom:.5pt solid black;border-right:.5pt solid black;border-top:.5pt solid black;'>01/07/2009</td>
  
  <td class=xl44 width=60 style='width:45pt'></td>
  <td class=xl44 width=76 style='width:57pt'></td>
  <td width=64 style='width:48pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1037" style='position:absolute;flip:x y;z-index:13' from="48pt,0"
   to="96pt,0" strokecolor="windowText [64]" strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1038" style='position:absolute;flip:x;z-index:14'
   from="48pt,0" to="96pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1039" style='position:absolute;flip:x;z-index:15'
   from="48pt,0" to="96pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1040" style='position:absolute;flip:x;z-index:16'
   from="48pt,0" to="96pt,0" strokecolor="windowText [64]" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  relative;z-index:13'><span style='position:absolute;left:63px;top:-1px;
  width:66px;height:2px'><img width=66 height=2
  src="rpt_03a_TBH_files/image003.gif" v:shapes="_x0000_s1037 _x0000_s1038 _x0000_s1039 _x0000_s1040"></span></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl41 width=64 style='height:18.0pt;width:48pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl41 width=64 style='width:48pt'></td>
  <td class=xl41 width=64 style='width:48pt'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl64  style='height:18.0pt;mso-ignore:colspan'>Mã
  đơn vị: <%=dt_name.Rows[1][0].ToString() %></td>
  <td class=xl45></td>
  <td class=xl45></td>
  <td colspan=3 class=xl46 style='mso-ignore:colspan'></td>
  <td class=xl43></td>
  <td class=xl43></td>
  <td class=xl82 colspan=4>Số:..........Tháng <%=p_rpt_month.Substring(4,2) %> Năm <%=p_rpt_month.Substring(0,4) %> </td>
  <td class=xl47></td>
  <td class=xl47></td>
  <td class=xl46 ></td>
  <td class=xl84 colspan=5 "></td>
  <td  class=xl48 ></td>
  <td  class=xl48 ></td>
  <td  style='border-left:.5pt solid black;border-bottom:.5pt solid black;border-right:.5pt solid black;border-top:.5pt solid black;'>T/g hiện hành</td>
  <td  style='border-left:.5pt solid black;border-bottom:.5pt solid black;border-right:.5pt solid black;border-top:.5pt solid black;'>BHXH, BHTN</td>
  <td  style='border-left:.5pt solid black;border-bottom:.5pt solid black;border-right:.5pt solid black;border-top:.5pt solid black;mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";' x:num>9000000</td>
  <td style='border-left:.5pt solid black;border-bottom:.5pt solid black;border-right:.5pt solid black;border-top:.5pt solid black;mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";' x:num>10800000 </td>
  <td style='border-left:.5pt solid black;border-bottom:.5pt solid black;border-right:.5pt solid black;border-top:.5pt solid black;mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";' x:num>13000000</td>
  <td style='border-left:.5pt solid black;border-bottom:.5pt solid black;border-right:.5pt solid black;border-top:.5pt solid black;mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";' x:num>13000000 </td>
  
  <td  class=xl48 ></td>
  <td  class=xl41 ></td>
  
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl83 colspan=3 style='height:18.0pt;mso-ignore:colspan'>Địa
  chỉ: <%=dt_name.Rows[2][0].ToString() %></td>
  <td colspan=4 class=xl49 style='mso-ignore:colspan'></td>
  <td class=xl50></td>
  <td class=xl43></td>
  <td class=xl49></td>
  <td class=xl41></td>
  <td colspan=3 class=xl49 style='mso-ignore:colspan'></td>
  <td class=xl51></td>
  <td colspan=5 class=xl49 x:str><span
  style='mso-spacerun:yes'> </span><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 style='mso-ignore:colspan'></td>
   <td class=xl52 style='mso-ignore:colspan'></td>
   	
  <td  style='border-left:.5pt solid black;border-bottom:.5pt solid black;border-right:.5pt solid black;border-top:.5pt solid black;'>01/05/2010</td>
  <td  style='border-left:.5pt solid black;border-bottom:.5pt solid black;border-right:.5pt solid black;border-top:.5pt solid black;'>BHYT</td>
  <td  style='border-left:.5pt solid black;border-bottom:.5pt solid black;border-right:.5pt solid black;border-top:.5pt solid black;mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";' x:num>1000000000</td>
  <td style='border-left:.5pt solid black;border-bottom:.5pt solid black;border-right:.5pt solid black;border-top:.5pt solid black;mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";' x:num>1000000000 </td>
  <td style='border-left:.5pt solid black;border-bottom:.5pt solid black;border-right:.5pt solid black;border-top:.5pt solid black;mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";' x:num>1000000000 </td>
  <td style='border-left:.5pt solid black;border-bottom:.5pt solid black;border-right:.5pt solid black;border-top:.5pt solid black;mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";' x:num>13000000 </td>
  
  <td colspan=3 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
 
  <td colspan=3 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl53 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td rowspan=4 height=104 class=xl139 width=27 style='height:78.0pt;
  width:20pt'>Số <br>
    TT</td>
  <td rowspan=4 height=104 class=xl140 width=60 style='height:78.0pt;
  width:45.13pt'>Mã Số </td>
  <td rowspan=4 class=xl140 width=156 style='border-bottom:.5pt solid black;
  width:117pt'>Họ và tên</td>
  <td rowspan=4 class=xl140 width=117 style='border-bottom:.5pt solid black;
  width:88pt'>Số sổ <br>
    BHXH</td>
   <td rowspan=4 class=xl140 width=60 style='border-bottom:.5pt solid black;
  width:45.13pt'>Ngày tháng năm sinh</td>
  <td colspan=10 class=xl141 width=508 style='border-left:none;width:382pt'>Tiền
  lương và phụ cấp</td>
  
  <td colspan=2 rowspan=2 class=xl143 width=106 style='width:80pt'
  x:str="Thời gian ">Thời gian<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=4 class=xl143 width=40 style='width:30pt'>Tỷ lệ nộp bổ sung</td>
  <td rowspan=4 class=xl143 width=40 style='width:30pt'
  >Ghi Chú<span style='mso-spacerun:yes'> </span></td>
  <td colspan=6 rowspan=2 class=xl143 width=106 style='width:80pt'
  x:str>Số phát sinh<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=4 class=xl139 width=396 style='border-left:none;width:297pt'>Số tháng</td>
  <td colspan=6 rowspan=2 class=xl143 width=106 style='width:80pt'
  x:str>Số phải đóng bổ sung<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl53 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=5 height=17 class=xl141 width=254 style='height:12.75pt;
  border-left:none;width:191pt'>Mức cũ</td>
  <td colspan=5 class=xl141 width=254 style='width:191pt'>Mức mới</td>
  
 </tr>
 <tr class=xl53 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td rowspan=2 height=68 class=xl139 width=78 style='height:51.0pt;border-top:
  none;width:59pt'>Tiền lương, tiền công</td>
  <td colspan=4 class=xl141 width=176 style='border-right:.5pt solid black;
  border-left:none;width:132pt'>Phụ cấp</td>
  <td rowspan=2 class=xl139 width=78 style='border-top:none;width:59pt'>Tiền
  lương, tiền công</td>
  <td colspan=4 class=xl141 width=176 style='border-right:.5pt solid black;
  border-left:none;width:132pt'>Phụ cấp</td>
  <td rowspan=2 class=xl139 width=53 style='border-top:none;width:40pt'>Từ
  tháng<br>
    năm</td>
  <td rowspan=2 class=xl139 width=53 style='border-top:none;width:40pt'>Đến
  tháng<br>
    năm</td>
  <td colspan=2 class=xl141 width=176 style='border-right:.5pt solid black;
  border-left:none;width:132pt'>BHXH</td>
  <td colspan=2 class=xl141 width=176 style='border-right:.5pt solid black;
  border-left:none;width:132pt'>BHYT</td>
  <td colspan=2 class=xl141 width=176 style='border-right:.5pt solid black;
  border-left:none;width:132pt'>BHTN</td>
  <td colspan=2 class=xl139 width=120 style='border-left:none;width:90pt'>BHXH</td>
  <td colspan=2 class=xl139 width=120 style='border-left:none;width:90pt'>BHYT</td>
  <td colspan=2 class=xl139 width=120 style='border-left:none;width:90pt'>BHTN</td>
  
 </tr>
 <tr class=xl53 height=51 style='height:38.25pt'>
  <td height=51 class=xl139 width=44 style='height:38.25pt;border-top:none;
  border-left:none;width:33pt'>Chức vụ</td>
  <td class=xl139 width=44 style='border-top:none;border-left:none;width:33pt'>Thâm
  niên VK</td>
  <td class=xl139 width=44 style='border-top:none;border-left:none;width:33pt'>Thâm
  niên nghề</td>
  <td class=xl139 width=44 style='border-top:none;border-left:none;width:33pt'>Khu
  vực</td>
  <td class=xl139 width=44 style='border-top:none;border-left:none;width:33pt'>Chức
  vụ</td>
  <td class=xl139 width=44 style='border-top:none;border-left:none;width:33pt'>Thâm
  niên VK</td>
  <td class=xl139 width=44 style='border-top:none;border-left:none;width:33pt'>Thâm
  niên nghề</td>
  <td class=xl139 width=44 style='border-top:none;border-left:none;width:33pt'>Khu
  vực</td>
  <td class=xl139 width=60 style='border-top:none;border-left:none;width:45pt'>Tăng</td>
  <td class=xl139 width=60 style='border-top:none;border-left:none;width:45pt'>Giảm</td>
  <td class=xl139 width=60 style='border-top:none;border-left:none;width:45pt'>Tăng</td>
  <td class=xl139 width=60 style='border-top:none;border-left:none;width:45pt'>Giảm</td>
  <td class=xl139 width=60 style='border-top:none;border-left:none;width:45pt'>Tăng</td>
  <td class=xl139 width=60 style='border-top:none;border-left:none;width:45pt'>Giảm</td>
  <td class=xl139 width=60 style='border-top:none;border-left:none;width:45pt'>Tăng</td>
  <td class=xl139 width=60 style='border-top:none;border-left:none;width:45pt'>Giảm</td>
  <td class=xl139 width=60 style='border-top:none;border-left:none;width:45pt'>Tăng</td>
  <td class=xl139 width=60 style='border-top:none;width:45pt'>Giảm</td>
  <td class=xl139 width=60 style='border-top:none;width:45pt'>Tăng</td>
  <td class=xl139 width=60 style='border-top:none;;width:45pt'>Giảm</td>
 </tr>
 <tr class=xl53 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl54 style='height:19.5pt;border-top:none' >1</td>
  <td height=26 class=xl54 style='height:19.5pt' ></td>
  <td class=xl54 style='border-top:none;border-left:none' >2</td>
  <td class=xl54 style='border-top:none;border-left:none' >3</td>
  <td class=xl54 style='border-top:none;border-left:none' >4</td>
  <td class=xl54 style='border-top:none;border-left:none' >5</td>
  <td class=xl54 style='border-top:none;border-left:none' >6</td>
  <td class=xl54 style='border-top:none;border-left:none' >7</td>
  <td class=xl54 style='border-top:none;border-left:none' >8</td>
  <td class=xl54 style='border-top:none;border-left:none' >9</td>
  <td class=xl54 style='border-top:none;border-left:none' >10</td>
  <td class=xl54 style='border-top:none;border-left:none' >11</td>
  <td class=xl54 style='border-top:none;border-left:none' >12</td>
  <td class=xl54 style='border-top:none;border-left:none' >13</td>
  <td class=xl54 style='border-top:none;border-left:none' >14</td>
  <td class=xl54 style='border-top:none;border-left:none' >15</td>
  <td class=xl54 style='border-top:none;border-left:none' >16</td>
  <td class=xl54 style='border-top:none;border-left:none' >17</td>
  <td class=xl54 style='border-top:none;border-left:none' >18</td>
  <td class=xl54 style='border-top:none;border-left:none' >A</td>
  <td class=xl54 style='border-top:none;border-left:none' >B</td>
  <td class=xl54 style='border-top:none;border-left:none' >C</td>
  <td class=xl54 style='border-top:none;border-left:none' >D</td>
  <td class=xl54 style='border-top:none;border-left:none' >E</td>
  <td class=xl54 style='border-top:none;border-left:none' >F</td>
  <td class=xl54 style='border-top:none;border-left:none' >G</td>
  <td class=xl54 style='border-top:none;border-left:none' >H</td>
  <td class=xl54 style='border-top:none;border-left:none' >I</td>
  <td class=xl54 style='border-top:none;border-left:none' >J</td>
  <td class=xl54 style='border-top:none;border-left:none' >K</td>
  <td class=xl54 style='border-top:none;border-left:none' >L</td>
  <td class=xl54 style='border-top:none;border-left:none' >M</td>
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
 <tr class=xl91 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td  height=26 class=xl136 style='border-right:.5pt solid black;
  height:19.5pt'><%=atype[j]%></td>
  <td colspan=2 height=26 class=xl136 style='border-right:.5pt solid black;
  height:19.5pt'><%=cur_type %></td>
  <td class=xl108 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl109 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl110 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl110 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl109 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl109 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl110 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl110 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl109 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl111 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl111 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl111 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl111 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
     <%     bchange=false;
            j+=1;
        }//ket thuc doi group%>
 
 <tr class=xl92 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl105 style='height:19.5pt' x:num><%=irow_type %></td>
  <td class=xl106 style='border-left:none'><%=dt_Emp.Rows[i][27].ToString() %></td>
  <td class=xl106 style='border-left:none'><%=dt_Emp.Rows[i][1].ToString() %></td>
  <td class=xl107 style='border-left:none' x:num><%=dt_Emp.Rows[i][2].ToString() %></td>
  <td class=xl101 style='border-left:none' ></td>
  <td class=xl101 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][3].ToString() %></td>
  <td class=xl101 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][4].ToString() %></td>
  <td class=xl101 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][5].ToString() %></td>
  <td class=xl101 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][6].ToString() %></td>
  <td class=xl101 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][7].ToString() %></td>
  <td class=xl101 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][8].ToString() %> </td>
  <td class=xl101 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][9].ToString() %></td>
  <td class=xl101 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][10].ToString() %> </td>
  <td class=xl101 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][11].ToString() %></td>
  <td class=xl101 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][12].ToString() %></td>
  
  <td class=xl102 style='border-left:none'><%=dt_Emp.Rows[i][17].ToString() %></td>
  <td class=xl102 style='border-left:none'><%=dt_Emp.Rows[i][18].ToString() %></td>
  <td class=xl103 style='border-left:none' x:num><%=dt_Emp.Rows[i][19].ToString() %></td>
  <td class=xl103 style='border-left:none'><%=dt_Emp.Rows[i][26].ToString() %></td>
  <td class=xl101 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][13].ToString() %></td>
  <td class=xl101 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][14].ToString() %> </td>
  <td class=xl101 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][15].ToString() %></td>
  <td class=xl101 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][16].ToString() %></td>
  <td class=xl101 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][29].ToString() %></td>
  <td class=xl101 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][30].ToString() %></td>
  <td class=xl104 style='border-left:none' x:num><%=dt_Emp.Rows[i][21].ToString() %></td>
  <td class=xl101 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][22].ToString() %></td>
  <td class=xl101 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][23].ToString() %></td>
  <td class=xl101 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][24].ToString() %> </td>
  <td class=xl101 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][25].ToString() %></td>
  <td class=xl101 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][31].ToString() %> </td>
  <td class=xl101 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][32].ToString() %></td>
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
 <tr class=xl122 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=5 height=26 class=xl123 style='border-right:.5pt solid black;
  height:19.5pt'>Tổng cộng</td>
  <td class=xl118 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dLuongCu %> </td>
  <td class=xl118 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl118 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl118 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl118 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl118 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dLuongMoi %> </td>
  <td class=xl118 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span> </td>
  <td class=xl118 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span> </td>
  <td class=xl118 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl118 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span></td>

  <td class=xl119 style='border-left:none'>&nbsp;</td>
  <td class=xl119 style='border-left:none'>&nbsp;</td>
  <td class=xl120 style='border-left:none'>&nbsp;</td>
  <td class=xl120 style='border-left:none'>&nbsp;</td>
   <td class=xl118 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dCLTangXH %></td>
  <td class=xl118 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dCLGiamXH %> </td>
  <td class=xl118 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dCLTangYT %></td>
  <td class=xl118 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dCLGiamYT %> </td>
  <td class=xl118 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dCLTangTN %></td>
  <td class=xl118 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dCLGiamTN %></td>
  <td class=xl121 style='border-left:none'>&nbsp;</td>
  <td class=xl118 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dBSTangXH %></td>
  <td class=xl118 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dBSGiamXH %> </td>
  <td class=xl118 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dBSTangYT %></td>
  <td class=xl118 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dBSGiamYT %> </td>
  <td class=xl118 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dBSTangTN%></td>
  <td class=xl118 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dBSGiamTN %> </td>
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
 <tr class=xl93 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=5 height=26 class=xl126 style='border-right:.5pt solid black;
  height:19.5pt'>Tổng cộng</td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dLuongCuT %> </td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dLuongMoiT %> </td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
 
  <td class=xl115 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl115 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl116 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl116 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dCLTangXHT %> </td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dCLGiamXHT %> </td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dCLTangYTT %>  </td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dCLGiamYTT %> </td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dCLTangTNT %>  </td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dCLGiamTNT %> </td>
  <td class=xl117 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dBSTangXHT %> </td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dBSGiamXHT %> </td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dBSTangYTT %>  </td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dBSGiamYTT %> </td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dBSTangTNT %>  </td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dBSGiamTNT %> </td>
 </tr>
 <tr class=xl56 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl57 style='height:19.5pt'></td>
  <td class=xl58></td>
  <td class=xl57></td>
  <td class=xl59></td>
  <td class=xl60></td>
  <td colspan=2 class=xl61 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl60 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl61 style='mso-ignore:colspan'></td>
  <td class=xl60></td>
  <td colspan=2 class=xl62 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl63 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl55 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl56 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl65 style='height:19.5pt'></td>
  <td class=xl90 colspan=2 style='mso-ignore:colspan' x:str="'* TỔNG HỢP CHUNG:">*
  TỔNG HỢP CHUNG:</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl67></td>
  <td class=xl41></td>
  <td colspan=16 class=xl68 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl69 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl69 style='height:19.5pt'></td>
  <td colspan=2 rowspan=2 class=xl129 width=273 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:205pt'>Phát sinh</td>
  <td class=xl147 align=center width=78 style='border-left:none;width:59pt'>Bảo
  hiểm xã hội</td>
  <td class=xl147 width=44 style='border-left:none;width:33pt'>&nbsp;</td>
  <td class=xl148 width=44 style='border-left:none;width:33pt'>&nbsp;</td>
  <td class=xl147 width=44 style='border-left:none;width:33pt'>&nbsp;</td>
  <td class=xl147 width=44 style='border-left:none;width:33pt'>&nbsp;</td>
  <td class=xl147 align=center width=78 style='border-left:none;width:59pt'>Bảo
  hiểm y tế</td>
  <td class=xl70 style='border-left:none'>&nbsp;</td>
  <td class=xl70 style='border-left:none'>&nbsp;</td>
  <td class=xl70 style='border-left:none'>&nbsp;</td>
  <td class=xl70 style='border-left:none'>&nbsp;</td>
  <td class=xl147 align=center width=78 style='border-left:none;width:59pt'>Bảo
  hiểm thất nghiệp</td>
  <td class=xl70 style='border-left:none'>&nbsp;</td>
  <td class=xl70 style='border-left:none'>&nbsp;</td>
  <td class=xl70 style='border-left:none'>&nbsp;</td>
  <td colspan=8 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl69 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl69 style='height:19.5pt'></td>
  <td colspan=2 class=xl149 width=122 style='border-right:.5pt solid black;
  border-left:none;width:92pt'>Tăng</td>
  <td colspan=3 class=xl149 width=132 style='border-right:.5pt solid black;
  border-left:none;width:99pt'>Giảm</td>
  <td colspan=2 class=xl149 width=122 style='border-right:.5pt solid black;
  border-left:none;width:92pt'>Tăng</td>
  <td colspan=3 class=xl149 width=132 style='border-right:.5pt solid black;
  border-left:none;width:99pt'>Giảm</td>
   <td colspan=2 class=xl149 width=122 style='border-right:.5pt solid black;
  border-left:none;width:92pt'>Tăng</td>
  <td colspan=2 class=xl149 width=132 style='border-right:.5pt solid black;
  border-left:none;width:99pt'>Giảm</td>
  <td colspan=8 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl69 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl69 style='height:19.5pt'></td>
  <td class=xl71 style='border-top:none'>1. Số lao động</td>
  <td class=xl152 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl133 style='border-right:.5pt solid black;border-left:
  none' x:num><span
  style='mso-spacerun:yes'>                                  </span><%=dt_sum.Rows[0][0].ToString()%>  </td>
  <td colspan=3 class=xl133 style='border-right:.5pt solid black;border-left:
  none' x:num><span
  style='mso-spacerun:yes'>                                     </span><%=dt_sum.Rows[0][1].ToString()%></td>
  <td colspan=2 class=xl133 style='border-right:.5pt solid black;border-left:
  none' x:num><span
  style='mso-spacerun:yes'>                                  </span><%=dt_sum.Rows[0][0].ToString()%> </td>
  <td colspan=3 class=xl153 style='border-right:.5pt solid black;border-left:
  none' x:num><span
  style='mso-spacerun:yes'>                                     </span><%=dt_sum.Rows[0][1].ToString()%></td>
  <td colspan=2 class=xl133 style='border-right:.5pt solid black;border-left:
  none' x:num><span
  style='mso-spacerun:yes'>                                  </span><%=dt_sum.Rows[0][0].ToString()%> </td>
  <td colspan=2 class=xl153 style='border-right:.5pt solid black;border-left:
  none' x:num><span
  style='mso-spacerun:yes'>                                     </span><%=dt_sum.Rows[0][1].ToString()%></td>
  <td colspan=8 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl69 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl69 style='height:19.5pt'></td>
  <td class=xl71 style='border-top:none'>2. Quỹ lương</td>
  <td class=xl152 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl133 style='border-right:.5pt solid black;border-left:
  none' x:num><span
  style='mso-spacerun:yes'>                                  </span><%=dt_sum.Rows[0][2].ToString()%></td>
  <td colspan=3 class=xl133 style='border-right:.5pt solid black;border-left:
  none' x:num><span
  style='mso-spacerun:yes'>                                     </span><%=dt_sum.Rows[0][3].ToString()%></td>
  <td colspan=2 class=xl133 style='border-right:.5pt solid black;border-left:
  none' x:num><span
  style='mso-spacerun:yes'>                                  </span><%=dt_sum.Rows[0][4].ToString()%></td>
  <td colspan=3 class=xl153 style='border-right:.5pt solid black;border-left:
  none' x:num><span
  style='mso-spacerun:yes'>                                     </span><%=dt_sum.Rows[0][5].ToString()%></td>
  <td colspan=2 class=xl133 style='border-right:.5pt solid black;border-left:
  none' x:num><span
  style='mso-spacerun:yes'>                                  </span><%=dt_sum.Rows[0][14].ToString()%></td>
  <td colspan=2 class=xl153 style='border-right:.5pt solid black;border-left:
  none' x:num><span
  style='mso-spacerun:yes'>                                     </span><%=dt_sum.Rows[0][15].ToString()%></td>
  <td colspan=8 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl69 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl69 style='height:19.5pt'></td>
  <td class=xl71 style='border-top:none'>3. Số phải nộp</td>
  <td class=xl152 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl133 style='border-right:.5pt solid black;border-left:
  none' x:num><span
  style='mso-spacerun:yes'>                                  </span><%=dt_sum.Rows[0][6].ToString()%></td>
  <td colspan=3 class=xl133 style='border-right:.5pt solid black;border-left:
  none' x:num><span
  style='mso-spacerun:yes'>                                     </span><%=dt_sum.Rows[0][7].ToString()%></td>
  <td colspan=2 class=xl133 style='border-right:.5pt solid black;border-left:
  none' x:num><span
  style='mso-spacerun:yes'>                                  </span><%=dt_sum.Rows[0][8].ToString()%></td>
  <td colspan=3 class=xl153 style='border-right:.5pt solid black;border-left:
  none' x:num><span
  style='mso-spacerun:yes'>                                     </span><%=dt_sum.Rows[0][9].ToString()%></td>
  
  <td colspan=2 class=xl133 style='border-right:.5pt solid black;border-left:
  none' x:num><span
  style='mso-spacerun:yes'>                                  </span><%=dt_sum.Rows[0][16].ToString()%></td>
  <td colspan=2 class=xl153 style='border-right:.5pt solid black;border-left:
  none' x:num><span
  style='mso-spacerun:yes'>                                     </span><%=dt_sum.Rows[0][17].ToString()%></td>
  <td colspan=13 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl69 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl69 style='height:19.5pt'></td>
  <td class=xl71 style='border-top:none'>4. Điều chỉnh số phải nộp</td>
  <td class=xl152 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl133 style='border-right:.5pt solid black;border-left:
  none' x:num><span
  style='mso-spacerun:yes'>                                  </span><%=dt_sum.Rows[0][10].ToString()%></td>
  <td colspan=3 class=xl133 style='border-right:.5pt solid black;border-left:
  none' x:num><span
  style='mso-spacerun:yes'>                                     </span><%=dt_sum.Rows[0][11].ToString()%></td>
  <td colspan=2 class=xl133 style='border-right:.5pt solid black;border-left:
  none' x:num><span
  style='mso-spacerun:yes'>                                  </span><%=dt_sum.Rows[0][12].ToString()%></td>
  <td colspan=3 class=xl153 style='border-right:.5pt solid black;border-left:
  none' x:num><span
  style='mso-spacerun:yes'>                                     </span><%=dt_sum.Rows[0][13].ToString()%></td>
  <td colspan=2 class=xl133 style='border-right:.5pt solid black;border-left:
  none' x:num><span
  style='mso-spacerun:yes'>                                  </span><%=dt_sum.Rows[0][18].ToString()%></td>
  <td colspan=2 class=xl153 style='border-right:.5pt solid black;border-left:
  none' x:num><span
  style='mso-spacerun:yes'>                                     </span><%=dt_sum.Rows[0][19].ToString()%></td>
  <td colspan=8 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl69 height=17 style='height:12.75pt'>
  <td height=17 colspan=7 class=xl69 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl72></td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl75 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl74 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl76 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl69 height=17 style='height:12.75pt'>
  <td height=17 colspan=7 class=xl69 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl72></td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl75 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl74 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl76 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl69 height=17 style='height:12.75pt'>
  <td height=17 colspan=7 class=xl69 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl72></td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl75 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl74 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl76 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl52 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl85 style='height:17.25pt'></td>
  <td colspan=2 class=xl52 style='mso-ignore:colspan'></td>
  <td class=xl85>Ngày..... tháng...... năm..........</td>
  <td colspan=10 class=xl52 style='mso-ignore:colspan'></td>
  <td class=xl85>Ngày <%=dt_name.Rows[0][1].ToString().Substring(0,2) %> tháng <%=dt_name.Rows[0][1].ToString().Substring(3,2) %> năm <%=dt_name.Rows[0][1].ToString().Substring(6,4) %></td>
  <td colspan=11 class=xl52 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl88 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl86 style='height:21.75pt'></td>
  <td class=xl87>Cán bộ thu</td>
  <td class=xl88></td>
  <td class=xl87>Phụ trách thu</td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td class=xl87>Người lập biểu</td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td class=xl87>Người sử dụng lao động</td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
 </tr>
 
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt'></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl43></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td colspan=10 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt'></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl43></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td colspan=10 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt'></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl43></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td colspan=10 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt'></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl43></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td colspan=10 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt'></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl43></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td colspan=10 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl88 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl86 style='height:21.75pt'></td>
  <td class=xl87><%=dt_name.Rows[3][0].ToString() %></td>
  <td class=xl88></td>
  <td class=xl87><%=dt_name.Rows[4][0].ToString() %></td>
  <td  class=xl88 style='mso-ignore:colspan'></td>
  <td  class=xl88 style='mso-ignore:colspan'></td>
  <td  class=xl88 style='mso-ignore:colspan'></td>
  <td  class=xl88 style='mso-ignore:colspan'></td>
  <td class=xl87><%=dt_name.Rows[5][0].ToString() %></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td class=xl87><%=dt_name.Rows[6][0].ToString() %></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
  <td  class=xl88 ></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt'></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl77 style='height:12.75pt'></td>
  <td class=xl41 colspan=8 style='mso-ignore:colspan'>Ghi chú : Mẫu 03-TBH lập
  khi đơn vị có điều chỉnh về lao động, tiền lương và mức đóng BHXH,BHYT bắt
  buộc.</td>
  <td class=xl43></td>
  <td colspan=3 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl43></td>
  <td colspan=12 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl56 height=16 style='height:12.0pt'>
  <td height=16 class=xl57 style='height:12.0pt'></td>
  <td colspan=6 class=xl56 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl60 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl56 style='mso-ignore:colspan'></td>
  <td class=xl60></td>
  <td colspan=11 class=xl56 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl56 height=16 style='height:12.0pt'>
  <td height=16 class=xl57 style='height:12.0pt'></td>
  <td colspan=6 class=xl56 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl60 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl56 style='mso-ignore:colspan'></td>
  <td class=xl60></td>
  <td colspan=11 class=xl56 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl56 height=16 style='height:12.0pt'>
  <td height=16 class=xl57 style='height:12.0pt'></td>
  <td colspan=6 class=xl56 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl60 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl56 style='mso-ignore:colspan'></td>
  <td class=xl60></td>
  <td colspan=11 class=xl56 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl56 height=16 style='height:12.0pt'>
  <td height=16 class=xl57 style='height:12.0pt'></td>
  <td colspan=5 class=xl56 style='mso-ignore:colspan'></td>
  <td class=xl68></td>
  <td colspan=3 class=xl60 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl56 style='mso-ignore:colspan'></td>
  <td class=xl60></td>
  <td colspan=11 class=xl56 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl56 height=16 style='height:12.0pt'>
  <td height=16 class=xl57 style='height:12.0pt'></td>
  <td colspan=6 class=xl56 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl60 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl56 style='mso-ignore:colspan'></td>
  <td class=xl60></td>
  <td colspan=11 class=xl56 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl56 height=16 style='height:12.0pt'>
  <td height=16 colspan=7 class=xl56 style='height:12.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl60 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl56 style='mso-ignore:colspan'></td>
  <td class=xl60></td>
  <td colspan=11 class=xl56 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl56 height=16 style='height:12.0pt'>
  <td height=16 colspan=7 class=xl56 style='height:12.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl60 style='mso-ignore:colspan'></td>
  <td colspan=16 class=xl56 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl56 height=16 style='height:12.0pt'>
  <td height=16 class=xl57 style='height:12.0pt'></td>
  <td colspan=6 class=xl56 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl60 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl56 style='mso-ignore:colspan'></td>
  <td class=xl60></td>
  <td colspan=11 class=xl56 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl56 height=16 style='height:12.0pt'>
  <td height=16 class=xl57 style='height:12.0pt'></td>
  <td colspan=4 class=xl56 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl60 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl56 style='mso-ignore:colspan'></td>
  <td class=xl60></td>
  <td colspan=11 class=xl56 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl56 height=16 style='height:12.0pt'>
  <td height=16 class=xl57 style='height:12.0pt'></td>
  <td colspan=3 class=xl56 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl60 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl56 style='mso-ignore:colspan'></td>
  <td class=xl60></td>
  <td colspan=11 class=xl56 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=16 style='height:12.0pt'>
  <td height=16 class=xl65 style='height:12.0pt'></td>
  <td colspan=3 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl78 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl78></td>
  <td colspan=11 class=xl68 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl56 height=16 style='height:12.0pt'>
  <td height=16 class=xl57 style='height:12.0pt'></td>
  <td colspan=2 class=xl56 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl60 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl56 style='mso-ignore:colspan'></td>
  <td class=xl60></td>
  <td colspan=2 class=xl79 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl56 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=27 style='width:20pt'></td>
  <td width=156 style='width:117pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
