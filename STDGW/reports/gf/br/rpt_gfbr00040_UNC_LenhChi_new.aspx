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
        p_Remark = dt.Rows[0][13].ToString();
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
        if (p_Ccy == "VND")
        {
            Inword = CommondLib.Num2VNText(dt_Amount.Rows[0][9].ToString(), p_Ccy);
        }
        else
        {
            Inword = CommondLib.Num2EngText(dt_Amount.Rows[0][9].ToString(), p_Ccy);
        }
        
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
<link rel=File-List href="Vietinbank_Lenhchi_files/filelist.xml">
<link rel=Edit-Time-Data href="Vietinbank_Lenhchi_files/editdata.mso">
<link rel=OLE-Object-Data href="Vietinbank_Lenhchi_files/oledata.mso">
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
  <o:LastPrinted>2012-02-01T05:35:30Z</o:LastPrinted>
  <o:Created>2012-01-12T09:28:17Z</o:Created>
  <o:LastSaved>2012-02-01T05:52:05Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}

	@page
	{margin:.19in .25in .25in .25in;
	mso-header-margin:.19in;
	mso-footer-margin:.25in;}
.font5
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font13
	{color:#333333;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font14
	{color:#333333;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font15
	{color:#333333;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font16
	{color:gray;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font17
	{color:#333333;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font19
	{color:#333333;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font23
	{color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font27
	{color:red;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font28
	{color:gray;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font30
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font31
	{color:windowtext;
	font-size:10.0pt;
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
.style16
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
.xl24
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	color:blue;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"\.VnArial", sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$-1010000\]d\/m\/yyyy\;\@";
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl34
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl35
	{mso-style-parent:style0;
	color:white;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl36
	{mso-style-parent:style0;
	color:white;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl37
	{mso-style-parent:style0;
	color:white;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:justify;}
.xl39
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style16;
	color:#FFCC99;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	color:white;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	color:white;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl43
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl44
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	color:white;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	color:#FF9900;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:red;
	mso-pattern:auto none;}
.xl47
	{mso-style-parent:style0;
	color:#FF9900;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	background:red;
	mso-pattern:auto none;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	background:blue;
	mso-pattern:auto none;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	background:#99CCFF;
	mso-pattern:auto none;
	padding-left:24px;
	mso-char-indent-count:2;}
.xl50
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	background:#99CCFF;
	mso-pattern:auto none;
	padding-left:24px;
	mso-char-indent-count:2;}
.xl51
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl54
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl55
	{mso-style-parent:style0;
	color:blue;
	font-size:22.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl56
	{mso-style-parent:style0;
	color:#333333;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl57
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:justify;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl59
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl60
	{mso-style-parent:style16;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl61
	{mso-style-parent:style0;
	color:#3366FF;
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
    <x:Name>Lenh chi</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>96</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:CodeName>Sheet9</x:CodeName>
     <x:TabColorIndex>13</x:TabColorIndex>
     <x:PageBreakZoom>100</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>28</x:ActiveRow>
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
  <x:WindowWidth>18195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>135</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1087"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=893 style='border-collapse:
 collapse;table-layout:fixed;width:671pt'>
 <col class=xl24 width=100 style='mso-width-source:userset;mso-width-alt:2844;
 width:75pt'>
 <col class=xl24 width=79 style='mso-width-source:userset;mso-width-alt:2247;
 width:59pt'>
 <col class=xl24 width=36 style='mso-width-source:userset;mso-width-alt:1024;
 width:27pt'>
 <col class=xl24 width=13 style='mso-width-source:userset;mso-width-alt:369;
 width:10pt'>
 <col class=xl24 width=24 span=11 style='mso-width-source:userset;mso-width-alt:
 682;width:18pt'>
 <col class=xl24 width=25 style='mso-width-source:userset;mso-width-alt:711;
 width:19pt'>
 <col class=xl24 width=24 style='mso-width-source:userset;mso-width-alt:682;
 width:18pt'>
 <col class=xl24 width=22 style='mso-width-source:userset;mso-width-alt:625;
 width:17pt'>
 <col class=xl24 width=24 span=4 style='mso-width-source:userset;mso-width-alt:
 682;width:18pt'>
 <col class=xl24 width=12 style='mso-width-source:userset;mso-width-alt:341;
 width:9pt'>
 <col class=xl24 width=24 span=3 style='mso-width-source:userset;mso-width-alt:
 682;width:18pt'>
 <col class=xl24 width=29 span=2 style='mso-width-source:userset;mso-width-alt:
 824;width:22pt'>
 <col class=xl24 width=6 style='mso-width-source:userset;mso-width-alt:170;
 width:5pt'>
 <col class=xl24 width=80 style='width:60pt'>
 <col class=xl24 width=3 span=2 style='mso-width-source:userset;mso-width-alt:
 85;width:2pt'>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl24 width=100 style='height:13.5pt;width:75pt'><a
  name="RANGE!A1"></a></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=36 style='width:27pt'></td>
  <td class=xl24 width=13 style='width:10pt'></td>
  <td class=xl24 width=24 style='width:18pt'></td>
  <td class=xl24 width=24 style='width:18pt'></td>
  <td class=xl24 width=24 style='width:18pt'></td>
  <td class=xl24 width=24 style='width:18pt'></td>
  <td class=xl24 width=24 style='width:18pt'></td>
  <td class=xl24 width=24 style='width:18pt'></td>
  <td class=xl24 width=24 style='width:18pt'></td>
  <td class=xl24 width=24 style='width:18pt'></td>
  <td class=xl24 width=24 style='width:18pt'></td>
  <td class=xl24 width=24 style='width:18pt'></td>
  <td class=xl24 width=24 style='width:18pt'></td>
  <td class=xl24 width=25 style='width:19pt'></td>
  <td class=xl24 width=24 style='width:18pt'></td>
  <td class=xl24 width=22 style='width:17pt'></td>
  <td class=xl24 width=24 style='width:18pt'></td>
  <td class=xl24 width=24 style='width:18pt'></td>
  <td class=xl24 width=24 style='width:18pt'></td>
  <td class=xl24 width=24 style='width:18pt'></td>
  <td class=xl24 width=12 style='width:9pt'></td>
  <td class=xl24 width=24 style='width:18pt'></td>
  <td class=xl24 width=24 style='width:18pt'></td>
  <td class=xl24 width=24 style='width:18pt'></td>
  <td class=xl24 width=29 style='width:22pt'></td>
  <td class=xl24 width=29 style='width:22pt'></td>
  <td class=xl24 width=6 style='width:5pt'></td>
  <td class=xl24 width=80 style='width:60pt'></td>
  <td class=xl24 width=3 style='width:2pt'></td>
  <td class=xl24 width=3 style='width:2pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=20 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
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
   style='position:absolute;margin-left:7.5pt;margin-top:3pt;width:201.75pt;
   height:33.75pt;z-index:1;visibility:visible'>
   <v:imagedata src="Vietinbank_Lenhchi_files/image001.png" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:Anchor>
     20, 10, 1, 4, 30, 13, 3, 4</x:Anchor>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:10px;margin-top:4px;width:269px;
  height:45px'><img width=269 height=45
  src="Vietinbank_Lenhchi_files/image002.jpg" v:shapes="Picture_x0020_1"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=21 class=xl24 width=24 style='height:15.75pt;width:18pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=11 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 class=xl25 colspan=8 style='height:18.0pt;mso-ignore:colspan'>Ngân
  Hàng TMCP Công Thương Việt Nam</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl24></td>
  <td class=xl27></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td colspan=30 height=34 class=xl55 style='height:25.5pt'>Lệnh Chi</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=30 height=21 class=xl56 style='height:15.75pt'>Payment Order</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 colspan=6 class=xl28 style='height:30.0pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl24 colspan=4 style='mso-ignore:colspan'>Số<font class="font13"> </font><font
  class="font14">No</font><font class="font15"> ……</font></td>
  <td class=xl24></td>
  <td class=xl24 colspan=10 style='mso-ignore:colspan'>Ngày<font class="font16">
  </font><font class="font14">Date</font><font class="font15">.</font><font
  class="font17">…<%=p_Date%>./…<%=p_Month%>./…<%=p_Year %>...</font></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=22 class=xl31 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl32 colspan=5 style='mso-ignore:colspan'>Liên <font class="font19"><span
  style='mso-spacerun:yes'> </span>Copy<span style='mso-spacerun:yes'>  </span></font></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl34 style='height:18.75pt'>Tên đơn vị trả ti<span
  style='display:none'>ền<font class="font16"> </font><font class="font14">Payer:<span
  style='mso-spacerun:yes'>   </span></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1057"
   style='position:absolute;z-index:27' from="51.75pt,14.25pt" to="520.5pt,14.25pt"
   strokecolor="gray [23]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:27;margin-left:68px;margin-top:18px;width:627px;height:2px'><img
  width=627 height=2 src="Vietinbank_Lenhchi_files/image003.gif" v:shapes="_x0000_s1057"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=25 class=xl34 width=79 style='height:18.75pt;width:59pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=28 class=xl57><%=p_D_Acc_Nm%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl33 style='height:15.75pt'>Tài khoản nợ<font
  class="font13"> </font><font class="font14">D</font><span style='display:
  none'><font class="font14">ebit A/C:<span style='mso-spacerun:yes'>   </span></font><font
  class="font13"><%=_str_Dr %></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1058"
   style='position:absolute;z-index:28' from="46.5pt,13.5pt" to="318.75pt,13.5pt"
   strokecolor="gray [23]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:28;margin-left:61px;margin-top:17px;width:365px;height:2px'><img
  width=365 height=2 src="Vietinbank_Lenhchi_files/image004.gif" v:shapes="_x0000_s1058"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=21 class=xl33 width=79 style='height:15.75pt;width:59pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24></td>
  <td class=xl35></td>
  <td colspan=15 class=xl37 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 style='height:17.25pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1028" style='position:absolute;flip:y;z-index:3' from="384pt,49.5pt"
   to="588pt,49.5pt" strokecolor="gray [23]" strokeweight="6pt" o:insetmode="auto"/><v:line
   id="_x0000_s1029" style='position:absolute;z-index:4' from="386.25pt,4.5pt"
   to="386.25pt,49.5pt" strokecolor="gray [23]" strokeweight="4.5pt"
   o:insetmode="auto"/><v:line id="_x0000_s1059" style='position:absolute;
   z-index:29' from="113.25pt,15pt" to="384pt,15pt" strokecolor="gray [23]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1060" style='position:absolute;z-index:30'
   from="151.5pt,31.5pt" to="378pt,31.5pt" strokecolor="gray [23]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1061" style='position:absolute;z-index:31'
   from="3.75pt,47.25pt" to="383.25pt,47.25pt" strokecolor="gray [23]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1062" style='position:absolute;z-index:32'
   from="133.5pt,66.75pt" to="587.25pt,66.75pt" strokecolor="gray [23]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:3;margin-left:4px;margin-top:3px;width:784px;height:87px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=173></td>
    <td width=607></td>
    <td width=4></td>
   </tr>
   <tr>
    <td height=67></td>
    <td colspan=3 align=left valign=top><img width=784 height=67
    src="Vietinbank_Lenhchi_files/image005.gif" v:shapes="_x0000_s1028 _x0000_s1029 _x0000_s1059 _x0000_s1060 _x0000_s1061"></td>
   </tr>
   <tr>
    <td height=18></td>
   </tr>
   <tr>
    <td height=2></td>
    <td></td>
    <td align=left valign=top><img width=607 height=2
    src="Vietinbank_Lenhchi_files/image006.gif" v:shapes="_x0000_s1062"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=23 class=xl24 width=100 style='height:17.25pt;width:75pt'>Tại
    ngân hàng<font class="font23"> </font><font class="font14">With bank:<span
    style='mso-spacerun:yes'>  </span></font><font class="font13"><%=p_D_Bank%></font></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl36></td>
  <td colspan=15 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl58>Số tiền bằng số <font class="font17">Amount in
  figures</font></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=18 rowspan=2 height=43 class=xl59 width=563 style='height:32.25pt;
  width:423pt'>Số tiền bằng chữ <font class="font14">Amount in words:<span
  style='mso-spacerun:yes'>   </span></font><font class="font13"><%=Inword%></font></td>
  <td class=xl38></td>
  <td colspan=10 rowspan=2 class=xl60 ><span
  style='mso-spacerun:yes'>     </span><%=_str_Amt %> <%=p_Ccy %><span
  style='mso-spacerun:yes'>     </span></td>
  <td class=xl39>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl40>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl29 colspan=16 style='height:22.5pt;mso-ignore:colspan'>Tên
  đơn vị nhận tiền<font class="font14"> Payer:<span style='mso-spacerun:yes'> 
  </span></font><font class="font13"><%=p_C_Acc_Nm %></font></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl42></td>
  <td class=xl24></td>
  <td class=xl43></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'>Tài khoản có<font
  class="font13"> </font><font class="font15">Cr</font><span style='display:
  none'><font class="font15">edit/ </font><font class="font14">AC:<span
  style='mso-spacerun:yes'>    </span></font><font class="font5"><%=_str%></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1063"
   style='position:absolute;z-index:33' from="48pt,13.5pt" to="521.25pt,13.5pt"
   strokecolor="gray [23]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:33;margin-left:63px;margin-top:17px;width:633px;height:2px'><img
  width=633 height=2 src="Vietinbank_Lenhchi_files/image007.gif" v:shapes="_x0000_s1063"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=21 class=xl24 width=79 style='height:15.75pt;width:59pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24></td>
  <td class=xl35></td>
  <td class=xl24></td>
  <td colspan=25 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl44 style='height:18.0pt'>Tại ngân hàng<font
  class="font13"> </font><span style='display:none'><font class="font14">With
  bank:<span style='mso-spacerun:yes'>   </span></font><font class="font13"><%=p_C_Bank %></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1064"
   style='position:absolute;z-index:34' from="47.25pt,15pt" to="520.5pt,15pt"
   strokecolor="gray [23]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]-->
  
 
  
  <![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:34;margin-left:62px;margin-top:19px;width:587px;height:2px'><img
  width=587 height=2 src="Vietinbank_Lenhchi_files/image008.gif" v:shapes="_x0000_s1064"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl44 width=79 style='height:18.0pt;width:59pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=25 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=30 height=23 class=xl61 width=887 style='height:17.25pt;
  width:667pt'><!--[if gte vml 1]><v:line id="_x0000_s1065" style='position:absolute;
   z-index:35' from="87pt,14.25pt" to="587.25pt,14.25pt" strokecolor="gray [23]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:35;margin-left:115px;margin-top:18px;width:669px;height:
  2px'><img width=669 height=2 src="Vietinbank_Lenhchi_files/image009.gif"
  v:shapes="_x0000_s1065"></span><![endif]>Nội dung<font class="font28"> </font><font
  class="font14">Remarks:<span style='mso-spacerun:yes'>    </span></font><font
  class="font13"><%=p_Remark %></font></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 colspan=3 class=xl24 style='height:8.25pt;mso-ignore:colspan'></td>
  <td colspan=20 class=xl45 style='mso-ignore:colspan'></td>
  <td width=24 style='width:18pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1027" style='position:absolute;flip:y;z-index:2' from="12.75pt,7.5pt"
   to="23.25pt,13.5pt" strokecolor="white [9]" strokeweight="2.25pt"
   o:insetmode="auto"/><v:line id="_x0000_s1030" style='position:absolute;
   z-index:5' from="15.75pt,10.5pt" to="15.75pt,10.5pt" strokecolor="windowText [64]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:15px;margin-top:8px;width:18px;
  height:12px'><img width=18 height=12
  src="Vietinbank_Lenhchi_files/image010.gif" v:shapes="_x0000_s1027 _x0000_s1030"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=11 class=xl45 width=24 style='height:8.25pt;width:18pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl45 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=6 style='mso-height-source:userset;height:4.5pt'>
  <td height=6 colspan=3 class=xl46 style='height:4.5pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=21 class=xl47 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=6 class=xl48 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl49 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Đơn
  vị trả tiền<font class="font30"> </font><font class="font31">Payer</font></td>
  <td class=xl49>&nbsp;</td>
  <td colspan=9 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl31 colspan=13 style='mso-ignore:colspan'>Ngày hạch toán <font
  class="font31">Accounting date ..…/…../……</font></td>
  <td colspan=5 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl50 colspan=2 style='height:13.5pt;mso-ignore:colspan'>Kế
  toán<font class="font5"> </font><font class="font23">Accountant</font></td>
  <td class=xl50>&nbsp;</td>
  <td class=xl51 colspan=8 style='mso-ignore:colspan'>Chủ tài khoản<font
  class="font5"> A</font><font class="font23">/c holder</font></td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51 colspan=7 style='mso-ignore:colspan'>Giao dịch viên<font
  class="font5"> </font><font class="font23">Teller</font></td>
  <td class=xl51 colspan=8 style='mso-ignore:colspan'>Kiểm soát viên<font
  class="font5"> </font><font class="font23">Supervisor</font></td>
  <td class=xl51>&nbsp;</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=7 class=xl52 style='height:10.5pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td colspan=3 class=xl52 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=15 class=xl52 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=7 class=xl52 style='height:10.5pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td colspan=3 class=xl52 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=15 class=xl52 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=30 class=xl31 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=30 class=xl31 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=3 class=xl31 style='height:18.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl54 colspan=8 style='mso-ignore:colspan'>Ký tên, đóng dấu
  Signature &amp; Seal</td>
  <td class=xl54>&nbsp;</td>
  <td colspan=5 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1031"
   style='position:absolute;z-index:6' from="14.25pt,18.75pt" to="14.25pt,18.75pt"
   strokecolor="gray [23]" strokeweight="4.5pt" o:insetmode="auto"/><v:line
   id="_x0000_s1037" style='position:absolute;z-index:12' from="14.25pt,18.75pt"
   to="14.25pt,18.75pt" strokecolor="gray [23]" strokeweight="4.5pt"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:6;margin-left:16px;margin-top:22px;width:6px;
  height:6px'><img width=6 height=6 src="Vietinbank_Lenhchi_files/image011.gif"
  v:shapes="_x0000_s1031 _x0000_s1037"></span><![endif]><span style='mso-ignore:
  vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=25 class=xl31 width=22 style='height:18.75pt;width:17pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1034"
   style='position:absolute;z-index:9' from="14.25pt,18.75pt" to="14.25pt,18.75pt"
   strokecolor="gray [23]" strokeweight="4.5pt" o:insetmode="auto"/><v:line
   id="_x0000_s1040" style='position:absolute;z-index:15' from="14.25pt,18.75pt"
   to="14.25pt,18.75pt" strokecolor="gray [23]" strokeweight="4.5pt"
   o:insetmode="auto"/><v:line id="_x0000_s1043" style='position:absolute;
   z-index:18' from="14.25pt,18.75pt" to="14.25pt,18.75pt" strokecolor="gray [23]"
   strokeweight="4.5pt" o:insetmode="auto"/><v:line id="_x0000_s1046" style='position:absolute;
   z-index:21' from="14.25pt,18.75pt" to="14.25pt,18.75pt" strokecolor="gray [23]"
   strokeweight="4.5pt" o:insetmode="auto"/><v:line id="_x0000_s1049" style='position:absolute;
   z-index:24' from="14.25pt,18.75pt" to="14.25pt,18.75pt" strokecolor="gray [23]"
   strokeweight="4.5pt" o:insetmode="auto"/><v:line id="_x0000_s1069" style='position:absolute;
   z-index:36' from="14.25pt,18.75pt" to="14.25pt,18.75pt" strokecolor="gray [23]"
   strokeweight="4.5pt" o:insetmode="auto"/><v:line id="_x0000_s1085" style='position:absolute;
   z-index:38' from="14.25pt,18.75pt" to="14.25pt,18.75pt" strokecolor="gray [23]"
   strokeweight="4.5pt" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:9;margin-left:16px;
  margin-top:22px;width:6px;height:6px'><img width=6 height=6
  src="Vietinbank_Lenhchi_files/image011.gif" v:shapes="_x0000_s1034 _x0000_s1040 _x0000_s1043 _x0000_s1046 _x0000_s1049 _x0000_s1069 _x0000_s1085"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=25 class=xl31 width=24 style='height:18.75pt;width:18pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td colspan=4 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1032"
   style='position:absolute;z-index:7' from="15.75pt,18.75pt" to="15.75pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1035"
   style='position:absolute;z-index:10' from="15.75pt,18.75pt" to="15.75pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1038"
   style='position:absolute;z-index:13' from="15.75pt,18.75pt" to="15.75pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1041"
   style='position:absolute;z-index:16' from="15.75pt,18.75pt" to="15.75pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1044"
   style='position:absolute;z-index:19' from="15.75pt,18.75pt" to="15.75pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1047"
   style='position:absolute;z-index:22' from="15.75pt,18.75pt" to="15.75pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1050"
   style='position:absolute;z-index:25' from="15.75pt,18.75pt" to="15.75pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1056"
   style='position:absolute;z-index:26' from="15.75pt,18.75pt" to="15.75pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1070"
   style='position:absolute;z-index:37' from="15.75pt,18.75pt" to="15.75pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1086"
   style='position:absolute;z-index:39' from="15.75pt,18.75pt" to="15.75pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:7;margin-left:20px;
  margin-top:24px;width:2px;height:2px'><img width=2 height=2
  src="Vietinbank_Lenhchi_files/image012.gif" v:shapes="_x0000_s1032 _x0000_s1035 _x0000_s1038 _x0000_s1041 _x0000_s1044 _x0000_s1047 _x0000_s1050 _x0000_s1056 _x0000_s1070 _x0000_s1086"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=25 class=xl31 width=24 style='height:18.75pt;width:18pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 rowspan=2 height=46 class=xl24 width=6 style='mso-ignore:colspan-rowspan;
  height:34.5pt;width:4pt'><!--[if gte vml 1]><v:shapetype id="_x0000_t202"
   coordsize="21600,21600" o:spt="202" path="m,l,21600r21600,l21600,xe">
   <v:stroke joinstyle="miter"/>
   <v:path gradientshapeok="t" o:connecttype="rect"/>
  </v:shapetype><v:shape id="_x0000_s1033" type="#_x0000_t202"
   href="#RANGE!A1" style='position:absolute;margin-left:2.25pt;margin-top:18.75pt;
   width:0;height:0;z-index:8;visibility:visible;mso-wrap-style:tight'
   o:button="t" fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font27">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1036" type="#_x0000_t202" href="#RANGE!A1"
   style='position:absolute;margin-left:2.25pt;margin-top:18.75pt;width:0;
   height:0;z-index:11;visibility:visible;mso-wrap-style:tight' o:button="t"
   fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font27">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1039" type="#_x0000_t202" href="#RANGE!A1"
   style='position:absolute;margin-left:2.25pt;margin-top:18.75pt;width:0;
   height:0;z-index:14;visibility:visible;mso-wrap-style:tight' o:button="t"
   fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font27">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1042" type="#_x0000_t202" href="#RANGE!A1"
   style='position:absolute;margin-left:2.25pt;margin-top:18.75pt;width:0;
   height:0;z-index:17;visibility:visible;mso-wrap-style:tight' o:button="t"
   fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font27">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1045" type="#_x0000_t202" href="#RANGE!A1"
   style='position:absolute;margin-left:2.25pt;margin-top:18.75pt;width:0;
   height:0;z-index:20;visibility:visible;mso-wrap-style:tight' o:button="t"
   fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font27">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1048" type="#_x0000_t202" href="#RANGE!A1"
   style='position:absolute;margin-left:2.25pt;margin-top:18.75pt;width:0;
   height:0;z-index:23;visibility:visible;mso-wrap-style:tight' o:button="t"
   fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font27">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=2 height=24></td>
   </tr>
   <tr>
    <td></td>
    <td><map name=MicrosoftOfficeMap0><area shape=Rect
    coords="0, 0, 2, 2" href="#RANGE!A1"><area shape=Rect
    coords="0, 0, 2, 2" href="#RANGE!A1"><area shape=Rect
    coords="0, 0, 2, 2" href="#RANGE!A1"><area shape=Rect
    coords="0, 0, 2, 2" href="#RANGE!A1"><area shape=Rect
    coords="0, 0, 2, 2" href="#RANGE!A1"><area shape=Rect
    coords="0, 0, 2, 2" href="#RANGE!A1"></map><img border=0 width=2 height=2
    src="Vietinbank_Lenhchi_files/image012.gif" usemap="#MicrosoftOfficeMap0"
    v:shapes="_x0000_s1033 _x0000_s1036 _x0000_s1039 _x0000_s1042 _x0000_s1045 _x0000_s1048"></td>
    <td width=2></td>
   </tr>
   <tr>
    <td height=20></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:4.5pt;height:34.5pt'></span><![endif]--></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=30 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=100 style='width:75pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=36 style='width:27pt'></td>
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
  <td width=80 style='width:60pt'></td>
  <td width=3 style='width:2pt'></td>
  <td width=3 style='width:2pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
