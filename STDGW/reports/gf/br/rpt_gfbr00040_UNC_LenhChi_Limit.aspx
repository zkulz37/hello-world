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
		
	p_D_Acc_No = p_D_Acc_No.Replace("-","");
	p_D_Acc_No = p_D_Acc_No.Replace(".","");
	
	p_C_Acc_No= p_C_Acc_No.Replace("-","");
	p_C_Acc_No= p_C_Acc_No.Replace(".","");
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
  <o:LastAuthor>LONG</o:LastAuthor>
  <o:LastPrinted>2012-02-01T05:35:30Z</o:LastPrinted>
  <o:Created>2012-01-12T09:28:17Z</o:Created>
  <o:LastSaved>2012-02-02T03:53:50Z</o:LastSaved>
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
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font23
	{color:red;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font24
	{color:white;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font25
	{color:white;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font26
	{color:white;
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
	color:#3366FF;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl33
	{mso-style-parent:style0;
	color:white;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl34
	{mso-style-parent:style0;
	color:white;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl35
	{mso-style-parent:style0;
	color:white;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:justify;}
.xl37
	{mso-style-parent:style0;
	color:white;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	color:white;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl39
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl40
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	color:white;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	color:blue;
	font-size:22.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl43
	{mso-style-parent:style0;
	color:#333333;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:justify;}
.xl49
	{mso-style-parent:style16;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl50
	{mso-style-parent:style16;
	color:#FFCC99;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl51
	{mso-style-parent:style0;
	color:white;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	color:white;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style0;
	color:white;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	padding-left:24px;
	mso-char-indent-count:2;}
.xl54
	{mso-style-parent:style0;
	color:white;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	padding-left:24px;
	mso-char-indent-count:2;}
.xl55
	{mso-style-parent:style0;
	color:white;
	font-size:10.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl56
	{mso-style-parent:style0;
	color:white;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl57
	{mso-style-parent:style0;
	color:white;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
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
       <x:ActiveRow>22</x:ActiveRow>
       <x:ActiveCol>14</x:ActiveCol>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=790 style='border-collapse:
 collapse;table-layout:fixed;width:599pt'>
 <col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:2848;
 width:67pt'>
 <col class=xl24 width=70 style='mso-width-source:userset;mso-width-alt:2240;
 width:53pt'>
 <col class=xl24 width=32 style='mso-width-source:userset;mso-width-alt:1024;
 width:24pt'>
 <col class=xl24 width=12 style='mso-width-source:userset;mso-width-alt:384;
 width:9pt'>
 <col class=xl24 width=21 span=11 style='mso-width-source:userset;mso-width-alt:
 672;width:16pt'>
 <col class=xl24 width=22 style='mso-width-source:userset;mso-width-alt:704;
 width:17pt'>
 <col class=xl24 width=21 style='mso-width-source:userset;mso-width-alt:672;
 width:16pt'>
 <col class=xl24 width=20 style='mso-width-source:userset;mso-width-alt:640;
 width:15pt'>
 <col class=xl24 width=21 span=4 style='mso-width-source:userset;mso-width-alt:
 672;width:16pt'>
 <col class=xl24 width=11 style='mso-width-source:userset;mso-width-alt:352;
 width:8pt'>
 <col class=xl24 width=21 span=3 style='mso-width-source:userset;mso-width-alt:
 672;width:16pt'>
 <col class=xl24 width=26 span=2 style='mso-width-source:userset;mso-width-alt:
 832;width:20pt'>
 <col class=xl24 width=5 style='mso-width-source:userset;mso-width-alt:160;
 width:4pt'>
 <col class=xl24 width=72 style='width:54pt'>
 <col class=xl24 width=3 span=2 style='mso-width-source:userset;mso-width-alt:
 96;width:2pt'>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl24 width=89 style='height:13.5pt;width:67pt'><a
  name="RANGE!A1"></a></td>
  <td class=xl24 width=70 style='width:53pt'></td>
  <td class=xl24 width=32 style='width:24pt'></td>
  <td class=xl24 width=12 style='width:9pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=22 style='width:17pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=20 style='width:15pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=11 style='width:8pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=26 style='width:20pt'></td>
  <td class=xl24 width=26 style='width:20pt'></td>
  <td class=xl24 width=5 style='width:4pt'></td>
  <td class=xl24 width=72 style='width:54pt'></td>
  <td class=xl24 width=3 style='width:2pt'></td>
  <td class=xl24 width=3 style='width:2pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=32 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=10 class=xl25 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=9 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl24></td>
  <td class=xl27></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td colspan=30 height=34 class=xl42 style='height:25.5pt'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=30 height=21 class=xl43 style='height:15.75pt'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 colspan=6 class=xl28 style='height:30.0pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl33 colspan=11 style='mso-ignore:colspan'>Ngày <font class="font24">Date</font><font
  class="font25">.</font><font class="font26">…</font><font class="font15"><%=p_Date%></font><font
  class="font26">./…</font><font class="font15"><%=p_Month%></font><font class="font26">./…</font><font
  class="font15"><%=p_Year %></font><font class="font26">...</font></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=22 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl47 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=2 class=xl32 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=28 class=xl44><%=p_D_Acc_Nm%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl33 colspan=20 style='height:15.75pt;mso-ignore:colspan'>Tài
  khoản nợ <font class="font24">Debit A/C: </font><font class="font13"><%=_str_Dr %></font></td>
  <td colspan=10 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl33 colspan=11 style='height:17.25pt;mso-ignore:colspan'>Tại
  ngân hàng<font class="font24"> With bank:</font><font class="font14"><span
  style='mso-spacerun:yes'>  </span></font><font class="font13"><%=p_D_Bank%></font></td>
  <td colspan=8 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl48></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=18 rowspan=2 height=43 class=xl51 width=497 style='height:32.25pt;
  width:377pt'>Số tiền bằng chữ <font class="font24">Amount in words: </font><font
  class="font14"><span style='mso-spacerun:yes'>  </span></font><font
  class="font13"><%=Inword%></font></td>
  <td class=xl36></td>
  <td colspan=10 rowspan=2 class=xl49 ><span
  style='mso-spacerun:yes'>      </span><%=_str_Amt %> <%=p_Ccy %><span
  style='mso-spacerun:yes'>      </span></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl50></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl52 colspan=10 style='height:22.5pt;mso-ignore:colspan'>Tên
  đơn vị nhận tiền<font class="font24"> Payer: </font><font class="font14"><span
  style='mso-spacerun:yes'> </span></font><font class="font13"><%=p_C_Acc_Nm %></font></td>
  <td colspan=9 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl37 style='mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td class=xl24></td>
  <td class=xl39></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl33 colspan=11 style='height:15.75pt;mso-ignore:colspan'>Tài
  khoản có <font class="font25">Credit/ </font><font class="font24">AC:</font><font
  class="font14"><span style='mso-spacerun:yes'>    </span></font><font
  class="font5"><%=_str%></font></td>
  <td colspan=19 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl52 colspan=6 style='height:18.0pt;mso-ignore:colspan'>Tại
  ngân hàng <font class="font24">With bank: </font><font class="font14"><span
  style='mso-spacerun:yes'>  </span></font><font class="font13"><%=p_C_Bank %></font></td>
  <td colspan=24 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=30 height=23 class=xl51 width=784 style='height:17.25pt;
  width:595pt'>Nội dung<font class="font25"> </font><font class="font24">Remarks:
  </font><font class="font14"><span style='mso-spacerun:yes'>   </span></font><font
  class="font13"><%=p_Remark %></font></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 colspan=3 class=xl24 style='height:8.25pt;mso-ignore:colspan'></td>
  <td colspan=27 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=6 style='mso-height-source:userset;height:4.5pt'>
  <td height=6 colspan=3 class=xl33 style='height:4.5pt;mso-ignore:colspan'></td>
  <td colspan=20 class=xl51 style='mso-ignore:colspan'></td>
  <td colspan=2 height=6 class=xl51 width=42 style='mso-ignore:colspan-rowspan;
  height:4.5pt;width:32pt'><!--[if gte vml 1]><v:line id="_x0000_s1030"
   style='position:absolute;z-index:1' from="15.75pt,2.25pt" to="15.75pt,2.25pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=20 height=2></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=2 height=2 src="Vietinbank_Lenhchi_files/image001.gif"
    v:shapes="_x0000_s1030"></td>
    <td width=20></td>
   </tr>
   <tr>
    <td height=2></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:31.5pt;height:4.5pt'></span><![endif]--></td>
  <td colspan=5 class=xl51 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl53 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=27 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 colspan=3 class=xl54 style='height:13.5pt;mso-ignore:colspan'></td>
  <td colspan=25 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=7 class=xl55 style='height:10.5pt;mso-ignore:colspan'></td>
  <td class=xl33></td>
  <td colspan=3 class=xl55 style='mso-ignore:colspan'></td>
  <td class=xl56></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=15 class=xl55 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=7 class=xl55 style='height:10.5pt;mso-ignore:colspan'></td>
  <td class=xl33></td>
  <td colspan=3 class=xl55 style='mso-ignore:colspan'></td>
  <td class=xl56></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=15 class=xl55 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=30 class=xl33 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=30 class=xl33 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=3 class=xl33 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=9 class=xl57 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=3 rowspan=2 height=46 class=xl33 width=62 style='mso-ignore:colspan-rowspan;
  height:34.5pt;width:47pt'><!--[if gte vml 1]><v:line id="_x0000_s1031"
   style='position:absolute;z-index:2' from="14.25pt,18.75pt" to="14.25pt,18.75pt"
   strokecolor="gray [23]" strokeweight="4.5pt" o:insetmode="auto"/><v:line
   id="_x0000_s1037" style='position:absolute;z-index:8' from="14.25pt,18.75pt"
   to="14.25pt,18.75pt" strokecolor="gray [23]" strokeweight="4.5pt"
   o:insetmode="auto"/><v:line id="_x0000_s1034" style='position:absolute;
   z-index:5' from="29.25pt,18.75pt" to="29.25pt,18.75pt" strokecolor="gray [23]"
   strokeweight="4.5pt" o:insetmode="auto"/><v:line id="_x0000_s1040" style='position:absolute;
   z-index:11' from="29.25pt,18.75pt" to="29.25pt,18.75pt" strokecolor="gray [23]"
   strokeweight="4.5pt" o:insetmode="auto"/><v:line id="_x0000_s1043" style='position:absolute;
   z-index:14' from="29.25pt,18.75pt" to="29.25pt,18.75pt" strokecolor="gray [23]"
   strokeweight="4.5pt" o:insetmode="auto"/><v:line id="_x0000_s1046" style='position:absolute;
   z-index:17' from="29.25pt,18.75pt" to="29.25pt,18.75pt" strokecolor="gray [23]"
   strokeweight="4.5pt" o:insetmode="auto"/><v:line id="_x0000_s1049" style='position:absolute;
   z-index:20' from="29.25pt,18.75pt" to="29.25pt,18.75pt" strokecolor="gray [23]"
   strokeweight="4.5pt" o:insetmode="auto"/><v:line id="_x0000_s1069" style='position:absolute;
   z-index:23' from="29.25pt,18.75pt" to="29.25pt,18.75pt" strokecolor="gray [23]"
   strokeweight="4.5pt" o:insetmode="auto"/><v:line id="_x0000_s1085" style='position:absolute;
   z-index:25' from="29.25pt,18.75pt" to="29.25pt,18.75pt" strokecolor="gray [23]"
   strokeweight="4.5pt" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=16 height=22></td>
    <td width=6></td>
    <td width=14></td>
    <td width=6></td>
    <td width=20></td>
   </tr>
   <tr>
    <td height=6></td>
    <td align=left valign=top><img width=6 height=6
    src="Vietinbank_Lenhchi_files/image002.gif" v:shapes="_x0000_s1031 _x0000_s1037"></td>
    <td></td>
    <td align=left valign=top><img width=6 height=6
    src="Vietinbank_Lenhchi_files/image002.gif" v:shapes="_x0000_s1034 _x0000_s1040 _x0000_s1043 _x0000_s1046 _x0000_s1049 _x0000_s1069 _x0000_s1085"></td>
   </tr>
   <tr>
    <td height=18></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:46.5pt;height:34.5pt'></span><![endif]--></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 rowspan=2 height=46 class=xl33 width=42 style='mso-ignore:colspan-rowspan;
  height:34.5pt;width:32pt'><!--[if gte vml 1]><v:line id="_x0000_s1032"
   style='position:absolute;z-index:3' from="15.75pt,18.75pt" to="15.75pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1035"
   style='position:absolute;z-index:6' from="15.75pt,18.75pt" to="15.75pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1038"
   style='position:absolute;z-index:9' from="15.75pt,18.75pt" to="15.75pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1041"
   style='position:absolute;z-index:12' from="15.75pt,18.75pt" to="15.75pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1044"
   style='position:absolute;z-index:15' from="15.75pt,18.75pt" to="15.75pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1047"
   style='position:absolute;z-index:18' from="15.75pt,18.75pt" to="15.75pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1050"
   style='position:absolute;z-index:21' from="15.75pt,18.75pt" to="15.75pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1056"
   style='position:absolute;z-index:22' from="15.75pt,18.75pt" to="15.75pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1070"
   style='position:absolute;z-index:24' from="15.75pt,18.75pt" to="15.75pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:line id="_x0000_s1086"
   style='position:absolute;z-index:26' from="15.75pt,18.75pt" to="15.75pt,18.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=20 height=24></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=2 height=2 src="Vietinbank_Lenhchi_files/image001.gif"
    v:shapes="_x0000_s1032 _x0000_s1035 _x0000_s1038 _x0000_s1041 _x0000_s1044 _x0000_s1047 _x0000_s1050 _x0000_s1056 _x0000_s1070 _x0000_s1086"></td>
    <td width=20></td>
   </tr>
   <tr>
    <td height=20></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:31.5pt;height:34.5pt'></span><![endif]--></td>
  <td colspan=5 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 rowspan=2 height=46 class=xl24 width=6 style='mso-ignore:colspan-rowspan;
  height:34.5pt;width:4pt'><!--[if gte vml 1]><v:shapetype id="_x0000_t202"
   coordsize="21600,21600" o:spt="202" path="m,l,21600r21600,l21600,xe">
   <v:stroke joinstyle="miter"/>
   <v:path gradientshapeok="t" o:connecttype="rect"/>
  </v:shapetype><v:shape id="_x0000_s1033" type="#_x0000_t202"
   href="#RANGE!A1" style='position:absolute;margin-left:2.25pt;margin-top:18.75pt;
   width:0;height:0;z-index:4;visibility:visible;mso-wrap-style:tight'
   o:button="t" fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font23">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1036" type="#_x0000_t202" href="#RANGE!A1"
   style='position:absolute;margin-left:2.25pt;margin-top:18.75pt;width:0;
   height:0;z-index:7;visibility:visible;mso-wrap-style:tight' o:button="t"
   fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font23">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1039" type="#_x0000_t202" href="#RANGE!A1"
   style='position:absolute;margin-left:2.25pt;margin-top:18.75pt;width:0;
   height:0;z-index:10;visibility:visible;mso-wrap-style:tight' o:button="t"
   fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font23">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1042" type="#_x0000_t202" href="#RANGE!A1"
   style='position:absolute;margin-left:2.25pt;margin-top:18.75pt;width:0;
   height:0;z-index:13;visibility:visible;mso-wrap-style:tight' o:button="t"
   fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font23">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1045" type="#_x0000_t202" href="#RANGE!A1"
   style='position:absolute;margin-left:2.25pt;margin-top:18.75pt;width:0;
   height:0;z-index:16;visibility:visible;mso-wrap-style:tight' o:button="t"
   fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font23">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1048" type="#_x0000_t202" href="#RANGE!A1"
   style='position:absolute;margin-left:2.25pt;margin-top:18.75pt;width:0;
   height:0;z-index:19;visibility:visible;mso-wrap-style:tight' o:button="t"
   fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font23">TRỞ LẠI</font></div>
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
    src="Vietinbank_Lenhchi_files/image001.gif" usemap="#MicrosoftOfficeMap0"
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
  <td height=21 colspan=17 class=xl33 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=30 class=xl33 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=30 class=xl33 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=89 style='width:67pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=12 style='width:9pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=22 style='width:17pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=11 style='width:8pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=5 style='width:4pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=3 style='width:2pt'></td>
  <td width=3 style='width:2pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
