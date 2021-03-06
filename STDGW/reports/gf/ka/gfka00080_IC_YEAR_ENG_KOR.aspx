﻿<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
  string l_kind=Request["p_kind"];  
  string l_status=Request["p_status"];
  string l_tco_company_pk=Request["p_tco_company_pk"];
  string l_date_fr=Request["p_date_fr"];
  string l_date_to=Request["p_date_to"];
  string l_date_type=Request["p_date_type"];
  string l_quarter = Request["p_quarter"];
  string l_Scale = Request["p_Scale"];
  string l_ccy = Request["p_ccy"];
  string l_rate = Request["p_rate"];
  string l_month = Request["p_month"];
  string l_Scale1 = "";
  if (Request["p_Scale"] != "1")
  {
      l_Scale1 = Request["p_Scale"];
  }        
  string p_xls_ccy_format = "";

  string p_bookccy = "";
   string SQL = "SELECT AC_GET_BOOKCCY_ACNT('ACBG0040') FROM DUAL " ;
  DataTable dt_bookccy = ESysLib.TableReadOpen(SQL);

	if (dt_bookccy.Rows.Count >0)
	{	
		p_bookccy = dt_bookccy.Rows[0][0].ToString();
	}
    if (p_bookccy == "VND")
  {
      p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";      
  }
  else
  {
      p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";      
  }
  string fr_dt, to_dt, l_cmp_name, l_cmp_add, l_cmp_taxcode, to_dt_e, quater, curr_date, last_Date;
  fr_dt = "";
  to_dt = "";
  l_cmp_name = "";
  l_cmp_add = "";
  l_cmp_taxcode = "";
  to_dt_e = "";
  quater = "";
  curr_date = "";
  last_Date = "";
  string SQL1 = " SELECT PARTNER_NAME, ADDR1, ADDR2, TAX_CODE " +
      ",to_char(to_date('" + l_date_fr + "','yyyymmdd'),'dd/mm/yyyy') fr_dt,to_char(to_date('" + l_date_to + "','yyyymmdd'),'dd/mm/yyyy') to_dt" +
      ",to_char(to_date('" + l_date_to + "','yyyymmdd'),'dd-Mon-yyyy') sign_dt" +
      ",decode('" + l_quarter + "','1','I','2','II','3','III','IV')" +
     ",to_char(to_date('" + l_date_to + "','yyyymmdd'),'yyyy') curr_date" +
      ",TO_CHAR (ADD_MONTHS (TO_DATE ('" + l_date_to + "', 'yyyymmdd'), -12), 'yyyy') last_yyyy" +
    " FROM TCO_COMPANY WHERE PK = '" + l_tco_company_pk + "' ";

  DataTable dt_f = ESysLib.TableReadOpen(SQL1);
  if (dt_f.Rows.Count > 0)
  {
      l_cmp_name = dt_f.Rows[0][0].ToString();
      l_cmp_add = dt_f.Rows[0][1].ToString();
      l_cmp_taxcode = dt_f.Rows[0][3].ToString();
      fr_dt = dt_f.Rows[0][4].ToString();
      to_dt = dt_f.Rows[0][5].ToString();
      to_dt_e = dt_f.Rows[0][6].ToString();
      quater = dt_f.Rows[0][7].ToString();
      curr_date = dt_f.Rows[0][8].ToString();
      last_Date = dt_f.Rows[0][9].ToString();
  }
  string l_parameter = "'" + l_kind + "','" + l_status + "','" + l_tco_company_pk + "','" + l_date_fr + "','" + l_date_to + "','" + l_date_type + "','" + l_Scale + "','" + l_ccy + "','" + l_rate + "','" + l_month + "'";
  string sp = "ac_sel_60080240_income";
  DataTable dt = ESysLib.TableReadOpenCursor(sp,l_parameter);  
  if (dt.Rows.Count==0)
  {
    Response.Write("There is no data");
    Response.End();
  }
  string l_col1_1 = "";
  string l_col1_2 = "";
  string l_col1_3 = "";

  string l_col2_1 = "";
  string l_col2_2 = "";
  string l_col2_3 = "";

  string l_col3_1 = "";
  string l_col3_2 = "";
  string l_col3_3 = "";

  string SQL2 = "SELECT   char_1, char_2, char_3, code " +
        "    FROM tac_commcode_master a, tac_commcode_detail b " +
        "   WHERE a.pk = b.tac_commcode_master_pk AND a.ID = 'EACAB031' " +
        "         AND a.del_if = 0 AND b.del_if = 0 AND b.use_yn = 'Y' " +
        "         AND(code LIKE 'ENG%' OR code LIKE 'VIE%') " +
        "ORDER BY code, b.code_nm ";


  // Response.Write(SQL2);
  // Response.End();
  DataTable dt_s = ESysLib.TableReadOpen(SQL2);
  if (dt_s.Rows.Count > 0)
  {
      l_col1_1 = dt_s.Rows[0][0].ToString();
      l_col1_2 = dt_s.Rows[1][0].ToString();
      l_col1_3 = dt_s.Rows[2][0].ToString();

      l_col2_1 = dt_s.Rows[0][1].ToString();
      l_col2_2 = dt_s.Rows[1][1].ToString();
      l_col2_3 = dt_s.Rows[2][1].ToString();

      l_col3_1 = dt_s.Rows[0][2].ToString();
      l_col3_2 = dt_s.Rows[1][2].ToString();
      l_col3_3 = dt_s.Rows[2][2].ToString();

  }

  string name1 = "";
  string name2 = "";
  string name3 = "";
  string SQL_NAME = "SELECT   char_1, char_2, char_3, code " +
          "    FROM tac_commcode_master a, tac_commcode_detail b " +
          "   WHERE a.pk = b.tac_commcode_master_pk AND a.ID = 'EACAB031' " +
          "         AND a.del_if = 0 AND b.del_if = 0 AND b.use_yn = 'Y' " +
          "         AND code='NAM' " +
          "ORDER BY code, b.code_nm ";

  DataTable dt_NAME = ESysLib.TableReadOpen(SQL_NAME);

  if (dt_NAME.Rows.Count > 0)
  {
      name1 = dt_NAME.Rows[0][0].ToString();
      name2 = dt_NAME.Rows[0][1].ToString();
      name3 = dt_NAME.Rows[0][2].ToString();

  }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00080_CF_PERIOD_VIE_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00080_CF_PERIOD_VIE_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00080_CF_PERIOD_VIE_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Thu Hien</o:LastAuthor>
  <o:LastPrinted>2009-01-22T04:03:04Z</o:LastPrinted>
  <o:LastSaved>2009-01-22T04:06:14Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .25in .75in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.5in;}
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
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
	border-left:none;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl46
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
	border-left:.5pt solid windowtext;}
.xl47
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
	border-left:none;}
.xl48
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
	border-left:none;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
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
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\\ \\ \\ ";
	text-align:left;
	vertical-align:middle;}
.xl60
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\\ \\ \\ ";
	text-align:left;
	vertical-align:middle;}
.xl61
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl62
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl63
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl64
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl65
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl66
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl67
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl68
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
	border-left:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
	
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>gfka00080_CF_PERIOD_VIE</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>87</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>1</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8445</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>
<!--The following information was generated by Microsoft Office Excel's Publish
as Web Page wizard.--><!--If the same item is republished from Excel, all information between the DIV
tags will be replaced.--><!-----------------------------><!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD --><!----------------------------->

<table x:str border=0 cellpadding=0 cellspacing=0 width=1391 style='border-collapse:
 collapse;table-layout:fixed;width:1046pt'>
 <col class=xl24 width=390 span=2 style='mso-width-source:userset;mso-width-alt:
 14262;width:293pt'>
 <col class=xl25 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl25 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl26 width=138 span=2 style='mso-width-source:userset;mso-width-alt:
 5046;width:104pt'>
 <col class=xl27 width=138 style='mso-width-source:userset;mso-width-alt:5046;
 width:104pt'>
 <col width=64 style='width:48pt'>
 <tr class=xl27 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl28 width=367 style='height:19.5pt;width:275pt'><%= l_cmp_name%></td>
  <td class=xl25 width=54 style='width:41pt'></td>
  <td class=xl29 width=61 style='width:46pt'></td>
  <td class=xl30 width=138 style='width:104pt'></td>
  <td colspan="2" class=xl32 width=138 style='width:104pt'>M&#7851;u s&#7889;: B03 - DN</td>
  <td class=xl33 width=11 style='width:8pt'></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl34 style='height:15.75pt'>&#272;&#7883;a ch&#7881;:<%= l_cmp_add %></td>
  <td colspan=5 class=xl65>Issued with Decision No. 15/2006/QĐ-BTC(Ban hành theo Quyết định số 15/2006/QĐ-BTC)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td colspan=5 class=xl65>dated March 20, 2006 by Ministry of Finance(Ngày 20 tháng 03 năm 2006 của Bộ trường Bộ Tài chính)</td>
  <td class=xl36></td>
 </tr>
 <tr class=xl27 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=6 height=26 class=xl66 style='height:19.5pt'>INCOME STATEMENT / BÁO CÁO KẾT QUẢ HOẠT ĐỘNG KINH DOANH</td>
  <td class=xl26></td>
 </tr>
 <tr class=xl27 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td class=xl26></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=6 height=21 class=xl35 style='height:15.75pt'>End the of year <%=curr_date %>(Kết thúc năm <%=curr_date %>)</td>
  <td class=xl26></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl38 style='height:15.75pt'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td colspan="2" class=xl37>(&#272;&#417;n v&#7883; tính: <%=l_Scale1%>  <%=l_ccy%>)</td>
  <td class=xl26></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl39 style='height:15.75pt'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td rowspan=2 height=42 class=xl68 style='border-bottom:.5pt solid black;
  height:31.5pt'>Items</td>
  <td rowspan=2 height=42 class=xl68 style='border-bottom:.5pt solid black;
  height:31.5pt'>항목</td>
  <td rowspan=2 class=xl68 style='border-bottom:.5pt solid black'>Code</td>
  <td class=xl41 width=61 style='width:46pt'>Notes/thuyết minh</td>
  <td colspan=2 class=xl70 style='border-right:.5pt solid black;border-left:
  none' ><span style='mso-spacerun:yes'> </span>This Year/Năm này<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl26></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl42 style='height:15.75pt'></td>
  <td class=xl43><span
  style='mso-spacerun:yes'> </span>Year/Năm <%=curr_date%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl44 width=138 style='width:104pt'><span
  style='mso-spacerun:yes'> </span>Year/Năm <%=last_Date %><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl45></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl46 style='height:15.75pt' x:num>1</td>
  <td height=21 class=xl46 style='height:15.75pt' x:num>2</td>
  <td class=xl47 x:num>3</td>
  <td class=xl48 width=61 style='width:46pt' x:num>4</td>
  <td class=xl48 width=138 style='width:104pt' x:num>5</td>
  <td class=xl48 width=138 style='width:104pt' x:num>6</td>
  <td class=xl45></td>
 </tr>
 <%
     string tag_begin = "";
     string tag_end = "";
     int i;
     decimal l_amt_08_1 = 0;
     decimal l_amt_08_2 = 0;
     decimal l_amt_20_1 = 0;
     decimal l_amt_20_2 = 0;
     decimal l_amt_30_1 = 0;
     decimal l_amt_30_2 = 0;
     decimal l_amt_40_1 = 0;
     decimal l_amt_40_2 = 0;
     decimal l_amt_50_1 = 0;
     decimal l_amt_50_2 = 0;
     decimal l_amt_60_1 = 0;
     decimal l_amt_60_2 = 0;

     decimal l_amt_61_1 = 0;
     decimal l_amt_61_2 = 0;
     decimal l_amt_70_1 = 0;
     decimal l_amt_70_2 = 0;
     decimal tmp_8 = 8;
     string tmp = "0";
     for (i = 0; i < dt.Rows.Count - 1; i++)
     {
         tag_begin = " ";
         tag_end = " ";
         if (dt.Rows[i][8].ToString() == "I")
         {
             tag_begin = "<i>";
             tag_end = "</i>";
         }
         if (dt.Rows[i][8].ToString() == "B")
         {
             tag_begin = "<b>";
             tag_end = "</b>";
         }
         string tmp11 = dt.Rows[i][6].ToString();
         string tmpi9 = dt.Rows[i][9].ToString();
         string tmpi10 = dt.Rows[i][10].ToString();
         if (!tmp11.Equals(""))
         {
             if (Convert.ToDecimal(tmp11) < 20)
             {
                 if (!tmpi9.Equals(""))
                 {
                     l_amt_08_1 = l_amt_08_1 + (Decimal)dt.Rows[i][9];
                 }
                 if (!tmpi10.Equals(""))
                 {
                     l_amt_08_2 = l_amt_08_2 + (Decimal)dt.Rows[i][10];
                 }
             }
             if (Convert.ToDecimal(tmp11) > 20 && Convert.ToDecimal(tmp11) < 30)
             {
                 if (!tmpi9.Equals(""))
                 {
                     l_amt_20_1 = l_amt_20_1 + (Decimal)dt.Rows[i][9];
                 }
                 if (!tmpi10.Equals(""))
                 {
                     l_amt_20_2 = l_amt_20_2 + (Decimal)dt.Rows[i][10];
                 }
             }
             if (Convert.ToDecimal(tmp11) > 30 && Convert.ToDecimal(tmp11) < 40)
             {
                 if (!tmpi9.Equals(""))
                 {
                     l_amt_30_1 = l_amt_30_1 + (Decimal)dt.Rows[i][9];
                 }

                 if (!tmpi10.Equals(""))
                 {
                     l_amt_30_2 = l_amt_30_2 + (Decimal)dt.Rows[i][10];
                 }
             }
             l_amt_50_1 = l_amt_08_1 + l_amt_20_1 + l_amt_30_1;
             l_amt_50_2 = l_amt_08_2 + l_amt_20_2 + l_amt_30_2;

             l_amt_70_1 = l_amt_50_1 + l_amt_60_1 + l_amt_61_1;
             l_amt_70_2 = l_amt_50_2 + l_amt_60_2 + l_amt_61_2;
         }
        if (i == 0)
        {  
 %>
 <tr class=xl49>
  <td class=xl74><%=tag_begin%><%= dt.Rows[i][0].ToString()%><%=tag_end%></td>
  <td class=xl74><%=tag_begin%><%= dt.Rows[i][2].ToString()%><%=tag_end%></td>
  <td class=xl75 x:str><%=tag_begin%><%=dt.Rows[i][7].ToString()%><%=tag_end%></td>
  <td class=xl75><%=tag_begin%><%=dt.Rows[i][6].ToString()%><%=tag_end%></td>
  <td class=xl76 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=tag_begin%><%=dt.Rows[i][9].ToString()%><%=tag_end%></td>
  <td class=xl76 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=tag_begin%><%=dt.Rows[i][10].ToString()%><%=tag_end%></td>
  <td class=xl33></td>
 </tr>
 <%}
   else
   {
 %>
 <tr class=xl49>
  <td class=xl50><%=tag_begin%><%= dt.Rows[i][0].ToString()%><%=tag_end%></td>
  <td class=xl50><%=tag_begin%><%= dt.Rows[i][2].ToString()%><%=tag_end%></td>
  <td class=xl51 x:str><%=tag_begin%><%=dt.Rows[i][7].ToString()%><%=tag_end%></td>
  <td class=xl51><%=tag_begin%><%=dt.Rows[i][6].ToString()%><%=tag_end%></td>
  <%
      switch (dt.Rows[i][7].ToString())
      {
          case "08":    
            
  %>
  <td class=xl52 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=tag_begin%><%=l_amt_08_1%><%=tag_end%></td>
  <td class=xl52 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=tag_begin%><%=l_amt_08_2%><%=tag_end%></td>
  <%      break;
      case "20":
  %>
   <td class=xl52 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=tag_begin%><%=l_amt_08_1%><%=tag_end%></td>
  <td class=xl52 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=tag_begin%><%=l_amt_08_2%><%=tag_end%></td>
  <%      break;
      case "30":
  %>
    <td class=xl52 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=tag_begin%><%=l_amt_20_1%><%=tag_end%></td>
  <td class=xl52 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=tag_begin%><%=l_amt_20_2%><%=tag_end%></td>
  <%      break;
      case "40":
  %>
  <td class=xl52 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=tag_begin%><%=l_amt_30_1%><%=tag_end%></td>
  <td class=xl52 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=tag_begin%><%=l_amt_30_2%><%=tag_end%></td>
   <%      break;
      case "50":
  %>
  <td class=xl52 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=tag_begin%><%=l_amt_50_1%><%=tag_end%></td>
  <td class=xl52 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=tag_begin%><%=l_amt_50_2%><%=tag_end%></td>
  <%      break;
      case "70":
  %>
  <td class=xl52 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=tag_begin%><%=l_amt_70_1%><%=tag_end%></td>
  <td class=xl52 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=tag_begin%><%=l_amt_70_2%><%=tag_end%></td>
  
  <% break;
          default:          
    %>
   <td class=xl52 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=tag_begin%><%=dt.Rows[i][9].ToString()%><%=tag_end%></td>
  <td class=xl52 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=tag_begin%><%=dt.Rows[i][10].ToString()%><%=tag_end%></td>
  <%
      break;
} %>
  <td class=xl33></td>
 </tr>
 <%
        } 
    }
  %>
 <tr class=xl49>
  <td class=xl56><%=tag_begin%><%= dt.Rows[i][0].ToString()%><%=tag_end%>)</td>
  <td class=xl56><%=tag_begin%><%= dt.Rows[i][2].ToString()%><%=tag_end%>)</td>
  <td class=xl57 x:num><%=tag_begin%><%=dt.Rows[i][7].ToString()%><%=tag_end%></td>
  <td class=xl57><%=tag_begin%><%=dt.Rows[i][6].ToString()%><%=tag_end%></td>
  <td class=xl58 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=tag_begin%><%=dt.Rows[i][9].ToString()%><%=tag_end%></td>
  <td class=xl58 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=tag_begin%><%=dt.Rows[i][10].ToString()%><%=tag_end%></td>
  <td class=xl33></td>
 </tr>
 <tr class=xl49 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl37 style='height:15.75pt'></td>
  <td colspan=2 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl59 x:num="0"><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl59 x:num="0"><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl60></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl38 style='height:15.75pt'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35>Date<span style='mso-spacerun:yes'> 
  </span><%=to_dt %></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl40 style='height:15.75pt'><span
  style='mso-spacerun:yes'></span><%=l_col1_1%><span
  style='mso-spacerun:yes'></span></td>
  <td colspan=2 class=xl39 style="text-align:center"><%=l_col2_1%><span style='mso-spacerun:yes'></span></td>
  <td colspan=3 class=xl72 ><span
  style='mso-spacerun:yes'>  </span><%=l_col3_1%><span
  style='mso-spacerun:yes'>  </span></td>
  <td class=xl61></td>
 </tr>
 <tr class=xl62 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl35 style='height:18.0pt'>Sign, Fullname</td>
  <td colspan=2 class=xl30 style="text-align:center;font-style:italic;">Sign, Fullname</td>
  <td colspan=3 class=xl73 ><span
  style='mso-spacerun:yes'> </span>Sign, Fullname, Stamp<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl63></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl38 style='height:15.75pt'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl38 style='height:15.75pt'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl38 style='height:15.75pt'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl38 style='height:15.75pt'></td>
  <td colspan=2 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl33></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl40 style='height:15.75pt'><%=name1%></td>
  <td colspan=2 class=xl50 style="text-align:center;border-left:none;border-right:none"><b><%=name2%></b></td>
  <td colspan=3 class=xl45><%=name3%></td>
  <td class=xl64><!-----------------------------><!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD--><!-----------------------------></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=367 style='width:275pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=11 style='width:8pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
