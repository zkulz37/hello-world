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
	string p_from_dt = "", p_to_dt = "";
	p_from_dt = Request["from_dt"];
	p_to_dt = Request["to_dt"];
string SQL
	= "select distinct r.tac_abacctcode_pk, c.ac_cd " + 
        "from tac_hgtrd r, tac_hgtrh h, tac_abacctcode c " +
        "where r.del_if = 0 " +
        "and r.tac_abacctcode_pk in ( " +
        "                    select distinct d.tac_abacctcode_pk " +
        "                            from tac_abtracgrp a, tac_abtracgrpd d " +
        "                        where a.ac_grp = '331' " +
        "                        and a.del_if = 0 " +
        "                        and a.app_grp = 'Y' " +
        "                        and a.pk = d.tac_abtracgrp_pk " +
        "                        and d.del_if = 0 " +
        "                    ) " +
        "        and r.drcr_type = 'C' " +
        "        and r.tac_hgtrh_pk = h.pk " +
		" and to_char(h.tr_date, 'YYYYMMDD') between '" + p_from_dt + "' and '" + p_to_dt + "' " +
        "        and h.tr_status in ('2', '0') " +
        "        and h.del_if = 0 " +
        "        and h.tr_tablenm = 'TAC_CRDA' " +
		" and r.tac_abacctcode_pk = c.pk " +
        "    order by r.tac_abacctcode_pk " ;
	DataTable dt = ESysLib.TableReadOpen(SQL);
	int i, j;	
	string l_ac_pk = "";	
	
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="fmgf00220_CTMH_Mua_files/filelist.xml">
<link rel=Edit-Time-Data href="fmgf00220_CTMH_Mua_files/editdata.mso">
<link rel=OLE-Object-Data href="fmgf00220_CTMH_Mua_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>GENU</o:Author>
  <o:LastAuthor>GENU</o:LastAuthor>
  <o:Created>2010-04-27T08:33:03Z</o:Created>
  <o:LastSaved>2010-04-27T08:38:36Z</o:LastSaved>
  <o:Company>GENUWIN</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
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
	font-size:13.5pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid black;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	border:.5pt solid black;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border:.5pt solid black;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border:.5pt solid black;
	white-space:normal;}	
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>AP Details</x:Name>
    <x:WorksheetOptions>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PublishObjects>
     <x:PublishObject>
      <x:Id>14473</x:Id>
      <x:DivID>Book4_14473</x:DivID>
      <x:SourceType>SourceSheet</x:SourceType>
      <x:HtmlType>HtmlStatic</x:HtmlType>
      <x:Location
       HRef="C:\Documents and Settings\treasure\Desktop\fmgf00220_CTMH_Mua.htm"/>
     </x:PublishObject>
    </x:PublishObjects>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9780</x:WindowHeight>
  <x:WindowWidth>16905</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>345</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=739 style='border-collapse:
 collapse;table-layout:fixed;width:555pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=69 style='mso-width-source:userset;mso-width-alt:2523;width:52pt'>
 <col width=250 style='mso-width-source:userset;mso-width-alt:9142;width:188pt'>
 <col width=67 style='mso-width-source:userset;mso-width-alt:2450;width:50pt'>
 <col width=66 style='mso-width-source:userset;mso-width-alt:2413;width:50pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl24 colspan=4 align=left width=466 style='height:17.25pt;
  mso-ignore:colspan;width:350pt'>Chi tiết mặt hàng theo tài khoản đối ứng</td>
  <td width=67 style='width:50pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=68 style='width:51pt'></td>
 </tr>
 <%
	for( i = 0 ; i < dt.Rows.Count; i++)
	{
		l_ac_pk = dt.Rows[i][0].ToString();
 SQL
	= "select a.voucherno, to_char(h.tr_date, 'dd/mm') tr_date " + 
        ", i.item_code, i.item_name  " +
        ", (select uom_nm from tco_uom where uom_code = i.uom and del_if = 0 )uom " +
        ", d.ap_qty, d.ap_tramt, (select c.ac_cd from tac_abacctcode c where c.pk = d.tac_abacctcode_pk) ac_cd, d.ap_trfamt " +
        "from tac_hgtrd r, tac_hgtrh h, tac_crda a, tac_crdad d, tco_item i  " +
        "where r.del_if = 0 " +
        "and r.tac_abacctcode_pk like '" + l_ac_pk + "' " +
        "        and r.drcr_type = 'C'                     " +
        "        and r.tac_hgtrh_pk = h.pk " +
        "        and h.tr_status in ('2', '0') " +
        "        and h.del_if = 0 " +
        "        and h.tr_tablenm = 'TAC_CRDA' " +
        "        and a.pk =  h.tr_table_pk " +
        "        and a.del_if = 0 " +
        "        and a.pk = d.tac_crda_pk " +
        "        and d.del_if = 0     " +
        "        and d.tco_item_pk = i.pk                                                " +
        "    order by a.voucherno " ;
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=9 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=9 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 align=left style='height:12.75pt;mso-ignore:colspan'>Tài
  khoản <%=dt.Rows[i][1]%></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 colspan=2 align=left style='height:15.75pt;
  mso-ignore:colspan'>Tháng <%=p_from_dt.Substring(4,2)%>/<%=p_from_dt.Substring(0,4)%></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=9 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=51 style='height:38.25pt'>
  <td height=51 class=xl26 width=68 style='height:38.25pt;width:51pt'>Chứng
  từ</td>
  <td class=xl26 width=79 style='border-left:none;width:59pt'>Ngày tháng</td>
  <td class=xl26 width=69 style='border-left:none;width:52pt'>Mã hàng</td>
  <td class=xl26 width=250 style='border-left:none;width:188pt'>Tên hàng</td>
  <td class=xl26 width=67 style='border-left:none;width:50pt'>Đơn vị</td>
  <td class=xl26 width=66 style='border-left:none;width:50pt'>Số lượng</td>
  <td class=xl26 width=72 style='border-left:none;width:54pt'>Tiền Nhập</td>
  <td class=xl26 width=72 style='border-left:none;width:54pt'>Tiền VND</td>
  <td class=xl26 width=68 style='border-left:none;width:51pt'>Tài khoản</td>
 </tr>
 <%
	DataTable dtDtl = ESysLib.TableReadOpen(SQL);
	for( j = 0 ; j < dtDtl.Rows.Count ; j++)
	{
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 align=left width=68 style='height:12.75pt;
  border-top:none;width:51pt'>&nbsp;<%=dtDtl.Rows[j][0]%></td>
  <td class=xl27 align=left width=79 style='border-top:none;border-left:none;
  width:59pt'>&nbsp;<%=dtDtl.Rows[j][1]%></td>
  <td class=xl27 align=left width=69 style='border-top:none;border-left:none;
  width:52pt'>&nbsp;<%=dtDtl.Rows[j][2]%></td>
  <td class=xl27 align=left width=250 style='border-top:none;border-left:none;
  width:188pt'>&nbsp;<%=dtDtl.Rows[j][3]%></td>
  <td class=xl27 align=left width=67 style='border-top:none;border-left:none;
  width:50pt'>&nbsp;<%=dtDtl.Rows[j][4]%></td>
  <td class=xl27 align=right width=66 style='border-top:none;border-left:none;
  width:50pt' x:num><%=dtDtl.Rows[j][5]%></td>
  <td class=xl28 width=72 style='border-top:none;border-left:none;width:54pt'
  x:num><span style='mso-spacerun:yes'>       </span><%=dtDtl.Rows[j][6]%> </td>
  <td class=xl29 width=72 style='border-top:none;border-left:none;width:54pt'
  x:num><span style='mso-spacerun:yes'>       </span><%=dtDtl.Rows[j][8]%> </td>  
  <td class=xl28 width=68 style='border-top:none;border-left:none;width:51pt'
  x:str><span style='mso-spacerun:yes'>           </span><%=dtDtl.Rows[j][7]%><span
  style='mso-spacerun:yes'>   </span></td>
 </tr>
 <%
		}
	}
 %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=68 style='width:51pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=250 style='width:188pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=68 style='width:51pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
