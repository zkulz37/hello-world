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
    string ls_tac_hgtrh_pk = Request["tac_hgtrh_pk"];
    string lcompany_pk = Request["company_pk"];
    string ls_tac_crca_pk = Request["tac_crca_pk"];
    string ls_invoice_date = "";
    string ls_recv_person = "";
    string ls_tax_code = "";
    string ls_tax_rate = "";
    decimal l_net_amt = 0, l_vat_amt = 0, l_total_amt = 0;
    string ls_doc_tien = "";
    decimal l_tr_rate = 0;
    string[] ls_tax_num = new string[12];
    int i;
    string SQL
        = "select (select i.item from tac_hgtrditem i, tac_abacctitem t where i.tac_hgtrd_pk in (select d.pk from tac_hgtrd d where d.tac_hgtrh_pk = h.pk and d.del_if = 0)  " +
            "		  and i.tac_abacctitem_pk = t.pk and t.tac_abitem_alias = 'INVOICE DATE' and rownum = 1 ) invoice_date, " +
            "	'' recv_person, ( select c.partner_name from tco_buspartner c where c.pk in (select d.tco_buspartner_pk from tac_hgtrd d where d.tac_hgtrh_pk = h.pk " +
            "        	and d.del_if = 0 ) and rownum = 1) partner_name, " +
            "( select c.addr1 || ' ' || c.addr2 || ' '  || c.addr3 partner_addr from tco_buspartner c where c.pk in (select d.tco_buspartner_pk from tac_hgtrd d where d.tac_hgtrh_pk = h.pk " +
            "        	and d.del_if = 0 ) and rownum = 1) partner_addr, " +
            "(select i.item from tac_hgtrditem i, tac_abacctitem t where i.tac_hgtrd_pk in (select d.pk from tac_hgtrd d where d.tac_hgtrh_pk = h.pk and d.del_if = 0)  " +
            "		  and i.tac_abacctitem_pk = t.pk and t.tac_abitem_alias = 'PAYMENT METHOD' and rownum = 1 ) payment_method, " +
            "( select c.tax_code from tco_buspartner c where c.pk in (select d.tco_buspartner_pk from tac_hgtrd d where d.tac_hgtrh_pk = h.pk " +
            "        	and d.del_if = 0 ) and rownum = 1) tax_code, " +
            "( select sum(d.tr_amt) from tac_hgtrd d where d.tac_hgtrh_pk = h.pk and d.del_if = 0 and d.drcr_type = 'C' and d.tac_abacctcode_pk not in (select d.tac_abacctcode_pk from tac_mtvat d where d.tac_hgtrh_pk = h.pk and d.del_if = 0) ) net_tr_amt, " +
            "(select i.item from tac_hgtrditem i, tac_abacctitem t where i.tac_hgtrd_pk in (select d.pk from tac_hgtrd d where d.tac_hgtrh_pk = h.pk and d.del_if = 0)  " +
            "		  and i.tac_abacctitem_pk = t.pk and t.tac_abitem_alias = 'TAX RATE' and rownum = 1 ) tax_rate, " +
            "( select sum(d.tax_amt) tax_amt from tac_mtvat d where d.tac_hgtrh_pk = h.pk and d.del_if = 0)  vat_tax_amt,  " +
            "( select d.tr_rate from tac_hgtrd d where d.tac_hgtrh_pk = h.pk and d.del_if = 0 and rownum = 1) tr_rate " +
            "from  tac_hgtrh h " +
            "where h.pk = '" + ls_tac_hgtrh_pk + "' ";
    DataTable dtMst = new DataTable();
    dtMst = ESysLib.TableReadOpen(SQL);
    if(dtMst.Rows.Count > 0)
    {
        ls_invoice_date = dtMst.Rows[0][0].ToString();
        if (ls_invoice_date.Length < 8)
        {
            /*Response.Write("No Information to display");
            Response.End();*/
            ls_invoice_date = "19000101";
        }
        ls_recv_person = dtMst.Rows[0][1].ToString();
        ls_tax_code = dtMst.Rows[0][5].ToString(); // tax code 
        ls_tax_rate = dtMst.Rows[0][7].ToString(); // tax rate
        if (ls_tax_rate.Trim() != "")
        {
            ls_tax_rate = ls_tax_rate.Substring(0, ls_tax_rate.Length - 1);
        }
        else
        {
            ls_tax_rate = "";
        }
        if (dtMst.Rows[0][8].ToString() != "")
        {
            l_vat_amt = decimal.Parse(dtMst.Rows[0][8].ToString());
            //l_vat_amt = decimal.Round(l_vat_amt * decimal.Parse(dtMst.Rows[0][8].ToString()), 0);
        }
        else
        {
            l_vat_amt = 0;
        }
        if(dtMst.Rows[0][9].ToString() != "")
        {
            l_tr_rate = decimal.Parse(dtMst.Rows[0][9].ToString());            
        }        
    }
    
    for (i = 0; i < ls_tax_code.Length; i++)
    {
        ls_tax_num[i] = ls_tax_code.Substring(i, 1);
    }
    if (ls_tax_code.Length < 12)
    {
        for (i = ls_tax_code.Length; i < 12; i++)
        {
            ls_tax_num[i] = "";
        }
    }
     SQL
        = "select d.remark2, '' uom, null qty, null u_price, d.tr_amt, d.tr_rate  " +
            "from tac_hgtrd d  " +
            "where d.tac_hgtrh_pk = '" + ls_tac_hgtrh_pk + "' " +
            "and d.del_if = 0 " +
            "and d.drcr_type = 'C' " +
            "and d.tac_abacctcode_pk not in (select d.tac_abacctcode_pk from tac_mtvat d where d.tac_hgtrh_pk = d.tac_hgtrh_pk and d.del_if = 0) ";
    DataTable dtItem = ESysLib.TableReadOpen(SQL);
    decimal ls_amount = 0;
    
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Page_files/filelist.xml">
<style id="File in Hoa don_2_479_Styles"><!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.xl26479
	{padding-top:1px;
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
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl27479
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl28479
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl29479
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl30479
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl31479
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl32479
	{padding-top:1px;
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
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl33479
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl34479
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl35479
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36479
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37479
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl38479
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39479
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:13.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:justify;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl40479
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl41479
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42479
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43479
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44479
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
--></style>
</head>

<body>
<!--[if !excel]>&nbsp;&nbsp;<![endif]-->
<!--The following information was generated by Microsoft Office Excel's Publish
as Web Page wizard.-->
<!--If the same item is republished from Excel, all information between the DIV
tags will be replaced.-->
<!----------------------------->
<!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD -->
<!----------------------------->

<div id="File in Hoa don_2_479" align=center x:publishsource="Excel">

<table x:str border=0 cellpadding=0 cellspacing=0 width=809 class=xl27479
 style='border-collapse:collapse;table-layout:fixed;width:607pt'>
 <col class=xl27479 width=32 style='mso-width-source:userset;mso-width-alt:
 1170;width:24pt'>
 <col class=xl27479 width=23 span=8 style='mso-width-source:userset;mso-width-alt:
 841;width:17pt'>
 <col class=xl27479 width=28 style='mso-width-source:userset;mso-width-alt:
 1024;width:21pt'>
 <col class=xl27479 width=39 style='mso-width-source:userset;mso-width-alt:
 1426;width:29pt'>
 <col class=xl27479 width=21 span=2 style='mso-width-source:userset;mso-width-alt:
 768;width:16pt'>
 <col class=xl27479 width=3 style='mso-width-source:userset;mso-width-alt:109;
 width:2pt'>
 <col class=xl27479 width=21 span=3 style='mso-width-source:userset;mso-width-alt:
 768;width:16pt'>
 <col class=xl27479 width=15 style='mso-width-source:userset;mso-width-alt:
 548;width:11pt'>
 <col class=xl27479 width=48 style='mso-width-source:userset;mso-width-alt:
 1755;width:36pt'>
 <col class=xl27479 width=21 span=2 style='mso-width-source:userset;mso-width-alt:
 768;width:16pt'>
 <col class=xl27479 width=3 style='mso-width-source:userset;mso-width-alt:109;
 width:2pt'>
 <col class=xl27479 width=21 style='mso-width-source:userset;mso-width-alt:
 768;width:16pt'>
 <col class=xl27479 width=3 style='mso-width-source:userset;mso-width-alt:109;
 width:2pt'>
 <col class=xl27479 width=21 span=3 style='mso-width-source:userset;mso-width-alt:
 768;width:16pt'>
 <col class=xl27479 width=3 style='mso-width-source:userset;mso-width-alt:109;
 width:2pt'>
 <col class=xl27479 width=21 style='mso-width-source:userset;mso-width-alt:
 768;width:16pt'>
 <col class=xl27479 width=23 style='mso-width-source:userset;mso-width-alt:
 841;width:17pt'>
 <col class=xl27479 width=22 style='mso-width-source:userset;mso-width-alt:
 804;width:17pt'>
 <col class=xl27479 width=90 style='mso-width-source:userset;mso-width-alt:
 3291;width:68pt'>
 <col class=xl27479 width=64 style='width:48pt'>
 <col class=xl27479 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:2340'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl30479 width=32 style='height:15.0pt;width:24pt'>&nbsp;</td>
  <td class=xl30479 width=23 style='width:17pt'>&nbsp;</td>
  <td class=xl30479 width=23 style='width:17pt'>&nbsp;</td>
  <td class=xl30479 width=23 style='width:17pt'>&nbsp;</td>
  <td class=xl30479 width=23 style='width:17pt'>&nbsp;</td>
  <td class=xl30479 width=23 style='width:17pt'>&nbsp;</td>
  <td class=xl30479 width=23 style='width:17pt'>&nbsp;</td>
  <td class=xl30479 width=23 style='width:17pt'>&nbsp;</td>
  <td class=xl30479 width=23 style='width:17pt'>&nbsp;</td>
  <td class=xl30479 width=28 style='width:21pt'>&nbsp;</td>
  <td class=xl30479 width=39 style='width:29pt'>&nbsp;</td>
  <td class=xl30479 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl30479 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl30479 width=3 style='width:2pt'>&nbsp;</td>
  <td class=xl30479 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl30479 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl30479 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl30479 width=15 style='width:11pt'>&nbsp;</td>
  <td class=xl30479 width=48 style='width:36pt'>&nbsp;</td>
  <td class=xl30479 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl30479 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl30479 width=3 style='width:2pt'>&nbsp;</td>
  <td class=xl30479 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl30479 width=3 style='width:2pt'>&nbsp;</td>
  <td class=xl30479 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl30479 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl30479 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl30479 width=3 style='width:2pt'>&nbsp;</td>
  <td class=xl30479 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl30479 width=23 style='width:17pt'>&nbsp;</td>
  <td class=xl30479 width=22 style='width:17pt'>&nbsp;</td>
  <td class=xl27479 width=90 style='width:68pt'></td>
  <td class=xl27479 width=64 style='width:48pt'></td>
  <td class=xl27479 width=0></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl30479 style='height:15.0pt'>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl30479 style='height:15.0pt'>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl30479 style='height:27.0pt'>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479 align=right x:num><%=int.Parse(ls_invoice_date.Substring(6, 2))%></td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479 align=right x:num><%=int.Parse(ls_invoice_date.Substring(4, 2))%></td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479 align=right x:num><%=int.Parse(ls_invoice_date.Substring(0, 4))%></td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl27479 style='height:15.0pt'></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl28479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl28479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl27479 style='height:15.0pt'></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
 </tr>
 <tr height=9 style='mso-height-source:userset;height:6.75pt'>
  <td height=9 class=xl30479 style='height:6.75pt'>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl27479 style='height:15.0pt'></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl28479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl28479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl30479 style='height:15.0pt'>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl30479 style='height:15.0pt'>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl30479 style='height:15.0pt'>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl30479>&nbsp;</td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl27479 style='height:17.25pt'></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479 colspan=1 align=left><%=ls_recv_person %></td>
  <td class=xl27479 colspan=1 align=left></td>
  <td class=xl27479 colspan=1 align=left></td>
  <td class=xl27479 colspan=1 align=left></td>
  <td class=xl27479 colspan=1 align=left></td>
  <td class=xl27479 colspan=1 align=left></td>
  <td class=xl27479 colspan=1 align=left></td>
  <td class=xl27479 colspan=1 align=left></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl27479 style='height:17.25pt'></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479 colspan=1 align=left><%=dtMst.Rows[0][2].ToString() %></td>
  <td class=xl27479 colspan=1 align=left></td>
  <td class=xl27479 colspan=1 align=left></td>
  <td class=xl27479 colspan=1 align=left></td>
  <td class=xl27479 colspan=1 align=left></td>
  <td class=xl27479 colspan=1 align=left></td>
  <td class=xl27479 colspan=1 align=left></td>
  <td class=xl27479 colspan=1 align=left></td>  
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl27479 style='height:20.25pt'></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479 colspan=1 align=left><%= dtMst.Rows[0][3].ToString() %></td>
  <td class=xl27479 colspan=1 align=left></td>
  <td class=xl27479 colspan=1 align=left></td>
  <td class=xl27479 colspan=1 align=left></td>
  <td class=xl27479 colspan=1 align=left></td>
  <td class=xl27479 colspan=1 align=left></td>
  <td class=xl27479 colspan=1 align=left></td>
  <td class=xl27479 colspan=1 align=left></td>
  <td class=xl27479 colspan=1 align=left></td>
  <td class=xl27479 colspan=1 align=left></td>
  <td class=xl27479 colspan=1 align=left></td>
  <td class=xl27479 colspan=1 align=left></td>  
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl27479 style='height:15.75pt'></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479 align=left></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl27479 style='height:18.75pt'></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479 colspan=2 align=left><%=dtMst.Rows[0][4].ToString() %></td>
  <td class=xl26479></td>
  <td class=xl31479 x:num><%=ls_tax_num[0]%></td>
  <td class=xl31479 x:num><%=ls_tax_num[1]%></td>
  <td class=xl31479 x:num></td>
  <td class=xl31479 x:num><%=ls_tax_num[2]%></td>
  <td class=xl31479 x:num><%=ls_tax_num[3]%></td>
  <td class=xl31479 x:num><%=ls_tax_num[4]%></td>
  <td class=xl31479 x:num></td>
  <td class=xl31479 x:num><%=ls_tax_num[5]%></td>
  <td class=xl31479 x:num><%=ls_tax_num[6]%></td>
  <td class=xl31479 x:num><%=ls_tax_num[7]%></td>
  <td class=xl31479></td>
  <td class=xl31479 x:num><%=ls_tax_num[8]%></td>
  <td class=xl31479></td>
  <td class=xl31479><%=ls_tax_num[9]%></td>
  <td class=xl31479><%=ls_tax_num[10]%></td>
  <td class=xl31479><%=ls_tax_num[11]%></td>
  <td class=xl31479></td>
  <td class=xl31479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479 align=left></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 class=xl27479 style='height:10.5pt'></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479 align=left></td>
 </tr>
 <tr class=xl29479 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl32479 width=32 style='height:17.25pt;width:24pt'></td>
  <td colspan=10 class=xl44479 width=251 style='width:186pt'></td>
  <td colspan=3 class=xl44479 width=45 style='width:34pt'></td>
  <td colspan=4 class=xl44479 width=78 style='width:59pt'></td>
  <td colspan=3 class=xl44479 width=90 style='width:68pt'></td>
  <td class=xl29479 width=3 style='width:2pt'></td>
  <td colspan=8 class=xl44479 width=134 style='width:101pt'></td>
  <td class=xl29479 width=22 style='width:17pt'></td>
  <td class=xl29479 width=90 style='width:68pt'></td>
  <td class=xl29479 width=64 style='width:48pt'></td>
  <td class=xl29479 width=0></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl27479 style='height:15.0pt'></td>
  <td colspan=10 class=xl31479></td>
  <td colspan=3 class=xl31479></td>
  <td colspan=4 class=xl31479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td colspan=8 class=xl31479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
 </tr>
 <% 
     int l_count_row = 0;
     l_net_amt = 0;
     for (i = 0; i < dtItem.Rows.Count; i++)
     {
         ls_amount = decimal.Parse(dtItem.Rows[i][4].ToString());
         l_count_row = l_count_row + 1;
         l_net_amt += ls_amount;
 %> 
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl33479 style='height:21.0pt'></td>
  <% 
     if (i == 9)
     {
         if (l_tr_rate != 1)
         {
  %>
  <td colspan=10 class=xl36479>Trị giá <%= l_net_amt%> * <%= l_tr_rate%></td>
  <% 
      }
      else
      {
  %>
  <td colspan=10 class=xl36479></td>
  <% 
      }
  %>
  <td colspan=3 class=xl34479></td>
  <td colspan=4 class=xl34479 x:num></td>
  <td colspan=4 class=xl34479 x:num></td>  
  <td colspan=3 class=xl34479>VND</td>
  <td colspan=5 class=xl42479 style='mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><span
  style='mso-spacerun:yes'> </span><%=decimal.Round(l_net_amt * l_tr_rate, 0)%> </td>
  
  <% 
     }
     else
     {
  %>
    <td colspan=10 class=xl36479><%=dtItem.Rows[i][0]%></td>
  <td colspan=3 class=xl34479><%=dtItem.Rows[i][1]%></td>
  <td colspan=4 class=xl34479 x:num><%=dtItem.Rows[i][2]%></td>
  <td colspan=4 class=xl34479 x:num><%=dtItem.Rows[i][3]%></td>
  <td colspan=3 class=xl34479></td>
  <%  
      if (l_tr_rate != 1)
      {         
  %>
  <td colspan=5 class=xl42479 x:num><span
  style='mso-spacerun:yes'> </span><%=ls_amount%> </td>  
  <% 
      }
      else
      {
  %>
  <td colspan=5 class=xl42479 style='mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><span
  style='mso-spacerun:yes'> </span><%=ls_amount%> </td>    
   <% 
      }
     } // if
%>  
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
 </tr>
 <%
 } // for                
 if (l_count_row < 10)
    {
        for (i = l_count_row; i < 10; i++)
        {
 %>
  <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl33479 style='height:21.0pt'></td>
  <% 
    if(i == 9)
    {
  %>
  <% 
    if(l_tr_rate != 1)
    {
  %>
  <td colspan=10 class=xl43479>Trị giá <%= l_net_amt%> * <%= l_tr_rate%></td>
  <% 
    }
    else
    {
  %>
  <td colspan=10 class=xl43479></td>
  <% 
  }
  %>
  <td colspan=3 class=xl34479></td>
  <td colspan=4 class=xl34479 x:num></td>
  <td colspan=4 class=xl34479 x:num></td>
  <td colspan=3 class=xl34479>VND</td>
  <td colspan=5 class=xl42479 style='mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><span
  style='mso-spacerun:yes;'> </span><%=decimal.Round(l_net_amt * l_tr_rate, 0) %></td>  
  <% 
    }
    else
    {
  %>
  <td colspan=10 class=xl43479></td>
  <td colspan=3 class=xl34479></td>
  <td colspan=4 class=xl34479 x:num></td>
  <td colspan=4 class=xl34479 x:num></td>  
  <td colspan=3 class=xl34479></td>
    <td colspan=5 class=xl42479 x:num><span
  style='mso-spacerun:yes'> </span></td>
  <% 
     }
  %>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
 </tr>
<% 
     }
}
%>
 <% 
     l_total_amt = decimal.Round(l_net_amt * l_tr_rate, 0) + l_vat_amt;
    ls_doc_tien = CommondLib.Num2VNText(l_total_amt.ToString(), "VND");
 %>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl27479 style='height:19.5pt'></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td colspan=3 class=xl31479>VND</td>
  <td colspan=8 class=xl40479 x:num><span
  style='mso-spacerun:yes'>        </span><%=decimal.Round(l_net_amt * l_tr_rate, 0)%> </td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl27479 style='height:15.75pt'></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td colspan=2 class=xl31479 x:num><%=ls_tax_rate %></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td colspan=3 class=xl31479>VND</td>
  <td colspan=8 class=xl40479 x:num><span
  style='mso-spacerun:yes'>        </span><%=l_vat_amt %> </td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27479 style='height:15.0pt'></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td colspan=3 class=xl31479>VND</td>
  <td colspan=8 class=xl40479 x:num><span
  style='mso-spacerun:yes'>        </span><%=l_total_amt %> </td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl27479 style='height:17.25pt'></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td colspan=22 rowspan=2 class=xl39479 width=440 style='width:331pt'><%=ls_doc_tien %></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl27479 style='height:17.25pt'></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
  <td class=xl27479></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=32 style='width:24pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=3 style='width:2pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=15 style='width:11pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=3 style='width:2pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=3 style='width:2pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=3 style='width:2pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=22 style='width:17pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=0></td>
 </tr>
 <![endif]>
</table>

</div>


<!----------------------------->
<!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD-->
<!----------------------------->
</body>

</html>

