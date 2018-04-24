<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_seq = Request["seq"];
   // string l_book_ccy = Request["ccy"];
    
    string So = "";
    string Payer = "";
    string Account_noU = "";
    string BankU = "";
    string Ngay = "";
    string Beneficiary = "";
    string Account_noD = "";
    string BankD = "";
    string Branch = "";

    string TKN = "";
    string TKC = "";
    string DRCR_Type = "";
    string Amt = "";
    string ccy = "";
    string Inwords = "";
    string Inwords_Eng = "";
    string Remark = "";
    string Remark2 = "";
    //-----------------------------------------------------------------------------------------------------

        /*
        for (int i = 0; i < dt_Acc.Rows.Count; i++)
        {
            DRCR_Type = dt_Acc.Rows[i][7].ToString();
            
            if (DRCR_Type == "D")
            {
                TKN = dt_Acc.Rows[i][1].ToString();
            }
            else if (DRCR_Type == "C")
            {
                TKC = dt_Acc.Rows[i][1].ToString();
            }
            
        }*/
      
//-----------------------------------------------------------------------------------------------------
       
        

       string SQL6 = "select d.tac_hgtrh_pk, COUNT (d.tac_hgtrh_pk),h.TR_TABLE_PK " +
            " from tac_hgtrh h, tac_hgtrd d, TAC_BPRVPV f   " +
            " where h.del_if =0 " +
            " and d.del_if =0 " +
            " and h.pk = d.tac_hgtrh_pk " +
            " and h.tr_status<>3 " +
            " and h.TR_TABLENM = 'TAC_BPRVPV'  " +
            " and h.TR_TABLE_PK = f.pk " +
            " and h.pk IN (" + p_seq + ")  " +
            " GROUP BY d.tac_hgtrh_pk,h.TR_TABLE_PK  " +
            " order by d.tac_hgtrh_pk ";

        DataTable dt_hgtrh_pk = ESysLib.TableReadOpen(SQL6);
        //Response.Write(dt_hgtrh_pk.Rows.Count.ToString());
        //Response.End();
      
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="aaaaaaa_files/filelist.xml">
<link rel=Edit-Time-Data href="aaaaaaa_files/editdata.mso">
<link rel=OLE-Object-Data href="aaaaaaa_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr Long</o:Author>
  <o:LastAuthor>Mr Long</o:LastAuthor>
  <o:LastPrinted>2010-05-28T03:37:56Z</o:LastPrinted>
  <o:Created>2010-04-06T09:42:11Z</o:Created>
  <o:LastSaved>2010-05-28T03:38:47Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .5in .5in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
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
	font-family:Helv, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"Normal_UNCHP\.USD";}
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
.xl25
	{mso-style-parent:style0;
	font-size:14.0pt;}
.xl26
	{mso-style-parent:style0;
	font-size:14.0pt;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl27
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl29
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl38
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl40
	{mso-style-parent:style22;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl41
	{mso-style-parent:style22;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl42
	{mso-style-parent:style22;
	font-size:14.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl43
	{mso-style-parent:style22;
	font-size:14.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl44
	{mso-style-parent:style22;
	font-size:14.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl45
	{mso-style-parent:style22;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl46
	{mso-style-parent:style22;
	font-size:14.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl50
	{mso-style-parent:style22;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style22;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;}
.xl52
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl57
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;}
.xl59
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl62
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>70</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Zoom>85</x:Zoom>
     <x:Selected/>
     <x:DoNotDisplayGridlines/>
     <x:TopRowVisible>15</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>44</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    
    
    
        <x:PageBreaks>
     <x:RowBreaks>
       <%
int i_row_break =0;

for (int m=0; m < dt_hgtrh_pk.Rows.Count ;m++)
{
	i_row_break+=56; 
%>
      <x:RowBreak>
       <x:Row><%= i_row_break%></x:Row>
      </x:RowBreak>
<%
}
%>
      
     </x:RowBreaks>
    </x:PageBreaks>
    
    
    
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>12615</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=999 style='border-collapse:
 collapse;table-layout:fixed;width:751pt'>
 <col width=106 style='mso-width-source:userset;mso-width-alt:3876;width:80pt'>
 <col width=195 style='mso-width-source:userset;mso-width-alt:7131;width:146pt'>
 <col width=26 style='mso-width-source:userset;mso-width-alt:950;width:20pt'>
 <col width=142 style='mso-width-source:userset;mso-width-alt:5193;width:107pt'>
 <col width=84 style='mso-width-source:userset;mso-width-alt:3072;width:63pt'>
 <col width=78 style='mso-width-source:userset;mso-width-alt:2852;width:59pt'>
 <col width=32 style='mso-width-source:userset;mso-width-alt:1170;width:24pt'>
 <col width=117 style='mso-width-source:userset;mso-width-alt:4278;width:88pt'>
 <col width=108 style='mso-width-source:userset;mso-width-alt:3949;width:81pt'>
 <col width=47 style='mso-width-source:userset;mso-width-alt:1718;width:35pt'>
 <col width=64 style='width:48pt'>
    <%
        String p_xls_ccy_format = "";
        String p_xls_ccy_format_usd = "";
        
    
        for (int w = 0; w < dt_hgtrh_pk.Rows.Count; w++)
   {


       string SQL = "SELECT a.*, c.partner_id, c.partner_name, b.branch, d.item_deposit,  " +
        "       d.item_nm_deposit, d.trandate, d.voucherno, d.company,d.REMARK2, d.REMARK  " +
        "  FROM (SELECT a.item, a.item_nm, a.table_nm table_nm,  " +
        "               a.item_table_pk table_pk " +
        "          FROM tac_bprvpvditem a,  " +
        "               tac_abacctitem b,  " +
        "               tac_abitem c,  " +
        "               tac_bprvpvd d,  " +
        "               tac_bprvpv e,  " +
        "               tco_company f, " +
        "               TAC_HGTRH g  " +
        "         WHERE a.tac_abacctitem_pk(+) = b.pk  " +
        "           AND b.tac_abitem_pk = c.pk  " +
        "           AND b.tac_abitem_alias = 'BENEFICIARY BANK'  " +
        "           AND a.del_if(+) = 0  " +
        "           AND b.del_if = 0  " +
        "           AND c.del_if = 0  " +
        "           AND d.del_if = 0  " +
        "           AND e.del_if = 0  " +
        "           AND f.del_if = 0  " +
        "           and g.del_if(+) = 0 " +
        "           AND a.tac_bprvpvd_pk = d.pk " +
        "           AND d.tac_bprvpv_pk = e.pk " +
        "           AND e.tco_company_pk = f.pk " +
        "           and e.pk = g.TR_TABLE_PK(+) " +
        "          and g.TR_TABLENM(+) = 'TAC_BPRVPV' " +
        "           AND g.pk =  " + dt_hgtrh_pk.Rows[w][0].ToString() + " ) a,  " +
        "       tac_bfbeneficiary b,  " +
        "       tco_buspartner c,  " +
        "       (SELECT a.item item_deposit, a.item_nm AS item_nm_deposit,  " +
        "               TO_CHAR (TO_DATE (e.tr_date, 'YYYYMMDD'),  " +
        "                        'DD/MM/YYYY'  " +
        "                       ) AS trandate,  " +
        "               e.voucherno AS voucherno, f.PARTNER_LNAME AS company, e.REMARK2 as   REMARK2, e.REMARK as remark  " +
        "          FROM tac_bprvpvditem a,  " +
        "               tac_abacctitem b,  " +
        "               tac_abitem c,  " +
        "               tac_bprvpvd d,  " +
        "               tac_bprvpv e,  " +
        "               tco_company f, " +
        "               TAC_HGTRH g   " +
        "         WHERE a.tac_abacctitem_pk(+) = b.pk  " +
        "           AND b.tac_abitem_pk = c.pk  " +
        "        " +
        "           AND b.tac_abitem_alias = 'DEPOSIT ACCOUNT NO'  " +
        "           AND a.del_if(+) = 0  " +
        "           AND b.del_if = 0  " +
        "           AND c.del_if = 0  " +
        "           AND d.del_if = 0  " +
        "           AND e.del_if = 0  " +
        "           AND f.del_if = 0  " +
        "           and g.del_if(+) = 0 " +
        "           AND a.tac_bprvpvd_pk = d.pk  " +
        "           AND d.tac_bprvpv_pk = e.pk  " +
        "           AND e.tco_company_pk = f.pk  " +
        "           and e.pk = g.TR_TABLE_PK(+) " +
        "           and g.TR_TABLENM = 'TAC_BPRVPV' " +
        "           and g.pk = " + dt_hgtrh_pk.Rows[w][0].ToString() +

        "           ) d  " +
        " WHERE b.del_if = 0  " +
        "   AND c.del_if = 0  " +
        "   AND a.table_pk = b.pk  " +
        "   AND b.tco_dccust_pk = c.pk  " +
        "   ";
       //Response.Write(SQL);
       //Response.End();
       DataTable dt = ESysLib.TableReadOpen(SQL);
       if (dt.Rows.Count > 0)
       {
           So = dt.Rows[0][10].ToString();
           Ngay = dt.Rows[0][9].ToString();
           Payer = dt.Rows[0][11].ToString();
           Account_noU = dt.Rows[0][7].ToString();
           BankU = dt.Rows[0][8].ToString();
           Beneficiary = dt.Rows[0][5].ToString();
           Account_noD = dt.Rows[0][0].ToString();
           BankD = dt.Rows[0][1].ToString();
           Branch = dt.Rows[0][6].ToString();
           Remark = dt.Rows[0][12].ToString();
           Remark2 = dt.Rows[0][13].ToString();
       }
       

/*
       string SQL  = "select d.tac_hgtrh_pk seq  " +
        "    , (select i.item from tac_hgtrditem i, tac_abacctitem t where i.tac_hgtrd_pk = d.pk " +
        "        and i.del_if = 0 and i.tac_abacctitem_pk = t.pk and t.del_if = 0 and t.tac_abitem_alias = 'BENEFICIARY BANK') item " +
        "    , (select i.item_nm from tac_hgtrditem i, tac_abacctitem t where i.tac_hgtrd_pk = d.pk " +
        "        and i.del_if = 0 and i.tac_abacctitem_pk = t.pk and t.del_if = 0 and t.tac_abitem_alias = 'BENEFICIARY BANK') item_nm         " +
        "    , (select i.item from tac_hgtrditem i, tac_abacctitem t where i.tac_hgtrd_pk = d.pk " +
        "        and i.del_if = 0 and i.tac_abacctitem_pk = t.pk and t.del_if = 0 and t.tac_abitem_alias = 'DEPOSIT ACCOUNT NO') item_1 " +
        "    , (select i.item_nm from tac_hgtrditem i, tac_abacctitem t where i.tac_hgtrd_pk = d.pk " +
        "        and i.del_if = 0 and i.tac_abacctitem_pk = t.pk and t.del_if = 0 and t.tac_abitem_alias = 'DEPOSIT ACCOUNT NO') item_nm_1 " +
        "    , (select h.voucherno from tac_hgtrh h where h.pk = d.tac_hgtrh_pk) voucherno " +
        "     , (select to_char(h.tr_date, 'dd/mm/yyyy') from tac_hgtrh h where h.pk = d.tac_hgtrh_pk) tr_date " +
        "    , (select b.branch from tac_hgtrditem i, tac_abacctitem t, tac_bfbeneficiary b where i.tac_hgtrd_pk = d.pk " +
        "        and i.del_if = 0 and i.tac_abacctitem_pk = t.pk and t.del_if = 0 and t.tac_abitem_alias = 'BENEFICIARY BANK' and i.ITEM_TABLE_PK = b.pk  " +
        "        ) branch          " +
        "    , (select c.partner_id from tac_hgtrditem i, tac_abacctitem t, tac_bfbeneficiary b, tco_buspartner c where i.tac_hgtrd_pk = d.pk " +
        "        and i.del_if = 0 and i.tac_abacctitem_pk = t.pk and t.del_if = 0 and t.tac_abitem_alias = 'BENEFICIARY BANK' and i.ITEM_TABLE_PK = b.pk " +
        "        and b.TCO_DCCUST_PK = c.pk  " +
        "        ) bank_id          " +
        "    , (select c.PARTNER_NAME from tac_hgtrditem i, tac_abacctitem t, tac_bfbeneficiary b, tco_buspartner c where i.tac_hgtrd_pk = d.pk " +
        "        and i.del_if = 0 and i.tac_abacctitem_pk = t.pk and t.del_if = 0 and t.tac_abitem_alias = 'BENEFICIARY BANK' and i.ITEM_TABLE_PK = b.pk " +
        "        and b.TCO_DCCUST_PK = c.pk  " +
        "        ) bank_nm " +
        "        , (select c.PARTNER_NAME from tac_hgtrh h , tco_company c where h.pk = d.tac_hgtrh_pk and h.tco_company_pk = c.pk) PARTNER_NAME " +
        "from tac_hgtrd d " +
        "where d.tac_hgtrh_pk = " + dt_hgtrh_pk.Rows[w][0].ToString() +
        "and d.del_if = 0 " +
        "and d.drcr_type = 'D' ";

*/

       //Response.Write(SQL);
       //Response.End();
       //DataTable dt = ESysLib.TableReadOpen(SQL);
      
       //if (dt.Rows.Count > 0)
       //{
       //    So = dt.Rows[0][5].ToString();
       //    Ngay = dt.Rows[0][6].ToString();
       //    Payer = dt.Rows[0][10].ToString();
       //    Account_noU = dt.Rows[0][3].ToString();
       //    BankU = dt.Rows[0][4].ToString();
       //    Beneficiary = dt.Rows[0][9].ToString();
       //    Account_noD = dt.Rows[0][1].ToString();
       //    BankD = dt.Rows[0][2].ToString();
       //    Branch = dt.Rows[0][7].ToString();
           
       //}

      
       string SQL1 = "SELECT t.pk, ac_get_accd (tac_abacctcode_pk, h.tco_company_pk) accd, " +
        "       ac_get_acnm (tac_abacctcode_pk, h.tco_company_pk, 'ENG') acnm, t.ccy, " +
        "       t.tr_rate, t.trans_amt, t.books_amt, t.drcr_type, t.type_ref, " +
        "       hh.trans_amt, hh.accd " +
        "  FROM tac_bprvpvd t, " +
        "       tac_bprvpv h, " +
        "       (SELECT t.pk, ac_get_accd (tac_abacctcode_pk, h.tco_company_pk) accd, " +
        "               ac_get_acnm (tac_abacctcode_pk, h.tco_company_pk, " +
        "                              'ENG') acnm, ccy, tr_rate, trans_amt, books_amt, " +
        "               t.drcr_type, t.type_ref " +
        "          FROM tac_bprvpvd t, tac_bprvpv h " +
        "         WHERE t.del_if = 0 " +
        "           AND h.del_if = 0 " +
        "           AND t.tac_bprvpv_pk = h.pk " +
        "           AND t.tac_bprvpv_pk = " +
        "                  (SELECT tr_table_pk " +
        "                     FROM tac_hgtrh " +
        "                    WHERE del_if = 0 AND tr_tablenm = 'TAC_BPRVPV' " +
        "                          AND pk = " + dt_hgtrh_pk.Rows[w][0].ToString() + ") " +
        "           AND t.drcr_type = 'C') hh " +
        " WHERE t.del_if = 0 " +
        "   AND h.del_if = 0 " +
        "   AND t.tac_bprvpv_pk = h.pk " +
        "   AND hh.type_ref = t.type_ref " +
        "   AND t.tac_bprvpv_pk = " +
        "               (SELECT tr_table_pk " +
        "                  FROM tac_hgtrh " +
        "                 WHERE del_if = 0 AND tr_tablenm = 'TAC_BPRVPV' AND pk = " + dt_hgtrh_pk.Rows[w][0].ToString() + ") " +
        "   AND t.drcr_type = 'D' ";
      // Response.Write(SQL1);
      // Response.End();
       DataTable dt_Acc = ESysLib.TableReadOpen(SQL1);
       if (dt_Acc.Rows.Count > 0)
       {
           Amt = dt_Acc.Rows[0][9].ToString();
           ccy = dt_Acc.Rows[0][3].ToString();
           Inwords = CommondLib.Num2VNText(Amt.ToString(), ccy);
           Inwords_Eng = CommondLib.Num2EngText(Amt.ToString(), ccy);




           if (ccy == "VND")
           {
               p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
               p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
           }
           else
           {
               p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
               p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
           }
       }
        
        //for (int d = 0; d < dt_Acc.Rows.Count; d++)
        //{
        //    DRCR_Type = dt_Acc.Rows[d][7].ToString();
            
        //    if (DRCR_Type == "D")
        //    {
        //        TKN = dt_Acc.Rows[d][1].ToString();
        //    }
        //    else if (DRCR_Type == "C")
        //    {
        //        TKC = dt_Acc.Rows[i][1].ToString();
        //    }
            
        //}

       string s = "", s1="", s2="";

       for (int p = 0; p < dt_Acc.Rows.Count; p++)
       {
           if (p == dt_Acc.Rows.Count - 1)
           {
               s += dt_Acc.Rows[p][1].ToString();
           }
           else
           {
               s += dt_Acc.Rows[p][1].ToString() + ", ";
           }    
           
           
           //s2 += dt_Acc.Rows[p][5].ToString();
          // Inwords = CommondLib.Num2VNText(s2.ToString(), ccy);
       }     

      // for (int p = 0; p < dt_Acc.Rows.Count; p++)
       {
    %>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=6 height=38 class=xl56 width=631 style='height:28.5pt;width:475pt'>ỦY
  NHIỆM CHI</td>
  <td class=xl25 width=32 style='width:24pt'>Số:</td>
  <td class=xl26 colspan=2 width=225 style='mso-ignore:colspan;width:169pt'><%=So%></td>
  <td width=47 style='width:35pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.95pt'>
  <td height=25 class=xl27 colspan=2 style='height:18.95pt;mso-ignore:colspan'>Chuyển
  khoản, chuyển tiền, thư, điện</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl27>Lập ngày:</td>
  <td colspan=2 class=xl57 style='border-right:.5pt solid black'><%=Ngay%></td>
  <td colspan=2 class=xl58 style='border-right:.5pt solid black;border-left:
  none'>Tài khoản Nợ</td>
  <td></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.95pt'>
  <td height=25 class=xl27 colspan=2 style='height:18.95pt;mso-ignore:colspan'>Tên
  đơn vị trả tiền (Payer):</td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan'><%=Payer%></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black'>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.95pt'>
  <td height=25 class=xl27 colspan=2 style='height:18.95pt;mso-ignore:colspan'>Số
  tài khoản (Account No):</td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'><%=Account_noU%></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl27 colspan=2 style='height:15.75pt;mso-ignore:colspan'
  x:str="Tại Ngân hàng (At bank): ">Tại Ngân hàng (At bank):<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'><%=BankU%></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black'>Tài khoản Có</td>
  <td></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl31 style='height:16.5pt'>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:
  none'><%=s1%></td>
  <td></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.95pt'>
  <td height=25 class=xl27 colspan=2 style='height:18.95pt;mso-ignore:colspan'
  x:str="Tên đơn vị nhận tiền (Beneficiary): ">Tên đơn vị nhận tiền
  (Beneficiary):<span style='mso-spacerun:yes'> </span></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan'><%=Beneficiary%></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.95pt'>
  <td height=25 class=xl27 colspan=2 style='height:18.95pt;mso-ignore:colspan'>Số
  tài khoản (Account No):</td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'><%=Account_noD%></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.95pt'>
  <td height=25 class=xl27 colspan=2 style='height:18.95pt;mso-ignore:colspan'
  x:str="Tại Ngân hàng (At bank): ">Tại Ngân hàng (At bank):<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'><%=BankD%></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black'>Số tiền bằng
  số</td>
  <td></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.95pt'>
  <td height=25 class=xl27 colspan=2 style='height:18.95pt;mso-ignore:colspan'>Chi
  nhánh (Branch):</td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'><%=Branch%></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl31 style='height:18.75pt'>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl34 width=106 style='height:18.75pt;width:80pt'>Bằng
  chữ:<br>
    </td>
  <td colspan=7 class=xl54 style='border-right:.5pt solid black'><%=Inwords%></td>
  <td class=xl35 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=Amt%></td>
  <td class=xl36><%=ccy%></td>
  <td class=xl59 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl34 width=106 style='height:19.5pt;width:80pt'>(Inwords):</td>
  <td colspan=7 class=xl60><%=Inwords_Eng%></td>
  <td class=xl61></td>
  <td class=xl62></td>
  <td class=xl60></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl25 style='height:20.25pt'>Nội dung:</td>
  <td class=xl27 colspan=5 style='mso-ignore:colspan'><%=Remark%></td>
  <td colspan=5 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl25 style='height:18.0pt'></td>
  <td class=xl27 colspan=4 style='mso-ignore:colspan'><%=Remark2%></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 colspan=10 class=xl37 style='height:6.0pt;mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=2 height=22 class=xl47 style='height:16.5pt'>Đơn vị trả tiền</td>
  <td class=xl38>&nbsp;</td>
  <td colspan=4 class=xl48 style='border-right:.5pt solid black;border-left:
  none'>Ngân hàng A</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 colspan=2 class=xl28 style='height:16.5pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=4 class=xl50 style='border-right:.5pt solid black'>Ghi sổ ngày:
  ……………</td>
  <td colspan=3 class=xl51 style='border-left:none'>Ghi sổ ngày: ……………</td>
  <td></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl40 style='height:18.75pt'>Kế toán</td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black'>Chủ tài khoản</td>
  <td class=xl40>Kế toán</td>
  <td colspan=2 class=xl40>TP Kế toán</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl40>Kế toán</td>
  <td colspan=2 class=xl40>TP Kế toán</td>
  <td></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl42 style='height:18.75pt'>(Accountant)</td>
  <td colspan=2 class=xl43 style='border-right:.5pt solid black'>(Account
  owner)</td>
  <td class=xl43>(Teller)</td>
  <td colspan=2 class=xl43>(Teller manager)</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl43>(Teller)</td>
  <td colspan=2 class=xl43>(Teller manager)</td>
  <td></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=10 class=xl25 style='height:18.0pt;mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=255 style='height:191.25pt;mso-xlrowspan:15'>
  <td height=255 colspan=11 style='height:191.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=36 style='height:27.0pt'>
  <td colspan=6 height=36 class=xl56 style='height:27.0pt'>ỦY NHIỆM CHI</td>
  <td class=xl25>Số:</td>
  <td class=xl26 colspan=2 style='mso-ignore:colspan'><%=So%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl27 colspan=2 style='height:18.75pt;mso-ignore:colspan'>Chuyển
  khoản, chuyển tiền, thư, điện</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl27>Lập ngày:</td>
  <td colspan=2 class=xl57 style='border-right:.5pt solid black'><%=Ngay%></td>
  <td colspan=2 class=xl58 style='border-right:.5pt solid black;border-left:
  none'>Tài khoản Nợ</td>
  <td></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl27 colspan=2 style='height:18.75pt;mso-ignore:colspan'>Tên
  đơn vị trả tiền (Payer):</td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan'><%=Payer%></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black'>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl27 colspan=2 style='height:18.75pt;mso-ignore:colspan'>Số
  tài khoản (Account No):</td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'><%=Account_noU%></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl27 colspan=2 style='height:18.75pt;mso-ignore:colspan'
  x:str="Tại Ngân hàng (At bank): ">Tại Ngân hàng (At bank):<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'><%=BankU%></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black'>Tài khoản Có</td>
  <td></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl31 style='height:18.75pt'>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:
  none'><%=s1%></td>
  <td></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl27 colspan=2 style='height:18.75pt;mso-ignore:colspan'
  x:str="Tên đơn vị nhận tiền (Beneficiary): ">Tên đơn vị nhận tiền
  (Beneficiary):<span style='mso-spacerun:yes'> </span></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan'><%=Beneficiary%></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl27 colspan=2 style='height:18.75pt;mso-ignore:colspan'>Số
  tài khoản (Account No):</td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'><%=Account_noD%></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl27 colspan=2 style='height:18.75pt;mso-ignore:colspan'
  x:str="Tại Ngân hàng (At bank): ">Tại Ngân hàng (At bank):<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'><%=BankD%></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black'>Số tiền bằng
  số</td>
  <td></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl27 colspan=2 style='height:18.75pt;mso-ignore:colspan'>Chi
  nhánh (Branch):</td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'><%=Branch%></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl31 style='height:17.25pt'>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl34 width=106 style='height:19.5pt;width:80pt'>Bằng
  chữ:<br>
    </td>
  <td colspan=7 class=xl54 style='border-right:.5pt solid black'><%=Inwords%></td>
  <td class=xl35 style='border-left:none' x:num=><span
  style='mso-spacerun:yes'> </span><%=Amt%></td>
  <td class=xl36><%=ccy%></td>
  <td></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl34 width=106 style='height:15.75pt;width:80pt'>(Inwords):</td>
  <td colspan=7 class=xl60><%=Inwords_Eng%></td>
  <td class=xl61></td>
  <td class=xl62></td>
  <td></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl25 style='height:21.75pt'>Nội dung:</td>
  <td class=xl27 colspan=5 style='mso-ignore:colspan'><%=Remark%></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl25 style='height:14.25pt'></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan'><%=Remark2%></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=5 style='mso-height-source:userset;height:3.75pt'>
  <td height=5 colspan=10 class=xl37 style='height:3.75pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td colspan=2 height=25 class=xl47 style='height:18.75pt'>Đơn vị trả tiền</td>
  <td class=xl38>&nbsp;</td>
  <td colspan=4 class=xl48 style='border-right:.5pt solid black;border-left:
  none'>Ngân hàng A</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=2 class=xl28 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=4 class=xl50 style='border-right:.5pt solid black'>Ghi sổ ngày:
  ……………</td>
  <td colspan=3 class=xl51 style='border-left:none'>Ghi sổ ngày: ……………</td>
  <td></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl40 style='height:18.75pt'>Kế toán</td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black'>Chủ tài khoản</td>
  <td class=xl40>Kế toán</td>
  <td colspan=2 class=xl40>TP Kế toán</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl40>Kế toán</td>
  <td colspan=2 class=xl40>TP Kế toán</td>
  <td></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl42 style='height:18.75pt'>(Accountant)</td>
  <td colspan=2 class=xl43 style='border-right:.5pt solid black'>(Account
  owner)</td>
  <td class=xl43>(Teller)</td>
  <td colspan=2 class=xl43>(Teller manager)</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl43>(Teller)</td>
  <td colspan=2 class=xl43>(Teller manager)</td>
  <td></td>
 </tr>
 <%}} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=106 style='width:80pt'></td>
  <td width=195 style='width:146pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=142 style='width:107pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
