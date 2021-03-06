﻿<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_Seq = Request["Seq"];
    string p_Date = "";
    string p_Month = "";
    string p_Year = "";
    string p_D_Acc_No = "";
    string p_D_Acc_Nm = "";
    string p_Add_Appli = "";
    string p_D_Bank = "";
    string p_C_Acc_No = "";
    string p_C_Acc_Nm = "";
    string p_C_Add = "";
    string p_C_Bank = "";
    string p_Remark = "";
    string p_So = "";
    string p_Tel_No = "";
    string p_Branch_Benefi = "";
    DataTable dt = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030", p_Seq);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is not data !!");
        Response.End();
    }
    else
    {
        p_Date = dt.Rows[0][15].ToString();
        p_Month = dt.Rows[0][16].ToString();
        p_Year = dt.Rows[0][17].ToString();
        p_D_Acc_No = dt.Rows[0][24].ToString();
        p_D_Acc_No = dt.Rows[0][8].ToString();
        p_D_Acc_Nm = dt.Rows[0][12].ToString();
        //p_D_Add = dt.Rows[0][25].ToString();
        p_D_Bank = dt.Rows[0][9].ToString();
        p_C_Acc_No = dt.Rows[0][0].ToString();
        p_C_Acc_Nm = dt.Rows[0][19].ToString();
        //p_C_Add = dt.Rows[0][26].ToString();
        p_C_Bank = dt.Rows[0][1].ToString();
        p_Remark = dt.Rows[0][13].ToString();//eng
        p_So = dt.Rows[0][11].ToString();
        p_Tel_No = dt.Rows[0][23].ToString();
        p_Add_Appli = dt.Rows[0][21].ToString();
        p_Branch_Benefi = dt.Rows[0][7].ToString();
    }

    //Response.Write(_str_Dr[0]);
    //Response.End();
    string p_Amt = "";
    string p_Ccy = "";
    string Inword = "";
    DataTable dt_Amount = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030_1", p_Seq);
    if (dt_Amount.Rows.Count > 0)
    {
        p_Amt = dt_Amount.Rows[0][13].ToString();
        p_Ccy = dt_Amount.Rows[0][3].ToString();
              
        Inword = CommondLib.Num2EngText(dt_Amount.Rows[0][9].ToString(), p_Ccy);
        string SQL3 = " SELECT upper(substr(trim('" + Inword + "'),1,1)) || substr(lower(trim('" + Inword + "')),2, length(trim('" + Inword + "')))  from dual ";
        DataTable dt_t = ESysLib.TableReadOpen(SQL3);

        if (dt_t.Rows.Count > 0)
        {
            Inword = dt_t.Rows[0][0].ToString();
        }
       
    }
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="SHB_files/filelist.xml">
<link rel=Edit-Time-Data href="SHB_files/editdata.mso">
<link rel=OLE-Object-Data href="SHB_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>KENZIE</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2012-01-13T08:19:17Z</o:LastPrinted>
  <o:Created>2012-01-11T04:20:11Z</o:Created>
  <o:LastSaved>2012-01-13T08:20:52Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:0in .54in 0in .51in;
	mso-header-margin:0in;
	mso-footer-margin:0in;}
.font12
	{color:windowtext;
	font-size:16.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font14
	{color:windowtext;
	font-size:26.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font15
	{color:windowtext;
	font-size:30.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font16
	{color:windowtext;
	font-size:22.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font19
	{color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font20
	{color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font22
	{color:#3366FF;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font23
	{color:#3366FF;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font25
	{color:#3366FF;
	font-size:13.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
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
	padding:0px;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:17.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl30
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:34.0pt;
	font-family:"Century Gothic", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl33
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl34
	{mso-style-parent:style0;
	font-size:26.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:32.0pt;
	font-family:"Century Gothic", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:17.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl48
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl49
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl51
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl52
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:14.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl53
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
.xl54
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl55
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl56
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl57
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl58
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:14.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl60
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl61
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl62
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl63
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
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
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>69</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:TopRowVisible>42</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>52</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8760</x:WindowHeight>
  <x:WindowWidth>15315</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>135</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=943 style='border-collapse:
 collapse;table-layout:fixed;width:711pt'>
 <col class=xl24 width=61 span=3 style='mso-width-source:userset;mso-width-alt:
 2230;width:46pt'>
 <col class=xl24 width=48 style='mso-width-source:userset;mso-width-alt:1755;
 width:36pt'>
 <col class=xl24 width=61 span=5 style='mso-width-source:userset;mso-width-alt:
 2230;width:46pt'>
 <col class=xl24 width=50 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col class=xl24 width=117 span=3 style='mso-width-source:userset;mso-width-alt:
 4278;width:88pt'>
 <col class=xl24 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:402'>
 <col class=xl24 width=6 style='mso-width-source:userset;mso-width-alt:219;
 width:5pt'>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl24 width=61 style='height:18.75pt;width:46pt'></td>
  <td class=xl24 width=61 style='width:46pt'></td>
  <td class=xl24 width=61 style='width:46pt'></td>
  <td class=xl24 width=76 style='width:57pt'></td>
  <td class=xl24 width=61 style='width:46pt'></td>
  <td class=xl24 width=61 style='width:46pt'></td>
  <td class=xl24 width=61 style='width:46pt'></td>
  <td class=xl24 width=61 style='width:46pt'></td>
  <td class=xl24 width=61 style='width:46pt'></td>
  <td class=xl24 width=50 style='width:38pt'></td>
  <td colspan=3 class=xl41 width=330 style='width:249pt'>Bank use only</td>
  <td class=xl24 width=0></td>
  <td class=xl24 width=6 style='width:5pt'></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 style='height:23.25pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
   id="_x0000_t75" coordsize="21600,21600" o:spt="75" o:preferrelative="t"
   path="m@4@5l@4@11@9@11@9@5xe" filled="f" stroked="f">
   <v:stroke joinstyle="miter"/>
   <v:formulas>
    <v:f eqn="if lineDrawn pixelLineWidth 0"/>
    <v:f eqn="sum @0 1 0"/>
    <v:f eqn="sum 0 0 @1"/>
    <v:f eqn="prod @2 1 2"/>
    <v:f eqn="prod @3 21600 pixelWidth"/>
    <v:f eqn="prod @3 21600 pixelHeight"/>
    <v:f eqn="sum @0 0 1"/>
    <v:f eqn="prod @6 1 2"/>
    <v:f eqn="prod @7 21600 pixelWidth"/>
    <v:f eqn="sum @8 21600 0"/>
    <v:f eqn="prod @7 21600 pixelHeight"/>
    <v:f eqn="sum @10 21600 0"/>
   </v:formulas>
   <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
   <o:lock v:ext="edit" aspectratio="t"/>
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:5.25pt;margin-top:15.75pt;width:48.75pt;height:48pt;z-index:1'>
   <v:imagedata src="SHB_files/image001.png" o:title="20111201055919_viipipdotcom_1185shinhan_bank_logo_2792"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:7px;margin-top:21px;width:65px;
  height:64px'><img width=65 height=64 src="SHB_files/image002.jpg" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=31 class=xl24 width=61 style='height:23.25pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=9 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl41>Dành cho ngân hàng</td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=10 rowspan=2 height=39 class=xl35 width=614 style='border-right:
  .5pt solid black;height:29.25pt;width:463pt'><span
  style='mso-spacerun:yes'>       </span><font class="font14">S</font><font
  class="font16">HINHAN </font><font class="font14">V</font><font class="font16">IETNAM
  </font><font class="font14">B</font><font class="font16">ANK Limited<span
  style='mso-spacerun:yes'>  </span></font></td>
  <td class=xl42 style='border-left:none'>Prepared</td>
  <td class=xl42 style='border-left:none'>Checked</td>
  <td class=xl42 style='border-left:none'>Approved</td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.75pt'>
  <td rowspan=3 height=77 class=xl42 style='height:57.75pt;border-top:none;border-left:.5pt solid black'></td>
  <td rowspan=3 class=xl42 style='border-top:none'></td>
  <td rowspan=3 class=xl42 style='border-top:none'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td colspan=10 height=37 class=xl34 width=614 style='border-right:.5pt solid black;
  height:27.75pt;width:463pt'>H<font class="font16">ANOI </font><font
  class="font14">B</font><font class="font16">RANCH</font></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl24 style='height:20.25pt'></td>
  <td class=xl28 colspan=5 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>        </span>Telephone: (84.4) 35538400</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=5 style='mso-height-source:userset;height:3.75pt'>
  <td height=5 class=xl24 style='height:3.75pt'></td>
  <td class=xl27></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl24 style='height:21.75pt'></td>
  <td class=xl29 colspan=5 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>        </span>Facsimile: (84.4) 35550505</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl44 colspan=2 style='mso-ignore:colspan'>BANK'S REF.</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=43 style='mso-height-source:userset;height:32.25pt'>
  <td colspan=12 height=43 class=xl37 style='height:32.25pt'>송금신청서</td>
  <td class=xl30></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=13 height=38 class=xl40 style='height:28.5pt'><span
  style='mso-spacerun:yes'>              </span>APPLICATION FOR REMITTANCE/GIẤY
  CHUYỂN TIỀN</td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='height:19.5pt'>
  <td height=26 colspan=4 class=xl24 style='height:19.5pt;mso-ignore:colspan'></td>
  <td rowspan=2 height=53 class=xl24 width=61 style='mso-ignore:colspan-rowspan;
  height:39.75pt;width:46pt'><!--[if gte vml 1]><v:rect id="_x0000_s1026"
   style='position:absolute;margin-left:15.75pt;margin-top:10.5pt;width:25.5pt;
   height:25.5pt;z-index:2' fillcolor="window [65]" strokecolor="windowText [64]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=20 height=13></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=36 height=36 src="SHB_files/image003.gif" v:shapes="_x0000_s1026"></td>
    <td width=5></td>
   </tr>
   <tr>
    <td height=4></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:45.75pt;height:39.75pt'></span><![endif]--></td>
  <td class=xl32 colspan=2 style='mso-ignore:colspan'>DOMESTIC</td>
  <td rowspan=2 height=53 class=xl31 width=61 style='mso-ignore:colspan-rowspan;
  height:39.75pt;width:46pt'><!--[if gte vml 1]><v:rect id="_x0000_s1027"
   style='position:absolute;margin-left:18.75pt;margin-top:10.5pt;width:25.5pt;
   height:25.5pt;z-index:3' fillcolor="window [65]" strokecolor="windowText [64]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=24 height=13></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=36 height=36 src="SHB_files/image003.gif" v:shapes="_x0000_s1027"></td>
    <td width=1></td>
   </tr>
   <tr>
    <td height=4></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:45.75pt;height:39.75pt'></span><![endif]--></td>
  <td class=xl31 colspan=2 style='mso-ignore:colspan'>OVERSEAS</td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 colspan=4 class=xl24 style='height:20.25pt;mso-ignore:colspan'></td>
  <td class=xl33 colspan=2 style='mso-ignore:colspan'>Nội địa</td>
  <td class=xl33 colspan=2 style='mso-ignore:colspan'>Nước ngoài</td>
  <td colspan=3 class=xl38>Date / Ngày:..<%=p_Date %>../..<%=p_Month %>../..<%=p_Year %>…</td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=13 rowspan=2 height=126 class=xl39 width=944 style='height:94.5pt;
  width:712pt'>I (We) apply for remittance beating any responsibility under
  this remittance and also agreeing that is<br>subject to the Bank's term and conditions and the Government's law as
  well.<br><font class="font12">Đề nghị Ngân hàng chuyển tiền cho chúng tôi theo
  nội dung dưới đây, chúng tôi cam kết chịu trách<br>nhiệm cũng như tuân theo các qui chế về chuyển tiền của Nhà nước và
  qui định của Ngân hàng.</font></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=109 style='mso-height-source:userset;height:81.75pt'>
  <td height=109 class=xl24 style='height:81.75pt'></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl62 colspan=3 style='height:20.1pt;mso-ignore:colspan'>1.AMOUNT
  <font class="font22">금액</font></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1034"
   style='position:absolute;z-index:9' from="36pt,18pt" to="384pt,18pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:9;margin-left:47px;
  margin-top:23px;width:466px;height:2px'><img width=466 height=2
  src="SHB_files/image004.gif" v:shapes="_x0000_s1034"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl43 width=76 style='height:20.1pt;width:57pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl47 colspan=3 style='mso-ignore:colspan'><%=p_Amt %></td>
  <td colspan=6 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl48 colspan=3 style='height:20.1pt;mso-ignore:colspan'>Số
  tiền (In number)</td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1035"
   style='position:absolute;flip:y;z-index:10' from="36pt,18pt" to="565.5pt,18pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:10;margin-left:47px;
  margin-top:23px;width:708px;height:2px'><img width=708 height=2
  src="SHB_files/image005.gif" v:shapes="_x0000_s1035"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl43 width=76 style='height:20.1pt;width:57pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=9 rowspan=2 class=xl49 width=685 style='width:517pt;vertical-align:top'><%=Inword %></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl48 colspan=2 style='height:20.1pt;mso-ignore:colspan'>(In
  words)</td>
  <td class=xl43></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1035"
   style='position:absolute;flip:y;z-index:10' from="36pt,18pt" to="565.5pt,18pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:10;margin-left:47px;
  margin-top:23px;width:708px;height:2px'><img width=708 height=2
  src="SHB_files/image005.gif" v:shapes="_x0000_s1035"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl43 width=76 style='height:20.1pt;width:57pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=13 class=xl43 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl62 colspan=3 style='height:20.1pt;mso-ignore:colspan'>2.
  APPLICANT</td>
  <td class=xl43></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1036"
   style='position:absolute;z-index:11' from="39pt,17.25pt" to="351.75pt,17.25pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1037"
   style='position:absolute;z-index:12' from="431.25pt,17.25pt" to="513.75pt,17.25pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:11;margin-left:51px;
  margin-top:22px;width:635px;height:2px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=419></td>
    <td width=104></td>
    <td width=112></td>
   </tr>
   <tr>
    <td height=2></td>
    <td align=left valign=top><img width=419 height=2
    src="SHB_files/image006.gif" v:shapes="_x0000_s1036"></td>
    <td></td>
    <td align=left valign=top><img width=112 height=2
    src="SHB_files/image007.gif" v:shapes="_x0000_s1037"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl50 width=61 style='height:20.1pt;width:46pt'
    x:str="Name: ">Name:<span style='mso-spacerun:yes'> </span></td>
   </tr>
  </table>
  </span></td>
  <td class=xl43 colspan=6 style='mso-ignore:colspan;font-size:13.0pt'><%=p_D_Acc_Nm%></td>
  <td class=xl51>ID (P/P) No</td>
  <td class=xl43></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl52 colspan=3 style='height:20.1pt;mso-ignore:colspan'>송금
  보내는 이</td>
  <td class=xl43></td>
  <td class=xl48>Tên</td>
  <td colspan=6 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl53>Số CMND (P/P)</td>
  <td class=xl43></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl48 colspan=3 style='height:20.1pt;mso-ignore:colspan'>Đơn
  vị chuyển tiền</td>
  <td class=xl43></td>
  <td class=xl54 colspan=2 style='mso-ignore:colspan'>Tel. No/<font
  class="font19">Điện th</font><span style='display:none'><font class="font19">oại:<span
  style='mso-spacerun:yes'>  </span></font><font class="font20"><%=p_Tel_No%></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1038"
   style='position:absolute;z-index:13' from="23.25pt,17.25pt" to="421.5pt,17.25pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:13;margin-left:30px;
  margin-top:22px;width:533px;height:2px'><img width=533 height=2
  src="SHB_files/image008.gif" v:shapes="_x0000_s1038"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl54 width=61 style='height:20.1pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl55 style='height:20.1pt'></td>
  <td colspan=3 class=xl50 style='mso-ignore:colspan'></td>
  <td class=xl50 colspan=2 style='mso-ignore:colspan'>Address/<font
  class="font19">Địa ch</font><span style='display:none'><font class="font19">ỉ:
  </font><font class="font20"><%=p_Add_Appli%></font></span></td>
  <td colspan=7 height=26 class=xl50 width=563 style='mso-ignore:colspan-rowspan;
  height:20.1pt;width:425pt'><!--[if gte vml 1]><v:line id="_x0000_s1040"
   style='position:absolute;z-index:14' from="8.25pt,18pt" to="420.75pt,18pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=10 height=23></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=552 height=2 src="SHB_files/image009.gif" v:shapes="_x0000_s1040"></td>
    <td width=1></td>
   </tr>
   <tr>
    <td height=1></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:422.25pt;height:19.5pt'></span><![endif]--></td>
  <td class=xl25></td>
  <td class=xl25></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl56 style='height:20.1pt'></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl50>Debit A<span style='display:none'>ccount:<span
  style='mso-spacerun:yes'>  </span><%=p_D_Acc_No %></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1041"
   style='position:absolute;z-index:15' from="42pt,17.25pt" to="312pt,17.25pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1042"
   style='position:absolute;z-index:16' from="378.75pt,16.5pt" to="468pt,16.5pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:15;margin-left:55px;
  margin-top:21px;width:570px;height:3px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=362></td>
    <td width=87></td>
    <td width=121></td>
   </tr>
   <tr>
    <td height=1></td>
    <td colspan=2></td>
    <td rowspan=2 align=left valign=top><img width=121 height=2
    src="SHB_files/image010.gif" v:shapes="_x0000_s1042"></td>
   </tr>
   <tr>
    <td height=1></td>
    <td rowspan=2 align=left valign=top><img width=362 height=2
    src="SHB_files/image011.gif" v:shapes="_x0000_s1041"></td>
   </tr>
   <tr>
    <td height=1></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl50 width=61 style='height:20.1pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=5 class=xl50 style='mso-ignore:colspan'></td>
  <td class=xl51>Secret No.</td>
  <td class=xl43></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl56 style='height:20.1pt'></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl48 colspan=3 style='mso-ignore:colspan'>Rút từ tài khoản số</td>
  <td colspan=4 class=xl54 style='mso-ignore:colspan'></td>
  <td class=xl53>Số bí mật</td>
  <td class=xl43></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl62 colspan=3 style='height:20.1pt;mso-ignore:colspan'>3.BENEFICIARY</td>
  <td class=xl43></td>
  <td class=xl50>Name/<font class="font19">T</font><span style='display:none'><font
  class="font19">ên:<span style='mso-spacerun:yes'>  </span></font><font
  class="font20"><%=p_C_Acc_Nm%></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1043"
   style='position:absolute;z-index:17' from="18pt,17.25pt" to="468pt,17.25pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:17;margin-left:23px;
  margin-top:22px;width:602px;height:2px'><img width=602 height=2
  src="SHB_files/image012.gif" v:shapes="_x0000_s1043"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl43 width=61 style='height:20.1pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=7 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl52 colspan=2 style='height:21.0pt;mso-ignore:colspan'>송금
  받는 이</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl43 colspan=2 style='mso-ignore:colspan'>Tel. No/<font
  class="font19">Điện th</font><span style='display:none'><font class="font19">oại:
  </font><font class="font20"></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1044"
   style='position:absolute;z-index:18' from="20.25pt,18pt" to="422.25pt,18pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:18;margin-left:26px;
  margin-top:23px;width:538px;height:2px'><img width=538 height=2
  src="SHB_files/image013.gif" v:shapes="_x0000_s1044"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=28 class=xl43 width=61 style='height:21.0pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl48 colspan=3 style='height:20.1pt;mso-ignore:colspan'>Đơn
  vị thụ hưởng</td>
  <td class=xl43></td>
  <td class=xl43 colspan=2 style='mso-ignore:colspan'>Address/Địa ch<span
  style='display:none'>ỉ:<span style='mso-spacerun:yes'>   
  </span></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1045"
   style='position:absolute;z-index:19' from="9pt,17.25pt" to="422.25pt,17.25pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:19;margin-left:11px;
  margin-top:22px;width:553px;height:2px'><img width=553 height=2
  src="SHB_files/image014.gif" v:shapes="_x0000_s1045"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl43 width=61 style='height:20.1pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl62 colspan=4 style='height:20.1pt;mso-ignore:colspan'>4.BENEFICIARY
  BANK</td>
  <td class=xl43 colspan=2 style='mso-ignore:colspan'>Name/<font class="font19">Ngân
  hàn</font><span style='display:none'><font class="font19">g:<span
  style='mso-spacerun:yes'>  </span></font><font class="font20"><%=p_C_Bank%></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1046"
   style='position:absolute;z-index:20' from="14.25pt,17.25pt" to="422.25pt,17.25pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:20;margin-left:18px;
  margin-top:22px;width:546px;height:2px'><img width=546 height=2
  src="SHB_files/image015.gif" v:shapes="_x0000_s1046"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl43 width=61 style='height:20.1pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl52 colspan=2 style='height:20.1pt;mso-ignore:colspan'>송금
  받는 은</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl43 colspan=2 style='mso-ignore:colspan'>Branch/<font
  class="font19">Chi nhá</font><span style='display:none'><font class="font19">nh:<span
  style='mso-spacerun:yes'>  </span></font><font class="font20"><%=p_Branch_Benefi%></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1047"
   style='position:absolute;flip:y;z-index:21' from="18pt,17.25pt" to="422.25pt,17.25pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:21;margin-left:23px;
  margin-top:22px;width:541px;height:2px'><img width=541 height=2
  src="SHB_files/image016.gif" v:shapes="_x0000_s1047"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl43 width=61 style='height:20.1pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl48 colspan=3 style='height:20.1pt;mso-ignore:colspan'>Ngân
  hàng thụ hưởng</td>
  <td class=xl43></td>
  <td class=xl43 colspan=2 style='mso-ignore:colspan'>Swift Code/<font
  class="font19">AB</font><span style='display:none'><font class="font19">A
  No.:<span style='mso-spacerun:yes'>  </span></font><font class="font20"></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1048"
   style='position:absolute;flip:y;z-index:22' from="30pt,17.25pt" to="422.25pt,17.25pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:22;margin-left:39px;
  margin-top:22px;width:525px;height:2px'><img width=525 height=2
  src="SHB_files/image017.gif" v:shapes="_x0000_s1048"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl43 width=61 style='height:20.1pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl56 style='height:20.1pt'></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl43 colspan=3 style='mso-ignore:colspan'>Account No/<font
  class="font19">Số Tài Kh</font><span style='display:none'><font class="font19">oản:<span
  style='mso-spacerun:yes'>  </span></font><font class="font20"><%=p_C_Acc_No%></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1049"
   style='position:absolute;z-index:23' from="19.5pt,17.25pt" to="376.5pt,17.25pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:23;margin-left:25px;
  margin-top:22px;width:478px;height:2px'><img width=478 height=2
  src="SHB_files/image018.gif" v:shapes="_x0000_s1049"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl43 width=61 style='height:20.1pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=5 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=4 height=26 class=xl61 style='height:20.1pt'>5.CORRESPONDENT BANK</td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1050"
   style='position:absolute;z-index:24' from=".75pt,17.25pt" to="513.75pt,17.25pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:24;margin-left:0px;
  margin-top:22px;width:686px;height:2px'><img width=686 height=2
  src="SHB_files/image019.gif" v:shapes="_x0000_s1050"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl57 width=61 style='height:20.1pt;width:46pt'><span
    style='mso-spacerun:yes'> </span><font class="font20"></font></td>
   </tr>
  </table>
  </span></td>
  <td colspan=8 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl52 colspan=2 style='height:20.1pt;mso-ignore:colspan'>중계은행</td>
  <td colspan=11 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl48 colspan=3 style='height:20.1pt;mso-ignore:colspan'>Ngân
  hàng trung gian</td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1051"
   style='position:absolute;z-index:25' from="57pt,13.5pt" to="570.75pt,13.5pt"
   strokecolor="windowText [64]" o:insetmode="auto">
   <x:ClientData ObjectType="Line">
    <x:Anchor>
     4, 0, 35, 18, 13, 0, 35, 18</x:Anchor>
   </x:ClientData>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:25;margin-left:75px;margin-top:17px;width:687px;height:2px'><img
  width=687 height=2 src="SHB_files/image005.gif" v:shapes="_x0000_s1051"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl43 width=76 style='height:20.1pt;width:57pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=9 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl62 colspan=2 style='height:20.1pt;mso-ignore:colspan'>6.MESSAGE</td>
  <td class=xl43></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1035"
   style='position:absolute;flip:y;z-index:10' from="36pt,18pt" to="565.5pt,18pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:10;margin-left:47px;
  margin-top:23px;width:708px;height:2px'><img width=708 height=2
  src="SHB_files/image005.gif" v:shapes="_x0000_s1035"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl43 width=76 style='height:20.1pt;width:57pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=9 rowspan=3 class=xl58 width=685 style='width:517pt'><%=p_Remark %></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl52 colspan=2 style='height:20.1pt;mso-ignore:colspan'>송금내용</td>
  <td class=xl43></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1035"
   style='position:absolute;flip:y;z-index:10' from="36pt,18pt" to="565.5pt,18pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:10;margin-left:47px;
  margin-top:23px;width:708px;height:2px'><img width=708 height=2
  src="SHB_files/image005.gif" v:shapes="_x0000_s1035"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl43 width=76 style='height:20.1pt;width:57pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl48 colspan=3 style='height:20.1pt;mso-ignore:colspan'>Nội
  dung thanh toán</td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1035"
   style='position:absolute;flip:y;z-index:10' from="36pt,18pt" to="565.5pt,18pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:10;margin-left:47px;
  margin-top:23px;width:708px;height:2px'><img width=708 height=2
  src="SHB_files/image005.gif" v:shapes="_x0000_s1035"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl43 width=76 style='height:20.1pt;width:57pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=13 class=xl43 style='height:20.1pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl63 colspan=4 style='height:18.75pt;mso-ignore:colspan'>7.CHARGER
  <font class="font25">수수료 부담</font></td>
  <td colspan=9 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl48 style='height:18.75pt'>Phí</td>
  <td colspan=12 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl54 colspan=4 style='height:22.5pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>*Shinhan Bank's Charges</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td rowspan=2 height=55 class=xl43 width=61 style='mso-ignore:colspan-rowspan;
  height:41.25pt;width:46pt'><!--[if gte vml 1]><v:rect id="_x0000_s1029"
   style='position:absolute;margin-left:21.75pt;margin-top:15pt;width:21pt;
   height:19.5pt;z-index:4' fillcolor="window [65]" strokecolor="windowText [64]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=28 height=19></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=30 height=28 src="SHB_files/image020.gif" v:shapes="_x0000_s1029"></td>
    <td width=3></td>
   </tr>
   <tr>
    <td height=8></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:45.75pt;height:41.25pt'></span><![endif]--></td>
  <td class=xl50 colspan=2 style='mso-ignore:colspan'>Beneficiary</td>
  <td class=xl43></td>
  <td rowspan=2 height=55 class=xl43 width=110 style='mso-ignore:colspan-rowspan;
  height:41.25pt;width:83pt'><!--[if gte vml 1]><v:rect id="_x0000_s1031"
   style='position:absolute;margin-left:58.5pt;margin-top:15pt;width:21pt;
   height:19.5pt;z-index:6' fillcolor="window [65]" strokecolor="windowText [64]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=77 height=19></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=30 height=28 src="SHB_files/image020.gif" v:shapes="_x0000_s1031"></td>
    <td width=3></td>
   </tr>
   <tr>
    <td height=8></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:82.5pt;height:41.25pt'></span><![endif]--></td>
  <td class=xl50>Application</td>
  <td class=xl43></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl59 colspan=3 style='height:18.75pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>    </span>보내실 때 수수료</td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl55 colspan=3 style='mso-ignore:colspan'>Do người hưởng chịu</td>
  <td class=xl55 colspan=2 style='mso-ignore:colspan'>Do người chuyển chịu</td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl56 colspan=5 style='height:18.75pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>     </span>(Phí tại Ngân hàng Shinhan)</td>
  <td colspan=8 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl54 colspan=4 style='height:22.5pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>*Other Bank's Charges</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td rowspan=2 height=55 class=xl43 width=61 style='mso-ignore:colspan-rowspan;
  height:41.25pt;width:46pt'><!--[if gte vml 1]><v:rect id="_x0000_s1030"
   style='position:absolute;margin-left:21.75pt;margin-top:15pt;width:21pt;
   height:19.5pt;z-index:5' fillcolor="window [65]" strokecolor="windowText [64]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=28 height=19></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=30 height=28 src="SHB_files/image020.gif" v:shapes="_x0000_s1030"></td>
    <td width=3></td>
   </tr>
   <tr>
    <td height=8></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:45.75pt;height:41.25pt'></span><![endif]--></td>
  <td class=xl50 colspan=2 style='mso-ignore:colspan'>Beneficiary</td>
  <td class=xl43></td>
  <td rowspan=2 height=55 class=xl43 width=110 style='mso-ignore:colspan-rowspan;
  height:41.25pt;width:83pt'><!--[if gte vml 1]><v:rect id="_x0000_s1032"
   style='position:absolute;margin-left:58.5pt;margin-top:15pt;width:21pt;
   height:19.5pt;z-index:7' fillcolor="window [65]" strokecolor="windowText [64]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=77 height=19></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=30 height=28 src="SHB_files/image020.gif" v:shapes="_x0000_s1032"></td>
    <td width=3></td>
   </tr>
   <tr>
    <td height=8></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:82.5pt;height:41.25pt'></span><![endif]--></td>
  <td class=xl50>Application</td>
  <td class=xl43></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl59 colspan=3 style='height:18.75pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>     </span>그외 수수료</td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl55 colspan=3 style='mso-ignore:colspan'>Do người hưởng chịu</td>
  <td class=xl55 colspan=2 style='mso-ignore:colspan'>Do người chuyển chịu</td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl56 colspan=4 style='height:18.75pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>      </span>(Phí<span style='mso-spacerun:yes'> 
  </span>ngân hàng khác)</td>
  <td colspan=9 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=10 class=xl43 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=10 class=xl43 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=10 class=xl43 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=10 class=xl43 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=10 class=xl24 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=3 height=25 width=330 style='height:18.75pt;width:249pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1033" style='position:absolute;
   z-index:8' from="14.25pt,.75pt" to="247.5pt,.75pt" strokecolor="windowText [64]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:8;margin-left:18px;margin-top:0px;width:313px;
  height:2px'><img width=313 height=2 src="SHB_files/image021.gif" v:shapes="_x0000_s1033"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=3 height=25 class=xl60 width=330 style='height:18.75pt;
    width:249pt'>Signed and Stamped <font class="font23">(</font><font
    class="font22">스템프,서명</font><font class="font23">)</font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=10 class=xl24 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl60>Ký tên, đóng dấu</td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 colspan=15 class=xl24 style='height:16.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 colspan=15 class=xl24 style='height:9.0pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=0></td>
  <td width=6 style='width:5pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
