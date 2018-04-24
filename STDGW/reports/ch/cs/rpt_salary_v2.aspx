<%@ Page Language="C#"%>
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
    string p_org, p_org_type, p_status, pos, lsttmp, txttmp, dtyear, fromjoin, tojoin, lstmoney, contract;
    string lstmon_year, from_mon_year, to_mon_year, lstSal_l1, fromsal_l1, tosal_l1, lstSal_l2, fromsal_l2, tosal_l2;
    // dept=ALL&code=ALL&pos=ALL&lsttmp=2
    // &txttmp=undefined&dtyear=2008&contract=ALL&status=A&fromjoin=&tojoin=&lstmoney=ALL
    // lstmon_year = MON & from_mon_year = &to_mon_year = &lstTmp = A0 & fromsal = &tosal =
    p_org = Request["org"].ToString();
    p_org_type = Request["org_type"].ToString();
    p_status = Request["status"].ToString();
    pos = Request["pos"].ToString();
    lsttmp = Request["lsttmp"].ToString();
    txttmp = Request["txttmp"].ToString();
   
    fromjoin = Request["fromjoin"].ToString();
    tojoin = Request["tojoin"].ToString();
    lstmoney = Request["lstmoney"].ToString();
    contract = Request["contract"].ToString();
    lstmon_year = Request["lstmon_year"].ToString();
    from_mon_year = Request["from_mon_year"].ToString();
    to_mon_year = Request["to_mon_year"].ToString();
    lstSal_l1 = Request["lstSal_L1"].ToString();
    fromsal_l1 = Request["fromsal_L1"].ToString();
    tosal_l1 = Request["tosal_L1"].ToString();
    lstSal_l2 = Request["lstSal_L2"].ToString();
    fromsal_l2 = Request["fromsal_L2"].ToString();
    tosal_l2 = Request["tosal_L2"].ToString();


    string SQL_Com
    = "select  a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,a.TCO_BPPHOTO_PK,0,0 " +
        "from tco_company a " +
        "where a.DEL_IF=0 " +
        "and a.pk in ( select tco_company_pk from  " +
        "               tco_org  f " +
        "               where  f.pk IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_org + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_org + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_org + "' = 'ALL') " +
        "and rownum=1 ";

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
    int pk = int.Parse(dt_Com.Rows[0][3].ToString());

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
        "               WHERE a.ID = 'HR0019'  ) allow_amt ";
    DataTable dt_Allow = ESysLib.TableReadOpen(SQL_Allow);
    int irow_Allow;
    irow_Allow = dt_Allow.Rows.Count;
    if (irow_Allow == 0)
    {
        Response.Write("There is no data of allowance");
        Response.End();
    }
    int col_span = 3;
    for (int j = 8; j < 16; j++)
        if (dt_Allow.Rows[0][j].ToString() == "1")
            col_span++; 
    
    string SQL
    = "SELECT   (SELECT   MAX(T.org_NM)"+
      "              FROM tco_org t "+
      "              WHERE t.del_if = 0 "+
      "              AND T.org_TYPE IN('06')"+
      "              START WITH t.pk=a.tco_org_pk "+
      "              CONNECT BY PRIOR t.p_pk=t.pk) AS dept_NM "+
        ",b.org_nm, a.emp_id, a.full_name " +
        "               ,TO_CHAR (TO_DATE (a.join_dt, 'yyyymmdd'), 'dd/mm/yyyy') " +
        "                ,nvl(a.pro_sal,0),d.code_nm,p.code_nm,nvl(a.LEVEL1_SAL,0) " +
        " ,nvl(a.SALARY_L1_K1,0),nvl(a.SALARY_L1_K2,0),nvl(a.SALARY_L1_K3,0) " +
        "                ,nvl(a.ALLOW_AMT1_l1,0),nvl(a.ALLOW_AMT2_l1,0),nvl(a.ALLOW_AMT3_l1,0),nvl(a.ALLOW_AMT4_l1,0) " +
        "                ,nvl(a.ALLOW_AMT5_l1,0),nvl(a.ALLOW_AMT6_l1,0),nvl(a.ALLOW_AMT7_l1,0),nvl(a.ALLOW_AMT8_l1,0) " +
        "               ,TO_CHAR (TO_DATE (a.CONFIRM_DT, 'yyyymmdd'), 'dd/mm/yyyy') " +
        "                ,nvl(a.BASIC_SAL,0),nvl(a.salary_l2_k1,0),nvl(a.salary_l2_k2,0),nvl(a.salary_l2_k3,0) " +
        "                ,nvl(a.ALLOW_AMT1,0),nvl(a.ALLOW_AMT2,0),nvl(a.ALLOW_AMT3,0),nvl(a.ALLOW_AMT4,0) " +
        "                ,nvl(a.ALLOW_AMT5,0),nvl(a.ALLOW_AMT6,0),nvl(a.ALLOW_AMT7,0),nvl(a.ALLOW_AMT8,0) " +
        "          FROM thr_employee a,tco_org b, " +
        "               (SELECT code, code_nm FROM vhr_hr_code WHERE ID = 'HR0001') d, " +
        "                  (SELECT code, code_nm FROM vhr_hr_code WHERE ID = 'HR0008') p " +
        "         WHERE a.del_if = 0 " +
        "           AND b.del_if = 0 " +
        "           AND a.tco_org_pk = b.pk " +
        "           AND a.contract_type = d.code(+) " +
        "           and a.pos_type=p.code(+) " +
        "          AND DECODE ('" + p_org_type + "', 'ALL', '" + p_org_type + "', b.org_type) = " +
        "                                                                '" + p_org_type + "' " +
        "           AND (   a.tco_org_pk IN ( " +
        "                              SELECT g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_org + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_org + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_org + "' = 'ALL') " +
        "           AND DECODE ('" + pos + "', 'ALL', '" + pos + "', a.pos_type) = '" + pos + "' " +
        "           AND DECODE ('" + p_status + "', 'ALL', '" + p_status + "', a.status) = '" + p_status + "' " +
        "  AND DECODE ('" + contract + "','ALL','" + contract + "',a.contract_type) = '" + contract + "'" +
        "  AND UPPER (DECODE ('"+lsttmp+"',1, a.full_name,2, a.emp_id,a.id_num)) LIKE '%' || UPPER ('"+txttmp+"') || '%' " +
        "           AND (   '"+fromjoin+"' IS NULL " +
        "                OR '"+tojoin+"' IS NULL " +
        "                OR a.join_dt BETWEEN '" + fromjoin + "' AND '" + tojoin + "' " +
        "               ) " +
        "           AND (   (    (   MONTHS_BETWEEN (SYSDATE, " +
        "                                            TO_DATE (a.join_dt, 'yyyymmdd') " +
        "                                           ) BETWEEN '"+from_mon_year+"' " +
        "                                                 AND '"+to_mon_year+"'" +
        "                         OR '" + from_mon_year + "' IS NULL " +
        "                         OR '" + to_mon_year + "' IS NULL " +
        "                        ) " +
        "                    AND '"+lstmon_year+"' = 'MON' " +
        "                   ) " +
        "                OR (    (     MONTHS_BETWEEN (SYSDATE, " +
        "                                              TO_DATE (a.join_dt, 'yyyymmdd') " +
        "                                             ) " +
        "                            / 12 BETWEEN '" + from_mon_year + "' AND '" + to_mon_year + "' " +
        "                         OR '" + from_mon_year + "' IS NULL " +
        "                         OR '" + to_mon_year + "' IS NULL " +
        "                        ) " +
        "                    AND '" + lstmon_year + "' = 'YEAR' " +
        "                   ) " +
        "               ) " +
        " AND ( DECODE('" + lstSal_l1 + "','0',nvl(a.SALARY_L1_K1,0),'1',nvl(a.SALARY_L1_K2,0),'2',nvl(a.SALARY_L1_K3,0),'A1',nvl(a.ALLOW_AMT1_l1,0) "+
        " ,'A2',nvl(a.ALLOW_AMT2_l1,0),'A3',nvl(a.ALLOW_AMT3_l1,0),'A4',nvl(a.ALLOW_AMT4_l1,0),'A5',nvl(a.ALLOW_AMT5_l1,0) " +
        "  ,'A6',nvl(a.ALLOW_AMT6_l1,0),'A7',nvl(a.ALLOW_AMT7_l1,0),'A8',nvl(a.ALLOW_AMT8_l1,0)) BETWEEN '"+fromsal_l1+"' AND '"+tosal_l1+"' " +
        "                OR '" + fromsal_l1 + "' IS NULL " +
        "                OR '" + tosal_l1 + "' IS NULL " +
        "               ) " +
        " AND ( DECODE('" + lstSal_l2 + "','0',nvl(a.SALARY_L2_K1,0),'1',nvl(a.SALARY_L2_K2,0),'2',nvl(a.SALARY_L2_K3,0),'A1',nvl(a.ALLOW_AMT1,0) " +
        " ,'A2',nvl(a.ALLOW_AMT2,0),'A3',nvl(a.ALLOW_AMT3,0),'A4',nvl(a.ALLOW_AMT4,0),'A5',nvl(a.ALLOW_AMT5,0) " +
        "  ,'A6',nvl(a.ALLOW_AMT6,0),'A7',nvl(a.ALLOW_AMT7,0),'A8',nvl(a.ALLOW_AMT8,0)) BETWEEN '" + fromsal_l1 + "' AND '" + tosal_l1 + "' " +
        "                OR '" + fromsal_l2 + "' IS NULL " +
        "                OR '" + tosal_l2 + "' IS NULL " +
        "               ) " +
        "      AND DECODE('" + lstmoney + "','ALL','" + lstmoney + "',A.MONEY_KIND)='" + lstmoney + "'  " +
        "      ORDER BY NVL(B.SEQ,0),B.org_nm, A.emp_id ";

    //Response.Write(SQL);
    //Response.End();
    
        DataTable dt_emp = ESysLib.TableReadOpen(SQL);
        int emp_row = 0;
        if (dt_emp.Rows.Count == 0)
        {
            Response.Write("There is no data to show");
            Response.End();
        }
        else
        {
            emp_row = dt_emp.Rows.Count;
        }
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_salary_summary_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_salary_summary_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_salary_summary_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Hee</o:Author>
  <o:LastAuthor>Hee</o:LastAuthor>
  <o:Created>2008-09-26T02:35:53Z</o:Created>
  <o:LastSaved>2008-09-30T03:38:05Z</o:LastSaved>
  <o:Company>Hee Nguyen</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
.font12
	{color:windowtext;
	font-size:12.0pt;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl28
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl29
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl35
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";}
.xl36
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
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
.xl43
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
.xl44
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
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl46
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
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl47
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
	background:#FFCC99;
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
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
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
      <x:Scale>32</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>6</x:SplitHorizontal>
     <x:TopRowBottomPane>6</x:TopRowBottomPane>
     <x:SplitVertical>5</x:SplitVertical>
     <x:LeftColumnRightPane>5</x:LeftColumnRightPane>
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
       <x:ActiveRow>5</x:ActiveRow>
       <x:ActiveCol>23</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
      <x:RowBreak>
       <x:Row>5</x:Row>
      </x:RowBreak>
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
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$6</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2228 style='border-collapse:
 collapse;table-layout:fixed;width:1678pt'>
 <col class=xl24 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col width=122 style='mso-width-source:userset;mso-width-alt:4461;width:92pt'>
 <col width=128 style='mso-width-source:userset;mso-width-alt:4681;width:96pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=181 style='mso-width-source:userset;mso-width-alt:6619;width:136pt'>
 <col width=76 style='mso-width-source:userset;mso-width-alt:2779;width:57pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=84 style='mso-width-source:userset;mso-width-alt:3072;width:63pt'>
 <col width=83 style='mso-width-source:userset;mso-width-alt:3035;width:62pt'>
 <col width=82 style='mso-width-source:userset;mso-width-alt:2998;width:62pt'>
 <col width=88 style='mso-width-source:userset;mso-width-alt:3218;width:66pt'>
 <col width=82 span=8 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col width=86 style='mso-width-source:userset;mso-width-alt:3145;width:65pt'>
 <col width=81 style='mso-width-source:userset;mso-width-alt:2962;width:61pt'>
 <col width=83 style='mso-width-source:userset;mso-width-alt:3035;width:62pt'>
 <col width=88 style='mso-width-source:userset;mso-width-alt:3218;width:66pt'>
 <col width=82 span=8 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <tr class=xl24 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 width=43 style='height:21.75pt;width:32pt' align=left
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
   margin-left:0;margin-top:0;width:46.5pt;height:42pt;z-index:1'>
   <v:imagedata src="http://localhost:1051/ESYS/system/binary/ViewFile.aspx?img_pk=66&amp;table_name=tco_bpphoto"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:0px;width:62px;
  height:56px'><img width=62 height=56
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=pk%>&table_name=tco_bpphoto"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=29 class=xl34 width=43 style='height:21.75pt;width:32pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl25 colspan=2 width=250 style='mso-ignore:colspan;width:188pt'><%=dt_Com.Rows[0][0].ToString() %></td>
  <td class=xl25 width=72 style='width:54pt'></td>
  <td class=xl27 width=181 style='width:136pt'></td>
  <td class=xl24 width=76 style='width:57pt'></td>
  <td class=xl24 width=89 style='width:67pt'></td>
  <td class=xl24 width=84 style='width:63pt'></td>
  <td class=xl24 width=83 style='width:62pt'></td>
  <td class=xl27 width=82 style='width:62pt'></td>
  <td class=xl27 width=88 style='width:66pt'>SALARY INFORMATION </td>

 </tr>
 <tr class=xl24 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl34 style='height:18.75pt'></td>
  <td class=xl25><%=dt_Com.Rows[0][1].ToString().ToUpper() %></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl28></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl28>THÔNG TIN LƯƠNG </td>
  <td colspan=15 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl34 style='height:12.0pt'></td>
  <td class=xl25>Phone : <%=dt_Com.Rows[0][2].ToString() %></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl26></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=18 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 style='height:12.75pt'></td>
  <td colspan=30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=39 style='mso-height-source:userset;height:29.25pt'>
  <td rowspan=2 height=102 class=xl45 width=43 style='height:76.5pt;width:32pt'>No.<br>
    <font class="font12">STT</font></td>
  <td rowspan=2 class=xl44 width=122 style='width:92pt'>DEPARTMENT<br>
    <font class="font12">Bộ phận</font></td>
  <td rowspan=2 class=xl44 width=128 style='width:96pt'>Team/Section<br>
    <font class="font12">Nhóm</font></td>
  <td rowspan=2 class=xl44 width=72 style='width:54pt'>Emp ID<br>
    <font class="font12">Mã NV</font></td>
  <td rowspan=2 class=xl44 width=181 style='width:136pt'>Full Name<br>
    <font class="font12">Họ và Tên</font></td>
  <td rowspan=2 class=xl44 width=76 style='width:57pt'>Join Date<br>
    <font class="font12">Ngày vào</font></td>
  <td rowspan=2 class=xl42 width=89 style='border-bottom:.5pt solid black;
  width:67pt'>Contract<br>
    <font class="font12">Loại HĐ</font></td>
  <td rowspan=2 class=xl42 width=89 style='border-bottom:.5pt solid black;
  width:67pt'>Position<br>
    <font class="font12">Chức vụ</font></td>  
  <td rowspan=2 class=xl42 width=89 style='border-bottom:.5pt solid black;
  width:67pt'>Salary L1<br>
    <font class="font12">Lương mức 1</font></td>   
  <td colspan=<%=col_span %> class=xl46 width=993 style='border-right:.5pt solid black;
  border-left:none;width:749pt'>Salary and Allowance informations Level 1<br>
    <font class="font12">Mức lương và phụ cấp hiện tại mức 1</font></td>
  <td rowspan=2 class=xl42 width=89 style='border-bottom:.5pt solid black;
  width:67pt'>Confirm DT<br>
    <font class="font12"></font></td>     
  <td rowspan=2 class=xl42 width=89 style='border-bottom:.5pt solid black;
  width:67pt'>Salary L2<br>
    <font class="font12">Lương mức 2</font></td>   
  <td colspan=<%=col_span %> class=xl33 width=994 style='border-left:none;width:750pt'>Salary
  and Allowance information Level 2 <br>
    <font class="font12">Mức lương và phụ cấp hiện tại mức 2</font></td>
 </tr>
 <tr class=xl31 height=63 style='page-break-before:always;mso-height-source:userset;height:47.25pt'>
  <td height=63 class=xl32 width=84 style='height:47.25pt;border-top:none;
  border-left:none;width:63pt'>Basic<span style='mso-spacerun:yes'> </span></td>
  <td class=xl32 width=83 style='border-top:none;border-left:none;width:62pt'>Addition</td>
  <td class=xl32 width=82 style='border-top:none;border-left:none;width:62pt'>Crane</td>
  <%    if (dt_Allow.Rows[0][8].ToString() == "1")
        {//phu cap thu 1
  %>
  <td class=xl32 width=82 style='border-top:none;border-left:none;width:62pt'><%=dt_Allow.Rows[0][0].ToString() %></td>
  <%
        }
        if(dt_Allow.Rows[0][9].ToString()=="1")
        {//phu cap thu 2
   %>
  <td class=xl32 width=82 style='border-top:none;border-left:none;width:62pt'><%=dt_Allow.Rows[0][1].ToString() %></td>
  <%
        }
        if(dt_Allow.Rows[0][10].ToString()=="1")
        {//phu cap thu 3
   %>
  <td class=xl32 width=82 style='border-top:none;border-left:none;width:62pt'><%=dt_Allow.Rows[0][2].ToString() %></td>
  <%
        }
        if(dt_Allow.Rows[0][11].ToString()=="1")
        {//phu cap thu 4
   %>
  <td class=xl32 width=82 style='border-top:none;border-left:none;width:62pt'><%=dt_Allow.Rows[0][3].ToString() %></td>
  <%
        }
        if(dt_Allow.Rows[0][12].ToString()=="1")
        {//phu cap thu 5
   %>
  <td class=xl32 width=82 style='border-top:none;border-left:none;width:62pt'><%=dt_Allow.Rows[0][4].ToString() %></td>
  <%
        }
        if(dt_Allow.Rows[0][13].ToString()=="1")
        {//phu cap thu 6
   %>
  <td class=xl32 width=82 style='border-top:none;border-left:none;width:62pt'><%=dt_Allow.Rows[0][5].ToString() %></td>
  <%
        }
        if(dt_Allow.Rows[0][14].ToString()=="1")
        {//phu cap thu 7
   %>
  <td class=xl32 width=82 style='border-top:none;border-left:none;width:62pt'><%=dt_Allow.Rows[0][6].ToString() %></td>
  <%
        }
        if(dt_Allow.Rows[0][15].ToString()=="1")
        {//phu cap thu 8
   %>
  <td class=xl32 width=82 style='border-top:none;border-left:none;width:62pt'><%=dt_Allow.Rows[0][7].ToString() %></td>
  <%
        }        
   %>
  <td class=xl33 width=86 style='border-top:none;border-left:none;width:65pt'>Basic</td>
  <td class=xl33 width=81 style='border-top:none;border-left:none;width:61pt'>Addition</td>
  <td class=xl33 width=83 style='border-top:none;border-left:none;width:62pt'>Crane</td>
  <%    if (dt_Allow.Rows[0][8].ToString() == "1")
        {//phu cap thu 1
  %>
  <td class=xl33 width=82 style='border-top:none;border-left:none;width:62pt'><%=dt_Allow.Rows[0][0].ToString() %></td>
  <%
        }
        if(dt_Allow.Rows[0][9].ToString()=="1")
        {//phu cap thu 2
   %>
  <td class=xl33 width=82 style='border-top:none;border-left:none;width:62pt'><%=dt_Allow.Rows[0][1].ToString() %></td>
  <%
        }
        if(dt_Allow.Rows[0][10].ToString()=="1")
        {//phu cap thu 3
   %>
  <td class=xl33 width=82 style='border-top:none;border-left:none;width:62pt'><%=dt_Allow.Rows[0][2].ToString() %></td>
  <%
        }
        if(dt_Allow.Rows[0][11].ToString()=="1")
        {//phu cap thu 4
   %>
  <td class=xl33 width=82 style='border-top:none;border-left:none;width:62pt'><%=dt_Allow.Rows[0][3].ToString() %></td>
  <%
        }
        if(dt_Allow.Rows[0][12].ToString()=="1")
        {//phu cap thu 5
   %>
  <td class=xl33 width=82 style='border-top:none;border-left:none;width:62pt'><%=dt_Allow.Rows[0][4].ToString() %></td>
  <%
        }
        if(dt_Allow.Rows[0][13].ToString()=="1")
        {//phu cap thu 6
   %>
  <td class=xl33 width=82 style='border-top:none;border-left:none;width:62pt'><%=dt_Allow.Rows[0][5].ToString() %></td>
  <%
        }
        if(dt_Allow.Rows[0][14].ToString()=="1")
        {//phu cap thu 7
   %>
  <td class=xl33 width=82 style='border-top:none;border-left:none;width:62pt'><%=dt_Allow.Rows[0][6].ToString() %></td>
  <%
        }
        if(dt_Allow.Rows[0][15].ToString()=="1")
        {//phu cap thu 8
   %>
  <td class=xl33 width=82 style='border-top:none;border-left:none;width:62pt'><%=dt_Allow.Rows[0][7].ToString() %></td>
  <%
        }
   %>
 </tr>
 <%
    int i = 0;
     double[] sum = new double[33] {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 };
     for (i = 0; i < emp_row; i++)
     {
         sum[8] += Double.Parse(dt_emp.Rows[i][8].ToString());
         sum[9] += Double.Parse(dt_emp.Rows[i][9].ToString());
         sum[10] += Double.Parse(dt_emp.Rows[i][10].ToString());
         sum[11] += Double.Parse(dt_emp.Rows[i][11].ToString());
         sum[12] += Double.Parse(dt_emp.Rows[i][12].ToString());
         sum[13] += Double.Parse(dt_emp.Rows[i][13].ToString());
         sum[14] += Double.Parse(dt_emp.Rows[i][14].ToString());
         sum[15] += Double.Parse(dt_emp.Rows[i][15].ToString());
         sum[16] += Double.Parse(dt_emp.Rows[i][16].ToString());
         sum[17] += Double.Parse(dt_emp.Rows[i][17].ToString());
         sum[18] += Double.Parse(dt_emp.Rows[i][18].ToString());
         sum[19] += Double.Parse(dt_emp.Rows[i][19].ToString());
         
         sum[21] += Double.Parse(dt_emp.Rows[i][21].ToString());
         sum[23] += Double.Parse(dt_emp.Rows[i][23].ToString());
         sum[24] += Double.Parse(dt_emp.Rows[i][24].ToString());
         sum[25] += Double.Parse(dt_emp.Rows[i][25].ToString());
         sum[26] += Double.Parse(dt_emp.Rows[i][26].ToString());
         sum[27] += Double.Parse(dt_emp.Rows[i][27].ToString());
         sum[28] += Double.Parse(dt_emp.Rows[i][28].ToString());
         sum[29] += Double.Parse(dt_emp.Rows[i][29].ToString());
         sum[30] += Double.Parse(dt_emp.Rows[i][30].ToString());
         sum[31] += Double.Parse(dt_emp.Rows[i][31].ToString());
         sum[32] += Double.Parse(dt_emp.Rows[i][32].ToString());
 %>
 <tr class=xl36 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl38 style='height:22.5pt;border-top:none' x:num><%=i+1 %></td>
  <td class=xl39 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][0].ToString() %></td>
  <td class=xl39 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][1].ToString() %></td>
  <td class=xl39 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][2].ToString() %></td>
  <td class=xl39 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][3].ToString() %></td>
  <td class=xl50 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][4].ToString() %></td>
  <td class=xl40 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][6].ToString() %></td>
  <td class=xl41 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][7].ToString() %></td>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][8].ToString() %></td>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][9].ToString() %></td>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][10].ToString() %></td>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][11].ToString() %></td>
  
   <%       
     if (dt_Allow.Rows[0][8].ToString() == "1")
     {//phu cap thu 1
   %>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][12].ToString() %></td>
   <%
     }
     if (dt_Allow.Rows[0][9].ToString() == "1")
     {//phu cap thu 2
   %>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][13].ToString() %></td>
   <%
     }
     if (dt_Allow.Rows[0][10].ToString() == "1")
     {//phu cap thu 3
   %>   
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][14].ToString() %></td>
   <%
     }
     if (dt_Allow.Rows[0][11].ToString() == "1")
     {//phu cap thu 4
   %>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][15].ToString() %></td>
   <%
     }
     if (dt_Allow.Rows[0][12].ToString() == "1")
     {//phu cap thu 5
   %>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][16].ToString() %></td>
   <%
     }
     if (dt_Allow.Rows[0][13].ToString() == "1")
     {//phu cap thu 6
   %>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][17].ToString() %></td>
   <%
     }
     if (dt_Allow.Rows[0][14].ToString() == "1")
     {//phu cap thu 7
   %>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][18].ToString() %></td>
   <%
     }
     if (dt_Allow.Rows[0][15].ToString() == "1")
     {//phu cap thu 8
   %>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][19].ToString() %></td>
  <%
     }
  %>
  <td class=xl41 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][20].ToString() %></td>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][21].ToString() %></td>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][22].ToString() %></td>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][23].ToString() %></td>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][24].ToString() %></td>
  <%
     if (dt_Allow.Rows[0][8].ToString() == "1")
     {//phu cap thu 1
   %>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][25].ToString() %></td>
  <%
     }
     if (dt_Allow.Rows[0][9].ToString() == "1")
     {//phu cap thu 2
   %>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][26].ToString() %></td>
  <%
     }
     if (dt_Allow.Rows[0][10].ToString() == "1")
     {//phu cap thu 3
   %>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][27].ToString() %></td>
  <%
     }
     if (dt_Allow.Rows[0][11].ToString() == "1")
     {//phu cap thu 4
   %>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][28].ToString() %></td>
  <%
     }
     if (dt_Allow.Rows[0][12].ToString() == "1")
     {//phu cap thu 5
   %>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][29].ToString() %></td>
  <%
     }
     if (dt_Allow.Rows[0][13].ToString() == "1")
     {//phu cap thu 6
   %>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][30].ToString() %></td>
  <%
     }
     if (dt_Allow.Rows[0][14].ToString() == "1")
     {//phu cap thu 7
   %>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][31].ToString() %></td>
  <%
     }
     if (dt_Allow.Rows[0][15].ToString() == "1")
     {//phu cap thu 8
   %>
  <td class=xl41 style='border-top:none;border-left:none' x:num><%=dt_emp.Rows[i][32].ToString() %></td>
  <%    }
       %>
 </tr>
 <%
     }//  <~~~~dau ngoac cua vong for
 %>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=8 height=28 class=xl37 style='height:21.0pt'>Total <%=i %> Employee(s)</td>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=sum[8] %></td>  
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=sum[9] %></td>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=sum[10] %></td>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=sum[11] %></td>
  <%
    
        if(dt_Allow.Rows[0][8].ToString()=="1")
        {//phu cap thu 1
  %>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=sum[12] %></td>
  <%
      }
        if(dt_Allow.Rows[0][9].ToString()=="1")
        {//phu cap thu 2
  %>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=sum[13] %></td>
  <%
      }
        if(dt_Allow.Rows[0][10].ToString()=="1")
        {//phu cap thu 3
  %>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=sum[14] %></td>
  <%
      }
        if(dt_Allow.Rows[0][11].ToString()=="1")
        {//phu cap thu 4
  %>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=sum[15] %></td>
  <%
      }
        if(dt_Allow.Rows[0][12].ToString()=="1")
        {//phu cap thu 5
  %>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=sum[16] %></td>
  <%
      }
        if(dt_Allow.Rows[0][13].ToString()=="1")
        {//phu cap thu 6
  %>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=sum[17] %></td>
  <%
      }
        if(dt_Allow.Rows[0][14].ToString()=="1")
        {//phu cap thu 7
  %>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=sum[18] %></td>
  <%
      }
      if (dt_Allow.Rows[0][15].ToString() == "1")
      {//phu cap thu 8
  %>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=sum[19] %></td>
  <%
      }
  %>
  <td class=xl49 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=sum[21] %></td>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=sum[22] %></td>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=sum[23] %></td>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=sum[24] %></td>
  <%
        if(dt_Allow.Rows[0][8].ToString()=="1")
        {//phu cap thu 1
  %>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=sum[25] %></td>
  <%
      }
        if(dt_Allow.Rows[0][9].ToString()=="1")
        {//phu cap thu 2
  %>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=sum[26] %></td>
  <%
      }
        if(dt_Allow.Rows[0][10].ToString()=="1")
        {//phu cap thu 3
  %>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=sum[27] %></td>
  <%
      }
        if(dt_Allow.Rows[0][11].ToString()=="1")
        {//phu cap thu 4
  %>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=sum[28] %></td>
  <%
      }
        if(dt_Allow.Rows[0][12].ToString()=="1")
        {//phu cap thu 5
  %>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=sum[29] %></td>
  <%
      }
        if(dt_Allow.Rows[0][13].ToString()=="1")
        {//phu cap thu 6
  %>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=sum[30] %></td>
  <%
      }
        if(dt_Allow.Rows[0][14].ToString()=="1")
        {//phu cap thu 7
  %>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=sum[31] %></td>
  <%
      }
        if(dt_Allow.Rows[0][15].ToString()=="1")
        {//phu cap thu 8
  %>  
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=sum[32] %></td>
  <%
        }
  %>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=43 style='width:32pt'></td>
  <td width=122 style='width:92pt'></td>
  <td width=128 style='width:96pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=181 style='width:136pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
