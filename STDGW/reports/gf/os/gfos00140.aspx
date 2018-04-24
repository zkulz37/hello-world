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
       string p_kind = Request["kind"];               
       string p_status = Request["status"];              
       string p_tco_company_pk = Request["company"];      
       string p_date_fr = Request["from"];              
       string p_date_to = Request["to"];            
       string p_date_type = Request["date_type"];             
       string p_scale = Request["scale"];                  
       string p_month = Request["month"];
       string p_user = Request["user"];
    
       string p_quy_data = Request["quy"];
       string p_donvi = Request["donvi"];
       string p_nam = Request["nam"];
     

       string l_parameter = "'" + p_kind + "', ";
       l_parameter += "'" + p_status + "', ";
       l_parameter += "'" + p_tco_company_pk + "', ";
       l_parameter += "'" + p_date_fr + "', ";
       l_parameter += "'" + p_date_to + "', ";
       l_parameter += "'" + p_date_type + "', ";
       l_parameter += "'" + p_scale + "', ";
       l_parameter += "'" + p_month + "', ";
       l_parameter += "'" + p_user + "' ";
       //Response.Write(l_parameter);
       //Response.End();
       DataTable dt = ESysLib.TableReadOpenCursor("ACNT.sp_sel_gfos00140_1_rpt", l_parameter);
       if (dt.Rows.Count == 0)
       {
           Response.Write("There is no data!!");
           Response.End();
       }

       string l_taxcode = "";
       string l_compa = "";
       string l_address = "";

       string SQL1 = " SELECT PARTNER_NAME,ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + p_tco_company_pk + "' ";
       DataTable dt_f = ESysLib.TableReadOpen(SQL1);

       if (dt_f.Rows.Count > 0)
       {
           l_compa = dt_f.Rows[0][0].ToString();
           l_address = dt_f.Rows[0][1].ToString();
           l_taxcode = dt_f.Rows[0][3].ToString();
       }


      
       string quy_data = "";
       string thang_data = "";
       string SQL6 = "SELECT a.code code, a.code_nm code_nm " +
           "                  FROM tac_commcode_detail a, tac_commcode_master b " +
           "                 WHERE a.del_if = 0 AND b.del_if = 0 " +
           "                       AND a.tac_commcode_master_pk = b.pk " +
           "                       AND b.ID = 'GFQC0015' AND b.use_yn = 'Y' " +
           "                       and a.code = '" + p_quy_data + "' ";
     
       DataTable dt_6 = ESysLib.TableReadOpen(SQL6);
       if (p_kind == "95")
       {
           quy_data = dt_6.Rows[0][1].ToString();
       }

      
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="BCTHTSco_No_quy_files/filelist.xml">
<link rel=Edit-Time-Data href="BCTHTSco_No_quy_files/editdata.mso">
<link rel=OLE-Object-Data href="BCTHTSco_No_quy_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>lananh.nguyen</o:Author>
  <o:LastAuthor>Mr Long</o:LastAuthor>
  <o:LastPrinted>2010-05-27T01:58:13Z</o:LastPrinted>
  <o:Created>2008-12-09T06:38:37Z</o:Created>
  <o:LastSaved>2010-05-31T02:11:24Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in 0in .77in .2in;
	mso-header-margin:0in;
	mso-footer-margin:.79in;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style43
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
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
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
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
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
.xl65
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:justify;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl72
	{mso-style-parent:style43;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:top;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl73
	{mso-style-parent:style43;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:top;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:justify;}
.xl75
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl77
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	font-weight:700;}
.xl81
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl82
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:top;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl84
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Bao cao quy</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>8</x:SplitHorizontal>
     <x:TopRowBottomPane>8</x:TopRowBottomPane>
     <x:SplitVertical>1</x:SplitVertical>
     <x:LeftColumnRightPane>1</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7770</x:WindowHeight>
  <x:WindowWidth>14175</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=832 style='border-collapse:
 collapse;table-layout:fixed;width:624pt'>
 <col width=284 style='mso-width-source:userset;mso-width-alt:9088;width:213pt'>
 <col width=112 span=2 style='mso-width-source:userset;mso-width-alt:3584;
 width:84pt'>
 <col width=111 style='mso-width-source:userset;mso-width-alt:3552;width:83pt'>
 <col width=116 style='mso-width-source:userset;mso-width-alt:3712;width:87pt'>
 <col width=97 style='mso-width-source:userset;mso-width-alt:3104;width:73pt'>
 <col width=72 style='width:54pt'>
 <col width=114 style='mso-width-source:userset;mso-width-alt:3648;width:86pt'>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=3 height=27 class=xl83 width=508 style='height:20.25pt;
  width:381pt'>Nơi gửi: <%=l_compa%></td>
  <td colspan=2 class=xl82 width=227 style='width:170pt'>Phụ lục III - Biểu số
  3.4-NHNN</td>
  <td width=97 style='width:73pt'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=3 height=25 class=xl83 width=508 style='height:18.75pt;
  width:381pt'></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td colspan=5 height=25 class=xl84 style='height:18.75pt'>BÁO CÁO TÌNH HÌNH
  TÀI SẢN CÓ - TÀI SẢN NỢ</td>
  <td></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=5 height=21 class=xl85 style='height:15.75pt'>Quý <%=quy_data%> năm <%=p_nam%></td>
  <td></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl66 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=4 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl66>Đơn vị: <%=p_donvi%></td>
  <td></td>
 </tr>
 <tr height=42 style='height:31.5pt'>
  <td height=42 class=xl68 width=284 style='height:31.5pt;width:213pt'>&nbsp;</td>
  <td class=xl70 width=112 style='border-left:none;width:84pt'>Số dư đầu kỳ</td>
  <td class=xl69 width=112 style='border-left:none;width:84pt'>Phát sinh tăng
  trong kỳ</td>
  <td class=xl69 width=111 style='border-left:none;width:83pt'>Phát sinh giảm
  trong kỳ</td>
  <td class=xl70 width=116 style='border-left:none;width:87pt'>Số dư cuối kỳ</td>
  <td></td>
 </tr>
 <%
     string tag_begin = "";
     string tag_end = "";
     int i;
     for( i = 0;i<dt.Rows.Count-1;i++)
   {

       tag_begin = "";
       tag_end = "";
        if (dt.Rows[i][5].ToString()=="I")
        {
            tag_begin="<i>";
            tag_end="</i>";
        }
        if (dt.Rows[i][5].ToString()=="B")
        {
            tag_begin="<b>";
            tag_end="</b>";
        }
        if (i == 0)
        {
       
 %>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl71 width=284 style='height:18.75pt;width:213pt'><%=tag_begin%><%=dt.Rows[i][0]%><%=tag_end%></td>
  <td class=xl72 width=112 style='border-left:none;width:84pt' x:num><%=tag_begin%><%=dt.Rows[i][1]%><%=tag_end%></td>
  <td class=xl72 width=112 style='border-left:none;width:84pt' x:num><%=tag_begin%><%=dt.Rows[i][2]%><%=tag_end%></td>
  <td class=xl72 width=111 style='border-left:none;width:83pt' x:num><%=tag_begin%><%=dt.Rows[i][3]%><%=tag_end%></td>
  <td class=xl72 width=116 style='border-left:none;width:87pt'x:num><%=tag_begin%><%=dt.Rows[i][4]%><%=tag_end%></td>
  <td class=xl77></td>
 </tr>
  <%
     }
     else
     {
 %>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl71 width=284 style='height:18.75pt;width:213pt'><%=tag_begin%><%=dt.Rows[i][0]%><%=tag_end%></td>
  <td class=xl72 width=112 style='border-left:none;width:84pt' x:num><%=tag_begin%><%=dt.Rows[i][1]%><%=tag_end%></td>
  <td class=xl72 width=112 style='border-left:none;width:84pt' x:num><%=tag_begin%><%=dt.Rows[i][2]%><%=tag_end%></td>
  <td class=xl72 width=111 style='border-left:none;width:83pt' x:num><%=tag_begin%><%=dt.Rows[i][3]%><%=tag_end%></td>
  <td class=xl72 width=116 style='border-left:none;width:87pt'x:num><%=tag_begin%><%=dt.Rows[i][4]%><%=tag_end%></td>
  <td class=xl77></td>
 </tr>
  <%
     }
 }
         %>
<tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl71 width=284 style='height:18.75pt;width:213pt'><%=tag_begin%><%=dt.Rows[i][0]%><%=tag_end%></td>
  <td class=xl72 width=112 style='border-left:none;width:84pt' x:num><%=tag_begin%><%=dt.Rows[i][1]%><%=tag_end%></td>
  <td class=xl72 width=112 style='border-left:none;width:84pt' x:num><%=tag_begin%><%=dt.Rows[i][2]%><%=tag_end%></td>
  <td class=xl72 width=111 style='border-left:none;width:83pt' x:num><%=tag_begin%><%=dt.Rows[i][3]%><%=tag_end%></td>
  <td class=xl72 width=116 style='border-left:none;width:87pt'x:num><%=tag_begin%><%=dt.Rows[i][4]%><%=tag_end%></td>
  <td class=xl77></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl78 width=284 style='height:15.75pt;border-top:none;
  width:213pt'>&nbsp;</td>
  <td class=xl73 width=112 style='border-top:none;border-left:none;width:84pt'>&nbsp;</td>
  <td class=xl73 width=112 style='border-top:none;border-left:none;width:84pt'>&nbsp;</td>
  <td class=xl73 width=111 style='border-top:none;border-left:none;width:83pt'>&nbsp;</td>
  <td class=xl73 width=116 style='border-top:none;border-left:none;width:87pt'>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl65 style='height:15.75pt'></td>
  <td class=xl74></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl67 style='height:15.75pt'></td>
  <td colspan=2 class=xl75 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl75 width=227 style='width:170pt'
  x:str="Ngày  tháng  năm  ">Ngày  tháng  năm <span
  style='mso-spacerun:yes'> </span></td>
  <td></td>
 </tr>
 <tr class=xl80 height=21 style='height:15.75pt'>
  <td height=21 class=xl79 width=284 style='height:15.75pt;width:213pt'>LẬP
  BIỂU</td>
  <td colspan=2 class=xl81 width=224 style='width:168pt'>KIỂM SOÁT</td>
  <td colspan=2 class=xl81 width=227 style='width:170pt'>THỦ TRƯỞNG ĐƠN VỊ</td>
  <td class=xl80></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=6 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=6 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=6 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=6 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=6 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl76 style='height:15.0pt'>Dương Thị Hoàng Diệu</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=284 style='width:213pt'></td>
  <td width=112 style='width:84pt'></td>
  <td width=112 style='width:84pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=97 style='width:73pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
