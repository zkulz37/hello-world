<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	ESysLib.SetUser("acnt"); 
	//Response.Buffer = false;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string p_Company=Request["p_Company"];
    string p_voucher_date_fr = Request["p_Propos_fr"];
    string p_voucher_date_to = Request["p_Propos_to"];
    string p_Voucherno=Request["p_Voucherno"];
    string p_Status=Request["p_Status"];
    string p_Dept=Request["p_Dept"];
    string p_Emppk=Request["p_Emppk"];
    string p_ccy=Request["p_ccy"];
    
    string SQL
    = "SELECT  a.req_no, to_char(to_date(a.voucher_date,'yyyymmdd'),'DD/MM/YYYY'), to_char(to_date(a.req_date,'yyyymmdd'),'DD/MM/YYYY'), " + 
        "       a.req_date - a.voucher_date age, " +
        "       CASE " +
        "          WHEN TO_CHAR (SYSDATE, 'yyyymmdd') - req_date > 0 " +
        "             THEN TO_CHAR (SYSDATE, 'yyyymmdd') - req_date " +
        "          ELSE 0 " +
        "       END over_date, " +
        "       a.req_ccy, a.ex_rate, a.tr_amt, a.bk_amt, d.tr_famt paid_famt, " +
        "       d.tr_amt paid_amt, a.tr_amt - NVL (d.tr_famt, 0) bal_famt, " +
        "       a.bk_amt - NVL (d.tr_amt, 0) bal_amt, a.description, a.ldescription " +
        "  FROM tac_empadvreq a, " +
        "       tac_hgtrh b, " +
        "       tac_hgtrd c, " +
        "       (SELECT   tac_hgtrd_pk, SUM (tr_famt) tr_famt, SUM (tr_amt) tr_amt " +
        "            FROM tfn_eppay a " +
        "           WHERE a.del_if = 0 AND a.approval_yn = 'Y' " +
        "        GROUP BY tac_hgtrd_pk) d " +
        " WHERE a.del_if = 0 " +
        "   AND b.del_if(+) = 0 " +
        "   AND a.pk = b.tr_table_pk(+) " +
        "   AND b.tr_tablenm(+) = 'TAC_EMPADVREQ' " +
        "   AND c.del_if(+) = 0 " +
        "   AND b.pk = c.tac_hgtrh_pk(+) " +
        "   AND c.drcr_type(+) = 'C' " +
        "   AND c.pk = d.tac_hgtrd_pk(+) " +
        "   AND a.tco_company_pk = '" + p_Company + "' " +
        "   AND a.voucher_date BETWEEN '" + p_voucher_date_fr + "' AND '" + p_voucher_date_to + "' " +
        "   AND a.tco_dept_pk LIKE DECODE ('" + p_Dept + "', '', '%', '" + p_Dept+ "') " +
        "   AND a.charger_pk LIKE DECODE ('" + p_Emppk +"', '', '%', '" + p_Emppk + "') " +
        "   AND a.req_ccy LIKE DECODE ('" + p_ccy + "', 'ALL', '%', '" + p_ccy + "') " +
        "   and a.req_no like decode('" + p_Voucherno + "','','%','%' || '" + p_Voucherno +"' || '%') " +
        "   order by a.req_no " ;
    //Response.Write(SQL);
    //Response.End();
    DataTable dt = ESysLib.TableReadOpen(SQL);

    string SQL_sum  = "SELECT decode(grouping(a.REQ_CCY ),1,' Total','Sub Total') title,a.req_ccy, decode(grouping(a.req_ccy),1,null,max(a.ex_rate)) ex_rate,  " +
        "    decode(grouping(a.req_ccy),1,null,max(a.tr_amt)) tr_amt, sum(a.bk_amt) bk_amt, sum(d.tr_famt) paid_famt, " +
        "   sum(d.tr_amt) paid_amt, sum(a.tr_amt - NVL (d.tr_famt, 0)) bal_famt, " +
        "   sum(a.bk_amt - NVL (d.tr_amt, 0)) bal_amt " +
        "FROM tac_empadvreq a, " +
        "   tac_hgtrh b, " +
        "   tac_hgtrd c, " +
        "   (SELECT   tac_hgtrd_pk, SUM(tr_famt) tr_famt, SUM (tr_amt) tr_amt " +
        "        FROM tfn_eppay a " +
        "       WHERE a.del_if = 0 AND a.approval_yn = 'Y' " +
        "    GROUP BY tac_hgtrd_pk) d " +
        " WHERE a.del_if = 0 " +
        "   AND b.del_if(+) = 0 " +
        "   AND a.pk = b.tr_table_pk(+) " +
        "   AND b.tr_tablenm(+) = 'TAC_EMPADVREQ' " +
        "   AND c.del_if(+) = 0 " +
        "   AND b.pk = c.tac_hgtrh_pk(+) " +
        "   AND c.drcr_type(+) = 'C' " +
        "   AND c.pk = d.tac_hgtrd_pk(+) " +
        "   AND a.tco_company_pk = '" + p_Company + "' " +
        "   AND a.voucher_date BETWEEN '" + p_voucher_date_fr + "' AND '" + p_voucher_date_to + "' " +
        "   AND a.tco_dept_pk LIKE DECODE ('" + p_Dept + "', '', '%', '" + p_Dept + "') " +
        "   AND a.charger_pk LIKE DECODE ('" + p_Emppk + "', '', '%', '" + p_Emppk + "') " +
        "   AND a.req_ccy LIKE DECODE ('" + p_ccy + "', 'ALL', '%', '" + p_ccy + "') " +
        "   and a.req_no like decode('" + p_Voucherno + "','','%','%' || '" + p_Voucherno + "' || '%') " +
        " group by ROLLUP(a.req_ccy) ";
    //Response.Write(SQL_sum);
    //Response.End();
    DataTable dt_sum = ESysLib.TableReadOpen(SQL_sum);
 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_gfma00030_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_gfma00030_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_gfma00030_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Thu Hien</o:Author>
  <o:LastAuthor>Thu Hien</o:LastAuthor>
  <o:LastPrinted>2009-04-09T03:04:14Z</o:LastPrinted>
  <o:Created>2009-04-09T02:58:46Z</o:Created>
  <o:LastSaved>2009-04-09T03:51:45Z</o:LastSaved>
  <o:Company>Vina Genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in 0in 0in .25in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
	mso-page-orientation:landscape;
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
	padding:0px;
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
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl54
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:#99CCFF;
	mso-pattern:auto none;}
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
      <x:Scale>65</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>20</x:ActiveRow>
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
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1050"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1523 style='border-collapse:
 collapse;table-layout:fixed;width:1143pt'>
 <col class=xl24 width=35 style='mso-width-source:userset;mso-width-alt:1280;
 width:26pt'>
 <col class=xl24 width=102 style='mso-width-source:userset;mso-width-alt:3730;
 width:77pt'>
 <col class=xl24 width=116 style='mso-width-source:userset;mso-width-alt:4242;
 width:87pt'>
 <col class=xl24 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl24 width=57 style='mso-width-source:userset;mso-width-alt:2084;
 width:43pt'>
 <col class=xl24 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl24 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl24 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl24 width=98 style='mso-width-source:userset;mso-width-alt:3584;
 width:74pt'>
 <col class=xl24 width=107 style='mso-width-source:userset;mso-width-alt:3913;
 width:80pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=107 style='mso-width-source:userset;mso-width-alt:3913;
 width:80pt'>
 <col class=xl24 width=109 style='mso-width-source:userset;mso-width-alt:3986;
 width:82pt'>
 <col class=xl24 width=107 style='mso-width-source:userset;mso-width-alt:3913;
 width:80pt'>
 <col class=xl24 width=115 style='mso-width-source:userset;mso-width-alt:4205;
 width:86pt'>
 <col class=xl24 width=141 style='mso-width-source:userset;mso-width-alt:5156;
 width:106pt'>
 <col class=xl24 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl24 width=117 style='mso-width-source:userset;mso-width-alt:4278;
 width:88pt'>
 <tr class=xl25 height=26 style='height:19.5pt'>
  <td height=26 class=xl25 colspan=5 width=413 style='height:19.5pt;mso-ignore:
  colspan;width:310pt'>ADVANCE REQUEST EXPENSE BALANCE</td>
  <td class=xl25 width=63 style='width:47pt'></td>
  <td class=xl25 width=67 style='width:50pt'></td>
  <td class=xl25 width=86 style='width:65pt'></td>
  <td class=xl25 width=98 style='width:74pt'></td>
  <td class=xl25 width=107 style='width:80pt'></td>
  <td class=xl25 width=110 style='width:83pt'></td>
  <td class=xl25 width=107 style='width:80pt'></td>
  <td class=xl25 width=109 style='width:82pt'></td>
  <td class=xl25 width=107 style='width:80pt'></td>
  <td class=xl25 width=115 style='width:86pt'></td>
  <td class=xl25 width=141 style='width:106pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=6 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 rowspan=2 height=34 class=xl24 width=153 style='mso-ignore:
  colspan-rowspan;height:25.5pt;width:115pt'><!--[if gte vml 1]><v:shapetype
   id="_x0000_t128" coordsize="21600,21600" o:spt="128" path="m,l21600,,10800,21600xe">
   <v:stroke joinstyle="miter"/>
   <v:path gradientshapeok="t" o:connecttype="custom" o:connectlocs="10800,0;5400,10800;10800,21600;16200,10800"
    textboxrect="5400,0,16200,10800"/>
  </v:shapetype><v:shape id="_x0000_s1045" type="#_x0000_t128" style='position:absolute;
   margin-left:50.25pt;margin-top:12.75pt;width:0;height:0;z-index:4'
   fillcolor="#0cf" strokecolor="windowText" o:insetmode="auto">
   <x:ClientData ObjectType="Shape">
    <x:Anchor>
     6, 101, 2, 0, 6, 84, 2, 0</x:Anchor>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=66 height=16></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=2 height=2 src="rpt_gfma00030_files/image001.gif" v:shapes="_x0000_s1045"></td>
    <td width=85></td>
   </tr>
   <tr>
    <td height=16></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:114.75pt;height:25.5pt'></span><![endif]--></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl26>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl27></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td rowspan=2 height=41 class=xl48 style='border-bottom:.5pt solid black;
  height:30.75pt'>No.</td>
  <td rowspan=2 class=xl48 style='border-bottom:.5pt solid black'>PV No.</td>
  <td rowspan=2 class=xl48 style='border-bottom:.5pt solid black;border-top:
  none'>PV Date</td>
  <td rowspan=2 class=xl48 style='border-bottom:.5pt solid black'>Due Date</td>
  <td rowspan=2 class=xl48 style='border-bottom:.5pt solid black'>Age</td>
  <td rowspan=2 class=xl50 width=63 style='border-bottom:.5pt solid black;
  width:47pt'>Over Due Date</td>
  <td rowspan=2 class=xl48 style='border-bottom:.5pt solid black'>Trans. Ccy</td>
  <td rowspan=2 class=xl48 style='border-bottom:.5pt solid black'>Ex. Rate</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:
  none'>PV Amount</td>
  <td colspan=2 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>Clear Amount</td>
  <td colspan=2 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>Balance</td>
  <td colspan=2 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>Description</td>
 </tr>
 <tr class=xl28 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt'>Transaction</td>
  <td class=xl29>Booking</td>
  <td class=xl29>Transaction</td>
  <td class=xl29>Booking</td>
  <td class=xl29>Transaction</td>
  <td class=xl29>Booking</td>
  <td class=xl29>Foregn</td>
  <td class=xl29>Local</td>
 </tr>
 <%
    if (dt.Rows.Count>0)
        for(int i=0;i<dt.Rows.Count;i++)
        {
  %>
 <tr class=xl28 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl30 style='height:15.75pt' x:num><%=i+1 %></td>
  <td class=xl31><%=dt.Rows[i][0].ToString()%></td>
  <td class=xl32 x:num><%=dt.Rows[i][1].ToString() %></td>
  <td class=xl32 x:num><%=dt.Rows[i][2].ToString()%></td>
  <td class=xl31 x:num ><%=dt.Rows[i][3].ToString()%></td>
  <td class=xl31 x:num><%=dt.Rows[i][4].ToString()%></td>
  <td class=xl33><%=dt.Rows[i][5].ToString()%></td>
  <td class=xl35 x:num><%=dt.Rows[i][6].ToString()%></td>
  <td class=xl36 align=right x:num><%=dt.Rows[i][7].ToString()%></td>
  <td class=xl37 x:num><%=dt.Rows[i][8].ToString()%></td>
  <td class=xl37 x:num><%=dt.Rows[i][9].ToString()%></td>
  <td class=xl37 x:num><%=dt.Rows[i][10].ToString()%></td>
  <td class=xl37 x:num><%=dt.Rows[i][11].ToString()%></td>
  <td class=xl37 x:num><%=dt.Rows[i][12].ToString()%></td>
  <td class=xl38><%=dt.Rows[i][13].ToString()%></td>
  <td class=xl38><%=dt.Rows[i][14].ToString()%></td>
 </tr>
 <%
        } 
     %>
 <tr class=xl28 height=14 style='height:10.5pt'>
  <td height=14 colspan=7 class=xl28 style='height:10.5pt;mso-ignore:colspan'></td>
  <td class=xl39></td>
  <td colspan=8 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <%
    if (dt_sum.Rows.Count>0)
    {
        for(int i=0;i<dt_sum.Rows.Count;i++)
        {
        
  %>
 <tr class=xl28 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'></td>
  <td class=xl40></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl41><%=dt_sum.Rows[i][0].ToString() %></td>
  <td class=xl42><%=dt_sum.Rows[i][1].ToString() %></td>
  <td class=xl43 align=right x:num><%=dt_sum.Rows[i][2].ToString() %></td>
  <td class=xl43 align=right x:num><%=dt_sum.Rows[i][3].ToString() %></td>
  <td class=xl43 align=right x:num><%=dt_sum.Rows[i][4].ToString() %></td>
  <td class=xl43 align=right x:num><%=dt_sum.Rows[i][5].ToString() %></td>
  <td class=xl43 align=right x:num><%=dt_sum.Rows[i][6].ToString() %></td>
  <td class=xl43 align=right x:num><%=dt_sum.Rows[i][7].ToString() %></td>
  <td class=xl43 align=right x:num><%=dt_sum.Rows[i][8].ToString() %></td>
  <td class=xl34></td>
  <td class=xl28></td>
 </tr>
 <%
        }
    }
  %> 
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=16 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=16 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=16 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=7 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 rowspan=2 height=34 class=xl24 width=184 style='mso-ignore:
  colspan-rowspan;height:25.5pt;width:139pt'><!--[if gte vml 1]><v:shape id="_x0000_s1048"
   type="#_x0000_t128" style='position:absolute;margin-left:64.5pt;
   margin-top:12.75pt;width:0;height:0;z-index:5' fillcolor="window"
   strokecolor="windowText" o:insetmode="auto">
   <x:ClientData ObjectType="Shape">
    <x:Anchor>
     7, 117, 16, 0, 8, 0, 16, 0</x:Anchor>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1049" type="#_x0000_t128" style='position:absolute;
   margin-left:64.5pt;margin-top:12.75pt;width:0;height:0;z-index:6'
   fillcolor="window" strokecolor="windowText" o:insetmode="auto">
   <x:ClientData ObjectType="Shape">
    <x:Anchor>
     7, 88, 16, 0, 8, 0, 16, 0</x:Anchor>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=85 height=16></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=2 height=2 src="rpt_gfma00030_files/image001.gif" v:shapes="_x0000_s1048 _x0000_s1049"></td>
    <td width=97></td>
   </tr>
   <tr>
    <td height=16></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:138.0pt;height:25.5pt'></span><![endif]--></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=7 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=16 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=16 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=16 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=16 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td colspan=3 rowspan=2 height=34 class=xl24 width=321 style='mso-ignore:
  colspan-rowspan;height:25.5pt;width:241pt'><!--[if gte vml 1]><v:shape id="_x0000_s1041"
   type="#_x0000_t128" style='position:absolute;margin-left:76.5pt;
   margin-top:12.75pt;width:0;height:0;z-index:2' fillcolor="window"
   strokecolor="windowText" o:insetmode="auto">
   <x:ClientData ObjectType="Shape">
    <x:Anchor>
     1, 117, 22, 0, 2, 0, 22, 0</x:Anchor>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1042" type="#_x0000_t128" style='position:absolute;
   margin-left:163.5pt;margin-top:12.75pt;width:0;height:0;z-index:3'
   fillcolor="window" strokecolor="windowText" o:insetmode="auto">
   <x:ClientData ObjectType="Shape">
    <x:Anchor>
     2, 117, 22, 0, 3, 0, 22, 0</x:Anchor>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=101 height=16></td>
    <td width=2></td>
    <td width=114></td>
    <td width=2></td>
    <td width=102></td>
   </tr>
   <tr>
    <td height=2></td>
    <td align=left valign=top><img width=2 height=2
    src="rpt_gfma00030_files/image001.gif" v:shapes="_x0000_s1041"></td>
    <td></td>
    <td align=left valign=top><img width=2 height=2
    src="rpt_gfma00030_files/image001.gif" v:shapes="_x0000_s1042"></td>
   </tr>
   <tr>
    <td height=16></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:240.75pt;height:25.5pt'></span><![endif]--></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 rowspan=2 height=34 class=xl24 width=216 style='mso-ignore:
  colspan-rowspan;height:25.5pt;width:162pt'><!--[if gte vml 1]><v:shape id="_x0000_s1040"
   type="#_x0000_t128" style='position:absolute;margin-left:80.25pt;
   margin-top:12.75pt;width:0;height:0;z-index:1' fillcolor="window"
   strokecolor="windowText" o:insetmode="auto">
   <x:ClientData ObjectType="Shape">
    <x:Anchor>
     11, 155, 22, 0, 12, 0, 22, 0</x:Anchor>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=106 height=16></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=2 height=2 src="rpt_gfma00030_files/image001.gif" v:shapes="_x0000_s1040"></td>
    <td width=108></td>
   </tr>
   <tr>
    <td height=16></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:162.0pt;height:25.5pt'></span><![endif]--></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=35 style='width:26pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=141 style='width:106pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
