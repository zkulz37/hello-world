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
    string p_D_Acc_No = "";
    string p_D_Acc_Nm = "";
    string p_D_Add = "";
    string p_D_Bank = "";
    string p_C_Acc_No = "";
    string p_C_Acc_Nm = "";
    string p_C_Add = "";
    string p_C_Bank = "";
    string p_Remark = "";
    int j;
    DataTable dt = ESysLib.TableReadOpenCursor("ac_sel_60050040_rpt", p_Seq);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is not data !!");
        Response.End();
    }
    else
    {
        p_Date = dt.Rows[0][10].ToString();
        p_D_Acc_No = dt.Rows[0][24].ToString();
        p_D_Acc_Nm = dt.Rows[0][12].ToString();
        p_D_Add = dt.Rows[0][25].ToString();
        p_D_Bank = dt.Rows[0][9].ToString();
        p_C_Acc_No = dt.Rows[0][0].ToString();
        p_C_Acc_Nm = dt.Rows[0][19].ToString();
        p_C_Add = dt.Rows[0][26].ToString();
        p_C_Bank = dt.Rows[0][1].ToString();
        p_Remark = dt.Rows[0][13].ToString();
    }

    string p_Amt = "";
    string p_Ccy = "";
    string Inword = "";
    DataTable dt_Amount = ESysLib.TableReadOpenCursor("ac_sel_60050040_1_rpt", p_Seq);
    if (dt_Amount.Rows.Count > 0)
    {
        p_Amt = dt_Amount.Rows[0][12].ToString();
        p_Ccy = dt_Amount.Rows[0][3].ToString();

        Inword = CommondLib.Num2VNText(dt_Amount.Rows[0][9].ToString(), p_Ccy);
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
<link rel=File-List
href="Lenh%20chuyen%20tien%20VCB%20-%203Lien_files/filelist.xml">
<link rel=Edit-Time-Data
href="Lenh%20chuyen%20tien%20VCB%20-%203Lien_files/editdata.mso">
<link rel=OLE-Object-Data
href="Lenh%20chuyen%20tien%20VCB%20-%203Lien_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Phan Thi Thanh Tuyen</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2011-09-30T03:43:48Z</o:LastPrinted>
  <o:Created>2011-09-29T07:20:21Z</o:Created>
  <o:LastSaved>2011-09-30T03:46:28Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .5in .5in .5in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;}
.font0
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font5
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font8
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
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
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl55
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
.xl61
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl62
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
.xl64
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Lenh chuyen tien - 3 to</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>87</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>33</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>52</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
        

         <x:PageBreaks>
     <x:RowBreaks>
       <%
int i_row_break =0;
int i;
for (i=0;i<3;i++)
{
		i_row_break = i_row_break +43;
%>
      <x:RowBreak>
       <x:Row><%= i_row_break%></x:Row>
      </x:RowBreak>
<%
}
%>
      
     </x:RowBreaks>
    </x:PageBreaks>



   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9345</x:WindowHeight>
  <x:WindowWidth>19020</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>

</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1032">
  <o:colormenu v:ext="edit" fillcolor="none"/>
 </o:shapedefaults></xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=755 style='border-collapse:
 collapse;table-layout:fixed;width:566pt'>
 <col class=xl24 width=15 style='mso-width-source:userset;mso-width-alt:548;
 width:11pt'>
 <col class=xl24 width=19 style='mso-width-source:userset;mso-width-alt:694;
 width:14pt'>
 <col class=xl24 width=34 style='mso-width-source:userset;mso-width-alt:1243;
 width:26pt'>
 <col class=xl24 width=64 span=3 style='width:48pt'>
 <col class=xl24 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=60 style='mso-width-source:userset;mso-width-alt:2194;
 width:45pt'>
 <col class=xl24 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=29 style='mso-width-source:userset;mso-width-alt:1060;
 width:22pt'>
 <col class=xl24 width=19 style='mso-width-source:userset;mso-width-alt:694;
 width:14pt'>
 <%
     for(j=0;j<3;j++)
     {%>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 width=15 style='height:15.0pt;width:11pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=34 style='width:26pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=71 style='width:53pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=44 style='width:33pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=60 style='width:45pt'></td>
  <td class=xl24 width=80 style='width:60pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=29 style='width:22pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
 </tr>
 <tr height=46 style='mso-height-source:userset;height:35.1pt'>
  <td height=46 class=xl24 style='height:35.1pt'></td>
  <td class=xl25>&nbsp;</td>
  <td colspan=3 height=46 class=xl26 width=162 style='mso-ignore:colspan-rowspan;
  height:35.1pt;width:122pt'><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
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
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:8.25pt;margin-top:9.75pt;width:85.5pt;height:9pt;z-index:1;
   visibility:visible;mso-wrap-edited:f' fillcolor="#0c9">
   <v:imagedata src="Lenh%20chuyen%20tien%20VCB%20-%203Lien_files/image004.emz"
    o:title="" chromakey="#3c3" gain="61604f"/>
   <x:ClientData ObjectType="Pict">
    <x:CF>Pict</x:CF>
   </x:ClientData>
  </v:shape><![if gte mso 9]><o:OLEObject Type="Embed" ProgID="Word.Picture.8"
   ShapeID="_x0000_s1025" DrawAspect="Content" ObjectID="MBD00230DC1">
  </o:OLEObject>
 <![endif]><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=11 height=13></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=114 height=12
    src="Lenh%20chuyen%20tien%20VCB%20-%203Lien_files/image002.gif" v:shapes="_x0000_s1025"></td>
    <td width=37></td>
   </tr>
   <tr>
    <td height=21></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:121.5pt;height:34.5pt'></span><![endif]--></td>
  <td colspan=9 class=xl59>LỆNH CHUYỂN TIỀN - APPLICATION FOR REMITTANCE</td>
  <td class=xl27>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=12 class=xl60>Ngày (Date) : <%=p_Date%></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl31>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl24 style='height:30.0pt'></td>
  <td class=xl35 colspan=9 style='mso-ignore:colspan'>Phương thức chuyển tiền<font
  class="font5"> (</font><font class="font9">Remittance Method</font><font
  class="font5">):<span style='mso-spacerun:yes'>  </span>Phát hàng hối phiếu (</font><font
  class="font9">Ban</font><span style='display:none'><font class="font9">k
  Draft</font><font class="font5">)</font></span></td>
  <td height=40 class=xl32 width=60 style='height:30.0pt;width:45pt'><!--[if gte vml 1]><v:rect
   id="_x0000_s1028" style='position:absolute;margin-left:29.25pt;margin-top:3pt;
   width:10.5pt;height:9.75pt;z-index:4' filled="f" fillcolor="#0cf [40]"
   strokecolor="windowText [64]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:left'><font class="font0"><br>
        </font></div>
   </v:textbox>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=38 height=3></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=16 height=15
    src="Lenh%20chuyen%20tien%20VCB%20-%203Lien_files/image003.gif"
    alt="Text Box: " v:shapes="_x0000_s1028"></td>
    <td width=6></td>
   </tr>
   <tr>
    <td height=22></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:45.0pt;height:30.0pt'></span><![endif]--></td>
  <td class=xl37><!--[if gte vml 1]><v:rect id="_x0000_s1026" style='position:absolute;
   margin-left:43.5pt;margin-top:2.25pt;width:10.5pt;height:9.75pt;z-index:2'
   filled="f" fillcolor="#0cf [40]" strokecolor="windowText [64]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:left'><font class="font0"><br>
        </font></div>
   </v:textbox>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:2;margin-left:57px;margin-top:2px;width:16px;height:15px'><img
  width=16 height=15
  src="Lenh%20chuyen%20tien%20VCB%20-%203Lien_files/image003.gif"
  alt="Text Box: " v:shapes="_x0000_s1026"></span><![endif]>SWIFFT</td>
  <td class=xl32>TELEX</td>
  <td height=40 class=xl32 width=29 style='height:30.0pt;width:22pt'><!--[if gte vml 1]><v:rect
   id="_x0000_s1027" style='position:absolute;margin-left:3.75pt;margin-top:3pt;
   width:10.5pt;height:9.75pt;z-index:3' filled="f" fillcolor="#0cf [40]"
   strokecolor="windowText [64]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:left'><font class="font0"><br>
        </font></div>
   </v:textbox>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=4 height=3></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=16 height=15
    src="Lenh%20chuyen%20tien%20VCB%20-%203Lien_files/image003.gif"
    alt="Text Box: " v:shapes="_x0000_s1027"></td>
    <td width=9></td>
   </tr>
   <tr>
    <td height=22></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:21.75pt;height:30.0pt'></span><![endif]--></td>
  <td class=xl33>&nbsp;</td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl38>32A</td>
  <td class=xl39 colspan=4 style='mso-ignore:colspan'>Ngày hiệu lực<font
  class="font5"> (</font><font class="font9">Effective Date</font><font
  class="font5">):<span style='mso-spacerun:yes'> </span></font></td>
  <td class=xl30>&nbsp;</td>
  <td class=xl28 colspan=4 style='mso-ignore:colspan'>Loại tiền (<font
  class="font9">Currency</font><font class="font5">), Số tiền (</font><font
  class="font9">Amount</font><font class="font5">)</font></td>
  <td class=xl24></td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl41><%=p_Ccy %></td>
  <td colspan=5 class=xl61 style='border-right:.5pt solid black' x:num><%=p_Amt %>
  </td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td height=39 class=xl24 style='height:29.25pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl35 colspan=4 style='mso-ignore:colspan'>Số tiền bằng chữ<font
  class="font5"> (A</font><font class="font9">mount in words</font><font
  class="font5">):<span style='mso-spacerun:yes'> </span></font></td>
  <td colspan=7 class=xl64 width=405 style='border-right:.5pt solid black;
  width:304pt'><%=Inword %></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.95pt'>
  <td height=13 class=xl24 style='height:9.95pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl34>Trong đó<span style='display:none'><font class="font5">:</font></span></td>
  <td height=20 class=xl24 width=64 style='height:15.0pt;width:48pt'><!--[if gte vml 1]><v:rect
   id="_x0000_s1029" style='position:absolute;margin-left:29.25pt;margin-top:3pt;
   width:10.5pt;height:9.75pt;z-index:5' filled="f" fillcolor="#0cf [40]"
   strokecolor="windowText [64]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:left'><font class="font0"><br>
        </font></div>
   </v:textbox>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=38 height=3></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=16 height=15
    src="Lenh%20chuyen%20tien%20VCB%20-%203Lien_files/image003.gif"
    alt="Text Box: " v:shapes="_x0000_s1029"></td>
    <td width=10></td>
   </tr>
   <tr>
    <td height=2></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:48.0pt;height:15.0pt'></span><![endif]--></td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan'>Từ TK số (<font
  class="font9">From A/C No</font><font class="font5">):</font></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl34 colspan=2 style='mso-ignore:colspan'>Số tiến<font class="font5">
  (</font><font class="font9">Amount</font><font class="font5">):</font></td>
  <td class=xl24></td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl24>(<font class="font9">Of Which</font><span style='display:none'><font
  class="font5">)</font></span></td>
  <td height=20 class=xl24 width=64 style='height:15.0pt;width:48pt'><!--[if gte vml 1]><v:rect
   id="_x0000_s1030" style='position:absolute;margin-left:29.25pt;margin-top:3pt;
   width:10.5pt;height:9.75pt;z-index:6' filled="f" fillcolor="#0cf [40]"
   strokecolor="windowText [64]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:left'><font class="font0"><br>
        </font></div>
   </v:textbox>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=38 height=3></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=16 height=15
    src="Lenh%20chuyen%20tien%20VCB%20-%203Lien_files/image003.gif"
    alt="Text Box: " v:shapes="_x0000_s1030"></td>
    <td width=10></td>
   </tr>
   <tr>
    <td height=2></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:48.0pt;height:15.0pt'></span><![endif]--></td>
  <td class=xl24 colspan=9 style='mso-ignore:colspan;border-right:.5pt solid black'>Tiền
  mặt (<font class="font9">Cash</font><font class="font5">):
  …………………………………………………………………………</font></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl24></td>
  <td height=20 class=xl24 width=64 style='height:15.0pt;width:48pt'><!--[if gte vml 1]><v:rect
   id="_x0000_s1031" style='position:absolute;margin-left:29.25pt;margin-top:3pt;
   width:10.5pt;height:9.75pt;z-index:7' filled="f" fillcolor="#0cf [40]"
   strokecolor="windowText [64]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:left'><font class="font0"><br>
        </font></div>
   </v:textbox>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=38 height=3></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=16 height=15
    src="Lenh%20chuyen%20tien%20VCB%20-%203Lien_files/image003.gif"
    alt="Text Box: " v:shapes="_x0000_s1031"></td>
    <td width=10></td>
   </tr>
   <tr>
    <td height=2></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:48.0pt;height:15.0pt'></span><![endif]--></td>
  <td class=xl24 colspan=9 style='mso-ignore:colspan;border-right:.5pt solid black'>NFTT
  (<font class="font9">Time BK Note</font><font class="font5">):
  …………………………………………………………………..</font></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl43>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl38 x:num>50</td>
  <td class=xl44 colspan=3 style='mso-ignore:colspan'>Người ra lệnh<font
  class="font5"> (</font><font class="font9">Applicant</font><font class="font5">):<span
  style='mso-spacerun:yes'> </span></font></td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl35 colspan=2 style='mso-ignore:colspan'>Địa chỉ<font class="font5">
  (</font><font class="font9">Address</font><font class="font5">):<span
  style='mso-spacerun:yes'> </span></font></td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl44 colspan=3 style='mso-ignore:colspan'>Số CMT/HC<font
  class="font5"> (</font><font class="font9">ID/PP No</font><font class="font5">):</font></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl44 colspan=3 style='mso-ignore:colspan'>Quốc tịch<font
  class="font5"> (</font><font class="font9">Nationality</font><font
  class="font5">):<span style='mso-spacerun:yes'> </span></font></td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl43>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl38>56A</td>
  <td class=xl44 colspan=4 style='mso-ignore:colspan'>NH Trung gian<font
  class="font5"> (</font><font class="font9">Intermediary Bank</font><font
  class="font5">):</font></td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl43>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl38 x:num>57</td>
  <td class=xl35 colspan=6 style='mso-ignore:colspan'>Ngân hàng người thụ hưởng<font
  class="font5"> (</font><font class="font9">Beneficiary</font><font
  class="font5">): <%=p_C_Bank %></font></td>
  <td class=xl32>&nbsp;</td>
  <td class=xl24></td>
  <td class=xl47>Swift code<font class="font5">:</font></td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl48 x:num>59</td>
  <td class=xl44 colspan=5 style='mso-ignore:colspan;border-right:.5pt solid black'>Người
  thụ hưởng<font class="font5"> (</font><font class="font9">Beneficiary</font><font
  class="font5">): </font></td>
  <td class=xl44 colspan=5 style='mso-ignore:colspan'>TK số <font class="font5">(</font><font
  class="font9">Acccount No</font><font class="font5">): <%=p_C_Acc_No%></font></td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl47 colspan=2 style='mso-ignore:colspan'>Tên<font class="font5"> (</font><font
  class="font9">Name</font><font class="font5">): <%=p_C_Acc_Nm %><span
  style='mso-spacerun:yes'> </span></font></td>
  <td class=xl49>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl43>&nbsp;</td>
  <td class=xl35 colspan=4 style='mso-ignore:colspan'>Địa chỉ<font class="font5">
  (</font><font class="font9">Address</font><font class="font5">):
  <%=p_C_Add %></font></td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl43 x:num>70</td>
  <td class=xl35 colspan=5 style='mso-ignore:colspan'>Nội dung<font
  class="font5"> (</font><font class="font9">Details</font><font class="font5">):
  <%=p_Remark %></font></td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl44 colspan=5 style='mso-ignore:colspan'>Phí ở VN do<font
  class="font5"> (</font><font class="font9">Charge in VN be borne by</font><font
  class="font5">)</font></td>
  <td class=xl24></td>
  <td class=xl50 colspan=3 style='mso-ignore:colspan'>Chúng tôi chịu (<font
  class="font9">Ourselves</font><font class="font5">)</font></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl50 colspan=4 style='mso-ignore:colspan;border-right:.5pt solid black'>Người
  thụ hưởng chịu (<font class="font9">Beneficiary</font><font class="font5">)</font></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl44 colspan=5 style='mso-ignore:colspan'>Phí ở NN do<font
  class="font5"> (</font><font class="font9">Charge outside VN be borne by</font><font
  class="font5">)</font></td>
  <td class=xl24></td>
  <td class=xl50 colspan=3 style='mso-ignore:colspan'>Chúng tôi chịu (<font
  class="font9">Ourselves</font><font class="font5">)</font></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl50 colspan=4 style='mso-ignore:colspan;border-right:.5pt solid black'>Người
  thụ hưởng chịu (<font class="font9">Beneficiary</font><font class="font5">)</font></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl54 colspan=11 style='mso-ignore:colspan'>Chúng tôi cam kết lệnh
  chuyển tiền này tuân thủ mọi qui định hiện hành về quản lý ngoại hối của nước
  công hòa xã hôi chủ nghĩa Việt Nam</td>
  <td class=xl24></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl54 colspan=11 style='mso-ignore:colspan'>We guarantee that this
  application is in strict compliance with the current regulations on foreign
  exchange control of S.R Vietnam</td>
  <td class=xl24></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=4 class=xl60>Kế toán trưởng ký</td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl60>Chủ tài khoản ký &amp; đóng dấu</td>
  <td class=xl24></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=4 class=xl60>Chief Accountant</td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl60>Account Holder &amp; Stamp</td>
  <td class=xl24></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl55>&nbsp;</td>
  <td class=xl56 colspan=8 style='mso-ignore:colspan'>DÀNH CHO NGÂN HÀNG ( FOR
  BANK USE ONLY)<font class="font8"> MÃ VAT:</font><font class="font5"><span
  style='mso-spacerun:yes'> </span></font></td>
  <td class=xl57>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl63 x:str="TT VIÊN ">TT VIÊN<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl24></td>
  <td colspan=3 class=xl63>KIỂM SOÁT</td>
  <td colspan=2 class=xl63>GIÁM ĐỐC</td>
  <td class=xl24></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl31>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=15 style='width:11pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=34 style='width:26pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=19 style='width:14pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
