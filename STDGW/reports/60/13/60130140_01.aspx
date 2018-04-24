<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<%
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    
    
    string p_comp = "" + Request["company_pk"];    
    string p_kind = ""+Request["KindCode"];
	string p_dept = ""+Request["DeptPK"];
	string p_status = ""+Request["Status"];
	string p_fa_acc = ""+ Request["AssetAccCode"];
	string p_depr_acc = ""+ Request["AssetDepr"]	;
	string p_expe_acc = ""+ Request["ExpAcc"];
    string p_from = "" + Request["dtFrom"];
    string p_to = "" + Request["dtTo"];
	string p_ccy = "" + Request["ccy"];
    string from_month = p_from.Substring(4, 2) + "/" + p_from.Substring(0, 4);
    string to_month = p_to.Substring(4, 2) + "/" + p_to.Substring(0, 4);
    string comp_name = "";
    string comp_lname = "";
    string address = "";
    string tax_code = "";
    string kind_code ="";
    string kind_code_dept = "";
    int j = 0, k=0;
    int stt = 0;
    string depr_date = "";
    string tmp_date = "";
    int month_depr = 0;
    int tmp_yy = 0;
    int tmp_mm = 0;
	
	string p_xls_ccy_format = "";
    string l_ccy = "";
    if (p_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
	
	
    string l_fa_cd_pk = "", l_depr_acc_pk = "", l_expe_acc_pk = "";
    string SQL = " SELECT pk, partner_name, partner_lname, addr1 ||addr2||addr3 address, tax_code ";
    SQL += "  FROM tco_company ";
    SQL += " WHERE del_if = 0 AND pk = '" + p_comp + "'";
    DataTable dtCom = new DataTable();
    dtCom = ESysLib.TableReadOpen(SQL);	
    if (dtCom.Rows.Count > 0)
    {
        comp_name = dtCom.Rows[0][1].ToString();
        comp_lname = dtCom.Rows[0][2].ToString();
        address = dtCom.Rows[0][3].ToString();
        tax_code = dtCom.Rows[0][4].ToString();
    }
	SQL
	= "    select pk from tac_abacctcode where del_if = 0 and ac_cd = '" + p_fa_acc + "' and tco_company_pk = '" + p_comp + "' " ;
    DataTable dtFA_CD = new DataTable();
    dtFA_CD = ESysLib.TableReadOpen(SQL);	
	if(dtFA_CD.Rows.Count > 0)
	{
		l_fa_cd_pk = dtFA_CD.Rows[0][0].ToString();
	}
	else
	{
		l_fa_cd_pk = "ALL";
	}

	SQL
	= "    select pk from tac_abacctcode where del_if = 0 and ac_cd = '" + p_depr_acc + "' and tco_company_pk = '" + p_comp + "' " ;
    DataTable dtDepr_CD = new DataTable();
    dtDepr_CD = ESysLib.TableReadOpen(SQL);	
	if(dtDepr_CD.Rows.Count > 0)
	{
		l_depr_acc_pk = dtDepr_CD.Rows[0][0].ToString();
	}
	else
	{
		l_depr_acc_pk = "ALL";
	}

	SQL
	= "    select pk from tac_abacctcode where del_if = 0 and ac_cd = '" + p_expe_acc + "' and tco_company_pk = '" + p_comp + "' " ;
    DataTable dtExpe_CD = new DataTable();
    dtExpe_CD = ESysLib.TableReadOpen(SQL);	
	if(dtExpe_CD.Rows.Count > 0)
	{
		l_expe_acc_pk = dtExpe_CD.Rows[0][0].ToString();
	}
	else
	{
		l_expe_acc_pk = "ALL";
	}
	
    string SQLD = "SELECT a.fa_cd, a.fa_nm, a.fa_kind_cd,a.fa_qty, " +
                 "       a.fa_depr_date, a.fa_depr_yy, a.fa_depr_mm, " +
                 "       DECODE('"+p_ccy+"','VND', round(FA_FCOST,0), round(FA_FCOST,2)) FA_FCOST, DECODE('"+p_ccy+"','VND', round(fa_depr_amt,0), round(fa_depr_amt,2)) fa_deprmonth_amt ,  DECODE('"+p_ccy+"','VND', round(NVL (b.fd_damt, 0), 0),round(NVL (b.fd_damt, 0), 2))  fa_depr_amt, " +
                 "       DECODE ('"+p_ccy+"','VND', round(NVL (a.fa_begin_depr_amt, 0) + NVL (b.fd_begin, 0)+ NVL (b.fd_damt, 0),0), round(NVL (a.fa_begin_depr_amt, 0) + NVL (b.fd_begin, 0)+ NVL (b.fd_damt, 0),2)) fa_depr_accum," +
                 "       DECODE ('"+p_ccy+"','VND', round(a.fa_fcost - NVL (a.fa_begin_depr_amt, 0) - NVL (b.fd_begin, 0) - NVL (b.fd_damt, 0),0),round(a.fa_fcost - NVL (a.fa_begin_depr_amt, 0) - NVL (b.fd_begin, 0) - NVL (b.fd_damt, 0),2)) fa_remain_amt," +
                 "       SF_A_GET_ACCD(a.tac_abacctcode_pk_depr,a.tco_company_pk) depr_acc, " +
                 "       SF_A_GET_ACCD(a.tac_abacctcode_pk_expe,a.tco_company_pk) expe_acc  " +
                 "       , DECODE ('"+p_ccy+"','VND', round(NVL (a.fa_fcost, 1) / DECODE (NVL (a.fa_qty, 1), 0, 1, NVL (a.fa_qty, 1)),0),round(NVL (a.fa_fcost, 1) / DECODE (NVL (a.fa_qty, 1), 0, 1, NVL (a.fa_qty, 1)),2)) u_price, a.remark, a.remark2,c.org_nm,c.pk dept_pk,  " +
                 "       sf_a_get_accd (a.TAC_ABACCTCODE_PK,a.tco_company_pk) asset_acc, c.seq " +
                 "FROM tac_gffa_mst a, " +
                 "     (SELECT tac_gffa_mst_pk, SUM(fd_fbegin) fd_fbegin, SUM(fd_begin) fd_begin, " +
                 "             SUM(fd_dfamt) fd_dfamt, SUM(fd_damt) fd_damt" +
                 "       FROM(  SELECT d.tac_gffa_mst_pk, fd_ym, " +
                 "                     CASE WHEN m.fd_ym < '" + p_from + "' THEN d.fd_dfamt ELSE 0  END fd_fbegin," +
                 "                     CASE WHEN m.fd_ym < '" + p_from + "' THEN d.fd_damt  ELSE 0  END fd_begin," +
                 "                     CASE WHEN m.fd_ym >= '" + p_from + "' THEN d.fd_dfamt ELSE 0 END fd_dfamt," +
                 "                     CASE WHEN m.fd_ym >= '" + p_from + "' THEN d.fd_damt ELSE 0  END fd_damt " +
                 "                FROM tac_gffadprc_dtl d, tac_gffadprc_mst m " +
                 "               WHERE d.del_if = 0 AND m.del_if = 0 " +
                 "                 AND d.tac_gffadprc_mst_pk = m.pk " +
                 "                 AND m.fd_status <> '3' " +
                 "                 AND m.fd_ym <= '" + p_to + "')" +
                 "               GROUP BY tac_gffa_mst_pk) b " +
                 "         , tco_org c " +
                 "      WHERE a.del_if = 0  " +
                 "        AND b.tac_gffa_mst_pk(+) = a.pk" +
                 "        and c.del_if (+)= 0 and a.tco_org_pk = c.pk(+) " +
                 "       AND a.tco_company_pk = '" + p_comp + "'" +
                 "       AND a.fa_kind_cd LIKE '%'||'" + p_kind + "'||'%'" +
                 "       AND a.tco_org_pk LIKE '%'||'" + p_dept + "'||'%'" +
                 "       AND decode('" + l_fa_cd_pk + "', 'ALL', 'ALL', a.tac_abacctcode_pk) = '" + l_fa_cd_pk + "' " +
				 "       AND decode('" + l_depr_acc_pk + "', 'ALL', 'ALL', a.tac_abacctcode_pk_depr ) = '" + l_depr_acc_pk + "' " +
                 "       AND decode('" + l_expe_acc_pk + "', 'ALL', 'ALL', a.tac_abacctcode_pk_expe ) = '" + l_expe_acc_pk + "' " +
                 "       AND a.FA_USE_DATE <= tO_char(last_day(to_date('" + p_to + "'||'01','yyyymmdd')),'yyyymmdd')  " +
                 "       AND a.fa_status LIKE DECODE('" + p_status + "', '', '%', '" + p_status + "') " +
                 "       AND ( nvl(a.unused_dt,to_char(sysdate,'yyyymmdd')) >= TO_CHAR(LAST_DAY(TO_DATE('" + p_to + "' || '01', 'yyyymmdd') ), 'yyyymmdd') or a.unused_dt is null) " +
                 "         ORDER BY a.fa_cd";

  // Response.Write(SQLD);
  //   Response.End();
    DataTable data = new DataTable();
    data = ESysLib.TableReadOpen(SQLD);    
    
    string SQLK = "SELECT fa_kind_cd,upper(SF_GET_COMMCODE_NM('ACDF0010',fa_kind_cd)) fa_kind_NM, sum(fa_fcost) fa_cost, sum(fa_deprmonth_amt) fa_deprmonth_amt, " +
                  "       sum(fa_depr_amt) fa_depr_amt, sum(fa_depr_accum) fa_depr_accum, sum(fa_remain_amt) fa_remain_amt" +
                  " FROM ( " + SQLD + " )" +
                  " GROUP BY fa_kind_cd ORDER BY fa_kind_cd";
    DataTable dt_kind = ESysLib.TableReadOpen(SQLK);

    string SQLK_D = "SELECT fa_kind_cd ,dept_pk,SF_GET_COMMCODE_NM('ACDF0010',fa_kind_cd) fa_kind_NM, INITCAP(org_nm) dept_nm, sum(fa_fcost) fa_cost, sum(fa_deprmonth_amt) fa_deprmonth_amt, " +
                  "       sum(fa_depr_amt) fa_depr_amt, sum(fa_depr_accum) fa_depr_accum, sum(fa_remain_amt) fa_remain_amt" +
                  " FROM ( " + SQLD + " )" +
                  " GROUP BY fa_kind_cd,org_nm,dept_pk,seq ORDER BY fa_kind_cd,seq";
    
    DataTable dt_kind_d = ESysLib.TableReadOpen(SQLK_D);
    
    string SQLT = "SELECT sum(fa_fcost) fa_cost, sum(fa_deprmonth_amt) fa_deprmonth_amt, " +
                  "       sum(fa_depr_amt) fa_depr_amt, sum(fa_depr_accum) fa_depr_accum, sum(fa_remain_amt) fa_remain_amt" +
                  " FROM ( " + SQLD + " )" ;
    DataTable total = ESysLib.TableReadOpen(SQLT);   
 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfgf00040_01_files/filelist.xml">
<link rel=Edit-Time-Data href="gfgf00040_01_files/editdata.mso">
<link rel=OLE-Object-Data href="gfgf00040_01_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Acc</o:Author>
  <o:LastAuthor>Acc</o:LastAuthor>
  <o:LastPrinted>2008-11-06T07:31:57Z</o:LastPrinted>
  <o:Created>2008-11-06T07:21:07Z</o:Created>
  <o:LastSaved>2008-11-06T08:59:17Z</o:LastSaved>
  <o:Company>genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in 0in .75in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
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
.xl24
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl34
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl37
	{mso-style-parent:style0;
	text-align:left;}
.xl38
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl39
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl45
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
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
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>22</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
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
  <x:WindowWidth>15180</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1176 style='border-collapse:
 collapse;table-layout:fixed;width:884pt'>
 <col width=32 style='mso-width-source:userset;mso-width-alt:1170;width:24pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=238 style='mso-width-source:userset;mso-width-alt:8704;width:179pt'>
 <col width=42 style='mso-width-source:userset;mso-width-alt:1536;width:32pt'>
 <col width=83 style='mso-width-source:userset;mso-width-alt:3035;width:62pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=102 style='mso-width-source:userset;mso-width-alt:3730;width:77pt'>
 <col width=93 style='mso-width-source:userset;mso-width-alt:3401;width:70pt'>
 <col width=90 style='mso-width-source:userset;mso-width-alt:3291;width:68pt'>
 <col width=95 style='mso-width-source:userset;mso-width-alt:3474;width:71pt'>
 <col width=93 style='mso-width-source:userset;mso-width-alt:3401;width:70pt'>
 <col width=76 style='mso-width-source:userset;mso-width-alt:2779;width:57pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 width=32 style='height:10.5pt;width:24pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=238 style='width:179pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=79 style='width:59pt'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=3 height=19 class=xl36 style='height:14.25pt'><%=comp_name%></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=3 height=17 class=xl37 style='height:12.75pt'><%=address%></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 style='height:20.25pt'></td>
  <td colspan=10 class=xl38>LIST OF FIXED ASSETS DEPRECIATION</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=10 class=xl24>From :<%=from_month%><span style='mso-spacerun:yes'>           
  </span>To :<%=to_month%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=13 style='height:7.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl26 width=32 style='height:30.0pt;width:24pt'>No</td>
  <td class=xl27 width=79 style='width:59pt'>Asset code</td>
  <td class=xl27 width=238 style='width:179pt'>Asset Name</td>
  <td class=xl27 width=42 style='width:32pt'>Qty</td>
  <td class=xl27 width=83 style='width:62pt'>Date of depreciation</td>
  <td class=xl27 width=74 style='width:56pt'>Estimate life(month)</td>
  <td class=xl27 width=102 style='width:77pt'>Original Cost</td>
  <td class=xl27 width=93 style='width:70pt'>Depr. Per Month</td>
  <td class=xl27 width=90 style='width:68pt'>Depr. In period</td>
  <td class=xl27 width=95 style='width:71pt'>Accumulation</td>
  <td class=xl27 width=93 style='width:70pt'>Remain</td>
  <td class=xl27 width=76 style='width:57pt'>Asset Acc.</td>
  <td class=xl27 width=76 style='width:57pt'>Depr. Acc</td>
  <td class=xl27 width=79 style='width:59pt'>Expe. Acc</td>
  <td class=xl27 width=79 style='width:59pt'>Unit Price</td>
  <td class=xl27 width=79 style='width:59pt'>Description</td>
  <td class=xl27 width=79 style='width:59pt'>Description </td>
 </tr>
 <%
    if(dt_kind.Rows.Count > 0)
    {
        for (int i = 0; i < dt_kind.Rows.Count; i++)
        {
            kind_code = dt_kind.Rows[i]["fa_kind_cd"].ToString();
 %>
 <tr class=xl28 height=17 style='mso-height-source:userset;height:12.75pt'>
  <!--td height=17 class=xl29 style='height:12.75pt'>&nbsp;</td-->
  <td colspan=3 class=xl39 style='border-right:.5pt solid black;border-left:
  none'><%=dt_kind.Rows[i]["fa_kind_NM"].ToString()%>   </td>
  <td class=xl30 ></td>
  <td class=xl30 ></td>
  <td class=xl30 ></td>
  <td class=xl31 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=dt_kind.Rows[i]["fa_cost"].ToString()%></td>
  <td class=xl31 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=dt_kind.Rows[i]["fa_deprmonth_amt"].ToString()%></td>
  <td class=xl31 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=dt_kind.Rows[i]["fa_depr_amt"].ToString()%></td>
  <td class=xl31 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=dt_kind.Rows[i]["fa_depr_accum"].ToString()%></td>
  <td class=xl31 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=dt_kind.Rows[i]["fa_remain_amt"].ToString()%></td>
  
  <td class=xl30 ></td>
  <td class=xl30 ></td>
  <td class=xl30 ></td>
  <td class=xl30 ></td>
  <td class=xl30 ></td>
   <td class=xl30 ></td>
 </tr>
 <% 
     if (dt_kind_d.Rows.Count > 0)
     {
         for (k = 0; k < dt_kind_d.Rows.Count; k++)
         {
             kind_code_dept = dt_kind_d.Rows[k]["dept_pk"].ToString();
             if (dt_kind_d.Rows[k]["fa_kind_cd"].ToString() == kind_code)
             {
                
%>

<tr class=xl28 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt'>&nbsp;</td>
  <td colspan=2 class=xl39 style='border-right:.5pt solid black;border-left:
  none'><%=dt_kind_d.Rows[k]["dept_nm"].ToString()%>   </td>
  <td class=xl30 >&nbsp;</td>
  <td class=xl30 >&nbsp;</td>
  <td class=xl30 >&nbsp;</td>
  <td class=xl31 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=dt_kind_d.Rows[k]["fa_cost"].ToString()%></td>
  <td class=xl31 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=dt_kind_d.Rows[k]["fa_deprmonth_amt"].ToString()%></td>
  <td class=xl31 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=dt_kind_d.Rows[k]["fa_depr_amt"].ToString()%></td>
  <td class=xl31 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=dt_kind_d.Rows[k]["fa_depr_accum"].ToString()%></td>
  <td class=xl31 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=dt_kind_d.Rows[k]["fa_remain_amt"].ToString()%></td>
  
  <td class=xl30 >&nbsp;</td>
  <td class=xl30 >&nbsp;</td>
  <td class=xl30 >&nbsp;</td>
  <td class=xl30 >&nbsp;</td>
  <td class=xl30 >&nbsp;</td>
  <td class=xl30 >&nbsp;</td>
 </tr>

 <%
     if (data.Rows.Count > 0)
     {
         stt = 0;
         for (j = 0; j < data.Rows.Count; j++)
         {
             if (data.Rows[j]["fa_kind_cd"].ToString() == kind_code && data.Rows[j]["dept_pk"].ToString() ==  kind_code_dept)
             {
                 stt++;
                 tmp_date = data.Rows[j]["fa_depr_date"].ToString();
                 depr_date = tmp_date.Substring(6, 2) + "/" + tmp_date.Substring(4, 2) + "/" + tmp_date.Substring(0, 4);
                 if (data.Rows[j]["fa_depr_yy"].ToString() != "")
                 {
                     tmp_yy = int.Parse(data.Rows[j]["fa_depr_yy"].ToString());
                 }
                 else
                 {
                     tmp_yy = 0;
                 }

                 if (data.Rows[j]["fa_depr_mm"].ToString() != "")
                 {
                     tmp_mm = int.Parse(data.Rows[j]["fa_depr_mm"].ToString());
                 }
                 else
                 {
                     tmp_mm = 0;
                 }
                 month_depr = tmp_yy * 12 + tmp_mm;
 %>
 <tr class=xl32 height=16 style='height:12.0pt'>
  <td height=16 class=xl45 style='height:12.0pt;border-top:none;text-align:center' x:num><%= stt%></td>
  <td class=xl45 style='border-top:none;border-left:none'><%=data.Rows[j]["fa_cd"].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none'><%=data.Rows[j]["fa_nm"].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none' x:num><%=data.Rows[j]["fa_qty"].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none'><%=depr_date%></td>
  <td class=xl45 style='border-top:none;border-left:none;text-align:right'><%=month_depr%></td>
  <td class=xl46 style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=data.Rows[j]["fa_fcost"].ToString()%></td>
  <td class=xl46 style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=data.Rows[j]["fa_deprmonth_amt"].ToString()%></td>
  <td class=xl46 style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=data.Rows[j]["fa_depr_amt"].ToString()%></td>
  <td class=xl46 style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=data.Rows[j]["fa_depr_accum"].ToString()%></td>
  <td class=xl46 style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=data.Rows[j]["fa_remain_amt"].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none'><%=data.Rows[j]["asset_acc"].ToString()%>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'><%=data.Rows[j]["depr_acc"].ToString()%>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'><%=data.Rows[j]["expe_acc"].ToString()%>&nbsp;</td>
  <td class=xl46 style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'"  x:num><%=data.Rows[j]["u_price"].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none'><%=data.Rows[j]["remark"].ToString()%>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'><%=data.Rows[j]["remark2"].ToString()%>&nbsp;</td>
 </tr>
 <%
     }
 }
}



            }// if dept 1
        } // for dept  
    } // if dept    
             

  %><%
        }
    }
  %>
  <%
      if (total.Rows.Count > 0)
      {
 %>
 <tr class=xl33 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=3 height=17 class=xl41 style='border-right:.5pt solid black;
  height:12.75pt'>TOTAL</td>
  <td class=xl34 >&nbsp;</td>
  <td class=xl34 >&nbsp;</td>
  <td class=xl34 >&nbsp;</td>
  <td class=xl35 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=total.Rows[0]["fa_cost"].ToString()%></td>
  <td class=xl35 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=total.Rows[0]["fa_deprmonth_amt"].ToString()%></td>
  <td class=xl35 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=total.Rows[0]["fa_depr_amt"].ToString()%></td>
  <td class=xl35 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=total.Rows[0]["fa_depr_accum"].ToString()%></td>
  <td class=xl35 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=total.Rows[0]["fa_remain_amt"].ToString()%></td>
  <td class=xl34 >&nbsp;</td>
  <td class=xl34 >&nbsp;</td>
  <td class=xl34 >&nbsp;</td>
  <td class=xl34 >&nbsp;</td>
  <td class=xl34 >&nbsp;</td>
  <td class=xl34 >&nbsp;</td>
 </tr>
 <%} %>
 <tr class=xl32 height=16 style='height:12.0pt'>
  <td height=16 colspan=13 class=xl32 style='height:12.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=9 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl44>Day...…..Month...…….Year.....</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl24>Prepared by</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24>Director</td>
  <td></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=32 style='width:24pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=238 style='width:179pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=79 style='width:59pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
