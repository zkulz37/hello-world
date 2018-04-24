<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string bz_pk;
       
    bz_pk = Request["p_biz_trip_pk"].ToString(); 
    
    
    string SQL
	=
        "select 'I' as No " +
        ",b.full_name " +
        ",b.emp_id " +
        ",c.org_nm " +
        ",null " +
        ",(select char_1 from vhr_hr_code where id='HR0040' and code=e.currency) " +
        ",nvl(a.actual_amt,0) " +
        ",'TRANS',to_char(sysdate,'dd'),to_char(sysdate,'mm'),to_char(sysdate,'yyyy') " +
        "from THR_SETTLE_TRANS a,thr_employee b,comm.tco_org c,THR_BIZ_SETTLE_EXPENSES d,THR_BIZ_TRIP e " +
        "where a.del_if=0  and b.del_if=0 and c.del_if=0 and d.del_if=0 and e.del_if=0 " +
        "and e.thr_emp_pk=b.pk " +
        "and b.tco_org_pk=c.pk " +
        "and a.THR_BIZ_SETTLE_PK=d.pk " +
        "and d.thr_biz_pk=e.pk " +
        "and d.thr_biz_pk=" + bz_pk + " " +
        "union all " +
        "select 'II' as No " + 
        ",b.full_name " +
        ",b.emp_id " +
        ",c.org_nm " +
        ",to_char(to_date(a.M_FROM,'yyyymmdd'),'dd/mm/yyyy') " +
        ",(select char_1 from vhr_hr_code where id='HR0040' and code=e.currency) " +
        ",nvl(a.AMOUNT,0) " +
        ",'MEAL',to_char(sysdate,'dd'),to_char(sysdate,'mm'),to_char(sysdate,'yyyy') " +
        "from THR_SETTLE_MEAL a,thr_employee b,comm.tco_org c,THR_BIZ_SETTLE_EXPENSES d,THR_BIZ_TRIP e " +
        "where a.del_if=0  and b.del_if=0 and c.del_if=0 and d.del_if=0 and e.del_if=0 " +
        "and e.thr_emp_pk=b.pk " +
        "and b.tco_org_pk=c.pk " +
        "and a.THR_BIZ_SETTLE_PK=d.pk " +
        "and d.thr_biz_pk=e.pk " +
        "and d.thr_biz_pk=" + bz_pk + " " +
        "union all " +
        "select 'III' as No " +
        ",b.full_name " +
        ",b.emp_id " +
        ",c.org_nm " +
        ",to_char(to_date(a.l_from,'yyyymmdd'),'dd/mm/yyyy') " +
        ",(select char_1 from vhr_hr_code where id='HR0040' and code=e.currency)" +
        ",nvl(a.AMOUNT,0) " +
        ",'LODGING',to_char(sysdate,'dd'),to_char(sysdate,'mm'),to_char(sysdate,'yyyy')  " +
        "from THR_SETTLE_LODGING a,thr_employee b,comm.tco_org c,THR_BIZ_SETTLE_EXPENSES d,THR_BIZ_TRIP e " +
        "where a.del_if=0  and b.del_if=0 and c.del_if=0 and d.del_if=0 and e.del_if=0 " +
        "and e.thr_emp_pk=b.pk " +
        "and b.tco_org_pk=c.pk " +
        "and a.THR_BIZ_SETTLE_PK=d.pk " +
        "and d.thr_biz_pk=e.pk " +
        "and d.thr_biz_pk=" + bz_pk + " " +
        "union all " +
        "select 'IV' as No " +
        ",b.full_name " +
        ",b.emp_id " +
        ",c.org_nm " +
        ",'' " +
        ",(select char_1 from vhr_hr_code where id='HR0040' and code=e.currency) " +
        ",nvl(a.actual_AMt,0) " +
        ",'OTHER',to_char(sysdate,'dd'),to_char(sysdate,'mm'),to_char(sysdate,'yyyy')  " +
        "from THR_SETTLE_other a,thr_employee b,comm.tco_org c,THR_BIZ_SETTLE_EXPENSES d,THR_BIZ_TRIP e " +
        "where a.del_if=0  and b.del_if=0 and c.del_if=0 and d.del_if=0 and e.del_if=0 " +
        "and e.thr_emp_pk=b.pk " +
        "and b.tco_org_pk=c.pk " +
        "and a.THR_BIZ_SETTLE_PK=d.pk " +
        "and d.thr_biz_pk=e.pk " +
        "and d.thr_biz_pk=" + bz_pk  ;


        //Response.Write(SQL);
        //Response.End();
     
        DataTable dt_total = ESysLib.TableReadOpen(SQL);
        int irow;
        irow = dt_total.Rows.Count;

        
        if (irow == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }
    
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_bz_expense_settlement_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_bz_expense_settlement_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_bz_expense_settlement_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>TYML</o:Author>
  <o:LastAuthor>banana</o:LastAuthor>
  <o:LastPrinted>2009-04-21T09:52:36Z</o:LastPrinted>
  <o:Created>2009-04-21T01:39:52Z</o:Created>
  <o:LastSaved>2009-04-21T09:54:42Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.57in .27in .3in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.18in;}
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
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>17</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
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
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=663 style='border-collapse:
 collapse;table-layout:fixed;width:499pt'>
 <col class=xl24 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl24 width=113 style='mso-width-source:userset;mso-width-alt:4132;
 width:85pt'>
 <col class=xl24 width=106 style='mso-width-source:userset;mso-width-alt:3876;
 width:80pt'>
 <col class=xl24 width=145 style='mso-width-source:userset;mso-width-alt:5302;
 width:109pt'>
 <col class=xl24 width=218 style='mso-width-source:userset;mso-width-alt:7972;
 width:164pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl35 colspan=2 width=194 style='height:15.75pt;
  mso-ignore:colspan;width:146pt'>POSCO - VIETNAM CO., LTD</td>
  <td class=xl24 width=106 style='width:80pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=218 style='width:164pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl35 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Lot
  1, Phu My 2 IZ., Tan Thanh, BR-VT</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl35 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Tax
  code: 3500771158</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=5 height=21 class=xl38 style='height:15.75pt'>BUSINESS TRIP
  EXPENSE SETTLEMENT</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Employee
  name: <% = dt_total.Rows[0][1].ToString()%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl24>Employee code: <% = dt_total.Rows[0][2].ToString()%></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Department/Section:
  <% = dt_total.Rows[0][3].ToString()%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl33 style='height:25.5pt'>No.</td>
  <td class=xl33 style='border-left:none'>Date</td>
  <td class=xl33 style='border-left:none'>Unit</td>
  <td class=xl33 style='border-left:none'>Amount</td>
  <td class=xl33 style='border-left:none'>Purpose</td>
 </tr>
 <%
    Double grand_amt=0;
    Double sub_amt=0;
    String scur_no,sold_no,snew_no;
    String sno,sp;
    Boolean bsub=false;
    String[] ano={"I","II","III","IV","V"};
    int iano=0;
    for (int i = 0; i < irow; i++) 
    {
        grand_amt+=Double.Parse(dt_total.Rows[i][6].ToString());
        sub_amt+=Double.Parse(dt_total.Rows[i][6].ToString());
        scur_no=dt_total.Rows[i][0].ToString();
        if (i==0)
        {
            sno= ano[0];
            sp=dt_total.Rows[i][7].ToString();
        }
        else
        {
            sold_no=dt_total.Rows[i-1][0].ToString();
            if (scur_no!=sold_no)
            {
                iano+=1;
                sno= ano[iano];
                sp=dt_total.Rows[i][7].ToString();
            }
            else
            {
                sno="";
                sp="";
            }
        }
  %> 
 <tr height=21 style='height:15.75pt'>
    
  <td height=21 class=xl26 style='height:15.75pt;border-top:none;border-bottom:.5pt hairline windowtext;'><% = sno %></td>
  <td class=xl29 style='border-top:none;border-left:none;border-bottom:.5pt hairline windowtext;' ><% = dt_total.Rows[i][4].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none;border-bottom:.5pt hairline windowtext;'><% = dt_total.Rows[i][5].ToString()%></td>
  <td class=xl36 style='border-top:none;border-left:none;border-bottom:.5pt hairline windowtext;' x:num><span
  style='mso-spacerun:yes'> </span><% = dt_total.Rows[i][6].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none;border-bottom:.5pt hairline windowtext;'><% =sp %></td>
 </tr>
 <%
    if (i==irow-1)
        bsub=true;
    else
    {
        snew_no=dt_total.Rows[i+1][0].ToString();
        if (scur_no!=snew_no)
              bsub=true;
    }
  %>
  
  <%
        if (bsub==true)
        {
   %>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl26 style='height:15.75pt'>Sub-total</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=sub_amt %> </td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%
            sub_amt=0;
            bsub=false;
        }
  %>
 <%} %>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl34 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Grand
  - Total</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none' x:num><span
  style='mso-spacerun:yes'> </span><%=grand_amt %> </td>
  <td class=xl28 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'>Ngày(day) <% = dt_total.Rows[0][8].ToString()%> tháng(month)
  <% = dt_total.Rows[0][9].ToString()%> n&#259;m(year) <% = dt_total.Rows[0][10].ToString()%></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl24 style='height:21.75pt'></td>
  <td class=xl31>Ng&#432;&#7901;i l&#7853;p (Proposer)</td>
  <td class=xl32></td>
  <td colspan=2 class=xl38>Ng&#432;&#7901;i duy&#7879;t (Approval)</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=81 style='width:61pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=218 style='width:164pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
