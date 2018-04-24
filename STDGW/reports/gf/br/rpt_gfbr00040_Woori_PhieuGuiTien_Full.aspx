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
		
	p_D_Acc_No = p_D_Acc_No.Replace(".","");
	p_D_Acc_No = p_D_Acc_No.Replace("-","");
    }

    string _str = "";
    char[] _ch = p_C_Acc_No.ToCharArray();
    for (int _j = 0; _j < _ch.Length; _j++)
    {
        _str += _ch[_j] + "<font class=font18><span style='mso-spacerun:yes'>     </span></font>";
    }
    string _str_Dr = "";
    char[] _ch_Dr = p_D_Acc_No.ToCharArray();
    for (int _k = 0; _k < _ch_Dr.Length; _k++)
    {
        _str_Dr += _ch_Dr[_k] ;
    }
    //Response.Write(_str_Dr[0]);
    //Response.End();
    string p_Amt = "";
    string p_Ccy = "";
    string Inword = "";
    string _str_Amt = "";
    string p_Amt1 = "";
    DataTable dt_Amount = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030_1", p_Seq);
    if (dt_Amount.Rows.Count > 0)
    {
        p_Amt = dt_Amount.Rows[0][11].ToString();
        p_Ccy = dt_Amount.Rows[0][3].ToString();
        p_Amt1 = dt_Amount.Rows[0][14].ToString();

        string _ch_Amt = p_Amt.ToString();

        int p = _ch_Amt.Length % 3;
        
        if (p > 0)
        {
            _str_Amt = _ch_Amt.Substring(0, p) + "     ";
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
        //Response.Write(p_Amt);
        //Response.End();
        //p_Ccy = "EUR";
        //p_Amt1 = "1600.00";
        //p_D_Acc_No = "3456789012";
    }
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Phieu%20gui%20tien%20-%20Wooribank_files/filelist.xml">
<link rel=Edit-Time-Data
href="Phieu%20gui%20tien%20-%20Wooribank_files/editdata.mso">
<link rel=OLE-Object-Data
href="Phieu%20gui%20tien%20-%20Wooribank_files/oledata.mso">
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
  <o:LastPrinted>2012-01-06T08:29:21Z</o:LastPrinted>
  <o:Created>2012-01-03T03:53:38Z</o:Created>
  <o:LastSaved>2012-01-06T08:31:02Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .5in .5in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.5in;}
.font9
	{color:red;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font10
	{color:red;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font11
	{color:red;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font14
	{color:red;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;}
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
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl26
	{mso-style-parent:style0;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid red;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	color:red;
	font-size:7.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;
	text-align:left;}
.xl31
	{mso-style-parent:style0;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid red;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid red;
	border-right:.5pt solid red;
	border-bottom:none;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid red;}
.xl36
	{mso-style-parent:style0;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid red;
	border-bottom:none;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid red;
	border-left:.5pt solid red;}
.xl38
	{mso-style-parent:style0;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid red;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid red;
	border-bottom:.5pt solid red;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	color:red;
	font-size:25.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	color:red;
	font-size:15.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;
	vertical-align:top;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	color:red;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;
	text-align:left;}
.xl44
	{mso-style-parent:style0;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	color:red;
	text-align:left;}
.xl46
	{mso-style-parent:style0;
	color:red;
	font-size:25.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid red;
	border-bottom:none;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl49
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid red;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid red;}
.xl50
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
.xl52
	{mso-style-parent:style0;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid red;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid red;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	color:red;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl55
	{mso-style-parent:style0;
	color:red;
	font-size:18.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;
	text-align:left;
	vertical-align:middle;}
.xl56
	{mso-style-parent:style0;
	color:red;
	font-size:18.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
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
      <x:Scale>75</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>200</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
       <x:ActiveCol>11</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>6465</x:WindowHeight>
  <x:WindowWidth>12435</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=844 style='border-collapse:
 collapse;table-layout:fixed;width:636pt'>
 <col class=xl24 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl24 width=23 style='mso-width-source:userset;mso-width-alt:841;
 width:17pt'>
 <col class=xl24 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=64 style='mso-width-source:userset;mso-width-alt:2340;
 width:48pt'>
 <col class=xl24 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=58 style='mso-width-source:userset;mso-width-alt:2121;
 width:44pt'>
 <col class=xl24 width=16 style='mso-width-source:userset;mso-width-alt:585;
 width:12pt'>
 <col class=xl24 width=57 style='mso-width-source:userset;mso-width-alt:2084;
 width:43pt'>
 <col class=xl24 width=97 span=3 style='mso-width-source:userset;mso-width-alt:
 3547;width:73pt'>
 <col class=xl24 width=30 style='mso-width-source:userset;mso-width-alt:1097;
 width:23pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 width=79 style='height:12.75pt;width:59pt'></td>
  <td class=xl24 width=23 style='width:17pt'></td>
  <td class=xl24 width=54 style='width:41pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=54 style='width:41pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=54 style='width:41pt'></td>
  <td class=xl24 width=58 style='width:44pt'></td>
  <td class=xl24 width=16 style='width:12pt'></td>
  <td class=xl24 width=57 style='width:43pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=30 style='width:23pt'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=10 height=40 class=xl40 style='border-right:.5pt solid red;
  height:30.0pt'>DEPOSIT</td>
  <td class=xl52 width=97 style='border-left:none;width:73pt'>Prepared<br><font class="font9">Người
  lập</font></td>
  <td class=xl52 width=97 style='border-left:none;width:73pt'>Entered<br><font class="font9">Người vào máy</font></td>
  <td class=xl52 width=97 style='border-left:none;width:73pt'>Approved<br><font class="font9">Người
  kiểm tra</font></td>
  <td class=xl24></td>
 </tr>
 <tr height=52 style='mso-height-source:userset;height:39.0pt'>
  <td colspan=10 height=52 class=xl40 style='border-right:.5pt solid red;
  height:39.0pt'>PHIẾU GỬI TIỀN</td>
  <td class=xl53 width=97 style='border-top:none;border-left:none;width:73pt'>&nbsp;</td>
  <td class=xl52 width=97 style='border-top:none;border-left:none;width:73pt'>&nbsp;</td>
  <td class=xl52 width=97 style='border-top:none;border-left:none;width:73pt'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=10 height=26 class=xl40 style='height:19.5pt'></td>
  <td class=xl26 width=97 style='border-top:none;width:73pt'>&nbsp;</td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl47 colspan=2 style='height:14.25pt;mso-ignore:colspan'>Account
  No.</td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1025"
   style='position:absolute;margin-left:6.75pt;margin-top:.75pt;width:20.25pt;
   height:26.25pt;z-index:1;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="red [10]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_D_Acc_No.Length >=12){%><%=p_D_Acc_No[p_D_Acc_No.Length - 12]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1026" style='position:absolute;margin-left:47.25pt;
   margin-top:.75pt;width:19.5pt;height:26.25pt;z-index:2;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_D_Acc_No.Length >=10){%><%=p_D_Acc_No[p_D_Acc_No.Length - 10]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1027" style='position:absolute;margin-left:87pt;
   margin-top:.75pt;width:20.25pt;height:26.25pt;z-index:3;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_D_Acc_No.Length >=8){%><%=p_D_Acc_No[p_D_Acc_No.Length - 8]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1028" style='position:absolute;margin-left:147.75pt;
   margin-top:.75pt;width:20.25pt;height:26.25pt;z-index:4;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_D_Acc_No.Length >=5){%><%=p_D_Acc_No[p_D_Acc_No.Length - 5]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1029" style='position:absolute;margin-left:127.5pt;
   margin-top:.75pt;width:20.25pt;height:26.25pt;z-index:5;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_D_Acc_No.Length >=6){%><%=p_D_Acc_No[p_D_Acc_No.Length - 6]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1030" style='position:absolute;margin-left:208.5pt;
   margin-top:.75pt;width:20.25pt;height:26.25pt;z-index:6;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_D_Acc_No.Length >=2){%><%=p_D_Acc_No[p_D_Acc_No.Length - 2]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1031" style='position:absolute;margin-left:228.75pt;
   margin-top:.75pt;width:20.25pt;height:26.25pt;z-index:7;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_D_Acc_No.Length >=1){%><%=p_D_Acc_No[p_D_Acc_No.Length - 1]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1032" style='position:absolute;margin-left:188.25pt;
   margin-top:.75pt;width:20.25pt;height:26.25pt;z-index:8;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_D_Acc_No.Length >=3){%><%=p_D_Acc_No[p_D_Acc_No.Length - 3]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1033" style='position:absolute;margin-left:27pt;
   margin-top:.75pt;width:20.25pt;height:26.25pt;z-index:9;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_D_Acc_No.Length >=11){%><%=p_D_Acc_No[p_D_Acc_No.Length - 11]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1034" style='position:absolute;margin-left:66.75pt;
   margin-top:.75pt;width:20.25pt;height:26.25pt;z-index:10;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_D_Acc_No.Length >=9){%><%=p_D_Acc_No[p_D_Acc_No.Length - 9]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1035" style='position:absolute;margin-left:168pt;
   margin-top:.75pt;width:20.25pt;height:26.25pt;z-index:11;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_D_Acc_No.Length >=4){%><%=p_D_Acc_No[p_D_Acc_No.Length - 4]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1036" style='position:absolute;margin-left:107.25pt;
   margin-top:.75pt;width:20.25pt;height:26.25pt;z-index:12;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_D_Acc_No.Length >=7){%><%=p_D_Acc_No[p_D_Acc_No.Length - 7]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:1;margin-left:8px;margin-top:0px;width:325px;height:37px'><img
  width=325 height=37
  src="Phieu%20gui%20tien%20-%20Wooribank_files/image001.gif" v:shapes="_x0000_s1025 _x0000_s1026 _x0000_s1027 _x0000_s1028 _x0000_s1029 _x0000_s1030 _x0000_s1031 _x0000_s1032 _x0000_s1033 _x0000_s1034 _x0000_s1035 _x0000_s1036"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=19 class=xl24 width=54 style='height:14.25pt;width:41pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=11 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl48 colspan=2 style='height:12.75pt;mso-ignore:colspan'>Số
  tài khoản</td>
  <td colspan=9 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl25 style='height:20.1pt'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl28 x:str="            "><span
  style='mso-spacerun:yes'>            </span></td>
  <td class=xl24></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl27></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl47 style='height:15.0pt'>Currency.</td>
  <td class=xl24></td>
  <td rowspan=2 class=xl55><%if (p_Ccy == "USD")
                             { %>þ<%}
                             else
                             { %>¨<%} %></td>
  <td rowspan=2 class=xl41>USD</td>
  <td rowspan=2 class=xl55><%if (p_Ccy == "VND")
                             { %>þ<%}
                             else
                             { %>¨<%} %></td>
  <td rowspan=2 class=xl41>VND</td>
  <td rowspan=2 class=xl55><%if (p_Ccy != "USD" && p_Ccy != "VND")
                             { %>þ<%}
                             else
                             { %>¨<%} %></td>
  <td colspan=2 rowspan=2 class=xl44>Other (khác)</td>
  <td class=xl41></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl48 style='height:14.25pt'>Loại tiền</td>
  <td class=xl24></td>
  <td class=xl41></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl47 style='height:20.1pt'></td>
  <td class=xl24></td>
  <td align=left valign=top><!--[if gte vml 1]>
  <%if(p_Ccy=="VND"){ %>
  <v:rect id="_x0000_s1037"
   style='position:absolute;margin-left:6.75pt;margin-top:19.5pt;width:20.25pt;
   height:26.25pt;z-index:13;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="red [10]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=12){%><%=p_Amt1[p_Amt1.Length - 12]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1039" style='position:absolute;margin-left:27pt;
   margin-top:19.5pt;width:20.25pt;height:26.25pt;z-index:15;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" strokeweight="1pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=11){%><%=p_Amt1[p_Amt1.Length - 11]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1040" style='position:absolute;margin-left:47.25pt;
   margin-top:19.5pt;width:19.5pt;height:26.25pt;z-index:16;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" strokeweight="1pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=10){%><%=p_Amt1[p_Amt1.Length - 10]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:line id="_x0000_s1075" style='position:absolute;z-index:29'
   from="18.75pt,19.5pt" to="66.75pt,19.5pt" strokecolor="red [10]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1076" style='position:absolute;
   z-index:30' from="18.75pt,45.75pt" to="66.75pt,45.75pt" strokecolor="red [10]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1078" style='position:absolute;
   flip:y;z-index:31' from="66.75pt,19.5pt" to="66.75pt,45.75pt" strokecolor="red [10]"
   strokeweight="1pt" o:insetmode="auto"/><v:rect id="_x0000_s1038" style='position:absolute;
   margin-left:69.75pt;margin-top:19.5pt;width:20.25pt;height:26.25pt;
   z-index:14;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="red [10]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=9){%><%=p_Amt1[p_Amt1.Length - 9]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1042" style='position:absolute;margin-left:90pt;
   margin-top:19.5pt;width:20.25pt;height:26.25pt;z-index:18;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" strokeweight="1pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=8){%><%=p_Amt1[p_Amt1.Length - 8]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1043" style='position:absolute;margin-left:110.25pt;
   margin-top:19.5pt;width:20.25pt;height:26.25pt;z-index:19;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" strokeweight="1pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=7){%><%=p_Amt1[p_Amt1.Length - 7]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:line id="_x0000_s1079" style='position:absolute;flip:y;z-index:32'
   from="130.5pt,19.5pt" to="130.5pt,45.75pt" strokecolor="red [10]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1080" style='position:absolute;
   z-index:33' from="71.25pt,19.5pt" to="131.25pt,19.5pt" strokecolor="red [10]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1085" style='position:absolute;
   z-index:38' from="70.5pt,45.75pt" to="130.5pt,45.75pt" strokecolor="red [10]"
   strokeweight="1pt" o:insetmode="auto"/><v:rect id="_x0000_s1041" style='position:absolute;
   margin-left:133.5pt;margin-top:19.5pt;width:20.25pt;height:26.25pt;
   z-index:17;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="red [10]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=6){%><%=p_Amt1[p_Amt1.Length - 6]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1044" style='position:absolute;margin-left:153.75pt;
   margin-top:19.5pt;width:20.25pt;height:26.25pt;z-index:20;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" strokeweight="1pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=5){%><%=p_Amt1[p_Amt1.Length - 5]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1048" style='position:absolute;margin-left:174pt;
   margin-top:19.5pt;width:20.25pt;height:26.25pt;z-index:24;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" strokeweight="1pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=4){%><%=p_Amt1[p_Amt1.Length - 4]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:line id="_x0000_s1081" style='position:absolute;z-index:34'
   from="146.25pt,19.5pt" to="195pt,19.5pt" strokecolor="red [10]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1083" style='position:absolute;
   flip:y;z-index:36' from="194.25pt,19.5pt" to="194.25pt,45.75pt"
   strokecolor="red [10]" strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1086"
   style='position:absolute;z-index:39' from="138pt,45.75pt" to="193.5pt,45.75pt"
   strokecolor="red [10]" strokeweight="1pt" o:insetmode="auto"/><v:rect id="_x0000_s1045"
   style='position:absolute;margin-left:217.5pt;margin-top:19.5pt;width:20.25pt;
   height:26.25pt;z-index:21;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="red [10]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=2){%><%=p_Amt1[p_Amt1.Length - 2]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1047" style='position:absolute;margin-left:197.25pt;
   margin-top:19.5pt;width:20.25pt;height:26.25pt;z-index:23;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=3){%><%=p_Amt1[p_Amt1.Length - 3]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1051" style='position:absolute;margin-left:237.75pt;
   margin-top:19.5pt;width:20.25pt;height:26.25pt;z-index:25;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" strokeweight="1pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=1){%><%=p_Amt1[p_Amt1.Length - 1]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect>
  <%}else { %>
  <v:rect id="_x0000_s1037"
   style='position:absolute;margin-left:6.75pt;margin-top:19.5pt;width:20.25pt;
   height:26.25pt;z-index:13;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="red [10]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=15){%><%=p_Amt1[p_Amt1.Length - 15]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1039" style='position:absolute;margin-left:27pt;
   margin-top:19.5pt;width:20.25pt;height:26.25pt;z-index:15;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" strokeweight="1pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=14){%><%=p_Amt1[p_Amt1.Length - 14]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1040" style='position:absolute;margin-left:47.25pt;
   margin-top:19.5pt;width:19.5pt;height:26.25pt;z-index:16;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" strokeweight="1pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=13){%><%=p_Amt1[p_Amt1.Length - 13]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:line id="_x0000_s1075" style='position:absolute;z-index:29'
   from="18.75pt,19.5pt" to="66.75pt,19.5pt" strokecolor="red [10]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1076" style='position:absolute;
   z-index:30' from="18.75pt,45.75pt" to="66.75pt,45.75pt" strokecolor="red [10]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1078" style='position:absolute;
   flip:y;z-index:31' from="66.75pt,19.5pt" to="66.75pt,45.75pt" strokecolor="red [10]"
   strokeweight="1pt" o:insetmode="auto"/><v:rect id="_x0000_s1038" style='position:absolute;
   margin-left:69.75pt;margin-top:19.5pt;width:20.25pt;height:26.25pt;
   z-index:14;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="red [10]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=12){%><%=p_Amt1[p_Amt1.Length - 12]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1042" style='position:absolute;margin-left:90pt;
   margin-top:19.5pt;width:20.25pt;height:26.25pt;z-index:18;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" strokeweight="1pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=11){%><%=p_Amt1[p_Amt1.Length - 11]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1043" style='position:absolute;margin-left:110.25pt;
   margin-top:19.5pt;width:20.25pt;height:26.25pt;z-index:19;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" strokeweight="1pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=10){%><%=p_Amt1[p_Amt1.Length - 10]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:line id="_x0000_s1079" style='position:absolute;flip:y;z-index:32'
   from="130.5pt,19.5pt" to="130.5pt,45.75pt" strokecolor="red [10]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1080" style='position:absolute;
   z-index:33' from="71.25pt,19.5pt" to="131.25pt,19.5pt" strokecolor="red [10]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1085" style='position:absolute;
   z-index:38' from="70.5pt,45.75pt" to="130.5pt,45.75pt" strokecolor="red [10]"
   strokeweight="1pt" o:insetmode="auto"/><v:rect id="_x0000_s1041" style='position:absolute;
   margin-left:133.5pt;margin-top:19.5pt;width:20.25pt;height:26.25pt;
   z-index:17;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="red [10]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=9){%><%=p_Amt1[p_Amt1.Length - 9]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1044" style='position:absolute;margin-left:153.75pt;
   margin-top:19.5pt;width:20.25pt;height:26.25pt;z-index:20;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" strokeweight="1pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=8){%><%=p_Amt1[p_Amt1.Length - 8]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1048" style='position:absolute;margin-left:174pt;
   margin-top:19.5pt;width:20.25pt;height:26.25pt;z-index:24;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" strokeweight="1pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=7){%><%=p_Amt1[p_Amt1.Length - 7]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:line id="_x0000_s1081" style='position:absolute;z-index:34'
   from="146.25pt,19.5pt" to="195pt,19.5pt" strokecolor="red [10]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1083" style='position:absolute;
   flip:y;z-index:36' from="194.25pt,19.5pt" to="194.25pt,45.75pt"
   strokecolor="red [10]" strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1086"
   style='position:absolute;z-index:39' from="138pt,45.75pt" to="193.5pt,45.75pt"
   strokecolor="red [10]" strokeweight="1pt" o:insetmode="auto"/><v:rect id="_x0000_s1045"
   style='position:absolute;margin-left:217.5pt;margin-top:19.5pt;width:20.25pt;
   height:26.25pt;z-index:21;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="red [10]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=5){%><%=p_Amt1[p_Amt1.Length - 5]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1047" style='position:absolute;margin-left:197.25pt;
   margin-top:19.5pt;width:20.25pt;height:26.25pt;z-index:23;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=6){%><%=p_Amt1[p_Amt1.Length - 6]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1051" style='position:absolute;margin-left:237.75pt;
   margin-top:19.5pt;width:20.25pt;height:26.25pt;z-index:25;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" strokeweight="1pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=4){%><%=p_Amt1[p_Amt1.Length - 4]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect>
  <%} %>
  <v:line id="_x0000_s1082" style='position:absolute;z-index:35'
   from="215.25pt,19.5pt" to="258.75pt,19.5pt" strokecolor="red [10]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1084" style='position:absolute;
   flip:y;z-index:37' from="258pt,19.5pt" to="258pt,45.75pt" strokecolor="red [10]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1087" style='position:absolute;
   z-index:40' from="3in,45.75pt" to="258pt,45.75pt" strokecolor="red [10]"
   strokeweight="1pt" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:13;margin-left:8px;
  margin-top:25px;width:338px;height:37px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=82></td>
    <td width=2></td>
    <td width=84></td>
    <td width=1></td>
    <td width=84></td>
    <td width=1></td>
    <td width=84></td>
   </tr>
   <tr>
    <td height=37></td>
    <td align=left valign=top><img width=82 height=37
    src="Phieu%20gui%20tien%20-%20Wooribank_files/image002.gif" v:shapes="_x0000_s1037 _x0000_s1039 _x0000_s1040 _x0000_s1075 _x0000_s1076 _x0000_s1078"></td>
    <td></td>
    <td align=left valign=top><img width=84 height=37
    src="Phieu%20gui%20tien%20-%20Wooribank_files/image003.gif" v:shapes="_x0000_s1038 _x0000_s1042 _x0000_s1043 _x0000_s1079 _x0000_s1080 _x0000_s1085"></td>
    <td></td>
    <td align=left valign=top><img width=84 height=37
    src="Phieu%20gui%20tien%20-%20Wooribank_files/image004.gif" v:shapes="_x0000_s1041 _x0000_s1044 _x0000_s1048 _x0000_s1081 _x0000_s1083 _x0000_s1086"></td>
    <td></td>
    <td align=left valign=top><img width=84 height=37
    src="Phieu%20gui%20tien%20-%20Wooribank_files/image005.gif" v:shapes="_x0000_s1045 _x0000_s1047 _x0000_s1051 _x0000_s1082 _x0000_s1084 _x0000_s1087"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl24 width=54 style='height:20.1pt;width:41pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td align=left valign=top><!--[if gte vml 1]>
  <%if(p_Ccy=="VND"){ %>
 <v:rect id="_x0000_s1046"
   style='position:absolute;margin-left:10.5pt;margin-top:19.5pt;width:20.25pt;
   height:26.25pt;z-index:22;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="red [10]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11">0</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1052" style='position:absolute;margin-left:30.75pt;
   margin-top:19.5pt;width:20.25pt;height:26.25pt;z-index:26;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11">0</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect>
  <%}else{%>
   <v:rect id="_x0000_s1046"
   style='position:absolute;margin-left:10.5pt;margin-top:19.5pt;width:20.25pt;
   height:26.25pt;z-index:22;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="red [10]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=2){%><%=p_Amt1[p_Amt1.Length - 2]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1052" style='position:absolute;margin-left:30.75pt;
   margin-top:19.5pt;width:20.25pt;height:26.25pt;z-index:26;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="red [10]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.875pt'><font class="font11"><%if(p_Amt1.Length >=1){%><%=p_Amt1[p_Amt1.Length - 1]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect>
  <%} %>
  <![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:22;margin-left:13px;margin-top:25px;width:56px;height:37px'><img
  width=56 height=37 src="Phieu%20gui%20tien%20-%20Wooribank_files/image006.gif"
  v:shapes="_x0000_s1046 _x0000_s1052"></span><![endif]><span style='mso-ignore:
  vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl29 width=16 style='height:20.1pt;width:12pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl29></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl47 style='height:14.25pt'>Amount</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl48 style='height:14.25pt'>Số lượng</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td class=xl43></td>
  <td class=xl45><span style='mso-spacerun:yes'> </span><font class="font14"></font></td>
  <td class=xl45></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=7 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.95pt'>
  <td height=37 colspan=2 class=xl25 style='height:27.95pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl50>Date <font class="font10">(ngày) :<span
  style='mso-spacerun:yes'>       </span>/<span
  style='mso-spacerun:yes'>        </span>/</font></td>
  <td class=xl24></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.95pt'>
  <td height=37 colspan=4 class=xl32 style='height:27.95pt;mso-ignore:colspan'></td>
  <td class=xl42></td>
  <td class=xl32></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1071"
   style='position:absolute;z-index:27' from=".75pt,15pt" to="218.25pt,15pt"
   strokecolor="red [10]" o:insetmode="auto">
   <x:ClientData ObjectType="Line">
    <x:Anchor>
     10, 1, 17, 0, 12, 121, 17, 0</x:Anchor>
   </x:ClientData>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:27;margin-left:0px;margin-top:19px;width:292px;height:2px'><img
  width=292 height=2 src="Phieu%20gui%20tien%20-%20Wooribank_files/image007.gif"
  v:shapes="_x0000_s1071"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl47 width=97 style='height:15.0pt;width:73pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.95pt'>
  <td height=37 colspan=2 class=xl25 style='height:27.95pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl51>Signature<font class="font10"> (Chữ ký)</font></td>
  <td class=xl24></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=14 class=xl24 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl49 colspan=7 style='height:14.25pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>  </span>For Bank Use Only / Phần dành riêng cho
  Ngân Hàng</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 style='height:12.75pt'>&nbsp;</td>
  <td colspan=11 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 style='height:12.75pt'>&nbsp;</td>
  <td colspan=11 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 style='height:12.75pt'>&nbsp;</td>
  <td colspan=11 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 style='height:12.75pt'>&nbsp;</td>
  <td colspan=11 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 style='height:12.75pt'>&nbsp;</td>
  <td colspan=11 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 style='height:12.75pt'>&nbsp;</td>
  <td colspan=11 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl37 style='height:12.75pt'>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=14 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 rowspan=3 height=51 class=xl24 width=291 style='mso-ignore:
  colspan-rowspan;height:38.25pt;width:219pt'><!--[if gte vml 1]><v:shapetype
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
  </v:shapetype><v:shape id="_x0000_s1074" type="#_x0000_t75" style='position:absolute;
   margin-left:63.75pt;margin-top:3.75pt;width:141pt;height:34.5pt;z-index:28'>
   <v:imagedata src="Phieu%20gui%20tien%20-%20Wooribank_files/image008.emz"
    o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Pict</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=85 height=5></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=188 height=46
    src="Phieu%20gui%20tien%20-%20Wooribank_files/image009.gif" v:shapes="_x0000_s1074"></td>
    <td width=18></td>
   </tr>
   <tr>
    <td height=0></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:218.25pt;height:38.25pt'></span><![endif]--></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl54 style='height:12.75pt'>DEP.0001</td>
  <td colspan=9 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=79 style='width:59pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=16 style='width:12pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=30 style='width:23pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
