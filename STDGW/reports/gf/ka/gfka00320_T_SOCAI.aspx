<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	//string l_company_pk = "" + Request["company_pk"];
	//string l_account_pk = "" + Request["account_pk"];
	//string l_date_from	= ""+ Request["dtbFrom"];
	//string l_date_to = "" + Request["dtbTo"];
	//string l_ccy = ""+Request["ccy"];
	//string l_status = "" +Request["status"];
	//string l_book_ccy = ""+Request["bookccy"];



    string seq = "" + Request["seq"];
    string l_company_pk = "" + Request["company_pk"];
    string l_account_pk = "2047";
    string l_date_from = "" + Request["dtbFrom"];
    string l_date_to = "" + Request["dtbTo"];
    string l_ccy = "VND";
    string l_status = "2";
    string l_book_ccy = "VND";
	
	string p_cmp_name = "";
	string p_cmp_add = "";
	string p_cmp_taxcode = "";
	string p_acc_code ="";
	string p_acc_name ="";
	string p_dt_from ="";
	string p_dt_to ="";
    
	
	
	
	
	string strDate = "";
	string strDate_Dsp = "";
	string p_acc_type ="";
	
    string p_acc_num = "";

	int i =0;


    double p_numrow_head = 12;
    double p_numrow_foot = 14;
    double p_page_break = 0;
    string SQLC = "";
    
    
	String p_xls_ccy_format ="";
    String p_xls_ccy_format_usd = "";
    if (l_book_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }

    string SQL = " SELECT partner_lname, addr1, tax_code, TO_CHAR(TO_DATE(TO_CHAR('" + l_date_from + "')||'01','YYYYMMDD'),'YYYYMMDD'), TO_CHAR(LAST_DAY(TO_DATE(TO_CHAR('" + l_date_to + "')||'01','YYYYMMDD')),'YYYYMMDD')  FROM tco_company WHERE pk = '" + l_company_pk + "' ";
	
	DataTable dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count >0)
    {
        p_cmp_name = dt.Rows[0][0].ToString();
        p_cmp_add = dt.Rows[0][1].ToString();
        p_cmp_taxcode = dt.Rows[0][2].ToString();
        l_date_from = dt.Rows[0][3].ToString();
        l_date_to = dt.Rows[0][4].ToString();
        
    }

    string SQLa = "select TAC_ABACCTCODE_PK from TAC_KAFINANCEFORM where form_type ='61' and del_if = 0 and PRN_CHK ='Y' and TAC_ABACCTCODE_PK IN (" + seq + ")  ";
    DataTable da = ESysLib.TableReadOpen(SQLa);
	
	
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00020_T_SOCAI_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00020_T_SOCAI_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00020_T_SOCAI_files/oledata.mso">
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
  <o:LastPrinted>2008-05-14T08:47:53Z</o:LastPrinted>
  <o:Created>2006-06-28T09:24:54Z</o:Created>
  <o:LastSaved>2008-06-11T07:42:34Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.5in .25in .5in .75in;
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
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
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
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
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
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl44
	{mso-style-parent:style16;
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
.xl45
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl47
	{mso-style-parent:style0;
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
.xl48
	{mso-style-parent:style0;
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
.xl49
	{mso-style-parent:style16;
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
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl55
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl56
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl63
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>GL</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>90</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
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
       <x:ActiveRow>18</x:ActiveRow>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    
    
    
    <x:PageBreaks>
     <x:RowBreaks>
       <% 
            
        int i_row_break =0;
        for (int m=0; m < da.Rows.Count ;m++)
        {
	        i_row_break+=23; 
	           
                 
                 
                 
                 
             string _SQL = "SELECT   1 ";
             _SQL += " FROM (  SELECT  tac_abacctcode_pk_cr ACC_CODE, ";
             _SQL += "       SUM(r1.tr_bookamt) debit_amt, 0 credit_amt ";
             _SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref r1 ";
             _SQL += " WHERE h.del_if = 0 ";
             _SQL += "   AND r1.del_if = 0 ";
             _SQL += "   AND h.pk = r1.tac_hgtrh_pk ";
             _SQL += "   AND r1.drcr_type = 'D' ";
             _SQL += "   AND r1.tac_abacctcode_pk_dr IN (SELECT     pk       FROM tac_abacctcode     WHERE del_if = 0 AND leaf_yn = 'Y'    CONNECT BY pac_pk = PRIOR pk          START WITH pk = "+da.Rows[m][0].ToString()+" )  ";
             _SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
             _SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') ";
             _SQL += "     AND h.tco_company_pk = '" + l_company_pk + "' ";
             _SQL += "     GROUP BY  r1.tac_abacctcode_pk_cr";
             _SQL += " UNION ALL ";
             _SQL += "  SELECT  tac_abacctcode_pk_Dr ACC_CODE, ";
             _SQL += "       0 debit_amt, sum(R2.tr_bookamt) credit_amt ";
             _SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref R2 ";
             _SQL += " WHERE h.del_if = 0 ";
             _SQL += "   AND R2.del_if = 0 ";
             _SQL += "   AND h.pk = R2.tac_hgtrh_pk ";
             _SQL += "   AND R2.drcr_type = 'D' ";
             _SQL += "   AND R2.tac_abacctcode_pk_cr IN (SELECT     pk       FROM tac_abacctcode     WHERE del_if = 0 AND leaf_yn = 'Y'    CONNECT BY pac_pk = PRIOR pk          START WITH pk = "+da.Rows[m][0].ToString()+" )  ";
             _SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
             _SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') ";
             _SQL += "     AND h.tco_company_pk = '" + l_company_pk + "' ";
             _SQL += "     GROUP BY  r2.tac_abacctcode_pk_dr )a, ";
             _SQL += "          tac_abacctcode b ";
             _SQL += " WHERE a.acc_code = b.pk ";
             _SQL += " GROUP BY b.ac_cd,b.ac_nm,b.ac_knm,b.ac_lnm ";
             
             
                 
		        DataTable _dt = ESysLib.TableReadOpen(_SQL);
		        i_row_break+=_dt.Rows.Count;
        %>
              <x:RowBreak>
               <x:Row><%= i_row_break%></x:Row>
              </x:RowBreak>
        <%
        }
        %>  
     </x:RowBreaks>
    </x:PageBreaks>
    
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9150</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1365</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=GL!$A$9:$F$9</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=GL!$8:$9</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="3073"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>
<table x:str border=0 cellpadding=0 cellspacing=0 width=1032 style='border-collapse:         collapse;table-layout:fixed;width:774pt'>
         <col class=xl25 width=236 span=3 style='mso-width-source:userset;mso-width-alt:         8630;width:177pt'>
         <col class=xl25 width=76 style='mso-width-source:userset;mso-width-alt:2779;         width:57pt'>
         <col class=xl25 width=124 span=2 style='mso-width-source:userset;mso-width-alt:         4534;width:93pt'>
<%
    
    for (int t = 0; t < da.Rows.Count; t++)
    {
    string p_open_bal_dr_xls = "";
    string p_close_bal_dr_xls = "";
    string p_open_bal_cr_xls = "";
    string p_close_bal_cr_xls = ""; ;
    string p_debit_xls = "0";
    string p_credit_xls = "0";
    string p_open_bal = "0";
    string p_open_bal_xls = "0";
    string p_close_bal_xls = "0";

    l_account_pk = da.Rows[t][0].ToString();
      
    
    %>
    <%
    
        string SQL1 = " SELECT AC_CD,AC_LNM || '  (' || ac_nm ||')' ,DRCR_TYPE, to_char(to_date('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') frm_date, ";
        SQL1 += "to_char(to_date('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') t_date ,DECODE(UPPER(a.DRCR_TYPE),'D','1','-1')  ";
        SQL1 += "FROM TAC_ABACCTCODE a WHERE a.pk = '" + l_account_pk + "' ";

        DataTable dt1 = ESysLib.TableReadOpen(SQL1);
        if (dt1.Rows.Count > 0)
        {
            p_acc_code = dt1.Rows[0][0].ToString();
            p_acc_name = dt1.Rows[0][1].ToString();
            p_acc_type = dt1.Rows[0][2].ToString();
            p_dt_from = dt1.Rows[0][3].ToString();
            p_dt_to = dt1.Rows[0][4].ToString();
            p_acc_num = dt1.Rows[0][5].ToString();
        }


        SQL = " SELECT   TO_CHAR (NVL (openingbalance, 0), sf_get_format ('ACBG0040')) AS openingbalance, ";
        SQL += "               TO_CHAR (NVL (debitbookamount, 0), sf_get_format ('ACBG0040')) AS debitbookamount, ";
        SQL += "               TO_CHAR (NVL (creditbookamount, 0), sf_get_format ('ACBG0040')) AS creditbookamount, ";
        SQL += "               TO_CHAR (NVL (closingbalance, 0), sf_get_format ('ACBG0040')) AS closingbalance, ";
        SQL += "               NVL (openingbalance, 0) AS OB FROM (";
        SQL += "    SELECT TAC_ABACCTCODE_PK, SUM(openingbalance) openingbalance, SUM(debitbookamount) debitbookamount, SUM(creditbookamount) creditbookamount,  " +
            "        (SUM(openingbalance)+ (SUM(debitbookamount) - SUM(creditbookamount)) *TO_NUMBER('" + p_acc_num + "') ) closingbalance     FROM " +
            "    (SELECT TAC_ABACCTCODE_PK, 0 openingbalance, " +
            "          SUM (NVL (ymd_drbooks, 0)) debitbookamount,  " +
            "          SUM (NVL (ymd_crbooks, 0)) creditbookamount  " +
            "        FROM tac_hgddbal a  " +
            "       WHERE a.del_if = 0  " +
            "         AND a.tco_company_pk = " + l_company_pk +
            "         AND a.tac_abacctcode_pk = " + l_account_pk +
            "         AND a.tr_status = " + l_status +
            "         AND a.std_ymd BETWEEN '" + l_date_from + "' AND '" + l_date_to + "'  " +
            "    GROUP BY tac_abacctcode_pk " +
            "    UNION ALL " +
            "    SELECT TAC_ABACCTCODE_PK, (SUM(NVL(THIS_DRAMT,0))- SUM(NVL(THIS_CRAMT,0)))*TO_NUMBER('" + p_acc_num + "') openingbalance,  " +
            "    0 debitbookamount, 0 creditbookamount  " +
            "     FROM tac_hgmmbal  " +
            "     WHERE del_if = 0  " +
            "       AND tco_company_pk = " + l_company_pk + " " +
            "       AND tac_abacctcode_pk = " + l_account_pk + "  " +
            "       AND tr_status = " + l_status + "  " +
            "       AND std_ym = SUBSTR (sf_get_lastclosemm('" + l_date_from + "',' " + l_company_pk + "'),1,6)  " +
            "    group by TAC_ABACCTCODE_PK " +
            "    UNION ALL " +
            "    SELECT TAC_ABACCTCODE_PK,(SUM(NVL(YMD_DRBOOKS,0))- SUM(NVL(YMD_CRBOOKS,0)))*TO_NUMBER('" + p_acc_num + "') openingbalance, " +
            "     0 debitbookamount, 0 creditbookamount " +
            "        FROM tac_hgddbal  " +
            "      WHERE del_if = 0  " +
            "          AND tco_company_pk = '" + l_company_pk + "'  " +
            "          AND tac_abacctcode_pk = '" + l_account_pk + "'  " +
            "          AND tr_status = '" + l_status + "'  " +
            "          AND std_ymd  " +
            "               BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE (sf_get_lastclosemm('" + l_date_from + "', '" + l_company_pk + "' ),'YYYYMMDD'),+1),'YYYYMMDD')  " +
            "               AND TO_CHAR (  TO_DATE ('" + l_date_from + "','YYYYMMDD')- 1,'YYYYMMDD') " +
            "     GROUP BY TAC_ABACCTCODE_PK " +
            "     ) " +
            "     GROUP BY TAC_ABACCTCODE_PK ) ";
        DataTable dt2 = ESysLib.TableReadOpen(SQL);

        if (dt2.Rows.Count > 0)
        {
            if (p_acc_type == "D")
            {
                p_open_bal_dr_xls = dt2.Rows[0][0].ToString();
                p_close_bal_dr_xls = dt2.Rows[0][3].ToString();
            }
            else
            {
                p_open_bal_cr_xls = dt2.Rows[0][0].ToString();
                p_close_bal_cr_xls = dt2.Rows[0][3].ToString();
            }
            p_debit_xls = dt2.Rows[0][1].ToString();
            p_credit_xls = dt2.Rows[0][2].ToString();
            p_open_bal = dt2.Rows[0][4].ToString();
        }
    
         %>
        
         
         <tr height=19 style='mso-height-source:userset;height:14.25pt'>          <td colspan=3 height=19 class=xl52 width=708 style='height:14.25pt;
          width:531pt'><%= p_cmp_name%></td>
          <td colspan=3 class=xl24 width=324 style='width:243pt'><span          style='mso-spacerun:yes'> </span>M&#7851;u s&#7889; S03b-DN</td>
         </tr>
         <tr height=19 style='mso-height-source:userset;height:14.25pt'>
          <td colspan=3 height=19 class=xl53 style='height:14.25pt'><%= p_cmp_add%></td>
          <td colspan=3 class=xl54
          x:str="(Ban hành theo Quy&#7871;t &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày ">(Ban
          hành theo Quy&#7871;t &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày<span
          style='mso-spacerun:yes'> </span></td>
         </tr>
         <tr height=20 style='height:15.0pt'>
          <td colspan=3 height=20 class=xl52 style='height:15.0pt'>Tax Code:<%= p_cmp_taxcode%></td>
          <td colspan=3 class=xl54>20 tháng 03 n&#259;m 2006 c&#7911;a B&#7897;
          tr&#432;&#7901;ng B&#7897; Tài chính)</td>
         </tr>
         <tr height=30 style='height:22.5pt'>
          <td colspan=6 height=30 class=xl55 style='height:22.5pt'>S&#7892; CÁI/GENERAL
          LEDGER</td>
         </tr>
         <tr height=28 style='mso-height-source:userset;height:21.0pt'>
          <td colspan=6 height=28 class=xl26 style='height:21.0pt'>T&#7915; ngày &nbsp;
          <%= p_dt_from%> &#272;&#7871;n ngày &nbsp; &nbsp;<%= p_dt_to%></td>
         </tr>
         <tr height=20 style='mso-height-source:userset;height:15.0pt'>
          <td height=20 class=xl27 style='height:15.0pt'>S&#7889; hi&#7879;u TK<span
          style='mso-spacerun:yes'>  </span>:</td>
          <td class=xl51  colspan=3 ><%= p_acc_code%><span style='mso-spacerun:yes'>  </span><%= p_acc_name%></td>
         
          <td class=xl28>Unit:</td>
          <td class=xl28><%= l_book_ccy%></td>
         </tr>
         <tr height=8 style='mso-height-source:userset;height:6.0pt'>
          <td height=8 colspan=4 class=xl25 style='height:6.0pt;mso-ignore:colspan'></td>
          <td class=xl29></td>
          <td class=xl30></td>
         </tr>
         <tr height=8 style='mso-height-source:userset;height:6.0pt'>
          <td height=8 colspan=4 class=xl25 style='height:6.0pt;mso-ignore:colspan'></td>
          <td class=xl29></td>
          <td class=xl30></td>
         </tr>
         <tr class=xl24 height=20 style='mso-height-source:userset;height:15.0pt'>
          <td colspan=3 height=20 class=xl57 width=708 style='border-right:.5pt solid black;
          height:15.0pt;width:531pt'>Tên TK</td>
          <td rowspan=2 class=xl60 width=76 style='border-bottom:.5pt solid black;
          width:57pt'>TK &#273;&#7889;i &#7913;ng</td>
          <td colspan=2 class=xl62 style='border-right:.5pt solid black;border-left:
          none'>S&#7889; ti&#7873;n/AMOUNT</td>
         </tr>
         <tr class=xl24 height=20 style='mso-height-source:userset;height:15.0pt'>
          <td height=20 class=xl31 style='height:15.0pt'>English</td>
          <td class=xl32 >Korea</td>
          <td class=xl32 >Local</td>
          
          <td class=xl32 >N&#7907;/DEBIT</td>
          <td class=xl32 >Có/CREDIT</td>
         </tr>
         <tr height=20 style='mso-height-source:userset;height:15.0pt'>
          <td height=20 class=xl33 style='height:15.0pt'>&nbsp;</td>
          <td class=xl34>&nbsp;</td>
          <td class=xl35 width=236 style='width:177pt'>S&#7889; d&#432; &#273;&#7847;u
          k&#7923;</td>
          <td class=xl36 style='border-top:none'>&nbsp;</td>
          <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= p_open_bal_dr_xls%></td>
          <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= p_open_bal_cr_xls%></td>
         </tr>
         <%
         
             SQL = " SELECT pk FROM tac_abacctcode  WHERE del_if = 0 AND upper(leaf_yn) = 'Y'  CONNECT BY pac_pk = PRIOR pk START WITH pk = " + l_account_pk;

             DataTable dt3 = ESysLib.TableReadOpen(SQL);
             string p_acc_pk_arr = "";
             string p_temp = "";
             for (i = 0; i < dt3.Rows.Count; i++)
             {
                 p_acc_pk_arr = p_acc_pk_arr + p_temp + dt3.Rows[i][0].ToString();
                 p_temp = ",";
             }

             SQL = "SELECT   b.ac_nm,b.ac_knm,b.ac_lnm,b.ac_cd, SUM (debit_amt), SUM (credit_amt) ";
             SQL += " FROM (  SELECT  tac_abacctcode_pk_cr ACC_CODE, ";
             SQL += "       SUM(r1.tr_bookamt) debit_amt, 0 credit_amt ";
             SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref r1 ";
             SQL += " WHERE h.del_if = 0 ";
             SQL += "   AND r1.del_if = 0 ";
             SQL += "   AND h.pk = r1.tac_hgtrh_pk ";
             SQL += "   AND r1.drcr_type = 'D' ";
             SQL += "   AND r1.tac_abacctcode_pk_dr IN (" + p_acc_pk_arr + ") ";
             SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
             SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') ";
             SQL += "     AND h.tco_company_pk = '" + l_company_pk + "' ";
             SQL += "     GROUP BY  r1.tac_abacctcode_pk_cr";
             SQL += " UNION ALL ";
             SQL += "  SELECT  tac_abacctcode_pk_Dr ACC_CODE, ";
             SQL += "       0 debit_amt, sum(R2.tr_bookamt) credit_amt ";
             SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref R2 ";
             SQL += " WHERE h.del_if = 0 ";
             SQL += "   AND R2.del_if = 0 ";
             SQL += "   AND h.pk = R2.tac_hgtrh_pk ";
             SQL += "   AND R2.drcr_type = 'D' ";
             SQL += "   AND R2.tac_abacctcode_pk_cr IN (" + p_acc_pk_arr + ") ";
             SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
             SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') ";
             SQL += "     AND h.tco_company_pk = '" + l_company_pk + "' ";
             SQL += "     GROUP BY  r2.tac_abacctcode_pk_dr )a, ";
             SQL += "          tac_abacctcode b ";
             SQL += " WHERE a.acc_code = b.pk ";
             SQL += " GROUP BY b.ac_cd,b.ac_nm,b.ac_knm,b.ac_lnm ";
             SQL += " ORDER BY b.ac_cd ";
    	
        
            DataTable dt_detail = ESysLib.TableReadOpen(SQL);
            if (dt_detail.Rows.Count > 0)
            {
                for (i = 0; i < dt_detail.Rows.Count; i++)
                {
                    if (i < dt_detail.Rows.Count)
                    {
                        //'height=20 style='mso-height-source:userset;height:15.0pt'
                 %>
                 <tr >
                  <td class=xl38><%=dt_detail.Rows[i][0].ToString()%></td>
                  <td class=xl39><%=dt_detail.Rows[i][1].ToString()%></td>
                  <td class=xl39><%=dt_detail.Rows[i][2].ToString()%></td>
                  <td class=xl40 x:num><%=dt_detail.Rows[i][3].ToString()%></td>
                  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_detail.Rows[i][4].ToString()%></td>
                  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_detail.Rows[i][5].ToString()%></td>
                 </tr>
                 <% 		}
                            else
                            { %>
                 <tr >
                  <td class=xl38 style='border-bottom:.5pt solid windowtext;'><%=dt_detail.Rows[i][0].ToString()%></td>
                  <td class=xl39><%=dt_detail.Rows[i][1].ToString()%></td>
                  <td class=xl39><%=dt_detail.Rows[i][2].ToString()%></td>
                  <td class=xl40 x:num><%=dt_detail.Rows[i][3].ToString()%></td>
                  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_detail.Rows[i][4].ToString()%></td>
                  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_detail.Rows[i][5].ToString()%></td>
                 </tr>
                 <%
                    }
              }
        }
          %>
         <tr height=20 style='mso-height-source:userset;height:15.0pt'>
          <td height=20 class=xl42 style='height:15.0pt;border-top:.5pt hairline windowtext;'>&nbsp;</td>
          <td class=xl43 >&nbsp;</td>
          <td class=xl44 x:str="  C&#7897;ng s&#7889; phát sinh trong k&#7923;  "><span
          style='mso-spacerun:yes'>   </span>C&#7897;ng s&#7889; phát sinh trong
          k&#7923;<span style='mso-spacerun:yes'>   </span></td>
          <td class=xl44>&nbsp;</td>
          <td class=xl44 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= p_debit_xls%></td>
          <td class=xl44 style='border-top:none' style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= p_credit_xls%></td>
         </tr>
         <tr height=20 style='mso-height-source:userset;height:15.0pt'>
          <td height=20 class=xl45 style='height:15.0pt'>&nbsp;</td>
          <td class=xl46>&nbsp;</td>
          <td class=xl47 width=236 style='width:177pt'>S&#7889; d&#432; cu&#7889;i
          k&#7923;</td>
          <td class=xl48>&nbsp;</td>
          <td class=xl49 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= p_close_bal_dr_xls%></td>
          <td class=xl49 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= p_close_bal_cr_xls%></td>
         </tr>
         <tr height=20 style='height:15.0pt'>
          <td height=20 colspan=6 class=xl50 style='height:15.0pt;mso-ignore:colspan'></td>
         </tr>
         <tr height=20 style='height:15.0pt'>
          <td height=20 colspan=3 class=xl50 style='height:15.0pt;mso-ignore:colspan'></td>
          <td colspan=3 class=xl56>L&#7853;p, ngày <%= l_date_to.Substring(6, 2)%> tháng <%= l_date_to.Substring(4, 2)%> năm <%= l_date_to.Substring(0, 4)%></td>
         </tr>
         
         
         
         <%
    SQL = "SELECT   " +
            "    D.CODE, " +
            "    D.CHAR_1,  " +
            "    D.CHAR_2,  " +
            "    D.CHAR_3,  " +
            "    D.CHAR_4,  " +
            "    D.CHAR_5,  " +
            "    D.REMARK " +
            " FROM TAC_COMMCODE_DETAIL D, TAC_COMMCODE_MASTER M " +
            " WHERE D.DEL_IF=0 AND D.TAC_COMMCODE_MASTER_PK = M.PK " +
            " AND M.ID='EACAB012' " +
            " order by D.ORD ";
    dt1 = ESysLib.TableReadOpen(SQL);
    String e1 = "";
    String e2 = "";
    String e3 = "";
    String e4 = "";
    String e5 = "";
    String e6 = "";
    String v1 = "";
    String v2 = "";
    String v3 = "";
    String v4 = "";
    String v5 = "";
    String v6 = "";
    String g1 = "";
    String g2 = "";
    String g3 = "";
    String g4 = "";
    String g5 = "";
    String g6 = "";
    String n1 = "";
    String n2 = "";
    String n3 = "";
    String n4 = "";
    String n5 = "";
    String n6 = "";

    for (int k = 0; k < dt1.Rows.Count; k++)
    {

        string strTmp = dt1.Rows[k][0].ToString();
        if (strTmp == "ENG")
        {
            e1 = "" + dt1.Rows[k][1].ToString();
            e2 = "" + dt1.Rows[k][2].ToString();
            e3 = "" + dt1.Rows[k][3].ToString();
            e4 = "" + dt1.Rows[k][4].ToString();
            e5 = "" + dt1.Rows[k][5].ToString();
            e6 = "" + dt1.Rows[k][6].ToString();
        }

        if (strTmp == "VIE")
        {
            v1 = dt1.Rows[k][1].ToString();
            v2 = dt1.Rows[k][2].ToString();
            v3 = dt1.Rows[k][3].ToString();
            v4 = dt1.Rows[k][4].ToString();
            v5 = dt1.Rows[k][5].ToString();
            v6 = dt1.Rows[k][6].ToString();
        }
        if (strTmp == "SIG")
        {
            g1 = dt1.Rows[k][1].ToString();
            g2 = dt1.Rows[k][2].ToString();
            g3 = dt1.Rows[k][3].ToString();
            g4 = dt1.Rows[k][4].ToString();
            g5 = dt1.Rows[k][5].ToString();
            g6 = dt1.Rows[k][6].ToString();
        }

        if (strTmp == "NAM")
        {
            n1 = dt1.Rows[k][1].ToString();
            n2 = dt1.Rows[k][2].ToString();
            n3 = dt1.Rows[k][3].ToString();
            n4 = dt1.Rows[k][4].ToString();
            n5 = dt1.Rows[k][5].ToString();
            n6 = dt1.Rows[k][6].ToString();
        }
    }
 %>       
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl27 style='height:17.25pt'><%= v1 %></td>
  <td class=xl50></td>
  <td class=xl27><%= v2 %></td>
  <td colspan=3 class=xl27><%= v3 %></td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl26 style='height:17.25pt'><span
  style='mso-spacerun:yes'> </span><%= g1 %></td>
  <td class=xl50></td>
  <td class=xl26><%= g2 %></td>
  <td colspan=3 class=xl26><%= g3 %></td>
 </tr>
<tr height=23 style='height:17.25pt'>
  <td height=23 class=xl27 style='height:17.25pt'></td>
  <td class=xl50></td>
  <td class=xl27></td>
  <td colspan=3 class=xl27></td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl26 style='height:17.25pt'></td>
  <td class=xl50></td>
  <td class=xl26></td>
  <td colspan=3 class=xl26></td>
 </tr>
<tr height=23 style='height:17.25pt'>
  <td height=23 class=xl27 style='height:17.25pt'></td>
  <td class=xl50></td>
  <td class=xl27></td>
  <td colspan=3 class=xl27></td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl26 style='height:17.25pt'></td>
  <td class=xl50></td>
  <td class=xl26></td>
  <td colspan=3 class=xl26></td>
 </tr>
<tr height=23 style='height:17.25pt'>
  <td height=23 class=xl27 style='height:17.25pt'></td>
  <td class=xl50></td>
  <td class=xl27></td>
  <td colspan=3 class=xl27></td>
 </tr>
  <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl27 style='height:17.25pt'><%= n1 %></td>
  <td class=xl50></td>
  <td class=xl27><%= n2 %></td>
  <td colspan=3 class=xl27><%= n3 %></td>
 </tr>
    
    
    
    
<% } %>            
         <![if supportMisalignedColumns]>
         <tr height=0 style='display:none'>
          <td width=236 style='width:177pt'></td>
          <td width=236 style='width:177pt'></td>
          <td width=236 style='width:177pt'></td>
          <td width=76 style='width:57pt'></td>
          <td width=124 style='width:93pt'></td>
          <td width=124 style='width:93pt'></td>
         </tr>
         
 <![endif]>
</table>

</body>

</html>