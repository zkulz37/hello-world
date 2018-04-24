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
string l_total_nett = "";
string l_totalt = "" ;      
string lrsAPRegister = "";
string lsSQLMaster = "", lsSQLDetail = "", SQL = "";
string llID = "";
int i, liRows ;
//---------------------AR Master PK
string idPK = Request["idPK_1"];        
//-------------------- AR Master Info
string l_pay_method = "", l_vat_rate = "", lsCCY = "";
string l_invoice_date = "", l_invoice_no = "", l_partner_name = "", l_addr = "" ;
string l_tax_code = "";    

lsSQLMaster = "select i.item pay_method from tac_crcaditem i where i.tac_crca_pk like '" + idPK + "' ";
lsSQLMaster += "and i.del_if = 0 and i.tac_abitem_pk = (select a.pk from tac_abitem a where a.item_nm = 'PAYMENT METHOD' and a.del_if = 0)";
DataTable dtPay = new DataTable();
dtPay = ESysLib.TableReadOpen( lsSQLMaster );
if(dtPay.Rows.Count > 0)
{
    l_pay_method = dtPay.Rows[0][0].ToString();           
}
SQL = "select i.item vat_rate from tac_crcaditem i " ;
SQL += " where i.tac_crca_pk like '" + idPK + "' ";
SQL += "and i.del_if = 0 ";
SQL += "and i.tac_abitem_pk =(select a.pk from tac_abitem a where a.item_nm = 'TAX RATE' and a.del_if = 0)";
DataTable dtVAT = new DataTable();
dtVAT = ESysLib.TableReadOpen( SQL );
if(dtVAT.Rows.Count > 0)
{
    l_vat_rate = dtVAT.Rows[0][0].ToString();
}
SQL = " select a.serial_no, invoice_no, to_char(to_date(a.invoice_date, 'YYYYMMDD'), 'DD/MM/YYYY') invoice_date, c.partner_name, c.addr1, c.tax_code, null pay_method, ";
SQL += "null vat_rate, a.tr_ccy, to_char((select sum(d.net_tr_amt) from tac_crcad d where d.tac_crca_pk = a.pk and d.del_if = 0), '999,999,999.99') total_net_tr_amt , to_char(decode(a.order_ccy, 'USD', nvl(a.order_trrate, 0), nvl(a.tr_rate, 0)), '999,999') tr_rate, a.tot_net_bk_amt, a.tot_vat_tr_amt, a.tot_vat_bk_amt ";   
SQL += "from tac_crca a, comm.tco_buspartner c ";
SQL += "where a.pk like '" + idPK + "' ";
SQL += "and a.tco_buspartner_pk = c.pk ";
SQL += "and c.del_if = 0 and a.del_if = 0 ";
        
DataTable lrs1 = new DataTable();
lrs1 = ESysLib.TableReadOpen(SQL);

SQL = "select d.pk, i.item_name, (SELECT A.UOM_NM FROM COMM.TCO_UOM A WHERE A.UOM_CODE = d.item_uom AND A.DEL_IF = 0) item_uom, to_char(d.qty, '999,999,999.999'), to_char(nvl(d.u_price, 0), '999,999,999.999') u_price, to_char(nvl(d.net_tr_amt, 0), '999,999,999,999.99') net_tr_amt, d.remark, d.net_tr_amt, d.net_bk_amt, d.VAT_BK_AMT ";
SQL += "from comm.tco_item i, tac_crcad d ";
SQL += "where d.tac_crca_pk = '" + idPK + "' ";
SQL += " and d.tco_item_pk = i.pk(+) ";
SQL += "and d.del_if = 0 ";
SQL += "and i.del_if(+)  = 0 ";
SQL += "order by d.pk ";        

DataTable lrs2 = new DataTable();
lrs2 = ESysLib.TableReadOpen(SQL);
if(lrs1.Rows.Count > 0)
{
    lsCCY = lrs1.Rows[0][8].ToString();               
}
// total amount of invoice
decimal l_total = 0;
if (lrs1.Rows.Count > 0)
{
    if (lrs1.Rows[0][3].ToString() != "")
    {
        l_partner_name = lrs1.Rows[0][3].ToString();
    }
    else
    {
        l_partner_name = "";    
    }
    if (lrs1.Rows[0][4].ToString() != "")
    {
        l_addr = lrs1.Rows[0][4].ToString();
    }
    else
    {
        l_addr = "";
    }
    if (lrs1.Rows[0][5].ToString() != "")
    {
        l_tax_code = lrs1.Rows[0][5].ToString();
    }
    else
    {
        l_tax_code = "";
    }

    if (lrs1.Rows[0][11].ToString() != "")
    {
        l_total += decimal.Parse(lrs1.Rows[0][11].ToString());            
    }
    if (lrs1.Rows[0][13].ToString() != "")
    {
        l_total += decimal.Parse(lrs1.Rows[0][13].ToString());            
    }
}        
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="invoiceakvina_files/filelist.xml">
<link rel=Edit-Time-Data href="invoiceakvina_files/editdata.mso">
<link rel=OLE-Object-Data href="invoiceakvina_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Jjangnet Computer</o:Author>
  <o:LastAuthor>Le Huu Phuc</o:LastAuthor>
  <o:LastPrinted>2011-11-21T06:21:21Z</o:LastPrinted>
  <o:Created>2004-11-01T07:34:36Z</o:Created>
  <o:LastSaved>2011-11-21T08:30:06Z</o:LastSaved>
  <o:Company>Jjangnet Computer</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.7in 0in 0in .1in;
	mso-header-margin:.5in;
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
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times, sans-serif;
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
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times, sans-serif;
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
	font-size:9.0pt;}
.xl66
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:left;}
.xl67
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:right;}
.xl68
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl69
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl70
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl71
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl72
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:right;}
.xl73
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	text-align:left;
	vertical-align:middle;}
.xl76
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;}
.xl77
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:left;
	vertical-align:middle;}
.xl78
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;}
.xl79
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	text-align:right;
	vertical-align:middle;}
.xl80
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl82
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;}
.xl84
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:top;}
.xl85
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:top;}
.xl86
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl87
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl88
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl89
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:left;}
.xl90
	{mso-style-parent:style0;
	font-size:9.0pt;
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl92
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;}
.xl93
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl94
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl95
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl96
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>VAT Invoice</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>240</x:DefaultRowHeight>
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
       <x:ActiveRow>1</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
       <x:RangeSelection>$B$2:$L$2</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9015</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1500</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl65>

<table x:str border=0 cellpadding=0 cellspacing=0 width=776 style='border-collapse:
 collapse;table-layout:fixed;width:584pt'>
 <col class=xl65 width=29 style='mso-width-source:userset;mso-width-alt:928;
 width:22pt'>
 <col class=xl65 width=41 style='mso-width-source:userset;mso-width-alt:1312;
 width:31pt'>
 <col class=xl65 width=125 style='mso-width-source:userset;mso-width-alt:4000;
 width:94pt'>
 <col class=xl65 width=64 style='mso-width-source:userset;mso-width-alt:2048;
 width:48pt'>
 <col class=xl65 width=84 style='mso-width-source:userset;mso-width-alt:2688;
 width:63pt'>
 <col class=xl65 width=60 style='mso-width-source:userset;mso-width-alt:1920;
 width:45pt'>
 <col class=xl66 width=50 style='mso-width-source:userset;mso-width-alt:1600;
 width:38pt'>
 <col class=xl67 width=79 style='mso-width-source:userset;mso-width-alt:2528;
 width:59pt'>
 <col class=xl67 width=45 style='mso-width-source:userset;mso-width-alt:1440;
 width:34pt'>
 <col class=xl66 width=82 style='mso-width-source:userset;mso-width-alt:2624;
 width:62pt'>
 <col class=xl66 width=34 style='mso-width-source:userset;mso-width-alt:1088;
 width:26pt'>
 <col class=xl65 width=83 style='mso-width-source:userset;mso-width-alt:2656;
 width:62pt'>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl65 width=29 style='height:27.0pt;width:22pt'></td>
  <td colspan=11 class=xl94 width=747 style='width:562pt'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl65 style='height:18.0pt'></td>
  <td colspan=11 class=xl95></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl65 style='height:17.1pt'></td>
  <td colspan=11 class=xl94></td>
 </tr>
 <tr height=61 style='mso-height-source:userset;height:45.75pt'>
  <td height=61 class=xl65 style='height:45.75pt'></td>
  <td colspan=11 class=xl69></td>
 </tr>
 <tr class=xl68 height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 colspan=6 class=xl68 style='height:23.1pt;mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl72><%=lrs1.Rows[0][2]%></td>
 </tr>
 <tr class=xl73 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 colspan=3 class=xl73 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=9 class=xl93 width=581 style='width:437pt'><%=l_partner_name%></td>
 </tr>
 <tr class=xl68 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 colspan=3 class=xl68 style='height:13.5pt;mso-ignore:colspan'></td>
  <td class=xl68 colspan=6 style='mso-ignore:colspan'>&nbsp;&nbsp;<%=l_addr %></td>
  <td class=xl68></td>
  <td class=xl70></td>
  <td class=xl68></td>
 </tr>
 <tr class=xl68 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 colspan=3 class=xl68 style='height:13.5pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl70>&nbsp;&nbsp;<%=l_tax_code%></td>
  <td class=xl68></td>
  <td class=xl70></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl68></td>
 </tr>
 <tr height=46 style='mso-height-source:userset;height:34.5pt'>
  <td height=46 class=xl65 style='height:34.5pt'></td>
  <td class=xl69></td>
  <td colspan=4 class=xl69></td>
  <td class=xl70></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl69></td>
 </tr>
  <% 
     decimal n, l_total_net_bk_amt = 0, l_total_vat_bk_amt = 0 ;
     string ls_format_show = "", ls_format_1 = "", ls_format_2 = "";
     int j;
     n = 11; //  dòng trống
     for (i = 0; i < lrs2.Rows.Count; i++)
     {
         if (lrs2.Rows[i][8].ToString() != "")
         {
             l_total_net_bk_amt += decimal.Parse(lrs2.Rows[i][8].ToString());
         }
         if (lrs2.Rows[i][9].ToString() != "")
         {
             l_total_vat_bk_amt += decimal.Parse(lrs2.Rows[i][9].ToString());
         }                      
 %>
 
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl65 style='height:20.1pt'></td>
  <td class=xl74 x:num><%=i + 1%></td>
  <td colspan=4 class=xl75><%=lrs2.Rows[i][1].ToString()%></td> <!-- Item Name -->
  <td class=xl76><%=lrs2.Rows[i][2].ToString()%></td> <!--  UOM -->
  <%
     if (lrs2.Rows[i][3].ToString() != "")
     {
         ls_format_show = lrs2.Rows[i][3].ToString();
         j = ls_format_show.IndexOf(".");
         if (j > 0)
         {
             ls_format_1 = ls_format_show.Substring(0, j);
             //ls_format_1 = ls_format_1.Replace(",", ".");
             ls_format_2 = ls_format_show.Substring(j + 1);
             if (int.Parse(ls_format_2) > 0)
                 ls_format_show = ls_format_1 + "." + ls_format_2;
             else
                 ls_format_show = ls_format_1;
         }
         else
         {
             //ls_format_show = ls_format_show.Replace(",", ".");
         }
     }
     else
     {
         ls_format_show = "0";
     }
                    
  %>  
  <td class=xl77 style="mso-number-format:'\#\,\#\#0\.00';" x:num><%=ls_format_show%></td>
  <td class=xl78><%=lsCCY%></td>
   <%
     if (lrs2.Rows[i][4].ToString() != "")
     {
         ls_format_show = lrs2.Rows[i][4].ToString();
         j = ls_format_show.IndexOf(".");
         if (j > 0)
         {
             ls_format_1 = ls_format_show.Substring(0, j);
             //ls_format_1 = ls_format_1.Replace(",", ".");
             ls_format_2 = ls_format_show.Substring(j + 1);
             if (int.Parse(ls_format_2) > 0)
             {
                 if (int.Parse(ls_format_2) % 10 > 0)
                     ls_format_show = ls_format_1 + "." + ls_format_2;
                 else if (int.Parse(ls_format_2) % 100 > 0)
                     ls_format_show = ls_format_1 + "." + ls_format_2.Substring(0, 2);
                 else if (int.Parse(ls_format_2) % 1000 > 0)
                     ls_format_show = ls_format_1 + "." + ls_format_2.Substring(0, 1);
             }
             else
             {
                 ls_format_show = ls_format_1;
             }
         }
         else
         {
             //ls_format_show = ls_format_show.Replace(",", ".");
         }
     }
     else
     {
         ls_format_show = "0";
     }
                    
  %>    
  <td class=xl77 style="mso-number-format:'\#\,\#\#0\.00';" x:num><%=ls_format_show%></td> <!-- Unit Price -->
  <td class=xl79><%=lsCCY%></td>
   <%
     if (lrs2.Rows[i][5].ToString() != "")
     {
         ls_format_show = lrs2.Rows[i][5].ToString();
         j = ls_format_show.IndexOf(".");
         if (j > 0)
         {
             ls_format_1 = ls_format_show.Substring(0, j);
             //ls_format_1 = ls_format_1.Replace(",", ".");
             ls_format_2 = ls_format_show.Substring(j + 1);
             if (lsCCY == "VND")
             {
                 ls_format_show = ls_format_1;
             }
             else
             {
                 if (int.Parse(ls_format_2) > 0)
                     ls_format_show = ls_format_1 + "." + ls_format_2;
                 else
                     ls_format_show = ls_format_1;
             }
         }
         else
         {
             //ls_format_show = ls_format_show.Replace(",", ".");
         }
     }
     else
     {
         ls_format_show = "0";
     }
                    
  %>  
  <td class=xl80 align=right style="mso-number-format:'\#\,\#\#0';" x:num><%=lrs2.Rows[i][5].ToString()%></td>  <!-- Net Trans Amt -->  
 </tr>
 <% 
     }
     for (i = lrs2.Rows.Count; i < n; i++)
     {
 %>
 
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl65 style='height:20.1pt'></td>
  <td class=xl74></td>
  <td colspan=4 class=xl75></td>
  <td class=xl76></td>
  <td class=xl75></td>
  <td class=xl78></td>
  <td class=xl75></td>
  <td class=xl79></td>
  <td class=xl81></td>
 </tr>
 <% 
    }
 l_total = l_total_net_bk_amt + l_total_vat_bk_amt; 
 
 SQL = "select nvl('" + l_total + "', 0) total, nvl('" + l_total_vat_bk_amt + "', 0) total_vat_bk_amt, nvl('" + l_total_net_bk_amt + "', 0) total_net_bk_amt ";
SQL += "from dual ";
DataTable lrs3 = new DataTable();
lrs3 = ESysLib.TableReadOpen(SQL);
    if (lrs1.Rows[0][9].ToString() != "")
    {
        ls_format_show = lrs1.Rows[0][9].ToString();
        j = ls_format_show.IndexOf(".");
        if (j > 0)
        {
            ls_format_1 = ls_format_show.Substring(0, j);
            //ls_format_1 = ls_format_1.Replace(",", ".");
            ls_format_2 = ls_format_show.Substring(j + 1);
            if (lsCCY == "VND")
            {
                ls_format_show = ls_format_1;
            }
            else
            {
                if (int.Parse(ls_format_2) > 0)
                    ls_format_show = ls_format_1 + "." + ls_format_2;
                else
                    ls_format_show = ls_format_1;
            }
        }
        else
        {
            //ls_format_show = ls_format_show.Replace(",", ".");
        }
    }
    else
    {
        ls_format_show = "-";
    }
// total amount of invoice
  %>           
 <tr height=25 style='mso-height-source:userset;height:18.95pt'>
  <td height=25 colspan=6 class=xl65 style='height:18.95pt;mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td class=xl84><%=lsCCY%></td>
  <td class=xl85 style="mso-number-format:'\#\,\#\#0';" x:num><%=lrs1.Rows[0][9].ToString()%></td>
 </tr>
 
 <tr height=25 style='mso-height-source:userset;height:18.95pt'>
  <td height=25 class=xl65 style='height:18.95pt'></td>
  <td colspan=5 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
<% 
    if (decimal.Parse(lrs1.Rows[0][10].ToString()) > 1)
    { 
%>    
  <td colspan=2 class=xl71>VND/USD</td>
  <td class=xl86 style="mso-number-format:'\#\,\#\#0';" x:num><%=lrs1.Rows[0][10]%></td>
 <% 
    }
    else
    {
  %>  
  <td colspan=2 class=xl71></td>
  <td class=xl86 style="mso-number-format:'\#\,\#\#0';" x:num></td>
  <% 
    }
  %>    
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.95pt'>
  <td height=37 class=xl65 style='height:27.95pt'></td>
  <td class=xl87></td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=2 class=xl88 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl65></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl65 style='height:18.0pt'></td>
  <td colspan=5 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td class=xl71>VND</td>
  <td class=xl86 style="mso-number-format:'\#\,\#\#0';" x:num><%=lrs3.Rows[0][2].ToString() %></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl65 style='height:30.0pt'></td>
  <td class=xl87></td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td colspan=2 class=xl88 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl65></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl65 style='height:18.0pt'></td>
  <td colspan=3 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl89><%=l_vat_rate%></td>
  <td class=xl68></td>
  <td class=xl70></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td class=xl71>VND</td>
  <td class=xl86 style="mso-number-format:'\#\,\#\#0';" x:num><%=lrs3.Rows[0][1].ToString() %></td> <!-- Total VAT Books -->
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl65 style='height:27.0pt'></td>
  <td class=xl87></td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td colspan=2 class=xl88 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl65></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl65 style='height:18.0pt'></td>
  <td colspan=5 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td class=xl71>VND</td>
  <td class=xl86 style="mso-number-format:'\#\,\#\#0';" x:num><%=lrs3.Rows[0][0].ToString() %></td> <!--Total Net Books-->
 </tr>
 <tr class=xl90 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=34 class=xl90 style='height:26.1pt'></td>
  <td colspan=4 class=xl91 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl96 width=433 style='width:326pt'><%=CommondLib.Num2VNText(l_total.ToString(), "VND")%></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl65 style='height:20.1pt'></td>
  <td colspan=5 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td colspan=2 class=xl88 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl92></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl65 style='height:18.0pt'></td>
  <td class=xl87></td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl87></td>
  <td class=xl68></td>
  <td class=xl70></td>
  <td colspan=2 class=xl88 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl65></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=6 class=xl65 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=2 class=xl67 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl66 style='mso-ignore:colspan'></td>
  <td class=xl65></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=6 class=xl65 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=2 class=xl67 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl66 style='mso-ignore:colspan'></td>
  <td class=xl65></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=6 class=xl65 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=2 class=xl67 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl66 style='mso-ignore:colspan'></td>
  <td class=xl65></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=6 class=xl65 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=2 class=xl67 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl66 style='mso-ignore:colspan'></td>
  <td class=xl65></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=6 class=xl65 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=2 class=xl67 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl66 style='mso-ignore:colspan'></td>
  <td class=xl65></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=29 style='width:22pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=34 style='width:26pt'></td>
  <td width=83 style='width:62pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
