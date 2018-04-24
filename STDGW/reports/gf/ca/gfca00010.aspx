<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<% ESysLib.SetUser("acnt");%>
<% Response.ContentType = "application/vnd.ms-excel";
   Response.Charset = "utf-8"; 
   Response.Buffer = false;
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
    string ls_tac_hgtrh_pk, lcompany_pk, ls_tac_crca_pk;
    string SQL;
    int i ;
    ls_tac_hgtrh_pk = Request["tac_hgtrh_pk"];
    lcompany_pk = Request["company_pk"];
    ls_tac_crca_pk = Request["tac_crca_pk"];
    SQL
	= "select PARTNER_NAME, TAX_CODE, NVL(ADDR1, '') || NVL(ADDR2, ' ') || NVL(ADDR3, ' ') address  " + 
        "from comm.tco_company  " +
        "where del_if = 0  " +
        "and pk = " + lcompany_pk ;    
    DataTable dtComp = new DataTable ();
    dtComp = ESysLib.TableReadOpen(SQL); 
    if(dtComp.Rows.Count == 0)
    {
        Response.Write("There is not enough information to display!!!");
        Response.End();
    }
SQL
	= "select h.VOUCHERNO, t.INVOICE_NO, substr(t.TR_DATE, 7, 2) || '/' || substr(t.TR_DATE, 5, 2) || '/' || substr(t.TR_DATE, 1, 4) trans_date, " + 
        "    c.PARTNER_NAME, NVL(c.ADDR1, '') || NVL(c.addr2, ' ') || NVL(c.addr3, '') address, t.remark2, substr(t.INVOICE_DATE, 7, 2) || '/' || substr(t.INVOICE_DATE, 5, 2) || '/' || substr(t.INVOICE_DATE, 1, 4) INVOICE_DATE_date, h.PK SEQ, " +
        " t.VOUCHER_TYPE, nvl(tot_net_bk_amt, 0) tot_net_bk_amt, nvl(tot_vat_bk_amt, 0) tot_vat_bk_amt, nvl(tot_net_bk_amt, 0) + nvl(tot_vat_bk_amt, 0) tot_bkamt " +
        ", (select d.vat_rate from tac_crcad d where d.tac_crca_pk = t.pk and d.del_if = 0 and rownum = 1) vat_rate " +
        ", t.tr_ccy, t.tr_rate " +
        "from acnt.tac_crca t, comm.TCO_BUSPARTNER c, TAC_HGTRH h " +
        "where t.del_if = 0 " +
        "and c.del_if(+) = 0 " +        
        " and h.del_if = 0 " +
        "and t.TCO_BUSPARTNER_PK = c.pk(+) " +
        " and h.TR_TABLENM = 'TAC_CRCA' " +
        " and h.TR_TABLE_PK = t.pk " +
        "and h.pk = " + ls_tac_hgtrh_pk ;
    DataTable dtMaster = new DataTable();
    dtMaster = ESysLib.TableReadOpen(SQL);
    if(dtMaster.Rows.Count == 0)
    {        
        Response.Write("!!!");
        Response.End();
    }
	SQL = "";
	DataTable dtItem = new DataTable();
	string ls_accdr = "", ls_acccr = "", ls_acvat = "";
	decimal v_tot_item_632 = 0 ;
	DataTable dtARDRCR_VAT = new DataTable();

SQL
	= "	 select num_1, num_2, num_4 " + 
        "	 from tac_commcode_detail a, tac_commcode_master b  " +
        "	 where a.del_if = 0 and b.del_if = 0  " +
        "	 and a.tac_commcode_master_pk = b.pk  " +
        "	 and b.tco_company_pk = '" + lcompany_pk + "' " +
        "	 and a.code = '60030010' " ;
	dtARDRCR_VAT = ESysLib.TableReadOpen(SQL);  
	if(dtARDRCR_VAT.Rows.Count > 0)
	{
		ls_accdr = dtARDRCR_VAT.Rows[0][0].ToString();
		ls_acccr = dtARDRCR_VAT.Rows[0][1].ToString();		
		ls_acvat = dtARDRCR_VAT.Rows[0][2].ToString();		
	}    
if(dtMaster.Rows[0][0].ToString().Trim().Substring(0, 2) == "AR")     
{
    SQL
	    = "select b.item_code, b.item_name, b.UOM, a.QTY, a.U_PRICE , a.EXT_PRICE, a.net_bk_amt " + 
            "from acnt.tac_crcad a, comm.tco_item b, acnt.tac_crca c  " +
            "where a.del_if = 0 and b.del_if(+) = 0 and c.del_if = 0 " +
            "and a.TCO_ITEM_PK = b.pk(+) " +            
            "and a.TAC_CRCA_PK = c.PK " +
            "and c.PK = " + ls_tac_crca_pk ;
        dtItem = ESysLib.TableReadOpen(SQL);        
        //ls_accdr = "131100";    
        //ls_acccr = "511100";
}            
 SQL
	= "SELECT TRIM (code) code, a.code code_nm " + 
        "  FROM tac_commcode_detail a, tac_commcode_master b " +
        " WHERE a.del_if = 0 " +
        "   AND b.del_if = 0 " +
        "   AND a.tac_commcode_master_pk = b.pk " +
        "   AND TRIM (b.ID) = 'ACBG0040' " +
        "   AND a.def_yn = 'Y' " ;
    DataTable dtBook_CCY = new DataTable();
	
    string ls_BookCCY = "USD";
        dtBook_CCY = ESysLib.TableReadOpen(SQL);
        ls_BookCCY = dtBook_CCY.Rows[0][0].ToString();
		
 	string l_xls_format = "" ;	
	if(dtMaster.Rows[0][13].ToString()!="VND")
	{
		l_xls_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
	}
	else
	{
		l_xls_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
	}
	string l_xls_book_ccy = "";
	if(ls_BookCCY != "VND")
		l_xls_book_ccy = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    else 
		l_xls_book_ccy = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
		
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="DTBH_files/filelist.xml">
<link rel=Edit-Time-Data href="DTBH_files/editdata.mso">
<link rel=OLE-Object-Data href="DTBH_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>OWNER</o:Author>
  <o:LastAuthor>van</o:LastAuthor>
  <o:LastPrinted>2008-12-08T07:27:51Z</o:LastPrinted>
  <o:Created>2008-12-08T03:55:36Z</o:Created>
  <o:LastSaved>2008-12-08T07:30:50Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .25in 1.0in .25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}
.font13
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font17
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
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
	{mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	mso-style-name:Comma;
	mso-style-id:3;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:돋움, monospace;
	mso-font-charset:129;
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
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:돋움, monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl24
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";}
.xl28
	{mso-style-parent:style0;
	color:white;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	color:white;
	font-weight:700;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style16;	
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;	
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl53
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl54
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl55
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl58
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl63
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl64
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl65
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl73
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl74
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl76
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl77
	{mso-style-parent:style16;	
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl78
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl79
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl80
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl82
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl83
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl84
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;	
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl85
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl86
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl87
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl88
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl89
	{mso-style-parent:style0;
	font-size:11.0pt;
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
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>29</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
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
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>12270</x:WindowHeight>
  <x:WindowWidth>18960</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:MaxIterations>1</x:MaxIterations>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>
<body onload="window.print();" link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=938 style='border-collapse:
 collapse;table-layout:fixed;width:705pt'>
 <col class=xl25 width=29 style='mso-width-source:userset;mso-width-alt:1060;
 width:22pt'>
 <col class=xl25 width=48 style='mso-width-source:userset;mso-width-alt:1755;
 width:36pt'>
 <col class=xl25 width=31 style='mso-width-source:userset;mso-width-alt:1133;
 width:23pt'>
 <col class=xl25 width=181 style='mso-width-source:userset;mso-width-alt:6619;
 width:136pt'>
 <col class=xl25 width=50 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col class=xl25 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl25 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt:4534;
 width:93pt'>
 <col class=xl25 width=135 style='mso-width-source:userset;mso-width-alt:4937;
 width:101pt'>
 <col class=xl25 width=48 span=247 style='mso-width-source:userset;mso-width-alt:
 1755;width:36pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 colspan=4 align=left width=289 style='height:15.0pt;
  mso-ignore:colspan;width:217pt'><%=dtComp.Rows[0][0] %></td>
  <td class=xl24 width=50 style='width:38pt'></td>
  <td class=xl25 width=110 style='width:83pt'></td>
  <td colspan=3 class=xl62 width=345 style='width:259pt'></td>
  <td class=xl25 width=48 style='width:36pt'></td>
  <td class=xl25 width=48 style='width:36pt'></td>
  <td class=xl25 width=48 style='width:36pt'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl25 colspan=4 align=left style='height:19.5pt;
  mso-ignore:colspan'><%=dtComp.Rows[0][2] %></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl89 align=left></td>
  <td class=xl89 align=left style='border-left:.5pt solid black; border-top:.5pt solid black; border-right:.5pt solid black; border-bottom:.5pt solid black'>Số chứng từ</td>
  <td class=xl72 style="border-left:.5pt solid black; border-top:.5pt solid black; border-right:.5pt solid black; border-bottom:.5pt solid black"><%=dtMaster.Rows[0][0] %> (<%=dtMaster.Rows[0][7] %>)</td>  
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 colspan=4 align=left style='height:15.0pt;
  mso-ignore:colspan'>Tax Code/MST:  <%=dtComp.Rows[0][1] %></td>
  <td class=xl26></td>
  <td class=xl25></td>
  <td class=xl63 align=left style='border-top:none; border-left:none'></td>
  <td class=xl51 align=right style="border-top:none;border-left:.5pt solid black;mso-number-format:'<%=l_xls_format%>';" x:str>Nợ <%=ls_accdr %></td>
  <td class=xl43 x:num><%=dtMaster.Rows[0][11]%></td>  
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl63 align=left style='border-top:none ' x:str></td>
  <td class=xl51 align=right style="border-top:none;border-left:.5pt solid black;" x:str>Có <%=ls_acccr %></td>
  <td class=xl43 style="mso-number-format:'<%=l_xls_format%>';" x:num><%=dtMaster.Rows[0][9]%></td>  
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=7 height=30 class=xl63 style='height:22.5pt'>HÓA ĐƠN BÁN
  HÀNG/COMMERCIAL INVOICE</td>  
  <td class=xl51 align=right style='border-top:none; border-left:.5pt solid black' x:str>Có <%=ls_acvat %></td>
  <td class=xl43 style="mso-number-format:'<%=l_xls_format%>';" x:num><%=dtMaster.Rows[0][10]%></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=6 height=20 class=xl64 style='height:15.0pt'>Ngày (date) :
  <%= dtMaster.Rows[0][2]%></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 colspan=4 align=left style='height:15.0pt;
  mso-ignore:colspan'>Họ tên người mua hàng hàng:</td>
  <td class=xl29 colspan="5"><%=dtMaster.Rows[0][3]%></td>
  <td class=xl30></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 colspan=2 align=left style='height:15.0pt;
  mso-ignore:colspan'>Địa chỉ:</td>
  <td colspan=6 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl57 colspan=4 style='height:15.0pt;mso-ignore:colspan'>Số
  hóa đơn kèm theo</td>
  <td class=xl29></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl57 colspan=4 style='height:15.0pt;mso-ignore:colspan'>Số
  tờ khai xuất kèm theo</td>
  <td class=xl29></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td rowspan=2 height=40 class=xl65 width=29 style='border-bottom:.5pt solid black;
  height:30.0pt;width:22pt'>STT<br>
    <font class="font13">No</font></td>
  <td colspan=2 rowspan=2 class=xl67 width=79 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:59pt'>Mã vật Tư<br>
    <font class="font13">Code</font></td>
  <td rowspan=2 class=xl70 width=181 style='border-bottom:.5pt solid black;
  width:136pt'>Tên Thành Phẩm <br>
    <font class="font13">The name of finish good</font></td>
  <td rowspan=2 class=xl70 width=50 style='border-bottom:.5pt solid black;
  width:38pt'>ĐVT<br>
    <font class="font13">Unit</font></td>
  <td class=xl33 width=110 style='width:83pt'>Số lượng</td>
  <td rowspan=2 class=xl70 width=86 style='border-bottom:.5pt solid black;
  width:65pt'>Đơn giá<br>
    <font class="font13">Price</font></td>
  <td rowspan=2 class=xl70 width=124 style='border-bottom:.5pt solid black;
  width:93pt'>Tiền giao dịch<br>
    Trans Amount</td>
  <td rowspan=2 class=xl70 width=135 style='border-bottom:.5pt solid black;
  width:101pt'>Thành tiền<br>
    Book <font class="font13">Amount</font></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl34 width=110 style='height:15.0pt;width:83pt'>Quantity</td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl35 style='height:15.0pt'>(A)</td>
  <td colspan=2 class=xl58 width=79 style='border-right:.5pt solid black;
  border-left:none;width:59pt'>(B)</td>
  <td class=xl36>(C)</td>
  <td class=xl36>(D)</td>
  <td class=xl36 x:str="'(E)">(E)</td>
  <td class=xl36 x:str="'(F)">(F)</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36 x:str="'(G)">(G)</td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr> 
 <% 
    decimal lQty = 0, lAmt = 0, lAmt_Bk = 0;
    for( i = 0; i < dtItem.Rows.Count ; i++)
    {    
        if(dtItem.Rows[i][3].ToString().Trim() != "")
        {
            lQty += Decimal.Parse(dtItem.Rows[i][3].ToString());            
        }
        if(dtItem.Rows[i][5].ToString().Trim() != "")
        {
            lAmt += Decimal.Parse(dtItem.Rows[i][5].ToString());            
        }
        if(dtItem.Rows[i][6].ToString().Trim() != "")
        {
            lAmt_Bk += Decimal.Parse(dtItem.Rows[i][6].ToString());            
        }

 %> 
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl44 style='height:15.0pt;border-top:none; border-bottom:.5pt solid black;' x:num><%=i+1 %></td>
  <td colspan=2 class=xl74 style='border-left:none'><%=dtItem.Rows[i][0] %></td>
  <td class=xl75 align=left width=181 style='border-top:none;border-left:none;
  width:136pt'><%=dtItem.Rows[i][1] %></td>
  <td class=xl78 style='border-top:none;border-left:none'><%=dtItem.Rows[i][2] %></td>
  <td class=xl84 align=right style='border-top:none;border-left:none' x:num><%=dtItem.Rows[i][3] %></td>
  <td class=xl77 style='border-top:none;border-left:none' x:num><%=dtItem.Rows[i][4] %></td>
    <td class=xl84 align="right" style="border-top:none;border-left:none;mso-number-format:'<%=l_xls_format%>';" x:num><%=dtItem.Rows[i][5] %></td>
  <td class=xl84 align=right style="border-top:none;border-left:none;mso-number-format:'<%=l_xls_book_ccy%>';" x:num
  ><%=dtItem.Rows[i][6] %></td> 
 </tr>
 <% } %>
 <% if(dtMaster.Rows[0][13].ToString() != ls_BookCCY ) 
 {
 %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl45 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl75 width=181 style='border-top:none;border-left:none;width:136pt'>Tỷ giá: <%=dtMaster.Rows[0][14] %></td>
  <td class=xl78 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl84 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl84 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl84 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <% } %>
 <tr class=xl24 height=20 style='height:15.0pt'>
  <td height=20 class=xl42 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl47 width=181 style='border-top:none;border-left:none;width:136pt'>Net
  total</td>
  <td class=xl79 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl85 align=right style='border-top:none;border-left:none' x:num></td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl85 align=right style="border-top:none;border-left:none;mso-number-format:'<%=l_xls_book_ccy%>';"
  x:num><%=dtMaster.Rows[0][9] %></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl41 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>VAT</td>
  <td class=xl80 style="border-top:none;border-left:none;" x:str><%=dtMaster.Rows[0][12] %>%</td>
  <td class=xl84 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl81 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl87 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl88 style="border-top:none;border-left:none;mso-number-format:'<%=l_xls_book_ccy%>';" x:num><%=dtMaster.Rows[0][10] %></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl37 style='height:15.0pt'>&nbsp;</td>
  <td class=xl38><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl38><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl48>Cộng/ Total</td>
  <td class=xl82>&nbsp;</td>
  <td class=xl86 align=right x:num><%=lQty %></td>
  <td class=xl83></td>
  <td class=xl86 align=right style="mso-number-format:'<%=l_xls_format%>';" x:num><%=lAmt %></td>
  <td class=xl86 align=right style="mso-number-format:'<%=l_xls_book_ccy%>';" x:num><%=dtMaster.Rows[0][11] %></td>  
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=9 rowspan=2 height=40 class=xl60 width=794 style='height:30.0pt;
  width:597pt'>Ghi bằng chữ: <%=CommondLib.Num2VNText(lAmt_Bk.ToString(), "VND") %> <font
  class="font17"><i>(<%=CommondLib.changeNumericToWords(dtMaster.Rows[0][11].ToString()) %> VND)</i></font></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl25 align=left><span style='mso-spacerun:yes'> </span></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl52 colspan=4 align=left style='height:15.75pt;
  mso-ignore:colspan'>Ngày (date): <%=dtMaster.Rows[0][2].ToString().Substring(0, 2)%> tháng <%=dtMaster.Rows[0][2].ToString().Substring(3, 2)%> năm <%=dtMaster.Rows[0][2].ToString().Substring(6, 4)%></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl52 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl53 colspan=3 align=left style='height:15.0pt;
  mso-ignore:colspan'>Thủ trưởng đơn vị</td>
  <td class=xl54>Kế Toán Trưởng</td>
  <td class=xl25></td>
  <td class=xl39>Kế Toán thành phẩm</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl54 x:str="Người nhận hàng ">Người nhận hàng<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl53 colspan=3 align=left style='height:15.0pt;
  mso-ignore:colspan'>General Director</td>
  <td class=xl54>Chief Account</td>
  <td class=xl25></td>
  <td class=xl39>Account</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl56 width=135 style='width:101pt'>The name of receiver</td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 class=xl40 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=9 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=8 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=8 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl55 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=29 style='width:22pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=31 style='width:23pt'></td>
  <td width=181 style='width:136pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=135 style='width:101pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=48 style='width:36pt'></td>
 </tr>
 <![endif]>
</table>
</body>

</html>
