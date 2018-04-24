﻿<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    
      string p_dept, p_status, p_work_dt;

        p_dept = Request["p_org"].ToString();
        p_status = Request["p_status"].ToString();
        p_work_dt = Request["p_1"].ToString();
    
    
   string SQL
	= "select a.DEPT_NM,  " +                                  //1
        "A.EMP_ID,  " +                                             //2
        "A.FULL_NAME,  " +                                          //3
        "to_char(to_date(A.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy'),  " +  //4
        "to_char(to_date(A.left_DT,'yyyymmdd'),'dd/mm/yyyy'),  " +  //5
        "A.POS_NM,  " +                                             //6
        "(case when nvl(a.CONFIRM_DT,a.from_dt) > a.from_dt then ROUND(NVL(A.SALARY_LEVEL1,0),10) else 0 end ),  " +                               //7
        "(case when nvl(a.CONFIRM_DT,a.to_dt) > a.to_DT then 0 else ROUND(NVL(A.SALARY_LEVEL2,0),10) end),  " +                               //8
        "ROUND(NVL(A.ALLOW_AMT1,0),10),  " +                                  //9
        "ROUND(NVL(A.ALLOW_AMT2,0),10),  " +                                  //10
        "ROUND(NVL(A.ALLOW_AMT3,0),10),  " +                                  //11
        "ROUND(NVL(A.ALLOW_AMT4,0),10),  " +                                  //12
        "ROUND(NVL(A.ALLOW_AMT5,0),10),  " +                                  //13
        "ROUND(NVL(A.ALLOW_AMT6,0),10),  " +                                  //14
        "ROUND(NVL(A.ALLOW_AMT7,0),10),  " +                                  //15
        "ROUND(NVL(A.ALLOW_AMT8,0),10),  " +                                  //16
        "ROUND(NVL(A.WT_L1,0)/8 + NVL(a.HOL_DAY_L1,0),10), " +                                       //17
        "ROUND(NVL(A.WT_L2,0)/8 + NVL(a.HOL_DAY_L2,0),10), " +                                        //18
        "ROUND(NVL(A.ABS_ALE_L1,0)/8,10), " +                                    //19
        "ROUND(NVL(A.ABS_ALE_L2,0)/8,10), " +                                    //20
        "ROUND(NVL(A.ABS_OTHER_PAY_L1,0)/8,10), " +        //21
        "ROUND(NVL(A.ABS_OTHER_PAY_L2,0)/8,10), " +        //22
        "ROUND(NVL(A.WT_L1_AMT,0) + nvl(A.WT_L2_AMT,0) + nvl(A.TOTAL_ABS_PAY_L1_AMT,0) + nvl(A.TOTAL_ABS_PAY_L2_AMT,0)+ NVL(a.HOL_DAY_L1_AMT,0)+ NVL(a.HOL_DAY_L2_AMT,0),10),  " +  //23
        "ROUND(NVL(A.OT_L1,0),10), " +                                        //24
        "ROUND(NVL(A.OT_L2,0),10), " +                                        //25
        "ROUND(NVL(A.ST_L1,0) + nvl(A.HT_L1,0)+ nvl(A.OHT_L1,0)+ nvl(A.OST_L1,0),10), " +                       //26
        "ROUND(NVL(A.ST_L2,0) + nvl(A.HT_L2,0)+ nvl(A.OHT_L2,0)+ nvl(A.OST_L2,0),10), " +                       //27
        "ROUND(NVL(A.NT_30_L1,0),10), " +                                     //28
        "ROUND(NVL(A.NT_30_L2,0),10), " +                                     //29
        "ROUND(NVL(A.NT_45_L1,0),10), " +                                     //30
        "ROUND(NVL(A.NT_45_L2,0),10), " +                                     //31
        "ROUND(NVL(A.NT_60_L1,0),10), " +                                     //32
        "ROUND(NVL(A.NT_60_L2,0),10), " +                                     //33
        "ROUND(NVL(A.NT_90_L1,0),10), " +                                     //34
        "ROUND(NVL(A.NT_90_L2,0),10), " +                                     //35
        "ROUND(NVL(A.TOTAL_OT_L1_AMT,0) + nvl(A.TOTAL_OT_L2_AMT,0),10), " +        //36
        "ROUND(NVL(A.ALLOW_K1_AMT,0),10),  " +                                //37
        "ROUND(NVL(A.ALLOW_K2_AMT,0),10),  " +                                //38
        "ROUND(NVL(A.ALLOW_K3_AMT,0),10),  " +                                //39
        "ROUND(NVL(A.ALLOW_K4_AMT,0),10),  " +                                //40
        "ROUND(NVL(A.ALLOW_K5_AMT,0),10),  " +                                //41
        "ROUND(NVL(A.ALLOW_K6_AMT,0),10),  " +                                //42
        "ROUND(NVL(A.ALLOW_K7_AMT,0),10),  " +                                //43
        "ROUND(NVL(A.ALLOW_K8_AMT,0),10),  " +                                //44
        "ROUND(NVL(A.RETURN_AMT,0),10), " +                //45
        "ROUND(NVL(A.ALE_STOP,0),10),  " +                                    //46
        "ROUND(NVL(A.ALE_STOP_AMT,0),10),  " +                                //47
        "ROUND(NVL(A.SEVERANCE_MONTH,0),10),  " +                             //48
        "ROUND(NVL(A.SEVERANCE_AMT,0),10),  " +                               //49
        "ROUND(NVL(A.GROSS_AMT,0),10),  " +                            //50
        "ROUND(NVL(A.BREAK_CONTRACT_AMT,0),10), " +                           //51
        "ROUND(NVL(A.ADVANCE_AMT,0),10),  " +                                 //52
        "ROUND(NVL(A.INCOME_BEFORE_TAX,NVL(A.INCOME_AMT,0)),10),  " +                           //53
        "ROUND(NVL(A.INCOME_TAX,0),10),  " +                           //54
        "ROUND(NVL(A.UNION_AMT,0),10),  " +                                   //55
        "ROUND(NVL(A.SOCIAL_AMT,0)  ,10),  " +           //56
        "ROUND(NVL(A.RETURN_NO_PIT,0)+NVL(A.ADJ_FOR_TAX,0),10)," + //57 
        "ROUND(NVL(A.ADVANCE_NO_PIT,0),10)," + //58 
        "round(NVL(A.NET_AMT,0),0),  " + //59                             
        "ROUND(NVL(A.DEDUCT_PIT,0),10)," + //60
        "ROUND(NVL(A.INCOME_AMT,0),10)," + //61
        "ROUND(NVL(A.OT_TAX_L1_AMT,0)+NVL(A.OT_TAX_L2_AMT,0),10)," + //62
        "ROUND(nvl(A.HEALTH_AMT,0),10)," + //63
        "ROUND(nvl(A.INC_AMT,0)+nvl(A.BONUS_YEARLY_AMT,0),10) " +                //64
        ",ROUND(NVL(A.EQUIP1_AMT,0),10) " +  //65
        ",ROUND(NVL(A.EQUIP2_AMT,0),10) " +  //66
        ",ROUND(NVL(A.EQUIP3_AMT,0),10) " +  //67
        ",ROUND(NVL(A.EQUIP4_AMT,0),10) " +  //68
        ",ROUND(NVL(A.EQUIP5_AMT,0),10) " +  //69
        ",ROUND(NVL(A.EQUIP6_AMT,0),10) " +  //70
        ",ROUND(NVL(A.EQUIP7_AMT,0),10) " +  //71
        ",ROUND(NVL(A.EQUIP8_AMT,0),10) " +  //72
        ",(select code_nm  from vhr_hr_code where id='HR0117'and code=a.times) " + //73
        ",(select  to_char(to_date(m.from_dt,'yyyymmdd'),'dd-mm-yy') ||' to '|| to_char(to_date(m.to_dt,'yyyymmdd'),'dd-mm-yy')from thr_close  m where  m.del_if=0 and m.ID='02' and m.month_close=substr('" + p_work_dt + "',1,6) and  m.times=nvl(a.times,'0'))" + //74
        " ,round( NVL(A.UNEMP_INS,0),10) " +  //75
        "from THR_DAILY_SALARY_V2 a, tco_org b, thr_work_group c " +         
        "where a.del_if=0 and a.work_dt='" + p_work_dt + "' " +
        " and b.del_if=0 and c.del_if=0 and a.tco_dept_pk=b.pk and a.thr_group_pk=c.pk" +
        " and (a.tco_dept_pk in ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_dept + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_dept + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_dept + "' = 'ALL') " +
        " and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "'" +
        " and nvl(a.net_amt,0)>0 "+
        " order by A.DEPT_NM,a.emp_id";



   //Response.Write(SQL);
   //Response.End();

    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp=dt_Emp.Columns.Count-3;
    if (irow_emp == 0)
    {
        Response.Write("There is no data of salary");
        Response.End();
    }
   
    //--------------------company information-----------------------
    string SQL_Com
	= "select  a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,a.TCO_BPPHOTO_PK,to_char(to_date('" + p_work_dt + "','yyyymmdd'),'DD-MON-YYYY'),to_char(to_date('" + p_work_dt + "','yyyymmDD'),'DD-MM-YYYY') " + 
        "from tco_company a " +
        "where a.DEL_IF=0 " +
        "and a.pk in ( select tco_company_pk from  " +
        "               tco_org  f " +
        "               where  f.pk IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_dept + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_dept + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_dept + "' = 'ALL') " +
        "and rownum=1 " ;

    
    DataTable dt_Com = ESysLib.TableReadOpen(SQL_Com);
    int irow_com;
    irow_com = dt_Com.Rows.Count;
    if (irow_com == 0)
    {
        Response.Write("There is no data of company");
        Response.End();
    }
    string SQL_Allow
	= "   SELECT MAX (code1), MAX (code2), MAX (code3), MAX (code4), MAX (code5), " + 
        "             MAX (code6), MAX (code7), MAX (code8), MAX (c1), MAX (c2), " +
        "             MAX (c3), MAX (c4), MAX (c5), MAX (c6), MAX (c7), MAX (c8), " +
        "           MAX (codef1), MAX (codef2), MAX (codef3), MAX (codef4), MAX (codef5), " + 
        "             MAX (codef6), MAX (codef7), MAX (codef8) " +
        "        FROM (SELECT DECODE (code, 'A1', a.code_nm, '') AS code1, " +
        "                     DECODE (code, 'A2', a.code_nm, '') AS code2, " +
        "                     DECODE (code, 'A3', a.code_nm, '') AS code3, " +
        "                     DECODE (code, 'A4', a.code_nm, '') AS code4, " +
        "                     DECODE (code, 'A5', a.code_nm, '') AS code5, " +
        "                     DECODE (code, 'A6', a.code_nm, '') AS code6, " +
        "                     DECODE (code, 'A7', a.code_nm, '') AS code7, " +
        "                     DECODE (code, 'A8', a.code_nm, '') AS code8, " +
        "                     DECODE (code, 'A1', a.num_2, '') AS c1, " +
        "                     DECODE (code, 'A2', a.num_2, '') AS c2, " +
        "                     DECODE (code, 'A3', a.num_2, '') AS c3, " +
        "                     DECODE (code, 'A4', a.num_2, '') AS c4, " +
        "                     DECODE (code, 'A5', a.num_2, '') AS c5, " +
        "                     DECODE (code, 'A6', a.num_2, '') AS c6, " +
        "                     DECODE (code, 'A7', a.num_2, '') AS c7, " +
        "                     DECODE (code, 'A8', a.num_2, '') AS c8, " +
        "                     DECODE (code, 'A1', a.code_fnm, '') AS codef1, " +
        "                     DECODE (code, 'A2', a.code_fnm, '') AS codef2, " +
        "                     DECODE (code, 'A3', a.code_fnm, '') AS codef3, " +
        "                     DECODE (code, 'A4', a.code_fnm, '') AS codef4, " +
        "                     DECODE (code, 'A5', a.code_fnm, '') AS codef5, " +
        "                     DECODE (code, 'A6', a.code_fnm, '') AS codef6, " +
        "                     DECODE (code, 'A7', a.code_fnm, '') AS codef7, " +
        "                     DECODE (code, 'A8', a.code_fnm, '') AS codef8 " +
        "                FROM vhr_hr_code a " +
        "               WHERE a.ID = 'HR0019'  ) allow_amt " ;

    
    DataTable dt_Allow = ESysLib.TableReadOpen(SQL_Allow);
    int irow_Allow;
    irow_Allow = dt_Allow.Rows.Count;
    if (irow_Allow == 0)
    {
        Response.Write("There is no data of allowance");
        Response.End();
    }
    
    string SQL_Allowk
	= " SELECT max(name1),max(name2),max(name3),max(name4),max(name5),max(name6),max(name7),max(name8) " + 
        "        FROM (SELECT DECODE (kind, '01', a.name, '') AS name1, " +
        "                     DECODE (kind, '02', a.name, '') AS name2, " +
        "                     DECODE (kind, '03', a.name, '') AS name3, " +
        "                     DECODE (kind, '04', a.name, '') AS name4, " +
        "                     DECODE (kind, '05', a.name, '') AS name5, " +
        "                     DECODE (kind, '06', a.name, '') AS name6, " +
        "                     DECODE (kind, '07', a.name, '') AS name7, " +
        "                     DECODE (kind, '08', a.name, '') AS name8 " +
        "                FROM THR_ALLOWANCE_MASTER A  " +
        "               WHERE del_if=0) allow_k " ;

    DataTable dt_Allowk = ESysLib.TableReadOpen(SQL_Allowk);
    int irow_Allowk;
    irow_Allowk = dt_Allowk.Rows.Count;
    if (irow_Allowk == 0)
    {
        Response.Write("There is no data of allowance");
        Response.End();
    }

    string SQL_Equip
	= "   SELECT MAX(code1),MAX(code2),MAX(code3),MAX(code4),MAX(code5),MAX(code6),MAX(code7),MAX(code8) " + 
        "          ,MAX(codef1),MAX(codef2),MAX(codef3),MAX(codef4),MAX(codef5),MAX(codef6),MAX(codef7),MAX(codef8) " +
        "          ,MAX(UPPER(c1)),MAX(UPPER(c2)),MAX(UPPER(c3)),MAX(UPPER(c4)),MAX(UPPER(c5)),MAX(UPPER(c6)),MAX(UPPER(c7)),MAX(UPPER(c8))      " +
        "        FROM (SELECT DECODE (code, '01', a.code_nm, '') AS code1,  " +
        "                     DECODE (code, '02', a.code_nm, '') AS code2,  " +
        "                     DECODE (code, '03', a.code_nm, '') AS code3,  " +
        "                     DECODE (code, '04', a.code_nm, '') AS code4,  " +
        "                     DECODE (code, '05', a.code_nm, '') AS code5,  " +
        "                     DECODE (code, '06', a.code_nm, '') AS code6,  " +
        "                     DECODE (code, '07', a.code_nm, '') AS code7,  " +
        "                     DECODE (code, '08', a.code_nm, '') AS code8,  " +
        "                     DECODE (code, '01', a.code_fnm, '') AS codef1,  " +
        "                     DECODE (code, '02', a.code_fnm, '') AS codef2,  " +
        "                     DECODE (code, '03', a.code_fnm, '') AS codef3,  " +
        "                     DECODE (code, '04', a.code_fnm, '') AS codef4,  " +
        "                     DECODE (code, '05', a.code_fnm, '') AS codef5,  " +
        "                     DECODE (code, '06', a.code_fnm, '') AS codef6,  " +
        "                     DECODE (code, '07', a.code_fnm, '') AS codef7,  " +
        "                     DECODE (code, '08', a.code_fnm, '') AS codef8, " +
        "                     DECODE (code, '01', a.CHAR_1, '') AS c1,  " +
        "                     DECODE (code, '02', a.CHAR_1, '') AS c2,  " +
        "                     DECODE (code, '03', a.CHAR_1, '') AS c3,  " +
        "                     DECODE (code, '04', a.CHAR_1, '') AS c4,  " +
        "                     DECODE (code, '05', a.CHAR_1, '') AS c5,  " +
        "                     DECODE (code, '06', a.CHAR_1, '') AS c6,  " +
        "                     DECODE (code, '07', a.CHAR_1, '') AS c7,  " +
        "                     DECODE (code, '08', a.CHAR_1, '') AS c8  " +
        "                FROM vhr_hr_code a  " +
        "               WHERE a.ID = 'HR0118'  ) allow_amt " ;


    DataTable dt_Equip = ESysLib.TableReadOpen(SQL_Equip);
    int irow_Equip;
    irow_Equip = dt_Equip.Rows.Count;
    if (irow_Equip == 0)
    {
        Response.Write("There is no data of allowance");
        Response.End();
    }
    //khai bao bien
     string cur_grp,next_grp;
     
    
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_employee_payroll_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_employee_payroll_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_employee_payroll_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>ty-ml</o:LastAuthor>
  <o:LastPrinted>2008-09-10T02:44:10Z</o:LastPrinted>
  <o:Created>2008-09-06T07:03:32Z</o:Created>
  <o:LastSaved>2008-09-10T06:06:49Z</o:LastSaved>
  <o:Company>genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.28in .19in .41in .2in;
	mso-header-margin:.3in;
	mso-footer-margin:.19in;
	mso-page-orientation:landscape;}
.font8
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font12
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
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
.xl24
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	font-size:25.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl29
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl32
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl56
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl62
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl65
	{mso-style-parent:style0;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl66
	{mso-style-parent:style0;
	font-size:30.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}	
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>25</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:SplitVertical>6</x:SplitVertical>
     <x:LeftColumnRightPane>54</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>7</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
     <%
        int irow=5;
        
        for (int k=0;k<irow_emp;k++)
        {
            irow+=1;
            cur_grp=dt_Emp.Rows[k][0].ToString() ;
            if (k<irow_emp-1)
            {
                
                next_grp=dt_Emp.Rows[k+1][0].ToString();
                if (cur_grp!=next_grp)
                {   irow+=1;
                
                %>
                    <x:RowBreak>
                        <x:Row><%=irow %></x:Row>
                    </x:RowBreak>
                <%
                }
                
            }    
                
        }  
      %>
      
     </x:RowBreaks>
    </x:PageBreaks>
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
  <x:WindowHeight>7935</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl29>

<table x:str border=0 cellpadding=0 cellspacing=0 width=4065 style='border-collapse:
 collapse;table-layout:fixed;width:3050pt'>
 <col class=xl29 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl29 width=92 style='mso-width-source:userset;mso-width-alt:3364;
 width:69pt'>
 <col class=xl29 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl29 width=171 style='mso-width-source:userset;mso-width-alt:6253;
 width:128pt'>
 <col class=xl29 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <%
    if (p_status!="A")
    {
   %>
 <col class=xl29 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <%}
  %>
 <col class=xl29 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 
 <col class=xl29 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt' >
 
 <col class=xl29 width=66 span=2 style='mso-width-source:userset;mso-width-alt:
 2413;width:50pt'>
  <%
        if (dt_Allow.Rows[0][8].ToString()=="1") //xet xem allowance type co hay khong?
        {
    %>
 <col class=xl29 width=71 style='mso-width-source:userset;mso-width-alt:
 2596;width:53pt'>
 <%} %>
  <%
        if (dt_Allow.Rows[0][9].ToString()=="1")
        {
    %>
 <col class=xl29 width=71 style='mso-width-source:userset;mso-width-alt:
 2596;width:53pt'>
 <%} %>
  <%
        if (dt_Allow.Rows[0][10].ToString()=="1")
        {
    %>
 <col class=xl29 width=71 style='mso-width-source:userset;mso-width-alt:
 2596;width:53pt'>
 <%} %>
  <%
        if (dt_Allow.Rows[0][11].ToString()=="1")
        {
    %>
 <col class=xl29 width=71 style='mso-width-source:userset;mso-width-alt:
 2596;width:53pt'>
 <%} %>
  <%
        if (dt_Allow.Rows[0][12].ToString()=="1")
        {
    %>
 <col class=xl29 width=71 style='mso-width-source:userset;mso-width-alt:
 2596;width:53pt'>
 <%} %>
  <%
        if (dt_Allow.Rows[0][13].ToString()=="1")
        {
    %>
 <col class=xl29 width=71 style='mso-width-source:userset;mso-width-alt:
 2596;width:53pt'>
 <%} %>
  <%
        if (dt_Allow.Rows[0][14].ToString()=="1")
        {
    %>
 <col class=xl29 width=71 style='mso-width-source:userset;mso-width-alt:
 2596;width:53pt'>
 <%} %>
  <%
        if (dt_Allow.Rows[0][15].ToString()=="1")
        {
    %>
 <col class=xl29 width=71 style='mso-width-source:userset;mso-width-alt:
 2596;width:53pt'><!--17-->
  <%} %>
 <col class=xl29 width=57 span=2 style='mso-width-source:userset;mso-width-alt:
 2084;width:43pt'>
 <col class=xl29 width=53 span=4 style='mso-width-source:userset;mso-width-alt:
 1938;width:40pt'>
 <col class=xl29 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl29 width=47 span=4 style='mso-width-source:userset;mso-width-alt:
 1718;width:35pt'>
 <col class=xl29 width=49 span=8 style='mso-width-source:userset;mso-width-alt:
 1792;width:37pt'>
 <col class=xl29 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'><!--37-->
 <col class=xl29 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <%
        if (dt_Allowk.Rows[0][0].ToString()!="")
        {
    %>
 <col class=xl29 width=84 style='mso-width-source:userset;mso-width-alt:3072;
 width:63pt'>
 <%} %>
  <%
        if (dt_Allowk.Rows[0][1].ToString()!="")
        {
    %>
 <col class=xl29 width=83 style='mso-width-source:userset;mso-width-alt:
 3035;width:62pt'>
 <%} %>
  <%
        if (dt_Allowk.Rows[0][2].ToString()!="")
        {
    %>
 <col class=xl29 width=83 style='mso-width-source:userset;mso-width-alt:
 3035;width:62pt'>
 <%} %>
  <%
        if (dt_Allowk.Rows[0][3].ToString()!="")
        {
    %>
 <col class=xl29 width=83 style='mso-width-source:userset;mso-width-alt:
 3035;width:62pt'>
 <%} %>
  <%
        if (dt_Allowk.Rows[0][4].ToString()!="")
        {
    %>
 <col class=xl29 width=83 style='mso-width-source:userset;mso-width-alt:
 3035;width:62pt'>
 <%} %>
 <%
        if (dt_Allowk.Rows[0][5].ToString()!="")
        {
    %>
 <col class=xl29 width=83 style='mso-width-source:userset;mso-width-alt:
 3035;width:62pt'>
 <%} %>
 <%
        if (dt_Allowk.Rows[0][6].ToString()!="")
        {
    %>
 <col class=xl29 width=83 style='mso-width-source:userset;mso-width-alt:
 3035;width:62pt'>
 <%} %>
  <%
        if (dt_Allowk.Rows[0][7].ToString()!="")
        {
    %>
 <col class=xl29 width=83 style='mso-width-source:userset;mso-width-alt:
 3035;width:62pt'>
 <%} %>
 
 <col class=xl29 width=99 style='mso-width-source:userset;mso-width-alt:3620;
 width:74pt'>
 <col class=xl29 width=99 style='mso-width-source:userset;mso-width-alt:3620;
 width:74pt'>
 
 <col class=xl29 width=57 style='mso-width-source:userset;mso-width-alt:2084;
 width:43pt'><!--47-->
 <col class=xl29 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <%
    if (p_status!="A")
    {
   %>
 <col class=xl29 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl29 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <%} %>
 <col class=xl29 width=97 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <%
    if (p_status!="A")
    {
   %>
 <col class=xl29 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <%} %>  <!--51 -->
 
 <col class=xl29 width=72 style='mso-width-source:userset;mso-width-alt:
 2633;width:54pt'>
  <col class=xl29 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
  <col class=xl29 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 <col class=xl29 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 <col class=xl29 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 <col class=xl29 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 <%--Kiểm tra hiển thị Equipment--%>
   <%
       if (p_status != "A")
       {
           for (int k = 0; k < 8; k++)
           {
               if (dt_Equip.Rows[0][k + 16].ToString() == "Y")
               {
   %>
  <col class=xl29 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
    <%         }
           }
        }           
    %>
 <col class=xl29 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl29 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl29 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl29 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl29 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl29 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl29 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl29 width=64 style='width:48pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 width=44 style='height:15.75pt;width:33pt' align=left
  valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75" coordsize="21600,21600"
   o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe" filled="f"
   stroked="f">
   <v:stroke joinstyle="miter"/>
   <v:formulas>
    <v:f eqn="if lineDrawn pixelLineWidth 0"/>
    <v:f eqn="sum @0 1 0"/>
    <v:f eqn="sum 0 0 @1"/>
    <v:f eqn="prod @2 1 2"/>
    <v:f eqn="prod @3 21600 pixelWidth"/>
    <v:f eqn="prod @3 21600 pixelHeight"/>
    <v:f eqn="sum @0 0 1"/>
    <v:f eqn="prod @6 1 2"/>
    <v:f eqn="prod @7 21600 pixelWidth"/>
    <v:f eqn="sum @8 21600 0"/>
    <v:f eqn="prod @7 21600 pixelHeight"/>
    <v:f eqn="sum @10 21600 0"/>
   </v:formulas>
   <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
   <o:lock v:ext="edit" aspectratio="t"/>
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:14.25pt;margin-top:7.5pt;width:76.5pt;height:45.75pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_Com.Rows[0][3].ToString()%>&table_name=tco_bpphoto" o:title="vinagenuwin"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:19px;margin-top:10px;width:102px;
  height:61px'><img width=102 height=61
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_Com.Rows[0][3].ToString()%>&table_name=tco_bpphoto" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=21 class=xl29 width=44 style='height:15.75pt;width:33pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl29 width=92 style='width:69pt'></td>
  <td class=xl24 colspan=2 width=242 style='mso-ignore:colspan;width:181pt'><%=dt_Com.Rows[0][0].ToString()%></td>
  <td class=xl29 width=73 style='width:55pt'></td>
  <td class=xl29 width=73 style='width:55pt'></td>
  <td class=xl29 width=77 style='width:58pt'></td>
  <td class=xl29 width=66 style='width:50pt'></td>
  <td class=xl29 width=66 style='width:50pt'></td>
  <td class=xl29 width=71 style='width:53pt'></td>
  <td class=xl29 width=71 style='width:53pt'></td>
  <td class=xl29 width=71 style='width:53pt'></td>
  <td class=xl29 width=71 style='width:53pt'></td>
  <td class=xl29 width=71 style='width:53pt'></td>
  <td class=xl29 width=71 style='width:53pt'></td>
  <td class=xl29 width=71 style='width:53pt'></td>
  <td class=xl29 width=71 style='width:53pt'></td>
  <td class=xl29 width=57 style='width:43pt'></td>
  <td class=xl29 width=53 style='width:40pt'></td>
  <td class=xl29 width=53 style='width:40pt'></td>
  <td class=xl29 width=53 style='width:40pt'></td>
  <td class=xl29 width=53 style='width:40pt'></td>
  <td class=xl29 width=86 style='width:65pt'></td>
  <td class=xl29 width=47 style='width:35pt'></td>
  <td class=xl29 width=47 style='width:35pt'></td>
  <td class=xl29 width=47 style='width:35pt'></td>
  <td class=xl29 width=47 style='width:35pt'></td>
  <td class=xl29 width=49 style='width:37pt'></td>
  <td class=xl28><%if (p_status == "R") { %>RESIGN <%}%> EMPLOYEE'S PAYROLL IN <%=dt_Com.Rows[0][4].ToString()%></td>
  <td class=xl29 width=49 style='width:37pt'></td>
  <td class=xl29 width=49 style='width:37pt'></td>
  <td class=xl29 width=49 style='width:37pt'></td>
  <td class=xl29 width=49 style='width:37pt'></td>
  <td class=xl29 width=49 style='width:37pt'></td>
  <td class=xl29 width=49 style='width:37pt'></td>
  <td class=xl29 width=49 style='width:37pt'></td>
  <td class=xl29 width=74 style='width:56pt'></td>
  <td class=xl29 width=84 style='width:63pt'></td>
  <td class=xl29 width=83 style='width:62pt'></td>
  <td class=xl29 width=83 style='width:62pt'></td>
  <td class=xl29 width=83 style='width:62pt'></td>
  <td class=xl29 width=83 style='width:62pt'></td>
  <td class=xl29 width=83 style='width:62pt'></td>
  <td class=xl29 width=83 style='width:62pt'></td>
  <td class=xl29 width=83 style='width:62pt'></td>
  <td class=xl29 width=99 style='width:74pt'></td>
  <td class=xl29 width=57 style='width:43pt'></td>
  <td class=xl29 width=79 style='width:59pt'></td>
  <td class=xl29 width=63 style='width:47pt'></td>
  <td class=xl29 width=83 style='width:62pt'></td>
  <td class=xl29 width=97 style='width:73pt'></td>
  <td class=xl29 width=73 style='width:55pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=85 style='width:64pt'></td>
  <td class=xl29 width=100 style='width:75pt'></td>
  <td class=xl29 width=89 style='width:67pt'></td>
  <td class=xl29 width=64 style='width:48pt'></td>
 </tr>
 <tr height=34 style='height:25.5pt'>
  <td height=34 colspan=2 class=xl29 style='height:25.5pt;mso-ignore:colspan'></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'><%=dt_Com.Rows[0][1].ToString()%></td>
  <td class=xl29></td>
  <td colspan=14 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl55>BẢNG CHI PHÍ NHÂN CÔNG NGÀY <%=dt_Com.Rows[0][5].ToString()+" "%> </td>
  <td colspan=21 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl25 style='mso-ignore:colspan'></td>
  <td  class=xl25 colspan=2 style='mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";' x:num></td>
  <td class=xl29></td>
 </tr>
 <tr height=35 style='height:26.25pt'>
  <td height=35 colspan=2 class=xl29 style='height:26.25pt;mso-ignore:colspan'></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'>Phone :<span
  style='mso-spacerun:yes'>  </span><%=dt_Com.Rows[0][2].ToString()%></td>
  <td class=xl29></td>
  <td colspan=14 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=29 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
 </tr>
 
 <tr class=xl63 height=46 style='mso-height-source:userset;height:34.5pt'>
  <td rowspan=2 height=92 class=xl41 width=44 style='border-bottom:.5pt solid black;
  height:69.0pt;width:33pt'>No.<br>
    <font class="font8">STT</font></td>
  <td rowspan=2 class=xl41 width=92 style='border-bottom:.5pt solid black;
  width:69pt'>GROUP<br>
    <font class="font8">Nhóm</font></td>
  <td rowspan=2 class=xl41 width=71 style='border-bottom:.5pt solid black;
  width:53pt'>Emp ID<br>
    <font class="font8">Mã NV</font></td>
  <td rowspan=2 class=xl41 width=171 style='border-bottom:.5pt solid black;
  width:128pt'>Full Name<br>
    <font class="font8">H&#7885; và Tên</font></td>
  <td rowspan=2 class=xl41 width=73 style='border-bottom:.5pt solid black;
  width:55pt'>Join Date<br>
    <font class="font8">Ngày vào</font></td>
  <%
    if (p_status!="A")
    {
   %>
  <td rowspan=2 class=xl41 width=73 style='border-bottom:.5pt solid black;
  width:55pt'>Left Date<br>
  
    <font class="font8">Ngày ngh&#7881; vi&#7879;c</font></td>
  <%}%>
  <td rowspan=2 class=xl41 width=77 style='border-bottom:.5pt solid black;
  width:58pt'>Position<br>
      <font class="font8">Ch&#7913;c v&#7909;</font></td>
  
  <td rowspan=2 class=xl41 width=77 style='border-bottom:.5pt solid black;
  width:58pt'>Times<br>
      <font class="font8">Tính lương nghỉ việc</font></td>
  
  <td colspan=2 class=xl61 width=132 style='border-right:.5pt solid black;
  border-left:none;width:100pt'>Salary<br>
    <font class="font8">L&#432;&#417;ng</font></td>
   <%
        if (dt_Allow.Rows[0][8].ToString()=="1")
        {
    %>
  <td rowspan=2 class=xl40 width=71 style='width:53pt'><% =dt_Allow.Rows[0][0].ToString()%><br>
    <font class="font8"><% =dt_Allow.Rows[0][16].ToString()%></font></td>
    <%  } %>
    <%
        if (dt_Allow.Rows[0][9].ToString()=="1")
        {
    %>
  <td rowspan=2 class=xl40 width=71 style='width:53pt'><% =dt_Allow.Rows[0][1].ToString()%><br>
    <font class="font8"><% =dt_Allow.Rows[0][17].ToString()%></font></td>
   <%  } %>
   <%
        if (dt_Allow.Rows[0][10].ToString()=="1")
        {
    %>
  <td rowspan=2 class=xl40 width=71 style='width:53pt'><% =dt_Allow.Rows[0][2].ToString()%><br>
    <font class="font8"><% =dt_Allow.Rows[0][18].ToString()%></font></td>
    <% } %>
    <%
        if (dt_Allow.Rows[0][11].ToString()=="1")
        {
    %>
  <td rowspan=2 class=xl40 width=71 style='width:53pt'><% =dt_Allow.Rows[0][3].ToString()%><br>
    <font class="font8"><% =dt_Allow.Rows[0][19].ToString()%></font></td>
    <%} %>
    <%
        if (dt_Allow.Rows[0][12].ToString()=="1")
        {
    %>
  <td rowspan=2 class=xl40 width=71 style='width:53pt'><% =dt_Allow.Rows[0][4].ToString()%><br>
    <font class="font8"><% =dt_Allow.Rows[0][20].ToString()%></font></td>
    <%} %>
    <%
        if (dt_Allow.Rows[0][13].ToString()=="1")
        {
    %>
  <td rowspan=2 class=xl40 width=71 style='width:53pt'><% =dt_Allow.Rows[0][5].ToString()%><br>
    <font class="font8"><% =dt_Allow.Rows[0][21].ToString()%></font></td>
    <%} %>
    <%
        if (dt_Allow.Rows[0][14].ToString()=="1")
        {
    %>
  <td rowspan=2 class=xl40 width=71 style='width:53pt'><% =dt_Allow.Rows[0][6].ToString()%><br>
    <font class="font8"><% =dt_Allow.Rows[0][22].ToString()%></font></td>
    <%} %>
    <%
        if (dt_Allow.Rows[0][15].ToString()=="1")
        {
    %>
  <td rowspan=2 class=xl40 width=71 style='width:53pt'><% =dt_Allow.Rows[0][7].ToString()%><br>
    <font class="font8"><% =dt_Allow.Rows[0][23].ToString()%></font></td>
    <%} %>
  <td colspan=2 class=xl47 width=114 style='border-left:none;width:86pt'>Working
  Days<br>
    <font class="font8">Ngày công</font></td>
  <td colspan=2 class=xl47 width=106 style='border-left:none;width:80pt'>ALE
  Absence<br>
    <font class="font8">Ngh&#7881; phép n&#259;m</font></td>
  <td colspan=2 class=xl47 width=106 style='border-left:none;width:80pt'>Other
  Absence<br>
    <font class="font8">Ngh&#7881; khác</font></td>
  <td rowspan=2 class=xl41 width=86 style='border-bottom:.5pt solid black;
  width:65pt'>Working Salary<br>
    <font class="font8">L&#432;&#417;ng ngày công</font></td>
  <td colspan=2 class=xl47 width=94 style='border-left:none;width:70pt'>OT
  Hours<br>
    <font class="font8">Gi&#7901; T.C</font></td>
  <td colspan=2 class=xl47 width=94 style='border-left:none;width:70pt'>HT
  Hours<br>
    <font class="font8">T.C l&#7877;</font></td>
  <td colspan=2 class=xl47 width=98 style='border-left:none;width:74pt'>NT
  30%<br>
    <font class="font8">Tr&#7907; c&#7845;p &#273;êm</font></td>
  <td colspan=2 class=xl47 width=98 style='border-left:none;width:74pt'>NT
  45%<br>
    <font class="font8">Tr&#7907; c&#7845;p &#273;êm</font></td>
  <td colspan=2 class=xl47 width=98 style='border-left:none;width:74pt'>NT
  60%<br>
    <font class="font8">Tr&#7907; c&#7845;p &#273;êm</font></td>
  <td colspan=2 class=xl47 width=98 style='border-left:none;width:74pt'>NT
  90%<br>
    <font class="font8">Tr&#7907; c&#7845;p &#273;êm</font></td>
  <td rowspan=2 class=xl41 width=74 style='border-bottom:.5pt solid black;
  width:56pt'>OT Salary<br>
  <td rowspan=2 class=xl41 width=74 style='border-bottom:.5pt solid black;
  width:56pt'>OT (100%)<br>
    <font class="font8">L&#432;&#417;ng t&#259;ng ca</font></td>
  <%
        if (dt_Allowk.Rows[0][0].ToString()!="") //kiem tra xem co cac loai tro cap khong co dinh khong?
        {
    %>  
  <td rowspan=2 class=xl40 width=84 style='width:63pt'><%=dt_Allowk.Rows[0][0].ToString() %>
    </td>
    <%} %>
    <%
        if (dt_Allowk.Rows[0][1].ToString()!="") //kiem tra xem co cac loai tro cap khong co dinh khong?
        {
    %>  
  <td rowspan=2 class=xl40 width=83 style='width:62pt'><%=dt_Allowk.Rows[0][1].ToString() %>
    </td>
    <%} %>
  <%
        if (dt_Allowk.Rows[0][2].ToString()!="") //kiem tra xem co cac loai tro cap khong co dinh khong?
        {
    %>  
  <td rowspan=2 class=xl40 width=83 style='width:62pt'><%=dt_Allowk.Rows[0][2].ToString() %>
   </td>
    <%} %>
  <%
        if (dt_Allowk.Rows[0][3].ToString()!="") //kiem tra xem co cac loai tro cap khong co dinh khong?
        {
    %>  
  <td rowspan=2 class=xl40 width=83 style='width:62pt'><%=dt_Allowk.Rows[0][3].ToString() %>
    </td>
    <%} %>
  <%
        if (dt_Allowk.Rows[0][4].ToString()!="") //kiem tra xem co cac loai tro cap khong co dinh khong?
        {
    %>  
  <td rowspan=2 class=xl40 width=83 style='width:62pt'><%=dt_Allowk.Rows[0][4].ToString() %>
    </td>
    <%} %>
 <%
        if (dt_Allowk.Rows[0][5].ToString()!="") //kiem tra xem co cac loai tro cap khong co dinh khong?
        {
    %>  
  <td rowspan=2 class=xl40 width=83 style='width:62pt'><%=dt_Allowk.Rows[0][5].ToString() %>
    </td>
    <%} %>
  <%
        if (dt_Allowk.Rows[0][6].ToString()!="") //kiem tra xem co cac loai tro cap khong co dinh khong?
        {
    %>  
  <td rowspan=2 class=xl40 width=83 style='width:62pt'><%=dt_Allowk.Rows[0][6].ToString() %>
   </td>
    <%} %>
  <%
        if (dt_Allowk.Rows[0][7].ToString()!="") //kiem tra xem co cac loai tro cap khong co dinh khong?
        {
    %>  
  <td rowspan=2 class=xl40 width=83 style='width:62pt'><%=dt_Allowk.Rows[0][7].ToString() %>
    </td>
    <%} %>
  <td rowspan=2 class=xl46 width=99 style='width:74pt'>Other Compensation<br>
    <font class="font12">Hoàn tr&#7843; khác</font></td>
  <td rowspan=2 class=xl46 width=99 style='width:74pt'>Incentive<br>
    <font class="font12">Thưởng</font></td>   
  <td colspan=2 class=xl47 width=136 style='border-left:none;width:102pt'>Remain ALE<br>
    <font class="font8">Phép n&#259;m còn l&#7841;i<span
  style='mso-spacerun:yes'> </span></font></td>
  <%
    if (p_status!="A")
    {
   %>
  <td colspan=2 class=xl47 width=146 style='border-left:none;width:109pt'>Severance<br>
    <font class="font8">Tr&#7907; c&#7845;p thôi vi&#7879;c</font></td>
   <%}
    %>
  <td rowspan=2 class=xl47 width=97 style='width:73pt'>Total Income<br>
    <font class="font8">T&#7893;ng thu nh&#7853;p</font></td>
  <%
    if (p_status!="A")
    {
   %>  
  <td rowspan=2 class=xl41 width=73 style='border-bottom:.5pt solid black;
  width:55pt'>Break Contract<br>
    <font class="font8">Vi ph&#7841;m h&#7907;p &#273;&#7891;ng</font></td>
    <%} %>
  <td rowspan=2 class=xl46 width=72 style='width:54pt'>Other Deduction<br>
    <font class="font12">Tr&#7915; khác</font></td>
    <td rowspan=2 class=xl46 width=72 style='width:54pt'>Deduct PIT<br>
    <font class="font12">Giảm trừ thuế</font></td>
    <td rowspan=2 class=xl46 width=72 style='width:54pt'>Income Pay Tax<br>
    <font class="font12">Thu nhập chịu thuế</font></td>
  <td rowspan=2 class=xl46 width=72 style='width:54pt'>Income Before Tax<br>
    <font class="font12">Thu nhập trước thuế</font></td>
  <td rowspan=2 class=xl46 width=72 style='width:54pt'>Income Tax<br>
    <font class="font12">Thu&#7871; thu nh&#7853;p</font></td>
  <td rowspan=2 class=xl47 width=85 style='width:64pt'>Union AMT<br>
    <font class="font8">Ti&#7873;n công &#273;oàn</font></td>
    <%--Kiểm tra hiển thị Equipment--%>
   <%
       if (p_status != "A")
       {
           for (int k = 0; k < 8; k++)
           {
               if (dt_Equip.Rows[0][k + 16].ToString() == "Y")
               {
   %>
  <td rowspan=2 class=xl47 width=85 style='width:64pt'><%= dt_Equip.Rows[0][k].ToString()%><br>
    <font class="font8"><%= dt_Equip.Rows[0][k + 8].ToString()%></font></td>
    <%
               }
           }
        }           
    %>
   <td rowspan=2 class=xl47 width=100 style='width:75pt'>Insurance (SI)<br>
    <font class="font8">Bảo hiểm XH</font></td>
   <td rowspan=2 class=xl47 width=100 style='width:75pt'>Insurance (HI)<br>
    <font class="font8">Bảo hiểm YT</font></td> 
<td rowspan=2 class=xl47 width=100 style='width:75pt'>Insurance (UI)<br>
<font class="font8">Bảo hiểm TN</font></td>
  <td rowspan=2 class=xl46 width=99 style='width:74pt'>Other Compensation (No PIT)<br>
    <font class="font12">Hoàn tr&#7843; khác</font></td>
  <td rowspan=2 class=xl46 width=72 style='width:54pt'>Other Deduction (No PIT)<br>
    <font class="font12">Tr&#7915; khác</font></td>
  <td rowspan=2 class=xl47 width=89 style='width:67pt'>Salary Total<br>
    <font class="font8">Th&#7921;c lãnh</font></td>
  <td rowspan=2 class=xl47 width=89 style='width:67pt'>Sign<br>
    <font class="font8">Ký nhận</font></td>
 </tr>
 <tr class=xl63 height=46 style='mso-height-source:userset;height:34.5pt'>
  <td height=46 class=xl64 width=66 style='height:34.5pt;border-top:none;
  border-left:none;width:50pt'>PRO<br>
    <font class="font14">TV</font></td>
  <td class=xl64 width=66 style='border-top:none;border-left:none;width:50pt'>OFF<br>
    <font class="font14">CT</font></td>
  <td class=xl64 width=57 style='border-top:none;border-left:none;width:43pt'>PRO<br>
    <font class="font14">TV</font></td>
  <td class=xl64 width=57 style='border-top:none;border-left:none;width:43pt'>OFF<br>
    <font class="font14">CT</font></td>
  <td class=xl64 width=53 style='border-top:none;border-left:none;width:40pt'>PRO<br>
    <font class="font14">TV</font></td>
  <td class=xl64 width=53 style='border-top:none;border-left:none;width:40pt'>OFF<br>
    <font class="font14">CT</font></td>
  <td class=xl64 width=53 style='border-top:none;border-left:none;width:40pt'>PRO<br>
    <font class="font14">TV</font></td>
  <td class=xl64 width=53 style='border-top:none;border-left:none;width:40pt'>OFF<br>
    <font class="font14">CT</font></td>
  <td class=xl64 width=47 style='border-top:none;border-left:none;width:35pt'>PRO<br>
    <font class="font14">TV</font></td>
  <td class=xl64 width=47 style='border-top:none;border-left:none;width:35pt'>OFF<br>
    <font class="font14">CT</font></td>
  <td class=xl64 width=47 style='border-top:none;border-left:none;width:35pt'>PRO<br>
    <font class="font14">TV</font></td>
  <td class=xl64 width=47 style='border-top:none;border-left:none;width:35pt'>OFF<br>
    <font class="font14">CT</font></td>
  <td class=xl64 width=49 style='border-top:none;border-left:none;width:37pt'>PRO<br>
    <font class="font14">TV</font></td>
  <td class=xl64 width=49 style='border-top:none;border-left:none;width:37pt'>OFF<br>
    <font class="font14">CT</font></td>
  <td class=xl64 width=49 style='border-top:none;border-left:none;width:37pt'>PRO<br>
    <font class="font14">TV</font></td>
  <td class=xl64 width=49 style='border-top:none;border-left:none;width:37pt'>OFF<br>
    <font class="font14">CT</font></td>
  <td class=xl64 width=49 style='border-top:none;border-left:none;width:37pt'>PRO<br>
    <font class="font14">TV</font></td>
  <td class=xl64 width=49 style='border-top:none;border-left:none;width:37pt'>OFF<br>
    <font class="font14">CT</font></td>
  <td class=xl64 width=49 style='border-top:none;border-left:none;width:37pt'>PRO<br>
    <font class="font14">TV</font></td>
  <td class=xl64 width=49 style='border-top:none;border-left:none;width:37pt'>OFF<br>
    <font class="font14">CT</font></td>
  
  <td class=xl27 width=57 style='border-left:none;width:43pt'>Days <br>
    <font class="font8">Ngày</font></td>
  <td class=xl27 width=79 style='border-left:none;width:59pt'>Salary <br>
    <font class="font8">Ti&#7873;n</font></td>
  <%
    if (p_status!="A")
    {
   %>  
  <td class=xl27 width=63 style='border-left:none;width:47pt'>Months<br>
    <font class="font8">Tháng</font></td>
  <td class=xl27 width=83 style='border-left:none;width:62pt'>Salary <br>
    <font class="font8">Ti&#7873;n</font></td>
   <%
   }
    %>
 </tr>
 <%
    int i;
    double[] Group_Total=new double[70];
    double[] Group_GTotal=new double[70];
    int ino=0;
    Boolean bTotal=false;
    for (int j = 0; j < 70; j++)
    {
        Group_Total[j] = 0;
        Group_GTotal[j] = 0;
    }
    
    for (i=0;i<irow_emp;i++)
    {
        ino+=1;
        for (int j=6;j<icol_emp;j++)
        {
            Group_Total[j-6]+=Double.Parse(dt_Emp.Rows[i][j].ToString());
            Group_GTotal[j-6]+=Double.Parse(dt_Emp.Rows[i][j].ToString());
        }
        Group_Total[69] += Double.Parse(dt_Emp.Rows[i][74].ToString());//group total UI
        Group_GTotal[69] += Double.Parse(dt_Emp.Rows[i][74].ToString());//grand tatal UI
  %>
 <tr class=xl36 height=46 style='mso-height-source:userset;height:34.5pt'>
  <td height=46 class=xl32 style='height:34.5pt' x:num><%=ino %></td>
  <td class=xl33 ><%=dt_Emp.Rows[i][0].ToString()%></td>
  <td class=xl32  ><%=dt_Emp.Rows[i][1].ToString()%></td>
  <td class=xl33  ><%=dt_Emp.Rows[i][2].ToString()%><span style='mso-spacerun:yes'> </span></td>
  <td class=xl39><%=dt_Emp.Rows[i][3].ToString()%></td>
  <%
    if (p_status!="A")
    {
   %>
  <td class=xl39><%=dt_Emp.Rows[i][4].ToString()%></td>
  <%} %>
  <td class=xl33 ><%=dt_Emp.Rows[i][5].ToString()%></td>
   <td class=xl33 ><%=dt_Emp.Rows[i][73].ToString()%></td>
  <td class=xl34  x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][6].ToString()%></td>
      
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][7].ToString()%> </td>
  <%
        if (dt_Allow.Rows[0][8].ToString()=="1")
        {
    %>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][8].ToString()%></td>
  <%} %>
  <%
        if (dt_Allow.Rows[0][9].ToString()=="1")
        {
    %>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][9].ToString()%></td>
  <%} %>
  <%
        if (dt_Allow.Rows[0][10].ToString()=="1")
        {
    %>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][10].ToString()%></td>
  <%} %>
  <%
        if (dt_Allow.Rows[0][11].ToString()=="1")
        {
    %>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][11].ToString()%></td>
  <%} %>
  <%
        if (dt_Allow.Rows[0][12].ToString()=="1")
        {
    %>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][12].ToString()%></td>
  <%} %>
  <%
        if (dt_Allow.Rows[0][13].ToString()=="1")
        {
    %>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][13].ToString()%></td>
  <%} %>
  <%
        if (dt_Allow.Rows[0][14].ToString()=="1")
        {
    %>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][14].ToString()%></td>
  <%} %>
  <%
        if (dt_Allow.Rows[0][15].ToString()=="1")
        {
    %>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][15].ToString()%></td>
  <%} %>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][16].ToString()%></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][17].ToString()%></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][18].ToString()%></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][19].ToString()%></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][20].ToString()%></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][21].ToString()%></td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][22].ToString()%></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][23].ToString()%></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][24].ToString()%></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][25].ToString()%></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][26].ToString()%></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][27].ToString()%></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][28].ToString()%></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][29].ToString()%></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][30].ToString()%></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][31].ToString()%></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][32].ToString()%></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][33].ToString()%></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][34].ToString()%></td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][35].ToString()%> </td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][61].ToString()%> </td>  <!-- them vao-->
  <%
        if (dt_Allowk.Rows[0][0].ToString()!="") //kiem tra xem co cac loai tro cap khong co dinh khong?
        {
    %>  
 
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][36].ToString()%> </td>
  <%} %>
  <%
        if (dt_Allowk.Rows[0][1].ToString()!="") //kiem tra xem co cac loai tro cap khong co dinh khong?
        {
    %>  
 <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][37].ToString()%> </td>
  <%} %>
  <%
        if (dt_Allowk.Rows[0][2].ToString()!="") //kiem tra xem co cac loai tro cap khong co dinh khong?
        {
    %>  
 <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][38].ToString()%> </td>
  <%} %>
   <%
        if (dt_Allowk.Rows[0][3].ToString()!="") //kiem tra xem co cac loai tro cap khong co dinh khong?
        {
    %>  
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][39].ToString()%> </td>
  <%} %>
   <%
        if (dt_Allowk.Rows[0][4].ToString()!="") //kiem tra xem co cac loai tro cap khong co dinh khong?
        {
    %>  
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][40].ToString()%> </td>
  <%} %>
   <%
        if (dt_Allowk.Rows[0][5].ToString()!="") //kiem tra xem co cac loai tro cap khong co dinh khong?
        {
    %>  
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][41].ToString()%> </td>
  <%} %>
   <%
        if (dt_Allowk.Rows[0][6].ToString()!="") //kiem tra xem co cac loai tro cap khong co dinh khong?
        {
    %>  
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][42].ToString()%> </td>
  <%} %>
  <%
        if (dt_Allowk.Rows[0][7].ToString()!="") //kiem tra xem co cac loai tro cap khong co dinh khong?
        {
    %>  
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][43].ToString()%> </td>
  <%} %>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][44].ToString()%> </td>
   <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][63].ToString()%> </td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][45].ToString()%> </td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][46].ToString()%> </td>
  <%
    if (p_status!="A")
    {
   %>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][47].ToString()%> </td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][48].ToString()%> </td>
  <%
  }
   %>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][49].ToString()%> </td>
  <%
    if (p_status!="A")
    {
   %>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][50].ToString()%> </td>
  <%} %>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][51].ToString()%> </td>
   <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][59].ToString()%> </td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][60].ToString()%> </td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][52].ToString()%> </td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][53].ToString()%> </td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][54].ToString()%> </td>
  <%--Kiểm tra hiển thị Equipment--%>
   <%
       if (p_status != "A")
       {
           for (int k = 0; k < 2; k++)
           {
               if (dt_Equip.Rows[0][k + 16].ToString() == "Y")
               {
   %>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_Emp.Rows[i][k + 64].ToString()%> </td>
  
    <%
               }
           }
        }           
    %>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][55].ToString()%> </td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][62].ToString()%> </td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][74].ToString()%> </td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][56].ToString()%> </td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][57].ToString()%> </td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][58].ToString()%> </td>
  
  <td class=xl34></td>
  
 </tr>
 <%
        cur_grp=dt_Emp.Rows[i][0].ToString() ;
        if (i<irow_emp-1)
        {
            
            next_grp=dt_Emp.Rows[i+1][0].ToString();
            if (cur_grp!=next_grp)
                bTotal=true;
        }    
        else
        {
                bTotal=true;
        }
  %>
  <%
        if (bTotal==true)
        {
   %>
 <tr class=xl30 height=46 style='mso-height-source:userset;height:34.5pt'>
  <td colspan=4 height=46 class=xl43 style='border-right:.5pt solid black;
  height:34.5pt'>Total <%=cur_grp %></td>
  <td class=xl56 >&nbsp;</td>
  <%
    if (p_status!="A")
    {
   %>
  <td class=xl56 >&nbsp;</td>
  <%} %>
  <td class=xl56>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl59  x:num><%=Group_Total[0] %></td>
  
  <td class=xl59  x:num><%=Group_Total[1] %></td>
  <%
        if (dt_Allow.Rows[0][8].ToString()=="1")
        {
    %>
  <td class=xl59 x:num><%=Group_Total[2] %></td>
  <%} %>
  <%
        if (dt_Allow.Rows[0][9].ToString()=="1")
        {
    %>
<td class=xl59 x:num><%=Group_Total[3] %></td>
  <%} %>
  <%
        if (dt_Allow.Rows[0][10].ToString()=="1")
        {
    %>
  <td class=xl59 x:num><%=Group_Total[4] %></td>
  <%} %>
  <%
        if (dt_Allow.Rows[0][11].ToString()=="1")
        {
    %>
  <td class=xl59 x:num><%=Group_Total[5] %></td>
  <%} %>
  <%
        if (dt_Allow.Rows[0][12].ToString()=="1")
        {
    %>
    <td class=xl59 x:num><%=Group_Total[6] %></td>
  <%} %>
  <%
        if (dt_Allow.Rows[0][13].ToString()=="1")
        {
    %>
<td class=xl59 x:num><%=Group_Total[7] %></td>
  <%} %>
  <%
        if (dt_Allow.Rows[0][14].ToString()=="1")
        {
    %>
 <td class=xl59 x:num><%=Group_Total[8] %></td>
  <%} %>
  <%
        if (dt_Allow.Rows[0][15].ToString()=="1")
        {
    %>
   <td class=xl59 x:num><%=Group_Total[9] %></td>
  <%} %>
  <td class=xl60 x:num><%=Group_Total[10] %></td>
  <td class=xl60 x:num><%=Group_Total[11] %></td>
 <td class=xl60  x:num><%=Group_Total[12] %></td>
  <td class=xl60  x:num><%=Group_Total[13] %></td>
  <td class=xl60  x:num><%=Group_Total[14] %></td>
  <td class=xl60  x:num><%=Group_Total[15] %></td>
  <td class=xl59  x:num><%=Group_Total[16] %></td>
  <td class=xl60  x:num><%=Group_Total[17] %></td>
  <td class=xl60  x:num><%=Group_Total[18] %></td>
  <td class=xl60  x:num><%=Group_Total[19] %></td>
  <td class=xl60 x:num><%=Group_Total[20] %></td>
  <td class=xl60  x:num><%=Group_Total[21] %></td>
  <td class=xl60  x:num><%=Group_Total[22] %></td>
  <td class=xl60 x:num><%=Group_Total[23] %></td>
  <td class=xl60 x:num><%=Group_Total[24] %></td>
  <td class=xl60 x:num><%=Group_Total[25] %></td>
  <td class=xl60  x:num><%=Group_Total[26] %></td>
  <td class=xl60  x:num><%=Group_Total[27] %></td>
  <td class=xl60  x:num><%=Group_Total[28] %></td>
  <td class=xl59  x:num><%=Group_Total[29] %></td>
  <td class=xl59  x:num><%=Group_Total[55] %></td>
    <%
        if (dt_Allowk.Rows[0][0].ToString()!="")
        {
    %>
    <td class=xl59 x:num><%=Group_Total[30] %></td>
  <%} %>
    <%
        if (dt_Allowk.Rows[0][1].ToString()!="")
        {
    %>
   <td class=xl59  x:num><%=Group_Total[31] %></td>
  <%} %>
    <%
        if (dt_Allowk.Rows[0][2].ToString()!="")
        {
    %>
  <td class=xl59 x:num><%=Group_Total[32] %></td>
  <%} %>
    <%
        if (dt_Allowk.Rows[0][3].ToString()!="")
        {
    %>
 <td class=xl59  x:num><%=Group_Total[33] %></td>
  <%} %>
    <%
        if (dt_Allowk.Rows[0][4].ToString()!="")
        {
    %>
 <td class=xl59  x:num><%=Group_Total[34] %></td>
  <%} %>
    <%
        if (dt_Allowk.Rows[0][5].ToString()!="")
        {
    %>
  <td class=xl59 x:num><%=Group_Total[35] %></td>
  <%} %>
    <%
        if (dt_Allowk.Rows[0][6].ToString()!="")
        {
    %>
 <td class=xl59  x:num><%=Group_Total[36] %></td>
  <%} %>
  <%
        if (dt_Allowk.Rows[0][7].ToString()!="")
        {
    %>
   <td class=xl59 x:num><%=Group_Total[37] %></td>
  <%} %>
  <td class=xl59  x:num><%=Group_Total[38] %></td>
   <td class=xl59  x:num><%=Group_Total[57] %></td>
   
  <td class=xl60  x:num><%=Group_Total[39] %></td>
  <td class=xl59 x:num><%=Group_Total[40] %></td>
  <%
    if (p_status!="A")
    {
   %>
  <td class=xl60 x:num><%=Group_Total[41] %></td>
   <td class=xl59 x:num><%=Group_Total[42] %></td>
   
  <%}
   %>
   <td class=xl59  x:num><%=Group_Total[43] %></td>
  <%
    if (p_status!="A")
    {
   %>
   <td class=xl59  x:num><%=Group_Total[44] %></td>
 
  <%} %>
   <td class=xl59 x:num><%=Group_Total[45] %></td>
   <td class=xl59  x:num><%=Group_Total[53] %></td>
  <td class=xl59  x:num><%=Group_Total[54] %></td>
  <td class=xl59 x:num><%=Group_Total[46] %></td>
  <td class=xl59 x:num><%=Group_Total[47] %></td>
  <td class=xl59  x:num><%=Group_Total[48] %></td>
  <%--Kiểm tra hiển thị Equipment--%>
   <%
       if (p_status != "A")
       {
           for (int k = 0; k < 8; k++)
           {
               if (dt_Equip.Rows[0][k + 16].ToString() == "Y")
               {
   %>
  <td class=xl59  x:num><%=Group_Total[k + 58]%></td>
    <%
               }
           }
        }           
    %>
  <td class=xl59  x:num><%=Group_Total[49] %></td>
  <td class=xl59 x:num><%=Group_Total[56] %></td>
  <td class=xl59 x:num><%=Group_Total[69] %></td>
  <td class=xl59  x:num><%=Group_Total[50] %></td>
  <td class=xl59  x:num><%=Group_Total[51] %></td>
  <td class=xl59  x:num><%=Group_Total[52] %></td>
  <td class=xl59></td>
 </tr>
 <%
        bTotal=false;
        ino=0;
            for (int l=6;l<icol_emp;l++)
            {
                Group_Total[l-6]=0;
            }
            Group_Total[69] = 0;
        }
  %>
 <%
    }
  %>
<tr class=xl30 height=46 style='mso-height-source:userset;height:34.5pt'>
  <td colspan=4 height=46 class=xl43 style='border-right:.5pt solid black;
  height:34.5pt'>Grant Total: <%=irow_emp %> Employee(s)</td>
  <td class=xl56 >&nbsp;</td>
<%
    if (p_status!="A")
    {
   %>
  <td class=xl56 >&nbsp;</td>
  <%} %>
  <td class=xl56>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl59  x:num><%=Group_GTotal[0] %></td>
  
  <td class=xl59  x:num><%=Group_GTotal[1] %></td>
  <%
        if (dt_Allow.Rows[0][8].ToString()=="1")
        {
    %>
  <td class=xl59 x:num><%=Group_GTotal[2] %></td>
  <%} %>
  <%
        if (dt_Allow.Rows[0][9].ToString()=="1")
        {
    %>
<td class=xl59 x:num><%=Group_GTotal[3] %></td>
  <%} %>
  <%
        if (dt_Allow.Rows[0][10].ToString()=="1")
        {
    %>
  <td class=xl59 x:num><%=Group_GTotal[4] %></td>
  <%} %>
  <%
        if (dt_Allow.Rows[0][11].ToString()=="1")
        {
    %>
  <td class=xl59 x:num><%=Group_GTotal[5] %></td>
  <%} %>
  <%
        if (dt_Allow.Rows[0][12].ToString()=="1")
        {
    %>
    <td class=xl59 x:num><%=Group_GTotal[6] %></td>
  <%} %>
  <%
        if (dt_Allow.Rows[0][13].ToString()=="1")
        {
    %>
<td class=xl59 x:num><%=Group_GTotal[7] %></td>
  <%} %>
  <%
        if (dt_Allow.Rows[0][14].ToString()=="1")
        {
    %>
 <td class=xl59 x:num><%=Group_GTotal[8] %></td>
  <%} %>
  <%
        if (dt_Allow.Rows[0][15].ToString()=="1")
        {
    %>
   <td class=xl59 x:num><%=Group_GTotal[9] %></td>
  <%} %>
   <td class=xl60 x:num><%=Group_GTotal[10] %></td>
   <td class=xl60 x:num><%=Group_GTotal[11] %></td>
 <td class=xl60  x:num><%=Group_GTotal[12] %></td>
  <td class=xl60  x:num><%=Group_GTotal[13] %></td>
  <td class=xl60  x:num><%=Group_GTotal[14] %></td>
  <td class=xl60  x:num><%=Group_GTotal[15] %></td>
  <td class=xl59  x:num><%=Group_GTotal[16] %></td>
  <td class=xl60  x:num><%=Group_GTotal[17] %></td>
  <td class=xl60  x:num><%=Group_GTotal[18] %></td>
  <td class=xl60  x:num><%=Group_GTotal[19] %></td>
  <td class=xl60 x:num><%=Group_GTotal[20] %></td>
  <td class=xl60  x:num><%=Group_GTotal[21] %></td>
  <td class=xl60  x:num><%=Group_GTotal[22] %></td>
  <td class=xl60 x:num><%=Group_GTotal[23] %></td>
  <td class=xl60 x:num><%=Group_GTotal[24] %></td>
  <td class=xl60 x:num><%=Group_GTotal[25] %></td>
  <td class=xl60  x:num><%=Group_GTotal[26] %></td>
  <td class=xl60  x:num><%=Group_GTotal[27] %></td>
  <td class=xl60  x:num><%=Group_GTotal[28] %></td>
  <td class=xl59  x:num><%=Group_GTotal[29] %></td>
  <td class=xl59  x:num><%=Group_GTotal[55] %></td>
    <%
        if (dt_Allowk.Rows[0][0].ToString()!="")
        {
    %>
    <td class=xl59 x:num><%=Group_GTotal[30] %></td>
  <%} %>
    <%
        if (dt_Allowk.Rows[0][1].ToString()!="")
        {
    %>
   <td class=xl59  x:num><%=Group_GTotal[31] %></td>
  <%} %>
    <%
        if (dt_Allowk.Rows[0][2].ToString()!="")
        {
    %>
  <td class=xl59 x:num><%=Group_GTotal[32] %></td>
  <%} %>
    <%
        if (dt_Allowk.Rows[0][3].ToString()!="")
        {
    %>
 <td class=xl59  x:num><%=Group_GTotal[33] %></td>
  <%} %>
    <%
        if (dt_Allowk.Rows[0][4].ToString()!="")
        {
    %>
 <td class=xl59  x:num><%=Group_GTotal[34] %></td>
  <%} %>
    <%
        if (dt_Allowk.Rows[0][5].ToString()!="")
        {
    %>
  <td class=xl59 x:num><%=Group_GTotal[35] %></td>
  <%} %>
    <%
        if (dt_Allowk.Rows[0][6].ToString()!="")
        {
    %>
 <td class=xl59  x:num><%=Group_GTotal[36] %></td>
  <%} %>
  <%
        if (dt_Allowk.Rows[0][7].ToString()!="")
        {
    %>
   <td class=xl59 x:num><%=Group_GTotal[37] %></td>
  <%} %>
  <td class=xl59  x:num><%=Group_GTotal[38] %></td>
  <td class=xl59  x:num><%=Group_GTotal[57] %></td>
  <td class=xl60  x:num><%=Group_GTotal[39] %></td>
  <td class=xl59 x:num><%=Group_GTotal[40] %></td>
  <%
    if (p_status!="A")
    {
   %>
   <td class=xl60 x:num><%=Group_GTotal[41] %></td>
   <td class=xl59 x:num><%=Group_GTotal[42] %></td>
   
  <%}
   %>
   <td class=xl59  x:num><%=Group_GTotal[43] %></td>
  <%
    if (p_status!="A")
    {
   %>
   <td class=xl59  x:num><%=Group_GTotal[44] %></td>
 
  <%} %>
   <td class=xl59 x:num><%=Group_GTotal[45] %></td>
   <td class=xl59  x:num><%=Group_GTotal[53] %></td>
  <td class=xl59  x:num><%=Group_GTotal[54] %></td>
  <td class=xl59 x:num><%=Group_GTotal[46] %></td>
  <td class=xl59 x:num><%=Group_GTotal[47] %></td>
  <td class=xl59  x:num><%=Group_GTotal[48] %></td>
  <%--Kiểm tra hiển thị Equipment--%>
   <%
       if (p_status != "A")
       {
           for (int k = 0; k < 8; k++)
           {
               if (dt_Equip.Rows[0][k + 16].ToString() == "Y")
               {
   %>
  <td class=xl59  x:num><%=Group_GTotal[k + 58]%></td>
    <%
               }
           }
        }           
    %>
  <td class=xl59  x:num><%=Group_GTotal[49] %></td>
  <td class=xl59 x:num><%=Group_GTotal[56] %></td>
  <td class=xl59 x:num><%=Group_GTotal[69] %></td>
  <td class=xl59  x:num><%=Group_GTotal[50] %></td>
  <td class=xl59  x:num><%=Group_GTotal[51] %></td>
  <td class=xl59  x:num><%=Group_GTotal[52] %></td>
  <td class=xl59></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=2 class=xl66 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=56 class=xl66 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=2 class=xl66 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=56 class=xl66 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=15 class=xl66 >Prepared by</td>
  <td height=25 colspan=18 class=xl66 >Checked by</td>
  <td colspan=15 class=xl66 >Approved by</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  
 </tr>
 <![endif]>
</table>

</body>

</html>