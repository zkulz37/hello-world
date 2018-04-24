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
string p_std_ym = Request["dtMonth"];
string p_company_pk = Request["company_pk"];
int iYear, iMonth;

string iFromDt, iToDt;
    
 //p_std_ym = p_std_ym.Substring(3, 4) + p_std_ym.Substring(0, 2);
    iYear    = int.Parse(p_std_ym.Substring(0, 4));
    iMonth   = int.Parse(p_std_ym.Substring(4, 2));
    iFromDt  = "01/" + p_std_ym.Substring(4, 2) + "/" + p_std_ym.Substring(0, 4);
string SQL
	= "select PARTNER_NAME, tax_code, NVL(ADDR1, '') || NVL(ADDR2, ' ') || NVL(ADDR3, '') address " + 
        "from comm.tco_company where pk = " + p_company_pk ;
    DataTable dtCompany = new DataTable();
    dtCompany = ESysLib.TableReadOpen(SQL);        
    if(dtCompany.Rows.Count == 0)
    {
        Response.Write("There is not information to display!!!");
        Response.End();
    }    
SQL
	= "      SELECT tac_abacctcode_pk         " + 
        "        FROM tac_abtracgrpd d, tac_abtracgrp h " +
        "       WHERE d.del_if = 0 " +
        "         AND h.del_if = 0 " +
        "         AND d.tac_abtracgrp_pk = h.pk " +
        "         AND h.tco_company_pk = " + p_company_pk + 
        "         AND UPPER (TRIM (h.ac_grp)) = 'ALLOCATE' " +
        "         AND TRIM(d.ac_code) = '154000' " ;
    DataTable dt_154 = new DataTable();
    dt_154 = ESysLib.TableReadOpen(SQL);
    if(dt_154.Rows.Count == 0)
    {
        Response.Write("There is not information to display!!!");
        Response.End();
    }    

SQL
	= "      SELECT tac_abacctcode_pk         " + 
        "        FROM tac_abtracgrpd d, tac_abtracgrp h " +
        "       WHERE d.del_if = 0 " +
        "         AND h.del_if = 0 " +
        "         AND d.tac_abtracgrp_pk = h.pk " +
        "         AND h.tco_company_pk = " + p_company_pk + 
        "         AND UPPER (TRIM (h.ac_grp)) = 'ALLOCATE' " +
        "         AND TRIM(d.ac_code) = '155000' " ;
    DataTable dt_155 = new DataTable();
    dt_155 = ESysLib.TableReadOpen(SQL);
    if(dt_155.Rows.Count == 0)
    {
        Response.Write("There is not information to display!!!");
        Response.End();
    }    

SQL
	= "      SELECT tac_abacctcode_pk         " + 
        "        FROM tac_abtracgrpd d, tac_abtracgrp h " +
        "       WHERE d.del_if = 0 " +
        "         AND h.del_if = 0 " +
        "         AND d.tac_abtracgrp_pk = h.pk " +
        "         AND h.tco_company_pk = " + p_company_pk + 
        "         AND UPPER (TRIM (h.ac_grp)) = 'ALLOCATE' " +
        "         AND TRIM(d.ac_code) = '621000' " ;
    DataTable dt_621 = new DataTable();
    dt_621 = ESysLib.TableReadOpen(SQL);
    if(dt_621.Rows.Count == 0)
    {
        Response.Write("There is not information to display!!!");
        Response.End();
    }    

SQL
	= "      SELECT tac_abacctcode_pk         " + 
        "        FROM tac_abtracgrpd d, tac_abtracgrp h " +
        "       WHERE d.del_if = 0 " +
        "         AND h.del_if = 0 " +
        "         AND d.tac_abtracgrp_pk = h.pk " +
        "         AND h.tco_company_pk = " + p_company_pk + 
        "         AND UPPER (TRIM (h.ac_grp)) = 'ALLOCATE' " +
        "         AND TRIM(d.ac_code) = '622000' " ;
    DataTable dt_622 = new DataTable();
    dt_622 = ESysLib.TableReadOpen(SQL);
    if(dt_622.Rows.Count == 0)
    {
        Response.Write("There is not information to display!!!");
        Response.End();
    }    

SQL
	= "select pk from acnt.tac_abacctcode  " + 
        "where TRIM(ac_cd) = '627000' and del_if = 0 and tco_company_pk = " + p_company_pk ;
    DataTable dt_627 = new DataTable();
    dt_627 = ESysLib.TableReadOpen(SQL);
    if(dt_627.Rows.Count == 0)
    {
        Response.Write("There is not information to display!!!");
        Response.End();
    }    
    
 SQL
	= "select a.pk, a.item_code, a.item_name, a.uom, c.qty, NVL(tbl_154.open_154,0) remain_154, NVL(tbl_621.amt_621,0) amt_621, NVL(tbl_154.open_154,0) + NVL(tbl_621.amt_621, 0) tot_mat, " + 
        "        NVL(tbl_622.amt_622,0) amt_622, NVL(tbl_627.amt_627,0) amt_627, 0 other_amt, NVL(c.amt,0) amt_155, NVL(tbl_price.TAKEOUT_UP, 0) price  " +
        "from comm.tco_item a, " +
        "    acnt.tac_pmcost b, " +
        "    acnt.tac_pmcostd c, " +
        "    (select TCO_ITEM_PK, NVL(sum(last_amt), 0) open_154 from tac_stockmm where del_if = 0 and close_yn = 'N'  " +
        "        and std_ym = " + p_std_ym + " and tco_company_pk = " + p_company_pk + " and tac_abacctcode_pk = " + dt_154.Rows[0][0].ToString() +
        "        group by TCO_ITEM_PK ) tbl_154, " +
        "    ( select c1.tco_item_pk, sum(c1.amt) amt_621 " +
        "      from acnt.tac_pmcost b1, acnt.tac_pmcostd c1 " +
        "      where b1.del_if = 0 and c1.del_if = 0 " +
        "      and b1.close_yn = 'N' and c1.close_yn = 'N' and b1.pk = c1.TAC_PMCOST_PK " +
        "      and b1.std_ym = " + p_std_ym + " and b1.tco_company_pk = " + p_company_pk +
        "      and b1.tac_abacctcode_pk = " + dt_621.Rows[0][0].ToString() +
        "      group by c1.tco_item_pk  " +
        "      ) tbl_621, " +
        "    ( select c1.tco_item_pk, sum(c1.amt) amt_622 " +
        "      from acnt.tac_pmcost b1, acnt.tac_pmcostd c1 " +
        "      where b1.del_if = 0 and c1.del_if = 0 " +
        "      and b1.close_yn = 'N' and c1.close_yn = 'N' " +
        "      and b1.pk = c1.TAC_PMCOST_PK and b1.std_ym = " + p_std_ym + " and b1.tco_company_pk = " + p_company_pk +
        "      and b1.tac_abacctcode_pk = " + dt_622.Rows[0][0].ToString() + 
        "      group by c1.tco_item_pk " +
        "      ) tbl_622, " +
        "    ( select c1.tco_item_pk, sum(c1.amt) amt_627 " +
        "      from acnt.tac_pmcost b1, acnt.tac_pmcostd c1 " +
        "      where b1.del_if = 0 and c1.del_if = 0 " +
        "      and b1.close_yn = 'N' and c1.close_yn = 'N' and b1.pk = c1.TAC_PMCOST_PK " +
        "      and b1.std_ym = " + p_std_ym + " and b1.tco_company_pk = " + p_company_pk +
        "      and b1.tac_abacctcode_pk = " + dt_627.Rows[0][0].ToString() + 
        "      group by c1.tco_item_pk  " +
        "      ) tbl_627, " +
        "      ( select TCO_ITEM_PK, TAKEOUT_UP " +
        "      from acnt.TAC_CRCOST_UP " +
        "      where del_if = 0 " +
        "      and TCO_COMPANY_PK = " + p_company_pk +
        "      and std_ym = " + p_std_ym + " ) tbl_price " +
        "    where b.del_if = 0 " +
        "    and c.del_if = 0 " +
        "    and a.del_if(+) = 0 " +
        "    and b.close_yn = 'N' " +
        "    and c.close_yn = 'N'  " +
        "    and b.pk = c.TAC_PMCOST_PK " +
        "    and b.TCO_COMPANY_PK = " + p_company_pk +
        "    and b.std_ym = " + p_std_ym +
        "    and c.tco_item_pk = a.pk(+) " +
        "    and b.tac_abacctcode_pk = " + dt_155.Rows[0][0].ToString() + 
        "    and c.tco_item_pk = tbl_154.tco_item_pk(+) " +
        "    and c.tco_item_pk = tbl_621.tco_item_pk(+) " +
        "    and c.tco_item_pk = tbl_622.tco_item_pk(+) " +
        "    and c.tco_item_pk = tbl_627.tco_item_pk(+) " +
        "    and c.tco_item_pk = tbl_price.tco_item_pk(+) " ;
    DataTable dt_Item = new DataTable();
    dt_Item = ESysLib.TableReadOpen(SQL);
   
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="bang%20tinh%20gia%20thanh%20pham_files/filelist.xml">
<link rel=Edit-Time-Data
href="bang%20tinh%20gia%20thanh%20pham_files/editdata.mso">
<link rel=OLE-Object-Data
href="bang%20tinh%20gia%20thanh%20pham_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>van</o:Author>
  <o:LastAuthor>van</o:LastAuthor>
  <o:LastPrinted>2008-11-24T06:40:46Z</o:LastPrinted>
  <o:Created>2008-11-24T06:36:55Z</o:Created>
  <o:LastSaved>2008-11-24T06:43:05Z</o:LastSaved>
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
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style17
	{mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	mso-style-name:"Comma \[0\]";
	mso-style-id:6;}
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style17;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style17;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style17;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl36
	{mso-style-parent:style17;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style17;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style17;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\\\(\#\,\#\#0\.00\\\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\\\(\#\,\#\#0\.00\\\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style17;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	}	
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
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

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1259 style='border-collapse:
 collapse;table-layout:fixed;width:949pt'>
 <col class=xl25 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl25 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl25 width=149 style='mso-width-source:userset;mso-width-alt:5449;
 width:112pt'>
 <col class=xl25 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl25 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl25 width=110 span=7 style='mso-width-source:userset;mso-width-alt:
 4022;width:83pt'>
 <col class=xl25 width=95 style='mso-width-source:userset;mso-width-alt:3474;
 width:71pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 colspan=3 width=250 style='height:15.0pt;mso-ignore:
  colspan;width:188pt'><%=dtCompany.Rows[0][0] %></td>
  <td class=xl25 width=66 style='width:50pt'></td>
  <td class=xl25 width=78 style='width:59pt'></td>
  <td class=xl25 width=110 style='width:83pt'></td>
  <td class=xl25 width=110 style='width:83pt'></td>
  <td class=xl25 width=110 style='width:83pt'></td>
  <td class=xl25 width=110 style='width:83pt'></td>
  <td class=xl25 width=110 style='width:83pt'></td>
  <td class=xl25 width=110 style='width:83pt'></td>
  <td class=xl25 width=110 style='width:83pt'></td>
  <td class=xl25 width=95 style='width:71pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 colspan=5 style='height:15.0pt;mso-ignore:colspan'><%=dtCompany.Rows[0][2] %></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=9 style='mso-height-source:userset;height:6.75pt'>
  <td height=9 colspan=13 class=xl25 style='height:6.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=13 height=27 class=xl43 style='height:20.25pt'>BẢNG TÍNH GIÁ
  THÀNH PHẨM</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=13 height=20 class=xl26 style='height:15.0pt'>Tháng <%=p_std_ym.Substring(4, 2) %>/<%=p_std_ym.Substring(0, 4) %></td>
 </tr>
 <tr class=xl30 height=19 style='height:14.25pt'>
  <td rowspan=2 height=38 class=xl27 style='height:28.5pt'>STT</td>
  <td colspan=3 class=xl27 style='border-left:none'>Vật tư hàng hóa</td>
  <td rowspan=2 class=xl28 x:str="Số lượng"><span
  style='mso-spacerun:yes'> </span>Số lượng<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl28 x:str="Chi phí dở dang"><span
  style='mso-spacerun:yes'> </span>Chi phí dở dang<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl29 width=110 style='width:83pt'
  x:str="Chi phí NVL&#10;Phát sinh"><span style='mso-spacerun:yes'> </span>Chi
  phí NVL<br>
    Phát sinh<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl29 width=110 style='width:83pt' x:str="Tổng chi phí&#10;NVL"><span
  style='mso-spacerun:yes'> </span>Tổng chi phí<br>
    NVL<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl29 width=110 style='width:83pt'
  x:str="Chi phí&#10;nhân công"><span style='mso-spacerun:yes'> </span>Chi
  phí<br>
    nhân công<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl29 width=110 style='width:83pt' x:str="Chi phí&#10;SX chung"><span
  style='mso-spacerun:yes'> </span>Chi phí<br>
    SX chung<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl28 x:str="Chi phí khác"><span
  style='mso-spacerun:yes'> </span>Chi phí khác<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl28 x:str="Giá thành"><span
  style='mso-spacerun:yes'> </span>Giá thành<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl28 x:str="Đơn giá"><span
  style='mso-spacerun:yes'> </span>Đơn giá<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl30 height=19 style='height:14.25pt'>
  <td height=19 class=xl27 style='height:14.25pt;border-top:none;border-left:
  none'>Mã</td>
  <td class=xl27 style='border-top:none;border-left:none'>Tên VT, háng hóa</td>
  <td class=xl27 style='border-top:none;border-left:none'>Đơn vị</td>
 </tr>
 <% 
    int i ;
    decimal l_Qty = 0, l_amt_154 = 0, l_amt_621 = 0, l_tot_amt = 0, l_amt_622 = 0, l_amt_627 = 0, l_other_amt = 0, l_amt_155 = 0 ;
    for(i = 0; i < dt_Item.Rows.Count; i++)
    {
        if(dt_Item.Rows[i][4].ToString().Trim() != "")        
            l_Qty += decimal.Parse(dt_Item.Rows[i][4].ToString());
        if(dt_Item.Rows[i][5].ToString().Trim() != "")        
            l_amt_154 += decimal.Parse(dt_Item.Rows[i][5].ToString());
        if(dt_Item.Rows[i][6].ToString().Trim() != "")        
            l_amt_621 += decimal.Parse(dt_Item.Rows[i][6].ToString());
        if(dt_Item.Rows[i][7].ToString().Trim() != "")        
            l_tot_amt += decimal.Parse(dt_Item.Rows[i][7].ToString());
        if(dt_Item.Rows[i][8].ToString().Trim() != "")        
            l_amt_622 += decimal.Parse(dt_Item.Rows[i][8].ToString());
        if(dt_Item.Rows[i][9].ToString().Trim() != "")        
            l_amt_627 += decimal.Parse(dt_Item.Rows[i][9].ToString());
        if(dt_Item.Rows[i][10].ToString().Trim() != "")        
            l_other_amt += decimal.Parse(dt_Item.Rows[i][10].ToString());
        if(dt_Item.Rows[i][11].ToString().Trim() != "")        
            l_amt_155 += decimal.Parse(dt_Item.Rows[i][11].ToString());
        
 %>
 <tr class=xl33 height=20 style='height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt;border-top:none' x:num><%=i+1 %></td>
  <td class=xl44 style='border-top:none;border-left:none'><%=dt_Item.Rows[i][1] %></td>
  <td class=xl45 width=149 style='border-top:none;border-left:none;width:112pt'
  x:str><%=dt_Item.Rows[i][2] %></td>
  <td class=xl37 style='border-top:none;border-left:none' x:str><span
  style='mso-spacerun:yes'> </span><%=dt_Item.Rows[i][3] %><span style='mso-spacerun:yes'> </span></td>
  <td class=xl38 align=right style='border-top:none;border-left:none'
  x:num><%=dt_Item.Rows[i][4] %></td>
  <td class=xl40 align=right style='border-top:none;border-left:none' x:num><%=dt_Item.Rows[i][5] %></td>
  <td class=xl40 align=right style='border-top:none;border-left:none'
  x:num><%=dt_Item.Rows[i][6] %></td>
  <td class=xl40 align=right style='border-top:none;border-left:none'
  x:num><%=dt_Item.Rows[i][7] %></td>
  <td class=xl40 align=right style='border-top:none;border-left:none'
  x:num><%=dt_Item.Rows[i][8] %></td>
  <td class=xl40 align=right style='border-top:none;border-left:none'
  x:num><%=dt_Item.Rows[i][9] %></td>
  <td class=xl40 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl40 align=right style='border-top:none;border-left:none'
  x:num><%=dt_Item.Rows[i][11] %></td>
  <td class=xl40 align=right style='border-top:none;border-left:none'
  x:num><%=dt_Item.Rows[i][12] %></td>
 </tr>
 <% 
    }
 %>
 <tr class=xl33 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>Tổng cộng</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 align=right style='border-top:none;border-left:none'
  x:num><%=l_Qty %></td>
  <td class=xl41 align=right style='border-top:none;border-left:none' x:num
  ><%=l_amt_154 %></td>
  <td class=xl41 align=right style='border-top:none;border-left:none'
  x:num><%=l_amt_621 %></td>
  <td class=xl41 align=right style='border-top:none;border-left:none'
  x:num><%=l_tot_amt %></td>
  <td class=xl41 align=right style='border-top:none;border-left:none'
  x:num><%=l_amt_622 %></td>
  <td class=xl41 align=right style='border-top:none;border-left:none'
  x:num><%=l_amt_627%></td>
  <td class=xl41 align=right style='border-top:none;border-left:none' x:num
  ><%=l_other_amt %></td>
  <td class=xl41 align=right style='border-top:none;border-left:none'
  x:num><%=l_amt_155 %></td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=13 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=13 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=13 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=13 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=13 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=13 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=13 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=38 style='width:29pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=149 style='width:112pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=95 style='width:71pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
