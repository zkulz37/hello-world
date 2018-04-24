<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("acnt");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string l_seq = ""+ Request["seq_list"];
	string p_table_pk = ""+ Request["pv_pk"];
    string p_company_pk = ""+ Request["company_pk"];
	string p_voucher_type = ""+ Request["voucher_type"];
    string p_cmp_name = "";
	string p_cmp_add = "";	
	string p_cmp_taxcode = ""; 	
    string p_voucher_no =""; 
    string p_ngay =""; 
    string p_thang =""; 
    string p_nam =""; 
    string p_person =""; 
    string p_addr =""; 
    string p_remark =""; 
    string p_remark2 =""; 
    string p_reason ="";
    string p_buspartner_lnm = "";
    string p_enclose = ""; 
	string SQL = "";
    string p_ccy = "";
    string p_amount = "";
    string p_fmt_amount = ""; 
	string p_rate = "";
	string p_amt_vn = "";
	string p_amt_en = "";
	string p_book_ccy = "";
    string p_voucher_code = "";
    String p_voucher_name = "PHIẾU THU";
	string tmp1 ="";
	string tmp2 ="";
	string tmp3 ="";
	int i,j,k;
	string p_hgtrh_pk_list ="";

	SQL = " SELECT partner_lname, addr2, tax_code  FROM tco_company WHERE pk = " + p_company_pk ;
	DataTable dt1 = ESysLib.TableReadOpen(SQL);
	if (dt1.Rows.Count >0)
	{
		p_cmp_name = dt1.Rows[0][0].ToString();
		p_cmp_add = dt1.Rows[0][1].ToString();
		p_cmp_taxcode = dt1.Rows[0][2].ToString();
	} 
	
	SQL = "SELECT CODE FROM TCO_ABCODE A, TCO_ABCODEGRP B WHERE A.TCO_ABCODEGRP_PK = b.pk and b.id ='ACBG0040' and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 and a.def_yn ='Y'";
	DataTable dt0 = ESysLib.TableReadOpen(SQL);
	if (dt0.Rows.Count >0)
    {
		p_book_ccy = dt0.Rows[0][0].ToString();
	}
	
	
	SQL = "select d.tac_hgtrh_pk, COUNT (d.tac_hgtrh_pk),h.TR_TABLE_PK " + 
        " from tac_hgtrh h, tac_hgtrd d  " +
        " where h.del_if =0 " +
        " and d.del_if =0 " +
        " and h.pk = d.tac_hgtrh_pk " +
        " and h.tr_status<>3 " +
        " and h.voucher_type='"+p_voucher_type+"' " +
        " and h.TR_TABLENM = 'TAC_BPRVPV' " +
        " and h.PK IN ("+l_seq+") " +
        " GROUP BY d.tac_hgtrh_pk,h.TR_TABLE_PK  " +
        " order by d.tac_hgtrh_pk " ;
		
	DataTable dt_hgtrh_pk = ESysLib.TableReadOpen(SQL);
    
    SQL = "select   " +
        "    D.CODE, " +
        "    D.CHAR_1,  " +
        "    D.CHAR_2,  " +
        "    D.CHAR_3,  " +
        "    D.CHAR_4,  " +
        "    D.CHAR_5,  " +
        "    D.REMARK " +
        " FROM TAC_COMMCODE_DETAIL D, TAC_COMMCODE_MASTER M " +
        " WHERE D.DEL_IF=0 AND D.TAC_COMMCODE_MASTER_PK = M.PK " +
        " AND M.ID='EACAB055' " +
        " order by D.ORD ";
      dt1 = ESysLib.TableReadOpen(SQL);
        String e1="";
        String e2 = "";
        String e3 = "";
        String e4 = "";
        String e5 = "";
        String e6 = "";
        String v1 = "";
        String v2 = "";
        String v3 = "";
        String v4 = "";
        String v5 = "";
        String v6 = "";
        String g1 = "";
        String g2 = "";
        String g3 = "";
        String g4 = "";
        String g5 = "";
        String g6 = "";
        String n1 = "";
        String n2 = "";
        String n3 = "";
        String n4 = "";
        String n5 = "";
        String n6 = "";
      
      for (k = 0; k < dt1.Rows.Count; k++)
      {
         
           string strTmp = dt1.Rows[k][0].ToString();
           if (strTmp == "ENG")
           {
               e1 = ""+dt1.Rows[k][1].ToString();
               e2 = "" + dt1.Rows[k][2].ToString();
               e3 = "" + dt1.Rows[k][3].ToString();
               e4 = "" + dt1.Rows[k][4].ToString();
               e5 = "" + dt1.Rows[k][5].ToString();
               e6 = "" + dt1.Rows[k][6].ToString();
           }
           
            if (strTmp == "VIE")
            {
                v1 = dt1.Rows[k][1].ToString();
                v2 = dt1.Rows[k][2].ToString();
                v3 = dt1.Rows[k][3].ToString();
                v4 = dt1.Rows[k][4].ToString();
                v5 = dt1.Rows[k][5].ToString();
                v6 = dt1.Rows[k][6].ToString();
            }
            if (strTmp == "SIG")
            {
                g1 = dt1.Rows[k][1].ToString();
                g2 = dt1.Rows[k][2].ToString();
                g3 = dt1.Rows[k][3].ToString();
                g4 = dt1.Rows[k][4].ToString();
                g5 = dt1.Rows[k][5].ToString();
                g6 = dt1.Rows[k][6].ToString();
            }
          
            if (strTmp == "NAM")
            {
                n1 = dt1.Rows[k][1].ToString();
                n2 = dt1.Rows[k][2].ToString();
                n3 = dt1.Rows[k][3].ToString();
                n4 = dt1.Rows[k][4].ToString();
                n5 = dt1.Rows[k][5].ToString();
                n6 = dt1.Rows[k][6].ToString();
            }
      }

%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="PT_files/filelist.xml">
<link rel=Edit-Time-Data href="PT_files/editdata.mso">
<link rel=OLE-Object-Data href="PT_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>GENU</o:LastAuthor>
  <o:LastPrinted>2008-07-02T01:53:36Z</o:LastPrinted>
  <o:Created>2008-07-02T01:53:26Z</o:Created>
  <o:LastSaved>2008-10-04T08:38:17Z</o:LastSaved>
  <o:Company>vinagenuwin</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .25in .25in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;}
.font5
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font6
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
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
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
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
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00\;\[Red\]\#\,\#\#0\.00";
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\0022$\0022\#\,\#\#0\.00";
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:center;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:00000;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Phieu Thu</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>92</x:Scale>
      <x:HorizontalResolution>1200</x:HorizontalResolution>
      <x:VerticalResolution>1200</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>17</x:ActiveRow>
       <x:ActiveCol>12</x:ActiveCol>
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
int i_tmp =0;
for (i=0;i<dt_hgtrh_pk.Rows.Count;i++)
{
	i_tmp = int.Parse(dt_hgtrh_pk.Rows[i][1].ToString());
	if(i_tmp <6)
	{
		i_row_break = i_row_break +27;
	}
	else
	{
		i_row_break = i_row_break +27+ i_tmp;
	}
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
  <x:WindowHeight>8835</x:WindowHeight>
  <x:WindowWidth>15120</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=750 style='border-collapse:
 collapse;table-layout:fixed;width:566pt'>
 <col class=xl24 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl24 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl24 width=113 style='mso-width-source:userset;mso-width-alt:4132;
 width:85pt'>
 <col class=xl24 width=109 style='mso-width-source:userset;mso-width-alt:3986;
 width:82pt'>
 <col class=xl24 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl24 width=52 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col class=xl24 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl24 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl24 width=54 span=246 style='mso-width-source:userset;mso-width-alt:
 1974;width:41pt'>
 <%
 for(k=0;k<dt_hgtrh_pk.Rows.Count;k++)
 {
	SQL = " SELECT v.tco_company_pk, v.voucherno, SUBSTR (v.tr_date, 7, 2) ngay, ";
    SQL +=  "       SUBSTR (v.tr_date, 5, 2) thang, SUBSTR (v.tr_date, 0, 4) nam, ";
    SQL +=  "       tr_person, (SELECT addr1 ";
    SQL +=  "                     FROM tco_buspartner b ";
    SQL +=  "                    WHERE b.pk = v.tco_buspartner_pk) addr, v.buspartner_lnm, ";
    SQL += "       v.remark, v.remark2, v.tr_enclose, v.tr_reason, v.VOUCHER_TYPE  ";
    SQL +=  "  FROM tac_bprvpv v ";
    SQL +=  " WHERE pk =  " + dt_hgtrh_pk.Rows[k][2].ToString();
	DataTable dt = ESysLib.TableReadOpen(SQL);
    
	if (dt.Rows.Count >0)
	{
		p_voucher_no = dt.Rows[0][1].ToString();
		p_ngay = dt.Rows[0][2].ToString();
		p_thang = dt.Rows[0][3].ToString();
		p_nam = dt.Rows[0][4].ToString();
		p_person = dt.Rows[0][5].ToString();
		p_addr = dt.Rows[0][6].ToString();
		p_buspartner_lnm = dt.Rows[0][7].ToString();
		p_remark = dt.Rows[0][8].ToString(); 
		p_remark2 = dt.Rows[0][9].ToString();
		p_enclose = dt.Rows[0][10].ToString();
		p_reason = dt.Rows[0][11].ToString();
        p_voucher_code = dt.Rows[0][12].ToString();
	}
    SQL = "SELECT UPPER(D.CODE_LNM) FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.DEL_IF =0 AND D.DEL_IF =0 AND M.ID ='ACBG0130' AND D.CODE = '" + p_voucher_code + "' ";
    dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count > 0)
    {
        p_voucher_name = dt.Rows[0][0].ToString();
    }
	/*
	SQL = " SELECT   d.ccy, TO_CHAR(SUM (D.TRANS_AMT),'9,999,999,999,999.99'), TRIM(TO_CHAR(SUM(D.trans_amt), DECODE(D.CCY,'VND','9,999,999,999,999','9,999,999,999,999.99')))||' '||d.ccy  FMT ";
	SQL += "    ,d.TR_RATE  ";
    SQL += "    FROM tac_bprvpvd d ";
    SQL += "   WHERE d.del_if = 0 ";
    SQL += "     AND d.tac_bprvpv_pk = " + dt_hgtrh_pk.Rows[k][2].ToString();
    SQL += "     AND d.drcr_type = 'C' ";
    SQL += "     AND d.tac_abacctcode_pk IN (SELECT pk FROM tac_abacctcode WHERE (ac_cd LIKE '111%'  or ac_cd LIKE '112%') AND tco_company_pk =" + p_company_pk+") ";
    SQL += "  GROUP BY ccy,TR_RATE ";
*/
	SQL = " SELECT   d.ccy, TO_CHAR(SUM (d.TR_AMT),'9,999,999,999,999.99'), TRIM(TO_CHAR(SUM(D.TR_AMT), DECODE(D.CCY,'VND','9,999,999,999,999','9,999,999,999,999.99')))||' '||d.ccy  FMT ";
	SQL += "    ,d.TR_RATE  ";
	SQL += "    FROM tac_hgtrd d ";
	SQL += "   WHERE d.del_if = 0 ";
	SQL += "     AND d.tac_hgtrh_pk = " + dt_hgtrh_pk.Rows[k][0].ToString();
	SQL += "     AND d.drcr_type = 'D' ";
	SQL += "     AND d.tac_abacctcode_pk IN (SELECT pk FROM tac_abacctcode WHERE (ac_cd LIKE '111%'  or ac_cd LIKE '112%') AND tco_company_pk =" + p_company_pk+") ";
	SQL += "  GROUP BY ccy,TR_RATE ";
    DataTable dt2 = ESysLib.TableReadOpen(SQL);
    if (dt2.Rows.Count > 0)
    {
        p_ccy = dt2.Rows[0][0].ToString();
        p_amount = dt2.Rows[0][1].ToString();
        p_fmt_amount = dt2.Rows[0][2].ToString();
		p_rate = dt2.Rows[0][3].ToString();
    }  
	p_amt_vn = CommondLib.Num2VNText(p_amount,p_ccy); 
	p_amt_en = CommondLib.Num2EngText(p_amount,p_ccy);
	
	SQL = " SELECT   d.drcr_type, ";
	SQL += "sf_a_get_accd (d.tac_abacctcode_pk,"+p_company_pk+")|| ' : '|| TRIM(TO_CHAR(SUM(d.TR_BOOKAMT),DECODE('"+ p_book_ccy +"','VND','9,999,999,999,999','9,999,999,999,999.99'))) ";
	SQL += "    FROM tac_hgtrd d ";
	SQL += "   WHERE d.del_if = 0 AND d.tac_hgtrh_pk = " + dt_hgtrh_pk.Rows[k][0].ToString();
	SQL += " GROUP BY d.drcr_type, d.tac_abacctcode_pk,DRCR_ORD ";
	SQL += " ORDER BY d.drcr_type DESC,DRCR_ORD ASC ";

	
	DataTable dt3 = ESysLib.TableReadOpen(SQL);
 %>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td colspan=6 height=33 class=xl43 width=477 style='height:24.95pt;
  width:360pt'><%=p_cmp_name %></td>
  <td colspan=4 class=xl44 width=219 style='width:165pt'>Form No/M&#7851;u
  s&#7889;: 01-TT</td>
  <td class=xl24 width=54 style='width:41pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=6 height=20 class=xl45 style='height:15.0pt'><%= p_cmp_add  %></td>
  <td colspan=4 class=xl40>Voucher No/S&#7889;: <font class="font6"><%= p_voucher_no%></font></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl39 style='height:15.0pt'>Tax Code/MST:</td>
  <td colspan=4 class=xl39><%= p_cmp_taxcode %></td>
  <td colspan=4 class=xl40>Seq: <font class="font6"><%= dt_hgtrh_pk.Rows[k][0].ToString() %></font></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=6 rowspan=5 height=102 class=xl41 width=477 style='height:76.9pt;
  width:360pt'>RECEIPT VOUCHER/ <%= p_voucher_name %><br>
    <font class="font9"><br>
    </font><font class="font5">Date/Ngày : <%= p_ngay %>/<%= p_thang%>/<%= p_nam%></font></td>
    <%
	for(i=0;i<dt3.Rows.Count;i++)
	{
		tmp1 = dt3.Rows[i][0].ToString();
		tmp2 = dt3.Rows[i][1].ToString();
		if (tmp1=="D")
		{
			tmp3 = "N&#7907;";
		}
		else
		{
			tmp3 = "C&oacute;";
		}
		if (i==0)
		{
%>
  <td class=xl26><%= tmp3 %> :</td>
  <td colspan=3 class=xl42><%= tmp2 %></td>
  <td class=xl24></td>
 </tr>
 <%
		}
		else
		{
	 %>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
 <% if (i>4) {%> <td colspan=6 class=xl40 width=459 style='width:346pt'></td><%} %>
  <td height=21 class=xl26 style='height:15.95pt'><%= tmp3 %> :</td>
  <td colspan=3 class=xl42><%= tmp2 %></td>
  <td class=xl24></td>
 </tr>
 <%
		}
	}
	for (i=0;i<5-dt3.Rows.Count;i++)//Blank rows
	{
%>

 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'></td>
  <td colspan=3 class=xl42></td>
  <td class=xl24></td>
 </tr>
 <%
	}
%>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=4 height=22 class=xl27 style='height:16.5pt'>Payer Name/ H&#7885;
  tên ng&#432;&#7901;i n&#7897;p ti&#7873;n:</td>
  <td colspan=6 class=xl38><%= p_person %></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl27 style='height:15.0pt'>Address/
  &#272;&#7883;a ch&#7881;:</td>
  <td colspan=7 class=xl38><%= p_addr %></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=3 height=21 class=xl27 style='height:15.75pt'>Object/
  &#272;&#417;n v&#7883;:</td>
  <td colspan=7 class=xl38><%= p_buspartner_lnm%></td>
  <td class=xl24></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl27 style='height:17.25pt'>Receive Reason/Lý
  do n&#7897;p:</td>
  <td colspan=7 class=xl35><%= p_remark%></td>
  <td class=xl24></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl27 style='height:17.25pt'></td>
  <td colspan=7 class=xl35><%= p_remark2 %></td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=3 height=24 class=xl27 style='height:18.0pt'>Total Amt/ S&#7889;
  ti&#7873;n:</td>
  <td colspan=3 class=xl36><%= p_fmt_amount %></td>
  <td class=xl25></td>
  <td colspan=2 class=xl37>Rate/T&#7927; giá:</td>
  <td class=xl28 align=right x:num><%= p_rate %></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 rowspan=2 height=20 class=xl27 style='height:15.0pt'>In Word/ B&#7857;ng
  ch&#7919;:</td>
  <td colspan=7 class=xl34 width=511 style='width:385pt'><%= p_amt_vn%></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=7 class=xl34 width=511 style='width:385pt;mso-text-control:shrinktofit;white-space:nowrap;'><%= p_amt_en%></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl27 colspan=2 style='height:15.0pt;mso-ignore:colspan'>Enclose/
  Kèm theo:</td>
  <td class=xl27></td>
  <td colspan=7><%= p_enclose %></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl29 style='height:12.75pt'><%= e1 %></td>
  <td colspan=2 class=xl29><%= e2 %></td>
  <td class=xl29><%= e3 %></td>
  <td class=xl29><%= e4 %></td>
  <td colspan=2 class=xl29><%= e5 %></td>
  <td colspan=2 class=xl29><%= e6 %></td>
  <td class=xl46></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl29 style='height:12.75pt'><%= v1 %></td>
  <td colspan=2 class=xl29><%= v2 %></td>
  <td class=xl29><%= v3 %></td>
  <td class=xl29><%= v4 %></td>
  <td colspan=2 class=xl29><%= v5 %></td>
  <td colspan=2 class=xl29><%= v6 %></td>
  <td class=xl46></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl30 style='height:12.75pt'><%= g1 %></td>
  <td colspan=2 class=xl30><%= g2 %></td>
  <td class=xl30><%= g3 %></td>
  <td class=xl30><%= g4 %></td>
  <td colspan=2 class=xl30><%= g5 %></td>
  <td colspan=2 class=xl30><%= g6 %></td>
  <td class=xl47></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 rowspan=3 height=76 class=xl32 style='height:57.0pt'></td>
  <td colspan=2 rowspan=3 class=xl32></td>
  <td rowspan=3 class=xl32></td>
  <td rowspan=3 class=xl32></td>
  <td colspan=2 rowspan=3 class=xl32></td>
  <td colspan=2 rowspan=3 class=xl32></td>
  <td class=xl24></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl24 style='height:27.75pt'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl24 style='height:16.5pt'></td>
 </tr>
<tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl29 style='height:12.75pt'><%= n1 %></td>
  <td colspan=2 class=xl29><%= n2 %></td>
  <td class=xl29><%= n3 %></td>
  <td class=xl29><%= n4 %></td>
  <td colspan=2 class=xl29><%= n5 %></td>
  <td colspan=2 class=xl29><%= n6 %></td>
  <td class=xl46></td>
 </tr>  
 <tr height=17 style='height:12.75pt'>
  <td colspan=10 height=17 class=xl33 style='height:12.75pt'>Payment Received
  (In Word)/&#272;ã nh&#7853;n &#273;&#7911; s&#7889; ti&#7873;n ( b&#7857;ng
  ch&#7919; ):……………………………………………………………………..</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=4 height=17 class=xl33 style='height:12.75pt'><span
  style='mso-spacerun:yes'> </span>+ S&#7889; ti&#7873;n quy &#273;&#7893;i:
  ................................................................................................................................................</td>
  <td colspan=6 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <%
 }
 %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=54 style='width:41pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=54 style='width:41pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
