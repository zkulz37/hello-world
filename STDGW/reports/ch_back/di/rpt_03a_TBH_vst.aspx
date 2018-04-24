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
        ",decode(nvl(a.TRA_THE_YN,'N'),'Y','X','') as c21 " +
        ",a.SO_THANG as c22 " +
        ",a.DC_TANG_XH as c23 " +
        ",a.DC_GIAM_XH as c24 " +
        ",a.DC_TANG_YT as c25 " +
        ",a.DC_GIAM_YT as c26 " +
        ",a.ghi_chu as c27 " +
        ",a.EMP_ID as c28 " +
        ",'HĐ số ' || A.MA_HOP_DONG || '(' ||  TO_CHAR(TO_DATE(A.NGAY_KY_HD,'YYYYMMDD'),'DD/MM/YYYY') || ')' as c29 " +
        ",nvl(a.CL_TANG_TN,0) as c30 " +
        ",nvl(a.CL_GIAM_TN,0) as c31 " +
        ",a.DC_TANG_TN as c32 " +
        ",a.DC_GIAM_TN as c33 " +
        ",(select v.code_fnm from vhr_hr_code v where v.id='HR0008' and v.code=nvl(e.pos_type,' ') ) as c34 " +
        ",(select v.code_fnm from vhr_hr_code v where v.id='HR0001' and v.code=nvl(e.contract_type,' ') ) as c35 " +
        "from THR_INSURANCE_MANAGE a,thr_employee e, " +
        "(select code,num_1,CHAr_3 from vhr_hr_code where id='HR0041') ins_type " +
        "where a.del_if=0 and a.LOAI_BH=ins_type.code and a.loai_bh <> '01'" +
        "and a.THANG_BC='" + p_rpt_month + "' " +
        "and a.LAN_BAO='" + p_times + "' and e.del_if=0 and a.thr_emp_pk= e.pk " +
        "order by ins_type.num_1,a.emp_id " ;


//Response.Write(SQL);
//Response.End();
    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp=dt_Emp.Columns.Count;
    /*if (irow_emp == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }*/
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
        ",sum(nvl(a.CL_TANG_XH,0))*0.02 as c2txh21 " +
        ",sum(nvl(a.CL_TANG_YT,0))*0.02 as c2tyt22 " +
        ",sum(nvl(a.CL_TANG_TN,0))*0.02 as c2ttn23 " +
        ",sum(nvl(a.CL_Giam_XH,0))*0.02 as c2txh21 " +
        ",sum(nvl(a.CL_Giam_YT,0))*0.02 as c2tyt22 " +
        ",sum(nvl(a.CL_Giam_TN,0))*0.02 as c2ttn23 " +        
        "from thr_insurance_manage a " +
        "where a.del_if=0  " +
        "and a.THANG_BC='" + p_rpt_month + "' " +
        "and a.LAN_BAO='" + p_times + "' and a.loai_bh <> '01' " ;
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
<link rel=File-List href="rpt_03a_TBH_vst_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_03a_TBH_vst_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_03a_TBH_vst_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>BHXH Dong Nai</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2011-04-27T04:24:12Z</o:LastPrinted>
  <o:Created>2008-03-17T06:49:57Z</o:Created>
  <o:LastSaved>2011-04-27T04:24:53Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.17in 0in .16in .17in;
	mso-header-margin:.17in;
	mso-footer-margin:0in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style23
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
	font-family:VNI-Times;
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
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
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
.xl46
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl47
	{mso-style-parent:style0;
	color:red;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl48
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl49
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl50
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl51
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl52
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;}
.xl53
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl54
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;}
.xl55
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;}
.xl56
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl57
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;}
.xl58
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;}
.xl60
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;}
.xl61
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;}
.xl71
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\\\/yyyy";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl85
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style23;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style23;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl95
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\\\/yyyy";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl96
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl97
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl99
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl100
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl101
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl102
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl103
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl104
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl105
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl106
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl107
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:normal;}
.xl108
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl109
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl110
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl111
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl112
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl113
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";}
.xl114
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl115
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl116
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl117
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl118
	{mso-style-parent:style23;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl119
	{mso-style-parent:style23;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl120
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl121
	{mso-style-parent:style23;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl122
	{mso-style-parent:style23;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl123
	{mso-style-parent:style23;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl124
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl125
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl126
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl127
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl128
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;}
.xl129
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl130
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl131
	{mso-style-parent:style0;
	color:red;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl132
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl133
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl134
	{mso-style-parent:style0;
	color:white;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl135
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl136
	{mso-style-parent:style0;
	color:white;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl137
	{mso-style-parent:style23;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl138
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.000";}
.xl139
	{mso-style-parent:style23;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.000";}
.xl140
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl141
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl142
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl143
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl144
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl145
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl146
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl147
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl148
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl149
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl150
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl151
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>03a</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>92</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>35</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:Sorting>
     <x:Sort>Column D</x:Sort>
    </x:Sorting>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>6915</x:WindowHeight>
  <x:WindowWidth>11640</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>180</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Document_array</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>={&quot;Book1&quot;}</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Document_array</x:Name>
  <x:Formula>={&quot;Book1&quot;}</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl48>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1774 style='border-collapse:
 collapse;table-layout:fixed;width:1334pt'>
 <col class=xl108 width=30 style='mso-width-source:userset;mso-width-alt:960;
 width:23pt'>
 <col class=xl48 width=189 style='mso-width-source:userset;mso-width-alt:6048;
 width:142pt'>
 <col class=xl108 width=82 style='mso-width-source:userset;mso-width-alt:2624;
 width:62pt'>
 <col class=xl48 width=81 style='mso-width-source:userset;mso-width-alt:2592;
 width:61pt'>
 <col class=xl48 width=91 style='mso-width-source:userset;mso-width-alt:2912;
 width:68pt'>
 <col class=xl48 width=38 style='mso-width-source:userset;mso-width-alt:1216;
 width:29pt'>
 <col class=xl48 width=29 style='mso-width-source:userset;mso-width-alt:928;
 width:22pt'>
 <col class=xl48 width=38 style='mso-width-source:userset;mso-width-alt:1216;
 width:29pt'>
 <col class=xl48 width=35 style='mso-width-source:userset;mso-width-alt:1120;
 width:26pt'>
 <col class=xl48 width=91 style='mso-width-source:userset;mso-width-alt:2912;
 width:68pt'>
 <col class=xl48 width=38 span=4 style='mso-width-source:userset;mso-width-alt:
 1216;width:29pt'>
 <col class=xl48 width=71 span=2 style='mso-width-source:userset;mso-width-alt:
 2272;width:53pt'>
 <col class=xl48 width=60 style='mso-width-source:userset;mso-width-alt:1920;
 width:45pt'>
 <col class=xl48 width=48 span=2 style='mso-width-source:userset;mso-width-alt:
 1536;width:36pt'>
 <col class=xl48 width=44 style='mso-width-source:userset;mso-width-alt:1408;
 width:33pt'>
 <col class=xl47 width=72 span=8 style='width:54pt'>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=20 height=24 class=xl46 width=1198 style='height:18.0pt;
  width:902pt'>DANH SÁCH<span style='mso-spacerun:yes'>  </span>LAO ĐỘNG ĐIỀU
  CHỈNH ĐÓNG BHXH, BHYT, BẢO HIỂM THẤT NGHIỆP</td>
  <td class=xl47 width=72 style='width:54pt'></td>
  <td class=xl47 width=72 style='width:54pt'></td>
  <td class=xl47 width=72 style='width:54pt'></td>
  <td class=xl47 width=72 style='width:54pt'></td>
  <td class=xl47 width=72 style='width:54pt'></td>
  <td class=xl47 width=72 style='width:54pt'></td>
  <td class=xl47 width=72 style='width:54pt'></td>
  <td class=xl47 width=72 style='width:54pt'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td colspan=20 height=18 class=xl49 style='height:13.5pt'><span
  style='mso-spacerun:yes'> </span>Số 01 Tháng <%=p_rpt_month.Substring(4,2) %> Năm <%=p_rpt_month.Substring(0,4) %></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl50 style='height:12.75pt'></td>
  <td class=xl51 colspan=3 style='mso-ignore:colspan'>Tên cơ quan ( đơn vị ):
  <%=dt_name.Rows[0][0].ToString() %></td>
  <td colspan=3 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl54 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl55>Mẫu: 03a- TBH</td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl50 style='height:13.5pt'></td>
  <td class=xl56>Mã đơn vị : <%=dt_name.Rows[1][0].ToString() %></td>
  <td class=xl52></td>
  <td class=xl57></td>
  <td colspan=6 class=xl54 style='mso-ignore:colspan'></td>
  <td colspan=10 rowspan=2 class=xl58 width=494 style='width:372pt'>(Ban hành
  kèm theo CV số 1615/BHXH-CSXH <br>
    ngày 02/06/2009 của BHXH Việt Nam)</td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl50 style='height:15.0pt'></td>
  <td class=xl56 colspan=2 style='mso-ignore:colspan'>Địa chỉ : <%=dt_name.Rows[2][0].ToString() %></td>
  <td class=xl57></td>
  <td colspan=2 class=xl54 style='mso-ignore:colspan'></td>
  <td class=xl59 colspan=4 style='mso-ignore:colspan'>Điện thoại: 0613.560360</td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl55 style='height:15.75pt'>A. PHẦN CHI TIẾT</td>
  <td class=xl52></td>
  <td colspan=3 class=xl53 style='mso-ignore:colspan'></td>
  <td class=xl54></td>
  <td colspan=2 class=xl52></td>
  <td class=xl52></td>
  <td colspan=5 class=xl52></td>
  <td colspan=5 class=xl60 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td rowspan=4 height=133 class=xl140 width=30 style='border-bottom:.5pt hairline black;
  height:99.75pt;width:23pt'>STT</td>
  <td rowspan=4 class=xl140 width=189 style='border-bottom:.5pt hairline black;
  width:142pt'>Họ và tên</td>
  <td rowspan=4 class=xl140 width=82 style='border-bottom:.5pt hairline black;
  width:62pt'>Số sổ BHXH</td>
  <td rowspan=4 class=xl140 width=81 style='border-bottom:.5pt hairline black;
  width:61pt'>Chức vụ hoặc chức danh nghề</td>
  <td colspan=10 class=xl63 style='border-left:none'>Tiền lương và phụ cấp</td>
  <td colspan=2 class=xl62 width=142 style='border-left:none;width:106pt'
  x:str="Thời gian ">Thời gian<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=4 class=xl62 width=60 style='width:45pt'>Tỷ lệ bổ sung</td>
  <td rowspan=4 class=xl62 width=48 style='width:36pt'>HĐLĐ<br>
    (số, ngày tháng năm)</td>
  <td colspan=2 class=xl62 width=92 style='border-right:2.0pt double black;
  border-left:none;width:69pt'>Ghi chú<br>
    </td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=5 height=27 class=xl67 style='height:20.25pt;border-left:none'>Mức
  cũ</td>
  <td colspan=5 class=xl66 width=243 style='border-left:none;width:184pt'>Mức
  mới</td>
  <td rowspan=3 class=xl66 width=71 style='border-top:none;width:53pt'>Từ
  <br>
    tháng năm</td>
  <td rowspan=3 class=xl66 width=71 style='border-top:none;width:53pt'>Đến
  <br>
    tháng năm</td>
  <td rowspan=3 class=xl66 width=48 style='border-top:none;width:36pt'>Trả thẻ
  <br>
    đánh dấu X</td>
  <td rowspan=3 class=xl68 width=44 style='border-top:none;width:33pt'>Khác</td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td rowspan=2 height=66 class=xl146 width=91 style='border-bottom:.5pt hairline black;
  height:49.5pt;border-top:none;width:68pt'>Tiền lương, tiền công</td>
  <td colspan=4 class=xl143 style='border-right:.5pt solid black;border-left:
  none'>Phụ cấp</td>
  <td rowspan=2 class=xl146 width=91 style='border-bottom:.5pt hairline black;
  border-top:none;width:68pt'>Tiền lương, tiền công</td>
  <td colspan=4 class=xl143 style='border-right:.5pt solid black;border-left:
  none'>Phụ cấp</td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=43 style='mso-height-source:userset;height:32.25pt'>
  <td height=43 class=xl69 width=38 style='height:32.25pt;border-top:none;
  border-left:none;width:29pt'>Chức vụ</td>
  <td class=xl69 width=29 style='border-top:none;border-left:none;width:22pt'>TNVK</td>
  <td class=xl69 width=38 style='border-top:none;border-left:none;width:29pt'>TN
  nghề</td>
  <td class=xl69 width=35 style='border-top:none;border-left:none;width:26pt'>Khác</td>
  <td class=xl69 width=38 style='border-top:none;border-left:none;width:29pt'>Chức
  vụ</td>
  <td class=xl69 width=38 style='border-top:none;border-left:none;width:29pt'>TNVK</td>
  <td class=xl69 width=38 style='border-top:none;border-left:none;width:29pt'>TN
  nghề</td>
  <td class=xl69 width=38 style='border-top:none;border-left:none;width:29pt'>Khác</td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl70 style='height:15.75pt;border-top:none' x:num>1</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num>7</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num>8</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num>9</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num>10</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num>11</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num>12</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num>13</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num>14</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num>15</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num>16</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num>17</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num>18</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num>19</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num>20</td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
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
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl73 width=30 style='height:18.0pt;border-top:none;
  width:23pt'><%=atype[j]%></td>
  <td class=xl74 width=189 style='border-top:none;border-left:none;width:142pt'><%=cur_type %></td>
  <td class=xl75 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl78 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl79 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl81 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl81 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl79 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl82 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl83 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
  <%     bchange=false;
            j+=1;
        }//ket thuc doi group%>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl84 width=30 style='height:18.0pt;border-top:none;
  width:23pt' x:num><%=irow_type %></td>
  <td class=xl85 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][1].ToString() %></td>
  <td class=xl75 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][2].ToString() %></td>
  <td class=xl76 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][33].ToString() %></td>
  <td class=xl86 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                         </span><%=dt_Emp.Rows[i][3].ToString() %> </td>
  <td class=xl78 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][4].ToString() %></td>
  <td class=xl75 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][5].ToString() %></td>
  <td class=xl75 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][6].ToString() %></td>
  <td class=xl75 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][7].ToString() %></td>
  <td class=xl79 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][8].ToString() %></td>
  <td class=xl80 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][9].ToString() %></td>
  <td class=xl80 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][10].ToString() %></td>
  <td class=xl80 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][11].ToString() %></td>
  <td class=xl80 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][12].ToString() %></td>
  <td class=xl81 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][17].ToString() %></td>
  <td class=xl81 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][18].ToString() %></td>
  <td class=xl79 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][19].ToString() %></td>
  <td class=xl82 align=right style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][28].ToString() %></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][26].ToString() %></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][27].ToString() %></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <%        
    } //ket thuc vong for
  %>
 
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=2 height=23 class=xl99 width=219 style='height:17.25pt;
  width:165pt'>Cộng</td>
  <td class=xl101 style='border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-left:none'>&nbsp;</td>
  <td class=xl103 align=right style='border-left:none' x:num
  ><%=dLuongCuT %></td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'><%=dLuongMoiT %></td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl104 style='border-left:none'>&nbsp;</td>
  <td class=xl104 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none'>&nbsp;</td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=9 style='mso-height-source:userset;height:6.75pt'>
  <td height=9 class=xl106 style='height:6.75pt'></td>
  <td class=xl107></td>
  <td class=xl108></td>
  <td class=xl48></td>
  <td class=xl109></td>
  <td colspan=4 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl109></td>
  <td colspan=4 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl110 style='mso-ignore:colspan'></td>
  <td class=xl48></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  360'>
  <td height=0 colspan=2 class=xl111 style='mso-ignore:colspan'></td>
  <td class=xl112></td>
  <td class=xl111></td>
  <td class=xl109></td>
  <td colspan=4 class=xl111 style='mso-ignore:colspan'></td>
  <td class=xl113></td>
  <td colspan=4 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl110 style='mso-ignore:colspan'></td>
  <td class=xl48></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl112 style='height:15.0pt'></td>
  <td colspan=2 rowspan=2 class=xl61 width=271 style='width:204pt'>Phát sinh</td>
  <td colspan=6 class=xl114 style='border-left:none'>Bảo hiểm y tế</td>
  <td colspan=5 class=xl114 style='border-left:none'>Bảo hiểm xã hội</td>
  <td colspan=6 class=xl114 style='border-right:2.0pt double black;border-left:
  none'>Bảo hiểm thất nghiệp</td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl112 style='height:14.25pt'></td>
  <td colspan=2 class=xl116 style='border-left:none' x:str="Tăng ">Tăng<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl116 style='border-left:none'>Giảm</td>
  <td colspan=2 class=xl116 style='border-left:none' x:str="Tăng ">Tăng<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl116 style='border-left:none'>Giảm</td>
  <td colspan=3 class=xl116 style='border-left:none' x:str="Tăng ">Tăng<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl116 style='border-right:2.0pt double black;border-left:
  none'>Giảm</td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl112 style='height:14.25pt'></td>
  <td colspan=2 class=xl148 width=271 style='border-right:.5pt solid black;
  width:204pt'>1. Số lao động</td>
  <td colspan=2 class=xl118 width=172 style='border-left:none;width:129pt'
  x:num><span
  style='mso-spacerun:yes'>                                                   
  </span><%=dt_sum.Rows[0][0].ToString()%>  </td>
  <td colspan=4 class=xl79 style='border-left:none' x:num><%=dt_sum.Rows[0][1].ToString()%> </td>
  <td colspan=2 class=xl119 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                                      </span><%=dt_sum.Rows[0][0].ToString()%>  </td>
  <td colspan=3 class=xl80 style='border-left:none' x:num><%=dt_sum.Rows[0][1].ToString()%> </td>
  <td colspan=3 class=xl120 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                                                             
  </span><%=dt_sum.Rows[0][0].ToString()%> </td>
  <td colspan=3 class=xl79 style='border-right:2.0pt double black;border-left:
  none' x:num><%=dt_sum.Rows[0][1].ToString()%> </td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl108 style='height:14.25pt'></td>
  <td colspan=2 class=xl148 width=271 style='border-right:.5pt solid black;
  width:204pt'>2. Quỹ lương</td>
  <td colspan=2 class=xl118 width=172 style='border-left:none;width:129pt'
  x:num><span
  style='mso-spacerun:yes'>                                                   
  </span><%=dt_sum.Rows[0][2].ToString()%> </td>
  <td colspan=4 class=xl79 style='border-left:none' x:num><%=dt_sum.Rows[0][3].ToString()%></td>
  <td colspan=2 class=xl119 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                                      </span><%=dt_sum.Rows[0][4].ToString()%> </td>
  <td colspan=3 class=xl79 style='border-left:none' x:num><%=dt_sum.Rows[0][5].ToString()%></td>
  <td colspan=3 class=xl120 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                                                             
  </span><%=dt_sum.Rows[0][14].ToString()%> </td>
  <td colspan=3 class=xl79 style='border-right:2.0pt double black;border-left:
  none' x:num><%=dt_sum.Rows[0][15].ToString()%></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl108 style='height:14.25pt'></td>
  <td colspan=2 class=xl148 width=271 style='border-right:.5pt solid black;
  width:204pt'>3. Số phải nộp</td>
  <td colspan=2 class=xl118 width=172 style='border-left:none;width:129pt'
  x:num><span
  style='mso-spacerun:yes'>                                                   
  </span><%=dt_sum.Rows[0][6].ToString()%> </td>
  <td colspan=4 class=xl79 style='border-left:none' x:num><%=dt_sum.Rows[0][7].ToString()%></td>
  <td colspan=2 class=xl119 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                                      </span><%=dt_sum.Rows[0][8].ToString()%> </td>
  <td colspan=3 class=xl79 style='border-left:none' x:num><%=dt_sum.Rows[0][9].ToString()%></td>
  <td colspan=3 class=xl120 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                                                             
  </span><%=dt_sum.Rows[0][16].ToString()%></td>
  <td colspan=3 class=xl79 style='border-right:2.0pt double black;border-left:
  none' x:num><%=dt_sum.Rows[0][17].ToString()%></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl108 style='height:14.25pt'></td>
  <td colspan=2 class=xl150 width=271 style='border-right:.5pt solid black;
  width:204pt'>4. Điều chỉnh số phải nộp</td>
  <td colspan=2 class=xl121 width=172 style='border-left:none;width:129pt'
  x:num><span
  style='mso-spacerun:yes'>                                                   
  </span><%=dt_sum.Rows[0][20].ToString()%></td>
  <td colspan=4 class=xl122 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                                          </span><%=dt_sum.Rows[0][23].ToString()%> </td>
  <td colspan=2 class=xl123 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                                      </span><%=dt_sum.Rows[0][21].ToString()%> </td>
  <td colspan=3 class=xl124 style='border-left:none' x:num><%=dt_sum.Rows[0][24].ToString()%></td>
  <td colspan=3 class=xl125 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                                                             
  </span><%=dt_sum.Rows[0][22].ToString()%></td>
  <td colspan=3 class=xl124 style='border-right:2.0pt double black;border-left:
  none' x:num><%=dt_sum.Rows[0][25].ToString()%></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl108 style='height:16.5pt'></td>
  <td class=xl127>Tổng số thẻ đã thu hồi:</td>
  <td class=xl108></td>
  <td class=xl48>phiếu</td>
  <td class=xl49></td>
  <td colspan=4 class=xl52 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl128 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl128 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl108 style='height:15.75pt'></td>
  <td class=xl127>Tổng số thẻ chưa thu hồi:</td>
  <td class=xl108></td>
  <td class=xl48>phiếu</td>
  <td class=xl49></td>
  <td colspan=4 class=xl52 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl128 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl128 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl108 style='height:12.75pt'></td>
  <td class=xl48></td>
  <td class=xl127 colspan=3 style='mso-ignore:colspan'>Nhơn trạch, ngày<span
  style='mso-spacerun:yes'>        </span>tháng<span
  style='mso-spacerun:yes'>        </span>năm</td>
  <td colspan=4 class=xl127 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl129></td>
  <td colspan=5 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl108>Ngày<span style='mso-spacerun:yes'>        </span>tháng<span
  style='mso-spacerun:yes'>        </span>năm</td>
  <td colspan=2 class=xl108 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl56 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl49 style='height:14.25pt'></td>
  <td class=xl56>Cán bộ thu</td>
  <td class=xl51 colspan=2 style='mso-ignore:colspan'>Giám đốc Bảo Hiểm Xã Hội</td>
  <td colspan=3 class=xl51 style='mso-ignore:colspan'></td>
  <td class=xl51 colspan=3 style='mso-ignore:colspan'>Người lập biểu</td>
  <td class=xl56></td>
  <td class=xl130></td>
  <td colspan=5 class=xl56 style='mso-ignore:colspan'></td>
  <td class=xl49>Người sử dụng lao động</td>
  <td colspan=2 class=xl49 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl131 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl108 style='height:13.5pt'></td>
  <td class=xl48></td>
  <td class=xl108></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl108></td>
  <td class=xl127 colspan=3 style='mso-ignore:colspan'>(ký ghi rõ họ tên)</td>
  <td class=xl48></td>
  <td class=xl129></td>
  <td class=xl127></td>
  <td colspan=4 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl108>(ký và đóng dấu)</td>
  <td colspan=2 class=xl108 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl108 style='height:12.75pt'></td>
  <td class=xl48></td>
  <td class=xl108></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl108></td>
  <td class=xl108></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl132></td>
  <td colspan=9 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl108 style='height:12.75pt'></td>
  <td class=xl48></td>
  <td class=xl108></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl108></td>
  <td colspan=2 class=xl108 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl108 style='height:12.75pt'></td>
  <td class=xl48></td>
  <td class=xl108></td>
  <td colspan=13 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl133 style='mso-ignore:colspan'></td>
  <td class=xl48></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=9 style='mso-height-source:userset;height:6.75pt'>
  <td height=9 class=xl108 style='height:6.75pt'></td>
  <td class=xl48></td>
  <td class=xl108></td>
  <td colspan=17 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl108 style='height:12.75pt'></td>
  <td class=xl48></td>
  <td class=xl108></td>
  <td colspan=4 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl48 colspan=3 style='mso-ignore:colspan'>Phạm Thị Ngọc Tuyết</td>
  <td colspan=7 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl108>LEE YOUNG JIN</td>
  <td colspan=2 class=xl108 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl52 style='height:12.75pt'></td>
  <td class=xl48></td>
  <td class=xl108></td>
  <td class=xl48></td>
  <td class=xl134></td>
  <td colspan=4 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl108></td>
  <td colspan=6 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl135 style='height:12.75pt'></td>
  <td class=xl48></td>
  <td class=xl108></td>
  <td class=xl48></td>
  <td class=xl136></td>
  <td colspan=15 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl108 style='height:12.75pt'></td>
  <td class=xl48></td>
  <td class=xl108></td>
  <td colspan=17 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl108 style='height:12.75pt'></td>
  <td class=xl48></td>
  <td class=xl108></td>
  <td colspan=7 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl137></td>
  <td colspan=9 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl108 style='height:12.75pt'></td>
  <td class=xl48></td>
  <td class=xl108></td>
  <td colspan=17 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl108 style='height:12.75pt'></td>
  <td class=xl48></td>
  <td class=xl108></td>
  <td colspan=6 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl138></td>
  <td colspan=10 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl108 style='height:12.75pt'></td>
  <td class=xl48></td>
  <td class=xl108></td>
  <td colspan=6 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl139></td>
  <td colspan=10 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl108 style='height:12.75pt'></td>
  <td class=xl48></td>
  <td class=xl108></td>
  <td colspan=6 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl138></td>
  <td colspan=10 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl108 style='height:12.75pt'></td>
  <td class=xl48></td>
  <td class=xl108></td>
  <td colspan=6 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl137></td>
  <td colspan=10 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=30 style='width:23pt'></td>
  <td width=189 style='width:142pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=35 style='width:26pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
