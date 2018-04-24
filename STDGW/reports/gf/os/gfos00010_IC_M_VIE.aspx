<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
%>

<% 
   ESysLib.SetUser("acnt");
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

  if (l_ccy == "VND")
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
  string SQL1 = " SELECT PARTNER_LNAME, ADDR1, ADDR2, TAX_CODE " +
      ",to_char(to_date('" + l_date_fr + "','yyyymmdd'),'dd/mm/yyyy') fr_dt,to_char(to_date('" + l_date_to + "','yyyymmdd'),'dd/mm/yyyy') to_dt" +
      ",to_char(to_date('" + l_date_to + "','yyyymmdd'),'dd-Mon-yyyy') sign_dt" +
      ",decode('" + l_quarter + "','1','I','2','II','3','III','IV')" +
     ",to_char(to_date('" + l_date_to + "','yyyymmdd'),'MM/yyyy') curr_date" +
      ",TO_CHAR (ADD_MONTHS (TO_DATE ('" + l_date_to + "', 'yyyymmdd'), -12), 'MM/yyyy') last_yyyy" +
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
  string sp = "sp_sel_gfos00010_1";
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
<link rel=File-List href="gfka00080_IC_PERIOD_VIE_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00080_IC_PERIOD_VIE_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00080_IC_PERIOD_VIE_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Thu Hien</o:LastAuthor>
  <o:LastPrinted>2008-12-25T08:36:42Z</o:LastPrinted>
  <o:LastSaved>2008-12-25T08:37:07Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .5in .25in .25in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-horizontal-page-align:center;}
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
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl40
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
.xl41
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
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	color:blue;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl55
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl58
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
.xl59
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
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl61
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
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl63
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
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>gfka00080_IC_PERIOD_VIE_Monthly</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>70</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>
<!--The following information was generated by Microsoft Office Excel's Publish
as Web Page wizard.--><!--If the same item is republished from Excel, all information between the DIV
tags will be replaced.--><!-----------------------------><!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD --><!----------------------------->

<table x:str border=0 cellpadding=0 cellspacing=0 width=956 style='border-collapse:
 collapse;table-layout:fixed;width:719pt'>
 <col class=xl24 width=405 style='mso-width-source:userset;mso-width-alt:14811;
 width:304pt'>
 <col class=xl25 width=58 style='mso-width-source:userset;mso-width-alt:2121;
 width:44pt'>
 <col class=xl25 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl26 width=135 style='mso-width-source:userset;mso-width-alt:4937;
 width:101pt'>
 <col class=xl26 width=138 span=2 style='mso-width-source:userset;mso-width-alt:
 5046;width:104pt'>
 <col class=xl24 width=14 style='mso-width-source:userset;mso-width-alt:512;
 width:11pt'>
 <tr class=xl27 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl28 width=405 style='height:18.75pt;width:304pt'><%= l_cmp_name%></td>
  <td class=xl25 width=58 style='width:44pt'></td>
  <td class=xl25 width=68 style='width:51pt'></td>
  <td colspan=3 class=xl55 width=411 style='width:309pt'>Mẫu số B02 - CTCK</td>
  <td class=xl24 width=14 style='width:11pt'></td>
 </tr>
 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl30 style='height:15.0pt'>Địa chỉ:<%= l_cmp_add %></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl56 >(Ban hành theo T.Tư số 95/2008/TT-BTC</td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl31></td>
  <td class=xl25></td>
  <td colspan=3 class=xl56>ngày 24 tháng 10 năm 2008  của Bộ Tài chính )</td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=13 style='mso-height-source:userset;height:9.95pt'>
  <td height=13 class=xl24 style='height:9.95pt'></td>
  <td colspan=5 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=6 height=26 class=xl57 style='height:19.5pt'>BÁO CÁO KẾT QUẢ HOẠT
  ĐỘNG KINH DOANH</td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=6 height=21 class=xl32 style='height:15.75pt'>Cho giai đọan từ ngày <%=fr_dt %> đến ngày <%=to_dt %><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl33 style='height:15.75pt'></td>
  <td colspan=3 class=xl34 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl36>(Đơn vị tính: <%=l_ccy%>)</td>
  <td class=xl24></td>
 </tr>
 <tr class=xl29 height=22 style='mso-height-source:userset;height:16.9pt'>
  <td rowspan=2 height=44 class=xl58 style='border-bottom:.5pt solid black;
  height:33.8pt'>Chỉ tiêu</td>
  <td rowspan=2 class=xl58 style='border-bottom:.5pt solid black'>Mă số</td>
  <td class=xl40 width=68 style='width:51pt'>Thuyết</td>
  <td rowspan=2 class=xl60 style='border-bottom:.5pt solid black'
  x:str="Tháng này"><span style='mso-spacerun:yes'> </span>Tháng này<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl60 style='border-bottom:.5pt solid black'
  x:str="Năm trước"><span style='mso-spacerun:yes'> </span>Năm trước<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl62 width=138 style='border-bottom:.5pt solid black;
  width:104pt' x:str="Lũy kế đầu năm &#10;đến tháng này"><span
  style='mso-spacerun:yes'> </span>Lũy kế đầu năm <br>
    đến tháng này<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl64>&nbsp;</td>
 </tr>
 <tr class=xl29 height=22 style='mso-height-source:userset;height:16.9pt'>
  <td height=22 class=xl41 width=68 style='height:16.9pt;width:51pt'>minh</td>
 </tr>
 <%
    string tag_begin="";
    string tag_end="";
    int i;
    for(i=0;i<dt.Rows.Count-1;i++)
    {
        tag_begin=" ";
        tag_end=" ";
        if (dt.Rows[i][8].ToString()=="I")
        {
            tag_begin="<i>";
            tag_end="</i>";
        }
        if (dt.Rows[i][8].ToString()=="B")
        {
            tag_begin="<b>";
            tag_end="</b>";
        }
        if (i == 0)
        {  
 %>
 <tr height=21 style='height:15.75pt'>
  <td class=xl43><%=tag_begin%><%= dt.Rows[i][1].ToString()%><%=tag_end%></td>
  <td class=xl44 x:num><%=tag_begin%><%=dt.Rows[i][6].ToString()%><%=tag_end%></td>
  <td class=xl45><%=tag_begin%><%=dt.Rows[i][7].ToString()%><%=tag_end%></td>
  <td class=xl46 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=tag_begin%><%=dt.Rows[i][9].ToString()%><%=tag_end%></td>
  <td class=xl46 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=tag_begin%><%=dt.Rows[i][10].ToString()%><%=tag_end%></td>
  <td class=xl46 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt.Rows[i][11].ToString()%></td>
  <td class=xl38></td>
 </tr>
 <%}
   else
   {
 %>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl43 width=405 style='height:15.75pt;width:304pt'><%=tag_begin%><%= dt.Rows[i][1].ToString()%><%=tag_end%></td>
  <td class=xl44 x:num><%=tag_begin%><%=dt.Rows[i][6].ToString()%><%=tag_end%></td>
  <td class=xl45><%=tag_begin%><%=dt.Rows[i][7].ToString()%><%=tag_end%></td>
  <td class=xl47 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=tag_begin%><%=dt.Rows[i][9].ToString()%><%=tag_end%></td>
  <td class=xl47 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=tag_begin%><%=dt.Rows[i][10].ToString()%><%=tag_end%></td>
  <td class=xl47 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt.Rows[i][11].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <%
        } 
    }
  %>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl48 width=405 style='height:16.5pt;width:304pt'><%=tag_begin%><%= dt.Rows[i][1].ToString()%><%=tag_end%></td>
  <td class=xl49 x:num><%=tag_begin%><%=dt.Rows[i][6].ToString()%><%=tag_end%></td>
  <td class=xl49><%=tag_begin%><%=dt.Rows[i][7].ToString()%><%=tag_end%></td>
  <td class=xl50 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=tag_begin%><%=dt.Rows[i][9].ToString()%><%=tag_end%></td>
  <td class=xl50 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=tag_begin%><%=dt.Rows[i][10].ToString()%><%=tag_end%></td>
  <td class=xl50 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=tag_begin%><%=dt.Rows[i][11].ToString()%><%=tag_end%></td>
  <td class=xl29></td>
 </tr>
 <tr class=xl27 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl42 style='height:19.5pt'></td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl42 style='height:15.75pt'></td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=2 class=xl32>Ngày<span
  style='mso-spacerun:yes'> </span><%=to_dt %></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl39><%=l_col1_3%> </td>
  <td colspan=3 class=xl65><%=l_col2_3%></td>
  <td colspan=2 class=xl66 ><%=l_col3_3%></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl32 style='height:15.75pt'>(Ký, họ tên)</td>
  <td colspan=2 class=xl32>(Ký họ tên)</td>
  <td class=xl26></td>
  <td colspan=2 class=xl67 x:str="(Ký, họ tên, đóng dấu)"><span
  style='mso-spacerun:yes'> </span>(Ký, họ tên, đóng dấu)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl42 style='height:15.75pt'></td>
  <td class=xl51></td>
  <td class=xl34></td>
  <td class=xl26></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl42 style='height:15.75pt'></td>
  <td class=xl51></td>
  <td class=xl34></td>
  <td class=xl26></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl42 style='height:15.75pt'></td>
  <td class=xl51></td>
  <td class=xl34></td>
  <td class=xl26></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl42 style='height:15.75pt'></td>
  <td class=xl51></td>
  <td class=xl34></td>
  <td class=xl26></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl52 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl53 style='height:15.75pt'><%=name1%></td>
  <td colspan=2 class=xl53><%=name2%></td>
  <td class=xl52></td>
  <td colspan=2 class=xl68 ><%=name3%></td>
  <td class=xl52></td>
 </tr>
 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl37 style='height:15.0pt'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl54 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl37 style='height:15.0pt'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl54 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl37 style='height:15.0pt'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl54 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl37 style='height:15.0pt'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl54 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl37 style='height:15.0pt'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl54 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl37 style='height:15.0pt'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl54 style='mso-ignore:colspan'></td>
  <td class=xl24><!-----------------------------><!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD--><!-----------------------------></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=405 style='width:304pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=135 style='width:101pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=14 style='width:11pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>

