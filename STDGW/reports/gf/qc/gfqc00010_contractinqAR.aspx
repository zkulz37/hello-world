<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
%>

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string l_tco_company_pk =Request["p_company_pk"];
    string l_partner_pk     =Request["p_partner_pk"];
    string l_pl_pk          =Request["p_pl_pk"];
    string l_contr_no       =Request["p_contr_no"];
    
    string l_cmp_name, l_cmp_add, l_cmp_taxcode;
    
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
      
   
    string SQL_contr_AR= "select  ROWNUM,E.CONTR_NO,p.PARTNER_ID,p.PARTNER_NAME,pl.pl_cd,pl.pl_nm,E.B_CCY,nvl(E.TOT_AMT,0),nvl(ADV.TR_AMT,0) adv_amt ,nvl(IN_NET.TR_AMT,0) IN_NET_amt " + 
        "        ,nvl(COLL_NET.TR_AMT,0) COLL_NET_amt, (nvl(adv.tr_amt,0)+nvl(COLL_NET.tr_amt,0)) TOT_PAID, nvl(E.TOT_AMT,0)-(nvl(adv.tr_amt,0)+nvl(COLL_NET.tr_amt,0)) bal_amt " +
        "        FROM imex.tex_contr_mst E, comm.TCO_BUSPARTNER p " +
        "            ,(SELECT t.pk, c.pl_cd, c.pl_nm " +
        "                FROM tac_abpl c, tac_abplcenter t " +
        "                WHERE c.del_if = 0 AND t.del_if = 0  " +
        "                    AND t.tac_abpl_pk = c.pk) PL " +
        "            ,(SELECT a.ITEM_TABLE_PK AS CONTR_PK, SUM(C.TR_AMT)  TR_AMT " +
        "            FROM TAC_HGTRDITEM A,TAC_HGTRH B, TAC_HGTRD C,TAC_ABACCTCODE D " +
        "            WHERE  " +
        "                A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0  " +
        "                AND D.DEL_IF=0  " +
        "                AND a.TABLE_NM='TEX_CONTR_MST' " +
        "                AND D.AC_CD IN ('331300','331400') AND D.AC_TYPE='C' " +
        "                AND d.PK=C.TAC_ABACCTCODE_PK " +
        "                AND A.TAC_HGTRD_PK=C.PK " +
        "                AND b.PK=c.TAC_HGTRH_PK " +
        "            GROUP BY  a.ITEM_TABLE_PK) ADV " +
        "            ,(SELECT a.ITEM_TABLE_PK as CONTR_PK, SUM(C.TR_AMT) TR_AMT   " +
        "            FROM TAC_HGTRDITEM A,TAC_HGTRH B, TAC_HGTRD C, " +
        "            TAC_ABACCTCODE D " +
        "            WHERE  " +
        "                A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0  " +
        "                AND d.DEL_IF=0 " +
        "                AND a.TABLE_NM='TEX_CONTR_MST' " +
        "                AND D.AC_CD in ('331100','331200') AND D.DRCR_TYPE='D' " +
        "                AND D.PK=C.TAC_ABACCTCODE_PK " +
        "                AND A.TAC_HGTRD_PK=C.PK " +
        "                AND b.PK=c.TAC_HGTRH_PK " +
        "            GROUP BY  a.ITEM_TABLE_PK)IN_NET " +
        "            ,(SELECT a.ITEM_TABLE_PK CONTR_PK, SUM(C.TR_AMT) TR_AMT   " +
        "            FROM TAC_HGTRDITEM A,TAC_HGTRH B, TAC_HGTRD C " +
        "            ,TAC_ABACCTCODE D " +
        "            WHERE  " +
        "                A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0  " +
        "                AND D.DEL_IF=0  " +
        "                AND a.TABLE_NM='TEX_CONTR_MST' " +
        "                AND D.AC_CD in ('331100','331200') " +
        "                AND D.DRCR_TYPE='C' " +
        "                AND D.PK=C.TAC_ABACCTCODE_PK " +
        "                AND A.TAC_HGTRD_PK=C.PK " +
        "                AND b.PK=c.TAC_HGTRH_PK " +
        "            GROUP BY  a.ITEM_TABLE_PK) COLL_NET " +
        "        where " +
        "            E.del_if(+)=0 AND p.del_if=0  " +
        "            AND E.pk=IN_NET.contr_pk(+)  " +
        "            AND E.pk=adv.contr_pk(+)        " +
        "            AND E.pk=COLL_NET.contr_pk(+) " +
        "            AND p.pk(+)=E.TCO_BUSPARTNER_PK " +
        "            AND pl.pk(+)=E.TAC_ABPLCENTER_PK " +
        "            AND E.STATUS in (0,2)   " +
        "            AND (E.contr_no LIKE '%' || '" + l_contr_no + "'|| '%' OR '" + l_contr_no + "' IS NULL) " +
        "            AND (E.TAC_ABPLCENTER_PK='" + l_pl_pk +"' or  '" + l_pl_pk + "' is null) " +
        "            AND (E.TCO_BUSPARTNER_PK= '"+ l_partner_pk + "' or '" + l_partner_pk + "' is null)  " +
        "            and decode('" + l_tco_company_pk + "','ALL','" + l_tco_company_pk + "',e.TCO_COMPANY_PK )='" + l_tco_company_pk + "' " +
        "        order by rownum,e.CONTR_NO     " ;       
           
       DataTable dt_AR = ESysLib.TableReadOpen(SQL_contr_AR);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfqc00010_contractinqAR_files/filelist.xml">
<link rel=Edit-Time-Data href="gfqc00010_contractinqAR_files/editdata.mso">
<link rel=OLE-Object-Data href="gfqc00010_contractinqAR_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>genuwin</o:Author>
  <o:LastAuthor>Thu Hien</o:LastAuthor>
  <o:LastPrinted>2009-03-20T07:39:53Z</o:LastPrinted>
  <o:Created>2009-03-12T01:42:49Z</o:Created>
  <o:LastSaved>2009-03-20T07:42:28Z</o:LastSaved>
  <o:Company>company</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.5in .25in .25in .5in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl26
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Accounts Receiable for Customer</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>203</x:HorizontalResolution>
      <x:VerticalResolution>203</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:LeftColumnVisible>3</x:LeftColumnVisible>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>8</x:SplitHorizontal>
     <x:TopRowBottomPane>8</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Accounts Receiable for Customer'!$A$8:$M$8</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1161 style='border-collapse:
 collapse;table-layout:fixed;width:872pt'>
 <col class=xl24 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl24 width=118 style='mso-width-source:userset;mso-width-alt:4315;
 width:89pt'>
 <col class=xl24 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=106 style='mso-width-source:userset;mso-width-alt:3876;
 width:80pt'>
 <col class=xl24 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=105 style='mso-width-source:userset;mso-width-alt:3840;
 width:79pt'>
 <col class=xl24 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <col class=xl24 width=103 span=4 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <col class=xl24 width=109 style='mso-width-source:userset;mso-width-alt:3986;
 width:82pt'>
 <col class=xl24 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 colspan=2 width=179 style='height:12.75pt;
  mso-ignore:colspan;width:135pt'><%=l_cmp_name %></td>
  <td class=xl24 width=54 style='width:41pt'></td>
  <td class=xl24 width=106 style='width:80pt'></td>
  <td class=xl24 width=54 style='width:41pt'></td>
  <td class=xl24 width=105 style='width:79pt'></td>
  <td class=xl24 width=39 style='width:29pt'></td>
  <td class=xl24 width=103 style='width:77pt'></td>
  <td class=xl24 width=103 style='width:77pt'></td>
  <td class=xl24 width=103 style='width:77pt'></td>
  <td class=xl24 width=103 style='width:77pt'></td>
  <td class=xl24 width=109 style='width:82pt'></td>
  <td class=xl24 width=103 style='width:77pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 colspan=4 style='height:12.75pt;mso-ignore:colspan'><%=l_cmp_add %></td>
  <td colspan=9 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 colspan=2 style='height:12.75pt;mso-ignore:colspan'>Mã
  s&#7889; thu&#7871;: <%=l_cmp_taxcode %></td>
  <td colspan=11 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=13 height=27 class=xl30 style='height:20.25pt'>Accounts Receiable
  for Customer</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl31 style='border-bottom:.5pt solid black;
  height:25.5pt'>No</td>
  <td rowspan=2 class=xl31 style='border-bottom:.5pt solid black'>Contract No</td>
  <td colspan=2 class=xl33 style='border-right:.5pt solid black;border-left:
  none' x:str="Partner ">Partner<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl33 style='border-right:.5pt solid black;border-left:
  none'>P/L</td>
  <td colspan=2 class=xl27 style='border-left:none'>Contract</td>
  <td rowspan=2 class=xl27>Advance Amount</td>
  <td rowspan=2 class=xl29 width=103 style='width:77pt'>Issue Invoice<br>
    (NET)</td>
  <td rowspan=2 class=xl29 width=103 style='width:77pt'>Collection money<br>
    (NET)</td>
  <td rowspan=2 class=xl31 style='border-bottom:.5pt solid black'>Total Coll.
  Amount</td>
  <td rowspan=2 class=xl27>Balance Amount</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'>Code</td>
  <td class=xl27 style='border-top:none'>Name</td>
  <td class=xl27 style='border-top:none;border-left:none'>Code</td>
  <td class=xl27 style='border-top:none;border-left:none'>Name</td>
  <td class=xl27 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Ccy</td>
  <td class=xl27 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Amount</td>
 </tr>
 <%
   for(int i=0;i<dt_AR.Rows.Count;i++)
   {
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'><%=i+1 %></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt_AR.Rows[i][1].ToString()%></td>
  <td class=xl25 style='border-left:none'><%=dt_AR.Rows[i][2].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt_AR.Rows[i][3].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt_AR.Rows[i][4].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt_AR.Rows[i][5].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt_AR.Rows[i][6].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none' x:num><%=dt_AR.Rows[i][7].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none' x:num><%=dt_AR.Rows[i][8].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none' x:num><%=dt_AR.Rows[i][9].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none' x:num><%=dt_AR.Rows[i][10].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none' x:num><%=dt_AR.Rows[i][11].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none' x:num><%=dt_AR.Rows[i][12].ToString()%></td>
 </tr>
 <%
    }
  %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=61 style='width:46pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=103 style='width:77pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
