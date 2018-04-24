<%@ Page Language="C#"%>
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
    string p_D_Add = "";
    string p_D_Bank = "";
    string p_C_Acc_No = "";
    string p_C_Acc_Nm = "";
    string p_C_Add = "";
    string p_C_Bank = "";
    string p_Remark = "";
    string p_So = "";
    
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
        //p_D_Acc_No = dt.Rows[0][8].ToString();
        p_D_Acc_Nm = dt.Rows[0][12].ToString();
        //p_D_Add = dt.Rows[0][25].ToString();
        p_D_Bank = dt.Rows[0][9].ToString();
        p_C_Acc_No = dt.Rows[0][0].ToString();
        p_C_Acc_Nm = dt.Rows[0][19].ToString();
        //p_C_Add = dt.Rows[0][26].ToString();
        p_C_Bank = dt.Rows[0][1].ToString();
        p_Remark = dt.Rows[0][14].ToString();
        p_So = dt.Rows[0][11].ToString();
    }

    string _str = "";
    char[] _ch = p_C_Acc_No.ToCharArray();
    for (int _j = 0; _j < _ch.Length; _j++)
        _str += _ch[_j] + "<font class=font18><span style='mso-spacerun:yes'>     </span></font>";

    string _str_Dr = "";
    char[] _ch_Dr = p_D_Acc_No.ToCharArray();
    for (int _k = 0; _k < _ch_Dr.Length; _k++)
        _str_Dr += _ch_Dr[_k] + "<font class=font18><span style='mso-spacerun:yes'>     </span></font>";
    
    string p_Amt = "";
    string p_Ccy = "";
    string Inword = "";
    string _str_Amt = "";
    DataTable dt_Amount = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030_1", p_Seq);
    if (dt_Amount.Rows.Count > 0)
    {
        p_Amt = dt_Amount.Rows[0][11].ToString();
        p_Ccy = dt_Amount.Rows[0][3].ToString();


        string _ch_Amt = p_Amt.ToString();
        
        int p = _ch_Amt.Length % 3;
        if (p > 0)
        {
            _str_Amt = _ch_Amt.Substring(0, p)+"     ";
        }
        int z = _ch_Amt.Length / 3;
        int r;
        for (r = 0; r < z; r++)
        {
            _str_Amt = _str_Amt + _ch_Amt.Substring(p, 3) + " ";
            p = p + 3;
        }
        
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
<link rel=File-List href="VIB_GNT_files/filelist.xml">
<link rel=Edit-Time-Data href="VIB_GNT_files/editdata.mso">
<link rel=OLE-Object-Data href="VIB_GNT_files/oledata.mso">
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
  <o:LastPrinted>2012-01-16T06:05:14Z</o:LastPrinted>
  <o:Created>2012-01-16T05:34:12Z</o:Created>
  <o:LastSaved>2012-01-16T06:07:04Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:0in .13in .2in .21in;
	mso-header-margin:0in;
	mso-footer-margin:.16in;}
.font5
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font17
	{color:red;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font18
	{color:red;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font19
	{color:red;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font20
	{color:red;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style143
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:Comma;
	mso-style-id:3;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"\.VnTime";
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
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"\.VnTime";
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
.xl513
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl514
	{mso-style-parent:style0;
	color:blue;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl515
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl516
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"\.VnArial", sans-serif;
	mso-font-charset:0;}
.xl517
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl518
	{mso-style-parent:style0;
	color:red;
	font-size:22.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl519
	{mso-style-parent:style0;
	color:red;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl520
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl521
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl522
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$-1010000\]d\/m\/yyyy\;\@";
	vertical-align:middle;}
.xl523
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl524
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl525
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$-1010000\]d\/m\/yyyy\;\@";
	vertical-align:middle;}
.xl526
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl527
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl528
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl529
	{mso-style-parent:style0;
	color:white;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl530
	{mso-style-parent:style0;
	color:white;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl531
	{mso-style-parent:style0;
	color:white;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl532
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:justify;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl533
	{mso-style-parent:style0;
	color:white;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:normal;}
.xl534
	{mso-style-parent:style0;
	color:white;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl535
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:justify;}
.xl536
	{mso-style-parent:style143;
	color:red;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl537
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl538
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl539
	{mso-style-parent:style143;
	color:#FFCC99;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl540
	{mso-style-parent:style0;
	color:white;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:normal;}
.xl541
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:navy;
	mso-pattern:auto none;}
.xl542
	{mso-style-parent:style0;
	color:white;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	background:navy;
	mso-pattern:auto none;
	white-space:normal;}
.xl543
	{mso-style-parent:style0;
	color:#FF9900;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:red;
	mso-pattern:auto none;}
.xl544
	{mso-style-parent:style0;
	color:#FF9900;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	background:red;
	mso-pattern:auto none;
	white-space:normal;}
.xl545
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	background:red;
	mso-pattern:auto none;
	white-space:normal;}
.xl546
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	background:#99CCFF;
	mso-pattern:auto none;
	padding-left:24px;
	mso-char-indent-count:2;}
.xl547
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl548
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	background:#99CCFF;
	mso-pattern:auto none;
	padding-left:24px;
	mso-char-indent-count:2;}
.xl549
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl550
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl551
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Giay nop tien</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:CodeName>Sheet11</x:CodeName>
     <x:TabColorIndex>13</x:TabColorIndex>
     <x:PageBreakZoom>100</x:PageBreakZoom>
     <x:Selected/>
     <x:TopRowVisible>22</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>32</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8760</x:WindowHeight>
  <x:WindowWidth>18195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>135</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1088"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl513>

<table x:str border=0 cellpadding=0 cellspacing=0 width=947 style='border-collapse:
 collapse;table-layout:fixed;width:713pt'>
 <col class=xl513 width=100 style='mso-width-source:userset;mso-width-alt:2844;
 width:75pt'>
 <col class=xl513 width=145 style='mso-width-source:userset;mso-width-alt:4124;
 width:109pt'>
 <col class=xl513 width=13 style='mso-width-source:userset;mso-width-alt:369;
 width:10pt'>
 <col class=xl513 width=24 span=11 style='mso-width-source:userset;mso-width-alt:
 682;width:18pt'>
 <col class=xl513 width=25 style='mso-width-source:userset;mso-width-alt:711;
 width:19pt'>
 <col class=xl513 width=24 style='mso-width-source:userset;mso-width-alt:682;
 width:18pt'>
 <col class=xl513 width=22 style='mso-width-source:userset;mso-width-alt:625;
 width:17pt'>
 <col class=xl513 width=24 span=4 style='mso-width-source:userset;mso-width-alt:
 682;width:18pt'>
 <col class=xl513 width=12 style='mso-width-source:userset;mso-width-alt:341;
 width:9pt'>
 <col class=xl513 width=24 span=3 style='mso-width-source:userset;mso-width-alt:
 682;width:18pt'>
 <col class=xl513 width=29 span=2 style='mso-width-source:userset;mso-width-alt:
 824;width:22pt'>
 <col class=xl513 width=6 style='mso-width-source:userset;mso-width-alt:170;
 width:5pt'>
 <col class=xl513 width=29 style='mso-width-source:userset;mso-width-alt:824;
 width:22pt'>
 <col class=xl513 width=81 span=227 style='mso-width-source:userset;mso-width-alt:
 2304;width:61pt'>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl513 width=100 style='height:13.5pt;width:75pt'></td>
  <td class=xl513 width=145 style='width:109pt'></td>
  <td class=xl513 width=13 style='width:10pt'></td>
  <td class=xl513 width=24 style='width:18pt'></td>
  <td class=xl513 width=24 style='width:18pt'></td>
  <td class=xl513 width=24 style='width:18pt'></td>
  <td class=xl513 width=24 style='width:18pt'></td>
  <td class=xl513 width=24 style='width:18pt'></td>
  <td class=xl513 width=24 style='width:18pt'></td>
  <td class=xl513 width=24 style='width:18pt'></td>
  <td class=xl513 width=24 style='width:18pt'></td>
  <td class=xl513 width=24 style='width:18pt'></td>
  <td class=xl513 width=24 style='width:18pt'></td>
  <td class=xl513 width=24 style='width:18pt'></td>
  <td class=xl513 width=25 style='width:19pt'></td>
  <td class=xl513 width=24 style='width:18pt'></td>
  <td class=xl513 width=22 style='width:17pt'></td>
  <td class=xl513 width=24 style='width:18pt'></td>
  <td class=xl513 width=24 style='width:18pt'></td>
  <td class=xl513 width=24 style='width:18pt'></td>
  <td class=xl513 width=24 style='width:18pt'></td>
  <td class=xl513 width=12 style='width:9pt'></td>
  <td class=xl513 width=24 style='width:18pt'></td>
  <td class=xl513 width=24 style='width:18pt'></td>
  <td class=xl513 width=24 style='width:18pt'></td>
  <td class=xl513 width=29 style='width:22pt'></td>
  <td class=xl513 width=29 style='width:22pt'></td>
  <td class=xl513 width=6 style='width:5pt'></td>
  <td class=xl513 width=29 style='width:22pt'></td>
  <td class=xl513 width=81 style='width:61pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=19 class=xl513 style='height:15.75pt;mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
   coordsize="21600,21600" o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe"
   filled="f" stroked="f">
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
  </v:shapetype><v:shape id="Picture_x0020_1" o:spid="_x0000_s1026" type="#_x0000_t75"
   style='position:absolute;margin-left:7.5pt;margin-top:3pt;width:151.5pt;
   height:33.75pt;z-index:2;visibility:visible'>
   <v:imagedata src="VIB_GNT_files/image001.png" o:title=""/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:10px;margin-top:4px;width:202px;
  height:45px'><img width=202 height=45 src="VIB_GNT_files/image002.jpg"
  v:shapes="Picture_x0020_1"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=21 class=xl513 width=24 style='height:15.75pt;width:18pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=10 class=xl513 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 class=xl514 colspan=6 style='height:18.0pt;mso-ignore:colspan'>Ngân
  Hàng TMCP Công Thương Việt Nam</td>
  <td colspan=12 class=xl513 style='mso-ignore:colspan'></td>
  <td class=xl516></td>
  <td class=xl513></td>
  <td class=xl517></td>
  <td colspan=9 class=xl513 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td colspan=29 height=34 class=xl518 style='height:25.5pt'>Giấy nộp tiền</td>
  <td class=xl513></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=29 height=21 class=xl519 style='height:15.75pt'>Cash deposit slip</td>
  <td class=xl513></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl520 style='height:30.0pt'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t202"
   coordsize="21600,21600" o:spt="202" path="m,l,21600r21600,l21600,xe">
   <v:stroke joinstyle="miter"/>
   <v:path gradientshapeok="t" o:connecttype="rect"/>
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t202"
   href="#RANGE!A1" style='position:absolute;margin-left:574.5pt;margin-top:8.25pt;
   width:0;height:40.5pt;z-index:1;visibility:visible;mso-wrap-style:tight'
   o:button="t" fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font19">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:line id="_x0000_s1055" style='position:absolute;z-index:29'
   from="32.25pt,70.5pt" to="573pt,70.5pt" coordsize="21600,21600"
   strokecolor="red [10]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:1;margin-left:42px;margin-top:10px;width:725px;height:85px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=723></td>
    <td width=2></td>
   </tr>
   <tr>
    <td height=56></td>
    <td></td>
    <td align=left valign=top><a href="#RANGE!A1"><img border=0 width=2
    height=56 src="VIB_GNT_files/image003.gif" alt="Text Box: TRỞ LẠI" v:shapes="_x0000_s1025"></a></td>
   </tr>
   <tr>
    <td height=27></td>
   </tr>
   <tr>
    <td height=2></td>
    <td align=left valign=top><img width=723 height=2
    src="VIB_GNT_files/image004.gif" v:shapes="_x0000_s1055"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=40 class=xl520 width=145 style='height:30.0pt;width:109pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl520 style='mso-ignore:colspan'></td>
  <td class=xl513></td>
  <td colspan=3 class=xl521 style='mso-ignore:colspan'></td>
  <td class=xl513></td>
  <td colspan=2 class=xl522 style='mso-ignore:colspan'></td>
  <td class=xl523 colspan=4 style='mso-ignore:colspan'>Số <font class="font17">No</font><font
  class="font18"> ……</font></td>
  <td class=xl523></td>
  <td class=xl523 colspan=9 style='mso-ignore:colspan'>Ngày <font class="font17">Date..</font><font
  class="font19"><%=p_Date %></font><font class="font17">…</font><font class="font19">/</font><font
  class="font17">..</font><font class="font19"><%=p_Month %></font><font class="font17">...</font><font
  class="font19">/..<%=p_Year %></font><font class="font20">...</font></td>
  <td colspan=4 class=xl513 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl513 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=11 class=xl526 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl527 colspan=13 style='mso-ignore:colspan'>Liên 1 Chứng từ hạch
  toán <font class="font17">Copy 1 Accouting Document</font></td>
  <td colspan=5 class=xl526 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl513></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl523 colspan=14 style='height:27.0pt;mso-ignore:colspan'>Người
  nộp <font class="font17">Deposited by:<span style='mso-spacerun:yes'>  
  </span></font><font class="font19"><%=p_D_Acc_Nm %></font></td>
  <td colspan=14 class=xl513 style='mso-ignore:colspan'></td>
  <td class=xl528></td>
  <td class=xl513></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 style='height:17.25pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1056" style='position:absolute;z-index:30' from="71.25pt,15pt"
   to="456.75pt,15pt" coordsize="21600,21600" strokecolor="red [10]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:30;margin-left:94px;margin-top:19px;width:516px;height:2px'><img
  width=516 height=2 src="VIB_GNT_files/image005.gif" v:shapes="_x0000_s1056"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=23 class=xl523 width=100 style='height:17.25pt;width:75pt'>Địa
    chỉ <font class="font17">Address :<span style='mso-spacerun:yes'>  </span></font><font
    class="font19"><%=p_D_Add %></font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl513></td>
  <td class=xl529></td>
  <td colspan=15 class=xl530 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl529 style='mso-ignore:colspan'></td>
  <td class=xl513></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 style='height:17.25pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1027" style='position:absolute;z-index:3' from="458.25pt,49.5pt"
   to="650.25pt,50.25pt" strokecolor="gray [23]" strokeweight="6pt"
   o:insetmode="auto"/><v:line id="_x0000_s1028" style='position:absolute;
   z-index:4' from="460.5pt,4.5pt" to="460.5pt,51.75pt" strokecolor="gray [23]"
   strokeweight="4.5pt" o:insetmode="auto"/><v:line id="_x0000_s1057" style='position:absolute;
   z-index:31' from="110.25pt,15pt" to="455.25pt,15pt" coordsize="21600,21600"
   strokecolor="red [10]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1058" style='position:absolute;z-index:32'
   from="106.5pt,32.25pt" to="457.5pt,32.25pt" coordsize="21600,21600"
   strokecolor="red [10]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1059" style='position:absolute;z-index:33'
   from="107.25pt,49.5pt" to="458.25pt,49.5pt" coordsize="21600,21600"
   strokecolor="red [10]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1061" style='position:absolute;z-index:35'
   from="1.5pt,81.75pt" to="646.5pt,81.75pt" coordsize="21600,21600"
   strokecolor="red [10]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1060" style='position:absolute;z-index:34'
   from="146.25pt,65.25pt" to="648.75pt,65.25pt" coordsize="21600,21600"
   strokecolor="red [10]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:3;margin-left:1px;margin-top:3px;width:870px;height:107px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=140></td>
    <td width=53></td>
    <td width=669></td>
    <td width=3></td>
    <td width=5></td>
   </tr>
   <tr>
    <td height=69></td>
    <td></td>
    <td colspan=4 align=left valign=top><img width=730 height=69
    src="VIB_GNT_files/image006.gif" v:shapes="_x0000_s1027 _x0000_s1028 _x0000_s1057 _x0000_s1058 _x0000_s1059"></td>
   </tr>
   <tr>
    <td height=14></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=2></td>
    <td colspan=2 align=left valign=top><img width=672 height=2
    src="VIB_GNT_files/image007.gif" v:shapes="_x0000_s1060"></td>
   </tr>
   <tr>
    <td height=20></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=3 align=left valign=top><img width=862 height=2
    src="VIB_GNT_files/image008.gif" v:shapes="_x0000_s1061"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=23 class=xl523 width=100 style='height:17.25pt;width:75pt'>Số
    tài khoản<font class="font17"> A/C number :<span style='mso-spacerun:yes'> 
    </span></font><font class="font19"><%=_str_Dr %></font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl513></td>
  <td class=xl531></td>
  <td colspan=15 class=xl529 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl532>Số tiền bằng số Amount in figures</td>
  <td class=xl513></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl523 colspan=7 style='height:17.25pt;mso-ignore:colspan'>Tên
  Tài khoản <font class="font17">A/c name:<span style='mso-spacerun:yes'> 
  </span></font><font class="font19"><%=p_C_Acc_Nm %></font></td>
  <td colspan=9 class=xl533 style='mso-ignore:colspan'></td>
  <td class=xl534></td>
  <td class=xl535></td>
  <td colspan=10 rowspan=2 class=xl536 ><span
  style='mso-spacerun:yes'> </span><%=_str_Amt %> <%=p_Ccy %><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl537>&nbsp;</td>
  <td class=xl513></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl523 colspan=7 style='height:17.25pt;mso-ignore:colspan'>Tại
  ngân hàng <font class="font17">With bank:<span style='mso-spacerun:yes'> 
  </span></font><font class="font19"><%=p_C_Bank %></font></td>
  <td colspan=9 class=xl533 style='mso-ignore:colspan'></td>
  <td class=xl534></td>
  <td class=xl513></td>
  <td class=xl539>&nbsp;</td>
  <td class=xl513></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=29 rowspan=2 height=46 class=xl551 width=866 style='height:34.5pt;
  width:652pt'>Số tiền bằng chữ <font class="font17">Amount in words:<span
  style='mso-spacerun:yes'>  </span></font><font class="font19"><%=Inword %></font></td>
  <td class=xl513></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl513 style='height:17.25pt'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl523 style='height:17.25pt'>Nội dung<font class="font18">
  </font><font class="font17">Rema</font><span style='display:none'><font
  class="font17">rks:<span style='mso-spacerun:yes'>  </span></font><font
  class="font19"><%=p_Remark %></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1062"
   style='position:absolute;z-index:36' from="6pt,15.75pt" to="573.75pt,15.75pt"
   coordsize="21600,21600" strokecolor="red [10]" strokeweight="1pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:36;margin-left:7px;margin-top:20px;width:759px;height:2px'><img
  width=759 height=2 src="VIB_GNT_files/image009.gif" v:shapes="_x0000_s1062"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=23 class=xl513 width=145 style='height:17.25pt;width:109pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl513></td>
  <td colspan=26 class=xl540 style='mso-ignore:colspan'></td>
  <td class=xl513></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 colspan=2 class=xl513 style='height:8.25pt;mso-ignore:colspan'></td>
  <td colspan=27 class=xl540 style='mso-ignore:colspan'></td>
  <td class=xl513></td>
 </tr>
 <tr class=xl513 height=4 style='mso-height-source:userset;height:3.0pt'>
  <td height=4 colspan=2 class=xl541 style='height:3.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=27 class=xl542 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl513></td>
 </tr>
 <tr class=xl513 height=4 style='mso-height-source:userset;height:3.0pt'>
  <td height=4 colspan=2 class=xl543 style='height:3.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=20 class=xl544 style='mso-ignore:colspan'>&nbsp;</td>
  <td height=4 class=xl544 width=24 style='height:3.0pt;width:18pt'><!--[if gte vml 1]><v:line
   id="_x0000_s1029" style='position:absolute;z-index:5' from="15.75pt,2.25pt"
   to="15.75pt,2.25pt" strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=20 height=2></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=2 height=2 src="VIB_GNT_files/image010.gif" v:shapes="_x0000_s1029"></td>
    <td width=2></td>
   </tr>
   <tr>
    <td height=0></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:18.0pt;height:3.0pt'></span><![endif]--></td>
  <td colspan=6 class=xl545 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl513></td>
 </tr>
 <tr class=xl513 height=21 style='height:15.75pt'>
  <td height=21 class=xl546 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Người
  nộp tiền</td>
  <td class=xl547 colspan=3 style='mso-ignore:colspan'>Thủ quỹ</td>
  <td colspan=6 class=xl526 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl547 colspan=5 style='mso-ignore:colspan'>Giao dịch viên<font
  class="font5"><span style='mso-spacerun:yes'> </span></font></td>
  <td colspan=2 class=xl526 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl547 colspan=6 style='mso-ignore:colspan'>Kiểm soát viên<font
  class="font5"><span style='mso-spacerun:yes'> </span></font></td>
  <td colspan=5 class=xl526 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl513></td>
 </tr>
 <tr class=xl513 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl548 style='height:13.5pt'>Depositor</td>
  <td class=xl526>&nbsp;</td>
  <td class=xl526 colspan=3 style='mso-ignore:colspan'>Cashier</td>
  <td colspan=6 class=xl526 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl526 colspan=2 style='mso-ignore:colspan'>Teller</td>
  <td colspan=5 class=xl526 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl526 colspan=3 style='mso-ignore:colspan'>Supervisor</td>
  <td colspan=8 class=xl526 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl513></td>
 </tr>
 <tr class=xl513 height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=6 class=xl549 style='height:10.5pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl526>&nbsp;</td>
  <td colspan=2 class=xl549 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=13 class=xl526 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=7 class=xl549 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl513></td>
 </tr>
 <tr class=xl513 height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=6 class=xl549 style='height:10.5pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl526>&nbsp;</td>
  <td colspan=2 class=xl549 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=13 class=xl526 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=7 class=xl549 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl513></td>
 </tr>
 <tr class=xl513 height=21 style='height:15.75pt'>
  <td height=21 colspan=29 class=xl526 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl513></td>
 </tr>
 <tr class=xl513 height=21 style='height:15.75pt'>
  <td height=21 colspan=29 class=xl526 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl513></td>
 </tr>
 <tr class=xl513 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=2 class=xl526 style='height:18.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl550>&nbsp;</td>
  <td colspan=14 class=xl526 style='mso-ignore:colspan'>&nbsp;</td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1042"
   style='position:absolute;z-index:18' from="15.75pt,18.75pt" to="15.75pt,18.75pt"
   strokecolor="gray [23]" strokeweight="4.5pt" o:insetmode="auto"/><v:line
   id="_x0000_s1045" style='position:absolute;z-index:21' from="15.75pt,18.75pt"
   to="15.75pt,18.75pt" strokecolor="gray [23]" strokeweight="4.5pt"
   o:insetmode="auto"/><v:line id="_x0000_s1048" style='position:absolute;
   z-index:24' from="15.75pt,18.75pt" to="15.75pt,18.75pt" strokecolor="gray [23]"
   strokeweight="4.5pt" o:insetmode="auto"/><v:line id="_x0000_s1053" style='position:absolute;
   z-index:27' from="15.75pt,18.75pt" to="15.75pt,18.75pt" strokecolor="gray [23]"
   strokeweight="4.5pt" o:insetmode="auto"/><v:line id="_x0000_s1033" style='position:absolute;
   z-index:9' from="15.75pt,32.25pt" to="15.75pt,32.25pt" strokecolor="gray [23]"
   strokeweight="4.5pt" o:insetmode="auto"/><v:line id="_x0000_s1039" style='position:absolute;
   z-index:15' from="15.75pt,32.25pt" to="15.75pt,32.25pt" strokecolor="gray [23]"
   strokeweight="4.5pt" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:18;margin-left:18px;
  margin-top:22px;width:6px;height:24px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=6></td>
   </tr>
   <tr>
    <td height=6></td>
    <td align=left valign=top><img width=6 height=6
    src="VIB_GNT_files/image011.gif" v:shapes="_x0000_s1042 _x0000_s1045 _x0000_s1048 _x0000_s1053"></td>
   </tr>
   <tr>
    <td height=12></td>
   </tr>
   <tr>
    <td height=6></td>
    <td align=left valign=top><img width=6 height=6
    src="VIB_GNT_files/image011.gif" v:shapes="_x0000_s1033 _x0000_s1039"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=25 class=xl526 width=24 style='height:18.75pt;width:18pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td colspan=4 class=xl526 style='mso-ignore:colspan'>&nbsp;</td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1046"
   style='position:absolute;z-index:22' from="15.75pt,18.75pt" to="15.75pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1049"
   style='position:absolute;z-index:25' from="15.75pt,18.75pt" to="15.75pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1054"
   style='position:absolute;z-index:28' from="15.75pt,18.75pt" to="15.75pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1031"
   style='position:absolute;z-index:7' from="15.75pt,32.25pt" to="15.75pt,32.25pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1034"
   style='position:absolute;z-index:10' from="15.75pt,32.25pt" to="15.75pt,32.25pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1037"
   style='position:absolute;z-index:13' from="15.75pt,32.25pt" to="15.75pt,32.25pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1040"
   style='position:absolute;z-index:16' from="15.75pt,32.25pt" to="15.75pt,32.25pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1043"
   style='position:absolute;z-index:19' from="15.75pt,32.25pt" to="15.75pt,32.25pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:22;margin-left:20px;
  margin-top:24px;width:2px;height:20px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=2></td>
   </tr>
   <tr>
    <td height=2></td>
    <td align=left valign=top><img width=2 height=2
    src="VIB_GNT_files/image010.gif" v:shapes="_x0000_s1046 _x0000_s1049 _x0000_s1054"></td>
   </tr>
   <tr>
    <td height=16></td>
   </tr>
   <tr>
    <td height=2></td>
    <td align=left valign=top><img width=2 height=2
    src="VIB_GNT_files/image010.gif" v:shapes="_x0000_s1031 _x0000_s1034 _x0000_s1037 _x0000_s1040 _x0000_s1043"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=25 class=xl526 width=24 style='height:18.75pt;width:18pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td colspan=5 class=xl526 style='mso-ignore:colspan'>&nbsp;</td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1041"
   type="#_x0000_t202" href="#RANGE!A1" style='position:absolute;margin-left:21.75pt;
   margin-top:18.75pt;width:0;height:0;z-index:17;visibility:visible;
   mso-wrap-style:tight' o:button="t" fillcolor="#cf3" strokecolor="blue [12]"
   o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font19">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1044" type="#_x0000_t202" href="#RANGE!A1"
   style='position:absolute;margin-left:21.75pt;margin-top:18.75pt;width:0;
   height:0;z-index:20;visibility:visible;mso-wrap-style:tight' o:button="t"
   fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font19">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1047" type="#_x0000_t202" href="#RANGE!A1"
   style='position:absolute;margin-left:21.75pt;margin-top:18.75pt;width:0;
   height:0;z-index:23;visibility:visible;mso-wrap-style:tight' o:button="t"
   fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font19">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1050" type="#_x0000_t202" href="#RANGE!A1"
   style='position:absolute;margin-left:21.75pt;margin-top:18.75pt;width:0;
   height:0;z-index:26;visibility:visible;mso-wrap-style:tight' o:button="t"
   fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font19">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1032" type="#_x0000_t202" href="#RANGE!A1"
   style='position:absolute;margin-left:21.75pt;margin-top:32.25pt;width:0;
   height:0;z-index:8;visibility:visible;mso-wrap-style:tight' o:button="t"
   fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font19">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1035" type="#_x0000_t202" href="#RANGE!A1"
   style='position:absolute;margin-left:21.75pt;margin-top:32.25pt;width:0;
   height:0;z-index:11;visibility:visible;mso-wrap-style:tight' o:button="t"
   fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font19">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1038" type="#_x0000_t202" href="#RANGE!A1"
   style='position:absolute;margin-left:21.75pt;margin-top:32.25pt;width:0;
   height:0;z-index:14;visibility:visible;mso-wrap-style:tight' o:button="t"
   fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font19">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:17;margin-left:28px;margin-top:24px;width:2px;
  height:20px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=2></td>
   </tr>
   <tr>
    <td height=2></td>
    <td align=left valign=top><map name=MicrosoftOfficeMap0><area shape=Rect
    coords="0, 0, 2, 2" href="#RANGE!A1"><area shape=Rect
    coords="0, 0, 2, 2" href="#RANGE!A1"><area shape=Rect
    coords="0, 0, 2, 2" href="#RANGE!A1"><area shape=Rect
    coords="0, 0, 2, 2" href="#RANGE!A1"></map><img border=0 width=2 height=2
    src="VIB_GNT_files/image010.gif" usemap="#MicrosoftOfficeMap0" v:shapes="_x0000_s1041 _x0000_s1044 _x0000_s1047 _x0000_s1050"></td>
   </tr>
   <tr>
    <td height=16></td>
   </tr>
   <tr>
    <td height=2></td>
    <td align=left valign=top><map name=MicrosoftOfficeMap1><area shape=Rect
    coords="0, 0, 2, 2" href="#RANGE!A1"><area shape=Rect
    coords="0, 0, 2, 2" href="#RANGE!A1"><area shape=Rect
    coords="0, 0, 2, 2" href="#RANGE!A1"></map><img border=0 width=2 height=2
    src="VIB_GNT_files/image010.gif" usemap="#MicrosoftOfficeMap1" v:shapes="_x0000_s1032 _x0000_s1035 _x0000_s1038"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=25 class=xl526 width=29 style='height:18.75pt;width:22pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td class=xl513></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 colspan=16 class=xl513 style='height:13.5pt;mso-ignore:colspan'></td>
  <td rowspan=2 height=219 class=xl513 width=22 style='mso-ignore:colspan-rowspan;
  height:164.25pt;width:17pt'><!--[if gte vml 1]><v:line id="_x0000_s1030"
   style='position:absolute;z-index:6' from="14.25pt,13.5pt" to="14.25pt,13.5pt"
   strokecolor="gray [23]" strokeweight="4.5pt" o:insetmode="auto"/><v:line
   id="_x0000_s1036" style='position:absolute;z-index:12' from="14.25pt,13.5pt"
   to="14.25pt,13.5pt" strokecolor="gray [23]" strokeweight="4.5pt"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=16 height=15></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=6 height=6 src="VIB_GNT_files/image011.gif" v:shapes="_x0000_s1030 _x0000_s1036"></td>
    <td width=0></td>
   </tr>
   <tr>
    <td height=198></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:16.5pt;height:164.25pt'></span><![endif]--></td>
  <td colspan=13 class=xl513 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=201 style='mso-height-source:userset;height:150.75pt'>
  <td height=201 colspan=16 class=xl513 style='height:150.75pt;mso-ignore:colspan'></td>
  <td colspan=13 class=xl513 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=19 class=xl513 style='height:15.75pt;mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1076"
   type="#_x0000_t75" style='position:absolute;margin-left:7.5pt;margin-top:3pt;
   width:151.5pt;height:33.75pt;z-index:38;visibility:visible'>
   <v:imagedata src="VIB_GNT_files/image001.png" o:title=""/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:38;margin-left:10px;margin-top:4px;width:202px;
  height:45px'><img width=202 height=45 src="VIB_GNT_files/image012.jpg"
  v:shapes="_x0000_s1076"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=21 class=xl513 width=24 style='height:15.75pt;width:18pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=10 class=xl513 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 class=xl514 colspan=6 style='height:18.0pt;mso-ignore:colspan'>Ngân
  Hàng TMCP Công Thương Việt Nam</td>
  <td colspan=12 class=xl513 style='mso-ignore:colspan'></td>
  <td class=xl516></td>
  <td class=xl513></td>
  <td class=xl517></td>
  <td colspan=9 class=xl513 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td colspan=29 height=34 class=xl518 style='height:25.5pt'>Giấy nộp tiền</td>
  <td class=xl513></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=29 height=21 class=xl519 style='height:15.75pt'>Cash deposit slip</td>
  <td class=xl513></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl520 style='height:30.0pt'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1075"
   type="#_x0000_t202" href="#RANGE!A1" style='position:absolute;margin-left:574.5pt;
   margin-top:8.25pt;width:0;height:40.5pt;z-index:37;visibility:visible;
   mso-wrap-style:tight' o:button="t" fillcolor="#cf3" strokecolor="blue [12]"
   o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font19">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:line id="_x0000_s1080" style='position:absolute;z-index:42'
   from="32.25pt,70.5pt" to="573pt,70.5pt" coordsize="21600,21600"
   strokecolor="red [10]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:37;margin-left:42px;margin-top:10px;width:725px;height:85px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=723></td>
    <td width=2></td>
   </tr>
   <tr>
    <td height=56></td>
    <td></td>
    <td align=left valign=top><a href="#RANGE!A1"><img border=0 width=2
    height=56 src="VIB_GNT_files/image003.gif" alt="Text Box: TRỞ LẠI" v:shapes="_x0000_s1075"></a></td>
   </tr>
   <tr>
    <td height=27></td>
   </tr>
   <tr>
    <td height=2></td>
    <td align=left valign=top><img width=723 height=2
    src="VIB_GNT_files/image004.gif" v:shapes="_x0000_s1080"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=40 class=xl520 width=145 style='height:30.0pt;width:109pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl520 style='mso-ignore:colspan'></td>
  <td class=xl513></td>
  <td colspan=3 class=xl521 style='mso-ignore:colspan'></td>
  <td class=xl513></td>
  <td colspan=2 class=xl522 style='mso-ignore:colspan'></td>
  <td class=xl523 colspan=4 style='mso-ignore:colspan'>Số <font class="font17">No</font><font
  class="font18"> ……</font></td>
  <td class=xl523></td>
  <td class=xl523 colspan=9 style='mso-ignore:colspan'>Ngày <font class="font17">Date..</font><font
  class="font19"><%=p_Date %></font><font class="font17">…</font><font class="font19">/</font><font
  class="font17">..</font><font class="font19"><%=p_Month %></font><font class="font17">...</font><font
  class="font19">/..<%=p_Year %></font><font class="font20">...</font></td>
  <td colspan=4 class=xl513 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl513 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=11 class=xl526 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl527 colspan=11 style='mso-ignore:colspan'>Liên 1 Giao người nộp
  Copy 1 Depositor's copy</td>
  <td colspan=7 class=xl526 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl513></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl523 colspan=14 style='height:27.0pt;mso-ignore:colspan'>Người
  nộp <font class="font17">Deposited by:<span style='mso-spacerun:yes'>  
  </span></font><font class="font19"><%=p_D_Acc_Nm %></font></td>
  <td colspan=14 class=xl513 style='mso-ignore:colspan'></td>
  <td class=xl528></td>
  <td class=xl513></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 style='height:17.25pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1081" style='position:absolute;z-index:43' from="71.25pt,15pt"
   to="456.75pt,15pt" coordsize="21600,21600" strokecolor="red [10]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:43;margin-left:94px;margin-top:19px;width:516px;height:2px'><img
  width=516 height=2 src="VIB_GNT_files/image005.gif" v:shapes="_x0000_s1081"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=23 class=xl523 width=100 style='height:17.25pt;width:75pt'>Địa
    chỉ <font class="font17">Address :<span style='mso-spacerun:yes'>  </span></font><font
    class="font19"><%=p_D_Add %></font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl513></td>
  <td class=xl529></td>
  <td colspan=15 class=xl530 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl529 style='mso-ignore:colspan'></td>
  <td class=xl513></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 style='height:17.25pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1077" style='position:absolute;z-index:39' from="458.25pt,49.5pt"
   to="650.25pt,50.25pt" strokecolor="gray [23]" strokeweight="6pt"
   o:insetmode="auto"/><v:line id="_x0000_s1078" style='position:absolute;
   z-index:40' from="460.5pt,4.5pt" to="460.5pt,51.75pt" strokecolor="gray [23]"
   strokeweight="4.5pt" o:insetmode="auto"/><v:line id="_x0000_s1082" style='position:absolute;
   z-index:44' from="110.25pt,15pt" to="455.25pt,15pt" coordsize="21600,21600"
   strokecolor="red [10]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1083" style='position:absolute;z-index:45'
   from="106.5pt,32.25pt" to="457.5pt,32.25pt" coordsize="21600,21600"
   strokecolor="red [10]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1084" style='position:absolute;z-index:46'
   from="107.25pt,49.5pt" to="458.25pt,49.5pt" coordsize="21600,21600"
   strokecolor="red [10]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1086" style='position:absolute;z-index:48'
   from="1.5pt,81.75pt" to="646.5pt,81.75pt" coordsize="21600,21600"
   strokecolor="red [10]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1085" style='position:absolute;z-index:47'
   from="146.25pt,65.25pt" to="648.75pt,65.25pt" coordsize="21600,21600"
   strokecolor="red [10]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:39;margin-left:1px;margin-top:3px;width:870px;height:107px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=140></td>
    <td width=53></td>
    <td width=669></td>
    <td width=3></td>
    <td width=5></td>
   </tr>
   <tr>
    <td height=69></td>
    <td></td>
    <td colspan=4 align=left valign=top><img width=730 height=69
    src="VIB_GNT_files/image006.gif" v:shapes="_x0000_s1077 _x0000_s1078 _x0000_s1082 _x0000_s1083 _x0000_s1084"></td>
   </tr>
   <tr>
    <td height=14></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=2></td>
    <td colspan=2 align=left valign=top><img width=672 height=2
    src="VIB_GNT_files/image007.gif" v:shapes="_x0000_s1085"></td>
   </tr>
   <tr>
    <td height=20></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=3 align=left valign=top><img width=862 height=2
    src="VIB_GNT_files/image008.gif" v:shapes="_x0000_s1086"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=23 class=xl523 width=100 style='height:17.25pt;width:75pt'>Số
    tài khoản<font class="font17"> A/C number :<span style='mso-spacerun:yes'> 
    </span></font><font class="font19"><%=_str_Dr %></font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl513></td>
  <td class=xl531></td>
  <td colspan=15 class=xl529 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl532>Số tiền bằng số Amount in figures</td>
  <td class=xl513></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl523 colspan=7 style='height:17.25pt;mso-ignore:colspan'>Tên
  Tài khoản <font class="font17">A/c name:<span style='mso-spacerun:yes'> 
  </span></font><font class="font19"><%=p_C_Acc_Nm %></font></td>
  <td colspan=9 class=xl533 style='mso-ignore:colspan'></td>
  <td class=xl534></td>
  <td class=xl535></td>
  <td colspan=10 rowspan=2 class=xl536 ><span
  style='mso-spacerun:yes'> </span><%=_str_Amt %> <%=p_Ccy %><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl537>&nbsp;</td>
  <td class=xl513></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl523 colspan=7 style='height:17.25pt;mso-ignore:colspan'>Tại
  ngân hàng <font class="font17">With bank:<span style='mso-spacerun:yes'> 
  </span></font><font class="font19"><%=p_C_Bank %></font></td>
  <td colspan=9 class=xl533 style='mso-ignore:colspan'></td>
  <td class=xl534></td>
  <td class=xl513></td>
  <td class=xl539>&nbsp;</td>
  <td class=xl513></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=29 rowspan=2 height=46 class=xl551 width=866 style='height:34.5pt;
  width:652pt'>Số tiền bằng chữ <font class="font17">Amount in words:<span
  style='mso-spacerun:yes'>  </span></font><font class="font19"><%=Inword %></font></td>
  <td class=xl513></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl513 style='height:17.25pt'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl523 style='height:17.25pt'>Nội dung<font class="font18">
  </font><font class="font17">Rema</font><span style='display:none'><font
  class="font17">rks:<span style='mso-spacerun:yes'>  </span></font><font
  class="font19"><%=p_Remark %></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1087"
   style='position:absolute;z-index:49' from="6pt,15.75pt" to="573.75pt,15.75pt"
   coordsize="21600,21600" strokecolor="red [10]" strokeweight="1pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:49;margin-left:7px;margin-top:20px;width:759px;height:2px'><img
  width=759 height=2 src="VIB_GNT_files/image009.gif" v:shapes="_x0000_s1087"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=23 class=xl513 width=145 style='height:17.25pt;width:109pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl513></td>
  <td colspan=26 class=xl540 style='mso-ignore:colspan'></td>
  <td class=xl513></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 colspan=2 class=xl513 style='height:8.25pt;mso-ignore:colspan'></td>
  <td colspan=27 class=xl540 style='mso-ignore:colspan'></td>
  <td class=xl513></td>
 </tr>
 <tr class=xl513 height=4 style='mso-height-source:userset;height:3.0pt'>
  <td height=4 colspan=2 class=xl541 style='height:3.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=27 class=xl542 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl513></td>
 </tr>
 <tr class=xl513 height=4 style='mso-height-source:userset;height:3.0pt'>
  <td height=4 colspan=2 class=xl543 style='height:3.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=20 class=xl544 style='mso-ignore:colspan'>&nbsp;</td>
  <td height=4 class=xl544 width=24 style='height:3.0pt;width:18pt'><!--[if gte vml 1]><v:line
   id="_x0000_s1079" style='position:absolute;z-index:41' from="15.75pt,2.25pt"
   to="15.75pt,2.25pt" strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=20 height=2></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=2 height=2 src="VIB_GNT_files/image010.gif" v:shapes="_x0000_s1079"></td>
    <td width=2></td>
   </tr>
   <tr>
    <td height=0></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:18.0pt;height:3.0pt'></span><![endif]--></td>
  <td colspan=6 class=xl545 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl513></td>
 </tr>
 <tr class=xl513 height=21 style='height:15.75pt'>
  <td height=21 class=xl546 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Người
  nộp tiền</td>
  <td class=xl547 colspan=3 style='mso-ignore:colspan'>Thủ quỹ</td>
  <td colspan=6 class=xl526 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl547 colspan=5 style='mso-ignore:colspan'>Giao dịch viên<font
  class="font5"><span style='mso-spacerun:yes'> </span></font></td>
  <td colspan=2 class=xl526 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl547 colspan=6 style='mso-ignore:colspan'>Kiểm soát viên<font
  class="font5"><span style='mso-spacerun:yes'> </span></font></td>
  <td colspan=5 class=xl526 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl513></td>
 </tr>
 <tr class=xl513 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl548 style='height:13.5pt'>Depositor</td>
  <td class=xl526>&nbsp;</td>
  <td class=xl526 colspan=3 style='mso-ignore:colspan'>Cashier</td>
  <td colspan=6 class=xl526 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl526 colspan=2 style='mso-ignore:colspan'>Teller</td>
  <td colspan=5 class=xl526 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl526 colspan=3 style='mso-ignore:colspan'>Supervisor</td>
  <td colspan=8 class=xl526 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl513></td>
 </tr>
 <tr class=xl513 height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=6 class=xl549 style='height:10.5pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl526>&nbsp;</td>
  <td colspan=2 class=xl549 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=13 class=xl526 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=7 class=xl549 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl513></td>
 </tr>
 <tr class=xl513 height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=6 class=xl549 style='height:10.5pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl526>&nbsp;</td>
  <td colspan=2 class=xl549 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=13 class=xl526 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=7 class=xl549 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl513></td>
 </tr>
 <tr class=xl513 height=21 style='height:15.75pt'>
  <td height=21 colspan=29 class=xl526 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl513></td>
 </tr>
 <tr class=xl513 height=21 style='height:15.75pt'>
  <td height=21 colspan=29 class=xl526 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl513></td>
 </tr>
 <tr class=xl513 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=2 class=xl526 style='height:18.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl550>&nbsp;</td>
  <td colspan=26 class=xl526 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl513></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=100 style='width:75pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=13 style='width:10pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=22 style='width:17pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=12 style='width:9pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=6 style='width:5pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=81 style='width:61pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
