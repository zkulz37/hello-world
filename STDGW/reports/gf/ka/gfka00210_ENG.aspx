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
                string header_Ass = "";
                string header_kor = "";
                string header_code = "";
                string header_note = "";
                string header_resource = "";
                string header_f = "";
                string header_Tax = "";
                if (p_lang == "VIE")
                {
                    header_Ass = "Tài sản";
                    header_kor = "자산(Tiếng hàn)";
                    header_code = "Mã";
                    header_note = "Ghi chú";
                    header_resource = "Nguồn vốn";
                   header_f = "BẢNG CÂN ĐỐI KẾ TOÁN";
                   header_Tax = "MST"; 
                } 
                else if(p_lang =="ENG")
                {
                    header_Ass = "ASSETS";
                    header_kor = "자산";
                    header_code = "CODE";
                    header_note = "NOTES";
                    header_resource = "RESOURCE";
                    header_f = "BALANCE SHEET [대차대조표]";
                    header_Tax = "Tax code"; 
                }
                
                //p_From = (p_From.Substring(6,2)+"/"+ p_From.Substring(4,2)+"/"+p_From.Substring(0,4));
                //p_To = (p_To.Substring(6, 2) + "/" + p_To.Substring(4, 2) + "/" + p_To.Substring(0, 4));
                string header_1 = "";
               
                if (p_balance == "1")
                {
                    header_1 = p_month.Substring(4, 2) + "/" + p_month.Substring(0, 4);
                }
                else if (p_balance == "3")
                {
                    header_1 = p_year;
                }
                else if (p_balance == "4" || p_balance == "5")
                {
                    header_1 = "From " + p_date_fr.Substring(6, 2) + "/" + p_date_fr.Substring(4, 2) + "/" + p_date_fr.Substring(0, 4) + " to " + p_date_to.Substring(6, 2) + "/" + p_date_to.Substring(4, 2) + "/" + p_date_to.Substring(0, 4);
                }
                p_date_to = p_date_to.Substring(6, 2) + "/" + p_date_to.Substring(4, 2) + "/" + p_date_to.Substring(0, 4);
                //Response.Write(header_1);
                //Response.End();
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00120_bs_month_4_ENG_KOR_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00120_bs_month_4_ENG_KOR_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00120_bs_month_4_ENG_KOR_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Phan Thi Thanh Tuyen</o:Author>
  <o:LastAuthor>LONG</o:LastAuthor>
  <o:LastPrinted>2010-08-10T07:27:29Z</o:LastPrinted>
  <o:Created>2010-07-21T08:24:20Z</o:Created>
  <o:LastSaved>2010-08-10T07:43:05Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .5in .5in .75in;
	mso-header-margin:0in;
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
.style20
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
	{mso-style-parent:style20;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl26
	{mso-style-parent:style20;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style20;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mmm\/yyyy";
	text-align:left;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style20;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mmm\/yyyy";
	text-align:left;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style16;
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
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
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
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
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
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl43
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl47
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style16;
	font-size:11.0pt;
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
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl52
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmm\\-yy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl61
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl62
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mmm\/yyyy";
	text-align:left;
	vertical-align:middle;}
.xl64
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl65
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl66
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl67
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl71
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl72
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
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
	{mso-style-parent:style20;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mmm\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ \\ dd\\\,\\ \\ yyyy";
	text-align:center;
	vertical-align:middle;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl78
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
.xl79
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl80
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:1.5pt solid windowtext;
	border-left:none;}
.xl82
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.5pt solid windowtext;
	border-left:none;}
.xl83
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.5pt solid windowtext;
	border-left:none;}
.xl84
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl85
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl86
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:1.5pt solid windowtext;
	border-left:none;
	mso-protection:unlocked visible;}
.xl87
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.5pt solid windowtext;
	border-left:none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.5pt solid windowtext;
	border-left:none;
	mso-protection:unlocked visible;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>52</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Zoom>90</x:Zoom>
     <x:Selected/>
     <x:LeftColumnVisible>2</x:LeftColumnVisible>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>9</x:SplitHorizontal>
     <x:TopRowBottomPane>9</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>38</x:ActiveRow>
       <x:ActiveCol>11</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8445</x:WindowHeight>
  <x:WindowWidth>18555</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>540</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl43>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1830 style='border-collapse:
 collapse;table-layout:fixed;width:1374pt'>
 <col class=xl43 width=375 style='mso-width-source:userset;mso-width-alt:13714;
 width:281pt'>
 <col class=xl43 width=120 style='mso-width-source:userset;mso-width-alt:4388;
 width:90pt'>
 <col class=xl43 width=64 style='width:48pt'>
 <col class=xl43 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl43 width=146 span=2 style='mso-width-source:userset;mso-width-alt:
 5339;width:110pt'>
 <col class=xl43 width=32 style='mso-width-source:userset;mso-width-alt:1170;
 width:24pt'>
 <col class=xl43 width=333 style='mso-width-source:userset;mso-width-alt:12178;
 width:250pt'>
 <col class=xl43 width=158 style='mso-width-source:userset;mso-width-alt:5778;
 width:119pt'>
 <col class=xl43 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl43 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl43 width=137 span=2 style='mso-width-source:userset;mso-width-alt:
 5010;width:103pt'>
 <col class=xl43 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:5010'>
 <tr height=25 style='height:18.75pt'>
  <td height=25 width=375 style='height:18.75pt;width:281pt' align=left
  valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t172" coordsize="21600,21600"
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
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t172" style='position:absolute;
   margin-left:59.25pt;margin-top:0;width:93.75pt;height:0;z-index:1' adj="0"
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
  </v:shapetype><v:shape id="_x0000_s1026" type="#_x0000_t136" style='position:absolute;
   margin-left:32.25pt;margin-top:0;width:313.5pt;height:0;z-index:2'
   fillcolor="#369" stroked="f" o:insetmode="auto">
   <v:shadow on="t" color="silver" offset="3pt"/>
   <v:textpath style='font-family:"Times New Roman";v-text-kern:t' trim="t"
    fitpath="t" string="Adjusment + ASA"/>
  </v:shape><v:shape id="_x0000_s1027" type="#_x0000_t136" style='position:absolute;
   margin-left:45.75pt;margin-top:0;width:240pt;height:0;z-index:3'
   o:insetmode="auto">
   <v:shadow color="#868686"/>
   <v:textpath style='font-family:"Arial Black";v-text-kern:t' trim="t"
    fitpath="t" string="Revised 1"/>
  </v:shape><v:shape id="_x0000_s1028" type="#_x0000_t172" style='position:absolute;
   margin-left:59.25pt;margin-top:0;width:93.75pt;height:0;z-index:4' adj="0"
   fillcolor="#60c" strokecolor="#c9f" o:insetmode="auto">
   <v:fill color2="#c0c" focus="100%" type="gradient"/>
   <v:shadow on="t" color="#99f" offset="3pt,3pt"/>
   <v:textpath style='font-family:"Impact";v-text-kern:t' trim="t" fitpath="t"
    string="Actual"/>
  </v:shape><v:shape id="_x0000_s1029" type="#_x0000_t136" style='position:absolute;
   margin-left:32.25pt;margin-top:0;width:313.5pt;height:0;z-index:5'
   fillcolor="#369" stroked="f" o:insetmode="auto">
   <v:shadow on="t" color="silver" offset="3pt"/>
   <v:textpath style='font-family:"Times New Roman";v-text-kern:t' trim="t"
    fitpath="t" string="Adjusment + ASA"/>
  </v:shape><v:shape id="_x0000_s1030" type="#_x0000_t136" style='position:absolute;
   margin-left:45.75pt;margin-top:0;width:240pt;height:0;z-index:6'
   o:insetmode="auto">
   <v:shadow color="#868686"/>
   <v:textpath style='font-family:"Arial Black";v-text-kern:t' trim="t"
    fitpath="t" string="Revised 1"/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:relative;z-index:1'><span style='position:absolute;left:43px;
  top:-1px;width:418px;height:2px'><img width=418 height=2
  src="gfka00120_bs_month_4_ENG_KOR_files/image001.gif"
  alt="Actual,Adjusment + ASA,Revised 1,Actual,Adjusment + ASA,Revised 1"
  v:shapes="_x0000_s1025 _x0000_s1027 _x0000_s1028 _x0000_s1030"></span></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=25 class=xl25 width=375 style='height:18.75pt;width:281pt'><%=p_company_name%></td>
   </tr>
  </table>
  </span></td>
  <td class=xl25 width=120 style='width:90pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl27 width=63 style='width:47pt'></td>
  <td class=xl28 width=146 style='width:110pt'></td>
  <td class=xl28 width=146 style='width:110pt'></td>
  <td class=xl43 width=32 style='width:24pt'></td>
  <td class=xl43 width=333 style='width:250pt'></td>
  <td class=xl43 width=158 style='width:119pt'></td>
  <td class=xl43 width=56 style='width:42pt'></td>
  <td class=xl27 width=63 style='width:47pt'></td>
  <td class=xl28 width=137 style='width:103pt'></td>
  <td class=xl28 width=137 style='width:103pt'></td>
  <td class=xl44 width=0>Form: B 01 - DN</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl45 style='height:15.75pt'><%=p_cmp_add%></td>
  <td class=xl45></td>
  <td class=xl46></td>
  <td colspan=3 class=xl73></td>
  <td colspan=4 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl73>(Ban hành theo Quyết Định số 15/2006/QĐ-BTC ngày</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl63 style='height:15.75pt'><%=header_Tax%>: <%=p_tax_code%></td>
  <td class=xl29></td>
  <td class=xl30></td>
  <td colspan=3 class=xl73></td>
  <td colspan=4 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl73>20 tháng 03 năm 2006 của Bộ trưởng Bộ Tài Chính)</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=14 height=26 class=xl74 style='height:19.5pt'><%=header_f%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=14 height=20 class=xl75 style='height:15.0pt'>Until <%=p_date_to%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=8 class=xl60 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl66 ></td>
  <td colspan=2 class=xl60 style='mso-ignore:colspan'></td>
  <td class=xl60>EX : <%=p_exrate%>/<%=p_ccy%></td>
  <td colspan=2 class=xl60 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl43 style='height:15.75pt'></td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl61></td>
  <td class=xl62>(Currency : <%=p_ccy%>)</td>
 </tr>
 <tr class=xl57 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl53 style='height:19.5pt'><%=header_Ass%></td>
  <td class=xl54><%=header_kor%></td>
  <td class=xl55><%=header_code%></td>
  <td class=xl55><%=header_note%></td>
  <td class=xl56 ><%=header_1%></td>
  <td class=xl56 ><%=header_1%></td>
  <td class=xl57></td>
  <td class=xl53><%=header_resource%></td>
  <td class=xl54><%=header_kor%></td>
  <td class=xl55><%=header_code%></td>
  <td class=xl55><%=header_note%></td>
  <td class=xl56 ><%=header_1%></td>
  <td class=xl56 ><%=header_1%></td>
  <td class=xl58 >12/31/2008</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl80 style='height:19.5pt;border-top:none' x:num>1</td>
  <td class=xl81 style='border-top:none'>&nbsp;</td>
  <td class=xl82 style='border-top:none' x:num>2</td>
  <td class=xl83 style='border-top:none'>3</td>
  <td class=xl84 style='border-top:none'>VND</td>
  <td class=xl84 style='border-top:none'>USD</td>
  <td class=xl47 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl86 style='border-top:none'>&nbsp;</td>
  <td class=xl87 width=56 style='border-top:none;width:42pt' x:num>2</td>
  <td class=xl88 width=63 style='border-top:none;width:47pt'>3</td>
  <td class=xl84 style='border-top:none'>VND</td>
  <td class=xl84 style='border-top:none'>USD</td>
  <td class=xl48 x:num>5</td>
 </tr>
 <%
     int p = 0;
     string color = "";
     string tag_color = "";
    string tag_beginbold = "";
    string tag_endbold = "";
    string tag_beginbold1 = "";
    string tag_endbold1 = ""; 
     p = (dt.Rows.Count) / 2;
     string _class = "";
     string _class1 = ""; 
     for (int i = 0; i < p; i++)
     {
         //color = int.Parse(dt.Rows[i][6]);
         //Response.Write(color);
         //Response.End();
         tag_beginbold = "";
         tag_endbold = "";
         tag_beginbold1 = "";
         tag_endbold1 = "";
         tag_color = "";

         if (dt.Rows[i][7].ToString() == "B")
         {
            
             tag_beginbold = "<b>";
             tag_endbold = "</b>";
         }
         else if (dt.Rows[i + p][7].ToString() == "B")
         {
             tag_beginbold1 = "<b>";
             tag_endbold1 = "</b>";
         }

         //if (dt.Rows[i][6].ToString()!="" )
         //{
         //    tag_color = dt.Rows[i][6].ToString();
         //}
         _class = "background:#" + dt.Rows[i][6].ToString().Substring(6,2) + dt.Rows[i][6].ToString().Substring(4,2) + dt.Rows[i][6].ToString().Substring(2,2)   + ";mso-pattern:auto none;";
         _class1 = "background:#" + dt.Rows[i+p][6].ToString().Substring(6, 2) + dt.Rows[i+p][6].ToString().Substring(4, 2) + dt.Rows[i+p][6].ToString().Substring(2, 2) + ";mso-pattern:auto none;";
             
  %>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl31 style='height:20.1pt;<%=_class %>'><%=tag_beginbold%><%=dt.Rows[i][0]%><%=tag_endbold%></td>
  <td class=xl49 style="<%=_class %>"><%=tag_beginbold%><%=dt.Rows[i][1]%><%=tag_endbold%></td>
  <td class=xl32 style="<%=_class %>" x:num><%=tag_beginbold%><%=dt.Rows[i][2]%><%=tag_endbold%></td>
  <td class=xl32 style="<%=_class %>"><%=tag_beginbold%><%=dt.Rows[i][3]%><%=tag_endbold%></td>
  <td class=xl59 style="<%=_class %>" x:num><%=tag_beginbold%><%=dt.Rows[i][4]%><%=tag_endbold%></td>
  <td class=xl79  style='border-left:none;<%=_class %>' x:num><%=tag_beginbold%><%=dt.Rows[i][5]%><%=tag_endbold%></td>
  <td class=xl43 ></td>
  <td class=xl31 style="<%=_class1 %>" ><%=tag_beginbold1%><%=dt.Rows[i + p][0]%><%=tag_endbold1%></td>
  <td class=xl49 style="<%=_class1 %>" ><%=dt.Rows[i + p][1]%></td>
  <td class=xl32 style="<%=_class1 %>"  x:num><%=dt.Rows[i + p][2]%></td>
  <td class=xl32 style="<%=_class1 %>" ><%=dt.Rows[i + p][3]%></td>
  <td class=xl59 style="<%=_class1 %>"  x:num><%=dt.Rows[i + p][4]%></td>
  <td class=xl79 style='border-left:none;<%=_class1 %>' x:num><%=dt.Rows[i + p][5]%></td>
  <td class=xl33 style="<%=_class1 %>"  x:num><%=dt.Rows[i + p][6]%></td>
 </tr>
 <%
     
 }       %>
 <tr class=xl43 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl67 style='height:20.1pt'>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl72 style='border-left:none'>&nbsp;</td>
  <td class=xl43></td>
  <td class=xl69 width=333 style='width:250pt'>&nbsp;</td>
  <td class=xl70 width=158 style='width:119pt'>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl72 style='border-left:none'>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 colspan=2 class=xl50 style='height:27.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl51 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl52 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl43 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 colspan=2 class=xl34 style='height:23.25pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl76>                                                                                                       </td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  315'>
  <td class=xl36>Repairer by</td>
  <td class=xl36></td>
  <td colspan=3 class=xl37></td>
  <td class=xl37></td>
  <td colspan=2 class=xl36></td>
  <td colspan=3 class=xl36>General Director</td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  330'>
  <td class=xl38>(Sign, Fullname)</td>
  <td class=xl38></td>
  <td colspan=2 class=xl38></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td class=xl35></td>
  <td colspan=3 class=xl77 x:str="(Sign, Fullname, Stamp)"><span
  style='mso-spacerun:yes'> </span>(Sign, Fullname, Stamp)<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  300'>
  <td height=0 colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  300'>
  <td height=0 colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  300'>
  <td height=0 colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  300'>
  <td height=0 colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  300'>
  <td class=xl39>NGUYỄN THỊ HỒNG DUYÊN</td>
  <td class=xl39></td>
  <td colspan=2 class=xl39></td>
  <td colspan=2 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl39></td>
  <td class=xl40></td>
  <td colspan=3 class=xl78 x:str="GO HAK JAE"><span
  style='mso-spacerun:yes'> </span>GO HAK JAE<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  300'>
  <td height=0 colspan=2 class=xl36 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none'>
  <td height=0 colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl42></td>
  <td class=xl42></td>
  <td colspan=8 class=xl43 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none'>
  <td class=xl42>Nguyễn Thị Hồng Duyên</td>
  <td class=xl42></td>
  <td colspan=3 class=xl42>Dương Ngọc Thiên Nga</td>
  <td class=xl42></td>
  <td colspan=8 class=xl43 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=375 style='width:281pt'></td>
  <td width=120 style='width:90pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=146 style='width:110pt'></td>
  <td width=146 style='width:110pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=333 style='width:250pt'></td>
  <td width=158 style='width:119pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=137 style='width:103pt'></td>
  <td width=137 style='width:103pt'></td>
  <td width=0></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
