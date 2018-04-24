<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%Response.ContentType = "application/vnd.ms-excel"; %>
<% ESysLib.SetUser("imex");%>

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
    string SQL, company = "", company_pk = "", pk = "";
    string com_name = "", com_add = "", com_tax = "";
    string partner1 = "", partner_add1 = "", tax1="", partner2 = "", partner_add2 = "", tax2="";
    string partner3 = "", partner_add3 = "", partner4 = "", partner_add4 = "", sogpxuat = "", ngaygpxuat = "";
    string sohdgxuat = "", ngayhdgxuat = "", ngayhhxuat = "",sogpnhap = "", ngaygpnhap = "", diadiemgiaohang = "";
    string sodh12 = "", ngaydh12 = "", ngayhdgnhap = "", sohdgnhap="",ngayhhnhap = "",hdtm = "", ngayhdtm = "";
    string phuongthucthanhtoan = "", curr = "", tigia = "";
    
    pk = Request.QueryString["pk"];
    company_pk = Request.QueryString["company_pk"];

    SQL = " select  a.partner_name, a.addr1, a.tax_code  " +
        " from    tco_company a   " +
        " where pk='" + company_pk + "' ";
    System.Data.DataTable dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count > 0)
    {
        com_name = (string)dt.Rows[0][0].ToString();
        com_add = (string)dt.Rows[0][1].ToString();
        com_tax = (string)dt.Rows[0][2].ToString();
    }

    SQL = " select  nvl(com.partner_name,exp.partner_name) partner1 " +
        "        , nvl(com.addr1,exp.addr1) partner_add1,  nvl(exp.tax_code,exp.tax_code) tax1 " +
        "        , imp.partner_name partner2, imp.tax_code tax1 " +
        "        , imp.addr1 partner_add2 " +
        "        , cons.partner_name partner3 " +
        "        , cons.addr1 partner_add3 " +
        "        , forw.partner_name partner4 " +
        "        , forw.addr1 partner_add4  " +
        "        , license ex_license, to_char(to_date(license_date,'yyyymmdd'),'dd/mm/yyyy') ex_license_date  " +
        "        , to_char(to_date(license_expdate,'yyyymmdd'),'dd/mm/yyyy') ex_license_expdate  " +
        "        , nvl(a.contr_no,ctr.contr_no) ex_contr_no " +
        "        , to_char(to_date(nvl(a.contr_date, ctr.contr_date),'yyyymmdd'),'dd-Mon-yy') ex_contr_date  " +
        "        , to_char(to_date(nvl(a.contr_exp_date,ctr.exp_date),'yyyymmdd'),'dd/mm/yy') exp_date_ex_ctr  " +
        "        , '' im_contr_no, '' im_contr_date, '' exp_date_im_ctr   " +
        "        , '' im_license, '' im_license_date, '' im_license_expdate           " +
        "        , '' diadiemgiaohang, '' sohoadon12, '' ngayhoadon12  " +
        "        , '' ngayhdnhap, '' sohdnhap , '' ngayhhhdgnhap  " +
        "        , nvl(a.invoice_no,cinv.co_invoice_no) invoice_no " +
        "        , to_char(to_date(nvl(a.invoice_date,cinv.co_invoice_date),'yyyymmdd'),'dd/mm/yy') cnv_date  " +
        "        , pay.code_nm payment_method, a.tr_ccy, a.ex_rate  " +
        "    from  tex_decl_mst a, tco_buspartner cus  " +
        "            , tco_buspartner exp, tco_buspartner imp  " +
        "            , tco_buspartner cons, tco_buspartner forw  " +
        "            , tex_cinv_mst_a  cinv, tco_company com  " +
        "            , tex_contr_mst ctr  " +
        "            , (select a.code,  a.code_nm from tco_abcode a, tco_abcodegrp b     " +
        "              where tco_abcodegrp_pk=b.pk and b.id='ACCR0140'     " +
        "                  and a.del_if=0 and b.del_if=0 order by a.CODE) pay  " +
        "    where a.del_if = 0 and cus.del_if(+)=0   " +
        "         and  cons.del_if(+)=0 and forw.del_if(+)=0  " +
        "         and a.tco_buspartner_pk = cus.pk(+)  " +
        "         and a.tco_buspartner_pk1 = exp.pk(+)  " +
        "         and a.tco_buspartner_pk1 = com.pk(+)  " +
        "         and a.tco_buspartner_pk2 = imp.pk(+)  " +
        "         and a.tco_buspartner_pk3 = cons.pk(+)  " +
        "         and a.tco_buspartner_pk4 = forw.pk(+)  " +
        "         and a.tex_cinv_mst_a_pk = cinv.pk(+)  " +
        "         and cinv.contract_pk = ctr.pk(+)  " +
        "         and upper(cinv.pay_meth) = upper(pay.code(+))  " +
        "         and a.pk='" + pk + "' ";
    dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count > 0)
    {
        partner1 = (string) dt.Rows[0][0].ToString() ; 
        partner_add1 = (string) dt.Rows[0][1].ToString() ;
        tax1 = (string)dt.Rows[0][2].ToString();
        partner2 = (string) dt.Rows[0][3].ToString() ; 
        partner_add2 = (string) dt.Rows[0][4].ToString() ;
        tax2 = (string)dt.Rows[0][5].ToString();
        partner3 = (string) dt.Rows[0][6].ToString() ; 
        partner_add3 = (string) dt.Rows[0][7].ToString() ;
        partner4 = (string) dt.Rows[0][8].ToString() ; 
        partner_add4 = (string) dt.Rows[0][9].ToString() ; 
        sogpxuat = (string) dt.Rows[0][10].ToString() ; 
        ngaygpxuat = (string) dt.Rows[0][11].ToString() ; 
        sohdgxuat = (string) dt.Rows[0][13].ToString() ; 
        ngayhdgxuat = (string) dt.Rows[0][14].ToString() ; 
        ngayhhxuat = (string) dt.Rows[0][15].ToString() ;
        sogpnhap = (string) dt.Rows[0][19].ToString() ; 
        ngaygpnhap = (string) dt.Rows[0][20].ToString() ; 
        diadiemgiaohang = (string) dt.Rows[0][22].ToString() ; 
        sodh12 = (string) dt.Rows[0][23].ToString() ; 
        ngaydh12 = (string) dt.Rows[0][24].ToString() ; 
        ngayhdgnhap = (string) dt.Rows[0][25].ToString() ;
        sohdgnhap = (string)dt.Rows[0][26].ToString();
        ngayhhnhap = (string) dt.Rows[0][27].ToString() ;
        hdtm = (string) dt.Rows[0][28].ToString() ; 
        ngayhdtm = (string) dt.Rows[0][29].ToString() ; 
        phuongthucthanhtoan = (string) dt.Rows[0][30].ToString() ; 
        curr = (string) dt.Rows[0][31].ToString() ; 
        tigia = (string) dt.Rows[0][32].ToString() ;
    }
    SQL = "select v2.GRP_NM,  c.item_code, v1.HS_CODE " +
        "     , COMM.sf_get_item_attribute(a.tco_item_pk) as item_attribute  " +
        "     , to_char(a.qty,'999,999,999') qty, v.uom_nm   " +
        "     , decode(e.tr_ccy,'VND',to_char(a.u_price,'999,999,999'),to_char(a.u_price,'999,999,990.99')) u_price   " +
        "     , decode(e.tr_ccy,'VND',to_char(a.EXT_PRICE ,'999,999,999'),to_char(a.EXT_PRICE ,'999,999,990.99')) ext_amt  " +
        "     , decode(nvl(v.cnv_ratio,1),1,'',to_char(v.cnv_ratio,'9,999,999')) || v.uom_nm  unit_cd " +
        "     , a.qty, a.qty_packing, a.net_weight, a.gross_weight, a.unit_packing, a.unit_weight,a.ext_price    " +
        " from tex_decl_dtl a, tex_decl_mst e, comm.tco_item c  " +
        "        , comm.tco_uom v, comm.tco_hscode v1, comm.tco_itemgrp v2   " +
        " where a.del_if = 0 and e.del_if = 0  " +
        "        and v.del_if(+) = 0 and v1.del_if(+) = 0 " +
        "        and v2.del_if(+) = 0  " +
        "        and a.tco_item_pk = c.pk   " +
        "        and a.tex_decl_mst_pk=e.pk  " +
        "        and upper(a.unit_cd) = upper(v.uom_code(+)) " +
        "        and c.tco_hscode_pk = v1.pk(+) " +
        "        and c.tco_itemgrp_pk = v2.pk(+) " +
        "    and a.tex_decl_mst_pk='" + pk + "'";
    dt = ESysLib.TableReadOpen(SQL);
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_epgd00030_decl_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_epgd00030_decl_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_epgd00030_decl_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>&#50724;&#49849;&#54872;</o:Author>
  <o:LastAuthor>NgaLe</o:LastAuthor>
  <o:LastPrinted>2008-12-01T06:16:46Z</o:LastPrinted>
  <o:Created>2003-09-02T12:49:59Z</o:Created>
  <o:LastSaved>2008-12-01T06:18:02Z</o:LastSaved>
  <o:Company>&#44305;&#47548;&#44368;&#54924;</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.51in .2in .98in .26in;
	mso-header-margin:.51in;
	mso-footer-margin:.51in;}
.font9
	{color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\AD74\B9BC, monospace;
	mso-font-charset:129;}
.font10
	{color:black;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:\AD74\B9BC, monospace;
	mso-font-charset:129;}
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
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style22
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
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_IM-23K;}
.style23
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
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_IMPORT99;}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl26
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl27
	{mso-style-parent:style16;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	padding-left:36px;
	mso-char-indent-count:3;}
.xl28
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl31
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl32
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	padding-left:24px;
	mso-char-indent-count:2;}
.xl33
	{mso-style-parent:style22;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl34
	{mso-style-parent:style23;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yy";
	text-align:right;}
.xl35
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl36
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	padding-left:36px;
	mso-char-indent-count:3;}
.xl37
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl38
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl39
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:center;}
.xl40
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";}
.xl41
	{mso-style-parent:style16;
	color:red;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	padding-left:36px;
	mso-char-indent-count:3;}
.xl42
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl43
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;}
.xl44
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl45
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;}
.xl46
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;}
.xl47
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;}
.xl48
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl49
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;}
.xl50
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl51
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl52
	{mso-style-parent:style22;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:right;}
.xl53
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";}
.xl54
	{mso-style-parent:style23;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl55
	{mso-style-parent:style23;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl56
	{mso-style-parent:style23;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:top;
	background:yellow;
	mso-pattern:auto none;}
.xl57
	{mso-style-parent:style23;
	color:navy;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl58
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yy";}
.xl59
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	padding-left:24px;
	mso-char-indent-count:2;}
.xl60
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	padding-left:24px;
	mso-char-indent-count:2;}
.xl61
	{mso-style-parent:style23;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:yellow;
	mso-pattern:auto none;}
.xl62
	{mso-style-parent:style23;
	color:white;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
.xl63
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
.xl64
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";}
.xl65
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl66
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl67
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl68
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;}
.xl69
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center-across;}
.xl70
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;}
.xl71
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl72
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl73
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl76
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl77
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;}
.xl78
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl79
	{mso-style-parent:style23;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yy";
	text-align:right;
	background:yellow;
	mso-pattern:auto none;}
.xl80
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:right;}
.xl81
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl82
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl83
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;}
.xl84
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl85
	{mso-style-parent:style23;
	color:red;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	padding-right:12px;
	mso-char-indent-count:1;}
.xl86
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;}
.xl87
	{mso-style-parent:style23;
	color:navy;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
.xl88
	{mso-style-parent:style23;
	color:navy;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl89
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl90
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl91
	{mso-style-parent:style23;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl92
	{mso-style-parent:style23;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:yellow;
	mso-pattern:auto none;}
.xl93
	{mso-style-parent:style23;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	background:yellow;
	mso-pattern:auto none;}
.xl94
	{mso-style-parent:style23;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:right;
	vertical-align:middle;
	background:yellow;
	mso-pattern:auto none;}
.xl95
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0000000;
	text-align:right;}
.xl96
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yy";
	text-align:right;}
-->
</style>
<![if !supportAnnotations]><style id="dynCom" type="text/css"><!-- --></style>

<script language="JavaScript"><!--

function msoCommentShow(com_id,anchor_id) {
	if(msoBrowserCheck()) {
	   c = document.all(com_id);
	   a = document.all(anchor_id);
	   if (null != c) {
		var cw = c.offsetWidth;
		var ch = c.offsetHeight;
		var aw = a.offsetWidth;
		var ah = a.offsetHeight;
		var x = a.offsetLeft;
		var y = a.offsetTop;
		var el = a;
		while (el.tagName != "BODY") {
		   el = el.offsetParent;
		   x = x + el.offsetLeft;
		   y = y + el.offsetTop;
		   }		
		var bw = document.body.clientWidth;
		var bh = document.body.clientHeight;
		var bsl = document.body.scrollLeft;
		var bst = document.body.scrollTop;
		if (x + cw + ah/2 > bw + bsl && x + aw - ah/2 - cw >= bsl ) {
		   c.style.left = x + aw - ah / 2 - cw; 
		}
		else {
		   c.style.left = x + ah/2; 
		}
		if (y + ch + ah/2 > bh + bst && y + ah/2 - ch >= bst ) {
	 	   c.style.top = y + ah/2 - ch;
		} 
		else {
		   c.style.top = y + ah/2;
		}
		c.style.visibility = "visible";
	   }
	}
}

function msoCommentHide(com_id) {
	if(msoBrowserCheck()) {
	  c = document.all(com_id)
	  if (null != c) {
	    c.style.visibility = "hidden";
	    c.style.left = "-10000";
	    c.style.top = "-10000";
	  }
	}
}

function msoBrowserCheck() {
 ms=navigator.appVersion.indexOf("MSIE");
 vers = navigator.appVersion.substring(ms+5, ms+6);
 ie4 = (ms>0) && (parseInt(vers) >=4);
 return ie4
}

if (msoBrowserCheck()) {
document.styleSheets.dynCom.addRule(".msocomspan1","position:absolute");
document.styleSheets.dynCom.addRule(".msocomspan2","position:absolute");
document.styleSheets.dynCom.addRule(".msocomspan2","left:-1.5ex");
document.styleSheets.dynCom.addRule(".msocomspan2","width:2ex");
document.styleSheets.dynCom.addRule(".msocomspan2","height:0.5em");
document.styleSheets.dynCom.addRule(".msocomanch","font-size:0.5em");
document.styleSheets.dynCom.addRule(".msocomanch","color:red");
document.styleSheets.dynCom.addRule(".msocomhide","display: none");
document.styleSheets.dynCom.addRule(".msocomtxt","visibility: hidden");
document.styleSheets.dynCom.addRule(".msocomtxt","position: absolute");        
document.styleSheets.dynCom.addRule(".msocomtxt","top:-10000");         
document.styleSheets.dynCom.addRule(".msocomtxt","left:-10000");         
document.styleSheets.dynCom.addRule(".msocomtxt","width: 33%");                 
document.styleSheets.dynCom.addRule(".msocomtxt","background: infobackground");
document.styleSheets.dynCom.addRule(".msocomtxt","color: infotext");
document.styleSheets.dynCom.addRule(".msocomtxt","border-top: 1pt solid threedlightshadow");
document.styleSheets.dynCom.addRule(".msocomtxt","border-right: 2pt solid threedshadow");
document.styleSheets.dynCom.addRule(".msocomtxt","border-bottom: 2pt solid threedshadow");
document.styleSheets.dynCom.addRule(".msocomtxt","border-left: 1pt solid threedlightshadow");
document.styleSheets.dynCom.addRule(".msocomtxt","padding: 3pt 3pt 3pt 3pt");
document.styleSheets.dynCom.addRule(".msocomtxt","z-index: 100");
}

// -->
</script>
<![endif]><!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>To Khai</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>225</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Zoom>120</x:Zoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>6675</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>-15</x:WindowTopX>
  <x:WindowTopY>6165</x:WindowTopY>
  <x:TabRatio>848</x:TabRatio>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="6145"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="5"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl29>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1015 style='border-collapse:
 collapse;table-layout:fixed;width:762pt'>
 <col class=xl29 width=23 style='mso-width-source:userset;mso-width-alt:654;
 width:17pt'>
 <col class=xl29 width=154 style='mso-width-source:userset;mso-width-alt:4380;
 width:116pt'>
 <col class=xl29 width=182 style='mso-width-source:userset;mso-width-alt:5176;
 width:137pt'>
 <col class=xl29 width=64 style='mso-width-source:userset;mso-width-alt:1820;
 width:48pt'>
 <col class=xl29 width=112 style='mso-width-source:userset;mso-width-alt:3185;
 width:84pt'>
 <col class=xl29 width=54 style='mso-width-source:userset;mso-width-alt:1536;
 width:41pt'>
 <col class=xl29 width=15 style='mso-width-source:userset;mso-width-alt:426;
 width:11pt'>
 <col class=xl29 width=21 style='mso-width-source:userset;mso-width-alt:597;
 width:16pt'>
 <col class=xl29 width=15 style='mso-width-source:userset;mso-width-alt:426;
 width:11pt'>
 <col class=xl29 width=135 style='mso-width-source:userset;mso-width-alt:3840;
 width:101pt'>
 <col class=xl29 width=80 span=3 style='width:60pt'>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl29 width=23 style='height:11.25pt;width:17pt'></td>
  <td class=xl29 width=154 style='width:116pt'></td>
  <td class=xl29 width=182 style='width:137pt'></td>
  <td class=xl29 width=64 style='width:48pt'></td>
  <td class=xl29 width=112 style='width:84pt'></td>
  <td class=xl29 width=54 style='width:41pt'></td>
  <td class=xl29 width=15 style='width:11pt'></td>
  <td class=xl29 width=21 style='width:16pt'></td>
  <td class=xl29 width=15 style='width:11pt'></td>
  <td class=xl29 width=135 style='width:101pt'></td>
  <td class=xl29 width=80 style='width:60pt'></td>
  <td class=xl29 width=80 style='width:60pt'></td>
  <td class=xl29 width=80 style='width:60pt'></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 colspan=13 class=xl29 style='height:23.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl29 style='height:26.25pt'><![if !supportAnnotations]><span
  class=msocomspan1><span class=msocomspan2 id="_anchor_1"
  onmouseover="msoCommentShow('_com_1','_anchor_1')"
  onmouseout="msoCommentHide('_com_1')" language=JavaScript><a
  class=msocomanch href="#_msocom_1" name="_msoanchor_1">[1]</a></span></span><![endif]></td>
  <td class=xl50><span
  style='mso-spacerun:yes'>                                                  
  </span><span style='display:none'><span
  style='mso-spacerun:yes'>              </span>3<span
  style='mso-spacerun:yes'>    </span>6<span style='mso-spacerun:yes'>  
  </span>0<span style='mso-spacerun:yes'>   </span>0<span
  style='mso-spacerun:yes'>   </span>7<span style='mso-spacerun:yes'>   
  </span>9<span style='mso-spacerun:yes'>   </span>0<span
  style='mso-spacerun:yes'>   </span>1<span style='mso-spacerun:yes'>  
  </span>5<span style='mso-spacerun:yes'>   </span>4</span></td>
  <td class=xl29><%=tax1  %><![if !supportAnnotations]><span class=msocomspan1><span
  class=msocomspan2 id="_anchor_2"
  onmouseover="msoCommentShow('_com_2','_anchor_2')"
  onmouseout="msoCommentHide('_com_2')" language=JavaScript><a
  class=msocomanch href="#_msocom_2" name="_msoanchor_2">[2]</a></span></span><![endif]></td>
  <td colspan=10 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl29 style='height:12.0pt'></td>
  <td class=xl30><span style='mso-spacerun:yes'>  </span><%=partner1   %></td>
  <td class=xl32></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl87>$sogpxk<![if !supportAnnotations]><span
  class=msocomspan1><span class=msocomspan2 id="_anchor_3"
  onmouseover="msoCommentShow('_com_3','_anchor_3')"
  onmouseout="msoCommentHide('_com_3')" language=JavaScript><a
  class=msocomanch href="#_msocom_3" name="_msoanchor_3">[3]</a></span></span><![endif]></td>
  <td class=xl33>$sohdgxk<![if !supportAnnotations]><span class=msocomspan1><span
  class=msocomspan2 id="_anchor_4"
  onmouseover="msoCommentShow('_com_4','_anchor_4')"
  onmouseout="msoCommentHide('_com_4')" language=JavaScript><a
  class=msocomanch href="#_msocom_4" name="_msoanchor_4">[4]</a></span></span><![endif]></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl29 style='height:13.5pt'></td>
  <td colspan=2 rowspan=3 class=xl81 width=336 style='width:253pt'><%=partner_add1   %></td>
  <td class=xl51></td>
  <td class=xl29></td>
  <td colspan=4 class=xl88><%=ngaygpxuat %></td>
  <td class=xl52><%=ngayhdgxuat  %><![if !supportAnnotations]><span class=msocomspan1><span
  class=msocomspan2 id="_anchor_5"
  onmouseover="msoCommentShow('_com_5','_anchor_5')"
  onmouseout="msoCommentHide('_com_5')" language=JavaScript><a
  class=msocomanch href="#_msocom_5" name="_msoanchor_5">[5]</a></span></span><![endif]></td>
  <td class=xl53></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt'></td>
  <td class=xl51></td>
  <td class=xl29></td>
  <td class=xl28></td>
  <td colspan=3 class=xl89></td>
  <td class=xl34><%=ngayhhxuat  %><![if !supportAnnotations]><span
  class=msocomspan1><span class=msocomspan2 id="_anchor_6"
  onmouseover="msoCommentShow('_com_6','_anchor_6')"
  onmouseout="msoCommentHide('_com_6')" language=JavaScript><a
  class=msocomanch href="#_msocom_6" name="_msoanchor_6">[6]</a></span></span><![endif]></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl29 style='height:15.75pt'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td colspan=3 class=xl38></td>
  <td class=xl28></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl29 style='height:14.25pt'></td>
  <td class=xl29><span
  style='mso-spacerun:yes'>                                                  
  </span><span style='display:none'><span
  style='mso-spacerun:yes'>               </span>0<span
  style='mso-spacerun:yes'>   </span>3<span style='mso-spacerun:yes'>  
  </span>0<span style='mso-spacerun:yes'>   </span>4<span
  style='mso-spacerun:yes'>   </span>9<span style='mso-spacerun:yes'>   
  </span>1<span style='mso-spacerun:yes'>   </span>8<span
  style='mso-spacerun:yes'>   </span>3<span style='mso-spacerun:yes'>  
  </span>8<span style='mso-spacerun:yes'>   </span>4</span></td>
  <td class=xl29><%=partner_add2%></td>
  <td class=xl29><![if !supportAnnotations]><span class=msocomspan1><span
  class=msocomspan2 id="_anchor_7"
  onmouseover="msoCommentShow('_com_7','_anchor_7')"
  onmouseout="msoCommentHide('_com_7')" language=JavaScript><a
  class=msocomanch href="#_msocom_7" name="_msoanchor_7">[7]</a></span></span><![endif]></td>
  <td class=xl29></td>
  <td class=xl54></td>
  <td colspan=3 class=xl91></td>
  <td class=xl55></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl35 style='height:15.0pt'><![if !supportAnnotations]><span
  class=msocomspan1><span class=msocomspan2 id="_anchor_8"
  onmouseover="msoCommentShow('_com_8','_anchor_8')"
  onmouseout="msoCommentHide('_com_8')" language=JavaScript><a
  class=msocomanch href="#_msocom_8" name="_msoanchor_8">[8]</a></span></span><![endif]></td>
  <td class=xl28><%=partner2  %></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl92 x:num="4102048926">4102048926<![if !supportAnnotations]><span
  class=msocomspan1><span class=msocomspan2 id="_anchor_9"
  onmouseover="msoCommentShow('_com_9','_anchor_9')"
  onmouseout="msoCommentHide('_com_9')" language=JavaScript><a
  class=msocomanch href="#_msocom_9" name="_msoanchor_9">[9]</a></span></span><![endif]></td>
  <td class=xl56><%=sohdgnhap  %><![if !supportAnnotations]><span class=msocomspan1><span
  class=msocomspan2 id="_anchor_10"
  onmouseover="msoCommentShow('_com_10','_anchor_10')"
  onmouseout="msoCommentHide('_com_10')" language=JavaScript><a
  class=msocomanch href="#_msocom_10" name="_msoanchor_10">[10]</a></span></span><![endif]></td>
  <td colspan=3 class=xl57 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt'></td>
  <td colspan=2 rowspan=2 class=xl81 width=336 style='width:253pt'><%=tax2  %></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl93 x:num="39188">4/16/2007</td>
  <td class=xl79><%=ngayhdgnhap  %><![if !supportAnnotations]><span class=msocomspan1><span
  class=msocomspan2 id="_anchor_11"
  onmouseover="msoCommentShow('_com_11','_anchor_11')"
  onmouseout="msoCommentHide('_com_11')" language=JavaScript><a
  class=msocomanch href="#_msocom_11" name="_msoanchor_11">[11]</a></span></span><![endif]></td>
  <td colspan=2 class=xl58 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl50 style='height:14.25pt'></td>
  <td class=xl50></td>
  <td class=xl29></td>
  <td rowspan=2 class=xl94>&nbsp;</td>
  <td colspan=3 rowspan=2 class=xl94>&nbsp;</td>
  <td class=xl79><%=ngayhhnhap  %><![if !supportAnnotations]><span
  class=msocomspan1><span class=msocomspan2 id="_anchor_12"
  onmouseover="msoCommentShow('_com_12','_anchor_12')"
  onmouseout="msoCommentHide('_com_12')" language=JavaScript><a
  class=msocomanch href="#_msocom_12" name="_msoanchor_12">[12]</a></span></span><![endif]></td>
  <td colspan=2 class=xl58 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl59 style='height:27.0pt'></td>
  <td class=xl60></td>
  <td class=xl59></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl61>&nbsp;</td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl35 style='height:15.75pt'></td>
  <td class=xl35><%=partner3  %><![if !supportAnnotations]><span
  class=msocomspan1><span class=msocomspan2 id="_anchor_13"
  onmouseover="msoCommentShow('_com_13','_anchor_13')"
  onmouseout="msoCommentHide('_com_13')" language=JavaScript><a
  class=msocomanch href="#_msocom_13" name="_msoanchor_13">[13]</a></span></span><![endif]></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td rowspan=2 class=xl90 width=112 style='width:84pt'><%=diadiemgiaohang  %><![if !supportAnnotations]><span
  class=msocomspan1><span class=msocomspan2 id="_anchor_14"
  onmouseover="msoCommentShow('_com_14','_anchor_14')"
  onmouseout="msoCommentHide('_com_14')" language=JavaScript><a
  class=msocomanch href="#_msocom_14" name="_msoanchor_14">[14]</a></span></span><![endif]></td>
  <td colspan=3 class=xl95><%=sodh12  %><![if !supportAnnotations]><span
  class=msocomspan1><span class=msocomspan2 id="_anchor_15"
  onmouseover="msoCommentShow('_com_15','_anchor_15')"
  onmouseout="msoCommentHide('_com_15')" language=JavaScript><a
  class=msocomanch href="#_msocom_15" name="_msoanchor_15">[15]</a></span></span><![endif]></td>
  <td colspan=2 class=xl54><%=hdtm  %> <![if !supportAnnotations]><span
  class=msocomspan1><span class=msocomspan2 id="_anchor_16"
  onmouseover="msoCommentShow('_com_16','_anchor_16')"
  onmouseout="msoCommentHide('_com_16')" language=JavaScript><a
  class=msocomanch href="#_msocom_16" name="_msoanchor_16">[16]</a></span></span><![endif]></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl29 style='height:16.5pt'></td>
  <td colspan=2 rowspan=2 class=xl81 width=336 style='width:253pt'>$partnerAddr3</td>
  <td class=xl29></td>
  <td colspan=3 class=xl96><%=ngaydh12  %><![if !supportAnnotations]><span
  class=msocomspan1><span class=msocomspan2 id="_anchor_17"
  onmouseover="msoCommentShow('_com_17','_anchor_17')"
  onmouseout="msoCommentHide('_com_17')" language=JavaScript><a
  class=msocomanch href="#_msocom_17" name="_msoanchor_17">[17]</a></span></span><![endif]></td>
  <td colspan=2 class=xl34><%=ngayhdtm  %><![if !supportAnnotations]><span
  class=msocomspan1><span class=msocomspan2 id="_anchor_18"
  onmouseover="msoCommentShow('_com_18','_anchor_18')"
  onmouseout="msoCommentHide('_com_18')" language=JavaScript><a
  class=msocomanch href="#_msocom_18" name="_msoanchor_18">[18]</a></span></span><![endif]></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl29 style='height:13.5pt'></td>
  <td class=xl29></td>
  <td class=xl62></td>
  <td class=xl63></td>
  <td colspan=2 class=xl64 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 colspan=4 class=xl29 style='height:9.0pt;mso-ignore:colspan'></td>
  <td class=xl50></td>
  <td colspan=4 class=xl63 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt'></td>
  <td class=xl26>Ng&#432;&#7901;i ch&#7881; &#273;&#7883;nh nh&#7853;n hàng<![if !supportAnnotations]><span
  class=msocomspan1><span class=msocomspan2 id="_anchor_19"
  onmouseover="msoCommentShow('_com_19','_anchor_19')"
  onmouseout="msoCommentHide('_com_19')" language=JavaScript><a
  class=msocomanch href="#_msocom_19" name="_msoanchor_19">[19]</a></span></span><![endif]></td>
  <td class=xl35></td>
  <td class=xl29></td>
  <td rowspan=2 class=xl84><%=phuongthucthanhtoan  %><![if !supportAnnotations]><span
  class=msocomspan1><span class=msocomspan2 id="_anchor_20"
  onmouseover="msoCommentShow('_com_20','_anchor_20')"
  onmouseout="msoCommentHide('_com_20')" language=JavaScript><a
  class=msocomanch href="#_msocom_20" name="_msoanchor_20">[20]</a></span></span><![endif]></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 rowspan=2 class=xl84><%=curr  %><![if !supportAnnotations]><span
  class=msocomspan1><span class=msocomspan2 id="_anchor_21"
  onmouseover="msoCommentShow('_com_21','_anchor_21')"
  onmouseout="msoCommentHide('_com_21')" language=JavaScript><a
  class=msocomanch href="#_msocom_21" name="_msoanchor_21">[21]</a></span></span><![endif]></td>
  <td rowspan=2 class=xl85><%=tigia  %><![if !supportAnnotations]><span
  class=msocomspan1><span class=msocomspan2 id="_anchor_22"
  onmouseover="msoCommentShow('_com_22','_anchor_22')"
  onmouseout="msoCommentHide('_com_22')" language=JavaScript><a
  class=msocomanch href="#_msocom_22" name="_msoanchor_22">[22]</a></span></span><![endif]></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl65 style='height:11.25pt'></td>
  <td class=xl30><%=partner4  %></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl29></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl65 style='height:11.25pt'></td>
  <td colspan=2 class=xl82><%=partner_add4  %></td>
  <td class=xl29></td>
  <td colspan=2 class=xl66 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=62 style='mso-height-source:userset;height:46.5pt'>
  <td height=62 class=xl50 style='height:46.5pt'></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl50 x:str="'"></td>
  <td colspan=8 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <%
    double qty=0, pack_qty=0, net_wt=0, gross_wt = 0, amt=0;
    string u_qty = "", u_wt = "", u_pack_qty = "";
    for (int i =0 ; i< dt.Rows.Count-1; i++)
    {        
        qty = qty +  Convert.ToDouble(dt.Rows[i][9]);
        pack_qty = pack_qty + Convert.ToDouble(dt.Rows[i][10]);
        net_wt = net_wt + Convert.ToDouble(dt.Rows[i][11]);
        gross_wt = gross_wt + Convert.ToDouble(dt.Rows[i][12]);
        amt = amt + Convert.ToDouble(dt.Rows[i][15]);
        u_qty = (string) dt.Rows[i][5].ToString() ;
        u_wt = (string)dt.Rows[i][14].ToString();
        u_pack_qty = (string)dt.Rows[i][13].ToString();
 %>
 <tr class=xl28 height=14 style='height:10.5pt'>
  <td height=14 class=xl28 style='height:10.5pt'></td>
  <td class=xl36 colspan=2 style='mso-ignore:colspan'><%=dt.Rows[i][0] %><span
  style='mso-spacerun:yes'>   </span><%=dt.Rows[i][1] %><span
  style='mso-spacerun:yes'>           </span><%=dt.Rows[i][2] %><![if !supportAnnotations]><span
  class=msocomspan1><span class=msocomspan2 id="_anchor_23"
  onmouseover="msoCommentShow('_com_23','_anchor_23')"
  onmouseout="msoCommentHide('_com_23')" language=JavaScript><a
  class=msocomanch href="#_msocom_23" name="_msoanchor_23">[23]</a></span></span><![endif]></td>
  <td class=xl38><%=dt.Rows[i][6] %><![if !supportAnnotations]><span class=msocomspan1><span
  class=msocomspan2 id="_anchor_24"
  onmouseover="msoCommentShow('_com_24','_anchor_24')"
  onmouseout="msoCommentHide('_com_24')" language=JavaScript><a
  class=msocomanch href="#_msocom_24" name="_msoanchor_24">[24]</a></span></span><![endif]></td>
  <td class=xl39><%=dt.Rows[i][4] %><![if !supportAnnotations]><span class=msocomspan1><span
  class=msocomspan2 id="_anchor_25"
  onmouseover="msoCommentShow('_com_25','_anchor_25')"
  onmouseout="msoCommentHide('_com_25')" language=JavaScript><a
  class=msocomanch href="#_msocom_25" name="_msoanchor_25">[25]</a></span></span><![endif]></td>
  <td colspan=2 class=xl86 ><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][6] %><span
  style='mso-spacerun:yes'> </span><![if !supportAnnotations]><span
  class=msocomspan1><span class=msocomspan2 id="_anchor_26"
  onmouseover="msoCommentShow('_com_26','_anchor_26')"
  onmouseout="msoCommentHide('_com_26')" language=JavaScript><a
  class=msocomanch href="#_msocom_26" name="_msoanchor_26">[26]</a></span></span><![endif]></td>
  <td colspan=2 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl80 ><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][7] %><span
  style='mso-spacerun:yes'> </span><![if !supportAnnotations]><span
  class=msocomspan1><span class=msocomspan2 id="_anchor_27"
  onmouseover="msoCommentShow('_com_27','_anchor_27')"
  onmouseout="msoCommentHide('_com_27')" language=JavaScript><a
  class=msocomanch href="#_msocom_27" name="_msoanchor_27">[27]</a></span></span><![endif]></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt'></td>
  <td class=xl41 x:str><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][3] %><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td class=xl44></td>
  <td class=xl45></td>
  <td colspan=2 class=xl46 style='mso-ignore:colspan'></td>
  <td class=xl47></td>
  <td class=xl80></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <tr class=xl28 height=0 style='display:none;mso-height-source:userset;
  mso-height-alt:240'>
  <td height=0 class=xl28></td>
  <td class=xl36></td>
  <td class=xl37></td>
  <td class=xl38></td>
  <td class=xl39></td>
  <td colspan=2 class=xl86></td>
  <td colspan=2 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  240'>
  <td height=0 class=xl29></td>
  <td class=xl41></td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td class=xl44></td>
  <td class=xl45></td>
  <td colspan=2 class=xl46 style='mso-ignore:colspan'></td>
  <td class=xl47></td>
  <td class=xl66></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>           
 <tr class=xl28 height=16 style='mso-height-source:userset;height:12.6pt'>
  <td height=16 class=xl28 style='height:12.6pt'></td>
  <td class=xl27 colspan=4 style='mso-ignore:colspan'
  x:str><span
  style='mso-spacerun:yes'> </span>TOTAL : <%=pack_qty%> <%=u_pack_qty  %> =<span
  style='mso-spacerun:yes'>  </span><%=qty%> <%=u_qty %> =<span style='mso-spacerun:yes'> 
  </span><%=net_wt%> <%=u_wt %> (N.W) = <%= gross_wt%> <%=u_wt %>(G.W)<span
  style='mso-spacerun:yes'>     </span><![if !supportAnnotations]><span
  class=msocomspan1><span class=msocomspan2 id="_anchor_28"
  onmouseover="msoCommentShow('_com_28','_anchor_28')"
  onmouseout="msoCommentHide('_com_28')" language=JavaScript><a
  class=msocomanch href="#_msocom_28" name="_msoanchor_28">[28]</a></span></span><![endif]></td>
  <td class=xl28></td>
  <td class=xl48 colspan=3 style='mso-ignore:colspan' x:str="C&#7897;ng :"><span
  style='mso-spacerun:yes'> </span>C&#7897;ng :<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl80 x:num><span
  style='mso-spacerun:yes'> </span><%=amt %><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl68 style='height:12.0pt'></td>
  <td colspan=8 class=xl42 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl68 style='height:12.75pt'></td>
  <td colspan=8 class=xl83></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl68 style='height:16.5pt'></td>
  <td class=xl69></td>
  <td class=xl42></td>
  <td class=xl46></td>
  <td class=xl70></td>
  <td class=xl43></td>
  <td colspan=2 class=xl46 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl68 style='height:16.5pt'></td>
  <td class=xl69></td>
  <td class=xl42></td>
  <td class=xl46></td>
  <td class=xl70></td>
  <td class=xl43></td>
  <td colspan=2 class=xl46 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl68 style='height:16.5pt'></td>
  <td class=xl29></td>
  <td class=xl71></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl71></td>
  <td colspan=7 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl68 style='height:12.0pt'></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl72></td>
  <td class=xl73></td>
  <td colspan=7 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl29 style='height:12.0pt'></td>
  <td class=xl74></td>
  <td colspan=11 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 colspan=13 class=xl29 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=13 class=xl29 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 colspan=2 class=xl29 style='height:11.25pt;mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=10 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 colspan=2 class=xl29 style='height:11.25pt;mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=10 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 colspan=2 class=xl29 style='height:11.25pt;mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=10 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 colspan=13 class=xl29 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=13 class=xl29 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl29 style='height:12.0pt'></td>
  <td class=xl75></td>
  <td class=xl29></td>
  <td class=xl76></td>
  <td class=xl29></td>
  <td class=xl77></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 colspan=13 class=xl29 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 colspan=13 class=xl29 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 class=xl78 style='height:11.25pt'></td>
  <td colspan=12 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 class=xl78 style='height:11.25pt'></td>
  <td colspan=12 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 class=xl78 style='height:11.25pt'></td>
  <td colspan=8 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl29 x:str="'"></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=23 style='width:17pt'></td>
  <td width=154 style='width:116pt'></td>
  <td width=182 style='width:137pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=112 style='width:84pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=15 style='width:11pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=15 style='width:11pt'></td>
  <td width=135 style='width:101pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
 </tr>
 <![endif]>
</table>

<div style='mso-element:comment-list'><![if !supportAnnotations]>

<hr class=msocomhide align=left size=1 width="33%">

<![endif]>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_1" class=msocomtxt
onmouseover="msoCommentShow('_com_1','_anchor_1')"
onmouseout="msoCommentHide('_com_1')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_1"
name="_msocom_1">[1]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shapetype id="_x0000_t202" coordsize="21600,21600" o:spt="202" path="m,l,21600r21600,l21600,xe">
  <v:stroke joinstyle="miter"/>
  <v:path gradientshapeok="t" o:connecttype="rect"/>
 </v:shapetype><v:shape id="_x0000_s5121" type="#_x0000_t202" style='position:absolute;
  margin-left:28.5pt;margin-top:-589.5pt;width:96pt;height:15.75pt;z-index:1;
  visibility:visible;mso-wrap-style:tight' fillcolor="infoBackground [80]"
  o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>2</x:Row>
   <x:Column>0</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5121" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">1. nguoi xk tai cho</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_2" class=msocomtxt
onmouseover="msoCommentShow('_com_2','_anchor_2')"
onmouseout="msoCommentHide('_com_2')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_2"
name="_msocom_2">[2]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5127" type="#_x0000_t202" style='position:absolute;
  margin-left:178.5pt;margin-top:-587.25pt;width:137.25pt;height:12.75pt;
  z-index:7;mso-wrap-style:tight' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>2</x:Row>
   <x:Column>2</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5127" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">MST nguoi xk tai cho</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_3" class=msocomtxt
onmouseover="msoCommentShow('_com_3','_anchor_3')"
onmouseout="msoCommentHide('_com_3')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_3"
name="_msocom_3">[3]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5123" type="#_x0000_t202" style='position:absolute;
  margin-left:378.75pt;margin-top:-597.75pt;width:96pt;height:39.75pt;
  z-index:3;visibility:visible;mso-wrap-style:tight' fillcolor="infoBackground [80]"
  o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>3</x:Row>
   <x:Column>5</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5123" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">6. giay phep XK (SO, NGAY)</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_4" class=msocomtxt
onmouseover="msoCommentShow('_com_4','_anchor_4')"
onmouseout="msoCommentHide('_com_4')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_4"
name="_msocom_4">[4]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5124" type="#_x0000_t202" style='position:absolute;
  margin-left:585pt;margin-top:-582pt;width:153pt;height:13.5pt;z-index:4;
  visibility:visible;mso-wrap-style:tight' fillcolor="infoBackground [80]"
  o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>3</x:Row>
   <x:Column>9</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5124" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">7. HOP DONG XK ( SO , NGAY)</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_5" class=msocomtxt
onmouseover="msoCommentShow('_com_5','_anchor_5')"
onmouseout="msoCommentHide('_com_5')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_5"
name="_msocom_5">[5]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5131" type="#_x0000_t202" style='position:absolute;
  margin-left:592.5pt;margin-top:-551.25pt;width:96pt;height:12.75pt;z-index:11;
  mso-wrap-style:tight' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>4</x:Row>
   <x:Column>9</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5131" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">NGÀY HDONG</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_6" class=msocomtxt
onmouseover="msoCommentShow('_com_6','_anchor_6')"
onmouseout="msoCommentHide('_com_6')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_6"
name="_msocom_6">[6]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5132" type="#_x0000_t202" style='position:absolute;
  margin-left:592.5pt;margin-top:-537.75pt;width:123pt;height:14.25pt;
  z-index:12;mso-wrap-style:tight' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>5</x:Row>
   <x:Column>9</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5132" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">NGAY HET HAN HDONG</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_7" class=msocomtxt
onmouseover="msoCommentShow('_com_7','_anchor_7')"
onmouseout="msoCommentHide('_com_7')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_7"
name="_msocom_7">[7]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5128" type="#_x0000_t202" style='position:absolute;
  margin-left:198.75pt;margin-top:-517.5pt;width:96.75pt;height:15.75pt;
  z-index:8;mso-wrap-style:tight' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>7</x:Row>
   <x:Column>3</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5128" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font9">MST nguoi NK tai cho<br>
</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_8" class=msocomtxt
onmouseover="msoCommentShow('_com_8','_anchor_8')"
onmouseout="msoCommentHide('_com_8')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_8"
name="_msocom_8">[8]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5122" type="#_x0000_t202" style='position:absolute;
  margin-left:23.25pt;margin-top:-498.75pt;width:96pt;height:15.75pt;z-index:2;
  visibility:visible;mso-wrap-style:tight' fillcolor="infoBackground [80]"
  o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>8</x:Row>
   <x:Column>0</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5122" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">2. nguoi nk tai cho</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_9" class=msocomtxt
onmouseover="msoCommentShow('_com_9','_anchor_9')"
onmouseout="msoCommentHide('_com_9')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_9"
name="_msocom_9">[9]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5125" type="#_x0000_t202" style='position:absolute;
  margin-left:388.5pt;margin-top:-521.25pt;width:96.75pt;height:33.75pt;
  z-index:5;visibility:visible;mso-wrap-style:tight' fillcolor="infoBackground [80]"
  o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>8</x:Row>
   <x:Column>5</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5125" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">9. GIAY PHEP NK (SO, NGAY)</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_10" class=msocomtxt
onmouseover="msoCommentShow('_com_10','_anchor_10')"
onmouseout="msoCommentHide('_com_10')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_10"
name="_msocom_10">[10]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5126" type="#_x0000_t202" style='position:absolute;
  margin-left:589.5pt;margin-top:-497.25pt;width:138.75pt;height:14.25pt;
  z-index:6;mso-wrap-style:tight' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>8</x:Row>
   <x:Column>9</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5126" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">10.HOP DONG NK ( SO, NGAY)</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_11" class=msocomtxt
onmouseover="msoCommentShow('_com_11','_anchor_11')"
onmouseout="msoCommentHide('_com_11')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_11"
name="_msocom_11">[11]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5129" type="#_x0000_t202" style='position:absolute;
  margin-left:592.5pt;margin-top:-477.75pt;width:96pt;height:14.25pt;z-index:9;
  mso-wrap-style:tight' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>9</x:Row>
   <x:Column>9</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5129" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">NGAY HDONG</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_12" class=msocomtxt
onmouseover="msoCommentShow('_com_12','_anchor_12')"
onmouseout="msoCommentHide('_com_12')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_12"
name="_msocom_12">[12]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5130" type="#_x0000_t202" style='position:absolute;
  margin-left:590.25pt;margin-top:-447.75pt;width:123pt;height:14.25pt;
  z-index:10;mso-wrap-style:tight' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>10</x:Row>
   <x:Column>9</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5130" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">NGAY HET HAN HDONG</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_13" class=msocomtxt
onmouseover="msoCommentShow('_com_13','_anchor_13')"
onmouseout="msoCommentHide('_com_13')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_13"
name="_msocom_13">[13]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5133" type="#_x0000_t202" style='position:absolute;
  margin-left:21pt;margin-top:-6in;width:154.5pt;height:15pt;z-index:13;
  mso-wrap-style:tight' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>12</x:Row>
   <x:Column>1</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5133" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">3. NGUOI CHI DINH GIAO HANG</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_14" class=msocomtxt
onmouseover="msoCommentShow('_com_14','_anchor_14')"
onmouseout="msoCommentHide('_com_14')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_14"
name="_msocom_14">[14]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5135" type="#_x0000_t202" style='position:absolute;
  margin-left:264pt;margin-top:-429pt;width:148.5pt;height:14.25pt;z-index:15;
  mso-wrap-style:tight' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>12</x:Row>
   <x:Column>4</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5135" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">11. DIA DIEM GIAO HANG</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_15" class=msocomtxt
onmouseover="msoCommentShow('_com_15','_anchor_15')"
onmouseout="msoCommentHide('_com_15')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_15"
name="_msocom_15">[15]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5136" type="#_x0000_t202" style='position:absolute;
  margin-left:425.25pt;margin-top:-432.75pt;width:79.5pt;height:13.5pt;
  z-index:16;mso-wrap-style:tight' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>12</x:Row>
   <x:Column>5</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5136" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">12. SO HDON</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_16" class=msocomtxt
onmouseover="msoCommentShow('_com_16','_anchor_16')"
onmouseout="msoCommentHide('_com_16')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_16"
name="_msocom_16">[16]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5138" type="#_x0000_t202" style='position:absolute;
  margin-left:592.5pt;margin-top:-421.5pt;width:96pt;height:13.5pt;z-index:18;
  mso-wrap-style:tight' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>12</x:Row>
   <x:Column>8</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5138" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">13. HDON TMAI NK</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_17" class=msocomtxt
onmouseover="msoCommentShow('_com_17','_anchor_17')"
onmouseout="msoCommentHide('_com_17')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_17"
name="_msocom_17">[17]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5137" type="#_x0000_t202" style='position:absolute;
  margin-left:405pt;margin-top:-383.25pt;width:68.25pt;height:15.75pt;
  z-index:17;mso-wrap-style:tight' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>13</x:Row>
   <x:Column>5</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5137" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">NGÀY HDON</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_18" class=msocomtxt
onmouseover="msoCommentShow('_com_18','_anchor_18')"
onmouseout="msoCommentHide('_com_18')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_18"
name="_msocom_18">[18]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5139" type="#_x0000_t202" style='position:absolute;
  margin-left:592.5pt;margin-top:-405.75pt;width:96pt;height:11.25pt;z-index:19;
  mso-wrap-style:tight' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>13</x:Row>
   <x:Column>8</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5139" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">NGAY HDONG TMAI</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_19" class=msocomtxt
onmouseover="msoCommentShow('_com_19','_anchor_19')"
onmouseout="msoCommentHide('_com_19')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_19"
name="_msocom_19">[19]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5134" type="#_x0000_t202" style='position:absolute;
  margin-left:29.25pt;margin-top:-378pt;width:174.75pt;height:15pt;z-index:14;
  mso-wrap-style:tight' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>16</x:Row>
   <x:Column>1</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5134" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">4. NGUOI LAM THU TUC HAI QUAN</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_20" class=msocomtxt
onmouseover="msoCommentShow('_com_20','_anchor_20')"
onmouseout="msoCommentHide('_com_20')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_20"
name="_msocom_20">[20]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5140" type="#_x0000_t202" style='position:absolute;
  margin-left:307.5pt;margin-top:-338.25pt;width:96pt;height:15.75pt;z-index:20;
  mso-wrap-style:tight' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>16</x:Row>
   <x:Column>4</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5140" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">14. PTHUC TTOAN</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_21" class=msocomtxt
onmouseover="msoCommentShow('_com_21','_anchor_21')"
onmouseout="msoCommentHide('_com_21')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_21"
name="_msocom_21">[21]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5141" type="#_x0000_t202" style='position:absolute;
  margin-left:367.5pt;margin-top:-313.5pt;width:117.75pt;height:12pt;z-index:21;
  mso-wrap-style:tight' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>16</x:Row>
   <x:Column>7</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5141" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">15. DONG TIEN TTOAN</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_22" class=msocomtxt
onmouseover="msoCommentShow('_com_22','_anchor_22')"
onmouseout="msoCommentHide('_com_22')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_22"
name="_msocom_22">[22]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5142" type="#_x0000_t202" style='position:absolute;
  margin-left:592.5pt;margin-top:-366.75pt;width:47.25pt;height:14.25pt;
  z-index:22;mso-wrap-style:tight' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>16</x:Row>
   <x:Column>9</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5142" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">TY GIA</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_23" class=msocomtxt
onmouseover="msoCommentShow('_com_23','_anchor_23')"
onmouseout="msoCommentHide('_com_23')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_23"
name="_msocom_23">[23]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5143" type="#_x0000_t202" style='position:absolute;
  margin-left:21pt;margin-top:-297.75pt;width:96pt;height:12.75pt;z-index:23;
  mso-wrap-style:tight' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>20</x:Row>
   <x:Column>1</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5143" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">16. TEN HANG, </font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_24" class=msocomtxt
onmouseover="msoCommentShow('_com_24','_anchor_24')"
onmouseout="msoCommentHide('_com_24')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_24"
name="_msocom_24">[24]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5144" type="#_x0000_t202" style='position:absolute;
  margin-left:176.25pt;margin-top:-293.25pt;width:75.75pt;height:11.25pt;
  z-index:24;mso-wrap-style:tight' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>20</x:Row>
   <x:Column>2</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5144" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">17. MA SO HS</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_25" class=msocomtxt
onmouseover="msoCommentShow('_com_25','_anchor_25')"
onmouseout="msoCommentHide('_com_25')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_25"
name="_msocom_25">[25]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5145" type="#_x0000_t202" style='position:absolute;
  margin-left:263.25pt;margin-top:-295.5pt;width:62.25pt;height:10.5pt;
  z-index:25;mso-wrap-style:tight' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>20</x:Row>
   <x:Column>3</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5145" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">18.Dvi tinh</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_26" class=msocomtxt
onmouseover="msoCommentShow('_com_26','_anchor_26')"
onmouseout="msoCommentHide('_com_26')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_26"
name="_msocom_26">[26]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5146" type="#_x0000_t202" style='position:absolute;
  margin-left:327pt;margin-top:-294.75pt;width:65.25pt;height:12.75pt;
  z-index:26;mso-wrap-style:tight' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>20</x:Row>
   <x:Column>4</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5146" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">19. SLUONG</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_27" class=msocomtxt
onmouseover="msoCommentShow('_com_27','_anchor_27')"
onmouseout="msoCommentHide('_com_27')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_27"
name="_msocom_27">[27]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5147" type="#_x0000_t202" style='position:absolute;
  margin-left:459pt;margin-top:-292.5pt;width:48pt;height:13.5pt;z-index:27;
  mso-wrap-style:tight' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>20</x:Row>
   <x:Column>5</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5147" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">20. DGIA</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_28" class=msocomtxt
onmouseover="msoCommentShow('_com_28','_anchor_28')"
onmouseout="msoCommentHide('_com_28')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_28"
name="_msocom_28">[28]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5148" type="#_x0000_t202" style='position:absolute;
  margin-left:592.5pt;margin-top:-285pt;width:124.5pt;height:13.5pt;z-index:28;
  mso-wrap-style:tight' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>20</x:Row>
   <x:Column>9</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5148" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">21. TRI GIA NGUYEN TE</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_29" class=msocomtxt
onmouseover="msoCommentShow('_com_29','_anchor_29')"
onmouseout="msoCommentHide('_com_29')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_29"
name="_msocom_29">[29]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shape id="_x0000_s5149" type="#_x0000_t202" style='position:absolute;
  margin-left:58.5pt;margin-top:-233.25pt;width:72.75pt;height:12pt;z-index:29;
  mso-wrap-style:tight' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>24</x:Row>
   <x:Column>1</x:Column>
   <x:Author>MYCOM</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s5149" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font10">TONG CONG</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

</div>

</body>

</html>
