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
<link rel=File-List href="AR%20ACCOUNT%20RECEIVABLE%20(1311)_files/filelist.xml">
<link rel=Edit-Time-Data
href="AR%20ACCOUNT%20RECEIVABLE%20(1311)_files/editdata.mso">
<link rel=OLE-Object-Data
href="AR%20ACCOUNT%20RECEIVABLE%20(1311)_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>van</o:Author>
  <o:LastAuthor>van</o:LastAuthor>
  <o:LastPrinted>2011-05-27T03:38:40Z</o:LastPrinted>
  <o:Created>2011-05-25T08:24:18Z</o:Created>
  <o:LastSaved>2011-05-27T03:41:02Z</o:LastSaved>
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
	font-size:11.0pt;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:10.5pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl37
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
.xl38
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
.xl39
	{mso-style-parent:style0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yyyy\;\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl41
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
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
       <x:ActiveRow>1</x:ActiveRow>
       <x:RangeSelection>$2:$2</x:RangeSelection>
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
    p_cust_pk = Request["cust_pk"];
    
    SQL = "select d.num_1 from tac_commcode_master a, tac_commcode_detail d " +
           "where a.id = 'GFQC0019' " +
           "and a.del_if = 0 " +
           "and a.pk = d.tac_commcode_master_pk " +
           "and d.del_if = 0 " +
           "and d.code = '40' ";
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
            "nvl(sum(v.tr_amt), 0) - nvl(sum(t.recv_amt), 0) vnd_balance " +
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
            "having nvl(sum(v.tr_amt), 0) - nvl(sum(t.recv_amt), 0) <> 0 " +
            "order by p.partner_id, v.tr_date ";
    DataTable dtItem = new DataTable();
    dtItem = ESysLib.TableReadOpen(SQL);
    if (dtItem.Rows.Count > 0)
    {
        p_cust_pk = dtItem.Rows[0][0].ToString();
    }
%>
<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=633 style='border-collapse:
 collapse;table-layout:fixed;width:476pt'>
 <col width=99 style='mso-width-source:userset;mso-width-alt:3620;width:74pt'>
 <col width=102 style='mso-width-source:userset;mso-width-alt:3730;width:77pt'>
 <col width=278 style='mso-width-source:userset;mso-width-alt:10166;width:209pt'>
 <col width=154 style='mso-width-source:userset;mso-width-alt:5632;width:116pt'>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 width=99 style='height:26.25pt;width:74pt'></td>
  <td width=102 style='width:77pt'></td>
  <td class=xl41 colspan=2 width=432 style='mso-ignore:colspan;width:325pt'>ACCOUNT
  RECEIVABLE (1311)</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 colspan=2 style='height:16.5pt;mso-ignore:colspan'></td>
  <td class=xl40 colspan=2 style='mso-ignore:colspan'>(DOMESTIC ACCOUNT
  RECEIVABLE)</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 style='height:12.75pt;mso-ignore:colspan'><%=p_company_nm %></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=4 style='height:15.75pt;mso-ignore:colspan'>AS OF <%=l_date_to %></td>
 </tr>
 <tr class=xl25 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl26 style='height:27.0pt'>DATE</td>
  <td class=xl27 width=102 style='border-left:none;width:77pt'>CUSTOMER CODE</td>
  <td class=xl26 style='border-left:none'>CUSTOMER</td>
  <td class=xl29 width=154 style='border-left:none;width:116pt'>VND <br>
    BALANCE</td>
 </tr>
 <%
     int i;      
     l_sub_tot_vnd_bal = 0;

     for (i = 0; i < dtItem.Rows.Count; i++)
     {
         l_vnd_bal = double.Parse(dtItem.Rows[i][4].ToString());         
 %> 
 <% 
     if (p_cust_pk != dtItem.Rows[i][0].ToString())
     {
     
 %>
 <tr class=xl24 height=18 style='height:13.5pt'>
  <td height=18 class=xl34 style='height:13.5pt;border-top:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'><%=l_cust_code%></td>
  <td class=xl35 style='border-top:none;border-left:none'><%=l_cust_name%></td>
  <td class=xl36 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%=l_sub_tot_vnd_bal%> </td>
 </tr>
 <%             
     p_cust_pk = dtItem.Rows[i][0].ToString();
     l_sub_tot_vnd_bal = l_vnd_bal;
     }
     else
     {
         l_sub_tot_vnd_bal += l_vnd_bal;
     }
     l_tr_date = dtItem.Rows[i][3].ToString();   // trans date
     l_tr_date = l_tr_date.Substring(6, 2) + "/" + l_tr_date.Substring(4, 2) + "/" + l_tr_date.Substring(0, 4);
     l_cust_code = dtItem.Rows[i][1].ToString(); // customer code
     l_cust_name = dtItem.Rows[i][2].ToString(); // customer name          
     l_grand_vnd_bal += l_vnd_bal;                  
  %>

 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl39 style='height:12.75pt;border-top:none' x:str><%=l_tr_date%></td>
  <td class=xl32 style='border-top:none;border-left:none'><%=l_cust_code %></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=l_cust_name %></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                      </span><%=l_vnd_bal %> </td>
 </tr>
 <% 
     }
 %>
 <tr height=20 style='height:15.0pt'>
  <td colspan=3 height=20 class=xl37 style='height:15.0pt'>Grand Total</td>
  <td class=xl31 style='border-top:none' x:num ><%=l_grand_vnd_bal%></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=99 style='width:74pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=278 style='width:209pt'></td>
  <td width=154 style='width:116pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
