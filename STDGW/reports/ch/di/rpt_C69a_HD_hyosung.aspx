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
        "and a.work_mon='" + p_mon + "' and nvl(b.SOCIAL_YN,'N')='Y' " ;
    double dtotal_lb=0,dtotal_lb_femail=0,dtotal_sal=0;
    DataTable dt_sum = ESysLib.TableReadOpen(SQL_Sum);
    if (dt_sum.Rows.Count != 0)
    {
        dtotal_lb=double.Parse(dt_sum.Rows[0][0].ToString());
        dtotal_lb_femail=double.Parse(dt_sum.Rows[0][1].ToString());
        dtotal_sal=double.Parse(dt_sum.Rows[0][2].ToString());
    }
    //Response.Write(p_mon.Insert(4, "-") + "-01");
    //Response.End();
    string SQL
    = "select v.CODE_NM,ti.emp_id, ti.FULL_NAME, ti.SOCIAL_NO, ti.CONDITION,case when nvl(ti.ST_SOCIAL_DT,'201003')>'201002' then  to_char(to_date(ti.ST_SOCIAL_DT,'yyyymm'),'mm/yyyy') else to_char(to_date(ti.ST_SOCIAL_DT || '01','yyyymmdd') ,'dd/mm/yyyy') end" +
        "    ,ti.PROGRESSIVE progressive ,nvl(ti.DAYS,0) nghi_tai_nha,'' nghi_tap_trung  " +
        "    ,round(nvl(ti.INS_AMT,0),0),ti.FROM_DT,"+
        "    ti.TO_DT, ti.REMARK, v.NUM_1 " +
        "from THR_INS_REGULATION ti, vhr_hr_code v,thr_employee c  " +
        "where ti.DEL_IF=0 and c.del_if=0 and ti.thr_emp_pk=c.pk " +
        "and ti.INS_MONTH='"+p_mon+"' " +
        "and v.ID='HR0055' " +
        "and ti.INS_REG_TYPE='03' " +
        "and v.CODE=ti.DETAIL_INS_REG_TYPE " +
        "order by v.NUM_1, ti.FULL_NAME,ti.from_dt ";

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
<link rel=File-List href="rpt_C69a_HD_hyosung_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_C69a_HD_hyosung_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_C69a_HD_hyosung_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ms lan</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2011-06-16T09:53:05Z</o:LastPrinted>
  <o:Created>2011-03-08T10:01:55Z</o:Created>
  <o:LastSaved>2011-09-30T02:12:14Z</o:LastSaved>
  <o:Company>vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in 0in .75in 0in;
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
.style56
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
.style57
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
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet1;}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
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
.xl67
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl69
	{mso-style-parent:style56;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl70
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl71
	{mso-style-parent:style56;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
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
.xl73
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
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
.xl74
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl75
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl76
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl77
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl78
	{mso-style-parent:style43;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl79
	{mso-style-parent:style57;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl80
	{mso-style-parent:style57;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl81
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl82
	{mso-style-parent:style57;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl83
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
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
.xl84
	{mso-style-parent:style57;
	color:windowtext;
	font-size:10.0pt;
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
.xl85
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl86
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
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
.xl87
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
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
.xl88
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
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
.xl89
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
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
.xl90
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
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
.xl91
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
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
.xl92
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl93
	{mso-style-parent:style0;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl94
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl95
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl96
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl97
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl98
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl99
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl100
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
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
.xl101
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl102
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl103
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl104
	{mso-style-parent:style57;
	color:windowtext;
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
.xl105
	{mso-style-parent:style57;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl106
	{mso-style-parent:style57;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl107
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl108
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl109
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	font-size:10.0pt;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-number-format:"dd/mm/yyyy";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	mso-text-control:shrinktofit;
	border-left:none;}
.xl110
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl111
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl112
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl113
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl114
	{mso-style-parent:style57;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl115
	{mso-style-parent:style57;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl116
	{mso-style-parent:style57;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name><%=p_mon.Substring(4,2) + p_mon.Substring(0,4) %></x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>95</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>15</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>32</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
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
  <x:WindowHeight>7170</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl67>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1113 style='border-collapse:
 collapse;table-layout:fixed;width:836pt'>
 <col class=xl67 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl67 width=57 style='mso-width-source:userset;mso-width-alt:2084;
 width:43pt'>
 <col class=xl67 width=144 style='mso-width-source:userset;mso-width-alt:5266;
 width:108pt'>
 <col class=xl68 width=92 style='mso-width-source:userset;mso-width-alt:3364;
 width:69pt'>
 <col class=xl68 width=117 style='mso-width-source:userset;mso-width-alt:4278;
 width:88pt'>
 <col class=xl67 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl67 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl67 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl67 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl67 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 <col class=xl67 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 <col class=xl67 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl67 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl79 width=47 style='height:15.0pt;width:35pt'>&nbsp;</td>
  <td class=xl79 width=57 style='width:43pt'>&nbsp;</td>
  <td class=xl79 colspan=3 width=353 style='mso-ignore:colspan;width:265pt'>Tên
  cơ quan: CTY TNHH HYOSUNG VIỆT NAM</td>
  <td class=xl80 width=80 style='width:60pt'>&nbsp;</td>
  <td class=xl80 width=88 style='width:66pt'>&nbsp;</td>
  <td class=xl80 width=93 style='width:70pt'>&nbsp;</td>
  <td class=xl80 width=100 style='width:75pt'>&nbsp;</td>
  <td class=xl80 width=69 style='width:52pt'>&nbsp;</td>
  <td colspan=2 class=xl92 width=171 style='width:129pt'>Mẫu: C69A - TBH</td>
  <td width=55 style='width:41pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=5 height=20 class=xl81 style='height:15.0pt'>Địa Chỉ: KCN Nhơn
  Trạch I, H.Nhơn Trạch, ĐNAI</td>
  <td colspan=5 class=xl80 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl80>Ma ĐV:</td>
  <td>YN0098K</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 class=xl82 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl81>ĐT: 0613 - 569455</td>
  <td class=xl82>&nbsp;</td>
  <td colspan=7 class=xl80 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 class=xl82 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl82>&nbsp;</td>
  <td colspan=7 class=xl80 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=13 height=27 class=xl93 style='height:20.25pt'>DANH SÁCH NGƯỜI
  LAO ĐỘNG ĐỀ NGHỊ HƯỞNG<span style='mso-spacerun:yes'>  </span>TRỢ CẤP NGHỈ
  DSPHSK SAU THAI SẢN</td>
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
 <tr height=18 style='height:13.5pt'>
  <td colspan=13 height=18 class=xl94 style='height:13.5pt'>Tháng <%=p_mon.Substring(4,2) %> quý <%=w %> năm <%= p_mon.Substring(0,4) %></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl67 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=8 class=xl67 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl67 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=8 class=xl67 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 colspan=2 class=xl67 style='height:20.25pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl69 colspan=2 style='mso-ignore:colspan'>Số hiệu tài khoản:
  DDA912030077</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69 colspan=2 style='mso-ignore:colspan'>Mở tại: WOORI BANK HCM</td>
  <td colspan=6 class=xl67 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 colspan=2 class=xl67 style='height:20.25pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl70 x:str="Tổng số lao động: ">Tổng số lao động:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan' x:num><%=dtotal_lb %></td>
  <td class=xl70 x:str="Trong đó nữ: ">Trong đó nữ:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl70 x:nm><%=dtotal_lb_femail %></td>
  <td colspan=6 class=xl67 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 colspan=2 class=xl67 style='height:20.25pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl70 colspan=2 style='mso-ignore:colspan'
  x:str="Tổng quỹ lương trong tháng: ">Tổng quỹ lương trong tháng:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl78 x:num><%=dtotal_sal %></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=6 class=xl67 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 colspan=2 class=xl67 style='height:20.25pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl70 colspan=3 style='mso-ignore:colspan'>Địa chỉ : Đường N2- KCN
  Nhơn trạch 5-Nhơn Trạch - Đồng Nai</td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=6 class=xl67 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 colspan=3 class=xl67 style='height:8.25pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=8 class=xl67 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=13 height=21 class=xl95 style='height:15.75pt'>&nbsp;</td>
 </tr>
 <tr class=xl70 height=68 style='mso-height-source:userset;height:51.0pt'>
  <td rowspan=4 height=138 class=xl89 style='border-bottom:.5pt solid black;
  height:103.5pt'>STT</td>
  <td rowspan=4 class=xl89 style='border-bottom:.5pt solid black'>Mã số</td>
  <td rowspan=4 class=xl89 style='border-bottom:.5pt solid black'>Họ và tên</td>
  <td class=xl72 style='border-left:none'>Số sổ</td>
  <td class=xl72 style='border-left:none'>Đ iều kiện</td>
  <td class=xl72 style='border-left:none'>Thời gian</td>
  <td rowspan=4 class=xl86 width=88 style='border-bottom:.5pt solid black;
  width:66pt'>Lũy kế <br>
    ngày nghỉ <br>
    hưởng DSPHSK<br>
    đối với sẩy thai, hút thai, thai chết lưu, sinh con</td>
  <td colspan=3 class=xl72 style='border-left:none'>Số đơn vị đề nghị</td>
  <td colspan=3 class=xl99 style='border-left:none'>Ghi Chú</td>
 </tr>
 <tr class=xl70 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td rowspan=2 height=31 class=xl100 style='border-bottom:.5pt solid black;
  height:23.25pt'>BHXH</td>
  <td rowspan=2 class=xl100 style='border-bottom:.5pt solid black'>tính hưởng</td>
  <td rowspan=2 class=xl100 style='border-bottom:.5pt solid black'>đóng BHXH</td>
  <td colspan=2 class=xl102 style='border-right:.5pt solid black;border-left:
  none'>Số ngày nghỉ trong kỳ</td>
  <td rowspan=2 class=xl72 style='border-bottom:.5pt solid black'>Số tiền</td>
  <td rowspan=3 class=xl85 width=85 style='border-top:none;width:64pt'>Từ
  ngày/tháng/<br>
    năm<br>
    </td>
  <td rowspan=3 class=xl85 width=86 style='border-top:none;width:65pt'>Đến
  ngày/tháng/<br>
    năm<br>
    </td>
  <td rowspan=3 class=xl99 style='border-top:none'>Khác</td>
 </tr>
 <tr class=xl70 height=0 style='display:none;mso-height-source:userset;
  mso-height-alt:165'>
  <td class=xl73 style='border-left:none'>trong kỳ</td>
  <td class=xl73 style='border-left:none'>từ đầu năm</td>
 </tr>
 <tr class=xl70 height=39 style='mso-height-source:userset;height:29.25pt'>
  <td height=39 class=xl73 style='height:29.25pt;border-left:none'>&nbsp;</td>
  <td class=xl73 style='border-left:none'>&nbsp;</td>
  <td class=xl73 style='border-left:none'>&nbsp;</td>
  <td class=xl73 style='border-left:none'>Nghỉ tại gia đình</td>
  <td class=xl73 style='border-left:none'>Nghỉ tập trung</td>
  <td class=xl73 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl74 style='height:16.5pt'>A</td>
  <td class=xl74 style='border-left:none'>&nbsp;</td>
  <td class=xl74 style='border-left:none'>B</td>
  <td class=xl74 style='border-left:none'>C</td>
  <td class=xl74 style='border-left:none'>D</td>
  <td class=xl74 style='border-left:none' x:num>1</td>
  <td class=xl74 style='border-left:none' x:num>2</td>
  <td class=xl74 style='border-left:none' x:num>3</td>
  <td class=xl74 style='border-left:none' x:num>4</td>
  <td class=xl74 style='border-left:none' x:num>5</td>
  <td class=xl74 style='border-left:none'>E</td>
  <td class=xl74 style='border-left:none'>F</td>
  <td class=xl74 style='border-left:none'>G</td>
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
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=3 height=22 class=xl96 style='border-right:.5pt solid black;
  height:16.5pt'><%=dt_emp.Rows[i][0].ToString() %></td>
  <td class=xl75 style='border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-left:none'>&nbsp;</td>
 </tr>
 <%
        bchange=false;
    } %>
 <tr class=xl76 height=49 style='mso-height-source:userset;height:36.75pt'>
  <td height=49 class=xl83 style='height:36.75pt' x:num><%=j %></td>
  <td class=xl84 style='border-left:none'><%=dt_emp.Rows[i][1].ToString() %></td>
  <td class=xl114 style='border-left:none'><%=dt_emp.Rows[i][2].ToString() %></td>
  <td class=xl104 style='border-left:none' ><%=dt_emp.Rows[i][3].ToString() %></td>
  <td class=xl105 width=117 style='border-left:none;width:88pt'
  x:str><%=dt_emp.Rows[i][4].ToString() %></td>
  <td class=xl106 style='border-left:none' ><%=dt_emp.Rows[i][5].ToString() %></td>
  <td class=xl84 style='border-left:none' x:num><%=dt_emp.Rows[i][6].ToString() %></td>
  <td class=xl84 style='border-left:none' x:num><%=dt_emp.Rows[i][7].ToString() %></td>
  <td class=xl107 style='border-left:none' x:num><%=dt_emp.Rows[i][8].ToString() %></td>
  <td class=xl108 style='border-left:none' x:num
  ><span style='mso-spacerun:yes'>   
  </span><%=dt_emp.Rows[i][9].ToString() %></td>
  <td class=xl109 style='border-left:none' x:fmla="=DATE(<%=int.Parse(dt_emp.Rows[i][10].ToString().Substring(0,4).ToString())%>,<%=int.Parse(dt_emp.Rows[i][10].ToString().Substring(4,2).ToString())%>,<%=int.Parse(dt_emp.Rows[i][10].ToString().Substring(6,2).ToString())%>)"  x:num></td>
  <td class=xl109 style='border-left:none' x:fmla="=DATE(<%=int.Parse(dt_emp.Rows[i][11].ToString().Substring(0,4).ToString())%>,<%=int.Parse(dt_emp.Rows[i][11].ToString().Substring(4,2).ToString())%>,<%=int.Parse(dt_emp.Rows[i][11].ToString().Substring(6,2).ToString())%>)"  x:num></td>
  <td class=xl83 style='border-left:none;mso-text-control:shrinktofit;'><%=dt_emp.Rows[i][12].ToString() %></td>
 </tr>
 <%} %>
 <tr height=43 style='mso-height-source:userset;height:32.25pt'>
  <td height=43 class=xl110 style='height:32.25pt'>&nbsp;</td>
  <td class=xl110 style='border-left:none'>&nbsp;</td>
  <td class=xl111 style='border-left:none'>TỔNG CỘNG</td>
  <td class=xl112 style='border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-left:none'>&nbsp;</td>
  <td class=xl110 style='border-left:none'>&nbsp;</td>
  <td class=xl110 style='border-left:none'>&nbsp;</td>
  <td class=xl110 style='border-left:none'>&nbsp;</td>
  <td class=xl110 style='border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-left:none' x:num
 ><span style='mso-spacerun:yes'>  </span><%=dTotal %></td>
  <td class=xl113 style='border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-left:none'>&nbsp;</td>
  <td class=xl110 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 colspan=3 class=xl67 style='height:6.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=8 class=xl67 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=3 class=xl67 style='height:15.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=5 class=xl67 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl67 colspan=2 style='mso-ignore:colspan'>Ngày<span
  style='mso-spacerun:yes'>      </span>tháng<span
  style='mso-spacerun:yes'>         </span>năm 201</td>
  <td class=xl67>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl70 colspan=3 style='height:12.75pt;mso-ignore:colspan'>Xác
  nhận phòng thu</td>
  <td class=xl70>Người lập</td>
  <td class=xl70>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl70 colspan=2 style='mso-ignore:colspan'>Công đoàn cơ sở</td>
  <td class=xl70>&nbsp;</td>
  <td class=xl70 colspan=2 style='mso-ignore:colspan'>Kế Toán Trưởng</td>
  <td class=xl77>Thủ Trưởng Đơn Vị</td>
  <td class=xl77>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl67 colspan=2 style='height:12.75pt;mso-ignore:colspan'>(Ký,
  họ tên)</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>(Ký, họ tên)</td>
  <td colspan=2 class=xl67 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl68>(Ký, họ tên)</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl68>(Ký, họ tên)</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl68>(Ký, họ tên)</td>
  <td class=xl68>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl67 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl67 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl67 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl67 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl67 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl67 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl67 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=8 class=xl67 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl67 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=8 class=xl67 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl67 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl67 style='mso-ignore:colspan'><%=dt_com.Rows[5][0].ToString() %></td>
  <td class=xl115 colspan=2 style='mso-ignore:colspan'><%=dt_com.Rows[7][0].ToString() %></td>
  <td class=xl116><%=dt_com.Rows[6][0].ToString() %></td>
  <td class=xl67>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=47 style='width:35pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=144 style='width:108pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=55 style='width:41pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
