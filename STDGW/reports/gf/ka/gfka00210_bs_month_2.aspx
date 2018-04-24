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
<%  ESysLib.SetUser("acnt");%>
<% 
string l_kind=Request["p_kind"];  
  string l_status=Request["p_status"];
  string l_tco_company_pk=Request["p_company_pk"];
  string l_date_fr=Request["p_date_f"];
  string l_date_to=Request["p_date_t"];
  string l_date_type=Request["p_date_type"];
string l_scale=Request["p_scale"];
  string fr_dt, to_dt, l_cmp_name, l_cmp_add, l_cmp_taxcode;
  fr_dt = "";
  to_dt = "";
  l_cmp_name = "";
  l_cmp_add = "";
  l_cmp_taxcode = "";

string y = l_date_fr.Substring(0,4),y1,y2;
string m = l_date_fr.Substring(4,2),m1,m2;

if(m == "01")
{
	m1 = "12";
	y1 = (int.Parse(y) -1).ToString("0000");
}
else 
{
	m1 = (int.Parse(m) -1).ToString("00");
	y1 = y;//(int.Parse(y) -1).ToString("0000");
}

if(m1 == "01")
{
	m2 = "12";
	y2 = (int.Parse(y1) -1).ToString("0000");
}
else 
{
	m2 = (int.Parse(m1) -1).ToString("00");
	y2 = y1;//(int.Parse(y1) -1).ToString("0000");
}

  string SQL1 = " SELECT PARTNER_NAME, ADDR1, ADDR2, TAX_CODE " +
      ",to_char(to_date('" + l_date_fr + "','yyyymmdd'),'dd/mm/yyyy') fr_dt,to_char(to_date('" + l_date_to + "','yyyymmdd'),'dd/mm/yyyy') to_dt" +
    " FROM TCO_COMPANY WHERE PK = '" + l_tco_company_pk + "' ";

  DataTable dt_f = ESysLib.TableReadOpen(SQL1);
  if (dt_f.Rows.Count > 0)
  {
      l_cmp_name = dt_f.Rows[0][0].ToString();
      l_cmp_add = dt_f.Rows[0][1].ToString();
      l_cmp_taxcode = dt_f.Rows[0][3].ToString();
      fr_dt = dt_f.Rows[0][4].ToString();
      to_dt = dt_f.Rows[0][5].ToString();
  }
    
      
  string l_parameter="'" + l_kind + "','" + l_status + "','" + l_tco_company_pk + "','" + l_date_fr + "','" + l_date_to + "','" + l_date_type + "','" + l_scale +"'";
  string sp="ACNT.SP_SEL_GRD_FINANCE_STATEMENT3";
	//Response.Write(sp + l_parameter);
    //Response.End();
  DataTable dt = ESysLib.TableReadOpenCursor(sp,l_parameter);  
  if (dt.Rows.Count==0)
  {
    Response.Write("There is no data");
    Response.End();
  
}
%>
<script>

</script>

<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 10">
<link rel=File-List href="gfka00120_bs_month_2_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00120_bs_month_2_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00120_bs_month_2_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Phan Huy Quoc My</o:LastAuthor>
  <o:LastPrinted>2009-04-01T01:47:38Z</o:LastPrinted>
  <o:Created>2001-09-01T01:02:36Z</o:Created>
  <o:LastSaved>2009-04-01T02:18:12Z</o:LastSaved>
  <o:Version>10.2625</o:Version>
 </o:DocumentProperties>
 <o:OfficeDocumentSettings>
  <o:DownloadComponents/>
  <o:LocationOfComponents HRef="file:///F:\"/>
 </o:OfficeDocumentSettings>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .25in .25in .25in;
	mso-header-margin:.25in;
	mso-footer-margin:0in;
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
	color:black;
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
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
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
.xl24
	{mso-style-parent:style0;
	color:aqua;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:black;
	mso-pattern:auto none;}
.xl25
	{mso-style-parent:style0;
	color:aqua;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:black;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	color:aqua;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"d\\-mmm";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"d\\-mmm";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl61
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl62
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl63
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl65
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl66
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl69
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl76
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
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
.xl79
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:1.0pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl81
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl83
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl84
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:1.0pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl87
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl88
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl90
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl92
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl93
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl95
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl96
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl97
	{mso-style-parent:style0;
	color:windowtext;
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
.xl98
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl99
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl100
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl101
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:1.0pt solid windowtext;}
.xl102
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl103
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl104
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:1.0pt solid windowtext;}
.xl105
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl106
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl107
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl108
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl109
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl110
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl111
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl112
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl113
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl114
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl115
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl116
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl117
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl118
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl119
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"d\\-mmm";
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl120
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl121
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl122
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl123
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"d\\-mmm";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl124
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl125
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl126
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl127
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl128
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl129
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	border-top:2.0pt double windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl130
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl131
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl132
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl133
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl134
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
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
.xl135
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl136
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl137
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl138
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl139
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl140
	{mso-style-parent:style0;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl141
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>cashflow analysis</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>60</x:Scale>
      <x:HorizontalResolution>-3</x:HorizontalResolution>
      <x:VerticalResolution>-3</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>12</x:TopRowVisible>
     <x:LeftColumnVisible>4</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9120</x:WindowHeight>
  <x:WindowWidth>7650</x:WindowWidth>
  <x:WindowTopX>7665</x:WindowTopX>
  <x:WindowTopY>-15</x:WindowTopY>
  <x:TabRatio>394</x:TabRatio>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl26>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1704 style='border-collapse:
 collapse;table-layout:fixed;width:1282pt'>
 <col class=xl26 width=117 span=2 style='mso-width-source:userset;mso-width-alt:
 4278;width:88pt'>
 <col class=xl26 width=121 style='mso-width-source:userset;mso-width-alt:4425;
 width:91pt'>
 <col class=xl28 width=121 span=3 style='mso-width-source:userset;mso-width-alt:
 4425;width:91pt'>
 <col class=xl26 width=121 style='mso-width-source:userset;mso-width-alt:4425;
 width:91pt'>
 <col class=xl26 width=117 span=2 style='mso-width-source:userset;mso-width-alt:
 4278;width:88pt'>
 <col class=xl28 width=121 span=4 style='mso-width-source:userset;mso-width-alt:
 4425;width:91pt'>
 <col class=xl26 width=121 style='mso-width-source:userset;mso-width-alt:4425;
 width:91pt'>
 <col class=xl26 width=26 style='mso-width-source:userset;mso-width-alt:950;
 width:20pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=2 width=234 style='height:15.75pt;
  mso-ignore:colspan;width:176pt' x:str="Cash Flow Analysis ">Cash Flow
  Analysis<span style='mso-spacerun:yes'> </span></td>
  <td class=xl26 width=121 style='width:91pt'></td>
  <td class=xl27 width=121 style='width:91pt'></td>
  <td class=xl27 width=121 style='width:91pt'></td>
  <td class=xl27 width=121 style='width:91pt'></td>
  <td class=xl26 width=121 style='width:91pt'></td>
  <td class=xl26 width=117 style='width:88pt'></td>
  <td class=xl26 width=117 style='width:88pt'></td>
  <td class=xl28 width=121 style='width:91pt'></td>
  <td class=xl28 width=121 style='width:91pt'></td>
  <td class=xl28 width=121 style='width:91pt'></td>
  <td class=xl28 width=121 style='width:91pt'></td>
  <td class=xl26 width=121 style='width:91pt'></td>
  <td class=xl26 width=26 style='width:20pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl29 colspan=2 style='height:15.75pt;mso-ignore:colspan'>1.
  Balance Sheet Comparison</td>
  <td class=xl26></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl30 align=right style='height:15.75pt' x:num><%=y%>.<%=m%></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=3 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl28 x:str></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl26>(Unit: <%=l_scale + " "%> VND)</td>
  <td class=xl26></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl118 style='height:16.5pt'>&nbsp;</td>
  <td class=xl33 style='border-left:none'>Item</td>
  <td class=xl119 style='border-left:none'><%=y2%>.<%=m2%></td>
  <td class=xl120 style='border-left:none'><%=y1%>.<%=m1%></td>
  <td class=xl120 style='border-left:none'><%=y%>.<%=m%></td>
  <td class=xl120 style='border-left:none'>variance</td>
  <td class=xl121 style='border-left:none'>variance</td>
  <td class=xl122 style='border-left:none'>&nbsp;</td>
  <td class=xl34>Item</td>
  <td class=xl123><%=y2%>.<%=m2%></td>
  <td class=xl124><%=y1%>.<%=m1%></td>
  <td class=xl124><%=y%>.<%=m%></td>
  <td class=xl125>variance</td>
  <td class=xl126>variance</td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl35 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-left:none'>A</td>
  <td class=xl38 style='border-left:none'>B</td>
  <td class=xl38 style='border-left:none'>C</td>
  <td class=xl38 style='border-left:none'>C-A</td>
  <td class=xl39 style='border-left:none'>C-D</td>
  <td class=xl40 style='border-top:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none'>&nbsp;</td>
  <td class=xl42 style='border-left:none'>A</td>
  <td class=xl43 style='border-left:none'>B</td>
  <td class=xl43 style='border-left:none'>C</td>
  <td class=xl117 style='border-left:none'>C-A</td>
  <td class=xl127>C-D</td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl44 style='height:15.75pt'><%= dt.Rows[0][0].ToString()%></td>
  <td class=xl45 style='border-left:none'>&nbsp;</td>
  <td class=xl130 style='border-left:none' x:num><%= dt.Rows[0][6].ToString()%></td>
  <td class=xl131 style='border-left:none' x:num><%= dt.Rows[0][7].ToString()%></td>
  <td class=xl131 style='border-left:none' x:num><%= dt.Rows[0][8].ToString()%></td>
  <td class=xl132 style='border-left:none' x:num><%= dt.Rows[0][9].ToString()%></td>
  <td class=xl47 align=right x:num><%= dt.Rows[0][10].ToString()%></td>
  <td class=xl48 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black'><%= dt.Rows[25][0].ToString()%></td>
  <td class=xl141 x:num><%= dt.Rows[25][6].ToString()%></td>
  <td class=xl141 x:num><%= dt.Rows[25][7].ToString()%></td>
  <td class=xl141 x:num><%= dt.Rows[25][8].ToString()%></td>
  <td class=xl132 style='border-left:none' x:num><%= dt.Rows[25][9].ToString()%></td>
  <td class=xl50 align=right style='border-top:none' x:num><%= dt.Rows[25][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl51 style='height:15.75pt;border-top:none'><%= dt.Rows[1][0].ToString()%></td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><%= dt.Rows[1][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[1][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[1][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[1][9].ToString()%></td>
  <td class=xl56 align=right x:num><%= dt.Rows[1][10].ToString()%></td>
  <td class=xl57 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black' x:str><%= dt.Rows[26][0].ToString()%></td>
  <td class=xl58 style='border-top:none;border-left:none' x:num><%= dt.Rows[26][6].ToString()%></td>
  <td class=xl58 style='border-top:none;border-left:none' x:num><%= dt.Rows[26][7].ToString()%></td>
  <td class=xl58 style='border-top:none;border-left:none' x:num><%= dt.Rows[26][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[26][9].ToString()%></td>
  <td class=xl128 align=right x:num><%= dt.Rows[26][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl51 style='height:15.75pt;border-top:none'><%= dt.Rows[2][0].ToString()%></td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><%= dt.Rows[2][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[2][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[2][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[2][9].ToString()%></td>
  <td class=xl56 align=right x:num><%= dt.Rows[1][10].ToString()%></td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none' x:str><%= dt.Rows[27][0].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'x:num><%= dt.Rows[27][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[27][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[27][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[27][9].ToString()%></td>
  <td class=xl128 align=right style='border-top:none' x:num><%= dt.Rows[27][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl51 style='height:15.75pt;border-top:none'><%= dt.Rows[3][0].ToString()%></td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-top:none;border-left:none' x:num><%= dt.Rows[3][6].ToString()%></td>
  <td class=xl58 style='border-top:none;border-left:none' x:num><%= dt.Rows[3][7].ToString()%></td>
  <td class=xl58 style='border-top:none;border-left:none' x:num><%= dt.Rows[3][8].ToString()%></td>
  <td class=xl61 style='border-left:none' x:num><%= dt.Rows[3][9].ToString()%></td>
  <td class=xl56 align=right x:num><%= dt.Rows[3][10].ToString()%></td>
  <td class=xl62 style='border-left:none'>&nbsp;</td>
  <td class=xl63 x:str><%= dt.Rows[28][0].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'x:num><%= dt.Rows[28][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'x:num><%= dt.Rows[28][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'x:num><%= dt.Rows[28][8].ToString()%></td>
  <td class=xl61 style='border-left:none' x:num><%= dt.Rows[28][9].ToString()%></td>
  <td class=xl128 align=right style='border-top:none' x:num><%= dt.Rows[28][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl64 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td class=xl65 style='border-top:none'><%= dt.Rows[4][0].ToString()%></td>
  <td class=xl53 style='border-top:none;border-left:none'x:num><%= dt.Rows[4][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[4][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[4][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[4][9].ToString()%></td>
  <td class=xl56 align=right x:num><%= dt.Rows[4][10].ToString()%></td>
  <td class=xl66 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black' x:str><%= dt.Rows[29][0].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[29][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[29][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[29][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[29][9].ToString()%></td>
  <td class=xl128 align=right style='border-top:none' x:num><%= dt.Rows[29][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl64 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td class=xl65 style='border-top:none'><%= dt.Rows[5][0].ToString()%></td>
  <td class=xl53 style='border-top:none;border-left:none'x:num><%= dt.Rows[5][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[5][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[5][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[5][9].ToString()%></td>
  <td class=xl56 align=right x:num><%= dt.Rows[5][10].ToString()%></td>
  <td class=xl66 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black' x:str><%= dt.Rows[30][0].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'><%= dt.Rows[30][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'><%= dt.Rows[30][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'><%= dt.Rows[30][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[30][9].ToString()%></td>
  <td class=xl128 align=right style='border-top:none' x:num><%= dt.Rows[30][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl64 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td class=xl65 style='border-top:none'><%= dt.Rows[6][0].ToString()%></td>
  <td class=xl53 style='border-top:none;border-left:none'x:num><%= dt.Rows[6][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[6][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[6][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[6][9].ToString()%></td>
  <td class=xl56 align=right x:num><%= dt.Rows[6][10].ToString()%></td>
  <td class=xl66 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black' x:str><%= dt.Rows[31][0].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'x:num><%= dt.Rows[31][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'x:num><%= dt.Rows[31][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'x:num><%= dt.Rows[31][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[31][9].ToString()%></td>
  <td class=xl128 align=right style='border-top:none' x:num><%= dt.Rows[31][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl64 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td class=xl65 style='border-top:none'x:num><%= dt.Rows[7][0].ToString()%></td>
  <td class=xl53 style='border-top:none;border-left:none'x:num><%= dt.Rows[7][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[7][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[7][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[7][9].ToString()%></td>
  <td class=xl56 align=right x:num><%= dt.Rows[7][10].ToString()%></td>
  <td class=xl66 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black' x:str><%= dt.Rows[32][0].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[32][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[32][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[32][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[32][9].ToString()%></td>
  <td class=xl128 align=right style='border-top:none' x:num><%= dt.Rows[32][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl64 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td class=xl65 style='border-top:none'x:num><%= dt.Rows[8][0].ToString()%></td>
  <td class=xl53 style='border-top:none;border-left:none'x:num><%= dt.Rows[8][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[8][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[8][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[8][9].ToString()%></td>
  <td class=xl56 align=right x:num><%= dt.Rows[8][10].ToString()%></td>
  <td class=xl66 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black' x:str><%= dt.Rows[33][0].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[33][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[33][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[33][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[33][9].ToString()%></td>
  <td class=xl128 align=right style='border-top:none' x:num><%= dt.Rows[33][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl64 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td class=xl65 style='border-top:none'><%= dt.Rows[9][0].ToString()%></td>
  <td class=xl53 style='border-top:none;border-left:none'x:num><%= dt.Rows[9][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[9][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[9][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[9][9].ToString()%></td>
  <td class=xl56 align=right x:num><%= dt.Rows[9][10].ToString()%></td>
  <td class=xl66 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black' x:str><%= dt.Rows[34][0].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[34][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[34][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[34][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[34][9].ToString()%></td>
  <td class=xl128 align=right style='border-top:none' x:num><%= dt.Rows[34][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl70 style='height:15.75pt'><%= dt.Rows[10][0].ToString()%></td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'x:num><%= dt.Rows[10][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[10][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[10][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[10][9].ToString()%></td>
  <td class=xl56 align=right x:num><%= dt.Rows[10][10].ToString()%></td>
  <td class=xl66 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black' x:str><%= dt.Rows[35][0].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[35][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[35][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[35][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[35][9].ToString()%></td>
  <td class=xl128 align=right style='border-top:none' x:num><%= dt.Rows[35][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl70 style='height:15.75pt'><%= dt.Rows[11][0].ToString()%></td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'x:num><%= dt.Rows[11][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[11][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[11][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[11][9].ToString()%></td>
  <td class=xl56 align=right x:num><%= dt.Rows[11][10].ToString()%></td>
  <td class=xl66 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black' x:str><%= dt.Rows[36][0].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[36][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[36][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[36][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[36][9].ToString()%></td>
  <td class=xl128 align=right style='border-top:none' x:num><%= dt.Rows[36][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl70 style='height:15.75pt'><%= dt.Rows[12][0].ToString()%></td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'x:num><%= dt.Rows[12][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[12][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[12][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[12][9].ToString()%></td>
  <td class=xl56 align=right x:num><%= dt.Rows[12][10].ToString()%></td>
  <td class=xl66 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black' x:str><%= dt.Rows[37][0].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[37][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[37][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[37][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[37][9].ToString()%></td>
  <td class=xl128 align=right style='border-top:none' x:num><%= dt.Rows[37][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl79 colspan=2 style='height:16.5pt;mso-ignore:colspan;
  border-right:.5pt solid black'><%= dt.Rows[13][0].ToString()%></td>
  <td class=xl53 style='border-top:none;border-left:none'x:num><%= dt.Rows[13][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[13][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[13][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[13][9].ToString()%></td>
  <td class=xl56 align=right x:num><%= dt.Rows[13][10].ToString()%></td>
  <td class=xl66 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black' x:str><%= dt.Rows[38][0].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[38][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[38][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%= dt.Rows[38][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[38][9].ToString()%></td>
  <td class=xl128 align=right style='border-top:none' x:num><%= dt.Rows[38][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl88 style='height:16.5pt;border-top:none'><%= dt.Rows[14][0].ToString()%></td>
  <td class=xl89>&nbsp;</td>
  <td class=xl130 style='border-left:none' x:num><%= dt.Rows[14][6].ToString()%></td>
  <td class=xl131 style='border-left:none' x:num><%= dt.Rows[14][7].ToString()%></td>
  <td class=xl131 style='border-left:none' x:num><%= dt.Rows[14][8].ToString()%></td>
  <td class=xl132 style='border-left:none' x:num><%= dt.Rows[14][9].ToString()%></td>
  <td class=xl50 align=right x:num><%= dt.Rows[14][10].ToString()%></td>
  <td class=xl90 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black' x:str><%= dt.Rows[39][0].ToString()%></td>
  <td class=xl92 style='border-top:none' x:num><%= dt.Rows[39][6].ToString()%></td>
  <td class=xl92 style='border-top:none' x:num><%= dt.Rows[39][7].ToString()%></td>
  <td class=xl92 style='border-top:none' x:num><%= dt.Rows[39][8].ToString()%></td>
  <td class=xl46 style='border-left:none' x:num><%= dt.Rows[39][9].ToString()%></td>
  <td class=xl129 align=right style='border-top:none' x:num><%= dt.Rows[39][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl93 style='height:15.75pt'><%= dt.Rows[15][0].ToString()%></td>
  <td class=xl72>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'x:num><%= dt.Rows[15][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'x:num><%= dt.Rows[15][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'x:num><%= dt.Rows[15][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[15][9].ToString()%></td>
  <td class=xl56 align=right x:num><%= dt.Rows[15][10].ToString()%></td>
  <td class=xl57 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black' x:str><%= dt.Rows[40][0].ToString()%></td>
  <td class=xl68 style='border-top:none' x:num><%= dt.Rows[40][6].ToString()%></td>
  <td class=xl68 style='border-top:none' x:num><%= dt.Rows[40][7].ToString()%></td>
  <td class=xl68 style='border-top:none' x:num><%= dt.Rows[40][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[40][9].ToString()%></td>
  <td class=xl128 align=right style='border-top:none' x:num><%= dt.Rows[40][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl93 style='height:15.75pt'><%= dt.Rows[16][0].ToString()%></td>
  <td class=xl72>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'x:num><%= dt.Rows[16][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'x:num><%= dt.Rows[16][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'x:num><%= dt.Rows[16][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[16][9].ToString()%></td>
  <td class=xl56 align=right x:num><%= dt.Rows[16][10].ToString()%></td>
  <td class=xl57 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black' x:str><%= dt.Rows[41][0].ToString()%></td>
  <td class=xl68 style='border-top:none' x:num><%= dt.Rows[41][6].ToString()%></td>
  <td class=xl68 style='border-top:none' x:num><%= dt.Rows[41][7].ToString()%></td>
  <td class=xl68 style='border-top:none' x:num><%= dt.Rows[41][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[41][9].ToString()%></td>
  <td class=xl128 align=right style='border-top:none' x:num><%= dt.Rows[41][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl93 style='height:15.75pt'><%= dt.Rows[17][0].ToString()%></td>
  <td class=xl72>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'x:num><%= dt.Rows[17][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'x:num><%= dt.Rows[17][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'x:num><%= dt.Rows[17][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[17][9].ToString()%></td>
  <td class=xl56 align=right x:num><%= dt.Rows[17][10].ToString()%></td>
  <td class=xl48 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black' x:str><%= dt.Rows[42][0].ToString()%></td>
  <td class=xl141 x:num><%= dt.Rows[42][6].ToString()%></td>
  <td class=xl141 x:num><%= dt.Rows[42][7].ToString()%></td>
  <td class=xl141 x:num><%= dt.Rows[42][8].ToString()%></td>
  <td class=xl137 style='border-left:none' x:num><%= dt.Rows[42][9].ToString()%></td>
  <td class=xl138 align=right style='border-top:none' x:num><%= dt.Rows[42][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl93 style='height:15.75pt'><%= dt.Rows[18][0].ToString()%></td>
  <td class=xl72>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'x:num><%= dt.Rows[18][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'x:num><%= dt.Rows[18][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'x:num><%= dt.Rows[18][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[18][9].ToString()%></td>
  <td class=xl56 align=right x:num><%= dt.Rows[18][10].ToString()%></td>
  <td class=xl95 style='border-left:none' x:str><%= dt.Rows[43][0].ToString()%></td>
  <td class=xl96 x:num></td>
  <td class=xl97 x:num><%= dt.Rows[43][6].ToString()%></td>
  <td class=xl97 x:num><%= dt.Rows[43][7].ToString()%></td>
  <td class=xl97 x:num><%= dt.Rows[43][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[43][9].ToString()%></td>
  <td class=xl128 align=right style='border-top:none' x:num><%= dt.Rows[43][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl93 style='height:15.75pt'><%= dt.Rows[19][0].ToString()%></td>
  <td class=xl72>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'x:num><%= dt.Rows[19][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'x:num><%= dt.Rows[19][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'x:num><%= dt.Rows[19][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[19][9].ToString()%></td>
  <td class=xl56 align=right x:num><%= dt.Rows[19][10].ToString()%></td>
  <td class=xl66 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black' x:str><%= dt.Rows[44][0].ToString()%></td>
  <td class=xl54 style='border-left:none' x:num><%= dt.Rows[44][6].ToString()%></td>
  <td class=xl54 style='border-left:none' x:num><%= dt.Rows[44][7].ToString()%></td>
  <td class=xl54 style='border-left:none' x:num><%= dt.Rows[44][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[44][9].ToString()%></td>
  <td class=xl128 align=right style='border-top:none' x:num><%= dt.Rows[44][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl93 style='height:15.75pt'><%= dt.Rows[20][0].ToString()%></td>
  <td class=xl72>&nbsp;</td>
  <td class=xl53 style='border-left:none'x:num><%= dt.Rows[20][6].ToString()%></td>
  <td class=xl54 style='border-left:none'x:num><%= dt.Rows[20][7].ToString()%></td>
  <td class=xl54 style='border-left:none'x:num><%= dt.Rows[20][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[20][9].ToString()%></td>
  <td class=xl56 align=right x:num><%= dt.Rows[20][10].ToString()%></td>
  <td class=xl66 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black' x:str><%= dt.Rows[45][0].ToString()%></td>
  <td class=xl54 style='border-left:none' x:num><%= dt.Rows[45][6].ToString()%></td>
  <td class=xl54 style='border-left:none' x:num><%= dt.Rows[45][7].ToString()%></td>
  <td class=xl54 style='border-left:none' x:num><%= dt.Rows[45][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[45][9].ToString()%></td>
  <td class=xl128 align=right style='border-top:none' x:num><%= dt.Rows[45][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl93 style='height:15.75pt'><%= dt.Rows[21][0].ToString()%></td>
  <td class=xl72>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'x:num><%= dt.Rows[21][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'x:num><%= dt.Rows[21][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'x:num><%= dt.Rows[21][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[21][9].ToString()%></td>
  <td class=xl56 align=right x:num><%= dt.Rows[21][10].ToString()%></td>
  <td class=xl48 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black' x:str><%= dt.Rows[46][0].ToString()%></td>
  <td class=xl136 ><%= dt.Rows[46][6].ToString()%></td>
  <td class=xl136 x:num><%= dt.Rows[46][7].ToString()%></td>
  <td class=xl136 x:num><%= dt.Rows[46][8].ToString()%></td>
  <td class=xl137 style='border-left:none' x:num><%= dt.Rows[46][9].ToString()%></td>
  <td class=xl138 align=right style='border-top:none' x:num><%= dt.Rows[46][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl99 style='height:15.75pt'><%= dt.Rows[22][0].ToString()%></td>
  <td class=xl72>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'x:num><%= dt.Rows[22][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'x:num><%= dt.Rows[22][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'x:num><%= dt.Rows[22][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[2][9].ToString()%></td>
  <td class=xl56 align=right x:num><%= dt.Rows[22][10].ToString()%></td>
  <td class=xl48 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black' x:str><%= dt.Rows[47][0].ToString()%></td>
  <td class=xl136 ><%= dt.Rows[47][6].ToString()%></td>
  <td class=xl136 x:num><%= dt.Rows[47][7].ToString()%></td>
  <td class=xl136 x:num><%= dt.Rows[47][8].ToString()%></td>
  <td class=xl137 style='border-left:none' x:num><%= dt.Rows[47][9].ToString()%></td>
  <td class=xl138 align=right style='border-top:none' x:num><%= dt.Rows[47][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=21 class=xl93 style='height:15.75pt'><%= dt.Rows[23][0].ToString()%></td>
  <td class=xl72>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'x:num><%= dt.Rows[23][6].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'x:num><%= dt.Rows[23][7].ToString()%></td>
  <td class=xl54 style='border-top:none;border-left:none'x:num><%= dt.Rows[23][8].ToString()%></td>
  <td class=xl55 style='border-left:none' x:num><%= dt.Rows[23][9].ToString()%></td>
  <td class=xl56 align=right x:num><%= dt.Rows[23][10].ToString()%></td>
  <td class=xl48 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black' x:str><%= dt.Rows[48][0].ToString()%></td>
  <td class=xl136 ><%= dt.Rows[48][6].ToString()%></td>
  <td class=xl136 x:num><%= dt.Rows[48][7].ToString()%></td>
  <td class=xl136 x:num><%= dt.Rows[48][8].ToString()%></td>
  <td class=xl137 style='border-left:none' x:num><%= dt.Rows[48][9].ToString()%></td>
  <td class=xl138 align=right style='border-top:none' x:num><%= dt.Rows[48][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl107 style='height:17.25pt'><%= dt.Rows[24][0].ToString()%></td>
  <td class=xl107>&nbsp;</td>
  <td class=xl110 x:num><%= dt.Rows[24][6].ToString()%></td>
  <td class=xl109 x:num><%= dt.Rows[24][7].ToString()%></td>
  <td class=xl109 x:num><%= dt.Rows[24][8].ToString()%></td>
  <td class=xl110 x:num><%= dt.Rows[24][9].ToString()%></td>
  <td class=xl111 align=right x:num><%= dt.Rows[24][10].ToString()%></td>
  <td class=xl112 style='border-left:none'>&nbsp;</td>
  <td class=xl113 x:str="Total"><span
  style='mso-spacerun:yes'> </span>Total<span style='mso-spacerun:yes'> </span></td>
  <td class=xl114 x:num><%= dt.Rows[49][6].ToString()%></td>
  <td class=xl109 x:num><%= dt.Rows[49][7].ToString()%></td>
  <td class=xl109 x:num><%= dt.Rows[49][8].ToString()%></td>
  <td class=xl110 x:num><%= dt.Rows[49][9].ToString()%></td>
  <td class=xl111 align=right x:num><%= dt.Rows[49][10].ToString()%></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl26 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl115></td>
  <td colspan=3 class=xl116 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl115 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl116 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=26 style='width:20pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
