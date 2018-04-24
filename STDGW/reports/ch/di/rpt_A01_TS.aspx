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
    
    
    string emp_pk, rpt_type, p_company_pk;

    emp_pk = Request["emp_pk"].ToString();
    rpt_type = Request["rpt_type"].ToString();
    p_company_pk = Request["company_pk"].ToString();

    if (p_company_pk == "")
        p_company_pk = "ALL";         
    
    string SQL_AMT
    = "SELECT NVL(A.NUM_1,0) " +
        "    FROM VHR_HR_CODE A " +
        "    WHERE A.ID='HR0043' AND A.CHAR_1= TO_CHAR(SYSDATE, 'YYYY') " +
        " and (nvl(to_char(TCO_COMPANY_PK),'" + p_company_pk + "') = '" + p_company_pk + "' or '" + p_company_pk + "' = 'ALL')  ";

    DataTable dt_amt = ESysLib.TableReadOpen(SQL_AMT);
    int social_amt = int.Parse(dt_amt.Rows[0][0].ToString());
    
    string  SQL
    = "select E.SOCIAL_NO c00 " +
        "        ,E.FULL_NAME c01 " +
        "        ,E.SEX c02 " +
        "        , decode(length(E.BIRTH_DT),4,E.BIRTH_DT,to_char(to_date(E.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy')) c03 " +
        "        , (select code_nm from vhr_hr_code v where id='HR0015' and v.code=E.ETHNIC_TYPE ) c04 " +
        "        , (select code_fnm from vhr_hr_code v where id='HR0009' and v.code=E.NATION ) c05 " +
        "        , E.PERMANENT_ADDR c06 " +
        "        , E.PERMANENT_ADDR c07 " +
        "        , E.TEL c08 " +
        "        , E.TEL_OTHER c09 " +
        "        , E.PERSON_ID c10 " +
        "        , to_char(to_date(E.ISSUE_DT,'yyyymmdd'),'dd/mm/yyyy') c11 " +
        "        , (select code_nm from vhr_hr_code v where id='HR0014' and v.code=E.PLACE_PER_ID ) c12  " +
        "        , (select A.CONTRACT_NO from thr_labour_contract a where A.DEL_IF=0 and A.THR_EMPLOYEE_PK=E.PK and A.CONTRACT_TIMES=2) c13 " +
        "        , (select to_char(to_date(a.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') from thr_labour_contract a "+
        "               where A.DEL_IF=0 and A.THR_EMPLOYEE_PK=E.PK and A.CONTRACT_TIMES=2) c14  " +
        "        , (select char_2 from vhr_hr_code v, thr_labour_contract a where id='HR0001' "+ 
        "               and v.code=a.contract_type and a.contract_times=2 and a.del_if=0 and a.thr_employee_pk=e.pk ) c15 " +
        "        , (select C.PARTNER_LNAME  " +
        "            from tco_company c, tco_org g  " +
        "            where C.DEL_IF=0  " +
        "                and g.PK=E.TCO_ORG_PK " +
        "                and G.DEL_IF=0 " +
        "                and G.TCO_COMPANY_PK = c.pk  ) c16 " +
        "        , (select (C.ADDR1)  " +
        "            from tco_company c, tco_org g  " +
        "            where C.DEL_IF=0  " +
        "                and g.PK=E.TCO_ORG_PK " +
        "                and G.DEL_IF=0 " +
        "                and G.TCO_COMPANY_PK = c.pk  ) c17    " +
        "        , (select code_knm from vhr_hr_code v where id='HR0008' and v.code=E.POS_TYPE ) c19     " +
        "        ,(case when substr(BEGIN_CONTRACT,-2) > '15' then to_char(add_months(to_date(e.BEGIN_CONTRACT,'yyyymmdd'),1),'mm/yyyy')  " +
        "           else  to_char(to_date(e.BEGIN_CONTRACT,'yyyymmdd'),'mm/yyyy') end) c20 " +
        "        ,(case when substr(BEGIN_CONTRACT,-2) > '15' then to_char(add_months(to_date(e.BEGIN_CONTRACT,'yyyymmdd'),1),'mm/yyyy')  " +
        "           else  to_char(to_date(e.BEGIN_CONTRACT,'yyyymmdd'),'mm/yyyy') end) c21    " +
        "        , (Select (CASE WHEN nvl(s.salary_level2,0) > " + social_amt + " THEN to_char(" + social_amt + ",'999,999,999') ELSE  TO_CHAR(s.salary_level2,'999,999,999') END) " + 
        "               from THR_SALARY_MANAGE s  " +
        "            where s.del_if=0 and s.thr_emp_pk=e.pk and s.work_mon=(case when substr(BEGIN_CONTRACT,-2) > '15'  " +
        "                                                                                                    then to_char(add_months(to_date(e.BEGIN_CONTRACT,'yyyymmdd'),1),'yyyymm')  " +
        "                                                                                                    else  to_char(to_date(e.BEGIN_CONTRACT,'yyyymmdd'),'yyyymm') end)) c22                   " +
        "       , E.PHOTO_PK c23,    (select code_nm from vhr_hr_code v where id='HR0012' and v.code=E.HEALTH_PLACE  )  c24 " +
		"        , (select code_fnm from vhr_hr_code v where id='HR0010' and v.code=E.JOB_TYPE ) c25 ,e.health_no c26    " +
        "        ,e.pk as c27 " +
        "from thr_employee e " +
        "where e.del_if=0 and e.pk in (" + emp_pk + ") ";

    //Response.Write(SQL);
    //Response.End();
    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    int num_row;
    num_row = dt_total.Rows.Count;
    if (num_row == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }

    SQL = "select max(decode(code,'15',code_nm,'')) giamdoc " +
        "        ,max(decode(code,'04',code_nm,'')) canbothu " +
        "        ,max(decode(code,'16',code_nm,'')) canbosothe  " +
        "        ,max(decode(code,'17',code_nm,'')) giamdocbhxh " +
        "        ,max(decode(code,'11',code_nm,'')) tinh " +
        "        from vhr_hr_code  " +
        "        where id='HR0049' " +
        " and (nvl(to_char(TCO_COMPANY_PK),'" + p_company_pk + "') = '" + p_company_pk + "' or '" + p_company_pk + "' = 'ALL')  " +
        " group by id  ";

    DataTable dt_name = ESysLib.TableReadOpen(SQL);
    int irow_name;
    irow_name = dt_name.Rows.Count;
    
 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_A01_TS_A3_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_A01_TS_A3_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_A01_TS_A3_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>convert</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2012-07-12T02:18:17Z</o:LastPrinted>
  <o:Created>2012-04-05T02:48:16Z</o:Created>
  <o:LastSaved>2012-07-12T02:20:37Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.48in .17in .34in .26in;
	mso-header-margin:.37in;
	mso-footer-margin:.42in;}
.font6
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font11
	{color:blue;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font12
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font13
	{color:black;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font15
	{color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font18
	{color:black;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font19
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font20
	{color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font21
	{color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font25
	{color:windowtext;
	font-size:14.0pt;
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
.style58
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
	mso-style-name:Normal_Sheet1;}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
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
.xl66
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl67
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl68
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl70
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl73
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl76
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl77
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl78
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl79
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl80
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl81
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl82
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl83
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl84
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl85
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl87
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl88
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl89
	{mso-style-parent:style0;
	color:blue;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl90
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl91
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl92
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl94
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl95
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl96
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl97
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl99
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl100
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl101
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl102
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl103
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl104
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl105
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl106
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl107
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	border:.5pt solid windowtext;}
.xl108
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl109
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl110
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl111
	{mso-style-parent:style58;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl112
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl113
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl114
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl115
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl116
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl117
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl118
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl119
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl120
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl121
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl122
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl123
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl124
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl125
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl126
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl127
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
	border-left:none;}
.xl128
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl129
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
	border-left:none;}
.xl130
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl131
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl132
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl133
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl134
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl135
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl136
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl137
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl138
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl139
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border:.5pt solid windowtext;}
.xl140
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;
	white-space:normal;}
.xl141
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl142
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl143
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
	border-left:none;
	white-space:normal;}
.xl144
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
	border-left:none;
	white-space:normal;}
.xl145
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl146
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;}
.xl147
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl148
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>A01_TS</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>5</x:ActiveRow>
       <x:ActiveCol>18</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
      <% 
        int irow=0;
        for (int j = 0; j < num_row; j++)
        {
            if(rpt_type=="0")
            {
                irow+=38;
                %>            
                <x:RowBreak>
                    <x:Row><%=irow %></x:Row>
                </x:RowBreak>
                <%    
             }
             else if(rpt_type=="1")
             {
                irow+=46;
                %>
                <x:RowBreak>
                    <x:Row><%=irow %></x:Row>
                </x:RowBreak>
                <%
             }
             else
             {
                irow+=38;
                %>
                <x:RowBreak>
                    <x:Row><%=irow %></x:Row>
                </x:RowBreak>
                <%
                irow+=42;
                %>
                <x:RowBreak>
                    <x:Row><%=irow %></x:Row>
                </x:RowBreak>
                <%
             }  
                
        }  
      %>
      
     </x:RowBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11520</x:WindowHeight>
  <x:WindowWidth>15180</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>165</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl67>

<table x:str border=0 cellpadding=0 cellspacing=0 width=711 style='border-collapse:
 collapse;table-layout:fixed;width:535pt'>
 <col class=xl67 width=27 style='mso-width-source:userset;mso-width-alt:987;
 width:20pt'>
 <col class=xl67 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl67 width=34 style='mso-width-source:userset;mso-width-alt:1243;
 width:26pt'>
 <col class=xl67 width=37 style='mso-width-source:userset;mso-width-alt:1353;
 width:28pt'>
 <col class=xl67 width=64 span=2 style='width:48pt'>
 <col class=xl67 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl67 width=64 style='width:48pt'>
 <col class=xl67 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl67 width=28 style='mso-width-source:userset;mso-width-alt:1024;
 width:21pt'>
 <col class=xl67 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl67 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl67 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col class=xl67 width=23 style='mso-width-source:userset;mso-width-alt:841;
 width:17pt'>
 <col class=xl67 width=29 style='mso-width-source:userset;mso-width-alt:1060;
 width:22pt'>
 <col class=xl67 width=23 style='mso-width-source:userset;mso-width-alt:841;
 width:17pt'>
 <%  int _j=0;
    for (_j = 0; _j < num_row; _j++)
    { %>

<%if (rpt_type != "1") //in mat truoc va hai mat
  { %>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl72 colspan=6 width=264 style='height:15.75pt;
  mso-ignore:colspan;width:199pt'>B&#7842;<font class="font19">O HI&#7874;M XÃ
  H&#7896;I VI&#7878;T N</font><font class="font12">AM</font></td>
  <td colspan=6 class=xl110 width=339 style='width:255pt'>C&#7896;NG HOÀ XÃ
  H&#7896;I CH&#7910; NGH&#296;A VI&#7878;T NAM</td>
  <td class=xl67 width=33 style='width:25pt'></td>
  <td class=xl67 width=23 style='width:17pt'></td>
  <td class=xl67 width=29 style='width:22pt'></td>
  <td class=xl67 width=23 style='width:17pt'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 colspan=5 class=xl67 style='height:21.0pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl111 width=403 style='width:303pt'>&#272;&#7897;<font
  class="font18">c l&#7853;p - T&#7921; do - H&#7841;nh p</font><font
  class="font13">húc</font></td>
  <td colspan=4 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl67 style='height:15.75pt'></td>
  <td class=xl68></td>
  <td colspan=3 class=xl67 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl69 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl67 style='mso-ignore:colspan'></td>
  <td colspan=6 rowspan=2 class=xl116 width=241 style='width:182pt'>M&#7851;u
  s&#7889;: A01-TS<br>
    <font class="font15">(Ban hành kèm theo Q&#272; s&#7889;: 1111
  /Q&#272;-BHXH ngày 25./10./2011c&#7911;a BHXH Vi&#7879;tNam)</font></td>
  <td class=xl67></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl67 style='height:20.25pt'></td>
  <td colspan=2 rowspan=4 class=xl112 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>3x4</td>
  <td colspan=2 class=xl67 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl117 x:str="T&#7900; KHAI THAM GIA ">T&#7900; KHAI THAM
  GIA<span style='mso-spacerun:yes'> </span></td>
  <td class=xl67></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl67 style='height:15.0pt'></td>
  <td colspan=8 class=xl146 style='border-left:none'>B&#7842;O HI&#7874;M XÃ
  H&#7896;I, B&#7842;O HI&#7874;M Y T&#7870;</td>
  <td class=xl73></td>
  <td colspan=4 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 class=xl67 style='height:10.5pt'></td>
  <td colspan=13 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl67 style='height:24.0pt'></td>
  <td class=xl70></td>
  <td class=xl76 colspan=2 style='mso-ignore:colspan' x:str="Mã s&#7889;: ">Mã
  s&#7889;:<span style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl76 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 class=xl67 style='height:24.75pt'></td>
  <td class=xl70></td>
  <td class=xl67></td>
  <td class=xl70></td>
  <td colspan=6 class=xl109></td>
  <td class=xl70></td>
  <td colspan=5 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl75 colspan=7 style='height:15.75pt;mso-ignore:colspan'>I.
  THÔNG TIN C&#7910;A NG&#431;&#7900;I THAM GIA:</td>
  <td colspan=9 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td colspan=10 height=25 class=xl115 style='height:18.75pt'>[01]. H&#7885; và
  tên<font class="font6"> (vi&#7871;t ch&#7919; in hoa): </font><font
  class="font11"><span style='mso-spacerun:yes'> </span></font><font
  class="font21"><%=dt_total.Rows[_j]["c01"].ToString()%></font></td>
  <td class=xl78 colspan=3 style='mso-ignore:colspan'>[02]. Gi&#7899;i tính:
  Nam</td>
  <%if (dt_total.Rows[_j]["c02"].ToString() == "M")
    {   %>
  <td class=xl92>x</td>
  <td class=xl74>N&#7919;</td>
  <td class=xl92>&nbsp;</td>
  <%}else 
    {
  %>
  <td class=xl92>&nbsp;</td>
  <td class=xl74>N&#7919;</td>
  <td class=xl92>x</td>
  <%} %>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl78 colspan=14 style='height:18.75pt;mso-ignore:colspan'>[03].
  Ngày tháng n&#259;m sinh: <font class="font21"><%=dt_total.Rows[_j]["c03"].ToString()%></font><font
  class="font20">, [04]. Dân t&#7897;c: </font><font class="font21"><%=dt_total.Rows[_j]["c04"].ToString()%></font><font
  class="font20">, [05]. Qu&#7889;c t&#7883;ch: </font><font class="font21"><%=dt_total.Rows[_j]["c05"].ToString()%></font></td>
  <td colspan=2 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=26 style='height:19.5pt'>
  <td height=26 class=xl78 colspan=11 style='height:19.5pt;mso-ignore:colspan'>[06].
  H&#7897; kh&#7849;u th&#432;&#7901;ng trú ho&#7863;c t&#7841;m trú: <font
  class="font25"><%=dt_total.Rows[_j]["c06"].ToString()%></font></td>
  <td class=xl77></td>
  <td colspan=4 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=26 style='height:19.5pt'>
  <td height=26 class=xl78 colspan=9 style='height:19.5pt;mso-ignore:colspan'>[07].
  &#272;&#7883;a ch&#7881; liên h&#7879;: <font class="font25"><%=dt_total.Rows[_j]["c07"].ToString()%></font></td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td height=25 class=xl78 colspan=14 style='height:18.75pt;mso-ignore:colspan'>[08].
  S&#7889; &#273;i&#7879;n tho&#7841;i liên h&#7879; (n&#7871;u có): c&#7889;
  &#273;&#7883;nh: <%=dt_total.Rows[_j]["c08"].ToString()%>, di &#273;&#7897;ng: <%=dt_total.Rows[_j]["c09"].ToString()%></td>
  <td colspan=2 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td colspan=12 height=25 class=xl115 style='height:18.75pt'>[09]. CMT
  s&#7889;:<span style='mso-spacerun:yes'>  </span><%=dt_total.Rows[_j]["c10"].ToString()%>, ngày c&#7845;p:
  <%=dt_total.Rows[_j]["c11"].ToString()%>, n&#417;i c&#7845;p: <%=dt_total.Rows[_j]["c12"].ToString()%></td>
  <td colspan=4 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td colspan=11 height=25 class=xl118 style='height:18.75pt'>II. THAM GIA
  B&#7842;O HI&#7874;M XÃ H&#7896;I B&#7854;T BU&#7896;C, B&#7842;O HI&#7874;M
  Y T&#7870;:</td>
  <td class=xl77></td>
  <td colspan=4 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=26 style='height:19.5pt'>
  <td height=26 class=xl78 colspan=14 style='height:19.5pt;mso-ignore:colspan'>[10].
  Quy&#7871;t &#273;&#7883;nh tuy&#7875;n d&#7909;ng, h&#7907;p &#273;&#7891;ng
  lao &#273;&#7897;ng (ho&#7863;c H&#272;LV) s&#7889;:<span
  style='mso-spacerun:yes'>  </span><font class="font25"><%=dt_total.Rows[_j]["c13"].ToString()%> </font><font
  class="font20">ngày</font></td>
  <td colspan=2 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=26 style='height:19.5pt'>
  <td height=26 class=xl78 colspan=13 style='height:19.5pt;mso-ignore:colspan'><font
  class="font25"><%=dt_total.Rows[_j]["c14"].ToString()%></font><font class="font20"> có hi&#7879;u l&#7921;c
  t&#7915; ngày <%=dt_total.Rows[_j]["c14"].ToString()%> lo&#7841;i h&#7907;p &#273;&#7891;ng<span
  style='mso-spacerun:yes'>  </span>: </font><font class="font25"><%=dt_total.Rows[_j]["c15"].ToString()%></font></td>
  <td colspan=3 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=26 style='height:19.5pt'>
  <td height=26 class=xl78 colspan=15 style='height:19.5pt;mso-ignore:colspan'>[11].
  Tên c&#417; quan, &#273;&#417;n v&#7883;, &#273;&#7883;a ch&#7881;:<span
  style='mso-spacerun:yes'>  </span><font class="font25"><%=dt_total.Rows[_j]["c16"].ToString()%><span
  style='mso-spacerun:yes'>  </span></font></td>
  <td class=xl74></td>
 </tr>
 <tr class=xl74 height=26 style='height:19.5pt'>
  <td height=26 class=xl87 colspan=11 style='height:19.5pt;mso-ignore:colspan'><%=dt_total.Rows[_j]["c17"].ToString()%></td>
  <td class=xl77></td>
  <td colspan=4 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=26 style='height:19.5pt'>
  <td height=26 class=xl78 colspan=8 style='height:19.5pt;mso-ignore:colspan'>[12].
  N&#417;i làm vi&#7879;c: <font class="font25"><%=dt_total.Rows[_j]["c17"].ToString()%></font></td>
  <td colspan=4 class=xl77 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=26 style='height:19.5pt'>
  <td height=26 class=xl78 colspan=11 style='height:19.5pt;mso-ignore:colspan'>[13].
  Ch&#7913;c v&#7909;, ch&#7913;c danh ngh&#7873;, công vi&#7879;c:<span
  style='mso-spacerun:yes'>  </span><font class="font25"><%=dt_total.Rows[_j]["c19"].ToString()%>  <%=dt_total.Rows[_j]["c25"].ToString()%></font></td>
  <td class=xl77></td>
  <td colspan=4 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=26 style='height:19.5pt'>
  <td height=26 class=xl74 colspan=7 style='height:19.5pt;mso-ignore:colspan'>[14].
  L&#432;&#417;ng chính:<span style='mso-spacerun:yes'>  </span><font
  class="font25"><%=dt_total.Rows[_j]["c22"].ToString()%> VN&#272;,</font></td>
  <td colspan=9 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td height=25 class=xl74 colspan=15 style='height:18.75pt;mso-ignore:colspan'>[15].
  Ph&#7909; c&#7845;p: [15.1]. PCCV ___, [15.2]. TNN ___, [15.3]. TNVK ___,
  [15.4]. Khác ___</td>
  <td class=xl74></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td colspan=12 height=25 class=xl78 style='height:18.75pt'>[16]. Mã s&#7889;
  s&#7893; b&#7843;o hi&#7875;m xã h&#7897;i &#273;ã &#273;&#432;&#7907;c
  c&#7845;p (<font class="font6">n&#7871;u có</font><font class="font20">):
  <%=dt_total.Rows[_j]["c00"].ToString()%></font></td>
  <td colspan=4 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td height=25 class=xl74 colspan=15 style='height:18.75pt;mso-ignore:colspan'>[17].
  Mã s&#7889; th&#7867; b&#7843;o hi&#7875;m y t&#7871; &#273;ã
  &#273;&#432;&#7907;c c&#7845;p (<font class="font6">n&#7871;u có</font><font
  class="font20">):<span style='mso-spacerun:yes'> 
  </span><%=dt_total.Rows[_j]["c26"].ToString()%></font></td>
  <td class=xl74></td>
 </tr>
 <tr class=xl74 height=51 style='mso-height-source:userset;height:38.25pt'>
  <td colspan=16 height=51 class=xl124 width=711 style='height:38.25pt;
  width:535pt'>[18]. N&#417;i &#273;&#259;ng ký khám ch&#7919;a b&#7879;nh ban
  &#273;&#7847;u (<font class="font6">theo h&#432;&#7899;ng d&#7851;n c&#7911;a
  c&#417; quan BHXH</font><font class="font20">): <%=dt_total.Rows[_j]["c24"].ToString()%></font></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td height=25 class=xl74 colspan=15 style='height:18.75pt;mso-ignore:colspan'>[19].
  Quy&#7873;n l&#7907;i h&#432;&#7903;ng b&#7843;o hi&#7875;m y t&#7871; (<font
  class="font6">n&#7871;u có</font><font class="font20">):<span
  style='mso-spacerun:yes'>  </span>_______________________________</font></td>
  <td class=xl74></td>
 </tr>
 <tr class=xl74 height=41 style='mso-height-source:userset;height:30.75pt'>
  <td height=41 colspan=7 class=xl74 style='height:30.75pt;mso-ignore:colspan'></td>
  <td class=xl79 colspan=7 style='mso-ignore:colspan'>Xác nh&#7853;n c&#7911;a
  ng&#432;&#7901;i s&#7917; d&#7909;ng lao &#273;&#7897;ng</td>
  <td colspan=2 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=81 style='mso-height-source:userset;height:60.75pt'>
  <td colspan=7 height=81 class=xl119 width=336 style='height:60.75pt;
  width:253pt'>Tôi xin cam &#273;oan nh&#7919;ng n&#7897;i dung kê khai trên là
  &#273;úng s&#7921; th&#7853;t và xin ch&#7883;u hoàn toàn trách nhi&#7879;m
  tr&#432;&#7899;c pháp lu&#7853;t.</td>
  <td colspan=8 class=xl119 width=352 style='width:265pt'>Sau khi ki&#7875;m
  tra, &#273;&#7889;i chi&#7871;u xác nh&#7853;n các n&#7897;i dung kê khai
  trên là &#273;úng và xin ch&#7883;u hoàn toàn trách nhi&#7879;m
  tr&#432;&#7899;c pháp lu&#7853;t.</td>
  <td class=xl93></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td colspan=7 height=25 class=xl80 style='height:18.75pt'><%=dt_name.Rows[0]["tinh"].ToString() %>,
  ngày <%=DateTime.Now.Day%> tháng <%=DateTime.Now.Month%> n&#259;m <%=DateTime.Now.Year%></td>
  <td class=xl88 colspan=6 style='mso-ignore:colspan'><%=dt_name.Rows[0]["tinh"].ToString() %>, ngày <%=DateTime.Now.Day%>
  tháng <%=DateTime.Now.Month%> n&#259;m <%=DateTime.Now.Year%></td>
  <td colspan=3 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td height=25 class=xl74 style='height:18.75pt'></td>
  <td colspan=3 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl82>Ng&#432;&#7901;i khai</td>
  <td colspan=2 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl74></td>
  <td class=xl79></td>
  <td class=xl74></td>
  <td class=xl82>Th&#7911; tr&#432;&#7903;ng &#273;&#417;n v&#7883;</td>
  <td class=xl79></td>
  <td colspan=4 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td height=25 class=xl74 style='height:18.75pt'></td>
  <td colspan=3 class=xl88 style='mso-ignore:colspan'></td>
  <td class=xl80>(Ký, ghi rõ h&#7885; tên)</td>
  <td colspan=2 class=xl88 style='mso-ignore:colspan'></td>
  <td class=xl74></td>
  <td class=xl88></td>
  <td class=xl74></td>
  <td class=xl80>(Ký, ghi rõ h&#7885; tên và &#273;óng d&#7845;u)</td>
  <td class=xl88></td>
  <td colspan=4 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td height=25 colspan=16 class=xl74 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td height=25 colspan=16 class=xl74 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td height=25 colspan=16 class=xl74 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td height=25 colspan=16 class=xl74 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td height=25 class=xl74 style='height:18.75pt'></td>
  <td colspan=3 class=xl89 style='mso-ignore:colspan'></td>
  <td class=xl82><%=dt_total.Rows[_j]["c01"].ToString()%></td>
  <td colspan=2 class=xl89 style='mso-ignore:colspan'></td>
  <td class=xl74></td>
  <td class=xl89></td>
  <td class=xl74></td>
  <td class=xl82><%=dt_name.Rows[0]["giamdoc"].ToString() %></td>
  <td class=xl89></td>
  <td colspan=4 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <% } //hết trang 1 %>
 
 <%  if (rpt_type != "0") //in mat  sau hoac hai mat
     {
 %>
 <tr class=xl74 height=25 style='page-break-before:always;height:18.75pt'>
  <td height=25 class=xl79 colspan=7 style='height:18.75pt;mso-ignore:colspan'
  x:str="Duy&#7879;t c&#7911;a c&#417; quan b&#7843;o hi&#7875;m xã h&#7897;i:      ">Duy&#7879;t
  c&#7911;a c&#417; quan b&#7843;o hi&#7875;m xã h&#7897;i:<span
  style='mso-spacerun:yes'>      </span></td>
  <td colspan=9 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td height=25 colspan=8 class=xl74 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl88 colspan=8 style='mso-ignore:colspan'>........., ngày......
  tháng...... n&#259;m .........</td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td height=25 class=xl74 style='height:18.75pt'></td>
  <td colspan=2 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl82>Cán b&#7897; thu</td>
  <td class=xl79></td>
  <td class=xl74></td>
  <td class=xl82>Cán b&#7897; s&#7893;, th&#7867;</td>
  <td class=xl82></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl74></td>
  <td class=xl82>Giám &#273;&#7889;c BHXH</td>
  <td colspan=4 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td height=25 class=xl74 style='height:18.75pt'></td>
  <td colspan=2 class=xl88 style='mso-ignore:colspan'></td>
  <td class=xl80>(Ký, ghi rõ h&#7885; tên)</td>
  <td class=xl88></td>
  <td class=xl74></td>
  <td class=xl80>(Ký, ghi rõ h&#7885; tên)</td>
  <td class=xl80></td>
  <td class=xl81></td>
  <td class=xl80></td>
  <td class=xl74></td>
  <td class=xl80>(Ký, ghi rõ h&#7885; tên và &#273;óng d&#7845;u)</td>
  <td colspan=4 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td height=25 colspan=16 class=xl74 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td height=25 colspan=16 class=xl74 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td height=25 colspan=16 class=xl74 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td height=25 colspan=16 class=xl74 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td height=25 class=xl74 style='height:18.75pt'></td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
  <td class=xl82>Ph&#7841;m Thanh Tâm</td>
  <td class=xl77></td>
  <td colspan=3 class=xl83></td>
  <td colspan=4 class=xl83></td>
  <td colspan=4 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td height=25 class=xl74 style='height:18.75pt'></td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
  <td class=xl82></td>
  <td class=xl77></td>
  <td colspan=7 class=xl83 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td colspan=15 height=25 class=xl82 style='height:18.75pt'
  x:str="PH&#7908; L&#7908;C: TH&#7900;I GIAN LÀM VI&#7878;C CÓ &#272;ÓNG BHXH ">PH&#7908;
  L&#7908;C: TH&#7900;I GIAN LÀM VI&#7878;C CÓ &#272;ÓNG BHXH<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl74></td>
 </tr>
 <tr class=xl74 height=25 style='height:18.75pt'>
  <td colspan=15 height=25 class=xl82 style='height:18.75pt'>CH&#431;A
  H&#431;&#7902;NG M&#7896;T L&#7846;N</td>
  <td class=xl74></td>
 </tr>
 <tr class=xl74 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=16 class=xl74 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=33 style='mso-height-source:userset;height:24.75pt'>
  <td colspan=2 rowspan=2 height=83 class=xl131 width=65 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:62.25pt;width:49pt'>T&#7915;
  tháng n&#259;m</td>
  <td colspan=2 rowspan=2 class=xl131 width=71 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:54pt'>&#272;&#7871;n tháng n&#259;m</td>
  <td colspan=5 rowspan=2 class=xl131 width=311 style='border-bottom:.5pt solid black;
  width:233pt'>Di&#7877;n gi&#7843;i</td>
  <td colspan=2 rowspan=2 class=xl126 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>C&#259;n c&#7913; &#273;óng</td>
  <td colspan=4 class=xl125 style='border-left:none'>T&#7881; l&#7879;
  &#273;óng(%)</td>
  <td class=xl104></td>
 </tr>
 <tr class=xl74 height=50 style='mso-height-source:userset;height:37.5pt'>
  <td height=50 class=xl97 style='height:37.5pt;border-top:none;border-left:
  none'>BHXH</td>
  <td colspan=3 class=xl97 style='border-left:none'>BHTN</td>
  <td class=xl105></td>
 </tr>
 <tr class=xl74 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=2 height=31 class=xl135 style='border-right:.5pt solid black;
  height:23.25pt' x:num>1</td>
  <td colspan=2 class=xl135 style='border-right:.5pt solid black;border-left:
  none' x:num>2</td>
  <td colspan=5 class=xl135 style='border-left:none' x:num>3</td>
  <td colspan=2 class=xl130 x:num>4</td>
  <td class=xl106 style='border-top:none' x:num>5</td>
  <td colspan=3 class=xl138 style='border-left:none' x:num>6</td>
  <td class=xl74></td>
 </tr>
 <tr class=xl91 height=106 style='mso-height-source:userset;height:79.5pt'>
  <td colspan=2 height=106 class=xl120 width=65 style='border-right:.5pt solid black;
  height:79.5pt;width:49pt'><%=dt_total.Rows[_j]["c20"].ToString()%></td>
  <td colspan=2 class=xl122 width=71 style='border-right:.5pt solid black;
  border-left:none;width:54pt'><%=dt_total.Rows[_j]["c21"].ToString()%></td>
  <td colspan=5 class=xl122 width=311 style='border-right:.5pt solid black;
  border-left:none;width:233pt'
  x:str><%=dt_total.Rows[_j]["c19"].ToString()%> <%=dt_total.Rows[_j]["c25"].ToString()%> 
  – Th&#7847;u XD gói th&#7847;u A3 &#273;&#432;&#7901;ng
  cao t&#7889;c N&#7897;i Bài ~ Lào Cai, Gia C&#7849;m – Vi&#7879;t Trì – Phú
  Th&#7885;
  <br>
    <br>
    - T&#7891;ng ti&#7873;n l&#432;&#417;ng &#273;óng<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl136 width=90 style='border-left:none;width:68pt'
  x:num><%=dt_total.Rows[_j]["c22"].ToString()%></td>
  <td class=xl107 align=right style='border-top:none' x:num>24%</td>
  <td colspan=3 class=xl139 style='border-left:none' x:num>2%</td>
  <td class=xl91></td>
 </tr>
 <% 
     if (_j < num_row - 1)
     {
         if (dt_total.Rows[_j]["c27"].ToString() == dt_total.Rows[_j + 1]["c27"].ToString() && _j < num_row)
         {
             _j++;
     %>
 <tr class=xl91 height=106 style='mso-height-source:userset;height:79.5pt'>
  <td colspan=2 height=106 class=xl120 width=65 style='border-right:.5pt solid black;
  height:79.5pt;width:49pt'><%=dt_total.Rows[_j]["c20"].ToString()%></td>
  <td colspan=2 class=xl122 width=71 style='border-right:.5pt solid black;
  border-left:none;width:54pt'><%=dt_total.Rows[_j]["c21"].ToString()%></td>
  <td colspan=5 class=xl122 width=311 style='border-right:.5pt solid black;
  border-left:none;width:233pt'
  x:str><%=dt_total.Rows[_j]["c19"].ToString()%> <%=dt_total.Rows[_j]["c25"].ToString()%> <%=dt_total.Rows[_j]["c17"].ToString()%><br>
    <br>
    - T&#7891;ng ti&#7873;n l&#432;&#417;ng &#273;óng<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl136 width=90 style='border-left:none;width:68pt'
  x:num><%=dt_total.Rows[_j]["c22"].ToString()%></td>
  <td class=xl107 align=right style='border-top:none' x:num>24%</td>
  <td colspan=3 class=xl139 style='border-left:none' x:num>2%</td>
  <td class=xl91></td>
 </tr>
 <%    
     }
         else
         { %>
 <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl120 width=65 style='border-right:.5pt solid black;
  height:15.95pt;width:49pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=71 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl98 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl99 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl99 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl99 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl100 width=47 style='width:35pt'>&nbsp;</td>
  <td class=xl95 width=28 style='border-top:none;border-left:none;width:21pt'>&nbsp;</td>
  <td class=xl94 width=62 style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl101 style='border-top:none'>&nbsp;</td>
  <td class=xl101>&nbsp;</td>
  <td class=xl102>&nbsp;</td>
  <td class=xl103>&nbsp;</td>
  <td class=xl91></td>
 </tr>
  <%}
     }%>
 <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl120 width=65 style='border-right:.5pt solid black;
  height:15.95pt;width:49pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=71 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl95 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl96 width=47 style='width:35pt'>&nbsp;</td>
  <td class=xl95 width=28 style='border-top:none;border-left:none;width:21pt'>&nbsp;</td>
  <td class=xl94 width=62 style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
  <td class=xl91></td>
 </tr>
 <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl120 width=65 style='border-right:.5pt solid black;
  height:15.95pt;width:49pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=71 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl98 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl99 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl99 width=72 style='border-top:none;width:54pt'>&nbsp;</td>
  <td class=xl99 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl100 width=47 style='border-top:none;width:35pt'>&nbsp;</td>
  <td class=xl95 width=28 style='border-top:none;border-left:none;width:21pt'>&nbsp;</td>
  <td class=xl94 width=62 style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
  <td class=xl91></td>
 </tr>
 <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl120 width=65 style='border-right:.5pt solid black;
  height:15.95pt;width:49pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=71 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl95 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl96 width=47 style='width:35pt'>&nbsp;</td>
  <td class=xl95 width=28 style='border-top:none;border-left:none;width:21pt'>&nbsp;</td>
  <td class=xl94 width=62 style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
  <td class=xl91></td>
 </tr>
 <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl120 width=65 style='border-right:.5pt solid black;
  height:15.95pt;width:49pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=71 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl98 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl99 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl99 width=72 style='border-top:none;width:54pt'>&nbsp;</td>
  <td class=xl99 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl100 width=47 style='border-top:none;width:35pt'>&nbsp;</td>
  <td class=xl95 width=28 style='border-top:none;border-left:none;width:21pt'>&nbsp;</td>
  <td class=xl94 width=62 style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
  <td class=xl91></td>
 </tr>
 <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl120 width=65 style='border-right:.5pt solid black;
  height:15.95pt;width:49pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=71 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl95 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl96 width=47 style='width:35pt'>&nbsp;</td>
  <td class=xl95 width=28 style='border-top:none;border-left:none;width:21pt'>&nbsp;</td>
  <td class=xl94 width=62 style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
  <td class=xl91></td>
 </tr>
 <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl120 width=65 style='border-right:.5pt solid black;
  height:15.95pt;width:49pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=71 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl98 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl99 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl99 width=72 style='border-top:none;width:54pt'>&nbsp;</td>
  <td class=xl99 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl100 width=47 style='border-top:none;width:35pt'>&nbsp;</td>
  <td class=xl95 width=28 style='border-top:none;border-left:none;width:21pt'>&nbsp;</td>
  <td class=xl94 width=62 style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
  <td class=xl91></td>
 </tr>
 <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl120 width=65 style='border-right:.5pt solid black;
  height:15.95pt;width:49pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=71 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl95 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl96 width=47 style='width:35pt'>&nbsp;</td>
  <td class=xl95 width=28 style='border-top:none;border-left:none;width:21pt'>&nbsp;</td>
  <td class=xl94 width=62 style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
  <td class=xl91></td>
 </tr>
 <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl120 width=65 style='border-right:.5pt solid black;
  height:15.95pt;width:49pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=71 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl98 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl99 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl99 width=72 style='border-top:none;width:54pt'>&nbsp;</td>
  <td class=xl99 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl100 width=47 style='border-top:none;width:35pt'>&nbsp;</td>
  <td class=xl95 width=28 style='border-top:none;border-left:none;width:21pt'>&nbsp;</td>
  <td class=xl94 width=62 style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
  <td class=xl91></td>
 </tr>
 <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl120 width=65 style='border-right:.5pt solid black;
  height:15.95pt;width:49pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=71 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl95 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl96 width=47 style='width:35pt'>&nbsp;</td>
  <td class=xl95 width=28 style='border-top:none;border-left:none;width:21pt'>&nbsp;</td>
  <td class=xl94 width=62 style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
  <td class=xl91></td>
 </tr>
 <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl120 width=65 style='border-right:.5pt solid black;
  height:15.95pt;width:49pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=71 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl98 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl99 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl99 width=72 style='border-top:none;width:54pt'>&nbsp;</td>
  <td class=xl99 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl100 width=47 style='border-top:none;width:35pt'>&nbsp;</td>
  <td class=xl95 width=28 style='border-top:none;border-left:none;width:21pt'>&nbsp;</td>
  <td class=xl94 width=62 style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
  <td class=xl91></td>
 </tr>
 <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl120 width=65 style='border-right:.5pt solid black;
  height:15.95pt;width:49pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=71 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl95 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl96 width=47 style='width:35pt'>&nbsp;</td>
  <td class=xl95 width=28 style='border-top:none;border-left:none;width:21pt'>&nbsp;</td>
  <td class=xl94 width=62 style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
  <td class=xl91></td>
 </tr>
 <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl120 width=65 style='border-right:.5pt solid black;
  height:15.95pt;width:49pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=71 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl98 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl99 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl99 width=72 style='border-top:none;width:54pt'>&nbsp;</td>
  <td class=xl99 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl100 width=47 style='border-top:none;width:35pt'>&nbsp;</td>
  <td class=xl95 width=28 style='border-top:none;border-left:none;width:21pt'>&nbsp;</td>
  <td class=xl94 width=62 style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
  <td class=xl91></td>
 </tr>
 <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl120 width=65 style='border-right:.5pt solid black;
  height:15.95pt;width:49pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=71 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl95 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl96 width=47 style='width:35pt'>&nbsp;</td>
  <td class=xl95 width=28 style='border-top:none;border-left:none;width:21pt'>&nbsp;</td>
  <td class=xl94 width=62 style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
  <td class=xl91></td>
 </tr>
 <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl120 width=65 style='border-right:.5pt solid black;
  height:15.95pt;width:49pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=71 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl98 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl99 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl99 width=72 style='border-top:none;width:54pt'>&nbsp;</td>
  <td class=xl99 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl100 width=47 style='border-top:none;width:35pt'>&nbsp;</td>
  <td class=xl95 width=28 style='border-top:none;border-left:none;width:21pt'>&nbsp;</td>
  <td class=xl94 width=62 style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
  <td class=xl91></td>
 </tr>
 <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl120 width=65 style='border-right:.5pt solid black;
  height:15.95pt;width:49pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=71 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl95 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl96 width=47 style='width:35pt'>&nbsp;</td>
  <td class=xl95 width=28 style='border-top:none;border-left:none;width:21pt'>&nbsp;</td>
  <td class=xl94 width=62 style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
  <td class=xl91></td>
 </tr>
 <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl120 width=65 style='border-right:.5pt solid black;
  height:15.95pt;width:49pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=71 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl98 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl99 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl99 width=72 style='border-top:none;width:54pt'>&nbsp;</td>
  <td class=xl99 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl100 width=47 style='border-top:none;width:35pt'>&nbsp;</td>
  <td class=xl95 width=28 style='border-top:none;border-left:none;width:21pt'>&nbsp;</td>
  <td class=xl94 width=62 style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
  <td class=xl91></td>
 </tr>
 <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl120 width=65 style='border-right:.5pt solid black;
  height:15.95pt;width:49pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=71 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl95 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl96 width=47 style='width:35pt'>&nbsp;</td>
  <td class=xl95 width=28 style='border-top:none;border-left:none;width:21pt'>&nbsp;</td>
  <td class=xl94 width=62 style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
  <td class=xl91></td>
 </tr>

  <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl120 width=65 style='border-right:.5pt solid black;
  height:15.95pt;width:49pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=71 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl95 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl96 width=47 style='width:35pt'>&nbsp;</td>
  <td class=xl95 width=28 style='border-top:none;border-left:none;width:21pt'>&nbsp;</td>
  <td class=xl94 width=62 style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
  <td class=xl91></td>
 </tr>
  <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl120 width=65 style='border-right:.5pt solid black;
  height:15.95pt;width:49pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=71 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl95 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl96 width=47 style='width:35pt'>&nbsp;</td>
  <td class=xl95 width=28 style='border-top:none;border-left:none;width:21pt'>&nbsp;</td>
  <td class=xl94 width=62 style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
  <td class=xl91></td>
 </tr>
  <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl120 width=65 style='border-right:.5pt solid black;
  height:15.95pt;width:49pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=71 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl95 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl96 width=47 style='width:35pt'>&nbsp;</td>
  <td class=xl95 width=28 style='border-top:none;border-left:none;width:21pt'>&nbsp;</td>
  <td class=xl94 width=62 style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
  <td class=xl91></td>
 </tr>
  <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl120 width=65 style='border-right:.5pt solid black;
  height:15.95pt;width:49pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=71 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl95 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl96 width=47 style='width:35pt'>&nbsp;</td>
  <td class=xl95 width=28 style='border-top:none;border-left:none;width:21pt'>&nbsp;</td>
  <td class=xl94 width=62 style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
  <td class=xl91></td>
 </tr>
  <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl120 width=65 style='border-right:.5pt solid black;
  height:15.95pt;width:49pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=71 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl95 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl96 width=47 style='width:35pt'>&nbsp;</td>
  <td class=xl95 width=28 style='border-top:none;border-left:none;width:21pt'>&nbsp;</td>
  <td class=xl94 width=62 style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
  <td class=xl91></td>
 </tr>
  <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl120 width=65 style='border-right:.5pt solid black;
  height:15.95pt;width:49pt'>&nbsp;</td>
  <td colspan=2 class=xl122 width=71 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl95 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl94 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl94 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl96 width=47 style='width:35pt'>&nbsp;</td>
  <td class=xl95 width=28 style='border-top:none;border-left:none;width:21pt'>&nbsp;</td>
  <td class=xl94 width=62 style='border-top:none;width:47pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
  <td class=xl91></td>
 </tr>
  <tr class=xl91 height=21 style='mso-height-source:userset;height:15.95pt'>
  
  <td colspan=16 class=xl91></td>
 </tr>



  <%}//in mat sau hoac 2 mat %>
<%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=27 style='width:20pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=34 style='width:26pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=23 style='width:17pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
