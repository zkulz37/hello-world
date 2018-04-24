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
    
    string p_times,p_rpt_month;
     
    p_times       = Request["l_times"].ToString();
    p_rpt_month  = Request["l_rpt_month"].ToString();
   string SQL
	= "SELECT A.FULL_NAME  c0  " +
        ",A.SO_BHXH c1  " +
        ",DECODE(LENGTH(A.BIRTH_DT),4,A.BIRTH_DT,TO_CHAR(TO_DATE(A.BIRTH_DT,'YYYYMMDD'),'DD/MM/YYYY')) AS NGAYSINH2   " +
        ",DECODE(A.SEX,'F','X','') AS SEXc3  " +
        ",A.SO_CMT c4  " +
        ",to_char(to_date(A.NGAY_CAP,'yyyymmdd'),'dd/mm/yyyy') c5" +
        ",(SELECT CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0014' AND V.CODE=A.TINH_CAP) AS tinhcap8  " +
        ",(SELECT CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0015' AND V.CODE=A.DAN_TOC) AS dantoc8  " +
        ",(SELECT CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0021' AND V.CODE=A.NGUYEN_QUAN) AS nguyenquan8  " +
        ",A.ADDRESS c6  " +
        ",(SELECT char_1 FROM VHR_HR_CODE V WHERE V.ID='HR0012' AND V.CODE=A.HEALTH_PLACE)  AS TINH7  " +
        ",(SELECT CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0012' AND V.CODE=A.HEALTH_PLACE) AS BENHVIEN8  " +
        ",(SELECT char_1 FROM VHR_HR_CODE V WHERE V.ID='HR0012' AND V.CODE=A.chuc_danh) AS CHUCVUc9  " +
        ",nvl(A.LUONG_MOI,0) c10  " +
        ",'' AS CHUCVUc11  " +
        ",'' AS TNVKc12  " +
        ",'' AS TNNc13  " +
        ",'' AS KHUVUCc14  " +
        ",decode(nvl(a.tn_yn,'N'),'Y','X','') c15  " +
        ",to_char(to_date(A.TU_THANG,'yyyymm'),'mm/yyyy') c16  " +
        ",TO_CHAR(TO_DATE(A.NGAY_KY_HD,'YYYYMMDD'),'dd.mm.yy') AS C17  " +
        ",TO_CHAR(TO_DATE(A.NGAY_KY_HD,'YYYYMMDD'),'dd/mm/yy') AS C18  " +
        ",12 AS C19  " +
        ",A.EMP_ID AS C20  " +
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
<link rel=File-List href="rpt_02a_tbh_ssa_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_02a_tbh_ssa_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_02a_tbh_ssa_files/oledata.mso">
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
  <o:Created>2011-11-07T07:16:28Z</o:Created>
  <o:LastSaved>2011-11-07T07:33:55Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P";
	margin:.25in 0in .2in 0in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
.font7
	{color:windowtext;
	font-size:10.0pt;
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
.style271
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style388
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
	mso-style-name:Normal_Sheet1;}
.style389
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
	mso-style-name:Normal_Sheet4;}
.style403
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
	font-family:Arial, sans-serif;
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
.xl1398
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl1399
	{mso-style-parent:style271;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl1400
	{mso-style-parent:style271;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl1401
	{mso-style-parent:style271;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl1402
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;}
.xl1403
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl1404
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl1405
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl1406
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	background:white;
	mso-pattern:auto none;}
.xl1407
	{mso-style-parent:style271;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center-across;
	vertical-align:middle;}
.xl1408
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;}
.xl1409
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl1410
	{mso-style-parent:style271;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;}
.xl1411
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:top;}
.xl1412
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl1413
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl1414
	{mso-style-parent:style271;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl1415
	{mso-style-parent:style271;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl1416
	{mso-style-parent:style271;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl1417
	{mso-style-parent:style271;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl1418
	{mso-style-parent:style271;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Scientific;}
.xl1419
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl1420
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl1421
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl1422
	{mso-style-parent:style271;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl1423
	{mso-style-parent:style271;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000000_\)\;_\(* \\\(\#\,\#\#0\.000000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:normal;}
.xl1424
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl1425
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;}
.xl1426
	{mso-style-parent:style271;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl1427
	{mso-style-parent:style271;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl1428
	{mso-style-parent:style271;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl1429
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl1430
	{mso-style-parent:style271;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;}
.xl1431
	{mso-style-parent:style271;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;}
.xl1432
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;}
.xl1433
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl1434
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl1435
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl1436
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl1437
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl1438
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl1439
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl1440
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl1441
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl1442
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1443
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl1444
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl1445
	{mso-style-parent:style0;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl1446
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1447
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl1448
	{mso-style-parent:style271;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"000\\ 000\\ 000";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl1449
	{mso-style-parent:style271;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl1450
	{mso-style-parent:style271;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl1451
	{mso-style-parent:style403;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl1452
	{mso-style-parent:style271;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl1453
	{mso-style-parent:style271;
	color:red;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl1454
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl1455
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl1456
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl1457
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl1458
	{mso-style-parent:style0;
	font-size:13.0pt;
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
.xl1459
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1460
	{mso-style-parent:style389;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1461
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl1462
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl1463
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1464
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl1465
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1466
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
.xl1467
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1468
	{mso-style-parent:style271;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1469
	{mso-style-parent:style403;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1470
	{mso-style-parent:style271;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1471
	{mso-style-parent:style271;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1472
	{mso-style-parent:style271;
	color:black;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1473
	{mso-style-parent:style271;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1474
	{mso-style-parent:style271;
	color:red;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1475
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1476
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1477
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1478
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1479
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl1480
	{mso-style-parent:style388;
	color:black;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1481
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1482
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1483
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl1484
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1485
	{mso-style-parent:style0;
	color:black;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1486
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1487
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl1488
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1489
	{mso-style-parent:style271;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border:.5pt solid windowtext;}
.xl1490
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl1491
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"000\\ 000\\ 000";
	text-align:center;
	border:.5pt solid windowtext;}
.xl1492
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl1493
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl1494
	{mso-style-parent:style271;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;
	border:.5pt solid windowtext;}
.xl1495
	{mso-style-parent:style271;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border:.5pt solid windowtext;}
.xl1496
	{mso-style-parent:style271;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border:.5pt solid windowtext;}
.xl1497
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl1498
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl1499
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl1500
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl1501
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl1502
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl1503
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl1504
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl1505
	{mso-style-parent:style271;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl1506
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"000\\ 000\\ 000";
	text-align:center;}
.xl1507
	{mso-style-parent:style271;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mm\/yy";
	text-align:center;}
.xl1508
	{mso-style-parent:style271;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;}
.xl1509
	{mso-style-parent:style271;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;}
.xl1510
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl1511
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl1512
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	background:white;
	mso-pattern:auto none;}
.xl1513
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl1514
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl1515
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;}
.xl1516
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl1517
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl1518
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl1519
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;}
.xl1520
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl1521
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl1522
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl1523
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;}
.xl1524
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl1525
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;}
.xl1526
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmm\\-yy";
	vertical-align:middle;}
.xl1527
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;}
.xl1528
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl1529
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl1530
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl1531
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl1532
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl1533
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl1534
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl1535
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl1536
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl1537
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";}
.xl1538
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl1539
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl1540
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl1541
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl1542
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl1543
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl1544
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl1545
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl1546
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl1547
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl1548
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl1549
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
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl1550
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
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl1551
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
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl1552
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
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl1553
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
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl1554
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
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl1555
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
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl1556
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
.xl1557
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
.xl1558
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
.xl1559
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl1560
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl1561
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl1562
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
.xl1563
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
.xl1564
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
.xl1565
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
.xl1566
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
.xl1567
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
.xl1568
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl1569
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl1570
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl1571
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl1572
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl1573
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl1574
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl1575
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl1576
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl1577
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl1578
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl1579
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl1580
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl1581
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl1582
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl1583
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl1584
	{mso-style-parent:style271;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl1585
	{mso-style-parent:style271;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>2A-L2</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>53</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:TopRowVisible>54</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:ColBreaks>
      <x:ColBreak>
       <x:Column>24</x:Column>
      </x:ColBreak>
      <x:ColBreak>
       <x:Column>25</x:Column>
      </x:ColBreak>
     </x:ColBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>19035</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>

</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl1404>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2792 style='border-collapse:
 collapse;table-layout:fixed;width:2099pt'>
 <col class=xl1404 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl1404 width=202 style='mso-width-source:userset;mso-width-alt:
 7387;width:152pt'>
 <col class=xl1546 width=114 style='mso-width-source:userset;mso-width-alt:
 4169;width:86pt'>
 <col class=xl1404 width=91 style='mso-width-source:userset;mso-width-alt:3328;
 width:68pt'>
 <col class=xl1404 width=46 style='mso-width-source:userset;mso-width-alt:1682;
 width:35pt'>
 <col class=xl1404 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl1404 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl1404 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:4278'>
 <col class=xl1404 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:2230'>
 <col class=xl1404 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:4278'>
 <col class=xl1404 width=349 style='mso-width-source:userset;mso-width-alt:
 12763;width:262pt'>
 <col class=xl1404 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl1404 width=118 style='mso-width-source:userset;mso-width-alt:
 4315;width:89pt'>
 <col class=xl1404 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl1404 width=95 style='mso-width-source:userset;mso-width-alt:3474;
 width:71pt'>
 <col class=xl1404 width=37 style='mso-width-source:userset;mso-width-alt:1353;
 width:28pt'>
 <col class=xl1404 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl1404 width=43 style='mso-width-source:userset;mso-width-alt:1572;
 width:32pt'>
 <col class=xl1404 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col class=xl1412 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <col class=xl1404 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl1404 width=130 style='mso-width-source:userset;mso-width-alt:
 4754;width:98pt'>
 <col class=xl1404 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl1404 width=50 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col class=xl1404 width=64 style='width:48pt'>
 <col class=xl1404 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl1404 width=100 style='mso-width-source:userset;mso-width-alt:
 3657;width:75pt'>
 <col class=xl1404 width=105 style='mso-width-source:userset;mso-width-alt:
 3840;width:79pt'>
 <col class=xl1404 width=104 style='mso-width-source:userset;mso-width-alt:
 3803;width:78pt'>
 <col class=xl1404 width=100 style='mso-width-source:userset;mso-width-alt:
 3657;width:75pt'>
 <col class=xl1404 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl1404 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl1404 width=74 span=2 style='mso-width-source:userset;mso-width-alt:
 2706;width:56pt'>
 <col class=xl1404 width=64 style='width:48pt'>
 <tr height=30 style='height:22.5pt'>
  <td height=30 class=xl1398 width=72 style='height:22.5pt;width:54pt'
  x:str="Tên đơn vị: ">Tên đơn vị:<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl1581 width=316 style='width:238pt'>CTY TNHH SUNG SHIN A
  (VN)</td>
  <td colspan=13 class=xl1584 width=1010 style='width:759pt'>DANH SÁCH LAO ĐỘNG
  THAM GIA BHXH, BHYT,BHTN</td>
  <td width=45 style='width:34pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
   id="_x0000_t202" coordsize="21600,21600" o:spt="202" path="m,l,21600r21600,l21600,xe">
   <v:stroke joinstyle="miter"/>
   <v:path gradientshapeok="t" o:connecttype="rect"/>
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t202" style='position:absolute;
   margin-left:20.25pt;margin-top:18pt;width:193.5pt;height:39pt;z-index:1;
   mso-wrap-style:tight' filled="f" fillcolor="white [9]" stroked="f"
   strokecolor="windowText [64]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font7">Mẫu số: 02a-TBH<br>
        </font><font class="font14">Ban hành kèm theo CV số 1615/BHXH -<br>
        CSXH ngày 02/06/2009 của BHXH VN</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:27px;margin-top:24px;width:258px;
  height:52px'><img width=258 height=52 src="rpt_02a_tbh_ssa_files/image001.gif"
  alt="Text Box: Mẫu số: 02a-TBH&#10;Ban hành kèm theo CV số 1615/BHXH -&#10;CSXH ngày 02/06/2009 của BHXH VN"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl1399 width=45 style='height:22.5pt;width:34pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl1399 width=43 style='width:32pt'></td>
  <td class=xl1399 width=33 style='width:25pt'></td>
  <td class=xl1400 width=39 style='width:29pt'></td>
  <td class=xl1399 width=51 style='width:38pt'></td>
  <td class=xl1399 width=130 style='width:98pt'></td>
  <td class=xl1399 width=68 style='width:51pt'></td>
  <td class=xl1399 width=50 style='width:38pt'></td>
  <td class=xl1401 width=64 style='width:48pt'></td>
  <td class=xl1402 width=90 style='width:68pt'></td>
  <td class=xl1402 width=100 style='width:75pt'></td>
  <td class=xl1402 width=105 style='width:79pt'></td>
  <td class=xl1403 width=104 style='width:78pt'></td>
  <td class=xl1403 width=100 style='width:75pt'></td>
  <td class=xl1403 width=77 style='width:58pt'></td>
  <td class=xl1403 width=83 style='width:62pt'></td>
  <td class=xl1403 width=74 style='width:56pt'></td>
  <td class=xl1403 width=74 style='width:56pt'></td>
  <td class=xl1403 width=64 style='width:48pt'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl1398 style='height:18.75pt' x:str="Mã  đơn vị: ">Mã<span
  style='mso-spacerun:yes'>  </span>đơn vị:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl1405>YN 1258 Z</td>
  <td class=xl1406>&nbsp;</td>
  <td class=xl1407></td>
  <td class=xl1408></td>
  <td class=xl1404></td>
  <td class=xl1409>Số:<span style='mso-spacerun:yes'>      </span>01</td>
  <td colspan=3 class=xl1409 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl1409
  x:fmla="=&quot;Tháng     &quot;&amp;MONTH(Z3)&amp;&quot;     năm     &quot;&amp;YEAR(Z3)">Tháng<span
  style='mso-spacerun:yes'>     </span>10<span style='mso-spacerun:yes'>    
  </span>năm<span style='mso-spacerun:yes'>     </span>2011</td>
  <td class=xl1409></td>
  <td class=xl1404></td>
  <td class=xl1410></td>
  <td class=xl1411></td>
  <td colspan=2 class=xl1408 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=5 class=xl1401 style='mso-ignore:colspan'></td>
  <td class=xl1413>Tháng B.Cáo</td>
  <td class=xl1413 style='border-left:none'>Trần 2009</td>
  <td class=xl1413 style='border-left:none'>Trần 2010</td>
  <td class=xl1413 style='border-left:none'>Trần 2011</td>
  <td class=xl1413 style='border-left:none'>Tối thiểu chung</td>
  <td colspan=5 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl1414 style='height:22.5pt'>Địa chỉ:</td>
  <td colspan=3 class=xl1585 width=407 style='width:306pt'
  x:str="Đường NA1,-KCN Mỹ Phước II-Bến Cát- Bình Dương"><span
  style='mso-spacerun:yes'> </span>Đường NA1,-KCN Mỹ Phước II-Bến Cát- Bình
  Dương<span style='mso-spacerun:yes'> </span></td>
  <td class=xl1415></td>
  <td colspan=5 class=xl1416 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl1417 style='mso-ignore:colspan'></td>
  <td class=xl1418></td>
  <td colspan=3 class=xl1419 style='mso-ignore:colspan'></td>
  <td class=xl1420></td>
  <td colspan=5 class=xl1419 style='mso-ignore:colspan'></td>
  <td class=xl1421 style='border-top:none' x:num x:fmla="=DATE(<%=int.Parse(p_rpt_month.Substring(0,4))%>,<%=int.Parse(p_rpt_month.Substring(4,2))%>,<%=1%>)"></td>
  <td class=xl1422 style='border-top:none;border-left:none' x:num="13000000"><span
  style='mso-spacerun:yes'>            </span>13,000,000 </td>
  <td class=xl1422 style='border-top:none;border-left:none' x:num="14600000"><span
  style='mso-spacerun:yes'>              </span>14,600,000 </td>
  <td class=xl1422 style='border-top:none;border-left:none' x:num="16600000"><span
  style='mso-spacerun:yes'>              </span>16,600,000 </td>
  <td class=xl1422 style='border-top:none;border-left:none' x:num="830000"><span
  style='mso-spacerun:yes'>                 </span>830,000 </td>
  <td colspan=5 class=xl1419 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl1414 style='height:14.25pt'>Điện thọai:</td>
  <td class=xl1423 width=202 style='width:152pt' x:str="'06503.565798"><span
  style='mso-spacerun:yes'> </span>06503.565798<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl1424>Fax :06503.559862</td>
  <td colspan=2 class=xl1415 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl1416 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl1417 style='mso-ignore:colspan'></td>
  <td class=xl1418></td>
  <td colspan=3 class=xl1419 style='mso-ignore:colspan'></td>
  <td class=xl1420></td>
  <td colspan=5 class=xl1419 style='mso-ignore:colspan'></td>
  <td class=xl1425></td>
  <td colspan=3 class=xl1426 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl1419 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl1427 style='height:9.0pt'></td>
  <td class=xl1428></td>
  <td class=xl1429>&nbsp;</td>
  <td class=xl1430></td>
  <td class=xl1431></td>
  <td colspan=5 class=xl1432 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl1403 style='mso-ignore:colspan'></td>
  <td class=xl1428></td>
  <td colspan=2 class=xl1403 style='mso-ignore:colspan'></td>
  <td class=xl1433></td>
  <td colspan=15 class=xl1403 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl1398 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td rowspan=3 height=89 class=xl1434 width=72 style='height:66.75pt;
  width:54pt'>Số <br>
    TT</td>
  <td rowspan=3 class=xl1565 width=202 style='border-bottom:.5pt solid black;
  width:152pt'>Họ và tên</td>
  <td rowspan=3 class=xl1577 width=114 style='width:86pt'>Số sổ <br>
    BHXH</td>
  <td rowspan=3 class=xl1578 width=91 style='border-bottom:.5pt solid black;
  width:68pt'>Ngày, tháng, <br>
    năm sinh</td>
  <td rowspan=3 class=xl1565 width=46 style='border-bottom:.5pt solid black;
  width:35pt'>Nữ <br>
    (X)</td>
  <td rowspan=3 class=xl1435 width=88 style='border-bottom:.5pt solid black;
  width:66pt'>Số chứng minh thư</td>
  <td class=xl1435 width=94 style='border-left:none;width:71pt'>&nbsp;</td>
  <td class=xl1435 width=0 style='border-left:none'>&nbsp;</td>
  <td class=xl1435 width=0 style='border-left:none'>&nbsp;</td>
  <td class=xl1435 width=0 style='border-left:none'>&nbsp;</td>
  <td rowspan=3 class=xl1434 width=349 style='width:262pt'>Địa chỉ</td>
  <td colspan=2 rowspan=2 class=xl1568 width=163 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:123pt'>Nơi đăng ký KCB ban đầu</td>
  <td rowspan=3 class=xl1565 width=47 style='border-bottom:.5pt solid black;
  width:35pt'>Chức vụ hoặc chức danh nghề</td>
  <td rowspan=3 class=xl1565 width=95 style='border-bottom:.5pt solid black;
  width:71pt'>Tiền lương, tiền công</td>
  <td class=xl1436 align=center width=37 style='border-left:none;width:28pt'>Phụ
  cấp</td>
  <td class=xl1436 width=45 style='border-left:none;width:34pt'>&nbsp;</td>
  <td class=xl1436 width=43 style='border-left:none;width:32pt'>&nbsp;</td>
  <td class=xl1436 width=33 style='border-left:none;width:25pt'>&nbsp;</td>
  <td rowspan=3 class=xl1565 width=39 style='border-bottom:.5pt solid black;
  width:29pt'>Đóng BH TN<br>
    (X)</td>
  <td rowspan=3 class=xl1565 width=51 style='border-bottom:.5pt solid black;
  width:38pt'>Đóng từ tháng năm</td>
  <td colspan=3 class=xl1568 width=248 style='border-right:.5pt solid black;
  border-left:none;width:187pt'>Quyết định hoặc HĐLĐ, HĐLV.</td>
  <td rowspan=3 class=xl1565 width=64 style='border-bottom:.5pt solid black;
  width:48pt'>Ghi chú</td>
  <td colspan=3 rowspan=2 class=xl1568 width=295 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:222pt'>SỐ PHÁT SINH</td>
  <td colspan=4 class=xl1574>SỐ PHẢI ĐÓNG BỔ SUNG</td>
  <td colspan=3 class=xl1437 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl1398 height=17 style='height:12.75pt'>
  <td height=17 class=xl1439 width=94 style='height:12.75pt;border-left:none;
  width:71pt'>Ngày cấp</td>
  <td class=xl1439 width=0 style='border-left:none'>Nơi cấp</td>
  <td class=xl1439 width=0 style='border-left:none'>Dân tộc</td>
  <td class=xl1439 width=0 style='border-left:none'>Nguyên quán</td>
  <td rowspan=2 class=xl1565 width=37 style='border-bottom:.5pt solid black;
  border-top:none;width:28pt'>Chức vụ</td>
  <td rowspan=2 class=xl1565 width=45 style='border-bottom:.5pt solid black;
  border-top:none;width:34pt'>Thâm niên VK</td>
  <td rowspan=2 class=xl1565 width=43 style='border-bottom:.5pt solid black;
  border-top:none;width:32pt'>Thâm niên nghề</td>
  <td rowspan=2 class=xl1565 width=33 style='border-bottom:.5pt solid black;
  border-top:none;width:25pt'>Khu vực</td>
  <td rowspan=2 class=xl1565 width=130 style='border-bottom:.5pt solid black;
  width:98pt'>Số</td>
  <td rowspan=2 class=xl1565 width=68 style='border-bottom:.5pt solid black;
  width:51pt'>Ngày, tháng, năm</td>
  <td rowspan=2 class=xl1565 width=50 style='border-bottom:.5pt solid black;
  width:38pt'>Loại</td>
  <td rowspan=2 class=xl1565 width=104 style='border-bottom:.5pt solid black;
  border-top:none;width:78pt'>Tháng</td>
  <td rowspan=2 class=xl1565 width=100 style='border-bottom:.5pt solid black;
  border-top:none;width:75pt'>BHXH</td>
  <td rowspan=2 class=xl1565 width=77 style='border-bottom:.5pt solid black;
  border-top:none;width:58pt'>BHYT</td>
  <td rowspan=2 class=xl1565 width=83 style='border-bottom:.5pt solid black;
  border-top:none;width:62pt'>BHTN</td>
  <td colspan=3 class=xl1437 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl1398 height=43 style='mso-height-source:userset;height:32.25pt'>
  <td height=43 class=xl1440 width=94 style='height:32.25pt;border-left:none;
  width:71pt'>&nbsp;</td>
  <td class=xl1440 width=0 style='border-left:none'>&nbsp;</td>
  <td class=xl1440 width=0 style='border-left:none'>&nbsp;</td>
  <td class=xl1440 width=0 style='border-left:none'>&nbsp;</td>
  <td class=xl1434 width=45 style='border-top:none;border-left:none;width:34pt'>Tỉnh</td>
  <td class=xl1434 width=118 style='border-top:none;border-left:none;
  width:89pt'>Bệnh viện</td>
  <td class=xl1434 width=90 style='border-top:none;border-left:none;width:68pt'>BHXH</td>
  <td class=xl1434 width=100 style='border-top:none;border-left:none;
  width:75pt'>BHYT</td>
  <td class=xl1434 width=105 style='border-top:none;border-left:none;
  width:79pt'>BHTN</td>
  <td colspan=3 class=xl1437 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl1441 style='height:12.75pt;border-top:none' x:num>1</td>
  <td class=xl1441 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl1442 style='border-top:none;border-left:none'>3</td>
  <td class=xl1443 style='border-top:none;border-left:none'>4</td>
  <td class=xl1443 style='border-top:none;border-left:none'>5</td>
  <td class=xl1443 style='border-top:none;border-left:none'>6</td>
  <td class=xl1443 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl1443 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl1443 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl1443 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl1443 style='border-top:none;border-left:none'>7</td>
  <td class=xl1443 style='border-top:none;border-left:none'>8</td>
  <td class=xl1443 style='border-top:none;border-left:none'>9</td>
  <td class=xl1443 style='border-top:none;border-left:none'>10</td>
  <td class=xl1443 style='border-top:none;border-left:none'>11</td>
  <td class=xl1443 style='border-top:none;border-left:none'>12</td>
  <td class=xl1443 style='border-top:none;border-left:none'>13</td>
  <td class=xl1443 style='border-top:none;border-left:none'>14</td>
  <td class=xl1443 style='border-top:none;border-left:none'>15</td>
  <td class=xl1443 style='border-top:none;border-left:none'>16</td>
  <td class=xl1443 style='border-top:none;border-left:none'>17</td>
  <td class=xl1443 style='border-top:none;border-left:none'>18</td>
  <td class=xl1443 style='border-top:none;border-left:none'>19</td>
  <td class=xl1443 style='border-top:none;border-left:none'>20</td>
  <td class=xl1443 style='border-top:none;border-left:none'>21</td>
  <td class=xl1441 style='border-top:none;border-left:none'>A</td>
  <td class=xl1441 style='border-top:none;border-left:none'>B</td>
  <td class=xl1441 style='border-top:none;border-left:none'>C</td>
  <td class=xl1441 style='border-top:none;border-left:none'>D</td>
  <td class=xl1441 style='border-top:none;border-left:none'>E</td>
  <td class=xl1441 style='border-top:none;border-left:none'>F</td>
  <td class=xl1441 style='border-top:none;border-left:none'>G</td>
  <td colspan=3 class=xl1420 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl1403 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl1444 style='height:21.0pt'>&nbsp;</td>
  <td class=xl1445 style='border-left:none'>MỨC LƯƠNG</td>
  <td class=xl1446 style='border-left:none'>&nbsp;</td>
  <td class=xl1447 style='border-left:none'>&nbsp;</td>
  <td class=xl1444 style='border-left:none'>&nbsp;</td>
  <td class=xl1448 style='border-left:none'>&nbsp;</td>
  <td class=xl1448 style='border-left:none'>&nbsp;</td>
  <td class=xl1448 style='border-left:none'>&nbsp;</td>
  <td class=xl1448 style='border-left:none'>&nbsp;</td>
  <td class=xl1448 style='border-left:none'>&nbsp;</td>
  <td class=xl1444 style='border-left:none'>&nbsp;</td>
  <td class=xl1444 style='border-left:none'>&nbsp;</td>
  <td class=xl1444 style='border-left:none'>&nbsp;</td>
  <td class=xl1444 style='border-left:none'>&nbsp;</td>
  <td class=xl1449 style='border-left:none'>&nbsp;</td>
  <td class=xl1450 style='border-left:none'>&nbsp;</td>
  <td class=xl1451 style='border-left:none'>&nbsp;</td>
  <td class=xl1451 style='border-left:none'>&nbsp;</td>
  <td class=xl1450 style='border-left:none'>&nbsp;</td>
  <td class=xl1452 style='border-left:none'>&nbsp;</td>
  <td class=xl1453 style='border-left:none'>&nbsp;</td>
  <td class=xl1453 style='border-left:none'>&nbsp;</td>
  <td class=xl1453 style='border-left:none'>&nbsp;</td>
  <td class=xl1453 style='border-left:none'>&nbsp;</td>
  <td class=xl1454 style='border-left:none'>&nbsp;</td>
  <td class=xl1455 style='border-left:none'>&nbsp;</td>
  <td class=xl1455 style='border-left:none'>&nbsp;</td>
  <td class=xl1455 style='border-left:none'>&nbsp;</td>
  <td class=xl1456 style='border-left:none'>&nbsp;</td>
  <td class=xl1455 style='border-left:none'>&nbsp;</td>
  <td class=xl1455 style='border-left:none'>&nbsp;</td>
  <td class=xl1455 style='border-left:none'>&nbsp;</td>
  <td class=xl1457 style='border-left:none'>&nbsp;</td>
  <td class=xl1457 style='border-left:none'>&nbsp;</td>
  <td class=xl1403></td>
 </tr>
 <%
    int st_row,et_row,seq_row;
    st_row=11;
    seq_row=11;
    et_row=st_row+irow_emp-1;
    for(int i=0;i<irow_emp;i++)
    {
        
       %>
 <tr class=xl1479 height=53 style='mso-height-source:userset;height:39.75pt'>
  <td height=53 class=xl1458 style='height:39.75pt;border-top:none' x:num><%=i+1 %></td>
  <td class=xl1459 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][0].ToString()%></td>
  <td class=xl1460 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][1].ToString()%></td>
  <td class=xl1463 style='border-top:none;border-left:none' ><%=dt_Emp.Rows[i][2].ToString()%></td>
  <td class=xl1464 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][3].ToString()%></td>
  <td class=xl1465 align=right style='border-top:none;border-left:none' ><%=dt_Emp.Rows[i][4].ToString()%></td>
  <td class=xl1458 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][5].ToString()%></td>
  <td class=xl1458 style='border-top:none;border-left:none;mso-text-control:shrinktofit;'><%=dt_Emp.Rows[i][6].ToString()%></td>
  <td class=xl1458 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][7].ToString()%></td>
  <td class=xl1458 style='border-top:none;border-left:none;white-space:nowrap;mso-text-control:shrinktofit'><%=dt_Emp.Rows[i][8].ToString()%></td>
  <td class=xl1459 style='border-top:none;border-left:none;white-space:nowrap;mso-text-control:shrinktofit'><%=dt_Emp.Rows[i][9].ToString()%></td>
  <td class=xl1466 style='border-top:none;border-left:none;white-space:nowrap;mso-text-control:shrinktofit'><%=dt_Emp.Rows[i][10].ToString()%></td>
  <td class=xl1466 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][11].ToString()%></td>
  <td class=xl1466 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][12].ToString()%></td>
  <td class=xl1467 align=right style='border-top:none;border-left:none'
  x:num><%=dt_Emp.Rows[i][13].ToString()%></td>
  <td class=xl1468 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][14].ToString()%></td>
  <td class=xl1469 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][15].ToString()%></td>
  <td class=xl1469 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][16].ToString()%></td>
  <td class=xl1470 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][17].ToString()%></td>
  <td class=xl1471 style='border-top:none;border-left:none' x:str><%=dt_Emp.Rows[i][18].ToString()%></td>
  <td class=xl1472 style='border-top:none;border-left:none' x:num x:fmla="=DATE(<%=int.Parse(dt_Emp.Rows[i][19].ToString().Substring(3,4).ToString())%>,<%=int.Parse(dt_Emp.Rows[i][19].ToString().Substring(0,2).ToString())%>,<%=1%>)"></td>
  <td class=xl1473 style='border-top:none;border-left:none'>Số HĐ ,ngày <%=dt_Emp.Rows[i][20].ToString()%></td>
  <td class=xl1474 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][21].ToString()%></td>
  <td class=xl1473 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][22].ToString()%></td>
  <td class=xl1475 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl1476 align=right style='border-top:none;border-left:none'
  x:num x:fmla="=IF(O<%=seq_row %>&gt;$AA$3,$AA$3,O<%=seq_row %>)">2,145,000</td>
  <td class=xl1476 align=right style='border-top:none;border-left:none'
  x:num x:fmla="=Z<%=seq_row %>">2,145,000</td>
  <td class=xl1476 align=right style='border-top:none;border-left:none'
  x:num x:fmla="=IF(T<%=seq_row %>=&quot;X&quot;,Z<%=seq_row %>,0)">2,145,000</td>
  <td class=xl1477 align=right style='border-top:none;border-left:none' x:num
  x:fmla="=IF(MONTH(AH<%=seq_row %>)&lt;MONTH(AG<%=seq_row %>),(((MONTH(AH<%=seq_row %>)+12)-MONTH(AG<%=seq_row %>))+((YEAR(AH<%=seq_row %>)-1)-YEAR(AG<%=seq_row %>))*12),IF(YEAR(AH<%=seq_row %>)=YEAR(AG<%=seq_row %>),(MONTH(AH<%=seq_row %>)-MONTH(AG<%=seq_row %>)),(((YEAR(AH<%=seq_row %>)-YEAR(AG<%=seq_row %>))*12)+(MONTH(AH<%=seq_row %>)-MONTH(AG<%=seq_row %>)))))">0</td>
  <td class=xl1476 align=right style='border-top:none;border-left:none' x:num
  x:fmla="=Z<%=seq_row %>*22%*AC<%=seq_row %>">0</td>
  <td class=xl1476 align=right style='border-top:none;border-left:none' x:num
  x:fmla="=AA<%=seq_row %>*AC<%=seq_row %>*4.5%">0</td>
  <td class=xl1476 align=right style='border-top:none;border-left:none' x:num
  x:fmla="=IF(YEAR(U<%=seq_row %>)=2008,AB<%=seq_row %>*2%*(AC<%=seq_row %>-(12-MONTH(U<%=seq_row %>)+1)),AB<%=seq_row %>*2%*AC<%=seq_row %>)">0</td>
  <td class=xl1478 align=right style='border-top:none;border-left:none'
  x:num x:fmla="=IF(U<%=seq_row %>=&quot;&quot;,$Z$3,U<%=seq_row %>)">01/10/2011</td>
  <td class=xl1478 align=right style='border-top:none;border-left:none'
  x:num x:fmla="=$Z$3">01/10/2011</td>
  <td class=xl1479><%=dt_Emp.Rows[i][23].ToString()%></td>
 </tr>
 
<%  seq_row++;
} %>
 
 
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl1486 style='height:21.0pt'>&nbsp;</td>
  <td class=xl1487 style='border-left:none'>&nbsp;</td>
  <td class=xl1488 style='border-left:none'>&nbsp;</td>
  <td class=xl1489 style='border-left:none'>&nbsp;</td>
  <td class=xl1490 style='border-left:none'>&nbsp;</td>
  <td class=xl1491 style='border-left:none'>&nbsp;</td>
  <td class=xl1491 style='border-left:none'>&nbsp;</td>
  <td class=xl1491 style='border-left:none'>&nbsp;</td>
  <td class=xl1491 style='border-left:none'>&nbsp;</td>
  <td class=xl1491 style='border-left:none'>&nbsp;</td>
  <td class=xl1490 style='border-left:none'>&nbsp;</td>
  <td class=xl1490 style='border-left:none'>&nbsp;</td>
  <td class=xl1490 style='border-left:none'>&nbsp;</td>
  <td class=xl1492 style='border-left:none'>&nbsp;</td>
  <td class=xl1422 style='border-left:none'>&nbsp;</td>
  <td class=xl1493 style='border-left:none'>&nbsp;</td>
  <td class=xl1493 style='border-left:none'>&nbsp;</td>
  <td class=xl1493 style='border-left:none'>&nbsp;</td>
  <td class=xl1493 style='border-left:none'>&nbsp;</td>
  <td class=xl1490 style='border-left:none'>&nbsp;</td>
  <td class=xl1494 style='border-left:none'>&nbsp;</td>
  <td class=xl1495 style='border-left:none'>&nbsp;</td>
  <td class=xl1496 style='border-left:none'>&nbsp;</td>
  <td class=xl1495 style='border-left:none'>&nbsp;</td>
  <td class=xl1493 style='border-left:none'>&nbsp;</td>
  <td class=xl1497>&nbsp;</td>
  <td class=xl1498 style='border-left:none'>&nbsp;</td>
  <td class=xl1498 style='border-left:none'>&nbsp;</td>
  <td class=xl1498 style='border-left:none'>&nbsp;</td>
  <td class=xl1498 style='border-left:none'>&nbsp;</td>
  <td class=xl1499 style='border-left:none'>&nbsp;</td>
  <td class=xl1498>&nbsp;</td>
  <td class=xl1500>&nbsp;</td>
  <td class=xl1501>&nbsp;</td>
  <td class=xl1404></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl1502 style='height:21.0pt'>&nbsp;</td>
  <td class=xl1503></td>
  <td class=xl1504>&nbsp;</td>
  <td class=xl1505></td>
  <td class=xl1412></td>
  <td colspan=5 class=xl1506 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl1412 style='mso-ignore:colspan'></td>
  <td class=xl1426></td>
  <td colspan=4 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td class=xl1507></td>
  <td class=xl1508></td>
  <td class=xl1509></td>
  <td class=xl1508></td>
  <td class=xl1404></td>
  <td class=xl1510 align=right x:num x:fmla="=SUM(Z<%=st_row %>:Z<%=et_row %>)">173,745,000</td>
  <td class=xl1510 align=right x:num x:fmla="=SUM(AA<%=st_row %>:AA<%=et_row %>)">173,745,000</td>
  <td class=xl1510 align=right x:num x:fmla="=SUM(AB<%=st_row %>:AB<%=et_row %>)">173,745,000</td>
  <td class=xl1511>&nbsp;</td>
  <td class=xl1511 align=right x:num x:fmla="=SUM(AD<%=st_row %>:AD<%=et_row %>)">0</td>
  <td class=xl1511 align=right x:num x:fmla="=SUM(AE<%=st_row %>:AE<%=et_row %>)">0</td>
  <td class=xl1511 align=right x:num x:fmla="=SUM(AF<%=st_row %>:AF<%=et_row %>)">0</td>
  <td colspan=3 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl1412 style='height:23.25pt'></td>
  <td class=xl1404></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1513></td>
  <td class=xl1514></td>
  <td colspan=5 class=xl1515 style='mso-ignore:colspan'></td>
  <td class=xl1516></td>
  <td class=xl1517></td>
  <td colspan=6 class=xl1582>TỔNG HỢP CHUNG</td>
  <td class=xl1404></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl1403 height=48 style='mso-height-source:userset;height:36.0pt'>
  <td height=48 class=xl1433 style='height:36.0pt'></td>
  <td class=xl1518></td>
  <td class=xl1429>&nbsp;</td>
  <td class=xl1519></td>
  <td class=xl1403></td>
  <td colspan=5 class=xl1432 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl1403 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl1559 width=260 style='border-right:.5pt solid black;
  width:195pt'>Phát sinh tăng</td>
  <td colspan=3 class=xl1562 width=125 style='border-right:.5pt solid black;
  border-left:none;width:94pt'>BHXH</td>
  <td colspan=3 class=xl1562 width=123 style='border-right:.5pt solid black;
  border-left:none;width:92pt'>BHYT</td>
  <td colspan=2 class=xl1562 width=198 style='border-right:.5pt solid black;
  border-left:none;width:149pt'>BHTN</td>
  <td colspan=5 class=xl1403 style='mso-ignore:colspan'></td>
  <td class=xl1520 x:str="Gỉai thích ">Gỉai thích<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl1583>Số<span style='mso-spacerun:yes'>  </span>điều
  chỉnh tăng BHXH 191.774.440 là:</td>
  <td colspan=3 class=xl1479 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl1403 height=48 style='mso-height-source:userset;height:36.0pt'>
  <td height=48 class=xl1433 style='height:36.0pt'></td>
  <td class=xl1521></td>
  <td class=xl1522>&nbsp;</td>
  <td class=xl1523></td>
  <td class=xl1524></td>
  <td colspan=2 class=xl1525 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl1432 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl1403 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl1461 style='border-right:.5pt solid black'>1. Số lao
  động:</td>
  <td colspan=3 class=xl1556 width=125 style='border-right:.5pt solid black;
  border-left:none;width:94pt' x:num x:fmla="=COUNTIF(O<%=st_row %>:O<%=et_row %>,&quot;&gt;0&quot;)">81</td>
  <td colspan=3 class=xl1556 width=123 style='border-right:.5pt solid black;
  border-left:none;width:92pt' x:num x:fmla="=COUNTIF(O<%=st_row %>:O<%=et_row %>,&quot;&gt;0&quot;)">81</td>
  <td colspan=2 class=xl1556 width=198 style='border-right:.5pt solid black;
  border-left:none;width:149pt' x:num x:fmla="=COUNTIF(T<%=st_row %>:T<%=et_row %>,&quot;X&quot;)">81</td>
  <td colspan=2 class=xl1526 style='mso-ignore:colspan'></td>
  <td class=xl1403></td>
  <td colspan=2 class=xl1526 style='mso-ignore:colspan'></td>
  <td class=xl1479>&nbsp;</td>
  <td class=xl1479 colspan=6 style='mso-ignore:colspan'>Tăng lùi từ t8 đến t11
  là 49 lđ<span style='mso-spacerun:yes'>  </span>(tổng lương<span
  style='mso-spacerun:yes'>  </span>của 49 nguoi nay la: 71.380.000) TRUY BHXH<span
  style='display:none'> T8 =71.380.000 * 4(tháng) * 22% (ty le thu cua BHXH)=
  62.814.400</span></td>
 </tr>
 <tr class=xl1403 height=48 style='mso-height-source:userset;height:36.0pt'>
  <td height=48 class=xl1433 style='height:36.0pt'></td>
  <td class=xl1521></td>
  <td class=xl1522>&nbsp;</td>
  <td class=xl1523></td>
  <td class=xl1524></td>
  <td colspan=2 class=xl1525 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl1432 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl1403 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl1461 style='border-right:.5pt solid black'>2. Quỹ lương
  tham gia</td>
  <td colspan=3 class=xl1553 width=125 style='border-right:.5pt solid black;
  border-left:none;width:94pt' x:num x:fmla="=SUM(Z<%=st_row %>:Z<%=et_row %>)">173,745,000</td>
  <td colspan=3 class=xl1553 width=123 style='border-right:.5pt solid black;
  border-left:none;width:92pt' x:num x:fmla="=SUM(AA<%=st_row %>:AA<%=et_row %>)">173,745,000</td>
  <td colspan=2 class=xl1553 width=198 style='border-right:.5pt solid black;
  border-left:none;width:149pt' x:num x:fmla="=SUM(AB<%=st_row %>:AB<%=et_row %>)">173,745,000</td>
  <td colspan=5 class=xl1403 style='mso-ignore:colspan'></td>
  <td class=xl1479>&nbsp;</td>
  <td class=xl1479 colspan=6 style='mso-ignore:colspan'>Tăng lùi từ<span
  style='mso-spacerun:yes'>  </span>T9 đến t11 là 37 lđ<span
  style='mso-spacerun:yes'>  </span>(tổng lương<span style='mso-spacerun:yes'> 
  </span>của 37 nguoi nay la: 47.840.000) TRUY BHX<span style='display:none'>H
  T9 =47.840.000 * 3(tháng) * 22% (ty le thu cua BHXH)= 31.574.400</span></td>
 </tr>
 <tr class=xl1403 height=48 style='mso-height-source:userset;height:36.0pt'>
  <td height=48 class=xl1433 style='height:36.0pt'></td>
  <td class=xl1524></td>
  <td class=xl1522>&nbsp;</td>
  <td class=xl1523></td>
  <td class=xl1524></td>
  <td colspan=2 class=xl1525 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl1432 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl1403 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl1461 style='border-right:.5pt solid black'>3. Số phải
  đóng</td>
  <td colspan=3 class=xl1553 width=125 style='border-right:.5pt solid black;
  border-left:none;width:94pt' x:num x:fmla="=22%*P<%=et_row +6 %>">38,223,900</td>
  <td colspan=3 class=xl1553 width=123 style='border-right:.5pt solid black;
  border-left:none;width:92pt' x:num x:fmla="=4.5%*S<%=et_row +6 %>">7,818,525</td>
  <td colspan=2 class=xl1553 width=198 style='border-right:.5pt solid black;
  border-left:none;width:149pt' x:num x:fmla="=2%*V<%=et_row + 6%>">3,474,900</td>
  <td colspan=5 class=xl1403 style='mso-ignore:colspan'></td>
  <td class=xl1479>&nbsp;</td>
  <td class=xl1479 colspan=6 style='mso-ignore:colspan'>Tăng lùi từ<span
  style='mso-spacerun:yes'>  </span>T10 đến t11 là 107 lđ<span
  style='mso-spacerun:yes'>  </span>(tổng lương<span style='mso-spacerun:yes'> 
  </span>của 107 nguoi nay la: 137.600.000) TRUY <span style='display:none'>BHXH
  T10 =137.600.000 * 2(tháng) * 22% (ty le thu cua BHXH)= 60.544.000</span></td>
 </tr>
 <tr class=xl1403 height=48 style='mso-height-source:userset;height:36.0pt'>
  <td height=48 class=xl1433 style='height:36.0pt'></td>
  <td class=xl1524></td>
  <td class=xl1522>&nbsp;</td>
  <td class=xl1523></td>
  <td class=xl1524></td>
  <td colspan=2 class=xl1525 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl1432 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl1403 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl1461 style='border-right:.5pt solid black'>Trong đó: Số
  tiên để lại đơn vị</td>
  <td colspan=3 class=xl1553 width=125 style='border-right:.5pt solid black;
  border-left:none;width:94pt' x:num x:fmla="=P<%=et_row +6%>*2%">3,474,900</td>
  <td colspan=3 class=xl1553 width=123 style='border-right:.5pt solid black;
  border-left:none;width:92pt'>&nbsp;</td>
  <td colspan=2 class=xl1556 width=198 style='border-right:.5pt solid black;
  border-left:none;width:149pt'>&nbsp;</td>
  <td colspan=5 class=xl1403 style='mso-ignore:colspan'></td>
  <td class=xl1479>&nbsp;</td>
  <td class=xl1479 colspan=6 style='mso-ignore:colspan'>Tăng lùi từ<span
  style='mso-spacerun:yes'>  </span>T11 đến t11 là 100 lđ<span
  style='mso-spacerun:yes'>  </span>(tổng lương<span style='mso-spacerun:yes'> 
  </span>của 100 nguoi nay la: 167.462.000) TRUY <span style='display:none'>BHXH
  T11 =167.462.000 * 1(tháng) * 22% (ty le thu cua BHXH)= 36.841.640</span></td>
 </tr>
 <tr class=xl1403 height=48 style='mso-height-source:userset;height:36.0pt'>
  <td height=48 class=xl1433 style='height:36.0pt'></td>
  <td class=xl1524></td>
  <td class=xl1522>&nbsp;</td>
  <td class=xl1523></td>
  <td class=xl1524></td>
  <td colspan=2 class=xl1525 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl1432 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl1403 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl1461 style='border-right:.5pt solid black'>4. Số tiền
  điều chỉnh:</td>
  <td colspan=3 class=xl1549 width=125 style='border-right:.5pt solid black;
  border-left:none;width:94pt' x:num x:fmla="=AD<%=et_row + 2%>">0</td>
  <td colspan=3 class=xl1549 width=123 style='border-right:.5pt solid black;
  border-left:none;width:92pt' x:num x:fmla="=AE<%=et_row + 2%>">0</td>
  <td colspan=2 class=xl1549 width=198 style='border-right:.5pt solid black;
  border-left:none;width:149pt' x:num x:fmla="=AF<%=et_row + 2%>">0</td>
  <td class=xl1527></td>
  <td colspan=4 class=xl1403 style='mso-ignore:colspan'></td>
  <td class=xl1479>&nbsp;</td>
  <td class=xl1479 colspan=5 style='mso-ignore:colspan'>Tương tự<span
  style='mso-spacerun:yes'>  </span>như vậy H nhân lên và tính cho phần BHYT,
  BHTN</td>
  <td class=xl1479>&nbsp;</td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl1412 style='height:28.5pt'></td>
  <td class=xl1528></td>
  <td class=xl1529>&nbsp;</td>
  <td colspan=2 class=xl1528 style='mso-ignore:colspan'></td>
  <td class=xl1530>Ngày..... tháng...... năm..........</td>
  <td class=xl1530></td>
  <td colspan=3 class=xl1412 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl1404 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl1548>Ngày 01 tháng 10 năm 2011</td>
  <td colspan=3 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1531></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=42 style='mso-height-source:userset;height:31.5pt'>
  <td height=42 class=xl1409 style='height:31.5pt'></td>
  <td class=xl1532>Cán bộ thu</td>
  <td class=xl1533>&nbsp;</td>
  <td colspan=2 class=xl1534 style='mso-ignore:colspan'></td>
  <td class=xl1532>GIÁM ĐỐC BHXH</td>
  <td class=xl1532></td>
  <td colspan=3 class=xl1409 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl1398 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl1532>Người lập biểu</td>
  <td class=xl1398></td>
  <td colspan=2 class=xl1535 style='mso-ignore:colspan'></td>
  <td class=xl1536><span
  style='mso-spacerun:yes'>                                </span>Người sử dụng
  lao động</td>
  <td class=xl1536></td>
  <td class=xl1535></td>
  <td colspan=14 class=xl1398 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl1412 style='height:24.0pt'></td>
  <td class=xl1404></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl1412 style='height:25.5pt'></td>
  <td class=xl1404></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td class=xl1404></td>
  <td class=xl1531></td>
  <td colspan=13 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  285'>
  <td class=xl1517 colspan=2 style='mso-ignore:colspan'>Ghi chuù: Maãu soá
  02a-TBH do Ñôn vò laäp kh<span style='display:none'>i coù lao ñoäng taêng
  môùi so vôùi thaùng tröôùc, hoaëc laäp danh saùch toaøn boä lao ñoäng khi ñôn
  vò môùi tham gia BHXH, BHYT, BHTN</span></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  285'>
  <td height=0 class=xl1517></td>
  <td class=xl1404></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  285'>
  <td class=xl1539 colspan=2 style='mso-ignore:colspan'>Phöông phaùp ghi:</td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  315'>
  <td height=0 class=xl1539></td>
  <td class=xl1540>Caùc oâ coù maøu Xanh laø oâ coâng <span style='display:
  none'>thöùc</span></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  315'>
  <td height=0 class=xl1539></td>
  <td class=xl1540>Nhaäp ngaøy, thaùng, naêm vaøo Coä<span style='display:none'>t
  R (oâ maøu vaøng ñeå coù thaùng baùo caùo)</span></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  285'>
  <td height=0 class=xl1412></td>
  <td class=xl1404>Coät 1, 2: ghi soá TT, hoï teân ngöôøi<span
  style='display:none'> lao ñoäng taêng</span></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  285'>
  <td height=0 class=xl1412></td>
  <td class=xl1404>Coät 3: ghi soá soå BHXH cuûa ngöô<span style='display:none'>øi
  lao ñoäng (neáu coù). Ngöôøi lao ñoäng ñaõ coù soå ghi tröôùc, chöa coù soå
  BHXH ghi sau.</span></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  285'>
  <td height=0 class=xl1412></td>
  <td class=xl1404>Coät 4: ghi soá theû BHYT (neáu coù<span style='display:
  none'>), chöa coù boå sung sau khi cô quan BHXH caáp.</span></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  285'>
  <td height=0 class=xl1412></td>
  <td class=xl1404>Coät 5: ghi ngaøy thaùng naêm sinh (<span style='display:
  none'>yeâu caàu caàn phaûi ghi ñaày ñuû caû ngaøy, thaùng sinh)</span></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none'>
  <td height=0 class=xl1412></td>
  <td class=xl1404>Coät 6: neáu laø nöõ ñaùnh daáu x</td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none'>
  <td height=0 class=xl1412></td>
  <td class=xl1404>Coät 7: ghi soá CMND cuûa ngöôøi l<span style='display:none'>ao
  ñoäng.</span></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none'>
  <td height=0 class=xl1412></td>
  <td class=xl1404>Coät 8: ghi ñòa chæ laø nôi cö truù hi<span
  style='display:none'>eän taïi cuûa ngöôøi lao ñoäng.</span></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none'>
  <td height=0 class=xl1412></td>
  <td class=xl1404>Coät 9, 10: ghi nôi ñaêng kyù KCB ba<span style='display:
  none'>n ñaàu.</span></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none'>
  <td height=0 class=xl1412></td>
  <td class=xl1404>Coät 11: ghi toång möùc tieàn löông, <span style='display:
  none'>tieàn coâng theo HÑLÑ</span></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none'>
  <td height=0 class=xl1412></td>
  <td class=xl1404>- Neáu ñôn vò thöïc hieän theo thang<span style='display:
  none'>, baûng löông Nhaø nöôùc thì ghi baèng heä soá löông.</span></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none'>
  <td height=0 class=xl1412></td>
  <td class=xl1404>- Neáu ñôn vò thöïc hieän thang, baû<span style='display:
  none'>ng löông do ñôn vò töï xaây döïng thì ghi baèng toång möùc löông tieàn
  ñoàng.</span></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none'>
  <td height=0 class=xl1412></td>
  <td class=xl1404>- Neáu ghi baèng USD: thì tính ra VN<span style='display:
  none'>Ñ ñeå ghi, theo tyû giaù bình quaân lieân ngaân haøng ngaøy 2/1 cho 6
  thaùng ñaàu naêm vaø ngaøy 1/7 cho 6 thaùng cuoái naêm.</span></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none'>
  <td height=0 class=xl1412></td>
  <td class=xl1541>Töø coät 12 ñeán coät 15 chæ aùp d<span style='display:none'>öïng
  ñoái vôùi ñôn vò thöïc hieän thang, baûng löông Nhaø nöôùc.</span></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none'>
  <td height=0 class=xl1412></td>
  <td class=xl1404>Coät 12:<span style='mso-spacerun:yes'>  </span>ghi heä soá
  phuï caáp chöùc<span style='display:none'> vuï (neáu coù).</span></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none'>
  <td height=0 class=xl1412></td>
  <td class=xl1404>Coät 13: ghi % thaâm nieân vöôït khu<span style='display:
  none'>ng (neáu coù).</span></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none'>
  <td height=0 class=xl1412></td>
  <td class=xl1404>Coät 14: ghi % thaâm nieân ngheà (ne<span style='display:
  none'>áu coù).</span></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none'>
  <td height=0 class=xl1412></td>
  <td class=xl1404>Coät 15: ghi heä soá phuï caáp khu v<span style='display:
  none'>öïc (neáu coù).</span></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none'>
  <td height=0 class=xl1412></td>
  <td class=xl1404>Coät 16: neáu coù tham gia BHTN thì <span style='display:
  none'>ñaùnh daáu (x) vaøo, khoâng tham gia BHTN ñeå troáng.</span></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none'>
  <td height=0 class=xl1412></td>
  <td class=xl1404>Coät 17: ghi töø thaùng/naêm baét ña<span style='display:
  none'>àu laøm vieäc chính thöùc theo HÑLÑ hoaëc QÑ tuyeån duïng</span></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  270'>
  <td height=0 class=xl1412></td>
  <td class=xl1404>Coät 18: ghi ñaày ñuû soá, ngaøy QÑ<span style='display:
  none'> hoaëc HÑLÑ. Neáu ngöôøi lao ñoäng laøm ngheà, coâng vieäc ñaëc bieät
  naëng nhoïc, ñoäc haïi thì ghi kyù hieäu chöõ (A); naëng nhoïc, ñoäc haïi ghi
  kyù hieäu baèng chöõ (B).</span></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl1412 style='height:12.75pt'></td>
  <td class=xl1404></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl1412 style='height:27.0pt'></td>
  <td class=xl1404></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td class=xl1404></td>
  <td class=xl1542></td>
  <td colspan=3 class=xl1547>Hoàng Thị Hằng</td>
  <td colspan=2 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1543></td>
  <td class=xl1544></td>
  <td class=xl1545></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl1412 style='height:15.75pt'></td>
  <td class=xl1404></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl1404 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl1542 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl1412 style='height:12.75pt'></td>
  <td class=xl1404></td>
  <td class=xl1512>&nbsp;</td>
  <td class=xl1537></td>
  <td class=xl1404></td>
  <td colspan=5 class=xl1538 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl1404 style='mso-ignore:colspan'></td>
  <td class=xl1412></td>
  <td colspan=15 class=xl1404 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=72 style='width:54pt'></td>
  <td width=202 style='width:152pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=349 style='width:262pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=130 style='width:98pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
