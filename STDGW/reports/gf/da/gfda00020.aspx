<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% ESysLib.SetUser("acnt");%>
<% Response.ContentType = "application/vnd.ms-excel";
   Response.Charset = "utf-8"; 
   Response.Buffer = false;
%>
<%         
    string lcompany, lvoucher_pk, SQL, lwh_name = "", lseq_no ;    
    int i, j;
    
    lcompany = Request["company"]; 
    lvoucher_pk = Request["voucher_pk"];
    lseq_no = Request["seq_no"]; 
    //Company Information 
    DataTable dtCompany = new DataTable ();          
    SQL
	= "select PARTNER_NAME, NVL(ADDR1, '') || NVL(ADDR2, ' ') || NVL(ADDR3, ' ') ADDRESS, TAX_CODE " + 
        "from comm.tco_company " +
        "where pk = " + lcompany ;
    dtCompany = ESysLib.TableReadOpen(SQL);
    if(dtCompany.Rows.Count == 0)
    {
        Response.Write("The page has incorrect information so it does not display");
        Response.End();
    }
    //voucher header information 
    DataTable dtSlipHeader = new DataTable ();
    SQL
        = "SELECT A.INVOICE_NO, A.VOUCHERNO, TO_CHAR(TO_DATE(A.TR_DATE, 'YYYYMMDD'), 'DD/MM/YYYY') TR_DATE, TO_CHAR(TO_DATE(A.INVOICE_DATE, 'YYYYMMDD'), 'DD/MM/YYYY') INVOICE_DATE, B.partner_name, NVL(B.addr1, '') || NVL(B.addr2, ' ') || NVL(B.addr3, ''), " +
        " A.remark2, NVL(A.AP_TRAMT,0) BOOK_AMT, A.VOUCHERNO, H.PK SEQ " +
        "FROM acnt.TAC_CRDA A, COMM.TCO_BUSPARTNER B, acnt.TAC_HGTRH H " +
        "where A.del_if = 0 " +
        "and B.del_if(+) = 0 " +
        "and H.del_if = 0 " +
        "and A.TCO_BUSPARTNER_PK = B.pk(+) " +
        "and H.TR_TABLENM = 'TAC_CRDA' " +
        "and H.TR_TABLE_PK = A.PK  " +
        "and A.PK = " + lvoucher_pk;
        dtSlipHeader = ESysLib.TableReadOpen(SQL);
    if(dtSlipHeader.Rows.Count == 0)
    {
        Response.Write("The page has incorrect information so it does not display");
        Response.End();
    }
   // debit accounts list 
        DataTable dtDebitList = new DataTable();
        SQL
            = "    SELECT SF_A_GET_ACCD(TAC_ABACCTCODE_PK, H.TCO_COMPANY_PK) ACCD, " +
                "           NVL(TR_BOOKAMT, 0)            " +
                "      FROM ACNT.TAC_HGTRD T, TAC_HGTRH H " +
                "     WHERE T.DEL_IF       = 0 " +
                "       AND H.DEL_IF       = 0 " +
                "       AND T.TAC_HGTRH_PK = H.PK        " +
                "       AND T.TAC_HGTRH_PK = " + lseq_no +
                "       AND T.DRCR_TYPE    = 'D' " +
                "     ";    
        dtDebitList = ESysLib.TableReadOpen(SQL);
    if(dtDebitList.Rows.Count == 0)
    {
        Response.Write("The voucher has not correct information to display");
        Response.End();        
    }        
    // credit accounts list 
        DataTable dtCreditList = new DataTable();
        SQL
            = "    SELECT SF_A_GET_ACCD(TAC_ABACCTCODE_PK, H.TCO_COMPANY_PK) ACCD, " +
                "           NVL(TR_BOOKAMT, 0)            " +
                "      FROM ACNT.TAC_HGTRD T, TAC_HGTRH H " +
                "     WHERE T.DEL_IF       = 0 " +
                "       AND H.DEL_IF       = 0 " +
                "       AND T.TAC_HGTRH_PK = H.PK        " +
                "       AND T.TAC_HGTRH_PK = " + lseq_no +
                "       AND T.DRCR_TYPE    = 'C' " +
                "      ";    
        dtCreditList = ESysLib.TableReadOpen(SQL);
    if(dtCreditList.Rows.Count == 0)
    {
        Response.Write("The voucher has not correct information to display");
        Response.End();                
    }
    SQL
	= "select WH_NAME from inv.tin_warehouse where del_if = 0 and UPPER(TRIM(WH_ID)) = 'NLNN' " ;
    DataTable dtWH = ESysLib.TableReadOpen(SQL);
    string ls_whnm = "";       
    if(dtWH.Rows.Count == 0)    
        ls_whnm = "";
    else
        ls_whnm = dtWH.Rows[0][0].ToString();                              
                            
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=unicode">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="PNK_files/filelist.xml">
<link rel=Edit-Time-Data href="PNK_files/editdata.mso">
<link rel=OLE-Object-Data href="PNK_files/oledata.mso">
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
  <o:LastAuthor>van</o:LastAuthor>
  <o:LastPrinted>2008-11-07T02:26:18Z</o:LastPrinted>
  <o:Created>2006-06-27T06:13:13Z</o:Created>
  <o:LastSaved>2008-11-07T07:55:44Z</o:LastSaved>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Trang &P \/ &N";
	margin:.5in 0in .5in .25in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
.font6
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
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
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:left;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
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
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl30
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
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid windowtext;
	border-bottom:none;
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
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl33
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
.xl34
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
.xl35
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
.xl36
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
	border-left:.5pt solid windowtext;}
.xl37
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
.xl38
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
.xl39
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
.xl40
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
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;}
.xl43
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
	border-left:none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style16;
	font-size:12.0pt;
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
.xl56
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl62
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl65
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl68
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
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
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl71
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl72
	{mso-style-parent:style0;
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
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl74
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;}
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
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl78
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
.xl79
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
.xl80
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl81
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
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
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl84
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl87
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl88
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl89
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	mso-text-control:shrinktofit;}	
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Phiếu xuất kho-02-VT</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>95</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>90</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>12</x:SplitHorizontal>
     <x:TopRowBottomPane>12</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11565</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1590</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Phiếu xuất kho-02-VT'!$A$11:$J$26</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Phiếu xuất kho-02-VT'!$9:$11</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="3073"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1143 style='border-collapse:
 collapse;table-layout:fixed;width:859pt'>
 <col class=xl24 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl24 width=194 style='mso-width-source:userset;mso-width-alt:7094;
 width:146pt'>
 <col class=xl24 width=215 style='mso-width-source:userset;mso-width-alt:7862;
 width:161pt'>
 <col class=xl24 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=75 span=2 style='mso-width-source:userset;mso-width-alt:
 2742;width:56pt'>
 <col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl24 width=110 span=2 style='mso-width-source:userset;mso-width-alt:
 4022;width:83pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 colspan=2 width=157 style='height:15.75pt;
  mso-ignore:colspan;width:118pt'><%=dtCompany.Rows[0][0] %></td>
  <td class=xl24 width=194 style='width:146pt'></td>
  <td class=xl24 width=215 style='width:161pt'></td>
  <td class=xl24 width=54 style='width:41pt'></td>
  <td class=xl24 width=75 style='width:56pt'></td>
  <td colspan=4 class=xl28 width=384 style='width:289pt'>Mẫu số: 02-VT</td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl26 colspan=3 style='height:15.75pt;mso-ignore:colspan'
  x:str><span style='mso-spacerun:yes'> </span><%=dtCompany.Rows[0][1] %><span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl27
  x:str="(Ban hành theo Quyết định số 15/2006/QĐ-BTC ngày ">(Ban hành theo
  Quyết định số 15/2006/QĐ-BTC ngày<span style='mso-spacerun:yes'> </span></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl26 colspan=2 style='height:15.75pt;mso-ignore:colspan'
  x:str><span style='mso-spacerun:yes'> </span>Mã số
  thuế: <%=dtCompany.Rows[0][2] %><span style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl27>20 tháng 03 năm 2006 của Bộ trường Bộ Tài chính)</td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=7 height=30 class=xl68 style='height:22.5pt'>PHIẾU NHẬP KHO</td>
  <td class=xl50>Số chứng từ:</td>
  <td colspan=2 class=xl69 x:str><span
  style='mso-spacerun:yes'> </span><%=dtSlipHeader.Rows[0][1] %>(<%=dtSlipHeader.Rows[0][9] %>)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl24></td>
 </tr>
 <% 
    i = 0; //index of Debit Account code List
    j = 0 ;//index of Credit Account code List
 %>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=7 height=26 class=xl28 style='height:19.5pt'>Ngày: <%=dtSlipHeader.Rows[0][2] %></td>
  <td class=xl24></td>
  <td class=xl46 x:str><span
  style='mso-spacerun:yes'> </span>Nợ/Debit: <%=dtDebitList.Rows[i][0] %>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl89 x:num><span style='mso-spacerun:yes'>                    
  </span><%=dtDebitList.Rows[i][1] %></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl75 style='height:15.75pt'
  x:str="Nhà cung cấp/Vendor:"><span style='mso-spacerun:yes'> </span>Nhà cung
  cấp/Vendor:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl67><%=dtSlipHeader.Rows[0][4] %></td>
  <td class=xl24>Địa chỉ NCC/Vendor's Addr:</td>
  <td colspan=3 rowspan=2 class=xl70 width=204 style='width:153pt'><%=dtSlipHeader.Rows[0][5] %></td>
  <td class=xl44></td>
  <td class=xl46 x:str><span
  style='mso-spacerun:yes'> </span>Có/Credit: <%=dtCreditList.Rows[j][0] %>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl89 x:num><span style='mso-spacerun:yes'>                    
  </span><%=dtCreditList.Rows[j][1] %></td>
  <td class=xl26></td>
 </tr>
 <% 
    i += 1;
    j += 1;
 %>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl73 style='height:15.75pt'
  x:str><span style='mso-spacerun:yes'> </span>Nhập
  tại kho/Warehouse:<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl29 x:str><span
  style='mso-spacerun:yes'> </span><%=ls_whnm %><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl24></td>
  <td class=xl49></td>
  <% 
    if(i < dtDebitList.Rows.Count)
    {
  %>  
  <td class=xl46 x:str><span
  style='mso-spacerun:yes'> </span>Nợ/Debit: <%=dtDebitList.Rows[i][0] %>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl89 x:num><span style='mso-spacerun:yes'>                    
  </span><%=dtDebitList.Rows[i][1] %></td> 
  <% 
  i += 1;
    }
    else if(j < dtCreditList.Rows.Count)
    {
%>
  <td class=xl46 x:str><span
  style='mso-spacerun:yes'> </span>Có/Credit: <%=dtCreditList.Rows[j][0] %>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl26 x:num><span style='mso-spacerun:yes'>                    
  </span><%=dtCreditList.Rows[j][1] %></td> 
<%      
    j += 1;              
    }
    else
    {
  %>
  <td class=xl46 x:str><span
  style='mso-spacerun:yes'> </span><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl26 x:num><span style='mso-spacerun:yes'>                    
  </span></td>
  <% 
    }
  %>
 <td class=xl24></td>      
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl74 style='height:15.75pt' x:str><span
  style='mso-spacerun:yes'> </span>Địa điểm:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl42></td>
  <td class=xl49></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl44></td>
  <% 
    if(j < dtCreditList.Rows.Count )
    {
  %>
  <td class=xl46 align="right"><span
  style='mso-spacerun:yes'> </span>Có/Credit: <%=dtCreditList.Rows[j][0] %>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl89 x:num><span style='mso-spacerun:yes'>                  
  </span><%=dtCreditList.Rows[j][1] %></td>
  <% 
    j += 1;    
  }
  else if( i < dtDebitList.Rows.Count )
  {
  %>
  <td class=xl46 align= "right"><span
  style='mso-spacerun:yes'> </span>Nợ/Debit: <%=dtDebitList.Rows[i][0] %>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl89 x:num><span style='mso-spacerun:yes'>                  
  </span><%=dtDebitList.Rows[i][1]%></td>  
  <%
      i += 1;
  }
  else
   {
  %>
  <td class=xl46 x:str><span
  style='mso-spacerun:yes'> </span><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl26 x:num><span style='mso-spacerun:yes'>                  
  </span></td>
  <% 
    }
  %>
  <td class=xl24></td>
 </tr>
 <% 
     while (i < dtDebitList.Rows.Count || j < dtCreditList.Rows.Count)
     {
         if (i < dtDebitList.Rows.Count)
         {
 %> 
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl74 style='height:15.75pt' x:str><span
  style='mso-spacerun:yes'> </span><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl42></td>
  <td class=xl49></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl44></td>
  <td class=xl46 x:str><span
  style='mso-spacerun:yes'> </span>Nợ/Debit: <%=dtDebitList.Rows[i][0]%>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl89 x:num><span style='mso-spacerun:yes'>                  
  </span><%=dtDebitList.Rows[i][1]%></td>
  <td class=xl24></td>
 </tr>
<% 
     i += 1;
 }
 if (j < dtCreditList.Rows.Count)
 { 
%> 
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl74 style='height:15.75pt' x:str><span
  style='mso-spacerun:yes'> </span><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl42></td>
  <td class=xl49></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl44></td>
  <td class=xl46 x:str><span
  style='mso-spacerun:yes'> </span>Có/Credit: <%=dtCreditList.Rows[j][0]%>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl89 x:num><span style='mso-spacerun:yes'>                  
  </span><%=dtCreditList.Rows[j][1]%></td>
  <td class=xl24></td>
 </tr>
<% 
     j += 1;
 }
}
%>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 class=xl30 style='height:15.75pt;border-top:none'>STT</td>
  <td colspan=2 class=xl76 width=297 style='border-right:.5pt solid black;
  border-left:none;width:223pt' x:str="Tên, nhãn hiệu, ">Tên, nhãn hiệu,<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl31>Mã số</td>
  <td class=xl30 style='border-left:none' x:str="Đơn vị ">Đơn vị<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl78 style='border-right:.5pt solid black;border-left:
  none'>Số lượng</td>
  <td class=xl33>Đơn giá</td>
  <td class=xl30>Tiền giao</td>
  <td class=xl34>Thành tiền</td>
  <td class=xl28></td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 class=xl35 style='height:15.75pt'>&nbsp;</td>
  <td colspan=2 class=xl80 width=297 style='border-right:.5pt solid black;
  border-left:none;width:223pt'><span style='mso-spacerun:yes'> </span>quy cách
  phẩm chất vật tư,</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl35 style='border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>Yêu</td>
  <td class=xl30 style='border-top:none'>Thực</td>
  <td class=xl28></td>
  <td class=xl35>dịch</td>
  <td class=xl32>ghi sổ</td>
  <td class=xl28></td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 class=xl37 id="_x0000_s1025" x:autofilter="all"
  x:autofilterrange="$A$11:$J$26" style='height:15.75pt'>&nbsp;</td>
  <td colspan=2 class=xl82 id="_x0000_s1028" x:autofilter="all" width=297
  style='border-right:.5pt solid black;border-left:none;width:223pt'>dụng cụ
  sản phẩm, hàng hóa</td>
  <td class=xl38 id="_x0000_s1030" x:autofilter="all">&nbsp;</td>
  <td class=xl37 id="_x0000_s1031" x:autofilter="all" style='border-left:none'>tính</td>
  <td class=xl40 id="_x0000_s1033" x:autofilter="all" style='border-left:none'>cầu</td>
  <td class=xl37 id="_x0000_s1034" x:autofilter="all">nhập</td>
  <td class=xl39 id="_x0000_s1036" x:autofilter="all"><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl37 id="_x0000_s1035" x:autofilter="all">&nbsp;</td>
  <td class=xl38 x:autofilter="all">&nbsp;</td>
  <td class=xl28></td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 class=xl65 style='height:15.75pt'>No</td>
  <td colspan=2 class=xl84 style='border-right:.5pt solid black;border-left:
  none'>Item Name</td>
  <td class=xl66>Item Code</td>
  <td class=xl66>Unit</td>
  <td class=xl66>Requested</td>
  <td class=xl66>Received</td>
  <td class=xl66>Price</td>
  <td class=xl66>Trans Amount</td>
  <td class=xl66>Book Amount</td>
  <td class=xl28></td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 class=xl37 style='height:15.75pt'>A</td>
  <td colspan=2 class=xl78 style='border-right:.5pt solid black;border-left:
  none'>B</td>
  <td class=xl38>C</td>
  <td class=xl38>D</td>
  <td class=xl38 x:num>1</td>
  <td class=xl38 x:num>2</td>
  <td class=xl38 x:num>3</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38 x:num>4</td>
  <td class=xl28></td>
 </tr>
 <% 
     decimal lTrAmt = 0, lBookAmt = 0;
     // Voucher details information
     DataTable dtSlipDetail = new DataTable();

     SQL = "SELECT D.PK, I.ITEM_CODE, I.ITEM_NAME, I.UOM, D.AP_QTY, " +
         "NVL(D.AP_TRFAMT, 0) + DECODE(D.RETURN_IMP_TAX, 'Y', 0, NVL(D.IMP_FAMT, 0)) + NVL(D.EXC_FAMT,0) AP_TRFAMT, " + 
         "NVL(D.AP_TRAMT, 0) + DECODE(D.RETURN_IMP_TAX, 'Y', 0, NVL(D.IMP_AMT, 0)) + NVL(D.EXC_AMT,0) AP_TRAMT, NULL, D.AP_UPRICE, I.ITEM_LNAME " + 
        "          FROM TAC_CRDAD D, TCO_ITEM I, TAC_ABACCTCODE A " +
        "         WHERE D.TCO_ITEM_PK = I.PK(+) " +
        "           AND D.TAC_ABACCTCODE_PK = A.PK " +
        "           AND D.DEL_IF     = 0 " +
        "           AND I.DEL_IF(+)  = 0 " +
        "           AND A.DEL_IF     = 0 " +
        "           AND D.TAC_CRDA_PK = " + lvoucher_pk + 
        "         ORDER BY I.ITEM_CODE, D.PK " ;
     dtSlipDetail = ESysLib.TableReadOpen(SQL);
     if (dtSlipDetail.Rows.Count == 0)
     {
         Response.Write("The page has incorrect information so it does not display");
         Response.End();
     }
     
     
     for( i = 0; i < dtSlipDetail.Rows.Count; i++)
     {
         if (dtSlipDetail.Rows[i][5].ToString().Trim() != "")
         {
             lTrAmt += Decimal.Parse(dtSlipDetail.Rows[i][5].ToString());
         }
         if (dtSlipDetail.Rows[i][6].ToString().Trim() != "")
         {
             lBookAmt += Decimal.Parse(dtSlipDetail.Rows[i][6].ToString());
         }         
 %>
    
 
 <tr class=xl26 height=63 style='mso-height-source:userset;height:47.25pt'>
  <td height=63 class=xl52 style='height:47.25pt;border-top:none; border-bottom:.5pt solid black; ' x:num><%=i+1 %></td>
  <td colspan=2 class=xl86 width=297 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black; width:223pt'><%=dtSlipDetail.Rows[i][9] %></td>
  <td class=xl60 width=215 style='border-top:none; border-bottom:.5pt solid black; width:161pt'><%=dtSlipDetail.Rows[i][1] %>/<%=dtSlipDetail.Rows[i][2] %></td>
  <td class=xl60 width=54 style='border-top:none; border-bottom:.5pt solid black; width:41pt'><%=dtSlipDetail.Rows[i][3] %></td>
  <td class=xl53 style='border-top:none; border-bottom:.5pt solid black;' >&nbsp;</td>
  <td class=xl53 x:num style='border-top:none; border-bottom:.5pt solid black;' ><span style='mso-spacerun:yes'> </span><%=dtSlipDetail.Rows[i][4] %></td>
  <td class=xl53 x:num style='border-top:none; border-bottom:.5pt solid black;' ><span
  style='mso-spacerun:yes'> </span><%=dtSlipDetail.Rows[i][8] %><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl62 x:num style='border-top:none; border-bottom:.5pt solid black;' ><span style='mso-spacerun:yes'> </span><%=dtSlipDetail.Rows[i][5] %></td>
  <td class=xl62 x:num style='border-top:none; border-bottom:.5pt solid black;' ><span style='mso-spacerun:yes'> </span><%=dtSlipDetail.Rows[i][6] %></td>
  <td class=xl26 ></td>
 </tr>
 <% 
    }
 %>
 <tr class=xl26 height=21 style='height:15.75pt'>
  <td colspan=6 height=21 class=xl82 width=695 style='height:15.75pt;
  width:522pt'>Cộng/Total</td>
  <td class=xl43 width=75 style='width:56pt'>&nbsp;</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl64 x:num><span style='mso-spacerun:yes'> </span><%=lTrAmt%></td>
  <td class=xl64 x:num><span style='mso-spacerun:yes'> </span><%=lBookAmt%></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl41 style='height:15.75pt'></td>
  <td class=xl26 colspan=3 style='mso-ignore:colspan'
  x:str="'-Tổng số tiền(Viết bằng chữ)/Total amount(written in Vietnamese words):"><span
  style='mso-spacerun:yes'> </span>-Tổng số tiền(Viết bằng chữ)/Total
  amount(written in Vietnamese words):<span style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl87 width=513 style='width:386pt'><%=CommondLib.Num2VNText(dtSlipHeader.Rows[0][7].ToString(), "VND") %></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl41 style='height:15.75pt'></td>
  <td class=xl48></td>
  <td class=xl26></td>
  <td class=xl26></td>
  <td colspan=6 class=xl88 width=513 style='width:386pt'><%= CommondLib.changeNumericToWords(dtSlipHeader.Rows[0][7].ToString()) %> VND</td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 class=xl27 style='height:15.75pt'></td>
  <td class=xl26 colspan=4 style='mso-ignore:colspan'
  x:str><span
  style='mso-spacerun:yes'> </span>-Số chứng từ gốc kèm theo/Origin Invoice No:
  [Số hđ:<span style='mso-spacerun:yes'><%=dtSlipHeader.Rows[0][0]%></span>][ngày hóa đơn:<%=dtSlipHeader.Rows[0][3]%>]
  <span style='mso-spacerun:yes'> </span></td>
  <td class=xl27></td>
  <td class=xl26></td>
  <td colspan=3 class=xl27>Ngày <%=dtSlipHeader.Rows[0][2].ToString().Substring(0, 2)%> tháng <%=dtSlipHeader.Rows[0][2].ToString().Substring(3, 2)%> năm <%=dtSlipHeader.Rows[0][2].ToString().Substring(6, 4)%>/Date</td>
  <td class=xl27></td>
 </tr>
 <tr class=xl27 height=64 style='mso-height-source:userset;height:48.6pt'>
  <td colspan=2 height=64 class=xl70 width=157 style='height:48.6pt;width:118pt'>Người
  lập phiếu/Slip Writer</td>
  <td class=xl47 width=194 style='width:146pt'>Người nhận hàng/Received Emp.</td>
  <td class=xl47 width=215 style='width:161pt'>Kế toán NPL/Material Dept. Account</td>
  <td colspan=4 class=xl47 width=293 style='width:220pt'>Kế toán trưởng/Account
  Manager<font class="font6"><br>
    ( Hoặc bộ phận có nhu cầu nhập/or manager of department requested goods)</font></td>
  <td colspan=2 class=xl28>Giám đốc/Director</td>
  <td class=xl27></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl59 style='height:15.75pt'>(Ký, họ tên/Sign,
  full name)</td>
  <td class=xl59>(Ký, họ tên/Sign, full name)</td>
  <td class=xl59>(Ký, họ tên/Sign, full name)</td>
  <td colspan=4 class=xl59>(Ký, họ tên/Sign, full name)</td>
  <td colspan=2 class=xl59>(Ký, họ tên/Sign, full name)</td>
  <td class=xl27></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl41 style='height:15.0pt'></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl41 style='height:15.0pt'></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl41 style='height:15.0pt'></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl26 style='height:15.75pt'></td>
  <td colspan=9 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl41 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl41 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl41 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl41 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl41 style='height:15.0pt'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl41 style='height:15.0pt'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=54 style='width:41pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=194 style='width:146pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
