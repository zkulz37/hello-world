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
    string SQL = "SELECT '' NO, a.fa_status status, a.fa_cd, a.fa_nm, a.fa_kind_cd, " +
        "             TO_CHAR(TO_DATE(fa_use_date,'YYYYMMDD'),'DD/MM/YYYY'), nvl(fa_cost,0), nvl(fa_depr_amt,0), " +
        "             nvl((NVL (a.fa_begin_depr_amt, 0) + NVL (b.fd_damt, 0)),0) accum_amt, " +
        "             nvl((a.fa_cost - NVL (a.fa_begin_depr_amt, 0) - NVL (b.fd_damt, 0) " +
        "             ),0) remain_amt " +
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

		 string l_parameter = "'" + p_from + "','" + p_to + "','" + p_comp + "','" +  p_kind  + "','" + p_dept + "','" + p_status + "', '"+p_ccy+"'";
    DataTable dt_grp_kind = ESysLib.TableReadOpenCursor("acnt.sp_sel_gfgf00040_02_2", l_parameter);
	
    DataTable dt_sum_location = ESysLib.TableReadOpenCursor("acnt.sp_sel_gfgf00040_02_3", l_parameter);
	//Response.Write(dt_sum_location.Rows.Count.ToString());
	//Response.End();
    DataTable dt_grd_total = ESysLib.TableReadOpenCursor("acnt.sp_sel_gfgf00040_02_4", l_parameter);
    DataTable dt_detail = ESysLib.TableReadOpenCursor("acnt.sp_sel_gfgf00040_02_1",l_parameter);
    DataTable dt_depr_yn = ESysLib.TableReadOpenCursor("acnt.sp_sel_gfgf00040_02_5", l_parameter);
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfgf00030_posco_VIE_files/filelist.xml">
<link rel=Edit-Time-Data href="gfgf00030_posco_VIE_files/editdata.mso">
<link rel=OLE-Object-Data href="gfgf00030_posco_VIE_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>ISA_SERVER</o:LastAuthor>
  <o:LastPrinted>2008-10-28T01:49:53Z</o:LastPrinted>
  <o:Created>2008-10-27T10:14:33Z</o:Created>
  <o:LastSaved>2011-04-07T09:55:04Z</o:LastSaved>
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
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	mso-number-format:"\@";
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	color:black;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
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
     <x:SplitHorizontal>6</x:SplitHorizontal>
     <x:TopRowBottomPane>6</x:TopRowBottomPane>
     <x:SplitVertical>4</x:SplitVertical>
     <x:LeftColumnRightPane>16</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>19</x:ActiveCol>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=2605 style='border-collapse:
 collapse;table-layout:fixed;width:1956pt'>
 <col width=64 style='width:48pt'>
 <col width=73 style='mso-width-source:userset;mso-width-alt:2669;width:55pt'>
 <col width=131 style='mso-width-source:userset;mso-width-alt:4790;width:98pt'>
 <col width=193 style='mso-width-source:userset;mso-width-alt:7058;width:145pt'>
 <col width=81 style='mso-width-source:userset;mso-width-alt:2962;width:61pt'>
 <col width=94 style='mso-width-source:userset;mso-width-alt:3437;width:71pt'>
 <col width=143 style='mso-width-source:userset;mso-width-alt:5229;width:107pt'>
 <col width=123 style='mso-width-source:userset;mso-width-alt:4498;width:92pt'>
 <col width=142 style='mso-width-source:userset;mso-width-alt:5193;width:107pt'>
 <col width=127 span=5 style='mso-width-source:userset;mso-width-alt:4644;
 width:95pt'>
 <col width=153 style='mso-width-source:userset;mso-width-alt:5595;width:115pt'>
 <col width=110 span=3 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col width=141 style='mso-width-source:userset;mso-width-alt:5156;width:106pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=64 span=3 style='width:48pt'>
 <tr class=xl24 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=20 height=22 class=xl33 width=2413 style='height:16.5pt;
  width:1812pt'><%=p_company_name %></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl24 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=20 height=22 class=xl33 style='height:16.5pt'><%= p_cmp_add %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=20 height=22 class=xl33 style='height:16.5pt'>MST :<%= p_tax_code %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=20 height=32 class=xl34 style='height:24.0pt'>DANH SÁCH TÀI SẢN
  CỐ ĐỊNH</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td rowspan=2 height=53 class=xl39 style='border-bottom:.5pt solid black;
  height:39.75pt;border-top:none'>STT</td>
  <td rowspan=2 class=xl39 style='border-bottom:.5pt solid black;border-top:
  none'>Trạng thái</td>
  <td rowspan=2 class=xl39 style='border-bottom:.5pt solid black;border-top:
  none'>Mã tài sản</td>
  <td rowspan=2 class=xl39 style='border-bottom:.5pt solid black;border-top:
  none'>Tên tài sản</td>
  <td rowspan=2 class=xl39 style='border-bottom:.5pt solid black;border-top:
  none'>Loại</td>
  <td rowspan=2 class=xl39 style='border-bottom:.5pt solid black;border-top:
  none'>Ngày sử dụng</td>
  <td colspan=2 class=xl41 style='border-left:none'>Nguyên giá đầu kỳ</td>
  <td colspan=2 class=xl42 style='border-right:.5pt solid black;border-left:
  none'>TS tăng trong kỳ</td>
  <td colspan=2 class=xl42 style='border-right:.5pt solid black;border-left:
  none'>TS giảm trong kỳ</td>
  <td colspan=2 class=xl42 style='border-right:.5pt solid black;border-left:
  none'>Nguyên giá cuối kỳ</td>
  <td colspan=2 class=xl42 style='border-right:.5pt solid black;border-left:
  none'>Trị giá khấu hao</td>
  <td colspan=2 class=xl44 width=220 style='border-right:.5pt solid black;
  border-left:none;width:166pt'>Tri giá khấu hao lũy kế</td>
  <td colspan=2 class=xl42 style='border-right:.5pt solid black;border-left:
  none'>Trị giá còn lại</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl41 style='height:14.25pt;border-top:none;border-left:
  none'>VND</td>
  <td class=xl41 style='border-top:none;border-left:none'>USD</td>
  <td class=xl25>VND</td>
  <td class=xl25>USD</td>
  <td class=xl25>VND</td>
  <td class=xl25>USD</td>
  <td class=xl25>VND</td>
  <td class=xl25>USD</td>
  <td class=xl25>VND</td>
  <td class=xl25>USD</td>
  <td class=xl25>VND</td>
  <td class=xl26 width=110 style='width:83pt'>USD</td>
  <td class=xl26 width=141 style='width:106pt'>VND</td>
  <td class=xl25>USD</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
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
  <td height=22 class=xl28 style='height:16.5pt'><%= (i+1) %>&nbsp;</td>
  <td class=xl29><%= dt.Rows[i][1].ToString() %>&nbsp;</td>
  <td class=xl30><%= dt.Rows[i][2].ToString() %>&nbsp;</td>
  <td class=xl30><%= dt.Rows[i][3].ToString() %>&nbsp;</td>
  <td class=xl30><%= dt.Rows[i][4].ToString() %>&nbsp;</td>
  <td class=xl31><%= dt.Rows[i][5].ToString() %>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl32><%= dt.Rows[i][6].ToString() %>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32><%= dt.Rows[i][7].ToString() %>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32><%= dt.Rows[i][8].ToString() %>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32><%= dt.Rows[i][9].ToString() %>&nbsp;</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <%
}
 %>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=6 height=22 class=xl35 style='border-right:.5pt solid black;
  height:16.5pt'>Total</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl32><%=t1 %>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32><%=t2 %>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32><%=t3 %>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32><%=t4 %>&nbsp;</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=193 style='width:145pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=143 style='width:107pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=142 style='width:107pt'></td>
  <td width=127 style='width:95pt'></td>
  <td width=127 style='width:95pt'></td>
  <td width=127 style='width:95pt'></td>
  <td width=127 style='width:95pt'></td>
  <td width=127 style='width:95pt'></td>
  <td width=153 style='width:115pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=141 style='width:106pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
