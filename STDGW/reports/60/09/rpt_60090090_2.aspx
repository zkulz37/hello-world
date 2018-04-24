<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
    string SQL = "";
    int iYear, iMonth ;
    string iToDt = "";
    string ls_std_ym = Request["std_ym"];
    string ls_std_ym_to = Request["std_ym_to"];
    string ls_ac_cd = Request["ac_cd"];
    string ls_tin_warehouse_pk = Request["tin_warehouse_pk"];
    string ls_tco_company_pk = Request["tco_company_pk"];
    string v_ac_cd = "";
    string p_plcenter_pk = "";
    p_plcenter_pk = Request["plcenter_pk"];
    string p_item_pk = "";
    p_item_pk = Request["item_pk"];
    string p_cust_pk = "";
    p_cust_pk = Request["cust_pk"];
    string p_voucherno = "";
    p_voucherno = Request["voucherno"];
    string p_takein_no = "";
    p_takein_no = Request["takein_no"];
    decimal v_trans_amt = 0, v_books_amt = 0 ,v_vat_trans_amt=0,v_total_due_trans_amt=0;
    decimal v_tot_trans_amt = 0, v_tot_books_amt = 0 ,v_grand_total_due_amt=0;
    int i ;
    ls_ac_cd = ls_ac_cd.Trim();
    if (ls_ac_cd == "")
    {
        ls_ac_cd = "ALL";            
    }
    SQL
	= "select pk, PARTNER_NAME, NVL(ADDR1, '') || NVL(ADDR2, ' ') || NVL(ADDR3, ' '), TAX_CODE from tco_company where del_if = 0 " ;
	DataTable dtCompany = new DataTable();
    dtCompany = ESysLib.TableReadOpen(SQL) ;	
    if(dtCompany.Rows.Count == 0)
    {
        Response.Write("The company does not exist");
        Response.End();
    }
    iYear    = int.Parse(ls_std_ym.Substring(0, 4));
    iMonth   = int.Parse(ls_std_ym.Substring(4, 2));    
    iToDt = DateTime.DaysInMonth(iYear, iMonth).ToString() + "/" + ls_std_ym.Substring(4, 2) + "/" + ls_std_ym.Substring(0, 4);    

    SQL = 	" select voucherno, trans_dt, item_code, item_name, uom," +
			" ap_qty, ap_uprice, ap_trfamt, ap_tramt, impvat_famt, impvat_amt, " +
			" pl_cd, pl_nm, partner_id, partner_name, invoice_no, invoice_date, remark2, ac_cd, wh_name, " +
			" slip_no, total_trans, total_book, " + 
			" nvl(books_amt_allocate,0) as books_amt_allocate, (ap_tramt+imp_amt+nvl(books_amt_allocate,0)) as total_amt_allocate, " + 
			" decode(ap_qty, 0,0,round((ap_tramt+imp_amt+nvl(books_amt_allocate,0))/ap_qty,0)) unitprice ,imp_amt,imp_famt" + 
			" from ( " +
			"select a.voucherno, to_char(to_date(a.tr_date, 'YYYYMMDD'), 'DD/MM/YYYY') trans_dt, i.item_code as item_code, i.item_name as item_name, i.uom as uom,  " +
            "    d.ap_qty as ap_qty, round(d.ap_uprice,4) as ap_uprice, round(d.ap_trfamt,2) as ap_trfamt, round(d.ap_tramt) as ap_tramt, nvl(round(d.impvat_famt),0) as impvat_famt, round(d.impvat_amt) as impvat_amt, v.pl_cd as pl_cd, v.pl_nm, p.partner_id,   " +
            "    p.partner_name, a.invoice_no, to_char(to_date(a.invoice_date, 'YYYYMMDD'), 'DD/MM/YYYY') invoice_date, a.remark2, c.ac_cd, w.wh_name, d.po_no slip_no,round(nvl(d.ap_trfamt,0) + nvl(d.impvat_famt,0)) total_trans,round(nvl(d.ap_tramt,0)+nvl(d.impvat_amt,0)) total_book,  " +
			" (select sum(e.books_amt_allocate) " +
            "      from tac_allexp_accrued e, tac_allexp_accrue f " +
            "     where     e.del_if = 0 " +
            "           and f.del_if = 0 " +
            "           and e.tac_allexp_accrue_pk = f.pk " +
            "           and e.tac_crdad_pk = d.pk " +
            "           and d.tco_item_pk = e.tco_item_pk " +
            "           and f.tr_status in (0,2) " +
            "     ) books_amt_allocate , " +
			"     nvl(d.imp_amt,0) imp_amt, nvl(d.imp_famt,0) imp_famt " +
            "from tlg_it_item i, tac_crdad d, tac_crda a,   " +
            "    tco_buspartner p, tac_abacctcode c, TLG_IN_WAREHOUSE w, v_abplcenter v      " +
            "where a.tr_date between '" + ls_std_ym + "' and '" + ls_std_ym_to + "' " + 
            "and a.del_if = 0 " +
            "and a.tr_status in ('2', '0') " +
            "and a.tco_company_pk = '" + ls_tco_company_pk + "'  " +
            "and a.pk = d.tac_crda_pk " +
            "and d.del_if = 0 " +
            "and d.tco_item_pk = i.pk(+) " +
            "and a.tco_buspartner_pk = p.pk(+) " +
            "and d.tin_warehouse_pk = w.pk(+) " +
            "and d.tac_abacctcode_pk = c.pk(+) " +
            "and d.tac_abplcenter_pk = v.tac_abplcenter_pk(+) " +
            "and (d.tin_warehouse_pk like '" + ls_tin_warehouse_pk + "' or '" + ls_tin_warehouse_pk + "' = 'ALL' ) " +
            "and (d.tac_abacctcode_pk like '" + ls_ac_cd + "' or '" + ls_ac_cd + "' = 'ALL' ) " +
            "and (d.tac_abplcenter_pk like '" + p_plcenter_pk + "' or '" + p_plcenter_pk + "' is null ) " +
            "and (d.tlg_it_item_pk like '" + p_item_pk + "' or '" + p_item_pk + "' is null ) " +
            "and (a.tco_buspartner_pk like '" + p_cust_pk + "' or '" + p_cust_pk + "' is null ) " +
            "and ( a.voucherno like '" + p_voucherno +  "' or '" + p_voucherno + "' is null ) " +
            "and (d.po_no like '" + p_takein_no + "' or '" + p_takein_no + "' is null ) " +
            " ) order by ac_cd, trans_dt, item_code  ";
			//Response.Write(SQL);
        //Response.End();
	DataTable dtItem = new DataTable();
    dtItem = ESysLib.TableReadOpen(SQL) ;	
    if(dtItem.Rows.Count > 0)
    {   
        v_ac_cd = dtItem.Rows[0][18].ToString().Trim() ;
    }
    
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_60090090_2_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_60090090_2_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_60090090_2_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Nguyen Van Quyen</o:LastAuthor>
  <o:LastPrinted>2013-04-22T03:33:28Z</o:LastPrinted>
  <o:Created>2006-09-14T03:47:35Z</o:Created>
  <o:LastSaved>2013-04-22T03:33:58Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.5in 0in .5in .25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style43
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
	font-family:"Times New Roman", serif;
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
	font-family:"Times New Roman", serif;
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
.xl65
	{mso-style-parent:style0;
	font-size:8.0pt;}
.xl66
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;}
.xl67
	{mso-style-parent:style43;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl68
	{mso-style-parent:style43;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:0%;
	text-align:left;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
	color:black;
	font-size:16.0pt;
	font-weight:700;}
.xl72
	{mso-style-parent:style43;
	color:black;
	font-size:16.0pt;
	font-weight:700;}
.xl73
	{mso-style-parent:style43;
	font-size:8.0pt;}
.xl74
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style43;
	font-size:12.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl80
	{mso-style-parent:style43;
	font-size:11.0pt;
	font-weight:700;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style43;
	font-size:11.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl82
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl83
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl84
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl86
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl87
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl88
	{mso-style-parent:style43;
	font-size:12.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl89
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl90
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl91
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	vertical-align:middle;}
.xl92
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl93
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl94
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl95
	{mso-style-parent:style43;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl96
	{mso-style-parent:style43;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl97
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl98
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl99
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl100
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl101
	{mso-style-parent:style0;
	font-size:11.0pt;
	vertical-align:middle;}
.xl102
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl103
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl104
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl105
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl106
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl107
	{mso-style-parent:style43;
	font-size:12.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl108
	{mso-style-parent:style43;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl109
	{mso-style-parent:style43;
	font-size:16.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;}
.xl110
	{mso-style-parent:style43;
	font-size:13.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;}
.xl111
	{mso-style-parent:style43;
	font-size:12.0pt;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl112
	{mso-style-parent:style43;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}	
-->

</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>BC_HN</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>225</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>56</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:LeftColumnVisible>3</x:LeftColumnVisible>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>6</x:SplitHorizontal>
     <x:TopRowBottomPane>6</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>19</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8190</x:WindowHeight>
  <x:WindowWidth>14835</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=BC_HN!$A$6:$U$6</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=BC_HN!$6:$6</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl65>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1716 style='border-collapse:
 collapse;table-layout:fixed;width:1290pt'>
 <col class=xl65 width=174 style='mso-width-source:userset;mso-width-alt:7424;
 width:131pt'>
 <col class=xl66 width=115 style='mso-width-source:userset;mso-width-alt:4906;
 width:86pt'>
 <col class=xl66 width=106 style='mso-width-source:userset;mso-width-alt:4522;
 width:80pt'>
 <col class=xl65 width=92 style='mso-width-source:userset;mso-width-alt:3925;
 width:69pt'>
 <col class=xl65 width=194 style='mso-width-source:userset;mso-width-alt:8277;
 width:146pt'>
 <col class=xl66 width=50 style='mso-width-source:userset;mso-width-alt:2133;
 width:38pt'>
 <col class=xl67 width=68 style='mso-width-source:userset;mso-width-alt:2901;
 width:51pt'>
 <col class=xl68 width=65 style='mso-width-source:userset;mso-width-alt:2773;
 width:49pt'>
 <col class=xl68 width=111 style='mso-width-source:userset;mso-width-alt:4736;
 width:83pt'>
 <col class=xl67 width=0 style='display:;mso-width-source:userset;
 mso-width-alt:5034'>
 <col class=xl67 width=90 style='mso-width-source:userset;mso-width-alt:3840;
 width:68pt'>
 <col class=xl67 width=118 span=2 style='mso-width-source:userset;mso-width-alt:
 5034;width:89pt'>
 <col class=xl67 width=147 style='mso-width-source:userset;mso-width-alt:6272;
 width:110pt'>
 <col class=xl67 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:4949'>
 <col class=xl65 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:4352'>
 <col class=xl65 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:6741'>
 <col class=xl65 width=101 style='mso-width-source:userset;mso-width-alt:4309;
 width:76pt'>
 <col class=xl65 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:6058'>
 <col class=xl65 width=80 style='mso-width-source:userset;mso-width-alt:3413;
 width:60pt'>
 <col class=xl65 width=87 style='mso-width-source:userset;mso-width-alt:3712;
 width:65pt'>
 <col class=xl65 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:5077'>
 <col class=xl65 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:6016'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl69 colspan=2 width=289 style='height:15.75pt;
  mso-ignore:colspan;width:217pt'><%=dtCompany.Rows[0][1] %></td>
  <td class=xl66 width=106 style='width:80pt'></td>
  <td class=xl65 width=92 style='width:69pt'></td>
  <td class=xl65 width=194 style='width:146pt'></td>
  <td class=xl66 width=50 style='width:38pt'></td>
  <td class=xl67 width=68 style='width:51pt'></td>
  <td class=xl68 width=65 style='width:49pt'></td>
  <td class=xl68 width=111 style='width:83pt'></td>
  <td class=xl67 width=0></td>
  <td class=xl67 width=90 style='width:68pt'></td>
  <td class=xl67 width=118 style='width:89pt'></td>
  <td class=xl67 width=118 style='width:89pt'></td>
  <td class=xl67 width=147 style='width:110pt'></td>
  <td class=xl67 width=0></td>
  <td class=xl65 width=0></td>
  <td class=xl65 width=0></td>
  <td class=xl65 width=101 style='width:76pt'></td>
  <td class=xl65 width=0></td>
  <td class=xl65 width=80 style='width:60pt'></td>
  <td class=xl65 width=87 style='width:65pt'></td>
  <td class=xl65 width=0></td>
  <td class=xl65 width=0></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td height=27 class=xl70 colspan=4 style='height:20.25pt;mso-ignore:colspan'>Địa chỉ:<%=dtCompany.Rows[0][2] %></td>
  <td class=xl66></td>
  <td class=xl67></td>
  <td colspan=14 class=xl109>CHI TI&#7870;T NH&#7852;P TRONG K&#7922;</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl70 style='height:16.5pt'>Mã số thuế:<%=dtCompany.Rows[0][3] %></td>
  <td class=xl70></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl67></td>
  <td colspan=14 class=xl110>&nbsp;&nbsp;&nbsp;&nbsp;Từ ngày <%=ls_std_ym.Substring(6, 2)+ "/" +ls_std_ym.Substring(4, 2) + "/" + ls_std_ym.Substring(0, 4) %> ~ <%=ls_std_ym_to.Substring(6, 2)+ "/" +ls_std_ym_to.Substring(4, 2) + "/" + ls_std_ym_to.Substring(0, 4) %></td> 
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td height=27 colspan=6 class=xl71 style='height:20.25pt;mso-ignore:colspan'></td>
  <td colspan=9 class=xl72 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl71 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 class=xl65 style='height:11.25pt'></td>
  <td class=xl66></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl67></td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl67 style='mso-ignore:colspan'></td>
  <td class=xl73></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=65 style='mso-height-source:userset;height:48.75pt'>
  <td height=65 class=xl75 style='height:48.75pt'>Voucher. No.</td>
  <td class=xl75>Slip No</td>
  <td class=xl75>Trans Date</td>
  <td class=xl75>Code</td>
  <td class=xl75>Name of material</td>
  <td class=xl75>Unit</td>
  <td class=xl76>Q'ty</td>
  <td class=xl76>U.price</td>
  <td class=xl76>Trans Amount</td>
  <td class=xl76>Books Amount</td>
  <td class=xl76>Import tax</td>
  <td class=xl107 width=118 style='width:89pt'>Total Fee<br>
    T&#7893;ng cp phân b&#7893;</td>
  <td class=xl107 width=118 style='width:89pt'>Total amount<br>
    T&#7893;ng thành ti&#7873;n</td>
  <td class=xl107 width=147 style='width:110pt'>Gross price<br>
    &#272;&#417;n giá bao g&#7891;m cp</td>
  <td class=xl76>Total Amt(Book)</td>
  <td class=xl75>P/L Unit Code</td>
  <td class=xl75>P/L Unit Name</td>
  <td class=xl75>Supplier Code</td>
  <td class=xl75>Supplier Name</td>
  <td class=xl75>Invoice No</td>
  <td class=xl75>Invoice Date</td>
  <td class=xl75>Remark</td>
  <td class=xl75>WH</td>
 </tr>
 <tr class=xl74 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl77 style='height:20.1pt'>P/L Unit Code || P/L Unit <span
  style='display:none'>Name</span></td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl82>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl82>&nbsp;</td>
  <td class=xl82>&nbsp;</td>
 </tr>
 <% 
    for(i = 0; i < dtItem.Rows.Count ; i++)
    {    
        if(v_ac_cd != dtItem.Rows[i][18].ToString().Trim())
        {            
 %>
 <tr class=xl91 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl92 style='height:20.1pt'>Sub total</td>
  <td class=xl93>&nbsp;</td>
  <td class=xl93>&nbsp;</td>
  <td class=xl93 x:str><%=v_ac_cd %></td>
  <td class=xl94>&nbsp;</td>
  <td class=xl93>&nbsp;</td>
  <td class=xl95>&nbsp;</td>
  <td class=xl95>&nbsp;</td>
  <td class=xl96 x:num><%= v_trans_amt%> </td>
  <td class=xl96 x:num ><%= v_books_amt%> </td>
  <td class=xl108 x:num> </td>
  <td class=xl108>&nbsp;</td>
  <td class=xl108 x:num><%= v_total_due_trans_amt%></td>
  <td class=xl108 x:num></td>
  <td class=xl96>&nbsp;</td>
  <td class=xl97>&nbsp;</td>
  <td class=xl98 width=0>&nbsp;</td>
  <td class=xl99>&nbsp;</td>
  <td class=xl99>&nbsp;</td>
  <td class=xl99>&nbsp;</td>
  <td class=xl100>&nbsp;</td>
  <td class=xl94>&nbsp;</td>
  <td class=xl89 x:str="">&nbsp;</td>
 </tr>
 <tr class=xl74 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl77 style='height:20.1pt'>P/L Unit Code || P/L Unit <span
  style='display:none'>Name</span></td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl82>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl82>&nbsp;</td>
  <td class=xl82>&nbsp;</td>
 </tr>
 <% 
            v_ac_cd = dtItem.Rows[i][18].ToString().Trim();    
            v_trans_amt = 0;
            v_books_amt = 0;
			v_total_due_trans_amt=0;
			v_vat_trans_amt=0;
            v_trans_amt += decimal.Parse(dtItem.Rows[i][7].ToString());
            v_books_amt += decimal.Parse(dtItem.Rows[i][8].ToString());
			
			v_vat_trans_amt += decimal.Parse(dtItem.Rows[i][9].ToString());
			v_total_due_trans_amt += decimal.Parse(dtItem.Rows[i]["total_amt_allocate"].ToString());
            v_tot_trans_amt += decimal.Parse(dtItem.Rows[i][7].ToString());
            v_tot_books_amt += decimal.Parse(dtItem.Rows[i][8].ToString());
			v_grand_total_due_amt += decimal.Parse(dtItem.Rows[i]["total_amt_allocate"].ToString());
			
%>
 <tr class=xl74 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl84 style='height:20.1pt'><%=dtItem.Rows[i][0] %></td>
  <td class=xl85><%=dtItem.Rows[i][20] %></td>
  <td class=xl85><%=dtItem.Rows[i][1] %></td>
  <td class=xl86><%=dtItem.Rows[i][2] %></td>
  <td class=xl87><%=dtItem.Rows[i][3] %></td>
  <td class=xl86><%=dtItem.Rows[i][4] %></td>
  <td class=xl88 x:num><%=dtItem.Rows[i][5] %> </td>
  <td class=xl111 x:num><%=dtItem.Rows[i]["ap_uprice"] %> </td>
  <td class=xl111 x:num><%=dtItem.Rows[i][7] %> </td>
  <td class=xl88 x:num><%=dtItem.Rows[i][8] %></td>
  <td class=xl88 x:num><%=dtItem.Rows[i]["imp_amt"] %></td>
  <td class=xl88 x:num><%=dtItem.Rows[i]["books_amt_allocate"] %></td>   
  <td class=xl88 x:num><%=dtItem.Rows[i]["total_amt_allocate"] %></td>
  <td class=xl88 x:num><%=dtItem.Rows[i]["unitprice"] %></td>
  
  <td class=xl88 x:num></td>
  <td class=xl89 x:str><%=dtItem.Rows[i][11] %></td>
  <td class=xl87 x:str><%=dtItem.Rows[i][12] %></td>
  <td class=xl87><%=dtItem.Rows[i][13] %></td>
  <td class=xl87><%=dtItem.Rows[i][14] %></td>
  <td class=xl87><%=dtItem.Rows[i][15] %></td>
  <td class=xl90><%=dtItem.Rows[i][16] %></td>
  <td class=xl89><%=dtItem.Rows[i][17] %></td>
  <td class=xl89><%=dtItem.Rows[i][19] %></td>
 </tr>
 <%            
        }
        else
        {
            v_trans_amt += decimal.Parse(dtItem.Rows[i][7].ToString());
            v_books_amt += decimal.Parse(dtItem.Rows[i][8].ToString());
			v_vat_trans_amt += decimal.Parse(dtItem.Rows[i][9].ToString());
			v_total_due_trans_amt += decimal.Parse(dtItem.Rows[i]["total_amt_allocate"].ToString());
            v_tot_trans_amt += decimal.Parse(dtItem.Rows[i][7].ToString());
            v_tot_books_amt += decimal.Parse(dtItem.Rows[i][8].ToString());
			v_grand_total_due_amt += decimal.Parse(dtItem.Rows[i]["total_amt_allocate"].ToString());
 %>
 <tr class=xl74 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl84 style='height:20.1pt'><%=dtItem.Rows[i][0] %></td>
  <td class=xl85><%=dtItem.Rows[i][20] %></td>
  <td class=xl85><%=dtItem.Rows[i][1] %></td>
  <td class=xl86><%=dtItem.Rows[i][2] %></td>
  <td class=xl87><%=dtItem.Rows[i][3] %></td>
  <td class=xl86><%=dtItem.Rows[i][4] %></td>
  <td class=xl88 x:num><%=dtItem.Rows[i][5] %> </td>
  <td class=xl111 x:num><%=dtItem.Rows[i]["ap_uprice"] %> </td>
  <td class=xl111 x:num><%=dtItem.Rows[i][7] %> </td>
  <td class=xl88 x:num><%=dtItem.Rows[i][8] %></td>
  <td class=xl88 x:num><%=dtItem.Rows[i]["imp_amt"] %></td>
  <td class=xl88 x:num><%=dtItem.Rows[i]["books_amt_allocate"] %></td>   
  <td class=xl88 x:num><%=dtItem.Rows[i]["total_amt_allocate"] %></td>
  <td class=xl88 x:num><%=dtItem.Rows[i]["unitprice"] %></td>
  
  <td class=xl88 x:num></td>
  <td class=xl89 x:str><%=dtItem.Rows[i][11] %></td>
  <td class=xl87 x:str><%=dtItem.Rows[i][12] %></td>
  <td class=xl87><%=dtItem.Rows[i][13] %></td>
  <td class=xl87><%=dtItem.Rows[i][14] %></td>
  <td class=xl87><%=dtItem.Rows[i][15] %></td>
  <td class=xl90><%=dtItem.Rows[i][16] %></td>
  <td class=xl89><%=dtItem.Rows[i][17] %></td>
  <td class=xl89><%=dtItem.Rows[i][19] %></td>
 </tr>
 <% 
        }    
    }            
 %>
 <tr class=xl91 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl92 style='height:20.1pt'>Sub total</td>
  <td class=xl93>&nbsp;</td>
  <td class=xl93>&nbsp;</td>
  <td class=xl93 x:str><%=v_ac_cd %></td>
  <td class=xl94>&nbsp;</td>
  <td class=xl93>&nbsp;</td>
  <td class=xl95>&nbsp;</td>
  <td class=xl95>&nbsp;</td>
  <td class=xl112 x:num><%= v_trans_amt%> </td>
  <td class=xl108 x:num ><%= v_books_amt%> </td>
  <td class=xl108 x:num></td>
  <td class=xl108>&nbsp;</td>
  <td class=xl108 x:num><%= v_total_due_trans_amt%></td>
  <td class=xl108 x:num></td>
  <td class=xl96>&nbsp;</td>
  <td class=xl97>&nbsp;</td>
  <td class=xl98 width=0>&nbsp;</td>
  <td class=xl99>&nbsp;</td>
  <td class=xl99>&nbsp;</td>
  <td class=xl99>&nbsp;</td>
  <td class=xl100>&nbsp;</td>
  <td class=xl94>&nbsp;</td>
  <td class=xl89 x:str="">&nbsp;</td>
 </tr>
 <tr class=xl101 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl102 style='height:20.1pt'>Grand Total</td>
  <td class=xl103>&nbsp;</td>
  <td class=xl103>&nbsp;</td>
  <td class=xl104>&nbsp;</td>
  <td class=xl82>&nbsp;</td>
  <td class=xl103>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl108 x:num><%= v_tot_books_amt%></td>
  <td class=xl88>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl108 x:num><%= v_grand_total_due_amt%></td>
  <td class=xl88>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl104>&nbsp;</td>
  <td class=xl105 width=0>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl105 width=0>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl106 width=0>&nbsp;</td>
  <td class=xl89 x:str="">&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=174 style='width:131pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=194 style='width:146pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=0></td>
  <td width=90 style='width:68pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=147 style='width:110pt'></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=101 style='width:76pt'></td>
  <td width=0></td>
  <td width=80 style='width:60pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=0></td>
  <td width=0></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
