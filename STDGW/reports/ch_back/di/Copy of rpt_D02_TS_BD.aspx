<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    
    string p_times, p_rpt_month, p_old_year, p_cur_year, p_select;
     
    p_times       = Request["l_times"].ToString();
    p_rpt_month  = Request["l_rpt_month"].ToString();
	p_cur_year=p_rpt_month.Substring(0,4);
    p_old_year=(int.Parse(p_rpt_month.Substring(0,4))-1).ToString();
    p_select     = Request["l_select"].ToString();
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
     = "select " +
        "decode( ins_type.num_2, 1, 'Tăng', 'Giảm') " +
        ",ins_type.char_3  as c1 " +
        ",nvl(ins_type.code_fnm, ins_type.Char_3) as c2 " +
        ",a.FULL_NAME as c3  " +
        ",nvl(a.SO_BHXH,'') as c4  " +
        ",nvl(a.LUONG_CU,0) as c5  " +
        ",'' as c6  " +
        ",'' as c7  " +
        ",'' as c8  " +
        ",'' as c9  " +
        ",nvl(a.LUONG_MOI,0) as c10  " +
        ",'' as c11  " +
        ",'' as c12  " +
        ",'' as c13  " +
        ",'' as c14  " +
        ",nvl(a.CL_TANG_XH,0) as c15  " +
        ",nvl(a.CL_GIAM_XH,0) as c16  " +
        ",nvl(a.CL_TANG_YT,0) as c17  " +
        ",nvl(a.CL_GIAM_YT,0) as c18  " +
        ",to_char(to_date(a.TU_THANG,'yyyymm'),'mmyyyy') as c19  " +
        ",to_char(to_date(nvl(a.DEN_THANG,'" + p_rpt_month + "'),'yyyymm'),'mmyyyy') as c20  " +
        ",a.TY_LE/100 as c21  " +
        ",'HÐ s? ' || A.MA_HOP_DONG || '(' ||  TO_CHAR(TO_DATE(A.NGAY_KY_HD,'YYYYMMDD'),'DD/MM/YYYY') || ')' as c22  " +
        ",a.SO_THANG as c23  " +
        ",a.DC_TANG_XH as c24  " +
        ",a.DC_GIAM_XH as c25  " +
        ",a.DC_TANG_YT as c26  " +
        ",a.DC_GIAM_YT as c27  " +
        ",a.ghi_chu as c28  " +
        ",a.EMP_ID as c29  " +
        ",decode(nvl(a.TN_YN,'N'),'Y','X','') as c30  " +
        ",nvl(a.CL_TANG_TN,0) as c31  " +
        ",nvl(a.CL_GIAM_TN,0) as c32  " +
        ",a.DC_TANG_TN as c33  " +
        ",a.DC_GIAM_TN as c34  " +
        ",(SELECT D.NUM_1 FROM THR_CODE_MASTER M,THR_CODE_DETAIL D WHERE M.DEL_IF=0 AND D.DEL_IF=0 AND D.THR_CODE_MASTER_PK=M.PK and id='HR0043' and char_1='" + p_old_year + "') c35 " +
        ",(select num_1 from vhr_hr_code where id='HR0043' and char_1='" + p_cur_year + "' ) c36 " +
        ",(select char_4 from vhr_hr_code where id='HR0043' and char_1='" + p_cur_year + "' ) c37 " +
        ",DECODE(LENGTH(A.BIRTH_DT),4,A.BIRTH_DT,TO_CHAR(TO_DATE(A.BIRTH_DT,'YYYYMMDD'),'DD/MM/YYYY')) AS NGAYSINH38    " +
        ",decode(nvl(a.TRA_THE_YN,'N'),'Y','X','')  as TRATHE39 " +
        ",decode(A.SEX,'F','X','')  as SEX40 " +
        ",(select V.CODE_FNM from vhr_hr_code v where v.id='HR0008' and v.code= A.CHUC_DANH ) as CHUCVU41 " +
        ",decode(nvl(a.coso_bhxh,'N'),'Y','X','') as COSOBHXH42 " +
        ",(select nvl(V.CHAR_3,'') from vhr_hr_code v where v.id='HR0012' and v.code= A.HEALTH_PLACE ) as TINH_BHYT43 " +
        ",(select nvl(V.CODE_NM ,'') from vhr_hr_code v where v.id='HR0012' and v.code= A.HEALTH_PLACE ) as BV_BHYT44 " +
        ",nvl(A.SO_CMT,'') as CMND45 " +
        "from THR_INSURANCE_MANAGE a, " +
        "(select code,num_1,num_2,CHAr_3,code_fnm from vhr_hr_code where id='HR0041') ins_type " +
        "where a.del_if=0 and a.LOAI_BH=ins_type.code " +
        "and a.THANG_BC='" + p_rpt_month + "' " +
        "and a.LAN_BAO='" + p_times + "' " +
        "and ((a.status_rpt = -1 and '" + p_select + "' = 'Y') or '" + p_select + "' = 'N' ) " +  //lay report dc select
        "order by ins_type.num_2,ins_type.num_1,a.emp_id,a.LUONG_MOI  ";


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
        "sum(decode(a.loai_bh,'01',1,'02',1,'03',1,'20',1,'18',1,'10',1,0)) as c1t1  " +
        ",sum(decode(a.loai_bh,'04',1,'05',1,'06',1,'07',1,'11',1,'26',1,'13',1,0)) as c1g2 " +
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
     SQL
	= "select " + 
        "sum(case when nvl(t.XH_YN,'N')='Y' then 1 else 0 end ) " +
        ",sum(case when nvl(t.YT_YN,'N')='Y' then 1 else 0 end ) " +
        ",sum(case when nvl(t.TN_YN,'N')='Y' then 1 else 0 end )  " +
        ",sum(case when nvl(t.XH_YN,'N')<>'Y' then 0 else nvl(LUONG_BHXH,0) end ) " +
        ",sum(case when nvl(t.YT_YN,'N')<>'Y' then 0 else nvl(LUONG_BHYT,0) end ) " +
        ",sum(case when nvl(t.TN_YN,'N')<>'Y' then 0 else nvl(LUONG_BHTN,0) end ) " +
		",sum(case when nvl(t.XH_YN,'N')<>'Y' then 0 else round(nvl(LUONG_BHXH,0)* (nvl(t.SOCIAL_RATE,0 )+nvl(t.SOCIAL_COM_RATE,0 ) )/100 ,0)end ) " + 
        ",sum(case when nvl(t.YT_YN,'N')<>'Y' then 0 else round(nvl(LUONG_BHYT,0)* (nvl(t.HEALTH_COM_RATE,0 )+nvl(t.HEALTH_RATE,0 )  )/100,0)end ) " +
        ",sum(case when nvl(t.TN_YN,'N')<>'Y' then 0 else round(nvl(LUONG_BHTN,0)* (nvl(t.UNEMP_COM_RATE,0 )+nvl(t.UNEMP_RATE,0 ) )/100 ,0)end)		" +
        "from thr_insurance_month t " +
        "where t.del_if=0 and t.WORK_MON=to_char(add_months(to_date('" + p_rpt_month + "','yyyymm'),-1),'yyyymm') " ;
DataTable dt_month = ESysLib.TableReadOpen(SQL);
	if (dt_month.Rows[0][1].ToString()=="")
    {
			 SQL
	= "select " + 
        " 0,0,0 ,0,0,0 ,0,0,0 from dual " ;
        dt_month = ESysLib.TableReadOpen(SQL);
    }
    //    Response.Write(SQL);
    int irow_total;
    irow_total = dt_sum.Rows.Count;
    if (irow_total ==0)
    {
        Response.Write("There is no data");
        Response.End();
    }

    int row = 0;
    
    %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_D02_TS_BD_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_D02_TS_BD_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_D02_TS_BD_files/oledata.mso">
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
  <o:LastAuthor>truong</o:LastAuthor>
  <o:Created>2012-01-16T08:47:30Z</o:Created>
  <o:LastSaved>2012-01-16T09:00:22Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:0in .18in 0in .26in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
	mso-page-orientation:landscape;}
.font13
	{color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font14
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
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
.style45
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:"Comma_rpt_D02_TS_BD - Copy";}
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
.style61
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
.xl66
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl68
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center-across;}
.xl69
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;}
.xl70
	{mso-style-parent:style45;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl71
	{mso-style-parent:style45;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;
	white-space:normal;}
.xl72
	{mso-style-parent:style45;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center-across;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style45;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center-across;}
.xl74
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:top;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;}
.xl77
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl78
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:top;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl80
	{mso-style-parent:style45;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;}
.xl81
	{mso-style-parent:style45;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;}
.xl82
	{mso-style-parent:style45;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl83
	{mso-style-parent:style45;
	font-style:italic;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl84
	{mso-style-parent:style45;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl85
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl86
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;}
.xl87
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Fixed;
	vertical-align:middle;
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Fixed;
	vertical-align:middle;}
.xl89
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;}
.xl90
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;}
.xl91
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
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
.xl92
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl93
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl94
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl95
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl96
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl97
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl99
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl100
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl101
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl102
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl103
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"Short Date";}
.xl104
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl105
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-protection:locked hidden;}
.xl106
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	mso-protection:locked hidden;}
.xl107
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl108
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl109
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	background:#CC99FF;
	mso-pattern:auto none;}
.xl110
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl111
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:VNI-TIMES;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl112
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl113
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl114
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl115
	{mso-style-parent:style45;
	color:red;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl116
	{mso-style-parent:style45;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl117
	{mso-style-parent:style61;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:0%;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl118
	{mso-style-parent:style45;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl119
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl120
	{mso-style-parent:style61;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl121
	{mso-style-parent:style61;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl122
	{mso-style-parent:style45;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl123
	{mso-style-parent:style45;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl124
	{mso-style-parent:style45;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl125
	{mso-style-parent:style45;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl126
	{mso-style-parent:style45;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl127
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	background:#CC99FF;
	mso-pattern:auto none;}
.xl128
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	background:#CC99FF;
	mso-pattern:auto none;}
.xl129
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	background:#CC99FF;
	mso-pattern:auto none;
	mso-protection:locked hidden;}
.xl130
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	background:#CC99FF;
	mso-pattern:auto none;
	mso-protection:locked hidden;}
.xl131
	{mso-style-parent:style45;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl132
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl133
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl134
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;}
.xl135
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl136
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl137
	{mso-style-parent:style45;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl138
	{mso-style-parent:style45;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl139
	{mso-style-parent:style45;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl140
	{mso-style-parent:style45;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl141
	{mso-style-parent:style45;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl142
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl143
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl144
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl145
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl146
	{mso-style-parent:style45;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl147
	{mso-style-parent:style45;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl148
	{mso-style-parent:style61;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:0%;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl149
	{mso-style-parent:style45;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl150
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-pattern:auto none;}
.xl151
	{mso-style-parent:style61;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"0\.0%";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl152
	{mso-style-parent:style61;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"0\.0%";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl153
	{mso-style-parent:style61;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"0\.0%";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl154
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CC99FF;
	mso-pattern:auto none;}
.xl155
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CC99FF;
	mso-pattern:auto none;}
.xl156
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CC99FF;
	mso-pattern:auto none;
	mso-protection:locked hidden;}
.xl157
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CC99FF;
	mso-pattern:auto none;
	mso-protection:locked hidden;}
.xl158
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl159
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl160
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;}
.xl161
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	white-space:normal;}
.xl162
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;}
.xl163
	{mso-style-parent:style45;
	color:red;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl164
	{mso-style-parent:style45;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl165
	{mso-style-parent:style61;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:0%;}
.xl166
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;}
.xl167
	{mso-style-parent:style61;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;}
.xl168
	{mso-style-parent:style45;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl169
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl170
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl171
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl172
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl173
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"Short Date";}
.xl174
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl175
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;}
.xl176
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	white-space:normal;}
.xl177
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;}
.xl178
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;}
.xl179
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;}
.xl180
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl181
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	white-space:normal;}
.xl182
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl183
	{mso-style-parent:style45;
	color:red;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl184
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl185
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl186
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl187
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl188
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;}
.xl189
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl190
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl191
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl192
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;}
.xl193
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;}
.xl194
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl195
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl196
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	white-space:normal;}
.xl197
	{mso-style-parent:style0;
	color:#339966;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	white-space:normal;}
.xl198
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl199
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl200
	{mso-style-parent:style0;
	font-style:italic;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;}
.xl201
	{mso-style-parent:style45;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	white-space:normal;}
.xl202
	{mso-style-parent:style45;
	color:#339966;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	white-space:normal;}
.xl203
	{mso-style-parent:style45;
	color:red;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	white-space:normal;}
.xl204
	{mso-style-parent:style0;
	font-style:italic;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl205
	{mso-style-parent:style0;
	font-style:italic;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;}
.xl206
	{mso-style-parent:style45;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl207
	{mso-style-parent:style45;
	color:#339966;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl208
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl209
	{mso-style-parent:style45;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;}
.xl210
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;}
.xl211
	{mso-style-parent:style0;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;}
.xl212
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"Short Date";}
.xl213
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl214
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;}
.xl215
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;}
.xl216
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl217
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl218
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl219
	{mso-style-parent:style45;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl220
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"Short Date";}
.xl221
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl222
	{mso-style-parent:style45;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl223
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";}
.xl224
	{mso-style-parent:style45;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl225
	{mso-style-parent:style45;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl226
	{mso-style-parent:style45;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl227
	{mso-style-parent:style45;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl228
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl229
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl230
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl231
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl232
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl233
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.000%";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl234
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.000%";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl235
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl236
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl237
	{mso-style-parent:style45;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl238
	{mso-style-parent:style45;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl239
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl240
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl241
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl242
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl243
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl244
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl245
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl246
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl247
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl248
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl249
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl250
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl251
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl252
	{mso-style-parent:style45;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl253
	{mso-style-parent:style45;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl254
	{mso-style-parent:style45;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl255
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl256
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl257
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl258
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl259
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl260
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl261
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl262
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl263
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl264
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl265
	{mso-style-parent:style0;
	color:#339966;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl266
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl267
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl268
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl269
	{mso-style-parent:style45;
	color:#339966;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border:.5pt solid windowtext;}
.xl270
	{mso-style-parent:style45;
	color:#339966;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl271
	{mso-style-parent:style45;
	color:#339966;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl272
	{mso-style-parent:style45;
	color:#339966;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl273
	{mso-style-parent:style45;
	color:#339966;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl274
	{mso-style-parent:style45;
	color:#339966;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl275
	{mso-style-parent:style45;
	color:#339966;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl276
	{mso-style-parent:style0;
	color:#339966;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl277
	{mso-style-parent:style0;
	color:#339966;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl278
	{mso-style-parent:style0;
	color:#339966;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl279
	{mso-style-parent:style0;
	color:#339966;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl280
	{mso-style-parent:style0;
	color:#339966;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl281
	{mso-style-parent:style0;
	color:#339966;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl282
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl283
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl284
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl285
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl286
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl287
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl288
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl289
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl290
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl291
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl292
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
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
.xl293
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
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
.xl294
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
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
.xl295
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl296
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl297
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl298
	{mso-style-parent:style45;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl299
	{mso-style-parent:style45;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl300
	{mso-style-parent:style45;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl301
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl302
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl303
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl304
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl305
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl306
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
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
.xl307
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl308
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl309
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl310
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl311
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl312
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl313
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl314
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl315
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl316
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl317
	{mso-style-parent:style0;
	color:#339966;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl318
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl319
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl320
	{mso-style-parent:style0;
	color:#339966;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl321
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl322
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl323
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl324
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl325
	{mso-style-parent:style45;
	color:red;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl326
	{mso-style-parent:style0;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl327
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:top;}
.xl328
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl329
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl330
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl331
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl332
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl333
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl334
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl335
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl336
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
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
    <x:Name>D02_TS</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:CodeName>Sheet1</x:CodeName>
     <x:Selected/>
     <x:LeftColumnVisible>29</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>62</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:CodeName>Sheet2</x:CodeName>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet2</x:Name>
    <x:WorksheetOptions>
     <x:CodeName>Sheet3</x:CodeName>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:CodeName>Sheet4</x:CodeName>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8760</x:WindowHeight>
  <x:WindowWidth>19320</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=D02_TS!$11:$11</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl67>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2806 style='border-collapse:
 collapse;table-layout:fixed;width:2108pt'>
 <col class=xl76 width=28 style='mso-width-source:userset;mso-width-alt:1024;
 width:21pt'>
 <col class=xl67 width=117 style='mso-width-source:userset;mso-width-alt:4278;
 width:88pt'>
 <col class=xl67 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl67 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl67 width=23 style='mso-width-source:userset;mso-width-alt:841;
 width:17pt'>
 <col class=xl67 width=35 style='mso-width-source:userset;mso-width-alt:1280;
 width:26pt'>
 <col class=xl67 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl67 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl67 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl67 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl84 width=17 style='mso-width-source:userset;mso-width-alt:621;
 width:13pt'>
 <col class=xl84 width=25 style='mso-width-source:userset;mso-width-alt:914;
 width:19pt'>
 <col class=xl84 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col class=xl84 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl84 width=21 style='mso-width-source:userset;mso-width-alt:768;
 width:16pt'>
 <col class=xl84 width=24 style='mso-width-source:userset;mso-width-alt:877;
 width:18pt'>
 <col class=xl67 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col class=xl223 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl223 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl224 width=41 style='mso-width-source:userset;mso-width-alt:1499;
 width:31pt'>
 <col class=xl224 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl224 width=87 span=5 style='mso-width-source:userset;mso-width-alt:
 3181;width:65pt'>
 <col class=xl67 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl67 width=84 style='mso-width-source:userset;mso-width-alt:3072;
 width:63pt'>
 <col class=xl67 width=133 style='mso-width-source:userset;mso-width-alt:4864;
 width:100pt'>
 <col class=xl67 width=101 style='mso-width-source:userset;mso-width-alt:3693;
 width:76pt'>
 <col class=xl67 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl67 width=84 style='mso-width-source:userset;mso-width-alt:3072;
 width:63pt'>
 <col class=xl67 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl67 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl67 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl67 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl67 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl67 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl67 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl67 width=0 span=3 style='display:none;mso-width-source:userset;
 mso-width-alt:2669'>
 <col class=xl67 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:2486'>
 <col class=xl67 width=0 span=7 style='display:none;mso-width-source:userset;
 mso-width-alt:0'>
 <col class=xl67 width=64 style='width:48pt'>
 <col class=xl212 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl213 width=64 span=2 style='width:48pt'>
 <col class=xl213 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:0'>
 <col class=xl67 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:2816'>
 <col class=xl67 width=0 span=6 style='display:none;mso-width-source:userset;
 mso-width-alt:0'>
 <col class=xl67 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=21 height=40 width=979 style='height:30.0pt;width:737pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="Line_x0020_4" o:spid="_x0000_s1028"
   style='position:absolute;flip:x y;z-index:4;visibility:visible' from="587.25pt,0"
   to="587.25pt,0" strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="Line_x0020_5" o:spid="_x0000_s1029" style='position:absolute;
   flip:x;z-index:5;visibility:visible' from="587.25pt,0" to="587.25pt,0"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="Line_x0020_6" o:spid="_x0000_s1030" style='position:absolute;
   flip:x;z-index:6;visibility:visible' from="587.25pt,0" to="587.25pt,0"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="Line_x0020_7" o:spid="_x0000_s1031" style='position:absolute;
   flip:x;z-index:7;visibility:visible' from="587.25pt,0" to="587.25pt,0"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="Line_x0020_1" o:spid="_x0000_s1025" style='position:absolute;
   z-index:1;visibility:visible' from="57pt,0" to="432.75pt,0" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
   <x:ClientData ObjectType="Line">
    <x:Anchor>
     1, 48, 0, 0, 10, 38, 0, 0</x:Anchor>
   </x:ClientData>
  </v:line><v:line id="Line_x0020_2" o:spid="_x0000_s1026" style='position:absolute;
   z-index:2;visibility:visible' from="57pt,0" to="432.75pt,0" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
   <x:ClientData ObjectType="Line">
    <x:Anchor>
     1, 48, 0, 0, 10, 36, 0, 0</x:Anchor>
   </x:ClientData>
  </v:line><v:line id="Line_x0020_3" o:spid="_x0000_s1027" style='position:absolute;
   flip:y;z-index:3;visibility:visible' from="58.5pt,0" to="432.75pt,0"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
   <x:ClientData ObjectType="Line">
    <x:Anchor>
     1, 50, 0, 0, 10, 35, 0, 0</x:Anchor>
   </x:ClientData>
  </v:line><v:line id="Line_x0020_8" o:spid="_x0000_s1032" style='position:absolute;
   z-index:8;visibility:visible' from="56.25pt,0" to="90pt,0" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="Line_x0020_9" o:spid="_x0000_s1033" style='position:absolute;
   z-index:9;visibility:visible' from="402pt,0" to="432.75pt,0" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
   <x:ClientData ObjectType="Line">
    <x:Anchor>
     9, 41, 0, 0, 10, 38, 0, 0</x:Anchor>
   </x:ClientData>
  </v:line><v:line id="Line_x0020_10" o:spid="_x0000_s1034" style='position:absolute;
   z-index:10;visibility:visible' from="57pt,0" to="420pt,0" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="Line_x0020_11" o:spid="_x0000_s1035" style='position:absolute;
   z-index:11;visibility:visible' from="57pt,0" to="420pt,0" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="Line_x0020_12" o:spid="_x0000_s1036" style='position:absolute;
   flip:y;z-index:12;visibility:visible' from="58.5pt,0" to="420pt,0"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="Line_x0020_17" o:spid="_x0000_s1041" style='position:absolute;
   z-index:17;visibility:visible' from="56.25pt,0" to="90pt,0" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="Line_x0020_18" o:spid="_x0000_s1042" style='position:absolute;
   z-index:18;visibility:visible' from="402pt,0" to="420pt,0" strokeweight=".25pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="Line_x0020_13" o:spid="_x0000_s1037" style='position:absolute;
   flip:x y;z-index:13;visibility:visible' from="670.5pt,0" to="670.5pt,0"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="Line_x0020_14" o:spid="_x0000_s1038" style='position:absolute;
   flip:x;z-index:14;visibility:visible' from="670.5pt,0" to="670.5pt,0"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="Line_x0020_15" o:spid="_x0000_s1039" style='position:absolute;
   flip:x;z-index:15;visibility:visible' from="670.5pt,0" to="670.5pt,0"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="Line_x0020_16" o:spid="_x0000_s1040" style='position:absolute;
   flip:x;z-index:16;visibility:visible' from="670.5pt,0" to="670.5pt,0"
   strokeweight=".25pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  relative;z-index:4'><span style='position:absolute;left:74px;top:-1px;
  width:821px;height:2px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=504></td>
    <td width=204></td>
    <td width=2></td>
    <td width=109></td>
    <td width=2></td>
   </tr>
   <tr>
    <td height=2></td>
    <td align=left valign=top><img width=504 height=2
    src="rpt_D02_TS_BD_files/image001.gif" v:shapes="Line_x0020_1 Line_x0020_2 Line_x0020_3 Line_x0020_8 Line_x0020_9 Line_x0020_10 Line_x0020_11 Line_x0020_12 Line_x0020_17 Line_x0020_18"></td>
    <td></td>
    <td align=left valign=top><img width=2 height=2
    src="rpt_D02_TS_BD_files/image002.gif" v:shapes="Line_x0020_4 Line_x0020_5 Line_x0020_6 Line_x0020_7"></td>
    <td></td>
    <td align=left valign=top><img width=2 height=2
    src="rpt_D02_TS_BD_files/image002.gif" v:shapes="Line_x0020_13 Line_x0020_14 Line_x0020_15 Line_x0020_16"></td>
   </tr>
  </table>
  </span></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=21 height=40 class=xl225 width=979 style='height:30.0pt;
    width:737pt'>DANH SÁCH LAO ĐỘNG THAM GIA BẢO HIỂM XÃ HỘI, BẢO HIỂM Y TẾ</td>
   </tr>
  </table>
  </span></td>
  <td class=xl66 width=87 style='width:65pt'></td>
  <td class=xl66 width=87 style='width:65pt'></td>
  <td class=xl66 width=87 style='width:65pt'></td>
  <td class=xl66 width=87 style='width:65pt'></td>
  <td class=xl66 width=87 style='width:65pt'></td>
  <td class=xl67 width=88 style='width:66pt'></td>
  <td class=xl67 width=84 style='width:63pt'></td>
  <td class=xl67 width=133 style='width:100pt'></td>
  <td class=xl67 width=101 style='width:76pt'></td>
  <td class=xl67 width=88 style='width:66pt'></td>
  <td class=xl67 width=84 style='width:63pt'></td>
  <td class=xl67 width=71 style='width:53pt'></td>
  <td class=xl67 width=82 style='width:62pt'></td>
  <td class=xl67 width=73 style='width:55pt'></td>
  <td class=xl67 width=82 style='width:62pt'></td>
  <td class=xl67 width=73 style='width:55pt'></td>
  <td class=xl67 width=88 style='width:66pt'></td>
  <td class=xl67 width=82 style='width:62pt'></td>
  <td class=xl67 width=0></td>
  <td class=xl67 width=0></td>
  <td class=xl67 width=0></td>
  <td class=xl67 width=0></td>
  <td class=xl67 width=0></td>
  <td class=xl67 width=0></td>
  <td class=xl67 width=0></td>
  <td class=xl67 width=0></td>
  <td class=xl67 width=0></td>
  <td class=xl67 width=0></td>
  <td class=xl67 width=0></td>
  <td class=xl67 width=64 style='width:48pt'></td>
  <td class=xl67 width=71 style='width:53pt'></td>
  <td class=xl67 width=64 style='width:48pt'></td>
  <td class=xl67 width=64 style='width:48pt'></td>
  <td class=xl67 width=0></td>
  <td class=xl67 width=0></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl67 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Tên
  đơn vị: <%=dt_name.Rows[0][0].ToString() %></td>
  <td colspan=6 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl69 colspan=5 style='mso-ignore:colspan'
  >Số:..........Tháng
  <%=p_rpt_month.Substring(4,2) %> Năm <%=p_rpt_month.Substring(0,4) %></td>
  <td class=xl73></td>
  <td class=xl71></td>
  <td class=xl68></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl74 style='mso-ignore:colspan'></td>
  <td colspan=4 rowspan=2 class=xl326 width=348 style='border-right:.5pt solid black;
  width:260pt'>Đơn vị cần ghi đầy đủ các tiêu chí<br>
    <span style='mso-spacerun:yes'> </span>từ cột 1 đến cột 26</td>
  <td rowspan=2 class=xl230 width=88 style='width:66pt'>Tháng báo cáo</td>
  <td rowspan=2 class=xl230 width=84 style='width:63pt'>Lương trần</td>
  <td rowspan=2 class=xl229 width=133 style='width:100pt'>Lương tối thiểu chung</td>
  <td colspan=3 class=xl75 width=273 style='width:205pt'>Lãi Truy Thu</td>
  <td colspan=10 class=xl67 style='mso-ignore:colspan'></td>
  <td class=xl76></td>
  <td colspan=7 class=xl67 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl67 colspan=2 style='height:18.0pt;mso-ignore:colspan'>Mã
  đơn vị:<span style='mso-spacerun:yes'>  </span><%=dt_name.Rows[1][0].ToString() %></td>
  <td colspan=2 class=xl67 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl71 style='mso-ignore:colspan'></td>
  <td class=xl72></td>
  <td class=xl73></td>
  <td colspan=6 rowspan=3 class=xl226 width=253 style='width:191pt'>Mẫu D02-TS<font
  class="font13"><br>
    </font><font class="font14">(Ban hành kèm theo QĐsố 1111/QĐ-BHXH ngày
  25/10/2011 của BHXH VN)</font></td>
  <td class=xl74></td>
  <td class=xl75 width=101 style='border-top:none;width:76pt'>BHXH</td>
  <td class=xl77 style='border-top:none;border-left:none'>BHYT</td>
  <td class=xl77 style='border-top:none;border-left:none'>BHTN</td>
  <td colspan=24 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl67 colspan=6 dir=LTR style='height:15.75pt;mso-ignore:
  colspan'>Địa chỉ:<span style='mso-spacerun:yes'>  </span><%=dt_name.Rows[2][0].ToString() %></td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl71 style='mso-ignore:colspan'></td>
  <td class=xl72></td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl78 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl79 width=87 style='width:65pt'>&nbsp;</td>
  <td rowspan=2 class=xl235 style='border-bottom:.5pt solid black;border-top:
  none' x:num x:fmla="=DATE(<%= p_rpt_month.Substring(0, 4).ToString()%>,<%= p_rpt_month.Substring(4, 2).ToString()%>,1)" > </td>
  <td rowspan=2 class=xl237 style='border-bottom:.5pt solid black;border-top:
  none' x:num="16600000"><span style='mso-spacerun:yes'>      
  </span>16,600,000 </td>
  <td rowspan=2 class=xl237 style='border-bottom:.5pt solid black;border-top:
  none' x:num="830000"><span
  style='mso-spacerun:yes'>                            </span>830,000 </td>
  <td rowspan=2 class=xl218 width=101 style='border-top:none;width:76pt'>0,875%</td>
  <td rowspan=2 class=xl231 style='border-bottom:.5pt solid black;border-top:
  none' x:num="7.4999999999999997E-3">0.75%</td>
  <td rowspan=2 class=xl233 style='border-bottom:.5pt solid black;border-top:
  none' x:num="8.7500000000000008E-3">0.875%</td>
  <td colspan=24 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl80 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Điện
  thoại liên hệ:<span style='mso-spacerun:yes'>  </span><%=dt_name.Rows[12][0].ToString() %></td>
  <td class=xl80></td>
  <td colspan=6 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl71 style='mso-ignore:colspan'></td>
  <td class=xl72></td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl78 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl79 width=87 style='width:65pt'>&nbsp;</td>
  <td colspan=24 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl81 colspan=2 style='height:18.75pt;mso-ignore:colspan'>A.
  PHẦN CHI TIẾT</td>
  <td colspan=8 class=xl67 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl82 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td class=xl84></td>
  <td class=xl82></td>
  <td class=xl67></td>
  <td colspan=9 class=xl82 style='mso-ignore:colspan'></td>
  <td colspan=30 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl86 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td rowspan=4 height=183 class=xl85 width=28 style='height:137.25pt;
  width:21pt'>Số <br>
    TT</td>
  <td rowspan=4 class=xl283 width=117 style='border-bottom:.5pt solid black;
  width:88pt'>Họ và tên</td>
  <td rowspan=4 class=xl283 width=76 style='border-bottom:.5pt solid black;
  width:57pt'>Số sổ BHXH</td>
  <td rowspan=4 class=xl283 width=63 style='border-bottom:.5pt solid black;
  width:47pt'>Ngày tháng năm sinh</td>
  <td rowspan=4 class=xl283 width=23 style='border-bottom:.5pt solid black;
  width:17pt'>Nữ<br>
    <span style='mso-spacerun:yes'> </span>(x)</td>
  <td colspan=2 rowspan=3 class=xl289 width=82 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:61pt'>Nơi khám chữa bệnh<br>
    </td>
  <td rowspan=4 class=xl305 width=61 style='border-bottom:.5pt solid black;
  width:46pt'><span style='mso-spacerun:yes'> </span>Số <br>
    CMND</td>
  <td rowspan=4 class=xl286 width=45 style='border-bottom:.5pt solid black;
  width:34pt'>Cấp bậc, c/vụ, chức danh nghề, đ/kiện, nơi làm việc</td>
  <td colspan=4 rowspan=2 class=xl307 width=140 style='border-bottom:.5pt solid black;
  width:106pt'>Mức đóng cũ</td>
  <td colspan=4 rowspan=2 class=xl308 width=148 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:112pt'>Mức đóng mới</td>
  <td rowspan=4 class=xl283 width=38 style='border-bottom:.5pt solid black;
  width:29pt'>Từ tháng<br>
    năm</td>
  <td rowspan=4 class=xl318 width=73 style='border-bottom:.5pt solid black;
  width:55pt'>Đến tháng<br>
    năm</td>
  <td rowspan=4 class=xl321 width=41 style='border-bottom:.5pt solid black;
  width:31pt'>Tỷ lệ bổ sung</td>
  <td rowspan=4 class=xl331 width=44 style='border-bottom:.5pt solid black;
  width:33pt'>Đã có sổ<span style='mso-spacerun:yes'>  </span>BHXH(x)</td>
  <td rowspan=4 class=xl331 width=87 style='border-bottom:.5pt solid black;
  width:65pt'>Ghi Chú</td>
  <td rowspan=4 class=xl194 width=87 style='width:65pt'><span
  style='mso-spacerun:yes'> </span>Mã<br>
    Phòng ban</td>
  <td rowspan=4 class=xl334>Ngày cấp</td>
  <td rowspan=4 class=xl334>Nơi cấp</td>
  <td rowspan=4 class=xl194 width=87 style='width:65pt'>Hộ khẩu thường trú
  <br>
    hoặc tạm trú</td>
  <td colspan=6 rowspan=2 class=xl255 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>SỐ PHÁT SINH</td>
  <td rowspan=4 class=xl247 width=71 style='border-bottom:.5pt solid black;
  width:53pt'>SỐ THÁNG</td>
  <td colspan=6 rowspan=2 class=xl241 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>ĐIỀU CHỈNH SỐ PHẢI ĐÓNG</td>
  <td colspan=11 class=xl86 style='mso-ignore:colspan'></td>
  <td rowspan=4 class=xl217 width=64 style='width:48pt'>Số Tháng<br>
    Truy Thu</td>
  <td colspan=3 rowspan=2 class=xl228>Lãi Truy Thu</td>
  <td class=xl87></td>
  <td class=xl86></td>
 </tr>
 <tr class=xl86 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=11 class=xl86 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl88></td>
  <td class=xl86></td>
 </tr>
 <tr class=xl86 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td rowspan=2 height=143 class=xl85 width=65 style='height:107.25pt;
  border-top:none;width:49pt'>Tiền lương</td>
  <td colspan=3 class=xl315 width=75 style='border-left:none;width:57pt'>Phụ
  cấp</td>
  <td rowspan=2 class=xl85 width=70 style='border-top:none;width:53pt'>Tiền
  lương</td>
  <td colspan=3 class=xl315 width=78 style='border-left:none;width:59pt'>Phụ
  cấp</td>
  <td colspan=2 class=xl263 style='border-right:.5pt solid black;border-left:
  none'>BHYT</td>
  <td colspan=2 class=xl261 style='border-right:.5pt solid black;border-left:
  none'>BHTN</td>
  <td colspan=2 class=xl263 style='border-right:.5pt solid black;border-left:
  none'>BHXH</td>
  <td colspan=2 class=xl239 style='border-right:.5pt solid black;border-left:
  none'>BHYT</td>
  <td colspan=2 class=xl113 style='border-right:.5pt solid black;border-left:
  none'>BHTN</td>
  <td colspan=2 class=xl239 style='border-right:.5pt solid black;border-left:
  none'>BHXH</td>
  <td colspan=6 class=xl86 style='mso-ignore:colspan'></td>
  <td class=xl89></td>
  <td class=xl90></td>
  <td colspan=3 class=xl86 style='mso-ignore:colspan'></td>
  <td rowspan=2 class=xl228 style='border-top:none'>BHXH</td>
  <td rowspan=2 class=xl228 style='border-top:none'>BHYT</td>
  <td rowspan=2 class=xl228 style='border-top:none'>BHTN</td>
  <td class=xl88></td>
  <td class=xl86></td>
 </tr>
 <tr class=xl86 height=111 style='mso-height-source:userset;height:83.25pt'>
  <td height=111 class=xl91 width=35 style='height:83.25pt;border-left:none;
  width:26pt'>Tỉnh</td>
  <td class=xl91 width=47 style='border-left:none;width:35pt'>Bệnh Viện</td>
  <td class=xl85 width=17 style='border-top:none;border-left:none;width:13pt'>CV</td>
  <td class=xl85 width=25 style='border-top:none;border-left:none;width:19pt'>TNVK
  %</td>
  <td class=xl85 width=33 style='border-top:none;border-left:none;width:25pt'>TN
  nghề %</td>
  <td class=xl85 width=21 style='border-top:none;border-left:none;width:16pt'>CV</td>
  <td class=xl85 width=24 style='border-top:none;border-left:none;width:18pt'>TNVK
  %</td>
  <td class=xl85 width=33 style='border-top:none;border-left:none;width:25pt'>TN
  nghề %</td>
  <td class=xl92 style='border-top:none;border-left:none'>TĂNG</td>
  <td class=xl93 style='border-top:none;border-left:none'>GIẢM</td>
  <td class=xl94 style='border-top:none;border-left:none'>TĂNG</td>
  <td class=xl94 style='border-top:none;border-left:none'>GIẢM</td>
  <td class=xl93 style='border-top:none;border-left:none'>TĂNG</td>
  <td class=xl93 style='border-top:none;border-left:none'>GIẢM</td>
  <td class=xl95 style='border-top:none;border-left:none'>TĂNG</td>
  <td class=xl95 style='border-top:none;border-left:none'>GIẢM</td>
  <td class=xl96 style='border-top:none;border-left:none'>TĂNG</td>
  <td class=xl96 style='border-top:none;border-left:none'>GIẢM</td>
  <td class=xl95 style='border-top:none;border-left:none'>TĂNG</td>
  <td class=xl95 style='border-top:none;border-left:none'>GIẢM</td>
  <td colspan=11 class=xl86 style='mso-ignore:colspan'></td>
  <td class=xl88></td>
  <td class=xl86></td>
 </tr>
 <tr class=xl76 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl97 style='height:14.25pt;border-top:none' x:num>1</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num x:fmla="=B11+1">3</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num x:fmla="=C11+1">4</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num x:fmla="=D11+1">5</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num x:fmla="=E11+1">6</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num x:fmla="=F11+1">7</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num x:fmla="=G11+1">8</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num x:fmla="=H11+1">9</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num x:fmla="=I11+1">10</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num x:fmla="=J11+1">11</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num x:fmla="=K11+1">12</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num x:fmla="=L11+1">13</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num x:fmla="=M11+1">14</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num x:fmla="=N11+1">15</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num x:fmla="=O11+1">16</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num x:fmla="=P11+1">17</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num x:fmla="=Q11+1">18</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num x:fmla="=R11+1">19</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num x:fmla="=S11+1">20</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num x:fmla="=T11+1">21</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num x:fmla="=U11+1">22</td>
  <td class=xl97 style='border-left:none' x:num x:fmla="=V11+1">23</td>
  <td class=xl97 style='border-left:none' x:num x:fmla="=W11+1">24</td>
  <td class=xl97 style='border-left:none' x:num x:fmla="=X11+1">25</td>
  <td class=xl97 style='border-left:none' x:num x:fmla="=Y11+1">26</td>
  <td class=xl98 style='border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl100 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl103 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl104 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl105 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl106 style='mso-ignore:colspan'></td>
  <td class=xl107 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl108 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl108 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl109>&nbsp;</td>
  <td class=xl76></td>
 </tr>
 <% 
    string next_type,cur_type,old_type,cur_kind,old_kind, cur_group, old_group;
    Boolean bchange=false;
     Boolean gchange=false;
     Boolean hchange = false;
    Boolean btotal=false;
    double dLuongCu = 0, dLuongMoi = 0;
        
    string[] atype=new string[] {"I","II","III","IV","V","VI","VII","VIII","IX","X","XI"};
    string[] btype=new string[] {"1","2","3","4","5","6","7","8","9","10","11"};
    string[] ctype = new string[] { "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k" };
    int irow_type=0;
    int j=0;
    int k=0;
    int g = 0;
    int tmp=0 ;
    int count = 1;
    for (int i = 0; i < irow_emp; i++)
    {
        
        irow_type += 1;
        cur_type = dt_Emp.Rows[i][0].ToString();
        cur_kind = dt_Emp.Rows[i][1].ToString();
        cur_group = dt_Emp.Rows[i][2].ToString();

        if (dt_Emp.Rows[i][5].ToString() != "")
        {
            dLuongCu += double.Parse(dt_Emp.Rows[i][5].ToString());
        }
        if (dt_Emp.Rows[i][10].ToString() != "")
        {
            dLuongMoi += double.Parse(dt_Emp.Rows[i][10].ToString());
        }
        //end sum 
        if (i == 0)
        {
            bchange = true;
            gchange = true;
            
        }
        else
        {
            old_type = dt_Emp.Rows[i - 1][0].ToString();
            old_kind = dt_Emp.Rows[i - 1][1].ToString();
            old_group = dt_Emp.Rows[i - 1][2].ToString();
            if (cur_type != old_type)
            {
                bchange = true;
                k = 0;
                tmp++;
                j++;
            }
            if (cur_kind != old_kind)
            {
                gchange = true;
                g = 0;
                tmp++;
            }
            if (cur_group != old_group && cur_kind != cur_group)
            {
                hchange = true;
                count = 1;
                tmp++;
            }
        }
        // chay row excel cho cong thuc
        row = i + tmp;
        
        if (bchange == true)
        {
            irow_type = 1;
            //doi loai bao cao tang giam
  %>
 <tr class=xl104 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl110 style='height:20.25pt' x:str><%=atype[j]%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl111 style='border-left:none' x:str><%=cur_type%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl115 style='border-left:none'>&nbsp;</td>
  <td class=xl116 style='border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-left:none'>&nbsp;</td>
  <td class=xl118 style='border-left:none'>&nbsp;</td>
  <td class=xl116 style='border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-left:none'>&nbsp;</td>
  <td class=xl119 style='border-left:none'>&nbsp;</td>
  <td class=xl119 style='border-left:none'>&nbsp;</td>
  <td class=xl120 style='border-left:none'>&nbsp;</td>
  <td class=xl120 style='border-left:none'>&nbsp;</td>
  <td class=xl120 style='border-left:none'>&nbsp;</td>
  <td class=xl121 style='border-left:none'>&nbsp;</td>
  <td class=xl121 style='border-left:none'>&nbsp;</td>
  <td class=xl121 style='border-left:none'>&nbsp;</td>
  <td class=xl121 style='border-left:none'>&nbsp;</td>
  <td class=xl122 style='border-left:none' x:num="0"
  x:fmla="=IF(AND(AO12=$AA$4,OR(T12=28.5%,T12=30.5%)),IF(AR12&gt;AQ12,AR12-AQ12,0),0)"><span
  style='mso-spacerun:yes'>                      </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl122 style='border-left:none' x:num="0"
  x:fmla="=IF(AND(AO12=$AA$4,OR(T12=28.5%,T12=30.5%)),IF(AQ12&gt;AR12,AQ12-AR12,0),0)"><span
  style='mso-spacerun:yes'>                     </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl123 style='border-left:none' x:num="0"
  x:fmla="=IF(AND(AO12=$AA$4,OR(T12=2%,T12=30.5%)),IF(AR12&gt;AQ12,AR12-AQ12,0),0)"><span
  style='mso-spacerun:yes'>                                     </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl123 style='border-left:none' x:num="0"
  x:fmla="=IF(AND(AO12=$AA$4,OR(T12=2%,T12=30.5%)),IF(AQ12&gt;AR12,AQ12-AR12,0),0)"><span
  style='mso-spacerun:yes'>                           </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl122 style='border-left:none' x:num="0"
  x:fmla="=IF(AND(AO12=$AA$4,OR(T12=24%,OR(T12=28.5%,OR(T12=28.5%,T12=30.5%)))),IF(AR12&gt;AQ12,AR12-AQ12,0),0)"><span
  style='mso-spacerun:yes'>                      </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl122 style='border-left:none' x:num="0"
  x:fmla="=IF(AND(AO12=$AA$4,OR(T12=22%,OR(T12=24%,OR(T12=26.5%,T12=28.5%)))),IF(AQ12&gt;AR12,AQ12-AR12,0),0)"><span
  style='mso-spacerun:yes'>                     </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl124 style='border-left:none' x:num="0"
  x:fmla="=IF(OR((AO12&lt;&gt;$AA$4),(AND((T12=4.5%),(AN12=AO12)))),DATEDIF(AN12,AO12,&quot;m&quot;)+1,DATEDIF(AN12,AO12,&quot;m&quot;))"><span
  style='mso-spacerun:yes'>                 </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl125 style='border-left:none' x:num="0"
  x:fmla="=IF(OR(T12=4.5%,OR(T12=28.5%,T12=30.5%,T12=26.5%)),AG12*MAX((AR12-AQ12),0)*4.5%,0)"><span
  style='mso-spacerun:yes'>                    </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl125 style='border-left:none' x:num="0"
  x:fmla="=IF(OR(T12=4.5%,OR(T12=28.5%,T12=30.5%,T12=26.5%)),AG12*MAX(AQ12-AR12,0)*4.5%,0)"><span
  style='mso-spacerun:yes'>                 </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl126 style='border-left:none' x:num="0"
  x:fmla="=IF(OR(T12=2%,T12=30.5%,AND((T12=28.5%),YEAR(AO12)&lt;2012)),AG12*MAX((AR12-AQ12),0)*2%,0)"><span
  style='mso-spacerun:yes'>                    </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl126 style='border-left:none' x:num="0"
  x:fmla="=IF(OR(T12=2%,T12=30.5%, AND((T12=28.5%),YEAR(AO12)&lt;2012)),AG12*MAX(AQ12-AR12,0)*2%,0)"><span
  style='mso-spacerun:yes'>                 </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl125 style='border-left:none' x:num="0"
  x:fmla="=IF(OR(T12=24%,OR(T12=28.5%,T12=30.5%,T12=26.5%)),IF(YEAR(AN12)=2011,AG12*MAX((AR12-AQ12),0)*22%,AG12*MAX((AR12-AQ12),0)*24%),0)"><span
  style='mso-spacerun:yes'>                      </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl125 style='border-left:none' x:num="0"
  x:fmla="=IF(OR(T12=24%,T12=26%,OR(T12=28.5%,T12=30.5%,T12=26.5%)),IF(YEAR(AN12)=2011,AG12*MAX(AQ12-AR12,0)*22%,AG12*MAX(AQ12-AR12,0)*24%),0)"><span
  style='mso-spacerun:yes'>                    </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl127 align=right x:num="40909" x:fmla="=IF(R12&lt;&gt;&quot;&quot;,R12,$AA$4)">01/01/2012</td>
  <td class=xl127 align=right x:num="40909" x:fmla="=IF(S12&lt;&gt;&quot;&quot;,S12,$AA$4)">01/01/2012</td>
  <td class=xl127 align=right x:num="40878"
  x:fmla="=DATE(YEAR($AA$4),MONTH($AA$4)-1,DAY($AA$4))">01/12/2011</td>
  <td class=xl128 align=right x:num x:fmla="=IF(J12&gt;$AB$4,$AB$4,J12)">0</td>
  <td class=xl128 align=right x:num x:fmla="=IF(N12&gt;$AB$4,$AB$4,N12)">0</td>
  <td class=xl129 align=right x:num x:fmla="=IF(AND(AB12&gt;0,AR12=0),1,0)">0</td>
  <td class=xl129 align=right x:num x:fmla="=IF(AND(AF12&gt;0,AR12=0),1,0)">0</td>
  <td class=xl129 align=right x:num x:fmla="=IF(AND(AD12&gt;0,AR12=0),1,0)">0</td>
  <td class=xl129 align=right x:num x:fmla="=IF(AND(AA12&gt;0,AQ12=0),1,0)">0</td>
  <td class=xl130 x:num x:fmla="=IF(AND((AE12&gt;0),(AQ12=0)),1,0)">0</td>
  <td class=xl130 x:num x:fmla="=IF(AND((AC12&gt;0),(AQ12=0)),1,0)">0</td>
  <td class=xl131 style='border-top:none' x:num="0"
  x:fmla="=IF(OR(T12=4.5%,AN12&gt;AP12),0,(DATEDIF(AN12,AP12,&quot;m&quot;))+1)"><span
  style='mso-spacerun:yes'>              </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl132 x:num
  x:fmla="=IF(OR(T12=4.5%,T12=2%,AY12=1,AQ12&gt;AR12),0,IF(YEAR(AN12)&lt;2010,laitt(AG12,AY12,MAX(AR12-AQ12)*20%,0.875%),IF(YEAR(AN12)&lt;2012,laitt(AG12,AY12,MAX(AR12-AQ12)*22%,0.875%),laitt(AG12,AY12,MAX(AR12-AQ12)*24%,0.875%))))">0</td>
  <td class=xl132 style='border-left:none' x:num
  x:fmla="=IF(OR(AND(YEAR(AN12)&lt;=2009,T12=20%),AND(YEAR(AN12)&lt;2010,T12=22%),AND(YEAR(AN12)&lt;2012,T12=24%),R12=26%,AQ12&gt;AR12,T12=4.5%,AY12=1),0,IF(YEAR(AN12)&lt;2010,laitt(AG12,AY12,(AR12-AQ12)*3%,0.75%),laitt(AG12,AY12,(AR12-AQ12)*4.5%,0.75%)))">0</td>
  <td class=xl133 style='border-left:none' x:num
  x:fmla="=IF(OR(YEAR(AN12)&lt;2009,AND(YEAR(AN12)&gt;=2010,T12=26.5%),AND(YEAR(AN12)&gt;2012,T12=28.5%),T12=4.5%,AQ12&gt;AR12,AY12=1),0,laitt(AG12,AY12,(AR12-AQ12)*2%,0.875%))">0</td>
  <td class=xl134></td>
  <td class=xl135></td>
 </tr>
 <%     bchange = false;
        
        }//ket thuc doi group

        if (gchange)
        {
 %>
 <tr class=xl104 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl110 style='height:20.25pt;border-top:none'><%=atype[j]%>.<%= btype[k]%></td>
  <td class=xl136 style='border-top:none;border-left:none'><%= cur_kind %></td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl115 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl116 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl118 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl116 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl119 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl119 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl120 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl120 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl120 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl121 style='border-left:none'>&nbsp;</td>
  <td class=xl121 style='border-left:none'>&nbsp;</td>
  <td class=xl121 style='border-left:none'>&nbsp;</td>
  <td class=xl121 style='border-left:none'>&nbsp;</td>
  <td class=xl137 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=IF(AND(AO13=$AA$4,OR(T13=28.5%,T13=30.5%)),IF(AR13&gt;AQ13,AR13-AQ13,0),0)"><span
  style='mso-spacerun:yes'>                      </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl137 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=IF(AND(AO13=$AA$4,OR(T13=28.5%,T13=30.5%)),IF(AQ13&gt;AR13,AQ13-AR13,0),0)"><span
  style='mso-spacerun:yes'>                     </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl138 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=IF(AND(AO13=$AA$4,OR(T13=2%,T13=30.5%)),IF(AR13&gt;AQ13,AR13-AQ13,0),0)"><span
  style='mso-spacerun:yes'>                                     </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl138 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=IF(AND(AO13=$AA$4,OR(T13=2%,T13=30.5%)),IF(AQ13&gt;AR13,AQ13-AR13,0),0)"><span
  style='mso-spacerun:yes'>                           </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl137 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=IF(AND(AO13=$AA$4,OR(T13=24%,OR(T13=28.5%,OR(T13=28.5%,T13=30.5%)))),IF(AR13&gt;AQ13,AR13-AQ13,0),0)"><span
  style='mso-spacerun:yes'>                      </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl137 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=IF(AND(AO13=$AA$4,OR(T13=22%,OR(T13=24%,OR(T13=26.5%,T13=28.5%)))),IF(AQ13&gt;AR13,AQ13-AR13,0),0)"><span
  style='mso-spacerun:yes'>                     </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl139 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=IF(OR((AO13&lt;&gt;$AA$4),(AND((T13=4.5%),(AN13=AO13)))),DATEDIF(AN13,AO13,&quot;m&quot;)+1,DATEDIF(AN13,AO13,&quot;m&quot;))"><span
  style='mso-spacerun:yes'>                 </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl140 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=IF(OR(T13=4.5%,OR(T13=28.5%,T13=30.5%,T13=26.5%)),AG13*MAX((AR13-AQ13),0)*4.5%,0)"><span
  style='mso-spacerun:yes'>                    </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl140 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=IF(OR(T13=4.5%,OR(T13=28.5%,T13=30.5%,T13=26.5%)),AG13*MAX(AQ13-AR13,0)*4.5%,0)"><span
  style='mso-spacerun:yes'>                 </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl141 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=IF(OR(T13=2%,T13=30.5%,AND((T13=28.5%),YEAR(AO13)&lt;2012)),AG13*MAX((AR13-AQ13),0)*2%,0)"><span
  style='mso-spacerun:yes'>                    </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl141 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=IF(OR(T13=2%,T13=30.5%, AND((T13=28.5%),YEAR(AO13)&lt;2012)),AG13*MAX(AQ13-AR13,0)*2%,0)"><span
  style='mso-spacerun:yes'>                 </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl140 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=IF(OR(T13=24%,OR(T13=28.5%,T13=30.5%,T13=26.5%)),IF(YEAR(AN13)=2011,AG13*MAX((AR13-AQ13),0)*22%,AG13*MAX((AR13-AQ13),0)*24%),0)"><span
  style='mso-spacerun:yes'>                      </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl140 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=IF(OR(T13=24%,T13=26%,OR(T13=28.5%,T13=30.5%,T13=26.5%)),IF(YEAR(AN13)=2011,AG13*MAX(AQ13-AR13,0)*22%,AG13*MAX(AQ13-AR13,0)*24%),0)"><span
  style='mso-spacerun:yes'>                    </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl127 align=right x:num="40909" x:fmla="=IF(R13&lt;&gt;&quot;&quot;,R13,$AA$4)">01/01/2012</td>
  <td class=xl127 align=right x:num="40909" x:fmla="=IF(S13&lt;&gt;&quot;&quot;,S13,$AA$4)">01/01/2012</td>
  <td class=xl127 align=right x:num="40878"
  x:fmla="=DATE(YEAR($AA$4),MONTH($AA$4)-1,DAY($AA$4))">01/12/2011</td>
  <td class=xl128 align=right x:num x:fmla="=IF(J13&gt;$AB$4,$AB$4,J13)">0</td>
  <td class=xl128 align=right x:num x:fmla="=IF(N13&gt;$AB$4,$AB$4,N13)">0</td>
  <td class=xl129 align=right x:num x:fmla="=IF(AND(AB13&gt;0,AR13=0),1,0)">0</td>
  <td class=xl129 align=right x:num x:fmla="=IF(AND(AF13&gt;0,AR13=0),1,0)">0</td>
  <td class=xl129 align=right x:num x:fmla="=IF(AND(AD13&gt;0,AR13=0),1,0)">0</td>
  <td class=xl129 align=right x:num x:fmla="=IF(AND(AA13&gt;0,AQ13=0),1,0)">0</td>
  <td class=xl130 x:num x:fmla="=IF(AND((AE13&gt;0),(AQ13=0)),1,0)">0</td>
  <td class=xl130 x:num x:fmla="=IF(AND((AC13&gt;0),(AQ13=0)),1,0)">0</td>
  <td class=xl131 style='border-top:none' x:num="0"
  x:fmla="=IF(OR(T13=4.5%,AN13&gt;AP13),0,(DATEDIF(AN13,AP13,&quot;m&quot;))+1)"><span
  style='mso-spacerun:yes'>              </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl132 style='border-top:none' x:num
  x:fmla="=IF(OR(T13=4.5%,T13=2%,AY13=1,AQ13&gt;AR13),0,IF(YEAR(AN13)&lt;2010,laitt(AG13,AY13,MAX(AR13-AQ13)*20%,0.875%),IF(YEAR(AN13)&lt;2012,laitt(AG13,AY13,MAX(AR13-AQ13)*22%,0.875%),laitt(AG13,AY13,MAX(AR13-AQ13)*24%,0.875%))))">0</td>
  <td class=xl132 style='border-top:none;border-left:none' x:num
  x:fmla="=IF(OR(AND(YEAR(AN13)&lt;=2009,T13=20%),AND(YEAR(AN13)&lt;2010,T13=22%),AND(YEAR(AN13)&lt;2012,T13=24%),R13=26%,AQ13&gt;AR13,T13=4.5%,AY13=1),0,IF(YEAR(AN13)&lt;2010,laitt(AG13,AY13,(AR13-AQ13)*3%,0.75%),laitt(AG13,AY13,(AR13-AQ13)*4.5%,0.75%)))">0</td>
  <td class=xl133 style='border-top:none;border-left:none' x:num
  x:fmla="=IF(OR(YEAR(AN13)&lt;2009,AND(YEAR(AN13)&gt;=2010,T13=26.5%),AND(YEAR(AN13)&gt;2012,T13=28.5%),T13=4.5%,AQ13&gt;AR13,AY13=1),0,laitt(AG13,AY13,(AR13-AQ13)*2%,0.875%))">0</td>
  <td class=xl134></td>
  <td class=xl135></td>
 </tr>
 <%
        gchange = false;
        k++;
      }
     if (hchange == true)
     {
        %>
 <tr class=xl104 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl110 style='height:20.25pt;border-top:none'><%=ctype[g]%></td>
  <td class=xl142 style='border-top:none;border-left:none'><%= cur_group%></td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl115 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl116 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl118 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl116 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl119 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl119 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl120 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl120 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl120 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl121 style='border-left:none'>&nbsp;</td>
  <td class=xl121 style='border-left:none'>&nbsp;</td>
  <td class=xl121 style='border-left:none'>&nbsp;</td>
  <td class=xl121 style='border-left:none'>&nbsp;</td>
  <td class=xl137 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl137 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl138 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl138 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl137 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl137 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl139 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl140 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl140 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl141 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl141 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl140 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=IF(OR(T14=24%,OR(T14=28.5%,T14=30.5%,T14=26.5%)),IF(YEAR(AN14)=2011,AG14*MAX((AR14-AQ14),0)*22%,AG14*MAX((AR14-AQ14),0)*24%),0)"><span
  style='mso-spacerun:yes'>                      </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl140 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=IF(OR(T14=24%,T14=26%,OR(T14=28.5%,T14=30.5%,T14=26.5%)),IF(YEAR(AN14)=2011,AG14*MAX(AQ14-AR14,0)*22%,AG14*MAX(AQ14-AR14,0)*24%),0)"><span
  style='mso-spacerun:yes'>                    </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td colspan=3 class=xl127 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl128 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 class=xl129 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl130 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl131 style='border-top:none' x:num="1"
  x:fmla="=IF(OR(T14=4.5%,AN14&gt;AP14),0,(DATEDIF(AN14,AP14,&quot;m&quot;))+1)"><span
  style='mso-spacerun:yes'>                </span>1 </td>
  <td class=xl132 style='border-top:none' x:num
  x:fmla="=IF(OR(T14=4.5%,T14=2%,AY14=1,AQ14&gt;AR14),0,IF(YEAR(AN14)&lt;2010,laitt(AG14,AY14,MAX(AR14-AQ14)*20%,0.875%),IF(YEAR(AN14)&lt;2012,laitt(AG14,AY14,MAX(AR14-AQ14)*22%,0.875%),laitt(AG14,AY14,MAX(AR14-AQ14)*24%,0.875%))))">0</td>
  <td class=xl132 style='border-top:none;border-left:none' x:num
  x:fmla="=IF(OR(AND(YEAR(AN14)&lt;=2009,T14=20%),AND(YEAR(AN14)&lt;2010,T14=22%),AND(YEAR(AN14)&lt;2012,T14=24%),R14=26%,AQ14&gt;AR14,T14=4.5%,AY14=1),0,IF(YEAR(AN14)&lt;2010,laitt(AG14,AY14,(AR14-AQ14)*3%,0.75%),laitt(AG14,AY14,(AR14-AQ14)*4.5%,0.75%)))">0</td>
  <td class=xl133 style='border-top:none;border-left:none' x:num
  x:fmla="=IF(OR(YEAR(AN14)&lt;2009,AND(YEAR(AN14)&gt;=2010,T14=26.5%),AND(YEAR(AN14)&gt;2012,T14=28.5%),T14=4.5%,AQ14&gt;AR14,AY14=1),0,laitt(AG14,AY14,(AR14-AQ14)*2%,0.875%))">0</td>
  <td class=xl134></td>
  <td class=xl135></td>
 </tr>
  <%    
     hchange = false;
     g += 1;
     }
            
             %>
 <tr class=xl104 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl143 style='height:20.25pt;border-top:none' x:num><%=count %></td>
  <td class=xl144 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][3].ToString() %></td>
  <td class=xl144 align=right style='border-top:none;border-left:none'
  x:str><%=dt_Emp.Rows[i][4].ToString() %></td>
  <td class=xl145 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][38].ToString() %></td>
  <td class=xl144 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][40].ToString() %></td>
  <td class=xl144 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][43].ToString() %></td>
  <td class=xl144 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][44].ToString() %></td>
  <td class=xl144 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][45].ToString() %></td>
  <td class=xl143 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][41].ToString() %></td>
  <td class=xl146 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][5].ToString() %> </td>
  <td class=xl147 style='border-top:none;border-left:none'></td>
  <td class=xl148 style='border-top:none;border-left:none'></td>
  <td class=xl148 style='border-top:none;border-left:none'></td>
  <td class=xl146 style='border-top:none;border-left:none' x:num ><%=dt_Emp.Rows[i][10].ToString() %></td>
  <td class=xl147 style='border-top:none;border-left:none'></td>
  <td class=xl148 style='border-top:none;border-left:none'></td>
  <td class=xl148 style='border-top:none;border-left:none'></td>
  <%--<td class=xl150 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][19].ToString() %></td>--%>
  <td class=xl150 style='border-top:none;border-left:none' x:num x:fmla="=DATE(<%= dt_Emp.Rows[i][19].ToString().Substring(2,4).ToString() %>,<%= dt_Emp.Rows[i][19].ToString().Substring(0,2).ToString() %>,1)" ></td>
  <td class=xl150 style='border-top:none;border-left:none' x:num x:fmla="=DATE(<%= dt_Emp.Rows[i][20].ToString().Substring(2,4).ToString() %>,<%= dt_Emp.Rows[i][20].ToString().Substring(0,2).ToString() %>,1)" ></td>
  <td class=xl151 style='border-top:none;border-left:none'
  x:num><%=dt_Emp.Rows[i][21].ToString() %></td>
  <td class=xl152 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][42].ToString() %></td>
  <td class=xl152 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl153 style='border-left:none'>&nbsp;</td>
  <td class=xl153 style='border-left:none'>&nbsp;</td>
  <td class=xl153 style='border-left:none'>&nbsp;</td>
  <td class=xl153 style='border-left:none'>&nbsp;</td>
  <td class=xl137 style='border-top:none;border-left:none' x:num
  x:fmla="=IF(AND(AO<%= row+14 %>=$AA$4,OR(T<%= row+14 %>=28.5%,T<%= row+14 %>=30.5%)),IF(AR<%= row+14 %>&gt;AQ<%= row+14 %>,AR<%= row+14 %>-AQ<%= row+14 %>,0),0)"><span
  style='mso-spacerun:yes'>                      </span><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl137 style='border-top:none;border-left:none' x:num
  x:fmla="=IF(AND(AO<%= row+14 %>=$AA$4,OR(T<%= row+14 %>=28.5%,T<%= row+14 %>=30.5%)),IF(AQ<%= row+14 %>&gt;AR<%= row+14 %>,AQ<%= row+14 %>-AR<%= row+14 %>,0),0)"><span
  style='mso-spacerun:yes'>        </span> </td>
  <td class=xl138 style='border-top:none;border-left:none' x:num
  x:fmla="=IF(AND(AO<%= row+14 %>=$AA$4,OR(T<%= row+14 %>=2%,T<%= row+14 %>=30.5%)),IF(AR<%= row+14 %>&gt;AQ<%= row+14 %>,AR<%= row+14 %>-AQ<%= row+14 %>,0),0)"><span
  style='mso-spacerun:yes'>                                     </span><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl138 style='border-top:none;border-left:none' x:num
  x:fmla="=IF(AND(AO<%= row+14 %>=$AA$4,OR(T<%= row+14 %>=2%,T<%= row+14 %>=30.5%)),IF(AQ<%= row+14 %>&gt;AR<%= row+14 %>,AQ<%= row+14 %>-AR<%= row+14 %>,0),0)"><span
  style='mso-spacerun:yes'>              </span> </td>
  <td class=xl137 style='border-top:none;border-left:none' x:num
  x:fmla="=IF(AND(AO<%= row+14 %>=$AA$4,OR(T<%= row+14 %>=24%,OR(T<%= row+14 %>=28.5%,OR(T<%= row+14 %>=28.5%,T<%= row+14 %>=30.5%)))),IF(AR<%= row+14 %>&gt;AQ<%= row+14 %>,AR<%= row+14 %>-AQ<%= row+14 %>,0),0)"><span
  style='mso-spacerun:yes'>                      </span><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl137 style='border-top:none;border-left:none' x:num
  x:fmla="=IF(AND(AO<%= row+14 %>=$AA$4,OR(T<%= row+14 %>=24%,OR(T<%= row+14 %>=26%,OR(T<%= row+14 %>=28.5%,T<%= row+14 %>=30.5%)))),IF(AQ<%= row+14 %>&gt;AR<%= row+14 %>,AQ<%= row+14 %>-AR<%= row+14 %>,0),0)"><span
  style='mso-spacerun:yes'>        </span> </td>
  <td class=xl139 style='border-top:none;border-left:none' x:num
  x:fmla="=IF(OR((AO<%= row+14 %>&lt;&gt;$AA$4),(AND((T<%= row+14 %>=4.5%),(AN<%= row+14 %>=AO<%= row+14 %>)))),DATEDIF(AN<%= row+14 %>,AO<%= row+14 %>,&quot;m&quot;)+1,DATEDIF(AN<%= row+14 %>,AO<%= row+14 %>,&quot;m&quot;))"><span
  style='mso-spacerun:yes'>                 </span><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl140 style='border-top:none;border-left:none' x:num
  x:fmla="=IF(OR(T<%= row+14 %>=4.5%,OR(T<%= row+14 %>=28.5%,T<%= row+14 %>=30.5%,T<%= row+14 %>=26.5%)),AG<%= row+14 %>*MAX((AR<%= row+14 %>-AQ<%= row+14 %>),0)*4.5%,0)"><span
  style='mso-spacerun:yes'>                    </span><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl140 style='border-top:none;border-left:none' x:num
  x:fmla="=IF(OR(T<%= row+14 %>=4.5%,OR(T<%= row+14 %>=28.5%,T<%= row+14 %>=30.5%,T<%= row+14 %>=26.5%)),AG<%= row+14 %>*MAX(AQ<%= row+14 %>-AR<%= row+14 %>,0)*4.5%,0)"><span
  style='mso-spacerun:yes'>                 </span><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl141 style='border-top:none;border-left:none' x:num
  x:fmla="=IF(OR(T<%= row+14 %>=2%,T<%= row+14 %>=30.5%,AND((T<%= row+14 %>=28.5%),YEAR(AO<%= row+14 %>)&lt;2012)),AG<%= row+14 %>*MAX((AR<%= row+14 %>-AQ<%= row+14 %>),0)*2%,0)"><span
  style='mso-spacerun:yes'>                    </span><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl141 style='border-top:none;border-left:none' x:num
  x:fmla="=IF(OR(T<%= row+14 %>=2%,T<%= row+14 %>=30.5%, AND((T<%= row+14 %>=28.5%),YEAR(AO<%= row+14 %>)&lt;2012)),AG<%= row+14 %>*MAX(AQ<%= row+14 %>-AR<%= row+14 %>,0)*2%,0)"><span
  style='mso-spacerun:yes'>                 </span><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl140 style='border-top:none;border-left:none' x:num
  x:fmla="=IF(OR(T<%= row+14 %>=24%,OR(T<%= row+14 %>=28.5%,T<%= row+14 %>=30.5%,T<%= row+14 %>=26.5%)),IF(YEAR(AN<%= row+14 %>)=2011,AG<%= row+14 %>*MAX((AR<%= row+14 %>-AQ<%= row+14 %>),0)*22%,AG<%= row+14 %>*MAX((AR<%= row+14 %>-AQ<%= row+14 %>),0)*24%),0)"><span
  style='mso-spacerun:yes'>                      </span><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl140 style='border-top:none;border-left:none' x:num
  x:fmla="=IF(OR(T<%= row+14 %>=24%,T<%= row+14 %>=26%,OR(T<%= row+14 %>=28.5%,T<%= row+14 %>=30.5%,T<%= row+14 %>=26.5%)),IF(YEAR(AN<%= row+14 %>)=2011,AG<%= row+14 %>*MAX(AQ<%= row+14 %>-AR<%= row+14 %>,0)*22%,AG<%= row+14 %>*MAX(AQ<%= row+14 %>-AR<%= row+14 %>,0)*24%),0)"><span
  style='mso-spacerun:yes'>                    </span><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl154 align=right x:num x:fmla="=IF(R<%= row+14 %>&lt;&gt;&quot;&quot;,R<%= row+14 %>,$AA$4)"></td>
  <td class=xl154 align=right x:num x:fmla="=IF(S<%= row+14 %>&lt;&gt;&quot;&quot;,S<%= row+14 %>,$AA$4)"></td>
  <td class=xl154 align=right x:num
  x:fmla="=DATE(YEAR($AA$4),MONTH($AA$4)-1,DAY($AA$4))"></td>
  <td class=xl155 align=right x:num x:fmla="=IF(J<%= row+14 %>&gt;$AB$4,$AB$4,J<%= row+14 %>)"></td>
  <td class=xl155 align=right x:num x:fmla="=IF(N<%= row+14 %>&gt;$AB$4,$AB$4,N<%= row+14 %>)"></td>
  <td class=xl156 align=right x:num x:fmla="=IF(AND(AB<%= row+14 %>&gt;0,AR<%= row+14 %>=0),1,0)"></td>
  <td class=xl156 align=right x:num x:fmla="=IF(AND(AF<%= row+14 %>&gt;0,AR<%= row+14 %>=0),1,0)"></td>
  <td class=xl156 align=right x:num x:fmla="=IF(AND(AD<%= row+14 %>&gt;0,AR<%= row+14 %>=0),1,0)"></td>
  <td class=xl156 align=right x:num x:fmla="=IF(AND(AA<%= row+14 %>&gt;0,AQ<%= row+14 %>=0),1,0)"></td>
  <td class=xl157 x:num x:fmla="=IF(AND((AE<%= row+14 %>&gt;0),(AQ<%= row+14 %>=0)),1,0)"></td>
  <td class=xl157 x:num x:fmla="=IF(AND((AC<%= row+14 %>&gt;0),(AQ<%= row+14 %>=0)),1,0)"></td>
  <td class=xl131 style='border-top:none' x:num
  x:fmla="=IF(OR(T<%= row+14 %>=4.5%,AN<%= row+14 %>&gt;AP<%= row+14 %>),0,(DATEDIF(AN<%= row+14 %>,AP<%= row+14 %>,&quot;m&quot;))+1)"><span
  style='mso-spacerun:yes'>              </span><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl158 style='border-top:none' x:num
  x:fmla="=IF(OR(T<%= row+14 %>=4.5%,T<%= row+14 %>=2%,AY<%= row+14 %>=1,AQ<%= row+14 %>&gt;AR<%= row+14 %>),0,IF(YEAR(AN<%= row+14 %>)&lt;2010,laitt(AG<%= row+14 %>,AY<%= row+14 %>,MAX(AR<%= row+14 %>-AQ<%= row+14 %>)*20%,0.875%),IF(YEAR(AN<%= row+14 %>)&lt;2012,laitt(AG<%= row+14 %>,AY<%= row+14 %>,MAX(AR<%= row+14 %>-AQ<%= row+14 %>)*22%,0.875%),laitt(AG<%= row+14 %>,AY<%= row+14 %>,MAX(AR<%= row+14 %>-AQ<%= row+14 %>)*24%,0.875%))))"></td>
  <td class=xl158 style='border-top:none;border-left:none' x:num
  x:fmla="=IF(OR(AND(YEAR(AN<%= row+14 %>)&lt;=2009,T<%= row+14 %>=20%),AND(YEAR(AN<%= row+14 %>)&lt;2010,T<%= row+14 %>=22%),AND(YEAR(AN<%= row+14 %>)&lt;2012,T<%= row+14 %>=24%),R<%= row+14 %>=26%,AQ<%= row+14 %>&gt;AR<%= row+14 %>,T<%= row+14 %>=4.5%,AY<%= row+14 %>=1),0,IF(YEAR(AN<%= row+14 %>)&lt;2010,laitt(AG<%= row+14 %>,AY<%= row+14 %>,(AR<%= row+14 %>-AQ<%= row+14 %>)*3%,0.75%),laitt(AG<%= row+14 %>,AY<%= row+14 %>,(AR<%= row+14 %>-AQ<%= row+14 %>)*4.5%,0.75%)))"></td>
  <td class=xl159 style='border-top:none;border-left:none' x:num
  x:fmla="=IF(OR(YEAR(AN<%= row+14 %>)&lt;2009,AND(YEAR(AN<%= row+14 %>)&gt;=2010,T<%= row+14 %>=26.5%),AND(YEAR(AN<%= row+14 %>)&gt;2012,T<%= row+14 %>=28.5%),T<%= row+14 %>=4.5%,AQ<%= row+14 %>&gt;AR<%= row+14 %>,AY<%= row+14 %>=1),0,laitt(AG<%= row+14 %>,AY<%= row+14 %>,(AR<%= row+14 %>-AQ<%= row+14 %>)*2%,0.875%))"></td>
  <td class=xl134><%=dt_Emp.Rows[i][29].ToString() %></td>
  <td class=xl135></td>
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
           
      count++;
    }// ket thuc for
     
  %>
 <tr class=xl169 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl160 style='height:21.0pt'></td>
  <td colspan=2 class=xl161 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl162 style='mso-ignore:colspan'></td>
  <td class=xl160></td>
  <td class=xl163></td>
  <td class=xl164></td>
  <td class=xl165></td>
  <td colspan=3 class=xl164 style='mso-ignore:colspan'></td>
  <td class=xl165></td>
  <td class=xl164></td>
  <td class=xl166></td>
  <td colspan=7 class=xl167 style='mso-ignore:colspan'></td>
  <td class=xl168 x:num x:fmla="=SUM(AA12:AA<%= row+14 %>)"><span
  style='mso-spacerun:yes'>                       </span><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl168 x:num x:fmla="=SUM(AB12:AB<%= row+14 %>)"><span
  style='mso-spacerun:yes'>         </span> </td>
  <td class=xl168 x:num x:fmla="=SUM(AC12:AC<%= row+14 %>)"><span
  style='mso-spacerun:yes'>                                      </span><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl168 x:num x:fmla="=SUM(AD12:AD<%= row+14 %>)"><span
  style='mso-spacerun:yes'>               </span> </td>
  <td class=xl168 x:num x:fmla="=SUM(AE12:AE<%= row+14 %>)"><span
  style='mso-spacerun:yes'>                       </span><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl168 x:num x:fmla="=SUM(AF12:AF<%= row+14 %>)"><span
  style='mso-spacerun:yes'>         </span> </td>
  <td class=xl168></td>
  <td class=xl168 x:num x:fmla="=SUM(AH12:AH<%= row+14 %>)"><span
  style='mso-spacerun:yes'>                     </span><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl168 x:num x:fmla="=SUM(AI12:AI<%= row+14 %>)"><span
  style='mso-spacerun:yes'>                  </span><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl168 x:num x:fmla="=SUM(AJ12:AJ<%= row+14 %>)"><span
  style='mso-spacerun:yes'>                     </span><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl168 x:num x:fmla="=SUM(AK12:AK<%= row+14 %>)"><span
  style='mso-spacerun:yes'>                  </span><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl168 x:num x:fmla="=SUM(AL12:AL<%= row+14 %>)"><span
  style='mso-spacerun:yes'>                       </span><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl168 x:num x:fmla="=SUM(AM12:AM<%= row+14 %>)"><span
  style='mso-spacerun:yes'>                     </span><span
  style='mso-spacerun:yes'>   </span></td>
  <td colspan=5 class=xl169 style='mso-ignore:colspan'></td>
  <td class=xl169 align=right x:num x:fmla="=SUM(AS12:AS<%= row+14 %>)"></td>
  <td class=xl169 align=right x:num x:fmla="=SUM(AT12:AT<%= row+14 %>)"></td>
  <td class=xl169 align=right x:num x:fmla="=SUM(AU12:AU<%= row+14 %>)"></td>
  <td class=xl169 align=right x:num x:fmla="=SUM(AV12:AV<%= row+14 %>)"></td>
  <td class=xl169 align=right x:num x:fmla="=SUM(AW12:AW<%= row+14 %>)"></td>
  <td class=xl169 align=right x:num x:fmla="=SUM(AX12:AX<%= row+14 %>)"></td>
  <td class=xl169></td>
  <td class=xl170 align=right x:num x:fmla="=SUM(AZ12:AZ<%= row+14 %>)"></td>
  <td class=xl170 align=right x:num x:fmla="=SUM(BA12:BA<%= row+14 %>)"></td>
  <td class=xl170 align=right x:num x:fmla="=SUM(BB12:BB<%= row+14 %>)"></td>
  <td class=xl171></td>
  <td class=xl169></td>
 </tr>
 <tr class=xl169 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl160 style='height:21.0pt'></td>
  <td colspan=2 class=xl172 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl162 style='mso-ignore:colspan'></td>
  <td class=xl160></td>
  <td class=xl163></td>
  <td class=xl164></td>
  <td class=xl165></td>
  <td colspan=3 class=xl164 style='mso-ignore:colspan'></td>
  <td class=xl165></td>
  <td class=xl164></td>
  <td class=xl166></td>
  <td colspan=7 class=xl167 style='mso-ignore:colspan'></td>
  <td colspan=25 class=xl169 style='mso-ignore:colspan'></td>
  <td class=xl173></td>
  <td colspan=3 class=xl171 style='mso-ignore:colspan'></td>
  <td class=xl169></td>
 </tr>
 <tr class=xl169 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl81 style='height:21.0pt'>B. P<span style='display:none'>PHẦN
  TỔNG HỢP CHUNG</span></td>
  <td class=xl174 width=117 style='width:88pt'>&nbsp;</td>
  <td class=xl174 width=76 style='width:57pt'>&nbsp;</td>
  <td colspan=6 class=xl162 style='mso-ignore:colspan'></td>
  <td class=xl160></td>
  <td class=xl163></td>
  <td class=xl164></td>
  <td class=xl165></td>
  <td colspan=3 class=xl164 style='mso-ignore:colspan'></td>
  <td class=xl165></td>
  <td class=xl164></td>
  <td class=xl166></td>
  <td colspan=7 class=xl167 style='mso-ignore:colspan'></td>
  <td colspan=25 class=xl169 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl170 style='mso-ignore:colspan'></td>
  <td class=xl171></td>
  <td class=xl169></td>
 </tr>
 <tr class=xl177 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl175 style='height:21.0pt'></td>
  <td colspan=2 rowspan=2 class=xl301 width=193 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:145pt'>Phát sinh</td>
  <td colspan=7 class=xl282 width=339 style='border-left:none;width:254pt'>Bảo
  hiểm y tế</td>
  <td colspan=8 class=xl317 width=261 style='border-left:none;width:198pt'>Bảo
  hiểm thất nghiệp</td>
  <td colspan=3 class=xl314 width=158 style='border-left:none;width:119pt'>Bảo
  hiểm xã hội</td>
  <td colspan=5 class=xl176 style='mso-ignore:colspan'></td>
  <td colspan=25 class=xl177 style='mso-ignore:colspan'></td>
  <td class=xl178></td>
  <td colspan=3 class=xl179 style='mso-ignore:colspan'></td>
  <td class=xl177></td>
 </tr>
 <tr class=xl177 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl175 style='height:21.0pt'></td>
  <td colspan=4 class=xl311 width=168 style='border-right:.5pt solid black;
  border-left:none;width:125pt'>Tăng</td>
  <td colspan=3 class=xl311 width=171 style='border-right:.5pt solid black;
  border-left:none;width:129pt'>Giảm</td>
  <td colspan=4 class=xl279 width=145 style='border-right:.5pt solid black;
  border-left:none;width:110pt'>Tăng</td>
  <td colspan=4 class=xl320 width=116 style='border-left:none;width:88pt'>Giảm</td>
  <td class=xl180 width=73 style='border-top:none;border-left:none;width:55pt'>Tăng</td>
  <td colspan=2 class=xl329 width=85 style='width:64pt'>Giảm</td>
  <td colspan=5 class=xl181 style='mso-ignore:colspan'></td>
  <td colspan=25 class=xl177 style='mso-ignore:colspan'></td>
  <td class=xl178></td>
  <td colspan=3 class=xl179 style='mso-ignore:colspan'></td>
  <td class=xl177></td>
 </tr>
 <tr class=xl177 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl175 style='height:21.0pt'></td>
  <td colspan=2 class=xl251>1.Số lao động</td>
  <td colspan=4 class=xl295 width=168 style='border-right:.5pt solid black;
  border-left:none;width:125pt' x:num x:fmla="=AV<%= row+15 %>"></td>
  <td colspan=3 class=xl295 width=171 style='border-right:.5pt solid black;
  border-left:none;width:129pt' x:num x:fmla="=AT<%= row+15 %>"></td>
  <td colspan=4 class=xl276 width=145 style='border-right:.5pt solid black;
  border-left:none;width:110pt' x:num x:fmla="=AX<%= row+15 %>"></td>
  <td colspan=4 class=xl265 width=116 style='border-left:none;width:88pt' x:num x:fmla="=AU<%= row+15 %>" ></td>
  <td class=xl182 width=73 style='border-top:none;border-left:none;width:55pt'
  x:num x:fmla="=AW<%= row+15 %>"></td>
  <td colspan=2 class=xl330 width=85 style='width:64pt' x:num x:fmla="=AT<%= row+15 %>"></td>
  <td colspan=5 class=xl181 style='mso-ignore:colspan'></td>
  <td colspan=25 class=xl177 style='mso-ignore:colspan'></td>
  <td class=xl178></td>
  <td colspan=3 class=xl179 style='mso-ignore:colspan'></td>
  <td class=xl177></td>
 </tr>
 <tr class=xl177 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl175 style='height:21.0pt'></td>
  <td colspan=2 class=xl251>2.Quỹ lương</td>
  <td colspan=4 class=xl298 width=168 style='border-right:.5pt solid black;
  border-left:none;width:125pt' x:num x:fmla="=AA<%= row+15 %>"><span
  style='mso-spacerun:yes'>                                </span></td>
  <td colspan=3 class=xl298 width=171 style='border-right:.5pt solid black;
  border-left:none;width:129pt' x:num x:fmla="=AB<%= row+15 %>"><span
  style='mso-spacerun:yes'>                                 </span></td>
  <td colspan=4 class=xl270 width=145 style='border-right:.5pt solid black;
  border-left:none;width:110pt' x:num x:fmla="=AC<%= row+15 %>"><span
  style='mso-spacerun:yes'>                           </span></td>
  <td colspan=4 class=xl270 width=116 style='border-right:.5pt solid black;
  border-left:none;width:88pt' x:num x:fmla="=AD<%= row+15 %>"><span
  style='mso-spacerun:yes'>               </span></td>
  <td class=xl183 width=73 style='border-top:none;border-left:none;width:55pt'
  x:num x:fmla="=AE<%= row+15 %>"><span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl325 width=85 style='width:64pt' x:num x:fmla="=AF<%= row+15 %>"><span
  style='mso-spacerun:yes'>     </span></td>
  <td colspan=5 class=xl181 style='mso-ignore:colspan'></td>
  <td colspan=25 class=xl177 style='mso-ignore:colspan'></td>
  <td class=xl178></td>
  <td colspan=3 class=xl179 style='mso-ignore:colspan'></td>
  <td class=xl177></td>
 </tr>
 <tr class=xl177 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl177 style='height:21.0pt'></td>
  <td colspan=2 class=xl251>3.Số phải đóng</td>
  <td colspan=4 class=xl252 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=D<%= row+21 %>*4.5%"><span
  style='mso-spacerun:yes'>                                      </span>
  </td>
  <td colspan=3 class=xl252 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=H<%= row+21 %>*4.5%"><span
  style='mso-spacerun:yes'>                                      
  </span></td>
  <td colspan=4 class=xl269 style='border-left:none' x:num x:fmla="=K<%= row+21 %>*2%"><span
  style='mso-spacerun:yes'>                                 </span></td>
  <td colspan=4 class=xl273 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=O<%= row+21 %>*2%"><span style='mso-spacerun:yes'>                    
  </span></td>
  <td class=xl183 width=73 style='border-top:none;border-left:none;width:55pt'
  x:num x:fmla="=S<%= row+21 %>*24%"><span style='mso-spacerun:yes'>   </span></td>
  <td colspan=2 class=xl325 width=85 style='width:64pt' x:num x:fmla="=T<%= row+21 %>*24%"><span
  style='mso-spacerun:yes'>       </span> </td>
  <td colspan=5 class=xl181 style='mso-ignore:colspan'></td>
  <td colspan=25 class=xl177 style='mso-ignore:colspan'></td>
  <td class=xl178></td>
  <td colspan=3 class=xl179 style='mso-ignore:colspan'></td>
  <td class=xl177></td>
 </tr>
 <tr class=xl177 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl177 style='height:21.0pt'></td>
  <td colspan=2 class=xl266 style='border-right:.5pt solid black'>4.Điều chỉnh
  số phải đóng</td>
  <td colspan=4 class=xl252 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=AH<%= row+15 %>+BA<%= row+15 %>"><span
  style='mso-spacerun:yes'>                                   </span> </td>
  <td colspan=3 class=xl253 style='border-right:.5pt solid black' x:num x:fmla="=AI<%= row+15 %>"><span
  style='mso-spacerun:yes'>                                      
  </span></td>
  <td colspan=4 class=xl273 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=AJ<%= row+15 %>+BB<%= row+15 %>"><span
  style='mso-spacerun:yes'>                              </span></td>
  <td colspan=4 class=xl273 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=AK<%= row+15 %>"><span style='mso-spacerun:yes'>                    
  </span></td>
  <td class=xl183 width=73 style='border-top:none;border-left:none;width:55pt'
  x:num x:fmla="=AL<%= row+15 %>+AZ<%= row+15 %>"><span style='mso-spacerun:yes'>   </span>
  </td>
  <td colspan=2 class=xl325 width=85 style='width:64pt' x:num x:fmla="=AM<%= row+15 %>"><span
  style='mso-spacerun:yes'>       </span></td>
  <td colspan=5 class=xl181 style='mso-ignore:colspan'></td>
  <td colspan=25 class=xl177 style='mso-ignore:colspan'></td>
  <td class=xl178></td>
  <td colspan=3 class=xl179 style='mso-ignore:colspan'></td>
  <td class=xl177></td>
 </tr>
 <tr class=xl177 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl184 colspan=2 style='height:19.5pt;mso-ignore:colspan'>Phần
  CQ BHXH ghi:</td>
  <td colspan=6 class=xl186 style='mso-ignore:colspan'></td>
  <td class=xl187></td>
  <td class=xl186></td>
  <td class=xl187></td>
  <td colspan=3 class=xl268>Phần đơn vị ghi:</td>
  <td colspan=2 class=xl177 style='mso-ignore:colspan'></td>
  <td class=xl188></td>
  <td colspan=34 class=xl177 style='mso-ignore:colspan'></td>
  <td class=xl178></td>
  <td colspan=3 class=xl179 style='mso-ignore:colspan'></td>
  <td class=xl177></td>
 </tr>
 <tr class=xl177 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl185 style='height:19.5pt'></td>
  <td class=xl189>Tổng số tờ khai:</td>
  <td colspan=6 class=xl186 style='mso-ignore:colspan'></td>
  <td class=xl187></td>
  <td class=xl190>&nbsp;</td>
  <td class=xl187></td>
  <td colspan=5 class=xl177 style='mso-ignore:colspan'></td>
  <td class=xl188></td>
  <td colspan=34 class=xl177 style='mso-ignore:colspan'></td>
  <td class=xl178></td>
  <td colspan=3 class=xl179 style='mso-ignore:colspan'></td>
  <td class=xl177></td>
 </tr>
 <tr class=xl177 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl185 style='height:19.5pt'></td>
  <td class=xl189 colspan=2 style='mso-ignore:colspan'>Tồng số sổ BHXH đề nghị cấp:</td>
  <td colspan=5 class=xl186 style='mso-ignore:colspan'></td>
  <td class=xl187></td>
  <td class=xl190>&nbsp;</td>
  <td class=xl187></td>
  <td colspan=5 class=xl177 style='mso-ignore:colspan'></td>
  <td class=xl188></td>
  <td colspan=34 class=xl177 style='mso-ignore:colspan'></td>
  <td class=xl178></td>
  <td colspan=3 class=xl179 style='mso-ignore:colspan'></td>
  <td class=xl177></td>
 </tr>
 <tr class=xl177 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl185 style='height:19.5pt'></td>
  <td class=xl189 colspan=2 style='mso-ignore:colspan'>Tổng số thẻ BHYT đề nghị cấp:</td>
  <td colspan=5 class=xl186 style='mso-ignore:colspan'></td>
  <td class=xl187>Thời hạn từ……. đến………………</td>
  <td class=xl190>&nbsp;</td>
  <td class=xl187></td>
  <td class=xl189 colspan=5 style='mso-ignore:colspan'>Tồng số thẻ BHYT đề
  nghị cấp:</td>
  <td colspan=2 class=xl186 style='mso-ignore:colspan'></td>
  <td class=xl177></td>
  <td class=xl187>Thời hạn từ……. đến………………</td>
  <td colspan=31 class=xl177 style='mso-ignore:colspan'></td>
  <td class=xl178></td>
  <td colspan=3 class=xl179 style='mso-ignore:colspan'></td>
  <td class=xl177></td>
 </tr>
 <tr class=xl177 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=2 class=xl185 style='height:19.5pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl186 style='mso-ignore:colspan'></td>
  <td class=xl187></td>
  <td class=xl190>&nbsp;</td>
  <td class=xl187></td>
  <td colspan=5 class=xl177 style='mso-ignore:colspan'></td>
  <td class=xl188></td>
  <td class=xl177></td>
  <td colspan=3 class=xl195>Ngày<span style='mso-spacerun:yes'> 
  </span><%= DateTime.Now.Day.ToString() %><span style='mso-spacerun:yes'>  </span>tháng<span
  style='mso-spacerun:yes'>  </span><%= DateTime.Now.Month.ToString() %><span style='mso-spacerun:yes'> 
  </span>năm<span style='mso-spacerun:yes'>  </span><%= DateTime.Now.Year.ToString() %></td>
  <td colspan=30 class=xl177 style='mso-ignore:colspan'></td>
  <td class=xl178></td>
  <td colspan=3 class=xl179 style='mso-ignore:colspan'></td>
  <td class=xl177></td>
 </tr>
 <tr class=xl177 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl185 style='height:19.5pt'></td>
  <td class=xl191>Cán bộ thụ</td>
  <td colspan=3 class=xl186 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl191>Cán bộ sổ, thẻ</td>
  <td class=xl192></td>
  <td class=xl190>&nbsp;</td>
  <td class=xl187></td>
  <td class=xl177></td>
  <td colspan=3 class=xl191>Người lập biểu</td>
  <td class=xl177></td>
  <td class=xl188></td>
  <td class=xl177></td>
  <td colspan=3 class=xl191>Thủ trưởng đơn vị</td>
  <td colspan=30 class=xl177 style='mso-ignore:colspan'></td>
  <td class=xl178></td>
  <td colspan=3 class=xl179 style='mso-ignore:colspan'></td>
  <td class=xl177></td>
 </tr>
 <tr class=xl177 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=2 class=xl185 style='height:19.5pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl186 style='mso-ignore:colspan'></td>
  <td class=xl187></td>
  <td class=xl190>&nbsp;</td>
  <td class=xl187></td>
  <td colspan=5 class=xl177 style='mso-ignore:colspan'></td>
  <td class=xl188></td>
  <td colspan=34 class=xl177 style='mso-ignore:colspan'></td>
  <td class=xl178></td>
  <td colspan=3 class=xl179 style='mso-ignore:colspan'></td>
  <td class=xl177></td>
 </tr>
 <tr class=xl177 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=2 class=xl185 style='height:19.5pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl186 style='mso-ignore:colspan'></td>
  <td class=xl187></td>
  <td class=xl186></td>
  <td class=xl187></td>
  <td colspan=5 class=xl177 style='mso-ignore:colspan'></td>
  <td class=xl188></td>
  <td colspan=34 class=xl177 style='mso-ignore:colspan'></td>
  <td class=xl178></td>
  <td colspan=3 class=xl179 style='mso-ignore:colspan'></td>
  <td class=xl177></td>
 </tr>
 <tr class=xl177 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=2 height=26 class=xl195 style='height:19.5pt'></td>
  <td colspan=6 class=xl186 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl187 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl193 style='mso-ignore:colspan'></td>
  <td class=xl195></td>
  <td colspan=37 class=xl177 style='mso-ignore:colspan'></td>
  <td class=xl178></td>
  <td colspan=3 class=xl179 style='mso-ignore:colspan'></td>
  <td class=xl177></td>
 </tr>
 <tr class=xl177 height=19 style='height:14.25pt'>
  <td height=19 colspan=3 class=xl177 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl196 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl197 style='mso-ignore:colspan'></td>
  <td class=xl198></td>
  <td colspan=2 class=xl198 width=85 style='width:64pt'></td>
  <td colspan=5 class=xl199 style='mso-ignore:colspan'></td>
  <td colspan=25 class=xl177 style='mso-ignore:colspan'></td>
  <td class=xl178></td>
  <td colspan=3 class=xl179 style='mso-ignore:colspan'></td>
  <td class=xl177></td>
 </tr>
 <tr class=xl200 height=19 style='height:14.25pt'>
  <td height=19 colspan=3 class=xl200 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl201 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl202 style='mso-ignore:colspan'></td>
  <td class=xl203></td>
  <td colspan=2 class=xl203 width=85 style='width:64pt'></td>
  <td colspan=30 class=xl200 style='mso-ignore:colspan'></td>
  <td class=xl204></td>
  <td colspan=3 class=xl205 style='mso-ignore:colspan'></td>
  <td class=xl200></td>
 </tr>
 <tr class=xl86 height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl86 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl206 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl207 style='mso-ignore:colspan'></td>
  <td class=xl203></td>
  <td colspan=2 class=xl203 width=85 style='width:64pt'></td>
  <td colspan=30 class=xl86 style='mso-ignore:colspan'></td>
  <td class=xl208></td>
  <td colspan=3 class=xl90 style='mso-ignore:colspan'></td>
  <td class=xl86></td>
 </tr>
 <tr class=xl86 height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl86 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl206 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl207 style='mso-ignore:colspan'></td>
  <td class=xl203></td>
  <td colspan=2 class=xl203 width=85 style='width:64pt'></td>
  <td colspan=30 class=xl86 style='mso-ignore:colspan'></td>
  <td class=xl208></td>
  <td colspan=3 class=xl90 style='mso-ignore:colspan'></td>
  <td class=xl86></td>
 </tr>
 <tr class=xl86 height=21 style='height:15.75pt'>
  <td height=21 colspan=11 class=xl86 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl209 style='mso-ignore:colspan'></td>
  <td class=xl210></td>
  <td colspan=35 class=xl86 style='mso-ignore:colspan'></td>
  <td class=xl208></td>
  <td colspan=3 class=xl90 style='mso-ignore:colspan'></td>
  <td class=xl86></td>
 </tr>
 <tr class=xl86 height=21 style='height:15.75pt'>
  <td height=21 colspan=11 class=xl86 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl209 style='mso-ignore:colspan'></td>
  <td class=xl210></td>
  <td colspan=35 class=xl86 style='mso-ignore:colspan'></td>
  <td class=xl208></td>
  <td colspan=3 class=xl90 style='mso-ignore:colspan'></td>
  <td class=xl86></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl211 style='height:14.25pt'></td>
  <td colspan=10 class=xl67 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl84 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl67 style='mso-ignore:colspan'></td>
  <td class=xl84></td>
  <td colspan=32 class=xl67 style='mso-ignore:colspan'></td>
  <td class=xl212></td>
  <td colspan=3 class=xl213 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
 </tr>
 <tr class=xl169 height=19 style='height:14.25pt'>
  <td height=19 class=xl160 style='height:14.25pt'></td>
  <td class=xl214></td>
  <td colspan=11 class=xl169 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl164 style='mso-ignore:colspan'></td>
  <td colspan=35 class=xl169 style='mso-ignore:colspan'></td>
  <td class=xl173></td>
  <td colspan=3 class=xl171 style='mso-ignore:colspan'></td>
  <td class=xl169></td>
 </tr>
 <tr class=xl169 height=18 style='height:13.5pt'>
  <td height=18 class=xl160 style='height:13.5pt'></td>
  <td colspan=12 class=xl169 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl164 style='mso-ignore:colspan'></td>
  <td colspan=35 class=xl169 style='mso-ignore:colspan'></td>
  <td class=xl173></td>
  <td colspan=3 class=xl171 style='mso-ignore:colspan'></td>
  <td class=xl169></td>
 </tr>
 <tr class=xl169 height=18 style='height:13.5pt'>
  <td height=18 class=xl160 style='height:13.5pt'></td>
  <td colspan=12 class=xl169 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl164 style='mso-ignore:colspan'></td>
  <td colspan=35 class=xl169 style='mso-ignore:colspan'></td>
  <td class=xl173></td>
  <td colspan=3 class=xl171 style='mso-ignore:colspan'></td>
  <td class=xl169></td>
 </tr>
 <tr class=xl169 height=18 style='height:13.5pt'>
  <td height=18 class=xl160 style='height:13.5pt'></td>
  <td colspan=12 class=xl169 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl164 style='mso-ignore:colspan'></td>
  <td colspan=35 class=xl169 style='mso-ignore:colspan'></td>
  <td class=xl173></td>
  <td colspan=3 class=xl171 style='mso-ignore:colspan'></td>
  <td class=xl169></td>
 </tr>
 <tr class=xl169 height=18 style='height:13.5pt'>
  <td height=18 class=xl160 style='height:13.5pt'></td>
  <td colspan=12 class=xl169 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl164 style='mso-ignore:colspan'></td>
  <td colspan=35 class=xl169 style='mso-ignore:colspan'></td>
  <td class=xl173></td>
  <td colspan=3 class=xl171 style='mso-ignore:colspan'></td>
  <td class=xl169></td>
 </tr>
 <tr class=xl169 height=18 style='height:13.5pt'>
  <td height=18 colspan=13 class=xl169 style='height:13.5pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl164 style='mso-ignore:colspan'></td>
  <td colspan=35 class=xl169 style='mso-ignore:colspan'></td>
  <td class=xl173></td>
  <td colspan=3 class=xl171 style='mso-ignore:colspan'></td>
  <td class=xl169></td>
 </tr>
 <tr class=xl169 height=18 style='height:13.5pt'>
  <td height=18 colspan=13 class=xl169 style='height:13.5pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl164 style='mso-ignore:colspan'></td>
  <td colspan=35 class=xl169 style='mso-ignore:colspan'></td>
  <td class=xl173></td>
  <td colspan=3 class=xl171 style='mso-ignore:colspan'></td>
  <td class=xl169></td>
 </tr>
 <tr class=xl169 height=18 style='height:13.5pt'>
  <td height=18 class=xl160 style='height:13.5pt'></td>
  <td colspan=12 class=xl169 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl164 style='mso-ignore:colspan'></td>
  <td colspan=35 class=xl169 style='mso-ignore:colspan'></td>
  <td class=xl173></td>
  <td colspan=3 class=xl171 style='mso-ignore:colspan'></td>
  <td class=xl169></td>
 </tr>
 <tr class=xl169 height=18 style='height:13.5pt'>
  <td height=18 class=xl160 style='height:13.5pt'></td>
  <td colspan=11 class=xl169 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl164 style='mso-ignore:colspan'></td>
  <td colspan=35 class=xl169 style='mso-ignore:colspan'></td>
  <td class=xl173></td>
  <td colspan=3 class=xl171 style='mso-ignore:colspan'></td>
  <td class=xl169></td>
 </tr>
 <tr class=xl169 height=18 style='height:13.5pt'>
  <td height=18 class=xl160 style='height:13.5pt'></td>
  <td colspan=10 class=xl169 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl164 style='mso-ignore:colspan'></td>
  <td colspan=35 class=xl169 style='mso-ignore:colspan'></td>
  <td class=xl173></td>
  <td colspan=3 class=xl171 style='mso-ignore:colspan'></td>
  <td class=xl169></td>
 </tr>
 <tr class=xl216 height=18 style='height:13.5pt'>
  <td height=18 class=xl215 style='height:13.5pt'></td>
  <td colspan=10 class=xl216 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl219 style='mso-ignore:colspan'></td>
  <td colspan=35 class=xl216 style='mso-ignore:colspan'></td>
  <td class=xl220></td>
  <td colspan=3 class=xl221 style='mso-ignore:colspan'></td>
  <td class=xl216></td>
 </tr>
 <tr class=xl169 height=18 style='height:13.5pt'>
  <td height=18 class=xl160 style='height:13.5pt'></td>
  <td colspan=9 class=xl169 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl164 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl169 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl222 style='mso-ignore:colspan'></td>
  <td colspan=25 class=xl169 style='mso-ignore:colspan'></td>
  <td class=xl173></td>
  <td colspan=3 class=xl171 style='mso-ignore:colspan'></td>
  <td class=xl169></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=28 style='width:21pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=35 style='width:26pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=17 style='width:13pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=133 style='width:100pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=64 style='width:48pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=0></td>
  <td width=0></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
