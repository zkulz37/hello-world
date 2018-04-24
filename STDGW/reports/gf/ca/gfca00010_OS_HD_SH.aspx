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
	string SQL = "", ls_tac_hgtrh_pk = "", ls_tac_crca_pk = "", lcompany_pk = "";	
    	ls_tac_hgtrh_pk = Request["tac_hgtrh_pk"];
    	lcompany_pk = Request["company_pk"];
    	ls_tac_crca_pk = Request["tac_crca_pk"];
	
	SQL = "select a.code_nm from tac_commcode_detail a, tac_commcode_master b where a.del_if = 0 and b.del_if = 0 and a.tac_commcode_master_pk = b.pk and b.id = 'EACBK016' and a.code = 'AROS' ";	
	DataTable dtLength = new DataTable();
	dtLength = ESysLib.TableReadOpen(SQL);
	SQL
	= "select substr(a.tr_date, 4, 1) yyyy, substr(a.tr_date, 5, 2) mm, substr(a.tr_date, 7, 2) dd,  " + 
        "				 c.partner_name, nvl(c.addr1, '') || nvl(c.addr2, ' ') || nvl(c.addr3, ' ') address, " +
        "				 (        select c.item_lnm " +
        "          from tac_crcaditem b, tac_abitem c " +
        "         where b.del_if       = 0 " +
        "           and c.del_if       = 0 " +
        "           and b.tac_crca_pk  = '" + ls_tac_crca_pk + "' " +
        "           and b.tac_abitem_pk = c.pk " +
        "	    and c.item_nm = 'PAYMENT METHOD' ) pay_method, " +
        "	    c.tax_code, decode(a.vat_rate, '01', 'None', '00', 'None', a.vat_rate) vat_rate,  " +
        "	    a.tot_net_tr_amt, a.tot_vat_tr_amt, nvl(a.tot_net_tr_amt, 0) + nvl(a.tot_vat_tr_amt, 0) tot_inc_vattax, a.invoice_no, " +
        "		(        select c.item_lnm " +
        "          from tac_crcaditem b, tac_abitem c " +
        "         where b.del_if       = 0 " +
        "           and c.del_if       = 0 " +
        "           and b.tac_crca_pk  = '" + ls_tac_crca_pk + "' " +
        "           and b.tac_abitem_pk = c.pk " +
        "	    and c.item_nm = 'CONTRACT NOAR' ) contract_no, length(c.tax_code) length_taxcd, to_char(to_date(a.tr_date, 'YYYYMMDD'), 'DD/MM/YYYY') trans_dt, a.tr_ccy " +
        "from tac_crca a, comm.tco_buspartner c " +
        "where a.del_if = 0 " +
        "and c.del_if(+) = 0 " +
        "and a.tco_buspartner_pk = c.pk(+) " +
        "and a.pk = '" + ls_tac_crca_pk + "' " ;

    DataTable dtMst = new DataTable();
    dtMst = ESysLib.TableReadOpen(SQL); 

	string ls_partner = "" ;
	string[] l_tax_num = new string[15];
	string ls_taxcd = "" ;
	int j, k = 0;
	String ls_tax_code = "" ;
        string ls_contract_no = "" ;
	ls_contract_no = "Tờ khai " + dtMst.Rows[0][12].ToString() + " Ngày " + dtMst.Rows[0][14].ToString();
	if(dtMst.Rows[0][3].ToString() != "")
	{
	    ls_partner = "Bán cho " + dtMst.Rows[0][3].ToString() ;	
	}
	else
	{
	    ls_partner = "Bán cho " ;	
	}
	if(dtMst.Rows[0][6].ToString() != "")
	{
		ls_taxcd = dtMst.Rows[0][6].ToString() ;
		ls_tax_code = ls_taxcd ;
	}
	else 
	{		
	       for(j = 0; j < 10; j++)
		{
		    l_tax_num[j] = "";	
		}	
	}
	if(ls_taxcd != "")
	{   	
	   k = ls_tax_code.Length ;
	   		   
	   //for(j = 0; j < k; j++); 	
	   //{
		l_tax_num[0] = ls_tax_code.Substring(0, 1);
		l_tax_num[1] = ls_tax_code.Substring(1, 1);
		l_tax_num[2] = ls_tax_code.Substring(2, 1);
		l_tax_num[3] = ls_tax_code.Substring(3, 1);
		l_tax_num[4] = ls_tax_code.Substring(4, 1);
		l_tax_num[5] = ls_tax_code.Substring(5, 1);
		l_tax_num[6] = ls_tax_code.Substring(6, 1);
		l_tax_num[7] = ls_tax_code.Substring(7, 1);
		l_tax_num[8] = ls_tax_code.Substring(8, 1);
		l_tax_num[9] = ls_tax_code.Substring(9, 1);
	   // }
           if(k < 10)
	   {	
	       for(j = k - 1; j < 10; j++)
		{
		    l_tax_num[j] = "";	
		}	
	    }			 	 
	}
	SQL
	= "select i.item_name, i.uom, round(sum(d.qty), 3) qty, to_char(round(d.u_price, 5), '999,999.99999') uprice, to_char(round(sum(d.net_tr_amt), 2), '999,999.99') net_tr_amt " + 
        "from tac_crcad d, comm.tco_item i " +
        "where d.del_if = 0 " +
        "and i.del_if(+) = 0 " +
        "and d.tco_item_pk = i.pk(+) " +
        "and d.tac_crca_pk = '" + ls_tac_crca_pk + "' " +
        "group by i.item_name, i.uom, d.u_price " ;
    	DataTable dtDetail = new DataTable();
    	dtDetail = ESysLib.TableReadOpen(SQL);

	string ls_uprice = "" ;
	string ls_tr_amt = "" ;
	string ls_ccy = dtMst.Rows[0][15].ToString();
	if(dtLength.Rows.Count > 0)

	    k = int.Parse(dtLength.Rows[0][0].ToString());
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfca00010_OS_HD_SH_files/filelist.xml">
<link rel=Edit-Time-Data href="gfca00010_OS_HD_SH_files/editdata.mso">
<link rel=OLE-Object-Data href="gfca00010_OS_HD_SH_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>MS LOAN</o:Author>
  <o:LastAuthor>GENU</o:LastAuthor>
  <o:LastPrinted>2009-07-28T04:17:52Z</o:LastPrinted>
  <o:Created>2009-02-28T07:53:24Z</o:Created>
  <o:LastSaved>2009-07-29T09:42:15Z</o:LastSaved>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .31in .36in .25in;
	mso-header-margin:.2in;
	mso-footer-margin:.19in;}
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
	font-family:VNI-Times;
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
	font-family:VNI-Times;
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
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:normal;}
.xl32
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:justify;}
.xl34
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl36
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;}
.xl39
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:justify;}
.xl42
	{mso-style-parent:style0;
	font-size:9.5pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$USD\]\\ \#\,\#\#0\.00000";
	text-align:right;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$USD\]\\ \#\,\#\#0\.00_\)\;\\\(\[$USD\]\\ \#\,\#\#0\.00\\\)";
	text-align:center;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl46
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl47
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;}
.xl49
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl53
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$USD\]\\ \#\,\#\#0\.00_\)\;\\\(\[$USD\]\\ \#\,\#\#0\.00\\\)";
	text-align:center;
	vertical-align:middle;}
.xl54
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$USD\]\\ \#\,\#\#0\.00_\)\;\\\(\[$USD\]\\ \#\,\#\#0\.00\\\)";
	text-align:center;}
.xl55
	{mso-style-parent:style0;
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
    <x:Name>HD.OS</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>180</x:VerticalResolution>
     </x:Print>
     <x:ShowPageBreakZoom/>
     <x:PageBreakZoom>100</x:PageBreakZoom>
     <x:Selected/>
     <x:TopRowVisible>6</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>23</x:ActiveRow>
       <x:ActiveCol>8</x:ActiveCol>
       <x:RangeSelection>$I$24:$L$24</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>11310</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Area</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=HD.OS!$A$1:$W$33</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=718 style='border-collapse:
 collapse;table-layout:fixed;width:543pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl24 width=64 span=2 style='width:48pt'>
 <col class=xl24 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl24 width=25 span=2 style='mso-width-source:userset;mso-width-alt:
 914;width:19pt'>
 <col class=xl24 width=6 style='mso-width-source:userset;mso-width-alt:219;
 width:5pt'>
 <col class=xl24 width=25 span=3 style='mso-width-source:userset;mso-width-alt:
 914;width:19pt'>
 <col class=xl24 width=21 style='mso-width-source:userset;mso-width-alt:768;
 width:16pt'>
 <col class=xl24 width=25 span=3 style='mso-width-source:userset;mso-width-alt:
 914;width:19pt'>
 <col class=xl24 width=7 style='mso-width-source:userset;mso-width-alt:256;
 width:5pt'>
 <col class=xl24 width=25 style='mso-width-source:userset;mso-width-alt:914;
 width:19pt'>
 <col class=xl24 width=7 style='mso-width-source:userset;mso-width-alt:256;
 width:5pt'>
 <col class=xl24 width=25 span=2 style='mso-width-source:userset;mso-width-alt:
 914;width:19pt'>
 <col class=xl24 width=27 style='mso-width-source:userset;mso-width-alt:987;
 width:20pt'>
 <col class=xl24 width=10 style='mso-width-source:userset;mso-width-alt:365;
 width:8pt'>
 <col class=xl24 width=22 style='mso-width-source:userset;mso-width-alt:804;
 width:17pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 width=64 style='height:12.75pt;width:48pt'><a
  name="Print_Area"></a></td>
  <td class=xl24 width=73 style='width:55pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=78 style='width:59pt'></td>
  <td class=xl24 width=25 style='width:19pt'></td>
  <td class=xl24 width=25 style='width:19pt'></td>
  <td class=xl24 width=6 style='width:5pt'></td>
  <td class=xl24 width=25 style='width:19pt'></td>
  <td class=xl24 width=25 style='width:19pt'></td>
  <td class=xl24 width=25 style='width:19pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=25 style='width:19pt'></td>
  <td class=xl24 width=25 style='width:19pt'></td>
  <td class=xl24 width=25 style='width:19pt'></td>
  <td class=xl24 width=7 style='width:5pt'></td>
  <td class=xl24 width=25 style='width:19pt'></td>
  <td class=xl24 width=7 style='width:5pt'></td>
  <td class=xl24 width=25 style='width:19pt'></td>
  <td class=xl24 width=25 style='width:19pt'></td>
  <td class=xl24 width=27 style='width:20pt'></td>
  <td class=xl24 width=10 style='width:8pt'></td>
  <td class=xl24 width=22 style='width:17pt'></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 colspan=23 class=xl24 style='height:26.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl25 x:num><%=dtMst.Rows[0][2]%></td>
  <td class=xl30 x:num><%=dtMst.Rows[0][1]%></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl49></td>
  <td colspan=2 class=xl30 x:num><%=dtMst.Rows[0][0]%></td>
  <td colspan=11 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=23 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=23 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=23 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=23 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=23 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=9 style='mso-height-source:userset;height:6.75pt'>
  <td height=9 colspan=3 class=xl24 style='height:6.75pt;mso-ignore:colspan'></td>
  <td colspan=7 rowspan=2 class=xl50></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl24 style='height:16.5pt'></td>
  <td colspan=22 class=xl25 x:str><span
  style='mso-spacerun:yes'>                 </span><%=dtMst.Rows[0][3]%><span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl24 style='height:20.25pt'></td>
  <td colspan=22 class=xl39
  x:str><span
  style='mso-spacerun:yes'>   </span><%=dtMst.Rows[0][4]%><span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=2 class=xl24 style='height:17.25pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl45><%=ls_contract_no%></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 rowspan=2 class=xl51><span style='mso-spacerun:yes'>     
  </span><%=dtMst.Rows[0][5].ToString()%></td>
  <td class=xl24></td>
  <td colspan=18 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=19 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 colspan=23 class=xl24 style='height:9.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=23 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=23 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
<%
   	
   for(j = 0; j < dtDetail.Rows.Count; j++)
   {
	if(ls_ccy == "USD")
		ls_uprice = dtMst.Rows[0][15].ToString() + dtDetail.Rows[j][3].ToString();
	else
		ls_uprice = dtDetail.Rows[j][3].ToString();
	ls_tr_amt = dtMst.Rows[0][15].ToString() + dtDetail.Rows[j][4].ToString();
%>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.6pt'>
  <td height=24 class=xl34 align=right style='height:18.6pt' x:num></td>
  <td colspan=4 class=xl39><%=dtDetail.Rows[j][0]%><span style='mso-spacerun:yes'> 
  </span>Size 0</td>
  <td colspan=3 class=xl44 x:str><%=dtDetail.Rows[j][1]%><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl46 x:num><%=dtDetail.Rows[j][2]%><span
  style='mso-spacerun:yes'>             </span></td>
  <td colspan=4 class=xl42 x:str><%=ls_uprice%></td>
  <td colspan=7 class=xl43 x:str><%=ls_tr_amt%></td>
 </tr>
<% 
   }
   for(j = dtDetail.Rows.Count; j < k; j++)
   {
%>	 	
	<tr class=xl24 height=24 style='mso-height-source:userset;height:18.6pt'>
  	<td height=24 class=xl34 align=right style='height:18.6pt' x:num></td>
  	<td colspan=4 class=xl39><span style='mso-spacerun:yes'> 
  	</span></td>
  	<td colspan=3 class=xl44 x:str><span
  	style='mso-spacerun:yes'> </span></td>
  	<td colspan=4 class=xl46 x:num><span
  	style='mso-spacerun:yes'>             </span></td>
  	<td colspan=4 class=xl42 x:str></td>
  	<td colspan=7 class=xl43 x:str></td>
 </tr>
<%
   }	
%>
 <tr class=xl24 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 colspan=2 class=xl24 style='height:16.5pt;mso-ignore:colspan'></td>
  <td rowspan=2 class=xl26></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl40></td>
  <td class=xl32></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl38 x:num><span
  style='mso-spacerun:yes'>                 </span><%=dtMst.Rows[0][8]%></td>
  <td class=xl35></td>
 </tr>
 <tr class=xl24 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 colspan=2 class=xl24 style='height:16.5pt;mso-ignore:colspan'></td>
  <td class=xl25 x:num>0</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl44></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl28 x:num><%=dtMst.Rows[0][9]%></td>
 </tr>
 <tr class=xl24 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 colspan=7 class=xl24 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl41></td>
  <td class=xl33></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl38 x:num><span
  style='mso-spacerun:yes'>                 </span><%=dtMst.Rows[0][10]%></td>
  <td class=xl29></td>
 </tr>
 <tr class=xl24 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=20 rowspan=2 class=xl52 width=517 style='width:392pt'><%=CommondLib.Num2VNText(dtMst.Rows[0][10].ToString(), ls_ccy )%>./.</td>
 </tr>
 <tr class=xl24 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 colspan=2 class=xl24 style='height:22.5pt;mso-ignore:colspan'></td>
  <td class=xl31></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=23 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=23 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=23 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=23 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=23 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=23 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=23 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=23 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=23 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=23 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=23 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=23 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=23 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=23 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=23 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=23 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=23 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=23 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=23 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=23 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=23 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 colspan=23 class=xl24 style='height:13.5pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=6 style='width:5pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=7 style='width:5pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=7 style='width:5pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=10 style='width:8pt'></td>
  <td width=22 style='width:17pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
