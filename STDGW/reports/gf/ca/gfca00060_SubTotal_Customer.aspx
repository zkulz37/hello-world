<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<% ESysLib.SetUser("acnt");%>
<% Response.ContentType = "application/vnd.ms-excel";
   Response.Charset = "utf-8"; 
   Response.Buffer = false;
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="AR%20ACCOUNT%20RECEIVABLE%20(1312)_files/filelist.xml">
<link rel=Edit-Time-Data
href="AR%20ACCOUNT%20RECEIVABLE%20(1312)_files/editdata.mso">
<link rel=OLE-Object-Data
href="AR%20ACCOUNT%20RECEIVABLE%20(1312)_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>van</o:Author>
  <o:LastAuthor>van</o:LastAuthor>
  <o:LastPrinted>2011-05-25T08:52:24Z</o:LastPrinted>
  <o:Created>2011-05-25T08:24:18Z</o:Created>
  <o:LastSaved>2011-05-25T08:53:33Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .25in .75in .5in;
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
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yy\;\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:10.5pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:10.5pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	vertical-align:top;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>SUB TOTAL_CUSTOMER</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8385</x:WindowHeight>
  <x:WindowWidth>14940</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>240</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>
<% 
    string p_compk = "", p_company_nm = "";
    string p_to_date = "", p_acc_cd = "", p_cust_pk = "";
    double l_usd_bal = 0, l_vnd_bal = 0, l_sub_tot_usd_bal = 0, l_sub_tot_vnd_bal = 0;
    double l_grand_usd_bal = 0, l_grand_vnd_bal = 0;       
    string SQL = "";
    string l_tr_date = "", l_cust_code = "", l_ccy = "", l_cust_name = "";
    p_compk = Request["company_pk"];
    p_to_date = Request["to_date"];
    p_cust_pk = Request["cust_pk"]; // customer Pk

    SQL = "select d.num_1 from tac_commcode_master a, tac_commcode_detail d " +
           "where a.id = 'GFQC0019' " +
           "and a.del_if = 0 " +
           "and a.pk = d.tac_commcode_master_pk " +
           "and d.del_if = 0 " +
           "and d.code = '30' ";
    DataTable dtAcc = new DataTable();
    dtAcc = ESysLib.TableReadOpen(SQL);
    if (dtAcc.Rows.Count > 0)
    {
        p_acc_cd = dtAcc.Rows[0][0].ToString();     
    }      

    DateTime dtTo = new DateTime(int.Parse(p_to_date.Substring(0, 4)), int.Parse(p_to_date.Substring(4, 2)), int.Parse(p_to_date.Substring(6, 2)));
    string l_date_to = dtTo.ToLongDateString();
    SQL = "select partner_name from comm.tco_company where pk = " + p_compk + " and del_if = 0";
    DataTable dtComp = new DataTable();
    dtComp = ESysLib.TableReadOpen(SQL);
    
    if(dtComp.Rows.Count > 0)
    {
        p_company_nm = dtComp.Rows[0][0].ToString();
    }
    SQL
        = "select v.tco_buspartner_pk, p.partner_id, p.partner_name, v.tr_date, " +
            "nvl(sum(v.tr_famt), 0) - nvl(sum(t.recv_famt), 0) usd_balance, nvl(sum(v.tr_amt), 0) - nvl(sum(t.recv_amt), 0) vnd_balance " +
            "from tac_carecvtr t, tac_carecv v, comm.tco_buspartner p  " +
            "where v.del_if = 0 " +
            "and v.pk = t.tac_carecv_pk(+) " +
            "and t.del_if(+) = 0 " +
            "and v.tr_date <= '" + p_to_date + "' " +
            "and v.tac_abacctcode_pk = (select c.pk from tac_abacctcode c where c.ac_cd like '" + p_acc_cd + "' and c.del_if = 0) " +
            "and v.received_yn = 'Y' " +
            "and v.tco_buspartner_pk = p.pk " +
            "and (v.tco_buspartner_pk like '" + p_cust_pk + "' or '" + p_cust_pk + "' is null) " +
            "group by v.tco_buspartner_pk , p.partner_id, p.partner_name, v.tr_date " +
            "having nvl(sum(v.tr_famt), 0) - nvl(sum(t.recv_famt), 0) <> 0 " +            
            "order by p.partner_id, v.tr_date ";
    DataTable dtItem = new DataTable();
    dtItem = ESysLib.TableReadOpen(SQL);
    if (dtItem.Rows.Count > 0)
    {
        p_cust_pk = dtItem.Rows[0][0].ToString();
    }
%>
<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=655 style='border-collapse:
 collapse;table-layout:fixed;width:493pt'>
 <col width=67 style='mso-width-source:userset;mso-width-alt:2450;width:50pt'>
 <col width=90 style='mso-width-source:userset;mso-width-alt:3291;width:68pt'>
 <col width=221 style='mso-width-source:userset;mso-width-alt:8082;width:166pt'>
 <col class=xl26 width=46 style='mso-width-source:userset;mso-width-alt:1682;
 width:35pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=121 style='mso-width-source:userset;mso-width-alt:4425;width:91pt'>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 width=67 style='height:21.0pt;width:50pt'></td>
  <td width=90 style='width:68pt'></td>
  <td class=xl25 colspan=3 align=left width=377 style='mso-ignore:colspan;
  width:284pt; text-underline-style:single;'>ACCOUNT RECEIVABLE (1312)</td>
  <td width=121 style='width:91pt'></td>
 </tr>
  <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 width=67 style='height:21.0pt;width:50pt'></td>
  <td width=90 style='width:68pt'></td>
  <td class=xl25 colspan=3 align=left width=377 style='mso-ignore:colspan;
  width:284pt; text-underline-style:single; font-size:13.0pt; '>(FOREIGN ACCOUNT
  RECEIVABLE)</td>
  <td width=121 style='width:91pt'></td>  
  </tr>  
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 align=left style='height:12.75pt;mso-ignore:colspan'><%=p_company_nm%></td>
  <td></td>
  <td class=xl26></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=3 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl48 colspan=2 align=left style='mso-ignore:colspan'>AS OF <%=l_date_to%></td>
 </tr>
 
 <tr class=xl27 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl28 style='height:27.0pt'>DATE</td>
  <td class=xl29 width=90 style='border-left:none;width:68pt'>CUSTOMER CODE</td>
  <td class=xl28 style='border-left:none'>CUSTOMER</td>
  <td class=xl28 style='border-left:none'>CCY</td>
  <td class=xl32 width=110 style='border-left:none;width:83pt'>FOREIGN BALANCE</td>
  <td class=xl32 width=121 style='border-left:none;width:91pt'>VND <br>
    BALANCE</td>
 </tr>
 <% 
     int i;
     l_sub_tot_usd_bal = 0;
     l_sub_tot_vnd_bal = 0;
     
     for (i = 0; i < dtItem.Rows.Count; i++)
     {
         l_usd_bal = double.Parse(dtItem.Rows[i][4].ToString());
         l_vnd_bal = double.Parse(dtItem.Rows[i][5].ToString());         
 %> 
 <% 
     if (p_cust_pk != dtItem.Rows[i][0].ToString())
     {
%>
 <tr class=xl24 height=18 style='height:13.5pt'>
  <td height=18 class=xl43 style='height:13.5pt;border-top:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'><%=l_cust_code %></td>
  <td class=xl44 style='border-top:none;border-left:none'><%=l_cust_name%></td>
  <td class=xl45 style='border-top:none;border-left:none'>USD</td>
  <td class=xl46 align=left style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'>              </span><%=l_sub_tot_usd_bal %> </td>
  <td class=xl47 align=left style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'>          </span><%=l_sub_tot_vnd_bal%> </td>
 </tr>
<%             
        p_cust_pk = dtItem.Rows[i][0].ToString();
        l_sub_tot_usd_bal = l_usd_bal;
        l_sub_tot_vnd_bal = l_vnd_bal;          
         
     }         
     else 
     {
         l_sub_tot_usd_bal += l_usd_bal;
         l_sub_tot_vnd_bal += l_vnd_bal;  
     }
     l_tr_date = dtItem.Rows[i][3].ToString();   // trans date
     l_tr_date = l_tr_date.Substring(6, 2) + "/" + l_tr_date.Substring(4, 2) + "/" + l_tr_date.Substring(2, 2);
     l_cust_code = dtItem.Rows[i][1].ToString(); // customer code
     l_cust_name = dtItem.Rows[i][2].ToString(); // customer name
     l_ccy = "USD";
     l_grand_usd_bal += l_usd_bal;
     l_grand_vnd_bal += l_vnd_bal;                  
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl42 style='height:12.75pt;border-top:none' x:str><%=l_tr_date%></td>
  <td class=xl40 style='border-top:none;border-left:none'><%=l_cust_code%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=l_cust_name%></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=l_ccy %></td>
  <td class=xl34 align=left style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'>               </span><%=l_usd_bal %> </td>
  <td class=xl33 align=left style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'>            </span><%=l_vnd_bal %>
  </td>
 </tr>
<%         
     }
 %>
 <tr height=20 style='height:15.0pt'>
  <td colspan=4 height=20 class=xl35 style='border-right:.5pt solid black;
  height:15.0pt'>Grand Total</td>
  <td class=xl38 style='border-top:none;border-left:none' x:num ><%=l_grand_usd_bal %></td>
  <td class=xl39 style='border-top:none;border-left:none' x:num ><%=l_grand_vnd_bal%></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=67 style='width:50pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=221 style='width:166pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=121 style='width:91pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
