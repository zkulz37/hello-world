<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
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
     ",to_char(to_date('" + l_date_to + "','yyyymmdd'),'MM/yyyy') curr_date" +
      ",TO_CHAR (ADD_MONTHS (TO_DATE ('" + l_date_to + "', 'yyyymmdd'), -12), 'MM/yyyy') last_yyyy" +
    " FROM TCO_COMPANY WHERE PK = '" + l_tco_company_pk + "' ";
  //  Response.Write(SQL1);
  //  Response.End();
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
<link rel=File-List href="gfka00080_IC_M_VIE_KOR_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00080_IC_M_VIE_KOR_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00080_IC_M_VIE_KOR_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>SVPOSLILAMA</o:LastAuthor>
  <o:LastPrinted>2008-12-25T09:37:58Z</o:LastPrinted>
  <o:LastSaved>2011-12-02T07:10:35Z</o:LastSaved>
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\0022For the year ended\0022\\ dd\\ mmmm\\ yyyy";
	text-align:left;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl37
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
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl39
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
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl40
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
	border-left:none;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
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
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl46
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
.xl47
	{mso-style-parent:style0;
	color:green;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	color:green;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	color:green;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style0;
	color:blue;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\\ \\ \\ ";
	vertical-align:middle;}
.xl56
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl59
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl61
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl62
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ \\ dd\\\,\\ \\ yyyy";
	text-align:center;
	vertical-align:middle;}
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
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl67
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
    <x:Name>gfka00080_IC_PERIOD_ENG_Monthly</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
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
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
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
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1025"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>
<!--The following information was generated by Microsoft Office Excel's Publish
as Web Page wizard.--><!--If the same item is republished from Excel, all information between the DIV
tags will be replaced.--><!-----------------------------><!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD --><!----------------------------->

<table x:str border=0 cellpadding=0 cellspacing=0 width=1327 style='border-collapse:
 collapse;table-layout:fixed;width:998pt'>
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
 <tr class=xl28 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl29 width=390 style='height:18.75pt;width:293pt'><%= l_cmp_name%></td>
  <td class=xl29 width=390 style='width:293pt'></td>
  <td class=xl25 width=62 style='width:47pt'></td>
  <td class=xl25 width=71 style='width:53pt'></td>
  <td colspan=3 class=xl60 width=414 style='width:312pt'>Form/M&#7851;u
  s&#7889;: B 02 - DN</td>
 </tr>
 <tr class=xl28 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt'>Adress/&#272;&#7883;a
  ch&#7881;/&#51452;&#49548;:<%= l_cmp_add %></td>
  <td colspan=6 class=xl61></td>
 </tr>
 <tr class=xl28 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl32 style='height:15.0pt'></td>
  <td colspan=6 class=xl61></td>
 </tr>
 <tr class=xl28 height=13 style='mso-height-source:userset;height:9.95pt'>
  <td height=13 colspan=2 class=xl24 style='height:9.95pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl33></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=7 height=26 class=xl62 style='height:19.5pt'>INCOME STATEMENT/B�O
  C�O K&#7870;T QU&#7842; HO&#7840;T &#272;&#7896;NG KINH
  DOANH/&#49552;&#51061;&#44228;&#49328;&#49436;</td>
 </tr>
 <tr class=xl28 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=7 height=21 class=xl34 style='height:15.75pt'>Form/Cho giai
  &#273;&#7885;an t&#7915; ng�y /&#48512;&#53552; to/&#273;&#7871;n
  ng�y/&#44620;&#51648;<%=fr_dt %><%=to_dt %></td>
 </tr>
 <tr class=xl28 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=2 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=2 class=xl63>(Unit/&#272;&#417;n v&#7883; t�nh/&#45800;&#50948;:
  )<%=l_Scale1%><%=l_ccy%></td>
 </tr>
 <tr class=xl30 height=84 style='height:63.0pt'>
  <td height=84 class=xl36 width=390 style='height:63.0pt;width:293pt'>Items</td>
  <td class=xl37 width=390 style='width:293pt'>&#54637;&#47785;</td>
  <td class=xl37 width=62 style='width:47pt'>Code<br>
    M&#259; s&#7889;<br>
    &#53076;&#46300;</td>
  <td class=xl37 width=71 style='width:53pt'>Notes<br>
    Thuy&#7871;t <br>
    minh<br>
    &#48708;&#44256;</td>
  <td class=xl39 width=138 style='width:104pt' x:str="This month&#10;Th�ng n�y&#10;&#51060;&#48264; &#45804;"><span
  style='mso-spacerun:yes'>�</span>This month<br>
    Th�ng n�y<br>
    &#51060;&#48264; &#45804;<span style='mso-spacerun:yes'>�</span></td>
  <td class=xl40 width=138 style='width:104pt' x:str="Last Year&#10;N&#259;m tr&#432;&#7899;c&#10;&#51089;&#45380;&#50640;"><span
  style='mso-spacerun:yes'>�</span>Last Year<br>
    N&#259;m tr&#432;&#7899;c<br>
    &#51089;&#45380;&#50640;<span style='mso-spacerun:yes'>�</span></td>
  <td class=xl40 width=138 style='width:104pt'
  x:str="Accum. Year&#10;L&#361;y k&#7871; &#273;&#7847;u n&#259;m &#10;&#273;&#7871;n th�ng n�y&#10;&#52629;&#51201; &#45380;"><span
  style='mso-spacerun:yes'>�</span>Accum. Year<br>
    L&#361;y k&#7871; &#273;&#7847;u n&#259;m <br>
    &#273;&#7871;n th�ng n�y<br>
    &#52629;&#51201; &#45380;<span style='mso-spacerun:yes'>�</span></td>
 </tr>
 <tr class=xl30 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl41 width=390 style='height:15.75pt;width:293pt' x:num>1</td>
  <td class=xl42 width=390 style='width:293pt'>&nbsp;</td>
  <td class=xl42 width=62 style='width:47pt' x:num>2</td>
  <td class=xl42 width=71 style='width:53pt' x:num>3</td>
  <td class=xl43 x:num>4</td>
  <td class=xl43 x:num>5</td>
  <td class=xl44 x:num>6</td>
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
  <td height=21 class=xl45 style='height:15.75pt'><%=tag_begin%><%= dt.Rows[i]["prn_lacnm"].ToString()%><%=tag_end%>;</td>
  <td class=xl45 style='border-left:none'><%=tag_begin%><%=dt.Rows[i]["prn_kacnm"].ToString()%><%=tag_end%></td>
  <td class=xl46><%=tag_begin%><%=dt.Rows[i][6].ToString()%><%=tag_end%></td>
  <td class=xl46><%=tag_begin%><%=dt.Rows[i][7].ToString()%><%=tag_end%></td>
  <td class=xl47 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=tag_begin%><%=dt.Rows[i][9].ToString()%><%=tag_end%></td>
  <td class=xl47 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=tag_begin%><%=dt.Rows[i][10].ToString()%><%=tag_end%></td>
  <td class=xl48 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=tag_begin%><%=dt.Rows[i][11].ToString()%><%=tag_end%></td>
 </tr>
 <%
     }
     else
     {
 %>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl45 style='height:15.75pt'><%=tag_begin%><%= dt.Rows[i]["prn_lacnm"].ToString()%><%=tag_end%></td>
  <td class=xl45 style='border-left:none'><%=tag_begin%><%=dt.Rows[i]["prn_kacnm"].ToString()%><%=tag_end%></td>
  <td class=xl46><%=tag_begin%><%=dt.Rows[i][6].ToString()%><%=tag_end%></td>
  <td class=xl46><%=tag_begin%><%=dt.Rows[i][7].ToString()%><%=tag_end%></td>
  <td class=xl47 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=tag_begin%><%=dt.Rows[i][9].ToString()%><%=tag_end%></td>
  <td class=xl47 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=tag_begin%><%=dt.Rows[i][10].ToString()%><%=tag_end%></td>
  <td class=xl49 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=tag_begin%><%=dt.Rows[i][11].ToString()%><%=tag_end%></td>
 </tr>
 <%
     }
 }
         %>
 <tr class=xl30 height=22 style='height:16.5pt'>
  <td height=22 class=xl50 style='height:16.5pt'><%=tag_begin%><%=dt.Rows[i]["prn_lacnm"].ToString()%><%=tag_end%></td>
  <td class=xl50 style='border-left:none'><%=tag_begin%><%=dt.Rows[i]["prn_kacnm"].ToString()%><%=tag_end%></td>
  <td class=xl51><%=tag_begin%><%=dt.Rows[i][6].ToString()%><%=tag_end%></td>
  <td class=xl51><%=tag_begin%><%=dt.Rows[i][7].ToString()%><%=tag_end%></td>
  <td class=xl52 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=tag_begin%><%=dt.Rows[i][9].ToString()%><%=tag_end%></td>
  <td class=xl53 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=tag_begin%><%=dt.Rows[i][10].ToString()%><%=tag_end%></td>
  <td class=xl54 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=tag_begin%><%=dt.Rows[i][11].ToString()%><%=tag_end%></td>
  <td class=xl35></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=2 class=xl24 style='height:19.5pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl55 align=right x:num="0"><span style='mso-spacerun:yes'>��
  </span></td>
  <td class=xl55 align=right x:num="0"><span style='mso-spacerun:yes'>��
  </span></td>
  <td class=xl26></td>
 </tr>
 <tr class=xl28 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=2 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=2 class=xl64 x:str="At dated ">At dated<span
  style='mso-spacerun:yes'>�</span><%=to_dt_e %></td>
 </tr>
 <tr class=xl28 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl38 style='height:15.75pt'><%=l_col1_1%></td>
  <td class=xl38></td>
  <td colspan=3 class=xl65><%=l_col2_1%></td>
  <td colspan=2 class=xl38><%=l_col3_1%></td>
 </tr>
 <tr class=xl28 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl34 style='height:15.75pt'>(Sign, Fullname)</td>
  <td class=xl34></td>
  <td colspan=2 class=xl34>(Sign, Fullname)</td>
  <td class=xl26></td>
  <td colspan=2 class=xl66 x:str="(Sign, Fullname, Stamp)"><span
  style='mso-spacerun:yes'>�</span>(Sign, Fullname, Stamp)<span
  style='mso-spacerun:yes'>�</span></td>
 </tr>
 <tr class=xl28 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=2 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=2 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=2 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=2 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl56 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl57 style='height:15.75pt'><%=name1%></td>
  <td class=xl57></td>
  <td colspan=2 class=xl57><%=name2%></td>
  <td class=xl56></td>
  <td colspan=2 class=xl67><%=name3%></td>
 </tr>
 <tr class=xl28 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=2 class=xl38 style='height:15.95pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl58 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=2 class=xl38 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl58 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=2 class=xl38 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl58 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=2 class=xl38 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl58 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=2 class=xl38 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl58 style='mso-ignore:colspan'></td>
  <td class=xl59></td>
 </tr>
 <tr class=xl28 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=2 class=xl38 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl58 style='mso-ignore:colspan'></td>
  <td class=xl59></td>
 </tr>
 <tr class=xl28 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=2 class=xl38 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl58 style='mso-ignore:colspan'></td>
  <td class=xl27><!-----------------------------><!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD--><!-----------------------------></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=390 style='width:293pt'></td>
  <td width=390 style='width:293pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
