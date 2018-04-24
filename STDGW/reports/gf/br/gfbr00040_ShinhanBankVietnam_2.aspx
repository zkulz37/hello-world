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
    string p_Phone = "";
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
        p_D_Add = dt.Rows[0][25].ToString();
        p_D_Bank = dt.Rows[0][9].ToString();
        p_C_Acc_No = dt.Rows[0][0].ToString();
        p_C_Acc_Nm = dt.Rows[0][19].ToString();
        //p_C_Add = dt.Rows[0][26].ToString();
        p_C_Bank = dt.Rows[0][1].ToString();
        p_Remark = dt.Rows[0][14].ToString();
        p_So = dt.Rows[0][11].ToString();
        p_Phone = dt.Rows[0][23].ToString();
    }

    string _str_Cr = "";
    char[] _ch_Cr = p_C_Acc_No.ToCharArray();
    for (int _k = 0; _k < _ch_Cr.Length; _k++)
    {
        _str_Cr += _ch_Cr[_k] ;
    }
    //Response.Write(_str_Dr[0]);
    //Response.End();
    string p_Amt = "";
    string p_Ccy = "";
    string Inword = "";
    string p_Amt1 = "";
    DataTable dt_Amount = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030_1", p_Seq);
    if (dt_Amount.Rows.Count > 0)
    {
        p_Amt = dt_Amount.Rows[0][13].ToString();
        p_Ccy = dt_Amount.Rows[0][3].ToString();
        p_Amt1 = dt_Amount.Rows[0][14].ToString();

        
        
            Inword = CommondLib.Num2EngText(dt_Amount.Rows[0][9].ToString(), p_Ccy);
        //}
        string SQL3 = " SELECT upper(substr(trim('" + Inword + "'),1,1)) || substr(lower(trim('" + Inword + "')),2, length(trim('" + Inword + "')))  from dual ";
        DataTable dt_t = ESysLib.TableReadOpen(SQL3);

        if (dt_t.Rows.Count > 0)
        {
            Inword = dt_t.Rows[0][0].ToString();
        }
        //Response.Write(p_Amt1);
        //Response.End();
        //p_Ccy = "USD";
        //p_Amt1 = "123456789012.00";
        //p_D_Acc_No = "3456789012";
        //Response.Write(p_Amt1[p_Amt1.Length - 11]);
        //Response.End();
    }
    p_C_Acc_No = p_C_Acc_No.Replace("-","");
    p_C_Acc_No = p_C_Acc_No.Replace(".","");
	p_C_Acc_No = p_C_Acc_No.Replace(" ","");
    p_D_Acc_No = p_D_Acc_No.Replace("-","");
    p_D_Acc_No = p_D_Acc_No.Replace(".","");
	p_D_Acc_No = p_D_Acc_No.Replace(" ","");
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfbr00040_ShinhanBankVietnam_2_files/filelist.xml">
<link rel=Edit-Time-Data
href="gfbr00040_ShinhanBankVietnam_2_files/editdata.mso">
<link rel=OLE-Object-Data
href="gfbr00040_ShinhanBankVietnam_2_files/oledata.mso">
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
  <o:LastPrinted>2012-09-12T06:17:13Z</o:LastPrinted>
  <o:Created>2012-01-18T08:27:42Z</o:Created>
  <o:LastSaved>2012-09-12T06:47:09Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:0in .25in .6in .3in;
	mso-header-margin:0in;
	mso-footer-margin:.61in;}
.font9
	{color:#333399;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font10
	{color:white;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font11
	{color:white;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font12
	{color:#333399;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font14
	{color:#333399;
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
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	color:#333399;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl26
	{mso-style-parent:style0;
	color:#333399;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl27
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	color:white;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	color:white;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	color:white;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	color:white;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl39
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	color:#333399;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl41
	{mso-style-parent:style0;
	color:#333399;
	font-size:22.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	color:#333399;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Scientific;
	text-align:left;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl50
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style0;
	color:white;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
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
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>73</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
       <x:ActiveCol>23</x:ActiveCol>
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
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>135</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1090"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1015 style='border-collapse:
 collapse;table-layout:fixed;width:761pt'>
 <col class=xl24 width=64 span=5 style='width:48pt'>
 <col class=xl24 width=103 span=2 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <col class=xl24 width=19 span=3 style='mso-width-source:userset;mso-width-alt:
 694;width:14pt'>
 <col class=xl24 width=26 style='mso-width-source:userset;mso-width-alt:950;
 width:20pt'>
 <col class=xl24 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl24 width=21 style='mso-width-source:userset;mso-width-alt:768;
 width:16pt'>
 <col class=xl24 width=64 span=2 style='width:48pt'>
 <col class=xl24 width=16 style='mso-width-source:userset;mso-width-alt:585;
 width:12pt'>
 <col class=xl24 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl24 width=16 style='mso-width-source:userset;mso-width-alt:585;
 width:12pt'>
 <col class=xl24 width=12 style='mso-width-source:userset;mso-width-alt:438;
 width:9pt'>
 <col class=xl24 width=3 style='mso-width-source:userset;mso-width-alt:109;
 width:2pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td colspan=11 height=22 class=xl41 width=609 style='height:17.1pt;
  width:456pt'></td>
  <td class=xl25 width=76 style='width:57pt'></td>
  <td colspan=6 class=xl42 width=251 style='width:189pt'></td>
  <td class=xl24 width=12 style='width:9pt'></td>
  <td class=xl24 width=3 style='width:2pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=12 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=12 class=xl24 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=12 class=xl27 style='height:14.25pt;mso-ignore:colspan'></td>
  <td class=xl28 colspan=5 style='mso-ignore:colspan'>Ngày/<font class="font11">Date:</font><font
  class="font9"><%=p_Date %></font><font class="font10">…./…</font><font class="font9"><%=p_Month %></font><font
  class="font10">…./….</font><font class="font9"><%=p_Year %></font><font class="font10">….</font></td>
  <td class=xl28></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=6 height=40 class=xl29 width=423 style='height:30.0pt;width:317pt'>Đơn
  v<span style='mso-spacerun:yes'>   </span>ị/<font class="font11">Name:</font><font
  class="font12"> </font><font class="font9"><%=p_D_Acc_Nm %></font></td>
  <td class=xl29></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=6 height=40 class=xl30 width=311 style='mso-ignore:colspan-rowspan;
  height:30.0pt;width:234pt'><!--[if gte vml 1]><v:rect id="_x0000_s1076"
   style='position:absolute;margin-left:31.5pt;margin-top:6.75pt;width:15.75pt;
   height:17.25pt;z-index:15;mso-wrap-style:tight' fillcolor="window [65]"
   stroked="f" strokecolor="#339 [62]" strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:2.25pt'><font class="font14"><%if(p_D_Acc_No.Length >=12){%><%=p_D_Acc_No[p_D_Acc_No.Length - 12]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1077" style='position:absolute;margin-left:48.75pt;
   margin-top:6.75pt;width:15.75pt;height:17.25pt;z-index:16;mso-wrap-style:tight'
   fillcolor="window [65]" stroked="f" strokecolor="#339 [62]" strokeweight=".5pt"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:2.25pt'><font class="font14"><%if(p_D_Acc_No.Length >=11){%><%=p_D_Acc_No[p_D_Acc_No.Length - 11]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1078" style='position:absolute;margin-left:66pt;
   margin-top:6.75pt;width:15.75pt;height:17.25pt;z-index:17;mso-wrap-style:tight'
   fillcolor="window [65]" stroked="f" strokecolor="#339 [62]" strokeweight=".5pt"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:2.25pt'><font class="font14"><%if(p_D_Acc_No.Length >=10){%><%=p_D_Acc_No[p_D_Acc_No.Length - 10]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1081" style='position:absolute;margin-left:107.25pt;
   margin-top:6.75pt;width:15.75pt;height:17.25pt;z-index:19;mso-wrap-style:tight'
   fillcolor="window [65]" stroked="f" strokecolor="#339 [62]" strokeweight=".5pt"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:2.25pt'><font class="font14"><%if(p_D_Acc_No.Length >=9){%><%=p_D_Acc_No[p_D_Acc_No.Length - 9]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1080" style='position:absolute;margin-left:90pt;
   margin-top:6.75pt;width:15.75pt;height:17.25pt;z-index:18;mso-wrap-style:tight'
   fillcolor="window [65]" stroked="f" strokecolor="#339 [62]" strokeweight=".5pt"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:2.25pt'><font class="font14"><%if(p_D_Acc_No.Length >=8){%><%=p_D_Acc_No[p_D_Acc_No.Length - 8]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1084" style='position:absolute;margin-left:148.5pt;
   margin-top:6.75pt;width:15.75pt;height:17.25pt;z-index:21;mso-wrap-style:tight'
   fillcolor="window [65]" stroked="f" strokecolor="#339 [62]" strokeweight=".5pt"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:2.25pt'><font class="font14"><%if(p_D_Acc_No.Length >=7){%><%=p_D_Acc_No[p_D_Acc_No.Length - 7]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1085" style='position:absolute;margin-left:165.75pt;
   margin-top:6.75pt;width:15.75pt;height:17.25pt;z-index:22;mso-wrap-style:tight'
   fillcolor="window [65]" stroked="f" strokecolor="#339 [62]" strokeweight=".5pt"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:2.25pt'><font class="font14"><%if(p_D_Acc_No.Length >=6){%><%=p_D_Acc_No[p_D_Acc_No.Length - 6]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1082" style='position:absolute;margin-left:124.5pt;
   margin-top:6.75pt;width:15.75pt;height:17.25pt;z-index:20;mso-wrap-style:tight'
   fillcolor="window [65]" stroked="f" strokecolor="#339 [62]" strokeweight=".5pt"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:2.25pt'><font class="font14"><%if(p_D_Acc_No.Length >=5){%><%=p_D_Acc_No[p_D_Acc_No.Length - 5]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1086" style='position:absolute;margin-left:183pt;
   margin-top:6.75pt;width:15.75pt;height:17.25pt;z-index:23;mso-wrap-style:tight'
   fillcolor="window [65]" stroked="f" strokecolor="#339 [62]" strokeweight=".5pt"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:2.25pt'><font class="font14"><%if(p_D_Acc_No.Length >=4){%><%=p_D_Acc_No[p_D_Acc_No.Length - 4]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1088" style='position:absolute;margin-left:217.5pt;
   margin-top:6.75pt;width:15.75pt;height:17.25pt;z-index:25;mso-wrap-style:tight'
   fillcolor="window [65]" stroked="f" strokecolor="#339 [62]" strokeweight=".5pt"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:2.25pt'><font class="font14"><%if(p_D_Acc_No.Length >=3){%><%=p_D_Acc_No[p_D_Acc_No.Length - 3]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1087" style='position:absolute;margin-left:200.25pt;
   margin-top:6.75pt;width:15.75pt;height:17.25pt;z-index:24;mso-wrap-style:tight'
   fillcolor="window [65]" stroked="f" strokecolor="#339 [62]" strokeweight=".5pt"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:2.25pt'><font class="font14"><%if(p_D_Acc_No.Length >=2){%><%=p_D_Acc_No[p_D_Acc_No.Length - 2]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=42 height=9></td>
    <td width=21></td>
    <td width=2></td>
    <td width=21></td>
    <td width=2></td>
    <td width=21></td>
    <td width=11></td>
    <td width=21></td>
    <td width=2></td>
    <td width=21></td>
    <td width=2></td>
    <td width=21></td>
    <td width=11></td>
    <td width=21></td>
    <td width=2></td>
    <td width=21></td>
    <td width=2></td>
    <td width=21></td>
    <td width=2></td>
    <td width=21></td>
    <td width=2></td>
    <td width=21></td>
    <td width=0></td>
   </tr>
   <tr>
    <td height=23></td>
    <td align=left valign=top><img width=21 height=23
    src="gfbr00040_ShinhanBankVietnam_2_files/image001.gif" alt="Text Box: 7"
    v:shapes="_x0000_s1076"></td>
    <td></td>
    <td align=left valign=top><img width=21 height=23
    src="gfbr00040_ShinhanBankVietnam_2_files/image002.gif" alt="Text Box: 0"
    v:shapes="_x0000_s1077"></td>
    <td></td>
    <td align=left valign=top><img width=21 height=23
    src="gfbr00040_ShinhanBankVietnam_2_files/image003.gif" alt="Text Box: 3"
    v:shapes="_x0000_s1078"></td>
    <td></td>
    <td align=left valign=top><img width=21 height=23
    src="gfbr00040_ShinhanBankVietnam_2_files/image002.gif" alt="Text Box: 0"
    v:shapes="_x0000_s1080"></td>
    <td></td>
    <td align=left valign=top><img width=21 height=23
    src="gfbr00040_ShinhanBankVietnam_2_files/image002.gif" alt="Text Box: 0"
    v:shapes="_x0000_s1081"></td>
    <td></td>
    <td align=left valign=top><img width=21 height=23
    src="gfbr00040_ShinhanBankVietnam_2_files/image002.gif" alt="Text Box: 0"
    v:shapes="_x0000_s1082"></td>
    <td></td>
    <td align=left valign=top><img width=21 height=23
    src="gfbr00040_ShinhanBankVietnam_2_files/image003.gif" alt="Text Box: 3"
    v:shapes="_x0000_s1084"></td>
    <td></td>
    <td align=left valign=top><img width=21 height=23
    src="gfbr00040_ShinhanBankVietnam_2_files/image004.gif" alt="Text Box: 6"
    v:shapes="_x0000_s1085"></td>
    <td></td>
    <td align=left valign=top><img width=21 height=23
    src="gfbr00040_ShinhanBankVietnam_2_files/image005.gif" alt="Text Box: 4"
    v:shapes="_x0000_s1086"></td>
    <td></td>
    <td align=left valign=top><img width=21 height=23
    src="gfbr00040_ShinhanBankVietnam_2_files/image001.gif" alt="Text Box: 7"
    v:shapes="_x0000_s1087"></td>
    <td></td>
    <td align=left valign=top><img width=21 height=23
    src="gfbr00040_ShinhanBankVietnam_2_files/image006.gif" alt="Text Box: 9"
    v:shapes="_x0000_s1088"></td>
   </tr>
   <tr>
    <td height=8></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:233.25pt;height:30.0pt'></span><![endif]--></td>
  <td colspan=2 height=40 class=xl27 width=28 style='mso-ignore:colspan-rowspan;
  height:30.0pt;width:21pt'><!--[if gte vml 1]><v:rect id="_x0000_s1089"
   style='position:absolute;margin-left:1.5pt;margin-top:6.75pt;width:15.75pt;
   height:17.25pt;z-index:26;mso-wrap-style:tight' fillcolor="window [65]"
   stroked="f" strokecolor="#339 [62]" strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:2.25pt'><font class="font14"><%if(p_D_Acc_No.Length >=1){%><%=p_D_Acc_No[p_D_Acc_No.Length - 1]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=2 height=9></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=21 height=23
    src="gfbr00040_ShinhanBankVietnam_2_files/image007.gif" alt="Text Box: 2"
    v:shapes="_x0000_s1089"></td>
    <td width=5></td>
   </tr>
   <tr>
    <td height=8></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:21.0pt;height:30.0pt'></span><![endif]--></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl27 style='height:12.95pt'></td>
  <td class=xl31></td>
  <td colspan=5 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl33><%=p_Ccy %></td>
  <td colspan=6 class=xl43><%=p_Amt %></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl34 style='height:15.0pt'>Địa chỉ/<span
  style='mso-spacerun:yes'>    </span><font class="font11">Address:</font><font
  class="font12"> </font><font class="font9"><%=p_D_Add %></font></td>
  <td class=xl34></td>
  <td colspan=11 class=xl44><span style='mso-spacerun:yes'>                  
  </span><%=Inword %></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=7 class=xl27 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=11 class=xl45 width=410 style='width:308pt'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=11 class=xl27 style='height:15.0pt;mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1038"
   style='position:absolute;margin-left:30.75pt;margin-top:11.25pt;width:15.75pt;
   height:17.25pt;z-index:1;mso-wrap-style:tight' filled="f" fillcolor="window [65]"
   stroked="f" strokecolor="#339 [62]" strokeweight="0" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:2.25pt'><font class="font14"><%if(p_C_Acc_No.Length >=12){%><%=p_C_Acc_No[p_C_Acc_No.Length - 12]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1039" style='position:absolute;margin-left:48pt;
   margin-top:11.25pt;width:15.75pt;height:17.25pt;z-index:2;mso-wrap-style:tight'
   fillcolor="window [65]" stroked="f" strokecolor="#339 [62]" strokeweight=".5pt"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:2.25pt'><font class="font14"><%if(p_C_Acc_No.Length >=11){%><%=p_C_Acc_No[p_C_Acc_No.Length - 11]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1040" style='position:absolute;margin-left:65.25pt;
   margin-top:11.25pt;width:15.75pt;height:17.25pt;z-index:3;mso-wrap-style:tight'
   fillcolor="window [65]" stroked="f" strokecolor="#339 [62]" strokeweight=".5pt"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:2.25pt'><font class="font14"><%if(p_C_Acc_No.Length >=10){%><%=p_C_Acc_No[p_C_Acc_No.Length - 10]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1043" style='position:absolute;margin-left:106.5pt;
   margin-top:11.25pt;width:15.75pt;height:17.25pt;z-index:5;mso-wrap-style:tight'
   fillcolor="window [65]" stroked="f" strokecolor="#339 [62]" strokeweight=".5pt"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:2.25pt'><font class="font14"><%if(p_C_Acc_No.Length >=9){%><%=p_C_Acc_No[p_C_Acc_No.Length - 9]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1042" style='position:absolute;margin-left:89.25pt;
   margin-top:11.25pt;width:15.75pt;height:17.25pt;z-index:4;mso-wrap-style:tight'
   fillcolor="window [65]" stroked="f" strokecolor="#339 [62]" strokeweight=".5pt"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:2.25pt'><font class="font14"><%if(p_C_Acc_No.Length >=8){%><%=p_C_Acc_No[p_C_Acc_No.Length - 8]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1046" style='position:absolute;margin-left:147.75pt;
   margin-top:11.25pt;width:15.75pt;height:17.25pt;z-index:7;mso-wrap-style:tight'
   fillcolor="window [65]" stroked="f" strokecolor="#339 [62]" strokeweight=".5pt"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:2.25pt'><font class="font14"><%if(p_C_Acc_No.Length >=6){%><%=p_C_Acc_No[p_C_Acc_No.Length - 6]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1047" style='position:absolute;margin-left:165pt;
   margin-top:11.25pt;width:15.75pt;height:17.25pt;z-index:8;mso-wrap-style:tight'
   fillcolor="window [65]" stroked="f" strokecolor="#339 [62]" strokeweight=".5pt"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:2.25pt'><font class="font14"><%if(p_C_Acc_No.Length >=5){%><%=p_C_Acc_No[p_C_Acc_No.Length - 5]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1044" style='position:absolute;margin-left:123.75pt;
   margin-top:11.25pt;width:15.75pt;height:17.25pt;z-index:6;mso-wrap-style:tight'
   fillcolor="window [65]" stroked="f" strokecolor="#339 [62]" strokeweight=".5pt"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:2.25pt'><font class="font14"><%if(p_C_Acc_No.Length >=7){%><%=p_C_Acc_No[p_C_Acc_No.Length - 7]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:1;margin-left:41px;margin-top:15px;width:200px;height:23px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=21></td>
    <td width=2></td>
    <td width=21></td>
    <td width=2></td>
    <td width=21></td>
    <td width=11></td>
    <td width=21></td>
    <td width=2></td>
    <td width=21></td>
    <td width=2></td>
    <td width=21></td>
    <td width=11></td>
    <td width=21></td>
    <td width=2></td>
    <td width=21></td>
   </tr>
   <tr>
    <td height=23></td>
    <td align=left valign=top><img width=21 height=23
    src="gfbr00040_ShinhanBankVietnam_2_files/image008.gif" alt="Text Box: 2"
    v:shapes="_x0000_s1038"></td>
    <td></td>
    <td align=left valign=top><img width=21 height=23
    src="gfbr00040_ShinhanBankVietnam_2_files/image009.gif" alt="Text Box: 8"
    v:shapes="_x0000_s1039"></td>
    <td></td>
    <td align=left valign=top><img width=21 height=23
    src="gfbr00040_ShinhanBankVietnam_2_files/image010.gif" alt="Text Box: 1"
    v:shapes="_x0000_s1040"></td>
    <td></td>
    <td align=left valign=top><img width=21 height=23
    src="gfbr00040_ShinhanBankVietnam_2_files/image002.gif" alt="Text Box: 0"
    v:shapes="_x0000_s1042"></td>
    <td></td>
    <td align=left valign=top><img width=21 height=23
    src="gfbr00040_ShinhanBankVietnam_2_files/image002.gif" alt="Text Box: 0"
    v:shapes="_x0000_s1043"></td>
    <td></td>
    <td align=left valign=top><img width=21 height=23
    src="gfbr00040_ShinhanBankVietnam_2_files/image010.gif" alt="Text Box: 1"
    v:shapes="_x0000_s1044"></td>
    <td></td>
    <td align=left valign=top><img width=21 height=23
    src="gfbr00040_ShinhanBankVietnam_2_files/image003.gif" alt="Text Box: 3"
    v:shapes="_x0000_s1046"></td>
    <td></td>
    <td align=left valign=top><img width=21 height=23
    src="gfbr00040_ShinhanBankVietnam_2_files/image009.gif" alt="Text Box: 8"
    v:shapes="_x0000_s1047"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl27 width=76 style='height:15.0pt;width:57pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1048"
   style='position:absolute;margin-left:1.5pt;margin-top:11.25pt;width:15.75pt;
   height:17.25pt;z-index:9;mso-wrap-style:tight' fillcolor="window [65]"
   stroked="f" strokecolor="#339 [62]" strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:2.25pt'><font class="font14"><%if(p_C_Acc_No.Length >=4){%><%=p_C_Acc_No[p_C_Acc_No.Length - 4]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1050" style='position:absolute;margin-left:36pt;
   margin-top:11.25pt;width:15.75pt;height:17.25pt;z-index:11;mso-wrap-style:tight'
   fillcolor="window [65]" stroked="f" strokecolor="#339 [62]" strokeweight=".5pt"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:2.25pt'><font class="font14"><%if(p_C_Acc_No.Length >=3){%><%=p_C_Acc_No[p_C_Acc_No.Length - 3]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1049" style='position:absolute;margin-left:18.75pt;
   margin-top:11.25pt;width:15.75pt;height:17.25pt;z-index:10;mso-wrap-style:tight'
   fillcolor="window [65]" stroked="f" strokecolor="#339 [62]" strokeweight=".5pt"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:2.25pt'><font class="font14"><%if(p_C_Acc_No.Length >=2){%><%=p_C_Acc_No[p_C_Acc_No.Length - 2]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:9;margin-left:2px;margin-top:15px;width:67px;height:23px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=21></td>
    <td width=2></td>
    <td width=21></td>
    <td width=2></td>
    <td width=21></td>
   </tr>
   <tr>
    <td height=23></td>
    <td align=left valign=top><img width=21 height=23
    src="gfbr00040_ShinhanBankVietnam_2_files/image004.gif" alt="Text Box: 6"
    v:shapes="_x0000_s1048"></td>
    <td></td>
    <td align=left valign=top><img width=21 height=23
    src="gfbr00040_ShinhanBankVietnam_2_files/image003.gif" alt="Text Box: 3"
    v:shapes="_x0000_s1049"></td>
    <td></td>
    <td align=left valign=top><img width=21 height=23
    src="gfbr00040_ShinhanBankVietnam_2_files/image003.gif" alt="Text Box: 3"
    v:shapes="_x0000_s1050"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl27 width=70 style='height:15.0pt;width:53pt'></td>
   </tr>
  </table>
  </span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1051"
   style='position:absolute;margin-left:.75pt;margin-top:11.25pt;width:15.75pt;
   height:17.25pt;z-index:12;mso-wrap-style:tight' fillcolor="window [65]"
   stroked="f" strokecolor="#339 [62]" strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:2.25pt'><font class="font14"><%if(p_C_Acc_No.Length >=1){%><%=p_C_Acc_No[p_C_Acc_No.Length - 1]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:12;margin-left:1px;margin-top:15px;width:21px;height:23px'><img
  width=21 height=23 src="gfbr00040_ShinhanBankVietnam_2_files/image004.gif"
  alt="Text Box: 6" v:shapes="_x0000_s1051"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl27 width=16 style='height:15.0pt;width:12pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=7 class=xl27 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=11 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=3 style='mso-height-source:userset;height:2.25pt'>
  <td height=3 colspan=7 class=xl27 style='height:2.25pt;mso-ignore:colspan'></td>
  <td colspan=11 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=42 style='mso-height-source:userset;height:32.1pt'>
  <td colspan=4 height=42 class=xl36 width=256 style='height:32.1pt;width:192pt'></td>
  <td colspan=2 class=xl36 width=167 style='width:125pt'></td>
  <td class=xl36></td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl45 width=327 style='width:246pt'><span
  style='mso-spacerun:yes'>                           </span><%=p_Remark %></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 colspan=4 class=xl27 style='height:30.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl37 width=167 style='width:125pt'></td>
  <td class=xl37></td>
  <td colspan=11 rowspan=3 class=xl46 width=410 style='width:308pt'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=7 class=xl27 style='height:20.1pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=53 style='mso-height-source:userset;height:39.75pt'>
  <td height=53 colspan=7 class=xl27 style='height:39.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=7 class=xl27 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=11 class=xl47><span
  style='mso-spacerun:yes'>                             </span><%=p_C_Acc_Nm %></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td height=39 colspan=7 class=xl27 style='height:29.25pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl48 width=83 style='width:62pt'></td>
  <td colspan=2 class=xl48 width=97 style='width:73pt'></td>
  <td class=xl38></td>
  <td class=xl39></td>
  <td colspan=2 class=xl38 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=41 style='mso-height-source:userset;height:30.75pt'>
  <td height=41 colspan=7 class=xl27 style='height:30.75pt;mso-ignore:colspan'></td>
  <td colspan=11 class=xl45 width=410 style='width:308pt'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=14 height=20 class=xl49 style='height:15.0pt'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl50></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:11.1pt'>
  <td height=14 colspan=21 class=xl27 style='height:11.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:11.1pt'>
  <td height=14 colspan=21 class=xl27 style='height:11.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:11.1pt'>
  <td height=14 colspan=21 class=xl27 style='height:11.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=16 class=xl27 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl50></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:11.1pt'>
  <td height=14 colspan=21 class=xl27 style='height:11.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:11.1pt'>
  <td height=14 colspan=21 class=xl27 style='height:11.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:11.1pt'>
  <td height=14 colspan=21 class=xl27 style='height:11.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=16 class=xl27 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl50></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:11.1pt'>
  <td height=14 colspan=21 class=xl27 style='height:11.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:11.1pt'>
  <td height=14 colspan=21 class=xl27 style='height:11.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:11.1pt'>
  <td height=14 colspan=21 class=xl27 style='height:11.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=5 class=xl40 style='height:11.25pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=21 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=21 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=21 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=21 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=21 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=21 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=21 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=21 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=21 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=21 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=21 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=21 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=21 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=21 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=21 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=21 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=21 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=21 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=21 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=21 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=21 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=21 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=18 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 height=17 class=xl24 width=15 style='mso-ignore:colspan-rowspan;
  height:12.75pt;width:11pt'><!--[if gte vml 1]><v:line id="_x0000_s1064"
   style='position:absolute;z-index:13' from="9pt,10.5pt" to="9pt,10.5pt"
   strokecolor="#339 [62]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=11 height=13></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=2 height=2
    src="gfbr00040_ShinhanBankVietnam_2_files/image011.gif" v:shapes="_x0000_s1064"></td>
    <td width=2></td>
   </tr>
   <tr>
    <td height=2></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:11.25pt;height:12.75pt'></span><![endif]--></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=21 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=18 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 height=17 class=xl24 width=15 style='mso-ignore:colspan-rowspan;
  height:12.75pt;width:11pt'><!--[if gte vml 1]><v:line id="_x0000_s1065"
   style='position:absolute;z-index:14' from="9pt,10.5pt" to="9pt,10.5pt"
   strokecolor="#339 [62]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=11 height=13></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=2 height=2
    src="gfbr00040_ShinhanBankVietnam_2_files/image011.gif" v:shapes="_x0000_s1065"></td>
    <td width=2></td>
   </tr>
   <tr>
    <td height=2></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:11.25pt;height:12.75pt'></span><![endif]--></td>
  <td class=xl24></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=16 style='width:12pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=16 style='width:12pt'></td>
  <td width=12 style='width:9pt'></td>
  <td width=3 style='width:2pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
