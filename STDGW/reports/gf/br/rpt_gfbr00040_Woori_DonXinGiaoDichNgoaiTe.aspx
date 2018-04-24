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
    string p_TaxCode = "";
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
        p_TaxCode = dt.Rows[0][28].ToString();
    }

    
    string p_Amt = "";
    string p_Ccy = "";
    string Inword = "";
    string p_Amt1 = "";
    DataTable dt_Amount = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030_1", p_Seq);
    if (dt_Amount.Rows.Count > 0)
    {
        p_Amt = dt_Amount.Rows[0][12].ToString();
        p_Ccy = dt_Amount.Rows[0][3].ToString();
        p_Amt1 = dt_Amount.Rows[0][13].ToString();

        
        
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
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="WB_AFE_files/filelist.xml">
<link rel=Edit-Time-Data href="WB_AFE_files/editdata.mso">
<link rel=OLE-Object-Data href="WB_AFE_files/oledata.mso">
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
  <o:LastPrinted>2012-01-30T07:57:30Z</o:LastPrinted>
  <o:Created>2012-01-30T02:07:45Z</o:Created>
  <o:LastSaved>2012-01-30T08:25:21Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:0in .35in .51in .28in;
	mso-header-margin:0in;
	mso-footer-margin:.5in;}
.font8
	{color:green;
	font-size:22.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font9
	{color:green;
	font-size:22.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font10
	{color:green;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font11
	{color:green;
	font-size:9.0pt;
	font-weight:400;
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
	color:green;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	color:green;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	color:green;
	font-size:11.0pt;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	color:green;
	font-size:18.0pt;
	font-weight:700;
	text-align:center;}
.xl28
	{mso-style-parent:style0;
	color:green;
	font-size:18.0pt;
	font-weight:700;
	text-align:center;
	border-top:none;
	border-right:.5pt solid #339966;
	border-bottom:none;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	color:green;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid #339966;
	border-right:.5pt solid #339966;
	border-bottom:none;
	border-left:.5pt solid #339966;}
.xl30
	{mso-style-parent:style0;
	color:green;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid #339966;
	border-bottom:.5pt solid #339966;
	border-left:.5pt solid #339966;}
.xl31
	{mso-style-parent:style0;
	color:green;
	font-size:16.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	color:green;
	font-size:16.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid green;
	border-bottom:none;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	color:green;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid #339966;
	border-right:.5pt solid green;
	border-bottom:none;
	border-left:.5pt solid green;}
.xl34
	{mso-style-parent:style0;
	color:green;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid green;
	border-bottom:.5pt solid green;
	border-left:.5pt solid green;}
.xl35
	{mso-style-parent:style0;
	color:green;
	font-size:22.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	color:green;
	font-size:22.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid green;
	border-bottom:none;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	color:green;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	color:green;
	text-align:left;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	color:green;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	color:green;
	text-align:left;
	vertical-align:top;}
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
      <x:Scale>76</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>12</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
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
 <o:shapedefaults v:ext="edit" spidmax="1039"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=913 style='border-collapse:
 collapse;table-layout:fixed;width:686pt'>
 <col class=xl24 width=64 span=10 style='width:48pt'>
 <col class=xl24 width=89 span=3 style='mso-width-source:userset;mso-width-alt:
 3254;width:67pt'>
 <col class=xl24 width=6 style='mso-width-source:userset;mso-width-alt:219;
 width:5pt'>
 <tr height=17 style='height:12.75pt'>
  <td colspan=10 rowspan=2 height=36 class=xl27 width=640 style='border-right:
  .5pt solid #339966;height:27.0pt;width:480pt'>APPLICATION FOR FOREIGN
  EXCHANGE<br>
    <br>
    </td>
  <td rowspan=2 class=xl29 width=89 style='border-bottom:.5pt solid #339966;
  width:67pt'>Prepared</td>
  <td rowspan=2 class=xl29 width=89 style='border-bottom:.5pt solid #339966;
  width:67pt'>Entered</td>
  <td rowspan=2 class=xl29 width=89 style='border-bottom:.5pt solid #339966;
  width:67pt'>Approved</td>
  <td class=xl24 width=6 style='width:5pt'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl24 style='height:14.25pt'></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=10 height=32 class=xl31 style='border-right:.5pt solid green;
  height:24.0pt'>ĐƠN XIN GIAO DỊCH NGOẠI TỆ</td>
  <td rowspan=2 class=xl33 style='border-bottom:.5pt solid green;border-top:
  none'>&nbsp;</td>
  <td rowspan=2 class=xl33 style='border-bottom:.5pt solid green;border-top:
  none'>&nbsp;</td>
  <td rowspan=2 class=xl33 style='border-bottom:.5pt solid green;border-top:
  none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td colspan=10 height=39 class=xl35 style='border-right:.5pt solid green;
  height:29.25pt'>(<font class="font9"> 환전 신청서 </font><font class="font8">)</font></td>
  <td class=xl24></td>
 </tr>
 <tr height=41 style='mso-height-source:userset;height:30.75pt'>
  <td colspan=13 height=41 width=907 style='height:30.75pt;width:681pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1031" style='position:absolute;
   z-index:5' from="66pt,15pt" to="678.75pt,15pt" strokecolor="green [17]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:5;margin-left:87px;margin-top:19px;width:819px;
  height:2px'><img width=819 height=2 src="WB_AFE_files/image001.gif" v:shapes="_x0000_s1031"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=13 height=41 class=xl37 width=907 style='height:30.75pt;
    width:681pt'>1. Name / Tên:<span style='mso-spacerun:yes'>  </span><%=p_D_Acc_Nm %><br>
        <span style='mso-spacerun:yes'>   </span>(성명)</td>
   </tr>
  </table>
  </span></td>
  <td class=xl24></td>
 </tr>
 <tr height=57 style='mso-height-source:userset;height:42.75pt'>
  <td colspan=8 height=57 width=512 style='height:42.75pt;width:384pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1032" style='position:absolute;
   z-index:6' from="169.5pt,15pt" to="383.25pt,15pt" strokecolor="green [17]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:6;margin-left:225px;margin-top:19px;width:287px;
  height:2px'><img width=287 height=2 src="WB_AFE_files/image002.gif" v:shapes="_x0000_s1032"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=8 height=57 class=xl38 width=512 style='height:42.75pt;
    width:384pt'>2. Passport No/Business Licence No.:<br>
        <span style='mso-spacerun:yes'>    </span>Số hộ chiếu/Số đăng ký kinh
    doanh<br>
        <span style='mso-spacerun:yes'>    </span>(사업자번호/여권번호)</td>
   </tr>
  </table>
  </span></td>
  <td width=64 style='width:48pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1033" style='position:absolute;z-index:7' from="42pt,15.75pt"
   to="296.25pt,15.75pt" strokecolor="green [17]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:7;margin-left:55px;
  margin-top:20px;width:341px;height:2px'><img width=341 height=2
  src="WB_AFE_files/image003.gif" v:shapes="_x0000_s1033"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=57 class=xl25 align=left width=64 style='height:42.75pt;
    width:48pt'>National<br>
        Quốc tịch<br>
        (국적)</td>
   </tr>
  </table>
  </span></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=43 style='mso-height-source:userset;height:32.25pt'>
  <td colspan=13 height=43 width=907 style='height:32.25pt;width:681pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1034" style='position:absolute;
   z-index:8' from="145.5pt,19.5pt" to="678pt,19.5pt" strokecolor="green [17]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:8;margin-left:193px;margin-top:25px;width:712px;
  height:2px'><img width=712 height=2 src="WB_AFE_files/image004.gif" v:shapes="_x0000_s1034"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=13 height=43 class=xl38 width=907 style='height:32.25pt;
    width:681pt'>3. Address (in Vietnam) / Địa chỉ: <%=p_D_Add %><br>
        <span style='mso-spacerun:yes'>    </span>(주소)</td>
   </tr>
  </table>
  </span></td>
  <td class=xl24></td>
 </tr>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td colspan=8 height=45 width=512 style='height:33.75pt;width:384pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1035" style='position:absolute;
   z-index:9' from="95.25pt,19.5pt" to="384pt,19.5pt" strokecolor="green [17]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:9;margin-left:126px;margin-top:25px;width:387px;
  height:2px'><img width=387 height=2 src="WB_AFE_files/image005.gif" v:shapes="_x0000_s1035"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=8 height=45 class=xl38 width=512 style='height:33.75pt;
    width:384pt'>4. Tel / Số điện thoại: <%=p_Phone %><br>
        <span style='mso-spacerun:yes'>    </span>(전화번호)</td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=9 height=40 width=576 style='height:30.0pt;width:432pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1036" style='position:absolute;
   z-index:10' from="99.75pt,15.75pt" to="382.5pt,15.75pt" strokecolor="green [17]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:10;margin-left:132px;margin-top:20px;width:379px;
  height:2px'><img width=379 height=2 src="WB_AFE_files/image006.gif" v:shapes="_x0000_s1036"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=9 height=40 class=xl38 width=576 style='height:30.0pt;
    width:432pt'>5. Amount / Số lượng: <%=p_Amt1 %><br>
        <span style='mso-spacerun:yes'>    </span>(금액)</td>
   </tr>
  </table>
  </span></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=14 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl24 style='height:26.25pt'></td>
  <td height=35 class=xl24 width=64 style='height:26.25pt;width:48pt'><!--[if gte vml 1]><v:rect
   id="_x0000_s1026" style='position:absolute;direction:LTR;text-align:left;
   margin-left:33pt;margin-top:6.75pt;width:11.25pt;height:11.25pt;z-index:1'
   fillcolor="window [65]" strokecolor="green [17]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=43 height=8></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=17 height=17 src="WB_AFE_files/image007.gif" v:shapes="_x0000_s1026"></td>
    <td width=4></td>
   </tr>
   <tr>
    <td height=10></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:48.0pt;height:26.25pt'></span><![endif]--></td>
  <td colspan=2 class=xl37 width=128 style='width:96pt'>Cash in USD<br>
    Số tiền USD</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl39 width=192 style='width:144pt'>To be exchange
  to<br>
    Đổi sang</td>
  <td class=xl24></td>
  <td height=35 class=xl24 width=89 style='height:26.25pt;width:67pt'><!--[if gte vml 1]><v:rect
   id="_x0000_s1029" style='position:absolute;direction:LTR;text-align:left;
   margin-left:51.75pt;margin-top:6.75pt;width:11.25pt;height:11.25pt;
   z-index:3' fillcolor="window [65]" strokecolor="green [17]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=68 height=8></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=17 height=17 src="WB_AFE_files/image007.gif" v:shapes="_x0000_s1029"></td>
    <td width=4></td>
   </tr>
   <tr>
    <td height=10></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:66.75pt;height:26.25pt'></span><![endif]--></td>
  <td colspan=2 class=xl37 width=178 style='width:134pt'>Cash in USD<br>
    Số tiền USD</td>
  <td class=xl24></td>
 </tr>
 <tr height=57 style='mso-height-source:userset;height:42.75pt'>
  <td height=57 class=xl24 style='height:42.75pt'></td>
  <td height=57 class=xl24 width=64 style='height:42.75pt;width:48pt'><!--[if gte vml 1]><v:rect
   id="_x0000_s1027" style='position:absolute;direction:LTR;text-align:left;
   margin-left:33pt;margin-top:14.25pt;width:11.25pt;height:11.25pt;z-index:2'
   fillcolor="window [65]" strokecolor="green [17]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=43 height=18></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=17 height=17 src="WB_AFE_files/image007.gif" v:shapes="_x0000_s1027"></td>
    <td width=4></td>
   </tr>
   <tr>
    <td height=22></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:48.0pt;height:42.75pt'></span><![endif]--></td>
  <td colspan=2 class=xl37 width=128 style='width:96pt'>Cash in VND<br>
    Số tiền VND</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td height=57 class=xl24 width=89 style='height:42.75pt;width:67pt'><!--[if gte vml 1]><v:rect
   id="_x0000_s1030" style='position:absolute;direction:LTR;text-align:left;
   margin-left:51.75pt;margin-top:14.25pt;width:11.25pt;height:11.25pt;
   z-index:4' fillcolor="window [65]" strokecolor="green [17]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=68 height=18></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=17 height=17 src="WB_AFE_files/image007.gif" v:shapes="_x0000_s1030"></td>
    <td width=4></td>
   </tr>
   <tr>
    <td height=22></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:66.75pt;height:42.75pt'></span><![endif]--></td>
  <td colspan=2 class=xl37 width=178 style='width:134pt'>Cash in VND<br>
    Số tiền VND</td>
  <td class=xl24></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 colspan=10 class=xl24 style='height:28.5pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl37 width=267 style='width:201pt'>Date / Ngày:<span
  style='mso-spacerun:yes'>      </span>/<span style='mso-spacerun:yes'>      
  </span>/ ……<br>
    <span style='mso-spacerun:yes'>     </span>(날짜)</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=14 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td colspan=7 height=35 class=xl37 width=448 style='height:26.25pt;
  width:336pt'>I (We) hereby request you to exchange above mentioned
  currency<br>
    <font class="font10">Tôi (Chúng tôi) yêu cầu Ngân hàng đổi số tiền trên</font></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=5 height=17 class=xl24 width=395 style='mso-ignore:colspan-rowspan;
  height:12.75pt;width:297pt'><!--[if gte vml 1]><v:line id="_x0000_s1037"
   style='position:absolute;z-index:11' from="48pt,7.5pt" to="294.75pt,7.5pt"
   strokecolor="green [17]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=63 height=9></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=331 height=2 src="WB_AFE_files/image008.gif" v:shapes="_x0000_s1037"></td>
    <td width=1></td>
   </tr>
   <tr>
    <td height=6></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:296.25pt;height:12.75pt'></span><![endif]--></td>
  <td class=xl24></td>
 </tr>
 <tr height=71 style='mso-height-source:userset;height:53.25pt'>
  <td colspan=9 height=71 class=xl37 width=576 style='height:53.25pt;
  width:432pt'>I (We) undertake all responsibilities in this transaction,
  certifying that all mentioned above<br>
    items comply with the Foreign Exchange Control Regulations of SBV<br>
    <font class="font10">Chúng tôi chịu trách nhiệm về giao dịch này với điều
  kiện tất cả các điều khoản trên đều<br>
    tuân theo quy định về quản lý ngoại hối của Ngân hàng Nhà nước.</font></td>
  <td colspan=4 height=71 width=331 style='height:53.25pt;width:249pt'
  align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
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
  </v:shapetype><v:shape id="_x0000_s1038" type="#_x0000_t75" style='position:absolute;
   direction:LTR;text-align:left;margin-left:82.5pt;margin-top:41.25pt;width:164.25pt;
   height:40.5pt;z-index:12'>
   <v:imagedata src="WB_AFE_files/image009.jpg" o:title="woori"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:12;margin-left:110px;margin-top:55px;width:219px;
  height:54px'><img width=219 height=54 src="WB_AFE_files/image010.jpg" v:shapes="_x0000_s1038"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=4 height=71 class=xl40 width=331 style='height:53.25pt;
    width:249pt'>Customer's Signature / Chữ ký khách hàng <font class="font11">(성명
    및 서명)</font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=14 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl24 style='height:14.25pt'></td>
  <td class=xl26 colspan=2 align=left style='mso-ignore:colspan'>DEP.0003</td>
  <td colspan=11 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=6 style='width:5pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
