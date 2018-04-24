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
    string p_com = "" + Request["com"];
    string p_month = "" + Request["yyyymm"];
    string p_status = "" + Request["status"];
    
    string yyyy = p_month.Substring(0,4);
    string mm = p_month.Substring(4,2);
    string lname ="";
    string name ="";
    string tax_code ="";
    string addr1 ="";
    string addr2 ="";
    string addr3 ="";
    string fax ="";
    string phone="";
    string email="";
    float item11 = 0;
    float item12 = 0;
    float item13 = 0;
    float item14 = 0;
    float item15 = 0;
    float item16 = 0;
    float item17 = 0;
    float item18 = 0;
    float item19 = 0;
    float item20 = 0;
    float item21 = 0;
    float item22 = 0;
    float item23 = 0;
    float item24 = 0;
    float item25 = 0;
    float item26 = 0;
    float item27 = 0;
    float item28 = 0;
    float item29 = 0;
    float item30 = 0;
    float item31 = 0;
    float item32 = 0;
    float item33 = 0;
    float item34 = 0;
    float item35 = 0;
    float item36 = 0;
    float item37 = 0;
    float item38 = 0;
    float item39 = 0;
    float item40 = 0;
    float item41 = 0;
    float item42 = 0;
    float item43 = 0;
    
    string SQLC = " SELECT pk, partner_name, partner_lname, addr1, addr2,addr3, tax_code,FAX_NO,PHONE_NO,EMAIL_ADDRESS ";
    SQLC += "  FROM tco_company ";
    SQLC += " WHERE del_if = 0 AND pk = '" + p_com + "'";
    DataTable dtCom = ESysLib.TableReadOpen(SQLC);
    if (dtCom.Rows.Count >0)
    {
		name  = dtCom.Rows[0][1].ToString();
		lname = dtCom.Rows[0][2].ToString();
		addr1 = dtCom.Rows[0][3].ToString();
		addr2 = dtCom.Rows[0][4].ToString();
		addr3 = dtCom.Rows[0][5].ToString();
		tax_code = dtCom.Rows[0][6].ToString();
		fax = dtCom.Rows[0][7].ToString();
		phone = dtCom.Rows[0][8].ToString();
		email= dtCom.Rows[0][9].ToString();
	}
    
    string SQL = " SELECT 'I.1.a' stt, NVL (SUM (net_amt), 0) net_amt,  NVL (SUM (tax_amt), 0) tax_amt ";
        SQL +="  FROM tac_mtvat ";
        SQL +=" WHERE del_if = 0 AND vat_type = '1' ";
        SQL +="   AND tco_company_pk = '" + p_com + "'";
        SQL +="   AND std_ym = '" + p_month + "' ";
        SQL +="   AND tr_status IN ('0', '" + p_status + "') ";
        SQL +="   AND NVL (tr_type, 'DO') = 'DO' ";
        SQL +="UNION ALL ";
        SQL +="SELECT 'I.1.b' stt, NVL (SUM (net_amt), 0) net_amt, NVL (SUM (tax_amt), 0) tax_amt ";
        SQL +="  FROM tac_mtvat ";
        SQL +=" WHERE del_if = 0 AND vat_type = '1' ";
        SQL +="   AND tco_company_pk = '" + p_com + "' ";
        SQL +="   AND std_ym = '" + p_month + "' ";
        SQL +="   AND tr_status IN ('0', '" + p_status + "') ";
        SQL +="   AND NVL (tr_type, 'DO') = 'OS' ";
        SQL +="UNION ALL ";
        SQL +="SELECT 'II.11' stt, NVL (SUM (net_amt), 0) net_amt,  NVL (SUM (tax_amt), 0) tax_amt ";
        SQL +="  FROM tac_mtvat ";
        SQL +=" WHERE del_if = 0 AND vat_type = '2' ";
        SQL +="   AND tco_company_pk = '" + p_com + "' ";
        SQL +="   AND std_ym = '" + p_month + "' ";
        SQL +="   AND tr_status IN ('0', '" + p_status + "') ";
        SQL +="   AND tax_rate = 'none' ";
        SQL +="UNION ALL ";
        SQL +="SELECT 'II.12.a' stt, NVL (SUM (net_amt), 0) net_amt, NVL (SUM (tax_amt), 0) tax_amt ";
        SQL +="  FROM tac_mtvat ";
        SQL +=" WHERE del_if = 0 AND vat_type = '2' ";
        SQL +="   AND tco_company_pk = '" + p_com + "' ";
        SQL +="   AND std_ym = '" + p_month + "' ";
        SQL +="   AND tr_status IN ('0', '" + p_status + "') ";
        SQL +="   AND tax_rate = '0%' ";
        SQL +="UNION ALL ";
        SQL +="SELECT 'II.12.b' stt, NVL (SUM (net_amt), 0) net_amt, NVL (SUM (tax_amt), 0) tax_amt ";
        SQL +="  FROM tac_mtvat ";
        SQL +=" WHERE del_if = 0  AND vat_type = '2' ";
        SQL +="   AND tco_company_pk = '" + p_com + "' ";
        SQL +="   AND std_ym = '" + p_month + "' ";
        SQL +="   AND tr_status IN ('0', '" + p_status + "') ";
        SQL +="   AND tax_rate = '5%' ";
        SQL +="UNION ALL ";
        SQL +="SELECT 'II.12.c' stt, NVL (SUM (net_amt), 0) net_amt, NVL (SUM (tax_amt), 0) tax_amt ";
        SQL +="  FROM tac_mtvat ";
        SQL +=" WHERE del_if = 0 AND vat_type = '2' ";
        SQL +="   AND tco_company_pk = '" + p_com + "' ";
        SQL +="   AND std_ym = '" + p_month + "' ";
        SQL +="   AND tr_status IN ('0', '" + p_status + "') ";
        SQL +="   AND tax_rate = '10%' ";
        
    DataTable dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count >0)
    {
        item14 = float.Parse(dt.Rows[0][1].ToString());
        item15 = float.Parse(dt.Rows[0][2].ToString());
        item16 = float.Parse(dt.Rows[1][1].ToString());
        item17 = float.Parse(dt.Rows[1][2].ToString());
        item26 = float.Parse(dt.Rows[2][1].ToString());
        item29 = float.Parse(dt.Rows[3][1].ToString());
        item30 = float.Parse(dt.Rows[4][1].ToString());
        item31 = float.Parse(dt.Rows[4][2].ToString());
        item32 = float.Parse(dt.Rows[5][1].ToString());
        item33 = float.Parse(dt.Rows[5][2].ToString());
    }
    item12 = item14 + item16;
    item13 = item15 + item17;
    item22 = item13 + item19 - item21;
    item23 = item22;
    item24 = item26 + item27;
    item27 = item29 + item30 + item32;
    item28 = item31 + item33;
    item25 = item28;
    item38 = item24 + item34 - item36;
    item39 = item25 + item35 - item37;
    item40 = item39 - item22 - item11;
    item41 = item39 - item23 - item11;
    item43 = item41 - item42;
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gflv00030_VAT_Sum_VN_files/filelist.xml">
<link rel=Edit-Time-Data href="gflv00030_VAT_Sum_VN_files/editdata.mso">
<link rel=OLE-Object-Data href="gflv00030_VAT_Sum_VN_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2008-08-12T09:31:22Z</o:LastPrinted>
  <o:Created>2008-08-12T07:21:18Z</o:Created>
  <o:LastSaved>2008-08-13T01:21:47Z</o:LastSaved>
  <o:Company>GENUWIN</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.08in .25in 1.0in .75in;
	mso-header-margin:.17in;
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl56
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl57
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl64
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
	border-left:none;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl66
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl69
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>90</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
       <x:RangeSelection>$H$12:$I$12</x:RangeSelection>
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
  <x:WindowHeight>9360</x:WindowHeight>
  <x:WindowWidth>19035</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=712 style='border-collapse:
 collapse;table-layout:fixed;width:535pt'>
 <col class=xl24 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col class=xl24 width=137 style='mso-width-source:userset;mso-width-alt:5010;
 width:103pt'>
 <col class=xl24 width=29 style='mso-width-source:userset;mso-width-alt:1060;
 width:22pt'>
 <col class=xl24 width=152 style='mso-width-source:userset;mso-width-alt:5558;
 width:114pt'>
 <col class=xl24 width=35 style='mso-width-source:userset;mso-width-alt:1280;
 width:26pt'>
 <col class=xl24 width=36 style='mso-width-source:userset;mso-width-alt:1316;
 width:27pt'>
 <col class=xl24 width=125 style='mso-width-source:userset;mso-width-alt:4571;
 width:94pt'>
 <col class=xl24 width=34 style='mso-width-source:userset;mso-width-alt:1243;
 width:26pt'>
 <col class=xl24 width=131 style='mso-width-source:userset;mso-width-alt:4790;
 width:98pt'>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 rowspan=4 height=74 class=xl66 width=199 style='height:55.5pt;
  width:150pt'>M&#7851;u s&#7889;: 01/GTGT<span
  style='mso-spacerun:yes'>                                 </span>(Ban hành
  kèm theo Thông t&#432; s&#7889; 60/2007/TT-BTC ngày 14/6/2007 c&#7911;a
  B&#7897; tài Chính)</td>
  <td colspan=6 class=xl68 width=513 style='width:385pt'>C&#7896;NG HÒA XÃ
  H&#7896;I CH&#7910; NGH&#296;A VI&#7878;T NAM</td>
 </tr>
 <tr class=xl25 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td colspan=6 height=18 class=xl47 style='height:13.5pt'>&#272;&#7897;c
  l&#7853;p - T&#7921; do - H&#7841;nh phúc</td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=6 class=xl24 style='height:7.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=6 height=25 class=xl69 style='height:18.75pt'>T&#7900; KHAI
  THU&#7870; GIÁ TR&#7882; GIA T&#258;NG (GTGT)</td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=3 class=xl25 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl47>[01] K&#7923; tính thu&#7871;: tháng <%=mm %> n&#259;m
  <%=yyyy %></td>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 colspan=9 class=xl24 style='height:6.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'>[02] Ng&#432;&#7901;i
  n&#7897;p thu&#7871;:</td>
  <td colspan=6 class=xl67><%=lname%></td>
 </tr>
 <tr class=xl25 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl25 style='height:13.5pt'></td>
  <td class=xl27 x:str="[03] Mã s&#7889; thu&#7871;: ">[03] Mã s&#7889;
  thu&#7871;:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl27></td>
  <td colspan=3 class=xl67><%=tax_code %></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl25 style='height:14.25pt'></td>
  <td class=xl25>[04] &#272;&#7883;a ch&#7881; tr&#7909; s&#7903;:</td>
  <td class=xl25></td>
  <td colspan=6 class=xl65><%=addr1 %></td>
 </tr>
 <tr class=xl25 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl25 style='height:13.5pt'></td>
  <td class=xl25>[05] Qu&#7853;n/huy&#7879;n:</td>
  <td class=xl25></td>
  <td colspan=2 class=xl65><%=addr2 %></td>
  <td class=xl25></td>
  <td class=xl25>[06] T&#7881;nh/Thành ph&#7889;:</td>
  <td colspan=2 class=xl65><%=addr3 %></td>
 </tr>
 <tr class=xl25 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'></td>
  <td class=xl25>[07] &#272;i&#7879;n tho&#7841;i:</td>
  <td class=xl25></td>
  <td colspan=2 class=xl65 x:num><%=phone %></td>
  <td class=xl25></td>
  <td class=xl25>[08] Email: </td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'><%=email %></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=6 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl43>&#272;&#417;n v&#7883; ti&#7873;n:</td>
  <td colspan=2 class=xl54>&#272;&#7891;ng Vi&#7879;t Nam</td>
 </tr>
 <tr class=xl25 height=41 style='mso-height-source:userset;height:30.75pt'>
  <td height=41 class=xl26 width=33 style='height:30.75pt;width:25pt'>STT</td>
  <td colspan=4 class=xl26 width=353 style='border-left:none;width:265pt'>Ch&#7881;
  tiêu</td>
  <td colspan=2 class=xl26 width=161 style='border-left:none;width:121pt'>Giá
  tr&#7883; HHDV<span style='mso-spacerun:yes'>                
  </span>(Ch&#432;a có thu&#7871;)</td>
  <td colspan=2 class=xl26 width=165 style='border-left:none;width:124pt'>Thu&#7871;
  GTGT</td>
 </tr>
 <tr class=xl28 height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl26 width=33 style='height:25.5pt;border-top:none;
  width:25pt'>A</td>
  <td colspan=3 class=xl62 width=318 style='border-left:none;width:239pt'>Không
  phát sinh ho&#7841;t &#273;&#7897;ng mua bán trong k&#7923; (&#273;ánh
  d&#7845;u &quot;X&quot;)</td>
  <td class=xl26 width=35 style='border-top:none;border-left:none;width:26pt'>[10]</td>
  <td colspan=2 class=xl63 width=161 style='border-right:.5pt solid black;
  border-left:none;width:121pt'>&nbsp;</td>
  <td colspan=2 class=xl63 width=165 style='border-right:.5pt solid black;
  border-left:none;width:124pt'>&nbsp;</td>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl32 width=33 style='height:16.5pt;border-top:none;
  width:25pt'>B</td>
  <td colspan=4 class=xl58 width=353 style='width:265pt'>Thu&#7871; GTGT còn
  &#273;&#432;&#7907;c kh&#7845;u tr&#7915; chuy&#7875;n sang</td>
  <td class=xl31 width=36 style='border-top:none;width:27pt'>&nbsp;</td>
  <td class=xl31 width=125 style='border-top:none;width:94pt'>&nbsp;</td>
  <td class=xl32 width=34 style='border-top:none;width:26pt'>[11]</td>
  <td class=xl36 width=131 style='border-top:none;width:98pt' x:num><span
  style='mso-spacerun:yes'>                          </span></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl33 style='height:15.0pt;border-top:none'>C</td>
  <td colspan=8 class=xl48 style='border-right:.5pt solid black'>Kê khai
  thu&#7871; GTGT ph&#7843;i n&#7897;p Ngân sách nhà n&#432;&#7899;c</td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl45 style='height:17.25pt;border-top:none'>I</td>
  <td colspan=8 class=xl51 style='border-left:none'>Hàng hóa, d&#7883;ch
  v&#7909; (HHDV) mua vào</td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl26 width=33 style='height:17.25pt;border-top:none;
  width:25pt' x:num>1</td>
  <td colspan=4 class=xl59 width=353 style='border-right:.5pt solid black;
  border-left:none;width:265pt'>Hàng hóa, d&#7883;ch v&#7909; (HHDV) mua vào
  trong k&#7923;</td>
  <td class=xl26 width=36 style='border-top:none;border-left:none;width:27pt'>[12]</td>
  <td class=xl37 width=125 style='border-top:none;border-left:none;width:94pt'
  x:num><span style='mso-spacerun:yes'>                         </span><%=item12%></td>
  <td class=xl26 width=34 style='border-top:none;border-left:none;width:26pt'>[13]</td>
  <td class=xl37 width=131 style='border-top:none;border-left:none;width:98pt'
  x:num><span style='mso-spacerun:yes'>                          </span><%=item13%></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl39 style='height:17.25pt;border-top:none'>a</td>
  <td colspan=4 class=xl57 style='border-left:none'>Hàng hóa, d&#7883;ch
  v&#7909; mua vào trong n&#432;&#7899;c</td>
  <td class=xl26 width=36 style='border-top:none;border-left:none;width:27pt'>[14]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                         </span><%=item14 %></td>
  <td class=xl26 width=34 style='border-top:none;border-left:none;width:26pt'>[15]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                          </span><%=item15 %></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl39 style='height:17.25pt;border-top:none'>b</td>
  <td colspan=4 class=xl57 style='border-left:none'>Hàng hóa, d&#7883;ch
  v&#7909; nh&#7853;p kh&#7849;u</td>
  <td class=xl26 width=36 style='border-top:none;border-left:none;width:27pt'>[16]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                         </span><%=item16%></td>
  <td class=xl26 width=34 style='border-top:none;border-left:none;width:26pt'>[17]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                          </span><%=item17%></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl34 style='height:17.25pt;border-top:none' x:num>2</td>
  <td colspan=8 class=xl53 style='border-left:none'>&#272;i&#7873;u ch&#7881;nh
  thu&#7871; GTGT c&#7911;a HHDV mua vào các k&#7923; tr&#432;&#7899;c</td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt;border-top:none'>a</td>
  <td colspan=4 class=xl57 style='border-left:none'><span
  style='mso-spacerun:yes'>        </span>&#272;i&#7873;u ch&#7881;nh t&#259;ng</td>
  <td class=xl26 width=36 style='border-top:none;border-left:none;width:27pt'>[18]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span style='mso-spacerun:yes'></span><%=item18%></td>
  <td class=xl26 width=34 style='border-top:none;border-left:none;width:26pt'>[19]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span style='mso-spacerun:yes'></span><%=item19%></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl39 style='height:17.25pt;border-top:none'>b</td>
  <td colspan=4 class=xl57 style='border-left:none'><span
  style='mso-spacerun:yes'>        </span>&#272;i&#7873;u ch&#7881;nh
  gi&#7843;m</td>
  <td class=xl26 width=36 style='border-top:none;border-left:none;width:27pt'>[20]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                         </span><%=item20%></td>
  <td class=xl26 width=34 style='border-top:none;border-left:none;width:26pt'>[21]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span style='mso-spacerun:yes'></span><%=item21%></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl33 style='height:17.25pt;border-top:none' x:num>3</td>
  <td colspan=4 class=xl49>T&#7893;ng s&#7889; thu&#7871; GTGT c&#7911;a HHDV
  mua vào</td>
  <td class=xl40 style='border-top:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none'>&nbsp;</td>
  <td class=xl26 width=34 style='border-top:none;border-left:none;width:26pt'>[22]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                          </span><%=item22%></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl33 style='height:17.25pt;border-top:none' x:num>4</td>
  <td colspan=4 class=xl49>T&#7893;ng s&#7889; thu&#7871; GTGT
  &#273;&#432;&#7907;c kh&#7845;u tr&#7915; k&#7923; này</td>
  <td class=xl40 style='border-top:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none'>&nbsp;</td>
  <td class=xl26 width=34 style='border-top:none;border-left:none;width:26pt'>[23]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                          </span><%=item23%></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl45 style='height:17.25pt;border-top:none'>II</td>
  <td colspan=8 class=xl50>Hàng hóa, d&#7883;ch v&#7909; bán ra</td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl34 style='height:17.25pt;border-top:none' x:num>1</td>
  <td colspan=4 class=xl52>Hàng hóa, d&#7883;ch v&#7909; bán ra trong k&#7923;</td>
  <td class=xl26 width=36 style='border-top:none;border-left:none;width:27pt'>[24]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                         </span><%=item24%></td>
  <td class=xl26 width=34 style='border-top:none;border-left:none;width:26pt'>[25]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                          </span><%=item25%></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl34 style='height:17.25pt;border-top:none' x:num>1.1</td>
  <td colspan=4 class=xl48 style='border-left:none'>Hàng hóa, d&#7883;ch
  v&#7909; bán ra không ch&#7883;u thu&#7871; GTGT</td>
  <td class=xl26 width=36 style='border-top:none;width:27pt'>[26]</td>
  <td class=xl44 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>                         </span><%=item26%></td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl34 style='height:17.25pt;border-top:none' x:num>1.2</td>
  <td colspan=4 class=xl53 style='border-left:none'>Hàng hóa, d&#7883;ch
  v&#7909; bán ra ch&#7883;u thu&#7871; GTGT</td>
  <td class=xl26 width=36 style='border-top:none;border-left:none;width:27pt'>[27]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                         </span><%=item27%></td>
  <td class=xl26 width=34 style='border-top:none;border-left:none;width:26pt'>[28]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                          </span><%=item28%></td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl39 style='height:15.75pt;border-top:none'>a</td>
  <td colspan=4 class=xl57 style='border-left:none'><span
  style='mso-spacerun:yes'>   </span>Hàng hóa, d&#7883;ch v&#7909; bán ra
  ch&#7883;u thu&#7871; su&#7845;t 0%</td>
  <td class=xl26 width=36 style='border-top:none;border-left:none;width:27pt'>[29]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                         </span><%=item29%></td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl39 style='height:15.75pt;border-top:none'>b</td>
  <td colspan=4 class=xl57 style='border-left:none'><span
  style='mso-spacerun:yes'>   </span>Hàng hóa, d&#7883;ch v&#7909; bán ra
  ch&#7883;u thu&#7871; su&#7845;t 5%</td>
  <td class=xl26 width=36 style='border-top:none;border-left:none;width:27pt'>[30]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                         </span><%=item30%></td>
  <td class=xl26 width=34 style='border-top:none;border-left:none;width:26pt'>[31]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                          </span><%=item31%></td>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl39 style='height:16.5pt;border-top:none'>c</td>
  <td colspan=4 class=xl57 style='border-left:none'><span
  style='mso-spacerun:yes'>   </span>Hàng hóa, d&#7883;ch v&#7909; bán ra
  ch&#7883;u thu&#7871; su&#7845;t 10%</td>
  <td class=xl26 width=36 style='border-top:none;border-left:none;width:27pt'>[32]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                         </span><%=item32%></td>
  <td class=xl26 width=34 style='border-top:none;border-left:none;width:26pt'>[33]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                          </span><%=item33%></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl34 style='height:17.25pt;border-top:none' x:num>2</td>
  <td colspan=8 class=xl48 style='border-right:.5pt solid black;border-left:
  none'>&#272;i&#7873;u ch&#7881;nh thu&#7871; GTGT c&#7911;a HHDV bán ra các
  k&#7923; tr&#432;&#7899;c</td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt;border-top:none'>a</td>
  <td colspan=4 class=xl57 style='border-left:none'><span
  style='mso-spacerun:yes'>        </span>&#272;i&#7873;u ch&#7881;nh t&#259;ng</td>
  <td class=xl26 width=36 style='border-top:none;border-left:none;width:27pt'>[34]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                         </span><%=item34%></td>
  <td class=xl26 width=34 style='border-top:none;border-left:none;width:26pt'>[35]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                          </span><%=item35%></td>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl39 style='height:16.5pt;border-top:none'>b</td>
  <td colspan=4 class=xl57 style='border-left:none'><span
  style='mso-spacerun:yes'>        </span>&#272;i&#7873;u ch&#7881;nh
  gi&#7843;m</td>
  <td class=xl26 width=36 style='border-top:none;border-left:none;width:27pt'>[36]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                         </span><%=item36%></td>
  <td class=xl26 width=34 style='border-top:none;border-left:none;width:26pt'>[37]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                          </span><%=item37%></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl34 style='height:17.25pt;border-top:none' x:num>3</td>
  <td colspan=4 class=xl53 style='border-left:none'>T&#7893;ng doanh thu và
  thu&#7871; GTGT c&#7911;a HHDV bán ra</td>
  <td class=xl26 width=36 style='border-top:none;border-left:none;width:27pt'>[38]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                         </span><%=item38%></td>
  <td class=xl26 width=34 style='border-top:none;border-left:none;width:26pt'>[39]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                          </span><%=item39%></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl45 style='height:17.25pt;border-top:none'>III</td>
  <td colspan=8 class=xl55 style='border-right:.5pt solid black;border-left:
  none'>Xác &#273;&#7883;nh ngh&#297;a v&#7909; thu&#7871; GTGT ph&#7843;i
  n&#7897;p trong k&#7923;</td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl34 style='height:17.25pt;border-top:none' x:num>1</td>
  <td colspan=4 class=xl54>Thu&#7871; GTGT ph&#7843;i n&#7897;p trong k&#7923;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl26 width=34 style='border-top:none;width:26pt'>[40]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                          </span><%=item40%></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl34 style='height:17.25pt;border-top:none' x:num>2</td>
  <td colspan=4 class=xl48 style='border-left:none'>Thu&#7871; GTGT ch&#432;a
  kh&#7845;u tr&#7915; h&#7871;t k&#7923; này</td>
  <td class=xl40 style='border-top:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none'>&nbsp;</td>
  <td class=xl26 width=34 style='border-top:none;border-left:none;width:26pt'>[41]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                          </span><%=item41%></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl34 style='height:17.25pt;border-top:none' x:num>2.1</td>
  <td colspan=4 class=xl48 style='border-left:none'>Thu&#7871; GTGT
  &#273;&#7873; ngh&#7883; hoàn k&#7923; này</td>
  <td class=xl40 style='border-top:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none'>&nbsp;</td>
  <td class=xl26 width=34 style='border-top:none;border-left:none;width:26pt'>[42]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                          </span><%=item42%></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl34 style='height:17.25pt;border-top:none' x:num>2.2</td>
  <td colspan=4 class=xl48 style='border-left:none'>Thu&#7871; GTGT còn
  &#273;&#432;&#7907;c kh&#7845;u tr&#7915; chuy&#7875;n k&#7923; sau</td>
  <td class=xl40 style='border-top:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none'>&nbsp;</td>
  <td class=xl26 width=34 style='border-top:none;border-left:none;width:26pt'>[43]</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                          </span><%=item43%></td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl25 colspan=9 style='height:15.0pt;mso-ignore:colspan'>Tôi
  cam &#273;oan s&#7889; li&#7879;u khai trên là &#273;úng và ch&#7883;u trách
  nhi&#7879;m tr&#432;&#7899;c pháp luât v&#7873; nh&#7919;ng s&#7889;
  li&#7879;u &#273;ã khai./.</td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 colspan=4 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl46 x:str="Ngày   tháng  n&#259;m ">Ngày<span
  style='mso-spacerun:yes'>   </span>tháng<span style='mso-spacerun:yes'> 
  </span>n&#259;m<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 colspan=4 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl47>NG&#431;&#7900;I N&#7896;P THU&#7870; ho&#7863;c</td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 colspan=4 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl47>&#272;&#7840;I DI&#7878;N H&#7906;P PHÁP C&#7910;A
  NG&#431;&#7900;I N&#7896;P THU&#7870;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=33 style='width:25pt'></td>
  <td width=137 style='width:103pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=152 style='width:114pt'></td>
  <td width=35 style='width:26pt'></td>
  <td width=36 style='width:27pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=34 style='width:26pt'></td>
  <td width=131 style='width:98pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
