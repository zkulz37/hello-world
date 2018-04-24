<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string ls_tco_company_pk = "", ls_tr_date_from = "", ls_tr_date_to = "", ls_tac_abpl_pk = "";
	string ls_tac_abcenter_pk = "";
    string SQL = "";
    string ls_pl_cd = "";
    ls_tco_company_pk           = Request["company_pk"];
    ls_tr_date_from             = Request["tr_date_from"];
    ls_tr_date_to               = Request["tr_date_to"];
    ls_tac_abpl_pk              = Request["tac_abpl_pk"];
	ls_tac_abcenter_pk			= Request["tac_abcenter_pk"];
    string ls_grp_tra_ve        = "SALESO" ; // account nhom tra ve
    string ls_grp_ban_ve        = "SALESI" ; // account nhom ban ve
    string ls_grp_hop_dong      = "SALESC" ; // account nhom hop dong
    string ls_grp_expenses      = "";
    string ls_from_to_date = "Từ ngày " + ls_tr_date_from.Substring(6, 2) + "/" + ls_tr_date_from.Substring(4, 2) + "/" + ls_tr_date_from.Substring(0, 4) + " đến ngày " + ls_tr_date_to.Substring(6, 2) + "/" + ls_tr_date_to.Substring(4, 2) + "/" + ls_tr_date_to.Substring(0, 4);

SQL
	= "select to_char(to_date(tbl.tr_date, 'yyyymmdd'), 'dd/mm/yyyy') tr_date, plc.plc_cd, tbl.srn_banve, tbl.invoice_no seri_begin,  " + 
        "    max(tbl.invoice_no) seri_end, sum(tbl.qty_banve) qty_banve, " +
        "    tbl.srn_trave, sum(tbl.qty_trave) qty_trave, sum(tbl.qty_banve) - sum(tbl.qty_trave) qty_thucban, tbl.u_price,  " +
        "    sum(tbl.tr_amt_trave) tr_amt_trave, sum(tbl.tr_amt_banve) tr_amt_banve, sum(tbl.tr_amt_hopdong) tr_amt_hopdong,  " +
        "    sum(tbl.tr_amt_trave) + sum(tbl.tr_amt_banve) + sum(tbl.tr_amt_hopdong) tot_tr_amt      " +
        "    from (         " +
        "        select ar_mst.tr_date,              xe.pk tac_abpl_pk,          xe_chn.tac_abcenter_pk,  " +
        "        ar.u_price u_price,                 ar_mst.serial_no srn_banve,   NULL srn_trave,  " +
        "        ar_mst.invoice_no, sum(ar.qty) qty_banve,      sum(ar.net_tr_amt) tr_amt_banve, " +
        "        0 qty_trave, 0 tr_amt_trave, 0 tr_amt_hopdong  " +
        "        from tac_crcad ar, tac_crca ar_mst, tac_abpl xe, tac_abplcenter xe_chn " +        
        "        where ar.del_if     = 0  " +
        "        and   ar_mst.del_if = 0 " +
        "        and   xe_chn.del_if = 0 " +
        "        and  ar_mst.tr_status in ('2', '0', '4')  " +
        "        and   ar.tac_crca_pk = ar_mst.pk " +
        "        and ar.tac_abplcenter_pk = xe_chn.pk   " +
        "        and xe_chn.tac_abpl_pk   = xe.pk " +
        "        and ar.tac_abacctcode_pk IN ( " +
        "          SELECT distinct D.TAC_ABACCTCODE_PK  " +
        "            FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
        "           WHERE D.DEL_IF           = 0  " +
        "             AND H.DEL_IF           = 0 " +
        "             AND D.TAC_ABTRACGRP_PK = H.PK " +
        "             AND H.AC_GRP           = '" + ls_grp_ban_ve + "'" +
        "        ) " +
        "        and ar_mst.tr_date between '" + ls_tr_date_from + "' and '" + ls_tr_date_to + "' " +
        "        and xe.pk = '" + ls_tac_abpl_pk + "'               " +
		"        and xe_chn.tac_abcenter_pk = '" + ls_tac_abcenter_pk + "'               " +
        "        group by ar_mst.tr_date, xe.pk, xe_chn.tac_abcenter_pk, ar.u_price, ar_mst.serial_no, ar_mst.invoice_no " +
        "        union all " +
        "        select ar_mst.tr_date, xe.pk tac_abpl_pk, xe_chn.tac_abcenter_pk,  " +
        "        NULL uprice, NULL srn_trave, ar_mst.serial_no srn_trave,  " +
        "        ar_mst.invoice_no, 0 qty_banve, 0 tr_amt_banve,                   " +
        "        sum(ar.qty) qty_trave,      sum(ar.net_tr_amt) tr_amt_trave, " +
        "        0 tr_amt_hopdong  " +
        "        from tac_crcad ar, tac_crca ar_mst, tac_abpl xe, tac_abplcenter xe_chn " +
        "        where ar.del_if     = 0  " +
        "        and   ar_mst.del_if = 0 " +
        "        and   xe_chn.del_if = 0         " +
        "        and  ar_mst.tr_status in ('2', '0', '4') " +
        "        and   ar.tac_crca_pk = ar_mst.pk " +
        "        and ar.tac_abplcenter_pk = xe_chn.pk   " +
        "        and xe_chn.tac_abpl_pk   = xe.pk " +
        "        and ar.tac_abacctcode_pk IN ( " +
        "          SELECT DISTINCT D.TAC_ABACCTCODE_PK  " +
        "            FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
        "           WHERE D.DEL_IF           = 0  " +
        "             AND H.DEL_IF           = 0 " +
        "             AND D.TAC_ABTRACGRP_PK = H.PK " +
        "             AND H.AC_GRP           = '" + ls_grp_tra_ve + "' " +
        "        ) " +
        "        and ar_mst.tr_date between '" + ls_tr_date_from + "' and '" + ls_tr_date_to + "' " +
        "        and xe.pk = '" + ls_tac_abpl_pk + "'                " +
		"        and xe_chn.tac_abcenter_pk = '" + ls_tac_abcenter_pk + "'               " +		
        "        group by ar_mst.tr_date, xe.pk, xe_chn.tac_abcenter_pk, ar.u_price, ar_mst.serial_no, ar_mst.invoice_no " +
        "        union all " +
        "        select ar_mst.tr_date,              xe.pk tac_abpl_pk,          xe_chn.tac_abcenter_pk,  " +
        "        0 u_price,                 NULL srn_banve, NULL srn_trave,  " +
        "        ar_mst.invoice_no, 0 qty_banve, 0 tr_amt_banve,                   " +
        "        0 qty_trave,      0 tr_amt_trave, " +
        "        sum(ar.net_tr_amt) tr_amt_hopdong  " +
        "        from tac_crcad ar, tac_crca ar_mst, tac_abpl xe, tac_abplcenter xe_chn " +
        "        where ar.del_if     = 0  " +
        "        and   ar_mst.del_if = 0 " +
        "        and   xe_chn.del_if = 0 " +
        "        and  ar_mst.tr_status in ('2', '0', '4')         " +
        "        and   ar.tac_crca_pk = ar_mst.pk " +
        "        and ar.tac_abplcenter_pk = xe_chn.pk   " +
        "        and xe_chn.tac_abpl_pk   = xe.pk " +
        "        and ar.tac_abacctcode_pk IN ( " +
        "          SELECT DISTINCT D.TAC_ABACCTCODE_PK  " +
        "            FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
        "           WHERE D.DEL_IF           = 0  " +
        "             AND H.DEL_IF           = 0 " +
        "             AND D.TAC_ABTRACGRP_PK = H.PK " +
        "             AND H.AC_GRP           = '" + ls_grp_hop_dong + "' " +
        "        ) " +
        "        and ar_mst.tr_date between '" + ls_tr_date_from + "' and '" + ls_tr_date_to  + "' " +
        "        and xe.pk = '" + ls_tac_abpl_pk + "'              " +
		"        and xe_chn.tac_abcenter_pk = '" + ls_tac_abcenter_pk + "'               " +		
        "        group by ar_mst.tr_date, xe.pk, xe_chn.tac_abcenter_pk, xe_chn.pk, ar_mst.invoice_no " +
        "    ) " +
        "    tbl, tac_abpl pl, tac_abcenter plc  " +
        "    where tbl.tac_abpl_pk = pl.pk(+) " +
        "    and tbl.tac_abcenter_pk = plc.pk(+) " +
        "    group by tbl.tr_date, plc.plc_cd, tbl.srn_banve, tbl.srn_trave, tbl.u_price, tbl.invoice_no " +
		" order by tr_date asc " ;

    DataTable dtIncome = new DataTable();        
    dtIncome = ESysLib.TableReadOpen(SQL) ;     
       
    //Hao phi            
    SQL
	= "select partner_name, tax_code, NVL(addr1,'') || ' ' || NVL(addr2, ' ') || ' ' || NVL(addr3, '') address " + 
        "from comm.tco_company " +
        "where del_if = 0 and pk = '" + ls_tco_company_pk + "' " ;
    DataTable dtComp        = new DataTable();        
    dtComp                  = ESysLib.TableReadOpen(SQL) ;
    // nhom tai khoan hao phi    
    /*SQL = "select code FROM TCO_ABCODE A, TCO_ABCODEGRP B where a.TCO_ABCODEGRP_PK = B.PK and B.ID = 'ACBG0020' and upper(a.code_nm) = 'EXPENSES' ";
    DataTable dtGrpExpense  = new DataTable();
    dtGrpExpense            = ESysLib.TableReadOpen(SQL) ;
    if(dtGrpExpense.Rows.Count > 0)
    {
        ls_grp_expenses         = dtGrpExpense.Rows[0][0].ToString() ;        
    }
    else
    {
        Response.Write("Cannot display the report because user has not defined the expense account group!!!");
        Response.End();
    }        */
 SQL
    = "        select   max (b.ac_lnm) cac_chi_tieu, b.ac_cd tai_khoan, e.pl_cd, e.pl_nm, " + 
        "             decode (max (drcr_type), 'D', sum (ymd_drtrans), sum (ymd_crtrans)) so_tien " +
        "        from tac_hgplddbal a, tac_abacctcode b, tac_abplcenter c, tac_abcenter d, tac_abpl e, " +
        "        tac_hgtrh g, " +
        "         ( " +
        "                SELECT  D.TAC_ABACCTCODE_PK " +
        "            FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
        "           WHERE D.DEL_IF           = 0  " +
        "             AND H.DEL_IF           = 0 " +
        "             AND D.TAC_ABTRACGRP_PK = H.PK " +
        "             AND H.AC_GRP IN ('811', '642', '6421', '641', '6411', '621', '622', '627','6271') " +
        "             AND H.TCO_COMPANY_PK = '" + ls_tco_company_pk + "' " +
        "         ) f " +
        "       where a.del_if                  = 0 " +
        "            and g.del_if               = 0 " +
        "         and a.tac_abacctcode_pk       = b.pk " +
        "         and b.pk                      = f.tac_abacctcode_pk " +
        "         and b.pl_yn                   = 'Y' " +
        "         and a.tac_abplcenter_pk       = c.pk " +
        "         and c.tac_abcenter_pk         = d.pk " +
        "         and c.tac_abpl_pk             = e.pk " +
        "         and a.tac_hgtrh_pk            = g.pk " +
        "         and a.tco_company_pk          = '" + ls_tco_company_pk + "'          " +
        "         and a.std_ymd between '" + ls_tr_date_from + "' and '" + ls_tr_date_to + "'   " +
        "         and decode('" + ls_tac_abpl_pk + "', 'ALL', '" + ls_tac_abpl_pk + "', e.pk) = '" + ls_tac_abpl_pk + "' " +
        "         and decode('" + ls_tac_abcenter_pk + "', 'ALL', '" + ls_tac_abcenter_pk + "', d.pk) = '" + ls_tac_abcenter_pk + "' " +		
        "         and g.tr_status in ('0', '2')           " +
        "    GROUP BY b.ac_cd, e.pl_cd, e.pl_nm " ;
    DataTable dtExpense = new DataTable();        
    dtExpense = ESysLib.TableReadOpen(SQL) ;        
    if(ls_tac_abpl_pk != "ALL")
    {
        SQL         = "select pl_cd || '-' || pl_nm from tac_abpl where del_if = 0 and pk = '" + ls_tac_abpl_pk + "' " ;
        DataTable dtPL = new DataTable();        
        dtPL    = ESysLib.TableReadOpen(SQL) ;
        ls_pl_cd    = dtPL.Rows[0][0].ToString();
    }
    else
        ls_pl_cd = "Tất cả" ;                    
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Doanh%20thu%20Kumho_files/filelist.xml">
<link rel=Edit-Time-Data href="Doanh%20thu%20Kumho_files/editdata.mso">
<link rel=OLE-Object-Data href="Doanh%20thu%20Kumho_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>van</o:Author>
  <o:LastAuthor>van</o:LastAuthor>
  <o:Created>2009-01-22T02:55:25Z</o:Created>
  <o:LastSaved>2009-01-22T03:17:47Z</o:LastSaved>
  <o:Company>vinagenuwin</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl32
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
	background:white;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid red;
	border-right:none;
	border-bottom:1.0pt solid red;
	border-left:1.0pt solid red;
	background:white;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid red;
	border-right:none;
	border-bottom:1.0pt solid red;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid red;
	border-right:1.0pt solid red;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl37
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
.xl38
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format: General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
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
.xl42
	{mso-style-parent:style0;
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
.xl43
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style16;
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
.xl45
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid red;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid red;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style16;
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
.xl50
	{mso-style-parent:style16;
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
.xl51
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style16;
	font-weight:700;
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
.xl55
	{mso-style-parent:style16;
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
.xl56
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid red;
	border-bottom:1.0pt solid red;
	border-left:1.0pt solid red;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;}
.xl60
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
.xl61
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl62
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;}
.xl63
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl65
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl66
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
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
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid red;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl76
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid red;
	border-left:none;}
.xl77
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid red;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid red;
	border-left:1.0pt solid red;}
.xl78
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid red;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid red;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid red;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid red;
	border-left:none;}
.xl80
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid red;
	border-bottom:1.0pt solid red;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid red;
	border-bottom:1.0pt solid red;
	border-left:none;}
.xl82
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;}
.xl83
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl84
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl85
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl86
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl87
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
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl89
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl90
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl92
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl93
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl94
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl95
	{mso-style-parent:style0;
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
.xl96
	{mso-style-parent:style0;
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
.xl97
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl98
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl99
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl100
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl101
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl102
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid red;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl103
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl104
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid red;
	border-right:1.0pt solid red;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl105
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid red;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl106
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid red;
	border-bottom:none;
	border-left:1.0pt solid red;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl107
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid red;
	border-bottom:.5pt solid black;
	border-left:1.0pt solid red;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl108
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl109
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl110
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl111
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl112
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl113
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl114
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl115
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl116
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid red;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid red;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>THEO TUYEN</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:LeftColumnVisible>2</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>26</x:ActiveRow>
       <x:ActiveCol>13</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11850</x:WindowHeight>
  <x:WindowWidth>19065</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1431 style='border-collapse:
 collapse;table-layout:fixed;width:1074pt'>
 <col class=xl24 width=227 style='mso-width-source:userset;mso-width-alt:8301;
 width:170pt'>
 <col class=xl25 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl26 width=106 style='mso-width-source:userset;mso-width-alt:3876;
 width:80pt'>
 <col class=xl24 width=142 style='mso-width-source:userset;mso-width-alt:5193;
 width:107pt'>
 <col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl24 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl27 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl27 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl27 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 <col class=xl27 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl27 width=96 span=4 style='mso-width-source:userset;mso-width-alt:
 3510;width:72pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=98 style='mso-width-source:userset;mso-width-alt:3584;
 width:74pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 width=227 style='height:12.75pt;width:170pt'>Tên
  công ty</td>
  <td class=xl25 width=83 style='width:62pt'><%=dtComp.Rows[0][0] %></td>
  <td class=xl26 width=106 style='width:80pt'></td>
  <td class=xl24 width=142 style='width:107pt'></td>
  <td class=xl24 width=89 style='width:67pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl27 width=75 style='width:56pt'></td>
  <td class=xl27 width=79 style='width:59pt'></td>
  <td class=xl27 width=85 style='width:64pt'></td>
  <td class=xl27 width=79 style='width:59pt'></td>
  <td class=xl27 width=96 style='width:72pt'></td>
  <td class=xl27 width=96 style='width:72pt'></td>
  <td class=xl27 width=96 style='width:72pt'></td>
  <td class=xl27 width=96 style='width:72pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>Địa chỉ công ty</td>
  <td class=xl25><%=dtComp.Rows[0][2] %></td>
  <td class=xl26></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>Mã số thuế</td>
  <td class=xl25><%=dtComp.Rows[0][1] %></td>
  <td class=xl26></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=14 height=24 class=xl83 style='height:18.0pt'><%=ls_pl_cd %></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 colspan=2 style='height:15.75pt;mso-ignore:colspan'><%=ls_from_to_date %></td>
  <td colspan=12 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=18 style='height:13.5pt'>
  <td colspan=14 height=18 class=xl84 style='border-right:.5pt solid black;
  height:13.5pt'>CÁC CHỈ TIÊU DOANH THU</td>
 </tr>
 <tr class=xl29 height=18 style='height:13.5pt'>
  <td rowspan=3 height=69 class=xl87 width=227 style='border-bottom:.5pt solid black;
  height:51.75pt;width:170pt'>Ngày</td>
  <td rowspan=3 class=xl90 width=83 style='border-bottom:.5pt solid black;
  width:62pt'>Số<br>
    <span style='mso-spacerun:yes'> </span>xe</td>
  <td rowspan=3 class=xl87 width=106 style='border-bottom:.5pt solid black;
  width:80pt'>Số <br>
    seri</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td rowspan=3 class=xl93 width=85 style='border-bottom:.5pt solid black;
  width:64pt'>Tổng<br>
    số vé = (a)-(b)</td>
  <td rowspan=3 class=xl95 width=79 style='border-bottom:.5pt solid black;
  width:59pt'>Đơn<br>
    giá</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr class=xl31 height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl99 width=313 style='border-right:.5pt solid black;
  height:12.75pt;border-left:none;width:236pt'>Số hoá đơn</td>
  <td colspan=2 class=xl101 width=154 style='border-right:.5pt solid black;
  border-left:none;width:115pt'>Trả vé<br>
    (số seri)</td>
  <td rowspan=2 class=xl102 width=96 style='border-bottom:.5pt solid black;
  border-top:none;width:72pt'>Doanh thu trả vé</td>
  <td rowspan=2 class=xl102 width=96 style='border-bottom:.5pt solid black;
  border-top:none;width:72pt'>Doanh thu bán vé</td>
  <td rowspan=2 class=xl104 width=96 style='border-bottom:.5pt solid black;
  border-top:none;width:72pt'>Doanh thu hợp đồng</td>
  <td rowspan=2 class=xl106 width=96 style='border-bottom:.5pt solid black;
  width:72pt'>Tổng doanh thu</td>
 </tr>
 <tr class=xl31 height=34 style='height:25.5pt'>
  <td height=34 class=xl36 width=142 style='height:25.5pt;width:107pt'>Từ
  <br>
    số</td>
  <td class=xl36 width=89 style='width:67pt'>Đến <br>
    số</td>
  <td class=xl36 width=82 style='width:62pt'>Số lượng(a)</td>
  <td class=xl37 width=75 style='width:56pt'>Số <br>
    seri</td>
  <td class=xl37 width=79 style='width:59pt'>Số lượng(b)</td>
 </tr>
  <% 
    int i;
    decimal l_sum_sl_ve_ban = 0 ;
    decimal l_sum_sl_ve_tra = 0 ;
    decimal l_sum_sl_ve_thuc = 0 ;
    decimal l_sum_dt_ve_tra = 0 ;
    decimal l_sum_dt_ve_ban = 0 ;
    decimal l_sum_dt_hop_dong = 0 ;
    decimal l_sum_dt_tong = 0 ;
    string ls_trans_dt = "";
    string ls_plc_cd = "";
    
    for(i = 0; i < dtIncome.Rows.Count ; i++)
    {    
        // so luong ve da ban
        if(dtIncome.Rows[i][5].ToString().Trim() != "")
            l_sum_sl_ve_ban += decimal.Parse(dtIncome.Rows[i][5].ToString());
        // so luong ve bi tra lai            
        if(dtIncome.Rows[i][7].ToString().Trim() != "")        
            l_sum_sl_ve_tra += decimal.Parse(dtIncome.Rows[i][7].ToString());
        // so luong ve thuc da ban di
        if(dtIncome.Rows[i][8].ToString().Trim() != "")        
            l_sum_sl_ve_thuc += decimal.Parse(dtIncome.Rows[i][8].ToString());
        // doanh thu ban ve    
        if(dtIncome.Rows[i][11].ToString().Trim() != "")
            l_sum_dt_ve_ban += decimal.Parse(dtIncome.Rows[i][11].ToString());
        // doanh thu ve tra            
        if(dtIncome.Rows[i][10].ToString().Trim() != "")
            l_sum_dt_ve_tra += decimal.Parse(dtIncome.Rows[i][10].ToString());
        //doanh thu hop dong
        if(dtIncome.Rows[i][12].ToString().Trim() != "")
            l_sum_dt_hop_dong += decimal.Parse(dtIncome.Rows[i][12].ToString());
        if(dtIncome.Rows[i][13].ToString().Trim() != "")
            l_sum_dt_tong += decimal.Parse(dtIncome.Rows[i][13].ToString());                
 %>

 <tr class=xl38 height=22 style='mso-height-source:userset;height:16.5pt'>
  <% 
    if(ls_trans_dt != dtIncome.Rows[i][0].ToString().Trim())       
    {
 %>
  <td height=22 class=xl39 style='height:16.5pt' ><%=dtIncome.Rows[i][0] %></td>
  <%  
        ls_trans_dt = dtIncome.Rows[i][0].ToString() ;
    }
    else
    {
  %>
    <td height=22 class=xl39 style='height:16.5pt' >&nbsp;</td>
  <% 
    }
  %>
  <% 
  if(ls_plc_cd != dtIncome.Rows[i][1].ToString().Trim())
  {
  %>      
  <td class=xl40><%=dtIncome.Rows[i][1] %></td>
  <% 
        ls_plc_cd = dtIncome.Rows[i][1].ToString() ;
  }
  else
  {
  %>
   <td class=xl40>&nbsp;</td>
  <% 
  }
  %>      
  <td class=xl41><%=dtIncome.Rows[i][2] %></td>
  <td class=xl42 x:num><%=dtIncome.Rows[i][3] %></td>
  <td class=xl42 x:num><%=dtIncome.Rows[i][4] %></td>
  <td class=xl43 x:num><%=dtIncome.Rows[i][5] %></td>
  <td class=xl44><%=dtIncome.Rows[i][6] %></td>
  <td class=xl44 x:num><span style='mso-spacerun:yes'> </span><%=dtIncome.Rows[i][7] %></td>
  <td class=xl44 x:num><span style='mso-spacerun:yes'> </span><%=dtIncome.Rows[i][8] %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl45 x:num><span
  style='mso-spacerun:yes'> </span><%=dtIncome.Rows[i][9] %></td>
  <td class=xl45 x:num><span
  style='mso-spacerun:yes'> </span><%=dtIncome.Rows[i][10] %></td>
  <td class=xl45 x:num><span style='mso-spacerun:yes'> </span><%=dtIncome.Rows[i][11] %></td>
  <td class=xl46 x:num><span
  style='mso-spacerun:yes'> </span><%=dtIncome.Rows[i][12] %></td>
  <td class=xl116 x:num><span
  style='mso-spacerun:yes'> </span><%=dtIncome.Rows[i][13] %></td>
 </tr>
 <% } %>
 <tr class=xl38 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=2 height=22 class=xl108 style='border-right:.5pt solid black;
  height:16.5pt'>Tổng:</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl53 x:num><span
  style='mso-spacerun:yes'> </span><%=l_sum_sl_ve_ban %></td>
  <td class=xl54>&nbsp;</td>
  <td class=xl54 x:num><span
  style='mso-spacerun:yes'> </span><%=l_sum_sl_ve_tra %></td>
  <td class=xl55 x:num><span
  style='mso-spacerun:yes'> </span><%=l_sum_sl_ve_thuc %><span style='mso-spacerun:yes'></span></td>
  <td class=xl56>&nbsp;</td>
  <td class=xl57 x:num><%=l_sum_dt_ve_tra %><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl56 x:num><span
  style='mso-spacerun:yes'> </span><%=l_sum_dt_ve_ban %></td>
  <td class=xl56 x:num><span
  style='mso-spacerun:yes'> </span><%=l_sum_dt_hop_dong %></td>
  <td class=xl58 x:num><span
  style='mso-spacerun:yes'> </span><%=l_sum_dt_tong %></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl59></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl59></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl59></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td rowspan=2 height=38 class=xl110 style='border-bottom:.5pt solid black;
  height:28.5pt' x:str>CÁC CHỈ TIÊU VỀ CHI PHÍ<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl112 style='border-bottom:.5pt solid black'>TÀI KHOẢN</td>
  <td colspan=2 class=xl114 style='border-right:.5pt solid black;border-left:
  none'>XE</td>
  <td rowspan=2 colspan=2 class=xl110 style='border-bottom:.5pt solid black'>SỐ TIỀN</td>
  <td class=xl24></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl59></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl60 style='height:12.75pt'>MÃ</td>
  <td class=xl60>TÊN</td>
  <td class=xl24></td>
  <td colspan=7 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl59></td>
 </tr>
  <% 
    decimal ls_sum_expense = 0 ;
    string ls_chi_phi = "";
    string ls_tai_khoan = "";
    for(i = 0; i < dtExpense.Rows.Count ; i++)
    {
        if(dtExpense.Rows[i][4].ToString().Trim() != "")            
            ls_sum_expense += decimal.Parse(dtExpense.Rows[i][4].ToString().Trim());
 %>
 <tr class=xl61 height=20 style='mso-height-source:userset;height:15.0pt'>
 <% 
    if(dtExpense.Rows[i][1].ToString().Substring(3,3)=="000")
    {
        if(ls_chi_phi != dtExpense.Rows[i][0].ToString().Trim() )
        {
 %> 
            <td height=20 class=xl63 style='height:15.0pt'><%=dtExpense.Rows[i][0] %></td>
            <td class=xl64><%=dtExpense.Rows[i][1] %></td>
<% 
            ls_chi_phi = dtExpense.Rows[i][0].ToString().Trim();
        }
        else
        {                         
%>       
            <td height=20 class=xl68 style='height:15.0pt'>-</td>
            <td class=xl69>-</td>    
<% 
        }
%>                 
  <td class=xl70><%=dtExpense.Rows[i][2] %></td>
  <td class=xl41><%=dtExpense.Rows[i][3] %></td>
  <td class=xl67 colspan="2" x:num><span
  style='mso-spacerun:yes'>                       </span><%=dtExpense.Rows[i][4] %><span
  style='mso-spacerun:yes'>   </span></td>
  <td colspan=3 class=xl61 style='mso-ignore:colspan'></td>
  <td class=xl62></td>
  <td class=xl27></td>
  <td colspan=4 class=xl62 style='mso-ignore:colspan'></td>
  <% 
    }
    else
    {
        if(ls_chi_phi != dtExpense.Rows[i][0].ToString().Trim() )
        {    
  %>
            <td height=20 class=xl63 style='height:15.0pt'><%=dtExpense.Rows[i][0] %></td>
            <td class=xl64><%=dtExpense.Rows[i][1] %></td>
    <% 
            ls_chi_phi = dtExpense.Rows[i][0].ToString().Trim();     
        }
        else
        {
    %>                                  
            <td height=20 class=xl68 style='height:15.0pt'>-</td>
            <td class=xl69>-</td>
    <% 
        }
    %>  
  <td class=xl70><%=dtExpense.Rows[i][2] %></td>
  <td class=xl41><%=dtExpense.Rows[i][3] %></td>
  <td class=xl67 colspan="2" x:num><span style='mso-spacerun:yes'>                   
  </span><%=dtExpense.Rows[i][4] %></td>
  <td class=xl24></td>
  <td colspan=7 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl59></td>
  <% 
    }
  %>
 </tr>
 <% 
    } //vong for
 %>
 <tr class=xl29 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl77 style='height:26.25pt'>TỔNG CHI PHÍ</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl80 style='border-top:1.0pt solid red'>&nbsp;</td>
  <td class=xl81 colspan=2 style='border-top:1.0pt solid red' x:num><%=ls_sum_expense %></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl59></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl59></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl59></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl59></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl59></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl82></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl59></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl59></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl59></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl59></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl59></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl59></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl59></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl59></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl59></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=227 style='width:170pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=142 style='width:107pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
