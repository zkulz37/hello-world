<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("acnt");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
                string p_kind = Request["kind"];
                string p_status = Request["status"];
                string p_tco_company_pk = Request["company"];
                string p_date_fr = Request["from"];
                string p_date_to = Request["to"];
                string p_date_type = Request["date_type"]; 
                string p_scale = Request["scale"];
                string p_exrate = Request["exrate"];
                string p_balance = Request["balance"];
                string p_month = Request["month"];
                string p_year = Request["year"];
                string p_ccy = Request["ccy"];
                string p_lang = Request["lang"];

                string l_parameter = "'" + p_kind + "', ";
                l_parameter += "'" + p_status + "', ";
                l_parameter += "'" + p_tco_company_pk + "', ";
                l_parameter += "'" + p_date_fr + "', ";
                l_parameter += "'" + p_date_to + "', ";
                l_parameter += "'" + p_date_type + "', ";
                l_parameter += "'" + p_scale + "', ";
                l_parameter += "'" + p_exrate + "' ";
                //Response.Write(l_parameter);
                //Response.End();            
    
                 string p_company_name = "";
                 string p_tax_code = "";
                 string p_cmp_add = "";
                 string SQL = " SELECT partner_lname, tax_code, ADDR1, ADDR2, ADDR3  FROM tco_company  WHERE pk = '" + p_tco_company_pk + "'";
                DataTable dt2 = ESysLib.TableReadOpen(SQL);
                p_company_name = dt2.Rows[0][0].ToString();
                p_tax_code = dt2.Rows[0][1].ToString();
                p_cmp_add = dt2.Rows[0][2].ToString() + " " + dt2.Rows[0][3].ToString();

                DataTable dt = ESysLib.TableReadOpenCursor("ACNT.sp_sel_gfka00210_5", l_parameter);
                if (dt.Rows.Count == 0)
                {
                    Response.Write("There is no data!!");
                    Response.End();
                }
                string header_Item = "";
                string header_Code = "";
                string header_year = "";
                string header_f = "";
                string header_Tax = "";
                if (p_lang == "VIE")
                {
                    header_Item = "Chỉ tiêu";
                    header_Code = "Mã";
                    header_year = "Lũy kế đầu năm đến tháng này";
                    header_f = "BÁO CÁO KẾT QUẢ HOẠT ĐỘNG KINH DOANH";
                    header_Tax = "MST"; 
                }
                else if (p_lang == "ENG")
                {
                    header_Item = "Items";
                    header_Code = "Code";
                    header_year = "Year to date";
                    header_f = "INCOME STATEMENT [손익계산서]";
                    header_Tax = "Tax code"; 
                }

                //p_From = (p_From.Substring(6,2)+"/"+ p_From.Substring(4,2)+"/"+p_From.Substring(0,4));
                //p_To = (p_To.Substring(6, 2) + "/" + p_To.Substring(4, 2) + "/" + p_To.Substring(0, 4));
                string header_1 = "";

                if (p_balance == "1")
                {
                    header_1 = p_month.Substring(0, 4);
                }
                else if (p_balance == "3")
                {
                    header_1 = p_year;
                }
               
                p_date_to = p_date_to.Substring(6, 2) + "/" + p_date_to.Substring(4, 2) + "/" + p_date_to.Substring(0, 4);

                p_month = p_month.Substring(4, 2);
               
             
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00120_pl_month_ENG_KOR_4_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00120_pl_month_ENG_KOR_4_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00120_pl_month_ENG_KOR_4_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>LONG</o:LastAuthor>
  <o:LastPrinted>2010-08-11T06:45:33Z</o:LastPrinted>
  <o:Created>2004-11-01T04:35:56Z</o:Created>
  <o:LastSaved>2010-08-13T02:17:13Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.82in .18in 4.06in .12in;
	mso-header-margin:.81in;
	mso-footer-margin:.5in;
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style22
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Bctc50;}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
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
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl31
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
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style16;
	font-size:12.0pt;

	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\\\(\#\,\#\#0\.00\\\)";}
.xl42
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\\\(\#\,\#\#0\.00\\\)";}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\\\(\#\,\#\#0\.00\\\)";
	text-align:center;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl45
	{mso-style-parent:style16;
	font-size:11.0pt;

	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl48
	{mso-style-parent:style22;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl50
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\0022For the year ended\0022\\ dd\\ mmmm\\ yyyy";
	text-align:left;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl55
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:11.0pt;
	
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl61
	{mso-style-parent:style0;
	font-size:12.0pt;
	
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl62
	{mso-style-parent:style16;
	font-size:11.0pt;
	
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style0;
	font-size:11.0pt;
	
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl65
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$-1010000\]d\/m\/yyyy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$-1010000\]d\/m\/yyyy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl74
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>PL</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:StandardWidth>2340</x:StandardWidth>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>28</x:Scale>
      <x:HorizontalResolution>180</x:HorizontalResolution>
      <x:VerticalResolution>180</x:VerticalResolution>
     </x:Print>
     <x:CodeName>Sheet3</x:CodeName>
     <x:Zoom>95</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>9</x:SplitHorizontal>
     <x:TopRowBottomPane>9</x:TopRowBottomPane>
     <x:SplitVertical>2</x:SplitVertical>
     <x:LeftColumnRightPane>2</x:LeftColumnRightPane>
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
       <x:ActiveRow>18</x:ActiveRow>
       <x:ActiveCol>0</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8655</x:WindowHeight>
  <x:WindowWidth>7905</x:WindowWidth>
  <x:WindowTopX>-120</x:WindowTopX>
  <x:WindowTopY>135</x:WindowTopY>
  <x:TabRatio>840</x:TabRatio>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="17409" fillcolor="none [9]">
  <v:fill color="none [9]"/>
 </o:shapedefaults></xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="4"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl34>
<%
        string _display =";display:none";         
 %>
<table x:str border=0 cellpadding=0 cellspacing=0 width=3567 style='border-collapse: collapse;table-layout:fixed;width:2689pt'>
 <col class=xl34 width=370 style='mso-width-source:userset;mso-width-alt:13531; width:278pt'>
 <col class=xl34 width=185 style='mso-width-source:userset;mso-width-alt:6765; width:139pt'>
 <col class=xl34 width=44 style='mso-width-source:userset;mso-width-alt:1609; width:33pt'>
<!----------------------------------------------------------------------------------------------------------------------------->
 <col class=xl34 width=110 span=2 style='mso-width-source:userset;mso-width-alt: 4022;width:83pt'>
<%
    if (int.Parse(p_month) > 1)
        _display = ""; 
     %> 
<col class=xl34 width=110 span=2 style='mso-width-source:userset;mso-width-alt: 4022;width:83pt<%=_display %>'>
<%
    _display = ";display:none";
    if (int.Parse(p_month) > 2 || p_balance=="3" )
        _display = ""; 
     %>
<col class=xl34 width=110 span=2 style='mso-width-source:userset;mso-width-alt: 4022;width:83pt<%=_display %>'>
<%
    _display = ";display:none";
    if (int.Parse(p_month) > 3 || p_balance == "3")
        _display = ""; 
     %>
<col class=xl34 width=110 span=2 style='mso-width-source:userset;mso-width-alt: 4022;width:83pt<%=_display %>'>
<%
    _display = ";display:none";
    if (int.Parse(p_month) > 4 || p_balance == "3")
        _display = ""; 
     %>
<col class=xl34 width=110 span=2 style='mso-width-source:userset;mso-width-alt: 4022;width:83pt<%=_display %>'>
<%
    _display = ";display:none";
    if (int.Parse(p_month) > 5 || p_balance == "3")
        _display = ""; 
     %>
<col class=xl34 width=110 span=2 style='mso-width-source:userset;mso-width-alt: 4022;width:83pt<%=_display %>'>
<%
    _display = ";display:none";
    if (int.Parse(p_month) > 6 || p_balance == "3")
        _display = ""; 
     %>
<col class=xl34 width=110 span=2 style='mso-width-source:userset;mso-width-alt: 4022;width:83pt<%=_display %>'>
<%
    _display = ";display:none";
    if (int.Parse(p_month) > 7 || p_balance == "3")
        _display = ""; 
     %>
<col class=xl34 width=110 span=2 style='mso-width-source:userset;mso-width-alt: 4022;width:83pt<%=_display %>'>
<%
    _display = ";display:none";
    if (int.Parse(p_month) > 8 || p_balance == "3")
        _display = ""; 
     %>
<col class=xl34 width=110 span=2 style='mso-width-source:userset;mso-width-alt: 4022;width:83pt<%=_display %>'>

<%
    _display = ";display:none";
    if (int.Parse(p_month) > 9 || p_balance == "3")
        _display = ""; 
     %>
<col class=xl34 width=110 span=2 style='mso-width-source:userset;mso-width-alt: 4022;width:83pt<%=_display %>'> 
<%
    _display = ";display:none";
    if (int.Parse(p_month) > 10 || p_balance == "3")
        _display = ""; 
     %>
<col class=xl34 width=110 span=2 style='mso-width-source:userset;mso-width-alt: 4022;width:83pt<%=_display %>'>

<%
    _display = ";display:none";
    if (int.Parse(p_month) > 11 || p_balance == "3")
        _display = ""; 
     %>

<col class=xl34 width=110 span=2 style='mso-width-source:userset;mso-width-alt: 4022;width:83pt<%=_display %>'> 
 
 
<col class=xl34 width=110 span=2 style='mso-width-source:userset;mso-width-alt: 4022;width:83pt'> 
 
 <tr height=25 style='height:18.75pt'>
  <td height=25 width=370 style='height:18.75pt;width:278pt' align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t172" coordsize="21600,21600"
   o:spt="172" adj="12000" path="m0@0l21600,m,21600l21600@1e">
   <v:formulas>
    <v:f eqn="val #0"/>
    <v:f eqn="sum 21600 0 @0"/>
    <v:f eqn="prod #0 1 2"/>
    <v:f eqn="sum @2 10800 0"/>
    <v:f eqn="prod @1 1 2"/>
    <v:f eqn="sum @4 10800 0"/>
   </v:formulas>
   <v:path textpathok="t" o:connecttype="custom" o:connectlocs="10800,@2;0,@3;10800,@5;21600,@4"
    o:connectangles="270,180,90,0"/>
   <v:textpath on="t" fitshape="t"/>
   <v:handles>
    <v:h position="topLeft,#0" yrange="0,15429"/>
   </v:handles>
   <o:lock v:ext="edit" text="t" shapetype="t"/>
  </v:shapetype><v:shape id="_x0000_s4097" type="#_x0000_t172" style='position:absolute;
   margin-left:65.25pt;margin-top:0;width:93.75pt;height:0;z-index:1' adj="0"
   fillcolor="#60c" strokecolor="#c9f" o:insetmode="auto">
   <v:fill color2="#c0c" focus="100%" type="gradient"/>
   <v:shadow on="t" color="#99f" offset="3pt,3pt"/>
   <v:textpath style='font-family:"Impact";v-text-kern:t' trim="t" fitpath="t"
    string="Actual"/>
  </v:shape><v:shape id="_x0000_s4098" type="#_x0000_t172" style='position:absolute;
   margin-left:45.75pt;margin-top:0;width:93.75pt;height:0;z-index:2' adj="0"
   fillcolor="#60c" strokecolor="#c9f" o:insetmode="auto">
   <v:fill color2="#c0c" focus="100%" type="gradient"/>
   <v:shadow on="t" color="#99f" offset="3pt,3pt"/>
   <v:textpath style='font-family:"Impact";v-text-kern:t' trim="t" fitpath="t"
    string="Actual"/>
  </v:shape><v:shapetype id="_x0000_t136" coordsize="21600,21600" o:spt="136"
   adj="10800" path="m@7,l@8,m@5,21600l@6,21600e">
   <v:formulas>
    <v:f eqn="sum #0 0 10800"/>
    <v:f eqn="prod #0 2 1"/>
    <v:f eqn="sum 21600 0 @1"/>
    <v:f eqn="sum 0 0 @2"/>
    <v:f eqn="sum 21600 0 @3"/>
    <v:f eqn="if @0 @3 0"/>
    <v:f eqn="if @0 21600 @1"/>
    <v:f eqn="if @0 0 @2"/>
    <v:f eqn="if @0 @4 21600"/>
    <v:f eqn="mid @5 @6"/>
    <v:f eqn="mid @8 @5"/>
    <v:f eqn="mid @7 @8"/>
    <v:f eqn="mid @6 @7"/>
    <v:f eqn="sum @6 0 @5"/>
   </v:formulas>
   <v:path textpathok="t" o:connecttype="custom" o:connectlocs="@9,0;@10,10800;@11,21600;@12,10800"
    o:connectangles="270,180,90,0"/>
   <v:textpath on="t" fitshape="t"/>
   <v:handles>
    <v:h position="#0,bottomRight" xrange="6629,14971"/>
   </v:handles>
   <o:lock v:ext="edit" text="t" shapetype="t"/>
  </v:shapetype><v:shape id="_x0000_s4099" type="#_x0000_t136" style='position:absolute;
   margin-left:32.25pt;margin-top:0;width:191.25pt;height:0;z-index:3'
   o:insetmode="auto">
   <v:shadow color="#868686"/>
   <v:textpath style='font-family:"Arial Black";v-text-kern:t' trim="t"
    fitpath="t" string="Revised 1"/>
  </v:shape><v:shape id="_x0000_s4100" type="#_x0000_t136" style='position:absolute;
   margin-left:32.25pt;margin-top:0;width:191.25pt;height:0;z-index:4'
   o:insetmode="auto">
   <v:shadow color="#868686"/>
   <v:textpath style='font-family:"Arial Black";v-text-kern:t' trim="t"
    fitpath="t" string="Revised 1"/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout; position:relative;z-index:1'><span style='position:absolute;left:42px;
  top:-1px;width:257px;height:2px'><img width=257 height=2
  src="gfka00120_pl_month_ENG_KOR_4_files/image001.gif"
  alt="Actual,Actual,Revised 1,Revised 1" v:shapes="_x0000_s4097 _x0000_s4098 _x0000_s4099 _x0000_s4100"></span></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=25 class=xl48 width=370 style='height:18.75pt;width:278pt'><%=p_company_name%></td>
   </tr>
  </table>
  </span></td>
  <td class=xl48 width=185 style='width:139pt'></td>
  <td class=xl48 width=44 style='width:33pt'></td>
  <td class=xl49 width=138 style='width:104pt'></td>
  <td class=xl49 width=110 style='width:83pt'></td>
  <td class=xl49 width=110 style='width:83pt'></td>
  <td class=xl49 width=110 style='width:83pt'></td>
  <td colspan=23 class=xl71 width=2500 style='width:1886pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl50 style='height:15.75pt'><%=p_cmp_add%></td>
  <td colspan=2 class=xl50 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl49 style='mso-ignore:colspan'></td>
  <td colspan=23 class=xl72></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl51 style='height:15.75pt'><%=header_Tax%>: <%=p_tax_code%></td>
  <td colspan=2 class=xl52 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl49 style='mso-ignore:colspan'></td>
  <td colspan=23 class=xl73></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl51 style='height:15.75pt'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl49 style='mso-ignore:colspan'></td>
  <td colspan=22 class=xl54 style='mso-ignore:colspan'></td>
  <td class=xl55></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td colspan=29 height=25 class=xl74 style='height:18.75pt'><%=header_f%></td>
  <td class=xl35></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=29 height=21 class=xl68 style='height:15.75pt'>Until <%=p_date_to%></td>
  <td class=xl56></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl51 style='height:16.5pt'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl49 style='mso-ignore:colspan'></td>
  <td colspan=20 class=xl54 style='mso-ignore:colspan'></td>
  <td class=xl57>(Currency: <%=p_ccy%>)</td>
  <td class=xl51 align=right x:num><%=p_exrate%></td>
  <td class=xl51></td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td colspan=2 height=23 class=xl69 width=555 style='border-right:.5pt solid black;
  height:17.25pt;width:417pt'><%=header_Item%></td>
  <td class=xl25 width=44 style='border-left:none;width:33pt'><%=header_Code%></td>
  <td colspan=2 class=xl66 width=248 style='border-right:.5pt solid black;
  border-left:none;width:187pt'>31/01/<%=header_1%></td>
  <td colspan=2 class=xl66 width=220 style='border-right:.5pt solid black;
  border-left:none;width:166pt'>28/02/<%=header_1%></td>
  <td colspan=2 class=xl66 width=220 style='border-right:.5pt solid black;
  border-left:none;width:166pt'>31/03/<%=header_1%></td>
  <td colspan=2 class=xl66 width=220 style='border-right:.5pt solid black;
  border-left:none;width:166pt'>30/04/<%=header_1%></td>
  <td colspan=2 class=xl66 width=220 style='border-right:.5pt solid black;
  border-left:none;width:166pt'>31/05/<%=header_1%></td>
  <td colspan=2 class=xl66 width=220 style='border-right:.5pt solid black;
  border-left:none;width:166pt'>30/06/<%=header_1%></td>
  <td colspan=2 class=xl66 width=220 style='border-right:.5pt solid black;
  border-left:none;width:166pt'>31/07/<%=header_1%></td>
  <td colspan=2 class=xl66 width=220 style='border-right:.5pt solid black;
  border-left:none;width:166pt'>31/08/<%=header_1%></td>
  <td colspan=2 class=xl66 width=220 style='border-right:.5pt solid black;
  border-left:none;width:166pt'>30/09/<%=header_1%></td>
  <td colspan=2 class=xl66 width=220 style='border-right:.5pt solid black;
  border-left:none;width:166pt'>31/10/<%=header_1%></td>
  <td colspan=2 class=xl66 width=220 style='border-right:.5pt solid black;
  border-left:none;width:166pt'>30/11/<%=header_1%></td>
  <td colspan=2 class=xl66 width=220 style='border-right:.5pt solid black;
  border-left:none;width:166pt'>31/12/<%=header_1%></td>
  <td colspan=2 class=xl75 width=236 style='border-right:2.0pt double black;  border-left:none;width:178pt' ><%=header_year %></td>  
  <td class=xl35></td>
 </tr>

 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl26 width=370 style='height:16.5pt;border-top:none;
  width:278pt'>1</td>
  <td class=xl27 width=185 style='border-top:none;width:139pt'>&nbsp;</td>
  <td class=xl28 width=44 style='border-left:none;width:33pt'>&nbsp;</td>
  <td class=xl27 width=138 style='border-top:none;width:104pt'>VND</td>
  <td class=xl33 width=110 style='border-top:none;border-left:none;width:83pt' x:num><%=dt.Rows[0][4]%></td>
  <td class=xl64 width=110 style='border-top:none;width:83pt' x:str="VND">VND</td>
  <td class=xl64 width=110 style='border-top:none;width:83pt' x:num><%=dt.Rows[0][6]%></td>
  <td class=xl27 width=110 style='border-top:none;width:83pt'>VND</td>
  <td class=xl33 width=110 style='border-top:none;border-left:none;width:83pt'  x:num><%=dt.Rows[0][8]%></td>
  <td class=xl27 width=110 style='border-top:none;width:83pt'>VND</td>
  <td class=xl33 width=110 style='border-top:none;border-left:none;width:83pt'  x:num><%=dt.Rows[0][10]%></td>
  <td class=xl27 width=110 style='border-top:none;width:83pt'>VND</td>
  <td class=xl33 width=110 style='border-top:none;border-left:none;width:83pt'  x:num><%=dt.Rows[0][12]%></td>
  <td class=xl27 width=110 style='border-top:none;width:83pt'>VND</td>
  <td class=xl33 width=110 style='border-top:none;border-left:none;width:83pt'  x:num><%=dt.Rows[0][14]%></td>
  <td class=xl27 width=110 style='border-top:none;width:83pt'>VND</td>
  <td class=xl33 width=110 style='border-top:none;border-left:none;width:83pt'  x:num><%=dt.Rows[0][16]%></td>
  <td class=xl27 width=110 style='border-top:none;width:83pt'>VND</td>
  <td class=xl33 width=110 style='border-top:none;border-left:none;width:83pt'  x:num><%=dt.Rows[0][18]%></td>
  <td class=xl27 width=110 style='border-top:none;width:83pt'>VND</td>
  <td class=xl33 width=110 style='border-top:none;border-left:none;width:83pt'  x:num><%=dt.Rows[0][20]%></td>
  <td class=xl27 width=110 style='border-top:none;width:83pt'>VND</td>
  <td class=xl33 width=110 style='border-top:none;border-left:none;width:83pt'  x:num><%=dt.Rows[0][22]%></td>
  <td class=xl27 width=110 style='border-top:none;width:83pt'>VND</td>
  <td class=xl33 width=110 style='border-top:none;border-left:none;width:83pt'  x:num><%=dt.Rows[0][24]%></td>
  <td class=xl27 width=110 style='border-top:none;width:83pt'>VND</td>
  <td class=xl33 width=110 style='border-top:none;border-left:none;width:83pt'  x:num><%=dt.Rows[0][26]%></td>
  <td class=xl29 style='border-top:none;border-left:none'>VND</td>
  <td class=xl47 width=110 style='border-top:none;border-left:none;width:83pt'  x:num></td>
  <td class=xl35></td>
 </tr>
  <%
   
     string color = "";
     string tag_color = "";
    string tag_beginbold = "";
    string tag_endbold = "";
     string _class = "";
     for (int i = 1; i < dt.Rows.Count; i++)
     {
         tag_beginbold = "";
         tag_endbold = "";
         tag_color = "";
         if (dt.Rows[i][30].ToString() == "B")
         {
            
             tag_beginbold = "<b>";
             tag_endbold = "</b>";
         }
       
         _class = "background:#" + dt.Rows[i][29].ToString().Substring(6,2) + dt.Rows[i][29].ToString().Substring(4,2) + dt.Rows[i][29].ToString().Substring(2,2)   + ";mso-pattern:auto none;";
        
  %>

 <tr class=xl32 height=21 style='height:15.75pt;mso-height-source:userset'>
  <td height=21 class=xl58 style='height:15.75pt;<%=_class%>'><%=tag_beginbold%><%=dt.Rows[i][0]%><%=tag_endbold%></td>
  <td class=xl59 style="<%=_class%>"><%=tag_beginbold%><%=dt.Rows[i][1]%><%=tag_endbold%></td>
  <td class=xl60 style='border-left:none;<%=_class%>' x:num><%=tag_beginbold%><%=dt.Rows[i][2]%><%=tag_endbold%></td>
  <td class=xl61 style="<%=_class%>" x:num><%=tag_beginbold%><%=dt.Rows[i][3]%><%=tag_endbold%></td>
  <td class=xl62 style='border-left:none;<%=_class%>' x:num><%=tag_beginbold%><%=dt.Rows[i][4]%><%=tag_endbold%></td>
  <td class=xl65 style="<%=_class%>" x:num><%=tag_beginbold%><%=dt.Rows[i][5]%><%=tag_endbold%></td>
  <td class="xl65" style="<%=_class%>" x:num><%=tag_beginbold%><%=dt.Rows[i][6]%><%=tag_endbold%></td>
  <td class=xl63 style="<%=_class%>" x:num><%=tag_beginbold%><%=dt.Rows[i][7]%><%=tag_endbold%></td>
  <td class=xl62 style='border-left:none;<%=_class%>' x:num><%=tag_beginbold%><%=dt.Rows[i][8]%><%=tag_endbold%></td>
  <td class=xl63 style="<%=_class%>" x:num><%=tag_beginbold%><%=dt.Rows[i][9]%><%=tag_endbold%></td>
  <td class=xl62 style='border-left:none;<%=_class%>' x:num><%=tag_beginbold%><%=dt.Rows[i][10]%><%=tag_endbold%></td>
  <td class=xl63 style="<%=_class%>" x:num><%=tag_beginbold%><%=dt.Rows[i][11]%><%=tag_endbold%></td>
  <td class=xl62 style='border-left:none;<%=_class%>' x:num><%=tag_beginbold%><%=dt.Rows[i][12]%><%=tag_endbold%></td>
  <td class=xl63 style="<%=_class%>" x:num><%=tag_beginbold%><%=dt.Rows[i][13]%><%=tag_endbold%></td>
  <td class=xl62 style='border-left:none;<%=_class%>' x:num><%=tag_beginbold%><%=dt.Rows[i][14]%><%=tag_endbold%></td>
  <td class=xl63 style="<%=_class%>" x:num><%=tag_beginbold%><%=dt.Rows[i][15]%><%=tag_endbold%></td>
  <td class=xl62 style='border-left:none;<%=_class%>' x:num><%=tag_beginbold%><%=dt.Rows[i][16]%><%=tag_endbold%></td>
  <td class=xl63 style="<%=_class%>" x:num><%=tag_beginbold%><%=dt.Rows[i][17]%><%=tag_endbold%></td>
  <td class=xl62 style='border-left:none;<%=_class%>' x:num><%=tag_beginbold%><%=dt.Rows[i][18]%><%=tag_endbold%></td>
  <td class=xl63 style="<%=_class%>" x:num><%=tag_beginbold%><%=dt.Rows[i][19]%><%=tag_endbold%></td>
  <td class=xl62 style='border-left:none;<%=_class%>' x:num><%=tag_beginbold%><%=dt.Rows[i][20]%><%=tag_endbold%></td>
  <td class=xl63 style="<%=_class%>" x:num><%=tag_beginbold%><%=dt.Rows[i][21]%><%=tag_endbold%></td>
  <td class=xl62 style='border-left:none;<%=_class%>' x:num><%=dt.Rows[i][22]%><%=tag_endbold%></td>
  <td class=xl63 style="<%=_class%>" x:num><%=tag_beginbold%><%=dt.Rows[i][23]%><%=tag_endbold%></td>
  <td class=xl62 style='border-left:none;<%=_class%>' x:num><%=tag_beginbold%><%=dt.Rows[i][24]%><%=tag_endbold%></td>
  <td class=xl63 style="<%=_class%>" x:num><%=tag_beginbold%><%=tag_beginbold%><%=dt.Rows[i][25]%><%=tag_endbold%></td>
  <td class=xl62 style='border-left:none;<%=_class%>' x:num><%=tag_beginbold%><%=dt.Rows[i][26]%><%=tag_endbold%></td>
  <td class=xl46 style='border-left:none;<%=_class%>' x:num><%=tag_beginbold%><%=dt.Rows[i][27]%><%=tag_endbold%></td>
  <td class=xl45 style="<%=_class%>" x:num><%=tag_beginbold%><%=dt.Rows[i][28]%><%=tag_endbold%></td>
  <td class=xl32></td>
 </tr>
<%} %> 
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl30 style='height:16.5pt'>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl31 style='border-left:none'>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38 style='border-left:none'>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl38 style='border-left:none'>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl38 style='border-left:none'>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl38 style='border-left:none'>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl38 style='border-left:none'>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl38 style='border-left:none'>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl38 style='border-left:none'>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl38 style='border-left:none'>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl38 style='border-left:none'>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl38 style='border-left:none'>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl38 style='border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-left:none'>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=370 style='width:278pt'></td>
  <td width=185 style='width:139pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
