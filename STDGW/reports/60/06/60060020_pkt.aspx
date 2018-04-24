<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_seq = "" + Request["seq"];
    string company = "" + Request["comp"];
    //Response.Write(p_seq);
    //Response.End();
    string Sophieu = "";
    string stt = "";
    string ngay="";
    string thang="";
    string nam="";
    string kt = "";
    string title = "";
    string nguoilap = "";
    string SQL = "";
    string l_taxcode = "";
    string l_compa = "";
    string l_address = "";

    
    string SQL1 = " SELECT PARTNER_LNAME,ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + company + "' ";
    DataTable dt_f = ESysLib.TableReadOpen(SQL1);

    if (dt_f.Rows.Count > 0)
    {
        l_compa = dt_f.Rows[0][0].ToString();
        l_address = dt_f.Rows[0][1].ToString();
        l_taxcode = dt_f.Rows[0][3].ToString();
    }
    //-----------------------------------------------------------------------
  
    string l_book_ccy = "VND";
    String p_xls_ccy_format = "";
    String p_xls_ccy_format_usd = "";
   
    if (l_book_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }



    string SQL10
   = "  SELECT a.pk " +
       "    FROM tac_hgtrh a " +
       "   WHERE a.pk IN (" + p_seq + ")  " +
       "   AND a.del_if = 0 " +
       "   order by pk ";    
    DataTable dt_pk = ESysLib.TableReadOpen(SQL10);
 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="aaa_files/filelist.xml">
<link rel=Edit-Time-Data href="aaa_files/editdata.mso">
<link rel=OLE-Object-Data href="aaa_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Phan Thi Thanh Tuyen</o:Author>
  <o:LastAuthor>LONG</o:LastAuthor>
  <o:LastPrinted>2010-09-16T01:58:34Z</o:LastPrinted>
  <o:Created>2010-04-09T03:21:05Z</o:Created>
  <o:LastSaved>2010-09-17T03:15:52Z</o:LastSaved>
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
	mso-header-margin:.25in;
	mso-footer-margin:.25in;}
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	
	vertical-align:middle;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	
	vertical-align:middle;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	vertical-align:middle;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Phiếu kế toán tổng hợp</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>90</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
    
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
for (int m=0; m < dt_pk.Rows.Count ;m++)
{
	i_row_break+=19; 
	string  _SQL  = " select 1 " +
         "    FROM tac_hgtrd a " +
         "   WHERE del_if = 0 AND tac_hgtrh_pk IN ("+dt_pk.Rows[m][0].ToString()+") " ;         
		DataTable _dt = ESysLib.TableReadOpen(_SQL);
		i_row_break+=_dt.Rows.Count;
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
  <x:WindowHeight>7680</x:WindowHeight>
  <x:WindowWidth>14955</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>360</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->

</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=735 style='border-collapse:
 collapse;table-layout:fixed;width:553pt'>
 <%
      //string t="";
      //for (int w = 0; w < dt_pk.Rows.Count; w++)
      //    t += dt_pk.Rows[w][0].ToString() + ",";
      //Response.Write(t);
      //Response.End();
          
     for (int w = 0; w < dt_pk.Rows.Count; w++)
     {
         string SQL5
     = "SELECT h.pk, " +
         "         h.voucherno, " +
         "         TO_CHAR (h.tr_date, 'DD') ngay, " +
         "         TO_CHAR (h.tr_date, 'MM') thang, " +
         "         TO_CHAR (h.tr_date, 'YYYY') nam, " +
         "         d.org_nm, " +
         "         a.tr_type, " +
         "         a.tr_tpnm, " +
         "         v1.full_name pro_by, " +
         "         h.sign_date, " +
         "         c.partner_name, " +
         "         h.tr_enclose, " +
         "         b.CODE_NM " +
         "    FROM tac_hgtrh h, " +
         "         tco_company c, " +
         "         tco_org d, " +
         "         tac_abtrtype a, " +
         "         vco_bsuser v1, " +
         "         vco_bsuser v2, " +
         "         (SELECT UPPER (N.CODE_NM) CODE_NM, k.pk pk " +
         "            FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL N, tac_hgtrh k " +
         "           WHERE     N.CODE = k.VOUCHER_TYPE " +
         "                 AND N.DEL_IF = 0 " +
         "                 AND N.TAC_COMMCODE_MASTER_PK = M.PK " +
         "                 AND M.del_if = 0 " +
         "                 AND m.id = 'ACBG0130') b " +
         "   WHERE     h.del_if = 0 " +
         "         AND c.del_if = 0 " +
         "         AND h.tco_org_pk = d.pk(+) " +
         "         AND h.tac_abtrtype_pk = a.pk(+) " +
         "         AND h.tco_company_pk = c.pk " +
         "         AND h.tco_bsuser_pk = v1.pk(+) " +
         "         AND h.sign_memb = v2.user_id(+) " +
         "         AND H.pk = b.pk " +
         "         AND h.pk IN ("+dt_pk.Rows[w][0].ToString()+") " +
         "ORDER BY h.pk ";

         //Response.Write(SQL5);
         //Response.End();
         DataTable dt_m = ESysLib.TableReadOpen(SQL5);
         if (dt_m.Rows.Count > 0)
         {
             Sophieu = dt_m.Rows[0][1].ToString();
             stt = dt_m.Rows[0][0].ToString();
             ngay = dt_m.Rows[0][2].ToString();
             thang = dt_m.Rows[0][3].ToString();
             nam = dt_m.Rows[0][4].ToString();
             kt = dt_m.Rows[0][11].ToString();
             title = dt_m.Rows[0][12].ToString();
             nguoilap = dt_m.Rows[0][8].ToString();
         }
      %>
 <col class=xl24 width=145 style='mso-width-source:userset;mso-width-alt:5302;
 width:109pt'>
 <col class=xl24 width=245 style='mso-width-source:userset;mso-width-alt:8960;
 width:184pt'>
 <col class=xl24 width=125 style='mso-width-source:userset;mso-width-alt:4571;
 width:94pt'>
 <col class=xl24 width=110 span=2 style='mso-width-source:userset;mso-width-alt:
 4022;width:83pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 width=145 style='height:15.75pt;width:109pt'><%=l_compa%></td>
  <td class=xl24 width=245 style='width:184pt'></td>
  <td colspan=3 class=xl25 width=345 style='width:260pt'>STT:<%=stt%></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'><%=l_address%></td>
  <td class=xl24></td>
  <td colspan=3 class=xl26>Mẫu số: 002a-DN</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl26>(Ban hành theo QĐ 15/2006/QĐ-BTC</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl26>Ngày 20/03/2006 của Bộ trưởng BTC)</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=5 height=21 class=xl27 style='height:15.75pt;font-size:20pt'><%=title%></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=5 height=21 class=xl26 style='height:15.75pt'>Số phiếu:<%=Sophieu%></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=5 height=21 class=xl26 style='height:15.75pt'>Ngày <%=ngay%> tháng <%=thang%> năm <%=nam%></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl28 style='height:21.75pt'>Đối tượng</td>
  <td class=xl29>Diễn giải</td>
  <td class=xl29>Tài khoản</td>
  <td class=xl29>PS Nợ</td>
  <td class=xl29>PS Có</td>
 </tr>
 <%
     decimal Sum_Dr = 0;
     decimal Sum_Cr = 0;
     string Inword = "";
   
    string  SQL7  = " SELECT SF_A_GET_AGTRITEM2 (a.PK), a.REMARK2 c1, sf_a_get_accd (a.tac_abacctcode_pk, 2) c2, " +
         "         DECODE (DRCR_TYPE, 'D', TR_BOOKAMT, 0) c3, " +
         "         DECODE (DRCR_TYPE, 'C', TR_BOOKAMT, 0) c4, a.pk " +
         "    FROM tac_hgtrd a " +
         "   WHERE del_if = 0 AND tac_hgtrh_pk IN ("+dt_pk.Rows[w][0].ToString()+") " +
         "ORDER BY DRCR_TYPE DESC, DRCR_ORD ";


      //Response.Write(SQL7);
      //Response.End();


     DataTable dt_detail = ESysLib.TableReadOpen(SQL7);
   
     for (int i = 0; i < dt_detail.Rows.Count; i++)
     {
         if (dt_detail.Rows[i][3].ToString().Trim() != "")
         {
             Sum_Dr += decimal.Parse(dt_detail.Rows[i][3].ToString());
         }
         else
         {
             Sum_Dr += 0;
         }

         if (dt_detail.Rows[i][4].ToString().Trim() != "")
         {
             Sum_Cr += decimal.Parse(dt_detail.Rows[i][4].ToString());
         }
         else
         {
             Sum_Cr += 0;
         }
         Inword = CommondLib.Num2VNText(Sum_Cr.ToString(), "VND");
         string SQL3 = " SELECT upper(substr(trim('" + Inword + "'),1,1)) || substr(lower(trim('" + Inword + "')),2, length(trim('" + Inword + "')))  from dual ";
         DataTable dt_t = ESysLib.TableReadOpen(SQL3);

       
         if (dt_t.Rows.Count > 0)
         {
             Inword = dt_t.Rows[0][0].ToString();

         }
        
  %>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl37 width=145 style='height:15.75pt;width:109pt'><%=dt_detail.Rows[i][0]%>&nbsp;</td>
  <td class=xl38 width=245 style='width:184pt'><%=dt_detail.Rows[i][1]%>&nbsp;</td>
  <td class=xl26 style="border-bottom:.5pt solid windowtext"><%=dt_detail.Rows[i][2]%></td>
  <td class=xl39 x:num><%=dt_detail.Rows[i][3]%></td>
  <td class=xl40 x:num><%=dt_detail.Rows[i][4]%></td>
 </tr>
 <%} %>
 <tr class=xl34 height=21 style='height:15.75pt'>
  <td height=21 class=xl30 style='height:15.75pt'>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl32>Cộng</td>
  <td class=xl33 x:num><%=Sum_Dr%></td>
  <td class=xl33 x:num><%=Sum_Cr%></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=5 height=21 class=xl35 style='height:15.75pt'>Bằng chữ:<%=Inword%></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl24 style='height:16.5pt'>Kèm theo: HĐ số:<%=kt%></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <%
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
        " AND M.ID='EACBK037' " +
        " order by D.ORD ";
     DataTable dt1 = ESysLib.TableReadOpen(SQL);
     String e1 = "";
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

     for (int k = 0; k < dt1.Rows.Count; k++)
     {

         string strTmp = dt1.Rows[k][0].ToString();
         if (strTmp == "ENG")
         {
             e1 = "" + dt1.Rows[k][1].ToString();
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
 <tr class=xl36 height=21 style='height:15.75pt'>
  <td height=21 class=xl36 style='height:15.75pt'>Người lập biểu</td>
  <td colspan=2 class=xl27>Kiểm soát</td>
  <td colspan=2 class=xl27>Giám đốc</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'>(Ký, họ tên)</td>
  <td colspan=2 class=xl26>(Ký, họ tên)</td>
  <td colspan=2 class=xl26>(Ký, họ tên)</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td colspan=2 class=xl26></td>
  <td colspan=2 class=xl26></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=145 style='width:109pt'></td>
  <td width=245 style='width:184pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
 </tr>
 <![endif]><%} %>
</table>

</body>

</html>
