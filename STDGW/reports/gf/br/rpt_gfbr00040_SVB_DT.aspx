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
        p_Amt = dt_Amount.Rows[0][15].ToString();
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
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="SVB_files/filelist.xml">
<link rel=Edit-Time-Data href="SVB_files/editdata.mso">
<link rel=OLE-Object-Data href="SVB_files/oledata.mso">
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
  <o:LastPrinted>2012-01-30T06:20:28Z</o:LastPrinted>
  <o:Created>2012-01-19T07:28:00Z</o:Created>
  <o:LastSaved>2012-01-30T06:24:49Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:0in .42in .5in .44in;
	mso-header-margin:0in;
	mso-footer-margin:.5in;}
.font7
	{color:white;
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font8
	{color:white;
	font-size:14.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font10
	{color:#99CC00;
	font-size:13.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font11
	{color:#99CC00;
	font-size:13.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font12
	{color:#99CC00;
	font-size:13.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font14
	{color:#99CC00;
	font-size:13.0pt;
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
	color:#99CC00;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	color:#99CC00;
	vertical-align:middle;
	border-top:.5pt solid #99CC00;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid #99CC00;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	color:#99CC00;
	vertical-align:middle;
	border-top:.5pt solid #99CC00;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	color:#99CC00;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid #99CC00;
	border-left:.5pt solid #99CC00;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	color:#99CC00;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid #99CC00;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid #99CC00;
	border-bottom:.5pt solid #99CC00;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	color:#99CC00;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid #99CC00;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	vertical-align:middle;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	vertical-align:middle;
	border-top:.5pt solid #99CC00;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid #99CC00;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid #99CC00;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid #99CC00;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	vertical-align:top;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	vertical-align:top;
	border-top:.5pt solid #99CC00;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	vertical-align:middle;
	border-top:.5pt solid #99CC00;
	border-right:.5pt solid #99CC00;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #99CC00;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #99CC00;
	border-bottom:.5pt solid #99CC00;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid #99CC00;
	border-bottom:.5pt solid #99CC00;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	color:#99CC00;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid #99CC00;}
.xl45
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #99CC00;
	border-bottom:none;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid #99CC00;}
.xl48
	{mso-style-parent:style0;
	color:#99CC00;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid #99CC00;
	border-left:.5pt solid #99CC00;}
.xl49
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid #99CC00;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #99CC00;
	border-bottom:.5pt solid #99CC00;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid #99CC00;
	border-left:.5pt solid #99CC00;}
.xl52
	{mso-style-parent:style0;
	color:white;
	font-size:19.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	text-align:right;
	vertical-align:middle;}
.xl54
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid #99CC00;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid #99CC00;
	border-right:.5pt solid #99CC00;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid #99CC00;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid #99CC00;
	border-bottom:.5pt solid #99CC00;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid #99CC00;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid #99CC00;
	border-bottom:.5pt solid #99CC00;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid #99CC00;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid #99CC00;
	border-right:.5pt solid #99CC00;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid #99CC00;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid #99CC00;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid #99CC00;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid #99CC00;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid #99CC00;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:13.0pt;
	mso-number-format:"\@";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid #99CC00;
	border-right:none;
	border-bottom:none;
	border-left:none;}
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
      <x:Scale>68</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
       <x:ActiveCol>18</x:ActiveCol>
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
 <o:shapedefaults v:ext="edit" spidmax="1047"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=984 style='border-collapse:
 collapse;table-layout:fixed;width:736pt'>
 <col class=xl24 width=9 style='mso-width-source:userset;mso-width-alt:329;
 width:7pt'>
 <col class=xl24 width=75 span=2 style='mso-width-source:userset;mso-width-alt:
 2742;width:56pt'>
 <col class=xl24 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl24 width=75 span=3 style='mso-width-source:userset;mso-width-alt:
 2742;width:56pt'>
 <col class=xl24 width=9 style='mso-width-source:userset;mso-width-alt:329;
 width:7pt'>
 <col class=xl24 width=27 style='mso-width-source:userset;mso-width-alt:987;
 width:20pt'>
 <col class=xl24 width=75 span=6 style='mso-width-source:userset;mso-width-alt:
 2742;width:56pt'>
 <col class=xl24 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <tr height=69 style='mso-height-source:userset;height:51.75pt'>
  <td colspan=16 height=69 width=984 style='height:51.75pt;width:736pt'
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
  </v:shapetype><v:shape id="_x0000_s1044" type="#_x0000_t75" style='position:absolute;
   margin-left:0;margin-top:0;width:737.25pt;height:51.75pt;z-index:16'>
   <v:imagedata src="SVB_files/image001.jpg" o:title="shinhan(1)"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:16;margin-left:0px;margin-top:0px;width:983px;
  height:69px'><img width=983 height=69 src="SVB_files/image015.jpg" v:shapes="_x0000_s1044"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=16 height=69 class=xl52 width=984 style='height:51.75pt;
    width:736pt'>DOMESTIC TRANSFER<font class="font7"><br>
        </font><font class="font8">Phiếu chuyển khoản trong nước</font></td>
   </tr>
  </table>
  </span></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=16 class=xl24 style='height:7.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:26.1pt'>
  <td height=34 colspan=5 class=xl24 style='height:26.1pt;mso-ignore:colspan'></td>
  <td class=xl25 colspan=6 style='mso-ignore:colspan'>Date<font class="font10">
  </font><font class="font11">(</font><font class="font12">Ngày</font><font
  class="font11">):</font><font class="font10"> …..<%=p_Date %>…./…..<%=p_Month %>…../….<%=p_Year %>….</font></td>
  <td colspan=5 class=xl53>Tax Code <font class="font12">(MST):</font><font
  class="font10"> <%=p_TaxCode %></font></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=16 class=xl24 style='height:7.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=53 style='mso-height-source:userset;height:39.95pt'>
  <td height=53 class=xl27 style='height:39.95pt'>&nbsp;</td>
  <td colspan=6 class=xl54 width=456 style='border-right:.5pt solid #99CC00;
  width:341pt'>Applicant (Account Name):<br>
    <font class="font12">Người yêu cầu (Tên tài khoản)</font></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=8 class=xl54 width=510 style='border-right:.5pt solid #99CC00;
  width:381pt'>Beneficiary (Receiver):<br>
    <font class="font12">Người thụ hưởng (Người nhận)<br>
    <br>
    </font></td>
 </tr>
 <tr height=50 style='mso-height-source:userset;height:37.5pt'>
  <td height=50 class=xl29 style='height:37.5pt'>&nbsp;</td>
  <td colspan=6 height=50 class=xl56 width=456 style='border-right:.5pt solid #99CC00;
  height:37.5pt;width:341pt'><!--[if gte vml 1]><v:line id="_x0000_s1027"
   style='position:absolute;z-index:3' from="2.25pt,15pt" to="331.5pt,15pt"
   strokecolor="#9c0 [50]" o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><v:line id="_x0000_s1045" style='position:absolute;z-index:17'
   from="1.5pt,31.5pt" to="330.75pt,31.5pt" strokecolor="#9c0 [50]"
   o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:3;margin-left:1px;margin-top:19px;width:442px;height:24px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=1></td>
    <td width=440></td>
    <td width=1></td>
   </tr>
   <tr>
    <td height=2></td>
    <td></td>
    <td colspan=2 align=left valign=top><img width=441 height=2
    src="SVB_files/image003.gif" v:shapes="_x0000_s1027"></td>
   </tr>
   <tr>
    <td height=20></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=2 align=left valign=top><img width=441 height=2
    src="SVB_files/image003.gif" v:shapes="_x0000_s1045"></td>
   </tr>
  </table>
  </span><![endif]><%=p_D_Acc_Nm %></td>
  <td class=xl30>&nbsp;</td>
  <td colspan=7 height=50 class=xl58 width=477 style='height:37.5pt;width:356pt'><!--[if gte vml 1]><v:line
   id="_x0000_s1029" style='position:absolute;z-index:5' from="2.25pt,16.5pt"
   to="372pt,16.5pt" strokecolor="#9c0 [50]" o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><v:line id="_x0000_s1046" style='position:absolute;z-index:18'
   from="3pt,32.25pt" to="372.75pt,32.25pt" strokecolor="#9c0 [50]"
   o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:5;margin-left:2px;margin-top:21px;width:496px;height:23px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=1></td>
    <td width=494></td>
    <td width=1></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=2 align=left valign=top><img width=495 height=2
    src="SVB_files/image004.gif" v:shapes="_x0000_s1029"></td>
   </tr>
   <tr>
    <td height=19></td>
   </tr>
   <tr>
    <td height=2></td>
    <td></td>
    <td colspan=2 align=left valign=top><img width=495 height=2
    src="SVB_files/image016.gif" v:shapes="_x0000_s1046"></td>
   </tr>
  </table>
  </span><![endif]><%=p_C_Acc_Nm %></td>
  <td class=xl31 width=33 style='width:25pt'>&nbsp;</td>
 </tr>
 <tr height=53 style='mso-height-source:userset;height:39.95pt'>
  <td height=53 class=xl32 style='height:39.95pt'>&nbsp;</td>
  <td colspan=6 class=xl54 width=456 style='border-right:.5pt solid #99CC00;
  width:341pt'>Applicant's A/C No.<br>
    <font class="font12">Số tài khoản<br>
    </font><font class="font10"><br>
    </font></td>
  <td class=xl33>&nbsp;</td>
  <td colspan=8 class=xl54 width=510 style='border-right:.5pt solid #99CC00;
  width:381pt'>Beneficiary's A/C No. / ID card or PP No.<br>
    <font class="font12">Số TK / CMND hoặc passport của<span
  style='mso-spacerun:yes'>  </span>người thụ hưởng<br>
    <br>
    </font><font class="font14"></font></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl29 style='height:21.95pt'>&nbsp;</td>
  <td colspan=6 height=29 class=xl58 width=456 style='border-right:.5pt solid #99CC00;
  height:21.95pt;width:341pt'><!--[if gte vml 1]><v:line id="_x0000_s1028"
   style='position:absolute;z-index:4' from="1.5pt,15.75pt" to="330.75pt,15.75pt"
   strokecolor="#9c0 [50]" o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:4;margin-left:1px;margin-top:20px;width:441px;height:2px'><img
  width=441 height=2 src="SVB_files/image003.gif" v:shapes="_x0000_s1028"></span><![endif]><%=p_D_Acc_No %></td>
  <td class=xl33>&nbsp;</td>
  <td colspan=7 height=29 class=xl58 width=477 style='height:21.95pt;
  width:356pt'><!--[if gte vml 1]><v:line id="_x0000_s1030" style='position:absolute;
   z-index:6' from="1.5pt,15.75pt" to="374.25pt,15.75pt" strokecolor="#9c0 [50]"
   o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:6;margin-left:1px;margin-top:20px;width:499px;height:2px'><img
  width=499 height=2 src="SVB_files/image005.gif" v:shapes="_x0000_s1030"></span><![endif]><%=p_C_Acc_No %></td>
  <td class=xl31 width=33 style='width:25pt'>&nbsp;</td>
 </tr>
 <tr height=53 style='mso-height-source:userset;height:39.95pt'>
  <td height=53 class=xl32 style='height:39.95pt'>&nbsp;</td>
  <td colspan=3 class=xl54 width=231 style='width:173pt'>Banking charge's at AC
  of:<br>
    <font class="font12">Phí ngân hàng tính vào TK của</font></td>
  <td colspan=3 height=53 class=xl54 width=225 style='border-right:.5pt solid #99CC00;
  height:39.95pt;width:168pt'><!--[if gte vml 1]><v:rect id="_x0000_s1025"
   style='position:absolute;margin-left:.75pt;margin-top:3pt;width:12pt;
   height:10.5pt;z-index:1' fillcolor="window [65]" strokecolor="#9c0 [50]"
   o:insetmode="auto"/><v:rect id="_x0000_s1026" style='position:absolute;
   margin-left:78.75pt;margin-top:3pt;width:12pt;height:10.5pt;z-index:2'
   fillcolor="window [65]" strokecolor="#9c0 [50]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:1;margin-left:0px;
  margin-top:3px;width:122px;height:16px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=18></td>
    <td width=86></td>
    <td width=18></td>
   </tr>
   <tr>
    <td height=16></td>
    <td align=left valign=top><img width=18 height=16
    src="SVB_files/image006.gif" v:shapes="_x0000_s1025"></td>
    <td></td>
    <td align=left valign=top><img width=18 height=16
    src="SVB_files/image006.gif" v:shapes="_x0000_s1026"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-spacerun:yes'>    </span>Applicant<span
  style='mso-spacerun:yes'>       </span>Beneficiary<span
  style='mso-spacerun:yes'>            </span><br>
    <span style='mso-spacerun:yes'> </span><font class="font12">Người
  chuyển<span style='mso-spacerun:yes'>     </span>Người nhận</font></td>
  <td class=xl34>&nbsp;</td>
  <td colspan=7 class=xl54 width=477 style='width:356pt'>Beneficiary's Bank and
  Branch Name<br>
    <font class="font12">Tên ngân hàng nhận và Chi nhánh<br>
    <br>
    </font></td>
  <td class=xl35 width=33 style='width:25pt'>&nbsp;</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl29 style='height:21.95pt'>&nbsp;</td>
  <td class=xl36 width=75 style='width:56pt'>&nbsp;</td>
  <td class=xl36 width=75 style='width:56pt'>&nbsp;</td>
  <td class=xl36 width=81 style='width:61pt'>&nbsp;</td>
  <td class=xl36 width=75 style='width:56pt'>&nbsp;</td>
  <td class=xl36 width=75 style='width:56pt'>&nbsp;</td>
  <td class=xl31 width=75 style='width:56pt'>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td colspan=7 height=29 class=xl58 width=477 style='height:21.95pt;
  width:356pt'><!--[if gte vml 1]><v:line id="_x0000_s1031" style='position:absolute;
   z-index:7' from="2.25pt,15.75pt" to="374.25pt,15.75pt" strokecolor="#9c0 [50]"
   o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:7;margin-left:2px;margin-top:20px;width:498px;height:2px'><img
  width=498 height=2 src="SVB_files/image007.gif" v:shapes="_x0000_s1031"></span><![endif]><%=p_C_Bank %></td>
  <td class=xl35 width=33 style='width:25pt'>&nbsp;</td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:33.0pt'>
  <td height=40 class=xl32 style='height:30.0pt'>&nbsp;</td>
  <td colspan=3 class=xl60 width=231 style='border-right:.5pt solid #99CC00;
  width:173pt'>Customer's Signature<br>
    <font class="font12">Chữ ký khách hàng</font></td>
  <td colspan=3 class=xl62 width=225 style='border-right:.5pt solid #99CC00;
  border-left:none;width:168pt'><span style='mso-spacerun:yes'>  </span>Company
  Seal :<br>
    <span style='mso-spacerun:yes'>  </span><font class="font12">Dấu của Công
  ty</font></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl39 colspan=4 style='mso-ignore:colspan'>Transfer Amount <font
  class="font12">(Số tiền):</font></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl32 style='height:21.0pt'>&nbsp;</td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl38 colspan=2 style='mso-ignore:colspan'>in Figures<font
  class="font12"> (Bằng số</font><span style='display:none'><font class="font12">):
  </font><font class="font14"><%=p_Amt %></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1032"
   style='position:absolute;z-index:8' from="4.5pt,15.75pt" to="240.75pt,15.75pt"
   strokecolor="#9c0 [50]" o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:8;margin-left:5px;margin-top:20px;width:317px;height:2px'><img
  width=317 height=2 src="SVB_files/image008.gif" v:shapes="_x0000_s1032"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=28 class=xl33 width=75 style='height:21.0pt;width:56pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
 </tr>
 <tr height=54 style='mso-height-source:userset;height:40.5pt'>
  <td height=54 class=xl32 style='height:40.5pt'>&nbsp;</td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td colspan=7 height=54 class=xl36 width=483 style='border-right:.5pt solid #99CC00;
  height:40.5pt;width:361pt'><!--[if gte vml 1]><v:line id="_x0000_s1033"
   style='position:absolute;z-index:9' from="116.25pt,15.75pt" to="353.25pt,15.75pt"
   strokecolor="#9c0 [50]" o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><v:line id="_x0000_s1034" style='position:absolute;z-index:10'
   from="2.25pt,34.5pt" to="354pt,34.5pt" strokecolor="#9c0 [50]" o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:9;margin-left:2px;margin-top:20px;width:471px;height:27px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=152></td>
    <td width=318></td>
    <td width=1></td>
   </tr>
   <tr>
    <td height=2></td>
    <td></td>
    <td align=left valign=top><img width=318 height=2
    src="SVB_files/image009.gif" v:shapes="_x0000_s1033"></td>
   </tr>
   <tr>
    <td height=23></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=3 align=left valign=top><img width=471 height=2
    src="SVB_files/image010.gif" v:shapes="_x0000_s1034"></td>
   </tr>
  </table>
  </span><![endif]>in Words <font class="font12">(Bằng chữ): </font><font
  class="font14"><%=Inword %></font></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl32 style='height:17.25pt'>&nbsp;</td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34 colspan=5 style='mso-ignore:colspan'>Details of payment <font
  class="font12">(Nội dung thanh toán):</font></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
 </tr>
 <tr height=51 style='mso-height-source:userset;height:38.25pt'>
  <td height=51 class=xl29 style='height:38.25pt'>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td colspan=7 height=51 class=xl58 width=477 style='height:38.25pt;
  width:356pt'><!--[if gte vml 1]><v:line id="_x0000_s1036" style='position:absolute;
   z-index:11' from="3pt,15.75pt" to="372.75pt,15.75pt" strokecolor="#9c0 [50]"
   o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><v:line id="_x0000_s1037" style='position:absolute;z-index:12'
   from="2.25pt,32.25pt" to="372.75pt,32.25pt" strokecolor="#9c0 [50]"
   o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:11;margin-left:2px;margin-top:20px;width:496px;height:24px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=1></td>
    <td width=495></td>
   </tr>
   <tr>
    <td height=2></td>
    <td></td>
    <td align=left valign=top><img width=495 height=2
    src="SVB_files/image004.gif" v:shapes="_x0000_s1036"></td>
   </tr>
   <tr>
    <td height=20></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=2 align=left valign=top><img width=496 height=2
    src="SVB_files/image011.gif" v:shapes="_x0000_s1037"></td>
   </tr>
  </table>
  </span><![endif]><%=p_Remark %></td>
  <td class=xl43 width=33 style='width:25pt'>&nbsp;</td>
 </tr>
 <tr height=48 style='mso-height-source:userset;height:36.0pt'>
  <td height=48 class=xl44 style='height:36.0pt'>&nbsp;</td>
  <td class=xl26 colspan=6 style='mso-ignore:colspan;border-right:.5pt solid #99CC00'>In
  case of transfer by cash<font class="font14"> </font><font class="font12">(Trường
  hợp nộp tiền mặt)</font></td>
  <td class=xl26></td>
  <td colspan=3 class=xl63 width=177 style='width:132pt'>Cashier:<br>
    <font class="font12">Thủ quỹ</font></td>
  <td class=xl26></td>
  <td colspan=2 class=xl64 width=150 style='width:112pt'><span
  style='mso-spacerun:yes'>  </span>Verified by:<br>
    <span style='mso-spacerun:yes'>  </span><font class="font12">Xác nhận bởi</font></td>
  <td class=xl46></td>
  <td class=xl45>&nbsp;</td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl44 style='height:24.0pt'>&nbsp;</td>
  <td class=xl26 colspan=2 style='mso-ignore:colspan'>Depositor name <font
  class="font12">(Họ</font><span style='display:none'><font class="font12"> và
  tên)</font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1038"
   style='position:absolute;z-index:13' from="39.75pt,15.75pt" to="220.5pt,15.75pt"
   strokecolor="#9c0 [50]" o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:13;margin-left:52px;margin-top:20px;width:243px;height:2px'><img
  width=243 height=2 src="SVB_files/image012.gif" v:shapes="_x0000_s1038"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=32 class=xl26 width=81 style='height:24.0pt;width:61pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl45>&nbsp;</td>
  <td colspan=5 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl47>&nbsp;</td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl45>&nbsp;</td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl44 style='height:24.0pt'>&nbsp;</td>
  <td class=xl26 colspan=2 style='mso-ignore:colspan'>ID / PP No. <font
  class="font12">(Số CM</font><span style='display:none'><font class="font12">ND
  / PP)</font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1039"
   style='position:absolute;z-index:14' from="42pt,15pt" to="219pt,15pt"
   strokecolor="#9c0 [50]" o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:14;margin-left:55px;margin-top:19px;width:238px;height:2px'><img
  width=238 height=2 src="SVB_files/image013.gif" v:shapes="_x0000_s1039"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=32 class=xl26 width=81 style='height:24.0pt;width:61pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl45>&nbsp;</td>
  <td colspan=5 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl47>&nbsp;</td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl45>&nbsp;</td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl48 style='height:24.0pt'>&nbsp;</td>
  <td class=xl49>Address <font class="font12">(</font><span style='display:
  none'><font class="font12">Địa chỉ)</font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1040"
   style='position:absolute;z-index:15' from="42.75pt,15.75pt" to="273.75pt,15.75pt"
   strokecolor="#9c0 [50]" o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:15;margin-left:56px;margin-top:20px;width:310px;height:2px'><img
  width=310 height=2 src="SVB_files/image014.gif" v:shapes="_x0000_s1040"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=32 class=xl49 width=75 style='height:24.0pt;width:56pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td class=xl49>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl26 colspan=9 style='height:21.75pt;mso-ignore:colspan'>Received
  by the bank at : ………… date……../ ……../ …………</td>
  <td colspan=5 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl65>03-2005</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=9 style='width:7pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=9 style='width:7pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=33 style='width:25pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
