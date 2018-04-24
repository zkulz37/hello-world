<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 
    Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string l_tco_company_pk         =Request["p_tco_company_pk"];
    string l_tex_contr_mst_pk       =Request["p_tex_contr_mst_pk"];
    
    string l_cmp_name, l_cmp_add, l_cmp_taxcode;
    double l_adv_amt, l_deduct_amt, l_remain_amt, l_AP_amt, l_G_AP_amt, l_remain_AP, l_pay_amt, l_t_pay_amt, l_remain_contr, l_AP_tr_amt, l_contr_amt;

    l_adv_amt = l_deduct_amt = l_remain_amt = l_AP_amt = l_G_AP_amt = l_remain_AP = l_pay_amt = l_t_pay_amt = l_remain_contr = l_AP_tr_amt = l_contr_amt=0;
    

    string sql_master, sql_adv, sql_deduct, sql_AP, sql_pay, sql_cond;    
    
    sql_master="";      //sql for master contract infor
    sql_adv="";         //sql for advance status
    sql_deduct = "";    // sql for deduct status
    sql_AP="";          //sql for A/P Status
    sql_pay = "";       //sql for Payment Status
    sql_cond = "";      // sql for Condition payment
    
    l_cmp_name = "";
    l_cmp_add = "";
    l_cmp_taxcode = "";
    
    string SQL1 = " SELECT PARTNER_NAME, ADDR1, ADDR2, TAX_CODE " +      
    " FROM TCO_COMPANY WHERE PK = '" + l_tco_company_pk + "' ";
    
    
      DataTable dt_f = ESysLib.TableReadOpen(SQL1);
      if (dt_f.Rows.Count > 0)
      {
          l_cmp_name = dt_f.Rows[0][0].ToString();
          l_cmp_add = dt_f.Rows[0][1].ToString();
          l_cmp_taxcode = dt_f.Rows[0][3].ToString();          
      }
      
     string sql_count="SELECT COUNT(*) FROM IMEX.TIM_CONTR_DTL D WHERE D.DEL_IF=0 AND D.TIM_CONTR_MST_PK='" + l_tex_contr_mst_pk + "'";
     DataTable dt_c = ESysLib.TableReadOpen(sql_count);
     
     if (dt_c.Rows.Count >1)
     {
         sql_master = "select m.CONTR_NO, p.PARTNER_ID,m.B_CCY, p.PARTNER_NAME, pl.plc_cd,pl.plc_nm,M.PERIOD,max(nvl(m.VAT_AMT,0)),max(nvl(m.ADJ_VAT_AMT,0)) " +
                    ",MAX (NVL (m.adj_vat_amt, 0))+ MAX(NVL (m.vat_amt, 0)) as vat_tot,0 as QTY,0 as ADJ_QTY,0 as ADJ_U_PRICE,0 as RETOUCH_AMT, 0 as U_PRICE " +
                    ",0 as qty_sum,0 adv_u_price_sum, " +
                    "sum(nvl(d.TR_AMT,0)),sum(nvl(d.RETOUCH_AMT,0)),sum(nvl(d.TR_AMT,0))+sum(nvl(d.RETOUCH_AMT,0)) amt_sum,max(nvl(m.AR_TR_AMT,0)) " +
                    "from imex.tex_contr_mst m, imex.tex_contr_dtl d, TCO_BUSPARTNER p " +
                    ",(select c.pk, a.PLC_CD, a.PLC_NM " +
                    "    from tac_abcenter a, tac_abpl b, tac_abplcenter c " +
                    "    where a.del_if=0 and b.DEL_IF=0 and c.DEL_IF=0 " +
                    "        and c.TAC_ABCENTER_PK=a.pk " +
                    "        and c.tac_abpl_pk =b.pk ) pl " +
                    "where  " +
                    "    m.DEL_IF=0 and d.DEL_IF=0 " +
                    "    and m.PK(+)=d.TIM_CONTR_MST_PK " +    
                    "    and m.TCO_BUSPARTNER_PK=p.PK(+)  " +
                    "    and m.TAC_ABPLCENTER_PK=pl.pk(+)  " +
                    "    and m.pk='" +l_tex_contr_mst_pk + "' " +
                    "    AND m.STATUS in (0,2) " +
                    " group by m.pk, m.CONTR_NO, p.PARTNER_ID,m.B_CCY, p.PARTNER_NAME, pl.plc_cd,pl.plc_nm ,M.PERIOD";   
     }
     else 
     {
         sql_master = "select m.CONTR_NO, p.PARTNER_ID,m.B_CCY, p.PARTNER_NAME, pl.plc_cd,pl.plc_nm,M.PERIOD,max(nvl(m.VAT_AMT,0)),max(nvl(m.ADJ_VAT_AMT,0))" + 
                    ",sum(nvl(d.QTY,0)),sum(nvl(d.ADJ_QTY,0)),sum(nvl(d.ADJ_U_PRICE,0)), sum(nvl(d.U_PRICE,0)) " +
                    ",MAX (NVL (m.adj_vat_amt, 0))+MAX (NVL (m.vat_amt, 0)) as vat_tot,(sum(nvl(d.QTY,0))+sum(nvl(d.ADJ_QTY,0))) qty_sum,(sum(nvl(d.ADJ_U_PRICE,0))+sum(nvl(d.U_PRICE,0))) price_sum, " +
                    "sum(nvl(d.TR_AMT,0)),sum(nvl(d.RETOUCH_AMT,0)),sum(nvl(d.TR_AMT,0))+sum(nvl(d.RETOUCH_AMT,0)) amt,max(nvl(m.AR_TR_AMT,0)) " +
                    "from imex.tex_contr_mst m, imex.tex_contr_dtl d, TCO_BUSPARTNER p " +
                    ",(select c.pk, a.PLC_CD, a.PLC_NM " +
                    "    from tac_abcenter a, tac_abpl b, tac_abplcenter c " +
                    "    where a.del_if=0 and b.DEL_IF=0 and c.DEL_IF=0 " +
                    "        and c.TAC_ABCENTER_PK=a.pk " +
                    "        and c.tac_abpl_pk =b.pk ) pl " +
                    "where  " +
                    "    m.DEL_IF=0 and d.DEL_IF=0 " +
                    "    and m.PK(+)=d.TEX_CONTR_MST_PK " +      
                    "    and m.TCO_BUSPARTNER_PK=p.PK(+)  " +
                    "    and m.TAC_ABPLCENTER_PK=pl.pk(+)  " +
                    "    and m.pk='" +l_tex_contr_mst_pk + "' " +
                    "    AND m.STATUS in (0,2) " +
                    "group by m.pk, m.CONTR_NO, p.PARTNER_ID,m.B_CCY, p.PARTNER_NAME, pl.plc_cd,pl.plc_nm,M.PERIOD " +
                    "having count(*)=1    " ;         
     }
     //Response.Write(sql_master);
     //Response.End();
    
     DataTable dt_master = ESysLib.TableReadOpen(sql_master);
    //---------------------------------------------------------------------------------
     sql_cond = "select c.code_nm, A.pay_percent/100, A.pay_amt,b.period " + 
                "from imex.tex_payment_condition A " +
                "    ,imex.tex_contr_mst B " +
                ",(select a.CODE,  a.CODE_NM  " +
                "    from TCO_ABCODE a, TCO_ABCODEGRP b  " +
                "    where TCO_ABCODEGRP_PK=b.pk and b.id='LGAB0030'  " +
                "        and a.use_if=1 and a.del_if(+)=0 and b.del_if(+)=0 ) c " +
                "where a.del_if=0 and b.del_if=0  " +
                "        and a.condition=c.code(+) " +
                "        and a.TEX_CONTR_MST_PK=b.PK " +
                "      and a.tex_contr_mst_pk='" + l_tex_contr_mst_pk + "' ";
     
    DataTable dt_cond = ESysLib.TableReadOpen(sql_cond);
    //-----------------------------------------------------------------------------------
    sql_adv = "SELECT B.PK,to_char(B.TR_DATE,'dd/mm/yyyy'),E.CONTR_NO,C.DRCR_ORD, C.TR_AMT  " +
                 "FROM TAC_HGTRDITEM A,TAC_HGTRH B, TAC_HGTRD C,TAC_ABACCTCODE D " +
                 "    ,IMEX.TEX_CONTR_MST E " +
                 "WHERE  " +
                 "    A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0  " +
                 "    AND D.DEL_IF=0 AND E.DEL_IF=0  " +
                 "    AND a.TABLE_NM='TEX_CONTR_MST' " +
                 "    AND D.AC_CD IN ('331300','331400') AND C.DRCR_TYPE='D' " +
                 "    AND d.PK=C.TAC_ABACCTCODE_PK " +
                 "    AND A.TAC_HGTRD_PK=C.PK " +
                 "    AND b.PK=c.TAC_HGTRH_PK " +
                 "    AND A.ITEM_TABLE_PK=E.PK " +
                 "    AND E.PK='" + l_tex_contr_mst_pk + "' ";
         
     DataTable dt_adv = ESysLib.TableReadOpen(sql_adv);
    //-----------------------------------------------------------------------------------
     sql_deduct = "SELECT B.PK,to_char(B.TR_DATE,'dd/mm/yyyy'),E.CONTR_NO,C.DRCR_ORD, C.TR_AMT  " +
                  "FROM TAC_HGTRDITEM A,TAC_HGTRH B, TAC_HGTRD C,TAC_ABACCTCODE D " +
                  "    ,IMEX.TEX_CONTR_MST E " +
                  "WHERE  " +
                  "    A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0  " +
                  "    AND D.DEL_IF=0 AND E.DEL_IF=0  " +
                  "    AND a.TABLE_NM='TEX_CONTR_MST' " +
                  "    AND D.AC_CD IN ('331300','331400') AND C.DRCR_TYPE='D' " +
                  "    AND d.PK=C.TAC_ABACCTCODE_PK " +
                  "    AND A.TAC_HGTRD_PK=C.PK " +
                  "    AND b.PK=c.TAC_HGTRH_PK " +
                  "    AND A.ITEM_TABLE_PK=E.PK " +
                  "    AND E.PK='" + l_tex_contr_mst_pk + "' ";
     
     DataTable dt_deduct = ESysLib.TableReadOpen(sql_deduct);
    //-------------------------------------------------------------------------------------------
     sql_AP = "SELECT B.PK,to_char(B.TR_DATE,'dd/mm/yyyy'),E.CONTR_NO,B.REMARK, C.TR_AMT  " + 
                "FROM TAC_HGTRDITEM A,TAC_HGTRH B, TAC_HGTRD C " +
                ",TAC_ABACCTCODE D,IMEX.TEX_CONTR_MST E " +
                "WHERE  " +
                "    A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0  " +
                "    AND d.DEL_IF=0 AND E.DEL_IF=0 " +
                "    AND a.TABLE_NM='TEX_CONTR_MST' " +
                "    AND D.AC_CD in ('331100','331200') AND C.DRCR_TYPE='D' " +
                "    AND D.PK=C.TAC_ABACCTCODE_PK " +
                "    AND A.TAC_HGTRD_PK=C.PK " +
                "    AND b.PK=c.TAC_HGTRH_PK " +
                "    AND A.ITEM_TABLE_PK=E.PK " +
                "    AND E.PK='" + l_tex_contr_mst_pk+"'" ;

     DataTable dt_AP = ESysLib.TableReadOpen(sql_AP);
    //--------------------------------------------------------------------------------------------------
     sql_pay = "SELECT B.PK,to_char(B.TR_DATE,'dd/mm/yyyy'),E.CONTR_NO,B.REMARK, C.TR_AMT  " +
                "FROM TAC_HGTRDITEM A,TAC_HGTRH B, TAC_HGTRD C " +
                ",TAC_ABACCTCODE D,IMEX.TEX_CONTR_MST E " +
                "WHERE  " +
                "    A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0  " +
                "    AND d.DEL_IF=0 AND E.DEL_IF=0 " +
                "    AND a.TABLE_NM='TEX_CONTR_MST' " +
                "    AND D.AC_CD in ('331100','331200') AND C.DRCR_TYPE='C' " +
                "    AND D.PK=C.TAC_ABACCTCODE_PK " +
                "    AND A.TAC_HGTRD_PK=C.PK " +
                "    AND b.PK=c.TAC_HGTRH_PK " +
                "    AND A.ITEM_TABLE_PK=E.PK  "+
                "    AND E.PK='" + l_tex_contr_mst_pk+"'" ;   
    
    DataTable dt_pay = ESysLib.TableReadOpen(sql_pay);
    //-----------------------------------------------------------------------------------
          
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfqc00020_contractprogress_files/filelist.xml">
<link rel=Edit-Time-Data href="gfqc00020_contractprogress_files/editdata.mso">
<link rel=OLE-Object-Data href="gfqc00020_contractprogress_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>AA</o:Author>
  <o:LastAuthor>Ho Thu Hien</o:LastAuthor>
  <o:LastPrinted>2009-02-17T09:21:59Z</o:LastPrinted>
  <o:Created>2007-09-13T09:21:45Z</o:Created>
  <o:LastSaved>2009-03-20T07:57:43Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in 0in 0in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;}
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
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl54
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl55
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl56
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl60
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style16;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single-accounting;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl62
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl65
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style16;
	font-size:9.0pt;
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
.xl67
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl68
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl69
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	font-size:9.0pt;
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
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl73
	{mso-style-parent:style0;
	font-size:9.0pt;
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
.xl74
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl76
	{mso-style-parent:style0;
	font-size:9.0pt;
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
.xl77
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	font-size:9.0pt;
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
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>PROGRESS PAYMENT</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>342</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>86</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>33</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>42</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
       <x:RangeSelection>$G$43:$I$43</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>19035</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=794 style='border-collapse:
 collapse;table-layout:fixed;width:597pt'>
 <col class=xl24 width=15 style='mso-width-source:userset;mso-width-alt:548;
 width:11pt'>
 <col class=xl24 width=13 style='mso-width-source:userset;mso-width-alt:475;
 width:10pt'>
 <col class=xl25 width=26 style='mso-width-source:userset;mso-width-alt:950;
 width:20pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl25 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=106 style='mso-width-source:userset;mso-width-alt:3876;
 width:80pt'>
 <col class=xl24 width=124 span=3 style='mso-width-source:userset;mso-width-alt:
 4534;width:93pt'>
 <col class=xl24 width=117 style='mso-width-source:userset;mso-width-alt:4278;
 width:88pt'>
 <col class=xl24 width=16 style='mso-width-source:userset;mso-width-alt:585;
 width:12pt'>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl24 width=15 style='height:12.0pt;width:11pt'></td>
  <td class=xl24 width=13 style='width:10pt'></td>
  <td class=xl25 width=26 style='width:20pt'></td>
  <td colspan=7 class=xl26 width=724 style='width:544pt'>Tên công ty: <%=l_cmp_name %></td>
  <td class=xl24 width=16 style='width:12pt'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 colspan=2 class=xl24 style='height:12.0pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=7 class=xl26 x:str="&#272;&#7883;a ch&#7881; ">&#272;&#7883;a
  ch&#7881;: <span style='mso-spacerun:yes'><%=l_cmp_add %> </span></td>
  <td class=xl24></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 colspan=2 class=xl24 style='height:12.0pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=7 class=xl26>Mã s&#7889; thu&#7871;: <%=l_cmp_taxcode %></td>
  <td class=xl24></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=2 class=xl24 style='height:7.5pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl28></td>
  <td class=xl25></td>
  <td class=xl28></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td colspan=7 class=xl69>PROGRESS PAYMENT</td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <%
     if (dt_master.Rows.Count>0)
     {
      %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl36>Contract No :</td>
  <td class=xl53><%=dt_master.Rows[0][0].ToString()%></td>
  <td class=xl55>Contract Name :</td>
  <td class=xl53><%=dt_master.Rows[0][1].ToString()%></td>
  <td class=xl53 colspan=2 style='mso-ignore:colspan'><%=dt_master.Rows[0][3].ToString()%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl36>P/L Name :</td>
  <td class=xl24><%=dt_master.Rows[0][4].ToString()%></td>
  <td class=xl27><%=dt_master.Rows[0][5].ToString()%></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl36>Quantity :</td>
  <td class=xl37 x:num><%=dt_master.Rows[0][9].ToString()%></td>
  <td class=xl36 x:str="Quantity Adj: ">Quantity Adj:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl37 x:num><span style='mso-spacerun:yes'> </span><%=dt_master.Rows[0][10].ToString()%> </td>
  <td class=xl36>Currency:</td>
  <td class=xl37 x:str="VND"><span style='mso-spacerun:yes'> </span><%=dt_master.Rows[0][2].ToString()%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl36>Unit price:</td>
  <td class=xl60 x:num><span
  style='mso-spacerun:yes'> </span><%=dt_master.Rows[0][12].ToString()%> </td>
  <td class=xl36 x:str="Unit price: ">Unit price:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl60 x:num><%=dt_master.Rows[0][11].ToString()%></td>
  <td class=xl36>Total price:</td>
  <td class=xl60 x:num><%=dt_master.Rows[0][15].ToString()%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl36>VAT :</td>
  <td class=xl60 x:num><%=dt_master.Rows[0][7].ToString()%></td>
  <td class=xl36 x:str="VAT Adj: ">VAT Adj:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl60 x:num><%=dt_master.Rows[0][8].ToString()%></td>
  <td class=xl36>Total VAT:</td>
  <td class=xl60 x:num><%=dt_master.Rows[0][13].ToString()%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl36>Contract Amount :</td>
  <td class=xl60 x:num><%=dt_master.Rows[0][16].ToString()%></td>
  <td class=xl36 x:str="Adjust amount: ">Adjust amount:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl60 x:num><%=dt_master.Rows[0][17].ToString()%></td>
  <td class=xl36 x:str="Final (1): ">Final (1):<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl61 x:num><%=dt_master.Rows[0][18].ToString()%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <%
    if (dt_cond.Rows.Count>0)   
    {
        for(int i=0;i<dt_cond.Rows.Count;i++)
            if (i == 0)
            {
 %>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
 </td>
  <td height=18 class=xl24 style='height:14.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl36>Condition Payment :</td>
  <td class=xl24><%=dt_cond.Rows[i][0].ToString()%></td>
  <td class=xl38 align=right x:num><%=dt_cond.Rows[i][1].ToString()%></td>
  <td class=xl37 x:num><%=dt_cond.Rows[i][2].ToString()%></td>
  <td class=xl36>Period of contract :</td>
  <td class=xl24></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <%
            }
            else
            { 
  %>
  <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl24 style='height:14.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl36></td>
  <td class=xl24><%=dt_cond.Rows[i][0].ToString()%></td>
  <td class=xl38 align=right x:num><%=dt_cond.Rows[i][1].ToString()%></td>
  <td class=xl37 x:num><span
  style='mso-spacerun:yes'> </span><%=dt_cond.Rows[i][2].ToString()%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl35>&nbsp;</td>
 </tr>
        <%                
            }   
    }
    else
    {
   %>   
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl24 style='height:14.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl36>Condition Payment :</td>
  <td class=xl24>Advance</td>
  <td class=xl38 align=right x:num>0</td>
  <td class=xl37 x:num>0</td>
  <td class=xl36>Period of contract :</td>
  <td class=xl24></td>
  <td class=xl35>&nbsp;</td>
 </tr> 
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl24 style='height:14.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl36></td>
  <td class=xl24>Progress</td>
  <td class=xl38 align=right x:num>0</td>
  <td class=xl37 x:num><span
  style='mso-spacerun:yes'> </span>0</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl24 style='height:14.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl36></td>
  <td class=xl24>Retention</td>
  <td class=xl38 align=right x:num>0</td>
  <td class=xl37 x:num><span
  style='mso-spacerun:yes'> </span>0</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl24 style='height:14.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl36></td>
  <td class=xl24>Guarantee</td>
  <td class=xl38 align=right x:num>0</td>
  <td class=xl37 x:num><span
  style='mso-spacerun:yes'> </span>0</td>
  <td class=xl37 x:num></td>
  <td class=xl24></td>
  <td class=xl35>&nbsp;</td>
 </tr>
  <%
    }
         }
  %>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl24 style='height:9.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl59 colspan=3 style='mso-ignore:colspan'>I. ADVANCE STATUS</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl35>&nbsp;</td>
 </tr> 
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl39>No</td>
  <td class=xl40>Date</td>
  <td class=xl39>SEQ</td>
  <td class=xl39 style='border-left:none'>Voucher No</td>
  <td colspan=3 class=xl70 style='border-right:.5pt solid black;border-left:
  none'>Description</td>
  <td class=xl39 style='border-left:none'>Advance Amt</td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <%
     if (dt_adv.Rows.Count > 0)
     {
         for (int i1 = 0; i1 < dt_adv.Rows.Count; i1++)
         {
  %>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl49 style='border-top:none' x:num><%=i1 + 1%></td>
  <td class=xl50 style='border-top:none;border-left:none'><%=dt_adv.Rows[i1][1].ToString()%></td>
  <td class=xl51 style='border-top:none;border-left:none' x:num><%=dt_adv.Rows[i1][0].ToString()%></td>
  <td class=xl52 style='border-top:none;border-left:none'><%=dt_adv.Rows[i1][2].ToString()%></td>
  <td colspan=3 class=xl75 width=372 style='border-left:none;width:279pt'><%=dt_adv.Rows[i1][3].ToString()%></td>
  <td class=xl62 style='border-top:none;border-left:none' x:num><%=dt_adv.Rows[i1][4].ToString()%><%l_adv_amt = l_adv_amt + Double.Parse(dt_adv.Rows[i1][4].ToString());%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <%
     }
    }
  %>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td colspan=7 class=xl70 style='border-right:.5pt solid black'>Total Advance
  (2)</td>
  <td class=xl63 x:num><%=l_adv_amt %></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl24 style='height:12.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl59 colspan=3 style='mso-ignore:colspan'>II. DEDUCT STATUS</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl64></td>
  <td class=xl35>&nbsp;</td>
 </tr> 
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl39>No</td>
  <td class=xl40>Date</td>
  <td class=xl39>SEQ</td>
  <td class=xl39 style='border-left:none'>Voucher No</td>
  <td colspan=3 class=xl70 style='border-right:.5pt solid black;border-left:
  none'>Description</td>
  <td class=xl65 style='border-left:none' x:str="Deduct Amt"><span
  style='mso-spacerun:yes'> </span>Deduct Amt<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <%
     if (dt_deduct.Rows.Count > 0)
     {
         for (int i = 0; i < dt_deduct.Rows.Count; i++)
         {
             %>
<tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl49 style='border-top:none' x:num>2</td>
  <td class=xl50 style='border-top:none;border-left:none'><%=dt_deduct.Rows[i][1].ToString()%></td>
  <td class=xl51 style='border-top:none;border-left:none' x:num><%=dt_deduct.Rows[i][0].ToString()%></td>
  <td class=xl52 style='border-top:none;border-left:none'><%=dt_deduct.Rows[i][2].ToString()%></td>
  <td colspan=3 class=xl75 width=372 style='border-left:none;width:279pt'><%=dt_deduct.Rows[i][3].ToString()%></td>
  <td class=xl62 style='border-top:none;border-left:none' x:num><%=dt_deduct.Rows[i][4].ToString()%><%l_deduct_amt = l_deduct_amt + Double.Parse(dt_deduct.Rows[i][4].ToString());%></td>
  <td class=xl35>&nbsp;</td>
 </tr>          
             
             <%
             
         }
     }
  %>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td colspan=7 class=xl70 style='border-right:.5pt solid black'>Total Deduct
  (3)</td>
  <td class=xl63 x:num><%=l_deduct_amt%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td colspan=7 class=xl70 style='border-right:.5pt solid black'>Remain (4) =
  (2) - (3)</td>
  <td class=xl66 x:num><%l_remain_amt = l_adv_amt - l_deduct_amt;%><%=l_remain_amt %></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl24 style='height:12.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl59 colspan=2 style='mso-ignore:colspan'>III. A/P Status</td>
  <td class=xl26></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl26 colspan=2 style='mso-ignore:colspan'>Openning A/P Amt (5):</td>
  <td class=xl67 x:num>
  <%
    if (dt_master.Rows.Count>0)
        l_AP_tr_amt = Double.Parse(dt_master.Rows[0][19].ToString());%><%= l_AP_tr_amt%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl39>No</td>
  <td class=xl40>Date</td>
  <td class=xl39>SEQ</td>
  <td class=xl39 style='border-left:none'>Voucher No</td>
  <td colspan=3 class=xl70 style='border-right:.5pt solid black;border-left:
  none'>Description</td>
  <td class=xl65 style='border-top:none;border-left:none' x:str="A/P Amt"><span
  style='mso-spacerun:yes'> </span>A/P Amt<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl35>&nbsp;</td>
 </tr>
  <%
      if (dt_AP.Rows.Count > 0)
     {
         for (int i = 0; i < dt_AP.Rows.Count; i++)
         {
             %>
<tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl49 style='border-top:none' x:num>1</td>
  <td class=xl50 style='border-top:none;border-left:none'><%=dt_AP.Rows[i][1].ToString()%></td>
  <td class=xl51 style='border-top:none;border-left:none' x:num><%=dt_AP.Rows[i][0].ToString()%></td>
  <td class=xl52 style='border-top:none;border-left:none'><%=dt_AP.Rows[i][2].ToString()%></td>
  <td colspan=3 class=xl75 width=372 style='border-left:none;width:279pt'><%=dt_AP.Rows[i][3].ToString()%></td>
  <td class=xl62 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_AP.Rows[i][4].ToString()%><%l_AP_amt = l_AP_amt + Double.Parse(dt_AP.Rows[i][4].ToString());%> </td>
  <td class=xl35>&nbsp;</td>
 </tr>      
             <%
             
         }
     }
  %> 
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td colspan=7 class=xl70 style='border-right:.5pt solid black'>Total A/P (6)</td>
  <td class=xl66 x:num><%=l_AP_amt%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td colspan=7 class=xl70 style='border-right:.5pt solid black'>Grand Total
  A/P (7) = (2) + (5) + (6)</td>
  <td class=xl66 x:num><%l_G_AP_amt = l_adv_amt + l_AP_tr_amt + l_AP_amt; %><%=l_G_AP_amt%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td colspan=7 class=xl76 style='border-right:.5pt solid black'>REMAIN A/P (8)
  = (7) - (2)</td>
  <td class=xl66 x:num><%l_remain_AP = l_G_AP_amt - l_deduct_amt;%><%=l_remain_AP %></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl24 style='height:12.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl59 colspan=3 style='mso-ignore:colspan'>IV. PAYMENT Status</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl26 colspan=2 style='mso-ignore:colspan'>Openning Paymnent Amt
  (9):</td>
  <td class=xl67 x:num="0"><span style='mso-spacerun:yes'> </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl39>No</td>
  <td class=xl40>Date</td>
  <td class=xl39>SEQ</td>
  <td class=xl39 style='border-left:none'>Voucher No</td>
  <td colspan=3 class=xl70 style='border-right:.5pt solid black;border-left:
  none'>Description</td>
  <td class=xl65 style='border-top:none;border-left:none' x:str="Payment Amt"><span
  style='mso-spacerun:yes'> </span>Payment Amt<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <%
     if (dt_pay.Rows.Count > 0)
     {
         for (int i = 0; i < dt_pay.Rows.Count; i++)
         {
             %>
<tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl49 style='border-top:none' x:num>1</td>
  <td class=xl50 style='border-top:none;border-left:none'><%=dt_pay.Rows[i][1].ToString()%></td>
  <td class=xl51 style='border-top:none;border-left:none' x:num><%=dt_pay.Rows[i][0].ToString()%></td>
  <td class=xl52 style='border-top:none;border-left:none'><%=dt_pay.Rows[i][2].ToString()%></td>
  <td colspan=3 class=xl75 width=372 style='border-left:none;width:279pt'><%=dt_pay.Rows[i][3].ToString()%></td>
  <td class=xl62 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_pay.Rows[i][4].ToString()%><%l_pay_amt = l_pay_amt + Double.Parse(dt_pay.Rows[i][4].ToString());%> </td>
  <td class=xl35>&nbsp;</td>
 </tr>      
             <%             
         }
     }
  %>
 
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td colspan=7 class=xl70 style='border-right:.5pt solid black'>Total Payment
  (10)</td>
  <td class=xl63 x:num><%=l_pay_amt %></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 class=xl24 style='height:9.75pt'></td>
  <td class=xl34>&nbsp;</td>
  <td colspan=7 class=xl54 style='mso-ignore:colspan'></td>
  <td class=xl68></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl24 style='height:16.5pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl59 colspan=4 style='mso-ignore:colspan'>V. TOTAL PAYMENT (11) =
  (2) + (10)</td>
  <td class=xl24></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl68 x:num><%l_t_pay_amt = l_pay_amt + l_adv_amt; %><%= l_t_pay_amt%></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl24 style='height:16.5pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl59 colspan=4 style='mso-ignore:colspan'>VI. REMAIN CONTRACT (12)
  = (1) - (11)</td>
  <td class=xl24></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl61 x:num><%
                           if (dt_master.Rows.Count>0)
                             l_contr_amt = Double.Parse(dt_master.Rows[0][18].ToString());
                           l_remain_contr = l_contr_amt - l_t_pay_amt;
                           Response.Write(l_remain_contr);
                        %>
                        </td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan' x:str="Remark: ">Remark:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl25></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl24 style='height:15.95pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl39>Date</td>
  <td class=xl41>Repaired by</td>
  <td class=xl41>Checked by</td>
  <td class=xl41>Approved by</td>
  <td class=xl24></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl42 style='border-top:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl43>&nbsp;</td>
  <td class=xl43 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-left:none'>&nbsp;</td>
  <td class=xl57 style='border-left:none'>&nbsp;</td>
  <td class=xl24></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td class=xl24></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 class=xl24 style='height:9.75pt'></td>
  <td class=xl45>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=15 style='width:11pt'></td>
  <td width=13 style='width:10pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=16 style='width:12pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
