<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("CRM");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_seq = Request["seq"];
    string p_arr_master_pk = Request["master_pk"];
    //Response.Write(p_arr_master_pk);
    //Response.End();
    string SQL = "SELECT distinct(a.member_type_pk) " +      
                    "FROM tcm_member a, tcm_member_type b " +
                        " WHERE a.del_if = 0 AND b.del_if = 0 AND a.member_type_pk = b.pk and b.pk in(" + p_seq + ")";

    DataTable dt_seq = ESysLib.TableReadOpen(SQL);
    string SQL_Master = "SELECT a.pk " +
                    "FROM tcm_member a, tcm_member_type b " +
                        " WHERE a.del_if = 0 AND b.del_if = 0 AND a.member_type_pk = b.pk and a.pk in(" + p_arr_master_pk + ")";
    DataTable dt_master_seq = ESysLib.TableReadOpen(SQL_Master);
     %>
    
    
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_debit_note_htm_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_debit_note_htm_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_debit_note_htm_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Ngale</o:Author>
  <o:LastAuthor>Ngale</o:LastAuthor>
  <o:LastPrinted>2010-06-23T09:38:52Z</o:LastPrinted>
  <o:Created>2010-06-23T06:55:47Z</o:Created>
  <o:LastSaved>2010-06-23T09:42:43Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.2in .75in .2in .39in;
	mso-header-margin:.65in;
	mso-footer-margin:.51in;}
.font0
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font5
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
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
	vertical-align:justify;
	white-space:normal;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:justify;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:justify;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	mso-number-format:Standard;}
.xl36
	{mso-style-parent:style0;
	text-align:center;}
.xl37
	{mso-style-parent:style0;
	text-align:left;}
.xl38
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl39
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	vertical-align:middle;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:justify;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	mso-number-format:Standard;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	mso-number-format:Standard;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	mso-number-format:Standard;
	text-align:right;
	border:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	border:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl52
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>70</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
      <x:NumberofCopies>0</x:NumberofCopies>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>9</x:ActiveRow>
       <x:ActiveCol>11</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:ColBreaks>
      <x:ColBreak>
       <x:Column>8</x:Column>
      </x:ColBreak>
     </x:ColBreaks>
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
  <x:WindowHeight>5895</x:WindowHeight>
  <x:WindowWidth>7515</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=919 style='border-collapse:
 collapse;table-layout:fixed;width:691pt'>
 <col width=101 style='mso-width-source:userset;mso-width-alt:3693;width:76pt'>
 <col width=49 style='mso-width-source:userset;mso-width-alt:1792;width:37pt'>
 <col width=46 style='mso-width-source:userset;mso-width-alt:1682;width:35pt'>
 <col width=103 style='mso-width-source:userset;mso-width-alt:3766;width:77pt'>
 <col width=69 style='mso-width-source:userset;mso-width-alt:2523;width:52pt'>
 <col width=59 style='mso-width-source:userset;mso-width-alt:2157;width:44pt'>
 <col width=77 span=2 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col width=82 style='mso-width-source:userset;mso-width-alt:2998;width:62pt'>
 <col width=64 span=4 style='width:48pt'>
 <%
        String p_xls_ccy_format = "";
        String p_xls_ccy_format_usd = "";
        string l_parameter = "";
        for (int w = 0; w < dt_seq.Rows.Count; w++)
        {
            for (int r = 0; r < dt_master_seq.Rows.Count; r++)
            {
                DataTable dtMaster = ESysLib.TableReadOpenCursor("CRM.sp_sel_jams0060_5", dt_master_seq.Rows[r][0].ToString());
                

     %> 
 <tr height=17 style='height:12.75pt'>
  <td colspan=4 rowspan=2 height=34 class=xl36 width=299 style='height:25.5pt;
  width:225pt'></td>
  <td colspan=3 rowspan=2 class=xl39 width=205 style='width:154pt'>DEBIT NOTE</td>
  <td colspan=6 rowspan=2 class=xl36 width=415 style='width:312pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=4 height=20 class=xl36 style='height:15.0pt'></td>
  <td colspan=3 class=xl40>(Member charge)</td>
  <td colspan=6 class=xl36></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td colspan=13 height=18 class=xl36 style='height:13.5pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>Date :</td>
  <td colspan=12 class=xl37>dd/mm/yyyy</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>No<span
  style='mso-spacerun:yes'>    </span>:</td>
  <td colspan=12 class=xl37>E03/10</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=13 height=17 class=xl38 style='height:12.75pt'></td>
 </tr>
 <tr height=88 style='mso-height-source:userset;height:66.0pt'>
  <td height=88 class=xl27 style='height:66.0pt'>To<span
  style='mso-spacerun:yes'>    </span>:</td>
  <td colspan=4 class=xl41 dir=LTR width=267 style='width:201pt'>Cty TNHH Vina
  Genuwin suit 4.7A,fl.4,e.town building,364 cong hoa Str.,ward 13,tan binh
  dist., Hochiminh city,viet nam.</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=10 height=21 class=xl42 style='height:15.75pt'></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'>Name<span
  style='mso-spacerun:yes'>    </span>:</td>
  <td colspan=4 class=xl43><%= dtMaster.Rows[0][4].ToString()%></td>
  <td class=xl27>Gender:</td>
  <td class=xl26>Male</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'>Member Type :</td>
  <td colspan=4 class=xl26>INDIVIDUAL</td>
  <td class=xl27>Phone:</td>
  <td class=xl26 x:num="916324344">916324344</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=9 height=17 class=xl37 style='height:12.75pt'><span
  style='mso-spacerun:yes'> </span>We are pleased to inform you that member
  charge applied from Feb. 01, 2010<span style='mso-spacerun:yes'> 
  </span>to<span style='mso-spacerun:yes'>  </span>Feb.28,2010 , as follows :</td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=10 height=17 class=xl36 style='height:12.75pt'></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl30 style='height:12.75pt'>Fee Name</td>
  <td colspan=2 class=xl30 style='border-left:none'>Fee Amount</td>
  <td colspan=2 class=xl30 style='border-left:none'>Fee Amount(USD)</td>
  <td class=xl30 style='border-left:none'>Date From</td>
  <td class=xl30 style='border-left:none'>Date To</td>
  <td colspan=2 class=xl44 style='border-right:.5pt solid black;border-left:
  none'><span style='mso-spacerun:yes'> </span>Received Amount</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <%
     DataTable dt = ESysLib.TableReadOpenCursor("CRM.sp_sel_jams0060_4", dt_seq.Rows[w][0].ToString());
     for (int i = 0; i < dt.Rows.Count; i++)
     {
  %>
 
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl50 style='height:12.75pt'><%= dt.Rows[i][2].ToString()%></td>
  <td colspan=2 class=xl46 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dt.Rows[i][3].ToString()%></td>
  <td colspan=2 class=xl46 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dt.Rows[i][4].ToString()%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%= dt.Rows[i][5].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none'><%= dt.Rows[i][6].ToString()%></td>
  <td colspan=2 class=xl46 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dt.Rows[i][7].ToString()%></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=7 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl31 style='border-top:none'>Total<span
  style='mso-spacerun:yes'>         </span>:</td>
  <td colspan=2 class=xl48 style='border-left:none' x:num="10000.245000000001">10,000.25</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td class=xl31 style='border-top:none'>VAT(10%) :</td>
  <td colspan=2 class=xl48 style='border-left:none' x:num="10000.245000000001">10,000.25</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=7 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl32 style='border-top:none'>Total due<span
  style='mso-spacerun:yes'>   </span>:</td>
  <td colspan=2 class=xl49 style='border-left:none' x:num="10000.245000000001">10,000.25</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=10 height=17 class=xl36 style='height:12.75pt'></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=10 height=17 class=xl37 style='height:12.75pt'><span
  style='mso-spacerun:yes'> </span>Please make all cheque payable or by by
  electronic transfer on/before<span style='mso-spacerun:yes'>  </span><font
  class="font5">March 10,2010</font><font class="font0"><span
  style='mso-spacerun:yes'>  </span>to :</font></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt'>Beneficiary<span
  style='mso-spacerun:yes'>  </span>:</td>
  <td colspan=9 class=xl51>CTY AMB ……</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>A/C No<span
  style='mso-spacerun:yes'>      </span>:</td>
  <td colspan=9 class=xl51>007.100.07.95839(VND)</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>Bank<span
  style='mso-spacerun:yes'>         </span>:</td>
  <td colspan=9 class=xl52>Vietcombank,Tan<span style='mso-spacerun:yes'> 
  </span>Binh Branch</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl36 style='height:12.75pt'>Regards</td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 rowspan=3 height=51 class=xl36 style='height:38.25pt'></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl25 style='height:12.75pt'>Nguyen Van X</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl36 style='height:12.75pt'>Chief<span
  style='mso-spacerun:yes'>  </span>Acountant</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <% 
     }
 }
      %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=101 style='width:76pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
