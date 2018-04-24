<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<% ESysLib.SetUser("prod");%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
%>
<html 
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
    string l_pk_list;
	l_pk_list	=	Request["pkList"];
	
	string l_company = "";
	string l_cmp_short = "";
	string l_addr1 = "";
	string l_addr2 = "";
	string l_addr3 = "";
	string l_tel	= "";
	string l_fax	= "";
	string l_photo_pk = "";
    
    int i = 0;
    string SQL = "";
	char []seperate  = {','};


        Array l_po_pk = l_pk_list.Split(seperate);

       
        SQL = " select PARTNER_NAME,ADDR1,ADDR2,ADDR3,PHONE_NO,FAX_NO,SHORT_NM,TCO_BPPHOTO_PK from comm.tco_company a, prod.PO_PO_M b   ";
        SQL = SQL + "where  b.tco_company_pk = a.pk and b.pk =  '" + l_po_pk.GetValue(0) + "' ";
        DataTable dt = ESysLib.TableReadOpen(SQL);
        if (dt.Rows.Count > 0)
        {
            l_company = dt.Rows[0][0].ToString();
            l_addr1 = dt.Rows[0][1].ToString();
            l_addr2 = dt.Rows[0][2].ToString();
            l_addr3 = dt.Rows[0][3].ToString();
            l_tel = dt.Rows[0][4].ToString();
            l_fax = dt.Rows[0][5].ToString();
            l_cmp_short = dt.Rows[0][6].ToString();
            l_photo_pk = dt.Rows[0][7].ToString();
        }

	
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
  <o:Author>IT DEPT</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2008-04-09T07:17:09Z</o:LastPrinted>
  <o:Created>2005-02-02T09:57:08Z</o:Created>
  <o:LastSaved>2008-04-09T07:19:26Z</o:LastSaved>
  <o:Company>ESTV</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .2in .5in .5in;
	mso-header-margin:.1in;
	mso-footer-margin:.1in;}
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
	font-family:"Arial Unicode MS";
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
	font-family:"Arial Unicode MS";
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
	font-weight:700;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:21.0pt;
	font-weight:700;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;}
.xl43
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;}
.xl47
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
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
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>5</x:ActiveRow>
       <x:RangeSelection>$A$6:$G$6</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9225</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1590</x:WindowTopY>
  <x:TabRatio>345</x:TabRatio>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1025"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=689 style='border-collapse:
 collapse;table-layout:fixed;width:519pt'>
 <col width=39 style='mso-width-source:userset;mso-width-alt:1426;width:29pt'>
 <col width=161 style='mso-width-source:userset;mso-width-alt:5888;width:121pt'>
 <col width=150 style='mso-width-source:userset;mso-width-alt:5485;width:113pt'>
 <col width=46 style='mso-width-source:userset;mso-width-alt:1682;width:35pt'>
 <col width=77 style='mso-width-source:userset;mso-width-alt:2816;width:58pt'>
 <col width=94 style='mso-width-source:userset;mso-width-alt:3437;width:71pt'>
 <col width=122 style='mso-width-source:userset;mso-width-alt:4461;width:92pt'>
 <%
 
   
         for (i = 0; i < l_po_pk.Length; i++)
         {
             SQL = " select to_char(to_date(po_date,'YYYYMMDD'),'YYYY.MM.DD'), ";
             SQL = SQL + "po_no, (SELECT  CODE_NM  FROM TCO_ABCODE A, TCO_ABCODEGRP B WHERE  ";
             SQL = SQL + "A.TCO_ABCODEGRP_PK = b.pk  ";
             SQL = SQL + "and b.id ='ACCR0140' and a.use_if = 1 and a.del_if = 0 and b.del_if = 0  ";
             SQL = SQL + "and upper(code) = upper(b.PAYMENT_METHOD) ) FormOfPayment, ";
             SQL = SQL + "(SELECT  CODE_NM  FROM TCO_ABCODE A, TCO_ABCODEGRP B WHERE A.TCO_ABCODEGRP_PK = ";
             SQL = SQL + "b.pk and b.id ='ACCR0020' and a.use_if = 1 and a.del_if = 0 and b.del_if = 0  ";
             SQL = SQL + "and upper(code) = upper(b.PAYMENT_TERM) ) TermOfPayment ";
             SQL = SQL + " ,  c.partner_name, c.addr1, c.addr2, c.addr3, c.phone_no, c.fax_no,b.sale_rep     ";
             SQL = SQL + " from  prod.PO_PO_M b ,tco_busPartner c  ";
             SQL = SQL + " where  ";
             SQL = SQL + " b.SUPPLIER_PK = c.pk(+) ";
             SQL = SQL + " and b.pk = " + l_po_pk.GetValue(i);

             DataTable dt1 = ESysLib.TableReadOpen(SQL);

             if (dt1.Rows.Count < 1)
             {
                 return;
             }
		
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 width=39 style='height:12.75pt;width:29pt'></td>
  <td width=161 style='width:121pt'></td>
  <td width=150 style='width:113pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=122 style='width:92pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=7 height=17 style='height:12.75pt' class=xl38><%= l_company%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=7 height=17 class=xl38 style='height:12.75pt'><%= l_addr1%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=7 height=17 class=xl38 style='height:12.75pt'><%= l_addr2%> <%= l_addr3%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=7 height=17 class=xl38 style='height:12.75pt'>TEL: <%= l_tel%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=7 height=17 class=xl38 style='height:12.75pt'>FAX: <%= l_fax%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=7 height=17 style='height:12.75pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=7 rowspan=2 height=34 class=xl39 style='height:25.5pt'>PURCHASE
  ORDER</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=7 height=17 style='height:12.75pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl40 style='height:12.75pt'>DATE: <%=dt1.Rows[0][0]%></td>
  <td></td>
  <td colspan=3 class=xl40>TO: <%=dt1.Rows[0][10]%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=4 height=17 class=xl40 style='height:12.75pt'>MESSERS: <%=dt1.Rows[0][4]%></td>
  <td colspan=3 rowspan=2 class=xl40>TEL: <%= dt1.Rows[0][8]%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td colspan=3 rowspan=2 class=xl41 width=357 style='width:269pt'><%= dt1.Rows[0][5]%><br>
  <%= dt1.Rows[0][6]%> <%=dt1.Rows[0][7]%>
  </td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td colspan=3 rowspan=2 class=xl40>FAX: <%=dt1.Rows[0][9]%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl40 style='height:12.75pt'>PO NO.: <%=dt1.Rows[0][1]%></td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=7 height=17 style='height:12.75pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl42 style='height:12.75pt'>Dear sirs,</td>
  <td colspan=5></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=6 height=17 class=xl42 style='height:12.75pt'>We hereby place purchase order with
  following specified term and condition.</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=7 height=17 class=xl43 style='height:12.75pt'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>NO</td>
  <td class=xl25>P.NO</td>
  <td class=xl25>P.NAME</td>
  <td class=xl25>UNIT</td>
  <td class=xl25>Q'TY</td>
  <td class=xl25>ETD</td>
  <td class=xl25>REMARK</td>
 </tr>
 
 <% 
     SQL = "       select  v2.item_code, v2.item_name,  v1.PO_UOM_01 ";
     SQL = SQL + "      , v1.po_qty_01 , to_char(to_date(v1.ETA_TO,'yyyymmdd'),'dd/mm/yyyy'), v1.description  ";
     SQL = SQL + " from prod.PO_PO_D v1, comm.TCO_ITEM v2  ";
     SQL = SQL + " where v1.del_if=0 ";
     SQL = SQL + "      and v2.del_if=0 ";
     SQL = SQL + "      and v1.PO_ITEM_PK = v2.pk ";
     SQL = SQL + "      and PO_PO_M_PK = '" + l_po_pk.GetValue(i) + "' ";

     DataTable dt2 = ESysLib.TableReadOpen(SQL);
     Double sum_qty = 0;
     for (int j = 0; j < dt2.Rows.Count; j++)
     {
	%>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt' x:num><%= j + 1%></td>
  <td class=xl28><%=dt2.Rows[j][0]%></td>
  <td class=xl28><%=dt2.Rows[j][1]%></td>
  <td class=xl29><%=dt2.Rows[j][2]%></td>
  <td class=xl30 x:num><%=dt2.Rows[j][3]%></td>
  <td class=xl29><%=dt2.Rows[j][4]%></td>
  <td class=xl28><%=dt2.Rows[j][5]%></td>
 </tr>
 <%
       
     sum_qty = sum_qty + Double.Parse(dt2.Rows[j][3] + "");

 } //for loop end
 %>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl44 style='height:12.75pt'>&nbsp;</td>
  <td class=xl35>TOTAL:</td>
  <td></td>
  <td class=xl36 x:num><%= sum_qty%></td>
  <td colspan=2 class=xl44>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl42 style='height:12.75pt'>REMARK:</td>
  <td colspan=5></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=7 height=17 style='height:12.75pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl45 style='height:25.5pt' x:num>1</td>
  <td colspan=6 class=xl46>Kindly acknowledge receipt acceptance of the above
  PO(s) by RETURN FAX WITHIN 1 WORKING DAY from</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl46 style='height:12.75pt'>this FAX (Otherwise
  consider accepted)</td>
  <td colspan=4></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl37 style='height:12.75pt' x:num>2</td>
  <td colspan=6 class=xl46>The ETD day is the above mentioned, please also
  inform earlier of any changes within the above time</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl45 style='height:25.5pt' x:num>3</td>
  <td colspan=6 class=xl46>Right after your delivery, please fax the Invoice,
  Packing list and B/L. The original will be sent by email express</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl46 style='height:12.75pt'>(DHL) to our
  company as the above address</td>
  <td colspan=4></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl37 style='height:12.75pt' x:num>4</td>
  <td colspan=2 class=xl46>Please notice our PO Number in your tax invoice</td>
  <td colspan=4></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl37 style='height:12.75pt' x:num>5</td>
  <td colspan=2 class=xl47>Payment term:</td>
  <td colspan=4><%= dt1.Rows[0][2]%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=2 class=xl47>Delivery term:</td>
  <td colspan=4><%= dt1.Rows[0][3]%></td>
 </tr>
 <tr height=34 style='height:25.5pt;mso-xlrowspan:2'>
  <td height=34 colspan=7 style='height:25.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 colspan=7 style='height:12.75pt;mso-ignore:colspan'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= l_cmp_short%>. Prepaired by&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%= l_cmp_short%>. Approved
  by&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Confirmed by</td>
 </tr>
 <tr height=102 style='height:76.5pt;mso-xlrowspan:6'>
  <td height=102 colspan=7 style='height:76.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 colspan=6 style='height:12.75pt;mso-ignore:colspan'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ms. NGUYEN THI DIEM KHANH
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mr. JIN NAM JOO</td>
  <td></td>
 </tr>
 <%
     }
  //For Loop i end
 %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=39 style='width:29pt'></td>
  <td width=161 style='width:121pt'></td>
  <td width=150 style='width:113pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=122 style='width:92pt'></td>
 </tr>
 <![endif]>
</table>

</body>
</html>
