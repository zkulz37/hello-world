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
    string p_Seq = Request["p_Seq"];
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
		
	p_D_Acc_No = p_D_Acc_No.Replace(".","");
	p_D_Acc_No = p_D_Acc_No.Replace("-","");
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
        p_Amt1 = dt_Amount.Rows[0][15].ToString();
        
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
<link rel=File-List href="gfbr00040_ShinhanBank_DRVV_files/filelist.xml">
<link rel=Edit-Time-Data href="gfbr00040_ShinhanBank_DRVV_files/editdata.mso">
<link rel=OLE-Object-Data href="gfbr00040_ShinhanBank_DRVV_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Se7ven</o:Author>
  <o:LastAuthor>Kenzie</o:LastAuthor>
  <o:LastPrinted>2013-10-02T07:55:43Z</o:LastPrinted>
  <o:Created>2013-09-28T07:03:21Z</o:Created>
  <o:LastSaved>2013-10-02T08:04:44Z</o:LastSaved>
  <o:Company>Viettel Corporation</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .5in 0in .5in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-horizontal-page-align:center;}
.font8
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font10
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font12
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font13
	{color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font14
	{color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font15
	{color:blue;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Arial, sans-serif;
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
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:justify;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:justify;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:left;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;}
.xl52
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl69
	{mso-style-parent:style16;
	color:blue;
	font-size:11.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl70
	{mso-style-parent:style16;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl71
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>92</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>18</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>18795</x:WindowWidth>
  <x:WindowTopX>-195</x:WindowTopX>
  <x:WindowTopY>285</x:WindowTopY>
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

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1033 style='border-collapse:
 collapse;table-layout:fixed;width:777pt'>
 <col class=xl25 width=49 style='mso-width-source:userset;mso-width-alt:1792;
 width:37pt'>
 <col class=xl25 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl25 width=105 style='mso-width-source:userset;mso-width-alt:3840;
 width:79pt'>
 <col class=xl25 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl25 width=37 style='mso-width-source:userset;mso-width-alt:1353;
 width:28pt'>
 <col class=xl25 width=19 style='mso-width-source:userset;mso-width-alt:694;
 width:14pt'>
 <col class=xl25 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl25 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 <col class=xl25 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl25 width=64 style='width:48pt'>
 <col class=xl25 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl25 width=4 style='mso-width-source:userset;mso-width-alt:146;
 width:3pt'>
 <col class=xl25 width=64 span=5 style='width:48pt'>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 width=49 style='height:12.0pt;width:37pt' align=left
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
  </v:shapetype><v:shape id="_x0000_s1026" type="#_x0000_t75" style='position:absolute;
   margin-left:0;margin-top:2.25pt;width:152.25pt;height:19.5pt;z-index:1'>
   <v:imagedata src="gfbr00040_ShinhanBank_DRVV_files/image001.jpg" o:title="w"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><v:line id="_x0000_s1027" style='position:absolute;z-index:2'
   from="0,22.5pt" to="531.75pt,22.5pt" strokecolor="windowText [64]"
   strokeweight=".5pt" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:1;margin-left:-1px;
  margin-top:3px;width:711px;height:28px'><img width=711 height=28
  src="gfbr00040_ShinhanBank_DRVV_files/image002.gif" v:shapes="_x0000_s1026 _x0000_s1027"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=16 class=xl25 width=49 style='height:12.0pt;width:37pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl25 width=70 style='width:53pt'></td>
  <td class=xl25 width=105 style='width:79pt'></td>
  <td class=xl25 width=89 style='width:67pt'></td>
  <td class=xl25 width=37 style='width:28pt'></td>
  <td class=xl25 width=19 style='width:14pt'></td>
  <td class=xl25 width=66 style='width:50pt'></td>
  <td class=xl25 width=85 style='width:64pt'></td>
  <td class=xl25 width=71 style='width:53pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=54 style='width:41pt'></td>
  <td class=xl25 width=4 style='width:3pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=10 class=xl25 style='height:10.5pt;mso-ignore:colspan'></td>
  <td class=xl52 colspan=2 style='mso-ignore:colspan'>Credit -27</td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 colspan=17 class=xl25 style='height:12.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=11 height=21 class=xl77 style='height:15.75pt'>DRAWDOWN
  APPLICATION AND CONTRACT OF ACKNOWLEDGEMENT OF DEBT</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=11 height=20 class=xl78 style='height:15.0pt'>ĐƠN RÚT VỐN VAY
  KIÊM KHẾ ƯỚC NHẬN NỢ</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 colspan=17 class=xl25 style='height:6.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl26 style='height:14.25pt'>Date<font class="font8">/ </font><span
  style='display:none'><font class="font8">Ngày</font><font class="font12">:</font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1028"
   style='position:absolute;z-index:3' from="26.25pt,12pt" to="139.5pt,12pt"
   strokecolor="windowText [64]" strokeweight=".5pt" o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:3;margin-left:34px;margin-top:15px;width:153px;height:2px'><img
  width=153 height=2 src="gfbr00040_ShinhanBank_DRVV_files/image003.gif" v:shapes="_x0000_s1028"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=19 class=xl25 width=70 style='height:14.25pt;width:53pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl25><%=p_Date%></td>
  <td colspan=14 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt' x:str="To: ">To:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=10 class=xl46>SHINHAN BANK VIETNAM – TRANSACTION CENTER</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 colspan=17 class=xl25 style='height:8.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl26 colspan=2 style='height:15.0pt;mso-ignore:colspan'>Borrower’s
  name:</td>
  <td colspan=9 height=20 width=590 style='height:15.0pt;width:444pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1029" style='position:absolute;
   z-index:4' from=".75pt,12.75pt" to="441.75pt,12.75pt" strokecolor="windowText [64]"
   strokeweight=".5pt" o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:4;margin-left:0px;margin-top:16px;width:590px;height:2px'><img
  width=590 height=2 src="gfbr00040_ShinhanBank_DRVV_files/image004.gif" v:shapes="_x0000_s1029"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=9 height=20 class=xl54 width=590 style='height:15.0pt;
    width:444pt'><%=p_D_Acc_Nm%></td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=2 height=19 class=xl27 style='height:14.25pt'>(Bên vay)</td>
  <td colspan=15 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 class=xl28 style='height:8.1pt'></td>
  <td colspan=16 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl26 colspan=11 style='height:15.0pt;mso-ignore:colspan'>I/We
  hereby request SHINHAN BANK VIENAM<font class="font13"> </font><font
  class="font12">to debit our account and credit to our demand account
  No.:<span style='mso-spacerun:yes'> </span></font></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 style='height:15.0pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1030" style='position:absolute;z-index:5' from="0,13.5pt" to="198.75pt,13.5pt"
   strokecolor="windowText [64]" strokeweight=".5pt" o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:5;margin-left:-1px;margin-top:17px;width:267px;height:2px'><img
  width=267 height=2 src="gfbr00040_ShinhanBank_DRVV_files/image005.gif" v:shapes="_x0000_s1030"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl29 width=49 style='height:15.0pt;width:37pt'><%=p_D_Acc_No%></td>
   </tr>
  </table>
  </span></td>
  <td colspan=16 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 colspan=11 style='height:14.25pt;mso-ignore:colspan'>(Chúng)
  Tôi yêu cầu Ngân hàng<span style='mso-spacerun:yes'>  </span>SHINHAN BANK
  VIETNAM<font class="font14"> </font><font class="font8">ghi nợ tài khoản vay
  và ghi có vào tài khoản<span style='mso-spacerun:yes'> </span></font></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 colspan=4 style='height:14.25pt;mso-ignore:colspan'>thanh
  toán của chúng tôi số:……………………</td>
  <td colspan=13 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 class=xl30 style='height:8.1pt'></td>
  <td colspan=16 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl26 colspan=2 style='height:15.0pt;mso-ignore:colspan'
  x:str="with the sum of (in figures) : ">with the sum of (i<span
  style='display:none'>n figures) :<span style='mso-spacerun:yes'> </span></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1031"
   style='position:absolute;z-index:6' from="49.5pt,12.75pt" to="441pt,12.75pt"
   strokecolor="windowText [64]" strokeweight=".5pt" o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:6;margin-left:65px;margin-top:16px;width:524px;height:2px'><img
  width=524 height=2 src="gfbr00040_ShinhanBank_DRVV_files/image006.gif" v:shapes="_x0000_s1031"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl26 width=105 style='height:15.0pt;width:79pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl29 colspan=2 style='mso-ignore:colspan'><%=p_Amt1%> <%=p_Ccy%></td>
  <td colspan=12 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=4 height=19 class=xl27 style='height:14.25pt'
  x:str="Số tiền (bằng số) ">Số tiền (bằng số)<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=13 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 colspan=17 class=xl25 style='height:8.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl26 style='height:14.25pt'>(in wor<span
  style='display:none'>ds): <font class="font15"><%=Inword%></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1032"
   style='position:absolute;z-index:7' from="18.75pt,12.75pt" to="495pt,12.75pt"
   strokecolor="windowText [64]" strokeweight=".5pt" o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:7;margin-left:24px;margin-top:16px;width:637px;height:2px'><img
  width=637 height=2 src="gfbr00040_ShinhanBank_DRVV_files/image007.gif" v:shapes="_x0000_s1032"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=19 class=xl26 width=70 style='height:14.25pt;width:53pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=9 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=2 height=19 class=xl27 style='height:14.25pt'>(bằng chữ)</td>
  <td class=xl27></td>
  <td colspan=14 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 colspan=17 class=xl25 style='height:8.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl26 colspan=2 style='height:14.25pt;mso-ignore:colspan'
  x:str="Under the Credit Contract No.: ">Under the Credit <span
  style='display:none'>Contract No.:<span style='mso-spacerun:yes'> </span></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1033"
   style='position:absolute;z-index:8' from="60.75pt,12.75pt" to="185.25pt,12.75pt"
   strokecolor="windowText [64]" strokeweight=".5pt" o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:8;margin-left:80px;margin-top:16px;width:168px;height:2px'><img
  width=168 height=2 src="gfbr00040_ShinhanBank_DRVV_files/image008.gif" v:shapes="_x0000_s1033"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=19 class=xl26 width=105 style='height:14.25pt;width:79pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl31><%=p_C_Acc_No%></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1034"
   style='position:absolute;z-index:9' from="33.75pt,12.75pt" to="254.25pt,12.75pt"
   strokecolor="windowText [64]" strokeweight=".5pt" o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:9;margin-left:44px;margin-top:16px;width:296px;height:2px'><img
  width=296 height=2 src="gfbr00040_ShinhanBank_DRVV_files/image009.gif" v:shapes="_x0000_s1034"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=19 class=xl26 width=66 style='height:14.25pt;width:50pt'>dated:</td>
   </tr>
  </table>
  </span></td>
  <td class=xl51 align=right ><%=p_Date%></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl27 colspan=3 style='height:14.25pt;mso-ignore:colspan'>Theo
  Hợp đồng Tín dụng số</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl28>ngày</td>
  <td colspan=10 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 colspan=17 class=xl25 style='height:8.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl31 colspan=2 style='height:14.25pt;mso-ignore:colspan'
  x:str="Loan drawdown No.: ">Loan drawdown N<span style='display:none'>o.:<span
  style='mso-spacerun:yes'> </span></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1035"
   style='position:absolute;z-index:10' from="15pt,12.75pt" to="185.25pt,12.75pt"
   strokecolor="windowText [64]" strokeweight=".5pt" o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:10;margin-left:19px;margin-top:16px;width:229px;height:2px'><img
  width=229 height=2 src="gfbr00040_ShinhanBank_DRVV_files/image010.gif" v:shapes="_x0000_s1035"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=19 class=xl31 width=105 style='height:14.25pt;width:79pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl31></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26>Loan dra<span style='display:none'>wdown date:</span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1036"
   style='position:absolute;z-index:11' from="57.75pt,12.75pt" to="205.5pt,12.75pt"
   strokecolor="windowText [64]" strokeweight=".5pt" o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:11;margin-left:76px;margin-top:16px;width:199px;height:2px'><img
  width=199 height=2 src="gfbr00040_ShinhanBank_DRVV_files/image011.gif" v:shapes="_x0000_s1036"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=19 class=xl26 width=85 style='height:14.25pt;width:64pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl51 align=right ></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl27 colspan=3 style='height:14.25pt;mso-ignore:colspan'>Lần
  rút vốn vay số</td>
  <td class=xl27></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'>Ngày rút vốn vay</td>
  <td colspan=9 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 colspan=17 class=xl25 style='height:8.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl31 style='height:14.25pt' x:str="Interest rate: ">Interest<span
  style='display:none'> rate:<span style='mso-spacerun:yes'> </span></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1037"
   style='position:absolute;flip:y;z-index:12' from="27.75pt,12.75pt" to="495pt,12.75pt"
   strokecolor="windowText [64]" strokeweight=".5pt" o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:12;margin-left:36px;margin-top:16px;width:625px;height:2px'><img
  width=625 height=2 src="gfbr00040_ShinhanBank_DRVV_files/image012.gif" v:shapes="_x0000_s1037"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=19 class=xl31 width=70 style='height:14.25pt;width:53pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=13 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl27 colspan=2 style='height:14.25pt;mso-ignore:colspan'>Lãi
  suất</td>
  <td colspan=15 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 colspan=17 class=xl25 style='height:8.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl31 style='height:14.25pt'>Term o<span style='display:
  none'>f loan:</span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1038"
   style='position:absolute;z-index:13' from="31.5pt,12pt" to="240pt,12pt"
   strokecolor="windowText [64]" strokeweight=".5pt" o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><v:line id="_x0000_s1040" style='position:absolute;z-index:14'
   from="284.25pt,12.75pt" to="493.5pt,12.75pt" strokecolor="windowText [64]"
   strokeweight=".5pt" o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:13;margin-left:41px;margin-top:15px;width:618px;height:3px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=280></td>
    <td width=57></td>
    <td width=281></td>
   </tr>
   <tr>
    <td height=1></td>
    <td rowspan=2 align=left valign=top><img width=280 height=2
    src="gfbr00040_ShinhanBank_DRVV_files/image013.gif" v:shapes="_x0000_s1038"></td>
   </tr>
   <tr>
    <td height=1></td>
    <td></td>
    <td rowspan=2 align=left valign=top><img width=281 height=2
    src="gfbr00040_ShinhanBank_DRVV_files/image014.gif" v:shapes="_x0000_s1040"></td>
   </tr>
   <tr>
    <td height=1></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=19 class=xl31 width=70 style='height:14.25pt;width:53pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl31></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl32>Maturity:</td>
  <td class=xl25><span style='mso-spacerun:yes'> </span></td>
  <td colspan=9 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl27 colspan=2 style='height:14.25pt;mso-ignore:colspan'>Thời
  hạn vay</td>
  <td class=xl27></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'>ngày đến hạn</td>
  <td colspan=9 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 colspan=17 class=xl25 style='height:8.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=4 height=20 width=313 style='height:15.0pt;width:236pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1041" style='position:absolute;
   flip:y;z-index:15' from="120pt,12.75pt" to="531pt,12.75pt" strokecolor="windowText [64]"
   strokeweight=".5pt" o:insetmode="auto">
   <v:stroke dashstyle="dash"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:15;margin-left:159px;margin-top:16px;width:550px;height:
  2px'><img width=550 height=2
  src="gfbr00040_ShinhanBank_DRVV_files/image015.gif" v:shapes="_x0000_s1041"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td  height=20 class=xl76 width=313 style='height:15.0pt;
    width:236pt'>Purpose of using loan: <font class="font12"><%=p_Remark%></font></td>
   </tr>
  </table>
  </span></td>
  <td colspan=13 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=4 height=19 class=xl27 style='height:14.25pt'>Mục đích sử dụng
  vốn vay</td>
  <td colspan=13 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=9 style='mso-height-source:userset;height:6.75pt'>
  <td height=9 colspan=17 class=xl25 style='height:6.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=39 style='height:29.25pt'>
  <td height=39 class=xl24 width=49 style='height:29.25pt;width:37pt'>No.<font
  class="font9"><br>
    </font><font class="font10">Số</font></td>
  <td colspan=3 class=xl65 width=264 style='border-left:none;width:199pt'>Beneficiary<font
  class="font10"><br>
    Người thụ hưởng</font></td>
  <td colspan=3 class=xl24 width=122 style='width:92pt'>Amount<font
  class="font9"><br>
    </font><font class="font10">Số tiền</font></td>
  <td colspan=4 class=xl24 width=274 style='border-left:none;width:206pt'>Content<font
  class="font9"><br>
    </font><font class="font10">Nội dung</font></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl33 style='height:28.5pt;border-top:none' x:num>1</td>
  <td colspan=3 class=xl67 width=264 style='border-left:none;width:199pt'><%=p_C_Acc_Nm%></td>
  <td colspan=3 class=xl69 x:num><span
  style='mso-spacerun:yes'> </span><%=p_Amt1%></td>
  <td colspan=4 class=xl73 width=274 style='border-right:.5pt solid black;
  border-left:none;width:206pt'><%=p_Remark%></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl33 style='height:28.5pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl65 width=264 style='border-left:none;width:199pt'>Total<font
  class="font9"><br>
    </font><font class="font8">Tổng cộng</font></td>
  <td colspan=3 class=xl70 x:num><span
  style='mso-spacerun:yes'> </span><%=p_Amt%></td>
  <td colspan=4 class=xl33 style='border-left:none'>&nbsp;</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=11 height=20 class=xl71 width=709 style='height:15.0pt;
  width:534pt'
  x:str="I/ We hereby undertake to use the loan in accordance with the purpose clearly indicated in our/my Application ">I/
  We hereby undertake to use the loan in accordance with the purpose clearly
  indicated in our/my Application<span style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=11 height=20 class=xl71 width=709 style='height:15.0pt;
  width:534pt'>for Loan and to observe strictly all terms and conditions of the
  credit agreement</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=11 height=20 class=xl72 width=709 style='height:15.0pt;
  width:534pt'
  x:str="(Chúng) Tôi cam kết sử dụng vốn vay đúng mục đích đã được ghi rõ trong Đơn rút vốn vay kiêm khế ước ">(Chúng)
  Tôi cam kết sử dụng vốn vay đúng mục đích đã được ghi rõ trong Đơn rút vốn
  vay kiêm khế ước<span style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=11 height=20 class=xl27 style='height:15.0pt'>nhận nợ này và tuân
  thủ chặt chẽ mọi điều khoản, điều kiện của Hợp đồng tín dụng nói trên.</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=17 class=xl25 style='height:7.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=8 class=xl25 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl47>THE BORROWER</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=8 class=xl25 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=3 height=19 width=189 style='height:14.25pt;width:142pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1042" style='position:absolute;
   z-index:16' from="48.75pt,12.75pt" to="90pt,12.75pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:16;margin-left:64px;
  margin-top:16px;width:57px;height:2px'><img width=57 height=2
  src="gfbr00040_ShinhanBank_DRVV_files/image016.gif" v:shapes="_x0000_s1042"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=3 height=19 class=xl48 width=189 style='height:14.25pt;
    width:142pt'>Bên vay</td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=5 height=17 class=xl55 style='border-right:.5pt solid black;
  height:12.75pt'>For Bank internal check</td>
  <td colspan=12 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=5 height=19 class=xl58 style='border-right:.5pt solid black;
  height:14.25pt'>Phần dành riêng cho ngân hàng</td>
  <td colspan=12 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl61 width=119 style='border-right:.5pt solid black;
  height:12.75pt;width:90pt'>Prepared by</td>
  <td class=xl34 width=105 style='border-top:none;border-left:none;width:79pt'>Checked
  by</td>
  <td colspan=2 class=xl61 width=126 style='border-right:.5pt solid black;
  border-left:none;width:95pt'>Approved by</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl63 width=119 style='border-right:.5pt solid black;
  height:15.0pt;width:90pt'>Chuẩn bị</td>
  <td class=xl44 width=105 style='border-left:none;width:79pt'>Kiểm tra</td>
  <td colspan=2 class=xl63 width=126 style='border-right:.5pt solid black;
  border-left:none;width:95pt'>Phê duyệt</td>
  <td class=xl25></td>
  <td colspan=2 class=xl45 width=151 style='width:114pt'>Signature &amp; Seal</td>
  <td colspan=3 class=xl45 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=5 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl37 style='height:15.0pt'>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl25></td>
  <td colspan=2 class=xl49 width=151 style='width:114pt'>Chữ ký &amp; con dấu</td>
  <td class=xl49 width=71 style='width:53pt'>&nbsp;</td>
  <td class=xl49 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl49 width=54 style='width:41pt'>&nbsp;</td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt'>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl25></td>
  <td colspan=2 class=xl45 width=151 style='width:114pt'>Full Name</td>
  <td colspan=3 class=xl45 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt'>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl49 width=66 style='width:50pt'>Họ tên</td>
  <td class=xl49 width=85 style='width:64pt'>&nbsp;</td>
  <td class=xl49 width=71 style='width:53pt'>&nbsp;</td>
  <td class=xl49 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl49 width=54 style='width:41pt'>&nbsp;</td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt'>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl35 width=66 style='width:50pt'>Title</td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl39 style='height:14.25pt'>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl41></td>
  <td class=xl50 width=66 style='width:50pt'>Chức vụ</td>
  <td class=xl43>&nbsp;</td>
  <td class=xl43>&nbsp;</td>
  <td class=xl43>&nbsp;</td>
  <td class=xl43>&nbsp;</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl42 style='height:15.0pt'>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td colspan=12 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=49 style='width:37pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=4 style='width:3pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
