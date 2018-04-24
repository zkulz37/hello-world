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
    //string p_from="200807", p_to="200808";
    string p_org = Request.QueryString[0].ToString();
    string p_wg = Request.QueryString[1].ToString();
    string p_status = Request.QueryString[2].ToString();
    string p_emp_id = Request.QueryString[3].ToString();
    string p_money_type = Request.QueryString[4].ToString();
    string p_pay_type = Request.QueryString[5].ToString();
    string p_type = Request.QueryString[6].ToString();
    string p_from = Request.QueryString[7].ToString();
    string p_to = Request.QueryString[8].ToString();
string SQL_Com
    = "select  a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,a.TCO_BPPHOTO_PK,to_char(to_date('" + p_from + "','yyyymm'),'MON-YYYY'),to_char(to_date('" + p_from + "','yyyymm'),'MM-YYYY') " + 
        "from tco_company a " +
        "where a.DEL_IF=0 " +
        "and a.pk in ( select tco_company_pk from  " +
        "               comm.tco_org  f " +
        "               where  f.pk IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM comm.tco_org g " +
        "                                   WHERE g.del_if = 0 " +        
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_org + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_org + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_org + "' = 'ALL') " +
        "and rownum=1 " ;

    //Response.Write(SQL_Com);
    //Response.End();
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
    //Response.Write(SQL_Allow);
    //Response.End();
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
    //Response.Write(SQL_Allowk);
    //Response.End();
    DataTable dt_Allowk = ESysLib.TableReadOpen(SQL_Allowk);
    int irow_Allowk;
    irow_Allowk = dt_Allowk.Rows.Count;
    if (irow_Allowk == 0)
    {
        Response.Write("There is no data of allowance");
        Response.End();
    }
    
    string SQL
	= "        select  to_char(to_date(a.work_mon,'yyyymm'),'mm/yyyy') as c0,a.THR_GROUP_NM as c1,   " + 
        "            A.EMP_ID as c2,   " +
        "            A.FULL_NAME as  c3,   " +
        "            to_char(to_date(A.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') as c4,   " +
        "            to_char(to_date(A.left_DT,'yyyymmdd'),'dd/mm/yyyy') as c5,   " +
        "            A.POS_NM as c6,   " +
        "            ROUND(NVL(A.SALARY_LEVEL1,0),10) as c7,    " +
        "            ROUND(NVL(A.SALARY_LEVEL2,0),10) as c8,    " +
        "          ROUND(  NVL(A.ALLOW_AMT1,0),10) as c9,    " +
        "          ROUND(  NVL(A.ALLOW_AMT2,0),10) as c10,    " +
        "          ROUND( NVL(A.ALLOW_AMT3,0),10) as c11,    " +
        "           ROUND( NVL(A.ALLOW_AMT4,0),10) as c12,    " +
        "          ROUND(  NVL(A.ALLOW_AMT5,0),10) as c13,    " +
        "          ROUND(  NVL(A.ALLOW_AMT6,0),10) as c14,    " +
        "          ROUND(  NVL(A.ALLOW_AMT7,0),10) as c15,    " +
        "          ROUND(  NVL(A.ALLOW_AMT8,0),10) as c16,    " +
        "          ROUND(  NVL(A.WT_L1,0)/8 + NVL(a.HOL_DAY_L1,0),10) as c17,   " +
        "          ROUND(  NVL(A.WT_L2,0)/8 + NVL(a.HOL_DAY_L2,0),10) as c18,   " +
        "          ROUND(  NVL(A.ABS_ALE_L1,0)/8,10) as c19,   " +
        "          ROUND(  NVL(A.ABS_ALE_L2,0)/8,10) as c20,   " +
        "          ROUND(  NVL(A.ABS_OTHER_PAY_L1,0)/8,10) as c21,   " +
        "          ROUND(  NVL(A.ABS_OTHER_PAY_L2,0)/8,10)  as c22,  " +
        "          ROUND(  NVL(A.WT_L1_AMT,0) + nvl(A.WT_L2_AMT,0) + nvl(A.TOTAL_ABS_PAY_L1_AMT,0) + nvl(A.TOTAL_ABS_PAY_L2_AMT,0)+ NVL(a.HOL_DAY_L1_AMT,0)+ NVL(a.HOL_DAY_L2_AMT,0),10) as c23,    " +
        "          ROUND(  NVL(A.OT_L1,0),10) as c24,   " +
        "          ROUND(  NVL(A.OT_L2,0),10) as c25,   " +
        "          ROUND(  NVL(A.ST_L1,0) + nvl(A.HT_L1,0),10) as c26,   " +
        "          ROUND(  NVL(A.ST_L2,0) + nvl(A.HT_L2,0),10) as c27,   " +
        "          ROUND(  NVL(A.NT_30_L1,0),10)  as c28,   " +
        "          ROUND(  NVL(A.NT_30_L2,0),10)  as c29,   " +
        "          ROUND(  NVL(A.NT_45_L1,0),10)  as c30,   " +
        "          ROUND(  NVL(A.NT_45_L2,0),10)  as c31,   " +
        "          ROUND(  NVL(A.NT_60_L1,0),10)  as c32,   " +
        "          ROUND(  NVL(A.NT_60_L2,0),10)  as c33,   " +
        "          ROUND(  NVL(A.NT_90_L1,0),10)  as c34,   " +
        "          ROUND(  NVL(A.NT_90_L2,0),10)  as c35,   " +
        "          ROUND(  NVL(A.TOTAL_OT_L1_AMT,0) + nvl(A.TOTAL_OT_L2_AMT,0),10) as c36,  " +
        "          ROUND(  NVL(A.ALLOW_K1_AMT,0),10) as c37,   " +
        "          ROUND(  NVL(A.ALLOW_K2_AMT,0),10) as c38,   " +
        "          ROUND(  NVL(A.ALLOW_K3_AMT,0),10) as c39,   " +
        "          ROUND(  NVL(A.ALLOW_K4_AMT,0),10) as c40,   " +
        "          ROUND(  NVL(A.ALLOW_K5_AMT,0),10) as c41,   " +
        "          ROUND(  NVL(A.ALLOW_K6_AMT,0),10) as c42,   " +
        "          ROUND(  NVL(A.ALLOW_K7_AMT,0),10) as c43,   " +
        "          ROUND(  NVL(A.ALLOW_K8_AMT,0),10) as c44,   " +
        "          ROUND(  NVL(A.RETURN_AMT,0) + nvl(A.INC_AMT,0),10) as c45,  " +
        "         ROUND(   NVL(A.ALE_STOP,0),10) as c46,   " +
        "          ROUND(  NVL(A.ALE_STOP_AMT,0),10) as c47,   " +
        "          ROUND(  NVL(A.SEVERANCE_MONTH,0),10) as c48,   " +
        "         ROUND(   NVL(A.SEVERANCE_AMT,0),10) as c49,   " +
        "         ROUND(   NVL(A.GROSS_AMT,0),10) as c50,   " +
        "         ROUND(   NVL(A.BREAK_CONTRACT_AMT,0),10) as c51,  " +
        "         ROUND(   NVL(A.ADVANCE_AMT,0),10) as c52,  " +
        "         ROUND(   DECODE(nvl(A.MONEY_KIND,0),'02',NVL(A.INCOME_TAX,0),0),10) as c53, " +
        "         ROUND(   DECODE(nvl(A.MONEY_KIND,0),'02',NVL(A.INCOME_TAX,0)*NVL(A.EXCHANGE_RATE,0),NVL(A.INCOME_TAX,0)),10) as c54,   " +
        "         ROUND(   NVL(A.UNION_AMT,0),10) as c55,   " +
        "         ROUND(   NVL(A.SOCIAL_AMT,0),10)  as c56,   " +
        "         ROUND(   nvl(A.HEALTH_AMT,0),10) as c57 , " +
        "         ROUND(   DECODE(nvl(A.MONEY_KIND,0),'02',NVL(A.NET_AMT,0),0),10) as c58 , " +
        "         ROUND(   NVL(A.NET_VND,0),10)  as c59, " +
        "         ROUND(   nvl(A.INCOME_TAX_NET,0),10) as c60, " +
        "         ROUND(   nvl(A.SOCIAL_COM_NET,0),10) as c61, " +
        "         ROUND(   nvl(A.HEALTH_COM_NET,0),10) as c62, " +
        "         ROUND(   nvl(A.SOCIAL_COMPANY,0),10) as c63, " +
        "         ROUND(   nvl(A.HEALTH_COMPANY,0),10) as c64, " +
        "         ROUND(   DECODE('ALL','ALL',NVL(A.NET_VND,0),'01',NVL(A.NET_VND,0),NVL(A.NET_AMT,0))  + nvl(A.INCOME_TAX_NET,0) + nvl(A.SOCIAL_COM_NET,0) + nvl(A.HEALTH_COM_NET,0) + nvl(A.SOCIAL_COMPANY,0) + nvl(A.HEALTH_COMPANY,0),10) as c65, " +
        "            (select v.code_nm from vhr_hr_code v where v.id='HR0040' and v.code=a.money_kind) as c66        " +
        "            from thr_month_salary a " +
        "            where a.del_if=0 and a.work_mon between '"+p_from+"' and '"+p_to+"' " +
        "             and (a.tco_dept_pk in (  " +
        "                                          SELECT     g.pk  " +
        "                                                FROM comm.tco_org g  " +
        "                                               WHERE g.del_if = 0  " +        
        "                                          START WITH g.pk =  " +
        "                                                        DECODE ('"+p_org+"',  " +
        "                                                                'ALL', 0,  " +
        "                                                                '" + p_org + "'  " +
        "                                                               )  " +
        "                                          CONNECT BY PRIOR g.pk = g.p_pk)  " +
        "                                    OR '" + p_org + "' = 'ALL')  " +
        "      and decode('" + p_wg + "','ALL','ALL',a.thr_group_pk)= '" + p_wg + "' " +
        "             and a.emp_id like '%' || '"+p_emp_id+"' || '%'  " +
        "             and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "' " +
        "             and decode('" + p_pay_type + "','ALL','ALL',a.pay_type)='" + p_pay_type + "' " +
        "             and decode('" + p_money_type + "','ALL','ALL',a.MONEY_KIND)='" + p_money_type + "'" +
        "             and ((nvl(a.net_amt,0) >0 and   '"+p_type+"'='>0') " +
        "                or (nvl(a.net_amt,0) <0 and   '" + p_type + "'='<0') " +
        "                or (nvl(a.net_amt,0) =0 and  '" + p_type + "'='=0') " +
        "                or (nvl(a.net_amt,0) >=0 and  '" + p_type + "'='>=0') ) " + 
        "             order by c0,c1,c2 " ;
    //Response.Write(SQL);
    //Response.End();
    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
    if (dt_emp.Rows.Count == 0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }

    string SQL_mon
    = "select c0, count(c2) " +
        "    from(  select  to_char(to_date(a.work_mon,'yyyymm'),'mm/yyyy') as c0,a.THR_GROUP_NM as c1,   " +
        "            A.EMP_ID as c2      " +
        "            from thr_month_salary a " +
        "            where a.del_if=0 and a.work_mon between '"+p_from+"' and '"+p_to+"' " +
        "             and (a.tco_dept_pk in (  " +
        "                                          SELECT     g.pk  " +
        "                                                FROM comm.tco_org g  " +
        "                                               WHERE g.del_if = 0  " +        
        "                                          START WITH g.pk =  " +
        "                                                        DECODE ('" + p_org + "',  " +
        "                                                                'ALL', 0,  " +
        "                                                                '" + p_org + "'  " +
        "                                                               )  " +
        "                                          CONNECT BY PRIOR g.pk = g.p_pk)  " +
        "                                    OR '" + p_org + "' = 'ALL')               " +
        "      and decode('" + p_wg + "','ALL','ALL',a.thr_group_pk)= '" + p_wg + "' " +
        "             and a.emp_id like '%' || '" + p_emp_id + "' || '%'  " +
        "             and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "' " +
        "             and decode('" + p_pay_type + "','ALL','ALL',a.pay_type)='" + p_pay_type + "' " +
        "             and decode('" + p_money_type + "','ALL','ALL',a.MONEY_KIND)='" + p_money_type + "'" +
        "             and ((nvl(a.net_amt,0) >0 and   '" + p_type + "'='>0') " +
        "                or (nvl(a.net_amt,0) <0 and   '" + p_type + "'='<0') " +
        "                or (nvl(a.net_amt,0) =0 and  '" + p_type + "'='=0') " +
        "                or (nvl(a.net_amt,0) >=0 and  '" + p_type + "'='>=0') ) " + 
        "             order by c0,c1,c2) tbl " +
        "    group by c0  order by c0  ";
    //Response.Write(SQL_mon);
    //Response.End();
    DataTable dt_mon = ESysLib.TableReadOpen(SQL_mon);

    string SQL_grp
    = "select c0,c1, count(c2) " +
        "    from(  select  to_char(to_date(a.work_mon,'yyyymm'),'mm/yyyy') as c0,a.THR_GROUP_NM as c1,   " +
        "            A.EMP_ID as c2      " +
        "            from thr_month_salary a " +
        "            where a.del_if=0 and a.work_mon between '"+p_from+"' and '"+p_to+"' " +
        "             and (a.tco_dept_pk in (  " +
        "                                          SELECT     g.pk  " +
        "                                                FROM comm.tco_org g  " +
        "                                               WHERE g.del_if = 0  " +        
        "                                          START WITH g.pk =  " +
        "                                                        DECODE ('" + p_org + "',  " +
        "                                                                'ALL', 0,  " +
        "                                                                '" + p_org + "'  " +
        "                                                               )  " +
        "                                          CONNECT BY PRIOR g.pk = g.p_pk)  " +
        "                                    OR '" + p_org + "' = 'ALL')               " +
        "      and decode('" + p_wg + "','ALL','ALL',a.thr_group_pk)= '" + p_wg + "' " +
        "             and a.emp_id like '%' || '" + p_emp_id + "' || '%'  " +
        "             and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "' " +
        "             and decode('" + p_pay_type + "','ALL','ALL',a.pay_type)='" + p_pay_type + "' " +
        "             and decode('" + p_money_type + "','ALL','ALL',a.MONEY_KIND)='" + p_money_type + "'" +
        "             and ((nvl(a.net_amt,0) >0 and   '" + p_type + "'='>0') " +
        "                or (nvl(a.net_amt,0) <0 and   '" + p_type + "'='<0') " +
        "                or (nvl(a.net_amt,0) =0 and  '" + p_type + "'='=0') " +
        "                or (nvl(a.net_amt,0) >=0 and  '" + p_type + "'='>=0') ) " + 
        "             order by c0,c1,c2) tbl " +
        "    group by c0, c1 order by c0, c1";
    //Response.Write(SQL_grp);
    //Response.End();
    DataTable dt_grp = ESysLib.TableReadOpen(SQL_grp);        
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_employee_payroll_detail_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_employee_payroll_detail_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_employee_payroll_detail_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>User</o:Author>
  <o:LastAuthor>Hee</o:LastAuthor>
  <o:LastPrinted>2008-11-14T03:50:47Z</o:LastPrinted>
  <o:Created>2008-11-14T02:20:29Z</o:Created>
  <o:LastSaved>2008-11-18T02:28:39Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .2in 1.0in .2in;
	mso-header-margin:.48in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}
.font11
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
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
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	font-size:20.0;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;
	mso-rotate:90;}
.xl31
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
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
      <x:Scale>14</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     
      <x:SplitHorizontal>6</x:SplitHorizontal>
     <x:TopRowBottomPane>6</x:TopRowBottomPane>
     <x:SplitVertical>4</x:SplitVertical>
     <x:LeftColumnRightPane>4</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
       <x:RangeSelection>$C$2:$F$2</x:RangeSelection>
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
  <x:WindowHeight>9345</x:WindowHeight>
  <x:WindowWidth>11340</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
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

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=7195 style='border-collapse:
 collapse;table-layout:fixed;width:5382pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=128 style='mso-width-source:userset;mso-width-alt:4681;
 width:96pt'>
 <col class=xl24 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl24 width=192 style='mso-width-source:userset;mso-width-alt:7021;
 width:144pt'>
 <col class=xl24 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl24 width=87 style='mso-width-source:userset;mso-width-alt:3181;
 width:65pt'>
 <col class=xl24 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl24 width=103 span=53 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <col class=xl24 width=107 style='mso-width-source:userset;mso-width-alt:3913;
 width:80pt'>
 <col class=xl24 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl24 width=111 style='mso-width-source:userset;mso-width-alt:4059;
 width:83pt'>
 <col class=xl24 width=103 span=3 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <col class=xl24 width=96 span=4 style='mso-width-source:userset;mso-width-alt:
 3510;width:72pt'>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl24 width=64 style='height:27.75pt;width:48pt'></td>
  <td width=128 style='width:96pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
   id="_x0000_t75" coordsize="21600,21600" o:spt="75" o:preferrelative="t"
   path="m@4@5l@4@11@9@11@9@5xe" filled="f" stroked="f">
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
  </v:shapetype><v:shape id="_x0000_s1026" type="#_x0000_t75" alt="" style='position:absolute;
   margin-left:2.25pt;margin-top:2.25pt;width:90.75pt;height:63.75pt;z-index:1'>
   <v:imagedata src="../../../ViewFile.aspx?img_pk=<%= dt_Com.Rows[0][3].ToString()%>&amp;table_name=tco_bpphoto"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:3px;margin-top:3px;width:121px;
  height:85px'><img width=121 height=85
  src="../../../binary/ViewFile.aspx?img_pk=<%= dt_Com.Rows[0][3].ToString()%>&amp;table_name=tco_bpphoto"
  v:shapes="_x0000_s1026"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=37 class=xl24 width=128 style='height:27.75pt;width:96pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=4 class=xl32 width=436 style='width:327pt'><%= dt_Com.Rows[0][0].ToString()%></td>
  <td colspan=61 class=xl36 width=6279 style='width:4695pt'>PAYROLL SUMMARY
  FROM <%= DateTime.Parse(p_from.Insert(4,"-")).ToString("MMM-yyyy") %> TO <%=DateTime.Parse(p_to.Insert(4,"-")).ToString("MMM-yyyy") %></td>
  <td class=xl24 width=96 style='width:72pt'></td>
  <td class=xl24 width=96 style='width:72pt'></td>
  <td class=xl24 width=96 style='width:72pt'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 colspan=2 class=xl24 style='height:21.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl32><%= dt_Com.Rows[0][1].ToString()%></td>
  <td colspan=61 class=xl37>BẢNG CHI LƯƠNG TỪ <%=DateTime.Parse(p_from.Insert(4,"-")).ToString("MM-yyyy") %> ĐẾN <%=DateTime.Parse(p_to.Insert(4,"-")).ToString("MM-yyyy") %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 colspan=2 class=xl24 style='height:22.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl33>SDT: <%= dt_Com.Rows[0][2].ToString()%></td>
  <td colspan=64 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=51 style='mso-height-source:userset;height:38.25pt'>
  <td rowspan=2 height=109 class=xl27 width=64 style='height:81.75pt;
  width:48pt'>Month</td>
  <td rowspan=2 class=xl27 width=128 style='width:96pt'>Group<br>
    <font class="font11">Bộ phận</font></td>
  <td rowspan=2 class=xl34 width=77 style='border-bottom:.5pt solid black;
  border-top:none;width:58pt'>Emp ID<br>
    <font class="font11">Mã nhân viên</font></td>
  <td rowspan=2 class=xl34 width=192 style='border-bottom:.5pt solid black;
  border-top:none;width:144pt'>Full name<br>
    <font class="font11">Họ và tên</font></td>
  <td rowspan=2 class=xl27 width=80 style='border-top:none;width:60pt'>Join
  date<br>
    <font class="font11">Ngày vào</font></td>
  <td rowspan=2 class=xl27 width=87 style='border-top:none;width:65pt'>Left
  date<br>
    <font class="font11">Ngày nghỉ</font></td>
  <td rowspan=2 class=xl27 width=94 style='width:71pt'>Position<br>
    <font class="font11">Vị trí</font></td>
  <td colspan=2 class=xl27 width=206 style='border-left:none;width:154pt'>Salary<br>
    <font class="font11">Mức lương</font></td>

<%  if (dt_Allow.Rows[0][8].ToString().Equals("1"))
    { %>
  <td rowspan=2 class=xl27 width=103 style='width:77pt'><br><%=dt_Allow.Rows[0][0].ToString() %>
    <font class="font11"><%=dt_Allow.Rows[0][16].ToString() %></font></td>
<%  } %>    
  <%  if (dt_Allow.Rows[0][9].ToString().Equals("1"))
    { %>
  <td rowspan=2 class=xl27 width=103 style='width:77pt'><br><%=dt_Allow.Rows[0][1].ToString() %>
    <font class="font11"><%=dt_Allow.Rows[0][17].ToString() %></font></td>
<%  } %>    
  <%  if (dt_Allow.Rows[0][10].ToString().Equals("1"))
    { %>
  <td rowspan=2 class=xl27 width=103 style='width:77pt'><%=dt_Allow.Rows[0][2].ToString() %><br>
    <font class="font11"><%=dt_Allow.Rows[0][18].ToString() %></font></td>
<%  } %>    
  <%  if (dt_Allow.Rows[0][11].ToString().Equals("1"))
    { %>
  <td rowspan=2 class=xl27 width=103 style='width:77pt'><%=dt_Allow.Rows[0][3].ToString() %><br>
    <font class="font11"><%=dt_Allow.Rows[0][19].ToString() %></font></td>
<%  } %>    
  <%  if (dt_Allow.Rows[0][12].ToString().Equals("1"))
    { %>
  <td rowspan=2 class=xl27 width=103 style='width:77pt'><%=dt_Allow.Rows[0][4].ToString() %><br>
    <font class="font11"><%=dt_Allow.Rows[0][20].ToString() %></font></td>
<%  } %>    
  <%  if (dt_Allow.Rows[0][13].ToString().Equals("1"))
    { %>
  <td rowspan=2 class=xl27 width=103 style='width:77pt'><%=dt_Allow.Rows[0][5].ToString() %><br>
    <font class="font11"><%=dt_Allow.Rows[0][21].ToString() %></font></td>
<%  } %>    
  <%  if (dt_Allow.Rows[0][14].ToString().Equals("1"))
    { %>
  <td rowspan=2 class=xl27 width=103 style='width:77pt'><%=dt_Allow.Rows[0][6].ToString() %><br>
    <font class="font11"><%=dt_Allow.Rows[0][22].ToString() %></font></td>
<%  } %>    
  <%  if (dt_Allow.Rows[0][15].ToString().Equals("1"))
    { %>
  <td rowspan=2 class=xl27 width=103 style='width:77pt'><%=dt_Allow.Rows[0][7].ToString() %><br>
    <font class="font11"><%=dt_Allow.Rows[0][23].ToString() %></font></td>
<%  } %>    
  
  
  
  <td colspan=2 class=xl27 width=206 style='border-left:none;width:154pt'>Working
  day(s)<br>
    <font class="font11">Tổng ngày công</font></td>
  <td colspan=2 class=xl27 width=206 style='border-left:none;width:154pt'>Annual
  Leave absence<br>
    <font class="font11">Vắng phép năm</font></td>
  <td colspan=2 class=xl27 width=206 style='border-left:none;width:154pt'>Other
  absence<br>
    <font class="font11">Các loại vắng khác</font></td>
  <td rowspan=2 class=xl34 width=103 style='border-bottom:.5pt solid black;
  width:77pt'>Working Salary<br>
    <font class="font11">Lương ngày công</font></td>
  <td colspan=2 class=xl27 width=206 style='border-left:none;width:154pt'>OT<br>
    Giờ tăng ca thường</td>
  <td colspan=2 class=xl27 width=206 style='border-left:none;width:154pt'>HT<br>
    Giờ tăng ca ngày lễ</td>
  <td colspan=2 class=xl27 width=206 style='border-left:none;width:154pt'>NT30%<br>
    <font class="font11">Trợ cấp tăng ca đêm</font></td>
  <td colspan=2 class=xl27 width=206 style='border-left:none;width:154pt'>NT45%<br>
    <font class="font11">Trợ cấp tăng ca đêm</font></td>
  <td colspan=2 class=xl27 width=206 style='border-left:none;width:154pt'>NT60%<br>
    <font class="font11">Trợ cấp tăng ca đêm</font></td>
  <td colspan=2 class=xl27 width=206 style='border-left:none;width:154pt'>NT90%<br>
    <font class="font11">Trợ cấp tăng ca đêm</font></td>
  <td rowspan=2 class=xl27 width=103 style='width:77pt'>OT Salary<br>
    <font class="font11">Lương tăng ca</font></td>
<%  if (!dt_Allowk.Rows[0][0].ToString().Equals(""))
    { %>    
  <td rowspan=2 class=xl27 width=103 style='width:77pt'><%=dt_Allowk.Rows[0][0].ToString() %><br>
    <font class="font11"></font></td>
<%  } %>
<%  if (!dt_Allowk.Rows[0][1].ToString().Equals(""))
    { %>    
  <td rowspan=2 class=xl27 width=103 style='width:77pt'><%=dt_Allowk.Rows[0][1].ToString() %><br>
    <font class="font11"></font></td>
<%  } %>
<%  if (!dt_Allowk.Rows[0][2].ToString().Equals(""))
    { %>    
  <td rowspan=2 class=xl27 width=103 style='width:77pt'><%=dt_Allowk.Rows[0][2].ToString() %><br>
    <font class="font11"></font></td>
<%  } %>
<%  if (!dt_Allowk.Rows[0][3].ToString().Equals(""))
    { %>    
  <td rowspan=2 class=xl27 width=103 style='width:77pt'><%=dt_Allowk.Rows[0][3].ToString() %><br>
    <font class="font11"></font></td>
<%  } %>
<%  if (!dt_Allowk.Rows[0][4].ToString().Equals(""))
    { %>    
  <td rowspan=2 class=xl27 width=103 style='width:77pt'><%=dt_Allowk.Rows[0][4].ToString() %><br>
    <font class="font11"></font></td>
<%  } %>
<%  if (!dt_Allowk.Rows[0][5].ToString().Equals(""))
    { %>    
  <td rowspan=2 class=xl27 width=103 style='width:77pt'><%=dt_Allowk.Rows[0][5].ToString() %><br>
    <font class="font11"></font></td>
<%  } %>
<%  if (!dt_Allowk.Rows[0][6].ToString().Equals(""))
    { %>    
  <td rowspan=2 class=xl27 width=103 style='width:77pt'><%=dt_Allowk.Rows[0][6].ToString() %><br>
    <font class="font11"></font></td>
<%  } %>
<%  if (!dt_Allowk.Rows[0][7].ToString().Equals(""))
    { %>    
  <td rowspan=2 class=xl27 width=103 style='width:77pt'><%=dt_Allowk.Rows[0][7].ToString() %><br>
    <font class="font11"></font></td>
<%  } %>    
  
  <td colspan=2 class=xl27 width=206 style='border-left:none;width:154pt'>Annual
  remainning<br>
    <font class="font11">Phép năm còn</font></td>
  <td colspan=2 class=xl27 width=206 style='border-left:none;width:154pt'>Severance<br>
    <font class="font11">Thâm niên</font></td>
  <td rowspan=2 class=xl27 width=103 style='width:77pt'>Total Income<br>
    <font class="font11">Tổng thu nhập</font></td>
  <td rowspan=2 class=xl27 width=103 style='width:77pt'>Break Contract<br>
    <font class="font11">Vi phạm hợp đồng</font></td>
  <td rowspan=2 class=xl27 width=103 style='width:77pt'>Other Deduction<br>
    <font class="font11">Khấu trừ khác</font></td>
  <td colspan=2 class=xl27 width=206 style='border-left:none;width:154pt'>Income
  Tax<br>
    <font class="font11">Thuế thu nhập</font></td>
  <td rowspan=2 class=xl27 width=103 style='width:77pt'>Union AMT<br>
    <font class="font11">Phí công đoàn</font></td>
  <td colspan=2 class=xl27 width=206 style='border-left:none;width:154pt'>Social
  &amp; Health Insurance<br>
    <font class="font11">Bảo hiểm xã hội và y tế</font></td>
  <td colspan=2 class=xl27 width=206 style='border-left:none;width:154pt'>Total
  Salary<br>
    <font class="font11">Tổng lương</font></td>
  <td colspan=5 class=xl27 width=527 style='border-left:none;width:394pt'>Company's
  Payment<br>
    Công ty trả</td>
    <td rowspan=2 class=xl27 width=103 style='width:77pt'>Company Cost<br>
    <font class="font11">Tổng khoản thanh toán</font></td>
  <td rowspan=2 class=xl27 width=96 style='width:72pt'>Money Kind<br>
    <font class="font11">Loại tiền</font></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=58 style='mso-height-source:userset;height:43.5pt'>
  <td height=58 class=xl27 width=103 style='height:43.5pt;border-top:none;
  border-left:none;width:77pt'>Probation<br>
    <font class="font11">Thử việc</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Offical<br>
    <font class="font11">Chính thức</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Probation<br>
    <font class="font11">Thử việc</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Offical<br>
    <font class="font11">Chính thức</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Probation<br>
    <font class="font11">Thử việc</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Offical<br>
    <font class="font11">Chính thức</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Probation<br>
    <font class="font11">Thử việc</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Offical<br>
    <font class="font11">Chính thức</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Probation<br>
    <font class="font11">Thử việc</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Offical<br>
    <font class="font11">Chính thức</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Probation<br>
    <font class="font11">Thử việc</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Offical<br>
    <font class="font11">Chính thức</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Probation<br>
    <font class="font11">Thử việc</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Offical<br>
    <font class="font11">Chính thức</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Probation<br>
    <font class="font11">Thử việc</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Offical<br>
    <font class="font11">Chính thức</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Probation<br>
    <font class="font11">Thử việc</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Offical<br>
    <font class="font11">Chính thức</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Probation<br>
    <font class="font11">Thử việc</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Offical<br>
    <font class="font11">Chính thức</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Day(s)<br>
    <font class="font11">Số ngày</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Amount<br>
    <font class="font11">Số tiền</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Month(s)<br>
    <font class="font11">Số tháng</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Amount<br>
    <font class="font11">Số tiền</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>USD<br>
    <font class="font11">Ngoại tệ</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>VND<br>
    <font class="font11">Tiền Việt</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Social
  (6%)<br>
    <font class="font11">BH Xã hội</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Health(1.5%)<br>
    <font class="font11">BH Y tế</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>USD<br>
    <font class="font11">Ngoại tệ</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>VND<br>
    <font class="font11">Tiền Việt</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>PIT<br>
    <font class="font11">Thuế thu nhập</font></td>
  <td class=xl27 width=107 style='border-top:none;border-left:none;width:80pt'>Social(22%)<br>
    <font class="font11">BH Xã hội</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Health(6%)<br>
    <font class="font11">BH Y tế</font></td>
  <td class=xl27 width=111 style='border-top:none;border-left:none;width:83pt'>Social(16%)<br>
    <font class="font11">BH Xã hội</font></td>
  <td class=xl27 width=103 style='border-top:none;border-left:none;width:77pt'>Health(3%)<br>
    <font class="font11">BH Y tế</font></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt; display:none'>
  <td height=17 class=xl26 style='height:12.75pt;border-top:none' x:num>0</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>7</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>8</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>9</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>10</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>11</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>12</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>13</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>14</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>15</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>16</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>17</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>18</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>19</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>20</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>21</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>22</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>23</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>24</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>25</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>26</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>27</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>28</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>29</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>30</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>31</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>32</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>33</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>34</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>35</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>36</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>37</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>38</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>39</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>40</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>41</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>42</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>43</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>44</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>45</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>46</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>47</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>48</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>49</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>50</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>51</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>52</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>53</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>54</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>55</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>56</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>57</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>58</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>59</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>60</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>61</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>62</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>63</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>64</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>65</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num>66</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
<%
    int mon = 0, grp = 0;
    for(int i=0;i<dt_emp.Rows.Count;i++)
    { 
 %> 
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
    <%  if (i == 0)
        { %>
  <td height=23 rowspan="<%=int.Parse(dt_mon.Rows[mon++][1].ToString()) %>" class=xl30 
            style='height:17.25pt;border-top:none'><b>MONTH <%=dt_emp.Rows[i][0].ToString() %></b></td>
  <%    }
        else if(dt_emp.Rows[i][0].ToString()!=dt_emp.Rows[i-1][0].ToString())
        { 
        %>
  <td height=23 rowspan="<%=int.Parse(dt_mon.Rows[mon++][1].ToString()) %>" class=xl30 
            style='height:17.25pt;border-top:none'><b>MONTH <%=dt_emp.Rows[i][0].ToString() %></b></td>
  <%    } %>
  <%    if (i == 0)
        { %>  
  <td class=xl29 rowspan="<%=int.Parse(dt_grp.Rows[grp++][2].ToString()) %>" 
            style='border-top:none;border-left:none'><b><%=dt_emp.Rows[i][1].ToString()%></b> </td>
  <%    }
        else if (dt_emp.Rows[i][1].ToString() != dt_emp.Rows[i - 1][1].ToString())
        {%>
  <td class=xl29 rowspan="<%=int.Parse(dt_grp.Rows[grp++][2].ToString()) %>" 
            style='border-top:none;border-left:none'><b><%=dt_emp.Rows[i][1].ToString()%></b> </td>
  <%    } 
		else if (dt_emp.Rows[i][1].ToString() == dt_emp.Rows[i - 1][1].ToString() && dt_emp.Rows[i][0].ToString() != dt_emp.Rows[i - 1][0].ToString() )
		{ %>
  <td class=xl29 rowspan="<%=int.Parse(dt_grp.Rows[grp++][2].ToString()) %>" 
            style='border-top:none;border-left:none'><b><%=dt_emp.Rows[i][1].ToString()%></b> </td>		
	<%
		}%>          
  <td class=xl29 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][2].ToString()%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][3].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none' x:str><%=dt_emp.Rows[i][4].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none' x:str><%=dt_emp.Rows[i][5].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none' x:str><%=dt_emp.Rows[i][6].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][7].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][8].ToString()%></td>
  <%    if (dt_Allow.Rows[0][8].ToString().Equals("1"))
        { %>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][9].ToString()%></td>
  <%    } %>
  <%    if (dt_Allow.Rows[0][9].ToString().Equals("1"))
        { %>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][10].ToString()%></td>
  <%    } %>
  <%    if (dt_Allow.Rows[0][10].ToString().Equals("1"))
        { %>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][11].ToString()%></td>
  <%    } %>
  <%    if (dt_Allow.Rows[0][11].ToString().Equals("1"))
        { %>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][12].ToString()%></td>
  <%    } %>
  <%    if (dt_Allow.Rows[0][12].ToString().Equals("1"))
        { %>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][13].ToString()%></td>
  <%    } %>
  <%    if (dt_Allow.Rows[0][13].ToString().Equals("1"))
        { %>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][14].ToString()%></td>
  <%    } %>
  <%    if (dt_Allow.Rows[0][14].ToString().Equals("1"))
        { %>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][15].ToString()%></td>
  <%    } %>
  <%    if (dt_Allow.Rows[0][15].ToString().Equals("1"))
        { %>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][16].ToString()%></td>
  <%    } %>
  <%    for (int num = 17; num < 37; num++)
        { %>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][37].ToString()%> </td>
  <%    } %>
<%      if(!dt_Allowk.Rows[0][0].ToString().Equals(""))
        { %> 
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][38].ToString()%></td>
<%      } %>  
<%      if(!dt_Allowk.Rows[0][1].ToString().Equals(""))
        { %> 
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][39].ToString()%></td>
<%      } %>
<%      if(!dt_Allowk.Rows[0][2].ToString().Equals(""))
        { %> 
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][40].ToString()%></td>
<%      } %>
<%      if(!dt_Allowk.Rows[0][3].ToString().Equals(""))
        { %> 
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][41].ToString()%></td>
<%      } %>
<%      if(!dt_Allowk.Rows[0][4].ToString().Equals(""))
        { %> 
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][42].ToString()%></td>
<%      } %>
<%      if(!dt_Allowk.Rows[0][5].ToString().Equals(""))
        { %> 
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][43].ToString()%></td>
<%      } %>
<%      if(!dt_Allowk.Rows[0][6].ToString().Equals(""))
        { %> 
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][44].ToString()%></td>
<%      } %>
<%      if(!dt_Allowk.Rows[0][7].ToString().Equals(""))
        { %> 
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][45].ToString()%></td>
<%      } %>  
<%      for(int num=46;num<67;num++)
        { %>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][num].ToString()%></td>
<%      } %>

  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <%
    }//end for
  %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  
 </tr>
 <![endif]>
</table>

</body>

</html>
