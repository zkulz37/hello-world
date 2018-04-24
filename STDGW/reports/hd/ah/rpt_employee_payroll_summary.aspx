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
    string p_work_mon = "200807", p_org =  Request.QueryString[0] ;
    string p_wg = Request.QueryString[1];    
    string p_status =  Request.QueryString[2].ToString();
    string p_emp_id = Request.QueryString[3].ToString();
    string p_money_type = Request.QueryString[4].ToString();
    string p_pay_type = Request.QueryString[5].ToString();
    string p_type = Request.QueryString[6].ToString();
    string p_from = Request.QueryString[7].ToString();
    string p_to = Request.QueryString[8].ToString();

    //Response.Write(DateTime.Parse(p_from.Insert(4,"-")).ToString("MM-yyyy") + " - " + DateTime.Parse(p_to.Insert(4,"-")).ToString("MM-yyyy"));
    //Response.Write(p_from.Insert(4,"-") + " - " + p_to.Insert(4,"-"));
    //Response.End();
    
    string SQL
    = "SELECT   TO_CHAR (TO_DATE (a.work_mon, 'yyyymm'), 'mm/yyyy') AS c1, " +
        "         a.dept_nm AS c2, a.thr_group_nm AS c3, " +
        "         ROUND(SUM (DECODE (a.status, 'A', 1, 0)),8) AS c4, " +
        "         ROUND(SUM (DECODE (a.status, 'R', 1, 0)),8) AS c5, COUNT (a.thr_emp_pk) AS c6, " +
        "         ROUND (SUM (NVL (a.salary_level1, 0)), 8) AS c7, " + 
        "         ROUND (SUM (NVL (a.salary_level2, 0)), 8) AS c8, " +
        "         ROUND (SUM (NVL (a.allow_amt1, 0)), 8) AS c9, " +
        "         ROUND (SUM (NVL (a.allow_amt2, 0)), 8) AS c10, " +
        "         ROUND (SUM (NVL (a.allow_amt3, 0)), 8) AS c11, " +
        "         ROUND (SUM (NVL (a.allow_amt4, 0)), 8) AS c12, " +
        "         ROUND (SUM (NVL (a.allow_amt5, 0)), 8) AS c13, " +
        "         ROUND (SUM (NVL (a.allow_amt6, 0)), 8) AS c14, " +
        "         ROUND (SUM (NVL (a.allow_amt7, 0)), 8) AS c15, " +
        "         ROUND (SUM (NVL (a.allow_amt8, 0)), 8) AS c16, " +
        "         ROUND (SUM (NVL (a.wt_l1, 0) / 8 + NVL (a.hol_day_l1, 0)), 8) AS c17, " +
        "         ROUND (SUM (NVL (a.wt_l2, 0) / 8 + NVL (a.hol_day_l2, 0)), " +
        "                8 " +
        "               ) AS c18, " +
        "         ROUND (SUM (NVL (a.abs_ale_l1, 0) / 8), " +
        "                8 " +
        "               ) AS c19, " +
        "         ROUND (SUM (NVL (a.abs_ale_l2, 0) / 8), " +
        "                8 " +
        "               ) AS c20, " +
        "         ROUND (SUM (NVL (a.abs_other_pay_l1, 0) / 8), " +
        "                8 " +
        "               ) AS c21, " +
        "         ROUND (SUM (NVL (a.abs_other_pay_l2, 0) / 8), " +
        "                8 " +
        "               ) AS c22, " +
        "         ROUND (SUM (  NVL (a.wt_l1_amt, 0) " +
        "                     + NVL (a.wt_l2_amt, 0) " +
        "                     + NVL (a.total_abs_pay_l1_amt, 0) " +
        "                     + NVL (a.total_abs_pay_l2_amt, 0) " +
        "                     + NVL (a.hol_day_l1_amt, 0) " +
        "                     + NVL (a.hol_day_l2_amt, 0) " +
        "                    ), " +
        "                8 " +
        "               ) AS c23, " +
        "         ROUND (SUM (NVL (a.ot_l1, 0)), " +
        "                8 " +
        "               ) AS c24, " +
        "         ROUND (SUM (NVL (a.ot_l2, 0)), " +
        "                8 " +
        "               ) AS c25, " +
        "         ROUND (SUM (NVL (a.st_l1, 0) + NVL (a.ht_l1, 0)), " +
        "                8 " +
        "               ) AS c26, " +
        "         ROUND (SUM (NVL (a.st_l2, 0) + NVL (a.ht_l2, 0)), " +
        "                8 " +
        "               ) AS c27, " +
        "         ROUND (SUM (NVL (a.nt_30_l1, 0)), " +
        "                8 " +
        "               ) AS c28, " +
        "         ROUND (SUM (NVL (a.nt_30_l2, 0)), " +
        "                8 " +
        "               ) AS c29, " +
        "         ROUND (SUM (NVL (a.nt_45_l1, 0)), " +
        "                8 " +
        "               ) AS c30, " +
        "         ROUND (SUM (NVL (a.nt_45_l2, 0)), " +
        "                8 " +
        "               ) AS c31, " +
        "         ROUND (SUM (NVL (a.nt_60_l1, 0)), " +
        "                8 " +
        "               ) AS c32, " +
        "         ROUND (SUM (NVL (a.nt_60_l2, 0)), " +
        "                8 " +
        "               ) AS c33, " +
        "         ROUND (SUM (NVL (a.nt_90_l1, 0)), " +
        "                8 " +
        "               ) AS c34, " +
        "         ROUND (SUM (NVL (a.nt_90_l2, 0)), " +
        "                8 " +
        "               ) AS c35, " +
        "         ROUND (SUM (NVL (a.total_ot_l1_amt, 0) + NVL (a.total_ot_l2_amt, 0)), " +
        "                8 " +
        "               ) AS c36, " +
        "         ROUND(SUM (NVL (a.allow_k1_amt, 0)),8) AS c37, " +
        "         ROUND(SUM (NVL (a.allow_k2_amt, 0)),8) AS c38, " +
        "         ROUND(SUM (NVL (a.allow_k3_amt, 0)),8) AS c39, " +
        "         ROUND(SUM (NVL (a.allow_k4_amt, 0)),8) AS c40, " +
        "         ROUND(SUM (NVL (a.allow_k5_amt, 0)),8) AS c41, " +
        "         ROUND(SUM (NVL (a.allow_k6_amt, 0)),8) AS c42, " +
        "         ROUND(SUM (NVL (a.allow_k7_amt, 0)),8) AS c43, " +
        "         ROUND(SUM (NVL (a.allow_k8_amt, 0)),8) AS c44, " +
        "         ROUND(SUM (NVL (a.return_amt, 0) + NVL (a.inc_amt, 0)),8) AS c45, " +
        "         ROUND(SUM (NVL (a.ale_stop, 0)),8) AS c46, " +
        "         ROUND(SUM (NVL (a.ale_stop_amt, 0)),8) AS c47, " +
        "         ROUND(SUM (NVL (a.severance_month, 0)),8) AS c48, " +
        "         ROUND(SUM (NVL (a.severance_amt, 0)),8) AS c49, " +
        "         ROUND(SUM (NVL (a.gross_amt, 0)),8) AS c50, " +
        "         ROUND(SUM (NVL (a.break_contract_amt, 0)),8) AS c51, " +
        "         ROUND(SUM (NVL (a.advance_amt, 0)),8) AS c52, " +
        "         ROUND(SUM (DECODE (NVL (a.money_kind, 0), '02', NVL (a.income_tax, 0), 0) " +
        "             ),8) AS c53, " +
        "         ROUND(SUM (DECODE (NVL (a.money_kind, 0), " +
        "                      '02', NVL (a.income_tax, 0) * NVL (a.exchange_rate, 0), " +
        "                      NVL (a.income_tax, 0) " +
        "                     ) " +
        "             ),8) AS c54, " +
        "         ROUND(SUM (NVL (a.union_amt, 0)),8) AS c55,ROUND( SUM (NVL (a.social_amt, 0)),8) " +
        "                                                                       AS c56, " +
        "         ROUND(SUM (NVL (a.health_amt, 0)),8) AS c57, " +
        "         ROUND(SUM (DECODE (NVL (a.money_kind, 0), '02', NVL (a.net_amt, 0), 0) " +
        "             ),8) AS c58, " +
        "         ROUND(SUM (NVL (a.net_vnd, 0)),8) AS c59, " +
        "         ROUND(SUM (NVL (a.income_tax_net, 0)),8) AS c60, " +
        "         ROUND(SUM (NVL (a.social_com_net, 0)),8) AS c61, " +
        "         ROUND(SUM (NVL (a.health_com_net, 0)),8) AS c62, " +
        "         ROUND(SUM (NVL (a.social_company, 0)),8) AS c63, " +
        "         ROUND(SUM (NVL (a.health_company, 0)),8) AS c64, " +
        "         ROUND(SUM (  NVL (a.social_com_net, 0) " +
        "              + NVL (a.health_com_net, 0) " +
        "              + NVL (a.social_company, 0) " +
        "              + NVL (a.health_company, 0) " +
        "              + NVL (a.social_amt, 0) " +
        "              + NVL (a.health_amt, 0) " +
        "             ),8) AS c65, " +
        "         ROUND(SUM (  DECODE ('"+p_money_type+"', " +
        "                        'ALL', NVL (a.net_vnd, 0), " +
        "                        '01', NVL (a.net_vnd, 0), " +
        "                        NVL (a.net_amt, 0) " +
        "                       ) " +
        "              + NVL (a.income_tax_net, 0) " +
        "              + NVL (a.social_com_net, 0) " +
        "              + NVL (a.health_com_net, 0) " +
        "              + NVL (a.social_company, 0) " +
        "              + NVL (a.health_company, 0) " +
        "             ),8) AS c66 " +
        "    FROM thr_month_salary a " +
        "   WHERE a.del_if = 0 " +
        "     AND a.work_mon BETWEEN '"+p_from+"' AND '"+p_to+"' " +
        "     AND (   a.tco_dept_pk IN ( " +
        "                             SELECT     g.pk " +
        "                                   FROM comm.tco_org g " +
        "                                  WHERE g.del_if = 0 " +        
        "                             START WITH g.pk = DECODE ('"+p_org+"', " +
        "                                                       'ALL', 0, " +
        "                                                       '"+p_org+"' " +
        "                                                      ) " +
        "                             CONNECT BY PRIOR g.pk = g.p_pk) " +
        "          OR '"+p_org+"' = 'ALL' " +
        "         ) " +
        "   and decode('"+p_wg+"','ALL','ALL',a.thr_group_pk)= '"+p_wg+"' " +
        "             and a.emp_id like '%' || '"+p_emp_id+"' || '%'  " +
        "             and decode('"+p_status+"','ALL','ALL',a.status)='"+p_status+"' " +
        "             and decode('"+p_pay_type+"','ALL','ALL',a.pay_type)='"+p_pay_type+"'  " +
        "             and decode('"+p_money_type+"','ALL','ALL',a.MONEY_KIND)='"+p_money_type+"' " +
        "             and ((nvl(a.net_amt,0) >0 and   '"+p_type+"'='>0') " +
        "                or (nvl(a.net_amt,0) <0 and   '" + p_type + "'='<0') " +
        "                or (nvl(a.net_amt,0) =0 and   '" + p_type + "'='=0') " +
        "                or (nvl(a.net_amt,0) >=0 and   '" + p_type + "'='>=0') ) " +
        "GROUP BY a.work_mon, a.tco_dept_pk, a.dept_nm, a.thr_group_pk, a.thr_group_nm " +
        "ORDER BY c1, c2, c3 ";

    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    //Response.Write(SQL);
    //Response.End();
    if (dt_Emp.Rows.Count == 0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }        
    
    string SQL_Com
    = "select  a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,a.TCO_BPPHOTO_PK,to_char(to_date('" + p_from + "','yyyymm'),'MON-YYYY'),to_char(to_date('" + p_to + "','yyyymm'),'MM-YYYY') " + 
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
    string SQL_cnt = " select c1, c2, count(c3) " +
        " from " +
        " (SELECT   TO_CHAR (TO_DATE (a.work_mon, 'yyyymm'), 'mm/yyyy') AS c1, " +
        "         a.dept_nm AS c2, a.thr_group_nm AS c3 " +
        "    FROM thr_month_salary a " +
        "   WHERE a.del_if = 0 " +
        "     AND a.work_mon BETWEEN '" + p_from + "' AND '" + p_to + "' " +
        "     AND (   a.tco_dept_pk IN ( " +
        "                             SELECT     g.pk " +
        "                                   FROM comm.tco_org g " +
        "                                  WHERE g.del_if = 0 " +        
        "                             START WITH g.pk = DECODE ('" + p_org + "', " +
        "                                                       'ALL', 0, " +
        "                                                       '" + p_org + "' " +
        "                                                      ) " +
        "                             CONNECT BY PRIOR g.pk = g.p_pk) " +
        "          OR '" + p_org + "' = 'ALL' " +
        "         ) " +
        "   and decode('" + p_wg + "','ALL','ALL',a.thr_group_pk)= '" + p_wg + "' " +
        "             and a.emp_id like '%' || '" + p_emp_id + "' || '%'  " +
        "             and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "' " +
        "             and decode('" + p_pay_type + "','ALL','ALL',a.pay_type)='" + p_pay_type + "'  " +
        "             and decode('" + p_money_type + "','ALL','ALL',a.MONEY_KIND)='" + p_money_type + "' " +
        "             and ((nvl(a.net_amt,0) >0 and   '" + p_type + "'='>0') " +
        "                or (nvl(a.net_amt,0) <0 and   '" + p_type + "'='<0') " +
        "                or (nvl(a.net_amt,0) =0 and   '" + p_type + "'='=0') " +
        "                or (nvl(a.net_amt,0) >=0 and   '" + p_type + "'='>=0') ) " +
        " GROUP BY a.work_mon, a.tco_dept_pk, a.dept_nm, a.thr_group_pk, a.thr_group_nm " +
        " ORDER BY c1, c2, c3 )tbl " +
        " group by c1, c2 " +
        " ORDER BY c1, c2 ";
    DataTable dt_cnt = ESysLib.TableReadOpen(SQL_cnt);
    
    //Response.Write(SQL_cnt);
    //Response.End();
    
    
    int col = 16;
    for (int num = 0; num < 8; num++)
    {
        if (dt_Allow.Rows[0][num + 8].ToString().Equals("0"))
            col--;
        if (dt_Allowk.Rows[0][num].ToString().Equals(""))
            col--;
    }
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_dms_employee_payroll_summary_files/filelist.xml">
<link rel=Edit-Time-Data
href="rpt_dms_employee_payroll_summary_files/editdata.mso">
<link rel=OLE-Object-Data
href="rpt_dms_employee_payroll_summary_files/oledata.mso">
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
  <o:LastAuthor>User</o:LastAuthor>
  <o:LastPrinted>2008-11-14T03:50:47Z</o:LastPrinted>
  <o:Created>2008-11-14T02:20:29Z</o:Created>
  <o:LastSaved>2008-11-14T04:30:37Z</o:LastSaved>
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
.font13
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
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
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
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
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
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl36
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
.xl37
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl47
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
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
       <x:RangeSelection>$B$2:$D$2</x:RangeSelection>
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
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=6966 style='border-collapse:
 collapse;table-layout:fixed;width:5210pt'>
 <col class=xl24 width=132 style='mso-width-source:userset;mso-width-alt:4827;
 width:99pt'>
 <col class=xl24 width=143 style='mso-width-source:userset;mso-width-alt:5229;
 width:107pt'>
 <col class=xl24 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl24 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl24 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
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
  <td height=37 width=132 style='height:27.75pt;width:99pt' align=left
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
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" alt="" style='position:absolute;
   margin-left:15pt;margin-top:6pt;width:76.5pt;height:45.75pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_Com.Rows[0][3].ToString()%>&table_name=tco_bpphoto"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:20px;margin-top:8px;width:102px;
  height:61px'><img width=102 height=61
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_Com.Rows[0][3].ToString()%>&table_name=tco_bpphoto"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=37 class=xl24 width=132 style='height:27.75pt;width:99pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl46 width=299 style='width:224pt'><%=dt_Com.Rows[0][0].ToString()%></td>
  <td colspan="<%=61-16+col %>" class=xl32 width=6151 style='width:4599pt'>PAYROLL SUMMARY
  FROM <%= DateTime.Parse(p_from.Insert(4,"-")).ToString("MMM-yyyy") %> TO <%=DateTime.Parse(p_to.Insert(4,"-")).ToString("MMM-yyyy") %></td>
  <td class=xl24 width=96 style='width:72pt'></td>
  <td class=xl24 width=96 style='width:72pt'></td>
  <td class=xl24 width=96 style='width:72pt'></td>
  <td class=xl24 width=96 style='width:72pt'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl24 style='height:21.0pt'></td>
  <td colspan=3 class=xl46><%=dt_Com.Rows[0][1].ToString()%></td>
  <td colspan="<%=61-16+col %>" class=xl45>BẢNG CHI LƯƠNG TỪ <%=DateTime.Parse(p_from.Insert(4,"-")).ToString("MM-yyyy") %> ĐẾN <%=DateTime.Parse(p_to.Insert(4,"-")).ToString("MM-yyyy") %></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl24 style='height:22.5pt'></td>
  <td colspan=3 class=xl47>Điện thoại: <%=dt_Com.Rows[0][2].ToString()%></td>
  <td colspan=64 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=51 style='mso-height-source:userset;height:38.25pt'>
  <td rowspan=2 height=109 class=xl28 width=132 style='height:81.75pt;
  width:99pt'>Department <br>
    <font class="font13">Phòng ban</font></td>
  <td rowspan=2 class=xl28 width=143 style='border-top:none;width:107pt'>Group<br>
    <font class="font13">Bộ phận</font></td>
  <td rowspan=2 class=xl28 width=76 style='border-top:none;width:57pt'>Active
  Emp(s)<br>
    <font class="font13">Nhân viên làm việc</font></td>
  <td rowspan=2 class=xl28 width=80 style='border-top:none;width:60pt'>Resigned
  Emp(s)<br>
    <font class="font13">Nhân viên nghỉ việc</font></td>
  <td rowspan=2 class=xl28 width=62 style='width:47pt'>Total Emp(s)<br>
    <font class="font13">Tổng nhân viên</font></td>
  <td colspan=2 class=xl28 width=206 style='border-left:none;width:154pt'>Salary<br>
    <font class="font13">Mức lương</font></td>
   <%   if (dt_Allow.Rows[0][8].ToString().Equals("1"))
        { %> 
    
  <td rowspan=2 class=xl28 width=103 style='width:77pt'><%=dt_Allow.Rows[0][0].ToString() %><br>
    <font class="font13"><%=dt_Allow.Rows[0][16].ToString() %></font></td>
    <%  } %>
    <%   if (dt_Allow.Rows[0][9].ToString().Equals("1"))
        { %>
  <td rowspan=2 class=xl28 width=103 style='width:77pt'><%=dt_Allow.Rows[0][1].ToString() %><br>
    <font class="font13"><%=dt_Allow.Rows[0][17].ToString() %></font></td>
    <%  } %>
    <%   if (dt_Allow.Rows[0][10].ToString().Equals("1"))
        { %>
        
  <td rowspan=2 class=xl28 width=103 style='width:77pt'><%=dt_Allow.Rows[0][2].ToString() %><br>
    <font class="font13"><%=dt_Allow.Rows[0][18].ToString() %></font></td>
    <%  } %>
    <%   if(dt_Allow.Rows[0][11].ToString().Equals("1"))
        { %>
  <td rowspan=2 class=xl28 width=103 style='width:77pt'><%=dt_Allow.Rows[0][3].ToString() %><br>
    <font class="font13"><%=dt_Allow.Rows[0][19].ToString() %></font></td>
    <%  } %>
    <%   if (dt_Allow.Rows[0][12].ToString().Equals("1"))
        { %>
  <td rowspan=2 class=xl28 width=103 style='width:77pt'><%=dt_Allow.Rows[0][4].ToString() %><br>
    <font class="font13"><%=dt_Allow.Rows[0][20].ToString() %></font></td>
    <%  } %>
    <%   if (dt_Allow.Rows[0][13].ToString().Equals("1"))
        { %>
  <td rowspan=2 class=xl28 width=103 style='width:77pt'><%=dt_Allow.Rows[0][5].ToString() %><br>
    <font class="font13"><%=dt_Allow.Rows[0][21].ToString() %></font></td>
    <%  } %>
    <%   if (dt_Allow.Rows[0][14].ToString().Equals("1"))
        { %>
  <td rowspan=2 class=xl28 width=103 style='width:77pt'><%=dt_Allow.Rows[0][6].ToString() %><br>
    <font class="font13"><%=dt_Allow.Rows[0][22].ToString() %></font></td>
    <%  } %>
    <%   if (dt_Allow.Rows[0][15].ToString().Equals("1"))
        { %>
  <td rowspan=2 class=xl28 width=103 style='width:77pt'><%=dt_Allow.Rows[0][7].ToString() %><br>
    <font class="font13"><%=dt_Allow.Rows[0][23].ToString() %></font></td>
    <%  } %>
  <td colspan=2 class=xl28 width=206 style='border-left:none;width:154pt'>Working
  day(s)<br>
    <font class="font13">Tổng ngày công</font></td>
  <td colspan=2 class=xl28 width=206 style='border-left:none;width:154pt'>Annual
  Leave absence<br>
    <font class="font13">Vắng phép năm</font></td>
  <td colspan=2 class=xl28 width=206 style='border-left:none;width:154pt'>Other
  absence<br>
    <font class="font13">Các loại vắng khác</font></td>
  <td rowspan=2 class=xl35 width=103 style='border-bottom:.5pt solid black;
  width:77pt'>Working Salary<br>
    <font class="font13">Lương ngày công</font></td>
  <td colspan=2 class=xl28 width=206 style='border-left:none;width:154pt'>OT<br>
    Giờ tăng ca thường</td>
  <td colspan=2 class=xl28 width=206 style='border-left:none;width:154pt'>HT<br>
    Giờ tăng ca ngày lễ</td>
  <td colspan=2 class=xl28 width=206 style='border-left:none;width:154pt'>NT30%<br>
    <font class="font13">Trợ cấp tăng ca đêm</font></td>
  <td colspan=2 class=xl28 width=206 style='border-left:none;width:154pt'>NT45%<br>
    <font class="font13">Trợ cấp tăng ca đêm</font></td>
  <td colspan=2 class=xl28 width=206 style='border-left:none;width:154pt'>NT60%<br>
    <font class="font13">Trợ cấp tăng ca đêm</font></td>
  <td colspan=2 class=xl28 width=206 style='border-left:none;width:154pt'>NT90%<br>
    <font class="font13">Trợ cấp tăng ca đêm</font></td>
  <td rowspan=2 class=xl28 width=103 style='width:77pt'>OT Salary<br>
    <font class="font13">Lương tăng ca</font></td>
    
    <% if(!dt_Allowk.Rows[0][0].ToString().Equals(""))
       { %>    
  <td rowspan=2 class=xl28 width=103 style='width:77pt'><%=dt_Allowk.Rows[0][0].ToString() %><br>
    <font class="font13"></font></td>
    <%  } %>
     <% if(!dt_Allowk.Rows[0][1].ToString().Equals(""))
       { %>
  <td rowspan=2 class=xl28 width=103 style='width:77pt'><%=dt_Allowk.Rows[0][1].ToString() %><br>
    <font class="font13"></font></td>
    <%  } %>
     <% if(!dt_Allowk.Rows[0][2].ToString().Equals(""))
       { %>
  <td rowspan=2 class=xl28 width=103 style='width:77pt'><%=dt_Allowk.Rows[0][2].ToString() %><br>
    <font class="font13"></font></td>
    <%  } %>
     <% if(!dt_Allowk.Rows[0][3].ToString().Equals(""))
       { %>
  <td rowspan=2 class=xl28 width=103 style='width:77pt'><%=dt_Allowk.Rows[0][3].ToString() %><br>
    <font class="font13"></font></td>
    <%  } %>
     <% if(!dt_Allowk.Rows[0][4].ToString().Equals(""))
       { %>
  <td rowspan=2 class=xl28 width=103 style='width:77pt'><%=dt_Allowk.Rows[0][4].ToString() %><br>
    <font class="font13"></font></td>
    <%  } %>
     <% if(!dt_Allowk.Rows[0][5].ToString().Equals(""))
       { %>
  <td rowspan=2 class=xl28 width=103 style='width:77pt'><%=dt_Allowk.Rows[0][5].ToString() %><br>
    <font class="font13"></font></td>
    <%  } %>
     <% if(!dt_Allowk.Rows[0][6].ToString().Equals(""))
       { %>
  <td rowspan=2 class=xl28 width=103 style='width:77pt'><%=dt_Allowk.Rows[0][6].ToString() %><br>
    <font class="font13"></font></td>
    <%  } %>
     <% if(!dt_Allowk.Rows[0][7].ToString().Equals(""))
       { %>
  <td rowspan=2 class=xl28 width=103 style='width:77pt'><%=dt_Allowk.Rows[0][7].ToString() %><br>
    <font class="font13"></font></td>
    <%  } %>
  <td rowspan=2 class=xl28 width=103 style='width:77pt'>Other Compensation<br>
    <font class="font13">Các khoản bù</font></td>
  <td colspan=2 class=xl28 width=206 style='border-left:none;width:154pt'>Annual
  remainning<br>
    <font class="font13">Phép năm còn</font></td>
  <td colspan=2 class=xl28 width=206 style='border-left:none;width:154pt'>Severance<br>
    <font class="font13">Thâm niên</font></td>
  <td rowspan=2 class=xl28 width=103 style='width:77pt'>Total Income<br>
    <font class="font13">Tổng thu nhập</font></td>
  <td rowspan=2 class=xl28 width=103 style='width:77pt'>Break Contract<br>
    <font class="font13">Vi phạm hợp đồng</font></td>
  <td rowspan=2 class=xl28 width=103 style='width:77pt'>Other Deduction<br>
    <font class="font13">Khấu trừ khác</font></td>
  <td colspan=2 class=xl28 width=206 style='border-left:none;width:154pt'>Income
  Tax<br>
    <font class="font13">Thuế thu nhập</font></td>
  <td rowspan=2 class=xl28 width=103 style='width:77pt'>Union AMT<br>
    <font class="font13">Phí công đoàn</font></td>
  <td colspan=2 class=xl28 width=206 style='border-left:none;width:154pt'>Social
  &amp; Health Insurance<br>
    <font class="font13">Bảo hiểm xã hội và y tế</font></td>
  <td colspan=2 class=xl28 width=206 style='border-left:none;width:154pt'>Total
  Salary<br>
    <font class="font13">Tổng lương</font></td>
  <td colspan=5 class=xl28 width=527 style='border-left:none;width:394pt'>Company's
  Payment<br>
    Công ty trả</td>
  <td rowspan=2 class=xl28 width=103 style='width:77pt'>Com. pay for Insurance
  Central<br>
    <font class="font13">Tiền công ty trả BH</font></td>
  <td rowspan=2 class=xl28 width=103 style='width:77pt'>Company Cost<br>
    <font class="font13">Tổng khoản thanh toán</font></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=58 style='mso-height-source:userset;height:43.5pt'>
  <td height=58 class=xl28 width=103 style='height:43.5pt;border-top:none;
  border-left:none;width:77pt'>Probation<br>
    <font class="font13">Thử việc</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Offical<br>
    <font class="font13">Chính thức</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Probation<br>
    <font class="font13">Thử việc</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Offical<br>
    <font class="font13">Chính thức</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Probation<br>
    <font class="font13">Thử việc</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Offical<br>
    <font class="font13">Chính thức</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Probation<br>
    <font class="font13">Thử việc</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Offical<br>
    <font class="font13">Chính thức</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Probation<br>
    <font class="font13">Thử việc</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Offical<br>
    <font class="font13">Chính thức</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Probation<br>
    <font class="font13">Thử việc</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Offical<br>
    <font class="font13">Chính thức</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Probation<br>
    <font class="font13">Thử việc</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Offical<br>
    <font class="font13">Chính thức</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Probation<br>
    <font class="font13">Thử việc</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Offical<br>
    <font class="font13">Chính thức</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Probation<br>
    <font class="font13">Thử việc</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Offical<br>
    <font class="font13">Chính thức</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Probation<br>
    <font class="font13">Thử việc</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Offical<br>
    <font class="font13">Chính thức</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Day(s)<br>
    <font class="font13">Số ngày</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Amount<br>
    <font class="font13">Số tiền</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Month(s)<br>
    <font class="font13">Số tháng</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Amount<br>
    <font class="font13">Số tiền</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>USD<br>
    <font class="font13">Ngoại tệ</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>VND<br>
    <font class="font13">Tiền Việt</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Social
  (5%)<br>
    <font class="font13">BH Xã hội</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Health(1%)<br>
    <font class="font13">BH Y tế</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>USD<br>
    <font class="font13">Ngoại tệ</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>VND<br>
    <font class="font13">Tiền Việt</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>PIT<br>
    <font class="font13">Thuế thu nhập</font></td>
  <td class=xl28 width=107 style='border-top:none;border-left:none;width:80pt'>Social(20%)<br>
    <font class="font13">BH Xã hội</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Health(5%)<br>
    <font class="font13">BH Y tế</font></td>
  <td class=xl28 width=111 style='border-top:none;border-left:none;width:83pt'>Social(15%)<br>
    <font class="font13">BH Xã hội</font></td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Health(2%)<br>
    <font class="font13">BH Y tế</font></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
 </tr>

 <tr height=17 style='height:12.75pt;display:none'>
  <td height=17 class=xl26 style='height:12.75pt;border-top:none' x:num>1</td>
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
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr> <!-- -->
 <%
     double[] sum_dept = new double[66];
     double[] sum_mon = new double[66];
     int dept = 0;
     //Response.Write( dt_cnt.Rows.Count );
     //Response.End();
     for (int j = 0; j < 66; j++)
     {
         sum_dept[j] = 0;
         sum_mon[j] = 0;
     }
     for (int i = 0; i < dt_Emp.Rows.Count; i++)
     {
         for (int j = 2; j < 65; j++)
         {
             sum_dept[j] += Double.Parse(dt_Emp.Rows[i][j+1].ToString()) ;
             sum_mon[j] += Double.Parse(dt_Emp.Rows[i][j+1].ToString());
         }
         if (i == 0)
         {
      %>
      
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=4 height=29 class=xl37 style='border-right:.5pt solid black;
  height:21.75pt'>MONTH: <%=dt_Emp.Rows[i][0].ToString() %></td>
  <td colspan="<%=61-16+col %>" class=xl40 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <%
        }
        else if (dt_Emp.Rows[i][0].ToString() != dt_Emp.Rows[i-1][0].ToString())
        {
            %>
    <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=4 height=29 class=xl37 style='border-right:.5pt solid black;
  height:21.75pt'>MONTH: <%=dt_Emp.Rows[i][0].ToString() %></td>
  <td colspan="<%=61-16+col %>" class=xl40 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>            
   <%   }  //else if %> 
<tr height=23 style='mso-height-source:userset;height:17.25pt'>







  <%
      if (i == 0)
      {             
             %>
 <td height=23  rowspan="<%=int.Parse(dt_cnt.Rows[dept++][2].ToString())+1 %>" class=xl30 style='height:17.25pt;border-top:none'>
    <%=dt_Emp.Rows[i][1].ToString()%>
 </td>
<%      }
        else if (dt_Emp.Rows[i][1].ToString() != dt_Emp.Rows[i-1][1].ToString())
        { 
         %>
<td height=23  rowspan="<%=int.Parse(dt_cnt.Rows[dept++][2].ToString())+1 %>" class=xl30 style='height:17.25pt;border-top:none'>
    <%=dt_Emp.Rows[i][1].ToString()%>
 </td>
 <%     } %>






   
  <td class=xl30 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][2].ToString() %></td>
  <%    for(int num=3; num<8;num++)            
        {  %>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][num].ToString()%></td>
  <%    }//for num  %>
  <%    if (dt_Allow.Rows[0][8].ToString().Equals("1"))
        { %>
<td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][8].ToString()%></td>
 <%     }
        if (dt_Allow.Rows[0][9].ToString().Equals("1"))
        {%>
<td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][9].ToString()%></td>          
<%      }
        if (dt_Allow.Rows[0][10].ToString().Equals("1"))
        {%>
<td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][10].ToString()%></td>          
<%      }
        if (dt_Allow.Rows[0][11].ToString().Equals("1"))
        {%>
<td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][11].ToString()%></td>          
<%      }
        if (dt_Allow.Rows[0][12].ToString().Equals("1"))
        {%>
<td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][12].ToString()%></td>          
<%      }
        if (dt_Allow.Rows[0][13].ToString().Equals("1"))
        {%>
<td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][13].ToString()%></td>          
<%      }
        if (dt_Allow.Rows[0][14].ToString().Equals("1"))
        {%>
<td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][14].ToString()%></td>          
<%      }
        if (dt_Allow.Rows[0][15].ToString().Equals("1"))
        {%>         
<td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][15].ToString()%></td> 
<%      }
        for (int num = 16; num < 36; num++)
        {
        %>
<td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][num].ToString()%></td>                     
<%      }%>       
<%    if (!dt_Allowk.Rows[0][0].ToString().Equals(""))
      {   %>
<td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][36].ToString()%></td>
 <%    }   %>  
<%    if (!dt_Allowk.Rows[0][1].ToString().Equals(""))
      {   %>
<td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][37].ToString()%></td>
 <%    }   %>  
          
<%    if (!dt_Allowk.Rows[0][2].ToString().Equals(""))
      {   %>
<td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][38].ToString()%></td>
 <%    }   %>  
          
<%    if (!dt_Allowk.Rows[0][3].ToString().Equals(""))
      {   %>
<td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][39].ToString()%></td>
 <%    }   %>  
          
<%    if (!dt_Allowk.Rows[0][4].ToString().Equals(""))
      {   %>
<td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][40].ToString()%></td>
 <%    }   %>  
          
<%    if (!dt_Allowk.Rows[0][5].ToString().Equals(""))
      {   %>
<td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][41].ToString()%></td>
 <%    }   %>  
          
<%    if (!dt_Allowk.Rows[0][6].ToString().Equals(""))
      {   %>
<td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][42].ToString()%></td>
 <%    }   %>  
          
<%    if (!dt_Allowk.Rows[0][7].ToString().Equals(""))
      {   %>
<td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][43].ToString()%></td>
 <%    }   %> 
 <%   for(int num=44; num<66;num++)
      {   %>
<td class=xl25 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][num].ToString()%></td>      
 <%   }         %> 
 <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 
 
 
 
 
 
 <%  if (i < dt_Emp.Rows.Count - 1)
     {
             if (dt_Emp.Rows[i][1].ToString() != dt_Emp.Rows[i + 1][1].ToString())
             {
  %>
 <tr height=26 style='userset;height:19.5pt'>
  <td colspan=1 height=26 class=xl43 width=275 style='border-right:.5pt solid black;
  height:19.5pt;width:206pt' x:str>SUM OF <%=dt_Emp.Rows[i][1].ToString()%></td>
<%    for(int num=2; num<8;num++)
        {  %>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[num]%></td>
  <%    }//for num  %>
  <%    if (dt_Allow.Rows[0][8].ToString().Equals("1"))
        { %>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[8]%></td>
 <%     }
        if (dt_Allow.Rows[0][9].ToString().Equals("1"))
        {%>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[9]%></td>          
<%      }
        if (dt_Allow.Rows[0][10].ToString().Equals("1"))
        {%>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[10]%></td>          
<%      }
        if (dt_Allow.Rows[0][11].ToString().Equals("1"))
        {%>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[11]%></td>         
<%      }
        if (dt_Allow.Rows[0][12].ToString().Equals("1"))
        {%>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[12]%></td>          
<%      }
        if (dt_Allow.Rows[0][13].ToString().Equals("1"))
        {%>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[13]%></td>          
<%      }
        if (dt_Allow.Rows[0][14].ToString().Equals("1"))
        {%>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[14]%></td>          
<%      }
        if (dt_Allow.Rows[0][15].ToString().Equals("1"))
        {%>         
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[15]%></td>
<%      }
        for (int num = 16; num < 36; num++)
        {
        %>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[num]%></td>
<%      }%>              
<%    if (!dt_Allowk.Rows[0][0].ToString().Equals(""))
      {   %>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[36]%></td>
<%    }   %>  
<%    if (!dt_Allowk.Rows[0][1].ToString().Equals(""))
      {   %>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[37]%></td>
 <%    }   %>  
          
<%    if (!dt_Allowk.Rows[0][2].ToString().Equals(""))
      {   %>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[38]%></td>
<%    }   %>          
<%    if (!dt_Allowk.Rows[0][3].ToString().Equals(""))
      {   %>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[39]%></td>
 <%    }   %>            
<%    if (!dt_Allowk.Rows[0][4].ToString().Equals(""))
      {   %>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[40]%></td>
 <%    }   %>  
          
<%    if (!dt_Allowk.Rows[0][5].ToString().Equals(""))
      {   %>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[41]%></td>
 <%    }   %>  
          
<%    if (!dt_Allowk.Rows[0][6].ToString().Equals(""))
      {   %>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[42]%></td>
 <%    }   %>  
          
<%    if (!dt_Allowk.Rows[0][7].ToString().Equals(""))
      {   %>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[43]%></td>
 <%    }   %> 
 <%   for(int num=44; num<65;num++)
      {   %>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[num]%></td>      
<%    }
      for (int num = 0; num < 65; num++)
          sum_dept[num] = 0;
%> 
 <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <%
            }
        }
        else if (i == dt_Emp.Rows.Count - 1)
        {
            %>
    <tr height=26 style='userset;height:19.5pt'>
  <td colspan=1 height=26 class=xl43 width=275 style='border-right:.5pt solid black;
  height:19.5pt;width:206pt' x:str>SUM OF <%=dt_Emp.Rows[i][1].ToString()%></td>
  <%    for(int num=2; num<8;num++)
        {  %>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[num]%></td>
  <%    }//for num  %>
  <%    if (dt_Allow.Rows[0][8].ToString().Equals("1"))
        { %>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[8]%></td>
 <%     }
        if (dt_Allow.Rows[0][9].ToString().Equals("1"))
        {%>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[9]%></td>          
<%      }
        if (dt_Allow.Rows[0][10].ToString().Equals("1"))
        {%>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[10]%></td>          
<%      }
        if (dt_Allow.Rows[0][11].ToString().Equals("1"))
        {%>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[11]%></td>         
<%      }
        if (dt_Allow.Rows[0][12].ToString().Equals("1"))
        {%>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[12]%></td>          
<%      }
        if (dt_Allow.Rows[0][13].ToString().Equals("1"))
        {%>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[13]%></td>          
<%      }
        if (dt_Allow.Rows[0][14].ToString().Equals("1"))
        {%>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[14]%></td>          
<%      }
        if (dt_Allow.Rows[0][15].ToString().Equals("1"))
        {%>         
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[15]%></td>
<%      }
        for (int num = 16; num < 36; num++)
        {
        %>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[num]%></td>
<%      }%>              
<%    if (!dt_Allowk.Rows[0][0].ToString().Equals(""))
      {   %>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[36]%></td>
<%    }   %>  
<%    if (!dt_Allowk.Rows[0][1].ToString().Equals(""))
      {   %>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[37]%></td>
 <%    }   %>  
          
<%    if (!dt_Allowk.Rows[0][2].ToString().Equals(""))
      {   %>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[38]%></td>
<%    }   %>          
<%    if (!dt_Allowk.Rows[0][3].ToString().Equals(""))
      {   %>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[39]%></td>
 <%    }   %>            
<%    if (!dt_Allowk.Rows[0][4].ToString().Equals(""))
      {   %>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[40]%></td>
 <%    }   %>  
          
<%    if (!dt_Allowk.Rows[0][5].ToString().Equals(""))
      {   %>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[41]%></td>
 <%    }   %>  
          
<%    if (!dt_Allowk.Rows[0][6].ToString().Equals(""))
      {   %>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[42]%></td>
 <%    }   %>  
          
<%    if (!dt_Allowk.Rows[0][7].ToString().Equals(""))
      {   %>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[43]%></td>
 <%    }   %> 
 <%   for(int num=44; num<65;num++)
      {   %>
<td class=xl31 style='border-top:none;border-left:none' x:num><%=sum_dept[num]%></td>      
<%    }
      for (int num = 0; num < 65; num++)
          sum_dept[num] = 0;
%>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>   
 <%
        }%>
<%      if (i < dt_Emp.Rows.Count - 1)
        {
             if (dt_Emp.Rows[i][0].ToString() != dt_Emp.Rows[i + 1][0].ToString())
             {
          %>
         <tr height=34 style='mso-height-source:userset;height:25.5pt'>
          <td colspan=2 height=34 class=xl33 width=275 style='border-right:.5pt solid black;
          height:25.5pt;width:206pt' x:str>TOTAL OF <%=dt_Emp.Rows[i][0].ToString()%></td>
<%    for(int num=2; num<8;num++)
        {  %>
  <td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[num]%></td>
  <%    }//for num  %>
  <%    if (dt_Allow.Rows[0][8].ToString().Equals("1"))
        { %>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[8]%></td>
 <%     }
        if (dt_Allow.Rows[0][9].ToString().Equals("1"))
        {%>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[9]%></td>          
<%      }
        if (dt_Allow.Rows[0][10].ToString().Equals("1"))
        {%>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[10]%></td>          
<%      }
        if (dt_Allow.Rows[0][11].ToString().Equals("1"))
        {%>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[11]%></td>         
<%      }
        if (dt_Allow.Rows[0][12].ToString().Equals("1"))
        {%>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[12]%></td>          
<%      }
        if (dt_Allow.Rows[0][13].ToString().Equals("1"))
        {%>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[13]%></td>          
<%      }
        if (dt_Allow.Rows[0][14].ToString().Equals("1"))
        {%>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[14]%></td>          
<%      }
        if (dt_Allow.Rows[0][15].ToString().Equals("1"))
        {%>         
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[15]%></td>
<%      }
        for (int num = 16; num < 36; num++)
        {
        %>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[num]%></td>
<%      }%>              
<%    if (!dt_Allowk.Rows[0][0].ToString().Equals(""))
      {   %>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[36]%></td>
<%    }   %>  
<%    if (!dt_Allowk.Rows[0][1].ToString().Equals(""))
      {   %>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[37]%></td>
 <%    }   %>  
          
<%    if (!dt_Allowk.Rows[0][2].ToString().Equals(""))
      {   %>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[38]%></td>
<%    }   %>          
<%    if (!dt_Allowk.Rows[0][3].ToString().Equals(""))
      {   %>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[39]%></td>
 <%    }   %>            
<%    if (!dt_Allowk.Rows[0][4].ToString().Equals(""))
      {   %>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[40]%></td>
 <%    }   %>  
          
<%    if (!dt_Allowk.Rows[0][5].ToString().Equals(""))
      {   %>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[41]%></td>
 <%    }   %>  
          
<%    if (!dt_Allowk.Rows[0][6].ToString().Equals(""))
      {   %>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[42]%></td>
 <%    }   %>  
          
<%    if (!dt_Allowk.Rows[0][7].ToString().Equals(""))
      {   %>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[43]%></td>
 <%    }   %> 
 <%   for(int num=44; num<65;num++)
      {   %>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[num]%></td>      
<%    }
      for (int num = 0; num < 65; num++)
          sum_mon[num] = 0;
%>                                                 
          <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
         </tr>          
<%
            }
        }
        else if (i == dt_Emp.Rows.Count-1)                 
        {
         %>
            <tr height=34 style='mso-height-source:userset;height:25.5pt'>
          <td colspan=2 height=34 class=xl33 width=275 style='border-right:.5pt solid black;
          height:25.5pt;width:206pt' x:str>TOTAL OF <%=dt_Emp.Rows[i][0].ToString()%></td>          
<%    for(int num=2; num<8;num++)
      {  %>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[num]%></td>
<%    }//for num  %>
  <%    if (dt_Allow.Rows[0][8].ToString().Equals("1"))
        { %>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[8]%></td>
 <%     }
        if (dt_Allow.Rows[0][9].ToString().Equals("1"))
        {%>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[9]%></td>          
<%      }
        if (dt_Allow.Rows[0][10].ToString().Equals("1"))
        {%>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[10]%></td>          
<%      }
        if (dt_Allow.Rows[0][11].ToString().Equals("1"))
        {%>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[11]%></td>         
<%      }
        if (dt_Allow.Rows[0][12].ToString().Equals("1"))
        {%>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[12]%></td>          
<%      }
        if (dt_Allow.Rows[0][13].ToString().Equals("1"))
        {%>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[13]%></td>          
<%      }
        if (dt_Allow.Rows[0][14].ToString().Equals("1"))
        {%>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[14]%></td>          
<%      }
        if (dt_Allow.Rows[0][15].ToString().Equals("1"))
        {%>         
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[15]%></td>
<%      }
        for (int num = 16; num < 36; num++)
        {
        %>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[num]%></td>
<%      }%>              
<%    if (!dt_Allowk.Rows[0][0].ToString().Equals(""))
      {   %>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[36]%></td>
<%    }   %>  
<%    if (!dt_Allowk.Rows[0][1].ToString().Equals(""))
      {   %>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[37]%></td>
 <%    }   %>  
          
<%    if (!dt_Allowk.Rows[0][2].ToString().Equals(""))
      {   %>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[38]%></td>
<%    }   %>          
<%    if (!dt_Allowk.Rows[0][3].ToString().Equals(""))
      {   %>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[39]%></td>
 <%    }   %>            
<%    if (!dt_Allowk.Rows[0][4].ToString().Equals(""))
      {   %>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[40]%></td>
 <%    }   %>  
          
<%    if (!dt_Allowk.Rows[0][5].ToString().Equals(""))
      {   %>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[41]%></td>
 <%    }   %>  
          
<%    if (!dt_Allowk.Rows[0][6].ToString().Equals(""))
      {   %>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[42]%></td>
 <%    }   %>  
          
<%    if (!dt_Allowk.Rows[0][7].ToString().Equals(""))
      {   %>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[43]%></td>
 <%    }   %> 
 <%   for(int num=44; num<65;num++)
      {   %>
<td class=xl27 style='border-top:none;border-left:none' x:num><%=sum_mon[num]%></td>      
<%    }
      for (int num = 0; num < 65; num++)
          sum_mon[num] = 0;
%>                                                          
          <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
         </tr>           
<%      } %>        
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
