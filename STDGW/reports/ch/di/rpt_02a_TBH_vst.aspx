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
	= "SELECT A.FULL_NAME as c1  " + 
        ",A.SO_BHXH  c2  " +
        ",DECODE(LENGTH(A.BIRTH_DT),4,A.BIRTH_DT,TO_CHAR(TO_DATE(A.BIRTH_DT,'YYYYMMDD'),'DD/MM/YYYY')) AS NGAYSINH5  " +
        ",DECODE(A.SEX,'F','X','') AS SEXc4 " +
        ", A.ADDRESS c5    " +
        ",(SELECT CHAR_1 FROM VHR_HR_CODE V WHERE V.ID='HR0012' AND V.CODE=A.HEALTH_PLACE)  AS TINH6 " +
        ",(SELECT CODE_FNM FROM VHR_HR_CODE V WHERE V.ID='HR0012' AND V.CODE=A.HEALTH_PLACE) AS BENHVIEN7  " +
        ",(SELECT code_fnm FROM VHR_HR_CODE V WHERE V.ID='HR0008' AND V.CODE=A.CHUC_DANH ) c8 " +
        ",nvl(A.LUONG_MOI,0) c9  " +
        ",TO_CHAR(TO_DATE(A.TU_THANG,'YYYYMM'),'MM/YYYY') C10  " +
        ",A.MA_HOP_DONG c11  " +
        ",TO_CHAR(TO_DATE(A.NGAY_KY_HD,'YYYYMMDD'),'DD/MM/YYYY') c12  " +
        ",(SELECT code_fnm FROM VHR_HR_CODE V WHERE V.ID='HR0001' AND V.CODE=A.loai_hd ) c13   " +
        ",A.SO_CMT AS CMT14  " +
        ",nvl(A.DC_TANG_XH,0) c15  " +
        ",nvl(A.DC_TANG_YT,0) c16  " +
        ",nvl(A.DC_TANG_TN,0) c17  " +
        "FROM THR_INSURANCE_MANAGE A " +
        "WHERE A.DEL_IF=0 AND A.THANG_BC='" + p_rpt_month + "' " +
        "AND A.LOAI_BH='01' " +
        "AND A.LAN_BAO='" + p_times + "' " +
        "ORDER BY A.EMP_ID " ;

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
    %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_02a_TBH_posco_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_02a_TBH_posco_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_02a_TBH_posco_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>BHXH Dong Nai</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2010-12-02T02:11:55Z</o:LastPrinted>
  <o:Created>2008-03-17T06:49:57Z</o:Created>
  <o:LastSaved>2011-04-21T04:25:30Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.3in .17in .82in 0in;
	mso-header-margin:.25in;
	mso-footer-margin:.18in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
.font6
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Times New Roman;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
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
.style24
	{mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	mso-style-name:"Comma \[0\]";
	mso-style-id:6;}
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
	font-family:Times New Roman;
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
	font-family:Times New Roman;
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
	font-size:10.0pt;
	font-weight:700;}
.xl47
	{mso-style-parent:style0;
	font-size:10.0pt;
	text-align:center-across;}
.xl48
	{mso-style-parent:style0;
	font-size:10.0pt;}
.xl49
	{mso-style-parent:style0;
	font-size:10.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:left;}
.xl50
	{mso-style-parent:style0;
	font-size:10.0pt;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-size:10.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:center;}
.xl52
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	font-size:10.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:10.0pt;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;}
.xl55
	{mso-style-parent:style0;
	font-size:10.0pt;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	font-size:10.0pt;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-size:10.0pt;
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-size:10.0pt;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	vertical-align:middle;}
.xl61
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	vertical-align:middle;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-size:10.0pt;
	vertical-align:middle;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-style:italic;
	text-align:center;}
.xl64
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	vertical-align:middle;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;}
.xl67
	{mso-style-parent:style0;
	font-size:10.0pt;
	text-align:center;}
.xl68
	{mso-style-parent:style0;
	font-size:10.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl69
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;}
.xl70
	{mso-style-parent:style0;
	font-size:10.0pt;
	text-align:left;}
.xl71
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:center;}
.xl72
	{mso-style-parent:style0;
	font-size:10.0pt;
	text-align:right;}
.xl73
	{mso-style-parent:style23;
	font-size:9.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;}
.xl74
	{mso-style-parent:style23;
	font-size:10.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl75
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:right;}
.xl76
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	mso-number-format:Fixed;
	text-align:left;}
.xl77
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:left;}
.xl78
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:right;}
.xl79
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	text-align:center-across;}
.xl80
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;}
.xl81
	{mso-style-parent:style0;
	font-size:11.0pt;
	mso-number-format:"\#\,\#\#0";}
.xl82
	{mso-style-parent:style0;
	font-size:11.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:left;}
.xl83
	{mso-style-parent:style0;
	font-size:11.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:center;}
.xl84
	{mso-style-parent:style0;
	font-size:11.0pt;}
.xl85
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;}
.xl86
	{mso-style-parent:style0;
	font-size:11.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	white-space:normal;}
.xl87
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:left;}
.xl88
	{mso-style-parent:style0;
	font-size:10.0pt;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style23;
	font-size:10.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style0;
	font-size:10.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	font-size:10.0pt;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	font-size:10.0pt;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style24;
	font-size:10.0pt;
	font-family:굴림체, monospace;
	mso-font-charset:129;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:normal;}
.xl95
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl96
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl97
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl98
	{mso-style-parent:style0;
	font-size:10.0pt;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl99
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	text-align:left;
	vertical-align:justify;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl100
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl101
	{mso-style-parent:style23;
	font-size:10.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl102
	{mso-style-parent:style0;
	font-size:10.0pt;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl103
	{mso-style-parent:style0;
	font-size:10.0pt;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl104
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl105
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022???_\)\;_\(\@_\)";
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl106
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl107
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl108
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl109
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;}
.xl110
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl111
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:center;}
.xl112
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl113
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl114
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl115
	{mso-style-parent:style0;
	font-size:10.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl116
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl117
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl118
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl119
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl120
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl121
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl122
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl123
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl124
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl125
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl126
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl127
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	mso-number-format:Fixed;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl128
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	text-align:center;}
.xl129
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;}
.xl130
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl131
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	text-align:left;
	vertical-align:justify;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;}
.xl132
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	text-align:left;
	vertical-align:justify;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl133
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl134
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl135
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl136
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;}
.xl137
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl138
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:normal;}
.xl139
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl140
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:normal;}
.xl141
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl142
	{mso-style-parent:style0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl143
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl144
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl145
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:normal;}
.xl146
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl147
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl148
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl149
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl150
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl151
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl152
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl153
	{mso-style-parent:style23;
	font-size:10.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl154
	{mso-style-parent:style23;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl155
	{mso-style-parent:style23;
	font-size:10.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl156
	{mso-style-parent:style0;
	font-size:10.0pt;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl157
	{mso-style-parent:style0;
	font-size:10.0pt;
	mso-number-format:"mmm\\-yy";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>12</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>70</x:Scale>
      <x:HorizontalResolution>-3</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>4</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
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
 <x:ExcelName>
  <x:Name>Print_Area</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='12'!$A$1:$S$33</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl48>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1703 style='border-collapse:
 collapse;table-layout:fixed;width:1278pt'>
 <col class=xl24 width=31 style='mso-width-source:userset;mso-width-alt:992;
 width:23pt'>
 <col class=xl24 width=195 style='mso-width-source:userset;mso-width-alt:6240;
 width:146pt'>
 <col class=xl24 width=77 style='mso-width-source:userset;mso-width-alt:2464;
 width:58pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2400;
 width:56pt'>
 <col class=xl24 width=26 style='mso-width-source:userset;mso-width-alt:832;
 width:20pt'>
 <col class=xl24 width=265 style='mso-width-source:userset;mso-width-alt:8480;
 width:199pt'>
 <col class=xl24 width=59 style='mso-width-source:userset;mso-width-alt:1888;
 width:44pt'>
 <col class=xl25 width=114 style='mso-width-source:userset;mso-width-alt:3648;
 width:86pt'>
 <col class=xl24 width=87 style='mso-width-source:userset;mso-width-alt:2784;
 width:65pt'>
 <col class=xl24 width=91 style='mso-width-source:userset;mso-width-alt:2912;
 width:68pt'>
 <col class=xl24 width=20 span=4 style='mso-width-source:userset;mso-width-alt:
 640;width:15pt'>
 <col class=xl24 width=55 style='mso-width-source:userset;mso-width-alt:1760;
 width:41pt'>
 <col class=xl24 width=65 style='mso-width-source:userset;mso-width-alt:2080;
 width:49pt'>
 <col class=xl24 width=70 style='mso-width-source:userset;mso-width-alt:2240;
 width:53pt'>
 <col class=xl24 width=179 style='mso-width-source:userset;mso-width-alt:5728;
 width:134pt'>
 <col class=xl26 width=71 style='mso-width-source:userset;mso-width-alt:2272;
 width:53pt'>
 <col class=xl24 width=58 style='mso-width-source:userset;mso-width-alt:1856;
 width:44pt'>
 <col class=xl24 width=105 style='mso-width-source:userset;mso-width-alt:3360;
 width:79pt'>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=19 height=27 class=xl128 width=1521 style='height:20.25pt;
  width:1141pt'><a name="Print_Area">DANH SÁCH<span style='mso-spacerun:yes'> 
  </span>LAO ĐỘNG ĐÓNG BHXH, BHYT, BHTN</a></td>
  <td class=xl48 width=58 style='width:44pt'></td>
  <td class=xl48 width=105 style='width:79pt'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=19 height=28 class=xl129 style='height:21.0pt'><span
  style='mso-spacerun:yes'> </span>Số 01 Tháng <%=p_rpt_month.Substring(4,2) %> Năm <%=p_rpt_month.Substring(0,4) %></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl84 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl79 style='height:19.5pt'></td>
  <td class=xl80 colspan=4 style='mso-ignore:colspan'
  x:str>Tên cơ quan ( đơn vị ): <%=dt_name.Rows[1][0].ToString() %><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl81></td>
  <td class=xl82></td>
  <td class=xl83></td>
  <td class=xl82></td>
  <td colspan=10 class=xl111>Mẫu: 02a- TBH</td>
  <td colspan=2 class=xl84 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl84 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl79 style='height:15.75pt'></td>
  <td class=xl85>Mã đơn vị :</td>
  <td colspan=5 class=xl82 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td class=xl82></td>
  <td colspan=10 class=xl86 width=592 style='width:444pt'>(Ban hành kèm theo CV số 1615/BHXH-CSXH <br>
    ngày 02/06/2009 của BHXH Việt Nam)</td>
  <td colspan=2 class=xl84 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl84 height=23 style='height:17.25pt'>
  <td height=23 class=xl79 style='height:17.25pt'></td>
  <td class=xl85 colspan=2 style='mso-ignore:colspan'>Địa chỉ : <%=dt_name.Rows[2][0].ToString() %></td>
  <td colspan=2 class=xl82 style='mso-ignore:colspan'></td>
  <td class=xl87>Điện thoại: 0613.560360</td>
  <td class=xl82></td>
  <td class=xl83></td>
  <td class=xl82></td>
  <td class=xl86></td>
  <td colspan=9 class=xl83 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl84 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=2 height=26 class=xl112 style='height:19.5pt'>A. PHẦN CHI TIẾT</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl49></td>
  <td colspan=2 class=xl115>&nbsp;</td>
  <td class=xl51></td>
  <td colspan=5 class=xl51></td>
  <td colspan=4 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=41 style='mso-height-source:userset;height:30.75pt'>
  <td rowspan=2 height=120 class=xl119 width=31 style='height:90.0pt;
  border-top:none;width:23pt'>STT</td>
  <td rowspan=2 class=xl117 width=195 style='border-top:none;width:146pt'>Họ và tên</td>
  <td rowspan=2 class=xl117 width=77 style='border-top:none;width:58pt'>Mã số</td>
  <td rowspan=2 class=xl118 width=75 style='border-top:none;width:56pt'>Ngày, tháng, năm sinh</td>
  <td rowspan=2 class=xl117 width=26 style='border-top:none;width:20pt'>Nữ (X)</td>
  <td rowspan=2 class=xl117 width=265 style='width:199pt'>Địa chỉ</td>
  <td colspan=2 class=xl117 width=173 style='border-left:none;width:130pt'
  x:str><span style='mso-spacerun:yes'> </span>Đăng ký
  KCB<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl117 width=87 style='width:65pt'>Chức vụ hoặc chức danh nghề</td>
  <td rowspan=2 class=xl117 width=72 style='width:54pt'>Tiền lương, tiền công</td>
  <td colspan=4 class=xl127 style='border-left:none'>Phụ cấp</td>
  <td rowspan=2 class=xl117 width=55 style='width:41pt'>Đóng từ<br>
    tháng năm</td>
  <td colspan=3 class=xl117 width=314 style='border-left:none;width:236pt'>Quyết định hoặc HĐLĐ,HĐLV</td>
  <td rowspan=2 class=xl121 width=71 style='width:53pt'>Ghi chú<br>
    (ghi số CMT)</td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=79 style='mso-height-source:userset;height:59.25pt'>
  <td height=79 class=xl52 width=59 style='height:59.25pt;border-top:none;
  border-left:none;width:44pt'>Tỉnh</td>
  <td class=xl52 width=114 style='border-top:none;border-left:none;width:86pt'>Bệnh
  viện</td>
  <td class=xl53 width=20 style='border-top:none;border-left:none;width:15pt'>Chức
  vụ</td>
  <td class=xl53 width=20 style='border-top:none;border-left:none;width:15pt'>TNVK</td>
  <td class=xl53 width=20 style='border-top:none;border-left:none;width:15pt'>TN
  nghề</td>
  <td class=xl53 width=20 style='border-top:none;border-left:none;width:15pt'>Khác</td>
  <td class=xl52 width=65 style='border-top:none;border-left:none;width:49pt'>Số</td>
  <td class=xl52 width=70 style='border-top:none;border-left:none;width:53pt'>Ngày,tháng,năm</td>
  <td class=xl52 width=179 style='border-top:none;border-left:none;width:134pt'>Loại</td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl54 style='height:23.25pt;border-top:none' x:num>1</td>
  <td class=xl55 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl55 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl55 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl55 style='border-top:none;border-left:none' x:num>7</td>
  <td class=xl55 style='border-top:none;border-left:none' x:num>8</td>
  <td class=xl55 style='border-top:none;border-left:none' x:num>9</td>
  <td class=xl55 style='border-top:none;border-left:none' x:num>10</td>
  <td class=xl55 style='border-top:none;border-left:none' x:num>11</td>
  <td class=xl55 style='border-top:none;border-left:none' x:num>12</td>
  <td class=xl55 style='border-top:none;border-left:none' x:num>13</td>
  <td class=xl55 style='border-top:none;border-left:none' x:num>14</td>
  <td class=xl55 style='border-top:none;border-left:none' x:num>15</td>
  <td class=xl55 style='border-top:none;border-left:none' x:num>16</td>
  <td class=xl55 style='border-top:none;border-left:none' x:num>17</td>
  <td class=xl55 style='border-top:none;border-left:none' x:num>18</td>
  <td class=xl56 style='border-top:none;border-left:none' x:num>19</td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <%
    
     Double dtongthunhap, dtongdctBHXH, dtongdctBHYT, dtongdctBHTN;
    dtongthunhap=0;
    dtongdctBHXH=0;
    dtongdctBHYT=0;
    dtongdctBHTN = 0;
    for(int i=0;i<irow_emp;i++)
    {
        dtongthunhap+=Double.Parse(dt_Emp.Rows[i][8].ToString());
        dtongdctBHXH+=Double.Parse(dt_Emp.Rows[i][14].ToString());
        dtongdctBHYT+=Double.Parse(dt_Emp.Rows[i][15].ToString());
        dtongdctBHTN += Double.Parse(dt_Emp.Rows[i][16].ToString());
  %>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl54 style='height:23.25pt;border-top:none' x:num><%=i+1 %></td>
  <td class=xl98 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][0].ToString()%> </td>
  <td class=xl55 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][1].ToString()%> </td>
  <td class=xl156 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][2].ToString()%> </td>
  <td class=xl55 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][3].ToString()%> </td>
  <td class=xl98 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][4].ToString()%> </td>
  <td class=xl55 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][5].ToString()%> </td>
  <td class=xl55 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][6].ToString()%> </td>
  <td class=xl98 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][7].ToString()%> </td>
  <td class=xl101 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][8].ToString()%></td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][9].ToString()%></td>
  <td class=xl93 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][10].ToString()%></td>
  <td class=xl91 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][11].ToString()%></td>
  <td class=xl92 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][12].ToString()%></td>
  <td class=xl102 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][13].ToString()%></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
  <%} %>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=2 height=31 class=xl113 style='height:23.25pt'>Tổng cộng</td>
  <td class=xl57 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl57 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl57 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl58 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl88 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl58 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num
  ><span style='mso-spacerun:yes'>                 
  </span><%=dtongthunhap %> <span style='mso-spacerun:yes'>   </span></td>
  <td class=xl57 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl57 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl57 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl57 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl57 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl57 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl57 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl57 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl48></td>
  <td class=xl74></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl66 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl72 style='mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td class=xl69></td>
  <td class=xl70></td>
  <td colspan=2 class=xl73 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl72 style='mso-ignore:colspan'></td>
  <td class=xl51></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl65 width=226 style='height:15.75pt;
  width:169pt'>B. PHẦN TỔNG HỢP</td>
  <td colspan=7 class=xl59 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl60 style='mso-ignore:colspan'></td>
  <td class=xl61></td>
  <td class=xl62></td>
  <td colspan=4 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl63></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl65 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl59 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl60 style='mso-ignore:colspan'></td>
  <td class=xl61></td>
  <td class=xl62></td>
  <td colspan=4 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl63></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl64 style='height:20.25pt'></td>
  <td colspan=2 class=xl125 width=272 style='border-right:.5pt solid black;
  width:204pt'>Số phát sinh tăng</td>
  <td colspan=2 class=xl107 style='border-right:.5pt solid black;border-left:
  none'>Bảo hiểm y tế</td>
  <td class=xl146 style='border-left:none'>Bảo hiểm thất nghiệp</td>
  <td colspan=2 class=xl116 width=173 style='border-right:2.0pt double black;
  border-left:none;width:130pt'>Bảo hiểm xã hội</td>
  <td class=xl135 style='border-left:none'>&nbsp;</td>
  <td class=xl136></td>
  <td colspan=4 class=xl64 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl46 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl65 style='height:20.25pt'></td>
  <td colspan=2 class=xl123 width=272 style='border-right:.5pt solid black;
  width:204pt'>1. Số lao ?ộng:</td>
  <td class=xl97 width=75 style='border-top:none;width:56pt'><%=irow_emp %></td>
  <td class=xl95 width=26 style='border-top:none;width:20pt'>&nbsp;</td>
  <td class=xl147 width=265 style='border-top:none;border-left:none;width:199pt'><%=irow_emp %></td>
  <td colspan=2 class=xl130 width=173 style='border-right:2.0pt double black;
  border-left:none;width:130pt'><%=irow_emp %></td>
  <td class=xl135 style='border-left:none'>&nbsp;</td>
  <td class=xl136></td>
  <td colspan=4 class=xl64 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl67 style='height:20.25pt'></td>
  <td colspan=2 class=xl109 style='border-right:.5pt solid black'>2. Quỹ lương</td>
  <td class=xl104 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>                    </span><%=dtongthunhap %> </td>
  <td class=xl96 width=26 style='border-top:none;width:20pt'>&nbsp;</td>
  <td class=xl148 width=265 style='border-top:none;border-left:none;width:199pt'
  x:num><span
  style='mso-spacerun:yes'>                                                                                  
  </span><%=dtongthunhap %> </td>
  <td colspan=2 class=xl153 width=173 style='border-right:2.0pt double black;
  border-left:none;width:130pt' x:num><span
  style='mso-spacerun:yes'>                                                    
  </span><%=dtongthunhap %></td>
  <td class=xl137 width=87 style='border-left:none;width:65pt'>&nbsp;</td>
  <td class=xl138></td>
  <td colspan=4 class=xl46 style='mso-ignore:colspan'></td>
  <td class=xl68></td>
  <td colspan=3 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl67 style='height:20.25pt'></td>
  <td colspan=2 class=xl109 style='border-right:.5pt solid black'>3. Số tiền
  phải đóng</td>
  <td class=xl105 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>                    </span><%=dtongthunhap*4.5/100 %></td>
  <td class=xl96 width=26 style='border-top:none;width:20pt'>&nbsp;</td>
  <td class=xl148 width=265 style='border-top:none;border-left:none;width:199pt'
  x:num><span
  style='mso-spacerun:yes'>                                                                                  
  </span><%=dtongthunhap*2/100 %></td>
  <td colspan=2 class=xl153 width=173 style='border-right:2.0pt double black;
  border-left:none;width:130pt' x:num><span
  style='mso-spacerun:yes'>                                                    
  </span><%=dtongthunhap*22/100 %> </td>
  <td class=xl139 width=87 style='border-left:none;width:65pt'>&nbsp;</td>
  <td class=xl140></td>
  <td colspan=4 class=xl46 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl67 style='height:20.25pt'></td>
  <td colspan=2 class=xl131 style='border-right:.5pt solid black'>Trong đó<font
  class="font6">: Số tiền để lại đơn vị</font></td>
  <td class=xl99 style='border-top:none'>&nbsp;</td>
  <td class=xl95 width=26 style='border-top:none;width:20pt'>&nbsp;</td>
  <td class=xl149 width=265 style='border-top:none;border-left:none;width:199pt'>&nbsp;</td>
  <td colspan=2 class=xl143 width=173 style='border-right:2.0pt double black;
  border-left:none;width:130pt' x:num><span
  style='mso-spacerun:yes'>                                                    
  </span><%=(dtongthunhap*22/100)*2/100 %></td>
  <td class=xl137 width=87 style='border-left:none;width:65pt'>&nbsp;</td>
  <td class=xl138></td>
  <td colspan=4 class=xl46 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl67 style='height:20.25pt'></td>
  <td colspan=2 class=xl133 style='border-right:.5pt solid black'>4. Số
  tiền<span style='mso-spacerun:yes'>  </span>điều chỉnh :</td>
  <td class=xl100 style='border-top:none'>&nbsp;</td>
  <td class=xl94 width=26 style='border-top:none;width:20pt'>&nbsp;</td>
  <td class=xl150 width=265 style='border-top:none;border-left:none;width:199pt'>&nbsp;</td>
  <td colspan=2 class=xl152 width=173 style='border-right:2.0pt double black;
  border-left:none;width:130pt'>&nbsp;</td>
  <td class=xl141 width=87 style='border-left:none;width:65pt'>&nbsp;</td>
  <td class=xl64></td>
  <td colspan=4 class=xl46 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl67 style='height:15.75pt'></td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl78 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl66 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl46 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl67 style='height:15.0pt'></td>
  <td class=xl70 colspan=4 style='mso-ignore:colspan'
  x:str>-
  Mã số được cấp:<span style='mso-spacerun:yes'>                </span>số.
  Từ số:<span
  style='mso-spacerun:yes'>                                         </span>đến
  số</td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl69></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl67 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl67 style='height:14.25pt'></td>
  <td class=xl70 x:str="'-Tổng số tờ khai: ">-Tổng số tờ khai:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl67>…………………..</td>
  <td class=xl70>tờ</td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl69></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl67 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl67 style='height:14.25pt'></td>
  <td class=xl70 colspan=5 style='mso-ignore:colspan'
  x:str="'- Số người được cấp thẻ BHYT :                         người, trong đó cấp ngoại tỉnh:                 thẻ">-
  Soá ngöôøi ñöôïc caáp theû BHYT :<span
  style='mso-spacerun:yes'>                         </span>ngöôøi, trong ñoù
  caáp ngoaïi tænh:<span style='mso-spacerun:yes'>                 </span>theû</td>
  <td colspan=4 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl67 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl67 style='height:14.25pt'></td>
  <td class=xl70 colspan=5 style='mso-ignore:colspan'
  x:str="'- Thôøi haïn söû duïng theû BHYT : Töø ngaøy:                                   ñeán ngaøy:        ">-
  Thời hạn sử dụng thẻ BHYT : Từ ngày:<span
  style='mso-spacerun:yes'>                                   </span>ñeán
  ngaøy:<span style='mso-spacerun:yes'>        </span></td>
  <td colspan=4 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl67 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl67 style='height:16.5pt'></td>
  <td class=xl48></td>
  <td colspan=2 class=xl67>Ngày<span style='mso-spacerun:yes'>   
  </span>tháng<span style='mso-spacerun:yes'>      </span>năm</td>
  <td colspan=3 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl69></td>
  <td colspan=6 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl67>Ngày<span style='mso-spacerun:yes'>       
  </span>tháng<span style='mso-spacerun:yes'>        </span>năm</td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl46 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl66 style='height:17.25pt'></td>
  <td class=xl46>Cán bộ thu</td>
  <td class=xl76 colspan=3 style='mso-ignore:colspan'>Giám đốc Bảo Hiểm Xã
  Hội</td>
  <td class=xl75>Người lập biểu</td>
  <td class=xl46></td>
  <td class=xl71></td>
  <td colspan=6 class=xl46 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=3 class=xl66>Người sử dụng lao động</td>
  <td class=xl66></td>
  <td colspan=2 class=xl46 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl67 style='height:16.5pt'></td>
  <td colspan=4 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl72>(ký ghi rõ họ tên)</td>
  <td class=xl48></td>
  <td class=xl69></td>
  <td class=xl72></td>
  <td colspan=5 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl67>(ký và đóng dấu)</td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl67 style='height:17.25pt'></td>
  <td colspan=6 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl69></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl67></td>
  <td colspan=2 class=xl67></td>
  <td colspan=4 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl67 style='height:17.25pt'></td>
  <td colspan=6 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl69></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl67></td>
  <td colspan=2 class=xl67></td>
  <td colspan=4 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl67 style='height:17.25pt'></td>
  <td colspan=6 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl69></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl67 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=7 class=xl48 style='height:17.25pt;mso-ignore:colspan'></td>
  <td class=xl69></td>
  <td colspan=10 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl63></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl48 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl72>Phạm Thị Ngọc Tuyết</td>
  <td class=xl48></td>
  <td class=xl69></td>
  <td class=xl46></td>
  <td class=xl48></td>
  <td class=xl46></td>
  <td class=xl48></td>
  <td colspan=2 class=xl46 style='mso-ignore:colspan'></td>
  <td class=xl48></td>
  <td colspan=3 class=xl66>LEE YOUNG JIN</td>
  <td class=xl67></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=31 style='width:23pt'></td>
  <td width=195 style='width:146pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=265 style='width:199pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=179 style='width:134pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=105 style='width:79pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
