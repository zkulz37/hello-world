<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<%   string TCO_ORG_PK;
     string THR_WG_PK;
     string NATION;
     string WORK_MON = "201611";
     int irow; //dòng
     int icol_emp; //cột
     int pos = 6; //position : vị trí con trỏ trong excel 
     int loop_height = 35;
     int loop_width = 5;
     TCO_ORG_PK = Request["TCO_ORG_PK"].ToString();
     THR_WG_PK = Request["THR_WG_PK"].ToString();
     NATION = Request["NATION"].ToString();



     string SQL =
     "select  " +
     "    to_char(to_date(B.WORK_MON,'YYYYMM'),'MM-YYYY') as WORK_MON, " +
     "    A.EMP_ID, " +
     "    A.PK, " +
     "    A.FULL_NAME, " +
     "    A.PHOTO_PK, " +
     "    A.STATUS, " +
     "   B.DEPT_NM, " +
     "    to_char(to_date(A.JOIN_DT,'YYYYMMDD'),'DD-MM-YYYY') as JOIN_DT, " +
     "    to_char(to_date(A.LEFT_DT,'YYYYMMDD'),'DD-MM-YYYY') as LEFT_DT, " +
     "    A.SEX, " +
     "    A.NATION, " +
     "    A.PRESENT_ADDR, " +
     "    A.TEL, " +
     "    A.BASIC_SAL, " +
     "    A.TCO_ORG_PK, " +
     "    ROUND (NVL (B.SALARY_LEVEL1, 0), 3) as PROBATION_SALARY,  " +         //-- luong thu viec 
     "    ROUND (NVL (B.SALARY_LEVEL2, 0), 3) as OFFICIAL_SALARY,     " +        // -- luong chinh thuc 
     "    ROUND (NVL (B.ALLOW_AMT1, 0), 3) as ALLOW_AMT1,            " +         //-- phu cap chuc vu
     "    ROUND (NVL (B.ALLOW_AMT2, 0), 3) as ALLOW_AMT2,            " +         //-- phu cap tien an
     "    ROUND (NVL (B.ALLOW_AMT1_L2, 0), 3) as ALLOW_AMT1_L2, " +
     "    ROUND (NVL (B.ALLOW_AMT2_L2, 0), 3) as ALLOW_AMT2_L2, " +
     " ROUND (NVL (B.ALLOW_AMT1_L1, 0) + NVL(B.ALLOW_AMT2_L1,0),3) AS PC_PROBATION," +   // tong phu cap thu viec
     " ROUND (NVL (B.ALLOW_AMT1_L2, 0) + NVL(B.ALLOW_AMT2_L2,0),3) AS PC_OFFICIAL," +    // tong phu cap chinh thuc
     "    ROUND (NVL (B.WT_L1, 0) + NVL (B.HOL_DAY_L1, 0) * 8, 3) as WT_L1, " +
     "    ROUND (NVL (B.WT_L2, 0) + NVL (B.HOL_DAY_L2, 0) * 8, 3) as Working_Days,  " +  //-- Ngày công
     "    ROUND (NVL (B.WT_L1_AMT, 0)+ NVL (B.HOL_DAY_L1_AMT, 0)+ NVL (B.WT_L2_AMT, 0)+ NVL (B.HOL_DAY_L2_AMT, 0),3) as BASIC_SALARY,  " +   //-- ngay cong qui ra tien
     "    ROUND (NVL (B.ABS_ALE_L1, 0), 3) as ALE_ABS,   " +             //-- Nghỉ phép năm 
     "    ROUND (NVL (B.ABS_ALE_L2, 0), 3) as OTHER_ABS,   " +           //-- Ngày vắng khác
     "    ROUND (NVL (B.ABS_ALE_L1_AMT, 0) + NVL (B.ABS_ALE_L2_AMT, 0), 3) as ABS_AMT,   " +       //  -- Nghỉ phép qui ra tiền
     "     ROUND (NVL (B.ABS_OTHER_PAY_L1, 0), 3), " +
     "         ROUND (NVL (B.ABS_OTHER_PAY_L2, 0), 3), " +
     "         ROUND ( " +
     "            NVL (B.ABS_OTHER_PAY_L1_AMT, 0) + NVL (B.ABS_OTHER_PAY_L2_AMT, 0), " +
     "            3), " +
     "         ROUND (NVL (B.OT_L1, 0), 3), " +
     "         ROUND (NVL (B.OT_L2, 0), 3) as OT_1,   " +                // -- Tăng ca thường (Overtime 1.5)
     "         ROUND (NVL (B.OT_L1_AMT, 0) + NVL (B.OT_L2_AMT, 0), 3) as OT_1_AMT,   " +         //-- Tăng ca qui ra tiền
     "         ROUND ( " +
     "              NVL (B.ST_L1, 0) " +
     "            + NVL (B.HT_L1, 0) " +
     "            + NVL (B.OHT_L1, 0) " +
     "            + NVL (B.OST_L1, 0), " +
     "            3), " +
     "         ROUND ( " +
     "              NVL (B.ST_L2, 0) " +
     "            + NVL (B.HT_L2, 0) " +
     "            + NVL (B.OHT_L2, 0) " +
     "            + NVL (B.OST_L2, 0), " +
     "            3) as OT_2,     " +                //-- Tăng ca CN/Lễ (Overtime 2.0)
     "         ROUND ( " +
     "              NVL (B.ST_L1_AMT, 0) " +
     "            + NVL (B.HT_L1_AMT, 0) " +
     "            + NVL (B.OHT_L1_AMT, 0) " +
     "            + NVL (B.ST_L2_AMT, 0) " +
     "            + NVL (B.HT_L2_AMT, 0) " +
     "            + NVL (B.OHT_L2_AMT, 0) " +
     "            + NVL (B.OST_L1_AMT, 0) " +
     "            + NVL (B.OST_L2_AMT, 0), " +
     "            3) as OT_2_AMT,   " +              //-- Tăng ca qui ra tiền
     "         ROUND (NVL (B.NT_30_L1, 0), 3) as PC_NT,  " +         // -- PC ca đêm
     "         ROUND (NVL (B.NT_30_L2, 0), 3),                                     " +
     "         ROUND (NVL (B.NT_30_L1_AMT, 0) + NVL (B.NT_30_L2_AMT, 0), 3), " +
     "         ROUND (NVL (B.NT_45_L1, 0) + NVL (B.NT_45_2_L1, 0), 3), " +
     "         ROUND (NVL (B.NT_45_L2, 0) + NVL (B.NT_45_2_L2, 0), 3), " +
     "         ROUND ( " +
     "              NVL (B.NT_45_L1_AMT, 0) " +
     "            + NVL (B.NT_45_L2_AMT, 0) " +
     "            + NVL (B.NT_45_2_L1_AMT, 0) " +
     "            + NVL (B.NT_45_2_L2_AMT, 0), " +
     "            3), " +
     "         ROUND (NVL (B.NT_60_L1, 0), 3), " +
     "         ROUND (NVL (B.NT_60_L2, 0), 3) as PC_OST,   " +               //-- Phụ cấp tăng ca đêm CN
     "         ROUND (NVL (B.NT_60_L1_AMT, 0) + NVL (B.NT_60_L2_AMT, 0), 3) as PC_OST_AMT,  " +      //-- PCTC qui ra tiền
     "         ROUND (NVL (B.NT_90_L1, 0), 3),                                                             " +
     "         ROUND (NVL (B.NT_90_L2, 0), 3) as PC_OHT,   " +           //-- PCTC đêm lễ
     "         ROUND (NVL (B.NT_90_L1_AMT, 0) + NVL (B.NT_90_L2_AMT, 0), 3) as PC_OHT_AMT,   " +     //-- qui ra tiền
     "         ROUND (NVL (B.ALLOW_K1_AMT, 0), 3), " +
     "         ROUND (NVL (B.ALLOW_K2_AMT, 0), 3), " +
     "         ROUND (NVL (B.ALLOW_K3_AMT, 0), 3), " +
     "         ROUND (NVL (B.ALLOW_K4_AMT, 0), 3), " +
     "         ROUND (NVL (B.ALLOW_K5_AMT, 0), 3), " +
     "         ROUND (NVL (B.ALLOW_K6_AMT, 0), 3), " +
     "         ROUND (NVL (B.ALLOW_K7_AMT, 0), 3), " +
     "         ROUND (NVL (B.ALLOW_K8_AMT, 0), 3), " +
     "         ROUND (NVL (B.RETURN_AMT, 0), 3), " +
     "         ROUND (NVL (B.ALE_STOP, 0), 3), " +
     "         ROUND (NVL (B.ALE_STOP_AMT, 0), 3), " +
     "         ROUND (NVL (B.SEVERANCE_MONTH, 0), 3), " +
     "         ROUND (NVL (B.SEVERANCE_AMT, 0), 3), " +
     "         ROUND (NVL (B.GROSS_AMT, 0), 3) as GROSS_SALARY,  " +         // -- Lương Gross
     "         ROUND (NVL (B.BREAK_CONTRACT_DAYS, 0), 3), " +
     "         ROUND (NVL (B.BREAK_CONTRACT_AMT, 0), 3), " +
     "         ROUND (NVL (B.ADVANCE_AMT, 0), 3), " +
     "         ROUND (NVL (B.INCOME_BEFORE_TAX, NVL (B.INCOME_AMT, 0)), 3), " +
     "         ROUND (NVL (B.INCOME_TAX, 0), 3) as INCOME_TAX, " +           // thue thu nhap
     "         ROUND (NVL (B.UNION_AMT, 0), 3) as CONG_DOAN, " +             //cong doan
     "         ROUND (NVL (B.SOCIAL_AMT, 0) + NVL (B.HEALTH_AMT, 0), 3) as BHXH_BHYT,  " +       //-- BHXH _ BHYT
     "         ROUND (NVL (B.RETURN_NO_PIT, 0), 3), " +
     "         ROUND (NVL (B.ADVANCE_NO_PIT, 0), 3), " +
     "         DECODE ('01', " +
     "                 'ALL', ROUND (NVL (B.NET_amt, 0), 0), " +
     "                 '01', ROUND (NVL (B.NET_amt, 0), 0), " +
     "                 ROUND (NVL (B.NET_AMT, 0), 2)) as NET_SALARY, " +             // --Lương NET
     "         ROUND (NVL (B.UNEMP_INS, 0), 3) as BHTN,  " +         //-- BH thất nghiệp 
     "         ROUND (NVL (B.OT_TAX_L1_AMT, 0) + NVL (B.OT_TAX_L2_AMT, 0), 3) as OT_SLARY,  " +      //-- Tăng ca 100% qui ra tiền
     "         ROUND (NVL (B.DEDUCT_PIT, 0), 3) as DEDUCT_PIT,   " +     //-- Giảm trừ thuế
     "         ROUND (NVL (B.INC_AMT, 0), 3), " +
     "         ROUND (NVL (B.ALLOW_AMT1_L1, 0), 3), " +
     "         ROUND (NVL (B.ALLOW_AMT2_L1, 0), 3), " +
     "         ROUND (NVL (B.ALLOW_AMT3_L1, 0), 3), " +
     "         ROUND (NVL (B.ALLOW_AMT4_L1, 0), 3), " +
     "         ROUND (NVL (B.ALLOW_AMT5_L1, 0), 3), " +
     "         ROUND (NVL (B.ALLOW_AMT6_L1, 0), 3), " +
     "         ROUND (NVL (B.ALLOW_AMT7_L1, 0), 3), " +
     "         ROUND (NVL (B.ALLOW_AMT8_L1, 0), 3),  " +
     "  B.HEALTH_CARD_AMT   " +                          // tru the BH
     "from THR_EMPLOYEE a " +
     "left join THR_MONTH_SALARY b on A.EMP_ID = B.EMP_ID and A.DEL_IF = B.DEL_IF " +
     "where  " +
     "    A.DEL_IF = 0 " +
     "    and B.WORK_MON =  '" + WORK_MON + "'" +
     " and ( A.TCO_ORG_PK in (select g.pk from tco_org g where g.del_if = 0 " +
     " start with g.pk = decode ('" + TCO_ORG_PK + "','ALL',0,'" + TCO_ORG_PK + "')" +
     " connect by prior g.pk = g.p_pk) or + '" + TCO_ORG_PK + "' = 'ALL' )" +
      "       and decode( '" + THR_WG_PK + "', 'ALL', 'ALL', A.THR_WG_PK ) = '" + THR_WG_PK + "' " +
      "       and decode( '" + NATION + "', 'ALL', 'ALL', A.NATION ) = '" + NATION + "'";
     //Read SQL
     //Response.Write(SQL);
     //Response.End();

     DataTable dt_emp = ESysLib.TableReadOpen(SQL);

     irow = dt_emp.Rows.Count; //đếm tổng số dòng
     icol_emp = dt_emp.Columns.Count; //đếm tổng số cột    

     if (irow == 0)
     {
         Response.Write("There is no data");
         Response.End();
     }

     int emp_row = dt_emp.Rows.Count;

%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 15">
<link rel=File-List href="summary_rpt_salary_payslip_test_files/filelis=
t.xml">
<style id="summary_rpt_salary_payslip_test_32706_Styles"><!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.font532706
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font632706
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font732706
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font832706
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl6532706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6632706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl6732706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl6832706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6932706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl7032706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl7132706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl7232706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7332706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl7432706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl7532706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl7632706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl7732706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl7832706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;}
.xl7932706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;}
.xl8032706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;}
.xl8132706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;}
.xl8232706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;}
.xl8332706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8432706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;}
.xl8532706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFCC00;
	mso-pattern:black none;
	white-space:nowrap;}
.xl8632706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8732706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl8832706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8932706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl9032706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl9132706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl9232706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl9332706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFCC00;
	mso-pattern:black none;
	white-space:nowrap;}
.xl9432706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC00;
	mso-pattern:black none;
	white-space:nowrap;}
.xl9532706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC00;
	mso-pattern:black none;
	white-space:nowrap;}
.xl9632706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;}
.xl9732706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;}
.xl9832706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl9932706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;}
.xl10032706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;}
.xl10132706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;}
.xl10232706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl10332706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;}
.xl10432706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;}
.xl10532706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;}
.xl10632706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl10732706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;}
.xl10832706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#FFCC00;
	mso-pattern:black none;
	white-space:nowrap;}
.xl10932706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC00;
	mso-pattern:black none;
	white-space:nowrap;}
.xl11032706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC00;
	mso-pattern:black none;
	white-space:nowrap;}
.xl11132706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#FFCC00;
	mso-pattern:black none;
	white-space:nowrap;}
.xl11232706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC00;
	mso-pattern:black none;
	white-space:nowrap;}
.xl11332706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#FFCC00;
	mso-pattern:black none;
	white-space:nowrap;}
.xl11432706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#FFCC00;
	mso-pattern:black none;
	white-space:nowrap;}
.xl11532706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#FFCC00;
	mso-pattern:black none;
	white-space:nowrap;}
.xl11632706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11732706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC00;
	mso-pattern:black none;
	white-space:nowrap;}
.xl11832706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC00;
	mso-pattern:black none;
	white-space:nowrap;}
.xl11932706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC00;
	mso-pattern:black none;
	white-space:nowrap;}
.xl12032706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC00;
	mso-pattern:black none;
	white-space:nowrap;}
.xl12132706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC00;
	mso-pattern:black none;
	white-space:nowrap;}
.xl12232706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFCC00;
	mso-pattern:black none;
	white-space:nowrap;}
.xl12332706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl12432706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl12532706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl12632706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl12732706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl12832706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl12932706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl13032706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl13132706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl13232706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl13332706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl13432706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl13532706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl13632706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;}
.xl13732706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;}
.xl13832706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;}
.xl13932706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;}
.xl14032706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;}
.xl14132706
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:nowrap;}
--></style>
</head>

<body>
<!--[if !excel]>&nbsp;&nbsp;<![endif]-->
<!--The following information was generated by Microsoft Excel's Publish as=
 Web
Page wizard.-->
<!--If the same item is republished from Excel, all information between the=
 DIV
tags will be replaced.-->
<!----------------------------->
<!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD -->
<!----------------------------->



<div id="summary_rpt_salary_payslip_test_32706" align=center
x:publishsource="Excel">


    <%
     int i = 0;	 
     double sum = 0;
     for (i = 0; i < emp_row; i++)
     {
         sum += i;
 %>

<table border=0 cellpadding=0 cellspacing=0 width=2835 class=xl6532706
 style='border-collapse:collapse;table-layout:fixed;width:2127pt'>
    </tr>
    
 <col class=xl6532706 width=324 style='mso-width-source:userset;mso-w=
idth-alt:
 11849;width:243pt'>
 <col class=xl6532706 width=160 style='mso-width-source:userset;mso-w=
idth-alt:
 5851;width:120pt'>
 <col class=xl6532706 width=226 style='mso-width-source:userset;mso-w=
idth-alt:
 8265;width:170pt'>
 <col class=xl6532706 width=73 style='mso-width-source:userset;mso-wi=
dth-alt:
 2669;width:55pt'>
 <col class=xl6532706 width=89 style='mso-width-source:userset;mso-wi=
dth-alt:
 3254;width:67pt'>
 <col class=xl6532706 width=43 style='mso-width-source:userset;mso-wi=
dth-alt:
 1572;width:32pt'>
 <col class=xl6532706 width=64 span=30 style='width:48pt'>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=5 height=16 class=xl12732706 width=872 style='heigh=
t:12.0pt;
  width:655pt'></td>
  <td class=xl6532706 width=43 style='width:32pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
  <td class=xl6532706 width=64 style='width:48pt'></td>
 
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=5 height=30 class=xl11632706 style='height:22.5pt'>PAY SLIP IN <% =dt_emp.Rows[i]["WORK_MON"].ToString() %> (PHIẾU LƯƠNG THÁNG <% =dt_emp.Rows[i]["WORK_MON"].ToString() %>)</td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=5 height=22 class=xl12832706 style='height:16.5pt'>HỌ TÊN :
  <% =dt_emp.Rows[i]["FULL_NAME"].ToString() %></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
 </tr>
 <tr class=xl6832706 height=27 style='mso-height-source:userset;heigh=
t:20.25pt'>
  <td height=27 class=xl6632706 style='height:20.25pt'>Mã NV<span
  style='mso-spacerun:yes'>     </span>:<span
  style='mso-spacerun:yes'>    </span></td>
  <td class=xl6732706><% =dt_emp.Rows[i]["EMP_ID"].ToString() %></td>
  <td colspan=3 class=xl12932706 style='border-right:.5pt solid black;
  border-left:none'>Bộ phận<span style='mso-spacerun:yes'> 
  </span>:<% =dt_emp.Rows[i]["DEPT_NM"].ToString() %></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=27 style='mso-height-source:userset;heigh=
t:20.25pt'>
  <td height=27 class=xl6932706 style='height:20.25pt;border-top:none'>Ngày vào<span style='mso-spacerun:yes'></span>: </td><td class=xl7032706 style='border-top:none'><% =dt_emp.Rows[i]["JOIN_DT"].ToString() %></td>
  <td colspan=3 class=xl13232706 style='border-right:.5pt solid black;border-left:none'>Ngày nghỉ việc :<% =dt_emp.Rows[i]["LEFT_DT"].ToString() %></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=7 style='mso-height-source:userset;height=
:5.25pt'>
  <td height=7 class=xl7132706 style='height:5.25pt'>&nbsp;</td>
  <td class=xl7132706>&nbsp;</td>
  <td class=xl7232706></td>
  <td class=xl7332706></td>
  <td class=xl7332706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=27 style='mso-height-source:userset;heigh=
t:20.25pt'>
  <td height=27 class=xl7432706 style='height:20.25pt'>Lương cơ bản thử việc<font
  class="font732706"> (Probation Basic Salary)</font></td>
  <td class=xl7432706 style='border-left:none'><% =dt_emp.Rows[i]["PROBATION_SALARY"].ToString() %></td>
  <td colspan=2 class=xl13532706 style='border-left:none'>Lương cơ bản chính thức<font class="font732706">(Official Basic Salary)</font></td>
  <td class=xl7532706 style='border-left:none'><% =dt_emp.Rows[i]["OFFICIAL_SALARY"].ToString() %></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=27 style='mso-height-source:userset;heigh=
t:20.25pt'>
  <td height=27 class=xl7632706 style='height:20.25pt;border-top:none=
'>Tổng phụ
  cấp thử việc<font class="font732706"> (Probation allowance)</font=
></td>
  <td class=xl7532706 style='border-left:none'><% =dt_emp.Rows[i]["PC_PROBATION"].ToString() %></td>
  <td colspan=2 class=xl12532706 style='border-left:none'>Tổng phụ cấp chính thức <font class="font732706">(Official Allowance)</font></td>
  <td class=xl7732706 style='border-top:none;border-left:none'><% =dt_emp.Rows[i]["PC_OFFICIAL"].ToString() %></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl8032706 height=25 style='mso-height-source:userset;heigh=
t:19.15pt'>
  <td height=25 class=xl7832706 style='height:19.15pt;border-top:none=
'>Ngày
  công trong tháng <font class="font732706">(Working day of month)</fon=
t></td>
  <td class=xl7932706 style='border-top:none;border-left:none'><% =dt_emp.Rows[i]["PROBATION_SALARY"].ToString() %></td>
  <td colspan=2 class=xl12632706 style='border-left:none'>Ngày công thực tế <font
  class="font732706">(Real working day)</font></td>
  <td class=xl7932706 style='border-top:none;border-left:none'><% =dt_emp.Rows[i]["PROBATION_SALARY"].ToString() %></td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
 </tr>
 <tr class=xl8032706 height=17 style='mso-height-source:userset;heigh=
t:13.15pt'>
  <td height=17 class=xl8132706 style='height:13.15pt'>&nbsp;</td>
  <td class=xl8232706>&nbsp;</td>
  <td class=xl8332706>&nbsp;</td>
  <td class=xl8332706>&nbsp;</td>
  <td class=xl8432706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
 </tr>
 <tr class=xl6832706 height=28 style='mso-height-source:userset;heigh=
t:21.0pt'>
  <td colspan=5 height=28 class=xl12132706 style='border-right:.5pt=
 solid black;
  height:21.0pt'>LƯƠNG NGÀY CÔNG VÀ LƯƠNG TĂNG CA (BASIC AND OVERTIME SALARY)</td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=26 style='mso-height-source:userset;heigh=
t:20.1pt'>
  <td height=26 class=xl8532706 style='height:20.1pt;border-top:none'=
>Lương cơ
  bản và tăng ca</td>
  <td class=xl8532706 style='border-top:none;border-left:none'>Thử việc</td>
  <td class=xl8532706 style='border-top:none;border-left:none'>Chính thức</td>
  <td class=xl8532706 style='border-top:none;border-left:none'>Đơn vị</td>
  <td class=xl8532706 style='border-top:none;border-left:none'>Thành tiền</td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=26 style='mso-height-source:userset;heigh=
t:20.1pt'>
  <td height=26 class=xl8632706 style='height:20.1pt;border-top:none'=
>Lương
  ngày công <font class="font732706">(Basic salary)</font></td>
  <td class=xl8732706 style='border-top:none;border-left:none'><% =dt_emp.Rows[i]["Working_Days"].ToString() %></td>
  <td class=xl8732706 style='border-top:none;border-left:none'><% =dt_emp.Rows[i]["Working_Days"].ToString() %></td>
  <td class=xl8832706 style='border-top:none;border-left:none'>Giờ</t=
d>
  <td class=xl8632706 style='border-top:none;border-left:none'><% =dt_emp.Rows[i]["BASIC_SALARY"].ToString() %></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=26 style='mso-height-source:userset;heigh=
t:20.1pt'>
  <td height=26 class=xl8932706 style='height:20.1pt;border-top:none'=
>Nghỉ phép
  năm (<font class="font732706">ALE Absence</font><font class="font532=
706">)</font></td>
  <td class=xl8932706 style='border-top:none;border-left:none'><% =dt_emp.Rows[i]["PROBATION_SALARY"].ToString() %></td>
  <td class=xl9032706 style='border-top:none;border-left:none'><% =dt_emp.Rows[i]["ALE_ABS"].ToString() %></td>
  <td class=xl9132706 style='border-top:none;border-left:none'>Ngày</t=
d>
  <td class=xl8932706 style='border-top:none;border-left:none'><% =dt_emp.Rows[i]["ABS_AMT"].ToString() %></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=26 style='mso-height-source:userset;heigh=
t:20.1pt'>
  <td height=26 class=xl8932706 style='height:20.1pt;border-top:none'=
>Ngày vắng
  khác (Other Absence)</td>
  <td class=xl8932706 style='border-top:none;border-left:none'><% =dt_emp.Rows[i]["PROBATION_SALARY"].ToString() %></td>
  <td class=xl9032706 style='border-top:none;border-left:none'><% =dt_emp.Rows[i]["OTHER_ABS"].ToString() %></td>
  <td class=xl9132706 style='border-top:none;border-left:none'>Giờ</td>
  <td class=xl8932706 style='border-top:none;border-left:none'><% =dt_emp.Rows[i]["PROBATION_SALARY"].ToString() %></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=26 style='mso-height-source:userset;heigh=
t:20.1pt'>
  <td height=26 class=xl8932706 style='height:20.1pt;border-top:none'=
>Tăng ca
  thường (Week day <font class="font732706">OT 1.5</font><font
  class="font532706">)</font></td>
  <td class=xl8932706 style='border-top:none;border-left:none'><% =dt_emp.Rows[i]["PROBATION_SALARY"].ToString() %></td>
  <td class=xl9032706 style='border-top:none;border-left:none'><% =dt_emp.Rows[i]["OT_1"].ToString() %></td>
  <td class=xl9132706 style='border-top:none;border-left:none'>Giờ</t=
d>
  <td class=xl8932706 style='border-top:none;border-left:none'><% =dt_emp.Rows[i]["OT_1_AMT"].ToString() %></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=26 style='mso-height-source:userset;heigh=
t:20.1pt'>
  <td height=26 class=xl8932706 style='height:20.1pt;border-top:none'=
>Tăng ca
  CN (Sunday <font class="font732706">OT 2.0</font><font class="font532=
706">)</font></td>
  <td class=xl8932706 style='border-top:none;border-left:none'><% =dt_emp.Rows[i]["PROBATION_SALARY"].ToString() %></td>
  <td class=xl9032706 style='border-top:none;border-left:none'><% =dt_emp.Rows[i]["PROBATION_SALARY"].ToString() %></td>
  <td class=xl9132706 style='border-top:none;border-left:none'>Giờ</t=
d>
  <td class=xl8932706 style='border-top:none;border-left:none'><% =dt_emp.Rows[i]["PROBATION_SALARY"].ToString() %></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=26 style='mso-height-source:userset;heigh=
t:20.1pt'>
  <td height=26 class=xl8932706 style='height:20.1pt;border-top:none'=
>Tăng ca
  Lễ (Holiday <font class="font732706">OT 3.0</font><font class="font=
532706">)</font></td>
  <td class=xl8932706 style='border-top:none;border-left:none'><% =dt_emp.Rows[i]["PROBATION_SALARY"].ToString() %></td>
  <td class=xl9032706 style='border-top:none;border-left:none'><% =dt_emp.Rows[i]["OT_2"].ToString() %></td>
  <td class=xl9132706 style='border-top:none;border-left:none'>Giờ</t=
d>
  <td class=xl8932706 style='border-top:none;border-left:none'><% =dt_emp.Rows[i]["OT_2_AMT"].ToString() %></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=26 style='mso-height-source:userset;heigh=
t:20.1pt'>
  <td colspan=4 height=26 class=xl12332706 style='height:20.1pt'>Tổng lương ngày công và phụ cấp <font class="font832706">(Total of Basic salary and allowance)</font></td>
  <td class=xl9232706>&nbsp;</td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=25 style='mso-height-source:userset;heigh=
t:19.15pt'>
  <td height=25 class=xl9332706 style='height:19.15pt;border-top:none=
'>Tổng
  (Total)</td>
  <td class=xl9432706 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl9532706 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl11932706 style='border-right:.5pt solid black'><% =dt_emp.Rows[i]["PROBATION_SALARY"].ToString() %></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl8032706 height=9 style='mso-height-source:userset;height=
:6.75pt'>
  <td height=9 class=xl9632706 style='height:6.75pt'>&nbsp;</td>
  <td class=xl9632706>&nbsp;</td>
  <td class=xl9632706>&nbsp;</td>
  <td class=xl9732706>&nbsp;</td>
  <td class=xl9732706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl8032706>&nbsp;</td>
 </tr>
 <tr class=xl6832706 height=27 style='mso-height-source:userset;heigh=
t:20.45pt'>
  <td colspan=5 height=27 class=xl12132706 style='border-right:.5pt=
 solid black;
  height:20.45pt'>KHẤU TRỪ (DEDUCT)</td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=24 style='mso-height-source:userset;heigh=
t:18.6pt'>
  <td height=24 class=xl9832706 style='height:18.6pt;border-top:none'=
>Thu nhập
  chịu thuế(<font class="font732706">Payable Income</font><font
  class="font532706">)</font></td>
  <td class=xl9932706 style='border-top:none'><span
  style='mso-spacerun:yes'>                     
                </span><span
  style='display:none'><span style='mso-spacerun:yes'>      </spa=
n></span></td>
  <td class=xl10032706 style='border-top:none'><% =dt_emp.Rows[i]["INCOME_TAX"].ToString() %></td>
  <td class=xl10032706 style='border-top:none'>&nbsp;</td>
  <td class=xl10132706 style='border-top:none'>&nbsp;</td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=24 style='mso-height-source:userset;heigh=
t:18.6pt'>
  <td height=24 class=xl10232706 style='height:18.6pt;border-top:none=
'>Vi phạm
  HĐ (<font class="font732706">Break Contract</font><font class="font5=
32706">)</font></td>
  <td class=xl9132706 style='border-top:none'>Số ngày</td>
  <td class=xl8932706 style='border-top:none;border-left:none'><% =dt_emp.Rows[i]["PROBATION_SALARY"].ToString() %></td>
  <td class=xl9132706 style='border-top:none;border-left:none'>Số tiền</td>
  <td class=xl8932706 style='border-top:none;border-left:none'><% =dt_emp.Rows[i]["PROBATION_SALARY"].ToString() %></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=24 style='mso-height-source:userset;heigh=
t:18.6pt'>
  <td height=24 class=xl10232706 style='height:18.6pt;border-top:none=
'>BHXH
  &amp; BHYT (<font class="font732706">Insurance AMT</font><font
  class="font532706">)</font></td>
  <td class=xl13632706 style='border-top:none'><% =dt_emp.Rows[i]["BHXH_BHYT"].ToString() %></td>
  <td class=xl13732706 style='border-top:none'>&nbsp;</td>
  <td class=xl13732706 style='border-top:none'>&nbsp;</td>
  <td class=xl10332706 style='border-top:none'>&nbsp;</td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=24 style='mso-height-source:userset;heigh=
t:18.6pt'>
  <td height=24 class=xl10232706 style='height:18.6pt;border-top:none=
'>BH Thất
  nghiệp (<font class="font732706">Unemployee Ins (1%)</font><font
  class="font532706">)</font></td>
  <td class=xl13632706 style='border-top:none'><% =dt_emp.Rows[i]["BHTN"].ToString() %></td>
  <td class=xl13732706 style='border-top:none'>&nbsp;</td>
  <td class=xl13732706 style='border-top:none'>&nbsp;</td>
  <td class=xl10332706 style='border-top:none'>&nbsp;</td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=24 style='mso-height-source:userset;heigh=
t:18.6pt'>
  <td height=24 class=xl10232706 style='height:18.6pt;border-top:none=
'>Tiền
  công đoàn (Trade Union)</td>
  <td class=xl13632706 style='border-top:none'><% =dt_emp.Rows[i]["CONG_DOAN"].ToString() %></td>
  <td class=xl13732706 style='border-top:none'>&nbsp;</td>
  <td class=xl13732706 style='border-top:none'>&nbsp;</td>
  <td class=xl10432706 style='border-top:none'>&nbsp;</td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=24 style='mso-height-source:userset;heigh=
t:18.6pt'>
  <td height=24 class=xl10232706 style='height:18.6pt;border-top:none=
'>Trừ thẻ
  Bảo hiểm (<font class="font732706">Deduct Health card</font><font
  class="font532706">)</font></td>
  <td class=xl13632706 style='border-top:none'><% =dt_emp.Rows[i]["HEALTH_CARD_AMT"].ToString() %></td>
  <td class=xl13732706 style='border-top:none'>&nbsp;</td>
  <td class=xl13732706 style='border-top:none'>&nbsp;</td>
  <td class=xl10332706 style='border-top:none'>&nbsp;</td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl8032706>&nbsp;</td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=24 style='mso-height-source:userset;heigh=
t:18.6pt'>
  <td height=24 class=xl10232706 style='height:18.6pt;border-top:none=
'>Thuế thu
  nhập (<font class="font732706">Income Tax</font><font class="font53=
2706">)</font></td>
  <td class=xl13832706 style='border-top:none'><% =dt_emp.Rows[i]["INCOME_TAX"].ToString() %></td>
  <td class=xl13932706 style='border-top:none'>&nbsp;</td>
  <td class=xl13932706 style='border-top:none'>&nbsp;</td>
  <td class=xl10532706 style='border-top:none'>&nbsp;</td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=24 style='mso-height-source:userset;heigh=
t:18.6pt'>
  <td height=24 class=xl10632706 style='height:18.6pt;border-top:none=
'>Trừ khác
  (<font class="font732706">Other Ded (No PIT)</font><font class="font5=
32706">)</font></td>
  <td class=xl14032706 style='border-top:none'><% =dt_emp.Rows[i]["PROBATION_SALARY"].ToString() %></td>
  <td class=xl14132706 style='border-top:none'>&nbsp;</td>
  <td class=xl14132706 style='border-top:none'>&nbsp;</td>
  <td class=xl10732706 style='border-top:none'>&nbsp;</td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=28 style='mso-height-source:userset;heigh=
t:21.0pt'>
  <td height=28 class=xl9432706 style='height:21.0pt;border-top:none'=
>Tổng khấu
  trừ (Total Deduct)</td>
  <td colspan=4 class=xl12232706><% =dt_emp.Rows[i]["DEDUCT_PIT"].ToString() %></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=10 style='mso-height-source:userset;heigh=
t:7.5pt'>
  <td colspan=5 height=10 class=xl11632706 style='height:7.5pt'></t=
d>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=24 style='mso-height-source:userset;heigh=
t:18.6pt'>
  <td height=24 class=xl10832706 style='height:18.6pt'>Thực lãnh (
      <font
  class="font832706">Net Salary</font><font class="font632706">)</font>
</td>
  <td class=xl10932706>&nbsp;</td>
  <td class=xl11032706><% =dt_emp.Rows[i]["NET_SALARY"].ToString() %></td>
  <td colspan=2 class=xl11732706 style='border-right:1.0pt solid blac=
k'>&nbsp;</td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
 <tr class=xl6832706 height=24 style='mso-height-source:userset;heigh=
t:18.6pt'>
  <td height=24 class=xl11132706 style='height:18.6pt;border-top:none=
'>Phép năm còn lại tính đến tháng hiện tại <font class="font832706">(Remaining A.L)</font>
</td>
  <td class=xl11232706 style='border-top:none'>&nbsp;</td>
  <td class=xl11332706 style='border-top:none'>&nbsp;</td>
  <td class=xl11432706 style='border-top:none'><% =dt_emp.Rows[i]["PROBATION_SALARY"].ToString() %></td>
  <td class=xl11532706 style='border-top:none'>&nbsp;</td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
  <td class=xl6832706></td>
 </tr>
    
 <tr height=33 style='page-break-before:always;mso-height-source:userset;
  height:24.95pt'>
  <td height=33 class=xl6532706 style='height:24.95pt'></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
  <td class=xl6532706></td>
 
    
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=324 style='width:243pt'></td>
  <td width=160 style='width:120pt'></td>
  <td width=226 style='width:170pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

      <%
    }
    %>

</div>
    
    


<!----------------------------->
<!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD-->
<!----------------------------->
</body>

</html>

