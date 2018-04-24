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
    //Response.Write(p_mon.Insert(4, "-") + "-01");
    //Response.End();
    string SQL_Sum
        = "select count(*),sum(decode(b.sex,'F',1,0)),sum(luong_cb)  " +
            "from thr_insurance_month a,thr_employee b " +
            "where a.del_if=0 and b.del_if=0 and a.thr_emp_pk=b.pk " +
            "and a.work_mon='" + p_mon + "' and nvl(b.SOCIAL_YN,'N')='Y' ";
    double dtotal_lb = 0, dtotal_lb_femail = 0, dtotal_sal = 0;
    DataTable dt_sum = ESysLib.TableReadOpen(SQL_Sum);
    if (dt_sum.Rows.Count != 0)
    {
        dtotal_lb = double.Parse(dt_sum.Rows[0][0].ToString());
        dtotal_lb_femail = double.Parse(dt_sum.Rows[0][1].ToString());
        dtotal_sal = double.Parse(dt_sum.Rows[0][2].ToString());
    }
    string SQL
    = "select v.CODE_NM,c.emp_id, ti.FULL_NAME, ti.SOCIAL_NO, ti.CONDITION, round(nvl(ti.AVERAGE_SALARY,0),0) " +
        "    ,case when nvl(ti.ST_SOCIAL_DT,'201003')>'201002' then  to_char(to_date(ti.ST_SOCIAL_DT,'yyyymm'),'mm/yyyy') else to_char(to_date(ti.ST_SOCIAL_DT || '01','yyyymmdd') ,'dd/mm/yyyy') end,ti.DAYS, ti.PROGRESSIVE  " +
        "    ,round(ti.INS_AMT,0),ti.FROM_DT,"+
        "    ti.TO_DT, ti.REMARK, v.NUM_1 " +
        "from THR_INS_REGULATION ti, vhr_hr_code v,thr_employee c  " +
        "where ti.DEL_IF=0 and c.del_if=0 and ti.thr_emp_pk=c.pk " +
        "and ti.INS_MONTH='"+p_mon+"' " +
        "and v.ID='HR0055' " +
        "and ti.INS_REG_TYPE='01' " +
        "and v.CODE=ti.DETAIL_INS_REG_TYPE " +
        "order by v.NUM_1 , ti.FULL_NAME,ti.from_dt ";

    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
    if(dt_emp.Rows.Count==0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }    
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_66a_HD_hyosung_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_66a_HD_hyosung_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_66a_HD_hyosung_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>truong</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2011-09-28T02:19:52Z</o:LastPrinted>
  <o:Created>2011-09-28T02:19:11Z</o:Created>
  <o:LastSaved>2011-09-28T03:01:21Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.33in .18in .4in .3in;
	mso-header-margin:.23in;
	mso-footer-margin:.26in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style16
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
.style20
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_BHXH;}
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
.xl25
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/dd\/yy\;\@";
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\/yyyy\;\@";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;}
.xl32
	{mso-style-parent:style20;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style20;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/dd\/yy\;\@";
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/dd\/yy\;\@";
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style20;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/dd\/yy\;\@";
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/dd\/yy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\/yyyy\;\@";
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\/yyyy\;\@";
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\/yyyy\;\@";
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\/yyyy\;\@";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\/yyyy\;\@";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\/yyyy\;\@";
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\/yyyy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl54
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl55
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/dd\/yy\;\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl56
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl57
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\/yyyy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl58
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl59
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl60
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/dd\/yy\;\@";
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl61
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl62
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl63
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\/yyyy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl64
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl65
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl66
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl67
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\/yyyy\;\@";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl70
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl71
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
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
.xl72
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl73
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl75
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl76
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	text-align:center;}
.xl82
	{mso-style-parent:style0;
	text-align:left;}
.xl83
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl84
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl85
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	background:white;
	mso-pattern:auto none;}
.xl86
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	background:white;
	mso-pattern:auto none;}
.xl87
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\/yyyy\;\@";
	background:white;
	mso-pattern:auto none;}
.xl88
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl89
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl90
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl91
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl92
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl93
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
	background:white;
	mso-pattern:auto none;}
.xl94
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl95
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/dd\/yy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl96
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
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
.xl97
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl98
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\/yyyy\;\@";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl99
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\/yyyy\;\@";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl100
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	font-size:10.0pt;
	mso-font-charset:0;
	mso-number-format:"dd/mm/yyyy";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	mso-text-control:shrinktofit;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name><%=p_mon.Substring(4,2) + p_mon.Substring(0,4) %></x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>98</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet2</x:Name>
    <x:WorksheetOptions>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8445</x:WindowHeight>
  <x:WindowWidth>19035</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="6145"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1,2,3,4,5"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl31>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1033 style='border-collapse:
 collapse;table-layout:fixed;width:777pt'>
 <col class=xl31 width=64 style='width:48pt'>
 <col class=xl31 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl81 width=138 style='mso-width-source:userset;mso-width-alt:5046;
 width:104pt'>
 <col class=xl31 width=101 style='mso-width-source:userset;mso-width-alt:3693;
 width:76pt'>
 <col class=xl81 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl31 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 <col class=xl82 width=64 style='width:48pt'>
 <col class=xl81 width=48 style='mso-width-source:userset;mso-width-alt:1755;
 width:36pt'>
 <col class=xl81 width=64 style='width:48pt'>
 <col class=xl83 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl31 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl31 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl31 width=64 style='width:48pt'>
 <tr class=xl27 height=17 style='height:12.75pt'>
  <td height=17 class=xl25 width=64 style='height:12.75pt;width:48pt'>&nbsp;</td>
  <td class=xl26 width=67 style='width:50pt'>&nbsp;</td>
  <td class=xl26 width=138 style='width:104pt'>Tên cơ quan: CTY TNHH HYOSUNG
  VIỆT NAM</td>
  <td height=17 class=xl27 width=101 style='height:12.75pt;width:76pt'>&nbsp;</td>
  <td class=xl25 width=94 style='width:71pt'>&nbsp;</td>
  <td class=xl25 width=85 style='width:64pt'>&nbsp;</td>
  <td class=xl28 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl25 width=48 style='width:36pt'>&nbsp;</td>
  <td class=xl25 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl29 width=81 style='width:61pt'>&nbsp;</td>
  <td class=xl30 width=81 style='width:61pt'>&nbsp;</td>
  <td class=xl30 width=82 style='width:62pt'>&nbsp;</td>
  <td class=xl25 width=64 style='width:48pt'>&nbsp;</td>
 </tr>
 <tr class=xl27 height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl25>Địa Chỉ: KCN Nhơn Trạch I, H.Nhơn Trạch, ĐNAI</td>
  <td class=xl27>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>Mẫu: C66A - TBH</td>
  <td class=xl27>&nbsp;</td>
 </tr>
 <tr class=xl27 height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl25>ĐT: 0613 - 569455</td>
  <td class=xl27>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl27>Ma ĐV:</td>
  <td class=xl31>YN0098K</td>
 </tr>
 <tr class=xl27 height=27 style='height:20.25pt'>
  <td colspan=13 height=27 class=xl88 style='height:20.25pt'>DANH SÁCH NGƯỜI
  LAO ĐỘNG HƯỞNG CHẾ ĐỘ ỐM ĐAU</td>
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
 <tr class=xl27 height=18 style='height:13.5pt'>
  <td colspan=13 height=18 class=xl89 style='height:13.5pt'>Tháng <%=p_mon.Substring(4,2) %> quý <%=w %> năm <%= p_mon.Substring(0,4) %> </td>
 </tr>
 <tr class=xl27 height=17 style='height:12.75pt'>
  <td height=17 colspan=6 class=xl25 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
 </tr>
 <tr class=xl27 height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl25 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl32>Số hiệu tài khoản: DDA912030077</td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl33 colspan=3 style='mso-ignore:colspan'>Mở tại: WOORI BANK HCM</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
 </tr>
 <tr class=xl27 height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl25 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl34 x:str="Tổng số lao động: ">Tổng số lao động:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl35 x:num><%=dtotal_lb %></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl36 colspan=2 style='mso-ignore:colspan' x:str="Trong đó nữ: ">Trong
  đó nữ:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl25 x:num><%=dtotal_lb_femail %></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
 </tr>
 <tr class=xl27 height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl25 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl34 x:str="Tổng quỹ lương trong tháng:  ">Tổng quỹ lương trong
  tháng:<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl37 x:num><%=dtotal_sal %></td>
  <td class=xl38>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
 </tr>
 <tr class=xl27 height=22 style='height:16.5pt'>
  <td colspan=13 height=22 class=xl90 style='height:16.5pt'>&nbsp;</td>
 </tr>
 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=3 height=99 class=xl91 style='height:74.25pt'>STT</td>
  <td rowspan=3 class=xl40>Mã số</td>
  <td rowspan=3 class=xl41 style='border-bottom:.5pt hairline black'>Họ và tên</td>
  <td class=xl40 style='border-left:none'>Số sổ</td>
  <td class=xl40 style='border-left:none'>Đ iều kiện</td>
  <td class=xl40 style='border-left:none'>Tiền lương</td>
  <td class=xl42 style='border-left:none'>Thời gian</td>
  <td colspan=3 class=xl40 style='border-left:none'>Số đơn vị đề nghị</td>
  <td class=xl43 style='border-left:none'>Ghi Chú</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl45>&nbsp;</td>
 </tr>
 <tr class=xl27 height=46 style='mso-height-source:userset;height:34.5pt'>
  <td rowspan=2 height=79 class=xl46 style='height:59.25pt;border-top:none'>BHXH</td>
  <td rowspan=2 class=xl46 style='border-top:none'>tính hưởng</td>
  <td rowspan=2 class=xl47 width=85 style='border-top:none;width:64pt'>tính
  hưởng<br>
    BHXH</td>
  <td rowspan=2 class=xl95 style='border-top:none'>đóng BHXH</td>
  <td class=xl47 width=48 style='border-top:none;border-left:none;width:36pt'>Số
  ngày nghỉ <br></td>
  <td class=xl46 style='border-top:none;border-left:none'>Luỹ kế</td>
  <td rowspan=2 class=xl96 style='border-top:none' x:str="Số tiền"><span
  style='mso-spacerun:yes'> </span>Số tiền<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl48 style='border-left:none'>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
 </tr>
 <tr class=xl27 height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 class=xl46 style='height:24.75pt;border-top:none;border-left:
  none'>trong kỳ</td>
  <td class=xl46 style='border-top:none;border-left:none'>từ đầu năm</td>
  <td class=xl51 width=81 style='border-top:none;border-left:none;width:61pt'>Từ
  ngày/tháng<br>
    năm</td>
  <td class=xl51 width=82 style='border-top:none;border-left:none;width:62pt'>Đến
  ngày/tháng<br>
    năm</td>
  <td class=xl52 style='border-top:none;border-left:none'>Khác</td>
 </tr>
 <tr class=xl27 height=18 style='height:13.5pt'>
  <td height=18 class=xl53 style='height:13.5pt;border-top:none'>A</td>
  <td class=xl54 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl54 style='border-top:none;border-left:none'>B</td>
  <td class=xl54 style='border-top:none;border-left:none'>C</td>
  <td class=xl54 style='border-top:none;border-left:none'>D</td>
  <td class=xl54 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl55 style='border-top:none;border-left:none' x:str="'2">2</td>
  <td class=xl54 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl54 style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl56 style='border-top:none;border-left:none' x:num="5"><span
  style='mso-spacerun:yes'>                      </span>5 </td>
  <td class=xl57 style='border-top:none;border-left:none'>E</td>
  <td class=xl57 style='border-top:none;border-left:none'>F</td>
  <td class=xl58 style='border-top:none;border-left:none'>G</td>
 </tr>
 <%             
        string[] seq = new string[6] { "I", "II", "III", "IV","V","VI" };
        int j=0, i=0,z=0;
        double dTotal=0;
        Boolean bchange=false;
     for (i = 0; i < dt_emp.Rows.Count; i++)
     { 
         j++;
         dTotal += Double.Parse(dt_emp.Rows[i][9].ToString());
         if (i==0)
            bchange=true;
         else
         {
             if (dt_emp.Rows[i][0].ToString() != dt_emp.Rows[i - 1][0].ToString())
             {
                bchange = true;
                j=1;
                z++;
            }
        }   
  %>
  <%
    if (bchange==true)
    {
  %>
 <tr class=xl27 height=17 style='height:12.75pt'>

  <td height=17 class=xl59 style='height:12.75pt'><%=seq[z] %></td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-left:none'><%=dt_emp.Rows[i][0].ToString() %></td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-left:none'>&nbsp;</td>
  <td class=xl61 style='border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl62 style='border-left:none'>&nbsp;</td>
  <td class=xl63 style='border-left:none'>&nbsp;</td>
  <td class=xl63 style='border-left:none'>&nbsp;</td>
  <td class=xl64 style='border-left:none'>&nbsp;</td>
 </tr>
 <%
        bchange=false;
    } %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt' x:num><%=j %></td>
  <td class=xl66 style='border-left:none'><%=dt_emp.Rows[i][1].ToString() %></td>
  <td class=xl66 style='border-left:none'><%=dt_emp.Rows[i][2].ToString() %></td>
  <td class=xl67 style='border-left:none' x:num><%=dt_emp.Rows[i][3].ToString() %></td>
  <td class=xl67 style='border-left:none;mso-text-control:shrinktofit;'><%=dt_emp.Rows[i][4].ToString() %></td>
  <td class=xl68 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%=dt_emp.Rows[i][5].ToString() %> </td>
  <td class=xl69 style='border-left:none' ><%=dt_emp.Rows[i][6].ToString() %></td>
  <td class=xl70 style='border-left:none' x:num><%=dt_emp.Rows[i][7].ToString() %></td>
  <td class=xl70 style='border-left:none' x:num><%=dt_emp.Rows[i][8].ToString() %></td>
  <td class=xl71 style='border-left:none' x:num><span style='mso-spacerun:yes'>          
  </span><%=dt_emp.Rows[i][9].ToString() %></td>
  <td class=xl100 style='border-left:none'
  x:fmla="=DATE(<%=int.Parse(dt_emp.Rows[i][10].ToString().Substring(0,4).ToString())%>,<%=int.Parse(dt_emp.Rows[i][10].ToString().Substring(4,2).ToString())%>,<%=int.Parse(dt_emp.Rows[i][10].ToString().Substring(6,2).ToString())%>)"  x:num></td>
  <td class=xl100 style='border-left:none' x:fmla="=DATE(<%=int.Parse(dt_emp.Rows[i][10].ToString().Substring(0,4).ToString())%>,<%=int.Parse(dt_emp.Rows[i][10].ToString().Substring(4,2).ToString())%>,<%=int.Parse(dt_emp.Rows[i][10].ToString().Substring(6,2).ToString())%>)"  x:num></td>
  <td class=xl73 style='border-left:none;mso-text-control:shrinktofit'><%=dt_emp.Rows[i][12].ToString() %></td>
 </tr>
 <%} %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl74 style='height:13.5pt;border-top:none'>&nbsp;</td>
  <td class=xl75 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-top:none;border-left:none'>TỔNG CỘNG</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl78 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl79 style='border-top:none;border-left:none' x:num
  ><span style='mso-spacerun:yes'>      </span><%=dTotal %></td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 colspan=6 class=xl25 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=5 class=xl97><span style='mso-spacerun:yes'>                    
  </span>Nhơn Trạch, ngày<span style='mso-spacerun:yes'>     </span>tháng<span
  style='mso-spacerun:yes'>      </span>năm <%=DateTime.Now.Year %></td>
 </tr>
 <tr class=xl27 height=17 style='height:12.75pt'>
  <td height=17 colspan=6 class=xl25 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
 </tr>
 <tr class=xl27 height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl26 style='height:12.75pt'>Xác nhận phòng thu</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl26>Người lập</td>
  <td class=xl26>&nbsp;</td>
  <td colspan=4 class=xl26>Kế Toán Trưởng</td>
  <td colspan=2 class=xl98>Thủ Trưởng Đơn Vị</td>
  <td class=xl25>&nbsp;</td>
 </tr>
 <tr class=xl27 height=17 style='height:12.75pt'>
  <td height=17 colspan=6 class=xl25 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl25>&nbsp;</td>
  <td colspan=2 class=xl25>&nbsp;</td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
 </tr>
 <tr class=xl27 height=17 style='height:12.75pt'>
  <td height=17 colspan=6 class=xl25 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
 </tr>
 <tr class=xl27 height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl27 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 class=xl84 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td colspan=2 class=xl84 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl86>&nbsp;</td>
  <td colspan=2 class=xl87 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
 </tr>
 <tr class=xl27 height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl27 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 class=xl84 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td colspan=2 class=xl84 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl86>&nbsp;</td>
  <td colspan=2 class=xl87 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
 </tr>
 <tr class=xl27 height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl27 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 class=xl84 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td colspan=2 class=xl84 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl86>&nbsp;</td>
  <td colspan=2 class=xl87 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
 </tr>
 <tr class=xl27 height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl27 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 class=xl84 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td colspan=2 class=xl84 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl86>&nbsp;</td>
  <td colspan=2 class=xl87 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
 </tr>
 <tr class=xl27 height=17 style='height:12.75pt'>
  <td height=17 colspan=6 class=xl25 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'>&nbsp;</td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26><%=dt_com.Rows[5][0].ToString() %></td>
  <td colspan=4 class=xl90><%=dt_com.Rows[7][0].ToString() %></td>
  <td colspan=2 class=xl99><%=dt_com.Rows[6][0].ToString() %></td>
  <td class=xl25>&nbsp;</td>
 </tr>
 <tr class=xl27 height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl27 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 class=xl84 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td colspan=2 class=xl84 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl86>&nbsp;</td>
  <td colspan=2 class=xl87 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl81></td>
  <td class=xl31></td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
