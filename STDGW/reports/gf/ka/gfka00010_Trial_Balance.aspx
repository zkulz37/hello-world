<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string l_compk = Request["p_compk"];
    string l_accd = Request["p_accd"];
    string l_level = Request["p_level"];
    string l_formtype = Request["p_formtype"];
    string l_formtype_text = Request["p_frm_type"];
    
    string l_company = "",l_address="";
    string Form_Type = "",AccCode="",LevelName="";

    string SQL1_1 = " SELECT  A.CODE_NM FROM TCO_ABCODE A, TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0020' AND A.USE_IF = 1 and A.CODE ='" + l_level + "'";
    DataTable dt_f1 = ESysLib.TableReadOpen(SQL1_1);
    if (dt_f1.Rows.Count > 0)
    {
        LevelName = dt_f1.Rows[0][0].ToString();
        
    }
    
    
    string SQL1 = " SELECT  PARTNER_NAME,addr1 FROM TCO_COMPANY WHERE DEL_IF=0 and pk ='" + l_compk + "'";
    DataTable dt_f = ESysLib.TableReadOpen(SQL1);
    if (dt_f.Rows.Count > 0)
      {
          l_company = dt_f.Rows[0][0].ToString();
          l_address = dt_f.Rows[0][1].ToString();
      }
      string l_parameter = "'" + l_compk + "','" + l_accd + "','" + l_level + "','" + l_formtype + "'";
    DataTable dt = ESysLib.TableReadOpenCursor("ac_sel_60080010_finance_form", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
            
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="RPTtRIALbALANCE_files/filelist.xml">
<link rel=Edit-Time-Data href="RPTtRIALbALANCE_files/editdata.mso">
<link rel=OLE-Object-Data href="RPTtRIALbALANCE_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>PCVINA002</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2009-10-20T04:29:35Z</o:LastPrinted>
  <o:Created>2009-10-16T03:08:39Z</o:Created>
  <o:LastSaved>2009-10-20T04:31:12Z</o:LastSaved>
  <o:Company>VINA</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .2in .5in .2in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
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
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;
	background:#FF9900;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;
	background:#FF9900;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;
	background:#FF9900;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;
	background:#FF9900;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;
	background:#FF9900;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl36
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;
	background:#FF9900;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style0;
	text-align:left;}
.xl41
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
	
	
	
.xl45
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl47
	{mso-style-parent:style0;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl48
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;
	background:#00CCFF;
	mso-pattern:auto none;}
	
	
	
	
.xl51
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;}
.xl52
	{mso-style-parent:style0;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;}
.xl53
	{mso-style-parent:style0;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
	
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
      <x:ValidPrinterInfo/>
      <x:Scale>56</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
      <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitVertical>7</x:SplitVertical>
      <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>9</x:TopRowBottomPane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>7</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
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
  <x:WindowHeight>6600</x:WindowHeight>
  <x:WindowWidth>11880</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1545</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2083 style='border-collapse:
 collapse;table-layout:fixed;width:1566pt'>
 <col width=38 style='mso-width-source:userset;mso-width-alt:1389;width:29pt'>
 <col width=60 style='mso-width-source:userset;mso-width-alt:2194;width:45pt'>
 <col width=43 style='mso-width-source:userset;mso-width-alt:1572;width:32pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=97 style='mso-width-source:userset;mso-width-alt:3547;width:73pt'>
 <col width=160 span=3 style='mso-width-source:userset;mso-width-alt:5851;
 width:120pt'>
 <col width=35 style='mso-width-source:userset;mso-width-alt:1280;width:26pt'>
 <col width=46 style='mso-width-source:userset;mso-width-alt:1682;width:35pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2560;width:53pt'>
 <col width=38 style='mso-width-source:userset;mso-width-alt:1389;width:29pt'>
 <col width=90 style='mso-width-source:userset;mso-width-alt:3291;width:68pt'>
 <col width=46 style='mso-width-source:userset;mso-width-alt:1682;width:35pt'>
 <col width=98 style='mso-width-source:userset;mso-width-alt:3584;width:74pt'>
 <col width=135 span=3 style='mso-width-source:userset;mso-width-alt:4937;
 width:101pt'>
 <col width=96 style='mso-width-source:userset;mso-width-alt:3510;width:72pt'>
 <col width=138 style='mso-width-source:userset;mso-width-alt:5046;width:104pt'>
 <col width=150 style='mso-width-source:userset;mso-width-alt:5485;width:113pt'>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=5 height=21 class=xl42 width=294 style='height:15.75pt;
  width:221pt'><%=l_company %></td>
  <td colspan=10 class=xl41 width=902 style='width:679pt'><%=l_formtype_text%></td>
  <td class=xl26 width=98 style='width:74pt'></td>
  <td class=xl26 width=135 style='width:101pt'></td>
  <td class=xl26 width=135 style='width:101pt'></td>
  <td class=xl26 width=135 style='width:101pt'></td>
  <td class=xl26 width=96 style='width:72pt'></td>
  <td class=xl26 width=138 style='width:104pt'></td>
  <td class=xl26 width=150 style='width:113pt'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=5 height=17 class=xl43 style='height:12.75pt'><%=l_address %></td>
  <td class=xl28>Form Type :</td>
  <td class=xl35><%=l_formtype_text%></td>
  <td class=xl24>Acount Code :</td>
  <td class=xl35 x:num><%=l_accd %></td>
  <td colspan=2 class=xl24>Level :</td>
  <td colspan=2 class=xl38><%=LevelName%></td>
  <td class=xl34></td>
  <td colspan=8 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl24 style='height:12.75pt'></td>
  <td colspan=3 class=xl40></td>
  <td colspan=2 class=xl24></td>
  <td colspan=2 class=xl44>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl28></td>
  <td colspan=3 class=xl44>&nbsp;</td>
  <td class=xl28></td>
  <td colspan=2 class=xl44>&nbsp;</td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl25 style='height:12.75pt'>Group</td>
  <td class=xl25 style='border-left:none'>Seq</td>
  <td class=xl25 style='border-left:none'>Code</td>
  <td class=xl25 style='border-left:none'>Header</td>
  <td class=xl25 style='border-left:none'>Acc Code</td>
  <td class=xl25 style='border-left:none'>Acc Name</td>
  <td class=xl25 style='border-top:none;border-left:none'>Local Acc Name</td>
  <td class=xl25 style='border-top:none;border-left:none'>Korean Acc Name</td>
  <td class=xl25 style='border-top:none;border-left:none'>Print</td>
  <td class=xl25 style='border-top:none;border-left:none'>L/R</td>
  <td class=xl25 style='border-left:none'>Font Stype</td>
  <td class=xl25 style='border-top:none;border-left:none'>Rem</td>
  <td class=xl25 style='border-top:none;border-left:none'>Color</td>
  <td class=xl25 style='border-top:none;border-left:none'>Level</td>
  <td class=xl25 style='border-left:none'>Formular1</td>
  <td class=xl25 style='border-top:none;border-left:none'>Formular2</td>
  <td class=xl25 style='border-top:none;border-left:none'>Formular3</td>
  <td class=xl25 style='border-left:none'>Formular4</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <%
     string color ="";
     for (int i = 0; i < dt.Rows.Count; i++)
     {
         color = dt.Rows[i][14].ToString();
         if (color == "Orange")
         {
        
  %>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl36 style='border-right:.5pt dashed black;
  height:12.75pt'><%=dt.Rows[i][1]%></td>
  <td class=xl29 style='border-left:none' x:num><%=dt.Rows[i][2]%></td>
  <td class=xl29 style='border-left:none' x:num><%=dt.Rows[i][3]%></td>
  <td class=xl30 style='border-left:none'><%=dt.Rows[i][4]%></td>
  <td class=xl30 align=right style='border-left:none' x:num><%=dt.Rows[i][6]%></td>
  <td class=xl31 style='border-left:none'><%=dt.Rows[i][7]%></td>
  <td class=xl31 style='border-left:none'><%=dt.Rows[i][8]%></td>
  <td class=xl31 style='border-left:none'><%=dt.Rows[i][9]%></td>
  <td class=xl29 style='border-left:none'><%=dt.Rows[i][10]%></td>
  <td class=xl29 style='border-left:none'><%=dt.Rows[i][11]%></td>
  <td class=xl29 style='border-left:none'><%=dt.Rows[i][12]%></td>
  <td class=xl29 style='border-left:none'><%=dt.Rows[i][13]%></td>
  <td class=xl29 style='border-left:none'><%=dt.Rows[i][14]%></td>
  <td class=xl29 style='border-left:none'><%=dt.Rows[i][15]%></td>
  <td class=xl29 style='border-left:none'><%=dt.Rows[i][16]%></td>
  <td class=xl32 style='border-left:none'><%=dt.Rows[i][17]%></td>
  <td class=xl32 style='border-left:none'><%=dt.Rows[i][18]%></td>
  <td class=xl33 style='border-left:none'><%=dt.Rows[i][19]%></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <%
     }
     else
         if (color == "Blue")
         {
                  %>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl50 style='border-right:.5pt dashed black;
  height:12.75pt'><%=dt.Rows[i][1]%></td>
  <td class=xl45 style='border-left:none' x:num><%=dt.Rows[i][2]%></td>
  <td class=xl45 style='border-left:none' x:num><%=dt.Rows[i][3]%></td>
  <td class=xl46 style='border-left:none'><%=dt.Rows[i][4]%></td>
  <td class=xl46 align=right style='border-left:none' x:num><%=dt.Rows[i][6]%></td>
  <td class=xl47 style='border-left:none'><%=dt.Rows[i][7]%></td>
  <td class=xl47 style='border-left:none'><%=dt.Rows[i][8]%></td>
  <td class=xl47 style='border-left:none'><%=dt.Rows[i][9]%></td>
  <td class=xl45 style='border-left:none'><%=dt.Rows[i][10]%></td>
  <td class=xl45 style='border-left:none'><%=dt.Rows[i][11]%></td>
  <td class=xl45 style='border-left:none'><%=dt.Rows[i][12]%></td>
  <td class=xl45 style='border-left:none'><%=dt.Rows[i][13]%></td>
  <td class=xl45 style='border-left:none'><%=dt.Rows[i][14]%></td>
  <td class=xl45 style='border-left:none'><%=dt.Rows[i][15]%></td>
  <td class=xl45 style='border-left:none'><%=dt.Rows[i][16]%></td>
  <td class=xl48 style='border-left:none'><%=dt.Rows[i][17]%></td>
  <td class=xl48 style='border-left:none'><%=dt.Rows[i][18]%></td>
  <td class=xl49 style='border-left:none'><%=dt.Rows[i][19]%></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>                 
      <%
     }else
     
                      %> 
  <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl56 style='border-right:.5pt dashed black;
  height:12.75pt'><%=dt.Rows[i][1]%></td>
  <td class=xl51 style='border-left:none' x:num><%=dt.Rows[i][2]%></td>
  <td class=xl51 style='border-left:none' x:num><%=dt.Rows[i][3]%></td>
  <td class=xl52 style='border-left:none'><%=dt.Rows[i][4]%></td>
  <td class=xl52 align=right style='border-left:none' x:num><%=dt.Rows[i][6]%></td>
  <td class=xl53 style='border-left:none'><%=dt.Rows[i][7]%></td>
  <td class=xl53 style='border-left:none'><%=dt.Rows[i][8]%></td>
  <td class=xl53 style='border-left:none'><%=dt.Rows[i][9]%></td>
  <td class=xl51 style='border-left:none'><%=dt.Rows[i][10]%></td>
  <td class=xl51 style='border-left:none'><%=dt.Rows[i][11]%></td>
  <td class=xl51 style='border-left:none'><%=dt.Rows[i][12]%></td>
  <td class=xl51 style='border-left:none'><%=dt.Rows[i][13]%></td>
  <td class=xl51 style='border-left:none'><%=dt.Rows[i][14]%></td>
  <td class=xl51 style='border-left:none'><%=dt.Rows[i][15]%></td>
  <td class=xl51 style='border-left:none'><%=dt.Rows[i][16]%></td>
  <td class=xl54 style='border-left:none'><%=dt.Rows[i][17]%></td>
  <td class=xl54 style='border-left:none'><%=dt.Rows[i][18]%></td>
  <td class=xl55 style='border-left:none'><%=dt.Rows[i][19]%></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>      
 <%
}               
         %>                               
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=38 style='width:29pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=160 style='width:120pt'></td>
  <td width=160 style='width:120pt'></td>
  <td width=160 style='width:120pt'></td>
  <td width=35 style='width:26pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=135 style='width:101pt'></td>
  <td width=135 style='width:101pt'></td>
  <td width=135 style='width:101pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=150 style='width:113pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
