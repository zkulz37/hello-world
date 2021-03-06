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
        "from acnt.tac_crca t, comm.TCO_BUSPARTNER c, TAC_HGTRH h " +
        "where t.del_if = 0 " +
        "and c.del_if(+) = 0 " +
        "and t.CLOSE_YN = 'N' " +
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
string ls_accdr = "", ls_acccr = "" ;
decimal v_tot_item_632 = 0 ;

if(dtMaster.Rows[0][0].ToString().Trim().Substring(0, 3) == "XTP")     
{
    SQL
	    = "select b.item_code, b.item_name, b.UOM, a.QTY, ACNT.sf_get_monthly_up(substr(c.TR_DATE, 0,6), a.TCO_ITEM_PK, c.TCO_COMPANY_PK) uprice, ACNT.sf_get_monthly_up(substr(c.TR_DATE, 0,6), a.TCO_ITEM_PK, c.TCO_COMPANY_PK) * a.qty bk_amt " + 
            "from acnt.tac_crcad a, comm.tco_item b, acnt.tac_crca c  " +
            "where a.del_if = 0 and b.del_if(+) = 0 and c.del_if = 0 " +
            "and a.TCO_ITEM_PK = b.pk(+) " +            
            "and a.TAC_CRCA_PK = c.PK " +
            "and c.PK = " + ls_tac_crca_pk ;
        dtItem = ESysLib.TableReadOpen(SQL);    
        ls_accdr = "632000";    
        ls_acccr = "155000";
        for(i = 0; i < dtItem.Rows.Count; i++)
        {
            if(dtItem.Rows[i][5].ToString() != "")        
                v_tot_item_632 += decimal.Parse(dtItem.Rows[i][5].ToString());
        }        
}            

%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=unicode">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="phieu_xuat_kho_files/filelist.xml">
<link rel=Edit-Time-Data href="phieu_xuat_kho_files/editdata.mso">
<link rel=OLE-Object-Data href="phieu_xuat_kho_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>van</o:Author>
  <o:LastAuthor>van</o:LastAuthor>
  <o:LastPrinted>2008-11-13T03:28:44Z</o:LastPrinted>
  <o:Created>2008-11-13T03:19:52Z</o:Created>
  <o:LastSaved>2008-11-13T03:28:58Z</o:LastSaved>
  <o:Company>vinagenuwin</o:Company>
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
	mso-footer-margin:.5in;}
.font13
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
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
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	color:red;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;}
.xl30
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	color:white;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
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
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl42
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
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;	
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;	
	border-left:none;
	white-space:normal;
	}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;	
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl49
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl58
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022????_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	color:white;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl63
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl65
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl66
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl68
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl79
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
	white-space:normal;}
.xl80
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
	white-space:normal;}
.xl81
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
	white-space:normal;}
.xl82
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl85
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl87
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl88
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl89
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
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
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11595</x:WindowHeight>
  <x:WindowWidth>19065</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=674 style='border-collapse:
 collapse;table-layout:fixed;width:506pt'>
 <col class=xl24 width=37 style='mso-width-source:userset;mso-width-alt:1353;
 width:28pt'>
 <col class=xl24 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl24 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl24 width=171 style='mso-width-source:userset;mso-width-alt:6253;
 width:128pt'>
 <col class=xl24 width=52 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col class=xl24 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl24 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl24 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl24 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl24 width=62 span=247 style='mso-width-source:userset;mso-width-alt:
 2267;width:47pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 colspan=6 align=left width=424 style='height:15.0pt;
  mso-ignore:colspan;width:319pt'><%=dtComp.Rows[0][0] %></td>
  <td class=xl24 width=76 style='width:57pt'></td>
  <td colspan=2 class=xl67 width=174 style='width:130pt'>Mẫu số S02-TP</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl24 colspan=7 align=left style='height:19.5pt;
  mso-ignore:colspan'><%=dtComp.Rows[0][2] %></td>
  <td class=xl26></td>
  <td class=xl27
  x:str="                 (Ban hành theo Quyết định số 15/2006/QĐ-BTC ngày "><span
  style='mso-spacerun:yes'>                 </span>(Ban hành theo Quyết định số
  15/2006/QĐ-BTC ngày<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 colspan=4 align=left style='height:15.0pt;
  mso-ignore:colspan'>Tax Code/MST:&nbsp;&nbsp;<%=dtComp.Rows[0][1] %></td>
  <td class=xl28></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl27>&nbsp;&nbsp;&nbsp;<span style='mso-spacerun:yes'>           
  </span>20 tháng 03 năm 2006 của Bộ trường Bộ Tài chính)</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=7 height=30 class=xl68 style='border-right:.5pt solid black;
  height:22.5pt'>PHIẾU XUẤT KHO/OUTPUT FINISHED GOODS</td>
  <td class=xl30>Số chứng từ</td>
  <td class=xl31><%=dtMaster.Rows[0][0] %> (<%=dtMaster.Rows[0][7] %>)</td>
 </tr> 
 <tr height=20 style='height:15.0pt'>
  <td colspan=7 height=20 class=xl70 style='border-right:.5pt solid black;
  height:15.0pt'>Ngày (date) : <%= dtMaster.Rows[0][2]%></td>
  <td class=xl32>Nợ <%=ls_accdr %></td>
  <td class=xl36 x:num><%=v_tot_item_632%></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl35>Có <%=ls_acccr %></td>
  <td class=xl36 x:num><%=v_tot_item_632 %></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 colspan=4 align=left style='height:15.0pt;
  mso-ignore:colspan'>Họ tên người nhận hàng :</td>
  <td class=xl37></td>
  <td colspan=2 class=xl38 style='mso-ignore:colspan'></td>
  <td colspan=1 class=xl38></td>
  <td class=xl24></td> 
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 colspan=2 align=left style='height:15.0pt;
  mso-ignore:colspan'>Địa chỉ:</td>
  <td colspan=6 class=xl37 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 colspan=2 align=left style='height:15.0pt;
  mso-ignore:colspan'>Diễn giải:</td>
  <td colspan=6 class=xl37 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 colspan=2 align=left style='height:15.0pt;
  mso-ignore:colspan'>Xuất tại kho :</td>
  <td class=xl24 colspan=2 align=left style='mso-ignore:colspan'>Tên doanh
  nghiệp</td>
  <td colspan=4 class=xl37 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl39 align=left style='height:15.0pt'>Chứng
  từ kèm theo :</td>
  <td class=xl24 colspan=2 align=left style='mso-ignore:colspan'>[Số hđ: <%= dtMaster.Rows[0][1]%>][Ngày hđ: <%= dtMaster.Rows[0][6]%>]</td>
  <td class=xl37></td>
  <td colspan=3 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl40></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td rowspan=2 height=40 class=xl72 width=37 style='border-bottom:.5pt solid black;
  height:30.0pt;width:28pt'>STT<br>
    <font class="font13">No</font></td>
  <td colspan=2 rowspan=2 class=xl74 width=102 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:77pt'>Mã vật Tư<br>
    <font class="font13">Code</font></td>
  <td rowspan=2 class=xl77 width=171 style='border-bottom:.5pt solid black;
  width:128pt'>Tên Thành Phẩm <br>
    <font class="font13">The name of finish good</font></td>
  <td rowspan=2 class=xl77 width=52 style='border-bottom:.5pt solid black;
  width:39pt'>ĐVT<br>
    <font class="font13">Unit</font></td>
  <td colspan=2 class=xl79 width=138 style='border-right:.5pt solid black;
  border-left:none;width:104pt' x:str="Số Lượng ">Số Lượng<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl77 width=71 style='border-bottom:.5pt solid black;
  width:53pt'>Đơn giá<br>
    <font class="font13">Price</font></td>
  <td rowspan=2 class=xl77 width=103 style='border-bottom:.5pt solid black;
  width:77pt'>Thành tiền<br>
    <font class="font13">Amount</font></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl42 width=62 style='height:15.0pt;width:47pt'
  x:str="Chứng từ ">Chứng từ<span style='mso-spacerun:yes'> </span></td>
  <td class=xl43 width=76 style='width:57pt'>Quantity</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl44 style='height:15.0pt'>(A)</td>
  <td colspan=2 class=xl79 width=102 style='border-right:.5pt solid black;
  border-left:none;width:77pt'>(B)</td>
  <td class=xl45>(C)</td>
  <td class=xl45>(D)</td>
  <td class=xl45 x:str="'(1)">(1)</td>
  <td class=xl45 x:str="'(E)">(E)</td>
  <td class=xl45 x:str="'(F)">(F)</td>
  <td class=xl45 x:str="'(G)">(G)</td>
 </tr>
 <% 
    decimal lQty = 0, lAmt = 0;
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
 %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl46 style='height:15.0pt; border-bottom:.5pt solid black;' x:num><%=i + 1 %></td>
  <td colspan=2 class=xl83 style='border-right:.5pt solid black;border-left:
  none; border-bottom:.5pt solid black;'><%=dtItem.Rows[i][0] %></td>
  <td class=xl47 align=left style="border-bottom:.5pt solid black;"><%=dtItem.Rows[i][1] %></td>
  <td class=xl48 style="border-bottom:.5pt solid black;"><%=dtItem.Rows[i][2] %></td>
  <td class=xl49 align=left x:num><span
  style='mso-spacerun:yes; border-bottom:.5pt solid black;'> </span><%=dtItem.Rows[i][3] %></td>
  <td class=xl49 align=left x:num><span
  style='mso-spacerun:yes; border-bottom:.5pt solid black;'> </span><%=dtItem.Rows[i][3] %></td>
  <td class=xl49 align=left x:num><span
  style='mso-spacerun:yes;border-bottom:.5pt solid black;'> </span><%=dtItem.Rows[i][4] %></td>
  <td class=xl49 align=left x:num><span
  style='mso-spacerun:yes; border-bottom:.5pt solid black;'> </span><%=dtItem.Rows[i][5] %></td>
 </tr>
 <% 
    }
 %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl54 style='height:15.0pt'>&nbsp;</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl59>&nbsp;</td>
  <td class=xl59>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl54 style='height:15.0pt'>&nbsp;</td>
  <td class=xl60><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl60><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl61 align=left>Cộng/ Total</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl63 align=left x:num><span
  style='mso-spacerun:yes'> </span><%=lQty %></td>
  <td class=xl64>&nbsp;</td>
  <td class=xl63 align=left x:num><span
  style='mso-spacerun:yes'> </span><%=lAmt %></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=9 rowspan=2 height=40 class=xl82 style='height:30.0pt'>Ghi bằng
  chữ:<%=CommondLib.Num2VNText(lAmt.ToString(), "VND") %> <i>(<%=CommondLib.changeNumericToWords(lAmt.ToString()) %> VND)</i></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl24 align=left><span style='mso-spacerun:yes'> </span></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=6 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl88>Ngày (date): <%=dtMaster.Rows[0][2].ToString().Substring(0, 2)%> tháng <%=dtMaster.Rows[0][2].ToString().Substring(3, 2)%> năm <%=dtMaster.Rows[0][2].ToString().Substring(6, 4)%></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=3 height=20 class=xl65 style='height:15.0pt'
  x:str="Người nhận hàng ">Người nhận hàng<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl65>Kế Toán thành phẩm</td>
  <td colspan=3 class=xl65>Kế Toán Trưởng</td>
  <td colspan=2 class=xl65><span style='mso-spacerun:yes'>      </span>Thủ
  trưởng đơn vị</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl89 width=139 style='height:15.0pt;width:105pt'>The
  name of receiver</td>
  <td class=xl65>Account</td>
  <td colspan=3 class=xl65>Chief Account</td>
  <td colspan=2 class=xl65>General Director</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=37 style='width:28pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=171 style='width:128pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=103 style='width:77pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
