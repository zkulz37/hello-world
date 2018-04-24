<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string l_company = ""+Request["Company"];
	string l_date_from = ""+Request["DateFrom"];
	string l_date_to = ""+Request["DateTo"];
	string l_voucher = ""+Request["Voucher"];
	string l_Seq = ""+Request["Seq"];
	string l_Status = ""+Request["Status"];
	string l_bookCcy = ""+Request["BookCcy"];
	string l_lang	= ""+Request["Lang"];
	string l_date_fr2 = "";
	string l_date_to2 = "";
	string l_bookformat = "";
	string l_report_dd = "";
	string l_report_mm = "";
	string l_report_yy = "";
	string l_row_height = "";
	string l_str_today = "";
	string l_total_dr = "0";
	string l_total_cr = "0";

    string l_cmp_name = "";
    string l_cmp_add = "";
    string l_cmp_taxcode = "";
    string l_status_dsp = "";
    string SQLS = "";
	string SQL = " SELECT PARTNER_NAME,ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + l_company + "' ";
	
	DataTable dt = ESysLib.TableReadOpen(SQL);
	if (dt.Rows.Count >0)
	{
		l_cmp_name = dt.Rows[0][0].ToString();
		l_cmp_add = dt.Rows[0][1].ToString();
		l_cmp_taxcode = dt.Rows[0][3].ToString();
	}
	String p_xls_ccy_format ="";
    String p_xls_ccy_format_usd = "";
    if (l_bookCcy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }

SQL = " SELECT TO_CHAR(TO_DATE('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') DT_FR,  TO_CHAR(TO_DATE('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') DT_TO, ";
SQL = SQL + "ac_sf_get_format('ACBG0040'), TO_CHAR(LAST_DAY(TO_DATE('" + l_date_to + "','YYYYMMDD')),'DD')  RP_DD,";
SQL = SQL + " TO_CHAR(LAST_DAY(TO_DATE('" + l_date_to + "','YYYYMMDD')),'MM')  RP_MM, ";
SQL = SQL + " TO_CHAR(LAST_DAY(TO_DATE('" + l_date_to + "','YYYYMMDD')),'YYYY')  RP_YY, ";
SQL = SQL + " AC_SF_GET_FORMAT ('ACRP0010'), INITCAP(TRIM(TO_CHAR(SYSDATE,'MONTH')))||' '||TO_CHAR(SYSDATE,'DD') ||', '||  TO_CHAR(SYSDATE,'YYYY') ";
SQL = SQL + " FROM DUAL ";


	
	dt = ESysLib.TableReadOpen(SQL);

	if (dt.Rows.Count >0)
	{
		l_date_fr2 = dt.Rows[0][0].ToString();
		l_date_to2 = dt.Rows[0][1].ToString();
		l_bookformat = dt.Rows[0][2].ToString();
		l_report_dd = dt.Rows[0][3].ToString();
		l_report_mm = dt.Rows[0][4].ToString();
		l_report_yy = dt.Rows[0][5].ToString();
		l_row_height = dt.Rows[0][6].ToString();
		l_str_today = dt.Rows[0][7].ToString();
	}
	switch (l_Status)
	{
		case "1" : 
			l_status_dsp ="Saved";
			break;
		case "2" :
			l_status_dsp ="Confirmed";
			break;
		case "4" :
			l_status_dsp ="NAPP";
			break;
		case "0" :
			l_status_dsp ="Approved";
			break;
	}	
	
	if (l_row_height == "")
	{
		l_row_height= "15";
	}
	
SQL = "  SELECT    TO_CHAR(SUM(decode(D.DRCR_TYPE,'D',D.TR_BOOKAMT,0)),ac_sf_get_format ('ACBG0040')) AMT_D,  ";
SQL = SQL + "               TO_CHAR(SUM(decode(D.DRCR_TYPE,'C',D.TR_BOOKAMT,0)),ac_sf_get_format ('ACBG0040')) AMT_C ";
SQL = SQL + "             FROM tac_hgtrh h, tac_hgtrd d ";
SQL = SQL + "             WHERE h.pk = d.tac_hgtrh_pk ";
SQL = SQL + "                AND h.tco_company_pk = " + l_company;
SQL = SQL + "                AND h.del_if = 0 ";
SQL = SQL + "                AND d.del_if = 0 ";
SQL = SQL + "                AND TO_CHAR (h.tr_date, 'YYYYMMDD') BETWEEN TO_CHAR ('"+ l_date_from +"') AND TO_CHAR ('"+ l_date_to +"') ";
SQL = SQL + "				 AND ( H.TR_STATUS IN (DECODE ('"+ l_Status +"' , 2, 2, '"+ l_Status +"'),DECODE ('"+ l_Status +"', 2, 0, '"+ l_Status +"'), DECODE ('"+ l_Status +"', 2, 4, '"+ l_Status +"')) OR '" +l_Status + "' is null)";
SQL = SQL + "    AND ((TRIM('" + l_voucher +"') IS NULL) OR (UPPER (H.voucherno) LIKE'%' || UPPER (TRIM('" + l_voucher +"'))|| '%'))  ";
SQL = SQL + "    AND ((TRIM('" + l_Seq +"')  IS NULL) OR (H.pk = TRIM('" + l_Seq +"') ))  ";



	dt = ESysLib.TableReadOpen(SQL);
	if (dt.Rows.Count >0)
	{
		l_total_dr = dt.Rows[0][0].ToString();
		l_total_cr = dt.Rows[0][1].ToString();	
	}
    SQL
        = " SELECT  a.pk,   " +
            "        TO_CHAR (a.tr_date, AC_SF_GET_FORMAT ('ACAB0300')) TRDATE, a.voucherno, d.ac_cd,  " +
            "        DECODE (' + l_lang +', 'ENG', d.ac_nm, 'VIE', d.ac_lnm, d.ac_knm) ac_nm,  " +
            "        DECODE (b.drcr_type,'D', TO_CHAR (b.tr_amt, DECODE (b.ccy,'VND', '9,999,999,999,999', '999,999,999,990.99')), '') tr_amtD,  " +
            "        DECODE (b.drcr_type,'C', TO_CHAR (b.tr_amt,DECODE (b.ccy,'VND', '9,999,999,999,999','999,999,999,990.99')),'') tr_amtC,  " +
            "        DECODE (b.drcr_type,'D', TO_CHAR (b.tr_bookamt, AC_SF_GET_FORMAT ('ACBG0040')),'') tr_bookD,  " +
            "        DECODE (b.drcr_type,'C', TO_CHAR (b.tr_bookamt, AC_SF_GET_FORMAT ('ACBG0040')),'') tr_bookC,  " +
            "        b.remark, b.remark2,  " +
            "        AC_SF_A_GET_AGTRITEM(b.pk), TO_CHAR (a.tr_date, 'YYYYMMDD') TRDATE1,  " +
            "        AC_SF_A_GET_AGTRITEM(b.pk), a.tr_enclose ENCLOSE  " +
            "     FROM tac_hgtrh a, tac_hgtrd b, tac_abacctcode c, tac_localcode d " +
            "         WHERE a.pk = b.tac_hgtrh_pk  " +
            "           AND b.tac_abacctcode_pk = c.pk  " +
            "           and c.TAC_LOCALCODE_PK = d.pk " +
            "           AND a.tco_company_pk =  "+ l_company +   "" +
            "    AND TO_CHAR(A.TR_DATE,'YYYYMMDD') BETWEEN '"+ l_date_from +"' AND '"+ l_date_to +"'    " +
            "    AND ( A.TR_STATUS IN (DECODE ('"+ l_Status +"' , 2, 2, '"+ l_Status +"'),DECODE ('"+ l_Status + "', 2, 0, '"+ l_Status +"'), DECODE ('"+ l_Status +"', 2, 4, '"+ l_Status +"'))  " +
            "         OR '" + l_Status + "' is null)  " +
            "    AND ((TRIM('" + l_voucher +"') IS NULL) OR (UPPER (a.voucherno) LIKE'%' || UPPER (TRIM('" + l_voucher +"'))|| '%'))   " +
            "    AND ((TRIM('" + l_Seq +"')  IS NULL) OR (a.pk = TRIM('" + l_Seq +"') ))   " +
            "           AND a.del_if = 0  " +
            "           AND b.del_if = 0  " +
            "           AND c.del_if = 0  " +
            "           and d.del_if = 0 " +
            "      ORDER BY trdate1, pk  ";

	
	
	DataTable dt_detail = ESysLib.TableReadOpen(SQL);



    SQL = " 		SELECT  AC_CD, AC_NM, ";
    SQL = SQL + "                  TRIM(TO_CHAR(DECODE('VND','VND',OP*1,OP/1),DECODE('VND','VND',ac_sf_get_format('ACBG0040'),'9,999,999,999,990.99'))) CR_OP,";
    SQL = SQL + "                  TRIM(TO_CHAR(DECODE('VND','VND',DR_PS*1,DR_PS/1),DECODE('VND','VND',ac_sf_get_format('ACBG0040'),'9,999,999,999,990.99'))) DR_PS,";
    SQL = SQL + "                  TRIM(TO_CHAR(DECODE('VND','VND',CR_PS*1,CR_PS/1),DECODE('VND','VND',ac_sf_get_format('ACBG0040'),'9,999,999,999,990.99'))) CR_PS,";
    SQL = SQL + "                  TRIM(TO_CHAR(DECODE('VND','VND',BL*1,BL/1),DECODE('VND','VND',ac_sf_get_format('ACBG0040'),'9,999,999,999,990.99'))) DR_BL,";
    SQL = SQL + "                  BOLD_YN, COLOR";
    SQL = SQL + "             FROM (SELECT E.AC_CD AC_CD , AC_NM AC_NM, ";
    SQL = SQL + "                          (DC*(NVL(LAST_AMT, 0) + NVL(YMAMT, 0))) OP,";
    SQL = SQL + "                          NVL(DR_PS, 0) DR_PS,";
    SQL = SQL + "                          NVL(CR_PS, 0) CR_PS,";
    SQL = SQL + "                          DC*(NVL(LAST_AMT,0)+NVL(YMAMT,0))+DC*(NVL(DR_PS,0)-NVL(CR_PS,0)) BL,";
    SQL = SQL + "                          E.BOLD_YN BOLD_YN, COLOR, E.PK PK";
    SQL = SQL + "                     FROM (SELECT MAX(TAC_ABACCTCODE_PK) TAC_ABACCTCODE_PK,";
    SQL = SQL + "                                  NVL(SUM(THIS_DRBAL),0) - NVL(SUM(THIS_CRBAL),0) LAST_AMT";
    SQL = SQL + "                             FROM TAC_HGMMBAL";
    SQL = SQL + "                            WHERE STD_YM=SUBSTR(Sf_Get_Lastclosemm(TO_CHAR('" + l_date_from + "')," + l_company + "),1,6)";
    SQL = SQL + "                              AND TCO_COMPANY_PK = " + l_company + "";
    SQL = SQL + "                              AND DEL_IF = 0";
    SQL = SQL + "                              AND ( TR_STATUS = '" + l_Status + "' OR '" + l_Status + "' is null) " ;
    SQL = SQL + "                            GROUP BY TAC_ABACCTCODE_PK) A,";
    SQL = SQL + "                          (SELECT MAX(TAC_ABACCTCODE_PK) TAC_ABACCTCODE_PK, ";
    SQL = SQL + "                                   NVL(SUM(YMD_DRBOOKS),0) - NVL(SUM(YMD_CRBOOKS),0) YMAMT";
    SQL = SQL + "                             FROM TAC_HGDDBAL";
    SQL = SQL + "                            WHERE STD_YMD BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE(Sf_Get_Lastclosemm(TO_CHAR('" + l_date_from + "')," + l_company + "),'YYYYMMDD'),+1),'YYYYMMDD')";
    SQL = SQL + "                                  AND TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(TO_CHAR('" + l_date_from + "'),'YYYYMMDD'),-1)),'YYYYMMDD')";
    SQL = SQL + "                              AND TCO_COMPANY_PK = " + l_company + "";
    SQL = SQL + "                              AND DEL_IF=0";
    SQL = SQL + "                              AND ( TR_STATUS = '" + l_Status + "' OR '" + l_Status + "' is null )";
    SQL = SQL + "                            GROUP BY TAC_ABACCTCODE_PK) B,";
    
    SQL = SQL + "                          (SELECT MAX(TAC_ABACCTCODE_PK) TAC_ABACCTCODE_PK, ";
    SQL = SQL + "                                  NVL(SUM(YMD_DRBOOKS),0) DR_PS,";
    SQL = SQL + "                                  NVL(SUM(YMD_CRBOOKS),0) CR_PS";
    SQL = SQL + "                             FROM TAC_HGDDBAL";
    SQL = SQL + "                            WHERE STD_YMD BETWEEN TO_CHAR('" + l_date_from + "') AND '" + l_date_to + "' ";
    SQL = SQL + "                              AND TCO_COMPANY_PK = " + l_company + " ";
    SQL = SQL + "                              AND DEL_IF = 0";
    SQL = SQL + "                              AND ( TR_STATUS = '" + l_Status + "' OR '" + l_Status + "' is null ) ";
    SQL = SQL + "                            GROUP BY TAC_ABACCTCODE_PK) D,";
    SQL = SQL + "                          (SELECT a.PK, c.AC_CD_FORMULAR AC_CD, DECODE(c.DRCR_TYPE,'D',1,-1) DC, B.FONT_STYPE BOLD_YN, B.PRN_COLOR COLOR, ";
    SQL = SQL + "                                  DECODE('ENG','ENG',c.AC_NM,'VIE', c.AC_LNM,'KOR', c.AC_KNM) AC_NM";
    SQL = SQL + "                             FROM TAC_ABACCTCODE A, TAC_KAFINANCEFORM_LEVEL B, tac_localcode c";
    SQL = SQL + "                            WHERE A.DEL_IF    = 0";
    SQL = SQL + "                              AND B.DEL_IF    = 0";
    SQL = SQL + "                              and c.del_if    = 0";
    SQL = SQL + "                              AND A.TAC_LOCALCODE_PK    = C.PK";
    SQL = SQL + "                              AND A.AC_LEVEL = B.PRN_LEVEL";
    SQL = SQL + "                              AND A.TCO_COMPANY_PK = " + l_company + "";
    SQL = SQL + "                              AND A.AC_CD LIKE '' || '%'";
    SQL = SQL + "                              AND A.AC_LEVEL LIKE DECODE('', '', '%', '')";
    SQL = SQL + "                              AND A.LEAF_YN  LIKE DECODE('Y', '', '%', 'Y')) E";
    SQL = SQL + "                     WHERE E.PK = D.TAC_ABACCTCODE_PK(+)";
    
    SQL = SQL + "                       AND E.PK = B.TAC_ABACCTCODE_PK(+)";
    SQL = SQL + "                       AND E.PK = A.TAC_ABACCTCODE_PK(+) ";
    SQL = SQL + " 					ORDER BY E.AC_CD)";
    SQL = SQL + " 				WHERE OP <> 0 OR DR_PS <> 0 OR CR_PS <> 0";

//Response.Write(SQL);
//Response.End();



    DataTable dt_bal = ESysLib.TableReadOpen(SQL);
	%>
	
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfhg00050_DailyEntryInq_files/filelist.xml">
<link rel=Edit-Time-Data href="gfhg00050_DailyEntryInq_files/editdata.mso">
<link rel=OLE-Object-Data href="gfhg00050_DailyEntryInq_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2008-05-05T07:43:24Z</o:LastPrinted>
  <o:Created>2008-03-13T01:45:00Z</o:Created>
  <o:LastSaved>2008-05-14T01:27:13Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.5in .25in .25in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style16
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:Comma;
	mso-style-id:3;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
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
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl24
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl25
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"<%= p_xls_ccy_format%>";
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"<%= p_xls_ccy_format%>";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl43
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl44
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl47
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style16;
	color:blue;
	font-size:9.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"<%= p_xls_ccy_format%>";
	text-align:right;}
.xl53
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl55
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"<%= p_xls_ccy_format%>";
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl59
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl60
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl61
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Daily Entry Inquiry</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>360</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>7</x:SplitHorizontal>
     <x:TopRowBottomPane>7</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9270</x:WindowHeight>
  <x:WindowWidth>14160</x:WindowWidth>
  <x:WindowTopX>600</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl29>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1025 style='border-collapse:
 collapse;table-layout:fixed;width:769pt'>
 <col class=xl29 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl29 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl29 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl29 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl29 width=180 style='mso-width-source:userset;mso-width-alt:6582;
 width:135pt'>
 <col class=xl29 width=53 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col class=xl29 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl29 width=115 style='mso-width-source:userset;mso-width-alt:4205;
 width:86pt'>
 <col class=xl29 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl29 width=187 style='mso-width-source:userset;mso-width-alt:6838;
 width:140pt'>
 <col class=xl29 width=62 span=246 style='mso-width-source:userset;mso-width-alt:
 2267;width:47pt'>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl28 colspan=4 width=261 style='height:18.0pt;mso-ignore:
  colspan;width:196pt'>DAILY ENTRY INQUIRY</td>
  <td class=xl29 width=180 style='width:135pt'></td>
  <td class=xl29 width=53 style='width:40pt'></td>
  <td class=xl29 width=71 style='width:53pt'></td>
  <td class=xl29 width=115 style='width:86pt'></td>
  <td class=xl29 width=96 style='width:72pt'></td>
  <td class=xl29 width=187 style='width:140pt'></td>
  <td class=xl29 width=62 style='width:47pt'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td colspan=4 height=18 class=xl30 style='height:14.1pt'>as at <%= l_str_today %></td>
  <td colspan=7 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl27 colspan=2 style='height:18.0pt;mso-ignore:colspan'>Company:</td>
  <td colspan=3 class=xl58><%= l_cmp_name %></td>
  <td class=xl41 width=53 style='width:40pt'>Period:</td>
  <td colspan=2 class=xl59><%= l_date_fr2 %> ~ <%= l_date_to2 %></td>
  <td class=xl42 x:str="Status:   ">Status:<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl43><%= l_status_dsp %></td>
  <td class=xl30></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 colspan=2 class=xl27 style='height:8.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td class=xl27></td>
  <td class=xl30></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl27 style='height:14.25pt'></td>
  <td class=xl27>SUMMARY :</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td class=xl52 x:num><%= l_total_dr %></td>
  <td class=xl52 x:num><%= l_total_cr %></td>
  <td class=xl27></td>
  <td class=xl30></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 colspan=2 class=xl27 style='height:8.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td class=xl27></td>
  <td class=xl30></td>
 </tr>
 <tr height=42 style='mso-height-source:userset;height:31.5pt'>
  <td colspan=2 height=42 class=xl61 width=124 style='border-right:.5pt solid black;
  height:31.5pt;width:93pt'>Account <br>
    code</td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none'>Account Name</td>
  <td class=xl48 style='border-left:none'>Control Item</td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black'>Begin Balance</td>
  <td class=xl48 style='border-left:none'>Debit amount</td>
  <td class=xl49>Credit amount</td>
  <td class=xl45>Ending Balance</td>
  <td class=xl30></td>
 </tr>
 <%
	if (dt_bal.Rows.Count >0)
	{
		for(int i=0;i<dt_bal.Rows.Count;i++)
		{
 %>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td colspan=2 height=22 class=xl62 style='border-right:.5pt solid black;  height:17.1pt' x:num=""><%= dt_bal.Rows[i][0].ToString() %></td>
  <td colspan=2 class=xl56 style='border-right:.5pt solid black;border-left:  none'><%= dt_bal.Rows[i][1].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'></td>
  <td colspan=2 class=xl39 x:num=""><%= dt_bal.Rows[i][2].ToString() %></td>
  <td class=xl39 style='border-top:none' x:num=""><%= dt_bal.Rows[i][3].ToString() %></td>
  <td class=xl40 style='border-top:none' x:num=""><%= dt_bal.Rows[i][4].ToString() %></td>
  <td class=xl39 style='border-top:none' x:num=""><%= dt_bal.Rows[i][5].ToString() %></td>
  <td class=xl30></td>
 </tr>
  <%
		}
	}
 	
 %>
 
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl27 style='height:14.25pt'></td>
  <td class=xl27>DETAIL:</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td class=xl27></td>
  <td class=xl30></td>
 </tr>
 <tr class=xl30 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl45 style='height:30.0pt'>Seq</td>
  <td class=xl46>Voucher no</td>
  <td class=xl46>Trs Date</td>
  <td class=xl47 width=72 style='width:54pt'>Account <br>
    code</td>
  <td class=xl46>Description</td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none'>Local description</td>
  <td class=xl46>Debit amount</td>
  <td class=xl46>Credit amount</td>
  <td class=xl46>Item control</td>
  <td class=xl46 style="border-right:1;">EnClose</td>
 </tr>
<%
	if (dt_detail.Rows.Count >0)
	{
		for(int i=0;i<dt_detail.Rows.Count;i++)
		{
 %>
 <tr class=xl30 height=<%= l_row_height %> style='mso-height-source:userset;'>
  <td  class=xl51 x:num><%= dt_detail.Rows[i][0].ToString() %></td>
  <td class=xl50><%= dt_detail.Rows[i][2].ToString()  %></td>
  <td class=xl36><%= dt_detail.Rows[i][1].ToString()  %></td>
  <td class=xl36 x:num><%= dt_detail.Rows[i][3].ToString()  %></td>
  <td class=xl44 width=180 style='width:135pt'  ><%= dt_detail.Rows[i][9].ToString()  %></td>
  <td colspan=2 class=xl53 width=124 style='border-right:.5pt solid black;
  border-left:none;width:93pSt'><%= dt_detail.Rows[i][10].ToString()  %></td>
  <td class=xl39 style='border-top:none' x:num><%= dt_detail.Rows[i][7].ToString()  %></td>
  <td class=xl39 style='border-top:none;border-left:none' x:num><%= dt_detail.Rows[i][8].ToString() %></td>
  <td class=xl44 width=187 style='width:140pt'><%= dt_detail.Rows[i][11].ToString()  %></td>
  <td class=xl44 style="border-right:1;"><%= dt_detail.Rows[i][14].ToString()  %></td>
 </tr>
 <%
		}
	}
 	
 %>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl33 style='height:21.95pt;border-top:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none'>&nbsp;</td>
  <td class=xl29></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=51 style='width:38pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=187 style='width:140pt'></td>
  <td width=62 style='width:47pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
