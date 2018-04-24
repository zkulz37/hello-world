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
    = "select v.CODE_NM, ti.FULL_NAME, ti.SOCIAL_NO, ti.CONDITION, round(nvl(ti.AVERAGE_SALARY,0),0) " +
        "    ,to_char(to_date(ti.ST_SOCIAL_DT,'yyyymm'),'mm-yyyy'),nvl(ti.DAYS,0), nvl(ti.PROGRESSIVE,0)  " +
        "    ,round(ti.INS_AMT,0),to_char(to_date(ti.FROM_DT,'yyyymmdd'),'dd/mm/yyyy'),"+
        "    to_char(to_date(ti.TO_DT,'yyyymmdd'),'dd/mm/yyyy'), ti.REMARK, v.NUM_1 " +
        "from THR_INS_REGULATION ti, vhr_hr_code v  " +
        "where ti.DEL_IF=0 " +
        "and ti.INS_MONTH='"+p_mon+"' " +
        "and v.ID='HR0055' " +
        "and ti.INS_REG_TYPE='01' " +
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
<link rel=File-List href="rpt_C66a_HD_VHPC_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_C66a_HD_VHPC_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_C66a_HD_VHPC_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>welcome</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-05-13T07:14:52Z</o:LastPrinted>
  <o:Created>2008-06-12T07:32:33Z</o:Created>
  <o:LastSaved>2011-05-13T07:15:34Z</o:LastSaved>
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
.font13
	{color:black;
	font-size:13.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
.font14
	{color:black;
	font-size:13.0pt;
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
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl68
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style43;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl74
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl75
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl76
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl77
	{mso-style-parent:style0;
	font-size:13.0pt;
	vertical-align:middle;}
.xl78
	{mso-style-parent:style0;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl79
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl80
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
.xl81
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
	border-left:none;}
.xl82
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
	border-left:none;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl84
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl87
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl88
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	font-size:12.0pt;}
.xl90
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl91
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl94
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
.xl95
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl96
	{mso-style-parent:style43;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
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
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl98
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
.xl99
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl100
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl101
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl102
	{mso-style-parent:style43;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl103
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl104
	{mso-style-parent:style0;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl105
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl106
	{mso-style-parent:style0;
	font-size:13.0pt;
	text-align:center;}
.xl107
	{mso-style-parent:style0;
	font-size:13.0pt;}
.xl108
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl109
	{mso-style-parent:style45;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;}
.xl110
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl111
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl112
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl113
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl114
	{mso-style-parent:style43;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl115
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl116
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl117
	{mso-style-parent:style43;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl118
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
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl119
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl120
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;}
.xl121
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
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl122
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl123
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl124
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl125
	{mso-style-parent:style0;
	color:windowtext;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl126
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl127
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
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
	border-right:.5pt solid windowtext;
	border-bottom:none;
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
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl130
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl131
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
.xl132
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl133
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl134
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl135
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl136
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>C66</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>95</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>4</x:ActiveRow>
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
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='C66'!$12:$15</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="11265"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1036 style='border-collapse:
 collapse;table-layout:fixed;width:778pt'>
 <col width=36 style='mso-width-source:userset;mso-width-alt:1316;width:27pt'>
 <col width=249 style='mso-width-source:userset;mso-width-alt:9106;width:187pt'>
 <col width=93 style='mso-width-source:userset;mso-width-alt:3401;width:70pt'>
 <col width=101 style='mso-width-source:userset;mso-width-alt:3693;width:76pt'>
 <col width=95 span=2 style='mso-width-source:userset;mso-width-alt:3474;
 width:71pt'>
 <col width=53 style='mso-width-source:userset;mso-width-alt:1938;width:40pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=84 style='mso-width-source:userset;mso-width-alt:3072;width:63pt'>
 <col width=82 style='mso-width-source:userset;mso-width-alt:2998;width:62pt'>
 <col width=83 style='mso-width-source:userset;mso-width-alt:3035;width:62pt'>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=10 height=27 class=xl124 width=953 style='height:20.25pt;
  width:716pt'>C&#7896;NG HÒA XÃ H&#7896;I CH&#7910; NGH&#296;A VI&#7878;T NAM</td>
  <td width=83 style='width:62pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=10 height=21 class=xl120 style='height:15.75pt'>&#272;&#7897;c
  L&#7853;p- T&#7921; Do- H&#7841;nh Phúc</td>
  <td></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=10 height=21 class=xl120 style='height:15.75pt'>-----o0o-----</td>
  <td></td>
 </tr>
 <tr class=xl107 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl77 colspan=4 style='height:20.25pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>    </span>Tên công ty: <font class="font13">Công ty
  TNHH Trung Tâm Gia Công POSCO Vi&#7879;t Nam</font></td>
  <td colspan=5 class=xl106 style='mso-ignore:colspan'></td>
  <td class=xl120>M&#7850;U C66a-HD</td>
  <td class=xl107></td>
 </tr>
 <tr class=xl107 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl108 colspan=2 style='height:20.25pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>    </span>Mã &#273;&#417;n v&#7883;: <font
  class="font14">YN0473Z</font></td>
  <td colspan=8 class=xl106 style='mso-ignore:colspan'></td>
  <td class=xl107></td>
 </tr>
 <tr class=xl66 height=37 style='mso-height-source:userset;height:27.75pt'>
  <td colspan=11 height=37 class=xl125 style='height:27.75pt'>DANH SÁCH
  NG&#431;&#7900;I LAO &#272;&#7896;NG &#272;&#7872; NGH&#7882;
  H&#431;&#7902;NG CH&#7870; &#272;&#7896; &#7888;M &#272;AU</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=10 height=20 class=xl126 style='height:15.0pt'>Tháng <%= dt_sum.Rows[0][3].ToString() %> quý <%= dt_sum.Rows[0][4].ToString() %>
  n&#259;m <%= dt_sum.Rows[0][5].ToString() %></td>
  <td></td>
 </tr>
 <tr class=xl68 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl68 colspan=2 style='height:17.25pt;mso-ignore:colspan'
  x:str="S&#7889; hi&#7879;u tài kho&#7843;n:        ">S&#7889; hi&#7879;u tài
  kho&#7843;n:<span style='mso-spacerun:yes'>        </span></td>
  <td class=xl103>6252582-001</td>
  <td class=xl103></td>
  <td class=xl68></td>
  <td class=xl68>M&#7903; t&#7841;i:</td>
  <td class=xl68 colspan=4 style='mso-ignore:colspan'>Ngân Hàng Indovina Bank-
  &#272;&#7891;ng Nai</td>
  <td class=xl68></td>
 </tr>
 <tr class=xl68 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl68 colspan=2 style='height:17.25pt;mso-ignore:colspan'
  x:str>T&#7893;ng s&#7889;
  lao &#273;&#7897;ng:<span style='mso-spacerun:yes'>         </span></td>
  <td class=xl104><%= dt_sum.Rows[0][0].ToString() %> Ng&#432;&#7901;i</td>
  <td class=xl104></td>
  <td class=xl78></td>
  <td class=xl78>Trong &#273;ó n&#7919;:</td>
  <td class=xl78><%= dt_sum.Rows[0][2].ToString() %> ng&#432;<span style='display:none'>&#7901;i</span></td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td class=xl68></td>
 </tr>
 <tr class=xl66 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl76 colspan=2 style='height:17.25pt;mso-ignore:colspan'
  x:str="T&#7893;ng qu&#7929; l&#432;&#417;ng trong(tháng) quý : ">T&#7893;ng
  qu&#7929; l&#432;&#417;ng trong(tháng) quý :<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl109 x:num="355651989"><span style='mso-spacerun:yes'>  
  </span><%= dt_sum.Rows[0][2].ToString() %> </td>
  <td class=xl105>VND(tháng)</td>
  <td colspan=6 class=xl72 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
 </tr>
 <tr class=xl66 height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl71 style='height:9.0pt'>&nbsp;</td>
  <td colspan=5 class=xl72 style='mso-ignore:colspan'></td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl72></td>
  <td class=xl66></td>
 </tr>
 <tr class=xl67 height=21 style='height:15.75pt'>
  <td rowspan=3 height=110 class=xl127 style='height:82.5pt;border-top:none'>STT</td>
  <td rowspan=3 class=xl128 style='border-bottom:.5pt solid black'>H&#7885; và
  Tên</td>
  <td rowspan=3 class=xl121 width=93 style='border-bottom:.5pt solid black;
  width:70pt'>S&#7889; s&#7893;<br>
    BHXH</td>
  <td rowspan=3 class=xl121 width=101 style='border-bottom:.5pt solid black;
  width:76pt'>&#272;i&#7873;u ki&#7879;n<br>
    <span style='mso-spacerun:yes'> </span>tính h&#432;&#7903;ng</td>
  <td rowspan=3 class=xl121 width=95 style='border-bottom:.5pt solid black;
  width:71pt'>Ti&#7873;n l&#432;&#417;ng tính h&#432;&#7903;ng BHXH</td>
  <td rowspan=3 class=xl121 width=95 style='border-bottom:.5pt solid black;
  width:71pt'>Th&#7901;i gian <br>
    &#273;óng BHXH</td>
  <td colspan=3 class=xl127 style='border-left:none'>&#272;&#417;n v&#7883;
  &#273;&#7873; ngh&#7883;</td>
  <td colspan=2 rowspan=3 class=xl131 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>Ghi chú</td>
 </tr>
 <tr class=xl67 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl127 style='height:18.0pt;border-left:none'>S&#7889;
  ngày ngh&#7881;<br>
    </td>
  <td rowspan=2 class=xl121 width=84 style='border-bottom:.5pt solid black;
  border-top:none;width:63pt'>Ti&#7873;n<br>
    <span style='mso-spacerun:yes'> </span>tr&#7907; c&#7845;p</td>
 </tr>
 <tr class=xl67 height=65 style='mso-height-source:userset;height:48.75pt'>
  <td height=65 class=xl79 width=53 style='height:48.75pt;border-top:none;
  border-left:none;width:40pt'>Trong k&#7923;</td>
  <td class=xl79 width=65 style='border-top:none;border-left:none;width:49pt'>L&#361;y
  k&#7871; t&#7915; &#273;&#7847;u n&#259;m</td>
 </tr>
  <%
     Boolean flag = true;
     string old_type, new_type;
     string[] seq = new string[4] { "I", "II", "III", "IV" };
     double[] sum = new Double[3] { 0, 0, 0 };
     int tt = 0;
	 int count =0;
    for(int i=0; i< irow; i++)
    {
        old_type = dt_emp.Rows[i][0].ToString();
        count++;
        
        sum[0] += Double.Parse(dt_emp.Rows[i][6].ToString());
        sum[1] += Double.Parse(dt_emp.Rows[i][7].ToString());
        sum[2] += Double.Parse(dt_emp.Rows[i][8].ToString());
        
        if(flag)
        {
  %>
 <tr class=xl67 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl80 style='height:17.25pt;border-top:none'><%= seq[tt] %></td>
  <td class=xl81 style='border-top:none'><%= dt_emp.Rows[i][0].ToString() %></td>
  <td class=xl82 width=93 style='border-top:none;width:70pt'>&nbsp;</td>
  <td class=xl82 width=101 style='border-top:none;width:76pt'>&nbsp;</td>
  <td class=xl81 style='border-top:none'>&nbsp;</td>
  <td class=xl81 style='border-top:none'>&nbsp;</td>
  <td class=xl82 width=53 style='border-top:none;width:40pt'>&nbsp;</td>
  <td class=xl82 width=65 style='border-top:none;width:49pt'>&nbsp;</td>
  <td class=xl82 width=84 style='border-top:none;width:63pt'>&nbsp;</td>
  <td class=xl81 style='border-top:none'>&nbsp;</td>
  <td class=xl83 style='border-top:none'>&nbsp;</td>
 </tr>
  <%         tt++;
            flag = false;
        }
  %>
 <tr class=xl67 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl111 style='height:26.25pt' x:num><%= count %></td>
  <td class=xl112 style='border-left:none' x:str><%= dt_emp.Rows[i][1].ToString() %><span style='mso-spacerun:yes'> </span></td>
  <td class=xl119 style='border-left:none' x:str><%= dt_emp.Rows[i][2].ToString() %></td>
  <td class=xl113 style='border-left:none'><%= dt_emp.Rows[i][3].ToString() %></td>
  <td class=xl114 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_emp.Rows[i][4].ToString() %> </td>
  <td class=xl115 style='border-left:none' x:str><%= dt_emp.Rows[i][5].ToString() %></td>
  <td class=xl116 style='border-left:none' x:num><%= dt_emp.Rows[i][6].ToString() %></td>
  <td class=xl116 style='border-left:none' x:num><%= dt_emp.Rows[i][7].ToString() %></td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_emp.Rows[i][8].ToString() %> </td>
  <td class=xl118 style='border-left:none'><%= dt_emp.Rows[i][9].ToString() %></td>
  <td class=xl118 style='border-left:none'><%= dt_emp.Rows[i][10].ToString() %></td>
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
 <tr class=xl67 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl84 style='height:13.5pt;border-top:none'>&nbsp;</td>
  <td class=xl95 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl92 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl91 style='border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl97 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl93 width=53 style='border-top:none;border-left:none;width:40pt'>&nbsp;</td>
  <td class=xl93 width=65 style='border-top:none;border-left:none;width:49pt'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl94 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl66 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl80 style='height:21.0pt'>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl81>T&#7893;ng c&#7897;ng</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl86>&nbsp;</td>
  <td class=xl87>&nbsp;</td>
  <td class=xl101 style='border-left:none' x:num><%= sum[0] %></td>
  <td class=xl101 style='border-left:none' x:num><%= sum[1] %></td>
  <td class=xl102 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%= sum[2] %> </td>
  <td class=xl88 style='border-left:none'>&nbsp;</td>
  <td class=xl88 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 style='height:6.0pt'></td>
  <td colspan=2 class=xl73 style='mso-ignore:colspan'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td class=xl75></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl89 height=21 style='height:15.75pt'>
  <td height=21 class=xl89 style='height:15.75pt'></td>
  <td class=xl74>Xác nh&#7853;n Thu BHXH</td>
  <td class=xl89></td>
  <td class=xl74>Ng&#432;&#7901;i l&#7853;p</td>
  <td class=xl89></td>
  <td class=xl74>K&#7871; toán Tr&#432;&#7903;ng</td>
  <td colspan=2 class=xl89 style='mso-ignore:colspan'></td>
  <td class=xl99>Ngày<span style='mso-spacerun:yes'>  <%= dt_sum.Rows[0][6].ToString() %>   </span>tháng<span
  style='mso-spacerun:yes'> <%= dt_sum.Rows[0][7].ToString() %>     </span>n&#259;m <%= dt_sum.Rows[0][8].ToString() %></td>
  <td colspan=2 class=xl89 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl89 height=21 style='height:15.75pt'>
  <td height=21 class=xl89 style='height:15.75pt'></td>
  <td class=xl74>(Ký, h&#7885; tên)</td>
  <td class=xl89></td>
  <td class=xl74>(Ký, h&#7885; tên)</td>
  <td class=xl89></td>
  <td class=xl74>(Ký, h&#7885; tên)</td>
  <td colspan=2 class=xl89 style='mso-ignore:colspan'></td>
  <td class=xl74>Th&#7911; tr&#432;&#7903;ng &#273;&#417;n v&#7883;</td>
  <td class=xl89></td>
  <td class=xl90></td>
 </tr>
 <tr class=xl89 height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl89 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl74><span style='mso-spacerun:yes'>   </span>(Ký tên và &#273;óng
  d&#7845;u)</td>
  <td class=xl89></td>
  <td class=xl90></td>
 </tr>
 <tr class=xl89 height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl89 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl74></td>
  <td class=xl89></td>
  <td class=xl90></td>
 </tr>
 <tr class=xl89 height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl89 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl74></td>
  <td class=xl89></td>
  <td class=xl90></td>
 </tr>
 <tr class=xl89 height=21 style='height:15.75pt'>
  <td height=21 colspan=11 class=xl89 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl100 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 colspan=3 class=xl100 style='height:20.25pt;mso-ignore:colspan'></td>
  <td class=xl110>NGUY&#7876;N TH&#7882; KIM OANH</td>
  <td class=xl100></td>
  <td class=xl110><span style='mso-spacerun:yes'>   </span>LÊ TH&#7882; ANH
  TH&#431;</td>
  <td class=xl100></td>
  <td colspan=3 class=xl110><span style='mso-spacerun:yes'>         </span>BANG
  YEONG SIG</td>
  <td class=xl100></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=36 style='width:27pt'></td>
  <td width=249 style='width:187pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=83 style='width:62pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
