<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("acnt");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
                   string p_compk = Request["compk"];
                   string p_month = Request["month"];
                   string p_vat_type = Request["vat_type"];
                   string p_vat_rate = Request["vat_rate"];
                   string p_ccy = Request["ccy"];
                   string p_status = Request["status"];
                   string p_custpk = Request["custpk"];
                   string p_invoiceno = Request["invoiceno"];
                   string p_ac_cd = Request["ac_cd"];
                   string p_tac_hgtrh_pk = Request["tac_hgtrh_pk"];
                   string p_voucherno = Request["voucherno"];
                   string p_balance_type = Request["balance_type"];
                   string p_dtfr = Request["dtfr"];
                   string p_dtto = Request["dtto"];

                   string p_company_name = "";
                   string p_tax_code = "";
                   string p_cmp_add = "";
                   string SQL = " SELECT partner_lname, tax_code, ADDR1, ADDR2, ADDR3  FROM tco_company  WHERE pk = '" + p_compk + "'";
                   DataTable dt2 = ESysLib.TableReadOpen(SQL);
                   p_company_name = dt2.Rows[0][0].ToString();
                   p_tax_code = dt2.Rows[0][1].ToString();
                   p_cmp_add = dt2.Rows[0][2].ToString() + " " + dt2.Rows[0][3].ToString();

                    string l_parameter = "'" + p_compk + "', ";
                    l_parameter += "'" + p_month + "', ";
                    l_parameter += "'" + p_vat_type + "', ";
                    l_parameter += "'" + p_vat_rate + "', ";
                    l_parameter += "'" + p_ccy + "', ";
                    l_parameter += "'" + p_status + "', ";
                    l_parameter += "'" + p_custpk + "', ";
                    l_parameter += "'" + p_invoiceno + "', ";
                    l_parameter += "'" + p_ac_cd + "', ";
                    l_parameter += "'" + p_tac_hgtrh_pk + "', ";  
                    l_parameter += "'" + p_voucherno + "', ";
                    l_parameter += "'" + p_balance_type + "', ";
                    l_parameter += "'" + p_dtfr + "', ";
                    l_parameter += "'" + p_dtto + "' ";
                    //Response.Write(l_parameter);
                    //Response.End(); 
                   DataTable dt_Detail = ESysLib.TableReadOpenCursor("acnt.sp_sel_gflv00040_1", l_parameter);
                   if (dt_Detail.Rows.Count == 0)
                   {
                       Response.Write("There is no data!!");
                       Response.End();
                   }

                   string p_thang = "";
                   string p_nam = "";
                   p_thang = p_month.Substring(4, 2);
                   p_nam = p_month.Substring(0, 4);         
     %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List
href="bang%20ke%20hoa%20don%20hang%20hoa%20mua%20vao_files/filelist.xml">
<link rel=Edit-Time-Data
href="bang%20ke%20hoa%20don%20hang%20hoa%20mua%20vao_files/editdata.mso">
<link rel=OLE-Object-Data
href="bang%20ke%20hoa%20don%20hang%20hoa%20mua%20vao_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>LONG</o:LastAuthor>
  <o:LastPrinted>2010-10-01T01:26:07Z</o:LastPrinted>
  <o:Created>2010-09-29T08:55:16Z</o:Created>
  <o:LastSaved>2010-10-01T01:40:46Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .5in 1.0in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0_\)\;\\\(0\\\)";
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
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
.xl37
	{mso-style-parent:style0;
	font-size:9.0pt;
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
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:justify;}
.xl39
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
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
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:9.0pt;
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
.xl53
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	vertical-align:middle;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	vertical-align:middle;}
.xl60
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl61
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	vertical-align:middle;}
.xl64
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl68
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl77
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl80
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl81
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl82
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl83
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl85
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl87
	{mso-style-parent:style0;
	font-size:9.0pt;
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
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl89
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl90
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl92
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl93
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl94
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl95
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl96
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl97
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl98
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl99
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl100
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl101
	{mso-style-parent:style0;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl102
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl103
	{mso-style-parent:style0;
	font-size:9.0pt;
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
	white-space:normal;}
.xl104
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl105
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl106
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl107
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl108
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl109
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>gflv00400_import_VAT_in</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>84</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:DoNotDisplayGridlines/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>14</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
       <x:RangeSelection>$B$15:$D$16</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>12000</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl39>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1589 style='border-collapse:
 collapse;table-layout:fixed;width:1193pt'>
 <col class=xl31 width=37 style='mso-width-source:userset;mso-width-alt:1353;
 width:28pt'>
 <col class=xl33 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl31 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl33 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl33 width=233 style='mso-width-source:userset;mso-width-alt:8521;
 width:175pt'>
 <col class=xl33 width=125 style='mso-width-source:userset;mso-width-alt:4571;
 width:94pt'>
 <col class=xl33 width=131 style='mso-width-source:userset;mso-width-alt:4790;
 width:98pt'>
 <col class=xl31 width=131 style='mso-width-source:userset;mso-width-alt:4790;
 width:98pt'>
 <col class=xl34 width=131 style='mso-width-source:userset;mso-width-alt:4790;
 width:98pt'>
 <col class=xl33 width=131 style='mso-width-source:userset;mso-width-alt:4790;
 width:98pt'>
 <col class=xl31 width=154 style='mso-width-source:userset;mso-width-alt:5632;
 width:116pt'>
 <col class=xl31 width=64 style='width:48pt'>
 <col class=xl32 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl32 width=64 span=2 style='width:48pt'>
 <tr class=xl31 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=3 height=21 class=xl75 width=182 style='border-right:.5pt solid black;
  height:15.75pt;width:137pt'>Mẫu số: 01 - 2/TTĐ (Ban hành</td>
  <td class=xl24 width=93 style='width:70pt'></td>
  <td class=xl25 width=233 style='width:175pt'></td>
  <td class=xl26 width=125 style='width:94pt'></td>
  <td class=xl27 width=131 style='width:98pt'></td>
  <td class=xl28 width=131 style='width:98pt'></td>
  <td class=xl29 width=131 style='width:98pt'></td>
  <td class=xl30 width=131 style='width:98pt'></td>
  <td class=xl31 width=154 style='width:116pt'></td>
  <td class=xl31 width=64 style='width:48pt'></td>
  <td class=xl32 width=86 style='width:65pt'></td>
  <td class=xl32 width=64 style='width:48pt'></td>
  <td class=xl32 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl31 height=13 style='mso-height-source:userset;height:9.75pt'>
  <td colspan=3 height=13 class=xl73 style='border-right:.5pt solid black;
  height:9.75pt' x:str="kèm theo thông tư số ">kèm theo thông tư số<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td class=xl34></td>
  <td class=xl33></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=3 height=21 class=xl78 style='border-right:.5pt solid black;
  height:15.75pt' x:str="60/2007TT - BTC ngày ">60/2007TT - BTC ngày<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td class=xl34></td>
  <td class=xl33></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=16 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=3 height=16 class=xl70 style='border-right:.5pt solid black;
  height:12.0pt'>14/6/2007 của Bộ Tài Chính)</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td class=xl34></td>
  <td class=xl33></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=33 style='mso-height-source:userset;height:24.75pt'>
  <td colspan=10 height=33 class=xl100 style='height:24.75pt'>BẢNG KÊ HOÁ ĐƠN
  HÀNG HÓA, DỊCH VỤ MUA VÀO CHỊU THUẾ TIÊU THỤ ĐẶC BIỆT</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=0 style='display:none'>
  <td colspan=10 class=xl101></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=10 height=20 class=xl35 style='height:15.0pt'>(Kèm theo tờ khai
  thuế TTĐB theo mẫu số 01/TTĐB)</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=10 height=20 class=xl35 style='height:15.0pt'>Kỳ tính thuế: Tháng
  <%=p_thang%> năm <%=p_nam %></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl35 style='height:15.0pt'></td>
  <td class=xl33></td>
  <td class=xl31></td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td class=xl34></td>
  <td class=xl33></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl109 colspan=2 style='height:15.0pt;mso-ignore:colspan'
  x:str="Người nộp thuế: ">Người nộp thuế:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl108 colspan=2 style='mso-ignore:colspan'><%=p_company_name%></td>
  <td colspan=6 class=xl109 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl67 colspan=2 style='height:15.0pt;mso-ignore:colspan'
  x:str="Địa chỉ: ">Địa chỉ:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl108 colspan=2 style='mso-ignore:colspan'><%=p_cmp_add%></td>
  <td colspan=6 class=xl67 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl109 colspan=2 style='height:15.0pt;mso-ignore:colspan'
  x:str="Mã số thuế: ">Mã số thuế:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl108><%=p_tax_code %></td>
  <td colspan=7 class=xl109 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl31 colspan=4 style='height:15.0pt;mso-ignore:colspan'>I.
  Bảng tính thuế TTĐB của nguyên liệu mua vào:</td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td class=xl34></td>
  <td class=xl33></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=10 height=20 class=xl91 style='height:15.0pt'>Đơn vị tiền: đồng
  Việt Nam</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td rowspan=3 height=75 class=xl68 width=37 style='border-bottom:.5pt solid black;
  height:56.25pt;border-top:none;width:28pt'>STT</td>
  <td colspan=3 rowspan=2 class=xl92 width=238 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:179pt'>Hoá đơn, chứng từ, biên lai nộp
  thuế TTĐB</td>
  <td rowspan=3 class=xl68 width=233 style='border-bottom:.5pt solid black;
  border-top:none;width:175pt'>Tên nguyên liệu đã nộp thuếTTĐB</td>
  <td rowspan=3 class=xl68 width=125 style='border-bottom:.5pt solid black;
  border-top:none;width:94pt'>Số lượng đơn vị nguyên liệu mua vào</td>
  <td rowspan=3 class=xl68 width=131 style='border-bottom:.5pt solid black;
  border-top:none;width:98pt'>Thuế TTĐB đã nộp (đồng)</td>
  <td rowspan=3 class=xl68 width=131 style='border-bottom:.5pt solid black;
  border-top:none;width:98pt'>Thuế TTĐB trên 1 đơn vị nguyên liệu mua vào
  (đồng)</td>
  <td rowspan=3 class=xl97 width=131 style='border-bottom:.5pt solid black;
  border-top:none;width:98pt' x:str="Số thuế TTĐB đã khấu trừ các kỳ trước"><span
  style='mso-spacerun:yes'> </span>Số thuế TTĐB đã khấu trừ các kỳ trước<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl68 width=131 style='border-bottom:.5pt solid black;
  border-top:none;width:98pt'>Số thuế TTĐB chưa được khấu trừ</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 colspan=2 class=xl31 style='height:8.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=47 style='mso-height-source:userset;height:35.25pt'>
  <td height=47 class=xl36 width=78 style='height:35.25pt;width:59pt'>Ký hiệu</td>
  <td class=xl36 width=67 style='width:50pt'>Số</td>
  <td class=xl36 width=93 style='width:70pt'>Ngày, tháng, năm phát hành</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl42 style='height:18.75pt'>(1)</td>
  <td class=xl43>(2)</td>
  <td class=xl43>(3)</td>
  <td class=xl43>(4)</td>
  <td class=xl43>(5)</td>
  <td class=xl43>(6)</td>
  <td class=xl43>(7)</td>
  <td class=xl43>(8)=(7)/(6)</td>
  <td class=xl43>(9)</td>
  <td class=xl43>(10)</td>
  <td colspan=2 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
<%
    decimal qty = 0;
    decimal u_price = 0;
    decimal total = 0;
    decimal _8 = 0;
    decimal _7 = 0;
    decimal _6 = 0;
   
    for(int i = 0; i < dt_Detail.Rows.Count;i++)
    {
        if (dt_Detail.Rows[i][13].ToString().Trim() != "")
        {
            _6 = decimal.Parse(dt_Detail.Rows[i][13].ToString());
        }
        else
        {
            _6 = 0;
        }

        if (dt_Detail.Rows[i][17].ToString().Trim() != "")
        {
            _7 = decimal.Parse( dt_Detail.Rows[i][17].ToString());
        }
        else
        {
            _7 = 0;
        }

        _8 = _7 / _6;

      
     %> 
 <tr class=xl44 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl51 width=37 style='height:18.75pt;width:28pt'><%=dt_Detail.Rows[i][0]%></td>
  <td class=xl52 width=78 style='width:59pt'><%=dt_Detail.Rows[i][5]%></td>
  <td class=xl52 width=67 style='width:50pt'><%=dt_Detail.Rows[i][7]%></td>
  <td class=xl53 width=93 style='width:70pt'><%=dt_Detail.Rows[i][6]%></td>
  <td class=xl54 width=233 style='width:175pt'><%=dt_Detail.Rows[i][12]%></td>
  <td class=xl55 width=125 style='width:94pt' x:num><%=dt_Detail.Rows[i][13]%></td>
  <td class=xl56 width=131 style='width:98pt' x:num><%=dt_Detail.Rows[i][17]%></td>
  <td class=xl56 width=131 style='width:98pt' x:num><%=_8%></td>
  <td class=xl56 width=131 style='width:98pt' x:num></td>
  <td class=xl56 width=131 style='width:98pt' x:num></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl57 style='mso-ignore:colspan'></td>
 </tr>
<%}        
    %> 
     <%
   DataTable dt_total = ESysLib.TableReadOpenCursor("acnt.sp_sel_gflv00040_report_sum", l_parameter);
   
   for (int j = 0; j < dt_total.Rows.Count; j++)
   {
         %>
 <tr class=xl45 height=25 style='mso-height-source:userset;height:18.75pt'>
  
  <%if (j == 0)
  { %> 
  <td colspan=4 rowspan="<%=dt_total.Rows.Count.ToString()%>"  class=xl83 style='border-right:.5pt solid black;border-left: none'><%=dt_total.Rows[j][0]%></td>
<%} %> 

  <td class=xl61 style='border-top:none;border-left:none'><%=dt_total.Rows[j][1]%></td>
  <td class=xl62 x:num><%=dt_total.Rows[j][2]%></td>
  <td class=xl62 x:num><%=dt_total.Rows[j][4]%></td>
  <td class=xl62 x:num><%=dt_total.Rows[j][5]%></td>
  <td class=xl62 x:num></td>
  <td class=xl62 x:num></td>

 </tr>
<%} %>  
 <tr class=xl31 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl46 colspan=5 style='height:21.0pt;mso-ignore:colspan'>II. Bảng tính thuế TTĐB của nguyên liệu được khấu trừ:</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl47 height=52 style='mso-height-source:userset;height:39.0pt'>
  <td height=52 class=xl37 width=37 style='height:39.0pt;width:28pt'>STT</td>
  <td colspan=2 class=xl86 width=145 style='border-right:.5pt solid black;
  border-left:none;width:109pt'>Mặt hàng tiêu thụ</td>
  <td class=xl36 width=93 style='width:70pt'>Số lượng</td>
  <td colspan=2 class=xl86 width=358 style='border-left:none;width:269pt'>Tên
  nguyên liệu chịu thuếTTĐB đầu vào</td>
  <td colspan=2 class=xl89 width=262 style='border-right:.5pt solid black;
  width:196pt'>Lượng nguyên liệu trên 1 đơn vị sản phẩm tiêu thụ</td>
  <td class=xl48 width=131 style='width:98pt'
  x:str="Thuế TTĐB trên 1 đơn vị nguyên liệu đầu vào (đồng)"><span
  style='mso-spacerun:yes'> </span>Thuế TTĐB trên 1 đơn vị nguyên liệu đầu vào
  (đồng)<span style='mso-spacerun:yes'> </span></td>
  <td class=xl36 width=131 style='width:98pt'>Tổng thuế TTĐB đầu vào được khấu
  trừ (đồng)</td>
  <td colspan=2 class=xl47 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl49 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl64 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl65 width=37 style='height:18.75pt;border-top:none;  width:28pt' x:num>1</td>
  <td colspan=2 class=xl106 width=145 style='border-right:.5pt solid black;  border-left:none;width:109pt'>sdfsdfsdf</td>
  <td class=xl66 width=93 style='border-top:none;border-left:none;width:70pt' x:num>3,425,345 </td>
  <td colspan=2 class=xl104 width=358 style='border-right:.5pt solid black;  border-left:none;width:269pt' x:num>34,534,534 </td>
  <td colspan=2 class=xl104 width=262 style='border-right:.5pt solid black; border-left:none;width:196pt' x:num>456,456,456 </td>
  <td class=xl66 width=131 style='border-top:none;border-left:none;width:98pt'  x:num>234,234 </td>
  <td class=xl66 width=131 style='border-top:none;border-left:none;width:98pt'  x:num>2,342,342 </td>
  <td colspan=2 class=xl64 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl57 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl45 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl50 width=37 style='height:21.75pt;width:28pt'>&nbsp;</td>
  <td colspan=2 class=xl86 width=145 style='border-right:.5pt solid black; border-left:none;width:109pt'>Tổng cộng</td>
  <td class=xl58 width=93 style='width:70pt' x:num>345,345 </td>
  <td colspan=2 class=xl102 width=358 style='border-right:.5pt solid black; border-left:none;width:269pt' x:num>345,345,345 </td>
  <td colspan=2 class=xl102 width=262 style='border-right:.5pt solid black; border-left:none;width:196pt' x:num>657,575 </td>
  <td class=xl58 width=131 style='width:98pt' x:num>345,345 </td>
  <td class=xl58 width=131 style='width:98pt' x:num>5,675,675 </td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl59 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl38 style='height:15.0pt'></td>
  <td class=xl33></td>
  <td class=xl31></td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td class=xl34></td>
  <td class=xl33></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl38 style='height:15.0pt'></td>
  <td class=xl33></td>
  <td class=xl31></td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl82>Ngày 28 tháng 09 năm 2010</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt'></td>
  <td class=xl33></td>
  <td class=xl31></td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl81>NGƯỜI NỘP THUẾ hoặc</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt'></td>
  <td class=xl33></td>
  <td class=xl31></td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl81>ĐẠI DIỆN HỢP PHÁP CỦA NGƯỜI NỘP THUẾ</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt'></td>
  <td class=xl33></td>
  <td class=xl31></td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl81><span style='mso-spacerun:yes'> </span>Ký tên, đóng
  dấu (ghi rõ họ tên và chức vụ)</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=37 style='width:28pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=233 style='width:175pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=154 style='width:116pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
