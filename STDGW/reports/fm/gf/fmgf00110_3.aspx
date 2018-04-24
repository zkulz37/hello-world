<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>


<% 
    string SQL = "";
    int iYear, iMonth ;
    string iToDt = "";
    string ls_std_ym = Request["std_ym"];
    string ls_ac_cd = Request["ac_cd"];
    string ls_tin_warehouse_pk = Request["tin_warehouse_pk"];
    string ls_tco_company_pk = Request["tco_company_pk"];
    string v_ac_cd = "";
    decimal v_trans_amt = 0, v_books_amt = 0 ;
    decimal v_tot_trans_amt = 0, v_tot_books_amt = 0 ;
    int i ;
    ls_ac_cd = ls_ac_cd.Trim();
    if (ls_ac_cd == "")
    {
        ls_ac_cd = "ALL";            
    }
    SQL
	= "select pk, PARTNER_NAME, NVL(ADDR1, '') || NVL(ADDR2, ' ') || NVL(ADDR3, ' '), TAX_CODE from comm.tco_company where del_if = 0 " ;
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

 SQL
	= "select a.STOCKTR_NO, to_char(to_date(a.TR_DATE, 'YYYYMMDD'), 'DD/MM/YYYY') trans_dt, b.item_code, b.item_name, b.UOM, " + 
        "    a.INPUT_QTY, a.in_uprice, a.IN_TRAMT, a.in_amt, c.IMPVAT_FAMT, c.IMPVAT_AMT, d1.pl_cd, d1.pl_nm, e.PARTNER_ID,  " +
        "    e.PARTNER_NAME, c1.INVOICE_NO, c1.INVOICE_Date, c1.REMARK2, f.ac_cd, w.wh_name " +
        "from tac_stocktr a, comm.tco_item b, tac_crdad c, tac_crda c1, tac_abplcenter d, tac_abpl d1, " +
        "    comm.TCO_BUSPARTNER e, tac_abacctcode f, inv.tin_warehouse w " +
        "where a.del_if = 0 and b.del_if(+) = 0 " +
        "and c.del_if = 0 and c1.del_if = 0 " +
        "and f.del_if(+) = 0 " +
        "and a.TR_TABLE_NM = 'TAC_CRDAD' " +
        "and a.TR_TABLE_PK = c.PK " +
        "and c.TAC_CRDA_PK = c1.pk " +
        "and c.TAC_ABPLCENTER_PK = d.PK(+) " +
        "and d.TAC_ABPL_PK = d1.pk(+)  " +
        "and a.TAC_ABACCTCODE_PK = f.pk(+) " +
        "and a.tco_item_pk = b.PK(+) " +
        "and c1.TCO_BUSPARTNER_PK = e.pk(+) " +
	    " and a.tin_warehouse_pk = w.pk(+) " + 
        " and a.trin_type = '10' " +
	   " and (a.tin_warehouse_pk like decode('" + ls_tin_warehouse_pk + "', 'ALL', '%', '" + ls_tin_warehouse_pk + "') or '" + ls_tin_warehouse_pk + "' is null)" +
        "and ( substr(a.tr_date, 1, 6) like " + "' " + ls_std_ym + "' or a.std_ym = '" +  ls_std_ym + "' ) " +
        " and c1.tr_status in ('2', '0') " +
        " and decode('" + ls_ac_cd + "', 'ALL', 'ALL', substr(f.ac_cd, 1, 3)) = decode('" + ls_ac_cd + "', 'ALL', 'ALL', substr('" + ls_ac_cd + "', 1, 3)) " +
        //" and f.ac_cd IN ('152111', '152112' ) " +
        //"and substr(f.ac_cd, 1, 3) = substr('" + ls_ac_cd + "', 1, 3) " +
        "and a.tco_company_pk = '" + ls_tco_company_pk + "' " +
		" order by f.ac_cd, a.tr_date, b.item_code " ;
 //Response.Write(SQL);
 //Response.End();
	DataTable dtItem = new DataTable();
    dtItem = ESysLib.TableReadOpen(SQL) ;	
    if(dtItem.Rows.Count > 0)
    {   
        v_ac_cd = dtItem.Rows[0][18].ToString().Trim() ;
    }
    
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List
href="bao%20cao%20nhap%20chi%20tiet%20trong%20ky_files/filelist.xml">
<link rel=Edit-Time-Data
href="bao%20cao%20nhap%20chi%20tiet%20trong%20ky_files/editdata.mso">
<link rel=OLE-Object-Data
href="bao%20cao%20nhap%20chi%20tiet%20trong%20ky_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>van</o:LastAuthor>
  <o:LastPrinted>2008-12-25T03:38:07Z</o:LastPrinted>
  <o:Created>2006-09-14T03:47:35Z</o:Created>
  <o:LastSaved>2008-12-25T03:40:03Z</o:LastSaved>
  <o:Version>11.6360</o:Version>
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
.xl24
	{mso-style-parent:style0;
	font-size:8.0pt;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;}
.xl26
	{mso-style-parent:style16;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl27
	{mso-style-parent:style16;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:0%;
	text-align:left;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	color:black;
	font-size:16.0pt;
	font-weight:700;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style16;
	font-size:11.0pt;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style16;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style16;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0\.00_\)\;\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style16;
	font-size:11.0pt;
	mso-number-format:"\#\,\#\#0\.00_\)\;\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style16;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0\.00_\)\;\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style16;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	mso-number-format:"\#\,\#\#0\.00_\)\;\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	font-size:11.0pt;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	font-size:11.0pt;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	font-size:11.0pt;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;	
	}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>BC_HN</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>225</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>40</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
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
       <x:ActiveRow>7</x:ActiveRow>
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
  <x:Formula>=BC_HN!$A$6:$R$6</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=BC_HN!$6:$6</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>
<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2225 style='border-collapse:
 collapse;table-layout:fixed;width:1673pt'>
 <col class=xl24 width=174 style='mso-width-source:userset;mso-width-alt:7424;
 width:131pt'>
 <col class=xl25 width=128 style='mso-width-source:userset;mso-width-alt:5461;
 width:96pt'>
 <col class=xl24 width=92 style='mso-width-source:userset;mso-width-alt:3925;
 width:69pt'>
 <col class=xl24 width=194 style='mso-width-source:userset;mso-width-alt:8277;
 width:146pt'>
 <col class=xl25 width=50 style='mso-width-source:userset;mso-width-alt:2133;
 width:38pt'>
 <col class=xl26 width=77 style='mso-width-source:userset;mso-width-alt:3285;
 width:58pt'>
 <col class=xl27 width=65 style='mso-width-source:userset;mso-width-alt:2773;
 width:49pt'>
 <col class=xl27 width=111 style='mso-width-source:userset;mso-width-alt:4736;
 width:83pt'>
 <col class=xl26 width=118 style='mso-width-source:userset;mso-width-alt:5034;
 width:89pt'>
 <col class=xl26 width=101 style='mso-width-source:userset;mso-width-alt:4309;
 width:76pt'>
 <col class=xl26 width=96 style='mso-width-source:userset;mso-width-alt:4096;
 width:72pt'>
 <col class=xl24 width=102 style='mso-width-source:userset;mso-width-alt:4352;
 width:77pt'>
 <col class=xl24 width=158 style='mso-width-source:userset;mso-width-alt:6741;
 width:119pt'>
 <col class=xl24 width=101 style='mso-width-source:userset;mso-width-alt:4309;
 width:76pt'>
 <col class=xl24 width=142 style='mso-width-source:userset;mso-width-alt:6058;
 width:107pt'>
 <col class=xl24 width=195 style='mso-width-source:userset;mso-width-alt:8320;
 width:146pt'>
 <col class=xl24 width=202 style='mso-width-source:userset;mso-width-alt:8618;
 width:152pt'>
 <col class=xl24 width=119 style='mso-width-source:userset;mso-width-alt:5077;
 width:89pt'>
  <col class=xl24 width=141 style='mso-width-source:userset;mso-width-alt:6016;
 width:106pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 width=174 style='height:15.75pt;width:131pt'><%=dtCompany.Rows[0][1] %></td>
  <td class=xl25 width=128 style='width:96pt'></td>
  <td class=xl24 width=92 style='width:69pt'></td>
  <td class=xl24 width=194 style='width:146pt'></td>
  <td class=xl25 width=50 style='width:38pt'></td>
  <td class=xl26 width=77 style='width:58pt'></td>
  <td class=xl27 width=65 style='width:49pt'></td>
  <td class=xl27 width=111 style='width:83pt'></td>
  <td class=xl26 width=118 style='width:89pt'></td>
  <td class=xl26 width=101 style='width:76pt'></td>
  <td class=xl26 width=96 style='width:72pt'></td>
  <td class=xl24 width=102 style='width:77pt'></td>
  <td class=xl24 width=158 style='width:119pt'></td>
  <td class=xl24 width=101 style='width:76pt'></td>
  <td class=xl24 width=142 style='width:107pt'></td>
  <td class=xl24 width=195 style='width:146pt'></td>
  <td class=xl24 width=202 style='width:152pt'></td>
  <td class=xl24 width=119 style='width:89pt'></td>
  <td class=xl24 width=119 style='width:106pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl29 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Địa
  chỉ: <%=dtCompany.Rows[0][2] %></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl29 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Mã
  số thuế: <%=dtCompany.Rows[0][3] %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td height=27 class=xl30 colspan=4 style='height:20.25pt;mso-ignore:colspan'>CHI
  TIẾT NHẬP TRONG KỲ <%="01/" + ls_std_ym.Substring(4, 2) + "/" + ls_std_ym.Substring(0, 4) %> ~ <%=iToDt %></td>
  <td colspan=14 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 class=xl24 style='height:11.25pt'></td>
  <td class=xl25></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl31 style='height:20.1pt'>Voucher. No.</td>
  <td class=xl31 style='border-left:none'>Trans Date</td>
  <td class=xl31 style='border-left:none'>Code</td>
  <td class=xl31 style='border-left:none'>Name of material</td>
  <td class=xl31 style='border-left:none'>Unit</td>
  <td class=xl37 style='border-left:none' x:str="Q'ty"><span
  style='mso-spacerun:yes'> </span>Q'ty<span style='mso-spacerun:yes'> </span></td>
  <td class=xl38 style='border-left:none' x:str="U.price"><span
  style='mso-spacerun:yes'> </span>U.price<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl38 style='border-left:none' x:str="Trans Amount"><span
  style='mso-spacerun:yes'> </span>Trans Amount<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl37 style='border-left:none' x:str="Books Amount"><span
  style='mso-spacerun:yes'> </span>Books Amount<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl37 style='border-left:none' x:str="VAT Trans"><span
  style='mso-spacerun:yes'> </span>VAT Trans<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl37 style='border-left:none' x:str="VAT Books"><span
  style='mso-spacerun:yes'> </span>VAT Books<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl31 style='border-left:none'>P/L Unit Code</td>
  <td class=xl31 style='border-left:none'>P/L Unit Name</td>
  <td class=xl31 style='border-left:none'>Supplier Code</td>
  <td class=xl31 style='border-left:none'>Supplier Name</td>
  <td class=xl31 style='border-left:none'>Invoice No (custom number)</td>
  <td class=xl31 style='border-left:none'>InvoiceDate (custom date)</td>
  <td class=xl31 style='border-left:none'>Remark</td>
  <td class=xl31 style='border-left:none'>WH</td>
 </tr>
 <tr class=xl33 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl46 style='height:20.1pt;border-top:none'>P/L Unit Code
  || P/L Unit <span style='display:none'>Name</span></td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl65 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <% 
    for(i = 0; i < dtItem.Rows.Count ; i++)
    {    
        if(v_ac_cd != dtItem.Rows[i][18].ToString().Trim())
        {            
 %> 
  <tr class=xl34 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl42 style='height:20.1pt;border-top:none'>Sub total</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none' x:str><%=v_ac_cd %></td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><%= v_trans_amt%></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><%= v_books_amt%></td>
  <td class=xl57 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl57 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl62 width=158 style='border-top:none;border-left:none;width:119pt'>&nbsp;</td>
  <td class=xl64 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl64 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl64 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
  <tr class=xl36 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl49 style='height:20.1pt;border-top:none'>P/L Unit Code
  || P/L Unit Name</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl54 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl54 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl54 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl54 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl58 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl58 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <% 
            v_ac_cd = dtItem.Rows[i][18].ToString().Trim();    
            v_trans_amt = 0;
            v_books_amt = 0;
            v_trans_amt += decimal.Parse(dtItem.Rows[i][7].ToString());
            v_books_amt += decimal.Parse(dtItem.Rows[i][8].ToString());
            v_tot_trans_amt += decimal.Parse(dtItem.Rows[i][7].ToString());
            v_tot_books_amt += decimal.Parse(dtItem.Rows[i][8].ToString());
%>
 <tr class=xl33 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl40 style='height:20.1pt;border-top:none'><%=dtItem.Rows[i][0] %></td>
  <td class=xl50 style='border-top:none;border-left:none'><%=dtItem.Rows[i][1] %></td>
  <td class=xl40 style='border-top:none;border-left:none'><%=dtItem.Rows[i][2] %></td>
  <td class=xl40 style='border-top:none;border-left:none'><%=dtItem.Rows[i][3] %></td>
  <td class=xl40 style='border-top:none;border-left:none'><%=dtItem.Rows[i][4] %></td>
  <td class=xl52 style='border-top:none;border-left:none' x:num><%=dtItem.Rows[i][5] %></td>
  <td class=xl52 style='border-top:none;border-left:none' x:num><%=dtItem.Rows[i][6] %></td>
  <td class=xl52 style='border-top:none;border-left:none' x:num><%=dtItem.Rows[i][7] %></td>
  <td class=xl52 style='border-top:none;border-left:none' x:num><%=dtItem.Rows[i][8] %></td>
  <td class=xl56 style='border-top:none;border-left:none' x:num><%=dtItem.Rows[i][9] %></td>
  <td class=xl56 style='border-top:none;border-left:none' x:num><%=dtItem.Rows[i][10] %></td>
  <td class=xl60 style='border-top:none;border-left:none' x:str><%=dtItem.Rows[i][11] %></td>
  <td class=xl61 style='border-top:none;border-left:none' x:str><%=dtItem.Rows[i][12] %></td>
  <td class=xl61 style='border-top:none;border-left:none' x:str><%=dtItem.Rows[i][13] %></td>
  <td class=xl61 style='border-top:none;border-left:none' x:str><%=dtItem.Rows[i][14] %></td>
  <td class=xl61 style='border-top:none;border-left:none' x:str><%=dtItem.Rows[i][15] %></td>
  <td class=xl66 style='border-top:none;border-left:none' x:str><%=dtItem.Rows[i][16] %></td>
  <td class=xl69 style='border-top:none;border-left:none' x:str><%=dtItem.Rows[i][17] %></td>
  <td class=xl69 style='border-top:none;border-left:none' x:str><%=dtItem.Rows[i][19] %></td>
 </tr>

<%            
        }
        else
        {
            v_trans_amt += decimal.Parse(dtItem.Rows[i][7].ToString());
            v_books_amt += decimal.Parse(dtItem.Rows[i][8].ToString());
            v_tot_trans_amt += decimal.Parse(dtItem.Rows[i][7].ToString());
            v_tot_books_amt += decimal.Parse(dtItem.Rows[i][8].ToString());
 %>

 <tr class=xl33 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl40 style='height:20.1pt;border-top:none'><%=dtItem.Rows[i][0] %></td>
  <td class=xl50 style='border-top:none;border-left:none'><%=dtItem.Rows[i][1] %></td>
  <td class=xl40 style='border-top:none;border-left:none'><%=dtItem.Rows[i][2] %></td>
  <td class=xl40 style='border-top:none;border-left:none'><%=dtItem.Rows[i][3] %></td>
  <td class=xl40 style='border-top:none;border-left:none'><%=dtItem.Rows[i][4] %></td>
  <td class=xl52 style='border-top:none;border-left:none' x:num><%=dtItem.Rows[i][5] %></td>
  <td class=xl52 style='border-top:none;border-left:none' x:num><%=dtItem.Rows[i][6] %></td>
  <td class=xl52 style='border-top:none;border-left:none' x:num><%=dtItem.Rows[i][7] %></td>
  <td class=xl52 style='border-top:none;border-left:none' x:num><%=dtItem.Rows[i][8] %></td>
  <td class=xl56 style='border-top:none;border-left:none' x:num><%=dtItem.Rows[i][9] %></td>
  <td class=xl56 style='border-top:none;border-left:none' x:num><%=dtItem.Rows[i][10] %></td>
  <td class=xl60 style='border-top:none;border-left:none' x:str><%=dtItem.Rows[i][11] %></td>
  <td class=xl61 style='border-top:none;border-left:none' x:str><%=dtItem.Rows[i][12] %></td>
  <td class=xl61 style='border-top:none;border-left:none' x:str><%=dtItem.Rows[i][13] %></td>
  <td class=xl61 style='border-top:none;border-left:none' x:str><%=dtItem.Rows[i][14] %></td>
  <td class=xl61 style='border-top:none;border-left:none' x:str><%=dtItem.Rows[i][15] %></td>
  <td class=xl66 style='border-top:none;border-left:none' x:str><%=dtItem.Rows[i][16] %></td>
  <td class=xl69 style='border-top:none;border-left:none' x:str><%=dtItem.Rows[i][17] %></td>
  <td class=xl69 style='border-top:none;border-left:none' x:str><%=dtItem.Rows[i][19] %></td>
 </tr>
 <% 
        }    
    }            
 %>
   <tr class=xl34 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl42 style='height:20.1pt;border-top:none'>Sub total</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none' x:str><%=v_ac_cd %></td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><%= v_trans_amt%></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><%= v_books_amt%></td>
  <td class=xl57 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl57 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl62 width=158 style='border-top:none;border-left:none;width:119pt'>&nbsp;</td>
  <td class=xl64 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl64 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl64 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none' x:str></td>
 </tr>

 <tr class=xl32 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl47 style='height:20.1pt;border-top:none'>Grand Total</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:num><%= v_tot_trans_amt%></td>
  <td class=xl51 style='border-top:none;border-left:none' x:num><%= v_tot_trans_amt%></td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl63 width=158 style='border-top:none;border-left:none;width:119pt'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl63 width=142 style='border-top:none;border-left:none;width:107pt'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl65 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl48 width=119 style='border-top:none;border-left:none;width:89pt'>&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none' x:str></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=174 style='width:131pt'></td>
  <td width=128 style='width:96pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=194 style='width:146pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=158 style='width:119pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=142 style='width:107pt'></td>
  <td width=195 style='width:146pt'></td>
  <td width=202 style='width:152pt'></td>
  <td width=119 style='width:89pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>