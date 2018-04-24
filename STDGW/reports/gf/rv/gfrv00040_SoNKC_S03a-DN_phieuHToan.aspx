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
	string l_company = Request["Company"];
	string l_date_from = Request["DateFrom"];
	string l_date_to = Request["DateTo"];
	string l_voucher = Request["Voucher"];
	string l_Seq = Request["Seq"];
	string l_Status = Request["Status"];
	string l_bookCcy = Request["BookCcy"];

	string l_bookformat = "";
	string l_date_fr2 = "";
	string l_date_to2 = "";
	string l_report_dd = "";
	string l_report_mm = "";
	string l_report_yy = "";
	string l_total_book_amt = "0";
	string l_row_height = "15";
	string l_cmp_name="";
	string l_cmp_add ="";
	string l_cmp_taxcode="";
	
	string SQL = " SELECT PARTNER_NAME,ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + l_company + "' ";
	
	DataTable dt = ESysLib.TableReadOpen(SQL);
	if (dt.Rows.Count >0)
	{
		l_cmp_name = dt.Rows[0][0].ToString();
		l_cmp_add = dt.Rows[0][1].ToString();
		l_cmp_taxcode = dt.Rows[0][3].ToString();
	}

	
SQL = " SELECT TO_CHAR(TO_DATE('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') DT_FR,  TO_CHAR(TO_DATE('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') DT_TO, ";
SQL = SQL + "acnt.sf_get_format('ACBG0040'), TO_CHAR(LAST_DAY(TO_DATE('" + l_date_to + "','YYYYMMDD')),'DD')  RP_DD,";
SQL = SQL + " TO_CHAR(LAST_DAY(TO_DATE('" + l_date_to + "','YYYYMMDD')),'MM')  RP_MM, ";
SQL = SQL + " TO_CHAR(LAST_DAY(TO_DATE('" + l_date_to + "','YYYYMMDD')),'YYYY')  RP_YY, ";
SQL = SQL + " SF_GET_FORMAT ('ACRP0010') ";
SQL = SQL + " FROM DUAL ";

	dt = ESysLib.TableReadOpen(SQL);
	if (dt.Rows.Count >0)
	{
	    l_date_fr2 = dt.Rows[0][0].ToString();
		l_date_to2 = dt.Rows[0][1].ToString();
		l_bookformat = dt.Rows[0][2].ToString();
		l_report_dd = dt.Rows[0][3].ToString();
		l_report_mm = dt.Rows[0][4].ToString();
		l_report_yy = dt.Rows[0][5].ToString();
		l_row_height = dt.Rows[0][6].ToString();
	}
	
	if (l_row_height == "")
	{
		l_row_height= "15";
	}

	String p_xls_ccy_format ="";
    String p_xls_ccy_format_usd = "";
    if (l_bookCcy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
	
	
    SQL = " SELECT H.PK, TO_CHAR(H.TR_DATE,SF_GET_FORMAT ('ACAB0300')) TR_DATE, H.VOUCHERNO, ";
    SQL = SQL + "    SF_A_GET_ACCD(R.TAC_ABACCTCODE_PK_DR," + l_company + "),  SF_A_GET_ACCD(R.TAC_ABACCTCODE_PK_CR," + l_company + "), ";
    SQL = SQL + "    R.TR_BOOKAMT, R.REMARK , R.REMARK2 ,SF_GET_SEQ_PRINT_CONTROLITEM(H.PK) ,h.VOUCHERNO_APP ";
    SQL = SQL + "    FROM TAC_HGTRH H,  TAC_HGTRD_REF R ";
    SQL = SQL + "    WHERE H.DEL_IF = 0  ";
    SQL = SQL + "    AND R.DEL_IF = 0 ";
    SQL = SQL + "    AND H.PK = R.TAC_HGTRH_PK ";
    SQL = SQL + "    AND R.DRCR_TYPE = 'D'  ";
    SQL = SQL + "    AND H.TCO_COMPANY_PK =  " + l_company + " ";
    SQL = SQL + "    AND TO_CHAR(H.TR_DATE,'YYYYMMDD') BETWEEN '" + l_date_from + "' AND '" + l_date_to + "'   ";
    SQL = SQL + "    AND H.TR_STATUS IN (DECODE (" + l_Status + " , 2, 2, " + l_Status + "),DECODE (" + l_Status + ", 2, 0, " + l_Status + "), DECODE (" + l_Status + ", 2, 4, " + l_Status + ")) ";
    SQL = SQL + "    AND ((TRIM('" + l_voucher + "') IS NULL) OR (UPPER (h.voucherno) LIKE'%' || UPPER (TRIM('" + l_voucher + "'))|| '%'))  ";
    SQL = SQL + "    AND ((TRIM('" + l_Seq + "')  IS NULL) OR (h.pk = TRIM('" + l_Seq + "') ))  ";
    SQL = SQL + "  ORDER BY H.TR_DATE ASC,H.PK ";
     
     
	DataTable dt_detail = ESysLib.TableReadOpen(SQL);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfhg00050_SoNKC_S03a-DN_phieuHToan_files/filelist.xml">
<link rel=Edit-Time-Data
href="gfhg00050_SoNKC_S03a-DN_phieuHToan_files/editdata.mso">
<link rel=OLE-Object-Data
href="gfhg00050_SoNKC_S03a-DN_phieuHToan_files/oledata.mso">
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
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2009-04-09T07:28:32Z</o:LastPrinted>
  <o:Created>2006-06-27T06:13:13Z</o:Created>
  <o:LastSaved>2009-04-10T03:59:38Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Trang &P \/ &N";
	margin:.5in .25in .5in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style16
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
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
.xl24
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
.xl25
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
	border-left:none;}
.xl26
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
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl29
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
	border-left:.5pt solid windowtext;}
.xl30
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
.xl31
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
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
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
.xl37
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
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl39
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:left;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl57
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
.xl58
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
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl61
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl63
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
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl64
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
	border-left:none;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>S&#7893; NKC (Mau so S03a-DN) (2)</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>77</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>90</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>8</x:SplitHorizontal>
     <x:TopRowBottomPane>8</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveCol>1</x:ActiveCol>
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
  <x:Formula>='S&#7893; NKC (Mau so S03a-DN) (2)'!$A$8:$M$19</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='S&#7893; NKC (Mau so S03a-DN) (2)'!$7:$8</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl41>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1289 style='border-collapse:
 collapse;table-layout:fixed;width:968pt'>
 <col class=xl41 width=81 span=2 style='mso-width-source:userset;mso-width-alt:
 2962;width:61pt'>
 <col class=xl41 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl41 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl41 width=285 span=2 style='mso-width-source:userset;mso-width-alt:
 10422;width:214pt'>
 <col class=xl41 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:2560'>
 <col class=xl41 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl41 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:1609'>
 <col class=xl41 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl41 width=117 style='mso-width-source:userset;mso-width-alt:4278;
 width:88pt'>
 <col class=xl41 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl41 width=64 style='width:48pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl40 colspan=2 width=162 style='height:15.75pt;
  mso-ignore:colspan;width:122pt'><%= l_cmp_name %></td>
  <td class=xl41 width=103 style='width:77pt'></td>
  <td class=xl41 width=83 style='width:62pt'></td>
  <td class=xl41 width=285 style='width:214pt'></td>
  <td class=xl41 width=285 style='width:214pt'></td>
  <td class=xl41 width=0></td>
  <td class=xl42 colspan=3 width=136 style='mso-ignore:colspan;width:102pt'>M&#7851;u
  s&#7889; S03a-DN</td>
  <td class=xl43 width=117 style='width:88pt'></td>
  <td class=xl41 width=54 style='width:41pt'></td>
  <td class=xl41 width=64 style='width:48pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl44 colspan=4 style='height:15.75pt;mso-ignore:colspan'><%= l_cmp_add %></td>
  <td colspan=3 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl45
  x:str="                 (Ban hành theo Quy&#7871;t &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày "><span
  style='mso-spacerun:yes'>                 </span>(Ban hành theo Quy&#7871;t
  &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl46></td>
  <td colspan=4 class=xl46 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl44 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Mã
  s&#7889; thu&#7871;: <%= l_cmp_taxcode %></td>
  <td colspan=4 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl45>&nbsp;&nbsp;&nbsp;<span style='mso-spacerun:yes'>           
  </span>20 tháng 03 n&#259;m 2006 c&#7911;a B&#7897; tr&#432;&#7901;ng
  B&#7897; Tài chính)</td>
  <td class=xl46></td>
  <td colspan=4 class=xl46 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=13 height=30 class=xl60 style='height:22.5pt'>PHIẾU HẠCH TOÁN</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=13 height=26 class=xl45 style='height:19.5pt'>T&#7915; ngày
  <%= l_date_fr2 %> -&gt; <%= l_date_to2 %></td>
 </tr>
 <tr class=xl44 height=21 style='height:15.75pt'>
  <td height=21 colspan=10 class=xl44 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl47>&#272;&#417;n v&#7883; tính:</td>
  <td class=xl48><%= l_bookCcy%></td>
  <td class=xl44></td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt' x:str="Ngày tháng ">Ngày
  tháng<span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl61 style='border-left:none'>Ch&#7913;ng t&#7915;</td>
  <td class=xl25>Di&#7877;n gi&#7843;i</td>
  <td class=xl24>Description</td>
  <td class=xl26>&#272;ã ghi</td>
  <td colspan=3 class=xl57 style='border-right:.5pt solid black;border-left:
  none'>S&#7889; hi&#7879;u TK</td>
  <td class=xl25>S&#7889; phát sinh</td>
  <td class=xl27>Lo&#7841;i</td>
  <td class=xl24>Ghi chú</td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 class=xl29 id="_x0000_s1025" x:autofilter="all"
  x:autofilterrange="$A$8:$M$19" style='height:15.75pt'>ghi s&#7893;</td>
  <td class=xl30 id="_x0000_s1037" x:autofilter="all">S&#7889; phi&#7871;u HT</td>
  <td class=xl30 id="_x0000_s1026" x:autofilter="all">S&#7889; hi&#7879;u</td>
  <td class=xl30 id="_x0000_s1027" x:autofilter="all">Ngày</td>
  <td class=xl30 id="_x0000_s1028" x:autofilter="all">&nbsp;</td>
  <td class=xl30 id="_x0000_s1029" x:autofilter="all">&nbsp;</td>
  <td class=xl30 id="_x0000_s1030" x:autofilter="all">SC</td>
  <td class=xl31 id="_x0000_s1031" x:autofilter="all" style='border-top:none'
  x:str="N&#7907; ">N&#7907;<span style='mso-spacerun:yes'> </span></td>
  <td class=xl31 id="_x0000_s1032" x:autofilter="all" style='border-top:none'>CS</td>
  <td class=xl31 id="_x0000_s1033" x:autofilter="all" style='border-top:none'>Có</td>
  <td class=xl30 id="_x0000_s1034" x:autofilter="all"><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl32 id="_x0000_s1035" x:autofilter="all">chi phí</td>
  <td class=xl29 id="_x0000_s1036" x:autofilter="all">Seq</td>
 </tr>
 <%
	string trs_date = "";
	string trs_date_dsp = "";
	if (dt_detail.Rows.Count >0)
	{
	    for(int i=0;i<dt_detail.Rows.Count ;i++)
	    {
	    
	        if (trs_date != dt_detail.Rows[i][1].ToString() )
	        {
	            trs_date_dsp = dt_detail.Rows[i][1].ToString();
 			    trs_date = dt_detail.Rows[i][1].ToString();
	        }
	        else
	        {
	            trs_date_dsp ="";
	        }
%>  
 <tr class=xl44 height=<%= l_row_height %> style='mso-height-source:userset;'>
  <td class=xl33 x:str="<%=  trs_date_dsp%>" ><%= trs_date_dsp %></td>
  <td class=xl34 x:str><%= dt_detail.Rows[i][9].ToString() %></td>
  <td class=xl34><%= dt_detail.Rows[i][2].ToString() %></td>
  <td class=xl35 x:str="<%=  dt_detail.Rows[i][1].ToString()%>" ><%= dt_detail.Rows[i][1].ToString() %></td>
  <td class=xl36 width=285 style='width:214pt'><%= dt_detail.Rows[i][7].ToString() %></td>
  <td class=xl36 width=285 style='width:214pt'><% = dt_detail.Rows[i][6].ToString() %></td>
  <td class=xl34>X</td>
  <td class=xl34 x:num><%= dt_detail.Rows[i][3].ToString() %></td>
  <td class=xl34>2&nbsp;</td>
  <td class=xl34 x:num><%= dt_detail.Rows[i][4].ToString() %></td>
  <td class=xl37 x:num  style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" ><%= dt_detail.Rows[i][5].ToString() %></td>
  <td class=xl49><%= dt_detail.Rows[i][8].ToString() %></td>
  <td class=xl51 style='border-top:none;border-left:none' x:num><%= dt_detail.Rows[i][0].ToString() %></td>
 </tr>
 <%
	}//for
	}//if
	
SQL = "  SELECT  TO_CHAR(SUM(D.TR_BOOKAMT),'" + l_bookformat + "')    ";
SQL = SQL + "FROM TAC_HGTRH H, TAC_HGTRD D ";
SQL = SQL + "WHERE H.DEL_IF = 0   ";
SQL = SQL + "    AND D.DEL_IF = 0   ";
SQL = SQL + "    AND H.PK = D.TAC_HGTRH_PK    ";
SQL = SQL + "    AND H.TCO_COMPANY_PK = " + l_company + " ";
SQL = SQL + "    AND TO_CHAR(H.TR_DATE,'YYYYMMDD') BETWEEN '"+ l_date_from +"' AND '"+ l_date_to +"'    ";
SQL = SQL + "    AND H.TR_STATUS IN (DECODE ("+ l_Status +" , 2, 2, "+ l_Status +"),DECODE ("+ l_Status +", 2, 0, "+ l_Status +"), DECODE ("+ l_Status +", 2, 4, "+ l_Status +")) ";
SQL = SQL + "    AND D.DRCR_TYPE = 'C' ";
SQL = SQL + "    AND (('" + l_voucher +"' IS NULL) OR (UPPER (h.voucherno) LIKE'%' || UPPER ('" + l_voucher +"')|| '%')) ";
SQL = SQL + "    AND (('" + l_Seq +"'  IS NULL) OR (h.pk = '" + l_Seq +"' )) ";

SQL = " SELECT  TO_CHAR(SUM(R.TR_BOOKAMT),'" + l_bookformat + "') ";
SQL = SQL + "    FROM TAC_HGTRH H,  TAC_HGTRD_REF R ";
SQL = SQL + "    WHERE H.DEL_IF = 0  ";
SQL = SQL + "    AND R.DEL_IF = 0 ";
SQL = SQL + "    AND H.PK = R.TAC_HGTRH_PK ";
SQL = SQL + "    AND R.DRCR_TYPE = 'D'  ";
SQL = SQL + "    AND H.TCO_COMPANY_PK =  " + l_company + " ";
SQL = SQL + "    AND TO_CHAR(H.TR_DATE,'YYYYMMDD') BETWEEN '"+ l_date_from +"' AND '"+ l_date_to +"'   ";
SQL = SQL + "    AND H.TR_STATUS IN (DECODE ("+ l_Status +" , 2, 2, "+ l_Status +"),DECODE ("+ l_Status +", 2, 0, "+ l_Status +"), DECODE ("+ l_Status +", 2, 4, "+ l_Status +")) ";
SQL = SQL + "    AND ((TRIM('" + l_voucher +"') IS NULL) OR (UPPER (h.voucherno) LIKE'%' || UPPER (TRIM('" + l_voucher +"'))|| '%'))  ";
SQL = SQL + "    AND ((TRIM('" + l_Seq +"')  IS NULL) OR (h.pk = '"+l_Seq+"' ))  ";
//SQL = SQL + "  GROUP BY H.PK, H.TR_DATE, H.VOUCHERNO, R.TAC_ABACCTCODE_PK_DR, R.TAC_ABACCTCODE_PK_CR  ";
SQL = SQL + "  ORDER BY H.TR_DATE ASC,H.PK ";


dt = ESysLib.TableReadOpen(SQL);
if (dt.Rows.Count >0)
{
    l_total_book_amt = dt.Rows[0][0].ToString();
}


%>  
 <tr class=xl44 height=21 style='height:15.75pt'>
  <td colspan=9 height=21 class=xl63 width=986 style='border-right:.5pt solid black;
  height:15.75pt;width:740pt'>T&#7893;ng c&#7897;ng s&#7889; phát sinh</td>
  <td class=xl38 width=68 style='width:51pt'>&nbsp;</td>
  <td class=xl39 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" ><%= l_total_book_amt %></td>
  <td class=xl53>&nbsp;</td>
  <td class=xl54 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl55 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl45 height=21 style='height:15.75pt'>
  <td height=21 colspan=7 class=xl45 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl45>Ngày <%= l_report_dd %> tháng <%= l_report_mm %> n&#259;m <%= l_report_yy %></td>
  <td class=xl45></td>
 </tr>
 <tr class=xl45 height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl28 style='height:15.75pt'>Ng&#432;&#7901;i
  ghi s&#7893;</td>
  <td colspan=2 class=xl28>K&#7871; toán tr&#432;&#7903;ng</td>
  <td class=xl45></td>
  <td colspan=5 class=xl28>Giám &#273;&#7889;c</td>
  <td class=xl56></td>
 </tr>
 <tr class=xl45 height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl62 style='height:15.75pt'>( Ký, h&#7885; tên
  )</td>
  <td colspan=2 class=xl62>( Ký, h&#7885; tên )</td>
  <td class=xl45></td>
  <td colspan=5 class=xl62>( Ký, h&#7885; tên, &#273;óng d&#7845;u )</td>
  <td class=xl45></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl55 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl55 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl55 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl55 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl55 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=4 class=xl55 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl66></td>
  <td class=xl55></td>
  <td colspan=2 class=xl55 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl66></td>
  <td colspan=2 class=xl55 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl55 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl55 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=4 class=xl55 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl41></td>
  <td colspan=8 class=xl55 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=4 class=xl55 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl41></td>
  <td colspan=8 class=xl55 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=81 style='width:61pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=285 style='width:214pt'></td>
  <td width=285 style='width:214pt'></td>
  <td width=0></td>
  <td width=68 style='width:51pt'></td>
  <td width=0></td>
  <td width=68 style='width:51pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
