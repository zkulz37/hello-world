<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("sale");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string strSQL = @"SELECT partner_name, addr1, phone_no, fax_no, tax_code, tco_bpphoto_pk
                      FROM comm.tco_company
                      WHERE del_if = 0 AND pk = (SELECT MAX (pk)
                                                 FROM comm.tco_company
                                                 WHERE del_if = 0 AND active_yn = 'Y')";
    string p_from_dt = Request.QueryString["p_from_dt"];
    string p_to_dt = Request.QueryString["p_to_dt"];
    string p_partner = Request.QueryString["p_partner"];
    string p_slip_ref_no = Request.QueryString["p_slip_ref_no"];
    string p_bal_yn = Request.QueryString["p_bal_yn"];
    string para = "'" + p_from_dt + "','" + p_to_dt + "','" + p_partner + "','" + p_slip_ref_no + "','" + p_bal_yn + "'";
    DataTable dt, dt1;
    dt = ESysLib.TableReadOpen(strSQL);
    dt1 = ESysLib.TableReadOpenCursor("SALE.sp_rpt_dsap00050", para);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_dsap00050_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_dsap00050_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_dsap00050_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Server_Test</o:LastAuthor>
  <o:LastPrinted>2011-07-06T06:59:58Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-07-06T08:10:41Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P of &N";
	margin:.1in .25in .25in .25in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
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
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl30
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
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
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
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	color:red;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	color:blue;
	font-size:24.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
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
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
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
  <x:WindowHeight>9300</x:WindowHeight>
  <x:WindowWidth>15135</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1025"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1021 style='border-collapse:
 collapse;table-layout:fixed;width:766pt'>
 <col class=xl24 width=133 style='mso-width-source:userset;mso-width-alt:4864;
 width:100pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl24 width=58 style='mso-width-source:userset;mso-width-alt:2121;
 width:44pt'>
 <col class=xl24 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=109 span=2 style='mso-width-source:userset;mso-width-alt:
 3986;width:82pt'>
 <col class=xl24 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl24 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl24 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl24 width=87 style='mso-width-source:userset;mso-width-alt:3181;
 width:65pt'>
 <!--[if gte vml 1]><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:1.5pt;margin-top:1.5pt;width:78pt;height:42pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]-->
 <tr height=60 style='mso-height-source:userset;height:45.0pt'>
  <td colspan=12 height=60 class=xl39 width=1021 style='height:45.0pt;
  width:766pt'>Payment Balance Checking</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl25 style='height:16.5pt'></td>
  <td class=xl26 colspan=3 style='mso-ignore:colspan'>Request Date: <%=System.DateTime.ParseExact(p_from_dt, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%>
                ~
                <%=System.DateTime.ParseExact(p_to_dt, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26 colspan=3 style='mso-ignore:colspan'>Print Date: <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl27 style='height:18.75pt'>Partner Name</td>
  <td class=xl28>Rea Date</td>
  <td class=xl28>Ref No</td>
  <td class=xl28>Slip No</td>
  <td class=xl28>Item Amount</td>
  <td class=xl28>Vat Amount</td>
  <td class=xl28>Total Amount</td>
  <td class=xl28>Pay Amount</td>
  <td class=xl28>Bal Amount</td>
  <td class=xl28>CCY</td>
  <td class=xl28>Ex Rate</td>
  <td class=xl28>Payment Desc</td>
 </tr>
 <%
            Decimal total_amount = 0;
            Decimal pay_amount = 0;
            Decimal bal_amount = 0;
            
            string strPartner = string.Empty;
            int[] arrPartner_count = new int[dt1.Rows.Count];
            int a = 0;
            int strPartner_count = 1;

            for (int y = 0; y < dt1.Rows.Count; y++)
            {
                if (strPartner == string.Empty)
                {
                    strPartner = dt1.Rows[y]["partner_name"].ToString();
                    strPartner_count = 1;
                }
                else
                {
                    if (!dt1.Rows[y]["partner_name"].ToString().Trim().Equals(strPartner.Trim()))
                    {
                        arrPartner_count[a] = strPartner_count;
                        strPartner_count = 1;
                        a++;
                        strPartner = dt1.Rows[y]["partner_name"].ToString();
                    }
                    else
                    {
                        strPartner_count++;
                    }
                }
            }
            arrPartner_count[a] = strPartner_count;
            a = 0;
            strPartner = string.Empty;
            //-----------
            for (int i = 0; i < dt1.Rows.Count; i++)
            {
        %>
        <%
            if (!strPartner.Equals(dt1.Rows[i]["partner_name"].ToString()))
            {
        %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan="<%=arrPartner_count[a]%>" height=20 class=xl29 width=133 style='height:15.0pt;width:100pt'><%= dt1.Rows[i]["partner_name"]%></td>
  <% 
                strPartner = dt1.Rows[i]["partner_name"].ToString();
                a++;
            }
            %>
  <td class=xl30><%=System.DateTime.ParseExact(dt1.Rows[i]["req_date"].ToString(), "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%></td>
  <td class=xl31><%= dt1.Rows[i]["ref_no"]%></td>
  <td class=xl32 align=right x:num><%= dt1.Rows[i]["slip_no"]%></td>
  <td class=xl33 align=right x:num=><%= dt1.Rows[i]["item_amount"]%></td>
  <td class=xl33 align=right x:num><%= dt1.Rows[i]["vat_amount"]%></td>
  <td class=xl34 align=right x:num><%= dt1.Rows[i]["total_amount"]%></td>
  <td class=xl34 align=right x:num><%= dt1.Rows[i]["pay_amount"]%></td>
  <td class=xl35 align=right x:num><%= dt1.Rows[i]["bal_amount"]%></td>
  <td class=xl30><%= dt1.Rows[i]["tr_ccy"]%></td>
  <td class=xl32 align=right x:num><%= dt1.Rows[i]["ex_rate"]%></td>
  <td class=xl32><%= dt1.Rows[i]["payment_desc"]%></td>
 </tr>
 <%
     total_amount += Convert.ToDecimal(dt1.Rows[i]["total_amount"]);
     pay_amount += Convert.ToDecimal(dt1.Rows[i]["pay_amount"]);
     bal_amount += Convert.ToDecimal(dt1.Rows[i]["bal_amount"]);
 } %>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=6 height=25 class=xl40 style='border-right:.5pt solid black;
  height:18.75pt'>Total</td>
  <td class=xl36 align=right x:num><%= total_amount %></td>
  <td class=xl36 align=right x:num><%= pay_amount %></td>
  <td class=xl37 align=right x:num><%= bal_amount %></td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=133 style='width:100pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=87 style='width:65pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
