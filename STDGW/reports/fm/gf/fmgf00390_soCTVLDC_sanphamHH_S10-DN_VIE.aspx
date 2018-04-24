<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
    string SQL = "";
    string ls_compk = Request["company_pk"];
    string ls_item_pk = Request["item_pk"]; // item
    string ls_acc_pk = Request["acc_pk"]; // account code
    string ls_wh_pk = Request["wh_pk"]; // whouse
    string ls_from_dt = Request["from_date"]; // from date
    string ls_to_dt = Request["to_date"]; // to date
    SQL
        = "select partner_name, addr1 || nvl(addr2, '' ) || nvl(addr3, '') addr, tax_code " +
            "from comm.tco_company where pk = '" + ls_compk + "'";
    DataTable dtComp = ESysLib.TableReadOpen(SQL);
    string p_comp_nm = "", p_addr = "", p_tax_cd = "";
    if (dtComp.Rows.Count > 0)
    {
        p_comp_nm = dtComp.Rows[0][0].ToString();
        p_addr = dtComp.Rows[0][1].ToString();
        p_tax_cd = dtComp.Rows[0][2].ToString();
    }
    SQL = "select ac_cd, ac_nm from tac_abacctcode where pk like '" + ls_acc_pk + "' ";
    DataTable dtAcc = ESysLib.TableReadOpen(SQL);
    string p_ac_cd = "", p_ac_nm = "";
    if (dtAcc.Rows.Count > 0)
    {
        p_ac_cd = dtAcc.Rows[0][0].ToString();
        p_ac_nm = dtAcc.Rows[0][1].ToString();
    }
    SQL = "select item_code, item_name from comm.tco_item where pk like '" + ls_item_pk + "' ";
    DataTable dtItem = ESysLib.TableReadOpen(SQL);
    string p_item_cd = "", p_item_nm = "";
    if (dtItem.Rows.Count > 0)
    {
        p_item_cd = dtItem.Rows[0][0].ToString();
        p_item_nm = dtItem.Rows[0][1].ToString();
    }
    SQL = "select wh_id || ' - ' || wh_name from inv.tin_warehouse where pk like '" + ls_wh_pk + "' ";
    DataTable dtWH = ESysLib.TableReadOpen(SQL);
    string p_wh_name = "";
    if (dtWH.Rows.Count > 0)
    {
        p_wh_name = dtWH.Rows[0][0].ToString();
    }
    SQL
       = "select d.code " +
           "from tac_commcode_master a, tac_commcode_detail d " +
           "where a.id = 'ACBG0040' " +
           "and a.del_if = 0 " +
           "and a.pk = d.tac_commcode_master_pk " +
           "and d.del_if = 0 " +
           "and d.def_yn = 'Y'  ";
    DataTable dtBookCcy = ESysLib.TableReadOpen(SQL);
    string p_book_ccy = "";
    if (dtBookCcy.Rows.Count > 0)
    {
        p_book_ccy = dtBookCcy.Rows[0][0].ToString();
    }       
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List
href="fmgf00390_soCTVLDC_sanphamHH_S10-DN_files/filelist.xml">
<link rel=Edit-Time-Data
href="fmgf00390_soCTVLDC_sanphamHH_S10-DN_files/editdata.mso">
<link rel=OLE-Object-Data
href="fmgf00390_soCTVLDC_sanphamHH_S10-DN_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>tam</o:Author>
  <o:LastAuthor>vanle</o:LastAuthor>
  <o:LastPrinted>2010-08-23T02:19:42Z</o:LastPrinted>
  <o:Created>2006-06-28T09:24:54Z</o:Created>
  <o:LastSaved>2010-09-20T09:09:28Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.75in 0in .5in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;
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
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl36
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
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
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
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl50
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
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl51
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
.xl52
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
.xl53
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
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl57
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl59
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl62
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl65
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl67
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl68
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl72
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl76
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
	border-left:.5pt solid windowtext;}
.xl77
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
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl79
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl80
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl81
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
	white-space:normal;}
.xl82
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
	border-left:.5pt solid windowtext;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>So chi tiet VL (Mau so S10-DN)</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>65</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>85</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>11</x:SplitHorizontal>
     <x:TopRowBottomPane>11</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>17</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8490</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>2325</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='So chi tiet VL (Mau so S10-DN)'!$B$10:$N$10</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='So chi tiet VL (Mau so S10-DN)'!$9:$10</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1499 style='border-collapse:
 collapse;table-layout:fixed;width:1125pt'>
 <col class=xl25 width=17 style='mso-width-source:userset;mso-width-alt:621;
 width:13pt'>
 <col class=xl25 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl25 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl25 width=292 style='mso-width-source:userset;mso-width-alt:10678;
 width:219pt'>
 <col class=xl25 width=238 style='mso-width-source:userset;mso-width-alt:8704;
 width:179pt'>
 <col class=xl25 width=63 span=2 style='mso-width-source:userset;mso-width-alt:
 2304;width:47pt'>
 <col class=xl25 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl25 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl25 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl25 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl25 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl25 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl25 width=64 style='width:48pt'>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl25 width=17 style='height:14.25pt;width:13pt'></td>
  <td class=xl31 colspan=2 width=186 style='mso-ignore:colspan;width:140pt'>VINA
  GENUWIN</td>
  <td class=xl31 width=292 style='width:219pt'></td>
  <td class=xl24 width=238 style='width:179pt'></td>
  <td class=xl25 width=63 style='width:47pt'></td>
  <td class=xl69 width=63 style='width:47pt'></td>
  <td class=xl69 width=89 style='width:67pt'></td>
  <td colspan=5 class=xl33 width=487 style='width:365pt'><span
  style='mso-spacerun:yes'> </span>Mẫu số S10-DN</td>
  <td class=xl69 width=64 style='width:48pt'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl25 style='height:14.25pt'></td>
  <td class=xl46 width=100 style='width:75pt'>246 CỘNG HÒA, TÂN BÌNH , TP.HỒ
  CHÍ MINH</td>
  <td colspan=2 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl25></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl78
  x:str="(Ban hành theo Quyết định số 15/2006/QĐ-BTC ngày ">(Ban hành theo
  Quyết định số 15/2006/QĐ-BTC ngày<span style='mso-spacerun:yes'> </span></td>
  <td class=xl25></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl31 colspan=3 style='mso-ignore:colspan'>Mã số thuế:3 7 0 0 7 5 5
  6 4 3</td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl78>20 tháng 03 năm 2006 của Bộ trường Bộ Tài chính)</td>
  <td class=xl25></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td height=30 class=xl25 style='height:22.5pt'></td>
  <td colspan=12 class=xl79></td>
  <td class=xl25></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl25 style='height:19.5pt'></td>
  <td colspan=12 class=xl80>SỔ CHI TIẾT VẬT LIỆU, DỤNG CỤ (SẢN PHẨM, HÀNG HÓA)</td>
  <td class=xl25></td>
 </tr>
 <tr class=xl31 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl31 style='height:19.5pt'></td>
  <td class=xl32 colspan=2 style='mso-ignore:colspan'>Số hiệu tài khoản:</td>
  <td class=xl33 x:num>152000</td>
  <td class=xl32 x:str="Material ">Material<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=9 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl31 style='height:19.5pt'></td>
  <td class=xl32 colspan=2 style='mso-ignore:colspan'>Vật liệu, dụng cụ:</td>
  <td class=xl33>Mã</td>
  <td class=xl32>Tên</td>
  <td colspan=9 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 colspan=7 class=xl31 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=3 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl34>Đơn vị tính:</td>
  <td class=xl35>VND</td>
  <td class=xl31></td>
 </tr>
 <tr class=xl33 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl33 style='height:15.75pt'></td>
  <td colspan=2 class=xl58>Chứng từ</td>
  <td rowspan=2 class=xl58>Diễn giải</td>
  <td rowspan=2 class=xl58>Description</td>
  <td rowspan=2 class=xl81 width=63 style='width:47pt'>Số hiệu TK đối ứng</td>
  <td class=xl51 width=63 style='border-left:none;width:47pt'>Đơn giá</td>
  <td colspan=2 class=xl76>Nhập</td>
  <td colspan=2 class=xl76>Xuất</td>
  <td colspan=2 class=xl76>Tồn</td>
  <td class=xl36>Ghi chú</td>
 </tr>
 <tr class=xl33 height=47 style='mso-height-source:userset;height:35.25pt'>
  <td height=47 class=xl33 style='height:35.25pt'></td>
  <td class=xl58 id="_x0000_s1026" x:autofilter="all"
  x:autofilterrange="$B$10:$N$10" style='border-top:none'>Số hiệu</td>
  <td class=xl71 id="_x0000_s1027" x:autofilter="all" width=86
  style='border-top:none;border-left:none;width:65pt'>Ngày tháng</td>
  <td class=xl52 id="_x0000_s1025" x:autofilter="all" width=63
  style='width:47pt'>&nbsp;</td>
  <td class=xl58 id="_x0000_s1034" x:autofilter="all" style='border-top:none;
  border-left:none'>Số lượng</td>
  <td class=xl58 id="_x0000_s1035" x:autofilter="all" style='border-top:none;
  border-left:none'>Thành tiền</td>
  <td class=xl58 id="_x0000_s1036" x:autofilter="all" style='border-top:none;
  border-left:none'>Số lượng</td>
  <td class=xl58 id="_x0000_s1037" x:autofilter="all" style='border-top:none;
  border-left:none'>Thành tiền</td>
  <td class=xl58 id="_x0000_s1031" x:autofilter="all" style='border-top:none;
  border-left:none'>Số lượng</td>
  <td class=xl58 id="_x0000_s1032" x:autofilter="all" style='border-top:none;
  border-left:none'>Thành tiền</td>
  <td class=xl53 id="_x0000_s1033" x:autofilter="all" style='border-left:none'>Seq</td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 class=xl31 style='height:15.75pt'></td>
  <td class=xl48 style='border-top:none'>A</td>
  <td class=xl49 style='border-top:none;border-left:none'>B</td>
  <td class=xl56 width=292 style='border-top:none;border-left:none;width:219pt'>C</td>
  <td class=xl56 width=238 style='border-top:none;border-left:none;width:179pt'>&nbsp;</td>
  <td class=xl48 style='border-left:none'>D</td>
  <td class=xl48 style='border-left:none' x:num>1</td>
  <td class=xl57 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl57 style='border-top:none;border-left:none'>3=1x2</td>
  <td class=xl57 style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl57 style='border-top:none;border-left:none'>5=1x4</td>
  <td class=xl57 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl57 style='border-top:none;border-left:none'>7=1x6</td>
  <td class=xl58 style='border-left:none' x:num>8</td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 class=xl31 style='height:15.75pt'></td>
  <td class=xl50>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl56 width=292 style='border-top:none;border-left:none;width:219pt'>SỐ
  DƯ ĐẦU KỲ</td>
  <td class=xl56 width=238 style='border-top:none;border-left:none;width:179pt'>&nbsp;</td>
  <td class=xl48 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none;border-left:none' x:num="9"><span
  style='mso-spacerun:yes'> </span>9.00 </td>
  <td class=xl59 style='border-top:none;border-left:none' x:num="100000"><span
  style='mso-spacerun:yes'> </span>100,000.00 </td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl31 height=42 style='height:31.5pt'>
  <td height=42 class=xl31 style='height:31.5pt'></td>
  <td class=xl29>PC080109-34</td>
  <td class=xl54 style='border-left:none' x:num="39702">9/11/2008</td>
  <td class=xl55 width=292 style='border-left:none;width:219pt'>dsdsdsdsdsdskdjsfsdjgkdgkdfjgkjdkgjdfccccccccccccccccccksgsfg</td>
  <td class=xl55 width=238 style='border-left:none;width:179pt'>dsdsdsdsdsdskdjsfsdjgkdgkdfjgkjdkgjdfccccccccccccccccccksgsfg</td>
  <td class=xl37 x:num>311100</td>
  <td class=xl38 x:num="10"><span style='mso-spacerun:yes'>         </span>10 </td>
  <td class=xl61 x:num="10"><span style='mso-spacerun:yes'> </span>10 </td>
  <td class=xl62 style='border-left:none' x:num="100" x:fmla="=G13*H13"><span
  style='mso-spacerun:yes'> </span>100 </td>
  <td class=xl61 x:num="1"><span style='mso-spacerun:yes'> </span>1 </td>
  <td class=xl62 style='border-left:none' x:num="0"><span
  style='mso-spacerun:yes'> </span>- </td>
  <td class=xl61 x:num="20000000"><span
  style='mso-spacerun:yes'> </span>20,000,000 </td>
  <td class=xl62 style='border-left:none' x:num="0"><span
  style='mso-spacerun:yes'> </span>- </td>
  <td class=xl63 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl31 height=63 style='height:47.25pt'>
  <td height=63 class=xl31 style='height:47.25pt'></td>
  <td class=xl29 style='border-top:none'>PC080109-35</td>
  <td class=xl28 style='border-top:none;border-left:none' x:num="39702">9/11/2008</td>
  <td class=xl45 width=292 style='width:219pt'>Nộp tiền ký quỹ mở TK
  ACBggggggggggggggggggggggggggggggggg</td>
  <td class=xl45 width=238 style='width:179pt'>Nộp tiền ký quỹ mở TK
  ACBggggggggggggggggggggggggggggggggg</td>
  <td class=xl37 x:num>242100</td>
  <td class=xl38 x:num="0"><span style='mso-spacerun:yes'>            </span>- </td>
  <td class=xl61 x:num="0"><span style='mso-spacerun:yes'> </span>- </td>
  <td class=xl62 style='border-left:none' x:num="0" x:fmla="=G14*H14"><span
  style='mso-spacerun:yes'> </span>- </td>
  <td class=xl61 x:num="0"><span style='mso-spacerun:yes'> </span>- </td>
  <td class=xl64 style='border-top:none;border-left:none' x:num="922909"><span
  style='mso-spacerun:yes'> </span>922,909 </td>
  <td class=xl61 x:num="0"><span style='mso-spacerun:yes'> </span>- </td>
  <td class=xl64 style='border-top:none;border-left:none' x:num="922909"><span
  style='mso-spacerun:yes'> </span>922,909 </td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl31 height=63 style='height:47.25pt'>
  <td height=63 class=xl31 style='height:47.25pt'></td>
  <td class=xl29 style='border-top:none'>PC080109-36</td>
  <td class=xl28 style='border-top:none;border-left:none' x:num="39702">9/11/2008</td>
  <td class=xl45 width=292 style='width:219pt'>Nộp tiền ký quỹ mở TK
  ACBggggggggggggggggggggggggggggggggg</td>
  <td class=xl45 width=238 style='width:179pt'>Nộp tiền ký quỹ mở TK
  ACBggggggggggggggggggggggggggggggggg</td>
  <td class=xl37 x:num>133100</td>
  <td class=xl38 x:num="0"><span style='mso-spacerun:yes'>            </span>- </td>
  <td class=xl61 x:num="0"><span style='mso-spacerun:yes'> </span>- </td>
  <td class=xl62 style='border-left:none' x:num="0" x:fmla="=G15*H15"><span
  style='mso-spacerun:yes'> </span>- </td>
  <td class=xl61 x:num="0"><span style='mso-spacerun:yes'> </span>- </td>
  <td class=xl64 style='border-top:none;border-left:none' x:num="92291"><span
  style='mso-spacerun:yes'> </span>92,291 </td>
  <td class=xl61 x:num="0"><span style='mso-spacerun:yes'> </span>- </td>
  <td class=xl64 style='border-top:none;border-left:none' x:num="92291"><span
  style='mso-spacerun:yes'> </span>92,291 </td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 class=xl31 style='height:15.75pt'></td>
  <td class=xl29 style='border-top:none'>PC080109-34</td>
  <td class=xl28 style='border-top:none;border-left:none' x:num="39702">9/11/2008</td>
  <td class=xl45 width=292 style='width:219pt' x:str="Nộp tiền ký quỹ mở TK ">Nộp
  tiền ký quỹ mở TK<span style='mso-spacerun:yes'> </span></td>
  <td class=xl45 width=238 style='width:179pt' x:str="Nộp tiền ký quỹ mở TK ">Nộp
  tiền ký quỹ mở TK<span style='mso-spacerun:yes'> </span></td>
  <td class=xl37 x:num>242100</td>
  <td class=xl38 x:num="0"><span style='mso-spacerun:yes'>            </span>- </td>
  <td class=xl61 x:num="0"><span style='mso-spacerun:yes'> </span>- </td>
  <td class=xl62 style='border-left:none' x:num="0" x:fmla="=G16*H16"><span
  style='mso-spacerun:yes'> </span>- </td>
  <td class=xl61 x:num="0"><span style='mso-spacerun:yes'> </span>- </td>
  <td class=xl64 style='border-top:none;border-left:none' x:num="1680000"><span
  style='mso-spacerun:yes'> </span>1,680,000 </td>
  <td class=xl61 x:num="0"><span style='mso-spacerun:yes'> </span>- </td>
  <td class=xl64 style='border-top:none;border-left:none' x:num="1680000"><span
  style='mso-spacerun:yes'> </span>1,680,000 </td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl31 height=63 style='height:47.25pt'>
  <td height=63 class=xl31 style='height:47.25pt'></td>
  <td class=xl29 style='border-top:none'>PC080109-35</td>
  <td class=xl28 style='border-top:none;border-left:none' x:num="39702">9/11/2008</td>
  <td class=xl45 width=292 style='width:219pt'>Nộp tiền ký quỹ mở TK
  ACBggggggggggggggggggggggggggggggggg</td>
  <td class=xl45 width=238 style='width:179pt'>Nộp tiền ký quỹ mở TK
  ACBggggggggggggggggggggggggggggggggg</td>
  <td class=xl37 x:num>242100</td>
  <td class=xl38 x:num="0"><span style='mso-spacerun:yes'>            </span>- </td>
  <td class=xl61 x:num="0"><span style='mso-spacerun:yes'> </span>- </td>
  <td class=xl62 style='border-left:none' x:num="0" x:fmla="=G17*H17"><span
  style='mso-spacerun:yes'> </span>- </td>
  <td class=xl61 x:num="0"><span style='mso-spacerun:yes'> </span>- </td>
  <td class=xl64 style='border-top:none;border-left:none' x:num="2576899"><span
  style='mso-spacerun:yes'> </span>2,576,899 </td>
  <td class=xl61 x:num="0"><span style='mso-spacerun:yes'> </span>- </td>
  <td class=xl64 style='border-top:none;border-left:none' x:num="2576899"><span
  style='mso-spacerun:yes'> </span>2,576,899 </td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl31 height=63 style='height:47.25pt'>
  <td height=63 class=xl31 style='height:47.25pt'></td>
  <td class=xl29 style='border-top:none'>PC080109-36</td>
  <td class=xl28 style='border-top:none;border-left:none' x:num="39702">9/11/2008</td>
  <td class=xl45 width=292 style='width:219pt'>Nộp tiền ký quỹ mở TK
  ACBggggggggggggggggggggggggggggggggg</td>
  <td class=xl45 width=238 style='width:179pt'>Nộp tiền ký quỹ mở TK
  ACBggggggggggggggggggggggggggggggggg</td>
  <td class=xl37 x:num>133100</td>
  <td class=xl38 x:num="0"><span style='mso-spacerun:yes'>            </span>- </td>
  <td class=xl61 x:num="0"><span style='mso-spacerun:yes'> </span>- </td>
  <td class=xl62 style='border-left:none' x:num="0" x:fmla="=G18*H18"><span
  style='mso-spacerun:yes'> </span>- </td>
  <td class=xl61 x:num="0"><span style='mso-spacerun:yes'> </span>- </td>
  <td class=xl65 style='border-top:none;border-left:none' x:num="257690"><span
  style='mso-spacerun:yes'> </span>257,690 </td>
  <td class=xl61 x:num="0"><span style='mso-spacerun:yes'> </span>- </td>
  <td class=xl65 style='border-top:none;border-left:none' x:num="257690"><span
  style='mso-spacerun:yes'> </span>257,690 </td>
  <td class=xl66 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 class=xl31 style='height:15.75pt'></td>
  <td class=xl73>&nbsp;</td>
  <td class=xl39 style='border-left:none'>&nbsp;</td>
  <td class=xl74 style='border-left:none' x:str="Tổng cộng số phát sinh"><span
  style='mso-spacerun:yes'> </span>Tổng cộng số phát sinh<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl72 style='border-left:none' x:num="230000000"><span
  style='mso-spacerun:yes'> </span>230,000,000 </td>
  <td class=xl72 style='border-left:none' x:num="260848420"><span
  style='mso-spacerun:yes'> </span>260,848,420 </td>
  <td class=xl72 style='border-left:none' x:num="230000000"><span
  style='mso-spacerun:yes'> </span>230,000,000 </td>
  <td class=xl72 style='border-top:none;border-left:none' x:num="260848420"><span
  style='mso-spacerun:yes'> </span>260,848,420 </td>
  <td class=xl72 style='border-left:none' x:num="230000000"><span
  style='mso-spacerun:yes'> </span>230,000,000 </td>
  <td class=xl72 style='border-top:none;border-left:none' x:num="260848420"><span
  style='mso-spacerun:yes'> </span>260,848,420 </td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 class=xl31 style='height:15.75pt'></td>
  <td class=xl75 style='border-top:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl56 width=292 style='border-top:none;border-left:none;width:219pt'>SỐ
  DƯ CUỐI KỲ</td>
  <td class=xl43 width=238 style='width:179pt'>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl67 style='border-top:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none' x:num="10000"><span
  style='mso-spacerun:yes'> </span>10,000 </td>
  <td class=xl68 style='border-top:none' x:num="100000"><span
  style='mso-spacerun:yes'> </span>100,000 </td>
  <td class=xl60 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=14 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl25 style='height:24.0pt'></td>
  <td colspan=12 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td colspan=12 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl31 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl78>Ngày ........ tháng ........ năm ...........</td>
  <td class=xl31></td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 class=xl31 style='height:15.75pt'></td>
  <td class=xl33>Người ghi sổ</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl33>Kế toán trưởng</td>
  <td class=xl31></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl33>Giám đốc</td>
  <td class=xl31></td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 class=xl31 style='height:15.75pt'></td>
  <td class=xl44><span style='mso-spacerun:yes'> </span>( Ký, họ tên)</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl44>( Ký, họ tên)</td>
  <td class=xl31></td>
  <td colspan=3 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl44>(Ký, họ tên, đóng dấu)</td>
  <td class=xl31></td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 colspan=14 class=xl31 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 colspan=14 class=xl31 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=17 style='width:13pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=292 style='width:219pt'></td>
  <td width=238 style='width:179pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>