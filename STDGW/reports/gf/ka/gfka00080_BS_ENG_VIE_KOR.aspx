<%@ Page Language="C#"%>
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
    string l_status  = Request["p_status"];
    string l_company = Request["p_company_pk"];
    string l_date_f  = Request["p_date_f"];
    string l_date    = Request["p_date_t"];
    string l_kind    = Request["p_kind"];
    string l_crt_by  = Request["p_crt_by"];
    string l_scale   = Request["p_Scale"];
    string l_cmp_name = "";
    string l_cmp_add = "";
    string l_cmp_taxcode = "";
    int    i;

    string l_ccy = Request["p_ccy"];

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


    string fr_dt, to_dt,  to_dt_e, quater, curr_date, last_Date;
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
        ",to_char(to_date('" + l_date_f + "','yyyymmdd'),'dd/mm/yyyy') fr_dt,to_char(to_date('" + l_date + "','yyyymmdd'),'dd/mm/yyyy') to_dt" +
      ",to_char(to_date('" + l_date + "','yyyymmdd'),'dd-Mon-yyyy') sign_dt" +
      ",to_char(to_date('" + l_date + "','yyyymmdd'),'MM/yyyy') curr_date" +
      "  FROM TCO_COMPANY WHERE PK = '" + l_company + "' ";
    
    DataTable dt = ESysLib.TableReadOpen(SQL1);
    if (dt.Rows.Count > 0)
    {
        l_cmp_name = dt.Rows[0][0].ToString();
        l_cmp_add = dt.Rows[0][1].ToString();
        l_cmp_taxcode = dt.Rows[0][3].ToString();
        fr_dt = dt.Rows[0][4].ToString();
        to_dt = dt.Rows[0][5].ToString();
        to_dt_e = dt.Rows[0][6].ToString();
      
        
       
    }

    string SQL_TEMP = "ac_pro_60080240_trial_balance";
    
    string para = "'" + l_status + "','" + l_company + "','" + l_date_f + "','" + l_date + "','" + l_kind + "','" + l_crt_by + "'";
    
    int dt_Temp = ESysLib.TableReadOpenObject(SQL_TEMP, para);

    DataTable dt_detail;
    
    if (dt_Temp.ToString() == "1")
    {
       string l_parameter = "'" + l_company + "','" + l_date_f + "','" + l_date + "','" + l_status + "','" + l_scale + "'" ;
      string sp = "ac_sel_60080240_balance_sheet";
	  dt_detail = ESysLib.TableReadOpenCursor(sp,l_parameter); 
    }
    else
    {
        dt_detail = null;
    }
    
    
    
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List
href="Copy%20(2)%20of%20gfka00080_BS_ENG_KOR_files/filelist.xml">
<link rel=Edit-Time-Data
href="Copy%20(2)%20of%20gfka00080_BS_ENG_KOR_files/editdata.mso">
<link rel=OLE-Object-Data
href="Copy%20(2)%20of%20gfka00080_BS_ENG_KOR_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>GENU</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2008-09-16T06:20:47Z</o:LastPrinted>
  <o:Created>2008-09-16T06:17:58Z</o:Created>
  <o:LastSaved>2011-09-28T06:04:24Z</o:LastSaved>
  <o:Company>GENUWIN</o:Company>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P\ of &N";
	margin:.25in .25in .5in .25in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-horizontal-page-align:center;}
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
.style21
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
	mso-style-name:Normal_Bctc50;}
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
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl27
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;}
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
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mmm\/yyyy";
	text-align:left;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mmm\/yyyy";
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
	text-align:center;
	vertical-align:middle;
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
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-protection:unlocked visible;}
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
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-protection:unlocked visible;
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
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-protection:unlocked visible;
	white-space:normal;}
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
	border-bottom:.5pt solid windowtext;
	border-left:none;
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
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-protection:unlocked visible;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
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
	mso-protection:unlocked visible;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-protection:unlocked visible;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-protection:unlocked visible;}
.xl51
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	mso-protection:unlocked visible;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	mso-protection:unlocked visible;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl59
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl60
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl61
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl62
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-protection:unlocked visible;}
.xl64
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl65
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl66
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\0022Page \00220";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl67
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
	mso-protection:unlocked visible;}
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
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-protection:unlocked visible;}
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
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl70
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
	mso-protection:unlocked visible;
	white-space:normal;}
.xl71
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
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl72
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl73
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl74
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	mso-protection:unlocked visible;}
.xl75
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	mso-protection:unlocked visible;}
.xl76
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl77
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl78
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\\ \\ \\ ";
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl79
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl80
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl81
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl82
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\\ \\ \\ ";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl83
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;}
.xl84
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl88
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-protection:unlocked visible;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl89
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl90
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl91
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	mso-protection:unlocked visible;}
.xl92
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl93
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl94
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl95
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl96
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl97
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl98
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl99
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl100
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl101
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-protection:unlocked visible;}
.xl102
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl103
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl104
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl105
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl106
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl107
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl108
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl109
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl110
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl111
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl112
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl113
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mmm\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl114
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl115
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl116
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ \\ dd\\\,\\ \\ yyyy";
	text-align:center;
	vertical-align:middle;}
.xl117
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl118
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
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
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

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1521 style='border-collapse:
 collapse;table-layout:fixed;width:1143pt'>
 <col class=xl25 width=285 span=3 style='mso-width-source:userset;mso-width-alt:
 10422;width:214pt'>
 <col class=xl25 width=50 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col class=xl25 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl26 width=110 span=2 style='mso-width-source:userset;mso-width-alt:
 4022;width:83pt'>
 <col class=xl25 width=15 style='mso-width-source:userset;mso-width-alt:548;
 width:11pt'>
 <col class=xl25 width=64 span=5 style='width:48pt'>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl27 width=285 style='height:18.75pt;width:214pt'><%=l_cmp_name%></td>
  <td class=xl27 width=285 style='width:214pt'></td>
  <td class=xl27 width=285 style='width:214pt'></td>
  <td class=xl28 width=50 style='width:38pt'></td>
  <td colspan=3 class=xl111 width=281 style='width:212pt'>Form: B 01 - DN</td>
  <td class=xl25 width=15 style='width:11pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl29 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl30 style='height:15.0pt'>Address/địa chỉ/주소:<%=l_cmp_add %></td>
  <td class=xl30></td>
  <td colspan=5 class=xl112
  x:str="(Issued with Decision No. 15/2006/QĐ-BTC/Ban hành theo Quyết định số 15/2006/QĐ-BTC ngày ">(Issued
  with Decision No. 15/2006/QĐ-BTC/Ban hành theo Quyết định số 15/2006/QĐ-BTC
  ngày<span style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl32 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl112>dated March 20, 2006 by Ministry of Finance/20
  tháng 03 năm 2006 của Bộ trường Bộ Tài chính)</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.95pt'>
  <td height=13 colspan=3 class=xl32 style='height:9.95pt;mso-ignore:colspan'></td>
  <td class=xl33></td>
  <td class=xl34></td>
  <td class=xl35></td>
  <td class=xl36></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='height:19.5pt'>
  <td colspan=7 height=26 class=xl113 style='height:19.5pt'>BALANCE SHEET/BẢNG CÂN ĐỐI KẾ TOÁN/대차대조표</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=22 style='height:16.5pt'>
  <td colspan=7 height=22 class=xl114 style='height:16.5pt'>As at/tại ngày/현재 : <%=l_date.Substring(6, 2)%><%=l_date.Substring(4, 2)%><%=l_date.Substring(0, 4)%></td>
  <td colspan=6 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=4 class=xl37 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td class=xl35></td>
  <td class=xl36>(Unit/đơn vị/단위 : VN<span style='display:none'>D)</span></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=42 style='height:31.5pt'>
  <td height=42 class=xl38 style='height:31.5pt'>ASSETS</td>
  <td class=xl38>TÀI SẢN</td>
  <td class=xl38>자산</td>
  <td class=xl40 width=50 style='width:38pt'>Code<br>
    Mã số<br>
    코드</td>
  <td class=xl41 width=61 style='width:46pt'>header <br>
    Thuyết minh<br>
    비고</td>
  <td class=xl42 width=110 style='width:83pt'>Closing <br>
    số dư cuối kỳ<br>
    기말</td>
  <td class=xl43 width=110 style='width:83pt'>Openning<br>
    số đầu năm<br>
    기초</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=20 style='height:15.0pt'>
  <td height=20 class=xl44 style='height:15.0pt' x:num>1</td>
  <td class=xl45 x:num>1</td>
  <td class=xl45 x:num>1</td>
  <td class=xl45 x:num>2</td>
  <td class=xl46 width=61 style='width:46pt'>3</td>
  <td class=xl47 x:num>4</td>
  <td class=xl47 x:num>5</td>
  <td colspan=6 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <%
    
    if (dt_detail.Rows.Count >0)
	{
        string strBegin = "";
        string strEnd = "";
        
	    for(i = 0; i < 52; i++)
	    {
            
            strBegin = "";
            strEnd = "";
            if (dt_detail.Rows[i]["font_stype"].ToString() == "I")
            {
                strBegin = "<i>";
                strEnd = "</i>";
            }
            if (dt_detail.Rows[i]["font_stype"].ToString() == "B")
            {
                strBegin = "<b>";
                strEnd = "</b>";
            }
            
 %>
 <tr class=xl29 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl48 style='height:19.5pt'><%=strBegin%><%= dt_detail.Rows[i]["prn_acnm"].ToString() %><%=strEnd%>&nbsp;</td>
  <td class=xl48 style='border-left:none'><%=strBegin%><%= dt_detail.Rows[i]["prn_lacnm"].ToString() %><%=strEnd%>&nbsp;</td>
  <td class=xl48 style='border-left:none'><%=strBegin%><%= dt_detail.Rows[i]["prn_kacnm"].ToString() %><%=strEnd%>&nbsp;</td>
  <td class=xl49><%=strBegin%><%= dt_detail.Rows[i]["code"].ToString() %><%=strEnd%>&nbsp;</td>
  <td class=xl50><%=strBegin%><%= dt_detail.Rows[i]["header"].ToString() %><%=strEnd%>&nbsp;</td>
 
  <td class=xl51 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%=strBegin%><%= dt_detail.Rows[i]["closing"].ToString()%><%=strEnd%></td>
   <td class=xl51 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%=strBegin%><%= dt_detail.Rows[i]["openning"].ToString()%><%=strEnd%></td>
  <td class=xl52></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <%
        }
%>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl53 style='height:19.5pt'><%=strBegin%><%= dt_detail.Rows[i]["prn_acnm"].ToString() %><%=strEnd%>&nbsp;</td>
  <td class=xl53><%=strBegin%><%= dt_detail.Rows[i]["prn_lacnm"].ToString() %><%=strEnd%>&nbsp;</td>
  <td class=xl53><%=strBegin%><%= dt_detail.Rows[i]["prn_kacnm"].ToString() %><%=strEnd%>&nbsp;</td>
  <td class=xl54><%=strBegin%><%= dt_detail.Rows[i]["code"].ToString() %><%=strEnd%>&nbsp;</td>
  <td class=xl55><%=strBegin%><%= dt_detail.Rows[i]["header"].ToString() %><%=strEnd%>&nbsp;</td>
 <td class=xl56 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%=strBegin%><%= dt_detail.Rows[i]["closing"].ToString()%><%=strEnd%></td>
   <td class=xl56 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%=strBegin%><%= dt_detail.Rows[i]["openning"].ToString()%><%=strEnd%></td>
  <td class=xl57></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <%
 }
%>
 <tr class=xl29 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl58 style='height:19.5pt'></td>
  <td colspan=2 class=xl59 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl60 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl61 style='mso-ignore:colspan'></td>
  <td class=xl52></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl62 style='height:19.5pt'><u style='visibility:hidden;
  mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl63>&nbsp;</td>
  <td class=xl63>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl52></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=53 style='mso-height-source:userset;height:39.75pt'>
  <td height=53 class=xl38 style='height:39.75pt'>RESOURCES</td>
  <td class=xl39>NGUỒN VỐN</td>
  <td class=xl39>부채 및 자본</td>
  <td class=xl40 width=50 style='width:38pt'>Code<br>
    Mã số<br>
    코드</td>
  <td class=xl41 width=61 style='width:46pt'>Header <br>
    thuyết minh<br>
    비고</td>
  <td class=xl42 width=110 style='width:83pt'>Closing<br>
    Số dư cuối kỳ<br>
    기말</td>
  <td class=xl43 width=110 style='width:83pt'>Openning<br>
    số đầu năm<br>
    기초</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl67 style='height:15.75pt' x:num>1</td>
  <td class=xl68 style='border-top:none' x:num>1</td>
  <td class=xl68 style='border-top:none' x:num>1</td>
  <td class=xl69 width=50 style='width:38pt' x:num>2</td>
  <td class=xl70 width=61 style='width:46pt'>3</td>
  <td class=xl71 x:num>4</td>
  <td class=xl71 x:num>5</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <%
    
     if (dt_detail.Rows.Count > 0)
     {
         string strBegin = "";
         string strEnd = "";
         //dt_detail.Rows.Count - 1
         for (i = 53; i < 90; i++)
         {
             strBegin = "";
             strEnd = "";
             if (dt_detail.Rows[i]["font_stype"].ToString() == "I")
             {
                 strBegin = "<i>";
                 strEnd = "</i>";
             }
             if (dt_detail.Rows[i]["font_stype"].ToString() == "B")
             {
                 strBegin = "<b>";
                 strEnd = "</b>";
             }


            // string tmp = dt_detail.Rows[i][3].ToString();
           // if (!tmp.Equals(""))
            // {
             //  if (Convert.ToDecimal(tmp) < 500)
              // {
 %>
 <tr class=xl29 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl48 style='height:19.5pt'><%=strBegin%><%= dt_detail.Rows[i]["prn_acnm"].ToString()%><%=strEnd%>&nbsp;</td>
  <td class=xl48 style='border-left:none'><%=strBegin%><%= dt_detail.Rows[i]["prn_lacnm"].ToString()%><%=strEnd%>&nbsp;</td>
  <td class=xl48 style='border-left:none'><%=strBegin%><%= dt_detail.Rows[i]["prn_kacnm"].ToString()%><%=strEnd%>&nbsp;</td>
  <td class=xl49><%=strBegin%><%= dt_detail.Rows[i]["code"].ToString()%><%=strEnd%>&nbsp;</td>
  <td class=xl50><%=strBegin%><%= dt_detail.Rows[i]["header"].ToString()%><%=strEnd%>&nbsp;</td>
  <td class=xl51 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%=strBegin%><%= dt_detail.Rows[i]["closing"].ToString()%><%=strEnd%></td>
   <td class=xl51 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%=strBegin%><%= dt_detail.Rows[i]["openning"].ToString()%><%=strEnd%></td>
  <td colspan=6 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <%
     }
%>
 <tr class=xl29 height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl72 style='height:27.75pt'><%=strBegin%><%= dt_detail.Rows[i]["prn_acnm"].ToString()%><%=strEnd%>&nbsp;</td>
  <td class=xl73 style='border-left:none'><%=strBegin%><%= dt_detail.Rows[i]["prn_lacnm"].ToString()%><%=strEnd%>&nbsp;</td>
  <td class=xl73 style='border-left:none'><%=strBegin%><%= dt_detail.Rows[i]["prn_kacnm"].ToString()%><%=strEnd%>&nbsp;</td>
  <td class=xl74><%=strBegin%><%= dt_detail.Rows[i]["code"].ToString()%><%=strEnd%>&nbsp;</td>
  <td class=xl75><%=strBegin%><%= dt_detail.Rows[i]["header"].ToString()%><%=strEnd%>&nbsp;</td>
  <td class=xl76 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%=strBegin%><%= dt_detail.Rows[i]["closing"].ToString()%><%=strEnd%></td>
   <td class=xl76 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%=strBegin%><%= dt_detail.Rows[i]["openning"].ToString()%><%=strEnd%></td>
  <td class=xl52></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <%
     }
 //}
//}
%>
 <tr class=xl29 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=3 class=xl29 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl77></td>
  <td colspan=2 class=xl78 style='mso-ignore:colspan'></td>
  <td class=xl79></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td colspan=2 class=xl82 style='mso-ignore:colspan'></td>
  <td class=xl52></td>
 </tr>
 <tr class=xl29 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=6 height=24 class=xl115 style='height:18.0pt'>OFF BALANCE SHEET
  ITEMS/TÀI KHOẢN NGOÀI BẢNG/부외자산 항목</td>
  <td class=xl79></td>
  <td colspan=6 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=4 class=xl37 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td class=xl35></td>
  <td class=xl36></td>
  <td class=xl57></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=43 style='height:32.25pt'>
  <td height=43 class=xl83 style='height:32.25pt'>ITEMS</td>
  <td class=xl84>Khoản mục</td>
  <td class=xl84>항목</td>
  <td class=xl85>Code<br>
    mã sô<br>
    코드</td>
  <td class=xl86>Notes<br>
    thuyết minh<br>
    비고</td>
  <td class=xl87 width=110 style='width:83pt'>Closing<br>
    số dư cuối kỳ<br>
    기말</td>
  <td class=xl88 width=110 style='width:83pt'>Openning<br>
    số đầu năm<br>
    기초</td>
  <td class=xl57></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <%
 
 
    
     if (dt_detail.Rows.Count > 0)
     {
         string strBegin = "";
         string strEnd = "";
         //dt_detail.Rows.Count - 1
         for (i = 91; i < dt_detail.Rows.Count - 1; i++)
         {
             strBegin = "";
             strEnd = "";
             if (dt_detail.Rows[i]["font_stype"].ToString() == "I")
             {
                 strBegin = "<i>";
                 strEnd = "</i>";
             }
             if (dt_detail.Rows[i]["font_stype"].ToString() == "B")
             {
                 strBegin = "<b>";
                 strEnd = "</b>";
             }
      %>
 <tr class=xl29 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl48 style='height:19.5pt'><%=strBegin%><%= dt_detail.Rows[i]["prn_acnm"].ToString()%><%=strEnd%>&nbsp;</td>
  <td class=xl48 style='border-left:none'><%=strBegin%><%= dt_detail.Rows[i]["prn_lacnm"].ToString()%><%=strEnd%>&nbsp;</td>
  <td class=xl48 style='border-left:none'><%=strBegin%><%= dt_detail.Rows[i]["prn_kacnm"].ToString()%><%=strEnd%>&nbsp;</td>
  <td class=xl49><%=strBegin%><%= dt_detail.Rows[i]["code"].ToString()%><%=strEnd%>&nbsp;</td>
  <td class=xl50><%=strBegin%><%= dt_detail.Rows[i]["header"].ToString()%><%=strEnd%>&nbsp;</td>
 <td class=xl76 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%=strBegin%><%= dt_detail.Rows[i]["closing"].ToString()%><%=strEnd%></td>
   <td class=xl76 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%=strBegin%><%= dt_detail.Rows[i]["openning"].ToString()%><%=strEnd%></td>
  <td colspan=6 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <%
     }

  %>
 <tr class=xl29 height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl89 style='height:27.75pt;border-top:none'><%=strBegin%><%= dt_detail.Rows[i]["prn_acnm"].ToString()%><%=strEnd%>&nbsp;</td>
  <td class=xl90 style='border-left:none'><%=strBegin%><%= dt_detail.Rows[i]["prn_lacnm"].ToString()%><%=strEnd%>&nbsp;</td>
  <td class=xl90 style='border-left:none'><%=strBegin%><%= dt_detail.Rows[i]["prn_kacnm"].ToString()%><%=strEnd%>&nbsp;</td>
  <td class=xl91><%=strBegin%><%= dt_detail.Rows[i]["code"].ToString()%><%=strEnd%>&nbsp;</td>
  <td class=xl75><%=strBegin%><%= dt_detail.Rows[i]["header"].ToString()%><%=strEnd%>&nbsp;</td>
  <td class=xl76 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%=strBegin%><%= dt_detail.Rows[i]["closing"].ToString()%><%=strEnd%></td>
   <td class=xl76 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%=strBegin%><%= dt_detail.Rows[i]["openning"].ToString()%><%=strEnd%></td>
  <td class=xl52></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <%
    
 }
  %>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=3 class=xl25 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl92></td>
  <td colspan=2 class=xl93 style='mso-ignore:colspan'></td>
  <td class=xl94></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=3 class=xl37 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=3 class=xl116>dated/tại ngày/현재<span style='mso-spacerun:yes'>  </span>//<%=l_date.Substring(6, 2)%><%=l_date.Substring(4, 2)%><%=l_date.Substring(0, 4)%></td>
  <td class=xl57></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl95 style='height:18.0pt'>Repairer by/ Người lập biểu</td>
  <td class=xl95>Chief Accountant/Kế Toán Trưởng</td>
  <td class=xl95>Chief Accountant/Kế Toán Trưởng</td>
  <td class=xl96></td>
  <td colspan=3 class=xl95 x:str="General Director/ Tổng Giám Đốc ">General
  Director/ Tổng Giám Đốc<span style='mso-spacerun:yes'> </span></td>
  <td class=xl97></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 class=xl98 style='height:15.75pt'>(Sign, Fullname/(Ký, họ tên)</td>
  <td class=xl98>(Sign, Fullname)/(Ký, họ tên)</td>
  <td class=xl98>(Sign, Fullname)/(Ký, họ tên)</td>
  <td colspan=4 class=xl117
  x:str="(Sign, Fullname, Stamp)/(Ký, họ tên, đóng dấu)"><span
  style='mso-spacerun:yes'> </span>(Sign, Fullname, Stamp)/(Ký, họ tên, đóng
  dấu)<span style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl37 style='height:15.75pt'></td>
  <td colspan=4 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl99 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl37 style='height:15.75pt'></td>
  <td colspan=4 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl99 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl37 style='height:15.75pt'></td>
  <td colspan=4 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl99 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl37 style='height:18.0pt'></td>
  <td colspan=4 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl99 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl100 style='height:15.75pt'>NGUYEN VAN</td>
  <td class=xl100>NGUYỄN VĂN A</td>
  <td class=xl100>NGUYỄN VĂN A</td>
  <td class=xl100></td>
  <td colspan=3 class=xl118 x:str="LAM VAN"><span
  style='mso-spacerun:yes'> </span>LAM VAN<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl97></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl101 style='height:15.75pt'>&nbsp;</td>
  <td class=xl101>&nbsp;</td>
  <td class=xl101>&nbsp;</td>
  <td class=xl101>&nbsp;</td>
  <td class=xl101>&nbsp;</td>
  <td class=xl102>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl103 style='height:15.75pt'></td>
  <td colspan=2 class=xl104 style='mso-ignore:colspan'></td>
  <td class=xl105></td>
  <td class=xl106></td>
  <td class=xl107></td>
  <td class=xl26></td>
  <td class=xl108></td>
  <td colspan=2 class=xl109 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl110 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl103 style='height:15.75pt'></td>
  <td colspan=2 class=xl104 style='mso-ignore:colspan'></td>
  <td class=xl105></td>
  <td class=xl106></td>
  <td class=xl107></td>
  <td class=xl26></td>
  <td class=xl108></td>
  <td colspan=2 class=xl109 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl110 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl103 style='height:15.75pt'></td>
  <td colspan=2 class=xl104 style='mso-ignore:colspan'></td>
  <td class=xl105></td>
  <td class=xl106></td>
  <td class=xl107></td>
  <td class=xl26></td>
  <td class=xl108></td>
  <td colspan=2 class=xl109 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl110 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl103 style='height:18.0pt'></td>
  <td colspan=2 class=xl104 style='mso-ignore:colspan'></td>
  <td class=xl105></td>
  <td class=xl106></td>
  <td class=xl107></td>
  <td class=xl26></td>
  <td class=xl108></td>
  <td colspan=2 class=xl109 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl110 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=285 style='width:214pt'></td>
  <td width=285 style='width:214pt'></td>
  <td width=285 style='width:214pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=15 style='width:11pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
