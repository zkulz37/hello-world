<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<% 
    string SQL = "";
    string v_param = "";
    string v_com_pk = Request["com_pk"]; //company
    string v_from_date = Request["from_date"];    
    string v_to_date = Request["to_date"];    
    string v_voucher_type = Request["voucher_type"];
    string v_status = Request["status"];
    string v_voucherno = Request["voucher_no"];
    string v_serial_no = Request["serial_no"];
    string v_seq = Request["seq"];
    string v_invoice_no = Request["invoice_no"];
    string v_vendor_pk = Request["vendor_pk"];
    string v_origin = Request["origin"];
    string v_partner_name = "", v_comp_addr = "";
    string v_tu_ngay = "", v_den_ngay = "";
    v_param = "'" + v_com_pk + "', '" + v_from_date + "', '" + v_to_date + "', '" + v_voucher_type + "', '" + v_voucherno + "', '" + v_seq + "', '";
    v_param += v_serial_no + "', '" + v_invoice_no + "', '" + v_vendor_pk + "', '" + v_status + "', '" + v_origin + "' " ;
    DataTable dt = new DataTable();
    dt = ESysLib.TableReadOpenCursor("SP_SEL_GRD_MST_AP", v_param);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data to display");
        Response.End();
    }
    decimal v_net_trans_total = 0, v_net_books_total = 0, v_vat_trans_total = 0, v_vat_books_total = 0;
        //-------------------------------------Company
    SQL = "select partner_name, addr1 from comm.tco_company where pk like '" + v_com_pk + "' and del_if = 0";
    DataTable dtComp = new DataTable();
    dtComp = ESysLib.TableReadOpen(SQL);
    if (dtComp.Rows.Count > 0)
    {
        v_partner_name = dtComp.Rows[0][0].ToString();
        v_comp_addr = dtComp.Rows[0][1].ToString();
    }
    v_tu_ngay = v_from_date.Substring(6, 2) + "/" + v_from_date.Substring(4, 2) + "/" + v_from_date.Substring(0, 4);
    v_den_ngay = v_to_date.Substring(6, 2) + "/" + v_to_date.Substring(4, 2) + "/" + v_to_date.Substring(0, 4);
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="NXT_files/filelist.xml">
<link rel=Edit-Time-Data href="NXT_files/editdata.mso">
<link rel=OLE-Object-Data href="NXT_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>van</o:Author>
  <o:LastAuthor>van</o:LastAuthor>
  <o:Created>2011-10-19T02:03:39Z</o:Created>
  <o:LastSaved>2011-10-19T02:33:16Z</o:LastSaved>
  <o:Company>Vina Genuwin</o:Company>
  <o:Version>11.5606</o:Version>
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
	color:red;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:left;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	mso-number-format:"Short Date";
	text-align:center;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl33
	{mso-style-parent:style0;}
.xl34
	{mso-style-parent:style0;
	text-align:center;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	mso-number-format:"\@";
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>AP Register List</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>14</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PublishObjects>
     <x:PublishObject>
      <x:Id>21236</x:Id>
      <x:DivID>Book1_21236</x:DivID>
      <x:SourceType>SourceSheet</x:SourceType>
      <x:HtmlType>HtmlStatic</x:HtmlType>
      <x:Location
       HRef="C:\Documents and Settings\Administrator\My Documents\NXT.htm"/>
     </x:PublishObject>
    </x:PublishObjects>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9345</x:WindowHeight>
  <x:WindowWidth>11340</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2164 style='border-collapse:
 collapse;table-layout:fixed;width:1623pt'>
 <col width=107 style='mso-width-source:userset;mso-width-alt:3913;width:80pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=83 style='mso-width-source:userset;mso-width-alt:3035;width:62pt'>
 <col width=64 span=2 style='width:48pt'>
 <col width=83 style='mso-width-source:userset;mso-width-alt:3035;width:62pt'>
 <col width=85 style='mso-width-source:userset;mso-width-alt:3108;width:64pt'>
 <col width=124 style='mso-width-source:userset;mso-width-alt:4534;width:93pt'>
 <col width=111 style='mso-width-source:userset;mso-width-alt:4059;width:83pt'>
 <col width=64 style='width:48pt'>
 <col width=111 style='mso-width-source:userset;mso-width-alt:4059;width:83pt'>
 <col width=115 style='mso-width-source:userset;mso-width-alt:4205;width:86pt'>
 <col width=88 style='mso-width-source:userset;mso-width-alt:3218;width:66pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=170 style='mso-width-source:userset;mso-width-alt:6217;width:128pt'>
 <col width=203 style='mso-width-source:userset;mso-width-alt:7424;width:152pt'>
 <col width=174 style='mso-width-source:userset;mso-width-alt:6363;width:131pt'>
 <col width=114 style='mso-width-source:userset;mso-width-alt:4169;width:86pt'>
 <col width=241 style='mso-width-source:userset;mso-width-alt:8813;width:181pt'>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl25 colspan=3 width=262 style='height:14.25pt;
  mso-ignore:colspan;width:196pt'><%=v_partner_name%></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=170 style='width:128pt'></td>
  <td width=203 style='width:152pt'></td>
  <td width=174 style='width:131pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=241 style='width:181pt'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl25 colspan=2 style='height:14.25pt;mso-ignore:colspan'><%=v_comp_addr %>
  </td>
  <td colspan=17 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td height=27 colspan=5 style='height:20.25pt;mso-ignore:colspan'></td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan'>AP Register List</td>
  <td colspan=11 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=4 style='height:14.25pt;mso-ignore:colspan'></td>
  <td class=xl25 colspan=4 style='mso-ignore:colspan'
  x:str="Từ ngày: 01/09/2011 đến 30/09/2011 ">Từ ngày: <%=v_tu_ngay%> đến
  <%=v_den_ngay%><span style='mso-spacerun:yes'> </span></td>
  <td colspan=11 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='height:25.5pt;mso-xlrowspan:2'>
  <td height=34 colspan=19 style='height:25.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=19 style='height:14.25pt'>
  <td height=19 class=xl26 style='height:14.25pt'>Voucher No</td>
  <td class=xl26>Seq</td>
  <td class=xl26>Trans Date</td>
  <td class=xl26>Trans Ccy</td>
  <td class=xl26>Trans Rate</td>
  <td class=xl26>Invoice Date</td>
  <td class=xl26>Invoice No</td>
  <td class=xl26>Net Trans Amt</td>
  <td class=xl26>Net Books Amt</td>
  <td class=xl26>Tax Rate</td>
  <td class=xl26>VAT Trans Amt</td>
  <td class=xl26>VAT Books Amt</td>
  <td class=xl26>AP. Type</td>
  <td class=xl26>Account Code</td>
  <td class=xl26>Account Name</td>
  <td class=xl26>Description</td>
  <td class=xl26>Local Description</td>
  <td class=xl26>Vendor Code</td>
  <td class=xl26>Vendor Name</td>
 </tr>
 <% 
     int i;
     string v_trans_date = "", v_format = "", v_format_ccy_book = "";
     for(i = 0; i < dt.Rows.Count; i++)
     {
        v_trans_date = dt.Rows[i][7].ToString();
        
                     
 %>
 <tr class=xl25 height=19 style='height:14.25pt'>
  <td height=19 class=xl26 style='height:14.25pt'><%=dt.Rows[i][5] %></td> <!-- voucher no -->
  <td class=xl27 x:num><%=dt.Rows[i][6] %></td> <!-- seq -->
  <td class=xl28 x:str><%=v_trans_date %></td> <!-- trans date -->
  <td class=xl26><%=dt.Rows[i][9] %></td> <!-- trans ccy -->
  <td class=xl26 x:num><%=dt.Rows[i][10] %></td> <!-- trans rate -->
  <td class=xl28 x:str><%=dt.Rows[i][11] %></td> <!-- invoice date -->
  <td class=xl35 x:str><%=dt.Rows[i][13]%></td> <!-- invoice no -->
  <% 
         if(dt.Rows[i][9].ToString() =="VND")
         {
             v_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
         }
         else
         {
             v_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
         }                
  %>
  <td class=xl29 style="mso-number-format:'<%=v_format %>';" x:num><span style='mso-spacerun:yes'>    
  </span><%=dt.Rows[i][14]%> </td> <!-- Net Trans Amt -->
  <% 
         if(decimal.Parse(dt.Rows[i][35].ToString()) == 1)
         {
             v_format_ccy_book = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
         }
         else
         {
             v_format_ccy_book = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
         }                
  %>

  <td class=xl30 style="mso-number-format:'<%=v_format_ccy_book %>';" x:num><span style='mso-spacerun:yes'>      
  </span><%=dt.Rows[i][15]%></td> <!-- Net Trans Amt -->
  <td class=xl25 align=right x:str><%=dt.Rows[i][17] %></td> <!-- VAT Tax Rate -->
  <td class=xl29 style="mso-number-format:'<%=v_format%>';" x:num><span style='mso-spacerun:yes'>   
  </span><%=dt.Rows[i][18] %> </td> <!-- VAT Trans Amt -->
  <td class=xl30 style="mso-number-format:'<%=v_format_ccy_book%>';" x:num><span style='mso-spacerun:yes'>         
  </span><%=dt.Rows[i][19] %> </td> <!-- Net Books Amt -->
  <td class=xl33><%=dt.Rows[i][22] %></td>
  <td class=xl26 x:str><%=dt.Rows[i][24] %></td>
  <td class=xl33 x:str><%=dt.Rows[i][25] %></td>
  <td class=xl33><%=dt.Rows[i][26] %><span style='display:none'></span></td>
  <td class=xl33><%=dt.Rows[i][27] %><span style='display:none'>ƠI</span></td>
  <td class=xl34 x:str><%=dt.Rows[i][38] %></td>
  <td class=xl33 x:str><%=dt.Rows[i][39]%></td>
 </tr>
 <% 
        if(dt.Rows[i][14].ToString() != "")
        {
            v_net_trans_total += decimal.Parse(dt.Rows[i][14].ToString());
        }
        if(dt.Rows[i][15].ToString() != "")
        {
            v_net_books_total += decimal.Parse(dt.Rows[i][15].ToString());
        }
        if(dt.Rows[i][18].ToString() != "")
        {
            v_vat_trans_total += decimal.Parse(dt.Rows[i][18].ToString());
        }
        if(dt.Rows[i][19].ToString() != "")
        {
            v_vat_books_total += decimal.Parse(dt.Rows[i][19].ToString());
        }
         
     }
 %>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 colspan=7 class=xl25 style='height:15.0pt;mso-ignore:colspan'>Total</td>
  <td class=xl31 x:num><span
  style='mso-spacerun:yes'>   </span><%=v_net_trans_total %> </td>
  <td class=xl32 x:num><span
  style='mso-spacerun:yes'>     </span><%=v_net_books_total %> </td>
  <td class=xl25></td>
  <td class=xl31 x:num><span
  style='mso-spacerun:yes'>  </span><%=v_vat_trans_total %> </td>
  <td class=xl32 x:num><span
  style='mso-spacerun:yes'>        </span><%=v_vat_books_total %> </td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=107 style='width:80pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=170 style='width:128pt'></td>
  <td width=203 style='width:152pt'></td>
  <td width=174 style='width:131pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=241 style='width:181pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
