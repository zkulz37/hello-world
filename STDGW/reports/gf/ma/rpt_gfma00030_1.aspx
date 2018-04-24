<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
    ESysLib.SetUser("acnt");
    Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_tac_empadvreq_pk=Request["p_tac_empadvreq_pk"];
    string p_tco_company_pk =Request["p_tco_company_pk"];
    
    string l_cmp_name    ="";
    string l_cmp_add     ="";
    string l_cmp_taxcode ="";
    
    int adv_amt,over_adv_amt;
    adv_amt=over_adv_amt=0;
    
    string SQL1 = " SELECT PARTNER_NAME, ADDR1, ADDR2, TAX_CODE " +      
    " FROM TCO_COMPANY WHERE PK = '" + p_tco_company_pk + "' ";
    
    
      DataTable dt_f = ESysLib.TableReadOpen(SQL1);
      if (dt_f.Rows.Count > 0)
      {
          l_cmp_name = dt_f.Rows[0][0].ToString();
          l_cmp_add = dt_f.Rows[0][1].ToString();
          l_cmp_taxcode = dt_f.Rows[0][3].ToString();          
      }
    
    string SQL	= "SELECT A.REQ_NO, to_char(to_date(a.VOUCHER_DATE,'yyyymmdd'),'dd') dd " + 
        ",to_char(to_date(a.VOUCHER_DATE,'yyyymmdd'),'mm') mm " +
        ",to_char(to_date(a.VOUCHER_DATE,'yyyymmdd'),'yyyy') yyyy " +
        ", B.FULL_NAME,B.PERMANENT_ADDR,NVL(c.TR_AMT,0) D141, NVL(d.tr_amt,0) D331, NVL(C.TR_AMT,0)-NVL(D.TR_AMT,0)  " +
        "FROM tac_empadvreq A, hr.thr_employee B " +
        ",(SELECT E.REQ_NO, sum(NVL(C.TR_AMT,0)) TR_AMT " +
        "FROM TAC_HGTRH B, TAC_HGTRD C,TAC_ABACCTCODE D " +
        "    ,TAC_EMPADVREQ E " +
        "WHERE  " +
        "    B.DEL_IF=0 AND C.DEL_IF=0  " +
        "    AND D.DEL_IF=0 AND E.DEL_IF=0  " +
        "    AND b.TR_TABLENM='TAC_EMPADVREQ' " +
        "    AND D.AC_CD like  ('141') || '%'  " +
        "    AND c.DRCR_TYPE='D' " +
        "    AND d.PK=C.TAC_ABACCTCODE_PK    " +
        "    AND b.PK=c.TAC_HGTRH_PK " +
        "    and e.PK=b.TR_TABLE_PK " +
        "group by E.REQ_NO) C,     " +
        "(SELECT E.REQ_NO, sum(NVL(C.TR_AMT,0)) TR_AMT " +
        "FROM TAC_HGTRH B, TAC_HGTRD C,TAC_ABACCTCODE D " +
        "    ,TAC_EMPADVREQ E " +
        "WHERE  " +
        "    B.DEL_IF=0 AND C.DEL_IF=0  " +
        "    AND D.DEL_IF=0 AND E.DEL_IF=0  " +
        "    AND b.TR_TABLENM='TAC_EMPADVREQ' " +
        "    AND D.AC_CD like  ('331') || '%'  " +
        "    AND c.DRCR_TYPE='D' " +
        "    AND d.PK=C.TAC_ABACCTCODE_PK    " +
        "    AND b.PK=c.TAC_HGTRH_PK " +
        "    and e.PK=b.TR_TABLE_PK " +
        "group by E.REQ_NO ) D " +
        "WHERE A.DEL_IF=0 AND B.DEL_IF=0 " +
        "    AND A.CHARGER_PK=B.PK " +
        "    AND A.REQ_NO=D.REQ_NO(+) " +
        "    AND A.REQ_NO=C.REQ_NO(+) " +
        "    AND A.STATUS='0' " +
        "    AND A.PK='" + p_tac_empadvreq_pk + "' " ;
    
    //Response.Write(SQL);
    //Response.End();
    
    DataTable dt = ESysLib.TableReadOpen(SQL);
    
    string SQL_D141 = "SELECT B.VOUCHERNO,TO_CHAR(B.TR_DATE,'DD/MM/YYYY') TR_DATE,NVL(C.TR_AMT,0) TR_AMT " + 
        "FROM TAC_HGTRH B, TAC_HGTRD C,TAC_ABACCTCODE D " +
        "    ,TAC_EMPADVREQ E " +
        "WHERE  " +
        "    B.DEL_IF=0 AND C.DEL_IF=0  " +
        "    AND D.DEL_IF=0 AND E.DEL_IF=0  " +
        "    AND b.TR_TABLENM='TAC_EMPADVREQ' " +
        "    AND D.AC_CD like  ('141') || '%'  " +
        "    AND c.DRCR_TYPE='D' " +
        "    AND d.PK=C.TAC_ABACCTCODE_PK    " +
        "    AND b.PK=c.TAC_HGTRH_PK " +
        "    and e.PK=b.TR_TABLE_PK " +
        "    AND E.PK='" + p_tac_empadvreq_pk + "' " ;
        
        DataTable dt_D141=ESysLib.TableReadOpen(SQL_D141);
        
    string SQL_D331 = "SELECT B.VOUCHERNO,TO_CHAR(B.TR_DATE,'DD/MM/YYYY') TR_DATE,NVL(C.TR_AMT,0) TR_AMT " + 
        "FROM TAC_HGTRH B, TAC_HGTRD C,TAC_ABACCTCODE D " +
        "    ,TAC_EMPADVREQ E " +
        "WHERE  " +
        "    B.DEL_IF=0 AND C.DEL_IF=0  " +
        "    AND D.DEL_IF=0 AND E.DEL_IF=0  " +
        "    AND b.TR_TABLENM='TAC_EMPADVREQ' " +
        "    AND D.AC_CD like  ('331') || '%'  " +
        "    AND c.DRCR_TYPE='D' " +
        "    AND d.PK=C.TAC_ABACCTCODE_PK    " +
        "    AND b.PK=c.TAC_HGTRH_PK " +
        "    and e.PK=b.TR_TABLE_PK " +
        "    AND E.PK='" + p_tac_empadvreq_pk + "' " ;
        
        DataTable dt_D331=ESysLib.TableReadOpen(SQL_D331);       
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_gfma00030_1_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_gfma00030_1_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_gfma00030_1_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Thu Hien</o:Author>
  <o:LastAuthor>Thu Hien</o:LastAuthor>
  <o:LastPrinted>2009-04-09T08:29:12Z</o:LastPrinted>
  <o:Created>2009-04-09T05:47:51Z</o:Created>
  <o:LastSaved>2009-04-09T08:29:47Z</o:LastSaved>
  <o:Company>Vina Genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .25in 0in .75in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
	mso-horizontal-page-align:center;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style16
	{mso-style-name:Comma;
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl26
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl29
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl35
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl36
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	border-top:none;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl50
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl58
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl59
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>95</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>9</x:ActiveRow>
       <x:ActiveCol>11</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet2</x:Name>
    <x:WorksheetOptions>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8445</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=674 style='border-collapse:
 collapse;table-layout:fixed;width:508pt'>
 <col class=xl24 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl24 width=97 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <col class=xl24 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl24 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <col class=xl24 width=34 style='mso-width-source:userset;mso-width-alt:1243;
 width:26pt'>
 <col class=xl24 width=46 style='mso-width-source:userset;mso-width-alt:1682;
 width:35pt'>
 <col class=xl24 width=31 style='mso-width-source:userset;mso-width-alt:1133;
 width:23pt'>
 <col class=xl24 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl24 width=46 style='mso-width-source:userset;mso-width-alt:1682;
 width:35pt'>
 <col class=xl24 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl24 width=29 style='mso-width-source:userset;mso-width-alt:1060;
 width:22pt'>
 <col class=xl24 width=95 style='mso-width-source:userset;mso-width-alt:3474;
 width:71pt'>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl24 width=77 style='height:18.75pt;width:58pt'
  x:str="&#272;&#416;N V&#7882;: ">&#272;&#416;N V&#7882;:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl24 colspan=3 width=222 style='mso-ignore:colspan;width:167pt'><%=l_cmp_name%></td>
  <td class=xl24 width=34 style='width:26pt'></td>
  <td class=xl24 width=46 style='width:35pt'></td>
  <td class=xl24 width=31 style='width:23pt'></td>
  <td class=xl24 width=38 style='width:29pt'></td>
  <td class=xl24 width=46 style='width:35pt'></td>
  <td class=xl24 width=56 style='width:42pt'></td>
  <td class=xl24 width=29 style='width:22pt'></td>
  <td class=xl24 width=95 style='width:71pt'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl24 style='height:18.75pt' x:str="B&#7896; PH&#7852;N: ">B&#7896;
  PH&#7852;N:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=12 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <%
    if (dt.Rows.Count>0) 
    {
  %>
 <tr height=27 style='height:20.25pt'>
  <td height=27 colspan=2 class=xl24 style='height:20.25pt;mso-ignore:colspan'></td>
  <td class=xl26 colspan=8 style='mso-ignore:colspan'>GI&#7844;Y THANH TOÁN
  TI&#7872;N T&#7840;M &#7912;NG</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=12 class=xl24 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=3 class=xl24 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl24>Ngày</td>
  <td class=xl27 x:num><%=dt.Rows[0][1].ToString() %></td>
  <td class=xl24>Tháng</td>
  <td class=xl27 x:str><%=dt.Rows[0][2].ToString() %></td>
  <td class=xl24>N&#259;m</td>
  <td class=xl27 x:str><%=dt.Rows[0][3].ToString() %></td>
  <td class=xl28></td>
  <td class=xl24>S&#7889;:</td>
  <td class=xl28 x:str><%=dt.Rows[0][0].ToString() %></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=12 class=xl24 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl24 colspan=2 style='height:18.75pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>H&#7885; tên ng&#432;&#7901;i thanh toán:</td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'><%=dt.Rows[0][4].ToString() %></td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl24>N&#7907;:</td>
  <td class=xl29 align=right x:num><%=dt.Rows[0][6].ToString() %></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl24 style='height:18.75pt'><span
  style='mso-spacerun:yes'> </span>&#272;&#7883;a ch&#7881;:</td>
  <td colspan=9 class=xl45><%=dt.Rows[0][5].ToString() %></td>
  <td class=xl24>Có:</td>
  <td class=xl29 align=right x:num><%=dt.Rows[0][7].ToString() %><%over_adv_amt=int.Parse(dt.Rows[0][7].ToString());%></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl24 colspan=5 style='height:18.75pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>S&#7889; ti&#7873;n t&#7841;m &#7913;ng
  &#273;&#432;&#7907;c thanh toán theo b&#7843;ng d&#432;&#7899;i &#273;ây:</td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=12 class=xl24 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl30 style='height:18.0pt'>S&#7889; TT</td>
  <td colspan=8 class=xl47 style='border-right:.5pt solid black;border-left:
  none'>Di&#7877;n gi&#7843;i</td>
  <td colspan=3 class=xl49 style='border-right:.5pt solid black;border-left:
  none'>Thành ti&#7873;n</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl31 style='height:16.5pt'>A</td>
  <td colspan=8 class=xl47 style='border-right:.5pt solid black;border-left:
  none'>B</td>
  <td colspan=3 class=xl49 style='border-right:.5pt solid black;border-left:
  none' x:num>1</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl32 style='height:18.75pt'>I</td>
  <td class=xl33 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>S&#7889; ti&#7873;n t&#7841;m &#7913;ng:</td>
  <td colspan=5 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl36>&nbsp;</td>
  <td colspan=3 class=xl51 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dt.Rows[0][6].ToString() %><%adv_amt=int.Parse(dt.Rows[0][6].ToString()); %></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl32 style='height:18.75pt' x:num>1</td>
  <td class=xl37 colspan=4 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>S&#7889; t&#7841;m &#7913;ng các
  &#273;&#7907;t tr&#432;&#7899;c ch&#432;a chi h&#7871;t:</td>
  <td colspan=3 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl36>&nbsp;</td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dt.Rows[0][8].ToString() %></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl32 style='height:18.75pt' x:num>2</td>
  <td class=xl37 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>S&#7889; t&#7841;m &#7913;ng k&#7923; này:</td>
  <td colspan=5 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl36>&nbsp;</td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black;border-left:
  none' x:num></td>
 </tr>
 <%
    if (dt_D141.Rows.Count>0)
    {
        for(int i=0;i<dt_D141.Rows.Count;i++)
        {
  %>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl37 style='height:18.75pt'>&nbsp;</td>
  <td class=xl37 x:str="'- Phi&#7871;u chi s&#7889;:">- Phi&#7871;u chi
  s&#7889;:</td>
  <td class=xl25><%=dt_D141.Rows[i][0].ToString() %></td>
  <td class=xl24>Ngày</td>
  <td class=xl39 colspan=2 style='mso-ignore:colspan' x:str><%=dt_D141.Rows[i][1].ToString() %></td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dt_D141.Rows[i][2].ToString() %></td>
 </tr>
 <%
        }
        int rows= int.Parse(dt_D331.Rows.Count.ToString());
       int r_rows =4-rows;
       if (rows<4)
       {
            if (r_rows>0)
                for (int i=0;i<r_rows;i++)
                {           
 
  %> 
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl37 style='height:18.75pt'>&nbsp;</td>
  <td class=xl41 x:str="'-">-</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
 </tr>
 <%
        }
    }
   }
  %> 
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl32 style='height:18.75pt'>II</td>
  <td class=xl37><span style='mso-spacerun:yes'> </span>S&#7889; ti&#7873;n
  &#273;ã chi:</td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black'
  x:num></td>
 </tr>
 <%
   if (dt_D331.Rows.Count>0)
    {
        for(int i=0;i<dt_D331.Rows.Count;i++)
        {
        %>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl32 style='height:18.75pt' x:num><%=i+1 %></td>
  <td class=xl37 x:str="' - Ch&#7913;ng t&#7915; s&#7889;:"><span
  style='mso-spacerun:yes'> </span>- Ch&#7913;ng t&#7915; s&#7889;:</td>
  <td class=xl25><%=dt_D331.Rows[i][0].ToString() %></td>
  <td class=xl24>Ngày</td>
  <td class=xl39 colspan=2 style='mso-ignore:colspan' x:str><%=dt_D331.Rows[i][1].ToString() %></td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dt_D331.Rows[i][2].ToString() %></td>
 </tr>        
        <%        
        }
       int rows= int.Parse(dt_D331.Rows.Count.ToString());
       int r_rows =10-rows;
       if (rows<10)
       {
            if (r_rows>0)
                for (int i=0;i<r_rows;i++)
                {
                %>
<tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl32 style='height:18.75pt' x:num><%=i+rows%></td>
  <td class=xl41>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
 </tr>                
                <%
                }
       }
     }
     else
     {
     %>
<tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl32 style='height:18.75pt' x:num>1</td>
  <td class=xl37 x:str="' - Ch&#7913;ng t&#7915; s&#7889;:"><span
  style='mso-spacerun:yes'> </span>- Ch&#7913;ng t&#7915; s&#7889;:</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl24>Ngày</td>
  <td class=xl39 colspan=2 style='mso-ignore:colspan' x:str>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black;border-left:
  none' x:num></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl32 style='height:18.75pt' x:num>2</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl32 style='height:18.75pt' x:num>3</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl32 style='height:18.75pt' x:num>4</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl32 style='height:18.75pt' x:num>5</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl32 style='height:18.75pt' x:num>6</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl32 style='height:18.75pt' x:num>7</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl32 style='height:18.75pt' x:num>8</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl32 style='height:18.75pt' x:num>9</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl32 style='height:18.75pt' x:num>10</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
 </tr>     
     <%
        
     }
  %>  
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl32 style='height:18.75pt'>III</td>
  <td class=xl37><span style='mso-spacerun:yes'> </span>Chênh l&#7879;ch:</td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl32 style='height:18.75pt' x:num>1</td>
  <td class=xl37 colspan=3 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>S&#7889; t&#7841;m &#7913;ng chi không
  h&#7871;t (I - II)</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black' x:num><%= adv_amt-over_adv_amt%></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl32 style='height:18.75pt' x:num>2</td>
  <td class=xl37 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>Chi quá s&#7889; t&#7841;m &#7913;ng (I +
  II)</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black' x:num><%= adv_amt+over_adv_amt%></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl42 style='height:18.75pt'>&nbsp;</td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl56 style='border-right:.5pt solid black'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl43 style='height:18.75pt'>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td colspan=3 class=xl59 style='border-right:.5pt solid black'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=12 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=12 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl28>Th&#7911; tr&#432;&#7903;ng &#273;&#417;n v&#7883;</td>
  <td class=xl24></td>
  <td class=xl27>K&#7871; toán tr&#432;&#7903;ng</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl27>K&#7871; toán thanh toán</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl27>Ng&#432;&#7901;i thanh toán</td>
  <td class=xl24></td>
 </tr>
 <%
    }
  %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=77 style='width:58pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=34 style='width:26pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=31 style='width:23pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=95 style='width:71pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
