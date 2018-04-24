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
    string ls_tac_crca_pk = Request["tac_crca_pk"]; 
    string SQLInvDate = "";
    string l_invdate = "";
    SQLInvDate = "select i.item from tac_crcaditem i, tac_abitem t where i.tac_crca_pk = '" + ls_tac_crca_pk + "' and i.del_if = 0 and i.tac_abitem_pk = t.pk and t.del_if = 0 and t.item_nm = 'INVOICE DATE'";
    DataTable dtInvDate = new DataTable();
    dtInvDate = ESysLib.TableReadOpen(SQLInvDate);
    if (dtInvDate.Rows.Count > 0)
    {
        l_invdate = dtInvDate.Rows[0][0].ToString();
    }
string SQL
	= "select c.phone_no, substr('" + l_invdate + "', 7, 2) inv_date_dd, substr('" + l_invdate + "', 5, 2) inv_date_mm, substr('" + l_invdate + "', 3, 2) inv_date_yyyy, " +
        "     upper(p.partner_name) partner_name, upper(p.addr1) addr1, p.phone_no phone_no_cust, " +
        "     (select i.item from tac_crcaditem i, tac_abitem t where i.tac_crca_pk like '" + ls_tac_crca_pk + "' and i.del_if = 0 and i.tac_abitem_pk = t.pk and t.del_if = 0 and t.item_nm = 'CONTRACT NO' ) contract_no, " +
        "      (select i.item from tac_crcaditem i, tac_abitem t where i.tac_crca_pk like '" + ls_tac_crca_pk + "' and i.del_if = 0 and i.tac_abitem_pk = t.pk and t.del_if = 0 and t.item_nm = 'CONTRACT DATE' ) contract_date, " +
        "      (select i.item from tac_crcaditem i, tac_abitem t where i.tac_crca_pk like '" + ls_tac_crca_pk + "' and i.del_if = 0 and i.tac_abitem_pk = t.pk and t.del_if = 0 and t.item_nm = 'PAYMENT METHOD' ) pay_method, " +
        "      (select i.item from tac_crcaditem i, tac_abitem t where i.tac_crca_pk like '" + ls_tac_crca_pk + "' and i.del_if = 0 and i.tac_abitem_pk = t.pk and t.del_if = 0 and t.item_nm = 'PLACE OF DELIVERY' ) plc_delivery, " +
        "      (select i.item from tac_crcaditem i, tac_abitem t where i.tac_crca_pk like '" + ls_tac_crca_pk + "' and i.del_if = 0 and i.tac_abitem_pk = t.pk and t.del_if = 0 and t.item_nm = 'PLACE OF DESTINATION' ) plc_dest, " +
        "      (select i.item from tac_crcaditem i, tac_abitem t where i.tac_crca_pk like '" + ls_tac_crca_pk + "' and i.del_if = 0 and i.tac_abitem_pk = t.pk and t.del_if = 0 and t.item_nm = 'BILL OF LADING NO' ) bill_of_lading, " +
        "      (select i.item from tac_crcaditem i, tac_abitem t where i.tac_crca_pk like '" + ls_tac_crca_pk + "' and i.del_if = 0 and i.tac_abitem_pk = t.pk and t.del_if = 0 and t.item_nm = 'CONTAINER NO' ) container_no, " +
        "      (select i.item from tac_crcaditem i, tac_abitem t where i.tac_crca_pk like '" + ls_tac_crca_pk + "' and i.del_if = 0 and i.tac_abitem_pk = t.pk and t.del_if = 0 and t.item_nm = 'SHIPPER' ) shipper,       " +
        " a.tr_rate, a.tr_ccy,  a.invoice_no, to_char(to_date(a.invoice_date, 'YYYYMMDD'), 'DD/MM/YYYY') invoice_date " +
        "      from comm.tco_company c, tac_crca a, comm.tco_buspartner p " +
        "where a.pk like '" + ls_tac_crca_pk + "' " +
        "and a.del_if = 0 " +
        "and a.tco_company_pk = c.pk " +
        "and c.del_if = 0 " +
        "and a.tco_buspartner_pk = p.pk " +
        "and p.del_if = 0 " ;
DataTable dtMst = new DataTable();
dtMst = ESysLib.TableReadOpen(SQL);
        
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="mau%20hdxk_gtgt_files/filelist.xml">
<link rel=Edit-Time-Data href="mau%20hdxk_gtgt_files/editdata.mso">
<link rel=OLE-Object-Data href="mau%20hdxk_gtgt_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>vinacom</o:Author>
  <o:LastAuthor>MS LOAN</o:LastAuthor>
  <o:LastPrinted>2011-05-05T02:57:26Z</o:LastPrinted>
  <o:Created>2010-10-27T06:42:45Z</o:Created>
  <o:LastSaved>2011-05-05T03:05:50Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .25in 0in .7in;
	mso-header-margin:.5in;
	mso-footer-margin:0in;}
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
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:right;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:right;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl40
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl41
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl42
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00000";}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	vertical-align:middle;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;}
.xl48
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;}
.xl51
	{mso-style-parent:style0;
	font-size:10.5pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl54
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";}
	
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>XK</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>21</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>37</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
       <x:RangeSelection>$E$38:$J$38</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9975</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=623 style='border-collapse:
 collapse;table-layout:fixed;width:468pt'>
 <col class=xl24 width=37 style='mso-width-source:userset;mso-width-alt:1353;
 width:28pt'>
 <col class=xl24 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl24 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <col class=xl24 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl24 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl24 width=48 style='mso-width-source:userset;mso-width-alt:1755;
 width:36pt'>
 <col class=xl24 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 class=xl24 width=37 style='height:7.5pt;width:28pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=93 style='width:70pt'></td>
  <td class=xl24 width=73 style='width:55pt'></td>
  <td class=xl24 width=55 style='width:41pt'></td>
  <td class=xl24 width=65 style='width:49pt'></td>
  <td class=xl24 width=89 style='width:67pt'></td>
  <td class=xl24 width=51 style='width:38pt'></td>
  <td class=xl24 width=48 style='width:36pt'></td>
  <td class=xl24 width=33 style='width:25pt'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 colspan=10 class=xl24 style='height:20.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=10 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl25 colspan=2 style='height:17.25pt;mso-ignore:colspan'
  x:str="                  "><span
  style='mso-spacerun:yes'>                  </span></td>
  <td class=xl25></td>
  <td class=xl26><span style='mso-spacerun:yes'>      </span><%=dtMst.Rows[0][1].ToString() %></td>
  <td class=xl27 x:str="      "><span style='mso-spacerun:yes'>      </span></td>
  <td class=xl28><%=dtMst.Rows[0][2].ToString() %></td>
  <td class=xl29><span style='mso-spacerun:yes'>            </span><%=dtMst.Rows[0][3].ToString() %></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl25 style='height:25.5pt' x:str="      "><span
  style='mso-spacerun:yes'>      </span></td>
  <td colspan=9 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 colspan=10 class=xl25 style='height:20.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl25 style='height:20.25pt' x:str="      "><span
  style='mso-spacerun:yes'>      </span></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl30 x:num></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl31 colspan=3 style='height:19.5pt;mso-ignore:colspan' x:str><span
  style='mso-spacerun:yes'>                                  </span></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl54 colspan=7 style='height:21.0pt;mso-ignore:colspan' x:str><span
  style='mso-spacerun:yes'>                                                                      
  </span><%=dtMst.Rows[0][4].ToString() %></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl54 colspan=7 style='height:19.5pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>                                 </span><%=dtMst.Rows[0][5].ToString() %></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl25 style='height:17.25pt' x:str="      "><span
  style='mso-spacerun:yes'>      </span></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl25 align=right x:num></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 colspan=3 class=xl25 style='height:16.5pt;mso-ignore:colspan'></td>
  <td class=xl25 align=right x:str>Số TK <%=dtMst.Rows[0][17].ToString() %> ngày <%=dtMst.Rows[0][18].ToString()%></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
   <% 
      string ls_cont_dd = "", ls_cont_mm = "", ls_cont_yy = "", ls_cont_date = "";
      ls_cont_date = dtMst.Rows[0][8].ToString();
      if (ls_cont_date.Length == 8)
      {
          ls_cont_dd = ls_cont_date.Substring(6, 2);
          ls_cont_mm = ls_cont_date.Substring(4, 2);
          ls_cont_yy = ls_cont_date.Substring(0, 4);
      }          
  %>

 <tr class=xl25 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=3 class=xl25 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl25 align=right x:str><%=dtMst.Rows[0][7].ToString() %></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl32><span style='mso-spacerun:yes'>        </span><%=ls_cont_dd %></td>
  <td class=xl33><%=ls_cont_mm %></td>
  <td class=xl34><%=ls_cont_yy %></td>
 </tr>
 <tr class=xl25 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=4 class=xl25 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl25><%=dtMst.Rows[0][9].ToString()%></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=4 class=xl25 style='height:17.25pt;mso-ignore:colspan'></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'><%=dtMst.Rows[0][10].ToString()%></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=4 class=xl25 style='height:17.25pt;mso-ignore:colspan'></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'><%=dtMst.Rows[0][11].ToString()%></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=4 class=xl25 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl31 colspan=2 style='mso-ignore:colspan' x:str><%=dtMst.Rows[0][12].ToString()%></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=5 height=22 class=xl33 style='height:16.5pt'><span
  style='mso-spacerun:yes'>                                              
  </span><%=dtMst.Rows[0][13].ToString()%></td>
  <td class=xl25></td>
  <td colspan=4 class=xl32><span
  style='mso-spacerun:yes'>                         </span><%=dtMst.Rows[0][14].ToString()%></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl35 style='height:18.0pt'></td>
  <td colspan=3 class=xl36></td>
  <td colspan=3 class=xl36 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl36></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl37 style='height:15.0pt'></td>
  <td colspan=3 class=xl38></td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl38></td>
 </tr>
 <tr height=21 style='height:16.75pt'>
  <td height=21 class=xl39 style='height:16.75pt'></td>
  <td colspan=3 class=xl39></td>
  <td colspan=3 class=xl39 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl39></td>
 </tr>
  <tr class=xl25 height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 align=right style='height:17.1pt' x:num></td>
  <td colspan=3 class=xl40 x:str>Vỏ viên nang gelatin</td>
  <td class=xl40></td>
  <td class=xl41 align=right x:num></td>
  <td class=xl42 align=right x:num></td>
  <td colspan=3 class=xl47 x:num></td>
 </tr>
  <% 
     int i;
     SQL
        = "						select tbl_sum.item_name, tbl_sum.uom, round(tbl_sum.qty, 3) qty,  " +
            "									 decode(tbl_sum.tr_ccy, 'VND', to_char(round(tbl_sum.u_price, 5), '999,999,999,999'), to_char(round(tbl_sum.u_price, 5), '999,999,999,999.99999') ) uprice, " +
            "									 decode(tbl_sum.tr_ccy, 'VND', to_char(round(tbl_sum.net_tr_amt, 2), '999,999,999,999,999,999'), to_char(round(tbl_sum.net_tr_amt, 2), '999,999,999,999,999,999.99') ) net_tr_amt, " +
            "									 tbl_sum.item_desc, tbl_sum.sizea, tbl_sum.cap_color, tbl_sum.body_color, tbl_sum.tr_ccy, round(tbl_sum.net_tr_amt, 2) net_tr_amt_1, " +
            " to_char(round(tbl_sum.qty / 1000, 0), '999,999,999,999') qty_1 " +
            "						from ( " +
            "	                         select tbl.item_name, tbl.uom, tbl.qty qty, tbl.u_price,      " +
            "                           tbl.net_tr_amt net_tr_amt,  " +
            "                            tbl.item_desc, sf_get_sizea_sign(tbl.sizea) sizea, tbl.cap_color,      " +
            "                            tbl.body_color, tbl.tr_ccy   " +
            "          from (      " +
                            " select i.item_name, '1000Viên' uom, d.qty, (1000 * d.u_price) u_price, d.net_tr_amt, d.item_desc, i.size_code sizea, " +
                               " s1.color_code cap_color, s.color_code body_color, a.tr_ccy, d.order_no " +
                                " from tac_crcad d, comm.tco_item i, prod.tsh_color s, tac_crca a, prod.tsh_color s1 " +
                                " where d.del_if = 0 " +
                                " and a.del_if = 0 " +
                                " and i.del_if = 0 " +
                                " and d.tco_item_pk = i.pk " +
                                " and s.pk = i.body_color_pk " +
                                " and s1.pk = i.cap_color_pk " +
                                " and d.tac_crca_pk    = a.pk " +
                                " and d.tac_crca_pk =  '" + ls_tac_crca_pk + "' " +
            "      ) tbl                                              " +
            "                                                            ) tbl_sum  ";
     DataTable dtDtl = new DataTable();
     dtDtl = ESysLib.TableReadOpen(SQL);
     decimal l_tot_net_tr = 0, l_tot_net_bk = 0;
    for(i = 0; i < dtDtl.Rows.Count ; i++)
    {
        l_tot_net_tr += decimal.Parse(dtDtl.Rows[i][10].ToString());
            
 %>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 align=right style='height:17.1pt' x:num><%= i + 1 %></td>
  <td colspan=3 class=xl40 x:str>Size <%=dtDtl.Rows[i][6].ToString() %></td>
  <td class=xl40>1000 Viên</td>
  <td class=xl41 align=right x:num><%=dtDtl.Rows[i][11].ToString() %></td>
  <td class=xl42 align=right x:num><%=dtDtl.Rows[i][3].ToString() %></td>
  <td colspan=3 class=xl47 x:num><%=dtDtl.Rows[i][10].ToString() %></td>
 </tr>
<% 
    }
    for (i = dtDtl.Rows.Count; i < 10; i++)
    {    
%>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 align=right style='height:17.1pt' x:num></td>
  <td colspan=3 class=xl40 x:str></td>
  <td class=xl40></td>
  <td class=xl41 align=right x:num></td>
  <td class=xl42 align=right x:num></td>
  <td colspan=3 class=xl47 x:num></td>
 </tr>
<% 
}
%>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td colspan=3 class=xl39 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl53 align="right"></td>
  <td colspan=1 class=xl53 align="right">(<%=dtMst.Rows[0][16].ToString() %>)</td>
  <td colspan=2 class=xl49 x:num><%=l_tot_net_tr %></td>
 </tr>
 <% 
     decimal l_tot_bk_amt = 0;     
    SQL = "select round(nvl(sum(d.net_bk_amt), 0), 0) from tac_crcad d where d.tac_crca_pk like '" + ls_tac_crca_pk + "' and d.del_if = 0 ";
    DataTable dtSum = ESysLib.TableReadOpen(SQL);
    if(dtSum.Rows.Count > 0)
    {
        l_tot_bk_amt = decimal.Parse(dtSum.Rows[0][0].ToString());              
    }        
     
 %> 
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=2 class=xl24 style='height:19.5pt;mso-ignore:colspan'></td>
  <td class=xl43 align=right x:num><%=dtMst.Rows[0][15].ToString() %></td>
  <td class=xl24></td>
  <td colspan=3 class=xl39></td>
  <td colspan=3 class=xl50 x:num><%=l_tot_bk_amt %></td>
 </tr>
 <tr class=xl44 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl44 style='height:23.25pt'></td>
  <td colspan=8 rowspan=2 class=xl51 width=553 style='width:415pt' <span style='mso-spacerun:yes'>
                                                                     </span>                                                            <span
  style='mso-spacerun:yes'>                                                        
        </span><%=CommondLib.Num2VNText(l_tot_net_tr.ToString(), "USD") %> / <%=CommondLib.Num2EngText(l_tot_net_tr.ToString(), "USD") %> <span
  style='mso-spacerun:yes'>                                                           </span></td>
  <td class=xl45></td>
 </tr>
 <tr class=xl44 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl46 style='height:19.5pt'></td>
  <td class=xl45></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=3 height=22 class=xl39 style='height:16.5pt'></td>
  <td class=xl24></td>
  <td colspan=6 class=xl39></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=3 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl37></td>
  <td colspan=6 class=xl39></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl38></td>
  <td colspan=4 class=xl39></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 colspan=3 class=xl24 style='height:13.5pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl38></td>
  <td colspan=4 class=xl38></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 colspan=10 class=xl24 style='height:13.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=10 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 colspan=10 class=xl24 style='height:22.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=10 height=17 class=xl52 style='height:12.75pt'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=10 height=19 class=xl52 style='height:14.25pt'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=37 style='width:28pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=33 style='width:25pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
