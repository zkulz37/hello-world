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
	= "select b.full_name " + 
        ",b.emp_id " +
        ",c.org_nm " +
        ",a.DESCRIPTION " +
        ",a.APPLICATION_NO " +
        ",a.TOTAL_EXPENSES " +
        ",a.VISITING_PLACE " +
        "from thr_biz_trip a,thr_employee b,comm.tco_org c " +
        "where a.del_if=0  and b.del_if=0 and c.del_if=0 " +
        "and a.thr_emp_pk=b.pk " +
        "and b.tco_org_pk=c.pk " +
        "and a.pk in (" + bz_pk + ") " +
        "order by b.emp_id,a.application_no";

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
<link rel=File-List href="rpt_bz_payment_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_bz_payment_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_bz_payment_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>TYML</o:Author>
  <o:LastAuthor>banana</o:LastAuthor>
  <o:LastPrinted>2009-04-21T06:45:36Z</o:LastPrinted>
  <o:Created>2009-04-21T01:52:04Z</o:Created>
  <o:LastSaved>2009-04-21T08:20:06Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.37in .18in .4in .4in;
	mso-header-margin:.28in;
	mso-footer-margin:.21in;}
.font9
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
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
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl35
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
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
      <x:Scale>92</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
      <% 
        int inum=0;
        for (int k=0;k<irow;k++)
        {
            inum+=50 ;
            %>
            
            <x:RowBreak>
                <x:Row><%=inum %></x:Row>
            </x:RowBreak>
            <%    
               
                
        }  
      %>
      
     </x:RowBreaks>
    </x:PageBreaks>
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
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>14955</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>315</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=757 style='border-collapse:
 collapse;table-layout:fixed;width:569pt'>
 <%
 for (int i = 0; i < irow; i++) 
    {
  %>  
 <col class=xl24 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl24 width=29 span=2 style='mso-width-source:userset;mso-width-alt:
 1060;width:22pt'>
 <col class=xl24 width=232 style='mso-width-source:userset;mso-width-alt:8484;
 width:174pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=105 style='mso-width-source:userset;mso-width-alt:3840;
 width:79pt'>
 <col class=xl24 width=231 style='mso-width-source:userset;mso-width-alt:8448;
 width:173pt'>
 <tr height=25 style='height:18.75pt'>
  <td colspan=7 height=25 class=xl35 width=757 style='height:18.75pt;
  width:569pt'>GI&#7844;Y &#272;&#7872; NGH&#7882; THANH TOÁN / T&#7840;M
  &#7912;NG</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=7 height=21 class=xl36 style='height:15.75pt'>PAYMENT /
  IN-ADVANCED PAYMENT REQUEST</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=7 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=4 style='height:15.75pt;mso-ignore:colspan'>H&#7885;
  và tên - Full name: <% = dt_total.Rows[i][0].ToString()%></td>
  <td class=xl24></td>
  <td class=xl24>Emloyee code:</td>
  <td class=xl39 x:num><% = dt_total.Rows[i][1].ToString()%></td>
 </tr>
 <tr height=3 style='mso-height-source:userset;height:4pt'>
  <td height=3 class=xl34 colspan=7 style='height:4pt;mso-ignore:colspan'
  x:str="                                                                                                                                                                                        "><span
  style='mso-spacerun:yes'>                                                                                                                                                                                        </span></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=4 style='height:15.75pt;mso-ignore:colspan'>B&#7897;
  ph&#7853;n - Section (Company): <% = dt_total.Rows[i][2].ToString()%></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=3 style='mso-height-source:userset;height:4pt'>
  <td height=3 class=xl34 colspan=7 style='height:4pt;mso-ignore:colspan'
  x:str="                                                                                                                                                                                        "><span
  style='mso-spacerun:yes'>                                                                                                                                                                                        </span></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=7 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=81 style='mso-height-source:userset;height:60.75pt'>
  <td height=81 class=xl25 width=38 style='height:60.75pt;width:29pt'>STT<br>
    Item</td>
  <td colspan=3 class=xl26 style='border-left:none'>N&#7897;i dung -
  Descriptions</td>
  <td class=xl25 width=93 style='border-left:none;width:70pt'>S&#7889; hóa
  &#273;&#417;n<br>
    Invoice no.</td>
  <td class=xl26 style='border-left:none'>Amount</td>
  <td class=xl25 width=231 style='border-left:none;width:173pt'>M&#7909;c
  &#273;ích - Purposes (Ghi rõ s&#7917; d&#7909;ng vào vi&#7879;c gì và cho
  phòng ban nào (n&#7871;u có))</td>
 </tr>
 <tr class=xl27 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl28 style='height:21.0pt;border-top:none' x:num>1</td>
  <td colspan=3 class=xl48 style='border-right:.5pt solid black;border-left:
  none'><% = dt_total.Rows[i][3].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none'><% = dt_total.Rows[i][4].ToString()%></td>
  <td class=xl44 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>        </span><% = dt_total.Rows[i][5].ToString()%></td>
  <td class=xl29 style='border-top:none;border-left:none'><% = dt_total.Rows[i][6].ToString()%></td>
 </tr>
 <tr class=xl27 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl42 style='height:21.0pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl51 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl27 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl42 style='height:21.0pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl42 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl27 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl42 style='height:21.0pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl42 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl27 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl42 style='height:21.0pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl42 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl27 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl42 style='height:21.0pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl42 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl27 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl42 style='height:21.0pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl42 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl27 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl42 style='height:21.0pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl42 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl27 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl42 style='height:21.0pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl42 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl27 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl42 style='height:21.0pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl42 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl27 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl42 style='height:21.0pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl42 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl27 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl42 style='height:21.0pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl42 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl27 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl42 style='height:21.0pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl42 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 
 <tr class=xl27 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl32 style='height:21.0pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl26 style='border-left:none'>T&#7893;ng c&#7897;ng -
  Total</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>        </span><% = dt_total.Rows[i][5].ToString()%> </td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=7 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=7 style='height:15.75pt;mso-ignore:colspan'>Vui
  lòng &#273;ính kèm gi&#7845;y &#273;&#7873; ngh&#7883; t&#7841;m &#7913;ng
  khi thanh toán t&#7841;m &#7913;ng (n&#7871;u có) và các ch&#7913;ng t&#7915;
  liên quan</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=6 style='height:15.75pt;mso-ignore:colspan'>Please
  attach the propose for advance (if any) and relevant invoices, documents</td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=7 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl24 colspan=5 style='mso-ignore:colspan'
  x:str="S&#7889; ti&#7873;n &#273;ã t&#7841;m &#7913;ng - Advance amount:                                                                                                 ">S&#7889;
  ti&#7873;n &#273;ã t&#7841;m &#7913;ng - Advance amount:<span
  style='mso-spacerun:yes'>                                                                                                 </span></td>
 </tr>
 <tr height=5 style='mso-height-source:userset;height:3.75pt'>
  <td height=5 class=xl24 colspan=2 style='height:3.75pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>                </span><span style='display:none'><span
  style='mso-spacerun:yes'>       </span><font class="font9"><span
  style='mso-spacerun:yes'>                                                                                                                                                            </span></font></span></td>
  <td colspan=5 class=xl40
  x:str="                                                                                                                                                                       "><span
  style='mso-spacerun:yes'>                                                                                                                                                                       </span></td>
 </tr>
 <tr height=4 style='mso-height-source:userset;height:3.0pt'>
  <td height=4 colspan=2 class=xl24 style='height:3.0pt;mso-ignore:colspan'></td>
  <td class=xl40></td>
  <td colspan=4 class=xl39 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl24 colspan=5 style='mso-ignore:colspan'
  x:str="S&#7889; ti&#7873;n còn ph&#7843;i tr&#7843; - Payment amount:                                                                                                 ">S&#7889;
  ti&#7873;n còn ph&#7843;i tr&#7843; - Payment amount:<span
  style='mso-spacerun:yes'>                                                                                                 </span></td>
 </tr>
 <tr height=5 style='mso-height-source:userset;height:3.75pt'>
  <td height=5 class=xl24 colspan=2 style='height:3.75pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>                </span><span style='display:none'><span
  style='mso-spacerun:yes'>       </span><font class="font9"><span
  style='mso-spacerun:yes'>                                                                                                                                                            </span></font></span></td>
  <td colspan=5 class=xl40
  x:str="                                                                                                                                                                       "><span
  style='mso-spacerun:yes'>                                                                                                                                                                       </span></td>
 </tr>
 <tr height=7 style='mso-height-source:userset;height:5.25pt'>
  <td height=7 colspan=7 class=xl24 style='height:5.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl26>X</td>
  <td class=xl24 colspan=4 style='mso-ignore:colspan'
  x:str="Ti&#7873;n m&#7863;t - Cash                                                                                                                            ">Ti&#7873;n
  m&#7863;t - Cash<span
  style='mso-spacerun:yes'>                                                                                                                            </span></td>
 </tr>
 <tr height=5 style='mso-height-source:userset;height:3.75pt'>
  <td height=5 class=xl24 colspan=2 style='height:3.75pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>                </span><span style='display:none'><span
  style='mso-spacerun:yes'>       </span><font class="font9"><span
  style='mso-spacerun:yes'>                                                                                                                                                            </span></font></span></td>
  <td colspan=5 class=xl40
  x:str="                                                                                                                                                                       "><span
  style='mso-spacerun:yes'>                                                                                                                                                                       </span></td>
 </tr>
 <tr height=5 style='mso-height-source:userset;height:3.75pt'>
  <td height=5 colspan=2 class=xl24 style='height:3.75pt;mso-ignore:colspan'></td>
  <td class=xl41>&nbsp;</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl38>&nbsp;</td>
  <td class=xl24 colspan=4 style='mso-ignore:colspan'
  x:str="Chuy&#7875;n kho&#7843;n - Tranfer (Bao g&#7891;m th&#7867; tín d&#7909;ng - Including Credit card)                                       ">Chuy&#7875;n
  kho&#7843;n - Tranfer (Bao g&#7891;m th&#7867; tín d&#7909;ng - Including
  Credit card)<span
  style='mso-spacerun:yes'>                                       </span></td>
 </tr>
 <tr height=5 style='mso-height-source:userset;height:3.75pt'>
  <td height=5 class=xl24 colspan=2 style='height:3.75pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>                </span><span style='display:none'><span
  style='mso-spacerun:yes'>       </span><font class="font9"><span
  style='mso-spacerun:yes'>                                                                                                                                                            </span></font></span></td>
  <td colspan=5 class=xl40
  x:str="                                                                                                                                                                       "><span
  style='mso-spacerun:yes'>                                                                                                                                                                       </span></td>
 </tr>
 <tr height=7 style='mso-height-source:userset;height:5.25pt'>
  <td height=7 colspan=7 class=xl24 style='height:5.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl24 colspan=5 style='mso-ignore:colspan'
  x:str="Tr&#7843; l&#7841;i cho công ty - Reimbusment to company                                                                                     ">Tr&#7843;
  l&#7841;i cho công ty - Reimbusment to company<span
  style='mso-spacerun:yes'>                                                                                     </span></td>
 </tr>
 <tr height=5 style='mso-height-source:userset;height:3.75pt'>
  <td height=5 class=xl24 colspan=2 style='height:3.75pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>                </span><span style='display:none'><span
  style='mso-spacerun:yes'>       </span><font class="font9"><span
  style='mso-spacerun:yes'>                                                                                                                                                            </span></font></span></td>
  <td colspan=5 class=xl40
  x:str="                                                                                                                                                                       "><span
  style='mso-spacerun:yes'>                                                                                                                                                                       </span></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl37 style='height:15.75pt'>Note:</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=7 style='height:15.75pt;mso-ignore:colspan'
  x:str="Phòng K&#7871; ho&#7841;ch &amp; Tài chính ch&#7881; ch&#7845;p nh&#7853;n nh&#7919;ng H&#272;, ch&#7913;ng t&#7915; h&#7907;p l&#7879; v&#7899;i &#273;&#7847;y &#273;&#7911; các thông tin v&#7873; DN (Tên Cty, ">Phòng
  K&#7871; ho&#7841;ch &amp; Tài chính ch&#7881; ch&#7845;p nh&#7853;n
  nh&#7919;ng H&#272;, ch&#7913;ng t&#7915; h&#7907;p l&#7879; v&#7899;i
  &#273;&#7847;y &#273;&#7911; các thông tin v&#7873; DN (Tên Cty,<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=7 style='height:15.75pt;mso-ignore:colspan'
  x:str="&#272;&#7883;a ch&#7881; MST), N&#7871;u thi&#7871;u m&#7897;t trong các tr&#432;&#7901;ng h&#7907;p trên, vui lòng lên h&#7879; l&#7841;i v&#7899;i nhà cung c&#7845;p (Trong tr&#432;&#7901;ng h&#7907;p ">&#272;&#7883;a
  ch&#7881; MST), N&#7871;u thi&#7871;u m&#7897;t trong các tr&#432;&#7901;ng
  h&#7907;p trên, vui lòng lên h&#7879; l&#7841;i v&#7899;i nhà cung c&#7845;p
  (Trong tr&#432;&#7901;ng h&#7907;p<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=7 style='height:15.75pt;mso-ignore:colspan'
  x:str="không th&#7875; l&#7845;y HD, vui lòng &#273;i&#7873;n vào m&#7851;u xác nh&#7853;n không hóa &#273;&#417;n và nêu rõ lý do t&#7841;i sao...) &#273;&#7891;ng th&#7901;i &#273;&#432;a cho G&#272; ">không
  th&#7875; l&#7845;y HD, vui lòng &#273;i&#7873;n vào m&#7851;u xác nh&#7853;n
  không hóa &#273;&#417;n và nêu rõ lý do t&#7841;i sao...) &#273;&#7891;ng
  th&#7901;i &#273;&#432;a cho G&#272;<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=4 style='height:15.75pt;mso-ignore:colspan'>các
  b&#7897; ph&#7853;n ký xác nh&#7853;n.</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=7 style='height:15.75pt;mso-ignore:colspan'
  x:str="The Plan and Financing dept. only accepts the red bills with fully information about company (Name, Address, ">The
  Plan and Financing dept. only accepts the red bills with fully information
  about company (Name, Address,<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=7 style='height:15.75pt;mso-ignore:colspan'
  x:str=" Taxe code), If not please recontact with supplier and make it suitable (Incase you can not get the red bill please fill "><span
  style='mso-spacerun:yes'> </span>Taxe code), If not please recontact with
  supplier and make it suitable (Incase you can not get the red bill please
  fill<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=7 style='height:15.75pt;mso-ignore:colspan'
  x:str="the Confirmation of without red bill expense form and write the reason... simultaneously receive confirmation by ">the
  Confirmation of without red bill expense form and write the reason...
  simultaneously receive confirmation by<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=4 style='height:15.75pt;mso-ignore:colspan'>your
  General Manager.</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=38 style='width:29pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=232 style='width:174pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=231 style='width:173pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
