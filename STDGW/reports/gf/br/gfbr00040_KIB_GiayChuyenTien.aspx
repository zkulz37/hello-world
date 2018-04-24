<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("acnt");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_Seq = Request["p_Seq"];
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
    string p_D_Add = "";
	string p_Add_Beneficiary = "";
    DataTable dt = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030", p_Seq);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is not data !!");
        Response.End();
    }
    else
    {
        p_Date = dt.Rows[0][10].ToString();
        p_Month = dt.Rows[0][16].ToString();
        p_Year = dt.Rows[0][17].ToString();
        p_D_Acc_No = dt.Rows[0][24].ToString();
        //p_D_Acc_No = dt.Rows[0][8].ToString();
        p_D_Acc_Nm = dt.Rows[0][12].ToString();
        p_D_Add = dt.Rows[0][25].ToString();
        p_D_Bank = dt.Rows[0][9].ToString();
        p_C_Acc_No = dt.Rows[0][0].ToString();
        p_C_Acc_Nm = dt.Rows[0][19].ToString();
        p_C_Add = dt.Rows[0][26].ToString();
        p_C_Bank = dt.Rows[0][1].ToString();
        p_Remark = dt.Rows[0][14].ToString();//eng
        p_So = dt.Rows[0][11].ToString();
        p_Tel_No = dt.Rows[0][23].ToString();
        p_Add_Appli = dt.Rows[0][21].ToString();
        p_Branch_Benefi = dt.Rows[0][7].ToString();
	p_Add_Beneficiary = dt.Rows[0][29].ToString();
    }

    //Response.Write(_str_Dr[0]);
    //Response.End();
    string p_Amt = "";
    string p_Ccy = "";
    string Inword = "";
    DataTable dt_Amount = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030_1", p_Seq);
    if (dt_Amount.Rows.Count > 0)
    {
        p_Amt = dt_Amount.Rows[0][12].ToString();
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
<link rel=File-List href="gfbr00040_KIB_GiayChuyeTien_files/filelist.xml">
<link rel=Edit-Time-Data href="gfbr00040_KIB_GiayChuyeTien_files/editdata.mso">
<link rel=OLE-Object-Data href="gfbr00040_KIB_GiayChuyeTien_files/oledata.mso">
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
  <o:LastAuthor>Kenzie</o:LastAuthor>
  <o:LastPrinted>2013-07-10T04:13:27Z</o:LastPrinted>
  <o:Created>2012-01-11T04:20:11Z</o:Created>
  <o:LastSaved>2013-07-10T06:13:37Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:0in .25in 0in .5in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
	mso-horizontal-page-align:center;}
.font6
	{color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font19
	{color:windowtext;
	font-size:14.0pt;
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:34.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:26.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	color:blue;
	font-size:32.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:17.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl47
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl49
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
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
      <x:Scale>72</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:TopRowVisible>42</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>61</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9570</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1092">
  <o:colormenu v:ext="edit" fillcolor="none [63]" strokecolor="none [63]"/>
 </o:shapedefaults></xml><![endif]--><!--[if gte mso 9]><xml>
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
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 width=61 style='height:8.25pt;width:46pt' align=left
  valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75" coordsize="21600,21600"
   o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe" filled="f"
   stroked="f">
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
  </v:shapetype><v:shape id="Picture_x0020_18" o:spid="_x0000_s1056" type="#_x0000_t75"
   style='position:absolute;margin-left:0;margin-top:0;width:222.75pt;height:90pt;
   z-index:21;visibility:visible'>
   <v:imagedata src="gfbr00040_KIB_GiayChuyeTien_files/image001.png" o:title=""/>
  </v:shape><v:shape id="_x0000_s1091" type="#_x0000_t75" style='position:absolute;
   margin-left:509.25pt;margin-top:0;width:195pt;height:81pt;z-index:52'>
   <v:imagedata src="gfbr00040_KIB_GiayChuyeTien_files/image002.png" o:title="Ảnh chụp màn hình_2013-07-06_091624"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><v:line id="_x0000_s1058" style='position:absolute;z-index:22'
   from="594.75pt,103.5pt" to="702pt,103.5pt" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
   <x:ClientData ObjectType="Line">
    <x:Anchor>
     11, 90, 5, 25, 12, 116, 5, 25</x:Anchor>
   </x:ClientData>
  </v:line><v:shape id="Picture_x0020_16" o:spid="_x0000_s1059" type="#_x0000_t75"
   style='position:absolute;margin-left:273pt;margin-top:103.5pt;width:121.5pt;
   height:30pt;z-index:23;visibility:visible'>
   <v:imagedata src="gfbr00040_KIB_GiayChuyeTien_files/image003.png" o:title=""/>
  </v:shape><v:shape id="Picture_x0020_17" o:spid="_x0000_s1060" type="#_x0000_t75"
   style='position:absolute;margin-left:72.75pt;margin-top:129.75pt;width:534.75pt;
   height:35.25pt;z-index:24;visibility:visible'>
   <v:imagedata src="gfbr00040_KIB_GiayChuyeTien_files/image004.png" o:title=""/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:21;margin-left:0px;margin-top:0px;width:939px;
  height:220px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=97></td>
    <td width=200></td>
    <td width=382></td>
    <td width=258></td>
    <td width=2></td>
   </tr>
   <tr>
    <td height=108></td>
    <td colspan=2 rowspan=2 align=left valign=top><img width=297 height=120
    src="gfbr00040_KIB_GiayChuyeTien_files/image005.jpg" v:shapes="Picture_x0020_18"></td>
    <td></td>
    <td colspan=2 align=left valign=top><img width=260 height=108
    src="gfbr00040_KIB_GiayChuyeTien_files/image006.gif" v:shapes="_x0000_s1091"></td>
   </tr>
   <tr>
    <td height=12></td>
   </tr>
   <tr>
    <td height=17></td>
   </tr>
   <tr>
    <td height=83></td>
    <td></td>
    <td colspan=3 align=left valign=top><img width=840 height=83
    src="gfbr00040_KIB_GiayChuyeTien_files/image007.gif" v:shapes="_x0000_s1058 Picture_x0020_16 Picture_x0020_17"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=11 class=xl24 width=61 style='height:8.25pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24 width=61 style='width:46pt'></td>
  <td class=xl24 width=61 style='width:46pt'></td>
  <td class=xl24 width=48 style='width:36pt'></td>
  <td class=xl24 width=61 style='width:46pt'></td>
  <td class=xl24 width=61 style='width:46pt'></td>
  <td class=xl24 width=61 style='width:46pt'></td>
  <td class=xl24 width=61 style='width:46pt'></td>
  <td class=xl24 width=61 style='width:46pt'></td>
  <td class=xl24 width=50 style='width:38pt'></td>
  <td class=xl25 width=117 style='width:88pt'></td>
  <td class=xl25 width=117 style='width:88pt'></td>
  <td class=xl25 width=117 style='width:88pt'></td>
  <td class=xl24 width=0></td>
  <td class=xl24 width=6 style='width:5pt'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=10 rowspan=2 height=39 class=xl43 width=586 style='height:29.25pt;
  width:442pt'></td>
  <td class=xl24></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 class=xl24 style='height:9.75pt'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td colspan=10 height=37 class=xl44 width=586 style='height:27.75pt;
  width:442pt'></td>
  <td class=xl24></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl24 style='height:20.25pt'></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl29>Date/ Ngày:</td>
  <td class=xl30 ><%=p_Date%></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=12 height=38 class=xl45 style='height:28.5pt'></td>
  <td class=xl31></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=13 height=38 class=xl46 style='height:28.5pt'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=4 class=xl24 style='height:18.75pt;mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1026"
   style='position:absolute;margin-left:2.25pt;margin-top:3.75pt;width:10.5pt;
   height:10.5pt;z-index:1' fillcolor="window [65]" strokecolor="windowText [64]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:2px;margin-top:4px;width:16px;
  height:16px'><img width=16 height=16
  src="gfbr00040_KIB_GiayChuyeTien_files/image008.gif" v:shapes="_x0000_s1026"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=25 class=xl27 width=61 style='height:18.75pt;width:46pt'><span
    style='mso-spacerun:yes'>     </span>DOMESTIC</td>
   </tr>
  </table>
  </span></td>
  <td class=xl24></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl32></td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1027"
   style='position:absolute;margin-left:25.5pt;margin-top:5.25pt;width:10.5pt;
   height:10.5pt;z-index:2' fillcolor="window [65]" strokecolor="windowText [64]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:33px;margin-top:6px;width:16px;
  height:16px'><img width=16 height=16
  src="gfbr00040_KIB_GiayChuyeTien_files/image008.gif" v:shapes="_x0000_s1027"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=25 class=xl27 width=117 style='height:18.75pt;width:88pt'><span
    style='mso-spacerun:yes'>           </span>OVERSEAS</td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 colspan=4 class=xl24 style='height:20.25pt;mso-ignore:colspan'></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>     </span>Nội địa</td>
  <td class=xl33></td>
  <td class=xl32></td>
  <td class=xl24></td>
  <td class=xl33></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>           </span>Nước ngoài</td>
  <td class=xl33></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl34 colspan=2 style='height:23.1pt;mso-ignore:colspan'>1.<span
  style='mso-spacerun:yes'>   </span>AMOUNT</td>
  <td class=xl34></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl25 colspan=3 style='height:23.1pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>     </span>Số tiền (In numbe<span style='display:
  none'>r)</span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1034"
   style='position:absolute;z-index:7' from="36pt,21pt" to="219.75pt,21pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:7;margin-left:47px;
  margin-top:27px;width:247px;height:2px'><img width=247 height=2
  src="gfbr00040_KIB_GiayChuyeTien_files/image009.gif" v:shapes="_x0000_s1034"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=48 style='height:23.1pt;width:36pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=4 class=xl47><%=p_Amt%></td>
  <td colspan=5 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 style='height:23.1pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="_x0000_s1062" type="#_x0000_t75" style='position:absolute;margin-left:18.75pt;
   margin-top:1.5pt;width:30pt;height:21pt;z-index:25'>
   <v:imagedata src="gfbr00040_KIB_GiayChuyeTien_files/image010.png" o:title=""/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:25;margin-left:25px;margin-top:2px;width:40px;
  height:28px'><img width=40 height=28
  src="gfbr00040_KIB_GiayChuyeTien_files/image011.jpg" v:shapes="_x0000_s1062"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl25 width=61 style='height:23.1pt;width:46pt'
    x:str="          "><span style='mso-spacerun:yes'>          </span></td>
   </tr>
  </table>
  </span></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'>(In words)</td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1055"
   style='position:absolute;flip:y;z-index:8' from="36pt,21pt" to="564pt,21pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:8;margin-left:47px;
  margin-top:27px;width:706px;height:2px'><img width=706 height=2
  src="gfbr00040_KIB_GiayChuyeTien_files/image012.gif" v:shapes="_x0000_s1055"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=48 style='height:23.1pt;width:36pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=9 class=xl35 style='mso-text-control:shrinktofit;'><%=Inword%></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=13 class=xl27 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl34 colspan=3 style='height:23.1pt;mso-ignore:colspan'>2.<span
  style='mso-spacerun:yes'>   </span>APPLICANT</td>
  <td align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t120"
   coordsize="21600,21600" o:spt="120" path="m10800,qx,10800,10800,21600,21600,10800,10800,xe">
   <v:path gradientshapeok="t" o:connecttype="custom" o:connectlocs="10800,0;3163,3163;0,10800;3163,18437;10800,21600;18437,18437;21600,10800;18437,3163"
    textboxrect="3163,3163,18437,18437"/>
  </v:shapetype><v:shape id="_x0000_s1079" type="#_x0000_t120" style='position:absolute;
   margin-left:35.25pt;margin-top:12pt;width:3.75pt;height:3.75pt;z-index:40'
   fillcolor="#333 [63]" strokecolor="#333 [63]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:40;margin-left:46px;
  margin-top:15px;width:7px;height:7px'><img width=7 height=7
  src="gfbr00040_KIB_GiayChuyeTien_files/image013.gif" v:shapes="_x0000_s1079"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=48 style='height:23.1pt;width:36pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27 x:str=" Name/ Tên: "><span
  style='mso-spacerun:yes'> </span>Name/<span style='display:none'> Tên:<span
  style='mso-spacerun:yes'> </span></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1036"
   style='position:absolute;z-index:9' from="32.25pt,19.5pt" to="483.75pt,19.5pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:9;margin-left:42px;
  margin-top:25px;width:604px;height:2px'><img width=604 height=2
  src="gfbr00040_KIB_GiayChuyeTien_files/image014.gif" v:shapes="_x0000_s1036"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=61 style='height:23.1pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=7 class=xl48 style='mso-text-control:shrinktofit;'><%=p_D_Acc_Nm%></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 colspan=3 class=xl36 style='height:23.1pt;mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1080"
   type="#_x0000_t120" style='position:absolute;margin-left:36pt;margin-top:12pt;
   width:3.75pt;height:3.75pt;z-index:41' fillcolor="#333 [63]" strokecolor="#333 [63]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:41;margin-left:47px;margin-top:15px;width:7px;
  height:7px'><img width=7 height=7
  src="gfbr00040_KIB_GiayChuyeTien_files/image013.gif" v:shapes="_x0000_s1080"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=48 style='height:23.1pt;width:36pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl35 colspan=3 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>ID No/ Số CMND:</td>
  <td colspan=6 class=xl35></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl25 colspan=3 style='height:23.1pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>      </span>Đơn vị chuyển tiề<span
  style='display:none'>n</span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1081"
   type="#_x0000_t120" style='position:absolute;margin-left:36pt;margin-top:12pt;
   width:3.75pt;height:3.75pt;z-index:42' fillcolor="#333 [63]" strokecolor="#333 [63]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:42;margin-left:47px;margin-top:15px;width:7px;
  height:7px'><img width=7 height=7
  src="gfbr00040_KIB_GiayChuyeTien_files/image013.gif" v:shapes="_x0000_s1081"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=48 style='height:23.1pt;width:36pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>Tel. No/ <font class="font6">Điện </font><span
  style='display:none'><font class="font6">thoại:</font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1038"
   style='position:absolute;z-index:10' from="38.25pt,18.75pt" to="437.25pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:10;margin-left:50px;
  margin-top:24px;width:534px;height:2px'><img width=534 height=2
  src="gfbr00040_KIB_GiayChuyeTien_files/image015.gif" v:shapes="_x0000_s1038"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=61 style='height:23.1pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl35><%=p_Tel_No%></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 style='height:23.1pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="Picture_x0020_8" o:spid="_x0000_s1063" type="#_x0000_t75" style='position:absolute;
   margin-left:22.5pt;margin-top:3pt;width:35.25pt;height:11.25pt;z-index:26;
   visibility:visible'>
   <v:imagedata src="gfbr00040_KIB_GiayChuyeTien_files/image016.png" o:title=""/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:26;margin-left:30px;margin-top:4px;width:47px;
  height:15px'><img width=47 height=15
  src="gfbr00040_KIB_GiayChuyeTien_files/image017.jpg" v:shapes="Picture_x0020_8"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl25 width=61 style='height:23.1pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1082"
   type="#_x0000_t120" style='position:absolute;margin-left:36pt;margin-top:12pt;
   width:3.75pt;height:3.75pt;z-index:43' fillcolor="#333 [63]" strokecolor="#333 [63]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:43;margin-left:47px;margin-top:15px;width:7px;
  height:7px'><img width=7 height=7
  src="gfbr00040_KIB_GiayChuyeTien_files/image013.gif" v:shapes="_x0000_s1082"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=48 style='height:23.1pt;width:36pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>Address/ <font class="font6">Địa </font><span
  style='display:none'><font class="font6">chỉ:</font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1040"
   style='position:absolute;z-index:11' from="27.75pt,19.5pt" to="437.25pt,19.5pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:11;margin-left:36px;
  margin-top:25px;width:548px;height:2px'><img width=548 height=2
  src="gfbr00040_KIB_GiayChuyeTien_files/image018.gif" v:shapes="_x0000_s1040"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl34 width=61 style='height:23.1pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl35 style='mso-text-control:shrinktofit;'><%=p_D_Add%></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl25 style='height:23.1pt'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1064"
   style='position:absolute;margin-left:20.25pt;margin-top:6.75pt;width:9.75pt;
   height:9.75pt;z-index:27' fillcolor="window [65]" strokecolor="windowText [64]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:27;margin-left:26px;margin-top:8px;width:15px;
  height:15px'><img width=15 height=15
  src="gfbr00040_KIB_GiayChuyeTien_files/image019.gif" v:shapes="_x0000_s1064"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl35 width=61 style='height:23.1pt;width:46pt'><span
    style='mso-spacerun:yes'>         </span>Debit Account:</td>
   </tr>
  </table>
  </span></td>
  <td class=xl27></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1041"
   style='position:absolute;z-index:12' from="34.5pt,19.5pt" to="260.25pt,19.5pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:12;margin-left:45px;
  margin-top:25px;width:303px;height:2px'><img width=303 height=2
  src="gfbr00040_KIB_GiayChuyeTien_files/image020.gif" v:shapes="_x0000_s1041"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl34 width=61 style='height:23.1pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=4 class=xl35><%=p_D_Acc_No%></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1042"
   style='position:absolute;z-index:13' from="62.25pt,19.5pt" to="174pt,19.5pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:rect id="_x0000_s1065"
   style='position:absolute;margin-left:7.5pt;margin-top:7.5pt;width:9.75pt;
   height:9.75pt;z-index:28' fillcolor="window [65]" strokecolor="windowText [64]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:13;margin-left:9px;margin-top:9px;width:224px;
  height:18px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=15></td>
    <td width=58></td>
    <td width=151></td>
   </tr>
   <tr>
    <td height=15></td>
    <td align=left valign=top><img width=15 height=15
    src="gfbr00040_KIB_GiayChuyeTien_files/image019.gif" v:shapes="_x0000_s1065"></td>
   </tr>
   <tr>
    <td height=1></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=2></td>
    <td align=left valign=top><img width=151 height=2
    src="gfbr00040_KIB_GiayChuyeTien_files/image021.gif" v:shapes="_x0000_s1042"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl37 width=117 style='height:23.1pt;width:88pt'>Cash:</td>
   </tr>
  </table>
  </span></td>
  <td class=xl27></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td class=xl27></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl34 colspan=3 style='height:23.1pt;mso-ignore:colspan'>3.<span
  style='mso-spacerun:yes'>   </span>BENEFICIARY</td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1083"
   type="#_x0000_t120" style='position:absolute;margin-left:36pt;margin-top:12pt;
   width:3.75pt;height:3.75pt;z-index:44' fillcolor="#333 [63]" strokecolor="#333 [63]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:44;margin-left:47px;margin-top:15px;width:7px;
  height:7px'><img width=7 height=7
  src="gfbr00040_KIB_GiayChuyeTien_files/image013.gif" v:shapes="_x0000_s1083"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=48 style='height:23.1pt;width:36pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27><span style='mso-spacerun:yes'> </span>Name/<span
  style='display:none'> <font class="font6">Tên:</font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1043"
   style='position:absolute;z-index:14' from="33.75pt,19.5pt" to="483.75pt,19.5pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:14;margin-left:44px;
  margin-top:25px;width:602px;height:2px'><img width=602 height=2
  src="gfbr00040_KIB_GiayChuyeTien_files/image022.gif" v:shapes="_x0000_s1043"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=61 style='height:23.1pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=7 class=xl35 style='mso-text-control:shrinktofit;'><%=p_C_Acc_Nm%></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl25 colspan=3 style='height:23.1pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>      </span>Đơn vị thụ hưởng</td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1084"
   type="#_x0000_t120" style='position:absolute;margin-left:36pt;margin-top:10.5pt;
   width:3.75pt;height:3.75pt;z-index:45' fillcolor="#333 [63]" strokecolor="#333 [63]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:45;margin-left:47px;margin-top:13px;width:7px;
  height:7px'><img width=7 height=7
  src="gfbr00040_KIB_GiayChuyeTien_files/image013.gif" v:shapes="_x0000_s1084"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=48 style='height:23.1pt;width:36pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>Account No/ <font class="font6">Số Tài </font><span
  style='display:none'><font class="font6">Khoản:</font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1044"
   style='position:absolute;z-index:15' from="42.75pt,18.75pt" to="391.5pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:15;margin-left:56px;
  margin-top:24px;width:467px;height:2px'><img width=467 height=2
  src="gfbr00040_KIB_GiayChuyeTien_files/image023.gif" v:shapes="_x0000_s1044"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=61 style='height:23.1pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=5 class=xl35><%=p_C_Acc_No%></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 style='height:23.1pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="Picture_x0020_7" o:spid="_x0000_s1066" type="#_x0000_t75" style='position:absolute;
   margin-left:22.5pt;margin-top:3pt;width:33pt;height:13.5pt;z-index:29;
   visibility:visible'>
   <v:imagedata src="gfbr00040_KIB_GiayChuyeTien_files/image024.gif" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:29;margin-left:30px;margin-top:4px;width:44px;
  height:18px'><img width=44 height=18
  src="gfbr00040_KIB_GiayChuyeTien_files/image024.gif" v:shapes="Picture_x0020_7"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=61 style='height:23.1pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1085"
   type="#_x0000_t120" style='position:absolute;margin-left:36pt;margin-top:10.5pt;
   width:3.75pt;height:3.75pt;z-index:46' fillcolor="#333 [63]" strokecolor="#333 [63]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:46;margin-left:47px;margin-top:13px;width:7px;
  height:7px'><img width=7 height=7
  src="gfbr00040_KIB_GiayChuyeTien_files/image013.gif" v:shapes="_x0000_s1085"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=48 style='height:23.1pt;width:36pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>Tel. No/ <font class="font6">Điện </font><span
  style='display:none'><font class="font6">thoại:<span
  style='mso-spacerun:yes'> </span></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1045"
   style='position:absolute;z-index:16' from="37.5pt,19.5pt" to="437.25pt,19.5pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:16;margin-left:49px;
  margin-top:25px;width:535px;height:2px'><img width=535 height=2
  src="gfbr00040_KIB_GiayChuyeTien_files/image025.gif" v:shapes="_x0000_s1045"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=61 style='height:23.1pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl35></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl27 style='height:23.1pt'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1086"
   type="#_x0000_t120" style='position:absolute;margin-left:36pt;margin-top:9.75pt;
   width:3.75pt;height:3.75pt;z-index:47' fillcolor="#333 [63]" strokecolor="#333 [63]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:47;margin-left:47px;margin-top:12px;width:7px;
  height:7px'><img width=7 height=7
  src="gfbr00040_KIB_GiayChuyeTien_files/image013.gif" v:shapes="_x0000_s1086"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=48 style='height:23.1pt;width:36pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>Address/ <font class="font6">Địa </font><span
  style='display:none'><font class="font6">chỉ:<span
  style='mso-spacerun:yes'>   </span></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1068"
   style='position:absolute;z-index:30' from="25.5pt,19.5pt" to="437.25pt,19.5pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:30;margin-left:33px;
  margin-top:25px;width:551px;height:2px'><img width=551 height=2
  src="gfbr00040_KIB_GiayChuyeTien_files/image026.gif" v:shapes="_x0000_s1068"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=61 style='height:23.1pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl35 style='mso-text-control:shrinktofit;'><%=p_Add_Beneficiary%></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl27 style='height:23.1pt'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1087"
   type="#_x0000_t120" style='position:absolute;margin-left:36pt;margin-top:9.75pt;
   width:3.75pt;height:3.75pt;z-index:48' fillcolor="#333 [63]" strokecolor="#333 [63]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:48;margin-left:47px;margin-top:12px;width:7px;
  height:7px'><img width=7 height=7
  src="gfbr00040_KIB_GiayChuyeTien_files/image013.gif" v:shapes="_x0000_s1087"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=48 style='height:23.1pt;width:36pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>Others/<font class="font6"> Khác:</font><span
  style='display:none'><font class="font6"><span
  style='mso-spacerun:yes'>   </span></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1069"
   style='position:absolute;z-index:31' from=".75pt,19.5pt" to="436.5pt,19.5pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:31;margin-left:0px;
  margin-top:25px;width:583px;height:2px'><img width=583 height=2
  src="gfbr00040_KIB_GiayChuyeTien_files/image027.gif" v:shapes="_x0000_s1069"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=61 style='height:23.1pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl35></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl34 colspan=3 style='height:23.1pt;mso-ignore:colspan'>4.<span
  style='mso-spacerun:yes'>   </span>BENEFICIARY B<span style='display:none'>ANK</span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1088"
   type="#_x0000_t120" style='position:absolute;margin-left:36pt;margin-top:9.75pt;
   width:3.75pt;height:3.75pt;z-index:49' fillcolor="#333 [63]" strokecolor="#333 [63]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:49;margin-left:47px;margin-top:12px;width:7px;
  height:7px'><img width=7 height=7
  src="gfbr00040_KIB_GiayChuyeTien_files/image013.gif" v:shapes="_x0000_s1088"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl34 width=48 style='height:23.1pt;width:36pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>Name/ <font class="font6">Ngân </font><span
  style='display:none'><font class="font6">hàng:<span
  style='mso-spacerun:yes'>  </span></font><font class="font19"></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1046"
   style='position:absolute;z-index:17' from="32.25pt,20.25pt" to="436.5pt,20.25pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:17;margin-left:42px;
  margin-top:26px;width:541px;height:2px'><img width=541 height=2
  src="gfbr00040_KIB_GiayChuyeTien_files/image028.gif" v:shapes="_x0000_s1046"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=61 style='height:23.1pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl35><%=p_C_Bank%></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl25 colspan=3 style='height:23.1pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>      </span>Ngân hàng thụ h<span style='display:
  none'>ưởng</span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1089"
   type="#_x0000_t120" style='position:absolute;margin-left:36pt;margin-top:9.75pt;
   width:3.75pt;height:3.75pt;z-index:50' fillcolor="#333 [63]" strokecolor="#333 [63]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:50;margin-left:47px;margin-top:12px;width:7px;
  height:7px'><img width=7 height=7
  src="gfbr00040_KIB_GiayChuyeTien_files/image013.gif" v:shapes="_x0000_s1089"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=48 style='height:23.1pt;width:36pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>Branch/ <font class="font6">Chi n</font><span
  style='display:none'><font class="font6">hánh:</font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1047"
   style='position:absolute;flip:y;z-index:18' from="36pt,19.5pt" to="436.5pt,19.5pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:18;margin-left:47px;
  margin-top:25px;width:536px;height:2px'><img width=536 height=2
  src="gfbr00040_KIB_GiayChuyeTien_files/image029.gif" v:shapes="_x0000_s1047"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=61 style='height:23.1pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl35><%=p_Branch_Benefi%></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 style='height:23.1pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="Picture_x0020_9" o:spid="_x0000_s1070" type="#_x0000_t75" style='position:absolute;
   margin-left:24pt;margin-top:2.25pt;width:74.25pt;height:14.25pt;z-index:32;
   visibility:visible'>
   <v:imagedata src="gfbr00040_KIB_GiayChuyeTien_files/image030.png" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:32;margin-left:32px;margin-top:3px;width:99px;
  height:19px'><img width=99 height=19
  src="gfbr00040_KIB_GiayChuyeTien_files/image031.jpg" v:shapes="Picture_x0020_9"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=61 style='height:23.1pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1090"
   type="#_x0000_t120" style='position:absolute;margin-left:36pt;margin-top:9.75pt;
   width:3.75pt;height:3.75pt;z-index:51' fillcolor="#333 [63]" strokecolor="#333 [63]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:51;margin-left:47px;margin-top:12px;width:7px;
  height:7px'><img width=7 height=7
  src="gfbr00040_KIB_GiayChuyeTien_files/image013.gif" v:shapes="_x0000_s1090"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=48 style='height:23.1pt;width:36pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>Swift Code/ <font class="font6">ABA No.</font><span
  style='display:none'><font class="font6">:<span
  style='mso-spacerun:yes'>  </span></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1048"
   style='position:absolute;flip:y;z-index:19' from="2.25pt,18.75pt" to="390.75pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:19;margin-left:2px;
  margin-top:24px;width:520px;height:2px'><img width=520 height=2
  src="gfbr00040_KIB_GiayChuyeTien_files/image032.gif" v:shapes="_x0000_s1048"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=61 style='height:23.1pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=5 class=xl35></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 class=xl25 style='height:9.75pt'></td>
  <td colspan=12 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td colspan=4 height=30 width=231 style='height:23.1pt;width:174pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1050" style='position:absolute;
   z-index:20' from="173.25pt,21.75pt" to="701.25pt,21.75pt" strokecolor="windowText [64]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:20;margin-left:230px;margin-top:28px;width:706px;
  height:2px'><img width=706 height=2
  src="gfbr00040_KIB_GiayChuyeTien_files/image012.gif" v:shapes="_x0000_s1050"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=4 height=30 class=xl48 width=231 style='height:23.1pt;
    width:174pt'>5.<span style='mso-spacerun:yes'>   </span>PAYMENT DETAIL</td>
   </tr>
  </table>
  </span></td>
  <td colspan=9 class=xl48 style='mso-text-control:shrinktofit;'><%=p_Remark%></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl36 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=11 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl34 colspan=4 style='height:23.1pt;mso-ignore:colspan'>6.<span
  style='mso-spacerun:yes'>   </span>BANKING CHARGER</td>
  <td colspan=9 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl25 colspan=3 style='height:19.5pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>      </span>Phí ngân hàng</td>
  <td colspan=10 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 style='height:21.95pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="Picture_x0020_10" o:spid="_x0000_s1076" type="#_x0000_t75" style='position:absolute;
   margin-left:24.75pt;margin-top:3pt;width:66pt;height:14.25pt;z-index:37;
   visibility:visible'>
   <v:imagedata src="gfbr00040_KIB_GiayChuyeTien_files/image033.png" o:title=""/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:37;margin-left:33px;margin-top:4px;width:88px;
  height:19px'><img width=88 height=19
  src="gfbr00040_KIB_GiayChuyeTien_files/image034.jpg" v:shapes="Picture_x0020_10"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=29 class=xl29 width=61 style='height:21.95pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl39 colspan=4 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>* Industrial Bank of Korea char<span
  style='display:none'>ge</span></td>
  <td height=29 class=xl40 width=61 style='height:21.95pt;width:46pt'><!--[if gte vml 1]><v:rect
   id="_x0000_s1029" style='position:absolute;margin-left:33pt;margin-top:6pt;
   width:10.5pt;height:10.5pt;z-index:3' fillcolor="window [65]" strokecolor="windowText [64]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=43 height=7></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=16 height=16
    src="gfbr00040_KIB_GiayChuyeTien_files/image008.gif" v:shapes="_x0000_s1029"></td>
    <td width=2></td>
   </tr>
   <tr>
    <td height=6></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:45.75pt;height:21.75pt'></span><![endif]--></td>
  <td class=xl40>Benefi<span style='display:none'>ciary</span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1031"
   style='position:absolute;margin-left:87.75pt;margin-top:6pt;width:10.5pt;
   height:10.5pt;z-index:5' fillcolor="window [65]" strokecolor="windowText [64]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:5;margin-left:116px;margin-top:7px;width:16px;
  height:16px'><img width=16 height=16
  src="gfbr00040_KIB_GiayChuyeTien_files/image008.gif" v:shapes="_x0000_s1031"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=29 class=xl40 width=117 style='height:21.95pt;width:88pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl40><span style='mso-spacerun:yes'>     </span>Application</td>
  <td class=xl27></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl24 style='height:16.5pt'></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl41 colspan=4 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>   </span>(Phí tại Ngân hàng IBK)</td>
  <td class=xl41 x:str="       "><span style='mso-spacerun:yes'>       </span></td>
  <td class=xl41 colspan=2 style='mso-ignore:colspan'>Do người hưởng chịu</td>
  <td class=xl41 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>     </span>Do người chuyển chịu</td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=3 height=20 class=xl40 width=228 style='mso-ignore:colspan-rowspan;
  height:15.0pt;width:172pt'><!--[if gte vml 1]><v:shape id="_x0000_s1071"
   type="#_x0000_t75" style='position:absolute;margin-left:45pt;margin-top:.75pt;
   width:49.5pt;height:14.25pt;z-index:33'>
   <v:imagedata src="gfbr00040_KIB_GiayChuyeTien_files/image035.png" o:title=""/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=60 height=1></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=66 height=19
    src="gfbr00040_KIB_GiayChuyeTien_files/image036.jpg" v:shapes="_x0000_s1071"></td>
    <td width=102></td>
   </tr>
   <tr>
    <td height=0></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:171.0pt;height:15.0pt'></span><![endif]--></td>
  <td height=20 class=xl40 width=117 style='height:15.0pt;width:88pt'><!--[if gte vml 1]><v:shape
   id="_x0000_s1073" type="#_x0000_t75" style='position:absolute;margin-left:18.75pt;
   margin-top:1.5pt;width:43.5pt;height:13.5pt;z-index:34'>
   <v:imagedata src="gfbr00040_KIB_GiayChuyeTien_files/image037.png" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:Anchor>
     11, 25, 37, 2, 11, 83, 37, 21</x:Anchor>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=25 height=2></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=58 height=18
    src="gfbr00040_KIB_GiayChuyeTien_files/image038.jpg" v:shapes="_x0000_s1073"></td>
    <td width=34></td>
   </tr>
   <tr>
    <td height=0></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:87.75pt;height:15.0pt'></span><![endif]--></td>
  <td class=xl27></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 colspan=2 class=xl24 style='height:21.95pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl39 colspan=4 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>*Other Bank's Charges</td>
  <td height=29 class=xl40 width=61 style='height:21.95pt;width:46pt'><!--[if gte vml 1]><v:rect
   id="_x0000_s1030" style='position:absolute;margin-left:30.75pt;margin-top:5.25pt;
   width:10.5pt;height:10.5pt;z-index:4' fillcolor="window [65]" strokecolor="windowText [64]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=40 height=6></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=16 height=16
    src="gfbr00040_KIB_GiayChuyeTien_files/image008.gif" v:shapes="_x0000_s1030"></td>
    <td width=5></td>
   </tr>
   <tr>
    <td height=7></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:45.75pt;height:21.75pt'></span><![endif]--></td>
  <td class=xl40>Benefi<span style='display:none'>ciary</span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1032"
   style='position:absolute;margin-left:87.75pt;margin-top:6.75pt;width:10.5pt;
   height:10.5pt;z-index:6' fillcolor="window [65]" strokecolor="windowText [64]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:6;margin-left:116px;margin-top:8px;width:16px;
  height:16px'><img width=16 height=16
  src="gfbr00040_KIB_GiayChuyeTien_files/image008.gif" v:shapes="_x0000_s1032"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=29 class=xl40 width=117 style='height:21.95pt;width:88pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl40><span style='mso-spacerun:yes'>     </span>Application</td>
  <td class=xl42></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=2 class=xl24 style='height:14.25pt;mso-ignore:colspan'></td>
  <td class=xl36></td>
  <td class=xl27></td>
  <td class=xl41 colspan=3 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>   </span>(Phí<span style='mso-spacerun:yes'> 
  </span>ngân hàng khác)</td>
  <td class=xl40></td>
  <td class=xl41></td>
  <td class=xl41 colspan=2 style='mso-ignore:colspan'>Do người hưởng chịu</td>
  <td class=xl41 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>     </span>Do người chuyển chịu</td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 style='height:21.95pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="_x0000_s1078" type="#_x0000_t75" style='position:absolute;margin-left:0;
   margin-top:18pt;width:704.25pt;height:105pt;z-index:39'>
   <v:imagedata src="gfbr00040_KIB_GiayChuyeTien_files/image039.png" o:title=""/>
  </v:shape><v:shape id="_x0000_s1075" type="#_x0000_t75" style='position:absolute;
   margin-left:401.25pt;margin-top:2.25pt;width:49.5pt;height:14.25pt;
   z-index:36'>
   <v:imagedata src="gfbr00040_KIB_GiayChuyeTien_files/image035.png" o:title=""/>
  </v:shape><v:shape id="_x0000_s1074" type="#_x0000_t75" style='position:absolute;
   margin-left:545.25pt;margin-top:1.5pt;width:43.5pt;height:14.25pt;z-index:35'>
   <v:imagedata src="gfbr00040_KIB_GiayChuyeTien_files/image037.png" o:title=""/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:39;margin-left:0px;margin-top:2px;width:939px;
  height:162px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=535></td>
    <td width=66></td>
    <td width=126></td>
    <td width=58></td>
    <td width=154></td>
   </tr>
   <tr>
    <td height=1></td>
    <td colspan=3></td>
    <td rowspan=2 align=left valign=top><img width=58 height=19
    src="gfbr00040_KIB_GiayChuyeTien_files/image040.jpg" v:shapes="_x0000_s1074"></td>
   </tr>
   <tr>
    <td height=18></td>
    <td></td>
    <td rowspan=2 align=left valign=top><img width=66 height=19
    src="gfbr00040_KIB_GiayChuyeTien_files/image036.jpg" v:shapes="_x0000_s1075"></td>
   </tr>
   <tr>
    <td height=1></td>
   </tr>
   <tr>
    <td height=2></td>
   </tr>
   <tr>
    <td height=140></td>
    <td colspan=5 align=left valign=top><img width=939 height=140
    src="gfbr00040_KIB_GiayChuyeTien_files/image041.jpg" v:shapes="_x0000_s1078"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=29 class=xl24 width=61 style='height:21.95pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=7 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=4 class=xl25 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=9 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=13 rowspan=2 height=126 class=xl49 width=937 style='height:94.5pt;
  width:706pt'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=109 style='mso-height-source:userset;height:81.75pt'>
  <td height=109 class=xl24 style='height:81.75pt'></td>
  <td class=xl24></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=4 class=xl25 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=9 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=4 class=xl25 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=9 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 style='height:18.0pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="_x0000_s1077" type="#_x0000_t75" style='position:absolute;margin-left:4.5pt;
   margin-top:17.25pt;width:695.25pt;height:116.25pt;z-index:38'>
   <v:imagedata src="gfbr00040_KIB_GiayChuyeTien_files/image042.png" o:title=""/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:38;margin-left:6px;margin-top:23px;width:927px;
  height:155px'><img width=927 height=155
  src="gfbr00040_KIB_GiayChuyeTien_files/image043.jpg" v:shapes="_x0000_s1077"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl27 width=61 style='height:18.0pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=9 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=10 class=xl27 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=10 class=xl27 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=10 class=xl27 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=10 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl37></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=10 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl37></td>
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
  <td width=48 style='width:36pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=0></td>
  <td width=6 style='width:5pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
