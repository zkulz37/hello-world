<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string emp_pk;
    
    emp_pk       = Request["emp_pk"].ToString();
    string SQL = " select a.emp_id  " //0 
        + ",a.FULL_NAME  "//1
        + ",a.Social_no " //2
        + ",a.health_no " //3
        + ",(select v.code_nm from vhr_hr_code v where v.id='HR0132' and v.code=b.content ) " //4 noi dung thay doi
        + ",b.old " //5 cu 
        + ",b.new " //6 moi
        + ",b.reason " //7 ly do dieu chinh
        + "from thr_employee a,thr_ins_modify b "
        + "where a.del_if=0 and b.del_if=0 and b.thr_emp_pk =a.pk "
       + "and b.pk in (" + emp_pk + ") " ;
        
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
    //getting employeer
    SQL
    = "select code_nm " +
        "from vhr_hr_code " +
        "where id='HR0049' order by code  ";
    DataTable dt_name = ESysLib.TableReadOpen(SQL);
    int irow_name;
    irow_name = dt_name.Rows.Count;
    
        
   
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_03B_TBH_Hyosung_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_03B_TBH_Hyosung_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_03B_TBH_Hyosung_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>welcome</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-09-27T09:19:45Z</o:LastPrinted>
  <o:Created>2011-09-27T09:13:04Z</o:Created>
  <o:LastSaved>2011-09-27T09:20:34Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .7in .75in .7in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;
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
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
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
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl67
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	background:white;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl69
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl70
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl71
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl73
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl76
	{mso-style-parent:style0;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl79
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl84
	{mso-style-parent:style0;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl85
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl86
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl87
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl88
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl90
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl91
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl92
	{mso-style-parent:style0;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl93
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>03B_TBH</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>88</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
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
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7710</x:WindowHeight>
  <x:WindowWidth>16995</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>360</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='03B_TBH'!$7:$7</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl65>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1042 style='border-collapse:
 collapse;table-layout:fixed;width:782pt'>
 <col class=xl65 width=34 style='mso-width-source:userset;mso-width-alt:1243;
 width:26pt'>
 <col class=xl65 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:1243'>
 <col class=xl65 width=147 style='mso-width-source:userset;mso-width-alt:5376;
 width:110pt'>
 <col class=xl65 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl65 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl65 width=166 style='mso-width-source:userset;mso-width-alt:6070;
 width:125pt'>
 <col class=xl65 width=91 style='mso-width-source:userset;mso-width-alt:3328;
 width:68pt'>
 <col class=xl65 width=133 style='mso-width-source:userset;mso-width-alt:4864;
 width:100pt'>
 <col class=xl65 width=152 style='mso-width-source:userset;mso-width-alt:5558;
 width:114pt'>
 <col class=xl65 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl65 width=64 style='width:48pt'>
 <tr height=27 style='height:20.25pt'>
  <td height=27 class=xl65 width=34 style='height:20.25pt;width:26pt'></td>
  <td class=xl65 width=0></td>
  <td class=xl65 width=147 style='width:110pt'></td>
  <td class=xl84 colspan=6 width=734 style='mso-ignore:colspan;width:551pt'>DANH
  SÁCH &#272;&#7872; NGH&#7882; &#272;I&#7872;U CH&#7880;NH H&#7890; S&#416;
  THAM GIA BHXH, BHYT</td>
  <td class=xl65 width=63 style='width:47pt'></td>
  <td class=xl65 width=64 style='width:48pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl83>M&#7851;u s&#7889; :03b - TBH</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl83 x:str="&#272;&#417;n v&#7883;: ">&#272;&#417;n v&#7883;:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl83 colspan=3 style='mso-ignore:colspan'>Công ty TNHH Hyosung
  Vi&#7879;t Nam</td>
  <td class=xl83></td>
  <td class=xl83>Mã s&#7889;:<span style='mso-spacerun:yes'>  </span>75</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl83>&#272;&#7883;a ch&#7881;:</td>
  <td class=xl83 colspan=4 style='mso-ignore:colspan'>&#272;&#432;&#7901;ng N2
  - KCN Nh&#417;n Tr&#7841;ch 5 - Nh&#417;n Tr&#7841;ch - &#272;&#7891;ng Nai</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl83 colspan=2 style='mso-ignore:colspan'>&#272;i&#7879;n
  tho&#7841;i: (0613)569291</td>
  <td class=xl83 colspan=2 style='mso-ignore:colspan'>Fax: (0613)569299</td>
  <td class=xl83></td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=11 class=xl65 style='height:16.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl72 height=42 style='height:31.5pt'>
  <td height=42 class=xl81 style='height:31.5pt'>STT</td>
  <td class=xl81 style='border-left:none'>&nbsp;</td>
  <td class=xl81 style='border-left:none'>H&#7885; và tên</td>
  <td class=xl81 style='border-left:none'>S&#7889; s&#7893; BHXH</td>
  <td class=xl81 style='border-left:none'>S&#7889; th&#7867; BHYT</td>
  <td class=xl82 width=166 style='border-left:none;width:125pt'>N&#7897;i dung
  thay &#273;&#7893;i<br>
    (&#273;i&#7873;u ch&#7881;nh)</td>
  <td class=xl81 style='border-left:none'>C&#361;</td>
  <td class=xl81 style='border-left:none'>M&#7899;i</td>
  <td class=xl81 style='border-left:none'>Lý do &#273;i&#7873;u ch&#7881;nh</td>
  <td class=xl81 style='border-left:none'>Ghi chú</td>
  <td class=xl72></td>
 </tr>
 <% 
   int count =0;
 for (int i=0 ;i< dt_total.Rows.Count;i++) {
    count ++;
 %>
 <tr class=xl72 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl80 style='height:26.25pt' x:num><%=i+1 %></td>
  <td class=xl88 style='border-left:none'><%=dt_total.Rows[i][0].ToString() %></td>
  <td class=xl89 style='border-left:none'><%=dt_total.Rows[i][1].ToString() %></td>
  <td class=xl90 style='border-left:none' x:str><%=dt_total.Rows[i][2].ToString() %></td>
  <td class=xl90 style='border-left:none' x:str><%=dt_total.Rows[i][3].ToString() %></td>
  <td class=xl92 style='border-left:none'><%=dt_total.Rows[i][4].ToString() %></td>
  <td height=35 class=xl90 width=91 style='height:26.25pt;border-left:none;
  width:68pt' x:str><%=dt_total.Rows[i][5].ToString() %></td>
  <td height=35 class=xl90 width=133 style='height:26.25pt;border-left:none;
  width:100pt' x:str><%=dt_total.Rows[i][6].ToString() %></td>
  <td height=35 class=xl93 width=152 style='height:26.25pt;border-left:none;
  width:114pt'><%=dt_total.Rows[i][7].ToString() %></td>
  <td class=xl79 style='border-left:none'>&nbsp;</td>
  <td class=xl72></td>
 </tr>
  <%} %>
 <tr class=xl72 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl74 style='height:15.75pt'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl78 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl74 style='border-left:none'>&nbsp;</td>
  <td class=xl77 width=166 style='border-left:none;width:125pt'>&nbsp;</td>
  <td height=21 class=xl76 width=91 style='height:15.75pt;border-top:none;
  border-left:none;width:68pt'>&nbsp;</td>
  <td class=xl75 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl74 style='border-left:none'>&nbsp;</td>
  <td class=xl73 style='border-left:none'>&nbsp;</td>
  <td class=xl72></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 colspan=3 class=xl65 style='height:9.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl85>&nbsp;</td>
  <td class=xl65></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl71 colspan=3 style='mso-ignore:colspan'>&#272;&#7872; NGH&#7882;
  H&#7910;Y S&#7888; S&#7892; BHXH</td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl65></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl70 colspan=2 style='mso-ignore:colspan'
  x:str>-
  s&#7893; BHXH c&#7847;n &#273;i&#7873;u ch&#7881;nh: <%= count %><span
  style='mso-spacerun:yes'>  </span>s&#7893;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl70>&nbsp;</td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl65></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl66>&nbsp;</td>
  <td class=xl70 colspan=2 style='mso-ignore:colspan'>Ngày<span
  style='mso-spacerun:yes'>                   </span>Tháng<span
  style='mso-spacerun:yes'>                   </span>N&#259;m</td>
  <td class=xl65></td>
  <td class=xl66>&nbsp;</td>
  <td class=xl69>Ngày<span style='mso-spacerun:yes'>   </span><%= DateTime.Today.Day%><span
  style='mso-spacerun:yes'>  </span>tháng<span style='mso-spacerun:yes'>   
  </span><%= DateTime.Today.Month%><span style='mso-spacerun:yes'>         </span>n&#259;m <%= DateTime.Today.Year%></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl68>Cán b&#7897; thu</td>
  <td class=xl65></td>
  <td class=xl68 colspan=2 style='mso-ignore:colspan'>Giám &#273;&#7889;c BHXH
  Nh&#417;n tr&#7841;ch</td>
  <td colspan=2 class=xl85>Ng&#432;&#7901;i l&#7853;p bi&#7875;u</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>Ng&#432;&#7901;i s&#7917; d&#7909;ng lao &#273;&#7897;ng</td>
  <td class=xl65></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl66 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl65></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl66 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl65></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl66 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl65></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl66 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl65></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 colspan=11 class=xl65 style='height:8.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 colspan=8 class=xl65 style='height:27.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl86></td>
  <td class=xl65></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=6 class=xl65 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl87></td>
  <td colspan=3 class=xl86></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=34 style='width:26pt'></td>
  <td width=0></td>
  <td width=147 style='width:110pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=166 style='width:125pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=133 style='width:100pt'></td>
  <td width=152 style='width:114pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
