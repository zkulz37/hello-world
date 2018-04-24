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
    
    string P_DEPT,P_GROUP,P_STATUS,P_TYPE,P_PAY_TYPE,P_EMP_ID,P_WORK_MON, P_M_TYPE,P_TIMES,P_EMP_TYPE;
     
  
    P_WORK_MON   = Request["l_work_mon"].ToString();
    DateTime p_month_dt=new DateTime(int.Parse(P_WORK_MON.Substring(0,4).ToString()),int.Parse(P_WORK_MON.Substring(4,2).ToString()),1) ;
    
    string SQL_S
	= "SELECT " + 
        "ORG_LEVEL1_NM " +
        ",COUNT(*)  " +
        ",SUM(ROUND(NVL(A.TOTAL_PAY_L2_AMT,0) + NVL(A.ALLOW_AMT1_L2,0)  + NVL(A.ALLOW_AMT2_L2,0)-NVL(A.PROBATION_AMT,0) ,10))  WT  " +
        ",SUM(ROUND(NVL(A.OT_L2_AMT,0) +  nvl(a.MONTH_OT_L2_AMT,0)+ NVL(A.ST_L2_AMT,0) + NVL(A.OST_L2_AMT,0) + NVL(A.HT_L2_AMT,0) + NVL(A.OHT_L2_AMT,0) + NVL(A.NT_30_L2_AMT,0) + NVL(A.NT_45_L2_AMT,0)+NVL(A.NT_60_L2_AMT,0) +  NVL(A.NT_90_L2_AMT,0),10)) OT  " +
        ",SUM(ROUND(NVL(A.ALLOW_K1_AMT,0) + NVL(A.ALLOW_K2_AMT,0) + NVL(A.ALLOW_AMT3_L2,0) + NVL(A.ALLOW_AMT4_L2,0) + NVL(A.ALLOW_AMT5_L2,0)   " +
        " + NVL(A.ALLOW_K3_AMT,0) + NVL(A.ALLOW_K4_AMT,0) + NVL(A.ALLOW_K5_AMT,0) + NVL(A.ALLOW_K6_AMT,0) + NVL(A.ALLOW_K7_AMT,0) + NVL(A.ALLOW_K8_AMT,0)+NVL(A.MEAL,0)+NVL(A.ALLOW_AMT6_L2,0)+NVL(A.UNFIX_OTHER_AMT,0)  " +
        " + NVL(A.RETURN_AMT,0) + NVL(A.RETURN_NO_PIT,0) + NVL(A.ADDITION_AMT,0)  " +
        " + NVL(A.INC_AMT,0)+nvl(A.BONUS_YEARLY_AMT,0)   " +
        " + NVL(A.ALE_STOP_AMT,0)  " +
        " + NVL(A.SEVERANCE_AMT,0),10))  " +
        ",SUM(ROUND(NVL(A.GROSS_AMT,0),10))  " +
        ",SUM(ROUND(nvl(A.HEALTH_AMT,0)  " +
        " + nvl(A.SOCIAL_AMT,0)  " +
        " + nvl(A.UNEMP_INS,0)  " +
        " + NVL(A.UNION_AMT,0)  " +
        " + NVL(A.INCOME_TAX,0)  " +
         " + NVL(A.ADVANCE_AMT,0) + NVL(A.ADVANCE_NO_PIT,0) +  NVL(A.HEALTH_CARD_AMT,0) + nvl(a.EQUIP1_AMT,0) + nvl(a.EQUIP2_AMT,0)  " +
        " + NVL(A.CHARITY_AMT,0),10)) " +
        ",SUM(round(NVL(A.NET_AMT,0),10))  " +
        "FROM THR_MONTH_SALARY A  " +
        "WHERE A.DEL_IF=0 AND A.WORK_MON='" + P_WORK_MON + "'  " +
        "AND NVL(A.NET_AMT,0)>0  AND A.EMPLOYEE_TYPE='01' " +
        "AND NVL(A.POS_TYPE,' ') <>'04'  " +
        "GROUP BY A.ORG_LEVEL1_ID,ORG_LEVEL1_NM " ;

 //Response.Write(SQL_S);
//  Response.End();

    DataTable dt_Emp_S = ESysLib.TableReadOpen(SQL_S);
    int irow_emp_s;
    irow_emp_s = dt_Emp_S.Rows.Count;
    if (irow_emp_s == 0)
    {
        Response.Write("There is no data of salary");
        Response.End();
    }
    //----------------------------------------
    string SQL_W
	= "SELECT " + 
        "ORG_LEVEL1_NM " +
        ",COUNT(*)  " +
        ",SUM(ROUND(NVL(A.TOTAL_PAY_L2_AMT,0) + NVL(A.ALLOW_AMT1_L2,0)  + NVL(A.ALLOW_AMT2_L2,0)-NVL(A.PROBATION_AMT,0),10))  WT  " +
        ",SUM(ROUND(NVL(A.OT_L2_AMT,0) +  nvl(a.MONTH_OT_L2_AMT,0)+ NVL(A.ST_L2_AMT,0) + NVL(A.OST_L2_AMT,0) + NVL(A.HT_L2_AMT,0) + NVL(A.OHT_L2_AMT,0) + NVL(A.NT_30_L2_AMT,0) + NVL(A.NT_45_L2_AMT,0)+NVL(A.NT_60_L2_AMT,0) +  NVL(A.NT_90_L2_AMT,0),10)) OT  " +
        ",SUM(ROUND(NVL(A.ALLOW_K1_AMT,0) + NVL(A.ALLOW_K2_AMT,0) + NVL(A.ALLOW_AMT3_L2,0) + NVL(A.ALLOW_AMT4_L2,0) + NVL(A.ALLOW_AMT5_L2,0)   " +
        " + NVL(A.ALLOW_K3_AMT,0) + NVL(A.ALLOW_K4_AMT,0) + NVL(A.ALLOW_K5_AMT,0) + NVL(A.ALLOW_K6_AMT,0) + NVL(A.ALLOW_K7_AMT,0) + NVL(A.ALLOW_K8_AMT,0)+NVL(A.MEAL,0)+NVL(A.ALLOW_AMT6_L2,0)+NVL(A.UNFIX_OTHER_AMT,0)  " +
        " + NVL(A.RETURN_AMT,0) + NVL(A.RETURN_NO_PIT,0) + NVL(A.ADDITION_AMT,0)  " +
        " + NVL(A.INC_AMT,0)+nvl(A.BONUS_YEARLY_AMT,0)   " +
        " + NVL(A.ALE_STOP_AMT,0)  " +
        " + NVL(A.SEVERANCE_AMT,0),10))  " +
        ",SUM(ROUND(NVL(A.GROSS_AMT,0),10))  " +
        ",SUM(ROUND(nvl(A.HEALTH_AMT,0)  " +
        " + nvl(A.SOCIAL_AMT,0)  " +
        " + nvl(A.UNEMP_INS,0)  " +
        " + NVL(A.UNION_AMT,0)  " +
        " + NVL(A.INCOME_TAX,0)  " +
        " + NVL(A.ADVANCE_AMT,0) + NVL(A.ADVANCE_NO_PIT,0) +  NVL(A.HEALTH_CARD_AMT,0) + nvl(a.EQUIP1_AMT,0) + nvl(a.EQUIP2_AMT,0)  " +
        " + NVL(A.CHARITY_AMT,0),10)) " +
        ",SUM(round(NVL(A.NET_AMT,0),10))  " +
        "FROM THR_MONTH_SALARY A  " +
        "WHERE A.DEL_IF=0 AND A.WORK_MON='" + P_WORK_MON + "'  " +
        "AND NVL(A.NET_AMT,0)>0  AND A.EMPLOYEE_TYPE='02' " +
        "AND NVL(A.POS_TYPE,' ') <>'04'  " +
        "GROUP BY A.ORG_LEVEL1_ID,ORG_LEVEL1_NM " ;

//  Response.Write(SQL_W);
//  Response.End();

    DataTable dt_Emp_W = ESysLib.TableReadOpen(SQL_W);
    int irow_emp_w;
    irow_emp_w = dt_Emp_W.Rows.Count;
    if (irow_emp_w == 0)
    {
        Response.Write("There is no data of salary");
        Response.End();
    }
   //----------------
   string SQL_D
	= "SELECT " + 
        "0 " +
        ",COUNT(*)  " +
        ",SUM(ROUND(NVL(A.TOTAL_PAY_L2_AMT,0) + NVL(A.ALLOW_AMT1_L2,0)  + NVL(A.ALLOW_AMT2_L2,0)-NVL(A.PROBATION_AMT,0),10))  WT  " +
        ",SUM(ROUND(NVL(A.OT_L2_AMT,0) +  nvl(a.MONTH_OT_L2_AMT,0)+ NVL(A.ST_L2_AMT,0) + NVL(A.OST_L2_AMT,0) + NVL(A.HT_L2_AMT,0) + NVL(A.OHT_L2_AMT,0) + NVL(A.NT_30_L2_AMT,0) + NVL(A.NT_45_L2_AMT,0)+NVL(A.NT_60_L2_AMT,0) +  NVL(A.NT_90_L2_AMT,0),10)) OT  " +
        ",SUM(ROUND(NVL(A.ALLOW_K1_AMT,0) + NVL(A.ALLOW_K2_AMT,0) + NVL(A.ALLOW_AMT3_L2,0) + NVL(A.ALLOW_AMT4_L2,0) + NVL(A.ALLOW_AMT5_L2,0)   " +
        " + NVL(A.ALLOW_K3_AMT,0) + NVL(A.ALLOW_K4_AMT,0) + NVL(A.ALLOW_K5_AMT,0) + NVL(A.ALLOW_K6_AMT,0) + NVL(A.ALLOW_K7_AMT,0) + NVL(A.ALLOW_K8_AMT,0)+NVL(A.MEAL,0)+NVL(A.ALLOW_AMT6_L2,0)+NVL(A.UNFIX_OTHER_AMT,0)  " +
        " + NVL(A.RETURN_AMT,0) + NVL(A.RETURN_NO_PIT,0) + NVL(A.ADDITION_AMT,0)  " +
        " + NVL(A.INC_AMT,0)+nvl(A.BONUS_YEARLY_AMT,0)   " +
        " + NVL(A.ALE_STOP_AMT,0)  " +
        " + NVL(A.SEVERANCE_AMT,0),10))  " +
        ",SUM(ROUND(NVL(A.GROSS_AMT,0),10))  " +
        ",SUM(ROUND(nvl(A.HEALTH_AMT,0)  " +
        " + nvl(A.SOCIAL_AMT,0)  " +
        " + nvl(A.UNEMP_INS,0)  " +
        " + NVL(A.UNION_AMT,0)  " +
        " + NVL(A.INCOME_TAX,0)  " +
        " + NVL(A.ADVANCE_AMT,0) + NVL(A.ADVANCE_NO_PIT,0)  +  NVL(A.HEALTH_CARD_AMT,0) + nvl(a.EQUIP1_AMT,0) + nvl(a.EQUIP2_AMT,0) " +
        " + NVL(A.CHARITY_AMT,0),10)) " +
        ",SUM(round(NVL(A.NET_AMT,0),10))  " +
        "FROM THR_MONTH_SALARY A  " +
        "WHERE A.DEL_IF=0 AND A.WORK_MON='" + P_WORK_MON + "'  " +
        "AND NVL(A.NET_AMT,0)>0 " +
        "AND NVL(A.POS_TYPE,' ' ) = '04'  " ;

//  Response.Write(SQL_D);
 // Response.End();

    DataTable dt_Emp_D = ESysLib.TableReadOpen(SQL_D);
    int irow_emp_d;
    irow_emp_d = dt_Emp_D.Rows.Count;
    if (irow_emp_d == 0)
    {
        Response.Write("There is no data of salary");
        Response.End();
    }
     
	string SQL
    = "select code_nm " +
        "from vhr_hr_code " +
        "where id='HR0048'  and lower(char_4) ='rpt_salary_payment.aspx'" ;
    DataTable dt_name = ESysLib.TableReadOpen(SQL);
    int irow_name;
    irow_name = dt_name.Rows.Count;
	String sname="";
    if (irow_name >0)
    {
         sname= dt_name.Rows[0][0].ToString();
		
    }
    
    

    int irow_sum1,irow_sum2,irow_sum3;
	irow_sum1=22 + irow_emp_s +1 ;
	irow_sum2=irow_sum1 + 7 + irow_emp_w;
	irow_sum3=irow_sum2 + 6 +irow_emp_d;
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_salary_payment_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_salary_payment_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_salary_payment_files/oledata.mso">
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
  <o:LastPrinted>2011-07-22T03:42:03Z</o:LastPrinted>
  <o:Created>2011-07-22T03:36:05Z</o:Created>
  <o:LastSaved>2011-07-22T06:35:16Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.23in .16in .32in .17in;
	mso-header-margin:.17in;
	mso-footer-margin:.16in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style44
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
.style58
	{mso-number-format:0%;
	mso-style-name:Percent;
	mso-style-id:5;}
.style62
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:돋움, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"표준_품의서_품의서\(가설사무실\)_Salary Report_sample for payment";}
td
	{mso-style-parent:style0;
	padding:0px;
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
	color:windowtext;
	font-size:28.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl67
	{mso-style-parent:style0;
	color:windowtext;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style0;
	color:windowtext;
	font-size:24.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl69
	{mso-style-parent:style0;
	color:windowtext;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center-across;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl70
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;
	layout-flow:vertical;}
.xl71
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl73
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl74
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl75
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl76
	{mso-style-parent:style0;
	color:windowtext;
	font-family:굴림, monospace;
	mso-font-charset:129;
	
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl77
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	layout-flow:vertical;}
.xl78
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl79
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl80
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl81
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl82
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl83
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"yy\0022\/\0022m\0022\/\0022d\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl84
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"yy\0022\/\0022m\0022\/\0022d\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl85
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"yy\0022\/\0022m\0022\/\0022d\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl86
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl87
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl89
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl90
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl92
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl93
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl94
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl95
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl96
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl97
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl98
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl99
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"yy\0022\/\0022m\0022\/\0022d\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl100
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"yy\0022\/\0022m\0022\/\0022d\;\@";
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl101
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"yy\0022\/\0022m\0022\/\0022d\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl102
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl103
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:top;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl104
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl105
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl106
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl107
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl108
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl109
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl110
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl111
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl112
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl113
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl114
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	layout-flow:vertical;}
.xl115
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl116
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"yy\0022\/\0022m\0022\/\0022d\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl117
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"yy\0022\/\0022m\0022\/\0022d\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl118
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"yy\0022\/\0022m\0022\/\0022d\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl119
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl120
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl121
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl122
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl123
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl124
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl125
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl126
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl127
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl128
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl129
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl130
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-family:돋움, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl131
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-family:돋움, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl132
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl133
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl134
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl135
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl136
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:굴림체, monospace;
	mso-font-charset:129;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl137
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl138
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center-across;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl139
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center-across;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl140
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center-across;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl141
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center-across;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl142
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl143
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl144
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl145
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center-across;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl146
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl147
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl148
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	vertical-align:middle;}
.xl149
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl150
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl151
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center-across;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl152
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center-across;
	vertical-align:middle;}
.xl153
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center-across;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl154
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"yyyy\0022-\0022mm\0022-\0022dd\;\@";
	text-align:left;
	vertical-align:middle;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl155
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"yyyy\0022-\0022mm\0022-\0022dd\;\@";
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl156
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:left;
	vertical-align:middle;}
.xl157
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center;
	vertical-align:middle;}
.xl158
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:right;
	vertical-align:middle;}
.xl159
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	vertical-align:middle;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl160
	{mso-style-parent:style44;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl161
	{mso-style-parent:style44;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl162
	{mso-style-parent:style44;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl163
	{mso-style-parent:style44;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl164
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl165
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl166
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl167
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center-across;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl168
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center-across;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl169
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center-across;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl170
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center-across;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl171
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl172
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl173
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl174
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl175
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl176
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl177
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl178
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl179
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl180
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl181
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl182
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl183
	{mso-style-parent:style44;
	color:green;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl184
	{mso-style-parent:style44;
	color:green;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl185
	{mso-style-parent:style44;
	color:green;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl186
	{mso-style-parent:style44;
	color:green;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl187
	{mso-style-parent:style44;
	color:green;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl188
	{mso-style-parent:style44;
	color:green;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl189
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl190
	{mso-style-parent:style44;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl191
	{mso-style-parent:style44;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl192
	{mso-style-parent:style44;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl193
	{mso-style-parent:style44;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl194
	{mso-style-parent:style44;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl195
	{mso-style-parent:style44;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl196
	{mso-style-parent:style44;
	color:red;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl197
	{mso-style-parent:style44;
	color:red;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl198
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl199
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl200
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl201
	{mso-style-parent:style58;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:Percent;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl202
	{mso-style-parent:style44;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl203
	{mso-style-parent:style44;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl204
	{mso-style-parent:style44;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl205
	{mso-style-parent:style58;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:Percent;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl206
	{mso-style-parent:style58;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:Percent;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl207
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	vertical-align:middle;}
.xl208
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl209
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl210
	{mso-style-parent:style0;
	color:red;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl211
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl212
	{mso-style-parent:style44;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl213
	{mso-style-parent:style44;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl214
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center;
	vertical-align:middle;}
.xl215
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl216
	{mso-style-parent:style0;
	color:green;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl217
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl218
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl219
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl220
	{mso-style-parent:style62;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl221
	{mso-style-parent:style62;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl222
	{mso-style-parent:style62;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl223
	{mso-style-parent:style62;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl224
	{mso-style-parent:style62;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl225
	{mso-style-parent:style62;
	color:windowtext;
	font-family:굴림, monospace;
	mso-font-charset:129;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl226
	{mso-style-parent:style62;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl227
	{mso-style-parent:style62;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl228
	{mso-style-parent:style62;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl229
	{mso-style-parent:style62;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:left;
	vertical-align:middle;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl230
	{mso-style-parent:style62;
	color:windowtext;
	font-size:14.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl231
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl232
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:굴림, monospace;
	mso-font-charset:129;
	text-align:right;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl233
	{mso-style-parent:style44;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl234
	{mso-style-parent:style44;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl235
	{mso-style-parent:style44;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl236
	{mso-style-parent:style44;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl237
	{mso-style-parent:style44;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl238
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl239
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#\#";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl240
	{mso-style-parent:style44;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl241
	{mso-style-parent:style44;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl242
	{mso-style-parent:style44;
	color:windowtext;
	font-size:12.0pt;
	font-family:굴림;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet2</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>270</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:StandardWidth>1353</x:StandardWidth>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>81</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Zoom>80</x:Zoom>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
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
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl67>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1247 style='border-collapse:
 collapse;table-layout:fixed;width:945pt'>
 <col class=xl67 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl67 width=50 span=3 style='mso-width-source:userset;mso-width-alt:
 1828;width:38pt'>
 <col class=xl67 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl67 width=50 span=10 style='mso-width-source:userset;mso-width-alt:
 1828;width:38pt'>
 <col class=xl67 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <col class=xl67 width=50 span=6 style='mso-width-source:userset;mso-width-alt:
 1828;width:38pt'>
 <col class=xl67 width=58 style='mso-width-source:userset;mso-width-alt:2121;
 width:44pt'>
 <col class=xl67 width=50 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col class=xl67 width=36 style='mso-width-source:userset;mso-width-alt:1316;
 width:27pt'>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl66 width=47 style='height:20.25pt;width:35pt'></td>
  <td class=xl66 width=50 style='width:38pt'></td>
  <td class=xl66 width=50 style='width:38pt'></td>
  <td class=xl66 width=50 style='width:38pt'></td>
  <td class=xl66 width=51 style='width:38pt'></td>
  <td class=xl66 width=50 style='width:38pt'></td>
  <td class=xl66 width=50 style='width:38pt'></td>
  <td class=xl66 width=50 style='width:38pt'></td>
  <td class=xl66 width=50 style='width:38pt'></td>
  <td class=xl67 width=50 style='width:38pt'></td>
  <td colspan=5 class=xl68 width=250 style='width:190pt'>REPORT</td>
  <td class=xl69 width=55 style='width:41pt'></td>
  <td class=xl69 width=50 style='width:38pt'></td>
  <td class=xl69 width=50 style='width:38pt'></td>
  <td class=xl69 width=50 style='width:38pt'></td>
  <td class=xl69 width=50 style='width:38pt'></td>
  <td class=xl69 width=50 style='width:38pt'></td>
  <td class=xl69 width=50 style='width:38pt'></td>
  <td class=xl69 width=58 style='width:44pt'></td>
  <td class=xl69 width=50 style='width:38pt'></td>
  <td class=xl69 width=36 style='width:27pt'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 colspan=9 class=xl66 style='height:13.5pt;mso-ignore:colspan'></td>
  <td class=xl67></td>
  <td colspan=5 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl76 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td rowspan=5 height=179 class=xl70 width=47 style='border-bottom:.5pt solid black;
  height:134.25pt;width:35pt'>CO SIGN</td>
  <td colspan=3 class=xl71 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl71 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl72 style='border-right:.5pt solid black;border-left:
  none'>Report</td>
  <td colspan=3 class=xl72 style='border-right:.5pt solid black;border-left:
  none'>Report</td>
  <td colspan=3 rowspan=2 class=xl72 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>Checked by</td>
  <td colspan=3 class=xl72 style='border-right:.5pt solid black;border-left:
  none'>Managing</td>
  <td colspan=3 class=xl72 style='border-right:.5pt solid black;border-left:
  none'>Managing</td>
  <td colspan=3 rowspan=2 class=xl72 style='border-right:1.0pt solid black;
  border-bottom:.5pt solid black'>G.Director</td>
 </tr>
 <tr class=xl76 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=3 height=26 class=xl78 style='border-right:.5pt solid black;
  height:19.5pt;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl78 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=3 class=xl78 style='border-right:.5pt solid black;border-left:
  none'>Date</td>
  <td colspan=3 class=xl78 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=3 class=xl78 style='border-right:.5pt solid black;border-left:
  none'>T.Manager</td>
  <td colspan=3 class=xl78 style='border-right:.5pt solid black;border-left:
  none'>Director</td>
 </tr>
 <tr class=xl76 height=47 style='mso-height-source:userset;height:35.25pt'>
  <td colspan=3 rowspan=2 height=94 class=xl82 style='border-bottom:.5pt solid black;
  height:70.5pt'>&nbsp;</td>
  <td colspan=3 rowspan=2 class=xl82 style='border-bottom:.5pt solid black'>&nbsp;</td>
  <td colspan=3 rowspan=3 class=xl83 width=150 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:114pt' x:num><%=DateTime.Now.Day + "/" + DateTime.Now.Month  + "/" + DateTime.Now.Year %></td>
  <td colspan=3 class=xl86 width=150 style='border-right:.5pt solid black;
  border-left:none;width:114pt'>Personal</td>
  <td class=xl89 width=50 style='border-top:none;width:38pt'>&nbsp;</td>
  <td class=xl89 width=50 style='border-top:none;width:38pt'>&nbsp;</td>
  <td class=xl90 width=55 style='border-top:none;width:41pt'>&nbsp;</td>
  <td colspan=3 rowspan=2 class=xl91 style='border-bottom:.5pt solid black'>&nbsp;</td>
  <td class=xl92 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-top:none'>&nbsp;</td>
  <td class=xl94 style='border-top:none'>&nbsp;</td>
  <td colspan=3 rowspan=2 class=xl95 style='border-right:1.0pt solid black;
  border-bottom:.5pt solid black'>&nbsp;</td>
 </tr>
 <tr class=xl76 height=47 style='mso-height-source:userset;height:35.25pt'>
  <td colspan=3 height=47 class=xl102 width=150 style='border-right:.5pt solid black;
  height:35.25pt;border-left:none;width:114pt'>part</td>
  <td colspan=2 class=xl105 style='mso-ignore:colspan'></td>
  <td class=xl106 width=55 style='width:41pt'>&nbsp;</td>
  <td class=xl108 style='border-left:none'>&nbsp;</td>
  <td class=xl109>&nbsp;</td>
  <td class=xl110>&nbsp;</td>
 </tr>
 <tr class=xl76 height=33 style='mso-height-source:userset;height:24.75pt'>
  <td colspan=3 height=33 class=xl115 style='height:24.75pt;border-left:none'>/</td>
  <td colspan=3 class=xl115 style='border-left:none'>/</td>
  <td colspan=3 class=xl119 width=150 style='border-right:.5pt solid black;
  border-left:none;width:114pt'><%=sname%></td>
  <td colspan=3 class=xl122 width=155 style='border-right:.5pt solid black;
  border-left:none;width:117pt'>&nbsp;</td>
  <td colspan=3 class=xl115 style='border-left:none' x:str="'/">/</td>
  <td colspan=3 class=xl125 style='border-right:.5pt solid black;border-left:
  none'>/</td>
  <td colspan=3 class=xl125 style='border-right:1.0pt solid black;border-left:
  none'>/</td>
 </tr>
 <tr class=xl76 height=37 style='mso-height-source:userset;height:27.75pt'>
  <td colspan=4 height=37 class=xl129 style='border-right:.5pt solid black;
  height:27.75pt'>TITLE</td>
  <td class=xl132 colspan=9 style='mso-ignore:colspan'>The Salary of Vietnam
  empolyee(<%=p_month_dt.ToString("MMMM") %><span style='mso-spacerun:yes'>  </span><%=P_WORK_MON.Substring(0,4).ToString() %>)</td>
  <td class=xl135 style='border-top:none'>&nbsp;</td>
  <td class=xl135 style='border-top:none'>&nbsp;</td>
  <td class=xl136 style='border-top:none'>&nbsp;</td>
  <td class=xl136 style='border-top:none'>&nbsp;</td>
  <td class=xl136 style='border-top:none'>&nbsp;</td>
  <td class=xl136 style='border-top:none'>&nbsp;</td>
  <td class=xl136 style='border-top:none'>&nbsp;</td>
  <td class=xl136 style='border-top:none'>&nbsp;</td>
  <td class=xl137 style='border-top:none'>&nbsp;</td>
  <td class=xl137 style='border-top:none'>&nbsp;</td>
  <td class=xl138 style='border-top:none'>&nbsp;</td>
  <td class=xl139 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl140 style='height:23.25pt'>&nbsp;</td>
  <td colspan=2 class=xl141 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl142 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl143 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl144 style='mso-ignore:colspan'></td>
  <td class=xl141></td>
  <td class=xl145>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl146 style='height:23.25pt'>&nbsp;</td>
  <td colspan=2 class=xl147 style='mso-ignore:colspan'></td>
  <td class=xl143></td>
  <td colspan=8 class=xl147 style='mso-ignore:colspan'></td>
  <td colspan=12 class=xl148 style='mso-ignore:colspan'></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl76></td>
  <td colspan=2 class=xl148 style='mso-ignore:colspan'></td>
  <td class=xl148 colspan=15 style='mso-ignore:colspan'><%=P_WORK_MON.Substring(0,4)%>년 <%=P_WORK_MON.Substring(4,2)%>월 베트남 관리직.생산직
  급여.임금 지급 내용을 아래와 같이 보고 합니다.</td>
  <td colspan=5 class=xl148 style='mso-ignore:colspan'></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td colspan=23 class=xl148 style='mso-ignore:colspan'></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td colspan=23 class=xl148 style='mso-ignore:colspan'></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl151 align=center style='height:23.25pt' x:str="'- 아 래 -">-
  아 래 -</td>
  <td colspan=23 class=xl152 style='mso-ignore:colspan'></td>
  <td class=xl153>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td colspan=23 class=xl148 style='mso-ignore:colspan'></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl148 colspan=4 style='mso-ignore:colspan' x:str="1. 급여.임금 지급일 : ">1.
  급여.임금 지급일 :<span style='mso-spacerun:yes'> </span></td>
  <td class=xl148></td>
  <td colspan=4 class=xl154 x:num><%=DateTime.Now.Day + "-" + DateTime.Now.Month  + "-" + DateTime.Now.Year %></td>
  <td colspan=2 class=xl155 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=12 class=xl148 style='mso-ignore:colspan'></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl148 colspan=13 style='mso-ignore:colspan'>2. 급여.임금 기산일 : 전월 21일
  부터 ~ 당월 20일 까지 공수 계산하여 지급.</td>
  <td colspan=10 class=xl148 style='mso-ignore:colspan'></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl156 colspan=9 style='mso-ignore:colspan'>3. 급여 지급 방법 : 은행 송금(BANK
  TRANSFER)</td>
  <td colspan=3 class=xl157 style='mso-ignore:colspan'></td>
  <td class=xl156></td>
  <td colspan=9 class=xl157 style='mso-ignore:colspan'></td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl148 colspan=5 style='mso-ignore:colspan'>4. 급여.임금 지급액 내역</td>
  <td class=xl148></td>
  <td class=xl159 colspan=2 style='mso-ignore:colspan' x:str="(총원 : ">(총원
  :<span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl161 x:num x:fmla="=E<%=irow_sum1%>+E<%=irow_sum2%>+E<%=irow_sum3%>"><span
  style='mso-spacerun:yes'>                 </span>100 </td>
  <td class=xl159>명,</td>
  <td class=xl159 colspan=3 style='mso-ignore:colspan' x:str="   총 지급금액 : "><span
  style='mso-spacerun:yes'>   </span>총 지급금액 :<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl162>&nbsp;</td>
  <td colspan=4 class=xl163 x:num x:fmla="=O<%=irow_sum1%>+O<%=irow_sum2%>+O<%=irow_sum3%>">0</td>
  <td class=xl159>동)</td>
  <td class=xl143></td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl143></td>
  <td class=xl148 colspan=2 style='mso-ignore:colspan'>1) 관리직</td>
  <td class=xl148 colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl148 style='mso-ignore:colspan'></td>
  <td class=xl147></td>
  <td class=xl148></td>
  <td class=xl147></td>
  <td colspan=11 class=xl148 style='mso-ignore:colspan'></td>
  <td class=xl143></td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl143></td>
  <td colspan=2 class=xl164>구분</td>
  <td class=xl166 style='border-left:none'>인원</td>
  <td class=xl167 align=center>지급총액(Gross)</td>
  <td class=xl168 style='border-left:none'>&nbsp;</td>
  <td class=xl169 style='border-left:none'>&nbsp;</td>
  <td class=xl167>&nbsp;</td>
  <td class=xl168 style='border-left:none'>&nbsp;</td>
  <td class=xl169 style='border-left:none'>&nbsp;</td>
  <td class=xl170>&nbsp;</td>
  <td class=xl170>&nbsp;</td>
  <td class=xl170>&nbsp;</td>
  <td colspan=3 class=xl171>&nbsp;</td>
  <td colspan=3 class=xl164>공제</td>
  <td colspan=3 class=xl165 style='border-right:1.0pt solid black;border-left:
  none'>차인지급액</td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl143></td>
  <td colspan=2 class=xl174>&nbsp;</td>
  <td class=xl176 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl177 style='border-left:none'>급여</td>
  <td colspan=3 class=xl177 style='border-left:none'>잔업수당</td>
  <td colspan=3 class=xl177 style='border-left:none'>기타</td>
  <td colspan=3 class=xl175 style='border-left:none'>계</td>
  <td colspan=3 class=xl174>(보험/소득세)</td>
  <td colspan=3 class=xl175 style='border-right:1.0pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <%
    int i;
    int icount_row=22;
    int istart_row=0,iend_row=0;
    istart_row=23;
    for (i=0;i<irow_emp_s;i++)
    {
        icount_row++;
 %>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl143></td>
  <td colspan=2 class=xl180><% =dt_Emp_S.Rows[i][0].ToString()%></td>
  <td class=xl193 align=right style='border-top:none;border-left:none' x:num><% =dt_Emp_S.Rows[i][1].ToString()%></td>
  <td colspan=3 class=xl193 style='border-right:.5pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'> </span><% =dt_Emp_S.Rows[i][2].ToString()%><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl193 style='border-right:.5pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'> </span><% =dt_Emp_S.Rows[i][3].ToString()%><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl193 style='border-right:.5pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'> </span><% =dt_Emp_S.Rows[i][4].ToString()%><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl193 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><% =dt_Emp_S.Rows[i][5].ToString()%><span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl193 style='border-right:.5pt solid black' x:num><span
  style='mso-spacerun:yes'> </span><% =dt_Emp_S.Rows[i][6].ToString()%><span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl193 style='border-right:1.0pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'> </span><% =dt_Emp_S.Rows[i][7].ToString()%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <% }
    iend_row=icount_row;
    icount_row++; %>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl143></td>
  <td colspan=2 class=xl180>합 계</td>
  <td class=xl189 align=right style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(E<%=istart_row %>:E<%=iend_row %>)">100</td>
  <td colspan=3 class=xl193 style='border-left:none' x:num="0"
  x:fmla="=SUM(F<%=istart_row %>:F<%=iend_row %>)"><span
  style='mso-spacerun:yes'>                          </span>- </td>
  <td colspan=3 class=xl193 style='border-left:none' x:num="0"
  x:fmla="=SUM(I<%=istart_row %>:I<%=iend_row %>)"><span
  style='mso-spacerun:yes'>                          </span>- </td>
  <td colspan=3 class=xl193 style='border-left:none' x:num="0"
  x:fmla="=SUM(L<%=istart_row %>:L<%=iend_row %>)"><span
  style='mso-spacerun:yes'>                          </span>- </td>
  <td colspan=3 class=xl193 style='border-left:none' x:num="0"
  x:fmla="=SUM(O<%=istart_row %>:O<%=iend_row %>)"><span
  style='mso-spacerun:yes'>                           </span>- </td>
  <td colspan=3 class=xl194 x:num="0" x:fmla="=SUM(R<%=istart_row %>:R<%=iend_row %>)"><span
  style='mso-spacerun:yes'>                          </span>- </td>
  <td colspan=3 class=xl193 style='border-right:1.0pt solid black;border-left:
  none' x:num="0" x:fmla="=SUM(U<%=istart_row %>:U<%=iend_row %>)"><span
  style='mso-spacerun:yes'>                           </span>- </td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl143></td>
  <td colspan=2 class=xl198>비 율</td>
  <td class=xl200 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl193 style='border-left:none;mso-number-format:Percent;border-bottom:1.0pt solid black;' x:num
  x:fmla="=F<%=icount_row %>/O<%=icount_row %>"></td>
  <td colspan=3 class=xl193 style='border-left:none;mso-number-format:Percent;border-bottom:1.0pt solid black;' x:num
  x:fmla="=I<%=icount_row %>/O<%=icount_row %>"></td>
  <td colspan=3 class=xl193 style='border-left:none;mso-number-format:Percent;border-bottom:1.0pt solid black;' x:num
  x:fmla="=L<%=icount_row %>/O<%=icount_row %>"></td>
  <td colspan=3 class=xl193 style='border-left:none;mso-number-format:Percent;border-bottom:1.0pt solid black;' x:num
  x:fmla="=F<%=icount_row+1 %>+I<%=icount_row+1 %>+L<%=icount_row+1 %>"></td>
  <td colspan=3 class=xl193 x:num x:fmla="=R<%=icount_row %>/O<%=icount_row %>" style='mso-number-format:Percent;border-bottom:1.0pt solid black;'></td>
  <td colspan=3 class=xl193 style='border-bottom:1.0pt solid black;border-right:1.0pt solid black;border-left:
  none;mso-number-format:Percent;' x:num x:fmla="=U<%=icount_row %>/O<%=icount_row %>"></td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl143></td>
  <td class=xl207 colspan=2 style='mso-ignore:colspan'>* 기타 : 시상<span
  style='display:none'>금, 퇴직수당, 연차수당, 전월 착오분 정산 지급 등.</span></td>
  <td colspan=18 class=xl208 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl209>&nbsp;</td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl143></td>
  <td class=xl207></td>
  <td class=xl148></td>
  <td colspan=18 class=xl208 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl209>&nbsp;</td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl143></td>
  <td class=xl148 colspan=2 style='mso-ignore:colspan'>2) 생산직</td>
  <td class=xl208 colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=16 class=xl208 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl209>&nbsp;</td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl143></td>
  <td colspan=2 class=xl164>구분</td>
  <td class=xl166 style='border-left:none'>인원</td>
  <td class=xl167 align=center>지급총액(Gross)</td>
  <td class=xl168 style='border-left:none'>&nbsp;</td>
  <td class=xl169 style='border-left:none'>&nbsp;</td>
  <td class=xl167>&nbsp;</td>
  <td class=xl168 style='border-left:none'>&nbsp;</td>
  <td class=xl169 style='border-left:none'>&nbsp;</td>
  <td class=xl170>&nbsp;</td>
  <td class=xl170>&nbsp;</td>
  <td class=xl170>&nbsp;</td>
  <td colspan=3 class=xl171>&nbsp;</td>
  <td colspan=3 class=xl164>공제</td>
  <td colspan=3 class=xl165 style='border-right:1.0pt solid black;border-left:
  none'>차인지급액</td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl143></td>
  <td colspan=2 class=xl174>&nbsp;</td>
  <td class=xl176 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl177 style='border-left:none'>임금</td>
  <td colspan=3 class=xl177 style='border-left:none'>잔업수당</td>
  <td colspan=3 class=xl177 style='border-left:none'>기타</td>
  <td colspan=3 class=xl175 style='border-left:none'>계</td>
  <td colspan=3 class=xl174>(보험/소득세)</td>
  <td colspan=3 class=xl175 style='border-right:1.0pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <% icount_row+=6;
    istart_row=icount_row+1;
 for (i=0;i<irow_emp_w;i++)
    {
        icount_row++;%>
<tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl143></td>
  <td colspan=2 class=xl180><% =dt_Emp_W.Rows[i][0].ToString()%></td>
  <td class=xl193 align=right style='border-top:none;border-left:none;white-space:nowrap;
	mso-text-control:shrinktofit;' x:num><% =dt_Emp_W.Rows[i][1].ToString()%></td>
  <td colspan=3 class=xl193 style='border-right:.5pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'> </span><% =dt_Emp_W.Rows[i][2].ToString()%><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl193 style='border-right:.5pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'> </span><% =dt_Emp_W.Rows[i][3].ToString()%><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl193 style='border-right:.5pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'> </span><% =dt_Emp_W.Rows[i][4].ToString()%><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl193 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><% =dt_Emp_W.Rows[i][5].ToString()%><span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl193 style='border-right:.5pt solid black' x:num><span
  style='mso-spacerun:yes'> </span><% =dt_Emp_W.Rows[i][6].ToString()%><span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl193 style='border-right:1.0pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'> </span><% =dt_Emp_W.Rows[i][7].ToString()%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <% }
    iend_row=icount_row;
    icount_row++; %>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl143></td>
  <td colspan=2 class=xl180>합 계</td>
  <td class=xl189 align=right style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(E<%=istart_row %>:E<%=iend_row %>)">100</td>
  <td colspan=3 class=xl193 style='border-left:none' x:num="0"
  x:fmla="=SUM(F<%=istart_row %>:F<%=iend_row %>)"><span
  style='mso-spacerun:yes'>                          </span>- </td>
  <td colspan=3 class=xl193 style='border-left:none' x:num="0"
  x:fmla="=SUM(I<%=istart_row %>:I<%=iend_row %>)"><span
  style='mso-spacerun:yes'>                          </span>- </td>
  <td colspan=3 class=xl193 style='border-left:none' x:num="0"
  x:fmla="=SUM(L<%=istart_row %>:L<%=iend_row %>)"><span
  style='mso-spacerun:yes'>                          </span>- </td>
  <td colspan=3 class=xl193 style='border-left:none' x:num="0"
  x:fmla="=SUM(O<%=istart_row %>:O<%=iend_row %>)"><span
  style='mso-spacerun:yes'>                           </span>- </td>
  <td colspan=3 class=xl194 x:num="0" x:fmla="=SUM(R<%=istart_row %>:R<%=iend_row %>)"><span
  style='mso-spacerun:yes'>                          </span>- </td>
  <td colspan=3 class=xl193 style='border-right:1.0pt solid black;border-left:
  none' x:num="0" x:fmla="=SUM(U<%=istart_row %>:U<%=iend_row %>)"><span
  style='mso-spacerun:yes'>                           </span>- </td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl143></td>
  <td colspan=2 class=xl198>비 율</td>
  <td class=xl200 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl193 style='border-left:none;mso-number-format:Percent;border-bottom:1.0pt solid black' x:num
  x:fmla="=F<%=icount_row %>/O<%=icount_row %>"></td>
  <td colspan=3 class=xl193 style='border-left:none;mso-number-format:Percent;border-bottom:1.0pt solid black' x:num
  x:fmla="=I<%=icount_row %>/O<%=icount_row %>"></td>
  <td colspan=3 class=xl193 style='border-left:none;mso-number-format:Percent;border-bottom:1.0pt solid black;' x:num
  x:fmla="=L<%=icount_row %>/O<%=icount_row %>"></td>
  <td colspan=3 class=xl193 style='border-left:none;mso-number-format:Percent;border-bottom:1.0pt solid black;' x:num
  x:fmla="=F<%=icount_row+1 %>+I<%=icount_row+1 %>+L<%=icount_row+1 %>"></td>
  <td colspan=3 class=xl193 x:num x:fmla="=R<%=icount_row %>/O<%=icount_row %>" style='mso-number-format:Percent;border-bottom:1.0pt solid black'></td>
  <td colspan=3 class=xl193 style='border-bottom:1.0pt solid black;border-right:1.0pt solid black;border-left:
  none;mso-number-format:Percent;' x:num x:fmla="=U<%=icount_row %>/O<%=icount_row %>"></td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl143></td>
  <td class=xl207 colspan=2 style='mso-ignore:colspan'>* 기타 : 고정<span
  style='display:none'>수당(만근수당, 교통수당, 학력수당, 직책수당, 환경수당), 시상금, 퇴직수당, 연차수당, 전월
  착오분 정산 지급 등.</span></td>
  <td colspan=16 class=xl215 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl214 style='mso-ignore:colspan'></td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl143></td>
  <td class=xl207></td>
  <td class=xl214></td>
  <td colspan=16 class=xl215 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl214 style='mso-ignore:colspan'></td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl143></td>
  <td class=xl148 colspan=2 style='mso-ignore:colspan'>3) 별정직(<span
  style='display:none'>기사. 통역. 잡부)</span></td>
  <td colspan=3 class=xl208 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl216></td>
  <td colspan=14 class=xl208 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl209>&nbsp;</td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl143></td>
  <td colspan=2 class=xl164>구분</td>
  <td class=xl166 style='border-left:none'>인원</td>
  <td class=xl167 align=center>지급총액(Gross)</td>
  <td class=xl168 style='border-left:none'>&nbsp;</td>
  <td class=xl169 style='border-left:none'>&nbsp;</td>
  <td class=xl167>&nbsp;</td>
  <td class=xl168 style='border-left:none'>&nbsp;</td>
  <td class=xl169 style='border-left:none'>&nbsp;</td>
  <td class=xl170>&nbsp;</td>
  <td class=xl170>&nbsp;</td>
  <td class=xl170>&nbsp;</td>
  <td colspan=3 class=xl171>&nbsp;</td>
  <td colspan=3 class=xl164>공제</td>
  <td colspan=3 class=xl165 style='border-right:1.0pt solid black;border-left:
  none'>차인지급액</td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl143></td>
  <td colspan=2 class=xl174>&nbsp;</td>
  <td class=xl176 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl177 style='border-left:none'>임금</td>
  <td colspan=3 class=xl177 style='border-left:none'>잔업수당</td>
  <td colspan=3 class=xl177 style='border-left:none'>기타</td>
  <td colspan=3 class=xl175 style='border-left:none'>계</td>
  <td colspan=3 class=xl174>(보험/소득세)</td>
  <td colspan=3 class=xl175 style='border-right:1.0pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <% icount_row+=6;
    istart_row=icount_row+1;
 for (i=0;i<irow_emp_d;i++)
    {
        icount_row++;%>
<tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl143></td>
  <td colspan=2 class=xl180>경영관리</td>
  <td class=xl193 align=right style='border-top:none;border-left:none' x:num><% =dt_Emp_D.Rows[i][1].ToString()%></td>
  <td colspan=3 class=xl193 style='border-right:.5pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'> </span><% =dt_Emp_D.Rows[i][2].ToString()%><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl193 style='border-right:.5pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'> </span><% =dt_Emp_D.Rows[i][3].ToString()%><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl193 style='border-right:.5pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'> </span><% =dt_Emp_D.Rows[i][4].ToString()%><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl193 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><% =dt_Emp_D.Rows[i][5].ToString()%><span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl193 style='border-right:.5pt solid black' x:num><span
  style='mso-spacerun:yes'> </span><% =dt_Emp_D.Rows[i][6].ToString()%><span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl193 style='border-right:1.0pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'> </span><% =dt_Emp_D.Rows[i][7].ToString()%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <%
    }
     %>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl143></td>
  <td colspan=2 class=xl198>비 율</td>
  <td class=xl200 style='border-top:none;border-left:none;mso-number-format:Percent;border-bottom:1.0pt solid black;'>&nbsp;</td>
  <td colspan=3 class=xl193 style='border-left:none;mso-number-format:Percent;border-bottom:1.0pt solid black;' x:num
  x:fmla="=F<%=icount_row %>/O<%=icount_row %>"></td>
  <td colspan=3 class=xl193 style='border-left:none;mso-number-format:Percent;border-bottom:1.0pt solid black;' x:num
  x:fmla="=I<%=icount_row %>/O<%=icount_row %>"></td>
  <td colspan=3 class=xl193 style='border-left:none;mso-number-format:Percent;border-bottom:1.0pt solid black;' x:num
  x:fmla="=L<%=icount_row %>/O<%=icount_row %>"></td>
  <td colspan=3 class=xl193 style='border-left:none;mso-number-format:Percent;border-bottom:1.0pt solid black;' x:num
  x:fmla="=F<%=icount_row+1 %>+I<%=icount_row+1 %>+L<%=icount_row+1 %>"></td>
  <td colspan=3 class=xl193 x:num x:fmla="=R<%=icount_row %>/O<%=icount_row %>" style='mso-number-format:Percent;border-bottom:1.0pt solid black' >#DIV/0!</td>
  <td colspan=3 class=xl193 style='border-bottom:1.0pt solid black;border-right:1.0pt solid black;border-left:
  none;mso-number-format:Percent;' x:num x:fmla="=U<%=icount_row %>/O<%=icount_row %>"></td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl143></td>
  <td class=xl207 colspan=18 style='mso-ignore:colspan'>* 기타 : 고정수당(만근수당, 교통수당,
  학력수당, 직책수당, 환경수당), 시상금, 퇴직수당, 연차수당, 전월 착오분 정산 지급 등.</td>
  <td colspan=3 class=xl214 style='mso-ignore:colspan'></td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl76 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl150 style='height:23.25pt'>&nbsp;</td>
  <td class=xl218>&nbsp;</td>
  <td colspan=3 class=xl219 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=15 class=xl208 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl76></td>
  <td class=xl208>&nbsp;</td>
  <td class=xl208 x:str="'- 이 상 -">- 이 <span style='display:none'>상 -</span></td>
  <td class=xl158></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr class=xl225 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=3 rowspan=2 height=62 class=xl220 width=147 style='mso-height-source:userset;border-right:
  1.0pt solid black;border-bottom:1.0pt solid black;height:46.5pt;width:111pt'>지시·의견/배포선</td>
  <td class=xl223>&nbsp;</td>
  <td class=xl223>&nbsp;</td>
  <td class=xl223>&nbsp;</td>
  <td class=xl223>&nbsp;</td>
  <td class=xl223>&nbsp;</td>
  <td class=xl223>&nbsp;</td>
  <td class=xl223>&nbsp;</td>
  <td class=xl223>&nbsp;</td>
  <td class=xl223>&nbsp;</td>
  <td class=xl223>&nbsp;</td>
  <td class=xl223>&nbsp;</td>
  <td class=xl223>&nbsp;</td>
  <td class=xl223>&nbsp;</td>
  <td class=xl223>&nbsp;</td>
  <td class=xl223>&nbsp;</td>
  <td class=xl223>&nbsp;</td>
  <td class=xl223>&nbsp;</td>
  <td class=xl223>&nbsp;</td>
  <td class=xl223>&nbsp;</td>
  <td class=xl223>&nbsp;</td>
  <td class=xl223>&nbsp;</td>
  <td class=xl224>&nbsp;</td>
 </tr>
 <tr class=xl225 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl229 style='height:23.25pt'>&nbsp;</td>
  <td class=xl229>&nbsp;</td>
  <td class=xl229>&nbsp;</td>
  <td class=xl229>&nbsp;</td>
  <td class=xl229>&nbsp;</td>
  <td class=xl229>&nbsp;</td>
  <td class=xl229>&nbsp;</td>
  <td class=xl229>&nbsp;</td>
  <td class=xl229>&nbsp;</td>
  <td class=xl229>&nbsp;</td>
  <td class=xl229>&nbsp;</td>
  <td class=xl229>&nbsp;</td>
  <td class=xl229>&nbsp;</td>
  <td class=xl229>&nbsp;</td>
  <td class=xl229>&nbsp;</td>
  <td class=xl229>&nbsp;</td>
  <td class=xl229>&nbsp;</td>
  <td class=xl229>&nbsp;</td>
  <td class=xl229>&nbsp;</td>
  <td class=xl229>&nbsp;</td>
  <td class=xl229>&nbsp;</td>
  <td class=xl230>&nbsp;</td>
 </tr>
 <tr class=xl225 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl231 colspan=2 style='height:23.25pt;mso-ignore:colspan'>공통-01</td>
  <td colspan=13 class=xl76 style='mso-ignore:colspan;border-top:1.0pt solid windowtext;'></td>
  <td colspan=4 class=xl143 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl76 style='mso-ignore:colspan'></td>
  <td colspan=2 height=31 class=xl76 width=108 style='mso-ignore:colspan-rowspan;
  height:23.25pt;width:82pt'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=47 style='width:35pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=36 style='width:27pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
