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
	string p_company_pk = ""+Request["company_pk"];
	string p_kindCode = ""+Request["KindCode"];
	string p_DeptPK = ""+Request["DeptPK"];
	string p_Status = ""+Request["Status"];
	string p_AssetNo = ""+ Request["AssetNo"];
	string p_AssetName = ""+ Request["AssetName"]	;
	string p_date_from = ""+Request["dtFrom"];
	string p_date_to = ""+Request["dtTo"];
    string p_company_name = "";
    string p_rpt_date = "";
    string p_rpt_date2 = "";
    string p_open_date = "";
    string p_tax_code = "";
    string p_cmp_add = "";
    string SQL = "";
	SQL
	= "SELECT '' NO, a.fa_status status, a.fa_cd, a.fa_nm, a.fa_kind_cd,  " + 
        "             TO_CHAR(TO_DATE(fa_use_date,'YYYYMMDD'),'DD/MM/YYYY') fa_use_date, nvl(fa_fcost,0) fa_fcost, nvl(fa_depr_famt,0) fa_depr_famt,  " +
        "             nvl((NVL (a.fa_begin_depr_famt, 0) + NVL (b.fd_damt, 0)),0) accum_amt,  " +
        "             nvl((a.fa_fcost - NVL (a.fa_begin_depr_famt, 0) - NVL (b.fd_dfamt, 0)  " +
        "             ),0) remain_famt  " +
        "        FROM tac_gffa_mst a, " +
        "             (SELECT   d.tac_gffa_mst_pk, SUM (d.fd_damt) fd_damt, " +
        "                       SUM (d.fd_dfamt) fd_dfamt " +
        "                  FROM tac_gffadprc_mst m, tac_gffadprc_dtl d " +
        "                 WHERE m.del_if = 0 " +
        "                   AND d.del_if = 0 " +
        "                   AND m.fd_status IN ('0', '1', '2') " +
        "                   AND d.tac_gffadprc_mst_pk = m.pk " +
        "              GROUP BY d.tac_gffa_mst_pk) b " +
        "       WHERE a.del_if = 0 " +
        "         AND b.tac_gffa_mst_pk(+) = a.pk " +
        "         AND a.tco_company_pk =  " + p_company_pk +
        "         AND a.fa_status = '" + p_Status + "' " +
        "         AND NVL(a.fa_kind_cd,'%') LIKE DECODE ('" + p_kindCode + "', 'ALL', '%', '" + p_kindCode + "') " +
        "         AND a.fa_cd LIKE '%' ||  '" + p_AssetNo + "'  || '%' " +
        "         AND a.fa_nm LIKE '%' || '" + p_AssetName + "' || '%' " +
        "         AND a.tco_org_pk LIKE DECODE ('" + p_DeptPK + "', '', '%', '" + p_DeptPK + "') " +
        "         AND a.fa_use_date BETWEEN '" + p_date_from + "' AND '" + p_date_to + "'  ORDER BY a.fa_kind_cd, a.fa_cd";
 
	
        
        DataTable dt =  ESysLib.TableReadOpen(SQL);

        SQL = " SELECT partner_lname, ";
        SQL += "       tax_code,ADDR1,ADDR2,ADDR3 ";
        SQL += "  FROM tco_company ";
        SQL += " WHERE pk =" + p_company_pk;

        DataTable  dt2 = ESysLib.TableReadOpen(SQL);
        p_company_name = dt2.Rows[0][0].ToString();
        
        p_tax_code = dt2.Rows[0][1].ToString();
        p_cmp_add = dt2.Rows[0][2].ToString() + " " + dt2.Rows[0][3].ToString(); 
        double t1,t2,t3,t4;
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="FIXED%20ASSET%20LIST_files/filelist.xml">
<link rel=Edit-Time-Data href="FIXED%20ASSET%20LIST_files/editdata.mso">
<link rel=OLE-Object-Data href="FIXED%20ASSET%20LIST_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2008-10-28T01:49:53Z</o:LastPrinted>
  <o:Created>2008-10-27T10:14:33Z</o:Created>
  <o:LastSaved>2008-10-28T01:50:02Z</o:LastSaved>
  <o:Company>vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .25in 1.0in .5in;
	mso-header-margin:.25in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}
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
	font-family:Tahoma;
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
	font-family:Tahoma;
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
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	color:black;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
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
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>95</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8445</x:WindowHeight>
  <x:WindowWidth>15240</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>15</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1067 style='border-collapse:
 collapse;table-layout:fixed;width:803pt'>
 <col width=64 span=2 style='width:48pt'>
 <col width=131 style='mso-width-source:userset;mso-width-alt:4790;width:98pt'>
 <col width=193 style='mso-width-source:userset;mso-width-alt:7058;width:145pt'>
 <col width=81 style='mso-width-source:userset;mso-width-alt:2962;width:61pt'>
 <col width=94 style='mso-width-source:userset;mso-width-alt:3437;width:71pt'>
 <col width=110 span=4 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <tr class=xl24 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=10 height=22 class=xl31 width=1067 style='height:16.5pt;
  width:803pt'><%=p_company_name %></td>
 </tr>
 <tr class=xl24 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=10 height=22 class=xl31 style='height:16.5pt'><%= p_cmp_add %></td>
 </tr>
 <tr class=xl24 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=10 height=22 class=xl31 style='height:16.5pt'>MST : <%= p_tax_code %></td>
 </tr>
 <tr class=xl24 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=10 height=32 class=xl32 style='height:24.0pt'>FIXED ASSET LIST</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl27 style='height:16.5pt'>No</td>
  <td class=xl27 style='border-left:none'>Status</td>
  <td class=xl27 style='border-left:none'>Asset No</td>
  <td class=xl27 style='border-left:none'>Asset Name</td>
  <td class=xl27 style='border-left:none'>Kind Code</td>
  <td class=xl27 style='border-left:none'>PIS Date</td>
  <td class=xl27 style='border-left:none'>Orginal Cost</td>
  <td class=xl27 style='border-left:none'>Depr. Amt.</td>
  <td class=xl27 style='border-left:none'>Accum.Depr.Amt.</td>
  <td class=xl27 style='border-left:none'>Remaining Amt.</td>
 </tr>
<%
t1=0;
t2=0;
t3=0;
t4=0;

    for(int i=0;i<dt.Rows.Count;i++)
   { 
        
        t1 = t1 +double.Parse(dt.Rows[i][6].ToString());
        t2 = t2 + double.Parse(dt.Rows[i][7].ToString());
        t3 = t3 + double.Parse(dt.Rows[i][8].ToString());
        t4 = t4 + double.Parse(dt.Rows[i][9].ToString());
         
 %> 
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl26 align=right style='height:16.5pt;border-top:none'
  x:num><%= (i+1) %></td>
  <td class=xl25 style='border-top:none;border-left:none'><%= dt.Rows[i][1].ToString() %></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt.Rows[i][2].ToString() %></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt.Rows[i][3].ToString() %></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt.Rows[i][4].ToString() %></td>
  <td class=xl29 style='border-top:none;border-left:none'><%= dt.Rows[i][5].ToString() %></td>
  <td class=xl28 align=right style='border-top:none;border-left:none'
  x:num><%= dt.Rows[i][6].ToString() %></td>
  <td class=xl28 align=right style='border-top:none;border-left:none'
  x:num><%= dt.Rows[i][7].ToString() %></td>
  <td class=xl28 align=right style='border-top:none;border-left:none'
  x:num><%= dt.Rows[i][8].ToString() %></td>
  <td class=xl28 align=right style='border-top:none;border-left:none'
  x:num><%= dt.Rows[i][9].ToString() %></td>
 </tr>
<%
}
 %> 
 
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=6 height=22 class=xl30 style='height:16.5pt'>Total</td>
  <td class=xl28 align=right style='border-top:none;border-left:none'
  x:num><%=t1 %></td>
  <td class=xl28 align=right style='border-top:none;border-left:none'
  x:num><%=t2 %></td>
  <td class=xl28 align=right style='border-top:none;border-left:none'
  x:num><%=t3 %></td>
  <td class=xl28 align=right style='border-top:none;border-left:none'
  x:num><%=t4 %></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=193 style='width:145pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
