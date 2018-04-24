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
        p_Date = dt.Rows[0][10].ToString();
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

        
        
        Inword = CommondLib.Num2EngText(dt_Amount.Rows[0][9].ToString(), p_Ccy);
        string SQL3 = " SELECT upper(substr(trim('" + Inword + "'),1,1)) || substr(lower(trim('" + Inword + "')),2, length(trim('" + Inword + "')))  from dual ";
        DataTable dt_t = ESysLib.TableReadOpen(SQL3);

        if (dt_t.Rows.Count > 0)
        {
            Inword = dt_t.Rows[0][0].ToString();
			Inword = Inword.Replace("dollars","US dollars");
        }
        
    }
	
	
	//p_Ccy = "USD";
	//p_Amt1 = "24556.12";
	
	p_D_Acc_No = p_D_Acc_No.Replace("-","");
	//Response.Write(p_Amt1);
    //    Response.End();
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="HSBC_files/filelist.xml">
<link rel=Edit-Time-Data href="HSBC_files/editdata.mso">
<link rel=OLE-Object-Data href="HSBC_files/oledata.mso">
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
  <o:LastPrinted>2012-06-18T07:24:38Z</o:LastPrinted>
  <o:Created>2012-06-11T08:59:30Z</o:Created>
  <o:LastSaved>2012-06-18T07:33:02Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .24in .5in .32in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
.font7
	{color:windowtext;
	font-size:12.0pt;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl28
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.font15
	{color:white;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}		
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
      <x:Scale>61</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>22</x:ActiveRow>
       <x:ActiveCol>20</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9780</x:WindowHeight>
  <x:WindowWidth>15315</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1096"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1126 style='border-collapse:
 collapse;table-layout:fixed;width:845pt'>
 <col class=xl24 width=64 span=17 style='width:48pt'>
 <col class=xl24 width=37 style='mso-width-source:userset;mso-width-alt:1353;
 width:28pt'>
 <col class=xl24 width=1 style='mso-width-source:userset;mso-width-alt:36;
 width:1pt'>
 <col class=xl24 width=16 style='mso-width-source:userset;mso-width-alt:585;
 width:12pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 width=64 style='height:12.75pt;width:48pt' align=left
  valign=top><!--[if gte vml 1]><v:line id="_x0000_s1036" style='position:absolute;
   z-index:1' from="411.75pt,108.75pt" to="411.75pt,126pt" strokecolor="#9cf [44]"
   o:insetmode="auto"/><v:line id="_x0000_s1040" style='position:absolute;
   z-index:2' from="514.5pt,109.5pt" to="514.5pt,126.75pt" strokecolor="#9cf [44]"
   o:insetmode="auto"/><v:line id="_x0000_s1041" style='position:absolute;
   z-index:3' from="376.5pt,116.25pt" to="376.5pt,126.75pt" strokecolor="#9cf [44]"
   o:insetmode="auto"/><v:line id="_x0000_s1042" style='position:absolute;
   z-index:4' from="395.25pt,116.25pt" to="395.25pt,126.75pt" strokecolor="#9cf [44]"
   o:insetmode="auto"/><v:line id="_x0000_s1043" style='position:absolute;
   z-index:5' from="429pt,116.25pt" to="429pt,126.75pt" strokecolor="#9cf [44]"
   o:insetmode="auto"/><v:line id="_x0000_s1044" style='position:absolute;
   z-index:6' from="447.75pt,116.25pt" to="447.75pt,126.75pt" strokecolor="#9cf [44]"
   o:insetmode="auto"/><v:line id="_x0000_s1045" style='position:absolute;
   z-index:7' from="465.75pt,116.25pt" to="465.75pt,126.75pt" strokecolor="#9cf [44]"
   o:insetmode="auto"/><v:line id="_x0000_s1046" style='position:absolute;
   z-index:8' from="481.5pt,116.25pt" to="481.5pt,126.75pt" strokecolor="#9cf [44]"
   o:insetmode="auto"/><v:line id="_x0000_s1047" style='position:absolute;
   z-index:9' from="498.75pt,116.25pt" to="498.75pt,126.75pt" strokecolor="#9cf [44]"
   o:insetmode="auto"/><v:line id="_x0000_s1048" style='position:absolute;
   z-index:10' from="531.75pt,116.25pt" to="531.75pt,126.75pt" strokecolor="#9cf [44]"
   o:insetmode="auto"/><v:line id="_x0000_s1049" style='position:absolute;
   z-index:11' from="549.75pt,116.25pt" to="549.75pt,126.75pt" strokecolor="#9cf [44]"
   o:insetmode="auto"/><v:line id="_x0000_s1051" style='position:absolute;
   z-index:12' from="621pt,94.5pt" to="621pt,142.5pt" strokecolor="#9cf [44]"
   o:insetmode="auto"/><v:line id="_x0000_s1062" style='position:absolute;
   z-index:14' from="784.5pt,95.25pt" to="784.5pt,141.75pt" strokecolor="#9cf [44]"
   o:insetmode="auto"/><v:line id="_x0000_s1063" style='position:absolute;
   z-index:15' from="637.5pt,118.5pt" to="637.5pt,143.25pt" strokecolor="#9cf [44]"
   o:insetmode="auto"/><v:line id="_x0000_s1064" style='position:absolute;
   z-index:16' from="654pt,127.5pt" to="654pt,143.25pt" strokecolor="#9cf [44]"
   o:insetmode="auto"/><v:line id="_x0000_s1066" style='position:absolute;
   z-index:17' from="670.5pt,126.75pt" to="670.5pt,142.5pt" strokecolor="#9cf [44]"
   o:insetmode="auto"/><v:line id="_x0000_s1067" style='position:absolute;
   z-index:18' from="704.25pt,126.75pt" to="704.25pt,142.5pt" strokecolor="#9cf [44]"
   o:insetmode="auto"/><v:line id="_x0000_s1068" style='position:absolute;
   z-index:19' from="720.75pt,126.75pt" to="720.75pt,142.5pt" strokecolor="#9cf [44]"
   o:insetmode="auto"/><v:line id="_x0000_s1069" style='position:absolute;
   z-index:20' from="752.25pt,126.75pt" to="752.25pt,142.5pt" strokecolor="#9cf [44]"
   o:insetmode="auto"/><v:line id="_x0000_s1070" style='position:absolute;
   z-index:21' from="801pt,126.75pt" to="801pt,142.5pt" strokecolor="#9cf [44]"
   o:insetmode="auto"/><v:line id="_x0000_s1071" style='position:absolute;
   z-index:22' from="687pt,118.5pt" to="687pt,143.25pt" strokecolor="#9cf [44]"
   o:insetmode="auto"/><v:line id="_x0000_s1073" style='position:absolute;
   z-index:23' from="735.75pt,117.75pt" to="735.75pt,142.5pt" strokecolor="#9cf [44]"
   o:insetmode="auto"/><v:line id="_x0000_s1074" style='position:absolute;
   z-index:24' from="768pt,126pt" to="768pt,141.75pt" strokecolor="#9cf [44]"
   o:insetmode="auto"/><v:shapetype id="_x0000_t75" coordsize="21600,21600"
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
  </v:shapetype><v:shape id="_x0000_s1077" type="#_x0000_t75" style='position:absolute;
   margin-left:822pt;margin-top:510.75pt;width:21pt;height:30pt;z-index:25'>
   <v:imagedata src="HSBC_files/image001.png" o:title="Ảnh chụp màn hình_2012-06-12_101747"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1078" type="#_x0000_t75" style='position:absolute;
   margin-left:0;margin-top:5.25pt;width:692.25pt;height:88.5pt;z-index:26'>
   <v:imagedata src="HSBC_files/image002.png" o:title="Ảnh chụp màn hình_2012-06-18_133853"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1079" type="#_x0000_t75" style='position:absolute;
   margin-left:692.25pt;margin-top:5.25pt;width:150.75pt;height:39.75pt;
   z-index:27'>
   <v:imagedata src="HSBC_files/image003.png" o:title="Ảnh chụp màn hình_2012-06-18_134225"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1080" type="#_x0000_t75" style='position:absolute;
   margin-left:690pt;margin-top:65.25pt;width:153pt;height:29.25pt;z-index:28'>
   <v:imagedata src="HSBC_files/image004.png" o:title="Ảnh chụp màn hình_2012-06-18_134336"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1081" type="#_x0000_t75" style='position:absolute;
   margin-left:822pt;margin-top:44.25pt;width:21pt;height:25.5pt;z-index:29'>
   <v:imagedata src="HSBC_files/image005.png" o:title="Ảnh chụp màn hình_2012-06-18_134437"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1082" type="#_x0000_t75" style='position:absolute;
   margin-left:12.75pt;margin-top:127.5pt;width:554.25pt;height:21pt;z-index:30'>
   <v:imagedata src="HSBC_files/image006.png" o:title="Ảnh chụp màn hình_2012-06-18_134729"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1083" type="#_x0000_t75" style='position:absolute;
   margin-left:336.75pt;margin-top:93pt;width:21pt;height:87.75pt;z-index:31'>
   <v:imagedata src="HSBC_files/image007.png" o:title="Ảnh chụp màn hình_2012-06-18_134922"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1084" type="#_x0000_t75" style='position:absolute;
   margin-left:567pt;margin-top:93pt;width:21pt;height:55.5pt;z-index:32'>
   <v:imagedata src="HSBC_files/image007.png" o:title="Ảnh chụp màn hình_2012-06-18_134922"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1085" type="#_x0000_t75" style='position:absolute;
   margin-left:567.75pt;margin-top:143.25pt;width:255.75pt;height:57.75pt;
   z-index:33'>
   <v:imagedata src="HSBC_files/image008.png" o:title="Ảnh chụp màn hình_2012-06-18_135338"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1086" type="#_x0000_t75" style='position:absolute;
   margin-left:822pt;margin-top:93pt;width:21pt;height:189pt;z-index:34'>
   <v:imagedata src="HSBC_files/image009.png" o:title="Ảnh chụp màn hình_2012-06-18_135617"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1089" type="#_x0000_t75" style='position:absolute;
   margin-left:0;margin-top:93pt;width:12.75pt;height:447.75pt;z-index:35'>
   <v:imagedata src="HSBC_files/image010.png" o:title="Ảnh chụp màn hình_2012-06-18_135822"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1090" type="#_x0000_t75" style='position:absolute;
   margin-left:12.75pt;margin-top:180.75pt;width:558pt;height:21pt;z-index:36'>
   <v:imagedata src="HSBC_files/image011.png" o:title="Ảnh chụp màn hình_2012-06-18_140129"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1091" type="#_x0000_t75" style='position:absolute;
   margin-left:12.75pt;margin-top:233.25pt;width:810.75pt;height:21pt;
   z-index:37'>
   <v:imagedata src="HSBC_files/image012.png" o:title="Ảnh chụp màn hình_2012-06-18_140416"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1092" type="#_x0000_t75" style='position:absolute;
   margin-left:12.75pt;margin-top:283.5pt;width:811.5pt;height:257.25pt;
   z-index:38'>
   <v:imagedata src="HSBC_files/image013.png" o:title="Ảnh chụp màn hình_2012-06-18_140849"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1093" type="#_x0000_t75" style='position:absolute;
   margin-left:822pt;margin-top:280.5pt;width:21pt;height:257.25pt;z-index:39'>
   <v:imagedata src="HSBC_files/image014.png" o:title="Ảnh chụp màn hình_2012-06-18_141113"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:7px;width:1124px;
  height:714px'><img width=1124 height=714 src="HSBC_files/image015.gif"
  v:shapes="_x0000_s1036 _x0000_s1040 _x0000_s1041 _x0000_s1042 _x0000_s1043 _x0000_s1044 _x0000_s1045 _x0000_s1046 _x0000_s1047 _x0000_s1048 _x0000_s1049 _x0000_s1051 _x0000_s1062 _x0000_s1063 _x0000_s1064 _x0000_s1066 _x0000_s1067 _x0000_s1068 _x0000_s1069 _x0000_s1070 _x0000_s1071 _x0000_s1073 _x0000_s1074 _x0000_s1077 _x0000_s1078 _x0000_s1079 _x0000_s1080 _x0000_s1081 _x0000_s1082 _x0000_s1083 _x0000_s1084 _x0000_s1085 _x0000_s1086 _x0000_s1089 _x0000_s1090 _x0000_s1091 _x0000_s1092 _x0000_s1093"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 class=xl24 width=64 style='height:12.75pt;width:48pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=37 style='width:28pt'></td>
  <td class=xl24 width=1 style='width:1pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=14 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 rowspan=2 class=xl25 ><%=p_Date%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=14 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=7 rowspan=3 height=51 class=xl26 style='height:38.25pt'><span
  style='mso-spacerun:yes'>       </span><%=p_C_Acc_Nm %></td>
  <td colspan=5 rowspan=3 class=xl27><span style='mso-spacerun:yes'>        
  </span><%if(p_D_Acc_No.Length >=12){%><%=p_D_Acc_No[p_D_Acc_No.Length - 12]%><%}%><span style='mso-spacerun:yes'>   </span><%if(p_D_Acc_No.Length >=11){%><%=p_D_Acc_No[p_D_Acc_No.Length - 11]%><%}%><span
  style='mso-spacerun:yes'>   </span><%if(p_D_Acc_No.Length >=10){%><%=p_D_Acc_No[p_D_Acc_No.Length - 10]%><%}%><span style='mso-spacerun:yes'>   
  </span><%if(p_D_Acc_No.Length >=9){%><%=p_D_Acc_No[p_D_Acc_No.Length - 9]%><%}%><span style='mso-spacerun:yes'>    </span><%if(p_D_Acc_No.Length >=8){%><%=p_D_Acc_No[p_D_Acc_No.Length - 8]%><%}%><span
  style='mso-spacerun:yes'>    </span><%if(p_D_Acc_No.Length >=7){%><%=p_D_Acc_No[p_D_Acc_No.Length - 7]%><%}%><span style='mso-spacerun:yes'>   
  </span><%if(p_D_Acc_No.Length >=6){%><%=p_D_Acc_No[p_D_Acc_No.Length - 6]%><%}%><span style='mso-spacerun:yes'>   </span><%if(p_D_Acc_No.Length >=5){%><%=p_D_Acc_No[p_D_Acc_No.Length - 5]%><%}%><span
  style='mso-spacerun:yes'>   </span>&nbsp;<%if(p_D_Acc_No.Length >=4){%><%=p_D_Acc_No[p_D_Acc_No.Length - 4]%><%}%><span style='mso-spacerun:yes'>  
  </span><%if(p_D_Acc_No.Length >=3){%>&nbsp;<%=p_D_Acc_No[p_D_Acc_No.Length - 3]%><%}%><span style='mso-spacerun:yes'>    </span><%if(p_D_Acc_No.Length >=2){%><%=p_D_Acc_No[p_D_Acc_No.Length - 2]%><%}%><span
  style='mso-spacerun:yes'>   </span>&nbsp;<%if(p_D_Acc_No.Length >=1){%><%=p_D_Acc_No[p_D_Acc_No.Length - 1]%><%}%></td>
  <td rowspan=4 class=xl28><span style='mso-spacerun:yes'>     </span><font
  class="font7"><%=p_Ccy%></font></td>
  <%if(p_Ccy=="VND"){ %>
  <td colspan=4 rowspan=4 class=xl27><%if(p_Amt1.Length >=11){%><%=p_Amt1[p_Amt1.Length - 11]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>   
  </span><%if(p_Amt1.Length >=10){%><%=p_Amt1[p_Amt1.Length - 10]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>    </span><span
  style='mso-spacerun:yes'>   </span><%if(p_Amt1.Length >=9){%><%=p_Amt1[p_Amt1.Length - 9]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>   
  </span><%if(p_Amt1.Length >=8){%><%=p_Amt1[p_Amt1.Length - 8]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>   </span><%if(p_Amt1.Length >=7){%><%=p_Amt1[p_Amt1.Length - 7]%><%}else{%><font class="font15">9</font><%}%><span
  style='mso-spacerun:yes'>    </span><%if(p_Amt1.Length >=6){%><%=p_Amt1[p_Amt1.Length - 6]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>  
  </span><%if(p_Amt1.Length >=5){%><%=p_Amt1[p_Amt1.Length - 5]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>    </span><%if(p_Amt1.Length >=4){%><%=p_Amt1[p_Amt1.Length - 4]%><%}else{%><font class="font15">9</font><%}%><span
  style='mso-spacerun:yes'>   </span><%if(p_Amt1.Length >=3){%><%=p_Amt1[p_Amt1.Length - 3]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>   
  </span><%if(p_Amt1.Length >=2){%><%=p_Amt1[p_Amt1.Length - 2]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>  </span><%if(p_Amt1.Length >=1){%><%=p_Amt1[p_Amt1.Length - 1]%><%}else{%><font class="font15">9</font><%}%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <%}else{%>
  <td colspan=4 rowspan=4 class=xl27><%if(p_Amt1.Length >=13){%><%=p_Amt1[p_Amt1.Length - 13]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>   
  </span><%if(p_Amt1.Length >=12){%><%=p_Amt1[p_Amt1.Length - 12]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>    </span><%if(p_Amt1.Length >=11){%><%=p_Amt1[p_Amt1.Length - 11]%><%}else{%><font class="font15">9</font><%}%><span
  style='mso-spacerun:yes'>   </span><%if(p_Amt1.Length >=10){%><%=p_Amt1[p_Amt1.Length - 10]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>   
  </span><%if(p_Amt1.Length >=9){%><%=p_Amt1[p_Amt1.Length - 9]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>   </span><%if(p_Amt1.Length >=8){%><%=p_Amt1[p_Amt1.Length - 8]%><%}else{%><font class="font15">9</font><%}%><span
  style='mso-spacerun:yes'>    </span><%if(p_Amt1.Length >=7){%><%=p_Amt1[p_Amt1.Length - 7]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>  
  </span><%if(p_Amt1.Length >=6){%><%=p_Amt1[p_Amt1.Length - 6]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>    </span><%if(p_Amt1.Length >=5){%><%=p_Amt1[p_Amt1.Length - 5]%><%}else{%><font class="font15">9</font><%}%><span
  style='mso-spacerun:yes'>   </span><%if(p_Amt1.Length >=4){%><%=p_Amt1[p_Amt1.Length - 4]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>   
  </span><font class="font15">9</font><span style='mso-spacerun:yes'>  </span>&nbsp;&nbsp;<font class="font15">9</font></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <%}%>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 colspan=2 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=12 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=7 rowspan=3 height=51 class=xl29 width=448 style='height:38.25pt;
  width:336pt'><span style='mso-spacerun:yes'>       
  </span></td>
  <td colspan=5 rowspan=3 class=xl26></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 colspan=7 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 colspan=7 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=17 rowspan=3 height=51 class=xl26 style='height:38.25pt'><span
  style='mso-spacerun:yes'>      
  </span><%=Inword%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=17 rowspan=3 height=51 class=xl26 style='height:38.25pt'><span
  style='mso-spacerun:yes'>       
  </span><%=p_Remark%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="_x0000_s1061" type="#_x0000_t75" style='position:absolute;margin-left:0;
   margin-top:0;width:844.5pt;height:571.5pt;z-index:13'>
   <v:imagedata src="HSBC_files/image016.png" o:title="Ảnh chụp màn hình_2012-06-12_111951"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1095" type="#_x0000_t75" style='position:absolute;
   margin-left:3pt;margin-top:4.5pt;width:837.75pt;height:562.5pt;z-index:40'>
   <v:imagedata src="HSBC_files/image017.png" o:title="Ảnh chụp màn hình_2012-06-18_142056"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:13;margin-left:0px;margin-top:0px;width:1126px;
  height:762px'><img width=1126 height=762 src="HSBC_files/image018.gif"
  v:shapes="_x0000_s1061 _x0000_s1095"></span><![endif]><span style='mso-ignore:
  vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 class=xl24 width=64 style='height:12.75pt;width:48pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=18 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
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
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=1 style='width:1pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
