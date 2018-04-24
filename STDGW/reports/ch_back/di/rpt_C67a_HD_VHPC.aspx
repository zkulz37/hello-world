<<%@ Page Language="C#"%>
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

    string SQL
    = "select v.CODE_NM, ti.FULL_NAME, ti.SOCIAL_NO, round(nvl(ti.AVERAGE_SALARY,0),0) " +
        "    ,to_char(to_date(ti.ST_SOCIAL_DT,'yyyymm'),'mm-yyyy'),nvl(ti.DAYS,0), nvl(ti.PROGRESSIVE,0)  " +
        "    ,round(ti.INS_AMT,0),to_char(to_date(ti.FROM_DT,'yyyymmdd'),'dd/mm/yyyy'),"+
        "    to_char(to_date(ti.TO_DT,'yyyymmdd'),'dd/mm/yyyy'), ti.REMARK, v.NUM_1 " +
        "from THR_INS_REGULATION ti, vhr_hr_code v  " +
        "where ti.DEL_IF=0 " +
        "and ti.INS_MONTH='"+p_mon+"' " +
        "and v.ID='HR0055' " +
        "and ti.INS_REG_TYPE='02' " +
        "and v.CODE=ti.DETAIL_INS_REG_TYPE " +
        "order by v.NUM_1 , ti.FULL_NAME ";

    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
    int irow = dt_emp.Rows.Count;
    if(dt_emp.Rows.Count==0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }

    string SQL_Sum
    = "select count(*), sum(nvl(a.LUONG_BHXH,0)),sum(decode(b.SEX,'F',1,0)) " +
        ",substr('" + p_mon + "',5,2) as mon " +
        ",decode(substr('" + p_mon + "',5,2),'03','1','06','2','09','3','12','4','') as quater " +
        ",substr('" + p_mon + "',1,4) as years " +
        ",to_char(sysdate,'dd') day " +
        ",to_char(sysdate,'mm') mon " +
        ",to_char(sysdate,'yyyy') day " +
        "from thr_insurance_month a, thr_employee b " +
        "where a.del_if=0 and b.del_if=0 " +
        "and a.THR_EMP_PK = b.PK " +
        "and a.WORK_MON ='" + p_mon + "' " +
        "and nvl(a.XH_YN,'N') ='Y' and nvl(a.YT_YN,'N')='Y' and nvl(a.TN_YN,'N')='Y' " +
        "and b.NATION='01' ";

    DataTable dt_sum = ESysLib.TableReadOpen(SQL_Sum);
    
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_C67a_HD_VHPC_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_C67a_HD_VHPC_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_C67a_HD_VHPC_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>welcome</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-05-13T08:18:01Z</o:LastPrinted>
  <o:Created>2008-06-12T07:32:33Z</o:Created>
  <o:LastSaved>2011-05-13T08:18:20Z</o:LastSaved>
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
.font9
	{color:black;
	font-size:12.0pt;
	font-weight:700;
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
.style43
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:Comma;
	mso-style-id:3;}
.style45
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:"Comma 2";}
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
.xl66
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl67
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl68
	{mso-style-parent:style43;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;}
.xl71
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl72
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl75
	{mso-style-parent:style0;
	font-size:13.0pt;}
.xl76
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl77
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl79
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl80
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl81
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl82
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl83
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl84
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl86
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl87
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl88
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl89
	{mso-style-parent:style45;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;}
.xl90
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
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
.xl92
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl94
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl95
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl96
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl97
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style43;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl99
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl100
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl101
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl102
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl103
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl104
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl105
	{mso-style-parent:style43;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl106
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl107
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl108
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl109
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl110
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl111
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;}
.xl112
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl113
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl114
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl115
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl116
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl117
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl118
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl119
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl120
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl121
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl122
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl123
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl124
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl125
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl126
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl127
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
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
.xl128
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl129
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl130
	{mso-style-parent:style0;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>C67</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>3</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>21</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8010</x:WindowHeight>
  <x:WindowWidth>15120</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl77>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1174 style='border-collapse:
 collapse;table-layout:fixed;width:881pt'>
 <col class=xl76 width=31 style='mso-width-source:userset;mso-width-alt:1133;
 width:23pt'>
 <col class=xl76 width=209 style='mso-width-source:userset;mso-width-alt:7643;
 width:157pt'>
 <col class=xl76 width=98 style='mso-width-source:userset;mso-width-alt:3584;
 width:74pt'>
 <col class=xl76 width=95 span=2 style='mso-width-source:userset;mso-width-alt:
 3474;width:71pt'>
 <col class=xl76 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl76 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl76 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col width=97 style='mso-width-source:userset;mso-width-alt:3547;width:73pt'>
 <col width=94 style='mso-width-source:userset;mso-width-alt:3437;width:71pt'>
 <col class=xl77 width=64 span=3 style='width:48pt'>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=10 height=25 class=xl76 width=982 style='height:18.75pt;
  width:737pt'>C&#7896;NG HÒA XÃ H&#7896;I CH&#7910; NGH&#296;A VI&#7878;T NAM</td>
  <td class=xl77 width=64 style='width:48pt'></td>
  <td class=xl77 width=64 style='width:48pt'></td>
  <td class=xl77 width=64 style='width:48pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=10 height=21 class=xl79 style='height:15.75pt'>&#272;&#7897;c
  L&#7853;p- T&#7921; Do- H&#7841;nh Phúc</td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=10 height=21 class=xl79 style='height:15.75pt'>-----o0o-----</td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl80 height=23 style='height:17.25pt'>
  <td height=23 class=xl78 colspan=5 style='height:17.25pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>    </span>Tên công ty: <font class="font9">Công ty
  TNHH Trung Tâm Gia Công POSCO Vi&#7879;t Nam</font></td>
  <td colspan=3 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl111>M&#7850;U C 67a-HD</td>
  <td class=xl75></td>
  <td colspan=3 class=xl80 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl80 height=23 style='height:17.25pt'>
  <td height=23 class=xl81 colspan=2 style='height:17.25pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>    </span>Mã &#273;&#417;n v&#7883;: <font
  class="font9">YN0473Z</font></td>
  <td colspan=6 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td class=xl75></td>
  <td colspan=3 class=xl80 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl82 height=43 style='mso-height-source:userset;height:32.25pt'>
  <td colspan=10 height=43 class=xl130 style='height:32.25pt'>DANH SÁCH
  NG&#431;&#7900;I LAO &#272;&#7896;NG &#272;&#7872; NGH&#7882;
  H&#431;&#7902;NG CH&#7870; &#272;&#7896; THAI S&#7842;N</td>
  <td colspan=3 class=xl82 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=10 height=21 class=xl83 style='height:15.75pt'>Tháng <%= dt_sum.Rows[0][3].ToString() %> quý <%= dt_sum.Rows[0][4].ToString() %>
  n&#259;m <%= dt_sum.Rows[0][5].ToString() %></td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl78 height=21 style='height:15.75pt'>
  <td height=21 class=xl78 colspan=2 style='height:15.75pt;mso-ignore:colspan'
  x:str="S&#7889; hi&#7879;u tài kho&#7843;n:        ">S&#7889; hi&#7879;u tài
  kho&#7843;n:<span style='mso-spacerun:yes'>        </span></td>
  <td class=xl84>6252582-001</td>
  <td class=xl85></td>
  <td class=xl78></td>
  <td class=xl78>M&#7903; t&#7841;i:</td>
  <td class=xl78 colspan=3 style='mso-ignore:colspan'>Ngân Hàng Indovina Bank-
  &#272;&#7891;ng Nai</td>
  <td class=xl67></td>
  <td colspan=3 class=xl78 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl78 height=21 style='height:15.75pt'>
  <td height=21 class=xl78 colspan=2 style='height:15.75pt;mso-ignore:colspan'
  x:str>T&#7893;ng s&#7889;
  lao &#273;&#7897;ng:<span style='mso-spacerun:yes'>         </span></td>
  <td class=xl86><%= dt_sum.Rows[0][0].ToString() %> Ng&#432;&#7901;i</td>
  <td class=xl87></td>
  <td class=xl82></td>
  <td class=xl82 colspan=2 style='mso-ignore:colspan'>Trong &#273;ó n&#7919;:
  <%= dt_sum.Rows[0][2].ToString() %> ng&#432;&#7901;i</td>
  <td class=xl78></td>
  <td class=xl68></td>
  <td class=xl67></td>
  <td colspan=3 class=xl78 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl82 height=21 style='height:15.75pt'>
  <td height=21 class=xl82 colspan=2 style='height:15.75pt;mso-ignore:colspan'
  x:str="T&#7893;ng qu&#7929; l&#432;&#417;ng trong(tháng) quý : ">T&#7893;ng
  qu&#7929; l&#432;&#417;ng trong(tháng) quý :<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl89 x:num><span style='mso-spacerun:yes'> 
  </span><%= dt_sum.Rows[0][1].ToString() %> </td>
  <td class=xl86>VND(tháng)</td>
  <td class=xl82></td>
  <td colspan=3 class=xl88 style='mso-ignore:colspan'></td>
  <td class=xl69></td>
  <td class=xl66></td>
  <td colspan=3 class=xl82 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl76 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl69></td>
  <td class=xl66></td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl90 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td rowspan=3 height=90 class=xl127 width=31 style='height:67.5pt;width:23pt'>STT</td>
  <td rowspan=3 class=xl127 width=209 style='width:157pt'>H&#7885; và tên</td>
  <td rowspan=3 class=xl127 width=98 style='width:74pt'>S&#7889; s&#7893; BHXH</td>
  <td rowspan=3 class=xl127 width=95 style='width:71pt'>Ti&#7873;n
  l&#432;&#417;ng tính h&#432;&#7903;ng BHXH</td>
  <td rowspan=3 class=xl127 width=95 style='width:71pt'>Th&#7901;i gian
  &#273;óng BHXH</td>
  <td colspan=3 class=xl116 width=263 style='border-right:.5pt solid black;
  border-left:none;width:197pt'>S&#7889; &#273;&#7873; ngh&#7883;</td>
  <td colspan=2 rowspan=3 class=xl119 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>Ghi chú</td>
  <td colspan=3 class=xl90 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl90 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=2 height=19 class=xl125 width=160 style='border-right:.5pt solid black;
  height:14.25pt;border-left:none;width:120pt'>S&#7889; ngày ngh&#7881;</td>
  <td rowspan=2 class=xl127 width=103 style='border-top:none;width:77pt'
  x:str="S&#7889; ti&#7873;n ">S&#7889; ti&#7873;n<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl90 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl90 height=50 style='mso-height-source:userset;height:37.5pt'>
  <td height=50 class=xl91 width=72 style='height:37.5pt;border-left:none;
  width:54pt'>Trong k&#7923;</td>
  <td class=xl91 width=88 style='border-left:none;width:66pt'>Lu&#7929;
  k&#7871; t&#7915; &#273;&#7847;u n&#259;m</td>
  <td colspan=3 class=xl90 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl93 height=21 style='height:15.75pt'>
  <td height=21 class=xl92 style='height:15.75pt'>A</td>
  <td class=xl92 style='border-left:none'>B</td>
  <td class=xl92 style='border-left:none'>C</td>
  <td class=xl92 style='border-left:none' x:num>1</td>
  <td class=xl92 style='border-left:none' x:num>2</td>
  <td class=xl92 style='border-left:none' x:num>3</td>
  <td class=xl92 style='border-left:none' x:num>4</td>
  <td class=xl92 style='border-left:none' x:num>5</td>
  <td colspan=2 class=xl128 style='border-right:.5pt solid black;border-left:
  none' x:num>6</td>
  <td colspan=3 class=xl93 style='mso-ignore:colspan'></td>
 </tr>
   <%
     Boolean flag = true;
     string old_type, new_type;
     string[] seq = new string[5] { "I", "II", "III", "IV", "V" };
     double[] sum = new Double[3] { 0, 0, 0 };
     int tt = 0;
	 int count =0;
    for(int i=0; i< irow; i++)
    {
        old_type = dt_emp.Rows[i][0].ToString();
        count++;
        
        sum[0] += Double.Parse(dt_emp.Rows[i][5].ToString());
        sum[1] += Double.Parse(dt_emp.Rows[i][6].ToString());
        sum[2] += Double.Parse(dt_emp.Rows[i][7].ToString());
        
        if(flag)
        {
  %>
 <tr class=xl93 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl94 style='height:21.0pt'><%= seq[tt] %></td>
  <td class=xl95 style='border-left:none' x:str><%= dt_emp.Rows[i][0].ToString() %><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl94 style='border-left:none'>&nbsp;</td>
  <td class=xl94 style='border-left:none'>&nbsp;</td>
  <td class=xl94 style='border-left:none'>&nbsp;</td>
  <td class=xl94 style='border-left:none'>&nbsp;</td>
  <td class=xl94 style='border-left:none'>&nbsp;</td>
  <td class=xl94 style='border-left:none'>&nbsp;</td>
  <td class=xl73 style='border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl93 style='mso-ignore:colspan'></td>
 </tr>
   <%         tt++;
            flag = false;
        }
  %>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl96 style='height:21.0pt;border-top:none' x:num><%= count %></td>
  <td class=xl97 style='border-top:none;border-left:none'><%= dt_emp.Rows[i][1].ToString() %></td>
  <td class=xl96 style='border-top:none;border-left:none' x:num><%= dt_emp.Rows[i][2].ToString() %></td>
  <td class=xl98 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>     </span><%= dt_emp.Rows[i][3].ToString() %> </td>
  <td class=xl96 style='border-top:none;border-left:none' x:str><%= dt_emp.Rows[i][4].ToString() %></td>
  <td class=xl96 style='border-top:none;border-left:none' x:num><%= dt_emp.Rows[i][5].ToString() %></td>
  <td class=xl96 style='border-top:none;border-left:none' x:num><%= dt_emp.Rows[i][6].ToString() %></td>
  <td class=xl99 style='border-top:none;border-left:none'
  x:num><span
  style='mso-spacerun:yes'>            </span><%= dt_emp.Rows[i][7].ToString() %> </td>
  <td class=xl73 style='border-top:none;border-left:none'><%= dt_emp.Rows[i][8].ToString() %></td>
  <td class=xl72 style='border-top:none;border-left:none'><%= dt_emp.Rows[i][9].ToString() %></td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <%
     if (i < irow - 1)
     {
         new_type = dt_emp.Rows[i + 1][0].ToString();

         if (new_type != old_type)
             flag = true;
     }
     else
     {
         flag = true;
     }
  }
  %>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  420'>
  <td class=xl96 style='border-top:none' x:num>1</td>
  <td class=xl95 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  420'>
  <td class=xl100>....</td>
  <td class=xl101 style='border-left:none'>&nbsp;</td>
  <td class=xl100 style='border-left:none'>&nbsp;</td>
  <td class=xl100 style='border-left:none'>&nbsp;</td>
  <td class=xl100 style='border-left:none'>&nbsp;</td>
  <td class=xl100 style='border-left:none'>&nbsp;</td>
  <td class=xl100 style='border-left:none'>&nbsp;</td>
  <td class=xl100 style='border-left:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 class=xl112 style='height:8.25pt'>&nbsp;</td>
  <td class=xl113 style='border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl115 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl102 style='height:17.25pt'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>T&#7893;ng c&#7897;ng</td>
  <td class=xl104 style='border-left:none'>&nbsp;</td>
  <td class=xl104 style='border-left:none'>&nbsp;</td>
  <td class=xl104 style='border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><%= sum[0] %> </td>
  <td class=xl105 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                 </span><%= sum[1] %> </td>
  <td class=xl105 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%= sum[2] %> </td>
  <td class=xl106 style='border-left:none'>&nbsp;</td>
  <td class=xl107 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl76 style='height:15.0pt'></td>
  <td class=xl83></td>
  <td colspan=5 class=xl76 style='mso-ignore:colspan'></td>
  <td class=xl108><span
  style='mso-spacerun:yes'>                                           
  </span>Ngày <%= dt_sum.Rows[0][6].ToString() %><span style='mso-spacerun:yes'>  </span>tháng <%= dt_sum.Rows[0][7].ToString() %><span
  style='mso-spacerun:yes'>  </span>n&#259;m <%= dt_sum.Rows[0][8].ToString() %></td>
  <td colspan=5 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl80 height=21 style='height:15.75pt'>
  <td height=21 class=xl80 style='height:15.75pt'></td>
  <td class=xl83>Xác nh&#7853;n Thu BHXH</td>
  <td class=xl80></td>
  <td class=xl83>Ng&#432;&#7901;i l&#7853;p</td>
  <td class=xl80></td>
  <td class=xl83><span style='mso-spacerun:yes'>                  
  </span>K&#7871; toán Tr&#432;&#7903;ng</td>
  <td class=xl80></td>
  <td class=xl83><span
  style='mso-spacerun:yes'>                                 </span>Th&#7911;
  tr&#432;&#7903;ng &#273;&#417;n v&#7883;</td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td class=xl108></td>
  <td class=xl77></td>
 </tr>
 <tr class=xl80 height=21 style='height:15.75pt'>
  <td height=21 class=xl80 style='height:15.75pt'></td>
  <td class=xl83>(Ký, h&#7885; tên)</td>
  <td class=xl80></td>
  <td class=xl83>(Ký, h&#7885; tên)</td>
  <td class=xl80></td>
  <td class=xl83><span style='mso-spacerun:yes'>                    
  </span>(Ký, h&#7885; tên)</td>
  <td class=xl80></td>
  <td class=xl83><span
  style='mso-spacerun:yes'>                                     </span>(Ký tên
  và &#273;óng d&#7845;u)</td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td class=xl83></td>
  <td class=xl77></td>
 </tr>
 <tr class=xl80 height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl80 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td class=xl83></td>
  <td class=xl77></td>
 </tr>
 <tr class=xl80 height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl80 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td class=xl83></td>
  <td class=xl77></td>
 </tr>
 <tr class=xl80 height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl80 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td class=xl83></td>
  <td class=xl77></td>
 </tr>
 <tr class=xl80 height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 colspan=8 class=xl80 style='height:9.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl77></td>
 </tr>
 <tr class=xl80 height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl80 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl77></td>
 </tr>
 <tr class=xl109 height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl109 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl110>NGUY&#7876;N TH&#7882; KIM OANH</td>
  <td class=xl109></td>
  <td class=xl110><span style='mso-spacerun:yes'>                         
  </span>LÊ TH&#7882; ANH TH&#431;</td>
  <td class=xl109></td>
  <td colspan=2 class=xl110><span style='mso-spacerun:yes'>                 
  </span>BANG YEONG SIG</td>
  <td></td>
  <td colspan=3 class=xl110></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl76 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl76 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td class=xl71></td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl76 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td class=xl71></td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl76 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td class=xl71></td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl76 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td class=xl71></td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl76 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl76 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl76 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl77></td>
  <td class=xl74></td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=31 style='width:23pt'></td>
  <td width=209 style='width:157pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
